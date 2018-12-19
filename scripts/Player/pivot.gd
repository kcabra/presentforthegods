extends Position2D

onready var player = get_parent()

func _ready():
	pass

func _physics_process(delta):
	# essa funcao faz a margem de tolerancia da tela girar ao redor do player dependendo de pra onde ele esteja olhando
	rotation = player.playergaze.angle()