"PARSER for BEYOND ZORK:
 Copyright (C)1987 Infocom, Inc. All rights reserved."

<SETG SIBREAKS ".,\"!?">

<GLOBAL NOW-PRSI?:FLAG <>>

<GLOBAL LIT?:FLAG T>
<GLOBAL ALWAYS-LIT?:FLAG <>>

<GLOBAL PRSA:VERB 0>
<GLOBAL PRSI:OBJECT 0>
<GLOBAL PRSO:OBJECT 0>
<GLOBAL P-TABLE:NUMBER 0>  
<GLOBAL P-SYNTAX:NUMBER 0> 
<GLOBAL P-LEN:NUMBER 0>    
<GLOBAL P-DIR:NUMBER 0>    
<GLOBAL HERE:OBJECT 0>

; <GLOBAL LAST-PLAYER-LOC 0>

<CONSTANT LEXMAX 59>
<CONSTANT P-LEXV-LENGTH %<+ <* ,LEXMAX 4> 2>>
<GLOBAL P-LEXV:TABLE       <ITABLE ,P-LEXV-LENGTH (BYTE) 0>>
<GLOBAL AGAIN-LEXV:TABLE   <ITABLE ,P-LEXV-LENGTH (BYTE) 0>>
<GLOBAL RESERVE-LEXV:TABLE <ITABLE ,P-LEXV-LENGTH (BYTE) 0>>

<GLOBAL RESERVE-PTR:FLAG <>>

<CONSTANT P-INBUF-LENGTH 82>
<GLOBAL P-INBUF:TABLE       <ITABLE ,P-INBUF-LENGTH (BYTE) 0>>
<GLOBAL RESERVE-INBUF:TABLE <ITABLE ,P-INBUF-LENGTH (BYTE) 0>> "FIX #36"
<GLOBAL OOPS-INBUF:TABLE    <ITABLE ,P-INBUF-LENGTH (BYTE) 0>>

<GLOBAL P-NUMBER:NUMBER -1>
<GLOBAL P-EXCHANGE:NUMBER 0>
<GLOBAL P-DIRECTION 0>
<GLOBAL P-LASTADJ:WORD <>>
<GLOBAL P-GWIMBIT 0>

<GLOBAL P-NAM <>>   
<GLOBAL P-XNAM <>>
<GLOBAL P-NAMW:TABLE <TABLE 0 0>>
<GLOBAL P-ADJ <>>   
<GLOBAL P-XADJ <>>
<GLOBAL P-ADJW:TABLE <TABLE 0 0>>
<GLOBAL P-PHR 0>	"Which noun phrase is being parsed?"

<GLOBAL P-OFW:TABLE <TABLE 0 0>>

<GLOBAL P-PRSO:TABLE <ITABLE NONE 48>>
<GLOBAL P-PRSI:TABLE <ITABLE NONE 48>>   
<GLOBAL P-BUTS:TABLE <ITABLE NONE 48>>   
<GLOBAL P-MERGE:TABLE <ITABLE NONE 48>>  
<GLOBAL P-OCL1 <ITABLE NONE 48>>
<GLOBAL P-OCL2 <ITABLE NONE 48>>

<GLOBAL P-GETFLAGS 0>
<GLOBAL P-AND <>>

<CONSTANT P-MATCHLEN 0>    
<CONSTANT P-ALL 1>  
<CONSTANT P-ONE 2>  
<CONSTANT P-INHIBIT 4>   

<GLOBAL P-CONT:FLAG <>> "Parse-continue flag."  

<GLOBAL P-IT-OBJECT:OBJECT <>>
<GLOBAL P-HER-OBJECT:OBJECT <>>
<GLOBAL P-HIM-OBJECT:OBJECT <>>
<GLOBAL P-THEM-OBJECT:OBJECT <>>

<GLOBAL QCONTEXT:OBJECT <>>
<GLOBAL QCONTEXT-ROOM:OBJECT <>>

"Orphan flag"

<GLOBAL P-OFLAG:FLAG <>> 

<GLOBAL P-MERGED <>>
<GLOBAL P-ACLAUSE <>>    
<GLOBAL P-ANAM <>>  

; <GLOBAL P-AADJ <>>

"Byte offset to # of entries in LEXV"

<CONSTANT P-LEXWORDS 1>

"Word offset to start of LEXV entries"

<CONSTANT P-LEXSTART 1>

"Number of words per LEXV entry"

<CONSTANT P-LEXELEN 2>   
<CONSTANT P-WORDLEN 4>

"Offset to parts of speech byte"

<CONSTANT P-PSOFF 6>

"Offset to first part of speech"

<CONSTANT P-P1OFF 7>

"First part of speech bit mask in PSOFF byte"

<CONSTANT P-P1BITS 3>    
<CONSTANT P-ITBLLEN 20> "In bytes (for COPYT)."   

<GLOBAL P-ITBL:TABLE <TABLE 0 0 0 0 0 0 0 0 0 0>>  
<GLOBAL P-OTBL:TABLE <TABLE 0 0 0 0 0 0 0 0 0 0>>  
<GLOBAL P-VTBL:TABLE <TABLE 0 0 0 0>>
<GLOBAL P-OVTBL:TABLE <TABLE 0 0 0 0>>
<GLOBAL P-NCN 0>    

<CONSTANT P-VERB 0> 
<CONSTANT P-VERBN 1>
<CONSTANT P-PREP1 2>
<CONSTANT P-PREP1N 3>    
<CONSTANT P-PREP2 4>

; <CONSTANT P-PREP2N 5>    

<CONSTANT P-NC1 6>  
<CONSTANT P-NC1L 7> 
<CONSTANT P-NC2 8>  
<CONSTANT P-NC2L 9> 

<GLOBAL QUOTE-FLAG:FLAG <>>

<GLOBAL P-WON:FLAG <>>

<CONSTANT M-FATAL 2>

<CONSTANT M-BEG 1>  
<CONSTANT M-ENTERING 2>
<CONSTANT M-LOOK 3> 
<CONSTANT M-ENTERED 4>
<CONSTANT M-OBJDESC 5>
<CONSTANT M-END 6> 
<CONSTANT M-CONT 7> 
<CONSTANT M-WINNER 8>
<CONSTANT M-EXIT 9>

<GLOBAL P-WALK-DIR:DIRECTION <>>
<GLOBAL P-END-ON-PREP <>>

<GLOBAL OOPS-TABLE:TABLE <TABLE <> <> <> <>>>
<GLOBAL AGAIN-DIR:DIRECTION <>> ; "FIX #44"

<CONSTANT O-PTR 0>
<CONSTANT O-START 1>
<CONSTANT O-LENGTH 2>
<CONSTANT O-END 3>

<GLOBAL P-PRSA-WORD:WORD <>>
<GLOBAL P-DIR-WORD:WORD <>>

<GLOBAL P-SLOCBITS 0>

" Grovel down the input finding the verb, prepositions, and noun clauses.
   If the input is <direction> or <walk> <direction>, fall out immediately
   setting PRSA to ,V?WALK and PRSO to <direction>.  Otherwise, perform
   all required orphaning, syntax checking, and noun clause lookup."

