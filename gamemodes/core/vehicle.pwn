/*
 *
 * SAN ANDREAS MULTIPLAYER VEHICLE.PWN BY TOMAS TORKQ VOSYLIUS
 * ALL RIGHTS RESERVED
 * 2016
 *
 */
#include <YSI\y_hooks>

new aVehicleNames[ 212 ][ ] = {	// Credit: BetaMaster
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Article Trailer"},
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Article Trailer 2"},
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"},
	{"Hotring Racer B"},
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"},
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"},
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"},
	{"Monster B"},
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"},
	{"Streak Carriage"},
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Petrol Trailer"},
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Box Trailer"},
	{"Article Trailer 3"},
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"LSPD"},
	{"SFPD"},
	{"LVPD"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Baggage Trailer A"},
	{"Baggage Trailer B"},
	{"Stair Trailer"},
	{"Boxville"},
	{"Farm Plow"},
	{"Utility Trailer"}
};

/*
 * Hooks
 */

/*
 * Functions
 */

stock GetVehicleDoors(vehicleid,&bonnet,&boot,&driver_door,&passenger_door)
{
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	bonnet = (doors & 0x7);
	boot = ((doors >> 8) & 0x7);
	driver_door = ((doors >> 16) & 0x7);
	passenger_door = ((doors >> 24) & 0x7);
}

stock SetVehicleDoors(vehicleid,bonnet,boot,driver_door,passenger_door)
{
	new panels,doors,lights,tires;
	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
	doors = (bonnet | (boot << 8) | (driver_door << 16) | (passenger_door << 24));
	UpdateVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
}

