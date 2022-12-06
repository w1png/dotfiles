from requests import get as rget

def get_icon(code: int) -> str:
    match code:
        case 0, 1:
            return "盛"
        case 2, 3:
            return ""
        case 45, 48:
            return "敖"
        case 51, 53, 55, 56, 57, 58, 59, 66, 67, 80, 81, 82, 95, 96, 99:
            return ""
        case 71, 73, 75, 77, 85, 86:
            return "流"
        case _:
            return "盛"


def get_weather_json() -> dict:
    return rget("https://api.open-meteo.com/v1/forecast?latitude=55.7558&longitude=37.6176&current_weather=true").json()["current_weather"]


def main() -> None:
    weather = get_weather_json()
    print(f"{get_icon(weather['weathercode'])} {weather['temperature']}°C")

main()