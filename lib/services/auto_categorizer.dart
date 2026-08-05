import '../models/transaction.dart';

class AutoCategory {
  final String name;
  final String group;

  const AutoCategory(this.name, this.group);
}

class _Rule {
  final RegExp pattern;
  final AutoCategory result;

  const _Rule(this.pattern, this.result);
}

/// Fills in a best-guess category for transactions Akahu didn't categorize.
/// Only ever consulted when there's no Akahu category and no manual
/// override - see [AppState.categoryNameFor]/[categoryGroupFor].
///
/// Category names/groups mirror Akahu's own NZFCC taxonomy (as observed on
/// real categorized transactions) wherever a natural match exists, so a
/// mixed real/auto spend breakdown doesn't fragment into near-duplicate
/// buckets. A handful of names (Transfers, Investments, Fees, Rent, Income,
/// Insurance, Airlines, Postal and courier services, Pet care services) have
/// no NZFCC equivalent and are fern's own.
///
/// Merchant lists are broad general-market coverage (major NZ + global
/// chains), not derived from any one person's transaction history.
class AutoCategorizer {
  AutoCategorizer._();

  static final RegExp _fcPrefix = RegExp(r'^FC\d{2}-\d{4}-\d+-\d+\s');

  static final List<_Rule> _rules = [
    // Own-bank internal payment references (format "FCxx-xxxx-xxxxxxx-xx
    // <memo>") that happen to mention stocks/a broker - checked before the
    // generic FC-prefix rule below.
    _Rule(
      RegExp(
        r'^FC\d{2}-\d{4}-\d+-\d+.*(STOCK|\bIB\b|SHARESIES|HATCH|'
        r'INVESTNOW|KERNEL)',
      ),
      const AutoCategory('Investments', 'Investments'),
    ),
    _Rule(
      RegExp(
        r'\bIRD\b|INLAND REVENUE|\bACC\b|\bMSD\b|WORK AND INCOME|'
        r'STUDYLINK|KIWISAVER',
      ),
      const AutoCategory(
        'National government services',
        'Professional Services',
      ),
    ),
    _Rule(
      RegExp(
        r'WOOLWORTHS|NEW WORLD|PAK.?N.?SAVE|COUNTDOWN|FRESH CHOICE|'
        r'FOUR SQUARE|SUPERETTE|\bALDI\b|\bCOSTCO\b|FARRO|MOORE WILSON|'
        r'\bIGA\b',
      ),
      const AutoCategory('Supermarkets and grocery stores', 'Food'),
    ),
    _Rule(
      RegExp(
        r"MCDONALD|KFC|BURGER KING|SUBWAY|DOMINO|PIZZA HUT|WENDY'?S|"
        r"CARL'?S JR|NANDO'?S|WINGSTOP|TACO BELL|HELL PIZZA|"
        r'GEORGIE PIE',
      ),
      const AutoCategory('Fast food stores', 'Lifestyle'),
    ),
    _Rule(
      RegExp(r'BAKERY|\bPIES?\b|PATISSERIE'),
      const AutoCategory('Bakeries', 'Food'),
    ),
    _Rule(
      RegExp(
        r'SUSHI|\bCAFE|COFFEE|RESTAURANT|KITCHEN|EATERY|DINER|'
        r'\bROLL\b|GOOD ?TIME|STARBUCKS|GLORIA JEAN|ESQUIRES|\bBISTRO\b',
      ),
      const AutoCategory('Cafes and restaurants', 'Lifestyle'),
    ),
    _Rule(
      RegExp(
        r'\bBEER\b|\bBREW|\bPUB\b|\bBAR\b|NIGHTCLUB|\bTAVERN\b|'
        r'\bLIQUOR\b|BOTTLE ?SHOP|\bVINEYARD\b|\bWINERY\b',
      ),
      const AutoCategory('Bars, pubs, nightclubs', 'Lifestyle'),
    ),
    _Rule(
      RegExp(
        r'\bGOLF|AXE THROW|\bWAKE\b|BOWLING|ESCAPE ROOM|\bCINEMA\b|'
        r'\bMOVIE\b|TICKETMASTER|EVENTFINDA|\bMUSEUM\b|\bZOO\b|'
        r'AQUARIUM|THEME PARK|TENPIN|LASER ?TAG|TRAMPOLINE',
      ),
      const AutoCategory(
        'Attractions, museums, zoos, amusement parks, circuses, exhibits',
        'Lifestyle',
      ),
    ),
    _Rule(
      RegExp(
        r'\bUBER\b|\bOLA\b|\bLYFT\b|\bBOLT\b|ZOOMY|\bTAXI\b|\bCABS?|'
        r'AT HOP|AUCKLAND TRANSPORT|METLINK|METRO CARD|GOWELLINGTON|'
        r'RITCHIES|INTERCITY|PARKING|WILSON P|EASY PARK',
      ),
      const AutoCategory(
        'Taxi, rideshare, and on-demand transport services',
        'Transport',
      ),
    ),
    _Rule(
      RegExp(
        r'\bBP\b|Z ENERGY|\bMOBIL\b|CALTEX|\bGULL\b|CHEVRON|'
        r'ALLIED PETROLEUM|WAITOMO FUEL|NPD FUEL',
      ),
      const AutoCategory('Fuel stations', 'Transport'),
    ),
    _Rule(
      RegExp(
        r'AIR ?NZ|JETSTAR|\bQANTAS\b|VIRGIN AUSTRALIA|EMIRATES|'
        r'\bAIRLINE\b|\bAIRWAYS\b',
      ),
      const AutoCategory('Airlines', 'Transport'),
    ),
    _Rule(
      RegExp(
        r'\bAIRBNB\b|BOOKING\.COM|HOTELS\.COM|\bEXPEDIA\b|\bMOTEL\b|'
        r'\bHOTEL\b|HOLIDAY PARK|BACKPACKERS',
      ),
      const AutoCategory(
        'Hotels, motels, temporary accommodation',
        'Lifestyle',
      ),
    ),
    _Rule(
      RegExp(
        r'\bGYM\b|FITNESS|ALLFIT|LES MILLS|ANYTIME FIT|EZYPAY|'
        r'\bF45\b|SNAP FITNESS|\bJETTS\b|CITY FITNESS|CROSSFIT|'
        r'PLANET FITNESS',
      ),
      const AutoCategory('Gym and fitness services', 'Health'),
    ),
    _Rule(
      RegExp(
        r'\bVULTR\b|\bAWS\b|AMAZON WEB|DIGITALOCEAN|\bLINODE\b|'
        r'\bGITHUB\b|GOOGLE CLOUD|GOOGLE WORKSPACE|MICROSOFT ?365|'
        r'\bHEROKU\b|CLOUDFLARE|\bOPENAI\b|ANTHROPIC|\bSLACK\b|\bZOOM\b|'
        r'\bNOTION\b|\bFIGMA\b|ADOBE|\bDROPBOX\b|\bATLASSIAN\b|\bJIRA\b',
      ),
      const AutoCategory(
        'Business software and cloud services',
        'Professional Services',
      ),
    ),
    _Rule(
      RegExp(
        r'NETFLIX|SPOTIFY|DISNEY|APPLE\.COM/BILL|PRIME VIDEO|'
        r'MEMBER SUBSCRIPT|\bYOUTUBE\b|\bNEON\b|LIGHTBOX|SKY TV|\bTVNZ\b|'
        r'THREENOW|\bHULU\b|\bHBO\b|\bTWITCH\b|\bSTEAM\b|PLAYSTATION|'
        r'\bXBOX\b|NINTENDO|EPIC GAMES',
      ),
      const AutoCategory(
        'Entertainment (not elsewhere classified)',
        'Lifestyle',
      ),
    ),
    _Rule(
      RegExp(
        r'PB TECH|NOEL LEEMING|JB HI-?FI|HARVEY NORMAN|MIGHTY APE|'
        r'COOLMOBILE|MYGUY|DICK SMITH|\bKOGAN\b',
      ),
      const AutoCategory('Electronic and appliance stores', 'Household'),
    ),
    _Rule(
      RegExp(
        r'AMAZON|REDBUBBLE|\bEBAY\b|\bTEMU\b|ALIEXPRESS|TRADE ME|'
        r'THE WAREHOUSE|\bKMART\b|\bFARMERS\b|BRISCOES|\bTARGET\b|'
        r'\bH&M\b|COTTON ?ON|GLASSONS',
      ),
      const AutoCategory('General retail stores', 'Household'),
    ),
    _Rule(
      RegExp(
        r'POWERSHOP|MERCURY|CONTACT ENERGY|GENESIS|TRUSTPOWER|'
        r'ELECTRIC KIWI|\bFLICK\b|NOVA ENERGY|PULSE ENERGY|'
        r'ENERGYONLINE',
      ),
      const AutoCategory('Electricity services', 'Utilities'),
    ),
    _Rule(
      RegExp(
        r'2DEGREES|SPARK|VODAFONE|ONE ?NZ|SKINNY|SLINGSHOT|\bORCON\b|'
        r'\bVOYAGER\b|\bFYX\b',
      ),
      const AutoCategory('Telecommunication services', 'Utilities'),
    ),
    _Rule(
      RegExp(r'DENTAL|\bDENTIST\b'),
      const AutoCategory('Dental services', 'Health'),
    ),
    _Rule(
      RegExp(r'PHARMACY|\bCHEMIST\b|UNICHEM|LIFE PHARMACY|GREEN CROSS'),
      const AutoCategory('Pharmacies', 'Health'),
    ),
    _Rule(
      RegExp(r'MEDICAL|\bDOCTOR\b|\bGP\b|\bCLINIC\b|HEALTHCARE'),
      const AutoCategory('Doctors and physicians', 'Health'),
    ),
    _Rule(
      RegExp(r'\bVET\b|VETERINARY|PETSTOCK|\bANIMATES\b|PET ?SHOP'),
      const AutoCategory('Pet care services', 'Household'),
    ),
    _Rule(
      RegExp(
        r'APPLIANCE|SERVICING|HANDYMAN|\bPLUMBER\b|ELECTRICIAN|'
        r'\bBUNNINGS\b|MITRE ?10|PLACEMAKERS|\bITM\b|\bCARTERS\b',
      ),
      const AutoCategory('Home furnishing and repair stores', 'Household'),
    ),
    _Rule(
      RegExp(r'\bLAWN\b|GARDEN|LANDSCAP'),
      const AutoCategory('Home and garden services', 'Household'),
    ),
    _Rule(
      RegExp(r'CHARTERED ACCOUNT|\bACCOUNTANT\b|\bBOOKKEEP|TAX AGENT'),
      const AutoCategory(
        'Accounting and tax services',
        'Professional Services',
      ),
    ),
    _Rule(
      RegExp(
        r'\bINSURANCE\b|\bAMI\b|\bTOWER\b|STATE INSURANCE|\bVERO\b|'
        r'\bFMG\b|FIDELITY LIFE|AA INSURANCE',
      ),
      const AutoCategory('Insurance', 'Insurance'),
    ),
    _Rule(
      RegExp(
        r'NZ ?POST|COURIERPOST|\bARAMEX\b|\bDHL\b|\bFEDEX\b|'
        r'\bCOURIER\b|PARCEL',
      ),
      const AutoCategory('Postal and courier services', 'Household'),
    ),
    _Rule(
      RegExp(
        r'UNIVERSITY|POLYTECHNIC|\bPOLYTECH\b|SCHOOL FEES|'
        r'\bTUITION\b|\bWANANGA\b',
      ),
      const AutoCategory('Education services', 'Education'),
    ),
    _Rule(
      RegExp(
        r'\bFEE\b|OFFSHORESERVICEMARGIN|\bINTEREST\b|OVERDRAFT|'
        r'\bSURCHARGE\b',
      ),
      const AutoCategory('Fees', 'Fees'),
    ),
    _Rule(RegExp(r'\bRENT\b|\bBOND\b'), const AutoCategory('Rent', 'Housing')),
    // Shopify-processed card purchases ("CARD 1234 SP <merchant>" / "USD
    // 12.34 SP <merchant>at ...") - almost always small/independent online
    // retailers that don't match a more specific rule above.
    _Rule(
      RegExp(r'CARD \d+ SP [A-Z]|USD [\d.]+ SP [A-Z]'),
      const AutoCategory('General retail stores', 'Household'),
    ),
  ];

