
"RARITIES for Beyond Zork
 Copyright (C)1987 Infocom, Inc. All rights reserved."

<OBJECT INTNUM
	(LOC GLOBAL-OBJECTS)
	(DESC "number")
	(FLAGS NODESC)
	(SDESC DESCRIBE-INTNUM)
	(SYNONYM INTNUM)>

<ROUTINE DESCRIBE-INTNUM (OBJ)
	 <TELL 'INTNUM C ,SP N ,P-NUMBER>
	 <RTRUE>>

<OBJECT IT
	(LOC GLOBAL-OBJECTS)
	(DESC "it")
	(FLAGS VOWEL NOARTICLE NODESC TOUCHED)
	(SYNONYM IT THAT ITSELF THING SOMETHING)>

<ROUTINE BE-SPECIFIC ()
	 <TELL "[Be specific: what do you want to ">
	 <RTRUE>>

<ROUTINE TO-DO-THING-USE (STR1 STR2)
	 <TELL "[To " .STR1 C ,SP B ,W?SOMETHING ", use the command: " 
	       .STR2 " THING.]" CR>
	 <RTRUE>>

<ROUTINE CANT-USE (PTR "AUX" BUF) 
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>
	<SET BUF <REST ,P-LEXV <* .PTR 2>>>
	<TELL "[This story can't understand the word \"">	
	<WORD-PRINT <GETB .BUF 2> <GETB .BUF 3>>
	<TELL "\" when you use it that way.]" CR>
	<RTRUE>>

<ROUTINE DONT-UNDERSTAND ()
	<TELL "[Please try to express that another way.]" CR>
	<RTRUE>>

<ROUTINE NOT-IN-SENTENCE (STR)
	 <TELL "[There aren't " .STR " in that sentence.]" CR>
	 <RTRUE>>

<OBJECT WALLS
	(LOC GLOBAL-OBJECTS)
	(DESC "wall")
	(FLAGS NODESC TOUCHED SURFACE)
	(SYNONYM WALL WALLS)
	(ACTION WALLS-F)>
	 
<ROUTINE WALLS-F ()
	 <COND (<HERE? IN-GARDEN>)
	       (<NOT <IS? ,HERE ,INDOORS>>
		<CANT-SEE-ANY ,WALLS>
		<RFATAL>)>
	 <COND (<HANDLE-WALLS?>
		<RTRUE>)>
	 <USELESS ,WALLS>
	 <RFATAL>>
		
