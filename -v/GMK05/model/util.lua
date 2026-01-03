require "import"
import {
"com.google.android.material.animation.*",
"com.google.android.material.appbar.*",
"com.google.android.material.badge.*",
"com.google.android.material.behavior.*",
"com.google.android.material.bottomappbar.*",
"com.google.android.material.bottomnavigation.*",
"com.google.android.material.bottomsheet.*",
"com.google.android.material.button.*",
"com.google.android.material.canvas.*",
"com.google.android.material.card.*",
"com.google.android.material.checkbox.*",
"com.google.android.material.chip.*",
"com.google.android.material.circularreveal.*",
"com.google.android.material.color.*",
"com.google.android.material.datepicker.*",
"com.google.android.material.dialog.*",
"com.google.android.material.divider.*",
"com.google.android.material.drawable.*",
"com.google.android.material.elevation.*",
"com.google.android.material.expandable.*",
"com.google.android.material.floatingactionbutton.*",
"com.google.android.material.imageview.*",
"com.google.android.material.internal.*",
"com.google.android.material.materialswitch.*",
"com.google.android.material.math.*",
"com.google.android.material.motion.*",
"com.google.android.material.navigation.*",
"com.google.android.material.navigationrail.*",
"com.google.android.material.progressindicator.*",
"com.google.android.material.radiobutton.*",
"com.google.android.material.resources.*",
"com.google.android.material.ripple.*",
"com.google.android.material.shadow.*",
"com.google.android.material.shape.*",
"com.google.android.material.slider.*",
"com.google.android.material.snackbar.*",
"com.google.android.material.stateful.*",
"com.google.android.material.switchmaterial.*",
"com.google.android.material.tabs.*",
"com.google.android.material.textfield.*",
"com.google.android.material.textview.*",
"com.google.android.material.theme.*",
"com.google.android.material.timepicker.*",
"com.google.android.material.tooltip.*",
"com.google.android.material.transformation.*",
"com.google.android.material.transition.*",

}
cjson=require "cjson"
import {
"android.app.*",
"android.os.*",
"android.widget.*",
"android.view.*",
"android.graphics.*",
"android.net.*",
"android.content.*",
"android.graphics.drawable.*",
"android.animation.*",
"android.util.TypedValue",
"java.io.*",
"java.lang.*",
"java.nio.charset.*",
"androidx.core.app.*",
"androidx.appcompat.app.*",
"android.provider.*",
"android.content.res.ColorStateList",
"androidx.core.widget.NestedScrollView",
"androidx.coordinatorlayout.widget.CoordinatorLayout",
"androidx.viewpager.widget.ViewPager",
"androidx.swiperefreshlayout.widget.SwipeRefreshLayout",
"androidx.appcompat.widget.*",
"androidx.recyclerview.widget.*",
"androidx.constraintlayout.motion.widget.MotionLayout$DecelerateInterpolator",
"github.daisukiKaffuChino.*",
"github.daisukiKaffuChino.utils.LuaThemeUtil",
"android.view.animation.*",
"android.animation.*",
"androidx.vectordrawable.graphics.drawable.*",
"android.webkit.WebView",
"androidx.appcompat.widget.LinearLayoutCompat",
"androidx.drawerlayout.widget.DrawerLayout",


}


R=import "com.google.android.material.R"








--全局属性封装
aa={a={}}


