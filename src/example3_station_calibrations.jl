#=
example3:
- Julia version:
- Author: Ashley Sommer
- Date: 2020-01-03

This example gets all the Calibration records for a given Cosmoz station
=#

using Printf
using JSON
using HTTP

const COSMOZ_API_URL = "https://esoil.io/cosmoz-data-pipeline/rest/"  # Keep the trailing slash on here.
const STATION_NUMBER = 21
# Endpoint to get a station's calibrations is "pipeline/rest/stations/{id}/calibration"
stations_endpoint = COSMOZ_API_URL * "stations"
station_endpoint = stations_endpoint * "/" * string(STATION_NUMBER)
station_cal_endpoint = station_endpoint * "/calibration"
# Add a header to specifically ask for JSON output
request_headers = Dict("Accept"=>"application/json",)
# Construct a GET request, with that URL and those headers
r = HTTP.request("GET", station_cal_endpoint, request_headers)
payload = JSON.parse(String(r.body))
println("Showing raw payload")
println(payload)
println()
count = payload["meta"]["count"]
println("Found $count calibrations for site $(string(STATION_NUMBER))")
for (i, c) in enumerate(payload["calibrations"])
    println("Calibration $i")
    for (k,v) in c
        println("\t$(string(k)): $(string(v))")
    end
end