stock GetModelCategory(model)
{
	new string[12] = "-";
	switch(model)
	{
		case 400: format(string, sizeof string, "Visureigis"); // Landstalker
		case 401: format(string, sizeof string, "Lengvasis"); // Bravura
		case 402: format(string, sizeof string, "Sportinis"); // Buffalo
		case 403: format(string, sizeof string, "Sunkiasvoris"); // Linerunner
		case 404: format(string, sizeof string, "Lengvasis"); // Perenniel
		case 405: format(string, sizeof string, "Lengvasis"); // Sentinel
		case 406: format(string, sizeof string, "Sunkiasvoris"); // Dumper
		case 407: format(string, sizeof string, "Sunkiasvoris"); // Firetruck
		case 408: format(string, sizeof string, "Sunkiasvoris"); // Trashmaster
		case 409: format(string, sizeof string, "Limuzinas"); // Stretch
		case 410: format(string, sizeof string, "Lengvasis"); // Manana
		case 411: format(string, sizeof string, "Sportinis"); // Infernus
		case 412: format(string, sizeof string, "Lengvasis"); // Voodoo
		case 413: format(string, sizeof string, "Krovininis"); // Pony
		case 414: format(string, sizeof string, "Krovininis"); // Mule
		case 415: format(string, sizeof string, "Sportinis"); // Cheetah
		case 416: format(string, sizeof string, "Sunkiasvoris"); // Ambulance
		case 417: format(string, sizeof string, "Sraigtasparnis"); // Leviathan
		case 418: format(string, sizeof string, "Krovininis"); // Moonbeam
		case 419: format(string, sizeof string, "Lengvasis"); // Esperanto
		case 420: format(string, sizeof string, "Lengvasis"); // Taxi
		case 421: format(string, sizeof string, "Lengvasis"); // Washington
		case 422: format(string, sizeof string, "Krovininis"); // Bobcat
		case 423: format(string, sizeof string, "Sunkiasvoris"); // Mr. Whoopee
		case 424: format(string, sizeof string, "Lengvasis"); // BF Injection
		case 425: format(string, sizeof string, "Sraigtasparnis"); // Hunter
		case 426: format(string, sizeof string, "Lengvasis"); // Premier
		case 427: format(string, sizeof string, "Sarvuotis"); // Enforcer
		case 428: format(string, sizeof string, "Sunkiasvoris"); // Securicar
		case 429: format(string, sizeof string, "Sportinis"); // Banshee
		case 430: format(string, sizeof string, "Laivas"); // Predator
		case 431: format(string, sizeof string, "Sunkiasvoris"); // Bus
		case 432: format(string, sizeof string, "Sunkiasvoris"); // Rhino
		case 433: format(string, sizeof string, "Sunkiasvoris"); // Barracks
		case 434: format(string, sizeof string, "Lengvasis"); // Hotknife
		case 435: format(string, sizeof string, "Priekaba"); // Article Trailer
		case 436: format(string, sizeof string, "Lengvasis"); // Previon
		case 437: format(string, sizeof string, "Sunkiasvoris"); // Coach
		case 438: format(string, sizeof string, "Lengvasis"); // Cabbie
		case 439: format(string, sizeof string, "Lengvasis"); // Stallion
		case 440: format(string, sizeof string, "Krovininis"); // Rumpo
		case 441: format(string, sizeof string, "Lengvasis"); // RC Bandit
		case 442: format(string, sizeof string, "Lengvasis"); // Romero
		case 443: format(string, sizeof string, "Krovininis"); // Packer
		case 444: format(string, sizeof string, "Visureigis"); // Monster
		case 445: format(string, sizeof string, "Lengvasis"); // Admiral
		case 446: format(string, sizeof string, "Laivas"); // Squallo
		case 447: format(string, sizeof string, "Sraigtasparnis"); // Seasparrow
		case 448: format(string, sizeof string, "Motociklas"); // Pizzaboy
		case 449: format(string, sizeof string, "Sunkiasvoris"); // Tram
		case 450: format(string, sizeof string, "Priekaba"); // Article Trailer 2
		case 451: format(string, sizeof string, "Sportine"); // Turismo
		case 452: format(string, sizeof string, "Laivas"); // Speeder
		case 453: format(string, sizeof string, "Laivas"); // Reefer
		case 454: format(string, sizeof string, "Laivas"); // Tropic
		case 455: format(string, sizeof string, "Krovininis"); // Flatbed
		case 456: format(string, sizeof string, "Krovininis"); // Yankee
		case 457: format(string, sizeof string, "Lengvasis"); // Caddy
		case 458: format(string, sizeof string, "Lengvasis"); // Solair
		case 459: format(string, sizeof string, "Krovininis"); // Topfun Van (Berkley's RC)
		case 460: format(string, sizeof string, "Lektuvas"); // Skimmer
		case 461: format(string, sizeof string, "Motociklas"); // PCJ-600
		case 462: format(string, sizeof string, "Motociklas"); // Faggio
		case 463: format(string, sizeof string, "Motociklas"); // Freeway
		case 464: format(string, sizeof string, "Lektuvas"); // RC Baron
		case 465: format(string, sizeof string, "Sraigtasparnis"); // RC Raider
		case 466: format(string, sizeof string, "Lengvasis"); // Glendale
		case 467: format(string, sizeof string, "Lengvasis"); // Oceanic
		case 468: format(string, sizeof string, "Motociklas"); // Sanchez
		case 469: format(string, sizeof string, "Sraigtasparnis"); // Sparrow
		case 470: format(string, sizeof string, "Visureigis"); // Patriot
		case 471: format(string, sizeof string, "Motociklas"); // Quad
		case 472: format(string, sizeof string, "Laivas"); // Coastguard
		case 473: format(string, sizeof string, "Laivas"); // Dinghy
		case 474: format(string, sizeof string, "Lengvasis"); // Hermes
		case 475: format(string, sizeof string, "Lengvasis"); // Sabre
		case 476: format(string, sizeof string, "Lektuvas"); // Rustler
		case 477: format(string, sizeof string, "Sportinis"); // ZR-350
		case 478: format(string, sizeof string, "Krovininis"); // Walton
		case 479: format(string, sizeof string, "Lengvasis"); // Regina
		case 480: format(string, sizeof string, "Sportinis"); // Comet
		case 481: format(string, sizeof string, "Dviratis"); // BMX
		case 482: format(string, sizeof string, "Krovininis"); // Burrito
		case 483: format(string, sizeof string, "Lengvasis"); // Camper
		case 484: format(string, sizeof string, "Laivas"); // Marquis
		case 485: format(string, sizeof string, "Krovininis"); // Baggage
		case 486: format(string, sizeof string, "Sunkiasvoris"); // Dozer
		case 487: format(string, sizeof string, "Sraigtasparnis"); // Maverick
		case 488: format(string, sizeof string, "Sraigtasparnis"); // SAN News Maverick
		case 489: format(string, sizeof string, "Visureigis"); // Rancher
		case 490: format(string, sizeof string, "Visureigis"); // FBI Rancher
		case 491: format(string, sizeof string, "Lengvasis"); // Virgo
		case 492: format(string, sizeof string, "Lengvasis"); // Greenwood
		case 493: format(string, sizeof string, "Laivas"); // Jetmax
		case 494: format(string, sizeof string, "Sportinis"); // Hotring Racer
		case 495: format(string, sizeof string, "Visureigis"); // Sandking
		case 496: format(string, sizeof string, "Lengvasis"); // Blista Compact
		case 497: format(string, sizeof string, "Sraigtasparnis"); // Police Maverick
		case 498: format(string, sizeof string, "Krovininis"); // Boxville
		case 499: format(string, sizeof string, "Krovininis"); // Benson
		case 500: format(string, sizeof string, "Visureigis"); // Mesa
		case 501: format(string, sizeof string, "Sraigtasparnis"); // RC Goblin
		case 502: format(string, sizeof string, "Sportinis"); // Hotring Racer A
		case 503: format(string, sizeof string, "Sportinis"); // Hotring Racer B
		case 504: format(string, sizeof string, "Sportinis"); // Bloodring Banger
		case 505: format(string, sizeof string, "Visureigis"); // Rancher Lure
		case 506: format(string, sizeof string, "Sportinis"); // Super GT
		case 507: format(string, sizeof string, "Lengvasis"); // Elegant
		case 508: format(string, sizeof string, "Sunkiasvoris"); // Journey
		case 509: format(string, sizeof string, "Dviratis"); // Bike
		case 510: format(string, sizeof string, "Dviratis"); // Mountain Bike
		case 511: format(string, sizeof string, "Lektuvas"); // Beagle
		case 512: format(string, sizeof string, "Lektuvas"); // Cropduster
		case 513: format(string, sizeof string, "Lektuvas"); // Stuntplane
		case 514: format(string, sizeof string, "Sunkiasvoris"); // Tanker
		case 515: format(string, sizeof string, "Sunkiasvoris"); // Roadtrain
		case 516: format(string, sizeof string, "Lengvasis"); // Nebula
		case 517: format(string, sizeof string, "Lengvasis"); // Majestic
		case 518: format(string, sizeof string, "Lengvasis"); // Buccaneer
		case 519: format(string, sizeof string, "Lektuvas"); // Shamal
		case 520: format(string, sizeof string, "Lektuvas"); // Hydra
		case 521: format(string, sizeof string, "Motociklas"); // FCR-900
		case 522: format(string, sizeof string, "Motociklas"); // NRG-500
		case 523: format(string, sizeof string, "Motociklas"); // HPV1000
		case 524: format(string, sizeof string, "Sunkiasvoris"); // Cement Truck
		case 525: format(string, sizeof string, "Sunkiasvoris"); // Towtruck
		case 526: format(string, sizeof string, "Lengvasis"); // Fortune
		case 527: format(string, sizeof string, "Lengvasis"); // Cadrona
		case 528: format(string, sizeof string, "Sunkiasvoris"); // FBI Truck
		case 529: format(string, sizeof string, "Lengvasis"); // Willard
		case 530: format(string, sizeof string, "Krovininis"); // Forklift
		case 531: format(string, sizeof string, "Krovininis"); // Tractor
		case 532: format(string, sizeof string, "Sunkiasvoris"); // Combine Harvester
		case 533: format(string, sizeof string, "Lengvasis"); // Feltzer
		case 534: format(string, sizeof string, "Lengvasis"); // Remington
		case 535: format(string, sizeof string, "Lengvasis"); // Slamvan
		case 536: format(string, sizeof string, "Lengvasis"); // Blade
		case 537: format(string, sizeof string, "Sunkiasvoris"); // Freight (Train)
		case 538: format(string, sizeof string, "Sunkiasvoris"); // Brownstreak (Train)
		case 539: format(string, sizeof string, "Laivas"); // Vortex
		case 540: format(string, sizeof string, "Lengvasis"); // Vincent
		case 541: format(string, sizeof string, "Sportinis"); // Bullet
		case 542: format(string, sizeof string, "Lengvasis"); // Clover
		case 543: format(string, sizeof string, "Krovininis"); // Sadler
		case 544: format(string, sizeof string, "Sunkiasvoris"); // Firetruck LA
		case 545: format(string, sizeof string, "Lengvasis"); // Hustler
		case 546: format(string, sizeof string, "Lengvasis"); // Intruder
		case 547: format(string, sizeof string, "Lengvasis"); // Primo
		case 548: format(string, sizeof string, "Sraigtasparnis"); // Cargobob
		case 549: format(string, sizeof string, "Lengvasis"); // Tampa
		case 550: format(string, sizeof string, "Lengvasis"); // Sunrise
		case 551: format(string, sizeof string, "Lengvasis"); // Merit
		case 552: format(string, sizeof string, "Krovininis"); // Utility Van
		case 553: format(string, sizeof string, "Lektuvas"); // Nevada
		case 554: format(string, sizeof string, "Visureigis"); // Yosemite
		case 555: format(string, sizeof string, "Lengvasis"); // Windsor
		case 556: format(string, sizeof string, "Visureigis"); // Monster "A"
		case 557: format(string, sizeof string, "Visureigis"); // Monster "B"
		case 558: format(string, sizeof string, "Sportinis"); // Uranus
		case 559: format(string, sizeof string, "Sportinis"); // Jester
		case 560: format(string, sizeof string, "Sportinis"); // Sultan
		case 561: format(string, sizeof string, "Sportinis"); // Stratum
		case 562: format(string, sizeof string, "Sportinis"); // Elegy
		case 563: format(string, sizeof string, "Sraigtasparnis"); // Raindance
		case 564: format(string, sizeof string, "Lengvasis"); // RC Tiger
		case 565: format(string, sizeof string, "Sportinis"); // Flash
		case 566: format(string, sizeof string, "Lengvasis"); // Tahoma
		case 567: format(string, sizeof string, "Lengvasis"); // Savanna
		case 568: format(string, sizeof string, "Visureigis"); // Bandito
		case 569: format(string, sizeof string, "Priekaba"); // Freight Flat Trailer (Train)
		case 570: format(string, sizeof string, "Priekaba"); // Streak Trailer (Train)
		case 571: format(string, sizeof string, "Lengvasis"); // Kart
		case 572: format(string, sizeof string, "Lengvasis"); // Mower
		case 573: format(string, sizeof string, "Krovininis"); // Dune
		case 574: format(string, sizeof string, "Lengvasis"); // Sweeper
		case 575: format(string, sizeof string, "Lengvasis"); // Broadway
		case 576: format(string, sizeof string, "Lengvasis"); // Tornado
		case 577: format(string, sizeof string, "Lektuvas"); // AT400
		case 578: format(string, sizeof string, "Krovinis"); // DFT-30
		case 579: format(string, sizeof string, "Visureigis"); // Huntley
		case 580: format(string, sizeof string, "Lengvasis"); // Stafford
		case 581: format(string, sizeof string, "Motociklas"); // BF-400
		case 582: format(string, sizeof string, "Krovinis"); // Newsvan
		case 583: format(string, sizeof string, "Lengvasis"); // Tug
		case 584: format(string, sizeof string, "Priekaba"); // Petrol Trailer
		case 585: format(string, sizeof string, "Lengvasis"); // Emperor
		case 586: format(string, sizeof string, "Motociklas"); // Wayfarer
		case 587: format(string, sizeof string, "Lengvasis"); // Euros
		case 588: format(string, sizeof string, "Sunkiasvoris"); // Hotdog
		case 589: format(string, sizeof string, "Lengvasis"); // Club
		case 590: format(string, sizeof string, "Priekaba"); // Freight Box Trailer (Train)
		case 591: format(string, sizeof string, "Priekaba"); // Article Trailer 3
		case 592: format(string, sizeof string, "Lektuvas"); // Andromada
		case 593: format(string, sizeof string, "Lektuvas"); // Dodo
		case 594: format(string, sizeof string, "Lengvasis"); // RC Cam
		case 595: format(string, sizeof string, "Laivas"); // Launch
		case 596: format(string, sizeof string, "Lengvasis"); // Police Car (LSPD)
		case 597: format(string, sizeof string, "Lengvasis"); // Police Car (SFPD)
		case 598: format(string, sizeof string, "Lengvasis"); // Police Car (LVPD)
		case 599: format(string, sizeof string, "Visureigis"); // Police Ranger
		case 600: format(string, sizeof string, "Krovininis"); // Picador
		case 601: format(string, sizeof string, "Sunkiasvoris"); // S.W.A.T.
		case 602: format(string, sizeof string, "Sportinis"); // Alpha
		case 603: format(string, sizeof string, "Sportinis"); // Phoenix
		case 604: format(string, sizeof string, "Lengvasis"); // Glendale Shit
		case 605: format(string, sizeof string, "Lengvasis"); // Sadler Shit
		case 606: format(string, sizeof string, "Priekaba"); // Baggage Trailer "A"
		case 607: format(string, sizeof string, "Priekaba"); // Baggage Trailer "B"
		case 608: format(string, sizeof string, "Priekaba"); // Tug Stairs Trailer
		case 609: format(string, sizeof string, "Krovininis"); // Boxville
		case 610: format(string, sizeof string, "Priekaba"); // Farm Trailer
		case 611: format(string, sizeof string, "Priekaba"); // Utility Trailer
	}
	return string;
}

