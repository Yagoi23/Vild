extends Node

#random bullshit go!
var saveData = {
	"Max_Health" : 1,
	"Max_Stamina" : 1,
	"Last_Checkpoint_x": null,
	"Last_Checkpoint_y": null,
	"Last_Level": null
}

var saveGameFileName = "user://playerData.txt"

func edit_data():
	saveData.Max_Health = PlayerStats.Max_Health
	saveData.Max_Stamina = PlayerStats.Max_Stamina
	
	saveData.Last_Checkpoint_x = Checkpoint.last_position.x
	saveData.Last_Checkpoint_y = Checkpoint.last_position.y
	
	saveData.Last_Level = Checkpoint.last_level

func save_data():
	self.edit_data()
	
	var saveFile = File.new()
	saveFile.open(saveGameFileName, File.WRITE)


	saveFile.store_line(to_json(saveData))
	saveFile.close()

func load_data():
	var dataFile = File.new()
	

	if not dataFile.file_exists(saveGameFileName):
		print("error")
		return

	dataFile.open(saveGameFileName, File.READ)
	
	while dataFile.get_position() < dataFile.get_len():
		var nodeData = parse_json(dataFile.get_line())
		
		saveData.Max_Health = nodeData["Max_Health"]
		saveData.Max_Stamina = nodeData["Max_Stamina"]
		
		saveData.Last_Checkpoint_x = nodeData["Last_Checkpoint_x"]
		saveData.Last_Checkpoint_y = nodeData["Last_Checkpoint_y"]
		
		saveData.Last_Level = nodeData["Last_Level"]
		
		PlayerStats.Max_Health = saveData.Max_Health
		PlayerStats.Max_Stamina = saveData.Max_Stamina
		
		Checkpoint.last_level = saveData.Last_Level
		
		var x = saveData.Last_Checkpoint_x
		var y = saveData.Last_Checkpoint_y
		
		Checkpoint.last_position  = Vector2(x, y)
		
		

		
	dataFile.close()
