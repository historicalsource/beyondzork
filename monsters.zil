"MONSTERS for BEYOND ZORK:
 Copyright (C)1987 Infocom, Inc. All Rights Reserved."

"*** DISCIPLINE CRAB ***"

<OBJECT CRAB
	(LOC THRONE-ROOM)
	(LAST-LOC THRONE-ROOM)
	(DESC "discipline crab")
	(FLAGS TRYTAKE LIVING SURFACE SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM CRAB MONSTER SOMETHING THING)
	(ADJECTIVE KING DISCIPLINE AWAKE)
	(LIFE I-CRAB)
	(ENDURANCE 7)
	(EMAX 7)
	(STRENGTH 7)
	(DEXTERITY 60)
	(VALUE 5)
	(HABITAT CELLAR-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(CONTFCN CRAB-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "skulking in the corner")
	(ACTION CRAB-F)>

<ROUTINE CRAB-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<SET X <TOUCHING?>>
			      <TELL CTHE ,CRAB 
				    " snaps at your fingers. Yow!" CR>
			      <RTRUE>)>)>
		<RFALSE>)
	       (<AND <NOT <VERB? HIT MUNG>>
		     <SET X <TOUCHING?>>>
		<SHY-CRAB>
	        <RTRUE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)
		      (<VERB? PUT-ON EMPTY-INTO>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO
" adjusts the crown on its head, and glares at you defiantly. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE SHY-CRAB ()
	 <TELL CTHE ,CRAB " sidesteps out of your reach." CR>
	 <RTRUE>>

"*** RATS ***"

<OBJECT RAT
	(LOC WC1)
	(LAST-LOC WC1)
	(DESC "rat-ant")
	(FLAGS MONSTER LIVING SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM RAT\-ANT RAT ANT MONSTER SOMETHING THING)
	(ADJECTIVE RAT AWAKE)
	(LIFE I-RAT)
	(ENDURANCE 6)
	(EMAX 6)
	(STRENGTH 6)
	(DEXTERITY 60)
	(VALUE 5)
	(HABITAT CELLAR-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "scuttling across the dirt")
	(ACTION RAT-F)>

<ROUTINE RAT-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " glares back at you, snarling. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** SKELETON ***"

<OBJECT SKELETON
	(LOC SKEL-ROOM)
	(DESC "skeleton")
	(SDESC 0)
	(FLAGS TRYTAKE NOALL SURFACE)
	(CAPACITY 10)
	(VALUE 3)
	(SYNONYM SKELETON BONES BONE BODY CORPSE NECK MONSTER)
	(ADJECTIVE SKELETON)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN SKELETON-F)
	(ACTION SKELETON-F)>

"SEEN = not yet fought."

<ROUTINE DESCRIBE-HEAP (OBJ)
	 <TELL "heap of bones">
	 <RTRUE>>

