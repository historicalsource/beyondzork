"PLACES for BEYOND ZORK:
 Copyright (C)1987 Infocom, Inc. All rights reserved."

<ROUTINE GET-OWOMAN-AND-CURTAIN ()
	 <MAKE ,CURTAIN ,NODESC>
	 <COND (<NOT <IN? ,CURTAIN ,HERE>>
		<MOVE ,CURTAIN ,HERE>)>
	 <PUTP ,OWOMAN ,P?LAST-LOC ,HERE>
	 <COND (<NOT <IN? ,OWOMAN ,HERE>>
		<MOVE ,OWOMAN ,HERE>)>
	 <REMOVE-ALL ,OWOMAN>
	 <SEE-CHARACTER ,OWOMAN>
	 <RFALSE>>

<ROUTINE GET-DACT? ()
	 <COND (<AND <NOT <IS? ,DACT ,TOUCHED>>
		     <NOT <IS? ,HERE ,TOUCHED>>
		     <LAST-ROOM-IN? ,MOOR-ROOMS 2>>
		<MAKE ,DACT ,TOUCHED>
		<MOVE ,DACT ,HERE>
		<QUEUE ,I-DACT>
		<RTRUE>)>
	 <RFALSE>>

<OBJECT HILLTOP
	(LOC ROOMS)
	(DESC "Hilltop")
	(FLAGS LIGHTED LOCATION)
	(EAST <SAY-TO COVESIDE "You amble down the hill.">)
	(NW <TO ON-PIKE>)
	(DOWN <PER EXIT-A-TREE>)
	(UP <PER CLIMB-A-TREE>)
	(OVERHEAD OAK2)
	(EXIT-STR "The hillside is too steep that way.")
	(GLOBAL GRUBBO)
	(FNUM OGRUBBO)
	(THINGS (<> HILL HERE-F)
	        (<> HILLTOP HERE-F)
		(GREAT SEA USELESS)
		(<> SHORE USELESS))
	(ACTION HILLTOP-F)>

"SEEN = seen morning."

<ROUTINE HILLTOP-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The horizon is lost in the glare of morning upon the Great Sea. You shield your eyes to sweep the shore below, where a village lies nestled beside a quiet cove." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<SETG P-IT-OBJECT ,OAK2>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		       <SETG P-WALK-DIR ,P?EAST>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT COVESIDE
	(LOC ROOMS)
	(DESC "Cove")
	(FLAGS LIGHTED LOCATION)
	(NE <TO AT-LEDGE 3>)
	(EAST <TO ON-WHARF>)
	(SOUTH <TO OUTSIDE-PUB>)
	(WEST <TO HILLTOP>)
	(UP <TO HILLTOP>)
	(GLOBAL GRUBBO WHARF)
	(FNUM OGRUBBO)
	(THINGS (<> COVE HERE-F)
	 	(<> GULLS USELESS)
		(<> SHANTIES <>))
	(ACTION COVESIDE-F)>

<ROUTINE COVESIDE-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Gulls circle the far end of a wharf extending east across the cove. The street is dotted with shanties bleached by years of sun and salt." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?UP>
		       <SETG P-WALK-DIR ,P?WEST>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT OUTSIDE-PUB
	(LOC ROOMS)
	(DESC "Outside Pub")
	(FLAGS LIGHTED LOCATION)
	(NORTH <TO COVESIDE>)
	(SOUTH <TO N-MOOR>)
	(WEST <THRU PUB-DOOR IN-PUB>)
	(IN <THRU PUB-DOOR IN-PUB>)
	(GLOBAL PUB-DOOR PUB GRUBBO)
	(FNUM OGRUBBO)
	(HEAR PUB)
	(ODOR PUB)
	(ACTION OUTSIDE-PUB-F)>

<ROUTINE OUTSIDE-PUB-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Harsh laughter and mouthwatering aromas waft ">
		<COND (<IS? ,PUB-DOOR ,OPENED>
		       <TELL "through the open ">)
		      (T
		       <TELL "out from under the ">)>
		<TELL "door of a shanty on the street's west side. ">
		<DESCRIBE-PUB-SIGN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-PUB-SIGN ("AUX" X)
	 <TELL
"The words \"Ye Rusty Lantern, A Publick House\" appear in fading script above ">
	 <COND (<SET X <FIRST? ,PUB-SIGN>>
		<THIS-IS-IT .X>
		<COND (<EQUAL? .X ,LANTERN>
		       <TELL "a real " D .X>)
		      (T
		       <TELL A .X>)>
		<TELL ", dangling from a ">)
	       (T
		<SETG P-IT-OBJECT ,PUB-SIGN>
		<TELL "an empty ">)>
	 <TELL "hook." CR>
	 <RTRUE>>

<OBJECT N-MOOR
	(LOC ROOMS)
	(DESC "Moor's Edge")
	(FLAGS LIGHTED LOCATION)
	(NORTH <TO OUTSIDE-PUB>)
	(SOUTH <PER N-MOOR-S 1>)
	(FNUM OGRUBBO)
	(GLOBAL GRUBBO)
	(ACTION N-MOOR-F)>

<ROUTINE N-MOOR-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A gray scrim of mist lies across the southern moors, obscuring the path only a few steps away. The outskirts of a village">
		<PRINT " can be seen not far to the north.|">
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		       <COND (<T? ,AUTO>
			      <BMODE-OFF>)>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-GAS
	(LOC ROOMS)
	(DESC "Gasses")
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OMOOR)
	(EXIT-STR "Tall reeds block your path.")
	(GLOBAL SWAMP FOG)
	(ACTION IN-GAS-F)>

<ROUTINE IN-GAS-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Your feet make wet, sucking noises as you trudge across patches of rotting vegetable matter. An unwholesome miasma of gasses is making your head swim." CR>
		<MENTION-MOOR-EXIT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE DO-GAS-EXIT ("AUX" DIR CNT TBL)
	 <COND (<OR <EQUAL? ,P-WALK-DIR ,P?IN ,P?OUT>
		    <EQUAL? ,P-WALK-DIR ,P?UP ,P?DOWN>>
		<RFALSE>)>
	 <SET DIR ,P?NW>
	 <SET CNT 1>
	 <REPEAT ()
	    <SET TBL <GETP ,HERE .DIR>>
	    <COND (<ZERO? .TBL>)
		  (<EQUAL? <MSB <GET .TBL ,XTYPE>> ,CONNECT>
		   <INC CNT>
		   <PUT ,GOOD-DIRS .CNT .DIR>)>
	    <COND (<IGRTR? DIR ,P?NORTH>
		   <RETURN>)>>
	 <COND (<EQUAL? .CNT 2>
		<SET DIR <GET ,GOOD-DIRS 2>>)
	       (T
		<PUT ,GOOD-DIRS 0 .CNT>
		<PUT ,GOOD-DIRS 1 0>
		<PROG ()
		   <SET DIR <PICK-ONE ,GOOD-DIRS>>
		   <COND (<EQUAL? .DIR ,PRSO>
			  <AGAIN>)>>)>
	 <COND (<PROB <- ,STATMAX <GET ,STATS ,LUCK>>>
		<SETG PRSO .DIR>
		<SETG P-WALK-DIR .DIR>
		<TELL 
"You stumble uncertainly in the whirling gas." CR>
		<COND (<T? ,VERBOSITY>
		       <CRLF>)>)>
	 <RFALSE>>		

<OBJECT MOOR2
	(LOC ROOMS)
	(DESC "Eyes")
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OMOOR)
	(EXIT-STR "Tall reeds block your path.")
	(GLOBAL SWAMP FOG)
	(ACTION MOOR2-F)>

<ROUTINE MOOR2-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Silent, unblinking eyes peer down at you from the fog-shrouded trees." CR>
		<MENTION-MOOR-EXIT>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<GET-DACT?>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT MOOR3
	(LOC ROOMS)
	(DESC "Deep Mist")
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OMOOR)
	(EXIT-STR "Tall reeds block your path.")
	(GLOBAL SWAMP FOG)
	(ACTION MOOR3-F)>

<ROUTINE MOOR3-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Spooky fingers of mist swirl around your feet. It's hard to see more than a few yards in any " 'INTDIR ,PERIOD>
		<MENTION-MOOR-EXIT>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<GET-DACT?>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT MOOR4
	(LOC ROOMS)
	(DESC "Noises")
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OMOOR)
	(EXIT-STR "Tall reeds block your path.")
	(GLOBAL SWAMP FOG)
	(ACTION MOOR4-F)>

<ROUTINE MOOR4-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A cacophony of peeps, hoots and croaks sets your nerves on edge." CR> 
		<MENTION-MOOR-EXIT>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<GET-DACT?>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT MOOR5
	(LOC ROOMS)
	(DESC "Mud Flats")
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OMOOR)
	(EXIT-STR "Tall reeds block your path.")
	(GLOBAL SWAMP FOG)
	(ACTION MOOR5-F)>

<ROUTINE MOOR5-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Narrow paths wander off between pools of black, fetid mud. The damp chill in the air is making you shiver." CR>
		<MENTION-MOOR-EXIT>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<GET-DACT?>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT MOOR6
	(LOC ROOMS)
	(DESC "Odors")
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OMOOR)
	(EXIT-STR "Tall reeds block your path.")
	(GLOBAL SWAMP FOG)
	(ACTION MOOR6-F)>

<ROUTINE MOOR6-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Gray wraiths of mist linger among the reeds, filling your nostrils with the odor of things long dead." CR>
		<MENTION-MOOR-EXIT> 
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<GET-DACT?>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE MENTION-MOOR-EXIT ("AUX" (WRD 0) TBL)
	 <SET TBL <GETP ,HERE ,P?SW>>
	 <COND (<AND <T? .TBL>
		     <EQUAL? <GET .TBL ,XROOM> ,SW-MOOR>>
		<SET WRD ,W?SOUTHWEST>)
	       (T
		<SET TBL <GETP ,HERE ,P?NORTH>>
		<COND (<AND <T? .TBL>
			    <EQUAL? <GET .TBL ,XROOM> ,N-MOOR>>
		       <SET WRD ,W?NORTH>)>)>
	 <COND (<ZERO? .WRD>
		<RFALSE>)>
	 <TELL ,TAB "The mist thins out a bit to the " B .WRD ,PERIOD>
	 <RTRUE>>

<OBJECT SW-MOOR
	(LOC ROOMS)
	(DESC "Bluffs")
	(FLAGS LIGHTED LOCATION)
	(NE <PER SW-MOOR-NE 5>)
	(WEST <TO IN-PORT>)
	(FNUM OMIZNIA)
	(ACTION SW-MOOR-F)>

<ROUTINE SW-MOOR-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Circling gulls and a forest of masts disclose a seaport not far to the west. The view to the northeast is obscured by a blanket of mist." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<EQUAL? ,P-WALK-DIR ,P?SW>
		       <COND (<T? ,AUTO>
			      <BMODE-OFF>)>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-PORT
	(LOC ROOMS)
	(DESC "Mizniaport")
	(FLAGS LIGHTED LOCATION)
        (NORTH <THRU BOUTIQUE-DOOR IN-BOUTIQUE>)
      	(IN <THRU BOUTIQUE-DOOR IN-BOUTIQUE>)
	(NE <TO IN-YARD>)
	(EAST <TO SW-MOOR>)
	(SE <SORRY "You'd fall in the bay if you went that way.">)
	(SOUTH <SORRY "You'd fall in the bay if you went that way.">)
	(SW <SORRY "You'd fall in the bay if you went that way.">)
	(WEST <TO AT-DOCK>)
	(NW <TO XROADS 11>)
	(FNUM OMIZNIA)
	(GLOBAL BOUTIQUE-DOOR BOUTIQUE STABLE)
	(ACTION IN-PORT-F)>

<ROUTINE IN-PORT-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Mizniaport is a magnet for the wealthy yipples of Borphee, who browse the colorful shops in search of next year's fashions" ,PTAB 
"An especially swank boutique stands just north of here. Beside it, a path marked \"Private Way\" bends northeast." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-YARD
	(LOC ROOMS)
	(DESC "Private Way")
	(FLAGS LIGHTED LOCATION)
	(NORTH <TO IN-STABLE>)
	(IN <TO IN-STABLE>)
	(SW <TO IN-PORT>)
	(FNUM OMIZNIA)
	(GLOBAL STABLE)
	(ACTION IN-YARD-F)>

<ROUTINE IN-YARD-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"This shady nook obviously belongs to some well-to-do yipple. The arborvitaes are lush and neatly trimmed, with twin beds of flowers leading up to a little red " 'STABLE ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT IN-STABLE
	(LOC ROOMS)
	(DESC "Stablehouse")
	(FLAGS LIGHTED LOCATION INDOORS)
	(SOUTH <TO IN-YARD>)
	(OUT <PER EXIT-STABLE>)
	(IN <PER STABLE-IN>)
	(FNUM OMIZNIA)
	(GLOBAL STABLE)
	(ACTION IN-STABLE-F)>

<ROUTINE STABLE-IN ()
	 <PERFORM ,V?ENTER ,STALL>
	 <RFALSE>>

<ROUTINE EXIT-STABLE ()
	 <COND (<IN? ,PLAYER ,STALL>
		<PERFORM ,V?EXIT ,STALL>
		<RFALSE>)>
	 <RETURN ,IN-YARD>>

<ROUTINE IN-STABLE-F ("OPT" (CONTEXT <>) "AUX" (U 0) ANY X)
	 <COND (<IN? ,UNICORN ,STALL>
		<INC U>)>
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<COND (<IS? ,STALL ,MUNGED>
		       <TELL "The splintered ruins of " THE ,STALL
			     " look out of place in this otherwise">)
		      (T
		       <TELL "Not a straw is out of place in this">)>
		<TELL " immaculate " 'STABLE>
		<COND (<IN? ,PLAYER ,STALL>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<SET ANY <SEE-ANYTHING-IN? ,STALL>>
		<COND (<IS? ,STALL ,MUNGED>
		       <COND (<T? .ANY>
			      <TELL ". ">
			      <PRINT "Peering inside, you see ">
			      <CONTENTS ,STALL>
			      <SETG P-IT-OBJECT ,STALL>)>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<TELL ". The one">
		<OPEN-CLOSED ,STALL>
		<TELL ,SIS>
		<COND (<T? .U>
		       <TELL "occupied by a snow-white " 'UNICORN 
", who gazes at you mournfully from between the slats">
		       <COND (<T? .ANY>
			      <TELL ". You can also ">)>)
		      (T
		       <TELL "unoccupied">
		       <COND (<T? .ANY>
			      <TELL "; you can ">)>)>
		<COND (<T? .ANY>
		       <TELL "see ">
		       <CONTENTS ,STALL>
		       <TELL " inside">
		       <SETG P-IT-OBJECT ,STALL>)>
		<PRINT ,PERIOD>   
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<T? .U>
		       <SEE-CHARACTER ,UNICORN>
		       <MAKE ,UNICORN ,SEEN>
		       <QUEUE ,I-UNICORN>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<T? .U>
		       <DEQUEUE ,I-UNICORN>
		       <TELL CTHE ,UNICORN
			     " whinnies pitifully as you leave." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>


<OBJECT IN-BOUTIQUE
	(LOC ROOMS)
	(DESC "Boutique")
	(FLAGS LIGHTED LOCATION INDOORS)
	(SOUTH <THRU BOUTIQUE-DOOR IN-PORT>)
	(OUT <THRU BOUTIQUE-DOOR IN-PORT>)
	(EAST <PER ENTER-CURTAIN>)
	(IN <PER ENTER-CURTAIN>)
	(GLOBAL BOUTIQUE-DOOR BOUTIQUE)
	(THIS-CASE BCASE)
	(FNUM OMIZNIA)
	(ACTION IN-BOUTIQUE-F)>

<ROUTINE IN-BOUTIQUE-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The sheer, flowing fabrics and gossamer pastels in this little shop create an atmosphere of taste and calm conducive to reckless spending.|  A ">
		<SHOP-DOOR ,BOUTIQUE-DOOR>
		<TELL " offers the latest in travel fashions">
		<LOOK-ON-CASE ,ON-BCASE>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<GET-OWOMAN-AND-CURTAIN>
		<QUEUE ,I-OWOMAN>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<DEQUEUE ,I-OWOMAN>
		<COND (<IN? ,OWOMAN ,IN-BOUTIQUE>
		       <TELL
"\"See you later,\" calls " THE ,OWOMAN " as you leave." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-PUB
	(LOC ROOMS)
	(DESC "The Rusty Lantern")
	(FLAGS LIGHTED LOCATION INDOORS)
	(EAST <THRU PUB-DOOR OUTSIDE-PUB>)
	(WEST <TO IN-KITCHEN>)
	(OUT <THRU PUB-DOOR OUTSIDE-PUB>)
	(IN <TO IN-KITCHEN>)
	(HEAR PUB)
	(ODOR PUB)
	(FNUM OGRUBBO)
	(GLOBAL PUB KITCHEN PUB-DOOR CELLAR GRUBBO)
	(THINGS (<> FIREPLACE USELESS))
	(ACTION IN-PUB-F)>

<ROUTINE IN-PUB-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Loud voices and clattering dishes make this smarmy dive sound busier than it really is. Your eyes sting from the greasy smoke drifting in from "
THE ,KITCHEN ,PTAB CA ,BANDITS " is hogging the fireplace." CR>
		<COND (<SET X <FIRST? ,PUBWALL>>
		       <SETG P-IT-OBJECT .X>
		       <TELL ,TAB CA .X " is imbedded in the wall." CR>)>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<QUEUE ,I-BANDITS>
		<RFALSE>)
	       
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<SETG P-THEM-OBJECT ,BANDITS>
		<RFALSE>)
	       
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<ZERO? ,P-WALK-DIR>)
		      (<IS? ,DAGGER ,NODESC>
		       <UNMAKE ,DAGGER ,NODESC>
		       <WINDOW ,SHOWING-ROOM>
		       <MOVE ,DAGGER ,PUBWALL>
		       <SETG P-IT-OBJECT ,DAGGER>
		       <MAKE ,BANDITS ,SEEN>
		       <TELL "You edge towards the ">
		       <COND (<EQUAL? ,P-WALK-DIR ,P?WEST ,P?IN>
			      <TELL 'KITCHEN>)
			     (T
			      <TELL B ,W?EXIT>)>
		       <TELL ,PTAB>
		       <ITALICIZE "Thwack">
		       <TELL 
"! A dagger streaks past your ear, imbedding itself deep into the wall.|
  \"Har!\" chortles a bandit." CR>
		       <RFATAL>)>
		<DEQUEUE ,I-BANDITS>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-KITCHEN
	(LOC ROOMS)
	(DESC "Kitchen")
	(FLAGS LIGHTED LOCATION INDOORS)
	(BELOW CELLAR-DOOR)
	(IN <THRU CELLAR-DOOR AT-BOTTOM>)
	(OUT <TO IN-PUB>)
	(EAST <TO IN-PUB>)
	(DOWN <THRU CELLAR-DOOR AT-BOTTOM>)
	(HEAR PUB)
	(ODOR PUB)
	(FNUM OGRUBBO)
	(GLOBAL CELLAR-DOOR CELLAR-STAIR KITCHEN CELLAR PUB GRUBBO)
	(ACTION IN-KITCHEN-F)>

<ROUTINE IN-KITCHEN-F ("OPT" (CONTEXT <>) "AUX" (D 0) L)
	 <COND (<IS? ,CELLAR-DOOR ,OPENED>
		<INC D>)>
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Coils of greasy steam rise from a cauldron bubbling over a roaring hearth. "
CTHE ,CEILING " is hung with crusty pots and strips of old meat" ,PTAB "A">
		<COND (<IS? ,CELLAR-DOOR ,MUNGED>
		       <TELL " gaping hole">)
		      (<T? .D>
		       <TELL "n open door">)
		      (T
		       <TELL " closed door">)>
		<TELL ,SIN THE ,GCORNER>
		<COND (<T? .D>
		       <TELL " reveals a stair leading downward." CR>
		       <RTRUE>)>
		<TELL " bears the legend, \"Keepeth Out.\"" CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<NOT <IN? ,COOK ,IN-KITCHEN>>
		       <MOVE ,COOK ,IN-KITCHEN>)>
		<UNMAKE ,COOK ,NODESC>
		<SEE-CHARACTER ,COOK>
		<MAKE ,COOK ,SEEN>
		<QUEUE ,I-COOK>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IS? ,BOTTLE ,MUNGED>
		       <RFALSE>)
		      (<IN? ,BOTTLE ,PLAYER>
		       <TELL ,TAB>
		       <COOK-SEES-BOTTLE>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<AND <T? ,P-WALK-DIR>
			    <IS? ,ONION ,TOUCHED>
			    <NOT <IS? ,BOTTLE ,IDENTIFIED>>>
		       <UNMAKE ,COOK ,SEEN>
		       <TELL "\"Wait a second.\"" CR>
		       <I-ONION-OFFER>
		       <RFATAL>)
		      (<EQUAL? ,P-WALK-DIR ,P?DOWN ,P?IN>
		       <COND (<ZERO? .D>
			      <ITS-CLOSED ,CELLAR-DOOR>
			      <RFATAL>)
			     (<NOT <IS? ,CELLAR-DOOR ,TOUCHED>>
			      <MAKE ,CELLAR-DOOR ,TOUCHED>
			      <COND (<NOT <SETUP-CELLAR?>>
				     <RFALSE>)>)>
		       <DEQUEUE ,I-COOK>
		       <TELL "You clump down "
			     THE ,CELLAR-STAIR ,PERIOD>
		       <RTRUE>)
		      (<EQUAL? ,P-WALK-DIR ,P?EAST ,P?OUT>
		       <SETG P-WALK-DIR ,P?EAST>
		       <DEQUEUE ,I-COOK>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT KITCHEN-JUNK 
	(LOC IN-KITCHEN)
	(DESC "that")
	(FLAGS NOARTICLE NODESC TRYTAKE NOALL)
	(SYNONYM MEAT CAULDRON STRIPS HEARTH POT POTS)
	(ACTION USELESS)>

<OBJECT ON-WHARF
	(LOC ROOMS)
	(DESC "Wharf")
	(FLAGS LIGHTED LOCATION)
	(COORDS MAP-RIGHT)
	(WEST <TO COVESIDE>)
	(DOWN <PER ON-WHARF-DOWN>)
	(IN <PER ON-WHARF-DOWN>)
	(HEAR COVE)
	(ODOR WHARF)
	(SEE-ALL COVE)
	(BELOW COVE)
	(GLOBAL GRUBBO WHARF)
	(FNUM OGRUBBO)
	(ACTION ON-WHARF-F)>

<ROUTINE ON-WHARF-DOWN ()
	 <MAKE ,SALT ,SEEN>
	 <TELL "\"Careful!\" warns " THE ,SALT 
", holding you back. \"Water's mighty cool this time o' year.\"" CR>
	 <RFALSE>>

<ROUTINE ON-WHARF-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<PRINT 
"Dank, fishy smells permeate this old wharf to its very bones.">
		<TELL " Far below, you ">
		<PRINT "hear the slurp of oily seawater against the piers">
		<COND (<FIRST? ,COVE>
		       <TELL ,PTAB ,YOU-SEE>
		       <CONTENTS ,COVE>
		       <TELL " bobbing on the waves">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<NOT <IS? ,SHILL ,BUOYANT>>
		       <MAKE ,SHILL ,BUOYANT>
		       <QUEUE ,I-SHILL>)>
		<MAKE ,SALT ,SEEN>
		<QUEUE ,I-SALT>
		<SEE-CHARACTER ,SALT>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<NOT <IS? ,SHILL ,SEEN>>
		       <SEE-SHILL>
		       <RFATAL>)>
		<DEQUEUE ,I-SALT>
		<COND (<T? ,P-WALK-DIR>
		       <TELL 
"\"See y'later,\" chuckles the salt as you walk away." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT NULL
	(FLAGS NODESC)>

<OBJECT AT-BOTTOM
	(LOC ROOMS)
	(DESC "Wine Cellar")
	(FLAGS LIGHTED LOCATION INDOORS)
	(UP <THRU CELLAR-DOOR IN-KITCHEN>)
	(OUT <SORRY "Which way do you want to go out?">)
	(OVERHEAD CELLAR-DOOR)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OGRUBBO)
	(GLOBAL NULL CELLAR-STAIR CELLAR-DOOR CELLAR)
	(ACTION AT-BOTTOM-F)>

<ROUTINE LOCK-CELLAR-DOOR ()
	 <MAKE ,CELLAR-DOOR ,LOCKED>
	 <TELL ,YOU-HEAR ,LTHE>
	 <ITALICIZE "snap">
	 <TELL " of a substantial lock." CR>
	 <RTRUE>>

