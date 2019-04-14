"CONSTANTS for BEYOND ZORK:
 Copyright (C)1987 Infocom, Inc. All rights reserved."

<CONSTANT EOL 13>
<CONSTANT LF 10>
<CONSTANT SP 32>
<CONSTANT EXCLAM 33>
<CONSTANT QUOTATION 34>
<CONSTANT PER 46>
<CONSTANT COMMA 44>

<CONSTANT DEC-20 1>
<CONSTANT APPLE-2E 2>
<CONSTANT MACINTOSH 3>
<CONSTANT AMIGA 4>
<CONSTANT ATARI-ST 5>
<CONSTANT IBM 6>
<CONSTANT C128 7>
<CONSTANT C64 8>
<CONSTANT APPLE-2C 9>
<CONSTANT APPLE-2GS 10>

<CONSTANT MACHINES
	<PLTABLE "DEC-20"
		 "Apple //e"
		 "Macintosh"
		 "Amiga"
		 "Atari ST"
		 "IBM/MS-DOS"
		 "Commodore 128"
		 "C64"
		 "Apple //c"
		 "Apple //gs"
		 "Tandy Color Computer">>

<CONSTANT F-OLD 0>
<CONSTANT F-DEFAULT 1>
<CONSTANT F-PICTURES 2>
<CONSTANT F-NEWFONT 3>

<CONSTANT S-TEXT 0>
<CONSTANT S-WINDOW 1>

<CONSTANT S-BEEP 1>
<CONSTANT S-BOOP 2>

<CONSTANT H-NORMAL 0>
<CONSTANT H-INVERSE 1>
<CONSTANT H-BOLD 2>
<CONSTANT H-ITALIC 4>
<CONSTANT H-MONO 8>

<CONSTANT D-SCREEN-ON 1>
<CONSTANT D-SCREEN-OFF -1>
<CONSTANT D-PRINTER-ON 2>
<CONSTANT D-PRINTER-OFF -2>
<CONSTANT D-TABLE-ON 3>
<CONSTANT D-TABLE-OFF -3>
<CONSTANT D-RECORD-ON 4>
<CONSTANT D-RECORD-OFF -4>

"Color constants"

<CONSTANT C-SAME 0>
<CONSTANT C-DEFAULT 1>
<CONSTANT C-BLACK 2>
<CONSTANT C-RED 3>
<CONSTANT C-GREEN 4>
<CONSTANT C-YELLOW 5>
<CONSTANT C-BLUE 6>
<CONSTANT C-MAGENTA 7>
<CONSTANT C-CYAN 8>
<CONSTANT C-WHITE 9>

<CONSTANT BWWW <PTABLE (BYTE) C-BLUE C-WHITE C-WHITE C-WHITE>> 
<CONSTANT BWCR <PTABLE (BYTE) C-BLACK C-WHITE C-CYAN C-RED>>
<CONSTANT WBBB <PTABLE (BYTE) C-WHITE C-BLACK C-BLACK C-BLACK>>
<CONSTANT DWWW <PTABLE (BYTE) C-BLACK C-WHITE C-WHITE C-WHITE>>
<CONSTANT DEFCOLORS 
	  <PTABLE (BYTE) C-DEFAULT C-DEFAULT C-DEFAULT C-DEFAULT>>

<CONSTANT ST-MONO <PLTABLE DWWW WBBB>>

<CONSTANT MACHINE-COLORS
	  <PLTABLE
	   0 ; "DEC-20"
	   0 ; "Apple //e"
	   0 ; "Macintosh"
	   <PLTABLE
	       BWCR DWWW BWWW WBBB> ; "Amiga"
	   <PLTABLE
	       BWCR DWWW BWWW WBBB> ; "Atari ST"
	   <PLTABLE
	       DEFCOLORS
	       BWWW
	       <PTABLE (BYTE) C-BLUE C-WHITE C-WHITE C-GREEN>
	       BWCR DWWW WBBB> ; "IBM"
	   <PLTABLE
	      <PTABLE (BYTE) C-BLACK C-WHITE C-YELLOW C-CYAN>
	       DWWW WBBB BWWW> ; "C128"
	   0 ; "C64"
	   0 ; "Apple //c"
	   <PLTABLE
	       BWCR DWWW BWWW WBBB> ; "Apple //gs"
	   >>

"Apple //c MouseText characters."

<CONSTANT APPLE-LEFT 95>
<CONSTANT APPLE-RIGHT 90>
<CONSTANT APPLE-HORZ 76>

"IBM graphics chars."

<CONSTANT IBM-TRC 191>
<CONSTANT IBM-BLC 192>
<CONSTANT IBM-BRC 217>
<CONSTANT IBM-TLC 218>
<CONSTANT IBM-HORZ 196>
<CONSTANT IBM-VERT 179>

<CONSTANT DIR-HACKS <PTABLE -7 -6 1 8 7 6 -1 -8>>

<CONSTANT I-NORTH 0>
<CONSTANT I-NE    1>
<CONSTANT I-EAST  2>
<CONSTANT I-SE    3>
<CONSTANT I-SOUTH 4>
<CONSTANT I-SW    5>
<CONSTANT I-WEST  6>
<CONSTANT I-NW    7>
<CONSTANT I-U	  8>
<CONSTANT I-D	  9>

<CONSTANT DIR-NAMES
	  <PTABLE <VOC "NORTH" <>> <VOC "NORTHEAST" <>>
		  <VOC "EAST" <>> <VOC "SOUTHEAST" <>>
		  <VOC "SOUTH" <>> <VOC "SOUTHWEST" <>>
		  <VOC "WEST" <>> <VOC "NORTHWEST" <>>
		  <VOC "UP" <>> <VOC "DOWN" <>>  >>

<CONSTANT PDIR-LIST
	  <PTABLE (BYTE)
		  P?NORTH P?NE P?EAST P?SE
		  P?SOUTH P?SW P?WEST P?NW
		  P?UP P?DOWN P?IN P?OUT>>

<CONSTANT XPDIR-LIST
	  <PTABLE (BYTE)
		  P?SOUTH P?SW P?WEST P?NW
		  P?NORTH P?NE P?EAST P?SE
		  P?DOWN P?UP P?OUT P?IN>>

<CONSTANT UP-ARROW 129>
<CONSTANT DOWN-ARROW 130>
<CONSTANT LEFT-ARROW 131>
<CONSTANT RIGHT-ARROW 132>

<CONSTANT F1 133>
<CONSTANT F2 134>
<CONSTANT F3 135>
<CONSTANT F4 136>
<CONSTANT F5 137>
<CONSTANT F6 138>
<CONSTANT F7 139>
<CONSTANT F8 140>
<CONSTANT F9 141>
<CONSTANT F10 142>
<CONSTANT F11 143>
<CONSTANT F12 144>

<CONSTANT PAD0 145>
<CONSTANT PAD1 146>
<CONSTANT PAD2 147>
<CONSTANT PAD3 148>
<CONSTANT PAD4 149>
<CONSTANT PAD5 150>
<CONSTANT PAD6 151>
<CONSTANT PAD7 152>
<CONSTANT PAD8 153>
<CONSTANT PAD9 154>

<CONSTANT CLICK1 254>
<CONSTANT CLICK2 253>

<CONSTANT MAC-DOWN-ARROW <ASCII !\/>>
<CONSTANT MAC-UP-ARROW <ASCII !\\>>

<CONSTANT TCHARS 
	  <TABLE (KERNEL BYTE)
		  UP-ARROW DOWN-ARROW LEFT-ARROW RIGHT-ARROW
		  F1 F2 F3 F4 F5 F6 F7 F8 F9 F10
		  PAD0 PAD1 PAD2 PAD3 PAD4 PAD5 PAD6 PAD7 PAD8 PAD9
		  CLICK1 CLICK2 0 0 0>>

<CONSTANT FIRST-MAC-ARROW 26>

<CONSTANT PAD-NAMES
	  <PTABLE <VOC "SOUTHWEST" <>>
		  <VOC "SOUTH" <>>
		  <VOC "SOUTHEAST" <>>
		  <VOC "WEST" <>>
		  <VOC "AROUND" <>>
		  <VOC "EAST" <>>
		  <VOC "NORTHWEST" <>>
		  <VOC "NORTH" <>>
		  <VOC "NORTHEAST" <>>>>

<CONSTANT C-TABLE-LENGTH 100>
<CONSTANT C-TABLE <ITABLE %<+ ,C-TABLE-LENGTH 1>>>

<CONSTANT C-INTLEN 4> "Length of an interrupt entry."
<CONSTANT C-RTN 0>    "Offset of routine name."
<CONSTANT C-TICK 1>   "Offset of count."

<CONSTANT REXIT 0>
<CONSTANT UEXIT 2>
<CONSTANT NEXIT 3>
<CONSTANT FEXIT 4>
<CONSTANT CEXIT 5>
<CONSTANT DEXIT 6>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 4>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 2>

<CONSTANT NEW-STATS <ITABLE 8 (BYTE) 0>>
<CONSTANT NORMAL-RATE 2>
<CONSTANT BLESSED-RATE %<* ,NORMAL-RATE 2>>

<CONSTANT MIN-HIT-PROB 50>
<CONSTANT MAX-HIT-PROB 95>

<CONSTANT STSTR <PTABLE "EN" "ST" "DX" "IQ" "CM" "LK" "AC">>