new VehicleFuelCapacityList[212] = {
	80, // Landstalker
	60, // Bravura
	50, // Buffalo
	500, // Linerunner
	68, // Perenniel
	60, // Sentinel
	500, // Dumper
	500, // Firetruck
	500, // Trashmaster
	80, // Stretch
	40, // Manana
	50, // Infernus
	60, // Voodoo
	90, // Pony
	150, // Mule
	50, // Cheetah
	190, // Ambulance
	500, // Leviathan
	90, // Moonbeam
	60, // Esperanto
	70, // Taxi
	80, // Washington
	65, // Bobcat
	70, // Mr. Whoopee
	50, // BF Injection
	300, // Hunter
	65, // Premier
	190, // Enforcer
	100, // Securicar
	50, // Banshee
	150, // Predator
	350, // Bus
	500, // Rhino
	200, // Barracks
	60, // Hotknife
	0, // Article Trailer
	60, // Previon
	350, // Coach
	80, // Cabbie
	60, // Stallion
	90, // Rumpo
	0, // RC Bandit
	80, // Romero
	500, // Packer
	80, // Monster
	70, // Admiral
	120, // Squallo
	120, // Seasparrow
	15, // Pizzaboy
	0, // Tram
	0, // Article Trailer 2
	50, // Turismo
	120, // Speeder
	120, // Reefer
	120, // Tropic
	200, // Flatbed
	120, // Yankee
	25, // Caddy
	75, // Solair
	90, // Topfun Van (Berkley's RC)
	200, // Skimmer
	30, // PCJ-600
	15, // Faggio
	35, // Freeway
	0, // RC Baron
	0, // RC Raider
	70, // Glendale
	70, // Oceanic
	25, // Sanchez
	120, // Sparrow
	120, // Patriot
	30, // Quad
	120, // Coastguard
	120, // Dinghy
	60, // Hermes
	60, // Sabre
	120, // Rustler
	60, // ZR-350
	80, // Walton
	70, // Regina
	55, // Comet
	0, // BMX
	85, // Burrito
	80, // Camper
	120, // Marquis
	35, // Baggage
	100, // Dozer
	120, // Maverick
	120, // SAN News Maverick
	85, // Rancher
	85, // FBI Rancher
	60, // Virgo
	65, // Greenwood
	120, // Jetmax
	80, // Hotring Racer
	80, // Sandking
	60, // Blista Compact
	230, // Police Maverick
	90, // Boxville
	90, // Benson
	55, // Mesa
	0, // RC Goblin
	80, // Hotring Racer A
	80, // Hotring Racer B
	80, // Bloodring Banger
	85, // Rancher Lure
	50, // Super GT
	75, // Elegant
	95, // Journey
	0, // Bike
	0, // Mountain Bike
	120, // Beagle
	100, // Cropduster
	90, // Stuntplane
	400, // Tanker
	400, // Roadtrain
	65, // Nebula
	60, // Majestic
	65, // Buccaneer
	80, // Shamal
	400, // Hydra
	30, // FCR-900
	30, // NRG-500
	45, // HPV1000
	110, // Cement Truck
	100, // Towtruck
	60, // Fortune
	60, // Cadrona
	120, // FBI Truck
	60, // Willard
	30, // Forklift
	25, // Tractor
	110, // Combine Harvester
	55, // Feltzer
	70, // Remington
	70, // Slamvan
	70, // Blade
	1000, // Freight (Train)
	1000, // Brownstreak (Train)
	20, // Vortex
	70, // Vincent
	55, // Bullet
	60, // Clover
	70, // Sadler
	200, // Firetruck LA
	70, // Hustler
	70, // Intruder
	70, // Primo
	400, // Cargobob
	60, // Tampa
	70, // Sunrise
	70, // Merit
	80, // Utility Van
	1000, // Nevada
	80, // Yosemite
	50, // Windsor
	80, // Monster "A"
	80, // Monster "B"
	65, // Uranus
	65, // Jester
	70, // Sultan
	75, // Stratum
	55, // Elegy
	500, // Raindance
	0, // RC Tiger
	50, // Flash
	65, // Tahoma
	65, // Savanna
	45, // Bandito
	0, // Freight Flat Trailer (Train)
	1000, // Streak Trailer (Train)
	20, // Kart
	30, // Mower
	120, // Dune
	40, // Sweeper
	70, // Broadway
	80, // Tornado
	400, // AT400
	180, // DFT-30
	150, // Huntley
	135, // Stafford
	30, // BF-400
	80, // Newsvan
	30, // Tug
	0, // Petrol Trailer
	70, // Emperor
	40, // Wayfarer
	60, // Euros
	80, // Hotdog
	55, // Club
	0, // Freight Box Trailer (Train)
	0, // Article Trailer 3
	400, // Andromada
	180, // Dodo
	0, // RC Cam
	120, // Launch
	90, // Police Car (LSPD)
	90, // Police Car (SFPD)
	90, // Police Car (LVPD)
	100, // Police Ranger
	70, // Picador
	120, // S.W.A.T.
	60, // Alpha
	55, // Phoenix
	60, // Glendale Shit
	60, // Sadler Shit
	0, // Baggage Trailer "A"
	0, // Baggage Trailer "B"
	0, // Tug Stairs Trailer
	90, // Boxville
	0, // Farm Trailer
	0 // Utility Trailer
};