<ROUTINE AT-BOTTOM-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're standing at the bottom of a short, rickety stairway, ankle-deep in refuse. ">
		<COND (<IS? ,CELLAR-DOOR ,OPENED>
		       <TELL "Light streams down through a">
		       <COND (<IS? ,CELLAR-DOOR ,MUNGED>
			      <TELL " gaping hole">)
			     (T
			      <TELL "n open door">)>
		       <TELL " overhead." CR>
		       <RTRUE>)>
		<TELL "The door overhead is closed." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<NOT <IN? ,COOK ,AT-BOTTOM>>
		       <MOVE ,COOK ,AT-BOTTOM>
		       <MAKE ,COOK ,NODESC>)>
		<SETG P-IT-OBJECT ,CELLAR-DOOR>
	        <RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?UP>
		       <COND (<IS? ,CELLAR-DOOR ,MUNGED>
			      <COND (<T? ,AUTO>
				     <BMODE-OFF>)>
			      <YOU-CLIMB-UP T>
			      <RTRUE>)
			     (<IS? ,CELLAR-DOOR ,LOCKED>
			      <SETG P-IT-OBJECT ,CELLAR-DOOR>
			      <TELL CTHE ,P-IT-OBJECT " is locked." CR>
			      <RFATAL>)
			     (<IS? ,CELLAR-DOOR ,OPENED>
			      <WINDOW ,SHOWING-ROOM>
			      <SETG P-IT-OBJECT ,CELLAR-DOOR>
			      <UNMAKE ,CELLAR-DOOR ,OPENED>
			      <UNMAKE ,AT-BOTTOM ,LIGHTED>
			      <ITALICIZE "Bang">
			      <TELL "! An unseen hand slams "
				    THE ,CELLAR-DOOR " in your face." CR>
			      <SAY-IF-HERE-LIT>
			      <TELL ,TAB>
			      <LOCK-CELLAR-DOOR>
			      <RFATAL>)>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT WC1
	(LOC ROOMS)
	(DESC "Reeking Room")
	(FLAGS LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OGRUBBO)
	(GLOBAL NULL CELLAR)
	(ACTION WC1-F)>

<ROUTINE WC1-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Smashed bottles litter the floor, and the air reeks of sour wine." CR>
	        <RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SKEL-ROOM
	(LOC ROOMS)
	(DESC "Shadowy Stacks")
	(FLAGS LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OGRUBBO)
	(GLOBAL NULL CELLAR)
	(ACTION SKEL-ROOM-F)>

<ROUTINE SKEL-ROOM-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Precarious stacks of barrels loom in the shadows on every side." CR> 
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-BEG>
		<COND (<ZERO? ,CHOKE>
		       <RFALSE>)
		      (<VERB? SAVE UNDO>
		       <MUMBLAGE ,SKELETON>
		       <RTRUE>)
		      (<OR <VERB? WAIT LOOK>
			   <SET X <GAMEVERB?>>>
		       <RFALSE>)>
		<SET X ,P-PRSA-WORD>
		<COND (<VERB? WALK WALK-TO>
		       <SET X ,W?MOVE>)
		      (<SET X <TALKING?>>
		       <SET X ,W?SPEAK>)
		      (<SET X <SEEING?>>
		       <SET X ,W?SEE>)
		      (<EQUAL? ,SKELETON ,PRSO ,PRSI>
		       <RFALSE>)>
		<TELL "It's not easy to ">
		<COND (<ZERO? .X>
		       <TELL "do that">)
		      (T
		       <TELL B .X>)>
		<TELL " while you're being strangled to death." CR>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<OBJECT MOSS-ROOM
	(LOC ROOMS)
	(DESC "Musty Corridor")
	(FLAGS LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OGRUBBO)
	(THINGS (DAMP CORRIDOR HERE-F)
	 	(DAMP HALL HERE-F)
	 	(DAMP HALLWAY HERE-F))
	(GLOBAL NULL CELLAR)
	(ACTION MOSS-ROOM-F)>

<ROUTINE MOSS-ROOM-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SET X <LIGHT-SOURCE?>>
		<COND (<ZERO? .X>
		       <TELL "The dim light">)
		      (T
		       <TELL CTHE .X "'s glow">)>
		<TELL " reveals a gray patch of moss on the wall." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT AT-STACK
	(LOC ROOMS)
	(DESC "Bottom of Stack")
	(FLAGS LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OGRUBBO)
	(OVERHEAD CRATES)
	(UP <PER UPSTACK 1>)
	(DOWN <SORRY "You're already at the bottom of the stack.">)
	(GLOBAL NULL CELLAR CRATES)
	(ACTION AT-STACK-F)>

<ROUTINE UPSTACK ("AUX" (BAD 0))
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFALSE>)>
	 <TELL "You teeter ">
	 <COND (<L? <GET ,STATS ,DEXTERITY> 15>
		<INC BAD>
		<TELL "uncertainly">)
	       (T
		<TELL "for a moment">)>
	 <TELL " on the lowest crates">
	 <COND (<T? .BAD>
		<TELL 
", lose your balance, and sprawl to " THE ,GROUND>
		<COND (<NOT <IS? ,CRATES ,SEEN>>
		       <MAKE ,CRATES ,SEEN>
		       <TELL ". Not very coordinated, are you?" CR>
		       <RFALSE>)>
		<PRINT ,PERIOD>
		<RFALSE>)>
	 <TELL ", then slowly edge your way upward." CR>
	 <COND (<T? ,VERBOSITY>
		<CRLF>)>
	 <RETURN ,BARRELTOP>>

<ROUTINE AT-STACK-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Empty wine crates are stacked to " 
		      THE ,CEILING " in a stairlike spiral." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT THRONE-ROOM
	(LOC ROOMS)
	(DESC "Throne Room")
	(FLAGS LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(FNUM OGRUBBO)
	(GLOBAL NULL CELLAR)
	(ACTION THRONE-ROOM-F)>

<ROUTINE THRONE-ROOM-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A shallow nest of sea shells, coral and other bits of ocean debris lies in "
THE ,GCORNER>
		<COND (<SEE-ANYTHING-IN? ,THRONE>
		       <TELL ". Upon this pile you see ">
		       <CONTENTS ,THRONE>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<NOT <IS? ,CRAB ,MONSTER>>
		       <MAKE ,CRAB ,MONSTER>
		       <WINDOW ,SHOWING-ROOM>
		       <QUEUE ,I-CRAB>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>
		      
<OBJECT BARRELTOP
	(LOC ROOMS)
	(DESC "Top of Stack")
	(FLAGS LOCATION INDOORS)
	(NORTH <SORRY "You'd fall off the barrel if you went that way.">)
	(NE <SORRY "You'd fall off the barrel if you went that way.">)
	(EAST <SORRY "You'd fall off the barrel if you went that way.">)
	(SE <SORRY "You'd fall off the barrel if you went that way.">)
	(SOUTH <SORRY "You'd fall off the barrel if you went that way.">)
	(SW <SORRY "You'd fall off the barrel if you went that way.">)
	(WEST <SORRY "You'd fall off the barrel if you went that way.">)
	(NW <SORRY "You'd fall off the barrel if you went that way.">)
	(DOWN <SAY-TO AT-STACK "You carefully descend the stack.">)
	(UP <SORRY "You're up as high as you can go.">)
	(FNUM OGRUBBO)
	(GLOBAL CRATES CELLAR)
	(ACTION BARRELTOP-F)>
	 
<ROUTINE BARRELTOP-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You struggle to keep your balance as the stack sways back and forth in the darkness." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<EQUAL? ,P-WALK-DIR ,P?UP>
		       <COND (<T? ,AUTO>
			      <BMODE-OFF>)>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-THRIFF
	(LOC ROOMS)
	(DESC "Thriff")
	(FLAGS LIGHTED LOCATION)
	(NE <TO AT-FALLS>)
	(SOUTH <TO FOREST-EDGE>)
	(UP <TO FOREST-EDGE>)
	(NW <TO IN-PASTURE>)	
	(WEST <THRU CHAPEL-DOOR IN-CHAPEL>)
	(IN <THRU CHAPEL-DOOR IN-CHAPEL>)
	(FNUM OTHRIFF)
	(GLOBAL CHAPEL-DOOR THRIFF CHAPEL)
	(ACTION IN-THRIFF-F)>
		
<ROUTINE IN-THRIFF-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Trim white cottages are clustered around a central grove of mountain firs, tall and lovingly tended. A little chapel graces the west side of the street">
		<COND (<IS? ,CHAPEL-DOOR ,OPENED>
		       <TELL ", its front doors wide open">)>
		<TELL ,PTAB "Turning south, you see a ">
		<COND (<IS? ,FOREST-EDGE ,MUNGED>
		       <TELL "wall of " 'XTREES
			     " waiting to descend upon the village." CR>
		       <RTRUE>)>
		<TELL "narrow trail winding up into the mountains">
		<COND (<T? ,MAGMA-TIMER>
		       <TELL ", backlit by a ">
		       <GLOW-COLOR>
		       <TELL "glow of heat">)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?IN>
		       <SETG P-WALK-DIR ,P?WEST>)
		      (<EQUAL? ,P-WALK-DIR ,P?UP ,P?SOUTH>
		       <SETG P-WALK-DIR ,P?SOUTH>
		       <COND (<T? ,MAGMA-TIMER>
			      <COND (<WEARING-MAGIC? ,RING>
				     <TELL 
"Your ring finger tingles as you draw closer to the blistering heat." CR>
				     <RTRUE>)>
			      <TELL 
"A blistering wall of heat forces you to turn back." CR>
			      <RFATAL>)
			     (<GLOBAL-IN? ,FOREST-EDGE ,SNOW>
			      <TELL 
"Your feet become dusted with snow as you ascend." CR>
			      <RTRUE>)>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-CHAPEL
	(LOC ROOMS)
	(DESC "Chapel")
	(FLAGS LIGHTED LOCATION INDOORS)
	(FNUM OTHRIFF)
	(EAST <THRU CHAPEL-DOOR IN-THRIFF>)
	(OUT <THRU CHAPEL-DOOR IN-THRIFF>)
	(UP <PER EXIT-PEW>)
	(GLOBAL CHAPEL-DOOR CHAPEL)
	(ACTION IN-CHAPEL-F)>

<GLOBAL THRIFF-WON:FLAG <>>

<ROUTINE IN-CHAPEL-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<COND (<IN? ,CLERIC ,IN-CHAPEL>
		       <COND (<IN? ,RELIQUARY ,CLERIC>
			      <TELL CTHE ,CLERIC
" stands beside " THE ,ALTAR ", holding ">
			      <CONTENTS ,CLERIC>)
			     (T
			      <TELL "An anxious " 'CONGREG
" kneels in silent prayer before " THE ,CLERIC
". On the altar beside him rests ">
			      <CONTENTS ,ALTAR>)>)
		      (T
		       <TELL "Rows of empty pews face a deserted altar">
		       <COND (<SEE-ANYTHING-IN? ,ALTAR>
			      <TELL ", upon which rests ">
			      <CONTENTS ,ALTAR>)>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-BEG>
		<COND (<NOT <IN? ,CLERIC ,IN-CHAPEL>>
		       <RFALSE>)
		      (<VERB? HIT MUNG KICK>
		       <TELL "This is no place for violence." CR>
		       <RFATAL>)
		      (<T? ,THRIFF-WON>)
		      (<SET X <TALKING?>>
		       <MAKE ,CLERIC ,SEEN>
		       <PCLEAR>
		       <TELL C ,QUOTATION>
		       <SET X <RANDOM 100>>
		       <COND (<L? .X 33>
			      <TELL "Shhh">)
			     (<L? .X 67>
			      <TELL "Quiet">)
			     (T
			      <TELL "Shush">)> 
<TELL "!\" whispers a member of " THE ,CONGREG ,PERIOD>
		       <RFATAL>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<NOT <IS? ,CLERIC ,LIVING>>
		       <MAKE ,CLERIC ,LIVING>
		       <UNMAKE ,CLERIC ,SEEN>
		       <SETG P-HIM-OBJECT ,CLERIC>
		       <SETG P-THEM-OBJECT ,CONGREG>
		       <SETG CLERIC-SCRIPT ,INIT-CLERIC-SCRIPT>
		       <QUEUE ,I-CLERIC>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?OUT>
		       <SETG P-WALK-DIR ,P?EAST>)>
		<COND (<T? ,THRIFF-WON>)
		      (<IN? ,CLERIC ,IN-CHAPEL>
		       <DEQUEUE ,I-CLERIC>
		       <TELL C ,QUOTATION <PICK-NEXT ,CLERIC-WOES>
			     "!\" wails " THE ,CLERIC ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT FOREST-EDGE
	(LOC ROOMS)
	(DESC "Lava Flow")
	(SDESC DESCRIBE-FOREST-EDGE)
	(FLAGS LIGHTED LOCATION)
	(NORTH <TO IN-THRIFF>)
	(DOWN <TO IN-THRIFF>)
	(NE <SORRY "Rock walls block your path.">)
	(NW <SORRY "Rock walls block your path.">)
	(WEST <TO ON-TRAIL>)
	(UP <TO ON-TRAIL>)
	(EXIT-STR "Christmas trees block your path.")
	(GLOBAL XTREES SNOW GLYPH TRAIL)
	(FNUM OTHRIFF)
	(ACTION FOREST-EDGE-F)>

<ROUTINE DESCRIBE-FOREST-EDGE (OBJ)
	 <TELL "Snowy Clearing">
	 <RTRUE>>

<ROUTINE FOREST-EDGE-F ("OPT" (CONTEXT <>) "AUX" (BHERE 0))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<COND (<GLOBAL-IN? ,FOREST-EDGE ,LAVA>
		       <TELL 
"An avalanche of lava has consumed the upward trail, ending here in a ">
		       <COND (<T? ,MAGMA-TIMER>
			      <GLOW-COLOR>
			      <TELL B ,W?POOL>)
			     (T
			      <TELL "dark, steaming crust">)>
		       <TELL ". Many of the surrounding ">
		       <SAY-TREES>
		       <TELL 
" are damaged; the survivors linger near the blackened edge of the clearing." CR>)
		      (T
		       <TELL 
"The upward trail bends sharply west here, winding out of sight between the ">
		       <SAY-TREES>
		       <TELL ,PERIOD>)>
		<MENTION-GLYPH?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<IS? ,XTREES ,SEEN>
		       <SETG P-THEM-OBJECT ,XTREES>)>
		<COND (<GLOBAL-IN? ,FOREST-EDGE ,GLYPH>
		       <SETG P-IT-OBJECT ,GLYPH>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<NOT <IS? ,XTREES ,TOUCHED>>
		       <SEE-XTREES>
		       <RFATAL>)>
		<COND (<EQUAL? ,P-WALK-DIR ,P?UP>
		       <SETG P-WALK-DIR ,P?WEST>)>
		<COND (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		       <SETG P-WALK-DIR ,P?NORTH>)>
		<COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		       <COND (<T? ,LAVA-TIMER>
			      <TELL 
"Volcanic heat singes your eyebrows as you race down the mountainside." CR>
			      <RTRUE>)>
		       <TELL "You stride down into the village">
		       <BYE-BFLY>
		       <RTRUE>)
		      (<NOT <EQUAL? ,P-WALK-DIR ,P?WEST>>
		       <RFALSE>)
		      (<T? ,LAVA-TIMER>
		       <CASCADE "approach">
		       <RFATAL>)>
		<TELL CTHE ,XTREES " shuffle ">
		<COND (<T? ,MAGMA-TIMER>
		       <TELL "impotently at the lava's edge">)
		      (<AND <IN? ,BFLY ,PLAYER>
			    <IS? ,BFLY ,MUNGED>
			    <IS? ,BFLY ,LIVING>>
		       <TELL "nervously out of your way">)
		      (T
		       <MAKE ,XTREES ,SEEN>
		       <TELL 
"across the upward trail, blocking it completely." CR>
		       <RFATAL>)>
		<TELL " as you ascend the slope">
		<BYE-BFLY>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<ROUTINE BYE-BFLY ()
	 <COND (<AND <IN? ,BFLY ,HERE>
		     <IS? ,BFLY ,MUNGED>
		     <IS? ,BFLY ,LIVING>>
		<REMOVE ,BFLY>
		<DEQUEUE ,I-PILLAR>
		<TELL "; behind you, " THE ,BFLY " crawls out of sight">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE SEE-XTREES ()
	 <MAKE ,XTREES ,TOUCHED>
	 <MAKE ,XTREES ,SEEN>
	 <WINDOW ,SHOWING-ROOM>
	 <SETG P-THEM-OBJECT ,XTREES>
	 <SETG P-WALK-DIR <>>
	 <SETG OLD-HERE <>>
	 <MOVE ,ORNAMENT ,HERE>
	 <SETG P-IT-OBJECT ,ORNAMENT>
	 <QUEUE ,I-XTREES>
	 <ITALICIZE "Bonk">
	 <TELL "! Something hard hits the back of " 'HEAD
	       " and rolls to your feet." CR>
	 <BMODE-ON>
	 <UPDATE-STAT -5 ,ENDURANCE>
	 <TELL ,TAB
"A strange chorus of humming rises from the forest as you rub " 'HEAD
". It takes a few moments for you to recall the familiar melody: \""
<PICK-NEXT ,CAROLS> "!\"" CR>
	 <RFALSE>>

<ROUTINE SAY-TREES ()
	 <COND (<IS? ,XTREES ,TOUCHED>
		<TELL 'XTREES>)
	       (T
		<TELL B ,W?TREES>)>
	 <RTRUE>>

<ROUTINE MENTION-GLYPH? ("AUX" X)
	 <COND (<GLOBAL-IN? ,HERE ,GLYPH>
		<TELL ,TAB CA ,GLYPH " is inscribed in the ">
		<COND (<GLOBAL-IN? ,HERE ,SNOW>
		       <TELL B ,W?SNOW>)
		      (<ZERO? ,MAGMA-TIMER>
		       <TELL "hardened crust">)
		      (T
		       <GLOW-COLOR>
		       <TELL B ,W?LAVA>)>
		<TELL " at your feet." CR>)>
	 <RTRUE>>
		
<OBJECT ON-TRAIL
	(LOC ROOMS)
	(DESC "Mountain Trail")
	(FLAGS LIGHTED LOCATION)
	(EAST <TO FOREST-EDGE>)
	(DOWN <TO FOREST-EDGE>)
	(SOUTH <THRU CABIN-DOOR IN-CABIN>)
	(IN <THRU CABIN-DOOR IN-CABIN>)
	(WEST <TO ON-PEAK>)
	(UP <TO ON-PEAK>)
	(EXIT-STR "Steep rock walls block your path.")
	(GLOBAL SNOW NULL TRAIL)
	(FNUM OTHRIFF)
	(ACTION ON-TRAIL-F)>

<ROUTINE ON-TRAIL-F ("OPT" (CONTEXT <>) "AUX" (W 0) (LV 0))
	 <COND (<AND <IN? ,WIGHT ,ON-TRAIL>
		     <IS? ,WIGHT ,MONSTER>>
		<INC W>)>
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SET LV <GLOBAL-IN? ,ON-TRAIL ,LAVA>>
		<TELL "This ">
		<COND (<T? .LV>
		       <TELL 
"high trail has been consumed by an avalanche of ">
		       <COND (<T? ,MAGMA-TIMER>
			      <GLOW-COLOR>)>
		       <TELL 'LAVA>
		       <COND (<ZERO? ,MAGMA-TIMER>
			      <TELL ", still steaming in the frosty air">)>)
		      (T
		       <TELL 
"snowbound trail commands a superb view of the surrounding countryside. Maybe you could enjoy the sights if ">
		       <COND (<ZERO? ,LAVA-TIMER>
			      <TELL "your teeth would stop chatter">)
			     (T
			      <TELL THE ,GROUND " would stop shak">)>
		       <TELL "ing">)>
		<COND (<IS? ,FOREST-EDGE ,MUNGED>
		       <TELL ". The downward path is hopelessly choked with "
			     'XTREES>)>
		<PRINT ,PERIOD>
		<COND (<ZERO? .LV>
		       <TELL ,TAB CA ,CABIN 
			     " hugs the south side of the trail">
		       <COND (<IS? ,CABIN-DOOR ,OPENED>
			      <TELL 
", its front door banging open and shut in the wind">)>
		       <TELL ". Before it stands a">
		       <COND (<IS? ,MAILBOX ,OPENED>
			      <TELL "n open ">)
			     (T
			      <TELL " closed ">)>
		       <TELL 'MAILBOX ,PERIOD>)>
		<MENTION-GLYPH?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<GLOBAL-IN? ,ON-TRAIL ,GLYPH>
		       <SETG P-IT-OBJECT ,GLYPH>)>
		<COND (<T? .W>
		       <SETG P-IT-OBJECT ,WIGHT>
		       <SETG LAST-MONSTER ,WIGHT>
		       <SETG LAST-MONSTER-DIR ,P?EAST>
		       <QUEUE ,I-WIGHT>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		       <SETG P-WALK-DIR ,P?EAST>)
		      (<EQUAL? ,P-WALK-DIR ,P?UP>
		       <SETG P-WALK-DIR ,P?WEST>)
		      (<EQUAL? ,P-WALK-DIR ,P?IN>
		       <SETG P-WALK-DIR ,P?SOUTH>)>
		<COND (<EQUAL? ,P-WALK-DIR ,P?WEST>
		       <COND (<T? ,LAVA-TIMER>
			      <CASCADE "you approach">
			      <RFATAL>)
			     (<IN? ,WIGHT ,ON-TRAIL>
			      <COND (<NOT <IS? ,WIGHT ,MONSTER>>
				     <START-WIGHT>
				     <RFATAL>)>
			      <TELL CTHE ,WIGHT 
				    " leaps into your path and snarls." CR>
			      <RFATAL>)>
		       <RFALSE>)
		      (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <COND (<NOT <IS? ,CABIN-DOOR ,OPENED>>
			      <RFALSE>)
			     (<AND <T? .W>
				   <NOT <IS? .W ,SLEEPING>>>
			      <SNARLS>)
			     (T
			      <TELL ,CYOU>)>
		       <DEQUEUE ,I-WIGHT>
		       <TELL "retreat into the shelter of " 
			     THE ,CABIN>
		       <COND (<T? ,LAVA-TIMER>
			      <PRINT 
", a cascade of lava hot on your heels">)>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (<NOT <EQUAL? ,P-WALK-DIR ,P?EAST>>
		       <RFALSE>)
		      (<AND <T? .W>
			    <NOT <IS? ,WIGHT ,SLEEPING>>>
		       <SNARLS>)
		      (T
		       <TELL ,CYOU>)>
		<DEQUEUE ,I-WIGHT>
		<TELL "stumble down " THE ,TRAIL>
		<COND (<T? ,LAVA-TIMER>
		       <PRINT ", a cascade of lava hot on your heels">
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<BYE-BFLY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SNARLS ()
	 <TELL CTHE ,WIGHT " snarls a threat as you ">
	 <RTRUE>>

<OBJECT IN-CABIN
	(LOC ROOMS)
	(DESC "Laboratory")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH <THRU CABIN-DOOR ON-TRAIL>)
	(OUT <THRU CABIN-DOOR ON-TRAIL>)
	(IN <SORRY "You're in as far as you can go.">)
	(GLOBAL CABIN CABIN-DOOR)
	(FNUM OTHRIFF)
	(ACTION IN-CABIN-F)>

<ROUTINE IN-CABIN-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Whoever works in this isolated cabin ought to consider the services of a maid nymph. Retorts, alembics and other dubious " 'CHEMS " are spilled across " 
THE ,BENCH " in the center of the room">
		<MAKE ,CHEMS ,NODESC>
		<COND (<SEE-ANYTHING-IN? ,BENCH>
		       <TELL ". You also see ">
		       <CONTENTS ,BENCH>
		       <TELL " lying amid the mess">)>
		<UNMAKE ,CHEMS ,NODESC>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>  

<OBJECT ON-PEAK
	(LOC ROOMS)
	(DESC "Peak")
	(FLAGS LIGHTED LOCATION)
	(EAST <TO ON-TRAIL>)
	(DOWN <TO ON-TRAIL>)
	(UP <SORRY "You're up as high as you can go.">)
	(EXIT-STR "You'd tumble off the peak if you went that way.")
	(GLOBAL SNOW NULL TRAIL)
	(FNUM OTHRIFF)
	(ACTION ON-PEAK-F)>

<ROUTINE ON-PEAK-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL ,XTHE>
		<COND (<GLOBAL-IN? ,ON-PEAK ,LAVA>
		       <COND (<T? ,MAGMA-TIMER>
			      <GLOW-COLOR>)>
		       <TELL "flow of lava">)
		      (T
		       <TELL "upward trail">)>
		<TELL 
" ends here, at the brink of " A ,CRATER ". ">
		<COND (<IN? ,DOME ,ON-PEAK>
		       <TELL 
"Most of the opening is hidden beneath " A ,DOME
" of light, at least a hundred yards across and almost as high." CR>)
		      (<T? ,LAVA-TIMER>
		       <TELL 
"Molten lava is spewing out of the opening in a spectacular plume." CR>)
		      (T
		       <SAY-STEAM>)>
		<MENTION-GLYPH?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		       <SETG P-WALK-DIR ,P?EAST>)>
		<COND (<EQUAL? ,P-WALK-DIR ,P?EAST>
		       <COND (<T? ,LAVA-TIMER>
			      <TELL 
"An onrushing tide of red-hot magma encourages your descent." CR>
			      <RTRUE>)>
		       <TELL "You stumble down the steep trail">
		       <BYE-BFLY>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE SAY-STEAM ()
	 <TELL "Billowing clouds of steam obscure " THE ,CRATER
	       "'s interior." CR>
	 <RTRUE>>

<OBJECT AT-LEDGE
	(LOC ROOMS)
	(DESC "Ledge")
	(FLAGS LIGHTED LOCATION)
	(SW <TO COVESIDE 3>)
	(WEST <SORRY "Sheer cliff walls block your path.">)
	(NW <TO AT-BRINE 3>)
	(EXIT-STR "You'd plummet into the sea if you went that way.")
	(THINGS (SHORE ROAD HERE-F)
	 	(ROCKY LEDGE HERE-F))
	(FNUM OSHORE)
	(GLOBAL GREAT-SEA NULL)
	(ACTION AT-LEDGE-F)>

<ROUTINE AT-LEDGE-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"This narrow path curves along a rocky ledge overlooking the sea. You ">
		<COND (<IS? ,CREVICE ,NODESC>
		       <TELL "press your back against ">
		       <PRINT "the sheer cliff wall">
		       <TELL ", trying">)
		      (T
		       <TELL "try">)>
		<TELL 
" not to hear the waves crashing on the rocks, far below">
		<COND (<NOT <IS? ,CREVICE ,NODESC>>
		       <SETG P-IT-OBJECT ,CREVICE>
		       <TELL ,PTAB CA ,CREVICE " has been blasted into ">
		       <PRINT "the sheer cliff wall">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<NOT <IS? ,CREVICE ,NODESC>>
		       <SETG P-IT-OBJECT ,CREVICE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT TOWER-BASE
	(LOC ROOMS)
	(DESC "Lighthouse")
	(FLAGS LIGHTED LOCATION)
	(EAST <SORRY "Sheer cliff walls block your path.">)
	(EXIT-STR "Sheer cliff walls block your path.")
	(UP <PER TOWER-BASE-UP 1>)
	(FNUM OSHORE)
	(GLOBAL TOWER TOWER-STEPS CREVICE)
	(ACTION TOWER-BASE-F)>

<ROUTINE TOWER-BASE-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"An ancient " 'TOWER " stands upon this secret plateau, looming in dark silhouette against the sky. Crumbled steps lead up into its shadowy interior." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT AT-BRINE
	(LOC ROOMS)
	(DESC "Tidal Flats")
	(FLAGS LIGHTED LOCATION)
	(NORTH <SORRY "You'd get soaked if you went that way.">)
	(NE <TO IN-ACCARDI>)
	(EAST <SORRY "You'd get soaked if you went that way.">)
	(SE <TO AT-LEDGE 3>)
	(NW <TO AT-BROOK 3>)
	(ODOR BRINE)
	(BELOW BRINE)
	(EXIT-STR "Sheer cliff walls block your path.")
	(THINGS (SHORE ROAD HERE-F))
	(FNUM OSHORE)
	(GLOBAL GREAT-SEA ACCARDI BRIDGE BROOK)
	(ACTION AT-BRINE-F)>

<ROUTINE AT-BRINE-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<PRINT "The ocean smell is strong">
		<TELL 
" here, where a nameless brook meets the tidal flats of the Great Sea. One road follows the water inland; another spans a bridge to the northeast."  CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT AT-BROOK
	(LOC ROOMS)
	(DESC "Babbling Brook")
	(FLAGS LIGHTED LOCATION)
	(NORTH <SORRY "You'd get soaked if you went that way.">)
	(NE <SORRY "You'd get soaked if you went that way.">)
	(SE <TO AT-BRINE 3>)
	(WEST <PER AT-BROOK-WEST 9>)
	(NW <SORRY "You'd get soaked if you went that way.">)
	(EXIT-STR "A thick forest blocks your path.")
	(THINGS (<> PATH HERE-F)
	        (<> FOOTPATH HERE-F))
	(FNUM OACCARDI)
	(GLOBAL BROOK)
	(ACTION AT-BROOK-F)>

<ROUTINE AT-BROOK-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A footpath emerges from the shadow of a forbidding forest, curving southwest along the edge of a brook." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-ACCARDI
	(LOC ROOMS)
	(DESC "Accardi-by-the-Sea")
	(FLAGS LIGHTED LOCATION)
	(EAST <TO AT-GATE>)
	(WEST <THRU WEAPON-DOOR IN-WEAPON>)
        (IN <THRU WEAPON-DOOR IN-WEAPON>)
	(SW <TO AT-BRINE>)
	(FNUM OACCARDI)
	(GLOBAL GREAT-SEA ACCARDI GUILD-HALL WEAPON-DOOR WEAPON-SHOP
	 	BRIDGE)
	(ACTION IN-ACCARDI-F)>

<ROUTINE IN-ACCARDI-F ("OPT" (CONTEXT <>) "AUX" OBJ)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Home of the most famous of all Enchanters' Guilds, Accardi is usually crowded with autograph seekers and hopeful young apprentices. But the crooked streets are oddly quiet today" 
,PTAB CA ,WEAPON-SHOP " stands near " THE ,BRIDGE " leading out of town">
		<COND (<IS? ,WEAPON-DOOR ,OPENED>
		       <TELL ". Its " 'WEAPON-DOOR " is wide open">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-WEAPON
	(LOC ROOMS)
	(DESC "Weapon Shop")
	(FLAGS LIGHTED LOCATION INDOORS)
	(EAST <THRU WEAPON-DOOR IN-ACCARDI>)
	(OUT <THRU WEAPON-DOOR IN-ACCARDI>)
	(NORTH <PER ENTER-CURTAIN>)
	(IN <PER ENTER-CURTAIN>)
	(THIS-CASE WCASE)
	(FNUM OACCARDI)
	(GLOBAL WEAPON-DOOR WEAPON-SHOP ACCARDI)
	(ACTION IN-WEAPON-F)>

<ROUTINE IN-WEAPON-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Lethal instruments of iron and steel crowd every inch of this tiny establishment. The gleam of polished metal makes your fist clench with expensive fantasies of aggression" ,PTAB "Your attention comes to rest on a ">
		<SHOP-DOOR ,WEAPON-DOOR>
		<LOOK-ON-CASE ,ON-WCASE>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<GET-OWOMAN-AND-CURTAIN>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT AT-GATE
	(LOC ROOMS)
	(DESC "Outside Guild Hall")
	(FLAGS LIGHTED LOCATION)
	(NORTH <TO IN-HALL>)
	(IN <TO IN-HALL>)
	(WEST <TO IN-ACCARDI>)
	(FNUM OACCARDI)
	(GLOBAL GUILD-HALL ACCARDI NYMPH)
	(ACTION AT-GATE-F)>

<ROUTINE NYMPH-SAYS ()
	 <TELL 
"ear. \"There's no one here right now,\" she squeaks, \"so you'd better not">
	 <RTRUE>>

<ROUTINE AT-GATE-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Before you stands the headquarters of The Accardi Chapter of the Guild of Enchanters, better known as \"The Circle.\" Its legendary membership and mighty deeds need no introduction." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IN? ,GRINDER ,AT-GATE>
		       <SEE-GRINDER>
		       <TELL ,TAB "\"Welcome back,\" coos " THE ,GRINDER
			     " with an evil grin." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<ZERO? ,P-WALK-DIR>
		       <RFALSE>)
		      (<IN? ,GRINDER ,AT-GATE>
		       <COND (<EQUAL? ,P-WALK-DIR ,P?WEST>
			      <DEQUEUE ,I-GRINDER>
			      <TELL
"\"Coward!\" taunts " THE ,GRINDER " as you duck out of range." CR>
			      <RTRUE>)>
		       <TELL CTHE ,GRINDER 
			     " steps into your path, laughing." CR>
		       <RFATAL>)
		      (<EQUAL? ,P-WALK-DIR ,P?NORTH ,P?IN>
		       <COND (<NOT <IS? ,NYMPH ,LIVING>>
			      <TELL 
"You step unchallenged through the open gate." CR>
			      <RTRUE>)
			     (<IS? ,GRINDER ,NODESC>
			      <UNMAKE ,GRINDER ,NODESC>
			      <SETG GRTIMER 4>
			      <QUEUE ,I-GRINDER-APPEARS>)>
		       
		       <COND (<IS? ,GUILD-HALL ,TOUCHED>
			      <TELL CTHE ,NYMPH 
" promptly reappears. \"They're not back yet. Go away">)
			     (T
			      <TELL "A tiny " 'NYMPH 
" appears, floating in the air beside your ">
			      <NYMPH-SAYS>
			      <TELL " come in">)>
		       <MAKE ,GUILD-HALL ,TOUCHED>
		       <PRINT ". Bye!\"|  She disappears with a wink.|">
		       <RFATAL>)
		      (<EQUAL? ,P-WALK-DIR ,P?WEST>
		       <COND (<OR <IS? ,GRINDER ,NODESC>
				  <T? ,GRTIMER>>
			      <TELL "A">
			      <COND (<EQUAL? ,GRTIMER 1 2>
				     <TELL "nother">)>
			      <PRINT " noise makes you hesitate.|">
			      <COND (<IS? ,GRINDER ,NODESC>
				     <UNMAKE ,GRINDER ,NODESC>
				     <SETG GRTIMER 3>
				     <QUEUE ,I-GRINDER-APPEARS>)>
			      <I-GRINDER-APPEARS>
			      <RFATAL>)>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-HALL
	(LOC ROOMS)
	(DESC "Lobby")
	(FLAGS LIGHTED LOCATION INDOORS)
	(SOUTH <TO AT-GATE>)
	(OUT <TO AT-GATE>)
	(FNUM OACCARDI)
	(GLOBAL ACCARDI GUILD-HALL NYMPH)
	(ACTION IN-HALL-F)>

<VOC "DISPEL" NOUN>
<VOC "DISPEL" ADJ>

<ROUTINE IN-HALL-F ("OPT" (CONTEXT <>) "AUX" OBJ)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,CEILING 
" of this once-splendid chamber has collapsed, burying doors and stairwells under tons of debris. The elliptical scorches on the walls are unmistakable, even to a novice; but why would anyone fire magic missiles here, in the very midst of the Circle?" CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<NOT <IS? ,IN-HALL ,SEEN>>
		       <MAKE ,IN-HALL ,SEEN>
		       <SET OBJ <PICK-ONE ,WAND-LIST>>
		       <UNMAKE .OBJ ,NODESC>
		       <PUTP .OBJ ,P?ACTION ,DISPEL-WAND-F>
		       <PUTP .OBJ ,P?SDESC ,DESCRIBE-DISPEL-WAND>
		       <PUT <GETPT .OBJ ,P?SYNONYM> 0 ,W?DISPEL>
		       <PUT <GETPT .OBJ ,P?ADJECTIVE> 0 ,W?DISPEL>
		       <PUTP .OBJ ,P?DESCFCN ,DESCRIBE-HALL-WAND>
		       <MOVE .OBJ ,IN-HALL>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL1A
	(LOC ROOMS)
	(DESC "Lighthouse, 1st Level")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SAY-TO TOWER-BASE "You hurry down the steps.">)
	(GLOBAL TOWER TOWER-STEPS DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL1A-F)>

<ROUTINE LEVEL1A-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A welcome patch of daylight is visible at the bottom of the stairway." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?DOWN ,P?OUT>
		     ; <COND (<IS? ,DORN ,LIVING>
			      <DEQUEUE ,I-DISTANT-DORN>)>
		       <COND (<T? ,AUTO>
			      <BMODE-OFF>)>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE TOWER-BASE-UP ("AUX" RM X)
	 <COND (<NOT <IS? ,LEVEL1A ,TOUCHED>>
		<MAKE ,LEVEL1A ,TOUCHED>
		<SCRAMBLE ,TOWER1-ROOMS>
		<PROG ()
		   <SET RM <GETB ,TOWER1-ROOMS <RANDOM 4>>>
		   <COND (<EQUAL? .RM ,LEVEL1A>
			  <AGAIN>)>>
		<NEXT-WAND? ,DESCRIBE-TOWER-WAND .RM>)>
       ; <COND (<IS? ,DORN ,LIVING>
		<MAKE ,DORN ,SEEN>
		<QUEUE ,I-DISTANT-DORN>)>
	 <COND (<IS? ,SPIDER ,NODESC>
		<UNMAKE ,SPIDER ,NODESC>
		<QUEUE ,I-SPIDER>)>
	 <YOU-CLIMB-UP>
	 <RETURN ,LEVEL1A>>

<ROUTINE LEVEL1-UP ("AUX" RM)
	 <COND (<NOT <IS? ,LEVEL2A ,TOUCHED>>
		<MAKE ,LEVEL2A ,TOUCHED>
		<NEW-EXIT? ,LEVEL2A ,P?DOWN %<+ ,SCONNECT 1 ,MARKBIT>
			   ,HERE>		
		<SCRAMBLE ,TOWER2-ROOMS>
		<PROG ()
	           <SET RM <GETB ,TOWER2-ROOMS <RANDOM 4>>>
		   <COND (<EQUAL? .RM ,LEVEL2A>
			  <AGAIN>)>>
		<MOVE ,CARD .RM>)>
	 <COND (<IS? ,SLUG ,NODESC>
		<UNMAKE ,SLUG ,NODESC>
		<QUEUE ,I-SLUG>)>
	 <YOU-CLIMB-UP>
	 <RETURN ,LEVEL2A>>

<ROUTINE LEVEL2-UP ("AUX" RM X)
	 <COND (<NOT <IS? ,LEVEL3A ,TOUCHED>>
		<MAKE ,LEVEL3A ,TOUCHED>
		<NEW-EXIT? ,LEVEL3A ,P?DOWN %<+ ,SCONNECT 1 ,MARKBIT>
			   ,HERE>
		<SCRAMBLE ,TOWER3-ROOMS>
						
		<PROG ()
		   <SET RM <GETB ,TOWER3-ROOMS <RANDOM 4>>>
		   <COND (<EQUAL? .RM ,LEVEL3A>
			  <AGAIN>)>>
		<NEXT-SCROLL? ,DESCRIBE-TOWER-SCROLL .RM>)>		
	 <YOU-CLIMB-UP>
	 <RETURN ,LEVEL3A>>

<ROUTINE LEVEL3-UP ()
	 <COND (<NOT <IS? ,TOWER-TOP ,TOUCHED>>
		<MAKE ,TOWER-TOP ,TOUCHED>
		<NEW-EXIT? ,TOWER-TOP ,P?DOWN %<+ ,SCONNECT 1 ,MARKBIT>
			   ,HERE>
		<NEW-EXIT? ,HERE ,P?UP %<+ ,CONNECT 1 ,MARKBIT> ,TOWER-TOP>)>
	 <YOU-CLIMB-UP>
	 <RETURN ,TOWER-TOP>>

<ROUTINE MENTION-TOWER-STEPS? ()
	 <COND (<GLOBAL-IN? ,HERE ,TOWER-STEPS>
		<TELL ". A narrow flight of steps winds upward">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE SAY-EXIT ("AUX" TBL DIR XDIR)
	 <SET XDIR <- <RANDOM 8> 1>>
	 <SET DIR .XDIR>
	 <REPEAT ()
	    <COND (<IGRTR? DIR ,I-NW>
		   <SET DIR ,I-NORTH>)>
	    <SET TBL <GETP ,HERE <GETB ,PDIR-LIST .DIR>>>
	    <COND (<ZERO? .TBL>)
		  (<EQUAL? <MSB <GET .TBL ,XTYPE>> ,CONNECT>
		   <TELL B <GET ,DIR-NAMES .DIR>>
		   <RFALSE>)>>>

<OBJECT LEVEL1B
	(LOC ROOMS)
	(DESC "Crumbling Walls")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SORRY "There aren't any stairs leading down from here.">)
	(GLOBAL TOWER NULL DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL1B-F)>

<ROUTINE LEVEL1B-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Uneven rays of daylight seep in through walls crumbling with age">
		<MENTION-TOWER-STEPS?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<LAST-ROOM-IN? ,TOWER1-ROOMS>
		       <NEW-EXIT? ,LEVEL1B ,P?UP %<+ ,FCONNECT 1 ,MARKBIT>
				  ,LEVEL1-UP>
		       <REPLACE-GLOBAL? ,LEVEL1B ,NULL ,TOWER-STEPS>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL1C
	(LOC ROOMS)
	(DESC "Room of Gloom")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SORRY "There aren't any stairs leading down from here.">)
	(GLOBAL TOWER NULL DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL1C-F)>

<ROUTINE LEVEL1C-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The dusty light streaming in from the ">
		<SAY-EXIT>
		<TELL " only deepens the gloom of this forgotten chamber">
		<MENTION-TOWER-STEPS?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<LAST-ROOM-IN? ,TOWER1-ROOMS>
		       <NEW-EXIT? ,LEVEL1C ,P?UP %<+ ,FCONNECT 1 ,MARKBIT>
				  ,LEVEL1-UP>
		       <REPLACE-GLOBAL? ,LEVEL1C ,NULL ,TOWER-STEPS>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL1D
	(LOC ROOMS)
	(DESC "Creaky Corner")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SORRY "There aren't any stairs leading down from here.">)
	(GLOBAL TOWER NULL DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL1D-F)>

<ROUTINE LEVEL1D-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Rotten floorboards creak with age as you tiptoe across them">
		<MENTION-TOWER-STEPS?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<LAST-ROOM-IN? ,TOWER1-ROOMS>
		       <NEW-EXIT? ,LEVEL1D ,P?UP %<+ ,FCONNECT 1 ,MARKBIT>
				  ,LEVEL1-UP>
		       <REPLACE-GLOBAL? ,LEVEL1D ,NULL ,TOWER-STEPS>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL2A
	(LOC ROOMS)
	(DESC "Lighthouse, 2nd Level")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SAY-TO LEVEL2A "You descend the steps.">)
	(GLOBAL TOWER TOWER-STEPS DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL2A-F)>

<ROUTINE LEVEL2A-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The steps winding downward are choked in a tangle of shadows and useless debris." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL2B
	(LOC ROOMS)
	(DESC "Twilit Room")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SORRY "There aren't any stairs leading down from here.">)
	(GLOBAL TOWER NULL DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL2B-F)>

<ROUTINE LEVEL2B-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The faint smudge of light from the ">
		<SAY-EXIT>
		<TELL " is barely enough to light your way">
		<MENTION-TOWER-STEPS?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<LAST-ROOM-IN? ,TOWER2-ROOMS>
		       <NEW-EXIT? ,LEVEL2B ,P?UP %<+ ,FCONNECT 1 ,MARKBIT>
				  ,LEVEL2-UP>
		       <REPLACE-GLOBAL? ,LEVEL2B ,NULL ,TOWER-STEPS>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL2C
	(LOC ROOMS)
	(DESC "Saggy Ceiling")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SORRY "There aren't any stairs leading down from here.">)
	(GLOBAL TOWER NULL DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL2C-F)>

<ROUTINE LEVEL2C-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You duck low to avoid the sagging, wormy timbers overhead">
		<MENTION-TOWER-STEPS?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<LAST-ROOM-IN? ,TOWER2-ROOMS>
		       <NEW-EXIT? ,LEVEL2C ,P?UP %<+ ,FCONNECT 1 ,MARKBIT>
				  ,LEVEL2-UP>
		       <REPLACE-GLOBAL? ,LEVEL2C ,NULL ,TOWER-STEPS>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-END>
		<COND (<PROB 10>
		       <TELL ,TAB 
"You bang your head on " THE ,CEILING ". Oof!" CR>
		       <UPDATE-STAT -4>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL2D
	(LOC ROOMS)
	(DESC "Chamber of Light")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SORRY "There aren't any stairs leading down from here.">)
	(GLOBAL TOWER NULL DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL2D-F)>

<ROUTINE LEVEL2D-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Planes of daylight slice the air through cracks in the walls and ceiling">
		<MENTION-TOWER-STEPS?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<LAST-ROOM-IN? ,TOWER2-ROOMS>
		       <NEW-EXIT? ,LEVEL2D ,P?UP %<+ ,FCONNECT 1 ,MARKBIT>
				  ,LEVEL2-UP>
		       <REPLACE-GLOBAL? ,LEVEL2D ,NULL ,TOWER-STEPS>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL3A
	(LOC ROOMS)
	(DESC "Lighthouse, 3rd Level")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SAY-TO LEVEL3A "You climb down the steps.">)
	(GLOBAL TOWER TOWER-STEPS DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL3A-F)>

<ROUTINE LEVEL3A-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Deep, inky shadows obscure the stairwell winding downward." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL3B
	(LOC ROOMS)
	(DESC "Dusty Corner")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SORRY "There aren't any stairs leading down from here.">)
	(GLOBAL TOWER NULL DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL3B-F)>

