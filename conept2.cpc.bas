' keyword/ [/optn] [args...]
' les mots clef peuvent prendre des "flags" et des arguments
' un peu à la maniere de programme POSIX (les flags obligatoirements
' avant les arguments)
txt/ /#R "Hello "
txt/ "World"

' ${} aurait la meme comportement que les {} dans les f-strings en python
txt/ "il est ${SYS.TIME}"

' pour definir une fonction
' def/ name (args)
'  body
' end/

def/ hello (name)
	txt/ "hello ${name}"	
end/

' Comme en python lambda:
goodby = lambda/ (name) text/ "Goodbye ${name}"

' et on les appeleraient comme ceci:
call/ hello "test de julien a nouveau"
' l'idée serait de séparer mot clef (finissant par / et reserver) et l'espace de nom utilisateur

' on pourrait inclure des dépendances externes avec par ex "include/"
include/ "cpcgui"
' ce qui permettrait d'importer 2 types de librairies
'  - code cc+
'  - libnative (et ces dernieres pourrait ajouter de nouveaux keywords)

let/ user_name = "admin"
' cpc.src.x serait une variable exporté par cpcgui (on pourrait imaginer 
' un keyword 'export/' pour exporter des variables et des fonctions
let/ center_point_x = cpc.src.x / 2
let/ center_point_y = cpc.src.y / 2

let/ logon_siz_x = cpc.src.x
let/ logon_siz_y = cpc.src.y

let/ logon_pos_x = 0
let/ logon_pos_y = 0

' window/ serait un keyword definis dans 'cpcgui' 
' les lignes commençant par . indique un paramètre nommé 
let/ logon_win_handle = window/
    .title          = "Logon window"
    .px             = logon_pos_x
    .py             = logon_pos_y 
    .sx             = logon_siz_x
    .sy             = logon_siz_y
    .opacity        = 100
    .parameters     = "TYPE:4 ALPHAMODE:0 BLURRY:6 CTX:1"
    .windowcolor    = (50, 50, 100)
    .titlecolor     = (255, 255, 255)
    .backcolor      = (150, 0, 220)
    .icon           = ""
end/

' on aurait pu faire
login_win_handle = window/ "Logon window" logon_pos_x ....
' tout comme on peut faire
txt/
.txt = "Hello World" ' ouai c'est naze mais c'est pour explicité l'idée
end/


' ==== User image ==== 


PictureBox/
.parent     = logon_win_handle
    .parameters = "IMGAUTO:2"
    .px         = 0
    .py         = 0
    .opacity    = 255 
    .sx         = logon_siz_x 
    .sy         = logon_siz_y 
    .image      = "${Media_OS}/bckgnd/LOG_TRSP.png"
end/

image_SX = 99
image_SY = 99

image_PX = center_point_x - (image_SX / 2)
image_PY = center_point_y - ((image_SY / 2) - 99) 

user_path = "%USER_OS%/%user_name%"

PictureBox/
	.handle     = logon_window_handle
    .parameters = "IMGAUTO:2"
    .px         = image_PX 
    .py         = image_PY 
    .opacity    = 255
    .sx         = image_SX 
    .sy         = image_SY 
    .image      = "%user_path%/image.png"
	.event      = "%_EXE_PATH_DIR%/logon_ev.cpc" ' TODO: trouver un truc cohérent pour ce genre de variable
end/

' ==== User image name ====
name_SX = 99
name_SY = 39

name_PX = center_point_x - (name_SX / 2)
name_PY = center_point_y - (name_SY / 2)

PictureBox/
	.handle     = logon_window_handle
    .parameters = "IMGAUTO:2"
    .px         = name_PX 
    .py         = name_PY 
    .opacity    = 255
    .sx         = name_SX 
    .sy         = name_SY
    .image      = "%user_path%/name.png"
end/

' (Ici Chrapati. Après avoir légèrement modifier quelques trucs qui ont été mis en place par les autres, voici ce que je propose) :

' Pour les variables modifiables par l'utilisateur :

let/ /input: "Entrez une valeur : ", x

txt/ "${x}"

' Pour les conditions

let/ y = 5

if/ 
    x == y then:
        txt/ "x est egal a y"
    or x < y then:
        txt/ "x est inferieur a y"
    else:
        txt/ "x est superieur a y"
end/

' Pour les boucles type "tant que"

while/
    x < y then:
    let/ x + 1
end/

' Pour les boucles type 'pour'

let/ tab = [3, 5, 4, 9, 14, 15, 21, 38]

for/
    y in tab:
    if tab[0] == y then:
        txt/ "y = ${tab[0]}"
end/

