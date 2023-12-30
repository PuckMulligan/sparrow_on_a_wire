extends Node


class_name UserDetail
var user : String
var password : String
var type : int
var known : bool = false

func _init(user = "", password = "", account_type = 1):
	self.name = user
	self.pass = password
	self.type = account_type