--字体
aa.a.b1=R.attr.textAppearanceBody1
aa.a.b2=R.attr.textAppearanceBody2
aa.a.bl=R.attr.textAppearanceBodyLarge
aa.a.bm=R.attr.textAppearanceBodyMedium
aa.a.bs=R.attr.textAppearanceBodySmall
aa.a.b=R.attr.textAppearanceButton
aa.a.c=R.attr.textAppearanceCaption
aa.a.dl=R.attr.textAppearanceDisplayLarge
aa.a.dm=R.attr.textAppearanceDisplayMedium
aa.a.ds=R.attr.textAppearanceDisplaySmall
aa.a.h1=R.attr.textAppearanceHeadline1
aa.a.h2=R.attr.textAppearanceHeadline2
aa.a.h3=R.attr.textAppearanceHeadline3
aa.a.h4=R.attr.textAppearanceHeadline4
aa.a.h5=R.attr.textAppearanceHeadline5
aa.a.h6=R.attr.textAppearanceHeadline6
aa.a.hl=R.attr.textAppearanceHeadlineLarge
aa.a.hm=R.attr.textAppearanceHeadlineMedium
aa.a.hs=R.attr.textAppearanceHeadlineSmall
aa.a.ll=R.attr.textAppearanceLabelLarge
aa.a.lm=R.attr.textAppearanceLabelMedium
aa.a.ls=R.attr.textAppearanceLabelSmall
aa.a.lpm=R.attr.textAppearanceLargePopupMenu
aa.a.lhe=R.attr.textAppearanceLineHeightEnabled
aa.a.li=R.attr.textAppearanceListItem
aa.a.lise=R.attr.textAppearanceListItemSecondary
aa.a.lis=R.attr.textAppearanceListItemSmall
aa.a.o=R.attr.textAppearanceOverline
aa.a.pmh=R.attr.textAppearancePopupMenuHeader
aa.a.srs=R.attr.textAppearanceSearchResultSubtitle
aa.a.srt=R.attr.textAppearanceSearchResultTitle
aa.a.spm=R.attr.textAppearanceSmallPopupMenu
aa.a.s1=R.attr.textAppearanceSubtitle1
aa.a.s2=R.attr.textAppearanceSubtitle2
aa.a.tl=R.attr.textAppearanceTitleLarge
aa.a.tm=R.attr.textAppearanceTitleMedium
aa.a.ts=R.attr.textAppearanceTitleSmall
aa.a.ac=R.attr.textAllCaps

--card
aa.a.cves=R.attr.materialCardViewElevatedStyle
aa.a.cvfs=R.attr.materialCardViewFilledStyle
aa.a.cvos=R.attr.materialCardViewOutlinedStyle
aa.a.cvs=R.attr.materialCardViewStyle

--分界线
aa.a.dds=R.attr.materialDisplayDividerStyle
aa.a.dhs=R.attr.materialDividerHeavyStyle
aa.a.ds=R.attr.materialDividerStyle

--button
aa.a.bs=R.attr.materialButtonStyle
aa.a.bos=R.attr.materialButtonOutlinedStyle
aa.a.ibfs=R.attr.materialIconButtonFilledStyle
aa.a.ibfts=R.attr.materialIconButtonFilledTonalStyle
aa.a.ibos=R.attr.materialIconButtonOutlinedStyle
aa.a.ibs=R.attr.materialIconButtonStyle


--cc.c访问
DynamicColors.applyIfAvailable(this)

function isNightMode()
local configuration = activity.getResources().getConfiguration();
return configuration.uiMode+1==configuration.UI_MODE_NIGHT_YES or configuration.uiMode-1==configuration.UI_MODE_NIGHT_YES or configuration.uiMode==configuration.UI_MODE_NIGHT_YES
end
if isNightMode() then
night=true
else
night=false
end
--注意是系统

local themeUtil=LuaThemeUtil(this)
MDC_R=luajava.bindClass"com.google.android.material.R"
surfaceColor=themeUtil.getAnyColor(MDC_R.attr.colorSurface)
--更多颜色分类 请查阅Material.io官方文档
backgroundc=themeUtil.getAnyColor(android.R.attr.colorBackground)
surfaceVar=themeUtil.getAnyColor(MDC_R.attr. colorOnSurfaceInverse)
--[[titleColor=themeUtil.getTitleTextc()
primaryc=themeUtil.getPrimaryc()
primarycVar=themeUtil.getAnyColor(MDC_R.attr.colorPrimaryVariant)]]


