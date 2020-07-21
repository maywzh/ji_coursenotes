db.createCollection("task3", {
    "validator": {
        $jsonSchema: {
            bsonType: "object",
            properties: {
                "_id": { bsonType: "string" },
                "company name": { bsonType: "string" },
                "city": { bsonType: "string" },
                "postal code": { bsonType: "int", minimum: 0, maximum: 9999 },
                "supplies": {
                    bsonType: "array",
                    items: {
                        bsonType: "object",
                        properties: {
                            "product name": {
                                bsonType: "string",
                            },
                            "keywords": {
                                bsonType: "string"
                            },
                            "unit price": {
                                bsonType: "double",
                                minimum: 0.00,
                                maximum: 100.00,
                                exclusiveMinimum: true,
                                exclusiveMaximum: true
                            },
                            "unit in stock": { bsonType: "int", minimum: 1 }
                        },
                        required: ["product name", "keywords"]
                    }
                }
            },
            required: ["_id", "company name", "city", "supplies"],
            additionalProperties: false
        }
    }
});

db.task3.insert({
    "company name": "Shanghai Zen",
    "city": "Shanghai",
    "postal code": 8879,
    "supplies": [
        {
            "product name": "Fryed Beatle",
            "unit price": 18.88,
            "unit in stock": 89,
            "keywords": "food"
        }
    ]
});