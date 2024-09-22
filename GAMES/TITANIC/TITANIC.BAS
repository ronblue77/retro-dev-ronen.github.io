10 REM TITANIC ADVENTURE GAME - ESCAPE THE SINKING SHIP
20 REM BY RON77 (SOLO88) 2023 EMAIL: ron77@email.com FORUM: https://back-to-basic.freeforums.net/
30 REM VERSION 1.0
40 REM VARIABLES INITIALIZATION
41 DIM ROOM$(10): RO=1: SC=0: DIM DIRECTION(10,4):DIM ITEMS1$(6), ITEMS2$(6), TR(6), INV$(6),DES$(6):PAY =0: KEY1=0: UNI=0
42 GOSUB 59970

100 REM INTERFACE INITIALIZATION
110 SCREEN 0:WIDTH 80: KEY OFF: CLS
111 LOCATE 21,1: PRINT "TITANIC - escape the sinking ship"
120 GOSUB 58900 : REM ROOM DESCRIPTION
125 GOSUB 53500 : REM ITEMS IN THE ROOM
124 REM INPUT HANDLING
129 KW=0
130 INPUT">", A$
131 IF A$="" THEN PRINT:PRINT "what?." : GOTO 130
140 A = ASC(A$): IF A<65 OR A>90 THEN PRINT:PRINT "use capital letters only": GOTO 130
150 M=LEN(A$): IF M<7 THEN A$=A$+" ": GOTO 150
155 B$=LEFT$(A$,3)
160 IF B$="NOR" OR B$= "N  " THEN D=1: GOSUB 55000: GOSUB 53500:GOTO 130
170 IF B$="SOU" OR B$= "S  " THEN D=3: GOSUB 55000: GOSUB 53500:GOTO 130
180 IF B$="EAS" OR B$= "E  " THEN D=2: GOSUB 55000: GOSUB 53500: GOTO 130
190 IF B$="WES" OR B$= "W  " THEN D=4: GOSUB 55000: GOSUB 53500:GOTO 130
200 IF B$="HEL" OR B$="H  " THEN GOSUB 54000 :GOTO 130
210 IF B$="QUI" OR B$="Q  " THEN GOTO 59410
220 IF B$="LOO" OR B$="L  " THEN GOSUB 58900: GOSUB 53500 :GOTO 130
230 IF B$="INV" OR B$="I  " THEN GOSUB 53000: GOTO 130 

250 N=1
260 IF MID$(A$,N,1)=" " THEN C$=MID$(A$,N+1,3):IF LEFT$(C$,1)<>" " THEN 290 ELSE 280
270 IF N<M THEN N=N+1:GOTO 260
280 PRINT "in that form i cannot understand what you mean by ";A$: GOTO 130
290 IF B$="TAK" OR B$="GET" THEN KW =1: GOSUB 52500: GOTO 130
300 IF B$="DRO" OR B$="PUT" THEN KW =1: GOSUB 52000: GOTO 130
310 IF B$="EXA" THEN GOSUB 51900:GOTO 130
320 IF B$="USE" OR B$="U" THEN GOSUB 51500: GOTO 130

1500 PRINT : PRINT "i don't know that word.": GOTO 130

51500 REM USE ITEMS
51505 IF C$="MON" OR C$="WAL" AND TR(1) =200 AND RO=9 THEN PRINT: PRINT "you give the money to the guard": PAY=1: RETURN
51506 IF C$="KEY" AND TR(4)=200 AND RO=6 THEN PRINT:PRINT "you use the key to open the elevator door": KEY1=1: RETURN
51507 IF C$="LIF" AND TR(5)=200 THEN PRINT:PRINT "you put on the life suit": RETURN
51508 IF C$="UNI" AND TR(6)=200 THEN UNI=1:PRINT:PRINT "you put on the boat crew uniform": RETURN
51509 IF C$="GUN" AND TR(3)=200 AND RO=9 THEN PRINT: PRINT "you draw the gun but the guard punch you in the face":PRINT "more guards come and take you away and lock you in one of the cells you drown with the ship - GAME OVER": END 
51510 IF C$="KNI" AND TR(2)=200 AND RO=9 THEN PRINT: PRINT "you draw the knife but the guard punch you in the face":PRINT "more guards come and take you away and lock you in one of the cells you drown with the ship - GAME OVER": END
51520 PRINT: PRINT "you either can't use that item here or don't have that item with you.": RETURN


51900 REM LOOK AT ITEMS
51905 OBJECT=0
51910 FOR I = 1 TO 6
51915 IF C$=ITEMS1$(I) AND TR(I) = 200 THEN OBJECT=I: PRINT: PRINT DES$(I): RETURN
51945 NEXT I
51950 IF OBJECT=0 THEN PRINT:PRINT "i don't have that object with you...":RETURN
51960 RETURN




