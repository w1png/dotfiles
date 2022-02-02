from requests import get as rget

def get(country_query=None, global_query=False):
    r = rget("https://api.covid19api.com/summary").json()
    
    if global_query:
        return f'{r["Global"]["NewConfirmed"]:,}'
    return f'{list(filter(lambda country: country["Country"] == country_query, r["Countries"]))[0]["NewConfirmed"]:,}'

if __name__ == "__main__":
    print(get("Russian Federation"))
    print(get(global_query=True))

