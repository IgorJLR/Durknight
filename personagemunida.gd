extends KinematicBody2D

# 1 EVENTO A MUDAR

var save_path = "user://save.dat"

export (int) var speed = 200
var equipindex = {
	"vazio":[0,0,0," ","vazio",999999],
	"Capacete Escuro":[1,0,0,"Elmo de soldado comum, tingido com tinta escura.","capacete",10],
	"Elmo de Aço":[4,0,0,"Ótima defesa, mas pesado. Cuidado com o torcicolo.","capacete",16],
	"Elmo Natural":[2,0,1,"A natureza o criou... curioso.","capacete",16],
	"Elmo Fatal":[6,2,2,"Simplesmente uma obra de arte, perfeito em tudo.","capacete",50],
	"Peitoral de Cobre":[2,1,1,"Leve e resistente, uma boa combinação.","peitoral",18],
	"Peitoral de Aço":[6,0,0,"Criado fraguando o aço pesado do deserto.","peitoral",28],
	"Armadura Fatal":[8,2,1,"É fato que seus inimigo cairão em temor.","peitoral",60],
	"Perneiras de Aço":[4,0,0,"Veio dos grandes mestres ferreiros do deserto.","perneiras",26],
	"Perneiras Orgânicas":[4,4,4,"Você se sente mais veloz que tudo.","perneiras",66],
	"Botas de Aço":[3,0,0,"Não são do tipo que se usa para correr.","botas",22],
	"Botas Naturais":[3,3,3,"A natureza se superou dessa vez...","botas",40],
	"Ponta de Ferro":[0,1,1,"Equipamento de combate comum, um tanto fraca.","arma",8],
	"Pique do Soldado":[1,2,0,"Grande chuço herdado de Lancer o 'Bruto de Laicos'.","arma",12],
	"Espada de Soldado":[0,3,1,"Espada da elite, leve e poderosa.","arma",12],
	"Espada Fatal":[1,6,3,"Cada golpe parece cortar a própia realidade.","arma",48],
	"Broquel Natural":[0,1,1,"Lancinante, nanico e tênue, anormal para um escudo.","escudo",5],
	"Escudo Fatal":[4,2,2,"Escudo que mais parece um muro.","escudo",42],
	"Tomo Sagrado":[0,0,0,"Gostaria de ouvir boas novas? -1 de gasto a mana.","amuleto",6],
	"Anel de Lâminas":[0,2,0,"Almas escuras emanam deste anel...","amuleto",14]
	}
var consumableindex = {
	"vazio":[-1,"",0,99999],
	"Poção de Vida Pequena":[0,"Recupera um pouco de vida, 5 pontos. A menos potente, procure algo melhor.",5,6],
	"Poção de Vida Média":[0,"Boa recuperação de vida, 10 pontos. Muito útil, use sem medo.",10,12],
	"Poção de Vida Grande":[0,"Incrível aumento de vida, 20 pontos, ninguém te segura!",20,18],
	"Poção de Mana Pequena":[1,"Recarrega moderadamente a mana, 5 pontos, esperava mais.",5,8],
	"Poção de Mana Média":[1,"Boa recarga da mana, 10 pontos, muito caro. Será que vale a pena?",10,18],
	"Poção de Mana Grande":[1,"Formidável recarga a mana, 20, caríssima! O que será que tem dentro?",20,38],
	"Boost de Agilidade":[2,"Aumento temporário de agilidade, duas batalhas, e um odor muito agradável.",5,50],
	"Boost de Defesa":[3,"Melhoria temporária à defesa, duas batalhas, não é a melhor defesa pelo que dizem.",10,52],
	"Boost de Força":[4,"Incremento temporário de ataque, duas batalhas, você pode sentir o poder.",5,50],
	"Boost de Mana":[5,"Temporário aperfeiçoamento de mana, duas batalhas, QUE PREÇO É ESSE!",10,100],
	"Maçã Verde":[0,"Uma deliciosa maçã verde, rende 5 pontos a vida. Espero que não contenha uma lagarta.",5,5]
	}
var velocity = Vector2()
var movendo = false
var direcao = "baixo"
var force = false
var switchh = 0
var positivo = false
var olhando = [false, "indefinido"]
var olhandoa = [false, "indefinido"]
var interacao = true
var correndo = false
var a = Vector2(0,0)
var pointer = "indefinido"
var pointeresc = "indefinido" 
var loja = false
var movimento = true
var textindex = 0
var permition = true
var voltar = false
var texto = []
var over = 0
var reset = false
var textplus = [false,"",0,"",0]
var gerald = false
var aux1 = 0
var aux2 = 0
var aux3 = 0
var idd = 0
var animation = false
var textoatual = ""
var busca = ""
var buscatroca = ""
var sobtroca = ""

var nivelindex = [5, 30, 100, 300, 400, 500, 600]

var limiter = true
var inv = {"equipado":{"capacete":["capacete","vazio"],"peitoral":["peitoral","vazio"],"perneiras":["perneiras","vazio"],"botas":["botas","vazio"],"arma":["arma","vazio"],"escudo":["escudo","vazio"],"amuleto3":["amuleto3","vazio"],"amuleto4":["amuleto4","vazio"]},
"guardado":[],
"consumables":{"Poção de Vida Pequena":[0],"Poção de Vida Média":[0],"Poção de Vida Grande":[0],"Poção de Mana Pequena":[0],"Poção de Mana Média":[0],"Poção de Mana Grande":[0],"Boost de Agilidade":[0],"Boost de Defesa":[0],"Boost de Força":[0],"Boost de Mana":[0],"Maçã Verde":[0]}
}

var status = {"vida":10, "mana":5 , "ataque":1, "defesa":2, "agilidade":1, "exp": 0, "moedas":0}

var eventos = {"Nome":"","Tipo":"","Checkpoint":"Cidade Principal","Config":{"velocidade":0.05,"volume":-20},"principal":0,"boost":{"2":0,"3":0,"4":0,"5":0},"loot":{"bau real":true,"lootCasa1":true,"lootCasa2":true,"lootCasa3":true,"lootDeserto1":true,"lootmundo1":true},"npcs":{"Lancer":false,"Sábio":false,"Diabrete":true,"CD":true}}

var battle = {"turno":1, "vez": "indefinido","pointer": "indefinido", "ação":"indefinido", "ataquesdisp": "indefinido", "ataque":"indefinido", "vida_inimigo": 1, "vida_jogador":10, "manaj":5, "ataque inimigo": "indefinido", "dano inimigo": 0, "inimigo_queue":2}

var c = true

var colision = false

var save = []

var pos = [0,0]

var nemo = {"Boost de Força":[9],"Elmo Fatal":[1], "Armadura Fatal":[1], "Espada Fatal":[1],"Perneiras Orgânicas":[1],"Botas Naturais":[1],"Escudo Fatal":[1]}

var monei = {"Poção de Vida Grande":[9],"Poção de Mana Grande":[9], "Boost de Agilidade":[9],"Boost de Defesa":[9], "Boost de Força":[9], "Boost de Mana":[9]}

signal BauVazio

signal Loaded

func ready():
	if c == true:
		c = false
		var file = File.new()
		if file.file_exists(save_path):
			var error = file.open(save_path, File.READ)
			if error == OK:
				var loader = file.get_var()
				status = loader["p"]
				pos = loader["s"]
				colision = loader["t"]
				battle = loader["q"]
				inv = loader["qui"]
				eventos = loader["sex"]
				file.close()
				colision = false
				
					
		eventos["Checkpoint"] = "Cidade Unida"
		$escMenu/Configurations.set_visible(true)
		$escMenu/Configurations/HSlider2.set_value(eventos["Config"]["velocidade"] * 1000)
		$escMenu/Configurations/HSlider.set_value(eventos["Config"]["volume"] + 94)
		$escMenu/Configurations.set_visible(false)
		subirnivel()
		$sons/musica.play()
		eventos["Checkpoint"] = "Cidade Unida"
		emit_signal("Loaded")
		direcao = "direita"
		if eventos["principal"] < 12:
			eventos["principal"] = 12



func get_input():
	velocity = Vector2()
	if Input.is_action_just_pressed("ui_cancel"):
		voltar = true
	else:
		voltar = false
	if Input.is_action_just_pressed("ui_accept"):
		positivo = true
		
	else:
		positivo = false
	if movimento == true and eventos["principal"] != 3:
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
			movendo = true
			direcao = "direita"
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			movendo = true
			direcao = "esquerda"
		elif Input.is_action_pressed("ui_down"):
			velocity.y += 1
			movendo = true
			direcao = "baixo"
		elif Input.is_action_pressed("ui_up"):
			velocity.y -= 1
			movendo = true
			direcao = "cima"
		else:
			movendo = false
	velocity = velocity.normalized() * speed

func get_animation():
	if movimento == true:
		if direcao == "esquerda":
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		if direcao == "cima" and movendo == false:
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("fc")
			else:
				$AnimatedSprite.play("c")
		if direcao == "cima" and movendo == true:
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("f anda c")
			else:
				$AnimatedSprite.play("anda c")
		if direcao == "baixo" and movendo == false:
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("fb")
			else:
				$AnimatedSprite.play("b")
		if direcao == "baixo" and movendo == true:
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("f anda b")
			else:
				$AnimatedSprite.play("anda b")
		if direcao == "direita" and movendo == false:
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("fd")
			else:
				$AnimatedSprite.play("d")
		if direcao == "direita" and movendo == true:
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("f anda d")
			else:
				$AnimatedSprite.play("anda d")
		if direcao == "esquerda" and movendo == false:
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("fe")
			else:
				$AnimatedSprite.play("e")
		if direcao == "esquerda" and movendo == true:
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("f anda d")
			else:
				$AnimatedSprite.play("anda d")
	else:
		if direcao == "esquerda":
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("fe")
			else:
				$AnimatedSprite.play("e")
		if direcao == "direita":
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("fd")
			else:
				$AnimatedSprite.play("d")
		if direcao == "baixo":
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("fb")
			else:
				$AnimatedSprite.play("b")
		if direcao == "cima":
			if eventos["Tipo"] == "1":
				$AnimatedSprite.play("fc")
			else:
				$AnimatedSprite.play("c")

func bumper(d):
	if d == "esquerda":
		$Bumper.position.x = -8
		$Bumper.position.y = 0
	if d == "direita":
		$Bumper.position.x = 8
		$Bumper.position.y = 0
	if d == "cima":
		$Bumper.position.x = 0
		$Bumper.position.y = -8
	if d == "baixo":
		$Bumper.position.x = 0
		$Bumper.position.y = 10

