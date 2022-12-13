extends RichTextLabel

onready var label = get_node("../RichTextLabel")
onready var label_rect = label.get_rect()  # Cache the original pos
# The max number of lines that the label can hold
const MAX_LINES = 300

func reposition_label(text):
	var regex = RegEx.new()
	regex.compile("\\n")
	# Assumes that there are no trailing newlines.
	var linecount = len(regex.search_all(text)) + 1

	var line_offset = label_rect.size.y / MAX_LINES / 2
	var top_offset = line_offset * (MAX_LINES - linecount)
	# Adjust the margin by the computed amount
	label.set_margin(MARGIN_TOP, label_rect.position.y + top_offset)

# Called when the node enters the scene tree for the first time.
func _ready():
	reposition_label("No grande reino de Helderheim, algo terrível aconteceu, durante a noite o grande rei foi morto por um assassino misterioso. O rei não tinha sucessor e a notícia corre levando caos, desespero e desconfiança entre as pessoas. A desordem faz com que durante os anos a população do reino abandone a capital e se separe em cantos diferentes da ilha, sem organização ou consciência coletiva, eles passaram a viver de forma individualista e egoísta. Será que existirá alguém capaz de acabar com essa anomia e reunir os povos de Helderheim?")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
