db.createCollection("company", {
    "validator": {
        $jsonSchema: {
            "bsonType": "object",
            "properties": {
                "_id": { "bsonType": "string" },
                "company name": { "bsonType": "string" },
                "city": { "bsonType": "string" },
                "postal code": {
                    "bsonType": ["int"],
                    "minimum": 0,
                    "maximum": 9999
                },
                "supplies": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "product name": {
                                "bsonType": "string",
                            },
                            "keywords": {
                                "bsonType": "string"
                            },
                            "unit price": {
                                "bsonType": ["double"],
                                "minimum": 0,
                                "maximum": 100,
                                "exclusiveMinimum": true,
                                "exclusiveMaximum": true
                            },
                            "unit in stock": {
                                "bsonType": ["int"],
                                "minimum": 1
                            }
                        },
                        "required": ["product name", "keywords"]
                    }
                }
            },
            "required": ["_id", "company name", "city", "supplies"],
            "additionalProperties": false
        }
    }
});

db.getCollection("task3").insert({
    "_id": "Shanghai Zen",
    "company name": "Shanghai Zen",
    "city": "Shanghai",
    "postal code": NumberInt(8879),
    "supplies": [
        {
            "product name": "Fryed Beatle",
            "unit price": 18.88,
            "unit in stock": NumberInt(89),
            "keywords": "food"
        }
    ]
});


db.getCollection("task3").insert({
    "_id": "Niko kasami",
    "company name": "Niko kasami",
    "city": "Kyoto",
    "postal code": NumberInt(7703),
    "supplies": [
        {
            "product name": "Tatami mattress",
            "unit price": 100.99,
            "unit in stock": NumberInt(89),
            "keywords": "Necessities"
        }
    ]
});