func interact():
	if interacao == true:
		if positivo == true and olhando[0] == true and olhando[1] == "placa" or positivo == true  and pointer == "olhando placa1":
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				$MenuMensagem/LabelMensagem.set_bbcode("Propriedade privada, parem de invadir!")
			if textindex == 1:
				$MenuMensagem/LabelMensagem.set_use_bbcode(true)
				$MenuMensagem/LabelMensagem.bbcode_text = ""
				$MenuMensagem/LabelMensagem.bbcode_text =""
			movimento = false
			pointer = "olhando placa1"
			interacao = false
			
		
		if positivo == true and olhando[0] == true and olhando[1] == "Sábiodeserto" or positivo == true  and pointer == "diálogo sábio":
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
					eventos["principal"] = 6
					eventos["npcs"]["Sábio"] = true

					textprep()
					textanimation("Olá novamente jovem... Como foi a viagem?",0,true,"",0,"",4)
			if textindex == 1:

				textprep()
				textanimation("Os aldeões daqui são difíceis... mas sem eles não temos chance.",1,false,"",0,"",0)
			if textindex == 2:

					textprep()
					textanimation("Provando a inocência dos magos de gelo os convenceremos.",2,false,"",0,"",0)
			if textindex == 3:

					textprep()
					textanimation("Marquei uma caverna no seu mapa, lá um pergaminho antigo foi escondido,",3,false,"",0,"",0)
			if textindex == 4:

					textprep()
					textanimation("A senha é ' AIMONA '",4,true,"[tornado radius=2 freq=2]",11,"[/tornado]",18)
			if textindex == 5:

					textprep()
					textanimation("mostre ele aos magos de gelo. Tomara que seja o suficiente...",5,true,"",0,"",8)
			
			movimento = false
			pointer = "diálogo sábio"
			interacao = false
			
		if positivo == true and olhando[0] == true and olhando[1] == "Lancer" or positivo == true  and pointer == "diálogo lancer":
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				$MenuMensagem/LabelMensagem.set_use_bbcode(true)
				$MenuMensagem/LabelMensagem.bbcode_text = ""
				if eventos["principal"] <= 2:
					$MenuMensagem/LabelMensagem.bbcode_text = "(Tenta falar enquanto mastiga um rabanete) tá me olha..ando (crack!)"
					textprep()
					textanimation(" tá me olha..ando ",0,true,"(Tenta falar enquanto mastiga um rabanete)",0,"([shake rate=30 level=2]crack![/shake])",17)
					
				else:
					if eventos["npcs"]["Lancer"] == true:
						
						$MenuMensagem/LabelMensagem.bbcode_text = ""
						textprep()
						
						textanimation("Foi mal por antes, eu não era assim.",0,true,"",0,"",0)
						
						
					else:
						$MenuMensagem/LabelMensagem.bbcode_text = "Nosso reino não se reconstruirá sozinho, meu pique acabará com eles."
						textprep()
						textanimation("Nosso reino não se reconstruirá sozinho, meu pique acabará com eles.",0,true,"",0,"",0)
			if textindex == 1:
				if eventos["principal"] <= 2:
					$MenuMensagem/LabelMensagem.set_bbcode("por que, quer levar um soco na cara?")
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					textprep()
					textanimation("por que, quer levar um soco na cara?",1,true,"",0,"",0)
					eventos["npcs"]["Lancer"] = true
				else:
					$MenuMensagem/LabelMensagem.set_bbcode("Tome cuidado, lembre-se de usar poções antes das batalhas.")
					textprep()
					textanimation("Tome cuidado, lembre-se de usar poções antes das batalhas.",1,true,"",0,"",0)
			movimento = false
			pointer = "diálogo lancer"
			interacao = false
			
		if positivo == true and olhando[0] == true and olhando[1] == "Berta" or positivo == true  and pointer == "diálogo berta":
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				$MenuMensagem/LabelMensagem.set_use_bbcode(true)
				$MenuMensagem/LabelMensagem.bbcode_text = ""
				if eventos["principal"] <= 2:
					$MenuMensagem/LabelMensagem.bbcode_text = "Os tempos estão difíceis,"
					textprep()
					textanimation("Os tempos estão difíceis,",0,true,"",0,"",0)
				else:
					$MenuMensagem/LabelMensagem.bbcode_text = "Eu estava tão cega de ódio... Já está na hora de voltar a se importar."
					textprep()
					textanimation("Eu estava tão cega de ódio... Já está na hora de voltar a se importar.",0,true,"",0,"",0)
			if textindex == 1:
				if eventos["principal"] <= 2:
					$MenuMensagem/LabelMensagem.set_bbcode("é cada um por si.")
					textprep()
					textanimation("é cada um por si.",1,true,"",0,"",0)
				else:
					$MenuMensagem/LabelMensagem.set_bbcode("Se esses demônios acham que já nôs derrotaram não perdem por esperar.")
					textprep()
					textanimation("Se esses demônios acham que já nôs derrotaram não perdem por esperar.",1,true,"",0,"",0)
			movimento = false
			pointer = "diálogo berta"
			interacao = false
		
		if positivo == true and olhando[0] == true and olhando[1] == "Sayan" or positivo == true  and pointer == "diálogo sayan" or positivo == true and eventos["principal"] == 3:
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				$MenuMensagem/LabelMensagem.set_use_bbcode(true)
				$MenuMensagem/LabelMensagem.bbcode_text = ""
				$MenuMensagem/LabelMensagem.bbcode_text = " Eu escutei tudo, não pode ser, todo esse tempo lutando entre si e a culpa"
				textprep()
				textanimation("Eu escutei tudo, não pode ser, todo esse tempo lutando entre si e a culpa",0,true,"",0,"",0)
			if textindex == 1:
				$MenuMensagem/LabelMensagem.set_bbcode("era desses demônios grotescos. Eu vou espalhar a notícia pela cidade,")
				textprep()
				textanimation("era desses demônios grotescos. Eu vou espalhar a notícia pela cidade,",1,true,"",0,"",0)
			if textindex == 2:
				$MenuMensagem/LabelMensagem.set_bbcode("o povo se unirá novamente!")
				textprep()
				textanimation("o povo se unirá novamente!",2,true,"",0,"",0)
			if textindex == 3:
				$MenuMensagem/LabelMensagem.set_bbcode("Tome aqui minha espada e estas poções, vá até o deserto e conte para eles.")
				textprep()
				textanimation("Tome aqui minha espada e estas poções, vá até o deserto e conte para eles.",3,true,"",0,"",0)
			movimento = false
			pointer = "diálogo sayan"
			interacao = false
		
		if positivo == true and olhando[0] == true and olhando[1] == "GeraldU" or positivo == true  and pointer == "diálogo gerald":
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				$MenuMensagem/LabelMensagem.bbcode_text = ""
				$MenuMensagem/LabelMensagem.bbcode_text += "Quer passar é? Primeiro vou querer 1000 moedas HAHAHAHA!"
				textprep()
				textanimation("Fiquei para cuidar das crianças e idosos.",0,true,"",0,"",0)
			movimento = false
			pointer = "diálogo gerald"
			interacao = false
			
		if positivo == true and olhando[0] == true and olhando[1] == "Mago de Gelo A" or positivo == true  and pointer == "diálogo A":
				$MenuMensagem.set_visible(true)
				permition = false
				$MenuMensagem/LabelMensagem.set_visible(true)
				if textindex == 0:
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 9:
						textprep()
						textanimation("Você é muito forte...",0,true,"",0,"",0)
					else:
						textprep()
						textanimation("O que foi isso?  Entendo... mal posso expressar o meu ódio,",0,true,"(você conta tudo a ele)",15,"",0)
				
				if textindex == 1:
					$MenuMensagem/LabelMensagem.set_use_bbcode(true)
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 9:
						textprep()
						textanimation("Talvez possa achar quem do deserto assassinou o rei e acabar com ele.",1,true,"",0,"",0)
					else:
						textprep()
						textanimation("Demônios infelizes. Eu mesmo reunirei as tropas para chegarmos à capital.",1,true,"",0,"",0)
				movimento = false
				pointer = "diálogo A"
				interacao = false
				
				
		if positivo == true and olhando[0] == true and olhando[1] == "Mago de Gelo BU" or positivo == true  and pointer == "diálogo B":
				$MenuMensagem.set_visible(true)
				permition = false
				$MenuMensagem/LabelMensagem.set_visible(true)
				if textindex == 0:
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 9:
						textprep()
						textanimation("Coloca esse pergaminho pra lá você tá doido?",0,true,"",0,"",0)
					else:
						textprep()
						textanimation("Calma meu amor.. é uma guerra, preciso ajudar.",0,true,"",0,"",0)
				
				
				movimento = false
				pointer = "diálogo B"
				interacao = false
				
		
		if positivo == true and olhando[0] == true and olhando[1] == "KenshiU" or positivo == true  and pointer == "diálogo kenshi":
				$MenuMensagem.set_visible(true)
				permition = false
				$MenuMensagem/LabelMensagem.set_visible(true)
				if textindex == 0:
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 9:
						textprep()
						textanimation("Coloca esse pergaminho pra lá você tá doido?",0,true,"",0,"",0)
					else:
						textprep()
						textanimation("Eu te conheço, você nôs salvou.",0,true,"",0,"",0)
				
				
				movimento = false
				pointer = "diálogo kenshi"
				interacao = false
		
		if positivo == true and olhando[0] == true and olhando[1] == "IldaU" or positivo == true  and pointer == "diálogo ilda":
				$MenuMensagem.set_visible(true)
				permition = false
				$MenuMensagem/LabelMensagem.set_visible(true)
				if textindex == 0:
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 9:
						textprep()
						textanimation("Coloca esse pergaminho pra lá você tá doido?",0,true,"",0,"",0)
					else:
						textprep()
						textanimation("Estou cuidando deste garoto agora, vou ensina-lo a jardinagem.",0,true,"",0,"",0)
				
				
				movimento = false
				pointer = "diálogo ilda"
				interacao = false
		
		if positivo == true and olhando[0] == true and olhando[1] == "Mago de Gelo C" or positivo == true  and pointer == "diálogo C":
				$MenuMensagem.set_visible(true)
				permition = false
				$MenuMensagem/LabelMensagem.set_visible(true)
				if textindex == 0:
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 9:
						textprep()
						textanimation("Não existe tratado, eles mataram o rei e merecem queimar!",0,true,"",0,"",0)
					else:
						textprep()
						textanimation("Então você estava certo... Vou destransformar os invasores...",0,true,"",0,"",0)
				
				
				movimento = false
				pointer = "diálogo C"
				interacao = false
				
		if positivo == true and olhando[0] == true and olhando[1] == "Mago de Gelo D" or positivo == true  and pointer == "diálogo D":
				$MenuMensagem.set_visible(true)
				permition = false
				$MenuMensagem/LabelMensagem.set_visible(true)
				if textindex == 0:
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 9:
						textprep()
						textanimation("COMO VOCÊ CONSEGUIU ISSO?",0,true,"",0,"",0)
					else:
						textprep()
						textanimation("",0,true,"",0,"",0)
				
				
				movimento = false
				pointer = "diálogo D"
				interacao = false
				
		if positivo == true and olhando[0] == true and olhando[1] == "Loyce" or positivo == true  and pointer == "diálogo loyce":
				$MenuMensagem.set_visible(true)
				permition = false
				$MenuMensagem/LabelMensagem.set_visible(true)
				if textindex == 0:
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 5:
						textprep()
						textanimation("Esse meu parceiro aí do lado é muito burro, ainda se preocupa em matar os",0,true,"",0,"",0)
					else:
						textprep()
						textanimation("",0,true,"",0,"",0)
				
				if textindex == 1:
					$MenuMensagem/LabelMensagem.set_use_bbcode(true)
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 5:
						textprep()
						textanimation("culpados do assassinato do rei, não faz diferença. Tudo está perdido!",1,true,"",0,"",0)
					else:
						textprep()
						textanimation("",1,true,"",0,"",0)
				movimento = false
				pointer = "diálogo loyce"
				interacao = false
			
		if positivo == true and olhando[0] == true and olhando[1] == "JohnU" or positivo == true  and pointer == "diálogo john":
				$MenuMensagem.set_visible(true)
				permition = false
				$MenuMensagem/LabelMensagem.set_visible(true)
				if textindex == 0:
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 5:
						textprep()
						textanimation("Aqueles bandidos ali, como eu queria acabar com eles. Só estão esperando a",0,true,"",0,"",0)
					else:
						textprep()
						textanimation("Aqueles cabeçudos.......... Espero que estejam bem...",0,true,"",0,"",0)
				
				
				movimento = false
				pointer = "diálogo john"
				interacao = false
			
			
		if positivo == true and olhando[0] == true and olhando[1] == "ShanalotteU" or positivo == true  and pointer == "diálogo shanalotte":
				$MenuMensagem.set_visible(true)
				permition = false
				$MenuMensagem/LabelMensagem.set_visible(true)
				if textindex == 0:
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					if eventos["principal"] <= 5:
						textprep()
						textanimation("Desculpe mal consigo te entender nesse calor. Os magos de gelo usavam sua",0,true,"",0,"",0)
					else:
						textprep()
						textanimation("Você não vai me abandonar novamente!!! Não deixo.",0,true,"",0,"",0)
				
				
				movimento = false
				pointer = "diálogo shanalotte"
				interacao = false
			
		if positivo == true and olhando[0] == true and olhando[1] == "apple tree" and eventos["principal"] >=3 or positivo == true  and pointer == "apple tree" and eventos["principal"] >=2:
			
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				$MenuMensagem/LabelMensagem.bbcode_text = ""
				aux3 = 0
				texto = []
				aux1 = 0
				textoatual = ""
				animation = true
				textanimation("Você balança a árvore vigorosamente...",0,true,"[shake rate=30 level=2]",30,"[/shake]",38)
				
			if textindex == 1:
				var rand = 0
				if inv["consumables"]["Maçã Verde"][0] > 3:
					rand = randi() % 1001
				else:
					rand = randi() % 101
				if rand <= 3:
					$MenuMensagem/LabelMensagem.set_bbcode("Uma maçã cai da árvore!")
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					aux3 = 0
					texto = []
					aux1 = 0
					textoatual = ""
					animation = true
					textanimation("Uma maçã cai da árvore!",1,true,"",0,"",0)
					inv["consumables"]["Maçã Verde"][0] += 1
				else:
					$MenuMensagem/LabelMensagem.set_bbcode("Porém nada acontece.")
					textprep()
					textanimation("Porém nada acontece.",1,true,"",0,"",0)
			movimento = false
			pointer = "apple tree"
			interacao = false
		
		
		if positivo == true and olhando[0] == true and olhando[1] == "lootDeserto1" or positivo == true  and pointer == "lootDeserto1":
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				var txtxt = get_node("../lootDeserto1").vazio
				if txtxt == false:
					txtxt = get_node("../lootDeserto1").loot
					var ress = ""
					var couna = 0
					for xcvs in txtxt:
						for g in consumableindex:
							if g == xcvs:
								inv["consumables"][xcvs][0] += 1
						for g in equipindex:
							if g == xcvs:
								inv["guardado"].append(xcvs)
						if xcvs == "moedas":
							status["moedas"] += txtxt["moedas"]
						if couna < 5:
							if xcvs == "moedas":
								ress += str(txtxt["moedas"])
								ress += " "
								ress += xcvs
							else:
								ress += xcvs
							couna = int(ress.count(" "))
							if couna <3:
								
								ress += ", "
							else:
								ress += "..."
					$MenuMensagem/LabelMensagem.set_bbcode("Você abre o saco e ganha: " + str(ress))
					$sons/item.play()
					pointer = "lootDeserto1"
					eventos["loot"]["lootDeserto1"] = false
					emit_signal("BauVazio",pointer)
					
				else:
					textindex += 1
			movimento = false
			pointer = "lootDeserto1"
			interacao = false
			if textindex == 1:
				$MenuMensagem/LabelMensagem.set_bbcode("Não tem mais nada.")
		if positivo == true and olhando[0] == true and olhando[1] == "lootCasa2" or positivo == true  and pointer == "lootCasa2":
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				var txtxt = get_node("../lootCasa2").vazio
				if txtxt == false:
					txtxt = get_node("../lootCasa2").loot
					var ress = ""
					var couna = 0
					for xcvs in txtxt:
						for g in consumableindex:
							if g == xcvs:
								inv["consumables"][xcvs][0] += 1
						for g in equipindex:
							if g == xcvs:
								inv["guardado"].append(xcvs)
						if xcvs == "moedas":
							status["moedas"] += txtxt["moedas"]
						if couna < 5:
							if xcvs == "moedas":
								ress += str(txtxt["moedas"])
								ress += " "
								ress += xcvs
							else:
								ress += xcvs
							couna = int(ress.count(" "))
							if couna <3:
								
								ress += ", "
							else:
								ress += "..."
					$MenuMensagem/LabelMensagem.set_bbcode("Você abre o saco e ganha: " + str(ress))
					pointer = "lootCasa2"
					eventos["loot"]["lootCasa2"] = false
					emit_signal("BauVazio",pointer)
					
				else:
					textindex += 1
			movimento = false
			pointer = "lootCasa2"
			interacao = false
			if textindex == 1:
				$MenuMensagem/LabelMensagem.set_bbcode("Não tem mais nada.")
		if positivo == true and olhando[0] == true and olhando[1] == "NemoU" or positivo == true  and pointer == "loja Nemo" or switchh == 5 and olhando[1] == "NemoU" or force == true and olhando[1] == "NemoU":
			if switchh == 5:
				switchh = 6
				textindex = 1
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				if eventos["principal"] < 4:
					$MenuMensagem/LabelMensagem.set_bbcode("Saia daqui! Seu plebeu imundo! (ele se recusa a te vender mercadorias)")
					textprep()
					textanimation(eventos["Nome"] +"!!! Que bom te ver. Aqui tenho os melhores armamentos.",0,true,"",0,"",0)
				else:
					$MenuMensagem/LabelMensagem.set_bbcode("Obrigado pela ajuda, devemos a você.")
					textprep()
					textanimation(eventos["Nome"] +"!!! Que bom te ver. Aqui tenho os melhores armamentos.",0,true,"",0,"",0)
					
			if textindex == 1:
				
				loja = true
				$escMenu.set_visible(true)
				$escMenu.set_animation("7")
				$escMenu/loja.set_visible(true)
				var carregar = 0
				var _naocarregar = 0
				$escMenu/Sprite.position = Vector2(-34,-69)
				$escMenu/Sprite.set_visible(true)
				$escMenu/equipados/RichTextLabel.bbcode_text = "\n\n\n +0 +0 +0"
				carregar = -1
				for n in nemo:
					if nemo[n][0]  > 0 and not n in inv["guardado"] and not n in inv["equipado"]["capacete"][1]:
						var t ="escMenu/guardados/" + str(carregar)
						$escMenu/guardados.set_visible(true)
						get_node(t).play(n)
						get_node(t).set_visible(true)
						t ="escMenu/mininumber/" + str(carregar)
						$escMenu/mininumber.set_visible(true)
						get_node(t).play(str(nemo[n][0]))
						if str(nemo[n][0]) != "9":
							get_node(t).set_visible(true)
						carregar += 1
							
				carregar += 6
				$escMenu.play(str(carregar))
				reset = false
				textindex+=1
				#-52 -23
				$escMenu/equipados/RichTextLabel.set_position(Vector2(-52,-39))
			if textindex == 2 and loja == true and switchh != 5 or force == true:
				force = false
				switchh +=1
				if switchh == 2:
					switchh = 0
					if $escMenu/loja.get_animation() == "default":
						$escMenu/loja.play("sim")
				if switchh == 1 and $escMenu/loja.get_animation() == "sim":
					for huhi in consumableindex:
						if huhi == buscatroca and buscatroca != "":
							
							if status["moedas"] - consumableindex[buscatroca][3] >= 0:
								status["moedas"] -= consumableindex[buscatroca][3]
								if nemo[buscatroca][0] - 1 != -1 and nemo[buscatroca][0] != 9:
									nemo[buscatroca][0] -= 1
								inv["consumables"][buscatroca][0] += 1
								
								hideall()
								
								
								interacao = true
								$escMenu/loja.play("default")
								pointer = "loja Nemo"
								switchh = 5
							else:
								$escMenu/loja.play("default")
							
					for huhi in equipindex:
						if huhi == buscatroca and buscatroca != "":
							if status["moedas"] - equipindex[buscatroca][5] >= 0:
								status["moedas"] -= equipindex[buscatroca][5]
								if nemo[buscatroca][0] - 1 != -1 and nemo[buscatroca][0] != 9:
									nemo[buscatroca][0] -= 1
								inv["guardado"].append(buscatroca)
								
								hideall()
								
								
								interacao = true
								$escMenu/loja.play("default")
								pointer = "loja Nemo"
								switchh = 5
								
							else:
								$escMenu/loja.play("default")
				if switchh == 1 and $escMenu/loja.get_animation() == "nao":
					$escMenu/loja.play("default")
			movimento = false
			pointer = "loja Nemo"
			if switchh != 7:
				interacao = false
		if positivo == true and olhando[0] == true and olhando[1] == "MoneiU" or positivo == true  and pointer == "loja Monei" or switchh == 5 and pointer == "loja Monei"  or force == true and pointer == "loja Monei":
			if switchh == 5:
				switchh = 6
				textindex = 1
			$MenuMensagem.set_visible(true)
			permition = false
			$MenuMensagem/LabelMensagem.set_visible(true)
			if textindex == 0:
				if eventos["principal"] < 4:
					$MenuMensagem/LabelMensagem.set_bbcode("Saia daqui! Seu plebeu imundo! (ele se recusa a te vender mercadorias)")
					textprep()
					textanimation("Ah olá "+eventos["Nome"] +", minhas poções podem curar tudo!",0,true,"",0,"",0)
				else:
					$MenuMensagem/LabelMensagem.set_bbcode("Obrigado pela ajuda, devemos a você.")
					textprep()
					textanimation("Ah olá "+eventos["Nome"] +", minhas poções podem curar tudo!",0,true,"",0,"",0)
					
			if textindex == 1:
				
				loja = true
				$escMenu.set_visible(true)
				$escMenu.set_animation("7")
				$escMenu/loja.set_visible(true)
				var carregar = 0
				var _naocarregar = 0
				$escMenu/Sprite.position = Vector2(-34,-69)
				$escMenu/Sprite.set_visible(true)
				$escMenu/equipados/RichTextLabel.bbcode_text = "\n\n\n +0 +0 +0"
				carregar = -1
				for n in monei:
					if monei[n][0]  > 0 and not n in inv["guardado"] and not n in inv["equipado"]["capacete"][1]:
						var t ="escMenu/guardados/" + str(carregar)
						$escMenu/guardados.set_visible(true)
						get_node(t).play(n)
						get_node(t).set_visible(true)
						t ="escMenu/mininumber/" + str(carregar)
						$escMenu/mininumber.set_visible(true)
						get_node(t).play(str(monei[n][0]))
						if str(monei[n][0]) != "9":
							get_node(t).set_visible(true)
						carregar += 1
							
				carregar += 6
				$escMenu.play(str(carregar))
				reset = false
				textindex+=1
				#-52 -23
				$escMenu/equipados/RichTextLabel.set_position(Vector2(-52,-39))
			if textindex == 2 and loja == true and switchh != 5 or force == true:
				force = false
				switchh +=1
				if switchh == 2:
					switchh = 0
					if $escMenu/loja.get_animation() == "default":
						$escMenu/loja.play("sim")
				if switchh == 1 and $escMenu/loja.get_animation() == "sim":
					for huhi in consumableindex:
						if huhi == buscatroca and buscatroca != "":
							
							if status["moedas"] - consumableindex[buscatroca][3] >= 0:
								status["moedas"] -= consumableindex[buscatroca][3]
								if monei[buscatroca][0] - 1 != -1 and monei[buscatroca][0] != 9:
									monei[buscatroca][0] -= 1
								inv["consumables"][buscatroca][0] += 1
								
								hideall()
								
								
								interacao = true
								$escMenu/loja.play("default")
								pointer = "loja Monei"
								switchh = 5
							else:
								$escMenu/loja.play("default")
							
					for huhi in equipindex:
						if huhi == buscatroca and buscatroca != "":
							if status["moedas"] - equipindex[buscatroca][5] >= 0:
								status["moedas"] -= equipindex[buscatroca][5]
								if monei[buscatroca][0] - 1 != -1 and monei[buscatroca][0] != 9:
									monei[buscatroca][0] -= 1
								inv["guardado"].append(buscatroca)
								
								hideall()
								
								
								interacao = true
								$escMenu/loja.play("default")
								pointer = "loja Monei"
								switchh = 5
								
							else:
								$escMenu/loja.play("default")
				if switchh == 1 and $escMenu/loja.get_animation() == "nao":
					$escMenu/loja.play("default")
			movimento = false
			pointer = "loja Monei"
			if switchh != 7:
				interacao = false

	
