require "model.util"
local sharedData=import "model.SharedData"
local md=(sharedData.MD_md) or "none"
md=string.gsub(md,"\n","\\n".."\\n")

import "android.webkit.WebSettings"

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
}
activity.setContentView(loadlayout(layout))

if isNightMode()
  webView.getSettings().setForceDark(WebSettings.FORCE_DARK_ON)
end


webView.setWebViewClient{
  shouldOverrideUrlLoading=function(view,url)
    --Url即将跳转
    --print(url)
    local context=(tostring(url):match("doc:" .. "(.-)"..".md"))
    if context
      md=io.open(activity.getLuaDir().."/model/Doc/"..context..".md"):read("*a")
      md=string.gsub(md,"\n","\\n".."\\n")
      webView.reload()
    end
    local todo=(tostring(url):match("todo://" .. "(.+)"..""))
    if todo
      if todo=="back"
        webView.goBack()
       elseif todo=="reload"
        webView.reload()
       else

      end
      webView.stopLoading()
    end
    local code=(tostring(url):match("lua:" .. "(.-)"..".luaaa"))
    if code
      webView.stopLoading()
      subs={
        {".<","("},
        {".>",")"},
      }
      for n=1,#subs do
        code=string.gsub(code,subs[n][1],subs[n][2])
      end
      assert(loadstring(code))()
    end
  end,
  onPageStarted=function(view,url,favicon)
    --网页即将加载
  end,
  onPageFinished=function(view,url)
    --网页加载完成
    webView.evaluateJavascript("document.getElementById('preview').innerHTML = ''+ marked.parse('"..md.."');",nil)

  end,
  onReceivedError=function(view,code,des,url)
    --网页加载失败
    print("嘿嘿嘿")
  end
}

webView.loadUrl(activity.getLuaDir().."/model/MD/preview.html")

