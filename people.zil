"PEOPLE for BEYOND ZORK: Copyright 1987 Infocom, Inc.
 All rights reserved."

"*** OLD SALT ***"

<OBJECT SALT
	(LOC ON-WHARF)
	(DESC "old sailor")
	(FLAGS VOWEL LIVING PERSON TRANSPARENT)
	(SYNONYM SAILOR ARTIST PAINTER MAN GUY FELLOW
	         HIMSELF YOURSELF M MALE)
	(ADJECTIVE OLD)
	(LIFE I-SALT)
	(DESCFCN SALT-F)
	(CONTFCN SALT-F)
	(ACTION SALT-F)>

<ROUTINE SALT-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA ,SALT " is seated before " A ,EASEL
		      ", dabbing color onto " A ,CANVAS>
		<COND (<SEE-ANYTHING-IN? ,SALT>
		       <TELL ". He's holding ">
		       <CONTENTS ,SALT>)>
		<TELL C ,PER>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<AND <VERB? HELLO>
			    <PRSO? ROOMS SALT>>
		       <GREET-SAILOR>
		       <RFATAL>)
		      (<AND <VERB? TELL-ABOUT SSHOW>
			    <PRSO? ME>>
		       <ASK-SALT-ABOUT ,PRSI>
		       <RFATAL>)
		      (<OR <VERB? EXAMINE WHAT WHO WHERE>
			   <AND <VERB? SHOW>
				<PRSI? ME>>>
		       <ASK-SALT-ABOUT ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? GIVE GET-FOR>
			    <PRSI? ME>>
		       <ASK-SALT-FOR ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? SGIVE SGET-FOR>
			    <PRSO? ME>>
		       <ASK-SALT-FOR ,PRSI>
		       <RFATAL>)>
		<DEAF-SALT>
		<RFATAL>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <HARMLESS ,PRSI>
		       <RTRUE>)
		      (<VERB? GIVE GET-FOR>
		       <GIVE-TO-SALT ,PRSO>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <DO-GLANCE ,SALT ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? TELL>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO "'s ice-blue eyes glance up from his work." CR>
		<RTRUE>)
	       (<VERB? YELL>
		<NOT-DEAF>
		<RTRUE>)
	       (<VERB? ASK-FOR>
		<ASK-SALT-FOR ,PRSI>
		<RTRUE>)
	       (<VERB? ASK-ABOUT>
		<ASK-SALT-ABOUT ,PRSI>
		<RTRUE>)
	       (<VERB? TELL-ABOUT>
		<DO-GLANCE ,SALT ,PRSI>
		<RTRUE>)
	       (<VERB? HELLO GOODBYE WAVE-AT>
		<GREET-SAILOR>
		<RTRUE>)
	       (<SET X <HURTING?>>
		<HARMLESS>
	        <RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE NOT-DEAF ()
	 <MAKE ,SALT ,SEEN>
	 <TELL CTHE ,SALT " cringes. \"I'm not deaf, y'know!\"" CR>
	 <RTRUE>>

<ROUTINE DEAF-SALT ("AUX" X)
	 <MAKE ,SALT ,SEEN>
	 <SET X <RANDOM 100>>
	 <COND (<L? .X 33>
		<TELL CTHE ,SALT
" doesn't look up from his work. Perhaps he didn't hear you." CR>
		<RTRUE>)
	       (<L? .X 67>
		<TELL CTHE ,SALT 
" cocks his head. \"Eh? Didn't catch that.\"" CR>
		<RTRUE>)>
	 <TELL "\"Stop whispering, ">
	 <BOY-GIRL>
	 <TELL "! Can't hear a word you're sayin'.\"" CR>
	 <RTRUE>>

<ROUTINE BOY-GIRL ()
	 <COND (<IS? ,PLAYER ,FEMALE>
		<TELL B ,W?GIRL>
		<RTRUE>)>
	 <TELL B ,W?BOY>
	 <RTRUE>>

<ROUTINE GREET-SAILOR ()
	 <MAKE ,SALT ,SEEN>
	 <COND (<PROB 33>
		<DEAF-SALT>
		<RTRUE>)>
	 <TELL CTHE ,SALT>
	 <COND (<IS? ,SALT ,TOUCHED>
		<TELL " shrugs. \"Okay. Hello, again.\"" CR>
		<RTRUE>)>
	 <MAKE ,SALT ,TOUCHED>
	 <COND (<AND <EQUAL? ,P-PRSA-WORD ,W?HELLO>
		     <NOUN-USED? ,W?SAILOR>>
		<TELL 
" chuckles softly and nods. \"Thought I 'membered you. ">)
	       (T
		<TELL " nods. \"">)>
	 <TELL "Hello, ">
	 <BOY-GIRL>
	 <TELL ,PERQ>
	 <RTRUE>> 

<ROUTINE ASK-SALT-ABOUT (OBJ "AUX" TBL LEN X)
	 <MAKE ,SALT ,SEEN>
	 <COND (<PROB 33>
		<DEAF-SALT>
		<RTRUE>)>
	 <COND (<NOT <VISIBLE? .OBJ>>		    
		<PERPLEXED ,SALT>
		<TELL "Not sure">
		<WHO-WHAT .OBJ>
		<TELL "you're talkin' 'bout, ">
		<BOY-GIRL>
		<TELL ,PERQ>
		<RTRUE>)
	       (<EQUAL? .OBJ ,SALT>
		<TELL "\"Been retired, ah, goin' on five years.\"" CR>
		<RTRUE>)
	       (<EQUAL? .OBJ ,SHILL>
		<TELL "\"Lucky ye saw it a-floatin' there.\"" CR>
		<RTRUE>)
	       (<EQUAL? .OBJ ,EASEL ,CANVAS>
		<TELL "\"Like it? Reminds me o' the good old days.\"" CR>
		<RTRUE>)
	       (<PROB 75>
		<DEAF-SALT>
		<RTRUE>)>
	 <IGNORANT ,SALT .OBJ>
	 <RTRUE>>
	       
<ROUTINE ASK-SALT-FOR (OBJ "AUX" X L)
	 <MAKE ,SALT ,SEEN>
	 <COND (<PROB 33>
		<DEAF-SALT>
		<RTRUE>)
	       (<EQUAL? .OBJ ,EASEL ,CANVAS>
		<TELL "\"Sorry. Not for sale.\"" CR>
		<RTRUE>)>
	 <AINT-GOT ,SALT .OBJ>
	 <RTRUE>>

<ROUTINE AINT-GOT (WHO OBJ)
	 <TELL "\"Don't have " A .OBJ>
	 <PRINT ",\" points out ">
	 <TELL THE .WHO ,PERIOD>
	 <RTRUE>>

<ROUTINE GIVE-TO-SALT (OBJ)
	 <MAKE ,SALT ,SEEN>
	 <COND (<GIVING-LOOT? .OBJ ,SALT>
		<RTRUE>)>
	 <NO-THANKS ,SALT>
	 <RTRUE>>

<ROUTINE NO-THANKS (WHO)
	 <TELL CTHE .WHO " shakes his head. \"No, thanks.\"" CR>
	 <RTRUE>>

<ROUTINE DO-GLANCE (WHO OBJ)
	 <MAKE .WHO ,SEEN>
	 <TELL CTHE .WHO>
	 <COND (<VISIBLE? .OBJ>
		<TELL ,GLANCES-AT THE .OBJ>)
	       (T
		<PRINT " gives you a puzzled frown">)>
	 <PRINT ", but says nothing.|">
	 <RTRUE>>

"*** INNCOOK ***"

<OBJECT COOK
	(LOC IN-KITCHEN)
	(DESC "cook")
	(FLAGS NOALL LIVING PERSON TRANSPARENT)
	(SYNONYM GROTE CLUTCHCAKE COOK MAN GUY FELLOW PERSON
	 	 SELF HIMSELF YOURSELF)
	(ADJECTIVE GROTE)
	(LIFE I-COOK)
	(DESCFCN COOK-F)
	(ACTION COOK-F)>

<ROUTINE COOK-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A skinny old cook is bustling around the kitchen.">
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<AND <VERB? TELL-ABOUT SSHOW>
			    <PRSO? ME>>
		       <ASK-COOK-ABOUT ,PRSI>
		       <RFATAL>)
		      (<OR <VERB? EXAMINE WHAT WHO WHERE>
			   <AND <VERB? SHOW>
				<PRSI? ME>>>
		       <ASK-COOK-ABOUT ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? GIVE GET-FOR>
			    <PRSI? ME>>
		       <ASK-COOK-FOR ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? SGIVE SGET-FOR>
			    <PRSO? ME>>
		       <ASK-COOK-FOR ,PRSI>
		       <RFATAL>)>
		<TELL CTHE ,COOK
