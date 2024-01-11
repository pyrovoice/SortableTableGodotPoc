extends Control

@onready var grid_container = $MarginContainer/GridContainer
const inputData = ["String 1", "String 2", "String 3", "String 4", "String 5", "String 6"]
const skillLine = preload("res://SkillLine.tscn")
var draggedComponent = null

func _ready():
	for child in grid_container.get_children():
		child.queue_free()
	for input in inputData:
		var newLine = skillLine.instantiate()
		grid_container.add_child(newLine)
		newLine.init(input)
		newLine.buttonAction.connect(func(b):onLineButtonPressed(newLine, b))
		newLine.mouseAction.connect(func(entered): onMouseEnterElement(newLine, entered))
		newLine.name = "Line " + str(newLine.get_index())

func onLineButtonPressed(child, isPressed: bool):
	if isPressed:
		draggedComponent = child
	else:
		draggedComponent = null

func onMouseEnterElement(enteredElement, isMouseEnter: bool):
	if draggedComponent && isMouseEnter:
		grid_container.move_child(draggedComponent, enteredElement.get_index())

func _input(event):
	if event is InputEventMouseMotion && draggedComponent:
		draggedComponent.position.y += (event as InputEventMouseMotion).relative.y