<ROUTINE SKELETON-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA ,SKELETON>
		<COND (<T? ,CHOKE>
		       <TELL " is clutching your throat.">)
		      (T
		       <PRINT " lies at your feet.">
		       <COND (<NOT <IS? ,AMULET ,TOUCHED>>
			      <MAKE ,AMULET ,NODESC>)>
		       <COND (<SEE-ANYTHING-IN? ,SKELETON>
			      <TELL " On it you see ">
			      <CONTENTS ,SKELETON>
			      <TELL C ,PER>)>
		       <UNMAKE ,AMULET ,NODESC>)>
		<COND (<NOT <IS? ,AMULET ,TOUCHED>>
		       <TELL " An amulet dangles from its neck.">)>
		<RTRUE>)
	       (<STRANGLE? ,SKELETON>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? TAKE KICK HIT SHAKE MOVE PUSH PULL ADJUST>
		<COND (<IS? ,PRSO ,MUNGED>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<WINDOW ,SHOWING-ROOM>
		<MAKE ,PRSO ,MUNGED>
		<MAKE ,PRSO ,SEEN>
		<PUTP ,PRSO ,P?SDESC ,DESCRIBE-HEAP>
		<MAKE ,AMULET ,TOUCHED>
		<REPLACE-SYN? ,PRSO ,W?BODY ,W?PILE>
		<REPLACE-SYN? ,PRSO ,W?CORPSE ,W?HEAP>
		<REPLACE-SYN? ,PRSO ,W?NECK ,W?ZZZP>
		<REPLACE-ADJ? ,PRSO ,W?SKELETON ,W?ZZZP>
		<TELL "With a sigh of exhaustion, " THEO>
		<COND (<T? ,CHOKE>
		       <SETG CHOKE 0>
		       <DEQUEUE ,I-STRANGLE>
		       <TELL " releases its strangle hold and">)>
		<TELL " crumbles into a useless " D ,PRSO ,PERIOD>		
		<UPDATE-STAT <GETP ,SKELETON ,P?VALUE> ,EXPERIENCE>
		<RTRUE>)
	       (<VERB? LOOK-ON LOOK-INSIDE SEARCH LOOK-UNDER DIG DIG-UNDER>
		<TELL "You find ">
		<COND (<NOT <IS? ,AMULET ,TOUCHED>>
		       <MAKE ,AMULET ,NODESC>)>
		<CONTENTS>
		<UNMAKE ,AMULET ,NODESC>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? EXAMINE LOOK-ON>
		     <NOT <IS? ,PRSO ,MUNGED>>>
		<TELL "It grins at you horribly. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** GUTTER SNIPES ***"

<OBJECT SNIPE
	(LAST-LOC 0)
	(DESC "guttersnipe")
	(FLAGS MONSTER LIVING SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM SNIPE GUTTERSNIPE BIRD MONSTER)
	(ADJECTIVE GUTTER AWAKE)
	(LIFE I-SNIPE)
	(ENDURANCE 12)
	(EMAX 12)
	(STRENGTH 10)
	(DEXTERITY 70)
	(VALUE 7)
	(HABITAT MOOR-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "lurking among the reeds")
	(ACTION SNIPE-F)>

<ROUTINE SNIPE-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO 
"'s beak is almost a foot long, and sharp as a needle. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** ELDRITCH VAPORS ***"

<OBJECT VAPOR 
	(LOC IN-GAS)
	(LAST-LOC IN-GAS)
	(DESC "eldritch vapor")
	(FLAGS VOWEL LIVING MONSTER SURPRISED)
	(SYNONYM VAPORS VAPOR MONSTER)
	(ADJECTIVE ELDRITCH AWAKE)
	(LIFE I-VAPOR)
	(ENDURANCE 6)
	(EMAX 6)
	(STRENGTH 5)
	(DEXTERITY 70)
	(VALUE 9)
	(HABITAT MOOR-ROOMS)
        (GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "wafting amid the reeds")
	(ACTION VAPOR-F)>
	 
<ROUTINE VAPOR-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<PCLEAR>
		<TELL CTHEO " murmurs vaguely in response." CR>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<DIAGNOSE-MONSTER>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <MAKE ,PRSO ,TOUCHED>
		       <TELL ,TAB>
		       <REFER-TO-PACKAGE>)>
		<RTRUE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>
	       
"*** SPIDERS ***"

<OBJECT SPIDER
	(LOC LEVEL1B)
	(LAST-LOC LEVEL1B)
	(DESC "giant spider")
	(FLAGS NODESC MONSTER LIVING SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM SPIDER INSECT MANDIBLE MANDIBLES MONSTER)
	(ADJECTIVE GIANT BIG LARGE AWAKE)
	(LIFE I-SPIDER)
	(ENDURANCE 10)
	(EMAX 10)
	(STRENGTH 10)
	(DEXTERITY 80)
	(VALUE 7)
	(HABITAT TOWER1-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "lurking in the shadows")
	(ACTION SPIDER-F)>

<ROUTINE SPIDER-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " looks alarmingly well-fed. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** SLUGS ***"

<OBJECT SLUG
	(LOC LEVEL2B)
	(LAST-LOC LEVEL2B)
	(DESC "slug")
	(FLAGS NODESC MONSTER LIVING SURFACE SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM SLUG INSECT MONSTER)
	(ADJECTIVE AWAKE)
	(LIFE I-SLUG)
	(ENDURANCE 11)
	(EMAX 11)
	(STRENGTH 10)
	(DEXTERITY 60)
	(VALUE 7)
	(HABITAT TOWER2-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "squishing across the debris")
	(ACTION SLUG-F)>

<ROUTINE SLUG-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER PUT-ON PUT TOUCH-TO>
		       <TOUCH-SLUG-WITH ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " is about as long as you are tall. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TOUCH-SLUG-WITH (OBJ)
	 <ITALICIZE "Splat">
	 <TELL "! ">
	 <COND (<NOT <EQUAL? .OBJ ,CUBE>>
		<WINDOW ,SHOWING-ALL>
		<MOVE .OBJ ,HERE>
		<TELL CTHE .OBJ " slips off " THE ,SLUG
		      "'s oozing body with no effect." CR>
		<RTRUE>)>
	 <REMOVE ,CUBE>
	 <VANISH ,SLUG>
	 <TELL CTHE ,SLUG " emits a shriek of agony as " THE .OBJ 
" slides across its body. You leap out of its path of retreat, and listen as its repulsive squeals ">
	 <PRINT "fade into the distance.|">
	 <KILL-MONSTER ,SLUG>
	 <RTRUE>>
		       
"*** DUST BUNNIES ***"

<OBJECT DUST
	(LOC LEVEL3B)
	(LAST-LOC LEVEL3B)
	(DESC "dust bunnies")
	(SDESC DESCRIBE-DUST)
	(FLAGS MONSTER LIVING)
	(SYNONYM BUNNIES BUNNY DUST BUNCH GROUP MONSTER MONSTERS)
	(ADJECTIVE DUST AWAKE)
	(LIFE I-DUST)
      ; (ENDURANCE 0)
      ; (EMAX 0)
      ; (STRENGTH 0)
      ; (DEXTERITY 0)
        (VALUE 10)
	(HABITAT TOWER3-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN DUST-F)
	(ACTION DUST-F)>	

<ROUTINE DESCRIBE-DUST (OBJ)
	 <TELL "dust bunny">
	 <RTRUE>>

<CONSTANT BMAX 10946>
<GLOBAL OBUNNIES:NUMBER 1>
<GLOBAL BUNNIES:NUMBER 1>

<ROUTINE DUST-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<COND (<L? ,BUNNIES 5>
		       <TELL ,XA>
		       <COND (<EQUAL? ,BUNNIES 1>
			      <TELL "dust bunny is ">)
			     (T
			      <COND (<EQUAL? ,BUNNIES 2>
				     <TELL "pair">)
				    (T
				     <TELL "trio">)>
			      <TELL " of " 'DUST " are ">)>
		       <TELL "lurking in " THE ,GCORNER C ,PER>
		       <RTRUE>)
		      (<EQUAL? ,BUNNIES 8>
		       <TELL "Eight">)
		      (<EQUAL? ,BUNNIES 13>
		       <TELL "Thirteen">)
		      (<G? ,BUNNIES ,BMAX>
		       <TELL "Countless">)
		      (<G? ,BUNNIES 999>
		       <TELL N </ ,BUNNIES 1000> C ,COMMA
			     N <MOD ,BUNNIES 1000>>)
		      (T
		       <TELL N ,BUNNIES>)>
		<TELL C ,SP 'DUST " hover in the air.">
		<RTRUE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<IS? ,DUST ,TOUCHED>)
	       (<SET X <TOUCHING?>>
		<START-DUST>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MOVE ,PRSO ,HERE>
		       <WINDOW ,SHOWING-ALL>
		       <TELL CTHEI " easily avoid " THEO ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? HIT MUNG CUT TOUCH KICK TAKE SHAKE>
		<HIT-BUNNIES>
		<RTRUE>)
	       (<VERB? EXAMINE COUNT>
		<UNMAKE ,PRSO ,SEEN>
		<COND (<EQUAL? ,BUNNIES 1>
		       <ONLY-ONE>
		       <RTRUE>)
		      (<G? ,BUNNIES ,BMAX>
		       <TELL CTHEO " number in the countless thousands." CR>
		       <RTRUE>)>
		<TELL "A quick count turns up ">
		<COND (<G? ,BUNNIES 999>
		       <TELL N </ ,BUNNIES 1000> C ,COMMA
			     N <MOD ,BUNNIES 1000>>)
		      (T
		       <TELL N ,BUNNIES>)>
		<TELL C ,SP 'PRSO ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>	        

<ROUTINE HIT-BUNNIES ()
	 <WHOOSH>
	 <COND (<ZERO? ,PRSI>
		<SETG PRSI ,HANDS>)>
	 <YOUR-OBJ>
	 <TELL " swipes through " THEO ,PTAB>
	 <COND (<SPARK-TO? ,PRSI ,PRSO>
		<RTRUE>)>
	 <I-DUST <>>
	 <RFALSE>>

<ROUTINE START-DUST ()
	 <MAKE ,DUST ,TOUCHED>
	 <UNMAKE ,DUST ,SEEN>
	 <QUEUE ,I-DUST>
	 <RFALSE>>

"*** DORNBEAST ***"

<OBJECT DORN
	(LAST-LOC TOWER-TOP)
	(DESC "dorn")
	(FLAGS NODESC LIVING MONSTER PERSON SURPRISED)
	(LIFE I-DORN)
	(ENDURANCE 100)
	(EMAX 100)
	(STRENGTH 25)
	(DEXTERITY 33)
	(VALUE 20)
	(HABITAT DORN-ROOMS)
	(SYNONYM DORNBEAST DORN BEAST DORNBROOK MONSTER)
	(ADJECTIVE DORN MIKE MICHAEL AWAKE)
	(DESCFCN DORN-F)
	(ACTION DORN-F)>

<ROUTINE DORN-F ("OPT" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL CA ,DORN ,SIS>
		<COND (<IS? ,DORN ,MUNGED>
		       <TELL "thrashing about, bawling helplessly.">
		       <RTRUE>)
		      (<IS? ,DORN ,SURPRISED>
		       <TELL "waiting for you.">
		       <RTRUE>)>
		<TELL "sweeping its gaze around the room.">
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-WINNER>
		<MAKE ,DORN ,SEEN>
		<TELL "\"Hurumph.\"" CR>
		<RFATAL>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? TELL>
		<SEE-CHARACTER ,PRSO>
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL CTHE ,DORN " is too busy bawling to respond." CR>
		       <RFATAL>)
		      (<T? ,P-CONT>
		       <SETG WINNER ,PRSO>
		       <RTRUE>)>
		<TELL CTHEO " \"Hurumphs\" expectantly." CR>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<COND (<IS? ,PRSO ,MUNGED>
		       <TELL CTHEO " is bawling like a baby. ">)>
		<DIAGNOSE-MONSTER>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <MAKE ,PRSO ,TOUCHED>
		       <TELL ,TAB>
		       <REFER-TO-PACKAGE>)>
		<RTRUE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>

"*** BLOODWORMS ***"

<OBJECT WORM
	(LOC WORM-ROOM)
	(LAST-LOC WORM-ROOM)
	(DESC "bloodworm")
	(FLAGS LIVING TRYTAKE SURFACE SURPRISED SLEEPING)
	(SDESC DESCRIBE-WORM)
	(SYNONYM WORM BLOODWORM ROCK STONE)
	(ADJECTIVE BLOOD MOSSY MOSS AWAKE)
	(LIFE I-WORM)
	(ENDURANCE 20)
	(EMAX 20)
	(STRENGTH 16)
	(DEXTERITY 70)
	(VALUE 20)
	(HABITAT JUNGLE-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN WORM-F)
	(EXIT-STR "slithering through the grass")
	(ACTION WORM-F)>

<ROUTINE DESCRIBE-WORM (OBJ)
	 <TELL "mossy rock">
	 <RTRUE>>

<ROUTINE WORM-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <COND (<NOT <IS? ,WORM ,MONSTER>>
			      <TELL "The underbrush almost conceals "
				    A ,WORM C ,PER>
			      <RTRUE>)>
		       <VIEW-MONSTER>
		       <RTRUE>)>
		<RFALSE>)
	       (<IS? ,WORM ,MONSTER>)
	       (<OR <VERB? LOOK-UNDER LOOK-BEHIND SEARCH>
		    <SET X <TOUCHING?>>>
		<START-WORM "approach">
		<RTRUE>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO>
		<COND (<IS? ,PRSO ,MONSTER>
		       <TELL 
" no longer looks like a mossy rock. It's equipped with three-foot fangs, and seems eager to plunge one or both of them into your chest. ">
		       <DIAGNOSE-MONSTER>
		       <RTRUE>)>
		<HELMLOOK>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HELMLOOK ()
	 <COND (<WEARING-MAGIC? ,HELM>
		<TELL " looks vaguely suspicious." CR>
		<RTRUE>)>
	 <PRINT " seems ordinary enough.|">
	 <RTRUE>>

<ROUTINE START-WORM (STR "AUX" X)
	 <MAKE ,WORM ,MONSTER>
	 <UNMAKE ,WORM ,SLEEPING>
	 <MAKE ,WORM ,NOALL>
         <UNMAKE ,WORM ,SURFACE>
	 <REPLACE-SYN? ,WORM ,W?ROCK ,W?MONSTER>
	 <REPLACE-SYN? ,WORM ,W?STONE ,W?ZZZP>
	 <REPLACE-ADJ? ,WORM ,W?MOSSY ,W?ZZZP>
	 <REPLACE-ADJ? ,WORM ,W?MOSS ,W?ZZZP>
	 <QUEUE ,I-WORM>
	 <WINDOW ,SHOWING-ROOM>
	 <SETG LAST-MONSTER ,WORM>
	 <SETG LAST-MONSTER-DIR ,P-WALK-DIR>
	 <SETG P-IT-OBJECT ,WORM>
	 <PUTP ,WORM ,P?SDESC ,DESCRIBE-MONSTERS>
	 <TELL "As you " .STR 
	       " the rock, a three-foot set of fangs leaps ">
	 <PRINT "out at you, barely missing your throat!|">
	 <RTRUE>>		

"*** CROCS ***"

<OBJECT CROC
	(LOC JUN2)
	(LAST-LOC JUN2)
	(DESC "crocodile")
	(FLAGS MONSTER LIVING SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM CROCODILE CROC LIZARD REPTILE MONSTER ALLIGATOR)
	(ADJECTIVE AWAKE)
	(LIFE I-CROC)
	(ENDURANCE 20)
	(EMAX 20)
	(STRENGTH 16)
	(DEXTERITY 80)
	(VALUE 20)
	(HABITAT JUNGLE-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "stalking through the undergrowth")
	(ACTION CROC-F)>

<ROUTINE CROC-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " looks hungry. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** HOUNDS ***"

<OBJECT HOUND
	(LAST-LOC 0)
	(DESC "hellhound")
	(FLAGS MONSTER LIVING SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM HELLHOUND HOUND HELL DOG MONSTER)
	(ADJECTIVE HELL AWAKE)
	(LIFE I-HOUND)
	(ENDURANCE 40)
	(EMAX 40)
	(STRENGTH 30)
	(DEXTERITY 70)
	(VALUE 25)
	(HABITAT FOREST-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "prowling between the trees")
	(ACTION HOUND-F)>

<ROUTINE HOUND-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is deciding how best to eat you. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** PUPPETS ***"

<OBJECT PUPP
	(LOC TWILIGHT)
	(LAST-LOC TWILIGHT)
	(DESC "cruel puppet")
	(FLAGS MONSTER LIVING SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM PUPPET MONSTER)
	(ADJECTIVE CRUEL AWAKE)
	(LIFE I-PUPP)
	(ENDURANCE 30)
	(EMAX 30)
	(STRENGTH 20)
	(DEXTERITY 80)
	(VALUE 25)
	(HABITAT FOREST-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "resting beneath a tree")
	(ACTION PUPP-F)>

<ROUTINE PUPP-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " twists its face to look just like you. Eeek! ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (<AND <VERB? LAUGH>
		     <EQUAL? ,P-PRSA-WORD ,W?INSULT ,W?OFFEND>>
		<SET X <GETP ,PRSO ,P?EMAX>>
		<COND (<L? <GETP ,PRSO ,P?ENDURANCE> .X>
		       <PUTP ,PRSO ,P?ENDURANCE .X>)
		      (<L? .X 32762>
		       <SET X <+ .X 5>>
		       <PUTP ,PRSO ,P?EMAX .X>
		       <PUTP ,PRSO ,P?ENDURANCE .X>)>
		<TELL "You instantly regret your words, for " THEO 
		      " grins with renewed vitality. It apparently ">
		<ITALICIZE "feeds">
		<TELL " off insults like that!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** UNDEAD ***"

<OBJECT DEAD
	(LAST-LOC 0)
	(DESC "undead warrior")
	(FLAGS MONSTER LIVING VOWEL SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM WARRIOR SOLDIER MAN FELLOW GUY UNDEAD MONSTER)
	(ADJECTIVE UNDEAD AWAKE)
	(LIFE I-DEAD)
	(ENDURANCE 36)
	(EMAX 36)
	(STRENGTH 30)
	(DEXTERITY 70)
	(VALUE 25)
	(HABITAT RUIN-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "lurking amid the ruins")
	(ACTION DEAD-F)>

<ROUTINE DEAD-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER TOUCH-TO>
		       <TOUCH-DEAD-WITH ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " shimmers like a wave of heat. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (<VERB? HIT MUNG CUT
		       RIP CUT OPEN
		       OPEN-WITH KICK STOUCH-TO>
		<TOUCH-DEAD-WITH ,PRSI>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<TOUCH-DEAD-WITH ,HANDS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TOUCH-DEAD-WITH (OBJ)
	 <COND (<NOT <EQUAL? .OBJ ,VIAL>>
		<PASSES-THROUGH .OBJ ,DEAD>
		<RTRUE>)>
	 <VANISH ,VIAL>
	 <TELL ,YOU-HEAR "a sharp ">
	 <ITALICIZE "crack">
	 <TELL " as " THE ,VIAL 
" shatters, splashing your target with a shower of droplets that burst into fire on contact! The blasphemous creature opens its jaws in a silent scream as a purifying flame engulfs its ghostly form.|
  Moments later, the last few cinders scatter in the breeze." CR>   
	 <KILL-MONSTER ,DEAD>
	 <RTRUE>>

"*** GHOULS ***"

<OBJECT GHOUL
	(LOC RUIN1)
	(LAST-LOC RUIN1)
	(DESC "ghoul")
	(FLAGS MONSTER LIVING SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM GHOUL ROBBER MONSTER)
	(ADJECTIVE GRAVE AWAKE)
	(LIFE I-GHOUL)
	(ENDURANCE 36)
	(EMAX 36)
	(STRENGTH 30)
	(DEXTERITY 70)
	(VALUE 25)
	(HABITAT RUIN-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(CONTFCN GHOUL-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "skulking about the ruins")
	(ACTION GHOUL-F)>

<ROUTINE GHOUL-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-CONT>
		       <COND (<SET X <TOUCHING?>>
			      <TELL "Laughing insanely, " 
				    THE ,GHOUL " dodges out of reach." CR>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " glares back at you. ">
		<DIAGNOSE-MONSTER>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** CORBIES ***"

<OBJECT CORBIES
	(LOC LOCAL-GLOBALS)
	(DESC "corbies")
	(FLAGS NODESC PLURAL LIVING)
	(SYNONYM CORBIES CORBIE BIRDS BIRD FLOCK GROUP BUNCH MONSTERS MONSTER)
	(ADJECTIVE GIANT)
	(ACTION CORBIES-F)>

<ROUTINE CORBIES-F ("AUX" (FEAR 0) X)
	 <COND (<AND <T? ,BADKEY>
		     <EQUAL? <LOC ,BADKEY> ,PLAYER ,HERE>>
		<INC FEAR>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER GIVE FEED SHOW>
		       <MAKE ,PRSI ,SEEN>
		       <COND (<NOT <VERB? SHOW>>
			      <MOVE ,PRSO ,HERE>
			      <WINDOW ,SHOWING-ALL>)>
		       <TELL CTHEI>
		       <COND (<PRSO? BADKEY>
			      <TELL " screech with fear!" CR>
			      <RTRUE>)>
		       <TELL " snatch " THEO
			     " out of the air, aim carefully and drop it">
		       <COND (<PROB 50>
			      <TELL " on your skull. Ouch!" CR>
			      <UPDATE-STAT <- 0 <GETP ,PRSO ,P?SIZE>>>
			      <RTRUE>)>
		       <TELL ", narrowly missing your skull." CR>
		       <RTRUE>)
		      (<SET X <TOUCHING?>>
		       <CORBIES-STAY-AWAY>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<TELL CTHE ,CORBIES " shriek back obscenities." CR>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "The flock of " 'PRSO " soars overhead in ">
		<COND (<T? .FEAR>
		       <TELL "high, frightened ">)
		      (T
		       <TELL "low, menacing ">)>
		<TELL "circles." CR>
		<COND (<NOT <IS? ,PRSO ,IDENTIFIED>>
		       <MAKE ,PRSO ,IDENTIFIED>
		       <TELL ,TAB>
		       <REFER-TO-PACKAGE>)>
		<RTRUE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (<T? .FEAR>)
	       (<VERB? HIT MUNG CUT KICK>
		<UNMAKE ,CORBIES ,SEEN>
		<TELL CTHEO " flutter out of your reach." CR>
		<RTRUE>)>
	 <COND (<SET X <TOUCHING?>>
		<CORBIES-STAY-AWAY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CORBIES-STAY-AWAY ()
	 <TELL CTHE ,CORBIES>
	 <COND (<AND <T? ,BADKEY>
		     <EQUAL? <LOC ,BADKEY> ,PLAYER ,HERE>>
		<MAKE ,CORBIES ,SEEN>
		<PRINT " seem unwilling to approach you.|">
		<RTRUE>)>
	 <UNMAKE ,CORBIES ,SEEN>
	 <TELL " easily swoop out of reach." CR>
	 <RTRUE>>

"*** MONKEY GRINDER ***"

<OBJECT GRINDER
	(LAST-LOC AT-GATE)
	(DESC "monkey grinder")
	(FLAGS NODESC PERSON LIVING MONSTER SURPRISED)
	(LIFE I-GRINDER)
	(ENDURANCE 100)
	(EMAX 100)
	(STRENGTH 16)
	(DEXTERITY 25)
	(VALUE 25)
	(HABITAT ACCARDI-ROOMS)
	(SYNONYM GRINDER FIGURE MAN FELLOW GUY MONSTER)
	(ADJECTIVE MONKEY AWAKE)
	(CONTFCN GRINDER-F)
	(DESCFCN GRINDER-F)
	(ACTION GRINDER-F)>

<ROUTINE GRINDER-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<SETG P-HIM-OBJECT ,GRINDER>
		<TELL CA ,GRINDER ,SIS>
		<COND (<IS? ,GRINDER ,SURPRISED>
		       <TELL "loafing nearby.">
		       <RTRUE>)>
		<TELL "attacking you with his " 'GURDY "!">
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-CONT>
		<COND (<SET X <TOUCHING?>>
		       <TELL CTHE ,GRINDER " slaps your hand away.">
		       <COND (<PROB 50>
			      <TELL " \"Touchy, touchy.\"">)>
		       <CRLF>
		       <RTRUE>)>
		<RFALSE>)
	       (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? GIVE GET-FOR>
		       <GIVE-TO-GRINDER ,PRSO>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <SHOW-TO-GRINDER ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? HELLO WAVE-AT>
		<MAKE ,GRINDER ,SEEN>
		<TELL "\"Hello, victim.\"" CR>
		<RTRUE>)
	       (<VERB? GOODBYE>
		<TELL "\"Heh heh heh.\"" CR>
		<RTRUE>)
	       (<SET X <TALKING?>>
		<PERPLEXED ,GRINDER>
		<TELL "You babble of ">
		<COND (<AND <T? ,PRSI>
			    <OR <IS? ,PRSI ,LIVING>
			        <IS? ,PRSI ,MONSTER>>>
		       <TELL "be">)
		      (T
		       <TELL "th">)>
		<TELL "ings of no significance to me!\"" CR>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<DIAGNOSE-MONSTER>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <MAKE ,PRSO ,TOUCHED>
		       <TELL ,TAB>
		       <REFER-TO-PACKAGE>)>
		<RTRUE>)
	       (<VERB? HIT MUNG>
		<TELL CTHEO " easily avoids ">
		<COND (<OR <EQUAL? ,PRSI <> ,HANDS ,FEET>
			   <NOT <IS? ,PRSI ,NOARTICLE>>>
		       <TELL "your ">)>
		<COND (<OR <VERB? KICK>
			   <PRSI? FEET>>
		       <TELL B ,W?FOOT>)
		      (<EQUAL? ,PRSI <> ,HANDS>
		       <TELL B ,W?BLOW>)
		      (T
		       <TELL D ,PRSI>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>
		
<ROUTINE SOME (OBJ)
	 <COND (<IS? .OBJ ,PLURAL>
		<TELL "some">
		<RTRUE>)>
	 <TELL "one">
	 <RTRUE>>

<ROUTINE GIVE-TO-GRINDER (OBJ)
	 <MAKE ,GRINDER ,SEEN>
	 <COND (<GIVING-LOOT? .OBJ ,GRINDER>
		<RTRUE>)
	       (<EQUAL? .OBJ ,CHEST>
		<GRINDERS-BANE>
		<RTRUE>)>
	 <TELL "\"If I wanted " A .OBJ ", I'd steal ">
	 <SOME .OBJ>
	 <TELL ,PERQ>
	 <RTRUE>>

<ROUTINE SHOW-TO-GRINDER (OBJ)
	 <MAKE ,GRINDER ,SEEN>
	 <COND (<EQUAL? .OBJ ,CHEST>
		<GRINDERS-BANE T>
		<RTRUE>)>
	 <TELL CTHE ,GRINDER ,GLANCES-AT THE .OBJ
	       " and yawns conspicuously." CR>
	 <RTRUE>>

<ROUTINE EXIT-GRINDER ()
	 <MOVE ,GURDY ,HERE>
	 <SETG GRTIMER 0>
	 <KILL-MONSTER ,GRINDER>
	 <SETG P-IT-OBJECT ,GURDY>
	 <WINDOW ,SHOWING-ALL>
	 <RFALSE>>

<ROUTINE GRINDERS-BANE ("OPT" (TAKIT <>) "AUX" L)
	 <SET L <LOC ,CHEST>>
	 <MOVE ,CHEST ,AT-GATE>
	 <TELL "\"A treasure chest!\" crows " THE ,GRINDER
	       ", snatching it ">
	 <COND (<EQUAL? .L ,PLAYER>
		<TELL "rudely away from you">)
	       (T
		<OUT-OF-LOC .L>)>
	 <TELL ". \"I just ">
	 <ITALICIZE "love">
	 <TELL " surprises.\"|
  You wince as he taps on the outside of the chest, shakes it, then turns it upside down. Nothing happens. Then he places it on the ground, stares without comprehension at the brass plate, and cracks his knuckles" ,PTAB>
	 <DESCRIBE-GATE ,GRINDER>
	 <EXIT-GRINDER>
	 <RTRUE>>
	       
"*** UR-GRUE ***"

<OBJECT URGRUE
	(LOC IN-LAIR)
	(LAST-LOC IN-LAIR)
	(DESC "shadow")
	(SDESC DESCRIBE-URGRUE)
	(FLAGS NODESC VOWEL LIVING MONSTER SURPRISED)
	(SYNONYM URGRUE UR\-GRUE SHADOW SHADOWS VOICE MONSTER)
	(ADJECTIVE UR AWAKE)
	(VALUE 50)
	(GENERIC GENERIC-MONSTER-F)
	(ACTION URGRUE-F)>

<ROUTINE DESCRIBE-URGRUE (OBJ)
	 <COND (<OR <T? ,LIT?>
		    <WEARING-MAGIC? ,HELM>>
		<PRINTD .OBJ>
		<RTRUE>)>
	 <TELL "voice">
	 <RTRUE>>

<ROUTINE URGRUE-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<NOUN-USED? ,W?URGRUE ,W?UR\-GRUE>
		<PCLEAR>
		<TELL "It is unwise to speak of such things." CR>
		<UPDATE-STAT -1 ,LUCK T>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<SET X <PUTTING?>>
		       <HOPELESS>
		       <RTRUE>)
		      (<VERB? GIVE SHOW FEED>
		       <NO-INTS>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <TALKING?>>
		<NO-INTS>
		<RTRUE>)
	       (<VERB? HIT MUNG CUT>
		<HOPELESS>
		<RTRUE>)
	       (<VERB? EXAMINE WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE HOPELESS ()
	 <TELL "A feeling of utter hopelessness stays your hand." CR>
	 <RTRUE>>

<ROUTINE NO-INTS ()
	 <PCLEAR>
	 <TELL "\"Please don't interrupt my monologue,\" scolds the ">
	 <COND (<OR <T? ,LIT?>
		    <WEARING-MAGIC? ,HELM>>
		<TELL 'URGRUE ,PERIOD>
		<RTRUE>)>
	 <TELL "voice in the darkness." CR>
	 <RTRUE>> 
	      
"*** CHRISTMAS TREES ***"

<OBJECT XTREES
	(LOC LOCAL-GLOBALS)
	(DESC "Christmas tree monsters")
	(FLAGS LIVING MONSTER PLURAL SURFACE)
	(SYNONYM TREES TREE MONSTER MONSTERS)
	(ADJECTIVE CHRISTMAS XMAS TREE)
	(LIFE 0)
	(ENDURANCE 12)
	(EMAX 12)
	(STRENGTH 6)
	(DEXTERITY 30)
	(VALUE 5)
	(GENERIC GENERIC-MONSTER-F)
	(ACTION XTREES-F)>
	 
<ROUTINE XTREES-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <V-THROW>
		       <COND (<AND <PRSO? BFLY>
				   <IN? ,PRSO ,HERE>>
			      <TELL ,TAB>
			      <SHOW-XTREES-BFLY?>)>
		       <RTRUE>)
		      (<VERB? SHOW GIVE GET-FOR>
		       <COND (<PRSO? BFLY>
			      <SHOW-XTREES-BFLY?>
			      <RTRUE>)>
		       <TELL CTHE ,XTREES " show no interest in " 
			     THEO ,PERIOD>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <TELL CTHEI " edge away from you." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<OR <VERB? WAVE-AT HELLO>
		    <SET X <TALKING?>>>
		<PCLEAR>
		<TELL CTHE ,XTREES " are too busy singing">
		<PRINT " to pay you much heed.|">
		<RFATAL>)
	       (<VERB? EXAMINE>
		<REFER-TO-PACKAGE>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "Still singing." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "The scent of pine">
		<PRINT " fills the air">
		<TELL ,PERIOD>
		<RTRUE>)
	       (<VERB? HIT MUNG KICK>
		<TELL 
"Sure. And even if you hit one tree, what about the thousands of others?" CR>
		<RTRUE>)
	       (<VERB? COUNT>
		<TELL "A quick count reveals 69,105 " 'PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (<VERB? LAMP-OFF>
		<HOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SHOW-XTREES-BFLY? ("OPT" (INDENT 0))
	 <COND (<OR <NOT <IS? ,BFLY ,MUNGED>>
		    <NOT <VISIBLE? ,BFLY>>>
		<MAKE ,XTREES ,SEEN>
		<COND (<T? .INDENT>
		       <TELL ,TAB>)>
		<TELL CTHE ,XTREES " murmur with vague concern." CR>
		<RTRUE>)
	       (<NOT <IS? ,BFLY ,LIVING>>
		<MAKE ,XTREES ,SEEN>
		<COND (<T? .INDENT>
		       <TELL ,TAB>)>
		<TELL CTHE ,XTREES 
" hesitate for a moment when they spot " THE ,BFLY
". But as it isn't moving, they soon resume their song." CR>
		<RTRUE>)>
	 <COND (<T? .INDENT>
		<TELL ,TAB>)>
	 <MAKE ,XTREES ,SEEN>
	 <TELL CTHE ,XTREES>
	 <COND (<IS? ,XTREES ,NEUTRALIZED>
		<TELL 
" seem to have gotten over their initial shock. Their carolling proceeds with renewed joy and determination." CR>
		<RTRUE>)>
	 <MAKE ,XTREES ,NEUTRALIZED>
	 <TELL 
" stop dead in their tracks when they spot " THE ,BFLY
". Youngsters take root behind their mothers, and the leaders sing an emergency verse of \"" <PICK-NEXT ,CAROLS> ,PERQ>
	 <RTRUE>>

"*** GRUE ***"

<OBJECT GRUE
	(LAST-LOC 0)
	(DESC "lurking presence")
	(FLAGS MONSTER LIVING SURPRISED)
	(SDESC DESCRIBE-MONSTERS)
	(SYNONYM GRUE PRESENCE MONSTER)
	(ADJECTIVE LURKING SINISTER AWAKE)
	(LIFE I-GRUE)
	(ENDURANCE 99)
	(EMAX 99)
	(STRENGTH 99)
	(DEXTERITY 95)
	(VALUE 30)
	(DNUM 0)
	(HABITAT GRUE-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(ACTION GRUE-F)>

<ROUTINE GRUE-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (<IN? ,GRUE ,HERE>
		<RFALSE>)
	       (<VERB? FIND WHERE>
		<TELL "There's probably one">
		<PRINT " lurking in the darkness nearby.|">
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "Grues make no sound, but are always">
		<PRINT " lurking in the darkness nearby.|">
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** LUCKSUCKERS ***"

<OBJECT ASUCKER
	(LOC CAVE2)
	(LAST-LOC CAVE2)
	(DESC "lucksucker")
	(SDESC DESCRIBE-SUCKERS)
	(FLAGS MONSTER LIVING SURPRISED)
	(SYNONYM ZZZP ZZZP LUCKSUCKER SUCKER MONSTER)
	(ADJECTIVE ZZZP BLACK GIANT LARGE LUCK AWAKE)
	(LIFE I-ASUCKER)
	(ENDURANCE 16)
	(EMAX 16)
	(STRENGTH 12)
	(DEXTERITY 60)
	(VALUE 20)
	(DNUM 0)
	(HABITAT GRUE-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "stalking the passageway")
	(ACTION ASUCKER-F)>

<ROUTINE ASUCKER-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-SUCKERS? ,ASUCKER>>>

<OBJECT BSUCKER
	(LAST-LOC 0)
	(DESC "lucksucker")
	(SDESC DESCRIBE-SUCKERS)
	(FLAGS MONSTER LIVING SURPRISED)
	(SYNONYM ZZZP ZZZP LUCKSUCKER SUCKER MONSTER)
	(ADJECTIVE ZZZP BLACK GIANT LARGE LUCK AWAKE)
	(LIFE I-BSUCKER)
	(ENDURANCE 16)
	(EMAX 16)
	(STRENGTH 12)
	(DEXTERITY 60)
	(VALUE 20)
	(DNUM 0)
	(HABITAT GRUE-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN VIEW-MONSTER)
	(EXIT-STR "stalking the passageway")
	(ACTION BSUCKER-F)>

<ROUTINE BSUCKER-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-SUCKERS? ,BSUCKER>>>

<OBJECT CSUCKER
	(LAST-LOC 0)
	(DESC "lucksucker")
	(SDESC DESCRIBE-SUCKERS)
	(FLAGS MONSTER LIVING SURPRISED)
	(SYNONYM ZZZP ZZZP LUCKSUCKER SUCKER MONSTER)
	(ADJECTIVE ZZZP BLACK GIANT LARGE LUCK AWAKE)
	(LIFE I-CSUCKER)
	(ENDURANCE 16)
	(EMAX 16)
	(STRENGTH 12)
	(DEXTERITY 60)
	(VALUE 20)
	(DNUM 0)
	(HABITAT GRUE-ROOMS)
	(GENERIC GENERIC-MONSTER-F)
        (DESCFCN VIEW-MONSTER)
	(EXIT-STR "stalking the passageway")
	(ACTION CSUCKER-F)>

<ROUTINE CSUCKER-F ("OPT" (CONTEXT <>))
	 <RETURN <HANDLE-SUCKERS? ,CSUCKER>>>

<GLOBAL THIS-SUCKER:NUMBER S-13>

<ROUTINE DESCRIBE-SUCKERS (OBJ)
	 <TELL <GET ,SUCKER-NAMES ,THIS-SUCKER>>
	 <RTRUE>>

<ROUTINE HANDLE-SUCKERS? (OBJ "AUX" X)
	 <COND (<AND <NOUN-USED? ,W?INTNUM>
		     <NOT <EQUAL? ,P-NUMBER 13>>>
		<TELL ,CANT "see that number here." CR>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? SHOW>
		       <TELL CTHEI " seems ">
		       <COND (<NOT <PRSO? RFOOT CLOVER SHOE>>
			      <TELL "indifferent to ">
			      <SAY-YOUR ,PRSO>
			      <TELL ,PERIOD>
			      <RTRUE>)>
		       <TELL "to hesitate for a moment." CR>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER TOUCH-TO>
		       <TOUCH-SUCKER-WITH .OBJ ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " returns your stare." CR>
		<RTRUE>)
	       (<VERB? HIT MUNG CUT
		       RIP CUT OPEN
		       OPEN-WITH KICK STOUCH-TO>
		<TOUCH-SUCKER-WITH .OBJ ,PRSI>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<TOUCH-SUCKER-WITH .OBJ ,HANDS>
		<RTRUE>)
	       (<VERB? WHAT WHO>
		<REFER-TO-PACKAGE>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE TOUCH-SUCKER-WITH (SUCKER OBJ)
	 <COND (<NOT <EQUAL? .OBJ ,RFOOT ,CLOVER ,SHOE>>
		<COND (<VERB? THROW THROW-OVER>
		       <MOVE .OBJ ,HERE>
		       <WINDOW ,SHOWING-ALL>)>
		<PASSES-THROUGH .OBJ .SUCKER>
		<RTRUE>)>
	 <VANISH .OBJ>
	 <KERBLAM>
	 <TELL CTHE .OBJ>
	 <BLAST-SUCKER .SUCKER>
	 <RTRUE>>

<ROUTINE BLAST-SUCKER (OBJ)
	 <PUTP .OBJ ,P?ENDURANCE 0>
	 <TELL " explodes in a shower of green sparks!" CR>
	 <RTRUE>>

"*** SNOW WIGHT ***"

<OBJECT WIGHT
	(LOC ON-TRAIL)
	(DESC "snow wight")
	(SDESC DESCRIBE-WIGHT)
	(FLAGS TRYTAKE SURFACE CONTAINER OPENED SURPRISED)
	(SYNONYM SNOWDRIFT DRIFT SNOW)
	(ADJECTIVE SNOW AWAKE)
	(LIFE I-WIGHT)
	(ENDURANCE 36)
	(EMAX 36)
	(STRENGTH 30)
	(DEXTERITY 70)
	(VALUE 30)
	(GENERIC GENERIC-MONSTER-F)
	(DESCFCN WIGHT-F)
	(EXIT-STR "waiting for you")
	(ACTION WIGHT-F)>

<VOC "WIGHT" NOUN>

<ROUTINE DESCRIBE-WIGHT (OBJ)
	 <TELL B ,W?SNOWDRIFT>
	 <RTRUE>>

<ROUTINE START-WIGHT ("AUX" X)
	 <MAKE ,WIGHT ,MONSTER>
	 <MAKE ,WIGHT ,LIVING>
	 <UNMAKE ,WIGHT ,SURFACE>
	 <UNMAKE ,WIGHT ,CONTAINER>
	 <UNMAKE ,WIGHT ,OPENED>
	 <REPLACE-SYN? ,WIGHT ,W?DRIFT ,W?MONSTER>
	 <REPLACE-SYN? ,WIGHT ,W?SNOWDRIFT ,W?WIGHT>
	 <QUEUE ,I-WIGHT>
	 <WINDOW ,SHOWING-ROOM>
	 <SETG LAST-MONSTER ,WIGHT>
	 <SETG LAST-MONSTER-DIR ,P?SOUTH>
	 <SETG P-IT-OBJECT ,WIGHT>
	 <AS-YOU-APPROACH ,WIGHT>
	 <PUTP ,WIGHT ,P?SDESC 0>
	 <TELL "a pair of bloodstained claws swipes ">
	 <PRINT "out at you, barely missing your throat!|">
	 <RTRUE>>
	 
<ROUTINE WIGHT-F ("OPT" (CONTEXT <>) "AUX" X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <COND (<NOT <IS? ,WIGHT ,MONSTER>>
			      <TELL CA ,WIGHT
				    " is blocking the uphill trail.">
			      <RTRUE>)>
		       <VIEW-MONSTER>
		       <RTRUE>)>
		<RFALSE>)
	       (<IS? ,WIGHT ,MONSTER>)
	       (<SET X <TOUCHING?>>
		<START-WIGHT>
		<RTRUE>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MONSTER-THROW>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO>
		<COND (<IS? ,PRSO ,MONSTER>
		       <TELL 
" is equipped with long, sharp teeth and claws, stained with the blood of its last encounter. ">
		       <DIAGNOSE-MONSTER>
		       <RTRUE>)>
		<HELMLOOK>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** SHAPE ***"

<OBJECT SHAPE
	(DESC "vague outline")
	(FLAGS TRYTAKE NOALL MONSTER LIVING)
	(SYNONYM OUTLINE)
	(ADJECTIVE AWAKE OUTLINE)
	(VALUE 10)
	(DESCFCN SHAPE-F)
	(ACTION SHAPE-F)>

<ROUTINE SHAPE-F ("OPT" (CONTEXT <>) "AUX" TBL X)
	 <COND (<T? .CONTEXT>
		<COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		       <SET X ,P?NW>
		       <REPEAT ()
			  <SET TBL <GETP ,HERE .X>>
			  <COND (<ZERO? .TBL>)
				(<EQUAL? <GET .TBL ,XDATA> ,OPLAIN>
				 <RETURN>)>
			  <COND (<IGRTR? X ,P?NORTH>
			       ; <SAY-ERROR "SHAPE-F">
				 <RTRUE>)>>
		       <TELL CA ,SHAPE
" is stretched across the " B <GET ,DIR-NAMES <- 0 <- .X ,P?NORTH>>>
" plane."> 
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<VERB? TOUCH-TO>
		       <TOUCH-SHAPE-WITH ,PRSO>
		       <RTRUE>)
		      (<SET X <PUTTING?>>
		       <COND (<PRSO? PHASE>
			      <TELL CTHEI " flexes away from " THEO
				    ,PERIOD>
			      <RTRUE>)>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)
		      (<VERB? LOOK-THRU>
		       <DISTORTED>
		       <RTRUE>)>
		<RFALSE>)
	       (<SET X <CLIMBING-ON?>>
		<TELL CTHEO 
" flexes backwards and sideways, thwarting your best efforts." CR>
		<RTRUE>)
	       (<VERB? HIT MUNG CUT
		       RIP CUT OPEN
		       OPEN-WITH KICK STOUCH-TO>
		<TOUCH-SHAPE-WITH ,PRSI>
		<RTRUE>)
	       (<SET X <TOUCHING?>>
		<TOUCH-SHAPE-WITH ,HANDS>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "Looking directly at " THEO 
		      " makes your head ache." CR>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND>
		<DISTORTED>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DISTORTED ()
	 <TELL "The space beyond " THE ,SHAPE
	       " appears hopelessly distorted." CR>
	 <RTRUE>>

<ROUTINE TOUCH-SHAPE-WITH (OBJ)
	 <COND (<NOT <EQUAL? .OBJ ,PHASE>>
		<PASSES-THROUGH .OBJ ,SHAPE>
		<RTRUE>)
	       (<NOT <IN? .OBJ ,PLAYER>>
		<YOUD-HAVE-TO "be holding" .OBJ>
		<RTRUE>)>
	 <VANISH ,SHAPE>
	 <UNMAKE ,SHAPE ,LIVING>
	 <SETG LAST-MONSTER <>>
	 <SETG LAST-MONSTER-DIR <>>
	 <HUMS>
	 <TELL  "slashes effortlessly through " THE ,SHAPE 
". The torn edges recoil in agony, twist inside out and vanish in a toroid of collapsing geometry, leaving you with a clear path and a headache." CR>
	 <UPDATE-STAT <GETP ,SHAPE ,P?VALUE> ,EXPERIENCE>
	 <RTRUE>>
	 