<CONSTANT KEY-LABELS
	  <PTABLE " F1" " F2" " F3" " F4" " F5"
		  " F6" " F7" " F8" " F9" "F10">>

<CONSTANT APPLE-LABELS
	  <PTABLE "[1]" "[2]" "[3]" "[4]" "[5]"
		  "[6]" "[7]" "[8]" "[9]" "[0]">>

<CONSTANT SOFT-LEN 36>
<CONSTANT NSOFT-LEN -36>

<CONSTANT SOFT-KEYS
	  <PTABLE
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>
	    <ITABLE <+ ,SOFT-LEN 2> (BYTE) 0>>>

<CONSTANT KEY-DEFAULTS
	  <PTABLE
	   <PLTABLE (STRING) "look around|">
	   <PLTABLE (STRING) "inventory|">
	   <PLTABLE (STRING) "status|">
	   <PLTABLE (STRING) "examine">
	   <PLTABLE (STRING) "take">
	   <PLTABLE (STRING) "drop">
	   <PLTABLE (STRING) "attack monster|">
	   <PLTABLE (STRING) "again|">
	   <PLTABLE (STRING) "undo|">
	   <PLTABLE (STRING) "oops">>>

<CONSTANT FUMBLE-NUMBER 6>
<CONSTANT LOAD-ALLOWED 30>

<CONSTANT NORMAL-ATTACK 0>
<CONSTANT PARRYING 1>
<CONSTANT THRUSTING 2>

<CONSTANT YAWNS
	  <LTABLE 2 "unusual" "interesting" "extraordinary" "special">>

<CONSTANT HO-HUM
	  <LTABLE 2 
	     "n't do anything useful"
	     " accomplish nothing"
	     " have no desirable effect"
	     "n't be very productive"
	     " serve no purpose"
	     " be pointless">>

<CONSTANT YUKS
	  <LTABLE 2
	     "That's impossible"
	     "What a ridiculous concept"
	     "You can't be serious">>

<CONSTANT FIRMS
	  <LTABLE 2 "firm" "permanent" "immovab" "secure">>

<CONSTANT ATTACHES
	  <LTABLE 2 "attached" "affixed">>

<CONSTANT POINTLESS
	  <LTABLE 2
	     "There's no point in doing that"
	     "That would be pointless"
	     "That's a pointless thing to do">>
			       
<CONSTANT PUZZLES
	  <LTABLE 2 "puzzl" "bewilder" "confus" "perplex">>

<CONSTANT UNKNOWN-MSGS
	  <LTABLE 2 
	     <PTABLE "The word \""
	             "\" isn't in the vocabulary that you can use.">
             <PTABLE "You don't need to use the word \""
	             "\" to complete this story.">
             <PTABLE "This story doesn't recognize the word \""
	             ".\"">>>

<CONSTANT LIKELIES 
	  <LTABLE 2
	     " isn't likely"
	     " seems doubtful"
	     " seems unlikely"
	     "'s unlikely"
	     "'s not likely"
	     "'s doubtful">>

"List of words to be capitalized."

<CONSTANT CAPS
	  <LTABLE
	   -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
	   <VOC "MR" <>> <VOC "MRS" <>> <VOC "MISS" <>>
	   <VOC "I" <>> <VOC "N" <>> <VOC "S" <>>
	   <VOC "E" <>> <VOC "W" <>> <VOC "ZORK" <>>
	   <VOC "ZORKMID" <>> <VOC "ZORKMIDS" <>> <VOC "ZM" <>>
	   <VOC "CHRISTMAS" <>> <VOC "XMAS" <>>
	   <VOC "FROON" <>> <VOC "FROTZEN" <>>
	   <VOC "GUILD" <>> <VOC "ACCARDI" <>> <VOC "GRUBBO" <>>
	   <VOC "THRIFF" <>> <VOC "ALEXIS" <>> <VOC "PHEE" <>>
	   <VOC "PHEEBOR" <>> <VOC "PHEEHELM" <>>
	   <VOC "QUEEN" <>> <VOC "GROTE" <>> <VOC "CLUTCHCAKE" <>>
	   <VOC "BOK" <>> <VOC "YABBA" <>> <VOC "SMEE" <>>
	   <VOC "SQUIRP" <>> <VOC "STELLA" <>> <VOC "BLARN" <>>
	   <VOC "PROSSER" <>> <VOC "YQUEM" <>> <VOC "WATKIN" <>>
	   <VOC "JUKES" <>> <VOC "MACUGA" <>>
	   <VOC "GRUESLAYER" NOUN> <VOC "SKYCAR" <>>
	   <VOC "SKYWAY" <>> <VOC "Y\'GAEL" <>> >>

<CONSTANT VOCAB2 <ITABLE 160 (BYTE) 0>>

"Game-specific constants."

<CONSTANT BASE-CHAR 79> "Base (0) character of bargraph charset."

<CONSTANT MARKBIT 128>

<CONSTANT SHOWING-ROOM 1>
<CONSTANT SHOWING-INV 2>
<CONSTANT SHOWING-ALL %<+ ,SHOWING-ROOM ,SHOWING-INV>>
<CONSTANT SHOWING-STATS 4>

<CONSTANT SLINE-LENGTH 82>
<CONSTANT SLINE <ITABLE ,SLINE-LENGTH (BYTE) 0>>

<CONSTANT MAX-HEIGHT 25>
<CONSTANT MAX-DWIDTH 62>
<CONSTANT DBOX-LENGTH %<+ <* ,MAX-HEIGHT ,MAX-DWIDTH> 2>>
<CONSTANT DBOX <ITABLE ,DBOX-LENGTH (BYTE) 0>>

<CONSTANT MWIDTH 17>
<CONSTANT MHEIGHT 11>
<CONSTANT MAP-SIZE %<* ,MWIDTH ,MHEIGHT>>
<CONSTANT MAP <ITABLE ,MAP-SIZE (BYTE) 0>>

<CONSTANT CENTERX %</ ,MWIDTH 2>>
<CONSTANT NCENTERX %<- 0 ,CENTERX>>

<CONSTANT CENTERY %</ ,MHEIGHT 2>>
<CONSTANT NCENTERY %<- 0 ,CENTERY>>

<CONSTANT ROOMS-MAPPED-LENGTH 46>
<CONSTANT ROOMS-MAPPED <ITABLE ,ROOMS-MAPPED-LENGTH (BYTE) 0>>

<CONSTANT MAP-TOP 1>
<CONSTANT MAP-BOT %<- ,MHEIGHT 2>>
<CONSTANT MAP-LEFT 256>
<CONSTANT MAP-RIGHT %<* <- ,MWIDTH 2> 256>>

<CONSTANT NGVERBS 33> "Number of GAME-VERBS."

<CONSTANT GAME-VERBS
	  <PTABLE
	   V?INVENTORY V?STATUS V?TELL
	   V?SAVE V?RESTORE V?RESTART V?UNDO V?TIME V?SCORE V?DIAGNOSE
	   V?SCRIPT V?UNSCRIPT V?HELP V?MONITOR V?CASH
	   V?VERSION V?QUIT V?MODE V?SETTINGS V?DEFINE
	   V?VERBOSE V?BRIEF V?SUPER-BRIEF V?NOTIFY V?NAME
	   V?PRIORITY-ON V?PRIORITY-OFF V?ZOOM	
	   V?REFRESH V?COLOR V?$VERIFY V?SPELLS V?$CREDITS 
	   ; "V?$RECORD V?$UNRECORD V?$COMMAND V?$RANDOM V?$CHEAT V?$SUSS">>

"These verbs reverse the order of PRSO and PRSI."

<CONSTANT NR-VERBS 19>
<CONSTANT R-VERBS
	  <PTABLE V?STOUCH-TO V?SASK-FOR
		  V?SGIVE V?SSHOW V?SFEED V?SSELL-TO V?SBUY 
		  V?SHIT V?SPOINT-AT V?STHROW
		  V?SWRAP V?COVER V?DIG V?DIG-UNDER V?SDIG V?SLOOK-THRU
		  V?WEDGE V?SFIRE-AT V?SWING>>

<CONSTANT NHAVES 23> "Number of HAVEVERBS."

<CONSTANT HAVEVERBS
	<PTABLE V?DROP V?PUT V?PUT-ON V?GIVE V?SHOW V?FEED V?THROW V?HIT
		V?PUT-UNDER V?PUT-BEHIND V?THROW-OVER V?RELEASE
		V?TAKE-WITH V?TOUCH-TO V?OPEN V?OPEN-WITH V?CLOSE V?COVER
		V?ERASE-WITH V?POINT-AT V?SUBMERGE V?WIELD V?UNWIELD>>

<CONSTANT NTVERBS 17> "Number of TALKVERBS."

<CONSTANT TALKVERBS
	<PTABLE
	 V?TELL V?TELL-ABOUT V?ASK-ABOUT V?ASK-FOR V?WHAT V?WHERE V?WHO
	 V?ALARM V?HELLO V?GOODBYE V?SAY V?YELL V?THANK V?QUESTION V?REPLY
	 V?LAUGH V?REQUEST>>

<CONSTANT NTOUCHES 81> "Number of TOUCHVERBS"