local myColor_dark={
"m3_sys_color_dynamic_dark_background",
"m3_sys_color_dynamic_dark_inverse_on_surface",
"m3_sys_color_dynamic_dark_inverse_primary",
"m3_sys_color_dynamic_dark_inverse_surface",
"m3_sys_color_dynamic_dark_on_background",
"m3_sys_color_dynamic_dark_on_primary",
"m3_sys_color_dynamic_dark_on_primary_container",
"m3_sys_color_dynamic_dark_on_secondary",
"m3_sys_color_dynamic_dark_on_secondary_container",
"m3_sys_color_dynamic_dark_on_surface",
"m3_sys_color_dynamic_dark_on_surface_variant",
"m3_sys_color_dynamic_dark_on_tertiary",
"m3_sys_color_dynamic_dark_on_tertiary_container",
"m3_sys_color_dynamic_dark_outline",
"m3_sys_color_dynamic_dark_primary",
"m3_sys_color_dynamic_dark_primary_container",
"m3_sys_color_dynamic_dark_secondary",
"m3_sys_color_dynamic_dark_secondary_container",
"m3_sys_color_dynamic_dark_surface",
"m3_sys_color_dynamic_dark_surface_variant",
"m3_sys_color_dynamic_dark_tertiary",
"m3_sys_color_dynamic_dark_tertiary_container",
}

local myColor_light={"m3_sys_color_dynamic_light_background",
"m3_sys_color_dynamic_light_inverse_on_surface",
"m3_sys_color_dynamic_light_inverse_primary",
"m3_sys_color_dynamic_light_inverse_surface",
"m3_sys_color_dynamic_light_on_background",
"m3_sys_color_dynamic_light_on_primary",
"m3_sys_color_dynamic_light_on_primary_container",
"m3_sys_color_dynamic_light_on_secondary",
"m3_sys_color_dynamic_light_on_secondary_container",
"m3_sys_color_dynamic_light_on_surface",
"m3_sys_color_dynamic_light_on_surface_variant",
"m3_sys_color_dynamic_light_on_tertiary",
"m3_sys_color_dynamic_light_on_tertiary_container",
"m3_sys_color_dynamic_light_outline",
"m3_sys_color_dynamic_light_primary",
"m3_sys_color_dynamic_light_primary_container",
"m3_sys_color_dynamic_light_secondary",
"m3_sys_color_dynamic_light_secondary_container",
"m3_sys_color_dynamic_light_surface",
"m3_sys_color_dynamic_light_surface_variant",
"m3_sys_color_dynamic_light_tertiary",
"m3_sys_color_dynamic_light_tertiary_container",
}



错误色d={
"m3_sys_color_dark_error",
"m3_sys_color_dark_error_container",
"m3_sys_color_dark_on_error",
"m3_sys_color_dark_on_error_container",
}

错误色l={
"m3_sys_color_light_error",
"m3_sys_color_light_error_container",
"m3_sys_color_light_on_error",
"m3_sys_color_light_on_error_container",

}

cc={c={}}

if night then
for k,v in pairs(错误色d) do
_ENV["cc"][v:gsub("m3_sys_color_dark_","")]=_ENV["MDC_R"]["color"][v]
_ENV["cc"]["c"][v:gsub("m3_sys_color_dark_","")]=activity.getColor(_ENV["MDC_R"]["color"][v])
end
else
for k,v in pairs(错误色l) do
_ENV["cc"][v:gsub("m3_sys_color_light_","")]=_ENV["MDC_R"]["color"][v]
_ENV["cc"]["c"][v:gsub("m3_sys_color_light_","")]=activity.getColor(_ENV["MDC_R"]["color"][v])
end
end


if Build.VERSION.SDK_INT <31 then
-- 默认颜色
if night then
--错误色
for k,v in pairs(错误色d) do
_ENV["cc"][v:gsub("m3_sys_color_dark_","")]=_ENV["MDC_R"]["color"][v]
end

for k,v in pairs(myColor_dark) do
_ENV["cc"][v:gsub("m3_sys_color_dynamic_dark_","")]=_ENV["MDC_R"]["color"][v:gsub("dynamic_","")]

_ENV["cc"]["c"][v:gsub("m3_sys_color_dynamic_dark_","")]=activity.getColor(_ENV["MDC_R"]["color"][v:gsub("dynamic_","")])
end

else
for k,v in pairs(myColor_light) do
_ENV["cc"][v:gsub("m3_sys_color_dynamic_light_","")]=_ENV["MDC_R"]["color"][v:gsub("dynamic_","")]

_ENV["cc"]["c"][v:gsub("m3_sys_color_dynamic_light_","")]=activity.getColor(_ENV["MDC_R"]["color"][v:gsub("dynamic_","")])
end
end
else
-- 动态颜色
if night then
for k,v in pairs(myColor_dark) do
_ENV["cc"][v:gsub("m3_sys_color_dynamic_dark_","")]=_ENV["MDC_R"]["color"][v]

