"MISC for BEYOND ZORK:
 Copyright (C)1987 Infocom, Inc. All Rights Reserved."

"*** ZCODE STARTS HERE ***"

<OBJECT GLOBAL-OBJECTS
	(FLAGS LOCATION LIGHTED INDOORS MAPPED PLACE NODESC
	       NOARTICLE PROPER VOWEL PLURAL NOALL SEEN PART
	       TOUCHED SURFACE CONTAINER OPENABLE DOORLIKE OPENED
	       TRANSPARENT LOCKED TAKEABLE TRYTAKE CLOTHING WORN
	       LIVING PERSON FEMALE MUNGED TOOL VEHICLE FERRIC
	       READABLE MANUALLY WIELDED WEAPON MONSTER SLEEPING
	       STRICKEN SURPRISED NAMED BUOYANT NEUTRALIZED
	       IDENTIFIED USED VIEWED NAMEABLE)>

<OBJECT LOCAL-GLOBALS
	(LOC GLOBAL-OBJECTS)
	(DESC "that")
	(FLAGS NODESC)>

<OBJECT ROOMS
	(FLAGS NODESC NOARTICLE)
	(DESC "that")>

<OBJECT DUMMY-OBJECT
	(FLAGS NODESC NOARTICLE)
	(DESC "nothing")>

<GLOBAL WINNER:OBJECT 0>

<GLOBAL TAB "  ">
<GLOBAL PERIOD ".|">
<GLOBAL PTAB ".|  ">
<GLOBAL YOU-SEE "You see ">
<GLOBAL LYOU-SEE ", you see ">
<GLOBAL CANT "You can't ">
<GLOBAL DONT "You don't ">
<GLOBAL YOU-HEAR "You hear ">
<GLOBAL ALREADY "You're already ">
<GLOBAL BRACKET "]|  ">
<GLOBAL IMPOSSIBLY "You couldn't possibly ">
<GLOBAL XTHE "The ">
<GLOBAL LTHE "the ">
<GLOBAL COMMA-AND ", and ">
<GLOBAL SINTO " into ">
<GLOBAL WITH " with ">
<GLOBAL CYOU "You ">
<GLOBAL AND " and ">
<GLOBAL CYOUR "Your ">
<GLOBAL SIN " in ">
<GLOBAL SON " on ">
<GLOBAL SIS " is ">
<GLOBAL STO " to ">
<GLOBAL XA "A ">
<GLOBAL STHE " the ">
<GLOBAL GLANCES-AT " glances at ">
<GLOBAL NOTHING "There's nothing ">
<GLOBAL AT-MOMENT " at the moment.|">
<GLOBAL CTHELADY "The old woman">
<GLOBAL SFIRST " first.|">
<GLOBAL PERQ ".\"|">

<GLOBAL HOST 0> "Host machine ID."
<GLOBAL VT220:FLAG <>> "Charsets available?"
<GLOBAL COLORS?:FLAG <>> "Color available?"
<GLOBAL GRAPHICS?:FLAG <>> "Graphics available?"
<GLOBAL CWIDTH:NUMBER 0> "Pixel width of mono chars."
<GLOBAL CHEIGHT:NUMBER 0> "Pixel height of mono chars."
<GLOBAL WIDTH:NUMBER 0> "Character width of screen."
<GLOBAL HEIGHT:NUMBER 0> "Character height of screen."
<GLOBAL SWIDTH:NUMBER 0> "Width of status bars (in characters)."
<GLOBAL BARWIDTH:NUMBER 0> "Width of a complete status bar."
<GLOBAL DWIDTH:NUMBER 0> "Width of status line and DBOX window."
<GLOBAL BOXWIDTH:NUMBER 0> "Justify and display width for DBOX."
<GLOBAL MOUSEDGE:NUMBER 0> "Left edge of mouse mindow."
<GLOBAL BAR-RES:NUMBER 0> "Number of pixels/character."
<GLOBAL DHEIGHT:NUMBER 0> "Current height of DBOX."
<GLOBAL MAX-DHEIGHT:NUMBER 0> "Maximum height of DBOX."
<GLOBAL STAT-ROUTINE <>> "Vector to stat-printing routine."
<GLOBAL BGND:NUMBER ,C-BLACK>
<GLOBAL FORE:NUMBER ,C-WHITE>
<GLOBAL INCOLOR:NUMBER ,C-CYAN>
<GLOBAL GCOLOR:NUMBER ,C-RED>

<ROUTINE GO () 
       	 <SETG HERE ,HILLTOP>
	 <MOVE ,PLAYER ,HERE>	 
	 <SETG WINNER ,PLAYER>
	 <SETG LIT? T>
	 <INITVARS>
	 <STARTUP>
	 <SETUP-CHARACTER>
	 <SETG WINDIR <- <RANDOM 8> 1>>
	 <QUEUE ,I-BREEZE>
	 <V-REFRESH>
	 <CRLF>
	 <V-LOOK>
	 <DO-MAIN-LOOP>
	 <AGAIN>>

<ROUTINE DO-MAIN-LOOP ("AUX" X)
	 <REPEAT ()
		 <SET X <MAIN-LOOP>>>>

<GLOBAL P-MULT?:FLAG <>>