new VehicleTrunkSpace[212] = {
	200, // Landstalker
	200, // Bravura
	200, // Buffalo
	200, // Linerunner
	200, // Perenniel
	200, // Sentinel
	200, // Dumper
	200, // Firetruck
	200, // Trashmaster
	200, // Stretch
	200, // Manana
	200, // Infernus
	200, // Voodoo
	200, // Pony
	200, // Mule
	200, // Cheetah
	200, // Ambulance
	200, // Leviathan
	200, // Moonbeam
	200, // Esperanto
	200, // Taxi
	200, // Washington
	200, // Bobcat
	200, // Mr. Whoopee
	200, // BF Injection
	200, // Hunter
	200, // Premier
	200, // Enforcer
	200, // Securicar
	200, // Banshee
	200, // Predator
	200, // Bus
	200, // Rhino
	200, // Barracks
	200, // Hotknife
	200, // Article Trailer
	200, // Previon
	200, // Coach
	200, // Cabbie
	200, // Stallion
	200, // Rumpo
	200, // RC Bandit
	200, // Romero
	200, // Packer
	200, // Monster
	200, // Admiral
	200, // Squallo
	200, // Seasparrow
	200, // Pizzaboy
	200, // Tram
	200, // Article Trailer 2
	200, // Turismo
	200, // Speeder
	200, // Reefer
	200, // Tropic
	200, // Flatbed
	200, // Yankee
	200, // Caddy
	200, // Solair
	200, // Topfun Van (Berkley's RC)
	200, // Skimmer
	200, // PCJ-600
	200, // Faggio
	200, // Freeway
	200, // RC Baron
	200, // RC Raider
	200, // Glendale
	200, // Oceanic
	200, // Sanchez
	200, // Sparrow
	200, // Patriot
	200, // Quad
	200, // Coastguard
	200, // Dinghy
	200, // Hermes
	200, // Sabre
	200, // Rustler
	200, // ZR-350
	200, // Walton
	200, // Regina
	200, // Comet
	200, // BMX
	200, // Burrito
	200, // Camper
	200, // Marquis
	200, // Baggage
	200, // Dozer
	200, // Maverick
	200, // SAN News Maverick
	200, // Rancher
	200, // FBI Rancher
	200, // Virgo
	200, // Greenwood
	200, // Jetmax
	200, // Hotring Racer
	200, // Sandking
	200, // Blista Compact
	200, // Police Maverick
	200, // Boxville
	200, // Benson
	200, // Mesa
	200, // RC Goblin
	200, // Hotring Racer A
	200, // Hotring Racer B
	200, // Bloodring Banger
	200, // Rancher Lure
	200, // Super GT
	200, // Elegant
	200, // Journey
	200, // Bike
	200, // Mountain Bike
	200, // Beagle
	200, // Cropduster
	200, // Stuntplane
	200, // Tanker
	200, // Roadtrain
	200, // Nebula
	200, // Majestic
	200, // Buccaneer
	200, // Shamal
	200, // Hydra
	200, // FCR-900
	200, // NRG-500
	200, // HPV1000
	200, // Cement Truck
	200, // Towtruck
	200, // Fortune
	200, // Cadrona
	200, // FBI Truck
	200, // Willard
	200, // Forklift
	200, // Tractor
	200, // Combine Harvester
	200, // Feltzer
	200, // Remington
	200, // Slamvan
	200, // Blade
	200, // Freight (Train)
	200, // Brownstreak (Train)
	200, // Vortex
	200, // Vincent
	200, // Bullet
	200, // Clover
	200, // Sadler
	200, // Firetruck LA
	200, // Hustler
	200, // Intruder
	200, // Primo
	200, // Cargobob
	200, // Tampa
	200, // Sunrise
	200, // Merit
	200, // Utility Van
	200, // Nevada
	200, // Yosemite
	200, // Windsor
	200, // Monster "A"
	200, // Monster "B"
	200, // Uranus
	200, // Jester
	200, // Sultan
	200, // Stratum
	200, // Elegy
	200, // Raindance
	200, // RC Tiger
	200, // Flash
	200, // Tahoma
	200, // Savanna
	200, // Bandito
	200, // Freight Flat Trailer (Train)
	200, // Streak Trailer (Train)
	200, // Kart
	200, // Mower
	200, // Dune
	200, // Sweeper
	200, // Broadway
	200, // Tornado
	200, // AT400
	200, // DFT-30
	200, // Huntley
	200, // Stafford
	200, // BF-400
	200, // Newsvan
	200, // Tug
	200, // Petrol Trailer
	200, // Emperor
	200, // Wayfarer
	200, // Euros
	200, // Hotdog
	200, // Club
	200, // Freight Box Trailer (Train)
	200, // Article Trailer 3
	200, // Andromada
	200, // Dodo
	200, // RC Cam
	200, // Launch
	200, // Police Car (LSPD)
	200, // Police Car (SFPD)
	200, // Police Car (LVPD)
	200, // Police Ranger
	200, // Picador
	200, // S.W.A.T.
	200, // Alpha
	200, // Phoenix
	200, // Glendale Shit
	200, // Sadler Shit
	200, // Baggage Trailer "A"
	200, // Baggage Trailer "B"
	200, // Tug Stairs Trailer
	200, // Boxville
	200, // Farm Trailer
	200 // Utility Trailer
};



