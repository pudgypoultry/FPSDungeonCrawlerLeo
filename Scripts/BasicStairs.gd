extends StaticBody3D

class_name BasicStairs

@export_category("Physical Properties")
@export var isObstructing : bool = false
@export var heightOffset : float = 0.5
@export var height : int = 0
@export var highDirection : GlobalEnums.Direction
@export var lowDirection: GlobalEnums.Direction

@export_category("Asset Properties")
@export var texture : Texture2D
@export var collider : CollisionShape3D
@export var mesh : MeshInstance3D

var isOccupied : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if texture != null and mesh.material_override == null:
		apply_texture(mesh, texture)


func apply_texture(mesh_instance_node, texture_pic):
	if mesh_instance_node:
		if mesh_instance_node.material_override == null:
			mesh_instance_node.material_override = StandardMaterial3D.new()
		mesh_instance_node.material_override.albedo_texture = texture_pic


func set_occupied(occupied : bool):
	isOccupied = occupied


func IsValidEnter(directionEnteringFrom : GlobalEnums.Direction):
	if (!isOccupied && directionEnteringFrom == highDirection):
		return Vector2(true, GlobalEnums.Direction.ABOVE)
	elif (!isOccupied && directionEnteringFrom == lowDirection):
		return Vector2(true, GlobalEnums.Direction.BELOW)
	else:
		return false


func IsValidExit(directionExitingTo : GlobalEnums.Direction):
	if (isOccupied && directionExitingTo == highDirection):
		return Vector2(true, GlobalEnums.Direction.ABOVE)
	elif (isOccupied && directionExitingTo == lowDirection):
		return Vector2(true, GlobalEnums.Direction.BELOW)
	else:
		return false