_ENV["cc"]["c"][v:gsub("m3_sys_color_dynamic_dark_","")]=activity.getColor(_ENV["MDC_R"]["color"][v])
end
else
for k,v in pairs(myColor_light) do
_ENV["cc"][v:gsub("m3_sys_color_dynamic_light_","")]=_ENV["MDC_R"]["color"][v]

_ENV["cc"]["c"][v:gsub("m3_sys_color_dynamic_light_","")]=activity.getColor(_ENV["MDC_R"]["color"][v])
end
end
end




typedValue = TypedValue()
activity.getTheme().resolveAttribute(android.R.attr.selectableItemBackground, typedValue, true)

--状态栏项目
local window = activity.getWindow()
window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
window.setStatusBarColor(backgroundc)
window.setNavigationBarColor(backgroundc)
if night then
window.getDecorView().setSystemUiVisibility( View.SYSTEM_UI_FLAG_LAYOUT_STABLE )--|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
else
window.getDecorView().setSystemUiVisibility( View.SYSTEM_UI_FLAG_LAYOUT_STABLE |View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
end





ColorUtils={}

ColorUtils.setAlphaComponent=function(color,alpha)
local alpha=tointeger(alpha)
if alpha >= 0 and alpha <=255 then
return (color & 0x00ffffff) | (tointeger(alpha) << 24)
end
end

local compositeAlpha=function(foregroundAlpha,backgroundAlpha)
return 0xFF - (((0xFF - backgroundAlpha) * (0xFF - foregroundAlpha)) / 0xFF)
end

local compositeComponent=function(fgC,fgA,bgC,bgA,a)
if (a == 0) then return 0 end
return ((0xFF * fgC * fgA) + (bgC * bgA * (0xFF - fgA))) / (a * 0xFF)
end

local alpha=function(color)
return tointeger(color) >> 24 & 255
end
local red=function(color)
return tointeger(color) >> 16 & 255
end
local green=function(color)
return tointeger(color) >> 8 & 255
end
local blue=function(color)
return tointeger(color) & 255
end
local argb=function(a, r, g, b)
return (tointeger(a) << 24) + (tointeger(r) << 16) + (tointeger(g) << 8) + tointeger(b)
end

ColorUtils.compositeColors=function(foreground,background)
local bgAlpha,fgAlpha,a,r,g,b

bgAlpha = alpha(background)
fgAlpha = alpha(foreground)
a = compositeAlpha(fgAlpha, bgAlpha)
r = compositeComponent(red(foreground), fgAlpha,
red(background), bgAlpha, a)
g = compositeComponent(green(foreground), fgAlpha,
green(background), bgAlpha, a)
b = compositeComponent(blue(foreground), fgAlpha,
blue(background), bgAlpha, a)
return argb(a, r, g, b)
end

local RGBToXYZ=function(r,g,b,outXyz)
local sr,sg,sb

sr = r / 255
sr = sr < 0.04045 and sr / 12.92 or Math.pow((sr + 0.055) / 1.055, 2.4)
sg = g / 255
sg = sg < 0.04045 and sg / 12.92 or Math.pow((sg + 0.055) / 1.055, 2.4)
sb = b / 255
sb = sb < 0.04045 and sb / 12.92 or Math.pow((sb + 0.055) / 1.055, 2.4)
--可以确定and后面一定为true所以偷懒了

outXyz[0] = 100 * (sr * 0.4124 + sg * 0.3576 + sb * 0.1805)
outXyz[1] = 100 * (sr * 0.2126 + sg * 0.7152 + sb * 0.0722)
outXyz[2] = 100 * (sr * 0.0193 + sg * 0.1192 + sb * 0.9505)
end

local colorToXYZ=function(color,outXyz)
RGBToXYZ(red(color), green(color), blue(color), outXyz)
end

ColorUtils.calculateLuminance=function(color)
local result = [3]
colorToXYZ(color, result)
-- 亮度是Y分量
return result[1] / 100
end

ColorUtils.blendARGB=function(color1,color2,ratio)
local inverseRatio,a,r,g,b

inverseRatio = 1 - ratio
a = alpha(color1) * inverseRatio + alpha(color2) * ratio
r = red(color1) * inverseRatio + red(color2) * ratio
g = green(color1) * inverseRatio + green(color2) * ratio
b = blue(color1) * inverseRatio + blue(color2) * ratio
return argb(a,r,g,b)
end





function 剪贴板()
local clipboardManager=activity.getSystemService(Context.CLIPBOARD_SERVICE)
if clipboardManager.hasPrimaryClip() then
content=clipboardManager.getPrimaryClip().getItemAt(0).getText()
return content
end
end


function 分享文字(内容)
import "android.content.Intent"
local intent=Intent(Intent.ACTION_SEND);
intent.setType("text/plain");
intent.putExtra(Intent.EXTRA_SUBJECT, "分享");
intent.putExtra(Intent.EXTRA_TEXT, tostring(内容));
intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
activity.startActivity(Intent.createChooser(intent,"分享到:"));
end

function 全屏()
if Build.VERSION.SDK_INT >= 21 then
window = activity.getWindow()
window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
window.setStatusBarColor(Color.TRANSPARENT);
window.addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
else
window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
end
end

function getJetres(s)
return activity.getLuaDir().."/JetLua/res/"..s
end

function 复制(text)
activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(text)
end

function getFileDrawable(file)
local fis = FileInputStream(activity.getLuaDir().."/res/"..file..".png")
local bitmap = BitmapFactory.decodeStream(fis)
return BitmapDrawable(activity.getResources(), bitmap)
end

function 导航栏高度()
local resourceId = 0;
local rid = activity.getResources().getIdentifier("config_showNavigationBar", "bool", "android");
if (rid ~= 0) then
resourceId = activity.getResources().getIdentifier("navigation_bar_height", "dimen", "android");
return activity.getResources().getDimensionPixelSize(resourceId);
else
return 0;
end
end

function 颜色渐变(id,color,...)
time=200
str="cardBackgroundColor"
if ...==nil then
elseif type(...)=="string" then
str=...
elseif type(...)=="number" then
time=...
end
ObjectAnimator.ofInt(id,str,color)
.setInterpolator(DecelerateInterpolator())--动画插值器
.setDuration(time)--动画时间
.setRepeatCount(0.5)--动画循环
.setRepeatMode(Animation.REVERSE)--循环模式
.setEvaluator(ArgbEvaluator())
.start()--动画开始
end

function 软件信息(pack)
import "android.net.Uri"
import "android.content.Intent"
import "android.provider.Settings"
local intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
intent.setData(Uri.parse("package:"..pack));
activity.startActivityForResult(intent, 100);
end

function GetAppInfo(包名)
import "android.content.pm.PackageManager"
local pm = activity.getPackageManager();
local 图标 = pm.getApplicationInfo(tostring(包名),0)
local 图标 = 图标.loadIcon(pm);
local pkg = activity.getPackageManager().getPackageInfo(包名, 0);
local 应用名称 = pkg.applicationInfo.loadLabel(activity.getPackageManager())
local 版本号 = activity.getPackageManager().getPackageInfo(包名, 0).versionName
local 版本= activity.getPackageManager().getPackageInfo(包名, 0).versionCode
local 最后更新时间 = activity.getPackageManager().getPackageInfo(包名, 0).lastUpdateTime
local cal = Calendar.getInstance();
cal.setTimeInMillis(最后更新时间);
local 最后更新时间 = cal.getTime().toLocaleString()
return 包名,版本号,最后更新时间,图标,应用名称,版本
end



function 写入文件(路径,内容)
import"java.io.File"
f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
io.open(tostring(路径),"w"):write(tostring(内容)):close()
end

function dp2px(n)
return n*activity.resources.displayMetrics.scaledDensity+.5
end

function shell(cmd,fun)
function shellfun(s)
fun(s)
end
thread(function(cmd,shellfun)
p=io.popen(string.format('%s',cmd))
s=p:read("*a")
p:close()
call("shellfun",s)
end,cmd,shellfun)
end


function customTabsActionButton(builder)
local Intent = import "android.content.Intent"
local PendingIntent = import "android.app.PendingIntent"
local BitmapFactory = import "android.graphics.BitmapFactory"
local loadbitmap = require "loadbitmap"
for i=1,3 do
local actionIntent = Intent(Intent.ACTION_VIEW)
local pi = PendingIntent.getActivity(activity.getApplicationContext(), 0, actionIntent, 0)
local path=activity.getLoader().getImagesDir("add")
builder.setActionButton(loadbitmap(path), "增加"..i.."个图标项目", pi, true)
end
end
function customTabsMenuItem(builder)
local Intent = import "android.content.Intent"
local PendingIntent = import "android.app.PendingIntent"
for i=1,3 do
local menuIntent = Intent(Intent.ACTION_VIEW)
local pi = PendingIntent.getActivity(activity.getApplicationContext(), 0, menuIntent, 0)
builder.addMenuItem("增加"..i.."个菜单项目", pi)
end
end
function customTabsColor(builder,color)
local CustomTabColorSchemeParams = import "androidx.browser.customtabs.CustomTabColorSchemeParams"
local Color = import "android.graphics.Color"
local defaultColors = CustomTabColorSchemeParams.Builder()
.setToolbarColor(Color.parseColor(color))
.build()
builder.setDefaultColorSchemeParams(defaultColors)
end
function openExtUrl(extURL)
local CustomTabsIntent = import "androidx.browser.customtabs.CustomTabsIntent"
local Uri = import "android.net.Uri"
builder=CustomTabsIntent.Builder()
--显示网站名称
builder.setShowTitle(true)
--添加图标按钮
--customTabsActionButton(builder)
--添加菜单按钮
-- customTabsMenuItem(builder)
--设置颜色
customTabsColor(builder,"#"..string.format("%#x",surfaceVar):sub(3,-1):gsub("^ffffffffff",""))
customTabsIntent=builder.build()
customTabsIntent.launchUrl(activity, Uri.parse(extURL))
end


function 状态栏高度()
if Build.VERSION.SDK_INT >= 19 then
resourceId = activity.getResources().getIdentifier("status_bar_height", "dimen", "android")
return activity.getResources().getDimensionPixelSize(resourceId)
else
return 0
end
end
function 波(id,lx,color)
xpcall(function()
ripple = activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
ripples = activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)
for index,content in ipairs(id) do
if lx=="圆" then
content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{color})))
end
if lx=="方" then
content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{color})))
end
end
end,function(e)end)
end