<ROUTINE LEVEL3B-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The sound of your footsteps is dampened by the fine dust coating every inch of this dimly lit chamber">
		<MENTION-TOWER-STEPS?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<LAST-ROOM-IN? ,TOWER3-ROOMS>
		       <NEW-EXIT? ,LEVEL3B ,P?UP %<+ ,FCONNECT 1 ,MARKBIT>
				  ,LEVEL3-UP>
		       <REPLACE-GLOBAL? ,LEVEL3B ,NULL ,TOWER-STEPS>)>
		<COND (<IN? ,DUST ,LEVEL3B>
		       <SETG P-IT-OBJECT ,DUST>
		       <SETG P-THEM-OBJECT ,DUST>
		       <COND (<G? ,BUNNIES 89>
			      <TELL 
"A cloud of dust billows up as you enter!" CR>
			      <COND (<T? ,VERBOSITY>
				     <CRLF>)>)>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IN? ,DUST ,HERE>
		       <SETG LAST-MONSTER ,DUST>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR <> ,P?UP ,P?DOWN>)
		      (<IN? ,DUST ,HERE>
		       <UNMAKE ,DUST ,SEEN>
		       <COND (<G? ,BUNNIES 89>
			      <PRINT "Your path is hopelessly blocked by ">
			      <TELL 'DUST ,PERIOD>
			      <RFATAL>)>
		       <TELL "You edge your way past " THE ,DUST ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>



<OBJECT LEVEL3C
	(LOC ROOMS)
	(DESC "Dimly-Lit Room")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SORRY "There aren't any stairs leading down from here.">)
	(GLOBAL TOWER NULL DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL3C-F)>

<ROUTINE LEVEL3C-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Streaks of light from the ">
		<SAY-EXIT>
		<TELL " exit fall in jagged patches across " THE ,FLOOR>
		<MENTION-TOWER-STEPS?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<LAST-ROOM-IN? ,TOWER3-ROOMS>
		       <NEW-EXIT? ,LEVEL3C ,P?UP %<+ ,FCONNECT 1 ,MARKBIT>
				  ,LEVEL3-UP>
		       <REPLACE-GLOBAL? ,LEVEL3C ,NULL ,TOWER-STEPS>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVEL3D
	(LOC ROOMS)
	(DESC "Saggy Floor")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP <SORRY "There aren't any stairs leading up from here.">)
	(DOWN <SORRY "There aren't any stairs leading down from here.">)
	(GLOBAL TOWER NULL DEBRIS)
	(DNUM 0)
	(FNUM OSHORE)
	(ACTION LEVEL3D-F)>

<ROUTINE LEVEL3D-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL ,YOU-HEAR 
		      "the creak of sagging timber as " THE ,FLOOR
		      " struggles to bear your weight">
		<MENTION-TOWER-STEPS?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<LAST-ROOM-IN? ,TOWER3-ROOMS>
		       <NEW-EXIT? ,LEVEL3D ,P?UP %<+ ,FCONNECT 1 ,MARKBIT>
				  ,LEVEL3-UP>
		       <REPLACE-GLOBAL? ,LEVEL3D ,NULL ,TOWER-STEPS>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT TOWER-TOP
	(LOC ROOMS)
	(DESC "Lamp Room")
	(FLAGS LIGHTED LOCATION INDOORS)
	(UP <SORRY "You're up as high as you can go.">)
	(DOWN <SAY-TO TOWER-TOP "You scramble down the steps.">)
	(FNUM OSHORE)
	(GLOBAL TOWER TOWER-STEPS DEBRIS)
	(ACTION TOWER-TOP-F)>

<ROUTINE TOWER-TOP-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Nothing remains of the stormproof panes that once enclosed this circular chamber on every side. The floor is littered with glass and debris">
		<COND (<SEE-ANYTHING-IN? ,LAMPHOUSE>
		       <TELL ", in which you also see ">
		       <CONTENTS ,LAMPHOUSE>)>
		<TELL ,PTAB "A flight of steps descends into shadow." CR>  
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IN? ,DORN ,TOWER-TOP>
		       <SEE-CHARACTER ,DORN>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT AT-DOCK
	 (LOC ROOMS)
	 (DESC "Skyway Entrance")
	 (FLAGS LIGHTED LOCATION)
	 (EAST <TO IN-PORT>)
	 (EXIT-STR "Dense jungle blocks your path.")
	 (SEE-ALL JUNGLE)
	 (IN <PER ENTER-GONDOLA>)
	 (GLOBAL NULL DOCK JUNGLE)
	 (FNUM OMIZNIA)
	 (ACTION AT-DOCK-F)>

<ROUTINE ENTER-GONDOLA ()
	 <COND (<NOT <IN? ,GONDOLA ,AT-DOCK>>
		<TELL CTHE ,DGONDOLA " isn't back yet." CR>
		<RFALSE>)>
	 <PERFORM ,V?ENTER ,GONDOLA>
	 <RFALSE>>

