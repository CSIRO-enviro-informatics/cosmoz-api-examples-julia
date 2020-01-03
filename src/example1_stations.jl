#=
example1:
- Julia version:
- Author: Ashley Sommer
- Date: 2020-01-03

This example gets a list of stations from the API endpoint
=#

using Printf
using JSON
using HTTP

const COSMOZ_API_URL = "https://esoil.io/cosmoz-data-pipeline/rest/"  # Keep the trailing slash on here.

# Endpoint to get all stations is "pipeline/rest/stations/"
const stations_endpoint = COSMOZ_API_URL * "stations"

# Add a header to specifically ask for JSON output
request_headers = Dict("Accept"=>"application/json",)
# Construct a GET request, with that URL and those headers
r = HTTP.request("GET", stations_endpoint, request_headers)
payload = JSON.parse(String(r.body))
println("Showing raw payload")
println(payload)
println()
count = payload["meta"]["count"]
println("Found $count stations.")
for s in payload["stations"]
    println("Site $(s["site_no"]): $(s["site_name"])")
end
