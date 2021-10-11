extends Node
var contrunthrough = 0
var controllers = []
var winner = ""
var char_paths = {}
var arena_path = ""
var music_path = ""
var current_controller = 0
var colors = [ "Green", "Red", "Blue", "Aqua", "Yellow","Orange", "Pink", "Purple"]
var alive_players = []

#in code, char paths is structured: key:controllerid[ 0 the scene, 1 the id, 2 the color, and 3 the life]
