extends TextureButton
class_name BossNode

@onready var panel: Panel = $Panel
@export var boss: Bosses
@onready var line_2d: Line2D = $Line2D

var enabled: bool = false:
	set(value):
		enabled = value
		$Panel.show_behind_parent = value
		

func _ready() -> void:
	if get_parent() is not BossNode:
		enabled = true
		var bosses = get_children()
		for boss in bosses:
			if boss is BossNode and boss.get_parent().enabled:
				boss.disabled = false
	if boss:
		texture_normal = boss.texture
		
func _draw():
	var parent = get_parent()
	if parent is BossNode:
		var point = pointOnRect(-position.x + (parent.size.x / 2), -position.y + (parent.size.y / 2), 0, 0, size.x, size.y, true)
		draw_line(point, -position + (size / 2), Color.GREEN, 1.0, true)

#region Line origin calc
# Finds the intersection point between
#     * the rectangle
#       with parallel sides to the x and y axes 
#     * the half-line pointing towards (x,y)
#       originating from the middle of the rectangle
#
# Note: the function works given min[XY] <= max[XY],
#       even though minY may not be the "top" of the rectangle
#       because the coordinate system is flipped.
# Note: if the input is inside the rectangle,
#       the line segment wouldn't have an intersection with the rectangle,
#       but the projected half-line does.
# Warning: passing in the middle of the rectangle will return the midpoint itself
#          there are infinitely many half-lines projected in all directions,
#          so let's just shortcut to midpoint (GIGO).
#
# @param x:Number x coordinate of point to build the half-line from
# @param y:Number y coordinate of point to build the half-line from
# @param minX:Number the "left" side of the rectangle
# @param minY:Number the "top" side of the rectangle
# @param maxX:Number the "right" side of the rectangle
# @param maxY:Number the "bottom" side of the rectangle
# @param validate:boolean (optional) whether to treat point inside the rect as error
# @return an object with x and y members for the intersection
# @throws if validate == true and (x,y) is inside the rectangle
# @author TWiStErRob
# @licence Dual CC0/WTFPL/Unlicence, whatever floats your boat
# @see <a href="http:#stackoverflow.com/a/31254199/253468">source</a>
# @see <a href="http:#stackoverflow.com/a/18292964/253468">based on</a>
func pointOnRect(x, y, minX, minY, maxX, maxY, validate) -> Vector2:
	# assert minX <= maxX
	# assert minY <= maxY
	if (validate && (minX < x && x < maxX) && (minY < y && y < maxY)):
		printerr("Point ", [x,y], "cannot be inside ", "the rectangle: ", [minX, minY], " - ", [maxX, maxY], ".")
		return Vector2.ZERO
	var midX = (minX + maxX) / 2
	var midY = (minY + maxY) / 2
	# if (midX - x == 0) -> m == ±Inf -> minYx/maxYx == x (because value / ±Inf = ±0)
	var m = (midY - y) / (midX - x)

	if (x <= midX): # check "left" side
		var minXy = m * (minX - x) + y
		if (minY <= minXy && minXy <= maxY):
			return Vector2(minX, minXy)

	if (x >= midX): # check "right" side
		var maxXy = m * (maxX - x) + y
		if (minY <= maxXy && maxXy <= maxY):
			return Vector2(maxX, maxXy)
	
	if (y <= midY): # check "top" side
		var minYx = (minY - y) / m + x
		if (minX <= minYx && minYx <= maxX):
			return Vector2(minYx, minY)
	
	if (y >= midY): # check "bottom" side
		var maxYx = (maxY - y) / m + x
		if (minX <= maxYx && maxYx <= maxX):
			return Vector2(maxYx, maxY)
	
	# edge case when finding midpoint intersection: m = 0/0 = NaN
	if (x == midX && y == midY):
		return Vector2(x, y)

	# Should never happen :) If it does, please tell me!
	printerr("Cannot find intersection for ", [x,y], " inside rectangle ", [minX, minY], " - ", [maxX, maxY], ".")
	return Vector2.ZERO
#endregion

func _on_pressed() -> void:
	print("Boss pressed:", boss)

	# Enable this boss
	enabled = true
	panel.show_behind_parent = true

	# 🔹 Disable all other siblings
	var siblings = get_parent().get_children()
	for node in siblings:
		if node is BossNode and node != self:
			_disable_branch(node)

	# 🔹 Unlock this boss’s children
	var bosses = get_children()
	for child in bosses:
		if child is BossNode and child.get_parent().enabled:
			child.disabled = false
	#get_parent()._on_boss_selected(self)  # Notify parent container

func _disable_branch(node: BossNode) -> void:
	node.enabled = false
	node.disabled = true
	node.panel.show_behind_parent = false
	for child in node.get_children():
		if child is BossNode:
			_disable_branch(child)