func continuar():
	if interacao == false:
		if pointer == "olhando placa1":
			if positivo == true and textindex < 1:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo B":
			if positivo == true and textindex < 1:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo kenshi":
			if positivo == true and textindex < 1:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo ilda":
			if positivo == true and textindex < 1:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo C":
			if positivo == true and textindex < 1:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo lancer":
			if positivo == true and textindex < 2:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
					if pointer == "diálogo lancer" and eventos["npcs"]["Lancer"] == true:
						var tdb = 0
						eventos["npcs"]["Lancer"] = false
						for gnk in inv["guardado"]:
							if gnk == "Pique do Soldado":
								tdb +=1
						if tdb == 0 and inv["equipado"]["arma"][0] != "Pique do Soldado":
							inv["guardado"].append("Pique do Soldado") 
							$MenuMensagem/LabelMensagem.bbcode_text += "(ele te entrega uma lança)"
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo berta":
			if positivo == true and textindex < 2:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo sayan":
			if positivo == true and textindex < 4:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
				if eventos["principal"] == 3:
					inv["guardado"].append("Ponta de Ferro")
					inv["consumables"]["Poção de Vida Pequena"][0] += 1
					inv["consumables"]["Poção de Mana Pequena"][0] += 1
				eventos["principal"] = 4
		if pointer == "diálogo gerald":
			if positivo == true and textindex < 1:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo A":
			if positivo == true and textindex < 2:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
				if eventos["principal"] == 10:
					eventos["principal"] = 11
		if pointer == "diálogo D":
			if positivo == true and textindex < 1:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
				eventos["principal"] = 10
				$"sons/d foge".play()
		if pointer == "diálogo loyce":
			if positivo == true and textindex < 2:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo john":
			if positivo == true and textindex < 1:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo shanalotte":
			if positivo == true and textindex < 1:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "diálogo sábio":
			if positivo == true and textindex == 4:
				eventos["npcs"]["Sábio"] = false
			if positivo == true and textindex < 6:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				
				endtext()
		if pointer == "apple tree":
			if positivo == true and textindex < 2:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "bau real":
			if positivo == true and textindex < 2:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "lootDeserto1":
			if positivo == true and textindex < 2:
				textindex += 1
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "lootCasa2":
			if positivo == true and textindex < 2:
				textindex += 0.5
				if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
					animation = false
					$MenuMensagem/LabelMensagem.bbcode_text = ""
					for l in texto:
						$MenuMensagem/LabelMensagem.bbcode_text += l
				interacao = true
				positivo = false
			else:
				endtext()
		if pointer == "loja Nemo":
			if positivo == true and textindex < 3:
				interacao = true
				if loja == false:
					textindex += 0.5
					if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
						animation = false
						$MenuMensagem/LabelMensagem.bbcode_text = ""
						for l in texto:
							$MenuMensagem/LabelMensagem.bbcode_text += l
				positivo = false
			if textindex == 3:
				endtext()
				$MenuMensagem/LabelMensagem.set_visible(false)
				$escMenu/equipados/RichTextLabel.set_visible(false)
				$escMenu/Sprite.set_visible(false)
				$escMenu/equipados/RichTextLabel.set_position(Vector2(-52,-23))
		if pointer == "loja Monei":
			if positivo == true and textindex < 3:
				interacao = true
				if loja == false:
					textindex += 0.5
					if animation == true and $MenuMensagem/LabelMensagem.get_bbcode() != "":
						animation = false
						$MenuMensagem/LabelMensagem.bbcode_text = ""
						for l in texto:
							$MenuMensagem/LabelMensagem.bbcode_text += l
				positivo = false
			if textindex == 3:
				endtext()
				$MenuMensagem/LabelMensagem.set_visible(false)
				$escMenu/equipados/RichTextLabel.set_visible(false)
				$escMenu/Sprite.set_visible(false)
				$escMenu/equipados/RichTextLabel.set_position(Vector2(-52,-23))
				
				
				
				
	if $escMenu/loja.get_animation() != "default":
		if Input.is_action_just_pressed("ui_up"):
			$escMenu/loja.play("sim")
		if Input.is_action_just_pressed("ui_down"):
			$escMenu/loja.play("nao")
	if textindex == 2 and pointer == "loja Nemo" and $escMenu/loja.get_animation() == "default":
		$escMenu/Sprite.set_visible(true)
		$escMenu/Sprite/AnimationPlayer.play("select")
		
		var g = ""
		if Input.is_action_just_pressed("ui_right") and $escMenu/Sprite.position.x < 61:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.x += 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_left") and $escMenu/Sprite.position.x > -23:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.x -= 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_up") and $escMenu/Sprite.position.y > -59:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.y -= 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_down") and $escMenu/Sprite.position.y < -20:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.y += 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		
		if $escMenu/Sprite.position == Vector2(-34,-69):
			sobtroca = $escMenu/Sprite.position
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
			$escMenu/equipados.set_visible(true)
			$escMenu/equipados/RichTextLabel.set_visible(true)
			if buscatroca != "" and buscatroca != "vazio":
				for huhi in consumableindex:
					if huhi == buscatroca and buscatroca != "":
						$escMenu/equipados/RichTextLabel.bbcode_text = " [color=#fbf236]Possui[/color]: "
						$escMenu/equipados/RichTextLabel.bbcode_text += str(status["moedas"])
						$escMenu/equipados/RichTextLabel.bbcode_text += ", "
						$escMenu/equipados/RichTextLabel.bbcode_text += " [color=#fbf236]Custo[/color]: "
						$escMenu/equipados/RichTextLabel.bbcode_text += str(consumableindex[buscatroca][3])
						$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(buscatroca) + " : " + str(consumableindex[buscatroca][1])
				for huhi in equipindex:
					if huhi == buscatroca and buscatroca != "":
						$escMenu/equipados/RichTextLabel.bbcode_text = " [color=#fbf236]Possui[/color]: "
						$escMenu/equipados/RichTextLabel.bbcode_text += str(status["moedas"])
						$escMenu/equipados/RichTextLabel.bbcode_text += ", "
						$escMenu/equipados/RichTextLabel.bbcode_text += " [color=#fbf236]Custo[/color]: "
						$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][5])
						$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(buscatroca) + " : " + str(equipindex[buscatroca][3])
						reset = true
						var _h = ""
						$escMenu/equipados/RichTextLabel.bbcode_text += " "
						$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#37325e]def[/color]:"
						print(buscatroca)
						if equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0] >= 0:
							$escMenu/equipados/RichTextLabel.bbcode_text += "+"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0]," ")
							
						$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#5e3232]atq[/color]:"
						if equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1] >= 0:
							$escMenu/equipados/RichTextLabel.bbcode_text += "+"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1]," ")
							
						$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#375e32]vel[/color]:"
						if equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2] >= 0:
							$escMenu/equipados/RichTextLabel.bbcode_text += "+"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2])
						reset = true
		
		if reset == false and  $escMenu/Sprite.position != Vector2(-34,-69):
			reset = true
			$escMenu/equipados.set_visible(true)
			$escMenu/equipados/RichTextLabel.set_visible(true)
			for huhi in consumableindex:
				if huhi == buscatroca and buscatroca != "":
					$escMenu/equipados/RichTextLabel.bbcode_text = " [color=#fbf236]Possui[/color]: "
					$escMenu/equipados/RichTextLabel.bbcode_text += str(status["moedas"])
					$escMenu/equipados/RichTextLabel.bbcode_text += ", "
					$escMenu/equipados/RichTextLabel.bbcode_text += " [color=#fbf236]Custo[/color]: "
					$escMenu/equipados/RichTextLabel.bbcode_text += str(consumableindex[buscatroca][3])
					$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(buscatroca) + " : " + str(consumableindex[buscatroca][1])
			for huhi in equipindex:
				if huhi == buscatroca and buscatroca != "":
					busca = equipindex[buscatroca][4]
					$escMenu/equipados/RichTextLabel.bbcode_text = " [color=#fbf236]Possui[/color]: "
					$escMenu/equipados/RichTextLabel.bbcode_text += str(status["moedas"])
					$escMenu/equipados/RichTextLabel.bbcode_text += ", "
					$escMenu/equipados/RichTextLabel.bbcode_text += " [color=#fbf236]Custo[/color]: "
					$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][5])
					$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(buscatroca) + " : " + str(equipindex[buscatroca][3])
					reset = true
					var _h = ""
					$escMenu/equipados/RichTextLabel.bbcode_text += " "
					$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#37325e]def[/color]:"
					if equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0] >= 0:
						$escMenu/equipados/RichTextLabel.bbcode_text += "+"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0]," ")
						
					$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#5e3232]atq[/color]:"
					if equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1] >= 0:
						$escMenu/equipados/RichTextLabel.bbcode_text += "+"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1]," ")
						
					$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#375e32]vel[/color]:"
					if equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2] >= 0:
						$escMenu/equipados/RichTextLabel.bbcode_text += "+"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2])
					reset = true
	
	if textindex == 2 and pointer == "loja Monei" and $escMenu/loja.get_animation() == "default":
		$escMenu/Sprite.set_visible(true)
		$escMenu/Sprite/AnimationPlayer.play("select")
		
		var g = ""
		if Input.is_action_just_pressed("ui_right") and $escMenu/Sprite.position.x < 61:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.x += 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_left") and $escMenu/Sprite.position.x > -23:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.x -= 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_up") and $escMenu/Sprite.position.y > -59:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.y -= 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_down") and $escMenu/Sprite.position.y < -20:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.y += 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		
		if $escMenu/Sprite.position == Vector2(-34,-69):
			sobtroca = $escMenu/Sprite.position
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
			$escMenu/equipados.set_visible(true)
			$escMenu/equipados/RichTextLabel.set_visible(true)
			if buscatroca != "" and buscatroca != "vazio":
				for huhi in consumableindex:
					if huhi == buscatroca and buscatroca != "":
						$escMenu/equipados/RichTextLabel.bbcode_text = " [color=#fbf236]Possui[/color]: "
						$escMenu/equipados/RichTextLabel.bbcode_text += str(status["moedas"])
						$escMenu/equipados/RichTextLabel.bbcode_text += ", "
						$escMenu/equipados/RichTextLabel.bbcode_text += " [color=#fbf236]Custo[/color]: "
						$escMenu/equipados/RichTextLabel.bbcode_text += str(consumableindex[buscatroca][3])
						$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(buscatroca) + " : " + str(consumableindex[buscatroca][1])
				for huhi in equipindex:
					if huhi == buscatroca and buscatroca != "":
						$escMenu/equipados/RichTextLabel.bbcode_text = " [color=#fbf236]Possui[/color]: "
						$escMenu/equipados/RichTextLabel.bbcode_text += str(status["moedas"])
						$escMenu/equipados/RichTextLabel.bbcode_text += ", "
						$escMenu/equipados/RichTextLabel.bbcode_text += " [color=#fbf236]Custo[/color]: "
						$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][5])
						$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(buscatroca) + " : " + str(equipindex[buscatroca][3])
						reset = true
						var _h = ""
						$escMenu/equipados/RichTextLabel.bbcode_text += " "
						$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#37325e]def[/color]:"
						print(buscatroca)
						if equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0] >= 0:
							$escMenu/equipados/RichTextLabel.bbcode_text += "+"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0]," ")
							
						$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#5e3232]atq[/color]:"
						if equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1] >= 0:
							$escMenu/equipados/RichTextLabel.bbcode_text += "+"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1]," ")
							
						$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#375e32]vel[/color]:"
						if equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2] >= 0:
							$escMenu/equipados/RichTextLabel.bbcode_text += "+"
						$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2])
						reset = true
		
		if reset == false and  $escMenu/Sprite.position != Vector2(-34,-69):
			reset = true
			$escMenu/equipados.set_visible(true)
			$escMenu/equipados/RichTextLabel.set_visible(true)
			for huhi in consumableindex:
				if huhi == buscatroca and buscatroca != "":
					$escMenu/equipados/RichTextLabel.bbcode_text = " [color=#fbf236]Possui[/color]: "
					$escMenu/equipados/RichTextLabel.bbcode_text += str(status["moedas"])
					$escMenu/equipados/RichTextLabel.bbcode_text += ", "
					$escMenu/equipados/RichTextLabel.bbcode_text += " [color=#fbf236]Custo[/color]: "
					$escMenu/equipados/RichTextLabel.bbcode_text += str(consumableindex[buscatroca][3])
					$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(buscatroca) + " : " + str(consumableindex[buscatroca][1])
			for huhi in equipindex:
				if huhi == buscatroca and buscatroca != "":
					busca = equipindex[buscatroca][4]
					$escMenu/equipados/RichTextLabel.bbcode_text = " [color=#fbf236]Possui[/color]: "
					$escMenu/equipados/RichTextLabel.bbcode_text += str(status["moedas"])
					$escMenu/equipados/RichTextLabel.bbcode_text += ", "
					$escMenu/equipados/RichTextLabel.bbcode_text += " [color=#fbf236]Custo[/color]: "
					$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][5])
					$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(buscatroca) + " : " + str(equipindex[buscatroca][3])
					reset = true
					var _h = ""
					$escMenu/equipados/RichTextLabel.bbcode_text += " "
					$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#37325e]def[/color]:"
					if equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0] >= 0:
						$escMenu/equipados/RichTextLabel.bbcode_text += "+"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0]," ")
						
					$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#5e3232]atq[/color]:"
					if equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1] >= 0:
						$escMenu/equipados/RichTextLabel.bbcode_text += "+"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1]," ")
						
					$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#375e32]vel[/color]:"
					if equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2] >= 0:
						$escMenu/equipados/RichTextLabel.bbcode_text += "+"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2])
					reset = true
	
	
	if positivo == true and pointer == "loja Nemo":
		
		if buscatroca != "vazio":
			pointer = "compra"
		else:
			var g = ""
			sobtroca = $escMenu/Sprite.position
			reset = false
			for n in range(22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
	
	if positivo == true and pointer == "loja Monei":
		
		if buscatroca != "vazio":
			pointer = "compra"
		else:
			var g = ""
			sobtroca = $escMenu/Sprite.position
			reset = false
			for n in range(22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
	
	if voltar == true and pointer == "loja Nemo":
		voltar = false
		$escMenu.set_animation("0")
		$escMenu.set_visible(false)
		
		$escMenu/guardados.set_visible(false)
		hideall()
		switchh = 0
		$escMenu/Sprite.position = Vector2(-23,-59)
		$escMenu/loja.set_visible(false)
		loja = false
		textindex = 2

		textprep()
		textanimation("Acabe com eles "+eventos["Nome"]+"!",2,true,"",0,"",0)
		#-52 -23
		$escMenu/equipados/RichTextLabel.set_position(Vector2(-52, -23))
		$escMenu/Sprite.set_visible(false)
		$escMenu/equipados/RichTextLabel.set_visible(false)
	
	if voltar == true and pointer == "loja Monei":
		voltar = false
		$escMenu.set_animation("0")
		$escMenu.set_visible(false)
		
		$escMenu/guardados.set_visible(false)
		hideall()
		switchh = 0
		$escMenu/Sprite.position = Vector2(-23,-59)
		$escMenu/loja.set_visible(false)
		loja = false
		textindex = 2

		textprep()
		textanimation("Temos confiança em você "+eventos["Nome"]+".",2,true,"",0,"",0)
		#-52 -23
		$escMenu/equipados/RichTextLabel.set_position(Vector2(-52, -23))
		$escMenu/Sprite.set_visible(false)
		$escMenu/equipados/RichTextLabel.set_visible(false)

func textprep():
	$MenuMensagem/LabelMensagem.bbcode_text = ""
	aux3 = 0
	texto = []
	aux1 = 0
	textoatual = ""
	animation = true

func textanimation(t,id,e,i,ip,f,fp):
	var nvnmnd = 0
	var idd = 0
	if $MenuMensagem/LabelMensagem.get_bbcode() == "":
		idd = id
	textplus = [e,i,ip,f,fp]
	if texto == []:
		for l in t:
			if nvnmnd == textplus[2]:
				texto.append(textplus[1])
				print("ué   ",textplus[1])
			if nvnmnd == textplus[4]:
				texto.append(textplus[3])
			texto.append(l)
			nvnmnd +=1
	
	aux1 +=1
	if aux1 >= 3:
		aux1 = 0
		if $sons/falaG.is_playing() == false or $sons/falaSabio.is_playing() == false:
			if pointer == "diálogo sábio":
				$sons/falaSabio.play()
			else:
				$sons/falaG.play()
	var xtnj = $MenuMensagem/LabelMensagem.get_bbcode()
	if aux3 < len(texto) and idd == id:
		
		$Timer.start(eventos["Config"]["velocidade"])
	else:
		print("acabou")
		textindex += 0.5
		animation = false
		if pointer == "diálogo lancer" and eventos["npcs"]["Lancer"] == true:
			var tdb = 0
			eventos["npcs"]["lancer"] = false
			for gnk in inv["guardado"]:
				if gnk == "Pique do Soldado":
					tdb +=1
			if tdb == 0 and inv["equipado"]["arma"][0] != "Pique do Soldado":
				inv["guardado"].append("Pique do Soldado") 
				$MenuMensagem/LabelMensagem.bbcode_text += "(ele te entrega uma lança)"


func endtext():
	$MenuMensagem.set_visible(false)
	$MenuMensagem/LabelMensagem.set_visible(false)
	$MenuMensagem/LabelMensagem.set_bbcode("")
	textindex = 0
	positivo = false
	movimento = true
	interacao = true
	pointer = "indefinido"
	permition = true
	


func escmenu():
	if voltar == true and pointer == "indefinido":
		pointer = "esc menu first"
		
			
		interacao = false
		movimento = false
		voltar = false 
		$escMenu.set_visible(true)
		$escMenu.set_animation("0")
	if pointer == "esc menu first":
		over = int($escMenu.get_animation())
		if over == 31:
			over = 3
		if over == 32:
			over = 4
		if Input.is_action_just_pressed("ui_down") and over < 4:
			if over <= 1 and over + 1 != 3:
				$escMenu.set_animation(str((int(over)+1)))
			else:
				if over == 2:
					$escMenu.set_animation("31")
				if over == 3:
					$escMenu.set_animation("32")
		if Input.is_action_just_pressed("ui_up") and over > 0:
			if over <= 2:
				$escMenu.set_animation(str((int(over)-1)))
			else:
				if over == 3:
					$escMenu.set_animation("2")
				if over == 4:
					$escMenu.set_animation("31")
		over = int($escMenu.get_animation())
		if over == 31:
			over = 3
		if over == 32:
			over = 4
		if positivo == true:
			positivo = false
			if over == 0 and pointer == "esc menu first":
				pointer = "item menu"
				$escMenu.set_animation("3")
			if over == 1 and pointer == "esc menu first":
				pointer = "status"
				$escMenu.set_animation("6")
				$escMenu/equipados.set_visible(true)
				$escMenu/guardados.set_visible(true)
				var t = "escMenu/guardados/" + str(-1)
				get_node(t).set_visible(true)
				if eventos["Tipo"] == "1":
					get_node(t).set_animation("Personagemf")
				else:
					get_node(t).set_animation("Personagem")
				$escMenu/equipados/RichTextLabel.set_visible(true)
				$escMenu/equipados/RichTextLabel.set_position(Vector2(-52,-79))
				$escMenu/equipados/RichTextLabel.bbcode_text = ""
				var nivel = 1
				for hjb in range(2,6):
					if eventos["boost"][str(hjb)] > 0:
						if hjb == 2:
							$"escMenu/guardados/4".set_visible(true)
							$"escMenu/guardados/4".play("agilidade")
						if hjb == 3:
							$"escMenu/guardados/5".set_visible(true)
							$"escMenu/guardados/5".play("defesa")
						if hjb == 4:
							$"escMenu/guardados/11".set_visible(true)
							$"escMenu/guardados/11".play("força")
						if hjb == 5:
							$"escMenu/guardados/17".set_visible(true)
							$"escMenu/guardados/17".play("mana")
				for ncx in nivelindex:
					if status["exp"] >= ncx:
						nivel += 1
				$escMenu/equipados/RichTextLabel.bbcode_text += "                    "
				$escMenu/equipados/RichTextLabel.bbcode_text += "nível"
				$escMenu/equipados/RichTextLabel.bbcode_text += ": "
				$escMenu/equipados/RichTextLabel.bbcode_text += str(nivel)
				$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
				for n in status:
					$escMenu/equipados/RichTextLabel.bbcode_text += "                    "
					$escMenu/equipados/RichTextLabel.bbcode_text += str(n)
					$escMenu/equipados/RichTextLabel.bbcode_text += ": "
					if n == "vida":
						$escMenu/equipados/RichTextLabel.bbcode_text += str(battle["vida_jogador"])
						$escMenu/equipados/RichTextLabel.bbcode_text += "/"
					if n == "mana":
						$escMenu/equipados/RichTextLabel.bbcode_text += str(battle["manaj"])
						$escMenu/equipados/RichTextLabel.bbcode_text += "/"
					$escMenu/equipados/RichTextLabel.bbcode_text += str(status[str(n)])
					if n == "exp":
						var prox = "5"
						for ghj in range(7):
							if status["exp"]>= nivelindex[ghj]:
								prox = nivelindex[ghj + 1]
						$escMenu/equipados/RichTextLabel.bbcode_text += " próx.("
						$escMenu/equipados/RichTextLabel.bbcode_text += str(prox)
						$escMenu/equipados/RichTextLabel.bbcode_text += ")"
					if n != "vida" and n != "mana"and n != "exp" and n != "moedas":
						$escMenu/equipados/RichTextLabel.bbcode_text += " + "
						var plus = 0
						for h in inv["equipado"]:
							if n == "defesa":
								plus += equipindex[str(inv["equipado"][h][1])][0]
							if n == "ataque":
								plus += equipindex[str(inv["equipado"][h][1])][1]
							if n == "agilidade":
								plus += equipindex[str(inv["equipado"][h][1])][2]
						$escMenu/equipados/RichTextLabel.bbcode_text += str(plus)
						$escMenu/equipados/RichTextLabel.bbcode_text += " ("
						$escMenu/equipados/RichTextLabel.bbcode_text += str(status[str(n)] + plus)
						$escMenu/equipados/RichTextLabel.bbcode_text += ")"
					$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
			if over == 2 and pointer == "esc menu first":
				pointer = "mapa"
				$escMenu.set_animation("30")
				var a = Vector2()
				var b = Vector2()
				b = $"./Camera2D".a
				a = Vector2(b.x +23 ,b.y - 32)
				$escMenu/Sprite.set_global_position(a)
				$escMenu/Sprite.set_visible(true)
				$escMenu/Objetivo.set_visible(true)
				if eventos["principal"] <= 3:
					$escMenu/Objetivo.set_global_position(Vector2(b.x +75 ,b.y - 26))
				if eventos["principal"] == 4:
					$escMenu/Objetivo.set_global_position(Vector2(b.x +23 ,b.y - 32))
				if eventos["Tipo"] == "1":
					$escMenu/Sprite.play("fmap")
					$escMenu/Sprite/AnimationPlayer.play("fmap")
				else:
					$escMenu/Sprite.play("map")
					$escMenu/Sprite/AnimationPlayer.play("map")
			
			if over == 3 and pointer == "esc menu first":
				pointer = "Configurations"
				$escMenu/Configurations.set_visible(true)
				over = 35
				$escMenu/Configurations/HSlider.grab_focus()
				$escMenu.set_animation("35")
			
			if over == 4 and pointer == "esc menu first":
				pointer = "Saindo"
				positivo = false
				over = 33
				$escMenu.set_animation("33")
	
	if pointer == "Configurations":
		over = int($escMenu.get_animation())
		if Input.is_action_just_pressed("ui_down") and over < 36:
			$escMenu.set_animation(str((int(over)+1)))
			if over == 36: 
				$escMenu/Configurations/HSlider.grab_focus()
				$escMenu/Configurations/RichTextLabel3.set_visible(false)
			else:
				$escMenu/Configurations/HSlider2.grab_focus()
				$escMenu/Configurations/RichTextLabel3.set_visible(true)
		if Input.is_action_just_pressed("ui_up") and over > 35:
			$escMenu.set_animation(str((int(over)-1)))
			if over == 36: 
				$escMenu/Configurations/HSlider.grab_focus()
				$escMenu/Configurations/RichTextLabel3.set_visible(false)
			else:
				$escMenu/Configurations/HSlider2.grab_focus()
				$escMenu/Configurations/RichTextLabel3.set_visible(true)
		if $Timer.is_stopped() == true and over == 36:
			$Timer.start(2)
		if voltar == true or positivo == true:
			voltar = false
			positivo = false
			eventos["Config"]["volume"] = $escMenu/Configurations/HSlider.get_value() -94
			eventos["Config"]["velocidade"] = $escMenu/Configurations/HSlider2.get_value() / 1000
			var file = File.new()
			var error = file.open(save_path, File.WRITE)
			save = {"p":1,"s":2,"t":3,"q":4,"qui":5,"sex":6}
			save["p"] = status
			save["s"] = pos
			save["t"] = colision
			save["q"] = battle
			save["qui"] = inv
			save["sex"] = eventos
			if error == OK:
				file.store_var(save)
				file.close()
			$escMenu/Configurations/RichTextLabel3.set_visible(false)
			$escMenu/Configurations.set_visible(false)
			$escMenu.set_animation("31")
			over = 3
			pointer = "esc menu first"
	
	if pointer == "Saindo":
		over = int($escMenu.get_animation())
		if Input.is_action_just_pressed("ui_down") and over < 34:
			$escMenu.set_animation(str((int(over)+1)))
		if Input.is_action_just_pressed("ui_up") and over > 33:
			$escMenu.set_animation(str((int(over)-1)))
		
		if positivo == true:
			positivo = false
			
			if over == 33:
				var file = File.new()
				var error = file.open(save_path, File.WRITE)
				if eventos["principal"] == 0:
					eventos["principal"] = 1
				save = {"p":1,"s":2,"t":3,"q":4,"qui":5,"sex":6}
				save["p"] = status
				save["s"] = pos
				save["t"] = colision
				save["q"] = battle
				save["qui"] = inv
				save["sex"] = eventos
				if error == OK:
					file.store_var(save)
					file.close()
				$escMenu.set_animation("32")
				over = 4
				pointer = "esc menu first"
			
			if over == 34:
				var file = File.new()
				var error = file.open(save_path, File.WRITE)
				if eventos["principal"] == 0:
					eventos["principal"] = 1
				save = {"p":1,"s":2,"t":3,"q":4,"qui":5,"sex":6}
				save["p"] = status
				save["s"] = pos
				save["t"] = colision
				save["q"] = battle
				save["qui"] = inv
				save["sex"] = eventos
				if error == OK:
					file.store_var(save)
					file.close()
				get_tree().change_scene("res://MenuPrincipal.tscn")
				
	if voltar == true and pointer == "mapa":
		voltar = false
		$escMenu.set_animation("2")
		$escMenu/guardados.set_visible(false)
		$escMenu/Sprite.set_visible(false)
		$escMenu/Objetivo.set_visible(false)
		$escMenu/Sprite.set_position(Vector2(-23,-59))
		$escMenu/Sprite.set_animation("default")
		$escMenu/Sprite/AnimationPlayer.play("select")
		hideall()
		$escMenu/Sprite.position = Vector2(-23,-59)
		$escMenu/equipados/RichTextLabel.set_position(Vector2(-52,-23))
		pointer = "esc menu first"
		$escMenu/Sprite.set_visible(false)
		$escMenu/equipados/RichTextLabel.set_visible(false)
	
	if voltar == true and pointer == "status":
		voltar = false
		$escMenu.set_animation("1")
		$escMenu/guardados.set_visible(false)
		hideall()
		$escMenu/Sprite.position = Vector2(-23,-59)
		$escMenu/equipados/RichTextLabel.set_position(Vector2(-52,-23))
		pointer = "esc menu first"
		$escMenu/Sprite.set_visible(false)
		$escMenu/equipados/RichTextLabel.set_visible(false)
	
	if pointer == "item menu":
		over =  int($escMenu.get_animation())
		if Input.is_action_just_pressed("ui_down") and over < 4:
			$escMenu.set_animation(str((int($escMenu.get_animation())+1)))
		if Input.is_action_just_pressed("ui_up") and over > 3:
			$escMenu.set_animation(str((int($escMenu.get_animation())-1)))
		if positivo == true:
			positivo = false
			if over == 3 and pointer == "item menu":
				pointer = "load items"
				$escMenu.set_animation("5")
				
			elif over == 4  and pointer == "item menu":
				
				$escMenu/equipados/capacete.set_visible(false)
				$escMenu/equipados/peitoral.set_visible(false)
				$escMenu/equipados/perneira.set_visible(false)
				$escMenu/equipados/botas.set_visible(false)
				$escMenu/equipados/arma.set_visible(false)
				$escMenu/equipados/escudo.set_visible(false)
				$escMenu/equipados/amuleto3.set_visible(false)
				$escMenu/equipados/amuleto4.set_visible(false)
				$escMenu.set_animation("6")
				pointer = "popular consumables"
	
	if pointer == "popular consumables":
		var carregar = 0
		var _naocarregar = 0
		
		$escMenu/Sprite.position = Vector2(-34,-69)
		$escMenu/equipados/RichTextLabel.bbcode_text = "\n\n\n +0 +0 +0"
		carregar = -1
		for n in inv["consumables"]:
			if inv["consumables"][n][0]  > 0:
				var t ="escMenu/guardados/" + str(carregar)
				$escMenu/guardados.set_visible(true)
				get_node(t).play(n)
				get_node(t).set_visible(true)
				t ="escMenu/mininumber/" + str(carregar)
				$escMenu/mininumber.set_visible(true)
				get_node(t).play(str(inv["consumables"][n][0]))
				get_node(t).set_visible(true)
				carregar += 1
					
		carregar += 6
		$escMenu.play(str(carregar))
		if int($escMenu.get_animation()) < 6:
			voltar = false
			$escMenu.set_animation("3")
			$escMenu/guardados.set_visible(false)
			hideall()
			$escMenu/Sprite.position = Vector2(-23,-59)
			$escMenu/Sprite.set_visible(false)
			$escMenu/equipados/RichTextLabel.set_visible(false)
			pointer = "item menu"
		else:
			pointer = "consumables troca"
		reset = false
		
	
	
	if pointer == "consumables troca":
		$escMenu/Sprite.set_visible(true)
		$escMenu/Sprite/AnimationPlayer.play("select")
		
		var g = ""
		if Input.is_action_just_pressed("ui_right") and $escMenu/Sprite.position.x < 61:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.x += 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_left") and $escMenu/Sprite.position.x > -23:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.x -= 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_up") and $escMenu/Sprite.position.y > -59:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.y -= 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_down") and $escMenu/Sprite.position.y < -20:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.y += 21
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		
		if $escMenu/Sprite.position == Vector2(-34,-69):
			sobtroca = $escMenu/Sprite.position
			reset = false
			for n in range(-1,22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
			$escMenu/equipados.set_visible(true)
			$escMenu/equipados/RichTextLabel.set_visible(true)
			if buscatroca != "":
				$escMenu/equipados/RichTextLabel.bbcode_text = str(buscatroca) + " : " + str(consumableindex[buscatroca][1])
		
		if reset == false and  $escMenu/Sprite.position != Vector2(-34,-69):
			reset = true
			$escMenu/equipados.set_visible(true)
			$escMenu/equipados/RichTextLabel.set_visible(true)
			if buscatroca != "":
				$escMenu/equipados/RichTextLabel.bbcode_text = str(buscatroca) + " : " + str(consumableindex[buscatroca][1])
	
	if positivo == true and pointer == "consumables troca":
		
		if buscatroca != "vazio":
			if consumableindex[buscatroca][0] == 0:
				battle["vida_jogador"] += consumableindex[buscatroca][2]
				if battle["vida_jogador"] > status["vida"]:
					battle["vida_jogador"] = status["vida"]
				inv["consumables"][buscatroca][0] -= 1
			
			if consumableindex[buscatroca][0] == 1:
				battle["manaj"] += consumableindex[buscatroca][2]
				if battle["manaj"] > status["mana"]:
					battle["manaj"] = status["mana"]
				inv["consumables"][buscatroca][0] -= 1
			
			if consumableindex[buscatroca][0] > 1:
				if eventos["boost"][str(consumableindex[buscatroca][0])] != 2:
					eventos["boost"][str(consumableindex[buscatroca][0])] = 2
					inv["consumables"][buscatroca][0] -= 1
			pointer = "popular consumables"
			hideall()
		else:
			var g = ""
			sobtroca = $escMenu/Sprite.position
			reset = false
			for n in range(22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
	
	if voltar == true and pointer == "consumables troca":
		voltar = false
		$escMenu.set_animation("3")
		$escMenu/guardados.set_visible(false)
		hideall()
		$escMenu/Sprite.position = Vector2(-23,-59)
		pointer = "item menu"
		$escMenu/Sprite.set_visible(false)
		$escMenu/equipados/RichTextLabel.set_visible(false)
	
	
	
	if pointer == "load items":
		positivo = false
		$escMenu/equipados/capacete.play(str(inv["equipado"]["capacete"][1]))
		$escMenu/equipados/peitoral.play(str(inv["equipado"]["peitoral"][1]))
		$escMenu/equipados/perneira.play(str(inv["equipado"]["perneiras"][1]))
		$escMenu/equipados/botas.play(str(inv["equipado"]["botas"][1]))
		$escMenu/equipados/arma.play(str(inv["equipado"]["arma"][1]))
		$escMenu/equipados/escudo.play(str(inv["equipado"]["escudo"][1]))
		$escMenu/equipados/amuleto3.play(str(inv["equipado"]["amuleto3"][1]))
		$escMenu/equipados/amuleto4.play(str(inv["equipado"]["amuleto4"][1]))
		$escMenu/equipados.set_visible(true)
		$escMenu/equipados/capacete.set_visible(true)
		$escMenu/equipados/peitoral.set_visible(true)
		$escMenu/equipados/perneira.set_visible(true)
		$escMenu/equipados/botas.set_visible(true)
		$escMenu/equipados/arma.set_visible(true)
		$escMenu/equipados/escudo.set_visible(true)
		$escMenu/equipados/amuleto3.set_visible(true)
		$escMenu/equipados/amuleto4.set_visible(true)
		$escMenu/equipados/RichTextLabel.set_visible(true)
		pointer = "equipamento menu"
		reset = false
	
	if pointer == "equipamento menu":
		
		$escMenu/Sprite.set_visible(true)
		$escMenu/Sprite/AnimationPlayer.play("select")
		if Input.is_action_just_pressed("ui_right") and $escMenu/Sprite.position.x < 61:
			$escMenu/Sprite.position.x += 28
			reset = false
		if Input.is_action_just_pressed("ui_left") and $escMenu/Sprite.position.x > -23:
			$escMenu/Sprite.position.x -= 28
			reset = false
		if Input.is_action_just_pressed("ui_up") and $escMenu/Sprite.position.y > -59:
			$escMenu/Sprite.position.y -= 28
			reset = false
		if Input.is_action_just_pressed("ui_down") and $escMenu/Sprite.position.y < -31:
			$escMenu/Sprite.position.y += 28
			reset = false
		if reset == false:
			reset = true
			busca = "capacete"
			if $escMenu/Sprite.position == $escMenu/equipados/peitoral.position:
				busca = "peitoral"
			if $escMenu/Sprite.position == $escMenu/equipados/perneira.position:
				busca = "perneiras"
			if $escMenu/Sprite.position == $escMenu/equipados/botas.position:
				busca = "botas"
			if $escMenu/Sprite.position == $escMenu/equipados/arma.position:
				busca = "arma"
			if $escMenu/Sprite.position == $escMenu/equipados/escudo.position:
				busca = "escudo"
			if $escMenu/Sprite.position == $escMenu/equipados/amuleto3.position:
				busca = "amuleto3"
			if $escMenu/Sprite.position == $escMenu/equipados/amuleto4.position:
				busca = "amuleto4"
			$escMenu/equipados/RichTextLabel.bbcode_text = (str(str(inv["equipado"][str(busca)][1]),"\n"))
			if equipindex[inv["equipado"][str(busca)][1]][0] != 0:
				$escMenu/equipados/RichTextLabel.bbcode_text += (str("[color=#37325e]def[/color]:",equipindex[inv["equipado"][str(busca)][1]][0],"  "))
			if equipindex[inv["equipado"][str(busca)][1]][1] != 0:
				$escMenu/equipados/RichTextLabel.bbcode_text += (str("[color=#5e3232]atq[/color]:",equipindex[inv["equipado"][str(busca)][1]][1],"  "))
			if equipindex[inv["equipado"][str(busca)][1]][2] != 0:
				$escMenu/equipados/RichTextLabel.bbcode_text += (str("[color=#375e32]vel[/color]:",equipindex[inv["equipado"][str(busca)][1]][2],"  "))
			$escMenu/equipados/RichTextLabel.bbcode_text += "\n"
			$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[inv["equipado"][str(busca)][1]][3])
		if positivo == true and pointer == "equipamento menu":
			positivo = false
			pointer = "popular"
			$escMenu/equipados/capacete.set_visible(false)
			$escMenu/equipados/peitoral.set_visible(false)
			$escMenu/equipados/perneira.set_visible(false)
			$escMenu/equipados/botas.set_visible(false)
			$escMenu/equipados/arma.set_visible(false)
			$escMenu/equipados/escudo.set_visible(false)
			$escMenu/equipados/amuleto3.set_visible(false)
			$escMenu/equipados/amuleto4.set_visible(false)
			$escMenu.set_animation("6")
		
	if pointer == "popular":
		var carregar = 0
		var naocarregar = 0
		
		$escMenu/Sprite.position = Vector2(-34,-69)
		$escMenu/equipados/RichTextLabel.bbcode_text = "\n\n\n +0 +0 +0"
		for n in inv["guardado"]:
			var ammm = "amuleto"
			if equipindex[n][4] in ammm:
				if not equipindex[n][4] in busca:
					carregar += 1
					naocarregar+=1
				if equipindex[n][4] in busca:
						
						
					var t ="escMenu/guardados/" + str(carregar - naocarregar)
					
						
					get_node(t).play(str(inv["guardado"][int(carregar)]))
					$escMenu/guardados.set_visible(true)
					get_node(t).set_visible(true)
					carregar += 1
			else:
				if equipindex[n][4] != busca:
					carregar += 1
					naocarregar+=1
				if equipindex[n][4] == busca:
						
						
					var t ="escMenu/guardados/" + str(carregar - naocarregar)
					
						
					get_node(t).play(str(inv["guardado"][int(carregar)]))
					$escMenu/guardados.set_visible(true)
					get_node(t).set_visible(true)
					carregar += 1
					
		carregar += 6
		$escMenu.play(str(carregar - naocarregar))
		
		pointer = "menu troca"
	
	
	if pointer == "menu troca":
		$escMenu/Sprite.set_visible(true)
		$escMenu/Sprite/AnimationPlayer.play("select")
		var g = ""
		if Input.is_action_just_pressed("ui_right") and $escMenu/Sprite.position.x < 61:
			
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.x += 21
			reset = false
			for n in range(22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_left") and $escMenu/Sprite.position.x > -23:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.x -= 21
			reset = false
			for n in range(22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_up") and $escMenu/Sprite.position.y > -59:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.y -= 21
			reset = false
			for n in range(22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		if Input.is_action_just_pressed("ui_down") and $escMenu/Sprite.position.y < -20:
			sobtroca = $escMenu/Sprite.position
			$escMenu/Sprite.position.y += 21
			reset = false
			for n in range(22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		
		if $escMenu/Sprite.position == Vector2(-34,-69):
				$escMenu/equipados/RichTextLabel.bbcode_text = "\n\n\nDesequipar equipamento."
		
		if reset == false and $escMenu/Sprite.position != Vector2(-34,-69):
			reset = true
			var h = ""
			for n in inv["guardado"]:
				if h == n:
					inv["guardado"].erase(n)
				h = n
			$escMenu/equipados/RichTextLabel.bbcode_text = "\n\n"
			$escMenu/equipados/RichTextLabel.bbcode_text += buscatroca + "\n "
			$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#37325e]def[/color]:"
			if equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0] >= 0:
				$escMenu/equipados/RichTextLabel.bbcode_text += "+"
			$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][0] - equipindex[inv["equipado"][busca][1]][0]," ")
				
			$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#5e3232]atq[/color]:"
			if equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1] >= 0:
				$escMenu/equipados/RichTextLabel.bbcode_text += "+"
			$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][1] - equipindex[inv["equipado"][busca][1]][1]," ")
				
			$escMenu/equipados/RichTextLabel.bbcode_text += "[color=#375e32]vel[/color]:"
			if equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2] >= 0:
				$escMenu/equipados/RichTextLabel.bbcode_text += "+"
			$escMenu/equipados/RichTextLabel.bbcode_text += str(equipindex[buscatroca][2] - equipindex[inv["equipado"][busca][1]][2])
			reset = true
	
	if positivo == true and pointer == "menu troca":
		if buscatroca != "vazio":
			if $escMenu/Sprite.position == Vector2(-34,-69):
				if inv["equipado"][busca][1] != "vazio":
					inv["guardado"].append(str(inv["equipado"][busca][1]))
					inv["equipado"][busca][1] = "vazio"
			if $escMenu/Sprite.position != Vector2(-34,-69):
				
				inv["guardado"].append(str(inv["equipado"][busca][1]))
				inv["equipado"][busca][1] = buscatroca
				inv["guardado"].erase(buscatroca)
			$escMenu.set_animation("5")
			$escMenu/guardados.set_visible(false)
			hideall()
			if busca == "perneiras":
				busca = "perneira"
			var g = "escMenu/equipados/" + busca
			$escMenu/Sprite.position = get_node(g).position
			pointer = "load items"
		else:
			if $escMenu/Sprite.position == Vector2(-34,-69):
				if inv["equipado"][busca][1] != "vazio":
					inv["guardado"].append(str(inv["equipado"][busca][1]))
					inv["equipado"][busca][1] = "vazio"
					$escMenu.set_animation("5")
					$escMenu/guardados.set_visible(false)
					hideall()
					if busca == "perneiras":
						busca = "perneira"
					var g = "escMenu/equipados/" + busca
					$escMenu/Sprite.position = get_node(g).position
					pointer = "load items"
			var g = ""
			sobtroca = $escMenu/Sprite.position
			reset = false
			for n in range(22):
				g = "escMenu/guardados/" + str(n)
				if get_node(g).get_position() == $escMenu/Sprite.get_position():
					buscatroca = get_node(g).get_animation()
					limiter =  get_node(g).is_visible()
			if  limiter == false and $escMenu/Sprite.position != Vector2(-34,-69):
				reset = true
				$escMenu/Sprite.position = sobtroca
		
	
	if voltar == true and pointer == "menu troca":
		voltar = false
		$escMenu.set_animation("5")
		$escMenu/guardados.set_visible(false)
		hideall()
		if busca == "perneiras":
			busca = "perneira"
		var g = "escMenu/equipados/" + busca
		$escMenu/Sprite.position = get_node(g).position
		pointer = "load items"
		
	if voltar == true and pointer == "equipamento menu":
		pointer ="item menu"
		$escMenu/Sprite.set_visible(false)
		$escMenu.set_animation("3")
		voltar = false
		$escMenu/equipados/capacete.set_visible(false)
		$escMenu/equipados/peitoral.set_visible(false)
		$escMenu/equipados/perneira.set_visible(false)
		$escMenu/equipados/botas.set_visible(false)
		$escMenu/equipados/arma.set_visible(false)
		$escMenu/equipados/escudo.set_visible(false)
		$escMenu/equipados/amuleto3.set_visible(false)
		$escMenu/equipados/amuleto4.set_visible(false)
		$escMenu/equipados/RichTextLabel.set_visible(false)
		
	if voltar == true and pointer == "item menu":
		pointer = "esc menu first"
		$escMenu.set_animation("0")
		voltar = false
		
	if voltar == true and pointer == "esc menu first":
		pointer = "indefinido"
		$escMenu.set_visible(false)
		interacao = true
		movimento = true
		voltar = false