52000 REM DROP ITEMS
52005 OBJECT=0: FLAG=0
52010 FOR I = 1 TO 6
52015 IF TR(I) = 200 THEN FLAG = 1
52020 NEXT I
52025 IF FLAG = 0 THEN PRINT: PRINT "you are not carrying anything":RETURN
52030 FOR I = 1 TO 6
52035 IF C$=ITEMS1$(I) AND TR(I) = 200 THEN OBJECT=I :PRINT: PRINT "ok. you drop ";INV$(OBJECT)
52038 NEXT I
52040 IF OBJECT=0 THEN PRINT:PRINT "you are not holding that object":RETURN
52050 TR(OBJECT)=RO
52055 PRINT: PRINT "ok."
52060 RETURN

52500 REM PICK UP ITEMS
52505 OBJECT=0
52510 FOR I = 1 TO 6
52515 IF C$=ITEMS1$(I) AND TR(I) = RO THEN OBJECT=I :PRINT: PRINT "ok. you pick up ";INV$(OBJECT)
52520 NEXT I
52325 REM
52530 IF OBJECT=0 THEN PRINT :PRINT "i don't see that object here...":RETURN
52540 TR(OBJECT)=200
52545 PRINT: PRINT "ok."
52550 RETURN


53000 REM INVENTORY ROUTINE
53010 PRINT: PRINT "  you are carrying: "
53020 FOR I = 1 TO 6
53030 IF TR(I) = 200 THEN PRINT "   ";INV$(I): AADS = 1
53040 NEXT I
53050 IF AADS <> 1 THEN PRINT "  nothing  "
53060 AADS = 0
53070 RETURN

53500 REM ITEMS IN A THE ROOM
53510 FOR I = 1 TO 6 
53511 IF TR(I)=RO THEN  PRINT ITEMS2$(I)
53512 NEXT I
53520 RETURN

54000 REM HELP
54010 PRINT: PRINT "TITANIC - escape the sinking ship"
54020 PRINT "you are on the titanic, the ship is sinking"
54030 PRINT "you must escape the ship before it sinks"
54040 PRINT "you can go north, south, east or west"
54050 PRINT "you can also go to the help screen by typing 'HELP'"
54060 PRINT "type 'NORTH', 'SOUTH', 'EAST' or 'WEST' or 'N', 'S', 'E' or 'W' to move 'H' or 'HELP' for help"
54070 PRINT "'Q' or 'QUIT' to quit - 'I' or 'INVENTORY' for inventory - 'TAKE' or 'GET' for picking up items 'PUT' or 'DROP' to drop item - 'U' or 'USE' to use item"
54080 RETURN

55000 REM DIRECTION HANDLING
55001 REM 
55002 REM
55003 IF RO=6 AND KEY1=0 AND D=3 THEN PRINT: PRINT "the elevator door is locked": RETURN
55004 IF RO=6 AND KEY1=1 AND D=3 THEN RO = 7: PRINT :PRINT "the elevator door opens": GOSUB 58900: RETURN
55005 IF RO=9 AND UNI=1 AND D=3 THEN RO=10: PRINT: PRINT "you are on the lifeboat": GOSUB 58900: END
55006 IF RO=9 AND PAY =1 AND D=3 THEN RO=10: PRINT: PRINT "you are on the lifeboat": GOSUB 58900: END
55007 IF RO=9 AND PAY =0 AND D=3 THEN PRINT: PRINT "the guard won't let you aboard the lifeboat": RETURN
55010 IF DIRECTION(RO,D)<>-1 THEN RO=DIRECTION(RO,D):SC=SC+1: PRINT: PRINT "you go into "; ROOM$(RO): GOSUB 58900
55020 IF DIRECTION(RO,D)=-1 THEN PRINT:PRINT "you can't go that way"
55030 RETURN



58900 COLOR 0,7
58910 LOCATE 25,1: PRINT SPACE$(80)
58920 LOCATE 25,1: PRINT ROOM$(RO)
58925 LOCATE 25,40: PRINT "score: ";SC
58930 COLOR 7,0
58940 REM LOCATE 24,1
58950 ON RO GOSUB 59370,59330,59290,59250,59210,59170,59120,59080,59040,59000
58960 RETURN