new VehicleClassLevel[212] = {
	4, // Landstalker
	1, // Bravura
	5, // Buffalo
	3, // Linerunner
	2, // Perenniel
	4, // Sentinel
	3, // Dumper
	4, // Firetruck
	3, // Trashmaster
	2, // Stretch
	1, // Manana
	5, // Infernus
	2, // Voodoo
	2, // Pony
	1, // Mule
	5, // Cheetah
	1, // Ambulance
	2, // Leviathan
	2, // Moonbeam
	4, // Esperanto
	2, // Taxi
	5, // Washington
	1, // Bobcat
	2, // Mr. Whoopee
	5, // BF Injection
	5, // Hunter
	4, // Premier
	3, // Enforcer
	3, // Securicar
	5, // Banshee
	5, // Predator
	5, // Bus
	5, // Rhino
	5, // Barracks
	5, // Hotknife
	2, // Article Trailer
	2, // Previon
	5, // Coach
	4, // Cabbie
	2, // Stallion
	1, // Rumpo
	5, // RC Bandit
	1, // Romero
	1, // Packer
	5, // Monster
	3, // Admiral
	2, // Squallo
	5, // Seasparrow
	1, // Pizzaboy
	1, // Tram
	1, // Article Trailer 2
	5, // Turismo
	5, // Speeder
	1, // Reefer
	1, // Tropic
	1, // Flatbed
	3, // Yankee
	1, // Caddy
	1, // Solair
	1, // Topfun Van (Berkley's RC)
	1, // Skimmer
	3, // PCJ-600
	1, // Faggio
	3, // Freeway
	1, // RC Baron
	1, // RC Raider
	1, // Glendale
	1, // Oceanic
	2, // Sanchez
	1, // Sparrow
	5, // Patriot
	1, // Quad
	1, // Coastguard
	1, // Dinghy
	2, // Hermes
	1, // Sabre
	1, // Rustler
	4, // ZR-350
	1, // Walton
	1, // Regina
	5, // Comet
	1, // BMX
	4, // Burrito
	3, // Camper
	2, // Marquis
	1, // Baggage
	3, // Dozer
	5, // Maverick
	5, // SAN News Maverick
	3, // Rancher
	5, // FBI Rancher
	2, // Virgo
	3, // Greenwood
	5, // Jetmax
	5, // Hotring Racer
	5, // Sandking
	1, // Blista Compact
	5, // Police Maverick
	2, // Boxville
	2, // Benson
	3, // Mesa
	2, // RC Goblin
	5, // Hotring Racer A
	5, // Hotring Racer B
	5, // Bloodring Banger
	5, // Rancher Lure
	5, // Super GT
	3, // Elegant
	1, // Journey
	1, // Bike
	1, // Mountain Bike
	1, // Beagle
	2, // Cropduster
	2, // Stuntplane
	3, // Tanker
	3, // Roadtrain
	1, // Nebula
	3, // Majestic
	2, // Buccaneer
	5, // Shamal
	5, // Hydra
	3, // FCR-900
	5, // NRG-500
	1, // HPV1000
	2, // Cement Truck
	1, // Towtruck
	1, // Fortune
	1, // Cadrona
	5, // FBI Truck
	2, // Willard
	1, // Forklift
	1, // Tractor
	1, // Combine Harvester
	3, // Feltzer
	3, // Remington
	2, // Slamvan
	2, // Blade
	5, // Freight (Train)
	5, // Brownstreak (Train)
	5, // Vortex
	2, // Vincent
	5, // Bullet
	1, // Clover
	1, // Sadler
	1, // Firetruck LA
	1, // Hustler
	1, // Intruder
	1, // Primo
	1, // Cargobob
	1, // Tampa
	1, // Sunrise
	2, // Merit
	1, // Utility Van
	2, // Nevada
	3, // Yosemite
	1, // Windsor
	5, // Monster "A"
	5, // Monster "B"
	3, // Uranus
	4, // Jester
	5, // Sultan
	2, // Stratum
	5, // Elegy
	1, // Raindance
	1, // RC Tiger
	4, // Flash
	4, // Tahoma
	2, // Savanna
	1, // Bandito
	1, // Freight Flat Trailer (Train)
	1, // Streak Trailer (Train)
	1, // Kart
	1, // Mower
	1, // Dune
	1, // Sweeper
	2, // Broadway
	1, // Tornado
	5, // AT400
	5, // DFT-30
	5, // Huntley
	5, // Stafford
	3, // BF-400
	1, // Newsvan
	2, // Tug
	3, // Petrol Trailer
	2, // Emperor
	2, // Wayfarer
	2, // Euros
	3, // Hotdog
	1, // Club
	1, // Freight Box Trailer (Train)
	1, // Article Trailer 3
	5, // Andromada
	3, // Dodo
	1, // RC Cam
	1, // Launch
	1, // Police Car (LSPD)
	1, // Police Car (SFPD)
	1, // Police Car (LVPD)
	1, // Police Ranger
	1, // Picador
	3, // S.W.A.T.
	2, // Alpha
	2, // Phoenix
	1, // Glendale Shit
	1, // Sadler Shit
	1, // Baggage Trailer "A"
	1, // Baggage Trailer "B"
	1, // Tug Stairs Trailer
	2, // Boxville
	1, // Farm Trailer
	1 // Utility Trailer
};