<CONSTANT TOUCHVERBS
	<PTABLE
	 V?TAKE V?TAKE-OFF V?TAKE-WITH
	 V?PUT V?PUT-ON V?PUT-UNDER V?PUT-BEHIND
	 V?COVER V?EMPTY-INTO V?REACH-IN V?TOUCH-TO V?TOUCH V?HIT V?THRUST
	 V?PARRY V?PUNCH V?KICK V?MOVE V?PUSH V?PUSH-TO V?PUSH-UP V?PUSH-DOWN 
	 V?PULL V?LOWER V?RAISE V?LOOSEN V?TURN-TO V?ADJUST V?SPIN V?TURN
	 V?SHAKE V?SWING V?OPEN V?OPEN-WITH V?CLOSE V?LOCK V?UNLOCK
	 ; "V?SCREW V?UNSCREW" V?UPROOT
	 V?PLUG-IN V?UNPLUG V?TIE V?UNTIE V?FOLD V?LAMP-ON V?LAMP-OFF
	 V?WRAP-AROUND V?CUT V?RIP V?MUNG V?DIG V?DIG-UNDER
	 V?FILL V?FILL-FROM
	 V?DEFLATE V?BURN-WITH V?CLEAN V?CLEAN-OFF V?BLOW-INTO V?DETONATE
	 V?WIND V?REPAIR V?REPLACE V?PICK V?MELT V?SQUEEZE ; V?PLAY
	 ; "V?UNSCREW-FROM V?SCREW-WITH" V?GIVE V?FEED V?STAND-ON
	 V?SIT V?LIE-DOWN V?EAT V?BITE V?TASTE V?DRINK V?DRINK-FROM V?POP
	 V?CRANK V?SCRATCH V?SCRAPE-ON V?PEEL V?SUBMERGE>>

<CONSTANT NHVERBS 17> "Number of HURTVERBS."

<CONSTANT HURTVERBS
	<PTABLE
	 V?HIT V?PUNCH V?KICK V?MUNG V?KNOCK V?KICK V?SQUEEZE V?CUT
	 V?RIP V?BITE V?RAPE V?SHAKE V?UNDRESS V?DETONATE V?PUSH V?PUSH-TO
	 V?PULL>>

<CONSTANT NUMPUTS 10> "# PUTVERBS."

<CONSTANT PUTVERBS
	<PTABLE V?DROP V?PUT V?PUT-ON V?PUT-UNDER V?PUT-BEHIND V?THROW
	        V?THROW-OVER V?EMPTY V?EMPTY-INTO V?HANG-ON>>

<CONSTANT NMVERBS 28> "Number of MOVEVERBS."

<CONSTANT MOVEVERBS
	<PTABLE
	 V?TAKE V?TAKE-OFF V?MOVE V?PULL V?PUSH V?PUSH-TO V?PUSH-UP
	 V?PUSH-DOWN V?TURN V?RAISE V?UPROOT
	 V?LOWER V?SPIN V?SHAKE ; V?PLAY V?OPEN V?OPEN-WITH V?CLOSE V?ADJUST
	 V?TURN-TO V?POINT-AT V?SWING V?UNPLUG V?BOUNCE
	 V?PUT-UNDER V?PUT-BEHIND V?LOOK-UNDER V?LOOK-BEHIND V?CRANK>>

<CONSTANT NSVERBS 19> "Number of SEEVERBS"
<CONSTANT SEEVERBS
	  <PTABLE V?EXAMINE V?LOOK V?LOOK-INSIDE V?LOOK-ON V?READ V?FIND
		  V?SEARCH V?SHOW V?LOOK-UNDER V?LOOK-BEHIND V?LOOK-THRU 
		  V?LOOK-DOWN V?LOOK-UP V?READ-TO V?LOOK-OUTSIDE V?COUNT
		  V?ADJUST V?POINT V?EXAMINE-IN>>

<CONSTANT ENTER-VERBS 5>
<CONSTANT CLIMB-ON-VERBS 13>
<CONSTANT E-VERBS
	  <PTABLE V?WALK-TO V?ENTER V?THROUGH V?FOLLOW V?USE
		  V?CLIMB-ON V?CLIMB-UP V?CLIMB-OVER V?SIT V?RIDE
		  V?STAND-ON V?LIE-DOWN V?CROSS>>

<CONSTANT EXIT-VERBS 3>
<CONSTANT CLIMB-DOWN-VERBS 5>
<CONSTANT X-VERBS
	  <PTABLE V?EXIT V?LEAVE V?ESCAPE
		  V?CLIMB-DOWN V?LEAP>>

<CONSTANT D-N  #2 00000001>
<CONSTANT D-NE #2 00000010>
<CONSTANT D-E  #2 00000100>
<CONSTANT D-SE #2 00001000>
<CONSTANT D-S  #2 00010000>
<CONSTANT D-SW #2 00100000>
<CONSTANT D-W  #2 01000000>
<CONSTANT D-NW #2 10000000>

<CONSTANT DBIT-LIST
	  <PTABLE (BYTE) D-N D-NE D-E D-SE D-S D-SW D-W D-NW>>

<CONSTANT XD-N  #2 11111110>
<CONSTANT XD-NE #2 11111101>
<CONSTANT XD-E  #2 11111011>
<CONSTANT XD-SE #2 11110111>
<CONSTANT XD-S  #2 11101111>
<CONSTANT XD-SW #2 11011111>
<CONSTANT XD-W  #2 10111111>
<CONSTANT XD-NW #2 01111111>

<CONSTANT XDBIT-LIST
	  <PTABLE (BYTE) XD-N XD-NE XD-E XD-SE
		         XD-S XD-SW XD-W XD-NW
			 XD-N XD-NE XD-E XD-SE>>

<CONSTANT D-ALL 255>

<CONSTANT D-LEFT   %<+ ,D-N ,D-NE ,D-E ,D-SE ,D-S>>
<CONSTANT D-RIGHT  %<+ ,D-N ,D-S ,D-SW ,D-W ,D-NW>>
<CONSTANT D-TOP    %<+ ,D-E ,D-SE ,D-S ,D-SW ,D-W>>
<CONSTANT D-BOTTOM %<+ ,D-N ,D-NE ,D-E ,D-W ,D-NW>>

"Pure border data (copied into BORDERS)."

<CONSTANT DEFAULT-BORDERS
	  <PLTABLE (BYTE)
		   %<+ ,D-E ,D-SE ,D-S>
		   ,D-TOP ,D-TOP ,D-TOP ,D-TOP ,D-TOP
		   %<+ ,D-S ,D-SW ,D-W>
		   ,D-LEFT ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-RIGHT
		   ,D-LEFT ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-RIGHT
		   ,D-LEFT ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-RIGHT
		   ,D-LEFT ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-RIGHT
		   ,D-LEFT ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-ALL ,D-RIGHT
		   %<+ ,D-N ,D-NE ,D-E>
		   ,D-BOTTOM ,D-BOTTOM ,D-BOTTOM ,D-BOTTOM ,D-BOTTOM
		   %<+ ,D-N ,D-W ,D-NW>>>

<CONSTANT XLIST-NAMES
	  <PTABLE "N" "NE" "E" "SE" "S" "SW" "W" "NW"
		  "Up" "Down" "In" "Out">>

<CONSTANT NORMAL-DHEIGHT 9>

<CONSTANT XOFFS <PTABLE 0 1 1 1 0 -1 -1 -1>>
<CONSTANT YOFFS <PTABLE -1 -1 0 1 1 1 0 -1>>

<CONSTANT SHITCHARS
	  <PTABLE (BYTE) 124 47 45 92 124 47 45 92>>

<CONSTANT QDIRS <PTABLE (BYTE) 0 2 4 6 0>>
<CONSTANT ZDIRS <PTABLE (BYTE) 3 5 7 1 3 5>>

<CONSTANT SETOFFS
	  <PTABLE (BYTE) 4 4 3 3 8 0 2 19 19>>

<CONSTANT SNAMES
	  <PTABLE     " Display Mode "
		      " Descriptions "
		     " Transcripting "
		     " Status Notify "
		          " Map View "
		  " Display Priority "
		    " Combat Monitor "
		  " Restore Defaults "
		              " Exit ">>

"Character set data."

<CONSTANT QMARK 96>
<CONSTANT IQMARK 126>

<CONSTANT TRCORNER 71>
<CONSTANT BRCORNER 72>
<CONSTANT BLCORNER 73>
<CONSTANT TLCORNER 74>
<CONSTANT TOPEDGE 75>
<CONSTANT BOTEDGE 76>
<CONSTANT LEDGE 77>
<CONSTANT REDGE 78>

<CONSTANT RDIAG 35>
<CONSTANT LDIAG 36>
<CONSTANT SOLID 37>
<CONSTANT BOT 38>
<CONSTANT TOP 39>
<CONSTANT LSID 40>
<CONSTANT RSID 41>
<CONSTANT NCON 42>
<CONSTANT SCON 43>
<CONSTANT ECON 44>
<CONSTANT WCON 45>
<CONSTANT BLC 46>
<CONSTANT TLC 47>
<CONSTANT TRC 48>
<CONSTANT BRC 49>
<CONSTANT SWCON 50>
<CONSTANT NWCON 51>
<CONSTANT NECON 52>
<CONSTANT SECON 53>
<CONSTANT ISOLID 54>
<CONSTANT XCROSS 90>
<CONSTANT HVCROSS 91>

