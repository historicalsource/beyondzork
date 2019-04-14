"THINGS for BEYOND ZORK: Copyright (C)1987 Infocom, Inc. All rights
 reserved."
	 
"*** PSEUDO OBJECTS ***"

<ROUTINE HANDLE-SIGNS? ("AUX" X)
	 <COND (<SET X <MOVING?>>
		<TELL "Signs are for reading." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BILLBOARD-PSEUDO ()
	 <MAKE ,PSEUDO-OBJECT ,TRYTAKE>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE READ LOOK-ON>
		<PRINT "The billboard">
		<FROTZEN-SIGN>
		<RTRUE>)
	       (<HANDLE-SIGNS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FROTZEN-SIGN ()
	 <TELL " says," CR CR>
	 <HLIGHT ,H-MONO>
	 <COND (<NOT <EQUAL? ,HOST ,MACINTOSH>>
		<HLIGHT ,H-BOLD>)>
	 <TELL "WELCOME TO THE FIELDS OF FROTZEN" CR>
	 <HLIGHT ,H-NORMAL>
	 <HLIGHT ,H-MONO>
	 <TELL " Last sign for next 120 bloits." CR>
	 <HLIGHT ,H-NORMAL>
	 <RTRUE>>

"*** STANDARD OBJECTS ***"

<OBJECT SUN
	(LOC GLOBAL-OBJECTS)
	(DESC "sun")
	(FLAGS NODESC)
	(SYNONYM SUN SUNLIGHT)
	(ACTION SUN-F)>

<ROUTINE SUN-F ("AUX" X)
	 <COND (<OR <IS? ,HERE ,INDOORS>
		    <PLAIN-ROOM?>
		    <HERE? NE-WALL>>
		<NOT-VISIBLE ,SUN>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL CTHEO " is as bright as ever">
		<COND (<HERE? XROADS ON-PIKE>
		       <TELL ", except to the ">
		       <COND (<HERE? ON-PIKE>
			      <TELL B ,W?WEST>)
			     (T
			      <TELL B ,W?EAST>)>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<OR <SET X <TOUCHING?>>
		    <SET X <ENTERING?>>
		    <VERB? LOOK-BEHIND>>	    
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NOT-VISIBLE (OBJ)
	 <PCLEAR>
	 <TELL CTHE .OBJ " isn't visible" ,AT-MOMENT>
	 <RTRUE>>
	       
<OBJECT SKY
	(LOC GLOBAL-OBJECTS)
	(DESC "sky")
	(FLAGS NODESC)
	(SYNONYM SKY AIR CLOUDS)
	(ACTION SKY-F)>

<ROUTINE SKY-F ("AUX" X)
	 <COND (<IS? ,HERE ,INDOORS>
		<NOT-VISIBLE ,SKY>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-INSIDE LOOK-UP SEARCH>
		<COND (<HERE? IN-SKY>
		       <V-LOOK>
		       <RTRUE>)>
		<PERFORM ,V?EXAMINE ,SUN>
		<RTRUE>)
	       (<VERB? FLY-UP WALK-TO ENTER THROUGH CLIMB-ON CLIMB-UP>
		<V-FLY>
		<RTRUE>)
	       (<VERB? EXIT FLY-DOWN CLIMB-DOWN LEAVE CLIMB-DOWN>
		<V-LAND>
		<RTRUE>)
	       (<OR <SET X <TOUCHING?>>
		    <VERB? LOOK-BEHIND LAND-ON>>	    
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BREEZE
	(LOC GLOBAL-OBJECTS)
	(DESC "wind")
	(FLAGS NODESC SEEN)
	(SYNONYM WIND BREEZE GUST)
	(ACTION BREEZE-F)>

<ROUTINE BREEZE-F ("AUX" X)
	 <MAKE ,BREEZE ,SEEN>
	 <COND (<OR <IS? ,HERE ,INDOORS>
		    <HERE? APLANE IN-GARDEN IN-FROON IN-SPLENDOR>>
		<TELL "There's no wind here to speak of." CR>
		<RFATAL>)
	       (<SET X <SEEING?>>
		<TELL "Wind is transparent." CR>
		<RTRUE>)
	       (<VERB? TOUCH>
		<TELL CTHE ,BREEZE " feels cool and fresh." CR>
		<RTRUE>)
	       (<OR <SET X <ENTERING?>>
		    <SET X <EXITING?>>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PACK
	(LOC PLAYER)
	(DESC "pack")
	(FLAGS TAKEABLE CLOTHING WORN CONTAINER OPENED)
	(CAPACITY 30)
	(SIZE 10)
	(VALUE 2)
	(SYNONYM PACK BACKPACK BAG)
	(ACTION PACK-F)>

<ROUTINE PACK-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO>
		       <COND (<PRSO? RUG>
			      <NEVER-FIT>
			      <RTRUE>)
			     (<AND <PRSO? PARASOL>
				   <IS? ,PRSO ,OPENED>>
			      <YOUD-HAVE-TO "close">
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<VERB? OPEN OPEN-WITH>
		<ITS-ALREADY "open">
		<RTRUE>)
	       (<VERB? CLOSE>
		<TELL "It's not that type of pack." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CELLAR-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "cellar door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY ZZZP ZZZP)
	(ADJECTIVE CELLAR)
	(ACTION CELLAR-DOOR-F)>

<ROUTINE CELLAR-DOOR-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? EXAMINE LOOK-ON LOOK-BEHIND>
		     <IS? ,PRSO ,MUNGED>>
		<ITS-MUNGED ,W?DOOR>
		<RTRUE>)
	       (<VERB? CLOSE>
		<COND (<IS? ,PRSO ,MUNGED>
		       <ITS-MUNGED ,W?DOOR>
		       <RTRUE>)
		      (<NOT <IS? ,PRSO ,OPENED>>
		       <RFALSE>)>
		<ICLOSE>
		<TELL "You pull " THEO " shut." CR>
		<COND (<HERE? AT-BOTTOM>
		       <UNMAKE ,HERE ,LIGHTED>
		       <SAY-IF-HERE-LIT>)>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<COND (<IS? ,PRSO ,MUNGED>
		       <ITS-MUNGED ,W?DOOR>
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <RFALSE>)
		      (<AND <HERE? AT-BOTTOM>
			    <NOT <IS? ,PRSO ,LOCKED>>>
		       <LOCK-CELLAR-DOOR>
		       <RTRUE>)
		      (<ZERO? ,PRSI>
		       <RFALSE>)
		      (<VERB? OPEN-WITH>
		       <CRASH-CELLAR-DOOR ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<OR <SET X <ENTERING?>>
		    <SET X <EXITING?>>>
		<COND (<HERE? AT-BOTTOM>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? KICK HIT MUNG LOOSEN PUSH SHAKE CUT KNOCK>
		<COND (<IS? ,PRSO ,MUNGED>
		       <ITS-ALREADY "in ruins">
	 	       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)
		      (<VERB? KNOCK>
		       <COND (<HERE? AT-BOTTOM>
			      <TELL ,YOU-HEAR "a muffled \"Har!\"" CR>
			      <RTRUE>)>
		       <TELL "\"Nobody down there,\" snickers " 
			     THE ,COOK ,PERIOD>
		       <RTRUE>)>
		<SET X ,PRSI>
		<COND (<VERB? KICK>
		       <SET X ,FEET>)>
		<CRASH-CELLAR-DOOR .X>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ITS-MUNGED (WRD)
	 <TELL "Little remains of the " B .WRD ,PERIOD>
	 <RTRUE>>

<ROUTINE CRASH-CELLAR-DOOR ("OPT" (OBJ ,HANDS) "AUX" TBL)
	 <ITALICIZE "Wham">
	 <TELL "! Your ">
	 <COND (<EQUAL? .OBJ <> ,HANDS ,ME>
		<TELL B ,W?FIST>)
	       (<EQUAL? .OBJ ,FEET>
		<TELL B ,W?FOOT>)
	       (T
		<TELL D .OBJ>)>
	 <TELL " deals " THE ,CELLAR-DOOR " a mighty blow">
	 <COND (<L? <GET ,STATS ,STRENGTH> 50>
		<NOTE-NOISE>
		<RTRUE>)>
	 <MAKE ,CELLAR-DOOR ,OPENED>
	 <UNMAKE ,CELLAR-DOOR ,LOCKED>
	 <MAKE ,CELLAR-DOOR ,MUNGED>
	 <MAKE ,AT-BOTTOM ,LIGHTED>
	 <SET TBL <GETPT ,CELLAR-DOOR ,P?SYNONYM>>
	 <PUT .TBL 2 ,W?HOLE>
	 <PUT .TBL 3 ,W?OPENING>
	 <SET TBL <GETP ,AT-BOTTOM ,P?UP>>
	 <PUT .TBL ,XTYPE %<+ ,CONNECT 1>>
	 <PUT .TBL ,XROOM ,IN-KITCHEN>
	 <SET TBL <GETP ,IN-KITCHEN ,P?DOWN>>
	 <PUT .TBL ,XTYPE %<+ ,CONNECT 1>>
	 <PUT .TBL ,XROOM ,AT-BOTTOM>
	 <SET TBL <GETP ,IN-KITCHEN ,P?IN>>
	 <PUT .TBL ,XTYPE %<+ ,CONNECT 1>>
	 <PUT .TBL ,XROOM ,AT-BOTTOM>
	 <TELL 
", shattering it and much of " THE ,KITCHEN " wall into splinters">
	 <RELOOK>
	 <TELL ,TAB "\"Yow,\" murmurs ">
	 <COND (<HERE? AT-BOTTOM>
		<TELL "an admiring voice upstairs." CR>
		<RTRUE>)>
	 <MAKE ,COOK ,SEEN>
	 <TELL THE ,COOK ", gawking at you admiringly." CR>
	 <RTRUE>>

<ROUTINE NOTE-NOISE ()
	 <TELL ", with little effect except for the noise." CR>
	 <RTRUE>>

<OBJECT PUB-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "front door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY)
	(ADJECTIVE FRONT)>

<OBJECT CELLAR-STAIR
	(LOC LOCAL-GLOBALS)
	(DESC "stairway")
	(FLAGS NODESC CONTAINER)
	(SYNONYM STAIR STAIRS STAIRWAY STEPS)
	(ACTION CELLAR-STAIR-F)>

<ROUTINE CELLAR-STAIR-F ("AUX" X)
	 <COND (<AND <NOT <IS? ,CELLAR-DOOR ,OPENED>>
		     <HERE? IN-KITCHEN>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HERE? IN-KITCHEN>)
	       (<SET X <CLIMBING-ON?>>
		<COND (<IS? ,CELLAR-DOOR ,OPENED>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<SETG P-IT-OBJECT ,CELLAR-DOOR>
		<TELL CTHE ,CELLAR-DOOR " at the top is closed." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-STAIRS? ,IN-KITCHEN>>>

<ROUTINE MIGHT-TRIP? ()
	 <COND (<VERB? PUT PUT-ON EMPTY-INTO THROW THROW-OVER>
		<TELL "Better not. You might trip on ">
		<COND (<IS? ,PRSO ,PLURAL>
		       <TELL "them">)
		      (T
		       <TELL "it">)>
		<TELL " later." CR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE HANDLE-STAIRS? (TOP "AUX" X)
	 <COND (<NOT <HERE? .TOP>>
		<SET TOP <>>)>
	 <COND (<THIS-PRSI?>
		<COND (<MIGHT-TRIP?>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " leads ">
		<COND (<T? .TOP>
		       <TELL "down">)
		      (T
		       <TELL "up">)>
		<TELL "ward." CR>
		<RTRUE>)
	       (<VERB? LOOK-UP>
		<COND (<T? .TOP>
		       <ALREADY-AT-TOP>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? LOOK-DOWN>
		<COND (<T? .TOP>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ALREADY-AT-BOTTOM>
		<RTRUE>)
	       (<VERB? FOLLOW USE>
		<COND (<T? .TOP>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<COND (<T? .TOP>
		       <ALREADY-AT-TOP>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<COND (<T? .TOP>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>
		<ALREADY-AT-BOTTOM>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<OBJECT PUB
	(LOC LOCAL-GLOBALS)
	(DESC "tavern")
	(FLAGS NODESC)
	(SYNONYM TAVERN PUB BAR SHANTY HOUSE LANTERN)
	(ADJECTIVE BROKEN LANTERN PUBLIC PUBLICK)
	(ACTION PUB-F)>

<ROUTINE PUB-F ("AUX" X)
	 <COND (<AND <HERE? IN-PUB>
		     <HERE-F>>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<HERE? OUTSIDE-PUB>
		       <DESCRIBE-PUB-SIGN>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "Mouthwatering aromas hang in the air." CR>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "Raucous laughter">
		<PRINT " fills the air">
		<TELL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PUB-SIGN
	(LOC OUTSIDE-PUB)
	(DESC "sign")
	(FLAGS NODESC READABLE SURFACE)
	(CAPACITY 7)
	(SYNONYM SIGN WORDS HOOK)
	(ADJECTIVE CURIOUS)
	(ACTION PUB-SIGN-F)>

<ROUTINE PUB-SIGN-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON HANG-ON EMPTY-INTO>
		       <COND (<PRSO? LANTERN PARASOL>
			      <COND (<SET X <FIRST? ,PRSI>>
				     <YOUD-HAVE-TO "remove" .X>
				     <RTRUE>)
				    (<AND <PRSO? PARASOL>
					  <IS? ,PRSO ,OPENED>>
				     <YOUD-HAVE-TO "close">
				     <RTRUE>)>
			      <WINDOW ,SHOWING-ALL>
			      <MOVE ,PRSO ,PRSI>
			      <TELL "You carefully hang " THEO>
			      <COND (<PRSO? LANTERN>
				     <TELL " back">)>
			      <TELL ,SON THEI ,PERIOD>
			      <RTRUE>)
			     (<VERB? HANG-ON>
			      <RFALSE>)>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)
		      (<VERB? PUT-UNDER>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<NOUN-USED? ,W?HOOK>
		<COND (<VERB? EXAMINE LOOK-ON>
		       <COND (<SET X <FIRST? ,PUB-SIGN>>
			      <TELL CA .X " hangs from it." CR>
			      <RTRUE>)>
		       <TELL ,XTHE "hook is empty." CR>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <FIRMLY-ATTACHED "hook" ,PRSO T>
		       <RTRUE>)>)>
	 <COND (<VERB? EXAMINE LOOK-ON READ>
		<DESCRIBE-PUB-SIGN>
		<RTRUE>)
	       (<VERB? PUSH TOUCH SWING SHAKE PULL LOOK-BEHIND>
		<TELL CTHEO " swings back and forth for a moment." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<FIRMLY-ATTACHED ,PRSO ,PUB>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LANTERN
	(LOC PUB-SIGN)
	(DESC "lantern")
	(SDESC DESCRIBE-LANTERN)
	(FLAGS TAKEABLE OPENED FERRIC)
	(SIZE 7)
	(VALUE 2)
	(SYNONYM LANTERN LAMP LIGHT SWITCH BATTERY)
	(ADJECTIVE LIGHT LAMP RUSTY RUSTED DARK ZZZP)
	(ACTION LANTERN-F)>


<ROUTINE LANTERN-F ("AUX" TBL X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <ITS-SEALED ,LANTERN>
		       <RTRUE>)>
		<RFALSE>)
	       (<NOUN-USED? ,W?BATTERY>
		<COND (<OR <SET TBL <SEEING?>>
			   <SET TBL <MOVING?>>
			   <VERB? REPAIR REPLACE>>
		       <ITS-SEALED ,LANTERN>
		       <RTRUE>)>)
	       (<NOUN-USED? ,W?SWITCH>
		<COND (<SET TBL <MOVING?>>
		       <FIRMLY-ATTACHED "switch" ,PRSO T>
		       <RTRUE>)
		      (<VERB? EXAMINE LOOK-ON>
		       <TELL CTHEO "'s switch is o">
		       <COND (<IS? ,PRSO ,OPENED>
			      <TELL "ff." CR>
			      <RTRUE>)>
		       <TELL "n." CR>
		       <RTRUE>)>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL CTHEO>
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL " is broken beyond repair." CR>
		       <RTRUE>)>
		<TELL " looks ">
		<COND (<IS? ,PRSO ,MAPPED> ; "Renewed?"
		       <TELL "good as new">)
		      (T
		       <TELL 
"much as you'd expect it to after years of hanging outdoors">)>
		<COND (<IS? ,PRSO ,LIGHTED>
		       <TELL ". Its glow is ">
		       <COND (<G? ,LAMP-LIFE 20>
			      <TELL "bright and strong." CR>
			      <RTRUE>)
			     (<G? ,LAMP-LIFE 10>
			      <TELL "a bit dim." CR>
			      <RTRUE>)>
		       <TELL "fading rapidly">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE OPEN UNPLUG>
		<ITS-SEALED ,LANTERN>
		<RTRUE>)
	       (<VERB? LAMP-ON USE>
		<COND (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-SWITCHED ,W?ON>
		       <RTRUE>)
		      (<CANT-REACH-LANTERN?>
		       <RTRUE>)>
		<UNMAKE ,PRSO ,OPENED>
		<ITALICIZE "Click">
		<TELL ". ">
		<COND (<OR <IS? ,PRSO ,MUNGED>
			   <ZERO? ,LAMP-LIFE>>
		       <TELL "Nothing happens." CR>
		       <RTRUE>)>
		<TELL CTHEO " emits a ">
		<COND (<G? ,LAMP-LIFE 20>
		       <TELL "brilliant">)
		      (T
		       <TELL "feeble">)>
		<TELL " glow." CR>
		<LIGHT-LANTERN>
		<RTRUE>)
	       (<VERB? LIGHT-WITH>
		<COND (<EQUAL? ,PRSI <> ,HANDS>
		       <PERFORM ,V?LAMP-ON ,PRSO>
		       <RTRUE>)>
	       	<TELL ,CANT "light " THEO ,WITH THEI ,PERIOD>
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-SWITCHED ,W?OFF>
		       <RTRUE>)
		      (<CANT-REACH-LANTERN?>
		       <RTRUE>)>
		<MAKE ,PRSO ,OPENED>
		<ITALICIZE "Click">
		<TELL ". ">
		<COND (<IS? ,PRSO ,LIGHTED>
		       <TELL CTHEO " goes out." CR>
		       <LANTERN-OUT>
		       <RTRUE>)>
		<TELL "You switch off " THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? MUNG HIT KICK>
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL "It's already broken enough." CR>
		       <RTRUE>)>
		<ITALICIZE "Bang">
		<TELL "! You smash " THEO ,WITH>
		<COND (<OR <VERB? KICK>
			   <PRSI? FEET>>
		       <TELL D ,FEET>)
		      (<EQUAL? ,PRSI <> ,HANDS>
		       <TELL "your fist">)
		      (T
		       <TELL THEI>)>
		<PRINT ,PERIOD>
		<BREAK-LANTERN>
		<RTRUE>)
	       (<AND <VERB? THROW>
		     <NOT <IS? ,PRSO ,MUNGED>>>
		<ITALICIZE "Smash">
		<TELL "!" CR>
		<BREAK-LANTERN>
		<RTRUE>)
	       (<AND <VERB? REPAIR>
		     <IS? ,PRSO ,MUNGED>>
		<TELL "You're not a member of the Guild of Lanternmakers." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE ITS-SWITCHED (WRD)
	 <TELL "It's already switched " B .WRD ,PERIOD>
	 <RTRUE>>

<ROUTINE CANT-REACH-LANTERN? ("AUX" L)
	 <SET L <LOC ,LANTERN>>
	 <COND (<EQUAL? .L ,PLAYER <LOC ,PLAYER>>
		<RFALSE>)
	       (<IS? .L ,SURFACE>
		<RFALSE>)>
	 <TAKE-FIRST ,LANTERN .L>
	 <RTRUE>>

<ROUTINE LIGHT-LANTERN ()
	 <WINDOW %<+ ,SHOWING-INV ,SHOWING-ROOM>>
	 <COND (<NO-LANTERN-HERE?>
		<RTRUE>)>
	 <QUEUE I-LANTERN>
	 <REPLACE-ADJ? ,LANTERN ,W?DARK ,W?LIGHTED>
	 <LIGHT-ROOM-WITH ,LANTERN>
	 <RTRUE>>

<ROUTINE NO-LANTERN-HERE? ("AUX" LEN)
	 <COND (<NOT <IS? ,URGRUE ,LIVING>>
		<RFALSE>)
	       (<IN? ,GRUE ,HERE>
		<EXUENT-MONSTER ,GRUE>)>
	 <COND (<GRUE-ROOM?>
		<VANISH ,LANTERN>
		<TELL ,TAB>
		<KERBLAM>
		<TELL "A bolt of lightning ">
		<COND (<NOT <HERE? IN-LAIR>>
		       <TELL "zigzags down the passageways, ">)>
		<TELL 
"strikes your lantern and blows it into little, tiny bits." CR>
		<COND (<IS? ,LANTERN ,LIGHTED>
		       <LANTERN-OUT>)>
		<CHUCKLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LANTERN-OUT ()
	 <WINDOW ,SHOWING-ALL>
	 <UNMAKE ,LANTERN ,LIGHTED>
	 <DEQUEUE ,I-LANTERN>
	 <REPLACE-ADJ? ,LANTERN ,W?LIGHTED ,W?DARK>
	 <SAY-IF-HERE-LIT>
	 <RTRUE>>

<ROUTINE BREAK-LANTERN ()
	 <UNMAKE ,PRSO ,SEEN>
	 <MAKE ,LANTERN ,MUNGED>
	 <WINDOW ,SHOWING-ALL>
	 <REPLACE-ADJ? ,LANTERN ,W?ZZZP ,W?BROKEN>
	 <COND (<IS? ,LANTERN ,LIGHTED>
		<LANTERN-OUT>)>	 
	 <RTRUE>>

<OBJECT GRUBBO
	(LOC LOCAL-GLOBALS)
	(DESC "village")
	(FLAGS NODESC PLACE)
	(SYNONYM VILLAGE TOWN GRUBBO)
	(ACTION GRUBBO-F)>

<ROUTINE GRUBBO-F ("AUX" X)
	 <COND (<NOT <HERE? HILLTOP N-MOOR AT-LEDGE>>
		<RETURN <HERE-F>>)
	       (<SET X <ENTERING?>>		    
		<SET X ,P?EAST>
		<COND (<HERE? N-MOOR>
		       <SET X ,P?NORTH>)
		      (<HERE? AT-LEDGE>
		       <SET X ,P?SW>)>
		<DO-WALK .X>
		<RTRUE>)
	       (<SET X <SEEING?>>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SHILL
	(DESC "shillelagh")
	(SDESC DESCRIBE-SHILL)
	(FLAGS NODESC TAKEABLE WEAPON NAMEABLE)
	(SYNONYM SHILLELAGH ZZZP CUDGEL CLUB DRIFTWOOD WOOD PIECE)
	(SIZE 5)
	(EFFECT 40)
	(EMAX 40)
	(ENDURANCE 3)
	(STRENGTH 5)
	(VALUE 10)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(DESCFCN DESCRIBE-WEAPONS)
	(ACTION SHILL-F)>

	
"BUOYANT = queue flag, NODESC = appearance delay."

<ROUTINE SHILL-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? TOUCH SWING SHAKE>
		<TELL "Feels hefty." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"Years of drifting on the open sea have toughened this stout club into a formidable skull-basher." CR>
		<RTRUE>)
	       (<AND <VERB? WHAT>
		     <NOUN-USED? ,W?SHILLELAGH>>
		<TELL "It's a club." CR>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<ITAKE>
		       <TELL ,XTHE B ,W?DRIFTWOOD
" begins to float out of reach as you bend over the side of the wharf. You strain your arm lower towards the water, lower... got it!" CR>
		       <GET-SHILL>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       		 
<ROUTINE GET-SHILL ()
	 <MAKE ,SHILL ,TOUCHED>
	 <DEQUEUE ,I-SHILL>
	 <MAKE ,SALT ,SEEN>
	 <TELL ,TAB "\"Found yerself a genu-ine " D ,SHILL " there, ">
	 <BOY-GIRL>
	 <TELL ",\" remarks the artist">
	 <COND (<IN? ,SHILL ,PLAYER>
		<TELL " as you shake off the seawater">)>
	 <TELL ". \"Come in handy nowadays.\"" CR>
	 <RTRUE>>

<OBJECT SWORD
	(LOC WCASE)
	(DESC "longsword")
	(SDESC DESCRIBE-SWORD)
	(FLAGS TAKEABLE TOOL FERRIC WEAPON NAMEABLE)
	(SYNONYM SWORD ZZZP LONGSWORD BLADE WEAPON)
	(ADJECTIVE ELVISH ELVIN LONG)
	(SIZE 7)
	(EFFECT 85)
	(EMAX 85)
	(VALUE 100)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(DESCFCN DESCRIBE-WEAPONS)
	(ACTION SWORD-F)>
	 

<ROUTINE SWORD-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "It's of elvish workmanship." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT AXE
	(LOC WCASE)
	(DESC "battleaxe")
	(SDESC DESCRIBE-AXE)
	(FLAGS TAKEABLE TOOL FERRIC WEAPON NAMEABLE)
	(SYNONYM AXE ZZZP AX BATTLEAXE WEAPON)
	(ADJECTIVE BATTLE)
	(SIZE 7)
	(EFFECT 75)
	(EMAX 75)
	(VALUE 40)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(DESCFCN DESCRIBE-WEAPONS)
	(ACTION AXE-F)>
	 

<ROUTINE AXE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"Just the thing for cleaving briskets, and other inconveniences." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT DAGGER
	(DESC "dagger")
	(SDESC DESCRIBE-DAGGER)
	(FLAGS NODESC TAKEABLE WEAPON TOOL MUNGED FERRIC NAMEABLE)
	(SYNONYM DAGGER ZZZP KNIFE BLADE WEAPON)
	(ADJECTIVE RUSTY RUSTED)
	(SIZE 2)
	(EFFECT 30)
	(EMAX 30)
	(VALUE 5)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(DESCFCN DESCRIBE-WEAPONS)
	(ACTION DAGGER-F)>


<ROUTINE DAGGER-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "It's a very basic " 'PRSO " with a ">
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL B ,W?RUSTY>)
		      (T
		       <TELL "razor-sharp">)>
		<TELL " blade." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PUBWALL
	(LOC IN-PUB)
	(DESC "wall")
	(FLAGS NODESC SURFACE)
	(SYNONYM WALL)
	(ACTION PUBWALL-F)>

<ROUTINE PUBWALL-F ("AUX" X)
	 <COND (<VERB? EMPTY TAKE>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<COND (<SET X <FIRST? ,PRSO>>
		       <TELL CA .X " is imbedded there." CR>
		       <RTRUE>)>
		<RFALSE>)>
	 <RETURN <HANDLE-WALLS?>>>	       

<OBJECT BOTTLE
	(LOC BARRELTOP)
	(DESC "wine bottle")
	(FLAGS TAKEABLE CONTAINER OPENABLE)
	(SYNONYM BOTTLE WINE LABEL BLANC MAILBOX HOUSE)
	(ADJECTIVE RED GRAY GREY WINE CHATEAU WHITE)
	(SIZE 5)
	(CAPACITY 4)
	(VALUE 5)
	(ACTION BOTTLE-F)>

"SEEN = tried opening box."

<ROUTINE BOTTLE-F ("AUX" (C 0))
	 <COND (<NOUN-USED? ,W?MAILBOX>
		<COND (<ZERO? ,LIT?>)
		      (<THIS-PRSI?>)
		      (<VERB? OPEN>
		       <COND (<NOT <IS? ,PRSO ,SEEN>>
			      <MAKE ,PRSO ,SEEN>
			      <TELL
"Opening the small mailbox reveals a leaflet" ,PTAB>
			      <KERBLAM>
			      <TELL 
"An Implementor appears in a dazzling flash! He slams the mailbox on " 
THE ,BOTTLE 
" shut, wags a disapproving finger and disappears before you can speak or move." CR>
			      <RTRUE>)>
		       <TELL ,CANT "open the ">
		       <PRINT "mailbox on the bottle's label">
		       <TELL ,PERIOD>
		       <RFATAL>)>
		<USELESS "mailbox on the bottle's label" T>
		<RFATAL>)
	       (<SEE-COLOR?>
		<INC C>
		<COND (<AND <ADJ-USED? ,W?GRAY ,W?GREY ,W?WHITE>
			    <NOT <NOUN-USED? ,W?HOUSE>>>
		       <TELL ,XTHE "wine in " THE ,BOTTLE 
			     " is red, not gray." CR>
		       <RFATAL>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? LOOK-THRU>
		       <COND (<PRSO? PRSI ME HEAD>
			      <IMPOSSIBLE>
			      <RTRUE>)>
		       <TELL "When viewed through " THEI ", ">
		       <COND (<PRSO? AMULET>
			      <COND (<ZERO? ,AMULET-WORD>
				     <SETUP-AMULET>)>
			      <WINDOW ,SHOWING-ALL>
			      <TELL "the word \"">
			      <PRINT-TABLE <GETP ,AMULET ,P?NAME-TABLE>>
			      <TELL 
"\" stands out clearly against the swirls and flourishes of the " 
'AMULET ,PERIOD>
			      <RTRUE>)>
		       <TELL THEO " appears ">
		       <COND (<T? .C>
			      <TELL "pale and ruddy." CR>
			      <RTRUE>)>
		       <TELL "gray and muddy." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE READ LOOK-INSIDE SEARCH>
		<COND (<VERB? EXAMINE READ>
		       <TELL ,XTHE "words \"">
		       <ITALICIZE "Chateau Blanc 877">
		       <TELL ", bottled by ">
		       <FROBOZZ "Wine">
		       <TELL ", Ltd\" appear on " THEO 
"'s label, above a picture of a white house with a small mailbox.">
		       <COND (<VERB? READ>
			      <CRLF>
			      <RTRUE>)>
		       <TELL C ,SP>)>
		<TELL "A pale ">
		<COND (<T? .C>
		       <TELL B ,W?RED>)
		      (T
		       <TELL B ,W?GRAY>)>
		<TELL 
" liquid swishes around inside. You can see right through it." CR>
		<RTRUE>)
	       (<VERB? SHAKE SPIN>
		<TELL ,XTHE>
		<COND (<T? .C>
		       <TELL B ,W?RED>)
		      (T
		       <TELL B ,W?GRAY>)>
		<TELL " liquid in " THEO " swishes around." CR>
		<RTRUE>)
	       (<VERB? OPEN DRINK DRINK-FROM>
		<TELL CTHEO " is tightly corked." CR>
		<RTRUE>)
	       (<VERB? OPEN-WITH>
		<TELL "You'll never open " THEO ,WITH THEI
		      ". Only a corkscrew will do." CR>
		<RTRUE>)
	       (<VERB? HIT MUNG KICK>
		<PRSO-SHATTER>
		<TELL ", and wine ">
		<PRINT "splashes all over the place.|">
		<RTRUE>)
	       (<AND <VERB? SPIN>
		     <EQUAL? ,P-PRSA-WORD ,W?SPIN>>
		<TELL "Lonely?" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CRATES
	(LOC LOCAL-GLOBALS)
	(DESC "stack of crates")
	(FLAGS NODESC)
	(SYNONYM STACK PILE HEAP BOXES CRATES CRATE SPIRAL)
	(ADJECTIVE WINE)
	(ACTION CRATES-F)>

<ROUTINE CRATES-F ()
	 <COND (<VERB? LOOK-INSIDE SEARCH OPEN OPEN-WITH>
		<TELL "They're all empty." CR>
		<RTRUE>)
	       (<VERB? SHAKE KICK PUSH>
		<TELL CTHEO " sways dangerously back and forth." CR>
		<RTRUE>)
	       (<HANDLE-STAIRS? ,BARRELTOP>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<OBJECT AMULET
	(LOC SKELETON)
	(DESC "amulet")
	(SDESC DESCRIBE-AMULET)
	(FLAGS VOWEL TAKEABLE CLOTHING FERRIC)
	(SIZE 1)
	(VALUE 12)
	(SYNONYM ZZZP AMULET CHAIN
	         RUNES RUNE SWIRLS FLOURISHES
	 	 STARS STAR)
	(ADJECTIVE ZZZP DARK GREEN RED)
	(NAME-TABLE 0)
	(ACTION AMULET-F)>


<GLOBAL AMULET-STARS:NUMBER 3>
<GLOBAL AMULET-WORD <>>

<ROUTINE SETUP-AMULET ("AUX" TBL)
	 <SET TBL <PICK-ONE ,MAGIC-WORDS>>
	 <PUT .TBL 2 1>
	 <SETG AMULET-WORD <GET .TBL 0>>
	 <PUTP ,AMULET ,P?NAME-TABLE <GET .TBL 1>>
	 <PUT <GETPT ,AMULET ,P?SYNONYM> 0 ,AMULET-WORD>
	 <PUT <GETPT ,AMULET ,P?ADJECTIVE> 0 ,AMULET-WORD>
	 <MAKE ,AMULET ,NAMED>
	 <MAKE ,AMULET ,IDENTIFIED>
	 <MAKE ,AMULET ,PROPER>
	 <RFALSE>>

<ROUTINE AMULET-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<OR <NOUN-USED? ,W?STARS ,W?STAR>
		    <ADJ-USED? ,W?SILVER>>
		<COND (<VERB? EXAMINE LOOK-ON READ>
		       <COND (<T? ,AMULET-TIMER>
			      <COND (<G? ,AMULET-STARS 1>
				     <PRINT "One of the stars">)
				    (T
				     <PRINT "The star">)>
			      <PRINT " on the amulet ">
			      <TELL "is glowing." CR>
			      <RTRUE>)>
		       <PRINT "The star">
		       <COND (<NOT <EQUAL? ,AMULET-STARS 1>>
			      <TELL "s">)>
		       <PRINT " on the amulet ">
		       <TELL "twinkle">
		       <COND (<EQUAL? ,AMULET-STARS 1>
			      <TELL "s">)>
		       <TELL " with hidden power." CR>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <PRINT "The star">
		       <COND (<G? ,AMULET-STARS 1>
			      <TELL "s are ">)
			     (T
			      <TELL ,SIS>)>
		       <ETCHED>
		       <RTRUE>)>)
	       (<OR <NOUN-USED? ,W?SWIRLS ,W?FLOURISHES>
		    <ADJ-USED? ,W?RED>>
		<COND (<VERB? EXAMINE LOOK-ON READ>
		       <TELL ,XTHE>
		       <SAY-RED>
		       <PRINT " swirls and flourishes">
		       <TELL " are skillfully wrought." CR>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <TELL ,XTHE "swirls are ">
		       <ETCHED>
		       <RTRUE>)>)
	       (<OR <NOUN-USED? ,W?RUNES ,W?RUNE>
		    <ADJ-USED? ,W?GREEN>>
		<COND (<VERB? READ EXAMINE LOOK-ON>
		       <READ-RUNES>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <TELL ,XTHE "runes are ">
		       <ETCHED>
		       <RTRUE>)>)>
	 <COND (<STRANGLE? ,AMULET>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " is inscribed with ">
		<SAY-GREEN>
		<TELL " runes, ">
		<PRINT "confusingly intertwined with ">
		<SAY-RED>
		<PRINT " swirls and flourishes">
		<COND (<G? ,AMULET-STARS 0>
		       <TELL ,AND>
		       <COND (<EQUAL? ,AMULET-STARS 1>
			      <TELL "a shiny star." CR>
			      <RTRUE>)
			     (<EQUAL? ,AMULET-STARS 2>
			      <TELL B ,W?TWO>)
			     (T
			      <TELL B ,W?THREE>)>
		       <TELL " shiny stars">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? READ>
		<READ-RUNES>
		<RTRUE>)
	       (<AND <VERB? SAY YELL>
		     <T? ,AMULET-WORD>
		     <NOUN-USED? ,AMULET-WORD>>
		<SAY-AMULET-WORD>
		<RTRUE>)
	       (<AND <VERB? WEAR>
		     <T? ,AMULET-TIMER>
		     <NOT <IS? ,PRSO ,WORN>>>
		<PUTON>
		<MEGA-STRENGTH>
		<RTRUE>)
	       (<AND <VERB? TAKE-OFF>
		     <T? ,AMULET-TIMER>
		     <IN? ,PRSO ,PLAYER>
		     <IS? ,PRSO ,WORN>>
		<TAKEOFF>
		<NORMAL-STRENGTH>
		<RTRUE>)
	       (T
		<RFALSE>)>>         

<ROUTINE STRANGLE? (OBJ "AUX" X)
	 <COND (<AND <SET X <TOUCHING?>>
		     <NOT <IS? ,SKELETON ,SEEN>>>
		<MAKE ,SKELETON ,SEEN>
		<SETG CHOKE <PERCENT 20 <GET ,STATS ,ENDURANCE>>>
		<COND (<ZERO? ,CHOKE>
		       <INC CHOKE>)>
		<QUEUE ,I-STRANGLE>
		<WINDOW ,SHOWING-ROOM>
		<SETG LAST-MONSTER ,SKELETON>
		<SETG LAST-MONSTER-DIR <>>
		<SETG P-IT-OBJECT ,SKELETON>
		<SETG P-HIM-OBJECT ,SKELETON>
		<TELL "You reach down to touch " THE .OBJ ".." ,PTAB>
		<CLAMP>
	        <BMODE-ON>
		<UPDATE-STAT <- 0 ,CHOKE>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CLAMP ()
	 <ITALICIZE "Snap">
	 <TELL "! Ten bony fingers clamp around your throat!" CR>
	 <RTRUE>>

<ROUTINE ETCHED ()
	 <TELL "permanently etched onto the " 'PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE READ-RUNES ()
	 <TELL ,XTHE>
	 <SAY-GREEN>
	 <TELL " runes are hard to see. They're ">
	 <PRINT "confusingly intertwined with ">
	 <TELL ,LTHE>
	 <SAY-RED>
	 <PRINT " swirls and flourishes">
	 <TELL " on the " 'PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE SAY-RED ()
	 <COND (<SEE-COLOR?>
		<TELL B ,W?RED>
		<RFALSE>)>
	 <TELL B ,W?GRAY>
	 <RFALSE>>

<ROUTINE SAY-GREEN ()
	 <COND (<SEE-COLOR?>
		<TELL B ,W?GREEN>
		<RFALSE>)>
	 <TELL B ,W?GRAY>
	 <RFALSE>>

<ROUTINE SAY-AMULET-WORD ()
	 <COND (<ZERO? ,AMULET-STARS>)
	       (<IS? ,AMULET ,NEUTRALIZED>)
	       (<NO-MAGIC-HERE? ,AMULET>
		<RTRUE>)
	       (<VISIBLE? ,AMULET>
		<COND (<T? ,AMULET-TIMER>
		       <STAR-FADES T>
		       <STOP-AMULET>
		       <COND (<WEARING-MAGIC? ,AMULET>
			      <NORMAL-STRENGTH>)>		       
		       <RTRUE>)
		      (<G? ,AMULET-STARS 1>
		       <PRINT "One of the stars">)
		      (T
		       <PRINT "The star">)>
		<PRINT " on the amulet ">
		<TELL "begins to glow." CR>
		<PUTP ,AMULET ,P?VALUE <- <GETP ,AMULET ,P?VALUE> 3>>
		<COND (<WEARING-MAGIC? ,AMULET>
		       <MEGA-STRENGTH>)>
		<LIGHT-ROOM-WITH ,AMULET>
		<SETG AMULET-TIMER 3>
		<QUEUE I-AMULET> 
		<RTRUE>)>
	 <NOTHING-HAPPENS <>>
	 <RTRUE>>	 

<ROUTINE MEGA-STRENGTH ("AUX" S)
	 <SET S <GET ,STATS ,STRENGTH>>
	 <COND (<L? .S 2>
		<SET S 9>)
	       (T
		<SET S <* 9 .S>>)>
	 <TELL ,TAB "A pulse of energy surges through your muscles!" CR>
	 <UPDATE-STAT .S ,STRENGTH>
	 <RTRUE>>

<ROUTINE NORMAL-STRENGTH ("AUX" S MAX)
	 <TELL ,TAB "The tension in your muscles subsides." CR>
	 <SET S <GET ,STATS ,STRENGTH>>	 
	 <SET MAX <GET ,MAXSTATS ,STRENGTH>>
	 <COND (<G? .S .MAX>
		<UPDATE-STAT <- 0 <- .S .MAX>> ,STRENGTH>)>
	 <RTRUE>>

<ROUTINE STOP-AMULET ()
	 <DEQUEUE I-AMULET>
	 <SETG AMULET-TIMER 0>
	 <UNMAKE ,AMULET ,LIGHTED>
	 <COND (<DLESS? AMULET-STARS 1>
		<SETG AMULET-STARS 0>
		<REPLACE-SYN? ,AMULET ,W?STAR ,W?ZZZP>
		<REPLACE-SYN? ,AMULET ,W?STARS ,W?ZZZP>
		<REPLACE-ADJ? ,AMULET ,W?SILVER ,W?ZZZP>)>
	 <COND (<VISIBLE? ,AMULET>
		<SAY-IF-HERE-LIT>)>
	 <RFALSE>>	 

<OBJECT KITCHEN
	(LOC LOCAL-GLOBALS)
	(DESC "kitchen")
	(FLAGS NODESC PLACE)
	(SYNONYM KITCHEN)
	(ACTION KITCHEN-F)>

<ROUTINE KITCHEN-F ("AUX" X)
	 <COND (<HERE? IN-KITCHEN>
		<RETURN <HERE-F>>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TEARS-PARASOL ("AUX" WRD1 WRD2)
	 <SET WRD1 ,W?OPENED>
         <SET WRD2 ,W?OPEN>
         <COND (<NOT <IS? ,PARASOL ,OPENED>>
		<SET WRD1 ,W?CLOSED>)>
         <REPLACE-ADJ? ,PARASOL .WRD1 ,W?BROKEN>
	 <MAKE ,PARASOL ,MUNGED>
	 <UNMAKE ,PARASOL ,OPENED>
         <UNMAKE ,PARASOL ,VOWEL>
	 <UNMAKE ,PARASOL ,BUOYANT>
	 <PUTP ,PARASOL ,P?VALUE 0>
	 <TELL " tears " THE ,PARASOL " from your grasp a little too soon">
	 <RFALSE>>
		
<OBJECT CROWN
	(LOC CRAB)
	(DESC "tiny crown")
	(FLAGS TAKEABLE FERRIC)
	(SIZE 1)
	(VALUE 20)
	(SYNONYM CROWN TREASURE)
	(ADJECTIVE TINY GOLD GOLDEN)
	(ACTION CROWN-F)>

<ROUTINE CROWN-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The tiny crown ">
		<COND (<IN? ,PRSO ,CRAB>
		       <TELL "on the crab's head ">)>
		<TELL 
"is exquisitely wrought in what appears to be solid gold." CR>
		<RTRUE>)
	       (<VERB? WEAR USE>
		<TELL "Your head is too fat." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<OBJECT GREAT-SEA
	(LOC LOCAL-GLOBALS)
	(DESC "sea")
	(FLAGS NODESC CONTAINER OPENED)
	(SYNONYM SEA OCEAN WATER WAVES)
	(ADJECTIVE GREAT FLATHEAD)
	(ACTION GREAT-SEA-F)>

<ROUTINE GREAT-SEA-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <WATER-VANISH>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " stretches east">
		<PRINT " as far as you can see">
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER SEARCH>
		<PRINT "Little can be seen ">
		<TELL "in the foamy waters." CR>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?EAST>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<TELL ,CANT "reach the water from here." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ACCARDI
	(LOC LOCAL-GLOBALS)
	(DESC "Accardi-by-the-Sea")
	(FLAGS NODESC PLACE)
	(SYNONYM ACCARDI ACCARDI\-BY\-THE\-SEA VILLAGE TOWN)
	(ACTION ACCARDI-F)>

<ROUTINE ACCARDI-F ("AUX" X)
	 <COND (<HERE? IN-ACCARDI>
		<RETURN <HERE-F>>)
	       (<SET X <ENTERING?>>
		<SET X ,P?WEST>
		<COND (<HERE? IN-HALL>
		       <SET X ,P?SOUTH>)
		      (<HERE? AT-BRINE>
		       <SET X ,P?NE>)>
		<DO-WALK .X>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT TOWER
	(LOC LOCAL-GLOBALS)
	(DESC "lighthouse")
	(FLAGS NODESC)
	(SYNONYM LIGHTHOUSE HOUSE)
	(ADJECTIVE LIGHT)
	(ACTION TOWER-F)>

<ROUTINE TOWER-F ("AUX" X)
	 <COND (<SET X <CLIMBING-ON?>>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<HERE-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<OBJECT TOWER-STEPS
	(LOC LOCAL-GLOBALS)
	(DESC "steps")
	(FLAGS NODESC PLURAL)
	(SYNONYM STEPS STAIR STAIRS STAIRWAY)
	(ACTION TOWER-STEPS-F)>

<ROUTINE TOWER-STEPS-F ()
	 <COND (<THIS-PRSI?>
		<COND (<MIGHT-TRIP?>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? CLIMB-ON CLIMB-UP CLIMB-OVER>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>
	        <RTRUE>)
	       (<VERB? COUNT>
		<TELL "There are fewer than 69,105 steps." CR>
		<RTRUE>)
	       (<VERB? LOOK-UP LOOK-DOWN>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BOUTIQUE-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY)
	(ADJECTIVE FRONT BOUTIQUE SHOP STORE)>

<OBJECT BOUTIQUE
	(LOC LOCAL-GLOBALS)
	(DESC "boutique")
	(FLAGS NODESC PLACE)
	(SYNONYM BOUTIQUE SHOP STORE BUILDING)
	(ACTION BOUTIQUE-F)>

<ROUTINE BOUTIQUE-F ("AUX" X)
	 <COND (<HERE? IN-BOUTIQUE>
		<RETURN <HERE-F>>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?NORTH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GONDOLA
	(LOC AT-DOCK)
	(DESC "gondola")
	(FLAGS NODESC VEHICLE CONTAINER OPENED)
	(SYNONYM GONDOLA SKYWAY SKYCAR CAR RIDE)
	(CAPACITY 100)
	(ACTION GONDOLA-F)>

<ROUTINE GONDOLA-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<SET OBJ ,PRSO>
		<COND (<THIS-PRSI?>
		       <SET OBJ ,PRSI>)>
		<COND (<EQUAL? .CONTEXT ,M-BEG>
		       <RETURN <CANT-REACH-WHILE-IN? .OBJ ,GONDOLA>>)
		      (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<IN? ,PLAYER ,GONDOLA>
			      <RFALSE>)
			     (<ZERO? .OBJ>
			      <RFALSE>)
			     (<SET X <TOUCHING?>>				
			      <YOUD-HAVE-TO "board" ,GONDOLA>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <SET X <ENTERING?>>
		     <NOT <IN? ,PLAYER ,PRSO>>>
		<COND (<AND <HERE? AT-DOCK>
			    <EQUAL? ,GON 0 1 14>>
		       <TELL "\"Wait yer turn, ">
		       <COND (<IS? ,PLAYER ,FEMALE>
			      <TELL B ,W?LADY>)
			     (T
			      <TELL "buddy">)>
		       <TELL ",\" growls a passenger in front of you." CR>
		       <RTRUE>)>
		<SETG OLD-HERE <>>
		<SETG P-WALK-DIR <>>
		<WINDOW ,SHOWING-ROOM>
		<MOVE ,WINNER ,PRSO>
		<UNMAKE ,PRSO ,NODESC>
		<COND (<HERE? AT-DOCK>
		       <TELL "You shove your way ">)
		      (T
		       <PRINT 
"Children tug their parents' sleeves and point as you clamber ">)>
		<TELL "into " THEO>
		<RELOOK>
		<RTRUE>)
	       (<AND <SET X <EXITING?>>
		     <IN? ,PLAYER ,PRSO>>
		<MAKE ,PRSO ,NODESC>
		<COND (<HERE? OVER-JUNGLE>
		       <JUNGLE-JUMP>
		       <RTRUE>)>
		<SETG OLD-HERE <>>
		<SETG P-WALK-DIR <>>
		<WINDOW ,SHOWING-ROOM>
		<MOVE ,WINNER ,HERE>
		<COND (<HERE? AT-DOCK>
		       <PRINT "You push your way ">
		       <TELL "out of " THEO>
		       <RELOOK>
		       <RTRUE>)>
		<PRINT 
"Children tug their parents' sleeves and point as you clamber ">
		<PRINT "over the gondola's edge">
		<RELOOK>
		<TELL ,TAB 
"\"Passengers will please remain seated,\" drones " THE ,CONDUCTOR ,PERIOD>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "A decal on the side says, \"">
		<FROBOZZ "Gondola">
		<TELL ,PERQ>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE JUNGLE-JUMP ()
	 <PRINT 
"Children tug their parents' sleeves and point as you clamber ">
	 <PRINT "over the gondola's edge">
	 <TELL ", and plummet to your death in the jungle far below">
	 <JIGS-UP>
	 <RFALSE>>		       

<OBJECT DGONDOLA
	(LOC LOCAL-GLOBALS)
	(DESC "gondola")
	(FLAGS NODESC)
	(SYNONYM GONDOLA RIDE SKYWAY SKYCAR CAR)
	(ACTION DGONDOLA-F)>

<ROUTINE DGONDOLA-F ("AUX" X)
	 <COND (<OR <SET X <TOUCHING?>>
		    <SET X <CLIMBING-ON?>>>
		<TELL CTHE ,DGONDOLA " is too far away now." CR>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <SEEING?>>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SUPPORT
	(LOC LOCAL-GLOBALS)
	(DESC "support tower")
	(FLAGS NODESC PLACE)
	(SYNONYM TOWER SUPPORT GIRDER GIRDERS LADDER)
	(ADJECTIVE SUPPORT STEEL SKINNY)
	(ACTION SUPPORT-F)>

<ROUTINE SUPPORT-F ("AUX" X)
	 <COND (<SET X <CLIMBING-ON?>>
		<COND (<HERE? OVER-JUNGLE>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<IN? ,PLAYER ,GONDOLA>
		       <PERFORM ,V?EXIT ,GONDOLA>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<COND (<HERE? OVER-JUNGLE>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<IN? ,PLAYER ,GONDOLA>
		       <NOT-ON ,SUPPORT>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<HERE? OVER-JUNGLE>
		<COND (<SET X <TOUCHING?>>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<SET X <SEEING?>>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT DOCK
	(LOC LOCAL-GLOBALS)
	(DESC "loading dock")
	(FLAGS NODESC PLACE)
	(SYNONYM DOCK GATE)
	(ADJECTIVE LOADING ENTRY ENTRANCE)
	(ACTION DOCK-F)>

<ROUTINE DOCK-F ("AUX" X)
	 <COND (<HERE? AT-DOCK>
		<RETURN <HERE-F>>)
	       (<SET X <TOUCHING?>>
		<CANT-FROM-HERE>)
	       (<SET X <SEEING?>>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ZBRIDGE
	(LOC LOCAL-GLOBALS)
	(DESC "bridge")
	(FLAGS NODESC SURFACE)
	(SYNONYM BRIDGE ROPES)
	(ADJECTIVE ROPE LONG NARROW)
	(ACTION ZBRIDGE-F)>

<ROUTINE ZBRIDGE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<OR <SET X <PUTTING?>>
			   <VERB? HANG-ON>>
		       <VANISH>
		       <TELL CTHEO>
		       <COND (<PRSO? PARASOL LANTERN>
			      <TELL " dangles uncertainly for a moment,">)>
		       <TELL 
" falls off the slippery ropes and plummets into the roaring water." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "The long, narrow " D ,PRSO " leads ">
		<COND (<HERE? ON-BRIDGE SFORD>
		       <TELL B ,W?NORTH>
		       <COND (<HERE? ON-BRIDGE>
			      <TELL ,AND B ,W?SOUTH>)>)
		      (T
		       <TELL B ,W?SOUTH>)>
		<TELL " across the roaring water." CR>
		<RTRUE>)
	       (<VERB? ENTER STAND-ON WALK-TO>
		<COND (<HERE? ON-BRIDGE>
		       <ALREADY-ON>
		       <RTRUE>)
		      (<HERE? SFORD>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<SET X ,P?NORTH>
		<COND (<HERE? SFORD>)
		      (<AND <HERE? ON-BRIDGE>
			    <EQUAL? <GETP ,HERE ,P?DNUM> "North">>)
		      (T
		       <SET X ,P?SOUTH>)>
		<DO-WALK .X>
		<RTRUE>)
	       (<OR <JUMPING-OFF?>
		    <VERB? STAND-UNDER>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<COND (<NOT <HERE? ON-BRIDGE>>
		       <NOT-ON>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SWALL
	(LOC LOCAL-GLOBALS)
	(DESC "wall of rock")
	(SDESC DESCRIBE-WALL)
	(FLAGS NODESC)
	(SYNONYM ZZZP WALL WALLS OUTLINE OPENING HOLE DOOR DOORWAY)
	(ADJECTIVE ZZZP STONE ROCK SMOOTH)
	(NAME-TABLE 0)
	(ACTION SWALL-F)>

<ROUTINE SWALL-F ("AUX" X)
	 <COND (<AND <NOUN-USED? ,W?OPENING ,W?HOLE>
		     <NOT <IS? ,SWALL ,OPENED>>>
		<NONE-HERE ,W?OPENING>
		<RFATAL>)
	       (<AND <NOT <IS? ,SWALL ,SEEN>>
		     <NOUN-USED? ,W?DOOR ,W?DOORWAY>>
		<NONE-HERE ,W?DOOR>
		<RFATAL>)
	       (<NOUN-USED? ,W?OUTLINE>
		<COND (<IS? ,SWALL ,OPENED>
		       <TELL ,XTHE B ,W?OUTLINE
			     " is now an " B ,W?OPENING ,PERIOD>
		       <RFATAL>)
		      (<NOT <IS? ,SWALL ,SEEN>>
		       <NONE-HERE ,W?OUTLINE>
		       <RFATAL>)>)>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? SAY YELL>
		     <T? ,WALL-WORD>
		     <OR <NOUN-USED? ,WALL-WORD>
			 <ADJ-USED? ,WALL-WORD>>>
		<SAY-WALL-WORD>
		<RTRUE>)
	       (<VERB? EXAMINE SEARCH LOOK-ON 
		       LOOK-INSIDE LOOK-BEHIND LOOK-UNDER>
		<COND (<IS? ,PRSO ,SEEN>
		       <SEE-DOORLIKE ,PRSO>
		       <COND (<HERE? SE-CAVE>
			      <TELL B ,W?SOUTHEAST C ,SP>)>
		       <TELL B ,W?WALL ,PERIOD>
		       <RTRUE>)>
		<SEAMLESS-WALL>
		<RTRUE>) 
	       (<VERB? ENTER WALK-TO THROUGH WALK-AROUND FOLLOW>
		<SET X ,P?SW>
		<COND (<HERE? NE-CAVE>
		       <SET X ,P?NE>)>
		<DO-WALK .X>
		<RTRUE>)
	       (<VERB? OPEN PUSH MOVE>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)
		      (<NOT <IS? ,SWALL ,SEEN>>
		       <SHOVE-STRAIN>
		       <RTRUE>)>
		<OPEN-SWALL>
		<WALLPUSH>
		<RTRUE>) 
	       (<VERB? CLOSE PULL>
		<COND (<NOT <IS? ,PRSO ,OPENED>>
		       <COND (<NOT <IS? ,SWALL ,SEEN>>
			      <NONE-HERE ,W?OPENING>
			      <RTRUE>)>
		       <ITS-ALREADY "closed">
		       <RTRUE>)>
		<CLOSE-SWALL>
		<WALLCLOSE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE WALLCLOSE ()
	 <TELL "You slowly pull the secret door shut." CR>
	 <RTRUE>>

<ROUTINE WALLPUSH ()
	 <TELL 
"You push against the outline on the wall with all your might, and an opening appears." CR>
	 <RTRUE>>

<ROUTINE NONE-HERE (WRD)
	 <TELL ,DONT "see any " B .WRD "s here." CR>
	 <RTRUE>>

<ROUTINE CLOSE-SWALL ()
	 <UNMAKE ,SWALL ,OPENED>
	 <NEW-EXIT? ,SE-WALL ,P?NW ,FCONNECT ,CANT-ENTER-WALL>
	 <NEW-EXIT? ,SE-WALL ,P?IN ,FCONNECT ,CANT-ENTER-WALL>
	 <NEW-EXIT? ,SE-CAVE ,P?SE ,FCONNECT ,CANT-ENTER-WALL>
         <NEW-EXIT? ,SE-CAVE ,P?OUT ,FCONNECT ,CANT-ENTER-WALL>
	 <UNMAKE ,SE-CAVE ,LIGHTED>
	 <PUTP ,SE-CAVE ,P?BEAM-DIR ,NO-MIRROR>
	 <REFLECTIONS>
	 <REFRESH-MAP>
	 <RTRUE>>

<ROUTINE OPEN-SWALL ("AUX" X)
	 <MAKE ,SWALL ,OPENED>
	 <NEW-EXIT? ,SE-WALL ,P?NW %<+ ,CONNECT 1 ,MARKBIT> ,SE-CAVE>
	 <NEW-EXIT? ,SE-WALL ,P?IN %<+ ,CONNECT 1 ,MARKBIT> ,SE-CAVE>
	 <NEW-EXIT? ,SE-CAVE ,P?SE %<+ ,CONNECT 1 ,MARKBIT> ,SE-WALL>
         <NEW-EXIT? ,SE-CAVE ,P?OUT %<+ ,CONNECT 1 ,MARKBIT> ,SE-WALL>
       	 <MAKE ,SE-CAVE ,LIGHTED>
	 <PUTP ,SE-CAVE ,P?BEAM-DIR ,I-SE>
	 <COND (<HERE? SE-CAVE>
		<SETG LIT? T>)>
	 <REFLECTIONS>
	 <COND (<NOT <HERE? SE-CAVE>>
		<REFRESH-MAP>)>
	 <RTRUE>>

<OBJECT NWALL
	(LOC LOCAL-GLOBALS)
	(DESC "wall of rock")
	(SDESC DESCRIBE-WALL)
	(FLAGS NODESC)
	(SYNONYM ZZZP WALL WALLS OUTLINE OPENING HOLE DOOR DOORWAY)
	(ADJECTIVE ZZZP ROCK STONE ZZZP)
	(NAME-TABLE 0)
	(ACTION NWALL-F)>

<ROUTINE NWALL-F ("AUX" X)
	 <COND (<AND <NOUN-USED? ,W?OPENING ,W?HOLE>
		     <NOT <IS? ,NWALL ,OPENED>>>
		<NONE-HERE ,W?OPENING>
		<RFATAL>)
	       (<AND <NOT <IS? ,NWALL ,SEEN>>
		     <NOUN-USED? ,W?DOOR ,W?DOORWAY>>
		<NONE-HERE ,W?DOOR>
		<RFATAL>)
	       (<NOUN-USED? ,W?OUTLINE>
		<COND (<IS? ,NWALL ,OPENED>
		       <TELL ,XTHE B ,W?OUTLINE
			     " is now an " B ,W?OPENING ,PERIOD>
		       <RFATAL>)
		      (<NOT <IS? ,NWALL ,SEEN>>
		       <NONE-HERE ,W?OUTLINE>
		       <RFATAL>)>)>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? SAY YELL>
		     <T? ,WALL-WORD>
		     <OR <NOUN-USED? ,WALL-WORD>
			 <ADJ-USED? ,WALL-WORD>>>
		<SAY-WALL-WORD>
		<RTRUE>)
	       (<VERB? EXAMINE SEARCH LOOK-ON 
		       LOOK-INSIDE LOOK-BEHIND LOOK-UNDER>
		<COND (<IS? ,NWALL ,SEEN>
		       <SEE-DOORLIKE ,PRSO>
		       <COND (<HERE? NE-CAVE>
			      <TELL B ,W?NORTHWEST C ,SP>)>
		       <TELL B ,W?WALL ,PERIOD>
		       <RTRUE>)>
		<SEAMLESS-WALL>
		<RTRUE>) 
	       (<VERB? ENTER WALK-TO THROUGH WALK-AROUND FOLLOW>
		<SET X ,P?SE>
		<COND (<HERE? NE-CAVE>
		       <SET X ,P?NW>)>
		<DO-WALK .X>
		<RTRUE>)
	       (<VERB? OPEN PUSH MOVE>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)
		      (<NOT <IS? ,NWALL ,SEEN>>
		       <SHOVE-STRAIN>
		       <RTRUE>)>
		<OPEN-NWALL>
		<WALLPUSH>
		<RTRUE>) 
	       (<VERB? CLOSE PULL>
		<COND (<NOT <IS? ,PRSO ,OPENED>>
		       <COND (<IS? ,NWALL ,SEEN>
			      <NONE-HERE ,W?OPENING>
			      <RTRUE>)>
		       <ITS-ALREADY "closed">
		       <RTRUE>)>
		<CLOSE-NWALL>
		<WALLCLOSE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<ROUTINE SEE-DOORLIKE (OBJ)
	 <PRINT "A doorlike ">
	 <COND (<IS? .OBJ ,OPENED>
		<TELL B ,W?OPENING>)
	       (T
		<TELL B ,W?OUTLINE>)>
	 <PRINT " is visible in the ">
	 <RFALSE>>		       

<ROUTINE SHOVE-STRAIN ()
	 <TELL
"You shove and strain against " THEO ", but to no avail." CR>
	 <RTRUE>>

<ROUTINE SEAMLESS-WALL ()
	 <TELL "All you see is a seamless wall of stone." CR>
	 <RTRUE>>

<ROUTINE CLOSE-NWALL ()
	 <UNMAKE ,NWALL ,OPENED>
	 <NEW-EXIT? ,NE-WALL ,P?SE ,FCONNECT ,CANT-ENTER-WALL>
	 <NEW-EXIT? ,NE-WALL ,P?IN ,FCONNECT ,CANT-ENTER-WALL>
	 <NEW-EXIT? ,NE-CAVE ,P?NW ,FCONNECT ,CANT-ENTER-WALL>
         <NEW-EXIT? ,NE-CAVE ,P?OUT ,FCONNECT ,CANT-ENTER-WALL>
       	 <UNMAKE ,NE-CAVE ,LIGHTED>
	 <REFRESH-MAP>
	 <RTRUE>>

<ROUTINE OPEN-NWALL ("AUX" X)
	 <MAKE ,NWALL ,OPENED>
	 <NEW-EXIT? ,NE-WALL ,P?SE %<+ ,CONNECT 1 ,MARKBIT> ,NE-CAVE>
	 <NEW-EXIT? ,NE-WALL ,P?IN %<+ ,CONNECT 1 ,MARKBIT> ,NE-CAVE>
	 <NEW-EXIT? ,NE-CAVE ,P?NW %<+ ,CONNECT 1 ,MARKBIT> ,NE-WALL>
         <NEW-EXIT? ,NE-CAVE ,P?OUT %<+ ,CONNECT 1 ,MARKBIT> ,NE-WALL>
         <MAKE ,NE-CAVE ,LIGHTED>
	 <COND (<HERE? NE-CAVE>
		<SETG LIT? T>)>
       	 <REFRESH-MAP>
	 <RTRUE>>

<OBJECT WEAPON-SHOP
	(LOC LOCAL-GLOBALS)
	(DESC "weapon shop")
	(FLAGS NODESC PLACE)
	(SYNONYM SHOP STORE BUILDING)
	(ADJECTIVE WEAPON)
	(ACTION WEAPON-SHOP-F)>

<ROUTINE WEAPON-SHOP-F ("AUX" X)
	 <COND (<HERE? IN-WEAPON>
		<RETURN <HERE-F>>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WEAPON-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "front door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY)
	(ADJECTIVE FRONT)>

<OBJECT MSHOPPE
	(LOC LOCAL-GLOBALS)
	(DESC "Magick Shoppe")
	(FLAGS NODESC PROPER PLACE)
	(SYNONYM SHOPPE SHOP STORE BUILDING)
	(ADJECTIVE YE OLDE MAGICK MAGIC)
	(ACTION MSHOPPE-F)>

<ROUTINE MSHOPPE-F ("AUX" X)
	 <COND (<HERE? IN-MAGICK>
		<RETURN <HERE-F>>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT MAGICK-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY)
	(ADJECTIVE FRONT)
	(ACTION MAGICK-DOOR-F)>

<ROUTINE MAGICK-DOOR-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? OPEN>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<TINKLES ,W?OPEN>
		<IOPEN>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <IS? ,PRSO ,OPENED>>
		<TINKLES ,W?CLOSE>
		<ICLOSE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TINKLES (WRD)
	 <TELL "As you " B .WRD C ,SP THEO
	       ", a concealed bell tinkles merrily." CR>
	 <RTRUE>>

<OBJECT LAMPHOUSE
	(LOC TOWER-TOP)
	(DESC "lamphouse")
	(FLAGS NODESC TRYTAKE NOALL CONTAINER OPENED)
	(SYNONYM LAMPHOUSE HOUSE GLASS DEBRIS)
	(ADJECTIVE LAMP)
	(CAPACITY 25)
	(ACTION LAMPHOUSE-F)>

<ROUTINE LAMPHOUSE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<GET-SEXTANT>
		<TELL CTHEO " is shattered beyond all usefulness">
		<COND (<SET X <FIRST? ,PRSO>>
		       <PRINT ". There seems to be something ">
		       <TELL "lying upon the debris within">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<GET-SEXTANT>
		<COND (<SET X <FIRST? ,PRSO>>
		       <SET X ,W?YOU>
		       <TELL "Sifting">)
		      (T
		       <SET X ,W?BUT>
		       <TELL "You sift">)>
		<TELL " through the debris, " B .X " discover ">
		<CONTENTS>
		<PRINT ,PERIOD>
		<SETG P-IT-OBJECT ,LAMPHOUSE>
		<RTRUE>)
	       (<VERB? LAMP-ON>
		<TELL "Not a chance." CR>
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<TELL "It's been off for a long time." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<TELL "The remains of " THEO>
		<PRINT " cannot be moved.|">
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<ROUTINE GET-SEXTANT ()
	 <COND (<IS? ,SEXTANT ,NODESC>
		<UNMAKE ,SEXTANT ,NODESC>
		<MOVE ,SEXTANT ,PRSO>
		<WINDOW ,SHOWING-ROOM>)>
	 <RFALSE>>

<OBJECT SEXTANT
	(DESC "antique sextant")
	(FLAGS NODESC TAKEABLE FERRIC VOWEL)
	(SYNONYM SEXTANT INSTRUMENT)
	(ADJECTIVE PLATINUM ANTIQUE)
	(SIZE 5)
	(VALUE 20)
	(ACTION SEXTANT-F)>

<ROUTINE SEXTANT-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL
"A quaint but obsolete instrument, long since replaced by Kaluzniacki's ">
		<ITALICIZE "nonav">
		<TELL 
" spell. Nevertheless, even he would have hesitated to throw this sextant away, as it appears to be wrought of solid platinum." CR>
		<RTRUE>)
	       (<VERB? POINT-AT TURN-TO ADJUST OPEN OPEN-WITH CLOSE>
		<TELL 
"You have no idea how to operate this arcane instrument." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<OBJECT CHEST
	(LOC TOWER-TOP)
	(DESC "sea chest")
	(FLAGS TAKEABLE CONTAINER OPENABLE READABLE)
	(CAPACITY 20)
	(SIZE 20)
	(VALUE 10)
	(SYNONYM CHEST BOX TRUNK LID COVER PLATE)
	(ADJECTIVE SEA BRASS METAL)
	(DESCFCN CHEST-F)
	(ACTION CHEST-F)>

<ROUTINE CHEST-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL 
"An old " 'CHEST " lies half-buried in debris.">
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TOUCHING?>>
		<COND (<AND <HERE? TOWER-TOP>
			    <IS? ,DORN ,LIVING>
			    <IS? ,DORN ,NODESC>>
		       <UNMAKE ,DORN ,NODESC>
		       <QUEUE ,I-DORN>
		       <MOVE ,DORN ,TOWER-TOP>
		       <SEE-CHARACTER ,DORN>
		       <WINDOW ,SHOWING-ROOM>
		       <PRINT "As you reach towards the chest, you ">
		       <TELL
"hear a loud \"Hurumph!\" immediately behind you." CR>
		       <COND (<OR <ZERO? ,DMODE>
				  <NOT <EQUAL? ,PRIOR 0 ,SHOWING-ROOM>>>
			      <RELOOK T>)>
		       <RTRUE>)
		      (<AND <VISIBLE? ,DORN>
			    <NOT <IS? ,DORN ,MUNGED>>>
		       <TELL CTHE ,DORN " won't let you near " THE ,CHEST
			     ,PERIOD>
		       <RTRUE>)>)>
	 <COND (<NOUN-USED? ,W?LID ,W?COVER>
		<COND (<VERB? LOOK-UNDER LOOK-BEHIND>
		       <PERFORM ,V?LOOK-INSIDE ,CHEST>
		       <RTRUE>)
		      (<VERB? OPEN RAISE>
		       <OPEN-CHEST>
		       <RTRUE>)>)
	       (<OR <NOUN-USED? ,W?PLATE>
		    <ADJ-USED? ,W?BRASS ,W?METAL>>
		<COND (<VERB? EXAMINE LOOK-ON READ>
		       <READ-PLATE>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <FIRMLY-ATTACHED "brass plate" ,CHEST T>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO>
		       <COND (<NOT <IS? ,PRSI ,OPENED>>
			      <YOUD-HAVE-TO "open" ,PRSI>
			      <RTRUE>)
			     (<AND <PRSO? PARASOL>
				   <IS? ,PRSO ,OPENED>>
			      <YOUD-HAVE-TO "close">
			      <RTRUE>)>
		       <RFALSE>)
		      (<VERB? PUT-ON>
		       <COND (<IS? ,PRSI ,OPENED>
			      <YOUD-HAVE-TO "close" ,PRSI>
			      <RTRUE>)>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? TAKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <YOUD-HAVE-TO "close">
		       <RTRUE>)
		      (<ITAKE>
		       <PUTP ,PRSO ,P?DESCFCN 0>
		       <TELL "Taken." CR>)>
		<RTRUE>)
	       (<VERB? READ>
		<READ-PLATE>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"The oak chest is compact and sturdy, probably the craft of Antharian dwarves. No latch or keyhole is visible, but a brass plate is affixed to the top of the ">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL B ,W?OPEN>)
		      (T
		       <TELL B ,W?CLOSED>)>
		<TELL " lid." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<OPEN-CHEST>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE READ-PLATE ()
	 <MAKE ,CHEST ,SEEN>
	 <TELL "The brass plate on " THEO 
"'s lid is engraved with a simple warning in many languages, including yours: ">
	 <PRINT "\"Do Not Open This Chest.\"|">
	 <RTRUE>>

<ROUTINE OPEN-CHEST ("AUX" L)
	 <SET L <LOC ,CHEST>>
	 <COND (<NOT <EQUAL? .L <LOC ,PLAYER>>>
		<YOUD-HAVE-TO "put down" ,CHEST>
		<RTRUE>)
	       (<IS? ,CHEST ,OPENED>
		<ITS-ALREADY "open">
		<RTRUE>)
	       (<IS? ,IN-SPLENDOR ,TOUCHED>)
	       (<NOT <IS? ,CHEST ,SEEN>>
		<MAKE ,CHEST ,SEEN>
		<PRINT "As you reach towards the chest, you ">
		<TELL "notice a brass plate inscribed with the words ">
		<PRINT "\"Do Not Open This Chest.\"|">
		<RTRUE>)>
       
       ; "This clause added 5/20/88. -- Prof"

	 <COND (<OR <IN? ,PLAYER ,ARCH>
		    <NOT <EQUAL? ,ATIME ,PRESENT>>>
		<TELL
"The arch's presence keeps the chest tightly shut." CR>
		<RTRUE>)
	       (<AND <HERE? APLANE>
		     <EQUAL? ,ABOVE ,OPLAIN>>
		<PERMISSION>
		<RTRUE>)>
	 
	 <TO-SPLENDOR>
	 <RTRUE>>
	  
<ROUTINE TO-SPLENDOR ("OPT" WHO "AUX" DIR X Y)
	 <PUTP ,IN-SPLENDOR ,P?FNUM <GETP ,HERE ,P?FNUM>>
	 <SET DIR ,P?NW>
	 <REPEAT ()
	    <SET X ,SORRY-EXIT>
	    <SET Y "Lush vegetation blocks your path.">
	    <COND (<PROB 50>
		   <SET X %<+ ,CONNECT 9 ,MARKBIT>>
		   <SET Y ,IN-SPLENDOR>)>
	    <NEW-EXIT? ,IN-SPLENDOR .DIR .X .Y>
	    <COND (<IGRTR? DIR ,P?NORTH>
		   <RETURN>)>>
	 <SAFE-VEHICLE-EXIT>
	 <MOVE ,HERD ,IN-SPLENDOR>
	 <QUEUE ,I-MARE-SEES 3>
	 <DESCRIBE-GATE>
	 <CARRIAGE-RETURNS>
	 <GOTO ,IN-SPLENDOR>
	 <RTRUE>>

<ROUTINE DESCRIBE-GATE ("OPT" WHO)
	 <PCLEAR>
	 <MAKE ,CHEST ,OPENED>
	 <COND (<IS? ,PHASE ,NOALL>
		<UNMAKE ,PHASE ,NOALL>
		<QUEUE ,I-PHASE>)>
	 <TELL "Rays of golden light burst from " THE ,CHEST
	       "'s interior as the lid creaks open. ">
	 <COND (<ASSIGNED? WHO>
		<TELL CTHE .WHO " is">)
	       (T
		<TELL "You're">)>
	 <TELL 
" bathed in a chorus of radiant ecstasy that almost drowns out the telltale ">
	 <HLIGHT ,H-ITALIC>
	 <TELL "snap">
	 <HLIGHT ,H-NORMAL>
	 <TELL " of an opening Gate." CR>
	 <COND (<ASSIGNED? WHO>
		<WINDOW ,SHOWING-ALL>
		<TELL ,TAB "When your head clears, " THE .WHO
		      " is gone without a trace." CR>)>
	 <RTRUE>>

<OBJECT HERD
	(DESC "herd of unicorns")
        (FLAGS TRYTAKE NOALL LIVING PERSON)
	(SYNONYM HERD UNICORNS UNICORN MARES COLTS PONIES HORN HORNS
	 	 KEY KEYS)
	(ADJECTIVE UNICORN)
	(GENERIC GENERIC-KEYS-F)
	(DESCFCN HERD-F)
	(ACTION HERD-F)>

<ROUTINE HERD-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,HERD
			     " grazes peacefully among the trees.">
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"This herd is mostly mares and colts, who rub their horns affectionately against their mothers' flanks. Oddly, every unicorn is wearing a gold key on a chain around its neck." CR>
		<RTRUE>)
	       (<OR <SET X <TOUCHING?>>
		    <SET X <CLIMBING-ON?>>>
		<UNICORNS-FLEE>
		<RTRUE>)
	       (T
		<RFALSE>)>>		
	 
<ROUTINE UNICORNS-FLEE ("OPT" STR)
	 <PCLEAR>
	 <DEQUEUE ,I-MARE-SEES>
	 <QUEUE ,I-ARREST 2>
	 <REMOVE ,HERD>
	 <WINDOW ,SHOWING-ROOM>
	 <TELL "One of the mares glances up ">
	 <COND (<ASSIGNED? STR>
		<TELL .STR>)
	       (T
		<TELL "as you draw closer">)>
	 <TELL
". Her nostrils flare with surprise, and a high-pitched voice in your head cries, \"">
	 <COND (<IS? ,HERD ,SEEN>
		<TELL "Another i">)
	       (T
		<TELL "I">)>
	 <TELL "ntruder!\"|
  The herd springs to full alert. Mothers nudge their frightened colts out of sight, then gallop away between the trees. Within moments, the glade is completely deserted." CR>
	 <RTRUE>>
	        
<OBJECT PHASE
	(LOC CHEST)
	(DESC "phase blade")
	(SDESC DESCRIBE-PHASE)
	(FLAGS TAKEABLE NOALL NAMEABLE)
	(SYNONYM OUTLINE ZZZP SHAPE ZZZP)
	(ADJECTIVE VAGUE)
	(SIZE 0)
	(EFFECT 0)
	(VALUE 20)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(DESCFCN DESCRIBE-WEAPONS)
	(ACTION SOFT-PHASE-F)>

"NOALL = never seen."


<ROUTINE HARD-PHASE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<TELL 
"The sharp blade blazes in a rainbow of anticipation." CR>
		<SHAPESEE>
		<RTRUE>)
	       (<VERB? SWING>
		<HUMS>
		<TELL "swings, a blazing streak of color in its wake." CR>
		<SHAPESEE>
		<RTRUE>)
	       (T
		<RFALSE>)>>		        

<ROUTINE SHAPESEE ()
	 <COND (<IN? ,SHAPE ,HERE>
		<TELL ,TAB CTHE ,SHAPE " quivers nervously." CR>)>
	 <RTRUE>>

<ROUTINE HUMS ()
	 <WHOOSH>
	 <TELL CTHE ,PHASE " hums with Magick as it ">
	 <RTRUE>>

<ROUTINE SOFT-PHASE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? TOUCH-TO>
		       <COND (<PRSO? HANDS>
			      <FEEL-PHASE>
			      <RTRUE>)>
		       <PASS-THRU ,PRSO ,PRSI>
		       <RTRUE>)
		      (<VERB? HIT MUNG CUT>
		       <PHASE-WHOOSH>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <SEEING?>>
		<COND (<IS? ,PRSO ,NODESC>
		       <TELL "You still can't see " THEO ,PERIOD>
		       <RTRUE>)>
		<MAKE ,PHASE ,NODESC>
		<MAKE ,PHASE ,SEEN>
		<WINDOW ,SHOWING-ALL>
		<TELL CTHEO 
" disappears the moment you set eyes on it." CR>
		<RTRUE>)
	       (<VERB? TOUCH-TO>
		<COND (<EQUAL? ,PRSI <> ,HANDS>
		       <FEEL-PHASE>
		       <RTRUE>)>
		<PASS-THRU ,PRSO ,PRSI>
		<RTRUE>)
	       (<VERB? TOUCH HIT SQUEEZE>
		<COND (<EQUAL? ,PRSI <> ,HANDS>
		       <FEEL-PHASE>
		       <RTRUE>)>
		<PASS-THRU ,PRSI ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE PHASE-WHOOSH ()
	 <WHOOSH>
	 <TELL "You swing " THEI ", but it">
	 <RIGHT-THRU>
	 <RFALSE>>

<ROUTINE PASS-THRU (OBJ1 OBJ2)
	 <TELL "Oddly enough, " THE .OBJ1>
	 <RIGHT-THRU .OBJ2>
	 <RTRUE>>

<ROUTINE PASSES-THROUGH (WITH OBJ)
         <YOUR-OBJ .WITH>
	 <RIGHT-THRU .OBJ T>
	 <TELL " as if it weren't there!" CR>
	 <RTRUE>>

<ROUTINE RIGHT-THRU ("OPT" (OBJ ,PRSO) NOCR)
	 <TELL " passes right through " THE .OBJ>
	 <COND (<NOT <ASSIGNED? NOCR>>
		<TELL ,PERIOD>)>
	 <RTRUE>>

<ROUTINE FEEL-PHASE ()
	 <TELL
"You feel a cool, sharp sensation, like brushing against the edge of a knife. But " THE ,PHASE " seems">
	 <PRINT " to possess no physical substance.|">
	 <RTRUE>>

<VOC "PHASE" ADJ>

<ROUTINE SETUP-PHASE ("AUX" TBL)
	 <WINDOW ,SHOWING-INV>
	 <DEQUEUE ,I-PHASE>
	 <UNMAKE ,PHASE ,NODESC>
	 <PUTP ,PHASE ,P?ACTION ,HARD-PHASE-F>
	 <PUTP ,PHASE ,P?SIZE 7>
	 <PUTP ,PHASE ,P?EFFECT 75>
	 <MAKE ,PHASE ,WEAPON>
	 <SET TBL <GETPT ,PHASE ,P?SYNONYM>>
	 <PUT .TBL 0 ,W?SWORD>
	 <PUT .TBL 2 ,W?BLADE>
	 <PUT .TBL 3 ,W?WEAPON>
	 <REPLACE-ADJ? ,PHASE ,W?VAGUE ,W?PHASE>
	 <RFALSE>>

<ROUTINE MUNG-PHASE ("AUX" TBL)
	 <WINDOW ,SHOWING-INV>
	 <QUEUE ,I-PHASE>
	 <UNMAKE ,PHASE ,NODESC>
	 <UNMAKE ,PHASE ,SEEN>
	 <PUTP ,PHASE ,P?ACTION ,SOFT-PHASE-F>
	 <PUTP ,PHASE ,P?SIZE 0>
	 <PUTP ,PHASE ,P?EFFECT 0>
	 <UNMAKE ,PHASE ,WEAPON>
	 <SET TBL <GETPT ,PHASE ,P?SYNONYM>>
	 <PUT .TBL 0 ,W?OUTLINE>
	 <PUT .TBL 2 ,W?SHAPE>
	 <PUT .TBL 3 ,W?ZZZP>
	 <REPLACE-ADJ? ,PHASE ,W?PHASE ,W?VAGUE>
	 <RFALSE>>
	 
<OBJECT THRONE
	(LOC THRONE-ROOM)
	(DESC "nest of seashells")
	(FLAGS NODESC TRYTAKE SURFACE CONTAINER OPENED)
	(SYNONYM NEST PILE HEAP SHELLS DEBRIS SHELL SEASHELL SEASHELLS)
	(CAPACITY 25)
	(ACTION THRONE-F)>

<ROUTINE THRONE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<GET-DOUBLOON?>
		<TELL "The material is heaped into a crude throne">
		<COND (<SET X <FIRST? ,PRSO>>
		       <PRINT ". On it you see ">
		       <CONTENTS>)>
		<PRINT ,PERIOD>
		<SETG P-IT-OBJECT ,PRSO>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<GET-DOUBLOON?>
		<COND (<SET X <FIRST? ,PRSO>>
		       <SET X ,W?YOU>
		       <TELL "Sifting">)
		      (T
		       <SET X ,W?BUT>
		       <TELL "You sift">)>
		<TELL " through the material in " THEO ", " B .X " discover ">
		<CONTENTS>
		<PRINT ,PERIOD>
		<SETG P-IT-OBJECT ,PRSO>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<TELL "None of it seems worth moving">
		<COND (<GET-DOUBLOON?>
		       <SETG P-IT-OBJECT ,DOUBLOON>
		       <TELL ", except for " THE ,DOUBLOON
			     " you just noticed">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<ROUTINE GET-DOUBLOON? ()
	 <COND (<IS? ,DOUBLOON ,NODESC>
		<UNMAKE ,DOUBLOON ,NODESC>
		<MOVE ,DOUBLOON ,PRSO>
		<WINDOW ,SHOWING-ROOM>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT DOUBLOON
	(DESC "gold doubloon")
	(FLAGS NODESC TAKEABLE FERRIC)
	(SYNONYM DOUBLOON COIN MONEY GOLD)
	(ADJECTIVE GOLD GOLDEN)
	(SIZE 0)
	(VALUE 10)
	(ACTION DOUBLOON-F)>

<ROUTINE DOUBLOON-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "Obviously of significant value." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT STAVE
	(DESC "stave")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE BUOYANT)
	(SYNONYM ZZZP STAVE)
	(ADJECTIVE ZZZP)
	(SIZE 2)
	(ENDURANCE 3)
	(STRENGTH 5)
	(VALUE 10)
	(DESCFCN 0)
	(ACTION 0)>

<OBJECT STAFF
	(DESC "staff")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE BUOYANT)
	(SYNONYM ZZZP STAFF)
	(ADJECTIVE ZZZP)
	(SIZE 1)
	(ENDURANCE 3)
	(STRENGTH 5)
	(VALUE 10)
	(DESCFCN 0)
	(ACTION 0)>

<OBJECT WAND
	(DESC "wand")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE BUOYANT)
	(SYNONYM ZZZP WAND)
	(ADJECTIVE ZZZP)
	(SIZE 1)
	(ENDURANCE 3)
	(STRENGTH 5)
	(VALUE 10)
	(DESCFCN 0)
	(ACTION 0)>

<OBJECT STICK
	(DESC "stick")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE BUOYANT)
	(SYNONYM ZZZP STICK)
	(ADJECTIVE ZZZP)
	(SIZE 1)
	(ENDURANCE 3)
	(STRENGTH 5)
	(VALUE 10)
	(DESCFCN 0)
	(ACTION 0)>

<OBJECT ROD
	(DESC "rod")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE BUOYANT)
	(SYNONYM ZZZP ROD)
	(ADJECTIVE ZZZP)
	(SIZE 3)
	(ENDURANCE 3)
	(STRENGTH 5)
	(VALUE 10)
	(DESCFCN 0)
	(ACTION 0)>

<OBJECT CANE
	(DESC "cane")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE BUOYANT)
	(SYNONYM ZZZP CANE)
	(ADJECTIVE ZZZP)
	(SIZE 3)
	(ENDURANCE 3)
	(STRENGTH 5)
	(VALUE 10)
	(DESCFCN 0)
	(ACTION 0)>



<ROUTINE TELE-WAND-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? ZAP-WITH>
		       <DO-TELE ,PRSO ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? POINT-AT TOUCH-TO FIRE-AT>
		<DO-TELE ,PRSI ,PRSO>
		<RTRUE>)
	       (<HANDLE-WANDS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-TELE (OBJ W "AUX" S L LEN RM)
	 <COND (<DONT-HAVE-WAND? .OBJ .W>
		<RTRUE>)
	       (<NOT-LIVING? .OBJ .W>
		<RTRUE>)
	       (<OUT-OF-GAS? .W>
		<RTRUE>)>
	 <SET S <WAND-STRENGTH? .W>>
	 <SET L <LOC .OBJ>>
	 <TELL "A ray of hard blue ">
	 <EXPLODES .W>
	 <COND (<OR <EQUAL? .OBJ ,ME ,HANDS ,FEET>
		    <EQUAL? .OBJ ,GRINDER>
		    <EQUAL? .L ,PLAYER>
		    <IN? .L ,PLAYER>>
		<COND (<EQUAL? .OBJ ,GRINDER>
		       <QUICKER>
		       <TELL
" and uses the lid to reflect the ray back into your face">)>
		<SET LEN <GETB ,TELEROOMS 0>>
		<PROG ()
		   <SET RM <GETB ,TELEROOMS <RANDOM .LEN>>>
		   <COND (<EQUAL? .RM ,HERE>
			  <AGAIN>)>>
		<TELL "! You're engulfed">
		<PRINT " in a dizzy maelstrom of sound and motion">
		<TELL "..." CR>
		<SETG P-WALK-DIR <>>
		<SETG OLD-HERE <>>
		<SAFE-VEHICLE-EXIT>
		<CARRIAGE-RETURNS>
		<GOTO .RM>
		<TELL ,TAB ,XTHE B ,W?LANDSCAPE " stops reeling">)
	       (<IS? .OBJ ,MONSTER>
		<COND (<NOT <EQUAL? .OBJ ,DUST ,WIGHT>>
		       <MAKE .OBJ ,SLEEPING>
		       <MAKE .OBJ ,NEUTRALIZED>
		       <TELEPORT-MONSTER .OBJ>)>
		<TELL ", engulfing " THE .OBJ> 
		<PRINT " in a dizzy maelstrom of sound and motion">
		<TELL ,PERIOD>
		<COND (<EQUAL? .OBJ ,DUST>
		       <COND (<NOT <IS? .OBJ ,TOUCHED>>
			      <START-DUST>)>
		       <UNMAKE .OBJ ,SEEN>
		       <UPDATE-STAT <- 0 <GETP .W ,P?STRENGTH>> ,STRENGTH>
		       <RTRUE>)>
		<TELL ,TAB>
		<ITALICIZE "Poof">
		<TELL ". " CTHE .OBJ>
		<COND (<EQUAL? .OBJ ,WIGHT>
		       <PRINT " disappears in a spectral flash">
		       <TELL 
", rematerializing ten feet beyond the edge of the cliff. It">
		       <PRINT " gives you a puzzled frown">
		       <TELL 
", looks down, looks back up at you, waves goodbye and plummets out of sight">)
		      (T
		       <TELL " is nowhere to be seen">)>)
	       (T
		<PRINT ", barely missing its wide-eyed target">)>
	 <PRINT ,PERIOD>
	 <UPDATE-STAT <- 0 <GETP .W ,P?STRENGTH>> ,STRENGTH>
	 <COND (<EQUAL? .OBJ ,WIGHT>
		<KILL-MONSTER ,WIGHT>)>
	 <STARTLE .OBJ .W>
	 <RTRUE>>
       
<ROUTINE EXPLODES (W)
	 <TELL "Magick explodes from the tip of " THE .W>
	 <RTRUE>>

<ROUTINE TELEPORT-MONSTER (OBJ "AUX" TBL LEN RM)
	 <SET TBL <GETP .OBJ ,P?HABITAT>>
	 <SET LEN <GETB .TBL 0>>
	 <PROG ()
	    <SET RM <GETB .TBL <RANDOM .LEN>>>
	    <COND (<EQUAL? .RM ,HERE>
		   <AGAIN>)>>
	 <EXUENT-MONSTER .OBJ>
	 <MOVE .OBJ .RM>
	 <RFALSE>>
	 

<ROUTINE SLEEP-WAND-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? ZAP-WITH>
		       <DO-SLEEP ,PRSO ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? POINT-AT TOUCH-TO FIRE-AT>
		<DO-SLEEP ,PRSI ,PRSO>
		<RTRUE>)
	       (<HANDLE-WANDS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-SLEEP (OBJ W "AUX" S LEN)
	 <COND (<DONT-HAVE-WAND? .OBJ .W>
		<RTRUE>)
	       (<NOT-LIVING? .OBJ .W>
		<RTRUE>)
	       (<OUT-OF-GAS? .W>
		<RTRUE>)>
	 <SET S <WAND-STRENGTH? .W>>
	 <TELL "A beam of soothing amber radiance ">
	 <COND (<EQUAL? .OBJ ,ME>
		<SETG ATTACK-MODE ,THRUSTING>
		<TELL "forces you to stifle a yawn." CR>
		<UPDATE-STAT .S ,STRENGTH>
		<RTRUE>)>
	 <TELL "envelops " THE .OBJ " as you train " THE .W " upon ">
	 <PRONOUN .OBJ T>
	 <SET LEN <GET ,NO-SLEEPS 0>>
	 <COND (<EQUAL? .OBJ ,DACT>
		<COND (<T? ,DACT-SLEEP>
		       <COND (<NOT <EQUAL? ,DACT-SLEEP 3>>
			      <INC DACT-SLEEP>)>
		       <TELL ", and he snuggles deeper into his nap." CR>
		       <UPDATE-STAT .S ,STRENGTH>
		       <RTRUE>)>
	        <TELL ,PTAB CTHE .OBJ>
		<DACT-TO-SLEEP>)
	       (<EQUAL? .OBJ ,DORN>
		<TELL 
". Two or three of its 69 eyes flutter drowsily." CR>)
	       (<EQUAL? .OBJ ,OWOMAN>
		<TELL ,PTAB 
"\"Stop it!\" she laughs, brushing aside the beam with a wave. \"That tickles.\"" CR>)
	       (<EQUAL? .OBJ ,CORBIES>
		<TELL 
". A few seem to hesitate in their flight; but they recover quickly." CR>)
	       (<EQUAL? .OBJ ,PUPP>
		<TELL ,PTAB CTHE .OBJ 
" promptly mimics your action, using its third finger to represent your " 
		      D .W ,PERIOD>)
	       (<OR <SET LEN <INTBL? .OBJ <REST ,NO-SLEEPS 2> .LEN>>
		    <AND <EQUAL? .OBJ ,WORM>
			 <NOT <IS? .OBJ ,MONSTER>>>>
		<TELL ". But " THE .OBJ 
		      " appears to be completely unaffected." CR>)
	       (<OR <EQUAL? .OBJ ,GRINDER>
		    <NOT <IS? .OBJ ,MONSTER>>>
		<TELL "; but aside from a brief fit of yawning, " THE .OBJ
		      " seems unaffected." CR>)
	       (<IS? .OBJ ,SLEEPING>
		<TELL ". Nothing further seems to happen." CR>)
	       (T
		<WINDOW ,SHOWING-ROOM>
		<REPLACE-ADJ? .OBJ ,W?AWAKE ,W?STUNNED>
		<MAKE .OBJ ,SLEEPING>
		<MAKE .OBJ ,NEUTRALIZED>
		<TELL ,PERIOD>)>
	 <UPDATE-STAT .S ,STRENGTH>
	 <RTRUE>>

<ROUTINE DACT-TO-SLEEP ("OPT" (G 0))
	 <TELL 
" closes his eyes, swaying his skinny head back and forth with drowsy reminiscences">
	 <COND (<T? .G>
		<TELL ". Soon his snore drowns out the fading song">)>
	 <COND (<HERE? IN-SKY>
		<TELL ,PTAB
"You tumble into a nose dive as " THE ,DACT "'s wings go limp. Desperate screams of terror do not wake him in time to avoid a crash">
		<JIGS-UP>
		<RFALSE>)>
	 <TELL ,PERIOD>
	 <WINDOW ,SHOWING-ALL>
	 <REPLACE-ADJ? ,DACT ,W?AWAKE ,W?SLEEPING>
	 <MAKE ,DACT ,SLEEPING>
	 <SETG DACT-SLEEP 4>
	 <RFALSE>>


<ROUTINE IO-WAND-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? ZAP-WITH>
		       <DO-IO ,PRSO ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? POINT-AT TOUCH-TO FIRE-AT>
		<DO-IO ,PRSI ,PRSO>
		<RTRUE>)
	       (<HANDLE-WANDS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-IO (OBJ W "AUX" S NXT X)
	 <COND (<DONT-HAVE-WAND? .OBJ .W>
		<RTRUE>)
	       (<OUT-OF-GAS? .W>
		<RTRUE>)>
	 <SET S <WAND-STRENGTH? .W>>
	 <ITALICIZE "Blit">
	 <TELL "! A zone of negative geometry forms in the space around ">
	 <COND (<EQUAL? .OBJ ,ME ,HANDS ,FEET>
		<SETG ATTACK-MODE ,THRUSTING>
		<TELL "your body">)
	       (T
		<TELL THE .OBJ ", effectively turning ">
		<PRONOUN .OBJ T>
		<TELL " inside out">)>
	 
	 <TELL ". This disconcerting effect lasts only for a moment">
	 
	 <COND (<EQUAL? .OBJ ,ME ,HANDS ,FEET>)
	       (<AND <EQUAL? .OBJ ,IDOL-ROOM>
		     <HERE? INNARDS>>
		<SETG P-WALK-DIR <>>
		<SETG OLD-HERE <>>
		<SETG HERE <LOC ,MAW>>
		<UNMAKE ,HERE ,TOUCHED>
		<MOVE ,PLAYER ,HERE>
		<MOVE-ALL ,INNARDS ,HERE ,NODESC>)
	       
	       (<EQUAL? .OBJ ,OWOMAN>
		<TELL ,PTAB 
"\"Very funny,\" she remarks, regaining her composure">)
	       
	       (<EQUAL? .OBJ ,BOTTLE>
		<TELL "; very little of " THE .OBJ
		      "'s contents escapes." CR>)
	       
	       (<AND <EQUAL? .OBJ ,MAMA>
		     <SET NXT <FIRST? .OBJ>>>
		<SET OBJ .NXT>
		<REPEAT ()
		   <SET NXT <NEXT? .OBJ>>
		   <UNMAKE .OBJ ,NODESC>
		   <MOVE .OBJ <LOC ,MAMA>>
		   <SET OBJ .NXT>
		   <COND (<ZERO? .OBJ>
			  <RETURN>)>>
		<WINDOW ,SHOWING-ROOM>
		<TELL 
"; but long enough for the undigested contents of " THE ,MAMA
		      "'s stomach to fall ">
		<SET OBJ ,GROUND>
		<COND (<NOT <IN? ,MAMA ,HERE>>
		       <TELL "on">
		       <SET OBJ <LOC ,MAMA>>)>
		<TELL "to " THE .OBJ>)
	       
	       (<IS? .OBJ ,LIVING>
		<TELL ", and leaves " THE .OBJ " looking ">
		<COND (<AND <IS? .OBJ ,MONSTER>
			    <NOT <IS? .OBJ ,SLEEPING>>>
		       <SETG ATTACK-MODE ,THRUSTING>
		       <TELL "madder than ever">)
		      (T
		       <TELL "rather upset">)>)
	       
	       (<AND <IS? .OBJ ,CONTAINER>
		     <SET OBJ <FIRST? .OBJ>>>
		<SET X 0>
		<REPEAT ()
		   <COND (<IS? .OBJ ,NODESC>)
			 (<IS? .OBJ ,TAKEABLE>
			  <INC X>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>
		<COND (<T? .X>
		       <TELL "; but you catch a glimpse of some">
		       <COND (<EQUAL? .X 1>
			      <TELL B ,W?THING>)
			     (T
			      <TELL " things">)>
		       <TELL " inside">)>)>
	 
	 <TELL ,PERIOD>
	 <UPDATE-STAT .S ,STRENGTH>
	 <RTRUE>>


<ROUTINE LEV-WAND-F ()
         <COND (<THIS-PRSI?>
		<COND (<VERB? ZAP-WITH>
		       <DO-LEV ,PRSO ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? POINT-AT TOUCH-TO FIRE-AT>
		<DO-LEV ,PRSI ,PRSO>
		<RTRUE>)
	       (<HANDLE-WANDS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-LEV (OBJ W "AUX" (M 0) L X S)
	 <SET S <GET ,STATS ,STRENGTH>>
	 <COND (<G? .S 24>
		<SET S -24>)
	       (T
		<SET S <- 0 <- .S 1>>>)>
	 <COND (<DONT-HAVE-WAND? .OBJ .W>
		<RTRUE>)
	       (<EQUAL? .OBJ .W>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<OUT-OF-GAS? .W>
		<RTRUE>)
	       (<EQUAL? .OBJ ,ME <LOC ,PLAYER>>
		<WAND-STRUGGLE .S .W>
		<RTRUE>)
	       (<EQUAL? .OBJ ,UNICORN>
		<TELL CTHE ,UNICORN 
" whinnies with fear as her hooves leave the floor! ">
		<PRINT "Sweat breaks out on your forehead as you ">
		<PRINT "guide the heavy burden over the ">
		<TELL "tall gate"> 
		<PRINT " and safely down to the ground.|">
		<UPDATE-STAT .S ,STRENGTH>
		<COND (<IN? ,CHEST ,HERE>
		       <UNICORN-OPENS-CHEST>
		       <RTRUE>)>
		<TELL ,TAB CTHE ,UNICORN C ,SP>
		<BYE-UNICORN>
		<RTRUE>)
	       (<EQUAL? .OBJ ,BABY>
		<VANISH ,BABY>
		<DEQUEUE ,I-BABY>
		<VANISH ,MAMA>
		<DEQUEUE ,I-MAMA>
		<TELL CTHE .OBJ 
" bellows with surprise as he rises out of " THE ,QUICKSAND "! ">
		<PRINT "Sweat breaks out on your forehead as you ">
		<PRINT "guide the heavy burden over the ">
		<TELL B ,W?MUD>
		<PRINT " and safely down to the ground.|">
		<UPDATE-STAT .S ,STRENGTH>
		<TELL ,TAB
"The ungainly creature nuzzles you with his muddy snout, and bats his eyelashes with joy and gratitude. Then he ">
		<COND (<IN? ,MAMA ,HERE>
		       <TELL "and his mother amble">)
		      (T
		       <TELL "ambles">)>
		<TELL " away into the jungle to">
		<COND (<IN? ,MAMA ,HERE>
		       <TELL "gether">)
		      (T
		       <TELL " find his mother">)>
		<TELL ", pausing for a final bellow of farewell." CR>
		<UPDATE-STAT 15 ,COMPASSION T>
		<RTRUE>)>
	 <COND (<AND <EQUAL? .OBJ ,ARROW>
		     <IN? .OBJ ,DACT>
		     <IS? .OBJ ,NODESC>>
		<TELL CTHE ,DACT>
		<COND (<IS? ,DACT ,SLEEPING>
		       <TELL " stirs restlessly">)
		      (T
		       <TELL " screeches with pain">)>
		<TELL " as " THE .OBJ " tugs against his wound." CR>
		<COND (<L? .S -3>
		       <SET S -3>)>
		<UPDATE-STAT .S ,STRENGTH>
		<RTRUE>)
	       (<EQUAL? .OBJ ,XTREES>
		<TELL "Ornaments and tinsel disappear into the sky." CR>
		<COND (<L? .S -3>
		       <SET S -3>)>
		<UPDATE-STAT .S ,STRENGTH>
		<RTRUE>)
	       (<EQUAL? .OBJ ,DUST>
		<TELL "Dust bunnies scatter all over the room." CR>
		<COND (<L? .S -3>
		       <SET S -3>)>
		<UPDATE-STAT .S ,STRENGTH>
		<RTRUE>)
	       (<IN? .OBJ ,GRINDER>
		<TELL CTHE ,GRINDER " retrieves the rising "
		      D .OBJ " with a chuckle. \"Cute.\"" CR>
		<COND (<L? .S -3>
		       <SET S -3>)>
		<UPDATE-STAT .S ,STRENGTH>
		<RTRUE>)
	       (<IS? .OBJ ,TAKEABLE>
		<SET L <LOC .OBJ>>
		<TELL CTHE .OBJ>
		<COND (<AND <EQUAL? .L ,PLAYER>
			    <IS? .OBJ ,WORN>>
		       <TELL 
" tugs vainly against your body for a few moments." CR>)
		      (<AND <EQUAL? .OBJ ,RELIQUARY>
			    <EQUAL? .L ,ALTAR>>
		       <TELL " begins to float">
		       <OUT-OF-LOC .L>
		       <MAKE ,CLERIC ,SEEN>
		       <TELL ,PTAB
"\"A sign!\" cries " THE ,CLERIC ", snatching " THE .OBJ
" out of the air and gently replacing it. \"A sign from the gods!\"" 
CR ,TAB CTHE ,CONGREG " grovels in fear and wonder." CR>)
		      (<EQUAL? .L ,MCASE ,BCASE ,WCASE>
		       <TELL 
" begins to float off its shelf in " THE .L ,PTAB
"\"No shoplifting!\" snaps " THE ,OWOMAN
,COMMA-AND THE .OBJ " drops back into place." CR>)
		      (T
		       <TELL " rises">
		       <COND (<EQUAL? .L ,PLAYER>
			      <TELL " out of your grasp">)
			     (T
			      <OUT-OF-LOC .L>)>
		       <TELL ", hovers for a moment and ">
		       <FALLS .OBJ <>>)>
		<SET X <GETP .OBJ ,P?SIZE>>
		<SET S <- <GET ,STATS ,STRENGTH> 1>>
		<COND (<L? .X 1>
		       <SET X 1>)
		      (<G? .X .S>
		       <SET X .S>)>
		<UPDATE-STAT <- 0 .X> ,STRENGTH>
		<COND (<AND <EQUAL? .OBJ ,SHILL>
			    <NOT <IS? ,SHILL ,TOUCHED>>>
		       <GET-SHILL>)>
		<RTRUE>)
	       (<IS? .OBJ ,LIVING>
		<TELL CTHE .OBJ>
		<COND (<AND <EQUAL? .OBJ ,DACT>
			    <HERE? IN-SKY>>
		       <TELL 
" spins out of control and crashes, killing you both instantly">
		       <JIGS-UP>
		       <RTRUE>)>
		<TELL " begins to rise off the ">
		<GROUND-WORD>
		<TELL ", but ">
		<COND (<EQUAL? .OBJ ,OWOMAN>
		       <TELL "her glare of annoyance prompt">)
		      (T
		       <COND (<IS? .OBJ ,FEMALE>
			      <TELL B ,W?HER>)
			     (<IS? .OBJ ,MONSTER>
			      <TELL "its">)
			     (T
			      <TELL "his">)>
		       <COND (<OR <IS? .OBJ ,MONSTER>
				  <IS? .OBJ ,SLEEPING>>
			      <TELL " wild thrashing force">)
			     (T
			      <TELL " obvious distress prompt">)>)>
		<TELL "s you to set ">
		<COND (<IS? .OBJ ,FEMALE>
		       <TELL B ,W?HER>)
		      (<IS? .OBJ ,MONSTER>
		       <TELL B ,W?IT>)
		      (T
		       <TELL B ,W?HIM>)>
		<TELL " down at once." CR>
		<UPDATE-STAT .S ,STRENGTH>
		<RTRUE>)>
	 <WAND-STRUGGLE .S .W .OBJ>
	 <RTRUE>>

<ROUTINE WAND-STRUGGLE (S W "OPT" OBJ)
	 <TELL "Your strength wanes sharply as " THE .W 
	       " struggles for influence">
	 <COND (<ASSIGNED? OBJ>
		<TELL "over " THE .OBJ>)>
	 <TELL ,PERIOD>
	 <UPDATE-STAT .S ,STRENGTH>
	 <RTRUE>>


<ROUTINE BLAST-WAND-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? ZAP-WITH>
		       <DO-BLAST ,PRSO ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? POINT-AT TOUCH-TO FIRE-AT>
		<DO-BLAST ,PRSI ,PRSO>
		<RTRUE>)
	       (<HANDLE-WANDS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-BLAST (OBJ W "AUX" (B 0) S L)
	 <COND (<DONT-HAVE-WAND? .OBJ .W>
		<RTRUE>)
	       (<NOT-LIVING? .OBJ .W>
		<RTRUE>)
	       (<OUT-OF-GAS? .W>
		<RTRUE>)>
	 <SET S <WAND-STRENGTH? .W>>
	 <SET L <LOC .OBJ>>
	 <KERBLAM>
	 <TELL "A searing bolt of ">
	 <EXPLODES .W>
	 <COND (<OR <EQUAL? .OBJ ,ME ,HANDS ,FEET>
		    <EQUAL? .L ,PLAYER>
		    <IN? .L ,PLAYER>>
		<TELL ", instantly consuming ">
		<COND (<EQUAL? .OBJ ,ME>
		       <TELL "you in flames">)
		      (T
		       <TELL THE .OBJ " in flames, and you with it">)>
		<JIGS-UP>
		<RTRUE>)
	       (<EQUAL? .OBJ ,GRINDER>
		<QUICKER>
		<TELL
", whirls the crank and sucks the deadly plasma under the lid." CR>)
	       (<EQUAL? .OBJ ,DUST>
		<COND (<NOT <IS? .OBJ ,TOUCHED>>
		       <START-DUST>)>
		<REPEAT ()
		   <MORE-BUNNIES>
		   <COND (<IGRTR? B 2>
			  <RETURN>)>>
		<TELL ", scattering dust bunnies all over the room." CR>)
	       (<IS? .OBJ ,MONSTER>
		<PUTP .OBJ ,P?ENDURANCE 0>
		<PUTP .OBJ ,P?STRENGTH 0>
		<TELL ", striking " THE .OBJ " squarely in the face!" CR>)
	       (T
		<TELL ", barely missing ">
		<COND (<AND <EQUAL? .OBJ ,WORM>
			    <NOT <IS? .OBJ ,MONSTER>>>
		       <TELL THE .OBJ>)
		      (T
		       <TELL "its wide-eyed target">)>
		<PRINT ,PERIOD>)>
	 <UPDATE-STAT .S ,STRENGTH>
	 <STARTLE .OBJ .W>
	 <RTRUE>>

<ROUTINE QUICKER ()
	 <TELL ", but " THE ,GRINDER 
	       " is quicker. He throws open his " 'GURDY>
	 <RTRUE>>


<ROUTINE DISPEL-WAND-F ()
         <COND (<THIS-PRSI?>
		<COND (<VERB? ZAP-WITH>
		       <DO-DISPEL ,PRSO ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? POINT-AT TOUCH-TO FIRE-AT>
		<DO-DISPEL ,PRSI ,PRSO>
		<RTRUE>)
	       (<HANDLE-WANDS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-DISPEL (OBJ W "AUX" (NAC 0) (H 0) S X Y)
	 <SET S <WAND-STRENGTH? .W>>
	 <COND (<DONT-HAVE-WAND? .OBJ .W>
		<RTRUE>)
	       (<EQUAL? .OBJ .W>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<OUT-OF-GAS? .W>
		<RTRUE>)
	       (<EQUAL? .OBJ ,ME <LOC ,PLAYER>>
		<WAND-STRUGGLE .S .W>
		<RTRUE>)>
	 <TELL "A vortex of energy forms at the tip of " THE .W
	       ", reaches outward and ">
	 <COND (<OR <EQUAL? .OBJ ,DOME>
		    <AND <EQUAL? .OBJ ,CRATER ,PLUME>
			 <IN? ,DOME ,ON-PEAK>>>
		<SETG LAVA-TIMER 4>
		<QUEUE ,I-LAVA>
		<REMOVE ,DOME>
		<MOVE ,LAVA ,ON-PEAK>
		<PUTP ,CRATER ,P?ACTION ,CRATER-F>
		<WINDOW ,SHOWING-ROOM>
		<HAZE-ENVELOPS ,DOME>
		<TELL 
"You watch as it spreads across the perimeter, patiently undoing the mystic forces that define its structure" ,PTAB>
		<KERBLAM>
		<TELL
"The mountain roars with volcanic triumph as a thousand years of pent-up fury breaches the bonds of Time. A plume of white-hot lava swells up from the heart of the mountain, only seconds away from where you stand!" CR>
		<UPDATE-STAT .S ,STRENGTH>
		<RTRUE>)
	       
	       (<EQUAL? .OBJ ,ASUCKER ,BSUCKER ,CSUCKER>
		<HAZE-ENVELOPS .OBJ>
		<PRINT 
"You hear a noise like a vacuum cleaner, then a satisfied slurp as ">
		<TELL THE .OBJ>
		<BLAST-SUCKER .OBJ>
		<UPDATE-STAT .S ,STRENGTH>
		<RTRUE>)
	       
	       (<OR <EQUAL? .OBJ ,BCASE ,MCASE ,WCASE>
		    <EQUAL? <LOC .OBJ> ,BCASE ,MCASE ,WCASE>>
		<MAKE ,OWOMAN ,SEEN>
		<TELL "reflects harmlessly off " 
		      THE ,MCASE ,PTAB ,CTHELADY " conceals a smirk." CR>
		<UPDATE-STAT .S ,STRENGTH>
		<RTRUE>)
	       
	       (<AND <SET X <GET ,MAGIC-ITEMS 0>>
		     <SET X <INTBL? .OBJ <REST ,MAGIC-ITEMS 2> .X>>>
		<HAZE-ENVELOPS .OBJ>
		<COND (<IS? .OBJ ,NEUTRALIZED>
		       <PRINT "But nothing seems to come of it; and ">)
		      (T
		       <COND (<AND <EQUAL? .OBJ ,HELM>
				   <WEARING-MAGIC? ,HELM>>
			      <INC H>)>
		       <MAKE .OBJ ,NEUTRALIZED>
		       <PRINT 
"You hear a noise like a vacuum cleaner, then a satisfied slurp as ">)>)
	       
	       (<AND <SET X <GET ,ARMOR-ITEMS 0>>
		     <SET X <INTBL? .OBJ <REST ,ARMOR-ITEMS 2> .X>>>
		<HAZE-ENVELOPS .OBJ>
		<SET X <GETP .OBJ ,P?EMAX>>
		<SET Y <GETP .OBJ ,P?EFFECT>>
		<COND (<AND <NOT <EQUAL? 0 .X .Y>>
			    <G? .Y .X>>
		       <PUTP .OBJ ,P?EFFECT .X>
		       <SET NAC <- .Y .X>>
		       <PRINT 
"You hear a noise like a vacuum cleaner, then a satisfied slurp as ">)
		      (T
		       <PRINT "But nothing seems to come of it; and ">)>)
	       
	       (<AND <SET X <GET ,WEAPON-ITEMS 0>>
		     <SET X <INTBL? .OBJ <REST ,WEAPON-ITEMS 2> .X>>>
		<HAZE-ENVELOPS .OBJ>
		<SET X <GETP .OBJ ,P?EMAX>>
		<SET Y <GETP .OBJ ,P?EFFECT>>
		<COND (<AND <NOT <EQUAL? 0 .X .Y>>
			    <G? .Y .X>>
		       <PUTP .OBJ ,P?EFFECT .X>
		       <PRINT 
"You hear a noise like a vacuum cleaner, then a satisfied slurp as ">)
		      (T
		       <PRINT "But nothing seems to come of it; and ">)>)
	       
	       (T
		<TELL "explores " THE .OBJ ". ">
		<COND (<EQUAL? .OBJ ,OWOMAN>
		       <TELL "\"How rude,\" she sniffs as ">)
		      (T
		       <PRINT "But nothing seems to come of it; and ">)>)>
	 
	 <TELL "the aura abruptly collapses." CR>
	 <UPDATE-STAT .S ,STRENGTH>
	 <COND (<T? .H>
		<NORMAL-IQ>)>
	 <COND (<EQUAL? .OBJ ,GLASS>
		<ARCH-OFF>)>
	 <COND (<T? .NAC>
		<UPDATE-STAT <- 0 .NAC> ,ARMOR-CLASS>)>
	 <RTRUE>>

<ROUTINE HAZE-ENVELOPS (OBJ)
	 <TELL "envelops " THE .OBJ " in a swirling haze. ">
	 <RTRUE>>

<ROUTINE WAND-STRENGTH? (OBJ "AUX" S X)
	 <SET S <GETP .OBJ ,P?STRENGTH>>
	 <SET X <- <GET ,STATS ,ENDURANCE> 1>>
	 <COND (<L? .S 1>
		<SET S 1>)
	       (<G? .S .X>
		<SET S .X>)>
	 <RETURN <- 0 .S>>>

<ROUTINE OUT-OF-GAS? (W "AUX" GAS)
	 <MAKE .W ,USED>
	 <SET GAS <GETP .W ,P?ENDURANCE>>
	 <COND (<OR <ZERO? .GAS>
		    <IS? .W ,NEUTRALIZED>>
		<TELL CTHE .W <PICK-NEXT ,EMPTY-WANDS> ". Its virtue">
		<COND (<ZERO? .GAS>
		       <TELL " seems to be exhausted." CR>
		       <RTRUE>)>
		<PRINT " appears to have been neutralized">
		<TELL ,PERIOD>
		<RTRUE>)>
	 <PUTP .W ,P?ENDURANCE <- .GAS 1>>
	 <RFALSE>>

<ROUTINE NOT-LIVING? (OBJ W)
	 <COND (<IS? .OBJ ,LIVING>
		<RFALSE>)>
	 <TELL CTHE .W 
" crackles lifelessly as you direct it at " THE .OBJ
". Perhaps its Magick works only on living things." CR>
	 <RTRUE>>

<ROUTINE STARTLE (OBJ W)
	 <COND (<EQUAL? .OBJ ,OWOMAN>
		<VANISH .W>
		<TELL ,TAB CTHE .OBJ " snatches " THE .W 
" away from you, snaps it in two and discards it angrily. \"That is ">
		<ITALICIZE "not">
		<TELL " a toy.\"" CR>
		<RTRUE>)
	       (<OR <EQUAL? .OBJ ,SALT ,COOK>
		    <EQUAL? .OBJ ,CLERIC>>
		<TELL ,TAB "\"Hey! Careful with that,\" growls "
		      THE .OBJ ,PERIOD>
		<RTRUE>)
	       (<AND <EQUAL? .OBJ ,MINX ,DACT>
		     <NOT <IS? .OBJ ,SLEEPING>>>
		<TELL ,TAB CTHE .OBJ " gives you a reproachful look." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NEXT-WAND? ("OPT" FCN RM "AUX" OBJ X)
	 <SET OBJ <PICK-ONE ,WAND-LIST>>
         <COND (<IS? .OBJ ,NODESC>
		<UNMAKE .OBJ ,NODESC>
		<SET X <PICK-ONE ,WAND-FUNCTIONS>>
		<PUTP .OBJ ,P?ACTION <GET .X 0>>
		<PUTP .OBJ ,P?SDESC <GET .X 1>>
		<SET X <GET .X 2>>
		<PUT <GETPT .OBJ ,P?SYNONYM> 0 .X>
		<PUT <GETPT .OBJ ,P?ADJECTIVE> 0 .X>
		<COND (<ASSIGNED? FCN>
		       <PUTP .OBJ ,P?DESCFCN .FCN>)>
		<COND (<ASSIGNED? RM>
		       <MOVE .OBJ .RM>)>
		<RETURN .OBJ>)
	       (T
	      ; <SAY-ERROR "NEXT-WAND?">
		<RFALSE>)>>
		
<ROUTINE HANDLE-WANDS? ()
	 <COND (<FIRST-TAKE?>
		<RTRUE>)
	       (<VERB? SWING>
		<TELL "You feel potential swell in " THEO
		      ", eager for release." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CURTAIN
	(LOC IN-MAGICK)
	(DESC "curtain")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM CURTAIN DRAPES)
	(DESCFCN CURTAIN-F)
	(ACTION CURTAIN-F)>

<ROUTINE CURTAIN-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL "A closed curtain hangs suspended in midair.">
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? CLOSE>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (<OR <VERB? LOOK-BEHIND LOOK-UNDER>
		    <SET X <ENTERING?>>
		    <SET X <TOUCHING?>>>
		<COND (<NOT <HERE? APLANE>>
		       <ENTER-CURTAIN>
		       <RTRUE>)>
		<COND (<HELD? ,PHASE>
		       <MUNG-PHASE>)>
		<AS-YOU-APPROACH>
	        <TELL "your eyes momentarily lose their focus." CR>
		<COND (<T? ,VERBOSITY>
		       <CRLF>)>
		<SET X ,IN-MAGICK>
		<COND (<EQUAL? ,ABOVE ,OACCARDI>
		       <UNMAKE ,WEAPON-DOOR ,OPENED>
		       <SET X ,IN-WEAPON>)
		      (<EQUAL? ,ABOVE ,OMIZNIA>
		       <UNMAKE ,BOUTIQUE-DOOR ,OPENED>
		       <SET X ,IN-BOUTIQUE>)>
		<GOTO .X>
		<TELL ,TAB ,CTHELADY " glances up as you appear. \"">
		<SET X <RANDOM 100>>
		<COND (<L? .X 33>
		       <TELL "Hello">)
		      (<L? .X 67>
		       <TELL "Welcome">)
		      (T
		       <TELL "Greetings">)>
		<TELL ",\" she says, ">
		<COND (<EQUAL? ,ABOVE ,OCITY>
		       <TELL "glaring at the">
		       <OPEN-CLOSED ,MAGICK-DOOR>
		       <TELL ". \"Gotta fix that bell.\"" CR>
		       <RTRUE>)>
		<TELL "frowning at the closed door." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTER-CURTAIN ()
	 <SETG P-WALK-DIR <>>
	 <AS-YOU-APPROACH ,CURTAIN>
	 <TELL "the shop subtly rearranges itself until you find yourself facing the other way">
	 <COND (<IN? ,OWOMAN ,HERE>
		<TELL ". " ,CTHELADY 
		      " watches you with wry amusement">)>
	 <PRINT ,PERIOD>
	 <RFALSE>>
		       
<OBJECT MIRROR0
	(DESC "mirror")
	(FLAGS TRYTAKE NOALL LIVING PERSON)
	(SYNONYM MIRROR BUBBLE BUBBLES REFLECTION)
	(ADJECTIVE MAGIC FLOATING ROUND)
	(MIRROR-DIR NO-MIRROR)
	(SIZE 0)
	(GENERIC GENERIC-BUBBLE-F)
	(DESCFCN MIRROR0-F)
	(ACTION MIRROR0-F)>

<ROUTINE MIRROR0-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-MIRRORS? ,MIRROR0 .CONTEXT>>>

<OBJECT MIRROR1
	(DESC "mirror")
	(FLAGS TRYTAKE NOALL LIVING PERSON)
	(SYNONYM MIRROR BUBBLE BUBBLES REFLECTION)
	(ADJECTIVE MAGIC FLOATING ROUND)
	(MIRROR-DIR NO-MIRROR)
	(SIZE 0)
	(GENERIC GENERIC-BUBBLE-F)
	(DESCFCN MIRROR1-F)
	(ACTION MIRROR1-F)>

<ROUTINE MIRROR1-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-MIRRORS? ,MIRROR1 .CONTEXT>>>

<OBJECT MIRROR2
	(DESC "mirror")
	(FLAGS TRYTAKE NOALL LIVING PERSON)
	(SYNONYM MIRROR BUBBLE BUBBLES REFLECTION)
	(ADJECTIVE MAGIC FLOATING ROUND)
	(MIRROR-DIR NO-MIRROR)
	(SIZE 0)
	(GENERIC GENERIC-BUBBLE-F)
	(DESCFCN MIRROR2-F)
	(ACTION MIRROR2-F)>

<ROUTINE MIRROR2-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-MIRRORS? ,MIRROR2 .CONTEXT>>>

<OBJECT MIRROR3
	(DESC "mirror")
	(FLAGS TRYTAKE NOALL LIVING PERSON)
	(SYNONYM MIRROR BUBBLE BUBBLES REFLECTION)
	(ADJECTIVE MAGIC FLOATING ROUND)
	(MIRROR-DIR NO-MIRROR)
	(SIZE 0)
	(GENERIC GENERIC-BUBBLE-F)
	(DESCFCN MIRROR3-F)
	(ACTION MIRROR3-F)>

<ROUTINE MIRROR3-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-MIRRORS? ,MIRROR3 .CONTEXT>>>

<OBJECT MIRROR4
	(DESC "mirror")
	(FLAGS TRYTAKE NOALL LIVING PERSON)
	(SYNONYM MIRROR BUBBLE BUBBLES REFLECTION)
	(ADJECTIVE MAGIC FLOATING ROUND)
	(MIRROR-DIR NO-MIRROR)
	(SIZE 0)
	(GENERIC GENERIC-BUBBLE-F)
	(DESCFCN MIRROR4-F)
	(ACTION MIRROR4-F)>

<ROUTINE MIRROR4-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-MIRRORS? ,MIRROR4 .CONTEXT>>>

<OBJECT MIRROR5
	(DESC "mirror")
	(FLAGS TRYTAKE NOALL LIVING PERSON)
	(SYNONYM MIRROR BUBBLE BUBBLES REFLECTION)
	(ADJECTIVE MAGIC FLOATING ROUND)
	(MIRROR-DIR NO-MIRROR)
	(SIZE 0)
	(GENERIC GENERIC-BUBBLE-F)
	(DESCFCN MIRROR5-F)
	(ACTION MIRROR5-F)>

<ROUTINE MIRROR5-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-MIRRORS? ,MIRROR5 .CONTEXT>>>

<OBJECT MIRROR6
	(DESC "mirror")
	(FLAGS TRYTAKE NOALL LIVING PERSON)
	(SYNONYM MIRROR BUBBLE BUBBLES REFLECTION)
	(ADJECTIVE MAGIC FLOATING ROUND)
	(MIRROR-DIR NO-MIRROR)
	(SIZE 0)
	(GENERIC GENERIC-BUBBLE-F)
	(DESCFCN MIRROR6-F)
	(ACTION MIRROR6-F)>
	
<ROUTINE MIRROR6-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-MIRRORS? ,MIRROR6 .CONTEXT>>>

<ROUTINE NOTE-MIRROR (OBJ WRD)
	 <TELL " is suspended in midair">
	 <COND (<NOT <IN? ,QUEEN ,HERE>>
		<TELL ", facing " B .WRD>
		<BEAM-DETAILS .OBJ>)>
	 <RFALSE>>

<ROUTINE BEAM-DETAILS (OBJ "AUX" DIR SDIR X1 X2 X3)
	 <COND (<NOT <EQUAL? <GETP ,HERE ,P?MIRROR-OBJ> .OBJ>>
		<RFALSE>)>
	 <SET SDIR <GETP ,HERE ,P?BEAM-DIR>> ; "Beam here?"
	 <COND (<EQUAL? .SDIR ,NO-MIRROR> ; "No, scram."
		<RFALSE>)>
	 <SET DIR <GETP .OBJ ,P?MIRROR-DIR>>
	 <TELL ". Sunlight from the "
	       B <GET ,DIR-NAMES .SDIR> " exit is ">
	 <COND (<EQUAL? .SDIR .DIR>
		<TELL "shining directly onto the mirror's face">
		<RTRUE>)>
	 
	 <SET X1 <+ .SDIR 1>>
	 <COND (<G? .X1 ,I-NW>
		<SET X1 ,I-NORTH>)>
	 <COND (<EQUAL? .DIR .X1>
		<COND (<IGRTR? X1 ,I-NW>
		       <SET X1 ,I-NORTH>)>
		<REFLECT-TO .X1>
		<RTRUE>)>
	 
	 <SET X1 <- .SDIR 1>>
	 <COND (<L? .X1 ,I-NORTH>
		<SET X1 ,I-NW>)>
	 <COND (<EQUAL? .DIR .X1>
		<COND (<DLESS? X1 ,I-NORTH>
		       <SET X1 ,I-NW>)>
		<REFLECT-TO .X1>
		<RTRUE>)>
	 	 
	 <SET X1 <- .SDIR 2>>
	 <COND (<L? .X1 ,I-NORTH>
		<SET X1 <+ .X1 8>>)>
	 <SET X2 <+ .SDIR 2>>
	 <COND (<G? .X2 ,I-NW>
		<SET X2 <- .X2 8>>)>
	 <COND (<EQUAL? .DIR .X1 .X2>
		<TELL "glinting on the mirror's edge">
		<RTRUE>)>
	 
	 <SET X1 <+ .SDIR 4>>
	 <COND (<G? .X1 ,I-NW>
		<SET X1 <- .X1 8>>)>
	 <SET X2 <+ .SDIR 3>>
	 <COND (<G? .X2 ,I-NW>
		<SET X2 <- .X2 8>>)>
	 <SET X3 <- .SDIR 3>>
	 <COND (<L? .X3 ,I-NORTH>
		<SET X3 <+ .X3 8>>)>
	 <COND (<EQUAL? .DIR .X1 .X2 .X3>
		<TELL "illuminating the back of the mirror">)>
	 <RTRUE>>		

<ROUTINE REFLECT-TO (DIR)
	 <TELL "reflected " B <GET ,DIR-NAMES .DIR>>
	 <SET DIR <GETP ,HERE <GETB ,PDIR-LIST .DIR>>>
	 <COND (<ZERO? .DIR>)
	       (<EQUAL? <MSB <GET .DIR ,XTYPE>> ,CONNECT>
		<RFALSE>)>
	 <TELL ", onto the wall">
	 <RTRUE>>
		
<ROUTINE HANDLE-MIRRORS? (OBJ CONTEXT "AUX" DIR WRD X)
	 <SET DIR <GETP .OBJ ,P?MIRROR-DIR>>
	 <SET WRD <GET ,DIR-NAMES .DIR>>
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA .OBJ>
		<NOTE-MIRROR .OBJ .WRD>
		<TELL C ,PER>
		<RTRUE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<NOUN-USED? ,W?BUBBLES>
		<TELL "There's only one " B ,W?BUBBLE " here." CR>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<MIRROR-REFLECTS>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL CTHEO>
		<NOTE-MIRROR .OBJ .WRD>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<VERB? POINT-AT PUSH-TO>
		<COND (<ZERO? ,LIT?>
		       <TOO-DARK>
		       <RTRUE>)
		      (<PRSI? URGRUE>
		       <SET X <GETP ,PRSI ,P?DNUM>>
		       <COND (<EQUAL? .X .DIR>
			      <ALREADY-FACING>
			      <RTRUE>)>
		       <NEW-MIRROR-DIR .X>
		       <RTRUE>)
		      (<PRSI? INTDIR>
		       <COND (<OR <EQUAL? ,P-DIRECTION ,P?UP ,P?DOWN>
				  <EQUAL? ,P-DIRECTION ,P?IN ,P?OUT>>
			      <TELL CTHEO>
			      <PRINT " can't be moved that way.|">
			      <RTRUE>)
			     (<EQUAL? <GETB ,PDIR-LIST .DIR> ,P-DIRECTION>
			      <ALREADY-FACING>
			      <RTRUE>)>
		       <NEW-MIRROR-DIR <- 0 <- ,P-DIRECTION ,P?NORTH>>> 
		       <RTRUE>)>
		<NYMPH-APPEARS>
		<TELL "To direct the mirror, simply specify a " 'INTDIR
"; for example, TURN THE MIRROR TO THE NORTH or AIM MIRROR SW">
		<PRINT ". Bye!\"|  She disappears with a wink.|">
		<RTRUE>)
	       (<VERB? SPIN SWING TURN PUSH MOVE>
		<PROG ()
		   <SET X <BOR <RANDOM 7> 1>>
		   <COND (<EQUAL? .X .DIR>
			  <AGAIN>)>>
		<WINDOW ,SHOWING-ROOM>
		<PUTP ,PRSO ,P?MIRROR-DIR .X>
		<TELL CTHEO 
" spins randomly around, slows and stops. It's now facing "
B <GET ,DIR-NAMES .X> ,PERIOD>
		<COND (<EQUAL? <GETP ,HERE ,P?MIRROR-OBJ> .OBJ>
		       <REFLECTIONS>)>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,YOU-SEE>
		<COND (<IN? ,QUEEN ,HERE>
		       <TELL THE ,QUEEN>)
		      (T
		       <TELL 'ME>)>
		<TELL " reflected in " THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? HIT SQUEEZE KICK REACH-IN POP MUNG>
		<DESTROY-MIRROR .OBJ>
		<SAY-MIRROR-POPS .OBJ>
		<RTRUE>)
	       (<VERB? THROW>
		<MOVE ,PRSI ,HERE>
		<TELL CTHEI " strikes " THEO ", ">
		<COND (<L? <GETP ,PRSI ,P?SIZE> 1>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL "slides off and lands at your feet." CR>
		       <RTRUE>)>
		<TELL "which explodes with a flabby ">
		<ITALICIZE "pop">
		<PRINT ,PERIOD>
		<DESTROY-MIRROR .OBJ>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<TELL "Wrong fantasy." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>	 

<ROUTINE ALREADY-FACING ()
	 <TELL CTHEO " is already facing that way." CR>
	 <RTRUE>>

<ROUTINE NEW-MIRROR-DIR (DIR)
	 <PUTP ,PRSO ,P?MIRROR-DIR .DIR>
	 <TELL "You carefully rotate " THEO " until it faces " 
	       B <GET ,DIR-NAMES .DIR> ,PERIOD>
	 <COND (<EQUAL? <GETP ,HERE ,P?MIRROR-OBJ> ,PRSO>
		<REFLECTIONS>
		<RTRUE>)>
	 <WINDOW ,SHOWING-ROOM>
	 <RTRUE>>

<ROUTINE MIRROR-REFLECTS ()
	 <PCLEAR>
	 <TELL CTHE ,MIRROR0 " reflects on your words in silence." CR>
	 <RTRUE>>

; <ROUTINE PATTERN-MATCH? ("AUX" WRD)
	 <COND (<NOT <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?MIRROR>>
		<RTRUE>)>
	 <SETG P-CONT <+ ,P-CONT ,P-LEXELEN>>
	 <SET WRD <GET ,P-LEXV ,P-CONT>>
	 <COND (<EQUAL? .WRD ,W?THEN ,W?COMMA ,W?PERIOD>
	 	<SETG P-CONT <+ ,P-CONT ,P-LEXELEN>>
		<SET WRD <GET ,P-LEXV ,P-CONT>>)>
	 <COND (<ZERO? .WRD>
		<RFALSE>)
	       (<NOT <EQUAL? .WRD ,W?IN ,W?ON>>
		<RTRUE>)>
	 <SETG P-CONT <+ ,P-CONT ,P-LEXELEN>>
	 <SET WRD <GET ,P-LEXV ,P-CONT>>
	 <COND (<EQUAL? .WRD ,W?THE ,W?A>
	 	<SETG P-CONT <+ ,P-CONT ,P-LEXELEN>>
		<SET WRD <GET ,P-LEXV ,P-CONT>>)>
	 <COND (<ZERO? .WRD>
		<RFALSE>)
	       (<NOT <EQUAL? .WRD ,W?AIR ,W?WALL>>
		<RTRUE>)>
	 <SETG P-CONT <+ ,P-CONT ,P-LEXELEN>>
	 <SET WRD <GET ,P-LEXV ,P-CONT>>
	 <COND (<EQUAL? .WRD ,W?THEN ,W?COMMA ,W?PERIOD>
	 	<COND (<NOT <EQUAL? .WRD ,W?THEN>>
		       <CHANGE-LEXV ,P-CONT ,W?THEN>)>
		<SETG P-CONT <+ ,P-CONT ,P-LEXELEN>>
		<SET WRD <GET ,P-LEXV ,P-CONT>>)>
	 <COND (<ZERO? .WRD>
		<RFALSE>)>
	 <RTRUE>>

<OBJECT SUNBEAM
	(LOC LOCAL-GLOBALS)
	(DESC "sunbeam")
	(FLAGS NODESC)
	(SYNONYM SUNBEAM BEAM LIGHT SUNLIGHT DAYLIGHT)
	(ADJECTIVE LIGHT SUN)
	(ACTION SUNBEAM-F)>

<ROUTINE SUNBEAM-F ("AUX" DIR)
	 <SET DIR <GETP ,HERE ,P?BEAM-DIR>>
	 <COND (<EQUAL? .DIR ,NO-MIRROR>
		<COND (<AND <HERE? SE-CAVE>
			    <IS? ,SWALL ,OPENED>>
		       <SET DIR ,I-SE>)
		      (T
		       <TELL ,CANT "see that here." CR>
		       <RFATAL>)>)>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is coming from the "
		      B <GET ,DIR-NAMES .DIR> ,PERIOD>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW>
		<DO-WALK <GETB ,PDIR-LIST .DIR>>
		<RTRUE>)
	       (T
		<RFALSE>)>>		 

<OBJECT JAR
	(DESC "crystal jar")
	(FLAGS TAKEABLE CONTAINER TRANSPARENT OPENABLE)
	(SIZE 2)
	(CAPACITY 1)
	(VALUE 20)
	(SYNONYM JAR LIQUID SOAP CONTENTS LID TOP)
	(ADJECTIVE CRYSTAL RICH PEARLY)
	(DESCFCN JAR-F)
	(CONTFCN JAR-F)
	(ACTION JAR-F)>

<ROUTINE JAR-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL ,XA 'JAR " glitters in the ">
		<SET X <LIGHT-SOURCE?>>
		<COND (<ZERO? .X>
		       <TELL "dim ">)
		      (<EQUAL? .X ,SUN>
		       <TELL 'SUN>)
		      (T
		       <PRINTD .X>
		       <TELL "'s ">)>
		<TELL "light.">
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-CONT>
		<COND (<IS? ,JAR ,OPENED>)
		      (<SET X <TOUCHING?>>
		       <YOUD-HAVE-TO "open" ,JAR>
		       <RTRUE>)>
		<RFALSE>)
	       (<NOUN-USED? ,W?LID ,W?TOP>
		<COND (<VERB? CLOSE PLUG-IN>)
		      (<VERB? EXAMINE LOOK-ON>
		       <TELL "The jar's lid is ">
		       <COND (<IS? ,PRSO ,OPENED>
			      <TELL "open." CR>
			      <RTRUE>)>
		       <TELL "closed." CR>
		       <RTRUE>)
		      (<VERB? LOOK-UNDER>
		       <V-OPEN>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <TELL "The jar's lid">
		       <PRINT " can't be moved that way.|">
		       <RTRUE>)>)
	       (<NOUN-USED? ,W?LIQUID ,W?SOAP ,W?CONTENTS>
		<COND (<THIS-PRSI?>)
		      (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		       <TELL "The rich, pearly liquid ">
		       <SAY-LIQUID>
		       <RTRUE>)
		      (<VERB? TOUCH SQUEEZE PUSH>
		       <TOUCH-LIQUID>
		       <RTRUE>)
		      (<VERB? OPEN OPEN-WITH CLOSE UNPLUG>
		       <IMPOSSIBLE>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? POUR-FROM>
			    <PRSO? PRSI>>
		       <COND (<EQUAL? <GET ,P-NAMW 0>
				      ,W?LIQUID ,W?SOAP ,W?CONTENTS>)
			     (<NOT <EQUAL? <GET ,P-OFW 0>
				   ,W?LIQUID ,W?SOAP ,W?CONTENTS>>
			      <RFALSE>)>
		       <COND (<EQUAL? <GET ,P-NAMW 1>
				      ,W?LIQUID ,W?SOAP ,W?CONTENTS>
			      <RFALSE>)
			     (<EQUAL? <GET ,P-OFW 1>
				   ,W?LIQUID ,W?SOAP ,W?CONTENTS>
			      <RFALSE>)> 
		       <COND (<NOT <IS? ,PRSI ,OPENED>>
			      <ITS-CLOSED ,PRSI>
			      <RTRUE>)>
		       <EMPTY-JAR>
		       <RTRUE>)
		      (<VERB? PUT PUT-UNDER EMPTY-INTO>
		       <COND (<AND <VERB? PUT-UNDER>
				   <NOT <EQUAL? ,P-PRSA-WORD ,W?DIP
						,W?SUBMERGE>>>
			      <RFALSE>)
			     (<NOT <IS? ,PRSI ,OPENED>>
			      <YOUD-HAVE-TO "open" ,PRSI>
			      <RTRUE>)
			     (<PRSO? CIRCLET>
			      <COND (<VERB? PUT-UNDER>
				     <DIP-CIRCLET>
				     <RTRUE>)
				    (<NOT <IS? ,PRSO ,SEEN>>
				     <RENEW-FILM>)>
			      <RFALSE>)
			     (<IN? ,CIRCLET ,PRSI>
			      <YOUD-HAVE-TO "take out" ,CIRCLET>
			      <RTRUE>)			     
			     (<G? <GETP ,P?SIZE ,PRSO> 1>  
			      <TELL CTHEO " is too big to fit in "
				    THEI ,PERIOD>
			      <RTRUE>)>
		       <VANISH>
		       <TELL "As you drop ">
		       <O-INTO-I 0>
		       <TELL
", it melts into the pearly liquid and disappears." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL ,XTHE>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL B ,W?OPEN>)
		      (T
		       <TELL B ,W?CLOSED>)>
		<TELL 
" jar appears to have been carved from a solid block of crystal." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<TELL CTHEO " is filled with a rich, pearly liquid that ">
		<SAY-LIQUID>
		<RTRUE>)
	       (<VERB? EMPTY EMPTY-INTO POUR>
		<COND (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-CLOSED>
		       <RTRUE>)>
		<EMPTY-JAR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH UNPLUG>
		<V-OPEN>
	        <RTRUE>)
	       (<VERB? DRINK TASTE KISS SMELL>
		<COND (<NOT <NOUN-USED? ,W?LIQUID ,W?SOAP ,W?CONTENTS>>
		       <TELL "[the " B ,W?LIQUID ,BRACKET>)>
		<COND (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-CLOSED>
		       <RTRUE>)>
		<TELL "Its sharp, metallic odor ">
		<COND (<VERB? SMELL>
		       <TELL "makes your nostrils burn." CR>
		       <RTRUE>)>
		<TELL "changes your mind." CR>
		<RTRUE>)
	       (<VERB? SHAKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <EMPTY-JAR>
		       <RTRUE>)>
		<TELL "The liquid in " THEO
		      " swirls around." CR>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<TOUCH-LIQUID>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EMPTY-JAR ()
	 <TELL
"The liquid seems quite content in its little jar, and refuses to come out despite vigorous turning and shaking." CR>
	 <RTRUE>>

<ROUTINE TOUCH-LIQUID ()
	 <COND (<NOT <IS? ,PRSO ,OPENED>>
		<ITS-CLOSED>
		<RTRUE>)>
	 <TELL "You feel a sharp, metallic sensation." CR>
	 <RTRUE>>

<ROUTINE SAY-LIQUID ()
	 <TELL "swirls and shimmers with a life all its own">
	 <COND (<IN? ,CIRCLET ,JAR>
		<TELL ". A " 'CIRCLET " is suspended within">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<OBJECT CIRCLET
	(LOC JAR)
	(DESC "circlet")
	(FLAGS TAKEABLE SEEN)
	(SIZE 1)
	(VALUE 0)
	(SYNONYM CIRCLET CIRCLE BUBBLE BUBBLES FILM)
	(ADJECTIVE SWIRLING)
	(GENERIC GENERIC-BUBBLE-F)
	(ACTION CIRCLET-F)>

"SEEN = bubbly."

<ROUTINE GENERIC-BUBBLE-F (TBL "OPT" (LEN <GET .TBL 0>) "AUX" X)
	 <SET TBL <REST .TBL 2>>
	 <COND (<AND <VERB? BLOW-INTO>
		     <SET X <INTBL? ,CIRCLET .TBL .LEN>>>
		<RETURN ,CIRCLET>)
	       (<G? .LEN 2>
		<RFALSE>)>
	 <SET X <GET .TBL 0>>
	 <COND (<EQUAL? .X ,CIRCLET>
		<RETURN <GET .TBL 1>>)>
	 <RETURN .X>>	 

<ROUTINE CIRCLET-F ("AUX" X B)
	 <SET B <NOUN-USED? ,W?BUBBLE ,W?BUBBLES>>
	 <COND (<IS? ,CIRCLET ,SEEN>)
	       (<OR <NOUN-USED? ,W?FILM>
		    <ADJ-USED? ,W?SWIRLING>>
		<PCLEAR>
		<TELL ,CANT "see any" ,AT-MOMENT>
		<RFATAL>)>
	 <COND (<VERB? BLOW-INTO>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)>
		<TELL ,CYOU>
		<COND (<IS? ,PRSO ,SEEN>)
		      (<T? .B>
		       <COND (<VISIBLE? ,JAR>
			      <TELL "dip " THEO ,SIN THE ,JAR
", draw it out and blow into the swirling film." CR>
			      <START-MIRROR>
			      <RTRUE>)>)>
		<TELL "blow gently into the ">
		<COND (<EMPTY-CIRCLET?>
		       <RTRUE>)>
		<TELL 'PRSO "'s swirling film." CR>
		<START-MIRROR>
		<RTRUE>)
	       (<T? .B>
		<PCLEAR>
		<TELL ,CANT "see any " B ,W?BUBBLES " here." CR>
		<RFATAL>)>
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <TELL CTHEI " is much too small." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? SWING>
		<TELL ,CYOU B ,P-PRSA-WORD ,STHE>
		<COND (<EMPTY-CIRCLET?>
		       <RTRUE>)>
		<TELL 'PRSO " through the air." CR>
		<START-MIRROR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "The flat, hollow " 'PRSO>
		<COND (<IN? ,PRSO ,JAR>
		       <TELL ,SIN THE ,JAR>)>
		<TELL " is attached to a short handle">
		<COND (<IS? ,PRSO ,SEEN>
		       <TELL ", and is filled with a swirling film">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DIP-CIRCLET ()
	 <TELL "You dip " THE ,CIRCLET ,SINTO THE ,JAR ,PERIOD>
	 <COND (<NOT <IS? ,CIRCLET ,SEEN>>
		<RENEW-FILM>)>
	 <RFALSE>>

<ROUTINE EMPTY-CIRCLET? ()
	 <COND (<IS? ,CIRCLET ,SEEN>
		<KILL-FILM>
		<RFALSE>)>
	 <TELL "empty " 'CIRCLET>
	 <BUT-NOTHING-HAPPENS>
	 <RTRUE>>

<ROUTINE KILL-FILM ()
	 <UNMAKE ,CIRCLET ,SEEN>
	 <REPLACE-SYN? ,W?CIRCLET ,W?FILM ,W?ZZZP>
	 <REPLACE-ADJ? ,W?CIRCLET ,W?SWIRLING ,W?ZZZP>
	 <RFALSE>>

<ROUTINE RENEW-FILM ()
	 <MAKE ,CIRCLET ,SEEN>
	 <REPLACE-SYN? ,W?CIRCLET ,W?ZZZP ,W?FILM>
	 <REPLACE-ADJ? ,W?CIRCLET ,W?ZZZP ,W?SWIRLING>
	 <RFALSE>>	 

<ROUTINE START-MIRROR ("AUX" LEN OBJ X)
	 <COND (<ZERO? ,LIT?>
		<TELL ,TAB "Moments later, you hear a flabby ">
		<ITALICIZE "pop">
		<TELL ,PERIOD>
		<RTRUE>)>
	 <SET X <PLAIN-ROOM?>>
	 <COND (<OR <T? .X>
		    <HERE? ON-BRIDGE APLANE IN-SKY IN-SPLENDOR>>
		<SAY-BUBBLE>
		<TELL ", but ">
		<COND (<T? .X>
		       <MAKE ,CORBIES ,SEEN>
		       <TELL "a corbie instantly swoops down to pop it." CR>
		       <RTRUE>)
		      (<HERE? ON-BRIDGE>
		       <TELL "river mist instantly dissolves it." CR>
		       <RTRUE>)
		      (<HERE? APLANE IN-SPLENDOR>
		       <TELL "it">
		       <PRINT " disappears in a spectral flash">
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<TELL "upper air currents soon blow it out of sight." CR>
		<RTRUE>)>
	 
	 <SET LEN <GET ,MIRROR-LIST 0>>
	 <REPEAT ()
	    <SET OBJ <GET ,MIRROR-LIST .LEN>>
	    <SET X <LOC .OBJ>>
	    <COND (<ZERO? .X>
		   <RETURN>)
		  (<EQUAL? .X ,HERE>
		   <DESTROY-MIRROR .OBJ>
		   <SAY-BUBBLE>
		   <TELL 
" and bounces into the other bubble hovering nearby. Both disappear with a flabby ">
		   <ITALICIZE "pop">
		   <TELL ,PERIOD>
		   <RTRUE>)
		  (<DLESS? LEN 1>
		   <SAY-BUBBLE>
		   <TELL ", but it pops almost immediately." CR>
		   <RETURN>)>>
	 
	 <SAY-BUBBLE>
	 <TELL
"! You watch as it flattens into a perfectly circular mirror, rotating more and more slowly until it faces " 
B <GET ,DIR-NAMES <CREATE-MIRROR? .OBJ>> ,PERIOD>
	 <COND (<IN? ,URGRUE ,HERE>
		<TELL ,TAB "\"How droll,\" remarks " THE ,URGRUE ,PERIOD>)>
	 <COND (<EQUAL? <GETP ,HERE ,P?MIRROR-OBJ> ,NO-MIRROR>
		<PUTP ,HERE ,P?MIRROR-OBJ .OBJ>
	        <REFLECTIONS>)>
	 <RTRUE>>		
	 
<ROUTINE SAY-BUBBLE ()
	 <TELL ,TAB 
"A silvery bubble blows out of " THE ,CIRCLET>
	 <RTRUE>>

<ROUTINE REFLECTIONS ("AUX" (ALERT 0) (POPIT 0) RM TBL X OBJ ANGLE DIR XDIR)
	 <SET X <GETB ,GRUE-ROOMS 0>>
	 <REPEAT ()
	    <SET RM <GETB ,GRUE-ROOMS .X>>
	    <COND (<EQUAL? ,HERE .RM>
		   <INC ALERT>)>
	    <UNMAKE .RM ,LIGHTED>
	    <PUTP .RM ,P?BEAM-DIR ,NO-MIRROR>
	    <COND (<DLESS? X 1>
		   <RETURN>)>>
	 	 
	 <COND (<IS? ,NWALL ,OPENED>
		<MAKE ,NE-CAVE ,LIGHTED>)>
	 <COND (<IS? ,SWALL ,OPENED>
		<MAKE ,SE-CAVE ,LIGHTED>)>
	 
	 <SET OBJ <GETP ,SE-CAVE ,P?MIRROR-OBJ>>
	 <COND (<EQUAL? .OBJ <> ,NO-MIRROR>)
	       (<AND <IS? ,SWALL ,OPENED>
		     <EQUAL? <GETP .OBJ ,P?MIRROR-DIR> ,I-SOUTH>>
		<PUTP ,SE-CAVE ,P?BEAM-DIR ,I-SE>
		<MAKE ,SE-CAVE ,LIGHTED>
		<SET RM ,SE-CAVE>
		<SET DIR ,I-SW>
		<REPEAT ()
		   <SET TBL <GETP .RM <GETB ,PDIR-LIST .DIR>>>
		   <COND (<ZERO? .TBL>
			  <RETURN>)
			 (<NOT <EQUAL? <MSB <GET .TBL ,XTYPE>> 
				       ,CONNECT ,SCONNECT>>
			  <RETURN>)>
		   <SET XDIR <+ .DIR 4>> ; "Establish opposite DIR."
		   <COND (<G? .XDIR ,I-NW>
			  <SET XDIR <- .XDIR 8>>)>
		   <SET RM <GET .TBL ,XROOM>>   ; "Check next room."
		   <SET OBJ <GETP .RM ,P?MIRROR-OBJ>> ; "Got a mirror?"
		   <COND (<ZERO? .OBJ> ; "Escaped caves, so done."
			  <RETURN>)
			 (<IS? .RM ,LIGHTED>
			  <INC POPIT>)>
		   <PUTP .RM ,P?BEAM-DIR .XDIR>
		   <MAKE .RM ,LIGHTED>
		   
		   <COND (<EQUAL? .OBJ ,NO-MIRROR> ; "Continue if none."
			  <AGAIN>)>
		   <SET ANGLE <GETP .OBJ ,P?MIRROR-DIR>> ; "Angle of new."
		   <COND (<EQUAL? .ANGLE .DIR> ; "Back facing beam?"
			  <COND (<HERE? .RM>
				 <TELL ,TAB "The back of " THE ,MIRROR0
				       " is illuminated by a sunbeam." CR>)>
			  <RETURN>)
			 (<EQUAL? .ANGLE .XDIR>
			  <COND (<HERE? .RM>
				 <TELL ,TAB "A sunbeam is reflected "
				       B <GET ,DIR-NAMES .XDIR>
				       ,PERIOD>)>
			  <RETURN>)>
		   <SET X <+ .DIR 2>> ; "Check for edge-on mirror."
		   <COND (<G? .X ,I-NW>
			  <SET X <- .X 8>>)>
		   <COND (<EQUAL? .ANGLE .X>
			  <COND (<HERE? .RM>
				 <MENTION-GLIMMER .XDIR>)>
			  <AGAIN>)>
		   <SET X <- .DIR 2>> ; "Check other edge."
		   <COND (<L? .X ,I-NORTH>
			  <SET X <+ .X 8>>)>
		   <COND (<EQUAL? .ANGLE .X>
			  <COND (<HERE? .RM>
				 <MENTION-GLIMMER .XDIR>)>
			  <AGAIN>)>
		   <SET X <+ .DIR 3>> ; "Check for CW reflection."
		   <COND (<G? .X ,I-NW>
			  <SET X <- .X 8>>)>
		   <COND (<EQUAL? .ANGLE .X>
			  <SET DIR <+ .DIR 2>>
			  <COND (<G? .DIR ,I-NW>
				 <SET DIR <- .DIR 8>>)>
			  <COND (<HERE? .RM>
				 <SAY-BEAM .XDIR .DIR>)>
			  <AGAIN>)>
		   <SET X <+ .DIR 5>> ; "Check for CCW reflection."
		   <COND (<G? .X ,I-NW>
			  <SET X <- .X 8>>)>
		   <COND (<EQUAL? .ANGLE .X>
			  <SET DIR <- .DIR 2>>
			  <COND (<L? .DIR ,I-NORTH>
				 <SET DIR <+ .DIR 8>>)>
			  <COND (<HERE? .RM>
				 <SAY-BEAM .XDIR .DIR>)>
			  <AGAIN>)>
		   <RETURN>>)>
	 <COND (<T? .ALERT>
		<SAY-IF-HERE-LIT>)>
	 <REFRESH-MAP>
	 <COND (<T? .POPIT>
		<PUTP <GETP ,SE-CAVE ,P?MIRROR-OBJ> ,P?SIZE 1>)>
	 <RFALSE>>		
		      
<ROUTINE SAY-BEAM (FROM TO)
        <PRINT "  A beam of sunlight ">
	<TELL "is reflected " B <GET ,DIR-NAMES .FROM>
	      ,STO B <GET ,DIR-NAMES .TO>>
	<COND (<AND <HERE? IN-LAIR>
		    <EQUAL? .TO ,I-SE>
		    <IN? ,URGRUE ,IN-LAIR>>
	       <KILL-URGRUE>
	       <RTRUE>)>
	<TELL ,PERIOD>
	<RTRUE>>

<ROUTINE MENTION-GLIMMER (DIR)
       	 <TELL ,TAB ,XTHE B <GET ,DIR-NAMES .DIR>
	       " edge of the mirror gleams." CR>
	 <RTRUE>>
	  
<ROUTINE URGRUE-GETS-COCO ("OPT" (I <>))
	 <DEQUEUE ,I-IMPS-TAKE>
	 <SETG IMPSAY 4>
	 <QUEUE ,I-IMPQUEST>
	 <REMOVE ,COCO>
	 <MAKE ,COCO ,NODESC>
	 <MAKE ,COCO ,SEEN>
	 <WINDOW ,SHOWING-ROOM>
	 <TELL "As ">
	 <COND (<ZERO? .I>
		<TELL "you reach">)
	       (T
		<TELL "the Implementor reaches">)>
	 <TELL " towards " THE ,COCO 
", a vortex of laughing darkness boils up from underfoot!|
  \"More company,\" sighs the ">
	 <PRINT "cheerful-looking Implementor">
	 <TELL ,PTAB 
"You back away from the zone of darkness as it spreads across the Plane, reaching out with long black fingers, searching, searching.." ,PTAB>
	 <ITALICIZE "Slurp">
	 <TELL "! " CTHE ,COCO 
" falls into the eye of the vortex and disappears, along with a stack of lunch meat and bits of cutlery from the Implementors' table. Then, with a final chortle, the vortex draws itself together, turns sideways and flickers out of existence.|
  \"Ur-grue?\" asks the only woman Implementor.|
  \"Ur-grue,\" nods another." CR>    
	 <RTRUE>>

<OBJECT PLAZA
	(LOC LOCAL-GLOBALS)
	(DESC "plaza")
	(FLAGS NODESC)
	(SYNONYM PLAZA)
	(ACTION HERE-F)>

"SEEN = assigned."

<OBJECT ARCH
	(DESC "arch")
	(FLAGS VEHICLE VOWEL CONTAINER OPENED SURFACE)
	(SYNONYM ARCH OPENING)
	(ADJECTIVE STONE ROCK)
	(CAPACITY 1000)
	(DESCFCN ARCH-F)
	(ACTION ARCH-F)>

<ROUTINE ARCH-F ("OPT" (CONTEXT <>) "AUX" TIME OBJ X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL "A crumbling stone arch stands ">
		       <COND (<EQUAL? ,ATIME ,PRESENT>
			      <TELL "at the exact center of " THE ,PLAZA>)
			     (T
			      <TELL "nearby">)>
		       <COND (<SEE-ANYTHING-IN? ,ARCH>
			      <TELL ". Beneath it you see ">
			      <CONTENTS ,ARCH>)>
		       <TELL C ,PER>
		       <SETG P-IT-OBJECT ,ARCH>
		       <RTRUE>)
		      (<EQUAL? .CONTEXT ,M-BEG>
		       <SET OBJ ,PRSO>
		       <COND (<THIS-PRSI?>
			      <SET OBJ ,PRSI>)>
		       <COND (<CANT-REACH-WHILE-IN? .OBJ ,ARCH>
			      <RTRUE>)>
		       <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT-ON>
		       <TELL "The top of " THEI " is high out of reach." CR>
		       <RTRUE>)
		      (<VERB? THROW-OVER>
		       <WASTE-OF-TIME>
		       <RTRUE>)
		      (<VERB? PUT-UNDER>
		       <COND (<IN? ,PLAYER ,PRSI>
			      <PERFORM ,V?DROP ,PRSO>
			      <RTRUE>)>
		       <PERFORM ,V?PUT ,PRSO ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO
" is tall and narrow. The opening beneath is shaped like an hourglass." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER SEARCH>
		<COND (<IN? ,PLAYER ,PRSO>
		       <ASIDE-FROM>)
		      (T
		       <TELL ,YOU-SEE>)>
		<CONTENTS>
		<TELL " under " THEO ,PERIOD>
		<SETG P-IT-OBJECT ,PRSO>
		<RTRUE>)
	       (<VERB? ENTER THROUGH WALK-TO STAND-UNDER FOLLOW>
		<ENTER-ARCH>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<EXIT-ARCH>
		<RFATAL>)
	       (<VERB? WALK-AROUND LOOK-BEHIND>
		<COND (<IN? ,PLAYER ,PRSO>
		       <YOUD-HAVE-TO "leave">
		       <RTRUE>)>
		<TELL "You walk slowly around " THEO
		      ", but find nothing " <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<TELL "The sides of " THEO " are too steep to climb." CR>
		<RTRUE>)
	       (<VERB? CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTER-ARCH ()
	 <COND (<IN? ,PLAYER ,ARCH>
		<TELL ,ALREADY "under " THE ,ARCH ,PERIOD>
		<RFALSE>)
	       (<DROP-ONION-FIRST?>
		<RFALSE>)>
	 <SETG OLD-HERE <>>
	 <SETG P-WALK-DIR <>>
	 <MOVE ,PLAYER ,ARCH>
	 <TELL "You step beneath the shadow of " THE ,ARCH ,PERIOD>
	 <COND (<AND <IN? ,MINX ,HERE>
		     <IS? ,MINX ,LIVING>>
		<I-MINX>)>
	 <COND (<AND <IN? ,DACT ,HERE>
		     <IS? ,DACT ,LIVING>
		     <NOT <IS? ,DACT ,SLEEPING>>>
		<WINDOW ,SHOWING-ROOM>
		<REMOVE ,DACT>
		<TELL ,TAB CTHE ,DACT
" spreads its wings and soars out of sight." CR>)>
	 <COND (<ZERO? ,DMODE>
		<CRLF>)>	 
	 <COND (<T? ,GLASS-TOP>
		<ARCH-ON>)>
	 <RFALSE>>

<ROUTINE EXIT-ARCH ()
	 <COND (<NOT <IN? ,PLAYER ,ARCH>>
		<TELL "You're not under " THE ,ARCH ,PERIOD>
	        <RFALSE>)
	       (<IS? ,ARCH ,SEEN>
		<PRINT "Such movement is meaningless now.">
		<CRLF>
		<RFALSE>)>
	 <SETG OLD-HERE <>>
	 <MOVE ,PLAYER ,HERE>
	 <TELL "You step out from under " THE ,ARCH ,PERIOD>
	 <COND (<ZERO? ,DMODE>
		<CRLF>)>
	 <RFALSE>>

<ROUTINE ARCH-ON ()
	 <COND (<AND <IN? ,PLAYER ,ARCH>
		     <NOT <IS? ,GLASS ,NEUTRALIZED>>>
		<TURN-ON-ARCH>)>
	 <RFALSE>>

<ROUTINE TURN-ON-ARCH ("AUX" DIR TBL X)
	 <MAKE ,ARCH ,SEEN>
	 <SETG P-WALK-DIR <>>
	 <SETG OLD-HERE <>>
	 <PUTP ,HERE ,P?EXIT-STR "Such movement is meaningless now.">
	 <COND (<NOT <HERE? ARCH-VOID>>
		<NEW-EXIT? ,HERE ,P?OUT ,NO-EXIT>)>
	 <NEW-EXIT? ,HERE ,P?NORTH %<+ ,FCONNECT 9 ,MARKBIT> ,TIMESHIFT>
	 <NEW-EXIT? ,HERE ,P?SOUTH %<+ ,FCONNECT 9 ,MARKBIT> ,TIMESHIFT>
	 <COND (<EQUAL? ,ATIME ,PRESENT>
		<SET DIR ,P?NW>
		<REPEAT ()
		   <COND (<NOT <EQUAL? .DIR ,P?SOUTH>>
			  <SET TBL <GETP ,HERE .DIR>>
			  <COND (<T? .TBL>
				 <SET X <BAND <GET .TBL ,XTYPE> 255>>
				 <PUT .TBL ,XTYPE <+ .X ,NO-EXIT>>)>)>
		   <COND (<IGRTR? DIR ,P?NE>
			  <RETURN>)>>)>
	 <MOVE ,LIGHTSHOW ,ARCH>
	 <TELL ,TAB>
	 <COND (<IS? ,ARCH ,IDENTIFIED>
		<TELL "The nightmare sensation returns">)
	       (T
		<MAKE ,ARCH ,IDENTIFIED>
		<TELL 
"A nightmare sensation grips your senses! Your field of vision warps into a narrow " 'LIGHTSHOW ", stretching ">
		<PRINT "north and south into infinity">)>
	 <PRINT ,PERIOD>
	 <COND (<ZERO? ,DMODE>
		<CRLF>)>
	 <RFALSE>>

<ROUTINE ARCH-OFF ("AUX" X)
	 <SET X <LOC ,PLAYER>>
	 <COND (<AND <EQUAL? .X ,ARCH <LOC ,ARCH>>
		     <IS? ,ARCH ,SEEN>>
		<TURN-OFF-ARCH>)>
	 <RFALSE>>

<ROUTINE TURN-OFF-ARCH ("AUX" DIR TBL X STR)
	 <UNMAKE ,ARCH ,SEEN>
	 <SETG P-WALK-DIR <>>
	 <SETG OLD-HERE <>>
	 <NEW-EXIT? ,HERE ,P?NORTH ,NO-EXIT>
	 <NEW-EXIT? ,HERE ,P?SOUTH ,NO-EXIT>
	 <SET STR "An irresistible force keeps you near the arch.">
	 <COND (<HERE? ARCH-VOID>
		<SET STR "Only void lies that way.">)
	       (T
		<NEW-EXIT? ,HERE ,P?OUT %<+ ,FCONNECT ,MARKBIT>>
		<COND (<EQUAL? ,ATIME ,PRESENT>
		       <SET STR "Ruins block your path.">
		       <SET DIR ,P?NW>
		       <REPEAT ()
		          <COND (<NOT <EQUAL? .DIR ,P?SOUTH>>
				 <SET TBL <GETP ,HERE .DIR>>
				 <COND (<T? .TBL>
					<SET X <BAND <GET .TBL ,XTYPE> 255>>
					<PUT .TBL ,XTYPE <+ .X ,CONNECT>>)>)>
			  <COND (<IGRTR? DIR ,P?NE>
				 <RETURN>)>>)>)>
	 <PUTP ,HERE ,P?EXIT-STR .STR>
	 <REMOVE ,LIGHTSHOW>
	 <TELL ,TAB>
	 <COND (<IS? ,PLAZA ,IDENTIFIED>
		<TELL "Y">)
	       (T
		<MAKE ,PLAZA ,IDENTIFIED>
		<TELL "The infinite " 'LIGHTSHOW
		      " abruptly collapses, and y">)>
	 <TELL "our field of view snaps back to normal." CR>
	 <COND (<ZERO? ,DMODE>
		<CRLF>)>
	 <RFALSE>>

<OBJECT LIGHTSHOW
	(DESC "corridor of light")
	(FLAGS NODESC)
	(SYNONYM CORRIDOR LIGHT)
	(ADJECTIVE INFINITE INFINITY)
	(ACTION LIGHTSHOW-F)>

<ROUTINE LIGHTSHOW-F ("AUX" X)
	 <COND (<OR <VERB? EXAMINE LOOK-ON LOOK-INSIDE>
		    <SET X <ENTERING?>>
		    <SET X <EXITING?>>>
		<TELL CTHEO " seems to extend ">
		<PRINT "north and south into infinity">
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<SET X <SEEING?>>
		<CANT-SEE-MUCH>
		<RTRUE>)>
	 <USELESS ,LIGHTSHOW>
	 <RFATAL>>		

<OBJECT HELM
	(LOC PRINCE)
	(DESC "helmet")
	(SDESC DESCRIBE-HELM)
	(FLAGS TAKEABLE CLOTHING FERRIC)
	(SIZE 2)
	(EFFECT 5)
	(EMAX 5)
	(VALUE 25)
	(DNUM 25)
	(SYNONYM HELM HELMET HEADPIECE PHEE PHEEHELM)
	(ADJECTIVE PHEE)
	(ACTION HELM-F)>


<ROUTINE HELM-F ("AUX" FX)
	 <SET FX <GETP ,HELM ,P?EFFECT>>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"This dazzling treasure is so heavily crusted with jewels, it's hard to see the precious metals underneath." CR>
		<RTRUE>)
	       (<AND <VERB? WEAR>
		     <NOT <IS? ,PRSO ,WORN>>>
		<COND (<DONT-HAVE?>
		       <RTRUE>)>
		<WINDOW ,SHOWING-INV>
		<MAKE ,PRSO ,WORN>
		<TELL "You lower " THEO " onto " 'HEAD>
		<COND (<IN? ,GRUE ,HERE>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL ,COMMA-AND A ,GRUE 
			     " takes shape in the darkness nearby">)>
		<PRINT ,PERIOD>
		<UPDATE-STAT .FX ,ARMOR-CLASS>
		<COND (<NOT <IS? ,PRSO ,NEUTRALIZED>>
		       <WINDOW ,SHOWING-ALL>
		       <UPDATE-STAT 30 ,INTELLIGENCE>)>
		<RTRUE>)
	       (<AND <VERB? TAKE-OFF>
		     <IS? ,PRSO ,WORN>
		     <IN? ,PRSO ,PLAYER>>
		<WINDOW ,SHOWING-INV>
		<UNMAKE ,PRSO ,WORN>
		<TELL "You lift " THEO " off " 'HEAD>
		<COND (<IN? ,GRUE ,HERE>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL ,COMMA-AND THE ,GRUE 
			     " merges into the darkness">)>
		<TELL ,PERIOD>
		<UPDATE-STAT <- 0 .FX> ,ARMOR-CLASS>
		<COND (<NOT <IS? ,PRSO ,NEUTRALIZED>>
		       <NORMAL-IQ>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NORMAL-IQ ("AUX" X MAX)
	 <WINDOW ,SHOWING-ALL>
	 <SET X <GET ,STATS ,INTELLIGENCE>>
	 <SET MAX <GET ,MAXSTATS ,INTELLIGENCE>>
	 <COND (<G? .X .MAX>
		<UPDATE-STAT <- 0 <- .X .MAX>> ,INTELLIGENCE>)>
	 <RFALSE>>

<OBJECT BHORSE
	(DESC "black stallion")
	(FLAGS SURFACE LIVING)
	(SYNONYM STALLION HORSE)
	(ADJECTIVE BLACK DARK)
	(DESCFCN BHORSE-F)
	(ACTION BHORSE-F)>

<ROUTINE BHORSE-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL "A black horse">
		       <PRINT " bears a sinister knight.">
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <BATTLE-MISS>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO>
		<PRINT " bears a sinister knight.">
		<CRLF>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<NOT-LONELY ,KNIGHT>
		<RTRUE>)
	       (<SET X <TALKING?>>
		<NOT-LIKELY>
		<PRINT " would respond.|">
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<ZING>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE SLAY-HORSE ()
	 <MOVE ,DEAD-HORSE ,HERE>
	 <WINDOW ,SHOWING-ROOM>
	 <UNMAKE ,PRINCE ,NODESC>
	 <MOVE ,HORSE ,TRENCH>
	 <UNMAKE ,TRENCH ,OPENED>
	 <MAKE ,HORSE ,NODESC>
	 <UNMAKE ,HORSE ,LIVING>
       ; <REPLACE-ADJ? ,HORSE ,W?ZZZP ,W?DEAD>
       ; <PUTP ,HORSE ,P?ACTION ,DEAD-HORSE-F>	 
	 <TELL 
"stray arrow strikes the prince's stallion in the flank. The luckless beast shrieks piteously, stumbles into " THE ,TRENCH " and lies still." CR>
	 <RTRUE>>

<OBJECT HORSE
	(DESC "stallion")
	(SDESC DESCRIBE-HORSE)
	(FLAGS SURFACE LIVING)
	(CAPACITY 25)
	(SYNONYM STALLION HORSE)
	(ADJECTIVE GRAY GREY PRINCE\'S)
	(CONTFCN HORSE-F)
	(DESCFCN HORSE-F)
	(ACTION HORSE-F)>


<ROUTINE HORSE-F ("OPT" (CONTEXT <>) "AUX" X OBJ)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <COND (<IN? ,PRINCE ,HORSE>
			      <TELL "A prince sits on a " D ,HORSE C ,PER>
			      <RTRUE>)>
		       <TELL CA ,HORSE 
" stands beside the headless body of a prince.">
		       <RTRUE>)
		      (<EQUAL? .CONTEXT ,M-CONT>
		       <SET OBJ ,PRSO>
		       <COND (<THIS-PRSI?>
			      <SET OBJ ,PRSI>)>
		       <COND (<ZERO? .OBJ>)
			     (<SET X <TOUCHING?>>
			      <TELL ,CANT "reach " THE .OBJ
				    ,AT-MOMENT>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <BATTLE-MISS>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO ,SIS>
		<COND (<IN? ,PRINCE ,PRSO>
		       <TELL "bearing " THE ,PRINCE ,PERIOD>
		       <RTRUE>)>
		<TELL "riderless." CR>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<COND (<IN? ,PRINCE ,PRSO>
		       <NOT-LONELY ,PRINCE>
		       <RTRUE>)>
		<ZING>
		<RTRUE>)
	       (<VERB? TELL ASK-ABOUT ASK-FOR TELL-ABOUT YELL>
		<TELL CTHE ,HORSE " pays no attention." CR>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<ZING>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE NOT-LONELY (WHO)
	 <TELL CTHE .WHO " doesn't seem lonely." CR>
	 <RTRUE>>

<ROUTINE BATTLE-MISS ()
	 <MOVE ,PRSO ,HERE>
	 <WINDOW ,SHOWING-ALL>
	 <TELL CTHEO " narrowly misses " THEI
	       " and tumbles to " THE ,GROUND ,PERIOD>
	 <RTRUE>>

<OBJECT DEAD-HORSE
	(DESC "stallion")
	(FLAGS NODESC TRYTAKE NOALL SURFACE)
	(SYNONYM HORSE STALLION)
	(ADJECTIVE DEAD GRAY GREY)
	(ACTION DEAD-HORSE-F)>

<ROUTINE DEAD-HORSE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO >
		<PRINT " is lying across ">
		<TELL THE ,TRENCH ,PERIOD>
		<RTRUE>)
	       (<VERB? TELL ASK-ABOUT ASK-FOR TELL-ABOUT YELL>
		<NOT-LIKELY>
		<TELL " will respond." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<TELL CTHEO " is much too heavy." CR>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<ZING>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TRENCH
	(DESC "trench")
	(SDESC DESCRIBE-TRENCH)
	(FLAGS NODESC CONTAINER OPENED)
	(CAPACITY 100)
	(SYNONYM TRENCH PIT HOLE ZZZP)
	(ADJECTIVE ZZZP)
	(CONTFCN TRENCH-F)
	(DESCFCN TRENCH-F)
	(ACTION TRENCH-F)>
	       
<VOC "MINXHOLE" NOUN>


<ROUTINE TRENCH-F ("OPT" (CONTEXT <>) "AUX" X OBJ)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,TRENCH " is visible on " THE ,GROUND>
		       <COND (<SEE-ANYTHING-IN? ,TRENCH>
			      <TELL ". Inside it you see ">
			      <CONTENTS ,TRENCH>
			      <SETG P-IT-OBJECT ,TRENCH>)>
		       <TELL C ,PER>
		       <RTRUE>)
		      (<EQUAL? .CONTEXT ,M-CONT>
		       <SET OBJ ,PRSO>
		       <COND (<THIS-PRSI?>
			      <SET OBJ ,PRSI>)>
		       <COND (<EQUAL? .OBJ <> ,HORSE>
			      <RFALSE>)
			     (<IN? ,HORSE ,TRENCH>)
			     (<AND <HERE? ARCH4>
				   <IN? ,HELM ,TRENCH>>
			      <SAY-SLAY> 
			      <RFATAL>)
			     (T
			      <RFALSE>)>
		       <TELL ,CANT>
		       <COND (<SET X <SEEING?>>
			      <TELL B ,W?SEE>)
			     (<SET X <TOUCHING?>>
			      <TELL B ,W?REACH>)
			     (T
			      <TELL "do that to">)>
		       <TELL C ,SP THE .OBJ ". " CTHE ,HORSE
			     " is blocking " THE ,TRENCH ,PERIOD>
		       <RTRUE>)>
	        <RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO THROW>
		       <MOVE ,PRSO ,PRSI>
		       <WINDOW ,SHOWING-ALL>
		       <TELL CTHEO " rolls deep into " THEI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL CTHEO>
		<COND (<HERE? ARCH4>
		       <TELL " forms an unsightly gash in the plaza">)
		      (T
		       <TELL " looks much like any other">)>
		<COND (<IN? ,HORSE ,PRSO>
		       <TELL ". " CA ,HORSE>
		       <PRINT " is lying across ">
		       <TELL B ,W?IT>)
		      (<SEE-ANYTHING-IN?>
		       <TELL ". ">
		       <PRINT "Peering inside, you see ">
		       <CONTENTS>
		       <SETG P-IT-OBJECT ,PRSO>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<OR <VERB? REACH-IN>
		    <SET X <ENTERING?>>>
		<COND (<IN? ,HORSE ,TRENCH>
		       <TELL CTHE ,HORSE " is blocking " THEO ,PERIOD>
		       <RTRUE>)
		      (<VERB? REACH-IN>
		       <TELL "You grope around in " THEO>
		       <COND (<SEE-ANYTHING-IN?>
			      <TELL ", and feel something." CR>
			      <RTRUE>)>
		       <TELL ", but feel nothing " 
			     <PICK-NEXT ,YAWNS> ,PERIOD>
		       <RTRUE>)>
		<TELL CTHEO 
"'s sides begin to crumble, so you hastily scramble out again." CR>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE ZING ()
	 <AS-YOU-APPROACH>
	 <TELL "an arrow zings across your path." CR>
	 <RTRUE>>

<ROUTINE AS-YOU-APPROACH ("OPT" (OBJ ,PRSO))
	 <TELL "As you approach " THE .OBJ ", ">
	 <RTRUE>>

<OBJECT SACK
	(LOC HUNTER)
	(DESC "burlap sack")
	(FLAGS TRYTAKE NOALL CONTAINER OPENABLE)
	(SYNONYM SACK BAG)
	(ADJECTIVE BURLAP)
	(CAPACITY 10)
      ; (ACTION SACK-F)>
		
<OBJECT MAW
	(DESC "idol's maw")
	(FLAGS NODESC VOWEL SURFACE VEHICLE)
	(CAPACITY 100)
	(SYNONYM MOUTH MAW JAW)
	(ADJECTIVE IDOL\'S LOWER)
	(CONTFCN MAW-F)
	(DESCFCN MAW-F)
	(ACTION MAW-F)>

<ROUTINE MAW-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<SET OBJ ,PRSO>
		<COND (<THIS-PRSI?>
		       <SET OBJ ,PRSI>)>
		<COND (<EQUAL? .CONTEXT ,M-BEG>
		       <RETURN <CANT-REACH-WHILE-IN? .OBJ ,MAW>>)
		      (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<IN? ,PLAYER ,MAW>
			      <COND (<NOT <EQUAL? .OBJ ,TEAR>>
				     <RFALSE>)
				    (<IS? .OBJ ,TAKEABLE>
				     <RFALSE>)
				    (<SET X <TOUCHING?>>
				     <TOUCH-TEAR>
				     <RFATAL>)>
			      <RFALSE>)
			     (<SET X <TOUCHING?>>				
			      <YOUD-HAVE-TO "climb up into" ,MAW>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<SEE-MAW>
		<RTRUE>)>
	 <RETURN <HANDLE-MAW?>>>

<ROUTINE SEE-MAW ()
	 <TELL 
"The maw hangs wide open, its lower jaw touching " THE ,GROUND 
" to form an inclined walkway lined with rows of stone teeth." CR>
	 <RTRUE>>

<ROUTINE HANDLE-MAW? ("AUX" X)
	 <COND (<VERB? LOOK-INSIDE SEARCH>
		<COND (<IN? ,PLAYER ,MAW>
		       <ASIDE-FROM>)
		      (T
		       <TELL ,YOU-SEE>)>
		<CONTENTS ,MAW>
		<TELL " lying in " THE ,MAW ,PERIOD>
		<SETG P-IT-OBJECT ,PRSO>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<ENTER-CROCO>
		<COND (<IN? ,PLAYER ,MAW>
		       <RTRUE>)>
		<RFATAL>)
	       (<SET X <CLIMBING-OFF?>>
	        <EXIT-CROCO>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<OBJECT CROCO
	(DESC "idol")
	(FLAGS NODESC VOWEL)
	(SYNONYM IDOL CROCODILE STATUE)
	(ADJECTIVE CROCODILE STONE ROCK)
	(ACTION CROCO-F)>

<ROUTINE CROCO-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON EMPTY-INTO>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL
"This monstrous idol is approximately the size and shape of a subway train, not counting the limbs and tail. ">
		<SEE-MAW>
		<COND (<IN? ,TEAR ,MAW>
		       <TELL ,TAB CA ,TEAR
" adorns the idol's face, just below one eye." CR>)>
		<RTRUE>)
	       (<HANDLE-MAW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE EXIT-CROCO ()
	 <COND (<NOT <IN? ,PLAYER ,MAW>>
		<NOT-IN ,MAW>
		<RFALSE>)
	       (<IN? ,MAMA ,MAW>
		<TELL CTHE ,MAMA " is blocking the way." CR>
		<RFALSE>)>
	 <CLEAR-MAW-EXITS>
	 <MOVE ,PLAYER <LOC ,MAW>>
	 <SETG P-WALK-DIR <>>
	 <TELL CTHE ,MAW " steadies itself as you descend">
	 <RELOOK>
	 <RFALSE>>	 

<ROUTINE ENTER-CROCO ("AUX" TBL)
	 <COND (<IN? ,PLAYER ,MAW>
		<TELL ,CYOU>
		<COND (<IN? ,MAMA ,MAW>
		       <TELL "squeeze " 'ME 
			     " up as far as you can go." CR>
		       <RFALSE>)>
		<TELL "edge a bit further into the open maw." CR>
		<INTO-INNARDS>
		<RFALSE>)>
	 <PUTP ,HERE ,P?BELOW ,MAW>
	 <NEW-EXIT? ,HERE ,P?DOWN %<+ ,FCONNECT 1 ,MARKBIT> ,EXIT-CROCO>
	 <MOVE ,PLAYER ,MAW>
	 <WINDOW ,SHOWING-ROOM>
	 <SETG P-WALK-DIR <>>
	 <TELL "You climb up into " THE ,MAW>
	 <RELOOK>
	 <TELL ,TAB 
"The stone jaw lurches underfoot, and you struggle to keep your balance. It's like standing on a seesaw." CR>
	 <RFALSE>>

<ROUTINE INTO-INNARDS ("AUX" OBJ NXT)
	 <CLEAR-MAW-EXITS>
	 <GOOD-MAMA>
	 <TELL ,TAB>
	 <ITALICIZE "Creak">
	 <TELL 
"! The bottom of the jaw tilts backward, pitching you helplessly forward...">
	 <CARRIAGE-RETURNS>
	 <SETG P-WALK-DIR <>>
	 <SETG OLD-HERE <>>
	 <UNMAKE ,INNARDS ,SEEN>
	 <SETG HERE ,INNARDS>
	 <MOVE ,PLAYER ,INNARDS>
	 <COND (<SET OBJ <FIRST? ,MAW>>
		<REPEAT ()
		   <SET NXT <NEXT? .OBJ>>
		   <COND (<IS? .OBJ ,TAKEABLE>
			  <MOVE .OBJ ,INNARDS>)>
		   <SET OBJ .NXT>
		   <COND (<ZERO? .OBJ>
			  <RETURN>)>>)>
	 <RFALSE>>

<ROUTINE TOUCH-TEAR ("AUX" (M 0))
	 <TELL CTHE ,MAW " tilts dangerously as you reach upward">
	 <COND (<OR <IN? ,MAMA ,MAW>
		    <IS? ,TEAR ,MUNGED>>
		<TELL 
", standing on tiptoe to grasp the sparkling treasure.." ,PERIOD>
		<COND (<IN? ,MAMA ,MAW>
		       <MAKE ,TEAR ,MUNGED>
		       <UNMAKE ,TEAR ,TRYTAKE>
		       <UNMAKE ,TEAR ,NOALL>
		       <MAKE ,TEAR ,TAKEABLE>
		       <MOVE ,TEAR ,MAMA>
		       <GOOD-MAMA>
		       <TELL ,TAB 
"Got it! The jewel pops off the idol's face, slips from your grasp and rolls down to " THE ,MAMA 
"'s feet, where she promptly eats it, turns and lumbers off the jaw." CR>)> 
		<INTO-INNARDS>
		<RTRUE>)>
	 <MAKE ,TEAR ,MUNGED>
	 <TELL "!|
  Slowly, slowly, you draw your hand away from " THE ,TEAR
", and the jaw settles back to the ground." CR>
	 <RTRUE>> 

<OBJECT TEAR
	(LOC MAW)
	(DESC "tear-shaped jewel")
	(FLAGS TRYTAKE NOALL)
	(VALUE 1000)
	(SIZE 0)
	(SYNONYM JEWEL GEM TEAR TREASURE)
	(ADJECTIVE TEAR SHAPED TEAR\-SHAPED CROCODILE)
	(ACTION TEAR-F)>

<ROUTINE TEAR-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE LOOK-ON>
		<TELL "Its pale ">
		<COND (<SEE-COLOR?>
		       <TELL "blue">)
		      (T
		       <TELL "gray">)>
		<TELL " facets sparkle with obvious value." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IDOL-ROOM
	(LOC INNARDS)
	(DESC "idol")
	(FLAGS NODESC VOWEL PLACE)
	(SYNONYM IDOL CROCODILE CHAMBER ROOM WALLS WALL)
	(ADJECTIVE STONE ROCK)
	(ACTION HERE-F)>
		       
<OBJECT JUNGLE
	(LOC LOCAL-GLOBALS)
	(DESC "jungle")
	(FLAGS NODESC PLACE)
	(SYNONYM JUNGLE FOREST)
	(ACTION JUNGLE-F)>

<ROUTINE JUNGLE-F ("AUX" LEN X)
	 <SET LEN <GETB ,JUNGLE-ROOMS 0>>
	 <COND (<VERB? LISTEN>
		<TELL ,YOU-HEAR "the cries of exotic birds." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "The air is warm and humid." CR>
		<RTRUE>)
	       (<SET LEN <INTBL? ,HERE <REST ,JUNGLE-ROOMS 1> .LEN 1>>
		<RETURN <HERE-F>>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<HERE? AT-FALLS>
		       <CANT-SEE-MUCH>
		       <RTRUE>)
		      (<HERE? OVER-JUNGLE NW-SUPPORT SW-SUPPORT SE-SUPPORT>
		       <TELL CTHEO 
" stretches off in every " 'INTDIR ,PERIOD>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<COND (<HERE? NW-UNDER>
		       <DO-WALK ,P?SE>
		       <RTRUE>)
		      (<HERE? SW-UNDER>
		       <DO-WALK ,P?NE>
		       <RTRUE>)
		      (<HERE? SE-UNDER>
		       <DO-WALK ,P?NW>
		       <RTRUE>)
		      (<HERE? AT-FALLS>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)>
		<TELL "It's a long way down." CR>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<COND (<HERE? SW-UNDER NW-UNDER SE-UNDER>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT PRAIRIE
	(LOC LOCAL-GLOBALS)
	(DESC "field")
	(FLAGS NODESC PLACE)
	(SYNONYM FIELDS FIELD FROTZEN PRAIRIE PLAIN GRASS)
	(ADJECTIVE FROTZEN GOLD GOLDEN GRAY GREY)
	(ACTION PRAIRIE-F)>

<ROUTINE PRAIRIE-F ("AUX" X)
	 <COND (<AND <ADJ-USED? ,W?GRAY ,W?GREY>
		     <IS? ,HERE ,SEEN>>
		<NOTE-COLOR ,PRAIRIE>
		<RFATAL>)
	       (<PLAIN-ROOM?>
		<COND (<HERE-F>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <ENTERING?>>
		<SET X ,P?EAST>
		<COND (<HERE? ON-PIKE>
		       <SET X ,P?WEST>)>
		<DO-WALK .X>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-ON>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NOTE-COLOR (OBJ)
	 <TELL "Look again. " CTHE .OBJ>
	 <ISNT-ARENT .OBJ>
	 <TELL " gray anymore." CR>
	 <RTRUE>>	       

<OBJECT FARM-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "door")
	(FLAGS NODESC DOORLIKE OPENABLE OPENED)
	(SYNONYM DOOR DOORWAY)
	(ACTION FARM-DOOR-F)>

<ROUTINE FARM-DOOR-F ()
	 <COND (<NOT <HERE? IN-FARM>>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? OPEN OPEN-WITH HIT MUNG KICK>
		     <IN? ,TWISTER ,HERE>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<TELL "No use. The wind is holding " THEO
		       " tightly shut." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>		  

<OBJECT FARM-WINDOW
	(LOC LOCAL-GLOBALS)
	(DESC "window")
	(FLAGS NODESC CONTAINER OPENED)
	(CAPACITY 10000)
	(SYNONYM WINDOW)
	(ACTION FARM-WINDOW-F)>

<ROUTINE FARM-WINDOW-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT THROW THROW-OVER EMPTY-INTO>
		       <COND (<NOT <IS? ,PRSI ,OPENED>>
			      <YOUD-HAVE-TO "open" ,PRSI>
			      <RTRUE>)>
		       <VANISH>
		       <TELL CTHEO " falls ">
		       <COND (<HERE? FARM-ROOM IN-FROON>
			      <MOVE ,PRSO ,IN-FARM>
			      <TELL "in">)
			     (T
			      <COND (<ZERO? ,STORM-TIMER>
				     <MOVE ,PRSO ,FARM-ROOM>)>
			      <TELL "out">)>
		       <TELL "side " THEI>
		       <PRINT " and disappears from view.|">
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO ,SIS>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "wide open." CR>
		       <RTRUE>)>
		<TELL "closed." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-OUTSIDE>
		<COND (<HERE? FARM-ROOM IN-FROON>
		       <COND (<VERB? LOOK-OUTSIDE>
			      <TELL ,ALREADY "outside " THEO ,PERIOD>
			      <RTRUE>)>
		       <CANT-SEE-MUCH>
		       <RTRUE>)
		      (<NOT <LOC ,TWISTER>>
		       <TELL "It seems to be getting darker." CR>
		       <RTRUE>)>
		<TELL "Whirling clouds of dust obscure the view." CR>
		<RTRUE>)
	       (<VERB? HIT MUNG KICK>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<VERB? LEAP ENTER THROUGH CLIMB-OVER ESCAPE DIVE>
		<COND (<NOT <IS? ,PRSO ,OPENED>>
		       <YOUD-HAVE-TO "open">
		       <RTRUE>)
		      (<HERE? FARM-ROOM IN-FROON>
		       <WINDOW-SQUEEZE ,IN-FARM>
		       <RTRUE>)
		      (<NOT <IS? ,FARMHOUSE ,SEEN>>
		       <WINDOW-SQUEEZE <GET <GETP ,IN-FARM ,P?NORTH> ,XROOM>>
		       <RTRUE>)>
		<TELL "You leap recklessly out the open " 'PRSO
" into a maelstrom of wind and dust, then plummet to a painful death">
		<JIGS-UP>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE WINDOW-SQUEEZE (DEST)
	 <TELL "You squeeze through " THEO ,PERIOD>
	 <COND (<T? ,VERBOSITY>
		<CRLF>)>
	 <GOTO .DEST>
	 <RTRUE>>
	       
<OBJECT FARM
	(DESC "farm house")
	(FLAGS NODESC PLACE)
	(SYNONYM FARMHOUSE HOUSE HOME BUILDING FARM SHACK)
	(ADJECTIVE RED GRAY GREY LITTLE SMALL FARM ONE\-ROOM)
	(DESCFCN FARMHOUSE-F)
	(ACTION FARMHOUSE-F)>
	
"NODESC = delay for I-HOUSEFALL."

<OBJECT FARMHOUSE
	(LOC LOCAL-GLOBALS)
	(DESC "farm house")
	(FLAGS NODESC PLACE)
	(SYNONYM FARMHOUSE HOUSE HOME BUILDING FARM SHACK)
	(ADJECTIVE RED GRAY GREY LITTLE SMALL FARM ONE\-ROOM)
	(ACTION FARMHOUSE-F)>

"NODESC = not seen correct color."

<ROUTINE FARMHOUSE-F ("OPT" (CONTEXT <>) "AUX" (DIR 0) X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL 
"A little gray " 'FARM " stands nearby. The front door is ">
		       <COND (<IS? ,FARM-DOOR ,OPENED>
			      <TELL "wide open.">
			      <RTRUE>)>
		       <TELL B ,W?CLOSED C ,PER>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <IS? ,FARMHOUSE ,SEEN>
		     <HERE? ,FARM-ROOM>>
		<GONE-NOW ,FARMHOUSE>
		<RFATAL>)
	       (<AND <ADJ-USED? ,W?GRAY ,W?GREY>
		     <IS? ,HERE ,SEEN>>
		<NOTE-COLOR ,FARMHOUSE>
		<RFATAL>)
	       (<HERE? IN-FARM>
		<RETURN <HERE-F>>)
	       (<AND <NOT <HERE? FARM-ROOM IN-FROON>>
		     <SET X <TOUCHING?>>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <SEEING?>>
		<COND (<VERB? EXAMINE LOOK-ON>
		       <TELL ,XTHE>
		       <COND (<PLAIN-ROOM?>
			      <TELL "distant ">)
			     (<IS? ,HERE ,SEEN>
			      <TELL "red ">)
			     (T
			      <TELL "gray ">)>
		       <TELL 'PRSO " isn't much to look at." CR>
		       <RTRUE>)
		      (<AND <VERB? LOOK-UNDER LOOK-BEHIND>
			    <HERE? IN-FROON>>
		       <SETG P-IT-OBJECT ,BOOT>
		       <TELL CA ,BOOT>
		       <PRINT " lies crushed beneath ">
		       <TELL THEO ,PERIOD>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<COND (<HERE? FARM-ROOM IN-FROON>
		       <DO-WALK ,P?IN>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SCARE1
	(DESC "scarecrow")
	(FLAGS TRYTAKE NOALL SURFACE)
	(CAPACITY 10)
	(SYNONYM SCARECROW MAN RAGS CLOTH CORN PATCH HUSKS)
	(ADJECTIVE GRAY GRAY GREY)
	(DESCFCN SCARE1-F)
	(ACTION SCARE1-F)>

<ROUTINE SCARE1-F ("OPT" (CONTEXT <>) "AUX" WRD)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <SET WRD ,W?GRAY>
		       <COND (<IS? ,HERE ,SEEN>
			      <SET WRD <RAG-COLOR-WORD? ,SCARE1>>)>
		       <TELL 
"A weatherbeaten " 'SCARE1 " stands in a patch of dead corn, its " B .WRD
" rags flapping in the wind.">
		       <RTRUE>)>
		<RFALSE>)>
	 <RETURN <HANDLE-SCARES? ,SCARE1>>>

<OBJECT SCARE2
	(DESC "scarecrow")
	(FLAGS TRYTAKE NOALL SURFACE)
	(CAPACITY 10)
	(SYNONYM SCARECROW MAN RAGS CLOTH CORN PATCH HUSKS)
	(ADJECTIVE GRAY GRAY GREY)
	(DESCFCN SCARE2-F)
	(ACTION SCARE2-F)>

<ROUTINE SCARE2-F ("OPT" (CONTEXT <>) "AUX" WRD)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <SET WRD ,W?GRAY>
		       <COND (<IS? ,HERE ,SEEN>
			      <SET WRD <RAG-COLOR-WORD? ,SCARE2>>)>
		       <TELL ,XTHE B .WRD
			     " rags of another " 'SCARE2
			     " flap uselessly in a dead patch of corn.">
		       <RTRUE>)>
		<RFALSE>)>
	 <RETURN <HANDLE-SCARES? ,SCARE2>>>

<OBJECT SCARE3
	(DESC "scarecrow")
	(FLAGS TRYTAKE NOALL SURFACE)
	(CAPACITY 10)
	(SYNONYM SCARECROW MAN RAGS CLOTH CORN PATCH HUSKS)
	(ADJECTIVE GRAY GRAY GREY)
	(DESCFCN SCARE3-F)
	(ACTION SCARE3-F)>

<ROUTINE SCARE3-F ("OPT" (CONTEXT <>) "AUX" WRD)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <SET WRD ,W?GRAY>
		       <COND (<IS? ,HERE ,SEEN>
			      <SET WRD <RAG-COLOR-WORD? ,SCARE3>>)>
		       <TELL 
"A patch of corn is flourishing nearby, presided over by a third " 
'SCARE3 ,SIN B .WRD " rags.">
		       <RTRUE>)>
		<RFALSE>)>
	 <RETURN <HANDLE-SCARES? ,SCARE3>>>
		
<ROUTINE HANDLE-SCARES? (OBJ "AUX" (S3 0) WRD X)
	 <COND (<EQUAL? .OBJ ,SCARE3>
		<INC S3>)>
	 <SET WRD ,W?GRAY>
	 <COND (<AND <IS? ,HERE ,SEEN>
		     <IS? .OBJ ,SEEN>>
		<SET WRD <GET <GETPT .OBJ ,P?ADJECTIVE> 0>>)>
	 <COND (<AND <IS? ,HERE ,SEEN>
		     <ADJ-USED? ,W?GRAY ,W?GREY>>
		<NOTE-COLOR .OBJ>
		<RFATAL>)>
	 <COND (<OR <NOUN-USED? ,W?RAGS ,W?CLOTH>
		    <ADJ-USED? .WRD ,W?GRAY ,W?GREY>>
		<COND (<THIS-PRSI?>
		       <COND (<SET X <PUTTING?>>
			      <WASTE-OF-TIME>
			      <RTRUE>)>
		       <RFALSE>)
		      (<VERB? EXAMINE LOOK-ON WEAR>
		       <COND (<AND <NOT <IS? .OBJ ,SEEN>>
				   <IS? ,HERE ,SEEN>>
			      <SET WRD <RAG-COLOR-WORD? .OBJ>>)>
		       <TELL ,XTHE B .WRD " rags on " THEO 
			     " are tattered and useless." CR>
		       <RTRUE>)
		      (<VERB? SEARCH LOOK-INSIDE LOOK-UNDER>
		       <TELL "You find nothing " <PICK-NEXT ,YAWNS>
			     ,PERIOD>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <TELL 
"Your grasp only shreds the rags worse than before." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<NOUN-USED? ,W?CORN ,W?PATCH ,W?HUSKS>
		<COND (<THIS-PRSI?>
		       <COND (<SET X <PUTTING?>>
			      <PERFORM ,V?DROP ,PRSO>
			      <RTRUE>)>
		       <RFALSE>)
		      (<VERB? TAKE>
		       <COND (<HERE? FARM-ROOM>
			      <TELL 
"Whoever owns the corn might not like that." CR>
			      <RTRUE>)>
		       <TELL "There's none left worth taking." CR>
		       <RTRUE>)
		      (<VERB? EXAMINE LOOK-ON>
		       <TELL "The corn around " THEO ,SIS>
		       <COND (<T? .S3>
			      <TELL "almost ready for harvest." CR>
			      <RTRUE>)>
		       <TELL "dead; only withered husks remain." CR>
		       <RTRUE>)
		      (<VERB? LOOK-INSIDE LOOK-UNDER SEARCH>
		       <ASIDE-FROM ,PRSO>
		       <TELL "nothing " <PICK-NEXT ,YAWNS>
			     " in the corn." CR>
		       <RTRUE>)
		      (<VERB? EAT TASTE>
		       <COND (<T? .S3>
			      <TELL "It's not quite ripe enough." CR>
			      <RTRUE>)>
		       <TELL ,NOTHING "left to eat." CR>
		       <RTRUE>)
		      (<VERB? SMELL>
		       <TELL "The corn smells ">
		       <COND (<T? .S3>
			      <TELL "almost ripe." CR>
			      <RTRUE>)>
		       <TELL "rotten." CR>
		       <RTRUE>)
		      (<VERB? DRINK>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<SET X <ENTERING?>>
		       <COND (<T? .S3>
			      <TELL "Thick husks block your path." CR>
			      <RTRUE>)>
		       <TELL "Dead husks crunch underfoot." CR>
		       <RTRUE>)
		      (<SET X <EXITING?>>
		       <TELL "Which way?" CR>
		       <RTRUE>)
		      (<SET X <TOUCHING?>>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<COND (<AND <NOT <IS? .OBJ ,SEEN>>
			    <IS? ,HERE ,SEEN>>
		       <SET WRD <RAG-COLOR-WORD? .OBJ>>)>
		<TELL 
"Considering the stormy climate hereabouts, it's remarkable that this " 'PRSO
" is still standing. Threadbare " B .WRD
" rags hang from the wooden limbs, flapping">
		<PRINT " in the steady wind.|">
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "Its limp rags flap">
		<PRINT " in the steady wind.|">
		<RTRUE>)
	       (<SET X <MOVING?>>
		<ROOTED .OBJ>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ROOTED (OBJ)
	 <TELL CTHE .OBJ " is firmly rooted in the ground." CR>
	 <RTRUE>>

<GLOBAL SCARES-SEEN:NUMBER 0>
<GLOBAL BADKEY:OBJECT <>> "Key that will scare corbies."

<ROUTINE RAG-COLOR-WORD? (OBJ "AUX" WRD BAD)
         <COND (<IS? .OBJ ,SEEN>
		<RETURN <GET <GETPT .OBJ ,P?ADJECTIVE> 0>>)>
	 <SET WRD <SET-RAG-COLOR .OBJ>>
	 <COND (<EQUAL? .OBJ ,SCARE3>
		<SET SCARES-SEEN 3>)
	       (<NOT <IGRTR? SCARES-SEEN 1>>
		<RETURN .WRD>)>
	 <COND (<AND <IS? ,FARMHOUSE ,NODESC>
		     <IS? ,FARM ,NODESC>>
		<QUEUE ,I-HOUSEFALL>)>
	 <COND (<NOT <IS? ,SCARE1 ,SEEN>>
		<SET-RAG-COLOR ,SCARE1>)>
	 <COND (<NOT <IS? ,SCARE2 ,SEEN>>
		<SET-RAG-COLOR ,SCARE2>)>
	 <COND (<NOT <IS? ,SCARE3 ,SEEN>>
		<SET BAD <SET-RAG-COLOR ,SCARE3>>)
	       (T
		<SET BAD <GET <GETPT ,SCARE3 ,P?ADJECTIVE> 0>>)>
	 <SETG BADKEY ,KEY1>
	 <COND (<EQUAL? .BAD ,W?MAUVE>
		<SETG BADKEY ,KEY2>)
	       (<EQUAL? .BAD ,W?LAVENDER>
		<SETG BADKEY ,KEY3>)>
	 <RETURN .WRD>>
			       
<ROUTINE SET-RAG-COLOR (OBJ "AUX" WRD)
	 <MAKE .OBJ ,SEEN>
	 <SET WRD <PICK-ONE ,SCARE-COLORS>>
	 <PUT <GETPT .OBJ ,P?ADJECTIVE> 0 .WRD>
	 <RETURN .WRD>>       
	      
<OBJECT JBOX
	(DESC "jewel box")
	(FLAGS CONTAINER OPENABLE TRYTAKE NOALL)
	(SYNONYM BOX CASK)
	(ADJECTIVE JEWEL)
	(CAPACITY 3)
	(ACTION JBOX-F)> 

<ROUTINE JBOX-F ("AUX" X)
	 <COND (<SET X <TOUCHING?>>
		<TELL CTHE ,MAYOR " backs way from you. \"Please, ">
		<HONORED-ONE>
		<TELL "! Not so hasty.\"" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>		

<OBJECT KEY1
	(LOC JBOX)
	(DESC "key")
	(SDESC DESCRIBE-KEYS)
	(FLAGS TAKEABLE)
	(SIZE 1)
	(VALUE 0)
	(SYNONYM KEY KEYS)
	(ADJECTIVE PUCE FIRST GRAY GREY)
	(GENERIC GENERIC-KEYS-F)
	(ACTION KEY1-F)>

<OBJECT KEY2
	(LOC JBOX)
	(DESC "key")
	(SDESC DESCRIBE-KEYS)
	(FLAGS TAKEABLE)
	(SIZE 1)
	(VALUE 0)
	(SYNONYM KEY KEYS)
	(ADJECTIVE MAUVE SECOND GRAY GREY)
	(GENERIC GENERIC-KEYS-F)
	(ACTION KEY2-F)>

<OBJECT KEY3
	(LOC JBOX)
	(DESC "key")
	(SDESC DESCRIBE-KEYS)
	(FLAGS TAKEABLE)
	(SIZE 1)
	(VALUE 0)
	(SYNONYM KEY KEYS)
	(ADJECTIVE LAVENDER THIRD LAST GRAY GREY)
	(GENERIC GENERIC-KEYS-F)
	(ACTION KEY3-F)>


<ROUTINE GENERIC-KEYS-F (TBL "OPT" (LEN <GET .TBL 0>))
	 <COND (<HERE? IN-SPLENDOR>
		<RETURN ,HERD>)
	       (<VERB? EXAMINE LOOK-ON>
		<RETURN <GET .TBL 1>>)
	       (T
		<RFALSE>)>>

<ROUTINE KEY1-F ()
	 <RETURN <HANDLE-KEYS? ,KEY1>>>

<ROUTINE KEY2-F ()
	 <RETURN <HANDLE-KEYS? ,KEY2>>>

<ROUTINE KEY3-F ()
	 <RETURN <HANDLE-KEYS? ,KEY3>>>

<ROUTINE HANDLE-KEYS? (OBJ "AUX" WORD K1 K2 K3)
	 <SET WORD <GET <GETPT .OBJ ,P?ADJECTIVE> 0>>
	 <COND (<NOT <SEE-COLOR?>>
		<SET WORD ,W?GRAY>)>
	 <COND (<NOUN-USED? ,W?KEYS>
		<SET K1 <VISIBLE? ,KEY1>>
		<SET K2 <VISIBLE? ,KEY2>>
		<SET K3 <VISIBLE? ,KEY3>>
		<COND (<OR <AND <EQUAL? .OBJ ,KEY1>
				<ZERO? .K2>
				<ZERO? .K3>>
			   <AND <EQUAL? .OBJ ,KEY2>
				<ZERO? .K1>
				<ZERO? .K3>>
			   <AND <EQUAL? .OBJ ,KEY3>
				<ZERO? .K2>
				<ZERO? .K1>>>
		       <ONLY-ONE>
		       <RFATAL>)
		      (<VERB? EXAMINE LOOK-ON>
		       <TELL 
"There are three keys, colored mauve, puce and lavender." CR>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? OPEN UNLOCK>
		       <TELL "Forget it. That phoney " D ,PRSI
			     " couldn't open anything." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<COND (<NOT <VERB? READ>>
		       <TELL
"This is actually a cheap piece of styrofoam, cut into the shape of a giant key, spray painted " B .WORD " and sprinkled with bits of glitter. ">)>
		<TELL "The words ">
		<ITALICIZE "City of Froon">
		<TELL " are scrawled in crayon across the front." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "It smells like " B .WORD " paint." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,TOUCHED>
		<RFALSE>)
	       (<VERB? POINT>
		<AWARD-KEY ,PRSO>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<NOT <ITAKE>>
		       <RTRUE>)>
		<TELL "You ceremoniously lift " THEO>
		<OUT-OF-LOC ,JBOX>
		<TELL ,PERIOD>
		<EXIT-FROON ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE AWARD-KEY (OBJ)
	 <MAKE .OBJ ,TOUCHED>
	 <MOVE .OBJ ,PLAYER>
	 <WINDOW ,SHOWING-ALL>
	 <SETG P-IT-OBJECT .OBJ>
	 <TELL "With a gracious bow, " THE ,MAYOR
" sets " THE .OBJ " onto your outstretched palm." CR>
	 <EXIT-FROON .OBJ>
	 <RTRUE>>

<ROUTINE EXIT-FROON (OBJ "AUX" WRD S1 S2 S3)
	 <COND (<ZERO? ,BADKEY>
	 	<SET WRD <GET <GETPT .OBJ ,P?ADJECTIVE> 0>>
		<SET S1 <GET <GETPT ,SCARE1 ,P?ADJECTIVE> 0>>
		<SET S2 <GET <GETPT ,SCARE2 ,P?ADJECTIVE> 0>>
		<SET S3 <GET <GETPT ,SCARE3 ,P?ADJECTIVE> 0>>
		<COND (<NOT <IS? ,SCARE3 ,SEEN>>
		       <PROG ()
			  <SET S3 <PICK-ONE ,SCARE-COLORS>>
			  <COND (<EQUAL? .S3 .WRD .S2 .S1>
				 <AGAIN>)>
			  <MAKE ,SCARE3 ,SEEN>
			  <PUT <GETPT ,SCARE3 ,P?ADJECTIVE> 0 .S3>>)>		
		<COND (<NOT <IS? ,SCARE2 ,SEEN>>
		       <PROG ()
			  <SET S2 <PICK-ONE ,SCARE-COLORS>>
			  <COND (<EQUAL? .S2 .S3 .S1>
				 <AGAIN>)>
			  <MAKE ,SCARE2 ,SEEN>
			  <PUT <GETPT ,SCARE2 ,P?ADJECTIVE> 0 .S2>>)>
		<COND (<NOT <IS? ,SCARE1 ,SEEN>>
		       <PROG ()
			  <SET S1 <PICK-ONE ,SCARE-COLORS>>
			  <COND (<EQUAL? .S1 .S3 .S2>
				 <AGAIN>)>
			  <MAKE ,SCARE1 ,SEEN>
			  <PUT <GETPT ,SCARE1 ,P?ADJECTIVE> 0 .S1>>)>)>
	 <DEQUEUE ,I-FROON>
	 <QUEUE ,I-CORBIES>
	 <REMOVE ,FARM>
	 <REPLACE-GLOBAL? ,FARM-ROOM ,FARM-DOOR ,NULL>
	 <REPLACE-GLOBAL? ,FARM-ROOM ,FARM-WINDOW ,NULL>
	 <NEW-EXIT? ,FARM-ROOM ,P?SOUTH ,SORRY-EXIT 
		    "The ground is a bit too rough that way.">
	 <NEW-EXIT? ,FARM-ROOM ,P?IN ,NO-EXIT 0 0>
	 <TELL "  \"An excellent choice,\" remarks " THE ,MAYOR
	       ". \"Bye!\"" CR>
	 <REGAIN-SENSES>
	 <GOTO ,FARM-ROOM>
       ; <REFRESH-MAP <>>
	 <RTRUE>>

<OBJECT FROON
	(LOC LOCAL-GLOBALS)
	(DESC "Froon")
	(FLAGS NODESC NOARTICLE PROPER PLACE)
	(SYNONYM FROON CITY)
	(ACTION FROON-F)>

<ROUTINE FROON-F ()
	 <COND (<HERE? IN-FROON>
		<RETURN <HERE-F>>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? WHAT WHO WHERE FIND WALK-TO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>
	       	       
<OBJECT GURDY
	(LOC GRINDER)
	(DESC "hurdy-gurdy")
	(FLAGS TAKEABLE CONTAINER OPENABLE SURFACE)
	(SYNONYM GURDY HURDY\-GURDY ORGAN BOX
	 	 CRANK HANDLE TURNER LID TOP
		 DIAL KNOB POINTER PAINTINGS PICTURES)
	(ADJECTIVE HURDY SENSE SIX)
	(SIZE 7)
	(CAPACITY 7)
	(VALUE 30)
	(GENERIC GENERIC-DIAL-F)
	(ACTION GURDY-F)>

<OBJECT INGURDY
	(FLAGS NODESC)>

<ROUTINE GURDY-F ("AUX" X)
	 <COND (<NOUN-USED? ,W?LID ,W?TOP>
		<COND (<THIS-PRSI?>)
		      (<VERB? EXAMINE>
		       <TELL "The lid of " THEO ,SIS>
		       <COND (<IS? ,PRSO ,OPENED>
			      <TELL "open." CR>
			      <RTRUE>)>
		       <TELL "closed." CR>
		       <RTRUE>)
		      (<VERB? LOOK-UNDER LOOK-BEHIND>
		       <LOOK-IN-GURDY>
		       <RTRUE>)
		      (<VERB? OPEN OPEN-WITH CLOSE>)
		      (<SET X <MOVING?>>
		       <FIRMLY-ATTACHED "lid" ,PRSO T>
		       <RTRUE>)>)
	       (<OR <NOUN-USED? ,W?DIAL ,W?KNOB ,W?POINTER>
		    <NOUN-USED? ,W?PAINTINGS ,W?PICTURES>>
		<RETURN <GDIAL-F>>)
	       (<NOUN-USED? ,W?CRANK ,W?HANDLE ,W?TURNER>
		<RETURN <CRANK-F>>)>
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? PUT EMPTY-INTO>
			    <NOT <IS? ,PRSI ,OPENED>>>
		       <ITS-CLOSED ,PRSI>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <COND (<IS? ,PRSI ,OPENED>
			      <YOUD-HAVE-TO "close" ,PRSI>
			      <RTRUE>)>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<LOOK-IN-GURDY>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<COND (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-CLOSED>
		       <RTRUE>)>
		<TELL "Your hand tingles." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<COND (<AND <VERB? OPEN-WITH>
			    <NOT <PRSI? HANDS>>>
		       <WASTE-OF-TIME>
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)>
		<MOVE-ALL ,INGURDY ,GURDY>
		<MAKE ,PRSO ,OPENED>
		<MENTION-PUFF>
		<TELL " as you open it." CR>
		<RTRUE>)
	       (<VERB? CLOSE>
		<COND (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-ALREADY "closed">
		       <RTRUE>)>
		<UNMAKE ,PRSO ,OPENED>
		<MOVE-ALL ,GURDY ,INGURDY ,NODESC>
		<WINDOW ,SHOWING-ALL>
		<TELL CTHEO " creaks shut." CR>
		<RTRUE>)
	       (<OR <VERB? TURN CRANK USE>
		    <AND <VERB? TOUCH>
			 <EQUAL? ,P-PRSA-WORD ,W?PLAY>>>
		<SETG LAST-CRANK-DIR <>>
		<TURN-GURDY>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL
"This squat contraption is about the size of a ">
		<FROBOZZ "Breadbox">
		<TELL 
" breadbox, and made of brightly painted wood. There's a big dial up front, and a crank jutting from the side, just below the ">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL B ,W?OPEN>)
		      (T
		       <TELL B ,W?CLOSED>)>
		<TELL " lid." CR>
		<RTRUE>)
	       (<VERB? TURN-TO POINT-AT PUSH-TO>
		<COND (<PRSI? PRSO>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<PRSI? LEFT RIGHT>
		       <OOPS-THE ,CRANK>
		       <COND (<PRSI? RIGHT>
			      <TURN-GURDY-RIGHT>
			      <RTRUE>)>
		       <TURN-GURDY-LEFT>
		       <RTRUE>)
		      (<SET X <INTBL? ,PRSI ,PICT-LIST 6>>
		       <OOPS-THE ,GDIAL>
		       <TURN-DIAL>
		       <RTRUE>)>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (T
		<RFALSE>)>> 
	       	
<ROUTINE MENTION-PUFF ()
	 <WINDOW ,SHOWING-ALL>
	 <TELL ,XA <GET ,GURDY-EFFECTS ,DPOINTER> " seeps out">
	 <RTRUE>>

<ROUTINE OOPS-THE (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 <TELL "[" THE .OBJ ,BRACKET>
	 <RTRUE>>

<ROUTINE LOOK-IN-GURDY ()
	 <COND (<NOT <IS? ,GURDY ,OPENED>>
		<YOUD-HAVE-TO "open" ,GURDY>
		<RTRUE>)>
	 <TELL "Looking inside " THEO " makes your " 
	       <GET ,GURDY-PEEKS ,DPOINTER>>
	 <COND (<SEE-ANYTHING-IN? ,GURDY>
		<TELL ". But you can glimpse ">
		<CONTENTS ,GURDY>
		<TELL " within">
		<SETG P-IT-OBJECT ,GURDY>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<OBJECT CRANK
	(LOC GURDY)
	(DESC "crank")
	(FLAGS NODESC TRYTAKE NOALL PART)
	(SYNONYM CRANK HANDLE TURNER)
	(ADJECTIVE TED)
	(GENERIC GENERIC-DIAL-F)
	(ACTION CRANK-F)>

<ROUTINE CRANK-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <IMPOSSIBLE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "It juts from the side of " THE ,GURDY ,PERIOD>
		<RTRUE>)
	       (<VERB? TURN-TO POINT-AT PUSH-TO>
		<COND (<PRSO? PRSI>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<PRSI? RIGHT>
		       <TURN-GURDY-RIGHT>
		       <RTRUE>)
		      (<PRSI? LEFT>
		       <TURN-GURDY-LEFT>
		       <RTRUE>)>
		<TELL CTHEO> 
		<COND (<PRSI? INTDIR>
		       <TELL " turns only to the left or right." CR>
		       <RTRUE>)>	       
		<PRINT " won't turn that way">
		<COND (<SET X <INTBL? ,PRSI ,PICT-LIST 6>>
		       <SETG P-IT-OBJECT ,GDIAL>
		       <TELL ". But " THE ,GDIAL " will">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? TURN CRANK SPIN PUSH MOVE USE>
		<SETG LAST-CRANK-DIR <>>
		<TURN-GURDY>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<FIRMLY-ATTACHED "crank" ,GURDY T>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<OBJECT G-EYE
	(LOC GURDY)
	(DESC "picture of an eye")
	(FLAGS TRYTAKE NOALL NODESC PART)
	(SYNONYM EYE PICTURE PAINTING)
	(ADJECTIVE EYE FIRST)
	(DNUM 0)
	(GENERIC GENERIC-PICTURE-F)
	(ACTION G-EYE-F)>

<ROUTINE G-EYE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "The eye on " THE ,GURDY
		      " stares back at you." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT G-EAR
	(LOC GURDY)
	(DESC "picture of an ear")
	(FLAGS TRYTAKE NOALL NODESC PART)
	(SYNONYM EAR PICTURE PAINTING)
	(ADJECTIVE EAR SECOND)
	(DNUM 1)
	(GENERIC GENERIC-PICTURE-F)
	(ACTION G-EAR-F)>

<ROUTINE G-EAR-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<TELL CTHEO " listens intently." CR>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "The ear on " THE ,GURDY
		      " perks up." CR>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "It listens back." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT G-NOSE
	(LOC GURDY)
	(DESC "picture of a nose")
	(FLAGS TRYTAKE NOALL NODESC PART)
	(SYNONYM NOSE PICTURE PAINTING)
	(ADJECTIVE NOSE THIRD)
	(DNUM 2)
        (GENERIC GENERIC-PICTURE-F)
	(ACTION G-NOSE-F)>

<ROUTINE G-NOSE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON SMELL LISTEN>
		<TELL "The nose on " THE ,GURDY
		      " sniffs you curiously." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT G-MOUTH
	(LOC GURDY)
	(DESC "picture of a mouth")
	(FLAGS TRYTAKE NOALL NODESC PART)
	(SYNONYM MOUTH PICTURE PAINTING)
	(ADJECTIVE MOUTH FOURTH)
	(DNUM 3)
	(GENERIC GENERIC-PICTURE-F)
	(ACTION G-MOUTH-F)>

<ROUTINE G-MOUTH-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<OR <VERB? EXAMINE LOOK-ON>
		    <SET X <TALKING?>>>
		<TELL "The mouth on " THE ,GURDY
		      " sticks out its tongue at you." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT G-HAND
	(LOC GURDY)
	(DESC "picture of a hand")
	(FLAGS TRYTAKE NOALL NODESC PART)
	(SYNONYM HAND PICTURE PAINTING)
	(ADJECTIVE HAND FIFTH)
	(DNUM 4)
	(GENERIC GENERIC-PICTURE-F)
	(ACTION G-HAND-F)>

<ROUTINE G-HAND-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "The hand on " THE ,GURDY
		      " waves at you." CR>
		<RTRUE>)
	       (<VERB? WAVE-AT HELLO BOW>
		<TELL CTHEO " waves back." CR>
		<RTRUE>)
	       (<AND <VERB? SHAKE>
	             <EQUAL? ,P-PRSA-WORD ,W?SHAKE>>
	        <TELL CTHEO " isn't ">
	        <ITALICIZE "that">
	        <TELL" friendly." CR>
	        <RTRUE>)
	       (<SET X <MOVING?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT G-CLOCK
	(LOC GURDY)
	(DESC "picture of a clock")
	(FLAGS TRYTAKE NOALL NODESC PART)
	(SYNONYM CLOCK PICTURE PAINTING)
	(ADJECTIVE CLOCK SIXTH LAST)
	(DNUM 5)
	(GENERIC GENERIC-PICTURE-F)
	(ACTION G-CLOCK-F)>

<ROUTINE G-CLOCK-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON >
		<TELL "The clock on " THE ,GURDY
		      " is quite old-fashioned." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GENERIC-PICTURE-F (TBL "OPT" (LEN <GET .TBL 0>) "AUX" OBJ X)
	 <SET TBL <REST .TBL 2>>
	 <COND (<SET X <INTBL? ,P-IT-OBJECT .TBL .LEN>>
		<RETURN ,P-IT-OBJECT>)
	       (<VERB? TURN-TO POINT-AT PUSH-TO>
		<RFALSE>)>
	 <SET OBJ <GET ,PICT-LIST ,DPOINTER>>
	 <COND (<SET X <INTBL? .OBJ .TBL .LEN>>
		<RETURN .OBJ>)>
	 <RFALSE>>			    

<OBJECT GDIAL
	(LOC GURDY)
	(DESC "dial")
	(FLAGS NODESC TRYTAKE NOALL PART)
	(SYNONYM DIAL KNOB POINTER PAINTINGS PICTURES)
	(ADJECTIVE SIX)
	(DNUM G-EYE)
	(GENERIC GENERIC-DIAL-F)
	(ACTION GDIAL-F)>
	
<ROUTINE GENERIC-DIAL-F (TBL "OPT" LEN "AUX" X Y)
	 <SET X <GET .TBL 1>>
	 <SET Y <GET .TBL 2>>
	 <COND (<EQUAL? .X ,GURDY>
		<RETURN .Y>)
	       (<EQUAL? .Y ,GURDY>
		<RETURN .X>)
	       (T
		<RFALSE>)>>

<GLOBAL DPOINTER:NUMBER 0>

<ROUTINE GDIAL-F ("AUX" X)
	 <COND (<OR <NOUN-USED? ,W?PAINTINGS ,W?PICTURES>
		    <ADJ-USED? ,W?SIX>>
		<COND (<THIS-PRSI?>
		       <COND (<VERB? TURN-TO POINT-AT PUSH-TO>
			      <HOW-TO-CLICK>
			      <RTRUE>)>)
		      (<VERB? EXAMINE LOOK-ON READ>
		       <TELL ,YOU-SEE "a circle of ">
		       <PRINT 
"six little pictures, cunningly painted: an eye, an ear, a nose, a mouth, a hand and a clock">
		       <TELL ", with a dial in the center." CR>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <IMPOSSIBLE>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <IMPOSSIBLE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO ,SON THE ,GURDY " is encircled by ">
		<PRINT 
"six little pictures, cunningly painted: an eye, an ear, a nose, a mouth, a hand and a clock">
		<TELL ". At the moment, the dial points to " 
		      THE <GET ,PICT-LIST ,DPOINTER> ,PERIOD>
		<RTRUE>)
	       (<VERB? TURN-TO POINT-AT PUSH-TO>
		<COND (<PRSI? LEFT>
		       <COND (<DLESS? DPOINTER 0>
			      <SETG DPOINTER 5>)>
		       <CLICK-DIAL "left">
		       <RTRUE>)
		      (<PRSI? RIGHT>
		       <COND (<IGRTR? DPOINTER 5>
			      <SETG DPOINTER 0>)>
		       <CLICK-DIAL "right">
		       <RTRUE>)
		      (<PRSI? INTDIR>
		       <TELL CTHEO " only turns left or right." CR>
		       <RTRUE>)>
		<TURN-DIAL>
		<RTRUE>)
	       (<VERB? SPIN ADJUST WIND TOUCH>
		<PROG ()
		   <SET X <RANDOM 6>>
		   <DEC X>
		   <COND (<EQUAL? .X ,DPOINTER>
			  <AGAIN>)>>
		<SETG DPOINTER .X>
		<WINDOW ,SHOWING-ALL>
		<PRSO-FIDDLE>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<FIRMLY-ATTACHED ,PRSO ,GURDY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CLICK-DIAL ("OPT" (STR <>))
	 <WINDOW ,SHOWING-ALL>
	 <ITALICIZE "Click">
	 <TELL ". You turn " THE ,GDIAL>
	 <COND (<T? .STR>
		<TELL " once to the " .STR ". It now ">)
	       (T
		<TELL " until it ">)>
	 <TELL "points to " THE <GET ,PICT-LIST ,DPOINTER> ,PERIOD>
	 <COND (<IS? ,GURDY ,OPENED>
		<PRINT ,TAB>
		<MENTION-PUFF>
		<PRINT ,PERIOD>)>		
	 <RTRUE>>	 

<ROUTINE TURN-DIAL ("AUX" X)
	 <COND (<PRSI? PRSO>
	        <IMPOSSIBLE>
	        <RTRUE>)
	       (<SET X <INTBL? ,PRSI ,PICT-LIST 6>>
		<SET X <GETP ,PRSI ,P?DNUM>>
		<COND (<EQUAL? .X ,DPOINTER>
		       <TELL CTHE ,GDIAL " already points to "
			     THEI ,PERIOD>
		       <RTRUE>)>
		<SETG DPOINTER .X>
		<CLICK-DIAL>
		<RTRUE>)
	       (<PRSI? INTNUM>
		<COND (<L? ,P-NUMBER 1>
		       <HOW-TO-CLICK>
		       <RTRUE>)
		      (<G? ,P-NUMBER 6>
		       <TELL "There are only six " B ,W?PAINTINGS
		             ,SON THE ,GURDY ,PERIOD>
		       <RTRUE>)>
		<SETG DPOINTER <- ,P-NUMBER 1>>
		<CLICK-DIAL>
		<RTRUE>)>
	 <TELL CTHE ,GDIAL ,SON THE ,GURDY>
	 <PRINT " won't turn that way">
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE HOW-TO-CLICK ()
	 <PCLEAR>
	 <NYMPH-APPEARS>
	 <TELL 
"You must specify one of the six paintings; for example, TURN THE DIAL TO THE PAINTING OF THE EAR or POINT ARROW AT MOUTH">
	 <PRINT ". Bye!\"|  She disappears with a wink.|">
	 <RTRUE>>

<OBJECT FHILLS
	(LOC LOCAL-GLOBALS)
	(DESC "foothills")
	(FLAGS NODESC PLACE PLURAL)
	(SYNONYM FOOTHILLS HILLS HILL)
	(ADJECTIVE STEEP RUGGED)
	(ACTION FHILLS-F)>

<ROUTINE FHILLS-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " are discouragingly steep and rugged." CR>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	           
<OBJECT WHARF
	(LOC LOCAL-GLOBALS)
	(DESC "wharf")
	(FLAGS NODESC PLACE SURFACE)
	(SYNONYM WHARF PIER PIERS)
	(ACTION WHARF-F)>

<ROUTINE WHARF-F ("AUX" (ON 0) X)
	 <COND (<HERE? ON-WHARF>
		<INC ON>)>
	 <COND (<SET X <CLIMBING-ON?>>
		<COND (<T? .ON>
		       <ALREADY-ON>
		       <RTRUE>)>
		<DO-WALK ,P?EAST>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<COND (<T? .ON>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)>
		<NOT-ON>
		<RTRUE>)
	       (<T? .ON>
		<COND (<VERB? SMELL>
		       <PRINT 
"Dank, fishy smells permeate this old wharf to its very bones.">
		       <CRLF>
		       <RTRUE>)>
		<RETURN <HERE-F>>)
	       (<SET X <TOUCHING?>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<SET X <SEEING?>>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FBEDS
	(LOC IN-FROON)
	(DESC "flower beds")
	(FLAGS NODESC)
	(SYNONYM BEDS BED FLOWERS FLOWER)
	(ADJECTIVE FLOWER)
	(ACTION FBEDS-F)>

<ROUTINE FBEDS-F ("AUX" STR X)
	 <COND (<ZERO? ,FSCRIPT>
		<SET STR "backs away from">
		<COND (<SET X <SEEING?>>
		       <SET STR "blinks at">)>
		<START-FROON .STR>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<TELL 
"The flowers deftly shift themselves away from your touch." CR>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "They are exceptionally beautiful." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "So sweet and delicate!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE START-FROON (STR)
	 <WINDOW ,SHOWING-ROOM>
	 <QUEUE ,I-FROON>
	 <MOVE ,LADY ,IN-FROON>
	 <SEE-CHARACTER ,LADY>
	 <PUTP ,IN-FROON ,P?HEAR ,LADY>
	 <TELL "One of the flowers " .STR " you!" CR ,TAB
"You leap back in alarm as a tiny figure emerges from the flower beds. It's a woman, garbed in bright clothes, and standing less than two feet high." CR>
	 <RTRUE>>		       

<OBJECT COVE
	(LOC ON-WHARF)
	(DESC "water")
	(FLAGS NODESC CONTAINER OPENED PLACE)
	(CAPACITY 10000)
	(SYNONYM WATER COVE SEA OCEAN WAVES SURFACE)
	(ACTION COVE-F)>

<ROUTINE COVE-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <VANISH>
		       <ITALICIZE "Splash">
		       <TELL "! " CTHEO>
		       <COND (<IS? ,PRSO ,BUOYANT>
			      <TELL 
" hits the water and floats out of sight." CR>
			      <RTRUE>)>
		       <TELL " disappears beneath the water." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<SEE-ANYTHING-IN?>
		       <TELL ,YOU-SEE>
		       <CONTENTS>
		       <SETG P-IT-OBJECT ,PRSO>
		       <TELL " floating ">)
		      (T
		       <TELL "Sunlight sparkles ">)>
		<TELL "on the surface of " THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND>
		<PRINT "Little can be seen ">
		<TELL "in the sparkling water." CR>
		<RTRUE>)
	       (<OR <VERB? LEAP>
		    <SET X <ENTERING?>>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL ,CYOU>
		<PRINT "hear the slurp of oily seawater against the piers">
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? EAT>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? DRINK TASTE DRINK-FROM KISS>
		<TELL "Ugh! Salty." CR>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT POOL
	(DESC "pool of radiance")
	(FLAGS NODESC VEHICLE CONTAINER OPENED)
	(SYNONYM POOL RADIANCE LIGHT SUNLIGHT YOUTH)
	(ADJECTIVE YOUTH ETERNAL)
	(CAPACITY 10000)
	(CONTFCN POOL-F)
	(ACTION POOL-F)>

<ROUTINE ENTER-POOL ()
	 <SETG P-PRSA-WORD ,W?ENTER>
	 <PERFORM ,V?ENTER ,POOL>
	 <RFALSE>>

<ROUTINE EXIT-POOL ()
	 <SETG P-PRSA-WORD ,W?EXIT>
	 <PERFORM ,V?EXIT ,POOL>
	 <RFALSE>>

<ROUTINE INTO-POOL ("OPT" (OBJ ,PRSO))
	 <WINDOW ,SHOWING-ALL>
	 <MOVE .OBJ ,POOL>
	 <COND (<OR <EQUAL? .OBJ ,TRUFFLE>
		    <IN? ,TRUFFLE .OBJ>>
		<MUNG-TRUFFLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MUNG-TRUFFLE ()
	 <COND (<IS? ,TRUFFLE ,MUNGED>
		<RFALSE>)>
	 <MAKE ,TRUFFLE ,MUNGED>
	 <SETG TRUFFLE-TIMER 0>
	 <DEQUEUE ,I-TRUFFLE>
	 <COND (<VISIBLE? ,TRUFFLE>
		<TELL ,TAB CTHE ,TRUFFLE
"'s color darkens to a rich, mouthwatering brown." CR>)>
	 <RTRUE>>

<ROUTINE POOL-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<SET OBJ ,PRSO>
		<COND (<THIS-PRSI?>
		       <SET OBJ ,PRSI>)>
		<COND (<EQUAL? .CONTEXT ,M-BEG>
		       <RETURN <CANT-REACH-WHILE-IN? .OBJ ,POOL>>)
		      (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<IN? ,PLAYER ,POOL>
			      <RFALSE>)
			     (<ZERO? .OBJ>
			      <RFALSE>)
			     (<SET X <SEEING?>>
			      <TELL ,CANT "see " THE .OBJ " very well">)
			     (<SET X <TOUCHING?>>
			      <CANT-REACH .OBJ>)
			     (T
			      <RFALSE>)>
		       <TELL " from the edge of the pool." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-UNDER>
		       <TELL "You lower ">
		       <O-INTO-I>
		       <INTO-POOL>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <TELL "With a silent splash of light, " THEO 
			     " tumbles into the pool." CR>
		       <INTO-POOL>
		       <RTRUE>)
		      (<VERB? FILL-FROM>
		       <COND (<PRSO? GOBLET VIAL>
			      <TELL CTHEO 
" seems unable to contain the golden radiance." CR>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<OR <SET X <ENTERING?>>
		    <VERB? SWIM CROSS CLIMB-DOWN>>
		<COND (<IN? ,PLAYER ,PRSO>
		       <RFALSE>)
		      (<DROP-ONION-FIRST?>
		       <RTRUE>)>
		<NEW-EXIT? ,HERE ,P?IN ,SORRY-EXIT
			   "You're in as far as you can go.">
		<NEW-EXIT? ,HERE ,P?OUT %<+ ,FCONNECT 1 ,MARKBIT>
			   ,EXIT-POOL>
		<MOVE ,PLAYER ,PRSO>
		<SETG P-WALK-DIR <>>
		<SETG OLD-HERE <>>
		<TELL ,CYOU>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <MAKE ,PRSO ,TOUCHED>
		       <TELL 
"test the shifting radiance with a timid foot, then ">)>
		<TELL "slowly wade into the middle of the pool">
		<RELOOK>
		<SET X <LOC ,TRUFFLE>>
		<COND (<ZERO? .X>)
		      (<OR <EQUAL? .X ,PLAYER>
			   <IN? .X ,PLAYER>>
		       <MUNG-TRUFFLE>)>
		<RTRUE>)
	       (<OR <SET X <EXITING?>>
		    <VERB? CLIMB-UP>>
		<COND (<NOT <IN? ,PLAYER ,PRSO>>
		       <NOT-IN>
		       <RTRUE>)>
		<SETUP-POND-EXITS>
		<SETG P-WALK-DIR <>>
		<SETG OLD-HERE <>>
		<MOVE ,PLAYER <LOC ,PRSO>>
		<TELL "You slowly wade">
		<OUT-OF-LOC ,PRSO>
		<RELOOK>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH LOOK-UNDER>
		<COND (<SEE-ANYTHING-IN?>
		       <TELL ,YOU-SEE>
		       <CONTENTS>
		       <SETG P-IT-OBJECT ,PRSO>
		       <TELL " enveloped">)
		      (T
		       <TELL "Nothing can be seen">)>
		<TELL " within." CR>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The circular " 'POOL " shimmers and ripples like the surface of a pond." CR>
		<RTRUE>)
	       (<VERB? COUNT>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? TASTE DRINK DRINK-FROM>
		<PRINT "Your mouth tingles with refreshment.|">
		<RTRUE>)
	       (<VERB? TOUCH KISS>
		<TELL "You feel a refreshing tingle." CR>
		<RTRUE>)
	       (<VERB? EAT>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
				       		       
<OBJECT VIAL
	(LOC UNDERPEW)
	(DESC "vial")
	(FLAGS NOALL TAKEABLE CONTAINER TRANSPARENT)
	(SYNONYM VIAL WATER)
	(ADJECTIVE HOLY)
	(SIZE 2)
	(CAPACITY 4)
	(VALUE 4)
	(ACTION VIAL-F)>

<ROUTINE VIAL-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO FILL-FROM POUR-FROM TAKE>
		       <VIAL-SEALED>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<TELL CTHEO " is filled with water." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<COND (<NOT <VERB? READ>>
		       <TELL
"This delicate vial was blown from fine glass of extraordinary clarity. ">)>
		<TELL 
"Looking closely, you see the legend \"">
		<FROBOZZ "Vial">
		<TELL "\" inscribed on the bottom." CR>
		<RTRUE>)
	       (<VERB? HIT MUNG KICK>
		<PRSO-SHATTER>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? SHAKE>
		<TELL "Water slooshes around inside." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE POUR EMPTY REACH-IN
		       EMPTY-INTO TASTE DRINK DRINK-FROM>
		<VIAL-SEALED>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VIAL-SEALED ()
	 <TELL CTHE ,VIAL " appears to be permanently sealed." CR>
	 <RTRUE>>

<ROUTINE PRSO-SHATTER ()
	 <VANISH>
	 <ITALICIZE "Crash">
	 <TELL "! " CTHEO " shatters into useless fragments">
	 <RTRUE>>

<OBJECT SADDLE
	(LOC STALL)
	(DESC "saddle")
	(FLAGS TAKEABLE SURFACE VEHICLE)
	(SYNONYM SADDLE)
	(SIZE 10)
	(CAPACITY 20)
	(VALUE 4)
	(ACTION SADDLE-F)>

<ROUTINE SADDLE-F ("OPT" (CONTEXT <>) "AUX" OBJ L X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-BEG>
		       <COND (<NOT <IN? ,SADDLE ,DACT>>
			      <RFALSE>)>
		       <SET OBJ ,PRSO>
		       <COND (<THIS-PRSI?>
			      <SET OBJ ,PRSI>)>
		       <COND (<EQUAL? .OBJ <> ,SADDLE ,DACT>
			      <RFALSE>)>
		       <RETURN <CANT-REACH-WHILE-IN? .OBJ ,DACT>>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT-ON EMPTY-INTO THROW PUT>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)
		      (<VERB? PUT-UNDER PUT-BEHIND>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <CLIMBING-ON?>>
		<SET L <LOC ,PRSO>>
		<COND (<ZERO? .L>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<OR <EQUAL? .L ,PLAYER>
			   <IN? .L ,PLAYER>>
		       <YOUD-HAVE-TO "put down">
		       <RTRUE>)
		      (<VERB? LIE-DOWN>
		       <TELL CTHEO " isn't big enough." CR>
		       <RTRUE>)
		      (<IN? ,PLAYER ,PRSO>
		       <COND (<VERB? STAND-ON>
			      <MOVE ,PLAYER <LOC ,PRSO>>
			      <TELL "You rise shakily to your feet">
			      <LOSE-BALANCE>
			      <CRLF>
			      <V-LOOK>
			      <RTRUE>)>
		       <TELL ,ALREADY "sitting on " THEO ,PERIOD>
		       <RTRUE>)
		      (<DROP-ONION-FIRST?>
		       <RTRUE>)
		      (<EQUAL? .L <LOC ,PLAYER>>
		       <COND (<VERB? STAND-ON>
			      <TELL "You climb shakily onto " THEO>
			      <LOSE-BALANCE>
			      <RTRUE>)>
		       <MOVE ,PLAYER ,PRSO>
		       <TELL "You lower " 'ME ,SINTO THEO>
		       <RELOOK>
		       <RTRUE>)
		      (<EQUAL? .L ,DACT>
		       <MOUNT-DACT>
		       <RTRUE>)>
		<PRINT "You'd have to get ">
		<TELL THEO>
		<OUT-OF-LOC .L>
		<TELL ,SFIRST>
		<RTRUE>)
	       (<OR <VERB? EXIT CLIMB-DOWN LEAVE LEAP DIVE ESCAPE>
		    <AND <VERB? EMPTY>
			 <IN? ,PLAYER ,PRSO>>>
		<COND (<NOT <IN? ,PLAYER ,PRSO>>
		       <TELL "You're not sitting on " THEO ,PERIOD>
		       <RTRUE>)
		      (<IN? ,SADDLE ,DACT>
		       <DISMOUNT-DACT>
		       <RTRUE>)>
		<MOVE ,PLAYER <LOC ,PRSO>>
		<TELL "You clamber off " THEO>
		<RELOOK>
		<RTRUE>)
	       (<VERB? STAND-ON LIE-DOWN>
		<TELL "Saddles are for sitting." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<TELL "A small label on it says, \"">
		<FROBOZZ "Saddle">
		<TELL ,PERQ>
		<RTRUE>)
	       (T
		<RFALSE>)>>

		       
<ROUTINE LOSE-BALANCE ()
	 <TELL ", lose your balance and slide off." CR>
	 <RTRUE>>
			     
<OBJECT DACT
	(DESC "pterodactyl")
	(FLAGS VEHICLE LIVING PERSON SURFACE TRYTAKE NOALL MUNGED NAMEABLE)
	(SYNONYM PTERODACTYL ZZZP DINOSAUR CREATURE ANIMAL BIRD
	 	 WING WINGS WOUND)
	(ADJECTIVE WOUNDED HURT AWAKE)
	(LIFE I-DACT)
	(CAPACITY 20)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(DESCFCN DACT-F)
	(CONTFCN DACT-F)
	(ACTION DACT-F)>

<ROUTINE SHY-DACT? ("AUX" X)
	 <COND (<AND <ZERO? ,DACT-SLEEP>
		     <IS? ,DACT ,MUNGED>	     
		     <OR <SET X <TOUCHING?>>
			 <SET X <CLIMBING-ON?>>>>
		<TELL "The wounded " 'DACT <PICK-NEXT ,SHYNESS>
		      ,PERIOD>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE DACT-F ("OPT" (CONTEXT <>) "AUX" (HURT 0) (W 0) X)
	 <SETG P-IT-OBJECT ,DACT>
	 <COND (<NOUN-USED? ,W?BIRD>
		<TELL "Pterodactyls are not birds." CR>
		<RFATAL>)
	       (<IS? ,DACT ,MUNGED>
		<INC HURT>)
	       (<OR <NOUN-USED? ,W?WOUND>
		    <ADJ-USED? ,W?WOUNDED ,W?HURT>>
		<TELL CTHE ,DACT "'s wound is gone now." CR>
		<RFATAL>)>
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA ,DACT>
		<COND (<T? ,DACT-SLEEP>
		       <TELL " lies nearby, snoring fitfully">)
		      (<T? .HURT>
		       <TELL " is hobbling around in slow, painful circles">)
		      (T
		       <TELL " is" <PICK-NEXT ,DACT-WAITS>>)>
	        <COND (<AND <IN? ,ARROW ,DACT>
			    <IS? ,ARROW ,NODESC>>
		       <TELL ". One of its wings is pierced by "
			     A ,ARROW>)>
		<COND (<IN? ,SADDLE ,DACT>
		       <COND (<T? .HURT>
			      <TELL "; and a ">)
			     (T
			      <TELL ". A ">)>
		       <TELL 'SADDLE " rests upon its back">)>
		<COND (<IN? ,WHISTLE ,DACT>
		       <TELL ". " CA ,WHISTLE
			     " hangs on a chain around its skinny neck">)>
		<TELL C ,PER>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-CONT>
		<COND (<SHY-DACT?>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<MAKE ,DACT ,SEEN>
		<COND (<OR <AND <VERB? WALK FLY BANK TURN TURN-TO
				       SPOINT-AT>
				<PRSO? INTDIR>>
			   <AND <VERB? POINT-AT>
				<PRSI? INTDIR>>>
		       <SETG P-WALK-DIR ,P-DIRECTION>
		       <NEXT-SKY>
		       <RFATAL>)
		      (<AND <VERB? FLY FLY-UP CLIMB-UP>
			    <EQUAL? ,PRSO <> ,ROOMS ,SKY>>
		       <DO-WALK ,P?UP>
		       <RFATAL>)
		      (<OR <VERB? LAND>
			   <AND <VERB? CLIMB-DOWN>
				<PRSO? ROOMS>
				<EQUAL? ,P-PRSA-WORD ,W?DESCEND>>
			   <AND <VERB? LAND-ON>
				<PRSO? GROUND FLOOR>>>
		       <DO-WALK ,P?DOWN>
		       <RFATAL>)
		      (<AND <VERB? HELLO>
			    <PRSO? ROOMS DACT>>
		       <HELLO-DACT>
		       <RFATAL>)>
		<PUZZLED-DACT>
		<RFATAL>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<NOUN-USED? ,W?WING ,W?WINGS ,W?WOUND>
		<COND (<SHY-DACT?>
		       <RTRUE>)
		      (<THIS-PRSI?>
		       <COND (<OR <VERB? TOUCH-TO>
				  <AND <VERB? PUT-ON PUT>
				       <PRSO? SPENSE>>>
			      <TOUCH-DACT-WITH ,PRSO> 
			      <RTRUE>)
			     (<VERB? PUT-UNDER PUT-BEHIND>
			      <WASTE-OF-TIME>
			      <RTRUE>)
			     (<SET X <PUTTING?>>
			      <PRSO-SLIDES-OFF-PRSI>
			      <RTRUE>)>
		       <RFALSE>)
		      (<VERB? STOUCH-TO>
		       <TOUCH-DACT-WITH ,PRSI>
		       <RTRUE>)
		      (<VERB? EXAMINE LOOK-ON>
		       <COND (<IN? ,ARROW ,DACT>
			      <SETG P-IT-OBJECT ,ARROW>
			      <TELL CA ,ARROW " has pierced one of " THEO
				    "'s wings." CR>
			      <RTRUE>)>
		       <TELL CTHEO "'s wing">
		       <COND (<IS? ,PRSO ,MUNGED>
			      <TELL " has a nasty wound." CR>
			      <RTRUE>)>
		       <TELL "s ">
		       <COND (<HERE? IN-SKY>
			      <TELL "beat slowly up and down." CR>
			      <RTRUE>)>
		       <TELL "appear healthy and strong." CR>
		       <RTRUE>)
		      (<VERB? TELL>
		       <TELL ,CANT "talk to a wing." CR>
		       <RFATAL>)
		      (<VERB? REPAIR DRESS>
		       <COND (<IS? ,PRSO ,MUNGED>
			      <HOW?>
			      <RTRUE>)>
		       <TELL CTHEO "'s wing is fine now." CR>
		       <RTRUE>)
		      (<SET X <CLIMBING-ON?>>
		       <NO-GOOD-SURFACE ,PRSO>
		       <RTRUE>)
		      (<SET X <CLIMBING-OFF?>>
		       <NOT-ON>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON THROW-OVER PUT>
		       <MAKE ,DACT ,SEEN>
		       <WINDOW ,SHOWING-ALL>
		       <TELL ,CYOU B ,P-PRSA-WORD C ,SP THEO 
			     " onto " THEI "'s back">
		       <COND (<AND <ZERO? ,DACT-SLEEP>
				   <IS? ,PRSI ,MUNGED>>
			      <MOVE ,PRSO <LOC ,PLAYER>>
			      <TELL 
", but the wounded creature shakes it loose and throws it to your feet." CR>
			      <RTRUE>)
			     (<NOT <PRSO? SADDLE>>
			      <TELL ", but ">
			      <COND (<IS? ,PRSO ,PLURAL>
				     <TELL "they slide">)
				    (T
				     <TELL "it slides">)>
			      <TELL " off and ">
			      <FALLS>
			      <RTRUE>)>
		       <MOVE ,PRSO ,PRSI>
		       <TELL ", where it settles comfortably." CR>
		       <RTRUE>)
		      (<SHY-DACT?>
		       <RTRUE>)
		      (<AND <VERB? TOUCH-TO>
			    <PRSO? SPENSE>>
		       <TELL "[" THEI "'s wing" ,BRACKET>
		       <TOUCH-DACT-WITH ,PRSO>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? TELL>
		<COND (<ZERO? ,DACT-SLEEP>
		       <RFALSE>)>
		<TELL "The snoring " 'DACT " doesn't respond." CR>
		<RFATAL>)
	       (<VERB? HELLO WAVE-AT>
		<HELLO-DACT>
		<RTRUE>)
	       (<VERB? ASK-ABOUT ASK-FOR TELL-ABOUT>
		<PUZZLED-DACT>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " appears to be ">
		<COND (<IS? ,PRSO ,SLEEPING>
		       <TELL B ,W?SLEEPING>)
		      (<IS? ,PRSO ,MUNGED>
		       <TELL B ,W?WOUNDED>)
		      (T
		       <TELL "watching you">)>
		<COND (<IN? ,WHISTLE ,DACT>
		       <REMOVE ,WHISTLE>
		       <INC W>
		       <TELL ". There's " A ,WHISTLE 
			     " hung around his neck">)>
		<COND (<SEE-ANYTHING-IN?>
		       <TELL ". On his back you see ">
		       <CONTENTS>)>
		<TELL ,PERIOD>
		<COND (<T? .W>
		       <MOVE ,WHISTLE ,DACT>)>
		<SETG P-IT-OBJECT ,DACT>
		<RTRUE>)
	       (<VERB? RESCUE>
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL "Medical aid might help." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <CLIMBING-OFF?>>
		<DISMOUNT-DACT>
		<RTRUE>)
	       (<VERB? ALARM>
		<COND (<ZERO? ,DACT-SLEEP>
		       <TELL CTHEO " isn't asleep" ,AT-MOMENT>
		       <RTRUE>)>
		<WAKE-DACT>
	        <RTRUE>)
	       (<SHY-DACT?>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<MOUNT-DACT>
		<RTRUE>)       
	       (<AND <VERB? STOUCH-TO>
		     <PRSI? SPENSE>>
		<TELL "[" THEO "'s wing" ,BRACKET>
		<TOUCH-DACT-WITH ,PRSI>
		<RTRUE>)
	       (<VERB? TOUCH>
		<TELL CTHEO " caws appreciatively." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MOUNT-DACT ()
	 <MAKE ,DACT ,SEEN>
	 <COND (<AND <IN? ,PLAYER ,SADDLE>
		     <IN? ,SADDLE ,DACT>>
		<TELL ,ALREADY "riding " THE ,DACT ,PERIOD>
		<RTRUE>)
	       (<DROP-ONION-FIRST?>
		<RTRUE>)
	       (<NOT <IN? ,SADDLE ,DACT>>
		<COND (<ZERO? ,DACT-SLEEP>
		       <TELL CTHE ,DACT " does its best to oblige">)
		      (T
		       <TELL "The sleeping " 'DACT
			     " does nothing to hinder you">)>
		<TELL ", but you keep sliding off its skinny back." CR>
		<RTRUE>)>
	 <MAKE ,DACT ,NODESC>
	 <MOVE ,PLAYER ,SADDLE>
	 <TELL "You climb up onto " THE ,DACT
	       "'s back, and settle into " THE ,SADDLE>
	 <RELOOK>
	 <RTRUE>>

<ROUTINE DISMOUNT-DACT ()
	 <COND (<OR <NOT <IN? ,PLAYER ,SADDLE>>
		    <NOT <IN? ,SADDLE ,DACT>>>
		<NOT-ON ,DACT>
		<RTRUE>)
	       (<IN? ,DACT ,IN-SKY>
		<TELL "You slide confidently">
		<OUT-OF-LOC ,SADDLE>
		<TELL
", and plummet hundreds of bloits to a senseless death">
		<JIGS-UP>
		<RTRUE>)>
	 <UNMAKE ,DACT ,NODESC>
	 <MOVE ,PLAYER <LOC ,DACT>>
	 <TELL "You clamber">
	 <OUT-OF-LOC ,SADDLE>
	 <TELL ", and slip off " THE ,DACT "'s back">
	 <RELOOK>
	 <RTRUE>>

<ROUTINE TOUCH-DACT-WITH (OBJ)
	 <COND (<NOT <IN? .OBJ ,PLAYER>>
		<YOUD-HAVE-TO "be holding" .OBJ>
		<RTRUE>)
	       (<NOT <EQUAL? .OBJ ,SPENSE>>
		<TELL CTHE ,DACT "'s ">
		<COND (<IS? ,DACT ,MUNGED>
		       <TELL "wounded ">)>
		<TELL "wing is unaffected." CR>
		<RTRUE>)>
	 <TELL
"You gently press " THE .OBJ " against the wounded wing" ,PTAB CTHE ,DACT
"'s sleep seems to deepen, and the tension in its limbs relaxes">
	 <COND (<IN? ,ARROW ,DACT>
		<TELL 
" a bit. But its flesh remains torn by the piercing arrow." CR>
		<RTRUE>)>
	 <VANISH .OBJ>
	 <UNMAKE ,DACT ,MUNGED>
	 <TELL ". You watch in astonishment as the weed begins to flow and congeal, blending itself into the torn flesh until no trace of the wound remains." CR>
	 <RTRUE>>

<ROUTINE HELLO-DACT ()
	 <COND (<NOT <DACT-SLEEPING?>>
		<TELL CTHE ,DACT " eyes you silently." CR>)>
	 <RTRUE>>

<ROUTINE PUZZLED-DACT ()
	 <COND (<NOT <DACT-SLEEPING?>>
		<TELL CTHE ,DACT>
		<PRINT " gives you a puzzled frown">
		<TELL ,PERIOD>)>		
	 <RTRUE>>

<ROUTINE DACT-SLEEPING? ()
	 <MAKE ,DACT ,SEEN>
	 <COND (<ZERO? ,DACT-SLEEP>
		<RFALSE>)>
	 <TELL CTHE ,DACT " responds with a fitful snore." CR>
	 <RTRUE>>

<OBJECT ARROW
	(LOC DACT)
	(SDESC DESCRIBE-ARROW)
	(DESC "arrow")
	(FLAGS NODESC TAKEABLE VOWEL NAMEABLE)
	(SYNONYM ARROW ARROW)
	(SIZE 3)
	(EFFECT 10)
	(EMAX 10)
	(VALUE 2)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(ACTION BAD-ARROW-F)>
		

<ROUTINE ARROW-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"A crude design. Looks like " B ,W?SOMETHING " you'd find in a museum." CR>
		<RTRUE>)
	       (<VERB? FIRE-AT>
		<TELL ,DONT "have a bow." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BAD-ARROW-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? TOUCH-TO>
		       <TOUCH-BAD-ARROW ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is piercing one of " THE ,DACT
		      "'s wings." CR>
		<RTRUE>)
	       (<VERB? TAKE PULL>
		<COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		       <TWIST-ARROW>
		       <RTRUE>)
		      (<NOT <ITAKE>>
		       <RTRUE>)>
		<PUTP ,PRSO ,P?ACTION ,ARROW-F>
		<TOUCH-BAD-ARROW>
		<TELL 
"  Gritting your teeth, you grasp the shaft firmly, close your eyes and give it a quick, determined yank" ,PTAB>
		<ITALICIZE "Rip">
		<TELL ". " CTHEO 
" pulls free, and dark blood trickles from the wound." CR>
		<RTRUE>)
	       (<VERB? TOUCH SQUEEZE>
		<TOUCH-BAD-ARROW>
		<RTRUE>)
	       (<VERB? HIT PUSH KICK>
		<YOUR-OBJ>
		<TELL " strikes " THEO " edgewise, driving it">
		<DRIVE-DEEPER>
		<RTRUE>)
	       (<VERB? TURN LOOSEN MOVE LOWER RAISE SPIN>
		<COND (<EQUAL? ,PRSI <> ,HANDS>
		       <TOUCH-BAD-ARROW>
		       <RTRUE>)>
		<TWIST-ARROW>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TWIST-ARROW ()
	 <TELL "You fumble uncertainly with " THEI 
	       ", driving " THEO>
	 <DRIVE-DEEPER>
	 <RTRUE>>

<ROUTINE DRIVE-DEEPER ()
	 <TELL " deeper into " THE ,DACT "'s wing" ,PTAB
	       "The luckless creature moans softly in its sleep." CR>
	 <RTRUE>>
		
<ROUTINE TOUCH-BAD-ARROW ("OPT" (OBJ <>))
	 <TELL "You gently touch the end of " THE ,ARROW>
	 <COND (<EQUAL? .OBJ <> ,HANDS ,ME>
		<TELL ", probing with your fingers">)
	       (T
		<TELL ,WITH THE .OBJ>)>
	 <TELL ". It barely gives at all." CR>
	 <RTRUE>>
		       
<OBJECT WEEDS
	(LOC ON-PIKE)
	(DESC "patch of weeds")
	(FLAGS NODESC SURFACE CONTAINER OPENED TRYTAKE NOALL)
	(CAPACITY 100)
	(SYNONYM WEEDS PATCH PLANTS BUNCH WEED PLANT SPENSEWEED)
	(ADJECTIVE WEED SPENSE)
	(GENERIC GENERIC-WEED-F)
	(ACTION WEEDS-F)>

<OBJECT WEEDS2
	(DESC "weeds")
	(FLAGS NODESC SURFACE CONTAINER OPENED TRYTAKE NOALL PLURAL)
	(CAPACITY 100)
	(SYNONYM WEEDS PATCH PLANTS BUNCH WEED PLANT SPENSEWEED)
	(ADJECTIVE WEED SPENSE)
	(GENERIC GENERIC-WEED-F)
	(ACTION WEEDS-F)>

<ROUTINE WEEDS-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <WINDOW ,SHOWING-ALL>
		       <MOVE ,PRSO ,PRSI>
		       <TELL CTHEO " fall">
		       <COND (<NOT <IS? ,PRSO ,PLURAL>>
			      <TELL "s">)>
		       <TELL " into the weeds." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE SEARCH LOOK-UNDER>
		<TELL "Aside from the " B ,W?BILLBOARD ,LYOU-SEE>
		<CONTENTS>
		<SETG P-IT-OBJECT ,PRSO>
		<TELL " among the weeds." CR>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "The weeds remind you of your garden back home." CR>
	        <RTRUE>)
	       (<VERB? TAKE PICK UPROOT LOOSEN PULL>
		<SET X ,SPENSE>
		<COND (<PRSO? WEEDS2>
		       <SET X ,SPENSE2>)>
		<COND (<PICK-WEED? .X>
		       <RTRUE>)>
		<TELL "None of the other weeds catches your eye." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GENERIC-WEED-F (TBL "OPT" (LEN <GET .TBL 0>))
	 <RETURN ,SPENSE>>

<OBJECT SPENSE
	(LOC WEEDS)
	(DESC "limp weed")
	(FLAGS NODESC TAKEABLE)
	(SIZE 1)
	(VALUE 2)
	(SYNONYM WEED SPENSEWEED PLANT)
	(ADJECTIVE SPENSE LIMP)
	(GENERIC GENERIC-WEED-F)
	(ACTION SPENSE-F)>

<OBJECT SPENSE2
	(LOC WEEDS2)
	(DESC "dry weed")
	(FLAGS NODESC TAKEABLE)
	(SIZE 1)
	(VALUE 2)
	(SYNONYM WEED SPENSEWEED PLANT)
	(ADJECTIVE SPENSE DRY)
	(GENERIC GENERIC-WEED-F)
	(ACTION SPENSE-F)>

<ROUTINE SPENSE-F ("AUX" X MAX)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? TAKE PICK UPROOT PULL LOOSEN>
		     <PICK-WEED?>>
		<RTRUE>)
	       (<VERB? TASTE>
		<TELL "A little taste finds " THEO>
		<PRINT " sweet and wholesome.|">
		<RTRUE>)
	       (<VERB? EAT>
		<VANISH>
		<TELL "You cram " THEO ,SINTO 'MOUTH
" and swallow it whole, enjoying its sweet, wholesome taste." CR>
		<SET X <GET ,STATS ,ENDURANCE>>
		<SET MAX <GET ,MAXSTATS ,ENDURANCE>>
		<COND (<L? .X .MAX>
		       <UPDATE-STAT <- .MAX .X>>)>
		<SET X <GET ,STATS ,STRENGTH>>
		<SET MAX <GET ,MAXSTATS ,STRENGTH>>
		<COND (<L? .X .MAX>
		       <UPDATE-STAT <- .MAX .X> ,STRENGTH>)>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL CTHEO "'s scent is">
		<PRINT " sweet and wholesome.|">
		<RTRUE>)
	       (<VERB? EXAMINE WHAT>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (<VERB? PLANT>
		<DO-PLANT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-PLANT ()
	 <COND (<IS? ,PRSO ,TOUCHED>
		<TELL "You left your trowel at home." CR>
		<RTRUE>)>
	 <TELL ,ALREADY "planted." CR>
	 <RTRUE>>

<ROUTINE PICK-WEED? ("OPT" (OBJ ,PRSO))
	 <COND (<IS? .OBJ ,TOUCHED>
		<RFALSE>)
	       (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		<PRSI-FUMBLE ,WEEDS2>
		<RTRUE>)>
	 <WINDOW ,SHOWING-INV>
	 <SETG P-IT-OBJECT .OBJ>
	 <MOVE .OBJ ,PLAYER>
	 <UNMAKE .OBJ ,NODESC>
	 <MAKE .OBJ ,TOUCHED>
	 <TELL "With a modest tug, " A .OBJ
	       " pops out of " THE ,GROUND ,PERIOD>
	 <RTRUE>>

<ROUTINE PRSI-FUMBLE (OBJ)
	 <TELL "You poke around with " THEI
	       ", noting little effect on " THE .OBJ ,PERIOD>
	 <RTRUE>>

<OBJECT BRINE
	(LOC AT-BRINE)
	(DESC "patch of brine")
	(FLAGS SURFACE CONTAINER OPENED TRYTAKE NOALL)
	(CAPACITY 100)
	(SYNONYM BRINE PATCH SALT)
	(ADJECTIVE SALT WHITE)
	(GENERIC GENERIC-SALT-F)
	(DESCFCN BRINE-F)
	(ACTION BRINE-F)>

<ROUTINE GENERIC-SALT-F (TBL "OPT" LEN)
	 <RETURN ,CUBE>>

<ROUTINE BRINE-F ("OPT" (CONTEXT <>) "AUX" (S 0) X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL "A white " 'BRINE " is drying in the sun">
		       <COND (<SEE-ANYTHING-IN? ,BRINE>
			      <PRINT ". On it you see ">
			      <CONTENTS ,BRINE>
			      <SETG P-IT-OBJECT ,BRINE>)>
		       <TELL C ,PER>
		       <RTRUE>)>
		<RFALSE>)>
	 <COND (<AND <IN? ,CUBE ,BRINE>
		     <IS? ,CUBE ,NODESC>>
		<INC S>)>
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <COND (<PRSO? CUBE>
			      <MAKE ,PRSO ,NODESC>)>
		       <MOVE ,PRSO ,PRSI>
		       <WINDOW ,SHOWING-ALL>
		       <TELL "You deposit " THEO ,SON THEI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"A shallow pool of seawater must have evaporated here">
		<COND (<SEE-ANYTHING-IN?>
		       <TELL ". Upon " THEO " you see ">
		       <CONTENTS>
		       <SETG P-IT-OBJECT ,PRSO>)>
		<PRINT ,PERIOD>
	        <RTRUE>)
	       (<VERB? TAKE PICK UPROOT LOOSEN PULL>
		<COND (<T? .S>
		       <SNARF-CUBE>
		       <RTRUE>)>
		<TELL "You've taken the only loose bit already." CR>
		<RTRUE>)
	       (<VERB? TOUCH KICK HIT>
		<TELL CTHEO " is hard as a rock">
		<COND (<T? .S>
		       <TELL ". One bit seems a bit loose, though">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? TASTE>
		<TELL "Ugh! Convincingly salty." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<PRINT "The ocean smell is strong">
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<TELL "Sorry. All evaporated." CR>
		<RTRUE>)
	       (<VERB? EAT>
		<YOUD-HAVE-TO "loosen a bit of">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SNARF-CUBE ()
	 <COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		<PRSI-FUMBLE ,BRINE>
		<RTRUE>)>
	 <WINDOW ,SHOWING-INV>
	 <SETG P-IT-OBJECT ,CUBE>
	 <MOVE ,CUBE ,PLAYER>
	 <UNMAKE ,CUBE ,NODESC>
	 <MAKE ,CUBE ,TOUCHED>
	 <TELL "You scrape a loose " 'CUBE>
	 <OUT-OF-LOC ,BRINE>
	 <TELL ,PERIOD>
	 <RTRUE>>

<OBJECT CUBE
	(LOC BRINE)
	(DESC "bit of salt")
	(FLAGS NODESC TAKEABLE)
	(SYNONYM SALT BRINE BIT PIECE)
	(SIZE 1)
	(VALUE 0)
	(GENERIC GENERIC-SALT-F)
	(ACTION CUBE-F)>

<ROUTINE CUBE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? HIT MUNG CUT>
			    <PRSO? SLUG>>
		       <TOUCH-SLUG-WITH ,CUBE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "It's no bigger than a die." CR>
		<RTRUE>)
	       (<VERB? EAT>
		<VANISH>
		<TELL "You pop " THEO
" into your mouth, and manage to swallow it without gagging." CR>
		<UPDATE-STAT -5>
		<RTRUE>)
	       (<VERB? TASTE>
		<TELL "A quick taste confirms " THEO
		      "'s identity." CR>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? SMELL>
		<PRINT "The ocean smell is strong">
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ROSES
	(LOC ROSE-ROOM)
	(DESC "rosebush")
	(FLAGS SURFACE CONTAINER OPENED TRYTAKE)
	(CAPACITY 100)
	(SYNONYM BUSH BUSHES ROSEBUSH ROSES ROSE FLOWER FLOWERS)
	(ADJECTIVE ROSE FLOWER)
	(GENERIC GENERIC-ROSE-F)
	(DESCFCN ROSES-F)
	(ACTION ROSES-F)>

<ROUTINE ROSES-F ("OPT" (CONTEXT <>) "AUX" (R 0) X)
	 <COND (<AND <IN? ,ROSE ,ROSES>
		     <IS? ,ROSE ,NODESC>>
		<INC R>)>
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A lone " 'ROSES
" has somehow managed to survive the stormy climate.">
		<RTRUE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE SEARCH LOOK-UNDER>
		<TELL ,YOU-SEE>
		<CONTENTS>
		<SETG P-IT-OBJECT ,PRSO>
		<TELL " among " THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "Aside from a few thorns, ">
		<COND (<T? .R>
		       <TELL 
"a solitary rose is the bush's only adornment." CR>
		       <RTRUE>)>
		<TELL THEO " is barren." CR> 
		<RTRUE>)
	       (<VERB? TAKE PICK UPROOT LOOSEN PULL RAISE>
		<COND (<T? .R>
		       <PICK-ROSE>
		       <RTRUE>)>
		<TELL CTHEO " is barren of flowers." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GENERIC-ROSE-F (TBL "OPT" (LEN <GET .TBL 0>))
	 <RETURN ,ROSE>>

<OBJECT ROSE
	(LOC ROSES)
	(DESC "rose")
	(FLAGS NODESC TAKEABLE)
	(SIZE 1)
	(VALUE 20)
	(SYNONYM ROSE FLOWER STEM PETALS)
	(ADJECTIVE COMPASS ROSE\'S)
	(GENERIC GENERIC-ROSE-F)
	(ACTION ROSE-F)>

<ROUTINE ROSE-F ("AUX" (NODROOP 0) WRD)
	 <COND (<OR <IS? ,HERE ,INDOORS>
		    <HERE? IN-GARDEN APLANE IN-FROON IN-SPLENDOR>>
		<INC NODROOP>)>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO "'s delicate stem ">
		<COND (<T? .NODROOP>
		       <TELL "is standing straight and tall." CR>
		       <RTRUE>)
		      (<PLAIN-ROOM?>
		       <TELL 
"blows wildly back and forth in the stormy winds." CR>
		       <RTRUE>)>
		<MAKE ,BREEZE ,SEEN>
		<TELL "is tilted to the " B <GET ,DIR-NAMES ,WINDIR> ,PERIOD>
	        <COND (<NOT <IS? ,PRSO ,IDENTIFIED>>
		       <MAKE ,PRSO ,IDENTIFIED>
		       <TELL ,TAB>
		       <REFER-TO-PACKAGE>)>
		<RTRUE>)
	       (<AND <VERB? TAKE PICK UPROOT PULL LOOSEN RAISE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<PICK-ROSE>
		<RTRUE>)
	       (<VERB? TURN-TO POINT-AT PUSH-TO>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)
		      (<PRSI? LEFT>
		       <COND (<DLESS? WINDIR ,I-NORTH>
			      <SETG WINDIR ,I-NW>)>
		       <SET WRD ,W?LEFT>)
		      (<PRSI? RIGHT>
		       <COND (<IGRTR? WINDIR ,I-NW>
			      <SETG WINDIR ,I-NORTH>)>
		       <SET WRD ,W?RIGHT>)
		      (T
		       <COND (<PRSI? INTDIR>
			      <COND (<AND <G? ,P-DIRECTION <- ,P?NW 1>>
					  <L? ,P-DIRECTION <+ ,P?NORTH 1>>>
				     <SETG WINDIR 
					   <- 0 <- ,P-DIRECTION ,P?NORTH>>>
				     <SET WRD <GET ,DIR-NAMES ,WINDIR>>)
				    (<EQUAL? ,P-DIRECTION ,P?UP ,P?DOWN>
				     <TELL CTHEO>
				     <COND (<PLAIN-ROOM?>
					    <TELL " blows back and forth." CR>
					    <RTRUE>)
					   (<T? .NODROOP>
					    <TELL " springs up again." CR>
					    <RTRUE>)>
				     <TELL " droops back to the "
					   B <GET ,DIR-NAMES ,WINDIR>
					   ,PERIOD>
				     <RTRUE>)>)
			     (T
			      <TELL ,CANT B ,P-PRSA-WORD C ,SP THEO
				    " that way." CR>
			      <RTRUE>)>)>
		<TELL ,CYOU B ,P-PRSA-WORD C ,SP THEO
		      "'s stem to the " B .WRD>
		<COND (<T? .NODROOP>
		       <TELL ", but it springs upright again." CR>
		       <RTRUE>)
		      (<PLAIN-ROOM?>
		       <TELL ", but the wind blows it wildly around." CR>
		       <RTRUE>)>
		<TELL ,PERIOD>
		<NEW-WINDIR?>
		<RTRUE>)
	       (<VERB? SPIN ADJUST WIND TOUCH>
		<PRSO-FIDDLE>
		<NEW-WINDIR? <NEXT-WINDIR?>>
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<TELL "You hurt your mouth on a thorn. Ouch!" CR>
		<UPDATE-STAT -2>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL CTHEO "'s scent is unusually delicate." CR>
		<RTRUE>)
	       (<VERB? WHAT>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>
		
<ROUTINE PRSO-FIDDLE ()
	 <TELL "You fiddle aimlessly with " THEO " for a while." CR>
	 <RTRUE>>

<ROUTINE PICK-ROSE ()
	 <COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		<PRSI-FUMBLE ,BUSH>
		<RTRUE>)>
	 <WINDOW ,SHOWING-INV>
	 <SETG P-IT-OBJECT ,ROSE>
	 <MOVE ,ROSE ,PLAYER>
	 <UNMAKE ,ROSE ,NODESC>
	 <MAKE ,ROSE ,TOUCHED>
	 <TELL "You pluck the flower off " THE ,ROSES ,PERIOD>
	 <RTRUE>>

<OBJECT GUILD-HALL
	(LOC LOCAL-GLOBALS)
	(DESC "Guild Hall")
	(FLAGS NODESC PLACE)
	(SYNONYM HALL BUILDING GUILD GATE LOBBY)
	(ADJECTIVE GUILD ENCHANTER FRONT)
	(ACTION GUILD-HALL-F)>

<ROUTINE GUILD-HALL-F ("AUX" X)
	 <COND (<VERB? WALK-TO ENTER THROUGH STAND-UNDER>
		<SET X ,P?NORTH>
		<COND (<HERE? IN-ACCARDI>
		       <SET X ,P?EAST>)>
		<DO-WALK .X>
		<RTRUE>)
	       (<HERE? IN-ACCARDI>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)>
	 <COND (<NOUN-USED? ,W?GATE>
		<COND (<VERB? EXAMINE>
		       <MENTION-REZROV>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <IMPOSSIBLE>
		       <RTRUE>)>)>
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO
" is as vast and majestic as you always imagined it. ">
		<MENTION-REZROV>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH LOOK-BEHIND>
		<TELL 
"The lobby beyond the open gate looks deserted." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<ITS-ALREADY "open">
		<RTRUE>)
	       (<VERB? CLOSE>
		<MENTION-REZROV>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<ROUTINE MENTION-REZROV ()
         <TELL "A permanent REZROV spell holds the front gate wide open." CR>
	 <RTRUE>>

<OBJECT THRIFF
	(LOC LOCAL-GLOBALS)
	(DESC "Thriff")
	(FLAGS NODESC PLACE NOARTICLE PROPER)
	(SYNONYM THRIFF)
	(ACTION THRIFF-F)>

<ROUTINE THRIFF-F ()
	 <COND (<VERB? RESCUE>
		<HOW?>
		<RTRUE>)
	       (<HERE? IN-THRIFF>
		<RETURN <HERE-F>>)
	       (T
		<RFALSE>)>>
	 
<OBJECT NYMPH
	(LOC LOCAL-GLOBALS)
	(DESC "warning nymph")
	(FLAGS NODESC LIVING)
	(SYNONYM NYMPH NYMPHS)
	(ADJECTIVE WARNING)
	(ACTION NYMPH-F)>

<ROUTINE NYMPH-F ()
	 <PCLEAR>
	 <COND (<NOT <IS? ,GUILD-HALL ,TOUCHED>>
		<NONE-TO-BE-SEEN>
		<RFATAL>)>	 
	 <GONE-NOW ,NYMPH>
	 <RFATAL>>

<OBJECT ONION
	(LOC IN-KITCHEN)
	(DESC "giant onion")
	(FLAGS TRYTAKE SURFACE)
	(SIZE 25)
	(CAPACITY 5)
	(SYNONYM ONION)
	(ADJECTIVE GIANT GIGANTIC HUGE HUMONGOUS LARGE)
	(ACTION ONION-F)>

"TOUCHED = tried to take, SEEN = paid for."

<ROUTINE DROP-ONION-FIRST? ()
	 <COND (<NOT <IN? ,ONION ,PLAYER>>
		<RFALSE>)>
	 <TELL "You'll have to put down that " 'ONION ,SFIRST>
	 <RTRUE>>

<ROUTINE ONION-F ("AUX" X LEN)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"This onion is about twice the diameter of a ">
		<FROBOZZ "Beachball">
		<TELL " beachball">
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL ", and sports a large gash in its surface">)>
		<PRINT ,PERIOD>
		<COND (<NOT <IS? ,ONION ,TOUCHED>>
		       <TELL ,TAB>
		       <COOK-MENTIONS-ONION>)>
		<RTRUE>)
	       (<VERB? TAKE>
		<PICK-UP-ONION>
		<RTRUE>)
	       (<VERB? RAISE>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?RAISE ,W?LIFT ,W?HOIST>)
		      (<EQUAL? ,P-PRSA-WORD ,W?TAKE ,W?HOLD ,W?ELEVATE>)
		      (<EQUAL? ,P-PRSA-WORD ,W?PULL>)
		      (<GETP ,HERE ,P?UP>
		       <ROLL-ONION ,P?UP>
		       <RTRUE>)>
		<PICK-UP-ONION>
		<RTRUE>)
	       (<VERB? PUSH-TO>
		<COND (<PRSI? PRSO>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<PRSI? INTDIR>
		       <ROLL-ONION ,P-DIRECTION>
		       <RTRUE>)
		      (<WATER?>
		       <VANISH>
		       <ITALICIZE "Sploosh">
		       <TELL "! " CTHEO " disappears in " THEI ,PERIOD>
		       <RTRUE>)
		      (<IS? ,PRSI ,VEHICLE>)
		      (<OR <EQUAL? ,PRSI <> ,LEFT ,RIGHT>
			   <IS? ,PRSI ,PLACE>>
		       <HOW-TO-MOVE-ONION>
		       <RTRUE>)>
		<TELL "You'd have a hard time " B ,P-PRSA-WORD
		      "ing that " 'ONION>
		<ON-IN ,PRSI>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<VERB? LOWER>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?LOWER ,W?HOLD>)
		      (<GETP ,HERE ,P?DOWN>
		       <ROLL-ONION ,P?DOWN>
		       <RTRUE>)>
		<ONION-ROLLS>
		<RTRUE>)
	       (<VERB? PUSH-UP PUSH-DOWN>
		<COND (<PRSO? PRSI>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<NOT <GLOBAL-IN? ,HERE ,PRSI>>)
		      (<AND <VERB? PUSH-UP>
			    <GETP ,HERE ,P?UP>>
		       <ROLL-ONION ,P?UP>
		       <RTRUE>)
		      (<AND <VERB? PUSH-DOWN>
			    <GETP ,HERE ,P?DOWN>>
		       <ROLL-ONION ,P?DOWN>
		       <RTRUE>)>
		<YOUD-HAVE-TO "pick up">
		<RTRUE>)
	       (<VERB? BUY>
		<COND (<IS? ,PRSO ,SEEN>
		       <TELL "You already did that." CR>
		       <RTRUE>)
		      (<NOT <VISIBLE? ,PRSO>>
		       <RFALSE>)>
		<PERFORM ,V?GIVE ,PRSI ,COOK>
		<RTRUE>)
	       (<VERB? PUSH MOVE ADJUST SPIN KICK>
		<ONION-ROLLS>
		<RTRUE>)
	       (<VERB? SIT STAND-ON LIE-DOWN CLIMB-UP CLIMB-ON
		       CLIMB-OVER>
		<TELL "You slide off the smooth, oniony surface." CR>
		<RTRUE>)
	       (<VERB? CUT HIT MUNG PEEL KICK>
		<COND (<EQUAL? ,PRSI <> ,HANDS ,FEET>
		       <TELL "Ouch! It's tough as leather." CR>
		       <RTRUE>)
		      (<PRSI? SWORD AXE DAGGER ARROW>
		       <SET LEN <GET ,NOPEELS 0>>
		       <REPEAT ()
			  <SET X <GET ,NOPEELS .LEN>>
			  <COND (<VISIBLE? .X>
				 <TELL "\"Not in front of ">
				 <ITALICIZE "me">
				 <TELL " you don't,\" growls " THE .X ,PERIOD>
				 <RTRUE>)>
			  <COND (<DLESS? LEN 1>
				 <RETURN>)>>
		       <COND (<IS? ,PRSO ,MUNGED>
			      <COND (<ZERO? ,ONION-TIMER>
				     <QUEUE ,I-ONION>)>
			      <TELL CTHEI 
				   " slightly widens the slash in ">)
			     (T
			      <MAKE ,PRSO ,MUNGED>
			      <QUEUE ,I-ONION>		       
			      <TELL 
"Your two-week stint as a short-order cook in Borphee stands you in good stead as you slash ">)>
		       <SETG ONION-TIMER 4>
		       <TELL THEO "'s surface." CR>
		       <RTRUE>)>
		<TELL "Thump! ">
		<YOUR-OBJ ,PRSI>
		<TELL " has little effect on " THEO ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>
			 
<ROUTINE ROLL-ONION (DIR "AUX" X OHERE)
	 <COND (<SPARK? <> ,ONION>
		<TELL ,TAB>)>
	 <COND (<OR <AND <HERE? NE-WALL>
			 <EQUAL? .DIR ,P?SE ,P?IN>
			 <IS? ,NE-WALL ,OPENED>>
		    <AND <HERE? SE-WALL>
			 <EQUAL? .DIR ,P?SW ,P?IN>
			 <IS? ,SE-WALL ,OPENED>>>
		<TELL CTHE ,ONION " won't fit through the "
		      B ,W?OPENING ,PERIOD>
		<RTRUE>)
	       (<HERE? IN-KITCHEN>
		<COND (<EQUAL? .DIR ,P?DOWN ,P?IN>
		       <TELL ,XTHE>
		       <COND (<IS? ,CELLAR-DOOR ,MUNGED>
			      <TELL "hole in the wall">)
			     (T
			      <TELL 'CELLAR-DOOR>)>
		       <TELL " isn't wide enough to fit " THE ,ONION>
		       <COND (<NOT <IS? ,CELLAR-DOOR ,OPENED>>
			      <TELL ". Besides, it's closed">)>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (<AND <EQUAL? .DIR ,P?EAST ,P?OUT>
			    <NOT <IS? ,ONION ,SEEN>>>
		       <TELL "As you roll " THE ,ONION
			     " towards the exit, " THE ,COOK 
			     " jumps into your path. \"">
		       <COND (<NOT <IS? ,ONION ,TOUCHED>>
			      <TELL "This ain't no free soup kitchen">
			      <PRINT 
",\" he barks, shoving the ungainly vegetable back into place.|">
			      <TELL ,TAB>
			      <COOK-MENTIONS-ONION>
			      <RTRUE>)
			     (<NOT <IS? ,BOTTLE ,IDENTIFIED>>
			      <TELL "Leave it alone">)
			     (T
			      <MAKE ,COOK ,SEEN>
			      <TELL "No bottle, no onion">)>
		       <PRINT 
",\" he barks, shoving the ungainly vegetable back into place.|">
		       <RTRUE>)>)>
	 <SET OHERE ,HERE>
	 <DO-WALK .DIR>	 	
	 <COND (<NOT <EQUAL? ,HERE .OHERE ,DEATH>>
		<MOVE ,ONION ,HERE>
		<SETG P-IT-OBJECT ,ONION>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB CTHE ,ONION " rolls to a stop." CR>)>
	 <RFALSE>>

<ROUTINE ONION-ROLLS ()
	 <TELL CTHE ,ONION " rolls freely across the ">
	 <COND (<IS? ,HERE ,INDOORS>
		<TELL 'FLOOR>)
	       (T
		<TELL 'GROUND>)>
	 <TELL ". You could probably push it in any " 'INTDIR
	       " you want." CR>
	 <RTRUE>>

<ROUTINE PICK-UP-ONION ("AUX" (H <>) OBJ)
	 <COND (<SET OBJ <FIRST? ,PLAYER>>
		<REPEAT ()
		   <COND (<IS? .OBJ ,NODESC>)
			 (<IS? .OBJ ,WORN>)
			 (<IS? .OBJ ,TAKEABLE>
			  <TELL
"You'd have to drop everything to get your arms around that " 'PRSO ,PERIOD>
			  <RTRUE>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <PRINT "Sweat breaks out on your forehead as you ">
	 <COND (<L? <GET ,STATS ,STRENGTH> 25>
		<SET H T>
		<TELL "try to ">)>
	 <TELL "heft " THEO ". But it's ">
	 <COND (<ZERO? .H>
		<TELL "too awkward for you">)
	       (T
		<TELL "beyond your strength">)>
	 <TELL " to carry it" ,PTAB>
	 <ITALICIZE "Thud">
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE HOW-TO-MOVE-ONION ()
	 <NYMPH-APPEARS>
	 <TELL "To move " THE ,ONION ", just indicate a " 'INTDIR
"; for example, ROLL THE GIANT ONION TO THE NORTH or PUSH ONION WEST">
	 <PRINT ". Bye!\"|  She disappears with a wink.|">
	 <RTRUE>>

<OBJECT MOSS
	(LOC MOSS-ROOM)
	(DESC "moss")
	(FLAGS NODESC TRYTAKE NOALL SEEN)
	(SYNONYM MOSS PATCH)
	(ADJECTIVE GRAY GREY)
	(ACTION MOSS-F)>

<OBJECT MOSS2
	(LOC INNARDS)
	(DESC "moss")
	(FLAGS NODESC TRYTAKE NOALL SEEN)
	(SYNONYM MOSS PATCH)
	(ADJECTIVE GRAY GREY)
	(ACTION MOSS-F)>

<OBJECT MOSS3
	(LOC CAVE7)
	(DESC "moss")
	(FLAGS NODESC TRYTAKE NOALL SEEN)
	(SYNONYM MOSS PATCH)
	(ADJECTIVE GRAY GREY)
	(ACTION MOSS-F)>

<ROUTINE MOSS-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? TOUCH-TO>
		       <PRINT "The moss seems soft and pliant.|">
		       <RTRUE>)>
		<RFALSE>)	       
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " is sickly gray, glistening with moisture." CR>
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<TELL ,CANT "eat it off the wall." CR>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL CTHEO " smells like a diet-control capsule." CR>
		<RTRUE>)
	       (<VERB? SQUEEZE>
		<COND (<ZERO? ,LIT?>
		       <TOO-DARK>
		       <RFATAL>)
		      (<NOT <IS? ,PRSO ,TOUCHED>>
		       <MAKE ,PRSO ,TOUCHED>
		       <SETG THIS-MOSS ,PRSO>
		       <INC MOSSES>
		       <QUEUE ,I-MOSS>)>
		<PRINT "The moss seems soft and pliant.|">
		<RTRUE>)
	       (<VERB? TOUCH HIT PUSH REACH-IN KICK>
		<COND (<VERB? KICK>)
		      (<EQUAL? ,PRSI <> ,HANDS>
		       <TELL CTHEO " feels moist and spongy." CR>
		       <RTRUE>)>
		<PRINT "The moss seems soft and pliant.|">
		<RTRUE>)
	       (<SET X <MOVING?>>
		<TELL "Despite your best efforts, " THEO
		      " stays firmly stuck on the wall." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>				    

<OBJECT UNICORN
	(LOC STALL)
	(DESC "unicorn")
	(FLAGS NODESC VOWEL TRYTAKE NOALL LIVING 
	       PERSON FEMALE SURFACE NAMEABLE)
	(SYNONYM UNICORN ZZZP MARE PONY HORN BEAST ANIMAL CREATURE)
	(ADJECTIVE UNICORN\'S)
	(LIFE I-UNICORN)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(ACTION UNICORN-F)>

<ROUTINE UNICORN-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<NOUN-USED? ,W?HORN>
		<COND (<THIS-PRSI?>)
		      (<VERB? EXAMINE LOOK-ON>
		       <TELL 
"Her horn is slender, the color of fine ivory, with a deep spiral groove." CR>
		       <RTRUE>)
		      (<VERB? KISS>
		       <COND (<SPARK? <>>
			      <RTRUE>)>
		       <TELL CTHEO " backs away">
		       <COND (<NOT <IS? ,PRSO ,TOUCHED>>
			      <MAKE ,PRSO ,TOUCHED>
			      <TELL 
"; but not before you touch her horn with your lips." CR>
			      <UPDATE-STAT 15 ,LUCK T>
			      <RTRUE>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <HARMLESS ,PRSI>
		       <RTRUE>)
		      (<VERB? GIVE FEED>
		       <PERFORM ,V?PUT ,PRSO ,STALL>
		       <RTRUE>)
		      (<AND <VERB? SHOW>
			    <PRSO? CHEST>>
		       <MAKE ,PRSI ,SEEN>
		       <TELL CTHEI " pricks up her ears." CR>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <MAKE ,PRSI ,SEEN>
		       <MOVE ,PRSO ,STALL>
		       <WINDOW ,SHOWING-ALL>
		       <TELL CTHEI " shakes off " THEO
			     " and gives you a black look." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <VERB? RELEASE RESCUE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<PERFORM ,V?OPEN ,STALL>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "She's just a pony." CR>	       
		<RTRUE>)
	       (<SET X <TALKING?>>
		<TELL CTHEO " is too melancholy to respond." CR>
		<RFATAL>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (<SET X <HURTING?>>
		<HARMLESS>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<TELL CTHE ,UNICORN " backs shyly away." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT STALL
	(LOC IN-STABLE)
	(DESC "stall")
	(FLAGS NODESC VEHICLE CONTAINER OPENABLE LOCKED TRANSPARENT)
	(SYNONYM STALL GATE DOOR LOCK)
	(CAPACITY 100)
	(CONTFCN STALL-F)
	(ACTION STALL-F)>

<ROUTINE STALL-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<SET OBJ ,PRSO>
		<COND (<THIS-PRSI?>
		       <SET OBJ ,PRSI>)>
		<COND (<EQUAL? .CONTEXT ,M-BEG>
		       <RETURN <CANT-REACH-WHILE-IN? .OBJ ,STALL>>)
		      (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<IN? ,WINNER ,STALL>
			      <RFALSE>)
			     (<EQUAL? .OBJ <> ,UNICORN>
			      <RFALSE>)
			     (<GLOBAL-IN? ,HERE .OBJ>
			      <RFALSE>)
			     (<SET X <TOUCHING?>>				
			      <CANT-REACH .OBJ>
			      <TELL " while you're outside " 
				    THE ,STALL ,PERIOD>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT THROW PUT-BEHIND EMPTY-INTO>
		       <COND (<OR <IS? ,PRSI ,OPENED>
				  <IN? ,PLAYER ,PRSI>>
			      <RFALSE>)>
		       <MOVE ,PRSO ,PRSI>
		       <WINDOW ,SHOWING-ALL>
		       <TELL "You drop " THEO " over the side of " THEI>
		       <COND (<PRSO? CHEST>
			      <TELL ", where it falls with a heavy ">
			      <ITALICIZE "clunk">
			      <PRINT ,PERIOD>
			      <COND (<IN? ,UNICORN ,PRSI>
				     <UNICORN-OPENS-CHEST>)>
			      <RTRUE>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<COND (<NOT <NOUN-USED? ,W?STALL>>
		       <TELL "The stall's ">)
		      (T
		       <TELL CTHEO 
"'s sides are tall enough to discourage escape. Its ">)>
		<TELL "gate is ">
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL "utterly demolished." CR>
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <TELL "wide open." CR>
		       <RTRUE>)>
		<TELL B ,W?CLOSED>
		<COND (<IS? ,PRSO ,LOCKED>
		       <TELL " and locked">)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH LOOK-BEHIND>
		<COND (<IN? ,PLAYER ,PRSO>
		       <ASIDE-FROM>)
		      (<IN? ,UNICORN ,PRSO>
		       <ASIDE-FROM ,UNICORN>)
		      (T
		       <TELL ,YOU-SEE>)>
		<CONTENTS>
		<SETG P-IT-OBJECT ,PRSO>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? REACH-IN>
		     <NOT <IN? ,PLAYER ,PRSO>>>
		<TELL ,CANT "reach very far." CR>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-UP CLIMB-OVER SIT RIDE
		       STAND-ON LIE-DOWN>
		<TELL "The sides of " THEO " are too tall." CR>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <IS? ,PRSO ,MUNGED>>
		<ITS-MUNGED ,W?GATE>
		<RTRUE>)
	       (<VERB? ENTER THROUGH WALK-TO>
		<COND (<IN? ,PLAYER ,PRSO>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <RFALSE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<VERB? EXIT LEAVE ESCAPE>
		<COND (<NOT <IN? ,PLAYER ,PRSO>>
		       <NOT-IN>
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <RFALSE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<COND (<IS? ,PRSO ,MUNGED>
		       <ITS-MUNGED ,W?GATE>
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <RFALSE>)
		      (<ZERO? ,PRSI>
		       <RFALSE>)
		      (<VERB? OPEN-WITH>
		       <MUNG-STALL>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? KICK HIT MUNG LOOSEN PUSH SHAKE CUT>
		<COND (<IS? ,PRSO ,MUNGED>
		       <ITS-ALREADY "in ruins">
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "opened">
		       <RTRUE>)>
		<COND (<VERB? KICK>
		       <SETG PRSI ,FEET>)>
		<MUNG-STALL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MUNG-STALL ("OPT" (OBJ ,PRSI) "AUX" TBL)
	 <ITALICIZE "Wham">
	 <TELL "! ">
	 <YOUR-OBJ .OBJ>
	 <TELL " deals the gate a mighty blow">
	 <COND (<L? <GET ,STATS ,STRENGTH> 50>
		<NOTE-NOISE>
		<COND (<IN? ,UNICORN ,STALL>
		       <MAKE ,UNICORN ,SEEN>
		       <TELL ,TAB CTHE ,UNICORN
			     " slowly shakes her head." CR>)>
		<RTRUE>)>
	 <WINDOW ,SHOWING-ROOM>
	 <MAKE ,STALL ,OPENED>
	 <UNMAKE ,STALL ,LOCKED>
	 <MAKE ,STALL ,MUNGED>
	 <UNMAKE ,UNICORN ,SEEN>
	 <TELL ", shattering it into splinters." CR>
	 <RTRUE>>
	       
<ROUTINE UNICORN-OPENS-CHEST ()
	 <TELL ,TAB CTHE ,UNICORN
" cranes her neck towards " THE ,CHEST
" and snuffles the lid curiously. She ">
	 <HAPPY-UNICORN>
	 <TELL "prods the lid of the chest with her nose." CR ,TAB>
	 <DESCRIBE-GATE ,UNICORN>
	 <UPDATE-STAT 15 ,COMPASSION T>
	 <RTRUE>>	 

<ROUTINE HAPPY-UNICORN ()
	 <EXIT-UNICORN>
	 <TELL 
"whinnies with joy and nuzzles your face with shy gratitude. Then, eyes bright with anticipation, the lovely creature ">
	 <RTRUE>>

<ROUTINE BYE-UNICORN ()
	 <HAPPY-UNICORN>
	 <TELL "shakes her mane and races out of "
THE ,STABLE ", where her hoofbeats quickly fade into the distance." CR>
	 <UPDATE-STAT 15 ,COMPASSION T>
	 <RFALSE>>

<ROUTINE EXIT-UNICORN ()
	 <VANISH ,UNICORN>
	 <DEQUEUE ,I-UNICORN>
	 <RFALSE>>

<OBJECT STABLE
	(LOC LOCAL-GLOBALS)
	(DESC "stablehouse")
	(FLAGS NODESC PLACE)
	(SYNONYM STABLEHOUSE STABLE STABLES HOUSE)
	(ADJECTIVE STABLE LITTLE RED)
	(ACTION STABLE-F)>

<ROUTINE STABLE-F ("AUX" X)
	 <COND (<HERE? IN-STABLE>
		<RETURN <HERE-F>>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?NORTH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT STORM
	(LOC LOCAL-GLOBALS)
	(DESC "thunderclouds")
	(FLAGS NODESC PLURAL)
	(SYNONYM CLOUDS CLOUD THUNDER THUNDERCLOUD SKY)
	(ADJECTIVE STORM THUNDER)
	(ACTION STORM-F)>

<ROUTINE STORM-F ("AUX" X)
	 <COND (<OR <SET X <TOUCHING?>>
		    <VERB? LOOK-BEHIND>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL CTHEO " boil with dark energy." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TWISTER
	(DESC "tornado")
	(FLAGS NOALL)
	(SYNONYM TORNADO TWISTER CYCLONE FUNNEL STORM CLOUD CLOUDS SKY)
	(ADJECTIVE FUNNEL STORM)
	(DESCFCN TWISTER-F)
	(ACTION TWISTER-F)>

<ROUTINE TWISTER-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL
"A roaring funnel of wind is bearing down upon the farm!">
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TOUCHING?>>
		<TELL "Luckily, " THE ,TWISTER " isn't close enough." CR>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "It looks just like the one in ">
		<ITALICIZE "The Wizard of Froon">
		<TELL ,PERIOD>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL ,YOU-HEAR A ,SOUND 
		      " like a raging locomotive amid the thunder." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT MCASE
	(LOC IN-MAGICK)
	(DESC "display case")
	(FLAGS NODESC CONTAINER TRANSPARENT OPENABLE SURFACE)
	(CAPACITY 20)
	(SYNONYM CASE SHELVES SHELF)
	(ADJECTIVE DISPLAY GLASS)
	(DNUM ON-MCASE)
	(CONTFCN MCASE-F)
	(ACTION MCASE-F)>

<OBJECT ON-MCASE
	(LOC IN-MAGICK)
	(DESC "case")
	(FLAGS NODESC NOALL SURFACE)
	(CAPACITY 15)>

<ROUTINE MCASE-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-CASE? ,MCASE ,ON-MCASE .CONTEXT>>>

<OBJECT BCASE
	(LOC IN-BOUTIQUE)
	(DESC "display case")
	(FLAGS NODESC CONTAINER TRANSPARENT OPENABLE SURFACE)
	(CAPACITY 20)
	(SYNONYM CASE SHELVES SHELF)
	(ADJECTIVE DISPLAY GLASS)
	(DNUM ON-BCASE)
	(CONTFCN BCASE-F)
	(ACTION BCASE-F)>

<OBJECT ON-BCASE
	(LOC IN-BOUTIQUE)
	(DESC "case")
	(FLAGS NODESC NOALL SURFACE)
	(CAPACITY 15)>

<ROUTINE BCASE-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-CASE? ,BCASE ,ON-BCASE .CONTEXT>>>

<OBJECT WCASE
	(LOC IN-WEAPON)
	(DESC "display case")
	(FLAGS NODESC CONTAINER TRANSPARENT OPENABLE SURFACE)
	(CAPACITY 20)
	(SYNONYM CASE SHELVES SHELF)
	(ADJECTIVE DISPLAY GLASS)
	(DNUM ON-WCASE)
	(CONTFCN WCASE-F)
	(ACTION WCASE-F)>

<OBJECT ON-WCASE
	(LOC IN-WEAPON)
	(DESC "case")
	(FLAGS NODESC NOALL SURFACE)
	(CAPACITY 15)>

<ROUTINE WCASE-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-CASE? ,WCASE ,ON-WCASE .CONTEXT>>>

<ROUTINE HANDLE-CASE? (OBJ TOP CONTEXT "AUX" (ANY 0) ANYTOP X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<SET X <TOUCHING?>>
			      <CANT-REACH-IN .OBJ>
			      <RTRUE>)
			     (<VERB? SMELL TASTE EAT>
			      <YOUD-HAVE-TO "open" .OBJ>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<NOUN-USED? ,W?SHELVES ,W?SHELF>
		<COND (<SET X <TOUCHING?>>
		       <CANT-REACH-IN .OBJ>
		       <RTRUE>)
		      (<THIS-PRSI?>
		       <RFALSE>)
		      (<VERB? LOOK-ON EXAMINE>
		       <LOOK-IN-CASE .OBJ>
		       <RTRUE>)>)>
	 <SET ANYTOP <SEE-ANYTHING-IN? .TOP>>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-UNDER PUT-BEHIND EMPTY-INTO>
		       <ITS-CLOSED ,PRSI>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <WINDOW ,SHOWING-ALL>
		       <MOVE ,PRSO .TOP> 
		       <TELL "You put " THEO ,SON THE .OBJ ,PERIOD>
		       <COND (<NOT <IS? ,PRSO ,IDENTIFIED>>
			      <TELL ,TAB>
			      <ASK-OWOMAN-ABOUT ,PRSO>)>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <MUNG-CASE-WITH ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The interior of the glass " 'PRSO " is lined with ">
		<COND (<SEE-ANYTHING-IN?>
		       <INC ANY>
		       <TELL "shelves, upon which you see ">
		       <CONTENTS>
		       <SETG P-IT-OBJECT ,PRSO>)
		      (T
		       <TELL "empty shelves">)>
		<COND (<T? .ANYTOP>
		       <TELL ". ">
		       <COND (<T? .ANY>
			      <TELL "You also">)
			     (T
			      <TELL "On top of the case you">)>
		       <TELL " see ">
		       <CONTENTS .TOP>
		       <SETG P-IT-OBJECT ,PRSO>
		       <COND (<T? .ANY>
			      <TELL " on top of the case">)>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-ON>
		<TELL ,YOU-SEE>
		<CONTENTS .TOP>
		<SETG P-IT-OBJECT ,PRSO>
		<TELL ,SON THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? SEARCH LOOK-INSIDE LOOK-UNDER
		       LOOK-BEHIND>
		<LOOK-IN-CASE ,PRSO>
		<RTRUE>)
	       (<VERB? OPEN REACH-IN EMPTY>
		<COND (<AND <T? .ANYTOP>
			    <VERB? EMPTY>>
		       <SETG PRSO .TOP>
		       <V-EMPTY>
		       <SETG PRSO .OBJ>
		       <RTRUE>)>
		<TELL ,CTHELADY " slaps " 'HANDS " away. \"Ask.\"" CR>
		<RTRUE>)
	       (<VERB? HIT MUNG OPEN-WITH>
		<MUNG-CASE-WITH ,PRSI>
		<RTRUE>)
	       (<VERB? KICK>
		<MUNG-CASE-WITH ,FEET>
		<RTRUE>)
	       (<VERB? CLOSE>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<MUNG-CASE-WITH ,HANDS>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<NOT-ON>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-IN-CASE (OBJ)
	 <COND (<NOT <SEE-ANYTHING-IN? .OBJ>>
		<TELL "The shelves in " THE .OBJ
		      " are empty." CR>
		<RTRUE>)>
	 <TELL "Peering under the glass" ,LYOU-SEE>
	 <CONTENTS .OBJ>
	 <SETG P-IT-OBJECT .OBJ>
	 <PRINT ,PERIOD>
	 <RTRUE>>	 

<ROUTINE CANT-REACH-IN (OBJ)
	 <TELL ,CANT "reach into " THE .OBJ ,PERIOD>
	 <RTRUE>>

<ROUTINE MUNG-CASE-WITH (OBJ)
	 <MAKE ,OWOMAN ,SEEN>
	 <COND (<EQUAL? .OBJ ,HANDS ,FEET>
		<TELL "\"Stop that">)
	       (T
		<TELL "\"Put th">
		<COND (<IS? .OBJ ,PLURAL>
		       <TELL "ose ">)
		      (T
		       <TELL "at ">)>
		<TELL D .OBJ " down">)>
	 <TELL ",\" demands " THE ,OWOMAN ,PERIOD>
	 <RTRUE>>

<OBJECT PLATE
	(LOC BCASE)
	(DESC "plate mail")
	(FLAGS CLOTHING TAKEABLE SURFACE CONTAINER OPENED NOARTICLE)
	(SYNONYM MAIL PLATE ARMOR)
	(ADJECTIVE PLATE)
	(SIZE 10)
	(EFFECT 60)
	(EMAX 60)
	(VALUE 200)
	(ACTION PLATE-F)>

<ROUTINE PLATE-F ("AUX" X)
	 <COND (<HANDLE-ARMOR? ,PLATE>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "The bulky " D ,PRSO
" looks as if it could turn aside any blade you could wield." CR> 
		<RTRUE>)
	       (<VERB? TOUCH SQUEEZE>
		<TELL CTHEO " feels as sturdy as it looks." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CHAIN
	(DESC "chain mail")
	(FLAGS CLOTHING TAKEABLE SURFACE CONTAINER OPENED NOARTICLE)
	(SYNONYM MAIL CHAIN ARMOR)
	(ADJECTIVE CHAIN ELVIN ELVISH)
	(SIZE 3)
	(EFFECT 35)
	(EMAX 35)
	(VALUE 100)
	(ACTION CHAIN-F)>

<ROUTINE CHAIN-F ("AUX" X)
	 <COND (<HANDLE-ARMOR? ,CHAIN>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"The intricate silver mesh sparkles as you gaze upon it." CR>
		<RTRUE>)
	       (<VERB? TOUCH SQUEEZE>
		<TELL CTHEO " feels remarkably light and supple." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SCALE
	(LOC BCASE)
	(DESC "scale mail")
	(FLAGS CLOTHING TAKEABLE SURFACE CONTAINER OPENED NOARTICLE)
	(SYNONYM MAIL SCALE ARMOR)
	(ADJECTIVE SCALE)
	(SIZE 3)
	(EFFECT 20)
	(EMAX 20)
	(VALUE 60)
	(ACTION SCALE-F)>

<ROUTINE SCALE-F ("AUX" X)
	 <COND (<HANDLE-ARMOR? ,SCALE>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<LEATHER>
		<TELL 
"overcoat, with metal scales sewn on the outside." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<OILY>
		<RTRUE>)
	       (<VERB? TOUCH SQUEEZE>
		<TELL CTHEO " feels sturdy enough." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TUNIC
	(LOC BCASE)
	(DESC "leather tunic")
	(FLAGS CLOTHING TAKEABLE SURFACE CONTAINER OPENED)
	(SYNONYM TUNIC ARMOR)
	(ADJECTIVE LEATHER)
	(SIZE 3)
	(EFFECT 10)
	(EMAX 10)
	(VALUE 20)
	(ACTION TUNIC-F)>

<ROUTINE TUNIC-F ("AUX" X)
	 <COND (<HANDLE-ARMOR? ,TUNIC>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO
" wouldn't stop a hellhound, or even an arrow. But it looks comfortable." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<OILY>
		<RTRUE>)
	       (<VERB? TOUCH SQUEEZE>
		<TELL CTHEO " feels soft and supple." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OILY ()
	 <TELL CTHEO " smells rich and oily." CR>
	 <RTRUE>>

<OBJECT CLOAK
	(LOC BCASE)
	(DESC "cloak")
	(SDESC DESCRIBE-CLOAK)
	(FLAGS CLOTHING TAKEABLE SURFACE CONTAINER OPENED BUOYANT)
	(SYNONYM CLOAK STEALTH)
	(ADJECTIVE STEALTH)
	(SIZE 3)
	(EFFECT 5)
	(EMAX 5)
	(VALUE 30)
	(ACTION CLOAK-F)>


<ROUTINE CLOAK-F ("AUX" (W 0) EFX X)
	 <SET EFX <GETP ,CLOAK ,P?EFFECT>>
	 <COND (<AND <IN? ,CLOAK ,PLAYER>
		     <IS? ,CLOAK ,WORN>>
		<INC W>)>
	 <COND (<HANDLE-ARMOR? ,CLOAK>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<O-WEARING>
		<TELL 
" is so utterly unremarkable in color (dull gray), style (utilitarian) and cut (shapeless), that your eyes feel compelled to look elsewhere." CR>
		<RTRUE>)
	       (<VERB? WEAR USE>
		<COND (<T? .W>
		       <RFALSE>)
		      (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "pick up">
		       <RTRUE>)>
		<MAKE ,PRSO ,WORN>
		<TELL "You slip " THEO " over ">
		<DO-CLOAK .EFX>
		<RTRUE>)
	       (<VERB? TAKE-OFF>
		<COND (<ZERO? .W>
		       <RFALSE>)>
		<UNMAKE ,PRSO ,WORN>
		<TELL "You slip " THEO " off ">
		<DO-CLOAK <- 0 .EFX>>
		<RTRUE>)
	       (<VERB? TOUCH SQUEEZE>
		<TELL CTHEO " feels surprisingly soft and lightweight." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE O-WEARING ()
	 <TELL CTHEO>
	 <COND (<IS? ,PRSO ,WORN>
		<PRINT " you're wearing">)>
	 <RFALSE>>

<ROUTINE DO-CLOAK (EFX)
	 <TELL "your shoulders." CR>
	 <WINDOW ,SHOWING-INV>
	 <UPDATE-STAT .EFX ,ARMOR-CLASS>
	 <RFALSE>>

<ROUTINE HANDLE-ARMOR? (OBJ "AUX" (W 0) (C 0) EFX X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO PUT-UNDER PUT-BEHIND>
		       <TELL CTHEI " has no pockets in which to " 
			     B ,P-PRSA-WORD " things." CR>
		       <RTRUE>)
		      (<VERB? PUT-ON THROW THROW-OVER>
		       <NO-GOOD-SURFACE>
		       <RTRUE>)>
		<RFALSE>)>
	 
	 <COND (<AND <IN? .OBJ ,PLAYER>
		     <IS? .OBJ ,WORN>>
		<INC W>)>
	 <COND (<VERB? REACH-IN EMPTY LOOK-INSIDE SEARCH LOOK-UNDER
		       LOOK-BEHIND SHAKE>
		<COND (<T? .W>
		       <TELL "Except for " 'ME ", the ">)
		      (T
		       <TELL ,XTHE>)>
		<TELL D ,PRSO " is empty." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<TELL ,DONT "need to do that with this " 'PRSO ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .OBJ ,CLOAK>
		<RFALSE>)>
	 <SET EFX <GETP .OBJ ,P?EFFECT>>
	 <COND (<AND <IN? ,CLOAK ,PLAYER>
		     <IS? ,CLOAK ,WORN>>
		<INC C>)>
	 <COND (<VERB? WEAR USE>
		<COND (<T? .W>
		       <RFALSE>)
		      (<SET X <FIRST? ,PLAYER>>
		       <REPEAT ()
			  <COND (<AND <NOT <EQUAL? .X ,CLOAK ,HELM>>
				      <IS? .X ,CLOTHING>
				      <IS? .X ,WORN>
				      <GETP .X ,P?EFFECT>>
				 <RETURN>)>
			  <COND (<NOT <SET X <NEXT? .X>>>
				 <RETURN>)>>)>
		<COND (<T? .X>
		       <YOUD-HAVE-TO "take off" .X>
		       <RTRUE>)
		      (<NOT <IN? .OBJ ,PLAYER>>
		       <YOUD-HAVE-TO "pick up">
		       <RTRUE>)>
		<MAKE ,PRSO ,WORN>
		<TELL ,CYOU>
		<COND (<T? .C>
		       <TELL "slip off your " D ,CLOAK ", ">)>
		<TELL "put on " THEO>
		<COND (<T? .C>
		       <TELL " and throw the cloak back over it">)>
		<DO-WEAR .EFX>
		<RTRUE>)
	       (<VERB? TAKE-OFF>
		<COND (<ZERO? .W>
		       <RFALSE>)>
		<UNMAKE ,PRSO ,WORN>
		<TELL ,CYOU>
		<COND (<T? .C>
		       <TELL "remove your " D ,CLOAK ", ">)>
		<TELL "take off " THEO>
		<COND (<T? .C>
		       <TELL " and slip the cloak back on">)>
		<DO-WEAR <- 0 .EFX>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-WEAR (EFX)
	 <PRINT ,PERIOD>
	 <WINDOW ,SHOWING-INV>
	 <UPDATE-STAT .EFX ,ARMOR-CLASS>
	 <RFALSE>>

<OBJECT QUICKSAND
	(LOC JUN0)
	(DESC "quicksand")
	(FLAGS NODESC TRYTAKE NOALL CONTAINER OPENED SURFACE)
	(CAPACITY 10000)
	(SYNONYM QUICKSAND SAND POOL MUD)
	(ADJECTIVE QUICK)
	(CONTFCN QUICKSAND-F)
	(ACTION QUICKSAND-F)>

<ROUTINE QUICKSAND-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-CONT>
		       <SET OBJ ,PRSO>
		       <COND (<THIS-PRSI?>
			      <SET OBJ ,PRSI>)>
		       <COND (<ZERO? .OBJ>
			      <RFALSE>)
			     (<VERB? THROW THROW-OVER>
			      <HIT-SANDED-OBJ-WITH ,PRSI ,PRSO>
			      <RTRUE>)
			     (<VERB? KICK>
			      <HIT-SANDED-OBJ-WITH ,PRSO ,FEET>
			      <RTRUE>)
			     (<VERB? HIT KICK MUNG>
			      <HIT-SANDED-OBJ-WITH ,PRSO ,PRSI>
			      <RTRUE>)
			     (<SET X <TOUCHING?>>
			      <CANT-REACH .OBJ>
			      <STANDING>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <ITALICIZE "Ploop">
		       <TELL "! " CTHEO " lands on " THEI ,AND>
		       <COND (<AND <PRSO? ,PARASOL>
				   <IS? ,PRSO ,OPENED>>)
			     (<G? <GETP ,PRSO ,P?SIZE> 2>
			      <VANISH>
			      <TELL "slowly sinks out of sight." CR>
			      <RTRUE>)>
		       <MOVE ,PRSO ,PRSI>
		       <WINDOW ,SHOWING-ALL>
		       <TELL "floats uncertainly." CR>
		       <RTRUE>)
		      (<VERB? TOUCH-TO>
		       <HIT-SAND-WITH ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-ON EXAMINE LOOK-INSIDE SEARCH>
		<TELL ,YOU-SEE>
		<CONTENTS>
		<SETG P-IT-OBJECT ,PRSO>
		<TELL " floating on " THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND OPEN CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? TOUCH REACH-IN SQUEEZE EMPTY>
		<HIT-SAND-WITH ,HANDS>
		<RTRUE>)
	       (<VERB? KICK>
		<HIT-SAND-WITH ,FEET>
		<RTRUE>)
	       (<VERB? HIT MUNG>
		<HIT-SAND-WITH ,PRSI>
		<RTRUE>)
	       (<OR <SET X <ENTERING?>>
		    <VERB? SWIM DIVE CLIMB-DOWN>>
		<ENTER-QUICKSAND>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<ITALICIZE "Gloop">
		<TELL ". It seems that ">
		<GRITTY>
		<TELL " is virtually impossible to move." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE HIT-SANDED-OBJ-WITH (OBJ WITH)
	 <YOUR-OBJ .WITH>
	 <TELL " misses " THE .OBJ>
	 <COND (<AND <VERB? THROW THROW-OVER>
		     <NOT <EQUAL? .WITH <> ,HANDS ,FEET>>>
		<TELL ", lands with a ">
		<ITALICIZE "ploop">
		<TELL ,SIN THE ,QUICKSAND ,AND>
		<COND (<OR <IS? .OBJ ,BUOYANT>
			   <L? <GETP .OBJ ,P?SIZE> 3>
			   <AND <EQUAL? .OBJ ,PARASOL>
				<IS? .OBJ ,OPENED>>>
		       <MOVE .WITH ,QUICKSAND>
		       <WINDOW ,SHOWING-ALL>
		       <TELL "floats there uncertainly">)
		      (T
		       <VANISH .WITH>
		       <TELL "sinks out of sight">)>)
	       (T
		<TELL ". It's just beyond your reach">)>
	 <PRINT ,PERIOD>
	 <COND (<OR <NOT <EQUAL? .OBJ ,BABY>>
		    <IS? ,MAMA ,MONSTER>
		    <NOT <VISIBLE? ,MAMA>>>
		<RTRUE>)>
	 <SETG LAST-MONSTER ,MAMA>
	 <MAMA-TO-MONSTER>
	 <TELL ,TAB "A sound like a snorting bull turns your attention to "
THE ,MAMA ". It looks as if she's about to attack!" CR>
	 <RTRUE>>

<ROUTINE MAMA-TO-MONSTER ()
	 <MAKE ,MAMA ,MONSTER>
	 <REPLACE-SYN? ,MAMA ,W?ZZZP ,W?MONSTER>
	 <PUTP ,MAMA ,P?GENERIC ,GENERIC-MONSTER-F>
	 <RFALSE>>

<ROUTINE HIT-SAND-WITH (OBJ)
	 <TELL "Ick! ">
	 <YOUR-OBJ .OBJ>
	 <TELL " pulls away from ">
	 <GRITTY>
	 <TELL " with a sickening ">
	 <ITALICIZE "slurp">
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE GRITTY ()
	 <TELL "the wet, gritty " 'QUICKSAND>
	 <RTRUE>>

<ROUTINE ENTER-QUICKSAND ()
	 <TELL 
"You step boldly into the pool, and thrash helplessly for a while in ">
	 <GRITTY>
	 <TELL " until your mouth fills">
	 <JIGS-UP>
	 <RFALSE>>

<OBJECT MAMA
	(LOC JUN0)
	(LAST-LOC JUN0)
	(DESC "mother hungus")
	(FLAGS NODESC LIVING TRYTAKE NOALL FEMALE NAMEABLE)
	(SYNONYM HUNGUS HUNGUS MOTHER MAMA MA MOM MOMMA ZZZP)
	(ADJECTIVE MOTHER MAMA MA)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(LIFE I-MAMA)
	(ENDURANCE 30)
	(EMAX 30)
	(STRENGTH 16)
	(DEXTERITY 95)
	(GENERIC 0)
	(CONTFCN MAMA-F)
	(DESCFCN MAMA-F)
	(ACTION MAMA-F)>

<ROUTINE GOOD-MAMA ()
	 <COND (<IN? ,BABY ,QUICKSAND>
		<UNMAKE ,MAMA ,MONSTER>
		<REPLACE-SYN? ,MAMA ,W?MONSTER ,W?ZZZP>
		<PUTP ,MAMA ,P?GENERIC 0>)>
	 <PUTP ,MAMA ,P?LAST-LOC ,JUN0>
	 <MOVE ,MAMA ,JUN0>
	 <RFALSE>>

<ROUTINE MAMA-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,MAMA " is standing nearby">
		       <COND (<VISIBLE? ,BABY>
			      <TELL ", gazing anxiously at her baby">)>
		       <TELL C ,PER>
		       <RTRUE>)
		      (<EQUAL? .CONTEXT ,M-CONT>
		       <SET OBJ ,PRSO>
		       <COND (<THIS-PRSI?>
			      <SET OBJ ,PRSI>)>
		       <COND (<ZERO? .OBJ>
			      <RFALSE>)>
		       <TELL ,CANT>
		       <COND (<SET X <SEEING?>>
			      <TELL "see ">)
			     (<SET X <TOUCHING?>>
			      <TELL "reach ">)
			     (T
			      <TELL "do that with ">)>
		       <TELL THE .OBJ " while it's inside " THE ,MAMA ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<TALK-TO-MUNGI?>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<GAZEBACK>
		<TELL "suspiciously." CR>
		<RTRUE>)
	       (<VERB? HIT MUNG KICK>
		<TELL CTHEO " avoids your ">
		<COND (<EQUAL? ,PRSI <> ,HANDS>
		       <TELL "blow">)
		      (<OR <VERB? KICK>
			   <PRSI? ,FEET>>
		       <TELL "foot">)
		      (T
		       <TELL D ,PRSI>)>
		<TELL ", and bellows a warning." CR>
		<RTRUE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE TALK-TO-MUNGI? ("AUX" X)
	 <COND (<SET X <TALKING?>>
		<TELL 
"Hunguses (hungi?) aren't smart enough to understand." CR>
		<RTRUE>)>
	 <RFALSE>>

<OBJECT BABY
	(LOC QUICKSAND)
	(DESC "baby hungus")
	(FLAGS TRYTAKE NOALL LIVING NAMEABLE)
	(SYNONYM BABY HUNGUS)
	(ADJECTIVE BABY LITTLE SMALL)
	(LIFE I-BABY)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(ACTION BABY-F)>

<ROUTINE BABY-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
	        <RFALSE>)
	       (<TALK-TO-MUNGI?>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<GAZEBACK>
		<TELL "helplessly." CR>
		<RTRUE>)
	       (<VERB? RESCUE RELEASE>
		<TELL "Easier said than done." CR>
		<RTRUE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE GAZEBACK ()
	 <TELL CTHEO " gazes back at you ">
	 <RFALSE>>

<OBJECT PARASOL
	(DESC "umbrella")
	(SDESC DESCRIBE-PARASOL)
	(FLAGS NODESC TAKEABLE OPENABLE FERRIC)
	(SYNONYM UMBRELLA PARASOL BROLLY HANDLE PARROT HEAD)
	(ADJECTIVE CLOSED PARROT\'S)
	(SIZE 8)
	(VALUE 2)
	(DESCFCN PARASOL-F)
	(ACTION PARASOL-F)>


<ROUTINE PARASOL-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL
CA ,PARASOL " dangles uncertainly from one of the ropes.">
		       <RTRUE>)>
		<RFALSE>)
	       (<OR <NOUN-USED? ,W?HANDLE ,W?PARROT ,W?HEAD>
		    <ADJ-USED? ,W?PARROT\'S>>
		<COND (<VERB? EXAMINE LOOK-ON>
		       <TELL "The parrot's head stares back at you." CR>
		       <RTRUE>)
		      (<VERB? TAKE MOVE PULL>
		       <TELL "The handle is firmly attached to the "
			     'PRSO ,PERIOD>
		       <RTRUE>)>
		<USELESS "umbrella's handle" T>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <TELL CTHEO " glances off the " D ,PRSI ,AND>
		       <FALLS>
		       <RTRUE>)
		      (<VERB? PUT PUT-ON EMPTY-INTO>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL CTHEO  
"'s handle is carved in the shape of a parrot's head." CR>
		<RTRUE>)
	       (<VERB? READ LOOK-ON>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL
"Nothing is legible on the " 'PRSO ,PERIOD>
		       <RTRUE>)>
		<YOUD-HAVE-TO "open">
		<RTRUE>)
	       (<FIRST-TAKE?>
		<RTRUE>)
	       (<VERB? STAND-UNDER>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)
		      (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-CLOSED>
		       <RTRUE>)>
		<TELL ,ALREADY "doing that." CR>
		<RTRUE>)
	       (<AND <VERB? OPEN OPEN-WITH>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL ,CANT "open " THEO " anymore." CR>
		       <RTRUE>)
		      (<NOT <IN? ,PARASOL ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)>
		<MAKE ,PRSO ,OPENED>
		<MAKE ,PRSO ,SURFACE>
		<MAKE ,PRSO ,VOWEL>
		<MAKE ,PRSO ,BUOYANT>
		<WINDOW ,SHOWING-INV>
	        <REPLACE-ADJ? ,PRSO ,W?CLOSED ,W?OPEN>
		<TELL "You snap open the " 'PRSO ,PERIOD>
		<COND (<AND <IS? ,HERE ,INDOORS>
			    <NOLUCK?>>
		       <UPDATE-STAT -1 ,LUCK T>
		       <RTRUE>)
		      (<HERE? IN-SKY>
		       <SETG P-WALK-DIR <>>
		       <TELL ,TAB
"Before you can think or move, a gust of wind pulls you">
		       <OUT-OF-LOC ,SADDLE>
		       <TELL ", and you float down to a ">
		       <SET X <DOWN-TO?>>
		       <COND (<ZERO? .X>
			      <COND (<EQUAL? ,ABOVE ,OTHRIFF>
				     <TELL "hideous death among " THE ,XTREES
					   " of Thriff">
				     <JIGS-UP>
				     <RTRUE>)>
			    ; <SAY-ERROR "PARASOL-F">
			      <RTRUE>)>
		       <SETG OLD-HERE <>>
		       <SETG P-WALK-DIR <>>
		       <WINDOW ,SHOWING-ALL>
		       <MOVE ,PLAYER .X>
		       <TELL "reasonably soft landing">
		       <RELOOK>)>
		<RTRUE>)
	       (<VERB? CLOSE FOLD>
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL ,CANT "close " THEO " anymore." CR>
		       <RTRUE>)
		      (<NOT <IN? ,PARASOL ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)
		      (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-ALREADY "closed">
		       <RTRUE>)>
		<UNMAKE ,PRSO ,OPENED>
		<UNMAKE ,PRSO ,SURFACE>
		<UNMAKE ,PRSO ,VOWEL>
		<UNMAKE ,PRSO ,BUOYANT>
		<WINDOW ,SHOWING-INV>
	        <REPLACE-ADJ? ,PRSO ,W?OPEN ,W?CLOSED>
		<TELL "You snap the " 'PRSO " shut." CR>
		<RTRUE>)
	       (<VERB? FILL-FROM>
		<COND (<WATER?>
		       <TELL "Water ">
		       <PRINT "splashes all over the place.|">
		       <RTRUE>)
		      (<PRSI? POOL>
		       <TELL "Radiance leaks through " THEO
			     " and dissipates in the air." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT ZSIGN
	(LOC LOCAL-GLOBALS)
	(DESC "notice")
	(FLAGS NODESC READABLE TRYTAKE)
	(SYNONYM NOTICE SIGN)
	(ACTION ZSIGN-F)>

<ROUTINE ZSIGN-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE READ LOOK-ON>
		<TELL CTHEO " says,||">
		<HLIGHT ,H-MONO>
		<TELL "    ZENO'S BRIDGE|Cross at thy Own Risk" CR>
		<HLIGHT ,H-NORMAL>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<ROOTED ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WHISTLE
	(LOC DACT)
	(DESC "whistle")
	(SDESC DESCRIBE-WHISTLE)
	(FLAGS TAKEABLE CLOTHING)
	(SIZE 1)
	(VALUE 10)
	(SYNONYM WHISTLE SUMMONING CHAIN)
	(ADJECTIVE SUMMONING)
	(ACTION WHISTLE-F)>


<GLOBAL HOOTS:NUMBER 0>

<ROUTINE WHISTLE-F ("AUX" (ITAL 0) X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<NOUN-USED? ,W?CHAIN>
		<COND (<VERB? BLOW-INTO>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<OR <VERB? EXAMINE LOOK-ON>
			   <SET X <MOVING?>>>
		       <FIRMLY-ATTACHED "chain" ,PRSO T>
		       <RTRUE>)>)>
	 <COND (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO " has a picture of a " 'DACT 
" etched on it, and has a chain for wearing." CR>
		<RTRUE>)
	       (<VERB? BLOW-INTO USE>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)
		      (<NOT <EQUAL? ,HOST ,APPLE-2E ,APPLE-2C>>
		       <INC ITAL>)>
		<TELL CTHEO " emits a long, harsh wail">
		<COND (<PLAIN-ROOM?>
		       <TELL " that is swallowed in a clap of thunder">)>
		<TELL ,PTAB>
		<COND (<IS? ,PRSO ,NEUTRALIZED>)
		      (<VISIBLE? ,DACT>
		       <COND (<IS? ,DACT ,SLEEPING>
			      <WAKE-DACT>
			      <RTRUE>)>
		       <TELL CTHE ,DACT>
		       <PRINT " looks at you expectantly. ">
		       <COND (<T? .ITAL>
			      <HLIGHT ,H-ITALIC>)
			     (T
			      <PRINTC ,QUOTATION>)>
		       <TELL "I await your pleasure">
		       <COND (<T? .ITAL>
			      <HLIGHT ,H-NORMAL>)>
		       <PRINTC %<ASCII !\,>>
		       <COND (<ZERO? .ITAL>
			      <PRINTC ,QUOTATION>)>
		       <TELL " whispers a voice in " 'HEAD ,PERIOD>
		       <RTRUE>)>
		<COND (<AND <HERE? IN-GARDEN>
			    <IN? ,QUEEN ,HERE>>
		       <QUEEN-SEES-YOU "at the sound">
		       <RTRUE>)>
		<TELL "Nothing happens">
		<COND (<OR <IS? ,PRSO ,NEUTRALIZED>
			   <HERE? IN-FROON APLANE IN-SPLENDOR>
			   <PLAIN-ROOM?>
			   <NOT <EQUAL? ,ATIME ,PRESENT>>
			   <IN? ,PLAYER ,ARCH>
			   <IS? ,HERE ,INDOORS>
			   <IS? ,DACT ,SLEEPING>
			   <IS? ,DACT ,MUNGED>
			   <NOT <IS? ,DACT ,LIVING>>
			   <IGRTR? HOOTS 3>>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<TELL 
" for a moment. Then, with a raucous cry and a great beating of wings, "
THE ,DACT>
		<COND (<OR <T? ,LAST-MONSTER>
			   <FIND-IN? ,HERE ,MONSTER>
			   <IN? ,PLAYER ,GONDOLA>
			   <HERE? NW-SUPPORT SW-SUPPORT SE-SUPPORT>
			   <AND <NOT <EQUAL? 0 ,LAVA-TIMER ,MAGMA-TIMER>>
				<HERE? FOREST-EDGE ON-TRAIL ON-PEAK>>>
		       <TELL 
" swoops overhead. Finding no safe place to land, he soars away again." CR>
		       <RTRUE>)>
		<TELL " lands by your side" ,PTAB>
		<MOVE ,DACT ,HERE>
		<UNMAKE ,DACT ,NODESC>
		<WINDOW ,SHOWING-ROOM>
		<COND (<T? .ITAL>
		       <HLIGHT ,H-ITALIC>)
		      (T
		       <PRINTC ,QUOTATION>)>
		<TELL "This is the ">
		<COND (<EQUAL? ,HOOTS 3>
		       <TELL "last time I shall answer">)
		      (T
		       <COND (<EQUAL? ,HOOTS 1>
			      <TELL "first">)
			     (T
			      <TELL "second">)>
		       <TELL " time I have answered">)>
		<TELL " the whistle's call">
		<COND (<T? .ITAL>
		       <HLIGHT ,H-NORMAL>)>
		<PRINTC %<ASCII !\,>>
		<COND (<ZERO? .ITAL>
		       <PRINTC ,QUOTATION>)>
		<TELL " observes a voice in " 'HEAD>
		<COND (<EQUAL? ,HOOTS 3>
		       <VANISH>
		       <TELL "; and as it speaks, " THEO
			     " melts away into nothingness">)>
		<TELL ". ">
		<COND (<T? .ITAL>
		       <HLIGHT ,H-ITALIC>)
		      (T
		       <PRINTC ,QUOTATION>)>
		<COND (<L? ,HOOTS 3>
		       <COND (<EQUAL? ,HOOTS 1>
			      <TELL "Twice">)
			     (T
			      <TELL "Once">)>
		       <TELL " more you may use it to summon me">
		       <COND (<T? .ITAL>
			      <HLIGHT ,H-NORMAL>)>
		       <TELL ". ">
		       <COND (<T? .ITAL>
			      <HLIGHT ,H-ITALIC>)>)>
		<TELL "I wait at your disposal">
		<COND (<T? .ITAL>
		       <HLIGHT ,H-NORMAL>)>
		<PRINTC ,PER>
		<COND (<ZERO? .ITAL>
		       <PRINTC ,QUOTATION>)>
		<CRLF>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CHAPEL
	(LOC LOCAL-GLOBALS)
	(DESC "chapel")
	(FLAGS NODESC PLACE)
	(SYNONYM CHAPEL CHURCH TEMPLE)
	(ACTION CHAPEL-F)>

<ROUTINE CHAPEL-F ("AUX" X)
	 <COND (<SET X <EXITING?>>
		<COND (<HERE? IN-CHAPEL>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)>
		<NOT-IN>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<HERE? IN-CHAPEL>
		<RETURN <HERE-F>>)
	       (T
		<RFALSE>)>>

<OBJECT CHAPEL-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "door")
	(FLAGS NODESC DOORLIKE OPENABLE OPENED)
	(SYNONYM DOOR DOORS DOORWAY)
	(ADJECTIVE FRONT CHAPEL)>

<OBJECT PEW
	(LOC IN-CHAPEL)
	(DESC "pew")
	(FLAGS VEHICLE SURFACE)
	(CAPACITY 100)
	(SYNONYM PEW SEAT CHAIR)
	(ACTION PEW-F)>

<OBJECT UNDERPEW
	(LOC IN-CHAPEL)
	(DESC "pew")
	(FLAGS NODESC NOALL SURFACE)>
	
<ROUTINE PEW-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <SET X <SEE-ANYTHING-IN? ,PEW>>
		       <TELL "There's a">
		       <COND (<ZERO? .X>
			      <TELL "n empty">)>
		       <TELL " pew just inside " THE ,CHAPEL-DOOR>
		       <COND (<T? .X>
			      <PRINT ". On it you see ">
			      <CONTENTS ,PEW>
			      <SETG P-IT-OBJECT ,PEW>)>
		       <PRINTC ,PER>
		       <RTRUE>)
		      (<EQUAL? .CONTEXT ,M-BEG>
		       <SET OBJ ,PRSO>
		       <COND (<THIS-PRSI?>
			      <SET OBJ ,PRSI>)>
		       <COND (<EQUAL? .OBJ <> ,PEW ,UNDERPEW>
			      <RFALSE>)
			     (<IN? .OBJ ,UNDERPEW>
			      <RFALSE>)
			     (<GLOBAL-IN? ,HERE .OBJ>
			      <RFALSE>)
			     (<AND <IN? .OBJ ,HERE>
				   <SET X <TOUCHING?>>>
			      <CANT-REACH .OBJ>
			      <TELL " while you're sitting on " 
				    THE ,PEW ,PERIOD>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT-UNDER PUT-BEHIND>
		       <COND (<G? <GETP ,PRSO ,P?SIZE> 6>
			      <TELL CTHEO " won't fit under " THEI ,PERIOD>
			      <RTRUE>)>
		       <STASH ,UNDERPEW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? ENTER SIT>
		<ENTER-PEW>
		<RTRUE>)
	       (<VERB? STAND-ON LEAP LIE-DOWN>
		<TELL "Pews are for sitting." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " looks ">
		<COND (<IN? ,PLAYER ,PRSO>
		       <TELL "and feels ">)>
		<TELL "uncomfortably hard">
		<COND (<SEE-ANYTHING-IN?>
		       <TELL ". Upon it you see ">
		       <CONTENTS ,PRSO>
		       <SETG P-IT-OBJECT ,PRSO>
		       <COND (<SET X <FIRST? ,UNDERPEW>>
			      <TELL ". There also ">
			      <PRINT "seems to be something underneath">)>)
		      (<SET X <FIRST? ,UNDERPEW>>
		       <TELL ". There ">
		       <PRINT "seems to be something underneath">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-UNDER SEARCH LOOK-BEHIND>
		<COND (<SET X <FIRST? ,UNDERPEW>>
		       <TELL "Peering under " THEO ,LYOU-SEE>
		       <CONTENTS ,UNDERPEW>
		       <SETG P-IT-OBJECT ,PRSO>)
		      (T
		       <TELL ,NOTHING "under " THEO>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE STASH (OBJ)
	 <MOVE ,PRSO .OBJ>
	 <WINDOW ,SHOWING-INV>
	 <TELL "You stash " THEO " out of sight beneath "
	       THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE ENTER-PEW ()
	 <COND (<IN? ,PLAYER ,PEW>
		<ALREADY-ON ,PEW>
		<RFALSE>)>
	 <MOVE ,PLAYER ,PEW>
	 <PEWSLIDE>
	 <RFALSE>>

<ROUTINE EXIT-PEW ()
	 <COND (<NOT <IN? ,PLAYER ,PEW>>
		<NOT-ON>
		<RFALSE>)>
	 <MOVE ,PLAYER ,IN-CHAPEL>
	 <PEWSLIDE T>
	 <RFALSE>>

<ROUTINE PEWSLIDE ("OPT" X)
	 <WINDOW ,SHOWING-ROOM>
	 <SETG OLD-HERE <>>
	 <SETG P-WALK-DIR <>>
	 <COND (<NOT <IS? ,VIAL ,TOUCHED>>
		<MAKE ,VIAL ,TOUCHED>
		<SETG P-IT-OBJECT ,VIAL>
		<TELL "As you slide into the pew, "
		      'FEET " nudges something underneath." CR>
		<RTRUE>)>
	 <TELL "You slide quietly ">
	 <COND (<ASSIGNED? X>
		<TELL B ,W?OFF>)
	       (T
		<TELL B ,W?INTO>)>
	 <TELL C ,SP THE ,PEW ,PERIOD>
	 <RTRUE>>

<OBJECT BFLY
	(LOC PLAIN1)
	(DESC "butterfly")
	(SDESC DESCRIBE-BFLY)
	(FLAGS TRYTAKE ; TAKEABLE LIVING PERSON FEMALE NAMEABLE)
	(SYNONYM BUTTERFLY ZZZP FLY INSECT)
	(ADJECTIVE BUTTER)
	(LIFE I-BFLY)
	(SIZE 1)
	(VALUE 5)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(DESCFCN BFLY-F)
	(ACTION BFLY-F)>

<VOC "CATERPILLAR" NOUN>
		

<ROUTINE BFLY-F ("OPT" (CONTEXT <>) "AUX" (ALIVE 0) (CAT 0) X)
	 <SETG P-IT-OBJECT ,BFLY>
	 <COND (<IS? ,BFLY ,LIVING>
		<INC ALIVE>)>
	 <COND (<IS? ,BFLY ,MUNGED>
		<INC CAT>)>
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<MAKE ,BFLY ,IDENTIFIED>
		<TELL CA ,BFLY ,SIS>
		<COND (<ZERO? .ALIVE>
		       <TELL "lying on">)
		      (<T? .CAT>
		       <TELL "crawling around">)
		      (T
		       <TELL "fluttering around " 'HEAD C ,PER>
		       <RTRUE>)>
		<TELL ,STHE>
		<GROUND-WORD>
		<TELL C ,PER>
		<RTRUE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<COND (<ZERO? .ALIVE>
		       <NOT-LIKELY>
		       <PRINT " would respond.|">
		       <RFATAL>)>
		<TELL CTHE ,BFLY " pretends not to understand you." CR>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON>
		<MAKE ,BFLY ,IDENTIFIED>
		<COND (<ZERO? .ALIVE>
		       <TELL "She's dead." CR>
		       <RTRUE>)>
		<TELL CTHEO>			      
		<COND (<ZERO? .CAT>
		       <TELL 
" is almost as big as your hand, and dappled with splotches of ">
		       <COND (<SEE-COLOR?>
			      <TELL "bright color." CR>
			      <RTRUE>)>
		       <TELL "gray." CR>
		       <RTRUE>)>
		<TELL " assigns one of her eyes to stare back at you." CR>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<COND (<OR <ZERO? .ALIVE>
			   <T? .CAT>>
		       <RFALSE>)>
		<UNMAKE ,PRSO ,SEEN>
		<WINDOW ,SHOWING-ALL>
		<SET X <LOC ,PRSO>>
		<TELL CTHEO>
		<COND (<NOT <EQUAL? .X ,HERE>>
		       <MOVE ,PRSO ,HERE>
		       <TELL " flutters">
		       <OUT-OF-LOC .X>
		       <TELL " and">)>
		<TELL " darts out of reach." CR>   			     
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GOBLET
	(DESC "goblet")
	(SDESC DESCRIBE-GOBLET)
	(FLAGS TAKEABLE CONTAINER OPENED FERRIC)
	(SYNONYM ZZZP GOBLET CHALICE ZZZP CUP COATING LIQUID NECTAR)
	(ADJECTIVE ZZZP GOLD GOLDEN STICKY)
	(SIZE 3)
	(CAPACITY 2)
	(VALUE 50)
	(NAME-TABLE 0)
	(ACTION GOBLET-F)>


<ROUTINE GOBLET-F ("OPT" (CONTEXT <>) "AUX" (B 0) X)
	 <COND (<AND <IN? ,BFLY ,GOBLET>
		     <IS? ,BFLY ,LIVING>
		   ; <NOT <IS? ,BFLY ,MUNGED>>>
		<INC B>)>
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)>
	 <COND (<NOUN-USED? ,W?COATING ,W?LIQUID ,W?NECTAR>
		<COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE>
		       <TELL "The coating on the inside of " THEO
			     " is thin and transparent." CR>
		       <RTRUE>)
		      (<OR <VERB? TOUCH>
			   <SET X <MOVING?>>>
		       <TELL
"You succeed only in getting your fingers sticky, so you lick them clean"
,PTAB>
		       <TASTE-NECTAR>
		       <RTRUE>)
		      (<VERB? DRINK TASTE>
		       <TASTE-NECTAR>
		       <RTRUE>)>)>
	 <COND (<VERB? EXAMINE>
		<TELL 
"Despite a sticky coating on the inside, " THEO
" gleams with the lustre of pure gold">
		<COND (<T? .B>
		       <TELL ". There's ">
		       <TELL A ,BFLY>
		       <PRINT " resting on the rim">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<NOT <ITAKE>>
		       <INC IMPSAY>
		       <RTRUE>)>
		<TELL "The Implementor smiles kindly as you take " THEO 
". \"And now you will excuse us. My fellow Implementors and I must prepare for something too awesome to reveal to one as insignificant as you.\"" CR>
		<ATRII-KICK>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<T? .B>
		       <REMOVE ,BFLY>)>
		<TELL "Aside from a sticky coating, ">
		<COND (<SEE-ANYTHING-IN?>
		       <TELL "you see ">
		       <CONTENTS>
		       <SETG P-IT-OBJECT ,PRSO>
		       <TELL ,SIN THEO>
		       <COND (<T? .B>
			      <TELL ". There's also ">)>)
		      (T
		       <TELL THEO " is empty">
		       <COND (<T? .B>
			      <TELL ". But there's ">)>)>
		<COND (<T? .B>
		       <MOVE ,BFLY ,PRSO>
		       <TELL A ,BFLY>
		       <PRINT " resting on the rim">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? TASTE DRINK>
		<TELL "[the sticky coating" ,BRACKET>
		<TASTE-NECTAR>
		<RTRUE>)
	       (<AND <VERB? SAY YELL>
		     <T? ,GOBLET-WORD>
		     <NOUN-USED? ,GOBLET-WORD>
		     <SAY-GOBLET-WORD?>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TASTE-NECTAR ()
	 <TELL 
"Few indeed are those lucky enough to taste the nectar of the Implementors">
	 <COND (<NOT <IS? ,GOBLET ,MUNGED>>
		<MAKE ,GOBLET ,MUNGED>
		<TELL ,PERIOD>
		<UPDATE-STAT 15 ,LUCK T>
		<RTRUE>)>
	 <PRINT ". Unfortunately, ">
	 <TELL "very little remains." CR>
	 <RTRUE>>

<GLOBAL GOBLET-WORD:WORD <>>

<ROUTINE SETUP-GOBLET ("AUX" TBL)
	 <SET TBL <PICK-ONE ,MAGIC-WORDS>>
       ; <COND (<T? <GET .TBL 2>>
		<SAY-ERROR "MAGIC-WORDS">
		<RFALSE>)>
	 <PUT .TBL 2 1>
	 <SETG GOBLET-WORD <GET .TBL 0>>
	 <PUTP ,GOBLET ,P?NAME-TABLE <GET .TBL 1>>
	 <PUT <GETPT ,GOBLET ,P?SYNONYM> 0 ,GOBLET-WORD>
	 <PUT <GETPT ,GOBLET ,P?ADJECTIVE> 0 ,GOBLET-WORD>
	 <MAKE ,GOBLET ,PROPER>
	 <MAKE ,GOBLET ,NAMED>
	 <MAKE ,GOBLET ,IDENTIFIED>
	 <WINDOW ,SHOWING-ALL>
	 <RFALSE>>

<ROUTINE SAY-GOBLET-WORD? ()
	 <COND (<AND <HERE? APLANE>
		     <EQUAL? ,ABOVE ,OPLAIN>>
		<TELL 
"\"Speak not that Name!\" growls an Implementor, polishing a thunderbolt." CR>
		<RTRUE>)
	       (<IS? ,GOBLET ,NEUTRALIZED>
		<RFALSE>)
	       (<OR <HERE? IN-SPLENDOR IN-FROON IN-GARDEN APLANE>
		    <IS? ,HERE ,INDOORS>>
		<TELL ,YOU-HEAR "a distant rumble of thunder." CR>
		<RTRUE>)
	       (T
		<KERBLAM>
		<TELL "Lightning forks across the sky." CR>
		<RTRUE>)>>

<OBJECT IMPTAB
	(DESC "table")
	(FLAGS NODESC SURFACE)
	(SYNONYM TABLE)
	(ADJECTIVE LONG)
	(CAPACITY 100)
	(CONTFCN IMPTAB-F)
	(ACTION IMPTAB-F)>

<ROUTINE IMPTAB-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<SET X <TOUCHING?>>
			      <TELL CTHE ,IMPS " growl at your approach." CR>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT-UNDER PUT-BEHIND>
		       <TELL "There's no room under " THEI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <CLIMBING-ON?>>
		<TELL "\"Stop that,\" growls an Implementor." CR>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND>
		<TELL "The Implementors' legs are there." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ALTAR
	(LOC IN-CHAPEL)
	(DESC "altar")
	(FLAGS NODESC SURFACE)
	(CAPACITY 25)
	(SYNONYM ALTAR TABLE)
	(CONTFCN ALTAR-F)
	(ACTION ALTAR-F)>

<ROUTINE ALTAR-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-CONT>
		       <SET OBJ ,PRSO>
		       <COND (<THIS-PRSI?>
			      <SET OBJ ,PRSI>)>
		       <COND (<ZERO? .OBJ>
			      <RFALSE>)
			     (<AND <IN? ,CLERIC ,IN-CHAPEL>
				   <SET X <TOUCHING?>>>
			      <MAKE ,CLERIC ,SEEN>
			      <TELL "\"Touch not the sacred "
				    D .OBJ "!\" growls " THE ,CLERIC
				    ", standing between you and "
				    THE ,ALTAR ,PERIOD>
			      <CROWD-AGREES>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<AND <IN? ,CLERIC ,IN-CHAPEL>
		     <SET X <TOUCHING?>>>
		<MAKE ,CLERIC ,SEEN>
		<TELL "\"Approach not the sacred altar!\" growls "
		      THE ,CLERIC ,PERIOD>
		<CROWD-AGREES>
		<RTRUE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT-UNDER PUT-BEHIND>
		       <TELL "There's no room there." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT RELIQUARY
	(LOC ALTAR)
	(DESC "reliquary")
	(FLAGS CONTAINER OPENABLE TAKEABLE)
	(CAPACITY 2)
	(SIZE 3)
	(VALUE 2)
	(SYNONYM RELIQUARY CLASP FOLDER)
	(ACTION RELIQUARY-F)>

<ROUTINE RELIQUARY-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT-ON>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<LEATHER>
		<TELL B ,W?FOLDER>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL ". Its metal clasp is open." CR>
		       <RTRUE>)>
		<TELL ", closed with a metal clasp." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LEATHER ()
	 <TELL CTHEO " looks like a leather ">
	 <RFALSE>>

<OBJECT OAK
	(LOC IN-PASTURE)
	(DESC "oak tree")
	(FLAGS VOWEL CONTAINER OPENED)
	(CAPACITY 10)
	(SYNONYM TREE TRUNK OAK ROOTS)
	(ADJECTIVE OAK TREE BARREN)
	(DESCFCN OAK-F)
	(ACTION OAK-F)>

<ROUTINE OAK-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL "A barren " 'OAK2 " looms over your path">
		       <LOOK-UNDER-OAK ,OAK>
		       <RTRUE>)>
		<RFALSE>)>
	 <RETURN <HANDLE-OAKS?>>>

<OBJECT OAK2
	(LOC HILLTOP)
	(DESC "oak tree")
	(FLAGS VOWEL CONTAINER OPENED)
	(SYNONYM OAK TREE ROOTS)
	(ADJECTIVE OAK STUNTED)
	(DESCFCN OAK2-F)
	(ACTION OAK2-F)>

<ROUTINE OAK2-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL "A stunted " 'OAK2 " shades the inland road">
		       <LOOK-UNDER-OAK ,OAK2>
		       <RTRUE>)>
		<RFALSE>)>
	 <RETURN <HANDLE-OAKS?>>>

<OBJECT OAK3
	(LOC TWILIGHT)
	(DESC "oak tree")
	(FLAGS NODESC VOWEL CONTAINER OPENED)
	(SYNONYM OAK TREE ROOTS)
	(ADJECTIVE OAK)
	(ACTION HANDLE-OAKS?)>

<ROUTINE HANDLE-OAKS? ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-UNDER>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (<VERB? PUT-BEHIND>
		       <WINDOW ,SHOWING-ALL>
		       <MOVE ,PRSO ,PRSI>
		       <TELL "You drop " THEO " behind " THEI ,PERIOD>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <TELL CTHEO " tumbles out of " THEI ,AND>
		       <FALLS>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? OPEN OPEN-WITH CLOSE REACH-IN EMPTY>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "Its gnarled roots cover " THE ,GROUND
		      " at your feet">
		<LOOK-UNDER-OAK ,PRSO>
		<CRLF>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND LOOK LOOK-UNDER SEARCH LOOK-INSIDE>
		<COND (<SET X <FIRST? ,PRSO>>
		       <PEERING-BEHIND>
		       <RTRUE>)>
		<TELL ,YOU-SEE "nothing " <PICK-NEXT ,YAWNS>
		      " anywhere under " THEO ,PERIOD>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<CLIMB-A-TREE>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<EXIT-A-TREE>
		<RTRUE>)
	       (<VERB? STAND-UNDER>
		<TELL ,ALREADY "under " THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? DIG-UNDER>
		<TELL "You poke around under " THEO>
		<COND (<IS? ,PRSO ,TOUCHED>
		       <TELL " a bit more">
		       <PRINT ", but turn up nothing of interest.|">
		       <RTRUE>)
		      (<NOT <PRSI? SPADE>>
		       <TELL 
", but " THEI " makes a poor digging tool amid the tangled roots." CR>
		       <RTRUE>)
		      (<LOC ,TRUFFLE>
		       <TELL ,WITH THEI>
		       <PRINT ", but turn up nothing of interest.|">
		       <RTRUE>)>
		<OAK-FIND ,PRSO>
		<TELL ", and soon turn up " A ,TRUFFLE ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-UNDER-OAK (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 <COND (<SET OBJ <FIRST? .OBJ>>
		<PRINT ". There seems to be something ">
		<TELL "behind it">)>
	 <TELL C ,PER>
	 <RFALSE>>

<ROUTINE EXIT-A-TREE ()
	 <TELL "You're not in the tree." CR>
	 <RFALSE>>

<ROUTINE CLIMB-A-TREE ()
	 <COND (<HERE? IN-PASTURE>
		<TELL "The windswept oak">
		<PRINT " offers no good footholds.|">
		<RFALSE>)>
	 <TELL 
"You clamber onto a convenient branch, but an ominous creak sends you scurrying back down." CR>
	 <RFALSE>>

<ROUTINE OAK-FIND (OBJ)
	 <MAKE .OBJ ,TOUCHED>
	 <MOVE ,TRUFFLE <LOC .OBJ>>
	 <UNMAKE ,TRUFFLE ,MUNGED>
	 <SETG TRUFFLE-TIMER ,INIT-TRUFFLE>
	 <QUEUE ,I-TRUFFLE>
	 <WINDOW ,SHOWING-ROOM>
	 <SETG P-IT-OBJECT ,TRUFFLE>
	 <UNMAKE ,MINX ,SEEN>
	 <RFALSE>>

<OBJECT TRUFFLE
	(DESC "chocolate truffle")
	(FLAGS TAKEABLE)
	(SYNONYM TRUFFLE CANDY CHOCOLATE)
	(ADJECTIVE CHOCOLATE BROWN GRAY GREY)
	(SIZE 1)
	(VALUE 5)
	(ACTION TRUFFLE-F)>

<ROUTINE TRUFFLE-F ("AUX" (FRESH 0) X WRD)
	 <COND (<OR <IS? ,TRUFFLE ,MUNGED>
		    <G? ,TRUFFLE-TIMER 40>>
		<INC FRESH>)>
	 <SET WRD ,W?GRAY>
	 <COND (<SEE-COLOR?>
		<SET WRD ,W?BROWN>
		<COND (<ADJ-USED? ,W?GRAY ,W?GREY>
		       <TELL CTHE ,TRUFFLE " is brown, not gray." CR>
		       <RFATAL>)>)>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO ,SIS>
		<COND (<T? .FRESH>)
		      (<L? ,TRUFFLE-TIMER 11>
		       <TELL "almost too runny to be edible." CR>
		       <RTRUE>)
		      (<L? ,TRUFFLE-TIMER 31>
		       <TELL "getting a bit runny. Still edible, though." CR>
		       <RTRUE>)>
		<TELL "dark " B .WRD " in color, ">
		<COND (<T? .FRESH>
		       <TELL "and looks fresh from the harvest." CR>
		       <RTRUE>)>
		<TELL "with only a trace of runniness." CR>
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<VANISH>
		<TELL "Gulp! Sure was yummy">
		<COND (<T? .FRESH>
		       <TELL ". Fresh-tasting, too">)>
		<TELL ,PERIOD>
		<COND (<AND <IS? ,MINX ,LIVING>
		    	    <VISIBLE? ,MINX>>
		       <MAKE ,MINX ,SEEN>
		       <TELL ,TAB CTHE ,MINX
			     " mews with disappointment." CR>
		       <UPDATE-STAT -1 ,COMPASSION T>)>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "Mmm! Smells ">
		<COND (<T? .FRESH>
		       <TELL "delightfully fresh and ">)>
		<TELL "yummy." CR>
		<RTRUE>)
	       (<VERB? WHAT WHERE FIND>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<OBJECT CASTLE
	(LOC LOCAL-GLOBALS)
	(DESC "castle")
	(FLAGS NODESC PLACE)
	(SYNONYM CASTLE PALACE TOWER TOWERS)
	(ACTION CASTLE-F)>

<ROUTINE CASTLE-F ("AUX" X)
	 <COND (<HERE? IN-GARDEN>
		<RETURN <HERE-F>>)
	       (<VERB? EXAMINE LOOK-BEHIND>
		<TELL "The distant " 'PRSO
		      " is shrouded in mountain mist." CR>
		<RTRUE>)
	       (<OR <VERB? LOOK-INSIDE SEARCH>
		    <SET X <TOUCHING?>>
		    <SET X <ENTERING?>>>
		<TELL CTHEO " is quite inaccessible from here." CR>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GARDEN
	(LOC IN-GARDEN)
	(DESC "garden")
	(FLAGS NODESC PLACE)
	(SYNONYM GARDEN)
	(ADJECTIVE PRIVATE)
	(ACTION HERE-F)>

<OBJECT BUSH
	(LOC IN-GARDEN)
	(DESC "morgia bush")
	(FLAGS VEHICLE CONTAINER OPENED)
	(SYNONYM BUSH BUSHES THORN THORNS ROOTS ROOT)
	(ADJECTIVE MORGIA)
	(CAPACITY 200)
	(GENERIC GENERIC-MORGIA-F)
	(ACTION BUSH-F)>

<ROUTINE BUSH-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-BEG>
		       <SET OBJ ,PRSO>
		       <COND (<THIS-PRSI?>
			      <SET OBJ ,PRSI>)>
		       <COND (<CANT-REACH-WHILE-IN? .OBJ ,BUSH>
			      <RFATAL>)
			     (<AND <IN? ,QUEEN ,IN-GARDEN>
				   <SET X <TALKING?>>>
			      <APPROACH-QUEEN "at the sound of your voice">
			      <RFATAL>)>
		       <RFALSE>)
		      (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL
"The air is filled with the fragrance of a nearby " 'BUSH C ,PER>
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-UNDER PUT-BEHIND>
		       <COND (<IN? ,PLAYER ,PRSI>
			      <PERFORM ,V?DROP ,PRSO>
			      <RTRUE>)
			     (<PRSO? ROOT>
			      <PRSO-SLIDES-OFF-PRSI>
			      <RTRUE>)>
		       <MOVE ,PRSO ,PRSI>
		       <WINDOW ,SHOWING-ALL>
		       <TELL CTHEO " disappears behind " THEI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<COND (<IN? ,PLAYER ,PRSO>
		       <V-LOOK>
		       <RTRUE>)>
		<TELL "The thorny " 'PRSO 
" has thrust its roots deep into the soil beside the castle wall." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-BEHIND LOOK-UNDER SEARCH>
		<COND (<NOT <IN? ,PLAYER ,PRSO>>
		       <PEERING-BEHIND>
		       <RTRUE>)>
		<ASIDE-FROM>
		<CONTENTS>
		<SETG P-IT-OBJECT ,PRSO>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? ENTER WALK-TO THROUGH WALK-AROUND STAND-UNDER>
		<ENTER-BUSH>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<TELL "Ouch! ">
		<NO-FOOTHOLDS>
		<RTRUE>)
	       (<VERB? TAKE PICK UPROOT LOOSEN PULL RAISE TOUCH SQUEEZE>
		<COND (<VERB? TOUCH SQUEEZE>)
		      (<AND <IS? ,ROOT ,NODESC>
			    <IN? ,ROOT ,PRSO>>
		       <PICK-ROOT>
		       <RTRUE>)>
		<TELL "You prick your finger on a thorn. Ouch!" CR>
		<UPDATE-STAT -2>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<EXIT-BUSH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NO-FOOTHOLDS ()
	 <TELL CTHEO " has no good footholds." CR>
	 <RTRUE>>

<ROUTINE ENTER-BUSH ()
	 <COND (<IN? ,PLAYER ,BUSH>
		<TELL "Ouch! " ,CANT "go in any farther." CR>
		<RFALSE>)>
	 <DO-THORNS ,BUSH>
	 <RFALSE>>
	
<ROUTINE DO-THORNS (DEST)
	 <SETG OLD-HERE <>>
	 <SETG P-WALK-DIR <>>
	 <WINDOW ,SHOWING-ROOM>
	 <TELL "Ouch! ">
	 <PRINT "You push your way ">
	 <COND (<IN? ,PLAYER ,BUSH>
		<TELL "out of">)
	       (T
		<TELL B ,W?BEHIND>)>
	 <TELL " the thorns." CR>
	 <MOVE ,PLAYER .DEST>
	 <COND (<OR <ZERO? ,DMODE>
		    <EQUAL? ,PRIOR ,SHOWING-INV ,SHOWING-STATS>>
		<RELOOK T>)>
	 <RTRUE>>

<ROUTINE EXIT-BUSH ()
	 <COND (<NOT <IN? ,PLAYER ,BUSH>>
		<TELL "You're not behind " THE ,BUSH ,PERIOD>
	        <RFALSE>)>
	 <DO-THORNS ,IN-GARDEN>
	 <COND (<IN? ,QUEEN ,IN-GARDEN>
		<TELL ,TAB>
		<QUEEN-SEES-YOU>)>
	 <RFALSE>>
		       
<OBJECT ROOT
	(LOC BUSH)
	(DESC "morgia root")
	(FLAGS NODESC TAKEABLE)
	(SYNONYM ROOT)
	(ADJECTIVE MORGIA)
	(SIZE 1)
	(VALUE 2)
	(GENERIC GENERIC-MORGIA-F)
	(ACTION ROOT-F)>

<ROUTINE ROOT-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? TAKE PICK UPROOT PULL LOOSEN RAISE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<PICK-ROOT>
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)>
		<TELL "You gnaw thoughtfully on " THEO ", ">
		<COND (<IS? ,PRSO ,NEUTRALIZED>)
		      (<NOT <IS? ,PRSO ,SEEN>>
		       <MAKE ,PRSO ,SEEN>
		       <TELL 
"and newfound vitality bubbles in your veins." CR>
		       <PUTP ,PRSO ,P?VALUE 0>
		       <SET X </ <GET ,STATS ,STRENGTH> 3>>
		       <COND (<L? .X 1>
			      <SET X 1>)>
		       <UPDATE-STAT .X ,STRENGTH T>
		       <RTRUE>)>
		<TELL "but its virtue appears to be ">
		<COND (<IS? ,PRSO ,SEEN>
		       <TELL "spent." CR>
		       <RTRUE>)>
		<TELL "neutralized." CR>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? PLANT>
		<DO-PLANT>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE GENERIC-MORGIA-F (TBL "OPT" (LEN <GET .TBL 0>))
	 <RETURN ,ROOT>>
		
<ROUTINE PICK-ROOT ()
	 <COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		<PRSI-FUMBLE ,BUSH>
		<RTRUE>)>
	 <WINDOW ,SHOWING-INV>
	 <SETG P-IT-OBJECT ,ROOT>
	 <MOVE ,ROOT ,PLAYER>
	 <UNMAKE ,ROOT ,NODESC>
	 <MAKE ,ROOT ,TOUCHED>
	 <TELL "Reaching carefully to avoid the thorns, you yank a loose root out from under " THE ,BUSH ,PERIOD>
	 <RTRUE>>

<OBJECT BROG
	(LOC IN-GARDEN)
	(DESC "statue")
	(FLAGS NODESC TRYTAKE NOALL)
	(CAPACITY 2)
	(SYNONYM STATUE BROGMOID ERNIE ZZZP)
	(ADJECTIVE BROGMOID ZZZP)
	(CONTFCN BROG-F)
	(ACTION BROG-F)>

<VOC "COMPARTMENT" NOUN>

<ROUTINE BROG-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<IS? ,BROG ,OPENED>)
			     (<OR <T? ,PRSO>
				  <T? ,PRSI>>
			      <TELL ,CANT "see that here." CR>
			      <RFATAL>)>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<IS? ,PRSO ,CONTAINER>
		       <RFALSE>)
		      (<VERB? PUT EMPTY-INTO>
		       <NO-BROG-OPENINGS>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE SEARCH>
		<TELL CTHEO 
" is a full head taller than you, but not as ugly">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL ". Its secret compartment is still open">)
		      (<IS? ,PRSO ,CONTAINER>
		       <TELL 
". Looking closely, you can trace the outlines of a secret compartment">)>
		<TELL ,PERIOD>
		<RTRUE>)	
	       (<VERB? WALK-AROUND LOOK-BEHIND>
		<TELL "You circle " THEO ", but find no">
		<COND (<EQUAL? ,P-PRSA-WORD ,W?HIDE>
		       <TELL " good places to hide." CR>
		       <RTRUE>)>
		<TELL "thing " <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<TELL CTHEO>
		<PRINT " offers no good footholds.|">
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<NOT-ON>
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE OPEN OPEN-WITH CLOSE EMPTY>
		<NO-BROG-OPENINGS>
		<RTRUE>)
	       (T
		<RFALSE>)>>		       
		       
<ROUTINE NO-BROG-OPENINGS ()
	 <TELL CTHE ,BROG " has no obvious openings." CR>
	 <RTRUE>>

<OBJECT RUG
	(LOC IN-PUB)
	(DESC "bearskin rug")
	(FLAGS TAKEABLE SURFACE VEHICLE)
	(SYNONYM RUG CARPET BEARSKIN SKIN)
	(ADJECTIVE BEARSKIN BEAR SKIN)
	(SIZE 15)
	(CAPACITY 15)
	(VALUE 2)
	(DESCFCN RUG-F)
	(ACTION RUG-F)>

<ROUTINE RUG-F ("OPT" (CONTEXT <>) "AUX" X L)
	 <SET L <LOC ,RUG>>
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA ,RUG>
		<PRINT " is lying across ">
		<TELL ,LTHE>
		<GROUND-WORD>
		<COND (<SEE-ANYTHING-IN? ,RUG>
		       <PRINT ". On it you see ">
		       <CONTENTS ,RUG>
		       <SETG P-IT-OBJECT ,PRSO>)>
		<TELL C ,PER>
		<RTRUE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? TOUCH-TO>
		       <TOUCH-RUG-WITH ,PRSO>
		       <RTRUE>)
		      (<VERB? PUT>
		       <PERFORM ,V?PUT-ON ,PRSO ,PRSI>
		       <RTRUE>)
		      (<VERB? PUT-UNDER PUT-BEHIND>
		       <COND (<PRSI? PRSO>
			      <IMPOSSIBLE>
			      <RTRUE>)
			     (<GOT-RUG?>
			      <RTRUE>)>
		       <STASH ,UNDERUG>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO>
		<COND (<IN? ,PLAYER ,PRSO>
		       <TELL " on which you stand">)>
		<TELL " is dreadfully old and ratty">
		<COND (<SEE-ANYTHING-IN?>
		       <PRINT ". On it you see ">
		       <CONTENTS>
		       <SETG P-IT-OBJECT ,PRSO>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? SEARCH LOOK-INSIDE LOOK-ON>
		<COND (<IN? ,PLAYER ,PRSO>
		       <ASIDE-FROM>)
		      (T
		       <TELL ,YOU-SEE>)>
		<CONTENTS>
		<TELL ,SON THEO>
		<COND (<AND <VERB? SEARCH>
			    <SET X <FIRST? ,UNDERUG>>>
		       <TELL ". ">
		       <COND (<IN? ,PLAYER ,PRSO>
			      <FEEL-UNDER-RUG>
			      <RTRUE>)>
		       <TELL "Peering underneath, you find ">
		       <CONTENTS ,UNDERUG>)>
		<SETG P-IT-OBJECT ,PRSO>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND>
		<TELL ,YOU-SEE>
		<CONTENTS ,UNDERUG>
		<SETG P-IT-OBJECT ,PRSO>
		<TELL " under " THE ,UNDERUG ,PERIOD>
		<RTRUE>)
	       (<VERB? WEAR STAND-UNDER ENTER THROUGH SMELL>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?LAY>
		       <LIE-ON-RUG>
		       <RTRUE>)
		      (<NOT <EQUAL? .L ,PLAYER <LOC ,PLAYER>>>
		       <TAKE-FIRST ,PRSO .L>
		       <RTRUE>)
		      (<NOT <VERB? SMELL>>
		       <TELL "You duck under ">
		       <PRINT 
"the rug for a moment, but the smell quickly drives you ">
		       <TELL "out. ">)>
		<TELL "Phew!" CR>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<ITAKE>
		       <MOVE-ALL ,UNDERUG .L>
		       <WINDOW ,SHOWING-ALL>
		       <TELL "You lift " THEO>
		       <OUT-OF-LOC .L>
		       <TELL ,PERIOD>)>
		<RTRUE>)
	       (<VERB? TOUCH>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?RUB ,W?PET ,W?PAT>
		       <TOUCH-RUG-WITH ,HANDS>
		       <RTRUE>)>
		<FEEL-RUG>
		<RTRUE>)
	       (<VERB? STAND-ON CLIMB-ON SIT LIE-DOWN RIDE>
		<COND (<IN? ,PLAYER ,PRSO>
		       <TELL ,ALREADY "on it." CR>
		       <RTRUE>)
		      (<GOT-RUG?>
		       <RTRUE>)
		      (<NOT <EQUAL? .L ,HERE>>
		       <TAKE-FIRST ,PRSO .L>
		       <RTRUE>)
		      (<VERB? SIT LIE-DOWN>
		       <LIE-ON-RUG>
		       <RTRUE>)>
		<MOVE ,PLAYER ,RUG>
		<WINDOW ,SHOWING-ALL>
		<SETG P-WALK-DIR <>>
		<TELL "You step onto " THEO>
		<RELOOK>
		<RTRUE>)
	       (<VERB? EXIT LEAVE ESCAPE>
		<COND (<NOT <IN? ,PLAYER ,PRSO>>
		       <NOT-ON>
		       <RTRUE>)>
		<MOVE ,PLAYER .L>
		<WINDOW ,SHOWING-ALL>
		<SETG P-WALK-DIR <>>
		<TELL "You step off " THEO>
		<RELOOK>
		<DO-CHARGE?>
		<RFATAL>)
	       (<VERB? CROSS>
		<TELL "You walk across " THEO ,PERIOD>
		<DO-CHARGE?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LIE-ON-RUG ()
	 <TELL "You sprawl onto ">
	 <PRINT 
"the rug for a moment, but the smell quickly drives you ">
	 <TELL "off. Phew!" CR>
	 <RTRUE>>

<ROUTINE FEEL-RUG ("AUX" X)
	 <COND (<SET X <FIRST? ,UNDERUG>>
		<FEEL-UNDER-RUG>
		<RTRUE>)>
	 <TELL "It feels soft and hairy." CR>
	 <RTRUE>>

<ROUTINE FEEL-UNDER-RUG ()
	 <TELL "It feels as if there's something underneath." CR>
	 <RTRUE>>

<ROUTINE TOUCH-RUG-WITH (OBJ)
	 <TELL "You rub " THE .OBJ " against the rug">
	 <COND (<EQUAL? .OBJ ,HANDS ,FEET>
		<TELL ". ">
		<FEEL-RUG>)
	       (T
		<TELL ,PERIOD>)>
	 <COND (<IS? .OBJ ,FERRIC>
		<RFALSE>)>
	 <DO-CHARGE?>
	 <RTRUE>>
	 
<GLOBAL STATIC:NUMBER 0>

<ROUTINE DO-CHARGE? ()
	 <COND (<HERE? ON-BRIDGE>
		<RFALSE>)>
	 <TELL ,TAB "You feel ">
	 <COND (<ZERO? ,STATIC>
		<TELL "the hairs on the back of your neck stand on end">)
	       (T
		<TELL "your body hair tingle again">)>
	 <TELL ,PERIOD>
	 <COND (<IGRTR? STATIC <GET ,STATS ,ENDURANCE>>
		<TELL ,TAB>
		<ITALICIZE "Zap">
		<TELL 
"! The built-up static potential in your body discharges in a deadly flash">
		<JIGS-UP>)
	       (<IN? ,DUST ,HERE>
		<TELL ,TAB CTHE ,DUST " crackle">
		<COND (<NOT <IS? ,DUST ,PLURAL>>
		       <TELL "s">)>
		<TELL " uneasily." CR>)>
	 <RTRUE>>

<ROUTINE GOT-RUG? ()
	 <COND (<OR <IN? ,RUG ,PLAYER>
		    <IN? <LOC ,RUG> ,PLAYER>>
		<YOUD-HAVE-TO "put down" ,RUG>
		<RTRUE>)>
	 <RFALSE>>

<OBJECT UNDERUG
	(LOC RUG)
	(DESC "rug")
	(FLAGS NODESC TRYTAKE NOALL SURFACE)
	(CONTFCN UNDERUG-F)>

<ROUTINE UNDERUG-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<EQUAL? .CONTEXT ,M-CONT>
		<SET OBJ ,PRSO>
		<COND (<THIS-PRSI?>
		       <SET OBJ ,PRSI>)>
		<COND (<ZERO? .OBJ>
		       <RFALSE>)
		      (<VERB? TAKE>
		       <RFALSE>)
		      (<SET X <SEEING?>>
		       <TELL "That'd be easier if you took ">)
		      (T
		       <PRINT "You'd have to get ">)>
		<TELL THE .OBJ " out from under " THE ,UNDERUG ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RING
	(DESC "ring")
	(SDESC DESCRIBE-RING)
	(FLAGS TAKEABLE CLOTHING)
	(SYNONYM RING SHIELDING)
	(ADJECTIVE SHIELDING)
	(SIZE 0)
	(VALUE 50)
	(ACTION RING-F)>


<ROUTINE RING-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<O-WEARING>
		<TELL 
" is encircled with a pattern of curly lines resembling tongues of flame." CR>
		<RTRUE>)
	       (<AND <VERB? WEAR>
		     <NOT <IS? ,PRSO ,WORN>>>
		<COND (<DONT-HAVE?>
		       <RTRUE>)>
		<MAKE ,PRSO ,WORN>
		<WINDOW ,SHOWING-INV>
		<TELL "A chill passes through your body as you slip "
		      THEO " onto your finger." CR>
		<RTRUE>)
	       (<AND <VERB? TAKE-OFF>
		     <IS? ,PRSO ,WORN>>
		<COND (<HOTFOOT?>
		       <RTRUE>)>
		<UNMAKE ,PRSO ,WORN>
		<WINDOW ,SHOWING-INV>
		<TELL "You slip " THEO " off your finger." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WOODS
	(LOC LOCAL-GLOBALS)
	(DESC "forest")
	(FLAGS NODESC PLACE)
	(SYNONYM FOREST WOODS TREES TREE)
	(ACTION HERE-F)>

<OBJECT TRACKS
	(DESC "footprints")
	(FLAGS TRYTAKE NOALL SURFACE PLURAL)
	(SYNONYM FOOTPRINTS PRINTS TRACKS TRACK TRAIL)
	(ADJECTIVE FOOT)
	(DESCFCN TRACKS-F)
	(ACTION TRACKS-F)>

<ROUTINE TRACKS-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL "Tiny " 'TRACKS
			     " are visible in the snow.">
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<AND <VERB? TOUCH-TO>
			    <EQUAL? ,P-PRSA-WORD ,W?RUB>>
		       <RUBOUT-TRACKS ,PRSO>
		       <RTRUE>)
		      (<VERB? PUT-ON EMPTY-INTO>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE READ LOOK-ON FOLLOW>
		<TELL CTHEO " lead behind " THE ,OAK ,PERIOD>
		<RTRUE>)
	       (<VERB? CLEAN-OFF>
		<COND (<OR <EQUAL? ,PRSI <> ,GROUND ,ROOMS>
			   <EQUAL? ,PRSI ,SNOW>>
		       <RUBOUT-TRACKS>
		       <RTRUE>)>
		<TELL CTHEO " aren't on " THEI ,PERIOD>
		<RTRUE>)
	       (<VERB? ERASE-WITH HIDE KICK TAKE-OFF MUNG CLEAN>		
		<RUBOUT-TRACKS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE RUBOUT-TRACKS ("OPT" OBJ)
	 <REMOVE ,TRACKS>
	 <SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>
	 <WINDOW ,SHOWING-ROOM>
	 <TELL "You obliterate all trace of " THE ,TRACKS>
	 <COND (<T? .OBJ>
		<TELL ,WITH THE .OBJ>)>
	 <TELL ,PERIOD>
	 <UPDATE-STAT 15 ,COMPASSION T>
	 <RTRUE>>

<OBJECT GURTH
	(LOC LOCAL-GLOBALS)
	(DESC "Gurth")
	(FLAGS NODESC NOARTICLE PROPER PLACE)
	(SYNONYM GURTH CITY)
	(ADJECTIVE GURTH)
	(ACTION GURTH-F)>

<ROUTINE GURTH-F ("AUX" X)
	 <COND (<HERE? IN-GURTH AT-MAGICK IN-MAGICK>
		<RETURN <HERE-F>>)
	       (<SET X <ENTERING?>>
		<SET X ,P?SW>
		<COND (<HERE? XROADS>
		       <SET X ,P?NORTH>)>
		<DO-WALK .X>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CELLAR
	(LOC LOCAL-GLOBALS)
	(DESC "wine cellar")
	(FLAGS NODESC PLACE)
	(SYNONYM CELLAR BASEMENT)
	(ADJECTIVE WINE)
	(ACTION CELLAR-F)>

<ROUTINE CELLAR-F ("AUX" X)
	 <SET X <GETB ,CELLAR-ROOMS 0>>
	 <COND (<OR <SET X <INTBL? ,HERE <REST ,CELLAR-ROOMS 1> .X 1>>
		    <HERE? BARRELTOP>>
		<RETURN <HERE-F>>)
	       (<OR <SET X <ENTERING?>>
		    <VERB? CLIMB-DOWN>>
		<COND (<HERE? IN-KITCHEN>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SPADE
	(LOC GHOUL)
	(DESC "spade")
	(SDESC DESCRIBE-SPADE)
	(FLAGS TAKEABLE WEAPON NAMEABLE)
	(SYNONYM SPADE ZZZP SHOVEL)
	(SIZE 6)
	(EFFECT 50)
	(VALUE 2)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(ACTION SPADE-F)>


<ROUTINE SPADE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is worn but serviceable." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PHEEBOR
	(LOC LOCAL-GLOBALS)
	(DESC "ruins")
	(FLAGS NODESC PLACE PLURAL)
	(SYNONYM RUINS PHEEBOR CITY)
	(ACTION HERE-F)>

<OBJECT GLASS
        (LOC MCASE)
	(DESC "hourglass")
	(FLAGS VOWEL TAKEABLE CONTAINER)
	(CAPACITY 0)
	(SIZE 2)
	(VALUE 1000)
	(SYNONYM HOURGLASS GLASS SAND TIME)
	(ADJECTIVE HOUR MINIATURE TINY)
	(ACTION GLASS-F)>
	       
<GLOBAL GLASS-BOT:NUMBER ,FULL>
<GLOBAL GLASS-TOP:NUMBER 0>

<ROUTINE GLASS-F ("AUX" X)
	 <COND (<NOUN-USED? ,W?SAND>
		<COND (<VERB? SHAKE>)
		      (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		       <TELL "The sand in " THEO ,SIS>
		       <COND (<T? ,GLASS-TOP>
			      <TELL "falling in a steady trickle." CR>
			      <RTRUE>)>
		       <TELL "exceptionally fine." CR>
		       <RTRUE>)
		      (<TOUCHING?>
		       <TELL ,CANT "reach the sand. ">
		       <ITS-SEALED ,GLASS>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO>
		       <ITS-SEALED ,GLASS>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? OPEN OPEN-WITH REACH-IN CLOSE>
		<ITS-SEALED ,GLASS>
		<RTRUE>)
	       (<VERB? SHAKE>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)>
		<TELL "You give the ">
		<COND (<T? ,GLASS-TOP>
		       <TELL "trickling sand in the ">)>
		<TELL 'GLASS " a vigorous shake." CR>
		<COND (<ZERO? ,GLASS-TOP>
		       <QUEUE ,I-GLASS>
		       <ARCH-ON>)>
		<PROG ()
		   <SET X <RANDOM %<- ,FULL 1>>>
		   <COND (<EQUAL? .X ,GLASS-TOP>
			  <AGAIN>)>>
		<SETG GLASS-TOP .X>
		<SETG GLASS-BOT <- 0 <- .X ,FULL>>>
	        <RTRUE>)
	       (<VERB? TURN SPIN>
		<COND (<OR <VERB? SPIN>
			   <EQUAL? ,PRSI <> ,HANDS>>
		       <COND (<NOT <IN? ,PRSO ,PLAYER>>
			      <YOUD-HAVE-TO "be holding">
			      <RTRUE>)>
		       <TELL "You turn over " THEO
			     ", and watch as the sand ">
		       <COND (<ZERO? ,GLASS-TOP>
			      <SETG GLASS-TOP ,FULL>
			      <SETG GLASS-BOT 0>
			      <QUEUE ,I-GLASS>
			      <TELL 
"begins to fall in a slow, steady trickle." CR>
			      <ARCH-ON>
			      <RTRUE>)>
		       <TELL "reverses " 'INTDIR 
			     " and resumes its steady trickle." CR>
		       <SET X ,GLASS-TOP>
		       <SETG GLASS-TOP ,GLASS-BOT>
		       <SETG GLASS-BOT .X>
		       <RTRUE>)>
		<TELL ,DONT "need " THEI ,STO 
		      B ,P-PRSA-WORD C ,SP THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL "The miniature " 'GLASS
		      " is wrought of brass and crystal">
		<COND (<T? ,GLASS-TOP>
		       <TELL 
". Fine, white sand is falling through it in a steady trickle." CR>
		       <RTRUE>)>
		<TELL ", and filled with fine, white sand." CR>
		<RTRUE>)
	       (<AND <VERB? LAMP-OFF>
		     <EQUAL? ,P-PRSA-WORD ,W?STOP ,W?HALT>>
		<COND (<ZERO? ,GLASS-TOP>
		       <TELL "The sand in " THEO
			     " isn't trickling" ,AT-MOMENT>
		       <RTRUE>)>
		<TELL "Patience. It'll stop eventually." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ITS-SEALED (OBJ)
	 <TELL CTHE .OBJ " is permanently sealed." CR>
	 <RTRUE>>

<OBJECT SCABBARD
	(LOC WCASE)
	(DESC "silver scabbard")
	(SDESC DESCRIBE-SCABBARD)
	(FLAGS TAKEABLE CONTAINER OPENED CLOTHING FERRIC)
	(SYNONYM SCABBARD SHEATH GRUESLAYER)
	(ADJECTIVE SILVER)
	(SIZE 4)
	(CAPACITY 4)
	(VALUE 80)
	(ACTION SCABBARD-F)>
	 

<ROUTINE SCABBARD-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO>
		       <TELL CTHEO>
		       <COND (<PRSO? SWORD>
			      <TELL " seems oddly reluctant to enter ">)
			     (<G? <GETP ,PRSO ,P?SIZE> 2>
			      <TELL " won't fit in ">)
			     (T
			      <TELL " would just fall through ">)>
		       <TELL THEI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"Only the mightiest blade could be worthy of such a sheath." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RFOOT
	(LOC MCASE)
	(DESC "rabbit's foot")
	(FLAGS TAKEABLE)
	(SYNONYM FOOT)
	(ADJECTIVE RABBIT\'S RABBIT)
	(SIZE 2)
	(VALUE 5)
	(DNUM 3)
	(ACTION RFOOT-F)>

<ROUTINE RFOOT-F ()
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? TOUCH-TO>
			    <PRSO? HANDS ME>>
		       <RUB-RFOOT>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "Poor wittle bunny wabbit. Sniff." CR>
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<TELL "Gross." CR>
		<RTRUE>)
	       (<AND <VERB? TOUCH>
		     <EQUAL? ,P-PRSA-WORD ,W?RUB>>
		<RUB-RFOOT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE RUB-RFOOT ()
	 <TELL "You run a finger across " THE ,RFOOT ,PERIOD>
	 <COND (<OR <IS? ,RFOOT ,MUNGED>
		    <IS? ,RFOOT ,NEUTRALIZED>>
		<RTRUE>)>
	 <MAKE ,RFOOT ,MUNGED>
	 <UPDATE-STAT 10 ,LUCK T>
	 <RTRUE>>

<OBJECT CLOVER
	(DESC "four-leaf clover")
	(FLAGS TAKEABLE)
	(SYNONYM CLOVER LEAVES)
	(ADJECTIVE FOUR\-LEAF FOUR LEAF)
	(SIZE 0)
	(VALUE 5)
	(DNUM 3)
	(DESCFCN CLOVER-F)
	(ACTION CLOVER-F)>

<ROUTINE CLOVER-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,CLOVER " is growing at your feet.">
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"Aside from its four leaves, the clover">
		<PRINT " seems ordinary enough.|">
		<RTRUE>)
	       (<FIRST-TAKE?>
		<RTRUE>)
	       (<AND <VERB? COUNT>
		     <NOUN-USED? ,W?LEAVES>>
		<TELL "One. Two. Three. Four. Satisfied?" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SHOE
	(LOC IN-STABLE)
	(DESC "old horseshoe")
	(FLAGS VOWEL TAKEABLE FERRIC)
	(SYNONYM SHOE HORSESHOE)
	(ADJECTIVE HORSE)
	(SIZE 3)
	(VALUE 2)
	(DNUM 3)
	(DESCFCN SHOE-F)
	(ACTION SHOE-F)>

<ROUTINE SHOE-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,SHOE>
		       <PRINT " lies forgotten in ">
		       <TELL THE ,GCORNER C ,PER>
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<FIRST-TAKE?>
		<RTRUE>)
	       (<VERB? WEAR>
		<TELL "No." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>


<OBJECT DIAMOND
	(DESC "small diamond")
	(FLAGS TAKEABLE)
        (SDESC DESCRIBE-DIAMOND)
	(SYNONYM SNOWFLAKE FLAKE SNOW)
	(ADJECTIVE SMALL)
	(SIZE 0)
	(VALUE 50)
	(DESCFCN DIAMOND-F)
	(ACTION DIAMOND-F)>

<VOC "DIAMOND" NOUN>


<ROUTINE DIAMOND-F ("OPT" (CONTEXT <>) "AUX" X TBL)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,DIAMOND " glitters at your feet.">
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<ITAKE>
		       <TELL CTHEO 
" feels unusually hard as you pick it up. Hard as a diamond, in fact." CR>
		       <PUTP ,PRSO ,P?DESCFCN 0>
		       <PUTP ,PRSO ,P?SDESC 0>
		       <SET TBL <GETPT ,PRSO ,P?SYNONYM>>
		       <PUT .TBL 0 ,W?DIAMOND>
		       <PUT .TBL 1 ,W?GEM>
		       <PUT .TBL 2 ,W?STONE>
		       <WINDOW ,SHOWING-ALL>)>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <TELL CTHEO " glitters invitingly." CR>
		       <RTRUE>)>
		<TELL
"This remarkable gem is fashioned in the likeness of a snowflake." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PARCHMENT
	(DESC "bit of parchment")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE READABLE)
	(SYNONYM ZZZP ZZZP PARCHMENT PAPER BIT PIECE
	 	SCROLL SCROLLS WRITING WORDS)
	(ADJECTIVE ZZZP ZZZP PARCHMENT)
	(SIZE 1)
	(VALUE 5)
	(GENERIC GENERIC-PAPER-F)
	(READIQ 8)
	(NAME-TABLE 0)
	(DESCFCN 0)
	(DNUM 0)
	(EFFECT 0)
	(ACTION HANDLE-SCROLL-F)>

<OBJECT VELLUM
	(DESC "vellum scroll")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE READABLE)
	(SYNONYM ZZZP ZZZP SCROLL SCROLLS WRITING WORDS)
	(ADJECTIVE ZZZP ZZZP VELLUM)
	(SIZE 1)
	(VALUE 5)
	(GENERIC GENERIC-PAPER-F)
	(READIQ 8)
	(NAME-TABLE 0)
	(DESCFCN 0)
	(DNUM 0)
	(EFFECT 0)
	(ACTION HANDLE-SCROLL-F)>

<OBJECT SMOOTH
	(DESC "smooth scroll")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE READABLE)
	(SYNONYM ZZZP ZZZP SCROLL SCROLLS WRITING WORDS)
	(ADJECTIVE ZZZP ZZZP SMOOTH)
	(SIZE 1)
	(VALUE 5)
	(GENERIC GENERIC-PAPER-F)
	(READIQ 8)
	(NAME-TABLE 0)
	(DESCFCN 0)
	(DNUM 0)
	(EFFECT 0)
	(ACTION HANDLE-SCROLL-F)>

<OBJECT RUMPLE
	(DESC "rumpled scroll")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE READABLE)
	(SYNONYM ZZZP ZZZP SCROLL SCROLLS WRITING WORDS)
	(ADJECTIVE ZZZP ZZZP RUMPLED)
	(SIZE 1)
	(VALUE 5)
	(GENERIC GENERIC-PAPER-F)
	(READIQ 8)
	(NAME-TABLE 0)
	(DESCFCN 0)
	(DNUM 0)
	(EFFECT 0)
	(ACTION HANDLE-SCROLL-F)>

<OBJECT GILT
	(DESC "gilt-edged scroll")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE READABLE)
	(SYNONYM ZZZP ZZZP GILT\-EDGE SCROLL SCROLLS WRITING WORDS)
	(ADJECTIVE ZZZP ZZZP GILT\-EDGE GILT EDGED)
	(SIZE 1)
	(VALUE 5)
	(GENERIC GENERIC-PAPER-F)
	(READIQ 8)
	(NAME-TABLE 0)
	(DESCFCN 0)
	(DNUM 0)
	(EFFECT 0)
	(ACTION HANDLE-SCROLL-F)>       

<ROUTINE HANDLE-SCROLL-F ("AUX" X WRD)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON EMPTY-INTO>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)>
	 <SET WRD <GET <GETPT ,PRSO ,P?SYNONYM> 1>>
	 <COND (<AND <VERB? SAY YELL>
		     <NOT <EQUAL? .WRD ,W?ZZZP>>
		     <NOUN-USED? .WRD>>
		<SET X <APPLY <GETP ,PRSO ,P?EFFECT> ,PRSO>>
		<RTRUE>)
	       (<VERB? READ>
		<READ-SCROLL>
		<RTRUE>)
	       (<FIRST-TAKE?>
		<RTRUE>)
	       (<VERB? RIP SQUEEZE>
		<VANISH>
		<ITALICIZE "Poof">
		<TELL "! " CTHEO " evaporates in a flash." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GENERIC-PAPER-F (TBL "OPT" (LEN <GET .TBL 0>))
	 <COND (<SET TBL <INTBL? ,P-IT-OBJECT <REST .TBL 2> .LEN>>
		<RETURN ,P-IT-OBJECT>)>
	 <RFALSE>>

<ROUTINE READ-SCROLL ("AUX" SYNS TBL WRD STAT X)
	 <COND (<NOT <IN? ,PRSO ,PLAYER>>
		<TELL "The writing on " THEO 
" is quite tiny. You'll have to pick it up to read it." CR>
		<RTRUE>)>
	 <SET SYNS <GETPT ,PRSO ,P?SYNONYM>>
	 <SET WRD <GET .SYNS 1>>
	 <COND (<EQUAL? .WRD ,W?ZZZP>
		<SET TBL <PICK-ONE ,MAGIC-WORDS>>
	      ; <COND (<T? <GET .TBL 2>>
		       <SAY-ERROR "MAGIC-WORDS">
		       <RFALSE>)>
		<PUT .TBL 2 1>
		<SET WRD <GET .TBL 0>>
		<PUT .SYNS 1 .WRD>
		<PUT <GETPT ,PRSO ,P?ADJECTIVE> 1 .WRD>
		<PUTP ,PRSO ,P?NAME-TABLE <GET .TBL 1>>)>
	 <TELL "The meaning of " THEO
	       " is obscure. It seems to have something to do with " 
	       <GETP ,PRSO ,P?DNUM> ". ">
	 <SET X <GETP ,PRSO ,P?READIQ>>
	 <SET STAT <GET ,STATS ,INTELLIGENCE>>
	 <COND (<NOT <L? .STAT .X>>
		<PRINT "The word ">
		<COND (<EQUAL? ,HOST ,APPLE-2E ,APPLE-2C ,C128>
		       <TELL "\"">)
		      (T
		       <HLIGHT ,H-ITALIC>)>
		<PRINT-TABLE <GETP ,PRSO ,P?NAME-TABLE>>
		<COND (<EQUAL? ,HOST ,APPLE-2E ,APPLE-2C ,C128>
		       <TELL "\"">)>
		<HLIGHT ,H-NORMAL>
		<TELL ,SIS>)
	       (<ZERO? ,VT220>
		<TELL "Strange, flowing runes are ">)
	       (T
		<TELL "The runes ">
		<RUNE .WRD>
		<TELL " are ">)>
	 <TELL "inscribed across the top">
	 <COND (<L? .STAT .X>
		<TELL 
"; you could probably understand them if you'd studied harder at school">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE RUNE (WRD "AUX" PTR LEN CHAR X)
	 <DIROUT ,D-TABLE-ON ,AUX-TABLE>
	 <PRINTB .WRD>
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <+ <GET ,AUX-TABLE 0> 1>>
	 <SET PTR 2>
	 <REPEAT ()
	    <SET X <FONT ,F-NEWFONT>>
	    <SET CHAR <GETB ,AUX-TABLE .PTR>>
	    <COND (<OR <L? .CHAR %<ASCII !\a>>
		       <G? .CHAR %<ASCII !\z>>>
		   <SET X <FONT ,F-DEFAULT>>)>
	    <PRINTC .CHAR>
	    <COND (<IGRTR? PTR .LEN>
		   <RETURN>)>>
	 <SET X <FONT ,F-DEFAULT>>
	 <RFALSE>>


<ROUTINE DO-PARTAY ("OPT" (OBJ ,PRSO))
	 <COND (<FINE-PRINT? .OBJ>
		<RTRUE>)>
	 <VANISH .OBJ>
	 <ITALICIZE "Poof">
	 <TELL "! " CTHE .OBJ>
	 <PRINT " disappears in a spectral flash">
	 <TELL 
". At the same moment, a housewife in a suburb of Mareilon watches in astonishment as her lawn furniture silently rearranges itself." CR>
	 <RTRUE>>


<ROUTINE DO-BLESS-WEAPON ("OPT" (SCR ,PRSO) "AUX" (CNT 0) OBJ WOBJ X)
	 <COND (<FINE-PRINT? .SCR>
		<RTRUE>)>
	 <VANISH .SCR>
	 <ITALICIZE "Poof">
	 <TELL "! " CTHE .SCR>
	 <PRINT " disappears in a spectral flash">
	 <COND (<SET OBJ <FIRST? ,PLAYER>>
		<REPEAT ()
		   <COND (<AND <IS? .OBJ ,WEAPON>
			       <IS? .OBJ ,WIELDED>>
			  <SET X <GETP .OBJ ,P?EFFECT>>
			  <COND (<T? .X>
				 <INC CNT>
				 <SET WOBJ .OBJ>
				 <PUTP .OBJ ,P?EFFECT
				       <+ .X </ .X 2>>>
				 <SET X <GETP .OBJ ,P?VALUE>>
				 <PUTP .OBJ ,P?VALUE
				       <+ .X </ .X 3>>>)>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <COND (<T? .CNT>
		<TELL ,COMMA-AND>
		<COND (<EQUAL? .CNT 1>
		       <SAY-YOUR .WOBJ>
		       <TELL " flickers">)
		      (T
		       <TELL "your weapons flicker">)>
		<TELL " with newfound power">)>
	 <TELL ,PERIOD>
	 <RTRUE>>


<ROUTINE DO-BLESS-ARMOR ("OPT" (SCR ,PRSO) "AUX" (CNT 0) (NAC 0) OBJ WOBJ X)
	 <COND (<FINE-PRINT? .SCR>
		<RTRUE>)>
	 <VANISH .SCR>
	 <ITALICIZE "Poof">
	 <TELL "! " CTHE .SCR>
	 <PRINT " disappears in a spectral flash">
	 <COND (<SET OBJ <FIRST? ,PLAYER>>
		<REPEAT ()
		   <COND (<IS? .OBJ ,WORN>
			  <SET X <GETP .OBJ ,P?EFFECT>>
			  <COND (<T? .X>
				 <INC CNT>
				 <SET WOBJ .OBJ>
				 <SET X <+ .X </ .X 2>>>
				 <COND (<G? .X ,STATMAX>
					<SET X ,STATMAX>)>
				 <SET NAC <+ .NAC .X>>
				 <PUTP .OBJ ,P?EFFECT .X>
				 <SET X <GETP .OBJ ,P?VALUE>>
				 <PUTP .OBJ ,P?VALUE
				       <+ .X </ .X 3>>>)>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <COND (<T? .CNT>
		<TELL ,COMMA-AND>
		<COND (<EQUAL? .CNT 1>
		       <SAY-YOUR .WOBJ>)
		      (T
		       <TELL "your armor">)>
		<TELL " flickers with newfound ruggedness">)>
	 <TELL ,PERIOD>
	 <COND (<T? .NAC>
		<UPDATE-STAT <- .NAC <GET ,STATS ,AC>> ,AC>)>
	 <RTRUE>>


<ROUTINE DO-FILFRE ("OPT" (OBJ ,PRSO))
	 <COND (<FINE-PRINT? .OBJ>
		<RTRUE>)>
	 <VANISH .OBJ>
	 <V-$CREDITS>
	 <TELL CR "The fireworks fade around you." CR>
	 <RTRUE>>


<ROUTINE DO-GOTO ("OPT" (OBJ ,PRSO))
	 <COND (<FINE-PRINT? .OBJ>
		<RTRUE>)>
	 <VANISH .OBJ>
	 <KERBLAM>
	 <TELL "A searing flash consumes " THE .OBJ
" in an instant, burning its runes upon your retina. Vision soon returns; but " THE ,GWORD " continue to swim before your eyes">
	 <COND (<HERE? ON-BRIDGE IN-SKY OVER-JUNGLE>
		<TELL " until a puff of wind disperses them." CR>
		<RTRUE>)>
	 <PRINT ,PERIOD>
	 <MOVE ,GWORD ,HERE>
	 <SETG P-THEM-OBJECT ,GWORD>
	 <SETG P-IT-OBJECT ,GWORD>
	 <SETG TELEWORD <GET <GETPT .OBJ ,P?SYNONYM> 1>>
	 <PUT <GETPT ,GWORD ,P?SYNONYM> 0 ,TELEWORD>
	 <PUT <GETPT ,GWORD ,P?ADJECTIVE> 0 ,TELEWORD>
         <PUTP ,GWORD ,P?NAME-TABLE <GETP .OBJ ,P?NAME-TABLE>>
	 <PUTP ,GWORD ,P?READIQ <GETP .OBJ ,P?READIQ>>
	 <RTRUE>>

<OBJECT GWORD
	(DESC "glowing runes")
	(FLAGS TRYTAKE NOALL LIGHTED PLURAL)
	(SYNONYM ZZZP WORD RUNE RUNES GLOW)
	(ADJECTIVE ZZZP GLOWING)
	(READIQ 0)
	(NAME-TABLE 0)
	(DESCFCN GWORD-F)
	(ACTION GWORD-F)>

<GLOBAL TELEWORD <>>

<ROUTINE GWORD-F ("OPT" (CONTEXT <>) "AUX" (DUMB 0) TBL X)
	 <SET TBL <GETP ,GWORD ,P?NAME-TABLE>>
	 <SET X <GETP ,GWORD ,P?READIQ>>
	 <COND (<L? <GET ,STATS ,INTELLIGENCE> .X>
		<INC DUMB>)>
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<COND (<ZERO? .DUMB>
		       <PRINT "The word \"">
		       <PRINT-TABLE .TBL>
		       <TELL "\" hangs ">)
		      (T
		       <TELL "Glowing runes hang ">)>
		<TELL "suspended in midair.">
		<RTRUE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<SET X <TOUCHING?>>
		<TELL CTHE ,GWORD " seem">
		<PRINT " to possess no physical substance.|">
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE READ LOOK-ON>
		<TELL ,XTHE>
		<COND (<AND <T? .DUMB>
			    <ZERO? ,VT220>>
		       <TELL "undecipherable ">)>
		<TELL 
"runes swim in your vision like the afterglow of a meteor">
		<COND (<OR <ZERO? .DUMB>
			   <T? ,VT220>>
		       <TELL ", forming the word ">
		       <COND (<ZERO? .DUMB>
			      <HLIGHT ,H-ITALIC>
			      <PRINT-TABLE .TBL>
			      <HLIGHT ,H-NORMAL>)
			     (T
			      <RUNE ,TELEWORD>)>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? SAY YELL>
		     <NOUN-USED? ,TELEWORD>>
		<SAY-TELEWORD>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<TELL CTHEO " recede from your approach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE SAY-TELEWORD ("AUX" L)
	 <SET L <LOC ,GWORD>>
	 <COND (<EQUAL? .L <LOC ,PLAYER>>
		<TELL CTHE ,GWORD " flare with Magick, and you ">
		<PRINT "feel a moment of dizziness">
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <COND (<OR <GRUE-ROOM?>
		    <IN? ,PLAYER ,ARCH>
		    <NOT <EQUAL? ,ATIME ,PRESENT>>
		    <HERE? IN-FROON IN-GARDEN APLANE IN-SPLENDOR>
		    <PLAIN-ROOM?>>
		<TELL ,CYOU>
		<PRINT "feel a moment of dizziness">
		<TELL " as unseen forces struggle for control. ">
		<INFLUENCE>
		<RTRUE>)>
	 <WINDOW ,SHOWING-ROOM>
	 <SETG P-WALK-DIR <>>
	 <SETG OLD-HERE <>>
	 <SAFE-VEHICLE-EXIT>
	 <GOTO .L>
	 <RTRUE>>


<ROUTINE FINE-PRINT? ("OPT" (OBJ ,PRSO))
	 <COND (<NOT <VISIBLE? .OBJ>>
		<PRINT "A hollow voice says, \"Fool!\"">
		<CRLF>
		<RTRUE>)
	       (<NOT <IN? .OBJ ,PLAYER>>
		<SPUTTERS .OBJ>
		<TELL "Perhaps you must hold it to wield its Magick." CR>
		<RTRUE>)
	       (<IS? .OBJ ,NEUTRALIZED>
		<SPUTTERS .OBJ>
		<TELL "Its virtue">
		<PRINT " appears to have been neutralized">
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<NO-MAGIC-HERE? .OBJ>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NEXT-SCROLL? ("OPT" FCN RM "AUX" OBJ)
	 <SET OBJ <PICK-ONE ,SCROLL-LIST>>
         <COND (<IS? .OBJ ,NODESC>
		<UNMAKE .OBJ ,NODESC>
		<INIT-SCROLL .OBJ>
		<COND (<ASSIGNED? FCN>
		       <PUTP .OBJ ,P?DESCFCN .FCN>)>
		<COND (<ASSIGNED? RM>
		       <MOVE .OBJ .RM>)>
		<RETURN .OBJ>)
	       (T
	      ; <SAY-ERROR "NEXT-SCROLL?">
		<RFALSE>)>>

<ROUTINE INIT-SCROLL (OBJ "AUX" TBL X)
	 <SET TBL <PICK-ONE ,SCROLL-FUNCTIONS>>
	 <PUTP .OBJ ,P?EFFECT <GET .TBL 0>>
	 <PUTP .OBJ ,P?SDESC <GET .TBL 1>>
	 <SET X <GET .TBL 2>>
	 <PUT <GETPT .OBJ ,P?SYNONYM> 0 .X>
	 <PUT <GETPT .OBJ ,P?ADJECTIVE> 0 .X>
	 <PUTP .OBJ ,P?DNUM <GET .TBL 3>>
	 <PUTP .OBJ ,P?VALUE <GET .TBL 4>>
	 <PUTP .OBJ ,P?READIQ <GET .TBL 5>>
	 <RFALSE>>
		
<OBJECT RENEWAL
	(LOC AT-BOTTOM)
	(DESC "crinkly scroll")
	(SDESC DESCRIBE-RENEWAL)
	(FLAGS TAKEABLE READABLE BUOYANT)
	(SYNONYM RENEWAL ZZZP SCROLL WRITING WORDS)
	(ADJECTIVE RENEWAL ZZZP CRINKLY)
	(SIZE 1)
	(VALUE 5)
	(GENERIC GENERIC-PAPER-F)
	(READIQ 8)
	(NAME-TABLE 0)
	(DNUM "refreshment")
	(EFFECT DO-RENEWAL)
	(DESCFCN RENEWAL-DESC)
	(ACTION HANDLE-SCROLL-F)>


<ROUTINE DO-RENEWAL ("OPT" (OBJ ,PRSO) "AUX" STAT MAX OLD)
	 <COND (<FINE-PRINT? .OBJ>
		<RTRUE>)>
	 <VANISH .OBJ>
	 <TELL "A refreshing pink aura envelops you ">
	 <COND (<FIRST? ,PLAYER>
		<TELL "and all your possessions ">)>
	 <TELL "as you study " THE .OBJ 
". Then the aura fades, and " THE .OBJ " disappears." CR>
	 <RENEW-ALL-IN ,PLAYER>
	 <SET STAT ,ENDURANCE>
	 <REPEAT ()
	    <SET MAX <GET ,MAXSTATS .STAT>>
	    <SET OLD <GET ,STATS .STAT>>
	    <COND (<G? .MAX .OLD>
		   <UPDATE-STAT <- .MAX .OLD> .STAT>)>
	    <COND (<IGRTR? STAT ,LUCK>
		   <RETURN>)>>
	 <BMODE-OFF>
	 <RTRUE>>
		
<ROUTINE RENEW-ALL-IN (OBJ "AUX" L)
	 <COND (<IS? ,GURDY ,OPENED>
		<WINDOW ,SHOWING-ALL>)>
	 <SET L <LOC ,DAGGER>>
	 <COND (<ZERO? .L>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<COND (<IS? ,DAGGER ,MUNGED>
		       <UNMAKE ,DAGGER ,MUNGED>
		       <PUTP ,DAGGER ,P?EFFECT 30>
		       <PUTP ,DAGGER ,P?VALUE
			     <* <GETP ,DAGGER ,P?VALUE> 2>>
		       <REPLACE-ADJ? ,DAGGER ,W?RUSTED ,W?ZZZP>
		       <REPLACE-ADJ? ,DAGGER ,W?RUSTY ,W?ZZZP>)>)>
	 <SET L <LOC ,TRUFFLE>>
	 <COND (<ZERO? .L>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<COND (<IS? ,TRUFFLE ,MUNGED>
		       <UNMAKE ,TRUFFLE ,MUNGED>
		       <SETG TRUFFLE-TIMER ,INIT-TRUFFLE>
		       <QUEUE ,I-TRUFFLE>)
		      (<G? ,TRUFFLE-TIMER 1>
		       <SETG TRUFFLE-TIMER </ ,TRUFFLE-TIMER 2>>)>)>
	 
	 <SET L <LOC ,LANTERN>>
	 <COND (<ZERO? .L>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<SETG LAMP-LIFE ,MAX-LAMP-LIFE>
		<UNMAKE ,LANTERN ,MUNGED>
		<MAKE ,LANTERN ,MAPPED>
	        <REPLACE-ADJ? ,LANTERN ,W?BROKEN ,W?ZZZP>
		<REPLACE-ADJ? ,LANTERN ,W?RUSTY ,W?ZZZP>
		<REPLACE-ADJ? ,LANTERN ,W?RUSTED ,W?ZZZP>
		<COND (<NOT <IS? ,LANTERN ,OPENED>>
		       <COND (<VISIBLE? ,LANTERN>
			      <TELL ,TAB CTHE ,LANTERN
			            " begins to glow." CR>)>
		       <LIGHT-LANTERN>)>)>
	 <SET L <LOC ,GLASS>>
	 <COND (<ZERO? .L>)
	       (<ZERO? ,GLASS-TOP>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<SETG GLASS-TOP ,FULL>
		<SETG GLASS-BOT 0>)>
	 <SET L <LOC ,BFLY>>
	 <COND (<ZERO? .L>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<COND (<NOT <IS? ,BFLY ,LIVING>>
		       <MAKE ,BFLY ,LIVING>
		       <COND (<IS? ,BFLY ,MUNGED>
			      <QUEUE ,I-PILLAR>)
			     (T
			      <QUEUE ,I-BFLY>)>
		       <UNMAKE ,BFLY ,SLEEPING>
		       <REPLACE-ADJ? ,BFLY ,W?DEAD ,W?ZZZP>)
		      (<IS? ,BFLY ,MUNGED>
		       <DEQUEUE ,I-PILLAR>
		       <QUEUE ,I-BFLY>
		       <UNMAKE ,BFLY ,MUNGED>
		       <UNMAKE ,BFLY ,TAKEABLE>
		       <REPLACE-SYN? ,BFLY ,W?CATERPILLAR ,W?BUTTERFLY>
		       <REPLACE-SYN? ,BFLY ,W?ZZZP ,W?FLY>
		       <REPLACE-ADJ? ,BFLY ,W?ZZZP ,W?BUTTER>)>)>
	 <SET L <LOC ,PARASOL>>
	 <COND (<ZERO? .L>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<COND (<IS? ,PARASOL ,MUNGED>
		       <UNMAKE ,PARASOL ,MUNGED>
		       <REPLACE-ADJ? ,PARASOL ,W?BROKEN ,W?CLOSED>
		       <MAKE ,PARASOL ,BUOYANT>
		       <PUTP ,PARASOL ,P?VALUE 2>)>)>
	 <RFALSE>>

<ROUTINE MUNG-ALL-IN (OBJ "AUX" L)
	 <COND (<IS? ,GURDY ,OPENED>
		<WINDOW ,SHOWING-ALL>)>
	 <SET L <LOC ,DAGGER>>
	 <COND (<ZERO? .L>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<MAKE ,DAGGER ,MUNGED>
		<PUTP ,DAGGER ,P?EFFECT 25>
		<PUTP ,DAGGER ,P?VALUE
		      </ <GETP ,DAGGER ,P?VALUE> 2>>
		<REPLACE-ADJ? ,DAGGER ,W?ZZZP ,W?RUSTY>
		<REPLACE-ADJ? ,DAGGER ,W?ZZZP ,W?RUSTED>)>
	 <SET L <LOC ,TRUFFLE>>
	 <COND (<ZERO? .L>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<COND (<NOT <IS? ,TRUFFLE ,MUNGED>>
		       <SETG TRUFFLE-TIMER ,INIT-TRUFFLE>)>)>
	 <SET L <LOC ,GLASS>>
	 <COND (<ZERO? .L>)
	       (<ZERO? ,GLASS-TOP>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<SETG GLASS-TOP 1>
		<SETG GLASS-BOT %<- ,FULL 1>>)>
	 
         <SET L <LOC ,LANTERN>>
         <COND (<ZERO? .L>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<COND (<NOT <L? ,LAMP-LIFE 20>>
		       <SETG LAMP-LIFE 20>)>
		<UNMAKE ,LANTERN ,MAPPED>
		<REPLACE-ADJ? ,LANTERN ,W?ZZZP ,W?RUSTY>
		<REPLACE-ADJ? ,LANTERN ,W?ZZZP ,W?RUSTED>
		<COND (<NOT <IS? ,LANTERN ,OPENED>>
		       <COND (<VISIBLE? ,LANTERN>
			      <TELL ,TAB CTHE ,LANTERN
			            " goes out." CR>)>
		       <LANTERN-OUT>)>)>
	 <SET L <LOC ,BFLY>>
	 <COND (<ZERO? .L>)
	       (<OR <EQUAL? .L .OBJ>
		    <IN? .L .OBJ>>
		<COND (<NOT <IS? ,BFLY ,MUNGED>>
		       <SETUP-PILLAR>)>)>
	 <RFALSE>>

<ROUTINE SETUP-PILLAR ()
	 <COND (<IS? ,BFLY ,LIVING>
		<DEQUEUE ,I-BFLY>
		<QUEUE ,I-PILLAR>)>
	 <MAKE ,BFLY ,MUNGED>
	 <MAKE ,BFLY ,TAKEABLE>
	 <REPLACE-SYN? ,BFLY ,W?BUTTERFLY ,W?CATERPILLAR>
	 <REPLACE-SYN? ,BFLY ,W?FLY ,W?ZZZP>
	 <REPLACE-ADJ? ,BFLY ,W?BUTTER ,W?ZZZP>
	 <RFALSE>>

<OBJECT PALIMP
	(LOC CHEST)
	(DESC "palimpsest")
	(SDESC DESCRIBE-PALIMP)
	(FLAGS TAKEABLE READABLE BUOYANT)
	(SYNONYM GATING ZZZP PALIMPSEST SCROLL SCROLLS
	 	 PAPER PIECE WRITING WORDS)
	(ADJECTIVE GATING ZZZP GATE)
	(SIZE 1)
	(VALUE 10)
	(GENERIC GENERIC-PAPER-F)
	(READIQ 16)
	(NAME-TABLE 0)
	(DESCFCN 0)
	(DNUM "transcendental physics")
	(EFFECT DO-GATE)
	(ACTION HANDLE-SCROLL-F)>
		

<GLOBAL PALIMP-CHARGES:NUMBER 5>

<ROUTINE DO-GATE ("OPT" (OBJ ,PRSO) "AUX" X)
	 <COND (<ZERO? ,PALIMP-CHARGES>
		<TELL "Nothing happens. " CTHE .OBJ
		      "'s virtue seems to be exhausted." CR>
		<RTRUE>)
	       (<HERE? APLANE>
		<COND (<EQUAL? ,ABOVE ,OPLAIN>
		       <PERMISSION>
		       <RTRUE>)>
		<SET X <DOWN-TO?>>
		<COND (<ZERO? .X>
		       <SET X ,HILLTOP>)>)
	       (<FINE-PRINT? .OBJ>
		<RTRUE>)
	       (T
		<SET X <GETP ,HERE ,P?FNUM>>
		<COND (<ZERO? .X>
		       <SET X ,OCITY>)>
		<DEC PALIMP-CHARGES>)>
	 <PCLEAR>
	 <SETG P-WALK-DIR <>>
	 <MAKE ,PALIMP ,USED>
	 <COND (<T? ,AUTO>
		<BMODE-OFF>)>
	 <COND (<NOT <IS? ,APLANE ,TOUCHED>>
		<TELL "As you speak the Word on " THE .OBJ ", the ">
		<COND (<IS? ,HERE ,INDOORS>
		       <TELL "walls, floor and " 'CEILING>)
		      (T
		       <TELL "sky and " B ,W?LANDSCAPE>)>
		<TELL " begin to warp like a funhouse mirror" ,PTAB>)>
	 <LOSE-FOCUS> 
	 <COND (<NOT <HERE? APLANE>>
		<COND (<IN? ,SHAPE ,APLANE>
		       <REMOVE ,SHAPE>)>
		<COND (<HELD? ,PHASE>
		       <SETUP-PHASE>)>
		<SAFE-VEHICLE-EXIT>
		<SETG SAME-COORDS T>
		<SETG ABOVE .X>
		<GET-APLANE-THINGS>
	        <SET X ,APLANE>)>
	 <GOTO .X>
	 <RTRUE>>

<ROUTINE SAFE-VEHICLE-EXIT ("AUX" X)
	 <SET X <LOC ,PLAYER>>
	 <COND (<NOT <EQUAL? .X ,HERE>>
		<COND (<EQUAL? .X ,POOL>
		       <SETUP-POND-EXITS>)
		      (<EQUAL? .X ,MAW>
		       <CLEAR-MAW-EXITS>)>
		<MAKE ,GONDOLA ,NODESC>
		<UNMAKE ,DACT ,NODESC>
		<MOVE ,PLAYER ,HERE>)>
	 <SET X <GETB ,CELLAR-ROOMS 0>>
	 <COND (<SET X <INTBL? ,HERE <REST ,CELLAR-ROOMS 1> .X 1>>
		<UNMAKE ,CELLAR-DOOR ,LOCKED>)>
	 <RFALSE>>
	 
<ROUTINE LOSE-FOCUS ()
	 <TELL "Your eyes lose their focus momentarily." CR>
	 <COND (<T? ,VERBOSITY>
		<CRLF>)>
	 <COND (<HERE? APLANE>
		<COND (<EQUAL? ,ABOVE ,OPLAIN>
		       <EXIT-IMPS>)>
		<COND (<HELD? ,PHASE>
		       <MUNG-PHASE>)>)>
	 <RFALSE>>

<ROUTINE ATRII-KICK ()
	 <DEQUEUE ,I-IMPGIVE>
	 <SETG IMPSAY 0>
	 <SETG P-WALK-DIR <>>
	 <UNMAKE ,ON-PIKE ,TOUCHED>
	 <TELL ,TAB>
	 <LOSE-FOCUS>
	 <GOTO ,ON-PIKE>
	 <COND (<AND <IN? ,GOBLET ,ON-PIKE>
		     <IS? ,GOBLET ,NODESC>>
	        <UNMAKE ,GOBLET ,NODESC>
		<SETG P-IT-OBJECT ,GOBLET>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB CTHE ,GOBLET " clatters to the ground." CR>)>
	 <RTRUE>>

<OBJECT TUSK
	(DESC "ivory tusk")
	(FLAGS TAKEABLE VOWEL)
	(SYNONYM TUSK)
	(ADJECTIVE IVORY)
	(SIZE 10)
	(VALUE 40)
	(DESCFCN TUSK-F)
	(ACTION TUSK-F)>

<ROUTINE TUSK-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,TUSK
" marks the final resting place of a mighty pachyderm.">
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<FIRST-TAKE?>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL
"Obviously valuable. The smooth, creamy curve is virtually flawless." CR>
		<RTRUE>)
	       (<VERB? TOUCH>
		<TELL "You run your hand along the smooth curve." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CARD
	(DESC "bubble gum card")
	(FLAGS TAKEABLE)
	(SYNONYM CARD)
	(ADJECTIVE BUBBLE GUM)
	(SIZE 1)
	(VALUE 30)
	(ACTION CARD-F)>

<ROUTINE CARD-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL
"This card, featuring Orkan of Thriff, is the rarest issue in the Famous Enchanter Series." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RIDDLE
	(LOC AT-LEDGE)
	(DESC "inscription")
	(FLAGS VOWEL TRYTAKE NOALL READABLE)
	(SYNONYM INSCRIPTION WRITING WORDS RIDDLE LIGHTNING CLIFF FACE)
	(DESCFCN RIDDLE-F)
	(ACTION RIDDLE-F)>

<ROUTINE RIDDLE-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <PRINT "An inscription is carved upon the face of ">
		       <TELL "the cliff.">
		       <RTRUE>)>
		<RFALSE>)
	       (<NOUN-USED? ,W?LIGHTNING>
		<OPEN-CLIFF>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE READ LOOK-ON>
		<TELL "The carved " 'PRSO " reads,||">
		<HLIGHT ,H-MONO>
		<TELL 
"\"My tines be long,|
 My tines be short,|
 My tines end ere my first report.|
 What am I?\"" CR>
		<HLIGHT ,H-NORMAL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OPEN-CLIFF ()
	 <PCLEAR>
	 <REMOVE ,RIDDLE>
	 <SETG P-WALK-DIR <>>
	 <SETG OLD-HERE <>>
	 <UNMAKE ,CREVICE ,NODESC>
	 <SETG P-IT-OBJECT ,CREVICE>
	 <REPLACE-GLOBAL? ,AT-LEDGE ,NULL ,CREVICE>
	 <NEW-EXIT? ,AT-LEDGE ,P?WEST %<+ ,CONNECT 1 ,MARKBIT> ,TOWER-BASE>
	 <NEW-EXIT? ,TOWER-BASE ,P?EAST %<+ ,CONNECT 1 ,MARKBIT> ,AT-LEDGE>
	 <WINDOW ,SHOWING-ROOM>
	 <KERBLAM>
	 <TELL 
"A blast from the sky sends you sprawling over the brink of the ledge! You grab onto a rocky outcrop and manage to drag " 'ME " back up to safety." CR>
	 <COND (<OR <ZERO? ,DMODE>
		    <EQUAL? ,PRIOR ,SHOWING-INV ,SHOWING-STATS>>
		<RELOOK T>)>
	 <RTRUE>>

<OBJECT CREVICE
	(LOC LOCAL-GLOBALS)
	(DESC "opening")
	(FLAGS NODESC VOWEL)
	(SYNONYM OPENING HOLE)
	(ACTION CREVICE-F)>

<ROUTINE CREVICE-F ("AUX" X)
	 <COND (<IS? ,CREVICE ,NODESC>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "It leads ">
		<SET X ,W?WEST>
		<COND (<HERE? TOWER-BASE>
		       <SET X ,W?EAST>)>
		<TELL B .X "ward." CR>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<SET X ,P?WEST>
		<COND (<HERE? TOWER-BASE>
		       <SET X ,P?EAST>)>
		<DO-WALK .X>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SWAMP
	(LOC LOCAL-GLOBALS)
	(DESC "moor")
	(FLAGS NODESC PLACE)
	(SYNONYM MOOR MOORS SWAMP)
	(ACTION HERE-F)>

<OBJECT FOG
	(LOC LOCAL-GLOBALS)
	(DESC "mist")
	(FLAGS NODESC)
	(SYNONYM MIST FOG)
	(ACTION FOG-F)>

<ROUTINE FOG-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL "It's hard to see more than a few yards." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PLATFORM
	(LOC LOCAL-GLOBALS)
	(DESC "platform")
	(FLAGS NODESC PLACE)
	(SYNONYM PLATFORM)
	(ADJECTIVE MAINTENANCE)
	(ACTION PLATFORM-F)>

<ROUTINE PLATFORM-F ("AUX" X)
	 <COND (<SET X <CLIMBING-ON?>>
		<COND (<IN? ,PLAYER ,GONDOLA>
		       <PERFORM ,V?EXIT ,GONDOLA>
		       <RTRUE>)>
		<ALREADY-ON>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<COND (<IN? ,PLAYER ,GONDOLA>
		       <NOT-ON>
		       <RTRUE>)
		      (<IN? ,GONDOLA ,HERE>
		       <PERFORM ,V?ENTER ,GONDOLA>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GGLYPH
	(LOC GLOBAL-OBJECTS)
	(DESC "glyph")
	(FLAGS READABLE)
	(SYNONYM GLYPH GLYPHS WARDING MARK MARKS SYMBOL SYMBOLS)
	(ADJECTIVE WARDING)
	(GENERIC GENERIC-GLYPH-F)
	(ACTION GGLYPH-F)>

<ROUTINE GGLYPH-F ("AUX" X)
	 <COND (<AND <IS? ,DIARY ,MUNGED>
		     <VISIBLE? ,DIARY>>
		<SETG P-IT-OBJECT ,DIARY>
		<TELL "[the glyph in the diary" ,BRACKET>
		<COND (<VERB? EXAMINE LOOK-ON>
		       <DESCRIBE-GLYPH>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <IMPOSSIBLE>
		       <RTRUE>)>
		<RETURN <DIARY-F>>)>
	 <PCLEAR>
	 <TELL "There aren't any visible here." CR>
	 <RFATAL>>

<OBJECT GLYPH
	(LOC LOCAL-GLOBALS)
	(DESC "glyph")
	(FLAGS READABLE SURFACE)
	(CAPACITY 100)
	(SYNONYM GLYPH WARDING MARK SYMBOL)
	(ADJECTIVE WARDING)
	(GENERIC GENERIC-GLYPH-F)
	(ACTION GLYPH-F)>

<ROUTINE GENERIC-GLYPH-F (TBL "OPT" (LEN <GET .TBL 0>))
	 <COND (<SET LEN <INTBL? ,GLYPH <REST .TBL 2> .LEN>>
		<RETURN ,GLYPH>)
	       (T
		<RETURN ,GGLYPH>)>>

<ROUTINE GLYPH-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? TOUCH-TO>
			    <EQUAL? ,P-PRSA-WORD ,W?RUB>>
		       <RUBOUT-GLYPH>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE READ LOOK-ON>
		<TELL CTHEO ,SIS>
		<SAY-GLYPH>
		<RTRUE>)
	       (<VERB? CLEAN-OFF>
		<COND (<OR <EQUAL? ,PRSI <> ,GROUND ,ROOMS>
			   <EQUAL? ,PRSI ,SNOW ,LAVA>>
		       <RUBOUT-GLYPH>
		       <RTRUE>)>
		<TELL CTHEO " isn't on " THEI ,PERIOD>
		<RTRUE>)
	       (<VERB? ERASE-WITH KICK TAKE-OFF MUNG CLEAN>		
		<RUBOUT-GLYPH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SAY-GLYPH ()
	 <MAKE ,GLYPH ,SEEN>
	 <TELL "a surprisingly simple pattern of lines and curves. Even a ">
	 <ANNOUNCE-RANK>
	 <TELL " like you could inscribe one just like it." CR>
	 <RTRUE>>

<ROUTINE WRITE-GLYPH ("AUX" X)
	 <COND (<NOT <IN? ,BURIN ,PLAYER>>
		<TELL 
"The inscription of glyphs is a delicate business. You'll need a proper tool first">
		<COND (<IS? ,GLYPH ,SEEN>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<TELL ". Besides, you ">
		<PRINT 
"haven't studied any glyphs well enough to inscribe one yourself.|">
		<RTRUE>)
	       (<GLOBAL-IN? ,HERE ,GLYPH>
		<TELL "There's already " A ,GLYPH
		      " written here." CR>
		<RTRUE>)
	       (<NOT <IS? ,GLYPH ,SEEN>>
		<TELL ,CYOU>
		<PRINT 
"haven't studied any glyphs well enough to inscribe one yourself.|">
		<RTRUE>)
	       (<AND <GLOBAL-IN? ,HERE ,NULL>
		     <GLOBAL-IN? ,HERE ,SNOW ,LAVA>>
		<SET X ,SNOW>
		<COND (<GLOBAL-IN? ,HERE ,LAVA>
		       <COND (<ZERO? ,MAGMA-TIMER>
			      <LAVA-TOO-HARD>
			      <RTRUE>)>
		       <SET X ,LAVA>)>
		<REPLACE-GLOBAL? ,HERE ,NULL ,GLYPH>		
		<SETG P-IT-OBJECT ,GLYPH>
		<WINDOW ,SHOWING-ROOM>
		<TELL "You carefully trace " A ,GLYPH ,SIN THE .X
		      " with your burin">
		<COND (<GLOBAL-IN? ,HERE ,XTREES>
		       <TELL ", and notice " THE ,XTREES
			     " fidgeting with rage">)>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <TELL ,XTHE>
	 <GROUND-WORD>
	 <TELL " here is too hard to write anything." CR>
	 <RTRUE>>		     
		
<ROUTINE LAVA-TOO-HARD ()
	 <TELL CTHE ,LAVA " underfoot is too hard now." CR>
	 <RTRUE>>

<ROUTINE RUBOUT-GLYPH ("AUX" X)
	 <COND (<AND <GLOBAL-IN? ,HERE ,LAVA>
		     <ZERO? ,MAGMA-TIMER>>
		<LAVA-TOO-HARD>
		<RTRUE>)>
	 <REPLACE-GLOBAL? ,HERE ,GLYPH ,NULL>
	 <WINDOW ,SHOWING-ROOM>
	 <TELL "You rub out " THE ,GLYPH>
	 <COND (<THIS-PRSI?>
		<TELL ,WITH THEO>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<OBJECT SNOW
	(LOC LOCAL-GLOBALS)
	(DESC "snow")
	(FLAGS NODESC SURFACE TRYTAKE NOALL)
	(SYNONYM SNOW SNOWFALL SNOWFLAKE POWDER)
	(ADJECTIVE FROZEN POWDERY WHITE)
	(ACTION SNOW-F)>	

<ROUTINE SNOW-F ("AUX" X)
	 <COND (<THIS-PRSI?>)
	       (<VERB? LOOK-UNDER DIG DIG-UNDER LOOK-INSIDE SEARCH>
		<TELL "You poke through " THEO>
		<BUT-FIND-NOTHING>
		<RTRUE>)
	       (<VERB? TAKE TOUCH>
		<TELL "The powdery " 'PRSO " falls between your fingers." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<WASTE-OF-TIME>
		<RTRUE>)>
	 <RETURN <GROUND-F>>>

<OBJECT LAVA
	(LOC LOCAL-GLOBALS)
	(DESC "lava")
	(FLAGS NODESC SURFACE TRYTAKE NOALL)
	(CAPACITY 1000)
	(SYNONYM LAVA MAGMA FLOW ROCK ZZZP)
	(ADJECTIVE LAVA)
	(ACTION LAVA-F)>

<ROUTINE LAVA-F ("AUX" X)
	 <COND (<THIS-PRSI?>)
	       (<OR <VERB? LOOK-UNDER>
		    <SET X <MOVING?>>>
		<TELL ,XTHE>
		<COND (<ZERO? ,MAGMA-TIMER>
		       <TELL "hardened lava">
		       <PRINT " cannot be moved.|">
		       <RTRUE>)>
		<TELL "cooling lava slurps between your fingers." CR>
		<RTRUE>)>
	 <RETURN <GROUND-F>>>

<OBJECT DOME
	(LOC ON-PEAK)
	(DESC "iridescent dome")
	(FLAGS VOWEL NODESC TRYTAKE NOALL CONTAINER OPENED SURFACE)
	(SYNONYM DOME ; LAVA ; MAGMA VOLCANO FIELD)
	(ADJECTIVE IRIDESCENT GIRGOL)
	(CAPACITY 1000)
	(CONTFCN DOME-F)
	(ACTION DOME-F)> 

<ROUTINE DOME-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<THIS-PRSI?>
			      <COND (<SET X <PUTTING?>>
				     <DOMESLIDE>
				     <RTRUE>)
				    (<SET X <TOUCHING?>>
				     <TOUCH-DOME-WITH ,PRSO>
				     <RTRUE>)>
			      <RFALSE>)
			     (<SET X <TOUCHING?>>
			      <TOUCH-DOME-WITH>
			      <RTRUE>)>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <DOMESLIDE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "Your eyes cannot focus on ">
		<PRINT "the iridescent surface of the dome">
		<TELL ". But a fiery glow emanates from within." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-BEHIND LOOK-UNDER SEARCH>
		<TELL "Peering within ">
		<PRINT "the iridescent surface of the dome">
		<TELL 
", you see a spectacular plume of molten lava, frozen in mid-explosion above a crater seething with molten magma." CR>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<TOUCH-DOME-WITH>
		<RTRUE>)
	       (<VERB? KICK>
		<TOUCH-DOME-WITH ,FEET>
		<RTRUE>)
	       (<VERB? TOUCH SQUEEZE>
		<TELL "The surface of " THEO 
		      " feels hard and slightly warm." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE DOMESLIDE ()
	 <THIS-IS-IT ,PRSO>
	 <MOVE ,PRSO ,HERE>
	 <WINDOW ,SHOWING-ALL>
	 <TELL CTHEO " strikes the perimeter of " THE ,DOME 
	       " and slides to " THE ,GROUND ,PERIOD>
	 <RTRUE>>

<ROUTINE TOUCH-DOME-WITH ("OPT" OBJ)
	 <YOUR-OBJ .OBJ>
	 <COND (<PROB 50>
		<TELL " will go no farther than ">)
	       (T
		<TELL " stops at ">)>
	 <TELL "the dome's perimeter." CR>
	 <RTRUE>>

<OBJECT PLUME
	(LOC DOME)
	(DESC "lava")
	(FLAGS NODESC TRYTAKE NOALL SURFACE CONTAINER OPENED)
	(SYNONYM LAVA PLUME SPRAY MAGMA)
	(ADJECTIVE LAVA MOLTEN)
	(CAPACITY 1000)
	(ACTION PLUME-F)>

<ROUTINE PLUME-F ("AUX" X)
	 <COND (<T? ,LAVA-TIMER>
		<COND (<OR <SET X <TOUCHING?>>
			   <SET X <ENTERING?>>>
		       <CASCADE "approach">
		       <RTRUE>)>
		<CASCADE "gawk at">
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE>
		<TELL CTHEO " seems frozen in a moment of time." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CRATER
	(LOC ON-PEAK)
	(DESC "crater")
	(FLAGS NODESC PLACE CONTAINER OPENED)
	(SYNONYM CRATER HOLE BRINK)
	(CAPACITY 1000)
	(ACTION DOME-F)>

<ROUTINE CRATER-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <VANISH>
		       <TELL CTHEO " disappears into the steam." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <SEEING?>>
		<SAY-STEAM>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<TELL "Hot steam drives you away from " THEO ,PERIOD>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT MAGMA-GLOW
	(DESC "glow")
	(FLAGS NODESC PLACE)
	(SYNONYM GLOW LIGHT SKY)
	(ADJECTIVE YELLOW DULL)
	(ACTION MAGMA-GLOW-F)>

<ROUTINE MAGMA-GLOW-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<SET X <ENTERING?>>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL CTHE ,MAGMA-GLOW " feels warm on your face." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GLOW-COLOR ()
	 <COND (<G? ,MAGMA-TIMER 2>
		<TELL "fiery yellow ">)
	       (<EQUAL? ,MAGMA-TIMER 2>
		<TELL "warm orange ">)
	       (T
		<TELL "dull red ">)>
	 <RTRUE>>

<OBJECT TRAIL
	(LOC LOCAL-GLOBALS)
	(DESC "trail")
	(FLAGS NODESC PLACE)
	(SYNONYM TRAIL PATH)
	(ACTION TRAIL-F)>

<ROUTINE TRAIL-F ("AUX" X)
	 <COND (<SET X <CLIMBING-ON?>>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<GLOBAL-IN? ,HERE ,SNOW>
		<RETURN <SNOW-F>>)
	       (<GLOBAL-IN? ,HERE ,LAVA>
		<RETURN <LAVA-F>>)
	       (T
		<RETURN ,GROUND-F>)>>

<OBJECT ORNAMENT
	(DESC "silver ornament")
	(FLAGS TAKEABLE)
	(SYNONYM ORNAMENT)
	(ADJECTIVE SILVER)
	(SIZE 1)
	(VALUE 2)
	(ACTION ORNAMENT-F)>

<ROUTINE ORNAMENT-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO 
" is crafted in an old-fashioned holiday style. Might fetch a few zorkmids in Mizniaport." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BOOT
	(LOC IN-FROON)
	(DESC "enormous boot")
	(FLAGS NODESC VOWEL TRYTAKE NOALL)
	(SYNONYM BOOT)
	(ADJECTIVE ENORMOUS GIANT LARGE)
	(ACTION BOOT-F)>

<ROUTINE BOOT-FACING ()
	 <TELL CTHE ,BOOT " is facing the wrong way." CR>
	 <RTRUE>>

<ROUTINE BOOT-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <BOOT-FACING>
		       <RTRUE>)>
		<RFALSE>)
	       (<OR <VERB? LOOK-INSIDE REACH-IN>
		    <SET X <ENTERING?>>>
		<BOOT-FACING>
		<RTRUE>)
	       (<VERB? WEAR>
		<TELL ,DONT "take a size 105." CR>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<TELL CTHEO " is firmly wedged under " THE ,FARMHOUSE ,PERIOD>
		<RTRUE>)
	       (<VERB? EXAMINE SEARCH>
		<TELL CTHEO>
		<PRINT " lies crushed beneath ">
		<TELL THE ,FARMHOUSE ", its tongue hanging in the dirt." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BROOK
	(LOC LOCAL-GLOBALS)
	(DESC "brook")
	(FLAGS NODESC CONTAINER OPENED)
	(SYNONYM BROOK RIVER STREAM WATER)
	(ADJECTIVE BABBLING)
	(ACTION BROOK-F)>

<ROUTINE BROOK-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <WATER-VANISH>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " meanders ">
		<COND (<HERE? AT-BRINE>
		       <TELL B ,W?NORTHWEST ,PERIOD>
		       <RTRUE>)>
		<TELL "west, into a deep forest." CR>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?NORTH>
		<RTRUE>)
	       (<HANDLE-WATER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WATERFALL
	(LOC AT-FALLS)
	(DESC "waterfall")
	(FLAGS NODESC CONTAINER OPENED)
	(SYNONYM WATERFALL FALLS WATER CASCADE)
	(ADJECTIVE FALLING)
	(ACTION WATERFALL-F)>

<ROUTINE WATERFALL-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<PUTTING?>
		       <VANISH>
		       <TELL CTHEO " disappears in the swirling water." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? ENTER WALK-AROUND LOOK-BEHIND>
		<TELL "Sorry. No secret caves." CR>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<ENTER-FALLS>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "The roar is loud and exhilarating." CR>
		<RTRUE>)
	       (<HANDLE-WATER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTER-FALLS ()
	 <TELL "One touch of the chilly water changes your mind." CR>
	 <RFALSE>>

<ROUTINE HANDLE-WATER? ("AUX" X)
	 <COND (<VERB? EXAMINE LOOK-INSIDE LOOK-UNDER SEARCH>
		<PRINT "Little can be seen ">
		<TELL "in the swirling water." CR>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM TASTE>
		<TELL "The water is cool and refreshing." CR>
		<RTRUE>)
	       (<VERB? TOUCH REACH-IN KICK>
		<TELL "Brr!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RIVER
	(LOC LOCAL-GLOBALS)
	(DESC "river")
	(FLAGS NODESC CONTAINER OPENED)
	(SYNONYM RIVER STREAM WATER FORD)
	(ACTION RIVER-F)>

<ROUTINE RIVER-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <WATER-VANISH>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <SEEING?>>
		<TELL "Blowing mist obscures the roaring water." CR>
		<RTRUE>)
	       (<OR <VERB? LEAP>
		    <SET X <ENTERING?>>>
		<JUMP-OFF-BRIDGE>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<NOT-IN>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CABIN
	(LOC LOCAL-GLOBALS)
	(DESC "log cabin")
	(FLAGS NODESC PLACE)
	(SYNONYM CABIN HOUSE BUILDING LABORATORY LAB LOGS)
	(ADJECTIVE LOG)
	(ACTION CABIN-F)>

<ROUTINE CABIN-F ("AUX" X)
	 <COND (<HERE? IN-CABIN>
		<COND (<VERB? SEARCH>
		       <PERFORM ,PRSA ,CHEMS>
		       <RTRUE>)>
		<RETURN <HERE-F>>)
	       (<SET X <ENTERING?>>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CABIN-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "door")
	(FLAGS NODESC DOORLIKE OPENABLE OPENED)
	(SYNONYM DOOR DOORWAY)
	(ADJECTIVE CABIN)>

<OBJECT BENCH
	(LOC IN-CABIN)
	(DESC "workbench")
	(FLAGS NODESC SURFACE TRYTAKE NOALL)
	(SYNONYM WORKBENCH BENCH TABLE)
	(CAPACITY 20)
	(ACTION BENCH-F)>

<ROUTINE BENCH-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <CLIMBING-ON?>>
		<TELL CTHEO " doesn't look as if it would support you." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<MAKE ,CHEMS ,NODESC>
		<TELL "Aside from " THE ,CHEMS ,LYOU-SEE>
		<CONTENTS>
		<TELL ,SON THEO ,PERIOD>
		<UNMAKE ,CHEMS ,NODESC>
		<SETG P-IT-OBJECT ,PRSO>
		<RTRUE>)
	       (<VERB? SEARCH>
		<PERFORM ,PRSA ,CHEMS>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<TELL CTHEO " is much too bulky." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<OBJECT CHEMS
	(LOC BENCH)
	(DESC "chemicals")
	(FLAGS TRYTAKE NOALL SURFACE PLURAL)
	(SYNONYM CHEMICALS RETORTS ALEMBICS LIQUID LIQUIDS)
	(ACTION CHEMS-F)>

<ROUTINE CHEMS-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-UNDER PUT-BEHIND PUT>
		       <WASTE-OF-TIME>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <PERFORM ,PRSA ,PRSO ,BENCH>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO 
" are fouled beyond recognition or usefulness">
		<MAKE ,PRSO ,NODESC>
		<COND (<SEE-ANYTHING-IN? ,BENCH>
		       <TELL ". " ,YOU-SEE>
		       <CONTENTS ,BENCH>
		       <SETG P-IT-OBJECT ,PRSO>
		       <TELL " lying among them">)>
		<UNMAKE ,PRSO ,NODESC>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? SEARCH LOOK-INSIDE LOOK-UNDER LOOK-BEHIND>
		<TELL "You carefully sift through " THEO>
		<COND (<NOT <IS? ,UHEMI ,NODESC>>
		       <PRINT ", but find nothing else of interest.|">
		       <RTRUE>)>
		<FIND-UHEMI>
		<TELL ", and turn up " A ,UHEMI ,PERIOD>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<TELL CTHEO " are sticky and useless." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>  
	       
<ROUTINE FIND-UHEMI ()
	 <MAKE ,DIARY ,TOUCHED>
	 <UNMAKE ,UHEMI ,NODESC>
	 <MOVE ,UHEMI ,BENCH>
	 <SETG P-IT-OBJECT ,UHEMI>
	 <WINDOW ,SHOWING-ALL>
	 <RTRUE>>

<OBJECT UHEMI
	(DESC "black hemisphere")
	(FLAGS NODESC TAKEABLE)
	(SYNONYM HEMISPHERE CRYSTAL CRYSTALS PEG)
	(ADJECTIVE BLACK)
	(SIZE 2)
	(VALUE 25)
	(ACTION UHEMI-F)>

<ROUTINE UHEMI-F ()
	 <RETURN <HANDLE-HEMI? ,UHEMI ,LHEMI ,W?PEG>>>

<OBJECT LHEMI
	(LOC RELIQUARY)
	(DESC "white hemisphere")
	(FLAGS TAKEABLE)
	(SYNONYM HEMISPHERE CRYSTAL CRYSTALS HOLE)
	(ADJECTIVE WHITE)
	(SIZE 2)
	(VALUE 25)
	(ACTION LHEMI-F)>

<ROUTINE LHEMI-F ()
	 <RETURN <HANDLE-HEMI? ,LHEMI ,UHEMI ,W?HOLE>>>

<ROUTINE HANDLE-HEMI? (OBJ OTHER WRD "AUX" X)
	 <COND (<NOUN-USED? .WRD>
		<COND (<THIS-PRSI?>
		       <COND (<VERB? PUT PUT-ON PLUG-IN>
			      <COND (<PRSO? PRSI>
				     <IMPOSSIBLE>
				     <RTRUE>)
				    (<EQUAL? ,PRSO .OTHER>
				     <FUSION>
				     <RTRUE>)
				    (<EQUAL? .WRD ,W?PEG>
				     <IMPOSSIBLE>
				     <RTRUE>)>
			      <TELL ,XTHE B .WRD ,SON THE .OBJ
				    " is much too tiny." CR>
			      <RTRUE>)
			     (<SET X <PUTTING?>>
			      <IMPOSSIBLE>
			      <RTRUE>)>
		       <RFALSE>)
		      (<SET X <MOVING?>>
		       <TELL ,XTHE B .WRD ,SON THE .OBJ>
		       <PRINT " cannot be moved.|">
		       <RTRUE>)
		      (<VERB? EXAMINE>
		       <TELL "It's set into the center of " 
			     THE .OBJ ,PERIOD>
		       <RTRUE>)
		      (<VERB? LOOK-INSIDE SEARCH>
		       <COND (<EQUAL? .WRD ,W?PEG>
			      <IMPOSSIBLE>
			      <RTRUE>)>
		       <PRINT "It's empty.|">
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON PLUG-IN>
		       <COND (<PRSO? PRSI>
			      <IMPOSSIBLE>
			      <RTRUE>)
			     (<EQUAL? ,PRSO .OTHER>
			      <FUSION>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE>
		<PRINT "You fix your gaze deep within the crystal, ">
		<TELL "and sense a vague incompleteness." CR>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"This curious artifact is wide as your palm, and fashioned of some ">
		<COND (<EQUAL? .OBJ ,LHEMI>
		       <TELL B ,W?WHITE>)
		      (T
		       <TELL B ,W?BLACK>)>
		<TELL " crystalline substance. A tiny ">
		<COND (<EQUAL? .OBJ ,LHEMI>
		       <TELL B ,W?HOLE>)
		      (T
		       <TELL B ,W?PEG>)>
		<TELL " is set in the middle of its flat side." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FUSION ("AUX" L)
	 <SET L <LOC ,PRSI>>
	 <WINDOW ,SHOWING-ALL>
	 <TELL "The crystals fit together with a satisfying ">
	 <HLIGHT ,H-ITALIC>
	 <TELL "click">
	 <HLIGHT ,H-NORMAL>
	 <TELL " to form a perfect sphere, half white, half black">
	 <COND (<OR <IS? ,PRSO ,NEUTRALIZED>
		    <IS? ,PRSI ,NEUTRALIZED>>
		<COND (<NOT <IN? ,PRSO .L>>
		       <MOVE ,PRSO .L>)>
		<TELL ". But they fall apart the moment you release them." CR>
		<RTRUE>)>
	 <TELL ,PERIOD>
	 <MOVE ,STONE .L>
	 <REMOVE ,PRSI>
	 <REMOVE ,PRSO>
	 <SETG P-IT-OBJECT ,STONE>
	 <COND (<HERE? IN-BOUTIQUE IN-MAGICK IN-WEAPON>
		<TELL ,TAB "\"Cover your eyes,\" warns "
		      THE ,OWOMAN ,PERIOD>)>
	 <TELL ,TAB 
"Nothing happens for a moment. Then, in a fraction of an instant, the two hemispheres switch colors! You hardly have time to gasp before the colors switch again, and then again, faster, faster, until you shield your eyes from the blinding strobe effect." CR>
	 <RTRUE>>
	 
<OBJECT STONE
	(DESC "gray sphere")
	(SDESC DESCRIBE-STONE)
	(FLAGS TAKEABLE)
	(SYNONYM ZZZP SCRYSTONE STONE CRYSTAL SPHERE BALL)
	(ADJECTIVE ZZZP GRAY GREY)
	(SIZE 4)
	(VALUE 50)
	(NAME-TABLE 0)
	(ACTION STONE-F)>


<GLOBAL VISION:NUMBER 0>

<ROUTINE STONE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is perfectly smooth and seamless">
		<COND (<NOT <IS? ,PRSO ,NEUTRALIZED>>
		       <TELL 
". Its surface draws your eyes deep into its cloudy interior">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <TELL 
"You're not likely to see much unless you're holding it." CR>
		       <RTRUE>)>
		<SET X <LOC ,STONE>>
		<PRINT "You fix your gaze deep within the crystal, ">
		<COND (<OR <IS? ,PRSO ,NEUTRALIZED>
			   <L? <GET ,STATS ,INTELLIGENCE> 69>>
		       <TELL 
"but an unintelligible swirl is all you can see." CR>
		       <RTRUE>)>
		<TELL 
"and watch its swirling depths coalesce into the image of a ">
		<COND (<IGRTR? VISION 3>
		       <SETG VISION 0>
		       <TELL
"samurai warrior, slashing through armies of bloodthirsty foes in an epic struggle for power and honor">
		       <PRINT ". This curious vision quickly fades.|">
		       <RTRUE>)
		      (<EQUAL? ,VISION 1>
		       <COND (<ZERO? ,WALL-WORD>
			      <SET X <PICK-ONE ,MAGIC-WORDS>>
			      <PUT .X 2 1>
			      <SETG WALL-WORD <GET .X 0>>
			      <SET X <GET .X 1>>
			      <PUTP ,NWALL ,P?NAME-TABLE .X>
			      <MAKE ,NWALL ,NAMED>
			      <PUTP ,SWALL ,P?NAME-TABLE .X>
			      <MAKE ,SWALL ,NAMED>)>
		       <TELL
"warlock, standing before a seamless wall of stone. He mutters the word \"">
		       <PRINT-TABLE <GETP ,NWALL ,P?NAME-TABLE>>
		       <TELL 
",\" and a doorlike outline appears which he pushes open. The vision fades as he steps inside." CR>
		       <RTRUE>)
		      (<EQUAL? ,VISION 2>
		       <TELL
"huge cauldron, bubbling in the midst of a vast, excessive castle">
		       <PRINT ". This curious vision quickly fades.|">  
		       <RTRUE>)>
		<TELL
"giant balloon-shaped head, wagging its tongue at you from the depths of outer space">
		<PRINT ". This curious vision quickly fades.|">
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<TELL CTHEO " is completely seamless." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL WALL-WORD:WORD <>>
		
<ROUTINE SETUP-STONE ("AUX" WRD TBL)
	 <SET TBL <PICK-ONE ,MAGIC-WORDS>>
	 <PUT .TBL 2 1>
	 <SET WRD <GET .TBL 0>>
	 <PUT <GETPT ,STONE ,P?SYNONYM> 0 .WRD>
	 <PUT <GETPT ,STONE ,P?ADJECTIVE> 0 .WRD>
	 <PUTP ,STONE ,P?NAME-TABLE <GET .TBL 1>>
	 <MAKE ,STONE ,PROPER>
	 <MAKE ,STONE ,NAMED>
	 <MAKE ,STONE ,IDENTIFIED>
	 <WINDOW ,SHOWING-ALL>
	 <RFALSE>>
	
<ROUTINE SAY-WALL-WORD ()
	 <COND (<AND <HERE? SE-WALL SE-CAVE>
		     <NOT <IS? ,SWALL ,SEEN>>>
		<SEE-WALL ,SWALL>
		<RTRUE>)
	       (<AND <HERE? NE-WALL NE-CAVE>
		     <NOT <IS? ,NWALL ,SEEN>>>
		<SEE-WALL ,NWALL>
		<RTRUE>)>
	 <NOTHING-HAPPENS <>>
	 <RTRUE>>

<ROUTINE SEE-WALL (OBJ)
	 <MAKE .OBJ ,SEEN>
	 <WINDOW ,SHOWING-ROOM>
	 <MAKE .OBJ ,PROPER>
	 <MAKE .OBJ ,IDENTIFIED>
	 <PUT <GETPT .OBJ ,P?SYNONYM> 0 ,WALL-WORD>
	 <PUT <GETPT .OBJ ,P?ADJECTIVE> 0 ,WALL-WORD>
	 <TELL CTHE ,GROUND " shudders at the sound of your voice">
	 <COND (<T? ,LIT?>
		<TELL
", and the outline of a door appears in the rock wall">)>
	 <TELL ,PERIOD>
	 <REFRESH-MAP>
	 <RTRUE>>		 
		       

<OBJECT DIARY
	(LOC BENCH)
	(DESC "little black book")
	(FLAGS TAKEABLE READABLE)
	(SYNONYM BOOK DIARY JOURNAL ENTRY ENTRIES)
	(SIZE 3)
	(VALUE 10)
	(GENERIC GENERIC-GLYPH-F)
	(ACTION DIARY-F)>

<ROUTINE DIARY-F ("AUX" X)
	 <COND (<NOUN-USED? ,W?GLYPH>
		<COND (<VERB? EXAMINE LOOK-ON>
		       <DESCRIBE-GLYPH>
		       <RTRUE>)
		      (<SET X <MOVING?>>
		       <TELL CTHE ,GLYPH ,SIN THE ,DIARY>
		       <PRINT " cannot be moved.|">
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON EMPTY-INTO>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<ITAKE>
		       <FIND-UHEMI>
		       <TELL "As you pick up " THEO ", you notice " A ,UHEMI
			     " lying among " THE ,CHEMS ,PERIOD>)>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"It appears to be a personal journal or diary of some kind. The faint glow of the penmanship betrays its author as a mage." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH OPEN>
		<TELL "Many of the pages are still intact." CR>
		<RTRUE>)
	       (<VERB? READ>
		<TELL "You nosily thumb the pages.|| \"">
		<ITALICIZE "23 July">
		<TELL
". Hot again. Retorts and alembics spoiling! Hate this northern clime" ,PTAB>
		<ITALICIZE "26 July">
		<TELL
". Gated Thriff to Miznia, via Atrii. Relief at last! Villagers perplexed but grateful" ,PTAB>
		<ITALICIZE "2 August">
		<TELL
". Mtn not dormant after all. Yonked a girgol just in nick of time.|  ">
		<ITALICIZE "9 August">
		<TELL
". Wilderness life stinks. Raccoon nest in chimney; guncho took flue and all! Broke last burin warding off Xmas pests. Better off up north?|  ">
		<ITALICIZE "13 August">
		<TELL ". Borphee tomorrow. Y'Gael ">
		<ITALICIZE "must">
		<TELL " be wrong.\"||  ">
		<DESCRIBE-GLYPH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-GLYPH ()
	 <MAKE ,DIARY ,MUNGED>
	 <TELL 
"A tiny glyph is scrawled beside the entry dated \"9 August.\" It">
	 <COND (<IS? ,GLYPH ,SEEN>
		<TELL " looks just like the one you saw outside." CR>
		<RTRUE>)>
	 <TELL "'s ">
	 <SAY-GLYPH>
	 <RFALSE>>

<OBJECT MAILBOX
	(LOC ON-TRAIL)
	(DESC "mailbox")
	(FLAGS NODESC TRYTAKE NOALL CONTAINER OPENABLE)
	(CAPACITY 10)
	(SYNONYM MAILBOX BOX)
	(ADJECTIVE MAIL)
	(ACTION MAILBOX-F)>

<ROUTINE MAILBOX-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<RFALSE>)
	       (<SET X <MOVING?>>
		<TELL CTHEO " is rooted firmly in " THE ,GROUND ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LEAFLET
	(LOC MAILBOX)
	(DESC "leaflet")
	(FLAGS TAKEABLE READABLE)
	(SIZE 1)
	(VALUE 0)
	(SYNONYM LEAFLET PAPER MAIL AD ADVERTISEMENT)
	(ACTION LEAFLET-F)>

<ROUTINE LEAFLET-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<TELL
"It seems to be an advertisement for some curious form of entertainment." CR>
		<RTRUE>)
	       (<VERB? READ>
		<MOVE ,PARCEL <LOC ,PRSO>>
		<VANISH>
		<SETG P-IT-OBJECT ,PARCEL>
		<TELL "With a silent puff, " THEO
		      " turns into " A ,PARCEL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PARCEL
	(DESC "parcel")
	(FLAGS TAKEABLE CONTAINER OPENABLE)
	(SIZE 3)
	(VALUE 0)
	(SYNONYM PARCEL PACKAGE BOX MAIL ADDRESS)
	(ACTION PARCEL-F)>

<ROUTINE PARCEL-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO " is from the ">
		<FROBOZZ "Magic Equipment">
		<TELL ", and is addressed to \"Orkan/Thriff/North Frobozz.\" Curiously, the words \"North Frobozz\" have been scratched out, and the word \"Miznia\" scribbled over them as an afterthought." CR>
		<RTRUE>)
	       (<VERB? SHAKE>
		<TELL "Feels as if there's something inside." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
	        <WINDOW ,SHOWING-ALL>
		<SET X <LOC ,PRSO>>
		<REMOVE ,PRSO>
		<MOVE ,BURIN .X>
		<SETG P-IT-OBJECT ,BURIN>
		<TELL "All traces of " THE ,PARCEL
" disappear in a puff as you open it, leaving the contents">
		<COND (<EQUAL? .X ,PLAYER ,HERE <LOC ,PLAYER>>
		       <TELL C ,SP B ,W?BEHIND>)
		      (T
		       <ON-IN .X>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BURIN
	(DESC "burin")
	(FLAGS TAKEABLE FERRIC)
	(SIZE 3)
	(VALUE 5)
	(SYNONYM BURIN STYLUS)
	(ACTION BURIN-F)>

<ROUTINE BURIN-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? WRITE-WITH>
		       <COND (<PRSO? GGLYPH GLYPH>
			      <PERFORM ,V?WRITE-ON ,PRSO ,GROUND>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO
" is long and tapered, with a diamond tip for precision inscribing. The words \"">
		<FROBOZZ "Burin">
		<TELL "\" are inscribed along the side." CR>
		<RTRUE>)
	       (<VERB? USE>
		<PERFORM ,V?WRITE-ON ,GGLYPH ,GROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>
 	    
<OBJECT BRIDGE
	(LOC LOCAL-GLOBALS)
	(DESC "bridge")
	(FLAGS NODESC PLACE)
	(SYNONYM BRIDGE)
	(ACTION BRIDGE-F)>

<ROUTINE BRIDGE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " leads ">
		<SET X ,W?SOUTHWEST>
		<COND (<HERE? AT-BRINE>
		       <SET X ,W?NORTHEAST>)>
		<TELL B .X ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND SEARCH>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? STAND-UNDER LEAP>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<SET X ,P?SW>
		<COND (<HERE? AT-BRINE>
		       <SET X ,P?NE>)>
		<DO-WALK .X>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<NOT-ON>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FOOD
	(LOC IMPTAB)
	(DESC "food")
	(FLAGS TRYTAKE NOALL)
	(SYNONYM FOOD)
	(ACTION FOOD-F)>

<ROUTINE FOOD-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE SMELL>
		<TELL "Your stomach growls." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<OBJECT DEBRIS
	(LOC LOCAL-GLOBALS)
	(DESC "debris")
	(FLAGS NODESC TRYTAKE NOALL SURFACE)
	(SYNONYM DEBRIS DUST DIRT JUNK)
	(ACTION DEBRIS-F)>

<ROUTINE DEBRIS-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE
		       LOOK-UNDER SEARCH LOOK-BEHIND
		       REACH-IN>
		<TELL "You rummage through " THEO>
		<BUT-FIND-NOTHING>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<TELL "A waste of time. " CTHEO
		      " is obviously useless." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<OBJECT EASEL
	(LOC ON-WHARF)
	(DESC "easel")
	(FLAGS VOWEL TRYTAKE NODESC SURFACE)
	(SYNONYM EASEL)
	(ACTION EASEL-F)>

<ROUTINE EASEL-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON PUT EMPTY-INTO>
		       <YOUD-HAVE-TO "remove" ,CANVAS>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <MOVING?>>
		<SHOO>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "There's " A ,CANVAS " on it." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SHOO ()
	 <MAKE ,SALT ,SEEN>
	 <TELL "\"Hands off,\" snaps " THE ,SALT ,PERIOD>
	 <RTRUE>> 
	 
<OBJECT CANVAS
	(LOC EASEL)
	(DESC "canvas")
	(FLAGS TRYTAKE SURFACE)
	(SYNONYM CANVAS PAINTING PICTURE ART GALLEON SHIP)
	(ACTION CANVAS-F)>

<ROUTINE CANVAS-F ("AUX" X)
	 <COND (<SET X <TOUCHING?>>
		<SHOO>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"A magnificent galleon is taking shape on the canvas, soaring across the sky on planes of sparkling Magick." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT APOTION
	(DESC "cloudy potion")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE)
	(SYNONYM ZZZP POTION POTIONS)
	(ADJECTIVE ZZZP CLOUDY)
	(SIZE 1)
	(VALUE 12)
	(DESCFCN 0)
	(ACTION 0)>

<OBJECT BPOTION
	(DESC "dark potion")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE)
	(SYNONYM ZZZP POTION POTIONS)
	(ADJECTIVE ZZZP DARK)
	(SIZE 1)
	(VALUE 12)
	(DESCFCN 0)
	(ACTION 0)>

<OBJECT CPOTION
	(DESC "clear potion")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE)
	(SYNONYM ZZZP POTION POTIONS)
	(ADJECTIVE ZZZP CLEAR)
	(SIZE 1)
	(VALUE 12)
	(DESCFCN 0)
	(ACTION 0)>

<OBJECT DPOTION
	(DESC "gray potion")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE)
	(SYNONYM ZZZP POTION POTIONS)
	(ADJECTIVE ZZZP GRAY GREY)
	(SIZE 1)
	(VALUE 12)
	(DESCFCN 0)
	(ACTION 0)>

<OBJECT EPOTION
	(DESC "milky potion")
	(SDESC 0)
	(FLAGS NODESC TAKEABLE)
	(SYNONYM ZZZP POTION POTIONS)
	(ADJECTIVE ZZZP MILKY MILK)
	(SIZE 1)
	(VALUE 12)
	(DESCFCN 0)
	(ACTION 0)>



<ROUTINE IQ-POTION-F ()
	 <RETURN <HANDLE-POTION? ,I-IQ>>>

<ROUTINE HEALING-POTION-F ()
	 <RETURN <HANDLE-POTION? ,I-HEAL>>>

<ROUTINE DEATH-POTION-F ()
	 <RETURN <HANDLE-POTION? ,I-DEATH>>>

<ROUTINE MIGHT-POTION-F ()
	 <RETURN <HANDLE-POTION? ,I-MIGHT>>>

<ROUTINE FORGET-POTION-F ()
	 <RETURN <HANDLE-POTION? ,I-FORGET>>>

<ROUTINE NEXT-POTION? ("OPT" RM FCN "AUX" OBJ X)
	 <SET OBJ <PICK-ONE ,POTION-LIST>>
	 <COND (<IS? .OBJ ,NODESC>
		<UNMAKE .OBJ ,NODESC>
		<SET X <PICK-ONE ,POTION-TABLES>>
		<PUTP .OBJ ,P?ACTION <GET .X 0>>
		<PUTP .OBJ ,P?SDESC <GET .X 1>>
		<SET X <GET .X 2>>
		<PUT <GETPT .OBJ ,P?SYNONYM> 0 .X>
		<PUT <GETPT .OBJ ,P?ADJECTIVE> 0 .X>
		<COND (<ASSIGNED? RM>
		       <MOVE .OBJ .RM>)>
		<COND (<ASSIGNED? FCN>
		       <PUTP .OBJ ,P?DESCFCN .FCN>)>
		<RETURN .OBJ>)
	       (T
	      ; <SAY-ERROR "NEXT-POTION?">
		<RFALSE>)>>

<ROUTINE HANDLE-POTION? (INT)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? POUR-FROM>
		       <PRINT "Wastrel.|">
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<MAKE ,BPOTION ,SEEN>
		<TELL
"A legend on the potion says, \"Shake before using. Another fine product of the ">
		<FROBOZZ "Potion">
		<TELL ,PERQ>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<TELL ,XTHE B <GET <GETPT ,PRSO ,P?ADJECTIVE> 1>
		      " liquid ">
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL "swirls with potency." CR>
		       <RTRUE>)>
		<TELL "looks a bit flat." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<TELL ,DONT 
"need to. It'll open itself when you drink it." CR>
		<RTRUE>)
	       (<VERB? POUR EMPTY EMPTY-INTO>
		<PRINT "Wastrel.|">
		<RTRUE>)
	       (<VERB? CLOSE>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (<VERB? SHAKE>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)>
		<MAKE ,PRSO ,MUNGED>
		<TELL "You give the potion a vigorous shake." CR>
		<RTRUE>)
	       (<VERB? DRINK USE>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding">
		       <RTRUE>)
		      (<AND <IS? ,PRSO ,MUNGED>
			    <NOT <IS? ,PRSO ,NEUTRALIZED>>>
		       <QUEUE .INT 2>)>
		<VANISH>
		<TELL "Gloop, gloop, gloop! You drain " THEO
" to the last drop, and watch as the container melts into nothingness." CR>
		<COND (<IN? ,OWOMAN ,HERE>
		       <MAKE ,OWOMAN ,SEEN>
		       <TELL "  \"">
		       <COND (<NOT <IS? ,BPOTION ,SEEN>>
			      <TELL "Should've read it first">)
			     (<AND <EQUAL? .INT ,I-DEATH>
				   <IS? ,PRSO ,MUNGED>
				   <NOT <IS? ,PRSO ,NEUTRALIZED>>>
			      <TELL "Nice knowing you">)
			     (T
			      <TELL "Cheers">)>
		       <TELL ",\" mutters " THE ,OWOMAN ,PERIOD>)>
		<RTRUE>)
	       (<FIRST-TAKE?>
		<RTRUE>)
	       (<VERB? MUNG CUT HIT>
		<TELL "And risk breaking this expensive " D ,PRSO "? ">
		<WASTE-OF-TIME>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CAKE
	(DESC "fish cake")
	(FLAGS NODESC TAKEABLE)
	(SYNONYM CAKE FISH)
	(ADJECTIVE FISH)
	(SIZE 1)
	(VALUE 2)
	(DESCFCN CAKE-F)
	(ACTION CAKE-F)>

<ROUTINE CAKE-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,CAKE>
		       <PRINT " lies at your feet.">
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<FIRST-TAKE?>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<JUST-LIKE ,W?LOOK>
		<RTRUE>)
	       (<VERB? SMELL KISS>
		<JUST-LIKE ,W?SMELL>
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<COND (<NOT <IS? ,PRSO ,NEUTRALIZED>>
		       <QUEUE ,I-IQ 4>)>
		<VANISH>
		<TELL "With a mighty effort of will, you cram " THEO
		      " into your mouth, chew and swallow. Bleah." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE JUST-LIKE (WRD)
	 <TELL "It " B .WRD
"s just like the ones your aunt used to make. Bleah." CR>
	 <RTRUE>>

<OBJECT HEAP
	(LOC IN-LAIR)
	(DESC "mound of plunder")
	(FLAGS NODESC TRYTAKE SURFACE)
	(SYNONYM MOUND HEAP PILE PLUNDER TREASURE TREASURES)
	(ADJECTIVE TREASURE)
	(CAPACITY 100)
	(CONTFCN HEAP-F)
	(ACTION HEAP-F)>

<ROUTINE HEAP-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<AND <EQUAL? .CONTEXT ,M-CONT>
			    <URGRUE-STOPS?>>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <SET X <TOUCHING?>>
		     <URGRUE-STOPS?>>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? COUNT>
		<TELL 
"A rapid survey turns up at least 69,105 treasures." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"The exotic treasures piled here are almost beyond counting">
		<COND (<SEE-ANYTHING-IN?>
		       <TELL ". Among them you see ">
		       <CONTENTS>
		       <SETG P-IT-OBJECT ,PRSO>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<OR <VERB? LOOK-INSIDE SEARCH LOOK-BEHIND LOOK-UNDER>
		    <SET X <MOVING?>>>
		<COND (<URGRUE-STOPS?>
		       <RTRUE>)
		      (<IS? ,COCO ,NODESC>
		       <UNMAKE ,COCO ,NODESC>
		       <WINDOW ,SHOWING-ROOM>
		       <MOVE ,COCO ,IN-LAIR>
		       <SETG P-IT-OBJECT ,COCO>
		       <TELL "As you sift excitedly through " THEO 
", something small and hard rolls out and lands on your toe. Ouch!" CR>
		       <RTRUE>)>
		<TELL 
"It'd take weeks to sift through everything else." CR>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<COND (<URGRUE-STOPS?>
		       <RTRUE>)>
		<TELL "Stop gloating." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE URGRUE-STOPS? ()
	 <COND (<IN? ,URGRUE ,HERE>
		<TELL 
"\"Do keep away from that,\" urges " THE ,URGRUE ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT COCO
        (LOC IMPS)
	(DESC "coconut")
	(FLAGS TAKEABLE)
	(SIZE 5)
	(VALUE 0)
	(SYNONYM COCONUT NUT QUENDOR)
	(ACTION COCO-F)>

<ROUTINE COCO-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "It's hard to see what all the fuss is about." CR>
		<RTRUE>)
	       (<AND <SET X <TOUCHING?>>
		     <NOT <IS? ,COCO ,SEEN>>>
		<URGRUE-GETS-COCO>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<ITAKE>
		       <QUEUE ,I-QUAKE>
		       <TELL
"An angelic choir swells as you lift " THEO " off the floor." CR>)>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "Phew! It's a few centuries overripe." CR>
		<RTRUE>)
	       (<VERB? HIT MUNG CUT KICK KNOCK OPEN OPEN-WITH>
		<TELL "Thump! Hard as a rock." CR>
		<RTRUE>)
	       (<VERB? EAT TASTE DRINK DRINK-FROM
		       LOOK-INSIDE REACH-IN EMPTY>
		<YOUD-HAVE-TO "open">
		<RTRUE>)
	       (<VERB? SHAKE>
		<TELL "Something slooshes around inside." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       	        
<OBJECT BOULDER
	(DESC "boulder")
	(FLAGS NODESC TRYTAKE NOALL SURFACE READABLE)
	(SYNONYM BOULDER ROCK STONE FACE
	 	 INSCRIPTION WRITING WORDS RIDDLE YOUTH)
	(DESCFCN BOULDER-F)
	(ACTION BOULDER-F)>

<ROUTINE BOULDER-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <PRINT "An inscription is carved upon the face of ">
		       <TELL "an enormous boulder.">
		       <RTRUE>)>
		<RFALSE>)
	       (<NOUN-USED? ,W?YOUTH>
		<OPEN-POOL>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE READ LOOK-ON>
		<TELL "The carved " 'RIDDLE " reads,||">
		<HLIGHT ,H-MONO>
		<TELL 
"\"Never ahead, ever behind,|
 Yet flying swiftly past;|
 For a child, I last forever,|
 For adults, I'm gone too fast.|
 What am I?\"" CR>
		<HLIGHT ,H-NORMAL>
		<RTRUE>)
	       (<SET X <MOVING?>>
		<TELL CTHEO " is much too big and heavy." CR>
		<RTRUE>)
	       (<SET X <CLIMBING-ON?>>
		<NO-FOOTHOLDS>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<NOT-ON>
		<RTRUE>)
	       (T
		<RFALSE>)>>