<ROUTINE AT-DOCK-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Aggressive ad campaigns and the deregulation of ZIFMIA spells have made Miznia's Jungle Skyway the fifth biggest tourist attraction in the Southlands. Passengers ">
		<COND (<IN? ,GONDOLA ,HERE>
		       <TELL "are ">
		       <COND (<L? ,GON 2>
			      <TELL "streaming out of ">)
			     (T
			      <TELL "crowding for a space in ">)>
		       <TELL THE ,GONDOLA>
		       <COND (<NOT <IN? ,PLAYER ,GONDOLA>>
			      <TELL " docked nearby">)>
		       <TELL ,PERIOD>
		       <RTRUE>)> 
		<TELL "crowd around the entry gate, ">
		<COND (<EQUAL? ,GON 4>
		       <TELL "watching a " 'GONDOLA
			     " glide away into the haze." CR>
		       <RTRUE>)>
		<TELL "waiting for the ">
		<COND (<EQUAL? ,GON 14>
		       <TELL 'GONDOLA " now ">
		       <PRINT "approaching from the south.|">
		       <RTRUE>)>
		<TELL "next " 'GONDOLA " to appear." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<NOT <IS? ,DGONDOLA ,SEEN>>
		       <MAKE ,DGONDOLA ,SEEN>
		       <QUEUE ,I-GONDOLA>)>
		<COND (<IN? ,GONDOLA ,AT-DOCK>
		       <SETG P-IT-OBJECT ,GONDOLA>
		       <SEE-CHARACTER ,CONDUCTOR>)>
		<MOVE ,PASSENGERS ,AT-DOCK>
		<SETG P-THEM-OBJECT ,PASSENGERS>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<MOVE ,PASSENGERS ,GONDOLA>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT NW-UNDER
	(LOC ROOMS)
	(DESC "Support Tower")
	(FLAGS LIGHTED LOCATION)
	(SE <PER NW-UNDER-SE 1>)
	(UP <TO NW-SUPPORT>)
	(DOWN <SORRY "You're already at the bottom of the ladder.">)
	(EXIT-STR "Dense jungle blocks your path.")
	(OVERHEAD SUPPORT)
	(SEE-ALL JUNGLE)
	(ODOR JUNGLE)
	(HEAR JUNGLE)
	(GLOBAL NULL SUPPORT JUNGLE)
	(FNUM OJUNGLE)
	(ACTION UNDERS-F)>

<OBJECT SW-UNDER
	(LOC ROOMS)
	(DESC "Support Tower")
	(FLAGS LIGHTED LOCATION)
	(NE <PER SW-UNDER-NE 1>)
	(UP <TO SW-SUPPORT>)
	(DOWN <SORRY "You're already at the bottom of the ladder.">)
	(EXIT-STR "Dense jungle blocks your path.")
	(SEE-ALL JUNGLE)
	(OVERHEAD SUPPORT)
	(ODOR JUNGLE)
	(HEAR JUNGLE)
	(GLOBAL NULL SUPPORT JUNGLE)
	(FNUM OJUNGLE)
	(ACTION UNDERS-F)>

<OBJECT SE-UNDER
	(LOC ROOMS)
	(DESC "Support Tower")
	(FLAGS LIGHTED LOCATION)
	(NW <PER SE-UNDER-NW 1>)
	(UP <TO SE-SUPPORT>)
	(DOWN <SORRY "You're already at the bottom of the ladder.">)
	(EXIT-STR "Dense jungle blocks your path.")
	(SEE-ALL JUNGLE)
	(OVERHEAD SUPPORT)
	(ODOR JUNGLE)
	(HEAR JUNGLE)
	(GLOBAL NULL SUPPORT JUNGLE)
	(FNUM OJUNGLE)
	(ACTION UNDERS-F)>

<ROUTINE UNDERS-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Steel girders rise high above the treetops of the surrounding jungle">
		<COND (<GLOBAL-IN? ,HERE ,DGONDOLA>
		       <TELL ". Peering upward, you notice " A ,DGONDOLA
			     " gliding overhead">)>
		<TELL ,PTAB "A skinny ladder leads upward." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?UP>
		       <COND (<T? ,AUTO>
			      <BMODE-OFF>)>
		       <TELL "You scoot up the ladder." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT NW-SUPPORT
	(LOC ROOMS)
	(DESC "top")
	(SDESC DESCRIBE-TOPS)
	(FLAGS LIGHTED LOCATION)
	(DOWN <TO NW-UNDER>)
	(UP <SORRY "You're up as high as you can go.">)
	(IN <PER SUPPORTS-IN>)
	(EXIT-STR "You'd fall off the platform if you went that way.")
	(SEE-ALL JUNGLE)
	(ODOR JUNGLE)
	(HEAR JUNGLE)
	(GLOBAL NULL SUPPORT PLATFORM JUNGLE)
	(FNUM OJUNGLE)
	(ACTION TOPS-F)>

<OBJECT SW-SUPPORT
	(LOC ROOMS)
	(DESC "top")
	(SDESC DESCRIBE-TOPS)
	(FLAGS LIGHTED LOCATION)
	(DOWN <TO SW-UNDER>)
	(UP <SORRY "You're up as high as you can go.">)
	(IN <PER SUPPORTS-IN>)
	(EXIT-STR "You'd fall off the platform if you went that way.")
	(SEE-ALL JUNGLE)
	(ODOR JUNGLE)
	(HEAR JUNGLE)
	(GLOBAL NULL SUPPORT PLATFORM JUNGLE)
	(FNUM OJUNGLE)
	(ACTION TOPS-F)>

<OBJECT SE-SUPPORT
	(LOC ROOMS)
	(DESC "top")
	(SDESC DESCRIBE-TOPS)
	(FLAGS LIGHTED LOCATION)
	(DOWN <TO SE-UNDER>)
	(UP <SORRY "You're up as high as you can go.">)
	(IN <PER SUPPORTS-IN>)
	(EXIT-STR "You'd fall off the platform if you went that way.")
	(SEE-ALL JUNGLE)
	(ODOR JUNGLE)
	(HEAR JUNGLE)
	(GLOBAL NULL SUPPORT PLATFORM JUNGLE)
	(FNUM OJUNGLE)
	(ACTION TOPS-F)>

<ROUTINE SUPPORTS-IN ()
	 <COND (<IN? ,PLAYER ,GONDOLA>
		<PERFORM ,V?EXIT ,GONDOLA>
		<RFALSE>)
	       (<IN? ,GONDOLA ,HERE>
		<PERFORM ,V?ENTER ,GONDOLA>
		<RFALSE>)
	       (<GLOBAL-IN? ,HERE ,DGONDOLA>
		<PERFORM ,V?ENTER ,DGONDOLA>
		<RFALSE>)>
	 <V-WALK-AROUND>
	 <RFALSE>>

<ROUTINE DESCRIBE-TOPS (OBJ)
	 <COND (<IN? ,PLAYER ,GONDOLA>
		<TELL "Beside Tower">
		<RTRUE>)>
	 <TELL "Maintenance Platform">
	 <RTRUE>>

<ROUTINE TOPS-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<COND (<IN? ,PLAYER ,GONDOLA>
		       <TELL ,CYOUR 'GONDOLA
" is passing a few feet away from a Skyway support tower. A small maintenance " 'PLATFORM " is enclosed within the steel girders; beside it, you notice a skinny ladder leading down towards the treetops." CR>
		       <RTRUE>)>
		<TELL 
"A spiderweb of structural steel rises above the treetops, tapering up to this narrow vantage near the top. The topmost rungs of a skinny ladder are within your reach." CR>
		<COND (<OR <IN? ,GONDOLA ,HERE>
			   <GLOBAL-IN? ,HERE ,DGONDOLA>>
		       <TELL ,TAB CA ,DGONDOLA " is gliding ">
		       <COND (<IN? ,GONDOLA ,HERE>
			      <TELL "close by ">)
			     (<EQUAL? ,GON 11 8 5>
			      <TELL "towards ">)
			     (T
			      <TELL "away from ">)>
		       <TELL THE ,PLATFORM ,PERIOD>)>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<NOT <IS? ,DGONDOLA ,SEEN>>
		       <MAKE ,DGONDOLA ,SEEN>
		       <QUEUE ,I-GONDOLA>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		       <COND (<IN? ,PLAYER ,GONDOLA>
			      <YOUD-HAVE-TO "get out of" ,GONDOLA>
			      <RFATAL>)>
		       <TELL "You scramble down the ladder." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT JUN0
	(LOC ROOMS)
	(DESC "Quicksand")
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DOWN <PER ENTER-QUICKSAND>)
	(IN <PER ENTER-QUICKSAND>)
	(EXIT-STR "Dense jungle blocks your path.")
	(DNUM 0)
	(BELOW QUICKSAND)
	(SEE-ALL JUNGLE)
	(HEAR JUNGLE)
	(ODOR JUNGLE)
	(GLOBAL JUNGLE)
	(FNUM OJUNGLE)
	(ACTION JUN0-F)>

<ROUTINE JUN0-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A strip of dry path winds alongside a pool of " 'QUICKSAND>
		<COND (<SEE-ANYTHING-IN? ,QUICKSAND>
		       <TELL ". " ,YOU-SEE>
		       <CONTENTS ,QUICKSAND>
		       <TELL " stuck into the wet, gritty surface">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<IS? ,MAMA ,NODESC>
		       <UNMAKE ,MAMA ,NODESC>
		       <QUEUE ,I-BABY>
		       <QUEUE ,I-MAMA>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR <> ,P?UP>)
		      (<IN? ,BABY ,QUICKSAND>
		       <MAKE ,BABY ,SEEN>
		       <TELL CTHE ,BABY
" bellows mournfully as you walk away." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT WORM-ROOM
	(LOC ROOMS)
	(DESC "Fungus")
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP 0)
	(DOWN 0)
	(BELOW 0)
	(IN 0)
	(OUT 0)
	(OVERHEAD 0)
	(DNUM 0)
	(SEE-ALL JUNGLE)
	(HEAR JUNGLE)
	(ODOR JUNGLE)
	(GLOBAL JUNGLE)
	(EXIT-STR "Dense jungle blocks your path.")
	(FNUM OJUNGLE)
	(ACTION WORM-ROOM-F)>

<ROUTINE WORM-ROOM-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,GROUND
" here is concealed beneath a growth of fungus, green and squishy." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<NOT <IS? ,WORM ,MONSTER>>
		       <START-WORM "step past">
		       <RFATAL>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT JUN2
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP 0)
	(DOWN 0)
	(BELOW 0)
	(IN 0)
	(OUT 0)
	(OVERHEAD 0)
	(DNUM 0)
	(SEE-ALL JUNGLE)
	(HEAR JUNGLE)
	(ODOR JUNGLE)
	(GLOBAL JUNGLE)
	(EXIT-STR "Dense jungle blocks your path.")
	(FNUM OJUNGLE)
	(ACTION JUNGLE-ROOM-F)>

<OBJECT JUN3
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP 0)
	(DOWN 0)
	(BELOW 0)
	(IN 0)
	(OUT 0)
	(OVERHEAD 0)
	(DNUM 0)
	(FNUM OJUNGLE)
	(SEE-ALL JUNGLE)
	(HEAR JUNGLE)
	(ODOR JUNGLE)
	(GLOBAL JUNGLE)
	(EXIT-STR "Dense jungle blocks your path.")
	(ACTION JUNGLE-ROOM-F)>

<OBJECT JUN4
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP 0)
	(DOWN 0)
	(BELOW 0)
	(IN 0)
	(OUT 0)
	(OVERHEAD 0)
	(DNUM 0)
	(FNUM OJUNGLE)
	(SEE-ALL JUNGLE)
	(HEAR JUNGLE)
	(ODOR JUNGLE)
	(GLOBAL JUNGLE)
	(EXIT-STR "Dense jungle blocks your path.")
	(ACTION JUNGLE-ROOM-F)>

<OBJECT JUN5
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP 0)
	(DOWN 0)
	(BELOW 0)
	(IN 0)
	(OUT 0)
	(OVERHEAD 0)
	(DNUM 0)
	(FNUM OJUNGLE)
	(SEE-ALL JUNGLE)
	(HEAR JUNGLE)
	(ODOR JUNGLE)
	(GLOBAL JUNGLE)
	(EXIT-STR "Dense jungle blocks your path.")
	(ACTION JUNGLE-ROOM-F)>

<OBJECT JUN6
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(UP 0)
	(DOWN 0)
	(BELOW 0)
	(IN 0)
	(OUT 0)
	(OVERHEAD 0)
	(DNUM 0)
	(FNUM OJUNGLE)
	(SEE-ALL JUNGLE)
	(HEAR JUNGLE)
	(ODOR JUNGLE)
	(GLOBAL JUNGLE)
	(EXIT-STR "Dense jungle blocks your path.")
	(ACTION JUNGLE-ROOM-F)>

<ROUTINE JUNGLE-ROOM-F ("OPT" (CONTEXT <>) "AUX" TBL)
	 <COND (<NOT <EQUAL? .CONTEXT ,M-ENTERING>>
		<RFALSE>)
	       (<IS? ,HERE ,TOUCHED>
		<RFALSE>)
	       (<AND <NOT <IS? ,CROCO ,SEEN>>
		     <LAST-ROOM-IN? ,JUNGLE-ROOMS 3>>
		<MAKE ,CROCO ,SEEN>
		<PUTP ,HERE ,P?ACTION ,IDOL-ROOM-F>
		<PUTP ,HERE ,P?SDESC ,DESCRIBE-IDOL-ROOM>
		<MOVE ,CROCO ,HERE>
		<MOVE ,MAW ,HERE>
		<NEW-EXIT? ,HERE ,P?UP
		   %<+ ,FCONNECT 1 ,MARKBIT> ,ENTER-CROCO>
		<NEW-EXIT? ,HERE ,P?IN
		   %<+ ,FCONNECT 1 ,MARKBIT> ,ENTER-CROCO>
		<NEW-EXIT? ,HERE ,P?OUT 
		   %<+ ,FCONNECT 1 ,MARKBIT> ,EXIT-CROCO>
		<CLEAR-MAW-EXITS>
		<RFALSE>)
	       (T
		<SET TBL <PICK-ONE ,JUNGLE-DESCS>>
		<PUTP ,HERE ,P?SDESC <GET .TBL 0>>
		<PUTP ,HERE ,P?ACTION <GET .TBL 1>>
		<RFALSE>)>>

<ROUTINE CLEAR-MAW-EXITS ("AUX" X)
	 <SET X <LOC ,CROCO>>
	 <PUTP .X ,P?BELOW 0>
	 <PUTP .X ,P?OVERHEAD ,MAW>
	 <NEW-EXIT? .X ,P?DOWN ,SORRY-EXIT ,NOT-IN-MAW>
	 <RFALSE>>

<ROUTINE DESCRIBE-IDOL-ROOM (OBJ)
	 <TELL "Idol">
	 <RTRUE>>

<ROUTINE IDOL-ROOM-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A stone idol, carved in the likeness of a giant crocodile, stands in a clearing">
		<COND (<SEE-ANYTHING-IN? ,MAW>
		       <TELL ". " ,YOU-SEE>
		       <CONTENTS ,MAW>
		       <TELL " in its gaping maw">)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NOT-IN-MAW ()
	 <TELL "You're not in the maw." CR>
	 <RFALSE>>

<ROUTINE DESCRIBE-JD0 (OBJ)
	 <TELL "Underbrush">
	 <RTRUE>>

<ROUTINE JD0-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Unseen creatures scurry out of your path as you struggle through the damp underbrush." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<ROUTINE DESCRIBE-JD1 (OBJ)
	 <TELL "Birdcries">
	 <RTRUE>>

<ROUTINE JD1-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The unnerving cries of exotic birds echo in the treetops." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-JD2 (OBJ)
	 <TELL "Creepers">
	 <RTRUE>>

<ROUTINE JD2-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A slimy tangle of vines and creepers dangles high overhead, swinging to and fro in the humid breeze." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-JD3 (OBJ)
	 <TELL "Ferns">
	 <RTRUE>>

<ROUTINE JD3-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A natural canopy of ferns mutes the sunlight to a cool, emerald dusk." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT OVER-JUNGLE
	(LOC ROOMS)
	(DESC "Over Jungle")
	(FLAGS LIGHTED LOCATION)
	(SEE-ALL JUNGLE)
	(BELOW JUNGLE)
	(ODOR JUNGLE)
	(HEAR JUNGLE)
	(FNUM OJUNGLE)
	(EXIT-STR "You'd plummet to your death if you went that way.")
	(GLOBAL DOCK JUNGLE NULL)
	(ACTION OVER-JUNGLE-F)>

<ROUTINE OVER-JUNGLE-F ("OPT" (CONTEXT <>) "AUX" X Y)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SET X ,W?WEST>
		<COND (<EQUAL? ,GON 7 8>
		       <SET X ,W?SOUTH>)
		      (<EQUAL? ,GON 10 11>
		       <SET X ,W?EAST>)
		      (<EQUAL? ,GON 13 14>
		       <SET X ,W?NORTH>)>
		<TELL ,CYOUR 'GONDOLA " is gliding " B .X
", high over the lush jungles and sparkling rivers of Miznia. ">
		<COND (<EQUAL? ,GON 4>
		       <RECEDING ,DOCK>
		       <RTRUE>)
		      (<EQUAL? ,GON 5>
		       <EMERGING ,SUPPORT>
		       <RTRUE>)
		      (<EQUAL? ,GON 8 11>
		       <EMERGING ,SUPPORT "Another ">
		       <RTRUE>)
		      (<EQUAL? ,GON 14>
		       <EMERGING ,DOCK>
		       <RTRUE>)>
		<RECEDING ,SUPPORT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EMERGING (OBJ "OPT" X)
	 <COND (<ASSIGNED? X>
		<TELL "Another ">)
	       (T
		<TELL ,XTHE>)>
	 <TELL D .OBJ " is emerging from the haze ahead." CR>
	 <RTRUE>>

<ROUTINE RECEDING (OBJ)
	 <TELL CTHE .OBJ " is receding into the haze." CR>
	 <RTRUE>>

<OBJECT AT-FALLS
	(LOC ROOMS)
	(DESC "Waterfall")
        (FLAGS LIGHTED LOCATION)
	(NORTH <PER AT-FALLS-N 5>)
	(SW <TO IN-THRIFF>)
	(IN <PER ENTER-FALLS>)
	(ODOR JUNGLE)
	(HEAR WATERFALL)
	(GLOBAL JUNGLE NULL)
	(FNUM OJUNGLE)
	(THINGS (<> LEDGE USELESS))
	(ACTION AT-FALLS-F)>

<ROUTINE AT-FALLS-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A dazzling cascade roars down from a ledge overhead, fed by the snowy peaks rising to the south">
		<COND (<IS? ,IN-THRIFF ,MUNGED>
		       <TELL ". The trail leading " B ,W?SOUTHWEST
			     " is choked with " 'XTREES>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <COND (<T? ,AUTO>
			      <BMODE-OFF>)>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-PASTURE
	(LOC ROOMS)
	(DESC "Mountain Pasture")
	(FLAGS LIGHTED LOCATION)
	(SE <TO IN-THRIFF>)
	(WEST <TO SE-WALL>)
	(UP <PER CLIMB-A-TREE>)
	(DOWN <PER EXIT-A-TREE>)
	(THINGS (<> PASTURE HERE-F))
	(OVERHEAD OAK)
	(FNUM OTHRIFF)
	(GLOBAL SNOW NULL NULL)
	(ACTION IN-PASTURE-F)>

<ROUTINE IN-PASTURE-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"This windswept pasture is dotted with ancient oaks. A snowy trail winds upward">
		<COND (<IS? ,IN-THRIFF ,MUNGED>
		       <TELL ", and a solid wall of " 'XTREES
			     " lies to the " B ,W?SOUTHEAST>)>
		<TELL ,PERIOD>
		<MENTION-GLYPH?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IN? ,HUNTERS ,IN-PASTURE>
		       <MAKE ,HUNTERS ,SEEN>
		       <SEE-CHARACTER ,HUNTERS>)>
		<QUEUE ,I-HUNTERS>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<AND <IN? ,MINX ,OAK>
			    <IS? ,MINX ,LIVING>>
		       <TELL "A loud voice makes you hesitate." CR>
		       <RFATAL>)>
		<DEQUEUE ,I-HUNTERS>
		<COND (<EQUAL? ,P-WALK-DIR ,P?UP>
		       <SETG P-WALK-DIR ,P?WEST>)>
		<COND (<IN? ,HUNTER ,IN-PASTURE>
		       <ABORT-HUNT>
		       <TELL CTHE ,HUNTER " watches you leave." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-END>
		<COND (<NOT <IN? ,HUNTER ,IN-PASTURE>>)
		      (<NOT <EQUAL? ,WINNER ,PLAYER>>)
		      (<VERB? LISTEN SMELL>)
		      (<AND <VERB? ASK-ABOUT ASK-FOR TELL-ABOUT>
			    <PRSI? OAK MINX	>>)
		      (<EQUAL? ,OAK ,PRSO ,PRSI>
		       <DRAW-ATTENTION-TO ,OAK>
		       <RTRUE>)
		      (<EQUAL? ,MINX ,PRSO ,PRSI>
		       <DRAW-ATTENTION-TO ,MINX>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE DRAW-ATTENTION-TO (OBJ)
	 <TELL ,TAB "Your action draws " THE ,HUNTER
	       "'s attention to " THE .OBJ ,PERIOD>
	 <HUNTER-SEES-MINX>
	 <RTRUE>>

<ROUTINE HUNTER-SEES-MINX ()
	 <ABORT-HUNT>
	 <TELL ,TAB
"\"Aha!\" he cries, plucking the minx out from behind the oak by the scruff of her neck. \"Thought ye'd get away from me, did ye? It's back home I'll be bringin' you, for a whippin' ye won't soon forget!\"|
  The last thing you hear is a tearful cry of \"Minx!\" as " THE ,HUNTER
" stalks away with his quarry." CR>
	 <RTRUE>>

<ROUTINE ABORT-HUNT ()
	 <DEQUEUE ,I-HUNT>
	 <REMOVE ,HUNTER>
	 <SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
	 <REMOVE ,MINX>
	 <SETG P-HER-OBJECT ,NOT-HERE-OBJECT>	 
	 <SETG QCONTEXT <>>
	 <SETG QCONTEXT-ROOM <>>
	 <WINDOW ,SHOWING-ROOM>
	 <RFALSE>>

<OBJECT SE-WALL
	(LOC ROOMS)
	(DESC "Rock Wall")
	(FLAGS LIGHTED LOCATION)
	(EAST <TO IN-PASTURE>)
	(SOUTH <SORRY "The rock wall blocks your path.">)
	(NW <PER CANT-ENTER-WALL>)
	(IN <PER CANT-ENTER-WALL>)
	(WEST <SORRY "The rock wall blocks your path.">)
	(DOWN <TO IN-PASTURE>)
	(GLOBAL SWALL CASTLE SNOW NULL)
	(FNUM OTHRIFF)
	(ACTION SE-WALL-F)>

<ROUTINE CANT-ENTER-WALL ("AUX" X)
	 <COND (<EQUAL? ,P-WALK-DIR ,P?IN ,P?OUT>
		<TELL ,CANT "see anywhere to go ">
		<SET X ,W?OUT>
		<COND (<EQUAL? ,P-WALK-DIR <> ,P?IN>
		       <SET X ,W?IN>)>
		<TELL B .X ,PERIOD>
		<RFALSE>)>
	 <SET X <GETP ,HERE ,P?EXIT-STR>>
	 <COND (<T? .X>
		<TELL .X CR>
		<RFALSE>)>
	 <PRINT "The rock wall blocks your path.">
	 <CRLF>
	 <RFALSE>>

<ROUTINE SE-WALL-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A sunlit wall of stone rises above the snow-dusted ground. Gazing farther up the mountainside, you see the parapets of a mighty " 'CASTLE ,PERIOD>
		<COND (<IS? ,SWALL ,SEEN>
		       <TELL ,TAB>
		       <SEE-DOORLIKE ,SWALL>
		       <TELL "wall." CR>)>
		<MENTION-GLYPH?>
		<RTRUE>)
	       
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IS? ,SWALL ,SEEN>
		       <SETG P-IT-OBJECT ,SWALL>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<AND <EQUAL? ,P-WALK-DIR ,P?IN>
			    <IS? ,SWALL ,OPENED>>
		       <SETG P-WALK-DIR ,P?NW>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT SE-CAVE
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-CAVES)
	(FLAGS LOCATION INDOORS)
	(SE <PER CANT-ENTER-WALL>)
	(OUT <PER CANT-ENTER-WALL>)
	(SW <TO CAVE7>)
	(IN 0)
	(FNUM OCAVES)
	(EXIT-STR "A cold, hard wall blocks your path.")
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(GLOBAL SWALL SUNBEAM)
	(ACTION SE-CAVE-F)>

