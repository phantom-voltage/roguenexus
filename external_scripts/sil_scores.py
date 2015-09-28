#!/usr/bin/python
#
# by Erik Osheim
#
# External score parser/printer for Angband. It hardcores some
# values from p_races.txt and classes.txt for simplicitly.
# Should basically mimic the built-in format.
#
# One caveat: does not currently display the current (living)
# character, since this character's information is not in the
# score file.
#
# Seems to work as of 2014-07-04 (1aba7a8).

import os, sys

races = {
    0: 'Noldor',
    1: 'Sindar',
    2: 'Naugrim',
    3: 'Edain',
}

classes = {
    0: 'Warrior',
    1: 'Mage',
    2: 'Priest',
    3: 'Rogue',
    4: 'Ranger',
    5: 'Paladin',
}

houses = {
    0: 'no house',
    1: '''Feanor's House''',
    2: '''Fingolfin's House''',
    3: '''Finarfin's House''',
    4: 'Doriath',
    5: 'Nogrod',
    6: 'Belegost',
    7: 'Beor',
    8: '''Haleth's People''',
    9: '''Hador's House''',
    10: 'the Falas',
}

# remove trailing nulls/spaces
def trim(s):
    i = len(s) - 1
    while s[i] == '\0' or s[i] == ' ':
        i -= 1
    return i + 1

# parse a (decimal) integer
def parse_int(s):
    i = trim(s)
    return int(s[:i])

# parse a string
def parse_str(s):
    i = trim(s)
    return str(s[:i])

# parse a date. input format is @YYYYMMDD?
def parse_date(s):
    return s[1:5] + '-' + s[5:7] + '-' + s[7:9]

# display a player dictionary
def display(p):
    race = races.get(p['raceid'], 'Unknown')
    house = houses.get(p['houseid'], 'Unknown')
    extra3 = ""
    extra4 = ""
    space = ""
    

    if p['morg'] == 't':
	extra1 = ", who defeated Morgoth in his dark halls"	
	morBonus = "   V    "
    elif p['sil'] == 1:
	extra1 = ", who freed a Simaril"
	morBonus = "\t"
    elif p['sil'] == 2:
	extra1 = ", who freed two Simarils"
	morBonus = "\t"
    elif p['sil'] == 3:
	extra1 = ", who freed all three Simarils"
	morBonus = "\t"
    else:
	extra1 = ""
	morBonus = "\t"
       

    if p['esc'] == 't':
	extra2 = "Escaped the iron hells"
	score="Escaped "
	
	if p['morg'] == 't'and p['sil'] > 0:
		extra3 = " and brought back the light of Valinor"
	else:
		if p['sex'] == 'm':
			extra4 = " with his task unfulfilled."
		else:
			extra4 = " with her task unfulfilled."
    else:
	extra2 = "Slain by " + p['how']
	score=format(p['mdun']*50, "4,d")+" ft"

    if p['mdun'] == 20:
   	space=" "
    if p['sil'] == 1:
	silBonus="   *    "
    elif p['sil'] == 2:
	silBonus="  * *   "
    elif p['sil'] == 3:
	silBonus=" * * *  "
    else:
	silBonus="\t"
	
    print "%s %s of %s" % (score, p['name'], house+extra1)
    print "%s%s" % (morBonus, space+extra2+extra3+extra4)
    print "%safter %s turns (%s) " % (silBonus+space, format(p['turns']), p['date'])
   



# mighty main method
def main():
    if len(sys.argv) < 2:
        print 'usage: %s SAVEFILE' % sys.argv[0]
        print '    (e.g. lib/scores/scores.raw)'
        sys.exit(1)

    path = sys.argv[1]

    if not os.path.exists(path):
        print 'error: %r was not found' % path
        sys.exit(2)

    with open(path, 'rb') as f:
        players = []
        while True:
            data = f.read(133)
            #if data == "": break
	    if len(data) < 133: break

            p = {
                'turns': parse_int(data[13:23]),
                'date': parse_date(data[23:33]),
                'name': parse_str(data[33:49]),
                'uid': parse_int(data[49:57]),
                'sex': parse_str(data[57:59]),
                'raceid': parse_int(data[59:62]),
                'houseid': parse_int(data[62:69]),
                'cdun': parse_int(data[69:73]),
                'mdun': parse_int(data[73:77]),
                'how': parse_str(data[77:127]),
                'sil': parse_int(data[127:129]),
                'morg': parse_str(data[129:131]),
                'esc': parse_str(data[131:133]),
            }
            players.append(p)
	    #print "loop completed\n"

        print ''
        for p in players:
            display(p)
            print ''

if __name__ == "__main__":
    main()
