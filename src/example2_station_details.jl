#=
example2:
- Julia version:
- Author: Ashley Sommer
- Date: 2020-01-03

This example gets details of a single CosmOz station
=#

using Printf
using JSON
using HTTP

const COSMOZ_API_URL = "https://esoil.io/cosmoz-data-pipeline/rest/"  # Keep the trailing slash on here.
const STATION_NUMBER = 21
# Endpoint to get a station details is "pipeline/rest/stations/{id}"
stations_endpoint = COSMOZ_API_URL * "stations"
station_endpoint = stations_endpoint * "/" * string(STATION_NUMBER)
# Add a header to specifically ask for JSON output
request_headers = Dict("Accept"=>"application/json",)
# Construct a GET request, with that URL and those headers
r = HTTP.request("GET", station_endpoint, request_headers)
payload = JSON.parse(String(r.body))
println("Showing raw payload")
println(payload)
println()
println("Station $(string(STATION_NUMBER)) details:")
for (k, v) in payload
    println("\t$(string(k)): $(string(v))")
end
