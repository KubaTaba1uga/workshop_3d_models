function get_pcb_board_holes_coordinates(pcb_x, pcb_y, hole_from_x, hole_from_y, hole_r) = [[(hole_from_x + hole_r), (hole_from_y + hole_r), 0],
											   [(hole_from_x + hole_r), pcb_y - (hole_from_y + hole_r), 0],
											   [pcb_x - (hole_from_x + hole_r), (hole_from_y + hole_r), 0],
											   [pcb_x - (hole_from_x + hole_r), pcb_y - (hole_from_y + hole_r), 0]];
