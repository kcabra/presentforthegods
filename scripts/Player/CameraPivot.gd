extends Position2D

#sobe na hierarquia pra pegar as variaveis de player
onready var parent = $'..'

func _ready():
	pass

func _physics_process(delta):
	update_pivot_angle()

#essa funcao faz a margem de tolerancia da tela girar ao redor do player dependendo de pra onde ele esteja olhando
func update_pivot_angle():
	rotation = parent.playergaze.angle()