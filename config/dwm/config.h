#include <X11/XF86keysym.h>

/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 4; /* border pixel of windows */
static const unsigned int snap = 32;    /* snap pixel */
static const int showbar = 1;           /* 0 means no bar */
static const int topbar = 1;            /* 0 means bottom bar */
static const int focusonwheel = 0;
static const char *fonts[] = {"JetBrainsMono Nerd Font:size=20",
                              "monospace:size=20"};
static const char dmenufont[] = "JetBrainsMono Nerd Font:size=20";

/* gruvbox */
// static const char color_fg[] = "#fbf7c1";
// static const char color_fg_primary[] = "#fbf7c1";
// static const char color_bg[] = "#282828";
// static const char color_primary[] = "#d65d0e";

/* catpuccin */
static const char color_fg[] = "#cdd6f4";
static const char color_fg_primary[] = "#1e1e2e";
static const char color_bg[] = "#1e1e2e";
static const char color_primary[] = "#cba6f7";

static const char *colors[][3] = {
    /*               fg          bg          border      */
    [SchemeNorm] = {color_fg, color_bg, color_primary},
    [SchemeSel] = {color_fg_primary, color_primary, color_primary},
};

/* tagging */
static const char *tags[] = {"", "󰖟", "", "4", "5"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    {NULL, NULL, NULL, 0, 0, -1},
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    1; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */
static const int refreshrate =
    120; /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"dmenu_run", "-i",      "-m",  dmenumon,
                                 "-fn",       dmenufont, "-nb", color_bg,
                                 "-nf",       color_fg,  "-sb", color_primary,
                                 "-sf",       color_fg,  NULL};
static const char *termcmd[] = {"alacritty", NULL};

static const Key keys[] = {
    /* modifier                     key        function        argument */
    {Mod1Mask, XK_space, spawn, {.v = dmenucmd}},
    {Mod1Mask | ShiftMask, XK_Return, spawn, {.v = termcmd}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_Return, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY | ShiftMask, XK_c, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_p, setlayout, {0}},
    {MODKEY | ShiftMask, XK_p, togglefloating, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5){MODKEY | ShiftMask, XK_q, quit, {0}},

    {0,
     XF86XK_AudioRaiseVolume,
     spawn,
     {.v = (const char *[]){"wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@",
                            "5%+", NULL}}},
    {0,
     XF86XK_AudioLowerVolume,
     spawn,
     {.v = (const char *[]){"wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@",
                            "5%-", NULL}}},
    {0,
     XF86XK_AudioMute,
     spawn,
     {.v = (const char *[]){"wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@",
                            "toggle", NULL}}},
    {0,
     XF86XK_AudioPlay,
     spawn,
     {.v = (const char *[]){"playerctl", "play-pause", NULL}}},
    {0,
     XF86XK_AudioPause,
     spawn,
     {.v = (const char *[]){"playerctl", "play-pause", NULL}}},
    {0,
     XF86XK_AudioNext,
     spawn,
     {.v = (const char *[]){"playerctl", "next", NULL}}},
    {0,
     XF86XK_AudioPrev,
     spawn,
     {.v = (const char *[]){"playerctl", "previous", NULL}}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function argument */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
