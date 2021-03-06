package cc.tilemapparallaxnodes;
import flambe.display.Graphics;
import flambe.display.Sprite;
import cc.tilemapparallaxnodes.CCTMXXMLParser;
import flambe.math.Rectangle;

/**
 * ...
 * @author Ang Li
 */
class CCTMXSprite extends Sprite
{
	var _mapInfo : CCTMXMapInfo;
	var _layerInfo : CCTMXLayerInfo;
	var _height : Float;
	var _width : Float;
	public function new(layerInfo : CCTMXLayerInfo, mapInfo : CCTMXMapInfo) 
	{
		super();
		this._layerInfo = layerInfo;
		this._mapInfo = mapInfo;
	}
	var flag : Bool = true;
	override public function draw(g:Graphics)
	{
		var count : Int = 0;
		//trace(_layerInfo._tiles.length);
		for (row in 0..._layerInfo._tiles.length) {
			for (col in 0..._layerInfo._tiles[0].length) {
				var gid = _layerInfo._tiles[row][col];
				if (gid == 0) {
					continue;
				} else {
					var tilesetInfo : CCTMXTilesetInfo = getTilesetInfo(gid);
					var x = col * _mapInfo.getTileSize().width;
					var y = row * _mapInfo.getTileSize().height;
					
					var rect : Rectangle = tilesetInfo.rectForGID(gid);
					//trace(rect.toString());
					
					g.drawSubImage(tilesetInfo.texture, x, y, rect.x, rect.y, rect.width, rect.height);
				}
				
			}
			flag = false;
		}
	}
	
	private function getTilesetInfo(gid : Int) : CCTMXTilesetInfo {
		//trace(gid);
		var a = _mapInfo.getTilesets();
		//var tileset : CCTMXTilesetInfo = new CCTMXTilesetInfo();
		for (i in 0..._mapInfo.getTilesets().length) {
			//trace(a[i].firstGid);
			if (a[i + 1] != null) {
				if (gid >= a[i].firstGid && gid < a[i + 1].firstGid) {
					//trace(gid);
					return a[i];
				}
			} else {
				return a[i];
			}
		}
		return null;
	}
	
	override public function getNaturalWidth():Float 
	{
		return _layerInfo._layerSize.width * _mapInfo.getTileSize().width;
	}
	
	override public function getNaturalHeight():Float 
	{
		return _layerInfo._layerSize.height * _mapInfo.getTileSize().height;
	}
}