new Float:VehicleEngineUsage[ 212 ] = {
	2.5, // Landstalker 2.5
	2.0, // Bravura 2.0
	5.0, // Buffalo 5.0
	5.0, // Linerunner 5.0
	1.9, // Perenniel 1.9
	2.8, // Sentinel 2.5
	6.4, // Dumper 6.4
	5.0, // Firetruck 5.0
	4.2, // Trashmaster 4.2
	4.0, // Stretch 4.0
	1.9, // Manana 1.9
	3.2, // Infernus 3.2
	2.2, // Voodoo 2.3
	2.2, // Pony 2.2
	3.0, // Mule 3.0
	3.5, // Cheetah 3.5
	2.8, // Ambulance 2.8
	6.3, // Leviathan 6.3
	2.5, // Moonbeam 2.5
	4.6, // Esperanto 4.6
	2.5, // Taxi 2.5
	3.0, // Washington 3.0
	2.0, // Bobcat 2.0
	3.2, // Mr. Whoopee 3.2
	2.2, // BF Injection 2.2
	7.4, // Hunter 7.4
	2.0, // Premier 2.0
	4.6, // Enforcer 4.6
	5.2, // Securicar 5.2
	3.2, // Banshee 3.2
	3.0, // Predator 3.0
	4.6, // Bus 4.6
	7.4, // Rhino 7.4
	5.2, // Barracks 5.2
	4.0, // Hotknife 4.0
	0.0, // Article Trailer 0.0
	1.6, // Previon 1.6
	3.5, // Coach 3.5
	2.0, // Cabbie 2.0
	1.9, // Stallion 1.9
	2.3, // Rumpo 2.3
	0.1, // RC Bandit 0.1
	2.3, // Romero 2.3
	6.2, // Packer 6.2
	5.0, // Monster 5.0
	2.0, // Admiral 2.0
	2.7, // Squallo 2.7
	4.6, // Seasparrow 4.6
	0.2, // Pizzaboy 0.2
	3.2, // Tram 3.2
	0.0, // Article Trailer 2 0.0
	3.5, // Turismo 3.5
	2.7, // Speeder 2.7
	3.2, // Reefer 3.2
	3.5, // Tropic 3.5
	4.2, // Flatbed 4.2
	3.0, // Yankee 3.0
	0.7, // Caddy 0.7
	2.2, // Solair 2.2
	2.5, // Topfun Van (Berkley's RC) 2.5
	3.6, // Skimmer 3.6
	0.6, // PCJ-600 0.6
	0.2, // Faggio 0.2
	1.0, // Freeway 1.0
	0.0, // RC Baron 0.0
	0.0, // RC Raider 0.0
	1.8, // Glendale  1.8
	2.1, // Oceanic 2.1
	0.5, // Sanchez 0.5
	3.0, // Sparrow 3.0
	3.2, // Patriot 3.2
	0.5, // Quad 0.5
	2.5, // Coastguard 2.5
	2.0, // Dinghy 2.0
	2.3, // Hermes 2.3
	3.0, // Sabre 3.0
	2.2, // Rustler 2.2
	3.2, // ZR-350 3.2
	2.0, // Walton 2.0 
	1.8, // Regina 1.8
	2.3, // Comet 2.3
	0.0, // BMX 0.0
	2.8, // Burrito 2.8
	3.0, // Camper 3.0
	4.2, // Marquis 4.2
	1.2, // Baggage 1.2
	4.5, // Dozer 4.5
	7.6, // Maverick 7.6
	7.6, // SAN News Maverick 7.6
	2.7, // Rancher 2.7
	2.7, // FBI Rancher 2.7
	2.3, // Virgo 2.3
	2.0, // Greenwood 2.0
	4.2, // Jetmax 4.2
	4.0, // Hotring Racer 4.0
	3.7, // Sandking 3.7
	2.0, // Blista Compact 2.0
	7.6, // Police Maverick 7.6
	3.0, // Boxville 3.0
	3.2, // Benson 3.2
	2.2, // Mesa 2.2
	0.0, // RC Goblin 0.0
	4.0, // Hotring Racer A 4.0
	4.0, // Hotring Racer B 4.0
	3.0, // Bloodring Banger 3.0
	2.8, // Rancher Lure 2.8
	3.2, // Super GT 3.2
	2.5, // Elegant 2.5
	3.6, // Journey 3.6
	0.0, // Bike 0.0
	0.0, // Mountain Bike 0.0
	8.5, // Beagle 8.5
	10.3, // Cropduster 10.3
	9.6, // Stuntplane 9.6
	6.2, // Tanker 6.2
	7.4, // Roadtrain 7.4
	1.9, // Nebula 1.9
	2.0, // Majestic 2.0
	2.2, // Buccaneer 2.2
	8.0, // Shamal 8.0
	10.3, // Hydra 10.3
	0.5, // FCR-900 0.5
	1.2, // NRG-500 1.2
	1.0, // HPV1000 1.0
	3.7, // Cement Truck 3.7
	4.2, // Towtruck 4.2
	2.2, // Fortune 2.2
	1.6, // Cadrona 1.6
	2.7, // FBI Truck 2.7
	1.6, // Willard 1.6
	1.0, // Forklift 1.0
	1.1, // Tractor 1.1
	3.5, // Combine Harvester 3.5
	2.6, // Feltzer 2.6
	3.0, // Remington 3.0
	3.2, // Slamvan 3.2
	2.8, // Blade 2.8
	15.6, // Freight (Train) 15.6
	15.6, // Brownstreak (Train) 15.6
	1.3, // Vortex 1.3
	1.8, // Vincent 1.8
	3.5, // Bullet 3.5
	1.8, // Clover 1.8
	2.2, // Sadler 2.2
	4.6, // Firetruck LA 4.6
	3.4, // Hustler 3.4
	1.6, // Intruder 1.6
	1.5, // Primo 1.5
	8.6, // Cargobob 8.6
	1.8, // Tampa 1.8
	1.8, // Sunrise 1.8
	2.5, // Merit 2.4
	2.5, // Utility Van 2.5
	1.6, // Nevada 1.6
	2.4, // Yosemite 2.4
	1.9, // Windsor 1.9
	5.0, // Monster "A" 5.0
	5.0, // Monster "B" 5.0 
	2.4, // Uranus 2.4
	2.6, // Jester 2.6
	2.8, // Sultan 2.8
	2.2, // Stratum 2.2
	2.5, // Elegy 2.5
	7.2, // Raindance 7.2
	0.0, // RC Tiger 0.0
	2.0, // Flash 2.0
	2.2, // Tahoma 2.2
	2.6, // Savanna 2.6
	1.6, // Bandito 1.4
	15.6, // Freight Flat Trailer (Train) 15.6
	15.6, // Streak Trailer (Train) 15.6
	0.2, // Kart 0.2
	0.1, // Mower 0.1
	4.2, // Dune 4.2
	0.3, // Sweeper 0.3
	2.6, // Broadway 2.6
	2.4, // Tornado 2.4
	22.0, // AT400 22.0
	4.2, // DFT-30 4.2
	3.2, // Huntley 3.2
	3.0, // Stafford 3.0
	0.4, // BF-400 0.4
	2.7, // Newsvan 2.7
	0.2, // Tug 0.2
	0.2, // Petrol Trailer 0.0
	2.2, // Emperor 2.2
	0.6, // Wayfarer 0.6
	1.9, // Euros 1.9
	3.0, // Hotdog 3.0
	1.6, // Club 1.6
	15.6, // Freight Box Trailer (Train) 15.6
	0.0, // Article Trailer 3 0.0
	22.0, // Andromada 22.0
	7.2, // Dodo 7.2
	0.0, // RC Cam 0.0 
	4.4, // Launch 4.4
	2.6, // Police Car (LSPD) 2.6
	2.6, // Police Car (SFPD) 2.6
	2.6, // Police Car (LVPD) 2.6
	3.2, // Police Ranger 3.2
	2.0, // Picador 2.0
	5.2, // S.W.A.T. 5.2
	2.0, // Alpha 2.0
	3.6, // Phoenix 3.6
	2.0, // Glendale Shit 2.0
	1.8, // Sadler Shit 1.8
	0.0, // Baggage Trailer "A" 0.0
	0.0, // Baggage Trailer "B" 0.0
	0.0, // Tug Stairs Trailer 0.0
	3.2, // Boxville 3.2
	0.0, // Farm Trailer 0.0
	0.0 // Utility Trailer 0.0
};