<ROUTINE SE-CAVE-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<NOTE-WALL ,SWALL ,W?SOUTHEAST>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<IN? ,GRUE ,HERE>
		       <REMOVE ,GRUE>)>
		<COND (<IS? ,SE-CAVE ,SEEN>)
		      (<NOT <SETUP-CAVES?>>
		       <RFATAL>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IS? ,SWALL ,SEEN>
		       <SETG P-IT-OBJECT ,SWALL>)>
		<COND (<IS? ,LANTERN ,LIGHTED>
		       <NO-LANTERN-HERE?>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE CHUCKLE ()
	 <TELL ,TAB>
	 <COND (<HERE? IN-LAIR>
		<MAKE ,URGRUE ,SEEN>
		<TELL "\"Heh, heh, heh,\" chuckles " THE ,URGRUE ,PERIOD>
		<RTRUE>)>
	 <TELL "An evil chuckle echoes through the caverns." CR>
	 <RTRUE>>

<ROUTINE NOTE-WALL (OBJ WRD)
	 <TELL "This ">
	 <COND (<NOT <IS? .OBJ ,OPENED>>
		<TELL "dead-end ">)>
	 <TELL "passage grows wider as it bends " B .WRD
	       ", ending at a flat wall of rock">
	 <COND (<IS? .OBJ ,SEEN>
		<TELL ". ">
		<COND (<IS? .OBJ ,OPENED>
		       <TELL "Daylight ">
		       <COND (<HERE? SE-CAVE>
			      <TELL "streams in from ">)
			     (T
			      <TELL "can be seen beyond ">)>
		       <TELL "an " B ,W?OPENING>)
		      (T
		       <PRINT "A doorlike ">
		       <TELL B ,W?OUTLINE " is visible">)>
		<TELL " therein">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<OBJECT NE-CAVE
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-CAVES)
	(FLAGS LOCATION INDOORS)
	(NW <PER CANT-ENTER-WALL>)
	(OUT <PER CANT-ENTER-WALL>)
	(SW 0)
	(IN 0)
	(FNUM OCAVES)
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(GLOBAL NWALL SUNBEAM)
	(EXIT-STR "A cold, hard wall blocks your path.")
	(ACTION NE-CAVE-F)>

<ROUTINE NE-CAVE-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<NOTE-WALL ,NWALL ,W?NORTHWEST>
		<MENTION-BEAM?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<IN? ,GRUE ,HERE>
		       <REMOVE ,GRUE>)>
		<COND (<IS? ,NE-CAVE ,SEEN>)
		      (<NOT <SETUP-CAVES?>>
		       <RFATAL>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IS? ,NWALL ,SEEN>
		       <SETG P-IT-OBJECT ,NWALL>)>
		<COND (<IS? ,LANTERN ,LIGHTED>
		       <NO-LANTERN-HERE?>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT NE-WALL
	(LOC ROOMS)
	(DESC "Shady Wall")
	(FLAGS LIGHTED LOCATION)
	(EAST <SORRY "The rock wall blocks your path.">)
	(SE <PER CANT-ENTER-WALL>)
	(IN <PER CANT-ENTER-WALL>)
	(SOUTH <SORRY "The rock wall blocks your path.">)
	(NE <TO XROADS>)
	(GLOBAL NULL NWALL CASTLE)
	(FNUM OXROADS)
	(ACTION NE-WALL-F)>

<ROUTINE NE-WALL-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The air is cool here, beneath the shadow of a towering wall of rock">
		<COND (<IS? ,NWALL ,SEEN>
		       <TELL ". ">
		       <SEE-DOORLIKE ,NWALL>
		       <TELL B ,W?WALL>)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IS? ,NWALL ,SEEN>
		       <SETG P-IT-OBJECT ,NWALL>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<AND <EQUAL? ,P-WALK-DIR ,P?IN>
			    <IS? ,NWALL ,OPENED>>
		       <SETG P-WALK-DIR ,P?SE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT CAVE0
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-CAVES)
	(FLAGS LOCATION INDOORS)
	(NE 0)
	(SE 0)
	(SW 0)
	(NW 0)
	(DNUM 0)
	(FNUM OCAVES)
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(GLOBAL SUNBEAM)
	(ACTION CAVE0-F)>

<ROUTINE CAVE0-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Cold, clammy walls of rock recede deep into the shadows." CR>)>
	 <RETURN <MOVE-GRUE? .CONTEXT>>>

<OBJECT CAVE1
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-CAVES)
	(FLAGS LOCATION INDOORS)
	(NE 0)
	(SE 0)
	(SW 0)
	(NW 0)
	(DNUM 0)
	(FNUM OCAVES)
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(GLOBAL SUNBEAM)
	(ACTION CAVE1-F)>

<ROUTINE CAVE1-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The steady drip of invisible moisture echoes in the passageway." CR>)>
	 <RETURN <MOVE-GRUE? .CONTEXT>>>

<OBJECT CAVE2
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-CAVES)
	(FLAGS LOCATION INDOORS)
	(NE 0)
	(SE 0)
	(SW 0)
	(NW 0)
	(DNUM 0)
	(FNUM OCAVES)
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(GLOBAL SUNBEAM)
	(ACTION CAVE2-F)>

<ROUTINE CAVE2-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The air here is pungent with subterranean vapors." CR>)>
	 <RETURN <MOVE-GRUE? .CONTEXT>>>

<OBJECT CAVE3
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-CAVES)
	(FLAGS LOCATION INDOORS)
	(NE 0)
	(SE 0)
	(SW 0)
	(NW 0)
	(DNUM 0)
	(FNUM OCAVES)
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(GLOBAL SUNBEAM)
	(ACTION CAVE3-F)>

<ROUTINE CAVE3-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Ebony walls of rock deepen the shadows on every side." CR>)>
	 <RETURN <MOVE-GRUE? .CONTEXT>>>

<OBJECT CAVE4
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-CAVES)
	(FLAGS LOCATION INDOORS)
	(NE 0)
	(SE 0)
	(SW 0)
	(NW 0)
	(DNUM 0)
	(FNUM OCAVES)
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(GLOBAL SUNBEAM)
	(ACTION CAVE4-F)>

<ROUTINE CAVE4-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Only a few feet separate the walls of this stultifying passage." CR>)>
	 <RETURN <MOVE-GRUE? .CONTEXT>>>

<OBJECT CAVE6
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-CAVES)
	(FLAGS LOCATION INDOORS)
	(NE 0)
	(SE 0)
	(SW 0)
	(NW 0)
	(DNUM 0)
	(FNUM OCAVES)
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(GLOBAL SUNBEAM)
	(ACTION CAVE6-F)>

<ROUTINE CAVE6-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The close, stale air in this chamber makes breathing difficult." CR>)>
	 <RETURN <MOVE-GRUE? .CONTEXT>>>

<OBJECT CAVE7
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-CAVES)
	(FLAGS LOCATION INDOORS)
	(NE <TO SE-CAVE>)
	(NW 0)
	(IN 0)
	(OUT <TO SE-CAVE>)
	(FNUM OCAVES)
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(GLOBAL SUNBEAM)
	(ACTION CAVE7-F)>

<ROUTINE CAVE7-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The walls of this shallow chamber are coated with a thick blanket of moss, fed by unseen trickles of water." CR>)>
	 <RETURN <MOVE-GRUE? .CONTEXT>>>

<ROUTINE MOVE-GRUE? (CONTEXT)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<MENTION-BEAM?>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERING>
		     <IN? ,GRUE ,HERE>>
		<REMOVE ,GRUE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MENTION-BEAM? ("AUX" DIR TBL)
	 <COND (<EQUAL? <GETP ,HERE ,P?MIRROR-OBJ> ,NO-MIRROR>
		<SET DIR <GETP ,HERE ,P?BEAM-DIR>>
		<COND (<EQUAL? .DIR ,NO-MIRROR>
		       <RFALSE>)>
		<PRINT "  A beam of sunlight ">
		<TELL "shines in from the " B <GET ,DIR-NAMES .DIR>>
		<SET DIR <+ .DIR 4>>
		<COND (<G? .DIR ,I-NW>
		       <SET DIR <- .DIR 8>>)>
		<SET TBL <GETP ,HERE <GETB ,PDIR-LIST .DIR>>>
		<COND (<ZERO? .TBL>)
		      (<EQUAL? <MSB <GET .TBL ,XTYPE>> ,CONNECT>
		       <TELL ", and disappears to the "
			     B <GET ,DIR-NAMES .DIR>>)>
		<TELL ,PERIOD>
		<RTRUE>)>
	 <RFALSE>>		

<OBJECT ON-PIKE
	(LOC ROOMS)
	(DESC "Edge of Storms")
	(FLAGS LIGHTED LOCATION)
	(SE <TO HILLTOP>)
        (WEST <PER ENTER-PLAIN-E 13>)
	(GLOBAL PRAIRIE)
	(FNUM OGRUBBO)
	(THINGS (<> BILLBOARD BILLBOARD-PSEUDO)
	 	(BILL BOARD BILLBOARD-PSEUDO)
		(<> SIGN BILLBOARD-PSEUDO)
		(<> NOTICE BILLBOARD-PSEUDO))
	(ACTION ON-PIKE-F)>

<ROUTINE ON-PIKE-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SEE-FIELDS ,W?WEST>
		<TELL ,PTAB "A billboard stands in a " 'WEEDS>
		<COND (<SEE-ANYTHING-IN? ,WEEDS>
		       <TELL ". Around it you see ">
		       <CONTENTS ,WEEDS>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<NOT <EQUAL? ,P-WALK-DIR ,P?WEST>>
		       <RFALSE>)>
		<RETURN <ENTER-PLAIN?>>)
	       (T
		<RFALSE>)>>

<OBJECT XROADS
	(LOC ROOMS)
	(DESC "Intersection")
	(FLAGS LIGHTED LOCATION)
        (NORTH <TO IN-GURTH>)
	(SE <TO IN-PORT 11>)
	(SW <TO NE-WALL>)
	(EAST <PER ENTER-PLAIN-W 13>)	
	(GLOBAL PRAIRIE GURTH)
	(FNUM OXROADS)
	(ACTION XROADS-F)>

<ROUTINE XROADS-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SEE-FIELDS ,W?EAST>
		<TELL  
". But the snow-capped peaks of Southern Mithicus are bright with sunshine" 
,PTAB "The outskirts of Gurth City">
		<PRINT " can be seen not far to the north.|">
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<EQUAL? ,P-WALK-DIR ,P?WEST>
		       <COND (<T? ,AUTO>
			      <BMODE-OFF>)>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?EAST>
		       <RETURN <ENTER-PLAIN?>>)
		      (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		       <ENTER-CITY>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTER-CITY ()
	 <TELL <PICK-NEXT ,CITY-ENTRIES>
	       " as you cross the city limits." CR>
	 <RTRUE>>

<ROUTINE SEE-FIELDS (WRD)
	 <TELL "Gray fields extend to the " B .WRD>
	 <PRINT " as far as you can see">
	 <TELL ", under ">
	 <PRINT "a sky black with thunderclouds">
	 <RTRUE>>
	
<ROUTINE ENTER-PLAIN? ("AUX" X Y L LL)
	 <SET L <LOC ,GOBLET>>
	 <KERBLAM>
	 <TELL "Forks of " B ,W?LIGHTNING 
	       " dance across your path">
	 <COND (<NOT <IS? ,ROSE-ROOM ,LOCATION>>
		<TELL ", and the clouds boom with laughter">)>
	 <COND (<OR <EQUAL? .L ,PLAYER>
		    <AND <T? .L>
			 <IN? .L ,PLAYER>
			 <SEE-INSIDE? .L>>>
		<COND (<IS? ,ROSE-ROOM ,LOCATION>
		       <TELL ", answered by " THE ,GOBLET>
		       <COND (<NOT <EQUAL? .L ,PLAYER>>
			      <ON-IN .L>)>)
		      (T
		       <TELL ". But " THE ,GOBLET>
		       <COND (<NOT <EQUAL? .L ,PLAYER>>
			      <ON-IN .L>)>
		       <TELL 
" emits an answering flash, and the threat from the sky subsides">)>
		<TELL ,PTAB>)
	       (T
		<MAKE ,IMPS ,MUNGED>
		<TELL ,PERIOD>
		<RFATAL>)>
	 <SET L <LOC ,MINX>>
	 <COND (<AND <T? .L>
		     <IS? ,MINX ,LIVING>>
		<SET LL <LOC .L>>
		<COND (<EQUAL? ,PLAYER .L .LL>
		       <MOVE ,MINX ,HERE>
		       <TELL CTHE ,MINX " struggles out of ">
		       <COND (<EQUAL? .L ,PLAYER>
			      <TELL "your arms">)
			     (T
			      <TELL THE .L>)>
		       <TELL " and">
		       <PRINT " cowers at the field's edge.|  ">)
		      (<EQUAL? ,HERE .L>
		       <TELL CTHE ,MINX>
		       <PRINT " cowers at the field's edge.|  ">)>)>
	 
	 <MAKE ,CORBIES ,SEEN>
	 <QUEUE ,I-CORBIES>
	 <COND (<NOT <IS? ,ROSE-ROOM ,LOCATION>>
		<MAKE ,ROSE-ROOM ,LOCATION>
		<TELL "As you set out across " THE ,PRAIRIE
", the colors around you seem to smudge and fade. Soon the entire landscape is rendered in shades of gray." CR>
		<RTRUE>)>
	 <TELL "All color drains from the landscape." CR>
	 <RTRUE>>

<GLOBAL PLAIN-COUNT:NUMBER 6>

<ROUTINE PLAIN-CONTEXT? (CONTEXT "AUX" TBL X)
	 <COND (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<NOT <IS? ,HERE ,TOUCHED>>
		       <COND (<DLESS? PLAIN-COUNT 1>
			      <SETG FARM-ROOM ,HERE>
			      <NEW-EXIT? ,FARM-ROOM ,P?SOUTH ,SORRY-EXIT 
		    		 "The ground is a bit too rough that way." <>>
			      <COND (<NOT <IS? ,FARMHOUSE ,NODESC>>
				     <DROP-FARM>)>)
			     (<EQUAL? ,PLAIN-COUNT 5>
			      <MOVE ,SCARE1 ,HERE>)
			     (<EQUAL? ,PLAIN-COUNT 4>
			      <MOVE ,CLOVER ,HERE>)
			     (<EQUAL? ,PLAIN-COUNT 3>
			      <MOVE ,SCARE2 ,HERE>)
			     (<EQUAL? ,PLAIN-COUNT 2>
			      <NEXT-SCROLL? ,DESCRIBE-PLAIN-SCROLL ,HERE>)
			     (<EQUAL? ,PLAIN-COUNT 1>
			      <MOVE ,SCARE3 ,HERE>)>)>
		<MAKE ,CORBIES ,SEEN>
		<COND (<IS? ,FARMHOUSE ,SEEN>)
		      (<IS? ,FARMHOUSE ,NODESC>)
		      (<HERE? FARM-ROOM>
		       <SETG STORM-TIMER 5>
		       <QUEUE ,I-TWISTER>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<IS? ,FARMHOUSE ,SEEN>)
		      (<IS? ,FARMHOUSE ,NODESC>)
		      (<HERE? FARM-ROOM>
		       <COND (<EQUAL? ,STORM-TIMER 3>
			      <TELL "A sudden">
			      <PRINT " noise makes you hesitate.|">
			      <RFATAL>)
			     (<EQUAL? ,P-WALK-DIR ,P?SOUTH ,P?IN>
			      <COND (<IN? ,TWISTER ,HERE>
				     <MOVE ,TWISTER ,IN-FARM>
				     <TELL 
"You fight your way through the rising gale." CR>
				     <RTRUE>)>
			      <RFALSE>)
			     (<EQUAL? ,STORM-TIMER 0 4 5>
			      <SETG STORM-TIMER 0>
			      <DEQUEUE ,I-TWISTER>)
			     (T
			      <SETG P-WALK-DIR <>>
			      <TELL 
"The rising gale makes it impossible to walk that way." CR>
			      <RFATAL>)>)>
		<COND (<IS? ,HERE ,SEEN>)
		      (<OR <AND <EQUAL? ,P-WALK-DIR ,P?WEST>
				<HERE? WEST-EXIT>>
			   <AND <EQUAL? ,P-WALK-DIR ,P?EAST>
				<HERE? EAST-EXIT>>>
		       <TELL "Color slowly returns to the landscape." CR>
		       <RTRUE>)>
		<COND (<NOT <EQUAL? ,P-WALK-DIR ,P?NORTH>>
		       <RFALSE>)>
		<SET X <GETP ,HERE ,P-WALK-DIR>>
		<COND (<ZERO? .X>
		       <RFALSE>)
		      (<NOT <EQUAL? <GET .X ,XROOM> ,ROSE-ROOM>>
		       <RFALSE>)
		      (<AND <T? ,BADKEY>
			    <IN? ,BADKEY ,PLAYER>>
		       <TELL "Screeching with fear, " THE ,CORBIES
			     " swoop out of your way." CR>
		       <RTRUE>)>
		<TELL "A screeching wall of corbies blocks the way." CR>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<GLOBAL WEST-EXIT:OBJECT <>>
<GLOBAL EAST-EXIT:OBJECT <>>
<GLOBAL FARM-ROOM:OBJECT <>>

<OBJECT PLAIN0
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-FROTZEN)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(EXIT-STR "The ground is a bit too rough that way.")
	(DNUM 0)
	(FNUM OPLAIN)
	(GLOBAL NULL NULL PRAIRIE STORM CORBIES)
	(ACTION PLAIN0-F)>

<ROUTINE PLAIN0-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The landscape is mottled with rocky terrain and windswept tracts of g">
		<GOLD-GRAY>
		<TELL " grass">
		<MENTION-CORBIES>
		<RTRUE>)>
	 <RETURN <PLAIN-CONTEXT? .CONTEXT>>>

<OBJECT PLAIN1
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-FROTZEN)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(EXIT-STR "The ground is a bit too rough that way.")
	(DNUM 0)
	(FNUM OPLAIN)
	(GLOBAL NULL NULL PRAIRIE STORM CORBIES)
	(ACTION PLAIN1-F)>

<ROUTINE PLAIN1-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "G">
		<GOLD-GRAY>
		<TELL 
" hills of grass sweep back and forth in the storm-driven wind">
		<MENTION-CORBIES>
		<RTRUE>)>
	 <RETURN <PLAIN-CONTEXT? .CONTEXT>>>

<OBJECT PLAIN2
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-FROTZEN)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(EXIT-STR "The ground is a bit too rough that way.")
	(DNUM 0)
	(FNUM OPLAIN)
	(GLOBAL NULL NULL PRAIRIE STORM CORBIES)
	(ACTION PLAIN2-F)>

<ROUTINE PLAIN2-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A sky black with thunderclouds looms over g">
		<GOLD-GRAY>
		<TELL " acres of windswept grass">
		<MENTION-CORBIES>
		<RTRUE>)>
	 <RETURN <PLAIN-CONTEXT? .CONTEXT>>>

<OBJECT PLAIN3
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-FROTZEN)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(EXIT-STR "The ground is a bit too rough that way.")
	(DNUM 0)
	(FNUM OPLAIN)
	(GLOBAL NULL NULL PRAIRIE STORM CORBIES)
	(ACTION PLAIN3-F)>

<ROUTINE PLAIN3-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Flashes of lightning light your path between the barren rocks and g">
		<GOLD-GRAY>
		<TELL " patches of grass"> 
		<MENTION-CORBIES>
		<RTRUE>)>
	 <RETURN <PLAIN-CONTEXT? .CONTEXT>>>

<OBJECT PLAIN4
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-FROTZEN)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(EXIT-STR "The ground is a bit too rough that way.")
	(DNUM 0)
	(FNUM OPLAIN)
	(GLOBAL NULL NULL PRAIRIE STORM CORBIES)
	(ACTION PLAIN4-F)>

<ROUTINE PLAIN4-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The windblown grass stretches in every " 'INTDIR>
		<PRINT " as far as you can see">
		<MENTION-CORBIES>
		<RTRUE>)>
	 <RETURN <PLAIN-CONTEXT? .CONTEXT>>>

<OBJECT PLAIN5
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-FROTZEN)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(EXIT-STR "The ground is a bit too rough that way.")
	(DNUM 0)
	(FNUM OPLAIN)
	(GLOBAL NULL NULL PRAIRIE STORM CORBIES)
	(ACTION PLAIN5-F)>

<ROUTINE PLAIN5-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "G">
		<GOLD-GRAY>
		<TELL 
" tracts of windswept grass sway to and fro under the dark, stormy sky">
		<MENTION-CORBIES>
		<RTRUE>)>
	 <RETURN <PLAIN-CONTEXT? .CONTEXT>>>

<ROUTINE DESCRIBE-FROTZEN (OBJ)
	 <TELL "The G">
	 <GOLD-GRAY>
	 <TELL " Fields of Frotzen">
	 <RTRUE>>

<ROUTINE GOLD-GRAY ()
	 <COND (<IS? ,HERE ,SEEN>
		<TELL "olden">
		<RTRUE>)>
	 <TELL "ray">
	 <RTRUE>>

<ROUTINE DESCRIBE-FARM-ROOM (OBJ)
	 <COND (<IS? ,FARMHOUSE ,SEEN>
		<TELL "Vacant Lot">
		<RTRUE>)>
	 <TELL "Farmyard">
	 <RTRUE>>

<ROUTINE MENTION-CORBIES ("AUX" TBL)
	 <COND (<AND <HERE? FARM-ROOM>
		     <IN? ,TWISTER ,HERE>>
		<TELL ,PERIOD>
		<RFALSE>)>
	 <TELL ". ">
	 <COND (<PROB 50>
		<TELL "Corbies are ">)
	       (T
		<TELL "A flock of corbies is ">)>
	 <TELL "circling ">
	 <SET TBL <GETP ,HERE ,P?NORTH>>
	 <COND (<ZERO? .TBL>)
	       (<EQUAL? <GET .TBL ,XROOM> ,ROSE-ROOM>
		<TELL "a point on " THE ,GROUND
		      " not far to the north." CR>
		<RTRUE>)>
	 <TELL "in tight, menacing circles overhead." CR>
	 <RTRUE>>

<OBJECT ROSE-ROOM
	(LOC ROOMS)
	(DESC "foo")
	(SDESC DESCRIBE-ROSE-ROOM)
	(FLAGS LIGHTED ; LOCATION)
	(SOUTH <TO ROSE-ROOM>)
	(EXIT-STR "The ground is a bit too rough that way.")
	(FNUM OPLAIN)
	(THINGS (<> GROTTO HERE-F))
	(GLOBAL PRAIRIE STORM CORBIES)
	(ACTION ROSE-ROOM-F)>

<ROUTINE DESCRIBE-ROSE-ROOM (OBJ)
	 <TELL "G">
	 <COND (<IS? ,ROSE-ROOM ,SEEN>
		<TELL "olden">)
	       (T
		<TELL "ray">)>
	 <TELL " Grotto">
	 <RTRUE>>

<ROUTINE ROSE-ROOM-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You're in the grotto." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-FARM
	(LOC ROOMS)
	(DESC "Farm House")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH <THRU FARM-DOOR IN-FARM>)
	(OUT <THRU FARM-DOOR IN-FARM>)
	(IN <SORRY "You're in as far as you can go.">)
	(SEE-ALL FARMHOUSE)
	(DNUM 0)
	(FNUM OPLAIN)
	(GLOBAL FARMHOUSE FARM-DOOR FARM-WINDOW)
	(ACTION IN-FARM-F)>

<ROUTINE DESCRIBE-IN-FARM (OBJ)
	 <PRINTD .OBJ>
	 <TELL ", in a " 'TWISTER>
	 <RTRUE>>

<ROUTINE IN-FARM-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"This tiny shack looks much as you'd expect after falling thousands of feet. No two of the splintered walls are parallel. The floor and ceiling are likewise skewed at crazy angles." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<AND <EQUAL? ,P-WALK-DIR ,P?NORTH ,P?OUT>
			    <IS? ,FARM-DOOR ,OPENED>>
		       <COND (<IN? ,TWISTER ,IN-FARM>
			      <UNMAKE ,FARM-DOOR ,OPENED>
			      <WINDOW ,SHOWING-ROOM>
			      <ITALICIZE "Bang">
			      <TELL "! The wind slams " THE ,FARM-DOOR
				    " in your face." CR>
			      <RFATAL>)
			     (<IN? ,FCROWD ,IN-FROON>
			      <TELL CTHE ,FCROWD
" cheers louder as you leave " THE ,FARMHOUSE ,PERIOD>
			      <RTRUE>)>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-GURTH
	(LOC ROOMS)
	(DESC "South Market")
	(FLAGS LIGHTED LOCATION)
	(NORTH <TO AT-MAGICK>)
	(SOUTH <TO XROADS>)
	(GLOBAL GURTH)
	(FNUM OCITY)
	(EXIT-STR "An impatient crowd of shoppers pushes you back.")
	(ACTION IN-GURTH-F)>

