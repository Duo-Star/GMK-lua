--以下是实现❤️❤️❤️引导栏
circularProgressDrawable.setStrokeWidth(dp2px(3.5)).setStrokeCap(Paint.Cap.ROUND)
.setColorFilter(PorterDuffColorFilter(ui.引导栏进度条颜色,PorterDuff.Mode.SRC_ATOP))

circularProgressDrawable.setStartEndTrim(0.75,0.75+0.3)
guide_card_progress_var=0
guide_card_progress_var_now=0
guide_card_set=function(pro,str)--向引导栏上设置内容
  if pro==0 guide_card_progress.setVisibility(8)
   else guide_card_progress.setVisibility(View.VISIBLE)
  end
  guide_card_appear()
  guide_card_progress_var=pro
  guide_card_text.text=str
end
guide_card_anim = ObjectAnimator.ofFloat(guide_card, "alpha", {1, 1, 1, 1, 0}).setDuration( 500).setRepeatCount(0)
guide_card_dismiss=function(t)
  guide_card_anim = ObjectAnimator.ofFloat(guide_card, "alpha", {1, 1, 1, 1, 0}).setDuration(t or 500).setRepeatCount(0)
  guide_card_anim.start()
end
guide_card_appear=function(t)
  if guide_card_anim.isRunning() guide_card_anim.pause() end
  guide_card.setAlpha(1)
end
guide_card.setAlpha(0)
--❤️❤️❤️❤️❤️❤️

