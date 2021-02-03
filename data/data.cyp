// File directly placed in import directory (import/data.csv)
LOAD CSV WITH HEADERS FROM "file:///roads.csv"
AS row

MERGE (origin:Place {name: row.origin_reference_place})
MERGE (originCountry:Country {code: row.origin_country_code})

MERGE (destination:Place {name: row.destination_reference_place})
MERGE (destinationCountry:Country {code: row.destination_country_code})

MERGE (origin)-[:IN_COUNTRY]->(originCountry)
MERGE (destination)-[:IN_COUNTRY]->(destinationCountry)

MERGE (origin)-[eroad:EROAD {number: row.road_number}]->(destination)
SET eroad.distance = toInteger(row.distance), eroad.watercrossing = row.watercrossing;