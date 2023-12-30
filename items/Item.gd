extends Resource
class_name Item

export (String) var item_name := "Item Name"
export (Types.ItemTypes) var item_type := Types.ItemTypes.KEY

func init (_item_name: String, _item_type: int):
	self.item_name = _item_name
	self.item_type = _item_type
	
