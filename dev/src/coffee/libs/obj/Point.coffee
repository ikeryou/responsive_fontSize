


# ---------------------------------------------------
# ポイントクラス
# ---------------------------------------------------
class Point


  # -----------------------------------------------
  # コンストラクタ
  # -----------------------------------------------
  constructor: (x, y)->

    @x = x || 0;
    @y = y || 0;



  # -----------------------------------------------
  #
  # -----------------------------------------------
  subtract: (pt) =>

    return new Point(@x - pt.x, @y - pt.y)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  copy: (point) =>

    @x = point.x
    @y = point.y



  # -----------------------------------------------
  # 距離
  # -----------------------------------------------
  distanceTo: (point) =>

    dx = point.x - @x
    dy = point.y - @y

    return Math.sqrt(dx * dx + dy * dy)
















module.exports = Point