import "com.caverock.androidsvg.*"--svg

function loadsvgstr(str,颜色)
local tp颜色=颜色 or 0xff00000
local 读取=str
local svg=读取:gsub("颜色","#"..string.format("%#x",tp颜色):sub(3,-1):gsub("^ffffffffff",""))
--写文件
--io.open("/storage/emulated/0/360/a.svg","w"):write(svg):close()
return PictureDrawable(SVG.getFromString(svg).renderToPicture())
end


function loadsvg(str,颜色,模式a)
local 模式b=模式a or false

local tp颜色=颜色 or cc.c.primary
local 读取=io.open(activity.getLuaDir("res/"..str..".svg")):read("*a")
local svg=读取:gsub("颜色","#"..string.format("%#x",tp颜色):sub(3,-1):gsub("^ffffffffff",""))
if 模式b then
for c in string.gmatch(svg,"%d+px") do
nb=svg:gsub(c,tostring(dp2px(tonumber(c:match("%d+")))))
end
svg=nb
end
--写文件
--io.open("/storage/emulated/0/360/a.svg","w"):write(svg):close()
return PictureDrawable(SVG.getFromString(svg).renderToPicture())
end

pcall(function()
activity.setTheme(R.style.Theme_ReOpenLua_Material3)
end)
pcall(function()
activity.setTheme(R.style.AppTheme_Material3)
end)
activity.getSupportActionBar().hide()
夜间模式=AppCompatDelegate.getDefaultNightMode()