" scowls. \"Don't bother me now, I'm busy!\"" CR>
		<RFATAL>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<IS? ,PRSI ,NODESC>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<VERB? BUY-FROM>
		       <ASK-COOK-FOR ,PRSO>
		       <RTRUE>)
		      (<VERB? GIVE GET-FOR>
		       <GIVE-TO-COOK ,PRSO>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <SHOW-TO-COOK ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<IS? ,PRSO ,NODESC>
		<COND (<SET X <TALKING?>>
		       <PCLEAR>
		       <TELL "He">
		       <PRINT " doesn't seem to hear you.|">
		       <RFATAL>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? ASK-FOR>
		<ASK-COOK-FOR ,PRSI>
		<RTRUE>)
	       (<VERB? ASK-ABOUT>
		<ASK-COOK-ABOUT ,PRSI>
		<RTRUE>)
	       (<VERB? TELL-ABOUT>
		<SHOW-TO-COOK ,PRSI>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE ASK-COOK-ABOUT (OBJ "AUX" TBL LEN X)
	 <SEE-CHARACTER ,COOK>
	 <MAKE ,COOK ,SEEN>
         <COND (<EQUAL? .OBJ ,BOTTLE>
		<COND (<IS? ,ONION ,SEEN>
		       <TELL 
"\"Got it put away, nice and safe. Thanks again.\"" CR>
		       <RTRUE>)
		      (<IS? ,BOTTLE ,IDENTIFIED>
		       <TELL "\"This here onion's yours if you ">
		       <COND (<VISIBLE? .OBJ>
			      <TELL "hand it over.\"" CR>
			      <RTRUE>)>
		       <TELL "get it for me.\"" CR>
		       <RTRUE>)
		      (<IS? ,ONION ,TOUCHED>
		       <UNMAKE ,COOK ,SEEN>
		       <TELL "\"Ahem.\"" CR>
		       <I-ONION-OFFER>
		       <RTRUE>)>
		<DO-GLANCE ,COOK ,CELLAR-DOOR>
		<RTRUE>)
	       
	       (<EQUAL? .OBJ ,COOK>
		<TELL "\"Grote Clutchcake's the name.\"" CR>
		<RTRUE>)
	       (<EQUAL? .OBJ ,CELLAR ,CELLAR-DOOR>
		<TELL
"\"Used t'be a wine cellar. Can't go down no more; too dangerous.\"" CR>
		<RTRUE>)
	       (<NOT <VISIBLE? .OBJ>>		    
		<PERPLEXED ,COOK>
		<TELL "Don't know">
		<WHO-WHAT .OBJ>
		<TELL "you're talkin' 'bout.\"" CR>
		<RTRUE>)
	       (<EQUAL? .OBJ ,ONION>
		<COOK-MENTIONS-ONION>
		<RTRUE>)>
	 <TELL CTHE ,COOK " shrugs impatiently. \"Can't say anythin' 'bout ">
	 <PRONOUN .OBJ>
	 <TELL " you wouldn't know already.\"" CR>
	 <RTRUE>>
		
<ROUTINE ASK-COOK-FOR (OBJ "AUX" X L)
	 <SEE-CHARACTER ,COOK>
	 <SET L <LOC .OBJ>>
	 <MAKE ,COOK ,SEEN>
	 <COND (<NOT <VISIBLE? .OBJ>>)
	       (<EQUAL? .OBJ ,ONION>
		<COND (<IS? .OBJ ,SEEN>
		       <TELL "\"It's yours. Roll it outa here.\"" CR>
		       <RTRUE>)
		      (<IS? ,BOTTLE ,IDENTIFIED>
		       <TELL "\"Yours for " THE ,BOTTLE>
		       <COND (<NOT <IS? ,BOTTLE ,TOUCHED>>
			      <TELL " downstairs">)>
		       <TELL ,PERQ>
		       <RTRUE>)>
		<COOK-MENTIONS-ONION>
		<RTRUE>)>
	 <AINT-GOT ,COOK .OBJ>
	 <RTRUE>>

<ROUTINE COOK-MENTIONS-ONION ()
	 <COND (<NOT <IS? ,ONION ,TOUCHED>>
		<MAKE ,ONION ,TOUCHED>
		<MAKE ,COOK ,SEEN>
		<DEQUEUE ,I-COOK>
		<QUEUE ,I-ONION-OFFER>
		<TELL CTHE ,COOK " gives " THE ,ONION
		      " an affectionate kick. ">)>
	 <TELL 
"\"Nice, eh? Won second place at the Borphee County Fair.\"" CR>
	 <RTRUE>>

<ROUTINE STOP-ONION-OFFER ()
	 <MAKE ,BOTTLE ,IDENTIFIED>
	 <DEQUEUE ,I-ONION-OFFER>
	 <COND (<NOT <QUEUED? ,I-COOK>>
		<QUEUE ,I-COOK>)>
	 <MAKE ,COOK ,SEEN>
	 <RFALSE>>

<ROUTINE GIVE-TO-COOK (OBJ)
	 <SEE-CHARACTER ,COOK>
	 <MAKE ,COOK ,SEEN>
	 <COND (<GIVING-LOOT? .OBJ ,COOK>
		<RTRUE>)>
	 <TELL CTHE ,COOK>
	 <COND (<EQUAL? .OBJ ,BOTTLE>
		<VANISH .OBJ>
		<MAKE ,ONION ,SEEN>
		<TELL "'s eyes grow large as he takes " THE .OBJ
". \"Been after this thing for years,\" he cries, turning it over and over in his hands before stowing it quickly out of sight. ">
		<COND (<NOT <IS? ,BOTTLE ,IDENTIFIED>>
		       <TELL "\"I owe you a big favor, ">
		       <BOY-GIRL>
		       <TELL ". A ">
		       <ITALICIZE "very">
		       <TELL " big favor. Big as this here onion.\" ">)>
		<STOP-ONION-OFFER>
		<TELL "Your eyes follow his to " THE ,ONION 
" near the exit. \"All yours,\" he says, patting it affectionately." CR>
		<RTRUE>)>
	 <TELL " refuses " THE .OBJ
	       " with a shake of his head. \"No, thanks.\"" CR>
	 <RTRUE>>

<ROUTINE COOK-SEES-BOTTLE ()
	 <STOP-ONION-OFFER>
	 <MAKE ,BOTTLE ,MUNGED>
	 <TELL "\"The bottle!\" gasps " THE ,COOK
	       " when he sees it">
	 <COND (<IN? ,BOTTLE ,PLAYER>
		<TELL " in your hands">)>
	 <PRINT ". \"You got it!\"|">
	 <RTRUE>>

<ROUTINE SHOW-TO-COOK (OBJ)
	 <SEE-CHARACTER ,COOK>
	 <MAKE ,COOK ,SEEN>
	 <COND (<EQUAL? .OBJ ,BOTTLE>
		<COND (<NOT <IS? .OBJ ,IDENTIFIED>>
		       <COOK-SEES-BOTTLE>
		       <RTRUE>)>
		<STOP-ONION-OFFER>
		<TELL "\"That's the one!\" he gasps">
		<PRINT ". \"You got it!\"|">
		<RTRUE>)>
	 <TELL "\"How interesting,\" yawns " THE ,COOK>
	 <COND (<VISIBLE? .OBJ>
		<TELL ", glancing at " THE .OBJ>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

"*** BAND ***"

<OBJECT BANDITS
	(LOC IN-PUB)
	(DESC "group of bandits")
	(FLAGS NODESC LIVING PERSON TRANSPARENT)
	(SYNONYM BANDITS BANDIT PEOPLE GUYS FELLOWS GROUP)
	(ACTION BANDITS-F)>

<ROUTINE BANDITS-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? POINT-AT TOUCH-TO FIRE-AT>
		       <TELL "There are too many of them here." CR>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <SUICIDE>
		       <RTRUE>)
		      (<VERB? GIVE SHOW GET-FOR FEED>
		       <HEEDLESS>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<HEEDLESS>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON>
		<NOSEY "starin' at">
		<RTRUE>)
	       (<VERB? LISTEN>
		<NOSEY "listenin' to">
		<RTRUE>)
	       (<SET X <HURTING?>>
		<SUICIDE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE NOSEY (STR)
	 <MAKE ,PRSO ,SEEN>
	 <TELL "\"Who're you " .STR 
"?\" demands a very large bandit. You wisely decide to turn your attention elsewhere." CR>
	 <RTRUE>>

<ROUTINE SUICIDE ()
	 <TELL "Suicide. Monsters are one thing; an armed " 'BANDITS
	       " is quite another." CR>
	 <RTRUE>>

<ROUTINE HEEDLESS ()
	 <PCLEAR>
	 <TELL "The bandits glare at your interruption. \"Scram.\"" CR>
	 <RTRUE>>
		       
<OBJECT OWOMAN
	(LAST-LOC 0)
	(DESC "old woman")
	(FLAGS VOWEL LIVING PERSON FEMALE TRANSPARENT)
	(SYNONYM Y\'GAEL WOMAN LADY DAME FEMALE F)
	(ADJECTIVE OLD)
	(LIFE I-OWOMAN)
	(DESCFCN OWOMAN-F)
	(ACTION OWOMAN-F)>

<ROUTINE OWOMAN-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA ,OWOMAN ,SIS <PICK-NEXT ,OWOMAN-EYES> C ,PER>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<AND <VERB? TELL-ABOUT SSHOW>
			    <PRSO? ME>>
		       <ASK-OWOMAN-ABOUT ,PRSI>
		       <RFATAL>)
		      (<OR <VERB? EXAMINE REQUEST WHAT WHO WHERE>
			   <AND <VERB? SHOW>
				<PRSI? ME>>>
		       <ASK-OWOMAN-ABOUT ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? GIVE GET-FOR>
			    <PRSI? ME>>
		       <ASK-OWOMAN-FOR ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? SGIVE SGET-FOR>
			    <PRSO? ME>>
		       <ASK-OWOMAN-FOR ,PRSI>
		       <RFATAL>)
		      (<AND <VERB? SELL-TO>
			    <PRSI? ME>>
		       <BUY-X-WITH-Y ,PRSO ,MONEY>
		       <RTRUE>)
		      (<AND <VERB? SSELL-TO>
			    <PRSO? ME>>
		       <BUY-X-WITH-Y ,PRSI ,MONEY>
		       <RTRUE>)
		      (<AND <VERB? HELLO GOODBYE>
			    <PRSO? ROOMS OWOMAN>>
		       <GREET-OWOMAN>
		       <RFATAL>)>
		<TELL "\"I'm not used to being ordered about,\" observes "
		      THE ,OWOMAN " coldly." CR>
		<RFATAL>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<NOUN-USED? ,W?Y\'GAEL>
		<COND (<NOT <IS? ,OWOMAN ,MUNGED>>
		       <MAKE ,OWOMAN ,MUNGED>
		       <TELL ,CTHELADY>
		       <PRINT " raises an eyebrow">
		       <TELL " as you speak her Name." CR>
		       <RFATAL>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <HARMLESS ,PRSI>
		       <RTRUE>)
		      (<VERB? GIVE GET-FOR>
		       <GIVE-TO-OWOMAN ,PRSO>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <ASK-OWOMAN-ABOUT ,PRSO>
		       <RTRUE>)
		      (<VERB? SELL-TO>
		       <TRADE-FOR-LOOT ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<SET X <GETP ,PRSO ,P?LAST-LOC>>
		<COND (<VISIBLE? .X>)
		      (<T? .X>
		       <TELL
"That's odd. She looks just like the woman you met in " THE .X ,PERIOD>
		       <RTRUE>)>
		<TELL CTHEO " regards you with equal interest." CR>
		<RTRUE>)
	       (<VERB? ASK-FOR>
		<ASK-OWOMAN-FOR ,PRSI>
		<RTRUE>)
	       (<VERB? ASK-ABOUT>
		<ASK-OWOMAN-ABOUT ,PRSI>
		<RTRUE>)
	       (<VERB? TELL-ABOUT>
		<COND (<IN? ,PRSI ,PLAYER>
		       <GIVE-TO-OWOMAN ,PRSI>
		       <RTRUE>)>
		<ASK-OWOMAN-ABOUT ,PRSI>
		<RTRUE>)
	       (<VERB? HELLO WAVE-AT GOODBYE>
		<GREET-OWOMAN>
		<RTRUE>)
	       (<SET X <HURTING?>>
		<HARMLESS>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE GREET-OWOMAN ()
	 <MAKE ,OWOMAN ,SEEN>
	 <TELL ,CTHELADY " nods graciously." CR>
	 <RTRUE>>

<CONSTANT OWOMAN-TABLE
	  <PLTABLE
	   <PTABLE SPADE "I've always been one to call a spade a spade">
	   <PTABLE LEAFLET "I don't look at other people's mail">
	   <PTABLE PARCEL "I don't look at other people's mail">
	   <PTABLE CROWN "Tidy little trinket, that">
	   <PTABLE DOUBLOON "Tidy little trinket, that">
	   <PTABLE DIAMOND "Tidy little trinket, that">
	   <PTABLE ORNAMENT "Aluminized plastic. Festive, though">
	   <PTABLE RELIQUARY "Standard clerical issue">
	   <PTABLE SADDLE "Smallish; must be for a pony">
	   <PTABLE SEXTANT "Antiques are big nowadays">
	   <PTABLE LANTERN "Antiques are big nowadays">
	   <PTABLE RUG "Phew! That thing wants a good airing">
	   <PTABLE TUSK "That'll make some piano awfully happy">
	   <PTABLE BOTTLE "A fair vintage">
	   <PTABLE BFLY "A fair specimen">
	   <PTABLE CARD "Not the handsomest of mages">
	   >>   

<ROUTINE ASK-OWOMAN-ABOUT (OBJ "AUX" TBL LEN X)
	 <SEE-CHARACTER ,OWOMAN>
	 <COND (<EQUAL? .OBJ ,MONEY ,INTNUM>
		<TELL "\"My favorite subject.\"" CR>
		<RTRUE>)
	       (<WHAT-TALK? ,OWOMAN .OBJ>
		<RTRUE>)
	       (<EQUAL? .OBJ ,KEY1 ,KEY2 ,KEY3>
		<TELL "\"How tawdry.\"" CR>
		<RTRUE>)
	       (<EQUAL? .OBJ ,PARASOL>
		<TELL ,CTHELADY>
		<PRINT  " raises an eyebrow">
		<PRINT ", but says nothing.|">
		<RTRUE>)
	       (<OR <EQUAL? .OBJ ,BOUTIQUE ,WEAPON-SHOP ,MSHOPPE>
		    <EQUAL? .OBJ ,BCASE ,MCASE ,WCASE>>
		<TELL "\"Best selection in the Southlands.\"" CR>
		<RTRUE>)
	       (<EQUAL? .OBJ ,CURTAIN ,OWOMAN ,ME>
		<TELL ,CTHELADY " smiles wryly">
		<PRINT ", but says nothing.|">
		<RTRUE>)
	       (<AND <HERE? IN-BOUTIQUE>
		     <BOUTIQUE-KNOWLEDGE? .OBJ>>
		<RTRUE>)
	       (<AND <HERE? IN-WEAPON>
		     <WEAPON-KNOWLEDGE? .OBJ>>
		<RTRUE>)
	       (<AND <HERE? IN-MAGICK>
		     <MAGICK-KNOWLEDGE? .OBJ>>
		<RTRUE>)>
	 
	 <SET LEN <GET ,OWOMAN-TABLE 0>>
	 <REPEAT ()
	    <SET TBL <GET ,OWOMAN-TABLE .LEN>>
	    <SET X <GET .TBL 0>>
	    <COND (<EQUAL? .X .OBJ>
		   <TELL "\"" <GET .TBL 1>>
		   <REVEAL-VALUE .X <GETP ,HERE ,P?THIS-CASE>>
		   <RTRUE>)
		  (<DLESS? LEN 1>
		   <RETURN>)>>	 
	 
	 <COND (<AND <NOT <HERE? IN-MAGICK>>
		     <SET X <GET ,MAGIC-ITEMS 0>>
		     <SET X <INTBL? .OBJ <REST ,MAGIC-ITEMS 2> .X>>>
		<ASK-IN .OBJ "Magick Shoppe in Gurth City">
		<RTRUE>)>
	 <COND (<AND <NOT <HERE? IN-WEAPON>>
		     <SET X <GET ,WEAPON-ITEMS 0>>
		     <SET X <INTBL? .OBJ <REST ,WEAPON-ITEMS 2> .X>>>
		<ASK-IN .OBJ "weapon shop in Accardi">
		<RTRUE>)>
	 <COND (<AND <NOT <HERE? IN-BOUTIQUE>>
		     <SET X <GET ,ARMOR-ITEMS 0>>
		     <SET X <INTBL? .OBJ <REST ,ARMOR-ITEMS 2> .X>>>
		<ASK-IN .OBJ "boutique in Mizniaport">
		<RTRUE>)>
	 
	 <TELL "\"I'm afraid I can't tell you very much about ">
	 <PRONOUN .OBJ>
	 <TELL ",\" apologizes " THE ,OWOMAN ,PERIOD>
	 <RTRUE>>
		
<ROUTINE ASK-IN (OBJ STR)
	 <TELL ,CTHELADY ,GLANCES-AT THE .OBJ 
". \"Can't tell you much about this here,\" she mutters. \"Bet the " .STR
" would know something, though.\"" CR>
	 <RTRUE>>

<ROUTINE BOUTIQUE-KNOWLEDGE? (OBJ)
	 <COND (<EQUAL? .OBJ ,PACK>
		<TELL "\"Perfect for those long adventures">)
	       
	       (<EQUAL? .OBJ ,CLOAK>
		<TELL 
"\"A fine example of elvish tailoring. 'Tis said a potent virtue is woven into the cloth">)
	       
	       (<EQUAL? .OBJ ,TUNIC>
		<TELL "\"Oh, that. Last week's fashion, I'm afraid">)
	       
	       (<EQUAL? .OBJ ,SCALE>
		<TELL 
"\"Good basic protection. Not too bulky, not too expensive">)
	       
	       (<EQUAL? .OBJ ,CHAIN>
		<TELL 
"\"An effective design, if not particularly comfortable">)
	       
	       (<EQUAL? .OBJ ,PLATE>
		<TELL
"\"The last word in protection,\" states " THE ,OWOMAN 
" flatly. \"That stuff'll turn aside anything short of a grue's fangs">)
	       
	       (<EQUAL? .OBJ ,HELM ,SCABBARD>
		<SECRET-VIRTUE .OBJ>
		<RTRUE>)
	       
	       (T
		<RFALSE>)>
	 
	 <REVEAL-VALUE .OBJ ,BCASE>
	 <RTRUE>>

<ROUTINE WEAPON-KNOWLEDGE? (OBJ)
	 <COND (<EQUAL? .OBJ ,ARROW>
		<TELL "\"A primitive design; high drag coefficient">)
	       
	       (<EQUAL? .OBJ ,DAGGER>
		<TELL "\"Suitable for cleaning fish, I suppose">)
	       
	       (<EQUAL? .OBJ ,SWORD>
		<TELL 
"\"Of ancient elvish workmanship, if I'm not mistaken">)
	       
	       (<EQUAL? .OBJ ,SHILL>
		<TELL 
"\"Many an orc's skull bears the mark of this " 'SHILL>)
	       
	       (<EQUAL? .OBJ ,AXE>
		<TELL "\"A real skull-cleaver, that one">)
	       
	       (<EQUAL? .OBJ ,PHASE ,SCABBARD ,HELM>
		<SECRET-VIRTUE .OBJ>
		<RTRUE>)
	       
	       (T
		<RFALSE>)>
	 
	 <REVEAL-VALUE .OBJ ,WCASE>
	 <RTRUE>>

<ROUTINE MAGICK-KNOWLEDGE? (OBJ "AUX" VAL ACT FX)
	 <SETG IDING .OBJ>
	 <SET ACT <GETP .OBJ ,P?ACTION>>
	 <SET FX <GETP .OBJ ,P?EFFECT>>
	 <COND (<EQUAL? .ACT ,SLEEP-WAND-F>
		<DO-ID>
		<TELL "Aim this at a creature and watch it stagger">)
	       (<EQUAL? .ACT ,BLAST-WAND-F>
		<DO-ID>
		<TELL "Instant death, with few exceptions">)
	       (<EQUAL? .ACT ,TELE-WAND-F>
		<DO-ID>
		<TELL "Teleports trouble out of your way">)
	       (<EQUAL? .ACT ,IO-WAND-F>
		<DO-ID>
		<TELL "Makes things turn inside-out">)
	       (<EQUAL? .ACT ,LEV-WAND-F>
		<DO-ID>
		<TELL "Floats 'most anything that isn't nailed down">)
	       (<EQUAL? .ACT ,DISPEL-WAND-F>
		<TELL ,CTHELADY " scowls. ">
		<DO-ID>
		<TELL "Neutralizes the effects of Magick">)
	       
	     ; "Potions."

	       (<EQUAL? .ACT ,HEALING-POTION-F>
		<DO-ID>
		<TELL "Just the thing in the heat of battle">)
	       (<EQUAL? .ACT ,FORGET-POTION-F>
		<DO-ID>
		<TELL "Hmm,\" mutters " THE ,OWOMAN
". \"Tried one of those once; can't recall what it does. Oh, well">)
	       (<EQUAL? .ACT ,DEATH-POTION-F>
		<DO-ID>
		<TELL "Don't understand why they mix these things">)
	       (<OR <EQUAL? .ACT ,MIGHT-POTION-F>
		    <EQUAL? .OBJ ,ROOT>>
		<DO-ID>
		<TELL "That'll put hair on your chest">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL ".\" " ,CTHELADY 
			     " blushes. \"Well, you know what I mean">)>)
	       (<EQUAL? .ACT ,IQ-POTION-F>
		<DO-ID>
		<TELL "Four years faster than GUE Tech, and a lot cheaper">)

	     ; "Scrolls."

	       (<EQUAL? .FX ,DO-PARTAY>
		<DO-ID>
		<TELL "Big fun at parties">)
	       (<EQUAL? .FX ,DO-FILFRE>
		<DO-ID>
		<TELL "Essential reading">)
	       (<EQUAL? .FX ,DO-GOTO>
		<DO-ID>
		<TELL "Just the thing for emergencies">)
	       (<EQUAL? .FX ,DO-BLESS-ARMOR>
		<DO-ID>
		<TELL "Bestows a rich blessing upon your armor">)
	       (<EQUAL? .FX ,DO-BLESS-WEAPON>
		<DO-ID>
		<TELL "Adds a touch of enchantment to any weapon">)
	       (<EQUAL? .FX ,DO-RENEWAL>
		<DO-ID>
		<TELL "How refreshing">)
	       (<EQUAL? .FX ,DO-GATE>
		<DO-ID>
		<TELL "Not as robust as Dimension Door, but serviceable">)
	       
	       (<EQUAL? .OBJ ,CAKE>
		<TELL ,CTHELADY 
" grimaces. \"Bleah. My aunt used to make those. Good for your brain, but not much else">)
	       
	       (<EQUAL? .OBJ ,CLOAK>
		<DO-ID>
		<TELL "Elvish, if the weave speaks true">)
	       
	       (<EQUAL? .OBJ ,RING>
		<TELL ,CTHELADY " smirks. ">
		<DO-ID>
		<TELL "Same as the Coal-Walkers of Egreth use">)
	       
	       (<EQUAL? .OBJ ,HELM>
		<DO-ID>
		<MAKE .OBJ ,PROPER>
		<TELL 
"A potent relic of the past 'Tis said the wearer commands the wisdom of kings, and can see the unseeable.\" She shudders visibly. \"Some things are better left unseen">)
	       
	       (<EQUAL? .OBJ ,GOBLET>
		<COND (<ZERO? ,GOBLET-WORD>
		       <SETUP-GOBLET>)>
		<TELL ,CTHELADY 
" turns pale, and lowers her voice to a barely audible whisper. \"The ">
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<TELL ",\" she hisses">
		<COND (<NOT <IS? .OBJ ,NEUTRALIZED>>
		       <TELL ", and thunder rumbles outside">)>
		<TELL 
". \"Beware! for its Name incurs the wrath of the Implementors">)
	       
	       (<EQUAL? .OBJ ,UHEMI ,LHEMI>
		<TELL "\"Hmm,\" mutters " THE ,OWOMAN 
		      ". \"Some great potential lies within">)
	       
	       (<EQUAL? .OBJ ,STONE>
		<COND (<NOT <IS? ,STONE ,NAMED>>
		       <SETUP-STONE>)>
		<TELL "\"Ah! The ">
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<TELL 
"! Visions of things yet to be lie within its depths, for those with enough wit to see them">)
	       
	       (<EQUAL? .OBJ ,RFOOT ,CLOVER ,SHOE>
		<TELL "\"A charm to ward off ill luck">)
	       
	       (<EQUAL? .OBJ ,SCABBARD>
		<MAKE .OBJ ,IDENTIFIED>
		<TELL ,CTHELADY 
"'s voice lowers to a respectful whisper. \"Behold " THE .OBJ
", Blade of Entharion,\" she says. \"Though the Blade is long lost, the scabbard retains much virtue; for ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "s">)>
		<TELL 
"he who wears it is blessed with wondrous powers of recuperation">)
	       	       
	       (<EQUAL? .OBJ ,VIAL>
		<TELL "\"Holy water,\" explains " THE ,OWOMAN
" after a brief glance. \"Standard issue against vampires, wraiths, anything dead that moves">)
	       
	       (<EQUAL? .OBJ ,GLASS>
		<TELL "\"A relic of ancient Pheebor,\" explains " THE ,OWOMAN
". \"Its purpose is lost in Time. Perhaps it is part of some greater Magick">)
	       
	       (<EQUAL? .OBJ ,ROSE>
		<TELL  
"\"A compass rose! Just the thing for an ill wind">)
	       
	       (<EQUAL? .OBJ ,GURDY>
		<TELL
"\"A versatile instrument. Dangerous in the wrong hands">)

	       (<EQUAL? .OBJ ,WHISTLE>
		<DO-ID>
		<TELL "Wrought by a platypus, like most nowadays">)
	        
	       (<EQUAL? .OBJ ,PHASE>
		<TELL
"\"Little more than a curiosity, at least on this Plane of existence">)
	       
	       (<EQUAL? .OBJ ,CHEST>
		<TELL ,CTHELADY
" studies " THE .OBJ " closely. \"Careful with this,\" she warns. \"The plaque on the lid is well worth reading">)
	       
	       (<EQUAL? .OBJ ,AMULET>
		<TELL "\"A useful bit of Magick, this. ">
		<COND (<ZERO? ,AMULET-STARS>
		       <TELL "Too bad it's all used up">)
		      (T
		       <TELL "Still got some life in it, too">)>)
	       
	       (<EQUAL? .OBJ ,SPENSE ,SPENSE2>
		<TELL 
"\"Spenseweed, of course. A wholesome treat">)

	       (<EQUAL? .OBJ ,BURIN>
		<TELL "\"Diamond-tipped, I see. Top of the line">)
	       
	       (<EQUAL? .OBJ ,JAR ,CIRCLET>
		<TELL 
"\"A vain bit of Magick; yet not without its uses">)
	       
	       (T
		<RFALSE>)>
	 
	 <COND (<IS? .OBJ ,NEUTRALIZED>
		<PRINT ". Unfortunately, ">
		<TELL "its Magick">
		<PRINT " appears to have been neutralized">)>
	 <REVEAL-VALUE .OBJ ,MCASE>
	 <RTRUE>>

<ROUTINE REVEAL-VALUE (OBJ CASE "AUX" VAL X)
	 <SET VAL <GETP .OBJ ,P?VALUE>>
	 <TELL C ,PER>
	 <COND (<ZERO? .VAL>
		<TELL "\"" CR>
		<RTRUE>)>
	 <TELL C ,SP>
	 <SET X ,OFFERS>
	 <COND (<NOT <IN? .OBJ .CASE>>
		<SET X ,USED-OFFERS>)>
	 <TELL <PICK-NEXT .X> N .VAL " zorkmid">
	 <COND (<NOT <EQUAL? .VAL 1>>
		<TELL "s">)>
	 <TELL ,PERQ>
	 <RTRUE>>

<ROUTINE SECRET-VIRTUE (OBJ)
	 <TELL ,CTHELADY " scrutinizes " THE .OBJ 
" with care. \"Hmm,\" she mutters. \"There may be a virtue in this ">
	 <PRINTD .OBJ>
	 <TELL 
" beyond its simple face value. Perhaps you should bring it to the ">
	 <PRINT "Magick Shoppe in Gurth City">
	 <TELL ,PERQ>
	 <RTRUE>>

<GLOBAL IDING:OBJECT <>>

<ROUTINE DO-ID ()
	 <COND (<NOT <IS? ,IDING ,IDENTIFIED>>
		<MAKE ,IDING ,IDENTIFIED>
		<WINDOW ,SHOWING-ALL>)>
	 <TELL "\"" <PICK-NEXT ,AH-YESSES> D ,IDING ". ">
	 <RFALSE>>

<ROUTINE ASK-OWOMAN-FOR (OBJ "AUX" X L)
	 <SEE-CHARACTER ,OWOMAN>
	 <SET L <LOC .OBJ>>
	 <COND (<NOT <EQUAL? .L ,OWOMAN>>
		<COND (<VISIBLE? .OBJ>
		       <TELL "\"I see ">
		       <COND (<IS? .OBJ ,PLURAL>
			      <TELL B ,W?SOME>)
			     (T
			      <TELL B ,W?ONE>)>
		       <TELL " there ">
		       <SAY-WHERE .L>
		       <TELL ",\" smiles " THE ,OWOMAN ,PERIOD>
		       <RTRUE>)>
		<TELL "\"I'm afraid I don't have " A .OBJ ,PERQ>
		<RTRUE>)>
	 <NOT-SO-FAST ,OWOMAN>
	 <RTRUE>>

<ROUTINE NOT-SO-FAST (OBJ)
	 <TELL "\"Not so fast!\" laughs " THE .OBJ
	       ", drawing away from you." CR>
	 <RTRUE>>

<ROUTINE GIVE-TO-OWOMAN (OBJ "AUX" X)
	 <SEE-CHARACTER ,OWOMAN>
	 <COND (<GIVING-LOOT? .OBJ ,OWOMAN>
		<RTRUE>)>
	 <SET X <GET ,MAGIC-ITEMS 0>>
	 <COND (<SET X <INTBL? .OBJ <REST ,MAGIC-ITEMS 2> .X>> 
		<COND (<NOT <HERE? IN-MAGICK>>
		       <CANT-USE-HERE .OBJ "Magick Shoppe in Gurth City">
		       <RTRUE>)>
		<TRADE-FOR-LOOT .OBJ>
		<RTRUE>)>
	 <SET X <GET ,ARMOR-ITEMS 0>>
	 <COND (<SET X <INTBL? .OBJ <REST ,ARMOR-ITEMS 2> .X>> 
		<COND (<NOT <HERE? IN-BOUTIQUE>>
		       <CANT-USE-HERE .OBJ "boutique in Mizniaport">
		       <RTRUE>)>
		<TRADE-FOR-LOOT .OBJ>
		<RTRUE>)>
	 <SET X <GET ,WEAPON-ITEMS 0>>
	 <COND (<SET X <INTBL? .OBJ <REST ,WEAPON-ITEMS 2> .X>> 
		<COND (<NOT <HERE? IN-WEAPON>>
		       <CANT-USE-HERE .OBJ "weapon shop in Accardi">
		       <RTRUE>)>
		<TRADE-FOR-LOOT .OBJ>
		<RTRUE>)>
	 <TRADE-FOR-LOOT .OBJ>
	 <RTRUE>>

<ROUTINE CANT-USE-HERE (OBJ STR)
	 <TELL ,CTHELADY ,GLANCES-AT THE .OBJ 
	       ". \"Can't use this here,\" she mutters. \"Maybe the "
	       .STR " would be interested.\"" CR>
	 <RTRUE>>
			
"*** ORATOR ***"

<OBJECT ORATOR
	(DESC "orator")
	(FLAGS LIVING PERSON VOWEL TRANSPARENT)
	(LIFE 0)
	(SYNONYM ORATOR SPEAKER MAN GUY FELLOW PERSON)
	(DESCFCN ORATOR-F)
	(ACTION ORATOR-F)>

<ROUTINE ORATOR-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA ,ORATOR " stands nearby, addressing the crowd.">
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<RFALSE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
	        <RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " looks and acts very important." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		        
<OBJECT PCROWD
	(DESC "throng")
	(FLAGS NODESC LIVING PERSON PLURAL TRANSPARENT)
	(SYNONYM THRONG CROWD PEOPLE)
      ; (ACTION PCROWD-F)>

"*** PRINCE ***"

<OBJECT PRINCE
	(LOC HORSE)
	(DESC "prince")
	(SDESC DESCRIBE-PRINCE)
	(FLAGS NODESC LIVING PERSON TRYTAKE NOALL TRANSPARENT)
	(SYNONYM PRINCE MAN GUY FELLOW RIDER ZZZP ZZZP ZZZP)
	(ADJECTIVE PRINCE\'S ZZZP)
	(CONTFCN PRINCE-F)
	(ACTION PRINCE-F)>

<ROUTINE DESCRIBE-PRINCE (OBJ)
	 <COND (<IS? .OBJ ,SLEEPING>
		<TELL "dead ">)>
	 <TELL 'PRINCE>
	 <RTRUE>>

<ROUTINE PRINCE-F ("OPT" (CONTEXT <>) "AUX" OBJ X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-CONT>
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
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<CONTEMPT>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "He's wearing " A ,HELM ,PERIOD>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<ZING>
		<RTRUE>)
	       (T
		<RFALSE>)>>
 	 
<ROUTINE CONTEMPT ()
	 <PCLEAR>
	 <TELL CTHEO
" silences you with a gesture of contempt." CR>
	 <RTRUE>>

<ROUTINE DEAD-PRINCE-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<NOUN-USED? ,W?HEAD>
		<COND (<NOT <IN? ,HORSE ,TRENCH>>
		       <SAY-SLAY>
		       <RFATAL>)>
		<TELL ,CANT "see it anymore." CR>
		<RFATAL>)>
	 <COND (<SET X <TOUCHING?>>
		<TELL "Ick! He's all bloody." CR>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<NOT-LIKELY>
		<PRINT " would respond.|">
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH>
		<TELL "His head is missing. Yuk." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SAY-SLAY ("AUX" X)
	 <TELL "As you ">
	 <COND (<SET X <SEEING?>>
		<TELL "peer into ">)
	       (<SET X <TOUCHING?>>
	        <TELL "reach towards ">)
	       (T
		<TELL "approach ">)>
	 <TELL THE ,TRENCH ", a ">
	 <SLAY-HORSE>
	 <RTRUE>>

<OBJECT KNIGHT
	(LOC BHORSE)
	(DESC "knight")
	(FLAGS LIVING PERSON TRANSPARENT)
	(SYNONYM KNIGHT MAN GUY FELLOW RIDER)
	(ACTION KNIGHT-F)>

<ROUTINE KNIGHT-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <BATTLE-MISS>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<CONTEMPT>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL 
"His regal bearing does not disguise his youth." CR> 
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<ZING>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
"*** HUNTERS ***"

<OBJECT HUNTERS
	(DESC "hunters")
	(FLAGS LIVING PERSON PLURAL TRANSPARENT)
	(SYNONYM HUNTERS HUNTER PEASANTS PEASANT PEOPLE MEN GUYS)
	(ADJECTIVE TRUFFLE)
	(GENERIC GENERIC-HUNTERS-F)
	(DESCFCN HUNTERS-F)
	(ACTION HUNTERS-F)>

<ROUTINE HUNTERS-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "Hunters are foraging under the distant trees.">
		<RTRUE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
	        <COND (<VERB? SHOW GIVE FEED>
		       <DISTANT-HUNTERS>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? YELL WAVE-AT>
		<TELL "A few of the distant " 'PRSO 
		      " glance up at you, then return to work." CR>
		<RTRUE>)
	       (<SET X <TALKING?>>
		<PCLEAR>
		<DISTANT-HUNTERS>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL CTHEO 
" trudge slowly among the oaks, peering at the ground." CR>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW>
		<TELL CTHEO " are running around in every "
		      'INTDIR ,PERIOD>
		<RTRUE>)
	       (<OR <VERB? LISTEN SMELL>
		    <SET X <TOUCHING?>>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DISTANT-HUNTERS ()
	 <TELL "None of " THE ,HUNTERS 
	       " respond. They're too far away to hear you." CR>
	 <RTRUE>>

<ROUTINE GENERIC-HUNTERS-F (TBL "OPT" (LEN 0))
	 <RETURN ,HUNTER>>
	 
"*** HUNTER ***"

<OBJECT HUNTER
	(DESC "hunter")
	(FLAGS LIVING PERSON TRANSPARENT)
	(SYNONYM HUNTER PEASANT BOY LAD MAN GUY FELLOW)
	(ADJECTIVE PEASANT TRUFFLE)
	(LIFE 0)
	(GENERIC GENERIC-HUNTERS-F)
	(DESCFCN HUNTER-F)
	(ACTION HUNTER-F)>

<ROUTINE HUNTER-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,HUNTER " is standing nearby.">
		       <RTRUE>)
		      (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<SET X <TOUCHING?>>
			      <HANDS-OFF-HUNTER>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? GIVE GET-FOR>
		       <GIVE-TO-HUNTER ,PRSO>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <SHOW-TO-HUNTER ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<PCLEAR>
		<TELL CTHE ,HUNTER 
" frowns. \"Wha' say ye? Ye got a funny way o' talkin', ">
		<COND (<IS? ,PLAYER ,FEMALE>
		       <TELL "ma'am.\"" CR>
		       <RFATAL>)>
		<TELL "mister.\"" CR>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO 
" is a lad of twelve or thirteen years, dressed in peasant garb. A burlap sack is slung over his narrow shoulders." CR>
		<RTRUE>)
	       (<VERB? KISS RAPE TOUCH>
		<HANDS-OFF-HUNTER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GIVE-TO-HUNTER (OBJ)
	 <COND (<GIVING-LOOT? .OBJ ,HUNTER>
		<RTRUE>)>
	 <TELL "\"No, thanks,\" says " THE ,HUNTER
	       ", shaking his head.\"" CR>
	 <RTRUE>>

<ROUTINE SHOW-TO-HUNTER (OBJ)
	 <TELL CTHE ,HUNTER ,GLANCES-AT THE .OBJ>
	 <COND (<EQUAL? .OBJ ,MINX>
		<TELL ,PERIOD>
		<HUNTER-SEES-MINX>
		<RTRUE>)>
	 <PRINT ", but says nothing.|">
	 <RTRUE>>

<ROUTINE HANDS-OFF-HUNTER ()
	 <TELL "\"Keep to yerself, ">
	 <MAAM-OR-MISTER>
	 <TELL "!\" cries " THE ,HUNTER ", drawing quickly away." CR>
	 <RTRUE>>

<ROUTINE MAAM-OR-MISTER ()
	 <COND (<IS? ,PLAYER ,FEMALE>
		<TELL "ma'am">
		<RTRUE>)>
	 <TELL "mister">
	 <RTRUE>>

"*** MINX! ***"

<OBJECT MINX
	(DESC "minx")
	(SDESC DESCRIBE-MINX)
	(FLAGS TRYTAKE NOALL LIVING PERSON TRANSPARENT FEMALE NAMEABLE)
	(LIFE 0)
	(SIZE 7)
	(SYNONYM MINX MINX ZZZP)
	(ADJECTIVE AWAKE ZZZP)
	(NAME-TABLE <ITABLE %<+ ,NAMES-LENGTH 1> (BYTE) 0>)
	(DESCFCN MINX-F)
	(ACTION MINX-F)>

<ROUTINE DESCRIBE-MINX (OBJ)
	 <COND (<IS? .OBJ ,NAMED>
		<PRINT-TABLE <GETP .OBJ ,P?NAME-TABLE>>
		<COND (<ZERO? ,INV-PRINTING?>
		       <RTRUE>)>
		<TELL ,STHE>)>
	 <PRINTD .OBJ>
	 <RTRUE>>		

<ROUTINE MINX-F ("OPT" (CONTEXT <>) "AUX" X)
	 <SETG P-IT-OBJECT ,MINX>
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<MAKE ,MINX ,SEEN>
		<TELL CA ,MINX>
		<COND (<SEE-ANYTHING-IN? ,MINX>
		       <TELL ,WITH>
		       <CONTENTS ,MINX>
		       <TELL " in its mouth">)>
		<TELL " is playing at your feet.">
		<RTRUE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<AND <IN? ,MINX ,OAK>
		     <T? ,HSCRIPT>
		     <SET X <TOUCHING?>>>
		<TELL "The thing behind " THE ,OAK
		      " shrinks out of reach." CR>
		<RTRUE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <HARMLESS ,PRSI>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <SHOW-TO-MINX>
		       <RTRUE>)
		      (<VERB? GIVE FEED>
		       <GIVE-TO-MINX>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (<VERB? TELL ASK-ABOUT ASK-FOR TELL-ABOUT>
		<PCLEAR>
		<TELL CTHEO>
		<COND (<PROB 50>
		       <TELL " looks at you incomprehendingly">)
		      (T
		       <TELL " gives you a blank look">)>
		<TELL ". \"Minx?\"" CR>
		<RFATAL>)
	       (<VERB? TOUCH>
		<MAKE ,MINX ,SEEN>
		<TELL CTHEO>
		<COND (<PROB 50>
		       <TELL " purrs">)
		      (T
		       <TELL " thumps her tail">)>
		<TELL " with pleasure. \"Minx.\"" CR>
		<RTRUE>)
	       (<SET X <HURTING?>>
		<HARMLESS>
		<RTRUE>)
	       (T
		<RFALSE>)>>
 	 
<ROUTINE GIVE-TO-MINX ("OPT" (OBJ ,PRSO))
	 <MAKE ,MINX ,SEEN>
	 <COND (<EQUAL? .OBJ ,TRUFFLE>
		<MINX-EATS-TRUFFLE>
		<RTRUE>)>
	 <WRINKLES .OBJ>
	 <RTRUE>>

<ROUTINE WRINKLES (OBJ)
	 <TELL CTHE ,MINX " sniffs " THE .OBJ
	       " and wrinkles her nose." CR>
	 <RTRUE>>

<ROUTINE SHOW-TO-MINX ("OPT" (OBJ ,PRSO))
	 <MAKE ,MINX ,SEEN>
	 <COND (<EQUAL? .OBJ ,TRUFFLE>
		<TELL CTHE ,MINX " eagerly thumps her tail. \"Minx!\"" CR>
		<RTRUE>)>
	 <WRINKLES .OBJ>
	 <RTRUE>>

<ROUTINE MINX-EATS-TRUFFLE ()
	 <WINDOW ,SHOWING-ALL>
	 <REMOVE ,TRUFFLE>
	 <MAKE ,MINX ,SEEN>
	 <SETG P-IT-OBJECT ,MINX>
	 <SETG P-HER-OBJECT ,MINX>
	 <TELL CTHE ,MINX>
	 <COND (<NOT <IS? ,TRUFFLE ,SEEN>>
		<MAKE ,TRUFFLE ,SEEN>
		<TELL " looks up at you as she sniffs the " B ,W?TRUFFLE
". \"Minx?\" she mews, thumping her tail imploringly. When you don't object, she">)>
	 <TELL 
" pops the delicacy into her mouth, licks her paws clean and purrs with contentment." CR>
	 <RTRUE>>


<ROUTINE KILL-MINX ()
	 <UNMAKE ,MINX ,LIVING>
	 <DEQUEUE ,I-MINX>
	 <PUTP ,MINX ,P?ACTION ,DEAD-MINX-F>
	 <REPLACE-ADJ? ,MINX ,W?AWAKE ,W?DEAD>
	 <REPLACE-ADJ? ,MINX ,W?SLEEPING ,W?DEAD>
	 <RFALSE>>

<ROUTINE DEAD-MINX-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <TELL CA ,MINX " lies nearby.">
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<TELL CTHE ,MINX>
		<PRINT " doesn't seem to hear you.|">
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL CTHE ,MINX " is still as death." CR>
		<RTRUE>)
	       (<SET X <HURTING?>>
		<TELL "You're lucky your compassion didn't go down." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** MAYOR ***"

<OBJECT MAYOR
	(DESC "Mayor")
	(FLAGS LIVING PERSON TRANSPARENT)
	(LIFE 0)
	(SYNONYM MAYOR GROPE MIDGET DWARF MUNCHKIN MAN GUY FELLOW)
	(ADJECTIVE LITTLE SMALL MAYOR)
	(GENERIC GENERIC-MUNCHKIN-F)
	(DESCFCN MAYOR-F)
	(ACTION MAYOR-F)>

<ROUTINE MAYOR-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CTHE ,MAYOR " of " 'FROON ,SIS>
		<COND (<SET X <FIRST? ,MAYOR>>
		       <TELL "standing next to you, holding ">
		       <CONTENTS ,MAYOR>)
		      (T
		       <TELL "grovelling at your feet">)>
		<TELL ". A joyous " 'FCROWD
		      " is gathered around him.">
		<RTRUE>)
	       (<INSULTED? ,MAYOR>
		<RFATAL>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<AND <VERB? HELLO>
			    <PRSO? ROOMS MAYOR>>
		       <GREET-MAYOR>
		       <RTRUE>)
		      (<AND <VERB? GOODBYE>
			    <PRSO? ROOMS MAYOR>>
		       <BYE-MAYOR>
		       <RTRUE>)
		      (<AND <VERB? TELL-ABOUT SSHOW>
			    <PRSO? ME>>
		       <ASK-MAYOR-ABOUT ,PRSI>
		       <RFATAL>)
		      (<OR <VERB? EXAMINE WHAT WHO WHERE>
			   <AND <VERB? SHOW>
				<PRSI? ME>>>
		       <ASK-MAYOR-ABOUT ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? GIVE GET-FOR>
			    <PRSI? ME>>
		       <ASK-MAYOR-FOR ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? SGIVE SGET-FOR>
			    <PRSO? ME>>
		       <ASK-MAYOR-FOR ,PRSI>
		       <RFATAL>)>
		<TELL CTHE ,MAYOR " sighs." CR>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? GIVE GET-FOR>
		       <GIVE-TO-MAYOR ,PRSO>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <SHOW-TO-MAYOR ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? HELLO WAVE-AT>
		<GREET-MAYOR>
		<RTRUE>)
	       (<VERB? GOODBYE>
		<BYE-MAYOR>
		<RTRUE>)
	       (<VERB? ASK-FOR>
		<ASK-MAYOR-FOR ,PRSI>
		<RTRUE>)
	       (<VERB? ASK-ABOUT>
		<ASK-MAYOR-ABOUT ,PRSI>
		<RTRUE>)
	       (<VERB? TELL-ABOUT>
		<SHOW-TO-MAYOR ,PRSI>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE BYE-MAYOR ()
	 <TELL
"\"Wait! Don't go yet,\" pleads " THE ,MAYOR ", holding you back." CR>
	 <RTRUE>>

<ROUTINE GREET-MAYOR ()
	 <TELL "\"Greetings, O noble one.\"" CR>
	 <RTRUE>>

<CONSTANT MAYOR-TABLE
	<PLTABLE
	 <PTABLE MAYOR "My predecessor died suddenly">
	 <PTABLE FROON "Froon! A beautiful land, honorable to serve">
	 <PTABLE KEY1 "Ah, yes. Such a delicate shade of puce">
	 <PTABLE KEY2 "Mmm. Lovely mauve highlights">
	 <PTABLE KEY3 "Lavender! One of my favorite colors">>>

<ROUTINE ASK-MAYOR-ABOUT (OBJ "AUX" TBL LEN X)
	 <SEE-CHARACTER ,MAYOR>
	 <COND (<NOT <VISIBLE? .OBJ>>
		<PERPLEXED ,MAYOR>
		<TELL "I'm uncertain as to">
		<WHO-WHAT .OBJ>
		<TELL "you are referring.\"" CR>
		<RTRUE>)>
	 <SET LEN <GET ,MAYOR-TABLE 0>>
	 <REPEAT ()
		 <SET TBL <GET ,MAYOR-TABLE .LEN>>
		 <SET X <GET .TBL 0>>
		 <COND (<EQUAL? <GET .TBL 0> .OBJ>
			<PRINTC %<ASCII !\">>
			<TELL <GET .TBL 1> ,PERQ>
			<RTRUE>)
		       (<DLESS? LEN 1>
			<RETURN>)>>
	 <TELL CTHE ,MAYOR " looks at " THE ,GROUND " sheepishly">
	 <ALAS>
	 <TELL "I possess but little knowledge of ">
	 <PRONOUN .OBJ>
	 <TELL ,PERQ>
	 <RTRUE>>
		
<ROUTINE ALAS ()
	 <TELL ". \"Alas, ">
	 <HONORED-ONE>
	 <TELL ". ">
	 <RTRUE>>

<ROUTINE ASK-MAYOR-FOR (OBJ "AUX" X L)
	 <SET L <LOC .OBJ>>
	 <COND (<NOT <EQUAL? .L ,MAYOR>>
		<COND (<VISIBLE? .OBJ>
		       <TELL "\"I notice ">
		       <COND (<IS? .OBJ ,PLURAL>
			      <TELL B ,W?SOME>)
			     (T
			      <TELL B ,W?ONE>)>
		       <TELL " there ">
		       <SAY-WHERE .L>
		       <TELL ",\" remarks " THE ,MAYOR ,PERIOD>
		       <RTRUE>)>
		<MAYOR-SORRY>
		<TELL "have none to offer at the moment.\"" CR>
		<RTRUE>)
	       (<EQUAL? .OBJ ,KEY1 ,KEY2 ,KEY3>
		<AWARD-KEY .OBJ>
		<RTRUE>)>
	 <MAYOR-SORRY>
	 <TELL "cannot give you ">
	 <PRONOUN .OBJ>
	 <TELL ,PERQ>
	 <RTRUE>>

<ROUTINE MAYOR-SORRY ()
	 <TELL "\"My apologies, ">
	 <HONORED-ONE>
	 <TELL ",\" mumbles " THE ,MAYOR>
	 <COND (<PROB 50>
		<TELL ", hanging his head">)>
	 <TELL ". \"I ">
	 <RTRUE>>

<ROUTINE GIVE-TO-MAYOR (OBJ)
	 <COND (<GIVING-LOOT? .OBJ ,MAYOR>
		<RTRUE>)>
	 <NO-THANKS ,MAYOR>
	 <RTRUE>>

<ROUTINE HONORED-ONE ()
	 <TELL "Honored ">
	 <COND (<IS? ,PLAYER ,FEMALE>
		<TELL "Ma'am">
		<RTRUE>)>
	 <TELL "Sir">
	 <RTRUE>>

<ROUTINE SHOW-TO-MAYOR (OBJ)
	 <TELL CTHE ,MAYOR>
	 <COND (<NOT <VISIBLE? .OBJ>>
		<TELL " looks confused. \"What do you mean?\"" CR>
		<RTRUE>)>
	 <TELL ,GLANCES-AT THE .OBJ
	       ", but shows only polite interest." CR>
	 <RTRUE>>

<OBJECT LADY
	(DESC "little lady")
	(FLAGS LIVING PERSON FEMALE TRANSPARENT)
	(SYNONYM LADY MIDGET MUNCHKIN WOMAN GIRL)
	(ADJECTIVE LITTLE SMALL TINY MIDGET MUNCHKIN)
	(LIFE 0)
	(GENERIC GENERIC-MUNCHKIN-F)
	(DESCFCN LADY-F)
	(ACTION LADY-F)>

<ROUTINE LADY-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA ,LADY " is standing near " THE ,FARMHOUSE C ,PER>
		<RTRUE>)
	       (<IN? ,FCROWD ,HERE>
		<TELL CTHE ,LADY " is lost in " THE ,FCROWD ,PERIOD>
		<RFATAL>)
	       (<INSULTED? ,LADY>
		<RFATAL>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<AND <VERB? HELLO>
			    <PRSO? ROOMS LADY>>
		       <GREET-LADY>
		       <RFATAL>)>
		<SHY-LADY>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? GIVE GET-FOR SHOW>
		       <SHOW-TO-LADY ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? TELL>
		<RFALSE>)
	       (<VERB? ASK-FOR ASK-ABOUT>
		<SHY-LADY>
		<RTRUE>)
	       (<VERB? TELL-ABOUT>
		<SHOW-TO-LADY ,PRSI>
		<RTRUE>)
	       (<VERB? HELLO WAVE-AT>
		<GREET-LADY>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL 
"Her bright, colorful garb blends in with the flowers." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SHOW-TO-LADY (OBJ)
	 <COND (<NOT <VISIBLE? .OBJ>>
		<SHY-LADY>
		<RTRUE>)>
	 <TELL CTHE ,LADY ,GLANCES-AT THE .OBJ
	       ", blushes, and says nothing." CR>
	 <RTRUE>>

<ROUTINE SHY-LADY ()
	 <TELL CTHE ,LADY " blushes. She's too shy to respond." CR>
	 <RTRUE>>

<ROUTINE GREET-LADY ()
	 <TELL CTHE ,LADY " nods at you shyly." CR>
	 <RTRUE>>

<OBJECT FCROWD
	(DESC "crowd")
	(FLAGS LIVING PERSON TRANSPARENT)
	(SYNONYM CROWD PEOPLE MUNCHKINS MUNCHKIN GATHERING)
	(ADJECTIVE MUNCHKIN LITTLE)
	(GENERIC GENERIC-MUNCHKIN-F)
	(DESCFCN FCROWD-F)
	(ACTION FCROWD-F)>

<ROUTINE FCROWD-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A joyous " 'FCROWD 
" of little people is standing all around you.">
		<RTRUE>)
	       (<INSULTED? ,FCROWD>
		<RFATAL>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<AND <VERB? HELLO>
			    <PRSO? ROOMS FCROWD>>
		       <CROWD-GREET>
		       <RFATAL>)>
		<LOUD-CROWD>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? GIVE GET-FOR SHOW>
		       <TELL "No one in " THEI
			     " shows any interest." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? TELL>
		<RFALSE>)
	       (<VERB? HELLO WAVE-AT>
		<CROWD-GREET>
		<RTRUE>)
	       (<VERB? ASK-FOR ASK-ABOUT TELL-ABOUT>
		<LOUD-CROWD>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<ROUTINE CROWD-GREET ()
	 <TELL CTHE ,FCROWD " waves and cheers." CR>
	 <RTRUE>>

<ROUTINE LOUD-CROWD ()
	 <TELL CTHE ,FCROWD
" is cheering too loudly to hear you." CR>
	 <RTRUE>>

<ROUTINE INSULTED? (OBJ)
	 <COND (<OR <NOUN-USED? ,W?MUNCHKIN ,W?MUNCHKINS>
		    <ADJ-USED? ,W?MUNCHKIN>>
		<TELL CTHE .OBJ " covers ">
		<HAND-PRONOUN .OBJ>
		<TELL " ears with ">
		<HAND-PRONOUN .OBJ>
		<TELL " hands. \"Don't call ">
	 	<COND (<EQUAL? .OBJ ,FCROWD>
		       <TELL B ,W?US>)
	       	      (T
		       <TELL B ,W?ME>)>
		<TELL " that!\"" CR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE HAND-PRONOUN (OBJ)
	 <COND (<EQUAL? .OBJ ,FCROWD>
		<TELL "their">
		<RTRUE>)
	       (<EQUAL? .OBJ ,MAYOR>
		<TELL "his">
		<RTRUE>)>
	 <TELL "her">
	 <RTRUE>>

<ROUTINE GENERIC-MUNCHKIN-F (TBL "OPT" (LEN <GET .TBL 0>))
	 <COND (<IN? ,MAYOR ,HERE>
		<RETURN ,MAYOR>)>
	 <RETURN ,FCROWD>>
	       		
"*** IMPLEMENTORS ***"

<OBJECT IMPS
	(DESC "Implementors")
	(FLAGS LIVING PERSON PLURAL TRANSPARENT)
	(SYNONYM IMPLEMENTORS IMPS IMP PEOPLE MEN GROUP)
	(LIFE I-IMPS)
	(DESCFCN IMPS-F)
	(CONTFCN IMPS-F)
	(ACTION IMPS-F)>

<ROUTINE IMPS-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL
"A group of Implementors is seated around a food-laden table">
		<COND (<IN? ,COCO ,IMPS>
		       <TELL ", playing catch with a coconut.">
		       <RTRUE>)
		      (<IN? ,GOBLET ,IMPS>
		       <TELL ". One of them is holding out a ">
		       <PRINT "goblet for you to take.|">
		       <RTRUE>)>
		<TELL ", glaring at you angrily."> 
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-CONT>
		<COND (<EQUAL? ,GOBLET ,PRSO ,PRSI>
		       <RFALSE>)
		      (<SET X <TOUCHING?>>
		       <TELL CTHE ,IMPS " won't let you near." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<PCLEAR>
		<TELL 
"\"I think I just heard something insignificant,\" remarks an Implementor"
,PTAB "\"How dull,\" replies another, stifling a yawn." CR>
		<RFATAL>)
	       (<VERB? EXAMINE WHAT WHO WHERE>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<OBJECT CONGREG
	(LOC IN-CHAPEL)
	(DESC "congregation")
	(FLAGS LIVING PERSON NODESC TRANSPARENT)
	(SYNONYM CONGREGATION CROWD PEOPLE FOLKS)
	(ACTION CONGREG-F)>

<ROUTINE CONGREG-F ("OPT" (CONTEXT <>))
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "Their heads are bowed in fervent prayer." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CLERIC
	(LOC IN-CHAPEL)
	(DESC "Cardinal Toolbox")
	(FLAGS NODESC NOARTICLE PERSON TRANSPARENT ; LIVING)
	(SYNONYM TOOLBOX CARDINAL CLERIC PRIEST MAN FELLOW GUY SIR)
	(ADJECTIVE CARDINAL)
	(LIFE I-CLERIC)
	(DESCFCN CLERIC-F)
	(CONTFCN CLERIC-F)
	(ACTION CLERIC-F)>

<ROUTINE CLERIC-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CTHE ,CLERIC 
" is here, surrounded by a grateful crowd of villagers. He's holding ">
		<CONTENTS ,CLERIC>
		<TELL C ,PER>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-CONT>
		<COND (<SET X <TOUCHING?>>
		       <NOT-SO-FAST ,CLERIC>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<AND <VERB? HELLO>
			    <PRSO? ROOMS CLERIC>>
		       <GREET-CLERIC>
		       <RFATAL>)
		      (<AND <VERB? TELL-ABOUT SSHOW>
			    <PRSO? ME>>
		       <ASK-CLERIC-ABOUT ,PRSI>
		       <RFATAL>)
		      (<OR <VERB? EXAMINE WHAT WHO WHERE>
			   <AND <VERB? SHOW>
				<PRSI? ME>>>
		       <ASK-CLERIC-ABOUT ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? GIVE GET-FOR>
			    <PRSI? ME>>
		       <ASK-CLERIC-FOR ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? SGIVE SGET-FOR>
			    <PRSO? ME>>
		       <ASK-CLERIC-FOR ,PRSI>
		       <RFATAL>)>
		<TELL "\"Your accent is strange. I don't understand.\"" CR>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <HARMLESS ,PRSI>
		       <RTRUE>)
		      (<VERB? GIVE GET-FOR>
		       <GIVE-TO-CLERIC ,PRSO>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <DO-GLANCE ,CLERIC ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? TELL>
		<COND (<T? ,P-CONT>
		       <RFALSE>)>
		<NO-RESPONSE>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "He">
		<COND (<SEE-ANYTHING-IN?>
		       <TELL "'s holding ">
		       <CONTENTS>
		       <TELL ", and">)>
		<TELL " looks as if he hasn't slept for days." CR>
		<RTRUE>)
	       (<VERB? ASK-FOR>
		<ASK-CLERIC-FOR ,PRSI>
		<RTRUE>)
	       (<VERB? ASK-ABOUT>
		<ASK-CLERIC-ABOUT ,PRSI>
		<RTRUE>)
	       (<VERB? TELL-ABOUT>
		<DO-GLANCE ,CLERIC ,PRSI>
		<RTRUE>)
	       (<VERB? HELLO WAVE-AT>
		<GREET-CLERIC>
		<RTRUE>)
	       (<SET X <HURTING?>>
		<HARMLESS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GREET-CLERIC ()
	 <TELL CTHE ,CLERIC " bows deeply." CR>
	 <RTRUE>>

<CONSTANT CLERIC-TABLE
	<PLTABLE
	 <PTABLE CLERIC "I preside over this humble diocese">
	 <PTABLE ORKAN "He disappeared a few weeks ago without trace">
	 <PTABLE THRIFF "I preside over this humble diocese">
	 <PTABLE XTREES "Woe is us! Woe">>>

<ROUTINE ASK-CLERIC-ABOUT (OBJ "AUX" TBL LEN X)
	 <COND (<WHAT-TALK? ,CLERIC .OBJ>
		<RTRUE>)>
	 <SET LEN <GET ,CLERIC-TABLE 0>>
	 <REPEAT ()
	    <SET TBL <GET ,CLERIC-TABLE .LEN>>
	    <SET X <GET .TBL 0>>
	    <COND (<EQUAL? <GET .TBL 0> .OBJ>
		   <PRINTC %<ASCII !\">>
		   <TELL <GET .TBL 1> ,PERQ>
		   <RTRUE>)
		  (<DLESS? LEN 1>
		   <RETURN>)>>
	 <TELL CTHE ,CLERIC " shrugs. \"I claim little knowledge of ">
	 <PRONOUN .OBJ>
	 <TELL ,PERQ>
	 <RTRUE>>

<ROUTINE ASK-CLERIC-FOR (OBJ)
	 <MAKE ,CLERIC ,SEEN>
	 <COND (<AND <EQUAL? .OBJ ,RELIQUARY>
		     <IN? .OBJ ,CLERIC>>
		<GET-RELIQUARY>
		<RTRUE>)>
	 <TELL CTHE ,CLERIC 
" searches the pockets of his robes. \"Alas. I have none to offer.\"" CR>
	 <RTRUE>>

<ROUTINE GET-RELIQUARY ()
	 <EXIT-CLERIC>
	 <MOVE ,RELIQUARY ,PLAYER>
	 <TELL CTHE ,CLERIC
	       " grudgingly surrenders " THE ,RELIQUARY " and">
	 <PRINT " disappears into the ">
	 <TELL "crowd, which soon wanders away." CR>
	 <RTRUE>>

<ROUTINE GIVE-TO-CLERIC (OBJ)
	 <MAKE ,CLERIC ,SEEN>
	 <COND (<GIVING-LOOT? .OBJ ,CLERIC>
		<RTRUE>)>
	 <NO-THANKS ,CLERIC>
	 <RTRUE>>

"*** ORKAN ***"

<OBJECT MSTAR
	(LOC GLOBAL-OBJECTS)
	(DESC "Morningstar")
	(FLAGS NORARTICLE NODESC FEMALE)
	(SYNONYM MORNINGSTAR MORNING\-STAR PRINCESS)
	(ADJECTIVE PRINCESS)
	(ACTION MISSING-F)>

<OBJECT ORKAN
	(LOC GLOBAL-OBJECTS)
	(DESC "Orkan")
	(FLAGS NOARTICLE NODESC VOWEL)
	(SYNONYM ORKAN)
	(ACTION MISSING-F)>

<ROUTINE MISSING-F ("AUX" OBJ)
	 <SET OBJ ,PRSO>
	 <COND (<ZERO? ,PRSI>)
	       (<THIS-PRSI?>
		<SET OBJ ,PRSI>)>
	 <PCLEAR>
	 <TELL "Alas. " CTHE .OBJ " isn't here" ,AT-MOMENT>
	 <RFATAL>>

"*** QUEEN ***"

<OBJECT QUEEN
	(DESC "platypus")
	(SDESC DESCRIBE-QUEEN)
	(FLAGS NODESC LIVING PERSON FEMALE TRANSPARENT)
	(LIFE I-QUEEN)
	(SYNONYM PLATYPUS CREATURE QUEEN LADY WOMAN HIGHNESS ALEXIS)
	(ADJECTIVE YOUR FURRY)
	(DESCFCN QUEEN-F)
	(CONTFCN QUEEN-F)
	(ACTION QUEEN-F)>

<ROUTINE DESCRIBE-QUEEN (OBJ)
	 <TELL "furry " B ,W?CREATURE>
	 <RTRUE>>

<ROUTINE QUEEN-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA ,QUEEN " is preening herself nearby">
		<COND (<SEE-ANYTHING-IN? ,QUEEN>
		       <TELL ". She's clutching ">
		       <CONTENTS ,QUEEN>
		       <TELL " in her paw">)>
		<TELL C ,PER>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-CONT>
		<COND (<SET X <TOUCHING?>>
		       <QUEEN-SEES-YOU>
		       <RTRUE>)>
		<RFALSE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<AND <NOUN-USED? ,W?PLATYPUS ,W?ALEXIS>
		     <GETP ,QUEEN ,P?SDESC>
		     <NOT <IS? ,QUEEN ,IDENTIFIED>>>
		<MAKE ,QUEEN ,IDENTIFIED>
		<TELL "[Good guess." ,BRACKET>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE SHOW FEED>
		       <APPROACH-QUEEN>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? HIT MUNG WALK-TO WAVE-AT FOLLOW RAPE UNDRESS>
		<QUEEN-SEES-YOU>
		<RTRUE>)
	       (<SET X <TALKING?>>
		<APPROACH-QUEEN "at the sound of your voice">
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL "Her red gown is a bit too snug">
		<COND (<SEE-ANYTHING-IN?>
		       <TELL ". She's holding ">
		       <CONTENTS>
		       <TELL " in one of her paws">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE APPROACH-QUEEN ("OPT" (STR <>))
	 <COND (<NOT <IS? ,QUEEN ,TOUCHED>>
		<MAKE ,QUEEN ,TOUCHED>
		<MAKE ,QUEEN ,SEEN>
		<TELL CTHE ,QUEEN
" glances around her garden, listening intently. Anxious moments pass; then, hearing nothing further, she turns her back with a shrug." CR>
		<RTRUE>)>
	 <QUEEN-SEES-YOU .STR>
	 <RTRUE>>
		
<ROUTINE QUEEN-SEES-YOU ("OPT" (STR <>))
	 <TELL CTHE ,QUEEN " wheels around ">
	 <COND (<T? .STR>
		<TELL .STR>)
	       (T
		<TELL "as you step into view">)>
	 <TELL 
". \"A spy!\" she cries, blowing a shrill note on her whistle.|
  Before you can think or move, twenty-seven heavily armed platypus guards materialize around you. After suffering exquisite torture at the skilled hands of the Queen, you're led away to twenty years of backbreaking labor in the granola mines of Antharia">
	 <JIGS-UP>
	 <RTRUE>>

<OBJECT CONDUCTOR
	(LOC GONDOLA)
	(DESC "conductor")
	(FLAGS LIVING PERSON NODESC TRANSPARENT)
	(SYNONYM CONDUCTOR MAN GUY FELLOW)
	(ADJECTIVE GONDOLA)
	(ACTION CONDUCTOR-F)>

<ROUTINE CONDUCTOR-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <TELL "Passengers block your target." CR>
		       <RTRUE>)
		      (<VERB? GIVE SHOW FEED>
		       <CONDUCTOR-BUSY>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<PCLEAR>
		<CONDUCTOR-BUSY>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL "His face is sallow with boredom." CR>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<TELL "A crowd of " 'PASSENGERS
		      " bars your approach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CONDUCTOR-BUSY ()
	 <TELL CTHE ,CONDUCTOR " is too busy ">
	 <COND (<HERE? AT-DOCK>
		<TELL "herding " 'PASSENGERS>)
	       (T
		<TELL "with his monologue">)>
	 <PRINT " to pay you much heed.|">
	 <RTRUE>>

<OBJECT PASSENGERS
	(LOC GONDOLA)
	(DESC "passengers")
	(FLAGS PLURAL NODESC PERSON LIVING TRANSPARENT)
	(SYNONYM PASSENGER PEOPLE CROWD RIDERS)
	(ACTION PASSENGERS-F)>

<ROUTINE PASSENGERS-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <TELL "You might hurt somebody." CR>
		       <RTRUE>)
		      (<VERB? GIVE SHOW FEED>
		       <PASSENGERS-BUSY>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<PCLEAR>
		<PASSENGERS-BUSY>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL "A suspicious passenger returns your stare." CR>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<TELL 
"Suspicious " 'PASSENGERS " edge away from your approach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PASSENGERS-BUSY ()
	 <TELL CTHE ,PASSENGERS " are too busy ">
	 <COND (<HERE? AT-DOCK>
		<TELL "crowding around " THE ,GONDOLA>)
	       (T
		<TELL "gawking at the scenery">)>
	 <PRINT " to pay you much heed.|">
	 <RTRUE>>


		


		       
		
			     