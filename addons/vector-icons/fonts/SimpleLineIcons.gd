
const FontData = preload("SimpleLineIcons.ttf")
const Cheatsheet = {
	"action-redo": "\uE051",
	"action-undo": "\uE050",
	"anchor": "\uE029",
	"arrow-down": "\uE604",
	"arrow-down-circle": "\uE07B",
	"arrow-left": "\uE605",
	"arrow-left-circle": "\uE07A",
	"arrow-right": "\uE606",
	"arrow-right-circle": "\uE079",
	"arrow-up": "\uE607",
	"arrow-up-circle": "\uE078",
	"badge": "\uE028",
	"bag": "\uE04F",
	"ban": "\uE07C",
	"basket": "\uE04E",
	"basket-loaded": "\uE04D",
	"bell": "\uE027",
	"book-open": "\uE04C",
	"briefcase": "\uE04B",
	"bubble": "\uE07D",
	"bubbles": "\uE04A",
	"bulb": "\uE076",
	"calculator": "\uE049",
	"calendar": "\uE075",
	"call-end": "\uE048",
	"call-in": "\uE047",
	"call-out": "\uE046",
	"camera": "\uE07F",
	"camrecorder": "\uE07E",
	"chart": "\uE077",
	"check": "\uE080",
	"chemistry": "\uE026",
	"clock": "\uE081",
	"close": "\uE082",
	"cloud-download": "\uE083",
	"cloud-upload": "\uE084",
	"compass": "\uE045",
	"control-end": "\uE074",
	"control-forward": "\uE073",
	"control-pause": "\uE072",
	"control-play": "\uE071",
	"control-rewind": "\uE070",
	"control-start": "\uE06F",
	"credit-card": "\uE025",
	"crop": "\uE024",
	"cup": "\uE044",
	"cursor": "\uE06E",
	"cursor-move": "\uE023",
	"diamond": "\uE043",
	"direction": "\uE042",
	"directions": "\uE041",
	"disc": "\uE022",
	"dislike": "\uE06D",
	"doc": "\uE085",
	"docs": "\uE040",
	"drawer": "\uE03F",
	"drop": "\uE03E",
	"earphones": "\uE03D",
	"earphones-alt": "\uE03C",
	"emotsmile": "\uE021",
	"energy": "\uE020",
	"envelope": "\uE086",
	"envelope-letter": "\uE01F",
	"envelope-open": "\uE01E",
	"equalizer": "\uE06C",
	"event": "\uE619",
	"exclamation": "\uE617",
	"eye": "\uE087",
	"eyeglass": "\uE01D",
	"feed": "\uE03B",
	"film": "\uE03A",
	"fire": "\uE01C",
	"flag": "\uE088",
	"folder": "\uE089",
	"folder-alt": "\uE039",
	"frame": "\uE038",
	"game-controller": "\uE01B",
	"ghost": "\uE01A",
	"globe": "\uE037",
	"globe-alt": "\uE036",
	"graduation": "\uE019",
	"graph": "\uE06B",
	"grid": "\uE06A",
	"handbag": "\uE035",
	"heart": "\uE08A",
	"home": "\uE069",
	"hourglass": "\uE018",
	"info": "\uE08B",
	"key": "\uE08C",
	"layers": "\uE034",
	"like": "\uE068",
	"link": "\uE08D",
	"list": "\uE067",
	"location-pin": "\uE096",
	"lock": "\uE08E",
	"lock-open": "\uE08F",
	"login": "\uE066",
	"logout": "\uE065",
	"loop": "\uE064",
	"magic-wand": "\uE017",
	"magnet": "\uE016",
	"magnifier": "\uE090",
	"magnifier-add": "\uE091",
	"magnifier-remove": "\uE092",
	"map": "\uE033",
	"menu": "\uE601",
	"microphone": "\uE063",
	"minus": "\uE615",
	"mouse": "\uE015",
	"music-tone": "\uE062",
	"music-tone-alt": "\uE061",
	"mustache": "\uE014",
	"note": "\uE060",
	"notebook": "\uE013",
	"options": "\uE603",
	"options-vertical": "\uE602",
	"organization": "\uE616",
	"paper-clip": "\uE093",
	"paper-plane": "\uE094",
	"paypal": "\uE608",
	"pencil": "\uE05F",
	"people": "\uE001",
	"phone": "\uE600",
	"picture": "\uE032",
	"pie-chart": "\uE05E",
	"pin": "\uE031",
	"plane": "\uE012",
	"playlist": "\uE030",
	"plus": "\uE095",
	"power": "\uE097",
	"present": "\uE02F",
	"printer": "\uE02E",
	"puzzle": "\uE02D",
	"question": "\uE05D",
	"refresh": "\uE098",
	"reload": "\uE099",
	"rocket": "\uE05C",
	"screen-desktop": "\uE011",
	"screen-smartphone": "\uE010",
	"screen-tablet": "\uE00F",
	"settings": "\uE09A",
	"share": "\uE05B",
	"share-alt": "\uE05A",
	"shield": "\uE00E",
	"shuffle": "\uE059",
	"size-actual": "\uE058",
	"size-fullscreen": "\uE057",
	"social-behance": "\uE610",
	"social-dribbble": "\uE00D",
	"social-dropbox": "\uE00C",
	"social-facebook": "\uE00B",
	"social-foursqare": "\uE611",
	"social-github": "\uE60C",
	"social-google": "\uE60D",
	"social-instagram": "\uE609",
	"social-linkedin": "\uE60A",
	"social-pinterest": "\uE60B",
	"social-reddit": "\uE60E",
	"social-skype": "\uE60F",
	"social-soundcloud": "\uE612",
	"social-spotify": "\uE613",
	"social-steam": "\uE620",
	"social-stumbleupon": "\uE614",
	"social-tumblr": "\uE00A",
	"social-twitter": "\uE009",
	"social-vkontakte": "\uE618",
	"social-youtube": "\uE008",
	"speech": "\uE02C",
	"speedometer": "\uE007",
	"star": "\uE09B",
	"support": "\uE056",
	"symbol-female": "\uE09C",
	"symbol-male": "\uE09D",
	"tag": "\uE055",
	"target": "\uE09E",
	"trash": "\uE054",
	"trophy": "\uE006",
	"umbrella": "\uE053",
	"user": "\uE005",
	"user-female": "\uE000",
	"user-follow": "\uE002",
	"user-following": "\uE003",
	"user-unfollow": "\uE004",
	"vector": "\uE02B",
	"volume-1": "\uE09F",
	"volume-2": "\uE0A0",
	"volume-off": "\uE0A1",
	"wallet": "\uE02A",
	"wrench": "\uE052"
}