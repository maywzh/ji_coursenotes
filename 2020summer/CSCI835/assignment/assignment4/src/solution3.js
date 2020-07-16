db.orders.find({ "SUPPLIER": { $exists: true } }).count();

db.orders.find({ "SUPPLIER.company name": "Norske Meierier" }).pretty();

db.orders.find({ "SUPPLIER.country": "USA", "SUPPLIER.city": "Boston" }).pretty();

db.orders.find({ $or: [{ "SUPPLIER.country": "USA" }, { "SUPPLIER.city": "Sandvika" }] }).pretty();

db.orders.find({ "SUPPLIER.country": "USA", "SUPPLIER.city": { $in: ["Boston", "Los Angeles", "Ann Arbor"] } }).pretty();