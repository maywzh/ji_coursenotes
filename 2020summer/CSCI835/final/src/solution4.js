db.createCollection("company", {
    "validator": {
        $jsonSchema: {
            "bsonType": "object",
            "properties": {
                "_id": { "bsonType": "string" },
                "dname": { "bsonType": "string" },
                "manager": { "bsonType": "string" },
                "msdate": { "bsonType": "Date" },
                "location": {
                    "bsonType": "array",
                    "items": { "bsonType": "string" }
                },
                "employee": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "e#": {
                                "bsonType": "string",
                            },
                            "name": {
                                "bsonType": "string"
                            },
                            "dob": {
                                "bsonType": "date"
                            },
                            "supervisor": {
                                "bsonType": "string",
                            }
                        },
                        "required": ["product name", "keywords"]
                    }
                }
            },
            "required": ["_id", "dname", "manager", "employee"],
            "additionalProperties": false
        }
    }
});