<CONSTANT UARROW 92>
<CONSTANT DARROW 93>
<CONSTANT UDARROW 94>

<CONSTANT SMBOX 95>

<CONSTANT MCHARS
	  <PTABLE (BYTE) LSID RDIAG BOT LDIAG LSID RDIAG BOT LDIAG>> 
<CONSTANT XCHARS
	  <PTABLE (BYTE) NCON NECON ECON SECON SCON SWCON WCON NWCON>>
<CONSTANT NXCHARS
	  <PTABLE (BYTE) TOP TRC LSID BRC BOT BLC RSID TLC>>

<CONSTANT IUARROW 123>
<CONSTANT IDARROW 124>
<CONSTANT IUDARROW 125>

<CONSTANT LCAP 88>
<CONSTANT RCAP 89>

<CONSTANT ENDURANCE 0>
<CONSTANT HP 0>
<CONSTANT STRENGTH 1>
<CONSTANT STR 1>
<CONSTANT DEXTERITY 2>
<CONSTANT DEX 2>
<CONSTANT INTELLIGENCE 3>
<CONSTANT IQ 3>
<CONSTANT COMPASSION 4>
<CONSTANT COM 4>
<CONSTANT LUCK 5>
<CONSTANT ARMOR-CLASS 6>
<CONSTANT AC 6>
<CONSTANT EXPERIENCE 7>
<CONSTANT EXP 7>

<CONSTANT NSTATS 8>    "Number of statistics."

<CONSTANT BEGINNERS-ENDURANCE 16>
<CONSTANT BEGINNERS-STRENGTH 8>
<CONSTANT BEGINNERS-DEXTERITY 8>
<CONSTANT BEGINNERS-INTELLIGENCE 8>
<CONSTANT BEGINNERS-COMPASSION 1>
<CONSTANT BEGINNERS-LUCK 25>
<CONSTANT NAKED-ARMOR-CLASS 1>
<CONSTANT BEGINNERS-EXPERIENCE 0>

<CONSTANT STATMAX 99> "High as any statistic can go."
<CONSTANT READING-IQ 40>

<CONSTANT WINNING-COMPASSION -45>

<CONSTANT DEFAULT-STATS 
	  <PTABLE ,BEGINNERS-ENDURANCE
	          ,BEGINNERS-STRENGTH
	          ,BEGINNERS-DEXTERITY
	          ,BEGINNERS-INTELLIGENCE
	          ,BEGINNERS-COMPASSION
	          ,BEGINNERS-LUCK
	          ,NAKED-ARMOR-CLASS
	          ,BEGINNERS-EXPERIENCE>>


<CONSTANT CNAME-LEN 7>
<CONSTANT BARMAR %<+ ,CNAME-LEN 3>>

<CONSTANT APPBOX 18> "Width of Apple stat box."

<CONSTANT CNAMES
	  <PTABLE "Lucky  "
		  "Tank   "
		  "Muscles"
		  "Nimble "
		  "Genius "
		  "Saint  " >>

<CONSTANT CSTATS
	  <PTABLE <PTABLE 16 8 8 8 1 25>
		  <PTABLE 30 16 8 1 1 10>
		  <PTABLE 18 20 18 4 1 5>
		  <PTABLE 12 14 20 4 1 15>
		  <PTABLE 12 10 8 16 5 15>
		  <PTABLE 12 10 8 8 16 12>
		  >>

<CONSTANT INIT-POTENTIAL 
	  <+ -6 ,BEGINNERS-LUCK ,BEGINNERS-COMPASSION
	        ,BEGINNERS-INTELLIGENCE ,BEGINNERS-DEXTERITY
		,BEGINNERS-STRENGTH ,BEGINNERS-ENDURANCE>>
<CONSTANT AVERAGE %</ ,INIT-POTENTIAL 6>>
<CONSTANT SPREAD %</ ,AVERAGE 2>>

<CONSTANT THRESHOLDS <PTABLE 9 29 59 99 149 209 279 359 449>>
<CONSTANT MAX-LEVEL 8>
<CONSTANT RANK-NAMES <PTABLE "Peasant" "Novice" "Cheater">>

; <CONSTANT SAVE-NAME <PLTABLE (STRING) "BEYONDZ">>

<CONSTANT CHARNAME-LENGTH 24>
<CONSTANT CHARNAME <ITABLE %<+ ,CHARNAME-LENGTH 1> (BYTE) 0>>

<CONSTANT NAMES-LENGTH 12>

<CONSTANT DEFAULT-NAME-LENGTH 13>
<CONSTANT DEFAULT-NAME
	  <PTABLE (STRING) 11 "Frank Booth" 0>>

<CONSTANT LABEL-WIDTH 12>
<CONSTANT BAR-LABELS
	  <PTABLE (STRING)
	     "   Endurance"
	     "    Strength"
	     "   Dexterity"
	     "Intelligence"
	     "  Compassion"
	     "        Luck"
	     " Armor Class">>

<CONSTANT STAT-NAMES
	  <PTABLE "endurance"
		  "strength"
		  "dexterity"
		  "intelligence"
		  "compassion"
		  "luck"
		  "armor class"
		  "experience">>

<CONSTANT BORDERS <ITABLE 50 (BYTE) 0>>
<CONSTANT MAZE-ROOMS <ITABLE 51 (BYTE) 0>>

<CONSTANT MOOR-ROOMS
	  <PLTABLE (BYTE) IN-GAS MOOR2 MOOR3 MOOR4 MOOR5 MOOR6>>

<CONSTANT CELLAR-ROOMS
	  <PLTABLE (BYTE) AT-STACK THRONE-ROOM AT-BOTTOM SKEL-ROOM
		   	  MOSS-ROOM WC1>>

<CONSTANT TOWER1-ROOMS 
	  <PLTABLE (BYTE) LEVEL1A LEVEL1B LEVEL1C LEVEL1D>>

<CONSTANT TOWER2-ROOMS
	  <PLTABLE (BYTE) LEVEL2A LEVEL2B LEVEL2C LEVEL2D>>

<CONSTANT TOWER3-ROOMS
	  <PLTABLE (BYTE) LEVEL3A LEVEL3B LEVEL3C LEVEL3D>>

<CONSTANT PLAIN-ROOMS 
	  <PLTABLE (BYTE) PLAIN0 PLAIN1 PLAIN2 PLAIN3 PLAIN4 PLAIN5>>

<CONSTANT INIT-STORM-TIMER 4>

<CONSTANT MIZNIA-ROOMS <PLTABLE (BYTE) IN-PORT IN-YARD SW-MOOR>>

<CONSTANT JUNGLE-ROOMS
	  <PLTABLE (BYTE)
		   JUN0 WORM-ROOM JUN2 JUN3 JUN4 JUN5 JUN6>>

<CONSTANT CAVE-ROOMS
	  <PLTABLE (BYTE)
		   CAVE0 CAVE1 CAVE2 CAVE3 CAVE4 CAVE6>>

<CONSTANT GRUE-SIGHTS
	  <LTABLE 2
	     "You sense a presence lurking in the darkness"
	     "A presence lurks in the darkness close at hand"
	     "Something is lurking in the darkness nearby">>

<CONSTANT MIRROR-LIFE 36>

<CONSTANT GRUE-ROOMS
	  <PLTABLE (BYTE)
		   CAVE0 CAVE1 CAVE2 CAVE3 CAVE4
		   CAVE6 CAVE7 SE-CAVE NE-CAVE IN-LAIR>>

<CONSTANT FOREST-ROOMS
	  <PLTABLE (BYTE)
		   TWILIGHT FOREST1 FOREST2 FOREST3
		   FOREST4 FOREST5 FOREST6>>

<CONSTANT RUIN-ROOMS
	  <PLTABLE (BYTE) RUIN0 RUIN1 RUIN2 RUIN3 RUIN4 RUIN5>>

<CONSTANT ACCARDI-ROOMS
	  <PLTABLE (BYTE) IN-ACCARDI AT-GATE IN-HALL IN-WEAPON>>

<CONSTANT SHORE-ROOMS
	  <PLTABLE (BYTE) AT-LEDGE AT-BRINE TOWER-BASE>>

<CONSTANT WAND-LIST
	  <LTABLE 0 WAND STAFF STAVE STICK ROD CANE>>

<VOC "ANNIHILATION" NOUN>
<VOC "SAYONARA" NOUN>
<VOC "ANESTHESIA" NOUN>
<VOC "EVERSION" NOUN>
<VOC "LEVITATION" NOUN>

<CONSTANT WAND-FUNCTIONS
	  <LTABLE 0
		  <PTABLE BLAST-WAND-F
			  DESCRIBE-BLAST-WAND
			  <VOC "ANNIHILATION" ADJ>>
		  <PTABLE TELE-WAND-F
			  DESCRIBE-TELE-WAND
			  <VOC "SAYONARA" ADJ>>
		  <PTABLE SLEEP-WAND-F
			  DESCRIBE-SLEEP-WAND
			  <VOC "ANESTHESIA" ADJ>>
		  <PTABLE IO-WAND-F
			  DESCRIBE-IO-WAND
			  <VOC "EVERSION" ADJ>>
		  <PTABLE LEV-WAND-F
			  DESCRIBE-LEV-WAND
			  <VOC "LEVITATION" ADJ>>>>

<CONSTANT POTION-LIST
	  <LTABLE 0 APOTION BPOTION CPOTION DPOTION EPOTION>>

