extends Node3D

@export var checkRay : RayCast3D

var checkIsObstructed : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if checkRay.get_collider() is BasicTile:
		# Return not occupied AND not obstructing
		# So if both false, we're good to go, and this is true
		checkIsObstructed = !checkRay.get_collider().isOccupied and !checkRay.get_collider().isObstructing
	else:
		checkIsObstructed = false

func IsMovementObstructed():
	# "Is movement obstructed?" if checkIsObstructed is true, then we're good to move there
	return !checkIsObstructed

func GetTile():
	if checkRay.get_collider() is BasicTile:
		return checkRay.get_collider()

func GetCollider():
	return checkRay.get_collider()
