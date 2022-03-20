# a small node script to create WebDSL dummy data generated with https://www.mockaroo.com/

import json


filename = "dummydata.app"

prelude = """module dummydata

function loadData(){
"""

eof = "}\n"

user_count = 0
def readUser(data):
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

def readUsers():
    with open("MOCK_USERS.json") as f:
        users = json.load(f)
    return map(readUser, users)

if __name__ == "__main__":
    with open(filename, "w") as f:
        f.write(prelude)

        for var, user in readUsers():
            print(var)
            f.write(user)
            f.write(f"{var}.save();" + "\n\n")

        f.write(eof)