new Float:VehicleFuelUsageList[212] = {
	0.009090, // Landstalker
	0.005136, // Bravura
	0.008454, // Buffalo
	0.022727, // Linerunner
	0.006045, // Perrenial
	0.008181, // Sentinel
	0.175454, // Dumper
	0.038136, // Firetruck
	0.033636, // Trashmaster
	0.012409, // Stretch
	0.004818, // Manana
	0.007863, // Infernus
	0.008454, // Voodoo
	0.011181, // Pony
	0.016636, // Mule
	0.007863, // Cheetah
	0.013909, // Ambulance
	0.168772, // Leviathan
	0.008454, // Moonbeam
	0.007545, // Esperanto
	0.007227, // Taxi
	0.008772, // Washington
	0.007545, // Bobcat
	0.006636, // Mr Whoopee
	0.006954, // BF Injection
	0.126045, // Hunter
	0.007863, // Premier
	0.019999, // Enforcer
	0.032727, // Securicar
	0.008454, // Banshee
	0.024545, // Predator
	0.032727, // Bus
	0.220590, // Rhino
	0.059954, // Barracks
	0.008181, // Hotknife
	0.029045, // Article Trailer
	0.006318, // Previon
	0.055454, // Coach
	0.008454, // Cabbie
	0.007863, // Stallion
	0.008181, // Rumpo
	0.005136, // RC Bandit
	0.009363, // Romero
	0.046318, // Packer
	0.026954, // Monster
	0.007863, // Admiral
	0.024818, // Squalo
	0.010909, // Seasparrow
	0.004818, // Pizzaboy
	0.009090, // Tram
	0.029045, // Article Trailer 2
	0.008181, // Turismo
	0.017863, // Speeder
	0.024227, // Reefer
	0.024545, // Tropic
	0.049090, // Flatbed
	0.020272, // Yankee
	0.004227, // Caddy
	0.009090, // Solair
	0.008772, // RC Van
	0.025727, // Skimmer
	0.008181, // PCJ-600
	0.004818, // Faggio
	0.006954, // Freeway
	0.000000, // RC Baron
	0.005136, // RC Raider
	0.007863, // Glendale
	0.007545, // Oceanic
	0.008181, // Sanchez
	0.009363, // Sparrow
	0.012090, // Patriot
	0.004227, // Quad
	0.006318, // Coastguard
	0.001772, // Dinghy
	0.008181, // Hermes
	0.008181, // Sabre
	0.027863, // Rustler
	0.007863, // ZR-350
	0.006636, // Walton
	0.006636, // Regina
	0.007545, // Comet
	0.002727, // BMX
	0.009363, // Burrito
	0.007227, // Camper
	0.122727, // Marquis
	0.004818, // Baggage
	0.041818, // Dozer
	0.029363, // Maverick
	0.012090, // News Chopper
	0.011181, // Rancher
	0.015136, // FBI Rancher
	0.006954, // Virgo
	0.007545, // Greenwood
	0.033636, // Jetmax
	0.008772, // Hotring
	0.009090, // Sandking
	0.006318, // Blista Compact
	0.026636, // Police Maverick
	0.025409, // Boxville
	0.016045, // Benson
	0.006318, // Mesa
	0.005136, // RC Goblin
	0.008772, // Hotring Racer A
	0.008772, // Hotring Racer B
	0.009363, // Bloodring Banger
	0.011181, // Rancher
	0.007227, // Super GT
	0.008772, // Elegant
	0.016045, // Journey
	0.002727, // Bike
	0.003590, // Mountain Bike
	0.072999, // Beagle
	0.027863, // Cropdust
	0.022409, // Stunt
	0.022727, // Tanker
	0.029954, // Roadtrain
	0.007227, // Nebula
	0.006954, // Majestic
	0.008454, // Buccaneer
	0.079045, // Shamal
	0.048136, // Hydra
	0.008181, // FCR-900
	0.009363, // NRG-500
	0.008181, // HPV1000
	0.033636, // Cement Truck
	0.016363, // Tow Truck
	0.007863, // Fortune
	0.005454, // Cadrona
	0.015136, // FBI Truck
	0.007545, // Willard
	0.004818, // Forklift
	0.008772, // Tractor
	0.049090, // Combine
	0.009090, // Feltzer
	0.008181, // Remington
	0.011500, // Slamvan
	0.006954, // Blade
	0.057545, // Freight
	0.057545, // Streak
	0.005727, // Vortex
	0.006636, // Vincent
	0.007545, // Bullet
	0.007227, // Clover
	0.008772, // Sadler
	0.038136, // Firetruck LA
	0.007863, // Hustler
	0.007545, // Intruder
	0.006636, // Primo
	0.059090, // Cargobob
	0.008454, // Tampa
	0.006636, // Sunrise
	0.008454, // Merit
	0.011772, // Utility
	0.056954, // Nevada
	0.011181, // Yosemite
	0.008454, // Windsor
	0.026954, // Monster A
	0.026954, // Monster B
	0.006636, // Uranus
	0.008454, // Jester
	0.008181, // Sultan
	0.008181, // Stratum
	0.008181, // Elegy
	0.085727, // Raindance
	0.005136, // RC Tiger
	0.007227, // Flash
	0.008454, // Tahoma
	0.006954, // Savanna
	0.008181, // Bandito
	0.033636, // Freight Flat
	0.033636, // Streak Carriage
	0.003000, // Kart
	0.002727, // Mower
	0.052999, // Duneride
	0.003000, // Sweeper
	0.007863, // Broadway
	0.007863, // Tornado
	0.214545, // AT-400
	0.033636, // DFT-30
	0.008590, // Huntley
	0.007272, // Stafford
	0.008181, // BF-400
	0.008772, // Newsvan
	0.003318, // Tug
	0.029045, // Petrol Trailer
	0.007863, // Emperor
	0.007227, // Wayfarer
	0.007227, // Euros
	0.025409, // Hotdog
	0.008181, // Club
	0.033636, // Freight Box Trailer
	0.029045, // Article Trailer 3
	0.194227, // Andromada
	0.027863, // Dodo
	0.007545, // RC Cam
	0.017545, // Launch
	0.008772, // LSPD
	0.008772, // SFPD
	0.008772, // LVPD
	0.011181, // Police Ranger
	0.008181, // Picador
	0.016045, // S.W.A.T. Van
	0.007545, // Alpha
	0.008454, // Phoenix
	0.007863, // Glendale
	0.008772, // Sadler
	0.004818, // Baggage Trailer A
	0.004818, // Baggage Trailer B
	0.005727, // Stair Trailer
	0.025409, // Boxville
	0.003590, // Farm Plow
	0.004818, // Utility Trailer
};

stock IsModelTrailer(model)
{
	switch(model)
	{
	    case 435, 450, 584, 591: return true;
	}
	return false;
}

stock IsModelForTrucking(model)
{
	if(model == 422 || model == 478 || model == 543 || model == 600 || model == 440 || model == 413 || model == 482 || model == 414 || model == 456 || model == 498 || model == 499 || model == 403 || model == 514 || model == 515 || model == 578 || model == 455) return true;
	return false;
}
stock IsModelTruck(model)
{
	if(model == 403 || model == 514 || model == 515) return true;
	return false;
}
stock IsModelPedal(model)
{
	if(model == 481 || model == 509 || model == 510) return true;
	return false;
} 
stock IsModelBike(model)
{ 
	if(model == 481 || model == 509 || model == 510 || model == 448 || model == 461 || model == 462 || model == 463 || model == 468 || model == 471 || model == 521 || model == 522 || model == 523 || model == 581 || model == 586) return true;
	return false;
}
stock IsModelBoat(model)
{ 
	if(model == 472 || model == 473 || model == 484 || model == 493 || model == 595 || model == 430 || model == 446 || model == 452 || model == 453 || model == 454) return true;
	return false;
}
stock IsModelPlane(model)
{ 
	if(model == 487 || model == 488 || model == 497 || model == 460 || model == 476 || model == 511 || model == 512 || model == 513 || model == 519 || model == 520 || model == 553 || model == 577 || model == 592 || model == 593) return true;
	return false;
}

