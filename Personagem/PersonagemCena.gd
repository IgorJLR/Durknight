extends KinematicBody2D

# 1 EVENTO A MUDAR

export (int) var speed = 200

var save_path = "user://save.dat"

var godmode = false
var velocity = Vector2()
var movendo = false
var skip = 0
var fim = false
var debuff = 0
var timerBatalha = randi() % 81 + 10
var batalha = false
var cima = false
var fin = 0
var baixo = false
var esquerda = false
var direita = false
var rei = false
var aceito = false
var positivo = false
var textplus = [true,"",0,"",0]
var texto = []
var aux1 = 0
var aux2 = 0
var aux3 = 0
var idd = 0
var textindex = 0
var animation = false
var textoatual = ""
var cancelar = false
var blocker = false
var block = false
var batata = 1
var menorx = 0.0
var menory = 0.0
var dif = 100000
var mdif = 0
var colision = false
var voltar = false
var interacao = true
var movimento = true
var over = 0
var reset = false
var limiter = true
var busca = ""

var buscatroca = ""
var sobtroca = ""
var cutscene = false
var pointer = "indefinido"
var pos = [602,102]

var nivelindex = [5, 30, 100, 300, 400, 500, 600]

var eventos = {"Nome":"","Tipo":"","Checkpoint":"Cidade Principal","Config":{"velocidade":0.05,"volume":-20},"principal":0,"boost":{"2":0,"3":0,"4":0,"5":0},"loot":{"bau real":true,"lootCasa1":true,"lootCasa2":true,"lootCasa3":true,"lootDeserto1":true,"lootmundo1":true},"npcs":{"Lancer":false,"Sábio":false,"Diabrete":true,"CD":true}}

