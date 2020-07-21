db.getCollection("orders").update({ "SUPPLIER.city": "Zaandam" }, { $push: { "SUPPLIER.supplies": { "PRODUCT": { "product name": "Changde Noodles", "category name": "Noodles" } } } });

db.getCollection("orders").find({ "SUPPLIER.city": "Zaandam" }, { "SUPPLIER.supplies.PRODUCT.product name": 1 });


db.getCollection("orders").update({ "SUPPLIER.company name": "Tokyo Traders" }, { $pull: { "SUPPLIER.supplies": { "PRODUCT.product name": "Longlife Tofu" } } });

db.getCollection("orders").find({ "SUPPLIER.company name": "Tokyo Traders" }, { "SUPPLIER.supplies.PRODUCT.product name": 1 });

db.getCollection("orders").update({ "SUPPLIER.supplies.PRODUCT.product name": "Flotemysost" }, { $mul: { "SUPPLIER.supplies.$.PRODUCT.unit price": 2 } });

db.getCollection("orders").aggregate([
    { "$unwind": "$SUPPLIER.supplies" },
    { "$match": { "SUPPLIER.supplies.PRODUCT.product name": "Flotemysost" } },
    { "$project": { "_id": 0, "product name": "$SUPPLIER.supplies.PRODUCT.product name", "unit price": "$SUPPLIER.supplies.PRODUCT.unit price" } }
]);

db.getCollection("orders").update({ "CUSTOMER.customer code": "FAMIA" }, { $rename: { "CUSTOMER.submits": "CUSTOMER.sends" } });

db.getCollection("orders").find({ "CUSTOMER.customer code": "FAMIA" }).pretty();


//db.getCollection("orders").find({ "SUPPLIER.supplies.PRODUCT.product name": "Flotemysost" });