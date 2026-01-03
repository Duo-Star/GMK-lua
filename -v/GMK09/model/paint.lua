require "import"
local Paint = luajava.bindClass "android.graphics.Paint"

--初始化一些笔
paint = Paint().setColor(0xee5E35B1).setStyle(Paint.Style.STROKE).setStrokeWidth(10).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
.setTextAlign(Paint.Align.LEFT).setTextSize(40)
paintOut= Paint().setColor(0xFFF6F1ED).setStrokeWidth(10).setStyle(Paint.Style.STROKE).setShadowLayer(30,0,0,0xFFF5EEE2)
paintOut2= Paint().setColor(0xFFAE4839).setStrokeWidth(10).setStyle(Paint.Style.STROKE).setShadowLayer(30,0,0,0xFFAE4839)
paintWeb = Paint().setColor(0xFFF6F1ED).setStrokeWidth(10)
paintFill= Paint().setColor(0xFFF6F1ED).setStrokeWidth(5).setStyle(Paint.Style.FILL).setShadowLayer(30,0,0,0xFFF5EEE2)
paintControl= Paint().setColor(0xFF5E4B3C).setStrokeWidth(8).setStyle(Paint.Style.STROKE)
paintText = Paint().setColor(0xFF131313).setAntiAlias(true).setTextAlign(Paint.Align.LEFT).setTextSize(40).setStrokeCap(Paint.Cap.ROUND).setStyle(Paint.Style.FILL).setStrokeWidth(3)
paintTreasure_1=Paint().setColor(0xFFFCF4C9).setStrokeWidth(10).setStyle(Paint.Style.STROKE).setShadowLayer(30,0,0,0xFFF5EEE2)
paintTreasure_2=Paint().setColor(0xFFCBBC89).setStrokeWidth(10).setStyle(Paint.Style.FILL).setShadowLayer(30,0,0,0xFFF5EEE2)
paintTreasure_T = Paint().setColor(0xFFF6F1ED).setAntiAlias(true).setTextAlign(Paint.Align.LEFT).setTextSize(35).setStrokeCap(Paint.Cap.ROUND).setStyle(Paint.Style.FILL).setStrokeWidth(3)
paintTreasure_3=Paint().setColor(0xFF6AA03B).setStrokeWidth(10).setStyle(Paint.Style.STROKE).setShadowLayer(30,0,0,0xFFF5EEE2)
paint坐标轴=Paint().setColor(0xAA252525).setStyle(Paint.Style.STROKE).setStrokeWidth(4).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
paint_Red=Paint().setColor(0xFFE60721).setStyle(Paint.Style.STROKE).setStrokeWidth(5).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
paint_Blue=Paint().setColor(0xFF0066C7).setStyle(Paint.Style.STROKE).setStrokeWidth(10).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
paint_Green=Paint().setColor(0xFF007F24).setStyle(Paint.Style.STROKE).setStrokeWidth(8).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
paint_Black=Paint().setColor(0xFF252525).setStyle(Paint.Style.STROKE).setStrokeWidth(5).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)



function newPaint_Color_ARGB(a,r,g,b)
  return Paint().setARGB(a,r,g,b).setStyle(Paint.Style.FILL)
end

paint_Wide={
  Red=Paint().setColor(0xFFE60721).setStyle(Paint.Style.STROKE).setStrokeWidth(8).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND),
  Blue=Paint().setColor(0xFF0066C7).setStyle(Paint.Style.STROKE).setStrokeWidth(8).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND),
  Green=Paint().setColor(0xFF007F24).setStyle(Paint.Style.STROKE).setStrokeWidth(8).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND),
  Black=Paint().setColor(0xFF252525).setStyle(Paint.Style.STROKE).setStrokeWidth(8).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND),
}