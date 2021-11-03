extends Node

#Sets the headings for the data 
var saveData = {
	"Max_Health" : 1,
	"Max_Stamina" : 1,
	"attack_power" : 1,
	"stat_points" : 1,
	"xp" : 1,
	"gold": 1,
	"Last_Checkpoint_x": null,
	"Last_Checkpoint_y": null,
	"Last_Level": null
}

var saveGameFileName = "user://playerData.txt"

#edits the data
func edit_data():
	saveData.Max_Health = PlayerStats.Max_Health
	saveData.Max_Stamina = PlayerStats.Max_Stamina
	saveData.attack_power = PlayerStats.attack_power
	saveData.stat_points = PlayerStats.stat_points
	saveData.xp = PlayerStats.xp
	saveData.gold = PlayerStats.gold
	
	saveData.Last_Checkpoint_x = Checkpoint.last_position.x
	saveData.Last_Checkpoint_y = Checkpoint.last_position.y
	
	saveData.Last_Level = Checkpoint.last_level

#saves the data
func save_data():
	self.edit_data()
	
	var saveFile = File.new()
	saveFile.open(saveGameFileName, File.WRITE)


	saveFile.store_line(to_json(saveData))
	saveFile.close()

#loads the data
func load_data():
	var dataFile = File.new()
	

	if not dataFile.file_exists(saveGameFileName): #if their isn't data in file or the file doesn't exist it returns
		print("error")
		return

	dataFile.open(saveGameFileName, File.READ)
	
	while dataFile.get_position() < dataFile.get_len():
		var nodeData = parse_json(dataFile.get_line())
		
		saveData.Max_Health = nodeData["Max_Health"]
		saveData.Max_Stamina = nodeData["Max_Stamina"]
		saveData.attack_power = nodeData["attack_power"]
		saveData.stat_points = nodeData["stat_points"]
		saveData.xp = nodeData["xp"]
		saveData.gold = nodeData["gold"]
		saveData.lamp = nodeData["lamp"]
		
		saveData.Last_Checkpoint_x = nodeData["Last_Checkpoint_x"]
		saveData.Last_Checkpoint_y = nodeData["Last_Checkpoint_y"]
		
		saveData.Last_Level = nodeData["Last_Level"]
		
		PlayerStats.Max_Health = saveData.Max_Health
		PlayerStats.Max_Stamina = saveData.Max_Stamina
		PlayerStats.attack_power = saveData.attack_power
		PlayerStats.stat_points = saveData.stat_points
		PlayerStats.xp = saveData.xp
		PlayerStats.gold = saveData.gold
		PlayerStats.lamp = saveData.lamp
		
		Checkpoint.last_level = saveData.Last_Level
		
		var x = saveData.Last_Checkpoint_x
		var y = saveData.Last_Checkpoint_y
		
		Checkpoint.last_position  = Vector2(x, y)
		
		

		
	dataFile.close()
