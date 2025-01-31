import http.client

conn = http.client.HTTPSConnection("voicerss-text-to-speech.p.rapidapi.com")

headers = {
    'x-rapidapi-key': "beffd5b897mshfc71b5776ff983dp145860jsn33dd55627068",
    'x-rapidapi-host': "voicerss-text-to-speech.p.rapidapi.com"
}

conn.request("GET", "/?src=Hello%2C%20world!&hl=en-us&r=0&c=mp3&f=8khz_8bit_mono", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))