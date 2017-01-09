


# ---------------------------------------------------
# サイズ
# ---------------------------------------------------
class Size


  constructor: (width, height) ->

    @width  = width || 0
    @height = height || 0



  # -----------------------------------------------
  # 半分
  # -----------------------------------------------
  width2: =>

    return ~~(@width * 0.5)



  # -----------------------------------------------
  # 半分
  # -----------------------------------------------
  height2: =>

    return ~~(@height * 0.5)



  # -----------------------------------------------
  # 同じかどうか
  # -----------------------------------------------
  equal: (width, height) =>

    return (@width == width && @height == height)



  # -----------------------------------------------
  # 値セット
  # -----------------------------------------------
  set: (width, height) =>

    @width  = width
    @height = height



  # -----------------------------------------------
  # コピー
  # -----------------------------------------------
  copy: (size) =>

    @width = size.width
    @height = size.height






module.exports = Size