func som():
	if $sons/Caminha.is_stopped() == true and movendo == true and movimento == true:
		$sons/caminhagrama.play()
		if correndo == true:
			$sons/Caminha.start(0.2)
		else:
			$sons/Caminha.start(0.4)
		print("som")

func _physics_process(delta):
	som()
	olhando = $"../NemoU".olhando
	print(pointer)
	ready()
	continuar()
	bumper(direcao)
	get_input()
	if switchh == 7 and Input.is_action_just_pressed("ui_accept"):
		switchh = 1
		force = true
	var _perspos = position
	get_animation()
	interact()
	escmenu()
	if movimento == true:
		if Input.is_action_pressed("ui_run"):
			velocity = move_and_slide(velocity * delta * 30)
			correndo = true
			$AnimatedSprite.set_speed_scale(2)
		else:
			velocity = move_and_slide(velocity * delta * 10)
			correndo = false
			$AnimatedSprite.set_speed_scale(1)
	if $MenuMensagem/LabelMensagem.is_visible() == false:
		animation = false
		


func hideall():
	get_node("escMenu/guardados/-1").set_visible(false)
	get_node("escMenu/guardados/0").set_visible(false)
	get_node("escMenu/guardados/1").set_visible(false)
	get_node("escMenu/guardados/2").set_visible(false)
	get_node("escMenu/guardados/3").set_visible(false)
	get_node("escMenu/guardados/4").set_visible(false)
	get_node("escMenu/guardados/5").set_visible(false)
	get_node("escMenu/guardados/6").set_visible(false)
	get_node("escMenu/guardados/7").set_visible(false)
	get_node("escMenu/guardados/8").set_visible(false)
	get_node("escMenu/guardados/9").set_visible(false)
	get_node("escMenu/guardados/10").set_visible(false)
	get_node("escMenu/guardados/11").set_visible(false)
	get_node("escMenu/guardados/12").set_visible(false)
	get_node("escMenu/guardados/13").set_visible(false)
	get_node("escMenu/guardados/14").set_visible(false)
	get_node("escMenu/guardados/15").set_visible(false)
	get_node("escMenu/guardados/16").set_visible(false)
	get_node("escMenu/guardados/17").set_visible(false)
	get_node("escMenu/guardados/18").set_visible(false)
	get_node("escMenu/guardados/19").set_visible(false)
	get_node("escMenu/guardados/20").set_visible(false)
	get_node("escMenu/guardados/21").set_visible(false)
	get_node("escMenu/guardados/22").set_visible(false)
	
	get_node("escMenu/guardados/-1").play("vazio")
	get_node("escMenu/guardados/0").play("vazio")
	get_node("escMenu/guardados/1").play("vazio")
	get_node("escMenu/guardados/2").play("vazio")
	get_node("escMenu/guardados/3").play("vazio")
	get_node("escMenu/guardados/4").play("vazio")
	get_node("escMenu/guardados/5").play("vazio")
	get_node("escMenu/guardados/6").play("vazio")
	get_node("escMenu/guardados/7").play("vazio")
	get_node("escMenu/guardados/8").play("vazio")
	get_node("escMenu/guardados/9").play("vazio")
	get_node("escMenu/guardados/10").play("vazio")
	get_node("escMenu/guardados/11").play("vazio")
	get_node("escMenu/guardados/12").play("vazio")
	get_node("escMenu/guardados/13").play("vazio")
	get_node("escMenu/guardados/14").play("vazio")
	get_node("escMenu/guardados/15").play("vazio")
	get_node("escMenu/guardados/16").play("vazio")
	get_node("escMenu/guardados/17").play("vazio")
	get_node("escMenu/guardados/18").play("vazio")
	get_node("escMenu/guardados/19").play("vazio")
	get_node("escMenu/guardados/20").play("vazio")
	get_node("escMenu/guardados/21").play("vazio")
	get_node("escMenu/guardados/22").play("vazio")
	
	get_node("escMenu/mininumber/-1").set_visible(false)
	get_node("escMenu/mininumber/0").set_visible(false)
	get_node("escMenu/mininumber/1").set_visible(false)
	get_node("escMenu/mininumber/2").set_visible(false)
	get_node("escMenu/mininumber/3").set_visible(false)
	get_node("escMenu/mininumber/4").set_visible(false)
	get_node("escMenu/mininumber/5").set_visible(false)
	get_node("escMenu/mininumber/6").set_visible(false)
	get_node("escMenu/mininumber/7").set_visible(false)
	get_node("escMenu/mininumber/8").set_visible(false)
	get_node("escMenu/mininumber/9").set_visible(false)
	get_node("escMenu/mininumber/10").set_visible(false)
	get_node("escMenu/mininumber/11").set_visible(false)
	get_node("escMenu/mininumber/12").set_visible(false)
	get_node("escMenu/mininumber/13").set_visible(false)
	get_node("escMenu/mininumber/14").set_visible(false)
	get_node("escMenu/mininumber/15").set_visible(false)
	get_node("escMenu/mininumber/16").set_visible(false)
	get_node("escMenu/mininumber/17").set_visible(false)
	get_node("escMenu/mininumber/18").set_visible(false)
	get_node("escMenu/mininumber/19").set_visible(false)
	get_node("escMenu/mininumber/20").set_visible(false)
	get_node("escMenu/mininumber/21").set_visible(false)
	get_node("escMenu/mininumber/22").set_visible(false)

