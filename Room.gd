extends PanelContainer
class_name _Room


export (String) var room_name = "Room Name"
export (String) var room_description = "This is a description of the room."
export (Dictionary) var exits = {"east": self, "west": self, "north": self, "south": self}

func connect_exit(direction: String, room: _Room, override_direction: bool = false):
	match direction:
		"west":
			exits[direction] = room
			room.exits["east"] = self
		"east":
			exits[direction] = room
			room.exits["west"] = self
		"south":
			exits[direction] = room
			room.exits["north"] = self
		"north":
			exits[direction] = room
			room.exits["south"] = self
