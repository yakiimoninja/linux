//~/.config/suckless/dwm*
/* See LICENSE file for copyright and license details. */

/* alt-tab configuration */
static const unsigned int tabModKey 		= 0x40;	/* if this key is hold the alt-tab functionality stays acitve. This key must be the same as key that is used to active functin altTabStart `*/
static const unsigned int tabCycleKey 		= 0x17;	/* if this key is hit the alt-tab program moves one position forward in clients stack. This key must be the same as key that is used to active functin altTabStart */
static const unsigned int tabPosY 			= -10;	/* tab position on Y axis, 0 = bottom, 1 = center, 2 = top */
static const unsigned int tabPosX 			= -10;	/* tab position on X axis, 0 = left, 1 = center, 2 = right */
static const unsigned int maxWTab 			= 1;	/* tab menu width */
static const unsigned int maxHTab 			= 1;	/* tab menu height */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 10;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "Hack Nerd Font:size=12" };
static const char dmenufont[]       = "Hack Nerd Font:size=12";
static const char col_gray1[]       = "#282828"; //"#282a36"; // Darker Gray for accents
static const char col_gray2[]       = "#504945"; //"#44475a"; // Dark Gray for unselected stuff
static const char col_gray3[]       = "#ebdbb2"; //"#bbbbbb"; // Light Gray for text
static const char col_gray4[]       = "#282828"; //"#f8f8f2"; // Lighter Gray for text
static const char col_cyan[]        = "#b16286"; //"#bd93f9"; // Purple for accents
static const char *colors[][3]      = {
	/*              		fg         bg         border   */
	[SchemeNorm] 		= { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  		= { col_gray4, col_cyan,  col_cyan  },
	[SchemeStatus]  	= { col_gray3, col_gray1, "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel] 	= { col_gray4, col_cyan,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
   	[SchemeTagsNorm]	= { col_gray3, col_gray1, "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
   	[SchemeInfoSel]  	= { col_gray3, col_gray1, "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
   	[SchemeInfoNorm]  	= { col_gray3, col_gray1, "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

/* tagging */
static const char *tags[] = { "一", "二", "三", "四", "五" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",       NULL,       NULL,       0,              1,          -1 },
	{ "firefox",    NULL,       NULL,       1,              0,          -1 },
   	{ "Thunar",     NULL,       NULL,       1 << 4,         0,          -1 },
   	{ "Steam",      "Steam",    "Steam",    1 << 3,         0,          -1 },
    { "Steam",      "Steam",    "Friends List",    1 << 3,  1,          -1 },
    { "discord",    NULL,       NULL,      1 << 2,          0,          -1 }
};

/* layout(s) */
static const float mfact     	= 0.5;  //0.525; /* factor of master area size [0.05..0.95] */
static const int nmaster     	= 1;    /* number of clients in master area */
static const int resizehints 	= 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]",       tile },    /* tiling  default */
	{ "<>",       NULL },    /* floating behavior */
	{ "()",       monocle }, /* maximized */
};

/* key definitions */
#define MODKEY Mod4Mask // Mod1Mask = Alt
#define TAGKEYS(CHAIN,KEY,TAG) \
	{ MODKEY,                       CHAIN,    KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           CHAIN,    KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             CHAIN,    KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, CHAIN,    KEY,      toggletag,      {.ui = 1 << TAG} },
 
	/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
//static const char *roficmd[] = {"rofi","-show", "run","-show-icons", NULL};
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] 	    = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  	    = { "alacritty", NULL };
static const char *slock[] 	        = { "slock", NULL };
static const char *screenshot[]     = { "flameshot", "screen" , "-p", "Pictures", NULL};
static const char *screenshot2[]    = { "flameshot", "gui", "-c","-p", "Pictures", NULL};
static const char *ranger[]         = { "alacritty", "-e", "ranger", NULL };
static const char *osu[]	        = { "pgame", "/Desktop/osu.AppImage", NULL };
static const char *steam[]	        = { "steam", NULL };
static const char *discord[]        = { "discord", NULL };

static Key keys[] = {
	/* Keys,            2nd key,    3rd key             function        argument */
	{ MODKEY,               -1,     XK_r,			spawn,          {.v = dmenucmd } },
	{ MODKEY,               -1,     XK_t,			spawn,          {.v = termcmd } },
	{ MODKEY,               -1,     XK_o,			spawn,          {.v = osu } },
	{ MODKEY,               -1,     XK_e,			spawn,          {.v = ranger } },
	{ MODKEY,               -1,     XK_l,			spawn,          {.v = slock } },
	{ MODKEY,               -1,     XK_p,			spawn,          {.v = screenshot } },
	{ MODKEY,               -1,     XK_z,	        spawn,          {.v = screenshot2 } },
	{ MODKEY,               -1,     XK_w,			spawn,          {.v = &rules[1] } },
	{ MODKEY,               -1,     XK_s,			spawn,          {.v = steam } },
	{ MODKEY,               -1,     XK_d,			spawn,          {.v = discord } },
	{ MODKEY,               -1,     XK_b,			togglebar,      {0} },
	//{ MODKEY,             -1,     XK_i,			incnmaster,     {.i = +1 } },
	//{ MODKEY,             -1,     XK_d,			incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,     -1,     XK_Left,		setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,     -1,     XK_Right,		setmfact,       {.f = +0.05} },
	{ MODKEY,               -1,     XK_Return,		zoom,           {0} },
	{ Mod1Mask,             -1,	    XK_Tab,			altTabStart,	{0} },
	//{ MODKEY,               XK_Tab,     XK_Tab,			view,           {0} }, // Returns to last visited tag
	{ MODKEY,               -1,     XK_Tab,			shiftview,      {.i = +1} },
	{ MODKEY,               -1,     XK_Right,		shiftview,      {.i = +1} },
	{ MODKEY,               -1,     XK_Left,		shiftview,      {.i = -1} },
	{ MODKEY,               -1,     XK_q,			killclient,     {0} },
	{ MODKEY,               -1,     XK_bracketleft, setlayout,      {.v = &layouts[0]} }, // Tiled
	{ MODKEY,               -1,     XK_bracketright,setlayout,      {.v = &layouts[1]} }, // Floating
	{ MODKEY,               -1,     XK_backslash,	setlayout,      {.v = &layouts[2]} }, // Fullscreen stacked
	{ MODKEY|ShiftMask,     -1,     XK_bracketright,togglefloating, {0} },
	{ MODKEY,               -1,     XK_0,			view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,     -1,     XK_0,			tag,            {.ui = ~0 } },
	{ MODKEY,               -1,     XK_comma,		focusmon,       {.i = -1 } },
	{ MODKEY,               -1,     XK_period,		focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,     -1,     XK_comma,		tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,     -1,     XK_period,	    tagmon,         {.i = +1 } },
	{ MODKEY,               -1,     XK_minus,  		setgaps,        {.i = -1 } },
	{ MODKEY,               -1,     XK_equal,  		setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,     -1,     XK_equal,  	    setgaps,        {.i = 0  } },
 	TAGKEYS(                -1,     XK_1,                               0)
 	TAGKEYS(                -1,     XK_2,                               1)
 	TAGKEYS(                -1,     XK_3,                               2)
 	TAGKEYS(                -1,     XK_4,                               3)
 	TAGKEYS(                -1,     XK_5,                               4)
 	//TAGKEYS(              -1      XK_6,                               5)
 	//TAGKEYS(              -1      XK_7,                               6)
    //TAGKEYS(              -1      XK_8,                               7)
 	//TAGKEYS(              -1      XK_9,                               8)
	{ MODKEY,               XK_d,   XK_q,			quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