<ROUTINE HANDLE-WALLS? ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<OR <SET X <CLIMBING-ON?>>
		    <VERB? LOOK-BEHIND LOOK-UNDER>>
		<COND (<HERE? IN-GARDEN>
		       <TELL CTHEO " is much too high." CR>
		       <RTRUE>)>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<SET X <CLIMBING-OFF?>>
		<NOT-ON>
		<RTRUE>)
	       (<OR <SET X <HURTING?>>
		    <SET X <MOVING?>>>
		<TELL CTHEO>
		<TELL " isn't affected." CR>
		<RTRUE>)
	       (<SET X <TALKING?>>
		<TELL "Talking to walls">
		<WONT-HELP>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<OBJECT CEILING
	(LOC GLOBAL-OBJECTS)
	(FLAGS NODESC TOUCHED)
	(DESC "ceiling")
	(SYNONYM CEILING)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<NOT <IS? ,HERE ,INDOORS>>
		<CANT-SEE-ANY ,CEILING>
		<RFATAL>)
	       (<VERB? LOOK-UNDER>
		<V-LOOK>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT HANDS
	(LOC GLOBAL-OBJECTS)
	(DESC "your hand")
	(FLAGS TOOL MANUALLY WEAPON NODESC TOUCHED NOARTICLE)
	(SYNONYM HAND HANDS FINGER FINGERS FIST ZZZP)
	(ADJECTIVE MY OWN BARE ZZZP ZZZP)
	(EFFECT 1)
	(SIZE 5)
	(ACTION HANDS-F)>
       
<ROUTINE HANDS-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? SCRAPE-ON>
			    <T? ,MOSS-TIMER>>
		       <DO-MOSS>
		       <RTRUE>)
		      (<VERB? TIE PUT PUT-ON EMPTY-INTO>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<COND (<T? ,MOSS-TIMER>
		       <DO-MOSS>
		       <RTRUE>)>
		<TELL ,CYOUR>
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL "long, slender ">)>
		<TELL "fingers are still there." CR>		      
		<RTRUE>)
	       (<VERB? COUNT>
		<TELL "You still have ">
		<COND (<NOUN-USED? ,W?FINGERS ,W?FINGER>
		       <TELL "ten">)
		      (T
		       <TELL "two">)>
		<TELL " of them." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<V-INVENTORY>
		<RTRUE>)
	       (<VERB? PUT PUT-UNDER PUT-BEHIND>
		<PERFORM ,V?REACH-IN ,PRSI>
		<RTRUE>)
	       (<VERB? PUT-ON>
		<PERFORM ,V?TOUCH ,PRSI>
		<RTRUE>)
	       (<VERB? SCRATCH>
		<COND (<T? ,MOSS-TIMER>
		       <DO-MOSS>
		       <RTRUE>)>
		<TELL "Your hand isn't itchy" ,AT-MOMENT>
		<RTRUE>)
	       (<SET X <MUST-HAVE?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FEET
	(LOC GLOBAL-OBJECTS)
	(DESC "your foot")
	(FLAGS CLOTHING WORN NODESC NOARTICLE SURFACE)
	(SYNONYM FOOT FEET TOE TOES SNEAKER SNEAKERS)
	(ADJECTIVE MY OWN)
	(EFFECT 1)
	(SIZE 5)
	(ACTION FEET-F)>

<ROUTINE FEET-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? PUT-ON>
		<PERFORM ,V?STAND-ON ,PRSI>
		<RTRUE>)
	       (<SET X <MUST-HAVE?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
			
<OBJECT MOUTH
	(LOC GLOBAL-OBJECTS)
	(DESC "your mouth")
	(SYNONYM MOUTH)
	(ADJECTIVE MY OWN)
	(FLAGS NODESC NOARTICLE TOUCHED)
	(ACTION MOUTH-F)>

<ROUTINE MOUTH-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON THROW>
		       <PERFORM ,V?EAT ,PRSO>
                       <RTRUE>)
		      (<VERB? TOUCH-TO>
		       <PERFORM ,V?TASTE ,PRSO>
		       <RTRUE>)>)
	       (<VERB? REACH-IN>
		<TELL "How rude." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<NO-NEED>
		<RTRUE>)
	       (<VERB? RAPE KICK KISS>
		<TELL "Good luck." CR>
		<RTRUE>)
	       (<SET X <MUST-HAVE?>>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <USELESS ,MOUTH>
	 <RFATAL>>

<OBJECT EYES
	(LOC GLOBAL-OBJECTS)
	(DESC "your eyes")
	(FLAGS NODESC NOARTICLE TOUCHED)
	(SYNONYM EYES)
	(ADJECTIVE MY OWN)
	(ACTION EYES-F)>

"SEEN = given PRE-DUMB-EXAMINE admonishment."

<ROUTINE EYES-F ("AUX" X)
	 <COND (<THIS-PRSI?>)
	       (<VERB? OPEN>
		<TELL "They are." CR>
		<RTRUE>)
	       (<VERB? CLOSE>
		<COND (<AND <EQUAL? ,LAST-MONSTER ,DORN>
			    <NOT <IS? ,LAST-MONSTER ,MUNGED>>>
		       <TELL "Something about " THE ,LAST-MONSTER
"'s roving gaze forces your eyes to snap open." CR>
		       <RTRUE>)
		      (<T? ,LAST-MONSTER>
		       <TELL "That won't make " THE ,LAST-MONSTER
			     " go away." CR>
		       <RTRUE>)>
		<V-SLEEP>
		<RTRUE>)
	       (<SET X <MUST-HAVE?>>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <USELESS ,EYES>
	 <RFATAL>>
		
<OBJECT HEAD
	(LOC GLOBAL-OBJECTS)
	(DESC "your head")
	(FLAGS NODESC SURFACE TOUCHED NOARTICLE)
	(SYNONYM HEAD NECK)
	(ADJECTIVE MY OWN)
	(ACTION HEAD-F)>

<ROUTINE HEAD-F ("AUX" X)
	 <COND (<AND <THIS-PRSI?>
		     <VERB? PUT-ON>>
		<COND (<PRSO? HELM>
		       <PERFORM ,V?WEAR ,PRSO>
		       <RTRUE>)>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<SET X <MUST-HAVE?>>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <USELESS ,HEAD>
	 <RFATAL>>

<OBJECT PLAYER
	(SYNONYM PROTAGONIST)
	(DESC "yourself")
      ; (SDESC SAY-CHARNAME)
	(FLAGS TRANSPARENT NODESC NOARTICLE PROPER)
	(SIZE 0)
	(NAME-TABLE CHARNAME)
	(CAPACITY 1000)>

<OBJECT ME
        (LOC GLOBAL-OBJECTS)
	(DESC "yourself")
	(FLAGS PERSON LIVING TOUCHED NOARTICLE)
	(SYNONYM I ME MYSELF SELF BODY)
	(ADJECTIVE MY OWN)
	(ACTION ME-F)>

<ROUTINE ME-F ("OPT" (CONTEXT <>) "AUX" (ANY <>) OBJ NXT X) 
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <WASTE-OF-TIME>
		       <RTRUE>)
		      (<VERB? COVER>
		       <PERFORM ,V?STAND-ON ,PRSO>
		       <RTRUE>)
		      (<VERB? PUT-ON WRAP-AROUND>
		       <COND (<IS? ,PRSO ,CLOTHING>
			      <PERFORM ,V?WEAR ,PRSO>
			      <RTRUE>)>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<VERB? PUT>
		       <PERFORM ,V?TASTE ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH>
		<TELL "You're ">
		<SET OBJ <FIRST? ,WINNER>>
		<REPEAT ()
			<COND (<ZERO? .OBJ>
			       <RETURN>)>
			<SET NXT <NEXT? .OBJ>>
			<COND (<IS? .OBJ ,WORN>
			       <SET ANY T>
			       <MOVE .OBJ ,DUMMY-OBJECT>)>
			<SET OBJ .NXT>>
		<COND (<ZERO? .ANY>
		       <TELL "not wearing anything special." CR>
		       <RTRUE>)>
		<TELL "wearing ">
		<CONTENTS ,DUMMY-OBJECT>
		<PRINT ,PERIOD>
		<MOVE-ALL ,DUMMY-OBJECT ,WINNER>
		<RTRUE>)
	       (<VERB? NAME>
		<TELL "You already have a name. It's ">
		<PRINT-TABLE ,CHARNAME>
		<TELL ,PERIOD>
		<RFATAL>)
	       (<VERB? LISTEN SMELL>
		<TELL ,CANT "help doing that." CR>
		<RTRUE>)
	       (<VERB? FIND FOLLOW>
	        <PRINT "You're right here.|">
		<RTRUE>)
	       (<VERB? RAPE KISS>
		<TELL "Desperate?" CR>
		<RTRUE>)
	       (<VERB? HIT>
		<TELL "You're indispensable." CR>
		<RTRUE>)
	       (<SET X <HURTING?>>
		<TELL "Punishing ">
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <TELL "your">)
		      (<IS? ,WINNER ,FEMALE>
		       <TELL "her">)
		      (<IS? ,WINNER ,PERSON>
		       <TELL "him">)
		      (T
		       <TELL "it">)>
		<TELL "self that way">
		<WONT-HELP>
		<RTRUE>)
	       (<YOU-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT YOU
	(LOC GLOBAL-OBJECTS)
	(DESC "myself")
	(SYNONYM YOU YOURSELF US)
	(FLAGS NODESC NOARTICLE)
	(ACTION YOU-F)>
	       
<ROUTINE YOU-F ("AUX" X)
	 <COND (<VERB? WHO WHAT WHERE>
		<TELL "Good question." CR>
		<RTRUE>)
	       (<VERB? UNDRESS>
		<INAPPROPRIATE>
		<RTRUE>)
	       (<OR <VERB? EAT TASTE DRINK DRINK-FROM>
		    <SET X <MUST-HAVE?>>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE INAPPROPRIATE ()
	 <TELL "That would hardly be an appropriate thing to do." CR>
	 <RTRUE>>

<ROUTINE WONT-HELP ()
	 <TELL " isn't likely to help matters." CR>
	 <RTRUE>>

<OBJECT GLOBAL-ROOM
	(LOC GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM AREA PLACE LANDSCAPE HORIZON)
	(ADJECTIVE OPENED THIS)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ("AUX" X)
	 <COND (<AND <IS? ,HERE ,INDOORS>
		     <NOUN-USED? ,W?LANDSCAPE ,W?HORIZON>>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<OR <SET X <ENTERING?>>
		    <VERB? DROP EXIT>>
		<V-WALK-AROUND>
		<RFATAL>)
	       (<VERB? WALK-AROUND>
		<TELL
"Walking around the area reveals nothing new" ,PTAB
"[If you want to go somewhere, simply indicate a " 'INTDIR ".]" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE CANT-SEE-ANY ("OPT" (THING ,NOT-HERE-OBJECT) (STRING? <>))
         <SETG CLOCK-WAIT? T>
	 <PCLEAR>
	 <THIS-IS-IT ,NOT-HERE-OBJECT>
	 <TELL ,CANT>
	 <COND (<VERB? LISTEN>
		<TELL B ,W?HEAR>)
	       (<VERB? SMELL>
		<TELL B ,W?SMELL>)
	       (T
		<TELL B ,W?SEE>)>
	 <TELL C ,SP>
	 <COND (<T? .STRING?>
		<TELL .THING>)
	       (T
		<COND (<IS? .THING ,PROPER>
		       <TELL ,LTHE>)
		      (<NOT <IS? .THING ,NOARTICLE>>
		       <TELL "any ">)>
		<TELL D .THING>)>
	 <TELL " here." CR>
	 <RTRUE>>

<ROUTINE HOW? ()
         <TELL "A noble idea. How do you intend to do it?" CR>
	 <RTRUE>>
	 			      
<ROUTINE NOT-LIKELY ("OPT" (OBJ ,PRSO))
	 <TELL "It" <PICK-NEXT ,LIKELIES> " that " THE .OBJ>
	 <RTRUE>>

<ROUTINE YOUD-HAVE-TO (STR "OPT" (OBJ ,PRSO))
         <THIS-IS-IT .OBJ>
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You'd ">)
	       (T
		<TELL CTHE ,WINNER " would ">)>
	 <TELL "have to " .STR C ,SP THE .OBJ " to do that." CR>
	 <RTRUE>>

<OBJECT HER
	(LOC GLOBAL-OBJECTS)
	(DESC "her")
	(FLAGS NODESC NOARTICLE PERSON LIVING FEMALE)
	(SYNONYM SHE HER HERSELF)>

<OBJECT HIM
	(LOC GLOBAL-OBJECTS)
	(DESC "him")
	(FLAGS NODESC NOARTICLE PERSON LIVING)
	(SYNONYM HE HIM HIMSELF)>

<OBJECT THEM
	(LOC GLOBAL-OBJECTS)
	(DESC "them")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM THEY THEM THEMSELVES)>

<OBJECT INTDIR
	(LOC GLOBAL-OBJECTS)
	(DESC "direction")
	(FLAGS NODESC)
	(SYNONYM DIRECTION)
	(ADJECTIVE NORTH EAST SOUTH WEST W NE NW SE SW UP DOWN)>

<OBJECT GROUND
	(LOC GLOBAL-OBJECTS)
	(DESC "ground")
	(FLAGS NODESC)
	(SYNONYM SURFACE GROUND GROUNDS EARTH ZZZP)
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ("AUX" OBJ NXT X)
	 <COND (<AND <HERE? IN-SKY>
		     <SET X <TOUCHING?>>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT-ON PUT THROW THROW-OVER>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (<VERB? WRITE-ON>
		       <COND (<NOT <PRSO? GLYPH GGLYPH>>
			      <IMPOSSIBLE>
			      <RTRUE>)>
		       <WRITE-GLYPH>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH>
		<COND (<SET OBJ <FIRST? ,HERE>>
		       <REPEAT ()
			  <SET NXT <NEXT? .OBJ>>
			  <COND (<OR <IS? .OBJ ,NODESC>
				     <NOT <IS? .OBJ ,TAKEABLE>>>
				 <MOVE .OBJ ,C-OBJECT>)>
			  <SET OBJ .NXT>
			  <COND (<ZERO? .OBJ>
				 <RETURN>)>>)>
		<TELL ,YOU-SEE>
		<CONTENTS ,HERE>
		<TELL " on the ">
		<GROUND-WORD>
		<TELL ,PERIOD>
		<MOVE-ALL ,C-OBJECT ,HERE>
		<RTRUE>)
	       (<VERB? CROSS>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? LOOK-UNDER>
		<TELL 
"Unfortunately, you left your X-ray glasses at home." CR>
		<RTRUE>)
	       (<VERB? DIG DIG-UNDER>
		<TELL "You dig around with " THEI>
		<BUT-FIND-NOTHING>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FLOOR
	(LOC GLOBAL-OBJECTS)
	(DESC "floor")
	(SYNONYM FLOOR)
	(ACTION FLOOR-F)>

<ROUTINE FLOOR-F ("AUX" X)
	 <COND (<NOT <IS? ,HERE ,INDOORS>>
		<CANT-SEE-ANY ,FLOOR>
		<RFATAL>)>
	 <SET X <GETB ,CAVE-ROOMS 0>>
	 <COND (<SET X <INTBL? ,HERE <REST ,CAVE-ROOMS 1> .X 1>>)
	       (<HERE? IN-LAIR NE-CAVE SE-CAVE>)
	       (<VERB? DIG DIG-UNDER>
		<TELL ,CANT "do that here." CR>
		<RTRUE>)>
	 <RETURN <GROUND-F>>> 

<ROUTINE NO-NEED ()
	 <TELL ,DONT "need to do that." CR>
	 <RTRUE>>

<ROUTINE NOT-IN ("OPT" (THING ,PRSO))
	 <THIS-IS-IT .THING>
	 <TELL "You're not in " THE .THING ,PERIOD>
	 <RTRUE>>

<ROUTINE NOT-ON ("OPT" (THING ,PRSO))
	 <THIS-IS-IT .THING>
	 <TELL "You're not on " THE .THING ,PERIOD>
	 <RTRUE>>

<ROUTINE ALREADY-IN ("OPT" (THING ,PRSO))
	 <THIS-IS-IT .THING>
	 <TELL ,ALREADY "in " THE .THING ,PERIOD>
	 <RTRUE>>

<ROUTINE ALREADY-ON ("OPT" (THING ,PRSO))
	 <THIS-IS-IT .THING>
	 <TELL ,ALREADY "on " THE .THING ,PERIOD>
	 <RTRUE>>

<ROUTINE ALREADY-AT-TOP ("OPT" (OBJ ,PRSO))
	 <ALREADY-AT "top" .OBJ>
	 <RTRUE>>

<ROUTINE ALREADY-AT-BOTTOM ("OPT" (OBJ ,PRSO))
	 <ALREADY-AT "bottom" .OBJ>
	 <RTRUE>>

<ROUTINE ALREADY-AT (STR "OPT" (OBJ ,PRSO))
	 <THIS-IS-IT .OBJ>
	 <TELL ,ALREADY "at the " .STR " of " THE .OBJ ,PERIOD>
	 <RTRUE>>

<ROUTINE CANT-SEE-MUCH ()
	 <PRINT "Little can be seen ">
	 <TELL "from here." CR>
	 <RTRUE>>

; <ROUTINE CANT-SEE-FROM-HERE ("OPT" (THING ,PRSO))
         <TELL ,CANT "see " THE .THING " from here." CR>
	 <RTRUE>>

<ROUTINE NOT-A (STR)
	 <TELL "You're an adventurer, not a " .STR ,PERIOD>
	 <RTRUE>>

<ROUTINE OPEN-CLOSED ("OPT" (THING ,PRSO) (VOWEL <>))
         <COND (<IS? .THING ,OPENED>
		<COND (<T? .VOWEL>
		       <TELL "n">)>
		<TELL " open ">)
	       (T
		<TELL " closed ">)>
	 <TELL D .THING>
	 <RTRUE>>

<ROUTINE CANT-FROM-HERE ()
	 <TELL ,IMPOSSIBLY "do that">
	 <STANDING>
	 <RTRUE>>
		       
<ROUTINE STANDING ("OPT" X)
	 <COND (<NOT <ASSIGNED? X>>
		<TELL " from where you're ">)>
	 <COND (<EQUAL? <LOC ,PLAYER> ,SADDLE ,PEW>
		<TELL "sitt">)
	       (T
		<TELL B ,W?STAND>)>
	 <TELL "ing">
	 <COND (<NOT <ASSIGNED? X>>
		<PRINT ,PERIOD>)>
	 <RTRUE>>

; <ROUTINE ITS-EMPTY ("OPT" (OBJ ,PRSO))
	 <TELL CTHE .OBJ>
	 <IS-ARE .OBJ>
	 <TELL B ,W?EMPTY ,PERIOD>
	 <RTRUE>>

<ROUTINE IS-ARE ("OPT" (THING ,PRSO))
         <PRINTC ,SP>
	 <COND (<IS? .THING ,PLURAL>
		<TELL "are ">
		<RTRUE>)>
	 <TELL "is ">
	 <RTRUE>>

<ROUTINE ISNT-ARENT ("OPT" (THING ,PRSO))
         <PRINTC ,SP>
	 <COND (<IS? .THING ,PLURAL>
		<TELL "are">)
	       (T
		<TELL "is">)>
	 <TELL "n't">
	 <RTRUE>>

; <ROUTINE WHICH-WAY (STR)
	 <TELL "[Which way do you want to go " .STR "?]" CR>
	 <RTRUE>>

<ROUTINE FIRMLY-ATTACHED (THING TO "OPT" (STR <>))
	 <COND (<ZERO? .STR>
		<THIS-IS-IT .THING>
		<TELL CTHE .THING>
		<IS-ARE .THING>)
	       (T
		<THIS-IS-IT .TO>
		<TELL ,XTHE .THING ,SIS>)>
	 <TELL <PICK-NEXT ,FIRMS> "ly "
	       <PICK-NEXT ,ATTACHES> ,STO THE .TO ,PERIOD>
	 <RTRUE>>

<ROUTINE HERE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND LOOK-OUTSIDE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? ENTER WALK-TO FIND>
		<ALREADY-IN>
		<RTRUE>)
	       (<OR <SET X <CLIMBING-ON?>>
		    <SET X <CLIMBING-OFF?>>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GLOBAL-HOLE
	(LOC GLOBAL-OBJECTS)
	(DESC "hole")
	(FLAGS NODESC)
	(SYNONYM HOLE)
	(ACTION GLOBAL-HOLE-F)>

<ROUTINE GLOBAL-HOLE-F ()
	 <COND (<VERB? DIG SDIG>
		<WASTE-OF-TIME>
		<RTRUE>)>
	 <TELL ,CANT "see any here." CR>
	 <RTRUE>>	  
		 
<OBJECT SOUND
	(LOC GLOBAL-OBJECTS)
	(DESC "sound")
	(FLAGS NODESC)
	(SYNONYM SOUND SOUNDS NOISE NOISES)
	(ACTION SOUND-F)>

<ROUTINE SOUND-F ("AUX" X)
	 <SET X <GETP ,HERE ,P?HEAR>>
	 <COND (<T? .X>
		<COND (<THIS-PRSO?>
		       <PERFORM ,PRSA .X ,PRSI>
		       <RTRUE>)>
	        <PERFORM ,PRSA ,PRSO .X>
		<RTRUE>)
	       (<OR <SET X <SEEING?>>
		    <SET X <TOUCHING?>>>
		<IMPOSSIBLE>		       
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GCORNER
	(LOC GLOBAL-OBJECTS)
	(DESC "corner")
	(FLAGS NODESC SURFACE)
	(SYNONYM CORNER CORNERS)
	(ACTION GCORNER-F)>

<ROUTINE GCORNER-F ("AUX" X)
	 <COND (<NOT <IS? ,HERE ,INDOORS>>
		<CANT-SEE-ANY ,GCORNER>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE LOOK-ON
		       SEARCH LOOK-BEHIND LOOK-UNDER>
		<V-LOOK>
		<RTRUE>)
	       (<SET X <ENTERING?>>
		<TELL ,ALREADY "close enough to " THEO ,PERIOD>
		<RTRUE>)
	       (<SET X <EXITING?>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RIGHT
	(LOC GLOBAL-OBJECTS)
	(DESC "that direction")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM RIGHT CLOCKWISE FORWARD AHEAD)
	(ACTION RL-F)>

<OBJECT LEFT
	(LOC GLOBAL-OBJECTS)
	(DESC "that direction")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM LEFT COUNTERCL BACKWARD BACKWARDS BACK)
	(ACTION RL-F)>

<ROUTINE RL-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<OR <SET X <CLIMBING-ON?>>
		    <SET X <CLIMBING-OFF?>>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT GAME
	(LOC GLOBAL-OBJECTS)
	(DESC "this game")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM ZORK GAME STORY)
	(ACTION GAME-F)>
				       
<ROUTINE GAME-F ()
	 <COND (<VERB? TOUCH READ EXAMINE>
		<TELL "[That's what you're doing.]" CR>
		<RFATAL>)>
	 <USELESS ,GAME>
	 <RFATAL>>

<CONSTANT YES-INBUF-LENGTH 14>
<CONSTANT YES-INBUF <ITABLE ,YES-INBUF-LENGTH (BYTE) 0>>

<CONSTANT YES-LEXV-LENGTH 10>
<CONSTANT YES-LEXV <ITABLE ,YES-LEXV-LENGTH (BYTE) 0>>

<ROUTINE READ-YES-LEXV ("AUX" KEY)
	 <COPYT ,YES-LEXV 0 ,YES-LEXV-LENGTH>
	 <PUTB ,YES-LEXV 0 2>
	 <COPYT ,YES-INBUF 0 ,YES-INBUF-LENGTH>
	 <PUTB ,YES-INBUF 0 <- ,YES-INBUF-LENGTH 2>>
	 <REPEAT ()
		 <COLOR ,INCOLOR ,BGND>
		 <SET KEY <READ ,YES-INBUF ,YES-LEXV>>
		 <COND (<EQUAL? .KEY ,EOL ,LF>
			<COLOR ,FORE ,BGND>
			<RFALSE>)>>>

<ROUTINE YES-WORD? (WORD)
	 <COND (<ZERO? .WORD>
		<RFALSE>)
	       (<EQUAL? .WORD ,W?Y ,W?YES ,W?YUP>
		<RTRUE>)
	       (<EQUAL? .WORD ,W?OKAY ,W?OK ,W?SURE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NO-WORD? (WORD)
	 <COND (<ZERO? .WORD>
		<RFALSE>)
	       (<EQUAL? .WORD ,W?N ,W?NO ,W?NOPE>
		<RTRUE>)
	       (<EQUAL? .WORD ,W?NEGATIVE ,W?NAY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE YES? ("AUX" WORD TBL)
	 <COLOR ,FORE ,BGND>
	 <CRLF>
	 <REPEAT ()
	    <TELL CR "[Please type YES or NO.] >">
	    <READ-YES-LEXV>
	    <COND (<ZERO? <GETB ,YES-LEXV ,P-LEXWORDS>>
		   <AGAIN>)>
	    <SET WORD <GET ,YES-LEXV ,P-LEXSTART>>
	    <COND (<ZERO? .WORD>
		   <AGAIN>)
		  (<YES-WORD? .WORD>
		   <RTRUE>)
		  (<NO-WORD? .WORD>
		   <RFALSE>)>>>
	 
"INITVARS must be called first!"

<GLOBAL VT100:FLAG <>>

<ROUTINE STARTUP ("AUX" X TBL CNT)
	 <COPYT ,VOCAB ,VOCAB2 <+ <GETB ,VOCAB 0> 2>> ; "Init VOCAB2."
	 <DEFAULT-SOFTS>
	 <SET TBL <GET ,MACHINE-COLORS ,HOST>>
	 <COND (<T? .TBL>
		<SET TBL <GET .TBL 1>>
		<SETG BGND <GETB .TBL 0>>
		<SETG FORE <GETB .TBL 1>>
		<SETG INCOLOR <GETB .TBL 2>>
		<SETG GCOLOR <GETB .TBL 3>>)>
	 <COND (<EQUAL? ,HOST ,DEC-20>
		<CLEAR -1>
		<TELL CR "Is this a VT220?">
		<COND (<NOT <YES?>>
		       <SETG VT100 T>
		       <SETUP-APPLE-MODE>)>)>	       
	 <COLOR ,FORE ,BGND>
	 <CLEAR -1>
	 <CRLF>
	 <PRINT "Copyright (C)1987 Infocom, Inc. All rights reserved.">
	 <CRLF>
	 <PRINT "|Do you want to ">
	 <TELL "begin a new game, restore a saved game, or quit?" CR CR>
	 <REPEAT ()
	    <COLOR ,FORE ,BGND>
	    <TELL "[Type BEGIN, RESTORE or QUIT.] >">
	    <READ-YES-LEXV>
	    <COND (<ZERO? <GETB ,YES-LEXV ,P-LEXWORDS>>
		   <AGAIN>)>
	    <SET X <GET ,YES-LEXV ,P-LEXSTART>>
	    <COND (<ZERO? .X>
		   <AGAIN>)
		  (<EQUAL? .X ,W?BEGIN ,W?B ,W?RESTART>
		   <PROLOGUE>
		   <CLEAR -1>
		   <RTRUE>)
		  (<EQUAL? .X ,W?RESTORE>
		   <V-RESTORE>
		   <CRLF>)		       
		  (<EQUAL? .X ,W?Q ,W?QUIT>
		   <CRLF>
		   <QUIT>
		   <RFALSE>)>>>
  
<ROUTINE SHOW-MENU-ITEM (LINE "OPT" (INV 0) "AUX" X)
	 <CENTER <+ .LINE 7> 35>
	 <COLOR ,GCOLOR ,BGND>
	 <HLIGHT ,H-NORMAL>
	 <COND (<T? .INV>
		<COND (<AND <T? ,COLORS?>
			    <NOT <EQUAL? ,FORE ,GCOLOR>>>
		       <COLOR ,FORE ,BGND>)
		      (T
		       <HLIGHT ,H-INVERSE>)>)>
	 <TELL <GET ,MENU-LIST .LINE>>
	 <RFALSE>>

<ROUTINE SETUP-CHARACTER ("AUX" (LAST 0) X STAT)
	 <PUTB ,DBOX 0 ,SP>
	 <COPYT ,DBOX <REST ,DBOX 1> %<- 0 <- ,DBOX-LENGTH 1>>>
	 <REPEAT ()
	    <COLOR ,FORE ,BGND>
	    <CLEAR -1>
	    <SPLIT 14>
	    <COND (<IS? ,PLAYER ,NAMED>
		   <SHOW-RANK ,WIDTH>)>
	    <TO-TOP-WINDOW>
	    <COLOR ,FORE ,BGND>
	    <CENTER 5 15>
	    <TELL "Character Setup">
	    <SET STAT 0>
	    <REPEAT ()
	       <SHOW-MENU-ITEM .STAT>
	       <COND (<IGRTR? STAT 4>
		      <RETURN>)>>
	    <USE-ARROWS>
	    <PRINT 
"highlight your selection.||Type [RETURN] to continue. >">
	    <SET STAT .LAST>
	    <REPEAT ()
	       <TO-TOP-WINDOW>
	       <SHOW-MENU-ITEM .STAT 1>
	       <TO-BOTTOM-WINDOW>
	       <SET X <DO-INPUT>>
	       <COND (<EQUAL? .X ,DOWN-ARROW ,SP ,UP-ARROW>
		      <TO-TOP-WINDOW>
		      <SHOW-MENU-ITEM .STAT>
		      <COND (<EQUAL? .X ,UP-ARROW>
			     <COND (<DLESS? STAT 0>
				    <SET STAT 4>)>
			     <AGAIN>)>
		      <COND (<IGRTR? STAT 4>
			     <SET STAT 0>)>
		      <AGAIN>)
		     (<EQUAL? .X ,EOL ,LF>
		      <COND (<ZERO? .STAT>
			     <QUICK-SETUP>
			     <RETURN>)
			    (<EQUAL? .STAT 1>
			     <PICK-A-CHAR>
			     <RETURN>)
			    (<EQUAL? .STAT 2>
			     <ROLL-YOUR-OWN>
			     <RETURN>)
			    (<EQUAL? .STAT 3>
			     <MANUAL>
			     <CRLF>
			     <COND (<T? ,POTENTIAL>
				    <TELL CR
 "Your unused Potential has been evenly distributed." CR>)>
			     <RETURN>)>
		      <CRLF>
		      <CRLF>
		      <V-QUIT>
		      <TO-TOP-WINDOW>
		      <SHOW-MENU-ITEM .STAT>
		      <USE-ARROWS>
		      <PRINT 
"highlight your selection.||Type [RETURN] to continue. >">
		      <SET STAT 0>
		      <AGAIN>)>
	       <SOUND 2>>
	    <TO-BOTTOM-WINDOW>
	    <CRLF>
	    <COND (<ZERO? .STAT>
		   <RETURN>)>
	    <SET LAST .STAT>
	    <PRINT "|Are you sure ">
	    <TELL "these are the attributes you want?">
	    <COND (<NOT <YES?>>
		   <AGAIN>)>
	    <GET-SEX>
	    <GET-NAME>
	    <MAKE ,PLAYER ,NAMED>
	    <SHOW-RANK ,WIDTH>
	    <PRINT "|Are you sure ">
	    <PRINT-TABLE ,CHARNAME>
	    <TELL " is the character you want?">
	    <COND (<YES?>
		   <RETURN>)>>
	 <SETG SAY-STAT T>
	 <COPYT ,STATS ,MAXSTATS %<* ,NSTATS 2>>
	 <COND (<T? .STAT>
		<PRINT "|Do you want to ">
		<TELL "save this character before you proceed?">
		<COND (<YES?>
		       <PUTB ,OOPS-INBUF 1 0>
		       <SET X <SAVE>>
		       <COND (<ZERO? .X>
			      <FAILED "SAVE">)
			     (<EQUAL? .X 1>
			      <COMPLETED "SAVE">)
			     (T
			      <INITVARS>
			      <RFALSE>)>)>)>
	 
	 <SETG CHECKSUM 0>
	 <SET STAT ,ENDURANCE>
	 <REPEAT ()
	    <SETG CHECKSUM <+ ,CHECKSUM <GET ,STATS .STAT>>>
	    <COND (<IGRTR? STAT ,LUCK>
		   <RETURN>)>>
	 <COND (<G? ,CHECKSUM %<+ ,INIT-POTENTIAL 6>>
		<CHEATER>
		<RFALSE>)>
	 
	 <TELL CR "Press any key to begin the story. >">
	 <SET X <INPUT 1>>
	 <RFALSE>>
	    		  
<ROUTINE QUICK-SETUP ()
	 <COPYT <GET ,CSTATS 0> ,STATS 12>
	 <COPYT ,DEFAULT-NAME ,CHARNAME ,DEFAULT-NAME-LENGTH>
	 <MAKE ,PLAYER ,NAMED>
	 <UNMAKE ,PLAYER ,FEMALE>
	 <SHOW-RANK ,WIDTH>
	 <RFALSE>>

<ROUTINE SETUP-TOP ("OPT" NOCLEAR "AUX" (STAT 0))
	 <CLEAR ,S-WINDOW>
	 <PUT ,STATS ,EXPERIENCE ,BEGINNERS-EXPERIENCE>
	 <COND (<IS? ,PLAYER ,NAMED>
		<SHOW-RANK ,WIDTH>)>
	 <COND (<ZERO? ,VT220>
		<APPLE-BARS>)
	       (T
		<STATBARS 3 <- </ <- ,WIDTH ,BARWIDTH> 2> 1> ,LUCK>)>
	 <SETG IN-DBOX ,SHOWING-STATS>
	 <RFALSE>>

<ROUTINE APPLE-BARS ("OPT" Y X "AUX" (STAT 0))
	 <COND (<NOT <ASSIGNED? Y>>
		<SET Y 4>)>
	 <SETG BARY .Y>
	 <COND (<NOT <ASSIGNED? X>>
		<SET X </ <- ,WIDTH 18> 2>>)>
	 <SETG BARX .X>
	 <TO-TOP-WINDOW>
	 <CURSET 3 <- ,BARX 1>>
	 <HLIGHT ,H-INVERSE>
	 <PRINTT ,DBOX ,APPBOX 8>
	 <CURSET ,BARY ,BARX>
	 <PRINTT ,BAR-LABELS ,LABEL-WIDTH ,ARMOR-CLASS>
	 <REPEAT ()
	    <BAR-NUMBER .STAT <GET ,STATS .STAT>>
	    <COND (<IGRTR? STAT ,LUCK>
		   <RETURN>)>>
	 <TO-BOTTOM-WINDOW>
	 <RFALSE>>

<ROUTINE PICK-A-CHAR ("AUX" (CHAR 0) LMARGIN NX NY NTBL X)
	 <CLEAR ,S-WINDOW>
	 <COND (<IS? ,PLAYER ,NAMED>
		<SHOW-RANK ,WIDTH>)>
	 <SET X ,BARWIDTH>
	 <COND (<ZERO? ,VT220>
		<SET X ,APPBOX>)>
	 <SET NX </ <- ,WIDTH <+ ,BARMAR .X>> 2>>
	 <SET LMARGIN <- .NX 1>>
	 <SETG IN-DBOX ,SHOWING-STATS>
	 <TO-TOP-WINDOW>
	 <COND (<ZERO? ,VT220>
		<COLOR ,FORE ,BGND>
		<DO-CURSET 3 .LMARGIN>
		<HLIGHT ,H-INVERSE>
		<PRINTT ,DBOX %<+ ,CNAME-LEN 2> 8>)>
	 <REPEAT ()
	    <DO-CURSET <+ .CHAR 4> .NX>
	    <TELL <GET ,CNAMES .CHAR>>
	    <COND (<IGRTR? CHAR 5>
		   <RETURN>)>>
	 <COPYT <GET ,CSTATS 0> ,STATS 12>
	 <SET X <+ <+ .LMARGIN ,BARMAR> 1>>
	 <COND (<ZERO? ,VT220>
		<APPLE-BARS 4 .X>)
	       (T
		<STATBARS 4 .X ,LUCK>)>
	 <USE-ARROWS>
	 <TELL "select the character you want">
	 <PRESS-RETURN>
	 <TO-TOP-WINDOW>
	 <SET CHAR 0>
	 <REPEAT ()
	     <SET NY <+ .CHAR 4>>
	     <SET NTBL <GET ,CNAMES .CHAR>>
	     <DO-CURSET .NY .NX>
	     <COLOR ,FORE ,BGND>
	     <COND (<ZERO? ,VT220>
		    <HLIGHT ,H-NORMAL>)
		   (<OR <ZERO? ,COLORS?>
			<EQUAL? ,FORE ,GCOLOR>>
		    <HLIGHT ,H-INVERSE>)>
	     <HLIGHT ,H-MONO>
	     <TELL .NTBL>
	     <COPYT <GET ,CSTATS .CHAR> ,STATS 12>
	     <HLIGHT ,H-NORMAL>
	     <SET X ,ENDURANCE>
	     <REPEAT ()
		<APPLY ,STAT-ROUTINE .X <GET ,STATS .X>>
		<COND (<IGRTR? X ,LUCK>
		       <RETURN>)>>
	     <TO-BOTTOM-WINDOW>
	     <REPEAT ()
		<SET X <DO-INPUT>>
		<COND (<EQUAL? .X ,EOL ,LF>
		       <SETUP-TOP>
		       <RFALSE>)
		      (<EQUAL? .X ,DOWN-ARROW ,SP ,UP-ARROW>
		       <TO-TOP-WINDOW>
		       <DO-CURSET .NY .NX>
		       <COLOR ,FORE ,BGND>
		       <COND (<ZERO? ,VT220>
			      <HLIGHT ,H-INVERSE>)
			     (T
			      <HLIGHT ,H-NORMAL>
			      <COND (<T? ,COLORS?>
				     <COLOR ,GCOLOR ,BGND>)>)>
		       <HLIGHT ,H-MONO>
		       <TELL .NTBL>
		       <COND (<NOT <EQUAL? .X ,UP-ARROW>>
			      <COND (<IGRTR? CHAR 5>
				     <SET CHAR 0>)>
			      <RETURN>)>
		       <COND (<DLESS? CHAR 0>
			      <SET CHAR 5>)>
		       <RETURN>)>
		<SOUND ,S-BOOP>>>
	 <RFALSE>>

<ROUTINE USE-ARROWS ("AUX" X)
	 <TO-BOTTOM-WINDOW>
	 <TELL CR CR "Use the ">
	 <COND (<EQUAL? ,HOST ,MACINTOSH>
		<TELL "[SPACE] bar to ">
		<RFALSE>)
	       (<T? ,VT220>
		<SET X <FONT ,F-NEWFONT>>
		<PRINTC 92>)
	       (<EQUAL? ,HOST ,IBM>
		<PRINTC 24>)
	       (<EQUAL? ,HOST ,APPLE-2C>
		<SET X <FONT ,F-NEWFONT>>
		<PRINTC 75>)
	       (T
		<TELL "UP">)>
	 <SET X <FONT ,F-DEFAULT>>
	 <TELL ,AND>
	 <COND (<T? ,VT220>
		<SET X <FONT ,F-NEWFONT>>
		<PRINTC 93>)
	       (<EQUAL? ,HOST ,IBM>
		<PRINTC 25>)
	       (<EQUAL? ,HOST ,APPLE-2C>
		<SET X <FONT ,F-NEWFONT>>
		<PRINTC 74>)
	       (T
		<TELL "DOWN arrow">)>
	 <SET X <FONT ,F-DEFAULT>>
	 <TELL " keys to ">
	 <RFALSE>>	 

<ROUTINE PRESS-RETURN ()
	 <TELL ,PERIOD CR "Press [RETURN] when you're finished. >">
	 <RTRUE>>

<ROUTINE MANUAL ("AUX" A OA X NX Y Z BX OBX OP KEY TBL)
	 <SET A ,ENDURANCE>
	 <REPEAT ()
	    <PUT ,STATS .A 1>
	    <COND (<IGRTR? A ,ARMOR-CLASS>
		   <RETURN>)>>
	 <SETUP-TOP>
	 <SETG POTENTIAL ,INIT-POTENTIAL>
	 <TO-TOP-WINDOW>
	 <SET Y <+ ,BARY 7>>
	 <COND (<ZERO? ,VT220>
		<CURSET .Y <- ,BARX 1>>
		<HLIGHT ,H-INVERSE>
		<PRINTT ,DBOX ,APPBOX 2>
		<CURSET .Y ,BARX>
		<TELL "   Potential">
		<BAR-NUMBER 7 ,POTENTIAL>)
	       (T
	      	<DO-CURSET <+ ,BARY ,ARMOR-CLASS> ,BARX>
		<PRINTT ,DBOX ,BARWIDTH>
		<DO-CURSET .Y ,BARX>
		<COLOR ,FORE ,BGND>
		<TELL "   Potential">
		<RAWBAR 7 ,POTENTIAL>)> 
	 <USE-ARROWS>
	 <TELL "select an attribute. Then use the ">
	 <COND (<EQUAL? ,HOST ,MACINTOSH>
		<TELL "+">)
	       (<T? ,VT220>
		<SET Z <FONT ,F-NEWFONT>>
		<PRINTC 33>)
	       (<EQUAL? ,HOST ,IBM>
		<PRINTC 27>)
	       (<EQUAL? ,HOST ,APPLE-2C>
		<SET Z <FONT ,F-NEWFONT>>
		<PRINTC 72>)
	       (T
		<TELL "LEFT">)>
	 <SET Z <FONT ,F-DEFAULT>>
	 <TELL ,AND>
	 <COND (<EQUAL? ,HOST ,MACINTOSH>
		<TELL "-">)
	       (<T? ,VT220>
		<SET Z <FONT ,F-NEWFONT>>
		<PRINTC 34>)
	       (<EQUAL? ,HOST ,IBM>
		<PRINTC 26>)
	       (<EQUAL? ,HOST ,APPLE-2C>
		<SET Z <FONT ,F-NEWFONT>>
		<PRINTC 85>)
	       (T
		<TELL "RIGHT arrow">)>
	 <SET Z <FONT ,F-DEFAULT>>
	 <TELL " keys to adjust that attribute">
	 <PRESS-RETURN>
	 <SET OP -1>
	 <SET OA -1>
	 <SET A ,ENDURANCE>
	 <REPEAT ()
	    <TO-TOP-WINDOW>
	    <SET TBL <REST ,BAR-LABELS <* .A ,LABEL-WIDTH>>>
	    <COND (<NOT <EQUAL? .A .OA>>
		   <SET OA .A>
		   <DO-CURSET <+ ,BARY .A> ,BARX>
		   <COLOR ,FORE ,BGND>
		   <COND (<T? ,VT220>
			  <HLIGHT ,H-INVERSE>)>
		   <PRINTT .TBL ,LABEL-WIDTH>
		   <HLIGHT ,H-NORMAL>
		   <HLIGHT ,H-MONO>
		   <COLOR ,GCOLOR ,BGND>)>
	    <COND (<NOT <EQUAL? .OP ,POTENTIAL>>
		   <APPLY ,STAT-ROUTINE 7 ,POTENTIAL>
		   <SET OP ,POTENTIAL>)>
	    <TO-BOTTOM-WINDOW>
	    <SET KEY <DO-INPUT>>
	    <COND (<EQUAL? .KEY ,EOL ,LF>
		   <RETURN>)>
	    <TO-TOP-WINDOW>		
	    <COND (<EQUAL? .KEY ,UP-ARROW ,DOWN-ARROW ,SP>
		   <DO-CURSET <+ ,BARY .A> ,BARX>
		   <COLOR ,FORE ,BGND>
		   <COND (<ZERO? ,VT220>
			  <HLIGHT ,H-INVERSE>)>
		   <PRINTT .TBL ,LABEL-WIDTH>
		   <HLIGHT ,H-NORMAL>
		   <HLIGHT ,H-MONO>
		   <COLOR ,GCOLOR ,BGND>
		   <COND (<EQUAL? .KEY ,UP-ARROW>
			  <COND (<DLESS? A ,ENDURANCE>
				 <SET A ,LUCK>)>
			  <AGAIN>)>
		   <COND (<IGRTR? A ,LUCK>
			  <SET A ,ENDURANCE>)>
		   <AGAIN>)
		  (<AND <EQUAL? .KEY ,LEFT-ARROW %<ASCII !\-> %<ASCII !\_>>
			<NOT <EQUAL? ,POTENTIAL ,INIT-POTENTIAL>>>
		   <SET X <GET ,STATS .A>>
		   <COND (<G? .X 1>
			  <INC POTENTIAL>
			  <SET NX <- .X 1>>
			  <PUT ,STATS .A .NX>
			  <APPLY ,STAT-ROUTINE .A .NX>
			  <AGAIN>)>)
		  (<ZERO? ,POTENTIAL>)
		  (<EQUAL? .KEY ,RIGHT-ARROW %<ASCII !\+> %<ASCII !\=>>
		   <DEC POTENTIAL>
		   <SET X <GET ,STATS .A>>
		   <SET NX <+ .X 1>>
		   <PUT ,STATS .A .NX>
		   <APPLY ,STAT-ROUTINE .A .NX>
		   <AGAIN>)>
	    <SOUND 2>>
	 	 
	 <TO-TOP-WINDOW>	
	 <FUDGE-STATS>
	 <COPYT ,STATS ,MAXSTATS %<* ,NSTATS 2>>
	 <SET A ,ENDURANCE>
	 <REPEAT ()
	    <APPLY ,STAT-ROUTINE .A <GET ,STATS .A>>
	    <COND (<IGRTR? A ,LUCK>
		   <RETURN>)>>
	 <COND (<ZERO? ,VT220>
		<DO-CURSET .Y <- ,BARX 1>>
		<PRINTT ,DBOX 18 2>
		<HLIGHT ,H-INVERSE>)
	       (T
		<DO-CURSET .Y ,BARX>
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTT ,DBOX ,BARWIDTH>
		<COLOR ,FORE ,BGND>)>
	 <DO-CURSET ,BARY ,BARX>
	 <PRINTT ,BAR-LABELS ,LABEL-WIDTH ,ARMOR-CLASS>
	 <TO-BOTTOM-WINDOW>
	 <RFALSE>>

<ROUTINE ROLL-YOUR-OWN ("AUX" STAT XSTAT OLD DELTA STAT-ORDER X)
	 <SET STAT ,ENDURANCE>
	 <REPEAT ()
	    <PUT ,STATS .STAT 1>
	    <COND (<IGRTR? STAT ,ARMOR-CLASS>
		   <RETURN>)>>
	 <SETUP-TOP>
	 <TO-BOTTOM-WINDOW>
	 <TELL CR CR
"A new set of attributes will appear each time you press the [SPACE] bar." CR CR "Press [RETURN] to select a set that you like. >">

	 <PUT ,AUX-TABLE 0 7>
	 <SET STAT-ORDER <REST ,AUX-TABLE 4>>
	 <SET STAT ,ENDURANCE>
	 
	 <REPEAT ()
	    <PUT .STAT-ORDER .STAT .STAT>
	    <COND (<IGRTR? STAT ,LUCK>
		   <RETURN>)>>
	 <SET STAT-ORDER <REST ,AUX-TABLE 20>> ; "Set up random list here."
	 
	 <REPEAT ()
	    <TO-TOP-WINDOW>
	    <PUT ,AUX-TABLE 1 0> ; "Reset for PICK-ONE."
	    <SET STAT ,ENDURANCE>
	    <REPEAT ()
	       <PUTB .STAT-ORDER .STAT <PICK-ONE ,AUX-TABLE>>
	       <COND (<IGRTR? STAT ,LUCK>
		      <RETURN>)>>
	    <SETG POTENTIAL %<+ ,INIT-POTENTIAL 6>>
	    <SET STAT ,ENDURANCE>
	    <REPEAT ()
	       <SET XSTAT <GETB .STAT-ORDER .STAT>>
	       <SET DELTA 1>
	       <COND (<T? ,POTENTIAL>
		      <SET DELTA <RANDOM %<+ ,AVERAGE 1>>>
		      <DEC DELTA>
		      <SET DELTA <+ ,AVERAGE <- ,SPREAD .DELTA>>>
		      <COND (<G? .DELTA ,POTENTIAL>
			     <SET DELTA ,POTENTIAL>)>
		      <SETG POTENTIAL <- ,POTENTIAL .DELTA>>)>
	       <PUT ,STATS .XSTAT .DELTA>
	       <COND (<IGRTR? STAT ,LUCK>
		      <RETURN>)>>
	    <FUDGE-STATS>
	    <SET STAT ,ENDURANCE>
	    <REPEAT ()
	       <APPLY ,STAT-ROUTINE .STAT <GET ,STATS .STAT>>
	       <COND (<IGRTR? STAT ,LUCK>
		      <RETURN>)>>
	    <TO-BOTTOM-WINDOW>
	    <REPEAT ()
	       <SET X <INPUT 1>>
	       <COND (<EQUAL? .X ,EOL ,LF>
		      <RFALSE>)
		     (<EQUAL? .X ,SP>
		      <RETURN>)>
	       <SOUND ,S-BOOP>>>>

<ROUTINE FUDGE-STATS ("AUX" TOTAL STAT)
	 <COND (<ZERO? ,POTENTIAL>
		<RFALSE>)>
	 <SET TOTAL ,POTENTIAL>
	 <REPEAT ()
	    <PUT ,STATS .STAT <+ <GET ,STATS .STAT> 1>>
	    <COND (<DLESS? TOTAL 1>
		   <RFALSE>)
		  (<IGRTR? STAT ,LUCK>
		   <SET STAT ,ENDURANCE>)>>>

<ROUTINE GET-NAME ("AUX" CNT PTR APO DASH BAD ANY CAP SPACE LEN X CHAR)
	 <COND (<NOT <IS? ,PLAYER ,NAMED>>
		<COPYT ,DEFAULT-NAME ,CHARNAME ,DEFAULT-NAME-LENGTH>)>
	 <TELL CR 
"Finally, you must select a Name for your character.|
|
By what Name shall your character be known?">
	 <REPEAT ()
	    <COPYT ,P-INBUF 0 ,P-INBUF-LENGTH>
	    <PUTB ,P-INBUF 0 %<- ,P-INBUF-LENGTH 2>>
	    <TELL CR CR "[The default is \"">
	    <PRINT-TABLE ,CHARNAME>
	    <TELL ".\"] >">
	    <REPEAT ()
	       <COLOR ,INCOLOR ,BGND>
	       <SET X <READ ,P-INBUF 0>>
	       <COND (<EQUAL? .X ,EOL ,LF>
		      <RETURN>)>
	       <SOUND 2>>
	    <COLOR ,FORE ,BGND>
	    <SET LEN <GETB ,P-INBUF 1>>
	    <COND (<ZERO? .LEN>
		   <RETURN>)>		 
	    <SET X <+ .LEN 1>>
	    <SET PTR 2>
	    <SET APO 0>
	    <SET DASH 0>
	    <SET BAD 0>
	    <SET ANY 0>
	    <REPEAT ()
	       <SET CHAR <GETB ,P-INBUF .PTR>>
	       <COND (<AND <G? .CHAR %<- <ASCII !\a> 1>>
			   <L? .CHAR %<+ <ASCII !\z> 1>>>
		      <INC ANY>)
		     (<EQUAL? .CHAR ,SP>)
		     (<EQUAL? .CHAR %<ASCII !\'>>
		      <INC APO>)
		     (<EQUAL? .CHAR %<ASCII !\->>
		      <INC DASH>)
		     (T
		      <INC BAD>
		      <RETURN>)>
	       <COND (<IGRTR? PTR .X>
		      <RETURN>)>>
	    <COND (<OR <ZERO? .ANY>
		       <T? .BAD>
		       <G? .APO 1>
		       <G? .DASH 1>>
		   <BAD-NAME "silly">
		   <AGAIN>)	       
		  (<G? .LEN ,CHARNAME-LENGTH>
		   <BAD-NAME "too long">
		   <AGAIN>)>
	    <COPYT ,CHARNAME 0 %<+ ,CHARNAME-LENGTH 1>>
	    <SET CNT 0>
	    <SET PTR 2>
	    <SET CAP 1>
	    <SET SPACE 0>
	    <SET ANY 0>
	    <REPEAT ()
	       <SET CHAR <GETB ,P-INBUF .PTR>>
	       <COND (<EQUAL? .CHAR ,SP>
		      <INC CAP>
		      <INC SPACE>
		      <COND (<AND <T? .ANY>
				  <EQUAL? .SPACE 1>>
			     <INC CNT>
			     <PUTB ,CHARNAME .CNT ,SP>)>)
		     (T
		      <INC ANY>
		      <SET SPACE 0>
		      <COND (<EQUAL? .CHAR %<ASCII !\'>
				           %<ASCII !\->>
			     <INC CAP>)
			    (<T? .CAP>
			     <SET CAP 0>
			     <SET CHAR <- .CHAR ,SP>>)>
		      <INC CNT>
		      <PUTB ,CHARNAME .CNT .CHAR>)>
	       <COND (<IGRTR? PTR .X>
		      <RETURN>)>>
	    <PUTB ,CHARNAME 0 .CNT>
	    <TELL CR "Is \"">
	    <PRINT-TABLE ,CHARNAME>
	    <TELL "\" correct?">
	    <COND (<YES?>
		   <RETURN>)>
	    <BAD-NAME "cast into the void">>
	 <MAKE ,PLAYER ,NAMED>
	 <SHOW-RANK ,WIDTH>
	 <RFALSE>>
		 	 
<ROUTINE BAD-NAME (STR)
	 <TELL CR "That name is " .STR
	       ". Please supply another.">
	 <RFALSE>>

<ROUTINE GET-SEX ("AUX" WORD)
	 <TELL CR "Shall your character be male or female?">
	 <REPEAT ()
	    <TELL CR CR "[The default is ">
	    <COND (<IS? ,PLAYER ,FEMALE>
		   <TELL "FE">)>
	    <TELL "MALE.] >">
	    <READ-YES-LEXV>
	    <COND (<ZERO? <GETB ,YES-LEXV ,P-LEXWORDS>>
		   <RTRUE>)>
	    <SET WORD <GET ,YES-LEXV ,P-LEXSTART>>
	    <COND (<EQUAL? .WORD ,W?M ,W?MALE ,W?MAN>
		   <RFALSE>)
		  (<EQUAL? .WORD ,W?F ,W?FEMALE ,W?WOMAN>
		   <MAKE ,PLAYER ,FEMALE>
		   <RFALSE>)>
	    <TELL CR "[Please type MALE or FEMALE.]">>>

<OBJECT HELLO-OBJECT
	(LOC GLOBAL-OBJECTS)
	(DESC "that")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM HELLO GOODBYE HI BYE)
	(ACTION WAY-TO-TALK)>

<ROUTINE WAY-TO-TALK ()
	 <PCLEAR>
	 <COND (<EQUAL? ,HERE <LOC ,RIDDLE>>
		<PRINT "A hollow voice says, \"Fool!\"">
		<CRLF>
		<RTRUE>)>
	 <SEE-MANUAL "address characters">
	 <RTRUE>>

<ROUTINE NOT-AVAILABLE ()
	 <NYMPH-APPEARS>
	 <TELL "Sorry, that feature isn't available. Consult your ">
	 <ITALICIZE "Beyond Zork">
	 <TELL " manual for more information">
	 <PRINT ". Bye!\"|  She disappears with a wink.|">
	 <RTRUE>>

<ROUTINE USELESS ("OPT" THING STRING)
	 <NYMPH-APPEARS>
	 <TELL ,DONT "need to refer to ">
	 <COND (<ASSIGNED? STRING>
		<TELL ,LTHE .THING>)
	       (<ASSIGNED? THING>
		<TELL THE .THING>)
	       (T
		<PRINTD ,PSEUDO-OBJECT>)>
	 <TO-COMPLETE>
	 <RTRUE>>

<ROUTINE TO-COMPLETE ()
	 <TELL " to complete this story">
	 <PRINT ". Bye!\"|  She disappears with a wink.|">
	 <RTRUE>>

<ROUTINE NYMPH-APPEARS ("OPT" STR)
	 <PCLEAR>
	 <TELL ,XA>
	 <COND (<NOT <ASSIGNED? STR>>
		<TELL "technical">)
	       (T
		<TELL .STR>)>
	 <TELL " nymph appears on your keyboard. \"">
	 <RTRUE>>

<ROUTINE SEE-MANUAL (STR)
	 <NYMPH-APPEARS>
	 <TELL "Refer to your ">
	 <ITALICIZE "Beyond Zork">
	 <TELL " manual for the correct way to " .STR>
	 <PRINT ". Bye!\"|  She disappears with a wink.|">
	 <RTRUE>>

<ROUTINE REFER-TO-PACKAGE ("OPT" (OBJ ,PRSO))
	 <NYMPH-APPEARS "marketing">
	 <TELL "You'll find ">
	 <COND (<VERB? EXAMINE>
		<TELL "a drawing of " THE .OBJ>)
	       (T
		<TELL "that information">)>
	 <TELL " in your ">
	 <ITALICIZE "Beyond Zork">
	 <TELL " package">
	 <PRINT ". Bye!\"|  She disappears with a wink.|">
	 <RTRUE>>

<ROUTINE NONE-TO-BE-SEEN ()
	 <TELL "There are none to be seen." CR>
	 <RTRUE>>

<ROUTINE GENERIC-MONSTER-F (TBL "OPT" (LEN <GET .TBL 0>) X)
	 <SET TBL <REST .TBL 2>>
	 <COND (<ZERO? ,LAST-MONSTER>)
	       (<SET X <INTBL? ,LAST-MONSTER .TBL .LEN>>
		<RETURN ,LAST-MONSTER>)>
	 <COND (<SET X <INTBL? ,P-IT-OBJECT .TBL .LEN>>
		<RETURN ,P-IT-OBJECT>)>
	 <REPEAT ()
	    <COND (<DLESS? LEN 0>
		   <RFALSE>)>
	    <SET X <GET .TBL .LEN>>
	    <COND (<AND <IS? .X ,LIVING>
			<NOT <IS? .X ,SLEEPING>>>
		   <RETURN .X>)>>>

<ROUTINE NOBODY-TO-ASK ()
	 <PCLEAR>
	 <TELL "There's nobody here to ask." CR>
	 <RTRUE>>

<ROUTINE TALK-TO-SELF ()
	 <PCLEAR>
	 <COND (<EQUAL? ,HERE <LOC ,RIDDLE>>
		<PRINT "A hollow voice says, \"Fool!\"">
		<CRLF>
		<RTRUE>)>
	 <TELL "[You must address characters directly.]" CR>
	 <RTRUE>>

"*** DEATH ***"

<OBJECT DEATH
	(LOC ROOMS)
	(DESC "Death")
	(SDESC DESCRIBE-DEATH)
	(FLAGS LIGHTED LOCATION)>

<ROUTINE DESCRIBE-DEATH (OBJ)
	 <COND (<IS? .OBJ ,MUNGED>
		<TELL "Defeated">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>	 

<ROUTINE KILL-URGRUE ()
	 <TELL 
", directly into the core of the shadow!|
  The thing within stands revealed to you for one brief instant. Then your sanity is spared by a blinding flash and concussion that throws you hard against the far wall...">
	 <CARRIAGE-RETURNS>
	 <TELL ,XTHE "sound of sobbing jolts you to your senses.|
  In the corner lies a feeble old man, bent with grief. His robes are tattered, his white hair scorched by flame. You slowly rise and draw closer, bending low to touch his shoulder" ,PTAB>
	 <CLAMP>
	 <TELL ,TAB
"\"I can always count on fools like you for sympathy,\" chuckles the not-so-feeble old man as he holds your windpipe shut. \"Still, though your mind is weak, your body is young and strong. It will make a suitable vessel until I can find another grue.\" He grabs your hair, pulls your head back and directs your eyes into his own. \"Relax. This won't hurt a bit.\"|
  Your fear turns to resentment, then to rage as the old man violates your mind, absorbing your compassion like a sponge as he fights to take possession of your soul." CR>
	 <UPDATE-STAT ,WINNING-COMPASSION ,COMPASSION>
	 <TELL ,TAB "\"Enough!\"|  The fingers on your neck drop away, ">
	 <COND (<GET ,STATS ,COMPASSION>
		<VANISH ,URGRUE>
		<DEQUEUE ,I-URGRUE>
		<UNMAKE ,URGRUE ,LIVING>
		<SETG LAST-MONSTER <>>
		<TELL 
"leaving you gasping but alive. You stumble backwards to find the old man leaning against the wall, breathing hard, his eyes brimming with tears.|
  \"Enough,\" he cries again, gesturing towards the exit. \"Take what you want and leave this place! I cannot bring myself to murder one so virtuous. Go!\" His voice is bitter with despair. \"Leave me to wallow in Compassion.\"|
  With these last words, the broken man fades into nothingness." CR>
		<UPDATE-STAT <GETP ,URGRUE ,P?VALUE> ,EXPERIENCE T>
		<RTRUE>)>
	 <TELL 
"and the carcass of your former self slumps to the ground. You kick it aside with a chuckle, and pause to admire your new, young body in the floating mirror. Then you saunter off down the passageway with the Coconut of Quendor under your arm, looking for a couple of baby grues to strangle. There's no faster way to burn off unwanted Compassion">
	 <MAKE ,DEATH ,MUNGED>
	 <JIGS-UP> 
	 <RTRUE>>

<ROUTINE JIGS-UP ()
	 <SETG HERE ,DEATH>
	 <MOVE ,PLAYER ,HERE>
	 <RELOOK>
	 <OPTIONS>
	 <RFALSE>>

<ROUTINE OPTIONS ("AUX" (U 0) WORD KEY)
	 <COND (<ZERO? ,CAN-UNDO>)
	       (<ZERO? ,LAST-MONSTER>
		<INC U>)>
	 <PRINT "|Do you want to ">
	 <COND (<T? .U>
		<TELL "undo your last command, ">)>
	 <TELL 
"restore a previously saved game, restart from the beginning, or quit?" CR CR>
	 <REPEAT ()
	    <TELL "[Type ">
	    <COND (<T? .U>
		   <TELL "UNDO, ">)>
	    <TELL "RESTORE, RESTART or QUIT.] >">
	    <SET KEY <READ-YES-LEXV>>
	    <SET WORD <GET ,YES-LEXV ,P-LEXSTART>>
	    <COND (<ZERO? <GETB ,YES-LEXV ,P-LEXWORDS>>
		   <AGAIN>)
		  (<AND <T? .U>
			<EQUAL? .WORD ,W?UNDO>>
		   <V-UNDO>)
		  (<EQUAL? .WORD ,W?RESTORE>
		   <V-RESTORE>)
		  (<EQUAL? .WORD ,W?RESTART>
		   <RESTART>
		   <FAILED "RESTART">)
		  (<EQUAL? .WORD ,W?QUIT ,W?Q>
		   <CRLF>
		   <QUIT>)>>
	 <RFALSE>>
	 
<ROUTINE ASIDE-FROM ("OPT" (OBJ ,ME))
	 <COND (<PROB 50>
		<TELL "Besides ">)
	       (T
		<TELL "Aside from ">)>
	 <TELL THE .OBJ ,LYOU-SEE>
	 <RTRUE>>
	  
<ROUTINE GONE-NOW (OBJ "OPT" (STR <>))
	 <COND (<ZERO? .STR>
		<TELL CTHE .OBJ>)
	       (T
		<TELL ,XTHE .OBJ>)>
	 <TELL " you saw here before is gone now." CR>
	 <RTRUE>>

<ROUTINE HOLLOW-VOICE (STR)
	 <PCLEAR>
	 <PRINT "A hollow voice says, \"Fool!\"">
	 <TELL " That Name is " .STR ". Choose another!\"" CR>
	 <RTRUE>>

; <SYNTAX $RUNE = V-RUNE>

; <ROUTINE V-RUNE ("AUX" X)
	 <COND (<ZERO? ,VT220>
		<TELL "[Sorry, Jack.]" CR>
		<RTRUE>)>
	 <PRINT "a b c d e f g h i j k l m n o p q r s t u v w x y z">
	 <TELL CR CR>
	 <SET X <FONT ,F-NEWFONT>>
	 <PRINT "a b c d e f g h i j k l m n o p q r s t u v w x y z">
	 <SET X <FONT ,F-DEFAULT>>
	 <TELL CR CR>
	 <RTRUE>>

<GLOBAL PALLETTE:NUMBER 1>

<ROUTINE V-COLOR ("AUX" TBL PAL CNT)
	 <COND (<PRSO? ROOMS>
		<SET TBL <GET ,MACHINE-COLORS ,HOST>>
		<COND (<AND <ZERO? ,COLORS?>
			    <EQUAL? ,HOST ,ATARI-ST>>
		       <SET TBL ,ST-MONO>)
		      (<OR <ZERO? ,COLORS?>
			   <ZERO? .TBL>
			   <AND <SET CNT <GET .TBL 0>>
				<L? .CNT 2>>>
		       <NOT-AVAILABLE>
		       <RTRUE>)>
		<SET TBL <GET .TBL ,PALLETTE>>
		<SETG BGND <GETB .TBL 0>>
		<SETG FORE <GETB .TBL 1>>
		<SETG INCOLOR <GETB .TBL 2>>
		<SETG GCOLOR <GETB .TBL 3>>
		<V-REFRESH>
	        <TELL CR "[Color pallette " N ,PALLETTE
		      " of " N .CNT ".]" CR>
		<COND (<IGRTR? PALLETTE .CNT>
		       <SETG PALLETTE 1>)>
		<RTRUE>)
	     ; (<PRSO? INTNUM>
		<COND (<ZERO? ,P-NUMBER>
		       <COND (<IGRTR? BGND 9>
			      <SETG BGND 1>)>
		       <SAY-COLOR ,BGND "BGND">
		       <RTRUE>)
		      (<EQUAL? ,P-NUMBER 1>
		       <COND (<IGRTR? FORE 9>
			      <SETG FORE 1>)>
		       <SAY-COLOR ,FORE "FORE">
		       <RTRUE>)
		      (<EQUAL? ,P-NUMBER 2>
		       <COND (<IGRTR? INCOLOR 9>
			      <SETG INCOLOR 1>)>
		       <SAY-COLOR ,INCOLOR "INCOLOR">
		       <RTRUE>)
		      (<EQUAL? ,P-NUMBER 3>
		       <COND (<IGRTR? GCOLOR 9>
			      <SETG GCOLOR 1>)>
		       <SAY-COLOR ,GCOLOR "GCOLOR">
		       <RTRUE>)
		      (<EQUAL? ,P-NUMBER 4>
		       <SAY-COLOR ,BGND "BGND" 1>
		       <SAY-COLOR ,FORE "FORE" 1>
		       <SAY-COLOR ,INCOLOR "INCOLOR" 1>
		       <SAY-COLOR ,GCOLOR "GCOLOR" 1>
		       <RTRUE>)>
		<SAY-ERROR "V-COLOR">
		<RTRUE>)>
	 <DONT-UNDERSTAND>
	 <RTRUE>>

; <ROUTINE SAY-COLOR (C STR "OPT" X)
	 <COND (<NOT <ASSIGNED? X>>
		<V-REFRESH>)>
	 <TELL "[" .STR " color = " <GET ,COLOR-NAMES .C> ".]" CR>
	 <RTRUE>>

; <GLOBAL DEBUG:FLAG <>>

; <SYNTAX $IMP OBJECT = V-$CHEAT>

; <ROUTINE V-$CHEAT ("AUX" X TBL SEED DELTA)
         <COND (<PRSO? INTNUM>
		<COND (<ZERO? ,P-NUMBER>
		       <MOVE ,COCO ,PLAYER>
		       <ENDING>
		       <REMOVE ,COCO>
		       <V-REFRESH>
		       <RTRUE>)
		      (<EQUAL? ,P-NUMBER 1>
		       <PUT ,STATS ,COMPASSION 50>
		       <PUT ,MAXSTATS ,COMPASSION 50>
		       <MOVE ,LHEMI ,PLAYER>
		       <UNMAKE ,LHEMI ,NODESC>
		       <MOVE ,UHEMI ,PLAYER>
		       <UNMAKE ,UHEMI ,NODESC>
		       <MOVE ,JAR ,PLAYER>
		       <MOVE ,RFOOT ,PLAYER>
		       <MOVE ,SHOE ,PLAYER>
		       <MOVE ,CLOVER ,PLAYER>
		       <MOVE ,LANTERN ,PLAYER>
		       <REPLACE-ADJ? ,LANTERN ,W?BROKEN ,W?ZZZP>
		       <UNMAKE ,LANTERN ,MUNGED>
		       <SETG LAMP-LIFE ,MAX-LAMP-LIFE>
		       <UNMAKE ,LANTERN ,NODESC>
		       <MOVE ,HELM ,PLAYER>
		       <UNMAKE ,HELM ,NODESC>
		       <TELL "Wheee!" CR>
		       <COND (<T? ,VERBOSITY>
			      <CRLF>)>
		       <GOTO ,SE-WALL>
		       <RTRUE>)>)>
	 <DONT-UNDERSTAND>
	 <RTRUE>>

<ROUTINE PROLOGUE ("AUX" X Y)
	 <CLEAR -1>
	 <TELL CR 
"\"Our doom is sealed.\"|
  Y'Gael turned away from the window overlooking the Great Sea. \"The
Guildmaster nears the end of his final quest,\" she said softly. \"When
he succeeds, for succeed he will, our powers shall cease to be.\"|
  The silence was unbroken for a long minute. Then a tiny voice near the
door peeped, \"Forever?\"|
  \"">
	 <HLIGHT ,H-ITALIC>
	 <TELL "No">
	 <HLIGHT ,H-NORMAL>
	 <TELL 
".\" The old woman leaned forward on her staff. \"The Age of Science
will endure long; no one in this room can hope to outlive it. But our
knowledge need not die with us -- if we act at once to preserve our
priceless heritage.\"|
  \"Wherein lies your hope, Y'Gael?\" demanded a salamander in the front
row. \"What Magick is proof against the death of Magick itself?\"|
  Y'Gael's dry chuckle stilled the murmur of the crowd. \"You forget your
own history, Gustar. Are you not author of the definitive scroll on the
Coconut of Quendor?\"|
  A tumult of amphibious croaks and squeals drowned out Gustar's retort.
Y'Gael hobbled over to a table laden with mystical artifacts, selected a
small stone and raised it high.|
  \"The Coconut is our only hope,\" she cried, her eyes shining in the
stone's violet aura. \"Its seed embodies the essence of our wisdom.
Its shell is impervious to the ravages of Time. We must reclaim it from
the Implementors, and hide it away before its secrets are forgotten!\"|
  The shrill voice of a newt rose above the cheering. \"And who will steal
this Coconut from the Implementors?\" he scoffed. \"You, Y'Gael?\"|
  The violet aura faded at his words. \"Not I, Orkan,\" replied Y'Gael,
shaking the lifeless stone and replacing it with a sigh. \"The fabric of
Magick is unravelling. We dare not rely on its protection. Another
champion must be sought; an innocent unskilled in the lore of enchantment, who
cannot know the price of failure, or recognize the face of death.\"|
  Orkan's squeak was skeptical. \"Suppose your champion succeeds in this
hopeless quest. What will become of the Coconut?\"|
  Y'Gael turned to face the sea once more. \"It will await the coming of a
better age,\" she replied, her voice trembling with emotion. \"An age
beyond Magick, beyond Science ...\"||">
	 <SET X <INPUT 1>>
	 
	 <SET X </ <- ,WIDTH 52> 2>>
	 <SET Y </ <- ,HEIGHT 8> 2>>
	 <CLEAR -1>
	 <SPLIT 20>
	 <TO-TOP-WINDOW>
	 
	 <DO-CURSET .Y <+ .X 10>>
	 <BIG-ZORK>
	 
	 <INC Y>
	 <DO-CURSET .Y <+ .X 15>>
	 <SAY-COCO>

	 <SET Y <+ .Y 2>>
	 <DO-CURSET .Y <+ .X 15>>
	 <TELL "An Interactive Fantasy">
	 
	 <INC Y>
	 <DO-CURSET .Y .X>
	 <PRINT "Copyright (C)1987 Infocom, Inc. All rights reserved.">
	 
	 <INC Y>
	 <DO-CURSET .Y <+ .X 2>>
	 <TRADEMARK>

	 <TO-BOTTOM-WINDOW>
	 <SET X <INPUT 1>>
	 <RFALSE>>

<ROUTINE BIG-ZORK ()
	 <COND (<T? ,COLORS?>
		<COLOR ,FORE ,BGND>)
	       (<NOT <EQUAL? ,HOST ,MACINTOSH>>
		<HLIGHT ,H-BOLD>)>
	 <TELL "B  E  Y  O  N  D      Z  O  R  K">
	 <RFALSE>>

<ROUTINE SAY-COCO ()
	 <COLOR ,INCOLOR ,BGND>
	 <HLIGHT ,H-NORMAL>
	 <HLIGHT ,H-MONO>
	 <PRINT "The Coconut of Quendor">
	 <COLOR ,FORE ,BGND>
	 <RFALSE>>

<ROUTINE TRADEMARK ()
	 <ITALICIZE "Zork">
	 <TELL " is a registered trademark of Infocom, Inc.">
	 <RTRUE>>

<SYNTAX $CREDITS = V-$CREDITS>

<ROUTINE V-$CREDITS ("AUX" X)
	 <CLEAR -1>
	 <SPLIT <- ,HEIGHT 1>>
	 <TO-TOP-WINDOW>
	 <CENTER 2 33>
	 <BIG-ZORK>
	 <CENTER 3 22>
	 <SAY-COCO>
	 <CENTER 5 17>
	 <TELL "by Brian Moriarty">
	 
	 <CENTER 7 7>
	 <COLOR ,INCOLOR ,BGND>
	 <TELL "Testing">
	 <COLOR ,FORE ,BGND>
	 <CENTER 8 53>
	 <TELL "Gary Brennan   Max Buxton   Liz Cyr-Jones   Jacob Galley">
	 <CENTER 9 70>
	 <TELL 
"Tyler Gore   Matt Hillman   Katie Kendall   Martin Price   Joe Prosser">
	 <CENTER 10 44>
	 <TELL "Steve Meretzky   Tom Veldran   Steve Watkins">
	 
	 <CENTER 12 48>
	 <COLOR ,INCOLOR ,BGND>
	 <TELL "Package         Project Manager       Copywriter">
	 
	 <CENTER 13 56>
	 <COLOR ,FORE ,BGND>
	 <TELL "Carl Genatossio       Jon Palace       Elizabeth Langosy">

	 <SET X 15>
	 <COND (<G? ,HEIGHT 23>
		<CENTER .X 57>
		<COLOR ,INCOLOR ,BGND>
		<TELL 
"Cover           Map & Book       Photography     Production">
		<INC X>
		<CENTER .X 63>
		<COLOR ,FORE ,BGND>
		<TELL 
"John Gamache    Bruce Hutchinson    Steve Grohe    Angela Crews">
		<SET X <+ .X 2>>)>

	 <CENTER .X 18>
	 <COLOR ,INCOLOR ,BGND>
	 <TELL "Micro Interpreters">
	 <INC X>
	 <CENTER .X 47>
	 <COLOR ,FORE ,BGND>
	 <TELL "Tim Anderson    Jon Arnold     Duncan Blanchard">
	 <INC X>
	 <CENTER .X 34>
	 <TELL "Linde Dynneson    Andy Kaluzniacki">
	 <SET X <+ .X 2>>
	 
	 <COLOR ,INCOLOR ,BGND>
	 <CENTER .X 20>
	 <TELL "Z Development System">
	 <INC X>
	 <CENTER .X 43>
	 <COLOR ,FORE ,BGND>
	 <TELL "Tim Anderson    Dave Lebling    Chris Reeve">
	 <TO-BOTTOM-WINDOW>
	 <SET X <INPUT 1>>
	 <V-REFRESH>
	 <RTRUE>>

<ROUTINE TIMESTOP ()
	 <TELL CTHE ,URGRUE 
" clears its throat. \"Girgol it is, then.\"|
  The speed and pitch of " THE ,URGRUE 
"'s triumphant laughter increase as a web of evil Magick engulfs you. Eons of history flicker past in mere seconds of subjective time, until the Final Conflagration brings your long-forgotten existence to a merciful end">
	 <JIGS-UP>
	 <RFALSE>>

<ROUTINE SAY-ERROR (STR)
	 <TELL "[Error @ " .STR "]" CR>
	 <RTRUE>>

; <SYNTAX $SUSS OBJECT = V-$SUSS>
; <SYNTAX $SUSS OBJECT OBJECT = V-$SUSS>

; <GLOBAL SUSSX:NUMBER 0>

; <ROUTINE V-$SUSS ("AUX" (REV 0) (STAT 0) OSTAT KEY X TBL PSTAT VAL)
	 <COND (<ZERO? ,DMODE>
		<TELL "[Switch to Enhanced mode first.]" CR>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,MONSTER>>
		<TELL "[Only monsters can be $SUSSed.]" CR>
		<RTRUE>)
	       (<PRSI? INTNUM>
		<KILL-MONSTER ,PRSO>
		<TELL "Poof." CR>)
	       (<T? ,PRSI>
		<HOW?>
		<RTRUE>)>
	 <SET X <GETP ,PRSO ,P?EMAX>>
	 <COND (<NOT <EQUAL? <GETP ,PRSO ,P?ENDURANCE> .X>>
		<TELL "[" CTHEO " must be fully recovered first.]" CR>
		<RTRUE>)>
	 <COND (<T? ,VT220>)
	       (<EQUAL? ,HOST ,DEC-20 ,APPLE-2E>
		<INC REV>)>
	 <PUTB ,DBOX 0 ,SP>
	 <COPYT ,DBOX <REST ,DBOX 1> %<- 0 <- ,DBOX-LENGTH 1>>>
	 <SETG SUSSX <+ </ <- ,DWIDTH ,SUSS-WIDTH> 2> 1>>
	 <TO-TOP-WINDOW>
	 <COLOR ,FORE ,BGND>
	 <DO-CURSET %<- ,SUSSY 1> ,SUSSX>
	 <INC SUSSX>
	 <COND (<ZERO? .REV>
		<HLIGHT ,H-INVERSE>)>
	 <PRINTT ,DBOX ,SUSS-WIDTH ,SUSS-HEIGHT>
	 <DO-CURSET ,SUSSY ,SUSSX>
	 <PRINTT ,BAR-LABELS ,LABEL-WIDTH 3>
	 <HLIGHT ,H-NORMAL>
	 <HLIGHT ,H-MONO>
	 <COND (<T? .REV>
		<HLIGHT ,H-INVERSE>)>
	 <REPEAT ()
	    <SUSSNUM .STAT>
	    <COND (<IGRTR? STAT ,DEXTERITY>
		   <RETURN>)>>
	 <TO-BOTTOM-WINDOW>
	 <TELL "[Sussing " D ,PRSO ". Press [RETURN] to exit.] >">

	 
	 <SET OSTAT -1>
	 <SET STAT ,ENDURANCE>
	 <TO-TOP-WINDOW>
	 <COLOR ,FORE ,BGND>
	 <REPEAT ()
	    <SET TBL <REST ,BAR-LABELS <* .STAT ,LABEL-WIDTH>>>
	    <SET PSTAT <GETB ,SUSS-STATS .STAT>>
	    <SET VAL <GETP ,PRSO .PSTAT>>
	    <COND (<NOT <EQUAL? .STAT .OSTAT>>
		   <SET OSTAT .STAT>
		   <DO-CURSET <+ ,SUSSY .STAT> ,SUSSX>
		   <HLIGHT ,H-NORMAL>
		   <HLIGHT ,H-MONO>
		   <COND (<T? .REV>
			  <HLIGHT ,H-INVERSE>)>
		   <PRINTT .TBL ,LABEL-WIDTH>)>
	    <TO-BOTTOM-WINDOW>
	    
	    <SET KEY <DO-INPUT>>
	    <COND (<EQUAL? .KEY ,EOL ,LF>
		   <RETURN>)>
	    <TO-TOP-WINDOW>		
	    <COLOR ,FORE ,BGND>
	    <COND (<EQUAL? .KEY ,UP-ARROW ,DOWN-ARROW ,SP>
		   <DO-CURSET <+ ,SUSSY .STAT> ,SUSSX>
		   <COND (<ZERO? .REV>
			  <HLIGHT ,H-INVERSE>)>
		   <PRINTT .TBL ,LABEL-WIDTH>
		   <COND (<AND <EQUAL? .KEY ,UP-ARROW>
			       <DLESS? STAT ,ENDURANCE>>
			  <SET STAT ,DEXTERITY>)
			 (<AND <EQUAL? .KEY ,DOWN-ARROW ,SP>
			       <IGRTR? STAT ,DEXTERITY>>
			  <SET STAT ,ENDURANCE>)>
		   <AGAIN>)
		  (<AND <EQUAL? .KEY ,LEFT-ARROW>
			<G? .VAL 1>>
		   <PUTP ,PRSO .PSTAT <- .VAL 1>>
		   <COND (<T? .REV>
			  <HLIGHT ,H-INVERSE>)>
		   <SUSSNUM .STAT>
		   <AGAIN>)
		  (<AND <EQUAL? .KEY ,RIGHT-ARROW>
			<L? .VAL ,STATMAX>>
		   <PUTP ,PRSO .PSTAT <+ .VAL 1>>
		   <COND (<T? .REV>
			  <HLIGHT ,H-INVERSE>)>
		   <SUSSNUM .STAT>
		   <AGAIN>)>
	    <SOUND 2>>
	 <PUTP ,PRSO ,P?EMAX <GETP ,PRSO ,P?ENDURANCE>>
	 <SETG NEW-DBOX ,IN-DBOX>
	 <TELL "[" CTHEO " $SUSSed.]" CR>
	 <RTRUE>>

; <ROUTINE SUSSNUM (STAT "AUX" X)
	 <SET X <+ ,SUSSX 13>>
	 <DO-CURSET <+ ,SUSSY .STAT> .X>
	 <SET X <GETP ,PRSO <GETB ,SUSS-STATS .STAT>>>
	 <COND (<L? .X 10>
		<TELL "  ">)
	       (<L? .X 100>
		<PRINTC ,SP>)>
	 <TELL N .X>
	 <RFALSE>>


; <ROUTINE V-$RECORD ()
	 <DIROUT 4>
	 <TELL "[#RECORD ok.]" CR>
	 <RTRUE>>

; <ROUTINE V-$UNRECORD ()
	 <DIROUT -4>
	 <TELL "[#UNRECORD ok.]" CR>
	 <RTRUE>>

; <ROUTINE V-$COMMAND ()
	 <DIRIN 1>
	 <TELL "[#COMMAND ok.]" CR>
	 <RTRUE>>

; <ROUTINE V-$RANDOM ()
	 <COND (<NOT <PRSO? INTNUM>>
		<TELL "[Illegal #RANDOM.]" CR>
		<RTRUE>)>
	 <RANDOM <- 0 ,P-NUMBER>>
	 <TELL "[#RANDOM " N ,P-NUMBER " ok.]" CR>	 
	 <RTRUE>>

<ROUTINE ENDING ("AUX" X LEVEL)
	 <TELL
"A devastating ground shock sends you sprawling! The roof of the cavern gives way at the same moment, and you watch helplessly as tons of granite crumble all around you..">
	 <SET X <LOC ,COCO>>
	 <COND (<OR <ZERO? .X>
		    <AND <NOT <EQUAL? .X ,PLAYER>>
			 <NOT <IN? .X ,PLAYER>>>>
		<JIGS-UP>
		<RFALSE>)>
	 <TELL ,PERIOD>
	 <CARRIAGE-RETURNS>
	 <CLEAR -1>
	 <COLOR ,FORE ,BGND>
	 <TELL CR "\"Is ">
	 <COND (<IS? ,PLAYER ,FEMALE>
		<TELL "s">)>
	 <TELL "he still alive?\"|
  The voice at your ear is familiar. You decide to open one eye.|
  \"Apparently.\" " ,CTHELADY
" probes your left ankle with her fingers, and you wince with pain. \"Close call, though. What did you call that spell, your Worship?\"|
  \"">
	 <ITALICIZE "Tossio">
	 <TELL 
". Turns granite to fettucine.\" Cardinal Toolbox wipes his mouth. \"Any left?\"|
  \"Gluttony is a sin,\" retorts " THE ,OWOMAN 
", helping you to your feet. \"Is everything ready?\"|
  The old sailor dabs a final touch of color onto the canvas, then signs his work with a chuckle. \"All set, Y'Gael.\"|
  \"Very well.\" The old woman hands you a slim golden wand and nods at the easel. \"Here. You need the experience.\"|
  The painting shimmers with Magick as the wand's rays play across its surface. You watch with growing wonder as the skillful strokes and flourishes become one with the sea and sky, artfully blending with your surroundings until it's hard to tell where one begins and the other ends.|
  \"Cast off, Mister Clutchcake!\" cries the old sailor, taking his place behind the wheel. \"Let's be underway while the tide's still with us!\"|
  \"Aye, Captain!\" The cook from the Rusty Lantern chops the mooring rope with a meat cleaver, and your magnificent galleon glides away from the wharf and high into the sky, held aloft by planes of sparkling Magick. The village of Grubbo-by-the-Sea dwindles off the stern; you can just see the little hilltop where your adventure began, so long ago.|
  The woman called Y'Gael weighs the Coconut of Quendor thoughtfully in her hand. \"Better go below and take a nap,\" she suggests as you stifle a yawn. \"You're going to need it.\"||">
	 <SET X <INPUT 1>>
	 
	 <CLEAR -1>
	 <SPLIT 14>
	 <PUTB ,DBOX 0 ,SP>
	 <COPYT ,DBOX <REST ,DBOX 1> %<- 0 <- ,DBOX-LENGTH 1>>>
	 <SHOW-RANK ,WIDTH>
	 <COND (<ZERO? ,VT220>
		<APPLE-BARS>)
	       (T
		<STATBARS 3 <- </ <- ,WIDTH ,BARWIDTH> 2> 1> ,LUCK>)>
	 <TELL CR "Thus ends the story of ">
	 <ITALICIZE "Beyond Zork">
	 <TELL ": ">
	 <HLIGHT ,H-ITALIC>
	 <PRINT "The Coconut of Quendor">
	 <HLIGHT ,H-NORMAL>
	 <TELL ,PERIOD>
	 <TELL CR "Your final rank is ">
	 <SET LEVEL <ANNOUNCE-RANK>>
	 <TELL " in " N ,MOVES " moves, ">
	 <COND (<ZERO? ,RANK>
		<SET LEVEL <- 9 .LEVEL>>
		<TELL N .LEVEL " level">
		<COND (<NOT <EQUAL? .LEVEL 1>>
		       <TELL "s">)>
		<TELL " below ">)>
	 <TELL "the highest possible rank." CR>
       ; <SAVE-CHAR>
	 <OPTIONS>
	 <RTRUE>>

; <ROUTINE SAVE-CHAR ("AUX" X Y SEED DELTA TBL)
	 <TELL CR
"Do you want to save your character for future reference?">
	 <COND (<YES?>
		<SET X 63>
		<REPEAT ()
		   <PUTB ,AUX-TABLE .X <RANDOM 255>>
		   <COND (<DLESS? X 24>
			  <RETURN>)>>
		<SET SEED <GETB ,AUX-TABLE 51>>
		<SET DELTA <GETB ,AUX-TABLE 61>>
		<COPYT ,CHARNAME ,AUX-TABLE %<+ ,CHARNAME-LENGTH 1>>
		<SET TBL <REST ,AUX-TABLE 32>>
		<SET X 7>
		<SET Y 0>
		<REPEAT ()
		   <PUT .TBL .Y <- 0 <+ <GET ,STATS .X> .SEED>>>
		   <SET SEED <+ .SEED .DELTA>>
		   <DEC X>
		   <COND (<IGRTR? Y 7>
			  <RETURN>)>>
		<SET X <SAVE ,AUX-TABLE 64 ,SAVE-NAME>>
		<COND (<ZERO? .X>
		       <FAILED "SAVE">)
		      (<EQUAL? .X 1>
		       <TELL CR "The character \"">
		       <PRINT-TABLE ,CHARNAME>
		       <TELL "\" has been saved." CR>)>)>
	 <RFALSE>>
	 
<ROUTINE CHEATER ()
	 <CRLF>
	 <NYMPH-APPEARS>
	 <TELL "Shame on you">
	 <PRINT ". Bye!\"|  She disappears with a wink.|">
	 <CRLF>
	 <QUIT>
	 <RFALSE>>