<VOC "ENLIGHTENMENT" NOUN>
<VOC "HEALING" NOUN>
<VOC "DEATH" NOUN>
<VOC "MIGHT" NOUN>
<VOC "FORGETFUL" NOUN>

<CONSTANT POTION-TABLES
	  <LTABLE 0
	     <PTABLE IQ-POTION-F
		     DESCRIBE-IQ-POTION
		     <VOC "ENLIGHTENMENT" ADJ>>
	     <PTABLE HEALING-POTION-F
		     DESCRIBE-HEALING-POTION
		     <VOC "HEALING" ADJ>>
	     <PTABLE DEATH-POTION-F
		     DESCRIBE-DEATH-POTION
		     <VOC "DEATH" ADJ>>
	     <PTABLE MIGHT-POTION-F
		     DESCRIBE-MIGHT-POTION
		     <VOC "MIGHT" ADJ>>
	     <PTABLE FORGET-POTION-F
		     DESCRIBE-FORGET-POTION
		     <VOC "FORGETFUL" ADJ>>>>

<CONSTANT ALL-SCROLLS
	  <PLTABLE PARCHMENT GILT SMOOTH RUMPLE VELLUM
		   PALIMP RENEWAL>>

<CONSTANT SCROLL-LIST
	  <LTABLE 0 PARCHMENT GILT SMOOTH RUMPLE VELLUM>>

<VOC "MISCHIEF" NOUN>
<VOC "HONING" NOUN>
<VOC "PROTECTION" NOUN>
<VOC "FIREWORKS" NOUN>
<VOC "RECALL" NOUN>

<CONSTANT SCROLL-FUNCTIONS
	  <LTABLE 0
	     <PTABLE DO-PARTAY
		     DESCRIBE-DO-PARTAY
		     <VOC "MISCHIEF" ADJ>
		     "yard improvements"
		     1
		     8>
	     <PTABLE DO-BLESS-WEAPON
		     DESCRIBE-BLESS-WEAPON
		     <VOC "HONING" ADJ>
		     "weaponry"
		     5
		     16>
	     <PTABLE DO-BLESS-ARMOR
		     DESCRIBE-BLESS-ARMOR
		     <VOC "PROTECTION" ADJ>
		     "armor"
		     5
		     16>
	     <PTABLE DO-FILFRE
		     DESCRIBE-DO-FILFRE
		     <VOC "FIREWORKS" ADJ>
		     "humility and self-effacement"
		     1
		     8>
	     <PTABLE DO-GOTO
		     DESCRIBE-DO-GOTO
		     <VOC "RECALL" ADJ>
		     "transportation"
		     5
		     24>>>

<CONSTANT TELEROOMS
	  <PLTABLE (BYTE)
		   HILLTOP AT-BROOK IN-PORT N-MOOR XROADS NFORD SFORD
		   NGURTH IN-THRIFF>>

<CONSTANT OVERS
	  <LTABLE "Ruins" "Bridge" "Forest" "Town"
		  "City" "Seashore" "Roadway"
		  "Fields" "Village" "Castle" "Mist"
		  "Jungle" "Seaport" "Mountainside">>

<CONSTANT HIGHEST-ZBOT 16384>

<CONSTANT ORUINS 1>
<CONSTANT OBRIDGE 2>
<CONSTANT OFOREST 3>
<CONSTANT OACCARDI 4>
<CONSTANT OCITY 5>
<CONSTANT OSHORE 6>
<CONSTANT OXROADS 7>
<CONSTANT OPLAIN 8>
<CONSTANT OGRUBBO 9>
<CONSTANT OCAVES 10>
<CONSTANT OMOOR 11>
<CONSTANT OJUNGLE 12>
<CONSTANT OMIZNIA 13>
<CONSTANT OTHRIFF 14>

<CONSTANT FLY-TABLES
	  <PLTABLE
       ; 1 <PTABLE (BYTE) %<+ ,D-SE ,D-SW>
			   OACCARDI OBRIDGE>
       ; 2 <PTABLE (BYTE) %<+ ,D-NE ,D-SE ,D-SW>
			   ORUINS OSHORE OFOREST>
       ; 3 <PTABLE (BYTE) %<+ ,D-NE ,D-E ,D-S>
			  OBRIDGE OACCARDI OCITY>
       ; 4 <PTABLE (BYTE) %<+ ,D-S ,D-SW ,D-W ,D-NW>
			  OSHORE OXROADS OFOREST ORUINS>
       ; 5 <PTABLE (BYTE) %<+ ,D-N ,D-E ,D-SE ,D-S>
			  OFOREST OSHORE OPLAIN OXROADS>
       ; 6 <PTABLE (BYTE) %<+ ,D-N ,D-S ,D-SW ,D-W ,D-NW>
			  OACCARDI OGRUBBO OPLAIN OCITY OBRIDGE>
       ; 7 <PTABLE (BYTE) %<+ ,D-N ,D-NE ,D-E ,D-SE ,D-SW>
			  OCITY OACCARDI OPLAIN OMIZNIA OCAVES>
       ; 8 <PTABLE (BYTE) %<+ ,D-NE ,D-E ,D-SE ,D-S ,D-W ,D-NW>
		   	  OSHORE OGRUBBO OMOOR
			  OMIZNIA OXROADS OCITY>
       ; 9 <PTABLE (BYTE) %<+ ,D-N ,D-S ,D-SW ,D-W>
			  OSHORE OMOOR OJUNGLE OPLAIN>
      ; 10 <PTABLE (BYTE) %<+ ,D-NE ,D-SE>
			  OXROADS OTHRIFF>
      ; 11 <PTABLE (BYTE) %<+ ,D-N ,D-SW ,D-NW>
			  OGRUBBO OMIZNIA OPLAIN>
      ; 12 <PTABLE (BYTE) %<+ ,D-NE ,D-E ,D-SW>
		   	  OGRUBBO OMIZNIA OTHRIFF>
      ; 13 <PTABLE (BYTE) %<+ ,D-N ,D-NE ,D-W ,D-NW>
		   	  OPLAIN OMOOR OJUNGLE OXROADS>
      ; 14 <PTABLE (BYTE) %<+ ,D-NE ,D-NW>
			  OJUNGLE OCAVES>
       >>

<CONSTANT PICT-LIST
	  <PTABLE G-EYE G-EAR G-NOSE G-MOUTH G-HAND G-CLOCK>>

<CONSTANT GURDY-EFFECTS
	  <PTABLE "wraith of colored light"
		  "brief chord of music"
		  "whiff of random odors"
		  "puff of tasty flavors"
		  "vague itchiness"
		  "strange sense of urgency">>

<CONSTANT GURDY-PEEKS
	  <PTABLE "eyes sting"
		  "ears ring"
		  "nose tickle"
		  "mouth water"
		  "skin crawl"
		  "pulse race">>

<CONSTANT Q-BUZZES
	  <PLTABLE <VOC "WHY" <>> <VOC "HOW" <>>
		   <VOC "WHEN" <>> <VOC "WOULD" <>>
		   <VOC "COULD" <>> <VOC "SHOULD" <>>
		   <VOC "HAS" <>> <VOC "AM" <>> <VOC "IS" <>>
		   <VOC "WAS" <>> >>

<CONSTANT N-BUZZES
	  <PLTABLE <VOC "ZERO" <>> <VOC "ONE" <>> <VOC "TWO" <>>
		   <VOC "THREE" <>> <VOC "FOUR" <>> <VOC "FIVE" <>>
		   <VOC "SIX" <>> <VOC "SEVEN" <>> <VOC "EIGHT" <>>
		   <VOC "NINE" <>> <VOC "TEN" <>>>>

<CONSTANT SWEAR-WORDS
	  <PLTABLE <VOC "CURSE" <>> <VOC "GODDAMNED" <>> <VOC "CUSS" <>>
		   <VOC "DAMN" <>> <VOC "FUCK" <>>
		   <VOC "SHITHEAD" <>> <VOC "BASTARD" <>> <VOC "ASS" <>>
		   <VOC "FUCKING" <>> <VOC "BITCH" <>> <VOC "DAMNED" <>>
		   <VOC "COCKSUCKER" <>> <VOC "FUCKED" <>> <VOC "PEE" <>>
		   <VOC "CUNT" <>> <VOC "ASSHOLE" <>> <VOC "PISS" <>>
		 ; <VOC "SUCK" <>> <VOC "SHIT" <>> <VOC "CRAP" <>> >>

<CONSTANT COLOR-WORDS
	  <PLTABLE <VOC "MAUVE" <>> <VOC "LAVENDER" <>> <VOC "PUCE" <>>
		   <VOC "RED" ADJ> <VOC "SILVER" <>>
		   <VOC "GOLD" <>> <VOC "ORANGE" ADJ> <VOC "YELLOW" ADJ> >>

<CONSTANT NO-MIRROR -1>

<CONSTANT PILLAR-DOINGS
	  <LTABLE 2 
	     " wiggles its antennae"		     
	     " looks up at you inquisitively"
	     " arches its back">>

<CONSTANT PILLAR-MOVES
	  <LTABLE 2 
	     " silently explores "
	     " crawls across "
	     " wiggles its way around ">>

<CONSTANT BFLY-EATINGS
	  <LTABLE 2 
	     " explores the rim of the goblet"
	     " slowly opens and closes its wings"
	     " wiggles its antennae">>

