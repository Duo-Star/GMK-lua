SeaDivider=class{
  extends=SurfaceView,
  fields={
    ox={},
    oy={},
    mPadding={},
    P={},
    alpha=1,
    Lambda=1,
    hasUpdateListener=false,
    waveColor=0xFF09658E,
    backgroundColor=0xFFD0E4F8,
    wavePadding=20,
    waveHight=.05,
    waveSpeed=0,
    waveDensity=10,

  },
  init=function(view)
    local padding
    if Build.VERSION.SDK_INT>=17 then
      local all=view.getPaddingLeft()+view.getPaddingRight()+view.getPaddingBottom()+view.getPaddingTop()+view.getPaddingEnd()+view.getPaddingStart()
      padding=all/6
     else
      padding=(view.getPaddingLeft()+view.getPaddingRight()+view.getPaddingBottom()+view.getPaddingTop())/4
    end
    view.setPadding(padding)
    view.post(function()
      local w,h=view.width,view.height
      local smallerDim=w>h and h or w
      local largestCenteredSquareLeft=(w-smallerDim)/2
      local largestCenteredSquareTop=(h-smallerDim)/2
      local largestCenteredSquareRight=largestCenteredSquareLeft+smallerDim
      local largestCenteredSquareBottom=largestCenteredSquareTop+smallerDim
      view.ox=largestCenteredSquareRight/2+(w-largestCenteredSquareRight)/2
      view.oy=largestCenteredSquareBottom/2+(h-largestCenteredSquareBottom)/2
    end)
    local animation = ValueAnimator.ofFloat({ 0,2*math.pi })
    animation.setDuration(1145.14)
    animation.setRepeatCount(-1)
    animation.setRepeatMode(1)
    animation.setInterpolator(TimeInterpolator({
      getInterpolation=function(a)
        return 1-a
      end
    }))
    animation.start()
    view.hasUpdateListener=false
    local holder = view.getHolder()
    holder.addCallback(SurfaceHolder.Callback {
      surfaceChanged = function(holder, format, width, height)
        if animation.isPaused()
          animation.start()
        end
      end,
      surfaceCreated = function(holder)
        if not(hasUpdateListener)
          hasUpdateListener=true
          animation.addUpdateListener(ValueAnimator.AnimatorUpdateListener {
            onAnimationUpdate = function(animate)
              local k = animation.getAnimatedValue()
              local canvas
              canvas = holder.lockCanvas()
              if canvas ~= nil then
                view.P={}
                view.P.tail = Paint() .setColor(view.waveColor) .setStyle(Paint.Style.FILL) .setStrokeWidth(10) .setAntiAlias(true) .setStrokeCap(Paint.Cap.ROUND)
                local w,h=view.width,view.height
                local smallerDim=w>h and h or w
                local largestCenteredSquareLeft=(w-smallerDim)/2
                local largestCenteredSquareTop=(h-smallerDim)/2
                local largestCenteredSquareRight=largestCenteredSquareLeft+smallerDim
                local largestCenteredSquareBottom=largestCenteredSquareTop+smallerDim
                view.ox=largestCenteredSquareRight/2+(w-largestCenteredSquareRight)/2
                view.oy=largestCenteredSquareBottom/2+(h-largestCenteredSquareBottom)/2
                canvas.drawColor(view.backgroundColor)
                local ox=view.ox
                local oy=view.oy
                local P=view.P
                local paint = view.P.p
                local Lambda=view.Lambda
                local w=view.width
                local padding_=view.wavePadding
                local function line_(x0,y0,x1,y1,p)
                  local p=p or paint
                  canvas.drawLine(x0*Lambda*100+ox,-y0*Lambda*100+oy,x1*Lambda*100+ox,-y1*Lambda*100+oy, p)
                end
                local function fun_(f,x0,x1,p)
                  local p=p or paint
                  local x0=(x0)/(Lambda*100)
                  local x1=(x1-ox)/(Lambda*100)
                  local dx=0.0456789*(1/Lambda)
                  local p0={x0,f(x0)}
                  local p1=p0
                  for x=x0,x1,dx do
                    local y=f(x)
                    p1={x,y}
                    line_(p0[1],p0[2],p1[1],p1[2],p)
                    p0=p1
                  end
                end
                fun_(function(x)
                  return view.waveHight*math.sin(view.waveDensity*x+view.waveSpeed*k)
                end, view.wavePadding-ox,
                1*w-view.wavePadding,P.tail)
              end
              holder.unlockCanvasAndPost(canvas)
            end
          })
        end
      end,
      surfaceDestroyed = function(holder)
        animation.pause()
      end
    })
    view.onTouch=function(_,event)
      local v = event.getAction()
      return true
    end
  end,
  methods={
    setPadding=function(view,padding)
      view.mPadding=padding
      return view
    end,
    setBackgroundColor=function(view,c)
      view.backgroundColor=c
      return view
    end,
    setWaveColor=function(view,c)
      view.waveColor=c
      return view
    end,
    setWavePadding=function(view,p)
      view.wavePadding=p
      return view
    end,
    setWaveHight=function(view,h)
      view.waveHight=h
      return view
    end,
    setWaveSpeed=function(view,s)
      view.waveSpeed=s
      return view
    end,
    setWaveDensity=function(view,d)
      view.waveDensity=d
      return view
    end,



    --[[
  wavePadding=20,
    waveHight=.05,
    waveSpeed=0,
    waveDensity=10,
    --]]


  },
}
return SeaDivider