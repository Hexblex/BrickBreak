package _Base._Game._Managers
{
	import _Base._Game._Blocks._Misc.MaterialProperty;
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Utility.BlockUtilities;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public final class SpriteSheetManager
	{
		[Embed(source="./assets/textures/Blocks/yow_sprite_sheet.jpg")]
		protected static var yowSS:Class;
		
		private static var _ssData:BitmapData;
		private static var _tileWidth:int;
		private static var _tileHeight:int;
		private static var _rowLength:int;
		
		private static var _tileRectangle:Rectangle;
		private static var _tilePoint:Point;
		
		private static var _canvasBitmapData:BitmapData;
		
		private static var _initClass:Boolean = InitClass();
	
		
		private static function InitClass():Boolean
		{
			var ssBitmap:Bitmap = new yowSS();
			_ssData = ssBitmap.bitmapData;
			
			_tileWidth = 256;
			_tileHeight = 256;
			
			_rowLength = ssBitmap.width / _tileWidth;
			
			_tileRectangle = new Rectangle(0,0,_tileWidth,_tileHeight);
			_tilePoint = new Point(0,0);
			
			_canvasBitmapData = new BitmapData(_tileWidth,_tileHeight,false);
			
			return true;
		}
		
		public static function GetBlockMaterial(block:Block):BitmapData
		{
			
			var materialIndex:int = BlockUtilities.GetMaterialLocation(block.MaterialProperties);
			
			_tileRectangle.x = int((materialIndex % _rowLength)) * _tileWidth;
			_tileRectangle.y = int((materialIndex / _rowLength)) * _tileHeight;
			
			_canvasBitmapData.copyPixels(_ssData, _tileRectangle,_tilePoint);
			
			return _canvasBitmapData.clone();
		}
	}
}