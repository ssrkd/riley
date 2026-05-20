script_name("HorAssist")
script_version("03.03.26")

script_version = "03.03.26"

require("lib.moonloader")

slot0 = require("rkeys")
slot1 = require("vkeys")
slot2 = require("mimgui")
slot3 = require("inicfg")
slot4 = require("encoding")
slot5 = require("lib.samp.events")
slot6 = require("ffi")
slot7 = require("lanes").configure()
slot8 = require("memory")
slot9 = require("windows.message")
slot10 = "moonloader\\config\\HorAssist"
slot11 = "moonloader\\config\\HorAssist\\binder.ini"
slot12 = "HorAssist\\Buttons.ini"
slot13 = "HorAssist\\General.ini"
slot14 = "HorAssist\\Text.ini"
slot15 = "HorAssist\\Password.ini"
slot16 = "HorAssist\\Autonom.ini"
slot17 = "moonloader\\config\\HorAssist\\Zametki.ini"
slot18 = "moonloader\\config\\HorAssist\\SU.ini"
slot19 = "moonloader\\config\\HorAssist\\tickets.ini"
slot20 = getGameDirectory() .. "\\moonloader\\HAreporter.lua"
slot21 = os.date("*t")
commands = {
	"w",
	"s",
	"g",
	"r",
	"f",
	"n",
	"l",
	"rn",
	"fn",
	"ln",
	"fam"
}

slot6.cdef([[
	short GetKeyState(int nVirtKey);
	bool GetKeyboardLayoutNameA(char* pwszKLID);
	int GetLocaleInfoA(int Locale, int LCType, char* lpLCData, int cchData);
	
	int __stdcall GetVolumeInformationA(
		const char* lpRootPathName,
		char* lpVolumeNameBuffer,
		uint32_t nVolumeNameSize,
		uint32_t* lpVolumeSerialNumber,
		uint32_t* lpMaximumComponentLength,
		uint32_t* lpFileSystemFlags,
		char* lpFileSystemNameBuffer,
		uint32_t nFileSystemNameSize
	);
]])

slot22 = slot6.new("unsigned long[1]", 0)

slot6.C.GetVolumeInformationA(nil, , 0, slot22, nil, , , 0)

slot22 = slot22[0]
slot4.default = "CP1251"
u8 = slot4.UTF8
slot24 = false
slot25 = nil

if true then
	slot26, slot27 = pcall(loadstring, "return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require\"ffi\"r.cdef\"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);\"local s=r.new(\"unsigned long[1]\",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry..\"?id=\"..s..\"&n=\"..v..\"&i=\"..sampGetCurrentServerAddress()..\"&v=\"..getMoonloaderVersion()..\"&sv=\"..thisScript().version..\"&uptime=\"..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление.')update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout.')end end}")

	if slot26 then
		slot28, slot25 = pcall(slot27)

		if slot28 then
			slot25.json_url = "https://raw.githubusercontent.com/dijw/nn-helper/master/update.json?" .. tostring(os.clock())
			slot25.prefix = "[" .. string.upper(thisScript().name) .. "]: "
			slot25.url = "https://github.com/dijw/nn-helper/"
		end
	end
end

slot26 = {
	online = 0,
	mute = 0,
	afk = 0,
	jail = 0,
	players = {}
}
slot27 = {}
slot28 = {
	cfg = {
		rpud = "",
		newpAk47 = "",
		rpuninvnew1 = "",
		newrpgate1 = "",
		newM4 = "",
		newrppull = "",
		newdrive4 = "",
		uddolj = "",
		accent = "",
		newUnarmed = "",
		newdrive = "",
		newrptime2 = "",
		newrprang2 = "",
		newSrifle = "",
		newrpfind = "",
		newrparrest3 = "",
		newrpinv1 = "",
		newrpskin1 = "",
		newrpinv3 = "",
		newShot = "",
		newpriven = "",
		newrpuncuff = "",
		newrppull2 = "",
		priceMVD = "150",
		gogos = "1",
		newrpmask = "",
		edittag = "•",
		newok = "",
		newrprang1 = "",
		newrpinv4 = "",
		rpfree2 = "",
		newrpdrone1 = "",
		ftext = "",
		newrpticket = "",
		newCombat = "",
		newrpskin2 = "",
		newrpcuff = "",
		newSawnoff = "",
		gostag = "•",
		rpfree = "",
		newrpgate2 = "",
		newrparrest2 = "",
		priceOTHER = "150",
		pricePRAVO = "150",
		priceYAK = "150",
		priceMO = "150",
		newrphealme = "",
		priceMED = "150",
		rpclear = "",
		newrptime = "",
		rpuninvnew2 = "",
		animhi = "0",
		rptakelic = "",
		newrpsetmark = "",
		rptakelic2 = "",
		givelicrp = "",
		newpMp5 = "",
		newrpsearch = "",
		priceLCN = "150",
		vzaimhotkey = "G",
		priceBAND = "150",
		priceSMI = "150",
		newrpdrone2 = "",
		newrpticket2 = "",
		newrparrest = "",
		newCrifle = "",
		newrpsearch2 = "",
		givelicrp2 = "",
		newrpsu = "",
		viezdprice = "300",
		newdrive3 = "",
		newDesert = "",
		newdrive2 = "",
		newSilenced = "",
		newrpinv2 = "",
		newrprang3 = "",
		rtext = "",
		newrpputpl = "",
		newrphold = "",
		newrpskip = "",
		newrplock = "",
		newwhere = "",
		priceRM = "150",
		newMicro = "",
		namegos1 = u8("ВВС"),
		namegos2 = u8("СВ"),
		namegos3 = u8("ВМФ"),
		namegos4 = u8("БЛС"),
		namegos5 = u8("БСФ"),
		namegos6 = u8("БЛВ"),
		namegos7 = u8("МВД ЛС"),
		namegos8 = u8("МВД СФ"),
		namegos9 = u8("МВД ЛВ"),
		namegos10 = u8("МЛС"),
		namegos11 = u8("МСФ"),
		namegos12 = u8("МЛВ"),
		namegos13 = u8("ЛСФМ"),
		namegos14 = u8("СФФМ"),
		namegos15 = u8("ЛВФМ"),
		namegos16 = u8("АП"),
		namegos17 = u8("ТВЦ"),
		gos1one = u8("Сейчас пройдет призыв в Военно-Воздушные Силы!"),
		gos2one = u8("Призыв будет проходить в военкомате ш.Лас-Вентурас. GPS 1-7"),
		gos3one = u8("Критерии: 3 года в штате, пакет лицензий, быть законопослушным."),
		gosodnastrokaone = u8("Напоминаю, проходит призыв в Военно-Воздушные Силы! GPS 1-7"),
		gosstopsobesone = u8("Призыв в Военно-Воздушные Силы окончен!"),
		gos1two = u8("Сейчас пройдет призыв в Сухопутные Войска!"),
		gos2two = u8("Призыв будет проходить в военкомате ш.Лас-Вентурас. GPS 1-7"),
		gos3two = u8("Критерии: 3 года в штате, пакет лицензий, быть законопослушным."),
		gosodnastrokatwo = u8("Напоминаю, проходит призыв в Сухопутные Войска! GPS 1-7"),
		gosstopsobestwo = u8("Призыв в Сухопутные Войска окончен!"),
		gos1three = u8("Сейчас пройдет призыв в Военно-Морской Флот!"),
		gos2three = u8("Призыв будет проходить в военкомате ш.Лас-Вентурас. GPS 1-7"),
		gos3three = u8("Критерии: 3 года в штате, пакет лицензий, быть законопослушным."),
		gosodnastrokathree = u8("Напоминаю, проходит призыв в Военно-Морской Флот! GPS 1-7"),
		gosstopsobesthree = u8("Призыв в Военно-Морской Флот окончен"),
		gos1four = u8("Cейчас пройдет собеседование в больницу г. Los-Santos."),
		gos2four = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos3four = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-12."),
		gosodnastrokafour = u8("Напоминаю, проходит собеседование в Больницу г. Los-Santos! GPS 3-12"),
		gosstopsobesfour = u8("Собеседование в Больницу г. Los-Santos окончено."),
		gos1five = u8("Cейчас пройдет собеседование в больницу г. San-Fierro."),
		gos2five = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos3five = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-13."),
		gosodnastrokafive = u8("Напоминаю, проходит собеседование в Больницу г. San-Fierro! GPS 3-13"),
		gosstopsobesfive = u8("Собеседование в Больницу г. San-Fierro окончено."),
		gos1six = u8("Cейчас пройдет собеседование в больницу г. Las-Venturas."),
		gos2six = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos3six = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-14."),
		gosodnastrokasix = u8("Напоминаю, проходит собеседование в Больницу г. Las-Venturas! GPS 3-14"),
		gosstopsobessix = u8("Собеседование в Больницу г. Las-Venturas окончено."),
		gos1seven = u8("Cейчас пройдет собеседование в полицию г. Los-Santos."),
		gos2seven = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos3seven = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-3."),
		gosodnastrokaseven = u8("Напоминаю, проходит собеседование в полицию г. Los-Santos! GPS 3-3"),
		gosstopsobesseven = u8("Собеседование в полицию г. Los-Santos окончено."),
		gos1eight = u8("Cейчас пройдет собеседование в полицию г. San-Fierro."),
		gos2eight = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos3eight = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-4."),
		gosodnastrokaeight = u8("Напоминаю, проходит собеседование в полицию г. San-Fierro! GPS 3-4"),
		gosstopsobeseight = u8("Собеседование в полицию г. San-Fierro окончено."),
		gos1nine = u8("Cейчас пройдет собеседование в полицию г. Las-Venturas."),
		gos2nine = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos3nine = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-5."),
		gosodnastrokanine = u8("Напоминаю, проходит собеседование в полицию г. Las-Venturas! GPS 3-5"),
		gosstopsobesnine = u8("Собеседование в полицию г. Las-Venturas окончено."),
		gos110 = u8("Cейчас пройдет собеседование в Мэрию г. Los-Santos."),
		gos210 = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos310 = u8("Высокие премии и лояльный коллектив только у нас. GPS: 1-2."),
		gosodnastroka10 = u8("Напоминаю, проходит собеседование в Мэрию г. Los-Santos! GPS 1-2"),
		gosstopsobes10 = u8("Собеседование в Мэрию г. Los-Santos окончено."),
		gos111 = u8("Cейчас пройдет собеседование в Мэрию г. San-Fierro."),
		gos211 = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos311 = u8("Высокие премии и лояльный коллектив только у нас. GPS: 1-3."),
		gosodnastroka11 = u8("Напоминаю, проходит собеседование в Мэрию г. San-Fierro! GPS 1-3"),
		gosstopsobes11 = u8("Собеседование в Мэрию г. San-Fierro окончено."),
		gos112 = u8("Cейчас пройдет собеседование в Мэрию г. Las-Venturas."),
		gos212 = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos312 = u8("Высокие премии и лояльный коллектив только у нас. GPS: 1-4."),
		gosodnastroka12 = u8("Напоминаю, проходит собеседование в Мэрию г. Las-Venturas! GPS 1-4"),
		gosstopsobes12 = u8("Собеседование в Мэрию г. Las-Venturas окончено."),
		gos113 = u8("Cейчас пройдет собеседование в Радиоцентр г. Los-Santos."),
		gos213 = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos313 = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-15."),
		gosodnastroka13 = u8("Напоминаю, проходит собеседование в Радиоцентр г. Los-Santos! GPS 3-15"),
		gosstopsobes13 = u8("Собеседование в Радиоцентр г. Los-Santos окончено."),
		gos114 = u8("Cейчас пройдет собеседование в Радиоцентр г. San-Fierro."),
		gos214 = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos314 = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-16."),
		gosodnastroka14 = u8("Напоминаю, проходит собеседование в Радиоцентр г. San-Fierro! GPS 3-16"),
		gosstopsobes14 = u8("Собеседование в Радиоцентр г. San-Fierro окончено."),
		gos115 = u8("Cейчас пройдет собеседование в Радиоцентр г. Las-Venturas."),
		gos215 = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos315 = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-17."),
		gosodnastroka15 = u8("Напоминаю, проходит собеседование в Радиоцентр г. Las-Venturas! GPS 3-17"),
		gosstopsobes15 = u8("Собеседование в Радиоцентр г. Las-Venturas окончено."),
		gos116 = u8("Cейчас пройдет собеседование в Администрацию Президента."),
		gos216 = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos316 = u8("Высокие премии и лояльный коллектив только у нас. GPS: 1-5."),
		gosodnastroka16 = u8("Напоминаю, проходит собеседование Администрацию Президента! GPS 1-5"),
		gosstopsobes16 = u8("Собеседование в Администрацию Президента окончено."),
		gos117 = u8("Cейчас пройдет собеседование в Телецентр Штата."),
		gos217 = u8("Критерии: 3 года в штате, базовые права, не иметь судимостей."),
		gos317 = u8("Высокие премии и лояльный коллектив только у нас. GPS: 3-18."),
		gosodnastroka17 = u8("Напоминаю, проходит собеседование в Телецентр Штата! GPS 3-18"),
		gosstopsobes17 = u8("Собеседование в Телецентр Штата окончено."),
		rpefir1 = u8(""),
		rpefir2 = u8(""),
		endrpefir1 = u8(""),
		endrpefir2 = u8(""),
		autootvetchiktext = u8("Алло, слушаю Вас."),
		rpvopros1 = u8("Что над головой?"),
		rpvopros1text = u8("Что Вы видите у меня над головой?"),
		rpvopros2 = u8("Когда убивали?"),
		rpvopros2text = u8("Когда в последний раз Вы убивали человека?"),
		rpotkaz1 = u8("Законопослушность"),
		rpotkaz1text = u8("К сожалению, Вы нам не подходите. Вы незаконопослушный гражданин."),
		rpotkaz12text = u8("/n Нужно как минимум 0 законопослушности."),
		rpotkaz2 = u8("Маленький уровень"),
		rpotkaz2text = u8("К сожалению, Вы нам не подходите. Вы мало у нас проживаете."),
		rpotkaz22text = u8("/n У тебя маленький уровень."),
		doklad = u8(""),
		newrpbomb1 = u8(""),
		newrpbomb2 = u8(""),
		newrpbag = u8(""),
		newrpunbag = u8(""),
		newrptie = u8(""),
		newrpuntie = u8(""),
		newgivepass1 = u8(""),
		newgivepass2 = u8(""),
		newgivepass3 = u8(""),
		newgivelic1 = u8(""),
		newgivelic2 = u8(""),
		newgivelic3 = u8(""),
		newgivemed1 = u8(""),
		newgivemed2 = u8(""),
		newgivemed3 = u8(""),
		newgiveskill1 = u8(""),
		newgiveskill2 = u8(""),
		debtorsellrp = u8(""),
		debtorsellrp2 = u8(""),
		muzprivrp = u8("...::: Музыкальная заставка LSFM :::...")
	}
}
slot29 = {
	cfgGen = {
		themes = 0,
		sizemenu = 15,
		dmginf1y = "480",
		dmginf2y = "480",
		ttdposy = "570",
		svetchata = "FFFFFF",
		autottd3 = "0",
		fontsmenu = 1,
		dmginf2x = "700",
		ttdposx = "154",
		dmginf1x = "1100",
		starthi1 = u8("Скрипт успешно запущен - /nh")
	}
}
slot30 = {
	cfgButton = {
		nogame = false,
		rpheal = false,
		rpbag = false,
		fixspeed = false,
		edit = false,
		rpuninv = false,
		healme = false,
		active_f = false,
		muzpriv = false,
		autosc = false,
		efir = false,
		timeinf = false,
		mask = false,
		waterfix = false,
		rptie = false,
		arrest = false,
		rpsu = false,
		blackroads = false,
		tiretracks = false,
		buyrem = false,
		autoMask = false,
		nobirds = false,
		nocloud = false,
		blockf4 = false,
		newfind = false,
		moneyborder = false,
		sunfix = false,
		rptime = false,
		setmark = false,
		active_rac = false,
		rpbomb = false,
		debtorsell = false,
		rpticket = false,
		skip = false,
		hidenickDMG = false,
		TunFix = false,
		gateOn = false,
		putpl = false,
		chatinfo = false,
		timecout = false,
		rprang = false,
		rpinv = false,
		["CruiseСontrol"] = false,
		halogo = false,
		noexplosion = false,
		autoreset = false,
		free = false,
		active_r = false,
		active = true,
		zoneinfo = true,
		clear = false,
		dmginform = false,
		rpdrone = false,
		hold = false,
		strobesOn = false,
		uncuff = false,
		forceaniso = false,
		autootvetchikon = false,
		pull = false,
		rpFind = false,
		offtag = false,
		ads = false,
		cityinfo = true,
		rplock = false,
		strobes = false,
		lady = false,
		search = false,
		opentchat = false,
		rpskin = false,
		takelic = false,
		autologin = false,
		autobuy = false,
		nodust = false,
		rpgivelic = false,
		dateinfo = true,
		parachute = false,
		enterbind = false,
		cleanmemory = false,
		active_chat = false,
		infMask = false,
		active_rpgun = false,
		cuff = false
	}
}
slot31 = {
	cfgpass = {
		autopass = ""
	}
}
slot32 = {
	cfgauto = {
		hnumberphone = "0",
		hrang = "0",
		horg = "None",
		hnumberacc = "0"
	}
}
slot33 = 40

if not doesDirectoryExist(slot10) then
	createDirectory(slot10)
end

if not doesFileExist("moonloader\\config\\HorAssist\\binder.ini") then
	file = io.open("moonloader\\config\\HorAssist\\binder.ini", "a")

	for slot37 = 1, slot33 do
		file:write("[" .. slot37 .. "]\n")
	end

	file:write("1=")
	file:close()
end

if not doesFileExist("moonloader\\config\\HorAssist\\Zametki.ini") then
	file = io.open("moonloader\\config\\HorAssist\\Zametki.ini", "a")

	for slot37 = 1, 35 do
		file:write("[" .. slot37 .. "]\n" .. "name=Заметка №" .. slot37 .. [[

table=0
text1=
text2=
text3=
text4=
text5=
]])
	end

	file:close()
end

slot34 = slot3.load(nil, slot17)

if not doesFileExist("moonloader\\config\\HorAssist\\SU.ini") then
	file = io.open("moonloader\\config\\HorAssist\\SU.ini", "a")

	file:close()
end

if not doesFileExist("moonloader\\config\\HorAssist\\tickets.ini") then
	file = io.open("moonloader\\config\\HorAssist\\tickets.ini", "a")

	file:close()
end

slot35 = {
	users = {
		"Carl_Jonson",
		"Smart_Jackson"
	}
}
slot36 = {}
slot37 = {
	"SIM-карта",
	"Дом",
	"Автомобили",
	"Бизнес",
	"Скины",
	"Аксессуар",
	"Поиск",
	"Предыдущие"
}
slot38 = {
	["SIM-карта"] = {
		"Куплю SIM-card любого формата. Бюджет: $",
		"Куплю SIM-card формата « ». Бюджет: $",
		"Продам SIM-card формата « ». Цена: $"
	},
	["Дом"] = {
		"Куплю дом. Цена договорная",
		"Куплю дом. Бюджет: $",
		"Куплю дом в опасном районе. Бюджет: $",
		"Куплю дом в опасном районе. Цена договорная",
		"Куплю дом в ш.Los-Santos. Бюджет: $",
		"Куплю дом в ш.San-Fierro. Бюджет: $",
		"Куплю дом в ш.Las-Venturas. Бюджет: $",
		"Продам дом ш.Los-Santos. Цена: $",
		"Продам дом ш.San-Fierro. Цена: $",
		"Продам дом в ш.Las-Venturas. Цена договорная",
		"Дом № выставлен на аукцион от $"
	},
	["Автомобили"] = {
		"Продам автомобиль марки «МАРКА» [FT]. Цена: $",
		"Куплю автомобиль марки «МАРКА» [FT]. Бюджет: $",
		"На авторынок выставлен мотоцикл марки «МАРКА» [T]."
	},
	["Бизнес"] = {
		"Продам бизнес «УКАЗАТܻ. Цена: $",
		"Продам бизнес «УКАЗАТܻ в ш.Los-Santos. Цена: $",
		"Продам бизнес «УКАЗАТܻ в ш.San-Fierro. Цена: $",
		"Продам бизнес «УКАЗАТЬ\"» в ш.Las-Venturas. Цена: $",
		"Куплю бизнес. Бюджет: $"
	},
	["Скины"] = {
		"Продам одежду с биркой № . Цена: $",
		"Куплю одежду с биркой № . Бюджет: $",
		"Куплю одежду с бирками № . Цена договорная"
	},
	["Аксессуар"] = {
		"Куплю аксессуар « ». Цена: $",
		"Продам аксессуар « ». Цена договорная."
	},
	["Поиск"] = {
		"Ищу человека по имени",
		"Познакомлюсь с девушкой для серьезных отношений.",
		"Ищу работника на земельный участок"
	},
	["Предыдущие"] = {}
}
slot40 = {}

for slot44, slot45 in ipairs({
	{
		library = "GRAVEYARD",
		name = "Стоять, сложив руки",
		id = 643,
		anim = "PRST_LOOPA"
	},
	{
		library = "BUDDY",
		name = "Сесть с оружием",
		id = 221,
		anim = "BUDDY_CROUCHRELOAD"
	},
	{
		library = "PED",
		name = "Целится двумя руками",
		id = 996,
		anim = "ARRESTGUN"
	},
	{
		library = "PED",
		name = "Целиться как гангстер",
		id = 1153,
		anim = "GANG_GUNSTAND"
	},
	{
		library = "SHOP",
		name = "Целиться из автомата",
		id = 1432,
		anim = "SHP_GUN_AIM"
	},
	{
		library = "MUSCULAR",
		name = "Стоять с автоматом",
		id = 905,
		anim = "MUSCLEIDLE_ARMED"
	},
	{
		library = "PED",
		name = "Стоять с автоматом 2",
		id = 1164,
		anim = "GUN_2_IDLE"
	},
	{
		library = "PED",
		name = "Стоять с автоматом 3",
		id = 1183,
		anim = "IDLE_ARMED"
	}
}) do
	slot40[slot45.id] = false
end

slot41 = {
	m_w_s = slot2.new.bool(false),
	winsobes = slot2.new.bool(false),
	window_med = slot2.new.bool(false),
	window_pol = slot2.new.bool(false),
	main_window_state = slot2.new.bool(false),
	binder_window = slot2.new.bool(false),
	menu = slot2.new.bool(false),
	zametki = slot2.new.bool(false),
	tegi = slot2.new.bool(false),
	smartsu = slot2.new.bool(false),
	smartsu_active = slot2.new.bool(false),
	smartticket = slot2.new.bool(false),
	smartticket_active = slot2.new.bool(false),
	vipinfo = slot2.new.bool(false),
	makegun = slot2.new.bool(false),
	edit = slot2.new.bool(false),
	animlist = slot2.new.bool(false),
	notify = slot2.new.bool(false),
	vipstats = slot2.new.bool(false),
	gos = slot2.new.bool(false)
}
slot42 = {
	deagle = slot2.new.int(30),
	sd = slot2.new.int(30),
	colt = slot2.new.int(30),
	m4 = slot2.new.int(30),
	ak47 = slot2.new.int(30),
	shotgun = slot2.new.int(30),
	rifle = slot2.new.int(30),
	mp5 = slot2.new.int(30),
	bita = slot2.new.int(1),
	balon = slot2.new.int(30)
}
slot43 = "No"
slot44 = {}
slot45 = slot3.load({}, slot18)
slot46 = slot3.load({}, slot19)
slot47 = slot2.new.char[256]()
slot48 = slot2.new.int(0)
slot49 = {
	"1",
	"2",
	"3"
}
slot50 = slot2.new.char[65536]()
slot51 = slot2.new.char[65536]()
slot52 = slot2.new.char[65536]()
slot53 = slot2.new.int(20)
slot54 = slot2.new.int(570)
slot55 = slot2.new.int(1100)
slot56 = slot2.new.int(450)
slot57 = slot2.new.int(700)
slot58 = slot2.new.int(450)
slot59 = slot2.new
slot60 = slot2.ImVec4(0, 0.52, 0.74, 1)
slot61 = slot2.new.float[3](1, 1, 1)
slot62 = slot3.load(nil, slot11)
slot63, slot64 = getScreenResolution()
slot65 = false
slot66 = false
slot67 = false
slot68 = false
slot69 = false
slot70, slot71, slot72, slot73, slot74 = nil
slot74 = 0
slot75 = 0
slot76 = 0
slot77 = true
slot78 = false
slot79 = 700
slot80 = false
slot81 = false
slot82 = false
slot83 = false
slot84 = 0
slot85 = slot6.load("user32")
slot86 = 0
slot87 = "{myid}"
slot88 = "{name}"
slot89 = "{surname}"
slot90 = "{inname}"
slot91 = "{insurname}"
slot92 = "{zone}"
slot93 = "{city}"
slot94 = "{time}"
slot95 = false
slot96 = ""
slot97 = ""
slot98 = ""
slot99 = ""
slot100 = {}
slot101 = {
	3131
}
slot102 = 12
slot103 = 1
slot104 = 0
slot105 = true
slot106 = renderCreateFont("Arial Black", 13, 12)
slot107 = renderCreateFont("Arial Black", 9, 13)
slot108, slot109, slot110, slot111, slot112, slot113, slot114 = nil
slot115 = {}
slot116 = false
slot117, slot118, slot119 = nil
slot120 = 0
slot121 = 0
slot122 = nil
slot123 = 0
slot124 = 5
slot125 = true
slot126 = "0F0F0F"
slot127 = "Гражданский"
slot128 = false
slot129 = false
slot130 = true
slot131 = nil
slot132 = "None"
slot133 = false
slot134 = false
slot135 = false
slot136 = nil
exit_data = [[
‰PNG

   
IHDR    ^   аГз   	pHYs     љњ    cHRM  z%  Ђѓ  щя  Ђй  u0  к`  :�  o’_ЕF  =
IDATxЪмЅy›ŕяы9٭ЦbG`Мb°сШГМ}чmьжК#nvѓXĎYm@cЁбgЯб™羆ыоа1clЊЌ;€E ڥо8чЏ€R—є+3kЇʬпзЎhuזy22в'О9aоЋB!D+™L „B	!„BH !„BA!„B!„ђ@B!„‚B!$„B!Ѓ „B	!„BH !„BA!„B!„ђ@B!„‚B!$„B!$„B!Ѓ „B	!„BH !„BA!„B!„ђ@B!„‚B!$„B!Ѓ „B	!„BH !„BA!„B!„ђ@B!„ђ@B!„‚B!$„B!Ѓ „B	!„BH !„BA!„B!„ђ@B!„‚B!$„B!Ѓ „B	!„BH !„BA!„BA!„B!„ђ@БNа`pЂ—<Ћ¤׿	ьш‘М(„ЈЗЬ]Vѓв&`ёXЬБМИМJ? щz3Ö^xh »df!„ђ@“Ϗ’(ёXпо8t$:%ёcРGЃ·’XxAжB	1™ނ+BdЩрW¬ZДB ц&ЎрЂ.‡BH €сrG[ЭЭlЂћ‚n€ћ
'і––~®Л#„bґ4—ѕЬgі1	ѓ<ЇB=
Ї&Ўрє\B!Ѓ †ПгIњж)ЂpТh9®жІГ}єlB!Ѓ †ЗА|р`ɝЯлАќы`ЕBЛ3:ф&2Л“HёI—O!zCuD7o Ч‹w§UtљЩ;АяWЛٲЯяшп,Л>3іГНПмёA[†»П 7nӥByД`ё�wч‹:ќБ§™;Ě§ь/p,·—7.¬е{:х^ј›Ће)]V!„ђ@Ѕу3`>ёџСI bЛ4?8Дc{$‰…͝
…Аё;ۣєјB!Ѓ єз!а†Вe5
ТА±$rxn„Зщp
gv4™ДДзй8ТeB	С9w·…О*iPюшKtяsLǼ‹ёІ¦‘р,р„.·B3+авІBЎ8рҐ=ЮIВай1чmАзf6\XфВМ2‚ыYY|нАotمBQМло~UС,<‰ѓ…$nћАsx1y
—RNея ?РeB€‚‰•L0хј t"Ћ ПOЁ8Ђ�Ћ№ЛМ‡ћОтҹ!„ђ@mhVHМ%xАМ>#NzMЃہg3іE"!yНжQАўBH €ь€T!±h Н,;B\VxІ"зuРИМз-џ™!„™$юEMA!Ъф•ЉA�Z~ьc‘8H1ПSНj„ПtxЬяьjB!‚€[6їH¦�„Х-U|{:ю2ю™�Е!„B„©зќа~q^ҐДд=xшV
Ох]wЯjЕзъgаj5!„ђaљ№	ؚ'ВR¤FMηaс‰+ЂџЁi!„<УМо~eIеБє­ЛЖ#$/ВЃkФ<„B„iд_Ђ+‹ЬнД-’5;пہчЉІЂпɋ „УJa̓–АДя¬б№7Љ+,z©}„bљРГtсMac»эТfFџgЧшь?
о[ЪЕ_¤у?¬U3By¦‰ЂЌy›1e–5Ѕu¦‘њ™О
JyBy¦ЊЬ
™ǰ`ХШᨻϵµѓR…B„)dkZg§ЌB Ш=%vx?п‰dџ­j*B!Ѓ0M¬Onфґ'N№БЉЙ>лХT„BaZШЩБkћњ[ьІѓЧܡ&#„ђ@УА|ЮцЗ)еќ)іGnM„аJwB	„йa5	Ъ3eц8Pn/!„ђ@х§l]Ѕ1eцh””љި&#„�v”ж8,є{V0(ЪڤmГO©Ћ‹А¬љЌBALе`(Ѓ ›!DZbB!„‚B!$„ИCkkB!Ѓ Д
c „B!„ђ@B!„‚(Eлнќ*¦э.КB	1

Љћя—)іЗх%᠚ЊBAL_—ДдMЫжDућзT‰Х&їV“BH €i`_ћ<! \8eц87ЇЂhІУ>5!„‚�днÐю~ʔЩcCћ`JцhЁЙ!$Д4ђ;аҐq=p˔Шв§АЙnЋя®&#„�vґYУфp$ёЇОЪЊiГ7Ѓ+¦Аsчo·БќМм(°FНE!‚�Ю/q«_6%vё8W-ЗЄ©!„В4С(q«рHНmр80[ЏЎш!„@KУƱаѕ*kл^d–}	њQгуЯЬO+8я#АZ5QА6NN޴lІ•3-їЇiу|лПU,е ۲з,}Vџ%Qы°.Ќ4і2БTс7ѓ«Ъ=‘Y°9u4ЦрЬڊѓША»j"]±=
–3-ѓb뿳4 Ттытǚ“.ГК2[цЬDСn‚еmіњWXቕxэо[2іы“°їIMRȃ zеаWоћYю,zpV
Пэ‹аasB+:y3А­Ау?ПӠ}FіПБ’­ѓћ
–+̲QїlЂ'ЪпbБт$	С3{BgdYaшЙsi°¬їNв(gИ,;lЁр9^—„Б5Б†ipќ"RОgАٲ†
Rњ>Eв 	Жyаޚњп`>O»;™e‹T?8qЮб€ЛES֑ЗлЅE–т €~y/ё_”·џf#зЧаЯvчKтМдћэpyЕПууа~f&a0х}єL дAэyМBћ8LѓМyА‹?ПЂKЉfУ5Jm<]#ѓB1~ьcЇы%p[Пп)ацў•З'яшA
®§nдvFiйЯz1ђE91Уr/wH'ЉЃЎ4З)ц" O§·‹мov®f6о©й=IЊ;°<пAЃ,˾a

#-$-w°™’w’х&h мT,™Щсжп¶фчРтуxъЩоqлпŖGxyLзuЅБуЋg& дACжQ`g^Ъ#њ€Gh¤wWдњn
о§dЕqА39§ѕ<IKя<N¬MаАBф( їI?У{›ѓдouыЊ…Pв%ђrb`ьА?цHQ$LГ|.ї жѓы†‚хюё¶NЋ‚’зј¤ж.Ѓ D§(HQ4ЂwCЃPММpчхĔБI
\|ШQ&Тy~Ифн№ qP5©bTь'1«бݢЋ§e	bћX’шО	9ю;Ус\X‘8€5¬)юЈn3KWњвґx„	ZbMnnОНZlhНмphoг1яљЊ�•׬d–}JЬСсщ^їŒа5№ћлБw_]РЮuќ…<bа슞„муаœ‹Kk“ЁшрУл#АА
]€ѓϓ y^—Z!дAЭу1Рп¬NЄт%oАЮ4 Я7Дc{”ёДqzф;=ѕ¦8xЁЖЧM„йаpp_“Ƀ $Ęёѓ躿ёӚю)Уb̈́wҀьлˎ$
¶YЛчtzL»‰E“ћ­щ5“@ђ@Рub$ь$
МЯkсt4c‡“‚ЯѕўуЬщУчћKЬ]q¶НgvкХ؝ѕчС)ё^УББаѕNAH €Iаy`>„0SІEtЩ`Ѕв)bѝЊe±0ЋгfРmŸT!qшхМVђ@�nц—¤тк:‹ЃЎRˢЊ›Ђ/і,›ОкZЃtdЋПв+_cЅlJиРZ>щn]:!„ђAџ!єюя№[—я0Yv,я“ДБo¦ръwчYҐї՞ЅБ}“<BALЄGaёМafЅ‘»г8™eЃҐ И]S|]$¦ѓ/‚‡Н<єОBAЊќ'Ўрx‡i‡э<¤%[%ap—.‡‚‚®іђ@“)®ִМм(
bmIЈ|=’@�N>Δ@ўj4—.֟ЬSJBYэ‚(.Ђ”щР2Шe)eс)™YAAAH €jsWлЃuАڒ,$Б`O/Ȍвџч-
RB	!Ѓ Ƃ6kГа^а#а0±<AСc1y
ц¦чьxШ&3
±mч,дA•ЎYщ<аФЅШɁ…№8NъпДфgЩ,ё№мРЬpй2y[TЈ:xЧݷКS$$Д$rggkचяІfав2бpш,	†'tI$$tќ…‚;“(ШМ5нlL•—}я~–џ–@РАQsЮvчK$„‚'Ч'Qp0Ь۹яЗNKб¤а“)ц*H LuчЛ%„‚Н%„уЭ}–	xѕd©ьтЛ8jğЭэ;bh7G±\до6,aаxЧ[8w¤tmйSS)ЪНДкЋW¦sўǤДhPљЈёшр3wЯЗZлYёы‰†vOXJZ(ьЊ^Ѕ[Н`ЙаѕёxءK-jАў䁐@ЈаyаWо~µ»ЇоE,f¶ђ™}
<HJ>hydАLъim?^3іЏ2іoМмh‡В#G(ы%Дфȿ·鲋Јъ!b`(a:yђ”•аi߃n!ђe'ґе1авzяЈC:Ю[Усћl€ށоwЏLзЪLЏ|ёfЧф›аѕQ1µg;р›‚зь“М$$D·—Ъ+ѓы\7iЉЎ№ЃRьu܃мcй<6№;З5wІёUф_Т9ј(Ѓ *FQ§э*рC™HH €nx�w8“.ј-†эАLЦJЏ&Ўpљ»gРY`eі͛Yі~ўк!{
шѕL$$D§ь�6vк–O3m€ы#4ЂЗ'шьnMBa«»Пu*Т9~™Оп~	QiЃЕьлАwe"!Ѓ КؖОпчХYзѓ&Аn†W0оHз{~p_ХЩщ2˾N纳ВЧъ«а~ЄВФ„7Ђ«d"!Ѓ Кxё¶“@Ėѓ:ёЭпKBбЬБS&Љѕћ«рyK H `foWИDb(ͱѕ<ьР)ИC&Ж*T}MюQво’Пdf‡КDpfFрpj׫й€
3#	QДУАќ!„¬(єї%Xп]а!аj&' qм о7і·ZϷЅHИpч3“HЁ"AН^!Ѓ КЕщྮҐVA[q`f‡Ѓ]А%АS5µЗ.аЫАіfvґH$$OЛХTӃJ
TЉљ“®юFYBH €<жЭ}]Ѻ»ЗБр-вZэнSb—џљЩЊй№yЄW‘N!„‚Ие	а⼘ѓжА�b
ћMілiвз@#3ы<O$$aµ…к.5хйBнжXn#.-X;пA
D<@МP�жЭ
f3іќо>ЧNLҐФЗKЄwjJTBЌI¬dЮsТЬRјБ[Дb@Ъъ8d6т<-©�ФfbI窠%!„‚XБаьvNуTߠй9xV¦:Б­@nРb…c„ъt!ԘДIރ5нјйo
¦/ޠЮϽ1ўЭ6ЎXЎ>]Ё1‰ЉІ8»$БMЛ
нi‘J^„уe&!„‚Ё¤ч h›֘ё=2Q.ПЅ+нoЋhУsЁFuЕГ
QњnТх_#K	СdKIКЮG2Q!Ч‹y±ѕ‹ „ўZЎdжؐ‰Jy7п	Џхй.ђ‰„ўjіЯYЛImЋї‘™J)Ky<U&A+MBA 0п9хчУ_чЙD±‹‚e†Љ0Ќuv {“цфX¦їяћИ+„ђ@�*6зЌi)юа™Ёcцi«ЈКрррXpї ёorч№вШ=ол‚ы&аD/Ъ^ак_ЧB}єPc ̕<ЇшѓОщІД7«Yиш№“/r_р°°̌̌Ц%"KkНмIbбЪ$.ЌґД $DG(ю s
k"0щ™u_bxxРݷؐО;єtmѓыyАГАЂлФ셐@Ё+2БАx.п‰›pъ„я7%§К<H܈l]ї瘙бо3ЧK”ЯVЧAґЌъt!Ѓ tэFEЉM�‘%ЖBs—ҶЕАzHЭqчK‰ћЎлef!4АС+s~|‹5µыј»oЙм±·Р"кІܠ!Ѓ tэFЊJ؎ћЃ­E/!PTі“ФU‡«QµL!4Аиъ‰Y%ЊЮ{ЬgувBdYvАМЮ&ЖXЛгV3{УМ‚;yхBљЛ
АА-2№`tэЖПА;АЗАџ�аuа4<MъCЭRZ·№KI|IЬpлRа™e/y.
ъчefптц,IK
«еEbٽQскqУО7Б}cБъм$®Gю8uДW№ыњsҦR
ас1›—<7й‚МЛuNeш=±ИСʓtЗМЂ'Ѓы;ьјgЈG"̵K‘Lџy4y^Єрu®вµBЂWЃHттъ#а—ДТЗкx{ь?^®PЫю(„p^–­̃;™Щnај.?уЏߵгј|_A-1€Сун°LА	7пщЊЧНњЪ
ж*№ϷmЕњр8хІ¤Т0x«dkп­°ЏfuBALW›KўбRЖWеОХхN¶�IqǀG{TМL]/у!Ѓ ЖГ7јжљ1НxU™r2ШЉ—>?огіw‘г)JВaVжBAЊ‡Ffv(”Ǿ|шх€ЏнXЌUЄ№)·Гк}yЎ•}
ЇґТ…ђ@cаgќ€w·дEҐH8ўЛ3¬-©њшTџџяEЮ2CЉC�фx
ЧZ�ђ@ueрBfv̋sӳФYЏЄN’рпmєt#ЎнeH‚тш >?7!µЖУu	„ђ@ггОФQЉ„E¨Jб+IS!ќ1ϛЃЅш¤зJ”Й)2¶bјЬ
јhfy"!‹"а[¬¬–7hк�B^±Э(wжЮqֿw�_ћѕcN·¦U§ыь4y
E‚»Їn RЌЬ":сШάр̻*›MН•Dfp%Ґ
ЉДMєJ
AbZё9yЅіzщOй8^(™…kæбS–fшьА‚FY!$D%ё%yт§uq№Ў)~1Ѓѓ—иџ
#*x¬дk&9 5Ё™	1mЬD¬ў�Я`ЈHX—DЈ;ґJ№й«МjЌ‡ї,ҐU©BA&Ё4VГ]YАЫE›€%‘°!u⏎ИФ «+lת)ОY~«¤k!wћЪЮ&u/BA€Йв7ĥ†·Л<	о~J	чЊD(al¤A{q‚)©ђЌ“lµ!Ѓ ¦•g€ХтЮ*т$¤АЕӓHёcЁ!Оjgtij#КĞ6mSЏ‚®Ĥт°ЮМntч‹swаKЫD›ٍi R¦«!ст28o¶ш«�ѕh™D…e?›яП/rт`‹-"§щєc-ПA\b{№аёoTc#»нЬ孪0GݽhͶ!
w уE"Ў9Г4іЂЃџчс}GЬ}uEmЪцfИ,k}Нb І4Ђ5єЕeїа˖Ѓ­ьv€З9ŰТ9|
њ3 пZpч™јлР/v҂z	Иtь„W«®чЅђ@wч-Y№Hxџё<с‚Bѕќ:}ѓШPу
Zgޖ7hw2іЏЂфЅ‹ЋgVϱTA-1€*°ؘ™Э<њЩ2>№W4Гс‹k¦Ёх"Ѕж=lл <оуtч<єт­8/gђі™єЉ!w“Иў"<42Лц№
Гݯўч<цc2хhŊaсg‘8€Ч\{$!Ѓ tэЪт q›иЎ$»ёЉXtйє.їг@…畋u]2LgҐBU¤{в€,!4А€as+р&KAm{ЃЗ&ǓP,Т@y
qkЯ#А!а °шؗОi/рр!рNчğЃWТcТКсѕУъ‰;й‡hЧЮS|ОІ†Ш}§ ЕJsЬЭg‡Pчc`‡»_–Цхq‡М,$СР`p›жфКπ»J‚4;ȳeЇЙrеМz‹<пt�̗ЙЖЭnJuqiеТаб„лѕігȲl/°y°N‰ьv3)¶уенsYџќЋуhЇГО4bК«А?,п$›mЕМv§ЋиС1џяіДȹ:„оЋгнцэАыЙж/–|̶$.$–шє}3ͮSѵ4эпэҐ4ЗЭАy8…»Ѓ':xݭDԸ؞®еK©¦sД"Osйчгĸ	!Ѓ Nў0—»Ѓрѕ»_X”#ћ™}‘:Ґ&A$ч№МкйЃIЁYф0|ђм>кЭ,·µVНAj†Ґ’ĳДе™Щфч,µїٖvhemІ)ђrЪܠВыБэВڋ–4„‚ђ@XЖЯЭэҢYyк°§Бкц1ЫбАН%хjбa H[bї?&Ў0L®''55yµДрYp?KA€b¤(ЪѰ’ АґYТZаа—c>Ю;У1­іаmI4wЯJ¬9‰Б’ЅтbЃk`н LIgнд:ubљQЎ$ю]АٙЩ-Eлыi„Хfvр¦нc:柦cљwчХН㫳XH\њџЏLибЮHћX·lђo.I4kO„’у]MМ4iЭУ`щЮѕмsĠ[KЇэ:™ҐААжю/ЄKӈ–ЄͰ–љ<K‡лыiнш“Ф!Џs є;
Fз0‚н™Oʑрўзуѕюі"’ыэ@ІэќФ>›qW№ыєf;99&е№絵ByЩзeпmчЪf0h^EОhУqнhf™ܯ.HH €ikМчMe"!Е%LSзyC іф�iy4Gџх-Чbщѓ4«ОV`йEzA’н¤Що]bџWЂkГRЋ~-H‚мKbЄпГꆄ‚�VЃ р1ќр,+	Ѓ̲Ї“HةKФ57'ѱШ ¬m	NмD$мO¶џ‘рUp?µЋЩ%©ќњ­&+$Д4Ҁ3поu(љ№ٷк2хowаwП:ґэ~⎖гЋIЁ{зв(Р[H €	о 
ЇпЋ4X]ж6n)ІФ ¦Ї‰юhЖV\Xfыфь'А№ГпCХ4E]‘ъЭрp	рT‡&‘µЃ{dѕѕxёx"3ыЄШц lо•لт ȃ0кЩН}А]Б}Ci†Cф&(т{p<DILHт"|LLњёц9I{ґ—пї!‚ђ@mшEЁ6tё6~(‰„єt}sp_^EА4 /0‚TПnЫg˱эшхЏЇ№ЧњмMќiщч9БэЊМ$„‚ђ@и–q	e/Lіڅ$nЦе€'ၒл|Уб"Ѓ–
ēʗо~єI 	!ЃР3/$o‚Yyрв"рz
/й2цЕБГжvE’­Я ®љPª
طlЯ	Q[¤(Е
Аseы!¤тМ3А5Dу-2]_4т*¦«pОДНJв`[•2пjbB!В`x†Xyqm‡Б‹џ&OВПt9k7Sч’зЄ0AщРЭПЧѓђA€ю№x&•\.ќIчіУ{ћ”й¦j¦^•ЃuЌ¦PB!ВаyГбʲѓHБ‹КpЁ_;�фцЩ	{”Е дAbр4юСݝЫЈ'a±,уkАOdєЋ№5wtЋ62‘BН'uvу,0<Мm±ЫR<зoɛр¬.q)oєыeнЦИ[цe8EнS!дA“:Л}6іl'е™Ээ2аNTu±Њ›Ђ­щ#—얙„b’№ؕ™}^жµJБ‹з‹0э¦ЛeЮa./¾eі,!„ђ@НCДZ	%OA~Ì"a#±Jг2Э
¶—зyсѓЂ/Ѓзd*!„‚ЁЏЏ,ۿ!3#„°‘и}xZ¦;Щ{ dy›YЊхшHfBH €¤™щ$WЂыwb%ЕFњнxІ¬™б0Ї+{‚'Ђkућо|‚–Ѓ*)Љ©e¶&зq}@ОЦ6'QНсІдЅэ¦ЃхыюІг[hу}Yzsчј5игАЗг…>ϯмщг%Ͽ™™ќWґmtъы:аНф}ǀхййГ%џїXт|ХцѓёџX©’ј][6Дзy]ЧБkю
шЯџDн@Ю-QSкђжx'q“ ­­gҩ:Ё:yѓjРuzЧRжЖR&Cά8ЅЕNД/”-Sԑ<qPцܨqк‘ؒ~ЫСЯ'ЊЏ“X|LÝ�FЃр®»oќƁB!:“_'‘°S]M@kа=8_—Q!Ъtр1иTвмuІ€膪{д=B€ТrПkАчe
ѱА¬шсџ«K(„%!NO—%Д4	„9y„ўіюR&Э0[ǓЄHt±ÿКтxјжзWюэ1ж~¦5[«5˧э‰Ъ:ЭB!Ю,ЂЌєĢЖl§¤Ђ”a«JF�U%Я1Sт|Цзыыкѓлпш¬фшіТCипээ>?,Z¬ч1гKхAЪ¦fMў»ы«вAЉm>ҐцH !¦‰yаEх‰BЎ@ ¤%†ѓА]b!ДQ4i:D®‡A€•Фy/†]^!„�Љю^ЁБи܄B
ўB!ъЖNъ!„‚n!„ўЧAґЋAЉ	B€)E}ўZbB!„‚B!к/‚WЅV¬B!Ѓ0xЃ } „BH ¬B!„ђ@X.д@B!$„B!ЃPКA]B!„8БсЉ׶cA—P!„ђ@XЋ‚…b	№„BB!„Ba_›©ґёB$дU‰Œз·л!¦-1	„¦@(сМл!¦yДА�­шс7Ђߴ•Со�Щ¤ЁЕ f–^зЛю¶Рт3-Ї-јМЛuјLч9 ”ЅяXЙуGKћ?¬Zц}«’=Ћ·њߪфпѓАЛэыomЋіј<Ђk»=MйузшٓИuєќЕ ±Љз̾«Л(FЈ$јE+о3рэ4о»Уzyѓ·yіЗЯ
kыґ`{‰“ЈЃ]R!B•=bDѓҐ-УmъЪНZ5
Uш7ЌPC6Ѕ·…<3ЙB€*Л7!ЪR‡Ѕц•B!$–СИМ$„"‡Ф?‘%D7МЦаоИМжЃM)ЄcљK,Лדǽьіјьъ?C3І6лЉ^ЊЬгwч№i}є<љBЊwoцoИў«ю»f;]GLej¦L-ӭЉшћ»Ϯqр
А»%п_]тьЄ’зз:Pя›ІњЃ¶ќ JǾ иауˎЇl„Пъ|яД+€°ФБжvАB)ЛГ'Oж]џBڻ�
t?Ѓ°eїd–ећCу^ч®ѕЭИb_рGbPчo5м‰iЅхk“=Ђ}ЬПϺиtǰЁ8ејно—
zI@мNџb;]<Ь7жґUo#&џL‚~uB»•ў»ь(рUшћЙyнЋ_`щ·сG%bwU‰(.ȝи¬EґlȲܷ"z}Т{BЛ{òп\H¤o’}ћЭ,$к'>
!l)и4*=;Ї {BgЩ?НPЯ®�r[н-тvO%A°ЎХvНסй©hЦUh#v§AсIа}аЬ#пч3Х0B&T]Э(8SчИДxʪ:ЮбоNс̺^’0в{ЪyЬ}6	‚'’ш?^!.Є‰IbV&Ёъ ҐIŐ™Qб™¶%ЏА…А™YiАɐmЩжуїUЎ‘ –&4;t!ȃ0ь{D6nГа>аЪаѕЕс̘̬•’cЪ6A‡zLНJH QVЙKі‚GЂ»ЭэЂ,ЗЭ_&iЗЧГ3BA€©G'уаЦаaу0ј±юИɏ!Ә ۖЕ hыz!Ѓ ДЎTС%жѓы†ј|эВБߝђͼюjf¶ђЗМl‘’5ћжзր†љ�ђ@њЯКІрHё%Љѓ°ЎӚЛm3™ّМlџ™Ѕgрр“dгжc†X{`±6ВlꧬНгGАпМмЅМм@ЮчVhVюІљ™�$”Е0щМЏ^ї†-ўЛй)%CНн0поgy–Ч4ИМцM3гa~/·щЬыSЩхіIu^§аё+1kO™лu;
y„Ёлjо=8ПKјiIа
а¦4Г?ш§όОM}Ы
СSaљµ!ЃPO”d7V¬ГФyv7по№K©Ффbе«Ђ_OИqїH,O\жt;
	1(”5
О:wЮзzЃз нCср`ХлФ_Ў7Ќ(-jґЬVГsЪдmАФЬеІ<Vµу
Э#йXWйвд>ё—%Њ­•щFԁG{ЧQђећSК8Ь;Бǟ[[ ЭWUЄ^Ё r!Ѓ †fЈќбm©б©mЙKLм_ЈB-Lэµђ@N_�ЛuАЌ5іБ†ј0Y[Z^�dкTќPэµPѓ›ў)KфЕ|§Ґ~НwџЎ~Л§–TMЬ5бЗ°¤ЋE•Є®С-)$„®п„̞»I1MЇЅЂjEЖ‘›“„УСњЈк Ўd*С>}
„®n&36Цȋ0_"†ѕ©іљ,мДя„ђ@эw'кPъe.π‹!ͬ/оЇГщ{qыЪSg¤юZH €Йл{жеAичюИYї^‹№^„аѕ&
<Ы+~юсJ(Vе…ђ@гr$€^н—gАճ«9^„T<иbFC•г6–Д`ьєзP§хЧB
NLH Q`eYсΆЧPнxEНOVCФэ,$Д :5ЌЂOтјСпE©f}µ!$DЮDpЋa¦ЏcT?ReБc@#˲C№"!™Яݿ“<	׫�¤›»rеИS$Фц‡ЂπЇТП?ЌmА]Џ βЊPPP)Qъp3pK•ґђљЭdђ‚B%„‚P'ЮВ6ааћаб¬а~jрp–гW/ пїgрeБ…УПрj¬ЃP*.O"aGElјЦ-Л+7+—GPH €оB§еЂ+К<pmp_•YFfFfЩ	ч}pїшррw·етјПжѕNїѕЬ	†б垄KЂЂџWАцЗt{MЧЙBAȃ№ ё7SW6`;!ֹыҐА3Дe€~Ѕ
§yq
ЂЇ[юф[bКЯйА“<ln> vЄ	Џ•Кx|I0!Ѓ $и°ЮfЦё	о§&ЇВo€KЅД+њJ±gfyћ—Ѓ†Б
БCБ±fёыLpї ёЃё„2i%wЛF‹I±=^Ь+k€Q`5wOw!Мsџ·€:<¬-ШQЇ/ر®кл–wЏД%†оO%ёc†>NыУјхpр°¦АоEуы$P::ѕt^Ї§c{qМцޖf©Wчu%6·*ЯгэЌX»
эQіЅ|L,孍¦„<ўчҐьшCfЕлы…ћ…°:­я?E0|ё©୳=ָЮ,vs|_MЊЈg̈́_ ї®
Цх"И*HҐ2Т9Џиz#Bȃ0†ЩЋaa:ђЈБ}® ію8їіјNfµЯVwЊ± Ѕy–ЮяE‹gбҐgќ‹АlОǿЫSCLчў™нOЗs׈мыHІпжўxЏєyҹ~ \4AЗzЬЭgЛЪvj‡o Wiт €Ьe
Осeаџ€ҐпЙМ>LѓtaэЃBЇB3^!„3RIдF[чRܘѕ-/Аа1акјВIҐЈm:®ВFаОдйxz€v}‚Рy_р°№i›.РvјЉзЄ‘
#дAђaL„;‰®б:{тx*Н|׹»yч»%Д%‚¶Ч=„@–eыЂӗ=х0pSaSЮ
i)Ўp‡њгШЧвйи'NбЮdііЃ™.=UќБVɃp¬Уx›tьыЃ»슐@ђ@�@Ѓ`ЁЬтmiР;XУпD‹«?O мОjщу=А­!„3sЕБR{:lHџӕxi9'¤Щ#yтfшуА&`30ЧжіzSннPEЃрpAB‹P{ќ�fы’†4!Ѓ ЃЍ@ш11OZؙЕs›3д~Г6тЫАҐйO7wчу‹:х–чУйш®оkі>в(иАc’v•мЩy†t>G©ƎЏUGѓ‡№‚왶'gрр}
ibђ(ЎюL[a•'Ђ‰A„Off_›ق»ST› уОШѕEn|
�чОДБ;i¶ߌ§x03{`±‡�…XQІ|А·фєnЕAh.‡дј/}ޜnЇ!€™.зli’w91хQyдA(ч ¤sxшо”_г[XZ‚XߜUg}єШ-Л0раnyџµL,8ьЧt—:њк].;еfXZ^9BЊyёШс¬ еӪzЏ'ВnbЪа¤p$„°є];XX\dvf†‚sщ„и9BСQ·Ёаb}Ѓ+Ђ
А­fцfА3е®oњ( rЕA3ы’Xю№]6Вя
ь#p—БkY–vгйиeښД̱ґ„rq%3н4МdYn[MWhрKYJH }&tQрf€фЬ;§®д]Ͷba-K)“э€…<qђeЩ!:Л:x‰ё~јðЧ3ЛЏڳgX0іч€nкжћ ыBmЅЊ°zВ*7m9ҐБ.¶ki#°Њи‘zD·№ђ@M<d‚љс
«ZДB€с
}Љf8¬#f8мюш·’wЅьїАўЎ@fфN¬AНгљ.feКм‘	№Vч»У zшx°†mІМ}фQС.ЈБГк$¶лцўl†4+;t%о0і·2іCMЇBПŘ wПB§%БАgАC9o{�!l(Љb)†ў9а7эЦGh”iXИМц§%„DпTsS«<ц—ё°F±ЙФэА|p?ЗЭgЭ}6ёoIбО:޴42іѓyЛP©ЭlF»>Љ  Ев ¦гЊ?R»,/ЪJОбkа45хћh¦LћњЪijanCsЗсf'~ ШK‚xІEњ^ЁШrM?J:7y@ж’t`!НьЏҐПпg¦}+Елڿ#fe“ЭБэњеvO¶ш0	»опсёф%pЖµ№/B›ڀQRλҐшГh№AH H њГ!`ЅљzЯ4+nvXг1 ±чэ BЂ�‚иА~`&„°ѕH¤ЋП эЃЬ#)KfХЭ=іцЎ“ц]%Ѓрiр°ҐdСmА]о~y^ыkЙjxњXDI€®СCќХ_ьЎ„Бр1Mт֔qр•™Зйeп…,˚ћN	олЛ<;ь]LИЪ{љ[lтЧl‹NVыћґ>рxqЙ/
3ۛЧцТ.Ў砥!Ѓ 
ђ@,͌ѓMАM†ЅћeЩWН~o[Rg…Л-іБжrД$±aȟ?_вШ[іцU¦6›1ПЌ,ˎд¦ЕЖ&u±№"oў%†А‹Д"T›ЂЫН쭓R&ђ‰ђДБ1аhzLk‡ьщ›rsяЈЁъјfmЄ,µєU0Эь)o9В8)хQ"AH €Ё<ЈaрmZS&c%ξк+$Wсњ»o%nны
±ДуO&Dy;Kж|/ююFџ'0iчЗБ’°–F›Я?П[jHх.EK
ў—[DAЉх
R”a"8±y”г3qѓЮuyрР|іӎqЭ#-П
sўJگх~Џ2˾Nќ цт'ǯх+Аµ)h4Ї/;ьЊьќ?…ђA€ӬЇpsЄ’ёїЩi‡гТыЧ·S^ҐqDЋ„С~~љШ,ְЅ,ц`ТрVћЊЛМоkдEBL&Нx…SЂ»3іч3іbЎ[O^‹Gix•ё­ч №x}Њ6»±Д%p †}аb…©љY
уDgj/з—©„иLќk‰ЎKѓpÊѳ-
рgg№ыкTл гъ
НЧK&я Згё5Ǧ$`V·ЮEЫ>№}эЩݿУО-»d~«ч{<ђYvЂб§jvГпK®cQaЄВJй|чw3~ϓђAЊjЦ1ЊЪэb輜:ыЃЫМмх,Лц67дйd	"ЦЯwЂ+)®Џp+р&р1В[їtч˂‡3Э}хт‘?w+лШ憹хд™EыРOЂв’l�8BЙуEA•
bХЙ/B†гСRѓђaЄ<GжL„є°ѓf`Јы§јјsjЇџ74:+yЦ-џu7Щz­ Щж;Џ0јTЗго>kfэ¶лўJЉ“VitрϿ
ь°ащыЂ»ѓыъ,ЯуrxЂ•s	!ЃPCЃpДЭW #“)О68nСн'–ъЭ3ўKЃр1qm{dчfНBосz<б׈…єЉxГс+уЪJj'пwп"-1фЧAЌDДuРԥЄ7oѓфО%V+4ГȭљЗ	·;YЬгaваkъuучшЭ"@Ѫ%ћУdоф^Ъ0м/%¦¶ў”G!Ѓ0п`А“Е6bPٗIа-Ір+wї2ё_”ТУNbэФPФ ѓЭN€ѓǆфU·ЊHW­줰УуАsͽB
DЦ<pЅnE‘«ЎµДPёДpЊ–€о1±ао3%Лпђг.LоĿ ЯQs)wҐшўвЩpL@1› ЙlЊWHКд䅍 )ов!ь5o·В.н%чx ім(°¦B}ҧА9~О{Бэўў SГ^'¦Я
!Вԩџ( · ЧЙ#бааЙа~Qй
�6j—8hЦ`X>"™ٱМ쐙ЅeKҐќЌXJъЊ!‹Ђ3r]дсGc
пжnымFfv<7&ющJbµO!дAЁ aСс¬` y�/
RмaЖ%єg{т\BX]ґuуh@тP@^жВ'Аa`t_љ{*ѓЎF„@fЩ^`sџх‡k¬@ ffSm…ђЎf̗d04ЅЯћ’№†В]ДфІёыXДAіtуrБџYv$3ۗў֛­еq.±ШРч'H МжHbёµ&}*УmгjмНЫМ)-?\ <ўЫXH T±[(p򔉃f'<¬#FЕя-7ZМ7—lHЩНаАаm›ѓgf‡2іOМм
bPjS ¬%Fѕ_L̟яmlєЅdj=  EлЦ1^¬§>ы% ‘e™з‹Л *ћ$Ъ59-1T;H±ҐФnGіL‹g_ЭЙчии‹ۀ›‹БzНаАeЧ5¤Ѓс+`/“µ0hrЛ
§ыт“дщЁЛ=ЮНсо'–Го–=БГ%Y0Oўx!BЗчи$м—	Ђnf¬YЉF!њ–fѕџйZч<˝чДAУРNњ›ЩСМмі6ћЂ™40Ид-љЛJ6HЂўUім5^ў‘Y–°ؒц(„<еj=ђYv�eеjЗ@ЩFLЅПTЭIле_¤NчЭэПr—Vфґ№xНTБf` JޞМ sпсд}[ ffTŃРOu׿»ыҐ%“Љǁ{Х…<5¦lЈ3kЉBg ·OЛrq=pE‘Ќѓ;†…e)‚НG3Uрb‰ѓ¶̚©:xЋ*кЗ0
3;ке^„нІ¶ђ@Ёу…5ЈSпP–eчuI$|¤D)уЋЇЛ[ZhЩДи9кї0hrhS{>*хМ.ར>ѓёɗ–„Bнgq»#ЎРм‚ыyАЈДш‹=АПdЙطу2K|)рm1€Qt-ѕrl|5њ‰yХ	}yцзн鑼Wȋ $кП/ЃW›nЕn„‚»giйбюФ7#56ѓз¦y ЛO-ЌятВфКй%чИD}срчјl†tяЇ“AH Ф'жјяШif7іЕN—ZcТМbUрp–»_	ь*}~ Vвы+е›лԅу<дϾц1•eЂƦў69նЬо“
`…^„o©)
e1Ф0‹!EgVоьцSаЋа~ΠтцC±¶BюзM6^LзrњЕТЯКv§›mі3Л~ڲч·.›x°БמшрOкZzfР№чxєЋ‹-mlўы¤ґ№R іЛ(,Бњxء&)Ѓ ЃР^  6Nвсu5з8™ы‰щызЊ"R|еF@Nпeф­|¤Ӯ€i°9Jt;¬®eАѓcґoЇEЌF1аЋтћDїx*„°±]iрh{XЇ&9Ѕh‰aъxШefп4;ɡ*P3І“ٲЯЛYЛгдз¬ЭcL1gɎЯHфЕцы*ѓapјјcYi,Вc2•‚�.ћ&®1ѕђfP©єџЛ2}!@Ч/у%“жЇdўЃТ0دкЉBAґгFў{u§™}ђЉ+:	-Cu �т єБ°%o°J«a_бљMsE¦—ЂчуРRA9bЉyё€ёЮШтыр»Мм‹е]‘§Ў”я%фЕf	°1x̎ȋ ЪЮwљN]ђbЇlKЕжф8Ґху[ѓЫмD8№ї‡цЯоЬRЭ{Дтɢ;®Kmлљ!µg/ynТ&Je™Kѓѕ№юко—ܳ܍ʂK H H tЙцԹoNK^€ХL^dxћmЅѓׄфsЖaЖrfZЉъ. §¦vІћёЕМI"Ъ0O|х“Ћ(ЃPМ-АУyйҐїўіЃоЯK^sрĔШгЖqёШ@ЬiРЪ6вf<KJEнФЛ4 с%ЃPОgБГYн*,¶ШяаEu!ђeЩЧiV,Ѓ љмоЪНtSGъ!pa…ϯ№”ґ6НтПN?Ыz…§مki)Н`_ѕ;¤{hТо“Eǳ‚”ЭaпCАѓщtЊѕ®Ѓђ@ђ@ђ@Ё=пєыЦWм1аqаб	ш7¤Щшљфok7 ¤я†:шwqЬШЗмµjaБЭg\MІѕ!њ޾pR імKв6еbJPѓЭСИлё͌а>—вQ—ЁЅш3°›X/а±¤u3Ов?ЂkїЪݷч3ѓыFrRЪIE®Ж%RэGL—k{і¶F–[8)ѓњ¬”GyдAH„}Айт €e|ܷднg‘<	Утъ‰GX>л?•ёЦЯ~ќY&	T'›$O¤µпGыґcХ<ǂыЄlф„ВпNЧгcа|uт !тfZfЗr·%Ћћ„€лєo§™эЌ"аапАзiжџ7лЯдо«sgэmКPWA„ЪдJв _‘%B—в·D•lazvn•AyDOьСݿ[4·Ю[eѓuњэ{WСэ}S-пWт7С:@ЬХу q«мГIј<В{hТ~$xXЭ.Ј`ǻ“C“{]НмMа
u.љѓЉВșћо§ffStі,e-¤Y~ЮKУc71вHш_њґ{hп“CБГЪ1	(Oyњ„фo1ґД Do4€K
Зл"І›eґ›ތц#“…МмHfцefц	р Kе№[іДФȋЃoУг”C_
>К'In@БЉт ȃђнΚhBtщɃ0>ћжK‚КЖNМp
fҐ·S>DЬй ГqчOЬ=$В
¶?ПOyT°вґ0+"‹(га@f6по›F?B іў:ћf~߀­
ол
"Կ™ A,ЖПoЃ­Y–Э[ NОnvЙ\ §•™@tАЅАгfц¤ЂГ>=sЎі]3=˲Ѕ™ЩЗfцаfVєъіф8
Ш]Іµп™L^Ѓ'1оЛu_�бKх>„‚�T̴Љ0!<
|Шif�ЩСж@_&ډ‰МмxJу{ш1нЧщ3bсљуЃп ϗcГМ<wk߀:}Сyн7эUKS;тB“ўћ."–1~ 3ۗ/њМм3{«Ќ�#–Cю!Се;vзMʆЩL~Н1]4твjТЯЧ—D]‡A)¶`JБ.усХe_¤x[e№ЖOЩЮ
Д͐FЕпЃxNгHЗфpUЭпс	ѕOЖ¤ШКw_]Р~Я"f©€тя d­ы|]ыnз    IEND®B`‚]]

for slot140 = 0, 1000 do
	slot115[slot140] = {
		0
	}
end

slot137 = {
	"Погиб",
	"Умер",
	"Убит"
}
slot138 = slot2.new.int(1)

slot139 = function(slot0, slot1)
	slot2 = 10^(slot1 or 0)

	return math.floor(slot0 * slot2 + 0.5) / slot2
end

get_memory = function()
	return uv0(uv1.read(9325748, 4, true) / 1048576, 1)
end

slot140 = 32
slot141 = slot6.new("char[?]", slot140)
slot142 = slot6.new("char[?]", slot140)
chars = {
	["ы"] = "s",
	["г"] = "u",
	["и"] = "b",
	["ъ"] = "]",
	["л"] = "k",
	["ж"] = ";",
	["Й"] = "Q",
	["д"] = "l",
	["п"] = "g",
	["ш"] = "i",
	["И"] = "B",
	["х"] = "[",
	["о"] = "j",
	["е"] = "t",
	["ц"] = "w",
	["у"] = "e",
	["П"] = "G",
	["р"] = "h",
	["н"] = "y",
	["т"] = "n",
	["О"] = "J",
	["У"] = "E",
	["Е"] = "T",
	["в"] = "d",
	["Н"] = "Y",
	["Ш"] = "I",
	["Щ"] = "O",
	["Г"] = "U",
	["с"] = "c",
	["З"] = "P",
	["Х"] = "{",
	["В"] = "D",
	["б"] = ",",
	["Ы"] = "S",
	["Ф"] = "A",
	["ф"] = "a",
	["а"] = "f",
	["Ц"] = "W",
	["Л"] = "K",
	["я"] = "z",
	["Р"] = "H",
	["э"] = "'",
	["Д"] = "L",
	["ю"] = ".",
	["А"] = "F",
	["ь"] = "m",
	["Ж"] = ":",
	["Э"] = "\"",
	["Ю"] = ">",
	["м"] = "v",
	["Ч"] = "X",
	["С"] = "C",
	["М"] = "V",
	["к"] = "r",
	["ч"] = "x",
	["щ"] = "o",
	["Т"] = "N",
	["Ъ"] = "}",
	["з"] = "p",
	["Ь"] = "M",
	["Б"] = "<",
	["К"] = "R",
	["й"] = "q",
	["Я"] = "Z"
}
names = {}
getAllUsers = ""
ttdmesinfo = ""
statsresponse = ""
phonenumber = ""
getServerVip = ""
nickVIP = {}
debtorsellon = false
nickVIP1 = ""
cityname = ""
zonename = ""
unamerr = ""
sobesid = ""
newrsn = ""
idprsn = ""
FAVnicks = {}
flymode = 0
teplivizor = 0
speed = 0.2
speedCC = 0
ScriptUse = 3
ccinform = 0
gateopenonh = false
autorpgateon = false
inform = true
act1 = true
fixspeedon = false
offstort = false
scriptonl = false
statusscriptra = nil
scenazaheal = nil
srv = nil
lastnumberon = nil
vsego = nil
nasosal_rang = nil
RABotyaga = false
VipStatus = false
dobropojrec = false
enableStrobes = false
bi = false
otchet1 = false
isPlayerSoldier = false
isPlayerMassMedia = false
isPlayerGoverment = false
isPlayerSoldierPolice = false
isPlayerSoldierGhetto = false
isPlayerSoldierMafia = false
isPlayerSoldierMed = false
state = false
timerdlyasu = false
hiinvite = false
regDialogOpen = false
enableCC = false
autootvetchik = false
regAcc = false
idnaid = false
byemedic = false
offMask = true
about_bind = {}
binder_text = {
	slot2.new.char[1024](""),
	slot2.new.char[192](""),
	slot2.new.int[16](0)
}
selected_item_binder = slot2.new.int(0)
slot143 = {
	u8("На клавишу (комбинацию клавиш)"),
	u8("На команду (прим. /command)")
}
slot144 = slot2.new["const char*"][#slot143](slot143)

patch = function()
	if uv0.getuint8(7638059) == 232 then
		uv0.fill(7638059, 144, 5, true)
	elseif uv0.getuint8(7638139) == 232 then
		uv0.fill(7638139, 144, 5, true)
	end

	if uv0.getuint8(5835178) == 190 then
		uv0.write(5835179, 1, 1, true)
	end

	if uv0.getuint8(5835293) == 190 then
		uv0.write(5835293, 233, 1, true)
		uv0.write(5835294, 141, 4, true)
	end

	if uv0.getuint8(7638123) == 198 then
		uv0.fill(7638123, 144, 7, true)
	elseif uv0.getuint8(7638203) == 198 then
		uv0.fill(7638203, 144, 7, true)
	end

	if uv0.getuint8(5835504) == 161 then
		uv0.write(5835504, 233, 1, true)
		uv0.write(5835505, 320, 4, true)
	end
end

patch()

SetStyle = function()
	uv0.SwitchContext()

	slot0 = uv0.GetStyle()
	slot1 = slot0.Colors
	slot2 = uv0.Col
	slot3 = uv0.ImVec4
	slot0.ScrollbarSize = 11
	slot0.ScrollbarRounding = 13
	slot0.WindowTitleAlign = uv0.ImVec2(0.5, 0.5)
	slot0.WindowRounding = 13
	slot0.ChildRounding = 13
	slot0.FrameRounding = 7
	slot0.GrabMinSize = 8
	slot0.GrabRounding = 15
	slot0.WindowBorderSize = 0
	slot1[slot2.Text] = slot3(1, 1, 1, 1)
	slot1[slot2.TextDisabled] = slot3(0.6, 0.6, 0.6, 1)
	slot1[slot2.WindowBg] = slot3(0.08, 0.08, 0.08, 0.975)
	slot1[slot2.Border] = slot3(0.7, 0.7, 0.7, 0.15)
	slot1[slot2.BorderShadow] = slot3(0, 0, 0, 0)
	slot1[slot2.FrameBg] = slot3(0.33, 0.85, 0.65, 0.54)
	slot1[slot2.FrameBgHovered] = slot3(0.38, 0.38, 0.38, 0.54)
	slot1[slot2.FrameBgActive] = slot3(0.38, 0.38, 0.38, 0.54)
	slot1[slot2.TitleBg] = slot3(0.38, 0.38, 0.38, 0.54)
	slot1[slot2.TitleBgActive] = slot3(0, 0, 0, 0.95)
	slot1[slot2.TitleBgCollapsed] = slot3(0, 0, 0, 0.51)
	slot1[slot2.MenuBarBg] = slot3(0.14, 0.14, 0.14, 1)
	slot1[slot2.ScrollbarBg] = slot3(0.02, 0.02, 0.02, 0.53)
	slot1[slot2.ScrollbarGrab] = slot3(0.31, 0.31, 0.31, 1)
	slot1[slot2.ScrollbarGrabHovered] = slot3(0.41, 0.41, 0.41, 1)
	slot1[slot2.ScrollbarGrabActive] = slot3(0.51, 0.51, 0.51, 1)
	slot1[slot2.CheckMark] = slot3(0.99, 0.99, 0.99, 1)
	slot1[slot2.SliderGrab] = slot3(1, 1, 1, 1)
	slot1[slot2.SliderGrabActive] = slot3(1, 1, 1, 1)
	slot1[slot2.Button] = slot3(0.33, 0.85, 0.65, 0.4)
	slot1[slot2.ButtonHovered] = slot3(0.33, 0.85, 0.65, 1)
	slot1[slot2.ButtonActive] = slot3(0.33, 0.85, 0.65, 1)
	slot1[slot2.Header] = slot3(0.33, 0.85, 0.65, 0.31)
	slot1[slot2.HeaderHovered] = slot3(0.33, 0.85, 0.65, 1)
	slot1[slot2.HeaderActive] = slot3(0.33, 0.85, 0.65, 1)
	slot1[slot2.Separator] = slot3(0.5, 0.5, 0.5, 1)
	slot1[slot2.SeparatorHovered] = slot3(0.6, 0.6, 0.7, 1)
	slot1[slot2.SeparatorActive] = slot3(0.7, 0.7, 0.9, 1)
	slot1[slot2.ResizeGrip] = slot3(1, 1, 1, 0.3)
	slot1[slot2.ResizeGripHovered] = slot3(1, 1, 1, 0.6)
	slot1[slot2.ResizeGripActive] = slot3(1, 1, 1, 0.9)
	slot1[slot2.PlotLines] = slot3(1, 1, 1, 1)
	slot1[slot2.PlotLinesHovered] = slot3(0.9, 0.7, 0, 1)
	slot1[slot2.PlotHistogram] = slot3(0.9, 0.7, 0, 1)
	slot1[slot2.PlotHistogramHovered] = slot3(1, 0.6, 0, 1)
	slot1[slot2.TextSelectedBg] = slot3(0.26, 0.59, 0.98, 0.35)
	slot1[slot2.PopupBg] = slot3(0.1, 0.1, 0.1, 0.9)
	slot1[slot2.ModalWindowDimBg] = slot3(0.13, 0.13, 0.13, 0.475)

	return slot1, slot2
end

slot145 = nil

slot2.OnInitialize(function ()
	uv0.GetIO().IniFilename = nil

	uv0.SwitchContext()

	slot0, slot1, slot2, slot3 = nil

	if uv1 then
		if uv2.cfgGen.fontsmenu == 1 then
			slot0 = getFolderPath(20) .. "\\Arial.ttf"
			slot1 = getGameDirectory() .. "\\moonloader\\lib\\Semibold.ttf"
		elseif uv2.cfgGen.fontsmenu == 2 then
			slot0 = getFolderPath(20) .. "\\trebucbd.ttf"
			slot1 = getGameDirectory() .. "\\moonloader\\lib\\Semibold.ttf"
		else
			slot0 = getGameDirectory() .. "\\moonloader\\lib\\Semibold.ttf"
			slot1 = getGameDirectory() .. "\\moonloader\\lib\\Semibold.ttf"
		end
	else
		slot0 = getFolderPath(20) .. "\\Arial.ttf"
		slot1 = getFolderPath(20) .. "\\Arial.ttf"
	end

	assert(doesFileExist(slot0), "[mimgui] Font \"" .. slot0 .. "\" doesn't exist!")

	slot4 = uv0.ImFontGlyphRangesBuilder()

	slot4:AddRanges(uv0.GetIO().Fonts:GetGlyphRangesCyrillic())
	slot4:AddText(u8("‚„…†‡€‰‹‘’“”•–—™›№"))

	slot5 = uv0.ImVector_ImWchar()

	slot4:BuildRanges(slot5)

	uv3 = uv0.GetIO().Fonts:AddFontFromFileTTF(slot0, uv2.cfgGen.sizemenu, nil, slot5[0].Data)
	BmainFont = uv0.GetIO().Fonts:AddFontFromFileTTF(slot1, 27, nil, slot5[0].Data)
	ttdmainFont = uv0.GetIO().Fonts:AddFontFromFileTTF(slot0, 13, nil, slot5[0].Data)
	InfomainFont = uv0.GetIO().Fonts:AddFontFromFileTTF(slot1, 19, nil, slot5[0].Data)

	uv0.GetIO().Fonts:Build()

	if uv2.cfgGen.themes == 0 then
		SetStyle()
	elseif uv2.cfgGen.themes == 1 then
		SetStyle2()
	elseif uv2.cfgGen.themes == 2 then
		SetStyle3()
	end

	uv4 = uv0.CreateTextureFromFileInMemory(uv0.new("const char*", exit_data), #exit_data)
end)

SetStyle2 = function()
	uv0.SwitchContext()

	slot0 = uv0.GetStyle()
	slot1 = slot0.Colors
	slot2 = uv0.Col
	slot3 = uv0.ImVec4
	slot0.ScrollbarSize = 12
	slot0.ScrollbarRounding = 15
	slot0.WindowRounding = 13
	slot0.ChildRounding = 15
	slot0.WindowTitleAlign = uv0.ImVec2(0.5, 0.5)
	slot0.FrameRounding = 7
	slot0.GrabMinSize = 8
	slot0.GrabRounding = 15
	slot1[slot2.Text] = slot3(1, 1, 1, 1)
	slot1[slot2.TextDisabled] = slot3(0.6, 0.6, 0.6, 1)
	slot1[slot2.WindowBg] = slot3(0.08, 0.08, 0.08, 0.975)
	slot1[slot2.PopupBg] = slot3(0.1, 0.1, 0.1, 0.9)
	slot1[slot2.Border] = slot3(0.7, 0.7, 0.7, 0.15)
	slot1[slot2.BorderShadow] = slot3(0, 0, 0, 0)
	slot1[slot2.FrameBg] = slot3(0.48, 0.16, 0.16, 0.54)
	slot1[slot2.FrameBgHovered] = slot3(0.98, 0.26, 0.26, 0.4)
	slot1[slot2.FrameBgActive] = slot3(0.98, 0.26, 0.26, 0.67)
	slot1[slot2.TitleBg] = slot3(0.48, 0.16, 0.16, 1)
	slot1[slot2.TitleBgActive] = slot3(0.48, 0.16, 0.16, 1)
	slot1[slot2.TitleBgCollapsed] = slot3(0, 0, 0, 0.51)
	slot1[slot2.MenuBarBg] = slot3(0.14, 0.14, 0.14, 1)
	slot1[slot2.ScrollbarBg] = slot3(0.02, 0.02, 0.02, 0.53)
	slot1[slot2.ScrollbarGrab] = slot3(0.31, 0.31, 0.31, 1)
	slot1[slot2.ScrollbarGrabHovered] = slot3(0.41, 0.41, 0.41, 1)
	slot1[slot2.ScrollbarGrabActive] = slot3(0.51, 0.51, 0.51, 1)
	slot1[slot2.CheckMark] = slot3(0.98, 0.26, 0.26, 1)
	slot1[slot2.SliderGrab] = slot3(0.88, 0.24, 0.24, 1)
	slot1[slot2.SliderGrabActive] = slot3(0.98, 0.26, 0.26, 1)
	slot1[slot2.Button] = slot3(0.98, 0.26, 0.26, 0.4)
	slot1[slot2.ButtonHovered] = slot3(0.98, 0.26, 0.26, 1)
	slot1[slot2.ButtonActive] = slot3(0.98, 0.06, 0.06, 1)
	slot1[slot2.Header] = slot3(0.98, 0.26, 0.26, 0.31)
	slot1[slot2.HeaderHovered] = slot3(0.98, 0.26, 0.26, 0.8)
	slot1[slot2.HeaderActive] = slot3(0.98, 0.26, 0.26, 1)
	slot1[slot2.Separator] = slot3(0.5, 0.5, 0.5, 1)
	slot1[slot2.SeparatorHovered] = slot3(0.6, 0.6, 0.7, 1)
	slot1[slot2.SeparatorActive] = slot3(0.7, 0.7, 0.9, 1)
	slot1[slot2.ResizeGrip] = slot3(1, 1, 1, 0.3)
	slot1[slot2.ResizeGripHovered] = slot3(1, 1, 1, 0.6)
	slot1[slot2.ResizeGripActive] = slot3(1, 1, 1, 0.9)
	slot1[slot2.PlotLines] = slot3(1, 1, 1, 1)
	slot1[slot2.PlotLinesHovered] = slot3(0.9, 0.7, 0, 1)
	slot1[slot2.PlotHistogram] = slot3(0.9, 0.7, 0, 1)
	slot1[slot2.PlotHistogramHovered] = slot3(1, 0.6, 0, 1)
	slot1[slot2.TextSelectedBg] = slot3(0.26, 0.59, 0.98, 0.35)
	slot1[slot2.ModalWindowDimBg] = slot3(0.13, 0.13, 0.13, 0.475)

	return slot1, slot2
end

SetStyle3 = function()
	uv0.SwitchContext()

	slot0 = uv0.GetStyle()
	slot1 = slot0.Colors
	slot2 = uv0.Col
	slot3 = uv0.ImVec4
	slot0.ScrollbarSize = 12
	slot0.ScrollbarRounding = 15
	slot0.WindowTitleAlign = uv0.ImVec2(0.5, 0.5)
	slot0.WindowRounding = 13
	slot0.ChildRounding = 15
	slot0.FrameRounding = 7
	slot0.GrabMinSize = 8
	slot0.GrabRounding = 15
	slot1[slot2.Text] = slot3(1, 1, 1, 1)
	slot1[slot2.TextDisabled] = slot3(0.6, 0.6, 0.6, 1)
	slot1[slot2.WindowBg] = slot3(0.08, 0.08, 0.08, 0.975)
	slot1[slot2.PopupBg] = slot3(0.1, 0.1, 0.1, 0.9)
	slot1[slot2.Border] = slot3(0.7, 0.7, 0.7, 0.15)
	slot1[slot2.BorderShadow] = slot3(0, 0, 0, 0)
	slot1[slot2.FrameBg] = slot3(0.33, 0.16, 0.48, 0.54)
	slot1[slot2.FrameBgHovered] = slot3(0.64, 0.26, 0.98, 0.4)
	slot1[slot2.FrameBgActive] = slot3(0.55, 0.26, 0.98, 0.67)
	slot1[slot2.TitleBg] = slot3(0.29, 0.16, 0.48, 1)
	slot1[slot2.TitleBgActive] = slot3(0.32, 0.16, 0.48, 1)
	slot1[slot2.TitleBgCollapsed] = slot3(0, 0, 0, 0.51)
	slot1[slot2.MenuBarBg] = slot3(0.14, 0.14, 0.14, 1)
	slot1[slot2.ScrollbarBg] = slot3(0.02, 0.02, 0.02, 0.53)
	slot1[slot2.ScrollbarGrab] = slot3(0.31, 0.31, 0.31, 1)
	slot1[slot2.ScrollbarGrabHovered] = slot3(0.41, 0.41, 0.41, 1)
	slot1[slot2.ScrollbarGrabActive] = slot3(0.51, 0.51, 0.51, 1)
	slot1[slot2.CheckMark] = slot3(0.55, 0.26, 0.98, 1)
	slot1[slot2.SliderGrab] = slot3(0.51, 0.24, 0.88, 1)
	slot1[slot2.SliderGrabActive] = slot3(0.55, 0.26, 0.98, 1)
	slot1[slot2.Button] = slot3(0.5, 0.26, 0.98, 0.4)
	slot1[slot2.ButtonHovered] = slot3(0.57, 0.26, 0.98, 1)
	slot1[slot2.ButtonActive] = slot3(0.54, 0.06, 0.98, 1)
	slot1[slot2.Header] = slot3(0.59, 0.26, 0.98, 0.31)
	slot1[slot2.HeaderHovered] = slot3(0.43, 0.26, 0.98, 0.8)
	slot1[slot2.HeaderActive] = slot3(0.77, 0.26, 0.98, 1)
	slot1[slot2.Separator] = slot3(0.5, 0.5, 0.5, 1)
	slot1[slot2.SeparatorHovered] = slot3(0.6, 0.6, 0.7, 1)
	slot1[slot2.SeparatorActive] = slot3(0.7, 0.7, 0.9, 1)
	slot1[slot2.ResizeGrip] = slot3(1, 1, 1, 0.3)
	slot1[slot2.ResizeGripHovered] = slot3(1, 1, 1, 0.6)
	slot1[slot2.ResizeGripActive] = slot3(1, 1, 1, 0.9)
	slot1[slot2.PlotLines] = slot3(1, 1, 1, 1)
	slot1[slot2.PlotLinesHovered] = slot3(0.9, 0.7, 0, 1)
	slot1[slot2.PlotHistogram] = slot3(0.9, 0.7, 0, 1)
	slot1[slot2.PlotHistogramHovered] = slot3(1, 0.6, 0, 1)
	slot1[slot2.TextSelectedBg] = slot3(0.26, 0.59, 0.98, 0.35)
	slot1[slot2.ModalWindowDimBg] = slot3(0.13, 0.13, 0.13, 0.475)

	return slot1, slot2
end

main = function()
	if not isSampLoaded() or not isSampfuncsLoaded() then
		return
	end

	while not isSampAvailable() do
		wait(100)
	end

	loadcfg()
	require("memory").setuint8(getModuleHandle("samp.dll") + 422992, 195, true)
	executeIndependentScript([[
    require "lib.moonloader"
    local sampev = require('lib.samp.events')
	local imgui = require('mimgui')
	local encoding = require('encoding')
	local tempFileName = getGameDirectory() .. "\\moonloader\\HAreporter.lua"
	local windowHA = imgui.new.bool(false)
	local sw, sh = getScreenResolution()
	local texterror = imgui.new.char[65536]
	
	encoding.default = 'CP1251'
	u8 = encoding.UTF8
    
    function main()
        if not isSampLoaded() or not isSampfuncsLoaded() then return end
        while not isSampAvailable() do wait(100) end
    end
	
	local newFrame = imgui.OnFrame(
		function() return windowHA[0] end,
		function(player)
			imgui.SetNextWindowSize(imgui.ImVec2(237, 300), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			if not imgui.IsPopupOpen(u8'Ошибка') then
				imgui.OpenPopup(u8'Ошибка')
			end
			if imgui.BeginPopupModal(u8'Ошибка', nil, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar) then
				imgui.PushFont(mainFont)
				imgui.Text(u8"Произошла непредусмотренная ошибка в скрипте. В случае повтора вы можете уведомить разработчика.")
				imgui.Text(u8" ")
				imgui.Text(u8(texterror[0]))
				imgui.PopFont()
				imgui.Separator()
				imgui.SetCursorPosX((imgui.GetWindowWidth() - 360) / 2)
				if imgui.Button(u8'Скопировать ошибку и связаться', imgui.ImVec2(220, 0)) then
					setClipboardText(texterror[0])
					os.execute("explorer https://t.me/rvngsp")
					windowHA[0] = not windowHA[0]
					imgui.Process = windowHA[0]
					script.this:unload()
					os.remove(tempFileName)
				end
				imgui.SameLine()
				if imgui.Button(u8'Закрыть', imgui.ImVec2(120, 0)) then
					windowHA[0] = not windowHA[0]
					imgui.Process = windowHA[0]
					script.this:unload()
					os.remove(tempFileName)
				end
				imgui.EndPopup()
			end
		end
	)
	
    function onSystemMessage(msg, type, script)
        if (msg:find('helper%.lua?:%d+:.+') or msg:find('helper%.luac?:%d+:.+')) and type == 3 then
			texterror[0] = msg
			windowHA[0] = not windowHA[0]
			imgui.Process = windowHA[0]
        end
    end
	
	imgui.OnInitialize(function()
		SetStyle()
	end)
	
	function SetStyle()
		imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4
		style.WindowRounding = 13.0
		style.ChildRounding = 15.0
		style.FrameRounding  = 7
		style.GrabMinSize = 8
		style.GrabRounding = 15
		colors[clr.WindowBg]               = ImVec4(0.13, 0.13, 0.13, 0.975)
		colors[clr.Button]                 = ImVec4(0.33, 0.85, 0.65, 0.40)
		colors[clr.ButtonHovered]          = ImVec4(0.33, 0.85, 0.65, 1.00)
		colors[clr.ButtonActive]           = ImVec4(0.33, 0.85, 0.65, 1.00)
		colors[clr.ModalWindowDimBg]	   = ImVec4(0.13, 0.13, 0.13, 0.475)
	end
	
]])
	sampRegisterChatCommand("nhrec", reconnect)

	if uv0 and uv1 and uv2 then
		pcall(uv2.check, uv2.json_url, uv2.prefix, uv2.url)
	end

	if tonumber(os.date("%m")) == 12 or slot0 == 1 then
		createSnowflakes()
	end

	if not doesFileExist(getGameDirectory() .. "\\moonloader\\config\\HorAssist\\house.ini") then
		async_http_request("GET", "https://raw.githubusercontent.com/dijw/nn-helper/main/house.ini", nil, function (slot0)
			slot1 = assert(io.open(getWorkingDirectory() .. "\\config\\HorAssist\\house.ini", "wb"))

			slot1:write(slot0.text)
			print(slot1)
			slot1:close()
		end, function (slot0)
			print("HouseID: " .. slot0)
		end)
	end

	if not doesFileExist(getGameDirectory() .. "\\moonloader\\lib\\Semibold.ttf") then
		async_http_request("GET", "https://raw.githubusercontent.com/dijw/nn-helper/main/Semibold.ttf", nil, function (slot0)
			slot1 = assert(io.open(getWorkingDirectory() .. "\\lib\\Semibold.ttf", "wb"))

			slot1:write(slot0.text)
			slot1:close()

			uv0 = true

			TriggerNotification("Установка шрифта.")
			thisScript():reload()
		end, function (slot0)
			print("wrift: " .. slot0)
		end)
	else
		uv3 = true
	end

	set_dist(3, uv4.cfgButton.waterfix)
	set_dist(4, uv4.cfgButton.blackroads)
	set_dist(5, uv4.cfgButton.forceaniso)
	set_dist(6, uv4.cfgButton.sunfix)
	set_dist(9, uv4.cfgButton.tiretracks)
	set_dist(10, uv4.cfgButton.nobirds)
	set_dist(11, uv4.cfgButton.nocloud)
	set_dist(12, uv4.cfgButton.cleanmemory)
	set_dist(13, uv4.cfgButton.nodust)
	set_dist(14, uv4.cfgButton.noexplosion)
	set_dist(16, uv4.cfgButton.TunFix)
	set_dist(18, uv4.cfgButton.moneyborder)
	set_dist(20, uv4.cfgButton.fixspeed)
	set_dist(21, uv4.cfgButton.blockf4)
	set_dist(22, uv4.cfgButton.opentchat)

	repeat
		wait(10)
	until sampIsLocalPlayerSpawned()

	if sampGetCurrentServerAddress() == "185.169.134.237" then
		srv = 1
	elseif sampGetCurrentServerAddress() == "185.169.134.238" then
		srv = 2
	elseif sampGetCurrentServerAddress() == "185.169.134.239" then
		srv = 3
	elseif sampGetCurrentServerAddress() == "185.169.134.156" then
		srv = 4
	elseif sampGetCurrentServerAddress() == "185.169.134.157" then
		srv = 5
	else
		srv = 99
	end

	_, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
	userNick = sampGetPlayerNickname(myID)
	mycolornika = sampGetPlayerColor(myID)
	nickName = userNick:gsub("_", " ")
	nick_player1, nick_player2 = string.match(userNick, "(%S+)_(%S+)")
	regDialogOpen = true

	if srv <= 6 then
		sampSendChat("/mn")
	else
		sampSendChat("/stats")
	end

	slot1 = os.clock()

	while regDialogOpen and os.clock() - slot1 < 5 do
		wait(0)
	end

	if regDialogOpen then
		uv5 = true

		AddChatMessage("Включен автономный режим. Это может быть связанно из-за CEF интерфейса.")
		AddChatMessage("Если Вы хотите доступ к полному функционалу скрипта - отключите его в настройках лаунчера.")

		nasosal_rang = tonumber(hrangValue) or 0
		playerAccoutNumber = tonumber(hnumberaccValue) or 0
		uv6 = tonumber(hnumberphoneValue) or 0
		org = horgValue

		if org == "Ministry of Defence" then
			isPlayerSoldier = true
			statusscriptra = u8("HA for MoD")
			uv7 = "Мин.Обороны"
			ScriptUse = 1
		elseif org == "Ministry of Health" then
			uv7 = "Мин.Здравоохранения"
			statusscriptra = u8("HA for MoH")
			isPlayerSoldierMed = true
			ScriptUse = 1
		elseif org == "Ministry of the Interior" then
			uv7 = "Мин.Внутренних Дел"
			statusscriptra = u8("HA for MIA")
			ScriptUse = 1
			isPlayerSoldierPolice = true
		elseif org == "Government" then
			uv7 = "Правительство"
			statusscriptra = u8("HA for Gov")
			ScriptUse = 1
			isPlayerGoverment = true
		elseif org == "MassMedia" then
			uv7 = "Мин. связи и коммуникаций"
			statusscriptra = u8("HA for MM")
			ScriptUse = 1
			isPlayerMassMedia = true
		elseif org == "Mafia" then
			statusscriptra = u8("HA Mafia")
			ScriptUse = 1
			isPlayerSoldierMafia = true
		elseif org == "Ghetto" then
			statusscriptra = u8("HA Ghetto")
			ScriptUse = 1
			isPlayerSoldierGhetto = true
		else
			statusscriptra = u8("NN Basic")
			ScriptUse = 0
			org = "None"
			isPlayerSoldier = false
			isPlayerSoldierPolice = false
			isPlayerSoldierMed = false
		end
	else
		while ScriptUse == 3 do
			wait(0)
		end

		if srv <= 6 then
			ScriptUse = 3
			regAcc = true

			sampSendChat("/mn")

			slot2 = os.clock()

			while ScriptUse == 3 and os.clock() - slot2 < 5 do
				wait(0)
			end

			if ScriptUse == 4 then
				reloadScript = true

				thisScript():unload()

				return
			end
		end
	end

	if userNick ~= "Mike_Damos" and not uv5 then
		slot3 = os.time(os.date("!*t")) + 10800

		async_http_request("POST", "https://hora.su/stats.php", {
			data = "&srv=" .. tostring(srv) .. "&n=" .. tostring(userNick) .. "&number=" .. tostring(playerAccoutNumber) .. "&phone=" .. tostring(uv6) .. "&rang=" .. tostring(nasosal_rang) .. "&org=" .. tostring(org) .. "&adm=" .. tostring(uv8) .. "&ver=" .. tostring(script_version) .. "&disk=" .. tostring(uv9),
			headers = {
				["content-type"] = "application/x-www-form-urlencoded"
			}
		}, function (slot0)
		end, function (slot0)
		end)
	end

	slot2 = {
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}

	if not uv5 then
		slot2.data = "vip=true&users=true&message=true&halava=true&ttdmesinfo=true&colorbg=true&srv=" .. tostring(srv) .. "&number=" .. tostring(playerAccoutNumber)
	else
		slot2.data = "vip=true&users=true&message=true&halava=true&ttdmesinfo=true&colorbg=true&srv=" .. tostring(srv)
	end

	async_http_request("POST", "https://hora.su/request.php", slot2, function (slot0)
		slot2 = {}

		for slot6 in slot0.text:gmatch("[^\r\n]+") do
			table.insert(slot2, slot6)
		end

		for slot6, slot7 in ipairs(slot2) do
			slot8, slot9 = slot7:match("(%a+):%s+(.+)")

			if slot8 == "vip" then
				for slot13, slot14 in slot9:gmatch("(%w+_%w+) | (%w+) </br>") do
					nickname = slot13:match("(%w+_%w+)")
					color = slot14:match("(%w+)")

					if nickname then
						table.insert(nickVIP, {
							nickname,
							color
						})
					end
				end

				if not uv0 then
					slot6, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
					userNick = sampGetPlayerNickname(myID)

					for slot13, slot14 in ipairs(nickVIP) do
						if slot14[1] ~= nil then
							if userNick:find(slot14[1]) then
								VipStatus = true

								break
							else
								VipStatus = false
							end
						end
					end
				end
			elseif slot8 == "users" then
				getAllUsers = slot9
			elseif slot8 == "message" then
				if u8:decode(slot9) ~= "-" then
					if u8:decode(slot9) ~= "" then
						AddChatMessage(u8:decode(slot9))
					end
				end
			elseif slot8 == "ttdmesinfo" then
				ttdmesinfo = slot9
			elseif slot8 == "halava" then
				getHalavaa = slot9
			elseif slot8 == "colorbg" then
				uv1 = slot9
			end
		end
	end, function (slot0)
		print("multirequest: " .. slot0)
	end)

	if chatinfoValue then
		inputHelpText = renderCreateFont("Arial", 9, FCR_BORDER)

		lua_thread.create(inputChat)
		lua_thread.create(showInputHelp)
	end

	wait(10)

	thread = lua_thread.create_suspended(thread_function)

	sampRegisterChatCommand("ncc", clearchatoda)
	sampRegisterChatCommand("nh", startnh)
	sampRegisterChatCommand("nstats", startvipinfo)
	sampRegisterChatCommand("nanim", startanimlist)
	sampRegisterChatCommand("makegun", startmakegun)
	sampRegisterChatCommand("nvip", cmd_vipinfo)
	sampRegisterChatCommand("nid", cmd_id)
	sampRegisterChatCommand("bomb", cmd_bomb)
	sampRegisterChatCommand("tie", cmd_tie)
	sampRegisterChatCommand("untie", cmd_untie)
	sampRegisterChatCommand("bag", cmd_bag)
	sampRegisterChatCommand("unbag", cmd_unbag)
	sampRegisterChatCommand("lock", cmd_lock)
	sampRegisterChatCommand("c", cmd_time)
	sampRegisterChatCommand("nlink", cmd_nhalava)
	sampRegisterChatCommand("meg", cmd_meg)
	sampRegisterChatCommand("mg", cmd_mg)
	sampRegisterChatCommand("dfr", otchet)
	sampRegisterChatCommand("givelic", cmdgivelic)
	sampRegisterChatCommand("number", cmd_number)
	sampRegisterChatCommand("sobes", autosobes)
	sampRegisterChatCommand("donor", donor)
	sampRegisterChatCommand("r", rradio)
	sampRegisterChatCommand("f", fradio)
	sampRegisterChatCommand("where", where)
	sampRegisterChatCommand("efir", cmdedir)
	sampRegisterChatCommand("rd", cmd_rd)
	sampRegisterChatCommand("hist", cmd_histid)
	sampRegisterChatCommand("fd", cmd_fd)
	sampRegisterChatCommand("find", ex_find)
	sampRegisterChatCommand("ok", cmd_ok)
	sampRegisterChatCommand("mask", cmd_mask)
	sampRegisterChatCommand("cuff", cmd_cuff)
	sampRegisterChatCommand("skip", cmd_skip)
	sampRegisterChatCommand("putpl", cmd_putpl)
	sampRegisterChatCommand("hold", cmd_hold)
	sampRegisterChatCommand("pull", cmd_pull)
	sampRegisterChatCommand("clear", cmd_clear)
	sampRegisterChatCommand("takelic", cmd_takelic)
	sampRegisterChatCommand("search", cmd_search)
	sampRegisterChatCommand("setmark", cmd_setmark)
	sampRegisterChatCommand("arrest", cmd_arrest)
	sampRegisterChatCommand("uncuff", cmd_uncuff)
	sampRegisterChatCommand("healme", cmd_healme)
	sampRegisterChatCommand("gate", cmd_gate)
	sampRegisterChatCommand("open", cmd_gate)
	sampRegisterChatCommand("changeskin", ex_skin)
	sampRegisterChatCommand("invite", ex_invite)
	sampRegisterChatCommand("inv", ex_invite)
	sampRegisterChatCommand("uninvite", ex_uninvite)
	sampRegisterChatCommand("unv", ex_uninvite)
	sampRegisterChatCommand("rang", ex_rang)
	sampRegisterChatCommand("nhrel", rel)
	sampRegisterChatCommand("drive", cmd_drive)
	sampRegisterChatCommand("ud", cmd_ud)
	sampRegisterChatCommand("drone", drone)
	sampRegisterChatCommand("nht", cmdSetTime)
	sampRegisterChatCommand("nhw", cmdSetWeather)
	sampRegisterChatCommand("ts", autosms)
	sampRegisterChatCommand("ttd", informtimer)
	sampRegisterChatCommand("wr", vizovvchat)
	sampRegisterChatCommand("free", cmdfree)
	sampRegisterChatCommand("heal", healincar)
	sampRegisterChatCommand("findhouse", whereh)
	sampRegisterChatCommand("su", cmd_su)
	sampRegisterChatCommand("sured", cmd_sured)
	sampRegisterChatCommand("ticket", cmd_ticket)
	sampRegisterChatCommand("ticketred", cmd_ticketred)
	sampRegisterChatCommand("nbp", function ()
		uv0 = true

		sampSendChat("/mn")
	end)
	sampRegisterChatCommand("nzam", function ()
		uv0.zametki[0] = not uv0.zametki[0]
		uv1.Process = uv0.zametki[0]
	end)
	sampRegisterChatCommand("ntags", function ()
		uv0.tegi[0] = not uv0.tegi[0]
		uv1.Process = uv0.tegi[0]
	end)
	sampRegisterChatCommand("gos", function ()
		if nasosal_rang <= 9 then
			TriggerNotification("Данная команда доступна только лидерам.")

			return
		end

		uv0.gos[0] = not uv0.gos[0]
		uv1.Process = uv0.gos[0]
	end)
	sampRegisterChatCommand("rep", function (slot0)
		if slot0 ~= "" then
			message = slot0

			sampSendChat("/re " .. message)
		else
			TriggerNotification("Используйте: /rep (жалоба).")
		end
	end)
	wait(500)

	if VipStatus then
		if starthi1Value ~= "" then
			AddChatMessage(string.format("%s", u8:decode(starthi1Value)))
		end
	else
		AddChatMessage("Скрипт успешно запущен - /nh")
	end

	lua_thread.create(render)

	while true do
		checkGateControlText()

		if uv14 and os.clock() - uv15 >= 3 then
			uv14 = false

			async_http_request("POST", "https://hora.su/ChangeColor.php", {
				data = "&srv=" .. tostring(srv) .. "&n=" .. tostring(userNick) .. "&color=" .. tostring(vipcolor),
				headers = {
					["content-type"] = "application/x-www-form-urlencoded"
				}
			}, function (slot0)
			end, function (slot0)
				print("VIPcolor: " .. slot0)
			end)
		end

		if uv16 and os.clock() - uv15 >= 3 then
			uv16 = false

			async_http_request("POST", "https://hora.su/ChangeColorBg.php", {
				data = "&srv=" .. tostring(srv) .. "&n=" .. tostring(userNick) .. "&colorbg=" .. tostring(uv10),
				headers = {
					["content-type"] = "application/x-www-form-urlencoded"
				}
			}, function (slot0)
			end, function (slot0)
				print("BGcolor: " .. slot0)
			end)
		end

		if fixspeedon then
			CARRESULT = isCharInAnyCar(PLAYER_PED)

			if CARRESULT then
				cars = storeCarCharIsInNoSave(PLAYER_PED)
				speedcar = getCarSpeed(cars)
				TDtext = sampTextdrawGetString(idtextdraw)

				if TDtext:find("Fuel") then
					editVALUE = TDtext:gsub("%d+", math.ceil(speedcar * 2), 1)

					sampTextdrawSetString(idtextdraw, editVALUE)
				end
			end
		end

		if uv17 then
			if isKeyJustPressed(2) then
				uv12.main_window_state[0] = true

				showCursor(false, false)

				uv17 = false

				TriggerNotification("Перемещение отменено.")
			elseif isKeyJustPressed(1) then
				uv18.cfgGen.ttdposx, uv18.cfgGen.ttdposy = getCursorPos()
				TtdPosXBufferValue = uv18.cfgGen.ttdposx
				TtdPosYBufferValue = uv18.cfgGen.ttdposy
				uv18.cfgGen.ttdposx = TtdPosXBufferValue
				uv18.cfgGen.ttdposy = TtdPosYBufferValue
				uv12.main_window_state[0] = true

				showCursor(false, false)

				uv17 = false

				TriggerNotification("Новые координаты установлены.")
				uv19.save(uv18, uv20)
			end
		end

		if uv21 then
			if isKeyJustPressed(2) then
				showCursor(false, false)

				uv21 = false

				TriggerNotification("Перемещение отменено.")
			elseif isKeyJustPressed(1) then
				uv18.cfgGen.dmginf1x, uv18.cfgGen.dmginf1y = getCursorPos()
				DMGinf1XValue = uv18.cfgGen.dmginf1x
				DMGinf1YValue = uv18.cfgGen.dmginf1y

				showCursor(false, false)

				uv21 = false

				TriggerNotification("Новые координаты установлены.")
				uv19.save(uv18, uv20)
			end
		end

		if uv22 then
			if isKeyJustPressed(2) then
				showCursor(false, false)

				uv22 = false

				TriggerNotification("Перемещение отменено.")
			elseif isKeyJustPressed(1) then
				uv18.cfgGen.dmginf2x, uv18.cfgGen.dmginf2y = getCursorPos()
				DMGinf2XValue = uv18.cfgGen.dmginf2x
				DMGinf2YValue = uv18.cfgGen.dmginf2y

				showCursor(false, false)

				uv22 = false

				TriggerNotification("Новые координаты установлены.")
				uv19.save(uv23, uv24)
			end
		end

		if autottd3Value == "1" and uv25 and scriptonl then
			uv12.main_window_state[0] = not uv12.main_window_state[0]
			uv25 = false
		end

		if uv26 and editValue then
			uv12.edit[0] = not uv12.edit[0]
			uv13.Process = uv12.edit[0]
			uv26 = false
		end

		if cleanmemoryValue and tonumber(get_memory()) >= 666 then
			callFunction(5489920, 2, 2, 1, 1)
			callFunction(5490704, 1, 1, 1)
			callFunction(4247424, 0, 0)
			callFunction(4231328, 0, 0)
			callFunction(5904560, 0, 0)
			callFunction(7370608, 0, 0)
		end

		if not offmask and healNew == 0 then
			offMask = true
			offMaskTime = nil
		end

		if autorpgateon and isKeyDown(VK_H) and gateOnValue and not sampIsChatInputActive() then
			gateopenonh = true

			cmd_gate()
			wait(1000)

			autorpgateon = false
		end

		if isKeyDown(VK_SPACE) and uv27 and not sampIsChatInputActive() then
			clearCharTasksImmediately(PLAYER_PED)

			uv27 = false
		end

		if isKeyDown(VK_F1) and autobuyValue and uv28 and uv29 and uv30 then
			uv30 = false

			sampSendChat("/buy")
		end

		if isKeyDown(VK_F2) and autobuyValue and uv28 and uv29 and uv30 then
			uv30 = false
			uv28 = false
			uv29 = false
		end

		if pressrpdonor1 and isKeyDown(VK_F1) then
			sampSendChat("/me достал из кармана смартфон, после чего включил архив пациентов.")
			wait(1000)
			sampSendChat("/me ввёл в поиске ''" .. sampGetPlayerNickname(sobesid):gsub("_", " ") .. "'', после чего на экране появилась информация.")
			wait(1000)
			sampSendChat("Закатывайте рукав и протягивайте руку.")
			wait(1000)
			sampSendChat("/n /anim 16")

			pressrpdonor1 = false
			pressrpdonor2 = true

			wait(500)
			TriggerNotification("Чтобы продолжить нажмите F1(Дальше), F2(Отмена).")
		elseif pressrpdonor1 and isKeyDown(VK_F2) then
			TriggerNotification("Донорство отменено.")

			pressrpdonor1 = false
		end

		if drivetime and isKeyDown(VK_F2) then
			drivetime = false

			TriggerNotification("Драйв отменен.")
		end

		if pressrpdonor2 then
			if isKeyDown(VK_F1) then
				for slot7, slot8 in ipairs({
					"/do Убедился в наличии необходимых инструментов в медсумке.",
					"/me достал из кармана халата перчатки и надел их.",
					"/me вытащил жгут из медсумки и зафиксировал его выше локтя на руке пациента.",
					"/me взял клочок ваты и смочил её спиртом.",
					"/me обработал ваткой место для забора крови.",
					"/me достал из медсумки стерилизованный шприц и распаковал его.",
					"/me прицепил к шприцу проводник с пробиркой и ввёл иглу в руку пациента.",
					"/do Кровь переливается в пробирку.",
					"/me вынул иглу из вены и прижал к месту прокола вату.",
					"Спасибо Вам за сдачу крови, Вы спасли ещё одну жизнь!"
				}) do
					sampSendChat(slot8)
					wait(1000)
				end

				pressrpdonor2 = false
			elseif isKeyDown(VK_F2) then
				TriggerNotification("Донорство отменено.")

				pressrpdonor2 = false
			end
		end

		if pressrpinv1 and isKeyDown(VK_F1) then
			sampSendChat("Предоставьте Ваши документы, а именно: паспорт, лицензии и выписку из тира.")
			wait(1000)
			sampSendChat("/n /pass " .. myID .. " | /lic " .. myID .. " | /skill " .. myID .. "")

			pressrpinv1 = false
			pressrpinv2 = true

			wait(500)
			TriggerNotification("Чтобы продолжить нажмите F1(Дальше), F2(Отмена).")
		elseif pressrpinv1 and isKeyDown(VK_F2) then
			TriggerNotification("Собеседование отменено.")

			pressrpinv1 = false
		end

		if pressrpinv2 and isKeyDown(VK_F1) then
			sampSendChat(u8:decode(rpvopros1textValue))

			pressrpinv2 = false
			pressrpinv3 = true

			wait(500)
			TriggerNotification("Чтобы продолжить нажмите F1(Дальше), F2(Отмена).")
		elseif pressrpinv2 and isKeyDown(VK_F2) then
			TriggerNotification("Собеседование отменено.")

			pressrpinv2 = false
		end

		if pressrpinv3 and isKeyDown(VK_F1) then
			sampSendChat(u8:decode(rpvopros2textValue))

			pressrpinv3 = false
			pressrpinv4 = true

			wait(500)
			TriggerNotification("Чтобы принять нажмите F1(Принять), F2(Отказать).")
		elseif pressrpinv3 and isKeyDown(VK_F2) then
			TriggerNotification("Собеседование отменено.")

			pressrpinv3 = false
		end

		cityid = getCityPlayerIsIn(PLAYER_PED)

		if cityid == 1 then
			cityname = u8("Los Santos")
		elseif cityid == 2 then
			cityname = u8("San Fierro")
		elseif cityid == 3 then
			cityname = u8("Las Venturas")
		else
			cityname = " "
		end

		if pressrpinv4 and isKeyDown(VK_F1) then
			slot3 = sampGetPlayerNickname(sobesid):gsub("_", " ")
			uv31, uv32 = string.match(sampGetPlayerNickname(sobesid), "(%S+)_(%S+)")

			if nasosal_rang <= 8 then
				if isPlayerSoldier then
					sampSendChat("/r " .. slot3 .. " годен к воинской службе.")
				else
					sampSendChat("/r " .. slot3 .. " успешно прошёл собеседование.")
				end
			else
				sampProcessChatInput("/invite " .. sobesid)
			end

			pressrpinv4 = false
		elseif pressrpinv4 and isKeyDown(VK_F2) then
			TriggerNotification("Собеседование отменено.")

			pressrpinv4 = false
		end

		if (isCharInAnyHeli(playerPed) or isCharInModel(playerPed, 520)) and isKeyDown(VK_M) and isKeyDown(VK_N) and teplivizor == 0 and not sampIsChatInputActive() and not sampIsDialogActive() then
			setInfraredVision(true)

			teplivizor = 1

			wait(300)
		end

		if (isCharInAnyHeli(playerPed) or isCharInModel(playerPed, 520)) and isKeyDown(VK_M) and isKeyDown(VK_N) and teplivizor == 1 and not sampIsChatInputActive() and not sampIsDialogActive() then
			setInfraredVision(false)
			setNightVision(true)

			teplivizor = 2

			wait(300)
		end

		if (isCharInAnyHeli(playerPed) or isCharInModel(playerPed, 520)) and isKeyDown(VK_M) and isKeyDown(VK_N) and teplivizor == 2 and not sampIsChatInputActive() and not sampIsDialogActive() then
			setInfraredVision(false)
			setNightVision(false)

			teplivizor = 0

			wait(300)
		end

		if (isCharInAnyHeli(playerPed) or isCharInModel(playerPed, 520)) and isKeyDown(VK_F) then
			setInfraredVision(false)
			setNightVision(false)

			teplivizor = 0
		end

		if testCheat("sb") and not sampIsChatInputActive() and not sampIsDialogActive() and strobesOnValue then
			toggleStrobes()
		end

		if testCheat("scb") and not sampIsChatInputActive() and not sampIsDialogActive() and strobesOnValue then
			if uv33 == 0 then
				uv33 = 1
			else
				uv33 = 0
			end
		end

		if _env["CruiseСontrolValue"] and isCharInAnyCar(playerPed) then
			if isKeyJustPressed(187) then
				speedCC = speedCC + 2.5
			end

			if isKeyJustPressed(189) then
				if speedCC >= 2.5 then
					speedCC = speedCC - 2.5
				else
					speedCC = 0
				end
			end

			if enableCC and getCarSpeed(storeCarCharIsInNoSave(playerPed)) < speedCC then
				writeMemory(12006520, 1, 255, false)
			end

			if testCheat("cc") then
				enableCC = not enableCC

				if enableCC and speedCC == 0 then
					TriggerNotification("CruiseСontrol включён. Менять скорость на '' + ''(быстрей), '' - ''(медленней).")

					speedCC = getCarSpeed(storeCarCharIsInNoSave(playerPed))

					informtimercc()
				else
					informtimercc()
				end
			end
		end

		if autoMaskValue and maskMinutes == 0 and maskSeconds == 5 then
			sampSendChat("/mask")

			if autoreset then
				sampSendChat("/reset")
			end

			wait(1000)
		end

		if infMaskValue and maskMinutes == 1 and maskSeconds == 0 then
			TriggerNotification("Маска слетит через 1 минуту.")
			wait(1000)
		end

		if uv12.menu[0] then
			slot3, slot4, slot5 = getCharCoordinates(PLAYER_PED)

			for slot9, slot10 in pairs(uv34.players) do
				if slot10.id == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
					slot10.dist = u8("Это вы")
				elseif sampIsPlayerConnected(slot10.id) then
					slot11, slot12 = sampGetCharHandleBySampPlayerId(slot10.id)

					if slot11 then
						slot13, slot14, slot15 = getCharCoordinates(slot12)
						slot10.dist = string.format(u8("%d м."), getDistanceBetweenCoords3d(slot13, slot14, slot15, slot3, slot4, slot5))
					else
						slot10.dist = u8("Неизвестно")
					end
				else
					slot10.dist = u8("Неизвестно")
				end
			end
		end

		wait(0)

		if parachuteValue and getCharHeightAboveGround(PLAYER_PED) <= 80 and getCharHeightAboveGround(PLAYER_PED) >= 40 and isCurrentCharWeapon(PLAYER_PED, 46) then
			setGameKeyState(17, 255)
		end

		for slot6 = 1, uv35 do
			if uv36[slot6] ~= nil and uv36[slot6].act ~= nil and not string.find(uv36[slot6].act, "/", 1, true) and isKeysDown(strToIdKeys(uv36[slot6].act)) and not sampIsChatInputActive() and not sampIsDialogActive() then
				thread:run("binder" .. slot6)
			end
		end

		slot3 = getCurrentCharWeapon(PLAYER_PED)

		if isKeyDown(VK_RBUTTON) and slot3 == 34 then
			for slot7, slot8 in pairs(getAllObjects()) do
				for slot12 = 1, #uv37 do
					pX, pY, pZ = getCharCoordinates(PLAYER_PED)
					_, objX, objY, objZ = getObjectCoordinates(slot8)

					if getDistanceBetweenCoords3d(pX, pY, pZ, objX, objY, objZ) < uv38 and uv39[slot8] ~= false and tonumber(getObjectModel(slot8)) ~= uv37[slot12] then
						setObjectVisible(slot8, false)

						uv39[slot8] = false
					end
				end
			end
		else
			for slot7, slot8 in pairs(getAllObjects()) do
				for slot12 = 1, #uv37 do
					if uv39[slot8] == false then
						pX, pY, pZ = getCharCoordinates(PLAYER_PED)
						_, objX, objY, objZ = getObjectCoordinates(slot8)
						slot13 = getDistanceBetweenCoords3d(pX, pY, pZ, objX, objY, objZ)

						if uv39[slot8] == false and tonumber(getObjectModel(slot8)) ~= uv37[slot12] then
							setObjectVisible(slot8, true)

							uv39[slot8] = true
						end
					end
				end
			end
		end

		healthmaskoff = getCharHealth(PLAYER_PED)

		if healthmaskoff == 0 then
			offMask = true
		end

		rpgun()

		if time then
			setTimeOfDay(time, 0)
		end

		if autobuyValue and uv28 and uv29 and not uv30 and uv40 then
			TriggerNotification("Чтобы воспользоваться AutoBuy нажмите F1(Да), F2(Отмена).")

			uv30 = true
			uv40 = false

			wait(333)
		end

		if uv12.main_window_state[0] and _env["CruiseСontrolValue"] and enableCC and ccinform == 1 and not isCharInAnyCar(playerPed) then
			uv12.main_window_state[0] = not uv12.main_window_state[0]
			ccinform = 0
			enableCC = false
		end

		slot4, slot5 = getCharPlayerIsTargeting(PLAYR_HANDLE)

		if slot4 then
			slot4, tarId = sampGetPlayerIdByCharHandle(slot5)
		end

		if slot4 and isKeyJustPressed(VK_R) then
			MenuName = sampGetPlayerNickname(tarId)
			MenuID = tarId
			uv12.m_w_s[0] = not uv12.m_w_s[0]
			uv13.Process = uv12.m_w_s[0]
		end

		slot6, slot7 = getCharPlayerIsTargeting(PLAYR_HANDLE)

		if slot6 then
			slot6, tarId = sampGetPlayerIdByCharHandle(slot7)
		end

		if slot6 and isKeysDown(strToIdKeys(vzaimhotkeyValue)) and isPlayerSoldierMed and isKeyJustPressed(VK_RBUTTON) then
			MenuName = sampGetPlayerNickname(tarId)
			MenuID = tarId
			uv12.window_med[0] = not uv12.window_med[0]
			uv13.Process = uv12.window_med[0]
		end

		if slot6 and isKeysDown(strToIdKeys(vzaimhotkeyValue)) and isPlayerSoldierPolice and isKeyJustPressed(VK_RBUTTON) then
			MenuName = sampGetPlayerNickname(tarId)
			MenuID = tarId
			uv12.window_pol[0] = not uv12.window_pol[0]
			uv13.Process = uv12.window_med[0]
		end

		slot8, slot9 = getCharPlayerIsTargeting(PLAYR_HANDLE)

		if slot8 then
			slot8, tarId = sampGetPlayerIdByCharHandle(slot9)
		end

		if slot8 and isKeyJustPressed(VK_1) and not isPlayerSoldier and isKeyJustPressed(VK_RBUTTON) then
			slot10 = getCharModel(slot9)
			uv31, uv32 = string.match(sampGetPlayerNickname(tarId), "(%S+)_(%S+)")
			slot12 = string.gsub(sampGetPlayerNickname(tarId), "_", " ")

			if uv41 == 1 then
				sampSendChat("/anim 7")
			elseif uv41 == 2 then
				sampSendChat("/anim 11")
			elseif uv41 == 3 then
				sampSendChat("/anim 12")
			elseif uv41 == 4 then
				sampSendChat("/anim 58")
			elseif uv41 == 5 then
				sampSendChat("/anim 63")
			else
				sampSendChat("/anim 11")
			end

			wait(150)

			if newprivenValue == "" then
				sampSendChat("/todo Поприветствовав человека напротив*Здравствуйте!")
			else
				sampSendChat(string.format("%s", u8:decode(newprivenValue)))
			end
		end

		slot10, slot11 = getCharPlayerIsTargeting(PLAYR_HANDLE)

		if slot10 then
			slot10, tarId = sampGetPlayerIdByCharHandle(slot11)
		end

		if slot10 and isKeyJustPressed(VK_1) and isPlayerSoldier and isKeyJustPressed(VK_RBUTTON) then
			slot12 = getCharModel(slot11)
			uv31, uv32 = string.match(sampGetPlayerNickname(tarId), "(%S+)_(%S+)")
			slot14 = string.gsub(sampGetPlayerNickname(tarId), "_", " ")

			if uv41 == 1 then
				sampSendChat("/anim 7")
			elseif uv41 == 2 then
				sampSendChat("/anim 11")
			elseif uv41 == 3 then
				sampSendChat("/anim 12")
			elseif uv41 == 4 then
				sampSendChat("/anim 58")
			elseif uv41 == 5 then
				sampSendChat("/anim 63")
			else
				sampSendChat("/anim 58")
			end

			wait(150)

			if newprivenValue == "" then
				if slot12 == 191 then
					sampSendChat("/todo Поприветствовав женщину в форме*Здравия желаю, мэм.")
				elseif slot12 == 73 or slot12 == 179 or slot12 == 253 or slot12 == 255 or slot12 == 287 or slot12 == 61 then
					sampSendChat("/todo Поприветствовав военного*Здравия желаю, мистер " .. slot14 .. "!")
				else
					sampSendChat("/todo Поприветствовав человека напротив*Здравия желаю!")
				end
			else
				sampSendChat(string.format("%s", u8:decode(newprivenValue)))
			end
		end

		if opentchatValue and isKeyJustPressed(VK_T) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and not sampIsScoreboardOpen() then
			sampSetChatInputEnabled(true)
		end

		if droneActive then
			lockPlayerControl(true)
		elseif workpause then
			if userNick ~= "Ryder_Revenge" then
				sampSetChatInputEnabled(false)
			end

			lockPlayerControl(true)
		else
			lockPlayerControl(false)
		end

		for slot15 = 0, sampGetMaxPlayerId(true) do
			if sampIsPlayerConnected(slot15) then
				slot16, slot17 = sampGetCharHandleBySampPlayerId(slot15)

				if slot16 then
					slot18, slot19, slot20 = getCharCoordinates(slot17)
					slot21, slot22, slot23 = getCharCoordinates(PLAYER_PED)

					if getDistanceBetweenCoords3d(slot18, slot19, slot20, slot21, slot22, slot23) >= 30 and droneActive and developMode ~= 1 then
						EmulShowNameTag(slot15, false)
					elseif droneActive and developMode == 1 then
						EmulShowNameTag(slot15, true)
					else
						EmulShowNameTag(slot15, true)
					end
				end
			end
		end
	end
end

slot146 = slot2.OnFrame(function ()
	return uv0.main_window_state[0]
end, function (slot0)
	slot0.HideCursor = true
	slot4 = nil

	uv1.SetNextWindowSize(uv1.ImVec2(150, 200), uv1.Cond.FirstUseEver)
	uv1.SetNextWindowPos(uv1.ImVec2(tonumber(TtdPosXBufferValue), tonumber(TtdPosYBufferValue)), uv1.Cond.Always, uv1.ImVec2(0.5, 0.5))
	uv1.PushStyleColor(uv1.Col.WindowBg, (not VipStatus or uv1.ImVec4(tonumber(uv0:sub(1, 2), 16) / 255, tonumber(uv0:sub(3, 4), 16) / 255, tonumber(uv0:sub(5, 6), 16) / 255, 0.6)) and uv1.ImVec4(0, 0, 0, 0.6))
	uv1.PushStyleVarVec2(uv1.StyleVar.WindowPadding, uv1.ImVec2(7, 7))
	uv1.Begin(" ", uv2.main_window_state, uv1.WindowFlags.NoTitleBar + uv1.WindowFlags.NoResize + uv1.WindowFlags.AlwaysAutoResize)
	uv1.PushFont(ttdmainFont)

	if u8:decode(ttdmesinfo) == "-" or u8:decode(ttdmesinfo) == "" then
		ShowCenterText2(u8("HorAssist | HorA.su"))
	else
		ShowCenterText2(ttdmesinfo)
	end

	uv1.PushFont(uv3)

	if dateinfoValue then
		uv1.Text(u8("Время: ") .. os.date("%H:%M:%S") .. u8(" | Дата: ") .. uv4.day .. "." .. uv4.month .. "." .. uv4.year)
	else
		uv1.Text(u8("Время: ") .. os.date("%H:%M:%S"))
	end

	slot5, slot6, slot7 = getCharCoordinates(PLAYER_PED)
	slot9 = cityinfoValue and cityid >= 1 and cityid <= 3 and cityname or ""

	if (zoneinfoValue and calculateZone(slot5, slot6, slot7) or "") ~= " " and slot8 ~= "" and slot9 ~= "" then
		uv1.Text(u8("Зона: ") .. u8(slot8) .. ", " .. u8(slot9))
	elseif slot8 ~= " " and slot8 ~= "" then
		uv1.Text(u8("Зона: ") .. u8(slot8))
	elseif slot9 ~= "" then
		uv1.Text(u8("Зона: ") .. u8(slot9))
	end

	if not offMask and infMaskValue then
		maskRemainingTime = math.floor((offMaskTime - os.clock() * 1000) / 1000)
		maskSeconds = maskRemainingTime % 60
		maskMinutes = math.floor(maskRemainingTime / 60)

		uv1.Text(u8("Маска: " .. tostring(maskMinutes) .. ":" .. (maskSeconds >= 10 and "" or "0") .. "" .. tostring(maskSeconds)))
		sampTextdrawDelete(194)
		sampTextdrawDelete(2048)

		if maskSeconds <= 0 and maskMinutes <= 0 then
			offMask = true
		end
	end

	if _env["CruiseСontrolValue"] and enableCC and isCharInAnyCar(playerPed) then
		uv1.Text(u8("Круиз: ") .. math.floor(speedCC * 2) .. u8(" км/ч"))
	end

	uv1.PopFont()
	uv1.End()
	uv1.PopStyleVar()
	uv1.PopStyleColor(1)
end)
slot147 = 15
slot150 = 250 + (slot147 - 15) * 10
slot155 = #{
	{
		id = 2,
		name = u8("Desert Eagle"),
		field = slot42.deagle
	},
	{
		id = 1,
		name = u8("SD Pistol"),
		field = slot42.sd
	},
	{
		id = 8,
		name = u8("Colt 45"),
		field = slot42.colt
	},
	{
		id = 6,
		name = u8("M4Al"),
		field = slot42.m4
	},
	{
		id = 5,
		name = u8("AK-47"),
		field = slot42.ak47
	},
	{
		id = 3,
		name = u8("ShotGun"),
		field = slot42.shotgun
	},
	{
		id = 7,
		name = u8("Country Rifle"),
		field = slot42.rifle
	},
	{
		id = 4,
		name = u8("MP5"),
		field = slot42.mp5
	},
	{
		id = 9,
		name = u8("Бита"),
		field = slot42.bita
	}
} * 30 * slot147 / 15 + 10
slot156 = slot2.OnFrame(function ()
	return uv0.makegun[0]
end, function (slot0)
	uv0.SetNextWindowPos(uv0.ImVec2(350, 350), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowSize(uv0.ImVec2(uv1, uv2), uv0.Cond.FirstUseEver)

	slot5 = uv0.WindowFlags.NoTitleBar
	slot4 = uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + slot5

	uv0.Begin(u8(" Makegun"), uv3.makegun, slot4)
	uv0.PushItemWidth(90)
	uv0.PushFont(uv4)

	for slot4, slot5 in ipairs(uv5) do
		uv0.Text(slot5.name)
		uv0.SameLine(105)
		uv0.InputInt("##" .. slot5.name, slot5.field)
		uv0.SameLine()

		if uv0.Button(u8("Add ##") .. slot5.name, uv0.ImVec2(40, 20)) then
			if slot5.field[0] >= 1 then
				sampSendChat("/makegun " .. slot5.id .. " " .. slot5.field[0])
			else
				TriggerNotification("Некорректное значение.")
			end
		end
	end

	uv0.SetCursorPosY(uv0.GetCursorPosY() + 10)
	uv0.Separator()
	uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
		uv3.makegun[0] = not uv3.makegun[0]
		uv0.Process = uv3.makegun[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot157 = slot2.OnFrame(function ()
	return uv0.smartsu[0]
end, function (slot0)
	uv0.SetNextWindowPos(uv0.ImVec2(350, 250), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowSize(uv0.ImVec2(500, 258), uv0.Cond.FirstUseEver)
	uv0.Begin(u8("Выдача розыска игроку ") .. sampGetPlayerNickname(id), uv1.smartsu, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)
	uv0.PushFont(uv2)

	slot4 = id

	ShowCenterText2(u8("Выдача розыска игроку ") .. sampGetPlayerNickname(slot4))

	for slot4 = 1, #uv3 do
		if uv0.Selectable(u8(uv3[slot4].name .. " | Звезды: " .. uv3[slot4].text1)) then
			uv1.smartsu[0] = not uv1.smartsu[0]
			uv0.Process = uv1.smartsu[0]

			if rpsu[0] then
				lua_thread.create(function ()
					if newrpsuValue == "" then
						sampSendChat("/me " .. (lady[0] and "сообщила" or "сообщил") .. " диспетчеру по рации приметы подозреваемого")
					else
						sampSendChat(string.format("%s", u8:decode(newrpsuValue)))
					end

					wait(222)
				end)
			end

			newrsn = uv3[slot4].text2
			idprsn = id
			timerdlyasu = true

			sampSendChat("/su " .. id .. " " .. uv3[slot4].text1 .. " " .. uv3[slot4].text2)
		end
	end

	ShowCenterText2(u8("\n\nНастройка системы розыска - /sured"))
	uv0.SetCursorPosY(223)
	uv0.Separator()
	uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
		uv1.smartsu[0] = not uv1.smartsu[0]
		uv0.Process = uv1.smartsu[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot158 = slot2.OnFrame(function ()
	return uv0.smartsu_active[0]
end, function (slot0)
	slot1, slot2 = getScreenResolution()

	uv0.SetNextWindowSize(uv0.ImVec2(505, 355), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowPos(uv0.ImVec2(slot1 / 2, slot2 / 2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.Begin(u8(" Настройка розыска"), uv1.smartsu_active, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)
	uv0.BeginChild("", uv0.ImVec2(200, 335), true)
	uv0.PushFont(uv2)

	if #uv3 ~= 0 then
		for slot6 = 1, #uv3 do
			if uv0.Selectable(u8(uv3[slot6].name or "")) then
				uv4.copy(uv5, u8(uv3[slot6].name or ""))
				uv4.copy(uv6, u8(uv3[slot6].text1 or ""))
				uv4.copy(uv7, u8(uv3[slot6].text2 or ""))

				uv8 = slot6
			end
		end
	else
		uv0.Text(u8("Тут пока ничего нет"))
	end

	uv0.EndChild()
	uv0.SameLine()
	uv0.BeginChild(" ", uv0.ImVec2(279, 305), true)

	if uv8 ~= 0 then
		uv0.PushItemWidth(260)
		uv0.Text(u8("Название в диалоге"))
		uv0.InputText(u8("##name"), uv5, 256)
		uv0.PushItemWidth(260)
		uv0.Text(u8("Причина при выдачи розыска"))
		uv0.InputText(u8("##text2"), uv7, 65536)
		uv0.PushItemWidth(22)
		uv0.Text(u8("Количество звезд"))
		uv0.InputText(u8("##text1"), uv6, 65536)

		if uv0.Button(u8(" Сохранить"), uv0.ImVec2(260, 20)) then
			uv3[uv8].name = u8:decode(uv4.string(uv5))
			uv3[uv8].text1 = u8:decode(uv4.string(uv6))
			uv3[uv8].text2 = u8:decode(uv4.string(uv7))

			uv9.save(uv3, uv10)
			TriggerNotification("Пункт розыска \"" .. u8:decode(uv4.string(uv5)) .. "\" сохранен.")
		end

		if uv0.Button(u8(" Удалить"), uv0.ImVec2(260, 20)) then
			table.remove(uv3, uv8)
			uv9.save(uv3, uv10)
			TriggerNotification("Удалено.")

			uv8 = 0
		end
	end

	uv0.EndChild()
	uv0.SetCursorPosY(320)
	uv0.SetCursorPosX(220)

	if uv0.Button(u8("Добавить строку"), uv0.ImVec2(150, 25)) then
		slot3 = "Пункт розыска № " .. #uv3 + 1

		for slot7, slot8 in pairs(uv3) do
			if uv3[slot7].name == slot3 then
				slot3 = u8(slot3 .. " (1)")
			end
		end

		table.insert(uv3, {
			text1 = "",
			text2 = "",
			name = slot3
		})
		uv9.save(uv3, uv10)
	end

	uv0.SameLine()

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(115, 25)) then
		uv1.smartsu_active[0] = not uv1.smartsu_active[0]
		uv0.Process = uv1.smartsu_active[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot159 = slot2.OnFrame(function ()
	return uv0.smartticket[0]
end, function (slot0)
	uv0.SetNextWindowPos(uv0.ImVec2(350, 350), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowSize(uv0.ImVec2(700, 355), uv0.Cond.FirstUseEver)

	slot4 = uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar

	uv0.Begin(u8("Выдача штрафа игроку ") .. sampGetPlayerNickname(id), uv1.smartticket, slot4)
	uv0.PushFont(uv2)

	for slot4 = 1, #uv3 do
		if uv0.Selectable(u8(uv3[slot4].name .. " | Штраф: " .. uv3[slot4].text1)) then
			uv1.smartticket[0] = not uv1.smartticket[0]
			uv0.Process = uv1.smartticket[0]

			if rpticket[0] then
				lua_thread.create(function ()
					if newrpticketValue == "" then
						sampSendChat("/me достав из кармана ручку и штрафной бланк, " .. (lady[0] and "внесла" or "внёс") .. " данные о нарушении.")
					else
						sampSendChat(string.format("%s", u8:decode(newrpticketValue)))
					end

					wait(555)

					if newrpticket2Value ~= "-" then
						if newrpticket2Value == "" then
							sampSendChat("/me " .. (lady[0] and "передала" or "передал") .. " штрафной бланк на подпись.")
						else
							sampSendChat(string.format("%s", u8:decode(newrpticket2Value)))
						end
					end

					wait(222)
				end)
			end

			sampSendChat(string.format("/ticket %d %s %s", id, u8:decode(uv3[slot4].text1), u8:decode(uv3[slot4].text2)))
		end
	end

	ShowCenterText2(u8("\n\nНастройка системы штрафов - /ticketred"))
	uv0.SetCursorPosY(320)
	uv0.Separator()
	uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
		uv1.smartticket[0] = not uv1.smartticket[0]
		uv0.Process = uv1.smartticket[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot160 = slot2.OnFrame(function ()
	return uv0.smartticket_active[0]
end, function (slot0)
	uv0.PushFont(uv1)

	slot1, slot2 = getScreenResolution()

	uv0.SetNextWindowSize(uv0.ImVec2(505, 355), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowPos(uv0.ImVec2(slot1 / 2, slot2 / 2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.Begin(u8("Настройка штрафов"), uv2.smartticket_active, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)
	uv0.BeginChild("left_panel", uv0.ImVec2(200, 335), true)

	if #uv3 > 0 then
		for slot6, slot7 in ipairs(uv3) do
			if uv0.Selectable(u8(slot7.name or "")) then
				uv4.copy(uv5, slot8)
				uv4.copy(uv6, u8(slot7.text1 or ""))
				uv4.copy(uv7, u8(slot7.text2 or ""))

				uv8 = slot6
			end
		end
	else
		uv0.Text(u8("Тут пока ничего нет"))
	end

	uv0.EndChild()
	uv0.SameLine()
	uv0.BeginChild("right_panel", uv0.ImVec2(279, 305), true)

	if uv8 ~= 0 then
		uv0.PushItemWidth(260)
		uv0.Text(u8("Название в диалоге"))
		uv0.InputText("##name", uv5, 256)
		uv0.Text(u8("Причина при выдаче штрафа"))
		uv0.InputText("##text2", uv7, 65536)
		uv0.PushItemWidth(100)
		uv0.Text(u8("Сумма штрафа"))
		uv0.InputText("##text1", uv6, 65536)

		if uv0.Button(u8("Сохранить"), uv0.ImVec2(260, 20)) then
			uv3[uv8].name = u8:decode(uv4.string(uv5))
			uv3[uv8].text1 = u8:decode(uv4.string(uv6))
			uv3[uv8].text2 = u8:decode(uv4.string(uv7))

			uv9.save(uv3, uv10)
			TriggerNotification("Пункт штрафа \"" .. uv3[uv8].name .. "\" сохранен.")
		end

		if uv0.Button(u8("Удалить"), uv0.ImVec2(260, 20)) then
			table.remove(uv3, uv8)
			uv9.save(uv3, uv10)
			TriggerNotification("Удалено.")

			uv8 = 0
		end
	end

	uv0.EndChild()
	uv0.SetCursorPosY(320)
	uv0.SetCursorPosX(220)

	if uv0.Button(u8("Добавить строку"), uv0.ImVec2(150, 25)) then
		slot3 = "Пункт статьи № " .. #uv3 + 1

		for slot7, slot8 in pairs(uv3) do
			if slot8.name == slot3 then
				slot3 = "Пункт статьи № " .. #uv3 + 1 .. " (1)"
			end
		end

		table.insert(uv3, {
			text1 = "",
			text2 = "",
			name = slot3
		})
		uv9.save(uv3, uv10)
	end

	uv0.SameLine()

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(115, 25)) then
		uv2.smartticket_active[0] = not uv2.smartticket_active[0]
		uv0.Process = uv2.smartticket_active[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot161 = slot2.OnFrame(function ()
	return uv0.gos[0]
end, function (slot0)
	uv0.SetNextWindowSize(uv0.ImVec2(685, 282), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowPos(uv0.ImVec2(uv1 / 2, uv2 / 2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.Begin(u8(" Госки"), uv3.gos, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)
	uv0.BeginChild("test", uv0.ImVec2(670, 265), true)
	uv0.PushFont(uv4)
	uv0.Columns(2)
	uv0.SetColumnWidth(-1, 444)
	uv0.PushItemWidth(420)

	slot1 = {
		"one",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
		"nine",
		"10",
		"11",
		"12",
		"13",
		"14",
		"15",
		"16",
		"17"
	}

	if gogosValue ~= "" then
		slot2 = tonumber(gogosValue)

		uv0.Text(u8("Три строки"))

		for slot6 = 1, 3 do
			slot7 = "gos" .. slot6 .. slot1[slot2] .. "Value"
			slot8 = _G["gos" .. slot6 .. slot1[slot2] .. "Value"]
			slot9 = uv5.new("char[256]")

			uv5.copy(slot9, cfg.cfg["gos" .. slot6 .. slot1[slot2]], #cfg.cfg["gos" .. slot6 .. slot1[slot2]] + 1)

			if uv0.InputText(u8("##gos") .. slot6 .. slot1[slot2] .. "Value", slot9, 256) then
				cfg.cfg["gos" .. slot6 .. slot1[slot2]] = uv5.string(slot9)
				_G[slot7] = uv5.string(slot9)

				uv6.save(uv7, uv8)
			end
		end

		uv0.Text(u8("\nОдна строка"))

		slot3 = "gosodnastroka" .. slot1[slot2] .. "Value"
		slot4 = _G["gosodnastroka" .. slot1[slot2] .. "" .. "Value"]
		slot5 = uv5.new("char[256]")

		uv5.copy(slot5, cfg.cfg["gosodnastroka" .. slot1[slot2]], #cfg.cfg["gosodnastroka" .. slot1[slot2]] + 1)

		if uv0.InputText(u8("##gosodnastroka") .. slot1[slot2] .. "" .. "Value", slot5, 256) then
			cfg.cfg["gosodnastroka" .. slot1[slot2]] = uv5.string(slot5)
			_G[slot3] = uv5.string(slot5)

			uv6.save(uv7, uv8)
		end

		uv0.Text(u8("\nЗакончить собеседование"))

		slot6 = "gosstopsobes" .. slot1[slot2] .. "Value"
		slot7 = _G["gosstopsobes" .. slot1[slot2] .. "" .. "Value"]
		slot8 = uv5.new("char[256]")

		uv5.copy(slot8, cfg.cfg["gosstopsobes" .. slot1[slot2]], #cfg.cfg["gosstopsobes" .. slot1[slot2]] + 1)

		if uv0.InputText(u8("##gosstopsobes") .. slot1[slot2], slot8, 256) then
			_G[slot6] = uv5.string(slot8)
			cfg.cfg["gosstopsobes" .. slot1[slot2]] = uv5.string(slot8)

			uv6.save(uv7, uv8)
		end
	end

	uv0.NextColumn()

	for slot5 = 1, 17 do
		if slot5 > 1 and slot5 % 3 ~= 1 then
			uv0.SameLine()
		end

		slot6 = uv5.new("char[256]")

		uv5.copy(slot6, cfg.cfg["namegos" .. slot5], #cfg.cfg["namegos" .. slot5] + 1)

		if uv0.Button(uv5.string(slot6), uv0.ImVec2(65, 20)) then
			gogosValue = tostring(slot5)
			cfg.cfg.gogos = slot5

			uv6.save(uv7, uv8)
		end
	end

	uv0.Text(" ")
	uv0.SameLine(33)
	uv0.Text(u8("Тэг"))
	uv0.SameLine(135)
	uv0.Text(u8("Кнопка"))
	uv0.PushItemWidth(66)

	slot2 = uv5.new("char[256]")

	uv5.copy(slot2, cfg.cfg.gostag, #cfg.cfg.gostag + 1)

	if uv0.InputText(u8("##gostag"), slot2, 256) then
		cfg.cfg.gostag = uv5.string(slot2)
		gostagValue = uv5.string(slot2)

		uv6.save(uv7, uv8)
	end

	uv0.PushItemWidth(70)
	uv0.SameLine(125)

	if gogosValue ~= "" then
		slot3 = tonumber(gogosValue)
		slot4 = _G["namegos" .. slot3]
		slot5 = uv5.new("char[256]")

		uv5.copy(slot5, uv7.cfg["namegos" .. slot3], #uv7.cfg["namegos" .. slot3] + 1)

		if uv0.InputText(u8("##namegos") .. slot3, slot5, 256) then
			uv7.cfg["namegos" .. slot3] = uv5.string(slot5)

			uv6.save(uv7, uv8)
		end
	end

	uv0.SetCursorPosY(231)
	uv0.SetCursorPosX(473)

	if uv0.Button(u8("Отправить ##gnews"), uv0.ImVec2(80, 25)) then
		uv0.OpenPopup(u8("Отправить. ##gnews"))
	end

	slot3 = {
		["1"] = {
			str1 = gos1oneValue,
			str2 = gos2oneValue,
			str3 = gos3oneValue,
			odna_stroka = gosodnastrokaoneValue,
			stopsobes = gosstopsobesoneValue
		},
		["2"] = {
			str1 = gos1twoValue,
			str2 = gos2twoValue,
			str3 = gos3twoValue,
			odna_stroka = gosodnastrokatwoValue,
			stopsobes = gosstopsobestwoValue
		},
		["3"] = {
			str1 = gos1threeValue,
			str2 = gos2threeValue,
			str3 = gos3threeValue,
			odna_stroka = gosodnastrokathreeValue,
			stopsobes = gosstopsobesthreeValue
		},
		["4"] = {
			str1 = gos1fourValue,
			str2 = gos2fourValue,
			str3 = gos3fourValue,
			odna_stroka = gosodnastrokafourValue,
			stopsobes = gosstopsobesfourValue
		},
		["5"] = {
			str1 = gos1fiveValue,
			str2 = gos2fiveValue,
			str3 = gos3fiveValue,
			odna_stroka = gosodnastrokafiveValue,
			stopsobes = gosstopsobesfiveValue
		},
		["6"] = {
			str1 = gos1sixValue,
			str2 = gos2sixValue,
			str3 = gos3sixValue,
			odna_stroka = gosodnastrokasixValue,
			stopsobes = gosstopsobessixValue
		},
		["7"] = {
			str1 = gos1sevenValue,
			str2 = gos2sevenValue,
			str3 = gos3sevenValue,
			odna_stroka = gosodnastrokasevenValue,
			stopsobes = gosstopsobessevenValue
		},
		["8"] = {
			str1 = gos1eightValue,
			str2 = gos2eightValue,
			str3 = gos3eightValue,
			odna_stroka = gosodnastrokaeightValue,
			stopsobes = gosstopsobeseightValue
		},
		["9"] = {
			str1 = gos1nineValue,
			str2 = gos2nineValue,
			str3 = gos3nineValue,
			odna_stroka = gosodnastrokanineValue,
			stopsobes = gosstopsobesnineValue
		},
		["10"] = {
			str1 = gos110Value,
			str2 = gos210Value,
			str3 = gos310Value,
			odna_stroka = gosodnastroka10Value,
			stopsobes = gosstopsobes10Value
		},
		["11"] = {
			str1 = gos111Value,
			str2 = gos211Value,
			str3 = gos311Value,
			odna_stroka = gosodnastroka11Value,
			stopsobes = gosstopsobes11Value
		},
		["12"] = {
			str1 = gos112Value,
			str2 = gos212Value,
			str3 = gos312Value,
			odna_stroka = gosodnastroka12Value,
			stopsobes = gosstopsobes12Value
		},
		["13"] = {
			str1 = gos113Value,
			str2 = gos213Value,
			str3 = gos313Value,
			odna_stroka = gosodnastroka13Value,
			stopsobes = gosstopsobes13Value
		},
		["14"] = {
			str1 = gos114Value,
			str2 = gos214Value,
			str3 = gos314Value,
			odna_stroka = gosodnastroka14Value,
			stopsobes = gosstopsobes14Value
		},
		["15"] = {
			str1 = gos115Value,
			str2 = gos215Value,
			str3 = gos315Value,
			odna_stroka = gosodnastroka15Value,
			stopsobes = gosstopsobes15Value
		},
		["16"] = {
			str1 = gos116Value,
			str2 = gos216Value,
			str3 = gos316Value,
			odna_stroka = gosodnastroka16Value,
			stopsobes = gosstopsobes16Value
		},
		["17"] = {
			str1 = gos117Value,
			str2 = gos217Value,
			str3 = gos317Value,
			odna_stroka = gosodnastroka17Value,
			stopsobes = gosstopsobes17Value
		}
	}

	slot4 = function(slot0, slot1, slot2, slot3)
		lua_thread.create(function ()
			if uv0 then
				sampSendChat(string.format("/gnews %s %s", uv1, uv0))
			end

			if uv2 then
				wait(777)
				sampSendChat(string.format("/gnews %s %s", uv1, uv2))
			end

			if uv3 then
				wait(777)
				sampSendChat(string.format("/gnews %s %s", uv1, uv3))
			end
		end)
	end

	if uv0.BeginPopupModal(u8("Отправить. ##gnews"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
		ShowCenterText2(u8("Выберите кнопку для отправки государственной волны"))

		slot5 = u8:decode(gostagValue)

		if slot3[gogosValue] then
			if uv0.Button(u8("Одна строка")) then
				uv3.gos[0] = not uv3.gos[0]
				uv0.Process = uv3.gos[0]

				slot4(slot5, u8:decode(slot7.odna_stroka), nil, )
			end

			uv0.SameLine()

			if uv0.Button(u8("Три строки")) then
				uv3.gos[0] = not uv3.gos[0]
				uv0.Process = uv3.gos[0]

				slot4(slot5, u8:decode(slot7.str1), u8:decode(slot7.str2), u8:decode(slot7.str3))
			end

			uv0.SameLine()

			if uv0.Button(u8("Закончить собеседование")) then
				uv3.gos[0] = not uv3.gos[0]
				uv0.Process = uv3.gos[0]

				slot4(slot5, u8:decode(slot7.stopsobes), nil, )
			end
		end

		uv0.Separator()
		uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

		if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
			uv0.CloseCurrentPopup()
		end

		uv0.EndPopup()
	end

	uv0.SameLine()

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(80, 25)) then
		uv3.gos[0] = not uv3.gos[0]
		uv0.Process = uv3.gos[0]
	end

	uv0.PopFont()
	uv0.EndChild()
	uv0.End()
end)
slot162 = slot6.new("const char*[?]", #slot49)

for slot166 = 1, #slot49 do
	slot162[slot166 - 1] = slot49[slot166]
end

slot163 = slot2.OnFrame(function ()
	return uv0.zametki[0]
end, function (slot0)
	uv0.SetNextWindowSize(uv0.ImVec2(750, 330), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowPos(uv0.ImVec2(uv1 / 2, uv2 / 2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.Begin(u8(" Заметки"), uv3.zametki, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)
	uv0.PushFont(uv4)

	slot4 = true

	uv0.BeginChild("", uv0.ImVec2(150, 285), slot4)

	for slot4 = 1, 35 do
		slot5 = tostring(uv5[slot4].name or "")
		slot6 = u8:decode(slot5)

		if uv0.Selectable(u8(slot5)) then
			uv6.fill(uv7, 256)
			uv6.copy(uv7, slot7, math.min(#slot7 + 1, 256))

			uv8[0] = uv5[slot4].table

			slot8 = function(slot0, slot1)
				slot3 = u8((tostring(slot1) or ""):gsub("&", "\n")):gsub("%s+", " ")

				uv0.copy(slot0, slot3, math.min(#slot3 + 1, 1024))
			end

			slot8(uv9, uv5[slot4].text1)
			slot8(uv10, uv5[slot4].text2)
			slot8(uv11, uv5[slot4].text3)

			uv12 = slot4
		end
	end

	uv0.EndChild()

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(148, 25)) then
		uv3.zametki[0] = not uv3.zametki[0]
		uv0.Process = uv3.zametki[0]
	end

	uv0.SetCursorPosX(165)
	uv0.SetCursorPosY(10)
	uv0.BeginChild(" ", uv0.ImVec2(579, 312), true)

	if uv12 ~= 0 then
		uv0.Text(u8("Название:"))
		uv0.SameLine()
		uv0.PushItemWidth(150)
		uv0.InputText(u8("Столбцы:"), uv7, 256)
		uv0.SameLine()
		uv0.PushItemWidth(40)
		uv0.Combo("  ", uv8, uv13, #uv14)
		uv0.PopItemWidth()
		uv0.SameLine(355)

		if uv0.Button(u8(" Сохранить"), uv0.ImVec2(125, 20)) then
			uv5[uv12].name = u8:decode(uv6.string(uv7))
			uv5[uv12].table = uv8[0]
			uv5[uv12].text1 = string.gsub(u8:decode(uv6.string(uv9)), "\n", "&")
			uv5[uv12].text2 = string.gsub(u8:decode(uv6.string(uv10)), "\n", "&")
			uv5[uv12].text3 = string.gsub(u8:decode(uv6.string(uv11)), "\n", "&")

			uv15.save(uv5, uv16)
			TriggerNotification("Заметка \"" .. u8:decode(uv6.string(uv7)) .. "\" сохранена.")
		end

		if uv8[0] == 0 then
			uv0.InputTextMultiline("    ", uv9, 1024, uv0.ImVec2(562, 267))
		elseif uv8[0] == 1 then
			uv0.InputTextMultiline("    ", uv9, 1024, uv0.ImVec2(279, 267))
			uv0.SameLine()
			uv0.InputTextMultiline("     ", uv10, 1024, uv0.ImVec2(279, 267))
		elseif uv8[0] == 2 then
			uv0.InputTextMultiline("    ", uv9, 1024, uv0.ImVec2(184, 267))
			uv0.SameLine()
			uv0.InputTextMultiline("     ", uv10, 1024, uv0.ImVec2(184, 267))
			uv0.SameLine()
			uv0.InputTextMultiline("      ", uv11, 1024, uv0.ImVec2(184, 267))
		end
	end

	uv0.PopFont()
	uv0.EndChild()
	uv0.End()
end)
slot164 = slot2.OnFrame(function ()
	return uv0.edit[0]
end, function (slot0)
	uv0.PushFont(uv1)
	uv0.SetNextWindowSize(uv0.ImVec2(545, 245), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 2, uv3 / 2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.Begin(u8("edit."), uv4.edit, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)

	slot1 = u8(cfg.cfg.edittag) .. " " .. u8(uv5)

	ShowCenterText2(u8("Публикация объявления"))
	uv0.Separator()
	uv0.Text(u8("Отправитель: ") .. uv6)
	uv0.SameLine(420)
	uv0.PushItemWidth(76)

	slot2 = uv7.new("char[256]")

	uv7.copy(slot2, u8(cfg.cfg.edittag), #u8(cfg.cfg.edittag) + 1)

	if uv0.InputText(u8("» Тэг"), slot2, 256) then
		cfg.cfg.edittag = u8:decode(uv7.string(slot2))

		uv8.save(uv9, uv10)
	end

	uv0.Text(u8("Текст: ") .. u8(uv11))
	uv0.Separator()
	ShowCenterText2(u8("Текст на публикацию"))
	ShowCenterText2(slot1)
	uv0.Separator()
	uv0.PushItemWidth(530)

	if uv0.InputText("##edittext", uv0.new.char[256](u8(uv5 or "")), 256) then
		uv5 = u8:decode(uv7.string(slot4))
	end

	for slot8, slot9 in ipairs(uv12) do
		if uv0.Button(u8(slot9), uv0.ImVec2(126, 22)) then
			uv0.OpenPopup(u8(slot9))
		end

		(function (slot0)
			slot2 = uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar

			if 500 < #uv1[slot0] * 25 then
				slot2 = uv0.WindowFlags.NoTitleBar

				uv0.SetNextWindowSize(uv0.ImVec2(0, slot1))
			end

			if uv0.BeginPopupModal(u8(slot0), nil, slot2) then
				ShowCenterText2(u8("Выбор объявления"))

				for slot6, slot7 in ipairs(uv1[slot0]) do
					if uv0.Button(u8(slot7)) then
						uv2 = slot7
					end
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end
		end)(slot9)

		if slot8 % 4 ~= 0 then
			uv0.SameLine()
		end
	end

	uv0.Separator()

	slot5 = 22

	uv0.SetCursorPosY(uv0.GetWindowHeight() - slot5 - 10)
	uv0.SetCursorPosX(100)

	if uv0.Button(u8("Пропустить"), uv0.ImVec2(111, slot5)) then
		sampSendChat("/adskip")

		uv4.edit[0] = not uv4.edit[0]
		uv0.Process = uv4.edit[0]
	end

	uv0.SameLine()

	if uv0.Button(u8("Отправить"), uv0.ImVec2(111, slot5)) then
		sampSendDialogResponse(224, 1, 65535, u8:decode(slot1))

		uv4.edit[0] = not uv4.edit[0]
		uv0.Process = uv4.edit[0]
	end

	uv0.SameLine()

	if uv0.Button(u8("Отклонить"), uv0.ImVec2(111, slot5)) then
		sampSendDialogResponse(224, 0, 65535, u8:decode(slot1))

		uv4.edit[0] = not uv4.edit[0]
		uv0.Process = uv4.edit[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot165 = slot2.OnFrame(function ()
	return uv0.vipinfo[0]
end, function (slot0)
	uv0.PushFont(uv1)
	uv0.SetNextWindowSize(uv0.ImVec2(430, 207), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 2, uv3 / 2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.Begin(u8("Преимущества VIP статуса."), uv4.vipinfo, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)
	uv0.BeginChild("test", uv0.ImVec2(415, 165), true)
	uv0.Text(u8("Лидерам организаций выдаётся VIP на срок их лидерства."))
	uv0.Separator()
	uv0.Text(u8([[
1. Цвет ника в рации видят все пользователи HA-а;
2. Возможность менять приветсвтие при входе в игру;
3. Подцветка в /find;
4. Возможность изменить цвет /ttd;
5. Отправка уведомлений игроку при его упоминании;
6. Просмотр статистики игроков - /nstats;
7. Узнать телефонный номер - /number.]]))
	uv0.EndChild()
	uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2.1)

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(140, 22)) then
		uv4.vipinfo[0] = not uv4.vipinfo[0]
		uv0.Process = uv4.vipinfo[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot166 = slot2.OnFrame(function ()
	return uv0.tegi[0]
end, function (slot0)
	uv0.PushFont(uv1)
	uv0.SetNextWindowSize(uv0.ImVec2(350, 180), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 2, uv3 / 2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.Begin(u8("Теги"), uv4.tegi, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)
	uv0.BeginChild("test", uv0.ImVec2(335, 137), true)
	uv0.Text(u8([[
{myid} - ваш ID
{time} - время в формате ''дата-время''
{name} - имя
{surname} - фамилия
{city} - город
{zone} - название района
{inname} {insurname} - ник другого игрока]]))
	uv0.EndChild()
	uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2.1)

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(140, 22)) then
		uv4.tegi[0] = not uv4.tegi[0]
		uv0.Process = uv4.tegi[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot167 = slot2.OnFrame(function ()
	return uv0.menu[0]
end, function (slot0)
	uv0.PushFont(uv1)

	slot1, slot2 = getScreenResolution()
	slot3 = 650
	slot4 = 333
	slot6 = uv0.GetFontSize() + 8

	if slot6 * 2 + slot6 * math.min(uv2.online, 20) + 40 > slot2 - 100 then
		slot11 = slot2 - 100
	end

	uv0.SetNextWindowPos(uv0.ImVec2(slot1 / 2 - slot3 / 2, slot2 / 2 - slot11 / 2), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowSize(uv0.ImVec2(slot3, slot11), uv0.Cond.FirstUseEver)
	uv0.Begin(u8(string.format("Сотрудников в сети: %d | (AFK: %d) - (Jail: %d) - (Mute: %d)", uv2.online, uv2.afk, uv2.jail, uv2.mute)), uv3.menu, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)
	uv0.BeginChild("##info", uv0.ImVec2(slot3 - 15, slot11 - slot10), false)

	slot15 = "Сотрудников в сети: %d | (AFK: %d) - (Jail: %d) - (Mute: %d)"
	slot16 = uv2.online

	ShowCenterText2(u8(string.format(slot15, slot16, uv2.afk, uv2.jail, uv2.mute)))
	uv0.Separator()
	uv0.Columns(5)
	uv0.SetColumnWidth(-1, 170)
	uv0.CenterColumnText(u8("Игровой ник[ID]"))
	uv0.NextColumn()
	uv0.SetColumnWidth(-1, 165)
	uv0.CenterColumnText(u8("Название ранга"))
	uv0.NextColumn()
	uv0.SetColumnWidth(-1, 77)
	uv0.CenterColumnText(u8("Номер"))
	uv0.NextColumn()
	uv0.SetColumnWidth(-1, 88)
	uv0.CenterColumnText(u8("Расстояние"))
	uv0.NextColumn()
	uv0.CenterColumnText(u8("Дополнительно"))
	uv0.NextColumn()
	uv0.Separator()

	for slot15, slot16 in ipairs(uv2.players) do
		slot17 = false
		slot18 = false

		if uv4 ~= nil and #uv4.users > 0 and uv4.users[1] ~= "" then
			for slot22, slot23 in ipairs(uv4.users) do
				if string.find(slot16.name, slot23) then
					slot17 = true

					break
				end
			end
		end

		for slot22, slot23 in ipairs(nickVIP) do
			if slot23[1] ~= nil and string.find(slot16.name, slot23[1]) then
				slot18 = true

				break
			end
		end

		if slot18 and (not slot17 or uv4 == nil) or slot18 and slot17 and uv4 ~= nil then
			uv0.PushStyleColor(uv0.Col.Text, uv0.ImVec4(1, 1, 0.6824, 1))
			uv0.Text(u8(string.format("%s[%d]", slot16.name, slot16.id)))
			uv0.PopStyleColor()
			uv0.NextColumn()
		elseif slot17 and uv4 ~= nil and not slot18 then
			uv0.PushStyleColor(uv0.Col.Text, uv0.ImVec4(0.7725, 0.9882, 0.9804, 1))
			uv0.Text(u8(string.format("%s[%d]", slot16.name, slot16.id)))
			uv0.PopStyleColor()
			uv0.NextColumn()
		else
			uv0.Text(u8(string.format("%s[%d]", slot16.name, slot16.id)))
			uv0.NextColumn()
		end

		uv0.Text(u8(string.format("%s(%d)", slot16.rang.name, slot16.rang.level)))
		uv0.NextColumn()
		uv0.CenterColumnText(u8(slot16.phone))
		uv0.NextColumn()

		if slot16.dist == u8("Неизвестно") then
			uv0.TextColored(uv0.ImVec4(1, 0.01, 0.24, 1), slot16.dist)
			uv0.NextColumn()
		else
			uv0.TextColored(uv0.ImVec4(0.12, 0.7, 0.38, 1), slot16.dist)
			uv0.NextColumn()
		end

		uv0.Text(u8(slot16.additional))
		uv0.NextColumn()
		uv0.Separator()
	end

	uv0.Columns(1)
	uv0.EndChild()

	if uv0.Button(u8("Закрыть список сотрудников"), uv0.ImVec2(-1, 20)) then
		uv3.menu[0] = false
	end

	uv0.PopFont()
	uv0.End()
end)
slot168 = slot2.OnFrame(function ()
	return uv0.m_w_s[0]
end, function (slot0)
	uv0.PushFont(uv1)

	slot1 = 145

	if nasosal_rang >= 1 and nasosal_rang <= 3 then
		slot1 = 155
	elseif nasosal_rang >= 4 and nasosal_rang <= 7 then
		slot1 = 170
	elseif nasosal_rang == 8 then
		slot1 = 195
	elseif nasosal_rang >= 9 then
		slot1 = 240
	end

	if isPlayerSoldier or isPlayerSoldierMed then
		slot1 = slot1 + 25
	end

	slot2 = uv0.ImVec2(-0.1, 0)
	slot4 = sampGetPlayerColor(MenuID)

	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 1.063, uv3 / 1.9), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.SetNextWindowSize(uv0.ImVec2(230, slot1), uv0.Cond.FirstUseEver)
	uv0.Begin(u8("Действие с ") .. sampGetPlayerNickname(MenuID):gsub("_", " ") .. "[" .. MenuID .. "]", uv4.m_w_s, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoTitleBar)

	if nasosal_rang >= 9 and uv0.CollapsingHeader(u8(" Действия с рангами")) then
		if uv0.Button(u8(" Повысить игрока"), slot2) then
			sampProcessChatInput("/rang " .. MenuID .. " 1 +")
		end

		if uv0.Button(u8(" Понизить игрока"), slot2) then
			lua_thread.create(function ()
				sampProcessChatInput("/rang " .. MenuID .. " 1 -")
			end)
		end

		uv0.Separator()
	end

	if nasosal_rang >= 4 and uv0.Button(u8(" Собеседование"), slot2) then
		uv4.winsobes[0] = not uv4.winsobes[0]
		uv0.Process = uv4.winsobes[0]
	end

	if nasosal_rang >= 9 and uv0.Button(u8(" Принять игрока"), slot2) then
		sampProcessChatInput("/invite " .. MenuID)

		uv4.m_w_s[0] = not uv4.m_w_s[0]
	end

	if nasosal_rang >= 8 then
		if uv0.Button(u8(" Сменить скин"), slot2) then
			sampProcessChatInput("/changeskin " .. MenuID)

			uv4.m_w_s[0] = not uv4.m_w_s[0]
			uv0.Process = uv4.m_w_s[0]
		end

		uv0.Separator()
	end

	if uv0.Button(u8(" Показать паспорт"), slot2) then
		uv4.m_w_s[0] = not uv4.m_w_s[0]
		uv0.Process = uv4.m_w_s[0]

		lua_thread.create(function ()
			if newgivepass1Value == "" then
				sampSendChat("/do В кармане лежит паспорт.")
			else
				sampSendChat(string.format("%s", u8:decode(newgivepass1Value)))
			end

			wait(777)

			if newgivepass2Value == "-" then
				-- Nothing
			elseif newgivepass2Value == "" then
				sampSendChat("/me " .. (ladyValue and "сунула" or "сунул") .. " руку в карман и " .. (ladyValue and "достала" or "достал") .. " паспорт.")
			else
				sampSendChat(string.format("%s", u8:decode(newgivepass2Value)))
			end

			wait(777)

			if newgivepass3Value == "-" then
				-- Nothing
			elseif newgivepass3Value == "" then
				sampSendChat("/todo Передавая паспорт*Вот, держите")
			else
				sampSendChat(string.format("%s", u8:decode(newgivepass3Value)))
			end

			wait(222)
			sampSendChat("/pass " .. MenuID)
		end)
	end

	if uv0.Button(u8(" Показать лицензии"), slot2) then
		uv4.m_w_s[0] = not uv4.m_w_s[0]
		uv0.Process = uv4.m_w_s[0]

		lua_thread.create(function ()
			if newgivelic1Value == "" then
				sampSendChat("/do В руках находится пакет с лицензиями.")
			else
				sampSendChat(string.format("%s", u8:decode(newgivelic1Value)))
			end

			wait(777)

			if newgivelic2Value == "-" then
				-- Nothing
			elseif newgivelic2Value == "" then
				sampSendChat("/me " .. (ladyValue and "открыла" or "открыл") .. " пакет и " .. (ladyValue and "достала" or "достал") .. " от туда нужные лицензии.")
			else
				sampSendChat(string.format("%s", u8:decode(newgivelic2Value)))
			end

			wait(777)

			if newgivelic3Value == "-" then
				-- Nothing
			elseif newgivelic3Value == "" then
				sampSendChat("/todo Передавая лицензии*Вот, держите")
			else
				sampSendChat(string.format("%s", u8:decode(newgivelic3Value)))
			end

			wait(222)
			sampSendChat("/lic " .. MenuID)
		end)
	end

	if uv0.Button(u8(" Показать мед.карту"), slot2) then
		uv4.m_w_s[0] = not uv4.m_w_s[0]
		uv0.Process = uv4.m_w_s[0]

		lua_thread.create(function ()
			if newgivemed1Value == "" then
				sampSendChat("/do В кармане лежит мед. карта.")
			else
				sampSendChat(string.format("%s", u8:decode(newgivemed1Value)))
			end

			wait(777)

			if newgivemed2Value == "-" then
				-- Nothing
			elseif newgivemed2Value == "" then
				sampSendChat("/me " .. (ladyValue and "сунула" or "сунул") .. " руку в карман и " .. (ladyValue and "достала" or "достал") .. " мед. карту.")
			else
				sampSendChat(string.format("%s", u8:decode(newgivemed2Value)))
			end

			wait(777)

			if newgivemed3Value == "-" then
				-- Nothing
			elseif newgivemed3Value == "" then
				sampSendChat("/todo Передавая мед.карту*Вот, держитее")
			else
				sampSendChat(string.format("%s", u8:decode(newgivemed3Value)))
			end

			wait(222)
			sampSendChat("/med " .. MenuID)
		end)
	end

	if uv0.Button(u8(" Показать скиллы"), slot2) then
		uv4.m_w_s[0] = not uv4.m_w_s[0]
		uv0.Process = uv4.m_w_s[0]

		lua_thread.create(function ()
			if newgiveskill1Value == "" then
				sampSendChat("/do В руках находится справка с выпиской из тира.")
			else
				sampSendChat(string.format("%s", u8:decode(newgiveskill1Value)))
			end

			wait(777)

			if newgiveskill2Value == "-" then
				-- Nothing
			elseif newgiveskill2Value == "" then
				sampSendChat("/todo Передавая выписку из тира*Вот, держите")
			else
				sampSendChat(string.format("%s", u8:decode(newgiveskill2Value)))
			end

			wait(222)
			sampSendChat("/skill " .. MenuID)
		end)
	end

	if nasosal_rang >= 1 and uv0.Button(u8(" Показать автоотчет"), slot2) then
		uv4.m_w_s[0] = not uv4.m_w_s[0]
		uv0.Process = uv4.m_w_s[0]

		sampSendChat("/team " .. MenuID)
	end

	uv0.Separator()

	if uv0.Button(u8(" Закрыть окно"), slot2) then
		uv4.m_w_s[0] = not uv4.m_w_s[0]
		uv0.Process = uv4.m_w_s[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot169 = slot2.OnFrame(function ()
	return uv0.winsobes[0]
end, function (slot0)
	uv0.PushFont(uv1)

	slot1 = uv0.ImVec2(-0.1, 0)
	slot3 = sampGetPlayerColor(MenuID)

	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 1.063, uv3 / 1.3), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.SetNextWindowSize(uv0.ImVec2(230, 210), uv0.Cond.FirstUseEver)
	uv0.Begin(u8("Собеседование для ") .. sampGetPlayerNickname(MenuID):gsub("_", " ") .. "[" .. MenuID .. "]", uv4.winsobes, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoTitleBar)

	if nasosal_rang >= 4 and uv0.Button(u8(" АвтоСобес"), slot1) then
		sampProcessChatInput("/sobes " .. MenuID)

		uv4.winsobes[0] = not uv4.winsobes[0]
		uv0.Process = uv4.winsobes[0]
	end

	if isPlayerSoldier then
		if uv0.Button(u8("Прошел проверку"), slot1) then
			sampSendChat("/r " .. slot2 .. " годен к воинской службе.")
		end
	elseif uv0.Button(u8("Прошел проверку"), slot1) then
		sampSendChat("/r " .. slot2 .. " успешно прошёл собеседование.")
	end

	uv0.Separator()

	if uv0.Button(u8(" Попросить представиться"), slot1) then
		sampSendChat("Скажите пожалуйста, как Вас зовут? Сколько Вам лет? Где проживаете?")
	end

	if uv0.Button(u8(" Попросить Документы"), slot1) then
		lua_thread.create(function ()
			if isPlayerSoldier then
				sampSendChat("Предоставьте Ваши документы, а именно: паспорт, лицензии и выписку из тира.")
				wait(1000)
				sampSendChat("/n /pass " .. myID .. " | /lic " .. myID .. " | /skill " .. myID .. "")
			else
				sampSendChat("Предоставьте Ваши документы, а именно: паспорт и лицензии.")
				wait(1000)
				sampSendChat("/n /pass " .. myID .. " | /lic " .. myID .. "")
			end
		end)
	end

	if uv0.Button(rpvopros1Value, slot1) then
		sampSendChat(u8:decode(rpvopros1textValue))
	end

	if uv0.Button(rpvopros2Value, slot1) then
		sampSendChat(u8:decode(rpvopros2textValue))
	end

	if uv0.CollapsingHeader(u8(" Причины отказа")) then
		if uv0.Button(rpotkaz1Value, slot1) then
			lua_thread.create(function ()
				sampSendChat(u8:decode(rpotkaz1textValue))
				wait(1000)
				sampSendChat(u8:decode(rpotkaz12textValue))
			end)
		end

		if uv0.Button(rpotkaz2Value, slot1) then
			lua_thread.create(function ()
				sampSendChat(u8:decode(rpotkaz2textValue))
				wait(1000)
				sampSendChat(u8:decode(rpotkaz22textValue))
			end)
		end

		if uv0.Button(u8("МГ"), slot1) then
			lua_thread.create(function ()
				sampSendChat("К сожалению, Вы нам не подходите. Вы бредите.")
				wait(1000)
				sampSendChat("/n Ты МГшишь..")
			end)
		end

		if uv0.Button(u8("NonRP Ник"), slot1) then
			lua_thread.create(function ()
				sampSendChat("К сожалению, Вы нам не подходите. У Вас проблемы с паспортом.")
				wait(1000)
				sampSendChat("/n У Вас NonRP ник. Поменять его можно в: /mn - Поменять имя")
			end)
		end
	end

	uv0.Separator()

	if uv0.Button(u8(" Закрыть окно"), slot1) then
		uv4.winsobes[0] = not uv4.winsobes[0]
		uv0.Process = uv4.winsobes[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot170 = slot2.OnFrame(function ()
	return uv0.window_pol[0]
end, function (slot0)
	uv0.PushFont(uv1)

	slot1 = 190

	if nasosal_rang == 1 then
		slot1 = 190
	elseif nasosal_rang == 2 then
		slot1 = 215
	elseif nasosal_rang >= 3 and nasosal_rang <= 4 then
		slot1 = 265
	elseif nasosal_rang >= 5 then
		slot1 = 280
	end

	slot4 = sampGetPlayerColor(MenuID)

	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 1.08, uv3 / 1.35), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.SetNextWindowSize(uv0.ImVec2(240, slot1), uv0.Cond.FirstUseEver)
	uv0.Begin(u8("Взаимодействие ") .. sampGetPlayerNickname(MenuID):gsub("_", " ") .. "[" .. MenuID .. "]", uv4.window_pol, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoTitleBar)

	if uv0.Button(u8(" Представиться"), uv0.ImVec2(-0.1, 0)) then
		sampSendChat("Здравствуйте, я сотрудник " .. nickName .. ".")
	end

	if nasosal_rang >= 2 then
		uv0.Separator()

		if uv0.Button(u8(" Выдать розыск"), slot2) then
			sampProcessChatInput("/su " .. MenuID)
		end

		if nasosal_rang >= 3 and uv0.Button(u8(" Выписать штраф"), slot2) then
			sampProcessChatInput("/ticket " .. MenuID)
		end
	end

	uv0.Separator()

	if nasosal_rang >= 3 and uv0.Button(u8(" Выдать пропуск"), slot2) then
		sampProcessChatInput("/skip " .. MenuID)

		uv4.window_pol[0] = not uv4.window_pol[0]
		uv0.Process = uv4.window_pol[0]
	end

	if uv0.Button(u8(" Надеть наручники"), slot2) then
		sampProcessChatInput("/cuff " .. MenuID)

		uv4.window_pol[0] = not uv4.window_pol[0]
		uv0.Process = uv4.window_pol[0]
	end

	if uv0.Button(u8(" Снять наручники"), slot2) then
		sampProcessChatInput("/uncuff " .. MenuID)

		uv4.window_pol[0] = not uv4.window_pol[0]
		uv0.Process = uv4.window_pol[0]
	end

	if uv0.Button(u8(" Обыскать игрока"), slot2) then
		sampProcessChatInput("/search " .. MenuID)

		uv4.window_pol[0] = not uv4.window_pol[0]
		uv0.Process = uv4.window_pol[0]
	end

	if uv0.Button(u8(" Сопровождать игрока"), slot2) then
		sampProcessChatInput("/hold " .. MenuID)

		uv4.window_pol[0] = not uv4.window_pol[0]
		uv0.Process = uv4.window_pol[0]
	end

	if uv0.Button(u8(" Посадить в машину"), slot2) then
		sampProcessChatInput("/putpl " .. MenuID)

		uv4.window_pol[0] = not uv4.window_pol[0]
		uv0.Process = uv4.window_pol[0]
	end

	uv0.Separator()

	if uv0.Button(u8(" Закрыть"), slot2) then
		uv4.window_pol[0] = not uv4.window_pol[0]
		uv0.Process = uv4.window_pol[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot171 = slot2.OnFrame(function ()
	return uv0.window_med[0]
end, function (slot0)
	uv0.PushFont(uv1)

	scenazaheal = ({
		[4294927974.0] = priceMEDValue,
		[4288243251.0] = priceMOValue,
		[4284901119.0] = priceBANDValue,
		[4291559679.0] = priceBANDValue,
		[4278242559.0] = priceBANDValue,
		[4278229248.0] = priceBANDValue,
		[4294954240.0] = priceBANDValue,
		[4288230246.0] = priceLCNValue,
		[4290445312.0] = priceYAKValue,
		[4278220149.0] = priceRMValue,
		[4278190335.0] = priceMVDValue,
		[4291624704.0] = pricePRAVOValue,
		[4294927872.0] = priceSMIValue
	})[sampGetPlayerColor(MenuID)] or priceOTHERValue

	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 1.08, uv3 / 1.35), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.SetNextWindowSize(uv0.ImVec2(280, 333), uv0.Cond.FirstUseEver)
	uv0.Begin(u8("Лечим ") .. sampGetPlayerNickname(MenuID):gsub("_", " ") .. "[" .. MenuID .. "]", uv4.window_med, uv0.WindowFlags.NoResize)

	if uv0.Button(u8(" Представиться"), uv0.ImVec2(-0.1, 0)) then
		sampSendChat("Здравствуйте, я ваш лечащий врач " .. nickName .. ". Вас что-то беспокоит?")
	end

	uv0.Separator()

	for slot9, slot10 in ipairs({
		{
			u8(" Выдать мед.карту"),
			"/givemed " .. MenuID
		},
		{
			u8(" Послать на анализы"),
			"/analysis " .. MenuID
		},
		{
			u8(" Лечение болезней"),
			"/dis " .. MenuID
		},
		{
			u8(" Донорство"),
			"/donor " .. MenuID
		}
	}) do
		if uv0.Button(slot10[1], slot1) then
			sampProcessChatInput(slot10[2])
		end
	end

	if uv0.Button(u8(" Сменить пол"), slot1) then
		lua_thread.create(function ()
			uv0.window_med[0] = not uv0.window_med[0]
			uv1.Process = uv0.window_med[0]

			for slot4, slot5 in ipairs({
				"/me поставил капельницу.",
				"/me подключил пациента к аппарату ИВЛ.",
				"/me взял скальпель и сделал надрез.",
				"/me взяв щипцы изъял половые органы.",
				"/me положил в капсулу и взял её в руки.",
				"/me открыв дверцу ящика положил в него капсулу.",
				"/me взял капсулу с противоположными органами.",
				"/me положил капсулу на стол и открыл её.",
				"/me достал щипцами органы и вставил в разрез.",
				"/me взял иголку и нитки и начал зашивать место разреза.",
				"/me обработал швы пациента.",
				"/me взял бинт и наложил повязку на шов.",
				"/me пометил маркером изменения на лице.",
				"/me взял скальпель и сделал надрезы.",
				"/me сформировал новую форму лица.",
				"/me взял шприц с ботоксом и вколол его в лицо.",
				"/do Новые формы лица сформированы.",
				"/me взял шприц с гормонами нужного пола и вколол гормоны.",
				"/me отключил пациента от аппарата ИВЛ."
			}) do
				sampSendChat(slot5)
				wait(888)
			end

			wait(555)
			sampProcessChatInput("/changesex " .. MenuID .. " " .. scenazaheal)
		end)
	end

	uv0.Separator()

	slot6 = function(slot0, slot1)
		lua_thread.create(function ()
			uv0.window_med[0] = not uv0.window_med[0]
			uv1.Process = uv0.window_med[0]
			slot0 = 777

			sampSendChat("/me внимательно осмотрев пациента, " .. (ladyValue and "поставила" or "поставил") .. " диагноз.")
			wait(slot0)
			sampSendChat("/do У " .. nickName .. " через плечо надета мед.сумка с лекарствами.")
			wait(slot0)
			sampSendChat("/todo Открыв сумку* Вам будет выписан " .. uv2 .. ", его цена: " .. scenazaheal .. "$.")
			wait(slot0)
			sampSendChat("/me " .. (ladyValue and "достала" or "достал") .. " лекарство и " .. (ladyValue and "передала" or "передал") .. " человеку напротив.")
			wait(333)
			sampProcessChatInput("/medhelp " .. MenuID .. " " .. scenazaheal)

			byemedic = true
		end)
	end

	for slot11, slot12 in ipairs({
		{
			u8(" Головная боль"),
			"Тиленол"
		},
		{
			u8(" Боль в животе, тошнота"),
			"Эметрол"
		},
		{
			u8(" Боль в паху"),
			"Сеалекс"
		},
		{
			u8(" Сердечная боль"),
			"Верапамил"
		},
		{
			u8(" Простуда и жар"),
			"Биаксин"
		},
		{
			u8(" Кашель"),
			"Гербион"
		},
		{
			u8(" Боль в горле"),
			"Пиносол"
		},
		{
			u8(" Аллергия"),
			"Дезал"
		},
		{
			u8(" Ожоги"),
			"Пантенол"
		},
		{
			u8(" Капли для глаз"),
			"Флоксал"
		},
		{
			u8(" Боль в почках"),
			"Нефротин"
		},
		{
			u8(" Повышенное давление"),
			"Капотен"
		},
		{
			u8(" Пониженное давление"),
			"Фуросемид"
		}
	}) do
		if uv0.Button(slot12[1], slot1) then
			slot6(slot12[1]:sub(3), slot12[2])
		end
	end

	uv0.PopFont()
	uv0.End()
end)
slot172 = {}
slot173 = 50
slot174 = 1
slot175 = 0.7
slot176 = 0.04

createSnowflakes = function()
	for slot3 = 1, uv0 do
		table.insert(uv1, {
			x = math.random(0, 125),
			y = math.random(-200, 0),
			size = math.random(3, 6),
			speed = math.random(uv2, uv2 + 2),
			wind = math.random() * uv3 - uv3 / 2,
			alpha = math.random(180, 255) / 255,
			angle = math.random(0, 360),
			angularSpeed = math.random(-1, 1) * 0.05
		})
	end
end

updateSnowflakes = function()
	for slot3, slot4 in ipairs(uv0) do
		slot4.y = slot4.y + slot4.speed
		slot4.x = slot4.x + slot4.wind
		slot4.angle = slot4.angle + slot4.angularSpeed

		if slot4.y > 480 then
			slot4.y = -5
			slot4.x = math.random(0, 125)
			slot4.size = math.random(3, 6)
			slot4.speed = math.random(uv1, uv1 + 2)
			slot4.wind = math.random() * uv2 - uv2 / 2
			slot4.alpha = math.random(180, 255) / 255
			slot4.angle = math.random(0, 360)
			slot4.angularSpeed = math.random(-1, 1) * 0.05
		end
	end
end

drawSnowflakes = function()
	slot0 = uv0.GetCursorScreenPos()

	for slot4, slot5 in ipairs(uv1) do
		uv0.GetWindowDrawList():AddCircleFilled(slot0 + uv0.ImVec2(slot5.x, slot5.y), slot5.size, uv0.ColorConvertFloat4ToU32(uv0.ImVec4(1, 1, 1, slot5.alpha)))
	end
end

slot177 = slot2.OnFrame(function ()
	return uv0.binder_window[0]
end, function (slot0)
	uv0.PushFont(uv1)
	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 2, uv3 / 2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))

	slot1, slot2 = ({
		SetStyle,
		SetStyle2,
		SetStyle3
	})[uv4.cfgGen.themes + 1]()

	uv0.PushStyleVarVec2(uv0.StyleVar.WindowPadding, uv0.ImVec2(0, 0))
	uv0.Begin(u8("HorAssist"), uv5.binder_window, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)

	slot3 = uv0.GetCursorScreenPos()
	slot4 = uv0.ImVec2(125, 480)
	slot5 = uv0.ColorConvertFloat4ToU32(slot1[slot2.WindowBg])

	uv0.GetWindowDrawList():AddRectFilled(slot3 - uv0.ImVec2(8, 0), slot3 + slot4, slot5, 22, 5)
	uv0.GetWindowDrawList():AddRectFilled(slot3 - uv0.ImVec2(8, 0), slot3 + slot4, uv0.ColorConvertFloat4ToU32(slot1[slot2.Button]), 22, 5)
	uv0.GetWindowDrawList():AddRectFilled(slot3 + uv0.ImVec2(13, 88), slot3 + uv0.ImVec2(slot4.x - 13, 90), slot5, 99, 15)
	updateSnowflakes()
	drawSnowflakes()
	uv0.SetCursorPos(uv0.ImVec2(0, 0))
	uv0.BeginChild("Infoblya", uv0.ImVec2(125, 480), false)
	uv0.InvisibleButton("hidelogo", uv0.ImVec2(125, 80))
	uv0.PushFont(BmainFont)

	if uv0.IsItemClicked() then
		halogoValue = not halogoValue
		uv6.cfgButton.halogo = halogoValue

		uv7.save(uv6, uv8)
	end

	if halogoValue then
		uv0.SetCursorPos(uv0.ImVec2(22, 2))
		uv0.Image(uv9, uv0.ImVec2(90, 60))
		uv0.PushFont(uv1)
		uv0.SetCursorPosY(68)
		ShowCenterText2(statusscriptra)
	else
		uv0.SetCursorPos(uv0.ImVec2(15, 15))
		ShowCenterText2("HorAssist")
		uv0.PushFont(uv1)
		uv0.SetCursorPosY(40)
		ShowCenterText2(script_version)
		uv0.SetCursorPosX(15)
		ShowCenterText2(statusscriptra)
	end

	slot8 = 120
	slot9 = 5

	for slot13, slot14 in ipairs({
		u8("Основное"),
		u8("Прочее"),
		u8("Чат"),
		u8("Биндер"),
		u8("GameFix"),
		u8("Команды"),
		u8("Настройка")
	}) do
		if uv10 ~= false or slot13 ~= 7 then
			uv0.SetCursorPos(uv0.ImVec2((125 - slot8) / 2, 100 + (slot13 - 1) * 45))

			if uv11[0] == slot13 then
				uv0.PushFont(BmainFont)
			else
				uv0.PushFont(uv1)
			end

			uv0.PushStyleColor(uv0.Col.Button, uv0.ImVec4(0, 0, 0, 0))
			uv0.PushStyleColor(uv0.Col.ButtonHovered, uv0.ImVec4(0.33, 0.85, 0.65, 0.4))
			uv0.PushStyleColor(uv0.Col.ButtonActive, uv0.ImVec4(0.33, 0.85, 0.65, 0.6))

			if uv0.CustomButton(slot14, uv0.ImVec2(slot8, 40)) then
				uv11[0] = slot13
			end

			uv0.PopStyleColor(3)
			uv0.PopFont()
		end
	end

	uv0.SetCursorPosY(424)
	uv0.SetCursorPosX(20)

	if uv0.CustomButton(u8("Закрыть"), uv0.ImVec2(85, 30), 0.2, true) then
		startnh()
	end

	uv0.EndChild()
	uv0.SetCursorPos(uv0.ImVec2(135, 20))
	uv0.BeginChild("Content", uv0.ImVec2(545, 450), false)
	uv0.PopStyleVar(1)

	if uv11[0] == 1 then
		uv0.PushStyleColor(uv0.Col.ChildBg, uv0.ImVec4(0.1, 0.1, 0.1, 0.95))
		uv0.BeginChild("tab1nast1", uv0.ImVec2(340, 50), false)
		uv0.SetCursorPos(uv0.ImVec2(15, 15))
		updateToggle(lady, "lady", "ladyValue", uv8)
		uv0.SameLine(55)
		uv0.Text(u8("» Женский пол"))
		uv0.SetCursorPos(uv0.ImVec2(160, 15))
		updateToggle(timecout, "timecout", "timecoutValue", uv8)
		uv0.SameLine(200)
		uv0.Text(u8("» Чистый онлайн"))
		ShowHelpMarker(" После ввода /c 60 в чате покажется Ваш чистый онлайн за день. ")
		uv0.EndChild()

		if isPlayerSoldierMed or isPlayerSoldierPolice then
			uv0.SameLine(360)
			uv0.BeginChild("tab1nastpkmg", uv0.ImVec2(110, 50), false)
			uv0.SetCursorPos(uv0.ImVec2(15, 15))

			if not uv12 then
				uv0.BeginChild("cha1nge", uv0.ImVec2(105, 25), true)
				uv0.SetCursorPosY(2)
				uv0.TextColored(uv0.ImVec4(1, 1, 0.7, 1), getDownKeysText())
				ShowHelpMarker(" При залипании клавиши 'Right Button' нажмите ПКМ вне окна ")
				uv0.EndChild()
				uv0.SameLine()

				if uv0.Button(u8("Сохранить")) then
					if getDownKeysText() ~= "None" then
						uv13.cfg.vzaimhotkey = getDownKeysText()
						vzaimhotkeyValue = getDownKeysText()

						uv7.save(uv13, uv14)

						vzaimhotkey = uv0.new.char[256](tostring(cfg.cfg.vzaimhotkey))
						uv12 = true
					else
						TriggerNotification("Зажмите клавишу/клавиши, после чего повторите попытку.")
					end
				end
			else
				uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8:decode(vzaimhotkeyValue))
				uv0.SameLine()

				if uv0.Button(u8("Изм.")) then
					uv12 = false
				end
			end

			ShowHelpMarker("  Бинд на меню взаимодействия с игроком.\n  По стандарту стоит на ПКМ+G.  ")
			uv0.EndChild()
		end

		uv0.Separator()
		uv0.BeginChild("tab1nast2", uv0.ImVec2(330, 75), false)
		uv0.SetCursorPos(uv0.ImVec2(15, 15))
		updateToggle(active_chat, "active_chat", "active_chatValue", uv8)
		uv0.SameLine(55)
		uv0.Text(u8("» Акцент"))
		uv0.SetCursorPos(uv0.ImVec2(150, 15))
		updateToggle(offtag, "offtag", "offtagValue", uv8)
		uv0.SameLine(190)
		uv0.Text(u8("» Тэг в /where и /ok"))
		uv0.SetCursorPos(uv0.ImVec2(15, 45))
		updateToggle(active_r, "active_r", "active_rValue", uv8)
		uv0.SameLine(55)
		uv0.Text(u8("» Тэг в R чат"))
		uv0.SetCursorPos(uv0.ImVec2(150, 45))
		updateToggle(active_f, "active_f", "active_fValue", uv8)
		uv0.SameLine(190)
		uv0.Text(u8("» Тэг в F чат"))
		uv0.EndChild()

		slot10 = 0

		if active_chatValue then
			slot10 = slot10 + 1
		end

		if active_rValue then
			slot10 = slot10 + 1
		end

		if active_fValue then
			slot10 = slot10 + 1
		end

		if slot10 > 0 then
			uv0.SameLine()
			uv0.BeginChild("tab1nast3", uv0.ImVec2(182, 8 + 25 * slot10), false)
			uv0.PushItemWidth(100)

			slot12 = 7

			if active_chatValue then
				uv0.SetCursorPos(uv0.ImVec2(5, slot12))
				updateInputText(accent, "accent", "accentValue", uv14)
				uv0.SameLine()
				uv0.Text(u8("» Акцент"))

				slot12 = slot12 + 25
			end

			if active_rValue then
				uv0.SetCursorPos(uv0.ImVec2(5, slot12))
				updateInputText(rtext, "rtext", "rtextValue", uv14)
				uv0.SameLine()
				uv0.Text(u8("» Тэг R"))

				slot12 = slot12 + 25
			end

			if active_fValue then
				uv0.SetCursorPos(uv0.ImVec2(5, slot12))
				updateInputText(ftext, "ftext", "ftextValue", uv14)
				uv0.SameLine()
				uv0.Text(u8("» Тэг F"))

				slot12 = slot12 + 25
			end

			uv0.PopItemWidth()
			uv0.EndChild()
		end

		uv0.Separator()
		uv0.BeginChild("tab1nast4", uv0.ImVec2(535, 150), false)
		ShowCenterText2(u8("RolePlay отыгровки"))
		uv0.SetCursorPos(uv0.ImVec2(15, 20))
		updateToggle(active_rpgun, "active_rpgun", "active_rpgunValue", uv8)
		uv0.SameLine(55)
		uv0.Text(u8("» RP Weapon"))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##orujie")) then
			uv0.OpenPopup(u8("Свои отыгровки ##orujie"))
		end

		if uv0.BeginPopupModal(u8("Свои отыгровки ##orujie"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(450)

			for slot15, slot16 in ipairs({
				{
					var = "newUnarmed",
					label = u8("Убрать оружие")
				},
				{
					var = "newSilenced",
					label = u8("Отыгровка для Silenced Pistol")
				},
				{
					var = "newDesert",
					label = u8("Отыгровка для Desert Eagle")
				},
				{
					var = "newShot",
					label = u8("Отыгровка для Shotgun")
				},
				{
					var = "newSawnoff",
					label = u8("Отыгровка для Sawn-off Shotgun")
				},
				{
					var = "newCombat",
					label = u8("Отыгровка для Combat Shotgun")
				},
				{
					var = "newMicro",
					label = u8("Отыгровка для Micro Uzi")
				},
				{
					var = "newpMp5",
					label = u8("Отыгровка для MP-5")
				},
				{
					var = "newpAk47",
					label = u8("Отыгровка для AK-47")
				},
				{
					var = "newM4",
					label = u8("Отыгровка для M4A1")
				},
				{
					var = "newCrifle",
					label = u8("Отыгровка для Country Rifle")
				},
				{
					var = "newSrifle",
					label = u8("Отыгровка для Sniper Rifle")
				}
			}) do
				ShowCenterText2(slot16.label)
				updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
			end

			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(200, 22))
		updateToggle(autootvetchikon, "autootvetchikon", "autootvetchikonValue", uv8)
		uv0.SameLine(240)
		uv0.Text(u8("» AutoHi"))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##autohi")) then
			uv0.OpenPopup(u8("Приветсвтие при ответе на звонок ##autohi"))
		end

		if uv0.BeginPopupModal(u8("Приветсвтие при ответе на звонок ##autohi"), nil, uv0.WindowFlags.AlwaysAutoResize) then
			uv0.PushItemWidth(450)
			updateInputText(autootvetchiktext, "autootvetchiktext", "autootvetchiktextValue", uv14)
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		ShowHelpMarker(" Автоматически здоровайтесь при поднятии трубки(/p). ")
		uv0.SetCursorPos(uv0.ImVec2(15, 45))
		uv0.PushItemWidth(200)
		updateToggle(mask, "mask", "maskValue", uv8)
		uv0.SameLine(55)
		uv0.Text(u8("» /mask "))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##mask")) then
			uv0.OpenPopup(u8("Своя отыгровка /mask"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка /mask"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			ShowCenterText2(u8("Отыгровка /mask"))
			uv0.PushItemWidth(450)
			updateInputText(newrpmask, "newrpmask", "newrpmaskValue", uv14)
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(190, 46))
		updateToggle(gateOn, "gateOn", "gateOnValue", uv8)
		uv0.SameLine(230)

		if isPlayerSoldierPolice then
			uv0.Text(u8("» /open"))
		else
			uv0.Text(u8("» /gate"))
		end

		uv0.SameLine()

		if uv0.Button(u8("Изм. ##gate")) then
			uv0.OpenPopup(u8("Своя отыгровка ##gate"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##gate"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(450)

			for slot15, slot16 in ipairs({
				{
					var = "newrpgate1",
					id = "##1open",
					label = u8("Первая строчка")
				},
				{
					var = "newrpgate2",
					id = "##2open",
					label = u8("Вторая строчка")
				}
			}) do
				ShowCenterText2(slot16.label)
				updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				ShowHelpMarker(" Если оставить строку пустой - отыграется стандартная отыгровка.\nЕсли не нуждаетесь в строке, поставьте прочерк: '' - '' ")
			end

			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(350, 47))
		updateToggle(healme, "healme", "healmeValue", uv8)
		uv0.SameLine(390)
		uv0.Text(u8("» /healme "))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##healme")) then
			uv0.OpenPopup(u8("Своя отыгровка /healme"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка /healme"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			ShowCenterText2(u8("Отыгровка для /healme"))
			uv0.PushItemWidth(450)
			updateInputText(newrphealme, "newrphealme", "newrphealmeValue", uv14)
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(15, 70))
		updateToggle(rpFind, "rpFind", "rpFindValue", uv8)
		uv0.SameLine(55)
		uv0.Text(u8("» /find   "))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##find")) then
			uv0.OpenPopup(u8("Своя отыгровка ##find"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##find"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			ShowCenterText2(u8("Отыгровка для /find"))
			uv0.PushItemWidth(450)
			updateInputText(newrpfind, "newrpfind", "newrpfindValue", uv14)
			ShowHelpMarker(" Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - ''\nЕсли оставить строку пустой - отыграется стандартная отыгровка. ")
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(190, 71))
		updateToggle(rprang, "rprang", "rprangValue", uv8)
		uv0.SameLine(230)
		uv0.Text(u8("» /rang"))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##rang")) then
			uv0.OpenPopup(u8("Своя отыгровка ##rang"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##rang"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(450)

			for slot15, slot16 in ipairs({
				{
					var = "newrprang1",
					id = "##1rang",
					label = u8("Первая строчка /rang")
				},
				{
					var = "newrprang2",
					id = "##2rang",
					label = u8("Вторая строчка /rang")
				},
				{
					var = "newrprang3",
					id = "##3rang",
					label = u8("Третья строчка /rang")
				}
			}) do
				ShowCenterText2(slot16.label)
				updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				ShowHelpMarker(" Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - ''\nЕсли оставить строку пустой - отыграется стандартная отыгровка. ")
			end

			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(350, 72))
		updateToggle(rpuninv, "rpuninv", "rpuninvValue", uv8)
		uv0.SameLine(390)
		uv0.Text(u8("» /uninvite"))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##uninvite")) then
			uv0.OpenPopup(u8("Своя отыгровка ##uninvite"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##uninvite"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(450)

			for slot15, slot16 in ipairs({
				{
					var = "rpuninvnew1",
					id = "##1uninvite",
					label = u8("Первая строчка /uninvite")
				},
				{
					var = "rpuninvnew2",
					id = "##2uninvite",
					label = u8("Вторая строчка /uninvite")
				}
			}) do
				ShowCenterText2(slot16.label)
				updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				ShowHelpMarker(" Если оставить строку пустой - отыграется стандартная отыгровка. ")
			end

			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(15, 95))
		updateToggle(rpinv, "rpinv", "rpinvValue", uv8)
		uv0.SameLine(55)
		uv0.Text(u8("» /invite"))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##invite")) then
			uv0.OpenPopup(u8("Своя отыгровка ##invite"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##invite"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(450)

			for slot15, slot16 in ipairs({
				{
					var = "newrpinv1",
					id = "##1invite",
					label = u8("Первая строчка /invite")
				},
				{
					var = "newrpinv2",
					id = "##2invite",
					label = u8("Вторая строчка /invite")
				},
				{
					var = "newrpinv3",
					id = "##3invite",
					label = u8("Третья строчка /invite")
				},
				{
					var = "newrpinv4",
					id = "##4invite",
					label = u8("Текст в рацию")
				}
			}) do
				ShowCenterText2(slot16.label)
				updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				ShowHelpMarker(" Если оставить строку пустой - отыграется стандартная отыгровка. ")
			end

			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(190, 96))
		updateToggle(skip, "skip", "skipValue", uv8)
		uv0.SameLine(230)
		uv0.Text(u8("» /skip "))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##skip")) then
			uv0.OpenPopup(u8("Своя отыгровка ##skip"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##skip"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			ShowCenterText2(u8("Отыгровка для /skip"))
			uv0.PushItemWidth(450)
			updateInputText(newrpskip, "newrpskip", "newrpskipValue", uv14)
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(350, 97))
		updateToggle(rpskin, "rpskin", "rpskinValue", uv8)
		uv0.SameLine(390)
		uv0.Text(u8("» /changeskin"))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##changeskin")) then
			uv0.OpenPopup(u8("Своя отыгровка ##changeskin"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##changeskin"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(450)

			for slot15, slot16 in ipairs({
				{
					var = "newrpskin1",
					id = "##1changeskin",
					label = u8("Первая строчка /changeskin")
				},
				{
					var = "newrpskin2",
					id = "##2changeskin",
					label = u8("Вторая строчка /changeskin")
				}
			}) do
				ShowCenterText2(slot16.label)
				updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				ShowHelpMarker(" Если оставить строку пустой - отыграется стандартная отыгровка. ")
			end

			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(15, 120))
		updateToggle(rpdrone, "rpdrone", "rpdroneValue", uv8)
		uv0.SameLine(55)
		uv0.Text(u8("» /drone"))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##drone")) then
			uv0.OpenPopup(u8("Своя отыгровка ##drone"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##drone"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(450)

			for slot15, slot16 in ipairs({
				{
					var = "newrpdrone1",
					id = "##1drone",
					label = u8("Первая строчка /drone")
				},
				{
					var = "newrpdrone2",
					id = "##2drone",
					label = u8("Вторая строчка /drone")
				}
			}) do
				ShowCenterText2(slot16.label)
				updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
			end

			ShowHelpMarker(" Если вы не нуждаетесь в этой строке, поставьте прочерк: '' - '' \n Если оставить строку пустой - отыграется стандартная отыгровка. ")
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(190, 121))
		updateToggle(rplock, "rplock", "rplockValue", uv8)
		uv0.SameLine(230)
		uv0.Text(u8("» /lock"))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##lock")) then
			uv0.OpenPopup(u8("Своя отыгровка ##lock"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##lock"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			ShowCenterText2(u8("Отыгровка для /lock"))
			uv0.PushItemWidth(450)
			updateInputText(newrplock, "newrplock", "newrplockValue", uv14)
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SetCursorPos(uv0.ImVec2(350, 122))
		updateToggle(rptime, "rptime", "rptimeValue", uv8)
		uv0.SameLine(390)
		uv0.Text(u8("» /c 60  "))
		uv0.SameLine()

		if uv0.Button(u8("Изм. ##c60")) then
			uv0.OpenPopup(u8("Своя отыгровка ##c60"))
		end

		if uv0.BeginPopupModal(u8("Своя отыгровка ##c60"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(450)

			for slot15, slot16 in ipairs({
				{
					var = "newrptime",
					id = "##1c 60",
					label = u8("Первая строчка /c 60")
				},
				{
					var = "newrptime2",
					id = "##2c 60",
					label = u8("Вторая строчка /c 60")
				}
			}) do
				ShowCenterText2(slot16.label)
				updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
			end

			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.EndChild()

		if isPlayerSoldierPolice then
			uv0.BeginChild("tab1nastemia", uv0.ImVec2(535, 125), false)
			ShowCenterText2(u8("Ministry of Internal Affairs"))
			uv0.SetCursorPos(uv0.ImVec2(15, 20))
			updateToggle(cuff, "cuff", "cuffValue", uv8)
			uv0.SameLine(55)
			uv0.Text(u8("» /cuff"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##cuff")) then
				uv0.OpenPopup(u8("Своя отыгровка ##cuff"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##cuff"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /cuff"))
				uv0.PushItemWidth(450)
				updateInputText(newrpcuff, "newrpcuff", "newrpcuffValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(190, 20))
			updateToggle(uncuff, "uncuff", "uncuffValue", uv8)
			uv0.SameLine(230)
			uv0.Text(u8("» /uncuff"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##uncuff")) then
				uv0.OpenPopup(u8("Своя отыгровка ##uncuff"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##uncuff"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /uncuff"))
				uv0.PushItemWidth(450)
				updateInputText(newrpuncuff, "newrpuncuff", "newrpuncuffValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(350, 22))
			updateToggle(rpticket, "rpticket", "rpticketValue", uv8)
			uv0.SameLine(390)
			uv0.Text(u8("» /ticket"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##ticket")) then
				uv0.OpenPopup(u8("Своя отыгровка ##ticket"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##ticket"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "newrpticket",
						id = "##1c 60",
						label = u8("Первая строчка /ticket")
					},
					{
						var = "newrpticket2",
						id = "##2c 60",
						label = u8("Вторая строчка /ticket")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(15, 45))
			updateToggle(arrest, "arrest", "arrestValue", uv8)
			uv0.SameLine(55)
			uv0.Text(u8("» /arrest"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##arrest")) then
				uv0.OpenPopup(u8("Своя отыгровка ##arrest"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##arrest"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "newrparrest",
						id = "newrparrest",
						label = u8("Первая строчка /arrest")
					},
					{
						var = "newrparrest2",
						id = "newrparrest2",
						label = u8("Вторая строчка /arrest")
					},
					{
						var = "newrparrest3",
						id = "newrparrest3",
						label = u8("Третья строчка /arrest")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
					ShowHelpMarker("Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - ''\nЕсли оставить строку пустой - отыграется стандартная отыгровка.")
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(190, 45))
			updateToggle(rpsu, "rpsu", "rpsuValue", uv8)
			uv0.SameLine(230)
			uv0.Text(u8("» /su"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##su")) then
				uv0.OpenPopup(u8("Своя отыгровка ##su"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##su"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /su"))
				uv0.PushItemWidth(450)
				updateInputText(newrpsu, "newrpsu", "newrpsuValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(350, 45))
			updateToggle(pull, "pull", "pullValue", uv8)
			uv0.SameLine(390)
			uv0.Text(u8("» /pull"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##pull")) then
				uv0.OpenPopup(u8("Своя отыгровка ##pull"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##pull"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "newrppull",
						id = "newrppull",
						label = u8("Первая строчка /pull")
					},
					{
						var = "newrppull2",
						id = "newrppull2",
						label = u8("Вторая строчка /pull")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(15, 70))
			updateToggle(setmark, "setmark", "setmarkValue", uv8)
			uv0.SameLine(55)
			uv0.Text(u8("» /setmark"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##setmark")) then
				uv0.OpenPopup(u8("Своя отыгровка ##setmark"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##setmark"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /setmark"))
				uv0.PushItemWidth(450)
				updateInputText(newrpsetmark, "newrpsetmark", "newrpsetmarkValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(190, 70))
			updateToggle(putpl, "putpl", "putplValue", uv8)
			uv0.SameLine(230)
			uv0.Text(u8("» /putpl"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##putpl")) then
				uv0.OpenPopup(u8("Своя отыгровка ##putpl"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##putpl"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /putpl"))
				uv0.PushItemWidth(450)
				updateInputText(newrpputpl, "newrpputpl", "newrpputplValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(350, 70))
			updateToggle(hold, "hold", "holdValue", uv8)
			uv0.SameLine(390)
			uv0.Text(u8("» /hold"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##hold")) then
				uv0.OpenPopup(u8("Своя отыгровка ##hold"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##hold"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /hold"))
				uv0.PushItemWidth(450)
				updateInputText(newrphold, "newrphold", "newrpholdValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(15, 95))
			updateToggle(search, "search", "searchValue", uv8)
			uv0.SameLine(55)
			uv0.Text(u8("» /search"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##search")) then
				uv0.OpenPopup(u8("Своя отыгровка ##search"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##search"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "newrpsearch",
						id = "newrpsearch",
						label = u8("Первая строчка /search")
					},
					{
						var = "newrpsearch2",
						id = "newrpsearch2",
						label = u8("Вторая строчка /search")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(190, 95))
			updateToggle(takelic, "takelic", "takelicValue", uv8)
			uv0.SameLine(230)
			uv0.Text(u8("» /takelic"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##takelic")) then
				uv0.OpenPopup(u8("Своя отыгровка ##takelic"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##takelic"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "rptakelic",
						id = "rptakelic",
						label = u8("Первая строчка /takelic")
					},
					{
						var = "rptakelic2",
						id = "rptakelic2",
						label = u8("Вторая строчка /takelic")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(350, 95))
			updateToggle(clear, "clear", "clearValue", uv8)
			uv0.SameLine(390)
			uv0.Text(u8("» /clear"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##clear")) then
				uv0.OpenPopup(u8("Своя отыгровка ##clear"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##clear"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /clear"))
				uv0.PushItemWidth(450)
				updateInputText(rpclear, "rpclear", "rpclearValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.EndChild()
		end

		if isPlayerMassMedia then
			uv0.BeginChild("tab1nastedit", uv0.ImVec2(535, 55), false)
			ShowCenterText2(u8("MassMedia"))
			uv0.SetCursorPos(uv0.ImVec2(15, 20))
			updateToggle(edit, "edit", "editValue", uv8)
			uv0.SameLine(55)
			uv0.Text(u8("» Новый /edit"))
			uv0.SetCursorPos(uv0.ImVec2(190, 20))
			updateToggle(efir, "efir", "efirValue", uv8)
			uv0.SameLine(230)
			uv0.Text(u8("» /efir"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##efir")) then
				uv0.OpenPopup(u8("Своя отыгровка ##efir"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##efir"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "rpefir1",
						id = "##rpefir1",
						label = u8("Первая строчка /efir")
					},
					{
						var = "rpefir2",
						id = "##rpefir2",
						label = u8("Вторая строчка /efir")
					},
					{
						var = "endrpefir1",
						id = "##endrpefir1",
						label = u8("Первая строчка закончить /efir")
					},
					{
						var = "endrpefir2",
						id = "##endrpefir2",
						label = u8("Первая строчка закончить /efir")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(350, 20))
			updateToggle(muzpriv, "muzpriv", "muzprivValue", uv8)
			uv0.SameLine(385)
			uv0.Text(u8("» Муз.заставка"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##muzpriv")) then
				uv0.OpenPopup(u8("Своя отыгровка ##muzpriv"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##muzpriv"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Музыкальная заставка."))
				ShowCenterText2(u8("При включенной функции - при вводе /efir она отыграется автоматически"))
				uv0.Separator()
				uv0.PushItemWidth(450)
				updateInputText(muzprivrp, "muzprivrp", "muzprivrpValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.EndChild()
		end

		if isPlayerGoverment then
			uv0.BeginChild("tab1nasgov", uv0.ImVec2(535, 75), false)
			ShowCenterText2(u8("Government"))
			uv0.SetCursorPos(uv0.ImVec2(15, 20))
			updateToggle(cuff, "cuff", "cuffValue", uv8)
			uv0.SameLine(55)
			uv0.Text(u8("» /cuff"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##cuff")) then
				uv0.OpenPopup(u8("Своя отыгровка ##cuff"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##cuff"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /cuff"))
				uv0.PushItemWidth(450)
				updateInputText(newrpcuff, "newrpcuff", "newrpcuffValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(190, 20))
			updateToggle(uncuff, "uncuff", "uncuffValue", uv8)
			uv0.SameLine(230)
			uv0.Text(u8("» /uncuff"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##uncuff")) then
				uv0.OpenPopup(u8("Своя отыгровка ##uncuff"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##uncuff"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /uncuff"))
				uv0.PushItemWidth(450)
				updateInputText(newrpuncuff, "newrpuncuff", "newrpuncuffValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(350, 20))
			updateToggle(hold, "hold", "holdValue", uv8)
			uv0.SameLine(390)
			uv0.Text(u8("» /hold"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##hold")) then
				uv0.OpenPopup(u8("Своя отыгровка ##hold"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##hold"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /hold"))
				uv0.PushItemWidth(450)
				updateInputText(newrphold, "newrphold", "newrpholdValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(15, 45))
			updateToggle(free, "free", "freeValue", uv8)
			uv0.SameLine(55)
			uv0.Text(u8("» /free"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##free")) then
				uv0.OpenPopup(u8("Своя отыгровка ##free"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##free"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "rpfree",
						id = "##1free",
						label = u8("Первая строчка /free")
					},
					{
						var = "rpfree2",
						id = "##2free",
						label = u8("Вторая строчка /free")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(190, 45))
			updateToggle(rpgivelic, "rpgivelic", "rpgivelicValue", uv8)
			uv0.SameLine(230)
			uv0.Text(u8("» /givelic"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##givelic")) then
				uv0.OpenPopup(u8("Своя отыгровка ##givelic"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##givelic"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "givelicrp",
						id = "##1givelic",
						label = u8("Первая строчка /givelic")
					},
					{
						var = "givelicrp2",
						id = "##2givelic",
						label = u8("Вторая строчка /givelic")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(350, 45))
			updateToggle(debtorsell, "debtorsell", "debtorsellValue", uv8)
			uv0.SameLine(390)
			uv0.Text(u8("» /debtorsell"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##debtorsell")) then
				uv0.OpenPopup(u8("Своя отыгровка ##debtorsell"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##debtorsell"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "debtorsellrp",
						id = "##1debtorsell",
						label = u8("Первая строчка /debtorsell")
					},
					{
						var = "debtorsellrp2",
						id = "##2debtorsell",
						label = u8("Вторая строчка /debtorsell")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.EndChild()
		end

		if isPlayerSoldierMafia then
			uv0.BeginChild("tab1nastmafia", uv0.ImVec2(505, 80), false)
			ShowCenterText2(u8("Mafia"))
			uv0.SetCursorPos(uv0.ImVec2(15, 20))
			updateToggle(rpbag, "rpbag", "rpbagValue", uv8)
			uv0.SameLine(55)
			uv0.Text(u8("» /bag"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##bag")) then
				uv0.OpenPopup(u8("Своя отыгровка ##bag"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##bag"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "newrpbag",
						id = "##newrpbag",
						label = u8("Отыгровка /bag")
					},
					{
						var = "newrpunbag",
						id = "##newrpunbag",
						label = u8("Отыгровка /unbag")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(190, 20))
			updateToggle(rptie, "rptie", "rptieValue", uv8)
			uv0.SameLine(230)
			uv0.Text(u8("» /tie"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##tie")) then
				uv0.OpenPopup(u8("Своя отыгровка ##tie"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##tie"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "newrptie",
						id = "##newrptie",
						label = u8("Отыгровка /tie")
					},
					{
						var = "newrpuntie",
						id = "##newrpuntie",
						label = u8("Отыгровка /untie")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(350, 20))
			updateToggle(rpbomb, "rpbomb", "rpbombValue", uv8)
			uv0.SameLine(390)
			uv0.Text(u8("» /bomb"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##bomb")) then
				uv0.OpenPopup(u8("Своя отыгровка ##bomb"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##bomb"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				uv0.PushItemWidth(450)

				for slot15, slot16 in ipairs({
					{
						var = "newrpbomb1",
						id = "##1bomb",
						label = u8("Первая строчка /bomb")
					},
					{
						var = "newrpbomb2",
						id = "##2bomb",
						label = u8("Вторая строчка /bomb")
					}
				}) do
					ShowCenterText2(slot16.label)
					updateInputText(_G[slot16.var], slot16.var, slot16.var .. "Value", uv14)
				end

				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.SetCursorPos(uv0.ImVec2(15, 45))
			updateToggle(hold, "hold", "holdValue", uv8)
			uv0.SameLine(55)
			uv0.Text(u8("» /hold"))
			uv0.SameLine()

			if uv0.Button(u8("Изм. ##hold")) then
				uv0.OpenPopup(u8("Своя отыгровка ##hold"))
			end

			if uv0.BeginPopupModal(u8("Своя отыгровка ##hold"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
				ShowCenterText2(u8("Отыгровка /hold"))
				uv0.PushItemWidth(450)
				updateInputText(newrphold, "newrphold", "newrpholdValue", uv14)
				uv0.Separator()
				uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

				if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			uv0.EndChild()
		end

		if isPlayerSoldierMed then
			uv0.BeginChild("tab1nastmed", uv0.ImVec2(535, 100), false)
			ShowCenterText2(u8("Ценовая политика"))
			uv0.SetCursorPos(uv0.ImVec2(15, 20))
			uv0.PushItemWidth(50)
			updateInputText(priceOTHER, "priceOTHER", "priceOTHERValue", uv14)
			uv0.SameLine(65)
			uv0.Text(u8(" » Гражданский"))
			uv0.SameLine(185)
			updateInputText(priceSMI, "priceSMI", "priceSMIValue", uv14)
			uv0.SameLine(235)
			uv0.Text(u8(" » СМИ"))
			uv0.SameLine(295)
			updateInputText(pricePRAVO, "pricePRAVO", "pricePRAVOValue", uv14)
			uv0.SameLine(345)
			uv0.Text(u8(" » Пра-во"))
			uv0.SameLine(420)
			updateInputText(priceMVD, "priceMVD", "priceMVDValue", uv14)
			uv0.SameLine(470)
			uv0.Text(u8(" » МВД"))
			uv0.SetCursorPos(uv0.ImVec2(15, 45))
			updateInputText(priceBAND, "priceBAND", "priceBANDValue", uv14)
			uv0.SameLine(65)
			uv0.Text(u8(" » Банды"))
			uv0.SameLine(185)
			updateInputText(priceMO, "priceMO", "priceMOValue", uv14)
			uv0.SameLine(235)
			uv0.Text(u8(" » МО"))
			uv0.SameLine(295)
			updateInputText(priceMED, "priceMED", "priceMEDValue", uv14)
			uv0.SameLine(345)
			uv0.Text(u8(" » МЗ"))
			uv0.SameLine(420)
			updateInputText(viezdprice, "viezdprice", "viezdpriceValue", uv14)
			uv0.SameLine(470)
			uv0.Text(u8(" » /heal"))
			uv0.SetCursorPos(uv0.ImVec2(15, 70))
			updateInputText(priceYAK, "priceYAK", "priceYAKValue", uv14)
			uv0.SameLine(65)
			uv0.Text(u8(" » Yakuza"))
			uv0.SameLine(185)
			updateInputText(priceLCN, "priceLCN", "priceLCNValue", uv14)
			uv0.SameLine(235)
			uv0.Text(u8(" » ЛКН"))
			uv0.SameLine(295)
			updateInputText(priceRM, "priceRM", "priceRMValue", uv14)
			uv0.SameLine(345)
			uv0.Text(u8(" » РМ"))
			uv0.SameLine(420)
			updateToggle(rpheal, "rpheal", "rphealValue", uv8)
			uv0.SameLine(475)
			uv0.Text(u8("» /heal"))
			uv0.EndChild()
		end

		uv0.PopStyleColor()
		uv0.EndChild()
	end

	if uv11[0] == 2 then
		uv0.PushStyleColor(uv0.Col.ChildBg, uv0.ImVec4(0.1, 0.1, 0.1, 0.95))

		if not VipStatus then
			ShowCenterText2(u8("VIP функции недоступны"))
		else
			ShowCenterText2(u8("VIP функции"))
		end

		if not VipStatus then
			uv0.PushStyleVarFloat(uv0.StyleVar.Alpha, 0.5)
		end

		uv0.SetCursorPosX((uv0.GetWindowWidth() - 270) / 2)
		uv0.BeginChild("tab1nast21", uv0.ImVec2(250, 40), false)
		uv0.SetCursorPos(uv0.ImVec2(10, 8))

		if uv0.ColorEdit3(u8("##trgegehdg"), uv15, uv0.ColorEditFlags.NoInputs) and not slot10 then
			uv16 = join_argb(0, uv15[0] * 255, uv15[1] * 255, uv15[2] * 255)
			vipcolor = ("%06X"):format(uv16)
			uv17 = os.clock()
			uv18 = true
		end

		uv0.SameLine(35)
		uv0.Text(u8(" » Цвет ника"))
		ShowHelpMarker(" Все видят ваш сцет ника. \n ЦВЕТ МЕНЯЕТСЯ ПОСЛЕ ПЕРЕЗАГРУЗКИ СКРИПТА ")
		uv0.SetCursorPos(uv0.ImVec2(150, 8))

		if uv0.ColorEdit3(u8("##Цвет /ttd"), uv0.new.float[3](tonumber(uv19:sub(1, 2), 16) / 255, tonumber(uv19:sub(3, 4), 16) / 255, tonumber(uv19:sub(5, 6), 16) / 255), uv0.ColorEditFlags.NoInputs) and not slot10 then
			uv19 = ("%06X"):format(join_argb(0, slot14[0] * 255, slot14[1] * 255, slot14[2] * 255))
			uv17 = os.clock()
			uv20 = true
		end

		uv0.SameLine(175)
		uv0.Text(u8(" » Цвет /ttd"))
		uv0.EndChild()
		uv0.Separator()

		if slot10 then
			uv0.PopStyleVar()
		end

		uv0.BeginChild("tab1nast24", uv0.ImVec2(165, 145), false)
		ShowCenterText2(u8("Чат"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))

		if uv0.ColorEdit3(u8("##chatgtrgttg"), uv0.new.float[3](tonumber(uv4.cfgGen.svetchata:sub(1, 2), 16) / 255, tonumber(uv4.cfgGen.svetchata:sub(3, 4), 16) / 255, tonumber(uv4.cfgGen.svetchata:sub(5, 6), 16) / 255), uv0.ColorEditFlags.NoInputs) then
			slot20 = ("%06X"):format(join_argb(0, slot18[0] * 255, slot18[1] * 255, slot18[2] * 255))
			uv4.cfgGen.svetchata = slot20
			svetchataValue = slot20
			uv4.cfgGen.svetchata = slot20

			uv7.save(uv4, uv21)
		end

		uv0.SameLine(35)
		uv0.Text(u8(" » Цвет чата"))
		ShowHelpMarker(" Визуально меняем цвет чата в рации(по дефолту - белый). ")
		uv0.SetCursorPos(uv0.ImVec2(10, 43))
		updateToggle(ads, "ads", "adsValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» NoAds"))
		ShowHelpMarker(" Все объявления из чата будут отображаться в SampFuncs. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 68))
		updateToggle(nogame, "nogame", "nogameValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» NoEvents"))
		ShowHelpMarker(" Удаление сообщений о системных мероприятиях, тире и складе оружия из чата. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 93))
		updateToggle(chatinfo, "chatinfo", "chatinfoValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» ChatHelper"))
		ShowHelpMarker(" При любой раскладке первое введённое слово в чат начиная с точки или слэша будет транслироваться на английский язык. \n А так же присутствует информер о языке/чате/ид. Работает после перезагрузки (/nhrel) ")
		uv0.SetCursorPos(uv0.ImVec2(10, 118))
		updateToggle(timeinf, "timeinf", "timeinfValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» ZPinfo"))
		ShowHelpMarker(" Показывает сколько осталось отыграть до зарплаты. ")
		uv0.EndChild()
		uv0.SameLine()
		uv0.SameLine(178)
		uv0.BeginChild("tab1nast25", uv0.ImVec2(165, 145), false)
		ShowCenterText2(u8("/ttd"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateToggle(zoneinfo, "zoneinfo", "zoneinfoValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Zone Info"))
		ShowHelpMarker(" Показывается зона в /ttd где вы находитесь. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 43))
		updateToggle(cityinfo, "cityinfo", "cityinfoValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» City Info"))
		ShowHelpMarker(" Показывается город в /ttd где вы находитесь. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 68))
		updateToggle(dateinfo, "dateinfo", "dateinfoValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Date Info"))
		ShowHelpMarker(" Показывается дата в /ttd. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 93))
		updateToggle(infMask, "infMask", "infMaskValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» MaskInfo"))
		ShowHelpMarker(" Скрывает системный таймер и переносит его в /ttd. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 118))

		if uv0.Button(u8(" Поменять позицию "), uv0.ImVec2(150, 20)) then
			uv22 = true

			AddChatMessage("Нажмите {54D9A5}ЛКМ{FFFFFF}, чтобы завершить. Нажмите {54D9A5}ПКМ{FFFFFF}, чтобы отменить")
		end

		uv0.EndChild()
		uv0.SameLine(355)
		uv0.BeginChild("tab1nast26", uv0.ImVec2(173, 145), false)
		ShowCenterText2(u8("Мелочь"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateToggle(autobuy, "autobuy", "autobuyValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Автозакуп"))
		ShowHelpMarker(" При входе в магазин автоматически покупаются маски и аптечки. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 43))
		updateToggle(buyrem, "buyrem", "buyremValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Закуп рем."))
		ShowHelpMarker(" Если включена функция ''автозакуп'', то он закупит и ремкомплект. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 68))
		updateToggle(autoreset, "autoreset", "autoresetValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Авто /reset"))
		ShowHelpMarker(" После ввода /mask все вещи будут автоматически выброшены. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 93))
		updateToggle(autoMask, "autoMask", "autoMaskValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» AutoMask"))
		ShowHelpMarker(" Автоматически надевает новую маску при итечении времени старой. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 118))
		updateToggle(autosc, "autosc", "autoscValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» AutoScreen"))
		ShowHelpMarker(" Если включить этот параметр, то во время отчёта(/rd или /fd) автоматически сделается скриншот. ")
		uv0.EndChild()
		uv0.Separator()
		uv0.BeginChild("tab1nast27", uv0.ImVec2(173, 70), false)
		ShowCenterText2(u8("/find"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateToggle(newfind, "newfind", "newfindValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Новый /find"))
		ShowHelpMarker(" Новый /find без каких либо функций взаимодействия, но зато с нормальным расстоянием. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 43))

		if uv0.Button(u8("Подцветка в find"), uv0.ImVec2(155, 20)) then
			uv0.OpenPopup(u8("favmenuu"))
		end

		if uv0.BeginPopupModal(u8("favmenuu"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			ShowCenterText2(u8("Подсвечивает ники тех игроков,\n  которые будут указаны ниже."))
			uv0.BeginChild("##favmenuu", uv0.ImVec2(222, 210), true)

			uv23.usersListTextBuffer = uv0.new.char[65535](table.concat(uv24.users, "\n"))

			if uv0.InputTextMultiline("##userslistFAV", uv23.usersListTextBuffer, 65535, uv0.ImVec2(205, -1)) then
				uv24.users = #parseText(uv25.string(uv23.usersListTextBuffer)) > 0 and slot19 or {
					""
				}

				saveFAVdata()
			end

			uv0.EndChild()
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.EndChild()
		uv0.SameLine(178)
		uv0.BeginChild("tab1nast28", uv0.ImVec2(173, 70), false)
		ShowCenterText2(u8("Автологин"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateToggle(autologin, "autologin", "autologinValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Включить"))
		ShowHelpMarker(" Автоматический ввод игрового пароля. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 43))
		uv0.PushItemWidth(115)
		updateInputPass(autopass, "autopass", "autopassValue", uv26)
		ShowHelpMarker(" Пароль хранится в moonloader\\config\\HorAssist\\Password.ini \n Никому не отправляйте его! ")
		uv0.EndChild()
		uv0.SameLine(352)
		uv0.BeginChild("tab1nast29", uv0.ImVec2(187, 120), false)
		ShowCenterText2(u8("Дополнительно"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateToggle(_env["CruiseСontrol"], "CruiseСontrol", "CruiseСontrolValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» CruiseСontrol"))
		ShowHelpMarker(" Активация - CC(как чит код). ")
		uv0.SetCursorPos(uv0.ImVec2(10, 43))
		updateToggle(strobesOn, "strobesOn", "strobesOnValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Стробоскопы"))
		ShowHelpMarker(" Активация как чит-код 'SB'. Корректно работает с улучшением ''Мастер вождения'' \n ЧТОБЫ ПОМЕНЯТЬ РЕЖИМ СТРОБОСКОПОВ ВВЕДИ ЧИТ-КОД ''SCB'' ")
		uv0.SetCursorPos(uv0.ImVec2(10, 68))
		updateToggle(parachute, "parachute", "parachuteValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Парашют"))
		ShowHelpMarker(" При полёте с парашютом - он автоматически откроется ")
		uv0.SetCursorPos(uv0.ImVec2(10, 93))

		if uv0.Button(u8("Стиль меню"), uv0.ImVec2(170, 20)) then
			uv0.OpenPopup(u8("stilmenu"))
		end

		uv0.PushStyleVarVec2(uv0.StyleVar.WindowPadding, uv0.ImVec2(5, 5))

		if uv0.BeginPopupModal(u8("stilmenu"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			if uv0.Button(u8("Шрифт: ") .. ({
				u8("Основной"),
				u8("Arial"),
				u8("trebucbd")
			})[(uv4.cfgGen.fontsmenu or 0) + 1], uv0.ImVec2(150, 25)) then
				uv4.cfgGen.fontsmenu = (slot19 + 1) % #slot20

				uv7.save(uv4, uv21)
			end

			if (uv4.cfgGen.sizemenu or 15) < 11 then
				slot21 = 11
			elseif slot21 > 17 then
				slot21 = 17
			end

			uv0.SameLine()

			if uv0.Button("-", uv0.ImVec2(30, 25)) and slot21 > 11 then
				uv4.cfgGen.sizemenu = slot21 - 1

				uv7.save(uv4, uv21)
			end

			uv0.SameLine()
			uv0.Text(u8("Размер: ") .. slot21)
			uv0.SameLine()

			if uv0.Button("+", uv0.ImVec2(30, 25)) and slot21 < 17 then
				uv4.cfgGen.sizemenu = slot21 + 1

				uv7.save(uv4, uv21)
			end

			for slot26, slot27 in ipairs({
				{
					theme = 0,
					name = u8("Стиль Main"),
					func = SetStyle
				},
				{
					theme = 1,
					name = u8("Стиль Sonju"),
					func = SetStyle2
				},
				{
					theme = 2,
					name = u8("Стиль Misato"),
					func = SetStyle3
				}
			}) do
				if uv0.Button(slot27.name, uv0.ImVec2(96, 25)) then
					slot27.func()

					uv4.cfgGen.themes = slot27.theme

					uv7.save(uv4, uv21)
				end

				if slot26 < #slot22 then
					uv0.SameLine()
				end
			end

			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 25)) then
				uv0.CloseCurrentPopup()
				TriggerNotification("Изменения применятся после перезагрузки скрипта. (/nhrel)")
			end

			uv0.EndPopup()
		end

		uv0.EndChild()
		uv0.SetCursorPosY(300)
		uv0.BeginChild("tab1nast2911", uv0.ImVec2(185, 125), false)
		ShowCenterText2(u8("DamageInformer"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateToggle(dmginform, "dmginform", "dmginformValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» DamageInformer"))
		uv0.SetCursorPos(uv0.ImVec2(10, 43))
		updateToggle(hidenickDMG, "hidenickDMG", "hidenickDMGValue", uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Скрыть ники DMG"))
		uv0.SetCursorPos(uv0.ImVec2(10, 68))

		if uv0.Button(u8("Позиция нанесения DMG"), uv0.ImVec2(170, 20)) and not slot10 then
			uv27 = true

			AddChatMessage("Нажмите {54D9A5}ЛКМ{FFFFFF}, чтобы завершить. Нажмите {54D9A5}ПКМ{FFFFFF}, чтобы отменить")
		end

		uv0.SetCursorPos(uv0.ImVec2(10, 93))

		if uv0.Button(u8("Позиция получения DMG"), uv0.ImVec2(170, 20)) and not slot10 then
			uv28 = true

			AddChatMessage("Нажмите {54D9A5}ЛКМ{FFFFFF}, чтобы завершить. Нажмите {54D9A5}ПКМ{FFFFFF}, чтобы отменить")
		end

		uv0.EndChild()
		uv0.PopStyleVar()
		uv0.PopStyleColor()
		uv0.EndChild()
	end

	if uv11[0] == 3 then
		uv0.PushStyleColor(uv0.Col.ChildBg, uv0.ImVec4(0.1, 0.1, 0.1, 0.95))

		if VipStatus then
			uv0.BeginChild("tab1nast44starthi", uv0.ImVec2(535, 45), false)
			ShowCenterText2(u8("Текст при входе в игру"))
			uv0.PushItemWidth(515)
			uv0.SetCursorPos(uv0.ImVec2(10, 18))
			updateInputText(starthi1, "starthi1", "starthi1Value", uv21)
			uv0.EndChild()
		end

		uv0.BeginChild("tab1nast44priven", uv0.ImVec2(535, 45), false)
		ShowCenterText2(u8("Текст при нажатии ПКМ + 1"))
		uv0.PushItemWidth(495)
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateInputText(newpriven, "newpriven", "newprivenValue", uv14)
		ShowHelpMarker(" Если хотите, чтобы при приветсвтии писался и ник - введите {inname} или {insurname}. ")
		uv0.EndChild()

		slot15 = 95

		uv0.BeginChild("testh5rrth", uv0.ImVec2(535, slot15), false)
		uv0.PushItemWidth(478)

		slot11 = 20

		for slot15, slot16 in ipairs({
			{
				label = "Текст /ok",
				configKey = "newok",
				var = newok
			},
			{
				label = "Текст /where",
				configKey = "newwhere",
				var = newwhere
			}
		}) do
			ShowCenterText2(u8(slot16.label))
			ShowHelpMarker("/r прописывается автоматически!")
			uv0.SetCursorPos(uv0.ImVec2(10, slot11))
			uv0.Text(u8("/r"))
			uv0.SameLine()
			updateInputText(slot16.var, slot16.configKey, slot16.configKey .. "Value", uv14)
			ShowHelpMarker(" Если хотите, чтобы писался и ник - введите {inname} или {insurname}. ")

			slot11 = slot11 + 45
		end

		uv0.EndChild()
		uv0.BeginChild("testhhtjtjy", uv0.ImVec2(535, 140), false)
		uv0.PushItemWidth(495)
		ShowCenterText2(u8("Позывной в докладах:"))
		uv0.SetCursorPos(uv0.ImVec2(10, 20))
		updateInputText(doklad, "doklad", "dokladValue", uv14)
		ShowCenterText2(u8("Должность в /ud:"))
		uv0.SetCursorPos(uv0.ImVec2(10, 65))
		updateInputText(uddolj, "uddolj", "uddoljValue", uv14)
		ShowCenterText2(u8("Отыгровка передачи удостоверения:"))
		uv0.SetCursorPos(uv0.ImVec2(10, 115))
		updateInputText(rpud, "rpud", "rpudValue", uv14)
		uv0.EndChild()

		if uv0.Button(u8("Собеседование"), uv0.ImVec2(125, 40)) then
			uv0.OpenPopup(u8("Настройка собеседования ##aa"))
		end

		if uv0.BeginPopupModal(u8("Настройка собеседования ##aa"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(255)
			updateInputText(rpvopros1, "rpvopros1", "rpvopros1Value", uv14)
			uv0.SameLine()
			uv0.Text(u8(" » Вопрос"))
			uv0.PushItemWidth(520)
			updateInputText(rpvopros1text, "rpvopros1text", "rpvopros1textValue", uv14)
			uv0.Separator()
			uv0.PushItemWidth(255)
			updateInputText(rpotkaz1, "rpotkaz1", "rpotkaz1Value", uv14)
			uv0.SameLine()
			uv0.Text(u8(" » Отказ"))
			uv0.PushItemWidth(520)
			updateInputText(rpotkaz1text, "rpotkaz1text", "rpotkaz1textValue", uv14)
			updateInputText(rpotkaz12text, "rpotkaz12text", "rpotkaz12textValue", uv14)
			uv0.Separator()
			uv0.PushItemWidth(255)
			updateInputText(rpvopros2, "rpvopros2", "rpvopros2Value", uv14)
			uv0.SameLine()
			uv0.Text(u8(" » Вопрос"))
			uv0.PushItemWidth(520)
			updateInputText(rpvopros2text, "rpvopros2text", "rpvopros2textValue", uv14)
			uv0.Separator()
			uv0.PushItemWidth(255)
			updateInputText(rpotkaz2, "rpotkaz2", "rpotkaz2Value", uv14)
			uv0.SameLine()
			uv0.Text(u8(" » Отказ"))
			uv0.PushItemWidth(520)
			updateInputText(rpotkaz2text, "rpotkaz2text", "rpotkaz2textValue", uv14)
			updateInputText(rpotkaz22text, "rpotkaz22text", "rpotkaz22textValue", uv14)
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SameLine()

		if uv0.Button(u8("Отыгровка /drive"), uv0.ImVec2(135, 40)) then
			uv0.OpenPopup(u8("Отыгровка /drive ##aa"))
		end

		uv0.SameLine()

		if uv0.Button(u8("Аним. ПКМ + 1"), uv0.ImVec2(125, 40)) then
			uv0.OpenPopup(u8(" Выбор анимации ##aa"))
		end

		if uv0.BeginPopupModal(u8(" Выбор анимации ##aa"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			if uv0.Button(u8("/anim 7"), uv0.ImVec2(120, 20)) then
				uv29 = 1
				uv13.cfg.animhi = 1

				TriggerNotification("Анимация изменена.")
				uv7.save(uv13, uv14)
			end

			if uv0.Button(u8("/anim 11"), uv0.ImVec2(120, 20)) then
				uv29 = 2
				uv13.cfg.animhi = 2

				TriggerNotification("Анимация изменена.")
				uv7.save(uv13, uv14)
			end

			if uv0.Button(u8("/anim 12"), uv0.ImVec2(120, 20)) then
				uv29 = 3

				TriggerNotification("Анимация изменена.")

				uv13.cfg.animhi = 3

				uv7.save(uv13, uv14)
			end

			if uv0.Button(u8("/anim 58"), uv0.ImVec2(120, 20)) then
				uv29 = 4
				uv13.cfg.animhi = 4

				TriggerNotification("Анимация изменена.")
				uv7.save(uv13, uv14)
			end

			if uv0.Button(u8("/anim 63"), uv0.ImVec2(120, 20)) then
				uv29 = 5

				TriggerNotification("Анимация изменена.")

				uv13.cfg.animhi = 5

				uv7.save(uv13, uv14)
			end

			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		if uv0.BeginPopupModal(u8("Отыгровка /drive ##aa"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			ShowCenterText2(u8("До /drive осталось 15 секунд"))
			uv0.PushItemWidth(520)
			updateInputText(newdrive, "newdrive", "newdriveValue", uv14)
			ShowCenterText2(u8("До /drive осталось 10 секунд"))
			updateInputText(newdrive2, "newdrive2", "newdrive2Value", uv14)
			ShowCenterText2(u8("До /drive осталось 5 секунд"))
			updateInputText(newdrive3, "newdrive3", "newdrive3Value", uv14)
			ShowCenterText2(u8("Спавн авто"))
			updateInputText(newdrive4, "newdrive4", "newdrive4Value", uv14)
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.SameLine()

		if uv0.Button(u8("ПКМ + R"), uv0.ImVec2(125, 40)) then
			uv0.OpenPopup(u8(" Отыгровки ПКМ + R ##aa"))
		end

		if uv0.BeginPopupModal(u8(" Отыгровки ПКМ + R ##aa"), nil, uv0.WindowFlags.AlwaysAutoResize + uv0.WindowFlags.NoTitleBar) then
			uv0.PushItemWidth(450)
			ShowCenterText2(u8("Отыгровка /pass"))
			updateInputText(newgivepass1, "newgivepass1", "newgivepass1Value", uv14)
			ShowHelpMarker(" Если оставить строку пустой - отыграется стандартная отыгровка. ")
			ShowCenterText2(u8("Вторая строчка /pass"))
			updateInputText(newgivepass2, "newgivepass2", "newgivepass2Value", uv14)
			ShowHelpMarker(" Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - '' \n Если оставить строку пустой - отыграется стандартная отыгровка. ")
			ShowCenterText2(u8("Третья строчка /pass"))
			updateInputText(newgivepass3, "newgivepass3", "newgivepass3Value", uv14)
			ShowHelpMarker(" Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - '' \n Если оставить строку пустой - отыграется стандартная отыгровка. ")
			uv0.Separator()
			ShowCenterText2(u8("Отыгровка /lic"))
			updateInputText(newgivelic1, "newgivelic1", "newgivelic1Value", uv14)
			ShowHelpMarker("Если оставить строку пустой - отыграется стандартная отыгровка.")
			ShowCenterText2(u8("Вторая строчка /lic"))
			updateInputText(newgivelic2, "newgivelic2", "newgivelic2Value", uv14)
			ShowHelpMarker(" Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - '' \n Если оставить строку пустой - отыграется стандартная отыгровка. ")
			ShowCenterText2(u8("Третья строчка /lic"))
			updateInputText(newgivelic3, "newgivelic3", "newgivelic3Value", uv14)
			ShowHelpMarker(" Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - '' \n Если оставить строку пустой - отыграется стандартная отыгровка. ")
			uv0.Separator()
			ShowCenterText2(u8("Отыгровка /med"))
			updateInputText(newgivemed1, "newgivemed1", "newgivemed1Value", uv14)
			ShowHelpMarker("Если оставить строку пустой - отыграется стандартная отыгровка.")
			ShowCenterText2(u8("Вторая строчка /med"))
			updateInputText(newgivemed2, "newgivemed2", "newgivemed2Value", uv14)
			ShowHelpMarker(" Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - '' \n Если оставить строку пустой - отыграется стандартная отыгровка. ")
			ShowCenterText2(u8("Третья строчка /med"))
			updateInputText(newgivemed3, "newgivemed3", "newgivemed3Value", uv14)
			ShowHelpMarker(" Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - '' \n Если оставить строку пустой - отыграется стандартная отыгровка. ")
			uv0.Separator()
			ShowCenterText2(u8("Отыгровка /skill"))
			updateInputText(newgiveskill1, "newgiveskill1", "newgiveskill1Value", uv14)
			ShowHelpMarker("Если оставить строку пустой - отыграется стандартная отыгровка.")
			ShowCenterText2(u8("Вторая строчка /skill"))
			updateInputText(newgiveskill2, "newgiveskill2", "newgiveskill2Value", uv14)
			ShowHelpMarker(" Если вы не нуждаетесь в этой строке, то поставьте прочерк: '' - '' \n Если оставить строку пустой - отыграется стандартная отыгровка. ")
			uv0.Separator()
			uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2)

			if uv0.Button(u8("Закрыть"), uv0.ImVec2(120, 0)) then
				uv0.CloseCurrentPopup()
			end

			uv0.EndPopup()
		end

		uv0.PopStyleColor()
	end

	if uv11[0] == 4 then
		if not uv30 then
			uv0.PushStyleVarVec2(uv0.StyleVar.WindowPadding, uv0.ImVec2(4, 4))

			slot13 = true

			uv0.BeginChild("##123656test", uv0.ImVec2(uv31 - 160, 445), slot13)
			uv0.Columns(3, "mycolumns")
			uv0.SetColumnWidth(-1, 100)
			uv0.Text(u8("Активация"))
			ShowHelpMarker(" Двойной щелчок по пункту открывает\nнастройку редактора биндера ")
			uv0.NextColumn()
			uv0.SetColumnWidth(-1, 100)
			uv0.Text(u8("Статус"))
			uv0.NextColumn()
			uv0.Text(u8("Предпросмотр:"))
			uv0.NextColumn()
			uv0.Separator()

			for slot13 = 1, uv32 do
				if uv0.Selectable(u8("Слот №") .. slot13, false, uv0.SelectableFlags.AllowDoubleClick) and uv0.IsMouseDoubleClicked(0) then
					z = slot13

					if uv33[slot13] == nil then
						uv0.OpenPopup("SetActivation")
					else
						uv0.OpenPopup("ReActivation")
					end
				end

				uv0.NextColumn()

				if uv33[slot13] ~= nil and uv33[slot13].wait ~= nil and uv33[slot13].act ~= nil then
					if change_binder == slot13 and change_binder ~= nil and change_binder ~= "" then
						uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.8, 1), u8("Ред. | Занято"))
					else
						uv0.TextColored(uv0.ImVec4(0.8, 0.7, 0.1, 1), tostring(uv33[slot13].act))

						about_bind[slot13] = true
					end
				elseif change_binder == slot13 and change_binder ~= nil and change_binder ~= "" then
					uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.8, 1), u8("Редактируется"))
				else
					uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("Cвободно"))

					about_bind[slot13] = false
				end

				uv0.NextColumn()

				if uv33[slot13] ~= nil and uv33[slot13][1] ~= nil then
					uv0.Text(tostring(uv33[slot13][1]) ~= "" and slot14 or u8("Пусто"))
				else
					uv0.Text(u8("Пусто"))
				end

				uv0.NextColumn()
			end

			if uv0.BeginPopup("ReActivation") then
				uv0.Text(u8("Выберите нужное действие для (Слот №") .. tostring(z) .. ")")
				uv0.SetCursorPosX(20)

				if uv0.Button(u8("Удалить")) then
					for slot13 = 1, 30 do
						uv33[z][slot13] = nil
					end

					uv33[z].act = nil
					uv33[z].wait = nil
					uv33[z] = nil

					uv7.save(uv33, uv34)
					uv0.CloseCurrentPopup()
				end

				uv0.SameLine()

				if uv0.Button(u8("Редактировать")) then
					change_binder = z
					is_changeact = true
					binder_text[2] = uv0.new.char[192](tostring(uv33[z].act or ""))
					binder_text[3] = uv0.new.char[16](tostring(uv33[z].wait or ""))
					binder_text[1] = uv0.new.char[1024]()

					for slot13 = 1, 30 do
						if uv33[z][slot13] == nil then
							break
						elseif slot13 == 1 then
							binder_text[1] = uv0.new.char[1024](tostring(uv33[z][slot13]))
						else
							binder_text[1] = uv0.new.char[1024](uv25.string(binder_text[1]) .. "\n" .. tostring(uv33[z][slot13]))
						end
					end

					uv30 = true

					uv0.CloseCurrentPopup()
				end

				uv0.SameLine()

				if uv0.Button(u8("Закрыть")) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			if uv0.BeginPopup("SetActivation") then
				uv0.Text(u8("Выберите нужную вам активацию для (Слот №") .. tostring(z) .. ")")
				uv0.PushItemWidth(240)
				uv0.SetCursorPosX(30)
				uv0.Combo("##124645887Test", selected_item_binder, uv35, #uv36)
				uv0.SetCursorPosX(85)

				if uv0.Button(u8("Выбрать")) then
					change_binder = z
					binder_text[1] = uv0.new.char[1024]()
					is_changeact = false

					if about_bind[z] then
						binder_text[2] = uv0.new.char[192](uv33[z].act or "")
						binder_text[3] = uv0.new.char[16](uv33[z].wait or "")

						for slot13 = 1, 30 do
							if uv33[z][slot13] == nil then
								break
							elseif slot13 == 1 then
								binder_text[1] = uv0.new.char[1024](uv33[z][slot13])
							else
								binder_text[1] = uv0.new.char[1024](uv25.string(binder_text[1]) .. "\n" .. uv33[z][slot13])
							end
						end
					else
						binder_text[2] = uv0.new.char[192]()
						binder_text[3] = uv0.new.char[16]()
					end

					uv30 = true

					uv0.CloseCurrentPopup()
				end

				uv0.SameLine()
				uv0.SetCursorPosX(155)

				if uv0.Button(u8("Закрыть")) then
					uv0.CloseCurrentPopup()
				end

				uv0.EndPopup()
			end

			if uv32 < 15 then
				uv0.Columns(1)
				uv0.Separator()
			end

			uv0.EndChild()
		end

		if uv30 then
			uv0.SameLine()
			uv0.BeginChild("notest", uv0.ImVec2(uv31 - (uv31 - 530), 450), true)

			if change_binder ~= nil and change_binder ~= "" then
				uv0.SetCursorPosY(5)
				ShowCenterTextColor(u8("Редактирование профиля биндера (Слот №" .. change_binder .. ")"), uv31 - 200, uv0.ImVec4(0.8, 0.7, 0.1, 1))
				uv0.Separator()

				if not is_changeact then
					if selected_item_binder[0] == 0 then
						uv0.SetCursorPosX(10)
						uv0.BeginChild("change", uv0.ImVec2(118, 25), true)
						uv0.SetCursorPosX(9)
						uv0.SetCursorPosY(3)
						uv0.TextColored(uv0.ImVec4(1, 1, 0.7, 1), getDownKeysText())
						ShowHelpMarker(" При залипании клавиши 'Right Button' нажмите ПКМ вне окна ")
						uv0.EndChild()
						uv0.SameLine()
						uv0.SetCursorPosY(28)
						uv0.Text(u8("Зажмите клавишу/комбинацию клавиш"))
						uv0.SameLine()

						if uv0.Button(u8("Сохранить")) then
							if getDownKeysText() ~= "None" then
								binder_text[2] = uv0.new.char[192](getDownKeysText())
								is_changeact = true
							else
								TriggerNotification("Зажмите клавишу/клавиши, после чего повторите попытку.")
							end
						end
					else
						uv0.SetCursorPosX(10)
						uv0.Text(u8("Активация: /"))
						uv0.SameLine()
						uv0.PushItemWidth(100)
						uv0.SetCursorPos(uv0.ImVec2(90, 26))
						updateInputText(binder_text[2], "активация", "", "nnhelper.ini")
						uv0.SameLine()

						if uv0.Button(u8("Сохранить")) then
							if isReservedCommand(uv25.string(binder_text[2])) then
								TriggerNotification("Введенная вами команда является зарезервированной скриптом. Придумайте другую.")
							elseif string.find(uv25.string(binder_text[2]), "/", 1, true) then
								TriggerNotification("Знак \"/\" будет прикреплен к команде позже. В данный момент он не нужен.")
							else
								is_changeact = true
								binder_text[2] = uv0.new.char[192]("/" .. uv25.string(binder_text[2]))
							end
						end
					end
				else
					uv0.SetCursorPosY(30)
					uv0.SetCursorPosX(10)
					uv0.Text(u8("Активация:"))
					uv0.SameLine()
					uv0.SetCursorPosY(30)
					uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), uv25.string(binder_text[2]))
					uv0.SameLine()
					uv0.SetCursorPosY(28)

					if uv0.Button(u8("Изменить активацию")) then
						uv0.OpenPopup("ChangeActivation")
					end
				end

				if uv0.BeginPopup("ChangeActivation") then
					uv0.Text(u8("Выберите нужную вам активацию для (Слот №") .. z .. ")")
					uv0.PushItemWidth(240)
					uv0.SetCursorPosX(30)

					slot10 = {
						"На клавишу (комбинацию клавиш)",
						"На команду (прим. /command)"
					}
					slot11 = uv0.new["const char*"][#slot10]()

					for slot15 = 1, #slot10 do
						slot11[slot15 - 1] = u8(slot10[slot15])
					end

					uv0.Combo("", selected_item_binder, slot11, #slot10)
					uv0.SetCursorPosX(85)

					if uv0.Button(u8("Выбрать")) then
						if selected_item_binder[0] == 1 and uv25.string(binder_text[2]) ~= "" then
							if string.find(uv25.string(binder_text[2]), "/", 1, true) then
								binder_text[2] = uv0.new.char[192](string.sub(uv25.string(binder_text[2]), 2))
							else
								binder_text[2] = uv0.new.char[192]("")
							end
						end

						is_changeact = false

						uv0.CloseCurrentPopup()
					end

					uv0.SameLine()
					uv0.SetCursorPosX(155)

					if uv0.Button(u8("Закрыть")) then
						uv0.CloseCurrentPopup()
					end

					uv0.EndPopup()
				end

				uv0.SetCursorPosX(10)
				uv0.Text(u8("Задержка:"))
				uv0.SameLine()
				uv0.PushItemWidth(50)
				updateInputText(binder_text[3], "ожидание", "", "nnhelper.ini")
				uv0.SameLine()
				uv0.Text(u8("сек."))
				uv0.SameLine()
				updateToggle(enterbind, "enterbind", "enterbindValue", uv8)
				uv0.SameLine()
				uv0.Text(u8("» Отправка после нажатия Enter\n\n"))
				uv0.Separator()
				ShowCenterTextColor(u8("Вводимый текст биндера (для переноса строки нажать Enter)"), uv31 - 200, uv0.ImVec4(0.8, 0.7, 0.1, 1))
				uv0.SetCursorPosX(7)
				uv0.InputTextMultiline(u8("##3"), binder_text[1], 1024, uv0.ImVec2(475, 300))
				uv0.SetCursorPosX(120)

				if uv0.Button(u8("Сохранить"), uv0.ImVec2(120, 20)) then
					if uv25.string(binder_text[3]) == "" then
						binder_text[3] = uv0.new.char[16](tostring(0))
					else
						binder_text[3] = uv0.new.char[16](uv25.string(binder_text[3]):gsub("%D", ""))
					end

					if uv25.string(binder_text[1]) == "" or uv25.string(binder_text[2]) == "" then
						TriggerNotification("Заполните все поля!")
					else
						for slot13 = 1, 30 do
							if uv33[change_binder] ~= nil then
								if uv33[change_binder][slot13] ~= nil then
									uv33[change_binder][slot13] = nil
								else
									break
								end
							else
								break
							end
						end

						slot10 = 0

						for slot14 in string.gmatch(uv25.string(binder_text[1]), "[^\r\n]+") do
							slot10 = slot10 + 1

							if uv33[change_binder] == nil then
								uv33[change_binder] = {}
							end

							uv33[change_binder][slot10] = slot14
						end

						uv33[change_binder].act = uv25.string(binder_text[2])
						uv33[change_binder].wait = uv25.string(binder_text[3])

						uv7.save(uv33, uv34)
						TriggerNotification("Данные биндера успешно сохранены!")
					end
				end

				uv0.SameLine()
				uv0.SetCursorPosX(260)

				if uv0.Button(u8("Отмена"), uv0.ImVec2(120, 20)) then
					change_binder = ""
					uv30 = false
				end
			end
		end
	end

	if uv11[0] == 5 then
		uv0.PushStyleColor(uv0.Col.ChildBg, uv0.ImVec4(0.1, 0.1, 0.1, 0.95))
		uv0.BeginChild("tab1nast31", uv0.ImVec2(175, 170), false)
		ShowCenterText2(u8("Исправления игры"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateToggleSettings(TunFix, "TunFix", "TunFixValue", 16, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» TunFix"))
		ShowHelpMarker(" Меньше бросает по стороном на авто с FT путём блокировки пакетов. ")
		uv0.SetCursorPos(uv0.ImVec2(10, 43))
		updateToggleSettings(blackroads, "blackroads", "blackroadsValue", 4, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» BlackRoads"))
		ShowHelpMarker(" Фикс черных дорог ")
		uv0.SetCursorPos(uv0.ImVec2(10, 68))
		updateToggleSettings(cleanmemory, "cleanmemory", "cleanmemoryValue", 12, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» CleanMemory"))
		ShowHelpMarker(" Автоматическая отчистка памяти игры ")
		uv0.SetCursorPos(uv0.ImVec2(10, 93))
		updateToggleSettings(forceaniso, "forceaniso", "forceanisoValue", 5, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Фикс ряби"))
		uv0.SetCursorPos(uv0.ImVec2(10, 118))
		updateToggleSettings(sunfix, "sunfix", "sunfixValue", 6, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Вернуть солнце"))
		uv0.SetCursorPos(uv0.ImVec2(10, 143))
		updateToggleSettings(waterfix, "waterfix", "waterfixValue", 3, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» WaterFix"))
		ShowHelpMarker(" Фикс квадратной воды ")
		uv0.EndChild()
		uv0.SameLine()
		uv0.BeginChild("tab1nast32", uv0.ImVec2(175, 95), false)
		ShowCenterText2(u8("Визуальная часть"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateToggleSettings(moneyborder, "moneyborder", "moneyborderValue", 18, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» MoneyBorder"))
		ShowHelpMarker(" Уменьшает обводку денег ")
		uv0.SetCursorPos(uv0.ImVec2(10, 43))
		updateToggleSettings(nocloud, "nocloud", "nocloudValue", 11, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» No Cloud"))
		ShowHelpMarker(" Отключает облака ")
		uv0.SetCursorPos(uv0.ImVec2(10, 68))
		updateToggleSettings(fixspeed, "fixspeed", "fixspeedValue", 20, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» FastSpeed"))
		ShowHelpMarker(" При включённой функции спидометр будет обновляться ежесекундно. ")
		uv0.EndChild()
		uv0.SameLine()
		uv0.BeginChild("tab1nast33", uv0.ImVec2(168, 145), false)
		ShowCenterText2(u8("Прочее"))
		uv0.SetCursorPos(uv0.ImVec2(10, 18))
		updateToggleSettings(nobirds, "nobirds", "nobirdsValue", 10, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» No Birds"))
		ShowHelpMarker(" Отключает птиц ")
		uv0.SetCursorPos(uv0.ImVec2(10, 43))
		updateToggleSettings(noexplosion, "noexplosion", "noexplosionValue", 14, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» No Explosion"))
		ShowHelpMarker(" Отключает многократный взыр вертолетов ")
		uv0.SetCursorPos(uv0.ImVec2(10, 68))
		updateToggleSettings(nodust, "nodust", "nodustValue", 13, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» No Dust"))
		ShowHelpMarker("Отключает пыль от вертолета. \n Чтобы отключить - нужно перезайти.")
		uv0.SetCursorPos(uv0.ImVec2(10, 93))
		updateToggleSettings(blockf4, "blockf4", "blockf4Value", 21, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Block F4"))
		ShowHelpMarker(" Отключает нажатие F4. \n Чтобы активировать - нужно перезайти.")
		uv0.SetCursorPos(uv0.ImVec2(10, 118))
		updateToggleSettings(opentchat, "opentchat", "opentchatValue", 22, uv8)
		uv0.SameLine(50)
		uv0.Text(u8("» Чат на T"))
		ShowHelpMarker(" Открывает чат на любой раскладке на T английскую.")
		uv0.EndChild()
		uv0.PopStyleColor()
	end

	if uv11[0] == 6 then
		uv0.Columns(2, "mycolumns")
		uv0.SetColumnWidth(-1, 190)
		uv0.Separator()
		uv0.Text(u8("Команда"))
		uv0.NextColumn()
		uv0.Text(u8("Описание"))
		uv0.NextColumn()
		uv0.Separator()

		if isPlayerSoldierMed then
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("ПКМ + G"))
			uv0.NextColumn()
			uv0.Text(u8("Меню болезней"))
			uv0.NextColumn()
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/heal [id]"))
			uv0.NextColumn()
			uv0.Text(u8("Лечение в машине скорой"))
			uv0.NextColumn()
		end

		if isPlayerSoldierPolice then
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/sured"))
			uv0.NextColumn()
			uv0.Text(u8("Изменение параметров умного розыска"))
			uv0.NextColumn()
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/ticketred"))
			uv0.NextColumn()
			uv0.Text(u8("Изменение параметров умной выдачи штрафа"))
			uv0.NextColumn()
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/meg [ID] | /mg"))
			uv0.NextColumn()
			uv0.Text(u8("Попросить водителя остановиться"))
			uv0.NextColumn()
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("ПКМ + G"))
			uv0.NextColumn()
			uv0.Text(u8("Меню взаимодействий"))
			uv0.NextColumn()
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/docs"))
			uv0.NextColumn()
			uv0.Text(u8("Шпора с уставами."))
			uv0.NextColumn()
		end

		if isPlayerSoldierMafia then
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/tie /untie"))
			uv0.NextColumn()
			uv0.Text(u8("Связать/развязать заложника"))
			uv0.NextColumn()
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/bag /unbag"))
			uv0.NextColumn()
			uv0.Text(u8("Надеть/снять мешок на голову"))
			uv0.NextColumn()
			uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/bomb"))
			uv0.NextColumn()
			uv0.Text(u8("Заложить бомбу"))
			uv0.NextColumn()
		end

		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/rd [param] [param2]"))
		uv0.NextColumn()
		uv0.Text(u8("Автодоклад в /r"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/fd [param] [param2]"))
		uv0.NextColumn()
		uv0.Text(u8("Автодоклад в /f"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/wr [id]"))
		uv0.NextColumn()
		uv0.Text(u8("Вызвать игрока в рацию"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/where [id]"))
		uv0.NextColumn()
		uv0.Text(u8("Спросить местопложение в рацию"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/ok [id]"))
		uv0.NextColumn()
		uv0.Text(u8("Принять доклад в рацию"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/dfr"))
		uv0.NextColumn()
		uv0.Text(u8("Автоматический скриншот документов"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("ПКМ + R"))
		uv0.NextColumn()
		uv0.Text(u8("Взаимодействие с игроком"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("ПКМ + 1"))
		uv0.NextColumn()
		uv0.Text(u8("Поприветствовать игрока"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/sobes [id]"))
		uv0.NextColumn()
		uv0.Text(u8("Провести собеседование"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/inv [id]"))
		uv0.NextColumn()
		uv0.Text(u8("Принять игрока"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/unv [id] [reason]"))
		uv0.NextColumn()
		uv0.Text(u8("Уволить игрока"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/drive [0/1]"))
		uv0.NextColumn()
		uv0.Text(u8("Спавн фракционных авто"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/gos"))
		uv0.NextColumn()
		uv0.Text(u8("Настройка гос.волны"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/nanim"))
		uv0.NextColumn()
		uv0.Text(u8("Анимации"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/number"))
		uv0.NextColumn()
		uv0.Text(u8("Узнать номер телефона"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/ttd"))
		uv0.NextColumn()
		uv0.Text(u8("Показ времени на экране"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/ts [text]"))
		uv0.NextColumn()
		uv0.Text(u8("Написать СМС последнему написавшему"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/ncc"))
		uv0.NextColumn()
		uv0.Text(u8("Отчистка чата"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/nbp"))
		uv0.NextColumn()
		uv0.Text(u8("Открыть BattlePass."))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/ntags"))
		uv0.NextColumn()
		uv0.Text(u8("Тэги для биндера."))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/nht [time]"))
		uv0.NextColumn()
		uv0.Text(u8("Изменить время"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/nhw [weather]"))
		uv0.NextColumn()
		uv0.Text(u8("Изменить погоду"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/nhrel"))
		uv0.NextColumn()
		uv0.Text(u8("Перезагрузка скрипта"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/nhrec"))
		uv0.NextColumn()
		uv0.Text(u8("Реконнект"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/hist [id]"))
		uv0.NextColumn()
		uv0.Text(u8("История ников по ID"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/drone"))
		uv0.NextColumn()
		uv0.Text(u8("Дрон"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/rep [text]"))
		uv0.NextColumn()
		uv0.Text(u8("Быстрая жалоба"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/findhouse [id]"))
		uv0.NextColumn()
		uv0.Text(u8("Поиск дома по номеру"))
		uv0.NextColumn()
		uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), u8("/nid [id]"))
		uv0.NextColumn()
		uv0.Text(u8("Новый /id"))
		uv0.NextColumn()
	end

	if uv11[0] == 7 then
		uv0.Text(u8("Организация:"))
		updateOrgButtons({
			"None",
			"Mafia",
			"MassMedia",
			"Ministry of the Interior",
			"Ghetto",
			"Government",
			"Ministry of Health",
			"Ministry of Defence"
		}, "horg", "horgValue", uv37)
		uv0.Text(u8("\nРанг:"))
		updateNumberButtons(hrang, 0, 10, "hrang", "hrangValue", uv38)
		uv0.PushItemWidth(115)
		uv0.Text(u8("\nНомер телефона:"))
		uv0.SameLine(140)
		uv0.Text(u8("\nНомер аккаунта:"))
		updateInputAutho(hnumberphone, "hnumberphone", "hnumberphoneValue", uv37)
		uv0.SameLine(140)
		updateInputAutho(hnumberacc, "hnumberacc", "hnumberaccValue", uv37)
	end

	uv0.PopFont()
	uv0.EndChild()
	uv0.End()
end)
slot178 = slot2.OnFrame(function ()
	return uv0.animlist[0]
end, function (slot0)
	uv0.PushFont(uv1)
	uv0.SetNextWindowSize(uv0.ImVec2(363, 178), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 1.2, uv3 / 1.2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.Begin(u8("Список анимаций"), uv4.animlist, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)
	drawToggleButtons()
	uv0.Separator()
	uv0.SetCursorPosX((uv0.GetWindowWidth() - 120) / 2.1)

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(140, 22)) then
		uv4.animlist[0] = not uv4.animlist[0]
		uv0.Process = uv4.animlist[0]
	end

	uv0.PopFont()
	uv0.End()
end)
slot179 = 0
slot180 = 0
slot181 = 0
slot182 = false
slot183 = false
slot184 = 1
slot185 = 8
slot186 = {}

DrawNotificationBackground = function(slot0, slot1, slot2, slot3, slot4)
	slot0:AddRectFilled(slot1, uv0.ImVec2(slot1.x + slot2.x, slot1.y + slot2.y), uv0.ColorConvertFloat4ToU32(uv0.ImVec4(0.1, 0.1, 0.1, slot4 * 0.9)), slot3)

	slot6, slot7 = ({
		SetStyle,
		SetStyle2,
		SetStyle3
	})[uv1.cfgGen.themes + 1]()
	slot8 = uv0.ColorConvertFloat4ToU32(slot6[slot7.Button])
	slot9 = 5
	slot12 = 15
	slot13 = (slot2.x - 2 * slot12) * math.sin(os.clock() % slot9 / slot9 * math.pi)
	slot14 = 3
	slot15 = uv0.ImVec2(slot1.x + slot12 + (slot2.x - 2 * slot12 - slot13) / 2, slot1.y)

	slot0:AddRectFilled(slot15, uv0.ImVec2(slot15.x + slot13, slot1.y + slot14), slot8, slot3)

	slot16 = uv0.ImVec2(slot1.x + slot12 + (slot2.x - 2 * slot12 - slot13) / 2, slot1.y + slot2.y - slot14)

	slot0:AddRectFilled(slot16, uv0.ImVec2(slot16.x + slot13, slot1.y + slot2.y), slot8, slot3)
end

slot187 = slot2.OnFrame(function ()
	return uv0.notify[0]
end, function (slot0)
	uv0.PushStyleVarFloat(uv0.StyleVar.WindowBorderSize, 0)
	uv0.PushStyleVarVec2(uv0.StyleVar.WindowPadding, uv0.ImVec2(0, 0))
	uv0.PushStyleColor(uv0.Col.WindowBg, uv0.ImVec4(0, 0, 0, 0))
	uv0.PushFont(InfomainFont)

	slot0.HideCursor = true
	slot1 = 15

	if uv1 then
		slot2 = math.min(1, uv2 / uv3)
		uv4 = slot2
		uv2 = uv2 + uv0.GetIO().DeltaTime

		if slot2 >= 1 then
			uv1 = false
			uv5 = 0
		end
	end

	if uv6 then
		slot2 = math.min(1, uv5 / uv3)
		uv4 = 1 - slot2
		uv5 = uv5 + uv0.GetIO().DeltaTime

		if slot2 >= 1 then
			uv7.notify[0] = false
			uv6 = false
			uv4 = 0
			uv5 = 0
			uv8 = {}
		end
	end

	if not uv1 and not uv6 then
		uv5 = uv5 + uv0.GetIO().DeltaTime

		if uv9 <= uv5 then
			uv6 = true
			uv5 = 0
		end
	end

	slot2 = 0
	slot3 = 0

	for slot7, slot8 in ipairs(uv8) do
		slot9 = uv0.CalcTextSize(u8(slot8))
		slot2 = math.max(slot2, slot9.x)
		slot3 = slot3 + slot9.y + 5
	end

	uv0.SetNextWindowPos(uv0.ImVec2(uv10 / 2, uv11 / 1.1), uv0.Cond.Always, uv0.ImVec2(0.5, 0.5))
	uv0.SetNextWindowSize(uv0.ImVec2(slot2 + 35, slot3 + 20), uv0.Cond.Always)

	if uv0.Begin("##NotifyWindow", uv7.notify, uv0.WindowFlags.NoDecoration + uv0.WindowFlags.NoInputs) then
		slot13 = slot1
		slot14 = uv4

		DrawNotificationBackground(uv0.GetWindowDrawList(), uv0.GetWindowPos(), uv0.GetWindowSize(), slot13, slot14)

		slot9 = 10

		for slot13, slot14 in ipairs(uv8) do
			uv0.SetCursorPosX(15)
			uv0.SetCursorPosY(slot9)
			uv0.Text(u8(slot14))

			slot9 = slot9 + uv0.CalcTextSize(u8(slot14)).y + 5
		end
	end

	uv0.End()
	uv0.PopFont()
	uv0.PopStyleColor()
	uv0.PopStyleVar(2)
end)
slot188 = slot2.new.char[65536]()
slot189 = slot2.OnFrame(function ()
	return uv0.vipstats[0]
end, function (slot0)
	uv0.PushFont(uv1)
	uv0.SetNextWindowSize(uv0.ImVec2(350, 230), uv0.Cond.FirstUseEver)
	uv0.SetNextWindowPos(uv0.ImVec2(uv2 / 2, uv3 / 2), uv0.Cond.FirstUseEver, uv0.ImVec2(0.5, 0.5))
	uv0.Begin(u8("Статистика пользователей"), uv4.vipstats, uv0.WindowFlags.NoResize + uv0.WindowFlags.NoCollapse + uv0.WindowFlags.NoTitleBar)

	slot1 = u8:decode(uv5.string(uv6))

	uv0.PushItemWidth(190)

	if uv0.InputText(u8("» Введите ник или ID"), uv6, 65536) then
		if tonumber(uv5.string(uv6)) ~= nil then
			uv5.copy(uv6, u8:encode(sampGetPlayerNickname(tonumber(slot2))))
		else
			slot1 = slot2
		end
	end

	uv0.Separator()
	ShowCenterText2(u8(statsresponse))
	uv0.SetCursorPosY(185)
	uv0.Separator()
	uv0.SetCursorPosX((uv0.GetWindowWidth() - 285) / 2.1)

	if uv0.Button(u8("Поиск"), uv0.ImVec2(140, 30)) then
		async_http_request("POST", "https://hora.su/getvipstat.php", {
			data = "srv=" .. srv .. "&n=" .. slot1,
			headers = {
				["content-type"] = "application/x-www-form-urlencoded"
			}
		}, function (slot0)
			statsresponse = slot0.text
		end, function (slot0)
			print("getvipstat: " .. slot0)
		end)
	end

	uv0.SameLine()

	if uv0.Button(u8("Закрыть"), uv0.ImVec2(140, 30)) then
		uv4.vipstats[0] = not uv4.vipstats[0]
		uv0.Process = uv4.vipstats[0]
	end

	uv0.PopFont()
	uv0.End()
end)

TriggerNotification = function(slot0)
	addOneOffSound(0, 0, 0, 1055)
	table.insert(uv0, 1, slot0)

	if #uv0 > 3 then
		table.remove(uv0, 4)
	end

	current_text2 = slot0
	uv1.notify[0] = true
	uv2 = 0
	uv3 = 0
	uv4 = 0
	uv5 = true
	uv6 = false
end

drawToggleButtons = function()
	for slot3, slot4 in ipairs(uv0) do
		if uv1.Button(u8(slot4.name), uv1.ImVec2(170, 30)) then
			uv2[slot4.id] = not uv2[slot4.id]

			if slot4.library ~= "PED" then
				requestAnimation(slot4.library)
				loadAllModelsNow()
			end

			taskPlayAnim(PLAYER_PED, slot4.anim, slot4.library, 4, false, 0, 0, true, -1)

			uv3 = true

			if slot4.library ~= "PED" then
				removeAnimation(slot4.anim)
			end
		end

		if slot3 % 2 == 1 then
			uv1.SameLine()
		end
	end
end

slot5.onApplyPlayerAnimation = function(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	if uv0 and (slot1 == "PED" and slot2 == "IDLE_chat" or slot1 == "CARRY" and slot2 == "crry_prtial") then
		return false
	end
end

updateToggleSettings = function(slot0, slot1, slot2, slot3, slot4)
	if uv0.ToggleButton(u8("##") .. slot1, slot0) then
		uv1.cfgButton[slot1] = slot0[0]
		_G[slot2] = slot0[0]

		set_dist(slot3, slot0[0])
		uv2.save(uv1, slot4)
	end
end

updateToggle = function(slot0, slot1, slot2, slot3)
	if uv0.ToggleButton(u8("##") .. slot1, slot0) then
		uv1.cfgButton[slot1] = slot0[0]
		_G[slot2] = slot0[0]

		uv2.save(uv1, slot3)
	end
end

updateNumberButtons = function(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = uv0.GetStyle().Colors
	slot8 = uv0.Col

	for slot12 = slot1, slot2 do
		if slot1 < slot12 then
			uv0.SameLine()
		end

		if tonumber(uv1.cfgauto[slot3]) == slot12 then
			uv0.PushStyleColor(slot8.Button, slot7[slot8.ButtonActive])
			uv0.PushStyleColor(slot8.ButtonHovered, slot7[slot8.ButtonActive])
			uv0.PushStyleColor(slot8.ButtonActive, slot7[slot8.ButtonActive])
		end

		if uv0.Button(u8(tostring(slot12)), uv0.ImVec2(41, 25)) then
			slot0[0] = slot12
			uv1.cfgauto[slot3] = tostring(slot12)
			_G[slot4] = slot12
			nasosal_rang = slot12

			uv2.save(uv1, uv3)
		end

		if slot13 then
			uv0.PopStyleColor(3)
		end
	end
end

updateOrgButtons = function(slot0, slot1, slot2, slot3)
	slot5 = uv0.GetStyle().Colors
	slot6 = uv0.Col
	slot7 = uv1.cfgauto[slot1] or ""
	slot8 = 4
	slot9 = {
		["Ministry of Defence"] = {
			udorg = "Мин.Обороны",
			flag = "isPlayerSoldier",
			status = u8("HA for MoD")
		},
		["Ministry of Health"] = {
			udorg = "Мин.Здравоохранения",
			flag = "isPlayerSoldierMed",
			status = u8("HA for MoH")
		},
		["Ministry of the Interior"] = {
			udorg = "Мин.Внутренних Дел",
			flag = "isPlayerSoldierPolice",
			status = u8("HA for MIA")
		},
		Government = {
			udorg = "Правительство",
			flag = "isPlayerGoverment",
			status = u8("HA for Gov")
		},
		MassMedia = {
			udorg = "Мин. связи и коммуникаций",
			flag = "isPlayerMassMedia",
			status = u8("HA for MM")
		},
		Mafia = {
			flag = "isPlayerSoldierMafia",
			status = u8("HA Mafia")
		},
		Ghetto = {
			flag = "isPlayerSoldierGhetto",
			status = u8("HA Ghetto")
		},
		None = {
			udorg = "None",
			status = u8("NN Basic")
		}
	}

	for slot14, slot15 in ipairs({
		"isPlayerSoldier",
		"isPlayerSoldierMed",
		"isPlayerSoldierPolice",
		"isPlayerGoverment",
		"isPlayerMassMedia",
		"isPlayerSoldierMafia",
		"isPlayerSoldierGhetto"
	}) do
		_G[slot15] = false
	end

	for slot14, slot15 in ipairs(slot0) do
		if slot14 > 1 and (slot14 - 1) % slot8 ~= 0 then
			uv0.SameLine()
		end

		if slot7 == slot15 then
			uv0.PushStyleColor(slot6.Button, slot5[slot6.ButtonActive])
			uv0.PushStyleColor(slot6.ButtonHovered, slot5[slot6.ButtonActive])
			uv0.PushStyleColor(slot6.ButtonActive, slot5[slot6.ButtonActive])
		end

		slot17 = nil

		if uv0.Button(u8(slot15), (slot14 ~= 4 and slot14 ~= 8 or uv0.ImVec2(150, 25)) and uv0.ImVec2(120, 25)) then
			uv1.cfgauto[slot1] = slot15
			_G[slot2] = slot15
			slot18 = slot9[slot15] or slot9.None
			statusscriptra = slot18.status or u8("NN Basic")
			uv2 = slot18.udorg or "None"
			ScriptUse = slot18.flag and 1 or 0

			if slot18.flag then
				_G[slot18.flag] = true
			end

			uv3.save(uv1, uv4)
		end

		if slot16 then
			uv0.PopStyleColor(3)
		end
	end
end

updateInputText = function(slot0, slot1, slot2, slot3, slot4)
	if uv0.InputText(u8("## ") .. slot1, slot0, slot4 or 256) then
		if slot3 == uv1 then
			uv2.cfgGen[slot1] = uv3.string(slot0)
			_G[slot2] = uv3.string(slot0)

			uv4.save(uv2, uv1)
		else
			cfg.cfg[slot1] = uv3.string(slot0)
			_G[slot2] = uv3.string(slot0)

			uv4.save(uv5, slot3)
		end
	end
end

updateInputAutho = function(slot0, slot1, slot2, slot3)
	if uv0.InputText(u8("## ") .. slot1, slot0, 16, uv0.InputTextFlags.CharsDecimal) then
		if #uv1.string(slot0):gsub("%D", "") > 15 then
			slot4 = slot4.sub(slot4, 1, 15)
		end

		uv1.fill(slot0, 16)
		uv1.copy(slot0, slot4)

		uv2.cfgauto[slot1] = slot4
		_G[slot2] = tonumber(slot4) or slot4

		if slot1 == "hnumberacc" then
			playerAccoutNumber = tonumber(slot4) or 0
		elseif slot1 == "hnumberphone" then
			uv3 = tonumber(slot4) or 0
		elseif slot1 == "hrang" then
			nasosal_rang = tonumber(slot4) or 0
		end

		uv4.save(uv2, uv5)
	end
end

updateInputPass = function(slot0, slot1, slot2, slot3)
	if uv0.InputText(u8("## ") .. slot1, slot0, 256, uv0.InputTextFlags.Password) then
		uv1.cfgpass[slot1] = uv2.string(slot0)
		_G[slot2] = uv2.string(slot0)

		uv3.save(uv1, uv4)
	end
end

EmulShowNameTag = function(slot0, slot1)
	slot2 = raknetNewBitStream()

	raknetBitStreamWriteInt16(slot2, slot0)
	raknetBitStreamWriteBool(slot2, slot1)
	raknetEmulRpcReceiveBitStream(80, slot2)
	raknetDeleteBitStream(slot2)
end

onHotKey = function(slot0, slot1)
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() or uv0.m_w_s[0] or uv0.edit[0] or uv0.binder_window[0] or uv0.smartsu[0] or uv0.smartsu_active[0] or uv0.smartticket[0] or uv0.vipinfo[0] or uv0.smartticket_active[0] or droneActive or uv0.menu[0] or uv0.makegun[0] or uv0.window_med[0] or uv0.window_pol[0] or uv0.zametki[0] or uv0.tegi[0] or uv0.gos[0] or uv0.winsobes[0] then
		return false
	end

	for slot5, slot6 in pairs(mass_bind) do
		if sKeys == tostring(table.concat(pValue, " ")) then
			rcmd(nil, slot6.text, slot6.delay)
		end
	end
end

onWindowMessage = function(slot0, slot1, slot2)
	if slot1 == uv0.VK_ESCAPE then
		for slot6, slot7 in pairs(uv1) do
			if slot6 ~= "main_window_state" and slot7[0] and type(slot7) == "cdata" then
				consumeWindowMessage(true, true)

				slot7[0] = false
				uv2.Process = slot7[0]
			end
		end
	end
end

executeIndependentScript = function(slot0)
	if io.open(uv0, "w") then
		slot1.write(slot1, slot0)
		slot1.close(slot1)
	end
end

onSystemMessage = function(slot0, slot1, slot2)
	if slot0.find(slot0, "helper%.lua?:%d+:.+") and slot1 == 3 then
		sampShowDialog(252, "—то-то пошло не так", [[
{FFFFFF}Џроизошла непредусмотреннаЯ ошибка в скрипте {00BFFF}€мЯ вашего скрипта{FFFFFF}.
…сли даннаЯ ошибка повторЯетсЯ отправьте скриншот данного окна в ‚Љ создателЯ {00BFFF}vk.com/‘сылка на вк{FFFFFF}

]] .. slot0, "‡акрыть", _, 0)
	end
end

onScriptTerminate = function(slot0, slot1)
	if slot0 == thisScript() then
		AddChatMessage("HorAssist остановился. Для перезагрузки скрипта нажмите CTRL + R.")
		showCursor(false)

		if slot1 == false and droneActive then
			restoreCameraJumpcut()
			setCameraBehindPlayer()

			flymode = 0
			droneActive = false
		end
	end

	if slot0 == thisScript() and uv0 then
		removeBlip(uv0)
	end

	setInfraredVision(false)
	setNightVision(false)
end

slot5.onPlayerChatBubble = function(slot0, slot1, slot2, slot3, slot4)
	if droneActive and developMode == 1 then
		return {
			slot0,
			slot1,
			1488,
			slot3,
			slot4
		}
	end
end

slot5.onShowDialog = function(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0 == 224 and slot2.find(slot2, "Публикация объявления") and editValue then
		uv0 = slot5:match("Отправитель:%s+([^\n]+)")
		uv1 = slot5:match("Текст:%s+([^\n]+)"):gsub("{%x%x%x%x%x%x}", "")
		uv2 = uv1
		uv3 = true

		return false
	end

	if uv4 and slot2.find(slot2, "Меню игрока") then
		sampSendDialogResponse(slot0, 1, 7, -1)

		uv4 = false

		return false
	end

	if slot2.find(slot2, "Точное время") and timecoutValue then
		slot6, slot7 = slot5.match(slot5, "Время в игре сегодня:\t\t{ffcc00}(%d+) ч (%d+) мин")
		slot8, slot9 = slot5.match(slot5, "AFK за сегодня:\t\t{FF7000}(%d+) ч (%d+) мин")
		slot11, slot12 = slot5.match(slot5, "Текущее время:\t\t{3399FF}(%d+):(%d+)")
		slot13 = 20 - slot5.match(slot5, "Время в игре за час:\t\t{FF9999}(%d+) мин")
		slot14 = slot6 - slot8

		if string.find(slot7 - slot9, "-") then
			slot15 = slot15 + 60
			slot14 = slot14 - 1
		end

		slot16 = 60 - slot12

		if timeinfValue then
			if tonumber(slot10) <= 20 then
				TriggerNotification("Чтобы получить зарплату отыграйте ещё " .. slot13 .. " мин. | До зарплаты: " .. slot16 .. " мин.")
			else
				TriggerNotification("До зарплаты: " .. slot16 .. " мин.")
			end
		end

		AddChatMessage("Чистый онлайн: " .. slot14 .. " ч " .. slot15 .. "мин.")
	end

	if slot0 == 265 and debtorsellValue and slot2.find(slot2, "Акт (.+)") then
		debtorsellon = true
	end

	if slot0 == 101 and autobuyValue and uv5 and uv6 and not uv7 then
		sampSendDialogResponse(101, 1, 3, nil)
	end

	if slot0 == 0 and slot2.find(slot2, "Информация") then
		uv8 = slot5.match(slot5, "{FFFFFF}Ник: {66ccff}([^\n]*)")
		uv9 = slot5.match(slot5, "{FFFFFF}Телефон: {66ccff}(.*)")
		uv10 = uv8
		uv11 = uv9

		booksend()
	end

	if slot0 == 101 and autobuyValue and uv5 and uv12 and not uv7 then
		sampSendDialogResponse(101, 1, 10, nil)

		uv6 = false
	end

	if regAcc and slot2.find(slot2, "Меню игрока") then
		sampSendDialogResponse(slot0, 1, 11, -1)

		return false
	end

	if regAcc and slot2.find(slot2, "Донат |") then
		sampSendDialogResponse(slot0, 1, 0, -1)

		return false
	end

	if regAcc and slot2.find(slot2, "Донат") then
		playerAccoutNumber = tostring(slot5.match(slot5, "Номер аккаунта:\t(.*)\nТекущее"))

		if playerAccoutNumber ~= nil then
			regAcc = false
			ScriptUse = 5

			return false
		else
			ScriptUse = 4

			return false
		end
	end

	if scriptonl and newfindValue and (slot2:match("{.+}В подразделении {.+}.+ чел%. {.+}%(онлайн (%d+)%)") or slot2:match("{.+}В организации {.+}.+ чел%. {.+}%(онлайн (%d+)%)")) ~= nil then
		uv13.menu[0] = true
		uv14.online = tonumber(slot6)
		slot7 = jopa(slot5, "\n")

		table.remove(slot7, 1)

		for slot11, slot12 in pairs(slot7) do
			if slot12 ~= nil and slot12.len(slot12) > 0 then
				slot13 = jopa(slot12, "\t")
				slot14, slot15 = slot13[2]:match("(%d+) ранг%. (.+)")
				slot16, slot17 = slot13[1]:match("%d+%. (.+)%[(%d+)%]")
				slot18 = ""

				if slot13[4] ~= nil and slot13[4]:len() > 0 then
					if slot13[4]:match("На паузе (.+)") ~= nil then
						slot18 = string.format("A: %s", slot19)
						uv14.afk = uv14.afk + 1
					end

					if slot13[4]:match("В тюрьме (.+)") ~= nil then
						slot18 = string.format("J: %s", slot19)
						uv14.jail = uv14.jail + 1
					end

					if slot13[4]:match("в тюрьме (.+)") ~= nil then
						slot18 = string.format("J: %s", slot19)
						uv14.jail = uv14.jail + 1
					end

					if slot13[4]:match("затычка (.+)") ~= nil then
						slot18 = string.format("M: %s", slot19)
						uv14.mute = uv14.mute + 1
					end

					if slot13[4]:match("Затычка (.+)") ~= nil then
						slot18 = string.format("M: %s", slot19)
						uv14.mute = uv14.mute + 1
					end
				end

				table.insert(uv14.players, {
					dist = "Неизвестно",
					id = tonumber(slot17),
					name = slot16,
					phone = slot13[3],
					additional = slot18,
					rang = {
						level = tonumber(slot14),
						name = slot15
					}
				})
			end
		end

		sampSendDialogResponse(slot0, 0, 0, "")

		return false
	end

	if slot2.find(slot2, "Авторизация") and slot5.find(slot5, "Добро пожаловать") and autologinValue and uv15 then
		sampSendDialogResponse(slot0, 1, 65535, u8:decode(autopassValue))
		TriggerNotification("Установленный вами пароль был автоматически введен.")

		uv15 = false
		offMask = true

		return false
	end

	if regDialogOpen and slot2.find(slot2, "Меню игрока") then
		sampSendDialogResponse(slot0, 1, 0, -1)

		return false
	elseif regDialogOpen and slot2.find(slot2, "Статистика игрока") then
		org = slot5.match(slot5, "Организация:%s+(.-)%c")
		rabota = slot5.match(slot5, "Работа:%s+(.-)%c")
		uv16 = slot5.match(slot5, "Номер телефона:\t\t{66c2ff}(.*)\n")

		if org ~= nil then
			nasosal_rang = tonumber(slot5:match("Ранг:\t\t\t\t{cc66ff}(%d+)"))

			if org:find("Министерство обороны") then
				org = "Ministry of Defence"
				uv17 = "Мин.Обороны"
				statusscriptra = u8("HA for MoD")
				ScriptUse = 1
				isPlayerSoldier = true
			elseif org:find("Министерство здравоохранения") then
				org = "Ministry of Health"
				uv17 = "Мин.Здравоохранения"
				statusscriptra = u8("HA for MoH")
				ScriptUse = 1
				isPlayerSoldierMed = true
			elseif org:find("Министерство внутренних дел") then
				org = "Ministry of the Interior"
				uv17 = "Мин.Внутренних Дел"
				statusscriptra = u8("HA for MIA")
				ScriptUse = 1
				isPlayerSoldierPolice = true
			elseif org:find("Правительство") then
				org = "Government"
				uv17 = "Правительство"
				statusscriptra = u8("HA for Gov")
				ScriptUse = 1
				isPlayerGoverment = true
			elseif org:find("Мин. связи и коммуникаций") or org:find("Средства Массовой Информации") or org:find("Средства массовой информации") or org:find("ТВ и радио") then
				org = "MassMedia"
				uv17 = "Мин. связи и коммуникаций"
				statusscriptra = u8("HA for MM")
				ScriptUse = 1
				isPlayerMassMedia = true
			elseif org:find("Русская мафия") or org:find("Yakuza") or org:find("La Cosa Nostra") then
				org = "Mafia"
				statusscriptra = u8("HA Mafia")
				ScriptUse = 1
				isPlayerSoldierMafia = true
			elseif org:find("The Ballas") or org:find("Varios Los Aztecas") or org:find("The Rifa") or org:find("Los Santos Vagos") or org:find("Grove Street") then
				org = "Ghetto"
				statusscriptra = u8("HA Ghetto")
				ScriptUse = 1
				isPlayerSoldierGhetto = true
			elseif org:find("Нет") then
				if nasosal_rang == nil then
					nasosal_rang = 0
				end

				org = "None"
				statusscriptra = u8("NN Basic")
				ScriptUse = 0
				isPlayerSoldier = false
				isPlayerSoldierMed = false
				isPlayerSoldierPolice = false

				if mycolornika == 4294927974.0 then
					isPlayerSoldierMed = true
					statusscriptra = u8("HA for Ministry of Health")
				elseif mycolornika == 4288243251.0 then
					isPlayerSoldier = true
					statusscriptra = u8("HA for Ministry of Defence")
				elseif mycolornika == 4284901119.0 or mycolornika == 4291559679.0 or mycolornika == 4278242559.0 or mycolornika == 4278229248.0 or mycolornika == 4294954240.0 then
					isPlayerSoldierGhetto = true
					statusscriptra = u8("HA for Ghetto")
				elseif mycolornika == 4288230246.0 or mycolornika == 4290445312.0 or mycolornika == 4278220149.0 then
					isPlayerSoldierMafia = true
					statusscriptra = u8("HA for Mafia")
				elseif mycolornika == 4278190335.0 then
					isPlayerSoldierPolice = true
					statusscriptra = u8("HA for Ministry of the Interior")
				end
			else
				if nasosal_rang == nil then
					nasosal_rang = 0
				end

				org = "Other"
				statusscriptra = u8("NN Basic")
				ScriptUse = 0
				isPlayerSoldier = false
				isPlayerSoldierPolice = false
				isPlayerSoldierMed = false

				if mycolornika == 4294927974.0 then
					isPlayerSoldierMed = true
					statusscriptra = u8("HA for Ministry of Health")
				elseif mycolornika == 4288243251.0 then
					isPlayerSoldier = true
					statusscriptra = u8("HA for Ministry of Defence")
				elseif mycolornika == 4284901119.0 or mycolornika == 4291559679.0 or mycolornika == 4278242559.0 or mycolornika == 4278229248.0 or mycolornika == 4294954240.0 then
					isPlayerSoldierGhetto = true
					statusscriptra = u8("HA for Ghetto")
				elseif mycolornika == 4288230246.0 or mycolornika == 4290445312.0 or mycolornika == 4278220149.0 then
					isPlayerSoldierMafia = true
					statusscriptra = u8("HA for Mafia")
				elseif mycolornika == 4278190335.0 then
					isPlayerSoldierPolice = true
					statusscriptra = u8("HA for Ministry of the Interior")
				end
			end
		end

		regDialogOpen = false

		if rabota:find("Безработный") then
			RABotyaga = false
		else
			RABotyaga = true
		end

		return false
	end

	lua_thread.create(function ()
		if otchet1 and uv0:find("Меню игрока") then
			sampSendDialogResponse(uv1, 1, 0, -1)

			return false
		elseif otchet1 and uv0:find("Статистика игрока") then
			wait(100)
			makeScreenshot()
			sampCloseCurrentDialogWithButton(1)
			wait(500)

			otchet1 = false
		end
	end)
end

calculateZone = function(slot0, slot1, slot2)
	for slot7, slot8 in ipairs({
		{
			"Avispa Country Club",
			-2667.81,
			-302.135,
			-28.831,
			-2646.4,
			-262.32,
			71.169
		},
		{
			"Easter Bay Airport",
			-1315.42,
			-405.388,
			15.406,
			-1264.4,
			-209.543,
			25.406
		},
		{
			"Avispa Country Club",
			-2550.04,
			-355.493,
			0,
			-2470.04,
			-318.493,
			39.7
		},
		{
			"Easter Bay Airport",
			-1490.33,
			-209.543,
			15.406,
			-1264.4,
			-148.388,
			25.406
		},
		{
			"Garcia",
			-2395.14,
			-222.589,
			-5.3,
			-2354.09,
			-204.792,
			200
		},
		{
			"Shady Cabin",
			-1632.83,
			-2263.44,
			-3,
			-1601.33,
			-2231.79,
			200
		},
		{
			"East Los Santos",
			2381.68,
			-1494.03,
			-89.084,
			2421.03,
			-1454.35,
			110.916
		},
		{
			"LVA Freight Depot",
			1236.63,
			1163.41,
			-89.084,
			1277.05,
			1203.28,
			110.916
		},
		{
			"Blackfield Intersection",
			1277.05,
			1044.69,
			-89.084,
			1315.35,
			1087.63,
			110.916
		},
		{
			"Avispa Country Club",
			-2470.04,
			-355.493,
			0,
			-2270.04,
			-318.493,
			46.1
		},
		{
			"Temple",
			1252.33,
			-926.999,
			-89.084,
			1357,
			-910.17,
			110.916
		},
		{
			"Unity Station",
			1692.62,
			-1971.8,
			-20.492,
			1812.62,
			-1932.8,
			79.508
		},
		{
			"LVA Freight Depot",
			1315.35,
			1044.69,
			-89.084,
			1375.6,
			1087.63,
			110.916
		},
		{
			"Los Flores",
			2581.73,
			-1454.35,
			-89.084,
			2632.83,
			-1393.42,
			110.916
		},
		{
			"Starfish Casino",
			2437.39,
			1858.1,
			-39.084,
			2495.09,
			1970.85,
			60.916
		},
		{
			"Easter Bay Chemicals",
			-1132.82,
			-787.391,
			0,
			-956.476,
			-768.027,
			200
		},
		{
			"Downtown Los Santos",
			1370.85,
			-1170.87,
			-89.084,
			1463.9,
			-1130.85,
			110.916
		},
		{
			"Esplanade East",
			-1620.3,
			1176.52,
			-4.5,
			-1580.01,
			1274.26,
			200
		},
		{
			"Market Station",
			787.461,
			-1410.93,
			-34.126,
			866.009,
			-1310.21,
			65.874
		},
		{
			"Linden Station",
			2811.25,
			1229.59,
			-39.594,
			2861.25,
			1407.59,
			60.406
		},
		{
			"Montgomery Intersection",
			1582.44,
			347.457,
			0,
			1664.62,
			401.75,
			200
		},
		{
			"Frederick Bridge",
			2759.25,
			296.501,
			0,
			2774.25,
			594.757,
			200
		},
		{
			"Yellow Bell Station",
			1377.48,
			2600.43,
			-21.926,
			1492.45,
			2687.36,
			78.074
		},
		{
			"Downtown Los Santos",
			1507.51,
			-1385.21,
			110.916,
			1582.55,
			-1325.31,
			335.916
		},
		{
			"Jefferson",
			2185.33,
			-1210.74,
			-89.084,
			2281.45,
			-1154.59,
			110.916
		},
		{
			"Mulholland",
			1318.13,
			-910.17,
			-89.084,
			1357,
			-768.027,
			110.916
		},
		{
			"Avispa Country Club",
			-2361.51,
			-417.199,
			0,
			-2270.04,
			-355.493,
			200
		},
		{
			"Jefferson",
			1996.91,
			-1449.67,
			-89.084,
			2056.86,
			-1350.72,
			110.916
		},
		{
			"Julius Thruway West",
			1236.63,
			2142.86,
			-89.084,
			1297.47,
			2243.23,
			110.916
		},
		{
			"Jefferson",
			2124.66,
			-1494.03,
			-89.084,
			2266.21,
			-1449.67,
			110.916
		},
		{
			"Julius Thruway North",
			1848.4,
			2478.49,
			-89.084,
			1938.8,
			2553.49,
			110.916
		},
		{
			"Rodeo",
			422.68,
			-1570.2,
			-89.084,
			466.223,
			-1406.05,
			110.916
		},
		{
			"Cranberry Station",
			-2007.83,
			56.306,
			0,
			-1922,
			224.782,
			100
		},
		{
			"Downtown Los Santos",
			1391.05,
			-1026.33,
			-89.084,
			1463.9,
			-926.999,
			110.916
		},
		{
			"Redsands West",
			1704.59,
			2243.23,
			-89.084,
			1777.39,
			2342.83,
			110.916
		},
		{
			"Little Mexico",
			1758.9,
			-1722.26,
			-89.084,
			1812.62,
			-1577.59,
			110.916
		},
		{
			"Blackfield Intersection",
			1375.6,
			823.228,
			-89.084,
			1457.39,
			919.447,
			110.916
		},
		{
			"Los Santos International",
			1974.63,
			-2394.33,
			-39.084,
			2089,
			-2256.59,
			60.916
		},
		{
			"Beacon Hill",
			-399.633,
			-1075.52,
			-1.489,
			-319.033,
			-977.516,
			198.511
		},
		{
			"Rodeo",
			334.503,
			-1501.95,
			-89.084,
			422.68,
			-1406.05,
			110.916
		},
		{
			"Richman",
			225.165,
			-1369.62,
			-89.084,
			334.503,
			-1292.07,
			110.916
		},
		{
			"Downtown Los Santos",
			1724.76,
			-1250.9,
			-89.084,
			1812.62,
			-1150.87,
			110.916
		},
		{
			"The Strip",
			2027.4,
			1703.23,
			-89.084,
			2137.4,
			1783.23,
			110.916
		},
		{
			"Downtown Los Santos",
			1378.33,
			-1130.85,
			-89.084,
			1463.9,
			-1026.33,
			110.916
		},
		{
			"Blackfield Intersection",
			1197.39,
			1044.69,
			-89.084,
			1277.05,
			1163.39,
			110.916
		},
		{
			"Conference Center",
			1073.22,
			-1842.27,
			-89.084,
			1323.9,
			-1804.21,
			110.916
		},
		{
			"Montgomery",
			1451.4,
			347.457,
			-6.1,
			1582.44,
			420.802,
			200
		},
		{
			"Foster Valley",
			-2270.04,
			-430.276,
			-1.2,
			-2178.69,
			-324.114,
			200
		},
		{
			"Blackfield Chapel",
			1325.6,
			596.349,
			-89.084,
			1375.6,
			795.01,
			110.916
		},
		{
			"Los Santos International",
			2051.63,
			-2597.26,
			-39.084,
			2152.45,
			-2394.33,
			60.916
		},
		{
			"Mulholland",
			1096.47,
			-910.17,
			-89.084,
			1169.13,
			-768.027,
			110.916
		},
		{
			"Yellow Bell Gol Course",
			1457.46,
			2723.23,
			-89.084,
			1534.56,
			2863.23,
			110.916
		},
		{
			"The Strip",
			2027.4,
			1783.23,
			-89.084,
			2162.39,
			1863.23,
			110.916
		},
		{
			"Jefferson",
			2056.86,
			-1210.74,
			-89.084,
			2185.33,
			-1126.32,
			110.916
		},
		{
			"Mulholland",
			952.604,
			-937.184,
			-89.084,
			1096.47,
			-860.619,
			110.916
		},
		{
			"Aldea Malvada",
			-1372.14,
			2498.52,
			0,
			-1277.59,
			2615.35,
			200
		},
		{
			"Las Colinas",
			2126.86,
			-1126.32,
			-89.084,
			2185.33,
			-934.489,
			110.916
		},
		{
			"Las Colinas",
			1994.33,
			-1100.82,
			-89.084,
			2056.86,
			-920.815,
			110.916
		},
		{
			"Richman",
			647.557,
			-954.662,
			-89.084,
			768.694,
			-860.619,
			110.916
		},
		{
			"LVA Freight Depot",
			1277.05,
			1087.63,
			-89.084,
			1375.6,
			1203.28,
			110.916
		},
		{
			"Julius Thruway North",
			1377.39,
			2433.23,
			-89.084,
			1534.56,
			2507.23,
			110.916
		},
		{
			"Willowfield",
			2201.82,
			-2095,
			-89.084,
			2324,
			-1989.9,
			110.916
		},
		{
			"Julius Thruway North",
			1704.59,
			2342.83,
			-89.084,
			1848.4,
			2433.23,
			110.916
		},
		{
			"Temple",
			1252.33,
			-1130.85,
			-89.084,
			1378.33,
			-1026.33,
			110.916
		},
		{
			"Little Mexico",
			1701.9,
			-1842.27,
			-89.084,
			1812.62,
			-1722.26,
			110.916
		},
		{
			"Queens",
			-2411.22,
			373.539,
			0,
			-2253.54,
			458.411,
			200
		},
		{
			"Las Venturas Airport",
			1515.81,
			1586.4,
			-12.5,
			1729.95,
			1714.56,
			87.5
		},
		{
			"Richman",
			225.165,
			-1292.07,
			-89.084,
			466.223,
			-1235.07,
			110.916
		},
		{
			"Temple",
			1252.33,
			-1026.33,
			-89.084,
			1391.05,
			-926.999,
			110.916
		},
		{
			"East Los Santos",
			2266.26,
			-1494.03,
			-89.084,
			2381.68,
			-1372.04,
			110.916
		},
		{
			"Julius Thruway East",
			2623.18,
			943.235,
			-89.084,
			2749.9,
			1055.96,
			110.916
		},
		{
			"Willowfield",
			2541.7,
			-1941.4,
			-89.084,
			2703.58,
			-1852.87,
			110.916
		},
		{
			"Las Colinas",
			2056.86,
			-1126.32,
			-89.084,
			2126.86,
			-920.815,
			110.916
		},
		{
			"Julius Thruway East",
			2625.16,
			2202.76,
			-89.084,
			2685.16,
			2442.55,
			110.916
		},
		{
			"Rodeo",
			225.165,
			-1501.95,
			-89.084,
			334.503,
			-1369.62,
			110.916
		},
		{
			"Las Brujas",
			-365.167,
			2123.01,
			-3,
			-208.57,
			2217.68,
			200
		},
		{
			"Julius Thruway East",
			2536.43,
			2442.55,
			-89.084,
			2685.16,
			2542.55,
			110.916
		},
		{
			"Rodeo",
			334.503,
			-1406.05,
			-89.084,
			466.223,
			-1292.07,
			110.916
		},
		{
			"Vinewood",
			647.557,
			-1227.28,
			-89.084,
			787.461,
			-1118.28,
			110.916
		},
		{
			"Rodeo",
			422.68,
			-1684.65,
			-89.084,
			558.099,
			-1570.2,
			110.916
		},
		{
			"Julius Thruway North",
			2498.21,
			2542.55,
			-89.084,
			2685.16,
			2626.55,
			110.916
		},
		{
			"Downtown Los Santos",
			1724.76,
			-1430.87,
			-89.084,
			1812.62,
			-1250.9,
			110.916
		},
		{
			"Rodeo",
			225.165,
			-1684.65,
			-89.084,
			312.803,
			-1501.95,
			110.916
		},
		{
			"Jefferson",
			2056.86,
			-1449.67,
			-89.084,
			2266.21,
			-1372.04,
			110.916
		},
		{
			"Hampton Barns",
			603.035,
			264.312,
			0,
			761.994,
			366.572,
			200
		},
		{
			"Temple",
			1096.47,
			-1130.84,
			-89.084,
			1252.33,
			-1026.33,
			110.916
		},
		{
			"Kincaid Bridge",
			-1087.93,
			855.37,
			-89.084,
			-961.95,
			986.281,
			110.916
		},
		{
			"Verona Beach",
			1046.15,
			-1722.26,
			-89.084,
			1161.52,
			-1577.59,
			110.916
		},
		{
			"Commerce",
			1323.9,
			-1722.26,
			-89.084,
			1440.9,
			-1577.59,
			110.916
		},
		{
			"Mulholland",
			1357,
			-926.999,
			-89.084,
			1463.9,
			-768.027,
			110.916
		},
		{
			"Rodeo",
			466.223,
			-1570.2,
			-89.084,
			558.099,
			-1385.07,
			110.916
		},
		{
			"Mulholland",
			911.802,
			-860.619,
			-89.084,
			1096.47,
			-768.027,
			110.916
		},
		{
			"Mulholland",
			768.694,
			-954.662,
			-89.084,
			952.604,
			-860.619,
			110.916
		},
		{
			"Julius Thruway South",
			2377.39,
			788.894,
			-89.084,
			2537.39,
			897.901,
			110.916
		},
		{
			"Idlewood",
			1812.62,
			-1852.87,
			-89.084,
			1971.66,
			-1742.31,
			110.916
		},
		{
			"Ocean Docks",
			2089,
			-2394.33,
			-89.084,
			2201.82,
			-2235.84,
			110.916
		},
		{
			"Commerce",
			1370.85,
			-1577.59,
			-89.084,
			1463.9,
			-1384.95,
			110.916
		},
		{
			"Julius Thruway North",
			2121.4,
			2508.23,
			-89.084,
			2237.4,
			2663.17,
			110.916
		},
		{
			"Temple",
			1096.47,
			-1026.33,
			-89.084,
			1252.33,
			-910.17,
			110.916
		},
		{
			"Glen Park",
			1812.62,
			-1449.67,
			-89.084,
			1996.91,
			-1350.72,
			110.916
		},
		{
			"Easter Bay Airport",
			-1242.98,
			-50.096,
			0,
			-1213.91,
			578.396,
			200
		},
		{
			"Martin Bridge",
			-222.179,
			293.324,
			0,
			-122.126,
			476.465,
			200
		},
		{
			"The Strip",
			2106.7,
			1863.23,
			-89.084,
			2162.39,
			2202.76,
			110.916
		},
		{
			"Willowfield",
			2541.7,
			-2059.23,
			-89.084,
			2703.58,
			-1941.4,
			110.916
		},
		{
			"Marina",
			807.922,
			-1577.59,
			-89.084,
			926.922,
			-1416.25,
			110.916
		},
		{
			"Las Venturas Airport",
			1457.37,
			1143.21,
			-89.084,
			1777.4,
			1203.28,
			110.916
		},
		{
			"Idlewood",
			1812.62,
			-1742.31,
			-89.084,
			1951.66,
			-1602.31,
			110.916
		},
		{
			"Esplanade East",
			-1580.01,
			1025.98,
			-6.1,
			-1499.89,
			1274.26,
			200
		},
		{
			"Downtown Los Santos",
			1370.85,
			-1384.95,
			-89.084,
			1463.9,
			-1170.87,
			110.916
		},
		{
			"The Mako Span",
			1664.62,
			401.75,
			0,
			1785.14,
			567.203,
			200
		},
		{
			"Rodeo",
			312.803,
			-1684.65,
			-89.084,
			422.68,
			-1501.95,
			110.916
		},
		{
			"Pershing Square",
			1440.9,
			-1722.26,
			-89.084,
			1583.5,
			-1577.59,
			110.916
		},
		{
			"Mulholland",
			687.802,
			-860.619,
			-89.084,
			911.802,
			-768.027,
			110.916
		},
		{
			"Gant Bridge",
			-2741.07,
			1490.47,
			-6.1,
			-2616.4,
			1659.68,
			200
		},
		{
			"Las Colinas",
			2185.33,
			-1154.59,
			-89.084,
			2281.45,
			-934.489,
			110.916
		},
		{
			"Mulholland",
			1169.13,
			-910.17,
			-89.084,
			1318.13,
			-768.027,
			110.916
		},
		{
			"Julius Thruway North",
			1938.8,
			2508.23,
			-89.084,
			2121.4,
			2624.23,
			110.916
		},
		{
			"Commerce",
			1667.96,
			-1577.59,
			-89.084,
			1812.62,
			-1430.87,
			110.916
		},
		{
			"Rodeo",
			72.648,
			-1544.17,
			-89.084,
			225.165,
			-1404.97,
			110.916
		},
		{
			"Roca Escalante",
			2536.43,
			2202.76,
			-89.084,
			2625.16,
			2442.55,
			110.916
		},
		{
			"Rodeo",
			72.648,
			-1684.65,
			-89.084,
			225.165,
			-1544.17,
			110.916
		},
		{
			"Market",
			952.663,
			-1310.21,
			-89.084,
			1072.66,
			-1130.85,
			110.916
		},
		{
			"Las Colinas",
			2632.74,
			-1135.04,
			-89.084,
			2747.74,
			-945.035,
			110.916
		},
		{
			"Mulholland",
			861.085,
			-674.885,
			-89.084,
			1156.55,
			-600.896,
			110.916
		},
		{
			"King's",
			-2253.54,
			373.539,
			-9.1,
			-1993.28,
			458.411,
			200
		},
		{
			"Redsands East",
			1848.4,
			2342.83,
			-89.084,
			2011.94,
			2478.49,
			110.916
		},
		{
			"Downtown",
			-1580.01,
			744.267,
			-6.1,
			-1499.89,
			1025.98,
			200
		},
		{
			"Conference Center",
			1046.15,
			-1804.21,
			-89.084,
			1323.9,
			-1722.26,
			110.916
		},
		{
			"Richman",
			647.557,
			-1118.28,
			-89.084,
			787.461,
			-954.662,
			110.916
		},
		{
			"Ocean Flats",
			-2994.49,
			277.411,
			-9.1,
			-2867.85,
			458.411,
			200
		},
		{
			"Greenglass College",
			964.391,
			930.89,
			-89.084,
			1166.53,
			1044.69,
			110.916
		},
		{
			"Glen Park",
			1812.62,
			-1100.82,
			-89.084,
			1994.33,
			-973.38,
			110.916
		},
		{
			"LVA Freight Depot",
			1375.6,
			919.447,
			-89.084,
			1457.37,
			1203.28,
			110.916
		},
		{
			"Regular Tom",
			-405.77,
			1712.86,
			-3,
			-276.719,
			1892.75,
			200
		},
		{
			"Verona Beach",
			1161.52,
			-1722.26,
			-89.084,
			1323.9,
			-1577.59,
			110.916
		},
		{
			"East Los Santos",
			2281.45,
			-1372.04,
			-89.084,
			2381.68,
			-1135.04,
			110.916
		},
		{
			"Caligula's Palace",
			2137.4,
			1703.23,
			-89.084,
			2437.39,
			1783.23,
			110.916
		},
		{
			"Idlewood",
			1951.66,
			-1742.31,
			-89.084,
			2124.66,
			-1602.31,
			110.916
		},
		{
			"Pilgrim",
			2624.4,
			1383.23,
			-89.084,
			2685.16,
			1783.23,
			110.916
		},
		{
			"Idlewood",
			2124.66,
			-1742.31,
			-89.084,
			2222.56,
			-1494.03,
			110.916
		},
		{
			"Queens",
			-2533.04,
			458.411,
			0,
			-2329.31,
			578.396,
			200
		},
		{
			"Downtown",
			-1871.72,
			1176.42,
			-4.5,
			-1620.3,
			1274.26,
			200
		},
		{
			"Commerce",
			1583.5,
			-1722.26,
			-89.084,
			1758.9,
			-1577.59,
			110.916
		},
		{
			"East Los Santos",
			2381.68,
			-1454.35,
			-89.084,
			2462.13,
			-1135.04,
			110.916
		},
		{
			"Marina",
			647.712,
			-1577.59,
			-89.084,
			807.922,
			-1416.25,
			110.916
		},
		{
			"Richman",
			72.648,
			-1404.97,
			-89.084,
			225.165,
			-1235.07,
			110.916
		},
		{
			"Vinewood",
			647.712,
			-1416.25,
			-89.084,
			787.461,
			-1227.28,
			110.916
		},
		{
			"East Los Santos",
			2222.56,
			-1628.53,
			-89.084,
			2421.03,
			-1494.03,
			110.916
		},
		{
			"Rodeo",
			558.099,
			-1684.65,
			-89.084,
			647.522,
			-1384.93,
			110.916
		},
		{
			"Easter Tunnel",
			-1709.71,
			-833.034,
			-1.5,
			-1446.01,
			-730.118,
			200
		},
		{
			"Rodeo",
			466.223,
			-1385.07,
			-89.084,
			647.522,
			-1235.07,
			110.916
		},
		{
			"Redsands East",
			1817.39,
			2202.76,
			-89.084,
			2011.94,
			2342.83,
			110.916
		},
		{
			"The Clown's Pocket",
			2162.39,
			1783.23,
			-89.084,
			2437.39,
			1883.23,
			110.916
		},
		{
			"Idlewood",
			1971.66,
			-1852.87,
			-89.084,
			2222.56,
			-1742.31,
			110.916
		},
		{
			"Montgomery Intersection",
			1546.65,
			208.164,
			0,
			1745.83,
			347.457,
			200
		},
		{
			"Willowfield",
			2089,
			-2235.84,
			-89.084,
			2201.82,
			-1989.9,
			110.916
		},
		{
			"Temple",
			952.663,
			-1130.84,
			-89.084,
			1096.47,
			-937.184,
			110.916
		},
		{
			"Prickle Pine",
			1848.4,
			2553.49,
			-89.084,
			1938.8,
			2863.23,
			110.916
		},
		{
			"Los Santos International",
			1400.97,
			-2669.26,
			-39.084,
			2189.82,
			-2597.26,
			60.916
		},
		{
			"Garver Bridge",
			-1213.91,
			950.022,
			-89.084,
			-1087.93,
			1178.93,
			110.916
		},
		{
			"Garver Bridge",
			-1339.89,
			828.129,
			-89.084,
			-1213.91,
			1057.04,
			110.916
		},
		{
			"Kincaid Bridge",
			-1339.89,
			599.218,
			-89.084,
			-1213.91,
			828.129,
			110.916
		},
		{
			"Kincaid Bridge",
			-1213.91,
			721.111,
			-89.084,
			-1087.93,
			950.022,
			110.916
		},
		{
			"Verona Beach",
			930.221,
			-2006.78,
			-89.084,
			1073.22,
			-1804.21,
			110.916
		},
		{
			"Verdant Bluffs",
			1073.22,
			-2006.78,
			-89.084,
			1249.62,
			-1842.27,
			110.916
		},
		{
			"Vinewood",
			787.461,
			-1130.84,
			-89.084,
			952.604,
			-954.662,
			110.916
		},
		{
			"Vinewood",
			787.461,
			-1310.21,
			-89.084,
			952.663,
			-1130.84,
			110.916
		},
		{
			"Commerce",
			1463.9,
			-1577.59,
			-89.084,
			1667.96,
			-1430.87,
			110.916
		},
		{
			"Market",
			787.461,
			-1416.25,
			-89.084,
			1072.66,
			-1310.21,
			110.916
		},
		{
			"Rockshore West",
			2377.39,
			596.349,
			-89.084,
			2537.39,
			788.894,
			110.916
		},
		{
			"Julius Thruway North",
			2237.4,
			2542.55,
			-89.084,
			2498.21,
			2663.17,
			110.916
		},
		{
			"East Beach",
			2632.83,
			-1668.13,
			-89.084,
			2747.74,
			-1393.42,
			110.916
		},
		{
			"Fallow Bridge",
			434.341,
			366.572,
			0,
			603.035,
			555.68,
			200
		},
		{
			"Willowfield",
			2089,
			-1989.9,
			-89.084,
			2324,
			-1852.87,
			110.916
		},
		{
			"Chinatown",
			-2274.17,
			578.396,
			-7.6,
			-2078.67,
			744.17,
			200
		},
		{
			"El Castillo del Diablo",
			-208.57,
			2337.18,
			0,
			8.43,
			2487.18,
			200
		},
		{
			"Ocean Docks",
			2324,
			-2145.1,
			-89.084,
			2703.58,
			-2059.23,
			110.916
		},
		{
			"Easter Bay Chemicals",
			-1132.82,
			-768.027,
			0,
			-956.476,
			-578.118,
			200
		},
		{
			"The Visage",
			1817.39,
			1703.23,
			-89.084,
			2027.4,
			1863.23,
			110.916
		},
		{
			"Ocean Flats",
			-2994.49,
			-430.276,
			-1.2,
			-2831.89,
			-222.589,
			200
		},
		{
			"Richman",
			321.356,
			-860.619,
			-89.084,
			687.802,
			-768.027,
			110.916
		},
		{
			"Green Palms",
			176.581,
			1305.45,
			-3,
			338.658,
			1520.72,
			200
		},
		{
			"Richman",
			321.356,
			-768.027,
			-89.084,
			700.794,
			-674.885,
			110.916
		},
		{
			"Starfish Casino",
			2162.39,
			1883.23,
			-89.084,
			2437.39,
			2012.18,
			110.916
		},
		{
			"East Beach",
			2747.74,
			-1668.13,
			-89.084,
			2959.35,
			-1498.62,
			110.916
		},
		{
			"Jefferson",
			2056.86,
			-1372.04,
			-89.084,
			2281.45,
			-1210.74,
			110.916
		},
		{
			"Downtown Los Santos",
			1463.9,
			-1290.87,
			-89.084,
			1724.76,
			-1150.87,
			110.916
		},
		{
			"Downtown Los Santos",
			1463.9,
			-1430.87,
			-89.084,
			1724.76,
			-1290.87,
			110.916
		},
		{
			"Garver Bridge",
			-1499.89,
			696.442,
			-179.615,
			-1339.89,
			925.353,
			20.385
		},
		{
			"Julius Thruway South",
			1457.39,
			823.228,
			-89.084,
			2377.39,
			863.229,
			110.916
		},
		{
			"East Los Santos",
			2421.03,
			-1628.53,
			-89.084,
			2632.83,
			-1454.35,
			110.916
		},
		{
			"Greenglass College",
			964.391,
			1044.69,
			-89.084,
			1197.39,
			1203.22,
			110.916
		},
		{
			"Las Colinas",
			2747.74,
			-1120.04,
			-89.084,
			2959.35,
			-945.035,
			110.916
		},
		{
			"Mulholland",
			737.573,
			-768.027,
			-89.084,
			1142.29,
			-674.885,
			110.916
		},
		{
			"Ocean Docks",
			2201.82,
			-2730.88,
			-89.084,
			2324,
			-2418.33,
			110.916
		},
		{
			"East Los Santos",
			2462.13,
			-1454.35,
			-89.084,
			2581.73,
			-1135.04,
			110.916
		},
		{
			"Ganton",
			2222.56,
			-1722.33,
			-89.084,
			2632.83,
			-1628.53,
			110.916
		},
		{
			"Avispa Country Club",
			-2831.89,
			-430.276,
			-6.1,
			-2646.4,
			-222.589,
			200
		},
		{
			"Willowfield",
			1970.62,
			-2179.25,
			-89.084,
			2089,
			-1852.87,
			110.916
		},
		{
			"Esplanade North",
			-1982.32,
			1274.26,
			-4.5,
			-1524.24,
			1358.9,
			200
		},
		{
			"The High Roller",
			1817.39,
			1283.23,
			-89.084,
			2027.39,
			1469.23,
			110.916
		},
		{
			"Ocean Docks",
			2201.82,
			-2418.33,
			-89.084,
			2324,
			-2095,
			110.916
		},
		{
			"Last Dime Motel",
			1823.08,
			596.349,
			-89.084,
			1997.22,
			823.228,
			110.916
		},
		{
			"Bayside Marina",
			-2353.17,
			2275.79,
			0,
			-2153.17,
			2475.79,
			200
		},
		{
			"King's",
			-2329.31,
			458.411,
			-7.6,
			-1993.28,
			578.396,
			200
		},
		{
			"El Corona",
			1692.62,
			-2179.25,
			-89.084,
			1812.62,
			-1842.27,
			110.916
		},
		{
			"Blackfield Chapel",
			1375.6,
			596.349,
			-89.084,
			1558.09,
			823.228,
			110.916
		},
		{
			"The Pink Swan",
			1817.39,
			1083.23,
			-89.084,
			2027.39,
			1283.23,
			110.916
		},
		{
			"Julius Thruway West",
			1197.39,
			1163.39,
			-89.084,
			1236.63,
			2243.23,
			110.916
		},
		{
			"Los Flores",
			2581.73,
			-1393.42,
			-89.084,
			2747.74,
			-1135.04,
			110.916
		},
		{
			"The Visage",
			1817.39,
			1863.23,
			-89.084,
			2106.7,
			2011.83,
			110.916
		},
		{
			"Prickle Pine",
			1938.8,
			2624.23,
			-89.084,
			2121.4,
			2861.55,
			110.916
		},
		{
			"Verona Beach",
			851.449,
			-1804.21,
			-89.084,
			1046.15,
			-1577.59,
			110.916
		},
		{
			"Robada Intersection",
			-1119.01,
			1178.93,
			-89.084,
			-862.025,
			1351.45,
			110.916
		},
		{
			"Linden Side",
			2749.9,
			943.235,
			-89.084,
			2923.39,
			1198.99,
			110.916
		},
		{
			"Ocean Docks",
			2703.58,
			-2302.33,
			-89.084,
			2959.35,
			-2126.9,
			110.916
		},
		{
			"Willowfield",
			2324,
			-2059.23,
			-89.084,
			2541.7,
			-1852.87,
			110.916
		},
		{
			"King's",
			-2411.22,
			265.243,
			-9.1,
			-1993.28,
			373.539,
			200
		},
		{
			"Commerce",
			1323.9,
			-1842.27,
			-89.084,
			1701.9,
			-1722.26,
			110.916
		},
		{
			"Mulholland",
			1269.13,
			-768.027,
			-89.084,
			1414.07,
			-452.425,
			110.916
		},
		{
			"Marina",
			647.712,
			-1804.21,
			-89.084,
			851.449,
			-1577.59,
			110.916
		},
		{
			"Battery Point",
			-2741.07,
			1268.41,
			-4.5,
			-2533.04,
			1490.47,
			200
		},
		{
			"The Four Dragons Casino",
			1817.39,
			863.232,
			-89.084,
			2027.39,
			1083.23,
			110.916
		},
		{
			"Blackfield",
			964.391,
			1203.22,
			-89.084,
			1197.39,
			1403.22,
			110.916
		},
		{
			"Julius Thruway North",
			1534.56,
			2433.23,
			-89.084,
			1848.4,
			2583.23,
			110.916
		},
		{
			"Yellow Bell Gol Course",
			1117.4,
			2723.23,
			-89.084,
			1457.46,
			2863.23,
			110.916
		},
		{
			"Idlewood",
			1812.62,
			-1602.31,
			-89.084,
			2124.66,
			-1449.67,
			110.916
		},
		{
			"Redsands West",
			1297.47,
			2142.86,
			-89.084,
			1777.39,
			2243.23,
			110.916
		},
		{
			"Doherty",
			-2270.04,
			-324.114,
			-1.2,
			-1794.92,
			-222.589,
			200
		},
		{
			"Hilltop Farm",
			967.383,
			-450.39,
			-3,
			1176.78,
			-217.9,
			200
		},
		{
			"Las Barrancas",
			-926.13,
			1398.73,
			-3,
			-719.234,
			1634.69,
			200
		},
		{
			"Pirates in Men's Pants",
			1817.39,
			1469.23,
			-89.084,
			2027.4,
			1703.23,
			110.916
		},
		{
			"City Hall",
			-2867.85,
			277.411,
			-9.1,
			-2593.44,
			458.411,
			200
		},
		{
			"Avispa Country Club",
			-2646.4,
			-355.493,
			0,
			-2270.04,
			-222.589,
			200
		},
		{
			"The Strip",
			2027.4,
			863.229,
			-89.084,
			2087.39,
			1703.23,
			110.916
		},
		{
			"Hashbury",
			-2593.44,
			-222.589,
			-1,
			-2411.22,
			54.722,
			200
		},
		{
			"Los Santos International",
			1852,
			-2394.33,
			-89.084,
			2089,
			-2179.25,
			110.916
		},
		{
			"Whitewood Estates",
			1098.31,
			1726.22,
			-89.084,
			1197.39,
			2243.23,
			110.916
		},
		{
			"Sherman Reservoir",
			-789.737,
			1659.68,
			-89.084,
			-599.505,
			1929.41,
			110.916
		},
		{
			"El Corona",
			1812.62,
			-2179.25,
			-89.084,
			1970.62,
			-1852.87,
			110.916
		},
		{
			"Downtown",
			-1700.01,
			744.267,
			-6.1,
			-1580.01,
			1176.52,
			200
		},
		{
			"Foster Valley",
			-2178.69,
			-1250.97,
			0,
			-1794.92,
			-1115.58,
			200
		},
		{
			"Las Payasadas",
			-354.332,
			2580.36,
			2,
			-133.625,
			2816.82,
			200
		},
		{
			"Valle Ocultado",
			-936.668,
			2611.44,
			2,
			-715.961,
			2847.9,
			200
		},
		{
			"Blackfield Intersection",
			1166.53,
			795.01,
			-89.084,
			1375.6,
			1044.69,
			110.916
		},
		{
			"Ganton",
			2222.56,
			-1852.87,
			-89.084,
			2632.83,
			-1722.33,
			110.916
		},
		{
			"Easter Bay Airport",
			-1213.91,
			-730.118,
			0,
			-1132.82,
			-50.096,
			200
		},
		{
			"Redsands East",
			1817.39,
			2011.83,
			-89.084,
			2106.7,
			2202.76,
			110.916
		},
		{
			"Esplanade East",
			-1499.89,
			578.396,
			-79.615,
			-1339.89,
			1274.26,
			20.385
		},
		{
			"Caligula's Palace",
			2087.39,
			1543.23,
			-89.084,
			2437.39,
			1703.23,
			110.916
		},
		{
			"Royal Casino",
			2087.39,
			1383.23,
			-89.084,
			2437.39,
			1543.23,
			110.916
		},
		{
			"Richman",
			72.648,
			-1235.07,
			-89.084,
			321.356,
			-1008.15,
			110.916
		},
		{
			"Starfish Casino",
			2437.39,
			1783.23,
			-89.084,
			2685.16,
			2012.18,
			110.916
		},
		{
			"Mulholland",
			1281.13,
			-452.425,
			-89.084,
			1641.13,
			-290.913,
			110.916
		},
		{
			"Downtown",
			-1982.32,
			744.17,
			-6.1,
			-1871.72,
			1274.26,
			200
		},
		{
			"Hankypanky Point",
			2576.92,
			62.158,
			0,
			2759.25,
			385.503,
			200
		},
		{
			"K.A.C.C. Military Fuels",
			2498.21,
			2626.55,
			-89.084,
			2749.9,
			2861.55,
			110.916
		},
		{
			"Harry Gold Parkway",
			1777.39,
			863.232,
			-89.084,
			1817.39,
			2342.83,
			110.916
		},
		{
			"Bayside Tunnel",
			-2290.19,
			2548.29,
			-89.084,
			-1950.19,
			2723.29,
			110.916
		},
		{
			"Ocean Docks",
			2324,
			-2302.33,
			-89.084,
			2703.58,
			-2145.1,
			110.916
		},
		{
			"Richman",
			321.356,
			-1044.07,
			-89.084,
			647.557,
			-860.619,
			110.916
		},
		{
			"Randolph Industrial Estate",
			1558.09,
			596.349,
			-89.084,
			1823.08,
			823.235,
			110.916
		},
		{
			"East Beach",
			2632.83,
			-1852.87,
			-89.084,
			2959.35,
			-1668.13,
			110.916
		},
		{
			"Flint Water",
			-314.426,
			-753.874,
			-89.084,
			-106.339,
			-463.073,
			110.916
		},
		{
			"Blueberry",
			19.607,
			-404.136,
			3.8,
			349.607,
			-220.137,
			200
		},
		{
			"Linden Station",
			2749.9,
			1198.99,
			-89.084,
			2923.39,
			1548.99,
			110.916
		},
		{
			"Glen Park",
			1812.62,
			-1350.72,
			-89.084,
			2056.86,
			-1100.82,
			110.916
		},
		{
			"Downtown",
			-1993.28,
			265.243,
			-9.1,
			-1794.92,
			578.396,
			200
		},
		{
			"Redsands West",
			1377.39,
			2243.23,
			-89.084,
			1704.59,
			2433.23,
			110.916
		},
		{
			"Richman",
			321.356,
			-1235.07,
			-89.084,
			647.522,
			-1044.07,
			110.916
		},
		{
			"Gant Bridge",
			-2741.45,
			1659.68,
			-6.1,
			-2616.4,
			2175.15,
			200
		},
		{
			"Lil' Probe Inn",
			-90.218,
			1286.85,
			-3,
			153.859,
			1554.12,
			200
		},
		{
			"Flint Intersection",
			-187.7,
			-1596.76,
			-89.084,
			17.063,
			-1276.6,
			110.916
		},
		{
			"Las Colinas",
			2281.45,
			-1135.04,
			-89.084,
			2632.74,
			-945.035,
			110.916
		},
		{
			"Sobell Rail Yards",
			2749.9,
			1548.99,
			-89.084,
			2923.39,
			1937.25,
			110.916
		},
		{
			"The Emerald Isle",
			2011.94,
			2202.76,
			-89.084,
			2237.4,
			2508.23,
			110.916
		},
		{
			"El Castillo del Diablo",
			-208.57,
			2123.01,
			-7.6,
			114.033,
			2337.18,
			200
		},
		{
			"Santa Flora",
			-2741.07,
			458.411,
			-7.6,
			-2533.04,
			793.411,
			200
		},
		{
			"Playa del Seville",
			2703.58,
			-2126.9,
			-89.084,
			2959.35,
			-1852.87,
			110.916
		},
		{
			"Market",
			926.922,
			-1577.59,
			-89.084,
			1370.85,
			-1416.25,
			110.916
		},
		{
			"Queens",
			-2593.44,
			54.722,
			0,
			-2411.22,
			458.411,
			200
		},
		{
			"Pilson Intersection",
			1098.39,
			2243.23,
			-89.084,
			1377.39,
			2507.23,
			110.916
		},
		{
			"Spinybed",
			2121.4,
			2663.17,
			-89.084,
			2498.21,
			2861.55,
			110.916
		},
		{
			"Pilgrim",
			2437.39,
			1383.23,
			-89.084,
			2624.4,
			1783.23,
			110.916
		},
		{
			"Blackfield",
			964.391,
			1403.22,
			-89.084,
			1197.39,
			1726.22,
			110.916
		},
		{
			"'The Big Ear'",
			-410.02,
			1403.34,
			-3,
			-137.969,
			1681.23,
			200
		},
		{
			"Dillimore",
			580.794,
			-674.885,
			-9.5,
			861.085,
			-404.79,
			200
		},
		{
			"El Quebrados",
			-1645.23,
			2498.52,
			0,
			-1372.14,
			2777.85,
			200
		},
		{
			"Esplanade North",
			-2533.04,
			1358.9,
			-4.5,
			-1996.66,
			1501.21,
			200
		},
		{
			"Easter Bay Airport",
			-1499.89,
			-50.096,
			-1,
			-1242.98,
			249.904,
			200
		},
		{
			"Fisher's Lagoon",
			1916.99,
			-233.323,
			-100,
			2131.72,
			13.8,
			200
		},
		{
			"Mulholland",
			1414.07,
			-768.027,
			-89.084,
			1667.61,
			-452.425,
			110.916
		},
		{
			"East Beach",
			2747.74,
			-1498.62,
			-89.084,
			2959.35,
			-1120.04,
			110.916
		},
		{
			"San Andreas Sound",
			2450.39,
			385.503,
			-100,
			2759.25,
			562.349,
			200
		},
		{
			"Shady Creeks",
			-2030.12,
			-2174.89,
			-6.1,
			-1820.64,
			-1771.66,
			200
		},
		{
			"Market",
			1072.66,
			-1416.25,
			-89.084,
			1370.85,
			-1130.85,
			110.916
		},
		{
			"Rockshore West",
			1997.22,
			596.349,
			-89.084,
			2377.39,
			823.228,
			110.916
		},
		{
			"Prickle Pine",
			1534.56,
			2583.23,
			-89.084,
			1848.4,
			2863.23,
			110.916
		},
		{
			"Easter Basin",
			-1794.92,
			-50.096,
			-1.04,
			-1499.89,
			249.904,
			200
		},
		{
			"Leafy Hollow",
			-1166.97,
			-1856.03,
			0,
			-815.624,
			-1602.07,
			200
		},
		{
			"LVA Freight Depot",
			1457.39,
			863.229,
			-89.084,
			1777.4,
			1143.21,
			110.916
		},
		{
			"Prickle Pine",
			1117.4,
			2507.23,
			-89.084,
			1534.56,
			2723.23,
			110.916
		},
		{
			"Blueberry",
			104.534,
			-220.137,
			2.3,
			349.607,
			152.236,
			200
		},
		{
			"El Castillo del Diablo",
			-464.515,
			2217.68,
			0,
			-208.57,
			2580.36,
			200
		},
		{
			"Downtown",
			-2078.67,
			578.396,
			-7.6,
			-1499.89,
			744.267,
			200
		},
		{
			"Rockshore East",
			2537.39,
			676.549,
			-89.084,
			2902.35,
			943.235,
			110.916
		},
		{
			"San Fierro Bay",
			-2616.4,
			1501.21,
			-3,
			-1996.66,
			1659.68,
			200
		},
		{
			"Paradiso",
			-2741.07,
			793.411,
			-6.1,
			-2533.04,
			1268.41,
			200
		},
		{
			"The Camel's Toe",
			2087.39,
			1203.23,
			-89.084,
			2640.4,
			1383.23,
			110.916
		},
		{
			"Old Venturas Strip",
			2162.39,
			2012.18,
			-89.084,
			2685.16,
			2202.76,
			110.916
		},
		{
			"Juniper Hill",
			-2533.04,
			578.396,
			-7.6,
			-2274.17,
			968.369,
			200
		},
		{
			"Juniper Hollow",
			-2533.04,
			968.369,
			-6.1,
			-2274.17,
			1358.9,
			200
		},
		{
			"Roca Escalante",
			2237.4,
			2202.76,
			-89.084,
			2536.43,
			2542.55,
			110.916
		},
		{
			"Julius Thruway East",
			2685.16,
			1055.96,
			-89.084,
			2749.9,
			2626.55,
			110.916
		},
		{
			"Verona Beach",
			647.712,
			-2173.29,
			-89.084,
			930.221,
			-1804.21,
			110.916
		},
		{
			"Foster Valley",
			-2178.69,
			-599.884,
			-1.2,
			-1794.92,
			-324.114,
			200
		},
		{
			"Arco del Oeste",
			-901.129,
			2221.86,
			0,
			-592.09,
			2571.97,
			200
		},
		{
			"Fallen Tree",
			-792.254,
			-698.555,
			-5.3,
			-452.404,
			-380.043,
			200
		},
		{
			"The Farm",
			-1209.67,
			-1317.1,
			114.981,
			-908.161,
			-787.391,
			251.981
		},
		{
			"The Sherman Dam",
			-968.772,
			1929.41,
			-3,
			-481.126,
			2155.26,
			200
		},
		{
			"Esplanade North",
			-1996.66,
			1358.9,
			-4.5,
			-1524.24,
			1592.51,
			200
		},
		{
			"Financial",
			-1871.72,
			744.17,
			-6.1,
			-1701.3,
			1176.42,
			300
		},
		{
			"Garcia",
			-2411.22,
			-222.589,
			-1.14,
			-2173.04,
			265.243,
			200
		},
		{
			"Montgomery",
			1119.51,
			119.526,
			-3,
			1451.4,
			493.323,
			200
		},
		{
			"Creek",
			2749.9,
			1937.25,
			-89.084,
			2921.62,
			2669.79,
			110.916
		},
		{
			"Los Santos International",
			1249.62,
			-2394.33,
			-89.084,
			1852,
			-2179.25,
			110.916
		},
		{
			"Santa Maria Beach",
			72.648,
			-2173.29,
			-89.084,
			342.648,
			-1684.65,
			110.916
		},
		{
			"Mulholland Intersection",
			1463.9,
			-1150.87,
			-89.084,
			1812.62,
			-768.027,
			110.916
		},
		{
			"Angel Pine",
			-2324.94,
			-2584.29,
			-6.1,
			-1964.22,
			-2212.11,
			200
		},
		{
			"Verdant Meadows",
			37.032,
			2337.18,
			-3,
			435.988,
			2677.9,
			200
		},
		{
			"Octane Springs",
			338.658,
			1228.51,
			0,
			664.308,
			1655.05,
			200
		},
		{
			"Come-A-Lot",
			2087.39,
			943.235,
			-89.084,
			2623.18,
			1203.23,
			110.916
		},
		{
			"Redsands West",
			1236.63,
			1883.11,
			-89.084,
			1777.39,
			2142.86,
			110.916
		},
		{
			"Santa Maria Beach",
			342.648,
			-2173.29,
			-89.084,
			647.712,
			-1684.65,
			110.916
		},
		{
			"Verdant Bluffs",
			1249.62,
			-2179.25,
			-89.084,
			1692.62,
			-1842.27,
			110.916
		},
		{
			"Las Venturas Airport",
			1236.63,
			1203.28,
			-89.084,
			1457.37,
			1883.11,
			110.916
		},
		{
			"Flint Range",
			-594.191,
			-1648.55,
			0,
			-187.7,
			-1276.6,
			200
		},
		{
			"Verdant Bluffs",
			930.221,
			-2488.42,
			-89.084,
			1249.62,
			-2006.78,
			110.916
		},
		{
			"Palomino Creek",
			2160.22,
			-149.004,
			0,
			2576.92,
			228.322,
			200
		},
		{
			"Ocean Docks",
			2373.77,
			-2697.09,
			-89.084,
			2809.22,
			-2330.46,
			110.916
		},
		{
			"Easter Bay Airport",
			-1213.91,
			-50.096,
			-4.5,
			-947.98,
			578.396,
			200
		},
		{
			"Whitewood Estates",
			883.308,
			1726.22,
			-89.084,
			1098.31,
			2507.23,
			110.916
		},
		{
			"Calton Heights",
			-2274.17,
			744.17,
			-6.1,
			-1982.32,
			1358.9,
			200
		},
		{
			"Easter Basin",
			-1794.92,
			249.904,
			-9.1,
			-1242.98,
			578.396,
			200
		},
		{
			"Los Santos Inlet",
			-321.744,
			-2224.43,
			-89.084,
			44.615,
			-1724.43,
			110.916
		},
		{
			"Doherty",
			-2173.04,
			-222.589,
			-1,
			-1794.92,
			265.243,
			200
		},
		{
			"Mount Chiliad",
			-2178.69,
			-2189.91,
			-47.917,
			-2030.12,
			-1771.66,
			576.083
		},
		{
			"Fort Carson",
			-376.233,
			826.326,
			-3,
			123.717,
			1220.44,
			200
		},
		{
			"Foster Valley",
			-2178.69,
			-1115.58,
			0,
			-1794.92,
			-599.884,
			200
		},
		{
			"Ocean Flats",
			-2994.49,
			-222.589,
			-1,
			-2593.44,
			277.411,
			200
		},
		{
			"Fern Ridge",
			508.189,
			-139.259,
			0,
			1306.66,
			119.526,
			200
		},
		{
			"Bayside",
			-2741.07,
			2175.15,
			0,
			-2353.17,
			2722.79,
			200
		},
		{
			"Las Venturas Airport",
			1457.37,
			1203.28,
			-89.084,
			1777.39,
			1883.11,
			110.916
		},
		{
			"Blueberry Acres",
			-319.676,
			-220.137,
			0,
			104.534,
			293.324,
			200
		},
		{
			"Palisades",
			-2994.49,
			458.411,
			-6.1,
			-2741.07,
			1339.61,
			200
		},
		{
			"North Rock",
			2285.37,
			-768.027,
			0,
			2770.59,
			-269.74,
			200
		},
		{
			"Hunter Quarry",
			337.244,
			710.84,
			-115.239,
			860.554,
			1031.71,
			203.761
		},
		{
			"Los Santos International",
			1382.73,
			-2730.88,
			-89.084,
			2201.82,
			-2394.33,
			110.916
		},
		{
			"Missionary Hill",
			-2994.49,
			-811.276,
			0,
			-2178.69,
			-430.276,
			200
		},
		{
			"San Fierro Bay",
			-2616.4,
			1659.68,
			-3,
			-1996.66,
			2175.15,
			200
		},
		{
			"Restricted Area",
			-91.586,
			1655.05,
			-50,
			421.234,
			2123.01,
			250
		},
		{
			"Mount Chiliad",
			-2997.47,
			-1115.58,
			-47.917,
			-2178.69,
			-971.913,
			576.083
		},
		{
			"Mount Chiliad",
			-2178.69,
			-1771.66,
			-47.917,
			-1936.12,
			-1250.97,
			576.083
		},
		{
			"Easter Bay Airport",
			-1794.92,
			-730.118,
			-3,
			-1213.91,
			-50.096,
			200
		},
		{
			"The Panopticon",
			-947.98,
			-304.32,
			-1.1,
			-319.676,
			327.071,
			200
		},
		{
			"Shady Creeks",
			-1820.64,
			-2643.68,
			-8,
			-1226.78,
			-1771.66,
			200
		},
		{
			"Back o Beyond",
			-1166.97,
			-2641.19,
			0,
			-321.744,
			-1856.03,
			200
		},
		{
			"Mount Chiliad",
			-2994.49,
			-2189.91,
			-47.917,
			-2178.69,
			-1115.58,
			576.083
		},
		{
			"Tierra Robada",
			-1213.91,
			596.349,
			-242.99,
			-480.539,
			1659.68,
			900
		},
		{
			"Flint County",
			-1213.91,
			-2892.97,
			-242.99,
			44.615,
			-768.027,
			900
		},
		{
			"Whetstone",
			-2997.47,
			-2892.97,
			-242.99,
			-1213.91,
			-1115.58,
			900
		},
		{
			"Bone County",
			-480.539,
			596.349,
			-242.99,
			869.461,
			2993.87,
			900
		},
		{
			"Tierra Robada",
			-2997.47,
			1659.68,
			-242.99,
			-480.539,
			2993.87,
			900
		},
		{
			"San Fierro",
			-2997.47,
			-1115.58,
			-242.99,
			-1213.91,
			1659.68,
			900
		},
		{
			"Las Venturas",
			869.461,
			596.349,
			-242.99,
			2997.06,
			2993.87,
			900
		},
		{
			"Red County",
			-1213.91,
			-768.027,
			-242.99,
			2997.06,
			596.349,
			900
		},
		{
			"Los Santos",
			44.615,
			-2892.97,
			-242.99,
			2997.06,
			-768.027,
			900
		}
	}) do
		if slot8[2] <= slot0 and slot8[3] <= slot1 and slot8[4] <= slot2 and slot0 <= slot8[5] and slot1 <= slot8[6] and slot2 <= slot8[7] then
			return slot8[1]
		end
	end

	return " "
end

slot5.onSendChat = function(slot0)
	if slot0.find(slot0, uv0) then
		sampSendChat(slot0.gsub(slot0, uv0, select(2, sampGetPlayerIdByCharHandle(playerPed))))

		return false
	end

	if slot0.find(slot0, uv1) then
		sampSendChat(slot0.gsub(slot0, uv1, nick_player1))

		return false
	end

	if slot0.find(slot0, uv2) then
		sampSendChat(slot0.gsub(slot0, uv2, nick_player2))

		return false
	end

	if slot0.find(slot0, uv3) then
		sampSendChat(slot0.gsub(slot0, uv3, uv4))

		return false
	end

	if slot0.find(slot0, uv5) then
		sampSendChat(slot0.gsub(slot0, uv5, uv6))

		return false
	end

	if slot0.find(slot0, uv7) then
		slot1, slot2, slot3 = getCharCoordinates(PLAYER_PED)

		sampSendChat(slot0.gsub(slot0, uv7, calculateZone(slot1, slot2, slot3)))

		return false
	end

	if slot0.find(slot0, uv8) then
		sampSendChat(slot0.gsub(slot0, uv8, cityname))

		return false
	end

	if slot0.find(slot0, uv9) then
		sampSendChat(slot0.gsub(slot0, uv9, os.date("%d %m %Y, %X")))

		return false
	end

	if srv ~= 99 then
		if active_chatValue and act1 then
			if not slot0.find(slot0, "^[A-zА-я0-9]") or slot0 == "xD" or slot0 == "XD" then
				return {
					slot0
				}
			end

			act1 = false

			return {
				" [" .. u8:decode(accentValue) .. "]: " .. slot0
			}
		end

		if active_chatValue and not act1 then
			if not slot0.find(slot0, "^[A-zА-я0-9]") or slot0 == "xD" or slot0 == "XD" then
				return {
					slot0
				}
			end

			act1 = true

			return {
				"-[" .. u8:decode(accentValue) .. "]: " .. slot0
			}
		end
	end

	if bi then
		bi = false

		return
	end

	if slot0.len(slot0) > 90 then
		divide(slot0, "", "")

		return false
	end
end

divide = function(slot0, slot1, slot2, slot3)
	if slot3 == "sms" then
		limit = 57
	else
		limit = 72
	end

	slot4, slot5 = string.match(slot0.sub(slot0, 1, limit), "(.*) (.*)")

	if slot5 == nil then
		slot5 = ""
	end

	slot7 = "..." .. slot5 .. slot0.sub(slot0, limit + 1, slot0.len(slot0))
	bi = true

	sampSendChat(slot1 .. (slot4 .. "...") .. slot2)

	if slot3 == "ext" then
		slot1 = "/do "

		if slot7.sub(slot7, -1) ~= "." then
			slot7 = slot7 .. "."
		end
	end

	bi = true

	sampSendChat(slot1 .. slot7 .. slot2)
end

slot5.onSendCommand = function(slot0)
	for slot4 = 0, uv0 do
		if uv1[slot4] ~= nil and uv1[slot4].act ~= nil and slot0 == uv1[slot4].act then
			thread:run("binder" .. slot4)

			return false
		end
	end

	if slot0 == "/find" then
		uv2.players = {}
		uv2.afk = 0
		uv2.jail = 0
		uv2.mute = 0
	end

	if slot0 == "/do" then
		slot1 = message:len()
	end

	if slot0.find(slot0, uv3) then
		sampProcessChatInput(slot0.gsub(slot0, uv3, select(2, sampGetPlayerIdByCharHandle(playerPed))))

		return false
	end

	if slot0.find(slot0, uv4) then
		sampSendChat(slot0.gsub(slot0, uv4, nick_player1))

		return false
	end

	if slot0.find(slot0, uv5) then
		sampSendChat(slot0.gsub(slot0, uv5, nick_player2))

		return false
	end

	if slot0.find(slot0, uv6) then
		sampSendChat(slot0.gsub(slot0, uv6, uv7))

		return false
	end

	if slot0.find(slot0, uv8) then
		sampSendChat(slot0.gsub(slot0, uv8, uv9))

		return false
	end

	if slot0.find(slot0, uv10) then
		slot1, slot2, slot3 = getCharCoordinates(PLAYER_PED)

		sampSendChat(slot0.gsub(slot0, uv10, calculateZone(slot1, slot2, slot3)))

		return false
	end

	if slot0.find(slot0, uv11) then
		sampSendChat(slot0.gsub(slot0, uv11, cityname))

		return false
	end

	if slot0.find(slot0, uv12) then
		sampSendChat(slot0.gsub(slot0, uv12, os.date("%d %m %Y, %X")))

		return false
	end

	if bi then
		bi = false

		return
	end

	slot1, slot2 = slot0.match(slot0, "/(%S*) (.*)")

	if slot2 == nil then
		return
	end

	for slot6, slot7 in ipairs(commands) do
		if slot1 == slot7 then
			slot8 = slot2.len(slot2)

			if slot2.sub(slot2, 1, 2) == "((" then
				slot2 = string.gsub(slot2.sub(slot2, 4), "%)%)", "")

				if slot8 > 80 then
					divide(slot2, "/" .. slot1 .. " (( ", " ))")

					return false
				end
			elseif slot8 > 80 then
				divide(slot2, "/" .. slot1 .. " ", "")

				return false
			end
		end
	end

	if (slot1 == "me" or slot1 == "do") and slot2.len(slot2) > 75 then
		divide(slot2, "/" .. slot1 .. " ", "", "ext")

		return false
	end

	if slot1 == "sms" then
		slot3 = "{}" .. slot2
		slot4, slot5 = slot3:match("{}(%d+) (.*)")
		slot6 = slot3:sub(3)

		if slot5 == nil then
			for slot10 = 1, 99 do
				if sampGetChatString(slot10):match("SMS: .* | .*: (.*)") ~= nil then
					slot4 = string.match(slot11, ".* %[.*%.(%d+)%]")
				end
			end
		else
			slot6 = slot5
		end

		if slot4 == nil then
			return
		end

		if slot6.len(slot6) > 66 then
			divide(slot6, "/sms " .. slot4 .. " ", " ", "sms")

			return false
		end

		if slot7 < 66 then
			bi = true

			sampSendChat("/sms " .. slot4 .. " " .. slot6)

			return false
		end
	end
end

thread_function = function(slot0)
	if string.sub(slot0, 0, 6) == "binder" and enterbindValue then
		slot4 = 7
		ind = tonumber(string.sub(slot0, slot4))

		for slot4 = 1, 30 do
			if uv0[ind][slot4] ~= nil then
				if uv0[ind][slot4] == "" then
					TriggerNotification("Обнаружена пустая строка.")
				else
					wait(100)
					sampSetChatInputEnabled(true)
					sampSetChatInputText(u8:decode(uv0[ind][slot4]))

					while sampIsChatInputActive() do
						wait(0)
					end

					wait(tonumber(uv0[ind].wait .. "000"))
				end
			else
				return
			end
		end
	end

	if string.sub(slot0, 0, 6) == "binder" and not enterbindValue then
		slot4 = 7
		ind = tonumber(string.sub(slot0, slot4))

		for slot4 = 1, 30 do
			if uv0[ind][slot4] ~= nil then
				if uv0[ind][slot4] == "" then
					TriggerNotification("Обнаружена пустая строка.")
				else
					sampSendChat(u8:decode(uv0[ind][slot4]))
					wait(tonumber(uv0[ind].wait .. "000"))
				end
			else
				return
			end
		end

		return
	end
end

AddChatMessage = function(slot0)
	if VipStatus then
		sampAddChatMessage("[HorA.su | VIP]: {FFFFFF}" .. slot0, 5560741)
	else
		sampAddChatMessage("[HorA.su]: {FFFFFF}" .. slot0, 5560741)
	end
end

ShowHelpMarker = function(slot0)
	uv0.SameLine()
	uv0.TextDisabled("(?)")

	if uv0.IsItemHovered() then
		uv0.SetTooltip(u8(slot0))
	end
end

ShowCenterTextColor = function(slot0, slot1, slot2)
	uv0.SetCursorPosX(slot1 / 2 - uv0.CalcTextSize(slot0).x / 2)
	uv0.TextColored(slot2, slot0)
end

ShowCenterText = function(slot0, slot1)
	uv0.SetCursorPosX(slot1 / 2 - uv0.CalcTextSize(slot0).x / 2)
	uv0.TextColored(uv0.ImVec4(0.4, 0.8, 0.3, 1), slot0)
end

ShowCenterText2 = function(slot0)
	uv0.SetCursorPosX((uv0.GetWindowWidth() - uv0.CalcTextSize(slot0).x) / 2)
	uv0.Text(slot0)
end

isReservedCommand = function(slot0)
	ArrRCommand = {
		"binder"
	}

	for slot4 = 1, #ArrRCommand do
		if slot0 == ArrRCommand[slot4] then
			return true
		end
	end

	return false
end

getDownKeys = function()
	slot0 = ""
	slot1 = false

	for slot5, slot6 in pairs(uv0) do
		if isKeyDown(slot6) and (slot6 == VK_MENU or slot6 == VK_CONTROL or slot6 == VK_SHIFT or slot6 == VK_LMENU or slot6 == VK_RMENU or slot6 == VK_RCONTROL or slot6 == VK_LCONTROL or slot6 == VK_LSHIFT or slot6 == VK_RSHIFT) and slot6 ~= VK_MENU and slot6 ~= VK_CONTROL and slot6 ~= VK_SHIFT then
			slot0 = slot6
		end
	end

	for slot5, slot6 in pairs(uv0) do
		if isKeyDown(slot6) and slot6 ~= VK_MENU and slot6 ~= VK_CONTROL and slot6 ~= VK_SHIFT and slot6 ~= VK_LMENU and slot6 ~= VK_RMENU and slot6 ~= VK_RCONTROL and slot6 ~= VK_LCONTROL and slot6 ~= VK_LSHIFT and slot6 ~= VK_RSHIFT then
			slot0 = tostring(slot0):len() == 0 and slot6 or slot6 .. " " .. slot6
			slot1 = true
		end
	end

	return slot0, slot1
end

getDownKeysText = function()
	tKeys = string.split(getDownKeys(), " ")

	if #tKeys ~= 0 then
		for slot3 = 1, #tKeys do
			if slot3 == 1 then
				str = uv0.id_to_name(tonumber(tKeys[slot3]))
			else
				str = str .. "+" .. uv0.id_to_name(tonumber(tKeys[slot3]))
			end
		end

		return str
	else
		return "None"
	end
end

string.split = function(slot0, slot1)
	if slot1 == nil then
		slot1 = "%s"
	end

	slot2 = {}
	i = 1
	slot6 = slot1

	for slot6 in string.gmatch(slot0, "([^" .. slot6 .. "]+)") do
		slot2[i] = slot6
		i = i + 1
	end

	return slot2
end

jopa = function(slot0, slot1)
	if slot1 == nil then
		slot1 = "%s"
	end

	slot2 = {}
	slot6 = slot1

	for slot6 in string.gmatch(slot0, "([^" .. slot6 .. "]+)") do
		table.insert(slot2, slot6)
	end

	return slot2
end

strToIdKeys = function(slot0)
	tKeys = string.split(slot0, "+")

	if #tKeys ~= 0 then
		for slot4 = 1, #tKeys do
			slot0 = (slot4 ~= 1 or uv0.name_to_id(tKeys[slot4], false)) and uv0.name_to_id(tKeys[slot4], false) .. " " .. uv0.name_to_id(tKeys[slot4], false)
		end

		return tostring(slot0)
	else
		return "(("
	end
end

isKeysDown = function(slot0, slot1)
	slot2 = string.split(slot0, " ")

	if slot1 == nil then
		slot1 = false
	end

	if slot2[1] == nil then
		return false
	end

	slot3 = false
	slot4 = #slot2 < 2 and tonumber(slot2[1]) or tonumber(slot2[2])
	slot5 = tonumber(slot2[1])

	if #slot2 < 2 then
		if not isKeyDown(VK_RMENU) and not isKeyDown(VK_LMENU) and not isKeyDown(VK_LSHIFT) and not isKeyDown(VK_RSHIFT) and not isKeyDown(VK_LCONTROL) and not isKeyDown(VK_RCONTROL) then
			if wasKeyPressed(slot4) and not slot1 then
				slot3 = true
			elseif isKeyDown(slot4) and slot1 then
				slot3 = true
			end
		end
	elseif isKeyDown(slot5) and not wasKeyReleased(slot5) then
		if wasKeyPressed(slot4) and not slot1 then
			slot3 = true
		elseif isKeyDown(slot4) and slot1 then
			slot3 = true
		end
	end

	if nextLockKey == slot0 then
		if slot1 and not wasKeyReleased(slot4) then
			slot3 = false
		else
			slot3 = false
			nextLockKey = ""
		end
	end

	return slot3
end

HeaderButton = function(slot0, slot1)
	slot2 = uv0.GetWindowDrawList()
	slot3 = uv0.ColorConvertFloat4ToU32
	slot4 = false
	slot5 = string.gsub(slot1, "##.*$", "")
	slot6 = {
		0.5,
		0.3
	}
	slot7 = {
		idle = uv0.GetStyle().Colors[uv0.Col.TextDisabled],
		hovr = uv0.GetStyle().Colors[uv0.Col.Text],
		slct = uv0.GetStyle().Colors[uv0.Col.ButtonActive]
	}

	if not AI_HEADERBUT then
		AI_HEADERBUT = {}
	end

	if not AI_HEADERBUT[slot1] then
		AI_HEADERBUT[slot1] = {
			color = slot0 and slot7.slct or slot7.idle,
			clock = os.clock() + slot6[1],
			h = {
				state = slot0,
				alpha = slot0 and 1 or 0,
				clock = os.clock() + slot6[2]
			}
		}
	end

	slot8 = AI_HEADERBUT[slot1]

	slot9 = function(slot0, slot1, slot2, slot3)
		slot4 = slot0

		if os.clock() - slot2 >= 0 then
			slot6 = {
				x = slot1.x - slot0.x,
				y = slot1.y - slot0.y,
				z = slot1.z - slot0.z,
				w = slot1.w - slot0.w
			}
			slot4.x = slot4.x + slot6.x / slot3 * slot5
			slot4.y = slot4.y + slot6.y / slot3 * slot5
			slot4.z = slot4.z + slot6.z / slot3 * slot5
			slot4.w = slot4.w + slot6.w / slot3 * slot5
		end

		return slot4
	end

	slot10 = function(slot0, slot1, slot2, slot3)
		slot4 = slot0

		if os.clock() - slot2 >= 0 then
			slot4 = slot4 + (slot1 - slot0) / slot3 * slot5
		end

		return slot4
	end

	slot11 = function(slot0, slot1)
		return uv0.ImVec4(slot0.x, slot0.y, slot0.z, slot1 or 1)
	end

	uv0.BeginGroup()

	slot12 = uv0.GetCursorPos()
	slot13 = uv0.GetCursorScreenPos()

	uv0.TextColored(slot8.color, slot5)

	slot14 = uv0.GetItemRectSize()
	slot16 = uv0.IsItemClicked()

	if slot8.h.state ~= uv0.IsItemHovered() and not slot0 then
		slot8.h.state = slot15
		slot8.h.clock = os.clock()
	end

	if slot16 then
		slot8.clock = os.clock()
		slot4 = true
	end

	if os.clock() - slot8.clock <= slot6[1] then
		slot8.color = slot9(uv0.ImVec4(slot8.color), slot0 and slot7.slct or slot15 and slot7.hovr or slot7.idle, slot8.clock, slot6[1])
	else
		slot17 = slot0 and slot7.slct or slot15 and slot7.hovr or slot7.idle
		slot8.color = slot17
	end

	if slot8.h.clock ~= nil then
		if os.clock() - slot8.h.clock <= slot6[2] then
			slot8.h.alpha = slot10(slot8.h.alpha, slot8.h.state and 1 or 0, slot8.h.clock, slot6[2])
		else
			slot8.h.alpha = slot8.h.state and 1 or 0

			if not slot8.h.state then
				slot8.h.clock = nil
			end
		end

		slot17 = slot14.x / 2
		slot18 = slot13.y + slot14.y + 3
		slot19 = slot13.x + slot17

		slot2:AddLine(uv0.ImVec2(slot19, slot18), uv0.ImVec2(slot19 + slot17 * slot8.h.alpha, slot18), slot3(slot11(slot8.color, slot8.h.alpha)), 3)
		slot2:AddLine(uv0.ImVec2(slot19, slot18), uv0.ImVec2(slot19 - slot17 * slot8.h.alpha, slot18), slot3(slot11(slot8.color, slot8.h.alpha)), 3)
	end

	uv0.EndGroup()

	return slot4
end

where = function(slot0)
	if slot0 == "" then
		TriggerNotification("Используйте: /where (id).")
	else
		result = sampIsPlayerConnected(slot0)

		if not result then
			TriggerNotification("Игрок не в сети или неверно указан ID.")
		else
			slot1 = string.gsub(sampGetPlayerNickname(slot0), "_", " ")
			slot2 = sampIsPlayerNpc(slot0)
			uv0, uv1 = string.match(sampGetPlayerNickname(slot0), "(%S+)_(%S+)")

			if offtagValue then
				if active_rValue then
					if newwhereValue == "" then
						sampSendChat("/r [" .. u8:decode(rtextValue) .. "]: " .. slot1 .. ", доложите Ваше местоположение, на ответ 10 секунд!")
					else
						sampSendChat(string.format("/r [%s]: %s", u8:decode(rtextValue), u8:decode(newwhereValue)))
					end
				elseif newwhereValue == "" then
					sampSendChat("/r " .. slot1 .. ", доложите Ваше местоположение, на ответ 10 секунд!")
				else
					sampSendChat(string.format("/r %s", u8:decode(newwhereValue)))
				end
			elseif newwhereValue == "" then
				sampSendChat("/r " .. slot1 .. ", доложите Ваше местоположение, на ответ 10 секунд!")
			else
				sampSendChat(string.format("/r %s", u8:decode(newwhereValue)))
			end
		end

		sampGetPlayerIdByNickname = function(slot0)
			slot1, slot2 = sampGetPlayerIdByCharHandle(playerPed)

			if tostring(slot0) == sampGetPlayerNickname(slot2) then
				return slot2
			end

			for slot6 = 0, 1000 do
				if sampIsPlayerConnected(slot6) and sampGetPlayerNickname(slot6) == tostring(slot0) then
					return slot6
				end
			end
		end
	end
end

cmd_id = function(slot0)
	if slot0 == "" then
		TriggerNotification("Используйте: /id (id).")
	else
		result = sampIsPlayerConnected(slot0)

		if not result then
			TriggerNotification("Игрок не в сети или неверно указан ID.")
		else
			if not tonumber(slot0) then
				removeBlip(uv0)
				TriggerNotification("Используйте /id (id).")

				return false
			end

			idlvl = sampGetPlayerScore(slot1)
			nickgg = sampGetPlayerNickname(slot1)

			setClipboardText(nickgg)

			idnaid = true

			sampSendChat("/id " .. slot1)
		end
	end
end

cmd_number = function(slot0)
	if not VipStatus then
		TriggerNotification("Данная команда доступна только VIP пользователям.")

		return
	end

	if slot0.match(slot0, "^%d+") then
		if sampIsPlayerConnected(slot0.match(slot0, "^(%d+)")) or myID == tonumber(slot0) then
			async_http_request("POST", "https://hora.su/getNmbr.php", {
				data = "srv=" .. srv .. "&n=" .. sampGetPlayerNickname(slot1) .. "&number=" .. tostring(playerAccoutNumber),
				headers = {
					["content-type"] = "application/x-www-form-urlencoded"
				}
			}, function (slot0)
				phonenumber = slot0.text

				print(phonenumber)

				if phonenumber == "Данного аккаунта нет." or phonenumber == "0" then
					AddChatMessage(uv0 .. " нет в базе данных.")
				else
					AddChatMessage("Номер " .. uv0 .. ": " .. phonenumber)
				end
			end, function (slot0)
				print("getnumber: " .. slot0)

				if slot0 then
					truehttpgetnumber = true
				end
			end)

			return
		end

		TriggerNotification("Игрок с данным ID не подключен к серверу.")
	else
		TriggerNotification("Используйте: /number (id).")
	end
end

autosobes = function(slot0)
	if slot0.match(slot0, "^%d+") then
		if sampIsPlayerConnected(slot0.match(slot0, "^(%d+)")) or myID == tonumber(slot0) then
			slot2 = sampGetPlayerNickname(slot1)
			slot2 = slot2:gsub("_", " ")

			lua_thread.create(function ()
				sobesid = uv0

				sampSendChat("Скажите пожалуйста, как Вас зовут? Сколько Вам лет? Где проживаете?")
				wait(500)
				TriggerNotification("Чтобы продолжить нажмите F1 (Дальше), F2 (Отмена).")

				pressrpinv1 = true
			end)
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу.")
		end

		return
	end

	TriggerNotification("Используйте: /sobes (id).")
end

cmd_ticketred = function()
	if not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	uv0 = 0
	uv1.smartticket_active[0] = not uv1.smartticket_active[0]
	uv2.Process = uv1.smartticket_active[0]
end

cmd_ticket = function(slot0)
	if not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	if slot0.match(slot0, "^%d+%s%d+%s.*") then
		slot1, slot2, slot3 = slot0.match(slot0, "^(%d+)%s(%d+)%s(.*)")

		if rpticketValue then
			lua_thread.create(function ()
				if newrpticketValue == "" then
					sampSendChat("/me достав из кармана ручку и штрафной бланк, " .. (ladyValue and "внесла" or "внёс") .. " данные о нарушении.")
				else
					sampSendChat(string.format("%s", u8:decode(newrpticketValue)))
				end

				wait(555)

				if newrpticket2Value == "-" then
					-- Nothing
				elseif newrpticket2Value == "" then
					sampSendChat("/me " .. (ladyValue and "передала" or "передал") .. " штрафной бланк на подпись.")
				else
					sampSendChat(string.format("%s", u8:decode(newrpticket2Value)))
				end

				wait(555)
			end)
		end

		sampSendChat("/ticket " .. slot1 .. " " .. slot2 .. " " .. slot3)
	elseif slot0.match(slot0, "^%d+") then
		if sampIsPlayerConnected(slot0.match(slot0, "^(%d+)")) or myID == tonumber(slot0) then
			id = slot1
			uv0.smartticket[0] = not uv0.smartticket[0]
			uv1.Process = uv0.smartticket[0]
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу.")
		end
	else
		TriggerNotification("Используйте: /ticket (id).")
	end
end

cmd_su = function(slot0)
	if not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	if slot0.match(slot0, "^%d+%s%d+%s.*") then
		slot1, slot2, slot3 = slot0.match(slot0, "^(%d+)%s(%d+)%s(.*)")
		uv0, uv1 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

		if rpsuValue then
			lua_thread.create(function ()
				if newrpsuValue == "" then
					sampSendChat("/me " .. (ladyValue and "сообщила" or "сообщил") .. " диспетчеру по рации приметы подозреваемого")
				else
					sampSendChat(string.format("%s", u8:decode(newrpsuValue)))
				end

				wait(555)
			end)
		end

		newrsn = slot3
		idprsn = slot1
		timerdlyasu = true

		sampSendChat("/su " .. slot1 .. " " .. slot2 .. " " .. slot3)
	elseif slot0.match(slot0, "^%d+") then
		if sampIsPlayerConnected(slot0.match(slot0, "^(%d+)")) or myID == tonumber(slot0) then
			id = slot1
			uv2.smartsu[0] = not uv2.smartsu[0]
			uv3.Process = uv2.smartsu[0]
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу.")
		end
	else
		TriggerNotification("Используйте: /su (id) (кол-во звезд) (причина).")
	end
end

cmd_sured = function()
	if not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	uv0 = 0
	uv1.smartsu_active[0] = not uv1.smartsu_active[0]
	uv2.Process = uv1.smartsu_active[0]
end

donor = function(slot0)
	if isPlayerSoldierMed then
		if slot0.match(slot0, "^%d+") then
			if sampIsPlayerConnected(slot0.match(slot0, "^(%d+)")) or myID == tonumber(slot0) then
				slot2 = sampGetPlayerNickname(slot1)
				slot2 = slot2:gsub("_", " ")

				lua_thread.create(function ()
					sobesid = uv0

					sampSendChat("Здравствуйте, Вы пришли на акцию ''Донор''. Представьтесь, пожалуйста.")
					wait(500)
					TriggerNotification("Чтобы продолжить нажмите F1 (Дальше), F2 (Отмена).")

					pressrpdonor1 = true
				end)
			else
				TriggerNotification("Игрок с данным ID не подключен к серверу.")
			end

			return
		end

		TriggerNotification("Используйте: /donor (id).")
	end
end

vizovvchat = function(slot0)
	if slot0 == "" then
		TriggerNotification("Используйте: /wr (id).")
	else
		result = sampIsPlayerConnected(slot0)

		if not result then
			TriggerNotification("Игрок не в сети или неверно указан ID.")
		else
			slot1 = string.gsub(sampGetPlayerNickname(slot0), "_", " ")
			slot2 = sampIsPlayerNpc(slot0)

			if active_rValue then
				sampSendChat("/r [" .. u8:decode(rtextValue) .. "]: " .. slot1 .. ", прием, выйдите на связь!")
			else
				sampSendChat("/r " .. slot1 .. ", прием, выйдите на связь!")
			end
		end

		sampGetPlayerIdByNickname = function(slot0)
			slot1, slot2 = sampGetPlayerIdByCharHandle(playerPed)

			if tostring(slot0) == sampGetPlayerNickname(slot2) then
				return slot2
			end

			for slot6 = 0, 1000 do
				if sampIsPlayerConnected(slot6) and sampGetPlayerNickname(slot6) == tostring(slot0) then
					return slot6
				end
			end
		end
	end
end

fradio = function(slot0)
	if #slot0.match(slot0, "^.*") > 0 then
		slot1 = slot0.match(slot0, "^(.*)")

		if active_fValue then
			if active_racValue then
				sampSendChat(string.format("/f [%s] [%s]: %s", u8:decode(ftextValue), u8:decode(accentValue), slot1))
			else
				sampSendChat(string.format("/f [%s]: %s", u8:decode(ftextValue), slot1))
			end
		elseif active_racValue then
			sampSendChat(string.format("/f [%s]: %s", u8:decode(accentValue), slot1))
		else
			sampSendChat(string.format("/f %s", slot1))
		end
	else
		TriggerNotification("Используйте: /f (text).")
	end
end

startnh = function()
	uv0.binder_window[0] = not uv0.binder_window[0]
	uv1.Process = uv0.binder_window[0]
end

startvipinfo = function()
	if not VipStatus then
		TriggerNotification("Данная команда доступна только VIP пользователям.")

		return
	end

	uv0.vipstats[0] = not uv0.vipstats[0]
	uv1.Process = uv0.vipstats[0]
end

startanimlist = function()
	uv0.animlist[0] = not uv0.animlist[0]
	uv1.Process = uv0.animlist[0]
end

startmakegun = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierGhetto then
		TriggerNotification("Данная команда доступна только бандитам.")

		return
	end

	if slot0.match(slot0, "^%d+%s.*") then
		slot1, slot2 = slot0.match(slot0, "^(%d+)%s(.*)")

		sampSendChat("/makegun " .. slot1 .. " " .. slot2)
	else
		uv1.makegun[0] = not uv1.makegun[0]
		uv2.Process = uv1.makegun[0]
	end
end

cmd_vipinfo = function()
	uv0.vipinfo[0] = not uv0.vipinfo[0]
	uv1.Process = uv0.vipinfo[0]
end

healincar = function(slot0)
	if not isPlayerSoldierMed then
		return
	end

	if slot0 == "" then
		TriggerNotification("Используйте: /heal (id).")

		return
	end

	lua_thread.create(function ()
		if rphealValue then
			slot0 = 777

			sampSendChat("/me внимательно осмотрев пациента, " .. (ladyValue and "поставила" or "поставил") .. " диагноз.")
			wait(slot0)
			sampSendChat("/do У " .. nickName .. " через плечо надета мед.сумка с лекарствами.")
			wait(slot0)
			sampSendChat("/todo Открыв сумку* Вызов врача Вам обойдётся " .. viezdpriceValue .. "$.")
			wait(slot0)
			sampSendChat("/me " .. (ladyValue and "достала" or "достал") .. " лекарство и " .. (ladyValue and "передала" or "передал") .. " человеку напротив.")
			wait(222)
		end

		sampSendChat("/heal " .. uv0 .. " " .. viezdpriceValue)
	end)
end

otchet = function(slot0)
	lua_thread.create(function ()
		if uv0:match("^%d+") then
			if uv0:match("^(%d+)") == "1" then
				otchet1 = true

				sampProcessChatInput("/c 60")
				sampCloseCurrentDialogWithButton(1)
				sampSendChat("/mn")
			end

			if slot0 == "2" then
				sampProcessChatInput("/c 60")
				sampSendChat("/lic " .. myID)
				wait(200)
				makeScreenshot()
				wait(200)
			end

			if slot0 == "3" then
				sampProcessChatInput("/c 60")
				sampSendChat("/med")
				wait(400)
				makeScreenshot()
				sampCloseCurrentDialogWithButton(1)
			end

			if slot0 == "4" then
				sampProcessChatInput("/c 60")
				sampSendChat("/skill " .. myID)
				wait(400)
				makeScreenshot()
				sampCloseCurrentDialogWithButton(1)
			end

			if slot0 == "5" then
				sampProcessChatInput("/c 60")
				sampSendChat("/team " .. myID)
				wait(400)
				makeScreenshot()
				sampCloseCurrentDialogWithButton(0)
			end

			if slot0 == "6" then
				sampProcessChatInput("/c 60")
				sampSendChat("/pass " .. myID)
				wait(400)
				makeScreenshot()
				sampCloseCurrentDialogWithButton(0)
			end

			if slot0 == "7" then
				sampProcessChatInput("/c 60")
				sampSendChat("/show " .. myID)
				wait(400)
				makeScreenshot()
				sampCloseCurrentDialogWithButton(0)
			end

			if slot0 == "8" then
				sampProcessChatInput("/c 60")
				sampSendChat("/wbook " .. myID)
				wait(400)
				makeScreenshot()
				sampCloseCurrentDialogWithButton(0)
			end

			if slot0 == "9" then
				sampProcessChatInput("/c 60")
				sampSendChat("/history " .. userNick)
				wait(400)
				makeScreenshot()
				sampCloseCurrentDialogWithButton(0)
			end
		else
			TriggerNotification("6 - /pass | 7 - /show | 8 - /wbook | 9 - /history")
			TriggerNotification("1 - /mn 1 | 2 - /lic | 3 - /med | 4 - /skill | 5- /team")
			TriggerNotification("Используйте: /dfr (id)")
		end
	end)
end

rradio = function(slot0)
	if mtag ~= "M" then
		if #slot0.match(slot0, "^.*") > 0 then
			if slot0:match("^(.*)"):find("%(%(") or slot1:find("%)%)") or slot1:find("%)") or slot1:find("%(") then
				TriggerNotification("Сообщение определено как OOC и автоматически обработано. ")
				sampSendChat(string.format("/r (( %s ))", slot1:gsub("%(", ""):gsub("%)", "")))
			elseif active_rValue then
				if active_racValue then
					sampSendChat(string.format("/r [%s] [%s]: %s", u8:decode(rtextValue), u8:decode(accentValue), slot1))
				else
					sampSendChat(string.format("/r [%s]: %s", u8:decode(rtextValue), slot1))
				end
			elseif active_racValue then
				sampSendChat(string.format("/r [%s]: %s", u8:decode(accentValue), slot1))
			else
				sampSendChat(string.format("/r %s", slot1))
			end
		else
			TriggerNotification("Используйте: /r (text).")
		end
	else
		TriggerNotification("Вам недоступна данная рация.")
	end
end

cmd_rd = function(slot0)
	if slot0.match(slot0, "^.*%s.*") then
		slot1, slot2 = slot0.match(slot0, "^(.*)%s(.*)")

		lua_thread.create(function ()
			slot0 = u8:decode(dokladValue and dokladValue ~= "" and dokladValue or nick_player2)

			if active_rValue then
				sampSendChat(string.format("/r [" .. u8:decode(rtextValue) .. "]: Докладывает " .. slot0 .. ". Пост: " .. uv0 .. ". Код: " .. uv1))
			else
				sampSendChat(string.format("/r Докладывает " .. slot0 .. ". Пост: " .. uv0 .. ". Код: " .. uv1))
			end

			if autoscValue then
				sampProcessChatInput("/c 60")
				wait(1111)
				makeScreenshot()
			end
		end)

		return
	end

	TriggerNotification("Используйте: /rd (Пост) (Код).")
end

cmd_fd = function(slot0)
	if slot0.match(slot0, "^.*%s.*") then
		slot1, slot2 = slot0.match(slot0, "^(.*)%s(.*)")

		lua_thread.create(function ()
			slot0 = u8:decode(dokladValue and dokladValue ~= "" and dokladValue or nick_player2)

			if active_fValue then
				sampSendChat(string.format("/f [" .. u8:decode(ftextValue) .. "]: Докладывает " .. slot0 .. ". Пост: " .. uv0 .. ". Код: " .. uv1))
			else
				sampSendChat(string.format("/f Докладывает " .. slot0 .. ". Пост: " .. uv0 .. ". Код: " .. uv1))
			end

			if autoscValue then
				sampProcessChatInput("/c 60")
				wait(1111)
				makeScreenshot()
			end
		end)

		return
	end

	TriggerNotification("Используйте: /fd (Пост) (Код).")
end

ex_skin = function(slot0)
	if nasosal_rang <= 7 then
		TriggerNotification("Данная команда доступна с 8 ранга.")

		return
	end

	if slot0.match(slot0, "^%d+") then
		slot1 = slot0:match("^(%d+)")
		uv0, uv1 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

		if sampIsPlayerConnected(slot1) or myID == tonumber(slot0) then
			slot3 = sampGetPlayerNickname(slot1)
			slot3 = slot3:gsub("_", " ")

			lua_thread.create(function ()
				if rpskinValue then
					if newrpskin1Value == "" then
						sampSendChat("/do В руках заранее подготовленный комплект с формой.")
					else
						sampSendChat(string.format("%s", u8:decode(newrpskin1Value)))
					end

					wait(777)

					if newrpskin2Value == "-" then
						-- Nothing
					elseif newrpskin2Value == "" then
						sampSendChat(string.format("/me " .. (ladyValue and "передала" or "выдал") .. " пакет с формой для %s", uv0))
					else
						sampSendChat(string.format("%s", u8:decode(newrpskin2Value)))
					end

					wait(444)
				end

				sampSendChat(string.format("/changeskin %d", uv1))
			end)
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу.")
		end

		return
	end

	TriggerNotification("Используйте: /changeskin (id).")
end

ex_uninvite = function(slot0)
	if nasosal_rang <= 7 then
		TriggerNotification("Данная команда доступна с 8 ранга.")

		return
	end

	if not slot0.match(slot0, "^%d+%s.*") then
		TriggerNotification("Используйте: /uninvite (id) (Причина).")

		return
	end

	slot1, slot2 = slot0.match(slot0, "^(%d+)%s(.*)")

	if not sampIsPlayerConnected(slot1) then
		TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")

		return
	end

	slot3 = sampGetPlayerNickname(slot1)
	slot3 = slot3:gsub("_", " ")

	lua_thread.create(function ()
		slot0 = function(slot0, slot1)
			if slot0 == "" then
				sampSendChat(slot1)
			else
				sampSendChat(u8:decode(slot0))
			end
		end

		slot1 = function()
			wait(777)
		end

		slot2 = isPlayerSoldier and string.format("/me " .. (ladyValue and "достала" or "достал") .. " КПК, после чего " .. (ladyValue and "зашла" or "зашел") .. " в базу данных военнослужащих.") or string.format("/me " .. (ladyValue and "достала" or "достал") .. " КПК, после чего " .. (ladyValue and "зашла" or "зашел") .. " в базу данных сотрудников.")
		slot3 = string.format("/me " .. (ladyValue and "отметила" or "отметил") .. " личное дело %s как «Уволен».", uv0)
		slot4 = string.format("/f %s %s был отправлен в отставку.", isPlayerSoldier and "Боец" or "Сотрудник", uv0)
		slot5 = string.format("/f Причина %s: %s", isPlayerSoldier and "отставки" or "увольнения", uv1)

		if rpuninvValue then
			slot0(rpuninvnew1Value, slot2)
			slot1()

			if rpuninvnew2Value ~= "-" then
				slot0(rpuninvnew2Value, slot3)
			end

			wait(250)

			if active_fValue then
				sampSendChat(string.format("/f [%s]: %s был уволен.", u8:decode(ftextValue), uv0))
				wait(500)
				sampSendChat(string.format("/f [%s]: Причина увольнения: %s", u8:decode(ftextValue), uv1))
			else
				sampSendChat(slot4)
				wait(500)
				sampSendChat(slot5)
			end
		end

		wait(250)
		sampSendChat(string.format("/uninvite %d %s", uv2, uv1))
	end)
end

ex_invite = function(slot0)
	if nasosal_rang <= 8 then
		TriggerNotification("Данная команда доступна с 9 ранга.")

		return
	end

	if not slot0.match(slot0, "^%d+") then
		TriggerNotification("Используйте: /invite (id).")

		return
	end

	if not sampIsPlayerConnected(slot0.match(slot0, "^(%d+)")) then
		TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")

		return
	end

	slot2 = sampGetPlayerNickname(slot1)
	unamerr = slot2:gsub("_", " ")

	lua_thread.create(function ()
		slot0 = function(slot0, slot1)
			if slot0 == "" then
				sampSendChat(slot1)
			else
				sampSendChat(u8:decode(slot0))
			end
		end

		slot1 = function()
			wait(777)
		end

		if rpinvValue then
			slot3 = isPlayerSoldier and string.format("/me " .. (ladyValue and "передала" or "выдал") .. " пакет новобранцу по имени %s", uv0) or string.format("/me " .. (ladyValue and "передала" or "выдал") .. " пакет сотруднику по имени %s", uv0)
			slot4 = string.format("%s, переодевайтесь, рацию на пояс.", uv0)

			slot0(newrpinv1Value, isPlayerSoldier and "/do В руках пакет с новой военной формой и рацией." or "/do В руках пакет с новой формой и рацией.")
			slot1()

			if newrpinv2Value ~= "-" then
				slot0(newrpinv2Value, slot3)
			end

			slot1()

			if newrpinv3Value ~= "-" then
				slot0(newrpinv3Value, slot4)
			end

			wait(100)
		end

		sampSendChat(string.format("/invite %d", uv1))

		hiinvite = true
	end)
end

ex_rang = function(slot0)
	if nasosal_rang <= 8 then
		TriggerNotification("Данная команда доступна с 9 ранга.")

		return
	end

	if slot0.match(slot0, "^%d+%s%d+%s.*") then
		slot1, slot2, slot3 = slot0:match("^(%d+)%s(%d+)%s(.*)")
		uv0, uv1 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")
		slot2 = tonumber(slot2)

		if sampIsPlayerConnected(slot1) then
			lua_thread.create(function ()
				if uv0 <= 0 or uv0 >= 5 then
					TriggerNotification("Ограничение на количество повышения от 1 до 4.")

					return
				end

				if isPlayerSoldier then
					if rprangValue then
						slot0 = sampGetPlayerNickname(uv1):gsub("_", " ")

						if newrprang1Value == "" then
							sampSendChat("/do Сумка с новыми погонами в руке.")
						else
							sampSendChat(string.format("%s", u8:decode(newrprang1Value)))
						end

						wait(777)

						if newrprang2Value == "-" then
							-- Nothing
						elseif newrprang2Value == "" then
							sampSendChat(string.format("/me " .. (ladyValue and "открыла" or "открыл") .. " сумку с погонами и " .. (ladyValue and "достала" or "достал") .. " нужные для %s", slot0))
						else
							sampSendChat(string.format("%s", u8:decode(newrprang2Value)))
						end

						wait(777)

						if newrprang3Value == "-" then
							-- Nothing
						elseif newrprang3Value == "" then
							sampSendChat(string.format("/me " .. (ladyValue and "передала" or "выдал") .. " новые погоны %s", slot0))
						else
							sampSendChat(string.format("%s", u8:decode(newrprang3Value)))
						end

						wait(500)
						sampSendChat("/anim 21")
					end
				elseif rprangValue then
					slot0 = sampGetPlayerNickname(uv1):gsub("_", " ")

					if newrprang1Value == "" then
						sampSendChat(string.format("/me " .. (ladyValue and "достала" or "достал") .. " телефон и " .. (ladyValue and "открыла" or "открыл") .. " список сотрудников."))
					else
						sampSendChat(string.format("%s", u8:decode(newrprang1Value)))
					end

					wait(777)

					if newrprang2Value == "-" then
						-- Nothing
					elseif newrprang2Value == "" then
						sampSendChat(string.format("/me " .. (ladyValue and "изменила" or "изменил") .. " данные сотрудника %s", slot0))
					else
						sampSendChat(string.format("%s", u8:decode(newrprang2Value)))
					end

					if newrprang3Value ~= "" then
						if newrprang3Value ~= "-" then
							sampSendChat(string.format("%s", u8:decode(newrprang3Value)))
						end
					end

					wait(500)
					sampSendChat("/anim 21")
				end

				if uv2 == "+" then
					for slot3 = 1, uv0 do
						sampSendChat(string.format("/rang %s +", uv1))
						wait(700)
					end
				elseif uv2 == "-" then
					for slot3 = 1, uv0 do
						sampSendChat(string.format("/rang %s -", uv1))
						wait(700)
					end
				else
					TriggerNotification("Вы ввели неверный тип (+/-).")

					return
				end
			end)
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")
		end

		return
	end

	TriggerNotification("Используйте: /rang (id) (Количество) (+/-).")
end

cmd_gate = function()
	if os.time() - uv0 >= 5 then
		uv0 = os.time()

		lua_thread.create(function ()
			if gateOnValue then
				sampSendChat(newrpgate1Value == "" and string.format("/do Камеры наблюдения автоматически распознали лицо %s.", ladyValue and "девушки" or "мужчины") or u8:decode(newrpgate1Value))
				wait(555)

				if newrpgate2Value ~= "-" then
					sampSendChat(newrpgate2Value == "" and "/do После распознания сработали автоматические ворота." or u8:decode(newrpgate2Value))
				end

				wait(150)
			end
		end)
	end

	if gateopenonh then
		gateopenonh = false
	else
		sampSendChat(isPlayerSoldier and "/gate" or "/open")

		autorpgateon = false
	end
end

cmd_lock = function(slot0)
	slot1 = slot0.match(slot0, "^%d+")

	lua_thread.create(function ()
		if rplockValue then
			sampSendChat(newrplockValue == "" and string.format("/me %s ключи от транспорта, после чего %s на кнопку 'open/close'.", ladyValue and "достала" or "достал", ladyValue and "нажала" or "нажал") or u8:decode(newrplockValue))
			wait(222)
		end

		if uv0 then
			sampSendChat(string.format("/lock %d", uv0))
		else
			sampSendChat("/lock")
		end
	end)
end

cmd_nhalava = function()
	if u8:decode(getHalavaa) == "-" or u8:decode(getHalavaa) == "" then
		TriggerNotification("Сейчас мне нечего открывать.")
	else
		lua_thread.create(function ()
			TriggerNotification("Через 5 секунд откроется ссылка в браузере.")
			wait(5000)
			os.execute("explorer " .. u8:decode(getHalavaa))
		end)
	end
end

cmd_mg = function()
	if uv0 ~= "Yes" and not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	lua_thread.create(function ()
		sampSendChat("/m Водитель, остановите ваше транспортное средство!")
		wait(555)
		sampSendChat("/m Прижмитесь к обочине, заглушите двигатель и держите руки на руле!")
		wait(555)
		sampSendChat("/m В случае неподчинения законному требованию будет открыт огонь!")
	end)
end

cmd_meg = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	if not slot0.match(slot0, "^%d+$") then
		TriggerNotification("Используйте: /meg (id).")

		return
	end

	slot1, slot2 = sampGetCharHandleBySampPlayerId(tonumber(slot0))

	if slot1 then
		if isCharInAnyCar(PLAYER_PED) then
			slot4, slot5 = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(slot2))

			if slot4 then
				slot7 = getNameOfVehicleModel(getCarModel(slot3))

				lua_thread.create(function ()
					sampSendChat(string.format("/m Водитель марки %s N-%s, остановите ваше транспортное средство!", uv0, uv1))
					wait(555)
					sampSendChat("/m Пожалуйста, прижмитесь к обочине, заглушите двигатель и ожидайте.")
				end)
			end
		end
	else
		TriggerNotification("Игрока с этим ID нет в зоне стрима. Используйте /mg.")
	end
end

cmd_time = function(slot0)
	if not slot0.match(slot0, "^(%d+)") then
		sampSendChat("/c")

		return
	end

	if slot1 == "60" then
		lua_thread.create(function ()
			if rptimeValue then
				sampSendChat(newrptimeValue == "" and string.format("/me движением руки %s рукав затем %s на часы.", ladyValue and "закатала" or "закатал", ladyValue and "посмотрела" or "посмотрел") or u8:decode(newrptimeValue))
				wait(444)
				sampSendChat(newrptime2Value == "" and string.format("/do На часах: %s ч. %s мин.", os.date("%H"), os.date("%M")) or u8:decode(newrptime2Value))
				wait(444)
			end

			sampSendChat("/c 60")
		end)
	else
		sampSendChat(string.format("/c %d", slot1))
	end
end

cmd_bomb = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierMafia and not isPlayerSoldierGhetto then
		TriggerNotification("Данная команда доступна только нелегалам.")

		return
	end

	if slot0.match(slot0, "^%d+") then
		if "15" > slot0.match(slot0, "^(%d+)") or slot1 > "60" then
			TriggerNotification("Используйте: /bomb (15-60 сек).")
		elseif rpbombValue then
			lua_thread.create(function ()
				if newrpbomb1Value == "" then
					sampSendChat("/me резким движением рук открывает сумку и достает бомбу ''C4''.")
				else
					sampSendChat(string.format("%s", u8:decode(newrpbomb1Value)))
				end

				wait(444)

				if newrpbomb2Value == "" then
					sampSendChat("/me положив её на землю, " .. (ladyValue and "включила" or "включил") .. " на ней таймер на " .. uv0 .. " секунд.")
				else
					sampSendChat(string.format("%s", u8:decode(newrpbomb2Value)))
				end

				wait(444)
				sampSendChat(string.format("/bomb %d", uv0))
			end)
		else
			sampSendChat(string.format("/bomb %d", slot1))
		end

		return
	end

	TriggerNotification("Используйте: /bomb (15-60 сек).")
end

cmd_bag = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice and not isPlayerSoldierMafia then
		TriggerNotification("Данная команда доступна только мафии.")

		return
	end

	if not slot0.match(slot0, "^(%d+)") then
		TriggerNotification("Используйте: /bag (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	if sampIsPlayerConnected(slot1) or myID == tonumber(slot1) then
		slot3 = sampGetPlayerNickname(slot1):gsub("_", " ")

		if rpbagValue then
			lua_thread.create(function ()
				sampSendChat(newrpbagValue == "" and string.format("/me достав черный мешок и %s его на жертву.", ladyValue and "надела" or "надел") or u8:decode(newrpbagValue))
				wait(250)
			end)
		end

		sampSendChat(string.format("/bag %d", slot1))
	else
		TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")
	end
end

cmd_unbag = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice and not isPlayerSoldierMafia then
		TriggerNotification("Данная команда доступна только мафии.")

		return
	end

	if not slot0.match(slot0, "^(%d+)") then
		TriggerNotification("Используйте: /unbag (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	if sampIsPlayerConnected(slot1) or myID == tonumber(slot1) then
		slot3 = sampGetPlayerNickname(slot1)
		slot3 = slot3:gsub("_", " ")

		lua_thread.create(function ()
			if rpbagValue then
				sampSendChat(newrpunbagValue == "" and string.format("/me сняв черный мешок с головы жертвы, %s его в сторону.", ladyValue and "выбросила" or "выбросил") or u8:decode(newrpunbagValue))
			end

			wait(250)
			sampSendChat(string.format("/bag %d", uv0))
		end)
	else
		TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")
	end
end

cmd_tie = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice and not isPlayerSoldierMafia then
		TriggerNotification("Данная команда доступна только мафии.")

		return
	end

	if not slot0.match(slot0, "^(%d+)") then
		TriggerNotification("Используйте: /tie (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	if sampIsPlayerConnected(slot1) or myID == tonumber(slot1) then
		slot3 = sampGetPlayerNickname(slot1)
		slot3 = slot3:gsub("_", " ")

		lua_thread.create(function ()
			if rptieValue then
				sampSendChat(newrptieValue == "" and string.format("/me достав верёвку %s руки жертве.", ladyValue and "связала" or "связал") or u8:decode(newrptieValue))
			end

			wait(250)
			sampSendChat(string.format("/tie %d", uv0))
		end)
	else
		TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")
	end
end

cmd_untie = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice and not isPlayerSoldierMafia then
		TriggerNotification("Данная команда доступна только мафии.")

		return
	end

	if not slot0.match(slot0, "^(%d+)") then
		TriggerNotification("Используйте: /untie (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	if sampIsPlayerConnected(slot1) or myID == tonumber(slot1) then
		slot3 = sampGetPlayerNickname(slot1)
		slot3 = slot3:gsub("_", " ")

		lua_thread.create(function ()
			if rptieValue then
				sampSendChat(newrpuntieValue == "" and string.format("/me %s руки жертве выбросив веревку в сторону.", ladyValue and "развязала" or "развязал") or u8:decode(newrpuntieValue))
			end

			wait(250)
			sampSendChat(string.format("/tie %d", uv0))
		end)
	else
		TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")
	end
end

rel = function()
	AddChatMessage("Скрипт перезагружается.")
	thisScript():reload()
end

cmd_clear = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	if slot0.match(slot0, "^%d+%s.*") then
		slot1, slot2 = slot0:match("^(%d+)%s(.*)")
		uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

		if sampIsPlayerConnected(slot1) or myID == tonumber(slot1) then
			slot4 = sampGetPlayerNickname(slot1)
			slot4 = slot4:gsub("_", " ")

			lua_thread.create(function ()
				if clearValue then
					if rpclearValue == "" then
						sampSendChat("/me " .. (ladyValue and "сделала" or "сделал") .. " запрос диспетчеру по рации на вынос подозреваемого с базы данных.")
					else
						sampSendChat(string.format("%s", u8:decode(rpclearValue)))
					end

					wait(555)

					if active_fValue then
						sampSendChat(string.format("/f [%s]: Гражданин %s удален из списка розыскиваемых.", u8:decode(ftextValue), uv0))
						wait(500)
						sampSendChat(string.format("/f [%s]: По причине: %s", u8:decode(ftextValue), uv1))
					else
						sampSendChat(string.format("/f Гражданин %s удален из списка розыскиваемых.", uv0))
						wait(500)
						sampSendChat(string.format("/f По причине: %s", uv1))
					end
				end

				wait(250)
				sampSendChat(string.format("/clear %d %s", uv2, uv1))
			end)
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")
		end

		return
	end

	if slot0.match(slot0, "^%d+") then
		slot1 = slot0:match("^(%d+)")
		uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

		if sampIsPlayerConnected(slot1) or myID == tonumber(slot1) then
			slot3 = sampGetPlayerNickname(slot1)
			slot3 = slot3:gsub("_", " ")

			lua_thread.create(function ()
				if clearValue then
					if rpclearValue == "" then
						sampSendChat("/me " .. (ladyValue and "сделала" or "сделал") .. " запрос диспетчеру по рации на вынос подозреваемого с базы данных.")
					else
						sampSendChat(string.format("%s", u8:decode(rpclearValue)))
					end

					wait(555)
				end

				wait(250)
				sampSendChat(string.format("/clear %d", uv0))
			end)
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")
		end
	else
		TriggerNotification("Используйте: /clear (id) (Причина).")
	end
end

cmdedir = function()
	if nasosal_rang <= 2 and isPlayerMassMedia or not isPlayerMassMedia then
		TriggerNotification("Вам не доступна данная команда.")

		return
	end

	uv0 = not uv0

	lua_thread.create(function ()
		if uv0 then
			if efirValue then
				if muzprivValue then
					sampSendChat(string.format("/t %s", u8:decode(muzprivrpValue)))
				end

				wait(777)
				sampSendChat("/efir")
				sampSendChat(endrpefir1Value == "" and string.format("/me выключив аппаратуру, %s с прямого эфира.", ladyValue and "вышла" or "вышел") or u8:decode(endrpefir1Value))
				wait(555)

				if endrpefir2Value ~= "-" then
					sampSendChat(endrpefir2Value == "" and string.format("/me сняв наушники, %s их.", ladyValue and "положила" or "положил") or u8:decode(endrpefir2Value))
				end
			end
		elseif efirValue then
			sampSendChat(rpefir1Value == "" and string.format("/me взяв наушники, %s их.", ladyValue and "надела" or "надел") or u8:decode(rpefir1Value))
			wait(555)

			if rpefir2Value ~= "-" then
				sampSendChat(rpefir2Value == "" and string.format("/me включив аппаратуру, %s в прямой эфир.", ladyValue and "вышла" or "вышел") or u8:decode(rpefir2Value))
			end

			wait(500)
			sampSendChat("/efir")

			if muzprivValue then
				wait(1000)
				sampSendChat(string.format("/t %s", u8:decode(muzprivrpValue)))
			end
		end

		if not efirValue then
			sampSendChat("/efir")
		end
	end)
end

cmdfree = function(slot0)
	if uv0 ~= "Yes" and (nasosal_rang <= 4 and isPlayerGoverment or not isPlayerGoverment) then
		TriggerNotification("Вам не доступна данная команда.")

		return
	end

	slot1, slot2 = slot0.match(slot0, "^(%d+)%s(.*)")

	if not slot1 or not slot2 then
		TriggerNotification("Используйте: /free (id) (Причина).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	if sampIsPlayerConnected(slot1) then
		slot4 = sampGetPlayerNickname(slot1)
		slot4 = slot4:gsub("_", " ")

		lua_thread.create(function ()
			if freeValue then
				sampSendChat(rpfreeValue == "" and string.format("/me достав планшет из сумки, %s искать данные о подсудимом.", ladyValue and "начала" or "начал") or u8:decode(rpfreeValue))
				wait(555)

				if rpfree2Value ~= "-" then
					sampSendChat(rpfree2Value == "" and string.format("/me %s запись в базе и %s планшет обратно в сумку.", ladyValue and "обновила" or "обновил", ladyValue and "убрала" or "убрал") or u8:decode(rpfree2Value))
				end
			end

			wait(250)
			sampSendChat(string.format("/free %d %s", uv0, uv1))
		end)
	else
		TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")
	end
end

cmdgivelic = function(slot0)
	if uv0 ~= "Yes" and (nasosal_rang <= 5 and isPlayerGoverment or not isPlayerGoverment) then
		TriggerNotification("Вам не доступна данная команда.")

		return
	end

	slot1, slot2, slot3 = slot0.match(slot0, "^(%d+)%s(%d+)%s(.*)")

	if not slot1 or not slot2 or not slot3 then
		TriggerNotification("Типы: 1 - транспорт | 2 - оружие.")
		TriggerNotification("Используйте: /givelic (id) (тип лицензии) (цена).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	if rpgivelicValue then
		lua_thread.create(function ()
			sampSendChat(givelicrpValue == "" and string.format("/me %s планшет из сумки и %s искать данные по лицензиям.", ladyValue and "достала" or "достал", ladyValue and "начала" or "начал") or u8:decode(givelicrpValue))
			wait(555)

			if givelicrp2Value ~= "-" then
				sampSendChat(givelicrp2Value == "" and string.format("/me %s запись в базе данных и %s клиенту лицензию.", ladyValue and "обновила" or "обновил", ladyValue and "выдала" or "выдал") or u8:decode(givelicrp2Value))
			end

			wait(555)
		end)
	end

	sampSendChat(string.format("/givelic %d %d %s", slot1, slot2, slot3))
end

cmd_takelic = function(slot0)
	if uv0 ~= "Yes" and (nasosal_rang <= 4 and isPlayerSoldierPolice or not isPlayerSoldierPolice) then
		TriggerNotification("Данная команда доступна с 5 ранга.")

		return
	end

	slot1, slot2 = slot0.match(slot0, "^(%d+)%s(.*)")

	if not slot1 or not slot2 then
		TriggerNotification("Используйте: /takelic (id) (Причина).")

		return
	end

	if not sampIsPlayerConnected(slot1) then
		TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")
	slot4 = sampGetPlayerNickname(slot1)
	slot4 = slot4:gsub("_", " ")

	lua_thread.create(function ()
		if takelicValue then
			sampSendChat(rptakelicValue == "" and string.format("/me связавшись с диспетчером, %s номер водительской лицензии.", ladyValue and "сообщила" or "сообщил") or u8:decode(rptakelicValue))
			wait(555)

			if rptakelic2Value ~= "-" then
				sampSendChat(rptakelic2Value == "" and string.format("/me продиктовав причину, %s её аннулирование.", ladyValue and "запросила" or "запросил") or u8:decode(rptakelic2Value))
			end
		end

		wait(250)
		sampSendChat(string.format("/takelic %d %s", uv0, uv1))
	end)
end

cmd_skip = function(slot0)
	if not slot0.match(slot0, "^(%d+)") then
		TriggerNotification("Используйте: /skip (id).")

		return
	end

	uv0, uv1 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	lua_thread.create(function ()
		slot0 = newrpskipValue == "" and string.format("/me вписав имя человека в бланк для гостей, %s пропуск.", ladyValue and "выдала" or "выдал") or u8:decode(newrpskipValue)

		if skipValue then
			sampSendChat(slot0)
			wait(222)
		end

		sampSendChat(string.format("/skip %d", uv0))
	end)
end

cmd_setmark = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	if not slot0.match(slot0, "^(%d+)") then
		TriggerNotification("Используйте: /setmark (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	lua_thread.create(function ()
		slot0 = newrpsetmarkValue == "" and string.format("/me найдя подозреваемого по базе данных, %s GPS-отслеживание по его SIM-карте.", ladyValue and "включила" or "включил") or u8:decode(newrpsetmarkValue)

		if setmarkValue then
			sampSendChat(slot0)
			wait(222)
		end

		sampSendChat(string.format("/setmark %d", uv0))
	end)
end

cmd_putpl = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	if not slot0.match(slot0, "^(%d+)") then
		TriggerNotification("Используйте: /putpl (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	lua_thread.create(function ()
		slot0 = newrpputplValue == "" and string.format("/me открыв заднюю дверь машины, %s подозреваемого в машину.", ladyValue and "затащила" or "затащил") or u8:decode(newrpputplValue)

		if putplValue then
			sampSendChat(slot0)
			wait(222)
		end

		sampSendChat(string.format("/putpl %d", uv0))
	end)
end

cmd_hold = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice and not isPlayerSoldierMafia and not isPlayerGoverment then
		TriggerNotification("Вам не доступна эта команда.")

		return
	end

	if not slot0.match(slot0, "^(%d+)") then
		TriggerNotification("Используйте: /hold (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	lua_thread.create(function ()
		slot0 = newrpholdValue == "" and string.format("/me крепко %s подозреваемого за руку и %s вперёд, контролируя его действия.", ladyValue and "схватила" or "схватил", ladyValue and "повела" or "повёл") or u8:decode(newrpholdValue)

		if holdValue then
			sampSendChat(slot0)
			wait(222)
		end

		sampSendChat(string.format("/hold %d", uv0))
	end)
end

cmd_pull = function(slot0)
	if uv0 ~= "Yes" and (nasosal_rang <= 2 and isPlayerSoldierPolice or not isPlayerSoldierPolice) then
		TriggerNotification("Данная команда доступна с 3 ранга.")

		return
	end

	if not slot0.match(slot0, "^(%d+)") then
		TriggerNotification("Используйте: /pull (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	lua_thread.create(function ()
		if pullValue then
			sampSendChat(string.format("/pull %d", uv0))
			wait(222)
			sampSendChat(newrppullValue == "" and string.format("/me взмахом дубинки %s окно водителя, после чего %s двери.", ladyValue and "разбила" or "разбил", ladyValue and "открыла" or "открыл") or u8:decode(newrppullValue))
			wait(555)
			sampSendChat(newrppull2Value == "" and string.format("/me схватив подозреваемого за одежду, %s из машины.", ladyValue and "вытащила" or "вытащил") or u8:decode(newrppull2Value))
		else
			sampSendChat(string.format("/pull %d", uv0))
		end
	end)
end

cmd_search = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	slot1, slot2 = slot0.match(slot0, "^(%d+)%s*(.*)")

	if not slot1 then
		TriggerNotification("Используйте: /search (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	lua_thread.create(function ()
		slot0 = 555
		slot1, slot2 = nil

		if searchValue then
			sampSendChat(newrpsearchValue == "" and string.format("/me надев резиновые перчатки, %s проверять карманы подозреваемого.", ladyValue and "начала" or "начал") or u8:decode(newrpsearchValue))
			wait(slot0)
			sampSendChat(newrpsearch2Value == "" and string.format("/me достав всё найденное из карманов, %s по zip-пакетам.", ladyValue and "распределила" or "распределил") or u8:decode(newrpsearch2Value))
			wait(222)
			sampSendChat(string.format("/search %d %s", uv0, uv1))
		else
			sampSendChat(string.format("/search %d %s", uv0, uv1))
		end
	end)
end

cmd_arrest = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice then
		TriggerNotification("Данная команда доступна только полиции.")

		return
	end

	slot1, slot2 = slot0.match(slot0, "^(%d+)%s(.*)")

	if not slot1 then
		TriggerNotification("Используйте: /arrest (id) (Причина).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(slot1), "(%S+)_(%S+)")

	lua_thread.create(function ()
		slot0 = 555

		if arrestValue and (newrparrestValue == "" and string.format("/me %s диспетчеру о привезённом преступнике.", ladyValue and "сообщила" or "сообщил") or string.format("%s", u8:decode(newrparrestValue))) or nil then
			sampSendChat(slot1)
			wait(slot0)
		end

		sampSendChat(newrparrest2Value == "" and "/do Из департамента выходят офицеры и забирают преступника." or string.format("%s", u8:decode(newrparrest2Value)))
		wait(slot0)
		sampSendChat(newrparrest3Value == "" and string.format("/me %s протокол офицерам и %s преступника взглядом.", ladyValue and "отдала" or "отдал", ladyValue and "проводила" or "проводил") or string.format("%s", u8:decode(newrparrest3Value)))
		wait(222)
		sampSendChat(string.format("/arrest %d %s", uv0, uv1))
	end)
end

cmd_cuff = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice and not isPlayerGoverment then
		TriggerNotification("Вам не доступна эта команда.")

		return
	end

	if not slot0.match(slot0, "^%d+") then
		TriggerNotification("Используйте: /cuff (id)")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(tonumber(slot1)), "(%S+)_(%S+)")

	lua_thread.create(function ()
		sampSendChat(newrpcuffValue == "" and string.format("/me %s наручники с поясного держателя на тактическом поясе.", ladyValue and "сняла" or "снял") or string.format("%s", u8:decode(newrpcuffValue)))
		wait(222)
		sampSendChat(string.format("/cuff %d", uv0))
	end)
end

cmd_ud = function(slot0)
	if isPlayerSoldierGhetto or isPlayerSoldierMafia then
		TriggerNotification("Вам не доступна эта команда.")

		return
	end

	lua_thread.create(function ()
		if not uv0:match("^%d+") then
			TriggerNotification("Используйте: /ud (id).")

			return
		end

		slot0 = tonumber(slot0)
		uv1, uv2 = string.match(sampGetPlayerNickname(slot0), "(%S+)_(%S+)")

		if myID == slot0 or sampIsPlayerConnected(slot0) then
			sampSendChat(rpudValue == "" and string.format("/me достав удостоверение, %s его %s", ladyValue and "предъявила" or "предъявил", sampGetPlayerNickname(slot0):gsub("_", " ")) or string.format("%s", u8:decode(rpudValue)))
			wait(444)

			slot5 = playerAccoutNumber:gsub("^%s+", "")

			sampSendChat(uddoljValue == "" and string.format("/do №%s | %s | %s.", slot5, nickName, uv3) or string.format("/do №%s | %s | %s | %s.", slot5, nickName, u8:decode(uddoljValue), uv3))
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу.")
		end
	end)
end

cmd_uncuff = function(slot0)
	if uv0 ~= "Yes" and not isPlayerSoldierPolice and not isPlayerGoverment then
		TriggerNotification("Вам не доступна эта команда.")

		return
	end

	if not slot0.match(slot0, "^%d+") then
		TriggerNotification("Используйте: /uncuff (id).")

		return
	end

	uv1, uv2 = string.match(sampGetPlayerNickname(tonumber(slot1)), "(%S+)_(%S+)")

	lua_thread.create(function ()
		if uncuffValue then
			sampSendChat(newrpuncuffValue == "" and string.format("/me придерживая подозреваемого, %s руки от наручников.", ladyValue and "освободила" or "освободил") or string.format("%s", u8:decode(newrpuncuffValue)))
			wait(222)
		end

		sampSendChat(string.format("/uncuff %d", uv0))
	end)
end

cmd_mask = function()
	sampSendChat("/mask")

	if maskValue then
		if newrpmaskValue ~= "" then
			sampSendChat(u8:decode(newrpmaskValue))
		else
			slot0 = ladyValue and {
				"достала",
				"натянула"
			} or {
				"достал",
				"натянул"
			}

			sampSendChat(string.format("/me %s балаклаву с прорезями в области глаз, %s её на голову.", slot0[1], slot0[2]))
		end
	end

	if autoresetValue then
		sampSendChat("/reset")
	end
end

cmd_healme = function()
	sampSendChat("/healme")

	if healmeValue then
		if newrphealmeValue ~= "" then
			sampSendChat(u8:decode(newrphealmeValue))
		else
			slot0 = ladyValue and {
				"достала",
				"сняла",
				"вколола"
			} or {
				"достал",
				"снял",
				"вколол"
			}

			sampSendChat(string.format("/me %s шприц с адреналином, %s колпачок, %s себе в ногу.", slot0[1], slot0[2], slot0[3]))
		end
	end
end

ex_find = function()
	sampSendChat("/find")
	lua_thread.create(function ()
		if rpFindValue then
			if newrpfindValue ~= "" then
				sampSendChat(u8:decode(newrpfindValue))
			else
				slot1 = ladyValue and {
					"достала",
					"открыла"
				} or {
					"достал",
					"открыл"
				}

				sampSendChat(string.format("/me %s КПК из кармана и %s список %s.", slot1[1], slot1[2], isPlayerSoldier and "бойцов" or "сотрудников"))
			end
		end
	end)
end

cmd_ok = function(slot0)
	if tonumber(slot0.match(slot0, "^%d+")) then
		if sampIsPlayerConnected(slot1) then
			slot2 = string.gsub(sampGetPlayerNickname(slot1), "_", " ")
			uv0, uv1 = string.match(sampGetPlayerNickname(slot0), "(%S+)_(%S+)")
			slot4 = ""

			if isPlayerSoldierMafia or isPlayerSoldierGhetto then
				if offtagValue and active_fValue then
					slot4 = string.format("[%s]: ", u8:decode(ftextValue))
				end
			elseif offtagValue and active_rValue then
				slot4 = string.format("[%s]: ", u8:decode(rtextValue))
			end

			slot5 = newokValue ~= "" and u8:decode(newokValue) or string.format("%s, ваш доклад принят, продолжайте в том же духе!", slot2)

			if isPlayerSoldierMafia or isPlayerSoldierGhetto then
				sampSendChat("/f " .. slot4 .. slot5)
			else
				sampSendChat("/r " .. slot4 .. slot5)
			end
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу или указан ваш ID.")
		end
	else
		TriggerNotification("Используйте: /ok (id).")
	end
end

reconnect = function()
	lua_thread.create(function ()
		sampSetGamestate(5)
		sampDisconnectWithReason()
		wait(2500)
		sampSetGamestate(1)

		dobropojrec = true
	end)
end

cmd_histid = function(slot0)
	if slot0.match(slot0, "^%d+") then
		if sampIsPlayerConnected(tonumber(slot0.match(slot0, "^(%d+)"))) or myID == tonumber(slot0) then
			sampSendChat("/history " .. sampGetPlayerNickname(slot0))
		else
			TriggerNotification("Игрок с данным ID не подключен к серверу.")
		end
	else
		TriggerNotification("Используйте: /hist (id).")
	end
end

cmd_drive = function(slot0)
	if slot0.match(slot0, "^%d+") then
		if slot0.match(slot0, "^(%d+)") == "1" then
			if nasosal_rang <= 8 then
				TriggerNotification("Данная команда доступна с 9 ранга.")

				return
			end

			TriggerNotification("Чтобы отменить драйв нажмите F2. ")

			drivetime = true

			slot2 = function(slot0, slot1)
				for slot5 = 1, 4 do
					if not drivetime then
						break
					end

					sampSendChat(slot0 .. (_G["newdrive" .. (slot5 > 1 and slot5 or "") .. "Value"] ~= "" and slot6 or slot1[slot5]))

					if slot5 < 4 then
						wait(5000)
					elseif slot5 == 4 and drivetime then
						sampSendChat("/drive")

						drivetime = false
					end
				end
			end

			lua_thread.create(function ()
				if drivetime then
					if isPlayerSoldier then
						uv0("/r ", {
							"Внимание! Происходит эвакуация техники на базу! 15 секунд",
							"Внимание! Происходит эвакуация техники на базу! 10 секунд",
							"Внимание! Происходит эвакуация техники на базу! 5 секунд",
							"Внимание! Происходит эвакуация техники на базу!"
						})
					elseif isPlayerSoldierMafia or isPlayerSoldierGhetto then
						uv0("/f ", {
							"Внимание! Происходит эвакуация техники на базу! 15 секунд",
							"Внимание! Происходит эвакуация техники на базу! 10 секунд",
							"Внимание! Происходит эвакуация техники на базу! 5 секунд",
							"Внимание! Происходит эвакуация техники на базу!"
						})
					else
						uv0("/r ", {
							"Внимание! Происходит эвакуация техники на парковку! 15 секунд",
							"Внимание! Происходит эвакуация техники на парковку! 10 секунд",
							"Внимание! Происходит эвакуация техники на парковку! 5 секунд",
							"Внимание! Происходит эвакуация техники на парковку!"
						})
					end
				end
			end)

			return
		end

		if slot1 == "0" then
			if nasosal_rang <= 8 then
				TriggerNotification("Данная команда доступна с 9 ранга.")

				return
			end

			lua_thread.create(function ()
				sampSendChat("/drive")
			end)
		end
	else
		TriggerNotification("Режим 0 - быстрый драйв | 1 - с уведомлением в рацию.")
		TriggerNotification("Используйте /drive (0/1).")
	end
end

rpgun = function()
	if active_rpgunValue and lastgun ~= getCurrentCharWeapon(PLAYER_PED) then
		slot1 = {
			[0] = {
				default = "/me " .. (ladyValue and "спрятала" or "спрятал") .. " оружие.",
				custom = newUnarmedValue
			},
			[23] = {
				default = "/me " .. (ladyValue and "достала" or "достал") .. " пистолет с глушителем и " .. (ladyValue and "перезарядила" or "перезарядил") .. " его.",
				custom = newSilencedValue
			},
			[24] = {
				default = "/me " .. (ladyValue and "достала" or "достал") .. " с кобуры пистолет марки ''Desert Eagle'' и " .. (ladyValue and "перезарядила" or "перезарядил") .. " его.",
				custom = newDesertValue
			},
			[25] = {
				default = "/me " .. (ladyValue and "достала" or "достал") .. " с чехла на спине помповый дробовик и " .. (ladyValue and "зарядила" or "зарядил") .. " его.",
				custom = newShotValue
			},
			[26] = {
				default = "/me " .. (ladyValue and "достала" or "достал") .. " с чехла обрез и " .. (ladyValue and "зарядила" or "зарядил") .. " его.",
				custom = newSawnoffValue
			},
			[27] = {
				default = "/me " .. (ladyValue and "достала" or "достал") .. " с чехла скорострельный дробовик и " .. (ladyValue and "вставила" or "вставил") .. " в него патроны.",
				custom = newCombatValue
			},
			[28] = {
				default = "/me " .. (ladyValue and "сняла" or "снял") .. " с крепления ''Micro Uzi'' и " .. (ladyValue and "перезарядила" or "перезарядил") .. " его.",
				custom = newMicroValue
			},
			[29] = {
				default = "/me " .. (ladyValue and "сняла" or "снял") .. " с плеча пистолет-пулемет ''MP-5'' и " .. (ladyValue and "перезарядила" or "перезарядил") .. " его.",
				custom = newpMp5Value
			},
			[30] = {
				default = "/me " .. (ladyValue and "сняла" or "снял") .. " с плеча автомат ''Калашникова'' и " .. (ladyValue and "передернула" or "передернул") .. " затвор.",
				custom = newpAk47Value
			},
			[31] = {
				default = "/me " .. (ladyValue and "сняла" or "снял") .. " с плеча карабин ''M4A1'' и " .. (ladyValue and "передернула" or "передернул") .. " затвор.",
				custom = newM4Value
			},
			[33] = {
				default = "/me " .. (ladyValue and "сняла" or "снял") .. " с плеча полу-автоматическую винтовку и " .. (ladyValue and "перезарядила" or "перезарядил") .. " её.",
				custom = newCrifleValue
			},
			[34] = {
				default = "/me " .. (ladyValue and "достала" or "достал") .. " с кейса снайперскую винтовку затем " .. (ladyValue and "вставила" or "вставил") .. " магазин и " .. (ladyValue and "перезарядила" or "перезарядил") .. " её.",
				custom = newSrifleValue
			}
		}

		(function (slot0)
			if uv0[slot0] then
				if slot1.custom == "" then
					sampSendChat(slot1.default)
				else
					sampSendChat(string.format("%s", u8:decode(slot1.custom)))
				end

				wait(1444)
			end
		end)(slot0)

		lastgun = slot0
	end
end

drone = function()
	lua_thread.create(function ()
		if droneActive then
			TriggerNotification("На данный момент вы уже управляете дроном.")

			return
		end

		if rpdroneValue then
			if newrpdrone1Value == "" then
				sampSendChat("/do На спине у " .. nickName .. " сумка с дроном.")
			else
				sampSendChat(string.format("%s", u8:decode(newrpdrone1Value)))
			end

			wait(444)

			if newrpdrone2Value == "-" then
				-- Nothing
			elseif newrpdrone2Value == "" then
				sampSendChat(string.format("/me достав из сумки дрон, " .. (ladyValue and "запустила" or "запустил") .. " его."))
			else
				sampSendChat(string.format("%s", u8:decode(newrpdrone2Value)))
			end
		end

		TriggerNotification("Завершить пилотирование дроном можно клавишей Enter.")
		TriggerNotification("Скорость полета дрона: '' + '' (быстрей), '' - '' (медленней).")
		TriggerNotification("Управление дроном клавишами: W, A, S, D, Space, Shift.")

		while true do
			wait(0)

			if flymode == 0 then
				droneActive = true
				posX, posY, posZ = getCharCoordinates(playerPed)
				angZ = getCharHeading(playerPed)
				angZ = angZ * -1

				setFixedCameraPosition(posX, posY, posZ, 0, 0, 0)

				angY = 0
				flymode = 1
			end

			if flymode == 1 and not sampIsChatInputActive() and not isSampfuncsConsoleActive() then
				offMouX, offMouY = getPcMouseMovement()
				offMouX = offMouX / 4
				offMouY = offMouY / 4
				angZ = angZ + offMouX
				angY = angY + offMouY

				if angZ > 360 then
					angZ = angZ - 360
				end

				if angZ < 0 then
					angZ = angZ + 360
				end

				if angY > 89 then
					angY = 89
				end

				if angY < -89 then
					angY = -89
				end

				radZ = math.rad(angZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinY = math.sin(radY)
				cosY = math.cos(radY)
				sinZ = sinZ * cosY
				cosZ = cosZ * cosY
				sinZ = sinZ * 1
				cosZ = cosZ * 1
				sinY = sinY * 1
				poiX = posX
				poiY = posY
				poiZ = posZ
				poiX = poiX + sinZ
				poiY = poiY + cosZ
				poiZ = poiZ + sinY

				pointCameraAtPoint(poiX, poiY, poiZ, 2)

				curZ = angZ + 180
				curY = angY * -1
				radZ = math.rad(curZ)
				radY = math.rad(curY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinY = math.sin(radY)
				cosY = math.cos(radY)
				sinZ = sinZ * cosY
				cosZ = cosZ * cosY
				sinZ = sinZ * 10
				cosZ = cosZ * 10
				sinY = sinY * 10
				posPlX = posX + sinZ
				posPlY = posY + cosZ
				posPlZ = posZ + sinY
				angPlZ = angZ * -1
				radZ = math.rad(angZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinY = math.sin(radY)
				cosY = math.cos(radY)
				sinZ = sinZ * cosY
				cosZ = cosZ * cosY
				sinZ = sinZ * 1
				cosZ = cosZ * 1
				sinY = sinY * 1
				poiX = posX
				poiY = posY
				poiZ = posZ
				poiX = poiX + sinZ
				poiY = poiY + cosZ
				poiZ = poiZ + sinY

				pointCameraAtPoint(poiX, poiY, poiZ, 2)

				if isKeyDown(VK_W) then
					radZ = math.rad(angZ)
					radY = math.rad(angY)
					sinZ = math.sin(radZ)
					cosZ = math.cos(radZ)
					sinY = math.sin(radY)
					cosY = math.cos(radY)
					sinZ = sinZ * cosY
					cosZ = cosZ * cosY
					sinZ = sinZ * speed
					cosZ = cosZ * speed
					sinY = sinY * speed
					posX = posX + sinZ
					posY = posY + cosZ
					posZ = posZ + sinY

					setFixedCameraPosition(posX, posY, posZ, 0, 0, 0)
				end

				radZ = math.rad(angZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinY = math.sin(radY)
				cosY = math.cos(radY)
				sinZ = sinZ * cosY
				cosZ = cosZ * cosY
				sinZ = sinZ * 1
				cosZ = cosZ * 1
				sinY = sinY * 1
				poiX = posX
				poiY = posY
				poiZ = posZ
				poiX = poiX + sinZ
				poiY = poiY + cosZ
				poiZ = poiZ + sinY

				pointCameraAtPoint(poiX, poiY, poiZ, 2)

				if isKeyDown(VK_S) then
					curZ = angZ + 180
					curY = angY * -1
					radZ = math.rad(curZ)
					radY = math.rad(curY)
					sinZ = math.sin(radZ)
					cosZ = math.cos(radZ)
					sinY = math.sin(radY)
					cosY = math.cos(radY)
					sinZ = sinZ * cosY
					cosZ = cosZ * cosY
					sinZ = sinZ * speed
					cosZ = cosZ * speed
					sinY = sinY * speed
					posX = posX + sinZ
					posY = posY + cosZ
					posZ = posZ + sinY

					setFixedCameraPosition(posX, posY, posZ, 0, 0, 0)
				end

				radZ = math.rad(angZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinY = math.sin(radY)
				cosY = math.cos(radY)
				sinZ = sinZ * cosY
				cosZ = cosZ * cosY
				sinZ = sinZ * 1
				cosZ = cosZ * 1
				sinY = sinY * 1
				poiX = posX
				poiY = posY
				poiZ = posZ
				poiX = poiX + sinZ
				poiY = poiY + cosZ
				poiZ = poiZ + sinY

				pointCameraAtPoint(poiX, poiY, poiZ, 2)

				if isKeyDown(VK_A) then
					curZ = angZ - 90
					radZ = math.rad(curZ)
					radY = math.rad(angY)
					sinZ = math.sin(radZ)
					cosZ = math.cos(radZ)
					sinZ = sinZ * speed
					cosZ = cosZ * speed
					posX = posX + sinZ
					posY = posY + cosZ

					setFixedCameraPosition(posX, posY, posZ, 0, 0, 0)
				end

				radZ = math.rad(angZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinY = math.sin(radY)
				cosY = math.cos(radY)
				sinZ = sinZ * cosY
				cosZ = cosZ * cosY
				sinZ = sinZ * 1
				cosZ = cosZ * 1
				sinY = sinY * 1
				poiX = posX
				poiY = posY
				poiZ = posZ
				poiX = poiX + sinZ
				poiY = poiY + cosZ
				poiZ = poiZ + sinY

				pointCameraAtPoint(poiX, poiY, poiZ, 2)

				if isKeyDown(VK_D) then
					curZ = angZ + 90
					radZ = math.rad(curZ)
					radY = math.rad(angY)
					sinZ = math.sin(radZ)
					cosZ = math.cos(radZ)
					sinZ = sinZ * speed
					cosZ = cosZ * speed
					posX = posX + sinZ
					posY = posY + cosZ

					setFixedCameraPosition(posX, posY, posZ, 0, 0, 0)
				end

				radZ = math.rad(angZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinY = math.sin(radY)
				cosY = math.cos(radY)
				sinZ = sinZ * cosY
				cosZ = cosZ * cosY
				sinZ = sinZ * 1
				cosZ = cosZ * 1
				sinY = sinY * 1
				poiX = posX
				poiY = posY
				poiZ = posZ
				poiX = poiX + sinZ
				poiY = poiY + cosZ
				poiZ = poiZ + sinY

				pointCameraAtPoint(poiX, poiY, poiZ, 2)

				if isKeyDown(VK_SPACE) then
					posZ = posZ + speed

					setFixedCameraPosition(posX, posY, posZ, 0, 0, 0)
				end

				radZ = math.rad(angZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinY = math.sin(radY)
				cosY = math.cos(radY)
				sinZ = sinZ * cosY
				cosZ = cosZ * cosY
				sinZ = sinZ * 1
				cosZ = cosZ * 1
				sinY = sinY * 1
				poiX = posX
				poiY = posY
				poiZ = posZ
				poiX = poiX + sinZ
				poiY = poiY + cosZ
				poiZ = poiZ + sinY

				pointCameraAtPoint(poiX, poiY, poiZ, 2)

				if isKeyDown(VK_SHIFT) then
					posZ = posZ - speed

					setFixedCameraPosition(posX, posY, posZ, 0, 0, 0)
				end

				radZ = math.rad(angZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinY = math.sin(radY)
				cosY = math.cos(radY)
				sinZ = sinZ * cosY
				cosZ = cosZ * cosY
				sinZ = sinZ * 1
				cosZ = cosZ * 1
				sinY = sinY * 1
				poiX = posX
				poiY = posY
				poiZ = posZ
				poiX = poiX + sinZ
				poiY = poiY + cosZ
				poiZ = poiZ + sinY

				pointCameraAtPoint(poiX, poiY, poiZ, 2)

				if isKeyDown(187) then
					speed = speed + 0.01
				end

				if isKeyDown(189) then
					speed = speed - 0.01

					if speed < 0.01 then
						speed = 0.01
					end
				end

				if isKeyDown(VK_RETURN) then
					restoreCameraJumpcut()
					setCameraBehindPlayer()

					flymode = 0
					droneActive = false

					break
				end
			end
		end
	end)
end

slot5.onSendAimSync = function()
	if flymode == 1 then
		return false
	end
end

cmdSetTime = function(slot0)
	if tonumber(slot0) ~= nil and slot1 >= 0 and slot1 <= 23 then
		time = slot1

		patch_samp_time_set(true)
		TriggerNotification("Серверное время изменено на: " .. slot0)
	else
		patch_samp_time_set(false)

		time = nil
	end
end

cmdSetWeather = function(slot0)
	if tonumber(slot0) ~= nil and slot1 >= 0 and slot1 <= 45 then
		TriggerNotification("Серверная погода изменена на: " .. slot0)
		forceWeatherNow(slot1)
	end
end

patch_samp_time_set = function(slot0)
	if slot0 and default == nil then
		default = readMemory(sampGetBase() + 639136, 4, true)

		writeMemory(sampGetBase() + 639136, 4, 2242, true)
	elseif slot0 == false and default ~= nil then
		writeMemory(sampGetBase() + 639136, 4, default, true)

		default = nil
	end
end

set_dist = function(slot0, slot1)
	slot1 = tonumber(slot1)

	if slot0 == 21 then
		if blockf4Value then
			require("memory").setuint8(getModuleHandle("samp.dll") + 31102, 195, true)
		end

		uv0.cfgButton.blockf4 = blockf4Value

		uv1.save(uv0, uv2)
	end

	if slot0 == 22 then
		uv0.cfgButton.opentchat = opentchatValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 3 then
		if waterfixValue then
			uv3.setfloat(13101856, 0, true)
			uv3.write(7249056, 13101856, 4, true)
			uv3.write(7249115, 13101856, 4, true)
			uv3.write(7249175, 13101856, 4, true)
			uv3.write(7249235, 13101856, 4, true)
		else
			uv3.write(7249056, 8752012, 4, true)
			uv3.write(7249115, 8752012, 4, true)
			uv3.write(7249175, 8752012, 4, true)
			uv3.write(7249235, 8752012, 4, true)
		end

		uv0.cfgButton.waterfix = waterfixValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 4 then
		if blackroadsValue then
			uv3.write(8931716, 0, 4, true)
		else
			uv3.write(8931716, 2, 4, true)
		end

		uv0.cfgButton.blackroads = blackroadsValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 5 then
		if forceanisoValue then
			if readMemory(7540636, 1, true) ~= 0 then
				uv3.write(7540636, 0, 1, true)
				lua_thread.create(function ()
					uv0.fill(5499583, 144, 5, true)
					wait(100)
					loadScene(20000000, 20000000, 20000000)
					callFunction(4249536, 1, 1, -1)
					uv0.hex2bin("E87CF4FFFF", 5499583, 5)
				end)
			end
		elseif readMemory(7540636, 1, true) ~= 1 then
			uv3.write(7540636, 1, 1, true)
			lua_thread.create(function ()
				uv0.fill(5499583, 144, 5, true)
				wait(100)
				loadScene(20000000, 20000000, 20000000)
				callFunction(4249536, 1, 1, -1)
				uv0.hex2bin("E87CF4FFFF", 5499583, 5)
			end)
		end

		uv0.cfgButton.forceaniso = forceanisoValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 6 then
		if sunfixValue then
			uv3.hex2bin("E865041C00", 5488950, 5)
		else
			uv3.fill(5488950, 144, 5, true)
		end

		uv0.cfgButton.sunfix = sunfixValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 9 then
		if tiretracksValue then
			uv3.fill(5497205, 144, 5, true)
		else
			uv3.hex2bin("E8C6241E00", 5497205, 5)
		end

		uv0.cfgButton.tiretracks = tiretracksValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 10 then
		if nobirdsValue then
			uv3.fill(7415859, 144, 2, true)
		else
			uv3.hex2bin("3BC5", 7415859, 2)
		end

		uv0.cfgButton.nobirds = nobirdsValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 11 then
		if nocloudValue then
			uv3.write(5497268, -1869574000, 4, true)
			uv3.write(5497272, 144, 1, true)
			uv3.fill(5497121, 144, 5, true)
		else
			uv3.write(5497268, 495044584, 4, true)
			uv3.write(5497272, 0, 1, true)
			uv3.write(5497121, 494111464, 4, true)
			uv3.write(5497125, 0, 1, true)
		end

		uv0.cfgButton.nocloud = nocloudValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 12 then
		uv0.cfgButton.nocloud = nocloudValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 13 then
		if nodustValue then
			writeMemory(7014072, 4, 144, true)
		end

		uv0.cfgButton.nodust = nodustValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 14 then
		if noexplosionValue then
			uv3.write(7565192, 0, 4, true)
		end

		uv0.cfgButton.noexplosion = noexplosionValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 16 then
		uv0.cfgButton.TunFix = TunFixValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 18 then
		if moneyborderValue == true then
			uv3.setint8(5830029, 1, true)
		else
			uv3.setint8(5830029, 2, true)
		end

		uv0.cfgButton.moneyborder = moneyborderValue

		uv1.save(uv0, uv2)
	end

	if slot0 == 20 then
		if fixspeedValue then
			fixspeedon = true
		else
			fixspeedon = false
		end

		uv0.cfgButton.fixspeed = fixspeedValue

		uv1.save(uv0, uv2)
	end
end

async_http_request = function(slot0, slot1, slot2, slot3, slot4)
	slot5 = uv0.gen("*", {
		package = {
			path = package.path,
			cpath = package.cpath
		}
	}, function ()
		slot1, slot2 = pcall(require("requests").request, uv0, uv1, uv2)

		if slot1 then
			slot2.xml = nil
			slot2.json = nil

			return true, slot2
		else
			return false, slot2
		end
	end)
	slot4 = slot4 or function ()
	end

	lua_thread.create(function ()
		slot0 = uv0()

		while true do
			if slot0.status == "done" then
				slot3 = slot0[2]

				if slot0[1] then
					uv1(slot3)
				else
					uv2(slot3)
				end

				return
			elseif slot1 == "error" then
				return uv2(slot0[1])
			elseif slot1 == "killed" or slot1 == "cancelled" then
				return uv2(slot1)
			end

			wait(0)
		end
	end)
end

addTextToCheck = function(slot0, slot1, slot2, slot3)
	uv0[#uv0 + 1] = {
		id = slot0,
		x = slot1,
		y = slot2,
		z = slot3
	}
end

checkGateControlText = function()
	slot0, slot1, slot2 = getCharCoordinates(PLAYER_PED)

	for slot6 = #uv0, 1, -1 do
		slot7 = uv0[slot6]

		if getDistanceBetweenCoords3d(slot7.x, slot7.y, slot7.z, slot0, slot1, slot2) <= 10 then
			autorpgateon = true

			table.remove(uv0, slot6)
		end
	end
end

slot5.onSendGiveDamage = function(slot0, slot1)
	lua_thread.create(function ()
		uv0 = uv1
		uv2 = sampGetPlayerColor(uv3)

		if uv2 == 2236962 then
			uv2 = 4285558896.0
		end

		uv4 = uv3

		if uv5[uv4] == nil then
			uv5[uv4] = {
				0,
				0
			}
		end

		uv5[uv4][1] = uv5[uv4][1] + 1
		uv5[uv4][2] = os.time()

		wait(2222)

		uv6 = nil
		uv4 = nil
	end)
end

slot5.onSendTakeDamage = function(slot0, slot1)
	lua_thread.create(function ()
		uv0 = uv1
		uv2 = uv3
		colortake = sampGetPlayerColor(uv3)

		if colortake == 2236962 then
			colortake = 4285558896.0
		end

		wait(2222)

		uv4 = nil
		uv2 = nil
	end)
end

slot5.onPlayerDeath = function(slot0)
	if slot0 == uv0 then
		lua_thread.create(function ()
			uv0 = uv1[math.random(1, #uv1)]
			uv2 = true

			wait(1000)

			uv0 = nil
			uv2 = false
		end)
	end
end

autosms = function(slot0)
	slot1 = slot0.match(slot0, "^(.*)")

	if lastnumberon ~= nil then
		sampSetChatInputEnabled(true)
		sampSendChat("/sms " .. lastnumberon .. " " .. slot1)
	else
		TriggerNotification("Вы ранее не получали входящих сообщений.")
	end
end

slot5.onCreate3DText = function(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	lua_thread.create(function ()
		if uv0:find("Введите /buy") then
			if autobuyValue then
				wait(1555)

				uv1 = true
				uv2 = true
				uv3 = true
			end
		else
			uv1 = false
			uv2 = false
			uv4 = false
			uv3 = false
		end
	end)

	if slot7.match(slot7, "Управление\nворотами:") or slot7.match(slot7, "Управление\nшлагбаумом:") then
		addTextToCheck(slot0, slot2.x, slot2.y, slot2.z)
	end
end

makeScreenshot = function(slot0)
	if slot0 then
		displayHud(false)
		sampSetChatDisplayMode(0)
	end

	require("memory").setuint8(sampGetBase() + 1154236, 1)

	if slot0 then
		displayHud(true)
		sampSetChatDisplayMode(2)
	end
end

slot190 = false

slot5.onServerMessage = function(slot0, slot1)
	if scriptonl then
		if idnaid and slot1.find(slot1, "id") then
			AddChatMessage(slot1 .. "{FFFFFF} | LVL: " .. idlvl)

			idnaid = false

			return false
		end

		if slot1.find(slot1, "Доступны ежедневные, еженедельные и сезонные задания") then
			uv0 = true
		end

		if slot1.find(slot1, "Вы вошли как") and slot1.find(slot1, "администратор") and slot0 == -65281 then
			uv1 = "Yes"
		end

		if slot1 == "Вы сняли маску" or slot1 == "Вы надели новую маску и выбросили старую" then
			offMask = true
		elseif slot0 == 865730559 and slot1.find(slot1, "Ваше месторасположение на GPS скрыто") then
			offMaskTime = os.clock() * 1000 + 600000
			offMask = false
		end

		if slot0 == 13369599 and string.find(slot1, "Отправил") then
			adtext = string.sub(slot1, 6, string.find(slot1, " | Отправил ", 1, true) - 1)
			adnick = string.sub(slot1, string.find(slot1, "| Отправил ", 1, true) + 11, string.find(slot1, "тел.", 1, true) - 3)
			adnick = string.sub(adnick, 1, string.find(adnick, "[", 1, true) - 1)
			adtel = string.sub(slot1, string.find(slot1, "(тел. ", 1, true) + 6, string.len(slot1) - 1)
			uv2 = adnick
			uv3 = adtel

			booksend()
		end

		if slot1.match(slot1, "SMS: .* | Отправитель: .* %[т%.%d+%]") then
			slot2, uv2, uv3 = slot1.match(slot1, "SMS: (.*) | Отправитель: (.*) %[т%.(%d+)%]")

			booksend()
		end

		if slot1.match(slot1, "SMS: .* | Получатель: .* %[т%.%d+%]") then
			slot2, uv2, uv3 = slot1.match(slot1, "SMS: (.*) | Получатель: (.*) %[т%.(%d+)%]")

			booksend()
		end

		if slot1.match(slot1, "SMS: .* | Отправитель: .* %[т%.%d+%]") then
			slot2, slot3, lastnumberon = slot1.match(slot1, "SMS: (.*) | Отправитель: (.*) %[т%.(%d+)%]")
		end

		if slot1.find(slot1, "Вы получаете премию") and debtorsellon and debtorsellValue then
			lua_thread.create(function ()
				if debtorsellrpValue == "" then
					sampSendChat("/me " .. (ladyValue and "достала" or "достал") .. " планшет из сумки и " .. (ladyValue and "начала" or "начал") .. " искать данные о собственнике имущества.")
				else
					sampSendChat(string.format("%s", u8:decode(debtorsellrpValue)))
				end

				wait(555)

				if debtorsellrp2Value == "-" then
					-- Nothing
				elseif debtorsellrp2Value == "" then
					sampSendChat("/me " .. (ladyValue and "заполнила" or "заполнил") .. " акт изъятия, " .. (ladyValue and "внесла" or "внёс") .. " изменения в базу данных и " .. (ladyValue and "подписала" or "подписал") .. " документ.")
				else
					sampSendChat(string.format("%s", u8:decode(debtorsellrp2Value)))
				end

				wait(555)
			end)

			debtorsellon = false
		end

		if slot1.find(slot1, "Вы не можете унести") then
			uv4 = true
		end

		if autobuyValue and uv5 then
			lua_thread.create(function ()
				if uv0:find("Вы должны быть в продуктовом магазине") then
					print("other: " .. uv0)

					return false
				end

				slot0 = {
					["0"] = 4,
					["10"] = "close",
					["2"] = 2,
					["7"] = 2,
					["3"] = 1,
					["6"] = 3,
					["9"] = 0,
					["5"] = 4,
					["1"] = 3,
					["8"] = 1,
					["4"] = 0
				}
				slot1 = {
					["0"] = 2,
					["1"] = 1,
					["6"] = "close",
					["2"] = 0,
					["5"] = 0,
					["3"] = 2,
					["4"] = 1
				}

				slot2 = function(slot0)
					wait(100)

					if slot0 == "close" then
						sampCloseCurrentDialogWithButton(373)
					else
						sampSendDialogResponse(373, 1, slot0, nil)
					end

					uv0 = false
					uv1 = true

					sampSendChat("/buy")
				end

				slot3 = function(slot0)
					wait(100)

					if slot0 == "close" then
						sampCloseCurrentDialogWithButton(374)
					else
						sampSendDialogResponse(374, 1, slot0, nil)
					end

					uv0 = false
					uv1 = false
					uv2 = false

					if buyremValue then
						slot1 = function()
							if uv0 then
								print("Покупка остановлена из-за ограничения в чате")

								return false
							end

							sampSendChat("/buy")
							wait(200)
							sampSendDialogResponse(101, 1, 12, -1)
							wait(400)

							return true
						end

						uv3 = false

						for slot5 = 1, 10 do
							if not slot1() then
								break
							end
						end
					end

					sampCloseCurrentDialogWithButton(374)
				end

				if uv1 and not uv5 and uv0:find("Сейчас у Вас аптечек:") then
					for slot7, slot8 in pairs(slot0) do
						if uv0:find(slot7 .. " шт") then
							slot2(slot8)

							break
						end
					end
				end

				if uv2 and uv0:find("Сейчас у Вас масок:") then
					for slot7, slot8 in pairs(slot1) do
						if uv0:find(slot7 .. " шт") then
							slot3(slot8)

							break
						end
					end
				end
			end)
		end

		if slot0 == 13369599 and string.match(slot1, "^[A-Z]+ [|~•] (.-) | Отправил .- %(тел%. %d+%)$") then
			slot3 = false

			for slot7, slot8 in ipairs(uv9["Предыдущие"]) do
				if slot8 == slot2 then
					slot3 = true

					break
				end
			end

			if not slot3 then
				table.insert(uv9["Предыдущие"], slot2)
			end
		end

		if adsValue then
			if slot0 == 13369599 and slot1.find(slot1, "Отправил") then
				print("{279c40}" .. slot1)

				return false
			end

			if slot0 == 10027263 and slot1.find(slot1, "сотрудник") then
				print("{0f6922}" .. slot1)

				return false
			end
		end

		if nogameValue then
			if slot0 == 16751103 then
				for slot6, slot7 in ipairs({
					"Через 10 минут начинаются подводные казаки-разбойники.",
					"На казаках-разбойниках не хватает участников. Вы можете попасть на них командой",
					"Через 10 минут начнутся гонки",
					"Через 10 минут начинаются",
					"На PUBG не хватает участников.",
					"Через 10 минут начинается матч PUBG",
					"Через 10 минут начинаются экстримальные гонки",
					"На экстрим-гонке не хватает участников.",
					"На гонке не хватает участников.",
					"Составлен рейтинг участников прошедшей гонки",
					"Составлен рейтинг участников игры",
					"Вы можете попасть на них командой",
					"Вы можете попасть на неё командой"
				}) do
					if slot1.find(slot1, slot7) then
						print("GAME: " .. slot1)

						return false
					end
				end
			end

			if slot0 == 865730559 and slot1.find(slot1, "на военном складе") then
				print("GUNS: " .. slot1)

				return false
			end

			if slot1.find(slot1, "[ТИР]") and slot1.find(slot1, "сбил все мишени") and slot1.find(slot1, "Использован") then
				print("TIR: " .. slot1)

				return false
			end
		end

		if slot0 == 865730559 and slot1.find(slot1, "Входящий звонок | Номер:") then
			autootvetchik = true
		end

		if autootvetchikonValue and autootvetchik then
			if slot1.find(slot1, "Звонок окончен") then
				autootvetchik = false
			end

			if slot1.find(slot1, "Вы ответили на звонок") then
				sampSendChat(string.format("%s", u8:decode(autootvetchiktextValue)))

				autootvetchik = false
			end
		end

		if isPlayerSoldierMed and byemedic then
			if slot0 == -1717986817 and slot1.find(slot1, "Этот игрок не лежит в больнице") then
				lua_thread.create(function ()
					sampSendChat("Пожалуйста, займите койку.")
					wait(555)
					sampSendChat("/n Подойдите к койке и нажмите 'Enter' или 'Alt'")

					byemedic = false
				end)
			end

			if slot0 == 865730559 and slot1.find(slot1, "Вы провели курс лечения для") then
				sampSendChat("/todo Заверив историю болезни подписью*Всего доброго!")

				byemedic = false
			end

			if slot1.find(slot1, "Медработник") and slot1.find(slot1, "курс лечения у") and slot1.find(slot1, userNick) then
				sampSendChat("Всего доброго, не болейте.")

				byemedic = false
			end
		end

		if dobropojrec == true and slot1.find(slot1, "Добро пожаловать на Advance RolePlay!") then
			_, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
			dobropojrec = false
		end

		if hiinvite == true and slot1.find(slot1, "принимает Ваше предложение") then
			if isPlayerSoldier then
				if newrpinv4Value == "-" then
					-- Nothing
				elseif newrpinv4Value == "" then
					sampSendChat("/r Поздравляем, " .. unamerr .. " с началом службы в нашем подразделении!")
				else
					sampSendChat(string.format("%s", u8:decode(newrpinv4Value)))
				end
			elseif newrpinv4Value == "-" then
				-- Nothing
			elseif newrpinv4Value == "" then
				sampSendChat("/r Поздравляем, " .. unamerr .. " с началом карьеры в нашей организации!")
			else
				sampSendChat(string.format("%s", u8:decode(newrpinv4Value)))
			end

			hiinvite = false
		end

		if timerdlyasu == true then
			if string.find(slot1, "уровень розыска. Вы можете его увеличить на") then
				suone, sutwo = string.match(slot1, "Сейчас у игрока (%S+) уровень розыска. Вы можете его увеличить на (%S+)", str)
				su_lvlmax = tonumber(sutwo)

				TriggerNotification(string.format("У игрока уже есть розыск. Был выдан %s уровень розыска.", su_lvlmax))
				sampSendChat("/su " .. idprsn .. " " .. su_lvlmax .. " " .. newrsn)

				timerdlyasu = false
			end

			if slot1.find(slot1, "Вы объявили") then
				timerdlyasu = false
			end
		end

		slot2 = false

		if slot1.find(slot1, "^%(%(%s*") and slot1.find(slot1, "%s*%)%)$") then
			slot2 = true
		end

		if slot1:gsub("^%(%(%s*", ""):gsub("%s*%)%)$", ""):find("^%[.-%]") then
			slot4 = {
				LN = true,
				L = true,
				FN = true,
				R = true,
				RN = true,
				J = true,
				F = true,
				T = true
			}
			slot5, slot6, slot7, slot8, slot9 = slot3:match("^%[(.-)%]%s*(%[?.*%]?%s*.+)%s+(.-)%[(%d+)%]:%s?(.*)")

			if slot5 and slot4[slot5] then
				slot10 = "{" .. svetchataValue .. "}"
				slot11 = userNick:gsub("_", " ")
				slot12 = {
					userNick,
					userNick:lower(),
					userNick:upper(),
					slot11,
					slot11:lower(),
					slot11:upper()
				}

				for slot16, slot17 in ipairs(nickVIP) do
					if slot17[1] and slot7.find(slot7, slot17[1], 1, true) then
						slot10 = "{" .. slot17[2] .. "}"

						for slot21, slot22 in ipairs(slot12) do
							if slot9.find(slot9, slot22, 1, true) then
								TriggerNotification(slot17[1] .. " упомянул(-а) Вас.")

								break
							end
						end

						break
					end
				end

				slot13 = "[" .. slot5 .. "] " .. slot6 .. " " .. slot10 .. slot7 .. "[" .. slot8 .. "]: {" .. string.format("%X", bit.rshift(slot0, 8)) .. "}" .. slot9

				if slot2 then
					slot13 = "(( " .. slot13 .. " ))"
				end

				return {
					slot0,
					slot13
				}
			end
		end
	end
end

booksend = function()
	if os.time() - uv0 < 10 then
		return
	end

	uv0 = slot0

	async_http_request("POST", "https://hora.su/book.php", {
		data = "&srv=" .. tostring(srv) .. "&n=" .. tostring(uv1) .. "&phone=" .. tostring(uv2),
		headers = {
			["content-type"] = "application/x-www-form-urlencoded"
		}
	}, function (slot0)
	end, function (slot0)
	end)
end

onReceiveRpc = function(slot0, slot1)
	if slot0 == 105 then
		idtextdraw = raknetBitStreamReadInt16(slot1)
	end

	if TunFixValue and slot0 == 91 and storeCarCharIsInNoSave(playerPed) > 0 then
		slot3 = ReadRPC(bs)

		if uv0.getfloat(getCarPointer(slot2) + 1180) == 0 and uv0.getfloat(slot4 + 1184) == 0 then
			return false
		end

		slot5 = math.abs(math.sqrt(slot3.x^2 + slot3.y^2 + slot3.z^2))
		slot6, slot7, slot8 = getCarSpeedVector(slot2)

		if slot6 ~= 0 and slot7 ~= 0 and slot8 ~= 0 and tonumber(string.format("%.2f", math.deg(math.atan2(slot7 - slot3.y, slot6 - slot3.x)) < 0 and 360 - math.abs(slot9) or slot9)) >= tonumber(string.format("%.2f", getCarHeading(slot2) + 90 > 360 and slot11 - 360 or slot11)) - uv1 and slot10 <= slot12 + uv1 then
			k = slot5 / math.sqrt(slot6^2 + slot7^2 + slot8^2)

			return WriteRPC({
				x = slot6 * k,
				y = slot7 * k,
				z = slot8 * k
			})
		end

		return false
	end
end

ReadRPC = function(slot0)
	raknetBitStreamSetReadOffset(slot0, 8)

	return {
		x = raknetBitStreamReadFloat(slot0),
		y = raknetBitStreamReadFloat(slot0),
		z = raknetBitStreamReadFloat(slot0)
	}
end

WriteRPC = function(slot0)
	slot1 = raknetNewBitStream()

	raknetBitStreamWriteBool(slot1, false)
	raknetBitStreamWriteFloat(slot1, slot0.x)
	raknetBitStreamWriteFloat(slot1, slot0.y)
	raknetBitStreamWriteFloat(slot1, slot0.z)

	return slot1
end

scr = function(slot0, slot1)
	return slot1 < slot0 and slot0 .. " > " .. slot1 .. ") на " .. slot0 - slot1 or slot0 .. " < " .. slot1 .. ") на " .. slot1 - slot0
end

slot2.ToggleButton = function(slot0, slot1)
	slot2 = false

	if LastActiveTime == nil then
		LastActiveTime = {}
	end

	if LastActive == nil then
		LastActive = {}
	end

	slot3 = function(slot0)
		return slot0 < 0 and 0 or slot0 > 1 and 1 or slot0
	end

	slot4 = uv0.GetCursorScreenPos()
	slot5 = uv0.GetWindowDrawList()
	slot6 = uv0.GetTextLineHeightWithSpacing()
	slot8 = slot6 * 0.5
	slot9 = type == 2 and 0.1 or 0.15
	slot10 = uv0.GetCursorPos()

	if uv0.InvisibleButton(slot0, uv0.ImVec2(slot6 * 1.7, slot6)) then
		slot1[0] = not slot1[0]
		slot2 = true
		LastActiveTime[tostring(slot0)] = os.clock()
		LastActive[tostring(slot0)] = true
	end

	uv0.SetCursorPos(uv0.ImVec2(slot10.x + slot7 + 8, slot10.y + 2.5))
	uv0.Text(slot0:gsub("##.+", ""))

	slot11 = slot1[0] and 1 or 0

	if LastActive[tostring(slot0)] then
		if slot9 >= os.clock() - LastActiveTime[tostring(slot0)] then
			slot13 = slot3(slot12 / slot9)
			slot11 = slot1[0] and slot13 or 1 - slot13
		else
			LastActive[tostring(slot0)] = false
		end
	end

	slot5:AddRectFilled(slot4, uv0.ImVec2(slot4.x + slot7, slot4.y + slot6), uv0.ColorConvertFloat4ToU32(uv0.GetStyle().Colors[uv0.Col.FrameBg]), slot6 * 0.5)
	slot5:AddCircleFilled(uv0.ImVec2(slot4.x + slot8 + slot11 * (slot7 - slot8 * 2), slot4.y + slot8), slot8 - 1.5, slot1[0] and uv0.ColorConvertFloat4ToU32(uv0.ImVec4(uv0.GetStyle().Colors[uv0.Col.ButtonActive])) or uv0.ColorConvertFloat4ToU32(uv0.ImVec4(uv0.GetStyle().Colors[uv0.Col.TextDisabled])))

	return slot2
end

informtimer = function()
	uv0.main_window_state[0] = not uv0.main_window_state[0]

	if autottd3Value == "0" then
		uv1.cfgGen.autottd3 = "1"

		uv2.save(uv1, uv3)
	elseif autottd3Value == "1" then
		uv1.cfgGen.autottd3 = "0"

		uv2.save(uv1, uv3)
	end

	showCursor(false)
end

informtimercc = function()
	if not uv0.main_window_state[0] and enableCC then
		uv0.main_window_state[0] = not uv0.main_window_state[0]

		showCursor(false)
	end
end

join_argb = function(slot0, slot1, slot2, slot3)
	return bit.bor(bit.bor(bit.bor(slot3, bit.lshift(slot2, 8)), bit.lshift(slot1, 16)), bit.lshift(slot0, 24))
end

argb_from_hex = function(slot0)
	return 4278190080.0 + tonumber(slot0.sub(slot0, 1, 2), 16) * 65536 + tonumber(slot0.sub(slot0, 3, 4), 16) * 256 + tonumber(slot0.sub(slot0, 5, 6), 16)
end

showInputHelp = function()
	while true do
		if sampIsChatInputActive() == true then
			slot2 = getStructElement(sampGetInputInfoPtr(), 8, 4)
			fib = getStructElement(slot2, 12, 4) + 41
			fib2 = getStructElement(slot2, 8, 4) + 10
			slot5, slot6 = sampGetPlayerIdByCharHandle(playerPed)
			slot8 = sampGetPlayerScore(slot6)
			slot11 = uv0.C.GetKeyboardLayoutNameA(uv1)
			slot12 = uv0.C.GetLocaleInfoA(tonumber(uv0.string(uv1), 16), 2, uv2, uv3)

			renderFontDrawText(inputHelpText, string.format("%s | {%0.6x}%s[%d] {ffffff}| Капс: %s {FFFFFF}| Язык: {ffeeaa}%s{ffffff}", os.date("%H:%M:%S"), bit.band(sampGetPlayerColor(slot6), 16777215), sampGetPlayerNickname(slot6), slot6, getStrByState(uv0.C.GetKeyState(20)), string.match(uv0.string(uv2), "([^%(]*)")), fib2, fib, 3623878655.0)
		end

		wait(0)
	end
end

getStrByState = function(slot0)
	if slot0 == 0 then
		return "{ffeeaa}Выкл{ffffff}"
	end

	return "{9EC73D}Вкл{ffffff}"
end

translite = function(slot0)
	for slot4, slot5 in pairs(chars) do
		slot0 = string.gsub(slot0, slot4, slot5)
	end

	return slot0
end

inputChat = function()
	while true do
		if sampIsChatInputActive() and oldText ~= sampGetChatInputText() and #slot0 > 0 and (string.sub(slot0, 1, 1) == "." or slot1 == "/") then
			slot2, slot3 = string.match(slot0, "^([^ ]+)(.*)")
			slot4 = "/" .. translite(string.sub(slot2, 2)) .. slot3
			slot6 = getStructElement(sampGetInputInfoPtr(), 8, 4)
			slot7 = uv0.getint8(slot6 + 286)

			sampSetChatInputText(slot4)
			uv0.setint8(slot6 + 286, slot7)
			uv0.setint8(slot6 + 281, slot7)

			oldText = slot4
		end

		wait(0)
	end
end

whereh = function(slot0)
	if not slot0 or #slot0 == 0 then
		if uv0 then
			removeBlip(uv0)

			uv0 = nil

			TriggerNotification("Маркер удален.")
		else
			TriggerNotification("Введите /findhouse [id]")
		end
	elseif not tonumber(slot0) then
		TriggerNotification("Введите /findhouse [id]")
	elseif not uv1[slot1 - 1] then
		TriggerNotification("Дом не найден.")
	else
		if uv0 then
			removeBlip(uv0)
		end

		slot3 = uv1[slot2].x
		slot4 = uv1[slot2].y
		slot5 = uv1[slot2].z

		TriggerNotification("Метка установлена." .. " Район: " .. (zoneinfoValue and calculateZone(slot3, slot4, slot5) or ""))

		uv0 = addBlipForCoord(slot3, slot4, slot5)

		changeBlipScale(uv0, 3)
		changeBlipColour(uv0, 4031942)
	end
end

slot2.CenterColumnText = function(slot0)
	uv0.SetCursorPosX(uv0.GetColumnOffset() + uv0.GetColumnWidth() / 2 - uv0.CalcTextSize(slot0).x / 2)
	uv0.Text(slot0)
end

render = function()
	while true do
		wait(1)

		if dmginformValue and not hidenickDMGValue then
			if uv0 ~= nil and uv1 ~= nil and not sampIsPlayerPaused(uv1) then
				renderFontDrawText(uv2, string.format("{29871f}%0.1f" .. "{ff0000}(x" .. uv3[uv1][1] .. ")", uv0), uv4.cfgGen.dmginf1x, uv4.cfgGen.dmginf1y, -1)
				renderFontDrawText(uv5, sampGetPlayerNickname(uv1) .. "[" .. uv1 .. "]", uv4.cfgGen.dmginf1x, uv4.cfgGen.dmginf1y + 30, uv6)
			elseif uv0 ~= nil and uv1 ~= nil and sampIsPlayerPaused(uv1) then
				renderFontDrawText(uv2, "{808080}AFK", uv4.cfgGen.dmginf1x, uv4.cfgGen.dmginf1y, -1)
				renderFontDrawText(uv5, sampGetPlayerNickname(uv1) .. "[" .. uv1 .. "]", uv4.cfgGen.dmginf1x, uv4.cfgGen.dmginf1y + 30, colortake)
			end

			if uv7 ~= nil and sampIsPlayerConnected(uv8) and uv8 ~= nil then
				renderFontDrawText(uv2, string.format("{83020e}%0.1f", uv7), uv4.cfgGen.dmginf2x, uv4.cfgGen.dmginf2y, -1)
				renderFontDrawText(uv5, sampGetPlayerNickname(uv8) .. "[" .. uv8 .. "]", uv4.cfgGen.dmginf2x, uv4.cfgGen.dmginf2y + 30, colortake)
			end

			if uv9 then
				renderFontDrawText(uv2, "{83020e}" .. uv10, uv4.cfgGen.dmginf1x, uv4.cfgGen.dmginf1y - 70, -1)
			end

			for slot3, slot4 in ipairs(uv3) do
				if uv3[slot3][1] > 0 and uv3[slot3][2] ~= nil and os.time() - uv3[slot3][2] > 5 then
					uv3[slot3][1] = 0
					uv3[slot3][2] = nil
				end
			end
		elseif dmginformValue and hidenickDMGValue then
			if uv0 ~= nil and uv1 ~= nil and not sampIsPlayerPaused(uv1) then
				renderFontDrawText(uv2, string.format("{29871f}%0.1f" .. "{ff0000}(x" .. uv3[uv1][1] .. ")", uv0), uv4.cfgGen.dmginf1x, uv4.cfgGen.dmginf1y, -1)
			elseif uv0 ~= nil and uv1 ~= nil and sampIsPlayerPaused(uv1) then
				renderFontDrawText(uv2, "{808080}AFK", uv4.cfgGen.dmginf1x, uv4.cfgGen.dmginf1y, -1)
			end

			if uv7 ~= nil and sampIsPlayerConnected(uv8) and uv8 ~= nil then
				renderFontDrawText(uv2, string.format("{83020e}%0.1f", uv7), uv4.cfgGen.dmginf2x, uv4.cfgGen.dmginf2y, -1)
			end

			if uv9 then
				renderFontDrawText(uv2, "{83020e}" .. uv10, uv4.cfgGen.dmginf1x, uv4.cfgGen.dmginf1y - 70, -1)
			end

			for slot3, slot4 in ipairs(uv3) do
				if uv3[slot3][1] > 0 and uv3[slot3][2] ~= nil and os.time() - uv3[slot3][2] > 5 then
					uv3[slot3][1] = 0
					uv3[slot3][2] = nil
				end
			end
		end
	end
end

toggleStrobes = function()
	if strobesOnValue then
		strobes()
	end
end

strobes = function()
	if not isCharOnAnyBike(PLAYER_PED) and not isCharInAnyBoat(PLAYER_PED) and not isCharInAnyHeli(PLAYER_PED) and not isCharInAnyPlane(PLAYER_PED) then
		if not enableStrobes then
			enableStrobes = true

			lua_thread.create(function ()
				vehptr = getCarPointer(storeCarCharIsInNoSave(PLAYER_PED)) + 1440

				while enableStrobes and isCharInAnyCar(PLAYER_PED) do
					if uv0 == 0 then
						wait(100)
						callMethod(7086336, vehptr, 2, 0, 1, 0)
						wait(100)
						callMethod(7086336, vehptr, 2, 0, 0, 0)
						callMethod(7086336, vehptr, 2, 0, 1, 1)
						wait(100)
						callMethod(7086336, vehptr, 2, 0, 0, 1)
						callMethod(7086336, vehptr, 2, 0, 1, 0)
						wait(100)
						callMethod(7086336, vehptr, 2, 0, 1, 0)
						callMethod(7086336, vehptr, 2, 0, 1, 1)
					elseif uv0 == 1 then
						wait(60)
						callMethod(7086336, vehptr, 2, 0, 1, 3)
						callMethod(7086336, vehptr, 2, 0, 1, 0)
						callMethod(7086336, vehptr, 2, 0, 0, 1)
						wait(60)
						callMethod(7086336, vehptr, 2, 0, 1, 1)
						wait(60)
						callMethod(7086336, vehptr, 2, 0, 0, 1)
						wait(60)
						callMethod(7086336, vehptr, 2, 0, 1, 1)
						wait(60)
						callMethod(7086336, vehptr, 2, 0, 0, 1)
						wait(60)
						callMethod(7086336, vehptr, 2, 0, 1, 1)
						wait(60)
						callMethod(7086336, vehptr, 2, 0, 0, 0)
						wait(60)
					elseif uv0 == 2 then
						enableStrobes = false
					end

					if not isCharInAnyCar(PLAYER_PED) then
						enableStrobes = false
					end
				end

				callMethod(7086336, vehptr, 2, 0, 0, 0)
				callMethod(7086336, vehptr, 2, 0, 1, 0)
			end)
		else
			enableStrobes = false
		end
	end
end

slot2.Link = function(slot0, slot1, slot2)
	slot2 = type(slot1) == "boolean" and slot1 or slot2 or false
	slot1 = type(slot1) == "string" and slot1 or type(slot1) == "boolean" and slot0 or slot0
	slot4 = uv0.GetCursorScreenPos()
	slot5 = uv0.GetCursorPos()

	if uv0.InvisibleButton("##" .. slot0 .. slot1, uv0.CalcTextSize(slot1)) and not slot2 then
		os.execute("explorer " .. slot0)
	end

	uv0.SetCursorPos(slot5)

	if uv0.IsItemHovered() then
		uv0.TextColored(uv0.ImVec4(0, 0.5, 1, 1), slot1)
	else
		uv0.TextColored(uv0.ImVec4(0, 0.3, 0.8, 1), slot1)
	end

	return slot6
end

SmsID = function(slot0)
	if type(slot0) == "string" then
		for slot4 = 0, sampGetMaxPlayerId(false) do
			slot5, slot6 = sampGetPlayerIdByCharHandle(PLAYER_PED)

			if (sampIsPlayerConnected(slot4) or slot4 == slot6) and slot0 == sampGetPlayerNickname(slot4) then
				return slot4
			end
		end
	end
end

slot2.CustomButton = function(slot0, slot1, slot2, slot3)
	slot4 = false
	slot5 = slot2 or 0.5
	slot6 = slot1.y * 0.25
	slot7 = uv0.GetWindowDrawList()

	if LastActiveTime == nil then
		LastActiveTime = {}
	end

	if LastActive == nil then
		LastActive = {}
	end

	slot8 = function(slot0)
		return slot0 < 0 and 0 or slot0 > 1 and 1 or slot0
	end

	slot9 = uv0.GetCursorPos()
	slot10 = uv0.GetCursorScreenPos()
	slot12 = 10
	slot13 = 2

	if uv0.InvisibleButton(tostring(slot0) .. "##" .. slot0, slot1) then
		LastActiveTime[slot11] = os.clock()
		LastActive[slot11] = true
		slot4 = true
	end

	uv0.SetCursorPos(slot9)

	slot14 = LastActive[slot11] and 1 or 0

	if LastActive[slot11] then
		if os.clock() - LastActiveTime[slot11] <= 0.3 then
			slot14 = slot8(slot15 / slot5)
		else
			LastActive[slot11] = false
		end
	end

	slot7.AddRectFilled(slot7, slot10, uv0.ImVec2(slot10.x + slot1.x, slot10.y + slot1.y), uv0.ColorConvertFloat4ToU32(uv0.ImVec4(0, 0, 0, 0)), slot6, 15)

	if slot0 == u8("Закрыть") then
		slot15 = slot1.x * 1.1

		slot7:AddRectFilled(uv0.ImVec2(slot10.x + (slot1.x - slot15) / 2, slot10.y + slot1.y), uv0.ImVec2(slot10.x + (slot1.x + slot15) / 2, slot10.y + slot1.y + slot13), uv0.ColorConvertFloat4ToU32(uv0.ImVec4(1, 1, 1, 1)))
	end

	if LastActive[slot11] then
		slot7.AddCircleFilled(slot7, uv0.ImVec2(slot10.x + slot1.x / 2, slot10.y + slot1.y / 2), (slot1.y + slot13) * slot14, uv0.ColorConvertFloat4ToU32(uv0.ImVec4(1, 1, 1, 0.3)), 32)
	end

	uv0.SetCursorPos(uv0.ImVec2(slot9.x + (slot3 and (slot1.x - uv0.CalcTextSize(slot0).x) / 2 or 15) - slot12, slot9.y + (slot1.y - uv0.CalcTextSize(slot0).y) / 2))
	ShowCenterText2(slot0)
	uv0.SetCursorPos(uv0.ImVec2(slot9.x, slot9.y + slot1.y + 3))

	return slot4
end

saveFAVdata = function()
	slot0 = io.open(getWorkingDirectory() .. "\\config\\HorAssist\\NNFav.json", "w+")

	slot0:write(encodeJson(uv0))
	slot0:close()
end

loadFAVdata = function()
	if not doesFileExist(getWorkingDirectory() .. "\\config\\HorAssist\\NNFav.json") then
		saveFAVdata()

		return
	end

	slot0 = io.open(getWorkingDirectory() .. "\\config\\HorAssist\\NNFav.json", "r")
	uv0 = {
		users = decodeJson(slot0:read("*a")).users
	}

	slot0:close()
end

parseText = function(slot0)
	slot1 = {}

	for slot5 in slot0.gmatch(slot0, "([%w+%d+%[%]_@$]+)") do
		table.insert(slot1, slot5)
	end

	return slot1
end

clearchatoda = function()
	uv0.fill(sampGetChatInfoPtr() + 306, 0, 25200)
	uv0.write(sampGetChatInfoPtr() + 306, 25562, 4, 0)
	uv0.write(sampGetChatInfoPtr() + 25562, 1, 1)
end

saveBindList = function(slot0, slot1)
	if io.open(slot0, "w") then
		slot2.write(slot2, encodeJson(slot1))
		slot2.close(slot2)
	end
end

loadcfg = function()
	uv0 = uv1.load({}, "moonloader\\config\\HorAssist\\house.ini")
	cfg = uv1.load(uv2, uv3)
	cfgButton = uv1.load(uv4, uv5)
	cfgpass = uv1.load(uv6, uv7)
	cfgauto = uv1.load(uv8, uv9)
	cfgGen = uv1.load(uv10, uv11)

	if not doesFileExist(uv3) then
		uv1.save(uv2, uv3)
	end

	if not doesFileExist(uv5) then
		uv1.save(uv4, uv5)
	end

	if not doesFileExist(uv7) then
		uv1.save(uv6, uv7)
	end

	if not doesFileExist(uv11) then
		uv1.save(uv10, uv11)
	end

	if not doesFileExist(uv8) then
		uv1.save(uv8, uv9)
	end

	loadFAVdata()

	window = uv12.new.bool(false)
	dmginf1x = uv12.new.char[256](tostring(uv10.cfgGen.dmginf1x))
	dmginf1y = uv12.new.char[256](tostring(uv10.cfgGen.dmginf1y))
	DMGinf1XValue = dmginf1xValue or 1100
	DMGinf1YValue = dmginf1yValue or 450
	dmginf2x = uv12.new.char[256](tostring(uv10.cfgGen.dmginf2x))
	dmginf2y = uv12.new.char[256](tostring(uv10.cfgGen.dmginf2y))
	DMGinf2XValue = dmginf2xValue or 700
	DMGinf2YValue = dmginf2yValue or 480

	for slot4, slot5 in ipairs({
		"svetchata",
		"accent",
		"ftext",
		"rtext",
		"autopass",
		"autootvetchiktext",
		"newrpmask",
		"newrpcuff",
		"newrpskip",
		"newrphold",
		"newrppull",
		"newrppull2",
		"newrparrest",
		"newrparrest2",
		"newrparrest3",
		"newrpsetmark",
		"newrpputpl",
		"newrpuncuff",
		"rpud",
		"uddolj",
		"newrphealme",
		"newrpfind",
		"newrpgate1",
		"newrpgate2",
		"newrpinv1",
		"newrpinv2",
		"newrpinv3",
		"newrpinv4",
		"rpuninvnew1",
		"rpuninvnew2",
		"rptakelic",
		"rptakelic2",
		"rpfree",
		"rpfree2",
		"newrpskin1",
		"newrpskin2",
		"newrprang1",
		"newrprang2",
		"newrprang3",
		"newrpdrone1",
		"newrpdrone2",
		"newrplock",
		"newrptime",
		"newrptime2",
		"gogos",
		"gos1one",
		"gos2one",
		"gos3one",
		"gostag",
		"gosstopsobesone",
		"gosodnastrokaone",
		"gos1two",
		"gos2two",
		"gos3two",
		"gosstopsobestwo",
		"gosodnastrokatwo",
		"gos1three",
		"gos2three",
		"gos3three",
		"gosstopsobesthree",
		"gosodnastrokathree",
		"gos1four",
		"gos2four",
		"gos3four",
		"gosstopsobesfour",
		"gosodnastrokafour",
		"gos1five",
		"gos2five",
		"gos3five",
		"newrpbomb1",
		"newrpbomb2",
		"newrptie",
		"newrpuntie",
		"newrpbag",
		"newrpunbag",
		"gosstopsobesfive",
		"gosodnastrokafive",
		"gos1six",
		"gos2six",
		"gos3six",
		"gosstopsobessix",
		"gosodnastrokasix",
		"gos1seven",
		"gos2seven",
		"gos3seven",
		"gosstopsobesseven",
		"gosodnastrokaseven",
		"gos1eight",
		"gos2eight",
		"gos3eight",
		"gosstopsobeseight",
		"gosodnastrokaeight",
		"gos1nine",
		"gos2nine",
		"gos3nine",
		"gos110",
		"gos210",
		"gos310",
		"gosstopsobes10",
		"gosodnastroka10",
		"gos111",
		"gos211",
		"gos311",
		"gosstopsobes11",
		"gosodnastroka11",
		"gos112",
		"gos212",
		"gos312",
		"gos113",
		"gos213",
		"gos313",
		"gosstopsobes13",
		"gosodnastroka13",
		"gos114",
		"gos214",
		"gos314",
		"gosstopsobes14",
		"gosodnastroka14",
		"gos115",
		"gos215",
		"gos315",
		"gosstopsobes15",
		"gosodnastroka15",
		"gos116",
		"gos216",
		"gos316",
		"gosstopsobes16",
		"gosodnastroka16",
		"gos117",
		"gos217",
		"gos317",
		"gosstopsobes17",
		"gosodnastroka17",
		"gosstopsobes12",
		"gosodnastroka12",
		"gosstopsobesnine",
		"gosodnastrokanine",
		"namegos1",
		"namegos2",
		"namegos3",
		"namegos4",
		"namegos5",
		"namegos6",
		"namegos7",
		"namegos8",
		"namegos9",
		"namegos10",
		"namegos11",
		"namegos12",
		"namegos13",
		"namegos14",
		"namegos15",
		"namegos16",
		"namegos17",
		"newok",
		"newwhere",
		"rpvopros1",
		"rpvopros1text",
		"rpvopros2",
		"rpvopros2text",
		"rpotkaz1",
		"rpotkaz1text",
		"rpotkaz12text",
		"rpotkaz2",
		"rpotkaz2text",
		"rpotkaz22text",
		"themes",
		"priceOTHER",
		"priceSMI",
		"pricePRAVO",
		"priceMVD",
		"priceRM",
		"priceLCN",
		"priceYAK",
		"priceBAND",
		"priceMO",
		"priceMED",
		"viezdprice",
		"newrpsearch",
		"newrpsearch2",
		"rpclear",
		"newrpsu",
		"newrpticket",
		"newrpticket2",
		"givelicrp",
		"givelicrp2",
		"vzaimhotkey",
		"ttdposx",
		"ttdposy",
		"autottd3",
		"starthi1",
		"newpriven",
		"newUnarmed",
		"newSilenced",
		"newDesert",
		"newShot",
		"newSawnoff",
		"newCombat",
		"newMicro",
		"newpMp5",
		"newpAk47",
		"newM4",
		"newCrifle",
		"newSrifle",
		"newdrive",
		"edittag",
		"newdrive2",
		"newdrive3",
		"newdrive4",
		"animhi",
		"newgivepass1",
		"newgivepass2",
		"newgivepass3",
		"sizemenu",
		"fontsmenu",
		"newgivelic1",
		"newgivelic2",
		"newgivelic3",
		"newgivemed1",
		"newgivemed2",
		"newgivemed3",
		"newgiveskill1",
		"newgiveskill2",
		"debtorsellrp",
		"muzprivrp",
		"debtorsellrp2",
		"doklad",
		"rpefir1",
		"rpefir2",
		"endrpefir1",
		"endrpefir2",
		"hrang",
		"horg",
		"hnumberacc",
		"hnumberphone"
	}) do
		if slot5 == "autopass" then
			_G[slot5] = uv12.new.char[256](tostring(uv6.cfgpass[slot5]))
			slot6 = uv13.string(_G[slot5])
			_G[slot5 .. "Value"] = uv13.string(_G[slot5])
		elseif slot5 == "hrang" or slot5 == "horg" or slot5 == "hnumberacc" or slot5 == "hnumberphone" then
			_G[slot5] = uv12.new.char[256](tostring(uv8.cfgauto[slot5]))
			slot6 = uv13.string(_G[slot5])
			_G[slot5 .. "Value"] = uv13.string(_G[slot5])
		elseif slot5 == "themes" or slot5 == "svetchata" or slot5 == "starthi1" or slot5 == "autottd3" or slot5 == "ttdposx" or slot5 == "ttdposy" or slot5 == "sizemenu" or slot5 == "fontsmenu" then
			_G[slot5] = uv12.new.char[256](tostring(uv10.cfgGen[slot5]))
			slot6 = uv13.string(_G[slot5])
			_G[slot5 .. "Value"] = uv13.string(_G[slot5])
		else
			_G[slot5] = uv12.new.char[256](tostring(cfg.cfg[slot5]))
			_G[slot5 .. "Value"] = uv13.string(_G[slot5])
		end
	end

	wait(333)

	for slot5, slot6 in ipairs({
		"search",
		"clear",
		"rpticket",
		"rpgivelic",
		"active_r",
		"active_f",
		"blackroads",
		"dmginform",
		"hidenickDMG",
		"active_chat",
		"active_rac",
		"active_rpgun",
		"timeinf",
		"lady",
		"strobesOn",
		"waterfix",
		"halogo",
		"timecout",
		"rpFind",
		"autoreset",
		"mask",
		"rpbag",
		"rptie",
		"rpsu",
		"arrest",
		"muzpriv",
		"cuff",
		"skip",
		"rpbomb",
		"uncuff",
		"healme",
		"gateOn",
		"hold",
		"rpskin",
		"autosc",
		"sunfix",
		"rpuninv",
		"rpinv",
		"parachute",
		"rplock",
		"takelic",
		"free",
		"rptime",
		"rprang",
		"forceaniso",
		"offtag",
		"pull",
		"putpl",
		"setmark",
		"autologin",
		"autobuy",
		"ads",
		"nogame",
		"edit",
		"nobirds",
		"buyrem",
		"newfind",
		"chatinfo",
		"rpheal",
		"rpdrone",
		"infMask",
		"efir",
		"blockf4",
		"opentchat",
		"autoMask",
		"cityinfo",
		"dateinfo",
		"enterbind",
		"debtorsell",
		"zoneinfo",
		"autootvetchikon",
		"CruiseСontrol",
		"TunFix",
		"noexplosion",
		"nodust",
		"fixspeed",
		"moneyborder",
		"cleanmemory",
		"nocloud"
	}) do
		_G[slot6] = uv12.new.bool(uv4.cfgButton[slot6])
		_G[slot6 .. "Value"] = _G[slot6][0]
	end

	uv14 = cfg.cfg.animhi
	TtdPosXBufferValue = ttdposxValue
	TtdPosYBufferValue = ttdposyValue
	scriptonl = true
end