<ROUTINE IN-GURTH-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Both sides of this busy thoroughfare are crammed with stalls. Hawkers shout and gesticulate at the passersby, their hoarse obscenities mingling with the smell of sweat and burning food." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<ZERO? ,P-WALK-DIR>)
		      (<IS? ,CAKE ,NODESC>
		       <UNMAKE ,CAKE ,NODESC>
		       <MOVE ,CAKE ,HERE>
		       <SETG P-IT-OBJECT ,CAKE>
		       <QUEUE ,I-CAKE 3>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL "\"Oof!\"|
  The street hawker you just bumped into glowers. \"Watch where I'm goin', will ya!\" You clumsily help to pick up her spilled wares; she stomps away without a word of thanks.|
  As you dust yourself off, you notice something">
		       <PRINT " lying in the dust.">
		       <CRLF>
		       <RFATAL>)
		    ; (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		       <CROWD-PUSH>
		       <RTRUE>)
		    ; (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <EXIT-CITY>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

; <ROUTINE CROWD-PUSH ()
	 <PRINT "You push your way ">
	 <COND (<PROB 50>
		<TELL B ,W?THROUGH>)
	       (T
		<TELL "deeper into">)>
	 <TELL " the teeming crowd." CR>
	 <RTRUE>>

; <ROUTINE EXIT-CITY ("AUX" X)
	 <SET X <RANDOM 100>>
	 <TELL ,XTHE>
	 <COND (<L? .X 33>
		<TELL B ,W?SMELL>)
	       (<L? .X 67>
		<TELL B ,W?NOISE>)
	       (T
		<TELL B ,W?SMELL "s and " B ,W?NOISE>)>
	 <TELL "s of the city fade behind you." CR>
	 <RTRUE>>

<OBJECT AT-MAGICK
	(LOC ROOMS)
	(DESC "North Market")
	(FLAGS LIGHTED LOCATION)
	(NE <TO NGURTH>)
	(SOUTH <TO IN-GURTH>)
        (WEST <THRU MAGICK-DOOR IN-MAGICK>)
	(IN <THRU MAGICK-DOOR IN-MAGICK>)
	(GLOBAL MAGICK-DOOR MSHOPPE GURTH)
	(FNUM OCITY)
	(ACTION AT-MAGICK-F)>

<ROUTINE AT-MAGICK-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"This is the safer end of Gurth City's notorious market district. Shop windows are mostly unbroken here, and the cobblestones don't stick to your shoes"
,PTAB "The gabled facade of Ye Olde Magick Shoppe lends an air of ersatz charm to the west side of the street">
		<COND (<IS? ,MAGICK-DOOR ,OPENED>
		       <TELL ". The front door is wide open">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	     ; (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		       <EXIT-CITY>
		       <RTRUE>)
		      (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <CROWD-PUSH>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>		 

<OBJECT IN-MAGICK
	(LOC ROOMS)
	(DESC "Magick Shoppe")
	(FLAGS LIGHTED LOCATION INDOORS)
	(EAST <THRU MAGICK-DOOR AT-MAGICK>)
	(OUT <THRU MAGICK-DOOR AT-MAGICK>)
	(WEST <PER ENTER-CURTAIN>)
	(IN <PER ENTER-CURTAIN>)
	(FNUM OCITY)
	(THIS-CASE MCASE)
	(GLOBAL MAGICK-DOOR MSHOPPE GURTH)
	(ACTION IN-MAGICK-F)>

<ROUTINE IN-MAGICK-F ("OPT" (CONTEXT <>) "AUX" (CNT 0))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A lone black candle obscures the proportions of this windowless shop. The scent of tallow is strong, heightening the aura of arcane mystery" ,PTAB
"Your eyes are irresistibly drawn to a ">
		<SHOP-DOOR ,MAGICK-DOOR>
		<LOOK-ON-CASE ,ON-MCASE>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<NOT <IS? ,MCASE ,SEEN>>
		       <MAKE ,MCASE ,SEEN>
		       <REPEAT ()
			  <PUTP <NEXT-POTION? ,MCASE> ,P?VALUE 24>
			  <COND (<IGRTR? CNT 2>
				 <RETURN>)>>)>
		<GET-OWOMAN-AND-CURTAIN>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT NGURTH
	(LOC ROOMS)
	(DESC "Outskirts")
	(FLAGS LIGHTED LOCATION)
	(SW <TO AT-MAGICK>)
	(NORTH <PER NGURTH-N 1>)
	(FNUM OCITY)
	(GLOBAL GURTH)
	(ACTION NGURTH-F)>

<ROUTINE NGURTH-F ("OPT" (CONTEXT <>) "AUX" X WRD)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The path before you leads away from the ">
		<COND (<EQUAL? ,P-WALK-DIR ,P?NE>
		       <PRINT "outskirts of Gurth City">
		       <SET WRD ,W?SOUTH>
		       <SET X "edge of a vast forest">)
		      (T
		       <PRINT "edge of a vast forest">
		       <SET WRD ,W?NORTH>
		       <SET X "outskirts of Gurth City">)>
		<TELL 
", meandering across the hills towards the " B .WRD "ernmost " .X ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <ENTER-CITY>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT TWILIGHT
	(LOC ROOMS)
	(DESC "Twilight")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(IN 0)
	(OUT 0)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(OVERHEAD OAK3)
	(DOWN <PER EXIT-A-TREE>)
	(UP <PER CLIMB-A-TREE>)
	(DNUM 0)
	(FNUM OFOREST)
	(GLOBAL WOODS)
	(ACTION TWILIGHT-F)>

<ROUTINE TWILIGHT-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"An ancient oak tree turns the day to twilight beneath the impressive sprawl of its branches">
		<LOOK-UNDER-OAK ,OAK3>
		<CRLF>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FOREST1
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(FNUM OFOREST)
	(GLOBAL WOODS)
	(ACTION FOREST-ROOM-F)>

<OBJECT FOREST2
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(FNUM OFOREST)
	(GLOBAL WOODS)
	(ACTION FOREST-ROOM-F)>

<OBJECT FOREST3
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(FNUM OFOREST)
	(GLOBAL WOODS)
	(ACTION FOREST-ROOM-F)>

<OBJECT FOREST4
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(FNUM OFOREST)
	(GLOBAL WOODS)
	(ACTION FOREST-ROOM-F)>

<OBJECT FOREST5
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(FNUM OFOREST)
	(GLOBAL WOODS)
	(ACTION FOREST-ROOM-F)>

<OBJECT FOREST6
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(FNUM OFOREST)
	(GLOBAL WOODS)
	(ACTION FOREST-ROOM-F)>

<ROUTINE FOREST-ROOM-F (CONTEXT "AUX" TBL)
	 <COND (<NOT <EQUAL? .CONTEXT ,M-ENTERING>>
		<RFALSE>)
	       (<IS? ,HERE ,TOUCHED>
		<RFALSE>)
	       (<AND <IS? ,BOULDER ,NODESC>
		     <LAST-ROOM-IN? ,FOREST-ROOMS 2>>
		<UNMAKE ,BOULDER ,NODESC>
		<MOVE ,BOULDER ,HERE>
		<PUTP ,HERE ,P?SDESC ,DESCRIBE-POOL>
		<PUTP ,HERE ,P?ACTION ,AT-POOL-F>
		<RFALSE>)
	       (T
		<SET TBL <PICK-ONE ,FOREST-DESCS>>
		<PUTP ,HERE ,P?SDESC <GET .TBL 0>>
		<PUTP ,HERE ,P?ACTION <GET .TBL 1>>
		<RFALSE>)>>

<ROUTINE OPEN-POOL ()
	 <REPLACE-SYN? ,BOULDER ,W?YOUTH ,W?ZZZP>
	 <WINDOW ,SHOWING-ALL>
	 <SETG P-WALK-DIR <>>
	 <SETG OLD-HERE <>>
	 <MOVE ,POOL ,HERE>
	 <SETG P-IT-OBJECT ,POOL>
	 <SETUP-POND-EXITS>
	 <TELL "\"Behold the Pool of Eternal Youth.\"|
  The hollow voice fades in the air as beams of sunlight converge on the clearing, forming a shallow pool of radiance that flows and ripples like a golden liquid." CR>
	 <RTRUE>>

<ROUTINE SETUP-POND-EXITS ()
	 <NEW-EXIT? ,HERE ,P?IN %<+ ,FCONNECT 1 ,MARKBIT> ,ENTER-POOL>
	 <NEW-EXIT? ,HERE ,P?OUT ,SORRY-EXIT "You're not in the pool.">
	 <RFALSE>>

<ROUTINE DESCRIBE-POOL (OBJ)
	 <TELL "Clearing">
	 <RTRUE>>

<ROUTINE AT-POOL-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Soft rays of sunlight filter down through the overhanging trees">
		<COND (<IN? ,POOL ,HERE>
		       <TELL ", forming a circular " 'POOL>
		       <COND (<AND <NOT <IN? ,PLAYER ,POOL>>
				   <SEE-ANYTHING-IN? ,POOL>>
			      <TELL ". You can make out ">
			      <CONTENTS ,POOL>
			      <TELL " enveloped within">)>)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-F1 (OBJ)
	 <TELL "Birches">
	 <RTRUE>>

<ROUTINE F1-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A graceful stand of birches has taken root amid the tangle of roots and underbrush." CR>  
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-F2 (OBJ)
	 <TELL "Catalpa">
	 <RTRUE>>

<ROUTINE F2-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Your head brushes past the blossoms of a stately old catalpa tree, home of many an unseen songbird." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-F3 (OBJ)
	 <TELL "Pine Grove">
	 <RTRUE>>

<ROUTINE F3-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A carpet of amber softens your footsteps between the rows of tall, sweet-smelling pines." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-F4 (OBJ)
	 <TELL "Eerie Copse">
	 <RTRUE>>

<ROUTINE F4-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A nameless blight has twisted the surrounding elms into sinister forms that creak and groan in the dry breeze." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-F5 (OBJ)
	 <TELL "Willow">
	 <RTRUE>>

<ROUTINE F5-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The limbs of an old, melancholy willow sway to and fro in the whispering breeze." CR> 
 		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-F6 (OBJ)
	 <TELL "Talons">
	 <RTRUE>>

<ROUTINE F6-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The gnarled branch of an ironwood tree looms above the path like the talons of a hawk descending." CR> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SFORD
	(LOC ROOMS)
	(DESC "South Chasm")
	(FLAGS LIGHTED LOCATION)
	(NORTH <TO ON-BRIDGE 9>)
	(SW <PER SFORD-S 1>)
	(FNUM OFOREST)
	(GLOBAL ZBRIDGE ZSIGN RIVER)
	(ACTION SFORD-F)>

<ROUTINE SFORD-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SEE-BRIDGE ,W?SOUTH>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
	        <COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		       <SETG BRIDGE-DIR "North">
		       <SETG ZTOP 1>
		       <SETG ZBOT 2>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE SEE-BRIDGE (WRD)
	 <TELL "You're shivering on the " B .WRD
" edge of a broad chasm. Clammy mists chill the air, and " THE ,GROUND
" trembles with the roar of a cataract" ,PTAB 
"Your heart sinks as you inspect the crude rope bridge spanning the chasm. A notice hangs near " THE ,ZBRIDGE "'s entrance." CR>
	 <RTRUE>>

<OBJECT NFORD
	(LOC ROOMS)
	(DESC "North Chasm")
	(FLAGS LIGHTED LOCATION)
	(NE <PER NFORD-NE 1>)
	(SOUTH <TO ON-BRIDGE 9>)
	(FNUM ORUINS)
	(GLOBAL ZBRIDGE ZSIGN RIVER)
	(ACTION NFORD-F)>

<ROUTINE NFORD-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SEE-BRIDGE ,W?NORTH>
		<TELL ,TAB 
"The ruins of an ancient city lie not far to the " B ,W?NORTHEAST ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
	        <COND (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <SETG BRIDGE-DIR "South">
		       <SETG ZTOP 1>
		       <SETG ZBOT 2>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT ON-BRIDGE
	(LOC ROOMS)
	(DESC "Bridge")
	(SDESC DESCRIBE-ON-BRIDGE)
	(FLAGS LIGHTED LOCATION)
	(NORTH <TO ON-BRIDGE 9>)
	(SOUTH <TO ON-BRIDGE 9>)
	(EXIT-STR "You'd plunge into the water if you went that way.")
	(DOWN <PER JUMP-OFF-BRIDGE>)
	(BELOW RIVER)
	(GLOBAL ZBRIDGE RIVER)
	(FNUM OBRIDGE)
	(ACTION ON-BRIDGE-F)>

<GLOBAL BRIDGE-DIR:STRING 0>
<GLOBAL ZTOP:NUMBER 1>
<GLOBAL ZBOT:NUMBER 2>

<ROUTINE DESCRIBE-ON-BRIDGE (OBJ)
	 <COND (<EQUAL? ,ZBOT 2>
		<TELL "Halfway">)
	       (<EQUAL? ,ZBOT -1>
		<TELL "Immeasurably Close">)
	       (T
		<COND (<AND <EQUAL? ,ZBOT ,HIGHEST-ZBOT>
			    <L? ,ZTOP <- ,HIGHEST-ZBOT 1>>>
		       <TELL "About ">)>
		<PRINTN ,ZTOP>
		<PRINTC %<ASCII !\/>>
		<PRINTN ,ZBOT>
		<TELL " of the Way">)>
	 <COND (<ZERO? ,BRIDGE-DIR>
		<TELL " Across">
		<RTRUE>)>
	 <TELL " to the " ,BRIDGE-DIR " End">
	 <RTRUE>>

<ROUTINE ON-BRIDGE-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The entire bridge jerks and sways as you struggle to keep your footing on the slippery ropes. " <PICK-NEXT ,BRIDGE-TYPES> ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<AND <EQUAL? ,ZTOP 1>
			    <EQUAL? ,ZBOT 2>
			    <IS? ,PARASOL ,NODESC>
			    <NOT <IS? ,PARASOL ,TOUCHED>>>
		       <UNMAKE ,PARASOL ,NODESC>
		       <MOVE ,PARASOL ,ON-BRIDGE>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<NOT <EQUAL? ,P-WALK-DIR ,P?NORTH ,P?SOUTH>>
		       <RFALSE>)
		      (<IN? ,PARASOL ,ON-BRIDGE>
		       <REMOVE ,PARASOL>
		       <MAKE ,PARASOL ,NODESC>)>
		<COND (<OR <ZERO? ,BRIDGE-DIR>
			   <AND <EQUAL? ,P-WALK-DIR ,P?NORTH>
				<EQUAL? ,BRIDGE-DIR "North">>
			   <AND <EQUAL? ,P-WALK-DIR ,P?SOUTH>
				<EQUAL? ,BRIDGE-DIR "South">>>
		       <COND (<EQUAL? ,ZBOT ,HIGHEST-ZBOT -1>
			      <SETG ZBOT -1>)
			     (T
			      <SETG ZTOP <+ ,ZTOP ,ZBOT>>
			      <SETG ZBOT <+ ,ZBOT ,ZBOT>>)>)
		      (<EQUAL? ,ZBOT ,HIGHEST-ZBOT -1>
		       <SETG BRIDGE-DIR 0>
		       <SETG ZBOT 2>
		       <SETG ZTOP 1>)
		      (T
		       <SETG ZBOT <+ ,ZBOT ,ZBOT>>
		       <SETG ZTOP <- ,ZBOT ,ZTOP>>)>
		<SETG BRIDGE-DIR "North">
		<COND (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <SETG BRIDGE-DIR "South">)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE JUMP-OFF-BRIDGE ("AUX" OBJ NXT X)
	 <TELL "You leap off the ">
	 <COND (<HERE? ON-BRIDGE>
		<TELL "slippery ropes">)
	       (T
		<TELL "chasm's edge">)>
	 <TELL ,AND>
	 <COND (<AND <IN? ,PARASOL ,PLAYER>
		     <IS? ,PARASOL ,OPENED>
		     <NOT <IS? ,PARASOL ,MUNGED>>>
		<PCLEAR>
		<TELL "drift down towards the raging water" ,PTAB>
		<ITALICIZE "Rip">
		<TELL "! A gust of spray">
		<TEARS-PARASOL>
		<TELL ", and you hit the freezing water...">
		<COND (<SET OBJ <FIRST? ,PLAYER>>
		       <REPEAT ()
			  <SET NXT <NEXT? .OBJ>>
			  <COND (<IS? .OBJ ,WORN>)
				(<IS? .OBJ ,TAKEABLE>
				 <MOVE .OBJ ,AT-BROOK>
			         <UNMAKE .OBJ ,WIELDED>
				 <COND (<AND <EQUAL? .OBJ ,MINX>
					     <IS? .OBJ ,LIVING>>
					<KILL-MINX>)>)>
			  <SET OBJ .NXT>
			  <COND (<ZERO? .OBJ>
				 <RETURN>)>>)>
		<REGAIN-SENSES>
		<UNMAKE ,AT-BROOK ,TOUCHED>
		<GOTO ,AT-BROOK>
		<SET X <GET ,STATS ,ENDURANCE>>
		<COND (<G? .X 1>
		       <COND (<T? ,AUTO>
			      <BMODE-ON>)>
		       <UPDATE-STAT <- 0 <- .X 1>>>)>
		<RFALSE>)> ; "Important!"
	 <TELL "plummet to a cold, violent death in the raging waters">
	 <JIGS-UP>
	 <RFALSE>>
			      
<OBJECT ARCH-VOID
	(LOC ROOMS)
	(DESC "Void")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "Nothing but void lies that way.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(FNUM ORUINS)
	(ACTION ARCH-VOID-F)>

<ROUTINE ARCH-VOID-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A timeless, dimensionless void stretches be">
		<COND (<ZERO? ,ATIME>
		       <TELL "hind you, re">
		       <PRINT "ceding into the infinite ">
		       <TELL "past." CR>
		       <RTRUE>)>
		<TELL "fore you, pro">
		<PRINT "ceding into the infinite ">
		<TELL "future." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<OBJECT ARCH1
	(LOC ROOMS)
	(DESC "Savannah")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "An irresistible force holds you near the arch.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(IN <PER ENTER-ARCH>)
	(OUT <PER EXIT-ARCH>)
	(FNUM ORUINS)
	(THINGS (<> SAVANNAH HERE-F)
	 	(HUGE DINOSAURS USELESS)
		(HUGE DINOSAUR USELESS)
		(<> VOLCANOS USELESS))
	(ACTION ARCH1-F)>

<ROUTINE ARCH1-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Huge dinosaurs feed on unfamiliar vegetation, lumbering against a sky red with the glare of active volcanos." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>
   
<OBJECT ARCH2
	(LOC ROOMS)
	(DESC "Forest Clearing")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "An irresistible force holds you near the arch.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(IN <PER ENTER-ARCH>)
	(OUT <PER EXIT-ARCH>)
	(FNUM ORUINS)
	(THINGS (<> CLEARING HERE-F)
	 	(<> HUTS USELESS)
		(<> HUT USELESS))
	(GLOBAL PHEEBOR)
	(ACTION ARCH2-F)>

<ROUTINE ARCH2-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The perimeter of this grassy " B ,W?CLEARING
" is dotted with primitive huts." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<OBJECT ARCH3
	(LOC ROOMS)
	(DESC "New Plaza")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "An irresistible force holds you near the arch.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(IN <PER ENTER-ARCH>)
	(OUT <PER EXIT-ARCH>)
	(FNUM ORUINS)
	(GLOBAL PLAZA PHEEBOR)
	(ACTION ARCH3-F)>

<ROUTINE ARCH3-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The spires of a young and arrogant city rise around " THE ,PLAZA>
		<COND (<IN? ,PCROWD ,HERE>
		       <TELL 
", which is filled to capacity with a cheering throng">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<MOVE ,ORATOR ,HERE>
		<SEE-CHARACTER ,ORATOR>
		<MOVE ,PCROWD ,HERE>
		<SETG P-THEM-OBJECT ,PCROWD>
		<QUEUE ,I-ARCH3>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<IN? ,ORATOR ,HERE>
		       <REMOVE ,ORATOR>)>
		<COND (<IN? ,PCROWD ,HERE>
		       <REMOVE ,PCROWD>)>
		<DEQUEUE ,I-ARCH3>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<OBJECT ARCH4
	(LOC ROOMS)
	(DESC "Battleground")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "An irresistible force holds you near the arch.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(IN <PER ENTER-ARCH>)
	(OUT <PER EXIT-ARCH>)
	(FNUM ORUINS)
	(GLOBAL PLAZA PHEEBOR)
	(ACTION ARCH4-F)>

<ROUTINE ARCH4-F ("OPT" (CONTEXT <>) "AUX" (V 0) (NEWIQ 0) (NAC 0) OBJ NXT)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A mighty conflagration obscures the dying city in a pall of smoke. Motionless bodies are strewn around " THE ,ARCH ,PTAB 
"Battle trenches zigzag across the plaza like open wounds. The one nearest you is ">
		<COND (<IN? ,HORSE ,TRENCH>
		       <TELL "blocked by the body of " A ,HORSE>)
		      (<SEE-ANYTHING-IN? ,TRENCH>
		       <TELL "sheltering ">
		       <CONTENTS ,TRENCH>)
		      (T
		       <TELL "unoccupied">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<REMOVE-ALL ,TRENCH>
		<MAKE ,TRENCH ,NODESC>
		<MOVE ,TRENCH ,HERE>
		<MAKE ,TRENCH ,OPENED>
		<REPLACE-SYN? ,TRENCH ,W?MINXHOLE ,W?ZZZP>
		<REPLACE-ADJ? ,TRENCH ,W?MINX ,W?ZZZP>
		<QUEUE ,I-ARCH4>
		<COND (<NOT <IN? ,HELM ,PRINCE>>
		       <COND (<VISIBLE? ,HELM>
			      <INC V>
			      <COND (<AND <IN? ,HELM ,PLAYER>
					  <IS? ,HELM ,WORN>>
				     <INC NAC>
				     <COND (<NOT <IS? ,HELM ,NEUTRALIZED>>
					    <INC NEWIQ>)>)>)>
		       <MOVE ,HELM ,PRINCE>
		       <PUTP ,HELM ,P?VALUE <GETP ,HELM ,P?DNUM>>
		       <UNMAKE ,HELM ,WORN>
		       <UNMAKE ,HELM ,WIELDED>
		       <COND (<T? .V>
			      <WINDOW ,SHOWING-ALL>
			      <TELL CTHE ,HELM 
				    " abruptly fades from view." CR>
			      <COND (<T? .NAC>
				     <UPDATE-STAT <- 0 <GETP ,HELM ,P?EFFECT>>
						  ,ARMOR-CLASS>)>
			      <COND (<T? .NEWIQ>
				     <NORMAL-IQ>)>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<DEQUEUE ,I-ARCH4>
		<COND (<SET OBJ <FIRST? ,TRENCH>>
		       <REPEAT ()
			  <SET NXT <NEXT? .OBJ>>
			  <COND (<EQUAL? .OBJ ,TEAR ,DIAMOND ,PHASE>)
				(<EQUAL? .OBJ ,TRUFFLE>
				 <COND (<NOT <IS? .OBJ ,MUNGED>>
					<REMOVE .OBJ>)>)
				(<NOT <IS? .OBJ ,FERRIC>>
				 <REMOVE .OBJ>)>
			  <SET OBJ .NXT>
			  <COND (<ZERO? .OBJ>
				 <RETURN>)>>)> 
		<REMOVE ,TRENCH>
		<UNMAKE ,TRENCH ,OPENED>
		<REMOVE ,BHORSE>
		<UNMAKE ,PRINCE ,SLEEPING>
		<MAKE ,PRINCE ,NODESC>
		<MOVE ,PRINCE ,HORSE>
		<PUTP ,PRINCE ,P?ACTION ,PRINCE-F>
		<REPLACE-SYN? ,PRINCE ,W?HEAD ,W?ZZZP>
		<REPLACE-SYN? ,PRINCE ,W?BODY ,W?ZZZP>
		<REPLACE-SYN? ,PRINCE ,W?CORPSE ,W?ZZZP>
		<REPLACE-ADJ? ,PRINCE ,W?DEAD ,W?ZZZP>
		<REMOVE ,HORSE>
		<REMOVE ,DEAD-HORSE>
		<MAKE ,HORSE ,LIVING>
		<UNMAKE ,HORSE ,NODESC>
	      ; <REPLACE-ADJ? ,HORSE ,W?DEAD ,W?ZZZP>
	      ; <PUTP ,HORSE ,P?ACTION ,HORSE-F>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<OBJECT ARCH5
	(LOC ROOMS)
	(DESC "Rubble")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "An irresistible force holds you near the arch.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(IN <PER ENTER-ARCH>)
	(OUT <PER EXIT-ARCH>)
	(FNUM ORUINS)
	(GLOBAL PLAZA PHEEBOR)
	(ACTION ARCH5-F)>

<ROUTINE ARCH5-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Time has not yet softened the layers of dirt and rubble obscuring the remains of the plaza." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<ROUTINE HANDLE-ARCH-ROOMS? (CONTEXT "AUX" X OBJ NXT)
	 <COND (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<HERE? <GETB ,ARCH-ROOMS ,PRESENT>>
		       <RFALSE>)
		      (<SET OBJ <FIRST? ,HERE>>
		       <REPEAT ()
			  <SET NXT <NEXT? .OBJ>>
			  <COND (<IS? .OBJ ,TAKEABLE>
				 <REMOVE .OBJ>)>
			  <SET OBJ .NXT>
			  <COND (<ZERO? .OBJ>
				 <RFALSE>)>>)>
		<RFALSE>)
	       (<NOT <EQUAL? .CONTEXT ,M-BEG>>
		<RFALSE>)
	       (<EQUAL? ,ATIME ,PRESENT>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<TELL
"Your voice has the faint, wistful quality of words ">
		<COND (<L? ,ATIME ,PRESENT>
		       <TELL "yet to be spoken">)
		      (T
		       <TELL "spoken long ago">)>
		<SET X <QCONTEXT-GOOD?>>
		<COND (<T? .X>
		       <TELL "; " THE .X " seems not to hear">)>
		<PRINT ,PERIOD>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<OBJECT ARCH9
	(LOC ROOMS)
	(DESC "Frost")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "An irresistible force holds you near the arch.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(IN <PER ENTER-ARCH>)
	(OUT <PER EXIT-ARCH>)
	(FNUM ORUINS)
	(GLOBAL PLAZA PHEEBOR)
	(ACTION ARCH9-F)>

<ROUTINE ARCH9-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Ages of windblown dust lie hardened upon the frozen earth. The air is touched with an ominous arctic chill." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<OBJECT ARCH10
	(LOC ROOMS)
	(DESC "Glacier")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "An irresistible force holds you near the arch.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(IN <PER ENTER-ARCH>)
	(OUT <PER EXIT-ARCH>)
	(THINGS (<> GLACIER HERE-F)
	 	(GLACIAL ICE HERE-F))
	(FNUM ORUINS)
	(ACTION ARCH10-F)>

<ROUTINE ARCH10-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The last traces of the plaza are lost beneath an impenetrable layer of glacial ice." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<OBJECT ARCH11
	(LOC ROOMS)
	(DESC "Highway")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "An irresistible force holds you near the arch.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(IN <PER ENTER-ARCH>)
	(OUT <PER EXIT-ARCH>)
	(THINGS (METAL MECHANISM USELESS)
	 	(GLASS MECHANISM USELESS)
		(<> BOULDERS USELESS)
		(<> ROCKS USELESS)
		(<> HIGHWAY HERE-F))
	(FNUM ORUINS)
	(ACTION ARCH11-F)>

<ROUTINE ARCH11-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Strange mechanisms of metal and glass zoom across a rugged landscape strewn with glacial boulders." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<OBJECT ARCH12
	(LOC ROOMS)
	(DESC "Desolation")
	(FLAGS LIGHTED LOCATION)
	(EXIT-STR "An irresistible force holds you near the arch.")
	(NORTH <PER TIMESHIFT 9>)
	(SOUTH <PER TIMESHIFT 9>)
	(IN <PER ENTER-ARCH>)
	(OUT <PER EXIT-ARCH>)
	(FNUM ORUINS)
	(ACTION ARCH12-F)>

<ROUTINE ARCH12-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Patient centuries have eroded much of the topsoil from the landscape. Loose, charred earth stretches away in every " 'INTDIR ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<IN? ,TRENCH ,HERE>
		       <MAKE ,TRENCH ,NODESC>
		       <UNMAKE ,TRENCH ,OPENED>
		       <REMOVE ,TRENCH>)>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<GLOBAL ATIME:NUMBER ,PRESENT>

<ROUTINE TIMESHIFT ("AUX" X)
	 <COND (<OR <NOT <IS? ,ARCH ,SEEN>>
		    <AND <EQUAL? ,P-WALK-DIR ,P?NORTH>
			 <EQUAL? ,ATIME ,MAX-ATIME>>
		    <AND <EQUAL? ,P-WALK-DIR ,P?SOUTH>
			 <ZERO? ,ATIME>>>
		<TELL "The weight of centuries restricts your motion." CR>
		<RFALSE>)>
	 	 
	 <SET X <APPLY <GETP ,HERE ,P?ACTION> ,M-EXIT>>
	 <COND (<T? .X>
		<COND (<EQUAL? .X ,M-FATAL>
		       <RFALSE>)
		      (<T? ,VERBOSITY>
		       <CRLF>)>)>
	 <COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		<INC ATIME>)
	       (T
		<DEC ATIME>)>
	 <SETG HERE <GETB ,ARCH-ROOMS ,ATIME>>
	 <MOVE ,ARCH ,HERE>
	 <SETG OLD-HERE <>>
	 <SETG ARCHTIMER 0>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTERING>
	 
	 <COND (<IS? ,LIGHTSHOW ,TOUCHED>
		<TELL "You slide ">)
	       (T
		<TELL "The merest effort of will is enough to slide you ">)> 
	 <COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		<TELL B ,W?FOR>)
	       (T
		<TELL B ,W?BACK>)>
	 <TELL "ward through " THE ,LIGHTSHOW>
	 <COND (<NOT <IS? ,LIGHTSHOW ,TOUCHED>>
		<MAKE ,LIGHTSHOW ,TOUCHED>
		<TELL ", guided by the Magick of the arch">)>
	 <RELOOK>
	 <COND (<T? ,GLASS-TOP>
		<I-GLASS>)>
	 <RFALSE>>

<OBJECT IN-LAIR
	(LOC ROOMS)
	(DESC "Treasure Chamber")
	(FLAGS LOCATION INDOORS)
	(NE 0)
	(SE 0)
	(OUT 0)
	(MIRROR-OBJ NO-MIRROR)
	(BEAM-DIR NO-MIRROR)
	(EXIT-STR "Rock walls block your path.")
	(FNUM OCAVES)
	(GLOBAL SUNBEAM)
	(ACTION IN-LAIR-F)>

<ROUTINE IN-LAIR-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The plunder of many kingdoms lies in a vast, sparkling mound of the type often employed by dragons as a mattress. Luckily, there are no dragons to be seen">
		<COND (<IN? ,URGRUE ,IN-LAIR>
		       <TELL 
"; but the southeast corner of the chamber is obscured by a curious shadow">)>
		<TELL ,PERIOD>
		<COND (<SEE-ANYTHING-IN? ,HEAP>
		       <TELL ,TAB ,YOU-SEE>
		       <CONTENTS ,HEAP>
		       <TELL " lying among the treasures." CR>)>
		<MENTION-BEAM?>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<IN? ,GRUE ,HERE>
		       <REMOVE ,GRUE>)>
		<COND (<IN? ,URGRUE ,IN-LAIR>
		       <UNMAKE ,URGRUE ,SEEN>
		       <MAKE ,URGRUE ,SURPRISED>
		       <SETG P-HIM-OBJECT ,URGRUE>
		       <SETG LAST-MONSTER ,URGRUE>
		       <QUEUE ,I-URGRUE>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<IN? ,URGRUE ,IN-LAIR>
		       <DEQUEUE ,I-URGRUE>
		       <TELL "\"" <PICK-NEXT ,URGRUE-BYES> 
			     "\" chuckles " THE ,URGRUE ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-FROON
	(LOC ROOMS)
	(DESC "Froon")
	(FLAGS LIGHTED LOCATION SEEN)
	(SOUTH <THRU FARM-DOOR IN-FARM>)
	(IN <THRU FARM-DOOR IN-FARM>)
	(GLOBAL FARM-DOOR FARM-WINDOW FARMHOUSE FROON)
	(HEAR 0)
	(SEE-ALL FBEDS)
	(ACTION IN-FROON-F)>

<ROUTINE IN-FROON-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Lullabies sing of places such as this. Songbirds swoop and glide between rows of dainty cottages; a rainbow of flowers lines the sun-dappled street, filling the air with a gentle fragrance" ,PTAB ,XTHE>
		<COND (<IS? ,FARM-DOOR ,OPENED>
		       <TELL B ,W?OPEN>)
		      (T
		       <TELL B ,W?CLOSED>)>
		<TELL C ,SP 'FARMHOUSE
" leans askew upon the roadside. Beneath it, you notice what appears to be the heel of " A ,BOOT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<IN? ,MAYOR ,IN-FROON>
		       <SETG P-HIM-OBJECT ,MAYOR>)>
		<COND (<IN? ,FCROWD ,IN-FROON>
		       <SETG P-THEM-OBJECT ,FCROWD>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<AND <EQUAL? ,P-WALK-DIR ,P?SOUTH ,P?IN>
			    <IS? ,FARM-DOOR ,OPENED>
			    <IN? ,MAYOR ,IN-FROON>
			    <G? ,FSCRIPT 5>>
		       <BYE-MAYOR>
		       <RFATAL>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT INNARDS
	(LOC ROOMS)
	(DESC "Inside Idol")
	(FLAGS LOCATION INDOORS)
	(FNUM OJUNGLE)
	(EXIT-STR "Whoever built this chamber forgot to provide any exits.")
	(ACTION INNARDS-F)>

<ROUTINE INNARDS-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"This long, low chamber is shaped much like the gizzard of a crocodile. Trickles of fetid moisture feed the moss crusting the walls and ceiling." CR> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT APLANE
	(LOC ROOMS)
	(DESC "Ethereal Plane Of Atrii")
	(SDESC DESCRIBE-APLANE)
	(FLAGS LIGHTED LOCATION)
	(NORTH <TABLE 0 APLANE 0>)
	(NE <TABLE 0 APLANE 0>)
	(EAST <TABLE 0 APLANE 0>)
	(SE <TABLE 0 APLANE 0>)
	(SOUTH <TABLE 0 APLANE 0>)
	(SW <TABLE 0 APLANE 0>)
	(WEST <TABLE 0 APLANE 0>)
	(NW <TABLE 0 APLANE 0>)
	(BELOW 0)
	(ACTION APLANE-F)>

<ROUTINE DESCRIBE-APLANE (OBJ)
	 <PRINTD .OBJ>
	 <COND (<IN? ,PLAYER .OBJ>
	        <TELL ", Above " <GET ,OVERS ,ABOVE>>)>
	 <RTRUE>>

<ROUTINE APLANE-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL ,XTHE>
		<COND (<EQUAL? ,ABOVE ,OPLAIN>
		       <TELL "thunderclouds are ">)
		      (T
		       <TELL "landscape is ">)>
		<TELL 
"compressed into a flat optical plane, stretching away below your feet in every " 'INTDIR ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<NEXT-OVER>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-SKY
	(LOC ROOMS)
	(DESC "Flying")
	(SDESC DESCRIBE-IN-SKY)
	(FLAGS LIGHTED LOCATION)
	(NORTH <TABLE 0 IN-SKY 0>)
	(NE <TABLE 0 IN-SKY 0>)
	(EAST <TABLE 0 IN-SKY 0>)
	(SE <TABLE 0 IN-SKY 0>)
	(SOUTH <TABLE 0 IN-SKY 0>)
	(SW <TABLE 0 IN-SKY 0>)
	(WEST <TABLE 0 IN-SKY 0>)
	(NW <TABLE 0 IN-SKY 0>)
	(BELOW 0)
	(FNUM 0)
	(ACTION IN-SKY-F)>

<GLOBAL ABOVE:NUMBER <>>

<ROUTINE DESCRIBE-IN-SKY (OBJ)
	 <TELL "Over " <GET ,OVERS ,ABOVE>>
	 <RTRUE>>

<ROUTINE IN-SKY-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You're soaring on " A ,DACT
		      "'s back, high above " THE ,GROUND ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<NEXT-OVER>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-GARDEN
	(LOC ROOMS)
	(DESC "Royal Garden")
	(FLAGS LIGHTED LOCATION)
      ; (IN <PER ENTER-BUSH>)
	(OUT <PER EXIT-BUSH>)
	(UP <PER EXIT-BUSH>)
	(FNUM OCAVES)
	(GLOBAL GARDEN CASTLE)
	(EXIT-STR "High castle walls block your path.")
	(ACTION IN-GARDEN-F)>

<ROUTINE IN-GARDEN-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're in a private garden, enclosed by the high walls of a castle and guarded by a brooding statue of a brogmoid">
		<COND (<IS? ,BROG ,OPENED>
		       <TELL 
". A secret compartment in " THE ,BROG " is open">
		       <COND (<SEE-ANYTHING-IN? ,BROG>
			      <TELL ", revealing ">
			      <CONTENTS ,BROG>)>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<COND (<IS? ,QUEEN ,NODESC>
		       <SETG PTIMER 0>
		       <QUEUE ,I-QUEEN>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<IN? ,QUEEN ,IN-GARDEN>
		       <REMOVE ,QUEEN>
		       <COND (<IN? ,MIRROR0 ,IN-GARDEN>
			      <DESTROY-MIRROR ,MIRROR0>
			      <DEQUEUE ,I-MIRRORS>)>)>
		<DEQUEUE ,I-QUEEN>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-BEG>
		<COND (<NOT <IN? ,QUEEN ,IN-GARDEN>>
		       <RFALSE>)
		      (<SET X <TALKING?>>
		       <APPROACH-QUEEN "at the sound of your voice">
		       <RFATAL>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT RUIN0
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
        (NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(FNUM ORUINS)
	(GLOBAL PHEEBOR NULL DEBRIS)
	(EXIT-STR "Ruins block your path.")
	(ACTION RUIN-ROOM-F)>

<OBJECT RUIN1
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(FNUM ORUINS)
	(GLOBAL PHEEBOR NULL DEBRIS)
	(EXIT-STR "Ruins block your path.")
	(ACTION RUIN-ROOM-F)>

<OBJECT RUIN2
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(FNUM ORUINS)
	(GLOBAL PHEEBOR NULL DEBRIS)
	(EXIT-STR "Ruins block your path.")
	(ACTION RUIN-ROOM-F)>

<OBJECT RUIN3
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(IN 0)
	(OUT 0)
	(FNUM ORUINS)
	(GLOBAL PHEEBOR NULL DEBRIS)
	(EXIT-STR "Ruins block your path.")
	(ACTION RUIN-ROOM-F)>

<OBJECT RUIN4
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(DNUM 0)
	(IN 0)
	(OUT 0)
	(FNUM ORUINS)
	(GLOBAL PHEEBOR NULL DEBRIS)
	(EXIT-STR "Ruins block your path.")
	(ACTION RUIN-ROOM-F)>

<OBJECT RUIN5
	(LOC ROOMS)
	(DESC "foo")
	(SDESC 0)
	(FLAGS LIGHTED LOCATION)
	(NORTH 0)
	(NE 0)
	(EAST 0)
	(SE 0)
	(SOUTH 0)
	(SW 0)
	(WEST 0)
	(NW 0)
	(IN 0)
	(OUT 0)
	(DNUM 0)
	(GLOBAL PHEEBOR NULL DEBRIS)
	(FNUM ORUINS)
	(EXIT-STR "Ruins block your path.")
	(ACTION RUIN-ROOM-F)>

<ROUTINE RUIN-ROOM-F ("OPT" (CONTEXT <>) "AUX" TBL X)
	 <COND (<NOT <EQUAL? .CONTEXT ,M-ENTERING>>
		<RFALSE>)
	       (<IS? ,HERE ,TOUCHED>
		<RFALSE>)
	       (<AND <NOT <IS? ,PLAZA ,SEEN>>
		     <LAST-ROOM-IN? ,RUIN-ROOMS>>
		<MAKE ,PLAZA ,SEEN>
		<PUTB ,ARCH-ROOMS ,PRESENT ,HERE>
		<REPLACE-GLOBAL? ,HERE ,NULL ,PLAZA>
		<MOVE ,ARCH ,HERE>
		<PUTP ,HERE ,P?SDESC ,DESCRIBE-ARCH7>
		<PUTP ,HERE ,P?ACTION ,ARCH7-F>
		<NEW-EXIT? ,HERE ,P?IN %<+ ,FCONNECT 1 ,MARKBIT> ,ENTER-ARCH>
		<NEW-EXIT? ,HERE ,P?OUT %<+ ,FCONNECT 1 ,MARKBIT> ,EXIT-ARCH>
		<RFALSE>)
	       (T
		<SET TBL <PICK-ONE ,RUIN-DESCS>>
		<PUTP ,HERE ,P?SDESC <GET .TBL 0>>
		<SET X <GET .TBL 1>>
		<PUTP ,HERE ,P?ACTION .X>
		<COND (<EQUAL? .X ,RD3-F>
		       <MOVE ,WEEDS2 ,HERE>)>
		<RFALSE>)>>

<ROUTINE DESCRIBE-ARCH7 (OBJ)
	 <TELL "Plaza">
	 <RTRUE>>

<ROUTINE ARCH7-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"This vast expanse may have served as a public meetingplace in centuries long past. Waves of heat rise from the stone pavement underfoot." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-ARCH-ROOMS? .CONTEXT>>>

<ROUTINE DESCRIBE-RD0 (OBJ)
	 <TELL "Courtyard">
	 <RTRUE>>

<ROUTINE RD0-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Tall pillars of stone once enclosed this circular courtyard. The sad remains lie smashed and scattered at your feet." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-RD1 (OBJ)
	 <TELL "Aqueduct">
	 <RTRUE>>

<ROUTINE RD1-F ("OPT" (CONTEXT <>) "AUX" TBL DIR)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SET DIR ,I-NORTH>
		<REPEAT ()
		   <SET TBL <GETP ,HERE <GETB ,PDIR-LIST .DIR>>>
		   <COND (<ZERO? .TBL>)
			 (<EQUAL? <MSB <GET .TBL ,XTYPE>> ,CONNECT>
			  <RETURN>)>
		   <COND (<IGRTR? DIR ,I-NW>
			  <RETURN>)>>
		<TELL "A boulevard of cracked marble leads "
		      B <GET ,DIR-NAMES .DIR>
" beneath the shadows of a crumbling aqueduct." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-RD2 (OBJ)
	 <TELL "Debris">
	 <RTRUE>>

<ROUTINE RD2-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Alleys strewn with centuries of debris wind between the silent ruins." CR> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-RD3 (OBJ)
	 <TELL "Glare">
	 <RTRUE>>

<ROUTINE RD3-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"The hard glare of sunlight on the windswept ruins is making your eyes water. Weeds are growing between the cracks in the street." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-RD4 (OBJ)
	 <TELL "Dusty Street">
	 <RTRUE>>

<ROUTINE RD4-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A dry, cheerless wind blows dust in your face as you regard the broken facades on every side." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-SPLENDOR
	(LOC ROOMS)
	(DESC "Plane of TransInfinite Splendor")
	(FLAGS LIGHTED LOCATION)
	(NORTH <SORRY "Lush vegetation blocks your path.">)
	(NE <SORRY "Lush vegetation blocks your path.">)
	(EAST <SORRY "Lush vegetation blocks your path.">)
	(SE <SORRY "Lush vegetation blocks your path.">)
	(SOUTH <SORRY "Lush vegetation blocks your path.">)
	(SW <SORRY "Lush vegetation blocks your path.">)
	(WEST <SORRY "Lush vegetation blocks your path.">)
	(NW <SORRY "Lush vegetation blocks your path.">)
	(FNUM 0)
	(ACTION IN-SPLENDOR-F)>

<ROUTINE IN-SPLENDOR-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"An unspoiled landscape of rolling meadows, sparkling streams and orchards bursting with fruit stretches away in every direction. You must be alone here; for no ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "wo">)>
		<TELL 
"man could visit this place and leave it voluntarily." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-BEG>
		<COND (<AND <IN? ,HERD ,IN-SPLENDOR>
			    <SET X <TALKING?>>>
		       <UNICORNS-FLEE "at the sound of your voice">
		       <RFATAL>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<OR <EQUAL? ,P-WALK-DIR <> ,P?IN ,P?OUT>
			   <EQUAL? ,P-WALK-DIR ,P?UP ,P?DOWN>>
		       <RFALSE>)
		      (<IN? ,HERD ,IN-SPLENDOR>
		       <UNICORNS-FLEE>
		       <RFATAL>)>
		<I-ARREST <>>
		<RFATAL>)
	       (T
		<RFALSE>)>>

"*** MAZE SETUP ***"

<ROUTINE SETUP-CELLAR? ()
	 <SCRAMBLE ,CELLAR-ROOMS>
	 <NEXT-WAND? ,DESCRIBE-CELLAR-WAND ,WC1>
	 <QUEUE ,I-RAT>
	 <RTRUE>>

<ROUTINE N-MOOR-S ()
	 <COND (<SETUP-MOOR?>
		<RETURN <GET <GETP ,N-MOOR ,P?SOUTH> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE SW-MOOR-NE ()
	 <COND (<SETUP-MOOR?>
		<RETURN <GET <GETP ,SW-MOOR ,P?NE> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE SETUP-MOOR? ("AUX" RM RM2 RM3 OBJ LEN)
	 <SCRAMBLE ,MOOR-ROOMS>

       ; "Connect N-MOOR to north edge of moor."

	 <SET RM <N-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-MOOR? <1>">
		<RFALSE>)>
	 <NEW-EXIT? .RM ,P?NORTH %<+ ,CONNECT 1 ,MARKBIT> ,N-MOOR>
	 <NEW-EXIT? ,N-MOOR ,P?SOUTH %<+ ,CONNECT 1 ,MARKBIT> .RM>
	 	 
       ; "Connect SW-MOOR to southwest corner of moor."

	 <SET RM <SW-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-MOOR? <2>">
		<RFALSE>)>
	 <NEW-EXIT? .RM ,P?SW %<+ ,CONNECT 5 ,MARKBIT> ,SW-MOOR>
	 <NEW-EXIT? ,SW-MOOR ,P?NE %<+ ,CONNECT 5 ,MARKBIT> .RM>
	 	 
	 <SET LEN <GETB ,MOOR-ROOMS 0>>
	 <SET RM <GETB ,MOOR-ROOMS <RANDOM .LEN>>>
	 <NEXT-SCROLL? ,DESCRIBE-MOOR-SCROLL .RM>
	 
	 <PROG ()
	     <SET RM2 <GETB ,MOOR-ROOMS <RANDOM .LEN>>>
	     <COND (<EQUAL? .RM2 .RM>
		    <AGAIN>)>>
	 <NEXT-POTION? .RM2 ,DESCRIBE-MOOR-POTION>
	 
	 <PROG ()
	     <SET RM3 <GETB ,MOOR-ROOMS <RANDOM .LEN>>>
	     <COND (<EQUAL? .RM3 .RM2 .RM>
		    <AGAIN>)>>
	 <NEXT-WAND? ,DESCRIBE-MOOR-WAND .RM3>
	 <QUEUE ,I-VAPOR>
	 <RTRUE>>

<ROUTINE NW-UNDER-SE ()
	 <COND (<SETUP-JUNGLE?>
		<RETURN <GET <GETP ,NW-UNDER ,P?SE> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE SW-UNDER-NE ()
	 <COND (<SETUP-JUNGLE?>
		<RETURN <GET <GETP ,SW-UNDER ,P?NE> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE SE-UNDER-NW ()
	 <COND (<SETUP-JUNGLE?>
		<RETURN <GET <GETP ,SE-UNDER ,P?NW> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE AT-FALLS-N ()
	 <COND (<SETUP-JUNGLE?>
		<RETURN <GET <GETP ,AT-FALLS ,P?NORTH> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE SETUP-JUNGLE? ("AUX" RM RM2 RM3 LEN)
	 <SCRAMBLE ,JUNGLE-ROOMS>
	 
       ; "Connect NW-UNDER to northwest edge of jungle."

	 <SET RM <NW-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-JUNGLE? <1>">
		<RFALSE>)>
	 <NEW-EXIT? .RM ,P?NW %<+ ,CONNECT 1 ,MARKBIT> ,NW-UNDER>
	 <NEW-EXIT? ,NW-UNDER ,P?SE %<+ ,CONNECT 1 ,MARKBIT> .RM>
	        
       ; "Connect SE-UNDER to southeast edge."
	   
	 <SET RM <SE-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-JUNGLE? <2>">
		<RFALSE>)>
	 <NEW-EXIT? .RM ,P?SE %<+ ,CONNECT 1 ,MARKBIT> ,SE-UNDER>
	 <NEW-EXIT? ,SE-UNDER ,P?NW %<+ ,CONNECT 1 ,MARKBIT> .RM>
	 	 	 
	; "Connect SW-UNDER to southwest edge."

	  <SET RM <SW-ROOM?>>
	; <COND (<ZERO? .RM>
		 <SAY-ERROR "SETUP-JUNGLE? <3>">
		 <RFALSE>)>
	  <NEW-EXIT? .RM ,P?SW %<+ ,CONNECT 1 ,MARKBIT> ,SW-UNDER>
	  <NEW-EXIT? ,SW-UNDER ,P?NE %<+ ,CONNECT 1 ,MARKBIT> .RM>
	  		  
        ; "Connect AT-FALLS to southern edge."

	  <SET RM <S-ROOM?>>
	; <COND (<ZERO? .RM>
		 <SAY-ERROR "SETUP-JUNGLE? <4>">
		 <RFALSE>)>
	  <NEW-EXIT? .RM ,P?SOUTH %<+ ,CONNECT 5 ,MARKBIT> ,AT-FALLS>
	  <NEW-EXIT? ,AT-FALLS ,P?NORTH %<+ ,CONNECT 5 ,MARKBIT> .RM>
          
	  <SET LEN <GETB ,JUNGLE-ROOMS 0>>
	  <PROG ()
	     <SET RM <GETB ,JUNGLE-ROOMS <RANDOM .LEN>>>
	     <COND (<EQUAL? .RM ,JUN0>
		    <AGAIN>)>>
	  <MOVE ,TUSK .RM>
	  
	  <PROG ()
	     <SET RM2 <GETB ,JUNGLE-ROOMS <RANDOM .LEN>>>
	     <COND (<EQUAL? .RM2 .RM ,JUN0>
		    <AGAIN>)>>
	  <NEXT-WAND? ,DESCRIBE-JUNGLE-WAND .RM2>

	  <PROG ()
	     <SET RM3 <GETB ,JUNGLE-ROOMS <RANDOM .LEN>>>
	     <COND (<EQUAL? .RM3 .RM2 .RM ,JUN0>
		    <AGAIN>)>>
	  <NEXT-SCROLL? ,DESCRIBE-JUNGLE-SCROLL .RM3>
	  <QUEUE ,I-CROC>
	  <RTRUE>>

<ROUTINE ENTER-PLAIN-W ()
	 <COND (<SETUP-PLAIN?>
		<RETURN <GET <GETP ,XROADS ,P?EAST> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE ENTER-PLAIN-E ()
	 <COND (<SETUP-PLAIN?>
		<RETURN <GET <GETP ,ON-PIKE ,P?WEST> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE SETUP-PLAIN? ("AUX" RM OBJ LEN)
	 <SETG SCRAMBLE-LENGTH 3>
	 <SCRAMBLE ,PLAIN-ROOMS #2 1110111011101110>
	 <SETG SCRAMBLE-LENGTH 1>

       ; "Connect XROADS to west edge of moor."

	 <SET RM <W-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-PLAIN? <1>">
		<RFALSE>)>
	 <SETG WEST-EXIT .RM>
	 <NEW-EXIT? .RM ,P?WEST %<+ ,CONNECT 13 ,MARKBIT> ,XROADS>
	 <NEW-EXIT? ,XROADS ,P?EAST %<+ ,CONNECT 13 ,MARKBIT> .RM>
	 	 
       ; "Connect ON-PIKE to east edge."

	 <SET RM <E-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-PLAIN? <2>">
		<RFALSE>)>
	 <SETG EAST-EXIT .RM>
	 <NEW-EXIT? .RM ,P?EAST %<+ ,CONNECT 13 ,MARKBIT> ,ON-PIKE>
	 <NEW-EXIT? ,ON-PIKE ,P?WEST %<+ ,CONNECT 13 ,MARKBIT> .RM>
	 
       ; "Connect ROSE-ROOM to north edge."

	 <SET RM <N-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-PLAIN? <3>">
		<RFALSE>)>
	 <NEW-EXIT? .RM ,P?NORTH %<+ ,CONNECT 3 ,MARKBIT> ,ROSE-ROOM>
	 <NEW-EXIT? ,ROSE-ROOM ,P?SOUTH %<+ ,CONNECT 3 ,MARKBIT> .RM>
	 	 
	 <QUEUE ,I-BFLY>
	 <RTRUE>>

<ROUTINE NGURTH-N ()
	 <COND (<SETUP-FOREST?>
		<RETURN <GET <GETP ,NGURTH ,P?NORTH> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE AT-BROOK-WEST ()
	 <COND (<SETUP-FOREST?>
		<RETURN <GET <GETP ,AT-BROOK ,P?WEST> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE SFORD-S ()
	 <COND (<SETUP-FOREST?>
		<RETURN <GET <GETP ,SFORD ,P?SW> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE SETUP-FOREST? ("AUX" LEN RM RM2)
	 <SCRAMBLE ,FOREST-ROOMS>
	 
       ; "Connect NGURTH to south edge of forest."

	 <SET RM <S-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-FOREST? <1>">
		<RFALSE>)>
	 <NEW-EXIT? .RM ,P?SOUTH %<+ ,CONNECT 1 ,MARKBIT> ,NGURTH>
	 <NEW-EXIT? ,NGURTH ,P?NORTH %<+ ,CONNECT 1 ,MARKBIT> .RM>

       ; "Connect SFORD to northeast edge of forest."

	 <SET RM <NE-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-FOREST? <2>">
		<RFALSE>)>
	 <NEW-EXIT? .RM ,P?NE %<+ ,CONNECT 1 ,MARKBIT> ,SFORD>
	 <NEW-EXIT? ,SFORD ,P?SW %<+ ,CONNECT 1 ,MARKBIT> .RM>
       
       ; "Connect AT-BROOK to east side of forest."

	 <SET RM <E-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-FOREST? <3>">
		<RFALSE>)>
	 <NEW-EXIT? .RM ,P?EAST %<+ ,CONNECT 9 ,MARKBIT> ,AT-BROOK>
	 <NEW-EXIT? ,AT-BROOK ,P?WEST %<+ ,CONNECT 9 ,MARKBIT> .RM>
	 
	 <SET LEN <GETB ,FOREST-ROOMS 0>>
	 <SET RM <GETB ,FOREST-ROOMS <RANDOM .LEN>>>
	 <NEXT-SCROLL? ,DESCRIBE-FOREST-SCROLL .RM>
	 
	 <PROG ()
	    <SET RM2 <GETB ,FOREST-ROOMS <RANDOM .LEN>>>
	    <COND (<EQUAL? .RM2 .RM>
		   <AGAIN>)>>
	 <NEXT-WAND? ,DESCRIBE-FOREST-WAND .RM2>
	 
	 <QUEUE ,I-PUPP>
	 <RTRUE>>

<ROUTINE NFORD-NE ()
	 <COND (<SETUP-RUINS?>
		<RETURN <GET <GETP ,NFORD ,P?NE> ,XROOM>>)>
	 <RFALSE>>

<ROUTINE SETUP-RUINS? ("AUX" RM)
	 <SCRAMBLE ,RUIN-ROOMS #2 1110111011101110>
	 
	 <SET RM <SW-ROOM?>>
       ; <COND (<ZERO? .RM>
		<SAY-ERROR "SETUP-RUINS? <1>">
		<RFALSE>)>
	 <NEW-EXIT? .RM ,P?SW %<+ ,CONNECT 1 ,MARKBIT> ,NFORD>
	 <NEW-EXIT? ,NFORD ,P?NE %<+ ,CONNECT 1 ,MARKBIT> .RM>
	 
	 <SET RM <GETB ,RUIN-ROOMS <RANDOM <GETB ,RUIN-ROOMS 0>>>>
	 <NEXT-POTION? .RM ,DESCRIBE-RUINS-POTION>
	 
	 <QUEUE ,I-GHOUL>
	 <RTRUE>>

<ROUTINE SETUP-CAVES? ("AUX" RM)
	 <SCRAMBLE ,CAVE-ROOMS #2 1010101010101010>
	 
	 <SET RM <SE-ROOM?>>
	 <NEW-EXIT? .RM ,P?SE %<+ ,CONNECT 1> ,CAVE7>
	 <NEW-EXIT? ,CAVE7 ,P?NW %<+ ,CONNECT 1> .RM>
	 <NEW-EXIT? ,CAVE7 ,P?IN %<+ ,CONNECT 1> .RM>
	 
	 <SET RM <NE-ROOM?>>
	 <NEW-EXIT? .RM ,P?NE %<+ ,CONNECT 1> ,NE-CAVE>
	 <NEW-EXIT? ,NE-CAVE ,P?SW %<+ ,CONNECT  1> .RM>
	 <NEW-EXIT? ,NE-CAVE ,P?IN %<+ ,CONNECT 1> .RM>
	 
	 <SET RM <W-ROOM?>>
	 <NEW-EXIT? ,IN-LAIR ,P?NE %<+ ,CONNECT 1> .RM>
	 <NEW-EXIT? .RM ,P?SW %<+ ,CONNECT 1> ,IN-LAIR>
	 
	 <MAKE ,SE-CAVE ,SEEN>
	 <MAKE ,NE-CAVE ,SEEN>
	 <NEXT-SUCKER ,ASUCKER>
	 <QUEUE ,I-ASUCKER>
	 <QUEUE ,I-GRUE>
	 <RTRUE>>

"*** THE MAZE MACHINE ***"

<GLOBAL GOOD-DIRS:TABLE <ITABLE 16>>
<GLOBAL LAST-CONNECTION:NUMBER -1>

<ROUTINE SCRAMBLE (RTBL "OPT" MASK "AUX" HOME LEN RM NXT X)
	 <COPYT ,DEFAULT-BORDERS ,BORDERS 50> ; "Reset room borders."
       	 <COND (<ASSIGNED? MASK>
		<SET LEN 24>
		<REPEAT ()
		   <PUT ,BORDERS .LEN <BAND <GET ,BORDERS .LEN> .MASK>>
		   <COND (<DLESS? LEN 0>
			  <RETURN>)>>
		<PUTB ,BORDERS 0 49>)>
	 	 
	 <SET LEN <GETB .RTBL 0>>
	 <SET HOME <GETB .RTBL 1>> ; "HOME starts at 1st list element."
	 	 
       ; "Make MAZE-ROOMS a PICK-ONE table, excluding HOME."

	 <SET X .LEN>
	 <REPEAT ()
	    <PUT ,MAZE-ROOMS .X <GETB .RTBL .X>>
	    <COND (<DLESS? X 2>
		   <RETURN>)>>
	 <PUT ,MAZE-ROOMS 1 0>
	 <PUT ,MAZE-ROOMS 0 .LEN>
	 
       ; "Make AUX-TABLE a PICK-NEXT table."

	 <INC LEN>
	 <PUT ,AUX-TABLE 0 .LEN>
	 <PUT ,AUX-TABLE 1 3> ; "Skip over HOME."
	 <PUT ,AUX-TABLE 2 .HOME>
	 <REPEAT ()
	    <PUT ,AUX-TABLE .LEN <PICK-ONE ,MAZE-ROOMS>>
	    <COND (<DLESS? LEN 3>
		   <RETURN>)>>
	 	 	 
	 <COPYT ,MAZE-ROOMS 0 51> ; "Reset." 
	 
	 <UNMAKE .HOME ,TOUCHED>
	 <PUTP .HOME ,P?DNUM 25> ; "Always start @ center(?)"
	 <PUTB ,MAZE-ROOMS 25 .HOME>	 
	 
       ; <COND (<AND <T? ,MAZING>
		     <T? ,DEBUG>>
		<TELL "[SCRAMBLE homes " D .HOME " to " N .X>
	        <PAUSE>)>
	 
	 <REPEAT ()
	    <SETG LAST-CONNECTION -1>
	    <CLEAR-MAPBITS .RTBL>
	    <SET RM .HOME>
	    <MAKE .HOME ,MAPPED>
	    <REPEAT ()
	       <SET NXT <NEXT-ROOM? .RM>>
	       <COND (<ZERO? .NXT>
		      <SET HOME <NEW-HOME? .HOME>>
		    ; <COND (<ZERO? .HOME>
			     <SAY-ERROR "SCRAMBLE">
			     <RFALSE>)>
		      <RETURN>)
		     (<EQUAL? <GET ,AUX-TABLE 1> 2> ; "No more?"
		      <CLEAR-MAPBITS .RTBL>
		      <RFALSE>)
		     (<EQUAL? .NXT .HOME>
		      <AGAIN>)
		     (<IS? .NXT ,MAPPED>
		      <SET HOME .NXT>
		      <RETURN>)>
	       <MAKE .NXT ,MAPPED>
	       <SET RM .NXT>>>>
		 		     
<ROUTINE CLEAR-MAPBITS (TBL "AUX" LEN)
	 <SET LEN <GETB .TBL 0>>
	 <REPEAT ()
	    <UNMAKE <GETB .TBL .LEN> ,MAPPED>
	    <COND (<DLESS? LEN 1>
		   <RFALSE>)>>>

<ROUTINE NEW-HOME? (RM "AUX" DIR CNT TBL)
	 <SET CNT 1>
	 <SET DIR ,P?NW>
	 <REPEAT ()
	    <SET TBL <GETP .RM .DIR>>
	    <COND (<T? .TBL>
		   <INC CNT>
		   <PUT ,GOOD-DIRS .CNT <GET .TBL ,XROOM>>)>
	    <COND (<IGRTR? DIR ,P?NORTH>
		   <RETURN>)>>
	 <COND (<EQUAL? .CNT 1> ; "No exits left, so scram."
		<RFALSE>)
	       (<EQUAL? .CNT 2> ; "Save time if only 1 DIR found."
		<RETURN <GET ,GOOD-DIRS 2>>)>
	 <PUT ,GOOD-DIRS 0 .CNT> ; "Setup a PICK-ONE table."
	 <PUT ,GOOD-DIRS 1 0>
	 <RETURN <PICK-ONE ,GOOD-DIRS>>>

<GLOBAL SCRAMBLE-LENGTH:NUMBER 1>

<ROUTINE NEXT-ROOM? (RM "AUX" (DIR 0) (DIAG 0)
		     	      PATH-LEN CNT BITS RNUM NRM NRNUM X LEN TBL)
	 <SET RNUM <GETP .RM ,P?DNUM>> ; "Get position in matrix."
	 <COND (<ZERO? .RNUM>
		<RFALSE>)>
	 <SET BITS <GETB ,BORDERS .RNUM>> ; "Get cell borders."
	 
       ; "Make a list of adjoining cells with accessible rooms."

	 <SET CNT 1>
	 <REPEAT ()
	    <COND (<BTST .BITS <GETB ,DBIT-LIST .DIR>> ; "Accessible?"
		   <SET X <+ .RNUM <GET ,DIR-HACKS .DIR>>>
		   <COND (<GETB ,MAZE-ROOMS .X> ; "Is there a room?"
			  <INC CNT>
			  <PUT ,GOOD-DIRS .CNT .DIR>)>)>
	    <COND (<IGRTR? DIR 7>
		   <RETURN>)>>
	 <COND (<EQUAL? .CNT 1> ; "No adjoining rooms found."
		
	      ; "Make a list of all accessible directions."

		<SET DIR 0>
		<REPEAT ()
		   <COND (<BTST .BITS <GETB ,DBIT-LIST .DIR>> ; "Access?"
			  <COND (<NOT <GETP .RM <GETB ,PDIR-LIST .DIR>>>
				 <INC CNT>
				 <PUT ,GOOD-DIRS .CNT .DIR>)>)>
		   <COND (<IGRTR? DIR 7>
			  <RETURN>)>>
		<COND (<EQUAL? .CNT 1> ; "No exits left, so scram."
		       <RFALSE>)
		      (<EQUAL? .CNT 2> ; "Save time if only 1 DIR found."
		       <SET DIR <GET ,GOOD-DIRS 2>>)
		      (T
		       <PUT ,GOOD-DIRS 0 .CNT> ; "Setup a PICK-ONE table."
		       <PUT ,GOOD-DIRS 1 0>
		       <REPEAT ()
			  <SET DIR <PICK-ONE ,GOOD-DIRS>>
			  <COND (<NOT <EQUAL? .DIR ,LAST-CONNECTION>>
				 <RETURN>)>>)>)
	       (<EQUAL? .CNT 2> ; "Save time if only 1 DIR found."
		<SET DIR <GET ,GOOD-DIRS 2>>)
	       (T
		<PUT ,GOOD-DIRS 0 .CNT> ; "Setup a PICK-ONE table."
		<PUT ,GOOD-DIRS 1 0>
		<REPEAT ()
		   <SET DIR <PICK-ONE ,GOOD-DIRS>>
		   <COND (<NOT <EQUAL? .DIR ,LAST-CONNECTION>>
			  <RETURN>)>>)>
	 
	 <SETG LAST-CONNECTION .DIR>
	 <SET NRNUM <+ .RNUM <GET ,DIR-HACKS .DIR>>> ; "Calc new room ID."
       
	 <COND (<BTST .DIR 1> ; "Handle diagonal paths."
		<INC DIAG>
		<KILL-DIAGONAL .RNUM .DIR>)>
	 
	 <SET PATH-LEN ,SCRAMBLE-LENGTH>
	 <REPEAT ()
	    <SET X <CAN-EXTEND? .NRNUM .DIR>>
	    <COND (<ZERO? .X>
		   <RETURN>)
		  (<PROB 67>
		   <RETURN>)
		  (<T? .DIAG>
		   <KILL-DIAGONAL .NRNUM .DIR>)>
	    <EXTEND .NRNUM .DIR>
	    <SET PATH-LEN <+ .PATH-LEN 2>>
	    <SET NRNUM .X>>
	 
	 <SET NRM <GETB ,MAZE-ROOMS .NRNUM>>
	 <COND (<ZERO? .NRM>
		<SET NRM <PICK-NEXT ,AUX-TABLE>> ; "Pick next room in chain."
	        <PUTP .NRM ,P?DNUM .NRNUM>
		<PUTB ,MAZE-ROOMS .NRNUM .NRM>)>	 	 
	 
       ; "Install the exit."

	 <SET LEN <+ ,CONNECT .PATH-LEN>>
	 <NEW-EXIT? .RM <GETB ,PDIR-LIST .DIR> .LEN .NRM>
	 <PUTB ,BORDERS .RNUM <BAND .BITS <GETB ,XDBIT-LIST .DIR>>>
	 	 
	 <SET DIR <+ .DIR 4>>
	 <COND (<G? .DIR 7>
		<SET DIR <- .DIR 8>>)> ; "Mirror the exit."
	 
	 <NEW-EXIT? .NRM <GETB ,PDIR-LIST .DIR> .LEN .RM>
	 	 	 
	 <SET BITS <GETB ,BORDERS .NRNUM>>
	 <PUTB ,BORDERS .NRNUM <BAND .BITS <GETB ,XDBIT-LIST .DIR>>>
	 
	 <RETURN .NRM>>

<ROUTINE CAN-EXTEND? (RNUM DIR "AUX" (CNT 0) XDIR X BITS)
	 <SET XDIR <+ .DIR 4>>
	 <COND (<G? .XDIR 7>
		<SET XDIR <- .XDIR 8>>)> ; "Establish opposite DIR."
	 
       ; "ALL directions must be available to win."

	 <REPEAT ()
	    <COND (<EQUAL? .CNT .XDIR>)
		  (<NOT <BTST .BITS <GETB ,DBIT-LIST .CNT>>>
		   <RFALSE>)>
	    <COND (<IGRTR? CNT 7>
		   <RETURN>)>>
	 <RETURN <+ .RNUM <GET ,DIR-HACKS .DIR>>>>
			
<ROUTINE EXTEND (RNUM DIR "AUX" (CNT 0) XRNUM XDIR BITS LIST)
	 <PUTB ,BORDERS .RNUM 0> ; "Forbid all future access."
	 <SET LIST <REST ,XDBIT-LIST 4>>
	 <SET XDIR <+ .DIR 4>>
	 <COND (<G? .XDIR 7>
		<SET XDIR <- .XDIR 8>>)>
	
      ; "Close off all adjacent rooms."

	 <REPEAT ()
	   <COND (<NOT <EQUAL? .CNT .DIR .XDIR>>
		  <SET XRNUM <+ .RNUM <GET ,DIR-HACKS .CNT>>>
		  <SET BITS <GETB ,BORDERS .XRNUM>>
		  <PUTB ,BORDERS .XRNUM <BAND .BITS <GETB .LIST .CNT>>>)>
	   <COND (<IGRTR? CNT 7>
		  <RFALSE>)>>>
		       
<ROUTINE KILL-DIAGONAL (RNUM DIR "AUX" (CNT 0) BITS XDIR XRNUM XBITS)
  <SET BITS <GETB ,BORDERS .RNUM>>
  <SET DIR </ .DIR 2>>
  <REPEAT ()
      <SET XRNUM <+ .RNUM <GET ,DIR-HACKS <GETB <REST ,QDIRS .CNT> .DIR>>>>
      <SET XDIR <GETB <REST ,ZDIRS <+ .CNT .CNT>> .DIR>>
      <SET XBITS <GETB ,XDBIT-LIST .XDIR>>
      <PUTB ,BORDERS .XRNUM <BAND <GETB ,BORDERS .XRNUM> .XBITS>>
      <COND (<IGRTR? CNT 1>
	     <RFALSE>)>>>

"Find northernmost room in maze."

<ROUTINE N-ROOM? ("AUX" ROW OFFSET RM)
	 <SET ROW 4>
	 <REPEAT ()
	    <SET RM <GETB ,MAZE-ROOMS .ROW>>
	    <COND (<T? .RM>
		   <RETURN .RM>)>
	    <SET OFFSET 1>
	    <REPEAT ()
	       <SET RM <GETB ,MAZE-ROOMS <+ .ROW .OFFSET>>>
	       <COND (<T? .RM>
		      <RETURN .RM>)>
	       <SET RM <GETB ,MAZE-ROOMS <- .ROW .OFFSET>>>
	       <COND (<T? .RM>
		      <RETURN .RM>)
		     (<IGRTR? OFFSET 3>
		      <RETURN>)>>
	    <SET ROW <+ .ROW 7>>
	    <COND (<G? .ROW 46>
		   <RETURN>)>>
       ; <SAY-ERROR "N-ROOM?">
	 <RFALSE>>

"Find southernmost room in maze."

<ROUTINE S-ROOM? ("AUX" ROW OFFSET RM)
	 <SET ROW 46>
	 <REPEAT ()
	    <SET RM <GETB ,MAZE-ROOMS .ROW>>
	    <COND (<T? .RM>
		   <RETURN .RM>)>
	    <SET OFFSET 1>
	    <REPEAT ()
	       <SET RM <GETB ,MAZE-ROOMS <+ .ROW .OFFSET>>>
	       <COND (<T? .RM>
		      <RETURN .RM>)>
	       <SET RM <GETB ,MAZE-ROOMS <- .ROW .OFFSET>>>
	       <COND (<T? .RM>
		      <RETURN .RM>)
		     (<IGRTR? OFFSET 3>
		      <RETURN>)>>
	    <SET ROW <- .ROW 7>>
	    <COND (<L? .ROW 4>
		   <RETURN>)>>
       ; <SAY-ERROR "S-ROOM?">
	 <RFALSE>>

"Find westernmost room in maze."

<ROUTINE W-ROOM? ("AUX" COL OFFSET RM)
	 <SET COL 22>
	 <REPEAT ()
	    <SET RM <GETB ,MAZE-ROOMS .COL>>
	    <COND (<T? .RM>
		   <RETURN .RM>)>
	    <SET OFFSET 7>
	    <REPEAT ()
	       <SET RM <GETB ,MAZE-ROOMS <+ .COL .OFFSET>>>
	       <COND (<T? .RM>
		      <RETURN .RM>)>
	       <SET RM <GETB ,MAZE-ROOMS <- .COL .OFFSET>>>
	       <COND (<T? .RM>
		      <RETURN .RM>)>		       
	       <SET OFFSET <+ .OFFSET 7>>
	       <COND (<G? .OFFSET 21>
		      <RETURN>)>>
	    <COND (<IGRTR? COL 28>
		   <RETURN>)>>
       ; <SAY-ERROR "W-ROOM?">
	 <RFALSE>>

"Find easternmost room in maze."

<ROUTINE E-ROOM? ("AUX" COL OFFSET RM)
	 <SET COL 28>
	 <REPEAT ()
	    <SET RM <GETB ,MAZE-ROOMS .COL>>
	    <COND (<T? .RM>
		   <RETURN .RM>)>
	    <SET OFFSET 7>
	    <REPEAT ()
	       <SET RM <GETB ,MAZE-ROOMS <+ .COL .OFFSET>>>
	       <COND (<T? .RM>
		      <RETURN .RM>)>
	       <SET RM <GETB ,MAZE-ROOMS <- .COL .OFFSET>>>
	       <COND (<T? .RM>
		      <RETURN .RM>)>		       
	       <SET OFFSET <+ .OFFSET 7>>
	       <COND (<G? .OFFSET 21>
		      <RETURN>)>>
	    <COND (<DLESS? COL 22>
		   <RETURN>)>>
       ; <SAY-ERROR "E-ROOM?">
	 <RFALSE>>

"Find northwesternmost room in maze."

<ROUTINE NW-ROOM? ("AUX" COL PTR X I RM)
	 <SET COL 1>
	 <REPEAT ()
	    <SET X .COL>
	    <SET PTR .COL>
	    <REPEAT ()
	       <SET RM <GETB ,MAZE-ROOMS .PTR>>
	       <COND (<T? .RM>
		      <RETURN .RM>)
		     (<DLESS? X 1>
		      <RETURN>)>
	       <SET PTR <+ .PTR 6>>>
	    <COND (<IGRTR? COL 7>
		   <RETURN>)>>
       ; <SAY-ERROR "NW-ROOM?">
	 <RFALSE>>

"Find northeasternmost room in maze."

<ROUTINE NE-ROOM? ("AUX" COL PTR X I RM)
	 <SET COL 7>
	 <SET I 1>
	 <REPEAT ()
	    <SET PTR .COL>
	    <SET X .I>
	    <REPEAT ()
	       <SET RM <GETB ,MAZE-ROOMS .PTR>>
	       <COND (<T? .RM>
		      <RETURN .RM>)
		     (<DLESS? X 1>
		      <RETURN>)>
	       <SET PTR <+ .PTR 8>>>
	    <INC I>
	    <COND (<DLESS? COL 1>
		   <RETURN>)>>
       ; <SAY-ERROR "NE-ROOM?">
	 <RFALSE>>

"Find southwesternmost room in maze."

<ROUTINE SW-ROOM? ("AUX" COL PTR X RM)
	 <SET COL 1>
	 <REPEAT ()
	    <SET X .COL>
	    <SET PTR <+ .COL 42>>
	    <REPEAT ()
	       <SET RM <GETB ,MAZE-ROOMS .PTR>>
	       <COND (<T? .RM>
		      <RETURN .RM>)
		     (<DLESS? X 1>
		      <RETURN>)>
	       <SET PTR <- .PTR 8>>>
	    <COND (<IGRTR? COL 7>
		   <RETURN>)>>
       ; <SAY-ERROR "SW-ROOM?">
	 <RFALSE>>

"Find southeasternmost room in maze."

<ROUTINE SE-ROOM? ("AUX" COL PTR X I RM)
	 <SET COL 7>
	 <SET I 1>
	 <REPEAT ()
	    <SET PTR <+ .COL 42>>
	    <SET X .I>
	    <REPEAT ()
	       <SET RM <GETB ,MAZE-ROOMS .PTR>>
	       <COND (<T? .RM>
		      <RETURN .RM>)
		     (<DLESS? X 1>
		      <RETURN>)>
	       <SET PTR <- .PTR 6>>>
	    <INC I>
	    <COND (<DLESS? COL 1>
		   <RETURN>)>>
       ; <SAY-ERROR "SE-ROOM?">
	 <RFALSE>>	 

















	       
	 

		   
		   


			


	