<CONSTANT BFLY-DOINGS
	  <LTABLE 2 
	     " darts around your head"
	     " lights on your nose, then flutters off"
	     " lands on your hand, then darts away">>

<CONSTANT BFLY-HOVERS
	  <LTABLE 2
	     " hovers around "
	     " seems interested in "
	     " is fluttering close to ">>

<CONSTANT REACH-TABLES
	  <PTABLE
	   <PLTABLE (BYTE) 1 3>
	   <PLTABLE (BYTE) 0 2 3 5>
	   <PLTABLE (BYTE) 1 5>
	   <PLTABLE (BYTE) 0 1 6 7>
	   <PLTABLE (BYTE) 0 1 2 3 5 6 7 8>
	   <PLTABLE (BYTE) 1 2 7 8>>>

<CONSTANT MIRROR-LIST
	  <PLTABLE MIRROR0 MIRROR1 MIRROR2 MIRROR3 MIRROR4
		   MIRROR5 MIRROR6>>

<CONSTANT AMB 255>

; "Removed per TAA.  No longer used for direction lookup with mouse."
;<CONSTANT COMPASS
	  <PTABLE (BYTE)
I-NW I-NW I-NW I-NW I-NW I-NW AMB I-NORTH I-NORTH I-NORTH I-NORTH I-NORTH AMB I-NE I-NE I-NE I-NE I-NE
AMB AMB I-NW I-NW I-NW I-NW I-NW AMB I-NORTH I-NORTH I-NORTH AMB I-NE I-NE I-NE I-NE I-NE AMB
AMB AMB AMB AMB AMB I-NW I-NW I-NW I-NORTH I-NORTH I-NORTH I-NE I-NE I-NE AMB AMB AMB AMB
I-WEST I-WEST I-WEST I-WEST AMB AMB I-NW I-NW AMB I-NORTH AMB I-NE I-NE AMB AMB I-EAST I-EAST I-EAST
I-WEST I-WEST I-WEST I-WEST I-WEST I-WEST I-WEST AMB I-NW I-NORTH I-NE AMB I-EAST I-EAST I-EAST I-EAST I-EAST I-EAST
I-WEST I-WEST I-WEST I-WEST I-WEST I-WEST I-WEST I-WEST I-WEST AMB I-EAST I-EAST I-EAST I-EAST I-EAST I-EAST I-EAST I-EAST
I-WEST I-WEST I-WEST I-WEST I-WEST I-WEST I-WEST AMB I-SW I-SOUTH I-SE AMB I-EAST I-EAST I-EAST I-EAST I-EAST I-EAST
I-WEST I-WEST I-WEST I-WEST AMB AMB I-SW I-SW AMB I-SOUTH AMB I-SE I-SE AMB AMB I-EAST I-EAST I-EAST
AMB AMB AMB AMB AMB I-SW I-SW I-SW I-SOUTH I-SOUTH I-SOUTH I-SE I-SE I-SE AMB AMB AMB AMB 
AMB AMB I-SW I-SW I-SW I-SW I-SW AMB I-SOUTH I-SOUTH I-SOUTH AMB I-SE I-SE I-SE I-SE I-SE AMB
I-SW I-SW I-SW I-SW I-SW I-SW AMB I-SOUTH I-SOUTH I-SOUTH I-SOUTH I-SOUTH AMB I-SE I-SE I-SE I-SE I-SE
I-SW I-SW I-SW I-SW I-SW AMB AMB I-SOUTH I-SOUTH I-SOUTH I-SOUTH I-SOUTH AMB AMB I-SE I-SE I-SE I-SE >>


; <CONSTANT DORN-SOUNDS
	  <LTABLE 2
	     "Far overhead, you hear something bellow \"Hurumph!\""
	     "\"Hurumph!\" bellows a distant voice."
	     "A loud \"Hurumph!\" echoes in the lighthouse.">>

; <CONSTANT CLOSE-DORNS
	  <LTABLE 2
	     "Close at hand, you hear something bellow \"Hurumph!\""
	     "\"Hurumph!\" bellows a nearby voice."
	     "A loud \"Hurumph!\" echoes in the lighthouse.">>

<CONSTANT TREE-DOINGS
	  <LTABLE 2
	     " whisper among themselves"
	     " shuffle around uncertainly"
	     " seem to be regrouping">>

<CONSTANT SAD-TREES
	  <LTABLE 2
	     " shuffle around disconsolately"
	     " sing carols of mourning"
	     " shake their ornaments with frustration">>

<CONSTANT HUNTER-DOINGS
	  <LTABLE 2
	     " skulk about the pasture's edge"
	     " shout something incoherent"
	     " call out to one another">>

<CONSTANT MINX-DOINGS
	  <LTABLE 2
	     " rubs up against your leg"
	     " mews sweetly"
	     " plays at your feet"
	     " looks up at you and mews">>

<CONSTANT DARK-MINXES
	  <LTABLE 2
	     " rubs up against your leg"
	     " is moving about your feet"
	     " purrs in the darkness">>

<CONSTANT MINX-SETTLES
	  <LTABLE 2
	     " settles comfortably"
	     " purrs and nudges about"
	     " squirms around">>

<CONSTANT MINX-RESTLESS
	  <LTABLE 2
	     " is acting a bit restless"
	     " shifts its position in your arms"
	     " fidgets about uncomfortably">> 

<CONSTANT MINX-SLEEPS
	  <LTABLE 2
	     " snores gently"
	     " fidgets in its sleep"
	     " yawns without waking up">>

<CONSTANT MINX-NERVES
	  <LTABLE 2
	     " fidgets nervously"
	     " whimpers with fear"
	     " mews anxiously">>

<CONSTANT ARCH-SNIFFS
	  <LTABLE 2
	     " sniffs the ground suspiciously"
	     " whines anxiously, pawing at the ground"
	     " is snuffling around underfoot">>

<CONSTANT CORBIE-SOUNDS
	  <LTABLE 2 "screech" "squawk" "croak">>

<CONSTANT FEAR-CORBIES
	  <LTABLE 2 "fear" "anxiety" "terror">>

<CONSTANT MAD-CORBIES
	  <LTABLE 2 "anger" "rage" "fury">>

<CONSTANT SICK-DACT
	  <LTABLE 2
	     " snaps at you with its beak"
	     " screeches pitifully"
	     " flutters its good wing back and forth"
	     " cries out with pain"
	     " limps about in a helpless circle">>

<CONSTANT HAPPY-DACT
	  <LTABLE 2
	     " scratches the ground with its claws"
	     " emits a dry croak of contentment"
	     " watches you with a sharp, beady eye"
	     " screeches at the sky"
	     " flutters about restlessly">>

<CONSTANT DACT-WAITS
	  <LTABLE 2
	     " eyeing you expectantly"
	     " sharpening its beak"
	     " fluttering its wings">>

<CONSTANT FLYING-DACT
	  <LTABLE 2
	     " peers at the ground below"
	     " circles patiently"
	     " beats its powerful wings"
	     " turns to look at you">>

<CONSTANT TORTURES
	  <LTABLE 2 
"your mouth gags with the taste of orcish nightsoil"
"the stench of burning fish cakes makes you stagger"
"hundreds of imaginary spiders crawl across your skin"
"a syrupy arrangement of \"Born in the GUE\" pounds in your ears"
"the raw glare of a disco strobe sends you reeling">>

<CONSTANT MAMA-CLIMBS
	  <LTABLE 2
" tries to climb higher, but can't quite manage it"
" snorts at you angrily, trying to climb higher"
" angrily paws the bottom of the maw">>

<CONSTANT CLERIC-WOES
	  <LTABLE 2 
	     "Woe! Woe is us"
	     "Who will save us? O woe"
	     "O woe is us, woe"
	     "Will no one answer our prayers? Woe">>

<CONSTANT MAGIC-WORDS
	  <LTABLE 0
	     <TABLE <VOC "SMEE" NOUN> <PLTABLE (STRING) "Smee"> 0>
	     <TABLE <VOC "YABBA" NOUN> <PLTABLE (STRING) "Yabba"> 0>
	     <TABLE <VOC "BOK" NOUN> <PLTABLE (STRING) "Bok"> 0>
	     <TABLE <VOC "SQUIRP" NOUN> <PLTABLE (STRING) "Squirp"> 0>
	     <TABLE <VOC "STELLA" NOUN> <PLTABLE (STRING) "Stella"> 0>
	     <TABLE <VOC "BLARN" NOUN> <PLTABLE (STRING) "Blarn"> 0>
	     <TABLE <VOC "PROSSER" NOUN> <PLTABLE (STRING) "Prosser"> 0>
	     <TABLE <VOC "YQUEM" NOUN> <PLTABLE (STRING) "Yquem"> 0>
	     <TABLE <VOC "WATKIN" NOUN> <PLTABLE (STRING) "Watkin"> 0>
	     <TABLE <VOC "JUKES" NOUN> <PLTABLE (STRING) "Jukes"> 0>
	     <TABLE <VOC "MACUGA" NOUN> <PLTABLE (STRING) "Macuga"> 0>>>

<CONSTANT SCARE-COLORS <LTABLE 0 W?PUCE W?LAVENDER W?MAUVE>>

