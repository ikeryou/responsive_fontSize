dat      = require('dat-gui')
window.$ = require('jquery')
Mouse    = require('../core/Mouse')


class Top


  constructor: ->

    @_fontSize = {
      def:5
      val:5
      start:0
    }

    @_lineHeight = {
      def:1.5
      val:1.5
      start:0
    }

    @_letterSpacing = {
      def:0.05
      val:0.05
      start:0
    }

    @_nowParam = 0

    @_body   = $('body')
    @_text   = $('.text')
    @_slider = $('#slider')
    @_sliderBar = $('#slider .bar')

    @_downTime = 0



  # -----------------------------------------------
  # エントリーポイント
  # -----------------------------------------------
  init: =>

    @_updateFont()

    Mouse.addCallBack('onDown', @_eDown)
    Mouse.addCallBack('onUp', @_eUp)
    Mouse.addCallBack('onMove', @_eMove)
    @_eUp()

    $('#debug').click(=>
      if ++@_nowParam >= 3
        @_nowParam = 0
      $('.debug_update_text p').removeClass('is_selected')
      $('.debug_update_text p:eq(' + @_nowParam + ')').addClass('is_selected')
    )

    @_update()



  # -----------------------------------------------
  # マウス押した
  # -----------------------------------------------
  _eDown: (e) =>

    @_downTime = 0

    @_fontSize.start = @_fontSize.val
    @_lineHeight.start = @_lineHeight.val
    @_letterSpacing.start = @_letterSpacing.val



  # -----------------------------------------------
  # マウス離した
  # -----------------------------------------------
  _eUp: (e) =>

    # スライダー消す
    @_slider.css({
      display:'none'
    })

    # すぐに離したら操作するパラメータを変更
    # if Mouse.now.y > window.innerHeight * 0.5 && @_downTime < 10
    #   if ++@_nowParam >= 3
    #     @_nowParam = 0
    #   $('.debug_update_text p').removeClass('is_selected')
    #   $('.debug_update_text p:eq(' + @_nowParam + ')').addClass('is_selected')



  # -----------------------------------------------
  # マウス動いた
  # -----------------------------------------------
  _eMove: (e) =>

    if Mouse.isDown && Mouse.now.y < window.innerHeight * 0.4

      e.preventDefault()

      # フォントサイズ
      if @_nowParam == 0
        @_updateParam('fontSize', 10, 2, 20)

      # 行高
      if @_nowParam == 1
        @_updateParam('lineHeight', 1.5, 1, 3)

      # 文字間
      if @_nowParam == 2
        @_updateParam('letterSpacing', 0.5, 0, 0.5)

      @_updateFont()



  # -----------------------------------------------
  # パラメータ更新
  # -----------------------------------------------
  _updateParam: (name, interval, min, max) =>

    o = @['_' + name]

    add = (Mouse.dist.x / @_body.width()) * interval
    o.val = o.start + add
    o.val = Math.min(Math.max(o.val, min), max)
    o.val = Math.floor(o.val * 10000) / 10000

    # スライダー
    r = @_map(o.val, 0, 100, min, max)
    @_slider.css({
      display:'block'
    })
    @_sliderBar.css({
      width:String(r) + '%'
    })



  # -----------------------------------------------
  # フォント更新
  # -----------------------------------------------
  _updateFont: =>

    @_text.css({
      fontSize     :String(@_fontSize.val) + 'vw'
      lineHeight   :@_lineHeight.val
      letterSpacing:String(@_letterSpacing.val) + 'em'
    })



  # -----------------------------------------------
  # 更新
  # -----------------------------------------------
  _update: =>

    if Mouse.isDown
      @_downTime++

    sw = @_body.width()

    $('.debug_fix_text .debug_text:eq(0)').html(sw)
    $('.debug_fix_text .debug_text:eq(1)').html(sw * (window.devicePixelRatio || 1))

    px = Math.floor((sw * (@_fontSize.val / 100)) * 10000) / 10000
    $('.debug_update_text .debug_text:eq(0)').html(String(@_fontSize.val) + 'vw / ' + String(px) + 'px')

    $('.debug_update_text .debug_text:eq(1)').html(@_lineHeight.val)
    $('.debug_update_text .debug_text:eq(2)').html(String(@_letterSpacing.val) + 'em')

    window.requestAnimationFrame(@_update)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _map: (num, resMin, resMax, baseMin, baseMax) ->

    if num < baseMin then return resMin
    if num > baseMax then return resMax

    p = (resMax - resMin) / (baseMax - baseMin)
    return ((num - baseMin) * p) + resMin










module.exports = Top




main = new Top()
main.init()
