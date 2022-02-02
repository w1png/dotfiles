from numpy import rint
import currency_tracker, weather_tracker, covid_tracker

MAX_ITERS = 3

try:
    with open("/home/w1png/Desktop/dev/toolbar/iters", 'r') as iters:
        i = int(iters.readlines()[0])
    with open("/home/w1png/Desktop/dev/toolbar/iters", 'w') as iters:
        i = 0 if i == MAX_ITERS else i + 1
        iters.write(str(i))

    match i:
        case 0:
            print(f"USD: {currency_tracker.get('usd', 'rub')}₽  EUR: {currency_tracker.get('eur', 'rub')}₽")
        case 1:
            print(f"BTC: {currency_tracker.get('btc', 'usd')}$  ETH: {currency_tracker.get('eth', 'usd')}$")
        case 2:
            print(weather_tracker.get())
        case 3:
            print(f"🇷🇺 Russia: {covid_tracker.get('Russian Federation')} cases  🌍 World: {covid_tracker.get(global_query=True)} cases")
except:
    print(f"Error occured!")