<CONSTANT SHYNESS
	  <LTABLE 2
	     " hobbles out of your reach"
	     " backs away from you"
	     " won't let you near">>

<CONSTANT CAROLS
	  <LTABLE 2
	     "Plover the River and Frotz the Woods"
	     "Winter Bozbarland"
	     "Dwaarnyn the Dark-Nosed Ur-Grue"
	     "I'm Dreaming of a Black Cavern"
	     "Good King Flathead"
	     "Dornbeasts Roasting on an Open Fire" >>

<CONSTANT HOW-SINGS
	  <LTABLE 2
		  " sing a few verses of \""
		  " hum the chorus from \""
		  " begin crooning \"">>

<CONSTANT XTREE-DOINGS
	  <LTABLE 2
		  " blink their lights"
		  " whisper among themselves"
		  " swish their tinsel"
		  " rattle their ornaments">>		  

<CONSTANT COOK-DOINGS
	  <LTABLE 2
		  " does his best to ignore you"
		  " busies himself around the kitchen"
		  " glances up at you and scowls"
		  " bustles around the room">>

<CONSTANT MAGIC-ITEMS
	  <PLTABLE STAFF CANE WAND ROD STICK STAVE
		   RENEWAL PARCHMENT VELLUM SMOOTH RUMPLE GILT
		   APOTION BPOTION CPOTION DPOTION EPOTION
		   RFOOT CLOVER SHOE
		   AMULET GOBLET VIAL
		   SCABBARD COCO ROOT RING STONE UHEMI LHEMI DIARY
		   PALIMP CHEST PHASE JAR CIRCLET GLASS
		   HELM GURDY SPENSE ROSE CLOAK WHISTLE >>

<CONSTANT WEAPON-ITEMS
	  <PLTABLE SWORD SHILL AXE DAGGER ARROW>>

<CONSTANT ARMOR-ITEMS
	  <PLTABLE CLOAK TUNIC SCALE CHAIN PLATE HELM PACK SCABBARD>>

<CONSTANT LIGHT-SOURCES <PLTABLE AMULET LANTERN>>

<CONSTANT WIND-ALERTS
	  <LTABLE 2 "You feel the wind changing direction"
		    "The wind changes direction again"
		    "A fresh wind blows from a new direction">>

<CONSTANT STORAGE-SPACE 1024>
<CONSTANT FREE-STORAGE <ITABLE ,STORAGE-SPACE (BYTE) 0>>

<CONSTANT PRESENT 6>
<CONSTANT MAX-ATIME 11>

<CONSTANT ARCH-ROOMS
	  <TABLE (BYTE)
		  ARCH-VOID ARCH1 ARCH2 ARCH3 ARCH4 ARCH5 0
		  ARCH9 ARCH10 ARCH11 ARCH12 ARCH-VOID>>

<CONSTANT DORN-MISSES
	  <LTABLE 2
		  " moves its deadly gaze across the room"
		  " tries to lock eyes with yours"
		  " scans the room with its deadly gaze"
		  " almost stares you down">>

<CONSTANT DORN-HITS
	  <LTABLE 2
		  " fixes its deadly gaze upon you"
		  "'s eyes meet yours"
		  " locks its eyes onto your face"
		  "'s gaze stops you cold">>

<CONSTANT DORN-ROOMS
	  <PLTABLE (BYTE) TOWER-TOP LEVEL3A LEVEL3B LEVEL3C LEVEL3D>>

<CONSTANT PUPP-DOINGS
	  <LTABLE 2
	     "making faces at you"
	     "hurling insults at you"
	     "reciting libelous rhymes about your personal life"
	     "spreading rumors about you"
	     "accusing you of shocking indiscretions"
	     "taunting you">>

<CONSTANT PUPP-MISSES
	  <LTABLE 2
	     " swings back and forth in its tree"
	     " pauses to think of another insult"
	     " dodges behind a tree trunk"
	     " stops to chuckle at its own cleverness">>

<CONSTANT PUPP-HITS
	  <LTABLE 2
" twists its body into an unflattering parody of your own"
" recites your nightly personal habits in excruciating detail"
" mirrors the expression on your face with infuriating accuracy"
" accuses your mother of shocking improprieties"
" reminds you how much weight you've gained lately, and where">>

<CONSTANT STRANGLES
	  <LTABLE 2
	     "The bony fingers close tighter around your throat"
	     "You gasp for breath as the skeleton throttles your neck"
	     "The skeleton grins with menace as its fingers close tighter">>

<CONSTANT S-LADDER 0>
<CONSTANT S-CAT 1>
<CONSTANT S-13 2>
<CONSTANT S-UMBRELLA 3>

<CONSTANT SUCKER-TYPES <LTABLE 0 S-LADDER S-CAT S-13 S-UMBRELLA>>

<CONSTANT SUCKER-NAMES
	  <PTABLE "stepladder"
		  "black cat"
		  "giant number 13"
		  "spinning umbrella">>

<CONSTANT SUCKER-SYNS-A
	  <PTABLE <VOC "LADDER" NOUN>
		  <VOC "CAT" NOUN>
		  <VOC "THIRTEEN" NOUN>
		  <VOC "UMBRELLA" NOUN>>>

<CONSTANT SUCKER-SYNS-B
	  <PTABLE <VOC "STEPLADDER" NOUN>
		  <VOC "KITTY" NOUN>
		  <VOC "INTNUM" NOUN>
		  <VOC "BROLLY" NOUN>>>

<CONSTANT SUCKER-ADJS
	  <PTABLE <VOC "STEP" ADJ>
		  <VOC "KITTY" ADJ>
		  <VOC "NUMBER" ADJ>
		  <VOC "SPINNING" ADJ>>>

<CONSTANT SUCKER-SMASHES
	  <PTABLE
" pirouettes across the chamber, grazing the mirror"
" yowls playfully, leaps high and rakes its claws across the mirror"
" studies itself in the mirror, frowns, and jabs at it angrily"
"'s point nudges against the mirror">>

<CONSTANT SUCKER-HITS
    <PTABLE
       <LTABLE 2
	  " opens its legs wide, and steps right over you"
	  " does a somersault over your head"
	  " leaps over your head">
       <LTABLE 2
	  " marches back and forth in front of you"
	  " places itself directly in your path"
	  " slinks to and fro before you">
       <LTABLE 2
	  " points to itself, then at you"
	  " stares you right in the face"
	  " waves at you grimly">
       <LTABLE 2
	  " slowly opens, then snaps itself shut"
	  " snaps itself open, then slowly closes"
	  " opens itself as wide as possible">>>

<CONSTANT SUCKER-MISSES
    <PTABLE
       <LTABLE 2
	  " clumps around the passage"
	  " twirls on one leg"
	  " tries to step over you">
       <LTABLE 2
	  " races around the chamber"
	  " tries to cross your path"
	  " slinks along the edge of the passage">
       <LTABLE 2
	  " slides closer to you"
	  " does its best to keep your attention"
	  " tries to block the passage">
       <LTABLE 2
	  " whacks the wall trying to open itself"
	  " whirls towards the center of the passage"
	  " stops moving, then spins the other way">>>

<CONSTANT SUCKER-STALKS
	  <LTABLE 2 "brushes past" "is stalking" "circles around">>

<CONSTANT LUCKY-OBJECTS
	  <PLTABLE RFOOT CLOVER SHOE>>

<CONSTANT EMPTY-WANDS
	  <LTABLE 2 
		  " sputters uselessly"
		  " emits a few feeble sparks"
		  " coughs impotently">>

<CONSTANT NO-SLEEPS
	  <PLTABLE DUST CRAB VAPOR DEAD SKELETON
		   ASUCKER BSUCKER CSUCKER>>

<CONSTANT OFFERS
	  <LTABLE 2 "Yours for only "
		    "A rare bargain at "
		    "I'd part with it for "
		    "For you, just ">>

<CONSTANT USED-OFFERS
	  <LTABLE 2 "This used one's worth "
		    "Used, it's worth about "
		    "A used one like this goes for ">>

<CONSTANT JUNGLE-DESCS
	  <LTABLE 0
	     <PTABLE DESCRIBE-JD0 JD0-F>
	     <PTABLE DESCRIBE-JD1 JD1-F>
	     <PTABLE DESCRIBE-JD2 JD2-F>
	     <PTABLE DESCRIBE-JD3 JD3-F>>>

<CONSTANT CITY-ENTRIES 
	  <LTABLE 2 
		  "The peace of the countryside is shattered"
		  "Decrepit buildings close in on every side"
		  "The road becomes noisy and crowded">>

<CONSTANT FOREST-DESCS
	  <LTABLE 0
	     <PTABLE DESCRIBE-F1 F1-F>
	     <PTABLE DESCRIBE-F2 F2-F>
	     <PTABLE DESCRIBE-F3 F3-F>
	     <PTABLE DESCRIBE-F4 F4-F>
	     <PTABLE DESCRIBE-F5 F5-F>
	     <PTABLE DESCRIBE-F6 F6-F>>>

<CONSTANT RUIN-DESCS
	  <LTABLE 0
	     <PTABLE DESCRIBE-RD0 RD0-F>
	     <PTABLE DESCRIBE-RD1 RD1-F>
	     <PTABLE DESCRIBE-RD2 RD2-F>
	     <PTABLE DESCRIBE-RD3 RD3-F>
	     <PTABLE DESCRIBE-RD4 RD4-F>>>

