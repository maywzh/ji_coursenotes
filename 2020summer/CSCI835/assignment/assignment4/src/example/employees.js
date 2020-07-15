db.orders.insert ( 
{"_id":NumberInt("2"),
 "EMPLOYEE":{"employee id":NumberInt("2"), 
             "last name":"Fuller", 
             "first name":"Andrew",
             "title":"Vice President, Sales",
             "title of courtesy":"Dr.",
             "birth date":new Date("1952-02-19"), 
             "hire date":new Date("1992-08-14"),
             "address":"908 W. Capital Way",
             "city":"Tacoma", 
             "region":"WA",
             "postal code": "98401",
             "country":"USA", 
             "home phone":"(206) 555-9482", 
             "extension":"3457",
             "photo":"andrew.jpg",
             "notes":"Andrew received his BTS commercial and a Ph.D. in international marketing from the University of Dallas.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager and was then named vice president of sales.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.",
             "supervises":[{"EMPLOYEE":{"employee id":NumberInt("1"), 
                                        "last name":"Davolio", 
                                        "first name":"Nancy",
                                        "title":"Sales Representative",
                                        "title of courtesy":"Ms.",
                                        "birth date":new Date("1968-08-12"), 
                                        "hire date":new Date("1992-01-05"),
                                        "address":"507 - 20th Ave. E.Apt. 2A",
                                        "city":"Seattle", 
                                        "region":"WA",
                                        "postal code": "98122",
                                        "country":"USA", 
                                        "home phone":"(206) 555-9857", 
                                        "extension":"5467",
                                        "photo":"nancy.jpg",
                                        "notes":"Education includes a BA in psychology from Colorado State University.  She also completed \"The Art of the Cold Call.\"  Nancy is a member of Toastmasters International.",
                                        "supervises":[ ] }
                           },
                           {"EMPLOYEE":{"employee id":NumberInt("3"), 
                                        "last name":"Leverling", 
                                        "first name":"Janet",
                                        "title":"Sales Representative",
                                        "title of courtesy":"Ms.",
                                        "birth date":new Date("1963-08-30"), 
                                        "hire date":new Date("1992-01-04"),
                                        "address":"722 Moss Bay Blvd.",
                                        "city":"Kirkland", 
                                        "region":"WA",
                                        "postal code": "98033",
                                        "country":"USA", 
                                        "home phone":"(206) 555-3412", 
                                        "extension":"3355",
                                        "photo":"janet.jpg",
                                        "notes":"Janet has a BS degree in chemistry from Boston College).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate and was promoted to sales representative.",
                                        "supervises":[ ] }
                           },
                           {"EMPLOYEE":{"employee id":NumberInt("4"), 
                                        "last name":"Peacock", 
                                        "first name":"Margaret",
                                        "title":"Sales Representative",
                                        "title of courtesy":"Ms.",
                                        "birth date":new Date("1958-09-19"), 
                                        "hire date":new Date("1993-05-03"),
                                        "address":"4110 Old Redmond Rd.",
                                        "city":"Redmond", 
                                        "region":"WA",
                                        "postal code": "98052",
                                        "country":"USA", 
                                        "home phone":"(206) 555-8122", 
                                        "extension":"5176",
                                        "photo":"margaret.jpg",
                                        "notes":"Margaret holds a BA in English literature from Concordia College and an MA from the American Institute of Culinary Arts. She was temporarily assigned to the London office before returning to her permanent post in Seattle.",
                                        "supervises":[ ] }
                           },
                           {"EMPLOYEE":{"employee id":NumberInt("8"), 
                                        "last name":"Callahan", 
                                        "first name":"Laura",
                                        "title":"Inside Sales Coordinator",
                                        "title of courtesy":"Ms.",
                                        "birth date":new Date("1958-01-09"), 
                                        "hire date":new Date("1995-03-05"),
                                        "address":"4726 - 11th Ave. N.E.",
                                        "city":"Seattle", 
                                        "region":"WA",
                                        "postal code": "98105",
                                        "country":"USA", 
                                        "home phone":"(206) 555-1189", 
                                        "extension":"2344",
                                        "photo":"laura.jpg",
                                        "notes":"Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.",
                                        "supervises":[ ] },
                          },
                          {"EMPLOYEE":{"employee id":NumberInt("5"), 
                                       "last name":"Buchanan", 
                                       "first name":"Steven",
                                       "title":"Sales Manager",
                                       "title of courtesy":"Mr.",
                                       "birth date":new Date("1955-03-04"), 
                                       "hire date":new Date("1993-10-17"),
                                       "address":"14 Garrett Hill",
                                       "city":"London", 
                                       "postal code": "SW1 8JR",
                                       "country":"UK", 
                                       "home phone":"(71) 555-4848", 
                                       "extension":"3453",
                                       "photo":"steven.jpg",
                                       "notes":"Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree.  Upon joining the company as a sales representative, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London, where he was promoted to sales manager.  Mr. Buchanan has completed the courses \"Successful Telemarketing\" and \"International Sales Management.\"  He is fluent in French.",
                                       "supervises":[{"EMPLOYEE":{"employee id":NumberInt("6"), 
                                                                  "last name":"Suyama", 
                                                                  "first name":"Michael",
                                                                  "title":"Sales Representative",
                                                                  "title of courtesy":"Mr.",
                                                                  "birth date":new Date("1963-07-02"), 
                                                                  "hire date":new Date("1993-10-17"),
                                                                  "address":"Coventry House Miner Rd.",
                                                                  "city":"London", 
                                                                  "postal code": "EC2 7JR",
                                                                  "country":"UK", 
                                                                  "home phone":"(71) 555-7773", 
                                                                  "extension":"428",
                                                                  "photo":"michael.jpg",
                                                                  "notes":"Michael is a graduate of Sussex University (MA, economics) and the University of California at Los Angeles (MBA, marketing).  He has also taken the courses \"Multi-Cultural Selling\" and \"Time Management for the Sales Professional.\"  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.",
                                                                  "supervises":[ ] }
                                                     },
                                                     {"EMPLOYEE":{"employee id":NumberInt("7"), 
                                                                  "last name":"King", 
                                                                  "first name":"Robert",
                                                                  "title":"Sales Representative",
                                                                  "title of courtesy":"Mr.",
                                                                  "birth date":new Date("1960-05-29"), 
                                                                  "hire date":new Date("1994-01-02"),
                                                                  "address":"Edgeham Hollow Winchester Way",
                                                                  "city":"London", 
                                                                  "postal code": "RG1 9SP",
                                                                  "country":"UK", 
                                                                  "home phone":"(71) 555-5598", 
                                                                  "extension":"465",
                                                                  "photo":"robert.jpg",
                                                                  "notes":"Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan and then joining the company.  After completing a course entitled \"Selling in Europe,\" he was transferred to the London office.",
                                                                  "supervises":[ ] }
                                                    },
                                                    {"EMPLOYEE":{"employee id":NumberInt("9"), 
                                                                 "last name":"Dodsworth", 
                                                                 "first name":"Anne",
                                                                 "title":"Sales Representative",
                                                                 "title of courtesy":"Ms.",
                                                                 "birth date":new Date("1969-07-02"), 
                                                                 "hire date":new Date("1994-11-15"),
                                                                 "address":"7 Houndstooth Rd.",
                                                                 "city":"London", 
                                                                 "postal code": "WG2 7LT",
                                                                 "country":"UK", 
                                                                 "home phone":"(71) 555-4444", 
                                                                 "extension":"452",
                                                                 "photo":"anne.jpg",
                                                                 "notes":"Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.",
                                                                 "supervises":[ ] }
                                                   }
                                                  ] 
                                      }
                          }
                         ]
            }
}
);
