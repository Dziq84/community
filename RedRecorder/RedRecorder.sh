#!/bin/sh

#RedRecorder.sh
#Written by Sam Klein

USER="$(whoami)"
NAME="$(cat /home/$USER/RedRecorder/user)"

ORANGE='\033[0;33m'
RED='\033[0;31m'
PURPLE='\033[1;35m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ -d "/home/$USER/RedRecorder/" ]; then
	NEW_POSITIVE_TOTAL=/home/$USER/RedRecorder/.Scores/POSITIVE
	NEW_NEGATIVE_TOTAL=/home/$USER/RedRecorder/.Scores/NEGATIVE
	bash /home/$USER/RedRecorder/redeclipse-1.5.3/redeclipse.sh
	NUMBER="$(ls -l /home/$USER/RedRecorder/.Logs | grep -v ^l | wc -l)"
	OLDNUMBER=$((NUMBER - 1))
	if diff ~/.redeclipse/log.txt /home/$USER/RedRecorder/.Logs/$OLDNUMBER >/dev/null ; then
		echo -e "${RED}ERROR:${NC} ${ORANGE}Your most current game session seems to be the same to the last one.${NC}"
	else
		cp ~/.redeclipse/log.txt /home/$USER/RedRecorder/.Logs
		mv /home/$USER/RedRecorder/.Logs/log.txt /home/$USER/RedRecorder/.Logs/$NUMBER
		### Positive Additives ###
			### Normal Frag ###
			POS_FRAG_SCORE="$(grep "by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			### Assists ###
			POS_ASSIST_SCORE_ONE="$(grep "assisted by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			POS_ASSIST_SCORE_TWO="$(grep "helped by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			POS_ASSIST_SCORE_THR="$(grep "and $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
		### Negative Additives ###
			NEG_TEAM_SCORE="$(grep "by team-mate $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE1="$(grep "$NAME was" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE2="$(grep "$NAME kicked" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE3="$(grep "$NAME died" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE4="$(grep "$NAME drowned" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE5="$(grep "$NAME had their head" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE6="$(grep "$NAME fell" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE7="$(grep "$NAME melted" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE8="$(grep "$NAME twitched" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE9="$(grep "$NAME gave up" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE10="$(grep "$NAME suicided" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE11="$(grep "$NAME met" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE12="$(grep "$NAME burned" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE13="$(grep "$NAME bled" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			NEG_FRAG_SCORE14="$(grep "$NAME tried" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"			
		### Total Positive ###
			CUR_POS_ASSIST1="$(($POS_ASSIST_SCORE_ONE+$POS_ASSIST_SCORE_TWO))"
			CUR_POS_ASSIST_TOTAL="$(($CUR_POS_ASSIST1+$POS_ASSIST_SCORE_THR))"
			POS_ASSIST="$(($CUR_POS_ASSIST_TOTAL/4))"
			CUR_POS_SCORE="$(($POS_ASSIST+$POS_FRAG_SCORE))"
			POS_SCORE="$(($CUR_POS_SCORE-CUR_POS_ASSIST_TOTAL))" ### Total
		### Total Negative ###
			CUR_NEG_SCORE1="$(($NEG_FRAG_SCORE1+$NEG_FRAG_SCORE2))"
			CUR_NEG_SCORE2="$(($CUR_NEG_SCORE1+$NEG_FRAG_SCORE3))"
			CUR_NEG_SCORE3="$(($CUR_NEG_SCORE2+$NEG_FRAG_SCORE4))"
			CUR_NEG_SCORE4="$(($CUR_NEG_SCORE3+$NEG_FRAG_SCORE5))"
			CUR_NEG_SCORE5="$(($CUR_NEG_SCORE4+$NEG_FRAG_SCORE6))"
			CUR_NEG_SCORE6="$(($CUR_NEG_SCORE5+$NEG_FRAG_SCORE7))"
			CUR_NEG_SCORE7="$(($CUR_NEG_SCORE6+$NEG_FRAG_SCORE8))"
			CUR_NEG_SCORE8="$(($CUR_NEG_SCORE7+$NEG_FRAG_SCORE9))"
			CUR_NEG_SCORE9="$(($CUR_NEG_SCORE8+$NEG_FRAG_SCORE10))"
			CUR_NEG_SCORE10="$(($CUR_NEG_SCORE9+$NEG_FRAG_SCORE11))"
			CUR_NEG_SCORE11="$(($CUR_NEG_SCORE10+$NEG_FRAG_SCORE12))" 
			CUR_NEG_SCORE12="$(($CUR_NEG_SCORE11+$NEG_FRAG_SCORE13))"
			CUR_NEG_SCORE13="$(($CUR_NEG_SCORE12+$NEG_FRAG_SCORE14))"
			NEG_SCORE="$(($CUR_NEG_SCORE13+$NEG_TEAM_SCORE))" ### Total
		### Posting Total ###
		echo -e "Your score for this session: ${GREEN}$POS_SCORE${NC} ${CYAN}/${NC} ${RED}$NEG_SCORE${NC}"
		POS_ADD="$(cat /home/$USER/RedRecorder/.Scores/POSITIVE)"
		NEG_ADD="$(cat /home/$USER/RedRecorder/.Scores/NEGATIVE)"
		NEW_POS="$(($POS_ADD+$POS_SCORE))"
		NEW_NEG="$(($NEG_ADD+$NEG_SCORE))"
		echo $NEW_POS > $NEW_POSITIVE_TOTAL
		echo $NEW_NEG > $NEW_NEGATIVE_TOTAL
		echo -e "Your total score: ${GREEN}$NEW_POS${NC} / ${RED}$NEW_NEG${NC}"
		### Weapons ###
			HandG="$(grep "capped by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			SMG1="$(grep "riddled with holes by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			SMG2="$(grep "air conditioned courtesy of $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			SHTGN1="$(grep "buckshot by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			SHTGN2="$(grep "filled with shrapnel by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			SHTGN3="$(grep "fatally wounded by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			RIF1="$(grep "laser shocked by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			RIF2="$(grep "expertly sniped by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			#GERN="$(grep "filled with shrapnel by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			MELEE="$(grep "kicked by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			FLMTHR1="$(grep "fireballed by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			FLMTHR2="$(grep "char-grilled by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			FLMTHR3="$(grep "set ablaze by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			SWORD1="$(grep "impaled by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			SWORD2="$(grep "sliced in half by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			SWORD3="$(grep "sliced apart by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
			PLASMA="$(grep "plasmified by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
	fi
else
	echo -e "No installation found."
	echo -e "Run installer? [${GREEN}yes${NC} / ${RED}no${NC}]"
	read RESP
	if [ $RESP = "yes" ]; then
		bash install-rr.sh
	else
		echo "${RED}Cancelling installation.${NC} Please run install-rr.sh or type in ''${GREEN}yes${NC}''. Contact us if you are having problems: ${CYAN}forum.ruzekklein.com.${NC}"
	fi
fi 
