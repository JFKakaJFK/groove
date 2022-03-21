# a small node script to create WebDSL dummy data generated with https://www.mockaroo.com/

import json
import random
from datetime import date

filename = "dummydata.app"

prelude = """module dummydata

imports src/entities

function loadData(){
"""

eof = "}\n"

user_count = 0
def read_user(data):
    global user_count
    user_count += 1
    var = f"user{user_count}"
    res = f"var {var} := User{{" + "\n"
    if data['premium']:
        res += "  roles := {PREMIUM}," + "\n"
    res += f"  name := \"{data['name'] if data['uname'] else data['first_name'] + ' ' + data['last_name']}\"," + "\n"
    res += f"  email := \"{data['email']}\"," + "\n"
    res += "  password := (\"123\" as Secret).digest(),\n"
    res += f"  verified := {'true' if data['verified'] else 'false'}," + "\n"
    res += f"  newsletter := {'true' if data['newsletter'] else 'false'}" + "\n"
    res += "};\n"
    return (var, res)

def read_users(limit=42):
    with open("MOCK_USERS.json") as f:
        users = json.load(f)
    return list(map(read_user, users))[:limit]

COLORS = [
"red",
"orange",
"yellow",
"green",
"teal",
"sky",
"indigo"
]

def read_habit(data, user):
    res = "Habit {\n"
    res += f"  name := \"{data['name']}\"," + "\n"
    res += f"  user := {user}," + "\n"
    res += f"  description := \"{data['description']}\"," + "\n"
    res += f"  color := {COLORS[random.randint(0, len(COLORS)-1)]}" + "\n"
    return res + "}\n"

def add_completions(habit):
    rate = random.random()
    from_date_ordinal = date.today().toordinal() - random.randint(0, 420)
    completions = ""
    for d in range(from_date_ordinal, date.today().toordinal()+1):
        if random.random() < rate:
            completions += f"{habit}.completions.add(Completion {{ habit := {habit}, date := Date(\"{date.fromordinal(d).strftime('%d/%m/%y')}\") }});" + "\n"
    return completions

def generate_habits(habits, user):
    hs = ""
    for i in range(random.randint(1, 5)):
        var = f"{user}Habit{i}"
        hs += f"var {var} := {read_habit(habits[random.randint(0, len(habits) - 1)], user)};" + "\n"
        hs += add_completions(var)
        hs += f"{user}.habits.add({var});" + "\n"
    return hs

def user_as_function(var, user):
    f = f"function load{var}(){{\n"
    f += user
    f += generate_habits(habits, var)
    f += f"{var}.save();" + "\n}\n"
    return f"load{var}();\n", f

if __name__ == "__main__":
    with open("MOCK_HABITS.json") as f:
        habits = json.load(f)
    with open(filename, "w") as f:
        f.write(prelude)

        loaders = [] # only like 30k lines in memory...
        for var, user in read_users(42):
            call, fn = user_as_function(var, user)
            f.write(call)
            loaders.append(fn)

        f.write(eof)
        for fn in loaders:
            f.write(fn)