--异形屏横屏适配
pcall(function()
local lp = activity.getWindow().getAttributes();
lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
end)

--底部弹出提示
function newsb(...)
local mtable={...}
local num=select("#",...)
local snackBar=Snackbar.make(activity.getDecorView(),mtable[1],Snackbar.LENGTH_SHORT)
if num==1 then
return snackBar
elseif num==2 then
if type(mtable[2]) =="string" then
snackBar.setAction(mtable[2], View.OnClickListener{
onClick=function(v)
end
})
else
return Snackbar.make(mtable[2] or activity.getDecorView(),mtable[1],Snackbar.LENGTH_SHORT)
end
return snackBar
elseif num==3 then
snackBar.setAction(mtable[2], View.OnClickListener{
onClick=function(v)
mtable[3]()
end
})
return snackBar
elseif num==4 then
local snackBar=Snackbar.make(mtable[2],mtable[1],Snackbar.LENGTH_SHORT)
snackBar.setAction(mtable[3], View.OnClickListener{
onClick=function(v)
mtable[4]()
end
})
return snackBar
end
return snackBar
end


--Duo
import "com.google.android.material.color.DynamicColors"
DynamicColors.applyIfAvailable(this)
themeUtil=LuaThemeUtil(this)
MDC_R=luajava.bindClass"com.google.android.material.R"
surfaceColor=themeUtil.getColorSurface()
--更多颜色分类 请查阅Material.io官方文档
backgroundc=themeUtil.getColorBackground()
surfaceVar=themeUtil.getColorSurfaceVariant()
titleColor=themeUtil.getTitleTextColor()
primaryc=themeUtil.getColorPrimary()
primarycVar=themeUtil.getColorPrimaryVariant()


