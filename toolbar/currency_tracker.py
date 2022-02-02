from requests import get as rget

def get(c1, c2):
    return "{:.2f}".format(rget(f"https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/{c1}/{c2}.json").json()[c2])

if __name__ == "__main__":
    print(get("usd", "rub"))
    print(f"USD: {get('usd', 'rub')}₽\tEUR: {get('eur', 'rub')}₽")
    print(f"BTC: {get('btc', 'usd')}$\tETH: {get('eth', 'usd')}$")
