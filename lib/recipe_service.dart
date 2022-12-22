import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:liste_epicerie/Entities/db.dart';
import 'package:liste_epicerie/Entities/item.dart';
import 'package:liste_epicerie/utils/constantes.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;

//this is the response i get from the api

// {
// 	"vegetarian": false,
// 	"vegan": false,
// 	"glutenFree": false,
// 	"dairyFree": false,
// 	"veryHealthy": false,
// 	"cheap": false,
// 	"veryPopular": false,
// 	"sustainable": false,
// 	"lowFodmap": false,
// 	"weightWatcherSmartPoints": 0,
// 	"gaps": "no",
// 	"preparationMinutes": 30,
// 	"cookingMinutes": 210,
// 	"aggregateLikes": 0,
// 	"healthScore": 0,
// 	"creditsText": "ricardocuisine.com",
// 	"sourceName": "ricardocuisine.com",
// 	"pricePerServing": 0.0,
// 	"extendedIngredients": [
// 		{
// 			"id": 93713,
// 			"aisle": "Meat",
// 			"image": "roast-beef-slices.jpg",
// 			"consistency": "SOLID",
// 			"name": "beef blade roast",
// 			"nameClean": "roast beef",
// 			"original": "1 lb (450 g) bone-in beef blade roast",
// 			"originalName": "lb bone-in beef blade roast",
// 			"amount": 450.0,
// 			"unit": "g",
// 			"meta": [
// 				"bone-in"
// 			],
// 			"measures": {
// 				"us": {
// 					"amount": 15.873,
// 					"unitShort": "oz",
// 					"unitLong": "ounces"
// 				},
// 				"metric": {
// 					"amount": 450.0,
// 					"unitShort": "g",
// 					"unitLong": "grams"
// 				}
// 			}
// 		},
// 		{
// 			"id": 4053,
// 			"aisle": "Oil, Vinegar, Salad Dressing",
// 			"image": "olive-oil.jpg",
// 			"consistency": "LIQUID",
// 			"name": "olive oil",
// 			"nameClean": "olive oil",
// 			"original": "2 tbsp (30 ml) olive oil",
// 			"originalName": "tbsp olive oil",
// 			"amount": 30.0,
// 			"unit": "ml",
// 			"meta": [],
// 			"measures": {
// 				"us": {
// 					"amount": 1.015,
// 					"unitShort": "fl. oz",
// 					"unitLong": "fl. oz"
// 				},
// 				"metric": {
// 					"amount": 30.0,
// 					"unitShort": "ml",
// 					"unitLong": "milliliters"
// 				}
// 			}
// 		},
// 		{
// 			"id": 10011238,
// 			"aisle": "Produce",
// 			"image": "mixed-mushrooms.png",
// 			"consistency": "SOLID",
// 			"name": "mushrooms",
// 			"nameClean": "mixed mushrooms",
// 			"original": "1 lb (450 g) mixed mushrooms (such as oyster, button, chanterelles, cremini, honey mushrooms)",
// 			"originalName": "lb mixed mushrooms (such as oyster, button, chanterelles, cremini, honey mushrooms)",
// 			"amount": 450.0,
// 			"unit": "g",
// 			"meta": [
// 				"mixed",
// 				"(such as oyster, button, chanterelles, cremini, honey mushrooms)"
// 			],
// 			"measures": {
// 				"us": {
// 					"amount": 15.873,
// 					"unitShort": "oz",
// 					"unitLong": "ounces"
// 				},
// 				"metric": {
// 					"amount": 450.0,
// 					"unitShort": "g",
// 					"unitLong": "grams"
// 				}
// 			}
// 		},
// 		{
// 			"id": 14096,
// 			"aisle": "Alcoholic Beverages",
// 			"image": "red-wine.jpg",
// 			"consistency": "LIQUID",
// 			"name": "red wine",
// 			"nameClean": "red wine",
// 			"original": "1 cup (250 ml) red wine",
// 			"originalName": "cup red wine",
// 			"amount": 250.0,
// 			"unit": "ml",
// 			"meta": [],
// 			"measures": {
// 				"us": {
// 					"amount": 1.057,
// 					"unitShort": "cups",
// 					"unitLong": "cups"
// 				},
// 				"metric": {
// 					"amount": 250.0,
// 					"unitShort": "ml",
// 					"unitLong": "milliliters"
// 				}
// 			}
// 		},
// 		{
// 			"id": 1006170,
// 			"aisle": "Canned and Jarred",
// 			"image": "beef-broth.png",
// 			"consistency": "LIQUID",
// 			"name": "veal stock",
// 			"nameClean": "veal stock",
// 			"original": "2 cups (500 ml) veal stock",
// 			"originalName": "cups veal stock",
// 			"amount": 500.0,
// 			"unit": "ml",
// 			"meta": [],
// 			"measures": {
// 				"us": {
// 					"amount": 2.113,
// 					"unitShort": "cups",
// 					"unitLong": "cups"
// 				},
// 				"metric": {
// 					"amount": 500.0,
// 					"unitShort": "ml",
// 					"unitLong": "milliliters"
// 				}
// 			}
// 		},
// 		{
// 			"id": 1012046,
// 			"aisle": "Condiments",
// 			"image": "whole-grain-mustard.png",
// 			"consistency": "LIQUID",
// 			"name": "whole-grain mustard",
// 			"nameClean": "whole grain mustard",
// 			"original": "2 tbsp (30 ml) whole-grain mustard",
// 			"originalName": "tbsp whole-grain mustard",
// 			"amount": 30.0,
// 			"unit": "ml",
// 			"meta": [],
// 			"measures": {
// 				"us": {
// 					"amount": 1.015,
// 					"unitShort": "fl. oz",
// 					"unitLong": "fl. oz"
// 				},
// 				"metric": {
// 					"amount": 30.0,
// 					"unitShort": "ml",
// 					"unitLong": "milliliters"
// 				}
// 			}
// 		},
// 		{
// 			"id": 10620420,
// 			"aisle": "Pasta and Rice",
// 			"image": "lasagna-noodles.jpg",
// 			"consistency": "SOLID",
// 			"name": "lasagna",
// 			"nameClean": "lasagne noodles",
// 			"original": "4 sheets fresh lasagna, each about 9 x 6 inches (23 x 15 cm)",
// 			"originalName": "fresh lasagna, each about 9 x 6 inches (23 x 15 cm)",
// 			"amount": 4.0,
// 			"unit": "sheets",
// 			"meta": [
// 				"fresh",
// 				"(23 x 15 cm)"
// 			],
// 			"measures": {
// 				"us": {
// 					"amount": 4.0,
// 					"unitShort": "sheets",
// 					"unitLong": "sheets"
// 				},
// 				"metric": {
// 					"amount": 4.0,
// 					"unitShort": "sheets",
// 					"unitLong": "sheets"
// 				}
// 			}
// 		},
// 		{
// 			"id": 1009,
// 			"aisle": "Cheese",
// 			"image": "cheddar-cheese.png",
// 			"consistency": "SOLID",
// 			"name": "aged cheddar cheese shavings",
// 			"nameClean": "cheddar cheese",
// 			"original": "2 oz (55 g) aged cheddar cheese shavings",
// 			"originalName": "oz aged cheddar cheese shavings",
// 			"amount": 55.0,
// 			"unit": "g",
// 			"meta": [],
// 			"measures": {
// 				"us": {
// 					"amount": 1.94,
// 					"unitShort": "oz",
// 					"unitLong": "ounces"
// 				},
// 				"metric": {
// 					"amount": 55.0,
// 					"unitShort": "g",
// 					"unitLong": "grams"
// 				}
// 			}
// 		},
// 		{
// 			"id": 10311297,
// 			"aisle": "Produce",
// 			"image": "parsley.jpg",
// 			"consistency": "SOLID",
// 			"name": "flat-leaf parsley leaves",
// 			"nameClean": "flat leaf parsley",
// 			"original": "2 tbsp flat-leaf parsley leaves",
// 			"originalName": "flat-leaf parsley leaves",
// 			"amount": 2.0,
// 			"unit": "tbsp",
// 			"meta": [],
// 			"measures": {
// 				"us": {
// 					"amount": 2.0,
// 					"unitShort": "Tbsps",
// 					"unitLong": "Tbsps"
// 				},
// 				"metric": {
// 					"amount": 2.0,
// 					"unitShort": "Tbsps",
// 					"unitLong": "Tbsps"
// 				}
// 			}
// 		}
// 	],
// 	"id": -1,
// 	"title": "Pasta with Mushrooms and Braised Beef",
// 	"readyInMinutes": 240,
// 	"servings": 4,
// 	"sourceUrl": "https://www.ricardocuisine.com/en/recipes/9586-pasta-with-mushrooms-and-braised-beef",
// 	"image": "https://images.ricardocuisine.com/services/recipes/1x1/9586.jpg",
// 	"imageType": "jpg",
// 	"summary": null,
// 	"cuisines": [],
// 	"dishTypes": [],
// 	"diets": [],
// 	"occasions": [],
// 	"instructions": "Ingredients\n\n1 lb (450 g) bone-in beef blade roast\n\n2 tbsp (30 ml) olive oil\n\n1 lb (450 g) mixed mushrooms (such as oyster, button, chanterelles, cremini, honey mushrooms)\n\n1 cup (250 ml) red wine\n\n2 cups (500 ml) veal stock\n\n2 tbsp (30 ml) whole-grain mustard\n\n4 \tsheets fresh lasagna, each about 9 x 6 inches (23 x 15 cm)\n\n2 oz (55 g) aged cheddar cheese shavings\n\n2 tbsp flat-leaf parsley leaves\n\nPreparation\n\nWith the rack in the middle position, preheat the oven to 300°F (150°C).\n\nIn a Dutch oven or ovenproof pot over medium-high heat, brown the meat in the oil on all sides. Set aside on a plate.\n\nMeanwhile, using a mandoline, thinly slice 2 mushrooms (either cremini or button). Set aside for serving.\n\nIn the same pot, brown the remaining mushrooms. Add more oil as needed. Deglaze with the wine and let reduce by half. Add the veal stock and mustard. Return the meat to the pot. Bring to a boil. Cover and bake in the oven for 3 hours or until the meat is fork-tender and the sauce has been almost completely absorbed (see note). Remove the bone from the meat. In the pot, shred the meat, removing any excess fat. Compost the bone and fat.\n\nCut each sheet of lasagna in half and make 5 incisions at the centre of each square of pasta.\n\nIn a pot of salted boiling water, cook the pasta until al dente. Set aside 1 cup (250 ml) of the cooking water. Drain the pasta.\n\nAdd the reserved pasta cooking water to the pot of meat to thin out the sauce (see note).\n\nPlace one square of pasta on each plate. Top with half of the meat and mushroom mixture. Top with a second square of pasta and the remaining meat mixture. Sprinkle with the cheese shavings, parsley leaves and raw mushroom slices.",
// 	"analyzedInstructions": [
// 		{
// 			"name": "",
// 			"steps": [
// 				{
// 					"number": 1,
// 					"step": "Ingredients",
// 					"ingredients": [],
// 					"equipment": []
// 				},
// 				{
// 					"number": 2,
// 					"step": "1 lb (450 g) bone-in beef blade roast",
// 					"ingredients": [
// 						{
// 							"id": 23572,
// 							"name": "beef",
// 							"localizedName": "beef",
// 							"image": "beef-cubes-raw.png"
// 						},
// 						{
// 							"id": 0,
// 							"name": "bone",
// 							"localizedName": "bone",
// 							"image": ""
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 3,
// 					"step": "2 tbsp (30 ml) olive oil",
// 					"ingredients": [
// 						{
// 							"id": 4053,
// 							"name": "olive oil",
// 							"localizedName": "olive oil",
// 							"image": "olive-oil.jpg"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 4,
// 					"step": "1 lb (450 g) mixed mushrooms (such as oyster, button, chanterelles, cremini, honey mushrooms)",
// 					"ingredients": [
// 						{
// 							"id": 10011238,
// 							"name": "mixed mushrooms",
// 							"localizedName": "mixed mushrooms",
// 							"image": "mixed-mushrooms.png"
// 						},
// 						{
// 							"id": 11239,
// 							"name": "chanterelle mushrooms",
// 							"localizedName": "chanterelle mushrooms",
// 							"image": "chanterelles.jpg"
// 						},
// 						{
// 							"id": 11260,
// 							"name": "mushrooms",
// 							"localizedName": "mushrooms",
// 							"image": "mushrooms.png"
// 						},
// 						{
// 							"id": 15167,
// 							"name": "oysters",
// 							"localizedName": "oysters",
// 							"image": "oysters.jpg"
// 						},
// 						{
// 							"id": 19296,
// 							"name": "honey",
// 							"localizedName": "honey",
// 							"image": "honey.png"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 5,
// 					"step": "1 cup (250 ml) red wine",
// 					"ingredients": [
// 						{
// 							"id": 14096,
// 							"name": "red wine",
// 							"localizedName": "red wine",
// 							"image": "red-wine.jpg"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 6,
// 					"step": "2 cups (500 ml) veal stock",
// 					"ingredients": [
// 						{
// 							"id": 1006170,
// 							"name": "veal stock",
// 							"localizedName": "veal stock",
// 							"image": "beef-broth.png"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 7,
// 					"step": "2 tbsp (30 ml) whole-grain mustard",
// 					"ingredients": [
// 						{
// 							"id": 1012046,
// 							"name": "whole grain mustard",
// 							"localizedName": "whole grain mustard",
// 							"image": "whole-grain-mustard.png"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 8,
// 					"step": "4 \tsheets fresh lasagna, each about 9 x 6 inches (23 x 15 cm)",
// 					"ingredients": [],
// 					"equipment": []
// 				},
// 				{
// 					"number": 9,
// 					"step": "2 oz (55 g) aged cheddar cheese shavings",
// 					"ingredients": [
// 						{
// 							"id": 1009,
// 							"name": "cheddar cheese",
// 							"localizedName": "cheddar cheese",
// 							"image": "cheddar-cheese.png"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 10,
// 					"step": "2 tbsp flat-leaf parsley leaves",
// 					"ingredients": [
// 						{
// 							"id": 10311297,
// 							"name": "flat leaf parsley",
// 							"localizedName": "flat leaf parsley",
// 							"image": "parsley.jpg"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 11,
// 					"step": "With the rack in the middle position, preheat the oven to 300°F (150°C).",
// 					"ingredients": [],
// 					"equipment": [
// 						{
// 							"id": 404784,
// 							"name": "oven",
// 							"localizedName": "oven",
// 							"image": "oven.jpg",
// 							"temperature": {
// 								"number": 300.0,
// 								"unit": "Fahrenheit"
// 							}
// 						}
// 					]
// 				},
// 				{
// 					"number": 12,
// 					"step": "In a Dutch oven or ovenproof pot over medium-high heat, brown the meat in the oil on all sides. Set aside on a plate.",
// 					"ingredients": [
// 						{
// 							"id": 1065062,
// 							"name": "meat",
// 							"localizedName": "meat",
// 							"image": "whole-chicken.jpg"
// 						},
// 						{
// 							"id": 4582,
// 							"name": "cooking oil",
// 							"localizedName": "cooking oil",
// 							"image": "vegetable-oil.jpg"
// 						}
// 					],
// 					"equipment": [
// 						{
// 							"id": 404667,
// 							"name": "dutch oven",
// 							"localizedName": "dutch oven",
// 							"image": "dutch-oven.jpg"
// 						}
// 					]
// 				},
// 				{
// 					"number": 13,
// 					"step": "Meanwhile, using a mandoline, thinly slice 2 mushrooms (either cremini or button). Set aside for serving.",
// 					"ingredients": [
// 						{
// 							"id": 11260,
// 							"name": "mushrooms",
// 							"localizedName": "mushrooms",
// 							"image": "mushrooms.png"
// 						}
// 					],
// 					"equipment": [
// 						{
// 							"id": 404687,
// 							"name": "mandoline",
// 							"localizedName": "mandoline",
// 							"image": "mandoline-slicer.png"
// 						}
// 					]
// 				},
// 				{
// 					"number": 14,
// 					"step": "In the same pot, brown the remaining mushrooms.",
// 					"ingredients": [
// 						{
// 							"id": 11260,
// 							"name": "mushrooms",
// 							"localizedName": "mushrooms",
// 							"image": "mushrooms.png"
// 						}
// 					],
// 					"equipment": [
// 						{
// 							"id": 404752,
// 							"name": "pot",
// 							"localizedName": "pot",
// 							"image": "stock-pot.jpg"
// 						}
// 					]
// 				},
// 				{
// 					"number": 15,
// 					"step": "Add more oil as needed. Deglaze with the wine and let reduce by half.",
// 					"ingredients": [
// 						{
// 							"id": 14084,
// 							"name": "wine",
// 							"localizedName": "wine",
// 							"image": "red-wine.jpg"
// 						},
// 						{
// 							"id": 4582,
// 							"name": "cooking oil",
// 							"localizedName": "cooking oil",
// 							"image": "vegetable-oil.jpg"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 16,
// 					"step": "Add the veal stock and mustard. Return the meat to the pot. Bring to a boil. Cover and bake in the oven for 3 hours or until the meat is fork-tender and the sauce has been almost completely absorbed (see note).",
// 					"ingredients": [
// 						{
// 							"id": 1006170,
// 							"name": "veal stock",
// 							"localizedName": "veal stock",
// 							"image": "beef-broth.png"
// 						},
// 						{
// 							"id": 2046,
// 							"name": "mustard",
// 							"localizedName": "mustard",
// 							"image": "regular-mustard.jpg"
// 						},
// 						{
// 							"id": 0,
// 							"name": "sauce",
// 							"localizedName": "sauce",
// 							"image": ""
// 						},
// 						{
// 							"id": 1065062,
// 							"name": "meat",
// 							"localizedName": "meat",
// 							"image": "whole-chicken.jpg"
// 						}
// 					],
// 					"equipment": [
// 						{
// 							"id": 404784,
// 							"name": "oven",
// 							"localizedName": "oven",
// 							"image": "oven.jpg"
// 						},
// 						{
// 							"id": 404752,
// 							"name": "pot",
// 							"localizedName": "pot",
// 							"image": "stock-pot.jpg"
// 						}
// 					],
// 					"length": {
// 						"number": 180,
// 						"unit": "minutes"
// 					}
// 				},
// 				{
// 					"number": 17,
// 					"step": "Remove the bone from the meat. In the pot, shred the meat, removing any excess fat. Compost the bone and fat.",
// 					"ingredients": [
// 						{
// 							"id": 0,
// 							"name": "bone",
// 							"localizedName": "bone",
// 							"image": ""
// 						},
// 						{
// 							"id": 1065062,
// 							"name": "meat",
// 							"localizedName": "meat",
// 							"image": "whole-chicken.jpg"
// 						}
// 					],
// 					"equipment": [
// 						{
// 							"id": 404752,
// 							"name": "pot",
// 							"localizedName": "pot",
// 							"image": "stock-pot.jpg"
// 						}
// 					]
// 				},
// 				{
// 					"number": 18,
// 					"step": "Cut each sheet of lasagna in half and make 5 incisions at the centre of each square of pasta.",
// 					"ingredients": [
// 						{
// 							"id": 20420,
// 							"name": "pasta",
// 							"localizedName": "pasta",
// 							"image": "fusilli.jpg"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 19,
// 					"step": "In a pot of salted boiling water, cook the pasta until al dente. Set aside 1 cup (250 ml) of the cooking water.",
// 					"ingredients": [
// 						{
// 							"id": 20420,
// 							"name": "pasta",
// 							"localizedName": "pasta",
// 							"image": "fusilli.jpg"
// 						},
// 						{
// 							"id": 14412,
// 							"name": "water",
// 							"localizedName": "water",
// 							"image": "water.png"
// 						}
// 					],
// 					"equipment": [
// 						{
// 							"id": 404752,
// 							"name": "pot",
// 							"localizedName": "pot",
// 							"image": "stock-pot.jpg"
// 						}
// 					]
// 				},
// 				{
// 					"number": 20,
// 					"step": "Drain the pasta.",
// 					"ingredients": [
// 						{
// 							"id": 20420,
// 							"name": "pasta",
// 							"localizedName": "pasta",
// 							"image": "fusilli.jpg"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 21,
// 					"step": "Add the reserved pasta cooking water to the pot of meat to thin out the sauce (see note).",
// 					"ingredients": [
// 						{
// 							"id": 20420,
// 							"name": "pasta",
// 							"localizedName": "pasta",
// 							"image": "fusilli.jpg"
// 						},
// 						{
// 							"id": 0,
// 							"name": "sauce",
// 							"localizedName": "sauce",
// 							"image": ""
// 						},
// 						{
// 							"id": 14412,
// 							"name": "water",
// 							"localizedName": "water",
// 							"image": "water.png"
// 						},
// 						{
// 							"id": 1065062,
// 							"name": "meat",
// 							"localizedName": "meat",
// 							"image": "whole-chicken.jpg"
// 						}
// 					],
// 					"equipment": [
// 						{
// 							"id": 404752,
// 							"name": "pot",
// 							"localizedName": "pot",
// 							"image": "stock-pot.jpg"
// 						}
// 					]
// 				},
// 				{
// 					"number": 22,
// 					"step": "Place one square of pasta on each plate. Top with half of the meat and mushroom mixture. Top with a second square of pasta and the remaining meat mixture.",
// 					"ingredients": [
// 						{
// 							"id": 11260,
// 							"name": "mushrooms",
// 							"localizedName": "mushrooms",
// 							"image": "mushrooms.png"
// 						},
// 						{
// 							"id": 20420,
// 							"name": "pasta",
// 							"localizedName": "pasta",
// 							"image": "fusilli.jpg"
// 						},
// 						{
// 							"id": 1065062,
// 							"name": "meat",
// 							"localizedName": "meat",
// 							"image": "whole-chicken.jpg"
// 						}
// 					],
// 					"equipment": []
// 				},
// 				{
// 					"number": 23,
// 					"step": "Sprinkle with the cheese shavings, parsley leaves and raw mushroom slices.",
// 					"ingredients": [
// 						{
// 							"id": 11297,
// 							"name": "parsley",
// 							"localizedName": "parsley",
// 							"image": "parsley.jpg"
// 						},
// 						{
// 							"id": 11260,
// 							"name": "mushrooms",
// 							"localizedName": "mushrooms",
// 							"image": "mushrooms.png"
// 						},
// 						{
// 							"id": 1041009,
// 							"name": "cheese",
// 							"localizedName": "cheese",
// 							"image": "cheddar-cheese.png"
// 						}
// 					],
// 					"equipment": []
// 				}
// 			]
// 		}
// 	],
// 	"originalId": null
// }

class RecipeService {
  static Future addFromRecipe(String recipeLink) async {
    //call spoonacular api
    //add items to db
    String getUrl =
        "https://api.spoonacular.com/recipes/extract?url=${recipeLink}";

    return http.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/extract?url=${recipeLink}'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'a4cb495d9d80410bb9121dfc492d7c6c',
      },
    ).then((response) {
      switch (response.statusCode) {
        case 200:
          var body = response.body;
          Map<String, dynamic> data = json.decode(response.body);
          //get every ingredients from extendedIngredients and map it to item entity
          for (var i = 0; i < data['extendedIngredients'].length; i++) {
            data['extendedIngredients'][i]['name'];
            Item newItem = Item(
              name: data['extendedIngredients'][i]['name'],
              unit: data['extendedIngredients'][i]['unit'],
              amount: data['extendedIngredients'][i]['amount'],
            );
            //add item to db
            MongoDatabase.insert(newItem);
          }
          break;

        default:
          throw ErrorDescription(
            'Failed to get form entries count by form id',
          );
      }
    });
  }
}