resources=activity.getResources()
function m3c(s)
value = resources.getColor(android.R.color[s])
return value
end

function dp2px(i)
return i*activity.resources.displayMetrics.scaledDensity+.5
end

function getFileDrawable(file)
fis = FileInputStream(activity.getLuaDir().."/res/"..file..".png")
bitmap = BitmapFactory.decodeStream(fis)
return BitmapDrawable(activity.getResources(), bitmap)
end


function saveData(key,str)--保存数据
local name="River"
local sp = activity.getSharedPreferences(name, Context.MODE_PRIVATE)
local sped = sp.edit().putString(key,str).commit()
end


function readData(key)--读取数据
local name="River"
local sp = activity.getSharedPreferences(name, Context.MODE_PRIVATE)
return sp.getString(key,"")
end


function isNightMode()
local config = activity.getResources().getConfiguration()
return config.uiMode & config.UI_MODE_NIGHT_MASK == config.UI_MODE_NIGHT_YES--夜间模式启用
end


Manifest = luajava.bindClass "android.Manifest"
function Permission(requirePermissions_)
function requestPermissions(permissions)
local ActivityCompat = luajava.bindClass "androidx.core.app.ActivityCompat"
return ActivityCompat.requestPermissions(activity, permissions, 10);
end
--示例
--要申请的权限列表，请写成常量以免自己写错
--所有的权限常量定义在Manifest的内部类permission里，写法如下
--以储存权限为例
local requirePermissions =requirePermissions_ or {
Manifest.permission.READ_EXTERNAL_STORAGE,
Manifest.permission.WRITE_EXTERNAL_STORAGE
}
--申请权限的回调在这里执行
onRequestPermissionsResult=function(requestCode, permissions, grantResults)
local PackageManager = luajava.bindClass "android.content.pm.PackageManager"
--判断是不是自己的权限申请，这里的10就是上面requestPermissions中写的10
if requestCode==10 then
local count = 0
for i=0,#permissions-1 do
if grantResults[i] == PackageManager.PERMISSION_GRANTED then
--print(permissions[i].."权限通过")
count = count + 1
else
--print(permissions[i].."权限拒绝")
end
end
--print("申请了"..#permissions.."个权限，通过了"..count.."个权限")
if count==#requirePermissions and readData("PermissionOK")=="" then
saveData("PermissionOK","T")
activity.recreate()
end
end
end

--发起请求
requestPermissions(requirePermissions)
--检查权限
function checkPermission(permission)
return 0==activity.checkSelfPermission(permission)
end
--单纯检查一下有没有指定权限
local flag = checkPermission(Manifest.permission.READ_EXTERNAL_STORAGE)
--print("READ_EXTERNAL_STORAGE检查结果"..tostring(flag))
return flag
end