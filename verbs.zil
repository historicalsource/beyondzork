"VERBS for BEYOND ZORK:
 Copyright (C)1987 Infocom, Inc. All Rights Reserved."

<ROUTINE GOTO (WHERE "AUX" (CR 0) WHO X L OLIT)
	 <SET OLIT ,LIT?>
	 <SET WHO ,WINNER>
	 <SET L <LOC ,WINNER>>
	 <COND (<AND <EQUAL? .L ,SADDLE>
		     <IN? .L ,DACT>>
		<SET WHO ,DACT>)
	       (<AND <NOT <EQUAL? .L ,HERE>>
		     <IS? .L ,VEHICLE>>
		<COND (<EQUAL? <PERFORM ,V?EXIT .L> ,M-FATAL>
		       <SETG P-WALK-DIR <>>
		       <RTRUE>)>
		<SETG P-WALK-DIR <>>
		<SETG OLD-HERE <>>
		<INC CR>)>
	 <SET X <APPLY <GETP ,HERE ,P?ACTION> ,M-EXIT>>
	 <COND (<EQUAL? .X ,M-FATAL>
		<SETG P-WALK-DIR <>>
		<RTRUE>)
	       (<T? .X>
		<COND (<T? .CR>
		       <TELL ,TAB>)>
		<INC CR>)>
       ; <COND (<EQUAL? .WHERE ,APLANE ,DEATH>)
	       (<T? ,EXIT-LINE>
		<COND (<T? .CR>
		       <TELL ,TAB>)>
		<TELL ,EXIT-LINE CR>
		<INC CR>)>
       ; <SETG EXIT-LINE <>>
	 <COND (<AND <EQUAL? .WHO ,WINNER>
		     <IN? ,DACT ,HERE>
		     <IS? ,DACT ,LIVING>
		     <NOT <IS? ,DACT ,MUNGED>>
		     <NOT <IS? ,DACT ,SLEEPING>>>
		<REMOVE ,DACT>
		<COND (<NOT <EQUAL? .WHERE ,APLANE ,DEATH>>
		       <COND (<T? .CR>
			      <TELL ,TAB>)>
		       <INC CR>
		       <TELL 
"A shadow passes over " 'HEAD " as you leave." CR>)>)>
	 <COND (<AND <T? .CR>
		     <T? ,VERBOSITY>>
		<CRLF>)>
	 <SETG HERE .WHERE>
	 <MOVE .WHO .WHERE>
	 <SETG LIT? <IS-LIT?>>
	 <COND (<AND <ZERO? .OLIT>
		     <ZERO? ,LIT?>>
		<COND (<T? .CR>
		       <TELL ,TAB>)>
		<TELL ,CYOU <PICK-NEXT ,DARK-WALKS>>
		
		<COND (<GRUE-ROOM?>)
		      (<PROB 50>
		       <TELL
", straight into the jaws of a deadly presence lurking in the darkness">
		       <JIGS-UP>
		       <RTRUE>)>
		<PRINT ,PERIOD>
		<COND (<T? ,VERBOSITY>
		       <CRLF>)>)>
		
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTERING>
	 <COND (<NOT <EQUAL? ,HERE .WHERE>>
		<RTRUE>)>
	 <COND (<ZERO? ,LIT?>
		<MARK-DIR>)>		 
	 <SETG LAST-PSEUDO-LOC <>>
	 <MAKE ,PSEUDO-OBJECT ,NOARTICLE>
	 <UNMAKE ,PSEUDO-OBJECT ,VOWEL>
	 <UNMAKE ,PSEUDO-OBJECT ,TRYTAKE>
	 <SETG LAST-MONSTER <>>
	 <SETG LAST-MONSTER-DIR <>>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>
	 <SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
	 <SETG P-HER-OBJECT ,NOT-HERE-OBJECT>
	 <V-LOOK <>>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTERED>	 
	 <RTRUE>>

<ROUTINE MARK-DIR ("OPT" (DIR ,P-WALK-DIR) "AUX" TBL WRD TYPE LEN)
	 <COND (<L? .DIR ,P?DOWN>
		<RFALSE>)>
	 <SET TBL <GETP ,HERE <GETB ,XPDIR-LIST <- 0 <- .DIR ,P?NORTH>>>>>
	 <COND (<ZERO? .TBL>
		<RFALSE>)>
	 <SET WRD <GET .TBL ,XTYPE>>
	 <COND (<BTST .WRD ,MARKBIT>
		<RTRUE>)>
	 <SET TYPE <MSB .WRD>>
	 <SET LEN <BAND .WRD 127>>
	 <COND (<OR <EQUAL? .TYPE ,CONNECT ,SCONNECT ,X-EXIT>
		    <AND <EQUAL? .TYPE ,FCONNECT>
			 <T? .LEN>>
		    <AND <EQUAL? .TYPE ,DCONNECT>
			 <IS? <GET .TBL ,XDATA> ,OPENED>>>
		<PUT .TBL ,XTYPE <+ .WRD ,MARKBIT>>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE DO-WALK (DIR1 "OPT" (DIR2 <>) (DIR3 <>) "AUX" X)
	 <SETG P-WALK-DIR .DIR1>
	 <SET X <PERFORM ,V?WALK .DIR1>>
	 <COND (<EQUAL? .X ,M-FATAL>
		<RFATAL>)
	       (<T? .DIR2>
		<CRLF>
		<SETG P-WALK-DIR .DIR2>
		<SET X <PERFORM ,V?WALK .DIR2>>
		<COND (<EQUAL? .X ,M-FATAL>
		       <RFATAL>)
		      (<T? .DIR3>
		       <CRLF>
		       <SETG P-WALK-DIR .DIR3>
		       <SET X <PERFORM ,V?WALK .DIR3>>)>)>
	 <RETURN .X>>

<ROUTINE V-WALK ("AUX" TBL TYPE DATA)
	 <COND (<ZERO? ,P-WALK-DIR>
		<COND (<T? ,PRSO>
		       <PRINT "[Presumably, you mean ">
		       <TELL "WALK TO " THEO>
		       <PRINTC %<ASCII !\.>>
		       <PRINT ,BRACKET>
		       <PERFORM ,V?WALK-TO ,PRSO>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<AND <IN? ,PLAYER ,SADDLE>
		     <IN? ,SADDLE ,DACT>>
		<RETURN <NEXT-SKY>>)
	       (<HERE? APLANE>
		<RETURN <NEXT-APLANE>>)>
	 <SET TBL <GETP ,HERE ,PRSO>>
	 <COND (<ZERO? .TBL>
		<NO-EXIT-THAT-WAY>
		<RFATAL>)>
	 <SET TYPE <MSB <GET .TBL ,XTYPE>>>
	 
	 <COND (<EQUAL? .TYPE ,NO-EXIT ,SHADOW-EXIT>
		<NO-EXIT-THAT-WAY>
		<RFATAL>)>
	 
	 <COND (<AND <NOT <EQUAL? ,LAST-MONSTER <> ,DORN ,MAMA>>
		     <IN? ,LAST-MONSTER ,HERE>
		     <IN? ,WINNER ,HERE>
		     <IS? ,LAST-MONSTER ,LIVING>
		     <NOT <IS? ,LAST-MONSTER ,SLEEPING>>
		     <EQUAL? ,LAST-MONSTER-DIR ,P-WALK-DIR>
		     <T? ,LIT?>>
		<TELL CTHE ,LAST-MONSTER " block">
		<COND (<OR <ZERO? ,LIT?>
			   <NOT <IS? ,LAST-MONSTER ,PLURAL>>>
		       <TELL "s">)>
		<TELL " your path!" CR>
		<RTRUE>)>
	 
	 <SET DATA <GET .TBL ,XROOM>>
	 <COND (<EQUAL? .TYPE ,CONNECT ,X-EXIT>
		<GOTO .DATA>
		<RTRUE>)
	       (<EQUAL? .TYPE ,SORRY-EXIT>
		<TELL .DATA CR>
		<RFATAL>)
	     ; (<EQUAL? .TYPE ,FSORRY-EXIT>
		<SET TYPE <GET .TBL ,XDATA>>
		<COND (<ZERO? .TYPE>
		       <SET DATA <APPLY .DATA>>
		       <RFATAL>)>
		<SET DATA <APPLY .DATA .TYPE>>
		<RFATAL>)
	       (<EQUAL? .TYPE ,SCONNECT>
		<TELL <GET .TBL ,XDATA> CR>
		<COND (<T? ,VERBOSITY>
		       <CRLF>)>
		<GOTO .DATA>
		<RTRUE>)
	       (<EQUAL? .TYPE ,FCONNECT>
		<SET DATA <APPLY .DATA>>
		<COND (<T? .DATA>
		       <GOTO .DATA>
		       <RTRUE>)>
		<RFATAL>)
	       (<EQUAL? .TYPE ,DCONNECT>
		<SET TYPE <GET .TBL ,XDATA>>
		<COND (<IS? .TYPE ,OPENED>
		       <GOTO .DATA>
		       <RTRUE>)>
		<ITS-CLOSED .TYPE>
		<RFATAL>)>
       ; <SAY-ERROR "V-WALK">
	 <RFATAL>>

<ROUTINE NO-EXIT-THAT-WAY ("AUX" STR)
	 <SET STR <GETP ,HERE ,P?EXIT-STR>>
	 <COND (<EQUAL? ,P-WALK-DIR <> ,P?UP ,P?DOWN>)
	       (<EQUAL? ,P-WALK-DIR ,P?IN ,P?OUT>)
	       (<T? .STR>		     
		<TELL .STR CR>
		<RTRUE>)>
	 <TELL "There's no exit that way." CR>
	 <RTRUE>>

<ROUTINE NEXT-OVER ("AUX" (CNT 0) DIR BITS TBL XTBL TYPE DATA)
	 <SET XTBL <GET ,FLY-TABLES ,ABOVE>>
	 <SET BITS <GETB .XTBL 0>>
	 <SET DIR ,I-NORTH>
	 <REPEAT ()
	    <SET TBL <GETP ,HERE <GETB ,PDIR-LIST .DIR>>>
	    <SET DATA 0>
	    <COND (<BTST .BITS <GETB ,DBIT-LIST .DIR>>
		   <SET TYPE %<+ ,CONNECT 9 ,MARKBIT>>
		   <INC CNT>
		   <SET DATA <GETB .XTBL .CNT>>
		   <COND (<AND <HERE? IN-SKY>
			       <EQUAL? .DATA ,OPLAIN>>
			  <SET TYPE %<+ ,FCONNECT 9 ,MARKBIT>>)
			 (<AND <HERE? APLANE>
			       <EQUAL? .DATA ,OCAVES>>
			  <SET TYPE ,NO-EXIT>
			  <SET DATA 0>)>)
		  (<HERE? IN-SKY>
		   <SET TYPE %<+ ,FCONNECT 9 ,MARKBIT>>)
		  (T
		   <SET TYPE ,NO-EXIT>)>
	    <PUT .TBL ,XTYPE .TYPE>
	    <PUT .TBL ,XDATA .DATA>
	    <COND (<IGRTR? DIR ,I-NW>
		   <RFALSE>)>>>
	   
<ROUTINE NEXT-SKY ("AUX" DIR IDIR D1 D2 D3 TBL DATA X)
	 <COND (<OR <T? ,DACT-SLEEP>
		    <IS? ,DACT ,SLEEPING>
		    <IS? ,DACT ,MUNGED>
		    <NOT <IS? ,DACT ,LIVING>>>
		<TELL CTHE ,DACT " is in no condition to move around." CR>
		<RFATAL>)>
	 <SET DIR ,P-WALK-DIR>
	 <SETG P-WALK-DIR <>>
	 <COND (<EQUAL? .DIR ,P?UP>
		<COND (<HERE? IN-SKY>
		       <TELL CTHE ,DACT
" puffs and strains, but cannot lift you any higher." CR>
		       <RFATAL>)>
		<SET X <GETP ,HERE ,P?FNUM>>
		<COND (<ZERO? .X>
		       <TELL ,CANT "fly here." CR>
		       <RFATAL>)>
		<TELL CTHE ,DACT>
		<COND (<AND <HERE? IN-GARDEN>
			    <T? ,PTIMER>>
		       <TELL " cocks his head, hesitating." CR>
		       <RTRUE>)>
		<TELL " spreads his leathery wings and ">
		<COND (<AND <IN? ,PARASOL ,PLAYER>
			    <IS? ,PARASOL ,OPENED>>
		       <TELL "tries to take off. But your open " 'PARASOL
			     " seems to be dragging him down." CR>
		       <RTRUE>)>
		<SETG ABOVE .X>
		<PUTP ,IN-SKY ,P?FNUM ,ABOVE>
		<TELL "rises into the sky." CR>
		<COND (<T? ,VERBOSITY>
		       <CRLF>)>
		<GOTO ,IN-SKY>
		<CHECK-BREEZE>
		<RTRUE>)
	       (<EQUAL? .DIR ,P?DOWN>
		<COND (<NOT <HERE? IN-SKY>>
		       <TELL CTHE ,DACT " is already on " THE ,GROUND
			     ,PERIOD>
		       <RFATAL>)>
		<SET X <DOWN-TO?>>
		<COND (<ZERO? .X>
		       <COND (<EQUAL? ,ABOVE ,OTHRIFF>
			      <TELL CTHE ,DACT 
" tries his best to land, but " THE ,GROUND 
" below is completely choked with " 'XTREES ,PERIOD>)>
		       <RFATAL>)>
		<TELL CTHE ,DACT " glides earthward." CR>
		<COND (<T? ,VERBOSITY>
		       <CRLF>)>
		<GOTO .X>	
		<RTRUE>)
	       (<EQUAL? .DIR <> ,P?IN ,P?OUT>
		<PUZZLED-DACT>
		<RFATAL>)
	       (<NOT <HERE? IN-SKY>>
		<SETG P-WALK-DIR <>>
		<TELL "It's hard enough for a " 'DACT 
" to walk, even when there's not an adventurer riding his back." CR>
		<RFATAL>)>
	 	  
       	 <SET TBL <GETP ,HERE .DIR>>
	 <SET DATA <GET .TBL ,XDATA>>
	 <COND (<EQUAL? <GET .TBL ,XTYPE> %<+ ,FCONNECT 9 ,MARKBIT>>
	 	<TELL "The sky is filled with impenetrable ">
		<COND (<EQUAL? .DATA ,OPLAIN>
		       <TELL "funnel ">)>
		<TELL "clouds in that " 'INTDIR ,PERIOD>		
		<RFATAL>)>
	 
       ; "D1-D3 are IDIRs favored by the wind."

	 <SET D1 <+ ,WINDIR 4>>
	 <COND (<G? .D1 ,I-NW>
		<SET D1 <- .D1 8>>)>
	 <SET D2 <+ .D1 1>>
	 <COND (<G? .D2 ,I-NW>
		<SET D2 ,I-NORTH>)>
	 <SET D3 <- .D1 1>>
	 <COND (<L? .D3 ,I-NORTH>
		<SET D3 ,I-NW>)>
	 <SET IDIR <- 0 <- .DIR ,P?NORTH>>>
	 <COND (<EQUAL? .IDIR .D1 .D2 .D3>
		<UNMAKE ,BREEZE ,SEEN>
		<TELL CTHE ,DACT> 
		<TELL " banks smoothly to the " 
		      B <GET ,DIR-NAMES .IDIR> ,PERIOD>
		<FLYOVER .DATA>
		<RTRUE>)>
	 
      ; "Check for crosswinds."

	 <MAKE ,BREEZE ,SEEN>
	 <SET D1 <- ,WINDIR 2>>
	 <COND (<L? .D1 ,I-NORTH>
		<SET D1 <+ .D1 8>>)>
	 <COND (<EQUAL? .IDIR .D1>
		<SET D2 <- ,WINDIR 3>>
		<COND (<L? .D2 ,I-NORTH>
		       <SET D2 <+ .D2 8>>)>
		<RETURN <DO-CROSSWIND .IDIR .D2>>)>
	 
	 <SET D1 <+ ,WINDIR 2>>
	 <COND (<G? .D1 ,I-NW>
		<SET D1 <- .D1 8>>)>
	 <COND (<EQUAL? .IDIR .D1>
		<SET D2 <+ ,WINDIR 3>>
		<COND (<G? .D2 ,I-NW>
		       <SET D2 <- .D2 8>>)>
		<RETURN <DO-CROSSWIND .IDIR .D2>>)>
	 
	 <TELL CTHE ,DACT 
" does his best to fly into the wind, but fails." CR>
	 <RFATAL>>
		
<ROUTINE DO-CROSSWIND (IDIR D2 "AUX" TBL DATA)
	 <SET TBL <GETP ,IN-SKY <GETB ,PDIR-LIST .D2>>>
	 <SET DATA <GET .TBL ,XDATA>>
	 <COND (<OR <EQUAL? .DATA 0 ,OPLAIN ,OCAVES>
		    <EQUAL? <GET .TBL ,XTYPE> %<+ ,FCONNECT 9 ,MARKBIT>>
		    <PROB 50>>
		<TELL
"A strong crosswind prevents " THE ,DACT " from flying that way." CR>
		<RFATAL>)>
	 <TELL CTHE ,DACT> 
	 <TELL " banks to the " B <GET ,DIR-NAMES .IDIR>
	       ", but a strong crosswind blows him off course." CR>
	 <FLYOVER .DATA>
	 <RTRUE>>		

<ROUTINE FLYOVER (DATA)
	 <SETG ABOVE .DATA>
	 <PUTP ,IN-SKY ,P?FNUM ,ABOVE>
	 <NEXT-OVER>
	 <RELOOK T>
	 <CHECK-BREEZE>
	 <RTRUE>>

<ROUTINE CHECK-BREEZE ()
	 <COND (<OR <AND <EQUAL? ,ABOVE ,OTHRIFF>
			 <EQUAL? ,WINDIR ,I-EAST ,I-SE ,I-SOUTH>>
		    <AND <EQUAL? ,ABOVE ,OXROADS>
			 <EQUAL? ,WINDIR ,I-NORTH ,I-NE ,I-EAST>>>
		<SETG WINDIR <NEXT-WINDIR?>>
		<MAKE ,BREEZE ,SEEN>
		<TELL ,TAB <PICK-NEXT ,WIND-ALERTS> ,PERIOD>)>
	 <RFALSE>>

<ROUTINE NEXT-APLANE ("AUX" DIR TBL DATA NEW X)
	 <SET DIR ,P-WALK-DIR>
	 <SETG P-WALK-DIR <>>
	 <SET X <LOC ,PLAYER>>
	 <COND (<OR <EQUAL? .DIR ,P?UP ,P?DOWN>
		    <EQUAL? .DIR ,P?IN ,P?OUT>>
		<TELL "Such " 'INTDIR "s have no meaning here." CR>
		<RFATAL>)
	       (<EQUAL? .X ,APLANE>)
	       (<IS? .X ,VEHICLE>
		<COND (<EQUAL? <PERFORM ,V?EXIT .X> ,M-FATAL>
		       <RFATAL>)>
		<TELL ,TAB>)>
	 <SET TBL <GETP ,HERE .DIR>>
	 <SET DATA <GET .TBL ,XTYPE>>
	 <COND (<EQUAL? .DATA ,NO-EXIT>
	 	<TELL "The local geometry does not extend in that " 
		      'INTDIR ,PERIOD>		
		<RFATAL>)
	       (<EQUAL? ,ABOVE ,OPLAIN>
		<COND (<T? ,IMPSAY>
		       <PERMISSION>
		       <RFATAL>)>
		<EXIT-IMPS>)>
	 <SET NEW <GET .TBL ,XDATA>>
	 <COND (<EQUAL? .NEW ,OPLAIN>
		<COND (<IS? ,SHAPE ,LIVING>
		       <COND (<NOT <IN? ,SHAPE ,APLANE>>
			      <WINDOW ,SHOWING-ROOM>
			      <MOVE ,SHAPE ,APLANE>
			      <SETG LAST-MONSTER ,SHAPE>
			      <SETG LAST-MONSTER-DIR <>>
			      <SETG P-IT-OBJECT ,SHAPE>
			      <TELL 
"The space before you flexes in on itself, twists sideways and reopens into "
A ,SHAPE ", stretched across your path like the skin of a drum." CR>
			      <RFATAL>)>
		       <TELL CTHE ,SHAPE 
" stretches itself tighter across your path." CR>	      
		       <RFATAL>)
		      (<ZERO? ,IMPSAY>
		       <KERBLAM>
		       <TELL "A bolt of " B ,W?LIGHTNING
			     " blocks your path." CR>
		       <RFATAL>)>)>
	 <COND (<EQUAL? ,ABOVE ,OACCARDI ,OCITY ,OMIZNIA>
		<REMOVE ,CURTAIN>)>
	 <COND (<IN? ,SHAPE ,APLANE>
		<REMOVE ,SHAPE>
		<SETG LAST-MONSTER <>>
		<SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		<TELL CTHE ,SHAPE " disincorporates as you retreat." CR>
		<COND (<T? ,VERBOSITY>
		       <CRLF>)>)>
	 <SETG ABOVE .NEW>
	 <GET-APLANE-THINGS>
	 <NEXT-OVER>
	 <V-LOOK>
	 <RTRUE>>
	   
<ROUTINE PERMISSION ()
	 <TELL
"\"We didn't say you could leave yet,\" notes an Implementor dryly." CR>
	 <RTRUE>>

<ROUTINE EXIT-IMPS ()
	 <REMOVE ,IMPTAB>
	 <REMOVE ,IMPS>
	 <DEQUEUE ,I-IMPS>
	 <RFALSE>>

<ROUTINE GET-APLANE-THINGS ()
	 <COND (<EQUAL? ,ABOVE ,OCITY ,OMIZNIA ,OACCARDI>
		<COND (<NOT <IN? ,CURTAIN ,APLANE>>
		       <MOVE ,CURTAIN ,APLANE>
		       <UNMAKE ,CURTAIN ,NODESC>)>
		<RTRUE>) 
	       (<AND <EQUAL? ,ABOVE ,OPLAIN>
		     <NOT <IN? ,IMPS ,APLANE>>>
		<MOVE ,IMPTAB ,APLANE>
		<MOVE ,IMPS ,APLANE>
		<QUEUE ,I-IMPS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ANY-TOUCHED? (TBL "OPT" EXCLUDED "AUX" LEN RM CNT)
	 <SET LEN <GETB .TBL 0>>
	 <SET CNT 1>
	 <REPEAT ()
	    <SET RM <GETB .TBL .LEN>>
	    <COND (<AND <IS? .RM ,TOUCHED>
			<OR <NOT <ASSIGNED? EXCLUDED>>
			    <NOT <IS? .RM .EXCLUDED>>>>
		   <INC CNT>
		   <PUT ,AUX-TABLE .CNT .RM>)>
	    <COND (<DLESS? LEN 1>
		   <RETURN>)>>
	 <COND (<EQUAL? .CNT 1>
		<RFALSE>)
	       (<EQUAL? .CNT 2>
		<RETURN <GET ,AUX-TABLE 2>>)>
	 <PUT ,AUX-TABLE 0 .CNT>
	 <PUT ,AUX-TABLE 1 0>
	 <RETURN <PICK-ONE ,AUX-TABLE>>>

<ROUTINE DOWN-TO? ("AUX" (RM 0) X)
	 <COND (<EQUAL? ,ABOVE ,ORUINS>
		<SET RM <ANY-TOUCHED? ,RUIN-ROOMS>>
		<COND (<AND <ZERO? .RM>
			    <SETUP-RUINS?>>
		       <SET RM <RANDOM-ROOM? ,RUIN-ROOMS>>)>
		<RETURN .RM>)
	       (<EQUAL? ,ABOVE ,OBRIDGE>
		<SETG BRIDGE-DIR 0>
		<SETG ZTOP 1>
		<SETG ZBOT 2>
		<RETURN ,ON-BRIDGE>)
	       (<EQUAL? ,ABOVE ,OFOREST>
		<SET RM <ANY-TOUCHED? ,FOREST-ROOMS>>
		<COND (<AND <ZERO? .RM>
			    <SETUP-FOREST?>>
		       <SET RM <RANDOM-ROOM? ,FOREST-ROOMS>>)>
		<RETURN .RM>)
	       (<EQUAL? ,ABOVE ,OACCARDI>
		<SET RM ,IN-ACCARDI>
		<COND (<AND <IS? ,AT-GATE ,TOUCHED>
			    <PROB 50>>
		       <SET RM ,AT-GATE>)>
		<RETURN .RM>)
	       (<EQUAL? ,ABOVE ,OCITY>
		<SET RM ,IN-GURTH>
		<COND (<IS? ,AT-MAGICK ,TOUCHED>
		       <SET RM ,AT-MAGICK>)>
		<RETURN .RM>)
	       (<EQUAL? ,ABOVE ,OSHORE>
		<SET RM <ANY-TOUCHED? ,SHORE-ROOMS>>
		<COND (<ZERO? .RM>
		       <SET RM ,AT-LEDGE>)>
		<RETURN .RM>)
	       (<EQUAL? ,ABOVE ,OXROADS>
		<RETURN ,XROADS>)
	       (<EQUAL? ,ABOVE ,OPLAIN>
		<RFALSE>)
	       (<EQUAL? ,ABOVE ,OGRUBBO>
		<RETURN ,HILLTOP>)
	       (<EQUAL? ,ABOVE ,OCAVES>
		<RETURN ,IN-GARDEN>)
	       (<EQUAL? ,ABOVE ,OMOOR>
		<SET RM <ANY-TOUCHED? ,MOOR-ROOMS>>
		<COND (<AND <ZERO? .RM>
			    <SETUP-MOOR?>>
		       <SET RM <RANDOM-ROOM? ,MOOR-ROOMS>>)>
		<RETURN .RM>)
	       (<EQUAL? ,ABOVE ,OJUNGLE>
		<SET RM <ANY-TOUCHED? ,JUNGLE-ROOMS>>
		<COND (<AND <ZERO? .RM>
			    <SETUP-JUNGLE?>>
		       <SET RM <RANDOM-ROOM? ,JUNGLE-ROOMS>>)>
		<RETURN .RM>)
	       (<EQUAL? ,ABOVE ,OMIZNIA>
		<SET RM <ANY-TOUCHED? ,MIZNIA-ROOMS>>
		<COND (<ZERO? .RM>
		       <SET RM ,IN-PORT>)>
		<RETURN .RM>)
	       (<EQUAL? ,ABOVE ,OTHRIFF>
	        <SET RM ,IN-THRIFF>
		<COND (<IS? ,IN-THRIFF ,MUNGED>
		       <SET RM ,IN-PASTURE>)>
		<RETURN .RM>)
	       (T
	      ; <SAY-ERROR "DOWN-TO?">
		<RFALSE>)>>
		
<ROUTINE RANDOM-ROOM? (TBL "AUX" OHERE RM X)
	 <SET RM <GETB .TBL <RANDOM <GETB .TBL 0>>>>
	 <COND (<NOT <IS? .RM ,TOUCHED>>
		<SET OHERE ,HERE>
		<SETG HERE .RM>
		<SET X <APPLY <GETP .RM ,P?ACTION> ,M-ENTERING>>
		<SETG HERE .OHERE>
		<MAKE .RM ,TOUCHED>)>
	 <RETURN .RM>>

<ROUTINE PRE-TAKE ("AUX" L LL WHO X X2)
	 <SET L <LOC ,PRSO>>
	 <COND (<T? .L>
		<SET LL <LOC .L>>)>
	 <COND (<AND <ZERO? ,LIT?>
		     <NOT <EQUAL? ,WINNER .L .LL>>>
		<TOO-DARK>
		<RTRUE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<EQUAL? .L ,WINNER>
		<THIS-IS-IT ,PRSO>
		<TELL ,ALREADY>
		<COND (<IS? ,PRSO ,WORN>
		       <TELL B ,W?WEAR>)
		      (T
		       <TELL B ,W?HOLD>)>
		<TELL "ing " THEO ,PERIOD>
		<RTRUE>)
	       (<AND <NOT <EQUAL? .L <> ,BROG>>
		     <IS? .L ,CONTAINER>
		     <IS? .L ,TRANSPARENT>
		     <NOT <IS? .L ,OPENED>>>
		<CANT-REACH-INTO .L>
		<RTRUE>)
	       (<AND <NOT <EQUAL? .LL <> ,BROG>>
		     <IS? .LL ,CONTAINER>
		     <IS? .LL ,TRANSPARENT>
		     <NOT <IS? .LL ,OPENED>>>
		<CANT-REACH-INTO .LL>
		<RTRUE>)
	       (<T? ,PRSI>
		<COND (<PRSO? PRSI>
		       <SET X <GET ,P-NAMW 0>>
		       <SET X2 <GET ,P-ADJW 0>>
		       <COND (<OR <EQUAL? .X <GET ,P-NAMW 1>>
				  <EQUAL? .X2 <GET ,P-ADJW 1>>>
			      <IMPOSSIBLE>
			      <RTRUE>)>)			    
		      (<PRSI? ME>
		       <COND (<EQUAL? ,WINNER ,PLAYER>
			      <NOBODY-TO-ASK>
			      <RTRUE>)
			     (<NOT <EQUAL? .L ,WINNER>>
			      <TELL CTHE ,WINNER " doesn't have "
				    THEO ,PERIOD>
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<NOT <EQUAL? .L ,PRSI>>
		       <COND (<AND <EQUAL? .L ,ON-MCASE ,ON-WCASE ,ON-BCASE>
				   <PRSI? MCASE WCASE BCASE>>
			      <RFALSE>)>
		       <TELL CTHEO>
		       <ISNT-ARENT>
		       <ON-IN ,PRSI>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<COND (<PRSO? BUSH POOL>
		       <RFALSE>)>
		<TELL "Difficult. You're">
		<ON-IN>
		<TELL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CANT-REACH-INTO (L)
	 <TELL ,CANT "reach into " THE .L ". It's closed." CR>
	 <RTRUE>>

<ROUTINE V-TAKE ("AUX" L)
	 <SET L <ITAKE>>
	 <COND (<ZERO? .L>
		<RTRUE>)
	       (<SPARK? <>>
		<TELL ,TAB>)>
	 <COND (<OR <T? ,P-MULT?>
		    <EQUAL? .L ,UNDERUG ,UNDERPEW ,LAMPHOUSE>
		    <AND <T? ,STATIC>
			 <IS? ,PRSO ,FERRIC>>>
		<TAKEN>
		<RTRUE>)
	       (<OR <IS? .L ,CONTAINER>
		    <IS? .L ,SURFACE>
		    <IS? .L ,PERSON>
		    <IS? .L ,LIVING>>
		<TELL "You take " THEO>
		<OUT-OF-LOC .L>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<PROB 50>
		<TAKEN>
		<RTRUE>)>
	 <TELL ,CYOU>
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?GRAB ,W?SEIZE ,W?SNATCH>
		<TELL B ,P-PRSA-WORD>)
	       (<PROB 50>
		<TELL "pick up">)
	       (T
		<TELL B ,W?TAKE>)>
	 <TELL C ,SP THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE TAKEN ()
	 <TELL "Taken." CR>
	 <RTRUE>>

<ROUTINE FIRST-TAKE? ()
	 <COND (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<ITAKE>
		       <PUTP ,PRSO ,P?DESCFCN 0>
		       <TAKEN>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ITAKE ("OPT" (VB T) "AUX" (CNT 0) OBJ L X MAX)
	 <COND (<OR <ZERO? ,PRSO>
		    <NOT <SET L <LOC ,PRSO>>>>
		<CANT-SEE-ANY>
		<RFALSE>)>
	 <THIS-IS-IT ,PRSO>
	 <COND (<NOT <IS? ,PRSO ,TAKEABLE>>
		<COND (<T? .VB>
		       <IMPOSSIBLE>)>
		<RFALSE>)
	       (<AND <IS? .L ,CONTAINER>
		     <IS? .L ,OPENABLE>
		     <NOT <IS? .L ,OPENED>>
		     <NOT <EQUAL? .L <LOC ,WINNER>>>>
		<COND (<T? .VB>
		       <YOUD-HAVE-TO "open" .L>)>
		<RFALSE>)>
	 <COND (<AND <EQUAL? ,WINNER ,UNICORN>
		     <SET X <FIRST? ,WINNER>>>
		<MOVE .X <LOC ,WINNER>>
		<TELL "[putting down " THE .X " first" ,BRACKET>)
	       (<EQUAL? ,WINNER ,PLAYER>
		<COND (<IN? ,ONION ,PLAYER>
		       <COND (<T? .VB>
			      <YOUD-HAVE-TO "put down" ,ONION>)>
		       <RFALSE>)>
		<SET X <WEIGHT ,PRSO>>
		<SET MAX <+ ,LOAD-ALLOWED </ <GET ,STATS ,STRENGTH> 10>>>
		<COND (<AND <NOT <IN? .L ,WINNER>>
			    <G? <+ .X <WEIGHT ,WINNER>> .MAX>>
		       <COND (<T? .VB>
			      <COND (<SET X <FIRST? ,WINNER>>
				     <TELL "Your load is ">)
				    (T
				     <TELL CTHEO>
				     <IS-ARE>)>
			      <TELL "too heavy." CR>)>
		       <RFALSE>)>
		
		<COND (<SET OBJ <FIRST? ,WINNER>>
		       <REPEAT ()
			  <COND (<IS? .OBJ ,NODESC>)
				(<IS? .OBJ ,WORN>)
				(<IS? .OBJ ,TAKEABLE>
				 <INC CNT>)>
			  <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
				 <RETURN>)>>)>
		<SET MAX <+ ,FUMBLE-NUMBER </ <GET ,STATS ,DEXTERITY> 10>>>
		<COND (<G? .CNT .MAX>
		       <COND (<T? .VB>
			      <TELL "Your hands are full." CR>)>
		       <RFALSE>)>)>
       
	 <WINDOW ,SHOWING-ALL>
	 <MAKE ,PRSO ,TOUCHED>
	 <UNMAKE ,PRSO ,NODESC>
	 <UNMAKE ,PRSO ,NOALL>
	 <MOVE ,PRSO ,WINNER>		
	 <RETURN .L>>  "So that .L an be analyzed."

"Return total weight of objects in THING."

<ROUTINE WEIGHT (THING "AUX" (WT 0) OBJ)
	 <COND (<SET OBJ <FIRST? .THING>>
		<REPEAT ()
		   <COND (<AND <EQUAL? .THING ,WINNER>
			       <IS? .OBJ ,WORN>>
			  <INC WT>)
			 (T
			  <SET WT <+ .WT <WEIGHT .OBJ>>>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <RETURN <+ .WT <GETP .THING ,P?SIZE>>>>

<ROUTINE V-WIELD ("AUX" OBJ)
	 <COND (<NOT <IS? ,PRSO ,TAKEABLE>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IN? ,PRSO ,WINNER>>
		<MUST-HOLD ,PRSO>
		<TELL " before you can wield it." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,WORN>
		<YOUD-HAVE-TO "take off" ,PRSO>
		<RTRUE>)
	       (<IS? ,PRSO ,WIELDED>
		<TELL ,ALREADY "wielding " THEO ,PERIOD>
		<RTRUE>)>
	 <COND (<SET OBJ <FIRST? ,WINNER>>
		<REPEAT ()
		   <COND (<IS? .OBJ ,WIELDED>
			  <UNMAKE .OBJ ,WIELDED>
			  <TELL "[setting aside " THE .OBJ " first" ,BRACKET>
			  <RETURN>)>
		   <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
			  <RETURN>)>>)>
	 <WINDOW ,SHOWING-INV>
	 <MAKE ,PRSO ,WIELDED>
	 <TELL "You wield " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-UNWIELD ()
	 <COND (<NOT <IS? ,PRSO ,TAKEABLE>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,WIELDED>>
		<TELL "You're not wielding " THEO ,PERIOD>
		<RTRUE>)>
	 <WINDOW ,SHOWING-INV>
	 <UNMAKE ,PRSO ,WIELDED>
	 <TELL "You set aside " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE SPARK? ("OPT" (INDENT T) (OBJ ,PRSO))
	 <COND (<NO-SPARK? .OBJ>
		<RFALSE>)
	       (<T? .INDENT>
		<TELL ,TAB>)>
	 <ITALICIZE "Snap">
	 <TELL "! You feel a ">
	 <COND (<G? ,STATIC 2>
		<TELL "painful ">)>
	 <TELL "spark as you touch " THE .OBJ ,PERIOD>
	 <UPDATE-STAT <- 0 ,STATIC>>
	 <SPARK-OBJ .OBJ>
	 <RTRUE>>

<ROUTINE SPARK-TO? ("OPT" (OBJ1 ,PRSO) (OBJ2 ,PRSI))
	 <COND (<NO-SPARK? .OBJ2>
		<RFALSE>)
	       (<EQUAL? .OBJ1 ,HANDS ,FEET ,ME>)
	       (<NOT <IS? .OBJ1 ,FERRIC>>
		<RFALSE>)>
	 <SAY-SNAP>
	 <SAY-YOUR .OBJ1>
	 <TELL ,AND THE .OBJ2 "!" CR>
	 <COND (<NOT <IS? .OBJ1 ,FERRIC>>
		<UPDATE-STAT <- 0 ,STATIC>>)>
	 <SPARK-OBJ .OBJ2>
	 <RTRUE>>

<ROUTINE SAY-SNAP ()
	 <ITALICIZE "Snap">
	 <TELL "! A ">
	 <COND (<G? ,STATIC 3>
		<TELL "painful ">)>
	 <TELL "spark leaps between ">
	 <RFALSE>>

<ROUTINE NO-SPARK? (OBJ "AUX" L)
	 <COND (<ZERO? ,STATIC>
		<RTRUE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<EQUAL? .L <> ,LOCAL-GLOBALS ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<EQUAL? ,PLAYER .L <LOC .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SPARK-OBJ (OBJ)
	 <COND (<NOT <IS? .OBJ ,LIVING>>)
	       (<EQUAL? .OBJ ,DUST>
		<VANISH ,DUST>
		<DEQUEUE ,I-DUST>
		<MOVE ,RING ,HERE>
		<SETG P-IT-OBJECT ,RING>
		<SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>
		<TELL "  A bright blue ">
		<ITALICIZE "snap">
		<TELL " of electricity lights the room! ">
		<BLINK ,DUST>
		<TELL " draw">
		<COND (<EQUAL? ,BUNNIES 1>
		       <TELL "s itself">)
		      (T
		       <TELL " themselves">)>
		<TELL 
" together into a hard ring of particles, which falls with a clatter to your feet." CR>
		<UPDATE-STAT <GETP ,DUST ,P?VALUE> ,EXPERIENCE>)
	       (<IS? .OBJ ,MONSTER>
		<MAKE .OBJ ,STRICKEN>
		<PUTP .OBJ ,P?ENDURANCE
		      <- <GETP .OBJ ,P?ENDURANCE> ,STATIC>>)
	       (T
		<TELL ,TAB CTHE .OBJ " looks at you reproachfully." CR>
		<COND (<EQUAL? .OBJ ,UNICORN>
		       <UPDATE-STAT -5 ,LUCK T>)>)>
	 <SETG STATIC 0>
	 <RFALSE>>

<ROUTINE BLINK (OBJ)
	 <TELL "In the blink of an eye, " THE .OBJ>
	 <RFALSE>>

"Takes monster OBJ and NEGATIVE damage, returns net damage."

<ROUTINE MSPARK? (OBJ DAMAGE "AUX" X)
	 <COND (<ZERO? ,STATIC>
		<RETURN .DAMAGE>)>
	 <SET X <+ <GETP .OBJ ,P?ENDURANCE> .DAMAGE>>
	 <TELL ,TAB>
	 <SAY-SNAP>
	 <TELL "you and " THE .OBJ>
	 <COND (<L? .X 1>
		<SET X 1>
		<TELL ", leaving it nearly stunned">)>
	 <TELL ,PERIOD>
	 <PUTP .OBJ ,P?ENDURANCE .X>
	 <SET DAMAGE <- .DAMAGE ,STATIC>>
	 <SETG STATIC 0>
	 <RETURN .DAMAGE>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<SAY-DROPPED>)>
	 <RTRUE>>

<ROUTINE SAY-DROPPED ()
	 <COND (<OR <T? ,P-MULT?>
		    <PROB 50>>
		<TELL "Dropped." CR>
		<RTRUE>)>
	 <TELL ,CYOU>
	 <COND (<PROB 50>
		<TELL "drop ">)
	       (T
		<TELL "put down ">)>
	 <TELL THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE IDROP ("AUX" L)
	 <SET L <LOC ,PRSO>>
	 <COND (<OR <EQUAL? .L <> ,LOCAL-GLOBALS ,GLOBAL-OBJECTS>
		    <PRSO? WINNER ME>>
		<IMPOSSIBLE>
		<RFALSE>)
	       (<NOT <EQUAL? .L ,WINNER>>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <TELL "You'd ">)
		      (T
		       <TELL CTHE ,WINNER " would ">)>
		<TELL "have to take " THEO>
		<OUT-OF-LOC .L>
		<TELL ,SFIRST>
		<RFALSE>)
	       (<AND <IS? ,PRSO ,WORN>
		     <IN? ,PRSO ,WINNER>>
		<COND (<TAKE-OFF-PRSO-FIRST?>
		       <RTRUE>)>)
	       (<PRSO? MINX>
		<UNMAKE ,PRSO ,SEEN>
		<UNMAKE ,PRSO ,TOUCHED>
		<UNMAKE ,PRSO ,TRYTAKE>)
	       (<PRSO? TRUFFLE>
		<UNMAKE ,MINX ,SEEN>)>
	 <UNMAKE ,PRSO ,WIELDED>
	 <WINDOW ,SHOWING-ALL>
	 <SET L <LOC ,WINNER>>
	 <COND (<OR <HERE? IN-SKY ON-BRIDGE APLANE>
		    <EQUAL? .L ,SADDLE>>
		<TELL CTHEO C ,SP>
		<FALLS>
		<RFALSE>)>
	 <MOVE ,PRSO .L>	 
	 <RTRUE>>

<ROUTINE PRSO-SLIDES-OFF-PRSI ()
	 <TELL CTHEO " slide">
	 <COND (<NOT <IS? ,PRSO ,PLURAL>>
		<TELL "s">)>
	 <TELL " off " THEI ,AND>
	 <FALLS>
	 <RTRUE>>

<ROUTINE FALLS ("OPT" (OBJ ,PRSO) (V T) "AUX" S L X)
	 <SET S "s ">
	 <COND (<IS? .OBJ ,PLURAL>
		<SET S " ">)>
	 <SET L <LOC ,WINNER>>
	 <WINDOW ,SHOWING-ALL>
	 <UNMAKE .OBJ ,WIELDED>
	 <UNMAKE .OBJ ,WORN>
	 <COND (<HERE? ON-BRIDGE>
		<VANISH .OBJ>
		<COND (<T? .V>
		       <TELL "slip" .S B ,W?BETWEEN " the ropes and ">)>
		<TELL "fall" .S "out of sight." CR>
		<RTRUE>)
	       (<HERE? IN-SKY APLANE>
		<SET X <DOWN-TO?>>
		<COND (<ZERO? .X>
		       <REMOVE .OBJ>)
		      (T
		       <MOVE .OBJ .X>)>
		<COND (<HERE? IN-SKY>
		       <TELL "fall" .S "out of sight." CR>
		       <RTRUE>)>
		<COND (<EQUAL? .OBJ ,PHASE>
		       <MUNG-PHASE>)>
		<TELL "disappear" .S "in a spectral flash." CR>
		<RTRUE>)
	       (<EQUAL? .L ,SADDLE>
		<SET X <LOC .L>>
		<COND (<IS? .X ,VEHICLE>
		       <MOVE .OBJ <LOC .X>>)
		      (T
		       <MOVE .OBJ .X>)>
		<COND (<T? .V>
		       <TELL "slide" .S "off " THE .L ,AND>)>)
	       (T
		<MOVE .OBJ .L>)>
	 <TELL "land" .S "on the ">
	 <GROUND-WORD>
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE V-CASH ()
	 <COND (<ZERO? ,LOOT>
		<PRINT "You're broke.|">
		<RTRUE>)>
	 <SAY-CASH>
	 <RTRUE>>

<ROUTINE V-INVENTORY ()
	 <COND (<OR <ZERO? ,DMODE>
		    <EQUAL? ,PRIOR ,SHOWING-ROOM ,SHOWING-STATS>>
		<PRINT-INVENTORY>)
	       (T
		<TELL "You take stock of your possessions." CR>
		<SETG DBOX-TOP 0>
		<UPDATE-INVENTORY>
		<COND (<BTST <LOWCORE FLAGS> 1>
		       <DIROUT ,D-SCREEN-OFF>
		       <CRLF>
		       <PRINT-INVENTORY>
		       <DIROUT ,D-SCREEN-ON>)>)>
	 <COND (<NOT <IS? ,MONEY ,TOUCHED>>
		<MAKE ,MONEY ,TOUCHED>
		<TELL ,TAB>
		<NYMPH-APPEARS "financial">
		<TELL 
"By the way, you can check the amount of cash you're holding at any time with the CASH command. Or, just type a $ followed by [RETURN]">
		<PRINT ". Bye!\"|  She disappears with a wink.|">)>
	 <RTRUE>>

<ROUTINE UPDATE-INVENTORY ()
	 <SETG IN-DBOX ,SHOWING-INV>
	 <SETUP-DBOX>
	 <PRINT-INVENTORY>
	 <JUSTIFY-DBOX>	 
	 <DISPLAY-DBOX>
	 <RFALSE>>

<OBJECT WEARING>
<OBJECT HOLDING>

<GLOBAL INV-PRINTING?:FLAG <>>

<ROUTINE PRINT-INVENTORY ("AUX" (HOLDS 0) (WORNS 0) (ANY 0) (B 0) OBJ NXT)
	 <COND (<NOT <SET OBJ <FIRST? ,WINNER>>>
		<NUTHIN>
		<RTRUE>)>
	 <SETG INV-PRINTING? T>
	 <REPEAT ()
	    <SET NXT <NEXT? .OBJ>>
	    <COND (<OR <IS? .OBJ ,NODESC>
		       <NOT <IS? .OBJ ,TAKEABLE>>>
		   <MOVE .OBJ ,DUMMY-OBJECT>)
		  (<AND <IS? .OBJ ,CLOTHING>
			<IS? .OBJ ,WORN>>
		   <INC WORNS>
		   <MOVE .OBJ ,WEARING>)
		  (<AND <EQUAL? .OBJ ,GOBLET>
			<IN? ,BFLY .OBJ>
			<IS? ,BFLY ,LIVING>>
		   <INC B>
		   <MAKE ,BFLY ,NODESC>)>
	    <COND (<AND <SEE-INSIDE? .OBJ>
			<SEE-ANYTHING-IN? .OBJ>>
		   <INC HOLDS>
		   <MOVE .OBJ ,HOLDING>)>
	    <SET OBJ .NXT>
	    <COND (<ZERO? .OBJ>
		   <RETURN>)>>		
	 	 
	 <COND (<SET OBJ <FIRST? ,WINNER>>
		<REPEAT ()
		  <SET NXT <NEXT? .OBJ>>
		  <COND (<IS? .OBJ ,WIELDED>
			 <REMOVE .OBJ>
			 <MOVE .OBJ ,WINNER>)>
		  <SET OBJ .NXT>
		  <COND (<ZERO? .OBJ>
			 <RETURN>)>>
		<INC ANY>
		<TELL "You're carrying ">
		<CONTENTS ,WINNER>
		<PRINT ,PERIOD>)>
	 
	 <COND (<T? .HOLDS>
		<COND (<T? .ANY>
		       <TELL ,TAB "You're also ">)
		      (T
		       <TELL "You're ">)>
		<INC ANY>
		<TELL "carrying ">
		<CONTENTS ,HOLDING>
		<COND (<SET OBJ <FIRST? ,HOLDING>>
		       <REPEAT ()
			  <TELL ". ">
			  <COND (<EQUAL? .OBJ ,GURDY>
				 <TELL "Within">)
				(<IS? .OBJ ,CONTAINER>
				 <TELL "Inside">)
				(T
				 <TELL "Upon">)>
			  <TELL C ,SP THE .OBJ " you see ">
			  <CONTENTS .OBJ>
			  <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
				 <RETURN>)>>)>
		<TELL ,PERIOD>
		<MOVE-ALL ,HOLDING ,WINNER>)>

	 <COND (<T? .WORNS>
		<COND (<T? .ANY>
		       <TELL ,TAB>)>
		<INC ANY>
		<TELL "You're wearing ">
		<CONTENTS ,WEARING>
		<COND (<SET OBJ <FIRST? ,WEARING>>
		       <REPEAT ()
			  <COND (<AND <SEE-INSIDE? .OBJ>
				      <SEE-ANYTHING-IN? .OBJ>>
				 <TELL ". ">
				 <COND (<IS? .OBJ ,CONTAINER>
					<TELL "Inside">)
				       (T
					<TELL "Upon">)>
				 <TELL C ,SP THE .OBJ " you see ">
				 <CONTENTS .OBJ>)>
			  <COND (<NOT <SET OBJ <NEXT? .OBJ>>>
				 <RETURN>)>>)>
		<TELL ,PERIOD>
		<MOVE-ALL ,WEARING ,WINNER>)>
		       
	 <MOVE-ALL ,DUMMY-OBJECT ,WINNER>
	 <COND (<ZERO? .ANY>
		<NUTHIN>)
	       (<T? ,LOOT>
		<TELL ,TAB>
		<SAY-CASH>)>
	 <COND (<T? .B>
		<UNMAKE ,BFLY ,NODESC>)>
	 <SETG INV-PRINTING? <>>
	 <RTRUE>>

<ROUTINE NUTHIN ()
	 <TELL ,DONT "have anything">
	 <COND (<T? ,LOOT>
		<TELL " except ">
		<SAY-LOOT>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE PRE-EXAMINE ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<IS? ,PRSO ,OPENABLE>
	        <TELL "It looks as if " THEO>
		<IS-ARE>
		<COND (<IS? ,PRSO ,OPENED>
		       <PRINTB ,W?OPEN>)
		      (T
		       <PRINTB ,W?CLOSED>)>
	        <PRINT ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,PLACE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<IS? ,PRSO ,READABLE>
		<TELL "There appears to be something written on it." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,SURFACE>
	      	<TELL ,YOU-SEE>
		<CONTENTS>
		<TELL ,SON THEO>
	        <PRINT ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<COND (<OR <IS? ,PRSO ,OPENED>
			   <IS? ,PRSO ,TRANSPARENT>>
		       <V-LOOK-INSIDE>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<LOOK-INTDIR?>
		<RTRUE>)
	       (<AND <IS? ,PRSO ,PERSON>
		     <SEE-ANYTHING-IN?>>
	        <TELL CTHEO " has ">
		<CONTENTS>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <NOTHING-INTERESTING>
	 <TELL " about " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE NOTHING-INTERESTING ()
	 <TELL ,YOU-SEE "nothing " <PICK-NEXT ,YAWNS>>
	 <RFALSE>>

<GLOBAL CAN-UNDO:NUMBER 0>

<ROUTINE V-UNDO ("AUX" X)
	 <COND (<CANT-SAVE?>
		<RTRUE>)>
	 <SETG OLD-HERE <>>
         <SET X <IRESTORE>>
         <COND (<EQUAL? .X -1>
		<NOT-AVAILABLE>
		<RTRUE>)>
	 <FAILED "UNDO">
	 <RTRUE>>

<ROUTINE CANT-SAVE? ("AUX" OBJ NXT X)
	 <COND (<T? ,CHOKE>
		<MUMBLAGE ,SKELETON>
		<RTRUE>)
	       (<SET OBJ <FIRST? ,HERE>>
		<REPEAT ()
		  <COND (<AND <IS? .OBJ ,MONSTER>
			      <IS? .OBJ ,LIVING>
			      <NOT <IS? .OBJ ,SLEEPING>>>
			 <MUMBLAGE .OBJ>
			 <RTRUE>)
			(<NOT <SET OBJ <NEXT? .OBJ>>>
			 <RFALSE>)>>)>
	 <RFALSE>>		  

<ROUTINE MUMBLAGE (OBJ)
	 <PCLEAR>
	 <TELL "You begin to mumble the Spell of ">
	 <COND (<VERB? SAVE>
		<TELL "Sav">)
	       (T
		<TELL "Undo">)>
	 <TELL "ing, but the ">
	 <COND (<T? ,LIT?>
		<TELL "sight of " THE .OBJ " makes">)
	       (T
		<TELL "noises in the darkness make">)>
	 <TELL " your mind wander." CR>
	 <RTRUE>>			 

<ROUTINE V-USE ()
	 <COND (<IS? ,PRSO ,PERSON>
		<TELL CTHEO " might resent that." CR>
		<RTRUE>)>
	 <HOW?>
	 <RTRUE>>

<ROUTINE V-BITE ()
	 <COND (<NOT <SPARK? <>>>
		<HACK-HACK "Biting">)>
	 <RTRUE>>

<ROUTINE V-BLOW-INTO ()
	 <COND (<IS? ,PRSO ,PERSON>
		<SETG P-PRSA-WORD ,W?USE>
		<PERFORM ,V?USE ,PRSO>
		<RTRUE>)>
	 <HACK-HACK "Blowing">
	 <RTRUE>>
		
<ROUTINE V-LIGHT-ON ()
	 <TELL ,CANT "light " THEO " on anything." CR>
	 <RTRUE>>	 

<ROUTINE V-LIGHT-WITH ()
	 <V-BURN-WITH>
	 <RTRUE>>

<ROUTINE V-BURN-WITH ()
         <COND (<T? ,PRSI>
		<TELL  "With " A ,PRSI "? ">)>
	 <TELL <PICK-NEXT ,YUKS> ,PERIOD>
	 <RTRUE>>

<ROUTINE ALREADY-HAVE ("OPT" (OBJ ,PRSO))
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You already have ">)
	       (T
		<TELL CTHE ,WINNER " already has ">)>
	 <TELL A .OBJ ,PERIOD>
	 <RTRUE>>

; <ROUTINE NO-MONEY ()
	 <TELL ,DONT "have any money." CR>
	 <RTRUE>>

<ROUTINE V-CLEAN ()
	 <COND (<NOT <SPARK? <>>>
		<HACK-HACK "Cleaning">)>
	 <RTRUE>>

<ROUTINE V-CLEAN-OFF ()
	 <COND (<PRSO? PRSI>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP THEO ,SON THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<OR <EQUAL? ,P-PRSA-WORD ,W?JUMP ,W?LEAP ,W?HURDLE>
		    <EQUAL? ,P-PRSA-WORD ,W?VAULT ,W?BOUND>>
		<PERFORM ,V?DIVE ,PRSO>
		<RTRUE>)
	       (<PRSO? ROOMS>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?TAKE>
		<PERFORM ,V?HIT ,PRSO>
		<RTRUE>)
	       (<IS? ,PRSO ,VEHICLE>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)>
	 <TELL ,CANT B ,P-PRSA-WORD " onto that." CR>
	 <RTRUE>>

<ROUTINE V-CLIMB-OVER ()
	 <COND (<PRSO? ROOMS>
		<V-WALK-AROUND>
		<RTRUE>)>
	 <TELL ,CANT>
	 <TELL "climb over that." CR>
	 <RTRUE>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<PRSO? ROOMS>
		<DO-WALK ,P?UP>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-OPEN-WITH ()
	 <COND (<NOT <IS? ,PRSO ,OPENABLE>>
		<CANT-OPEN-PRSO>
		<RTRUE>)
	       (<IS? ,PRSO ,OPENED>
		<ITS-ALREADY "open">
		<RTRUE>)>
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP THEO ,WITH THEI ,PERIOD>
	 <RTRUE>>	       

<ROUTINE CANT-OPEN-PRSO ()
	 <TELL ,IMPOSSIBLY "open " AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-OPEN ("AUX" X) 
	 <COND (<NOT <IS? ,PRSO ,OPENABLE>>
		<CANT-OPEN-PRSO>
		<RTRUE>)
	       (<IS? ,PRSO ,OPENED>
		<ITS-ALREADY "open">
		<RTRUE>)
	       (<IS? ,PRSO ,LOCKED>
		<TELL CTHEO " seems to be locked." CR>
		<RTRUE>)>
	 <COND (<SPARK?>
		<TELL ,TAB>)>
	 <TELL "You open " THEO ,PERIOD>
	 <IOPEN>	 
	 <COND (<AND <PRSO? CELLAR-DOOR>
		     <NOT <IS? ,ONION ,TOUCHED>>>
		<TELL ,TAB>
		<COOK-MENTIONS-ONION>)>
	 <RTRUE>>

<ROUTINE IOPEN ("OPT" (OBJ ,PRSO))
	 <WINDOW ,SHOWING-ALL>
	 <MAKE .OBJ ,OPENED>
	 <COND (<AND <IS? .OBJ ,DOORLIKE>
		     <IN? .OBJ ,LOCAL-GLOBALS>>
		<MARK-EXITS>
		<COND (<ZERO? ,DMODE>
		       <LOWER-SLINE>
		       <RFALSE>)>
		<DRAW-MAP>
	        <SHOW-MAP>
		<RFALSE>)
	       (<IS? .OBJ ,CONTAINER>
		<COND (<IS? .OBJ ,TRANSPARENT>
		       <RFALSE>)
		      (<NOT <SEE-ANYTHING-IN? .OBJ>>
		       <RFALSE>)>
		<TELL ,TAB>
		<PRINT "Peering inside, you see ">
		<CONTENTS .OBJ>
		<PRINT ,PERIOD>)>
	 <RFALSE>>

<ROUTINE ICLOSE ("OPT" (OBJ ,PRSO))
	 <WINDOW ,SHOWING-ALL>
	 <UNMAKE .OBJ ,OPENED>
	 <COND (<AND <IS? .OBJ ,DOORLIKE>
		     <IN? .OBJ ,LOCAL-GLOBALS>>
		<COND (<ZERO? ,DMODE>
		       <LOWER-SLINE>
		       <RFALSE>)>
		<DRAW-MAP>
		<SHOW-MAP>)>
	 <RFALSE>>

<ROUTINE V-CLOSE ()
	 <COND (<IS? ,PRSO ,OPENABLE>
		<COND (<IS? ,PRSO ,OPENED>
		       <COND (<SPARK?>
			      <TELL ,TAB>)>
		       <TELL "You close " THEO ,PERIOD>
		       <ICLOSE>
		       <RTRUE>)>
		<ITS-ALREADY "closed">
		<RTRUE>)>
	 <TELL ,CANT>
	 <TELL "close " AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-COUNT ()
	 <COND (<IS? ,PRSO ,PLURAL>
		<TELL "Your mind wanders, and you lose count." CR>
		<RTRUE>)>
	 <ONLY-ONE>
	 <RTRUE>>

<ROUTINE ONLY-ONE ()
	 <TELL "You only see one." CR>
	 <RTRUE>>

<ROUTINE V-COVER ()
	 <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-HOLD-OVER ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-CROSS ()
	 <TELL ,CANT>
	 <TELL "cross that." CR>
	 <RTRUE>>

<ROUTINE V-CUT ()
	 <COND (<PRSI? DAGGER SWORD AXE>
		<NYMPH-APPEARS "safety">
		<TELL "Careful with that " 'PRSI
"!\" she scolds, wagging a tiny finger. \"You might hurt " 'ME>
		<PRINT ". Bye!\"|  She disappears with a wink.|">
		<RTRUE>)>
	 <V-RIP>
	 <RTRUE>>

<ROUTINE V-RIP ()
	 <TELL ,IMPOSSIBLY B ,P-PRSA-WORD C ,SP THEO>
	 <COND (<NOT <PRSI? HANDS>>
		<TELL ,WITH THEI>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-DEFLATE ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-DETONATE ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE PRE-DIG-UNDER ()
	 <RETURN <PRE-DIG>>>

<ROUTINE PRE-DIG ()
	 <COND (<PRSO? PRSI>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<T? ,PRSI>
		<RFALSE>)>
	 <SETG PRSI ,HANDS>
	 <COND (<IN? ,SPADE ,PLAYER>
		<SETG PRSI ,SPADE>)>
	 <TELL "[with " THEI ,BRACKET>
	 <RFALSE>>

<ROUTINE V-DIG-UNDER ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-DIG ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-SDIG ()
	 <PERFORM ,V?DIG ,PRSI ,PRSO>
	 <RFATAL>>

<ROUTINE V-DRINK ("OPT" (FROM? <>))
	 <TELL ,CANT>
	 <TELL "drink ">
	 <COND (<T? .FROM?>
		<TELL "from ">)>
	 <TELL D ,NOT-HERE-OBJECT ,PERIOD>	
	 <RTRUE>>

<ROUTINE V-DRINK-FROM ()
	 <V-DRINK T>
	 <RTRUE>>

<ROUTINE V-EAT ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<NOT-LIKELY>
		<TELL " would agree with you." CR>
		<RTRUE>)>
	 <TELL "\"It" <PICK-NEXT ,LIKELIES>
	       " that " THEO " would agree with me.\"" CR>
	 <RTRUE>>

<ROUTINE V-ENTER ("AUX" X)
	 <COND (<IS? ,PRSO ,VEHICLE>
		<COND (<IN? ,PLAYER ,PRSO>
		       <TELL "You're already">
		       <ON-IN>
		       <TELL ,PERIOD>
		       <RTRUE>)
		      (<NOT <EQUAL? <LOC ,PRSO> ,HERE ,LOCAL-GLOBALS>>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<DROP-ONION-FIRST?>
		       <RTRUE>)>
		<SETG OLD-HERE <>>
		<WINDOW ,SHOWING-ROOM>
		<MOVE ,PLAYER ,PRSO>
		<TELL "You get">
		<ON-IN>
		<RELOOK>		
		<RTRUE>)	
	       (<PRSO? ROOMS>
		<SET X <FIND-IN? ,HERE ,VEHICLE>>
		<COND (<T? .X>
		       <SETG P-PRSA-WORD ,W?ENTER>
		       <PERFORM ,V?ENTER .X>
		       <RTRUE>)>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<IS? ,PRSO ,CLOTHING>
		<PRINT "[Presumably, you mean ">
		<TELL "WEAR " THEO>
		<PRINTC %<ASCII !\.>>
		<PRINT ,BRACKET>
		<SETG P-PRSA-WORD ,W?WEAR>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-ESCAPE ()
	 <COND (<IS? ,PRSO ,PLACE>
		<NOT-IN>
		<RTRUE>)>
	 <V-WALK-AROUND>
	 <RTRUE>>

<ROUTINE PRE-DUMB-EXAMINE ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<LOOK-INTDIR?>
		<RTRUE>)>
	 <COND (<NOT <IS? ,EYES ,SEEN>>
		<MAKE ,EYES ,SEEN>
		<PRINT "[Presumably, you mean ">
		<TELL "LOOK AT " THEO
", not LOOK INSIDE or LOOK UNDER or LOOK BEHIND " THEO>
		<PRINTC %<ASCII !\.>>
		<PRINT ,BRACKET>)>
	 <PERFORM ,V?EXAMINE ,PRSO>
	 <RTRUE>>

<ROUTINE V-DUMB-EXAMINE ()
	 <V-EXAMINE>
	 <RTRUE>>

<ROUTINE LOOK-INTDIR? ("AUX" X)
	 <COND (<PRSO? RIGHT LEFT>)
	       (<NOT <PRSO? INTDIR>>		   
		<RFALSE>)>
	 <SET X <GETP ,HERE ,P?SEE-ALL>>
	 <COND (<T? .X>
		<THIS-IS-IT .X>
		<TELL ,YOU-SEE>
		<COND (<AND <NOT <IS? .X ,NOARTICLE>>
			    <NOT <IS? .X ,PLURAL>>>
		       <TELL ,LTHE>)>
		<TELL D .X " that way." CR>
		<RTRUE>)>
	 <NOTHING-INTERESTING>
	 <TELL ,SIN D ,RIGHT ,PERIOD>
	 <RTRUE>>
		 	       	 
<ROUTINE PRE-EXAMINE-IN ("AUX" L)
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<PRSO? PRSI>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<IN? ,PRSI ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (<AND <IN? ,PRSI ,LOCAL-GLOBALS>
		     <IS? ,PRSI ,PLACE>>
		<RFALSE>)>
	 <SET L <LOC ,PRSO>>
	 <COND (<EQUAL? .L ,PRSI>
		<RFALSE>)
	       (<IN? .L ,PRSI>
		<RFALSE>)>
	 <TELL CTHEO>
	 <ISNT-ARENT>
	 <ON-IN ,PRSI>
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE V-EXAMINE-IN ()
	 <V-EXAMINE>
	 <RTRUE>>

<ROUTINE V-EXIT ("AUX" L)
	 <COND (<PRSO? ROOMS>
		<SET L <LOC ,WINNER>>
		<COND (<IS? .L ,VEHICLE>
		       <PERFORM ,V?EXIT .L>
		       <RTRUE>)>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<AND <T? ,PRSO>
		     <IS? ,PRSO ,VEHICLE>>
		<COND (<NOT <IN? ,WINNER ,PRSO>>
		       <TELL "You're not">
		       <ON-IN>
		       <TELL ,PERIOD>
		       <RTRUE>)>
		<SETG OLD-HERE <>>
		<WINDOW ,SHOWING-ROOM>
		<MOVE ,WINNER <LOC ,PRSO>>
		<TELL "You get">
		<OUT-OF-LOC ,PRSO>
		<RELOOK>
		<RTRUE>)>
	 <SET L <LOC ,PRSO>>
	 <COND (<IS? ,PRSO ,PLACE>
		<NOT-IN>
		<RTRUE>)
	       (<AND <IS? .L ,CONTAINER>
		     <VISIBLE? ,PRSO>>
		<TELL "[from " D .L ,BRACKET>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>
	 <DO-WALK ,P?OUT>
	 <RTRUE>>

<ROUTINE V-FILL-FROM ()
	 <V-FILL>
	 <RTRUE>>

<ROUTINE V-FILL ()
	 <COND (<AND <PRSO? VIAL GOBLET>
		     <VISIBLE? ,POOL>>
		<TELL "[from " THE ,POOL ,BRACKET>
		<SETG P-PRSA-WORD ,W?GET>
		<PERFORM ,V?FILL-FROM ,PRSO ,POOL>
		<RTRUE>)>
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-SUBMERGE ()
	 <COND (<AND <PRSO? CIRCLET>
		     <VISIBLE? ,JAR>>
		<TELL "[into " THE ,JAR ,BRACKET>
		<DIP-CIRCLET>
		<RTRUE>)
	       (<IN? ,POOL ,HERE>
		<TELL "[in " THE ,POOL ,BRACKET>
		<COND (<PRSO? VIAL GOBLET>
		       <PERFORM ,V?FILL-FROM ,PRSO ,POOL>
		       <RTRUE>)>
		<PERFORM ,V?PUT-UNDER ,PRSO ,POOL>
		<RTRUE>)>
	 <TELL ,NOTHING "here in which to " B ,P-PRSA-WORD
	       C ,SP THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-FIND ("AUX" L)
	 <SET L <LOC ,PRSO>>
	 <COND (<ZERO? .L>)
	       (<PRSO? ME HANDS WINNER>
	        <PRINT "You're right here.|">
		<RTRUE>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "You're holding it." CR>
		<RTRUE>)
	       (<OR <IN? ,PRSO ,HERE>
		    <AND <IN? ,PRSO ,LOCAL-GLOBALS>
			 <GLOBAL-IN? ,HERE ,PRSO>>
		    <IN? ,PRSO <LOC ,WINNER>>>
		<ITS-RIGHT-HERE>
		<RTRUE>)
	       (<AND <OR <IS? .L ,PERSON>
			 <IS? .L ,LIVING>>
		     <VISIBLE? .L>>
	        <TELL CTHE .L " has it." CR>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
	        <SAY-ITS>
		<ON-IN .L>
		<TELL ,PERIOD>
		<RTRUE>)>
         <DO-IT-YOURSELF>
	 <RTRUE>>

<ROUTINE DO-IT-YOURSELF ()
         <TELL "You'll have to do that " D ,ME ,PERIOD>
	 <RTRUE>>

<ROUTINE ITS-RIGHT-HERE ()
	 <SAY-ITS>
	 <TELL " right here in front of you." CR>
	 <RTRUE>>

<ROUTINE SAY-ITS ()
         <COND (<IS? ,PRSO ,PLURAL>
		<TELL "They're">
		<RTRUE>)
	       (<IS? ,PRSO ,FEMALE>
		<TELL "She's">
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<TELL "He's">
		<RTRUE>)>
	 <TELL "It's">
	 <RTRUE>>
	 
<ROUTINE V-LAND ()
	 <COND (<HERE? IN-SKY>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>
	 <NOT-FLYING>
	 <RTRUE>>

<ROUTINE NOT-FLYING ()
	 <TELL "You're not flying" ,AT-MOMENT>
	 <RTRUE>>

<ROUTINE V-LAND-ON ()
	 <COND (<NOT <HERE? IN-SKY>>
		<NOT-FLYING>
		<RTRUE>)
	       (<PRSO? GROUND FLOOR>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>
	 <V-WALK-AROUND>
	 <RTRUE>>			 

<ROUTINE V-BANK ()
	 <COND (<AND <PRSO? INTDIR>
		     <T? ,P-DIRECTION>
		     <HERE? IN-SKY>>
		<V-WALK>
		<RTRUE>)>
	 <NOT-FLYING>
	 <RTRUE>>

<ROUTINE V-FLY ()
	 <COND (<AND <PRSO? ROOMS>
		     <IN? ,PLAYER ,SADDLE>
		     <IN? ,SADDLE ,DACT>>
		<COND (<HERE? IN-SKY>
		       <TELL "Try looking down." CR>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)>
	 <TELL "Psst! Guess what? " ,CANT "fly unassisted." CR>
	 <RTRUE>>

<ROUTINE V-FLY-UP ()
	 <COND (<AND <PRSO? ROOMS>
		     <IN? ,PLAYER ,SADDLE>
		     <IN? ,SADDLE ,DACT>>
		<DO-WALK ,P?UP>
		<RTRUE>)>
	 <V-FLY>
	 <RTRUE>>

<ROUTINE V-FLY-DOWN ()
	 <COND (<AND <PRSO? ROOMS>
		     <IN? ,PLAYER ,SADDLE>
		     <IN? ,SADDLE ,DACT>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>
	 <V-FLY>
	 <RTRUE>>

<ROUTINE V-FOLD ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-FOLLOW ()
	 <COND (<ZERO? ,PRSO>
		<CANT-SEE-ANY>
		<RFATAL>)>
         <TELL "But ">
	 <COND (<PRSO? ME WINNER>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <TELL "you're">)
		      (T
		       <TELL THE ,WINNER " is">)>
		<PRINT " right here.|">
		<RTRUE>)
	       (T
		<TELL THEO>
		<COND (<IS? ,PRSO ,PLURAL>
		       <TELL " are">)
		      (T
		       <TELL " is">)>
	 	<COND (<OR <VISIBLE? ,PRSO>
		    	   <IN? ,PRSO ,GLOBAL-OBJECTS>>
		       <PRINT " right here.|">
		       <RTRUE>)>)>
         <TELL "n't visible" ,AT-MOMENT>
	 <RTRUE>>

<ROUTINE PRE-FEED ()
	 <COND (<PRE-GIVE T>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-FEED ()
         <COND (<PRSI? ME WINNER>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <TELL "You">)
		      (T
		       <TELL CTHE ,WINNER>)>)
	       (T
		<TELL CTHEI>)>
	 <TELL " can't eat that." CR>
	 <RTRUE>>

<ROUTINE V-SFEED ()
	 <PERFORM ,V?FEED ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-GIVE ("OPT" (FEED? <>))
	 <COND (<OR <ZERO? ,PRSO>
		    <ZERO? ,PRSI>>
		<REFERRING>
		<RTRUE>)
	       (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,PRSI>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<IN? ,PRSI ,GLOBAL-OBJECTS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IS? ,PRSI ,LIVING>>
		<TELL ,CANT>
		<COND (<T? .FEED?>
		       <TELL "feed ">)
		      (T
		       <TELL "give ">)>
		<TELL "anything to " A ,PRSI ,PERIOD>
	        <RTRUE>)
	       (<PRSO? MONEY INTNUM>
		<RFALSE>)
	       (<PRSI? ME WINNER>
		<COND (<IN? ,PRSO ,WINNER>
		       <ALREADY-HAVE>
		       <RTRUE>)>)
	       (<DONT-HAVE?>
		<RTRUE>)>
	 <COND (<AND <IS? ,PRSO ,WORN>
		     <IN? ,PRSO ,WINNER>>
		<RETURN <TAKE-OFF-PRSO-FIRST?>>)
	       (T
		<RFALSE>)>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-GIVE ()
	 <COND (<PRSI? ME>
		<NOBODY-TO-ASK>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<TELL CTHEI " shows little interest in your offer." CR>
		<RTRUE>)>
	  <NOT-LIKELY ,PRSI>
	  <TELL " would accept your offer." CR>
	  <RTRUE>>

<ROUTINE PRE-SHOW ()
	 <COND (<OR <ZERO? ,PRSO>
		    <ZERO? ,PRSI>>
		<REFERRING>
		<RTRUE>)
	       (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,PRSI>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<IN? ,PRSI ,GLOBAL-OBJECTS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IS? ,PRSI ,LIVING>>
		<TELL ,CANT>
		<TELL "show things to " A ,PRSI ,PERIOD>
		<RTRUE>)
	       (<PRSO? MONEY INTNUM>
		<RFALSE>)
	       (<PRSI? ME WINNER>
		<COND (<IN? ,PRSO ,WINNER>
		       <ALREADY-HAVE>
		       <RTRUE>)>
		<RFALSE>)
	       (<DONT-HAVE?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHOW ()
	 <TELL CTHEI " glance">
	 <COND (<NOT <IS? ,PRSI ,PLURAL>>
		<TELL "s">)>
	 <TELL " at " THEO ", but make">
	 <COND (<NOT <IS? ,PRSI ,PLURAL>>
		<TELL "s">)>
	 <TELL " no comment." CR>
	 <RTRUE>>

<ROUTINE V-REFUSE ()
	 <COND (<NOT <IS? ,PRSO ,TAKEABLE>>
		<WASTE-OF-TIME>
		<RTRUE>)>
         <TELL "How could you turn down such a tempting " D ,PRSO "?" CR>
	 <RTRUE>>

<ROUTINE V-HIDE ()
	 <COND (<HERE? <LOC ,ARCH>>
		<TELL "[under " THE ,ARCH ,BRACKET>
		<ENTER-ARCH>
		<RTRUE>)
	       (<HERE? IN-GARDEN>
		<TELL "[behind " THE ,BUSH ,BRACKET>
		<ENTER-BUSH>
		<RTRUE>)>
	 <TELL "There aren't any good hiding places here." CR>
	 <RTRUE>>

<ROUTINE V-KICK ()
	 <COND (<SPARK? <>>
		<RTRUE>)
	       (<IS? ,PRSO ,MONSTER>
		<PERFORM ,V?HIT ,PRSO ,FEET>
		<RTRUE>)>
	 <HACK-HACK "Kicking">
	 <RTRUE>>

<ROUTINE V-BOUNCE ()
	 <COND (<PRSO? ROOMS>
		<WASTE-OF-TIME>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-KNOCK ()
	 <COND (<SPARK? <>>
		<RTRUE>)
	       (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)>
	        <TELL "There's no answer." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<PERFORM ,V?USE ,PRSO>
		<RTRUE>)>
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-KISS ()
	 <COND (<NOT <SPARK? <>>>
		<WASTE-OF-TIME>)>
	 <RTRUE>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<PRSO? ROOMS>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <TELL "You pause">)
		      (T
		       <TELL CTHE ,WINNER " pauses">)>
		<TELL " for a moment." CR>
		<RTRUE>)>
	 <V-LAMP-ON T>
	 <RTRUE>>

<ROUTINE V-LAMP-ON ("OPT" (OFF? <>))
	 <TELL ,IMPOSSIBLY "turn that ">
	 <COND (<T? .OFF?>
		<TELL "off">)
	       (T
		<TELL "on">)>
	 <COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		<TELL ", " D ,PRSI " or no " D ,PRSI>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-LEAP ()
	 <COND (<NOT <PRSO? ROOMS>>
	        <TELL "That'd be a cute trick." CR>
		<RTRUE>)
	       (<HERE? OVER-JUNGLE>
		<JUNGLE-JUMP>
		<RTRUE>)
	       (<HERE? ON-BRIDGE>
		<JUMP-OFF-BRIDGE>
		<RTRUE>)>
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-LEAVE ()
	 <COND (<IS? ,PRSO ,PLACE>
		<NOT-IN>
		<RTRUE>)
	       (<OR <PRSO? ROOMS>
		    <NOT <IS? ,PRSO ,TAKEABLE>>>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<DONT-HAVE?>
		<RTRUE>)>
	 <PERFORM ,V?DROP ,PRSO>
	 <RTRUE>>

<ROUTINE V-SLEEP ()
         <V-LIE-DOWN>
	 <RTRUE>>

<ROUTINE V-LIE-DOWN ()
       	 <TELL "This is no time for that." CR>
	 <RTRUE>>

<ROUTINE V-LISTEN ("AUX" (OBJ <>))
	 <COND (<PRSO? ROOMS SOUND>
		<SET OBJ <GETP ,HERE ,P?HEAR>>
		<COND (<ZERO? .OBJ>
		       <TELL ,DONT "hear anything "
			     <PICK-NEXT ,YAWNS> ,PERIOD>
		       <RTRUE>)>
		<PERFORM ,V?LISTEN .OBJ>
	        <RTRUE>)
	       (<IS? ,PRSO ,LIVING>
		<TELL "No doubt " THEO " appreciate">
		<COND (<NOT <IS? ,PRSO ,PLURAL>>
		       <TELL "s">)>
		<TELL " your attention." CR>
		<RTRUE>)>
	 <TELL "At the moment, " THEO>
	 <IS-ARE>
	 <TELL "silent." CR>
	 <RTRUE>>

<ROUTINE V-LOCK ()
	 <COND (<OR <IS? ,PRSO ,OPENABLE>
		    <IS? ,PRSO ,CONTAINER>>
		<COND (<IS? ,PRSO ,OPENED>
		       <YOUD-HAVE-TO "close">
		       <RTRUE>)
		      (<IS? ,PRSO ,LOCKED>
		       <TELL CTHEO>
		       <IS-ARE>
		       <TELL "already locked." CR>
		       <RTRUE>)>
		<THING-WONT-LOCK ,PRSI ,PRSO>
		<RTRUE>)>
	 <CANT-LOCK>
	 <RTRUE>>

<ROUTINE V-UNLOCK ()
	 <COND (<OR <IS? ,PRSO ,OPENABLE>
		    <IS? ,PRSO ,CONTAINER>>
		<COND (<OR <IS? ,PRSO ,OPENED>
		           <NOT <IS? ,PRSO ,LOCKED>>>
		       <TELL CTHEO>
		       <ISNT-ARENT>
		       <TELL " locked." CR>
		       <RTRUE>)>
		<THING-WONT-LOCK ,PRSI ,PRSO T>
		<RTRUE>)>
	 <CANT-LOCK T>
	 <RTRUE>>

<ROUTINE CANT-LOCK ("OPT" (UN? <>))
	 <TELL ,CANT>
	 <COND (<T? .UN?>
		<TELL "un">)>
	 <TELL "lock " AO ,PERIOD>
	 <RTRUE>>

<ROUTINE THING-WONT-LOCK (THING CLOSED-THING "OPT" (UN? <>))
	 <NOT-LIKELY .THING>
	 <TELL " could ">
	 <COND (<T? .UN?>
		<TELL "un">)>
	 <TELL "lock " THE .CLOSED-THING ,PERIOD>
	 <RTRUE>>

; <ROUTINE V-SCREW-WITH ()
	 <NOT-LIKELY ,PRSI>
	 <TELL " could help you do that." CR>
	 <RTRUE>>

; <ROUTINE V-UNSCREW ()
	 <TELL ,CANT "unscrew " THEO>
	 <COND (<NOT <PRSI? HANDS>>
		<TELL ", with or without " THEI>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

; <ROUTINE V-UNSCREW-FROM ()
	 <COND (<PRSO? PRSI>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IN? ,PRSO ,PRSI>>
		<COND (<IS? ,PRSI ,LIVING>
		       <TELL CTHEI " doesn't have " THEO ,PERIOD>
		       <RTRUE>)>
		<TELL CTHEO>
		<ISNT-ARENT>
		<ON-IN ,PRSI>
		<TELL ,PERIOD>
		<RTRUE>)>
	 <TELL ,CANT "unscrew " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-UNTIE ()
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-LOOK-ON ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<IS? ,PRSO ,SURFACE>
		<TELL ,YOU-SEE>
		<CONTENTS>
		<TELL ,SON THEO ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,READABLE>
		<TELL CTHEO>
		<IS-ARE>
		<TELL "undecipherable." CR>
		<RTRUE>)>
	 <NOTHING-INTERESTING>
	 <TELL ,SON THEO ,PERIOD>
	 <RTRUE>>	       

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)>
	 <TELL ,NOTHING "behind " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-LOOK-DOWN ("AUX" X)
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<IS? ,PRSO ,PLACE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<PRSO? ROOMS>
		<SET X <GETP ,HERE ,P?BELOW>>
		<COND (<T? .X>
		       <PERFORM ,V?EXAMINE .X>
		       <RTRUE>)
		      (<IS? ,HERE ,INDOORS>
		       <PERFORM ,V?EXAMINE ,FLOOR>
		       <RTRUE>)>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)>
	 <PERFORM ,V?LOOK-INSIDE ,PRSO>
	 <RTRUE>>

<ROUTINE V-LOOK-UP ("AUX" (X <>))
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<PRSO? ROOMS>
		<SET X <GETP ,HERE ,P?OVERHEAD>>
		<COND (<T? .X>
		       <PERFORM ,V?EXAMINE .X>
		       <RTRUE>)>
		<NOTHING-INTERESTING>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <TELL ,CANT "look up " AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<IS? ,PRSO ,PLACE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<NOT-A "surgeon">
		<RTRUE>)
	       (<IS? ,PRSO ,LIVING>
		<NOT-A "veterinarian">
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<COND (<AND <NOT <IS? ,PRSO ,OPENED>>
			    <NOT <IS? ,PRSO ,TRANSPARENT>>>
		       <ITS-CLOSED>
		       <RTRUE>)
		      (<SEE-ANYTHING-IN?>
		       <TELL ,YOU-SEE>
		       <CONTENTS>
		       <TELL ,SIN THEO ,PERIOD>
		       <RTRUE>)>
		<TELL CTHEO " is empty." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)>
	 <TELL ,CANT "look inside " AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-LOOK-OUTSIDE ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<PRSO? ROOMS>
		<COND (<IS? ,HERE ,INDOORS>
		       <NOTHING-INTERESTING>
		       <TELL C ,SP>)
		      (T
		       <TELL ,ALREADY>)>
		<TELL B ,W?OUTSIDE ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)>
	 <TELL ,CANT "look out of " AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-SLOOK-THRU ()
	 <PERFORM ,V?LOOK-THRU ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-LOOK-THRU ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<AND <T? ,PRSI>
		     <NOT <IS? ,PRSI ,TRANSPARENT>>>
		<TELL ,CANT "look through that." CR>
		<RTRUE>)>
	 <NOTHING-INTERESTING>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)>
	 <NOTHING-INTERESTING>
	 <TELL " under " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-WEDGE ()
	 <PERFORM ,V?LOOSEN ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-LOOSEN ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-LOWER ()
	 <COND (<PRSO? ROOMS>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>
	 <V-RAISE>
	 <RTRUE>>

<ROUTINE V-MAKE ()
	 <HOW?>
	 <RTRUE>>

<ROUTINE V-MELT ()
	 <HOW?>
	 <RTRUE>>

<ROUTINE V-MOVE ()
	 <COND (<PRSO? ROOMS>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<IS? ,PRSO ,TAKEABLE>
		<TELL "Moving " THEO " would" <PICK-NEXT ,HO-HUM> 
		      ,PERIOD>
		<RTRUE>)>
	 <TELL ,IMPOSSIBLY B ,P-PRSA-WORD C ,SP THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-MUNG ()
	 <COND (<IS? ,PRSO ,MONSTER>
		<PERFORM ,V?HIT ,PRSO ,PRSI>
		<RTRUE>)
	       (<NOT <SPARK? <>>>
		<HACK-HACK "Trying to destroy">)>
	 <RTRUE>>
	       

<ROUTINE V-PICK ()
	 <COND (<IS? ,PRSO ,OPENABLE>
		<NOT-A "locksmith">
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-POINT ()
	 <COND (<T? ,PRSI>
		<COND (<IS? ,PRSI ,PERSON>
		       <TELL CTHEI>
		       <COND (<PRSO? PRSI>
			      <TELL " looks confused." CR>
			      <RTRUE>)>
		       <TELL ,GLANCES-AT THEO ", but doesn't respond." CR>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI>
		<PRINT " would respond.|">
		<RTRUE>)>
	 <TELL "You point at " THEO>
	 <NOTHING-HAPPENS>
	 <RTRUE>>

<ROUTINE NOTHING-HAPPENS ("OPT" (BUT T))
	 <COND (<ZERO? .BUT>
		<PRINTC %<ASCII !\N>>)
	       (T
		<TELL ", but n">)>
	 <TELL "othing " <PICK-NEXT ,YAWNS> " happens." CR>
	 <RTRUE>>

<ROUTINE V-SPOINT-AT ()
	 <PERFORM ,V?POINT-AT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-POINT-AT ()
	 <COND (<AND <ZERO? ,LIT?>
		     <NOT <EQUAL? ,PRSI <> ,ME>>>
		<TOO-DARK>
		<RTRUE>)
	       (T
		<RFALSE>)>>		

<ROUTINE V-POINT-AT ()
	 <COND (<PRSO? ME HANDS>
		<V-POINT>
		<RTRUE>)>
	 <TELL ,CYOU B ,P-PRSA-WORD C ,SP THEO " at " THEI>
	 <NOTHING-HAPPENS>
	 <RTRUE>>

<ROUTINE V-POP ()
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-POUR ()
	 <COND (<PRSO? HANDS>
		<TELL "[To do that, just DROP EVERYTHING.]" CR>
		<RFATAL>)
	       (<IS? ,PRSO ,SURFACE>
		<EMPTY-PRSO ,GROUND>
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<COND (<IS? ,PRSO ,OPENED>
		       <EMPTY-PRSO ,GROUND>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)>	
	 <TELL ,CANT "empty that." CR>
	 <RTRUE>>

<ROUTINE V-POUR-FROM ()
	 <COND (<PRSO? PRSI>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<PRSI? HANDS>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<AND <NOT <IS? ,PRSI ,CONTAINER>>
		     <NOT <IS? ,PRSI ,SURFACE>>>
		<TELL ,CANT B ,P-PRSA-WORD " things from " A ,PRSI ,PERIOD>
		<RTRUE>)
	       (<AND <IS? ,PRSI ,CONTAINER>
		     <NOT <IS? ,PRSI ,OPENED>>>
		<ITS-CLOSED ,PRSI>
		<RTRUE>)
	       (<IN? ,PRSO ,PRSI>
		<COND (<IS? ,PRSO ,TAKEABLE>
		       <TELL CTHEO C ,SP>
		       <FALLS>		
		       <RTRUE>)>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <TELL CTHEO " isn't in " THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE V-EMPTY-INTO ()
	 <COND (<PRSI? HANDS ME>
		<V-EMPTY>
		<RTRUE>)
	       (<PRSI? GROUND FLOOR GLOBAL-ROOM>
		<COND (<HERE? IN-SKY>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<V-EMPTY <LOC ,WINNER>>
		<RTRUE>)
	       (<IS? ,PRSI ,SURFACE>
		<V-EMPTY ,PRSI>
		<RTRUE>)
	       (<IS? ,PRSI ,CONTAINER>
		<COND (<IS? ,PRSI ,OPENED>
		       <V-EMPTY ,PRSI>
		       <RTRUE>)>
		<ITS-CLOSED ,PRSI>
		<RTRUE>)>
	 <TELL ,CANT "empty " THEO>
	 <ON-IN ,PRSI>
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE V-EMPTY ("OPT" (DEST 0))
         <COND (<IS? ,PRSO ,PERSON>)
	       (<IS? ,PRSO ,LIVING>)
	       (<IS? ,PRSO ,MONSTER>)
	       (<IS? ,PRSO ,SURFACE>
		<EMPTY-PRSO .DEST>
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<COND (<IS? ,PRSO ,OPENED>
		       <EMPTY-PRSO .DEST>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)>
	 <TELL ,IMPOSSIBLY "empty " THEO ,PERIOD>
	 <RTRUE>>
		
<ROUTINE EMPTY-PRSO (DEST "AUX" (ANY 0) OBJ NXT X ICAP ILOAD OSIZE)
	 <COND (<T? .DEST>
		<SET X <LOC .DEST>>
		<COND (<OR <ZERO? .X>
			   <EQUAL? ,PRSO .DEST>>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<OR <EQUAL? .X ,PRSO>
			   <IN? .X ,PRSO>>
		       <YOUD-HAVE-TO "remove" .DEST>
		       <RTRUE>)>)
	       (T
		<SET DEST ,WINNER>)>
	 <COND (<NOT <SEE-ANYTHING-IN?>>
	 	<TELL "There's nothing">
		<ON-IN>
		<TELL ,PERIOD>
		<RTRUE>)>
	 <SETG P-MULT? T>
	 <COND (<NOT <EQUAL? .DEST ,WINNER <LOC ,WINNER>>>
		<SET ILOAD <WEIGHT .DEST>>
		<SET ILOAD <- .ILOAD <GETP .DEST ,P?SIZE>>>
		<SET ICAP <GETP .DEST ,P?CAPACITY>>)>
	 <COND (<SET OBJ <FIRST? ,PRSO>>
		<REPEAT ()
		   <SET NXT <NEXT? .OBJ>>
		   <COND (<NOT <IS? .OBJ ,TAKEABLE>>)
			 (<NOT <IS? .OBJ ,NODESC>>
			  <INC ANY>
			  <SET OSIZE <GETP .OBJ ,P?SIZE>>
			  <COND (<NOT <IS? .OBJ ,NOARTICLE>>
				 <TELL ,XTHE>)>
			  <TELL D .OBJ ": ">
			  <COND (<EQUAL? .DEST ,WINNER>
				 <SET X <PERFORM ,V?TAKE .OBJ ,PRSO>>
				 <COND (<EQUAL? .X ,M-FATAL>
					<RETURN>)>)
				(<EQUAL? .DEST <LOC ,WINNER>>
				 <COND (<IS? .OBJ ,PLURAL>
					<TELL "They ">)
				       (T
					<TELL "It ">)>
				 <FALLS .OBJ>)
				(<G? .OSIZE .ICAP>
				 <TELL CTHE .OBJ>
				 <IS-ARE .OBJ>
				 <TELL "too big to fit in "
				       THE .DEST ,PERIOD>)
				(<G? <+ .ILOAD .OSIZE> .ICAP>
				 <NO-ROOM-IN .DEST>)
				(T
				 <UNMAKE .OBJ ,WIELDED>
				 <MOVE .OBJ .DEST>
				 <TELL "Done." CR>)>)>
		   <SET OBJ .NXT>
		   <COND (<ZERO? .OBJ>
			  <RETURN>)>>)>
	 <WINDOW ,SHOWING-ALL>
	 <SETG P-MULT? <>>
	 <COND (<ZERO? .ANY>
		<TELL ,NOTHING "you can take." CR>)>
	 <RTRUE>>
	 
<ROUTINE V-PULL ()
	 <COND (<NOT <SPARK? <>>>
		<HACK-HACK "Pulling on">)>
	 <RTRUE>>

<ROUTINE V-PUSH ()
	 <COND (<NOT <SPARK? <>>>
		<HACK-HACK "Pushing around">)>
	 <RTRUE>>

<ROUTINE V-PUSH-TO ()
	 <COND (<AND <PRSO? HANDS>
		     <T? ,PRSI>>
		<PERFORM ,V?REACH-IN ,PRSI>
		<RTRUE>)>
	 <PUSHOVER>
	 <RTRUE>>

<ROUTINE PUSHOVER ()
	 <TELL ,CANT "push " THEO " around like that." CR>
	 <RTRUE>>

<ROUTINE V-PUSH-UP ()
	 <COND (<AND <PRSO? HANDS>
		     <T? ,PRSI>>
		<PERFORM ,V?RAISE ,PRSI>
		<RTRUE>)>
	 <PUSHOVER>
	 <RTRUE>>

<ROUTINE V-PUSH-DOWN ()
	 <COND (<AND <PRSO? HANDS>
		     <T? ,PRSI>>
		<PERFORM ,V?LOWER ,PRSI>
		<RTRUE>)>
	 <PUSHOVER>
	 <RTRUE>>

<ROUTINE PRE-PUT ("AUX" L)
	 <SET L <LOC ,PRSO>>
	 <COND (<PRSO? PRSI>
		<HOW?>
		<RTRUE>)
	       (<PRSI? INTDIR RIGHT LEFT>
		<NYMPH-APPEARS>
		<TELL "You really must specify an object">
		<PRINT ". Bye!\"|  She disappears with a wink.|">
		<RTRUE>)
	       (<PRSI? HANDS HEAD>
		<COND (<AND <PRSI? HEAD>
			    <PRSO? HELM>>
		       <PERFORM ,V?WEAR ,PRSO>
		       <RTRUE>)>
		<NOT-LIKELY>
		<TELL " would fit very well." CR>
		<RTRUE>)
	       (<OR <EQUAL? ,FEET ,PRSO ,PRSI>
		    <EQUAL? ,HEAD ,PRSO ,PRSI>>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<ZERO? ,LIT?>
		<COND (<AND <PRSI? GRUE URGRUE>
			    <WEARING-MAGIC? ,HELM>>)
		      (<IN? ,PRSI ,WINNER>)
		      (T
		       <TOO-DARK>
		       <RTRUE>)>)>
	 <COND (<PRSO? MONEY INTNUM>
		<BENJAMIN>
		<RTRUE>)
	       (<PRSI? GROUND FLOOR>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<IN? ,PRSI ,GLOBAL-OBJECTS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<PRSO? HANDS>
		<PERFORM ,V?REACH-IN ,PRSI>
		<RTRUE>)
	       (<EQUAL? .L ,PRSI>
		<TELL CTHEO>
		<IS-ARE>
		<TELL "already">
		<ON-IN ,PRSI>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<OR <EQUAL? ,PRSO ,PRSI>
		    <EQUAL? .L ,GLOBAL-OBJECTS>
		    <NOT <IS? ,PRSO ,TAKEABLE>>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <ACCESSIBLE? ,PRSI>>
		<CANT-SEE-ANY ,PRSI>
		<RTRUE>)
	       (<AND <IS? ,PRSO ,WORN>
		     <EQUAL? .L ,WINNER>
		     <NOT <PRSI? ME WINNER>>>
		<RETURN <TAKE-OFF-PRSO-FIRST?>>)
	       (<AND <IN? .L ,WINNER>
		     <VISIBLE? ,PRSO>>
		<TAKING-OBJ-FIRST ,PRSO>
		<COND (<ITAKE>
		       <RFALSE>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TAKE-OFF-PRSO-FIRST? ("AUX" X)
	 <SET X <GETP ,PRSO ,P?EFFECT>>
	 <COND (<ZERO? .X>)
	       (<PRSO? CLOAK>)
	       (<AND <IN? ,CLOAK ,PLAYER>
		     <IS? ,CLOAK ,WORN>>
		<YOUD-HAVE-TO "take off" ,CLOAK>
		<RTRUE>)>
	 <UNMAKE ,PRSO ,WORN>
	 <WINDOW ,SHOWING-INV>
	 <TELL "[taking off " THEO " first]" CR>         
	 <COND (<AND <PRSO? AMULET>
		     <T? ,AMULET-TIMER>>
		<NORMAL-STRENGTH>
		<RTRUE>)
	       (<HOTFOOT? T>
		<RTRUE>)
	       (<AND <PRSO? HELM>
		     <NOT <IS? ,PRSO ,NEUTRALIZED>>>
		<NORMAL-IQ>)>
	 <COND (<T? .X>
		<UPDATE-STAT <- 0 .X> ,ARMOR-CLASS>)>
	 <TELL ,TAB>
	 <RFALSE>>

<ROUTINE PRE-PUT-ON ()
	 <COND (<PRE-PUT>
		<RTRUE>)
	       (<PRSI? CHEST>
		<RFALSE>)
	       (<NOT <IS? ,PRSI ,SURFACE>>		    
		<NO-GOOD-SURFACE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NO-GOOD-SURFACE ("OPT" (OBJ ,PRSI))
	 <TELL "There's no good surface on " THE .OBJ ,PERIOD>
	 <RTRUE>>

<ROUTINE V-PUT-ON () 
	 <COND (<PRSI? ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)>
	 <V-PUT>
	 <RTRUE>>

<ROUTINE V-PUT ("AUX" OL ICAP ILOAD OSIZE)
	 <SET OL <LOC ,PRSO>>
	 <COND (<OR <ZERO? .OL>
		    <AND <T? ,PRSI>
		     	 <NOT <IS? ,PRSI ,SURFACE>>
		     	 <NOT <IS? ,PRSI ,CONTAINER>>>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<AND <NOT <IS? ,PRSI ,OPENED>>
		     <NOT <IS? ,PRSI ,SURFACE>>>
		<THIS-IS-IT ,PRSI>
		<TELL CTHEI>
		<ISNT-ARENT ,PRSI>
		<TELL " open." CR>
		<RTRUE>)	       
	       (<NOT <EQUAL? .OL ,WINNER>>
		<TELL "Maybe you should take " THEO>
		<OUT-OF-LOC .OL>
		<TELL ,SFIRST>
		<RTRUE>)>
	 <SET ILOAD <WEIGHT ,PRSI>>
	 <SET ILOAD <- .ILOAD <GETP ,PRSI ,P?SIZE>>>
         <SET ICAP <GETP ,PRSI ,P?CAPACITY>>
	 <SET OSIZE <GETP ,PRSO ,P?SIZE>>
	 <COND (<G? .OSIZE .ICAP>
		<TELL CTHEO>
		<IS-ARE>
		<TELL "too big to fit">
		<ON-IN ,PRSI>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<G? <+ .ILOAD .OSIZE> .ICAP>
		<NO-ROOM-IN ,PRSI>
		<RTRUE>)>
	 <WINDOW ,SHOWING-ALL>
	 <UNMAKE ,PRSO ,WIELDED>
	 <MOVE ,PRSO ,PRSI>
	 <MAKE ,PRSO ,TOUCHED>
	 <COND (<T? ,P-MULT?>
		<TELL "Done." CR>
		<RTRUE>)>
	 <TELL "You put " THEO>
	 <ON-IN ,PRSI>
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE NO-ROOM-IN (OBJ)
	 <TELL "There isn't enough room">
	 <ON-IN .OBJ>
	 <TELL ,PERIOD>
	 <RTRUE>>

; <ROUTINE V-SCREW ()
	 <TELL ,CANT "screw ">
	 <O-INTO-I>
	 <RTRUE>>

<ROUTINE V-PLUG-IN ()
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP>
	 <O-INTO-I>
	 <RTRUE>>
	
<ROUTINE NEVER-FIT ()
	 <TELL "You'd never fit ">
	 <O-INTO-I>
	 <RTRUE>>

<ROUTINE O-INTO-I ("OPT" NOCR)
	 <TELL THEO ,SINTO THEI>
	 <COND (<NOT <ASSIGNED? NOCR>>
		<TELL ,PERIOD>)>
	 <RFALSE>>

<ROUTINE V-UNPLUG ()
	 <TELL CTHEO>
	 <ISNT-ARENT>
	 <TELL " connected to ">
	 <COND (<T? ,PRSI>
		<TELL THEI>)
	       (T
		<TELL "anything">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>
	 <RTRUE>>

<ROUTINE V-PUT-UNDER ()
         <TELL ,CANT "put anything under that." CR>
	 <RTRUE>>
	       
<ROUTINE V-RAPE ()
	 <TELL "What a wholesome idea." CR>
	 <RTRUE>>

<ROUTINE V-RAISE ()
	 <COND (<PRSO? ROOMS>
		<V-STAND>
		<RTRUE>)
	       (<NOT <SPARK? <>>>
		<HACK-HACK "Toying in this way with">)>
	 <RTRUE>>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<OR <IS? ,PRSO ,PERSON>
		    <IS? ,PRSO ,LIVING>>
		<NOT-A "surgeon">
		<RTRUE>)
	       (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <REACH-INTO-PRSO>
		       <TELL ", but experience nothing "
			     <PICK-NEXT ,YAWNS> ,PERIOD>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,CONTAINER>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,OPENED>>
		<TELL "It's not open." CR>
		<RTRUE>)
	       (<AND <IN? ,PRSO ,PLAYER>
		     <IS? ,PRSO ,WORN>>
		<YOUD-HAVE-TO "take off">
		<RTRUE>)
	       (<OR <ZERO? .OBJ>
		    <NOT <IS? .OBJ ,TAKEABLE>>>
		<PRINT "It's empty.|">
		<RTRUE>)>
	 <THIS-IS-IT .OBJ>
	 <REACH-INTO-PRSO>
	 <TELL " and feel " B ,W?SOMETHING ,PERIOD>
	 <RTRUE>>

<ROUTINE REACH-INTO-PRSO ()
	 <TELL "You reach into " THEO>
	 <RTRUE>>

<ROUTINE V-READ ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<NOT <IS? ,PRSO ,READABLE>>
		<HOW-READ>
		<TELL "?" CR>
		<RTRUE>)>
	 <TELL ,NOTHING "written on it." CR>
	 <RTRUE>>

<ROUTINE V-READ-TO ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<NOT <IS? ,PRSO ,READABLE>>
		<HOW-READ>
		<TELL ,STO A ,PRSI "?" CR>
		<RTRUE>)
	       (<EQUAL? ,WINNER ,PLAYER>
		<NOT-LIKELY ,PRSI>
		<TELL " would appreciate your reading." CR>
		<RTRUE>)>
	 <TELL "Maybe you ought to do it." CR>
	 <RTRUE>>

<ROUTINE HOW-READ ()
	 <TELL "How can you read " AO>
	 <RTRUE>>

<ROUTINE V-RELEASE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>
	 <COND (<PRSO? ME>
		<TELL "You aren't">)
	       (T
		<TELL CTHEO>
		<ISNT-ARENT>)>
	 <TELL " being held by anything." CR>
	 <RTRUE>>
		
<ROUTINE V-REPLACE ()
	 <COND (<PRSO? ME>
		<TELL "Easily done." CR>
		<RTRUE>)>
	 <TELL CTHEO " doesn't need replacement." CR>
	 <RTRUE>>

<ROUTINE V-REPAIR ()
	 <COND (<PRSO? ME>
		<TELL "You aren't">)
	       (T
		<TELL CTHEO>
		<ISNT-ARENT>)>
	 <TELL " in need of repair." CR>
	 <RTRUE>>

<ROUTINE V-HELP ()
	 <TELL 
"[If you're really stuck, maps and InvisiClues(TM) Hint Booklets are available at most Infocom dealers, or use the order form included in your game package.]" CR>
	 <RTRUE>>

<ROUTINE V-RESCUE ()
	 <COND (<PRSO? ME>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <V-HELP>
		       <RTRUE>)>
		<HOW?>
		<RTRUE>)>
	 <TELL CTHEO>
	 <COND (<IS? ,PRSO ,PLURAL>
		<TELL " do">)
	       (T
		<TELL " does">)>
	 <TELL "n't need any help." CR>
	 <RTRUE>>

<ROUTINE V-RIDE ()
	 <COND (<IS? ,PRSO ,LIVING>
		<NOT-LIKELY>
		<TELL " wants to play piggyback." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,VEHICLE>
		<PERFORM ,V?ENTER ,PRSO>
		<RTRUE>)>
	 <TELL ,CANT "ride that." CR>
	 <RTRUE>>

<ROUTINE V-TOUCH ()
	 <COND (<NOT <SPARK? <>>>
		<HACK-HACK "Fiddling with">)>
	 <RTRUE>>

<ROUTINE V-STOUCH-TO ()
	 <PERFORM ,V?TOUCH-TO ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-TOUCH-TO ()
	 <COND (<SPARK-TO?>
		<RTRUE>)>
	 <TELL ,CYOU B ,P-PRSA-WORD C ,SP THEO " against " THEI>
	 <NOTHING-HAPPENS>
	 <RTRUE>>	 

<ROUTINE V-SCRATCH ()
	 <COND (<NOT <SPARK? <>>>
		<TELL ,CYOU B ,P-PRSA-WORD " your fingers across " THEO>
		<BUT-NOTHING-HAPPENS>)>
	 <RTRUE>>

<ROUTINE BUT-NOTHING-HAPPENS ()
	 <TELL ", but nothing " <PICK-NEXT ,YAWNS> " happens." CR>
	 <RTRUE>>

<ROUTINE BUT-FIND-NOTHING ()
	 <TELL ", but nothing " <PICK-NEXT ,YAWNS> " turns up." CR>
	 <RTRUE>>

<ROUTINE V-PEEL ()
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-SCRAPE-ON ()
	 <COND (<SPARK-TO?>
		<RTRUE>)
	       (<PRSO? HANDS>
		<PERFORM ,V?TOUCH ,PRSI>
		<RTRUE>)
	       (<PRSO? FEET>
		<PERFORM ,V?KICK ,PRSI>
		<RTRUE>)>
	 <TELL ,CYOU B ,P-PRSA-WORD C ,SP THEO>
	 <COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		<TELL ,SON THEI>)>
	 <NOTHING-HAPPENS>
	 <RTRUE>>

<ROUTINE V-BOW ()
	 <HACK-HACK "Paying respect to">
	 <RTRUE>>

<ROUTINE V-SEARCH ()
	 <COND (<IS? ,PRSO ,PLACE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<COND (<AND <NOT <IS? ,PRSO ,OPENED>>
			    <NOT <IS? ,PRSO ,TRANSPARENT>>>
		       <YOUD-HAVE-TO "open">
		       <RTRUE>)>
		<TELL ,YOU-SEE>
		<CONTENTS>
		<TELL " inside " THEO ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,SURFACE>
		<TELL ,YOU-SEE>
		<CONTENTS>
		<TELL ,SON THEO ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<PERFORM ,V?USE ,PRSO>
		<RTRUE>)>
	 <NOTHING-INTERESTING>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-SHAKE ()
	 <COND (<SPARK? <>>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<PERFORM ,V?ALARM ,PRSO>
		<RTRUE>)
	       (<AND <NOT <IS? ,PRSO ,TAKEABLE>>
		     <NOT <IS? ,PRSO ,TRYTAKE>>>
		<HACK-HACK "Shaking">
		<RTRUE>)>
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-SFIRE-AT ()
	 <PERFORM ,V?FIRE-AT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-FIRE-AT ()
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP THEO " at anything." CR>
	 <RTRUE>>

<ROUTINE V-ZAP-WITH ()
	 <TELL ,CANT "zap things with " A ,PRSI ,PERIOD>
	 <RTRUE>>

<ROUTINE V-SIT ()
	 <COND (<PRSO? ROOMS>
		<COND (<HERE? IN-CHAPEL>
		       <ENTER-PEW>
		       <RTRUE>)>)>
	 <NO-PLACE-TO-PRSA>
	 <RTRUE>>

<ROUTINE NO-PLACE-TO-PRSA ()
	 <TELL "There's no place to " B ,P-PRSA-WORD " here." CR>
	 <RTRUE>>

<ROUTINE V-SMELL ("AUX" X)
	 <COND (<PRSO? ROOMS>
		<SET X <GETP ,HERE ,P?ODOR>>
		<COND (<ZERO? .X>
		       <TELL ,DONT "smell anything "
			     <PICK-NEXT ,YAWNS> ,PERIOD>
		       <RTRUE>)>
		<PERFORM ,V?SMELL .X>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,LIVING>>
		<TELL "It">)
	       (<IS? ,PRSO ,FEMALE>
		<TELL "She">)
	       (T
		<TELL "He">)>
	 <TELL " smells just like " AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-PLANT ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-UPROOT ()
	 <TELL CTHEO " isn't rooted anywhere." CR>
	 <RTRUE>>

<ROUTINE V-SPIN ()
	 <COND (<PRSO? ROOMS ME>
		<TELL "You begin to feel a little dizzy." CR>
		<RTRUE>)>
	 <TELL ,CANT "spin that." CR>
	 <RTRUE>>

<ROUTINE V-SQUEEZE ()
	 <COND (<NOT <SPARK? <>>>
		<WASTE-OF-TIME>)>
	 <RTRUE>>

<ROUTINE V-DUCK ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<PRSO? ROOMS>
		<COND (<IN? ,PLAYER ,PEW>
		       <EXIT-PEW>
		       <RTRUE>)>)>
	 <ALREADY-STANDING>
	 <RTRUE>>

<ROUTINE ALREADY-STANDING ()
	 <TELL ,ALREADY "standing." CR>
	 <RTRUE>>

<ROUTINE V-STAND-ON ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-STAND-UNDER ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-SWING ()
	 <COND (<ZERO? ,PRSI>
		<WASTE-OF-TIME>
		<RTRUE>)>
	 <PERFORM ,V?HIT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-DIVE ()
	 <COND (<PRSO? ROOMS>
		<COND (<HERE? IN-SKY>
		       <DISMOUNT-DACT>
		       <RTRUE>)>)>
	 <V-SWIM> 
	 <RTRUE>>

<ROUTINE V-SWIM ()
	 <COND (<PRSO? ROOMS>
		<COND (<HERE? ON-BRIDGE>
		       <JUMP-OFF-BRIDGE>
		       <RTRUE>)
		      (<HERE? JUN0>
		       <ENTER-QUICKSAND>
		       <RTRUE>)
		      (<HERE? ON-WHARF AT-LEDGE AT-BRINE>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>
		<NO-PLACE-TO-PRSA>
		<RTRUE>)
	       (<AND <PRSO? INTDIR>
		     <T? ,P-DIRECTION>
		     <EQUAL? ,WINNER ,PLAYER>>
		<TELL ,CANT B ,P-PRSA-WORD " that way from here." CR>
		<RTRUE>)> 
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-SGET-FOR ()
	 <PERFORM ,V?TAKE ,PRSI>
	 <RTRUE>>

<ROUTINE V-GET-FOR ()
	 <PERFORM ,V?TAKE ,PRSO>
	 <RTRUE>>

<ROUTINE V-TAKE-WITH ()
	 <HOW?>
	 <RTRUE>>

<ROUTINE V-TAKE-OFF ("AUX" X)
	 <COND (<PRSO? ROOMS>
		<SET X <LOC ,WINNER>>
		<COND (<AND <EQUAL? ,P-PRSA-WORD ,W?GET>
			    <NOT <EQUAL? .X ,HERE>>
			    <IS? .X ,VEHICLE>>
		       <PERFORM ,V?EXIT .X>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<PRSO? HANDS FEET>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<IS? ,PRSO ,PLACE>
		<NOT-IN>
		<RTRUE>)
	       (<IS? ,PRSO ,TAKEABLE>
		<SET X <LOC ,PRSO>>
		<COND (<ZERO? .X>
		       <REFERRING>
		       <RTRUE>)
		      (<AND <EQUAL? .X ,WINNER>
			    <IS? ,PRSO ,CLOTHING>>
		       <COND (<IS? ,PRSO ,WORN>
			      <COND (<HOTFOOT?>
				     <RTRUE>)>
			      <TAKEOFF>
			      <SET X <GETP ,PRSO ,P?EFFECT>>
			      <COND (<T? .X>
				     <UPDATE-STAT <- 0 .X> ,ARMOR-CLASS>)>
			      <RTRUE>)>
		       <PRINT "You're not wearing ">
		       <TELL THEO ,PERIOD>
		       <RTRUE>)
		      (<NOT <IS? .X ,SURFACE>>
		       <TELL CTHEO " isn't \"on\" anything." CR>
		       <RTRUE>)>		      
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<IS? ,PRSO ,VEHICLE>
		<PERFORM ,V?EXIT ,PRSO>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE TAKEOFF ()
	 <WINDOW ,SHOWING-INV>
	 <UNMAKE ,PRSO ,WORN>
	 <TELL "You take off " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE HOTFOOT? ("OPT" INDENT)
	 <COND (<AND <PRSO? RING>
		     <T? ,MAGMA-TIMER>
		     <HERE? FOREST-EDGE ON-TRAIL ON-PEAK>>
		<COND (<ASSIGNED? INDENT>
		       <TELL ,TAB>)>
		<TELL "You slip " THEO " off " 'HANDS ,PTAB>
		<ITALICIZE "Whoosh">
		<TELL 
"! Your flesh bakes in the volcanic heat of the lava underfoot">
		<JIGS-UP>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-TASTE ()
	 <PERFORM ,V?EAT ,PRSO>
	 <RTRUE>>

<ROUTINE V-ADJUST ()
	 <COND (<NOT <SPARK? <>>>
		<TELL CTHEO " doesn't need adjustment." CR>)>
	 <RTRUE>>

"*** CHARACTER INTERACTION DEFAULTS ***"

<ROUTINE SILLY-SPEAK? ()
	 <COND (<EQUAL? ,PRSO <> ,ROOMS>
		<RFALSE>)
	       (<NOT <IS? ,PRSO ,PERSON>>
		<NOT-LIKELY>
	 	<PRINT " would respond.|">
		<PCLEAR>
		<RTRUE>)
	       (<PRSO? ME PRSI WINNER>
		<WASTE-OF-TIME>
		<PCLEAR>
		<RTRUE>)
	       (T
		<THIS-IS-IT ,PRSO>
		<RFALSE>)>>

<ROUTINE V-ASK-ABOUT ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)
	       (<EQUAL? ,WINNER ,PRSI>
		<WASTE-OF-TIME>
		<RFATAL>)
	       (<OR <PRSO? ME>
		    <EQUAL? ,WINNER ,PLAYER>>
		<TALK-TO-SELF>
		<RTRUE>)>
	 <NO-RESPONSE>
	 <RTRUE>>

<ROUTINE V-REPLY ("AUX" WHO)
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)>
	 <NO-RESPONSE ,PRSO>
	 <RTRUE>>
		       
<ROUTINE V-QUESTION ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TO-DO-THING-USE "ask about" "ASK CHARACTER ABOUT">
		<RFATAL>)>
	 <NO-RESPONSE>
	 <RTRUE>>
		        
<ROUTINE V-ALARM ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)>
	 <COND (<PRSO? ROOMS ME>
		<TELL ,ALREADY "wide awake." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,LIVING>
		<TELL CTHEO>
		<IS-ARE>
		<TELL "already wide awake." CR>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-YELL ()
	 <COND (<PRSO? ROOMS>
		<TELL "You begin to get a sore throat." CR>
		<COND (<HERE? ON-WHARF>
		       <TELL ,TAB>
		       <NOT-DEAF>)>
		<RTRUE>)>
	 <V-SAY>
	 <RTRUE>>

<ROUTINE V-LAUGH ()
	 <COND (<PRSO? ROOMS>
		<TELL 
"There's a place for people who " B ,P-PRSA-WORD " without reason." CR>
		<RTRUE>)
	       (<EQUAL? ,P-PRSA-WORD ,W?INSULT ,W?OFFEND>
		<COND (<IS? ,PRSO ,MONSTER>
		       <TELL CTHEO " look">
		       <COND (<NOT <IS? ,PRSO ,PLURAL>>
			      <TELL "s">)>
		       <TELL " mad enough already." CR>
		       <RTRUE>)
		      (<IS? ,PRSO ,LIVING>
		       <TELL CTHEO " remain">
		       <COND (<NOT <IS? ,PRSO ,PLURAL>>
			      <TELL "s">)>
		       <TELL " silent. Maybe you should too." CR>
		       <RTRUE>)>
		<NOT-LIKELY>
		<TELL " would be offended.">
		<RTRUE>)>
	 <V-SAY>
	 <RTRUE>>

<ROUTINE PRE-NAME ()
	 <COND (<ZERO? ,PRSI>
		<SEE-MANUAL "name things">
		<RTRUE>)
	       (<NOT <PRSI? QWORD>>
		<HOLLOW-VOICE "reserved by the Implementors">
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 		
<ROUTINE V-NAME ("OPT" (OBJ ,PRSO) 
		 "AUX" TBL WORD BASE LEN PTR CHAR COMPLEX BAD ANY X)
	 <PCLEAR>
	 <SET TBL <GETP .OBJ ,P?NAME-TABLE>>
	 <COND (<OR <NOT <IS? .OBJ ,NAMEABLE>>
		    <ZERO? .TBL>>
		<TELL "Alas; " THE .OBJ>
		<COND (<IS? ,PRSO ,PERSON>
		       <TELL " already ha">
		       <COND (<IS? ,PRSO ,PLURAL>
			      <TELL "ve">)
			     (T
			      <TELL "s">)>
		       <TELL " a Name." CR>
		       <RTRUE>)>
		<TELL " cannot be Named." CR>
		<RTRUE>)
	       (<IS? .OBJ ,NAMED>
		<TELL "You've already assigned a Name to " THE .OBJ
		      ". To alter that Name, you must first Unmake ">
		<PRONOUN .OBJ T>
		<TELL 
", a dangerous procedure requiring years of magical training. Someday, perhaps..." CR>
		<RTRUE>)>
	 	 
	 <COPYT .TBL 0 %<+ ,NAMES-LENGTH 1>>
	 
       ; "Convert word typed into a byte LTABLE in AUX-TABLE."

	 <SET BASE <REST ,P-LEXV <* ,P-QWORD 2>>>
	 <SET LEN <GETB .BASE 2>> ; "Length of word typed."
	 <PUTB ,AUX-TABLE 0 .LEN> ; "Save it here."
	 <SET BASE <REST ,P-INBUF <GETB .BASE 3>>> ; "And start"
	 <COPYT .BASE <REST ,AUX-TABLE 1> .LEN>
	 <PUTB ,AUX-TABLE <+ .LEN 1> 0> ; "Zero-terminate."

       ; "Scan for obviously silly names."

	 <SET PTR .LEN>
	 <SET BAD 0>
	 <SET ANY 0>
	 <REPEAT ()
	    <SET CHAR <GETB ,AUX-TABLE .PTR>>
	    <COND (<AND <G? .CHAR %<- <ASCII !\a> 1>>
			<L? .CHAR %<+ <ASCII !\z> 1>>>
		   <INC ANY>)
		  (T
		   <INC BAD>
		   <RETURN>)>
	    <COND (<DLESS? PTR 1>
		   <RETURN>)>>
	 <COND (<OR <ZERO? .ANY>
		    <T? .BAD>>
		<HOLLOW-VOICE "too complex">
		<RTRUE>)
	       (<G? .LEN %<- ,NAMES-LENGTH 1>>
		<HOLLOW-VOICE "too long">
		<RTRUE>)>
       
	; "Copy AUX-TABLE into TBL w/appropriate caps."

	  <SET PTR 1>
	  <REPEAT ()
	     <SET CHAR <GETB ,AUX-TABLE .PTR>>
	     <COND (<EQUAL? .PTR 1>
		    <SET CHAR <- .CHAR 32>>)>
	     <PUTB .TBL .PTR .CHAR>
	     <COND (<IGRTR? PTR .LEN>
		    <RETURN>)>>
	  <PUTB .TBL 0 .LEN>
	  <PUTB .TBL <+ .LEN 1> 0> ; "Zero-terminate."
	  
	  <SET WORD <ADD-VOCAB ,AUX-TABLE .OBJ>>
	  <ADD-CAP? .WORD>
	  <MAKE .OBJ ,NAMED>
	  <MAKE .OBJ ,NOARTICLE>
	  <MAKE .OBJ ,PROPER>
	  <WINDOW ,SHOWING-ALL>
	  <TELL "You invoke the Spell of Naming, and the ">
	  <COND (<AND <EQUAL? .OBJ ,BFLY>
		      <IS? ,BFLY ,MUNGED>>
		 <PRINT "caterpillar">)
		(<AND <EQUAL? .OBJ ,PHASE>
		      <NOT <HERE? APLANE>>>
		 <TELL B ,W?OUTLINE>)
		(T
		 <PRINTD .OBJ>)>
	  <TELL 
" basks in the glow of a new-forged synonym. Henceforth, you may refer to ">
	  <PRONOUN .OBJ T>
	  <TELL " as \"">
	  <PRINT-TABLE .TBL>
	  <TELL ,PERQ>
	  <RTRUE>>

"Adds the ASCII byte-LTABLE string at TBL to the alternate charset, using
 the PS? field of synonym .WRD. Returns base address of new word."

<ROUTINE ADD-VOCAB (TBL OBJ "AUX" WRD SYNS SIBS ELEN CNT BASE LEN)
	 <SET SYNS <GETPT .OBJ ,P?SYNONYM>>
	 <SET WRD <GET .SYNS 0>>
	 <SET SIBS <GETB ,VOCAB2 0>> ; "Size of SIB table."
	 <SET ELEN <GETB <REST ,VOCAB2 <+ .SIBS 1>> 0>> ; "Entry length."
	 <SET CNT <GET <REST ,VOCAB2 <+ .SIBS 2>> 0>> ; "# entries."
	 
	 <SET BASE <REST ,VOCAB2 <+ .SIBS 4>>> 
	 <COND (<T? .CNT>
		<SET BASE <REST .BASE <* .ELEN <- 0 .CNT>>>>)>

	 <ZWSTR .TBL <GETB .TBL 0> 1 .BASE>
	 
	 <SET TBL <REST .WRD 6>> ; "Point to PS? field of synonym."
	 <SET LEN <- .ELEN 6>> ; "Length of PS? field."
	 <COPYT .TBL <REST .BASE 6> .LEN> ; "Copy PS? field of synonym."
	 
	 <DEC CNT> ; "List is unsorted, so CNT is negative."
	 <PUT <REST ,VOCAB2 <+ .SIBS 2>> 0 .CNT> ; "Update count."
	 <PUT .SYNS 1 .BASE>
	 <RETURN .BASE>>

<ROUTINE V-GOODBYE ()
	 <V-HELLO>
	 <RTRUE>>

<ROUTINE V-HELLO ()
         <COND (<SILLY-SPEAK?>
	        <RFATAL>)
	       (<PRSO? ROOMS>
		<TALK-TO-SELF>
		<RTRUE>)>
	 <NO-RESPONSE ,PRSO>
	 <RTRUE>>
	 
<ROUTINE V-WAVE-AT ()
	 <V-WHAT>
	 <RTRUE>>

<ROUTINE V-REQUEST ("AUX" L)
	 <SET L <LOC ,PRSO>>
	 <COND (<NOT <VISIBLE? .L>>
		<CANT-SEE-ANY>
		<RTRUE>)
	       (<IS? .L ,PERSON>
		<SPOKEN-TO .L>
		<PERFORM ,V?ASK-FOR .L ,PRSO>
		<RTRUE>)
	       (<IS? ,PRSO ,TAKEABLE>)
	       (<IS? ,PRSO ,TRYTAKE>)
	       (T
		<NOT-LIKELY>
		<TELL " could be moved." CR>
		<RTRUE>)>
	 <TELL ,DONT "have to ask for " THEO ". Just take ">
	 <COND (<IS? ,PRSO ,PLURAL>
		<TELL B ,W?THEM>)
	       (T
		<TELL B ,W?IT>)>
	 <COND (<OR <IS? .L ,SURFACE>
		    <IS? .L ,CONTAINER>>
		<OUT-OF-LOC .L>)>
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE V-SASK-FOR ()
	 <PERFORM ,V?ASK-FOR ,PRSI ,PRSO>
	 <RTRUE>>	       

<ROUTINE V-ASK-FOR ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)
	       (<OR <EQUAL? ,WINNER ,PRSI>
		    <NOT <IS? ,PRSI ,TAKEABLE>>>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <NO-RESPONSE ,PRSO>
	 <RTRUE>>

<ROUTINE V-TELL ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)
	       (<PRSO? ME>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <TALK-TO-SELF>
		       <RTRUE>)>)
	       (T
		<SEE-CHARACTER ,PRSO>
		<COND (<T? ,P-CONT>
		       <SETG WINNER ,PRSO>
		       <RTRUE>)>)>
	 <NO-RESPONSE ,PRSO>
	 <RTRUE>>

<ROUTINE V-TELL-ABOUT ()
	 <COND (<NOT <EQUAL? ,WINNER ,PLAYER>>
		<TELL CTHE ,WINNER>
		<COND (<PRSO? ME>
		       <TELL
" shrugs. \"I don't know anything about " THEI " you don't know." CR>
		       <RTRUE>)>
		<TELL " snorts. \"Don't be ridiculous.\"" CR>
		<RTRUE>)>
	 <V-WHAT>
	 <RTRUE>>

<ROUTINE V-THANK ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)
	       (<EQUAL? ,WINNER ,PLAYER>
		<COND (<PRSO? ME>
		       <TELL "Self-congratulations">
		       <WONT-HELP>
		       <RTRUE>)>
		<TELL "There's no need to thank " THEO ,PERIOD>
		<RTRUE>)>
	 <RTRUE>>

<ROUTINE V-WHO ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "Who, indeed?" CR> 
		<RTRUE>)>
	 <NO-RESPONSE>
	 <RTRUE>>

<ROUTINE V-WHERE ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<COND (<VISIBLE? ,PRSO>
		       <COND (<IS? ,PRSO ,PLURAL>
			      <TELL "They're ">)
			     (<IS? ,PRSO ,FEMALE>
			      <TELL "She's ">)
			     (<IS? ,PRSO ,PERSON>
			      <TELL "He's ">)
			     (T
			      <TELL "It's ">)>
		       <TELL "right here." CR>
		       <RTRUE>)>
		<TELL "Where, indeed?" CR>
		<RTRUE>)>
	 <NO-RESPONSE>
	 <RTRUE>>

<ROUTINE V-WHAT ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "What, indeed?" CR>
		<RTRUE>)>
	 <NO-RESPONSE>
	 <RTRUE>>

<ROUTINE NO-RESPONSE ("OPT" (OBJ ,WINNER))
	 <PCLEAR>
	 <SEE-CHARACTER .OBJ>
	 <TELL CTHE .OBJ>
	 <PRINT " looks at you expectantly. ">
	 <CRLF>	 
	 <RTRUE>>

<ROUTINE V-THROUGH ("AUX" X)
	 <COND (<PRSO? ROOMS>
		<SET X <LOC ,PLAYER>>
		<COND (<IS? .X ,VEHICLE>
		       <PERFORM ,V?ENTER .X>
		       <RTRUE>)>
		<DO-WALK ,P?IN>
		<RTRUE>)
	     ; (<IS? ,PRSO ,OPENABLE>
	        <DO-WALK <OTHER-SIDE ,PRSO>>
		<RTRUE>)
	       (<IS? ,PRSO ,VEHICLE>
	        <PERFORM ,V?ENTER ,PRSO>
	        <RTRUE>)
	     ; (<IN? ,PRSO ,WINNER>
	        <TELL "That would involve quite a contortion." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,LIVING>
		<V-RAPE>
		<RTRUE>)
	     ; (<NOT <IS? ,PRSO ,TAKEABLE>>
	        <TELL "You hit " 'HEAD " against " THEO
		      " as you attempt this feat." CR>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-STHROW ()
	 <PERFORM ,V?THROW ,PRSI ,PRSO>
	 <RTRUE>>
		
<ROUTINE PRE-THROW-OVER ()
	 <RETURN <PRE-PUT>>>

<ROUTINE V-THROW-OVER ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE PRE-THROW ()
	 <RETURN <PRE-PUT>>>

<ROUTINE V-THROW ()
	 <COND (<IS? ,PRSI ,DOORLIKE>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<IDROP>
		<TELL "Thrown" ,PTAB CTHEO " lands on the ">
		<COND (<IS? ,HERE ,INDOORS>
		       <TELL 'FLOOR>)
		      (T
		       <TELL 'GROUND>)>
		<TELL " nearby." CR>)>
	 <RTRUE>>
	 
<ROUTINE V-TIE ()
	 <TELL ,IMPOSSIBLY "tie " THEO>
	 <COND (<T? ,PRSI>
		<TELL ,STO THEI>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-TIE-UP ()
	 <TELL ,CANT "tie anything with that." CR>
	 <RTRUE>>

<ROUTINE V-TURN ()
	 <COND (<AND <NOT <IS? ,PRSO ,TAKEABLE>>
		     <NOT <IS? ,PRSO ,TRYTAKE>>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<SPARK? <>>
		<RTRUE>)>
	 <HACK-HACK "Turning">
	 <RTRUE>>

<ROUTINE V-TURN-TO ()
	 <COND (<VISIBLE? ,PRSO>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)>
	 <TELL ,DONT "see " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-WALK-AROUND ()
	 <PCLEAR>
	 <TELL "Which way do you want to go?" CR>
	 <RTRUE>>

<ROUTINE V-WALK-TO ()
	 <COND (<PRSO? ROOMS>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<PRSO? INTDIR>
		<DO-WALK ,P-DIRECTION>
		<RTRUE>)
	       (<PRSO? RIGHT LEFT>
		<MORE-SPECIFIC>
		<RTRUE>)>
	 <V-FOLLOW>
	 <RTRUE>>

<ROUTINE V-WAIT ("OPT" (N 3) "AUX" (X <>))
	 <TELL "Time passes." CR>
	 <REPEAT ()
	    <COND (<OR <T? .X>
		       <L? .N 1>>
		   <RTRUE>)
		  (<CLOCKER>
		   <SET X T>
		   <SETG CLOCK-WAIT? T>)>
	    <DEC N>>
	 <RTRUE>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<PRSO? INTNUM>
		<COND (<ZERO? ,P-NUMBER>
		       <SETG CLOCK-WAIT? T>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<G? ,P-NUMBER 120>
		       <SETG CLOCK-WAIT? T>
		       <TELL "[That's too long to WAIT.]" CR>
		       <RTRUE>)>
		<V-WAIT <- ,P-NUMBER 1>>
		<RTRUE>)
	       (<VISIBLE? ,PRSO>
		<TELL CTHEO>
		<IS-ARE>
		<TELL "already here." CR>
		<RTRUE>)>
	 <TELL "You may be waiting quite a while." CR>
	 <RTRUE>>

<ROUTINE V-WEAR ("AUX" X)
	 <COND (<AND <IN? ,PRSO ,WINNER>
		     <IS? ,PRSO ,WORN>>
		<TELL ,ALREADY "wearing " THEO ,PERIOD>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,CLOTHING>>
		<TELL ,CANT "wear " THEO ,PERIOD>
		<RTRUE>)
	       (<DONT-HAVE?>
		<RTRUE>)>
	 <PUTON>
	 <SET X <GETP ,PRSO ,P?EFFECT>>
	 <COND (<T? .X>
		<UPDATE-STAT .X ,ARMOR-CLASS>)>
	 <RTRUE>>

<ROUTINE PUTON ()
	 <WINDOW ,SHOWING-INV>
	 <MAKE ,PRSO ,WORN>
	 <TELL "You put on " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE WEARING-MAGIC? (OBJ)
	 <COND (<AND <IN? .OBJ ,PLAYER>
		     <IS? .OBJ ,WORN>
		     <NOT <IS? .OBJ ,NEUTRALIZED>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-WIND ()
	 <TELL ,CANT "wind " AO ,PERIOD>
	 <RTRUE>>

<ROUTINE YOU-CLIMB-UP ("OPT" (NOCR 0))
	 <TELL ,CYOU>
	 <COND (<PROB 33>
		<TELL B ,W?ASCEND>)
	       (T
		<COND (<PROB 50>
		       <TELL B ,W?CLAMBER>)
		      (T
		       <TELL B ,W?CLIMB>)>
		<TELL " up">)>
	 <TELL " the steps." CR>
	 <COND (<T? .NOCR>
		<RTRUE>)
	       (<T? ,VERBOSITY>
		<CRLF>)>
	 <RTRUE>>
		
<ROUTINE HACK-HACK (STR)
	 <TELL .STR C ,SP THEO " would" <PICK-NEXT ,HO-HUM> ,PERIOD>
	 <RTRUE>>

<ROUTINE IMPOSSIBLE ()
	 <TELL <PICK-NEXT ,YUKS> ,PERIOD>
	 <RTRUE>> 
	 
<ROUTINE TOO-DARK ()
	 <PCLEAR>
	 <TELL "It's too dark to see." CR>
	 <RTRUE>>

; <ROUTINE CANT-GO ()
	 <COND (<IS? ,HERE ,INDOORS>
		<TELL "There's no exit ">)
	       (T
		<TELL ,CANT "go ">)>
	 <TELL "that way." CR>
	 <RTRUE>>

; <ROUTINE ALREADY-OPEN ()
	 <ITS-ALREADY "open">
	 <RTRUE>>

; <ROUTINE ALREADY-CLOSED ()
	 <ITS-ALREADY "closed">
	 <RTRUE>>

<ROUTINE ITS-ALREADY (STR)
	 <TELL "It's already " .STR ,PERIOD>
	 <RTRUE>>

<ROUTINE REFERRING ()
	 <TELL "[To what are you referring?]" CR>
	 <RTRUE>>

<ROUTINE MORE-SPECIFIC ()
	 <NYMPH-APPEARS>
	 <TELL "You really must be more specific">
	 <PRINT ". Bye!\"|  She disappears with a wink.|">
	 <RTRUE>>

<ROUTINE WASTE-OF-TIME ()
	 <TELL <PICK-NEXT ,POINTLESS> ,PERIOD>
	 <RTRUE>>

<ROUTINE WHAT-TALK? (WHO OBJ)
	 <MAKE .WHO ,SEEN>
	 <COND (<VISIBLE? .OBJ>
		<RFALSE>)>
	 <PERPLEXED .WHO>
	 <TELL "I'm afraid I'm not sure">
	 <WHO-WHAT .OBJ>
	 <TELL "you're talking about.\"" CR>
	 <RTRUE>>

<ROUTINE PERPLEXED (WHO "AUX" STR X)
	 <PCLEAR>
	 <SET STR <PICK-NEXT ,PUZZLES>>
	 <TELL CTHE .WHO>
	 <SET X <RANDOM 100>>
	 <COND (<L? .X 33>
		<TELL " gives you a " .STR "ed look">)
	       (<L? .X 67>
		<COND (<PROB 50>
		       <TELL " look">)
		      (T
		       <TELL " appear">)>
		<TELL "s ">
		<COND (<PROB 50>
		       <COND (<PROB 50>
			      <TELL "somewhat ">)
			     (T
			      <TELL "a bit ">)>)>
		<TELL .STR "ed">)
	       (T
		<TELL " looks at you with a " .STR
		      "ed expression">)>
	 <TELL ". \"">
	 <RTRUE>>

<ROUTINE WHO-WHAT (OBJ)
	 <TELL " wh">
	 <COND (<IS? .OBJ ,PERSON>
		<TELL "o ">
		<RTRUE>)
	       (<IS? .OBJ ,PLACE>
		<TELL "ere ">
		<RTRUE>)>
	 <TELL "at ">
	 <RTRUE>>

<ROUTINE V-SWRAP ()
	 <PERFORM ,V?WRAP-AROUND ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-WRAP-AROUND ()
	 <TELL ,IMPOSSIBLY B ,P-PRSA-WORD C ,SP THEO
	       " around " THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE V-DRESS ()
	 <COND (<PRSO? ROOMS ME>
		<TELL "Try putting " B ,W?SOMETHING " on." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
	       	<TELL CTHEO " has all the clothing ">
		<COND (<IS? ,PRSO ,FEMALE>
		       <TELL "s">)>
		<TELL "he needs." CR>
		<RTRUE>)>
	 <TELL ,CANT "dress " AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-UNDRESS ("AUX" (ANY <>) X OBJ NXT)
	 <COND (<PRSO? ROOMS ME WINNER>
		<SET OBJ <FIRST? ,WINNER>>
		<REPEAT ()
			<COND (<ZERO? .OBJ>
			       <RETURN>)>
			<SET NXT <NEXT? .OBJ>>
			<COND (<IS? .OBJ ,WORN>
			       <SET ANY T>
			       <SETG P-MULT? T>
			       <SET X <PERFORM ,V?TAKE-OFF .OBJ>>
			       <COND (<EQUAL? .X ,M-FATAL>
				      <RETURN>)>)>
			<SET OBJ .NXT>>
		<COND (<T? .ANY>
		       <SETG P-MULT? <>>
		       <COND (<ZERO? .X>
			      <RTRUE>)>
		       <RETURN .X>)>
		<PRINT "You're not wearing ">
		<TELL "anything unusual." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<INAPPROPRIATE>
		<RTRUE>)>
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP AO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-HANG ("AUX" X)
	 <COND (<HERE? OUTSIDE-PUB ON-BRIDGE>
		<SET X ,PUB-SIGN>
		<COND (<HERE? ON-BRIDGE>
		       <SET X ,ZBRIDGE>)>
		<TELL "[on " THE .X ,BRACKET>
		<PERFORM ,V?HANG-ON ,PRSO .X>
		<RTRUE>)>
	 <TELL ,NOTHING "here on which to " 
	       B ,P-PRSA-WORD C ,SP THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-HANG-ON ()
	 <TELL CTHEI>
	 <IS-ARE ,PRSI>
	 <TELL "hardly suitable for " B ,P-PRSA-WORD "ing things." CR>
	 <RTRUE>>
	 
<ROUTINE V-LURK ()
	 <TELL "Leave the " B ,P-PRSA-WORD "ing to the grues." CR>
	 <RTRUE>>
	 	 
<ROUTINE V-SAY ()
	 <COND (<NOT <MAGICWORD? <GET ,P-LEXV ,P-CONT>>>
		<TALK-TO-SELF>)>
	 <PCLEAR>
	 <RTRUE>>

<ROUTINE V-MAGIC ()
	 <COND (<MAGICWORD?>
		<RTRUE>)
	       (<EQUAL? ,P-PRSA-WORD ,W?DISPEL>
		<HOW?>
		<RTRUE>)>
	 <NOTHING-HAPPENS <>>
	 <RTRUE>>
		
; <ROUTINE YOU-CANT ()
	 <SAY-YOU>
	 <TELL " can't ">
	 <RTRUE>>
	 
; <ROUTINE SAY-YOU ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You">
		<RTRUE>)>
	 <TELL CTHE ,WINNER>
	 <RTRUE>>

; <ROUTINE YOURE ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You're ">
		<RTRUE>)>
	 <TELL CTHE ,WINNER ,SIS>
	 <RTRUE>>

<ROUTINE V-ERASE-WITH ()
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP THEO>
	 <COND (<NOT <PRSI? HANDS>>
		<TELL ,WITH THEI>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>
	 	 
<ROUTINE V-WRITE-ON ()
	 <TELL "It would be difficult to " B ,P-PRSA-WORD C ,SP AO
	       ,SON THEI ,PERIOD>
	 <RTRUE>>
	 
<ROUTINE V-WRITE-WITH ()
	 <NOT-LIKELY ,PRSI>
	 <TELL " could " B ,P-PRSA-WORD " anything on " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-CRANK ()
	 <COND (<PRSO? ROOMS>
		<COND (<VISIBLE? ,GURDY>
		       <PRINTC %<ASCII !\[>>
		       <TELL THE ,GURDY ,BRACKET>
		       <SETG LAST-CRANK-DIR <>>
		       <TURN-GURDY>
		       <RTRUE>)>
		<TELL ,NOTHING "here to crank." CR>
		<RTRUE>)>
	 <TELL ,CANT "crank " THEO ,PERIOD>
	 <RTRUE>>
	 
<ROUTINE V-UNMAKE ()
	 <TELL "Such magic lies far beyond your meager abilities." CR>
	 <RTRUE>>

<ROUTINE V-SPELLS ()
	 <TELL ,DONT "know any. Few ">
	 <ANNOUNCE-RANK>
	 <TELL "s do." CR>
	 <RTRUE>>

"*** BARTERING ***"

<OBJECT MONEY
	(LOC GLOBAL-OBJECTS)
	(DESC "foo")
	(SDESC DESCRIBE-MONEY)
	(FLAGS NODESC NOARTICLE NOALL)
	(SYNONYM MONEY ZORKMIDS ZORKMID ZM CASH LOOT
	         ASSETS COINS COIN CREDIT LINE)
	(ADJECTIVE INTNUM MY PERSONAL CREDIT)
	(ACTION MONEY-F)>

<GLOBAL LOOT:NUMBER 1>

<ROUTINE DESCRIBE-MONEY (OBJ)
	 <TELL "your zorkmid">
	 <COND (<NOT <EQUAL? ,LOOT 1>>
		<TELL "s">)>
	 <RTRUE>>

<ROUTINE MONEY-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? TRADE-FOR>
			    <HERE? IN-MAGICK IN-BOUTIQUE IN-WEAPON>>
		       <TRADE-FOR-LOOT ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? SPEND>
		<RTRUE>)
	       (<VERB? FIND BUY>
		<TELL "Good luck." CR>
		<RTRUE>)
	       (<ZERO? ,LOOT>
		<PRINT "You're broke.|">
		<RFATAL>)
	       (<VERB? EXAMINE COUNT>
		<SAY-CASH>
		<RTRUE>)
	       (<VERB? WHAT>
		<TELL "Zorkmids are the local unit of currency." CR>
		<RTRUE>)
	       (<OR <VERB? DROP EMPTY>
		    <SET X <PUTTING?>>>
		<BENJAMIN>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>
			 
<ROUTINE SAY-CASH ()
	 <TELL "You have ">
	 <SAY-LOOT>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE NOT-ENOUGH-LOOT? (AMT)
	 <COND (<G? .AMT ,LOOT>
		<TELL "You only have ">
		<SAY-LOOT>
		<TELL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SAY-LOOT ("OPT" (VAL ,LOOT))
	 <TELL N .VAL " zorkmid">
	 <COND (<NOT <EQUAL? .VAL 1>>
		<TELL "s">)>
	 <RTRUE>>

<ROUTINE BENJAMIN ()
	 <TELL "A zorkmid saved is a zorkmid earned." CR>
	 <RTRUE>>

<ROUTINE GIVING-LOOT? (OBJ WHO)
	 <COND (<NOT <EQUAL? .OBJ ,MONEY ,INTNUM>>
		<RFALSE>)
	       (<ZERO? ,LOOT>
		<PRINT "You're broke.|">
		<RTRUE>)>
	 <SET OBJ ,LOOT>
	 <COND (<NOT <EQUAL? ,P-NUMBER -1>>
		<COND (<NOT-ENOUGH-LOOT? ,P-NUMBER>
		       <RTRUE>)>
		<SET OBJ ,P-NUMBER>)>
	 <TELL CTHE .WHO 
" gives you a bewildered look, shrugs, and accepts " D ,MONEY>
	 <SETG LOOT <- ,LOOT .OBJ>>
	 <TELL " without question." CR>
	 <RTRUE>>

<ROUTINE PRE-BUY ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<ZERO? ,PRSI>
		<SETG PRSI ,MONEY>
		<TELL "[with " D ,PRSI ,BRACKET>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-SBUY ()
	 <PERFORM ,V?BUY ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-BUY ()
	 <COND (<NOT <VISIBLE? ,PRSO>>
		<NONE-FOR-SALE>
		<RFATAL>)
	       (<HELD?>
		<ALREADY-HAVE>
		<RTRUE>)
	       (<HERE? IN-MAGICK IN-WEAPON IN-BOUTIQUE>
		<BUY-X-WITH-Y>
		<RTRUE>)>
	 <NOT-LIKELY>
	 <TELL " is for sale." CR>
	 <RTRUE>>

<ROUTINE NONE-FOR-SALE ()
	 <TELL "There are none here to buy." CR>
	 <RTRUE>>

<ROUTINE V-SPEND ()
	 <COND (<PRSO? ROOMS MONEY INTNUM>
		<TELL "Easily done">
		<COND (<HERE? IN-MAGICK IN-BOUTIQUE IN-WEAPON>
		       <TELL ", especially here">)>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-PAY ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-BUY-FROM ()
	 <COND (<NOT <VISIBLE? ,PRSO>>
		<NONE-FOR-SALE>
		<RFATAL>)
	       (<HELD?>
		<ALREADY-HAVE>
		<RTRUE>)
	       (<PRSI? OWOMAN MCASE BCASE WCASE>
		<BUY-X-WITH-Y>
		<RTRUE>)>
	 <NOT-LIKELY ,PRSI>
	 <TELL " could sell you " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE PRE-TRADE-FOR ()
	 <COND (<PRE-SELL-TO>
		<RTRUE>)
	       (<IN? ,PRSI ,WINNER>
	      	<ALREADY-HAVE ,PRSI>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-TRADE-FOR ("AUX" L)
	 <SET L <LOC ,PRSI>>
	 <COND (<ZERO? .L>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<HERE? IN-MAGICK IN-BOUTIQUE IN-WEAPON>
		<BUY-X-WITH-Y ,PRSI ,PRSO>
		<RTRUE>)
	       (<IS? .L ,PERSON>
		<TELL CTHE .L " seems reluctant to give up " THEI ,PERIOD>
		<RTRUE>)>
	 <TELL "Why not just pick up " THEI " instead?" CR>
	 <RTRUE>>	       
	       		 
<ROUTINE PRE-SELL-TO ()
	 <COND (<ZERO? ,PRSI>
		<COND (<IN? ,OWOMAN ,HERE>
		       <PERFORM ,PRSA ,PRSO ,OWOMAN>
		       <RTRUE>)>)>
	 <COND (<EQUAL? <> ,PRSO ,PRSI>
		<REFERRING>
		<RTRUE>)
	       (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<PRSO? PRSI>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<PRSI? MONEY INTNUM>
		<RFALSE>)
	       (<OR <IN? ,PRSI ,GLOBAL-OBJECTS>
		    <AND <NOT <IS? ,PRSO ,TAKEABLE>>
			 <NOT <IS? ,PRSO ,TRYTAKE>>>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<AND <IS? ,PRSO ,WORN>
		     <IN? ,PRSO ,WINNER>>
		<RETURN <TAKE-OFF-PRSO-FIRST?>>)
	       (T
		<RFALSE>)>>

<ROUTINE V-SELL-TO ()
	 <COND (<NOT <EQUAL? ,WINNER ,PLAYER>>
		<NOT-LIKELY ,WINNER>
		<IS-ARE>
		<TELL "interested in selling anything">
		<RTRUE>)
	       (<PRSI? PRSO ME WINNER>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IS? ,PRSI ,PERSON>>
		<NOT-LIKELY ,PRSI>
		<TELL " would buy anything." CR>
		<RTRUE>)>
	 <NOT-A "salesperson">
	 <RTRUE>>

<ROUTINE V-SSELL-TO ()
	 <PERFORM ,V?SELL-TO ,PRSI ,PRSO>
	 <RTRUE>>
		       		       
<ROUTINE BUY-X-WITH-Y ("OPT" (X ,PRSO) (Y ,PRSI)
		       "AUX" CASE VAL OFFER CHANGE)
	 <SET CASE <GETP ,HERE ,P?THIS-CASE>>
	 <COND (<NOT <VISIBLE? .X>>
		<TELL "\"I don't have any for sale,\" admits "
		      THE ,OWOMAN ,PERIOD>
		<RTRUE>)
	       (<NOT <IN? .X .CASE>>
		<TELL "\"Only the items in " THE .CASE
		      " are for sale.\"" CR>
		<RTRUE>)>
	 <SET VAL <GETP .X ,P?VALUE>>
	 <COND (<L? .VAL 1>
		<NO-WORTH .X>
		<RTRUE>)
	       (<EQUAL? .Y <> ,MONEY ,INTNUM>
		<SET OFFER ,P-NUMBER>
		<COND (<ZERO? ,LOOT>
		       <PRINT "You're broke.|">
		       <RTRUE>)
		      (<OR <ZERO? .Y>
			   <EQUAL? ,P-NUMBER -1>>
		       <SET OFFER ,LOOT>)
		      (<NOT-ENOUGH-LOOT? .OFFER>
		       <RTRUE>)>
		<COND (<L? .OFFER .VAL>
		       <TELL ,CTHELADY
            		     " shakes her head firmly. \"My price is ">
		       <SAY-LOOT .VAL>
		       <TELL ", dear.\"" CR>
		       <RTRUE>)>
		<PUTP .X ,P?VALUE </ .VAL 2>>
		<COND (<AND <NOT <EQUAL? ,P-NUMBER -1>>
			    <G? .OFFER .VAL>>
		       <SETG LOOT <- ,LOOT ,P-NUMBER>>
		       <PRINT "\"You are too kind">)
		      (T
		       <SETG LOOT <- .OFFER .VAL>>
		       <TELL "\"Done">)>
		<TELL ",\" says " THE ,OWOMAN ", taking your zorkmid">
		<COND (<NOT <EQUAL? .VAL 1>>
		       <TELL "s">)>
		<SOLD .X>
		<RTRUE>)
	       (<NO-DEAL? .Y>
		<RTRUE>)
	       (<IN? .Y ,GLOBAL-OBJECTS>
		<TELL "\"Don't be silly.\"" CR>
		<RTRUE>)>
	 <SET OFFER <GETP .Y ,P?VALUE>>
	 <COND (<ZERO? .OFFER>
		<NO-WORTH .Y>
		<RTRUE>)
	       (<L? .OFFER .VAL>
		<WORTHLESS .Y>
		<TELL " only worth ">
		<SAY-LOOT .OFFER>
		<TELL ". This " D .X " is valued at ">
		<SAY-LOOT .VAL>
		<TELL "!\"" CR>
		<RTRUE>)>
	 <WINDOW ,SHOWING-ALL>
	 <MOVE .Y .CASE>
	 <MAKE .Y ,USED>
	 <PUTP .Y ,P?VALUE <+ .OFFER .OFFER>>
	 <PUTP .X ,P?VALUE </ .VAL 2>>
	 <COND (<G? .OFFER .VAL>
		<PRINT "\"You are too kind">)
	       (T
		<TELL "\"Done">)>
	 <TELL ",\" says " THE ,OWOMAN ", taking ">
	 <SAY-YOUR .Y>
	 <COND (<G? .OFFER .VAL>
		<SET CHANGE <- .OFFER .VAL>>
		<SETG LOOT <+ ,LOOT .CHANGE>>
		<SOLD .X .CHANGE>
		<PRINT " and handing you ">
		<SAY-LOOT .CHANGE>
		<TELL " in change." CR>
		<RTRUE>)>
	 <SOLD .X>
	 <RTRUE>>
		
<ROUTINE SOLD (OBJ "OPT" (CHANGE 0))
	 <WINDOW ,SHOWING-ALL>
	 <THIS-IS-IT .OBJ>
	 <MAKE .OBJ ,USED>
	 <COND (<T? .CHANGE>
		<TELL ", ">)
	       (T
		<TELL ,AND>)>
	 <COND (<ITAKE <>>
		<MOVE .OBJ ,PLAYER>
		<TELL "handing you " THE .OBJ>)
	       (T
		<MOVE .OBJ <GETP <GETP ,HERE ,P?THIS-CASE> ,P?DNUM>>
		<TELL "setting " THE .OBJ ,SON THE ,MCASE>)>
	 <COND (<ZERO? .CHANGE>
		<PRINT ,PERIOD>)>
	 <RTRUE>>

<ROUTINE NO-WORTH (OBJ)
	 <WORTHLESS .OBJ>
	 <TELL " not worth anything here.\"" CR>
	 <RTRUE>>

<ROUTINE WORTHLESS (OBJ)
	 <TELL ,CTHELADY ,GLANCES-AT THE .OBJ
	       " and shakes her head. \"">
	 <COND (<IS? .OBJ ,FEMALE>
		<TELL "She's">)
	       (<IS? .OBJ ,LIVING>
		<TELL "He's">)
	       (<IS? .OBJ ,PLURAL>
		<TELL "They're">)
	       (T
		<TELL "That's">)>
	 <RTRUE>>

<ROUTINE NO-DEAL? (OBJ)
	 <COND (<EQUAL? .OBJ ,HELM ,RUG ,CAKE>
		<TELL "\"No,\" replies " THE ,OWOMAN 
", shaking her head firmly. \"I don't think I want to carry this.\"" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TRADE-FOR-LOOT (OBJ "AUX" VAL CASE)
	 <COND (<NOT <IN? .OBJ ,PLAYER>>
		<TAKE-FIRST .OBJ <LOC .OBJ>>
		<RTRUE>)>
	 <COND (<NO-DEAL? .OBJ>
		<RTRUE>)>
	 <SET VAL <GETP .OBJ ,P?VALUE>>
	 <SET CASE <GETP ,HERE ,P?THIS-CASE>>
	 <TELL ,CTHELADY " examines " THE .OBJ>
	 <COND (<ZERO? .VAL>
		<TELL 
" and hands it back to you with a shrug. \"Worthless.\"" CR>
		<RTRUE>)>
	 <WINDOW ,SHOWING-ALL>
	 <SETG LOOT <+ .VAL ,LOOT>>
	 <TELL " critically. \"Okay,\" she agrees, ">
	 <COND (<EQUAL? .OBJ ,TRUFFLE>
		<VANISH .OBJ>
		<TELL "popping " THE .OBJ " in her mouth">)
	       (T
		<PUTP .OBJ ,P?VALUE <+ .VAL .VAL>>
		<MOVE .OBJ .CASE>
		<TELL "stashing it away in " THE .CASE>)>
	 <PRINT " and handing you ">
	 <SAY-LOOT .VAL>
	 <TELL " in return." CR>
	 <RTRUE>>

<ROUTINE V-ZOOM ("AUX" WRD)
	 <COND (<NOT <PRSO? ROOMS>>
		<BAD-COMMAND "ZOOM" "that way">
		<RTRUE>)
	       (<ZERO? ,DMODE>
		<BAD-COMMAND "ZOOM" "in this display mode">
		<RTRUE>)
	       (<EQUAL? ,MAP-ROUTINE ,CLOSE-MAP>
		<SETG MAP-ROUTINE ,FAR-MAP>
		<SET WRD ,W?OUT>)
	       (T
		<SETG MAP-ROUTINE ,CLOSE-MAP>
		<SET WRD ,W?IN>)>
	 <SETG SAME-COORDS <>>
	 <TELL "[Zooming " B .WRD ".]" CR>
	 <NEW-MAP>
	 <SHOW-MAP>
	 <RTRUE>>

<GLOBAL PRIOR:NUMBER 0>

<ROUTINE V-PRIORITY-ON ()
	 <COND (<BAD-PRIOR?>
		<RTRUE>)
	       (<EQUAL? ,PRIOR ,IN-DBOX>
		<TELL "already ">)
	       (T
		<SETG PRIOR ,IN-DBOX>
		<TELL "now ">)>
	 <TELL "set to ">
	 <SAY-PRIORITY>
	 <TELL ".]" CR>
	 <RTRUE>>

<ROUTINE SAY-PRIORITY ()
	 <COND (<EQUAL? ,PRIOR ,SHOWING-ROOM>
		<TELL "Room Descriptions">
		<RTRUE>)
	       (<EQUAL? ,PRIOR ,SHOWING-INV>
		<TELL "Inventory">
		<RTRUE>)
	       (T
		<TELL "Player Status">
		<RTRUE>)>>

<ROUTINE V-PRIORITY-OFF ()
	 <COND (<BAD-PRIOR?>
		<RTRUE>)
	       (<ZERO? ,PRIOR>
		<TELL "already ">)
	       (T
		<SETG PRIOR 0>
		<TELL "now ">)>
	 <TELL "disabled.]" CR>
	 <RTRUE>>
	 
<ROUTINE BAD-PRIOR? ()
	 <COND (<NOT <PRSO? ROOMS>>		    
		<BAD-COMMAND "PRIORITY" "that way">
		<RTRUE>)
	       (<ZERO? ,DMODE>
		<BAD-COMMAND "PRIORITY" "in this display mode">
		<RTRUE>)>		
	 <TELL "[Display priority is ">
	 <RFALSE>>

<ROUTINE BAD-COMMAND (STR1 STR2)
	 <TELL "[" ,CANT "use the " .STR1 " command " .STR2 ".]" CR>
	 <RTRUE>>	 

<GLOBAL DMODE:FLAG T> "T = enhanced, <> = normal."

<ROUTINE V-MODE ("AUX" STR)
	 <SET STR "Normal">
	 <COND (<ZERO? ,DMODE>
		<SET STR "Enhanced">
		<SETG DMODE T>)
	       (T
		<SETG DMODE <>>)>
	 <V-REFRESH>
	 <CRLF>
	 <PRINTC %<ASCII !\[>>
	 <TELL .STR " display mode.]" CR CR>
	 <RTRUE>>

<GLOBAL VERBOSITY:NUMBER 1> "0 = super, 1 = brief, 2 = verbose."

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "[Maximum verbosity">
	 <FOR-SCRIPTING>
	 <COND (<ZERO? ,DMODE>
		<CRLF>
		<V-LOOK>)>
	 <RTRUE>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "[Brief descriptions">
	 <FOR-SCRIPTING>
	 <RTRUE>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG VERBOSITY 0>
	 <TELL "[Superbrief descriptions">
	 <FOR-SCRIPTING>
	 <RTRUE>>

<ROUTINE FOR-SCRIPTING ()
	 <COND (<T? ,DMODE>
		<TELL " for transcripting">)>
	 <TELL ".]" CR>
	 <RTRUE>>

<ROUTINE V-QUIT ()
	 <PRINT "Are you sure you want to ">
	 <TELL "leave the story now?">
	 <COND (<YES?>
		<CRLF>
		<QUIT>
		<RTRUE>)>
	 <CONTINUING>
	 <RTRUE>>
		      
<ROUTINE CONTINUING ()
	 <TELL CR "[Continuing.]" CR>
	 <RTRUE>>

<ROUTINE V-RESTART ()
	 <V-SCORE>
	 <CRLF>
	 <PRINT "Are you sure you want to ">
	 <TELL "restart the story?">
	 <COND (<YES?>
		<RESTART>
		<FAILED "RESTART">)>
	 <RTRUE>>

<ROUTINE V-RESTORE ("AUX" X)
	 <SETG OLD-HERE <>>
	 <SET X <RESTORE>>
	 <COND (<ZERO? .X>
		<INITVARS>
		<V-REFRESH>
		<FAILED "RESTORE">)>
	 <RTRUE>>

<GLOBAL CHECKSUM:NUMBER 0>

<ROUTINE V-SAVE ("AUX" X STAT)
	 <COND (<CANT-SAVE?>
		<RTRUE>)>
	 <TELL "You mumble the Spell of Saving." CR>
	 <PCLEAR>
	 <SETG OLD-HERE <>>
	 <PUTB ,OOPS-INBUF 1 0> ; "Retrofix #50"
	 
	 <SET STAT ,ENDURANCE>
	 <SETG CHECKSUM 0>
	 <REPEAT ()
	    <SETG CHECKSUM <+ ,CHECKSUM <GET ,STATS .STAT>>>
	    <COND (<IGRTR? STAT ,EXPERIENCE>
		   <RETURN>)>>
	 <SET STAT ,ENDURANCE>
	 <REPEAT ()
	    <SETG CHECKSUM <+ ,CHECKSUM <GET ,MAXSTATS .STAT>>>
	    <COND (<IGRTR? STAT ,EXPERIENCE>
		   <RETURN>)>>
	 <SETG CHECKSUM <- 0 ,CHECKSUM>>
	 
	 <SET X <SAVE>>
	 
	 <COND (<OR <EQUAL? .X 2>
		    <BTST <LOWCORE FLAGS> 4>>
		<INITVARS>
		<V-REFRESH>)>
	 
	 <COND (<ZERO? .X>
		<FAILED "SAVE">
		<RFATAL>)
	       (<EQUAL? .X 1>
		<COMPLETED "SAVE">
		<RFATAL>)>
	 
	 <COMPLETED "RESTORE">	 
	 <CRLF>
	 <V-LOOK>
	 	 
	 <SET STAT ,ENDURANCE>
	 <SET X 0>
	 <REPEAT ()
	    <SET X <+ .X <GET ,STATS .STAT>>>
	    <COND (<IGRTR? STAT ,EXPERIENCE>
		   <RETURN>)>>
	 <SET STAT ,ENDURANCE>
	 <REPEAT ()
	    <SET X <+ .X <GET ,MAXSTATS .STAT>>>
	    <COND (<IGRTR? STAT ,EXPERIENCE>
		   <RETURN>)>>
	 <COND (<NOT <EQUAL? <- 0 ,CHECKSUM> .X>>
		<CHEATER>)>
	 <RFATAL>>

<ROUTINE COMPLETED (STR)
	 <TELL CR "[" .STR " completed.]" CR>
	 <RTRUE>>

<ROUTINE FAILED (STR)
	 <TELL CR "[" .STR " failed.]" CR>
	 <RTRUE>>

<ROUTINE V-SCORE ()
	 <TELL "[Your rank is ">
	 <ANNOUNCE-RANK>
	 <TELL ", achieved in " N ,MOVES " move">
	 <COND (<NOT <EQUAL? ,MOVES 1>>
		<TELL "s">)>
	 <TELL ".]" CR>
	 <RTRUE>> 

<ROUTINE V-DIAGNOSE ()
	 <COND (<PRSO? ME ROOMS>
		<NYMPH-APPEARS "medical">
		<TELL "Please use the STATUS command to monitor your health">
		<PRINT ". Bye!\"|  She disappears with a wink.|">
		<RTRUE>)
	       (<IS? ,PRSO ,MONSTER>
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (<IS? ,PRSO ,LIVING>
		<TELL CTHEO " seem">
		<COND (<NOT <IS? ,PRSO ,PLURAL>>
		       <TELL "s">)>
		<TELL " well enough." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<TELL CTHEO>
		<ISNT-ARENT>
		<TELL " looking well." CR>
		<RTRUE>)>
	 <TELL ,CANT B ,P-PRSA-WORD C ,SP AO ,PERIOD>
	 <RTRUE>> 
		       
<GLOBAL SAY-STAT:FLAG <>>

<ROUTINE V-NOTIFY ()
	 <TELL "[Status notification is now o">
	 <COND (<T? ,SAY-STAT>
		<SETG SAY-STAT <>>
		<TELL "ff">)
	       (T
		<SETG SAY-STAT T>
		<TELL "n">)>
	 <TELL ".]" CR>
	 <RTRUE>>

<ROUTINE V-TIME ()
	 <TELL "This is a timeless tale." CR>
	 <RTRUE>>

<ROUTINE V-SCRIPT ()
         <PRINT "[Transcripting o">
	 <TELL "n.]" CR>
	 <DIROUT ,D-PRINTER-ON>
	 <TRANSCRIPT "begin">
	 <RTRUE>>

<ROUTINE V-UNSCRIPT ()
	 <TRANSCRIPT "end">
	 <DIROUT ,D-PRINTER-OFF>
	 <PRINT "[Transcripting o">
	 <TELL "ff.]" CR>
	 <RTRUE>>

<ROUTINE TRANSCRIPT (STR)
	 <DIROUT ,D-SCREEN-OFF>
	 <TELL CR "Here " .STR "s a transcript of interaction with" CR>
	 <V-VERSION>
	 <DIROUT ,D-SCREEN-ON>
	 <RTRUE>>

<ROUTINE V-VERSION ("AUX" X)
	 <CRLF>
	 <COND (<T? ,COLORS?>
		<COLOR ,INCOLOR ,BGND>)
	       (<NOT <EQUAL? ,HOST ,MACINTOSH>>
		<HLIGHT ,H-BOLD>)>
	 <TELL "BEYOND ZORK: ">
	 <PRINT "The Coconut of Quendor">
	 <CRLF>
	 <COLOR ,FORE ,BGND>
	 <HLIGHT ,H-NORMAL>
	 <PRINT "Copyright (C)1987 Infocom, Inc. All rights reserved.">
	 <CRLF>
	 <TRADEMARK>
	 <CRLF>
	 <TELL "Release ">
	 <PRINTN <BAND <LOWCORE ZORKID> *3777*>>
	 <TELL " / Serial Number ">
	 <LOWCORE-TABLE SERIAL 6 PRINTC>	 
	 <CRLF>
	 <INTERPRETER-ID>	 
	 <RTRUE>>
 		
<ROUTINE V-$VERIFY ()
       ; <COND (<T? ,PRSO>
	        <COND (<AND <PRSO? INTNUM>
		            <EQUAL? ,P-NUMBER 105>>
	               <TELL N ,SERIAL CR>
		       <RTRUE>)>
		<DONT-UNDERSTAND>
		<RTRUE>)>
	 <INTERPRETER-ID>
	 <TELL CR "[Verifying.]" CR>
	 <COND (<VERIFY> 
		<NYMPH-APPEARS>
		<TELL "Your disk is correct">
		<PRINT ". Bye!\"|  She disappears with a wink.|">
		<RTRUE>)>
	 <FAILED "$VERIFY">
	 <RTRUE>>

<ROUTINE INTERPRETER-ID ()
	 <COND (<L? ,HOST 1>
		<TELL "XZIP">)
	       (<G? ,HOST <GET ,MACHINES 0>>
		<TELL "Interpreter " N ,HOST>)
	       (T
		<TELL <GET ,MACHINES ,HOST>>)>
	 <COND (<T? ,COLORS?>
		<TELL " Color">)>
	 <TELL " Version " C <LOWCORE INTVR> CR>
	 <RTRUE>>

<GLOBAL POTENTIAL:NUMBER 0>
<GLOBAL STATS:TABLE <TABLE 0 0 0 0 0 0 0 0>>
<GLOBAL MAXSTATS:TABLE <TABLE 0 0 0 0 0 0 0 0>>

<ROUTINE V-STATUS ("AUX" (CNT 0) X)
	 <COND (<AND <T? ,DMODE>
		     <T? ,VT220>
		     <NOT <EQUAL? ,IN-DBOX ,SHOWING-STATS>>
		     <ZERO? ,PRIOR>>
		<TELL "[Displaying status.]" CR>
		<SHOW-RANK>
		<DISPLAY-STATS>)
	       (T
		<STANDARD-STATS>)>
	 <COND (<BTST <LOWCORE FLAGS> 1>
		<DIROUT ,D-SCREEN-OFF>
		<STANDARD-STATS>
		<DIROUT ,D-SCREEN-ON>)>
	 <RTRUE>>

<ROUTINE STANDARD-STATS ()
	 <PRINT-TABLE ,CHARNAME>
	 <PRINTC %<ASCII !\/>>
	 <ANNOUNCE-RANK>
	 <CRLF>
	 <TEXT-STATS>
	 <CRLF>
	 <RTRUE>>

<GLOBAL BMODE:FLAG <>> "Battle display mode flag."
<GLOBAL AUTO:FLAG T> "Automatic display mode flag."

<ROUTINE V-MONITOR ("AUX" X)
	 <COND (<ZERO? ,VT220>
		<NOT-AVAILABLE>
		<RTRUE>)
	       (<ZERO? ,DMODE>
		<TELL 
"[That command works only in Enhanced display mode.]" CR>
		<RTRUE>)
	       (<ZERO? ,AUTO>
		<SETG AUTO T>
		<SET X <GET ,STATS ,ENDURANCE>>
		<COND (<L? .X <GET ,MAXSTATS ,ENDURANCE>>
		       <BMODE-ON>)>
		<PRINT "[Combat monitor o">
		<TELL "n.]" CR>
		<RTRUE>)>
	 <SETG AUTO 0>
	 <COND (<T? ,BMODE>
		<BATTLE-MODE-OFF>)>
	 <PRINT "[Combat monitor o">
	 <TELL "ff.]" CR>
	 <RTRUE>>

<ROUTINE BMODE-OFF ("AUX" X)
	 <COND (<OR <ZERO? ,BMODE>
		    <ZERO? ,VT220>>
		<RFALSE>)>
	 <SET X <GET ,STATS ,ENDURANCE>>
	 <COND (<NOT <L? .X <GET ,MAXSTATS ,ENDURANCE>>>
		<BATTLE-MODE-OFF>)>
	 <RFALSE>>

<ROUTINE BATTLE-MODE-OFF ()
	 <SETG BMODE 0>
	 <WINDOW ,SHOWING-ALL>
	 <SETG DHEIGHT ,MAX-DHEIGHT>
	 <TO-TOP-WINDOW>
	 <DO-CURSET <+ ,DHEIGHT <- 11 ,MAX-DHEIGHT>> 2>
	 <PRINT-SPACES ,DWIDTH>
	 <TO-BOTTOM-WINDOW>
	 <RFALSE>>

<ROUTINE BMODE-ON ()
	 <COND (<OR <ZERO? ,DMODE>
		    <T? ,BMODE>
		    <ZERO? ,VT220>
		    <EQUAL? ,SHOWING-STATS ,IN-DBOX ,NEW-DBOX>>
		<RFALSE>)>
	 <BATTLE-MODE-ON>
	 <RFALSE>>

<ROUTINE BATTLE-MODE-ON ("AUX" Y)
	 <SETG BMODE T>
	 <WINDOW ,SHOWING-ALL>
	 <SET Y <+ ,DHEIGHT <- 11 ,MAX-DHEIGHT>>>
	 <TO-TOP-WINDOW>
	 <DO-CURSET .Y 2>
	 <PRINT-SPACES ,DWIDTH>
	 <TO-BOTTOM-WINDOW>
	 <STATBARS .Y 0 0>
	 <SETG DHEIGHT <- ,MAX-DHEIGHT 1>>	 	 
	 <RFALSE>>

<ROUTINE V-DEFINE ("AUX" KEYS TOP LTBL LMARGIN
		   	 DKEY TBL TBL2 LEN HIT X Y)
	 
       ; "Set up routine constants."

	 <SET KEYS 9>
	 <COND (<EQUAL? ,HOST ,C128 ,C64>
		<SET KEYS 7>)>
	 <SET TOP </ <- ,HEIGHT <+ .KEYS 7>> 2>>
	 <SET LTBL ,KEY-LABELS>
	 <COND (<OR <EQUAL? ,HOST ,APPLE-2E ,APPLE-2C ,APPLE-2GS>
		    <EQUAL? ,HOST ,MACINTOSH>>
		<SET LTBL ,APPLE-LABELS>)>
	 <SET LMARGIN </ <- ,WIDTH <+ ,SOFT-LEN 4>> 2>>
		 
       ; "Init screen."

	 <COLOR ,GCOLOR ,BGND>
	 <CLEAR -1>
	 <SPLIT 20>
	 <TO-TOP-WINDOW>
	
       ; "Set up image of SOFT-KEYS in DBOX."

	 <DO-CURSET .TOP <+ 8 .LMARGIN>>
	 <TELL "Function Key Definitions">
	 
	 <SOFTS-TO-DBOX .KEYS>
	 <SET X <+ .LMARGIN 4>>
	 <DO-CURSET <+ .TOP 2> .X>
	 <HLIGHT ,H-INVERSE>
	 <PRINTT ,DBOX ,SOFT-LEN <+ .KEYS 1>>
	 
       ; "Print key labels."
	 
	 <COND (<OR <ZERO? ,COLORS?>
		    <EQUAL? ,FORE ,GCOLOR>>
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>)>
	 <SET X 0>
	 <REPEAT ()
	    <DO-CURSET <+ <+ .TOP .X> 2> .LMARGIN>
	    <TELL <GET .LTBL .X>>
	    <COND (<IGRTR? X .KEYS>
		   <RETURN>)>>
	 
	 <SET X <+ .LMARGIN 4>>
	 <DO-CURSET <+ <+ .KEYS 4> .TOP> .X>
	 <TELL " Restore Defaults ">
	 <DO-CURSET <+ <+ .KEYS 6> .TOP> .X>
	 <PRINT " Exit ">
	 
	 <SET DKEY 0>
	 <REPEAT ()
	    <SET Y <+ <+ .DKEY .TOP> 2>>
	    <COLOR ,FORE ,BGND>
	    <HLIGHT ,H-INVERSE>
	    
	    <COND (<EQUAL? .DKEY <+ .KEYS 1>>
		   <SET X <+ .LMARGIN 4>>
		   <DO-CURSET <+ <+ .KEYS 4> .TOP> .X>
		   <TELL " Restore Defaults ">
		   <HLIGHT ,H-NORMAL>
		   <SCREEN ,S-TEXT>
		   <REPEAT ()
		      <SET HIT <DO-INPUT>>
		      <COND (<EQUAL? .HIT ,EOL ,LF>
			     <COND (<MAKE-SURE?>
				    <DEFAULT-SOFTS>
				    <SOFTS-TO-DBOX .KEYS>
				    <SCREEN ,S-WINDOW>
				    <HLIGHT ,H-NORMAL>
				    <HLIGHT ,H-MONO>
				    <HLIGHT ,H-INVERSE>
				    <COLOR ,GCOLOR ,BGND>
				    <SET X <+ .LMARGIN 4>>
				    <DO-CURSET <+ .TOP 2> .X>
				    <PRINTT ,DBOX ,SOFT-LEN <+ .KEYS 1>>
				    <RETURN>)>
			     <SET HIT ,DOWN-ARROW>)>
		      <COND (<EQUAL? .HIT ,UP-ARROW ,DOWN-ARROW>
			     <SET DKEY <+ .KEYS 2>>
			     <COND (<EQUAL? .HIT ,UP-ARROW>
				    <SET DKEY .KEYS>)>
			     <SCREEN ,S-WINDOW>
			     <HLIGHT ,H-NORMAL>
			     <HLIGHT ,H-MONO>
			     <COLOR ,GCOLOR ,BGND>
			     <COND (<AND <T? ,COLORS?>
					 <NOT <EQUAL? ,FORE ,GCOLOR>>>
				    <HLIGHT ,H-INVERSE>)>
			     <SET X <+ .LMARGIN 4>>
			     <DO-CURSET <+ <+ .KEYS 4> .TOP> .X>
			     <TELL " Restore Defaults ">
			     <RETURN>)>
		      <SOUND ,S-BOOP>>
		   <AGAIN>)
		  (<EQUAL? .DKEY <+ .KEYS 2>>
		   <SET X <+ .LMARGIN 4>>
		   <DO-CURSET <+ <+ .KEYS 6> .TOP> .X>
		   <PRINT " Exit ">
		   <HLIGHT ,H-NORMAL>
		   <SCREEN ,S-TEXT>
		   <REPEAT ()
		      <SET HIT <DO-INPUT>>
		      <COND (<EQUAL? .HIT ,EOL ,LF>
			     <COND (<OR <NOT <EQUAL? ,HOST ,MACINTOSH>>
					<MAKE-SURE?>>
				    <V-REFRESH>
				    <CONTINUING>
				    <RTRUE>)>
			     <SET HIT ,DOWN-ARROW>)>
		      <COND (<EQUAL? .HIT ,UP-ARROW ,DOWN-ARROW>
			     <SET DKEY 0>
			     <COND (<EQUAL? .HIT ,UP-ARROW>
				    <SET DKEY <+ .KEYS 1>>)>
			     <SCREEN ,S-WINDOW>
			     <HLIGHT ,H-NORMAL>
			     <HLIGHT ,H-MONO>
			     <COLOR ,GCOLOR ,BGND>
			     <COND (<AND <T? ,COLORS?>
					 <NOT <EQUAL? ,FORE ,GCOLOR>>>
				    <HLIGHT ,H-INVERSE>)>
			     <SET X <+ .LMARGIN 4>>
			     <DO-CURSET <+ <+ .KEYS 6> .TOP> .X>
			     <PRINT " Exit ">
			     <RETURN>)>
		      <SOUND ,S-BOOP>>
		   <AGAIN>)>
	    
	    <DO-CURSET .Y .LMARGIN>
	    <TELL <GET .LTBL .DKEY>>
	    <HLIGHT ,H-NORMAL>
	    <HLIGHT ,H-MONO>
	    <PUTB ,DBOX 0 ,SP>
	    <COPYT ,DBOX <REST ,DBOX 1> ,NSOFT-LEN>
	    <SET TBL <GET ,SOFT-KEYS .DKEY>>
	    <SET LEN <GETB .TBL 1>>
	    <COND (<T? .LEN>
		   <COPYT <REST .TBL 2> ,DBOX .LEN>)>
	    <DO-CURSET .Y <+ .LMARGIN 4>>
	    <COLOR ,INCOLOR ,BGND>
	    <PRINTT ,DBOX ,SOFT-LEN>	    
	    
	    <DO-CURSET .Y <+ <+ .LMARGIN .LEN> 4>>
	    <REPEAT ()
	       <SET HIT <READ .TBL 0>>
	       <COND (<OR <EQUAL? .HIT ,EOL ,LF>
			  <EQUAL? .HIT ,UP-ARROW ,DOWN-ARROW ,MAC-UP-ARROW
				  ,MAC-DOWN-ARROW>>
		      <RETURN>)>
	       <SOUND ,S-BOOP>>
	    <PUTB ,DBOX 0 ,SP>
	    <COPYT ,DBOX <REST ,DBOX 1> ,NSOFT-LEN>
	    <SET LEN <GETB .TBL 1>>
	    <COND (<ZERO? .LEN>
		   <PUTB .TBL 0 ,SP>
		   <COPYT .TBL <REST .TBL 1> ,NSOFT-LEN>
		   <SET TBL2 <GET ,KEY-DEFAULTS .DKEY>>
		   <SET LEN <GETB .TBL2 0>>
		   <PUTB .TBL 0 ,SOFT-LEN>
		   <PUTB .TBL 1 .LEN>
		   <SET X <REST .TBL2 1>>
		   <COPYT .X <REST .TBL 2> .LEN>
		   <COND (<NOT <EQUAL? ,HOST ,C128 ,C64>>)
			 (<SET X <INTBL? %<ASCII !\|> <REST .TBL 2> .LEN 1>>
			  <PUTB .X 0 %<ASCII !\!>>)>)>
	    <COPYT <REST .TBL 2> ,DBOX .LEN>
	    
	    <DO-CURSET .Y <+ .LMARGIN 4>>
	    <COLOR ,GCOLOR ,BGND>
	    <HLIGHT ,H-INVERSE>
	    <PRINTT ,DBOX ,SOFT-LEN>
	    
	    <SET Y <+ <+ .DKEY 2> .TOP>>
	    <DO-CURSET .Y .LMARGIN>
	    <COND (<OR <ZERO? ,COLORS?>
		       <EQUAL? ,FORE ,GCOLOR>>
		   <HLIGHT ,H-NORMAL>
		   <HLIGHT ,H-MONO>)>
	    <COLOR ,GCOLOR ,BGND>
	    <TELL <GET .LTBL .DKEY>>
	    
	    <COND (<EQUAL? .HIT ,EOL ,DOWN-ARROW ,LF ,MAC-DOWN-ARROW>
		   <INC DKEY>)
		  (<DLESS? DKEY 0>
		   <SET DKEY <+ .KEYS 2>>)>>
	 <RTRUE>>

<ROUTINE MAKE-SURE? ("AUX" X)
	 <TELL CR "Are you sure? (Y/N) >">
	 <SET X <INPUT 1>>
	 <CRLF>
	 <CLEAR ,S-TEXT>
	 <COND (<EQUAL? .X %<ASCII !\Y> %<ASCII !\y>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DEFAULT-SOFTS ("AUX" (CNT 0) TBL X LEN)
	 <REPEAT ()
	    <SET TBL <GET ,SOFT-KEYS .CNT>>
	    <PUTB .TBL 0 ,SOFT-LEN>
	    <SET TBL <REST .TBL 1>>
	    <SET X <GET ,KEY-DEFAULTS .CNT>>
	    <SET LEN <+ <GETB .X 0> 1>>
	    <COPYT .X .TBL .LEN>
	    <COND (<AND <EQUAL? ,HOST ,C128 ,C64>
			<SET X <INTBL? %<ASCII !\|> .TBL .LEN 1>>>
		   <PUTB .X 0 %<ASCII !\!>>)>
	    <COND (<IGRTR? CNT 9>
		   <RFALSE>)>>>

<ROUTINE SOFTS-TO-DBOX (KEYS "AUX" X TBL TBL2 LEN)
	 <PUTB ,DBOX 0 ,SP>
	 <COPYT ,DBOX <REST ,DBOX 1> %<- 0 <- ,DBOX-LENGTH 1>>>
	 <SET X 0>
	 <REPEAT ()
	    <SET TBL2 <REST ,DBOX <* .X ,SOFT-LEN>>>
	    <SET TBL <GET ,SOFT-KEYS .X>>
	    <SET LEN <GETB .TBL 1>>
	    <COND (<T? .LEN>
		   <COPYT <REST .TBL 2> .TBL2 .LEN>)>
	    <COND (<IGRTR? X .KEYS>
		   <RFALSE>)>>>

<ROUTINE V-SETTINGS ("AUX" TOP LMARGIN LINE X KEY)
	 <SET TOP </ <- ,HEIGHT 19> 2>>
	 <SET LMARGIN </ <- ,WIDTH 52> 2>>
	 <COLOR ,GCOLOR ,BGND>
	 <CLEAR -1>
	 <SPLIT 22>
	 <TO-TOP-WINDOW>
	 <DO-CURSET .TOP <+ .LMARGIN 18>>
	 <COLOR ,FORE ,BGND>
	 <TELL "Display Settings">
	 
	 <SET LINE 0>
	 <REPEAT ()
	    <SHOW-SETLINE .LINE .TOP .LMARGIN>
	    <COND (<IGRTR? LINE 8>
		   <RETURN>)>>

	 <SET LINE 0>
	 <REPEAT ()
	     <SHOW-SETLINE .LINE .TOP .LMARGIN 1>
	     <HLIGHT ,H-NORMAL>
	     <SCREEN ,S-TEXT>
	     <COND (<EQUAL? .LINE 7> ; "Restore."
		    <REPEAT ()
		       <SET KEY <DO-INPUT>>
		       <COND (<EQUAL? .KEY ,EOL ,LF>
			      <COND (<MAKE-SURE?>
				     <COND (<ZERO? ,DMODE>
					    <SETG DMODE T>
					    <SHOW-SETLINE 0 .TOP .LMARGIN>
					    <SETG MAP-ROUTINE ,CLOSE-MAP>
					    <COND (<ZERO? ,VT220>
						   <SETG MAP-ROUTINE
							 ,FAR-MAP>)>
					    <SETG IN-DBOX ,SHOWING-ROOM>
					    <SHOW-SETLINE 4 .TOP .LMARGIN>
					    <SETG PRIOR 0>
					    <SHOW-SETLINE 5 .TOP .LMARGIN>
					    <SETG AUTO T>
					    <SHOW-SETLINE 6 .TOP .LMARGIN>)>
				     <COND (<NOT <EQUAL? ,VERBOSITY 1>>
					    <SETG VERBOSITY 1>
					    <SHOW-SETLINE 1 .TOP .LMARGIN>)>
				     <COND (<BTST <LOWCORE FLAGS> 1>
					    <DIROUT ,D-PRINTER-OFF>
					    <SHOW-SETLINE 2 .TOP .LMARGIN>)>
				     <COND (<ZERO? ,SAY-STAT>
					    <SETG SAY-STAT T>
					    <SHOW-SETLINE 3 .TOP .LMARGIN>)>
				     <COND (<AND <T? ,VT220>
						 <EQUAL? ,MAP-ROUTINE
							 ,FAR-MAP>>
					    <SETG MAP-ROUTINE ,CLOSE-MAP>
					    <SHOW-SETLINE 4 .TOP .LMARGIN>)
					   (<AND <ZERO? ,VT220>
						 <EQUAL? ,MAP-ROUTINE
							 ,CLOSE-MAP>>
					    <SETG MAP-ROUTINE ,FAR-MAP>
					    <SHOW-SETLINE 4 .TOP .LMARGIN>)>
				     <COND (<T? ,PRIOR>
					    <SETG PRIOR 0>
					    <SHOW-SETLINE 5 .TOP .LMARGIN>)>
				     <COND (<ZERO? ,AUTO>
					    <SETG AUTO T>
					    <SHOW-SETLINE 6 .TOP .LMARGIN>)>
				   ; <RETURN>)>
			      <SET KEY ,DOWN-ARROW>)>
		       <COND (<EQUAL? .KEY ,UP-ARROW ,DOWN-ARROW
				      ,MAC-UP-ARROW ,MAC-DOWN-ARROW>
			      <SET LINE 8>
			      <COND (<EQUAL? .KEY ,UP-ARROW ,MAC-UP-ARROW>
				     <SET LINE 6>
				     <COND (<ZERO? ,DMODE>
					    <SET LINE 3>)>)>
			      <SHOW-SETLINE 7 .TOP .LMARGIN>
			      <RETURN>)>
		       <SOUND ,S-BOOP>>
		    <AGAIN>)
		   (<EQUAL? .LINE 8> ; "Exit"
		    <REPEAT ()
		       <SET KEY <DO-INPUT>>
		       <COND (<EQUAL? .KEY ,EOL ,LF>
			      <COND (<OR <NOT <EQUAL? ,HOST ,MACINTOSH>>
					 <MAKE-SURE?>>
				     <V-REFRESH>
				     <CONTINUING>
				     <RTRUE>)>
			      <SET KEY ,DOWN-ARROW>)>
		       <COND (<EQUAL? .KEY ,UP-ARROW ,DOWN-ARROW>
			      <SET LINE 0>
			      <COND (<EQUAL? .KEY ,UP-ARROW>
				     <SET LINE 7>)>
			      <SHOW-SETLINE 8 .TOP .LMARGIN>
			      <RETURN>)>
		       <SOUND ,S-BOOP>>
		    <AGAIN>)>
	     <REPEAT ()
		<SET KEY <DO-INPUT>>
		<COND (<EQUAL? .KEY ,UP-ARROW>
		       <SHOW-SETLINE .LINE .TOP .LMARGIN>
		       <COND (<DLESS? LINE 0>
			      <SET LINE 8>)>
		       <RETURN>)
		      (<EQUAL? .KEY ,DOWN-ARROW ,EOL ,LF>
		       <SHOW-SETLINE .LINE .TOP .LMARGIN>
		       <COND (<AND <ZERO? ,DMODE>
				   <EQUAL? .LINE 3>>
			      <SET LINE 7>
			      <RETURN>)>
		       <INC LINE>
		       <RETURN>)
		      (<EQUAL? .KEY ,RIGHT-ARROW ,LEFT-ARROW ,SP>
		       <COND (<ZERO? .LINE>
			      <COND (<ZERO? ,DMODE>
				     <INC DMODE>)
				    (T
				     <SETG DMODE 0>)>
			      <SHOW-SETLINE 4 .TOP .LMARGIN>
			      <SHOW-SETLINE 5 .TOP .LMARGIN>
			      <SHOW-SETLINE 6 .TOP .LMARGIN>)
			     (<EQUAL? .LINE 2>
			      <COND (<BTST <LOWCORE FLAGS> 1>
				     <DIROUT ,D-PRINTER-OFF>)
				    (T
				     <DIROUT ,D-PRINTER-ON>)>)
			     (<EQUAL? .LINE 3>
			      <COND (<ZERO? ,SAY-STAT>
				     <INC SAY-STAT>)
				    (T
				     <SETG SAY-STAT 0>)>)
			     (<EQUAL? .LINE 4>
			      <COND (<EQUAL? ,MAP-ROUTINE ,CLOSE-MAP>
				     <SETG MAP-ROUTINE ,FAR-MAP>)
				    (T
				     <SETG MAP-ROUTINE ,CLOSE-MAP>)>)
			     (<EQUAL? .LINE 6>
			      <COND (<ZERO? ,AUTO>
				     <INC AUTO>)
				    (T
				     <SETG AUTO 0>)>)
			     (<EQUAL? .KEY ,RIGHT-ARROW ,SP>
			      <COND (<EQUAL? .LINE 1>
				     <COND (<IGRTR? VERBOSITY 2>
					    <SETG VERBOSITY 0>)>)
				    (<EQUAL? .LINE 5>
				     <COND (<ZERO? ,PRIOR>
					    <SETG PRIOR ,SHOWING-ROOM>
					    <SETG IN-DBOX ,SHOWING-ROOM>)
					   (<EQUAL? ,PRIOR ,SHOWING-ROOM>
					    <SETG PRIOR ,SHOWING-INV>
					    <SETG IN-DBOX ,SHOWING-INV>)
					   (<AND <EQUAL? ,PRIOR
							 ,SHOWING-INV>
						 <NOT <EQUAL? ,STAT-ROUTINE
							      ,BAR-NUMBER>>>
					    <SETG PRIOR ,SHOWING-STATS>
					    <SETG IN-DBOX ,SHOWING-STATS>)
					   (T
					    <SETG PRIOR 0>)>)>)
			     (T
			      <COND (<EQUAL? .LINE 1>
				     <COND (<DLESS? VERBOSITY 0>
					    <SETG VERBOSITY 2>)>)
				    (<EQUAL? .LINE 5>
				     <COND (<ZERO? ,PRIOR>
					    <SETG PRIOR ,SHOWING-STATS>	   
					    <SETG IN-DBOX ,SHOWING-STATS>
					    <COND (<EQUAL? ,STAT-ROUTINE
							   ,BAR-NUMBER>
						   <SETG PRIOR ,SHOWING-INV>
					           <SETG IN-DBOX
							 ,SHOWING-INV>)>)
					   (<EQUAL? ,PRIOR ,SHOWING-ROOM>
					    <SETG PRIOR 0>)
					   (<EQUAL? ,PRIOR ,SHOWING-INV>
					    <SETG PRIOR ,SHOWING-ROOM>
					    <SETG IN-DBOX ,SHOWING-ROOM>)
					   (<NOT <EQUAL? ,STAT-ROUTINE
							 ,BAR-NUMBER>>
					    <SETG PRIOR ,SHOWING-INV>
					    <SETG IN-DBOX ,SHOWING-INV>)>)>)>
		       <RETURN>)>
		<SOUND ,S-BOOP>>>>

<ROUTINE SHOW-SETLINE (LINE TOP LMARGIN "OPT" (HL 0) "AUX" X)
	 <SCREEN ,S-WINDOW>
	 <SET TOP <+ .TOP 2>>
	 <SET X <+ <GETB ,SETOFFS .LINE> .LMARGIN>>
	 <DO-CURSET <+ <* .LINE 2> .TOP> .X>
	 <HLIGHT ,H-NORMAL>
	 <HLIGHT ,H-MONO>
	 <COLOR ,FORE ,BGND>
	 <COND (<T? .HL>
		<HLIGHT ,H-INVERSE>)>
	 <PRINT <GET ,SNAMES .LINE>>
	 <HLIGHT ,H-NORMAL>
	 <HLIGHT ,H-MONO>
	 <PRINTC ,SP>
	 <COND (<EQUAL? .LINE 7 8>
		<RTRUE>)
	       (<ZERO? .LINE>
		<COND (<T? ,DMODE>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Enhanced ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTC ,SP>
		<COND (<ZERO? ,DMODE>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Standard ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<RTRUE>)
	       (<EQUAL? .LINE 1>
		<COND (<ZERO? ,VERBOSITY>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Superbrief ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTC ,SP>
		<COND (<EQUAL? ,VERBOSITY 1>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Brief ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTC ,SP>
		<COND (<EQUAL? ,VERBOSITY 2>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Verbose ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<RTRUE>)
	       (<EQUAL? .LINE 2>
		<SET X <BAND <LOWCORE FLAGS> 1>>
		<COND (<ZERO? .X>	     
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Off ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTC ,SP>
		<COND (<T? .X>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " On ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<RTRUE>)
	       (<EQUAL? .LINE 3>
		<COND (<ZERO? ,SAY-STAT>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Off ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTC ,SP>
		<COND (<T? ,SAY-STAT>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " On ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<RTRUE>)
	       (<EQUAL? .LINE 4>
		<COND (<ZERO? ,DMODE>)
		      (<EQUAL? ,MAP-ROUTINE ,CLOSE-MAP>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Normal ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTC ,SP>
		<COND (<ZERO? ,DMODE>)
		      (<EQUAL? ,MAP-ROUTINE ,FAR-MAP>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Wide ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<RTRUE>)
	       (<EQUAL? .LINE 5>
		<COND (<ZERO? ,DMODE>)
		      (<ZERO? ,PRIOR>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Off ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTC ,SP>
		<COND (<ZERO? ,DMODE>)
		      (<EQUAL? ,PRIOR ,SHOWING-ROOM>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Room ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTC ,SP>
		<COND (<ZERO? ,DMODE>)
		      (<EQUAL? ,PRIOR ,SHOWING-INV>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Inventory ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<COND (<NOT <EQUAL? ,STAT-ROUTINE ,BAR-NUMBER>>
		       <PRINTC ,SP>
		       <COND (<ZERO? ,DMODE>)
			     (<EQUAL? ,PRIOR ,SHOWING-STATS>
			      <HLIGHT ,H-INVERSE>)>
		       <TELL " Status ">
		       <HLIGHT ,H-NORMAL>
		       <HLIGHT ,H-MONO>)>
		<RTRUE>)
	       (<EQUAL? .LINE 6>
		<COND (<ZERO? ,DMODE>)
		      (<T? ,AUTO>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Automatic ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<PRINTC ,SP>
		<COND (<ZERO? ,DMODE>)
		      (<ZERO? ,AUTO>
		       <HLIGHT ,H-INVERSE>)>
		<TELL " Off ">
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-MONO>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	        


