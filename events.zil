"EVENTS for BEYOND ZORK:
 Copyright (C)1987 Infocom, Inc. All rights reserved."

<CONSTANT MAX-LAMP-LIFE 100>
<GLOBAL LAMP-LIFE:NUMBER 20>

<ROUTINE I-LANTERN ("AUX" V)
	 <SET V <VISIBLE? ,LANTERN>>
	 <COND (<DLESS? LAMP-LIFE 1>
		<SETG LAMP-LIFE 0>
		<DEQUEUE ,I-LANTERN>
		<UNMAKE ,LANTERN ,LIGHTED>
		<REPLACE-ADJ? ,LANTERN ,W?LIGHTED ,W?DARK>
		<COND (<ZERO? .V>
		       <RFALSE>)>
		<SETG P-IT-OBJECT ,LANTERN>
		<TELL "  The " 'LANTERN
		      "'s light flickers and goes out." CR>
		<SAY-IF-HERE-LIT>
		<RTRUE>)
	       (<ZERO? .V>
		<RFALSE>)
	       (<EQUAL? ,LAMP-LIFE 20>
		<SETG P-IT-OBJECT ,LANTERN>
		<TELL "  The light from the " 'LANTERN
		      " is getting dimmer." CR>
		<RTRUE>)
	       (<EQUAL? ,LAMP-LIFE 10>
		<SETG P-IT-OBJECT ,LANTERN>
		<TELL "  The " 'LANTERN "'s glow is fading rapidly." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<CONSTANT DOOR-CRASHER 30> "Strength required to break open a door."

"Returns a direction for a monster to move, -1 if none."
	 	 		
<ROUTINE I-CRAB ("AUX" L DIR TBL DEST DAMAGE)
	 <SET L <LOC ,CRAB>>
	 <COND (<EQUAL? .L ,HERE>
		<COND (<L? <GETP ,CRAB ,P?ENDURANCE> 1>
		       <TELL ,TAB 
"Something falls to your feet with a ">
		       <ITALICIZE "plink">
		       <TELL ,COMMA-AND>
		       <COND (<ZERO? ,LIT?>
			      <TELL "a shadow">)
			     (T
			      <TELL THE ,CRAB>)>
		       <PRINT " retreats into the ">
		       <TELL "darkness." CR>
		       <KILL-MONSTER ,CRAB>
		       <MOVE ,CROWN ,HERE>
		       <SETG P-IT-OBJECT ,CROWN>
		       <RTRUE>)
		      (<IS? ,CRAB ,SURPRISED>
		       <SEE-MONSTER ,CRAB>
		       <COND (<NOT <IS? ,CRAB ,SLEEPING>>
			      <TELL ,TAB>
			      <COND (<ZERO? ,LIT?>
				     <DARK-MOVES>
				     <RTRUE>)>
			      <COND (<AND <HERE? THRONE-ROOM>
					  <NOT <IS? ,CRAB ,TOUCHED>>>
				     <MAKE ,CRAB ,TOUCHED>
				     <TELL CTHE ,CRAB
"'s antennae snap to alert as you enter. He rises from " THE ,THRONE
" and charges across " THE ,FLOOR ", claws snapping with anticipation!" CR>
				     <RTRUE>)>
			      <WHIRLS ,CRAB>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,CRAB>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,CRAB>>
		<TELL ,TAB>
		<COND (<T? .DAMAGE>
		       <COND (<ZERO? ,LIT?>
			      <TELL "Something pinches you">)
			     (T
			      <TELL CTHE ,CRAB <PICK-NEXT ,CRAB-ATTACKS>>)>
		       <OUCH ,CRAB .DAMAGE>
		       <RTRUE>)
		      (<ZERO? ,LIT?>
		       <DARK-MOVES>
		       <RTRUE>)>
		<TELL CTHE ,CRAB <PICK-NEXT ,CRAB-MISSES> ,PERIOD>
		<RTRUE>)>
       
	 <SET DIR <MOVE-MONSTER? ,CRAB>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<ZERO? ,LIT?>
		       <TELL ,YOU-HEAR B ,W?SOMETHING>
		       <COND (<IS? ,CRAB ,SEEN>
			      <TELL " else">)>
		       <TELL " scuttle ">)
		      (T
		       <COND (<IS? ,CRAB ,SEEN>
			      <TELL ,XTHE>)
			     (T
			      <TELL ,XA>)>
		       <TELL D ,CRAB " scuttles ">)>
		<MAKE ,CRAB ,SEEN>
		<PASSAGE .DIR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE PASSAGE (DIR)
	 <TELL "in from the " B .DIR " passage!" CR>
	 <RTRUE>>

<ROUTINE I-RAT ("AUX" L DIR TBL DEST DAMAGE)
	 <SET L <LOC ,RAT>>
	 <COND (<EQUAL? .L ,HERE>
		<COND (<L? <GETP ,RAT ,P?ENDURANCE> 1>
		       <TELL ,TAB>
		       <COND (<ZERO? ,LIT?>
			      <TELL ,YOU-HEAR B ,W?SOMETHING " retreat">)
			     (T
			      <TELL "Mortally wounded, " THE ,RAT 
				    " retreats">)>
		       <TELL " into the darkness." CR>
		       <KILL-MONSTER ,RAT>
		       <RTRUE>)
		      (<IS? ,RAT ,SURPRISED>
		       <SEE-MONSTER ,RAT>
		       <COND (<NOT <IS? ,RAT ,SLEEPING>>
			      <TELL ,TAB>
			      <COND (<ZERO? ,LIT?>
				     <DARK-MOVES>
				     <RTRUE>)>
			      <WHIRLS ,RAT>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,RAT>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,RAT>>
		<TELL ,TAB>
		<COND (<T? .DAMAGE>
		       <COND (<ZERO? ,LIT?>
			      <TELL "Something bites you">)
			     (T
			      <TELL CTHE ,RAT <PICK-NEXT ,RAT-ATTACKS>>)>
		       <OUCH ,RAT .DAMAGE>
		       <RTRUE>)
		      (<ZERO? ,LIT?>
		       <DARK-MOVES>
		       <RTRUE>)>
		<TELL CTHE ,RAT <PICK-NEXT ,RAT-MISSES> ,PERIOD>
		<RTRUE>)>
	 <SET DIR <MOVE-MONSTER? ,RAT>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<ZERO? ,LIT?>
		       <TELL ,YOU-HEAR B ,W?SOMETHING " scurry ">)
		      (T
		       <COND (<IS? ,RAT ,SEEN>
			      <TELL ,XTHE>)
			     (T
			      <TELL ,XA>)>
		       <TELL D ,RAT " scurries ">)>
		<MAKE ,RAT ,SEEN>
		<PASSAGE .DIR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE I-SNIPE ("AUX" L DIR TBL DEST DAMAGE)
	 <SET L <LOC ,SNIPE>>
	 <COND (<EQUAL? .L ,HERE>
		<COND (<L? <GETP ,SNIPE ,P?ENDURANCE> 1>
		       <TELL ,TAB "Battered beyond endurance, " THE ,SNIPE>
		       <PRINT " retreats into the ">
		       <TELL "fog." CR>
		       <KILL-MONSTER ,SNIPE>
		       <RTRUE>)
		      (<IS? ,SNIPE ,SURPRISED>
		       <SEE-MONSTER ,SNIPE>
		       <COND (<NOT <IS? ,SNIPE ,SLEEPING>>
			      <TELL ,TAB>
			      <WHIRLS ,SNIPE>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,SNIPE>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,SNIPE>>
		<TELL ,TAB CTHE ,SNIPE>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,SNIPE-HITS>>
		       <OUCH ,SNIPE .DAMAGE>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,SNIPE-MISSES> ,PERIOD>
		<RTRUE>)>
	 <SET DIR <MOVE-MONSTER? ,SNIPE>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<IS? ,SNIPE ,SEEN>
		       <TELL ,XTHE>)
		      (T
		       <TELL ,XA>)>
		<MAKE ,SNIPE ,SEEN>
		<TELL D ,SNIPE " streaks out of the mist!" CR>
		<TOPPLED? ,SNIPE>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE I-VAPOR ("AUX" L DIR DAMAGE)
	 <SET L <LOC ,VAPOR>>
	 <COND (<EQUAL? .L ,HERE>
		<COND (<L? <GETP ,VAPOR ,P?ENDURANCE> 1>
		       <TELL ,TAB CTHE ,VAPOR>
		       <PRINT " disappears in a spectral flash">
		       <TELL ,PERIOD>
		       <NEXT-MONSTER ,SNIPE>
		       <KILL-MONSTER ,VAPOR>
		       <RTRUE>)
		      (<IS? ,VAPOR ,SURPRISED>
		       <SEE-MONSTER ,VAPOR>
		       <TELL ,TAB CTHE ,VAPOR
			     " giggles when it sees you." CR>
		       <TOPPLED? ,VAPOR>
		       <RTRUE>)
		      (<TOPPLED? ,VAPOR>
		       <RTRUE>)>
	        <NEXT-ENDURANCE? ,VAPOR>
		<COND (<AND <PROB 50>
			    <VAPOR-SNATCH?>>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,VAPOR>>
		<TELL ,TAB CTHE ,VAPOR>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,VAPOR-TICKLES> C ,PER>
		       <COND (<ZERO? ,STATIC>
			      <TELL " \"" <PICK-NEXT ,VAPOR-SNEERS>
				    "!\"">)>
		       <CRLF>
		       <UPDATE-STAT <MSPARK? ,VAPOR .DAMAGE>>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,VAPOR-DOINGS>>
		<COND (<PROB 50>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<TELL ". \"" <PICK-NEXT ,VAPOR-SNEERS> "!\"" CR>
		<RTRUE>)>
	 <SET DIR <MOVE-MONSTER? ,VAPOR>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<IS? ,VAPOR ,SEEN>
		       <TELL ,XTHE>)
		      (T
		       <TELL "Without warning, an ">)>
		<MAKE ,VAPOR ,SEEN>
		<TELL D ,VAPOR " coalesces out of the surrounding mist">
		<COND (<PROB 50>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<TELL ". \"" <PICK-NEXT ,VAPOR-SNEERS> "!\"" CR>
		<TOPPLED? ,VAPOR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE VAPOR-SNATCH? ("AUX" (ANY 0) OBJ NXT RM LEN X)
	 <SET LEN <GETB ,MOOR-ROOMS 0>>
	 <COND (<SET OBJ <FIRST? ,PLAYER>>
		<REPEAT ()
		  <SET NXT <NEXT? .OBJ>>
		  <COND (<IS? .OBJ ,NODESC>)
			(<OR <IS? .OBJ ,WIELDED>
			     <IS? .OBJ ,WORN>>	
			 <COND (<ZERO? .ANY>
				<TELL ,TAB CTHE ,VAPOR " tries to snatch ">
				<SAY-YOUR .OBJ>
				<TELL " from your grasp, ">
				<COND (<PROB 50>
				       <TELL "and nearly succeeds">)
				      (T
				       <TELL "but fails">)>
				<COND (<PROB 50>
				       <TELL ,PERIOD>
				       <RTRUE>)>
				<INC ANY>)>)
			(<IS? .OBJ ,TAKEABLE>
			 <PROG ()
			    <SET RM <GETB ,MOOR-ROOMS <RANDOM .LEN>>>
			    <COND (<EQUAL? .RM ,HERE>
				   <AGAIN>)>>
		         <UNMAKE .OBJ ,WORN>
			 <UNMAKE .OBJ ,WIELDED>
			 <MOVE .OBJ .RM>
			 <MOVE ,VAPOR .RM>
			 <MAKE ,VAPOR ,SURPRISED>
			 <SETG LAST-MONSTER <FIND-IN? ,HERE ,MONSTER>>
			 <SETG LAST-MONSTER-DIR <>>
			 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
			 <WINDOW ,SHOWING-ALL>
			 <COND (<T? .ANY>
				<TELL ". Instead, it encircles ">)
			       (T
				<TELL ,TAB 
<PICK-NEXT ,VAPOR-LAUGHS> ", " THE ,VAPOR " snatches ">)>
			 <SAY-YOUR .OBJ>
			 <TELL " and spirits it away!" CR>
			 <RTRUE>)>
		  <SET OBJ .NXT>
		  <COND (<ZERO? .OBJ>
			 <RETURN>)>>)>
	 <COND (<T? .ANY>
		<TELL ,PERIOD>
		<RTRUE>)>
	 <SET X <GET ,STATS ,LUCK>>
	 <COND (<L? .X 2>)
	       (<PROB .X>
		<RFALSE>)>
	 <PROG ()
	    <SET RM <GETB ,MOOR-ROOMS <RANDOM .LEN>>>
	    <COND (<EQUAL? .RM ,HERE>
		   <AGAIN>)>>
	 <MAKE ,VAPOR ,SURPRISED>
	 <TELL ,TAB <PICK-NEXT ,VAPOR-LAUGHS> ", " THE ,VAPOR
 " grabs you by the ankles and lifts you high into the air!" CR>
	 <COND (<T? ,VERBOSITY>
		<CRLF>)>
	 <GOTO .RM>
	 <SET X <GET ,STATS ,ENDURANCE>>
	 <COND (<G? .X 5>
		<SET X -5>)
	       (T
		<SET X <- 0 <- .X 1>>>)>
	 <UPDATE-STAT .X>
	 <TELL ,TAB "You slowly recover your bearings." CR>
	 <RTRUE>>

<ROUTINE I-SPIDER ("AUX" L DIR TBL DEST DAMAGE)
	 <SET L <LOC ,SPIDER>>
	 <COND (<EQUAL? .L ,HERE>
		<COND (<L? <GETP ,SPIDER ,P?ENDURANCE> 1>
		       <TELL ,TAB CTHE ,SPIDER>
		       <PRINT " retreats down the passageway, ">
		       <TELL "its wounds oozing with vile ichors." CR>
		       <KILL-MONSTER ,SPIDER>
		       <RTRUE>)
		      (<IS? ,SPIDER ,SURPRISED>
		       <SEE-MONSTER ,SPIDER>
		       <COND (<NOT <IS? ,SPIDER ,SLEEPING>>
			      <TELL ,TAB>
			      <WHIRLS ,SPIDER>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,SPIDER>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,SPIDER>>
		<TELL ,TAB CTHE ,SPIDER>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,SPIDER-HITS>>
		       <OUCH ,SPIDER .DAMAGE>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,SPIDER-MISSES> ,PERIOD>
		<RTRUE>)>
	 <SET DIR <MOVE-MONSTER? ,SPIDER>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<IS? ,SPIDER ,SEEN>
		       <TELL ,XTHE>)
		      (T
		       <MAKE ,SPIDER ,SEEN>
		       <TELL ,XA>)>
		<TELL D ,SPIDER " crawls in from the " B .DIR " passage!" CR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE I-SLUG ("AUX" L DIR TBL DEST DAMAGE)
	 <SET L <LOC ,SLUG>>
	 <COND (<EQUAL? .L ,HERE>
		<COND (<L? <GETP ,SLUG ,P?ENDURANCE> 1>
		       <TELL ,TAB CTHE ,SLUG>
		       <PRINT " retreats down the passageway, ">
		       <TELL "oozing something wet." CR>
		       <KILL-MONSTER ,SLUG>
		       <RTRUE>)
		      (<IS? ,SLUG ,SURPRISED>
		       <SEE-MONSTER ,SLUG>
		       <COND (<NOT <IS? ,SLUG ,SLEEPING>>
			      <TELL ,TAB>
			      <WHIRLS ,SLUG>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,SLUG>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,SLUG>>
		<TELL ,TAB CTHE ,SLUG>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,SLUG-HITS>>
		       <OUCH ,SLUG .DAMAGE>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,SLUG-MISSES> ,PERIOD>
		<RTRUE>)>
	 <SET DIR <MOVE-MONSTER? ,SLUG>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<IS? ,SLUG ,SEEN>
		       <TELL ,XTHE>)
		      (T
		       <MAKE ,SLUG ,SEEN>
		       <TELL ,XA>)>
		<TELL D ,SLUG " oozes ">
		<PASSAGE .DIR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE I-WORM ("AUX" L DIR TBL DEST DAMAGE)
	 <SET L <LOC ,WORM>>
	 <COND (<EQUAL? .L ,HERE>
		<COND (<L? <GETP ,WORM ,P?ENDURANCE> 1>
		       <TELL "  Hissing with humiliation, " THE ,WORM 
			     " slithers away into the undergrowth." CR>
		       <KILL-MONSTER ,WORM>
		       <RTRUE>)
		      (<IS? ,WORM ,SURPRISED>
		       <SEE-MONSTER ,WORM>
		       <COND (<NOT <IS? ,WORM ,SLEEPING>>
			      <TELL ,TAB CTHE ,WORM
		       		   " rears up as it sees you." CR>
			      <TOPPLED? ,WORM>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,WORM>
		       <RTRUE>)>
		<TELL ,TAB CTHE ,WORM>
		<COND (<IN? ,PLAYER ,MAW>
		       <PRINT " lurks around the idol's maw">
		       <COND (<PROB 50>
			      <TELL ", sharpening its fangs">)>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,WORM>>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,WORM-HITS>>
		       <OUCH ,WORM .DAMAGE>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,WORM-MISSES> ,PERIOD>
		<RTRUE>)>
	 <SET DIR <MOVE-MONSTER? ,WORM>>
	 <COND (<T? .DIR>
		<TELL ,TAB CTHE ,WORM>
		<PRINT " reappears from the ">
		<TELL B .DIR "!" CR>
		<TOPPLED? ,WORM>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE I-CROC ("AUX" DAMAGE)
	 <COND (<IN? ,CROC ,HERE>
		<COND (<L? <GETP ,CROC ,P?ENDURANCE> 1>
		       <TELL ,TAB CTHE ,CROC>
		       <TELL " drags itself off into the bushes." CR>
		       <KILL-MONSTER ,CROC>
		       <RTRUE>)
		      (<IS? ,CROC ,SURPRISED>
		       <SEE-MONSTER ,CROC>
		       <COND (<NOT <IS? ,CROC ,SLEEPING>>
			      <TELL ,TAB>
			      <WHIRLS ,CROC>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,CROC>
		       <RTRUE>)>
		<TELL ,TAB CTHE ,CROC>
		<COND (<IN? ,PLAYER ,MAW>
		       <PRINT " lurks around the idol's maw">
		       <CHOPS>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,CROC>>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,JAW-HITS>>
		       <OUCH ,CROC .DAMAGE>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,JAW-MISSES> ,PERIOD>
		<RTRUE>)>
	 <RETURN <CHARGING? ,CROC>>>

<ROUTINE CHARGING? (OBJ "AUX" DIR)
	 <SET DIR <MOVE-MONSTER? .OBJ>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<IS? .OBJ ,SEEN>
		       <TELL ,XTHE>)
		      (T
		       <MAKE .OBJ ,SEEN>
		       <TELL ,XA>)>
		<TELL D .OBJ " charges in from the " B .DIR "!" CR>
		<TOPPLED? .OBJ>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CHOPS ()
	 <COND (<PROB 50>
		<TELL ", licking its chops">)>
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE I-HOUND ("AUX" DAMAGE)
	 <COND (<IN? ,HOUND ,HERE>
		<COND (<L? <GETP ,HOUND ,P?ENDURANCE> 1>
		       <TELL "  Whining with pain, " THE ,HOUND
			     " limps away into the forest." CR>
		       <KILL-MONSTER ,HOUND>
		       <RTRUE>)
		      (<IS? ,HOUND ,SURPRISED>
		       <SEE-MONSTER ,HOUND>
		       <COND (<NOT <IS? ,HOUND ,SLEEPING>>
			      <TELL ,TAB CTHE ,HOUND 
				    " bares its fangs when it sees you." CR>
			      <TOPPLED? ,HOUND>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,HOUND>
		       <RTRUE>)>
		<TELL ,TAB CTHE ,HOUND>
		<COND (<IN? ,PLAYER ,POOL>
		       <TELL " prowls the edge of " THE ,POOL>
		       <CHOPS>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,HOUND>>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,JAW-HITS>>
		       <OUCH ,HOUND .DAMAGE>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,JAW-MISSES> ,PERIOD>
		<RTRUE>)>
	 <RETURN <CHARGING? ,HOUND>>>

<ROUTINE I-PUPP ("AUX" L PL DIR TBL DEST DAMAGE)
	 <SET L <LOC ,PUPP>>
	 <COND (<EQUAL? .L ,HERE>
		<COND (<L? <GETP ,PUPP ,P?ENDURANCE> 1>
		       <TELL "  With a furious snarl, " THE ,PUPP>
		       <PRINT " retreats into the ">
		       <TELL "forest." CR>
		       <NEXT-MONSTER ,HOUND>
		       <KILL-MONSTER ,PUPP>
		       <RTRUE>)
		      (<IS? ,PUPP ,SURPRISED>
		       <SEE-MONSTER ,PUPP>
		       <COND (<NOT <IS? ,PUPP ,SLEEPING>>
			      <TELL ,TAB CTHE ,PUPP 
				    " grins evilly when it sees you." CR>
			      <TOPPLED? ,PUPP>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,PUPP>
		       <RTRUE>)>
		<NEXT-ENDURANCE? ,PUPP>
		<SET PL <LOC ,PLAYER>>
		<TELL ,TAB CTHE ,PUPP>
		<COND (<NOT <EQUAL? .PL ,HERE>>
		       <TELL <PICK-NEXT ,PUPP-MISSES> ,PERIOD>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,PUPP>>
		<TELL <PICK-NEXT ,PUPP-HITS>>
		<COND (<ZERO? .DAMAGE>
		       <TELL ", but you manage to ignore it." CR>
		       <RTRUE>)>
		<TELL ,PERIOD>
		<UPDATE-STAT .DAMAGE>
		<RTRUE>)>
	 <SET DIR <MOVE-MONSTER? ,PUPP>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<IS? ,PUPP ,SEEN>
		       <TELL CTHE ,PUPP " swings in from the " B .DIR ,PERIOD>
		       <RTRUE>)>
		<MAKE ,PUPP ,SEEN>
		<SETG LAST-MONSTER-DIR ,P-WALK-DIR>
		<TELL CA ,PUPP " drops out of the treetops!" CR>
		<TOPPLED? ,PUPP>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE I-DEAD ("AUX" DIR DAMAGE)
	 <COND (<IN? ,DEAD ,HERE>
		<COND (<L? <GETP ,DEAD ,P?ENDURANCE> 1>
		       <TELL "  Wailing with self-pity, " THE ,DEAD
			     " fades out of existence." CR>
		       <KILL-MONSTER ,DEAD>
		       <RTRUE>)
		      (<IS? ,DEAD ,SURPRISED>
		       <SEE-MONSTER ,DEAD>
		       <WHIRLS ,DEAD>
		       <RTRUE>)
		      (<TOPPLED? ,DEAD>
		       <RTRUE>)>
		<NEXT-ENDURANCE? ,DEAD>
		<SET DAMAGE <MONSTER-STRIKES? ,DEAD>>
		<TELL ,TAB CTHE ,DEAD>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,DEAD-HITS>>
		       <OUCH ,DEAD .DAMAGE>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,DEAD-MISSES> ,PERIOD>
		<RTRUE>)>
	 <SET DIR <MOVE-MONSTER? ,DEAD>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<IS? ,DEAD ,SEEN>
		       <TELL CTHE ,DEAD>
		       <PRINT " reappears from the ">
		       <TELL B .DIR>)
		      (T
		       <MAKE ,DEAD ,SEEN>
		       <TELL "With a fearful battle cry, " 
			     A ,DEAD " rises out of the ruins">)>
		<TELL "!" CR>
		<TOPPLED? ,DEAD>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE I-GHOUL ("AUX" DIR DAMAGE)
	 <COND (<IN? ,GHOUL ,HERE>
		<COND (<L? <GETP ,GHOUL ,P?ENDURANCE> 1>
		       <NEXT-MONSTER ,DEAD>
		       <TELL ,TAB "Howling with pain and rage, "
			     THE ,GHOUL " abandons his spade and">
		       <PRINT " retreats into the ">
		       <TELL "ruins." CR>
		       <KILL-MONSTER ,GHOUL>
		       <MOVE ,SPADE ,HERE>
		       <SETG P-IT-OBJECT ,SPADE>
		       <RTRUE>)
		      (<IS? ,GHOUL ,SURPRISED>
		       <SEE-MONSTER ,GHOUL>
		       <COND (<NOT <IS? ,GHOUL ,SLEEPING>>
			      <WHIRLS ,GHOUL>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,GHOUL>
		       <RTRUE>)>
		<SET DAMAGE <MONSTER-STRIKES? ,GHOUL>>
		<TELL ,TAB CTHE ,GHOUL>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,GHOUL-HITS>>
		       <OUCH ,GHOUL .DAMAGE>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,GHOUL-MISSES> ,PERIOD>
		<RTRUE>)>
	 <SET DIR <MOVE-MONSTER? ,GHOUL>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<IS? ,GHOUL ,SEEN>
		       <TELL CTHE ,GHOUL>
		       <PRINT " reappears from the ">
		       <TELL B .DIR>)
		      (T
		       <MAKE ,GHOUL ,SEEN>
		       <TELL "Without warning, " A ,GHOUL
			     " leaps out of the rubble">)>
		<TELL "!" CR>
		<TOPPLED? ,GHOUL>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE I-ASUCKER ()
	 <RETURN <MOVE-SUCKERS ,ASUCKER ,BSUCKER>>>

<ROUTINE I-BSUCKER ()
	 <RETURN <MOVE-SUCKERS ,BSUCKER ,CSUCKER>>>

<ROUTINE I-CSUCKER ()
	 <RETURN <MOVE-SUCKERS ,CSUCKER>>>

<ROUTINE MOVE-SUCKERS (OBJ "OPT" (NXT 0)
		       	   "AUX" (DAMAGE 0) L PL DIR TBL DEST X)
	 <SET L <LOC .OBJ>>
	 <COND (<EQUAL? .L ,HERE>
		<TELL ,TAB>
		<COND (<L? <GETP .OBJ ,P?ENDURANCE> 1>
		       <TELL "Squealing with fear, " THE .OBJ
			     " retreats down the passageway." CR>
		       <COND (<T? .NXT>
			      <NEXT-MONSTER .NXT>
			      <NEXT-SUCKER .NXT>)>
		       <KILL-MONSTER .OBJ>
		       <RTRUE>)
		      (<IS? .OBJ ,SURPRISED>
		       <SEE-MONSTER .OBJ>
		       <COND (<ZERO? ,LIT?>
			      <DARK-MOVES>
			      <RTRUE>)>
		       <TELL CTHE .OBJ " glances up as you appear." CR>
		       <RTRUE>)
		      (<PROB 20>
		       <PUTP .OBJ ,P?ENDURANCE <GETP .OBJ ,P?EMAX>>
		       <WINDOW ,SHOWING-ROOM>
		       <COND (<T? ,LIT?>
			      <BLINK .OBJ>
			      <TELL " turns into ">)>
		       <NEXT-SUCKER .OBJ>
		       <COND (<T? ,LIT?>
			      <TELL A .OBJ "!" CR>
			      <RTRUE>)>
		       <TELL ,YOU-HEAR "a curious sound in the darkness." CR>
		       <RTRUE>)>
		
		<SET X <GET ,STATS ,LUCK>>
	        <COND (<G? .X 9>
		       <SET DAMAGE <PERCENT 10 .X>>)
		      (<G? .X 1>
		       <SET DAMAGE 1>)>
		<NEXT-ENDURANCE? .OBJ>
		<SET X <GETP ,HERE ,P?MIRROR-OBJ>>
		<COND (<NOT <EQUAL? .X <> ,NO-MIRROR>>
		       <COND (<T? ,LIT?>
			      <TELL CTHE .OBJ
				    <GET ,SUCKER-SMASHES ,THIS-SUCKER> ,PTAB>
			      <ITALICIZE "Pop">
			      <TELL "!" CR>)
			     (T
			      <TELL ,YOU-HEAR "a flabby ">
			      <ITALICIZE "pop">
			      <TELL " in the darkness." CR>)>
		       <DESTROY-MIRROR .X>
		       <COND (<NOLUCK?>
			      <UPDATE-STAT <- 0 .DAMAGE> ,LUCK T>)>
		       <RTRUE>)
		      (<ZERO? ,LIT?>)
		      (<PROB 67>
		       <TELL CTHE .OBJ
			     <PICK-NEXT <GET ,SUCKER-HITS ,THIS-SUCKER>>
			     ,PERIOD>
		       <COND (<NOLUCK?>
			      <UPDATE-STAT <- 0 .DAMAGE> ,LUCK T>)>
		       <RTRUE>)>
		<COND (<T? ,LIT?>
		       <TELL CTHE .OBJ 
			     <PICK-NEXT <GET ,SUCKER-MISSES ,THIS-SUCKER>>
			     ,PERIOD>
		       <RTRUE>)>
		<TELL "Something " <PICK-NEXT ,SUCKER-STALKS>
		      " you in the darkness." CR>
		<RTRUE>)>	 
	 <SET DIR <MOVE-MONSTER? .OBJ>>
	 <COND (<T? .DIR>
		<TELL ,TAB>
		<COND (<ZERO? ,LIT?>
		       <TELL ,YOU-HEAR B ,W?SOMETHING 
			     " stalk into the passage." CR>
		       <RTRUE>)
		      (<IS? .OBJ ,SEEN>
		       <TELL ,XTHE>)
		      (T
		       <MAKE .OBJ ,SEEN>
		       <TELL ,XA>)>
		<TELL D .OBJ " stalks in from the " B .DIR " passage." CR>
		<RTRUE>)>
	 
	 <SET X <GETP <LOC .OBJ> ,P?MIRROR-OBJ>>
	 <COND (<EQUAL? .X <> ,NO-MIRROR>
		<RFALSE>)>
	 <TELL ,TAB ,YOU-HEAR 
	       "a distant patter of stalking feet, then a flabby ">
	 <ITALICIZE "pop">
	 <PRINT ,PERIOD>
	 <DESTROY-MIRROR .X>
	 <RTRUE>>

<ROUTINE NEXT-SUCKER (OBJ "AUX" X)
	 <PROG ()
	    <SET X <PICK-ONE ,SUCKER-TYPES>>
	    <COND (<EQUAL? .X ,THIS-SUCKER>
		   <AGAIN>)>>
	 <SETG THIS-SUCKER .X>
	 <SET X <GETPT .OBJ ,P?SYNONYM>>
	 <PUT .X 0 <GET ,SUCKER-SYNS-A ,THIS-SUCKER>>
	 <PUT .X 1 <GET ,SUCKER-SYNS-B ,THIS-SUCKER>>
	 <SET X <GETPT .OBJ ,P?ADJECTIVE>>
	 <PUT .X 0 <GET ,SUCKER-ADJS ,THIS-SUCKER>>
	 <RFALSE>>
	 
<GLOBAL AMULET-TIMER:NUMBER 0>

<ROUTINE I-AMULET ()
	 <COND (<DLESS? AMULET-TIMER 1>
		<COND (<VISIBLE? ,AMULET>
		       <STAR-FADES>)>
		<STOP-AMULET>
		<COND (<WEARING-MAGIC? ,AMULET>
		       <NORMAL-STRENGTH>)>)>
	 <RFALSE>>
	      
<ROUTINE STAR-FADES ("OPT" (ANGRY <>))
	 <TELL "  The amulet's glowing star ">
	 <COND (<T? .ANGRY>
		<TELL "flares angrily, ">)>
	 <TELL "fades and disappears." CR>
	 <RTRUE>>
		       
<ROUTINE I-SALT ()
	 <COND (<NOT <HERE? ON-WHARF>>
		<RFALSE>)
	       (<IS? ,SALT ,SEEN>
		<UNMAKE ,SALT ,SEEN>
		<RFALSE>)
	       (<PROB 75>
		<RFALSE>)>
	 <MAKE ,SALT ,SEEN>
	 <TELL ,TAB CTHE ,SALT <PICK-NEXT ,SALT-DABS> ,PERIOD>
	 <RTRUE>>

<GLOBAL GOSSIP:NUMBER 0>

<ROUTINE I-BANDITS ()
	 <COND (<NOT <HERE? IN-PUB>>
		<RFALSE>)
	       (<IS? ,BANDITS ,SEEN>
		<UNMAKE ,BANDITS ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <MAKE ,BANDITS ,SEEN>
	 <TELL ,TAB>
	 <COND (<G? ,GOSSIP 4>
		<TELL <PICK-NEXT ,BANDIT-MUTTERS> ,PERIOD>
		<RTRUE>)>
	 <INC GOSSIP>
	 <COND (<EQUAL? ,GOSSIP 1>
		<TELL 
"One of the bandits leers at you. \"Har!\"" CR>
		<RTRUE>)
	       (<EQUAL? ,GOSSIP 2>
		<TELL
"You overhear the word \"helmet\" in a conversation nearby." CR>
		<RTRUE>)
	       (<EQUAL? ,GOSSIP 3>
		<TELL 
"A bandit looks you up and down. \"Monster bait. Har!\"" CR>
		<RTRUE>)>
	 <TELL
"\"... north of the River Phee,\" whispers a bandit." CR>
	 <RTRUE>>
		
<ROUTINE I-COOK ()
	 <COND (<NOT <HERE? IN-KITCHEN>>
		<RFALSE>)
	       (<IS? ,COOK ,SEEN>
		<UNMAKE ,COOK ,SEEN>
		<RFALSE>)
	       (<PROB 75>
		<RFALSE>)>
	 <MAKE ,COOK ,SEEN>
	 <SEE-CHARACTER ,COOK>
	 <TELL ,TAB CTHE ,COOK <PICK-NEXT ,COOK-DOINGS> ,PERIOD>
	 <RTRUE>>

<ROUTINE I-ONION-OFFER ()
	 <COND (<NOT <HERE? IN-KITCHEN>>
		<RFALSE>)
	       (<IS? ,COOK ,SEEN>
		<UNMAKE ,COOK ,SEEN>
		<RFALSE>)>
	 <STOP-ONION-OFFER>
	 <TELL ,TAB CTHE ,COOK 
	       "'s scowl changes to a malicious grin. \"Listen, ">
	 <BOY-GIRL>
	 <TELL 
",\" he says. \"You look like somebody who knows a great vegetable when ">
	 <COND (<IS? ,PLAYER ,FEMALE>
		<TELL "s">)>
	 <TELL 
"he sees one. You want this here onion? Okay. There's an old bottle of wine lyin' around downstairs somewhere. Bring it up to me in one piece, and " 
THE ,ONION "'s yours.\" He" ,GLANCES-AT THE ,CELLAR-DOOR 
" and shudders. \"Simple.\"" CR>
	 <RTRUE>>

<GLOBAL GON:NUMBER 14> "Gondola timetable."

<ROUTINE I-GONDOLA ("AUX" (RIDING 0))
	 <COND (<IN? ,WINNER ,GONDOLA>
		<INC RIDING>)>
	 <COND (<IGRTR? GON 14>
		<SETG GON 0>
		<REPLACE-GLOBAL? ,AT-DOCK ,DGONDOLA ,NULL>
		<MOVE ,GONDOLA ,AT-DOCK>
		<MAKE ,GONDOLA ,OPENED>
		<COND (<T? .RIDING>
		       <SETG HERE ,AT-DOCK>)
		      (<HERE? AT-DOCK>
		       <SETG P-IT-OBJECT ,GONDOLA>)
		      (T
		       <RFALSE>)>		
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB CTHE ,GONDOLA
" glides to a halt at " THE ,DOCK ,PTAB 
"\"All off,\" calls " THE ,CONDUCTOR " as the hatch swings open. ">
		<PRINT 
"\"Thank you for riding the Miznia Jungle Skyway">
		<TELL ". Please exit the Skycar in an orderly manner.\"" CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 1>
		<COND (<NOT <HERE? AT-DOCK>>
		       <RFALSE>)>
		<TELL ,TAB "The last few " 'PASSENGERS 
		      " are shuffling out of " THE ,GONDOLA>
		<COND (<T? .RIDING>
		       <TELL
". \"All off, please,\" repeats " THE ,CONDUCTOR ", meaning you">)>
		<TELL ,PERIOD>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 2>
		<COND (<NOT <HERE? AT-DOCK>>
		       <RFALSE>)>
		<TELL ,TAB>
		<COND (<T? .RIDING>
		       <MOVE ,PLAYER ,AT-DOCK>
		       <MAKE ,GONDOLA ,NODESC>
		       <SETG P-WALK-DIR <>>
		       <PRINT 
"\"Thank you for riding the Miznia Jungle Skyway">
		       <TELL
",\" growls " THE ,CONDUCTOR ", pushing you out of " THE ,GONDOLA>
		       <RELOOK>)>
		<TELL
"Eager " 'PASSENGERS " surge into the emptied " 'GONDOLA
". \"All aboard, please,\" announces " THE ,CONDUCTOR " unnecessarily." CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 3>
		<UNMAKE ,GONDOLA ,OPENED>
		<COND (<T? .RIDING>)
		      (<NOT <HERE? AT-DOCK>>
		       <RFALSE>)>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB
"\"Stay clear of the door, please,\" calls " THE ,CONDUCTOR
" as the last few " 'PASSENGERS " squeeze into " THE ,GONDOLA ,PERIOD>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 4>
		<MOVE ,GONDOLA ,OVER-JUNGLE>
		<REPLACE-GLOBAL? ,AT-DOCK ,NULL ,DGONDOLA>
		<COND (<T? .RIDING>
		       <SETG P-WALK-DIR <>>
		       <SETG OLD-HERE <>>
		       <SETG HERE ,OVER-JUNGLE>)
		      (<HERE? AT-DOCK>
		       <SETG P-IT-OBJECT ,DGONDOLA>)
		      (T
		       <RFALSE>)>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB CTHE ,GONDOLA
" slides away from the dock and glides west, high over " THE ,JUNGLE ,PTAB
"\"Welcome to the Miznia Jungle Skyway.\" drawls " THE ,CONDUCTOR
", his voice heavy with boredom." CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 5>
		<REPLACE-GLOBAL? ,AT-DOCK ,DGONDOLA ,NULL>
		<REPLACE-GLOBAL? ,NW-SUPPORT ,NULL ,DGONDOLA>		
		<REPLACE-GLOBAL? ,NW-UNDER ,NULL ,DGONDOLA>
		<REPLACE-GLOBAL? ,OVER-JUNGLE ,DOCK ,SUPPORT>
		<PUTP ,NW-UNDER ,P?OVERHEAD ,DGONDOLA>		
		<COND (<HERE? AT-DOCK>
		       <GONDOLA-GONE ,W?WEST>
		       <RTRUE>)
		      (<HERE? NW-SUPPORT NW-UNDER>
		       <VIEWGLIDE ,NW-UNDER ,W?EAST>
		       <RTRUE>)
		      (<ZERO? .RIDING>
		       <RFALSE>)>
		<WINDOW ,SHOWING-ROOM>
		<SETG P-IT-OBJECT ,SUPPORT>
		<TELL ,TAB CTHE ,GONDOLA
" glides over " THE ,JUNGLE ", towards a tall " 'SUPPORT ,PTAB
"\"The jungles of Miznia are the spawning grounds of the deadly " 'WORM
",\" drones " THE ,CONDUCTOR
". \"Often mistaken for a mossy boulder, the " 'WORM
"'s fangs extend up to 32 inches during an attack.\"|
  \"Oooh,\" murmurs the crowd." CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 6>
		<MOVE ,GONDOLA ,NW-SUPPORT>
		<COND (<HERE? NW-SUPPORT>
		       <GLIDING>)
		      (<ZERO? .RIDING>
		       <RFALSE>)
		      (T
		       <GLIDE-PAST ,NW-SUPPORT>)>
		<TELL ,TAB
"\"The tower to your right is one of several erected to elevate the Skyway above the treetops,\" explains " THE ,CONDUCTOR
". \"Before the Skyway opened in 882 GUE, an average of twenty Miznia Jungle Train passengers died of wormbite each year.\"|
  The crowd giggles nervously." CR> 
		<RTRUE>)
	       
	       (<EQUAL? ,GON 7>
		<MOVE ,GONDOLA ,OVER-JUNGLE>
		<COND (<T? .RIDING>
		       <SETG HERE ,OVER-JUNGLE>)
		      (<HERE? NW-SUPPORT>
		       <SETG P-IT-OBJECT ,DGONDOLA>)
		      (T
		       <RFALSE>)>
		<TURNS ,W?SOUTH>
		<COND (<ZERO? .RIDING>
		       <RTRUE>)>
		<TELL ,TAB
"\"The jungle is a rich source of exciting stories,\" continues " 
THE ,CONDUCTOR ", stifling a yawn. \"The most famous is the Legend of the Crocodile's Tear.\"" CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 8>
		<REPLACE-GLOBAL? ,NW-SUPPORT ,DGONDOLA ,NULL>
		<REPLACE-GLOBAL? ,NW-UNDER ,DGONDOLA ,NULL>
		<PUTP ,NW-UNDER ,P?OVERHEAD ,SUPPORT>
		<REPLACE-GLOBAL? ,SW-SUPPORT ,NULL ,DGONDOLA>
		<REPLACE-GLOBAL? ,SW-UNDER ,NULL ,DGONDOLA>
		<PUTP ,SW-UNDER ,P?OVERHEAD ,DGONDOLA>
		<COND (<HERE? NW-SUPPORT NW-UNDER>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL ,TAB CTHE ,GONDOLA 
" glides southward, and is soon out of sight." CR>
		       <RTRUE>)
		      (<HERE? SW-SUPPORT SW-UNDER>
		       <VIEWGLIDE ,SW-UNDER ,W?NORTH>
		       <RTRUE>)
		      (<ZERO? .RIDING>
		       <RFALSE>)>
		<JUNGLE-GLIDE>
		<TELL ,TAB
"\"The Crocodile's Tear is a sapphire of extraordinary size and clarity. It was discovered by a slave working the granola mines of Antharia, who died bringing it to the surface.\"" CR>
		<TELL ,TAB "Another " 'SUPPORT " is approaching." CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 9>
		<MOVE ,GONDOLA ,SW-SUPPORT>
		<COND (<HERE? SW-SUPPORT>
		       <GLIDING>)
		      (<ZERO? .RIDING>
		       <RFALSE>)
		      (T
		       <GLIDE-PAST ,SW-SUPPORT>)>
		<TELL ,TAB
"\"After passing through many hands, including those of Thaddium Fzort\" (\"Bless you,\" mutters a passenger), \"the jewel came into the possession of the evil sorceress Y'Syska, whose collection of gems and minerals is still without peer.\"" CR> 
		<RTRUE>)
	       
	       (<EQUAL? ,GON 10>
		<MOVE ,GONDOLA ,OVER-JUNGLE>
		<COND (<T? .RIDING>
		       <SETG HERE ,OVER-JUNGLE>)
		      (<HERE? SW-SUPPORT>
		       <SETG P-IT-OBJECT ,DGONDOLA>)
		      (T
		       <RFALSE>)>
		<TURNS ,W?EAST>
		<COND (<ZERO? .RIDING>
		       <RTRUE>)>
		<TELL ,TAB
"\"Flash photography is prohibited,\" growls " THE ,CONDUCTOR
" as a passenger snaps a picture of the hazy landscape." CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 11>
		<REPLACE-GLOBAL? ,SW-SUPPORT ,DGONDOLA ,NULL>
		<REPLACE-GLOBAL? ,SW-UNDER ,DGONDOLA ,NULL>
		<PUTP ,SW-UNDER ,P?OVERHEAD ,SUPPORT>
		<REPLACE-GLOBAL? ,SE-SUPPORT ,NULL ,DGONDOLA>
		<REPLACE-GLOBAL? ,SE-UNDER ,NULL ,DGONDOLA>
		<PUTP ,SE-UNDER ,P?OVERHEAD ,DGONDOLA>		
		<COND (<HERE? SW-SUPPORT SW-UNDER>
		       <GONDOLA-GONE ,W?EAST>
		       <RTRUE>)
		      (<HERE? SE-SUPPORT SE-UNDER>
		       <VIEWGLIDE ,SE-UNDER ,W?WEST>
		       <RTRUE>)
		      (<ZERO? .RIDING>
		       <RFALSE>)>
		<JUNGLE-GLIDE>
		<TELL ,TAB
"\"To protect the Crocodile's Tear from thieves, Y'Syska concealed it somewhere in the jungle below,\" concludes " THE ,CONDUCTOR 
" lamely. \"There it remains to this very day, guarded by bloodworms and whatever traps the sorceress laid to confound the unwary.\"" CR>
		<TELL ,TAB "Another " 'SUPPORT " looms to the east." CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 12>
		<MOVE ,GONDOLA ,SE-SUPPORT>
		<COND (<HERE? SE-SUPPORT>
		       <GLIDING>)
		      (<ZERO? .RIDING>
		       <RFALSE>)
		      (T
		       <GLIDE-PAST ,SE-SUPPORT>)>
		<TELL ,TAB "\"Thirsty?\" asks " THE ,CONDUCTOR 
		      ". \"Stop by ">
		<PRINT "the Skyway Adventure Emporium for a ">
		<TELL "tall, frosty Granola Float.\" He smacks his lips dispiritedly. \"Mmm, so good.\"" CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 13>
		<MOVE ,GONDOLA ,OVER-JUNGLE>
		<COND (<T? .RIDING>
		       <SETG HERE ,OVER-JUNGLE>)
		      (<NOT <HERE? SE-SUPPORT>>
		       <RFALSE>)>
		<TURNS ,W?NORTH>
		<COND (<ZERO? .RIDING>
		       <RTRUE>)>
		<TELL ,TAB
"\"Bloodworms are not the only inhabitants of the Miznia jungle,\" remarks " 
THE ,CONDUCTOR ", pausing to stretch. \"Survivors have reported a wide variety of birds, reptiles and other unclassifiable dangers.\"" CR>
		<RTRUE>)
	       
	       (<EQUAL? ,GON 14>
		<REPLACE-GLOBAL? ,SE-SUPPORT ,DGONDOLA ,NULL>
		<REPLACE-GLOBAL? ,OVER-JUNGLE ,SUPPORT ,DOCK>
		<REPLACE-GLOBAL? ,SE-UNDER ,DGONDOLA ,NULL>
		<PUTP ,SW-UNDER ,P?OVERHEAD ,SUPPORT>
		<REPLACE-GLOBAL? ,AT-DOCK ,NULL ,DGONDOLA>
		<COND (<HERE? SE-SUPPORT SE-UNDER>
		       <GONDOLA-GONE ,W?NORTH>
		       <RTRUE>)
		      (<HERE? AT-DOCK>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL ,TAB CA ,GONDOLA ,SIS>
		       <PRINT "approaching from the south.|">
		       <RTRUE>)
		      (<ZERO? .RIDING>
		       <RFALSE>)>
		<JUNGLE-GLIDE>
		<TELL ,TAB "\"Be sure to visit ">
		<PRINT "the Skyway Adventure Emporium for a ">
		<TELL 
"thrilling selection of one-of-a-kind gift ideas,\" urges " THE ,CONDUCTOR
" as " THE ,DOCK " appears to the north." CR>
		<RTRUE>)
	       (T
	      ; <SAY-ERROR "I-GONDOLA">
		<RFALSE>)>>

<ROUTINE GONDOLA-GONE (WRD)
	 <WINDOW ,SHOWING-ROOM>
	 <TELL ,TAB CTHE ,GONDOLA
	      " disappears to the " B .WRD ,PERIOD>
	 <RTRUE>>

<ROUTINE TURNS (WRD)
	 <WINDOW ,SHOWING-ROOM>
	 <TELL ,TAB CTHE ,GONDOLA " turns and glides " B .WRD
	       ", away from " THE ,SUPPORT ,PERIOD>
	 <RTRUE>>

<ROUTINE VIEWGLIDE (RM WRD)
	 <SETG P-IT-OBJECT ,DGONDOLA>
	 <WINDOW ,SHOWING-ROOM>
	 <TELL ,TAB CA ,GONDOLA " glides into view ">
	 <COND (<EQUAL? .RM ,HERE>
		<TELL "overhead." CR>
		<RTRUE>)>
	 <TELL "from the " B .WRD ,PERIOD>
	 <RTRUE>>

<ROUTINE GLIDING ()
	 <WINDOW ,SHOWING-ROOM>
	 <TELL ,TAB CTHE ,GONDOLA
" glides smoothly past, just a few feet away." CR>
	 <RTRUE>>

<ROUTINE GLIDE-PAST (RM)
	 <SETG HERE .RM>
	 <WINDOW ,SHOWING-ROOM>
	 <TELL ,TAB CTHE ,GONDOLA
" is gliding just a few feet from the top of " THE ,SUPPORT ,PERIOD>
	 <RTRUE>>

<ROUTINE JUNGLE-GLIDE ()
	 <WINDOW ,SHOWING-ROOM>
	 <SETG P-IT-OBJECT ,SUPPORT>
	 <TELL ,TAB CTHE ,GONDOLA " glides across " 
	       THE ,JUNGLE ,PERIOD>
	 <RTRUE>>

<ROUTINE I-PHASE ("AUX" L)
	 <COND (<IS? ,PHASE ,SEEN> ; "1-move delay."
		<UNMAKE ,PHASE ,SEEN>
		<RFALSE>)
	       (<NOT <IS? ,PHASE ,NODESC>>
		<RFALSE>)
	       (<VISIBLE? ,PHASE>
		<UNMAKE ,PHASE ,NODESC>
		<SETG P-IT-OBJECT ,PHASE>
		<WINDOW ,SHOWING-ALL>
		<SET L <LOC ,PHASE>>
		<TELL ,TAB CTHE ,PHASE>
		<COND (<EQUAL? .L ,PLAYER>
		       <TELL ,SIN 'HANDS "s">)
		      (<EQUAL? .L ,HERE>
		       <TELL ,SON>
		       <COND (<IS? ,HERE ,INDOORS>
			      <TELL THE ,FLOOR>)
			     (T
			      <TELL THE ,GROUND>)>)
		      (<IS? .L ,CONTAINER>
		       <TELL ,SIN THE .L>)
		      (<IS? .L ,SURFACE>
		       <TELL ,SON THE .L>)>
		<TELL " reappears at the edge of your vision." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE I-OWOMAN ()
	 <COND (<NOT <IN? ,OWOMAN ,HERE>>
		<RFALSE>)
	       (<IS? ,OWOMAN ,SEEN>
		<UNMAKE ,OWOMAN ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <SETG P-HER-OBJECT ,OWOMAN>
	 <MAKE ,OWOMAN ,SEEN>
	 <TELL ,TAB ,CTHELADY <PICK-NEXT ,OWOMAN-MOVES> THE ,MCASE ,PERIOD>
	 <RTRUE>>

<ROUTINE I-MIRRORS ("AUX" (V 0) HEAR L OBJ CNT TIME LEN)
	 <SET HEAR <GRUE-ROOM?>>
	 <SET LEN <GET ,MIRROR-LIST 0>>
	 <SET CNT 7>
	 <REPEAT ()
	    <SET OBJ <GET ,MIRROR-LIST .LEN>>
	    <SET L <LOC .OBJ>>
	    <COND (<T? .L>
		   <SET TIME <GETP .OBJ ,P?SIZE>>
		   <COND (<DLESS? TIME 1>
			  <DEC CNT>
			  <COND (<EQUAL? .L ,HERE>
				 <INC V>
				 <TELL ,TAB>
				 <SAY-MIRROR-POPS .OBJ>)
				(<T? .HEAR>
				 <INC V>
				 <TELL ,TAB "A distant ">
				 <ITALICIZE "pop">
				 <TELL " echoes down the passageway." CR>)>
			  <DESTROY-MIRROR .OBJ>)
			 (T
			  <PUTP .OBJ ,P?SIZE .TIME>
			  <COND (<AND <EQUAL? .L ,HERE>
				      <EQUAL? .TIME 2 10 18>>
				 <INC V>
				 <TELL ,TAB>
				 <SETG P-IT-OBJECT .OBJ>
				 <TELL CTHE .OBJ>
				 <COND (<EQUAL? .TIME 2>
					<TELL " is flexing dangerously now">
					<PRINT
". It probably won't last much longer.|">)
				       (<EQUAL? .TIME 10>
					<TELL 
" shimmers uncertainly for a moment." CR>)
				       (T
					<TELL 
" billows slightly, then stabilizes." CR>)>)>)>)
		  (T
		   <DEC CNT>)>
	    <COND (<DLESS? LEN 1>
		   <RETURN>)>>
	 <COND (<ZERO? .CNT>
		<DEQUEUE ,I-MIRRORS>)>
	 <RETURN .V>>   
			 
<ROUTINE SAY-MIRROR-POPS (OBJ)
	 <ITALICIZE "Pop">
	 <TELL "! " CTHE .OBJ " disappears in a silver spray." CR>
	 <RTRUE>>

<ROUTINE DESTROY-MIRROR (OBJ "AUX" L)
	 <COND (<EQUAL? .OBJ <> ,NO-MIRROR>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <PUTP .OBJ ,P?MIRROR-DIR ,NO-MIRROR>
	 <PUTP .OBJ ,P?SIZE 0>
	 <REMOVE .OBJ>
	 <COND (<EQUAL? .L ,HERE>
		<WINDOW ,SHOWING-ROOM>)>
	 <COND (<EQUAL? <GETP .L ,P?MIRROR-OBJ> .OBJ>
		<PUTP .L ,P?MIRROR-OBJ ,NO-MIRROR>
		<REFLECTIONS>)>
	 <RFALSE>>

"Returns direction mirror is facing (1/3/5/7)."

<ROUTINE CREATE-MIRROR? (OBJ "AUX" DIR)
	 <WINDOW ,SHOWING-ROOM>
	 <MOVE .OBJ ,HERE>
	 <SETG P-IT-OBJECT .OBJ>
	 <SET DIR <BOR <RANDOM 7> 1>> 
	 <PUTP .OBJ ,P?MIRROR-DIR .DIR>
	 <PUTP .OBJ ,P?SIZE ,MIRROR-LIFE>
	 <COND (<NOT <QUEUED? ,I-MIRRORS>>
		<QUEUE ,I-MIRRORS>)>
	 <RETURN .DIR>>

<GLOBAL URSCRIPT:NUMBER 0>

<ROUTINE I-URGRUE ("AUX" (SEE 0))
	 <COND (<NOT <HERE? IN-LAIR>>
		<RFALSE>)
	       (<OR <T? ,LIT?>
		    <WEARING-MAGIC? ,HELM>>
		<INC SEE>)>
	 <MAKE ,URGRUE ,SEEN>
	 <TELL ,TAB>
	 <COND (<IS? ,URGRUE ,SURPRISED>
		<UNMAKE ,URGRUE ,SURPRISED>
		<COND (<NOT <IS? ,URGRUE ,IDENTIFIED>>
		       <MAKE ,URGRUE ,IDENTIFIED>
		       <COND (<T? .SEE>
			      <TELL "As you glance around the chamber, "
				    THE ,URGRUE " yawns and stretches">)
			     (T
			      <TELL ,YOU-HEAR>
			      <PRINT "a voice in the darkness">
			      <TELL " yawn">)>
		       <TELL ". \"At last we meet.\"" CR>
		       <RTRUE>)>
		<TELL "\"" <PICK-NEXT ,URGRUE-GREETS>
		      ",\" chuckles ">
		<COND (<T? .SEE>
		       <TELL THE ,URGRUE>)
		      (T
		       <PRINT "a voice in the darkness">)>
		<COND (<L? ,URSCRIPT 2>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<TELL 
". \"Now where were we? Ah, yes. We were deciding how best to destroy you.\"" CR>
		<RTRUE>)>
	 <COND (<IGRTR? URSCRIPT 4>
		<TIMESTOP>
		<RTRUE>)
	       (<EQUAL? ,URSCRIPT 4>
		<TELL "\"I know!\" cries " THE ,URGRUE 
" with delight. \"Girgol, the Time Stop spell! Love it. You'll make a hilarious statue.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,URSCRIPT 3>
		<TELL CTHE ,URGRUE 
" mutters thoughtfully to itself. \"Let's see, now. A spell. Cleesh? No; too silly. Espnis? Hmm. Better not; ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "s">)>
		<TELL "he might snore.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,URSCRIPT 2>
		<TELL "\"An interesting question,\" continues " THE ,URGRUE
		      " conversationally, \"is ">
		<ITALICIZE "how">
		<TELL 
" to destroy you. Not a trivial decision, no. I must select a spell that will enhance my image, a Magick worthy of my thoroughly evil reputation.\"" CR>
		<RTRUE>)>
	 
	 <TELL CTHE ,URGRUE 
"'s chuckling subsides. \"I rarely get visitors,\" it admits in a wistful tone. \"A pity I have to destroy you.\"" CR>
	 <RTRUE>>

<GLOBAL ARCHTIMER:NUMBER 0>

<ROUTINE I-ARCH3 ()
	 <INC ARCHTIMER>
	 <TELL ,TAB>
	 <COND (<EQUAL? ,ARCHTIMER 1>
		<TELL CTHE ,ORATOR " stills " THE ,PCROWD 
" with a wave of his hand.|
  \"Our fathers built this city at the Place Where the Great Waters
Meet,\" he cries. \"The right to name the One River belongs to us!\"" CR
,TAB CTHE ,PCROWD " roars its approval." CR>
		<RTRUE>)
	       (<EQUAL? ,ARCHTIMER 2>
		<TELL
"\"The infidels from the east control the One River's mouth,\" continues "
THE ,ORATOR ". \"But we, who dwell at the joining of the Rivers Phee and Bor, WE control the source!\" " CTHE ,PCROWD " whistles. \"As the daughter takes the name of the father, so shall the One River be known by the place of its birth!\"" CR ,TAB "\"">
		<ITALICIZE "Pheebor">
		<TELL "!\" roars " THE ,PCROWD
". \"Hail the River Pheebor!\"" CR>
		<RTRUE>)
	       (<EQUAL? ,ARCHTIMER 3>
		<WINDOW ,SHOWING-ROOM>
		<REMOVE ,ORATOR>
		<SETG QCONTEXT <>>
		<SETG QCONTEXT-ROOM <>>
		<SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
		<TELL "\"Phee-bor! Phee-bor!\" chants " THE ,PCROWD ,PTAB>
		<TELL "\"We have no quarrel with the city to the east,\" claims " THE ,ORATOR " (amid shouts to the contrary). \"But if they continue to slight our heritage with the wretched name ">
		<ITALICIZE "Borphee">
		<TELL "\" (the crowd hisses), \"we shall smite them from the face of the land!\"" CR ,TAB CTHE ,PCROWD 
" goes wild, and carries " THE ,ORATOR " away on its shoulders." CR>
		<RTRUE>)>
	 <WINDOW ,SHOWING-ROOM>
	 <DEQUEUE ,I-ARCH3>
	 <REMOVE ,PCROWD>
	 <SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>
	 <TELL CTHE ,PCROWD " disperses, and you're left alone." CR>
	 <RTRUE>>		

<ROUTINE I-ARCH4 ()
	 <INC ARCHTIMER>
	 <WINDOW ,SHOWING-ROOM>
	 <TELL ,TAB>
	 <COND (<EQUAL? ,ARCHTIMER 1>
		<MOVE ,HORSE ,HERE>
		<SEE-CHARACTER ,PRINCE>
		<SETG P-IT-OBJECT ,HELM>
		<TELL 
"A magnificent gray stallion appears amid the smoke. Its rider is a tall, proud man wearing a fabulous helmet." CR>
		<RTRUE>)
	       (<EQUAL? ,ARCHTIMER 2>
		<MOVE ,BHORSE ,HERE>
		<TELL 
"Another stallion, black as night, races out of the smoke. Its rider's armor gleams red in the firelight.|
  \"At last we meet, Prince Foo,\" snarls the newcomer.|
  The man on the gray stallion regards him coolly. \"Begone, thou eastern fop!\" he cries. \"Never shall the River Pheebor yield its sacred name!\"" CR>
		<RTRUE>)
	       (<EQUAL? ,ARCHTIMER 3>
		<SETG QCONTEXT <>>
		<SETG QCONTEXT-ROOM <>>
		<REMOVE ,BHORSE>
		<MAKE ,PRINCE ,SLEEPING>
	        <MOVE ,PRINCE ,HERE>
		<MOVE ,HELM ,TRENCH>
		<PUTP ,PRINCE ,P?ACTION ,DEAD-PRINCE-F>
		<REPLACE-SYN? ,PRINCE ,W?ZZZP ,W?HEAD>
		<REPLACE-SYN? ,PRINCE ,W?ZZZP ,W?BODY>
		<REPLACE-SYN? ,PRINCE ,W?ZZZP ,W?CORPSE>
		<REPLACE-ADJ? ,PRINCE ,W?ZZZP ,W?DEAD>
		<TELL
"The black rider draws a gleaming sword from his scabbard and cuts off the prince's head, which rolls into the trench.|
  \"The reign of Pheebor is ended!\" cries the black knight, galloping off into the smoke. \"Foo is dead! The age of Borphee is begun!\"|
  The gray stallion nudges the prince's body, and whinnies softly." CR>
		<RTRUE>)>
	 <DEQUEUE ,I-ARCH4>
	 <COND (<NOT <IN? ,HORSE ,TRENCH>>
		<TELL ,XA>
		<SLAY-HORSE>
		<TELL ,TAB>)>
	 <TELL 
"Cries of \"Foo is dead! The war is over!\" drift through the smoke. Tattered men race past; the cries grow faint; and soon all is still as death." CR>
	 <RTRUE>>		

<ROUTINE I-GLASS ("AUX" V)
	 <SET V <VISIBLE? ,GLASS>>
	 <INC GLASS-BOT>
	 <COND (<DLESS? GLASS-TOP 1>
		<DEQUEUE ,I-GLASS>
		<COND (<ZERO? .V>
		       <RFALSE>)>
		<TELL ,TAB 
"The last grains of sand fall through " THE ,GLASS ,PERIOD>
		<ARCH-OFF>
		<RTRUE>)
	       (<ZERO? .V>
		<RFALSE>)
	       (<EQUAL? ,GLASS-TOP 2 4>
		<RFALSE>)>
	 <TELL ,TAB>
	 <COND (<EQUAL? ,GLASS-TOP 1>
		<TELL "The top half of " THE ,GLASS
		      " is almost empty." CR>
		<RTRUE>)>
	 <TELL "Sand continues to trickle through " THE ,GLASS ,PERIOD>
	 <RTRUE>>

<ROUTINE I-HUNTERS ()
	 <COND (<NOT <HERE? IN-PASTURE>>
		<RFALSE>)
	       (<NOT <IN? ,HUNTERS ,IN-PASTURE>>
		<SETG HSCRIPT 0>
		<QUEUE ,I-HUNT>
		<MOVE ,HUNTERS ,IN-PASTURE>
		<MAKE ,HUNTERS ,SEEN>
		<SEE-CHARACTER ,HUNTERS>
		<WINDOW ,SHOWING-ROOM>
		<TELL
"  A distant movement catches your eye. Peering between the oaks, you see men foraging at the pasture's edge. They look like hunters." CR>
		<RTRUE>)
	       (<IS? ,HUNTERS ,SEEN>
		<UNMAKE ,HUNTERS ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <MAKE ,HUNTERS ,SEEN>
	 <TELL "  The distant " 'HUNTERS
	       <PICK-NEXT ,HUNTER-DOINGS> ,PERIOD>
	 <RTRUE>>

<GLOBAL HSCRIPT:NUMBER 0>

<ROUTINE I-HUNT ()
	 <COND (<NOT <HERE? IN-PASTURE>>
		<RFALSE>)>
	 <INC HSCRIPT>
	 <MAKE ,HUNTERS ,SEEN>
	 <TELL ,TAB>
	 <COND (<EQUAL? ,HSCRIPT 1>
		<MOVE ,MINX ,OAK>
		<MOVE ,TRACKS ,HERE>
		<WINDOW ,SHOWING-ROOM>
		<SETG P-HER-OBJECT ,MINX>
		<SETG P-IT-OBJECT ,MINX>
		<TELL "\"Come back 'ere, you!\"" CR ,TAB>
		<ITALICIZE "Whoosh">
		<TELL "! A golden bundle of fur jumps out of the forest! It bounds across the snow in quick, desperate leaps, ducks behind the trunk of "
A ,OAK>
		<PRINT " and disappears from view.|">
		<TELL ,TAB 
"\"I'll wring yer li'l neck,\" promises an angry voice." CR>
		<COND (<ZERO? ,DMODE>
		       <RELOOK T>)>
		<RTRUE>)
	       (<EQUAL? ,HSCRIPT 2>
		<TELL
"\"I see yer dirty tracks, ye pest!\" The angry voice is getting much closer." CR> 
		<RTRUE>)
	       (<EQUAL? ,HSCRIPT 3>
		<MOVE ,HUNTER ,IN-PASTURE>
		<WINDOW ,SHOWING-ROOM>
		<SEE-CHARACTER ,HUNTER>
		<TELL "\"Show yerself, ye flea-bit mop!\"" CR ,TAB
"A young man strides out of the woods, an angry scowl on his windburned face">
		<COND (<IN? ,TRACKS ,HERE>
		       <REMOVE ,TRACKS>
		       <TELL  " as he follows the tracks in the snow." CR>
		       <HUNTER-SEES-MINX>
		       <RTRUE>)>
		<TELL "... and a nasty-looking whip in his hands" ,PTAB>
		<TELL "\"Yo, ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "ma'am">)
		      (T
		       <TELL "sir">)>
		<TELL 
"!\" he cries, drawing closer. \"Lost a minx 'ereabouts! Came this way, if th' trail speaks truly.\"|
  Something behind " THE ,OAK " whimpers softly." CR>
		<RTRUE>)
	       (<EQUAL? ,HSCRIPT 4>
		<TELL 
"The lad surveys the pasture impatiently. \"Blasted crayture,\" he mutters with a practiced crack of the whip. \"One o' me best. 'Twould be a shame to lose 'er.\"|
  The beast behind " THE ,OAK " makes itself as small as possible." CR>
		<RTRUE>)
	       (<EQUAL? ,HSCRIPT 5>
		<DEQUEUE ,I-HUNT>
		<SETG HSCRIPT 0>
		<REMOVE ,HUNTER>
		<UNMAKE ,HUNTERS ,SEEN>
		<SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
		<WINDOW ,SHOWING-ROOM>
		<MOVE ,MINX ,IN-PASTURE>
		<UNMAKE ,MINX ,TRYTAKE>
		<UNMAKE ,MINX ,NOALL>
		<MAKE ,MINX ,TAKEABLE>
		<QUEUE ,I-MINX>
		<SEE-CHARACTER ,MINX>
		<TELL
"\"Hide from me, will ye, ye snufflin' she-devil!\" cries " THE ,HUNTER
" striding back into the forest. \"It's to the hounds I'll be throwin' yer bleedin' carcass!\" His curses soon ">
		<PRINT "fade into the distance.|">
		<TELL ,TAB CTHE ,MINX
" pokes its nose out from behind " THE ,OAK ", sniffing fearfully. It peeks around " THE ,GCORNER ", and its brown eyes lock with yours" ,PTAB 
"\"Minx?\"" CR>
		<RTRUE>)
	       (T  
		<RFALSE>)>>
		
<ROUTINE I-MINX ("AUX" L NL PL PLL V TBL DIR X TYPE)
	 <SET L <LOC ,MINX>>
	 <COND (<OR <ZERO? .L>
		    <NOT <IS? ,MINX ,LIVING>>>
		<DEQUEUE ,I-MINX>
		<RFALSE>)>
	 <SET V <VISIBLE? ,MINX>>
	 <COND (<IS? ,MINX ,SLEEPING>
		<COND (<ZERO? .V>
		       <RFALSE>)>
		<COND (<IS? ,MINX ,SEEN>
		       <UNMAKE ,MINX ,SEEN>
		       <RFALSE>)
		      (<PROB 50>
		       <RFALSE>)>
		<MINXTAB>
		<TELL CTHE ,MINX <PICK-NEXT ,MINX-SLEEPS> ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .L ,PLAYER>
		<MINXTAB>
		<COND (<IN? ,TRUFFLE .L>
		       <MINX-EATS-TRUFFLE>
		       <RTRUE>)>
		<TELL CTHE ,MINX>
		<COND (<BAD-MINX-PLACE? ,HERE>
		       <SET X ,MINX-NERVES>
		       <COND (<PROB 33>
			      <SET X ,MINX-RESTLESS>)>
		       <TELL <PICK-NEXT .X> ,PERIOD>
		       <RTRUE>)
		      (<IS? ,MINX ,TOUCHED>
		       <UNMAKE ,MINX ,TOUCHED>
		       <MAKE ,MINX ,TRYTAKE>
		       <TELL <PICK-NEXT ,MINX-SETTLES>
			     " in your arms." CR>
		       <RTRUE>)
		      (<IS? ,MINX ,TRYTAKE>
		       <UNMAKE ,MINX ,TRYTAKE>
		       <TELL <PICK-NEXT ,MINX-RESTLESS> ,PERIOD>
		       <RTRUE>)>
		<WINDOW ,SHOWING-ALL>
		<PRINTC ,SP>
		<COND (<PROB 50>
		       <SAY-LEAP>
		       <TELL "s ">
		       <COND (<PROB 50>
			      <TELL "out of your ">
			      <COND (<PROB 50>
				     <TELL "arms ">)
				    (T
				     <TELL "grasp ">)>)
			     (T
			      <TELL "free ">)>)
		      (T
		       <TELL "frees itself ">
		       <COND (<PROB 50>
			      <TELL "with a ">
			      <COND (<PROB 50>
				     <COND (<PROB 50>
					    <TELL "sudden ">)
					   (T
					    <TELL "quick ">)>)>
			      <SAY-LEAP>
			      <PRINTC ,SP>)>)>
		<TELL "and ">
		<FALLS ,MINX>
		<RTRUE>)>
	 <UNMAKE ,MINX ,TOUCHED>
	 <UNMAKE ,MINX ,TRYTAKE>
	 <SET PL <LOC ,PLAYER>>
	 <COND (<EQUAL? .L .PL>
		<COND (<IS? ,MINX ,SEEN>
		       <UNMAKE ,MINX ,SEEN>
		       <RFALSE>)
		      (<AND <NOT <IN? ,TRUFFLE .L>>
			    <PROB 80>>
		       <RFALSE>)>
		<MINXTAB>
		<COND (<ZERO? ,LIT?>
		       <TELL "Something" <PICK-NEXT ,DARK-MINXES> ,PERIOD>
		       <RTRUE>)
		      (<AND <EQUAL? .L ,ARCH ,ARCH4 ,ARCH12>
			    <IN? ,TRUFFLE ,TRENCH>>
		       <UNMAKE ,MINX ,SEEN>
		       <COND (<HERE? ARCH12>
			      <COND (<IS? ,TRENCH ,NODESC>
				     <DIG-UP-TRENCH>
				     <RTRUE>)>
			      <MINX-EATS-TRUFFLE>
			      <RTRUE>)>
		       <SET X ,ARCH-SNIFFS>
		       <COND (<HERE? ARCH4>)
			     (<PROB 25>
			      <SET X ,MINX-DOINGS>)>
		       <TELL CTHE ,MINX <PICK-NEXT .X> ,PERIOD>
		       <RTRUE>)
		      (<IN? ,TRUFFLE .L>
		       <MINX-EATS-TRUFFLE>
		       <RTRUE>)
		      (<LOC ,TRUFFLE>)
		      (<DIG-UP-TRUFFLE? .L>
		       <RTRUE>)>
		<TELL CTHE ,MINX <PICK-NEXT ,MINX-DOINGS> ,PERIOD>	
		<RTRUE>)
	       (<AND <IS? .PL ,VEHICLE>
		     <IN? .PL .L>>
		<MOVE ,MINX .PL>
		<MINXTAB>
		<COND (<ZERO? ,LIT?>
		       <TELL "Something furry">)
		      (T
		       <WINDOW ,SHOWING-ROOM>
		       <TELL CTHE ,MINX>)>
		<TELL " joins you">
		<ON-IN .PL>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<OR <IS? .L ,SURFACE>
		    <IS? .L ,CONTAINER>>
		<SET NL <LOC .L>>
		<COND (<OR <BAD-MINX-PLACE? .NL>
			   <AND <IS? .L ,CONTAINER>
				<NOT <IS? .L ,OPENED>>>>
		       <COND (<VISIBLE? .L>
			      <MINXTAB>
			      <COND (<AND <IS? .L ,TRANSPARENT>
					  <T? ,LIT?>>
				     <TELL CTHE ,MINX>)
				    (T
				     <TELL "Something">)>
			      <COND (<IN? ,TRUFFLE .L>
				     <WINDOW %<+ ,SHOWING-ROOM
							,SHOWING-INV>>
				     <REMOVE ,TRUFFLE>
				     <TELL " is eating " B ,W?SOMETHING>)
				    (T
				     <TELL " moves restlessly">)>
			      <ON-IN .L>
			      <TELL ,PERIOD>
			      <RTRUE>)
			     (<IN? ,TRUFFLE .L>
			      <REMOVE ,TRUFFLE>)>
		       <COND (<ZERO? .NL>
			      <REMOVE ,MINX>
			      <DEQUEUE ,I-MINX>)>
		       <RFALSE>)
		      (<ZERO? .V>
		       <MOVE ,MINX .NL>
		       <RFALSE>)>
		<MINXTAB>
		<COND (<ZERO? ,LIT?>
		       <TELL "Something">)
		      (<IN? ,TRUFFLE .L>
		       <MINX-EATS-TRUFFLE>
		       <RTRUE>)
		      (T
		       <WINDOW ,SHOWING-ROOM>
		       <TELL CTHE ,MINX>)>
		<PRINTC ,SP>
		<SAY-LEAP>
		<TELL "s">
		<OUT-OF-LOC .L>
		<PRINT ,PERIOD>
		<MOVE ,MINX .NL>
		<RTRUE>)>
	 	 	 
       ; "Is player in a room adjacent to minx?"

	 <SET PLL <LOC .PL>>
	 <SET DIR ,P?NORTH>
	 <REPEAT ()
	    <SET TBL <GETP .L .DIR>>
	    <COND (<T? .TBL>
		   <SET TYPE <MSB <GET .TBL ,XTYPE>>>
		   <COND (<OR <EQUAL? .TYPE ,CONNECT ,SCONNECT ,X-EXIT>
			      <AND <EQUAL? .TYPE ,DCONNECT>
				   <IS? <GET .TBL ,XDATA> ,OPENED>>>
			  <SET NL <GET .TBL ,XROOM>>
			  <COND (<BAD-MINX-PLACE? .NL>)
				(<EQUAL? .NL .PL .PLL>
				 <MOVE ,MINX .NL>
				 <MINXTAB>
				 <COND (<ZERO? ,LIT?>
					<TELL ,YOU-HEAR B ,W?SOMETHING
					      " moving ">)
				       (T
					<WINDOW ,SHOWING-ROOM>
					<TELL CTHE ,MINX " appears ">)>
				 <COND (<EQUAL? .NL .PL>
					<TELL "at your feet." CR>
					<RTRUE>)>
				 <TELL "nearby." CR>
				 <RTRUE>)>)>)>
	    <COND (<DLESS? DIR ,P?DOWN>
		   <RFALSE>)>>> 
		       		
<ROUTINE MINXTAB ()
	 <MAKE ,MINX ,SEEN>
	 <PRINT ,TAB>
	 <RFALSE>>

<ROUTINE BAD-MINX-PLACE? (RM "AUX" X)
	 <COND (<ZERO? .RM>
		<RTRUE>)>
	 <SET X <GETB ,NO-MINX 0>>
	 <COND (<SET X <INTBL? .RM <REST ,NO-MINX 1> .X 1>>
		<RTRUE>)
	       (<AND <EQUAL? .RM ,IN-GARDEN>
		     <G? ,PTIMER 1>>
		<RTRUE>)
	       (<AND <EQUAL? .RM ,SADDLE>
		     <IN? ,SADDLE ,DACT>
		     <IN? ,DACT ,IN-SKY>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DIG-UP-TRUFFLE? (L "AUX" X)
	 <COND (<EQUAL? .L <LOC ,OAK>>
		<SET X ,OAK>)
	       (<EQUAL? .L <LOC ,OAK2>>
		<SET X ,OAK2>)
	       (<EQUAL? .L <LOC ,OAK3>>
		<SET X ,OAK3>)
	       (T
		<RFALSE>)>
	 <COND (<IS? .X ,TOUCHED>
		<RFALSE>)>
	 <OAK-FIND .X>
	 <TELL CTHE ,MINX
" snuffles inquisitively around the base of " THE .X
". She scratches around the roots, nosing aside leaves and dirt, and pulls up a " D ,TRUFFLE " with a triumphant mew. ">
	 <PRINT "\"Minx! Minx! Minx!\"|">
	 <RTRUE>>

<ROUTINE DIG-UP-TRENCH ()
	 <UNMAKE ,TRUFFLE ,SEEN>
	 <REMOVE ,TRUFFLE>
	 <UNMAKE ,TRUFFLE ,MUNGED>
	 <DEQUEUE ,I-TRUFFLE>
	 <SETG TRUFFLE-TIMER 0>
	 <MOVE ,TRENCH ,HERE>
	 <UNMAKE ,TRENCH ,NODESC>
	 <MAKE ,TRENCH ,OPENED>
	 <WINDOW ,SHOWING-ROOM>
	 <REPLACE-SYN? ,TRENCH ,W?ZZZP ,W?MINXHOLE>
	 <REPLACE-ADJ? ,TRENCH ,W?ZZZP ,W?MINX>
	 <TELL CTHE ,MINX>
	 <COND (<NOT <IN? ,MINX ,HERE>>
		<MOVE ,MINX ,HERE>
		<TELL " leaves " THE ,ARCH " and">)>
	 <TELL
" runs its nose over the loose earth, snuffling hungrily. Then it paws a deep hole in " THE ,GROUND ", roots up a dirty truffle and swallows it whole"
,PTAB>
	 <PRINT "\"Minx! Minx! Minx!\"|">
	 <COND (<ZERO? ,DMODE>
		<RELOOK T>)>
	 <RTRUE>>  
		     
<ROUTINE SAY-LEAP ("AUX" X)
	 <SET X <RANDOM 100>>
	 <COND (<L? .X 33>
		<TELL B ,W?LEAP>
		<RTRUE>)
	       (<L? .X 67>
		<TELL B ,W?BOUND>
		<RTRUE>)>
	 <TELL B ,W?JUMP>
	 <RTRUE>>

<ROUTINE I-CORBIES ("AUX" (FEAR 0) SOUND EMOTION X)
	 <COND (<NOT <PLAIN-ROOM?>>
		<RFALSE>)>
	 <TELL ,TAB>
	 <MAKE ,CORBIES ,SEEN>
	 <SETG P-THEM-OBJECT ,CORBIES>
	 <SET SOUND <PICK-NEXT ,CORBIE-SOUNDS>>
	 <SET EMOTION <PICK-NEXT ,MAD-CORBIES>>
	 <COND (<OR <EQUAL? <LOC ,SCARE3> ,HERE>
		    <AND <T? ,BADKEY>
			 <EQUAL? <LOC ,BADKEY> ,PLAYER ,HERE>>>
		<INC FEAR>
		<SET EMOTION <PICK-NEXT ,FEAR-CORBIES>>)>
	 <SET X <RANDOM 100>>
	 <COND (<L? .X 33>
		<TELL "Corbies " .SOUND ,WITH .EMOTION
		      " overhead." CR>
		<RTRUE>)
	       (<L? .X 67>
		<TELL "You can hear corbies ">)
	       (T
		<TELL "Corbies ">
		<SET X <RANDOM 100>>
		<COND (<OR <T? .FEAR>
			   <L? .X 33>>
		       <TELL "circle ">
		       <COND (<PROB 50>
			      <COND (<ZERO? .FEAR>
				     <TELL "low ">)
				    (T
				     <TELL "high ">)>)>)
		      (<L? .X 67>
		       <TELL "dive ">
		       <COND (<PROB 50>
			      <TELL "down from ">)
			     (T
			      <TELL "and swoop ">)>)
		      (T
		       <TELL "swoop ">
		       <COND (<PROB 50>
			      <COND (<PROB 50>
				     <TELL "low ">)
				    (T
				     <TELL "down from ">)>)>)>)>
	 <TELL "overhead, " .SOUND "ing with " .EMOTION ,PERIOD>
	 <RTRUE>>

<CONSTANT RESET-GURDY 4>
<GLOBAL GURDY-TIMER:NUMBER 0>

<GLOBAL GURDY-ROOM:OBJECT <>>

<ROUTINE I-COLOR ("AUX" X)
	 <COND (<DLESS? GURDY-TIMER 1>
		<DEQUEUE ,I-COLOR>
		<SETG GURDY-TIMER 0>
		<UNMAKE ,ROSE-ROOM ,SEEN>
		<SET X <GETB ,PLAIN-ROOMS 0>>
		<REPEAT ()
		   <UNMAKE <GETB ,PLAIN-ROOMS .X> ,SEEN>
		   <COND (<DLESS? X 1>
			  <RETURN>)>>
		<COND (<HERE? GURDY-ROOM>
		       <WINDOW ,SHOWING-ROOM>
		       <SETG GURDY-ROOM <>>
		       <TELL ,TAB "The colors in the ">
		       <ROOM-OR-LAND>
		       <TELL " fade back to normal." CR>
		       <RTRUE>)>
		<SETG GURDY-ROOM <>>
		<RFALSE>)
	       (<NOT <HERE? GURDY-ROOM>>
		<RFALSE>)
	       (<EQUAL? ,GURDY-TIMER 1 3>
		<RFALSE>)>
	 <TELL ,TAB "The heightened colors in the ">
	 <ROOM-OR-LAND>
	 <TELL " are starting to fade." CR>
	 <RTRUE>>

<GLOBAL LAST-CRANK-DIR:OBJECT <>>

<ROUTINE TURN-GURDY ("AUX" X)
	 <SET X ,TURN-GURDY-RIGHT>
	 <COND (<EQUAL? ,LAST-CRANK-DIR ,RIGHT>)
	       (<OR <EQUAL? ,LAST-CRANK-DIR ,LEFT>
		    <PROB 50>>
		<SET X ,TURN-GURDY-LEFT>)>
	 <APPLY .X>
	 <RFALSE>>

<ROUTINE FIND-CHAR? ("AUX" LEN OBJ)
	 <SET LEN <GET ,CHARLIST 0>>
	 <REPEAT ()
	    <SET OBJ <GET ,CHARLIST .LEN>>
	    <COND (<VISIBLE? .OBJ>
		   <RETURN .OBJ>)
		  (<DLESS? LEN 1>
		   <RETURN>)>>
	 <RETURN <FIND-IN? ,HERE ,MONSTER>>>

<ROUTINE TURN-GURDY-RIGHT ("AUX" (M 0) (P 0) WHO)
	 <SET WHO <FIND-CHAR?>>
	 <COND (<ZERO? .WHO>)
	       (<IS? .WHO ,MONSTER>
		<COND (<NOT <IS? .WHO ,SLEEPING>>
		       <INC M>)>)
	       (T
		<INC P>)>
	 <SETG LAST-CRANK-DIR ,RIGHT>
	 <COND (<TURN-GURDY? ,W?RIGHT "violet">
		<RTRUE>)>
	 <TELL ,TAB>
	 <COND (<ZERO? ,DPOINTER>
		<WINDOW ,SHOWING-ALL>
		<SETG P-WALK-DIR <>>
		<SETG OLD-HERE <>>
		<SETG GURDY-TIMER ,RESET-GURDY>
		<SETG LIT? T>
		<TELL "A rainbow of dazzling spectra">
		<PRINT " fills the air">
		<TELL "! It swirls and blends with the ">
		<COND (<NOT <PLAIN-ROOM?>>
		       <COND (<HERE? GURDY-ROOM>
			      <TELL "already intense ">)>
		       <TELL "colors of the ">)
		      (T
		       <MAKE ,HERE ,SEEN>
		       <TELL "colorless ">)>
		<ROOM-OR-LAND>
		<COND (<HERE? GURDY-ROOM>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<SETG GURDY-ROOM ,HERE>
		<QUEUE I-COLOR>
		<TELL 
", creating rich, saturated hues that remind you of a postcard">
		<COND (<T? .M>
		       <PRINT ". Unfortunately, ">
		       <TELL THE .WHO " seems unmoved by the display">)>
		<TELL ,PERIOD>
		<COND (<HAPPY-CHAR? .WHO>
		       <RTRUE>)
		      (<EQUAL? .WHO ,OWOMAN ,SALT>
		       <LOVELY .WHO>
		       <RTRUE>)
		      (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB CTHE .WHO " gapes at the display." CR>)>
		<RTRUE>)
	       
	       (<EQUAL? ,DPOINTER 1>
		<TELL "Strains of soothing melody fill the air">
		<PRINT "! You can't help but ">
		<PRINT "close your eyes for a moment ">
		<TELL 
"as the liquid chords swell to a glorious crescendo, then fade into silence">
		<COND (<T? .M>
		       <TELL ". Even " THE .WHO " was not unmoved">)>
		<TELL ,PERIOD>
		<COND (<VISIBLE? ,DACT>
		       <MAKE ,DACT ,SEEN>
		       <COND (<T? ,DACT-SLEEP>
			      <COND (<NOT <EQUAL? ,DACT-SLEEP 3>>
				     <INC DACT-SLEEP>)>
			      <RTRUE>)>
		       <TELL ,TAB>
		       <TELL "A tear trembles on " THE ,DACT
			     "'s beak. You watch as it">
		       <DACT-TO-SLEEP T>
		       <RTRUE>)
		      (<HAPPY-CHAR? .WHO>
		       <RTRUE>)
		      (<EQUAL? .WHO ,OWOMAN ,MAYOR ,CLERIC>
		       <LOVELY .WHO>
		       <RTRUE>)
		      (<EQUAL? .WHO ,SALT>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB "\"Thought I heard music,\" remarks "
			     THE .WHO ,PERIOD>
		       <RTRUE>)
		      (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB CTHE .WHO " smiles at the sound." CR>
		       <RTRUE>)>
		<RTRUE>)
	       
	       (<EQUAL? ,DPOINTER 2>
		<TELL "A tide of flavorful aromas">
		<PRINT " fills the air">
		<PRINT "! You can't help but ">
		<TELL 
"breathe deeply as the scents of a dozen exotic delicacies drift past your nostrils, one by one">
		<COND (<T? .M>
		       <NOW-HUNGRY .WHO>)>
		<TELL ,PERIOD> 
		<COND (<HAPPY-CHAR? .WHO>
		       <RTRUE>)
		      (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB "\"Ahhh,\" sighs " THE .WHO ,PERIOD>)>
		<RTRUE>)
	       
	       (<EQUAL? ,DPOINTER 3>
		<TELL 
"A mouthwatering cascade of flavor washes over your tongue">
		<PRINT "! You can't help but ">
		<PRINT "close your eyes for a moment ">
		<TELL "to savor the taste of all your favorite dishes">
		<COND (<T? .M>
		       <NOW-HUNGRY .WHO>)>
		<PRINT ,PERIOD> 
		<COND (<HAPPY-CHAR? .WHO>
		       <RTRUE>)
		      (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB "\"Mmmmm,\" sighs " THE .WHO ", smacking ">
		       <COND (<IS? .WHO ,FEMALE>
			      <TELL "her">)
			     (T
			      <TELL "his">)>
		       <TELL " lips." CR>)>
		<RTRUE>)
	       
	       (<EQUAL? ,DPOINTER 4>
		<TELL "Invisible fingers of delight caress your skin! ">
		<PRINT "! You can't help but ">
		<PRINT "close your eyes for a moment ">
		<TELL
"as a soothing, sensuous tingle spreads over every inch of your body"> 
		<COND (<T? .M>
		       <TELL ,PTAB CTHE .WHO
			     " emits a brief moan of pleasure">)>
		<PRINT ,PERIOD> 
		<COND (<HAPPY-CHAR? .WHO>
		       <RTRUE>)
		      (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB "\"Mmmmm,\" moans " THE .WHO ,PERIOD>)>
		<RTRUE>)>
	 
	 <RENEW-ALL-IN ,INGURDY>
	 <TELL "A flood of joyful memory swells in your mind">
	 <PRINT "! You can't help but ">
	 <PRINT "close your eyes for a moment ">
	 <TELL 
"as old friends and forgotten secrets rise one by one from of the mists of time, then fade into obscurity"> 
	 <COND (<T? .M>
		<LAST-MEAL .WHO>)>
	 <PRINT ,PERIOD>
	 <COND (<HAPPY-CHAR? .WHO>
		<RTRUE>)
	       (<T? .P>
		<MAKE .WHO ,SEEN>
		<TELL ,TAB CTHE .WHO " smiles wistfully." CR>)>
	 <RTRUE>>

<ROUTINE LOVELY (WHO)
	 <MAKE .WHO ,SEEN>
	 <TELL ,TAB "\"Lovely,\" remarks " THE .WHO ,PERIOD>
	 <RTRUE>>

<ROUTINE LAST-MEAL (WHO)
	 <PRINT ". Unfortunately, ">
	 <TELL THE .WHO " seem">
	 <COND (<NOT <IS? .WHO ,PLURAL>>
		<TELL "s">)>
	 <TELL " to remember only its last meal">
	 <RTRUE>>

<ROUTINE NOW-HUNGRY (WHO)
	 <PRINT ". Unfortunately, ">
	 <TELL THE .WHO " now looks hungrier than before">
	 <RTRUE>>

<ROUTINE HAPPY-CHAR? (WHO)
	 <COND (<OR <EQUAL? .WHO ,MINX ,UNICORN ,BABY>
		    <EQUAL? .WHO ,MAMA ,DACT>>
		<TELL ,TAB CTHE .WHO " seemed to enjoy that." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE UNHAPPY-CHAR? (WHO)
	 <COND (<OR <EQUAL? .WHO ,MINX ,UNICORN ,BABY>
		    <EQUAL? .WHO ,MAMA ,DACT>>
		<TELL ,TAB CTHE .WHO " gives you a hurt look." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TURN-GURDY-LEFT ("AUX" (M 0) (P 0) WHO)
	 <SET WHO <FIND-CHAR?>>
	 <COND (<ZERO? .WHO>)
	       (<IS? .WHO ,MONSTER>
		<COND (<NOT <IS? .WHO ,SLEEPING>>
		       <INC M>)>)
	       (T
		<INC P>)>
	 <SETG LAST-CRANK-DIR ,LEFT>
	 <COND (<TURN-GURDY? ,W?LEFT "crimson">
		<RTRUE>)>
	 <TELL ,TAB>
	 <COND (<ZERO? ,DPOINTER>
		<WINDOW ,SHOWING-ALL>
		<COND (<T? ,GURDY-TIMER>
		       <SETG GURDY-TIMER 0>
		       <DEQUEUE ,I-COLOR>)>
		<TELL ,XTHE>
		<COND (<HERE? GURDY-ROOM>
		       <TELL "colors in the ">
		       <ROOM-OR-LAND>
		       <TELL " around you fade back to ">
		       <COND (<PLAIN-ROOM?>
			      <SETG OLD-HERE <>>
			      <SETG P-WALK-DIR <>>
			      <UNMAKE ,HERE ,SEEN>
			      <TELL B ,W?GRAY>)
			     (T
			      <TELL "normal">)>)
		      (T
		       <COND (<PLAIN-ROOM?>
			      <TELL "grayness">)
			     (T
			      <TELL "color">)>
		       <TELL " of the ">
		       <ROOM-OR-LAND>
		       <TELL " around you becomes pasty and dull">)>
		<SETG GURDY-ROOM <>>
		<COND (<T? .M>
		       <TELL ", an effect " THE .WHO " seem">
		       <COND (<NOT <IS? .WHO ,PLURAL>>
			      <TELL "s">)>
		       <TELL " not to mind in the least">)>
		<TELL ,PERIOD>
		<COND (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB CTHE .WHO 
			     " glances around, puzzled." CR>)>
		<RTRUE>)
	       
	       (<EQUAL? ,DPOINTER 1>
		<TELL
"A dreadful cacophony of random noise">
		<PRINT " fills the air">
		<TELL 
"! You cover your ears and wince until the onslaught fades to a welcome silence">
		<COND (<T? .M>
		       <ANNOY-WHO .WHO>)>
		<TELL ,PERIOD>
		<COND (<UNHAPPY-CHAR? .WHO>
		       <RTRUE>)
		      (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB "\"Ouch,\" comments " THE .WHO>
		       <PRINT " with a glare of annoyance.|">)>
	        <RTRUE>)
	       
	       (<EQUAL? ,DPOINTER 2>
		<TELL
"A nauseating cloud of foul, reeking stenches">
		<PRINT " fills the air">
		<TELL "! You cover your nose and try not to gag as the air clears all too slowly">
		<COND (<T? .M>
		       <TELL ", noting that " THE .WHO " seem">
		       <COND (<NOT <IS? .WHO ,PLURAL>>
			      <TELL "s">)>
		       <TELL " to have enjoyed the disgusting onslaught">)>
		<TELL ,PERIOD>
		<COND (<UNHAPPY-CHAR? .WHO>
		       <RTRUE>)
		      (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB "\"Put that away,\" coughs " THE .WHO>
		       <PRINT " with a glare of annoyance.|">)>
		<RTRUE>)
	       
	       (<EQUAL? ,DPOINTER 3>
		<TELL
"The unspeakable flavor of dead, rotting filth coats your tongue! You spit and cough uncontrollably until your mouth absorbs the dreadful taste">
		<COND (<T? .M>
		       <ANNOY-WHO .WHO>)>
		<TELL ,PERIOD>
		<COND (<UNHAPPY-CHAR? .WHO>
		       <RTRUE>)
		      (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB "\"Enough,\" gags " THE .WHO>
		       <PRINT " with a glare of annoyance.|">)>
		<RTRUE>)
	       
	       (<EQUAL? ,DPOINTER 4>
		<TELL
"Your skin erupts in a dozen places with a painful, burning itch! No scratching can relieve the suffering you endure until the invisible rash subsides">  
		<COND (<T? .M>
		       <ANNOY-WHO .WHO>)>
		<TELL ,PERIOD>
		<COND (<UNHAPPY-CHAR? .WHO>
		       <RTRUE>)
		      (<T? .P>
		       <MAKE .WHO ,SEEN>
		       <TELL ,TAB "\"Thanks,\" mutters " THE .WHO>
		       <PRINT " with a glare of annoyance.|">)>
		<RTRUE>)>
	 
	 <MUNG-ALL-IN ,INGURDY>
	 <TELL
"A black tide of memory swells in your mind! You blush with shame as thoughtless deeds and filthy little secrets emerge from the dark reaches of your past to taunt you">
	 <COND (<T? .M>
		<LAST-MEAL .WHO>)>
	 <PRINT ,PERIOD>
	 <COND (<UNHAPPY-CHAR? .WHO>
		<RTRUE>)
	       (<T? .P>
		<MAKE .WHO ,SEEN>
		<TELL ,TAB CTHE .WHO " gives you a bitter glare." CR>)>
	 <RTRUE>>
	 
<ROUTINE ANNOY-WHO (WHO)
	 <PRINT ". Unfortunately, ">
	 <TELL THE .WHO " now look">
	 <COND (<NOT <IS? .WHO ,PLURAL>>
		<TELL "s">)>
	 <TELL " more annoyed than ever">
	 <RFALSE>>

<ROUTINE TURN-GURDY? (WRD STR)
	 <COND (<NO-MAGIC-HERE? ,GURDY>
		<RTRUE>)>
	 <TELL "You turn the crank on " THE ,GURDY " to the " B .WRD 
	       ", and watch as ">
	 <COND (<IS? ,GURDY ,OPENED>
		<TELL "wraiths of soft " .STR 
" light escape from the open box, dispersing with no effect." CR>
		<RTRUE>)>
	 <TELL "a soft " .STR 
" glow brightens the rim of the closed lid." CR> 
	 <RFALSE>>

<ROUTINE ROOM-OR-LAND ()
	 <COND (<IS? ,HERE ,INDOORS>
		<PRINTD ,GLOBAL-ROOM>
		<RTRUE>)>
	 <PRINTB ,W?LANDSCAPE>
	 <RTRUE>>

<ROUTINE REGAIN-SENSES ()
	 <SETG P-WALK-DIR <>>
	 <SETG OLD-HERE <>>
	 <CARRIAGE-RETURNS>
	 <TELL "You slowly come to your senses." CR>
	 <COND (<T? ,VERBOSITY>
		<CRLF>)>
	 <RFALSE>>

<GLOBAL STORM-TIMER:NUMBER 0>

<ROUTINE I-STORM ()
	 <COND (<DLESS? STORM-TIMER 1>
		<REMOVE ,TWISTER>
		<SETG STORM-TIMER 0>
		<DEQUEUE ,I-STORM>
		<WINDOW ,SHOWING-ROOM>
		<PUTP ,IN-FARM ,P?SDESC 0>
		<MAKE ,IN-FARM ,SEEN>
		<PRINT ,TAB>
		<ITALICIZE "Crash">
		<TELL "! " CTHE ,FARMHOUSE " strikes " THE ,GROUND 
" with a sickening thud. You're thrown across the room, hit " 'HEAD
" and...||||||A ray of sunlight opens your eyes." CR>
		<RTRUE>)
	       (<EQUAL? ,STORM-TIMER 2>
		<TELL ,TAB CTHE ,FLOOR " lurches crazily underfoot." CR>
		<RTRUE>)
	       (<EQUAL? ,STORM-TIMER 1>
		<TELL "  The entire " 'FARMHOUSE
		      " shudders as " THE ,TWISTER
" loosens its grip. It feels as if you're starting to fall!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		 
<ROUTINE I-TWISTER ("AUX" X)
	 <MAKE ,CORBIES ,SEEN>
	 <TELL ,TAB>
	 <COND (<DLESS? STORM-TIMER 1>
		<DEQUEUE ,I-TWISTER>
		<DEQUEUE ,I-CORBIES>
		<TELL "The wind ">
		<COND (<HERE? IN-FARM>
		       <PRINT "outside ">)>
		<TELL
"rises to a deafening shriek, and blowing dust turns the day to night" ,PTAB>
		<ITALICIZE "Thwack">
		<TELL "! The ">
		<COND (<HERE? FARM-ROOM>
		       <TELL 'TWISTER 
" rips a clapboard off " THE ,FARMHOUSE 
", blows it across the yard and drives it deep into your chest"> 
		       <JIGS-UP>
		       <RTRUE>)>
		<MAKE ,FARMHOUSE ,SEEN>
		<SETG STORM-TIMER ,INIT-STORM-TIMER>
		<QUEUE ,I-STORM>
		<PUTP ,IN-FARM ,P?SDESC ,DESCRIBE-IN-FARM>
		<WINDOW ,SHOWING-ROOM>
		<PUTP ,IN-FARM ,P?FNUM 0>
		<NEW-EXIT? ,IN-FARM ,P?NORTH %<+ ,DCONNECT 1 ,MARKBIT>
			   ,IN-FROON ,FARM-DOOR>
		<NEW-EXIT? ,IN-FARM ,P?OUT %<+ ,DCONNECT 1 ,MARKBIT>
			   ,IN-FROON ,FARM-DOOR>
		<COND (<IS? ,FARM-DOOR ,OPENED>
		       <UNMAKE ,FARM-DOOR ,OPENED>
		       <TELL 'FARM-DOOR " slams shut as the ">)>
		<TELL 'FARMHOUSE
" jerks violently upward, throwing you to your knees. You feel a strange whirling sensation as " THE ,FLOOR
" begins to dip and sway like the deck of a boat. A glance out "
THE ,FARM-WINDOW " confirms what your popping ears already know: "
CTHE ,FARMHOUSE " is soaring high above the Fields of Frotzen, caught in the vortex of a mighty " 'TWISTER "!" CR>
		<REFRESH-MAP <>>
		<RTRUE>)
	       (<EQUAL? ,STORM-TIMER 1>
		<TELL "The wind ">
		<COND (<HERE? IN-FARM>
		       <PRINT "outside ">)>
		<TELL 
"grows from a rumble to a roar as the churning vortex whirls closer." CR>
		<COND (<HERE? IN-FARM>
		       <RTRUE>)
		      (<NOT <IS? ,FARM-DOOR ,OPENED>>
		       <WINDOW ,SHOWING-ROOM>
		       <MAKE ,FARM-DOOR ,OPENED>
		       <TELL ,TAB>
		       <ITALICIZE "Bang">
		       <TELL "! " CTHE ,FARM-DOOR 
			     " blows open in the gale." CR>)>
		<COND (<VISIBLE? ,MINX>
		       <MOVE ,MINX ,IN-FARM>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL ,TAB CTHE ,MINX 
			     " races for the safety of " 
			     THE ,FARM ,PERIOD>)> 
		<RTRUE>)
	       (<EQUAL? ,STORM-TIMER 2>
		<MOVE ,TWISTER ,HERE>
		<WINDOW ,SHOWING-ROOM>
		<TELL "An ominous rumble ">
		<SET X ,W?SOUTHEAST>
		<COND (<HERE? IN-FARM>
		       <MAKE ,TWISTER ,NODESC>
		       <SET X ,W?WINDOW>
		       <PRINT "outside ">)>
		<TELL "draws your eyes to the " B .X
", where a dark, boiling thundercloud is racing across the fields" ,PTAB>
		<KERBLAM>
		<TELL 
"Lightning heralds the approach of a deadly funnel!" CR>  
		<RTRUE>)
	       (<EQUAL? ,STORM-TIMER 3>
		<TELL "The sky ">
		<COND (<HERE? IN-FARM>
		       <TELL "outside ">)>
		<TELL "is becoming very dark." CR>
		<COND (<VISIBLE? ,MINX>
		       <TELL ,TAB CTHE ,MINX 
			     " sniffs the air and whimpers." CR>)>
		<RTRUE>)
	       (T
		<TELL "The air feels unusually still and expectant." CR>
		<RTRUE>)>>
	 
<GLOBAL FSCRIPT:NUMBER 0>

<ROUTINE I-FROON ()
	 <COND (<HERE? IN-FARM>
		<COND (<G? ,FSCRIPT 2>
		       <COND (<IS? ,FCROWD ,SEEN>
			      <UNMAKE ,FCROWD ,SEEN>
			      <RFALSE>)>
		       <MAKE ,FCROWD ,SEEN>
		       <TELL ,TAB 
"The cheers outside show no sign of stopping." CR>
		       <RTRUE>)>
		<RFALSE>)>
	 <TELL ,TAB>
	 <COND (<IGRTR? FSCRIPT 11>
		<TELL
"As you stand contemplating the natural beauty of the " 'FROON 
"ian landscape, another " 'FARMHOUSE 
" falls out of the sky and lands on " 'HEAD>
		<JIGS-UP>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 11>
		<WINDOW ,SHOWING-ROOM>
		<PUTP ,IN-FROON ,P?HEAR 0>
		<REMOVE ,MAYOR>
		<SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
		<REMOVE ,LADY>
		<SETG P-HER-OBJECT ,NOT-HERE-OBJECT>
		<REMOVE ,FCROWD>	
		<SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>
		<TELL "With a peremptory sniff, " THE ,MAYOR
" snaps " THE ,JBOX " shut" ,PTAB "\"Very well,\" he sighs. \"I'm sure there are plenty of other heroes who would be more than happy to accept our humble gifts and everlasting adulation.\"|
  Grumbling with indignation, he and the other folk sullenly retreat into "
THE ,FBEDS ". In moments, you are completely alone." CR>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 10>
		<TELL "\"The day is getting long,\" notes " THE ,MAYOR
" with obvious irritation. \"Please choose one of the keys. ">
		<ITALICIZE "Now">
		<TELL ,PERQ>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 9>
		<TELL CTHE ,MAYOR " taps his foot impatiently. \"" ,CYOUR>
		<HONORED-ONE>
		<TELL " will be so kind as to select a key?\"" CR>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 8>
		<TELL "\"Choose any key you like,\" prompts " THE ,MAYOR
		      " helpfully." CR>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 7>
		<WINDOW ,SHOWING-ROOM>
		<MAKE ,JBOX ,OPENED>
		<TELL CTHE ,MAYOR " opens " THE ,JBOX
" with a grand flourish.|  \"Behold!\" he cries. \"Herein lie the Keys to the Kingdom of " 'FROON 
". This gift is the greatest honor my people can bestow. Humbly, and with eternal gratitude, do we offer one to you.\"" CR ,TAB CTHE ,FCROWD
" redoubles its cheering." CR>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 6>
		<WINDOW ,SHOWING-ROOM>
		<MOVE ,JBOX ,MAYOR>
		<TELL 
"\"Such a mighty deed commands many thanks,\" continues " THE ,MAYOR 
". \"Bring me the Cask!\"|
  \"The Cask! " CTHE ,MAYOR " sends for the Cask!\" whispers " THE ,FCROWD
" as a servant disappears into " THE ,FBEDS
". Moments later he returns bearing a small "
'JBOX ", which is delivered to " THE ,MAYOR ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 5>
		<TELL
"\"For over three hundred years, my people have suffered in the shadow of the Heeled One,\" explains " THE ,MAYOR ", glancing hatefully at " THE ,BOOT
". \"At long last, his evil-smelling reign is at an end!\"|
  \"Huzzah!\" cries " THE ,FCROWD ", dancing gleefully around " THE ,FARMHOUSE
". \"Huzzah! The Boot is licked!\"" CR>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 4>
		<WINDOW ,SHOWING-ROOM>
		<MOVE ,MAYOR ,IN-FROON>
		<SEE-CHARACTER ,MAYOR>
		<MAKE ,FCROWD ,NODESC>
		<PUTP ,IN-FROON ,P?HEAR ,MAYOR>
		<TELL 
"An important-looking man, tinier than all the rest, emerges from "
THE ,FCROWD ,PTAB "\"Greetings, brave ">
		<SAY-SORC>
		<TELL ",\" he mumbles, grovelling at your feet. \"I am Grope, Mayor of the City of " 'FROON ". On behalf of us all, I welcome you!\"|
  \"Welcome! Welcome to the ">
		<SAY-SORC>
		<TELL "!\" echoes " THE ,FCROWD " joyfully." CR>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 3>
		<WINDOW ,SHOWING-ROOM>
		<MOVE ,FCROWD ,IN-FROON>
		<SETG P-THEM-OBJECT ,FCROWD>
		<PUTP ,IN-FROON ,P?HEAR ,FCROWD>
		<MAKE ,LADY ,NODESC>
		<TELL
"\"The Heeled One is fallen! Come see! Come see!\"|
  More and more of the little folk emerge from " THE ,FBEDS
", staring first at the crushed boot, then at you. Soon you're completely surrounded by joyous little faces." CR>
		<RTRUE>)
	       (<EQUAL? ,FSCRIPT 2>
		<TELL CTHE ,LADY " tiptoes over to " THE ,BOOT
" and gawks at it, awestruck. She gingerly reaches out to tickle the lifeless sole. Nothing happens. A broad grin spreads across her childlike face.|
  \"It's dead,\" she squeaks, turning to look at you. \"You killed it.\"" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE SAY-SORC ()
	 <TELL "sorcere">
	 <COND (<IS? ,PLAYER ,FEMALE>
		<TELL "ss">
		<RTRUE>)>
	 <PRINTC %<ASCII !\r>>
	 <RTRUE>>

<GLOBAL SHILL-TIMER:NUMBER 0>

<ROUTINE I-SHILL ()
	 <COND (<IS? ,SHILL ,NODESC>
		<UNMAKE ,SHILL ,NODESC>
		<RFALSE>)
	       (<IGRTR? SHILL-TIMER 5>
		<DEQUEUE ,I-SHILL>
		<SETG SHILL-TIMER 0>
		<VANISH ,SHILL>
		<COND (<HERE? ON-WHARF>
		       <TELL ,TAB CTHE ,SHILL
			     " slowly floats out of sight." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<NOT <HERE? ON-WHARF>>
		<RFALSE>)
	       (<EQUAL? ,SHILL-TIMER 4>
		<TELL ,TAB CTHE ,SHILL " is beginning to float away." CR>
		<RTRUE>)
	       (<EQUAL? ,SHILL-TIMER 1>
		<TELL ,TAB>
		<SEE-SHILL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SEE-SHILL ()
	 <MAKE ,SHILL ,SEEN>
	 <SETG SHILL-TIMER 1>
	 <WINDOW ,SHOWING-ROOM>
	 <SETG P-IT-OBJECT ,SHILL>
	 <MOVE ,SHILL ,COVE>
	 <TELL "A movement draws your eye to the water, where "
	        A ,SHILL " is bobbing on the waves." CR>
	 <RTRUE>>

<GLOBAL DACT-SLEEP:NUMBER 0>

<ROUTINE I-DACT ("AUX" (V <>) X)
	 <SET V <VISIBLE? ,DACT>>
	 <COND (<T? ,DACT-SLEEP>
		<DEC DACT-SLEEP>
		<COND (<EQUAL? ,DACT-SLEEP 3>
		       <RFALSE>)
		      (<T? .V>
		       <TELL ,TAB>)>
		<COND (<ZERO? ,DACT-SLEEP>
		       <WAKE-DACT>
		       <RTRUE>)
		      (<ZERO? .V>
		       <RFALSE>)>
		<TELL CTHE ,DACT>
		<COND (<EQUAL? ,DACT-SLEEP 1>
		       <TELL 
" snorts restlessly. It looks as if it's about to wake up." CR>
		       <RTRUE>)>
		<TELL " caws softly in its dreams." CR>
		<RTRUE>)>
	 <COND (<ZERO? .V>
		<RFALSE>)
	       (<IS? ,DACT ,SEEN>
		<UNMAKE ,DACT ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <MAKE ,DACT ,SEEN>
	 <SET X ,HAPPY-DACT>
	 <COND (<HERE? IN-SKY>
		<SET X ,FLYING-DACT>)
	       (<IS? ,DACT ,MUNGED>
		<SET X ,SICK-DACT>)>
	 <TELL ,TAB CTHE ,DACT <PICK-NEXT .X> ,PERIOD>
	 <RTRUE>>

<ROUTINE WAKE-DACT ()
	 <REPLACE-ADJ? ,DACT ,W?SLEEPING ,W?AWAKE>
	 <UNMAKE ,DACT ,SLEEPING>
	 <MAKE ,DACT ,SEEN>
	 <SETG DACT-SLEEP 0>
	 <COND (<VISIBLE? ,DACT>
		<WINDOW ,SHOWING-ALL>
		<TELL CTHE ,DACT 
" shakes its head, blinks its eyes and yawns stupidly." CR>
		<COND (<AND <IS? ,DACT ,MUNGED>
			    <IN? ,SADDLE ,DACT>>
		       <MOVE ,SADDLE ,HERE>
		       <TELL ,TAB CTHE ,SADDLE ,SON THE ,DACT
"'s back aggravates his wound. So he shakes it off with a violent twist">
		       <COND (<IN? ,PLAYER ,SADDLE>
			      <MOVE ,PLAYER ,HERE>
			      <TELL 
", which sends you sprawling to " THE ,GROUND>
			      <RELOOK>
			      <RTRUE>)>
		       <PRINT ,PERIOD>
		       <WINDOW ,SHOWING-ROOM>)>)>
	 <RTRUE>>

<GLOBAL GRTIMER:NUMBER 0>

<ROUTINE I-GRINDER-APPEARS ()
	 <COND (<NOT <HERE? AT-GATE>>
		<RFALSE>)
	       (<DLESS? GRTIMER 1>
		<SETG GRTIMER 0>
		<DEQUEUE ,I-GRINDER-APPEARS>		
		<MOVE ,GRINDER ,AT-GATE>
		<SEE-GRINDER>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB "Blue planes of energy form in the space around you. Their patterns of intersection whirl around a vortex of laughter, growing in power and malevolence.." ,PERIOD>
		<COND (<OR <ZERO? ,DMODE>
			   <EQUAL? ,PRIOR ,SHOWING-INV ,SHOWING-STATS>>
		       <RELOOK T>)>
		<RTRUE>)
	       (<EQUAL? ,GRTIMER 1>
		<TELL ,TAB 
"The invisible voice chuckles again, and the tension in the air rises." CR>
		<RTRUE>)
	       (<EQUAL? ,GRTIMER 2>
		<TELL ,TAB 
"A burst of hollow laughter echoes up and down the street. You turn, but see no one" ,PTAB "There's a faint, electrical tension in the air." CR>
		<RTRUE>)	       
	       (T
		<RFALSE>)>>

<ROUTINE SEE-GRINDER ()
	 <SEE-CHARACTER ,GRINDER>
	 <QUEUE ,I-GRINDER>
	 <SETG LAST-MONSTER ,GRINDER>
	 <SETG LAST-MONSTER-DIR <>>
	 <MAKE ,GRINDER ,SEEN>
	 <RFALSE>>

<ROUTINE I-GRINDER ()
	 <COND (<NOT <HERE? AT-GATE>>
		<RFALSE>)>
	 <INC GRTIMER>
	 <TELL ,TAB>
	 <COND (<L? <GETP ,GRINDER ,P?ENDURANCE> 1>
		<EXIT-GRINDER>
		<TELL CTHE ,GURDY " falls from " THE ,GRINDER
"'s dying grasp. Moments later, his body dissolves in a puff of steam." CR>
		<RTRUE>)>
	 <NEXT-ENDURANCE? ,GRINDER>
	 <COND (<EQUAL? ,GRTIMER 1>
		<TELL CTHE ,GRINDER 
" looks you up and down. \"Peasants,\" he sniffs, adjusting a knob on his "
'GURDY ". \"Like unto sheep.\"|
  He turns the crank of " THE ,GURDY ", and the air is filled with the combined stench of five herds of sheep, accompanied by a cacophany of hateful bleating." CR>)
	       (<EQUAL? ,GRTIMER 2>
		<UNMAKE ,NYMPH ,LIVING>
		<TELL "Ignoring you for the moment, " THE ,GRINDER 
" strides across to " THE ,GUILD-HALL "'s entrance.|
  A warning nymph appears beside his ">
		<NYMPH-SAYS>
		<TELL 
"... Oomph!\" This last exclamation is " THE ,NYMPH
"'s last; for, quick as a wink, " 
THE ,GRINDER " snatches it out of the air and crushes it in his fist. \"Miserable pests.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,GRTIMER 3>
		<TELL CTHE ,GRINDER
" turns around. \"Still here?\" he cries, adjusting his " 'GURDY ,PTAB
"He turns the crank again, and a wall of imaginary flame springs up around you. You wail as your skin burns with synthetic agony." CR>)
	       (<EQUAL? ,GRTIMER 4>
		<TELL
"\"Guess I'll just have to finish you off.\"" CR ,TAB>)>
	 
	 <COND (<G? ,GRTIMER 3>
		<TELL CTHE ,GRINDER " turns the crank, and "
		      <PICK-NEXT ,TORTURES> ,PERIOD>)>
	 
	 <COND (<T? ,AUTO>
		<BMODE-ON>)>
	 <UPDATE-STAT <- 0 <RANDOM <GETP ,GRINDER ,P?STRENGTH>>>>
	 <RTRUE>>

; <ROUTINE I-DISTANT-DORN ("AUX" X)
	 <COND (<IN? ,DORN ,HERE>
		<MAKE ,DORN ,SEEN>
		<RFALSE>)
	       (<OR <HERE? TOWER-TOP>
		    <SET X <INTBL? ,HERE <REST ,TOWER1-ROOMS 1> 4 1>>
		    <SET X <INTBL? ,HERE <REST ,TOWER2-ROOMS 1> 4 1>>
		    <SET X <INTBL? ,HERE <REST ,TOWER3-ROOMS 1> 4 1>>>
		<COND (<IS? ,DORN ,SEEN>
		       <UNMAKE ,DORN ,SEEN>
		       <RFALSE>)
		      (<PROB 50>
		       <RFALSE>)>
		<MAKE ,DORN ,SEEN>
		<TELL ,TAB>
		<COND (<SET X <INTBL? ,HERE <REST ,DORN-ROOMS 1> 5 1>>
		       <TELL <PICK-NEXT ,CLOSE-DORNS> CR>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,DORN-SOUNDS> CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL DORN-TIMER:NUMBER 0>

<ROUTINE I-DORN ("AUX" X L DIR TBL DEST DAMAGE)
	 <SET L <LOC ,DORN>>
	 <COND (<EQUAL? .L ,HERE>
		<MAKE ,DORN ,SEEN>
		<TELL ,TAB>
		<COND (<L? <GETP ,DORN ,P?ENDURANCE> 1>
		       <TELL "Howling with pain, " THE ,DORN 
			     " beats a hasty retreat." CR>
		     ; <DEQUEUE ,I-DISTANT-DORN>
		       <KILL-MONSTER ,DORN>
		       <RTRUE>)
		      (<IS? ,DORN ,MUNGED>
		       <TELL CTHE ,DORN>
		       <COND (<DLESS? DORN-TIMER 1>
			      <SETG DORN-TIMER 0>
			      <WINDOW ,SHOWING-ROOM>
			      <UNMAKE ,DORN ,MUNGED>
			      <TELL " sniffs away the last of its tears." CR>
			      <RTRUE>)
			     (<EQUAL? ,DORN-TIMER 1>
			      <TELL 
" blows its nose noisily. It looks as if it's recovering." CR>
			      <RTRUE>)
			     (<EQUAL? ,DORN-TIMER 2>
			      <TELL
" flails around the room, its eyes streaming. \"Hurumph!\" it bawls." CR>
			      <RTRUE>)>
		       <TELL 
" almost crashes into you in its blind frenzy. \"Hurumph!\" it cries, its face soaked with tears." CR>
		       <RTRUE>)
		      (<IS? ,DORN ,SURPRISED>
		       <SEE-MONSTER ,DORN>
		       <TELL CTHE ,DORN 
" begins turning its 69 eyes in your direction." CR>
		       <RTRUE>)>
		<NEXT-ENDURANCE? ,DORN>
		<SET DAMAGE <MONSTER-STRIKES? ,DORN>>
		<TELL CTHE ,DORN>
		<COND (<T? .DAMAGE>
		       <TELL <PICK-NEXT ,DORN-HITS> 
", and you feel strength drain from your body." CR>
		       <UPDATE-STAT .DAMAGE ,STRENGTH>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,DORN-MISSES> ,PERIOD>
		<RTRUE>)
	       (<IS? ,DORN ,MUNGED>
		<COND (<DLESS? DORN-TIMER 1>
		       <SETG DORN-TIMER 0>
		       <UNMAKE ,DORN ,MUNGED>)>
		<RFALSE>)
	       (<NOT <SET X <INTBL? ,HERE <REST ,DORN-ROOMS 1> 5 1>>>
		<REMOVE ,DORN>
		<UNMAKE ,DORN ,SLEEPING>
		<UNMAKE ,DORN ,MUNGED>
		<MAKE ,DORN ,SURPRISED>
		<SETG DORN-TIMER 0>
		<MAKE ,DORN ,NODESC>
		<DEQUEUE ,I-DORN>
		<RFALSE>)>
	 <SET DIR <MOVE-MONSTER? ,DORN T>>
	 <COND (<T? .DIR>
		<MAKE ,DORN ,SEEN>
		<TELL ,TAB>
		<COND (<PROB 50>
		       <TELL "\"Hurumph!\" ">)>
		<TELL CTHE ,DORN>
		<COND (<EQUAL? .DIR ,W?UP ,W?DOWN>
		       <TELL " clambers " B .DIR " the steps." CR>
		       <RTRUE>)>
		<PRINT " reappears from the ">
		<TELL B .DIR ,PERIOD>
		<RTRUE>)>
	 <RFALSE>>	 

<GLOBAL ONION-TIMER:NUMBER 0>

<ROUTINE I-ONION ("AUX" V)
	 <SET V <VISIBLE? ,ONION>>
	 <COND (<DLESS? ONION-TIMER 1>
		<SETG ONION-TIMER 0>
		<DEQUEUE ,I-ONION>
		<COND (<T? ,DORN-TIMER>
		       <SETG DORN-TIMER 1>)>
		<COND (<ZERO? .V>
		       <RFALSE>)>
		<TELL ,TAB CTHE ,ONION 
"'s sting diminishes enough to dry your eyes." CR>
		<RTRUE>)
	       (<ZERO? .V>
		<RFALSE>)>
	 <TELL ,TAB>
	 <COND (<AND <IN? ,DORN ,HERE>
		     <NOT <IS? ,DORN ,MUNGED>>>
		<WINDOW ,SHOWING-ROOM>
		<MAKE ,DORN ,MUNGED>
		<SETG DORN-TIMER 4>
		<MAKE ,DORN ,SEEN>
		<TELL CTHE ,DORN
"'s multiple eyes turn red and watery under the pungent influence of "
THE ,ONION ". \"Hurumph!\" it wails, utterly helpless" ,PTAB>)>
		   
	 <COND (<EQUAL? ,ONION-TIMER 1>
		<TELL CTHE ,ONION " seems to be losing its potency." CR>
		<RTRUE>)
	       (<EQUAL? ,ONION-TIMER 2>
		<TELL "You rub your swollen eyes to lessen " THE ,ONION
		      "'s pungent sting." CR>
	        <RTRUE>)>
	 <TELL "Your eyes become red and itchy as " THE ,ONION
	       "'s potent miasma">
	 <PRINT " fills the air">
	 <PRINT ,PERIOD>
	 <RTRUE>>

<VOC "ITCH" NOUN>
<VOC "LONG" ADJ> <VOC "SLENDER" ADJ> <VOC "ITCHY" ADJ>

<GLOBAL MOSS-TIMER:NUMBER 0>
<GLOBAL THIS-MOSS:OBJECT <>>
<GLOBAL MOSSES:NUMBER 0>

<ROUTINE I-MOSS ()
	 <COND (<IS? ,THIS-MOSS ,SEEN>
		<UNMAKE ,THIS-MOSS ,SEEN>
		<SETG MOSS-TIMER 6>
		<RFALSE>)
	       (<DLESS? MOSS-TIMER 1>
		<TELL ,TAB>
		<DO-MOSS>
		<RTRUE>)
	       (<EQUAL? ,MOSS-TIMER 2 4>
		<RFALSE>)>
	 <TELL ,TAB>
	 <COND (<EQUAL? ,MOSS-TIMER 1>
		<TELL "Those itchy fingers are becoming quite a nuisance">
		<COND (<G? ,MOSSES 1>
		       <TELL " again">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,MOSS-TIMER 3>
		<TELL "You give your fingers a satisfying scratch." CR>
		<RTRUE>)
	       (<EQUAL? ,MOSS-TIMER 5>
		<REPLACE-SYN? ,HANDS ,W?ZZZP ,W?ITCH>
		<REPLACE-ADJ? ,HANDS ,W?ZZZP ,W?ITCHY>
		<TELL "You idly scratch an itchy finger." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE DO-MOSS ("AUX" X)
	 <SETG THIS-MOSS <>>
	 <SETG MOSS-TIMER 0>
	 <DEQUEUE ,I-MOSS>
	 <MAKE ,HANDS ,MUNGED>
	 <REPLACE-ADJ? ,HANDS ,W?ITCHY ,W?LONG>
	 <REPLACE-ADJ? ,HANDS ,W?ZZZP ,W?SLENDER>	 
	 <COND (<T? ,LIT?>
		<SET X <LIGHT-SOURCE?>>
		<TELL "Damn that itch! You hold your bothersome hand up to ">
		<COND (<T? .X>
		       <TELL THE .X>)
		      (T
		       <TELL "the light">)>
		<COND (<G? ,MOSSES 1>
		       <TELL 
" and flex your fingers again, noting their improved agility">)
		      (T
		       <TELL "... and gasp with shock!" CR ,TAB 
"Your fingers, once fat and stubby, are now long and slender as a pianist's. You flex the new digits one at a time; they respond with unfamiliar agility. Fact is, your whole body feels tighter and more coordinated than ever">)>)
	       (T
		<TELL "Your fingers tingle oddly, and the itch disappears">)>
	 <PRINT ,PERIOD>
	 <UPDATE-STAT 8 ,DEXTERITY T>
	 <RTRUE>>

<ROUTINE I-UNICORN ()
	 <COND (<NOT <HERE? IN-STABLE>>
		<RFALSE>)
	       (<IS? ,STALL ,OPENED>
		<TELL ,TAB CTHE ,UNICORN
" wastes no time edging her way out of " THE ,STALL>
		<COND (<IN? ,CHEST ,HERE>
		       <TELL ,PERIOD>
		       <UNICORN-OPENS-CHEST>
		       <RTRUE>)>
		<TELL ". She ">
		<BYE-UNICORN>
		<RTRUE>)
	       (<IS? ,UNICORN ,SEEN>
		<UNMAKE ,UNICORN ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <MAKE ,UNICORN ,SEEN>
	 <SETG P-HER-OBJECT ,UNICORN>
	 <TELL ,TAB CTHE ,UNICORN " whinnies sadly." CR>
	 <RTRUE>>

<ROUTINE I-BABY ()
	 <COND (<NOT <HERE? JUN0>>
		<RFALSE>)
	       (<IS? ,BABY ,SEEN>
		<UNMAKE ,BABY ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <MAKE ,BABY ,SEEN>
	 <SETG P-HIM-OBJECT ,BABY>
	 <TELL ,TAB CTHE ,BABY " bellows helplessly">
	 <COND (<VISIBLE? ,MAMA>
		<MAKE ,MAMA ,SEEN>
		<COND (<PROB 50>
		       <SETG P-HER-OBJECT ,MAMA>
		       <TELL ", and its mother responds">)>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE I-MAMA ("AUX" DAMAGE TBL LEN X L NL PL PLL DIR)
	 <SET L <LOC ,MAMA>>
	 <SET PL <LOC ,PLAYER>>
	 <COND (<VISIBLE? ,MAMA>
		<COND (<NOT <IS? ,MAMA ,MONSTER>>
		       <COND (<IS? ,MAMA ,SEEN>
			      <UNMAKE ,MAMA ,SEEN>
			      <RFALSE>)
			     (<IS? ,MAMA ,MONSTER>)
			     (<PROB 50>
			      <RFALSE>)>
		       <SETG P-HER-OBJECT ,MAMA>
		       <MAKE ,MAMA ,SEEN>
		       <TELL ,TAB CTHE ,MAMA " bellows">
		       <COND (<VISIBLE? ,BABY>
			      <MAKE ,BABY ,SEEN>
			      <TELL " impotently">		
			      <COND (<PROB 50>
				     <SETG P-HIM-OBJECT ,BABY>
				     <TELL ", and her baby responds">)>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<SETG P-HER-OBJECT ,MAMA>
		<MAKE ,MAMA ,SEEN>
		<COND (<L? <GETP ,MAMA ,P?ENDURANCE> 1>
		       <TELL "  Bellowing with defeat, " THE ,MAMA 
			     " limps away into the jungle." CR>
		       <KILL-MONSTER ,MAMA>
		       <RTRUE>)>
		<COND (<STILL-SLEEPING? ,MAMA>
		       <RTRUE>)>
		<TELL ,TAB CTHE ,MAMA>
		<COND (<EQUAL? .L .PL>
		       <COND (<EQUAL? .L ,MAW>
			      <TELL <PICK-NEXT ,MAMA-CLIMBS>
				    ,PERIOD>
			      <RTRUE>)>
		       <SET X <MONSTER-STRIKES? ,MAMA>>
		       <TELL " charges you">
		       <COND (<T? .X>
			      <COND (<ZERO? ,STATIC>
				     <TELL ". Ooof!" CR>)
				    (T
				     <TELL ,PERIOD>)>
			      <UPDATE-STAT <MSPARK? ,MAMA .X>>
			      <RTRUE>)>
		       <TELL ", missing by a hair." CR>
		       <RTRUE>)
		      (<EQUAL? .PL ,MAW>
		       <MOVE ,MAMA ,MAW>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL 
" clambers onto the bottom of " THE .PL ", snorting with rage!" CR>
		       <RTRUE>)>
		<TELL " circles " THE .PL 
		      ", snorting angrily." CR>
		<RTRUE>)>

	 <COND (<NOT <IS? ,MAMA ,MONSTER>>
		<RFALSE>)>
	 
	 <SET NL <GETP ,MAMA ,P?LAST-LOC>>
	 <COND (<T? .NL>
		<MOVE ,MAMA .NL>
		<COND (<EQUAL? .NL ,HERE>
		       <SETG P-HER-OBJECT ,MAMA>
		       <PUTP ,MAMA ,P?LAST-LOC <>>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL ,TAB CTHE ,MAMA " storms into view!" CR>
		       <RTRUE>)>)>
	 
       ; "Is player in a room adjacent to mama?"

	 <COND (<NOT <WEARING-MAGIC? ,CLOAK>>
		<SET PLL <LOC .PL>>
		<SET DIR ,P?NORTH>
		<REPEAT ()
		   <SET TBL <GETP .L .DIR>>
		   <COND (<AND <T? .TBL>
			       <EQUAL? <MSB <GET .TBL ,XTYPE>>
				       ,CONNECT ,SCONNECT>>
			  <SET X <GET .TBL ,XROOM>>
			  <COND (<EQUAL? .X ,AT-FALLS>)
				(<EQUAL? .X .PL .PLL>
				 <PUTP ,MAMA ,P?LAST-LOC .X>
				 <RFALSE>)>)>
		   <COND (<DLESS? DIR ,P?NW>
			  <RETURN>)>>)>

	 <PUTP ,MAMA ,P?LAST-LOC 0>
	 <RFALSE>>

<GLOBAL IMPSAY:NUMBER 4>

<ROUTINE I-IMPS ()
	 <COND (<NOT <HERE? APLANE>>
		<RFALSE>)
	       (<NOT <EQUAL? ,ABOVE ,OPLAIN>>
		<RFALSE>)>
	 <MAKE ,IMPS ,SEEN>
	 <SETG P-THEM-OBJECT ,IMPS>
	 <TELL ,TAB>
	 <COND (<DLESS? IMPSAY 1>
		<DEQUEUE ,I-IMPS>
		<SETG IMPSAY 3>
		<QUEUE ,I-IMPS-TAKE>
		<MOVE ,COCO ,APLANE>
		<SETG P-IT-OBJECT ,COCO>
		<WINDOW ,SHOWING-ROOM>
		<TELL "\"Catch!\" cries the ">
		<PRINT "cheerful-looking Implementor">
		<TELL ", lobbing " THE ,COCO " high into the air" ,PTAB
"\"Got it.\" A loud-mouthed Implementor jumps out of his seat, steps backwards to grab the falling " 'COCO "... and plows directly into you" ,PTAB>
		<ITALICIZE "Plop">
		<TELL ". " CTHE ,COCO " skitters across the plane." CR>
		<RTRUE>)
	       (<EQUAL? ,IMPSAY 3>
		<TELL
"One of the Implementors notices your arrival. \"Company,\" he remarks with his mouth full.|
  A few of the others glance down at you." CR>
		<RTRUE>)
	       (<EQUAL? ,IMPSAY 2>
		<TELL ,XA>
		<PRINT "tall, bearded Implementor">
		<TELL " pitches " THE ,COCO
" across the table. \"Isn't this the feeb who ">
		<COND (<IS? ,BOTTLE ,SEEN>
		       <TELL "opened that mailbox">)
		      (<GETB ,LAST-BAD 0>
		       <TELL "used the word '">
		       <PRINT-TABLE ,LAST-BAD>
		       <TELL "'">)
		      (T
		       <TELL "bought that stupid onion">)>
		<TELL 
" a few moves ago?\" he mutters, apparently referring to you">
		<COND (<IS? ,IMPS ,MUNGED>
		       <TELL ". \"Gimme another thunderbolt.\"" CR>
		       <RTRUE>)>
		<TELL ,PTAB "\"That's ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL B ,W?HER>)
		      (T
		       <TELL B ,W?HIM>)>
		<TELL ",\" agrees one of the others." CR>
		<RTRUE>)
	       (<EQUAL? ,IMPSAY 1>
		<TELL "A ">
		<PRINT "cheerful-looking Implementor">
		<TELL " catches " THE ,COCO
" and glares down at you with silent contempt." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE I-IMPS-TAKE ("AUX" X)
	 <COND (<NOT <HERE? APLANE>>
		<RFALSE>)
	       (<NOT <EQUAL? ,ABOVE ,OPLAIN>>
		<RFALSE>)>
	 <MAKE ,IMPS ,SEEN>
	 <SETG P-THEM-OBJECT ,IMPS>
	 <TELL ,TAB>
	 <SETG P-IT-OBJECT ,COCO>
	 <COND (<DLESS? IMPSAY 1>
		<TELL
"The loud-mouthed Implementor growls something obscene, shoves you out of the way and reaches down to retrieve " THE ,COCO ,PTAB>
		<URGRUE-GETS-COCO T>
		<RTRUE>)
	       (<EQUAL? ,IMPSAY 1>
		<TELL "\"Pick up that " 'COCO
		      ",\" growls the Implementor, \"or I'll ">
		<COND (<NOT <L? <GET ,STATS ,INTELLIGENCE> ,READING-IQ>>
		       <ITALICIZE "remove">)
		      (<ZERO? ,VT220>
		       <TELL "(something unintelligible)">)
		      (T
		       <SET X <FONT ,F-NEWFONT>>
		       <TELL B ,W?REMOVE>
		       <SET X <FONT ,F-DEFAULT>>)>
		<TELL " you.\"" CR ,TAB 
"The other Implementors are enjoying this exchange." CR>
		<RTRUE>)
	       (<EQUAL? ,IMPSAY 2>
		<TELL 
"The Implementor who ran into you rises to his feet, livid with rage. \"Pick up that " 'COCO ",\" he demands." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE I-IMPQUEST ()
	 <COND (<NOT <HERE? APLANE>>
		<RFALSE>)
	       (<NOT <EQUAL? ,ABOVE ,OPLAIN>>
		<RFALSE>)
	       (<DLESS? IMPSAY 1>
		<SETG IMPSAY 3>
		<DEQUEUE ,I-IMPQUEST>
		<QUEUE ,I-IMPGIVE>
		<MOVE ,GOBLET ,IMPS>
		<SETG P-IT-OBJECT ,GOBLET>
		<WINDOW ,SHOWING-ROOM>
		<MAKE ,IMPS ,SEEN>
		<TELL "  A ">
		<PRINT "mild-mannered Implementor">
		<TELL 
" empties his goblet of nectar with a gulp. \"Here,\" he says, holding it out for you. \"Carry this. It'll keep the thunderbolts off your back.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,IMPSAY 1>
		<MAKE ,IMPS ,SEEN>
		<TELL
"  \"So,\" sighs another Implementor, toying with his sunglasses. \"The Coconut is gone. Stolen. Any volunteers to get it back?\"|
  One by one, the Implementors turn to look at you.|
  \"I'd say it's unanimous,\" smiles the ">
		<PRINT "cheerful-looking Implementor">
		<TELL ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,IMPSAY 2>
		<MAKE ,IMPS ,SEEN>
		<TELL
"  \"This is awkward,\" remarks a loudmouthed Implementor. \"No telling what the ur-grue might do with the Coconut. He could crumble the foundations of reality. Plunge the world into a thousand years of darkness. We might even have to buy our own lunch!\" The other Implementors gasp. \"And it's all ">
		<HLIGHT ,H-ITALIC>
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "her">)
		      (T
		       <TELL "his">)>
		<HLIGHT ,H-NORMAL>  
		<TELL 
" fault,\" he adds, pointing at you with a drumstick." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>   

<ROUTINE I-IMPGIVE ()
	 <COND (<NOT <HERE? APLANE>>
		<RFALSE>)
	       (<NOT <EQUAL? ,ABOVE ,OPLAIN>>
		<RFALSE>)>
	 <MAKE ,IMPS ,SEEN>
	 <SETG P-IT-OBJECT ,GOBLET>
	 <TELL ,TAB>
	 <COND (<DLESS? IMPSAY 1>
		<MOVE ,GOBLET ,ON-PIKE>
		<MAKE ,GOBLET ,NODESC>
		<MAKE ,GOBLET ,TOUCHED>
		<TELL "\"I don't think ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "s">)>
		<TELL "he's going to accept " THE ,GOBLET ",\" sighs the ">
		<PRINT "mild-mannered Implementor">
		<TELL ,PTAB "\"Of course ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "s">)>
		<TELL "he will,\" smiles the ">
		<PRINT "tall, bearded Implementor">
		<TELL ", forcing it into your hands. \"See?\"" CR>
		<ATRII-KICK>
		<RTRUE>)
	       (<EQUAL? ,IMPSAY 1>
		<TELL
"\"I really must insist that you take this goblet,\" repeats the ">
		<PRINT "mild-mannered Implementor">
		<TELL ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,IMPSAY 2>
		<TELL
"\"Here. Take this,\" urges the ">
		<PRINT "mild-mannered Implementor">
		<TELL ", holding out the ">
		<PRINT "goblet for you to take.|">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE I-BFLY ("AUX" (FREE 0) V L LEN)
	 <COND (<NOT <IS? ,BFLY ,LIVING>>
		<RFALSE>)>
	 <SET L <LOC ,BFLY>>
	 <COND (<T? .L>
		<SET V <VISIBLE? ,BFLY>>
		<COND (<IN? .L ,ROOMS>)
		      (<AND <EQUAL? .L ,ARCH>
			    <NOT <EQUAL? ,ATIME ,PRESENT>>>)
		      (<OR <IS? .L ,SURFACE>
			   <IS? .L ,VEHICLE>
			   <IS? .L ,LIVING>
			   <AND <IS? .L ,CONTAINER>
				<IS? .L ,OPENED>>>
		       <INC FREE>)>)>
	 <COND (<EQUAL? .L ,GOBLET>
		<COND (<ZERO? .V>
		       <RFALSE>)
		      (<IS? ,BFLY ,SEEN>
		       <UNMAKE ,BFLY ,SEEN>
		       <RFALSE>)
		      (<PROB 75>
		       <RFALSE>)>
		<MAKE ,BFLY ,SEEN>
		<MAKE ,BFLY ,IDENTIFIED>
		<TELL ,TAB CTHE ,BFLY <PICK-NEXT ,BFLY-EATINGS> ,PERIOD>
		<RTRUE>)
	       (<T? .V>
		<COND (<IS? ,BFLY ,SEEN>
		       <UNMAKE ,BFLY ,SEEN>
		       <RFALSE>)
		      (<PROB 75>
		       <RFALSE>)>
		<MAKE ,BFLY ,SEEN>
		<MAKE ,BFLY ,IDENTIFIED>
		<TELL ,TAB>
		<COND (<EQUAL? .L ,HERE>)
		      (<T? .FREE>
		       <MOVE ,BFLY ,HERE>
		       <WINDOW ,SHOWING-ALL>
		       <TELL CTHE ,BFLY " flutters">
		       <OUT-OF-LOC .L>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<COND (<VISIBLE? ,GOBLET>
		       <SET L <LOC ,GOBLET>>
		       <TELL CTHE ,BFLY>
		       <COND (<OR <EQUAL? .L ,PLAYER ,HERE <LOC ,PLAYER>>
				  <IS? .L ,SURFACE>>
			      <MOVE ,BFLY ,GOBLET>
			      <WINDOW ,SHOWING-ALL>
			      <TELL " alights on the rim of "
				    THE ,GOBLET ,PERIOD>
			      <RTRUE>)>
		       <TELL <PICK-NEXT ,BFLY-HOVERS> THE .L ,PERIOD>
		       <RTRUE>)>
		<COND (<HERE? <LOC ,ARCH>>)
		      (<PROB 66>
		       <TELL CTHE ,BFLY <PICK-NEXT ,BFLY-DOINGS> ,PERIOD>
		       <RTRUE>)>
		<RETURN <NEXT-BFLY-ROOM? ,HERE>>)>
	 <COND (<ZERO? .L>
		<RFALSE>)
	       (<NOT <IN? .L ,ROOMS>>
		<COND (<T? .FREE>
		       <MOVE ,BFLY <LOC .L>>)>
		<RFALSE>)
	       (<PROB 66>
		<RFALSE>)>
	 <RETURN <NEXT-BFLY-ROOM? .L>>>		   
				
<ROUTINE NEXT-BFLY-ROOM? (L "AUX" DIR CNT TBL TYPE X RM)
	 <COND (<NOT <IN? .L ,ROOMS>>
		<RFALSE>)>
	 <SET CNT 1>
	 <SET DIR ,I-NORTH>
	 <REPEAT ()
	    <SET TBL <GETP .L <GETB ,PDIR-LIST .DIR>>>
	    <COND (<T? .TBL>
		   <SET X <GET .TBL ,XTYPE>>
		   <SET TYPE <MSB .X>>
		   <COND (<OR <EQUAL? .TYPE ,CONNECT ,SCONNECT ,X-EXIT>
			      <AND <EQUAL? .TYPE ,DCONNECT>
				   <IS? <GET .TBL ,XDATA> ,OPENED>>
			      <AND <EQUAL? .TYPE ,FCONNECT>
				   <BAND .X 127>>>
			  <SET RM <GET .TBL ,XROOM>>
			  <COND (<EQUAL? .RM .L ,ON-BRIDGE ,IN-FROON>)
				(<EQUAL? .RM ,APLANE ,IN-SPLENDOR
					 <LOC ,ARCH>>)
				(<AND <NOT <PLAIN-ROOM? .RM>>
				      <NOT <IS? ,BFLY ,IDENTIFIED>>>)
				(<AND <IS? .RM ,INDOORS>
				      <NOT <IS? .L ,INDOORS>>>)
				(<AND <EQUAL? .RM ,HERE>
				      <NOT <WEARING-MAGIC? ,CLOAK>>>
				 <SET CNT 2>
				 <PUT ,GOOD-DIRS 2 .DIR>
				 <RETURN>)
				(T
				 <INC CNT>
				 <PUT ,GOOD-DIRS .CNT .DIR>)>)>)>
	    <COND (<IGRTR? DIR ,I-NW>
		   <RETURN>)>>
	 <COND (<EQUAL? .CNT 1>
		<RFALSE>)
	       (<EQUAL? .CNT 2>
		<SET DIR <GET ,GOOD-DIRS 2>>)
	       (T
		<PUT ,GOOD-DIRS 0 .CNT>
		<PUT ,GOOD-DIRS 1 0>
		<SET DIR <PICK-ONE ,GOOD-DIRS>>)>
	 <SET RM <GET <GETP .L <GETB ,PDIR-LIST .DIR>> ,XROOM>>
	 <COND (<EQUAL? .L ,HERE>
		<MOVE ,BFLY .RM>
		<BFLY-FLIES .DIR>
		<RTRUE>)
	       (<EQUAL? .RM ,HERE>
		<BFLY-ARRIVES .DIR>
		<RTRUE>)>
	 <RFALSE>>
			        	 
<ROUTINE BFLY-FLIES ("OPT" DIR)
	 <WINDOW ,SHOWING-ROOM>
	 <TELL CTHE ,BFLY " flutters away">
	 <COND (<ASSIGNED? DIR>
		<TELL " to the " B <GET ,DIR-NAMES .DIR>>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE BFLY-ARRIVES ("OPT" DIR)
	 <WINDOW ,SHOWING-ROOM>
         <SETG P-IT-OBJECT ,BFLY>
	 <MOVE ,BFLY ,HERE>
	 <MAKE ,BFLY ,SEEN>
	 <MAKE ,BFLY ,IDENTIFIED>
	 <TELL ,TAB>
	 <COND (<IS? ,BFLY ,TOUCHED>
		<TELL ,XTHE>)
	       (T
		<MAKE ,BFLY ,TOUCHED>
		<TELL ,XA>)>
	 <TELL D ,BFLY " flutters into view">
	 <COND (<ASSIGNED? DIR>
		<SET DIR <+ .DIR 4>>
		<COND (<G? .DIR ,I-NW>
		       <SET DIR <- .DIR 8>>)>
		<TELL " from the " B <GET ,DIR-NAMES .DIR>>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>
	    
<ROUTINE I-PILLAR ("AUX" L)
	 <SET L <LOC ,BFLY>>
	 <COND (<ZERO? .L>
		<RFALSE>)
	       (<NOT <IS? ,BFLY ,LIVING>>
		<RFALSE>)
	       (<VISIBLE? ,BFLY>
		<COND (<IS? ,BFLY ,SEEN>
		       <UNMAKE ,BFLY ,SEEN>
		       <RFALSE>)
		      (<IN? .L ,ROOMS>
		       <VANISH ,BFLY>
		       <DEQUEUE ,I-PILLAR>
		       <TELL ,TAB CTHE ,BFLY 
" seems to have crawled out of sight." CR>
		       <RTRUE>)
		      (<PROB 90>
		       <RFALSE>)>
		<MAKE ,BFLY ,SEEN>
		<TELL ,TAB CTHE ,BFLY>
		<COND (<PROB 50>
		       <TELL <PICK-NEXT ,PILLAR-DOINGS>>)
		      (T
		       <TELL <PICK-NEXT ,PILLAR-MOVES>>
		       <COND (<EQUAL? .L ,PLAYER>
			      <SET L ,HANDS>)
			     (<NOT <EQUAL? .L ,HERE>>)
			     (<IS? ,HERE ,INDOORS>
			      <SET L ,FLOOR>)
			     (T
			      <SET L ,GROUND>)>
		       <TELL THE .L>)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<NOT <IN? .L ,ROOMS>>
		<RFALSE>)
	       (<PROB 33>
		<REMOVE ,BFLY>
		<DEQUEUE ,I-PILLAR>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<CONSTANT INIT-CLERIC-SCRIPT 4>
<GLOBAL CLERIC-SCRIPT:NUMBER ,INIT-CLERIC-SCRIPT>

<ROUTINE I-CLERIC ("AUX" X)
	 <COND (<NOT <HERE? IN-CHAPEL>>
		<RFALSE>)
	       (<IS? ,CLERIC ,SEEN>
		<UNMAKE ,CLERIC ,SEEN>
		<RFALSE>)>
	 <TELL ,TAB>
	 <COND (<IGRTR? CLERIC-SCRIPT ,INIT-CLERIC-SCRIPT>
		<SETG CLERIC-SCRIPT 0>
		<TELL CTHE ,CLERIC " lifts his eyes as you walk in">
		<COND (<NOT <IS? ,CONGREG ,SEEN>>
		       <MAKE ,CONGREG ,SEEN>
		       <TELL 
". \"Art thou the Savior?\" he cries, and the entire " 
'CONGREG " turns to stare at you" ,PTAB
"\"Naw,\" sneers an unseen voice. \"Just some ">
		       <SET X ,W?GUY>
		       <COND (<IS? ,PLAYER ,FEMALE>
			      <SET X ,W?DAME>)>
		       <TELL B .X>
		       <COND (<SEE-ANYTHING-IN? ,PLAYER>
			      <TELL ,WITH A <FIRST? ,PLAYER>>)>
		       <TELL ,PERQ ,TAB "\"Oh,\" mumbles " THE ,CLERIC 
" with a sigh of resignation. \"Have a seat, good ">
		       <SET X ,W?SIR>
		       <COND (<IS? ,PLAYER ,FEMALE>
			      <SET X ,W?MISS>)>
		       <TELL B .X ", and join us in our hour of need.\"" CR>
		       <RTRUE>)>
		<TELL ", and bows his head in sorrow." CR>
		<RTRUE>)
	       (<EQUAL? ,CLERIC-SCRIPT 1>
		<TELL C ,QUOTATION <PICK-NEXT ,CLERIC-WOES> C ,EXCLAM>
		<CLERIC-WHINES>
		<TELL
"Behold! The wrath of the Trees is almost upon us. When the Glyph of Warding is melted, the village will be lost!\"" CR>
		<CROWD-AGREES>
		<RTRUE>)
	       (<EQUAL? ,CLERIC-SCRIPT 2>
		<TELL "\"Who can stop the marching Trees?">
		<CLERIC-WHINES>
		<TELL 
"Orkan's Glyphs are all that keep the monsters at bay. But Orkan answers not our summons; only one Glyph remains, and that is writ in snow!\"" CR>
		<CROWD-AGREES>
		<RTRUE>)
	       (<EQUAL? ,CLERIC-SCRIPT 3>
		<TELL "\"The southern mountains are their nest,">
		<CLERIC-WHINES>
		<TELL
"They march relentlessly, choking the valley with their foul gifts and blasphemous songs. They know the wizard's Glyph is melting, and with it fades our only hope!\"" CR>
		<RTRUE>)
	       (<EQUAL? ,CLERIC-SCRIPT ,INIT-CLERIC-SCRIPT>
		<SETG CLERIC-SCRIPT 0>
		<TELL "\"Where is the Savior of whom our legends speak?">
		<CLERIC-WHINES>
		<TELL "Anything ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "s">)>
		<TELL "he asks will be ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "her">)
		      (T
		       <TELL "his">)>
		<TELL " reward, if only ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "s">)>
		<TELL 
"he fulfills the ancient prophecy, and drives the plague of Tree-daemons from our doorstep!\"" CR>
		<CROWD-AGREES>
		<RTRUE>)
	       (T
		<RFALSE>)>>     
	       
<ROUTINE CLERIC-WHINES ("AUX" X)
	 <WHIMPERS ,CLERIC>
	 <COND (<PROB 50>
		<TELL ", ">
		<SET X <RANDOM 100>>
		<COND (<L? .X 33>
		       <TELL "beating his breast">)
		      (<L? .X 67>
		       <TELL "wringing his hands">)
		      (T
		       <TELL "covering his face">)>
		<COND (<PROB 50>
		       <COND (<PROB 50>
			      <TELL " in supplication">)
			     (T
			      <TELL " hopelessly">)>)>)>
	 <TELL ". \"">
	 <RFALSE>>
			  
<ROUTINE CROWD-AGREES ()
	 <COND (<PROB 33>
		<TELL ,TAB C ,QUOTATION <PICK-NEXT ,CLERIC-WOES> C ,EXCLAM>
		<WHIMPERS ,CONGREG>
		<PRINT ,PERIOD>)>
	 <RFALSE>>

<ROUTINE WHIMPERS (OBJ "AUX" X)
	 <TELL "\" ">
	 <SET X <RANDOM 100>>
	 <COND (<L? .X 33>
		<TELL "mourn">)
	       (<L? .X 67>
		<TELL "whine">)
	       (T
		<TELL "whimper">)>
	 <TELL "s " THE .OBJ>
	 <RFALSE>>

<ROUTINE I-THRIFF-WIN ()
	 <COND (<NOT <VISIBLE? ,CLERIC>>
		<RFALSE>)
	       (<IS? ,CLERIC ,SEEN>
		<UNMAKE ,CLERIC ,SEEN>
		<RFALSE>)>
	 <INC CLERIC-SCRIPT>
	 <TELL ,TAB>
	 <COND (<EQUAL? ,CLERIC-SCRIPT 1>
		<TELL "\"Congratulations, honored ">
		<SAY-SORC>
		<TELL ",\" booms " THE ,CLERIC
" over the crowd's cheers. \"Truly, thou art the Savior foretold in our eldest legends. Would that Orkan were here to witness this day.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,CLERIC-SCRIPT 2>
		<TELL "\"What reward wouldst thou claim of us?\" asks "
		      THE ,CLERIC ", carefully holding ">
		<PRINT "the reliquary behind his back. \"">
		<TELL "Ask for anything, and it shall be yours!\"" CR>
		<RTRUE>)
	       (<EQUAL? ,CLERIC-SCRIPT 3>
		<TELL
"\"Anything we possess is yours for the asking,\" repeats " 
THE ,CLERIC ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,CLERIC-SCRIPT 4>
		<TELL CTHE ,CLERIC " adjusts ">
		<PRINT "the reliquary behind his back. \"">
		<TELL "Perchance we have nothing to tempt such a mighty ">
		<SAY-SORC>
		<TELL ",\" he remarks hopefully." CR>
		<RTRUE>)>
	 <EXIT-CLERIC>
	 <TELL CTHE ,CONGREG " is beginning to wander away" ,PTAB
"\"Your reticence betrays your humility, honored one,\" says the Cardinal, bowing his head. \"No doubt you have forsworn earthly gifts in lieu of some greater reward in the afterlife. In that case, farewell!\"|
  Clutching " THE ,RELIQUARY ", " THE ,CLERIC>
	 <PRINT " disappears into the ">
	 <TELL "crowd. In moments, the place is deserted." CR>
	 <RTRUE>>	       

<ROUTINE EXIT-CLERIC ()
	 <DEQUEUE ,I-THRIFF-WIN>
	 <REMOVE ,CLERIC>
	 <SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
	 <REMOVE ,CONGREG>
	 <SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>
	 <WINDOW ,SHOWING-ALL>
	 <RFALSE>>
		      
<CONSTANT INIT-TRUFFLE 50>
<GLOBAL TRUFFLE-TIMER 0>

<ROUTINE I-TRUFFLE ("AUX" V)
	 <COND (<NOT <LOC ,TRUFFLE>>
		<SETG TRUFFLE-TIMER 0>
		<DEQUEUE ,I-TRUFFLE>
		<RFALSE>)
	       (<HERE? APLANE IN-SPLENDOR>
		<RFALSE>)>
	 <SET V <VISIBLE? ,TRUFFLE>>
	 <COND (<HERE? APLANE IN-SPLENDOR>
		<RFALSE>)
	       (<DLESS? TRUFFLE-TIMER 1>
		<SETG TRUFFLE-TIMER 0>
		<DEQUEUE ,I-TRUFFLE>
		<VANISH ,TRUFFLE>
		<COND (<T? .V>
		       <TELL ,TAB "All that's left of " THE ,TRUFFLE
			     " is a yummy memory." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<ZERO? .V>
		<RFALSE>)
	       (<EQUAL? ,TRUFFLE-TIMER 10>
		<TELL ,TAB CTHE ,TRUFFLE
		      " looks terribly soft">
		<PRINT
". It probably won't last much longer.|">
		<RTRUE>)
	       (<EQUAL? ,TRUFFLE-TIMER 30>
		<TELL ,TAB CTHE ,TRUFFLE
" looks as if it's beginning to soften." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL PTIMER:NUMBER 0>

<ROUTINE I-QUEEN ("AUX" X)
	 <COND (<NOT <HERE? IN-GARDEN>>
		<RFALSE>)>
	 <INC PTIMER>
	 <COND (<EQUAL? ,PTIMER 1>
		<RFALSE>)
	       (<EQUAL? ,PTIMER 2>
		<TELL ,TAB 
"Voices can be heard somewhere in the distance." CR>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 3>
		<TELL ,TAB
"One of the unseen voices laughs harshly." CR>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 4>
		<UNMAKE ,QUEEN ,NODESC>
		<TELL ,TAB ,YOU-HEAR
"a chorus of unpleasant giggles. \"I'll be in my garden,\" calls one of the voices." CR>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 5>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB 
"A whirlpool of twinkling light forms in " THE ,GARDEN
". Something is beginning to materialize!" CR>
		<COND (<AND <IN? ,DACT ,HERE>
			    <IS? ,DACT ,LIVING>
			    <NOT <IS? ,DACT ,SLEEPING>>>
		       <MAKE ,DACT ,SEEN>
		       <TELL ,TAB CTHE ,DACT 
" beats its wings restlessly." CR>)>
		<COND (<AND <VISIBLE? ,MINX>
			    <IS? ,MINX ,LIVING>
			    <NOT <IS? ,MINX ,SLEEPING>>>
		       <MAKE ,MINX ,SEEN>
		       <TELL ,TAB CTHE ,MINX 
" whimpers fearfully as " THE ,GARDEN " brightens">
		       <COND (<NOT <IN? ,MINX ,BUSH>>
			      <SET X <LOC ,MINX>>
			      <MOVE ,MINX ,BUSH>
			      <WINDOW ,SHOWING-ALL>
			      <TELL ". Before you can stop her, she ">
			      <COND (<NOT <EQUAL? .X ,IN-GARDEN>>
				     <TELL "leaps away from ">
				     <COND (<EQUAL? .X ,PLAYER>
					    <TELL "your grasp">)
					   (T
					    <TELL THE .X>)>
				     <TELL ", ">)>
			      <TELL 
"streaks across the lawn and disappears behind " THE ,BUSH>)>
		       <TELL ,PERIOD>)>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 6>
		<WINDOW ,SHOWING-ROOM>
		<MOVE ,QUEEN ,HERE>
		<SEE-CHARACTER ,QUEEN>
		<TELL ,TAB 
"The twinkling whirl resolves into a furry creature. Her face is turned away at the moment, but there's a flat tail sticking out from under her long, red gown." CR>
		<TOPPLED? ,QUEEN>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 7>
		<WINDOW ,SHOWING-ROOM>
		<PUTP ,QUEEN ,P?SDESC 0>
		<TELL ,TAB 
"The furry creature turns around, revealing her dark, beady eyes and fleshy bill. She's a platypus!" CR>
		<COND (<OR <IN? ,DACT ,HERE>
			   <NOT <IN? ,PLAYER ,BUSH>>>
		       <QUEEN-SEES-YOU>)>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 8>
	        <MOVE ,JAR ,QUEEN>
		<MAKE ,BROG ,CONTAINER>
		<MAKE ,BROG ,OPENABLE>
		<MAKE ,BROG ,OPENED>
		<REPLACE-SYN? ,BROG ,W?ZZZP ,W?COMPARTMENT>
		<REPLACE-ADJ? ,BROG ,W?ZZZP ,W?SECRET>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB CTHE ,QUEEN " steps over to " THE ,BROG 
", glancing around to be sure she is alone. Then she opens a secret compartment and pulls out " A ,JAR ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 9>
		<CREATE-MIRROR? ,MIRROR0>
		<TELL ,TAB CTHE ,QUEEN
" opens the jar, takes out a circlet and blows a silver bubble. You watch as the bubble flattens into a round mirror, rotating slowly on its edge." CR>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 10>
		<TELL ,TAB CTHE ,QUEEN
" stops the spinning mirror and turns it until it faces her. Gazing into it she whispers,|
|
 \"Mirror, mirror in the air,|
  Who in Quendor is most fair?\"" CR>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 11>
		<TELL 
"  The floating mirror shimmers, and a hollow voice says,|
|
 \"Your Highness once was fair, 'tis true.|
  But Morning-Star is ">
		<ITALICIZE "woo woo woo">
		<TELL "!\"" CR>
		<RTRUE>)
	       (<EQUAL? ,PTIMER 12>
		<UNMAKE ,BROG ,OPENED>
		<MOVE ,JAR ,BROG>
		<DESTROY-MIRROR ,MIRROR0>
		<DEQUEUE ,I-MIRRORS>
		<REMOVE ,QUEEN>
		<DEQUEUE ,I-QUEEN>
		<SETG PTIMER 0>
		<SETG P-HER-OBJECT ,NOT-HERE-OBJECT>
		<TELL "  \"Liar!\" cries " THE ,QUEEN
", bursting the mirror with an angry swipe. She stows " THE ,JAR 
" back in " THE ,BROG
", blows a silver whistle and dissolves in a whirlpool of color." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE I-DUST ("OPT" INDENT "AUX" V)
	 <SET V <VISIBLE? ,DUST>>
	 <COND (<ASSIGNED? INDENT>)
	       (<IS? ,DUST ,SEEN>
		<UNMAKE ,DUST ,SEEN>
		<RFALSE>)
	       (T
		<TELL ,TAB>)>
	 <MAKE ,DUST ,SEEN>
	 <COND (<EQUAL? ,BUNNIES 1>
		<SETG P-THEM-OBJECT ,DUST>
		<PUTP ,DUST ,P?SDESC 0>
		<MAKE ,DUST ,PLURAL>
		<COND (<T? .V>
		       <TELL "With an ominous ">
		       <HLIGHT ,H-ITALIC>
		       <TELL "poof">
		       <HLIGHT ,H-NORMAL>
		       <TELL ", the dust bunny divides itself in two." CR>)>)
	       (<T? .V>
		<HLIGHT ,H-ITALIC>
		<TELL "Poof">
		<HLIGHT ,H-NORMAL>
		<TELL ". " CTHE ,DUST <PICK-NEXT ,BUNNY-SPLITS> ,PERIOD>)>
	 <MORE-BUNNIES>
	 <RETURN .V>>

<ROUTINE MORE-BUNNIES ("AUX" X)
	 <COND (<G? ,BUNNIES ,BMAX>
		<RTRUE>)
	       (<EQUAL? ,BUNNIES ,BMAX>
		<INC BUNNIES>)
	       (T
		<SET X ,BUNNIES>
		<SETG BUNNIES <+ ,OBUNNIES ,BUNNIES>>
		<SETG OBUNNIES .X>)>
	 <WINDOW ,SHOWING-ROOM>
	 <RFALSE>>

<ROUTINE I-MARE-SEES ()
	 <DEQUEUE ,I-MARE-SEES>
	 <COND (<NOT <HERE? IN-SPLENDOR>>
		<RFALSE>)>
	 <TELL ,TAB>
	 <UNICORNS-FLEE "as you stand gawking at the landscape">
	 <RTRUE>>

<ROUTINE I-ARREST ("OPT" INDENT "AUX" RM OBJ NXT)
	 <DEQUEUE ,I-ARREST>
	 <COND (<NOT <HERE? IN-SPLENDOR>>
		<RFALSE>)>
	 <COND (<NOT <ASSIGNED? INDENT>>
		<TELL ,TAB ,XTHE>)
	       (T
		<TELL "As you step across the glade, the ">)>
	 <TELL
"stillness is broken by the rumble of approaching hooves. Before you can think or move, you find yourself enclosed by a dozen sharp horns, each backed by a unicorn in full military regalia.|
  A magnificent stallion regards you with calm authority. \"You">
	 <COND (<IS? ,HERD ,SEEN>
		<TELL "r fate is sealed">)
	       (T
		<TELL " will find no welcome here">)>
	 <TELL ", earth-dweller,\" whispers a stern voice in your mind. \"">
	 <COND (<IS? ,HERD ,SEEN>
		<TELL 
"The injustice that drove us to this Plane is now yours. Forever.\""
CR ,TAB 
"A painful metal bit is forced into your mouth, and a wagonload of overweight, aristocratic unicorns is attached. The rest of your life is spent hauling this laughing burden in a small circle, with infrequent stops for dirty water and oats">
		<JIGS-UP>
		<RTRUE>)>
	 
	 <MAKE ,HERD ,SEEN>
	 <TELL 
"Our children must never know the pain we suffered at the hands of Men. Return to your people now, and describe the fate awaiting any who dares to violate our solitude again.\"" CR ,TAB
"A lifetime of humiliating drudgery passes before your eyes. You cry out with pain and heartache as you haul wagons full of overweight aristocrats, standing silent and powerless as cruel taskmasters whip you over and over again...">
	 <CARRIAGE-RETURNS>
	 <SAFE-VEHICLE-EXIT>
	 <SET RM <META-LOC ,CHEST>>
	 <COND (<SET OBJ <FIRST? ,IN-SPLENDOR>>
		<REPEAT ()
	     	   <SET NXT <NEXT? .OBJ>>
		   <COND (<EQUAL? .OBJ ,WINNER>)
			 (<IS? .OBJ ,TAKEABLE>
			  <MOVE .OBJ .RM>)>
		   <SET OBJ .NXT>
		   <COND (<ZERO? .OBJ>
			  <RETURN>)>>)>
	 <SETG P-WALK-DIR <>>
	 <GOTO .RM>
	 <RTRUE>>

<GLOBAL CHOKE:NUMBER 0>

<ROUTINE I-STRANGLE ("AUX" X)
	 <SET X <GET ,STATS ,ENDURANCE>>
	 <TELL ,TAB>
	 <COND (<L? ,CHOKE .X>
		<TELL <PICK-NEXT ,STRANGLES>>
		<COND (<L? </ .X ,CHOKE> 2>
		       <TELL ". Your endurance won't last much longer">)>
		<TELL "!" CR>
		<UPDATE-STAT <- 0 ,CHOKE>>
		<RTRUE>)>
	 <UPDATE-STAT <- 0 .X>>
	 <TELL 
"The choking fingers drain your endurance to its limit. As your consciousness sinks into oblivion, you feel " THE ,SKELETON " draping " B ,W?SOMETHING
" around your neck">
	 <JIGS-UP>
	 <RTRUE>>

<ROUTINE NOLUCK? ("AUX" CNT LEN OBJ)
	 <SET LEN <GET ,LUCKY-OBJECTS 0>>
	 <REPEAT ()
	    <SET OBJ <GET ,LUCKY-OBJECTS .LEN>>
	    <COND (<AND <IN? .OBJ ,PLAYER>
			<NOT <IS? .OBJ ,NEUTRALIZED>>>
		   <SET CNT <GETP .OBJ ,P?DNUM>>
		   <COND (<DLESS? CNT 1>
			  <VANISH .OBJ>
			  <TELL ,TAB>
			  <ITALICIZE "Poof">
			  <TELL "! " CTHE .OBJ
				" is consumed in a silent flash of green." CR>
			  <RFALSE>)>
		   <PUTP .OBJ ,P?DNUM .CNT>
		   <TELL ,TAB ,CYOUR D .OBJ " flickers green">
		   <COND (<EQUAL? .CNT 1>
			  <TELL " again, less brightly than before">)>
		   <PRINT ,PERIOD>
		   <RFALSE>)>
	    <COND (<DLESS? LEN 1>
		   <RTRUE>)>>>

<GLOBAL GRUE-KILLS:NUMBER 0>

<ROUTINE I-GRUE ("AUX" SEE L DIR TBL DEST DAMAGE X)
	 <COND (<T? ,LIT?>
		<RFALSE>)
	       (<HERE? IN-LAIR>
		<RFALSE>)
	       (<NOT <GRUE-ROOM?>>
		<RFALSE>)>
	 <SET SEE <WEARING-MAGIC? ,HELM>>
	 <COND (<IN? ,GRUE ,HERE>
		<COND (<L? <GETP ,GRUE ,P?ENDURANCE> 1>
		       <COND (<IGRTR? GRUE-KILLS 2>
			      <DEQUEUE ,I-GRUE>)>
		       <TELL ,TAB>
		       <COND (<T? .SEE>
			      <TELL CTHE ,GRUE " retreats">)
			     (T
			      <TELL ,YOU-HEAR B ,W?SOMETHING " retreat">)>
		       <TELL " into the darkness." CR>
		       <UPDATE-STAT <GETP ,GRUE ,P?VALUE> ,EXPERIENCE T>
		       <EXUENT-MONSTER ,GRUE>
		       <PUTP ,GRUE ,P?ENDURANCE <GETP ,GRUE ,P?EMAX>>
		       <RTRUE>)>
		<NEXT-ENDURANCE? ,GRUE>
		<TELL ,TAB>
		<COND (<T? .SEE>
		       <TELL CTHE ,GRUE>)
		      (T
		       <TELL "Something">)>
		<TELL " strikes out at you">
		<SET DAMAGE <MONSTER-STRIKES? ,GRUE>>
		<COND (<ZERO? .DAMAGE>
		       <TELL ", but misses." CR>
		       <RTRUE>)
		      (<ZERO? ,STATIC>
		       <TELL ". Ouch!" CR>)
		      (T
		       <TELL ,PERIOD>)>
		<UPDATE-STAT <MSPARK? ,GRUE .DAMAGE>>
		<RTRUE>)
	       (<IS? ,GRUE ,SURPRISED>
		<UNMAKE ,GRUE ,SURPRISED>
		<RFALSE>)>
	 <MOVE ,GRUE ,HERE>
	 <SEE-MONSTER ,GRUE>
	 <COND (<T? .SEE>
		<WINDOW ,SHOWING-ROOM>)>
	 <TELL ,TAB>
	 <COND (<T? .SEE>
		<TELL "A presence">)
	       (T
		<TELL "Something">)>
	 <TELL " lurks into the passage." CR>
	 <RTRUE>>

<ROUTINE I-WIGHT ("AUX" DAMAGE)
	 <COND (<HERE? ON-TRAIL>
		<COND (<L? <GETP ,WIGHT ,P?ENDURANCE> 1>
		       <TELL ,TAB>
		       <COND (<NOT <IS? ,WIGHT ,SLEEPING>>
			      <TELL "Battered and confused, " THE ,WIGHT 
" backs over the edge of the cliff, shrieks and tumbles out of sight." CR>)>
		       <KILL-MONSTER ,WIGHT>
		       <MOVE ,DIAMOND ,ON-TRAIL>
		       <SETG P-IT-OBJECT ,DIAMOND>
		       <TELL ,TAB "Something lands at your feet with a ">
		       <ITALICIZE "plop">
		       <TELL ,PERIOD>
		       <RTRUE>)
		      (<IS? ,WIGHT ,SURPRISED>
		       <SEE-MONSTER ,WIGHT>
		       <COND (<NOT <IS? ,WIGHT ,SLEEPING>>
			      <TELL ,TAB CTHE ,WIGHT
				    " whirls to face you." CR>
			      <TOPPLED? ,WIGHT>
			      <RTRUE>)>)>
		<COND (<STILL-SLEEPING? ,WIGHT>
		       <RTRUE>)>
		<NEXT-ENDURANCE? ,WIGHT>
		<SET DAMAGE <MONSTER-STRIKES? ,WIGHT>>
		<TELL ,TAB CTHE ,WIGHT>
		<COND (<T? .DAMAGE>
		       <TELL " claws at you viciously.">
		       <COND (<ZERO? ,STATIC>
			      <TELL " Ouch!">)>
		       <CRLF>
		       <UPDATE-STAT <MSPARK? ,WIGHT .DAMAGE>>
		       <RTRUE>)>
		<TELL " strikes out at you, but misses." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL LAVA-TIMER:NUMBER 0>

<ROUTINE I-LAVA ()
	 <COND (<DLESS? LAVA-TIMER 1>
		<COND (<HERE? FOREST-EDGE ON-TRAIL ON-PEAK IN-CABIN>
		       <CASCADE>
		       <RTRUE>)>
		<REMOVE ,PLUME>
		<SETG LAVA-TIMER 0>
		<DEQUEUE ,I-LAVA>
		<MOVE ,MAGMA-GLOW ,IN-THRIFF>
		<SETG MAGMA-TIMER 4>
		<QUEUE ,I-MAGMA>
		<EMPTY-ROOM ,FOREST-EDGE>
	        <PUTP ,FOREST-EDGE ,P?SDESC 0>
	        <COND (<NOT <HERE? IN-THRIFF>>
		       <RFALSE>)>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB 
"A violent tremor wracks the earth and sends you sprawling. You bravely cover your eyes to await the tide of magma that will sweep you and Thriff into oblivion...|||||||The silence gets the better of your curiosity." CR>
		<RTRUE>)
	       
	       (<EQUAL? ,LAVA-TIMER 1>  
		<COND (<HERE? ON-TRAIL ON-PEAK IN-CABIN>
		       <CASCADE>
		       <RTRUE>)>
		<REMOVE ,MAILBOX>
		<PUTP ,ON-TRAIL ,P?SOUTH 0>
		<PUTP ,ON-TRAIL ,P?IN 0>
		<REPLACE-GLOBAL? ,ON-TRAIL ,CABIN ,NULL>
		<COND (<IN? ,WIGHT ,ON-TRAIL>
		       <REMOVE ,WIGHT>
		       <DEQUEUE ,I-WIGHT>)>
		<EMPTY-ROOM ,ON-TRAIL>
		<COND (<NOT <HERE? FOREST-EDGE IN-THRIFF>>
		       <RFALSE>)>
		<TELL ,TAB CTHE ,GROUND " trembles with seismic distress">
		<COND (<HERE? IN-THRIFF>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<TELL 
" as a deadly torrent of lava sweeps down the western slope, only seconds away!" CR>
		<RTRUE>)
	       
	       (<EQUAL? ,LAVA-TIMER 2>  
		<COND (<HERE? ON-PEAK>
		       <CASCADE>
		       <RTRUE>)>
		<EMPTY-ROOM ,ON-PEAK>
		<COND (<NOT <HERE? ON-TRAIL FOREST-EDGE IN-THRIFF IN-CABIN>>
		       <RFALSE>)>
		<TELL ,TAB "Powerful shock waves rock the mountainside">
		<COND (<HERE? IN-CABIN>
		       <TELL ", and the entire cabin shudders." CR>
		       <RTRUE>)
		      (<HERE? IN-THRIFF FOREST-EDGE>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<TELL 
" as a red-hot wall of liquid rock roars down the trail, only seconds behind you!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CASCADE ("OPT" STR)
	 <COND (<ASSIGNED? STR>
		<TELL "As you " .STR " the lava, a cascade of it ">)
	       (T
		<TELL ,TAB "A cascade of lava ">)>
	 <COND (<HERE? IN-CABIN>
		<TELL "buries " THE ,CABIN>)
	       (T
		<COND (<NOT <HERE? ON-PEAK>>
		       <TELL "roars down the mountainside and ">)>
		<TELL "knocks you off your feet, burying you">)>
	 <TELL " instantly under tons of molten rock">
	 <COND (<WEARING-MAGIC? ,RING>
		<TELL
"! Your magic ring miraculously shields you from the volcanic heat, but not from the inconvenience of having nothing to breathe">)>
	 <JIGS-UP>
	 <RTRUE>>	
			     
<ROUTINE EMPTY-ROOM (RM "AUX" OBJ NXT)
	 <COND (<SET OBJ <FIRST? .RM>>
		<REPEAT ()
		   <SET NXT <NEXT? .OBJ>>
		   <COND (<IS? .OBJ ,TAKEABLE>
			  <REMOVE .OBJ>)>
		   <SET OBJ .NXT>
		   <COND (<ZERO? .OBJ>
			  <RETURN>)>>)>
	 <REPLACE-GLOBAL? .RM ,SNOW ,LAVA>
	 <REPLACE-GLOBAL? .RM ,GLYPH ,NULL>
	 <RFALSE>>

<GLOBAL MAGMA-TIMER:NUMBER 0>

<VOC "CRUST" NOUN>

<ROUTINE I-MAGMA ("AUX" TBL X)
	 <SET TBL <GETPT ,MAGMA-GLOW ,P?ADJECTIVE>>
	 <COND (<DLESS? MAGMA-TIMER 1>
		<SETG MAGMA-TIMER 0>
		<DEQUEUE ,I-MAGMA>
		<REMOVE ,MAGMA-GLOW>
		<REPLACE-SYN? ,LAVA ,W?ZZZP ,W?CRUST>
		<COND (<HERE? IN-THRIFF FOREST-EDGE ON-TRAIL ON-PEAK>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL ,TAB "The red glow ">
		       <COND (<HERE? IN-THRIFF>
			      <TELL 
"from the south slowly fades from view">)
			     (T
			      <TELL 
"of the lava fades, leaving a hard crust underfoot">)>
		       <PRINT ,PERIOD>)>
		<COND (<GLOBAL-IN? ,FOREST-EDGE ,GLYPH>
		       <SETG THRIFF-WON T>
		       <DEQUEUE ,I-CLERIC>
		       <MAKE ,CLERIC ,LIVING>
		       <SETG CLERIC-SCRIPT 0>
		       <UNMAKE ,CLERIC ,SEEN>
		       <QUEUE ,I-THRIFF-WIN>
		       <QUEUE ,I-UNHAPPY-XTREES>
		       <MAKE ,XTREES ,SEEN>
		       <MOVE ,RELIQUARY ,CLERIC>
		       <COND (<HERE? IN-CHAPEL>
			      <WINDOW ,SHOWING-ROOM>
			      <TELL ,TAB
"A messenger nymph appears above " THE ,ALTAR
". \"Hooray!\" she cries. \"">
			      <PRINT-TABLE ,CHARNAME>
			      <TELL " outfoxed " THE ,XTREES "!\"" CR>
			      <RTRUE>)>
		       <UNMAKE ,CLERIC ,NODESC>
		       <SET X ,FOREST-EDGE>   
		       <COND (<HERE? IN-THRIFF>
			      <SET X ,HERE>)>
		       <MOVE ,CLERIC .X>
		       <MOVE ,CONGREG .X>
		       <COND (<EQUAL? ,HERE .X>
			      <WINDOW ,SHOWING-ROOM>
			      <TELL ,TAB "A cheering crowd">
			      <COND (<HERE? IN-THRIFF>
				     <TELL " streams out of " 
					   THE ,CHAPEL>)
				    (T
				     <PRINT " appears from the ">
				     <TELL "village">)>
			      <TELL ", led by " THE ,CLERIC ,PERIOD>
			      <RTRUE>)>)>
		
		<COND (<HERE? FOREST-EDGE>
		       <SAY-XTREES>
		       <TELL 
" test the edges of the clearing with their roots">
		       <COND (<AND <IS? ,BFLY ,MUNGED>
				   <IS? ,BFLY ,LIVING>
				   <OR <IN? ,BFLY ,PLAYER>
				       <IN? ,BFLY ,HERE>>>
			      <TELL 
", but still appear reluctant to approach you." CR>
			      <RTRUE>)>
		       <TELL 
". Finding no Glyphs of Warding or other inconveniences, they elect to ">
		       <XTREES-EAT-YOU T>)>

		<RTRUE>)
	       (<EQUAL? ,MAGMA-TIMER 1>
		<PUT .TBL 0 ,W?RED>
		<COND (<HERE? IN-THRIFF>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL ,TAB "The southern ">
		       <PRINT "glow fades from orange to dull red.|">
		       <RTRUE>)
		      (<NOT <HERE? FOREST-EDGE ON-TRAIL ON-PEAK>>
		       <RFALSE>)>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB "The lava's ">
		<PRINT "glow fades from orange to dull red.|">
		<COND (<HERE? FOREST-EDGE>
		       <SAY-XTREES>
		       <TELL
" shuffle a bit closer to the clearing's edge." CR>)>
		<RTRUE>)
	       (<EQUAL? ,MAGMA-TIMER 2>
		<PUT .TBL 0 ,W?ORANGE>
		<COND (<HERE? IN-THRIFF>
		       <WINDOW ,SHOWING-ROOM>
		       <TELL ,TAB
"You watch as the southern glow fades from yellow to orange." CR>
		       <RTRUE>)
		      (<NOT <HERE? FOREST-EDGE ON-TRAIL ON-PEAK>>
		       <RFALSE>)>
		<WINDOW ,SHOWING-ROOM>
		<TELL ,TAB
"The lava's glow fades from yellow to orange as it cools." CR>
		<COND (<HERE? FOREST-EDGE>
		       <SAY-XTREES>
		       <TELL
" are keeping well away from the clearing's edge." CR>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SAY-XTREES ()
	 <MAKE ,XTREES ,SEEN>
	 <TELL ,TAB CTHE ,XTREES>
	 <RTRUE>>

<ROUTINE I-XTREES ("AUX" X C)
	 <COND (<GLOBAL-IN? ,FOREST-EDGE ,GLYPH>
		<COND (<NOT <HERE? FOREST-EDGE>>
		       <RFALSE>)
		      (<IS? ,XTREES ,SEEN>
		       <UNMAKE ,XTREES ,SEEN>
		       <RFALSE>)
		      (<PROB 50>
		       <RFALSE>)>
		<SAY-XTREES>
		<COND (<PROB 50>
		       <SET X <PICK-NEXT ,CAROLS>>
		       <TELL <PICK-NEXT ,HOW-SINGS> .X ,PERQ>
		       <RTRUE>)>
		<TELL <PICK-NEXT ,XTREE-DOINGS> ,PERIOD>
		<RTRUE>)
	       (<T? ,MAGMA-TIMER>
		<RFALSE>)
	       (<AND <HERE? FOREST-EDGE IN-THRIFF>
		     <IS? ,BFLY ,MUNGED>
		     <IS? ,BFLY ,LIVING>
		     <OR <IN? ,BFLY ,PLAYER>
			 <IN? ,BFLY ,HERE>>>
		<SAY-XTREES>
		<TELL " shuffle nervously at the edge of the ">
		<COND (<GLOBAL-IN? ,SNOW ,HERE>
		       <TELL B ,W?CLEARING>)
		      (T
		       <TELL B ,W?LAVA>)>
		<TELL ". They">
		<PRINT " seem unwilling to approach you.|">
		<RTRUE>)
	       (<NOT <IS? ,FOREST-EDGE ,MUNGED>>
		<COND (<HERE? FOREST-EDGE>
		       <XTREES-EAT-YOU>
		       <RTRUE>)>
		<MAKE ,FOREST-EDGE ,MUNGED>
		<NEW-EXIT? ,ON-TRAIL ,P?EAST ,FCONNECT ,XTREES-BLOCK>
		<NEW-EXIT? ,ON-TRAIL ,P?DOWN ,FCONNECT ,XTREES-BLOCK>
		<NEW-EXIT? ,IN-THRIFF ,P?SOUTH ,FCONNECT ,XTREES-BLOCK>
		<NEW-EXIT? ,IN-THRIFF ,P?UP ,FCONNECT ,XTREES-BLOCK>
		<REPLACE-GLOBAL? ,ON-TRAIL ,NULL ,XTREES>
		<REPLACE-GLOBAL? ,IN-THRIFF ,NULL ,XTREES>
		<COND (<HERE? IN-THRIFF IN-CHAPEL ON-TRAIL>
		       <XTREES-APPEAR>
		       <RTRUE>)>
		<RFALSE>)
	       (<NOT <IS? ,IN-THRIFF ,MUNGED>>
		<COND (<HERE? IN-THRIFF IN-CHAPEL>
		       <XTREES-EAT-YOU>
		       <RTRUE>)>
		<MAKE ,IN-THRIFF ,MUNGED>
		<NEW-EXIT? ,IN-PASTURE ,P?SE ,FCONNECT ,XTREES-BLOCK>
		<NEW-EXIT? ,AT-FALLS ,P?SW ,FCONNECT ,XTREES-BLOCK>
		<REPLACE-GLOBAL? ,IN-PASTURE ,NULL ,XTREES>
		<REPLACE-GLOBAL? ,AT-FALLS ,NULL ,XTREES>
		<COND (<HERE? IN-PASTURE AT-FALLS>
		       <XTREES-APPEAR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>
		      		
<ROUTINE XTREES-BLOCK ()
	 <COND (<AND <IN? ,BFLY ,PLAYER>
		     <IS? ,BFLY ,MUNGED>>
		<TELL CTHE ,XTREES 
" fidget nervously as you approach, but refuse to stand aside." CR>
		<RFALSE>)>
	 <PRINT "Your path is hopelessly blocked by ">
	 <TELL 'XTREES ,PERIOD>
	 <RFALSE>>

<ROUTINE XTREES-EAT-YOU ("OPT" X)
	 <COND (<NOT <ASSIGNED? X>>
		<SAY-XTREES>)>
	 <TELL
" continue their delayed migration into Thriff, cheerfully trampling everything in their path. This includes you">
	 <JIGS-UP>
	 <RTRUE>>
		
<ROUTINE XTREES-APPEAR ("AUX" X)
	 <WINDOW ,SHOWING-ROOM>
	 <SETG P-THEM-OBJECT ,XTREES>
	 <TELL ,TAB>
	 <COND (<HERE? IN-CHAPEL>
		<TELL ,YOU-HEAR "a">
		<PRINT "n ominously cheerful rustling sound ">
		<TELL "outside." CR>
		<RTRUE>)>
	 <TELL "A">
	 <PRINT "n ominously cheerful rustling sound ">
	 <TELL "draws your attention to the ">
	 <SET X ,W?SOUTH>
	 <COND (<HERE? IN-PASTURE>
		<SET X ,W?SOUTHEAST>)
	       (<HERE? AT-FALLS>
		<SET X ,W?SOUTHWEST>)
	       (<HERE? ON-TRAIL>
		<SET X ,W?EAST>)>
	 <TELL B .X ", where a solid wall of " 'XTREES
	       " has completely choked the trail." CR>
	 <RTRUE>>

<ROUTINE I-UNHAPPY-XTREES ()
	 <COND (<NOT <HERE? FOREST-EDGE>>
		<RFALSE>)
	       (<IS? ,XTREES ,SEEN>
		<UNMAKE ,XTREES ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <SAY-XTREES>
	 <TELL <PICK-NEXT ,SAD-TREES> ,PERIOD>
	 <RTRUE>>

<ROUTINE I-HOUSEFALL ()
	 <COND (<NOT <PLAIN-ROOM?>>
		<RFALSE>)
	       (<IS? ,FARM ,NODESC>
		<UNMAKE ,FARM ,NODESC>
	        <RFALSE>)>
	 <DEQUEUE ,I-HOUSEFALL>
	 <UNMAKE ,FARMHOUSE ,NODESC>
	 <COND (<T? ,FARM-ROOM>
		<DROP-FARM>)>
	 <MAKE ,CORBIES ,SEEN>
	 <TELL "  A movement overhead catches your eye" ,PTAB
"Oh, my. A small farmhouse is falling out of the clouds! You ">
	 <COND (<HERE? FARM-ROOM>
		<SETG P-WALK-DIR <>>
		<SET OLD-HERE <>>
		<WINDOW ,SHOWING-ROOM>
		<SETG P-IT-OBJECT ,FARMHOUSE>
		<TELL "dive out of the way just in time to avoid ">
		<LUMBER>
		<TELL ,PERIOD>
		<RTRUE>)>
	 <TELL "watch it spin as it tumbles earthward, and hear ">
	 <LUMBER>
	 <TELL " somewhere nearby." CR>
	 <RTRUE>>

<ROUTINE LUMBER ()
	 <TELL ,LTHE>
	 <ITALICIZE "crunch">
	 <TELL " of splintering lumber">
	 <RFALSE>>

<ROUTINE DROP-FARM ()
	 <UNMAKE ,FARM ,NODESC>
	 <MOVE ,FARM ,FARM-ROOM>
	 <PUTP ,FARM-ROOM ,P?SDESC ,DESCRIBE-FARM-ROOM>
	 <REPLACE-GLOBAL? ,FARM-ROOM ,NULL ,FARM-DOOR>
	 <REPLACE-GLOBAL? ,FARM-ROOM ,NULL ,FARM-WINDOW>
	 <NEW-EXIT? ,IN-FARM ,P?NORTH %<+ ,DCONNECT 1 ,MARKBIT>
		     ,FARM-ROOM ,FARM-DOOR>
	 <NEW-EXIT? ,IN-FARM ,P?OUT %<+ ,DCONNECT 1 ,MARKBIT>
		    ,FARM-ROOM ,FARM-DOOR>
	 <NEW-EXIT? ,FARM-ROOM ,P?SOUTH %<+ ,DCONNECT 1 ,MARKBIT>
		    ,IN-FARM ,FARM-DOOR>
	 <NEW-EXIT? ,FARM-ROOM ,P?IN %<+ ,DCONNECT 1 ,MARKBIT>
		    ,IN-FARM ,FARM-DOOR>
	 <RFALSE>>

<ROUTINE I-IQ ()
	 <WINDOW ,SHOWING-ALL>
	 <TELL ,TAB
"Your forehead tingles oddly for a moment." CR>
	 <UPDATE-STAT 20 ,INTELLIGENCE T>
	 <RTRUE>>

<ROUTINE I-HEAL ("AUX" (STAT 0) MAX OLD)
	 <TELL ,TAB 
"Your body is flooded with an indescribable sense of well-being." CR>
	 <REPEAT ()
	    <SET OLD <GET ,STATS .STAT>>
	    <SET MAX <GET ,MAXSTATS .STAT>>
	    <COND (<G? .MAX .OLD>
		   <UPDATE-STAT <- .MAX .OLD> .STAT>)
		  (<EQUAL? .MAX .OLD>
		   <UPDATE-STAT 5 .STAT T>)>
	    <COND (<IGRTR? STAT ,STRENGTH>
		   <RETURN>)>>
	 <BMODE-OFF>
	 <RTRUE>>

<ROUTINE I-MIGHT ("AUX" MAX OLD)
	 <TELL ,TAB 
"You feel a surge of tension in your arms and shoulders." CR>
	 <SET OLD <GET ,STATS ,STRENGTH>>
	 <SET MAX <GET ,MAXSTATS ,STRENGTH>>
	 <COND (<G? .MAX .OLD>
		<UPDATE-STAT <- .MAX .OLD> ,STRENGTH>)
	       (<EQUAL? .MAX .OLD>
		<UPDATE-STAT 16 ,STRENGTH T>)>
	 <RTRUE>>

<ROUTINE I-FORGET ("AUX" (ANY 0) OBJ LEN)
	 <UNMAKE ,GLYPH ,SEEN>
	 <COND (<SET OBJ <FIRST? ,ROOMS>>
		<REPEAT ()
		   <UNMAKE .OBJ ,VIEWED>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <WINDOW ,SHOWING-ALL>
	 <SETG P-WALK-DIR <>>
	 <SETG OLD-HERE <>>
	 <SET LEN <GET ,MAGIC-ITEMS 0>>
	 <REPEAT ()
	    <SET OBJ <GET ,MAGIC-ITEMS .LEN>>
	    <COND (<IS? .OBJ ,IDENTIFIED>
		   <INC ANY>
		   <UNMAKE .OBJ ,IDENTIFIED>
		   <UNMAKE .OBJ ,PROPER>)>
	    <COND (<DLESS? LEN 1>
		   <RETURN>)>>
	 <TELL ,TAB "An uneasy feeling creeps into your soul." CR>
	 <RTRUE>>

<ROUTINE I-DEATH ()
	 <TELL ,TAB
"A sickening bile rises in your throat, and sweat breaks out on your forehead as your pulse races out of control. Moments later, you experience the combined effects of coronary arrest, catastrophic respiratory collapse and rickets">
	 <JIGS-UP>
	 <RTRUE>>

<ROUTINE I-CAKE ()
	 <COND (<IN? ,CAKE ,IN-GURTH>
		<REMOVE ,CAKE>
		<COND (<HERE? IN-GURTH>
		       <WINDOW ,SHOWING-ROOM>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL ,TAB
"An alley cat races between your legs, snatches " THE ,CAKE " and">
		       <PRINT " disappears into the ">
		       <TELL "crowd." CR>
		       <RTRUE>)>)>
	 <RFALSE>>

<GLOBAL QUAKE-TIMER:NUMBER 0>

<ROUTINE I-QUAKE ()
	 <TELL ,TAB>
	 <COND (<IGRTR? QUAKE-TIMER 4>
		<ENDING>
		<RTRUE>)
	       (<EQUAL? ,QUAKE-TIMER 4>
		<TELL CTHE ,GROUND
" heaves sharply to the right, and bits of broken rock shower down on your head. One more like that..." CR>
		<RTRUE>)
	       (<EQUAL? ,QUAKE-TIMER 3>
		<TELL
"The rumble grows to a roar as a mighty earthquake rocks the caverns to their very roots." CR>
		<RTRUE>)
	       (<EQUAL? ,QUAKE-TIMER 2>
		<TELL 
"Another tremor wracks the earth, and a deep, ominous rumble begins to swell around you." CR>
		<RTRUE>)
	       (T
		<TELL CTHE ,GROUND 
		      " underfoot trembles for a moment." CR>
		<RTRUE>)>>










		       
		

		


		 

	  
		
		      

	       

	 
	 
		     
		   
		   


			      
	       

	       



			      
		       
	       
	       
	       
	 
	 
		
		
	 
	 



