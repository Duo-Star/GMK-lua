require "import"
import "android.widget.*"
import "android.view.*"


--新增一行:next_line()



local AlertDialog = luajava.bindClass "androidx.appcompat.app.AlertDialog"
local AppCompatButton = luajava.bindClass "androidx.appcompat.widget.AppCompatButton"
local Materializer = {}
Materializer.ColorStateList = luajava.bindClass "android.content.res.ColorStateList"
Materializer.RippleDrawable = luajava.bindClass "android.graphics.drawable.RippleDrawable"
Materializer.GradientDrawable = luajava.bindClass "android.graphics.drawable.GradientDrawable"
Materializer.TypedValue = luajava.bindClass "android.util.TypedValue"
function Dialog(title,message)
  function Materializer.getColorSurface()
    local typedValue = Materializer.TypedValue()
    activity.getTheme().resolveAttribute(android.R.attr.colorBackground, typedValue, true);
    return typedValue.data;
  end
  function Materializer.blendARGB(color1, color2, ratio)
    local inverseRatio = 1 - ratio
    local components = {}
    for shift = 24, 0, -8 do
      local component1 = (color1 >> shift) & 255
      local component2 = (color2 >> shift) & 255
      local component = tointeger((component1 * inverseRatio) + (component2 * ratio))
      components[#components + 1] = (component & 255) << shift
    end
    return components[1] + components[2] + components[3] + components[4]
  end
  function Materializer.Dialog(dialog, colorAccent)
    local colorSurface = Materializer.getColorSurface()
    -- 叠加颜色
    local colorAccentInverse = Materializer.blendARGB(colorAccent, colorSurface, 0.56)
    local colorSurfaceInverse = Materializer.blendARGB(colorSurface, colorAccent, 0.08)

    -- 修改标题大小
    dialog.findViewById(R.id.alertTitle).setTextSize(24)

    -- 修改Button文字颜色
    local neuBtn = dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(colorAccent)
    local posiBtn = dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(colorAccent)
    local negaBtn = dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(colorAccent)

    pcall(function()
      -- 修改Button波纹颜色及样式
      local RippleUtils = luajava.bindClass "com.google.android.material.ripple.RippleUtils"
      local ShapeAppearanceModel = luajava.bindClass "com.google.android.material.shape.ShapeAppearanceModel"()
      neuBtn.setShapeAppearanceModel(ShapeAppearanceModel.withCornerSize(48)).getBackground().setColor(RippleUtils.sanitizeRippleDrawableColor(Materializer.ColorStateList.valueOf(colorAccentInverse)))
      posiBtn.setShapeAppearanceModel(ShapeAppearanceModel.withCornerSize(48)).getBackground().setColor(RippleUtils.sanitizeRippleDrawableColor(Materializer.ColorStateList.valueOf(colorAccentInverse)))
      negaBtn.setShapeAppearanceModel(ShapeAppearanceModel.withCornerSize(48)).getBackground().setColor(RippleUtils.sanitizeRippleDrawableColor(Materializer.ColorStateList.valueOf(colorAccentInverse)))
    end)

    -- 修改dialog宽度
    local outMetrics = luajava.bindClass "android.util.DisplayMetrics"();
    activity.getSystemService(luajava.bindClass "android.content.Context".WINDOW_SERVICE).getDefaultDisplay().getMetrics(outMetrics);
    local layoutParams = dialog.Window.Attributes;
    layoutParams.width = (outMetrics.widthPixels * 0.8);

    dialog.getWindow()
    .setBackgroundDrawable(
    Materializer.GradientDrawable()
    .setShape(Materializer.GradientDrawable.RECTANGLE)
    .setColor(colorSurfaceInverse)
    -- 设置32dp的圆角
    .setCornerRadius(Materializer.TypedValue.applyDimension(1,10,activity.getResources().getDisplayMetrics()))
    )
    .setElevation(16)
    .setDimAmount(0.3)
    .setAttributes(layoutParams)

    -- 用ObjectAnimator拼个动画
    local ObjectAnimator = luajava.bindClass "android.animation.ObjectAnimator"
    local Anim = luajava.bindClass "android.animation.AnimatorSet"()
    local X=ObjectAnimator.ofFloat(dialog.window.decorView, "scaleX", {0.8, 1})
    local Y=ObjectAnimator.ofFloat(dialog.window.decorView, "scaleY", {0.8, 1})
    local A=ObjectAnimator.ofFloat(dialog.window.decorView, "alpha", {0, 1})
    Anim.play(A).with(X).with(Y)
    Anim.setDuration(250)
    .setInterpolator(luajava.bindClass"android.view.animation.DecelerateInterpolator"())
    .start()

    return dialog
  end

  function Materializer.Button(btn, colorAccent)
    local colorSurface = Materializer.getColorSurface()
    local colorOnSurface = Materializer.blendARGB(colorSurface, colorAccent, 0.08)
    local colorRipple = Materializer.blendARGB(colorAccent, colorSurface, 0.56)

    -- 设置波纹
    local rippleDrawable =
    Materializer.RippleDrawable(Materializer.ColorStateList({{android.R.attr.state_pressed, android.R.attr.state_hovered},{}},{colorRipple, colorRipple}),
    Materializer.GradientDrawable().setShape(Materializer.GradientDrawable.RECTANGLE)
    .setColor(colorAccent)
    -- 设置32dp的圆角
    .setCornerRadius(Materializer.TypedValue.applyDimension(1,20,activity.getResources().getDisplayMetrics())),
    nil);

    btn.setBackground(rippleDrawable)
    .setTextColor(colorOnSurface)
    -- 移除阴影
    .setElevation(0)
    -- 移除press状态的阴影
    .setStateListAnimator(nil)
    -- 禁用文本转换器
    .setAllCaps(false)
    return btn
  end

  function Materializer.TextButton(btn, colorAccent)
    local colorSurface = Materializer.getColorSurface()
    local colorRipple = Materializer.blendARGB(colorSurface, colorAccent, 0.36)

    -- 设置波纹
    local rippleDrawable =
    Materializer.RippleDrawable(Materializer.ColorStateList({{android.R.attr.state_pressed, android.R.attr.state_hovered},{}},{colorRipple, colorRipple}),
    Materializer.GradientDrawable()
    .setShape(Materializer.GradientDrawable.RECTANGLE)
    .setColor(colorSurface)
    -- 设置32dp的圆角
    .setCornerRadius(Materializer.TypedValue.applyDimension(1,32,activity.getResources().getDisplayMetrics())),
    nil);

    btn.setBackground(rippleDrawable)
    .setTextColor(colorAccent)
    -- 移除阴影
    .setElevation(0)
    -- 移除press状态的阴影
    .setStateListAnimator(nil)
    -- 禁用文本转换器
    .setAllCaps(false)
    return btn
  end
  local Dialog = AlertDialog.Builder(activity)
  .setTitle(title)
  .setMessage(message)
  .setPositiveButton("确定",nil)
  .setNegativeButton("取消",nil)
  .setNeutralButton("中立",nil);
  Materializer.Dialog( Dialog.show(), 0xff7E57C2)
end





