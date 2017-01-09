isMobile = require('ismobilejs')
Point    = require('../libs/obj/Point')



# ---------------------------------------------------
# マウス位置
# ---------------------------------------------------
class Mouse


  constructor: ->

    @dist = new Point()
    @now = new Point()
    @start = new Point()

    @isDown = false

    @_onDown = []
    @_onUp = []
    @_onMove = []

    @_init()



  # ------------------------------------
  # 初期化
  # ------------------------------------
  _init: =>

    if isMobile.any
      $(window).on('touchmove', @_eMove).on('touchstart', @_eDown).on('touchend', @_eUp)
    else
      $(window).on('mousemove', @_eMove).on('mousedown', @_eDown).on('mouseup', @_eUp)



  # -----------------------------------
  # イベント 押した
  # -----------------------------------
  _eDown: (e) =>

    if @isDown
      return
    @isDown = true

    @start.copy(@_getMousePos(e))
    @now.copy(@_getMousePos(e))

    @_call(@_onDown, e)



  # -----------------------------------
  # イベント 離した
  # -----------------------------------
  _eUp: (e) =>

    if !@isDown
      return
    @isDown = false

    @_call(@_onUp, e)



  # -----------------------------------
  # イベント 動いた
  # -----------------------------------
  _eMove: (e) =>

    @now.copy(@_getMousePos(e))

    # 押してからの距離
    if @isDown
      @dist.x = @now.x - @start.x
      @dist.y = @now.y - @start.y

    @_call(@_onMove, e)



  # -----------------------------------
  # マウス位置取得
  # -----------------------------------
  _getMousePos: (e) =>

    p = new Point()

    if isMobile.any

      touches = e.touches
      if touches? && touches.length > 0
        p.x = touches[0].clientX
        p.y = touches[0].clientY

    else

      p.x = e.clientX
      p.y = e.clientY

    return p



  # -----------------------------------
  # コールバック登録
  # -----------------------------------
  addCallBack: (name, func) =>

    @['_' + name].push(func)



  # -----------------------------------------------
  # コールバック実行
  # -----------------------------------------------
  _call: (c, e) =>

    for val,i in c
      val(e)












module.exports = new Mouse()
