import colors from 'vuetify/es5/util/colors'

const ENV = 'UAT'
//const ENV = 'PROD'

if(ENV=='UAT'){
    var APP_NAME = "Fine.Work"
    var CLIENT_NAME = "Feng Guo 691427@QQ.COM"
    var API_URL = "http://114.115.178.72/FineWork/API"
    //var API_URL = "http://localhost:9909/API"
    //var API_URL = "http://103.254.77.30:8001/API"
    //var API_URL = "http://127.0.0.1:3000"
}else{
    var APP_NAME = "中阳集团项目进度跟踪系统"
    var CLIENT_NAME = "中阳集团"
    var API_URL = "/FineWork/API"
}

const Themes = [
    { primary: colors.lightBlue , secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.orange.darken2, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3, },
    { primary: colors.teal.darken1, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.cyan, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.green.darken3, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.deepPurple , secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.brown.darken3, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.indigo.darken3, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.blueGrey, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.blue.darken1, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.grey, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.shades.black, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.amber.darken1, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.pink.accent2, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3, info: colors.pink.accent4 },
    { primary: colors.red, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.lightGreen.accent4, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.purple.accent2, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.lime, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
]
const Theme = Themes[0]


//单数反转
//wget --no-cookie --no-check-certificate
const WALL_PAPER_URL = "https://cn.bing.com/HPImageArchive.aspx?format=js&idx=1&n=10&nc=1361089515117&FORM=HYLH1"
const WALLPAPERS = [
'https://cn.bing.com/az/hprichbg/rb/GoldenEagle_EN-CN5621882775_1920x1080.jpg', //egale
'https://cn.bing.com/az/hprichbg/rb/HoaryMarmot_ZH-CN7175843832_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/PlatteRiver_EN-CN2505500515_1920x1080.jpg', //Many bird
'https://cn.bing.com/az/hprichbg/rb/GBBC_EN-CN7021386584_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/GoldfinchSnow_EN-CN6193065571_1920x1080.jpg',   //bird
'https://cn.bing.com/az/hprichbg/rb/RavenWolf_EN-CN1564432890_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/LaDigue_EN-CN5418321345_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/UpHellyAa_EN-CN4575576413_1920x1080.jpg',
'https://cn.bing.com/sa/simg/hpb/NorthMale_EN-US8782628354_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.LoisachKochelsee_ZH-CN5859866695_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.Punakaiki_ZH-CN6944508336_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.lantern19_ZH-CN7846752344_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/HolocaustMemorial_EN-CN3092493021_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/KukeriCostume_EN-CN6866832286_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/BodegasYsios_EN-CN6930432309_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/OceanDrive_EN-CN5355005673_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/BM1759_EN-CN5095819877_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/Snowkiters_EN-CN6799323123_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/UKSomerset_EN-CN3755440952_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/NapoleonsHat_EN-CN7390815343_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/RainierDawn_EN-CN2623942425_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/VietnamStairs_EN-CN3105923263_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/FortRajgad_EN-CN7910178011_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/WinterLynx_EN-CN6283951646_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/MinnewankaBoathouse_ZH-CN0548323518_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/JapanCrane_EN-CN4265943819_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/UFOMuseum_EN-CN3265083079_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/BathBach_EN-CN2668793997_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/PingxiSky_EN-CN9973358728_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/OldTownTallinn_ZH-CN4833535739_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.PolarBearDay_ZH-CN5185516722_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.KomondorKennel_ZH-CN6009722858_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.CumulusCaribbean_EN-CN5051678201_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.WinterGrand_EN-CN5734771587_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.HZMB_ZH-CN5238831909_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.LeopardNamibia_ZH-CN9585068449_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BagpipeOpera_ZH-CN9506207351_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.GrapeHarvest_ZH-CN9372743517_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.Cefalu_ZH-CN9108906653_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.MardiGrasIndians_ZH-CN9075989964_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.ElephantMarch_ZH-CN8771717837_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.FinWhale_ZH-CN9010064973_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.VinicuncaMountain_ZH-CN8884315159_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.FallasBonfire_ZH-CN0990476822_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.TofinoCoast_ZH-CN0950198582_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.TaoiseachDept_ZH-CN0902989482_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.ChitalDawn_ZH-CN0851079165_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.SeptimiusSeverus_ZH-CN0799811992_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.AgriculturalPi_ZH-CN9754138523_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.SpainRioTinto_ZH-CN9632593185_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.SakuraFes_ZH-CN1341601988_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.AthensNight_ZH-CN1280970241_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.PWSRecovery_ZH-CN1234475074_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.HolePunchClouds_ZH-CN1184083504_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.TashkurganGrasslands_ZH-CN1141881683_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.springequinox_ZH-CN1099430476_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.EarlyBloomer_ZH-CN1044452089_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.RufousTailed_ZH-CN1593368869_1920x1080.jpg', 
'https://cn.bing.com/th?id=OHR.BlueTide_EN-CN9954190271_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.SPLLobby_EN-CN6683267834_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.Pepper_EN-CN5843968151_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.YongfuTown_EN-CN5641189378_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.NelderPlot_EN-CN8813996472_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BistiBadlands_EN-CN8442784979_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.HCABooks_EN-CN7398127982_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.MischiefCubs_EN-CN7135466931_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.EiffelBelow_EN-CN6709821136_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.EarthHourNYC_EN-CN6307178711_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.AurovilleIndia_EN-CN5835825337_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.WallaceMonument_ZH-CN4008495741_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.ChilehausHH_ZH-CN3895221092_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.QingmingBridge_ZH-CN3844222543_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.YukonEmerald_ZH-CN1893750172_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.SibWrestling_ZH-CN4106007210_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BlueTide_ZH-CN4055424992_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.ChipmunkCheeks_ZH-CN2370754946_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BesenheideBDJ_ZH-CN2139380821_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.AlpineEucalyptBark_ZH-CN2046783535_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.MiracleGarden_EN-CN7437183058_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.HopeValley_EN-CN7216481679_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BauhausArchive_EN-CN6923966348_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.GOTPath_EN-CN6091513115_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.RecordStoreDay_EN-CN5641273719_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BigWindDay_EN-CN5446594497_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.Bollenstreek_EN-CN6821407382_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.CasaBatllo_ZH-CN2826447794_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.LaysanAlbatross_ZH-CN2784683590_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.HidingEggs_ZH-CN2732414254_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.CoveSpires_ZH-CN2680932006_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.Paepalanthus_ZH-CN2626725103_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.HopeValley_ZH-CN2208363231_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.GlenfinnanViaduct_ZH-CN8400951216_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BabySloth_ZH-CN8329403615_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.SpringBadlands_ZH-CN8280871661_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BloomingAloe_ZH-CN8209855003_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.CoastalFog_ZH-CN8104406852_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.FireIce_ZH-CN2924097132_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.RainforestMoss_ZH-CN2878951870_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.NCFireweed_ZH-CN8827671063_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.StMaryFalls_ZH-CN8917284967_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.LightHouseNS_ZH-CN9060766128_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.SerengetiZebra_ZH-CN9007197602_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.ChannelIslandFox_ZH-CN5568101953_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.ZaanseSchans_ZH-CN5665496862_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.PipingPlover_ZH-CN0992806167_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BlueCannes_ZH-CN1811852585_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.JasperCub_ZH-CN4314891686_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BicycleRelief_ZH-CN4483533362_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BluebellBeech_ZH-CN8269343251_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.Ghyakar_ZH-CN4631836915_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BeeWeek_ZH-CN4917222816_1920x1080.jpg',
]

//项目状态
const ProjectStatus = [
    { value: '筹备中', text: '筹备中' },
    { value: '在建中', text: '在建中' },
    { value: '已停工', text: '已停工' },
    { value: '已竣工', text: '已竣工' },
    { value: '已验收', text: '已验收' },
]

//施工阶段
const ProjectPhase = [
    '基础工程',
    '主体工程',
    '屋面工程',
    '装饰装修工程',
]

//项目性质类型
const ProjcetType = ['新建', '扩建', '改建', '拆建', '恢复', '其他']


//任务状态
const TaskStatus = ['未开工', '施工中', '已停工', '已完工', ]
const TaskProgress = ['正常', '已延期', '已逾期']


//用户权限
const UserPermissions = [
    { value: 'project-management', text: '项目管理' },
    { value: 'plan-management', text: '计划管理' },
    { value: 'progress-management', text: '进度管理' },
    { value: 'system-management', text: '系统管理' },
]

export default {
    APP_NAME,
    CLIENT_NAME,
    API_URL,
    WALL_PAPER_URL,
    WALLPAPERS,
    Themes,
    Theme,
    ProjectStatus,
    TaskStatus,
    ProjcetType,
    ProjectPhase,
    UserPermissions,
}