<ROUTINE PARSER ("AUX" (PTR ,P-LEXSTART) (VAL 0) (VERB <>) (OF-FLAG <>)
		       (LEN 0) (DIR <>) (NW 0) (LW 0) OWINNER OMERGED WRD X)
	 <REPEAT ()
	   <COND (<ZERO? ,P-OFLAG>
		  <COPYT ,P-ITBL ,P-OTBL ,P-ITBLLEN>)>
	   <COPYT ,P-ITBL 0 ,P-ITBLLEN>
	   <SETG P-NAM <>>
	   <SETG P-ADJ <>>
	   <SETG P-XNAM <>>
	   <SETG P-XADJ <>>
	   <SETG P-DIR-WORD <>>
	   <SETG P-PNAM <>>
	   <SETG P-PADJN <>>
	   <COND (<ZERO? ,P-OFLAG>
		  <SETG P-ACT <>>
		  <SETG P-QWORD <>>
		  <SETG P-LASTADJ <>>
		  <PUT ,P-NAMW 0 <>>
		  <PUT ,P-NAMW 1 <>>
		  <PUT ,P-ADJW 0 <>>
		  <PUT ,P-ADJW 1 <>>
		  <PUT ,P-OFW 0 <>>
		  <PUT ,P-OFW 1 <>>)>
	   <SET OMERGED ,P-MERGED>
	   <SETG P-MERGED <>>
	   <SETG P-END-ON-PREP <>>
	   <PUT ,P-PRSO ,P-MATCHLEN 0>
	   <PUT ,P-PRSI ,P-MATCHLEN 0>
	   <PUT ,P-BUTS ,P-MATCHLEN 0>
	   <SET OWINNER ,WINNER>
	   <COND (<AND <ZERO? ,QUOTE-FLAG>
		       <NOT <EQUAL? ,WINNER ,PLAYER>>>
		  <SETG WINNER ,PLAYER>
		  <COND (<NOT <IS? <LOC ,WINNER> ,VEHICLE>>
			 <SETG HERE <LOC ,WINNER>>)>
		  <SETG LIT? <IS-LIT?>>)>
	   <COND (<T? ,RESERVE-PTR>
		  <SET PTR ,RESERVE-PTR>
		  <COPYT ,RESERVE-LEXV ,P-LEXV ,P-LEXV-LENGTH>
		  <COPYT ,RESERVE-INBUF ,P-INBUF ,P-INBUF-LENGTH> ; "FIX #36"
		  <COND (<AND <T? ,VERBOSITY>
			      <EQUAL? ,PLAYER ,WINNER>>
			 <CRLF>)>
		  <SETG RESERVE-PTR <>>
		  <SETG P-CONT <>>)
		 (<T? ,P-CONT>
		  <SET PTR ,P-CONT>
		  <SETG P-CONT <>>
		  <COND (<AND <T? ,VERBOSITY>
			      <EQUAL? ,PLAYER ,WINNER>>
			 <CRLF>)>)
		 (T
		  <SETG WINNER ,PLAYER>
		  <SETG QUOTE-FLAG <>>
		  <COND (<NOT <IS? <LOC ,WINNER> ,VEHICLE>>
			 <SETG HERE <LOC ,WINNER>>)>
		  <SETG LIT? <IS-LIT?>>
				  
		  <COND (<BTST <LOWCORE FLAGS> 4>
			 <V-REFRESH>)>
		  <COND (<HERE? OLD-HERE>)
			(<OR <ZERO? ,DMODE>
			     <EQUAL? ,IN-DBOX ,SHOWING-STATS>
			     <EQUAL? ,PRIOR ,SHOWING-INV ,SHOWING-STATS>>
			 <V-LOOK>)
			(T
			 <DISPLAY-PLACE>)>
		  <COND (<ZERO? ,DMODE>)
			(<ZERO? ,AUTO>)
			(<ZERO? ,NEW-DBOX>)
			(<AND <EQUAL? ,IN-DBOX ,SHOWING-ROOM>
			      <EQUAL? ,PRIOR 0 ,SHOWING-ROOM>>
			 <COND (<BTST ,NEW-DBOX ,SHOWING-ROOM>
				<SET X ,P-IT-OBJECT>
				<UPDATE-ROOMDESC>
				<THIS-IS-IT .X>)>)
			(<AND <EQUAL? ,IN-DBOX ,SHOWING-INV>
			      <EQUAL? ,PRIOR 0 ,SHOWING-INV>>
			 <COND (<BTST ,NEW-DBOX ,SHOWING-INV>
				<SET X ,P-IT-OBJECT>
				<UPDATE-INVENTORY>
				<THIS-IS-IT .X>)>)
			(<AND <EQUAL? ,IN-DBOX ,SHOWING-STATS>
			      <EQUAL? ,PRIOR 0 ,SHOWING-STATS>>
			 <COND (<BTST ,NEW-DBOX ,SHOWING-STATS>
				<SET X ,ENDURANCE>
				<TO-TOP-WINDOW>
				<REPEAT ()
				   <APPLY ,STAT-ROUTINE .X <GET ,STATS .X>>
				   <COND (<IGRTR? X ,LUCK>
					  <RETURN>)>>
				<TO-BOTTOM-WINDOW>)>)>
		
		  <COND (<T? ,VERBOSITY>
			 <CRLF>)>
		  <TELL ">">
		  <READ-LEXV>)>
	   <SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
	   <COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?QUOTE> ; "Quote first token?"
		  <SET PTR <+ .PTR ,P-LEXELEN>>	    ; "If so, ignore it."
		  <SETG P-LEN <- ,P-LEN 1>>)>
	   <COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?THEN ,W?PLEASE ,W?SO>
		  <SET PTR <+ .PTR ,P-LEXELEN>> ; "Ignore boring 1st words."
		  <SETG P-LEN <- ,P-LEN 1>>)>
	   <COND (<AND <L? 1 ,P-LEN>
		       <EQUAL? <GET ,P-LEXV .PTR> ,W?GO> ; "GO first word?"
		       <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
		       <WT? .NW ,PS?VERB ; ,P1?VERB>> ;" Followed by verb?"
		  <SET PTR <+ .PTR ,P-LEXELEN>>	   ; "If so, ignore it."
		  <SETG P-LEN <- ,P-LEN 1>>)>
	   <COND (<ZERO? ,P-LEN>
		  <TELL "[What?]" CR>
		  <RFALSE>)>
	   <SET WRD <GET ,P-LEXV .PTR>>
	   <COND (<EQUAL? .WRD ,W?UNDO>
		  <V-UNDO>
		  <RFALSE>)>
	   <SETG CAN-UNDO <ISAVE>>
	   <COND (<NOT <EQUAL? ,CAN-UNDO 2>>
		  <RETURN>)>
	   <V-REFRESH>
	   <COMPLETED "UNDO">
	   <COND (<OR <ZERO? ,DMODE>
		      <NOT <EQUAL? ,PRIOR 0 ,SHOWING-ROOM>>>
		  <CRLF>)>>
	<COND (<EQUAL? .WRD ,W?OOPS>
	       <COND (<EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
			      ,W?PERIOD ,W?COMMA>
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <SETG P-LEN <- ,P-LEN 1>>)> ; "FIX #38"
	       <COND (<NOT <G? ,P-LEN 1>>
		      <PRINTC %<ASCII !\[>>
		      <TELL ,CANT "use OOPS that way.]" CR>
		      <RFALSE>)
		     (<GET ,OOPS-TABLE ,O-PTR>
		      <COND (<G? ,P-LEN 2> ; "FIX #39"
			     <COND (<EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					  ,W?QUOTE>
				    <TELL 
"[Sorry. " ,CANT "correct mistakes in quoted text.]" CR>
				    <RFALSE>)>
			     <TELL 
"[NOTE: Only the first word after OOPS is used.]" CR ,TAB>)>
		      <PUT ,AGAIN-LEXV <GET ,OOPS-TABLE ,O-PTR>
			   <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
		      <SETG WINNER .OWINNER> ;"Fixes OOPS w/chars"
		      <INBUF-ADD <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 6>>
				 <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 7>>
			       <+ <* <GET ,OOPS-TABLE ,O-PTR> ,P-LEXELEN> 3>>
		      <COPYT ,AGAIN-LEXV ,P-LEXV ,P-LEXV-LENGTH>
		      <SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
		      <SET PTR <GET ,OOPS-TABLE ,O-START>>
		      <COPYT ,OOPS-INBUF ,P-INBUF ,P-INBUF-LENGTH>)
		     (T
		      <PUT ,OOPS-TABLE ,O-END <>>
		      <TELL 
"[There was no word to replace in that sentence.]" CR>
		      <RFALSE>)>)
	      (T
	       <COND (<NOT <EQUAL? .WRD ,W?AGAIN ,W?G>>
		      <SETG P-QWORD <>>
		      <SETG P-NUMBER -1>)>
	       <PUT ,OOPS-TABLE ,O-END <>>)>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?AGAIN ,W?G>
	       <COND (<OR <T? ,P-OFLAG>
			  <ZERO? ,P-WON>
			  <ZERO? <GETB ,OOPS-INBUF 1>>> ; "FIX #50"
		      <PRINTC %<ASCII !\[>>
		      <TELL ,CANT "use AGAIN that way.]" CR>
		      <RFALSE>)
		     (<G? ,P-LEN 1>
		      <COND (<OR <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?PERIOD ,W?COMMA ,W?THEN>
				 <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?AND>>
			     <SET PTR <+ .PTR <* 2 ,P-LEXELEN>>>
			     <PUTB ,P-LEXV ,P-LEXWORDS
				   <- <GETB ,P-LEXV ,P-LEXWORDS> 2>>)
			    (T
			     <DONT-UNDERSTAND>
			     <RFALSE>)>)
		     (T
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <PUTB ,P-LEXV ,P-LEXWORDS 
			    <- <GETB ,P-LEXV ,P-LEXWORDS> 1>>)>
	       <COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
		      <COPYT ,P-LEXV ,RESERVE-LEXV ,P-LEXV-LENGTH>
		    ; <STUFF ,RESERVE-LEXV ,P-LEXV>
		      <COPYT ,P-INBUF ,RESERVE-INBUF ,P-INBUF-LENGTH>
		    ; <INBUF-STUFF ,RESERVE-INBUF ,P-INBUF> ; "FIX #36"
		      <SETG RESERVE-PTR .PTR>)
		     (T
		      <SETG RESERVE-PTR <>>)>
	     ; <SETG P-LEN <GETB ,AGAIN-LEXV ,P-LEXWORDS>>
	       <SETG WINNER .OWINNER>
	       <SETG P-MERGED .OMERGED>
	       <COPYT ,OOPS-INBUF ,P-INBUF ,P-INBUF-LENGTH>
	     ; <INBUF-STUFF ,P-INBUF ,OOPS-INBUF>
	       <COPYT ,AGAIN-LEXV ,P-LEXV ,P-LEXV-LENGTH>
	     ; <STUFF ,P-LEXV ,AGAIN-LEXV>
	       <SET DIR ,AGAIN-DIR> ; "FIX #44"
	       <COPYT ,P-OTBL ,P-ITBL ,P-ITBLLEN>
	     ; <SET CNT -1>
	     ; <REPEAT ()
		       <COND (<IGRTR? CNT ,P-ITBLLEN>
		              <RETURN>)
		             (T
		              <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>)
	      (T
	       <SETG P-NUMBER -1> ; "Fixed BM 2/28/86"
	       <COPYT ,P-LEXV ,AGAIN-LEXV ,P-LEXV-LENGTH>
	     ; <STUFF ,AGAIN-LEXV ,P-LEXV>
	       <COPYT ,P-INBUF ,OOPS-INBUF ,P-INBUF-LENGTH>
	     ; <INBUF-STUFF ,OOPS-INBUF ,P-INBUF>
	       <PUT ,OOPS-TABLE ,O-START .PTR>
	       <PUT ,OOPS-TABLE ,O-LENGTH <* 4 ,P-LEN>> ; "FIX #37"
	       <SET LEN ; "FIX #43"
		    <* 2 <+ .PTR <* ,P-LEXELEN <GETB ,P-LEXV ,P-LEXWORDS>>>>>
	       <PUT ,OOPS-TABLE ,O-END <+ <GETB ,P-LEXV <- .LEN 1>>
					  <GETB ,P-LEXV <- .LEN 2>>>>
	       <SETG RESERVE-PTR <>>
	       <SET LEN ,P-LEN>
	       <SETG P-DIR <>>
	       <SETG P-NCN 0>
	       <SETG P-GETFLAGS 0>
	       <PUT ,P-ITBL ,P-VERBN 0>
	       <REPEAT ()
		<COND (<DLESS? P-LEN 0>
		       <SETG QUOTE-FLAG <>>
		       <RETURN>)>
		<SET WRD <GET ,P-LEXV .PTR>>
		<COND (<BUZZER-WORD? .WRD>
		       <RFALSE>)
		      (<OR <T? .WRD>
			   <SET WRD <QUOTED-WORD? .PTR .VERB>>
			   <SET WRD <NUMBER? .PTR>>
			 ; <SET WRD <NAME? .PTR>> >
		       <COND (<ZERO? ,P-LEN>
			      <SET NW 0>)
			     (T
			      <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		       <COND (<AND <EQUAL? .WRD ,W?TO>
				   <EQUAL? .VERB ,ACT?TELL ,ACT?ASK>>
			      <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
			    ; <SET VERB ,ACT?TELL>
			      <SET WRD ,W?QUOTE>)
			     (<AND <EQUAL? .WRD ,W?THEN ; ,W?PERIOD>
				 ; <NOT <EQUAL? .NW ,W?THEN ,W?PERIOD>>
				   <G? ,P-LEN 0> ; "FIX #40"
				   <ZERO? .VERB>
				   <ZERO? ,QUOTE-FLAG>>
			      <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
			      <PUT ,P-ITBL ,P-VERBN 0>
			      <SET WRD ,W?QUOTE>)
			     (<AND <EQUAL? .WRD ,W?PERIOD>
				   <EQUAL? .LW ,W?MR ,W?MRS ; ,W?DR>>
			      <SETG P-NCN <- ,P-NCN 1>>
			      <CHANGE-LEXV .PTR .LW T>
			      <SET WRD .LW>
			      <SET LW 0>)>  ; "FIX #40"
		       <COND ; (<AND <EQUAL? .WRD ,W?PERIOD>
				     <EQUAL? .LW ,W?MR ,W?MRS ; ,W?DR>>
			        <SET LW 0>)
			     (<EQUAL? .WRD ,W?THEN ,W?PERIOD ,W?QUOTE> 
			      <COND (<EQUAL? .WRD ,W?QUOTE>
				     <COND (<AND <EQUAL? <GET ,P-LEXV .PTR>
							 ,W?QUOTE>
						 <OR <NOT <EQUAL? .VERB
							    ,ACT?TELL
							    ,ACT?SAY
							  ; ,ACT?NAME>>
						     <NOT <EQUAL? ,WINNER
								  ,PLAYER>>>>
					    <COND (<QUOTED-PHRASE? .PTR .VERB>
						   <SET PTR 
							<+ .PTR ,P-LEXELEN>>
						   <AGAIN>)
						  (T
						   <RFALSE>)>)
					   (<T? ,QUOTE-FLAG>
					    <SETG QUOTE-FLAG <>>)
					   (T
					    <SETG QUOTE-FLAG T>)>)>
			      <OR <ZERO? ,P-LEN>
				  <SETG P-CONT <+ .PTR ,P-LEXELEN>>>
			      <PUTB ,P-LEXV ,P-LEXWORDS ,P-LEN>
			      <RETURN>)
			     (<AND <SET VAL <WT? .WRD ,PS?DIRECTION
					              ,P1?DIRECTION>>
				   <EQUAL? .VERB <> ,ACT?WALK ,ACT?GO>
				   <OR <EQUAL? .LEN 1>
				       <AND <EQUAL? .LEN 2>
					    <EQUAL? .VERB ,ACT?WALK ,ACT?GO>>
				       <AND <EQUAL? .NW ,W?THEN ,W?PERIOD
						    	,W?QUOTE>
					    <G? .LEN 1 ;2>>
				     ; <AND <EQUAL? .NW ,W?PERIOD>
					    <G? .LEN 1>>
				       <AND <T? ,QUOTE-FLAG>
					    <EQUAL? .LEN 2>
					    <EQUAL? .NW ,W?QUOTE>>
				       <AND <G? .LEN 2>
					    <EQUAL? .NW ,W?COMMA ,W?AND>>>>
			      <SET DIR .VAL>
			      <SETG P-DIR-WORD .WRD>
			      <COND (<EQUAL? .NW ,W?COMMA ,W?AND>
				     <CHANGE-LEXV <+ .PTR ,P-LEXELEN>
					          ,W?THEN>)>
			      <COND (<NOT <G? .LEN 2>>
				     <SETG QUOTE-FLAG <>>
				     <RETURN>)>)
			     (<AND <SET VAL <WT? .WRD ,PS?VERB ,P1?VERB>>
				   <ZERO? .VERB>>
			      <SETG P-PRSA-WORD .WRD> ; "For RUN, etc."
			      <SET VERB .VAL>
			      <PUT ,P-ITBL ,P-VERB .VAL>
			      <PUT ,P-ITBL ,P-VERBN ,P-VTBL>
			      <PUT ,P-VTBL 0 .WRD>
			      <SET X <+ <* .PTR 2> 2>>
			      <PUTB ,P-VTBL 2 <GETB ,P-LEXV .X>>
			      <PUTB ,P-VTBL 3 <GETB ,P-LEXV <+ .X 1>>>)
			     (<OR <SET VAL <WT? .WRD ,PS?PREPOSITION 0>>
				  <EQUAL? .WRD ,W?ALL ,W?EVERYTHING>
				  <EQUAL? .WRD ,W?BOTH ,W?A>
				  <WT? .WRD ,PS?ADJECTIVE>
				  <WT? .WRD ,PS?OBJECT>>
			      ; "Fix for new zilch, 3/12/87."
			      <COND (<AND <G? ,P-LEN 1> ; "1 IN RETROFIX #34"
					  <EQUAL? .NW ,W?OF>
					  <NOT <EQUAL? .VERB
						       ;,ACT?MAKE ,ACT?TAKE>>
					  <ZERO? .VAL>
					  <NOT <EQUAL? .WRD ,W?A>>
					  <NOT <EQUAL? .WRD ,W?ALL ,W?BOTH
						            ,W?EVERYTHING>>>
				   ; <COND (<EQUAL? .WRD ,W?BOTTOM>
					    <SET BOTTOM T>)>
				     <PUT ,P-OFW ,P-NCN .WRD> ; "Save OF-word"
				     <SET OF-FLAG T>)
				    (<AND <T? .VAL>
				          <OR <ZERO? ,P-LEN>
					      <EQUAL? .NW ,W?THEN ,W?PERIOD>>>
				     <SETG P-END-ON-PREP T>
				     <COND (<L? ,P-NCN 2>
					    <PUT ,P-ITBL ,P-PREP1 .VAL>
					    <PUT ,P-ITBL ,P-PREP1N .WRD>)>)
				    (<EQUAL? ,P-NCN 2>
				     <TELL
"[There are too many nouns in that sentence.]" CR>
				     <RFALSE>)
				    (T
				     <SETG P-NCN <+ ,P-NCN 1>>
				     <SETG P-ACT .VERB>
				     <SET PTR <CLAUSE .PTR .VAL .WRD>>
				     <COND (<ZERO? .PTR>
					    <RFALSE>)
					   (<L? .PTR 0>
					    <SETG QUOTE-FLAG <>>
					    <RETURN>)>)>)
			   
			     (<EQUAL? .WRD ,W?OF> ; "RETROFIX #34"
			      <COND (<OR <ZERO? .OF-FLAG>
					 <EQUAL? .NW ,W?PERIOD ,W?THEN>>
				     <CANT-USE .PTR>
				     <RFALSE>)
				    (T
				     <SET OF-FLAG <>>)>)
			     (<WT? .WRD ,PS?BUZZ-WORD>)
			     (<AND <EQUAL? .VERB ,ACT?TELL>
				   <WT? .WRD ,PS?VERB ; ,P1?VERB>>
			      <WAY-TO-TALK>
			      <RFALSE>)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T
		       <UNKNOWN-WORD .PTR>
		       <RFALSE>)>
		<SET LW .WRD>
		<SET PTR <+ .PTR ,P-LEXELEN>>>)>
	<PUT ,OOPS-TABLE ,O-PTR <>>
	<COND (<T? .DIR>
	       <SETG PRSA ,V?WALK>
	       <SETG P-WALK-DIR .DIR>
	       <SETG AGAIN-DIR .DIR> ; "FIX #44"
	       <SETG PRSO .DIR>
	       <SETG P-OFLAG <>>
	       <RTRUE>)>
	<SETG P-WALK-DIR <>>
	<SETG AGAIN-DIR <>> ; "FIX #44"
	<COND (<AND <T? ,P-OFLAG>
		    <ORPHAN-MERGE>>
	       <SETG WINNER .OWINNER>)
	    ; (T
	       <SETG BOTTOM? .BOTTOM>)>
      ; <COND (<ZERO? <GET ,P-ITBL ,P-VERB>>
	       <PUT ,P-ITBL ,P-VERB ,ACT?TELL>)> ; "Why was this here?"
	<COND (<AND <SYNTAX-CHECK>
		    <SNARF-OBJECTS>
		    <MANY-CHECK>
		  ; <TAKE-CHECK>
		    <ITAKE-CHECK ,P-PRSO <GETB ,P-SYNTAX ,P-SLOC1>>
		    <ITAKE-CHECK ,P-PRSI <GETB ,P-SYNTAX ,P-SLOC2>>>
	       <RTRUE>)>
	<RFALSE>>

<ROUTINE PCLEAR ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFALSE>>

<ROUTINE CHANGE-LEXV (PTR WRD "OPT" PTRS? "AUX" X Y Z)
	 <COND (<ASSIGNED? PTRS?>
		<SET X <+ 2 <* 2 <- .PTR ,P-LEXELEN>>>>
		<SET Y <GETB ,P-LEXV .X>>
		<SET Z <+ 2 <* 2 .PTR>>>
		<PUTB ,P-LEXV .Z .Y>
		<PUTB ,AGAIN-LEXV .Z .Y>
		<SET Y <GETB ,P-LEXV <+ 1 .X>>>
		<SET Z <+ 3 <* 2 .PTR>>>
		<PUTB ,P-LEXV .Z .Y>
		<PUTB ,AGAIN-LEXV .Z .Y>)>
	 <PUT ,P-LEXV .PTR .WRD>
	 <PUT ,AGAIN-LEXV .PTR .WRD>
	 <RTRUE>>

"Check whether word pointed at by PTR is the correct part of speech.
 The second argument is the part of speech (,PS?<part of speech>).  The
   3rd argument (,P1?<part of speech>), if given, causes the value
   for that part of speech to be returned."
 
<ROUTINE WT? (PTR BIT "OPT" (B1 5) "AUX" OFFS TYP)
	 <SET OFFS ,P-P1OFF>
	 <SET TYP <GETB .PTR ,P-PSOFF>>
	 <COND (<NOT <BTST .TYP .BIT>>
		<RFALSE>)
	       (<G? .B1 4>
		<RTRUE>)>
	 <SET TYP <BAND .TYP ,P-P1BITS>>
	 <COND (<NOT <EQUAL? .TYP .B1>>
		<SET OFFS <+ .OFFS 1>>)>
	 <RETURN <GETB .PTR .OFFS>>>

; <ROUTINE WT? (PTR BIT "OPT" (B1 5) "AUX" OFFS TYP) 
	<SET OFFS ,P-P1OFF>
	<SET TYP <GETB .PTR ,P-PSOFF>>
	<COND (<BTST .TYP .BIT>
	       <COND (<G? .B1 4>
		      <RTRUE>)>
	       <SET TYP <BAND .TYP ,P-P1BITS>>
	       <COND (<NOT <EQUAL? .TYP .B1>>
		      <INC OFFS>)>
	       <RETURN <GETB .PTR .OFFS>>)
	      (T
	       <RFALSE>)>>

"Scan through a noun phrase, leaving a pointer to its starting location:"

<ROUTINE CLAUSE (PTR VAL WRD "AUX" (FIRST?? T) (ANDFLG <>) (LW 0)
		 		   OFF NUM NW)
	<SET OFF <* <- ,P-NCN 1> 2>>
	<COND (<T? .VAL>
	       <PUT ,P-ITBL <SET NUM <+ ,P-PREP1 .OFF>> .VAL>
	       <PUT ,P-ITBL <+ .NUM 1> .WRD>
	       <SET PTR <+ .PTR ,P-LEXELEN>>)
	      (T
	       <SETG P-LEN <+ ,P-LEN 1>>)>
	<COND (<ZERO? ,P-LEN>
	       <SETG P-NCN <- ,P-NCN 1>>
	       <RETURN -1>)>
	<PUT ,P-ITBL <SET NUM <+ ,P-NC1 .OFF>> <REST ,P-LEXV <* .PTR 2>>>
	<COND (<OR <EQUAL? <GET ,P-LEXV .PTR> ,W?THE ,W?A ,W?AN>
		   <EQUAL? <GET ,P-LEXV .PTR> ,W?$BUZZ>>
	     ; <EQUAL? <GET ,P-LEXV .PTR> ,W?THE ,W?A ,W?AN>
	       <PUT ,P-ITBL .NUM <REST <GET ,P-ITBL .NUM> 4>>)>
	<REPEAT ()
		<COND (<DLESS? P-LEN 0>
		       <PUT ,P-ITBL <+ .NUM 1> <REST ,P-LEXV <* .PTR 2>>>
		       <RETURN -1>)>
		<SET WRD <GET ,P-LEXV .PTR>>
		<COND (<BUZZER-WORD? .WRD>
		       <RFALSE>)
		      (<OR <T? .WRD>
			   <SET WRD <QUOTED-WORD? .PTR>>
			   <SET WRD <NUMBER? .PTR>>
			 ; <SET WRD <NAME? .PTR>>>
		       <COND (<ZERO? ,P-LEN>
			      <SET NW 0>)
			     (T
			      <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
			      <COND (<ZERO? .NW> ; "FIX"
				     <SET NW
					  <NUMBER? <+ .PTR ,P-LEXELEN>>>)>)>
		     ; <COND (<AND <EQUAL? .WRD ,W?OF>
				   <EQUAL? <GET ,P-ITBL ,P-VERB>
					   ,ACT?MAKE ,ACT?TAKE>>
			      <CHANGE-LEXV .PTR ,W?WITH>
			      <SET WRD ,W?WITH>)>
		       <COND (<AND <EQUAL? .WRD ,W?QUOTE>
				   <NOT <EQUAL? ,P-ACT ,ACT?TELL ,ACT?SAY
						       ,ACT?NAME>>>
			      <COND (<QUOTED-PHRASE? .PTR ,P-ACT>
				     <SET PTR <+ .PTR ,P-LEXELEN>>
				     <AGAIN>)
				    (T
				     <RFALSE>)>)
			     (<AND <EQUAL? .WRD ,W?PERIOD>
				   <EQUAL? .LW ,W?MR ,W?MRS ; ,W?DR>>
			      <SET LW 0>)
			     (<EQUAL? .WRD ,W?AND ,W?COMMA>
			      <SET ANDFLG T>)
			     (<EQUAL? .WRD ,W?ALL ,W?BOTH ,W?EVERYTHING>
			    ; <OR <EQUAL? .WRD ,W?ALL ,W?BOTH ,W?ONE>
				  <EQUAL? .WRD ,W?EVERYTHING>>
			      <COND (<EQUAL? .NW ,W?OF>
				     <SETG P-LEN <- ,P-LEN 1>>
				     <SET PTR <+ .PTR ,P-LEXELEN>>)>)
			     (<OR <EQUAL? .WRD ,W?THEN ,W?PERIOD>
				  <AND <WT? .WRD ,PS?PREPOSITION>
				       <GET ,P-ITBL ,P-VERB>
				       <NOT .FIRST??>>>
			      <SETG P-LEN <+ ,P-LEN 1>>
			      <PUT ,P-ITBL
				   <+ .NUM 1>
				   <REST ,P-LEXV <* .PTR 2>>>
			      <RETURN <- .PTR ,P-LEXELEN>>)
			     ;"3/16/83: This clause used to be later."
			     (<AND <T? .ANDFLG>
				   <OR ;"3/25/83: next statement added."
				       <ZERO? <GET ,P-ITBL ,P-VERBN>>
				       ;"10/26/84: next stmt changed"
				       <VERB-DIR-ONLY? .WRD>>>
			      <SET PTR <- .PTR 4>>
			      <CHANGE-LEXV <+ .PTR 2> ,W?THEN>
			      <SETG P-LEN <+ ,P-LEN 2>>)
			     (<WT? .WRD ,PS?OBJECT>
			      <COND (<AND <G? ,P-LEN 0>
					  <EQUAL? .NW ,W?OF>
					  <NOT <EQUAL? .WRD ,W?ALL ; ,W?ONE
						            ,W?EVERYTHING>>>
				     <PUT ,P-OFW <- ,P-NCN 1> .WRD>)
				    (<AND <WT? .WRD ,PS?ADJECTIVE
					       ;,P1?ADJECTIVE>
					  <T? .NW>
					  <WT? .NW ,PS?OBJECT>>)
				    (<AND <ZERO? .ANDFLG>
					  <NOT <EQUAL? .NW ,W?BUT ,W?EXCEPT>>
					  <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
				     <PUT ,P-ITBL
					  <+ .NUM 1>
					  <REST ,P-LEXV <* <+ .PTR 2> 2>>>
				     <RETURN .PTR>)
				    (T
				     <SET ANDFLG <>>)>)
			     
       ; "Next clause replaced by following one to enable OLD WOMAN, HELLO"
			   
			   ; (<AND <OR <T? ,P-MERGED>
				       <T? ,P-OFLAG>
				       <T? <GET ,P-ITBL ,P-VERB>>>
				   <OR <WT? .WRD ,PS?ADJECTIVE>
				       <WT? .WRD ,PS?BUZZ-WORD>>>)
			     (<WT? .WRD ,PS?ADJECTIVE>)
			     (<WT? .WRD ,PS?BUZZ-WORD>)
			     (<AND <T? .ANDFLG>
				   <ZERO? <GET ,P-ITBL ,P-VERB>>>
			      <SET PTR <- .PTR 4>>
			      <CHANGE-LEXV <+ .PTR 2> ,W?THEN>
			      <SETG P-LEN <+ ,P-LEN 2>>)
			     (<WT? .WRD ,PS?PREPOSITION>)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T
		       <UNKNOWN-WORD .PTR>
		       <RFALSE>)>
		<SET LW .WRD>
		<SET FIRST?? <>>
		<SET PTR <+ .PTR ,P-LEXELEN>>>>

<ROUTINE SPOKEN-TO (WHO)
         <COND (<OR <NOT <EQUAL? .WHO ,QCONTEXT>>
		    <NOT <EQUAL? ,HERE ,QCONTEXT-ROOM>>>
		<SEE-CHARACTER .WHO>
	        <TELL "[spoken to " THE .WHO ,BRACKET>)>
	 <RTRUE>>

<ROUTINE ANYONE-HERE? ("AUX" OBJ)
	 <SET OBJ <QCONTEXT-GOOD?>>
	 <COND (<AND <ZERO? .OBJ>
		     <SET OBJ <FIRST? ,HERE>>>
		<REPEAT ()
		   <COND (<AND <IS? .OBJ ,PERSON>
			       <NOT <EQUAL? .OBJ ,PLAYER ,WINNER>>
			       <NOT <IS? .OBJ ,PLURAL>>>
			  <RETURN>)
			 (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <RETURN .OBJ>>

<ROUTINE SEE-CHARACTER (OBJ)
	 <COND (<IS? .OBJ ,FEMALE>
		<SETG P-HER-OBJECT .OBJ>)
	       (T
		<SETG P-HIM-OBJECT .OBJ>)>
	 <SETG QCONTEXT .OBJ>
	 <SETG QCONTEXT-ROOM <LOC .OBJ>>
	 <RFALSE>>

<ROUTINE QCONTEXT-GOOD? ()
	 <COND (<AND <T? ,QCONTEXT>
		     <IS? ,QCONTEXT ,PERSON>
		     <HERE? ,QCONTEXT-ROOM>
		     <VISIBLE? ,QCONTEXT>>
		<RETURN ,QCONTEXT>)>
	 <RFALSE>>

<ROUTINE THIS-IS-IT (OBJ)
	 <COND (<OR <ZERO? .OBJ>
		    <EQUAL? .OBJ ,PLAYER ,ME ,INTNUM>
		    <EQUAL? .OBJ ,INTDIR ,LEFT ,RIGHT>>
		<RFALSE>)
	       (<IS? .OBJ ,FEMALE>
		<SETG P-HER-OBJECT .OBJ>
		<RFALSE>)
	       (<IS? .OBJ ,PERSON>
		<SETG P-HIM-OBJECT .OBJ>
		<RFALSE>)
	       (<IS? .OBJ ,PLURAL>
		<SETG P-THEM-OBJECT .OBJ>
		<RFALSE>)
	       (T
		<SETG P-IT-OBJECT .OBJ>
		<RFALSE>)>>

<ROUTINE FAKE-ORPHAN ("AUX" TMP X)
	 <ORPHAN ,P-SYNTAX <>>
	 <BE-SPECIFIC>
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <COND (<ZERO? .TMP>
		<TELL B ,W?TELL>)
	       (<ZERO? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<SET X <GETB .TMP 2>>
		<WORD-PRINT .X <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <TELL "?]" CR>
	 <RTRUE>>

<ROUTINE PERFORM (A "OPT" (O <>) (I <>)
		    "AUX" (V <>) (WHO <>) OA OO OI ONP X) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT>)
	<COND (<AND <NOT <EQUAL? ,WINNER ,PLAYER>>
		    <NOT <IS? ,WINNER ,PERSON>>>
	       <NOT-LIKELY ,WINNER>
	       <PRINT " would respond.|">
	       <PCLEAR>
	       <RFATAL>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SET ONP ,NOW-PRSI?>
        <SET WHO <ANYONE-HERE?>>
	<SETG PRSA .A>
	<COND (<AND <NOT <EQUAL? ,WINNER ,PLAYER>>
		    <SET X <GAMEVERB?>>>
	       <TELL "[" ,CANT "tell characters to do that.]" CR>
	       <RFATAL>)
	      (<AND <ZERO? ,LIT?>
		    <SET X <SEEING?>>>
	       <TOO-DARK>
	       <RFATAL>)
	      (<NOT <EQUAL? .A ,V?WALK>>
	       <COND (<AND <EQUAL? ,WINNER ,PLAYER>
			   <VERB? WHO WHAT WHERE>
			   <T? .WHO>>
		      <SETG WINNER .WHO>
		      <SPOKEN-TO .WHO>)
	             (<AND <EQUAL? ,WINNER ,PLAYER>
			   <EQUAL? .O ,ME>
			   <VERB? TELL TELL-ABOUT ASK-ABOUT ASK-FOR
				  QUESTION REPLY THANK YELL HELLO GOODBYE
				  SAY ALARM>>
		      <COND (<ZERO? .WHO>
			     <TALK-TO-SELF>
			     <RFATAL>)>
		      <SETG WINNER .WHO>
		      <SPOKEN-TO .WHO>)>
	       <COND (<EQUAL? ,YOU .I .O>
		      <COND (<EQUAL? ,WINNER ,PLAYER>
			     <COND (<ZERO? .WHO>
				    <TALK-TO-SELF>
				    <RFATAL>)
				   (T
				    <SETG WINNER .WHO>
				    <SPOKEN-TO .WHO>)>)
			    (T
			     <SEE-CHARACTER ,WINNER>
			     <SET WHO ,WINNER>)>
		      <COND (<EQUAL? .I ,YOU>
			     <SET I .WHO>)>
		      <COND (<EQUAL? .O ,YOU>
			     <SET O .WHO>)>)>
	       <COND (<AND <EQUAL? ,IT .I .O>
			   <NOT <ACCESSIBLE? ,P-IT-OBJECT>>>
		      <COND (<ZERO? .I>
			     <FAKE-ORPHAN>)
			    (T
			     <CANT-SEE-ANY ,P-IT-OBJECT>)>
		      <RFATAL>)>
	       <COND (<EQUAL? ,THEM .I .O>
		      <COND (<VISIBLE? ,P-THEM-OBJECT>
			     <COND (<EQUAL? ,THEM .O>
				    <SET O ,P-THEM-OBJECT>)>
			     <COND (<EQUAL? ,THEM .I>
				    <SET I ,P-THEM-OBJECT>)>)
			    (T
			     <COND (<ZERO? .I>
				    <FAKE-ORPHAN>)
				   (T
				    <CANT-SEE-ANY ,P-THEM-OBJECT>)>
			     <RFATAL>)>)>
	       <COND (<EQUAL? ,HER .I .O>
		      <COND (<VISIBLE? ,P-HER-OBJECT>
			     <COND (<AND <EQUAL? ,P-HER-OBJECT ,WINNER>
					 <NO-OTHER? T>>
				    <RFATAL>)>	   
			     <COND (<EQUAL? ,HER .O>
				    <SET O ,P-HER-OBJECT>)>
			     <COND (<EQUAL? ,HER .I>
				    <SET I ,P-HER-OBJECT>)>)
			    (T
			     <COND (<ZERO? .I>
				    <FAKE-ORPHAN>)
				   (T 
				    <CANT-SEE-ANY ,P-HER-OBJECT>)>
			     <RFATAL>)>)>
	       <COND (<EQUAL? ,HIM .I .O>
		      <COND (<VISIBLE? ,P-HIM-OBJECT>
			     <COND (<AND <EQUAL? ,P-HIM-OBJECT ,WINNER>
					 <NO-OTHER?>>
				    <RFATAL>)>
			     <COND (<EQUAL? ,HIM .O>
				    <SET O ,P-HIM-OBJECT>)>
			     <COND (<EQUAL? ,HIM .I>
				    <SET I ,P-HIM-OBJECT>)>)
			    (T
			     <COND (<ZERO? .I>
				    <FAKE-ORPHAN>)
				   (T 
				    <CANT-SEE-ANY ,P-HIM-OBJECT>)>
			     <RFATAL>)>)>
	       <COND (<EQUAL? .O ,IT>
		      <SET O ,P-IT-OBJECT>)>
	       <COND (<EQUAL? .I ,IT>
		      <SET I ,P-IT-OBJECT>)>)>
	
	<SETG PRSI .I>
	<SETG PRSO .O>
		
        <SET V <>>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>>
	       <SET V <APPLY ,NOT-HERE-OBJECT-F>>
	       <COND (<T? .V>
		      <SETG P-WON <>>)>)>
      
	<COND (<NOT <EQUAL? .A ,V?WALK>>
	       <THIS-IS-IT ,PRSI>
	       <THIS-IS-IT ,PRSO>)>
	
	<SET O ,PRSO>
	<SET I ,PRSI>
		
	<COND (<ZERO? .V>
	       <SET V <APPLY <GETP ,WINNER ,P?ACTION> ,M-WINNER>>)>
	<COND (<ZERO? .V>
	       <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-BEG>>)>
	<COND (<ZERO? .V>
	       <SET V <APPLY <GET ,PREACTIONS .A>>>)>
			
	<COND (<T? .V>)
	      (<NOT <EQUAL? .A ,V?TELL-ABOUT ,V?ASK-ABOUT ,V?ASK-FOR>>
	       <SETG NOW-PRSI? T>
	       <COND (<ZERO? .I>)
		     (<AND <NOT <EQUAL? .A ,V?WALK>>
		    	   <LOC .I>>
	       	      <SET V <GETP <LOC .I> ,P?CONTFCN>>
	       	      <COND (<T? .V>
		      	     <SET V <APPLY .V ,M-CONT>>)>)>
	       <SETG NOW-PRSI? <>>
	       <COND (<T? .V>)
		     (<ZERO? .O>)
		     (<AND <NOT <EQUAL? .A ,V?WALK>>
			   <LOC .O>>
		      <SET V <GETP <LOC .O> ,P?CONTFCN>>
		      <COND (<T? .V>
			     <SET V <APPLY .V ,M-CONT>>)>)>
	       <SETG NOW-PRSI? T>
	       <COND (<T? .V>)
		     (<T? .I>
	       	      <SET V <APPLY <GETP .I ,P?ACTION>>>)>)>
	<SETG NOW-PRSI? <>>
	<COND (<T? .V>)
	      (<ZERO? .O>)
	      (<NOT <EQUAL? .A ,V?WALK>>
	       <SET V <APPLY <GETP .O ,P?ACTION>>>)>
	
	<COND (<ZERO? .V>
	       <SET V <APPLY <GET ,ACTIONS .A>>>)>
	
	<COND (<NOT <EQUAL? .V ,M-FATAL>>
	       <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>)>
	
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	<SETG NOW-PRSI? .ONP>
	<RETURN .V>>

<ROUTINE NO-OTHER? ("OPT" (FEMALE? <>) "AUX" OBJ)
	 <COND (<SET OBJ <FIRST? ,HERE>>
		<REPEAT ()
		   <COND (<EQUAL? .OBJ ,WINNER>)
			 (<IS? .OBJ ,PERSON>
			  <COND (<T? .FEMALE?>
				 <COND (<IS? .OBJ ,FEMALE>
					<RETURN>)>)
				(<NOT <IS? .OBJ ,FEMALE>>
				 <RETURN>)>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <COND (<ZERO? .OBJ>
		<PERPLEXED ,WINNER>
		<TELL "Who are you talking about?\"" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		 
<ROUTINE BUZZER-WORD? (WORD "AUX" TBL LEN X)
         <SET LEN <GET ,Q-BUZZES 0>>
	 <COND (<SET TBL <INTBL? .WORD <REST ,Q-BUZZES 2> .LEN>> 
	        <TO-DO-THING-USE "ask about" "ASK CHARACTER ABOUT">
	        <RTRUE>)>
	 <SET LEN <GET ,N-BUZZES 0>>
	 <COND (<SET TBL <INTBL? .WORD <REST ,N-BUZZES 2> .LEN>>
	        <NYMPH-APPEARS>
		<TELL ,DONT "need to use that " 'INTNUM>
		<TO-COMPLETE>
	        <RTRUE>)>
	 <SET LEN <GET ,SWEAR-WORDS 0>>
	 <COND (<SET TBL <INTBL? .WORD <REST ,SWEAR-WORDS 2> .LEN>>
	        <SET WORD <GET ,STATS ,INTELLIGENCE>>
		<COND (<L? .WORD 1>
		       <TELL 
"Such language betrays your low intelligence." CR>
		       <RTRUE>)>
		<TELL "You suddenly feel less intelligent." CR>
		<UPDATE-STAT -1 ,INTELLIGENCE T>		
		<RTRUE>)>
	 
	 <COND (<NOT <SEE-COLOR?>>
		<SET LEN <GET ,COLOR-WORDS 0>>
		<COND (<SET TBL <INTBL? .WORD <REST ,COLOR-WORDS 2> .LEN>>
		       <TELL ,DONT "see the color " B .WORD 
" here; or any other colors, for that matter." CR>
		       <RTRUE>)>)>

	 <SET LEN <GET ,MAGIC-WORDS 0>>
	 <REPEAT ()
	    <SET TBL <GET ,MAGIC-WORDS .LEN>>
	    <COND (<AND <EQUAL? .WORD <GET .TBL 0>>
			<ZERO? <GET .TBL 2>>>
		   <TELL "[This story won't recognize the word \""  
			 B .WORD ".\"]" CR>
		   <RTRUE>)>
	    <COND (<DLESS? LEN 2>
		   <RETURN>)>>
	 	 
	 <COND (<OR <EQUAL? .WORD ,W?QUIETLY ,W?SLOWLY ,W?CAREFULLY>
		    <EQUAL? .WORD ,W?CLOSELY ,W?QUICKLY ,W?RAPIDLY>>
	        <NYMPH-APPEARS>
		<TELL "Adverbs (such as \"" B .WORD "\") aren't needed">
	        <TO-COMPLETE>
		<RTRUE>)>
	 
	 <COND (<OR <EQUAL? .WORD ,W?XYZZY ,W?PLUGH ,W?PLOVER>
		    <EQUAL? .WORD ,W?YOHO ,W?ULYSSES ,W?ODYSSEUS>>
		<PRINT "A hollow voice says, \"Fool!\"">
		<CRLF>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE VERB-DIR-ONLY? (WRD)
	 <COND (<AND <NOT <WT? .WRD ,PS?OBJECT>>
	             <NOT <WT? .WRD ,PS?ADJECTIVE>>
	             <OR <WT? .WRD ,PS?DIRECTION>
		         <WT? .WRD ,PS?VERB>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<BUZZ AGAIN G OOPS>

"For AGAIN purposes, put contents of one LEXV table into another."

; <ROUTINE STUFF (DEST SRC "OPT" (MAX 29)
		           "AUX" (PTR ,P-LEXSTART) (CTR 1) BPTR)
	 <PUTB .DEST 0 <GETB .SRC 0>>
	 <PUTB .DEST 1 <GETB .SRC 1>>
	 <REPEAT ()
	         <PUT .DEST .PTR <GET .SRC .PTR>>
	         <SET BPTR <+ <* .PTR 2> 2>>
	         <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
	         <SET BPTR <+ <* .PTR 2> 3>>
	         <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
	         <SET PTR <+ .PTR ,P-LEXELEN>>
	         <COND (<IGRTR? CTR .MAX>
		        <RETURN>)>>>

"Put contents of one INBUF into another."

; <ROUTINE INBUF-STUFF (DEST SRC "AUX" CNT)
	 <SET CNT <- <GETB .SRC 0> 1>>
	 <REPEAT ()
		 <PUTB .DEST .CNT <GETB .SRC .CNT>>
		 <COND (<DLESS? CNT 0>
			<RTRUE>)>>> 

"Put the word in the positions specified from P-INBUF to the end of
OOPS-INBUF, leaving the appropriate pointers in AGAIN-LEXV."

<ROUTINE INBUF-ADD (LEN BEG SLOT "AUX" DBEG (CTR 0) TMP)
	 <SET TMP <GET ,OOPS-TABLE ,O-END>>
	 <COND (<T? .TMP>
		<SET DBEG .TMP>)
	       (T
		<SET DBEG <+ <GETB ,AGAIN-LEXV
				   <SET TMP <GET ,OOPS-TABLE ,O-LENGTH>>>
			     <GETB ,AGAIN-LEXV <+ .TMP 1>>>>)>
	 <PUT ,OOPS-TABLE ,O-END <+ .DBEG .LEN>>
	 <REPEAT ()
	         <PUTB ,OOPS-INBUF <+ .DBEG .CTR>
		                   <GETB ,P-INBUF <+ .BEG .CTR>>>
	         <INC CTR>
	         <COND (<EQUAL? .CTR .LEN>
			<RETURN>)>>
	 <PUTB ,AGAIN-LEXV .SLOT .DBEG>
	 <PUTB ,AGAIN-LEXV <- .SLOT 1> .LEN>
	 <RTRUE>>

; <GLOBAL P-DOLLAR-FLAG:FLAG <>>

<ROUTINE NUMBER? (PTR "AUX" (SUM 0) (TIM <>) (EXC <>) ; (DOLLAR 0)
		  	    CNT BPTR CHR CCTR TMP NW)
	 <SET TMP <REST ,P-LEXV <+ .PTR .PTR>>>
	 <SET BPTR <GETB .TMP 3>>
	 <SET CNT <GETB .TMP 2>>
	 <COND (<G? .CNT 3>
		<SET CNT 3>)>	 
	 <REPEAT ()
	    <COND (<DLESS? CNT 0>
		   <RETURN>)>
	    <SET CHR <GETB ,P-INBUF .BPTR>>
	    <COND (<EQUAL? .CHR %<ASCII !\:>>
		   <COND (<T? .EXC>
			  <RFALSE>)>
		   <SET TIM .SUM>
		   <SET SUM 0>)
		  (<EQUAL? .CHR %<ASCII !\->>
		   <COND (<T? .TIM>
			  <RFALSE>)>
		   <SET EXC .SUM>
		   <SET SUM 0>)
		  (<G? .SUM 9999>
		   <RFALSE>)
		; (<EQUAL? .CHR %<ASCII !\$>>
		   <SET DOLLAR T>)
		  (<AND <G? .CHR %<- <ASCII !\0> 1>>
			<L? .CHR %<+ <ASCII !\9> 1>>>
		   <SET SUM <+ <* .SUM 10> <- .CHR %<ASCII !\0>>>>)
		  (T
		   <RFALSE>)>
	    <INC BPTR>>
	 <CHANGE-LEXV .PTR ,W?INTNUM>
	 <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
       ; <COND (<AND <T? .DOLLAR>
		     <EQUAL? .NW ,W?PERIOD>
		     <G? ,P-LEN 1>>
		<SET TMP <CENTS-CHECK <+ .PTR <* ,P-LEXELEN 2>>>>
		<COND (<T? .TMP>
		       <COND (<EQUAL? .TMP 100>
			      <SET TMP 0>)>
		       <SET SUM <+ <* 100 .SUM> .TMP>>
		       <SET CCTR <- ,P-LEN 2>>
		       <REPEAT ()
			 <COND (<DLESS? CCTR 0>
				<RETURN>)>
			 <SET PTR <+ .PTR ,P-LEXELEN>>
			 <CHANGE-LEXV .PTR
				      <GET ,P-LEXV <+ .PTR <* 2 ,P-LEXELEN>>>>
	     <PUTB ,P-LEXV <+ <* .PTR 2> 2>
		   <GETB ,P-LEXV <+ <* <+ .PTR <* 2 ,P-LEXELEN>> 2> 2>>>
	     <PUTB ,P-LEXV <+ <* .PTR 2> 3>
		   <GETB ,P-LEXV <+ <* <+ .PTR <* 2 ,P-LEXELEN>> 2> 3>>>
	     <SETG P-LEN <- ,P-LEN 2>>
	     <PUTB ,P-LEXV ,P-LEXWORDS <- <GETB ,P-LEXV ,P-LEXWORDS> 2>>>)>)>
       ; <COND (<T? .DOLLAR>
		<SET SUM <* .SUM 100>>)
	       (<EQUAL? .NW ,W?DOLLAR ,W?DOLLARS>
		<SET DOLLAR T>
		<SET SUM <* .SUM 100>>)
	       (<EQUAL? .NW ,W?CENT ,W?CENTS>
		<SET DOLLAR T>)>
	 <COND (<G? .SUM 9999>
		<RFALSE>)
	       (<T? .EXC>
		<SETG P-EXCHANGE .EXC>)
	       (<T? .TIM>
		<SETG P-EXCHANGE 0>
		<COND (<G? .TIM 23>
		       <RFALSE>)
		      (<G? .TIM 19>)
		      (<G? .TIM 12>
		       <RFALSE>)
		      (<G? .TIM  7>)
		      (T
		       <SET TIM <+ 12 .TIM>>)>
		<SET SUM <+ .SUM <* .TIM 60>>>)
	       (T
		<SETG P-EXCHANGE 0>)>
       ; <SETG P-DOLLAR-FLAG .DOLLAR>
	 <SETG P-NUMBER .SUM>
       ; <COND (<AND <T? .DOLLAR>
		     <G? .SUM 0>>
		<RETURN ,W?MONEY>)>
       ; <SETG P-DOLLAR-FLAG <>>
	 <RETURN ,W?INTNUM>>

; <ROUTINE CENTS-CHECK (PTR "AUX" (CCTR 0) (SUM 0) CNT BPTR CHR)
	 <SET CNT <GETB <REST ,P-LEXV <* .PTR 2>> 2>>
	 <SET BPTR <GETB <REST ,P-LEXV <* .PTR 2>> 3>>
	 <REPEAT ()
		 <COND (<DLESS? CNT 0>
			<RETURN>)>
		 <SET CHR <GETB ,P-INBUF .BPTR>>
		 <COND (<IGRTR? CCTR 2>
			<RFALSE>)>
		 <COND (<AND <L? .CHR 58>
			     <G? .CHR 47>>
			<SET SUM <+ <* .SUM 10> <- .CHR 48>>>)
		       (T
			<RFALSE>)>
		 <INC BPTR>>
	 <COND (<ZERO? .SUM>
		<RETURN 100>)
	       (<EQUAL? .CCTR 1>
		<RETURN <* 10 .SUM>>)>
	 <RETURN .SUM>>

"Old ORPHAN-MERGE."

; <ROUTINE ORPHAN-MERGE ("AUX" (CNT -1) TEMP VERB BEG END (ADJ <>) WRD) 
   <SETG P-OFLAG <>>
   <COND (<OR <EQUAL? <WT? <SET WRD <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   ,PS?VERB ,P1?VERB>
		      <GET ,P-OTBL ,P-VERB>>
	      <WT? .WRD ,PS?ADJECTIVE>>
	  <SET ADJ T>) ; "FIX #45"
	 (<WT? <SET WRD <GET <GET ,P-ITBL ,P-VERBN> 0>>
	       ,PS?ADJECTIVE ;,P1?ADJECTIVE>
	  <SET ADJ T>)
	 (<AND <WT? .WRD ,PS?OBJECT ; ,P1?OBJECT>
	       <ZERO? ,P-NCN>>
	  <PUT ,P-ITBL ,P-VERB 0>
	  <PUT ,P-ITBL ,P-VERBN 0>
	  <PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
	  <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>
	  <SETG P-NCN 1>)>
   <COND (<AND <T? <SET VERB <GET ,P-ITBL ,P-VERB>>>
	       <ZERO? .ADJ>
	       <NOT <EQUAL? .VERB <GET ,P-OTBL ,P-VERB>>>>
	  <RFALSE>)
	 (<EQUAL? ,P-NCN 2>
	  <RFALSE>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC1> 1>
	  <COND (<OR <EQUAL? <SET TEMP <GET ,P-ITBL ,P-PREP1>>
			  <GET ,P-OTBL ,P-PREP1>>
		     <ZERO? .TEMP>>
		 <COND (<T? .ADJ>
			<PUT ,P-OTBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>> ;"? DELETE?"
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>
			<COND (<ZERO? ,P-NCN> ;"? DELETE?"
			       <SETG P-NCN 1>)>)
		       (T
			<PUT ,P-OTBL ,P-NC1 <GET ,P-ITBL ,P-NC1>>
			;<PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)>
		 <PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)
		(T
		 <RFALSE>)>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC2> 1>
	  <COND (<OR <EQUAL? <SET TEMP <GET ,P-ITBL ,P-PREP1>>
			  <GET ,P-OTBL ,P-PREP2>>
		     <ZERO? .TEMP>>
		 <COND (<T? .ADJ>
			<PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>> ;"? DELETE?"
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>)>
		 <PUT ,P-OTBL ,P-NC2 <GET ,P-ITBL ,P-NC1>>
		 <PUT ,P-OTBL ,P-NC2L <GET ,P-ITBL ,P-NC1L>>
		 <SETG P-NCN 2>)
		(T
		 <RFALSE>)>)
	 (<T? ,P-ACLAUSE>
	  <COND (<AND <NOT <EQUAL? ,P-NCN 1>> <NOT .ADJ>>
		 <SETG P-ACLAUSE <>>
		 <RFALSE>)
		(T
		 <SET BEG <GET ,P-ITBL ,P-NC1>>
		 <COND (<T? .ADJ>
		        <SET BEG <REST ,P-LEXV 2>>
			<SET ADJ <>>)>
		 <SET END <GET ,P-ITBL ,P-NC1L>>
		 <REPEAT ()
			 <SET WRD <GET .BEG 0>>
			 <COND (<EQUAL? .BEG .END>
				<COND (<T? .ADJ>
				       <CLAUSE-WIN .ADJ>
				     ; <ACLAUSE-WIN .ADJ>
				       <RETURN>)
				      (T
				       <SETG P-ACLAUSE <>>
				       <RFALSE>)>)
			       (<AND <ZERO? .ADJ>
				     <OR <BTST <GETB .WRD ,P-PSOFF>
					       ,PS?ADJECTIVE> ;"same as WT?"
					 <EQUAL? .WRD ,W?ALL ; ,W?ONE
						 ,W?EVERYTHING>>>
				<SET ADJ .WRD>)
			     ; (<EQUAL? .WRD ,W?ONE>
				<CLAUSE-WIN .ADJ>
			      ; <ACLAUSE-WIN .ADJ>
				<RETURN>)
			       (<BTST <GETB .WRD ,P-PSOFF> ,PS?OBJECT>
				<COND (<EQUAL? .WRD ,P-ANAM>
				       <CLAUSE-WIN .ADJ>
				     ; <ACLAUSE-WIN .ADJ>)
				      (T
				       <CLAUSE-WIN>
				     ; <NCLAUSE-WIN>)>
				<RETURN>)>
			 <SET BEG <REST .BEG ,P-WORDLEN>>
			 <COND (<ZERO? .END>
				<SET END .BEG>
				<SETG P-NCN 1>
				<PUT ,P-ITBL ,P-NC1 <BACK .BEG 4>>
				<PUT ,P-ITBL ,P-NC1L .BEG>)>>)>)>
   <PUT ,P-VTBL 0 <GET ,P-OVTBL 0>>
   <PUTB ,P-VTBL 2 <GETB ,P-OVTBL 2>>
   <PUTB ,P-VTBL 3 <GETB ,P-OVTBL 3>>
   <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
   <PUTB ,P-VTBL 2 0>
   ;<AND <NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
   <REPEAT ()
	   <COND (<IGRTR? CNT ,P-ITBLLEN>
		  <SETG P-MERGED T>
		  <RTRUE>)>
	   <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>>>

"New ORPHAN-MERGE."

<ROUTINE ORPHAN-MERGE ("AUX" (WHICH 1) (ADJ <>) TEMP VERB BEG END WRD X) 
   <SETG P-OFLAG <>>
   <SET WRD <GET <GET ,P-ITBL ,P-VERBN> 0>>
   <SET X <GET ,P-OTBL ,P-VERB>>
   <COND (<OR <EQUAL? <WT? .WRD ,PS?VERB ,P1?VERB> .X>
	      <WT? .WRD ,PS?ADJECTIVE>>
	  <SET ADJ T>)
	 (<AND <WT? .WRD ,PS?OBJECT ,P1?OBJECT>
	       <ZERO? ,P-NCN>>
	  <PUT ,P-ITBL ,P-VERB 0>
	  <PUT ,P-ITBL ,P-VERBN 0>
	  <PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
	  <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>
	  <SETG P-NCN 1>)>
   <SET VERB <GET ,P-ITBL ,P-VERB>>
   <COND (<AND <T? .VERB>
	       <ZERO? .ADJ>
	       <NOT <EQUAL? .VERB <GET ,P-OTBL ,P-VERB>>>>
	  <RFALSE>)
	 (<EQUAL? ,P-NCN 2>
	  <RFALSE>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC1> 1>
	  <SET TEMP <GET ,P-ITBL ,P-PREP1>>
	  <COND (<OR <ZERO? .TEMP>
		     <EQUAL? .TEMP <GET ,P-OTBL ,P-PREP1>>>
		 <COND (<T? .ADJ>
			<PUT ,P-OTBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>
			<COND (<ZERO? ,P-NCN>
			       <SETG P-NCN 1>)>)
		       (T
			<PUT ,P-OTBL ,P-NC1 <GET ,P-ITBL ,P-NC1>>)>
		 <PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)
		(T
		 <RFALSE>)>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC2> 1>
	  <SET WHICH 2>
	  <SET TEMP <GET ,P-ITBL ,P-PREP1>>
	  <COND (<OR <ZERO? .TEMP>
		     <EQUAL? .TEMP <GET ,P-OTBL ,P-PREP2>>>
		 <COND (<T? .ADJ>
			<PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>)>
		 <PUT ,P-OTBL ,P-NC2 <GET ,P-ITBL ,P-NC1>>
		 <PUT ,P-OTBL ,P-NC2L <GET ,P-ITBL ,P-NC1L>>
		 <SETG P-NCN 2>)
		(T
		 <RFALSE>)>)
	 (<T? ,P-ACLAUSE>
	  <COND (<AND <NOT <EQUAL? ,P-NCN 1>>
		      <ZERO? .ADJ>>
		 <SETG P-ACLAUSE <>>
		 <RFALSE>)
		(T
		 <COND (<NOT <EQUAL? ,P-ACLAUSE ,P-NC1>>
			<SET WHICH 2>)>
		 <SET BEG <GET ,P-ITBL ,P-NC1>>
		 <COND (<T? .ADJ>
			<SET BEG <REST ,P-LEXV 2>>
			<SET ADJ <>>)>
		 <SET END <GET ,P-ITBL ,P-NC1L>>
		 <REPEAT ()
			 <SET WRD <GET .BEG 0>>
			 <COND (<EQUAL? .BEG .END>
				<COND (<T? .ADJ>
				       <CLAUSE-WIN .ADJ>
				       <RETURN>)
				      (T
				       <SETG P-ACLAUSE <>>
				       <RFALSE>)>)
			       (<OR <EQUAL? .WRD ,W?ALL ,W?EVERYTHING ,W?ONE> 
				    <EQUAL? .WRD ,W?BOTH>
				    <AND <BTST <GETB .WRD ,P-PSOFF>
					       ,PS?ADJECTIVE> ;"same as WT?"
					 <ZERO? .ADJ>
				       ; <ADJ-CHECK .WRD .ADJ .ADJ>>>
				<SET ADJ .WRD>)
			       (<EQUAL? .WRD ,W?ONE>
				<CLAUSE-WIN .ADJ>
				<RETURN>)
			       (<AND <BTST <GETB .WRD ,P-PSOFF> ,PS?OBJECT>
				     <EQUAL? <REST .BEG ,P-WORDLEN> .END>>
				<COND (<EQUAL? .WRD ,P-ANAM>
				       <CLAUSE-WIN .ADJ>)
				      (T
				       <CLAUSE-WIN>)>
				<RETURN>)>
			 <SET BEG <REST .BEG ,P-WORDLEN>>
			 <COND (<ZERO? .END>
				<SET END .BEG>
				<SETG P-NCN 1>
				<PUT ,P-ITBL ,P-NC1 <BACK .BEG 4>>
				<PUT ,P-ITBL ,P-NC1L .BEG>)>>)>)>
   <PUT ,P-VTBL 0 <GET ,P-OVTBL 0>>
   <PUTB ,P-VTBL 2 <GETB ,P-OVTBL 2>>
   <PUTB ,P-VTBL 3 <GETB ,P-OVTBL 3>>
   <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
   <PUTB ,P-VTBL 2 0>
 ; <AND <NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>>
	<SETG P-NCN 2>>
      
 ; <SET CNT -1>
 ; <REPEAT ()
	   <COND (<IGRTR? CNT ,P-ITBLLEN>
		  <SETG P-MERGED T>
		  <RTRUE>)>
	   <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>>
   
   <COPYT ,P-OTBL ,P-ITBL ,P-ITBLLEN>
   <SETG P-MERGED .WHICH>
   <RTRUE>>

"ACLAUSE- and NCLAUSE-WIN are replaced by CLAUSE-WIN."

; <ROUTINE ACLAUSE-WIN (ADJ "AUX" X) 
	<PUT ,P-ITBL ,P-VERB <GET ,P-OTBL ,P-VERB>>
	<SET X <+ ,P-ACLAUSE 1>>
	<CLAUSE-COPY ,P-OTBL ,P-OTBL ,P-ACLAUSE .X ,P-ACLAUSE .X .ADJ>
	<AND <T? <GET ,P-OTBL ,P-NC2>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

; <ROUTINE NCLAUSE-WIN ()
        <CLAUSE-COPY ,P-ITBL ,P-OTBL ,P-NC1 ,P-NC1L
		     ,P-ACLAUSE <+ ,P-ACLAUSE 1>>
	<AND <T? <GET ,P-OTBL ,P-NC2>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

<ROUTINE CLAUSE-WIN ("OPT" (ADJ <>) X) 
	<COND (<T? .ADJ>
	       <SETG P-LASTADJ .ADJ>
	       <PUT ,P-ITBL ,P-VERB <GET ,P-OTBL ,P-VERB>>)
	      (T
	       <SET ADJ T>)>
	
	<SET X ,P-OCL2>
	<COND (<EQUAL? ,P-ACLAUSE ,P-NC1>
	       <SET X ,P-OCL1>)>
	<CLAUSE-COPY ,P-OTBL ,P-OTBL ,P-ACLAUSE <+ ,P-ACLAUSE 1> .X .ADJ>
      
      ; <CLAUSE-COPY ,P-OTBL ,P-OTBL ,P-ACLAUSE <+ ,P-ACLAUSE 1>
		     <COND (<EQUAL? ,P-ACLAUSE ,P-NC1> ,P-OCL1)
			   (T ,P-OCL2)> .ADJ>
	
	<COND (<NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>>
	       <SETG P-NCN 2>)>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

"Print undefined word in input. PTR points to the unknown word in P-LEXV"   

<ROUTINE WORD-PRINT (CNT BUF)
	 <COND (<G? .BUF 1>
		<REPEAT ()
		   <COND (<DLESS? CNT 0>
			  <RFALSE>)>
		   <PRINTC <GETB ,P-INBUF .BUF>>
		   <INC BUF>>)>
	 <RFALSE>>

<CONSTANT LAST-BAD-LEN 13>
<CONSTANT LAST-BAD <ITABLE ,LAST-BAD-LEN (BYTE) 0>>

<ROUTINE UNKNOWN-WORD (PTR "AUX" (CNT 0) MSG LEN OFFSET CHAR)
	 <PUT ,OOPS-TABLE ,O-PTR .PTR>
	 <SET MSG <PICK-NEXT ,UNKNOWN-MSGS>>
	 <TELL "[" <GET .MSG 0>>
	 <SET OFFSET <REST ,P-LEXV <* .PTR 2>>>
	 <SET LEN <GETB .OFFSET 2>> ; "Length of word typed."
	 <SET OFFSET <GETB .OFFSET 3>> ; "Starting offset into P-INBUF."
	 <COND (<G? .OFFSET 1>
		<REPEAT ()
		   <COND (<DLESS? LEN 0>
			  <RETURN>)>
		   <SET CHAR <GETB ,P-INBUF .OFFSET>>
		   <PRINTC .CHAR>
		   <INC OFFSET>
		   <COND (<L? .CNT %<- ,LAST-BAD-LEN 1>>
			  <INC CNT>
			  <PUTB ,LAST-BAD .CNT .CHAR>)>>)>
	 <PUTB ,LAST-BAD 0 .CNT>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-OFLAG <>>
	 <TELL <GET .MSG 1> "]" CR>
	 <RTRUE>>

" Perform syntax matching operations, using P-ITBL as the source of
   the verb and adjectives for this input.  Returns false if no
   syntax matches, and does it's own orphaning.  If return is true,
   the syntax is saved in P-SYNTAX."   
  
<CONSTANT P-SYNLEN 8>    
<CONSTANT P-SBITS 0> 
<CONSTANT P-SPREP1 1> 
<CONSTANT P-SPREP2 2> 
<CONSTANT P-SFWIM1 3> 
<CONSTANT P-SFWIM2 4> 
<CONSTANT P-SLOC1 5>
<CONSTANT P-SLOC2 6> 
<CONSTANT P-SACTION 7> 
<CONSTANT P-SONUMS 3>    

<ROUTINE SYNTAX-CHECK ("AUX" (DRIVE1 <>) (DRIVE2 <>)
		       	     SYN LEN NUM OBJ PREP VERB X Y) 
	<SET VERB <GET ,P-ITBL ,P-VERB>>
	<COND (<ZERO? .VERB>
	       <NOT-IN-SENTENCE "any verbs">
	       <RFALSE>)>
	<SET SYN <GET ,VERBS <- 255 .VERB>>>
	<SET LEN <GETB .SYN 0>>
	<SET SYN <REST .SYN>>
	<REPEAT ()
	   <SET NUM <BAND <GETB .SYN ,P-SBITS> ,P-SONUMS>>
	   <SET PREP <GET ,P-ITBL ,P-PREP1>>
	   <SET X <GETB .SYN ,P-SPREP1>>
	   <COND (<G? ,P-NCN .NUM>) ; "Added 4/27/83"
		 (<AND <NOT <L? .NUM 1>>
		       <ZERO? ,P-NCN>
		       <EQUAL? .PREP 0 .X>>
		  <SET DRIVE1 .SYN>)
		 (<EQUAL? .X <GET ,P-ITBL ,P-PREP1>>
		  <COND (<AND <EQUAL? .NUM 2>
			      <EQUAL? ,P-NCN 1>>
			 <SET DRIVE2 .SYN>)
			(<EQUAL? <GETB .SYN ,P-SPREP2>
				 <GET ,P-ITBL ,P-PREP2>>
			 <SETG P-SYNTAX .SYN>
			 <SETG PRSA <GETB .SYN ,P-SACTION>>
			 <RTRUE>)>)>
	   <COND (<DLESS? LEN 1>
		  <COND (<OR <T? .DRIVE1>
			     <T? .DRIVE2>>
			 <RETURN>)>
		  <DONT-UNDERSTAND>
		  <RFALSE>)>
	   <SET SYN <REST .SYN ,P-SYNLEN>>>
        <COND (<T? .DRIVE1>
	       <SET X <GETB .DRIVE1 ,P-SFWIM1>>
	       <SET Y <GETB .DRIVE1 ,P-SLOC1>>
	       <SET OBJ <GWIM .X .Y <GETB .DRIVE1 ,P-SPREP1>>>
	       <COND (<T? .OBJ>
		      <PUT ,P-PRSO ,P-MATCHLEN 1>
		      <PUT ,P-PRSO 1 .OBJ>
		      <SETG P-SYNTAX .DRIVE1>
		      <SETG PRSA <GETB .DRIVE1 ,P-SACTION>>
		      <RTRUE>)>)>
      ; <SET X <GETB .DRIVE1 ,P-SFWIM1>>
      ; <SET Y <GETB .DRIVE1 ,P-SLOC1>>
      ; <SET OBJ <GWIM .X .Y <GETB .DRIVE1 ,P-SPREP1>>>
      ; <COND (<AND <T? .DRIVE1>
		    <T? .OBJ>>
	       <PUT ,P-PRSO ,P-MATCHLEN 1>
	       <PUT ,P-PRSO 1 .OBJ>
	       <SETG P-SYNTAX .DRIVE1>
	       <SETG PRSA <GETB .DRIVE1 ,P-SACTION>>
	       <RTRUE>)>
      ; <SET OBJ <GWIM <GETB .DRIVE2 ,P-SFWIM2>
		       <GETB .DRIVE2 ,P-SLOC2>
		       <GETB .DRIVE2 ,P-SPREP2>>>
	<COND (<T? .DRIVE2>
	       <SET X <GETB .DRIVE2 ,P-SFWIM2>>
	       <SET Y <GETB .DRIVE2 ,P-SLOC2>>
	       <SET OBJ <GWIM .X .Y <GETB .DRIVE2 ,P-SPREP2>>>
	       <COND (<T? .OBJ>
		      <PUT ,P-PRSI ,P-MATCHLEN 1>
		      <PUT ,P-PRSI 1 .OBJ>
		      <SETG P-SYNTAX .DRIVE2>
		      <SETG PRSA <GETB .DRIVE2 ,P-SACTION>>
		      <RTRUE>)>)
	    ; (<AND <T? .DRIVE2>
		    <T? .OBJ>>
	       <PUT ,P-PRSI ,P-MATCHLEN 1>
	       <PUT ,P-PRSI 1 .OBJ>
	       <SETG P-SYNTAX .DRIVE2>
	       <SETG PRSA <GETB .DRIVE2 ,P-SACTION>>
	       <RTRUE>)
	      (<EQUAL? .VERB ,ACT?FIND ; ,ACT?WHAT>
	       <DO-IT-YOURSELF>
	       <RFALSE>)>
	<COND (<EQUAL? ,WINNER ,PLAYER>
	       <ORPHAN .DRIVE1 .DRIVE2>
	       <TELL "[Wh">)
	      (T
	       <TELL
"[Your command wasn't complete. Next time, type wh">)>
	<COND (<EQUAL? .VERB ,ACT?WALK ,ACT?GO>
	       <TELL "ere">)
	      (<OR <AND <T? .DRIVE1>
			<EQUAL? <GETB .DRIVE1 ,P-SFWIM1> ,PERSON>>
		   <AND <T? .DRIVE2>
			<EQUAL? <GETB .DRIVE2 ,P-SFWIM2> ,PERSON>>>
	       <TELL "om">)
	      (T
	       <TELL "at">)>
	<COND (<EQUAL? ,WINNER ,PLAYER>
	       <TELL " do you want">)
	      (T
	       <TELL " you want " THE ,WINNER>)>
	<TELL ,STO>
	<VERB-PRINT>
	<COND (<T? .DRIVE2>
	       <CLAUSE-PRINT ,P-NC1 ,P-NC1L>)>
	<SETG P-END-ON-PREP <>>
	<PREP-PRINT <COND (<T? .DRIVE1>
			   <GETB .DRIVE1 ,P-SPREP1>)
			  (T
			   <GETB .DRIVE2 ,P-SPREP2>)>>
	<COND (<EQUAL? ,WINNER ,PLAYER>
	       <SETG P-OFLAG T>
	       <TELL "?]" CR>)
	      (T
	       <SETG P-OFLAG <>>
	       <TELL ".]" CR>)>
	<RFALSE>>

<ROUTINE VERB-PRINT ("AUX" TMP X)
	<SET TMP <GET ,P-ITBL ,P-VERBN>>	;"? ,P-OTBL?"
	<COND (<ZERO? .TMP>
	       <TELL B ,W?TELL>)
	      (<ZERO? <GETB ,P-VTBL 2>>
	       <PRINTB <GET .TMP 0>>)
	      (T
	       <SET X <GETB .TMP 2>>
	       <WORD-PRINT .X <GETB .TMP 3>>
	       <PUTB ,P-VTBL 2 0>)>>

<ROUTINE ORPHAN (D1 D2) 
	 <COND (<ZERO? ,P-MERGED>
		<PUT ,P-OCL1 ,P-MATCHLEN 0>
		<PUT ,P-OCL2 ,P-MATCHLEN 0>)>
	 <PUT ,P-OVTBL 0 <GET ,P-VTBL 0>>
	 <PUTB ,P-OVTBL 2 <GETB ,P-VTBL 2>>
	 <PUTB ,P-OVTBL 3 <GETB ,P-VTBL 3>>
	 
       ; <SET CNT -1>
       ; <REPEAT ()
		 <COND (<IGRTR? CNT ,P-ITBLLEN>
			<RETURN>)>
		 <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>>
	 
	 <COPYT ,P-ITBL ,P-OTBL ,P-ITBLLEN>
	 <COND (<EQUAL? ,P-NCN 2>
		<CLAUSE-COPY ,P-ITBL ,P-OTBL ,P-NC2 ,P-NC2L ,P-OCL2>)>
	 <COND (<NOT <L? ,P-NCN 1>>
		<CLAUSE-COPY ,P-ITBL ,P-OTBL ,P-NC1 ,P-NC1L ,P-OCL1>)>
	 <COND (<T? .D1>
		<PUT ,P-OTBL ,P-PREP1 <GETB .D1 ,P-SPREP1>>
		<PUT ,P-OTBL ,P-NC1 1>)
	       (<T? .D2>
		<PUT ,P-OTBL ,P-PREP2 <GETB .D2 ,P-SPREP2>>
		<PUT ,P-OTBL ,P-NC2 1>)>
	 <RTRUE>> 

<ROUTINE CLAUSE-PRINT (BPTR EPTR "OPT" (THE? T) "AUX" X) 
	<SET X <GET ,P-ITBL .BPTR>>
	<BUFFER-PRINT .X <GET ,P-ITBL .EPTR> .THE?>
	<RFALSE>>    

<ROUTINE BUFFER-PRINT (BEG END CP 
		       "AUX" (NOSP <>) WRD (FIRST?? T) (PN <>) LEN)
	 <REPEAT ()
		<COND (<EQUAL? .BEG .END>
		       <RETURN>)>
		<SET WRD <GET .BEG 0>>
		<COND (<EQUAL? .WRD ,W?$BUZZ>)
		      (<EQUAL? .WRD ,W?COMMA>
		       <TELL ", ">)
		      (<T? .NOSP>
		       <SET NOSP <>>)
		      (T
		       <PRINTC ,SP>)>		
		<COND (<OR <AND <EQUAL? .WRD ,W?HIM>
				<NOT <VISIBLE? ,P-HIM-OBJECT>>>
			   <AND <EQUAL? .WRD ,W?HER>
				<NOT <VISIBLE? ,P-HER-OBJECT>>>
			   <AND <EQUAL? .WRD ,W?THEM>
				<NOT <VISIBLE? ,P-THEM-OBJECT>>>>
		       <SET PN T>)>
		<SET LEN <GET ,CAPS 0>>
		<COND (<OR <EQUAL? .WRD ,W?PERIOD ,W?COMMA ,W?$BUZZ>
			   <AND <OR <WT? .WRD ,PS?BUZZ-WORD>
				    <WT? .WRD ,PS?PREPOSITION>>
				<NOT <WT? .WRD ,PS?ADJECTIVE>>
				<NOT <WT? .WRD ,PS?OBJECT>>>>
		       <SET NOSP T>)
		      (<EQUAL? .WRD ,W?ME>
		       <PRINT-TABLE ,CHARNAME>
		       <SET PN T>)
		      (<SET LEN <INTBL? .WRD <REST ,CAPS 2> .LEN>>
		       <CAPITALIZE .BEG>
		       <SET PN T>)
		      (T
		       <SET LEN <GETB .BEG 3>>
		       <COND (<AND <T? .FIRST??>
				   <ZERO? .PN>
				   <T? .CP>>
			      <TELL ,LTHE>)>
		       <COND (<OR <T? ,P-OFLAG>
				  <T? ,P-MERGED>>
			      <PRINTB .WRD>)
			     (<AND <EQUAL? .WRD ,W?IT>
				   <VISIBLE? ,P-IT-OBJECT>>
			      <TELL D ,P-IT-OBJECT>)
			     (<AND <EQUAL? .WRD ,W?HER>
				   <ZERO? .PN>>
			      <TELL D ,P-HER-OBJECT>)
			     (<AND <EQUAL? .WRD ,W?THEM>
				   <ZERO? .PN>>
			      <TELL D ,P-THEM-OBJECT>)
			     (<AND <EQUAL? .WRD ,W?HIM>
				   <ZERO? .PN>>
			      <TELL D ,P-HIM-OBJECT>)
			     (T
			      <WORD-PRINT <GETB .BEG 2> .LEN>)>
		       <SET FIRST?? <>>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>>

<ROUTINE ADD-CAP? (WRD "AUX" X)
	 <SET X <GET ,CAPS 0>>
	 <COND (<SET X <INTBL? -1 <REST ,CAPS 2> .X>>
		<PUT .X 0 .WRD>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE CAPITALIZE (PTR)
	 <COND (<OR <T? ,P-OFLAG>
		    <T? ,P-MERGED>>
		<PRINTB <GET .PTR 0>>)
	       (T
		<PRINTC <- <GETB ,P-INBUF <GETB .PTR 3>> ,SP>>
		<WORD-PRINT <- <GETB .PTR 2> 1> <+ <GETB .PTR 3> 1>>)>>
			     
<ROUTINE PREP-PRINT (PREP "OPT" (SP? T) "AUX" WRD) 
	<COND (<AND <T? .PREP>
		    <ZERO? ,P-END-ON-PREP>>
	       <COND (<T? .SP?>
		      <TELL C ,SP>)>
	       <SET WRD <PREP-FIND .PREP>>
	       <PRINTB .WRD>
	       <COND (<AND <EQUAL? ,W?SIT <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   <EQUAL? ,W?DOWN .WRD>>
		      <TELL " on">)>
	       <COND (<AND <EQUAL? ,W?GET <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   <EQUAL? ,W?OUT .WRD>> ; "Will it ever work? --SWG"
		      <TELL " of">)>
	       <RTRUE>)>>    

"Old CLAUSE-COPY."

; <GLOBAL P-OCLAUSE:TABLE <ITABLE NONE 25>>

; <ROUTINE CLAUSE-COPY (SRC DEST SRCBEG SRCEND DESTBEG DESTEND
		      "OPT" (INSRT <>) "AUX" BEG END)
	<SET BEG <GET .SRC .SRCBEG>>
	<SET END <GET .SRC .SRCEND>>
	<PUT .DEST .DESTBEG
	     <REST ,P-OCLAUSE
		   <+ <* <GET ,P-OCLAUSE ,P-MATCHLEN> ,P-LEXELEN> 2>>>
	<REPEAT ()
	 <COND (<EQUAL? .BEG .END>
		<PUT .DEST .DESTEND
		     <REST ,P-OCLAUSE
			   <+ 2 <* <GET ,P-OCLAUSE ,P-MATCHLEN> ,P-LEXELEN>>>>
		<RETURN>)
	       (T
		<COND (<AND <T? .INSRT>
			    <EQUAL? ,P-ANAM <GET .BEG 0>>>
		       <CLAUSE-ADD .INSRT>)>
		<CLAUSE-ADD <GET .BEG 0>>)>
	 <SET BEG <REST .BEG ,P-WORDLEN>>>>

"Pointers used by CLAUSE-COPY (source/destination beginning/end pointers)."

; <CONSTANT CC-SBPTR 0>
; <CONSTANT CC-SEPTR 1>
; <CONSTANT CC-OCLAUSE 2>

; <GLOBAL P-CCTBL <TABLE 0 0 0 0 0>>

<ROUTINE CLAUSE-COPY (SRC DEST BB EE OCL "OPT" (INSRT <>)
		      "AUX" ; (FLG <>) BEG END OBEG CNT B E ; X)
        <SET BEG <GET .SRC .BB>>
	<SET END <GET .SRC .EE>>
	<SET OBEG <GET .OCL ,P-MATCHLEN>>
      ; <COND (<AND <T? .INSRT>
		    <EQUAL? .BEG <REST .OCL 2>>>
	       <SET OBEG 0>
	       <SET FLG T>)>
	<REPEAT ()
		<COND (<EQUAL? .BEG .END>
		       <RETURN>)>
		<COND (<AND <T? .INSRT>
			    <EQUAL? ,P-ANAM <GET .BEG 0>>>
		     ; <SET B <GET ,P-ITBL ,P-NC1>>
		     ; <SET E <GET ,P-ITBL ,P-NC1L>>
		     ; <COND (<T? .FLG>
			      <REPEAT ()
			         <SET CNT 0>
		     		 <COND (<EQUAL? .INSRT T>
		     		        <PUT .BEG 0 <GET .B 0>>
		     			<PUT .BEG 1 0>
				        <SET B <REST .B ,P-WORDLEN>>
				        <REPEAT ()
				           <COND (<EQUAL? .B .E>
		     				  <RETURN>)>
					   <SET B <REST .B ,P-WORDLEN>>
					   <SET CNT <+ .CNT 1>>>)
		     		      (T
				       <SET CNT 1>)>
		     	     <COND (<G? .CNT 0>
				    <SET X <* .CNT 2>>
				    <PUT .OCL ,P-MATCHLEN
				      	 <+ <GET .OCL ,P-MATCHLEN> .X>>
		     		    <COND (<AND <NOT <EQUAL? .BEG .END>>
					        <NOT <EQUAL?
		     				     <REST .BEG ,P-WORDLEN>
		     				     .END>>>
				    	   <SET B <BACK .END ,P-WORDLEN>>
					   <SET E <REST .END <* <- .CNT 1>
							  ,P-WORDLEN>>>
					   <REPEAT ()
					      <PUT .E 0 <GET .B 0>>
					      <PUT .E 1 <GET .B 1>>
					      <COND (<EQUAL? .B .BEG>
						     <RETURN>)>
					      <SET B <BACK .B ,P-WORDLEN>>
					      <SET E <BACK .E ,P-WORDLEN>>
					      <COND (<EQUAL? .B .BEG>
						     <RETURN>)>>)>
				  <SET END <REST .END <* .CNT ,P-WORDLEN>>>
				  <SET B <GET ,P-ITBL ,P-NC1>>
				  <SET E <GET ,P-ITBL ,P-NC1L>>
				  <COND (<EQUAL? .INSRT T>
					 <SET B <REST .B ,P-WORDLEN>>
					 <SET BEG <REST .BEG ,P-WORDLEN>>
					 <REPEAT ()
					    <COND (<EQUAL? .B .E>
		     				   <RETURN>)>
					    <PUT .BEG 0 <GET .B 0>>
					    <PUT .BEG 1 0>
					    <SET B <REST .B ,P-WORDLEN>>
					    <SET BEG <REST .BEG ,P-WORDLEN>>>)
					(T
					 <PUT .BEG ,P-LEXELEN ,P-ANAM>
					 <PUT .BEG <+ ,P-LEXELEN 1> 0>
					 <PUT .BEG 0 .INSRT>
					 <PUT .BEG 1 0>)>)>>
			      <RETURN>)
			     (<EQUAL? .INSRT T>
			      <REPEAT ()
				 <COND (<EQUAL? .B .E>
					<RETURN>)>
				 <CLAUSE-ADD <GET .B 0> .OCL>
				 <SET B <REST .B ,P-WORDLEN>>>)
			     (T
			      <COND (<NOT <EQUAL? .INSRT <GET .OCL 1>>>
				     <CLAUSE-ADD .INSRT .OCL>)>
			      <CLAUSE-ADD ,P-ANAM .OCL>)>
		       <COND (<EQUAL? .INSRT T>
			      <SET B <GET ,P-ITBL ,P-NC1>>
			      <SET E <GET ,P-ITBL ,P-NC1L>>
			      <REPEAT ()
				  <COND (<EQUAL? .B .E>
					 <RETURN>)>
				  <CLAUSE-ADD <GET .B 0> .OCL>
				  <SET B <REST .B ,P-WORDLEN>>>)
			     (T
			      <COND (<NOT <EQUAL? .INSRT <GET .OCL 1>>>
				     <CLAUSE-ADD .INSRT .OCL>)>
			      <CLAUSE-ADD ,P-ANAM .OCL>)>)
		    ; (<ZERO? .FLG>
		       <CLAUSE-ADD <ZGET .BEG 0> .OCL>)
		      (T
		       <CLAUSE-ADD <GET .BEG 0> .OCL>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>
	<SET CNT <- <GET .OCL ,P-MATCHLEN> .OBEG>>
	<COND (<AND ;<EQUAL? .SRC .DEST>
		  ; <ZERO? .FLG>
		    <G? .OBEG 0>
		    <T? .CNT>>
	       <PUT .OCL ,P-MATCHLEN 0>
	       <SET OBEG <+ .OBEG 1>>
	       <REPEAT ()
		  <CLAUSE-ADD <GET .OCL .OBEG> .OCL>
		  <SET CNT <- .CNT 2>>
		  <COND (<ZERO? .CNT>
			 <RETURN>)>
		  <SET OBEG <+ .OBEG 2>>>
	       <SET OBEG 0>)>
	<PUT .DEST .BB <REST .OCL <+ <* .OBEG ,P-LEXELEN> 2>>>
	<PUT .DEST .EE
	     <REST .OCL <+ <* <GET .OCL ,P-MATCHLEN> ,P-LEXELEN> 2>>>
	<RTRUE>>

; <ROUTINE CLAUSE-ADD (WRD TBL "AUX" PTR) 
	<SET PTR <+ <GET .TBL ,P-MATCHLEN> 2>>
	<PUT .TBL <- .PTR 1> .WRD>
	<PUT .TBL .PTR 0>
	<PUT .TBL ,P-MATCHLEN .PTR>
	<RFALSE>>

<ROUTINE CLAUSE-ADD (WRD TBL "AUX" PTR) 
	<SET PTR <GET .TBL ,P-MATCHLEN>>
	<INC PTR>
	<PUT .TBL .PTR .WRD>
	<INC PTR>
	<PUT .TBL .PTR 0>
	<PUT .TBL ,P-MATCHLEN .PTR>
	<RFALSE>>
 
<ROUTINE PREP-FIND (PREP "AUX" (CNT 0) SIZE) 
	<SET SIZE <* <GET ,PREPOSITIONS 0> 2>>
	<REPEAT ()
	   <COND (<IGRTR? CNT .SIZE>
		  <RFALSE>)
		 (<EQUAL? <GET ,PREPOSITIONS .CNT> .PREP>
		  <RETURN <GET ,PREPOSITIONS <- .CNT 1>>>)>>>  
  
<ROUTINE GWIM (GBIT LBIT PREP "AUX" (OBJ <>))
	<COND (<EQUAL? .GBIT ,LOCATION>
	       <RETURN ,ROOMS>)
	      (<AND <NOT <EQUAL? ,P-IT-OBJECT <> ,NOT-HERE-OBJECT>>
		    <IS? ,P-IT-OBJECT .GBIT>>
	       <COND (<AND <EQUAL? .GBIT ,TAKEABLE>
			   <IN? ,P-IT-OBJECT ,PLAYER>>)
		     (T
		      <SET OBJ ,P-IT-OBJECT>)>)
	      (<AND <NOT <EQUAL? ,P-HIM-OBJECT <> ,NOT-HERE-OBJECT>>
		    <IS? ,P-HIM-OBJECT .GBIT>>
	       <SET OBJ ,P-HIM-OBJECT>)
	      (<AND <NOT <EQUAL? ,P-HER-OBJECT <> ,NOT-HERE-OBJECT>>
		    <IS? ,P-HER-OBJECT .GBIT>>
	       <SET OBJ ,P-HER-OBJECT>)
	      (<AND <NOT <EQUAL? ,P-THEM-OBJECT <> ,NOT-HERE-OBJECT>>
		    <IS? ,P-THEM-OBJECT .GBIT>>
	       <SET OBJ ,P-THEM-OBJECT>)>
	<COND (<T? .OBJ>
	       <TELL "[" THE .OBJ ,BRACKET>
	       <RETURN .OBJ>)>
	<SETG P-GWIMBIT .GBIT>
	<SETG P-SLOCBITS .LBIT>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<COND (<GET-OBJECT ,P-MERGE <>>
	       <SETG P-GWIMBIT 0>
	       <COND (<EQUAL? <GET ,P-MERGE ,P-MATCHLEN> 1>
		      <SET OBJ <GET ,P-MERGE 1>>
		      <COND (<AND <EQUAL? ,WINNER ,PLAYER>
				  <NOT <EQUAL? .OBJ ,HANDS>>>
			     <TELL "[">
		      	     <COND (<PREP-PRINT .PREP <>>
			     	    <PRINTC ,SP>)>
			     <TELL THE .OBJ ,BRACKET>)>
		      <RETURN .OBJ>)>
	       <RFALSE>)
	      (<EQUAL? .GBIT ,WIELDED>
	       <SETG P-GWIMBIT 0>
	       <RETURN ,HANDS>)
	      (T
	       <SETG P-GWIMBIT 0>
	       <RFALSE>)>>   

<ROUTINE SNARF-OBJECTS ("AUX" PTR) 
	<SET PTR <GET ,P-ITBL ,P-NC1>>
	<COND (<T? .PTR>
	       <SETG P-PHR 0>
	       <SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC1>>
	       <COND (<NOT <SNARFEM .PTR <GET ,P-ITBL ,P-NC1L> ,P-PRSO>>
		      <RFALSE>)>
	       <COND (<GET ,P-BUTS ,P-MATCHLEN>
		      <SETG P-PRSO <BUT-MERGE ,P-PRSO>>)>)>
	<SET PTR <GET ,P-ITBL ,P-NC2>>
	<COND (<T? .PTR>
	       <SETG P-PHR 1>
	       <SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC2>>
	       <COND (<NOT <SNARFEM .PTR <GET ,P-ITBL ,P-NC2L> ,P-PRSI>>
		      <RFALSE>)>
	       <COND (<GET ,P-BUTS ,P-MATCHLEN>
		      <COND (<EQUAL? <GET ,P-PRSI ,P-MATCHLEN> 1>
			     <SETG P-PRSO <BUT-MERGE ,P-PRSO>>
			     <RTRUE>)>
		      <SETG P-PRSI <BUT-MERGE ,P-PRSI>>)>)>
	<RTRUE>>  

<ROUTINE BUT-MERGE (TBL "AUX" LEN BUTLEN (CNT 1) (MATCHES 0) OBJ NTBL X) 
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<REPEAT ()
	   <COND (<DLESS? LEN 0>
		  <RETURN>)>
	   <SET OBJ <GET .TBL .CNT>>
	   <SET X <REST ,P-BUTS 2>>
	   <COND (<NOT <SET X <INTBL? .OBJ .X <GET ,P-BUTS 0>>>>
		; <PUT ,P-MERGE <+ .MATCHES 1> .OBJ>
		; <SET MATCHES <+ .MATCHES 1>>
		  <INC MATCHES>
		  <PUT ,P-MERGE .MATCHES .OBJ>)>
	   <INC CNT>>
	<PUT ,P-MERGE ,P-MATCHLEN .MATCHES>
	<SET NTBL ,P-MERGE>
	<SETG P-MERGE .TBL>
	<RETURN .NTBL>>    
 
"Grabs the first adjective, unless it comes across a special-cased adjective."

; <ROUTINE ADJ-CHECK (WRD ADJ "OPT" (NW <>))
	 <COND (<ZERO? .ADJ>
		<RTRUE>)
	       (<ZMEMQ .WRD ,CHAR-POSS-TABLE>
		<RTRUE>)>>

<ROUTINE SNARFEM (PTR EPTR TBL "AUX" (BUT <>) LEN WV WRD NW (WAS-ALL? <>)
				     ONEOBJ) 
   ;"Next SETG 6/21/84 for WHICH retrofix"
   <SETG P-AND <>>
   <COND (<EQUAL? ,P-GETFLAGS ,P-ALL>
	  <SET WAS-ALL? T>)>
   <SETG P-GETFLAGS 0>
   <PUT ,P-BUTS ,P-MATCHLEN 0>
   <PUT .TBL ,P-MATCHLEN 0>
   <SET WRD <GET .PTR 0>>
   <REPEAT ()
	   <COND (<EQUAL? .PTR .EPTR>
		  <SET WV <GET-OBJECT <OR .BUT .TBL>>>
		  <COND (<T? .WAS-ALL?>
			 <SETG P-GETFLAGS ,P-ALL>)>
		  <RETURN .WV>)
		 (T
		  <COND (<EQUAL? .EPTR <REST .PTR ,P-WORDLEN>>
			 <SET NW 0>)
			(T
			 <SET NW <GET .PTR ,P-LEXELEN>>)>
		  <COND (<EQUAL? .WRD ,W?ALL ,W?BOTH ,W?EVERYTHING>
			 <SETG P-GETFLAGS ,P-ALL>
			 <COND (<EQUAL? .NW ,W?OF>
				<SET PTR <REST .PTR ,P-WORDLEN>>)>)
			(<EQUAL? .WRD ,W?BUT ,W?EXCEPT>
			 <COND (<NOT <GET-OBJECT <OR .BUT .TBL>>>
				<RFALSE>)>
			 <SET BUT ,P-BUTS>
			 <PUT .BUT ,P-MATCHLEN 0>)
			(<BUZZER-WORD? .WRD>
			 <RFALSE>)
			(<EQUAL? .WRD ,W?A ; ,W?ONE>
			 <COND (<ZERO? ,P-ADJ>
				<SETG P-GETFLAGS ,P-ONE>
				<COND (<EQUAL? .NW ,W?OF>
				       <SET PTR <REST .PTR ,P-WORDLEN>>)>)
			       (T
				<SETG P-NAM .ONEOBJ>
				<COND (<NOT <GET-OBJECT <OR .BUT .TBL>>>
				       <RFALSE>)>
				<COND (<ZERO? .NW>
				       <RTRUE>)>)>)
			(<AND <EQUAL? .WRD ,W?AND ,W?COMMA>
			      <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
			 ;"Next SETG 6/21/84 for WHICH retrofix"
			 <SETG P-AND T>
			 <COND (<NOT <GET-OBJECT <OR .BUT .TBL>>>
				<RFALSE>)>)
			(<WT? .WRD ,PS?BUZZ-WORD>)
			(<EQUAL? .WRD ,W?AND ,W?COMMA>)
			(<EQUAL? .WRD ,W?OF>
			 <COND (<ZERO? ,P-GETFLAGS>
				<SETG P-GETFLAGS ,P-INHIBIT>)>)
			(<AND <WT? .WRD ,PS?ADJECTIVE>
			      <ZERO? ,P-ADJ>
			      <NOT <EQUAL? .NW ,W?OF>>> ; "FIX #41"
			 <SETG P-ADJ .WRD>)
			(<WT? .WRD ,PS?OBJECT ;,P1?OBJECT>
			 <SETG P-NAM .WRD>
			 <SET ONEOBJ .WRD>)>)>
	   <COND (<NOT <EQUAL? .PTR .EPTR>>
		  <SET PTR <REST .PTR ,P-WORDLEN>>
		  <SET WRD .NW>)>>>   
 
<CONSTANT SH 128>   
<CONSTANT SC 64>    
<CONSTANT SIR 32>   
<CONSTANT SOG 16>
<CONSTANT STAKE 8>  
<CONSTANT SMANY 4>  
<CONSTANT SHAVE 2>  

<ROUTINE GET-OBJECT (TBL "OPT" (VRB T) 
		         "AUX" (GCHECK <>) (OLEN 0)
			        BTS LEN XBITS TLEN OBJ ADJ X XTBL
				TTBL TOBJ)
 <SET XBITS ,P-SLOCBITS>
 <SET TLEN <GET .TBL ,P-MATCHLEN>>
 <COND (<BTST ,P-GETFLAGS ,P-INHIBIT>
	<RTRUE>)>
 <SET ADJ ,P-ADJ>
 <COND (<AND <ZERO? ,P-NAM>
	     <T? ,P-ADJ>>
	<COND (<WT? ,P-ADJ ,PS?OBJECT>
	       <SETG P-NAM ,P-ADJ>
	       <SETG P-ADJ <>>)
	      (<SET BTS <WT? ,P-ADJ ,PS?DIRECTION ,P1?DIRECTION>>
	       <SETG P-ADJ <>>
	       <PUT .TBL ,P-MATCHLEN 1>
	       <PUT .TBL 1 ,INTDIR>
	       <SETG P-DIRECTION .BTS>
	       <RTRUE>)>)>
 <COND (<AND <ZERO? ,P-NAM>
	     <ZERO? ,P-ADJ>
	     <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>>
	     <ZERO? ,P-GWIMBIT>>
	<COND (<T? .VRB> 
	       <NOT-IN-SENTENCE "enough nouns">)>
	<RFALSE>)>
 <COND (<OR <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>>
	    <ZERO? ,P-SLOCBITS>>
	<SETG P-SLOCBITS -1>)>
 <SETG P-TABLE .TBL>
 <PROG ()
   <COND (<T? .GCHECK>
	  <GLOBAL-CHECK .TBL>)
	 (T
	  <DO-SL ,HERE ,SOG ,SIR>
	  <DO-SL ,WINNER ,SH ,SC>)>
   <SET LEN <- <GET .TBL ,P-MATCHLEN> .TLEN>>
   <COND (<BTST ,P-GETFLAGS ,P-ALL>)
	 (<AND <T? .LEN>
	       <BTST ,P-GETFLAGS ,P-ONE>>
	  <COND (<G? .LEN 1>
		 <PUT .TBL 1 <GET .TBL <RANDOM .LEN>>>
		 <TELL "[How about " THE <GET .TBL 1> "?]" CR>)>
	  <PUT .TBL ,P-MATCHLEN 1>)
	 (<OR <G? .LEN 1>
	      <AND <ZERO? .LEN>
		   <NOT <EQUAL? ,P-SLOCBITS -1>>>>
	  <COND (<EQUAL? ,P-SLOCBITS -1>
		 <SETG P-SLOCBITS .XBITS>
		 <SET OLEN .LEN>
		 <PUT .TBL ,P-MATCHLEN <- <GET .TBL ,P-MATCHLEN> .LEN>>
		 <AGAIN>)
		(T
		 <PUT ,P-NAMW ,P-PHR ,P-NAM>
		 <PUT ,P-ADJW ,P-PHR ,P-ADJ>
		 <COND (<ZERO? .LEN>
			<SET LEN .OLEN>)>
		 <COND (<AND <T? ,P-NAM>
			     <SET OBJ <GET .TBL <+ .TLEN 1>>>>
			<SET TTBL <REST .TBL <* .TLEN 2>>>
			<SET TOBJ <GET .TTBL 0>>
			<PUT .TTBL 0 .LEN>
			<SET OBJ <APPLY <GETP .OBJ ,P?GENERIC> .TTBL>>
			<PUT .TTBL 0 .TOBJ>
			<COND (<T? .OBJ> 
			       <COND (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
				      <RFALSE>)>
			       <SET X <+ .TLEN 1>>
			       <PUT .TBL .X ; <+ .TLEN 1> .OBJ>
			       <PUT .TBL ,P-MATCHLEN .X ; <+ .TLEN 1>>
			       <SETG P-NAM <>>
			       <SETG P-ADJ <>>
			       <RTRUE>)>)>
		 <COND (<AND <T? .VRB>
			     <NOT <EQUAL? ,WINNER ,PLAYER>>>
			<DONT-UNDERSTAND>
			<RFALSE>)
		       (<AND <T? .VRB>
			     <T? ,P-NAM>>
			<SET XTBL ,P-OCL2>
			<COND (<EQUAL? .TBL ,P-PRSO>
			       <SET XTBL ,P-OCL1>)>
			<COND (<VERB? NAME>
			       <MORE-SPECIFIC>)
			      (<G? <GET .XTBL 0> 22>
			       <PUT .XTBL 0 0>
			       <NYMPH-APPEARS>
			       <TELL 
"Parser overflow! Please try something else">
			       <PRINT 
". Bye!\"|  She disappears with a wink.|">)
			      (T
			       <WHICH-PRINT .TLEN .LEN .TBL>
			       <SETG P-ACLAUSE ,P-NC2>
			       <COND (<EQUAL? .TBL ,P-PRSO>
				      <SETG P-ACLAUSE ,P-NC1>)>
			       <SETG P-ANAM ,P-NAM>
			       <ORPHAN <> <>>
			       <SETG P-OFLAG T>)>)
		       (<T? .VRB>
			<NOT-IN-SENTENCE "enough nouns">)>
		 <SETG P-NAM <>>
		 <SETG P-ADJ <>>
		 <RFALSE>)>)
	 (<T? ,P-OFLAG>
	  <RFALSE>)
	 (<AND <ZERO? .LEN>
	       <T? .GCHECK>>
	  <PUT ,P-NAMW ,P-PHR ,P-NAM>
	  <PUT ,P-ADJW ,P-PHR ,P-ADJ>
	  <COND (<T? .VRB>
		 <SETG P-SLOCBITS .XBITS> ; "RETROFIX #33"
		 <OBJ-FOUND ,NOT-HERE-OBJECT .TBL>
		 <SETG P-XNAM ,P-NAM>
		 <SETG P-NAM <>>
		 <SETG P-XADJ ,P-ADJ>
		 <SETG P-ADJ <>>
		 <COND (<ZERO? ,LIT?>
			<TOO-DARK>)>
		 <RTRUE>)>
	  <SETG P-NAM <>>
	  <SETG P-ADJ <>>
	  <RFALSE>)
	 (<ZERO? .LEN>
	  <SET GCHECK T>
	  <AGAIN>)>
   <SET X <GET .TBL <+ .TLEN 1>>>
   <COND (<AND <T? ,P-ADJ>
	       <ZERO? ,P-NAM>
	       <T? .X>>
	  <TELL "[" THE .X ,BRACKET>)>
   <SETG P-SLOCBITS .XBITS>
   <PUT ,P-NAMW ,P-PHR ,P-NAM>
   <PUT ,P-ADJW ,P-PHR ,P-ADJ>
   <SETG P-NAM <>>
   <SETG P-ADJ <>>
   <RTRUE>>>

<GLOBAL P-MOBY-FOUND <>>

; <GLOBAL P-MOBY-FLAG <>> ; "Needed only for ZIL"

"This MOBY-FIND works in ZIP only!"

<CONSTANT LAST-OBJECT:OBJECT 0>

<ROUTINE MOBY-FIND (TBL "AUX" OBJ LEN NAM ADJ X)
  	 <SET OBJ 1>
	 <SET NAM ,P-NAM>
	 <SET ADJ ,P-ADJ>
	 <SETG P-NAM ,P-XNAM>
	 <SETG P-ADJ ,P-XADJ>
	 <PUT .TBL ,P-MATCHLEN 0>
	 <REPEAT ()
		 <COND (<AND <NOT <IN? .OBJ ,ROOMS>>
			     <THIS-IT? .OBJ>>
			<OBJ-FOUND .OBJ .TBL>)>
		 <COND (<IGRTR? OBJ ,LAST-OBJECT>
			<RETURN>)>>
	 <SET LEN <GET .TBL ,P-MATCHLEN>>
	 <COND (<EQUAL? .LEN 1>
		<SETG P-MOBY-FOUND <GET .TBL 1>>)>
	 <SETG P-NAM .NAM>
	 <SETG P-ADJ .ADJ>
	 <RETURN .LEN>>

"This MOBY-FIND works in both ZIL and ZIP."

; <ROUTINE MOBY-FIND (TBL "AUX" (OBJ 1) LEN FOO NAM ADJ)
  <SET NAM ,P-NAM>
  <SET ADJ ,P-ADJ>
  <SETG P-NAM ,P-XNAM>
  <SETG P-ADJ ,P-XADJ>
; <COND (<T? ,DEBUG>
	 <TELL "[MOBY-FIND called, P-NAM = " B ,P-NAM "]" CR>)>
  <PUT .TBL ,P-MATCHLEN 0>
  %<COND (<GASSIGNED? ZILCH> ; "ZIP case"
	 '<PROG ()
	 <REPEAT ()
		 <COND (<AND ; <SET FOO <META-LOC .OBJ T>>
			     <NOT <IN? .OBJ ,ROOMS>>
			     <SET FOO <THIS-IT? .OBJ>>>
			<SET FOO <OBJ-FOUND .OBJ .TBL>>)>
		 <COND (<IGRTR? OBJ ,LAST-OBJECT>
			<RETURN>)>>>)
	(T		;"ZIL case"
	 '<PROG ()
	 <SETG P-SLOCBITS -1>
	 <COND (<SET FOO <FIRST? ,ROOMS>>
		<REPEAT ()
			<SEARCH-LIST .FOO .TBL ,P-SRCALL T>
			<COND (<NOT <SET FOO <NEXT? .FOO>>>
			       <RETURN>)>>)>
	 <DO-SL ,LOCAL-GLOBALS 1 1 .TBL T>
	 <SEARCH-LIST ,ROOMS .TBL ,P-SRCTOP T>>)>
  <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 1>
	 <SETG P-MOBY-FOUND <GET .TBL 1>>)>
  <SETG P-NAM .NAM>
  <SETG P-ADJ .ADJ>
  <RETURN .LEN>>

<GLOBAL WHICH-PRINTING:FLAG <>>

<ROUTINE WHICH-PRINT (TLEN LEN TBL "AUX" OBJ RLEN)
	 <SET RLEN .LEN>
	 <TELL "[Which">
         <COND (<OR <T? ,P-OFLAG>
		    <T? ,P-MERGED>
		    <T? ,P-AND>>
		<PRINTC ,SP>
		<COND (<T? ,P-LASTADJ>
		       <TELL B ,P-LASTADJ C ,SP>)>
		<PRINTB ,P-NAM>)
	       (<EQUAL? .TBL ,P-PRSO>
		<CLAUSE-PRINT ,P-NC1 ,P-NC1L <>>)
	       (T
		<CLAUSE-PRINT ,P-NC2 ,P-NC2L <>>)>
	 <TELL " do you mean,">
	 <SETG WHICH-PRINTING T>
	 <REPEAT ()
	    <INC TLEN>
	    <SET OBJ <GET .TBL .TLEN>>
	    <TELL C ,SP THE .OBJ>
	    <COND (<EQUAL? .LEN 2>
		   <COND (<NOT <EQUAL? .RLEN 2>>
			  <TELL ",">)>
		   <TELL " or">)
		  (<G? .LEN 2>
		   <TELL ",">)>
	    <COND (<DLESS? LEN 1>
		   <RETURN>)>>
	 <SETG WHICH-PRINTING <>>
	 <TELL "?]" CR>
	 <RTRUE>>

<GLOBAL LAST-PSEUDO-LOC:OBJECT <>>

<GLOBAL P-PNAM <>>
<GLOBAL P-PADJN <>>

<GLOBAL PSEUDO-PRSO?:FLAG <>> "T if original PRSO was PSEUDO-OBJECT."

<OBJECT PSEUDO-OBJECT
	(LOC GLOBAL-OBJECTS)
	(DESC "that")
	(SDESC DESCRIBE-PSEUDO-OBJECT)
	(FLAGS NODESC NOARTICLE NOALL)
	(ACTION ME-F)>

<ROUTINE DESCRIBE-PSEUDO-OBJECT (OBJ)
	 <COND (<AND <T? ,P-PNAM>
		     <HERE? LAST-PSEUDO-LOC>>
		<PRINTB ,P-PNAM>
		<RTRUE>)>
	 <PRINTD ,PSEUDO-OBJECT>
	 <RTRUE>>

<ROUTINE GLOBAL-CHECK (TBL "AUX" LEN RMG RMGL (CNT 0) OBJ OBITS X) 
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<SET OBITS ,P-SLOCBITS>
	<SET RMG <GETPT ,HERE ,P?GLOBAL>>
	<COND (<T? .RMG>
	       <SET RMGL <RMGL-SIZE .RMG>>
	       <REPEAT ()
		       <SET OBJ <GET/B .RMG .CNT>>
		       <COND (<SET X <FIRST? .OBJ>>
			      <SEARCH-LIST .OBJ .TBL ,P-SRCALL>)>
		       <COND (<THIS-IT? .OBJ>
			      <OBJ-FOUND .OBJ .TBL>)>
		       <COND (<IGRTR? CNT .RMGL>
			      <RETURN>)>>)>
	<SET RMG <GETP ,HERE ,P?THINGS>>
	<COND (<T? .RMG>
	       <SET RMGL <GET .RMG 0>>
	       <SET CNT 0>
	       <REPEAT ()
		       <COND (<AND <EQUAL? ,P-NAM <GET .RMG <+ .CNT 1>>>
				   <OR <ZERO? ,P-ADJ>
				       <EQUAL? ,P-ADJ ; ,P-ADJN
					       <GET .RMG <+ .CNT 2>>>>>
			      <SETG P-PNAM ,P-NAM>
			      <COND (<T? ,P-ADJ>
				     <SETG P-PADJN ,P-ADJ ; ,P-ADJN>)
				    (T
				     <SETG P-PADJN <>>)>
			      <SETG LAST-PSEUDO-LOC ,HERE>
			      <UNMAKE ,PSEUDO-OBJECT ,NOARTICLE>
			      <PUTP ,PSEUDO-OBJECT
				    ,P?ACTION
				    <GET .RMG <+ .CNT 3>>>
			    ; <SET FOO
				   <BACK <GETPT ,PSEUDO-OBJECT ,P?ACTION> 5>>
			    ; <PUT .FOO 0 <GET ,P-NAM 0>>
			    ; <PUT .FOO 1 <GET ,P-NAM 1>>
			      <OBJ-FOUND ,PSEUDO-OBJECT .TBL>
			      <RETURN>)>
		       <SET CNT <+ .CNT 3>>
		       <COND (<NOT <L? .CNT .RMGL>>
			      <RETURN>)>>)>
	<COND (<EQUAL? <GET .TBL ,P-MATCHLEN> .LEN>
	       <SETG P-SLOCBITS -1>
	       <SETG P-TABLE .TBL>
	       <DO-SL ,GLOBAL-OBJECTS 1 1>
	       <SETG P-SLOCBITS .OBITS>
	     ; <COND (<ZERO? <GET .TBL ,P-MATCHLEN>>
		      <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE FIND FOLLOW
				    LEAVE SEARCH SMELL WALK-TO THROUGH
				    WAIT-FOR>
			     <DO-SL ,ROOMS 1 1>)>)>)>>

<CONSTANT P-SRCTOP 0>
<CONSTANT P-SRCALL 1>
<CONSTANT P-SRCBOT 2>

<ROUTINE DO-SL (OBJ BIT1 BIT2)
	<COND (<BTST ,P-SLOCBITS <+ .BIT1 .BIT2>>
	       <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCALL>)
	      (T
	       <COND (<BTST ,P-SLOCBITS .BIT1>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCTOP>)
		     (<BTST ,P-SLOCBITS .BIT2>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCBOT>)
		     (T
		      <RTRUE>)>)>>  

<ROUTINE SEARCH-LIST (OBJ TBL LVL "AUX" X)
	 <COND (<SET OBJ <FIRST? .OBJ>>
		<REPEAT ()
		   <COND (<AND <NOT <EQUAL? .LVL ,P-SRCBOT>>
			       <THIS-IT? .OBJ>>
			  <OBJ-FOUND .OBJ .TBL>)>
		   <COND (<AND ; <NOT <EQUAL? .LVL ,P-SRCTOP>>
			       <NOT <EQUAL? .OBJ ,WINNER ,LOCAL-GLOBALS
					    ,GLOBAL-OBJECTS>>
			       <SET X <FIRST? .OBJ>>
			       <SEE-INSIDE? .OBJ>
			     ; <SEE-ANYTHING-IN? .OBJ>>
			  <SET X ,P-SRCTOP>
			  <COND (<IS? .OBJ ,SURFACE>
				 <SET X ,P-SRCALL>)>
			  <SEARCH-LIST .OBJ .TBL .X>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <RFALSE>>

<ROUTINE THIS-IT? (OBJ "AUX" TBL LEN)
	 <COND (<AND <T? ,P-NAM>
		     <OR <NOT <SET TBL <GETPT .OBJ ,P?SYNONYM>>>
			 <NOT <SET LEN </ <PTSIZE .TBL> 2>>>
			 <NOT <SET LEN <INTBL? ,P-NAM .TBL .LEN>>>>>
		<RFALSE>)
	       (<AND <T? ,P-ADJ>
		     <OR <NOT <SET TBL <GETPT .OBJ ,P?ADJECTIVE>>>
			 <NOT <SET LEN </ <PTSIZE .TBL> 2>>>
			 <NOT <SET LEN <INTBL? ,P-ADJ .TBL .LEN>>>>>
		<RFALSE>)
	       (<AND <T? ,P-GWIMBIT>
		     <NOT <IS? .OBJ ,P-GWIMBIT>>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE OBJ-FOUND (OBJ TBL "AUX" PTR) 
	 <SET PTR <GET .TBL ,P-MATCHLEN>>
	 <INC PTR>
	 <PUT .TBL .PTR .OBJ>
	 <PUT .TBL ,P-MATCHLEN .PTR>
	 <RFALSE>> 
 
; <ROUTINE TAKE-CHECK () 
	 <COND (<AND <ITAKE-CHECK ,P-PRSO <GETB ,P-SYNTAX ,P-SLOC1>>
		     <ITAKE-CHECK ,P-PRSI <GETB ,P-SYNTAX ,P-SLOC2>>>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<ROUTINE ITAKE-CHECK (TBL BITS "AUX" PTR LEN OBJ L GOT-IT TOOK-IT)
	 <SET PTR 1>
	 <SET LEN <GET .TBL ,P-MATCHLEN>>
	 <COND (<ZERO? .LEN>
		<RTRUE>)
	       (<OR <BTST .BITS ,SHAVE>
		    <BTST .BITS ,STAKE>>
		<REPEAT ()
		   <SET OBJ <GET .TBL .PTR>>
		   <COND (<EQUAL? .OBJ ,IT>
			  <COND (<NOT <ACCESSIBLE? ,P-IT-OBJECT>>
				 <MORE-SPECIFIC>
				 <RFALSE>)>
			  <SET OBJ ,P-IT-OBJECT>)
			 (<EQUAL? .OBJ ,THEM>
			  <COND (<NOT <ACCESSIBLE? ,P-THEM-OBJECT>>
				 <MORE-SPECIFIC>
				 <RFALSE>)>
			  <SET OBJ ,P-THEM-OBJECT>)
			 (<EQUAL? .OBJ ,HER>
			  <COND (<NOT <ACCESSIBLE? ,P-HER-OBJECT>>
				 <MORE-SPECIFIC>
				 <RFALSE>)>
			  <SET OBJ ,P-HER-OBJECT>)
			 (<EQUAL? .OBJ ,HIM>
			  <COND (<NOT <ACCESSIBLE? ,P-HIM-OBJECT>>
				 <MORE-SPECIFIC>
				 <RFALSE>)>
			  <SET OBJ ,P-HIM-OBJECT>)>
		   <COND (<AND <NOT <EQUAL? .OBJ ,WINNER ,HANDS ,FEET>>
			       <NOT <EQUAL? .OBJ ,ME ,YOU ,ROOMS>>
			       <NOT <EQUAL? .OBJ ,INTDIR ,RIGHT ,LEFT>>
			       <NOT <EQUAL? .OBJ ,MONEY>>
			       <NOT <HELD? .OBJ>>
			     ; <NOT <IN? .OBJ ,WINNER>>>
			  <SETG PRSO .OBJ>
			  <SET L <LOC .OBJ>>
			  <SET GOT-IT 0>
			  <SET TOOK-IT 0>
			  <COND (<ZERO? .L>)
				(<AND <IS? .OBJ ,TRYTAKE>
				      <NOT <IS? .OBJ ,TAKEABLE>>>
				 <COND (<AND <BTST .BITS ,SHAVE>
					     <IN? .L ,WINNER>>
					<INC GOT-IT>)>)
			      ; (<NOT <EQUAL? ,WINNER ,PLAYER>>)
				(<AND <ZERO? ,P-MULT?>
				    ; <BTST .BITS ,STAKE>
				      <IN? .L ,WINNER>
				    ; <OR <IN? .L ,WINNER>
					  <IN? ,WINNER .L>>
				      <ITAKE <>>>
				 <INC GOT-IT>
				 <INC TOOK-IT>)
			        (<AND <EQUAL? .L ,WINNER>
				      <BTST .BITS ,SHAVE>>
				 <INC GOT-IT>)>
			  <COND (<AND <ZERO? .GOT-IT>
				      <BTST .BITS ,SHAVE>>
				 <WINNER-NOT-HOLDING>
				 <COND (<AND <EQUAL? .LEN .PTR>
					     <T? ,P-MULT?>>
					<TELL "all of those things">)
				       (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
					<THIS-IS-IT .OBJ>
					<TELL D .OBJ>)
				       (T
					<THIS-IS-IT .OBJ>
					<COND (<IS? .OBJ ,PLURAL>
					       <TELL "any ">)
					      (<NOT <IS? .OBJ ,NOARTICLE>>
					       <COND (<IS? .OBJ ,PROPER>
						      <TELL ,LTHE>)
						     (<IS? .OBJ ,VOWEL>
						      <TELL "an ">)
						     (T
						      <TELL "a ">)>)>
					<TELL D .OBJ>)>
				 <PRINT ,PERIOD>
				 <RFALSE>)
				(<AND <T? .GOT-IT>
				      <T? .TOOK-IT>
				    ; <BTST .BITS ,STAKE>
				      <EQUAL? ,WINNER ,PLAYER>>
				 <TAKING-OBJ-FIRST .OBJ>)>)>
		   <COND (<IGRTR? PTR .LEN>
			  <RTRUE>)>>)>
	 <RTRUE>>
			
<ROUTINE HELD? ("OPT" (OBJ ,PRSO) "AUX" L)
	 <COND (<ZERO? .OBJ>
		<RFALSE>)
	       (<IS? .OBJ ,TAKEABLE>)
	       (<NOT <IS? .OBJ ,TRYTAKE>>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<EQUAL? .L <> ,ROOMS ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER>
		<RTRUE>)>
	 <RETURN <HELD? .L>>>

<ROUTINE TAKING-OBJ-FIRST (OBJ "AUX" L)
	 <SET L <LOC .OBJ>>
	 <TELL "[taking " THE .OBJ>
	 <COND (<NOT <EQUAL? .L ,HERE <LOC ,WINNER> <>>>
		<OUT-OF-LOC .L>)>
	 <TELL " first" ,BRACKET>
	 <SPARK? <> .OBJ>
	 <RFALSE>>

; <ROUTINE ITAKE-CHECK (TBL BITS "AUX" PTR OBJ TAKEN L) 
 <SET PTR <GET .TBL ,P-MATCHLEN>>
 <COND (<AND <T? .PTR>
	     <OR <BTST .BITS ,SHAVE>
		 <BTST .BITS ,STAKE>>>
	<REPEAT ()
	 <COND (<DLESS? PTR 0>
		<RETURN>)>
       ; <COND (<L? <DEC PTR> 0>
		<RETURN>)>
	 <SET OBJ <GET .TBL <+ .PTR 1>>>
	 <COND (<EQUAL? .OBJ ,IT>
		<COND (<NOT <ACCESSIBLE? ,P-IT-OBJECT>>
		       <MORE-SPECIFIC>
		       <RFALSE>)
		      (T
		       <SET OBJ ,P-IT-OBJECT>)>)
	       (<EQUAL? .OBJ ,HER>
		<COND (<NOT <ACCESSIBLE? ,P-HER-OBJECT>>
		       <MORE-SPECIFIC>
		       <RFALSE>)
		      (T
		       <SET OBJ ,P-HER-OBJECT>)>)
	       (<EQUAL? .OBJ ,HIM>
		<COND (<NOT <ACCESSIBLE? ,P-HIM-OBJECT>>
		       <MORE-SPECIFIC>
		       <RFALSE>)
		      (T
		       <SET OBJ ,P-HIM-OBJECT>)>)
	       (<EQUAL? .OBJ ,THEM>
		<COND (<NOT <ACCESSIBLE? ,P-THEM-OBJECT>>
		       <MORE-SPECIFIC>
		       <RFALSE>)
		      (T
		       <SET OBJ ,P-THEM-OBJECT>)>)>
	 <COND (<AND <NOT <HELD? .OBJ>>
		     <NOT <EQUAL? .OBJ ,HANDS ,FEET>>>
		<SETG PRSO .OBJ>
		<SET L <LOC .OBJ>>
		<COND (<ZERO? .L>
		       <SET TAKEN T>)
		      (<AND <IS? .OBJ ,TRYTAKE>
			    <NOT <IS? .OBJ ,TAKEABLE>>>
		       <SET TAKEN T>)
		      (<NOT <EQUAL? ,WINNER ,PLAYER>>
		       <SET TAKEN <>>)
		      (<AND <BTST .BITS ,STAKE>
			    <IN? .L ,WINNER>
			    <ZERO? ,P-MULT?>
			    <ITAKE <>>>
		       <SET TAKEN <>>)
		      (<AND <BTST .BITS ,SHAVE>
			    <EQUAL? .L ,WINNER>>
		       <SET TAKEN <>>)
		      (T
		       <SET TAKEN T>)>
		<COND (<AND <T? .TAKEN>
			    <BTST .BITS ,SHAVE>>
		       <WINNER-NOT-HOLDING>
		       <COND (<L? 1 <GET .TBL ,P-MATCHLEN>>
			      <TELL "all of those things">)
			     (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
			      <TELL D ,NOT-HERE-OBJECT>)
			     (T
			      <THIS-IS-IT .OBJ>
			      <COND (<IS? .OBJ ,PLURAL>
				     <TELL "any ">)
				    (<NOT <IS? .OBJ ,NOARTICLE>>
				     <TELL ,LTHE>)>
			      <TELL D .OBJ>)>
		       <PRINT ,PERIOD>
		       <RFALSE>)
		      (<AND <ZERO? .TAKEN>
			    <EQUAL? ,WINNER ,PLAYER>>
		       <TELL "[taking " THEO>
		       <COND (<T? .L>
			      <OUT-OF-LOC .L>)>
		       <TELL " first" ,BRACKET>
		       <SPARK? <>>)>)>>)
       (T
	<RTRUE>)>>  

<ROUTINE MANY-CHECK ("AUX" (LOSS <>) TMP) 
	<COND (<AND <G? <GET ,P-PRSO ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC1> ,SMANY>>>
	       <SET LOSS 1>)
	      (<AND <G? <GET ,P-PRSI ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC2> ,SMANY>>>
	       <SET LOSS 2>)>
	<COND (<T? .LOSS>
	       <PRINTC %<ASCII !\[>>
	       <TELL ,CANT "refer to more than one object at a time with \"">
	       <SET TMP <GET ,P-ITBL ,P-VERBN>>
	       <COND (<ZERO? .TMP>
		      <TELL B ,W?TELL>)
		     (<OR <T? ,P-OFLAG>
			  <T? ,P-MERGED>>
		      <PRINTB <GET .TMP 0>>)
		     (T
		      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
	       <TELL ".\"]" CR>
	       <RFALSE>)
	      (T
	       <RTRUE>)>>
 
<ROUTINE SAY-IF-HERE-LIT ()
	 <SETG LIT? <IS-LIT?>>
	 <COND (<ZERO? ,LIT?>
		<SETG P-CONT <>>
		<SETG OLD-HERE <>>
		<SETG P-WALK-DIR <>>
		<RELOOK T>)>
	 <RTRUE>>

<ROUTINE LIGHT-ROOM-WITH (SOURCE)
	 <MAKE .SOURCE ,LIGHTED>
	 <REPLACE-ADJ? .SOURCE ,W?DARK ,W?LIGHTED>
	 <COND (<T? ,LIT?>
	        <RFALSE>)
	       (<VISIBLE? .SOURCE>		
		<SETG LIT? T>
		<SETG P-CONT <>>
		<SETG OLD-HERE <>>
		<CRLF>
		<V-LOOK>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IS-LIT? ("OPT" (RM ,HERE) (RMBIT T) "AUX" (LIT 0) OHERE)
	<COND (<AND <T? ,ALWAYS-LIT?>
		    <EQUAL? ,WINNER ,PLAYER>>
	       <RTRUE>)>
	<SETG P-GWIMBIT ,LIGHTED>
	<SET OHERE ,HERE>
	<SETG HERE .RM>
	<COND (<AND <T? .RMBIT>
		    <IS? .RM ,LIGHTED>>
	       <INC LIT>)
	      (T
	       <PUT ,P-MERGE ,P-MATCHLEN 0>
	       <SETG P-TABLE ,P-MERGE>
	       <SETG P-SLOCBITS -1>
	       <COND (<EQUAL? .OHERE .RM>
		      <DO-SL ,WINNER 1 1>
		      <COND (<AND <NOT <EQUAL? ,WINNER ,PLAYER>>
				  <IN? ,PLAYER .RM>>
			     <DO-SL ,PLAYER 1 1>)>)>
	       <DO-SL .RM 1 1>
	       <COND (<G? <GET ,P-TABLE ,P-MATCHLEN> 0>
		      <INC LIT>)>)>
	<SETG HERE .OHERE>
	<SETG P-GWIMBIT 0>
	<RETURN .LIT>>

<ROUTINE DONT-HAVE? ("OPT" (OBJ ,PRSO) "AUX" L O)
	 <SET L <LOC .OBJ>>
	 <COND (<ZERO? .L>)
	       (<EQUAL? .L ,WINNER>
		<RFALSE>)
	       (<AND <IN? .L ,PLAYER>
		     <EQUAL? ,WINNER ,PLAYER>>
	      	<SET O ,PRSO>
		<SETG PRSO .OBJ>
		<COND (<ITAKE <>>
		       <TELL "[taking " THEO>
		       <OUT-OF-LOC .L>
		       <TELL " first" ,BRACKET>
		       <SPARK? <>>
		       <SETG PRSO .O>
		       <THIS-IS-IT ,PRSO>
		       <RFALSE>)>
		<SETG PRSO .O>
		<TAKE-FIRST .OBJ .L>
		<RTRUE>)>
	 <WINNER-NOT-HOLDING>
	 <COND (<T? .OBJ>
		<COND (<IS? .OBJ ,PLURAL>
		       <TELL "any ">)>
		<TELL THE .OBJ>)
	       (T
		<TELL D ,NOT-HERE-OBJECT>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE TAKE-FIRST (OBJ1 OBJ2)
	 <TELL "You'd have to take " THE .OBJ1>
	 <OUT-OF-LOC .OBJ2>
	 <TELL ,SFIRST>
	 <RTRUE>>

<ROUTINE OUT-OF-LOC (L)
	 <TELL C ,SP>
	 <COND (<EQUAL? .L ,HERE>
		<TELL "off the ">
		<GROUND-WORD>
		<RTRUE>)>
	 <COND (<EQUAL? .L ,PLAYER>
		<TELL "away from you">
		<RTRUE>)
	       (<IS? .L ,LIVING>
		<TELL "away from">)
	       (<EQUAL? .L ,ARCH>
		<TELL "out from under">)
	       (<IS? .L ,CONTAINER>
		<TELL "out of">)
	       (<IS? .L ,SURFACE>
		<TELL B ,W?OFF>)
	       (T
		<TELL B ,W?FROM>)>
	 <TELL C ,SP THE .L>
	 <RTRUE>>

<ROUTINE SAY-WHERE (L)
	 <COND (<EQUAL? .L ,PLAYER>
		<TELL "in " 'HANDS "s">
		<RTRUE>)
	       (<EQUAL? .L ,HERE>
		<TELL "in front of you">
		<RTRUE>)
	       (<EQUAL? .L ,MCASE ,BCASE ,WCASE>
		<TELL B ,W?IN>)
	       (<IS? .L ,SURFACE>
		<TELL B ,W?ON>)
	       (<IS? .L ,CONTAINER>
		<TELL B ,W?IN>)
	       (T
		<TELL B ,W?WITH>)>
	 <TELL C ,SP THE .L>
	 <RTRUE>>

<ROUTINE WINNER-NOT-HOLDING ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You're not holding ">
		<RTRUE>)>
	 <TELL CTHE ,WINNER " do">
	 <COND (<NOT <IS? ,WINNER ,PLURAL>>
		<TELL "es">)>
	 <TELL "n't have ">
	 <RTRUE>>

<OBJECT NOT-HERE-OBJECT
	(DESC "that")
	(FLAGS NODESC NOARTICLE)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" (PRSO? T) TBL OBJ LEN)
	 <COND (<AND <PRSO? NOT-HERE-OBJECT>
		     <PRSI? NOT-HERE-OBJECT>>
		<TELL "Those things aren't here." CR>
		<RTRUE>)
	       (<PRSO? NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	       
	<COND (<T? .PRSO?>
		<COND (<VERB? ; WALK-TO ; FOLLOW FIND WHO WHAT WHERE BUY
			      WAIT-FOR ; PHONE>
		       <SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		       <COND (<T? .OBJ>
			      <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
				     <RFATAL>)>)
			     (T
			      <RFALSE>)>)>)
	       (T
		<COND (<VERB? TELL-ABOUT ASK-ABOUT ASK-FOR>
		       <SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		       <COND (<T? .OBJ>
			      <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
				     <RFATAL>)>)
			     (T
			      <RFALSE>)>)>)>
	 
	 <TELL ,CANT>
	 <COND (<VERB? LISTEN>
		<TELL B ,W?HEAR>)
	       (<VERB? SMELL>
		<TELL B ,W?SMELL>)
	       (T
		<TELL B ,W?SEE>)>
	 <SET LEN <GET ,CAPS 0>>
	 <COND (<NOT <SET LEN <INTBL? ,P-XNAM <REST ,CAPS 2> .LEN>>>
		<TELL " any">)>
	 <NOT-HERE-PRINT .PRSO?>
	 <TELL " here." CR>
	 <PCLEAR>
	 <RFATAL>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	<SET M-F <MOBY-FIND .TBL>>
	<COND (<EQUAL? .M-F 1>
	       <COND (<T? .PRSO?>
		      <SETG PRSO ,P-MOBY-FOUND>
		      <RFALSE>)>
	       <SETG PRSI ,P-MOBY-FOUND>
	       <RFALSE>)
	      (<AND <G? .M-F 1>
		    <SET OBJ <GET .TBL 1>>
		    <SET OBJ <APPLY <GETP .OBJ ,P?GENERIC> .TBL>>>
	       <COND (<EQUAL? .OBJ <> ,NOT-HERE-OBJECT>
		      <RTRUE>)
		     (<T? .PRSO?>
		      <SETG PRSO .OBJ>
		      <RFALSE>)>
	       <SETG PRSI .OBJ>
	       <RFALSE>)
	      (<VERB? ASK-ABOUT TELL-ABOUT ASK-FOR WHO WHAT WHERE
		      FIND FOLLOW TELL>
	       <RFALSE>)
	      (<ZERO? .PRSO?>
	       <TELL "You wouldn't find any">
	       <NOT-HERE-PRINT .PRSO?>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T
	       <RETURN ,NOT-HERE-OBJECT>)>>

<ROUTINE NOT-HERE-PRINT ("OPT" (PRSO? <>) "AUX" X)
	 <COND (<OR <T? ,P-OFLAG>
		    <T? ,P-MERGED>>
	        <COND (<T? ,P-XADJ>
		       <TELL C ,SP B ,P-XADJ>)>
	        <COND (<T? ,P-XNAM>
		       <TELL C ,SP B ,P-XNAM>)>
		<RFALSE>)
               (<T? .PRSO?>
	        <SET X <GET ,P-ITBL ,P-NC1>>
		<BUFFER-PRINT .X <GET ,P-ITBL ,P-NC1L> <>>
		<RFALSE>)
               (T
	        <SET X <GET ,P-ITBL ,P-NC2>>
		<BUFFER-PRINT .X <GET ,P-ITBL ,P-NC2L> <>>
		<RFALSE>)>>

<OBJECT C-OBJECT>

<ROUTINE CONTENTS ("OPT" (THING ,PRSO) (SAY-OR <>)
		   "AUX" OBJ NXT (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET OBJ <FIRST? .THING>>
		<REPEAT ()
		   <SET NXT <NEXT? .OBJ>>
		   <COND (<OR <EQUAL? .OBJ ,WINNER>
			      <IS? .OBJ ,NODESC>>
			  <MOVE .OBJ ,C-OBJECT>)>
		   <SET OBJ .NXT>
		   <COND (<ZERO? .OBJ>
			  <RETURN>)>>)>
	 <SET OBJ <FIRST? .THING>>
	 <COND (<ZERO? .OBJ>
		<TELL "nothing " <PICK-NEXT ,YAWNS>>)
	       (T
		<REPEAT ()
		        <COND (<T? .OBJ>
		               <SET NXT <NEXT? .OBJ>>
		               <COND (<T? .1ST?>
			              <SET 1ST? <>>)
			             (T
			              <COND (<T? .NXT>
				             <TELL ", ">)
				            (<T? .SAY-OR>
					     <TELL " or ">)
					    (T
				             <TELL ,AND>)>)>
		               <SETG DESCING .OBJ>
			       <TELL A .OBJ>
			       <COND (<AND <EQUAL? .OBJ ,GOBLET>
					   <IN? ,BFLY .OBJ>
					   <IS? ,BFLY ,LIVING>>
				      <TELL ,WITH A ,BFLY>
				      <PRINT " resting on the rim">)>
			       <COND (<AND <EQUAL? .THING ,WINNER>
					   <IS? .OBJ ,WIELDED>>
				      <TELL " (wielded)">)>
			     ; <COND (<IS? .OBJ ,LIGHTED>
				      <TELL " (providing light)">)>
			       <COND (<AND <ZERO? .IT?>
				           <ZERO? .TWO?>>
			              <SET IT? .OBJ>)
			             (T
			              <SET TWO? T>
			              <SET IT? <>>)>
		               <SET OBJ .NXT>)
			      (T
		               <COND (<AND <T? .IT?>
				           <ZERO? .TWO?>>
			              <THIS-IS-IT .IT?>)>
		               <RETURN>)>>)>
	 <SETG DESCING <>>
	 <MOVE-ALL ,C-OBJECT .THING>
	 <RTRUE>>

<ROUTINE MOVE-ALL (FROM TO "OPT" EXCEPT "AUX" OBJ NXT)
	 <COND (<SET OBJ <FIRST? .FROM>>
		<REPEAT ()
		   <SET NXT <NEXT? .OBJ>>
		   <COND (<OR <NOT <ASSIGNED? EXCEPT>>
			      <NOT <IS? .OBJ .EXCEPT>>>
			  <MOVE .OBJ .TO>)>
		   <SET OBJ .NXT>
		   <COND (<ZERO? .OBJ>
			  <RTRUE>)>>)>
	 <RFALSE>>

"Note that the object to be searched is the FIRST parameter expected in this
 version of GLOBAL-IN? ... allowing optional target objects."

<ROUTINE GLOBAL-IN? (SOURCE OBJ1 "OPT" OBJ2 OBJ3 "AUX" LEN X)
	 <SET SOURCE <GETPT .SOURCE ,P?GLOBAL>>
	 <COND (<ZERO? .SOURCE>
		<RFALSE>)>
	 <SET LEN </ <PTSIZE .SOURCE> 2>>
	 <COND (<SET X <INTBL? .OBJ1 .SOURCE .LEN>>
		<RTRUE>)
	       (<NOT <ASSIGNED? OBJ2>>
		<RFALSE>)
	       (<SET X <INTBL? .OBJ2 .SOURCE .LEN>>
		<RTRUE>)
	       (<NOT <ASSIGNED? OBJ3>>
		<RFALSE>)
	       (<SET X <INTBL? .OBJ3 .SOURCE .LEN>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TBL)
	 <SET TBL <GETPT .OBJ2 ,P?GLOBAL>>
	 <COND (<T? .TBL>
	        <INTBL? .OBJ1 .TBL </ <PTSIZE .TBL> 2>>
	      ; <ZMEMQ .OBJ1 .TBL <RMGL-SIZE .TBL>>)>>

<CONSTANT AUX-TABLE-LENGTH 82>
<GLOBAL AUX-TABLE:TABLE <ITABLE ,AUX-TABLE-LENGTH (BYTE) 0>>

<ROUTINE READ-LEXV ("AUX" KEY TBL LEN ILEN X Y CNT PTR DEST OFFSET
		    	  PAGE-SIZE LAST-PAGE)
	 <SET PAGE-SIZE <- ,DHEIGHT 2>>
	 <SET LAST-PAGE <- ,MAX-HEIGHT ,DHEIGHT>>
	 <COPYT ,P-INBUF 0 ,P-INBUF-LENGTH>
	 <PUTB ,P-INBUF 0 %<- ,P-INBUF-LENGTH 2>>
	 <COPYT ,P-LEXV 0 ,P-LEXV-LENGTH>
	 <PUTB ,P-LEXV 0 ,LEXMAX>
	 
	 
	 <REPEAT ()
	    <COLOR ,INCOLOR ,BGND>
	    <SET KEY <READ ,P-INBUF 0>>
	    <COND (<EQUAL? .KEY ,EOL ,LF>
		   <DO-LEX>
		   <RFALSE>)>
	    <SET TBL <>>
	    <SET ILEN <GETB ,P-INBUF 1>>
	    <SET DEST <REST ,P-INBUF <+ .ILEN 2>>>
	    <SET OFFSET 0>
	    <COND (<AND <G? .KEY ,PAD0>
			<L? .KEY %<+ ,PAD9 1>>>
		   <SET TBL <KEYPAD .KEY>>
		   <COND (<ZERO? .TBL>
			  <SOUND ,S-BOOP>
			  <AGAIN>)>)
		  (<ZERO? ,DMODE>)
		  (<EQUAL? .KEY ,CLICK1 ,CLICK2>
		   <SET Y <LOWCORE MSLOCY>>
		   <SET X <LOWCORE MSLOCX>>
		   <COND (<G? ,CWIDTH 1>
			  <DEC X>
			  <SET X </ .X ,CWIDTH>>
			  <INC X>)>
		   <COND (<G? ,CHEIGHT 1>
			  <DEC Y>
			  <SET Y </ .Y ,CHEIGHT>>
			  <INC Y>)>
		   <COND (<G? .Y %<+ ,MHEIGHT 1>>
			  <AGAIN>)
			 (<L? .X ,MOUSEDGE>
			  <AGAIN>)>
		   <SET TBL <CLICKED .KEY .Y .X>>
		   <COND (<ZERO? .TBL>
			  <SOUND ,S-BOOP>
			  <AGAIN>)>)
		  (<EQUAL? .KEY ,UP-ARROW ,MAC-UP-ARROW>
		   <COND (<ZERO? ,DBOX-TOP>
			  <SOUND 2>
			  <AGAIN>)>
		   <SETG DBOX-TOP <- ,DBOX-TOP .PAGE-SIZE>>
		   <COND (<L? ,DBOX-TOP 0>
			  <SETG DBOX-TOP 0>)>
		   <DISPLAY-DBOX>
		   <AGAIN>)
		  (<EQUAL? .KEY ,DOWN-ARROW ,MAC-DOWN-ARROW>
		   <SET X <- ,DBOX-LINES ,DHEIGHT>>
		   <COND (<OR <BTST ,IN-DBOX ,SHOWING-STATS>
			      <G? ,DBOX-TOP .X>
			      <G? ,DBOX-TOP <- .LAST-PAGE 1>>>
			  <SOUND 2>
			  <AGAIN>)>
		   <INC X>
		   <SETG DBOX-TOP <+ ,DBOX-TOP .PAGE-SIZE>>
		   <COND (<G? ,DBOX-TOP .X>
			  <SETG DBOX-TOP .X>)
			 (<G? ,DBOX-TOP .LAST-PAGE>
			  <SETG DBOX-TOP .LAST-PAGE>)>
		   <DISPLAY-DBOX>
		   <AGAIN>)>
	    <COND (<AND <G? .KEY %<- ,F1 1>>
			<L? .KEY %<+ ,F10 1>>>
		   <SET TBL <GET ,SOFT-KEYS <- .KEY ,F1>>>)>
	    <COND (<ZERO? .TBL>
		   <AGAIN>)>
	    <SET LEN <GETB .TBL 1>>
	    <COND (<ZERO? .LEN>
		   <SOUND ,S-BOOP>
		   <AGAIN>)
		  (<ZERO? .ILEN>)
		  (<G? .LEN <- %<- ,P-INBUF-LENGTH 6> .ILEN>>
		   <SOUND ,S-BOOP>
		   <AGAIN>)
		  (<NOT <EQUAL? <GETB <BACK .DEST 1> 0> ,SP>>
		   <PUTB .DEST 0 ,SP>
		   <INC DEST>
		   <INC OFFSET>
		   <BUFOUT <>>
		   <TELL C ,SP>)>
	    <BUFOUT <>>
	    <SHOW-TABLE .TBL .LEN>
	    <SET TBL <REST .TBL 2>>
	    <SET PTR 0>
	    <SET CNT <- .LEN 1>>
	    <REPEAT ()
	       <SET X <GETB .TBL .PTR>>
	       <COND (<OR <EQUAL? .X ,EOL ,LF>
			  <EQUAL? .X %<ASCII !\|> %<ASCII !\!>>>
		      <BUFOUT T>
		      <PUTB .DEST .PTR 0>
		      <SET LEN <+ <+ .PTR .ILEN> .OFFSET>>
		      <PUTB ,P-INBUF 1 .LEN>
		      <DO-LEX>
		      <RFALSE>)>
	       <PUTB .DEST .PTR .X>
	       <COND (<IGRTR? PTR .CNT>
		      <RETURN>)>>
	    <TELL C ,SP>
	    <BUFOUT T>
	    <PUTB .DEST .PTR ,SP>
	    <INC OFFSET>
	    <SET LEN <+ <+ .LEN .ILEN> .OFFSET>>
	    <PUTB ,P-INBUF 1 .LEN>>>

<ROUTINE DO-LEX ()
	 <LEX ,P-INBUF ,P-LEXV>
	 <LEX ,P-INBUF ,P-LEXV ,VOCAB2 1>
	 <COLOR ,FORE ,BGND>
	 <RFALSE>>

<ROUTINE SHOW-TABLE (TBL LEN "AUX" PTR CHAR)
	 <SET PTR 2>
	 <INC LEN>
	 <REPEAT ()
	    <SET CHAR <GETB .TBL .PTR>>
	    <COND (<OR <EQUAL? .CHAR ,EOL ,LF>
		       <EQUAL? .CHAR %<ASCII !\|> %<ASCII !\!>>>
		   <CRLF>
		   <RFALSE>)
		  (<AND <G? .CHAR %<- <ASCII !\a> 1>>
			<L? .CHAR %<+ <ASCII !\z> 1>>>
		   <SET CHAR <- .CHAR ,SP>>)>
	    <PRINTC .CHAR>
	    <COND (<IGRTR? PTR .LEN>
		   <RFALSE>)>>>

<ROUTINE CLICKED (CLK Y X "AUX" NX NY DIR TMP MX MY)
	 
       ; "Zero-align X and Y."

	 <SET X <- .X ,MOUSEDGE 1>>
	 <DEC Y>
	 
       ; "Get direction of mouse relative to HERE."

	 ; "Changed per TAA.  Instead of using COMPASS, we do
	    computation.  Cardinal directions happen if one coordinate
	    is L=? half of the other.  Otherwise do nw, etc."
	 <COND (<AND <EQUAL? .Y ,MAPY>
		     <EQUAL? .X ,MAPX>>
		; "We're in the same room, so check for up/down"
		<SET DIR <GETB <REST ,MAP <* ,MAPY ,MWIDTH>> ,MAPX>>
		<COND (<EQUAL? .DIR ,IUARROW ,UARROW>
		       <SET DIR ,I-U>)
		      (<EQUAL? .DIR ,IDARROW ,DARROW>
		       <SET DIR ,I-D>)
		      (T
		       <RFALSE>)>)
	       (T
		<SET NX <- .X ,MAPX>>
		; "Get position relative to current"
		;<COND (<ZERO? .NX>)
		      (<G? .NX ,CENTERX>
		       <SET X <- .X ,CENTERX>>)
		      (<L? .NX ,NCENTERX>
		       <SET X <+ .X ,CENTERX>>)>
		;<SET NX <+ .X <- ,CENTERX ,MAPX>>>
		
		<SET NY <- .Y ,MAPY>>
		;<COND (<ZERO? .NY>)
		      (<G? .NY ,CENTERY>
		       <SET Y <- .Y ,CENTERY>>)
		      (<L? .NY ,NCENTERY>
		       <SET Y <+ .Y ,CENTERY>>)>
		;<SET NY <+ .Y <- ,CENTERY ,MAPY>>>
		
		;<SET DIR <GETB <REST ,COMPASS <* .NY %<+ ,MWIDTH 1>>> .NX>>
		; "Get magnitude of X and Y difference"
		<COND (<L? .NY 0>
		       <SET MY <- .NY>>)
		      (T
		       <SET MY .NY>)>
		<COND (<L? .NX 0>
		       <SET MX <- .NX>>)
		      (T
		       <SET MX .NX>)>
		<COND (<AND <0? .MX> <0? .MY>>
		       <SET DIR ,AMB>)
		      (<L=? <* 3 .MX> .MY>
		       ; "X is small compared to Y, so this is N/S"
		       <COND (<G? .NY 0>
			      ; "Mouse is below current loc"
			      <SET DIR ,I-SOUTH>)
			     (T
			      <SET DIR ,I-NORTH>)>)
		      (<L=? <* 2 .MY> .MX>
		       ; "Y is small compared to X, so this is E/W"
		       <COND (<G? .NX 0>
			      <SET DIR ,I-EAST>)
			     (T
			      <SET DIR ,I-WEST>)>)
		      (<G? .NX 0>
		       ; "Tending eastward"
		       <COND (<G? .NY 0>
			      <SET DIR ,I-SE>)
			     (T
			      <SET DIR ,I-NE>)>)
		      (<G? .NY 0>
		       <SET DIR ,I-SW>)
		      (T
		       <SET DIR ,I-NW>)>)>
	 
	 
	 <COND (<EQUAL? .DIR ,AMB> ; "DIR ambiguous."
		<RFALSE>)>
	 
	 <TABLE-WALK <GET ,DIR-NAMES .DIR>>
	 <RETURN ,AUX-TABLE>>

<ROUTINE TABLE-WALK (WRD)
	 <PUT ,AUX-TABLE 0 0>
	 <DIROUT ,D-TABLE-ON ,AUX-TABLE>
	 <COND (<EQUAL? .WRD ,W?AROUND>
		<TELL "walk ">)>
	 <TELL B .WRD CR>
	 <DIROUT ,D-TABLE-OFF>
	 <PUTB ,AUX-TABLE 1 <GET ,AUX-TABLE 0>>
	 <RFALSE>>

<ROUTINE KEYPAD (KEY "AUX" TBL WRD)
	 <SET WRD <GET ,PAD-NAMES <- .KEY ,PAD1>>>
	 <COND (<EQUAL? .KEY ,PAD5>
		<SET TBL <GETP ,HERE ,P?UP>>
		<COND (<ZERO? .TBL>)
		      (<CHECK-EXIT? ,HERE .TBL>
		       <SET WRD ,W?UP>)>
		<SET TBL <GETP ,HERE ,P?DOWN>>
		<COND (<ZERO? .TBL>)
		      (<CHECK-EXIT? ,HERE .TBL>
		       <COND (<EQUAL? .WRD ,W?UP>
			      <SET WRD ,W?AROUND>)
			     (T
			      <SET WRD ,W?DOWN>)>)>)>
	 <TABLE-WALK .WRD>
	 <RETURN ,AUX-TABLE>>

"PICK-ONE expects an LTABLE, with an initial element of 0."

<ROUTINE PICK-ONE (TBL "AUX" L CNT RND X RTBL)
	 <SET L <GET .TBL 0>>
	 <SET CNT <GET .TBL 1>>
	 <DEC L>
	 <SET TBL <REST .TBL 2>>
	 <SET RTBL <REST .TBL <* .CNT 2>>>
	 <SET RND <RANDOM <- .L .CNT>>>
	 <SET X <GET .RTBL .RND>>
	 <PUT .RTBL .RND <GET .RTBL 1>>
	 <PUT .RTBL 1 .X>
	 <INC CNT>
	 <COND (<EQUAL? .CNT .L> 
		<SET CNT 0>)>
	 <PUT .TBL 0 .CNT>
	 <RETURN .X>>

"PICK-NEXT expects an LTABLE of strings, with an initial element of 2."

<ROUTINE PICK-NEXT (TBL "AUX" CNT STR)
	 <SET CNT <GET .TBL 1>>
       	 <SET STR <GET .TBL .CNT>>       
	 <COND (<IGRTR? CNT <GET .TBL 0>>
		<SET CNT 2>)>
	 <PUT .TBL 1 .CNT>
	 <RETURN .STR>>

<GLOBAL P-ACT <>>
<GLOBAL P-QWORD <>>

<BUZZ $BUZZ>

<OBJECT QWORD
	(LOC GLOBAL-OBJECTS)
	(DESC "that")
	(SYNONYM PPPZ)
	(FLAGS NOARTICLE NODESC)>

<ROUTINE QUOTED-WORD? (PTR "OPT" (VERB <>) (NAMING <>) "AUX" (WRD 0))
	 <COND (<ZERO? .VERB>)
	       (<AND <ZERO? ,P-QWORD>
		     <T? .NAMING>
		     <EQUAL? .VERB ,ACT?NAME ; ,ACT?SAY>>
		<SETG P-QWORD .PTR>
		<SET WRD ,W?PPPZ>)>
	 <CHANGE-LEXV .PTR .WRD>
	 <RETURN .WRD>>

<ROUTINE QUOTED-PHRASE? (PTR VERB "AUX" (1ST? T) LEN WRD BPTR)
	 <CHANGE-LEXV .PTR ,W?$BUZZ> ; "Neutralizes W?QUOTE."
	 <SET LEN <- ,P-LEN 1>>
	 <SET PTR <+ .PTR ,P-LEXELEN>>
         <SET BPTR <REST ,P-LEXV <* .PTR 2>>>
	 <REPEAT ()
	    <COND (<L? .LEN 0>
		   <PCLEAR>
		   <TELL "[You forgot a second quote.]" CR>
		   <RFALSE>)>
	    <SET WRD <GET ,P-LEXV .PTR>>
	    <COND (<EQUAL? .WRD ,W?QUOTE>
		   <CHANGE-LEXV .PTR ,W?$BUZZ>
		   <RTRUE>)
		  (<T? .1ST?>
		   <COND (<T? .WRD>
			  <COND (<EQUAL? .VERB ,ACT?SAY>)
				(<EQUAL? .VERB ,ACT?NAME>
				 <HOLLOW-VOICE 
				  "reserved by the Implementors">
				 <RFALSE>)>)
			 (<QUOTED-WORD? .PTR .VERB T>
			  <SET 1ST? <>>)
			 (T
			  <TELL ,CANT "see any ">
			  <SET LEN <GETB .BPTR 2>>
			  <WORD-PRINT .LEN <GETB .BPTR 3>>
			  <TELL " here." ;" [2]" CR>
			  <RFALSE>)>)
		  (T
		   <CHANGE-LEXV .PTR ,W?$BUZZ>)>
	    <SET PTR <+ .PTR ,P-LEXELEN>>
	    <SET LEN <- .LEN 1>>>>

<ROUTINE ITS-CLOSED ("OPT" (OBJ ,PRSO))
         <THIS-IS-IT .OBJ>
	 <TELL CTHE .OBJ>
	 <IS-ARE .OBJ>
	 <TELL B ,W?CLOSED ,PERIOD>
	 <RTRUE>>

<ROUTINE REMOVE-ALL (THING "AUX" OBJ NXT)
	 <COND (<SET OBJ <FIRST? .THING>>
		<REPEAT ()
		   <SET NXT <NEXT? .OBJ>>
		   <REMOVE .OBJ>
		   <SET OBJ .NXT>
		   <COND (<ZERO? .OBJ>
			  <RFALSE>)>>)>
	 <RFALSE>>

