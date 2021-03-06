//
//  CountryCode.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "CountryCode.h"

@interface CountryCode()

@property NSDictionary* dictCodeCountry;

@end

@implementation CountryCode

+ (instancetype _Nonnull)sharedInstance
{
    static CountryCode *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CountryCode alloc] init];
        [sharedInstance initContent];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (NSString*) getCountryOfCode:(NSString*) strCode
{
    NSString* strCountry = [_dictCodeCountry objectForKey:strCode];
    return strCountry;
}

- (NSString*) getCodeOfCountry:(NSString*) strCountry
{
    NSString* strCode = [_dictCodeCountry allKeysForObject:strCountry].firstObject;
    return strCode;
}

- (NSArray*) getAllCountries
{
    NSMutableArray* arrayCountry = [NSMutableArray arrayWithArray:[_dictCodeCountry allValues]];
    [arrayCountry sortUsingComparator:^(NSString* a, NSString* b) {
        return [a compare:b];
    }];
    return arrayCountry;
}

- (void) initContent
{
    if (_dictCodeCountry) {
        return;
    }
    _dictCodeCountry = @{
    @"AF":@"Afghanistan",
    @"AX":@"Aland Islands",
    @"AL":@"Albania",
    @"DZ":@"Algeria",
    @"AS":@"American Samoa",
    @"AD":@"Andorra",
    @"AO":@"Angola",
    @"AI":@"Anguilla",
    @"AQ":@"Antarctica",
    @"AG":@"Antigua and Barbuda",
    @"AR":@"Argentina",
    @"AM":@"Armenia",
    @"AW":@"Aruba",
    @"AU":@"Australia",
    @"AT":@"Austria",
    @"AZ":@"Azerbaijan",
    @"BS":@"Bahamas",
    @"BH":@"Bahrain",
    @"BD":@"Bangladesh",
    @"BB":@"Barbados",
    @"BY":@"Belarus",
    @"BE":@"Belgium",
    @"BZ":@"Belize",
    @"BJ":@"Benin",
    @"BM":@"Bermuda",
    @"BT":@"Bhutan",
    @"BO":@"Bolivia",
    @"BA":@"Bosnia and Herzegovina",
    @"BW":@"Botswana",
    @"BV":@"Bouvet Island",
    @"BR":@"Brazil",
    @"VG":@"British Virgin Islands",
    @"IO":@"British Indian Ocean Territory",
    @"BN":@"Brunei Darussalam",
    @"BG":@"Bulgaria",
    @"BF":@"Burkina Faso",
    @"BI":@"Burundi",
    @"KH":@"Cambodia",
    @"CM":@"Cameroon",
    @"CA":@"Canada",
    @"CV":@"Cape Verde",
    @"KY":@"Cayman Islands",
    @"CF":@"Central African Republic",
    @"TD":@"Chad",
    @"CL":@"Chile",
    @"CN":@"China",
    @"CX":@"Christmas Island",
    @"CC":@"Cocos (Keeling) Islands",
    @"CO":@"Colombia",
    @"KM":@"Comoros",
    @"CG":@"Congo",
    @"CD":@"Congo, The Democratic Republic of the",
    @"CK":@"Cook Islands",
    @"CR":@"Costa Rica",
    @"CI":@"Cote D\"Ivoire",
    @"HR":@"Croatia",
    @"CU":@"Cuba",
    @"CY":@"Cyprus",
    @"CZ":@"Czech Republic",
    @"DK":@"Denmark",
    @"DJ":@"Djibouti",
    @"DM":@"Dominica",
    @"DO":@"Dominican Republic",
    @"EC":@"Ecuador",
    @"EG":@"Egypt",
    @"SV":@"El Salvador",
    @"GQ":@"Equatorial Guinea",
    @"ER":@"Eritrea",
    @"EE":@"Estonia",
    @"ET":@"Ethiopia",
    @"FK":@"Falkland Islands (Malvinas)",
    @"FO":@"Faroe Islands",
    @"FJ":@"Fiji",
    @"FI":@"Finland",
    @"FR":@"France",
    @"GF":@"French Guiana",
    @"PF":@"French Polynesia",
    @"TF":@"French Southern Territories",
    @"GA":@"Gabon",
    @"GM":@"Gambia",
    @"GE":@"Georgia",
    @"DE":@"Germany",
    @"GH":@"Ghana",
    @"GI":@"Gibraltar",
    @"GR":@"Greece",
    @"GL":@"Greenland",
    @"GD":@"Grenada",
    @"GP":@"Guadeloupe",
    @"GU":@"Guam",
    @"GT":@"Guatemala",
    @"GG":@"Guernsey",
    @"GN":@"Guinea",
    @"GW":@"Guinea-Bissau",
    @"GY":@"Guyana",
    @"HT":@"Haiti",
    @"HM":@"Heard ),  Islands",
    @"VA":@"Holy See (Vatican City State)",
    @"HN":@"Honduras",
    @"HK":@"Hong Kong",
    @"HU":@"Hungary",
    @"IS":@"Iceland",
    @"IN":@"India",
    @"ID":@"Indonesia",
    @"IR":@"Iran, Islamic Republic Of",
    @"IQ":@"Iraq",
    @"IE":@"Ireland",
    @"IM":@"Isle of Man",
    @"IL":@"Israel",
    @"IT":@"Italy",
    @"JM":@"Jamaica",
    @"JP":@"Japan",
    @"JE":@"Jersey",
    @"JO":@"Jordan",
    @"KZ":@"Kazakhstan",
    @"KE":@"Kenya",
    @"KI":@"Kiribati",
    @"KP":@"Korea, Democratic People\"s Republic of",
    @"KR":@"Korea, Republic of",
    @"KW":@"Kuwait",
    @"KG":@"Kyrgyzstan",
    @"LA":@"Lao People\"s Democratic Republic",
    @"LV":@"Latvia",
    @"LB":@"Lebanon",
    @"LS":@"Lesotho",
    @"LR":@"Liberia",
    @"LY":@"Libya",
    @"LI":@"Liechtenstein",
    @"LT":@"Lithuania",
    @"LU":@"Luxembourg",
    @"MO":@"Macao",
    @"MK":@"Macedonia, Republic of",
    @"MG":@"Madagascar",
    @"MW":@"Malawi",
    @"MY":@"Malaysia",
    @"MV":@"Maldives",
    @"ML":@"Mali",
    @"MT":@"Malta",
    @"MH":@"Marshall Islands",
    @"MQ":@"Martinique",
    @"MR":@"Mauritania",
    @"MU":@"Mauritius",
    @"YT":@"Mayotte",
    @"MX":@"Mexico",
    @"FM":@"Micronesia, Federated States of",
    @"MD":@"Moldova",
    @"MC":@"Monaco",
    @"MN":@"Mongolia",
    @"ME":@"Montenegro",
    @"MS":@"Montserrat",
    @"MA":@"Morocco",
    @"MZ":@"Mozambique",
    @"MM":@"Myanmar",
    @"NA":@"Namibia",
    @"NR":@"Nauru",
    @"NP":@"Nepal",
    @"NL":@"Netherlands",
    @"AN":@"Netherlands Antilles",
    @"NC":@"New Caledonia",
    @"NZ":@"New Zealand",
    @"NI":@"Nicaragua",
    @"NE":@"Niger",
    @"NG":@"Nigeria",
    @"NU":@"Niue",
    @"NF":@"Norfolk Island",
    @"MP":@"Northern Mariana Islands",
    @"NO":@"Norway",
    @"OM":@"Oman",
    @"PK":@"Pakistan",
    @"PW":@"Palau",
    @"PS":@"Palestinian Territory, Occupied",
    @"PA":@"Panama",
    @"PG":@"Papua New Guinea",
    @"PY":@"Paraguay",
    @"PE":@"Peru",
    @"PH":@"Philippines",
    @"PN":@"Pitcairn",
    @"PL":@"Poland",
    @"PT":@"Portugal",
    @"PR":@"Puerto Rico",
    @"QA":@"Qatar",
    @"RE":@"Reunion",
    @"RO":@"Romania",
    @"RU":@"Russian Federation",
    @"RW":@"RWANDA",
    @"BL":@"Saint ­Barthélemy",
    @"SH":@"Saint Helena",
    @"KN":@"Saint Kitts and Nevis",
    @"LC":@"Saint Lucia",
    @"MF":@"Saint­-Martin (French part)",
    @"PM":@"Saint Pierre and Miquelon",
    @"VC":@"Saint Vincent and Grenadines",
    @"WS":@"Samoa",
    @"SM":@"San Marino",
    @"ST":@"Sao Tome and Principe",
    @"SA":@"Saudi Arabia",
    @"SN":@"Senegal",
    @"RS":@"Serbia",
    @"SC":@"Seychelles",
    @"SL":@"Sierra Leone",
    @"SG":@"Singapore",
    @"SK":@"Slovakia",
    @"SI":@"Slovenia",
    @"SB":@"Solomon Islands",
    @"SO":@"Somalia",
    @"ZA":@"South Africa",
    @"GS":@"South Georgia and the South Sandwich Islands",
    @"SS":@"South Sudan",
    @"ES":@"Spain",
    @"LK":@"Sri Lanka",
    @"SD":@"Sudan",
    @"SR":@"Suriname",
    @"SJ":@"Svalbard and Jan Mayen Islands",
    @"SZ":@"Swaziland",
    @"SE":@"Sweden",
    @"CH":@"Switzerland",
    @"SY":@"Syrian Arab Republic (Syria)",
    @"TW":@"Taiwan, Republic of China",
    @"TJ":@"Tajikistan",
    @"TZ":@"Tanzania, United Republic of",
    @"TH":@"Thailand",
    @"TL":@"Timor-Leste",
    @"TG":@"Togo",
    @"TK":@"Tokelau",
    @"TO":@"Tonga",
    @"TT":@"Trinidad and Tobago",
    @"TN":@"Tunisia",
    @"TR":@"Turkey",
    @"TM":@"Turkmenistan",
    @"TC":@"Turks and Caicos Islands",
    @"TV":@"Tuvalu",
    @"UG":@"Uganda",
    @"UA":@"Ukraine",
    @"AE":@"United Arab Emirates",
    @"GB":@"United Kingdom",
    @"US":@"United States of America",
    @"UM":@"United States Minor Outlying Islands",
    @"UY":@"Uruguay",
    @"UZ":@"Uzbekistan",
    @"VU":@"Vanuatu",
    @"VE":@"Venezuela",
    @"VN":@"Vietnam",
    @"VI":@"Virgin Islands, U.S.",
    @"WF":@"Wallis and Futuna Islands",
    @"EH":@"Western Sahara",
    @"YE":@"Yemen",
    @"ZM":@"Zambia",
    @"ZW":@"Zimbabwe"};
}

@end