<ROUTINE MAIN-LOOP ("AUX" ICNT OCNT NUM CNT OBJ TBL (V <>)
		          PTBL OBJ1 TMP X)
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<NOT <HERE? QCONTEXT-ROOM>>
	    <SETG QCONTEXT <>>
	    <SETG QCONTEXT-ROOM <>>)>
     <SETG P-WON <PARSER>>
     <COND (<T? ,P-WON>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND <T? ,P-IT-OBJECT>
			<ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
		      <COND (<IGRTR? CNT .ICNT>
			     <RETURN>)
			    (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
			     <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
			     <SET TMP T>
			     <RETURN>)>>
		   <COND (<ZERO? .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			     <COND (<IGRTR? CNT .OCNT>
				    <RETURN>)
				   (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
				    <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
				    <RETURN>)>>)>
		   <SET CNT 0>)>
	    <SET NUM 1>
	    <COND (<ZERO? .OCNT>
		   <SET NUM 0>)
		  (<G? .OCNT 1>
		   <SET TBL ,P-PRSO>
		   <SET OBJ <>>
		   <COND (<T? .ICNT>
			  <SET OBJ <GET ,P-PRSI 1>>)>
		   <SET NUM .OCNT>)
		  (<G? .ICNT 1>
		   <SET PTBL <>>
		   <SET TBL ,P-PRSI>
		   <SET OBJ <GET ,P-PRSO 1>>
		   <SET NUM .ICNT>)>
	    <COND (<AND <ZERO? .OBJ>
			<EQUAL? .ICNT 1>>
		   <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<VERB? WALK>
		   <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<ZERO? .NUM>
		   <COND (<NOT <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<ZERO? ,LIT?>
			  <PCLEAR>
			  <TOO-DARK>)
			 (T
			  <PCLEAR>
			  <TELL "[There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (<SET X <TALKING?>>
			         <TELL "talk to">)
				(<OR <T? ,P-MERGED>
				     <T? ,P-OFLAG>>
				 <PRINTB <GET .TMP 0>>)
				(T
				 <SET X <GETB .TMP 3>>
				 <WORD-PRINT <GETB .TMP 2> .X>)>
			  <TELL ".]" CR>
			  <SET V <>>)>)
		; (<AND <T? .PTBL>
			<G? .NUM 1>
			<VERB? COMPARE>>
		   <SET V <PERFORM ,PRSA ,OBJECT-PAIR>>)
		  (T
		   <SET X 0>
		   <SETG P-MULT? <>>
		   <COND (<G? .NUM 1>
			  <SETG P-MULT? T>)>
		   <SET TMP <>>
		   <REPEAT ()
		    <COND (<IGRTR? CNT .NUM>
			   <COND (<G? .X 0>
				  <TELL "[The ">
				  <COND (<NOT <EQUAL? .X .NUM>>
					 <TELL "other ">)>
				  <TELL "object">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL "s">)>
				  <TELL " that you mentioned ">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL "are">)
					(T <TELL "is">)>
				  <TELL "n't here.]" CR>)
				 (<ZERO? .TMP>
				  <REFERRING>)>
			   <RETURN>)>
		    <COND (<T? .PTBL>
			   <SET OBJ1 <GET ,P-PRSO .CNT>>)
			  (T
			   <SET OBJ1 <GET ,P-PRSI .CNT>>)>
		    <COND (<OR <G? .NUM 1>
			       <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0>
				       ,W?ALL ,W?EVERYTHING>>
			   <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
				  <INC X>
				  <AGAIN>)
				 (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
				       <DONT-ALL? .OBJ1 .OBJ>>
				  <AGAIN>)
				 (<NOT <ACCESSIBLE? .OBJ1>>
				  <AGAIN>)
				 (<EQUAL? .OBJ1 ,PLAYER>
				  <AGAIN>)>
			   <COND (<EQUAL? .OBJ1 ,IT>
				  <COND (<NOT <IS? ,P-IT-OBJECT ,NOARTICLE>>
					 <TELL ,XTHE>)>
				  <TELL D ,P-IT-OBJECT>)
				 (T
				  <COND (<NOT <IS? .OBJ1 ,NOARTICLE>>
					 <TELL ,XTHE>)>
				  <TELL D .OBJ1>)>
			   <TELL ": ">)>
		    <SET TMP T>
		    <SETG PRSO .OBJ1>
		    <SETG PRSI .OBJ>
		    <COND (<ZERO? .PTBL>
			   <SETG PRSO .OBJ>
			   <SETG PRSI .OBJ1>)>
		    <SETG PSEUDO-PRSO? <>>
		    <COND (<EQUAL? ,PRSO ,PSEUDO-OBJECT>
			   <SETG PSEUDO-PRSO? T>)>
		    <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
		    <COND (<EQUAL? .V ,M-FATAL>
			   <RETURN>)>>)>
	    <COND (<EQUAL? .V ,M-FATAL>
		   <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (<AND <T? ,P-WON>
		 <NOT <EQUAL? .V ,M-FATAL>>
		 <NOT <SET X <GAMEVERB?>>>>
	    <SET V <CLOCKER>>)>
     <SETG PRSA <>>
     <SETG PRSO <>>
     <SETG PRSI <>>
     <RFALSE>>

<ROUTINE DONT-ALL? (O I "AUX" L X)
	 <SET L <LOC .O>>
	 <COND (<OR <ZERO? .L>
		    <EQUAL? .O .I>>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<EQUAL? .L ,WINNER>
		       <RTRUE>)
		    ; (<IN? .L ,WINNER>
		       <RTRUE>)
		      (<AND <ZERO? ,LIT?>
			    <NOT <IN? .L ,WINNER>>>
		       <RTRUE>)
		      (<IS? .O ,NOALL>
		       <RTRUE>)
		      (<AND <NOT <IS? .O ,TAKEABLE>>
			    <NOT <IS? .O ,TRYTAKE>>>
		       <RTRUE>)
		      (<AND <IS? .L ,CONTAINER>
			    <NOT <IS? .L ,OPENED>>>
		       <RTRUE>)
		      (<T? .I>
		       <COND (<NOT <EQUAL? .L .I>>
			      <RTRUE>)
			     (<SEE-INSIDE? .I>
			      <RFALSE>)>
		       <RTRUE>)
		      (<EQUAL? .L <LOC ,PLAYER>>
		       <RFALSE>)
		      (<AND <NOT <IS? .L ,TAKEABLE>>
			    <SEE-INSIDE? .L>>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<SET X <PUTTING?>>
		<COND (<IS? .O ,WORN>
		       <RTRUE>)
		      (<IS? .O ,WIELDED>
		       <RTRUE>)
		      (<EQUAL? .L ,WINNER>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (T
		<RFALSE>)>>

<GLOBAL C-INTS:NUMBER ,C-TABLE-LENGTH>

<ROUTINE DEQUEUE (RTN)
	 <SET RTN <QUEUED? .RTN>>
	 <COND (<T? .RTN>
		<COPYT .RTN 0 ,C-INTLEN>)>
	 <RFALSE>>

<ROUTINE QUEUED? (RTN "AUX" TBL LEN)
	 <SET TBL <REST ,C-TABLE ,C-INTS>>
	 <SET LEN </ <- <REST ,C-TABLE ,C-TABLE-LENGTH> .TBL> ,C-INTLEN>>
	 <COND (<L? .LEN 1>
		<RFALSE>)
	       (<SET RTN <INTBL? .RTN .TBL .LEN 132>>
		<COND (<ZERO? <GET .RTN ,C-TICK>>
		       <RFALSE>)>
		<RETURN .RTN>)>
	 <RFALSE>>

"This version of QUEUE automatically enables as well."

<ROUTINE QUEUE (RTN "OPT" (TICK -1) "AUX" C E (INT <>))
	 <SET E <REST ,C-TABLE ,C-TABLE-LENGTH>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
	    <COND (<EQUAL? .C .E>
		   <COND (<T? .INT>
			  <SET C .INT>)
			 (T
			  <COND (<L? ,C-INTS ,C-INTLEN>
			       ; <SAY-ERROR "QUEUE">
				 <RTRUE>)>
			  <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			  <SET INT <REST ,C-TABLE ,C-INTS>>)>
		   <PUT .INT ,C-RTN .RTN>
		   <RETURN>)
		  (<EQUAL? <GET .C ,C-RTN> .RTN>
		   <SET INT .C>
		   <RETURN>)
		  (<ZERO? <GET .C ,C-RTN>>
		   <SET INT .C>)>
	    <SET C <REST .C ,C-INTLEN>>>
	 <COND (<G? .INT ,CLOCK-HAND>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 <RETURN .INT>>

<GLOBAL CLOCK-WAIT?:FLAG <>>
<GLOBAL CLOCK-HAND:NUMBER <>>
<GLOBAL MOVES:NUMBER 0>

<ROUTINE CLOCKER ("AUX" (FLG 0) (Q? 0) E TICK RTN X OSTAT NSTAT MAX DELTA)
	 <COND (<T? ,CLOCK-WAIT?>
	        <SETG CLOCK-WAIT? <>>
	        <RFALSE>)>
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLE-LENGTH>>
	 <REPEAT ()
		 <COND (<EQUAL? ,CLOCK-HAND .E>
		        <INC MOVES>
			<COND (<REFRESH-STATS?>
			       <SET FLG T>)>
			<RETURN>)
		       (<GET ,CLOCK-HAND ,C-RTN>
			<SET TICK <GET ,CLOCK-HAND ,C-TICK>>
			<COND (<L? .TICK -1>
			       <PUT ,CLOCK-HAND ,C-TICK <- <- .TICK> 3>>
			       <SET Q? ,CLOCK-HAND>)
			      (<T? .TICK>
			       <COND (<G? .TICK 0>
				      <SET TICK <- .TICK 1>>
				      <PUT ,CLOCK-HAND ,C-TICK .TICK>)>
			       <COND (<T? .TICK>
				      <SET Q? ,CLOCK-HAND>)>
			       <COND (<NOT <G? .TICK 0>>
				      <SET RTN <GET ,CLOCK-HAND ,C-RTN>>
				      <COND (<ZERO? .TICK>
					     <COPYT ,CLOCK-HAND 0 ,C-INTLEN>
					   ; <PUT ,CLOCK-HAND ,C-RTN 0>)>
				      <SET X <APPLY .RTN>>
				      <COND (<T? .X>
					     <SET FLG T>)>
				      <COND (<AND <ZERO? .Q?>
						  <GET ,CLOCK-HAND ,C-RTN>>
					     <SET Q? T>)>)>)>)>
		 <SETG CLOCK-HAND <REST ,CLOCK-HAND ,C-INTLEN>>
		 <COND (<ZERO? .Q?>
			<SETG C-INTS <+ ,C-INTS ,C-INTLEN>>)>>
	 <RETURN .FLG>>

<GLOBAL NO-REFRESH:NUMBER -1>  "Which stat NOT to refresh."

<ROUTINE REFRESH-STATS? ("AUX" (CNT 0) (ANY 0) 
			      STAT OSTAT NSTAT DELTA MAX RATE)
	 <SET RATE ,NORMAL-RATE>
	 <COND (<AND <IN? ,SCABBARD ,PLAYER>
		     <IS? ,SCABBARD ,WORN>
		     <NOT <IS? ,SCABBARD ,NEUTRALIZED>>>
		<SET RATE ,BLESSED-RATE>)>
	 <SET STAT ,ENDURANCE>
	 <REPEAT ()
	    <SET OSTAT <GET ,STATS .STAT>>
	    <SET MAX <GET ,MAXSTATS .STAT>>
	    <COND (<AND <EQUAL? .STAT ,INTELLIGENCE>
			<WEARING-MAGIC? ,HELM>>)
		  (<EQUAL? ,NO-REFRESH .STAT>
		   <SETG NO-REFRESH -1>)
		  (<NOT <EQUAL? .OSTAT .MAX>>
		   <SET DELTA <PERCENT .RATE .MAX>>
		   <COND (<L? .DELTA 1>
			  <SET DELTA 1>)>
		   <COND (<G? .OSTAT .MAX>
			  <SET NSTAT <- .OSTAT .DELTA>>
			  <COND (<L? .NSTAT .MAX>
				 <SET NSTAT .MAX>)>)
			 (T
			  <SET NSTAT <+ .OSTAT .DELTA>>
			  <COND (<G? .NSTAT .MAX>
				 <SET NSTAT .MAX>)>)>
		   <PUT ,STATS .STAT .NSTAT>
		   <COND (<ZERO? ,DMODE>)
			 (<OR <EQUAL? ,IN-DBOX ,SHOWING-STATS>
			      <AND <T? ,BMODE>
				   <EQUAL? .STAT ,ENDURANCE>>>
			  <SHOW-STAT .STAT>)>
		   <INC ANY>
		   <COND (<EQUAL? .NSTAT .MAX>
			  <INC CNT>
			  <PUTB ,NEW-STATS .CNT .STAT>)>)>
	    <COND (<IGRTR? STAT ,LUCK>
		   <RETURN>)>>
	 
	 <COND (<ZERO? .ANY>
		<RFALSE>)
	       (<ZERO? ,DMODE>
		<UPPER-SLINE>)
	       (<ZERO? ,VT220>
		<APPLE-STATS>)>
	 
	 <COND (<ZERO? .CNT>
		<RFALSE>)
	       (<ZERO? ,SAY-STAT>
		<RFALSE>)>
	 	 
	 <COND (<NOT <EQUAL? ,HOST ,MACINTOSH>>
		<HLIGHT ,H-BOLD>)>
	 <TELL ,TAB "[Your ">
	 <SET ANY .CNT>
	 <REPEAT ()
	    <TELL <GET ,STAT-NAMES <GETB ,NEW-STATS .ANY>>>
	    <COND (<DLESS? ANY 1>
		   <RETURN>)
		  (<EQUAL? .ANY 1>
		   <TELL ,AND>)
		  (T
		   <TELL ", ">)>>
	 <TELL C ,SP>
	 <COND (<G? .CNT 1>
		<TELL B ,W?ARE>)
	       (T
		<TELL B ,W?IS>)>
	 <TELL " back to normal.]" CR>
	 <HLIGHT ,H-NORMAL>
	 <SOUND ,S-BEEP>
	 <COND (<ZERO? ,AUTO>)
	       (<EQUAL? <GETB ,NEW-STATS 1> ,ENDURANCE>
		<BMODE-OFF>)>
	 <RTRUE>>	 

<ROUTINE INITVARS ("AUX" X)
	 <SETG HOST <LOWCORE INTID>> ; "Establish host machine ID."
	 <SETG COLORS? <BAND <LOWCORE (ZVERSION 1)> 1>>
	 <SETG GRAPHICS? <BAND <LOWCORE FLAGS> 8>>
	 <SETG BAR-RES 8>
	 <COND (<EQUAL? ,HOST ,MACINTOSH>
		<PUTB ,TCHARS ,FIRST-MAC-ARROW ,MAC-UP-ARROW>
		<PUTB ,TCHARS <+ ,FIRST-MAC-ARROW 1> ,MAC-DOWN-ARROW>
		<SETG BAR-RES 6>)>
	 <HLIGHT ,H-MONO>
	 <SETG CWIDTH <LOWCORE (FWRD 0)>> ; "Pixel width of chars."
	 <SETG CHEIGHT <LOWCORE (FWRD 1)>> ; "Pixel height of chars."
	 <SET X <FONT ,F-NEWFONT>> ; "For IBM."
	 <SET X <FONT ,F-DEFAULT>>
	 <HLIGHT ,H-NORMAL>
	 	          
	 <SET X <LOWCORE HWRD>> ; "Get pixel width of screen."	 
	 <SETG WIDTH </ .X ,CWIDTH>> ; "Screen width in chars."
	 <COND (<G? ,WIDTH 80>
		<SETG WIDTH 80>)>
	 
	 <SET X <LOWCORE VWRD>> ; "Get pixel height of screen."	 
	 <SETG HEIGHT </ .X ,CHEIGHT>> ; "Screen width in chars."
	 	 
	 <SETG DWIDTH <- ,WIDTH %<+ ,MWIDTH 3>>> ; "Width of DBOX."
	 <SETG BOXWIDTH ,DWIDTH>
	 <COND (<EQUAL? ,HOST ,APPLE-2C>
		<DEC BOXWIDTH>)>
	 <SETG MOUSEDGE <- <- ,WIDTH ,MWIDTH> 1>>

         <SETG SWIDTH <+ </ ,STATMAX ,BAR-RES> 1>>
	 <SETG BARWIDTH <+ <+ ,LABEL-WIDTH ,SWIDTH> 5>>
	 
	 <SETG CAN-UNDO 0>
	 <SETG STAT-ROUTINE ,RAWBAR>
	 <SETG VT220 T>
	 <SETG MAX-DHEIGHT ,NORMAL-DHEIGHT>
	 <SETG DHEIGHT ,MAX-DHEIGHT>
	 <SETG MAP-ROUTINE ,CLOSE-MAP>
	 <COND (<OR <T? ,VT100>
		    <EQUAL? ,HOST ,APPLE-2E ,APPLE-2C>
		    <AND <ZERO? ,GRAPHICS?>
			 <EQUAL? ,HOST ,IBM>>>
		<SETUP-APPLE-MODE>)>
	 <RFALSE>>
	 	 	 	      
<ROUTINE SETUP-APPLE-MODE ()
	 <SETG VT220 <>>
	 <SETG GRAPHICS? <>>
	 <SETG STAT-ROUTINE ,BAR-NUMBER>
	 <SETG MAX-DHEIGHT %<- ,NORMAL-DHEIGHT 1>>
	 <SETG MAP-ROUTINE ,FAR-MAP>
	 <SETG DHEIGHT ,MAX-DHEIGHT>
	 <RFALSE>>

<ROUTINE CENTER (Y X)
	 <DO-CURSET .Y </ <- ,WIDTH .X> 2>> 
	 <RFALSE>>

<ROUTINE DO-CURSET (Y X)
	 <COND (<NOT <EQUAL? 1 ,CWIDTH ,CHEIGHT>>
		<DEC X>
	 	<SET X <* .X ,CWIDTH>>
	 	<INC X>
	 	<DEC Y>
	 	<SET Y <* .Y ,CHEIGHT>>
	 	<INC Y>)>
	 <CURSET .Y .X>
	 <RFALSE>>

<ROUTINE TO-TOP-WINDOW ("AUX" X)
	 <SET X <FONT ,F-DEFAULT>>
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 <HLIGHT ,H-NORMAL>
	 <HLIGHT ,H-MONO>        
	 <COLOR ,GCOLOR ,BGND>
	 <RFALSE>>

<ROUTINE TO-BOTTOM-WINDOW ("AUX" X)
	 <SET X <FONT ,F-DEFAULT>>
	 <SCREEN ,S-TEXT>
	 <BUFOUT T>
	 <HLIGHT ,H-NORMAL>         
	 <COLOR ,FORE ,BGND>
	 <RFALSE>>

<GLOBAL OLD-HERE:OBJECT <>>

<ROUTINE V-REFRESH ("AUX" REDGE X)
	 <SET X <LOWCORE FLAGS>>
	 <LOWCORE FLAGS <BAND .X #2 1111111111111011>>
	 <SETG OLD-HERE <>>
         <SETG P-WALK-DIR <>>
	 <COLOR ,FORE ,BGND>	 
	 <CLEAR -1>
	 <COND (<ZERO? ,DMODE>
		<SPLIT 2>
		<TO-BOTTOM-WINDOW>
		<RTRUE>)>
	 <SETG NEW-DBOX ,IN-DBOX>
	 <SPLIT 12>
	 
	 <COND (<ZERO? ,VT220>
		<APPLE-STATS>
		<COND (<EQUAL? ,HOST ,APPLE-2C>
		       <2C-BOX>)
		      (<EQUAL? ,HOST ,IBM>
		       <IBM-BOX>)>
		<RTRUE>)>
	 
	 <TO-TOP-WINDOW>
	 <SET X <FONT ,F-NEWFONT>>
	 <SET REDGE <- <- ,WIDTH ,MWIDTH> 1>>
	 
	 <DO-CURSET 2 1>
	 <PRINTC ,TLC>
	 <SET X .REDGE>
	 <REPEAT ()
	    <PRINTC ,TOP>
	    <COND (<DLESS? X 3>
		   <RETURN>)>>
	 <PRINTC ,TRC>
	 
	 <DO-CURSET 12 1>
	 <PRINTC ,BLC>
	 <SET X .REDGE>
	 <REPEAT ()
	    <PRINTC ,BOT>
	    <COND (<DLESS? X 3>
		   <RETURN>)>>
	 <PRINTC ,BRC>
	 		  
	 <SET X 3>
	 <REPEAT ()
	    <DO-CURSET .X 1>
	    <PRINTC ,RSID>
	    <DO-CURSET .X .REDGE>
	    <PRINTC ,LSID>
	    <COND (<IGRTR? X 11>
		   <RETURN>)>>
	 
	 <SETG DHEIGHT ,MAX-DHEIGHT>
	 <TO-BOTTOM-WINDOW>	 	 
	 <COND (<EQUAL? ,PRIOR ,SHOWING-STATS>
		<SHOW-RANK>
		<DISPLAY-STATS>)
	       (<T? ,BMODE>
		<BATTLE-MODE-ON>)>
	 <RTRUE>>

<ROUTINE IBM-BOX ("AUX" REDGE X)
	 <TO-TOP-WINDOW>
	 <SET X <FONT ,F-NEWFONT>>
	 
	 <SET REDGE <- <- ,WIDTH ,MWIDTH> 1>>
	 
	 <CURSET 3 1>
	 <PRINTC ,IBM-TLC>
	 <SET X .REDGE>
	 <REPEAT ()
	    <PRINTC ,IBM-HORZ>
	    <COND (<DLESS? X 3>
		   <RETURN>)>>
	 <PRINTC ,IBM-TRC>
	 
	 <DO-CURSET 12 1>
	 <PRINTC ,IBM-BLC>
	 <SET X .REDGE>
	 <REPEAT ()
	    <PRINTC ,IBM-HORZ>
	    <COND (<DLESS? X 3>
		   <RETURN>)>>
	 <PRINTC ,IBM-BRC>
	 		  
	 <SET X 4>
	 <REPEAT ()
	    <DO-CURSET .X 1>
	    <PRINTC ,IBM-VERT>
	    <DO-CURSET .X .REDGE>
	    <PRINTC ,IBM-VERT>
	    <COND (<IGRTR? X 11>
		   <RETURN>)>>
	 
	 <TO-BOTTOM-WINDOW>
	 <RTRUE>>
			
<ROUTINE 2C-BOX ("AUX" CNT X)
	 <TO-TOP-WINDOW>
	 <SET X <FONT ,F-NEWFONT>>
       
       ; "Draw bottom edge."
		
	 <SET X <- <- ,WIDTH ,MWIDTH> 2>> ; "Right edge." 
	 <SET CNT 2>
	 <CURSET 12 2>
	 <REPEAT ()
	    <PRINTC ,APPLE-HORZ>
	    <COND (<IGRTR? CNT .X>
		   <RETURN>)>>
	 
       ; "Do sides."
	   
	  <SET X 1>
	  <REPEAT ()
	     <CURSET .X 1>
	     <PRINTC ,APPLE-RIGHT>
	     <CURSET .X .CNT>
	     <PRINTC ,APPLE-LEFT>
	     <COND (<IGRTR? X 11>
		    <RETURN>)>>
	  <TO-BOTTOM-WINDOW>
	  <RTRUE>>

<ROUTINE DISPLAY-PLACE ("AUX" (DIR 0) LEN X DEST END)
       	 <SET LEN <GETB ,ROOMS-MAPPED 0>>
	 <COND (<ZERO? .LEN>)
	       (<ZERO? ,OLD-HERE>)
	       (<SET DEST <INTBL? ,OLD-HERE <REST ,ROOMS-MAPPED 1> .LEN 1>>
		<SET END <REST ,ROOMS-MAPPED .LEN>>
		<COND (<L? .DEST .END>
		       <SET X <- 0 <- .END .DEST>>>
		       <COPYT <REST .DEST 1> .DEST .X>)>
		<PUTB ,ROOMS-MAPPED 0 <- .LEN 1>>)>
	 <SETUP-SLINE>
	 <SAY-HERE>
	 <CENTER-SLINE>
	 <SHOW-SLINE>
	 <COND (<OR <EQUAL? ,P-WALK-DIR <> ,P?UP ,P?DOWN>
		    <EQUAL? ,P-WALK-DIR ,P?IN ,P?OUT>>
		<NEW-MAP>)
	       (T
		<REPEAT ()
		   <COND (<EQUAL? ,P-WALK-DIR <GETB ,PDIR-LIST .DIR>>
			  <SET X <+ .DIR 4>>
			  <COND (<G? .X ,I-NW>
				 <SET X <- .X 8>>)>
			  <SET LEN <GETP ,HERE <GETB ,PDIR-LIST .X>>>
			  <COND (<ZERO? .LEN>
				 <NEW-MAP>
				 <RETURN>)>
			  <SET LEN <BAND <GET .LEN ,XTYPE> 127>>
			  <INC LEN>
			  <SET X <GET ,YOFFS .DIR>>
			  <COND (<EQUAL? ,MAP-ROUTINE ,CLOSE-MAP>
				 <SET X <+ .X .X>>)>
			  <SET X <* .X .LEN>>
			  <SETG MAPY <+ ,MAPY .X>>
			  <SET X <GET ,XOFFS .DIR>>
			  <COND (<EQUAL? ,MAP-ROUTINE ,CLOSE-MAP>
				 <SET X <+ .X .X>>)>
			  <SET X <* .X .LEN>>
			  <SETG MAPX <+ ,MAPX .X>>
			  <COND (<OR <L? ,MAPY 1>
				     <G? ,MAPY %<- ,MHEIGHT 2>>
				     <L? ,MAPX 1>
				     <G? ,MAPX %<- ,MWIDTH 2>>>
				 <NEW-MAP>
				 <RETURN>)>
			; <APPLY ,MAP-ROUTINE ,HERE ,MAPY ,MAPX>
			  <DRAW-MAP>
			  <RETURN>)>
		   <COND (<IGRTR? DIR ,I-NW>
			  <RETURN>)>>)>      
	 <SHOW-MAP>
	 <COND (<AND <T? ,DMODE>
		     <EQUAL? ,PRIOR 0 ,SHOWING-ROOM>>
		<SETG DBOX-TOP 0>
		<UPDATE-ROOMDESC>)>
	 <SETG OLD-HERE ,HERE>
	 <RTRUE>>
	
<ROUTINE REFRESH-MAP ("OPT" (NEW T))
	 <COND (<ZERO? ,DMODE>
		<LOWER-SLINE>
		<RFALSE>)>
	 <SETG SAME-COORDS .NEW>
	 <WINDOW ,SHOWING-ROOM>
	 <NEW-MAP>
	 <SHOW-MAP>
	 <RFALSE>>

<ROUTINE SHOW-MAP ("AUX" X)
         <TO-TOP-WINDOW>
	 <COND (<T? ,VT220>
		<SET X <FONT ,F-NEWFONT>>)>
	 <DO-CURSET 1 <- ,WIDTH ,MWIDTH>>
	 <PRINTT ,MAP ,MWIDTH ,MHEIGHT>
	 <TO-BOTTOM-WINDOW>
	 <RFALSE>>

<ROUTINE SHOW-RANK ("OPT" (RIGHT-EDGE ,DWIDTH) "AUX" LEN X)
	 <SETUP-SLINE>
	 <TELL C ,SP>
	 <PRINT-TABLE ,CHARNAME>
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,AUX-TABLE 0>>
	 <COPYT <REST ,AUX-TABLE 2> ,SLINE .LEN>
	 <PUT ,AUX-TABLE 0 0>
	 <DIROUT ,D-TABLE-ON ,AUX-TABLE>
	 <ANNOUNCE-RANK>
	 <PRINTC ,SP>
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,AUX-TABLE 0>>
	 <SET X <REST ,SLINE <- .RIGHT-EDGE .LEN>>>
	 <COPYT <REST ,AUX-TABLE 2> .X .LEN>
	 <SHOW-SLINE 1 .RIGHT-EDGE>
	 <RTRUE>>

<GLOBAL RANK:NUMBER 0>

<ROUTINE ANNOUNCE-RANK ("AUX" (LEVEL 0) STAT)
	 <SET STAT <GET ,STATS ,EXPERIENCE>>
	 <TELL "Level ">
	 <REPEAT ()
	    <COND (<L? .STAT <GET ,THRESHOLDS .LEVEL>>
		   <RETURN>)
		  (<IGRTR? LEVEL ,MAX-LEVEL>
		   <SET LEVEL 0>
		   <PUT ,STATS ,EXPERIENCE 0>
		   <COND (<IGRTR? RANK 2>
			  <SET RANK 2>)>
		   <RETURN>)>>
	 <TELL N .LEVEL C ,SP>
	 <COND (<IS? ,PLAYER ,FEMALE>
		<TELL "Fem">)
	       (T
		<TELL "M">)>
	 <TELL "ale " <GET ,RANK-NAMES ,RANK>>
	 <RETURN .LEVEL>>

<ROUTINE SETUP-SLINE ()
	 <PUTB ,SLINE 0 ,SP>
	 <COPYT ,SLINE <REST ,SLINE 1> %<- 0 <- ,SLINE-LENGTH 1>>>
	 <PUT ,AUX-TABLE 0 0>
	 <DIROUT ,D-TABLE-ON ,AUX-TABLE>
	 <RFALSE>>

<ROUTINE CENTER-SLINE ("AUX" X LEN)
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,AUX-TABLE 0>>
	 <SET X <REST ,SLINE </ <- ,DWIDTH .LEN> 2>>>
	 <COPYT <REST ,AUX-TABLE 2> .X .LEN>
	 <RFALSE>>

<ROUTINE SHOW-SLINE ("OPT" (Y 1) (RIGHT-EDGE ,DWIDTH) "AUX" X)
	 <TO-TOP-WINDOW>
	 <DO-CURSET .Y 1>
	 <COND (<EQUAL? .RIGHT-EDGE ,WIDTH>)
	       (<T? ,VT220>
		<SET X <FONT ,F-NEWFONT>>
		<PRINTC 58>
		<SET X <FONT ,F-DEFAULT>>)
	       (<EQUAL? ,HOST ,APPLE-2C>
		<SET X <FONT ,F-NEWFONT>>
		<PRINTC ,APPLE-RIGHT>
		<SET X <FONT ,F-DEFAULT>>)
	       (T
		<TELL C ,SP>)>
	 <HLIGHT ,H-INVERSE>
	 <PRINTT ,SLINE .RIGHT-EDGE>
	 <HLIGHT ,H-NORMAL>
         <HLIGHT ,H-MONO>
	 <COND (<EQUAL? .RIGHT-EDGE ,WIDTH>)
	       (<T? ,VT220>
		<SET X <FONT ,F-NEWFONT>>
		<PRINTC 57>
		<SET X <FONT ,F-DEFAULT>>)
	       (<EQUAL? ,HOST ,APPLE-2C>
		<SET X <FONT ,F-NEWFONT>>
		<PRINTC ,APPLE-LEFT>
		<SET X <FONT ,F-DEFAULT>>)
	       (T
		<TELL C ,SP>)>
	 <TO-BOTTOM-WINDOW>
	 <RFALSE>>

<ROUTINE SAY-HERE ("AUX" X)
	 <COND (<HERE? DEATH>)
	       (<ZERO? ,LIT?>
		<TELL "Darkness">
		<RTRUE>)>
	 <TELL D ,HERE>
	 <SET X <LOC ,PLAYER>>
	 <COND (<IS? .X ,VEHICLE>
		<TELL C ,COMMA>
		<COND (<AND <EQUAL? .X ,SADDLE>
			    <IN? ,SADDLE ,DACT>>
		       <TELL ,SON A ,DACT>
		       <RTRUE>)>
		<ON-IN .X>)>
	 <RTRUE>>

<ROUTINE PRINT-SPACES (N) 
	 <REPEAT ()
		 <COND (<DLESS? N 0>
			<RTRUE>)>
		 <TELL C ,SP>>>

<GLOBAL MAPX:NUMBER ,CENTERX>
<GLOBAL MAPY:NUMBER ,CENTERY>

<GLOBAL MAP-ROUTINE <>>

<GLOBAL SAME-COORDS:FLAG <>>

<ROUTINE NEW-MAP ("AUX" TBL X)
	 <COND (<T? ,SAME-COORDS>
		<SETG SAME-COORDS <>>)
	       (T
		<SETG MAPX ,CENTERX>
		<SETG MAPY ,CENTERY>
	        <SET TBL <GETPT ,HERE ,P?COORDS>>
	        <COND (<T? .TBL>
		       <SET X <GETB .TBL 0>>
		       <COND (<T? .X>
			      <SETG MAPX .X>)>
		       <SET X <GETB .TBL 1>>
		       <COND (<T? .X>
			      <SETG MAPY .X>)>)>)>
	 <DRAW-MAP>
	 <RTRUE>>
	 
<ROUTINE DRAW-MAP ()
	 <COPYT ,ROOMS-MAPPED 0 ,ROOMS-MAPPED-LENGTH>
	 <PUTB ,MAP 0 ,SP>
	 <COPYT ,MAP <REST ,MAP 1> %<- 0 <- ,MAP-SIZE 1>>>
	 <APPLY ,MAP-ROUTINE ,HERE ,MAPY ,MAPX>
	 <RFALSE>>

<ROUTINE CLOSE-MAP (RM Y X "AUX" DIR TBL CHAR TYPE LEN DEST
		    		 NY NX YOFF XOFF CTBL)
         <SET LEN <GETB ,ROOMS-MAPPED 0>>
	 <COND (<OR <ZERO? .LEN>
		    <NOT <SET CHAR 
			      <INTBL? .RM <REST ,ROOMS-MAPPED 1> .LEN 1>>>>
		<COND (<IGRTR? LEN %<- ,ROOMS-MAPPED-LENGTH 1>>
		     ; <SAY-ERROR "CLOSE-MAP <1>">
		       <RTRUE>)>
		<PUTB ,ROOMS-MAPPED .LEN .RM>
		<PUTB ,ROOMS-MAPPED 0 .LEN>)>
	 <COND (<AND <G? .Y -1>
		     <L? .Y ,MHEIGHT>
		     <G? .X -1>
		     <L? .X ,MWIDTH>>
		<COND (<T? ,VT220>
		       <SET CHAR <SMART-CHAR? .RM>>)
		      (T
		       <SET CHAR <DUMB-CHAR? .RM>>)>		
		<PUTB <REST ,MAP <* .Y ,MWIDTH>> .X .CHAR>
	      ; <COND (<T? ,DRAW>
		       <SHOW-DRAWING .Y .X .CHAR>)>)>
	 <MAKE .RM ,MAPPED>
	 <SET DIR -1>
	 <REPEAT ()
	    <COND (<IGRTR? DIR ,I-NW>
		   <UNMAKE .RM ,MAPPED>
		   <RTRUE>)>
	    <SET LEN 0>
	    <SET DEST <>> ; "Very important!"
	    <SET TYPE <>>
	    <SET CTBL ,XCHARS> ; "Assume exit edges."
		 
	  ; "Get attributes of a direction."
	    
	    <SET TBL <GETP .RM <GETB ,PDIR-LIST .DIR>>>
	    <COND (<T? .TBL>
		   <SET TYPE <GET .TBL ,XTYPE>>
		   <SET LEN <BAND .TYPE 255>> 
		   <SET TYPE <MSB .TYPE>>)>
	    <COND (<OR <ZERO? .TBL>
		       <EQUAL? .TYPE ,NO-EXIT ,SORRY-EXIT ; ,FSORRY-EXIT>
		       <NOT <BTST .LEN ,MARKBIT>>>
		   <SET CTBL ,NXCHARS>)
		  (<EQUAL? .TYPE ,FCONNECT>
		   <SET DEST -1>
		   <SET LEN <BAND .LEN 127>>
		   <COND (<ZERO? .LEN>
			  <SET CTBL ,NXCHARS>)>)
		  (T
		   <SET DEST <GET .TBL ,XROOM>>
		   <COND (<OR <ZERO? .DEST>
			      <NOT <IN? .DEST ,ROOMS>>>
			; <SAY-ERROR "CLOSE-MAP <3>">
			  <RFALSE>)
			 (<OR <EQUAL? .TYPE ,SHADOW-EXIT>
			      <AND <EQUAL? .TYPE ,DCONNECT>
				   <NOT <IS? <GET .TBL ,XDATA>
					     ,OPENED>>>>
			  <SET CTBL ,NXCHARS>)>)>
	    <SET LEN <BAND .LEN 127>>
	    <SET YOFF <GET ,YOFFS .DIR>> ; "Establish offsets."
	    <SET XOFF <GET ,XOFFS .DIR>>
	    <SET NY <+ .Y .YOFF>> ; "Do room edge."
	    <SET NX <+ .X .XOFF>>
	    <COND (<OR <L? .NY 0>
		       <G? .NY %<- ,MHEIGHT 1>>
		       <L? .NX 0>
		       <G? .NX %<- ,MWIDTH 1>>>
		   <AGAIN>)>
	    <SET CHAR <GETB .CTBL .DIR>>
	    <COND (<ZERO? ,VT220>
		   <SET CHAR <GETB ,SHITCHARS .DIR>>
		   <COND (<EQUAL? .CTBL ,NXCHARS>
			  <SET CHAR ,SP>)>)
		  (<HERE? .RM>
		   <SET CHAR <+ .CHAR 17>>)>		 
	    <PUTB <REST ,MAP <* .NY ,MWIDTH>> .NX .CHAR>
	  ; <COND (<T? ,DRAW>
		   <SHOW-DRAWING .NY .NX .CHAR>)>
	    <COND (<OR <ZERO? .TBL> ; "If no exit ..."
		       <ZERO? .TYPE>
		       <ZERO? .DEST> ; "Or no connection ..."
		       <L? .Y 0>
		       <G? .Y %<- ,MHEIGHT 1>>
		       <L? .X 0>
		       <G? .X %<- ,MWIDTH 1>>>			    
		   <AGAIN>)>
	    <SET LEN <+ .LEN <BAND .LEN #2 11111110>>>
	    <SET CHAR <GETB ,MCHARS .DIR>> ; "Continue the path."
	    <COND (<EQUAL? .TYPE ,X-EXIT>
		   <COND (<BTST .DIR 1>
			  <SET CHAR ,XCROSS>
			  <COND (<ZERO? ,VT220>
				 <SET CHAR %<ASCII !\X>>)>)
			 (T
			  <SET CHAR ,HVCROSS>
			  <COND (<ZERO? ,VT220>
				 <SET CHAR %<ASCII !\+>>)>)>)
		  (<EQUAL? .CTBL ,NXCHARS> ; "For closed doors."
		   <SET CHAR ,SOLID>
		   <COND (<ZERO? ,VT220>
			  <SET CHAR ,SP>)>)
		  (<ZERO? ,VT220>
		   <SET CHAR <GETB ,SHITCHARS .DIR>>)>
	    <REPEAT ()
	       <SET NY <+ .NY .YOFF>>
	       <SET NX <+ .NX .XOFF>>
	       <COND (<OR <L? .NY 0>
			  <G? .NY %<- ,MHEIGHT 1>>
			  <L? .NX 0>
			  <G? .NX %<- ,MWIDTH 1>>>
		      <RETURN>)>
	       <PUTB <REST ,MAP <* .NY ,MWIDTH>> .NX .CHAR>
	     ; <COND (<T? ,DRAW>
		      <SHOW-DRAWING .NY .NX .CHAR>)>
	       <COND (<DLESS? LEN 1>
		      <RETURN>)>>
	    <COND (<EQUAL? .DEST -1> ; "If it's an FCONNECT ..."
		   <AGAIN>)
		  (<IS? .DEST ,MAPPED>
		   <AGAIN>)
		  (<SET CHAR <INTBL? .DEST <REST ,ROOMS-MAPPED 1>
				     <GETB ,ROOMS-MAPPED 0> 1>>
		   <AGAIN>)
		  (<NOT <IS? .DEST ,VIEWED>>
		   <AGAIN>)>
	    <SET NY <+ .NY <+ .YOFF .YOFF>>>
	    <SET NX <+ .NX <+ .XOFF .XOFF>>>
	    <COND (<OR <L? .NY -1>
		       <G? .NY ,MHEIGHT>
		       <L? .NX -1>
		       <G? .NX ,MWIDTH>>
		   <AGAIN>)>
	    <CLOSE-MAP .DEST .NY .NX>>>

<ROUTINE DUMB-CHAR? (RM "AUX" CHAR)
	 <SET CHAR %<ASCII !\*>>
	 <COND (<HERE? .RM>
		<SET CHAR %<ASCII !\@>>)
	       (<NOT <IS-LIT? .RM>>
		<SET CHAR %<ASCII !\?>>)>
	 <RETURN .CHAR>>

<ROUTINE SMART-CHAR? (RM "AUX" CHAR TBL)
	 <SET CHAR ,SOLID>
	 <COND (<HERE? .RM>
		<SET CHAR ,ISOLID>)>
	 <COND (<NOT <IS-LIT? .RM>>
		<SET CHAR ,QMARK>
		<COND (<HERE? .RM>
		       <SET CHAR ,IQMARK>)>)>
	 <SET TBL <GETP .RM ,P?UP>>
	 <COND (<AND <T? .TBL>
		     <CHECK-EXIT? .RM .TBL>>
		<SET CHAR ,UARROW>
		<COND (<HERE? .RM>
		       <SET CHAR ,IUARROW>)>)>
	 <SET TBL <GETP .RM ,P?DOWN>>
	 <COND (<AND <T? .TBL>
		     <CHECK-EXIT? .RM .TBL>>
		<COND (<EQUAL? .CHAR ,UARROW>
		       <RETURN ,UDARROW>)
		      (<EQUAL? .CHAR ,IUARROW>
		       <RETURN ,IUDARROW>)
		      (<HERE? .RM>
		       <RETURN ,IDARROW>)>
		<RETURN ,DARROW>)>	      
	 <RETURN .CHAR>>	        

<ROUTINE CHECK-EXIT? (RM TBL "AUX" EXIT-WORD ROOM XDIR XTBL TYPE LEN)
	 	 
       ; "Make sure exit is unique."

	 <SET EXIT-WORD <GET .TBL ,XTYPE>>
	 <SET ROOM <GET .TBL ,XROOM>>
	 <SET XDIR ,P?NW>
	 <REPEAT ()
	    <SET XTBL <GETP .RM .XDIR>>
	    <COND (<AND <T? .TBL>
			<EQUAL? <GET .XTBL ,XTYPE> .EXIT-WORD>
			<EQUAL? <GET .XTBL ,XROOM> .ROOM>>
		   <RFALSE>)>
	    <COND (<IGRTR? XDIR ,P?NORTH>
		   <RETURN>)>>
	 
       ; "Exit is unique, so see if it's open."

	 <SET TYPE <MSB .EXIT-WORD>>
	 <SET LEN <BAND .EXIT-WORD 127>>
	 <COND (<EQUAL? .TYPE ,NO-EXIT ,SORRY-EXIT ; ,FSORRY-EXIT>
		<RFALSE>)
	       (<NOT <BTST .EXIT-WORD ,MARKBIT>>
		<RFALSE>)
	       (<EQUAL? .TYPE ,CONNECT ,SCONNECT ,X-EXIT>
		<RTRUE>)
	       (<AND <EQUAL? .TYPE ,DCONNECT>
		     <IS? <GET .TBL ,XDATA> ,OPENED>>
		<RTRUE>)
	       (<AND <EQUAL? .TYPE ,FCONNECT>
		     <T? .LEN>>
		<RTRUE>)
	       (T
		<RFALSE>)>>
			 
<ROUTINE FAR-MAP (RM Y X "AUX" DIR TBL CHAR TYPE LEN DEST
		  	       NY NX YOFF XOFF)
         <SET LEN <GETB ,ROOMS-MAPPED 0>>
	 <COND (<OR <ZERO? .LEN>
		    <NOT <SET CHAR 
			      <INTBL? .RM <REST ,ROOMS-MAPPED 1> .LEN 1>>>>
		<COND (<IGRTR? LEN %<- ,ROOMS-MAPPED-LENGTH 1>>
		     ; <SAY-ERROR "FAR-MAP <1>">
		       <RTRUE>)>
		<PUTB ,ROOMS-MAPPED .LEN .RM>
		<PUTB ,ROOMS-MAPPED 0 .LEN>)>
	 <COND (<AND <G? .Y -1>
		     <L? .Y ,MHEIGHT>
		     <G? .X -1>
		     <L? .X ,MWIDTH>>
		<COND (<ZERO? ,VT220>
		       <SET CHAR <DUMB-CHAR? .RM>>)
		      (T
		       <SET CHAR ,SMBOX>
		       <COND (<HERE? .RM>
			      <SET CHAR ,ISOLID>)>)>		
		<PUTB <REST ,MAP <* .Y ,MWIDTH>> .X .CHAR>)>
	 <MAKE .RM ,MAPPED>
	 <SET DIR -1>
	 <REPEAT ()
	    <COND (<IGRTR? DIR ,I-NW>
		   <UNMAKE .RM ,MAPPED>
		   <RTRUE>)>
	    <SET LEN 0>
	    <SET DEST <>>
	    <SET TYPE <>>
	    <SET TBL <GETP .RM <GETB ,PDIR-LIST .DIR>>>
	    <COND (<ZERO? .TBL>
		   <AGAIN>)>
	    <SET TYPE <GET .TBL ,XTYPE>>
	    <SET LEN <BAND .TYPE 255>> 
	    <SET TYPE <MSB .TYPE>>
	    <COND (<ZERO? .TYPE>
		 ; <SAY-ERROR "FAR-MAP <2>">
		   <RFALSE>)
		  (<EQUAL? .TYPE ,NO-EXIT ,SORRY-EXIT ; ,FSORRY-EXIT>
		   <AGAIN>)
		  (<NOT <BTST .LEN ,MARKBIT>>
		   <AGAIN>)
		  (<EQUAL? .TYPE ,FCONNECT>
		   <SET DEST -1>)
		  (T
		   <SET DEST <GET .TBL ,XROOM>>
		   <COND (<OR <ZERO? .DEST>
			      <NOT <IN? .DEST ,ROOMS>>>
			; <SAY-ERROR "FAR-MAP <3>">
			  <RFALSE>)>)>
	    <COND (<OR <ZERO? .DEST> ; "No connection ..."
		       <L? .Y 0>
		       <G? .Y %<- ,MHEIGHT 1>>
		       <L? .X 0>
		       <G? .X %<- ,MWIDTH 1>>>			    
		   <AGAIN>)>
	    <SET LEN <BAND .LEN 127>>
	    <SET YOFF <GET ,YOFFS .DIR>> ; "Establish offsets."
	    <SET XOFF <GET ,XOFFS .DIR>>
	    <SET CHAR <GETB ,MCHARS .DIR>> ; "Continue the path."
	    <COND (<EQUAL? .TYPE ,X-EXIT>
		   <COND (<BTST .DIR 1>
			  <SET CHAR ,XCROSS>
			  <COND (<ZERO? ,VT220>
				 <SET CHAR %<ASCII !\X>>)>)
			 (T
			  <SET CHAR ,HVCROSS>
			  <COND (<ZERO? ,VT220>
				 <SET CHAR %<ASCII !\+>>)>)>)
		  (<OR <EQUAL? .TYPE ,SHADOW-EXIT>
		       <AND <EQUAL? .TYPE ,DCONNECT>
			    <NOT <IS? <GET .TBL ,XDATA> ,OPENED>>>>
		   <SET CHAR ,SOLID>
		   <COND (<ZERO? ,VT220>
			  <SET CHAR ,SP>)>)
		  (<ZERO? ,VT220>
		   <SET CHAR <GETB ,SHITCHARS .DIR>>)>
	    <SET NY .Y>
	    <SET NX .X>
	    <REPEAT ()
	       <SET NY <+ .NY .YOFF>>
	       <SET NX <+ .NX .XOFF>>
	       <COND (<OR <L? .NY 0>
			  <G? .NY %<- ,MHEIGHT 1>>
			  <L? .NX 0>
			  <G? .NX %<- ,MWIDTH 1>>>
		      <RETURN>)>
	       <PUTB <REST ,MAP <* .NY ,MWIDTH>> .NX .CHAR>
	       <COND (<DLESS? LEN 1>
		      <RETURN>)>>
	    <COND (<EQUAL? .DEST -1> ; "If it's an FCONNECT ..."
		   <AGAIN>)
		  (<IS? .DEST ,MAPPED>
		   <AGAIN>)
		  (<SET CHAR <INTBL? .DEST <REST ,ROOMS-MAPPED 1>
				     <GETB ,ROOMS-MAPPED 0> 1>>
		   <AGAIN>)
		  (<NOT <IS? .DEST ,VIEWED>>
		   <AGAIN>)>
	    <SET NY <+ .NY .YOFF>>
	    <SET NX <+ .NX .XOFF>>
	    <COND (<OR <L? .NY -1>
		       <G? .NY ,MHEIGHT>
		       <L? .NX -1>
		       <G? .NX ,MWIDTH>>
		   <AGAIN>)>
	    <FAR-MAP .DEST .NY .NX>>>
	 
<ROUTINE RELOOK ("OPT" (NOP 0))
	 <COND (<ZERO? .NOP>
		<PRINT ,PERIOD>)>
	 <COND (<T? ,VERBOSITY>
		<CRLF>)>
	 <V-LOOK>
	 <RFALSE>>

<ROUTINE V-LOOK ("OPT" (V T))
	 <COND (<NOT <EQUAL? ,HOST ,MACINTOSH>>
		<HLIGHT ,H-BOLD>)>
	 <SAY-HERE>
	 <CRLF>
	 <HLIGHT ,H-NORMAL>
	 <COND (<T? ,LIT?>
		<MARK-EXITS>)>
	 <COND (<OR <ZERO? ,DMODE>
		    <EQUAL? ,PRIOR ,SHOWING-STATS ,SHOWING-INV>>
		<DESCRIBE-HERE .V>
		<COND (<ZERO? ,DMODE>
		       <UPPER-SLINE>
		       <LOWER-SLINE>
		       <SETG OLD-HERE ,HERE>
		       <RTRUE>)>
		<DISPLAY-PLACE>
		<RTRUE>)>
	 <DISPLAY-PLACE>
	 <COND (<BTST <LOWCORE FLAGS> 1>
		<DIROUT ,D-SCREEN-OFF>
		<DESCRIBE-HERE .V>
		<DIROUT ,D-SCREEN-ON>)>
	 <RTRUE>>

"Mark each visible exit as TOUCHED by setting bit 7 of XTYPE word."

<ROUTINE MARK-EXITS ("AUX" DIR TBL WRD TYPE LEN)
	 <SET DIR ,P?NORTH>
	 <REPEAT ()
	    <SET TBL <GETP ,HERE .DIR>>
	    <COND (<T? .TBL>
		   <SET WRD <GET .TBL ,XTYPE>>
		   <SET TYPE <MSB .WRD>>
		   <SET LEN <BAND .WRD 127>>
		   <COND (<BTST .WRD ,MARKBIT>) ; "Already marked?"
			 (<OR <EQUAL? .TYPE ,CONNECT ,SCONNECT ,X-EXIT>
			      <AND <EQUAL? .TYPE ,FCONNECT>
				   <T? .LEN>>
			      <AND <EQUAL? .TYPE ,DCONNECT>
				   <IS? <GET .TBL ,XDATA> ,OPENED>>>
			  <PUT .TBL ,XTYPE <+ .WRD ,MARKBIT>>)>)>
	    <COND (<DLESS? DIR ,P?DOWN>
		   <RFALSE>)>>>
		 
<ROUTINE UPDATE-ROOMDESC ()
       	 <SETG IN-DBOX ,SHOWING-ROOM>
	 <SETUP-DBOX>
	 <DESCRIBE-HERE>
	 <JUSTIFY-DBOX>
	 <DISPLAY-DBOX>
         <RFALSE>>

<ROUTINE DESCRIBE-HERE ("OPT" (V <>) "AUX" (INDENT 0) X)
	 <COND (<OR <ZERO? ,DMODE>
		    <EQUAL? ,PRIOR ,SHOWING-INV ,SHOWING-STATS>>
		<INC INDENT>)>	
	 <COND (<HERE? DEATH>
		<COND (<T? .INDENT>
		       <TELL ,TAB>)>
		<TELL "You are de">
		<COND (<IS? ,DEATH ,MUNGED>
		       <TELL "feated." CR>
		       <RTRUE>)>
		<TELL "ad." CR>
		<RTRUE>)
	       (<ZERO? ,LIT?>
		<MAKE ,HERE ,TOUCHED>
		<MAKE ,HERE ,VIEWED>
		<COND (<T? .INDENT>
		       <TELL ,TAB>)>
		<COND (<WEARING-MAGIC? ,HELM>
		       <COND (<IN? ,URGRUE ,HERE>
			      <SETG P-IT-OBJECT ,URGRUE>
			      <SETG LAST-MONSTER ,URGRUE>
			      <TELL
"You sense the presence of an obscure shadow in the darkness." CR> 
			      <RTRUE>)
			     (<IN? ,GRUE ,HERE>
			      <MAKE ,GRUE ,SEEN>
			      <SETG P-IT-OBJECT ,GRUE>
			      <SETG LAST-MONSTER ,GRUE>
			      <TELL <PICK-NEXT ,GRUE-SIGHTS> ,PERIOD>
			      <RTRUE>)>)>
		<TELL "It's completely dark">
		<COND (<OR <NOT <IS? ,GRUE ,SEEN>>
			   <PROB 50>>
		       <MAKE ,GRUE ,SEEN>
		       <TELL ". You are likely to be eaten by a grue">)>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <UNMAKE ,GRUE ,SEEN>
	 <SET X <GETP ,HERE ,P?ACTION>>
	 <COND (<T? .X>
		<COND (<OR <T? .V>
			   <ZERO? .INDENT>
			   <EQUAL? ,VERBOSITY 2>
			   <AND <EQUAL? ,VERBOSITY 1>
				<NOT <IS? ,HERE ,TOUCHED>>>>
		       <COND (<T? .INDENT>
			      <TELL ,TAB>)>
		       <APPLY .X ,M-LOOK>)>)>
	 <MAKE ,HERE ,TOUCHED>
	 <MAKE ,HERE ,VIEWED>
	 <COND (<OR <T? .V>
		    <T? ,VERBOSITY>
		    <ZERO? .INDENT>>
		<DESCRIBE-OBJECTS>)>
	 <RTRUE>>

<ROUTINE UPPER-SLINE ()
	 <SETUP-SLINE>
	 <TELL C ,SP>
	 <PRINT-TABLE ,CHARNAME>
	 <NEXTLINE>
	 <TEXT-STATS>
	 <PRINTLINE 1>
	 <RTRUE>>

<ROUTINE TEXT-STATS ("AUX" (STAT 0) X)
	 <REPEAT ()
	    <TELL <GET ,STSTR .STAT>>
	    <PRINTC %<ASCII !\:>>
	    <SET X <GET ,STATS .STAT>>
	    <COND (<L? .X 10>
		   <PRINTC %<ASCII !\0>>)>
	    <TELL N .X C ,SP>
	    <COND (<IGRTR? STAT 6>
		   <RFALSE>)>>>

<ROUTINE NEXTLINE ("AUX" LEN)
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,AUX-TABLE 0>>
	 <COPYT <REST ,AUX-TABLE 2> ,SLINE .LEN>
	 <DIROUT ,D-TABLE-ON ,AUX-TABLE> 
	 <PUT ,AUX-TABLE 0 0>
	 <RFALSE>>

<ROUTINE PRINTLINE (LINE "AUX" LEN X)
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,AUX-TABLE 0>>
	 <SET X <REST ,SLINE <- ,WIDTH .LEN>>>
	 <COPYT <REST ,AUX-TABLE 2> .X .LEN>
	 <TO-TOP-WINDOW>
	 <DO-CURSET .LINE 1>
	 <HLIGHT ,H-INVERSE>
	 <PRINTT ,SLINE ,WIDTH>
	 <TO-BOTTOM-WINDOW>
	 <RFALSE>>

<ROUTINE LOWER-SLINE ("AUX" (ANY 0) PTR DIR TBL TYPE X)
	 <SETUP-SLINE>
	 <PRINTC ,SP>
	 <SAY-HERE>
	 <NEXTLINE>
	 <TELL "Exits:">
	 <COND (<ZERO? ,LIT?>
		<TELL " None visible">)
	       (T
		<COPYT ,GOOD-DIRS 0 32> ; "List N-NW, remember in GOOD-DIRS."
		<SET DIR ,I-NORTH>
		<REPEAT ()
	           <SET TBL <GETP ,HERE <GETB ,PDIR-LIST .DIR>>>
		   <COND (<T? .TBL>
			  <SET TYPE <GET .TBL ,XTYPE>>
			  <SET X <MSB .TYPE>>
			  <COND (<OR <EQUAL? .X ,CONNECT ,SCONNECT ,X-EXIT>
				     <AND <EQUAL? .X ,FCONNECT>
					  <BAND .TYPE 127>>
				     <AND <EQUAL? .X ,DCONNECT>
					  <IS? <GET .TBL ,XDATA> ,OPENED>>>
				 <COPYT .TBL <REST ,GOOD-DIRS <* .DIR 4>> -4>
				 <INC ANY>
				 <TELL C ,SP <GET ,XLIST-NAMES .DIR>>)>)>
		   <COND (<IGRTR? DIR ,I-NW>
			  <RETURN>)>>
		<SET PTR <REST ,GOOD-DIRS 2>> ; "Point to XROOM entries."
		<REPEAT ()
		   <SET TBL <GETP ,HERE <GETB ,PDIR-LIST .DIR>>>
		   <COND (<T? .TBL>
			  <SET TYPE <GET .TBL ,XTYPE>>
			  <SET X <MSB .TYPE>>
			  <COND (<OR <EQUAL? .X ,CONNECT ,SCONNECT ,X-EXIT>
				     <AND <EQUAL? .X ,FCONNECT>
					  <BAND .TYPE 127>>
				     <AND <EQUAL? .X ,DCONNECT>
					  <IS? <GET .TBL ,XDATA> ,OPENED>>>
				 <COND (<OR <NOT <SET X 
					     <INTBL? .TYPE ,GOOD-DIRS 8 132>>>
					    <NOT <SET X 
					     <INTBL? <GET .TBL ,XROOM>
						     .PTR 8 132>>>>
					<INC ANY>
					<TELL C ,SP
					      <GET ,XLIST-NAMES .DIR>>)>)>)>
		   <COND (<IGRTR? DIR 11>
			  <RETURN>)>>
		<COND (<ZERO? .ANY>
		       <TELL " None">)>)>
	 <PRINTC ,SP>
	 <PRINTLINE 2>
	 <RTRUE>>	 
	 
<GLOBAL DBOX-LINES:NUMBER 0> "Number of lines in current DBOX."
<GLOBAL DBOX-TOP:NUMBER 0>   "Top line to be displayed."

<GLOBAL IN-DBOX:NUMBER ,SHOWING-ROOM> "Current contents of DBOX."
<GLOBAL NEW-DBOX:NUMBER ,SHOWING-ROOM> "DBOX to update if visible."

<ROUTINE SETUP-DBOX ()
	 <SETG DBOX-LINES 0>
	 <PUTB ,DBOX 0 ,SP>
	 <COPYT ,DBOX <REST ,DBOX 1> %<- 0 <- ,DBOX-LENGTH 1>>>
	 <PUT ,DBOX 0 0>
	 <DIROUT ,D-TABLE-ON ,DBOX>
	 <RFALSE>>

<ROUTINE JUSTIFY-DBOX ("AUX" (MORE <>)
		    	  LINE BASE LEN PTR CHAR X SOURCE DEST END XLEN)
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,DBOX 0>>
	 <SET LINE ,DBOX-LINES>
	 <SET BASE <REST ,DBOX 2>> ; "Skip over length word."
	 <SET BASE <+ .BASE <* .LINE ,BOXWIDTH>>>
	 <SET END <- ,BOXWIDTH 1>>
	 
	 <REPEAT ()
	    <COND (<G? .BASE <+ <REST ,DBOX 2> .LEN>>
		   <RETURN>)>
	    <COND (<SET PTR <INTBL? ,EOL .BASE .END 1>>
		 ; <PUTB .PTR 0 ,SP>
		   <SET PTR <- .PTR .BASE>>
		   <SET X .PTR>
		   <REPEAT ()
		      <INC X>
		      <SET CHAR <GETB .BASE .X>>
		      <COND (<OR <EQUAL? .CHAR ,EOL>
				 <G? .CHAR 31>>
			     <RETURN>)>>
		   <SET SOURCE <+ .BASE .X>>
		   <SET DEST <+ .BASE ,BOXWIDTH>>
		   <COND (<NOT <EQUAL? .SOURCE .DEST>>
			  <SET XLEN <- .LEN <+ <* .LINE ,BOXWIDTH> .X>>>
			  <COPYT .SOURCE .DEST .XLEN>
			  <REPEAT ()
			     <PUTB .BASE .PTR ,SP>
			     <COND (<IGRTR? PTR .END>
				    <RETURN>)>
			     <INC LEN>>)>)
		  (T
		   <SET PTR ,BOXWIDTH>
		   <REPEAT ()
		      <COND (<DLESS? PTR 0>
			     <RETURN>)>
		      <SET CHAR <GETB .BASE .PTR>>
		      <COND (<AND <EQUAL? .CHAR ,SP>
				  <NOT <EQUAL? .PTR .END>>>
			     <SET SOURCE <+ .BASE .PTR>>
			     <INC SOURCE>
			     <SET DEST <+ .BASE ,BOXWIDTH>>
			     <COND (<EQUAL? .SOURCE .DEST>
				    <RETURN>)>
			     <SET XLEN <* .LINE ,BOXWIDTH>>
			     <SET XLEN <- .LEN <+ .XLEN .PTR>>>
			     <COPYT .SOURCE .DEST .XLEN>
			     <REPEAT ()
				<COND (<IGRTR? PTR .END>
				       <RETURN>)>
				<INC LEN>
				<PUTB .BASE .PTR ,SP>>
			     <RETURN>)>>)>
	    <SET BASE <+ .BASE ,BOXWIDTH>>
	    <COND (<IGRTR? LINE %<- ,MAX-HEIGHT 1>>
		   <RETURN>)>>
	 <SETG DBOX-LINES .LINE>
	 <RTRUE>>

<ROUTINE DISPLAY-DBOX ("AUX" (MORE 0) TLC BASE LINES)
	 <SETG NEW-DBOX 0>
	 <SET TLC <- 12 ,MAX-DHEIGHT>>
	 <SET BASE <REST ,DBOX 2>>
	 <COND (<T? ,DBOX-TOP>
		<SET BASE <+ .BASE <* ,DBOX-TOP ,BOXWIDTH>>>)>	 
	 <SET LINES ,DHEIGHT>
	 <COND (<BTST ,IN-DBOX ,SHOWING-STATS>
		<SET LINES ,MAX-DHEIGHT>)
	       (<G? <- ,DBOX-LINES ,DBOX-TOP> ,DHEIGHT>
		<INC MORE>
		<DEC LINES>)>
	 <TO-TOP-WINDOW>
	 <COLOR ,FORE ,BGND>	 
	 <DO-CURSET .TLC 2>	 
	 <COND (<EQUAL? ,HOST ,APPLE-2C> ; "Nudge it over."
		<PRINTC ,SP>)
	       (<ZERO? ,VT220>
		<COND (<NOT <EQUAL? ,HOST ,IBM>>
		       <HLIGHT ,H-INVERSE>)>)>
	 <PRINTT .BASE ,BOXWIDTH .LINES>
	 <COND (<T? ,DBOX-TOP>
		<SAY-MORE .TLC T>)>
	 <COND (<T? .MORE>
	        <SAY-MORE <+ ,DHEIGHT <- 11 ,MAX-DHEIGHT>>>)>
	 <TO-BOTTOM-WINDOW>
	 <RTRUE>>

<ROUTINE SAY-MORE (Y "OPT" (UP <>) "AUX" X)
	 <COLOR ,GCOLOR ,BGND>
	 <DO-CURSET .Y 2>
	 <COND (<EQUAL? ,HOST ,APPLE-2C>
		<PRINTC ,SP>)>
	 <TELL "[MORE]">
	 <COND (<EQUAL? ,HOST ,MACINTOSH>
		<PRINT-SPACES <- ,BOXWIDTH 30>>
		<TELL "[Press ">
		<COND (<T? .UP>
		       <TELL "\\">)
		      (T
		       <TELL "/">)>
		<TELL " or ">
		<SET X <FONT ,F-NEWFONT>>
		<COND (<T? .UP>
		       <PRINTC 92>)
		      (T
		       <PRINTC 93>)>
		<SET X <FONT ,F-DEFAULT>>)
	       (<OR <T? ,VT220>
		    <EQUAL? ,HOST ,APPLE-2C ,IBM>>
		<PRINT-SPACES <- ,BOXWIDTH 25>>
		<TELL "[Press ">
		<SET X <FONT ,F-NEWFONT>>
		<COND (<T? ,VT220>
		       <SET X 93>
		       <COND (<T? .UP>
			      <DEC X>)>)
		      (<EQUAL? ,HOST ,APPLE-2C>
		       <SET X 74>
		       <COND (<T? .UP>
			      <INC X>)>)
		      (T
		       <SET X 25>
		       <COND (<T? .UP>
			      <DEC X>)>)>
		<PRINTC .X>
		<SET X <FONT ,F-DEFAULT>>)
	       (T
		<PRINT-SPACES <- ,BOXWIDTH 34>>
		<COND (<T? .UP>
		       <TELL "  ">)>
		<TELL "[Press ">
		<COND (<T? .UP>
		       <TELL "UP">)
		      (T
		       <TELL "DOWN">)>
		<TELL " arrow">)>
	 <TELL " to scroll]">
	 <RFALSE>>

<OBJECT X-OBJECT>

<GLOBAL DESCING:OBJECT <>> "Object currently being described."

<ROUTINE DESCRIBE-OBJECTS ("AUX" (TWO? 0) (IT? 0) (ANY? 0) (CR 0)
			   	 (B 0) 1ST? OBJ NXT STR X)
         <COND (<ZERO? ,LIT?>
	        <TOO-DARK>
		<RTRUE>)
	       (<NOT <SET OBJ <FIRST? ,HERE>>>
		<RTRUE>)> ; "Nothing here, so scram."
	
      ; "Handle vehicles."

	<SET OBJ <LOC ,WINNER>>
	<COND (<AND <NOT <EQUAL? .OBJ ,HERE>>
		    <IS? .OBJ ,VEHICLE>
		    <IN? .OBJ ,HERE>>
	       <MOVE .OBJ ,DUMMY-OBJECT>
	       <COND (<SEE-ANYTHING-IN? .OBJ>
		      <TELL ,TAB ,YOU-SEE>
		      <CONTENTS .OBJ>
		      <ON-IN .OBJ>
		      <TELL ,PERIOD>)>)>
	
      ; "Hide invisible objects"

	<COND (<SET OBJ <FIRST? ,HERE>>
	       <REPEAT ()
		  <SET NXT <NEXT? .OBJ>>
		  <COND (<OR <IS? .OBJ ,NODESC>
			     <EQUAL? .OBJ ,WINNER>>
			 <MOVE .OBJ ,DUMMY-OBJECT>)>
		  <SET OBJ .NXT>
		  <COND (<ZERO? .OBJ>
			 <RETURN>)>>)>
	
      ; "Apply FDESCs."
	
      ; <COND (<SET OBJ <FIRST? ,HERE>>
	       <REPEAT ()
		  <SET NXT <NEXT? .OBJ>>
		  <SET STR <GETP .OBJ ,P?FDESC>>
		  <COND (<AND <T? .STR>
			      <NOT <IS? .OBJ ,TOUCHED>>>
			 <TELL ,TAB .STR CR>
			 <THIS-IS-IT .OBJ>
			 <MOVE .OBJ ,DUMMY-OBJECT>)>
		  <SET OBJ .NXT>
		  <COND (<ZERO? .OBJ>
			 <RETURN>)>>)>
	
      ; "Apply DESCFCNs."

	<COND (<SET OBJ <FIRST? ,HERE>>
	       <REPEAT ()
		  <SET NXT <NEXT? .OBJ>>
		  <SET STR <GETP .OBJ ,P?DESCFCN>>
		  <COND (<T? .STR>
			 <SETG DESCING .OBJ>
			 <TELL ,TAB>
			 <APPLY .STR ,M-OBJDESC>
			 <CRLF>
			 <THIS-IS-IT .OBJ>
			 <MOVE .OBJ ,DUMMY-OBJECT>)>
		  <SET OBJ .NXT>
		  <COND (<ZERO? .OBJ>
			 <RETURN>)>>)>
	
      ; "Print whatever's left in a nice sentence"
        	
	<SET 1ST? 1>
	<SET OBJ <FIRST? ,HERE>>
	<REPEAT ()
	   <COND (<ZERO? .OBJ>
		  <COND (<T? .1ST?>
			 <RETURN>) ; "Nothin' left."
		        (<AND <T? .IT?>
			      <ZERO? .TWO?>>
		         <THIS-IS-IT .OBJ>)>
		  <TELL " here.">
		  <INC ANY?>
		  <RETURN>)>
	   <SET NXT <NEXT? .OBJ>>
	   <COND (<T? .1ST?>
		  <DEC 1ST?>
		  <TELL ,TAB>
		  <COND (<T? .NXT>
			 <TELL ,YOU-SEE>)
			(<IS? .OBJ ,PLURAL>
			 <TELL "There are ">)
			(T
			 <TELL "There's ">)>)
		 (T
		  <COND (<T? .NXT>
			 <TELL ", ">)
			(T
			 <TELL ,AND>)>)>
	   <SETG DESCING .OBJ>
	   <TELL A .OBJ>
	   <COND (<AND <EQUAL? .OBJ ,GOBLET>
		       <IN? ,BFLY .OBJ>
		       <IS? ,BFLY ,LIVING>>
		  <INC B>
		  <TELL ,WITH A ,BFLY>
		  <PRINT " resting on the rim">
		  <REMOVE ,BFLY>)>
	   <COND (<AND <SEE-INSIDE? .OBJ>
		       <SEE-ANYTHING-IN? .OBJ>>
		  <MOVE .OBJ ,X-OBJECT>)>
	   <COND (<AND <ZERO? .IT?>
		       <ZERO? .TWO?>>
		  <SET IT? .OBJ>)
		 (T
		  <SET TWO? T>
		  <SET IT? <>>)>
	   <SET OBJ .NXT>>
	<COND (<SET OBJ <FIRST? ,X-OBJECT>>
	       <REPEAT ()
		  <INC ANY?>
		  <TELL C ,SP>
		  <COND (<EQUAL? .OBJ ,GURDY>
			 <TELL "Within">)
			(<EQUAL? .OBJ ,ARCH>
			 <TELL "Under">)
			(<IS? .OBJ ,SURFACE>
			 <TELL "On">)
			(T
			 <TELL "Inside">)>
		  <TELL C ,SP THE .OBJ " you see ">
		  <CONTENTS .OBJ>
		  <PRINTC ,PER>
		  <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			 <RETURN>)>>)>
	<COND (<T? .B>
	       <MOVE ,BFLY ,GOBLET>)>
	<COND (<T? .ANY?>
	       <CRLF>)>
	<SETG DESCING <>>
	<MOVE-ALL ,X-OBJECT ,HERE>
	<MOVE-ALL ,DUMMY-OBJECT ,HERE>
	<RTRUE>>

<ROUTINE SEE-ANYTHING-IN? ("OPT" (OBJ ,PRSO))
	 <COND (<SET OBJ <FIRST? .OBJ>>
		<REPEAT ()
		   <COND (<IS? .OBJ ,NODESC>)
			 (<NOT <EQUAL? .OBJ ,WINNER>>
			  <RTRUE>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RFALSE>)>>)>
	 <RFALSE>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <COND (<ZERO? .OBJ>
		<RFALSE>)
	     ; (<T? ,P-MOBY-FLAG>
		<RTRUE>)
	       (<EQUAL? .OBJ ,WINNER ,PLAYER>
		<RTRUE>)
	       (<IS? .OBJ ,VEHICLE>
		<RTRUE>)
	       (<IS? .OBJ ,SURFACE>
		<RTRUE>)
	       (<IS? .OBJ ,PERSON>
		<RTRUE>)
	       (<IS? .OBJ ,LIVING>
		<RTRUE>)
	       (<NOT <IS? .OBJ ,CONTAINER>>
		<RFALSE>)
	       (<IS? .OBJ ,OPENED>
		<RTRUE>)
	       (<IS? .OBJ ,TRANSPARENT>
		<RTRUE>)
	       (T
	    	<RFALSE>)>>

<ROUTINE ACCESSIBLE? (OBJ "AUX" L)
         <COND (<EQUAL? .OBJ <> ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)>
		<RFALSE>)>
	 <SET L <META-LOC .OBJ>>
	 <COND (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,WINNER ,HERE <LOC ,WINNER>>
		     <VISIBLE? .OBJ>>
	        <RTRUE>)
	       (T 
		<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
	    <COND (<ZERO? .OBJ>
		   <RFALSE>)
		  (<IN? .OBJ ,GLOBAL-OBJECTS>
		   <RETURN ,GLOBAL-OBJECTS>)
		  (<IN? .OBJ ,ROOMS>
		   <RETURN .OBJ>)>
	    <SET OBJ <LOC .OBJ>>>>

<ROUTINE VISIBLE? (OBJ "AUX" L)
         <COND (<EQUAL? .OBJ <> ,NOT-HERE-OBJECT> 
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? .OBJ <LOC ,WINNER>>
		<RTRUE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<EQUAL? .L <> ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER <LOC ,WINNER> ,HERE>
	        <RTRUE>)
               (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? ,HERE .OBJ>>
		<RTRUE>)
               (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
	        <RTRUE>)
               (T
	        <RFALSE>)>>

<ROUTINE DPRINT (O "AUX" X)
	 <SET X <GETP .O ,P?SDESC>>
	 <COND (<T? .X>
		<APPLY .X .O>
		<RTRUE>)
	       (<IS? .O ,NOARTICLE>
		<SET X <GETP .O ,P?NAME-TABLE>>
		<COND (<T? .X>
		       <PRINT-TABLE .X>
		       <RTRUE>)>)>
	 <PRINTD .O>
	 <RTRUE>>
	 
<ROUTINE THE-PRINT ("OPT" (O ,PRSO) "AUX" X)
         <COND (<NOT <IS? .O ,NOARTICLE>>
		<TELL ,LTHE>)>
	 <DPRINT .O>
	 <RTRUE>>

<ROUTINE CTHE-PRINT ("OPT" (O ,PRSO) "AUX" X)
       	 <COND (<NOT <IS? .O ,PROPER>>
		<TELL ,XTHE>)>
	 <DPRINT .O>
	 <RTRUE>>

; <ROUTINE CRCTHE-PRINT ("OPT" (O ,PRSO) "AUX" X)
	 <CRLF>
	 <COND (<NOT <IS? .O ,PROPER>>
		<TELL ,XTHE>)>
	 <DPRINT .O>
	 <RTRUE>>

<ROUTINE THEI-PRINT ("AUX" X)
	 <COND (<NOT <IS? ,PRSI ,NOARTICLE>>
		<TELL ,LTHE>)>
	 <DPRINT ,PRSI>
	 <RTRUE>>

<ROUTINE CTHEI-PRINT ("AUX" X)
	 <COND (<NOT <IS? ,PRSI ,PROPER>>
		<TELL ,XTHE>)>
	 <DPRINT ,PRSI>
	 <RTRUE>>

<ROUTINE PRINTA ("OPT" (O ,PRSO) "AUX" X)
	 <COND (<IS? .O ,NOARTICLE>)
	       (<OR <IS? .O ,PROPER>
		    <AND <IS? .O ,PLURAL>
			 <IS? .O ,PERSON>>>
		<TELL ,LTHE>)
	       (<IS? .O ,VOWEL>
		<PRINTI "an ">)
	       (T
		<PRINTI "a ">)>
	 <DPRINT .O>
	 <RTRUE>>

<ROUTINE PRINTCA ("OPT" (O ,PRSO) "AUX" X)
	 <COND (<IS? .O ,NOARTICLE>)
	       (<OR <IS? .O ,PROPER>
		    <AND <IS? .O ,PLURAL>
			 <IS? .O ,PERSON>>>
		<TELL ,XTHE>)
	       (<IS? .O ,VOWEL>
		<PRINTI "An ">)
	       (T
		<TELL ,XA>)>
	 <DPRINT .O>
	 <RTRUE>>

<ROUTINE DESCRIBE-LANTERN (OBJ)
	 <COND (<IS? .OBJ ,MUNGED>
		<TELL B ,W?BROKEN C ,SP>)
	       (<IS? .OBJ ,LIGHTED>
		<TELL B ,W?LIGHTED C ,SP>)
	       (<NOT <IS? .OBJ ,MAPPED>>
		<TELL B ,W?RUSTY C ,SP>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-SHILL (OBJ)
	 <COND (<IS? .OBJ ,NAMED>
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<COND (<ZERO? ,INV-PRINTING?>
		       <RTRUE>)>
		<TELL ,STHE>)>
	 <COND (<IS? .OBJ ,TOUCHED>
		<PRINTD .OBJ>
		<RTRUE>)>
	 <TELL "piece of " B ,W?DRIFTWOOD>
	 <RTRUE>>

<ROUTINE DESCRIBE-SWORD (OBJ)
	 <COND (<IS? .OBJ ,NAMED>
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<COND (<ZERO? ,INV-PRINTING?>
		       <RTRUE>)>
		<TELL ,STHE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-AXE (OBJ)
	 <COND (<IS? .OBJ ,NAMED>
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<COND (<ZERO? ,INV-PRINTING?>
		       <RTRUE>)>
		<TELL ,STHE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-DAGGER (OBJ)
	 <COND (<IS? .OBJ ,NAMED>
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<COND (<ZERO? ,INV-PRINTING?>
		       <RTRUE>)>
		<TELL ,STHE>)>
	 <COND (<IS? .OBJ ,MUNGED>
		<TELL B ,W?RUSTY C ,SP>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-AMULET (OBJ)
	 <COND (<IS? ,AMULET ,IDENTIFIED>
		<TELL "Amulet of ">
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-PHASE (OBJ)
	 <COND (<IS? .OBJ ,NAMED>
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<COND (<ZERO? ,INV-PRINTING?>
		       <RTRUE>)>
		<TELL ,STHE>)>
	 <COND (<HERE? APLANE>
		<PRINTD .OBJ>
		<RTRUE>)>
	 <TELL 'SHAPE>
	 <RTRUE>>

<ROUTINE DESCRIBE-JUNGLE-WAND (CONTEXT)
	 <TELL CA ,DESCING " lies in a clump of grass.">
	 <RTRUE>>

<ROUTINE DESCRIBE-MOOR-WAND (CONTEXT)
	 <TELL "The end of " A ,DESCING " sticks out of the mud.">
	 <RTRUE>>

<ROUTINE DESCRIBE-FOREST-WAND (CONTEXT)
	 <TELL "Somebody has left " A ,DESCING " lying across the path.">
	 <RTRUE>>

<ROUTINE DESCRIBE-CELLAR-WAND (CONTEXT)
	 <TELL CA ,DESCING " lies in a shadowy corner.">
	 <RTRUE>>

<ROUTINE DESCRIBE-TOWER-WAND (CONTEXT)
	 <TELL CA ,DESCING>
	 <PRINT " lies half-hidden in ">
	 <TELL "a corner.">
	 <RTRUE>>

<ROUTINE DESCRIBE-HALL-WAND (CONTEXT)
	 <TELL "The tip of " A ,DESCING>
	 <PRINT " is visible in the ">
	 <TELL "rubble.">
	 <RTRUE>>

<ROUTINE DESCRIBE-TELE-WAND (OBJ)
	 <PRINTD .OBJ>
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL " of Sayonara">)>
	 <RTRUE>>

<ROUTINE DESCRIBE-SLEEP-WAND (OBJ)
	 <PRINTD .OBJ>
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL " of Anesthesia">)>
	 <RTRUE>>

<ROUTINE DESCRIBE-IO-WAND (OBJ)
	 <PRINTD .OBJ>
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL " of Eversion">)>
	 <RTRUE>>

<ROUTINE DESCRIBE-LEV-WAND (OBJ)
	 <PRINTD .OBJ>
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL " of Levitation">)>
	 <RTRUE>>

<ROUTINE DESCRIBE-BLAST-WAND (OBJ)
	 <PRINTD .OBJ>
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL " of Annihilation">)>
	 <RTRUE>>

<ROUTINE DESCRIBE-DISPEL-WAND (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "Dispel ">)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-HELM (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "Pheehelm">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-HORSE (OBJ)
	 <COND (<IS? ,HORSE ,LIVING>
		<TELL B ,W?GRAY>)
	       (T
		<TELL B ,W?DEAD>)>
	 <TELL C ,SP 'HORSE>
	 <RTRUE>>

<ROUTINE DESCRIBE-TRENCH (OBJ)
	 <COND (<HERE? ARCH12>
		<TELL "minxhole">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-KEYS (OBJ "AUX" WORD)
	 <SET WORD <GET <GETPT .OBJ ,P?ADJECTIVE> 0>>
	 <COND (<NOT <SEE-COLOR?>>
		<SET WORD ,W?GRAY>)>
	 <TELL B .WORD C ,SP>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-ARROW (OBJ)
	 <COND (<IS? .OBJ ,NAMED>
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<COND (<ZERO? ,INV-PRINTING?>
		       <RTRUE>)>
		<TELL ,STHE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-CLOAK (OBJ)
	 <PRINTD .OBJ>
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL " of Stealth">)>
	 <RTRUE>>

<ROUTINE DESCRIBE-PARASOL (OBJ)
	 <COND (<IS? .OBJ ,MUNGED>
		<TELL B ,W?BROKEN>)
	       (<IS? .OBJ ,OPENED>
		<TELL B ,W?OPEN>)
	       (T
		<TELL B ,W?CLOSED>)>
	 <PRINTC ,SP>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-WHISTLE (OBJ)
	 <PRINTD .OBJ>
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL " of Summoning">)>
	 <RTRUE>>

<ROUTINE DESCRIBE-BFLY (OBJ)
	 <COND (<IS? .OBJ ,NAMED>
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<COND (<ZERO? ,INV-PRINTING?>
		       <RTRUE>)>
		<TELL ,STHE>)>
	 <COND (<NOT <IS? .OBJ ,LIVING>>
		<TELL "dead ">)>
	 <COND (<IS? .OBJ ,MUNGED>
		<PRINT "caterpillar">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-GOBLET (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "Chalice of ">
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-RING (OBJ)
	 <PRINTD .OBJ>
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL " of Shielding">)>
	 <RTRUE>>

<ROUTINE DESCRIBE-SPADE (OBJ)
	 <COND (<IS? .OBJ ,NAMED>
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<COND (<ZERO? ,INV-PRINTING?>
		       <RTRUE>)>
		<TELL ,STHE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-SCABBARD (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "Sheath of Grueslayer">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-DIAMOND (OBJ)
	 <TELL B ,W?SNOWFLAKE>
	 <RTRUE>>

<ROUTINE DESCRIBE-DO-PARTAY (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "scroll of Mischief">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-BLESS-WEAPON (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "scroll of Honing">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-BLESS-ARMOR (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "scroll of Protection">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-DO-FILFRE (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "scroll of Fireworks">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-DO-GOTO (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "scroll of Recall">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-TOWER-SCROLL (CONTEXT)
	 <TELL CA ,DESCING>
	 <PRINT " lies half-hidden in ">
	 <TELL "shadow.">
	 <RTRUE>>

<ROUTINE DESCRIBE-FOREST-SCROLL (CONTEXT)
	 <TELL CA ,DESCING>
	 <PRINT " lies forgotten in ">
	 <TELL "the underbrush.">
	 <RTRUE>>

<ROUTINE DESCRIBE-PLAIN-SCROLL (CONTEXT)
	 <TELL CA ,DESCING " is blowing against a clump of grass.">
	 <RTRUE>>

<ROUTINE DESCRIBE-MOOR-SCROLL (CONTEXT)
	 <TELL CA ,DESCING " lies trodden in the mud.">
	 <RTRUE>>

<ROUTINE DESCRIBE-JUNGLE-SCROLL (CONTEXT)
	 <TELL "The undergrowth nearly conceals " A ,DESCING C ,PER>
	 <RTRUE>>

<ROUTINE DESCRIBE-RENEWAL (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "scroll of Renewal">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE RENEWAL-DESC (CONTEXT)
	 <TELL CA ,RENEWAL " lies trampled in the dust.">
	 <RTRUE>>

<ROUTINE DESCRIBE-PALIMP (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "scroll of Gating">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-STONE (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "Scrystone of ">
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-WALL (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<COND (<EQUAL? .OBJ ,NWALL>
		       <TELL "Nor">)
		      (T
		       <TELL "Sou">)>
		<TELL "th Wall of ">
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-IQ-POTION (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "potion of Enlightenment">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-HEALING-POTION (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "potion of Healing">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-DEATH-POTION (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "potion of Death">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-MIGHT-POTION (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "potion of Might">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-FORGET-POTION (OBJ)
	 <COND (<IS? .OBJ ,IDENTIFIED>
		<TELL "potion of Forgetfulness">
		<RTRUE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE DESCRIBE-MOOR-POTION (CONTEXT)
	 <TELL "Some luckless fool has left " A ,DESCING
	       " in the mud.">
	 <RTRUE>>

<ROUTINE DESCRIBE-RUINS-POTION (CONTEXT)
	 <TELL "Someone else must have been here recently. There's " 
	       A ,DESCING>
	 <PRINT " lying in the dust.">
	 <RTRUE>>

<ROUTINE KERBLAM ()
	 <ITALICIZE "Kerblam">
	 <TELL "! ">
	 <RFALSE>>

<ROUTINE WHOOSH ()
	 <ITALICIZE "Whoosh">
	 <TELL "! ">
	 <RFALSE>>

"Don't call this when you're in Screen 1!"

<ROUTINE ITALICIZE (STR "AUX" (PTR 2) LEN CHAR)
         <PUT ,AUX-TABLE 0 0>
	 <DIROUT ,D-TABLE-ON ,AUX-TABLE>
	 <TELL .STR>
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,AUX-TABLE 0>>
         <INC LEN>
	 <COND (<L? .LEN 2>
		<RTRUE>)
	       (<BTST <LOWCORE (ZVERSION 1)> 8> ; "Italics?"
		<HLIGHT ,H-ITALIC>
		<REPEAT ()
		   <SET CHAR <GETB ,AUX-TABLE .PTR>>
		   <COND (<AND <NOT <EQUAL? ,HOST ,ATARI-ST>>
			       <OR <EQUAL? .CHAR ,SP ,PER 44>
				   <EQUAL? .CHAR ,EXCLAM 63 59>
				   <EQUAL? .CHAR 58>>>
			  <HLIGHT ,H-NORMAL>
			  <PRINTC .CHAR>
			  <HLIGHT ,H-ITALIC>)
			 (T
			  <PRINTC .CHAR>)>
		   <COND (<EQUAL? .PTR .LEN>
			  <RETURN>)>
		   <INC PTR>>
		<HLIGHT ,H-NORMAL>
		<RTRUE>)>
	 <REPEAT ()				   ; "Caps if no italics."
	    <SET CHAR <GETB ,AUX-TABLE .PTR>>
	    <COND (<AND <G? .CHAR 96>
			<L? .CHAR 123>>
		   <SET CHAR <- .CHAR ,SP>>)>
	    <PRINTC .CHAR>
	    <COND (<EQUAL? .PTR .LEN>
		   <RETURN>)>
	    <INC PTR>>
	 <RTRUE>>
	       
<ROUTINE NOUN-USED? (WORD1 "OPT" (WORD2 <>) (WORD3 <>) 
		           "AUX" O I OOF IOF)
	 <COND (<ZERO? .WORD1>
		<RFALSE>)
	       (<SET O <INTBL? ,PRSA ,R-VERBS ,NR-VERBS>>
		<SET O <GET ,P-NAMW 1>>
		<SET OOF <GET ,P-OFW 1>>
		<SET I <GET ,P-NAMW 0>>		
		<SET IOF <GET ,P-OFW 0>>)
	       (T
		<SET O <GET ,P-NAMW 0>>
		<SET OOF <GET ,P-OFW 0>>
		<SET I <GET ,P-NAMW 1>>	
		<SET IOF <GET ,P-OFW 1>>)>	 
	 <COND (<OR <AND <THIS-PRSO?>
		         <EQUAL? .WORD1 .O .OOF>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .WORD1 .I .IOF>>>
		<RETURN .WORD1>)
	       (<ZERO? .WORD2>
		<RFALSE>)
	       (<OR <AND <THIS-PRSO?>
			 <EQUAL? .WORD2 .O .OOF>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .WORD2 .I .IOF>>>
		<RETURN .WORD2>)
	       (<ZERO? .WORD3>
		<RFALSE>)
	       (<OR <AND <THIS-PRSO?>
			 <EQUAL? .WORD3 .O .OOF>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .WORD3 .I .IOF>>>
		<RETURN .WORD3>)
	       (T
		<RFALSE>)>>

<ROUTINE ADJ-USED? (WORD1 "OPT" (WORD2 <>) (WORD3 <>) "AUX" O I)
	 <COND (<ZERO? .WORD1>
		<RFALSE>)
	       (<SET O <INTBL? ,PRSA ,R-VERBS ,NR-VERBS>>
		<SET O <GET ,P-ADJW 1>>
	 	<SET I <GET ,P-ADJW 0>>)
	       (T
		<SET O <GET ,P-ADJW 0>>
		<SET I <GET ,P-ADJW 1>>)>
	 <COND (<OR <AND <THIS-PRSO?>
			 <EQUAL? .WORD1 .O>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .WORD1 .I>>>
		<RETURN .WORD1>)
	       (<ZERO? .WORD2>
		<RFALSE>)
	       (<OR <AND <THIS-PRSO?>
			 <EQUAL? .WORD2 .O>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .WORD2 .I>>>
		<RETURN .WORD2>)
	       (<ZERO? .WORD3>
		<RFALSE>)
	       (<OR <AND <THIS-PRSO?>
			 <EQUAL? .WORD3 .O>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .WORD3 .I>>>
		<RETURN .WORD3>)
	       (T
		<RFALSE>)>>
		   
<ROUTINE REPLACE-ADJ? (OBJ OLD NEW "AUX" TBL LEN)
	 <SET TBL <GETPT .OBJ ,P?ADJECTIVE>>
	 <COND (<ZERO? .TBL>
		<RFALSE>)>
	 <SET LEN </ <PTSIZE .TBL> 2>>
	 <REPEAT ()
	    <COND (<DLESS? LEN 0>
		   <RFALSE>)
		  (<EQUAL? <GET .TBL .LEN> .OLD>
		   <PUT .TBL .LEN .NEW>
		   <RTRUE>)>>>

<ROUTINE REPLACE-SYN? (OBJ OLD NEW "AUX" TBL LEN)
	 <SET TBL <GETPT .OBJ ,P?SYNONYM>>
	 <COND (<ZERO? .TBL>
		<RFALSE>)>
	 <SET LEN </ <PTSIZE .TBL> 2>>
	 <REPEAT ()
	    <COND (<DLESS? LEN 0>
		   <RFALSE>)
		  (<EQUAL? <GET .TBL .LEN> .OLD>
		   <PUT .TBL .LEN .NEW>
		   <RTRUE>)>>>

<ROUTINE REPLACE-GLOBAL? (OBJ OLD NEW "AUX" TBL LEN)
	 <SET TBL <GETPT .OBJ ,P?GLOBAL>>
	 <COND (<ZERO? .TBL>
		<RFALSE>)>
	 <SET LEN </ <PTSIZE .TBL> 2>>
	 <REPEAT ()
	    <COND (<DLESS? LEN 0>
		   <RFALSE>)
		  (<EQUAL? <GET .TBL .LEN> .OLD>
		   <PUT .TBL .LEN .NEW>
		   <RTRUE>)>>>

<GLOBAL BARY:NUMBER 0> "Y-pos of status bar display."
<GLOBAL BARX:NUMBER 0> "X-pos of status bar display."

<ROUTINE DISPLAY-STATS ()
	 <SETG BMODE <>>
	 <SETG DHEIGHT ,MAX-DHEIGHT>
	 <SETG DBOX-TOP 0>
	 <SETG DBOX-LINES 0>
	 <SETG IN-DBOX ,SHOWING-STATS>
	 <PUTB ,DBOX 0 ,SP>
	 <COPYT ,DBOX <REST ,DBOX 1> %<- 0 <- ,DBOX-LENGTH 1>>>
	 <DISPLAY-DBOX>
	 <STATBARS <- 13 ,MAX-DHEIGHT>>
	 <RFALSE>>

<ROUTINE STATBARS (Y "OPT" X N "AUX" (STAT 0))
	 <COND (<ZERO? .X>
		<SET X <+ </ <- ,DWIDTH ,BARWIDTH> 2> 1>>)>
	 <COND (<NOT <ASSIGNED? N>>
		<SET N ,ARMOR-CLASS>)>
	 <SETG BARY .Y>
	 <SETG BARX .X>	 
	 <TO-TOP-WINDOW>
	 <COLOR ,FORE ,BGND>
	 <DO-CURSET ,BARY ,BARX>
	 <PRINTT ,BAR-LABELS ,LABEL-WIDTH <+ .N 1>>
	 <REPEAT ()
	    <APPLY ,STAT-ROUTINE .STAT <GET ,STATS .STAT>>
	    <COND (<IGRTR? STAT .N>
		   <RETURN>)>>
	 <TO-BOTTOM-WINDOW>
	 <RFALSE>>

<ROUTINE SHOW-STAT (STAT)
	 <TO-TOP-WINDOW>
	 <APPLY ,STAT-ROUTINE .STAT <GET ,STATS .STAT>>
	 <TO-BOTTOM-WINDOW>
	 <RFALSE>>

<ROUTINE BAR-NUMBER (STAT VAL "AUX" Y)
	 <HLIGHT ,H-NORMAL>
	 <SET Y <+ .STAT ,BARY>>
	 <CURSET .Y <+ ,BARX %<+ ,LABEL-WIDTH 1>>>
	 <COND (<L? .VAL 10>
		<TELL "  ">)
	       (<L? .VAL 100>
		<TELL C ,SP>)>
	 <TELL N .VAL>
	 <RFALSE>>

<ROUTINE RAWBAR (STAT VAL "AUX" PTR X Y Z)
	 <PUTB ,SLINE 0 ,BASE-CHAR> ; "Clear bar."
	 <SET X <- 0 ,SWIDTH>>
	 <COPYT ,SLINE <REST ,SLINE 1> .X>
	 	 
	 <SET X <+ ,BASE-CHAR ,BAR-RES>> ; "Solid char."
	 <SET Y </ .VAL ,BAR-RES>> ; "# solids to print."
	 <SET Z <- ,SWIDTH 1>> ; "Maximum."
	 <SET PTR 1>
	 <REPEAT ()
	    <COND (<G? .PTR .Y>
		   <RETURN>)>
	    <PUTB ,SLINE .PTR .X>
	    <COND (<IGRTR? PTR .Z>
		   <RETURN>)>>
	 <PUTB ,SLINE .PTR <+ ,BASE-CHAR <MOD .VAL ,BAR-RES>>>
	 
	 <PUTB ,SLINE 0 ,LCAP> ; "Install caps at both ends."
	 <PUTB ,SLINE <+ ,SWIDTH 1> ,RCAP>

	 <SET Y <+ .STAT ,BARY>>
	 <SET X <+ ,BARX ,LABEL-WIDTH>>

	 <DO-CURSET .Y .X>
	 <SET Z <FONT ,F-NEWFONT>>
	 <COLOR ,GCOLOR ,BGND>
	 <SET Z <+ ,SWIDTH 2>>
	 <PRINTT ,SLINE .Z>
	 
	 <DO-CURSET .Y <+ .Z .X>>
	 <SET Z <FONT ,F-DEFAULT>>
	 <COLOR ,FORE ,BGND>
	 <COND (<L? .VAL 10>
		<PRINTC ,SP>)>
	 <TELL N .VAL "%">
	 <RFALSE>>	 

<ROUTINE APPLE-STATS ("AUX" (CNT 0) X)
	 <SETUP-SLINE>
	 <REPEAT ()
	    <TELL <GET ,STSTR .CNT> ":">
	    <SET X <GET ,STATS .CNT>>
	    <COND (<L? .X 10>
		   <TELL "0">)>
	    <TELL N .X>
	    <COND (<IGRTR? CNT 6>
		   <RETURN>)>
	    <PRINTC ,SP>		 
	    <COND (<G? ,DWIDTH 46>
		   <PRINTC ,SP>)>>
	 <CENTER-SLINE>
	 <SHOW-SLINE 2>
	 <RTRUE>>

<ROUTINE UPDATE-STAT (DELTA "OPT" (STAT ,ENDURANCE) (UPDATE-MAX <>) 
		      	    "AUX" (NEWRANK 0) 
			    	  NSTAT OSTAT MAX OMAX NLVL OLVL X)
	 <COND (<ZERO? .DELTA>
		<RFALSE>)>
	 <SET OSTAT <GET ,STATS .STAT>>
	 <SET NSTAT <+ .OSTAT .DELTA>>	 
	 <COND (<L? .NSTAT 0>
		<SET NSTAT 0>)
	       (<EQUAL? .STAT ,EXPERIENCE>)
	       (<G? .NSTAT ,STATMAX>
		<SET NSTAT ,STATMAX>)>
	 <COND (<EQUAL? .OSTAT .NSTAT>
		<RFALSE>)>
	 <PUT ,STATS .STAT .NSTAT>
	 
	 <SET OMAX <GET ,MAXSTATS .STAT>>
	 <COND (<ZERO? .UPDATE-MAX>)
	       (<EQUAL? .STAT ,EXPERIENCE>)
	       (<NOT <EQUAL? .NSTAT .OMAX>>
		<SET MAX <+ .DELTA .OMAX>>
		<COND (<L? .MAX 0>
		       <SET MAX 0>)
		      (<G? .MAX ,STATMAX>
		       <SET MAX ,STATMAX>)>
		<PUT ,MAXSTATS .STAT .MAX>)>	 
	 
	 <COND (<NOT <EQUAL? .NSTAT .OMAX>>
		<SETG NO-REFRESH .STAT>)>
	 
	 <COND (<EQUAL? .STAT ,EXPERIENCE>
		<SET NLVL <GET-LEVEL? .NSTAT>>
		<SET OLVL <GET-LEVEL? .OSTAT>>
		<COND (<OR <G? .NLVL .OLVL>
			   <AND <ZERO? .NLVL>
				<EQUAL? .OLVL ,MAX-LEVEL>>>
		       <UPGRADE-RANK>
		       <INC NEWRANK>)>)>
	 
	 <COND (<T? ,SAY-STAT>
		<COND (<NOT <EQUAL? ,HOST ,MACINTOSH>>
		       <HLIGHT ,H-BOLD>)>
		<TELL ,TAB "[Your " <GET ,STAT-NAMES .STAT>>
		<SET X ,S-BEEP>
		<COND (<EQUAL? .NSTAT .OMAX>
		       <TELL " is back to normal">)
		      (T
		       <TELL " just went ">
		       <COND (<L? .DELTA 0>
			      <SET X ,S-BOOP>
			      <TELL B ,W?DOWN>)
			     (T
			      <TELL B ,W?UP>)>)>
		
		<COND (<T? .NEWRANK>
		       <TELL ". You have achieved the rank of ">
		       <ANNOUNCE-RANK>)>
		
		<TELL ".]" CR>
		<HLIGHT ,H-NORMAL>
		<SOUND .X>)>
	 	 
	 <COND (<ZERO? ,DMODE>
		<UPPER-SLINE>)
	       (<ZERO? ,VT220>
		<APPLE-STATS>)
	       (<EQUAL? ,IN-DBOX ,SHOWING-STATS>
		<COND (<T? .NEWRANK>
		       <SHOW-RANK>
		       <TO-TOP-WINDOW>
		       <SET STAT ,ENDURANCE>
		       <REPEAT ()
			  <APPLY ,STAT-ROUTINE .STAT <GET ,STATS .STAT>>
			  <COND (<IGRTR? STAT ,ARMOR-CLASS>
				 <RETURN>)>>
		       <TO-BOTTOM-WINDOW>
		       <RTRUE>)
		      (<EQUAL? .STAT ,EXPERIENCE>
		       <RTRUE>)> 
		<SHOW-STAT .STAT>)
	       (<ZERO? ,BMODE>)
	       (<OR <T? .NEWRANK>
		    <EQUAL? .STAT ,ENDURANCE>>
		<SHOW-STAT ,ENDURANCE>)>
	 
	 <COND (<AND <ZERO? .NSTAT>
		     <EQUAL? .STAT ,ENDURANCE ,STRENGTH>>
		<TELL ,TAB "Your last ounce of " <GET ,STAT-NAMES .STAT>
		      " gives out">
		<JIGS-UP>)>
	 <RTRUE>>
	 
<ROUTINE GET-LEVEL? (VAL "AUX" (LVL 0))
	 <REPEAT ()
	    <COND (<L? .VAL <GET ,THRESHOLDS .LVL>>
		   <RETURN .LVL>)
		  (<IGRTR? LVL ,MAX-LEVEL>
		   <RFALSE>)>>>

<ROUTINE UPGRADE-RANK ("AUX" TBL O N)
	 <SET TBL ,STATS>
	 <REPEAT ()
	    <SET O <GET .TBL ,ENDURANCE>>
	    <SET N </ <- ,STATMAX .O> 10>>
	    <COND (<L? .N 1>
		   <SET N 1>)>
	    <SET N <+ .O .N>>
	    <COND (<G? .N ,STATMAX>
		   <SET N ,STATMAX>)
		  (<L? .N 1>
		   <SET N 1>)>
	    <PUT .TBL ,ENDURANCE .N>
	    <COND (<EQUAL? .TBL ,MAXSTATS>
		   <RFALSE>)>
	    <SET TBL ,MAXSTATS>>>
	 
<ROUTINE PRINT-TABLE (TBL "AUX" (PTR 1) LEN)
	 <SET LEN <GETB .TBL 0>>
	 <COND (<ZERO? .LEN>
		<RFALSE>)>
	 <REPEAT ()
		 <PRINTC <GETB .TBL .PTR>>
		 <COND (<IGRTR? PTR .LEN>
			<RFALSE>)>>>

<ROUTINE WATER-VANISH ()
	 <VANISH>
	 <TELL CTHEO>
	 <PRINT " disappears into the ">
	 <TELL "water." CR>
	 <RTRUE>>

<ROUTINE VANISH ("OPT" (OBJ ,PRSO))
	 <WINDOW ,SHOWING-ALL>
	 <REMOVE .OBJ>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <RFALSE>>

<ROUTINE LIGHT-SOURCE? ("AUX" OBJ LEN)
	 <COND (<IS? ,HERE ,INDOORS>)
	       (<NOT <PLAIN-ROOM?>>
		<RETURN ,SUN>)>
	 <SET LEN <GET ,LIGHT-SOURCES 0>>
	 <REPEAT ()
		 <SET OBJ <GET ,LIGHT-SOURCES .LEN>>
		 <COND (<AND <IS? .OBJ ,LIGHTED>
			     <VISIBLE? .OBJ>>
			<RETURN .OBJ>)>
		 <COND (<DLESS? LEN 1>
			<RETURN>)>>
	 <SET OBJ <FIND-IN? ,WINNER ,LIGHTED>>
	 <COND (<ZERO? .OBJ>
		<SET OBJ <FIND-IN? <LOC ,WINNER> ,LIGHTED>>)>
	 <RETURN .OBJ>>

<GLOBAL STORAGE:NUMBER 0>

<ROUTINE NEW-EXIT? (OBJ DIR TYPE "OPT" ROOM DATA "AUX" PTR X TBL BYTES)
	 <SET TBL <GETP .OBJ .DIR>>
	 <COND (<ZERO? .TBL>
		<SET BYTES 4>
		<COND (<ASSIGNED? DATA>
		       <SET BYTES 6>)>
		<SET PTR ,STORAGE>
		<SET X <+ ,STORAGE .BYTES>>
	        <COND (<G? .X ,STORAGE-SPACE>
		       <SAY-ERROR "NEW-EXIT?">
		       <RFALSE>)>
		<SETG STORAGE .X>
		<SET TBL <REST ,FREE-STORAGE .PTR>>
		<PUTP .OBJ .DIR .TBL>)>
	 <PUT .TBL ,XTYPE .TYPE>
	 <COND (<ASSIGNED? ROOM>
		<PUT .TBL ,XROOM .ROOM>)>
	 <COND (<ASSIGNED? DATA>
		<PUT .TBL ,XDATA .DATA>)>
	 <RTRUE>>
		
<ROUTINE JUMPING-OFF? ()
	 <COND (<VERB? LEAP>
		<RTRUE>)
	       (<AND <VERB? DIVE>
		     <EQUAL? ,P-PRSA-WORD ,V?DIVE>>
		<RTRUE>)
	       (<AND <VERB? CLIMB-DOWN>
		     <OR <EQUAL? ,P-PRSA-WORD ,W?JUMP ,W?LEAP ,W?HURDLE>
			 <EQUAL? ,P-PRSA-WORD ,W?VAULT ,W?BOUND>>>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE DONT-HAVE-WAND? (OBJ W)
	 <COND (<NOT <IN? .W ,PLAYER>>
		<MUST-HOLD .W>
		<TELL " to direct its power." CR>
		<RTRUE>)
	       (<EQUAL? .OBJ .W>
		<TELL ,CANT B ,P-PRSA-WORD C ,SP THE .W " at itself." CR>
		<RTRUE>)
	       (<NO-MAGIC-HERE? .W>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MUST-HOLD (OBJ)
	 <TELL "You must be holding " THE .OBJ>
	 <RTRUE>>

<ROUTINE CANT-REACH-WHILE-IN? (OBJ1 OBJ2 "AUX" X)
	 <COND (<EQUAL? .OBJ1 <> .OBJ2>
		<RFALSE>)
	       (<GLOBAL-IN? ,HERE .OBJ1>
		<RFALSE>)
	       (<AND <IN? .OBJ1 ,HERE>
		     <OR <SET X <TOUCHING?>>
			 <AND <VERB? THRUST>
			      <EQUAL? .OBJ1 ,PRSO ,LAST-MONSTER>>>>
		<CANT-REACH .OBJ1>
		<TELL " while you're ">
		<COND (<EQUAL? .OBJ2 ,ARCH>
		       <TELL B ,W?UNDER>)
		      (<EQUAL? .OBJ2 ,DACT>
		       <TELL B ,W?ON>)
		      (<EQUAL? .OBJ2 ,BUSH>
		       <TELL B ,W?BEHIND>)
		      (T
		       <TELL B ,W?IN>)>
		<TELL C ,SP THE .OBJ2 ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CANT-REACH (OBJ)
	 <TELL ,CANT "quite reach " THE .OBJ>
	 <RFALSE>>

<ROUTINE NO-MAGIC-HERE? (OBJ)
	 <COND (<IN? ,PLAYER ,ARCH>)
	       (<NOT <EQUAL? ,ATIME ,PRESENT>>)
	       (<HERE? IN-CABIN IN-FROON IN-GARDEN>)
	       (<GRUE-ROOM?>)
	       (<AND <NOT <EQUAL? .OBJ ,GURDY>>
		     <PLAIN-ROOM?>>)
	       (<AND <HERE? IN-SKY>
		     <EQUAL? ,ABOVE ,OCAVES>>)
	       (<EQUAL? .OBJ ,PALIMP>
		<RFALSE>)
	       (<NOT <HERE? APLANE IN-SPLENDOR>>
		<RFALSE>)>
	 <SPUTTERS .OBJ>
	 <INFLUENCE>
	 <RTRUE>>

<ROUTINE SPUTTERS (OBJ)
	 <TELL CTHE .OBJ " sputters ineffectually. ">
	 <RTRUE>>

<ROUTINE INFLUENCE ()
	 <TELL "A nearby influence must be blocking its Magick." CR>
	 <RTRUE>>

<ROUTINE SEE-COLOR? ()
	 <COND (<NOT <PLAIN-ROOM?>>
		<RTRUE>)
	       (<IS? ,HERE ,SEEN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GRUE-ROOM? ("AUX" X)
	 <SET X <GETB ,GRUE-ROOMS 0>>
	 <COND (<SET X <INTBL? ,HERE <REST ,GRUE-ROOMS 1> .X 1>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PLAIN-ROOM? ("OPT" (RM ,HERE) "AUX" X)
	 <COND (<EQUAL? .RM ,IN-FARM ,ROSE-ROOM>
		<RTRUE>)>
	 <SET X <GETB ,PLAIN-ROOMS 0>>
	 <COND (<SET X <INTBL? .RM <REST ,PLAIN-ROOMS 1> .X 1>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GROUND-WORD ()
	 <COND (<IS? ,HERE ,INDOORS>
		<TELL B ,W?FLOOR>
		<RFALSE>)>
	 <TELL B ,W?GROUND>
	 <RFALSE>>

"*** THE MONSTER MACHINE ***"

<ROUTINE VIEW-MONSTER ("OPT" CONTEXT "AUX" X)
	 <COND (<IS? ,DESCING ,SLEEPING>
		<TELL CTHE ,DESCING " lies stunned upon the ">
		<GROUND-WORD>
		<TELL C ,PER>
		<RTRUE>)
	       (<IS? ,DESCING ,SURPRISED>
		<SET X <GETP ,DESCING ,P?EXIT-STR>>
		<COND (<OR <IS? ,DESCING ,SEEN>
			   <ZERO? .X>>
		       <TELL CTHE ,DESCING " is waiting for you.">
		       <RTRUE>)>
		<MAKE ,DESCING ,SEEN>
		<TELL CA ,DESCING ,SIS .X C ,PER>
		<RTRUE>)>
	 <SET X <RANDOM 100>>
	 <COND (<L? .X 33>
		<TELL CA ,DESCING " is attacking you">)
	       (<L? .X 67>
		<TELL "You're being attacked by " A ,DESCING>)
	       (T
		<TELL "You're under attack by " A ,DESCING>)>
	 <TELL "!">
	 <RTRUE>>

<ROUTINE DARK-MOVES ()
	 <TELL <PICK-NEXT ,DARK-MOVINGS> " in the darkness">
	 <COND (<PROB 50>
		<TELL " nearby">)>
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE OUCH (OBJ DAMAGE)
	 <COND (<T? ,STATIC>)
	       (<PROB 25>
		<TELL ". " <PICK-NEXT ,OUCHES>>)>
	 <TELL "!" CR>
	 <UPDATE-STAT <MSPARK? .OBJ .DAMAGE>>
	 <RTRUE>>

<GLOBAL LAST-MONSTER:OBJECT <>> "Last monster that bothered you."
<GLOBAL LAST-MONSTER-DIR 0> "Direction he came from."

<VOC "STUNNED" ADJ>

<ROUTINE STILL-SLEEPING? (OBJ)
	 <COND (<IS? .OBJ ,SLEEPING>
		<SETG LAST-MONSTER-DIR -1>
		<SETG ATTACK-MODE ,NORMAL-ATTACK>
		<TELL ,TAB>
		<COND (<IS? .OBJ ,NEUTRALIZED>
		       <UNMAKE .OBJ ,NEUTRALIZED>
		       <TELL CTHE .OBJ
" blinks its eyes, yawns and staggers with groggy impotence">)
		      (T
		       <WINDOW ,SHOWING-ROOM>
		       <UNMAKE .OBJ ,SLEEPING>
		       <REPLACE-ADJ? .OBJ ,W?STUNNED ,W?AWAKE>
		       <TELL CTHE .OBJ " shakes itself out of its stupor">)>
		<TELL ,PERIOD>
		<TOPPLED? .OBJ>
		<RTRUE>)>
	 <NEXT-ENDURANCE? .OBJ>
	 <RFALSE>>

<ROUTINE NEXT-ENDURANCE? (OBJ "AUX" X MAX CHANGE)
	 <SET X <GETP .OBJ ,P?ENDURANCE>>
	 <COND (<IS? .OBJ ,STRICKEN>
		<UNMAKE .OBJ ,STRICKEN>
		<RETURN .X>)>
	 <SET MAX <GETP .OBJ ,P?EMAX>>
	 <COND (<G? .MAX .X>
		<SET CHANGE <PERCENT 2 .MAX>>
		<COND (<L? .CHANGE 1>
		       <SET CHANGE 1>)>
		<SET X <+ .X .CHANGE>>
		<COND (<G? .X .MAX>
		       <SET X .MAX>)>
		<PUTP .OBJ ,P?ENDURANCE .X>)>
	 <RETURN .X>>

<ROUTINE WHIRLS (OBJ)
	 <TELL CTHE .OBJ " whirls to face you!" CR>
	 <TOPPLED? ,SNIPE>
	 <RTRUE>>

<ROUTINE TOPPLED? (OBJ)
	 <COND (<IS? ,DACT ,MUNGED>
		<RFALSE>)
	       (<AND <IN? ,PLAYER ,SADDLE>
		     <IN? ,SADDLE ,DACT>>
		<SETG P-WALK-DIR <>>
		<SETG OLD-HERE <>>
		<MOVE ,PLAYER <LOC ,DACT>>
		<EXIT-DACT .OBJ "play horsey" "sprawling across the dust">
		<RTRUE>)
	       (<VISIBLE? ,DACT>
		<EXIT-DACT .OBJ "stick around" "abandoned and alone">
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE EXIT-DACT (OBJ STR1 STR2)
	 <UNMAKE ,DACT ,NODESC>
	 <WINDOW ,SHOWING-ROOM>
	 <REMOVE ,DACT>
	 <TELL ,TAB CTHE ,DACT>
	 <COND (<IS? ,DACT ,SLEEPING>
		<UNMAKE ,DACT ,SLEEPING>
		<TELL " shakes himself awake,">)>
	 <TELL " takes one good look at " THE .OBJ 
" and decides that he doesn't want to " .STR1 
" anymore. Before you can think or move, you find yourself " .STR2
", with a cowardly shadow soaring out of sight overhead." CR>
	 <RTRUE>>

<ROUTINE SEE-MONSTER (OBJ)
	 <SETG LAST-MONSTER .OBJ>
	 <UNMAKE .OBJ ,SURPRISED>
	 <RFALSE>>

<ROUTINE MONSTER-STRIKES? (OBJ "AUX" (DAMAGE 0) STR CHANCE X)
	 <SEE-MONSTER .OBJ>
	 <SET STR <GETP .OBJ ,P?STRENGTH>>
	 <COND (<L? .STR 1>
		<RFALSE>)>
	 <MAKE .OBJ ,STRICKEN>
	 <SET CHANCE %</ ,MIN-HIT-PROB 4>>
	 <COND (<NOT <EQUAL? ,ATTACK-MODE ,PARRYING>>
		<SET CHANCE <GETP .OBJ ,P?DEXTERITY>>
		<COND (<EQUAL? ,ATTACK-MODE ,NORMAL-ATTACK>
		       <SET CHANCE </ .CHANCE 2>>)>
		<SET CHANCE 
		     <PERCENT .CHANCE %<- ,MAX-HIT-PROB ,MIN-HIT-PROB>>>
		<SET CHANCE <+ .CHANCE ,MIN-HIT-PROB>>
		<COND (<G? .CHANCE ,MAX-HIT-PROB>
		       <SET CHANCE ,MAX-HIT-PROB>)>)>
	 <SETG ATTACK-MODE ,NORMAL-ATTACK>
	 <COND (<PROB .CHANCE>
		<SET DAMAGE <- ,STATMAX <GET ,STATS ,ARMOR-CLASS>>>
		<SET DAMAGE </ <+ <* .DAMAGE .STR> 99> 100>>
		<COND (<L? .DAMAGE 2>
		       <SET DAMAGE 1>)
		      (T
		       <SET DAMAGE <RANDOM .DAMAGE>>)>
		<COND (<T? ,AUTO>
		       <BMODE-ON>)>
		<RETURN <- 0 .DAMAGE>>)
	       (T
		<RFALSE>)>>

"Returns ,W? of monster appearance, else false."

<ROUTINE MOVE-MONSTER? (OBJ "OPT" (UD 0) 
			"AUX" L RLIST RLEN CNT DIR TBL DEST X BRIGHT FEAR) 
	 <COND (<IS? .OBJ ,SLEEPING>
		<UNMAKE .OBJ ,SLEEPING>
		<UNMAKE .OBJ ,STRICKEN>
		<UNMAKE .OBJ ,NEUTRALIZED>
		<RFALSE>)>
	 <MAKE .OBJ ,SURPRISED>
	 <NEXT-ENDURANCE? .OBJ>
	 <SET L <LOC .OBJ>>
	 <SET FEAR <LOC ,SCARE3>>
	 <SET RLIST <GETP .OBJ ,P?HABITAT>>
       ; <COND (<ZERO? .RLIST>
		<SAY-ERROR "MOVE-MONSTER? <1>">
		<RFALSE>)>
	 <SET RLEN <GETB .RLIST 0>>
	 <SET RLIST <REST .RLIST 1>>
	 <SET CNT 1>
	 <SET DIR ,P?NORTH>
	 <REPEAT ()
	    <SET TBL <GETP .L .DIR>>
	    <COND (<ZERO? .TBL>)
		  (<EQUAL? <MSB <GET .TBL ,XTYPE>> ,CONNECT ,SCONNECT ,X-EXIT>
		   <SET DEST <GET .TBL ,XROOM>>
		   <COND (<AND <SET X <INTBL? .DEST .RLIST .RLEN 1>>
			       <OR <NOT <EQUAL? .OBJ ,GRUE>>
				   <NOT <IS-LIT? .DEST>>>>
			  <COND (<T? ,LAST-MONSTER>)
				(<WEARING-MAGIC? ,CLOAK>)
				(<AND <EQUAL? .DEST ,HERE>
				      <NOT <EQUAL? .DEST .FEAR>>>
				 <SET CNT 2>
				 <PUT ,GOOD-DIRS 2 .DIR>
				 <RETURN>)>
			  <COND (<NOT <EQUAL? .DEST .FEAR>>
				 <INC CNT>
				 <PUT ,GOOD-DIRS .CNT .DIR>)>)>)>
	    <COND (<DLESS? DIR ,P?NW>
		   <RETURN>)>>
	 
	 <COND (<T? .UD>
		<SET DIR ,P?UP>
		<REPEAT ()
		   <SET TBL <GETP .L .DIR>>
		   <COND (<ZERO? .TBL>)
			 (<EQUAL? <MSB <GET .TBL ,XTYPE>> ,CONNECT ,SCONNECT>
			  <SET DEST <GET .TBL ,XROOM>>
			  <COND (<SET X <INTBL? .DEST .RLIST .RLEN 1>>
				 <COND (<T? ,LAST-MONSTER>)
				       (<WEARING-MAGIC? ,CLOAK>)
				       (<EQUAL? .DEST ,HERE>
					<SET CNT 2>
					<PUT ,GOOD-DIRS 2 .DIR>
					<RETURN>)>
				 <INC CNT>
				 <PUT ,GOOD-DIRS .CNT .DIR>)>)>
		   <COND (<EQUAL? .DIR ,P?DOWN>
			  <RETURN>)>
		   <SET DIR ,P?DOWN>>)>
	 
	 <COND (<EQUAL? .CNT 1> ; "Can't move!"
		<RFALSE>)
	       (<EQUAL? .CNT 2> ; "Only one way out."
		<SET DIR <GET ,GOOD-DIRS 2>>
		<SET DEST <GET <GETP .L .DIR> ,XROOM>>)
	       (T
		<SET X <GETP .OBJ ,P?LAST-LOC>>
		<PUT ,GOOD-DIRS 0 .CNT>
		<PUT ,GOOD-DIRS 1 0>
		<PROG ()
		   <SET DIR <PICK-ONE ,GOOD-DIRS>>
		   <SET DEST <GET <GETP .L .DIR> ,XROOM>>
		   <COND (<EQUAL? .DEST .X>
			  <AGAIN>)>>)>
	 
       ; <COND (<NOT <IN? .DEST ,ROOMS>>
		<SAY-ERROR "MOVE-MONSTER? <2>">
		<RFALSE>)>
	 
	 <COND (<ZERO? ,LAST-MONSTER>)
	       (<EQUAL? .DEST ,HERE>
		<RFALSE>)>
	 <MOVE .OBJ .DEST>
	 <PUTP .OBJ ,P?LAST-LOC .DEST>
	 <COND (<NOT <EQUAL? .DEST ,HERE>>
		<RFALSE>)
	       (<T? ,LIT?>
		<WINDOW ,SHOWING-ROOM>)>
	 <COND (<NOT <EQUAL? .DIR ,P?UP ,P?DOWN>>
		<SET DIR <+ .DIR 4>>
		<COND (<G? .DIR ,P?NORTH>
		       <SET DIR <- .DIR 8>>)>
		<SETG LAST-MONSTER-DIR .DIR>)>
	 <THIS-IS-IT .OBJ>
	 <SETG LAST-MONSTER .OBJ>
	 <UNMAKE .OBJ ,SURPRISED>
	 <COND (<EQUAL? .DIR ,P?UP>
		<SETG LAST-MONSTER-DIR ,P?DOWN>
		<RETURN ,W?UP>)
	       (<EQUAL? .DIR ,P?DOWN>
		<SETG LAST-MONSTER-DIR ,P?UP>
		<RETURN ,W?DOWN>)>
	 <RETURN <GET ,DIR-NAMES <- 0 <- .DIR ,P?NORTH>>>>>

"Activates monster NXT."

<ROUTINE NEXT-MONSTER (OBJ "AUX" RLIST LEN CNT X RM)
	 <COND (<ZERO? .OBJ>
		<RFALSE>)>
	 <SET RLIST <GETP .OBJ ,P?HABITAT>>
       ; <COND (<ZERO? .RLIST>
		<SAY-ERROR "NEXT-MONSTER">
		<RFALSE>)>
	 <SET LEN <GETB .RLIST 0>>
	 <SET X .LEN>
	 <SET CNT 1>
	 <REPEAT ()
	    <SET RM <GETB .RLIST .X>>
	    <COND (<EQUAL? .RM ,HERE>)
		  (<AND <EQUAL? .OBJ ,GRUE>
			<IS? .RM ,LIGHTED>>)
		  (<NOT <IS? .RM ,TOUCHED>>
		   <INC CNT>
		   <PUT ,AUX-TABLE .CNT .RM>)>
	    <COND (<DLESS? X 1>
		   <RETURN>)>>
	 <COND (<EQUAL? .CNT 1>
		<PROG ()
		   <SET RM <GETB .RLIST <RANDOM .LEN>>>
		   <COND (<EQUAL? .RM ,HERE>
			  <AGAIN>)
			 (<AND <EQUAL? .OBJ ,GRUE>
			       <IS? .RM ,LIGHTED>>
			  <AGAIN>)>>)
	       (<EQUAL? .CNT 2>
		<SET RM <GET ,AUX-TABLE 2>>)
	       (T
		<PUT ,AUX-TABLE 0 .CNT>
		<PUT ,AUX-TABLE 1 0>
		<SET RM <PICK-ONE ,AUX-TABLE>>)>
	 <MOVE .OBJ .RM>
	 <MAKE .OBJ ,SURPRISED>
	 <PUTP .OBJ ,P?LAST-LOC .RM>
	 <QUEUE <GETP .OBJ ,P?LIFE>>
	 <RFALSE>>

<ROUTINE V-SHIT ()
	 <PERFORM ,V?HIT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-HIT ("AUX" OBJ X)
	 <COND (<DARKFIGHT?>
		<RTRUE>)
	       (<T? ,PRSI>
		<RFALSE>)>
	 <SETG PRSI ,HANDS>
	 <COND (<SET OBJ <FIRST? ,WINNER>>
		<REPEAT ()
		   <COND (<IS? .OBJ ,WIELDED>
			  <SETG PRSI .OBJ>
			  <RETURN>)
			 (<IS? .OBJ ,WEAPON>
			  <SETG PRSI .OBJ>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <COND (<NOT <PRSI? HANDS>>
		<TELL "[with " THEI ,BRACKET>)>
	 <RFALSE>>

<GLOBAL ATTACK-MODE:NUMBER 0>

<ROUTINE V-PUNCH ()
	 <PERFORM ,V?HIT ,PRSO ,HANDS>
	 <RTRUE>>

<ROUTINE V-HIT ("AUX" (MODE ,NORMAL-ATTACK))
         <COND (<EQUAL? ,P-PRSA-WORD ,W?THRUST>
		<SET MODE ,THRUSTING>)>
	 <HIT-MONSTER .MODE>
	 <RTRUE>>

<ROUTINE V-THRUST ()
	 <COND (<PRACTICE? ,W?THRUST>
		<RTRUE>)>
	 <HIT-MONSTER ,THRUSTING>
	 <RTRUE>>

<ROUTINE DARKFIGHT? ()
	 <COND (<ZERO? ,LIT?>
		<COND (<AND <PRSO? GRUE URGRUE>
			    <WEARING-MAGIC? ,HELM>>
		       <RFALSE>)>
		<TOO-DARK>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRACTICE? (WRD)
	 <COND (<ZERO? ,PRSO>
		<COND (<ZERO? ,LAST-MONSTER>
		       <TELL "You practice " B .WRD "ing ">
		       <COND (<ZERO? ,LIT?>
			      <TELL "in the dark ">)>
		       <TELL "for a few moments." CR>
		       <RTRUE>)>
		<SETG PRSO ,LAST-MONSTER>)>
	 <RETURN <DARKFIGHT?>>>

<ROUTINE V-PARRY ()
	 <COND (<PRACTICE? ,W?PARRY>
		<RTRUE>)>
	 <COND (<OR <NOT <IS? ,PRSO ,LIVING>>
		    <NOT <IS? ,PRSO ,MONSTER>>
		    <IS? ,PRSO ,SLEEPING>>
		<TELL CTHEO " isn't attacking you" ,AT-MOMENT>
		<RTRUE>)>
	 <SETG ATTACK-MODE ,PARRYING>
	 <SETG LAST-MONSTER-DIR <>>
	 <COND (<AND <IN? ,PLAYER ,MAW>
		     <NOT <IN? ,PRSO ,MAW>>>
		<TELL CTHEO " can't seem to reach you." CR>
		<RTRUE>)>
	 <TELL "You leap away from " THEO "'s attack." CR>
	 <RTRUE>>

"Returns <> if battle should end, T otherwise."

<GLOBAL ATTACK-MODE:NUMBER ,NORMAL-ATTACK>

<ROUTINE HARMLESS ("OPT" (OBJ ,PRSO))
	 <TELL CTHE .OBJ " obviously means you no harm; ">
	 <COND (<L? <GET ,STATS ,COMPASSION> 15>
		<TELL "even your meager compassion is enough to stay ">)
	       (T
		<TELL "compassion stays ">)>
	 <TELL 'HANDS ,PERIOD>
	 <RTRUE>>

<ROUTINE HIT-MONSTER ("OPT" (MODE ,NORMAL-ATTACK) 
		      "AUX" STR DAM L MEND PCENT MIN X)
	 <COND (<DARKFIGHT?>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,LIVING>>
		<TELL "Attacking " THEO>
		<COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		       <TELL ,WITH A ,PRSI>)>
		<WONT-HELP>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,MONSTER>>
		<HARMLESS>
		<RTRUE>)>
	  
	 <SETG ATTACK-MODE .MODE>
	 <COND (<AND <ZERO? ,PRSI>
		     <PRE-HIT>>
		<RTRUE>)>
	 <SET L <LOC ,PLAYER>>
	 <COND (<NOT <IN? ,PRSO .L>>
		<TELL ,CANT "quite reach " THEO ,AT-MOMENT>
		<RTRUE>)
	       (<PRSO? CORBIES>
		<CORBIES-STAY-AWAY>
		<RTRUE>)
	       (<PRSO? URGRUE>
		<HOPELESS>
		<RTRUE>)
	       (<PRSO? DUST>
		<HIT-BUNNIES>
		<RTRUE>)
	       (<PRSO? SHAPE>
		<TOUCH-SHAPE-WITH ,PRSI>
		<RTRUE>)
	       (<AND <PRSI? PHASE>
		     <NOT <HERE? APLANE>>>
		<PHASE-WHOOSH>
		<RTRUE>)
	       (<PRSO? ASUCKER BSUCKER CSUCKER>
		<TOUCH-SUCKER-WITH ,PRSO ,PRSI>
		<RTRUE>)
	       (<PRSO? DEAD>
		<TOUCH-DEAD-WITH ,PRSI>
		<RTRUE>)>
	 <SET L <GET ,STATS ,LUCK>>
	 <SET STR <GET ,STATS ,STRENGTH>>
	 
	 <SETG NO-REFRESH ,ENDURANCE>
	 
	 <SET PCENT ,MAX-HIT-PROB>
	 <COND (<NOT <IS? ,PRSO ,SLEEPING>>
		<SET PCENT <GET ,STATS ,DEXTERITY>>
		<COND (<L? .PCENT ,MAX-HIT-PROB>
		       <COND (<L? .PCENT ,MIN-HIT-PROB>
			      <SET PCENT ,MIN-HIT-PROB>)>
		       <SET X <PERCENT .L <- ,MAX-HIT-PROB .PCENT>>>
		       <COND (<NOT <L? .X 1>>
			      <SET PCENT <+ .PCENT .X>>)>)>)>
	 
	 <COND (<EQUAL? .MODE ,THRUSTING>
		<SET PCENT ,MAX-HIT-PROB>)
	       (<G? .PCENT ,MAX-HIT-PROB>
		<SET PCENT ,MAX-HIT-PROB>)
	       (<L? .PCENT ,MIN-HIT-PROB>
		<SET PCENT ,MIN-HIT-PROB>)>
	 
	 <COND (<PROB .PCENT>
		<COND (<SPARK-TO? ,PRSI ,PRSO>
		       <TELL ,TAB>)>
		<SET MEND <GETP ,PRSO ,P?ENDURANCE>>
		<COND (<L? .MEND 1> ; "Static killed it!"
		       <RFALSE>)>
		
		<COND (<G? .STR 1>
		       <SET DAM <RANDOM .STR>>)>
		<SET X <PERCENT <GET ,STATS ,LUCK> .DAM>>
		<COND (<L? .X 1>
		       <SET X 1>)>
		<SET DAM <+ .DAM .X>>
		<COND (<G? .DAM .STR>
		       <SET DAM .STR>)>
		
		<SET MIN </ .DAM 5>>
		<SET DAM </ <+ <* <GETP ,PRSI ,P?EFFECT> .DAM> 99> 100>>
		<COND (<L? .DAM .MIN>
		       <SET DAM .MIN>)
		      (<NOT <IS? ,PRSI ,WIELDED>>
		       <SET DAM </ .DAM 2>>
		       <COND (<L? .DAM .MIN>
			      <SET DAM .MIN>)>)>
				 				
	      ; "No important damage."
			
	        <MAKE ,PRSO ,STRICKEN>
		<COND (<L? .DAM .MEND> ; "Non-fatal damage inflicted."
		       <SET PCENT <RATIO .DAM .MEND>>
		       <SET MEND <- .MEND .DAM>>
		       <PUTP ,PRSO ,P?ENDURANCE .MEND>
		       <YOUR-OBJ ,PRSI>
		       <TELL C ,SP>		       
		       <COND (<ZERO? ,LIT?>
			      <TELL "strikes a blow." CR>
			      <RTRUE>)>
		       <HOW-BAD .PCENT>
		       <TELL "ly wounds " THEO>
		       <COND (<L? .PCENT 20>
			      <TOO-BAD>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		
	      ; "Got the sucker!"
		
		<PUTP ,PRSO ,P?ENDURANCE 0>
		<PUTP ,PRSO ,P?STRENGTH 0>
		<TELL "You deal ">
		<COND (<T? ,LIT?>
		       <TELL THEO C ,SP>)>
		<TELL "a decisive blow">
		<COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		       <TELL ,WITH THEI>)>
		<TELL "!" CR>
		<RTRUE>)>
	 
       ; "Missed!"
	
	 <TELL ,CYOU>
	 <COND (<EQUAL? ,PRSI ,FEET>
		<TELL B ,W?KICK>)
	       (<OR <EQUAL? ,PRSI ,HANDS>
		    <PROB 50>>
		<TELL B ,W?SWING>)
	       (T
		<TELL B ,W?STRIKE>)>
	 <COND (<ZERO? ,LIT?>
		<TELL " at the darkness, with no effect." CR>
		<RTRUE>)>
	 <TELL " at " THEO>
	 <COND (<NOT <EQUAL? ,PRSI <> ,HANDS ,FEET>>
		<TELL ,WITH THEI>)>		
	 <TELL ", " <PICK-NEXT ,MISSES>>
	 <TOO-BAD>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE TOO-BAD ()
	 <COND (<PRSI? HANDS FEET>
		<RFALSE>)
	       (<AND <IS? ,PRSI ,WEAPON>
		     <NOT <IS? ,PRSI ,WIELDED>>>
		<TELL ". Too bad you're not wielding " THEI>)>
	 <RFALSE>>

<ROUTINE MONSTER-THROW ()
	 <MOVE ,PRSO <LOC ,PRSI>>
	 <WINDOW ,SHOWING-ALL>
	 <YOUR-OBJ ,PRSO>
	 <TELL " just misses " THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE KILL-MONSTER (OBJ "AUX" X)
         <EXUENT-MONSTER .OBJ>
	 <UNMAKE .OBJ ,LIVING>
	 <PUTP .OBJ ,P?STRENGTH 0>
	 <PUTP .OBJ ,P?DEXTERITY 0>
	 <PUTP .OBJ ,P?ENDURANCE 0>
	 <SET X <GETP .OBJ ,P?LIFE>>
	 <COND (<T? .X>
		<DEQUEUE .X>
		<PUTP .OBJ ,P?LIFE 0>)>
	 <SET X <GETP .OBJ ,P?VALUE>>
	 <COND (<T? .X>
		<PUTP .OBJ ,P?VALUE 0>
		<UPDATE-STAT .X ,EXPERIENCE>)>
	 <RFALSE>>

<ROUTINE EXUENT-MONSTER (OBJ)
	 <VANISH .OBJ>
	 <MAKE .OBJ ,SURPRISED>
	 <UNMAKE .OBJ ,STRICKEN>
	 <SETG ATTACK-MODE ,NORMAL-ATTACK>
	 <SETG QCONTEXT ,NOT-HERE-OBJECT>
	 <SETG QCONTEXT-ROOM <>>
	 <SETG LAST-MONSTER <FIND-IN? ,HERE ,MONSTER>>
	 <SETG LAST-MONSTER-DIR <>>
	 <RFALSE>>

<ROUTINE DIAGNOSE-MONSTER ("OPT" (OBJ ,PRSO) "AUX" MAX MEND)
	 <SET MAX <GETP .OBJ ,P?EMAX>>
	 <SET MEND <GETP .OBJ ,P?ENDURANCE>>
	 <COND (<IS? .OBJ ,FEMALE>
		<TELL "She">)
	       (T
		<TELL "He">)>
	 <TELL " appears to be ">
	 <COND (<IS? .OBJ ,SLEEPING>
		<TELL B ,W?STUNNED ", ">
		<COND (<EQUAL? .MEND .MAX>
		       <TELL B ,W?BUT>)
		      (T
		       <TELL B ,W?AND>)>
		<TELL ", ">)>
	 <COND (<EQUAL? .MAX .MEND>
		<TELL "in excellent condition">
		<COND (<AND <EQUAL? .OBJ ,DORN>
			    <IS? .OBJ ,MUNGED>>
		       <TELL " otherwise">)>
		<TELL ,PERIOD>
		<RTRUE>)>
	 <HOW-BAD <RATIO .MEND .MAX>>
	 <TELL "ly wounded." CR>
	 <RTRUE>> 

<ROUTINE HOW-BAD (PCENT)
	 <COND (<L? .PCENT 20>
		<TELL "dangerous">
		<RTRUE>)
	       (<L? .PCENT 40>
		<TELL "grave">
		<RTRUE>)
	       (<L? .PCENT 60>
		<TELL "serious">
		<RTRUE>)
	       (<L? .PCENT 80>
		<TELL "noticeab">
		<RTRUE>)
	       (T
		<TELL "slight">
		<RTRUE>)>>

<ROUTINE WATER? ("OPT" (OBJ ,PRSI))
	 <COND (<OR <EQUAL? .OBJ ,GREAT-SEA ,COVE ,BROOK>
		    <EQUAL? .OBJ ,WATERFALL ,RIVER>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MAGICWORD? ("OPT" (WRD <>) "AUX" LEN OBJ X)
	 <COND (<AND <T? ,TELEWORD>
		     <EQUAL? ,TELEWORD ,P-PRSA-WORD .WRD>>
		<SAY-TELEWORD>
		<RTRUE>)
	       (<AND <EQUAL? ,W?LIGHTNING ,P-PRSA-WORD .WRD>
		     <EQUAL? ,HERE <LOC ,RIDDLE>>>
		<OPEN-CLIFF>
		<RTRUE>)
	       (<AND <EQUAL? ,W?YOUTH ,P-PRSA-WORD .WRD>
		     <EQUAL? ,HERE <LOC ,BOULDER>>
		     <ZERO? <LOC ,POOL>>>
		<OPEN-POOL>
		<RTRUE>)
	       (<AND <T? ,AMULET-WORD>
		     <EQUAL? ,AMULET-WORD ,P-PRSA-WORD .WRD>>
		<SAY-AMULET-WORD>
		<RTRUE>)
	       (<AND <T? ,WALL-WORD>
		     <EQUAL? ,WALL-WORD ,P-PRSA-WORD .WRD>>
		<SAY-WALL-WORD>
		<RTRUE>)
	       (<AND <T? ,GOBLET-WORD>
		     <EQUAL? ,GOBLET-WORD ,P-PRSA-WORD .WRD>
		     <SAY-GOBLET-WORD?>>
		<RTRUE>)>
	 <SET LEN <GET ,ALL-SCROLLS 0>>
	 <REPEAT ()
	    <SET OBJ <GET ,ALL-SCROLLS .LEN>>
	    <COND (<OR <EQUAL? .OBJ ,PRSO>
		       <VISIBLE? .OBJ>>
		   <SET X <GET <GETPT .OBJ ,P?SYNONYM> 1>>
		   <COND (<EQUAL? .X ,W?ZZZP>)
			 (<EQUAL? .X .WRD ,P-PRSA-WORD>
			  <SET X <APPLY <GETP .OBJ ,P?EFFECT> .OBJ>>
			  <RTRUE>)>)>
	    <COND (<DLESS? LEN 1>
		   <RFALSE>)>>>

<ROUTINE DESCRIBE-MONSTERS (OBJ)
	 <COND (<NOT <IS? .OBJ ,LIVING>>
		<TELL "dead ">)
	       (<IS? .OBJ ,SLEEPING>
		<TELL "stunned ">)>
	 <PRINTD .OBJ>
	 <RTRUE>>

<ROUTINE LAST-ROOM-IN? (TBL "OPT" (LAST 1) "AUX" LEN RM)
	 <COND (<IS? ,HERE ,TOUCHED>
		<RFALSE>)>
	 <SET LEN <GETB .TBL 0>>
	 <REPEAT ()
	    <SET RM <GETB .TBL .LEN>>
	    <COND (<EQUAL? ,HERE .RM>)
		  (<NOT <IS? .RM ,TOUCHED>>
		   <RFALSE>)>
	    <COND (<DLESS? LEN .LAST>
		   <RTRUE>)>>>

<GLOBAL WINDIR:NUMBER 0>

<ROUTINE I-BREEZE ()
	 <COND (<IS? ,BREEZE ,SEEN>
		<UNMAKE ,BREEZE ,SEEN>
		<RFALSE>)
	       (<PROB 7>
		<RETURN <NEW-WINDIR? <NEXT-WINDIR?>>>)
	       (T
		<RFALSE>)>>

<ROUTINE NEXT-WINDIR? ("AUX" X)
	 <PROG ()
	    <SET X <RANDOM 8>>
	    <DEC X>
	    <COND (<EQUAL? .X ,WINDIR>
		   <AGAIN>)
		  (<NOT <HERE? IN-SKY>>)
		  (<AND <EQUAL? ,ABOVE ,OXROADS>
			<EQUAL? .X ,I-NE ,I-NORTH ,I-EAST>>
		   <AGAIN>)
		  (<AND <EQUAL? ,ABOVE ,OTHRIFF>
			<EQUAL? .X ,I-SE ,I-SOUTH ,I-EAST>>
		   <AGAIN>)>>
	 <RETURN .X>>

<ROUTINE NEW-WINDIR? ("OPT" X)
	 <COND (<ASSIGNED? X>
		<SETG WINDIR .X>)>
	 <MAKE ,BREEZE ,SEEN>
	 <COND (<IS? ,HERE ,INDOORS>
		<RFALSE>)
	       (<HERE? APLANE IN-SPLENDOR IN-FROON IN-GARDEN>
		<RFALSE>)
	       (<PLAIN-ROOM?>
		<RFALSE>)
	       (<SET X <INTBL? ,HERE ,ARCH-ROOMS ,MAX-ATIME 1>>
		<RFALSE>)>
	 <TELL ,TAB <PICK-NEXT ,WIND-ALERTS> ,PERIOD>
	 <RTRUE>>

<ROUTINE FIND-IN? (OBJ BIT)
	 <COND (<SET OBJ <FIRST? .OBJ>>
		<REPEAT ()
		   <COND (<IS? .OBJ .BIT>
			  <RETURN>)
			 (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <RETURN .OBJ>>

<ROUTINE ON-IN ("OPT" (OBJ ,PRSO))
	 <PRINTC ,SP>
	 <COND (<EQUAL? .OBJ ,BUSH>
		<TELL B ,W?BEHIND>)
	       (<EQUAL? .OBJ ,ARCH>
		<TELL B ,W?UNDER>)
	       (<OR <IS? .OBJ ,CONTAINER>
		    <IS? .OBJ ,PLACE>>
		<TELL B ,W?IN>)
	       (T
		<TELL B ,W?ON>)>
	 <TELL C ,SP THE .OBJ>
	 <RTRUE>>

<ROUTINE SHOP-DOOR (OBJ)
	 <TELL "glass " 'BCASE " near the ">
	 <COND (<IS? .OBJ ,OPENED>
		<TELL "open ">)>
	 <PRINTD .OBJ>
	 <RFALSE>>

<ROUTINE LOOK-ON-CASE (OBJ)
	 <COND (<SEE-ANYTHING-IN? .OBJ>
		<TELL ". On the case you see ">
		<CONTENTS .OBJ>)>
	 <TELL 
". Another exit is partly concealed by " A ,CURTAIN ,PERIOD>
	 <RFALSE>>

<ROUTINE DESCRIBE-CAVES (OBJ)
	 <TELL "Underground">
	 <RTRUE>>

<ROUTINE IGNORANT (WHO OBJ)
	 <TELL CTHE .WHO " shrugs. \"Don't know nothin' special about ">
	 <PRONOUN .OBJ>
	 <TELL ,PERQ>
	 <RTRUE>>

<ROUTINE PRONOUN (OBJ "OPT" IT)
	 <COND (<IS? .OBJ ,PLURAL>
		<TELL B ,W?THEM>
		<RTRUE>)
	       (<IS? .OBJ ,FEMALE>
		<TELL B ,W?HER>
		<RTRUE>)
	       (<IS? .OBJ ,PERSON>
		<TELL B ,W?HIM>
		<RTRUE>)
	       (<ASSIGNED? IT>
		<TELL B ,W?IT>
		<RTRUE>)
	       (T
		<TELL B ,W?THAT>
		<RTRUE>)>>

<ROUTINE DESCRIBE-WEAPONS (CONTEXT)
	 <TELL CA ,DESCING>
	 <PRINT " lies at your feet.">
	 <RTRUE>>

<ROUTINE SAY-YOUR (OBJ)
	 <COND (<NOT <IS? .OBJ ,NOARTICLE>>
		<TELL "your ">)>
	 <TELL D .OBJ>
	 <RFALSE>>

<ROUTINE YOUR-OBJ ("OPT" (OBJ ,PRSI))
	 <COND (<OR <EQUAL? .OBJ ,FEET>
		    <VERB? KICK>>
		<TELL "Your foot">
		<RFALSE>)
	       (<EQUAL? .OBJ <> ,HANDS ,ME>
		<TELL "Your fist">
		<RFALSE>)>
	 <COND (<NOT <IS? .OBJ ,NOARTICLE>>
		<TELL ,CYOUR>)>
	 <TELL D .OBJ>
	 <RFALSE>>

<ROUTINE CARRIAGE-RETURNS ("AUX" NUM)
	 <SET NUM ,HEIGHT>
	 <COND (<T? ,DMODE>
		<SET NUM <- .NUM 12>>)>
	 <REPEAT ()
	    <CRLF>
	    <COND (<DLESS? NUM 1>
		   <RFALSE>)>>>

<ROUTINE PEERING-BEHIND ()
	 <TELL "Peering behind " THEO ,LYOU-SEE>
	 <CONTENTS>
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE FROBOZZ (STR)
	 <TELL "Frobozz Magic " .STR " Company">
	 <RTRUE>>

<ROUTINE DO-INPUT ("AUX" CHR)
  <COND (<EQUAL? <SET CHR <INPUT 1>> ,MAC-UP-ARROW ,MAC-DOWN-ARROW>
	 <COND (<EQUAL? .CHR ,MAC-UP-ARROW> ,UP-ARROW)
	       (T ,DOWN-ARROW)>)
	(T .CHR)>>