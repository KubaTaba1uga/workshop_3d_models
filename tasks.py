# TO-DO create task for downloading libs
###############################################
#                Imports                      #
###############################################
import os
import subprocess

from invoke import task

###############################################
#                Public API                   #
###############################################
ROOT_PATH = os.path.dirname(os.path.abspath(__file__))
SRC_PATH = os.path.join(ROOT_PATH, "src")
BUILD_PATH = os.path.join(ROOT_PATH, "build")
SHARED_PATH = os.path.join(ROOT_PATH, "libs")
CC = "openscad"


@task
def clean(c, bytecode=False, extra=""):
    """
    Clean up build and temporary files.

    This task removes the specified patterns of files and directories,
    including build artifacts, temporary files, and optionally Python
    bytecode files.

    Args:
        bytecode (bool, optional): If True, also removes Python bytecode files (.pyc). Defaults to False.
        extra (str, optional): Additional pattern to remove. Defaults to "".

    Usage:
        inv clean
        inv clean --bytecode
        inv clean --extra='**/*.log'
    """
    patterns = ["build", "**/*~", "**/#*", "*~", "#*", "**/*.stl"]

    if bytecode:
        patterns.append("**/*.pyc")
    if extra:
        patterns.append(extra)

    for pattern in patterns:
        _pr_info("Removing pattern {}".format(pattern))
        c.run("rm -vrf {}".format(pattern))


@task
def build(c, files_to_build: list = []):
    """
    Build STL files from OpenSCAD source files.

    This task finds all OpenSCAD files in the source directory,
    and generates corresponding STL files in the build directory.
    If a list of specific files is provided, only those files will be built.

    Args:
        files_to_build (list, optional): List of specific OpenSCAD files to build. Defaults to [].

    Usage:
        inv build
        inv build --files-to-build=example1.scad,example2.scad
    """
    _write_libs_path_to_envs()

    if not _command_exists(CC):
        _pr_error(f"{CC} need to be installed!")
        exit(-1)

    scad_files = _list_scad_files_recursively(SRC_PATH)

    os.makedirs(BUILD_PATH, exist_ok=True)

    for file_path in scad_files:
        if files_to_build and (
            not any((file_to_build in file_path) for file_to_build in files_to_build)
        ):
            continue

        _pr_info("Generating .stl file for {}".format(os.path.basename(file_path)))

        command = "{} -o {} {}".format(CC, _generate_build_name(file_path), file_path)

        c.run(command)

        print()


@task
def open(c, file_path: str=None):
    """
    Open an OpenSCAD file in OpenSCAD.

    This task opens a specified OpenSCAD file using the OpenSCAD application.

    Args:
        file_path (str): The path to the OpenSCAD file to open.

    Usage:
        inv open-file --file-path=example.scad
    """
    _write_libs_path_to_envs()

    if not os.path.isfile(file_path):
        _pr_error(f"File {file_path} does not exist!")
        return

    if _get_file_extension(file_path) != _SCAD_EXTENSION:
        _pr_error(f"File {file_path} is not an OpenSCAD file!")
        return

    if not _command_exists(CC):
        _pr_error(f"{CC} needs to be installed!")
        return

    _pr_info(f"Opening {file_path} in OpenSCAD")

    command = f"{CC} {file_path}"
    c.run(command)


###############################################
#                Private API                   #
###############################################
_SCAD_EXTENSION = ".scad"


def _list_scad_files_recursively(root_dir):
    files = []

    for dirpath, dirnames, filenames in os.walk(root_dir):
        for filename in filenames:
            if _SCAD_EXTENSION == _get_file_extension(filename):
                files.append(os.path.join(dirpath, filename))

    return files


def _get_file_extension(file_path):
    _, file_extension = os.path.splitext(file_path)
    return file_extension


def _command_exists(command):
    try:
        # Attempt to run the command with '--version' or any other flag that doesn't change system state
        subprocess.run(
            [command, "--version"], stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        return True
    except FileNotFoundError:
        return False
    except subprocess.CalledProcessError:
        # The command exists but returned an error
        return True
    except Exception:
        # Catch any other exceptions
        return False


def _generate_build_name(scad_file_path):
    cut_path = scad_file_path.replace(_cut_path_to_directory(scad_file_path, "src"), "")

    return os.path.join(
        BUILD_PATH, ("_".join(cut_path.split("/"))[1:]).replace(_SCAD_EXTENSION, ".stl")
    )


def _cut_path_to_directory(full_path, target_directory):
    """
    Cuts the path up to the specified target directory.

    :param full_path: The full path to be cut.
    :param target_directory: The directory up to which the path should be cut.
    :return: The cut path if the target directory is found, otherwise raises ValueError.
    """
    parts = full_path.split(os.sep)

    target_index = parts.index(target_directory)
    return os.sep.join(parts[: target_index + 1])


def _pr_info(message: str):
    """
    Print an informational message in blue color.

    Args:
        message (str): The message to print.

    Usage:
        pr_info("This is an info message.")
    """
    print(f"\033[94m[INFO] {message}\033[0m")


def _pr_warn(message: str):
    """
    Print a warning message in yellow color.

    Args:
        message (str): The message to print.

    Usage:
        pr_warn("This is a warning message.")
    """
    print(f"\033[93m[WARN] {message}\033[0m")


def _pr_debug(message: str):
    """
    Print a debug message in cyan color.

    Args:
        message (str): The message to print.

    Usage:
        pr_debug("This is a debug message.")
    """
    print(f"\033[96m[DEBUG] {message}\033[0m")


def _pr_error(message: str):
    """
    Print an error message in red color.

    Args:
        message (str): The message to print.

    Usage:
        pr_error("This is an error message.")
    """
    print(f"\033[91m[ERROR] {message}\033[0m")


###############################################
#                Internals                    #
###############################################
def _add_directory_to_path(directory):
    """
    Add the specified directory to the PATH environment variable.

    Args:
        directory (str): The directory to add to PATH.

    Usage:
        add_directory_to_path("/path/to/directory")
    """
    current_path = os.environ.get("PATH", "")

    if directory not in current_path.split(os.pathsep):
        os.environ["PATH"] = directory + os.pathsep + current_path


def _write_libs_path_to_envs():
    os.environ["OPENSCADPATH"] = SHARED_PATH


_add_directory_to_path(SHARED_PATH)