  static String? lookupGroup(String categoryName) {
    for (final rule in _rules) {
      if (rule.result.name == categoryName) return rule.result.group;
    }
    return null;
  }

  static Set<String> get allCategoryNames {
    final names = <String>{};
    for (final rule in _rules) {
      names.add(rule.result.name);
    }
    return names;
  }

  static Map<String, List<String>> get categoriesByGroup {
    final map = <String, List<String>>{};
    for (final rule in _rules) {
      map.putIfAbsent(rule.result.group, () => []).add(rule.result.name);
    }
    final result = <String, List<String>>{};
    for (final e in map.entries) {
      result[e.key] = e.value.toSet().toList()..sort();
    }
    return result;
  }

  static AutoCategory? categorize(Transaction tx) {
    final haystack = '${tx.description} ${tx.merchant?.name ?? ''}'
        .toUpperCase();

    for (final rule in _rules) {
      if (rule.pattern.hasMatch(haystack)) return rule.result;
    }

    // Own-bank payment references with no recognisable merchant/keyword are
    // almost always transfers to another person or account, not purchases.
    if (_fcPrefix.hasMatch(haystack)) {
      return const AutoCategory('Transfers', 'Transfers');
    }

    if (tx.type == 'TRANSFER') {
      return const AutoCategory('Transfers', 'Transfers');
    }
    if (tx.type == 'DIRECT CREDIT' && tx.amount > 0) {
      return const AutoCategory('Income', 'Income');
    }

    return null;
  }
}
