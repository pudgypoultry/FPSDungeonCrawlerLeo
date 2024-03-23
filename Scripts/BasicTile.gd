extends StaticBody3D

class_name BasicTile

@export_category("Physical Properties")
@export var isObstructing : bool = false
@export var height : int = 0

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