59000 REM ROOMS DESCRIPTIONS SUBROUTIME
59010 REM LIFEBOAT
59020 PRINT "you are in a lifeboat on the sea, you are safe - GAME OVER"
59030 RETURN
59040 REM BOAT DECK
59050 PRINT "you are on the boat deck, you can see the lifeboats"
59055 PRINT "there is a guard here, he is guarding the lifeboats"
59060 PRINT "you can go to the bridge, the main deck or the lifeboats"
59070 RETURN
59080 REM MAIN DECK
59090 PRINT "you are on the main deck, you can see the lifeboats far away"
59105 PRINT "there is mayhem everywhere, people are running around"
59106 PRINT "people are waiting to get aboard the lifeboats"
59107 PRINT "guards are shooting at people to keep order"
59100 PRINT "you can go to the bridge, the boat deck or the elevator"
59110 RETURN
59120 REM BRIDGE
59130 PRINT "you are on the bridge, you can see the captain"
59140 PRINT "the captain is giving orders to the crew"
59150 PRINT "you can go to the main deck or the boat deck"
59160 RETURN
59170 REM ELEVATOR
59180 PRINT "you are in the elevator, you can see the main deck"
59185 PRINT "there is a key hole on the elevator door"
59190 PRINT "you can go to the boiler room or the main deck"
59200 RETURN
59210 REM CARGO HOLD
59220 PRINT "you are in the cargo hold, you can see the boiler room"
59230 PRINT "you can go to the boiler room or the engine room"
59240 RETURN
59250 REM ENGINE ROOM
59260 PRINT "you are in the engine room, you can see the cargo hold"
59270 PRINT "you can go to the cargo hold or the boiler room"
59280 RETURN
59290 REM BOILER ROOM
59300 PRINT "you are in the boiler room, you can see the cargo hold"
59310 PRINT "you can go to the cargo hold or the engine room"
59320 RETURN
59330 REM GALLOW DECK
59340 PRINT "you are in the gallow deck, you can see the passenger cell"
59350 PRINT "you can go to the passenger cell or the boiler room"
59360 RETURN
59370 REM PASSENGER CELL
59380 PRINT "you are in the passenger cell, you can see the gallow deck"
59390 PRINT "you can go to the gallow deck or the boiler room"
59400 RETURN
59410 REM GAME OVER
59420 PRINT:PRINT "you are dead, game over"
59430 PRINT "press any key to continue"
59440 END

59970 REM INITIALIZATION SUBROUTINE
59975 FOR I = 1 TO 10: READ ROOM$(I): NEXT I
59980 FOR I = 1 TO 10: FOR J = 1 TO 4: READ DIRECTION(I,J): NEXT J: NEXT I
59985 FOR K = 1 TO 6: READ ITEMS1$(K): NEXT K
59987 FOR K = 1 TO 6: READ ITEMS2$(K): NEXT K
59988 FOR K = 1 TO 6: READ TR(K): NEXT K
59989 FOR K = 1 TO 6: READ INV$(K): NEXT K
59990 FOR K = 1 TO 6: READ DES$(K): NEXT K 
59991 REM
59992 RETURN

60000 DATA "passenger cell", "gallows deck", "boiler room", "engine room", "cargo hold"
60010 DATA "elevator", "bridge", "main deck", "boat deck", "lifeboat"
60020 DATA -1,-1,2,-1
60030 DATA 1,-1,3,-1
60040 DATA 2,-1,4,-1
60050 DATA 3,-1,5,-1
60060 DATA 4,-1,6,-1
60070 DATA 5,-1,7,-1
60080 DATA 6,-1,8,-1
60090 DATA 7,-1,9,-1
60100 DATA 8,-1,10,-1
60110 DATA 9,-1,-1,-1
60120 REM ITEMS
60130 REM DATA "WAL","there is a wallet on the table here", 1, "a wallet","the wallet contains 5,000 dollars"
60140 REM DATA "KNI","there is a knife on the table here", 1, "a knife","the knife is very sharp"
60150 REM DATA "GUN", "there is a gun on one of the suitcases here", 5, "a gun","the gun is loaded"
60160 REM DATA "KEY", "there is a key laying on the floor here", 4, "a key","the key is an elevator key"
60170 REM DATA "LIF", "there is a life suit laying on the floor here", 3, "a life suit","the life suit is a life jacket"
60180 REM DATA "UNI", "there are a boat crew uniform laying on the floor here", 3, "a boat crew uniform","the boat crew uniform is a is a formal TITANIC staff uniform"

60200 DATA "WAL", "KNI", "GUN", "KEY", "LIF", "UNI"
60210 DATA "there is a wallet on the table here", "there is a knife on the table here", "there is a gun on one of the suitcases here"
60215 DATA "there is a key laying on the floor here", "there is a life suit laying on the floor here", "there are a boat crew uniform laying on the floor here"
60220 DATA 1,1,5,4,3,3
60230 DATA "a wallet", "a knife", "a gun", "a key", "a life suit", "a boat crew uniform"
60240 DATA "the wallet contains 5,000 dollars", "the knife is very sharp", "the gun is loaded", "the key is an elevator key", "the life suit is a life jacket", "the boat crew uniform is a is a formal TITANIC staff uniform"