func _on_Exit_body_entered(body):
	if body.get_name() == "personagemunida":
		go("Mundo")
		

func subirnivel():
	# vida:     10, 12, 20, 30, 40, 50, 60
	# mana:      5, 10, 15, 20, 30, 35, 40
	# ataque:    1,  2,  4,  6,  8, 10, 12
	# defesa:    2,  4,  6,  8, 10, 12, 14
	# agilidade: 1,  3,  5,  7,  9, 11, 13
	if status["exp"] >= nivelindex[1]:
		status["vida"] = 12
		status["mana"] = 10
		status["ataque"] = 2
		status["defesa"] = 4
		status["agilidade"] = 3

		
	if status["exp"] >= nivelindex[2]:
		status["vida"] = 20
		status["mana"] = 15
		status["ataque"] = 4
		status["defesa"] = 6
		status["agilidade"] = 5

		
	if status["exp"] >= nivelindex[3]:
		status["vida"] = 30
		status["mana"] = 20
		status["ataque"] = 6
		status["defesa"] = 8
		status["agilidade"] = 7

		
	if status["exp"] >= nivelindex[4]:
		status["vida"] = 40
		status["mana"] = 30
		status["ataque"] = 8
		status["defesa"] = 10
		status["agilidade"] = 9

		
	if status["exp"] >= nivelindex[5]:
		status["vida"] = 50
		status["mana"] = 35
		status["ataque"] = 10
		status["defesa"] = 12
		status["agilidade"] = 11

		
	if status["exp"] >= nivelindex[6]:
		status["vida"] = 60
		status["mana"] = 40
		status["ataque"] = 12
		status["defesa"] = 14
		status["agilidade"] = 13

		
		

func go(to):
	var file = File.new()
	colision = false
	var error = file.open(save_path, File.WRITE)
	if to == "Mundo":
			pos = [-918, 550]
	if eventos["principal"] == 0:
		eventos["principal"] = 1
	save = {"p":1,"s":2,"t":3,"q":4,"qui":5,"sex":6}
	save["p"] = status
	save["s"] = pos
	save["t"] = colision
	save["q"] = battle
	save["qui"] = inv
	save["sex"] = eventos
	if error == OK:
		file.store_var(save)
		file.close()
	get_tree().change_scene("res://"+ to +".tscn")


func _on_Timer_timeout():
	if aux3 < len(texto) and animation == true:
		textoatual = ""
		$MenuMensagem/LabelMensagem.bbcode_text += texto[aux3]
		aux3 +=1
		textanimation(texto,idd,textplus[0],textplus[1],textplus[2],textplus[3],textplus[4])


func _on_Exit2_body_entered(body):
	if body.get_name() == "personagemunida":
		go("Mundo")