stock VehicleHaveWindows(model)
{
	if(!VehicleHaveEngine(model))
	    return false;
	switch(model)
	{
	    case 424, 429, 430, 432, 439, 446, 452, 453, 454, 457, 471, 472, 473,
			 480, 484, 485, 486, 493, 530, 531, 533, 536, 539, 555, 567, 568,
			 571, 572, 575, 595, 462, 463, 461, 448, 468, 481, 509, 510, 521,
			 522, 523, 581, 586:
        return false;
	}
	return true;
}
stock VehicleHaveEngine(model)
{
	switch (model)
	{
	    case 509, 481, 510:
        return false;
	}
	return true;
}

stock decode_panels(panels, &front_left_panel, &front_right_panel, &rear_left_panel, &rear_right_panel, &windshield, &front_bumper, &rear_bumper)
{
    front_left_panel = panels & 15;
    front_right_panel = panels >> 4 & 15;
    rear_left_panel = panels >> 8 & 15;
    rear_right_panel = panels >> 12 & 15;
    windshield = panels >> 16 & 15;
    front_bumper = panels >> 20 & 15;
    rear_bumper = panels >> 24 & 15;
}

stock encode_panels(front_left_panel, front_right_panel, rear_left_panel, rear_right_panel, windshield, front_bumper, rear_bumper)
{
    return front_left_panel | (front_right_panel << 4) | (rear_left_panel << 8) | (rear_right_panel << 12) | (windshield << 16) | (front_bumper << 20) | (rear_bumper << 24);
}
 
stock decode_doors(doors, &bonnet, &boot, &driver_door, &passenger_door)
{
    bonnet = doors & 7;
    boot = doors >> 8 & 7;
    driver_door = doors >> 16 & 7;
    passenger_door = doors >> 24 & 7;
}

stock encode_doors(bonnet, boot, driver_door, passenger_door)
{
    return bonnet | (boot << 8) | (driver_door << 16) | (passenger_door << 24);
}

stock decode_lights(lights, &front_left_light, &front_right_light, &back_lights)
{
    front_left_light = lights & 1;
    front_right_light = lights >> 2 & 1;
    back_lights = lights >> 6 & 1;
}

stock encode_lights(front_left_light, front_right_light, back_lights)
{
    return front_left_light | (front_right_light << 2) | (back_lights << 6);
}

stock decode_tires(tires, &rear_right_tire, &front_right_tire, &rear_left_tire, &front_left_tire)
{
    rear_right_tire = tires & 1;
    front_right_tire = tires >> 1 & 1;
    rear_left_tire = tires >> 2 & 1;
    front_left_tire = tires >> 3 & 1;
}

stock encode_tires(rear_right_tire, front_right_tire, rear_left_tire, front_left_tire)
{
	return rear_right_tire | (front_right_tire << 1) | (rear_left_tire << 2) | (front_left_tire << 3);
}

stock sd_LinkVehicleToInterior(vehicleid, interiorid)
{
	VehicleInfo[vehicleid][vInt] = interiorid;
	return LinkVehicleToInterior(vehicleid, interiorid);
}

stock sd_SetVehicleToRespawn(vehicleid)
{
	AcVehicleData[vehicleid][VehicleHealth] = 1000.0;
	new __reset_Trunk[E_FACTION_TRUNK_WEAPONS_DATA];
	for(new i = 0; i < MAX_VEHICLE_WEAPON_SLOTS; i++) VehicleWeaponsInventory[vehicleid][i] = __reset_Trunk;
	return SetVehicleToRespawn(vehicleid);
}

stock sd_CreateVehicle(model, Float:x, Float:y, Float:z, Float:a, color_1, color_2, respawn_time, add_siren = 0)
{
	new 
		vehicleid = CreateVehicle(model, x, y, z, a, color_1, color_2, respawn_time, add_siren);
	new 
		r_color_1, 
		r_color_2;
	if(vehicleid != INVALID_VEHICLE_ID)
	{
		if(color_1 < 0) r_color_1 = random(255);
		else r_color_1 = color_1; 
		if(color_2 < 0) r_color_2 = random(255);
		else r_color_2 = color_2;
		ChangeVehicleColor(vehicleid, r_color_1, r_color_2);
		AcVehicleData[vehicleid][VehicleHealth] = 1000.0;

		new __reset_VehicleInfo[E_VEHICLE_DATA],
			__reset_VehicleInventory[E_INVENTORY_DATA];
		VehicleInfo[vehicleid] = __reset_VehicleInfo;
		for(new slot = 0; slot < MAX_INVENTORY_SLOTS; slot++) VehicleInventory[vehicleid][slot] = __reset_VehicleInventory;
		if(Iter_Contains(Vehicle, vehicleid))
		{
			Iter_Remove(Vehicle, vehicleid);
		}
		VehicleInfo[vehicleid][vModel] = model;
		VehicleInfo[vehicleid][vRespawnTime] = respawn_time;
		VehicleInfo[vehicleid][vAddSiren] = add_siren;
		VehicleInfo[vehicleid][vColor1] = r_color_1;
		VehicleInfo[vehicleid][vColor2] = r_color_2;
		VehicleInfo[vehicleid][vUnitLabel] = INVALID_3DTEXT_ID;
		RentedBy[vehicleid] = INVALID_PLAYER_ID;
		for(new i = 0; i < 4; i++) VehicleInfo[vehicleid][vObjects][i] = INVALID_OBJECT_ID;
		Iter_Add(Vehicle, vehicleid);
	}
	#if SERVER_DEBUG_LEVEL >= 2 
		printf("[create] CreateVehicle(%d) called, ID: %d", model, vehicleid);
	#endif
	return vehicleid;
}

stock sd_ChangeVehicleColor(vehicleid, color1, color2)
{
	VehicleInfo[vehicleid][vColor1] = color1;
	VehicleInfo[vehicleid][vColor2] = color2;
	return ChangeVehicleColor(vehicleid, color1, color2);
}

stock sd_DestroyVehicle(vehicleid)
{
	#if SERVER_DEBUG_LEVEL >= 2 
		printf("[destroy] DestroyVehicle(%d, %d) called", vehicleid, GetVehicleModel(vehicleid));
	#endif
	new __reset_VehicleInfo[E_VEHICLE_DATA];
	if(IsValidDynamic3DTextLabel(VehicleInfo[vehicleid][vUnitLabel])) DestroyDynamic3DTextLabel(VehicleInfo[vehicleid][vUnitLabel]);
	for(new i = 0; i < 4; i++)
	{
		if(IsValidDynamicObject(VehicleInfo[vehicleid][vObjects][i])) DestroyDynamicObject(VehicleInfo[vehicleid][vObjects][i], "vehicle", "destroy");
	}
	
	VehicleInfo[vehicleid] = __reset_VehicleInfo;

	for(new i = 0; i < 4; i++)
	{
		VehicleInfo[vehicleid][vObjects][i] = INVALID_OBJECT_ID;
	}
	VehicleInfo[vehicleid][vUnitLabel] = INVALID_3DTEXT_ID;
	format(VehicleInfo[vehicleid][vUnitText], 1, "");
	DestroyVehicle(vehicleid);
	return Iter_Remove(Vehicle, vehicleid);
}

stock GetModelName(model)
{
	new string[64];
	if(400 <= model <= 612) format(string, sizeof string, "%s", aVehicleNames[model-400]);
	else format(string, sizeof string, "model%d", model);
	return string;
}