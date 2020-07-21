// db.getCollection("orders").aggregate([
//     { "$match": { "SUPPLIER.company name": "Gai paturage" } },
//     { "$project": { "_id": 0, "products1": { "product name": ["$SUPPLIER.supplies.PRODUCT.product name"] } } }
// ]).pretty();

db.getCollection("orders").aggregate([
    { "$match": { "SUPPLIER.company name": "Gai paturage" } },
    { "$project": { "_id": 0, "products1": "$SUPPLIER.supplies.PRODUCT.product name" } }
]).pretty();


db.getCollection("orders").aggregate([
    { "$match": { "SUPPLIER.company name": "Gai paturage" } },
    { "$project": { "_id": 0, "products1": [{ "product name": "$SUPPLIER.supplies.PRODUCT.product name" }] } }
]).pretty();


db.getCollection("orders").aggregate([
    { $unwind: "$SUPPLIER.supplies" },
    { $group: { "_id": null, "total number of products": { $sum: NumberInt(1) } } }

]).pretty();


db.getCollection("orders").aggregate([
    { $unwind: "$CUSTOMER.submits" },
    { $group: { "_id": "$CUSTOMER.submits.ORDER.employee id", count: { $sum: NumberInt(1) } } },
    { $sort: { "_id": 1 } },
    { $limit: 3 },
    { $project: { "employee id": "$_id", "_id": 0, "count": 1 } }
]).pretty();

db.getCollection("orders").aggregate([
    { $unwind: "$CUSTOMER.submits" },
    { $group: { "_id": "$CUSTOMER.submits.ORDER.employee id", count: { $sum: NumberInt(1) } } },
    { $sort: { "_id": 1 } },
    { $limit: 3 },
    { $project: { "employee id": "$_id", "_id": 0, "count": 1 } }
]).pretty();

db.getCollection("orders").aggregate([
    { $match: { "SUPPLIER": { $exists: 1 } } },
    { $project: { "total products": { $size: "$SUPPLIER.supplies" }, "_id": 0, "company name": "$SUPPLIER.company name" } }
]).pretty();

