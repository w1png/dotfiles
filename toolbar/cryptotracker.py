from requests import get as rget

print(rget("https://api.binance.com").json())

