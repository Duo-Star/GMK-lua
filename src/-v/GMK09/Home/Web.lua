require "model.util"

local sharedData=import "model.SharedData"
local web_ToDo=sharedData.web_ToDo
local web_Context=sharedData.web_Context


import "android.graphics.Typeface"
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main
jost_book_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_book.ttf") --设置字体路径，page/main
jost_medium_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_medium.ttf") --设置字体路径，page/main


layout={
  LinearLayout;
  layout_width='fill';
  layout_height='fill';
  {
    LuaWebView;
    layout_width='fill';
    layout_height='fill';
    id='webView';
  };
  {
    TextView,
    id="txt",
    textSize="15dp",
    Typeface=jost_book_typeface,
  }
}
activity.setContentView(loadlayout(layout))

mimeType="text/html"
enCoding="utf-8"
webView.getSettings().setJavaScriptEnabled(true);
webView.setLayerType(View.LAYER_TYPE_HARDWARE,nil);
webView.getSettings().setSupportZoom(true);

if web_ToDo=="url" then
  webView.loadUrl(web_Context)
 elseif web_ToDo=="html" then
  webView.loadDataWithBaseURL(nil,web_Context or "¿",mimeType,enCoding,nil)
 elseif web_ToDo=="txt" then
  webView.setVisibility(View.GONE)
  txt.text=web_Context
end

--]]