#=
example5:
- Julia version:
- Author: Ashley Sommer
- Date: 2020-01-03

This example gets some Sensor Observations from a given Cosmoz station, with observations aggregated to 24H steps
=#

using Printf
using JSON
using HTTP
using Dates

const COSMOZ_API_URL = "https://esoil.io/cosmoz-data-pipeline/rest/"  # Keep the trailing slash on here.
const STATION_NUMBER = 21
const PROCESSING_LEVEL = 4  # Choose processing level 1, 2, 3, 4, or 0 (for Raw)

# Endpoint to get a station's observations is "pipeline/rest/stations/{id}/observations"
stations_endpoint = COSMOZ_API_URL * "stations"
station_endpoint = stations_endpoint * "/" * string(STATION_NUMBER)
station_obs_endpoint = station_endpoint * "/observations"

# Time Period Start Date
start_date = Dates.DateTime(2019, 1, 1) # UTC
start_date_str = Dates.format(start_date, "Y-m-dTH:M:S.000Z")  # ISO8601 Format
# Time Period End Date
end_date = Dates.DateTime(2019, 1, 31) # UTC
end_date_str = Dates.format(end_date, "Y-m-dTH:M:S.000Z")  # ISO8601 Format
# Add request query params
query_params = Dict(
    "processing_level"=>PROCESSING_LEVEL,
    "startdate"=>start_date_str,
    "enddate"=>end_date_str,
    "aggregate"=>"24h"  # Set aggregation to 24H
)

# Add a header to specifically ask for JSON output
request_headers = Dict("Accept"=>"application/json",)
# Construct a GET request, with that URL and those headers
r = HTTP.request("GET", station_obs_endpoint, request_headers, query=query_params)
payload = JSON.parse(String(r.body))
println("Showing raw payload")
println(payload)
println()
count = payload["meta"]["count"]
println("Found $count Observations for site $(string(STATION_NUMBER))")
for (i, c) in enumerate(payload["observations"])
    println("Observation $i")
    for (k,v) in c
        println("\t$(repr(k)): $(repr(v))")
    end
end
