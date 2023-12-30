extends FileType

	var filenames: Array
	var fileData: Array
	var data: String
	var name: String
	var secondCreatedAt: int
	var size: int

	func _init():
		var index = rand_range(0, filenames.size() - 1)
		name = filenames[index]
		data = fileData[index]
		size = data.length() * 8
		secondCreatedAt = int(OS.get_ticks_msec() / 1000)

	func _init(dataEntry: String, nameEntry: String):
		nameEntry = nameEntry.replace(" ", "_")
		name = nameEntry
		data = dataEntry
		size = data.length() * 8
		secondCreatedAt = int(OS.get_ticks_msec() / 1000)

	func getName() -> String:
		return name

	func head() -> String:
		var index = 0
		var str = ""
		while index < data.length() and data[index] != 10 and index < 50:
			str += str(data[index])
			index += 1
		return str

	static func init(content: ContentManager) -> void:
		filenames = []
		fileData = []
		var files = Directory.new().open(content.get_root_directory() + "/files").list_dir_begin()
		while true:
			var file = files.get_next()
			if file == "":
				break
			filenames.append(file.get_basename().get_basename_without_extension())
			var streamReader = File.new()
			streamReader.open("res://Content/files/" + file.get_basename())
			fileData.append(streamReader.get_as_text())
			streamReader.close()

		var bashLogs = File.new()
		bashLogs.open("res://Content/BashLogs.txt")
		var strArray = bashLogs.get_as_text().split("\n#")
		bashLogs.close()

		for str in strArray:
			str = str.trim()
			var length = str.length()
			var index = str.find("\r\n")
			filenames.append("IRC_Log:" + str.substr(0, index).replace("- [X]", "").replace(" ", ""))
			fileData.append(purifyStringForDisplay(str.substr(index).replace("\n ", "\n")) + "\n\nArchived Via : http://Bash.org")
	# END: ed8c6549bwf9
	}
}
