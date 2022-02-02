from requests import get as rget

def get():
    r = rget("https://www.metaweather.com/api/location/2122265/").json()
    abbr = r["consolidated_weather"][1]["weather_state_abbr"]
    temp = r["consolidated_weather"][1]["the_temp"]
    
    icon = ""
    if abbr == "s":
        icon = "❄️"
    elif abbr in ["sl", "h", "hr", "lr", "s"]:
        icon = "🌧️"
    elif abbr == "t":
        icon = "🌩️"
    elif abbr in ["hc", "lc"]:
        icon = "☁️ "
    elif abbr == "c":
        icon = "☀️"


    return f"{icon}{'{:.2f}'.format(temp)}°C"

if __name__ == "__main__":
    print(get())
