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
    0: 'Human',
    1: 'Half-Elf',
    2: 'Elf',
    3: 'Hobbit',
    4: 'Gnome',
    5: 'Dwarf',
    6: 'Half-Orc',
    7: 'Half-Troll',
    8: 'Dunadan',
    9: 'High-Elf',
    10: 'Kobold',
}

classes = {
    0: 'Warrior',
    1: 'Mage',
    2: 'Priest',
    3: 'Rogue',
    4: 'Ranger',
    5: 'Paladin',
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
    cls = classes.get(p['classid'], 'Unknown')

    if p['max_clvl'] == p['clvl']:
        clvl = p['clvl']
    else:
        clvl = '%s (Max %s)' % (p['clvl'], p['max_clvl'])

    if p['dlvl'] > 0:
        dlvl = 'on dungeon level %s' % p['dlvl']
    else:
        dlvl = 'in the town'

    if p['max_dlvl'] != p['dlvl']:
        dlvl = '%s (Max %s)' % (dlvl, p['max_dlvl'])

    print "%10d  %s the %s %s, level %s" % (p['pts'], p['name'], race, cls, clvl)
    print "%10s  Killed by %s %s" % ('', p['how'], dlvl)
    print "%10s  (User %d, Date %s, Gold %d, Turn %d)" % ('', p['uid'], p['date'], p['gold'], p['turns'])

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
            data = f.read(126)
            if data == "": break

            p = {
                'pts': parse_int(data[8:18]),
                'gold': parse_int(data[18:28]),
                'turns': parse_int(data[28:38]),
                'date': parse_date(data[38:48]),
                'name': parse_str(data[48:64]),
                'uid': parse_int(data[64:72]),
                'raceid': parse_int(data[72:75]),
                'classid': parse_int(data[75:78]),
                'clvl': parse_int(data[78:82]),
                'dlvl': parse_int(data[82:86]),
                'max_clvl': parse_int(data[86:90]),
                'max_dlvl': parse_int(data[90:94]),
                'how': parse_str(data[94:126]),
            }
            players.append(p)

        print ''
        for p in players:
            display(p)
            print ''

if __name__ == "__main__":
    main()
