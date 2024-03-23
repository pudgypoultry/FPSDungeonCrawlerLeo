extends Node3D

@export_category("Check Nodes")
@export var leftCheck : Node3D
@export var rightCheck : Node3D
@export var forwardCheck : Node3D
@export var backwardCheck : Node3D
@export var selfCheck : Node3D

@export_category("Camera")
@export var cam : Camera3D

@export_category("Movement Control")
@export var timeToMove : float = 0.2
@export var facing : GlobalEnums.Direction = GlobalEnums.Direction.NORTH

var currentAngle : Vector3
var leftRotation : Vector3 = Vector3(0, PI/2, 0)
var rightRotation : Vector3 = Vector3(0, -PI/2, 0)
var tweenRotation : Tween
var canMove : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	currentAngle = rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	PlayerMovement()

# METHOD OF FINDING CURRENT FACING DIRECTION
func RotateFacing(directionTurning : GlobalEnums.Turning, currentFacing : GlobalEnums.Direction):
	if directionTurning == GlobalEnums.Turning.TURNWISE:
		facing = (currentFacing + 1) % 4
	if directionTurning == GlobalEnums.Turning.WIDDERSHINS:
		facing = int(fposmod(currentFacing - 1, 4))


"""
MOVEMENT HELPERS
"""
func PlayerMovement():
	if Input.is_action_just_pressed("TurnLeft") && canMove:
		RotateFacing(GlobalEnums.Turning.WIDDERSHINS, facing)
		TweenRotate(rotation + leftRotation)
		CurrentlyMoving()
	
	if Input.is_action_just_pressed("TurnRight") && canMove:
		RotateFacing(GlobalEnums.Turning.TURNWISE, facing)
		TweenRotate(rotation + rightRotation)
		CurrentlyMoving()
	
	if Input.is_action_just_pressed("MoveForward") && canMove:
		if !forwardCheck.IsMovementObstructed():
			TweenPosition(position - cam.global_basis.z)
			CurrentlyMoving()
		else:
			print_debug("Kathunk")
	
	if Input.is_action_just_pressed("MoveBackward") && canMove:
		# Deal with the situation where we are attempting to move into a normal tile
		if backwardCheck.GetCollider() is BasicTile:
			if !backwardCheck.IsMovementObstructed():
				TweenPosition(position + cam.global_basis.z)
				CurrentlyMoving()
			else:
				print_debug("Kathunk (Basic Edition)")
		else:
			print_debug("Kathunk (Blank edition)")
	
	if Input.is_action_just_pressed("StrafeLeft") && canMove:
		if !leftCheck.IsMovementObstructed():
			TweenPosition(position - cam.global_basis.x)
			CurrentlyMoving()
		else:
			print_debug("Kathunk")
	
	if Input.is_action_just_pressed("StrafeRight") && canMove:
		if !rightCheck.IsMovementObstructed():
			TweenPosition(position + cam.global_basis.x)
			CurrentlyMoving()
		else:
			print_debug("Kathunk")

func TweenRotate(desired_rot):
	tweenRotation = create_tween().bind_node(self)
	tweenRotation.set_trans(Tween.TRANS_SINE)
	tweenRotation.set_ease(Tween.EASE_IN_OUT)
	tweenRotation.tween_property(self, "rotation", desired_rot, timeToMove)


func TweenPosition(desired_position):
	tweenRotation = create_tween().bind_node(self)
	tweenRotation.set_trans(Tween.TRANS_SINE)
	tweenRotation.set_ease(Tween.EASE_IN_OUT)
	tweenRotation.tween_property(self, "position", desired_position, timeToMove)

func CurrentlyMoving():
	canMove = false
	await get_tree().create_timer(timeToMove, false).timeout
	canMove = true

func InteractActive():
	pass
	


func InteractCollide():
	pass