<CONSTANT BRIDGE-TYPES
	  <LTABLE 2
	     "Clammy mist obscures your view of either end"
	     "Your ears ring from the roar of water far below"
	     "Both edges of the chasm are obscured in the clammy mist"
	     "The deafening roar of water is giving you a headache">>

<CONSTANT NOPEELS <PLTABLE CLERIC OWOMAN SALT COOK>>

<CONSTANT FULL 5>

<CONSTANT SUSS-WIDTH 18>
<CONSTANT SUSS-HEIGHT 5>
<CONSTANT SUSSY 7>
<CONSTANT SUSS-STATS <PTABLE (BYTE) P?ENDURANCE P?STRENGTH P?DEXTERITY>>

<CONSTANT AH-YESSES
	  <LTABLE 2 
		  "Ah, yes! A " 
		  "That's a "
		  "A "
		  "Your basic "
		  "Behold! A "
		  "This is a ">>

<CONSTANT MENU-LIST
	  <PTABLE " Begin using a preset character    "
		  " Select a preset character         "
		  " Randomly generate a new character "
		  " Create your own character         "
		  " Quit ">>

<CONSTANT SALT-DABS
	  <LTABLE 2
		  " dabs a bit more paint onto the canvas"
		  " eyes his work critically"
		  " touches up a spot on his painting"
		  " pauses to squint at his handiwork">>

<CONSTANT DARK-WALKS
	  <LTABLE 2
		  "stumble blindly ahead"
		  "inch forward one step at a time"
		  "feel your way onward">>

<CONSTANT OWOMAN-SNORTS 
	  <LTABLE 2 "sniff" "laugh" "observe" "chuckle" "mutter">>

<CONSTANT DARK-MOVINGS 
	  <LTABLE 2 
		  "You hear something move"
		  "Something is moving around"
		  "You hear a movement"
		  "Something moves">>

<CONSTANT URGRUE-GREETS 
	  <LTABLE 2
		  "Welcome back"
		  "Still alive? Impressive"
		  "How nice of you to return">>

<CONSTANT URGRUE-BYES
	  <LTABLE 2 
		  "You'll be back,"
		  "Leaving so soon?"
		  "Do drop in again,">>

<CONSTANT CHARLIST
	  <PLTABLE CONGREG BABY MAMA MINX DACT CLERIC UNICORN
		   MAYOR HUNTER CONDUCTOR SALT COOK OWOMAN>>

<CONSTANT BUNNY-SPLITS
	  <LTABLE 2 " divide once again"
		    " are still dividing"
		    " have divided once again"
		    " continue to divide">>

<CONSTANT OWOMAN-MOVES 
	  <LTABLE 2
		  " dusts off the items in "
		  " putters around behind "
		  " polishes the top of "
		  " leans against ">>

<CONSTANT BANDIT-MUTTERS
	  <LTABLE 2
	      "The bandits chuckle among themselves"
	      "\"Har!\" shouts a bandit, for no apparent reason"
	      "One of the bandits winks at you">>
	      
<CONSTANT OWOMAN-EYES
	  <LTABLE 2 
	     "eyeing you curiously"
	     "keeping an eye on you"
	     "watching every move you make">>

<CONSTANT OUCHES
	  <LTABLE 2 "Yow" "Ouch" "Oof">>

<CONSTANT CRAB-ATTACKS
	  <LTABLE 2 " closes in with its pincers"
		    " gives you a nasty pinch"
		    "'s pincers close in again"
		    " pinches you hard">>

<CONSTANT CRAB-MISSES
	  <LTABLE 2
		  "'s pincers barely miss your leg"
		  " misses you again, but just barely"
		  " feints sideways, pincers snapping"
		  " barely misses you again"
		  " snaps out with its pincers, just missing you"  
		  " strikes out at you, but misses"
		  " poises itself for another strike" >>

<CONSTANT RAT-ATTACKS
	  <LTABLE 2 " closes in with its sharp teeth"
		    " gives you a nasty bite"
		    "'s teeth close in again"
		    " bites you hard">>

<CONSTANT RAT-MISSES
	  <LTABLE 2
		  "'s teeth barely miss your ankle"
		  " misses you again, but just barely"
		  " feints to one side, teeth snapping"
		  " barely misses you again"
		  " swipes out with its claws, just missing you"  
		  " strikes out at you, but misses"
		  " poises itself for another strike" >>

<CONSTANT SNIPE-HITS
	  <LTABLE 2 " closes in with its sharp beak"
		    " gives you a nasty peck"
		    "'s beak closes in again"
		    " pecks you hard">>

<CONSTANT SNIPE-MISSES
	  <LTABLE 2
		  "'s beak barely misses your eye"
		  " misses you again, but just barely"
		  " feints to one side, eyes flashing"
		  " barely misses you again"
		  " swipes out with its beak, just missing you"  
		  " strikes out at you, but misses"
		  " poises itself for another strike" >>

<CONSTANT VAPOR-DOINGS
	  <LTABLE 2
	     " whispers an obscene secret in your ear"
	     " giggles insanely"
	     " darts around your head, just out of reach">>

<CONSTANT VAPOR-LAUGHS
	  <LTABLE 2
	     "Giggling with glee"
	     "Cackling with mischief"
	     "Sniggering maliciously">>

<CONSTANT VAPOR-TICKLES 
	  <LTABLE 2
	     " tickles you in a sensitive place"
	     " pokes you where you ought not to be poked"
	     " infiltrates your naughty bits">>

<CONSTANT VAPOR-SNEERS
	  <LTABLE 2
	     "Boo"
	     "Nyeah, nyeah"
	     "Cootchy-cootchy-coo"
	     "Woo-woo-woo"
	     "Nyuk, nyuk, nyuk">>

<CONSTANT SPIDER-HITS
	  <LTABLE 2 " closes in with its mandibles"
		    " gives you a nasty sting"
		    "'s mandibles close in again"
		    " stings you hard">>

<CONSTANT SPIDER-MISSES
	  <LTABLE 2
		  " tries to grab you with its mandibles"
		  " misses you again, but just barely"
		  " feints to one side, mandibles ready"
		  " barely misses you again"
		  " reaches out with its mandibles, just missing you"  
		  " strikes out at you, but misses"
		  " poises itself for another strike" >>

<CONSTANT SLUG-HITS
	  <LTABLE 2 " squirts vile ichors at you"
		    " gives you a nasty squirt"
		    "'s squirt glands score a direct hit"
		    " squirts you again">>

<CONSTANT SLUG-MISSES
	  <LTABLE 2
		  " tries to squirt you with vile ichors"
		  " poises itself for another squirt"
		  " misses you again, but just barely"
		  " feints to one side, squirt glands at the ready"
		  " barely misses you again"
		  " squirts out again, just missing you"  >>

<CONSTANT WORM-HITS
	  <LTABLE 2 " closes in with its fangs"
		    " gives you a nasty bite"
		    "'s fangs close in again"
		    " strikes you hard">>

<CONSTANT WORM-MISSES
	  <LTABLE 2
		  " tries to impale you with its fangs"
		  " misses you again, but just barely"
		  " feints to one side, fangs bared"
		  " barely misses you again"
		  " strikes out with its fangs, just missing you"  
		  " strikes out at you, but misses"
		  " poises itself for another strike" >>

<CONSTANT JAW-HITS
	  <LTABLE 2 " closes in with its jaws"
		    " gives you a nasty snap"
		    "'s jaws close in again"
		    " bites you hard">>

<CONSTANT JAW-MISSES
	  <LTABLE 2
		  " tries to snap you with its jaws"
		  " misses you again, but just barely"
		  " feints to one side, jaws snapping"
		  " barely misses you again"
		  " strikes out with its jaws, just missing you"  
		  " strikes out at you, but misses"
		  " poises itself for another strike" >>

<CONSTANT DEAD-HITS
	  <LTABLE 2 " closes in with his ghostly blade"
		    " gives you a nasty cut"
		    "'s blade closes in again"
		    " strikes you hard">>
		  
<CONSTANT DEAD-MISSES
	  <LTABLE 2
		  " tries to slice you with his ghostly blade"
		  " misses you again, but just barely"
		  " feints to one side, blade swinging"
		  " barely misses you again"
		  " strikes out with his blade, just missing you"  
		  " strikes out at you, but misses"
		  " poises himself for another strike" >>

<CONSTANT GHOUL-HITS
	  <LTABLE 2 " closes in with his spade"
		    " gives you a nasty cut"
		    "'s spade closes in again"
		    " strikes you hard">>
		  
<CONSTANT GHOUL-MISSES
	  <LTABLE 2
		  " tries to brain you with his spade"
		  " misses you again, but just barely"
		  " feints to one side, spade swinging"
		  " barely misses you again"
		  " strikes out with his spade, just missing you"  
		  " strikes out at you, but misses"
		  " poises himself for another strike" >>

<CONSTANT MISSES
	  <LTABLE 2 "but miss"
		    "missing by a hair"
		    "nearly hitting it"
		    "just barely missing">>

<CONSTANT NO-MINX
	  <PLTABLE (BYTE)
		   IN-SPLENDOR ON-BRIDGE IN-SKY APLANE
		   NW-SUPPORT SW-SUPPORT SE-SUPPORT
		   FOREST-EDGE ON-TRAIL ON-PEAK IN-CABIN>>