var statusInimigos = {
	
	"cobra":{"vida":8,"ataque":1,"defesa":0,"agilidade":0,"exp":5, "ataques": {"0":["bote",1,3], "1":["ameaçar", -1,1]}, "padrão":[[0,80,1,0],[81,100,0,0]]},
	
	"slime":{"vida":6,"ataque":1,"defesa":1,"agilidade":1,"exp":6,"ataques": {"0":["pancada",1,4], "1":["ácido", 3, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Siri do Campo":{"vida":14,"ataque":1,"defesa":1,"agilidade":1,"exp":5,"ataques": {"0":["arranhão",1,2], "1":["arranhão", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Lobo Solitário":{"vida":6,"ataque":2,"defesa":6,"agilidade":4,"exp":15,"ataques": {"0":["mordida",4,4], "1":["investida", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Morcego":{"vida":12,"ataque":2,"defesa":1,"agilidade":8,"exp":12,"ataques": {"0":["sucção",3,4], "1":["absorver", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Mini Morcego":{"vida":4,"ataque":10,"defesa":0,"agilidade":16,"exp":5,"ataques": {"0":["dentada",10,4], "1":["dentada", 8, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Minhoca":{"vida":30,"ataque":2,"defesa":6,"agilidade":10,"exp":22,"ataques": {"0":["mergulho",1,4], "1":["cuspe arenoso", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Siri do Deserto":{"vida":10,"ataque":2,"defesa":1,"agilidade":1,"exp":8,"ataques": {"0":["arranhão",1,2], "1":["arranhão", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Naja":{"vida":20,"ataque":2,"defesa":1,"agilidade":1,"exp":15,"ataques": {"0":["bote",1,2], "1":["chicote", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Siri da Floresta":{"vida":10,"ataque":2,"defesa":1,"agilidade":1,"exp":8,"ataques": {"0":["arranhão",1,2], "1":["arranhão", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Fustel":{"vida":80,"ataque":2,"defesa":1,"agilidade":10,"exp":5,"ataques": {"0":["gelosfera",1,2], "1":["tremor", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Yeti":{"vida":100,"ataque":4,"defesa":10,"agilidade":1,"exp":5,"ataques": {"0":["grunhido",1,2], "1":["soco", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]]},
	
	"Diabrete":{"vida":3,"ataque":1,"defesa":1,"agilidade":1,"exp":10,"ataques": {"0":["tapa",1,4], "1":["podridão", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]],"texto inicial":["HAHAHA esses humanos imbecis não sabem de","nada, como são inocentes HAHAHA (ele olha para você)","O QUE VOCÊ ESTÁ FAZENDO AÍ! MORRA!!! "], "texto final":["","CALMA! Não me mate por favor, eu te conto tudo,","não foi um humano que matou seu rei,", "foi um demônio mandado pelo rei demônio,", "o plano dele é fazer vocês humanos brigarem entre", "si para que ele possa dominar o reino.", "(ele se aproveita da sua surpresa e foge correndo,","é melhor você voltar e contar a todos)"]},
	
	"Caverna":{"vida":0,"ataque":1,"defesa":1,"agilidade":1,"exp":10,"ataques": {"0":["tapa",1,4], "1":["podridão", 2, 1]},"padrão":[[0,90,0,1],[91,100,1,1]],"texto inicial":["QUAL É A SENHA?"], "texto final":["","VOCÊ NÃO PODERÁ PASSAR","MUITO BEM, VOCÊ PODE PASSAR"]},
	
	"Capitão Przymus":{"vida":60,"ataque":5,"defesa":1,"agilidade":17,"exp":40,"ataques": {"0":["Flamígera",4,4], "1":["Fogosfera", 5, 5]},"padrão":[[0,90,0,1],[91,100,1,1]],"texto inicial":["Patético!!!","Você acha que deixaremos você acabar","com tudo assim tão fácil! HAHAHAA!!!","Eu sou Przymus e irei te destruir."], "texto final":["","Droga! Como você ficou tão forte...","(O Capitão Demônio morre e você obtem um","pergaminho intitulado 'União Eterna dos", "Magos de Gelo' leve até oeste no bioma de gelo.)"]},
	
	"Mago de Gelo":{"vida":360,"ataque":2,"defesa":1,"agilidade":17,"exp":40,"ataques": {"0":["gelo",1,1], "1":["tranformar", 8, 5]},"padrão":[[0,90,0,1],[91,100,1,1]],"texto inicial":["Você não vai passar!!!","Esse pergaminho não vale mais nada","vou te ensinar a não se meter onde não deve!"], "texto final":["","Droga! Como você ficou tão forte...","(O Capitão Demônio morre e você obtem um","pergaminho intitulado 'União Eterna dos", "Magos de Gelo' leve até oeste no bioma de gelo.)"]},
	
	"Rei Demônio":{"vida":400,"ataque":3,"defesa":1,"agilidade":17,"exp":40,"ataques": {"0":["Anomia",4,4], "1":["Domíno", 5, 5]},"padrão":[[0,90,0,1],[91,100,1,1]],"texto inicial":["QUE PATÉTICO! LOGO VOCÊ E TODOS OS QUE AMA","IRÃO MORRER! HAHAHAA!!!"], "texto final":["","MPOSSÍVEL!!! COMO UM MERO HUMANO ","PODE ME DERROTAR AAAHHH!!!"]},
	
	"Slime Corrompido":{"vida":1000,"ataque":200,"defesa":1,"agilidade":1,"exp":8,"ataques": {"0":["morte",1000,2000], "1":["bug", 2000, 1000]},"padrão":[[0,90,0,1],[91,100,1,1]]}
	
}

var status = {"vida":10, "mana":5, "ataque":1, "defesa":2, "agilidade":1, "exp": 0, "moedas":100}

# vida: 10, 12, 20, 30, 40, 50, 60
# mana: 5, 10, 15, 20, 30, 35, 40
# ataque: 1, 2, 4, 6, 8, 10, 12
# defesa: 2, 4, 6, 8, 10, 12, 14
# agilidade: 1, 3, 5, 7, 9, 11, 13
# aplicados com a função subirnivel()


# Proporções do mapa:
#a = Vector2((b.x /36) +48 ,(b.y /32) - 44 )

var ataques = {
	"1": ["dividir",0, true, -53,10], 
	"2":["esmagar",2,false, -16, 10],
	"3":["chama",5,false, 38, 10],
	"4":["raio",5,false, -53, 24],
	"5":["gelo",5,false, -25,24],
	"6":["vaco",10,false, 2, 24],
	"7":["bigbang",40,false, 34, 24] #se for mudar o nome, tem funções que usam esse nome, ataque()
	}
#>dividir >esmagar >chama >raio >gelo >vaco >bigbang

var area = {"cena":"Campos Verdes", "inimigo":"indefinido"}

var battle = {"turno":1, "vez": "indefinido","pointer": "indefinido", "ação":"indefinido", "ataquesdisp": "indefinido", "ataque":"indefinido", "vida_inimigo": 1, "vida_jogador":10, "manaj":5, "ataque inimigo": "indefinido", "dano inimigo": 0, "inimigo_queue":2}

var inv = {"equipado":{"capacete":["capacete","vazio"],"peitoral":["peitoral","vazio"],"perneiras":["perneiras","vazio"],"botas":["botas","vazio"],"arma":["arma","vazio"],"escudo":["escudo","vazio"],"amuleto3":["amuleto3","vazio"],"amuleto4":["amuleto4","vazio"]},
"guardado":[],
"consumables":{"Poção de Vida Pequena":[1],"Poção de Vida Média":[1],"Poção de Vida Grande":[1],"Poção de Mana Pequena":[1],"Poção de Mana Média":[1],"Poção de Mana Grande":[1],"Maçã Verde":[1]}
}

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
var c = true

signal Loaded

signal terreno
#para detectar o terreno que está emit_signal("terreno")
var save = []

func ready():

	if c == true:
		$Efeitos.set_visible(false)
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
				$".".position.x = pos[0]
				$".".position.y = pos[1]
				$Camera2D.zoom = Vector2(0.2, 0.2)
				colision = false
					
		$escMenu/Configurations.set_visible(true)
		$escMenu/Configurations/HSlider2.set_value(eventos["Config"]["velocidade"] * 1000)
		$escMenu/Configurations/HSlider.set_value(eventos["Config"]["volume"] + 94)
		$escMenu/Configurations.set_visible(false)
		subirnivel()
		$sons2/musica.play()
		emit_signal("Loaded")


func get_input():
	
	velocity = Vector2()
	if Input.is_action_just_pressed("god_mode"):
		if godmode == true:
			godmode = false
			$godmode.set_visible(false)
		else:
			godmode = true
			$godmode.set_visible(true)
	if Input.is_action_just_pressed("ui_cancel"):
		voltar = true
	else:
		voltar = false
	if Input.is_action_just_pressed("ui_accept"):
		aceito = true
		positivo = true
	else:
		aceito = false
		positivo = false
	if pointer == "indefinido":
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
			movendo = true
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			movendo = true
		elif Input.is_action_pressed("ui_down"):
			velocity.y += 1
			movendo = true
		elif Input.is_action_pressed("ui_up"):
			velocity.y -= 1
			movendo = true
		else:
			if fim == false:
				movendo = false
		velocity = velocity.normalized() * speed
	
func battle_input():
	if Input.is_action_just_pressed("ui_up"):
		cima = true
	else:
		cima = false
	if Input.is_action_just_pressed("ui_down"):
		baixo = true
	else:
		baixo = false
	if Input.is_action_just_pressed("ui_left"):
		esquerda = true
	else:
		esquerda = false
	if Input.is_action_just_pressed("ui_right"):
		direita = true
	else:
		direita = false
		
	if Input.is_action_just_pressed("ui_accept"):
		aceito = true
	else:
		aceito = false
		
	if Input.is_action_just_pressed("ui_cancel"):
		cancelar = true
		voltar = true
	else:
		cancelar = false
		voltar = false
	
func set_animation():
	if movendo == true or fim == true:
		if eventos["Tipo"] == "1":
			$AnimatedSprite.play('fa')
		else:
			$AnimatedSprite.play('default')
	else:
		if eventos["Tipo"] == "1":
			$AnimatedSprite.play('f')
		else:
			$AnimatedSprite.play('New Anim')
		
func battle_call(random):
	if movendo == true and colision == false and blocker == false:
		if eventos["principal"] != 2 :
			if fim == false:
				timerBatalha -= 0.1
		else:
			if $".".position.x > 718 and $".".position.y < -94 and $".".position.y > -145:
				timerBatalha -= 0.5
			else:
				if fim == false:
					timerBatalha -= 0.1
		emit_signal("terreno")
	if timerBatalha < 0.1:
		if eventos["principal"] == 2 and area["inimigo"] == "Diabrete":
			cutscene = true
			batalha = true
			$sons2/musica.set_stream_paused(true)
			
			timerBatalha = random
		else:
			timerBatalha = random
			$sons2/musica.set_stream_paused(true) 
			if eventos["principal"] != 2 :
				$sons2/batalha.set_stream_paused(false)
				$sons2/batalha.stop()
				$sons2/batalha.play()
			batalha = true

func input_action():
	if battle["pointer"] == "esperando" and cutscene == false:
		if cima == true and batata >= 2 and area["inimigo"] != "Caverna" or esquerda == true and batata > 4 and area["inimigo"] == "Caverna" and eventos["principal"] != 6 or eventos["principal"] == 6 and area["inimigo"] == "Caverna" and esquerda == true and batata > 7:
			batata -= 1
			$acao.play(str(batata))
		if baixo == true and batata <= 2 and area["inimigo"] != "Caverna" or direita == true and batata <= 5 and area["inimigo"] == "Caverna" and eventos["principal"] != 6 or eventos["principal"] == 6 and direita == true and batata <= 8 and area["inimigo"] == "Caverna":
			batata +=1
			$acao.play(str(batata))
		
func battle_choose():
	if battle["pointer"] == "indefinido":
		if area["inimigo"] != "indefinido":
			return
		area["cena"] = get_node("../Cidade Principal").terreno
		if area["cena"] == "Campos Verdes":
			area["inimigo"] = randi() % 2
			if area["inimigo"] == 0:
				area["inimigo"] = "cobra"
				$Inimigo.play("cobra")
			else:
				area["inimigo"] = "slime"
				$Inimigo.play("slime")
		
		if area["cena"] == "Floresta":
			area["inimigo"] = randi() % 3
			if area["inimigo"] == 0:
				area["inimigo"] = "Lobo Solitário"
				$Inimigo.play("Lobo Solitário")
			elif area["inimigo"] == 1:
				area["inimigo"] = "Mini Morcego"
				$Inimigo.play("Mini Morcego")
			else:
				area["inimigo"] = "Morcego"
				$Inimigo.play("Morcego")
		
		if area["cena"] == "praia":
			area["inimigo"] = randi() % 2
			if area["inimigo"] == 0:
				area["inimigo"] = "slime"
				$Inimigo.play("slime")
			else:
				area["inimigo"] = "Siri do Campo"
				$Inimigo.play("Siri do Campo")
		
		if area["cena"] == "terra gelo":
			area["inimigo"] = randi() % 2
			if area["inimigo"] == 0:
				area["inimigo"] = "Fustel"
				$Inimigo.play("Fustel")
			else:
				area["inimigo"] = "Yeti"
				$Inimigo.play("Yeti")
		
		if area["cena"] == "praia floresta":
			area["inimigo"] = "Siri da Floresta"
			$Inimigo.play("Siri da Floresta")
			
		if area["cena"] == "terra corrompida" or area["cena"] == "praia corrompida":
			area["inimigo"] = "Slime Corrompido"
			$Inimigo.play("Slime Corrompido")
		
		if area["cena"] == "deserto":
			area["inimigo"] = randi() % 3
			if area["inimigo"] == 0:
				area["inimigo"] = "Minhoca"
				$Inimigo.play("Minhoca")
			elif area["inimigo"] == 1:
				area["inimigo"] = "Siri do Deserto"
				$Inimigo.play("Siri do Deserto")
			else:
				area["inimigo"] = "Naja"
				$Inimigo.play("Naja")
		
		if eventos["principal"] == 2 and $".".position.x > 718 and $".".position.y < -94 and $".".position.y > -145 and area["inimigo"] != "Diabrete":
				area["inimigo"] = "Diabrete"
				$Inimigo.play("Diabrete")
				cutscene = true

		if area["cena"] == "deserto" and cutscene == true:
			
			$FundoBatalha.play("Caverna")
			if eventos["principal"] < 7:
				$Inimigo.play("Caverna")
				$LabelMensagem.set_bbcode("Você escuta uma voz vinda da caverna...")
				area["inimigo"] = "Caverna"
				$FundoBatalha.play("Caverna")
			else:
				$Inimigo.play("Capitão Przymus surge", true)
				
				$LabelMensagem.set_bbcode("Você escuta uma voz vinda da caverna...")
				area["inimigo"] = "Capitão Przymus"
				$Inimigo.play("Capitão Przymus surge", true)
				CDOne()
				
		if area["cena"] == "terra gelo" and cutscene == true:
			
			$FundoBatalha.play("terra gelo")
			if eventos["principal"] <= 7:
				$Inimigo.play("Mago de Gelo")
				$LabelMensagem.set_bbcode("Você escuta uma voz vinda da caverna...")
				area["inimigo"] = "Mago de Gelo"
			else:
				$Inimigo.play("Mago de Gelo")
				$LabelMensagem.set_bbcode("Você escuta uma voz vinda da caverna...")
				area["inimigo"] = "Mago de Gelo"
				$Inimigo.play("Mago de Gelo")
		
		if rei == true:
			$FundoBatalha.play("Castelo")
			$Inimigo.play("Rei Demônio sorri")
			$LabelMensagem.set_bbcode("")
			area["inimigo"] = "Rei Demônio"
		else:
			if area["inimigo"] != "Caverna" and area["inimigo"] != "Capitão Przymus":
				$FundoBatalha.play(area["cena"])
			else:
				$FundoBatalha.play("Caverna")
		battle["vida_inimigo"] = statusInimigos[str(area["inimigo"])]["vida"]
		$VidaInimigo.max_value = battle["vida_inimigo"]
		$VidaPersonagem.max_value = status["vida"]
		$ManaPersonagem.max_value = status["mana"]
		$VidaInimigo.value = battle["vida_inimigo"]
		if cutscene == false:
			$LabelMensagem.set_text("Um(a) " + area["inimigo"] + " apareceu!")
			$VidaInimigo.set_visible(true)
			$VidaPersonagem.set_visible(true)
			$ManaPersonagem.set_visible(true)
			
		else:
			if area["inimigo"] == "Diabrete":
				$LabelMensagem.set_text(statusInimigos[area["inimigo"]]["texto inicial"][0])
				textprep()
				textanimation(statusInimigos[area["inimigo"]]["texto inicial"][0],0,true,"",0,"",0)
			if area["inimigo"] == "Caverna":
				$LabelMensagem.set_text(statusInimigos[area["inimigo"]]["texto inicial"][0])
				textprep()
				textanimation(statusInimigos[area["inimigo"]]["texto inicial"][0],0,true,"[fade start=0 length=120][wave amp=2 freq=2]",0,"",0)
			if area["inimigo"] == "Capitão Przymus":
				$LabelMensagem.set_text(statusInimigos[area["inimigo"]]["texto inicial"][0])
				textprep()
				textanimation(statusInimigos[area["inimigo"]]["texto inicial"][0],0,true,"[fade start=0 length=120][wave amp=2 freq=2]",0,"",0)
			if area["inimigo"] == "Mago de Gelo":
				$LabelMensagem.set_text(statusInimigos[area["inimigo"]]["texto inicial"][0])
				textprep()
				textanimation(statusInimigos[area["inimigo"]]["texto inicial"][0],0,true,"",0,"",0)
			if area["inimigo"] == "Rei Demônio":
				$LabelMensagem.set_text(statusInimigos[area["inimigo"]]["texto inicial"][0])
				textprep()
				textanimation(statusInimigos[area["inimigo"]]["texto inicial"][0],0,true,"",0,"",0)
		$Inimigo.set_visible(true)
		
		$MenuMensagem.set_visible(true)
		$LabelMensagem.set_visible(true)
		battle["pointer"] = "esperando"
	battle_queue()
	
func CDOne():
	yield( get_node("Inimigo"), "animation_finished" )
	$Inimigo.play("Capitão Przymus rindo")
	
func battle_queue():
	if battle["turno"] == 1:
		if area["inimigo"] == "Diabrete":
			if aceito == true:
				
				if animation == true and $LabelMensagem.get_bbcode() != "":
					animation = false
					$LabelMensagem.bbcode_text = ""
					for l in texto:
						$LabelMensagem.bbcode_text += l
				elif $LabelMensagem.get_text() != statusInimigos[area["inimigo"]]["texto inicial"][len(statusInimigos[area["inimigo"]]["texto inicial"]) - 1] and animation == false:
					var con = 0
					var fin = 0
					for dfb in  statusInimigos[area["inimigo"]]["texto inicial"]:
						var auxsc = texto
						if $LabelMensagem.get_text() == dfb:
							fin = con
						else:
							con+=1
					$LabelMensagem.set_bbcode(statusInimigos[area["inimigo"]]["texto inicial"][fin +1])
					textprep()
					textanimation(statusInimigos[area["inimigo"]]["texto inicial"][fin +1],0,true,"",0,"",0)
				else:
					$VidaInimigo.set_visible(true)
					cutscene = false
					$sons2/batalha.set_stream_paused(false)
					$sons2/batalha.stop()
					$sons2/batalha.play()
					#eventos["principal"] = 2
					batalha = true
					battle["vez"] = "jogador"
					battle["pointer"] = "esperando"
					aceito = false
					wait_answer()
					
					battle["turno"] = 2
					
					aceito = false
		if area["inimigo"] == "Caverna":
			if aceito == true:
				
				if animation == true and $LabelMensagem.get_bbcode() != "":
					animation = false
					$LabelMensagem.bbcode_text = ""
					for l in texto:
						$LabelMensagem.bbcode_text += l
				elif $LabelMensagem.get_text() != statusInimigos[area["inimigo"]]["texto inicial"][len(statusInimigos[area["inimigo"]]["texto inicial"]) - 1] and animation == false:
					var con = 0
					var fin = 0
					for dfb in  statusInimigos[area["inimigo"]]["texto inicial"]:
						var auxsc = texto
						if $LabelMensagem.get_text() == dfb:
							fin = con
						else:
							con+=1
					$LabelMensagem.set_bbcode(statusInimigos[area["inimigo"]]["texto inicial"][fin +1])
					textprep()
					textanimation(statusInimigos[area["inimigo"]]["texto inicial"][fin +1],0,true,"[fade start=4 length=14]",0,"",0)
				else:
					$VidaInimigo.set_visible(false)
					cutscene = false
					#eventos["principal"] = 2
					batalha = true
					battle["vez"] = "jogador"
					if eventos["principal"] != 6:
						batata = 4
						$acao.play("4")
					else:
						batata = 7
						$acao.play("7")
					battle["pointer"] = "esperando"
					aceito = false
					wait_answer()
					
					battle["turno"] = 2
					
					aceito = false
		if area["inimigo"] == "Capitão Przymus":
			if aceito == true:
				
				if animation == true and $LabelMensagem.get_bbcode() != "":
					animation = false
					$LabelMensagem.bbcode_text = ""
					for l in texto:
						$LabelMensagem.bbcode_text += l
				elif $LabelMensagem.get_text() != statusInimigos[area["inimigo"]]["texto inicial"][len(statusInimigos[area["inimigo"]]["texto inicial"]) - 1] and animation == false:
					var con = 0
					var fin = 0
					for dfb in  statusInimigos[area["inimigo"]]["texto inicial"]:
						var auxsc = texto
						if $LabelMensagem.get_text() == dfb:
							fin = con
						else:
							con+=1
					$LabelMensagem.set_bbcode(statusInimigos[area["inimigo"]]["texto inicial"][fin +1])
					textprep()
					textanimation(statusInimigos[area["inimigo"]]["texto inicial"][fin +1],0,true,"",0,"",0)
				else:
					$VidaInimigo.set_visible(true)
					cutscene = false
					#eventos["principal"] = 2
					batalha = true
					$sons2/musica.set_stream_paused(true)
					$sons2/bossfight.set_stream_paused(false)
					$sons2/bossfight.stop()
					$sons2/bossfight.play()
					battle["vez"] = "jogador"
					battle["vez"] = "jogador"
					battle["pointer"] = "esperando"
					battle["vida_inimigo"] = statusInimigos[str(area["inimigo"])]["vida"]
					$VidaInimigo.max_value = battle["vida_inimigo"]
					$VidaInimigo.value = battle["vida_inimigo"]
					aceito = false
					wait_answer()
					
					battle["turno"] = 2
					
					aceito = false
		
		if area["inimigo"] == "Rei Demônio":
			if aceito == true:
				
				if animation == true and $LabelMensagem.get_bbcode() != "":
					animation = false
					$LabelMensagem.bbcode_text = ""
					for l in texto:
						$LabelMensagem.bbcode_text += l
				elif $LabelMensagem.get_text() != statusInimigos[area["inimigo"]]["texto inicial"][len(statusInimigos[area["inimigo"]]["texto inicial"]) - 1] and animation == false:
					var con = 0
					var fin = 0
					for dfb in  statusInimigos[area["inimigo"]]["texto inicial"]:
						var auxsc = texto
						if $LabelMensagem.get_text() == dfb:
							fin = con
						else:
							con+=1
					$LabelMensagem.set_bbcode(statusInimigos[area["inimigo"]]["texto inicial"][fin +1])
					textprep()
					textanimation(statusInimigos[area["inimigo"]]["texto inicial"][fin +1],0,true,"",0,"",0)
				else:
					$VidaInimigo.set_visible(true)
					cutscene = false
					#eventos["principal"] = 2
					batalha = true
					$Inimigo.play("Rei Demônio p2")
					battle["vez"] = "jogador"
					battle["vez"] = "jogador"
					battle["pointer"] = "esperando"
					battle["vida_inimigo"] = statusInimigos[str(area["inimigo"])]["vida"]
					$VidaInimigo.max_value = battle["vida_inimigo"]
					$VidaInimigo.value = battle["vida_inimigo"]
					aceito = false
					wait_answer()
					
					battle["turno"] = 2
					
					aceito = false
		
		if area["inimigo"] == "Mago de Gelo":
			if aceito == true:
				$"sons/Mago de Gelo".play()
				if animation == true and $LabelMensagem.get_bbcode() != "":
					animation = false
					$LabelMensagem.bbcode_text = ""
					for l in texto:
						$LabelMensagem.bbcode_text += l
				elif $LabelMensagem.get_bbcode() != statusInimigos[area["inimigo"]]["texto inicial"][len(statusInimigos[area["inimigo"]]["texto inicial"]) - 1] and animation == false:
					var con = 0
					var fin = 0
					for dfb in  statusInimigos[area["inimigo"]]["texto inicial"]:
						var auxsc = texto
						if $LabelMensagem.get_bbcode() == dfb:
							fin = con
						else:
							con+=1
					$LabelMensagem.set_bbcode(statusInimigos[area["inimigo"]]["texto inicial"][fin +1])
					textprep()
					
					textanimation(statusInimigos[area["inimigo"]]["texto inicial"][fin +1],0,true,"",0,"",0)
					if eventos["principal"]<= 7:
						animation = false
						aceito = false
						
						$".".set_position(Vector2(-2134,373))
						battle["pointer"] = "over"
						cutscene = false
						batata = 1
						$acao.play("1")
						$acao.set_visible(false)
						end_of_fight(true)
						$LabelMensagem.set_bbcode("(Ele lança uma magia que te joga para longe)")
						$"sons/Mago de Gelo".play()
				else:
					
						
					$VidaInimigo.set_visible(true)
					cutscene = false
					#eventos["principal"] = 2
					batalha = true
					battle["vez"] = "jogador"
					battle["vez"] = "jogador"
					battle["pointer"] = "esperando"
					battle["vida_inimigo"] = statusInimigos[str(area["inimigo"])]["vida"]
					$VidaInimigo.max_value = battle["vida_inimigo"]
					$VidaInimigo.value = battle["vida_inimigo"]
					aceito = false
					wait_answer()
					
					battle["turno"] = 2
					if eventos["principal"]<= 7:
						
						aceito = false
						
						$".".set_position(Vector2(-2134,373))
						battle["pointer"] = "over"
						cutscene = false
						batata = 1
						$acao.play("1")
						$acao.set_visible(false)
						end_of_fight(true)
		else:
			battle["vez"] = "jogador"
	elif aceito == true and battle["turno"] > 1 and cutscene == true:
		aceito = false
		if animation == true and $LabelMensagem.get_bbcode() != "":
			animation = false
			$LabelMensagem.bbcode_text = ""
			for l in texto:
				$LabelMensagem.bbcode_text += l
		elif $LabelMensagem.get_text() != statusInimigos[area["inimigo"]]["texto final"][len(statusInimigos[area["inimigo"]]["texto final"]) - 1]:
			var con = 0
			var fin = 0
			$VidaInimigo.set_visible(false)
			for dfb in  statusInimigos[area["inimigo"]]["texto final"]:
				var auxsc = texto
				if $LabelMensagem.get_text() == dfb:
					fin = con
				else:
					con+=1
			if area["inimigo"] == "Diabrete" and fin == 5:
				$Inimigo.set_visible(false)
				eventos["npcs"]["Diabrete"] = false
			if area["inimigo"] == "Capitão Przymus" and fin > 0:
				$Inimigo.set_visible(false)
				eventos["npcs"]["CD"] = false
			if area["inimigo"] == "Caverna" and fin == 1 and eventos["principal"] == 6:
				battle["pointer"] = "over"
				cutscene = false
				batata = 1
				$acao.play("1")
				$acao.set_visible(false)
				end_of_fight(true)
			if area["inimigo"] == "Caverna" and fin == 0 and eventos["principal"] == 7:
				battle["pointer"] = "over"
				cutscene = false
				batata = 1
				$acao.play("1")
				$acao.set_visible(false)
				end_of_fight(true)
			if area["inimigo"] == "Capitão Przymus" and eventos["principal"] == 7:
				battle["pointer"] = "jogador ganhou"
				if eventos["npcs"]["CD"] == true:
					$Inimigo.play("Capitão Przymus surge")
					$sons2/bossfight.set_stream_paused(true)
					$AnimationPlayer.play("shake (copy) (copy) (copy)")
					$sons/CDmorre.play()
					
				cutscene = false
				batata = 1
				$acao.play("1")
				$acao.set_visible(false)
				end_of_fight(true)
			if area["inimigo"] == "Rei Demônio" and eventos["principal"] == 12:
				battle["pointer"] = "jogador ganhou"
				if eventos["npcs"]["CD"] == true:
					$Inimigo.play("Capitão Przymus surge")
					$sons2/bossfight.set_stream_paused(true)
					$AnimationPlayer.play("shake (copy) (copy) (copy)")
					$sons/CDmorre.play()
					
				cutscene = false
				batata = 1
				$acao.play("1")
				$acao.set_visible(false)
				end_of_fight(true)
			if area["inimigo"] != "indefinido":
				$LabelMensagem.set_bbcode(statusInimigos[area["inimigo"]]["texto final"][fin +1])
				textprep()
				textanimation(statusInimigos[area["inimigo"]]["texto final"][fin +1],0,true,"",0,"",0)
		else:
			if area["inimigo"] == "Diabrete":
				eventos["principal"] = 3
				eventos["npcs"]["Diabrete"] = true
			if area["inimigo"] == "Capitão Przymus":
				eventos["principal"] = 8
			else:
				battle["pointer"] = "over"
			cutscene = false
			end_of_fight(true)
			
		
				
	else:
		
		battle["vez"] = "jogador"
		
	if battle["vez"] == "jogador":
		wait_answer()

func wait_answer():
	if battle["vez"] == "jogador" and battle["pointer"] == "esperando" and aceito == true and cutscene == false:
		if batata == 1:
			battle["pointer"] = "esperando escolha de ataque"
			aceito = false
		if batata == 2:
			battle["pointer"] = "defendendo"
			end_of_turn()
		if batata == 3:
			var plus = 0
			if eventos["boost"]["2"] > 0:
					plus += consumableindex["Boost de Agilidade"][2]
			for h in inv["equipado"]:
				plus += equipindex[str(inv["equipado"][h][1])][2]
			if area["inimigo"] != "Diabrete" and area["inimigo"] != "Mago de Gelo" and area["inimigo"] != "Capitão Przymus" and area["inimigo"] != "Rei Demônio" and status["agilidade"] + plus > (statusInimigos[area["inimigo"]]["agilidade"]) or godmode == true:
				battle["pointer"] = "fugir"
				end_of_fight(true)
			else:
				$LabelMensagem.set_bbcode("Não pode fugir agora!")
		if batata >= 4 and eventos["principal"] != 6:
			cutscene = true
			$acao.set_visible(false)
			$LabelMensagem.set_bbcode("[wave amp=2 freq=20]ERRADO!!!")
			$sons/Caverna.play()
		if batata < 9 and eventos["principal"] == 6 and batata > 3:
			cutscene = true
			$acao.set_visible(false)
			$LabelMensagem.set_bbcode("[wave amp=2 freq=20]ERRADO!!!")
			$sons/Caverna.play()
			
		if batata == 9 and eventos["principal"] == 6:
			cutscene = true
			eventos["principal"] = 7
			$acao.set_visible(false)
			$LabelMensagem.set_bbcode("[wave amp=2 freq=20]Muito bem, pode passar.")
			area["inimigo"] = "Capitão Przymus"
			$Inimigo.set_visible(true)
			batata = 1
			$acao.play("1")
			$VidaInimigo.set_visible(true)
			$sons/Caverna.play()
			area["inimigo"] = "Capitão Przymus"
			battle["vida_inimigo"] = statusInimigos["Capitão Przymus"]["vida"]
			$Inimigo.set_visible(true)
			battle["turno"] = 1
			cutscene = true
			battle["pointer"] = 'esperando'
			batalha = true
			$Inimigo.play("Capitão Przymus surge", true)
			$sons2/musica.set_stream_paused(true)
			yield( get_node("Inimigo"), "animation_finished" )
			$Inimigo.play("Capitão Przymus rindo")
			
	if battle["pointer"] == "esperando escolha de ataque":
		ataque()

func ataque():
	battle["ataquesdisp"] = "[color=#c88b46]>[/color]"
	for n in range(1,8):
		if ataques[str(n)][2] == true:
			battle["ataquesdisp"] += ataques[str(n)][0]
			if ataques[str(n)][0] != "bigbang":
				battle["ataquesdisp"] += " [color=#c88b46]>[/color]"
		if ataques[str(n)][2] == false:
			battle["ataquesdisp"] += "[color=#c88b46]" + str(ataques[str(n)][0]) + "[/color]"
			if ataques[str(n)][0] != "bigbang":
				battle["ataquesdisp"] += " [color=#c88b46]>[/color]"
	$LabelMensagem.bbcode_text = (battle["ataquesdisp"])
	
	if battle["pointer"] == "esperando escolha de ataque":
		$Ponteiro.set_visible(true)
		
		if $Ponteiro.position.y == 24:
			if cima == true:
				menorx = 10000000
				menory = 10000000
				dif = 10000000
				mdif = 100000000
				for n in range(1,4):
					dif = sqrt(((ataques[str(n)][3] - $Ponteiro.position.x) * (ataques[str(n)][3] - $Ponteiro.position.x)) + ((ataques[str(n)][4] - $Ponteiro.position.y) * (ataques[str(n)][4] - $Ponteiro.position.y)))
					if dif < mdif and dif != 0 and ataques[str(n)][2] == true:
						menorx = float(ataques[str(n)][3])
						menory = float(ataques[str(n)][4])
						mdif = dif
						battle["ataque"] = ataques[str(n)][0]
				if menorx < 100000:
					$Ponteiro.position = Vector2(menorx,menory)
				menorx = 0
				menory = 0
				
				
			if direita == true:
				menorx = 10000000
				menory = 10000000
				dif = 10000000
				mdif = 100000000
				for n in range(5,8):
					if $Ponteiro.position.x < ataques[str(n)][3]:
						dif = sqrt(((ataques[str(n)][3] - $Ponteiro.position.x) * (ataques[str(n)][3] - $Ponteiro.position.x)) + ((ataques[str(n)][4] - $Ponteiro.position.y) * (ataques[str(n)][4] - $Ponteiro.position.y)))
					if dif < mdif and ataques[str(n)][2] == true and $Ponteiro.position.x < ataques[str(n)][3]:
						menorx = float(ataques[str(n)][3])
						menory = float(ataques[str(n)][4])
						mdif = dif
						battle["ataque"] = ataques[str(n)][0]
				if menorx < 100000:
					$Ponteiro.position = Vector2(menorx,menory)
				direita = false
				
			if esquerda == true:
				menorx = 10000000
				menory = 10000000
				dif = 10000000
				mdif = 100000000
				for n in range(4,7):
					if $Ponteiro.position.x > ataques[str(n)][3]:
						dif = sqrt(((ataques[str(n)][3] - $Ponteiro.position.x) * (ataques[str(n)][3] - $Ponteiro.position.x)) + ((ataques[str(n)][4] - $Ponteiro.position.y) * (ataques[str(n)][4] - $Ponteiro.position.y)))
					if dif < mdif and ataques[str(n)][2] == true and $Ponteiro.position.x > ataques[str(n)][3]:
						menorx = float(ataques[str(n)][3])
						menory = float(ataques[str(n)][4])
						mdif = dif
						battle["ataque"] = ataques[str(n)][0]
				if menorx < 100000:
					$Ponteiro.position = Vector2(menorx,menory)
				esquerda = false
				
		if $Ponteiro.position.y == 10:
			
			if baixo == true:
				menorx = 10000000
				menory = 10000000
				dif = 10000000
				mdif = 100000000
				for n in range(4,8):
					dif = sqrt(((ataques[str(n)][3] - $Ponteiro.position.x) * (ataques[str(n)][3] - $Ponteiro.position.x)) + ((ataques[str(n)][4] - $Ponteiro.position.y) * (ataques[str(n)][4] - $Ponteiro.position.y)))
					if dif < mdif and dif != 0 and ataques[str(n)][2] == true:
						menorx = float(ataques[str(n)][3])
						menory = float(ataques[str(n)][4])
						mdif = dif
						battle["ataque"] = ataques[str(n)][0]
				if menorx < 100000:
					$Ponteiro.position = Vector2(menorx,menory)
				
			if direita == true:
				menorx = 10000000
				menory = 10000000
				dif = 10000000
				mdif = 100000000
				for n in range(2,4):
					if $Ponteiro.position.x < ataques[str(n)][3]:
						dif = sqrt(((ataques[str(n)][3] - $Ponteiro.position.x) * (ataques[str(n)][3] - $Ponteiro.position.x)) + ((ataques[str(n)][4] - $Ponteiro.position.y) * (ataques[str(n)][4] - $Ponteiro.position.y)))
					if dif < mdif and ataques[str(n)][2] == true and $Ponteiro.position.x < ataques[str(n)][3]:
						menorx = float(ataques[str(n)][3])
						menory = float(ataques[str(n)][4])
						mdif = dif
						battle["ataque"] = ataques[str(n)][0]
				if menorx < 100000:
					$Ponteiro.position = Vector2(menorx,menory)
				direita = false

			if esquerda == true:
				menorx = 10000000
				menory = 10000000
				dif = 10000000
				mdif = 100000000
				for n in range(1,3):
					if $Ponteiro.position.x > ataques[str(n)][3]:
						dif = sqrt(((ataques[str(n)][3] - $Ponteiro.position.x) * (ataques[str(n)][3] - $Ponteiro.position.x)) + ((ataques[str(n)][4] - $Ponteiro.position.y) * (ataques[str(n)][4] - $Ponteiro.position.y)))
					if dif < mdif and ataques[str(n)][2] == true and $Ponteiro.position.x > ataques[str(n)][3]:
						menorx = float(ataques[str(n)][3])
						menory = float(ataques[str(n)][4])
						mdif = dif
						battle["ataque"] = ataques[str(n)][0]
				if menorx < 100000:
					$Ponteiro.position = Vector2(menorx,menory)
				esquerda = false
		if battle["ataque"] == "indefinido" and battle["pointer"] == "esperando escolha de ataque":
			for n in range(1,8):
				if $Ponteiro.position == Vector2(ataques[str(n)][3],ataques[str(n)][4]):
					battle["ataque"] = ataques[str(n)][0]
				
				
		if cancelar == true and battle["pointer"] == "esperando escolha de ataque":
			battle["pointer"] = "esperando"
			$LabelMensagem.set_text("O(A) " + area["inimigo"] + " está diante de você.")
			$Ponteiro.set_visible(false)
			battle["ataque"] = "indefinido"
		if aceito == true and battle["pointer"] == "esperando escolha de ataque" and battle["ataque"] != "indefinido":
			battle["pointer"] = "personagem atacando"
			attack_animation()
			if battle["ataque"] != "indefinido":
				var pot = "sons/"+ str(battle["ataque"])
				get_node(pot).play()
			
func enemy_turn():
	var n = 0
	if battle["ataque inimigo"] == "indefinido":
		n = randi() % 101
		for pattern in statusInimigos[area["inimigo"]]["padrão"]:
			if n >= int(pattern[0]) and n <= int(pattern[1]):
				if battle["inimigo_queue"] >= 2:
					if battle["inimigo_queue"] == len(pattern):
						battle["inimigo_queue"] = 2
				battle["ataque inimigo"] = statusInimigos[area["inimigo"]]["ataques"][str(pattern[battle["inimigo_queue"]])][0]
				battle["dano inimigo"] = statusInimigos[area["inimigo"]]["ataques"][str(pattern[battle["inimigo_queue"]])][1]
			if battle["dano inimigo"] < 0:
				var _ne = str("Inimigo usou " , battle["ataque inimigo"], ".")
				block = false
			if battle["dano inimigo"] > 0 and block == false:
				var aasd = randi() % 100 + 1
				if aasd <=25:
					$AnimationPlayer.play("shake")
				if aasd <=50 and aasd > 25:
					$AnimationPlayer.play("shake (copy)")
				if aasd <=75 and aasd > 50:
					$AnimationPlayer.play("shake (copy) (copy)")
				if aasd <=100 and aasd > 75:
					$AnimationPlayer.play("shake (copy) (copy) (copy)")
				$sons/dano.play()
				if area["inimigo"] == "Capitão Przymus" and battle["ataque inimigo"] == "Fogosfera":
					$Inimigo.play("Capitão Przymus bola de fogo")
				if area["inimigo"] == "Capitão Przymus" and battle["ataque inimigo"] == "Flamígera":
					$Inimigo.play("Capitão Przymus espada")
					
			if battle["ataque inimigo"] != "indefinido" and battle["dano inimigo"] > 0:
				var ne = str("Inimigo usou " , battle["ataque inimigo"] , ", você perdeu " , battle["dano inimigo"] , " de vida.")
				$LabelMensagem.set_text(ne)
		if battle["dano inimigo"] == -1:
			var dfv = randi() % 101
			if dfv <= 10:
				debuff +=1
				var plus_attack = 0
				for no in range(1,8):
					if ataques[str(no)][0] == battle["ataque"]:
						plus_attack = ataques[str(no)][1]
				var plus = 0
				for h in inv["equipado"]:
					plus += equipindex[str(inv["equipado"][h][1])][1]
				if debuff < status["ataque"] + plus_attack + plus:
					var ne = str("Inimigo usa " , battle["ataque inimigo"] , ", seu ataque cai " ,debuff , " pontos.")
					$LabelMensagem.set_text(ne)
				else:
					var ne = str("[color=#920000]Inimigo usa " , battle["ataque inimigo"] , ", seu dano zerou!!! [shake rate=30 level=5]fuja!!![/shake][/color]")
					$LabelMensagem.set_bbcode(ne)
			if dfv >10:
				var ne = str("Inimigo usou " , battle["ataque inimigo"] , ", mas não funciona.")
				$LabelMensagem.set_text(ne)
		$Ponteiro.set_visible(false)
		battle["inimigo_queue"] += 1
	if battle["dano inimigo"] < 0:
		pass
	if battle["dano inimigo"] >= 0:
		if block == false and battle["vida_inimigo"] > 0:
			battle["vida_jogador"] -= battle["dano inimigo"]
		elif block == true:
			var plus = 0
			if area["inimigo"] == "Capitão Przymus" and battle["ataque inimigo"] == "Flamígera":
				$Inimigo.play("Capitão Przymus espada")
				CDTwo()
			if area["inimigo"] == "Capitão Przymus" and battle["ataque inimigo"] == "Fogosfera":
				$Inimigo.play("Capitão Przymus bola de fogo")
				CDTwo()
			if eventos["boost"]["3"] > 0:
					plus += consumableindex["Boost de Defesa"][2]
			for h in inv["equipado"]:
				plus += equipindex[str(inv["equipado"][h][1])][0]
			battle["dano inimigo"] -= (status["defesa"] + plus)
			if battle["dano inimigo"] <= 0:
				battle["dano inimigo"] = 0
				if $LabelMensagem.get_text() != "você bloqueou completamente o ataque!":
					$LabelMensagem.set_text("você bloqueou completamente o ataque!")
					$sons2/defesa.play()
			if battle["dano inimigo"] > 0:
				battle["vida_jogador"] -= battle["dano inimigo"]
				n = str("você bloqueou ", status["defesa"] + plus, " de dano, levou ", battle["dano inimigo"])
				$sons2/defesa.play()
				var aasd = randi() % 100 + 1
				$sons/dano.play()
				if aasd <=25:
					$AnimationPlayer.play("shake")
				if aasd <=50 and aasd > 25:
					$AnimationPlayer.play("shake (copy)")
				if aasd <=75 and aasd > 50:
					$AnimationPlayer.play("shake (copy) (copy)")
				if aasd <=100 and aasd > 75:
					$AnimationPlayer.play("shake (copy) (copy) (copy)")
				$LabelMensagem.set_text(n)
			block = false
			
	battle["pointer"] = "inimigo atacaou"
	if battle["vida_jogador"] <= 0:
				battle["pointer"] = "jogador morreu"
				$Efeitos.set_visible(true)
				$Efeitos.set_animation("tela preta")
				$Efeitos.stop()
				$Efeitos.set_frame(0)
				$Efeitos.play("tela preta")
				end_of_fight(true)
				rei = false
				fim = false
				$sons2/rei.set_stream_paused(true)
func end_of_turn():
	if battle["vida_inimigo"] <= 0:
		end_of_fight(true)
		
	if battle["pointer"] == "defendendo":
		block = true
	if battle["vida_inimigo"] != 0 and battle["vez"] == "jogador":
		battle["pointer"] = "inimigo decidindo"
		battle["ataque inimigo"] = "indefinido"
		battle["vez"] = "inimigo"
		battle["turno"] += 1
		skip += 1
		if skip >1:
			skip = 0
			var plus = 0
			if eventos["boost"]["2"] > 0:
					plus += consumableindex["Boost de Agilidade"][2]
			for h in inv["equipado"]:
				plus += equipindex[str(inv["equipado"][h][1])][2]
			if status["agilidade"] + plus > (statusInimigos[area["inimigo"]]["agilidade"] * 2)  and block == false:
				battle["pointer"] = "esperando"
				battle["ataque inimigo"] = "indefinido"
				battle["dano inimigo"] = 0
				battle["turno"] += 1
				battle["vez"] = "jogador"
				var put = [$LabelMensagem.get_text(), "zerou"]
				if put[1] in put[0]:
					var _passs = "pass"
				else:
					$LabelMensagem.set_text("você é mais rápido, o inimigo perde a vez!")
				$Ponteiro.set_visible(false)
			else:
				enemy_turn()
		else:
			enemy_turn()
	if battle["vida_inimigo"] != 0 and battle["vez"] == "inimigo" and battle["pointer"] != "inimigo decidindo":
		battle["pointer"] = "esperando"
		battle["ataque inimigo"] = "indefinido"
		battle["dano inimigo"] = 0
		battle["turno"] += 1
		battle["vez"] = "jogador"
		
func end_of_fight(t):
	if t == true:
		t = false
		for dvc in eventos["boost"]:
			if eventos["boost"][dvc] > 0:
				eventos["boost"][dvc] -= 1
		if battle["pointer"] == "fugir":
			aceito = false
			$sons2/batalha.set_stream_paused(true)
			$sons2/rei.set_stream_paused(true)
			$sons2/fugir.play()
			battle["pointer"] = "over"
			debuff = 0
			$LabelMensagem.set_text("você corre desesperadamente.")
			battle["inimigo_queue"] = 2
		if battle["pointer"] == "jogador morreu":
			aceito = false
			battle["pointer"] = "over"
			debuff = 0
			battle["inimigo_queue"] = 2
			$LabelMensagem.set_text("você desmaia...")
			$".".position.x = pos[0]
			$".".position.y = pos[1]
			$FundoBatalha.set_visible(false)
			$VidaPersonagem.set_visible(false)
			$ManaPersonagem.set_visible(false)
			battle["vida_jogador"] = status["vida"]
			battle["manaj"] = status["mana"]
		if battle["pointer"] != "over":
			$LabelMensagem.set_text(area["inimigo"] + " perde, você ganhou "+ str(statusInimigos[area["inimigo"]]["exp"]) + " de exp!")
			if area["inimigo"] == "Mago de Gelo":
				eventos["principal"] = 9
			if area["inimigo"] == "Rei Demônio":
				eventos["principal"] = 13
				$AnimationPlayer2.play("claro")
				$sons2/rei.set_stream_paused(true)
			if area["inimigo"] == "Capitão Przymus":
				if eventos["principal"] == 8:
					$sons2/vitoria.play()
					$sons2/batalha.set_stream_paused(true)
					$sons2/rei.set_stream_paused(true)
			else:
				$sons2/vitoria.play()
				$sons2/batalha.set_stream_paused(true)
				$sons2/rei.set_stream_paused(true)
			var prox = [5,0]
			for vgh in range(6,-1,-1):
				if nivelindex[vgh] > status["exp"]:
					prox[0] = nivelindex[vgh]
					prox[1] = vgh
			status["exp"] += statusInimigos[area["inimigo"]]["exp"]
			status["moedas"] += int(statusInimigos[area["inimigo"]]["exp"] / 2)
			subirnivel()
			
			if status["exp"] >= prox[0]:
				$LabelMensagem.set_text(area["inimigo"] + " perde, nível "+ str(prox[1]+2) + "! Aprende "+ataques[str(prox[1]+1)][0]+"!")
				$Ponteiro.set_visible(false)
				battle["vida_jogador"] = status["vida"]
				battle["manaj"] = status["mana"]
				if ataques[str(prox[1]+1)][0] == "dividir":
					$LabelMensagem.set_text(area["inimigo"] + " perde, você ganhou "+ str(statusInimigos[area["inimigo"]]["exp"]) + " de exp!")
				if status["exp"] == 5:
					$LabelMensagem.set_text(area["inimigo"] + " perde, nível 2, você se sente mais forte.")
		
		if area["inimigo"] == "Diabrete" and eventos["principal"] == 2 or area["inimigo"] == "Capitão Przymus" and eventos["principal"] == 7 and battle["vida_inimigo"] <= 0:
			cutscene = true
			
			$Ponteiro.set_visible(false)
		else:
			$Inimigo.set_visible(false)
			$VidaInimigo.set_visible(false)
			$Ponteiro.set_visible(false)
			battle["pointer"] = "over"
			debuff = 0
			battle["inimigo_queue"] = 2
			timerBatalha = randi() % 81 + 10
			menorx = 0.0
			menory = 0.0
			dif = 100000
			mdif = 0
			area = {"cena":"Campos Verdes", "inimigo":"indefinido"}

			battle = {"turno":1, "vez": "indefinido","pointer": "over", "ação":"indefinido", "ataquesdisp": "indefinido", "ataque":"indefinido", "vida_inimigo": 1, "vida_jogador":battle["vida_jogador"], "manaj":battle["manaj"], "ataque inimigo": "indefinido", "dano inimigo": 0, "inimigo_queue":2}
		
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
		ataques["2"][2] = true
		
	if status["exp"] >= nivelindex[2]:
		status["vida"] = 20
		status["mana"] = 15
		status["ataque"] = 4
		status["defesa"] = 6
		status["agilidade"] = 5
		ataques["3"][2] = true
		
	if status["exp"] >= nivelindex[3]:
		status["vida"] = 30
		status["mana"] = 20
		status["ataque"] = 6
		status["defesa"] = 8
		status["agilidade"] = 7
		ataques["4"][2] = true
		
	if status["exp"] >= nivelindex[4]:
		status["vida"] = 40
		status["mana"] = 30
		status["ataque"] = 8
		status["defesa"] = 10
		status["agilidade"] = 9
		ataques["5"][2] = true
		
	if status["exp"] >= nivelindex[5]:
		status["vida"] = 50
		status["mana"] = 35
		status["ataque"] = 10
		status["defesa"] = 12
		status["agilidade"] = 11
		ataques["6"][2] = true
		
	if status["exp"] >= nivelindex[6]:
		status["vida"] = 60
		status["mana"] = 40
		status["ataque"] = 12
		status["defesa"] = 14
		status["agilidade"] = 13
		ataques["7"][2] = true
		
	
func attack_animation():
	var minus = 0
	if battle["vez"] == "jogador":
		for n in ataques:
			if ataques[n][0] == battle["ataque"]:
				minus = ataques[n][1]
		for klkn in inv["equipado"]:
			if inv["equipado"][klkn][1] == "Tomo Sagrado" and (minus - 1) >= 0:
				minus -= 1
		if eventos["boost"]["5"] > 0:
			if minus - consumableindex["Boost de Agilidade"][2] >= 0:
				minus -= consumableindex["Boost de Agilidade"][2]
			else:
				minus = 0
			if (battle["manaj"] - minus) < 0:
				aceito = false
				battle["pointer"] = "esperando"
				battle["ataque inimigo"] = "indefinido"
				battle["dano inimigo"] = 0
				battle["vez"] = "jogador"
				battle["ataque"] = "indefinido"
				$LabelMensagem.set_text("Você não possui mana suficiente.")
				$Ponteiro.set_visible(false)
			else:
				if minus >= 0:
					battle["manaj"] = battle["manaj"] - minus
		else:
			if (battle["manaj"] - minus) < 0:
				aceito = false
				battle["pointer"] = "esperando"
				battle["ataque inimigo"] = "indefinido"
				battle["dano inimigo"] = 0
				battle["vez"] = "jogador"
				battle["ataque"] = "indefinido"
				$LabelMensagem.set_text("Você não possui mana suficiente.")
				$Ponteiro.set_visible(false)
			else:
				
				battle["manaj"] = battle["manaj"] - minus
		if battle["pointer"] == "personagem atacando":
			battle["pointer"] = "animação personagem"
			$Efeitos.set_visible(true)
			$Efeitos.set_animation(battle["ataque"])
			$Efeitos.stop()
			$Efeitos.set_frame(0)
			$Efeitos.play(battle["ataque"])
			if area["inimigo"] == "Capitão Przymus":
				$Inimigo.play("Capitão Przymus dano")
				print("hsdbkhbfslkdbfksujdbvhuysxbvlidsknviksnçxclikvni")
				CDTwo()
			
			attack_damage()

func CDTwo():
	yield( get_node("Inimigo"), "animation_finished" )
	if battle["vida_inimigo"] > $VidaInimigo.get_max() / 2:
		$Inimigo.play("Capitão Przymus parado")
	else:
		$Inimigo.play("Capitão Przymus parado triste")

func attack_damage():
	var plus_attack = 0
	if battle["vez"] == "jogador":
		for n in range(1,8):
			if ataques[str(n)][0] == battle["ataque"]:
				plus_attack = ataques[str(n)][1]
		var plus = 0
		for h in inv["equipado"]:
			plus += equipindex[str(inv["equipado"][h][1])][1]
		if eventos["boost"]["4"] > 0:
					plus += consumableindex["Boost de Força"][2]
		if status["ataque"] + plus_attack + plus - debuff >0:
			battle["vida_inimigo"] -= status["ataque"] + plus_attack + plus - debuff
			if godmode == true:
				battle["vida_inimigo"] -= 500
			$VidaInimigo.value = battle["vida_inimigo"]



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
							if status["exp"]>= nivelindex[ghj] and ghj + 1 < len(nivelindex):
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
				var a = Vector2($"../KinematicBody2D".get_position())
				var b = Vector2($"../KinematicBody2D".get_position())
				$escMenu/Objetivo.set_visible(true)
				b = $"./Camera2D".a
				a = Vector2((b.x /36) +48 ,(b.y /32) - 44 )
				$escMenu/Sprite.set_position(a)
				$escMenu/Sprite.set_visible(true)
				if eventos["principal"] <= 3:
					$escMenu/Objetivo.set_global_position(Vector2(b.x +70 ,b.y - 20))
				if eventos["principal"] == 4:
					$escMenu/Objetivo.set_global_position(Vector2(b.x +23 ,b.y - 32))
				if eventos["principal"] > 4 and eventos["principal"] < 8:
					$escMenu/Objetivo.set_global_position(Vector2(b.x +30 ,b.y - 32))
				if eventos["principal"] > 7 and eventos["principal"] < 10:
					$escMenu/Objetivo.set_global_position(Vector2(b.x -20 ,b.y -6))
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
		$escMenu/Objetivo.set_visible(false)
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

func textanimation(t,id,e,i,ip,f,fp):
	var nvnmnd = 0
	var idd = 0
	if $LabelMensagem.get_bbcode() == "":
		idd = id
	textplus = [e,i,ip,f,fp]
	if texto == []:
		for l in t:
			if nvnmnd == textplus[2]:
				texto.append(textplus[1])
			if nvnmnd == textplus[4]:
				texto.append(textplus[3])
			texto.append(l)
			nvnmnd +=1
	
	aux1 +=1
	if aux1 >= 3:
		aux1 = 0
		var p = ""
		if rei == false:
			p = str("sons/"+str(area["inimigo"]))
			if get_node(str(p)).is_playing() == false:
				if eventos["npcs"]["Diabrete"] == true:
					if area["inimigo"] == "Capitão Przymus":
						if eventos["npcs"]["CD"] == true:
							get_node(str(p)).play()
					else:
						get_node(str(p)).play()
	var xtnj = $LabelMensagem.get_bbcode()
	if aux3 < len(texto) and idd == id:
		
		$Timer.start(eventos["Config"]["velocidade"])
	else:
		textindex += 0.5
		animation = false
		if pointer == "diálogo lancer" and eventos["npcs"]["Lancer"] == true and eventos["principal"] >2:
			var tdb = 0
			eventos["npcs"]["lancer"] = false
			for gnk in inv["guardado"]:
				if gnk == "Pique do Soldado":
					tdb +=1
			if tdb == 0 and inv["equipado"]["arma"][0] != "Pique do Soldado":
				inv["guardado"].append("Pique do Soldado") 
				$LabelMensagem.bbcode_text += "(ele te entrega uma lança)"


func textprep():
	$LabelMensagem.bbcode_text = ""
	aux3 = 0
	texto = []
	aux1 = 0
	textoatual = ""
	animation = true


func _physics_process(delta):
	ready()
	#print(cutscene)
	if batalha == false:
		if fim == false:
			escmenu()
		get_input()
		set_animation()
		battle_call(randi() % 81 + 10)
		if godmode == false:
			velocity = move_and_slide(velocity * delta * 10)
		else:
			velocity = move_and_slide(velocity * delta * 20)
		$FundoBatalha.play("default")
		$Inimigo.play("off")
		
		$FundoBatalha.set_visible(false)
		$Inimigo.set_visible(false)
		$acao.play(str(batata))
		$acao.set_visible(false)
		$VidaInimigo.set_visible(false)
		$VidaPersonagem.set_visible(false)
		$ManaPersonagem.set_visible(false)
		$MenuMensagem.set_visible(false)
		$LabelMensagem.set_visible(false)
		$Ponteiro.set_visible(false)
		#var ataqueblock = -1 usar para desativar alguma habilidade (pelo adversário)
	else:
		if battle["vida_jogador"] > status["vida"]:
			battle["vida_jogador"] = status["vida"]
		if cutscene == false:
			$FundoBatalha.set_visible(true)
			battle_input()
			$VidaPersonagem.set_value(battle["vida_jogador"])
			$ManaPersonagem.set_value(battle["manaj"])
			
			$acao.set_visible(true)
			if area["inimigo"] != "Caverna" and $LabelMensagem.get_bbcode() != "VOCÊ NÃO PODERÁ PASSAR":
				$VidaPersonagem.set_visible(true)
				$ManaPersonagem.set_visible(true)
				if area["inimigo"] == "Capitão Przymus" and $Inimigo.is_playing() == false and $Inimigo.get_animation() == "Capitão Przymus parado":
					$Inimigo.play("Capitão Przymus parado")
			$MenuMensagem.set_visible(true)
			$LabelMensagem.set_visible(true)
			battle_choose()
			$acao.set_visible(false)
			if battle["pointer"] != "over":
				$Inimigo.set_visible(true)
				$acao.set_visible(true)
			input_action()
		else:
			battle_input()
			input_action()
			battle_choose()
			$FundoBatalha.set_visible(true)
	if battle["pointer"] == "over" and aceito == true:
		battle["pointer"] = "indefinido"
		batalha = false
		$sons2/musica.set_stream_paused(false) 
		$sons2/batalha.set_stream_paused(true)
		$sons2/bossfight.set_stream_paused(true)
	if battle["pointer"] == "inimigo atacaou" and aceito == true:
		end_of_turn()
	if battle["vida_jogador"] > status["vida"]:
		battle["vida_jogador"] = status["vida"]
	if battle["manaj"] > status["mana"]:
		battle["manaj"] = status["mana"]
	
	if $".".position.y > 1110 and fim == false:
		fim = true
		$AnimationPlayer2.play("fim")
		movimento = false
		


func _on_Efeitos_animation_finished():
	if battle["pointer"] == "animação personagem":
		$AnimationPlayer.stop()
		$Efeitos.set_visible(false)
		battle["pointer"] = "fim de turno"
		$Efeitos.stop()
		end_of_turn()

func go(to):
	if colision == false:
		colision = true
		$AnimationPlayer.play("zoom")
		var file = File.new()
		var error = file.open(save_path, File.WRITE)
		if to == "Cidade Principal":
			pos = [726,-49]
		if to == "Cidade Deserto":
			pos = [726,-49]
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
		yield( get_node("AnimationPlayer"), "animation_finished" )
		$Camera2D.zoom = Vector2(0.2, 0.2)
		if to != "Caverna":
			get_tree().change_scene("res://"+to+".tscn")
		if $sons2/musica.is_playing() == false:
			$sons.play()
		
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




func _on_Blocker_body_entered(body):
	blocker = true


func _on_Blocker_body_exited(body):
	blocker = false



func _on_Timer_timeout():
	if aux3 < len(texto) and animation == true:
		textoatual = ""
		$LabelMensagem.bbcode_text += texto[aux3]
		aux3 +=1
		textanimation(texto,idd,textplus[0],textplus[1],textplus[2],textplus[3],textplus[4])


func _on_Blocker2_body_entered(body):
	blocker = true


func _on_Blocker2_body_exited(body):
	blocker = false


func _on_Blocker3_body_entered(body):
	blocker = true


func _on_Blocker3_body_exited(body):
	blocker = false


func _on_Blocker4_body_entered(body):
	blocker = true


func _on_Blocker4_body_exited(body):
	blocker = false


func _on_musica_finished():
	$sons2/musica.play()


func _on_batalha_finished():
	$sons2/batalha.play()


func _on_bossfight_finished():
	$sons2/bossfight.play()


func _on_AnimationPlayer2_animation_finished(anim_name):
	if eventos["principal"] < 13:
		rei = true
		cutscene = true
		batalha = true
		$sons2/musica.set_stream_paused(true)
		$sons2/rei.set_stream_paused(false)
		$sons2/rei.stop()
		$sons2/rei.play()
		$".".set_position(Vector2(-865,1010))
	else:
		go("ending")

func _on_rei_finished():
	$sons2/rei.play()
