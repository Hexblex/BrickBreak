package _Base._Game._GUI
{
	import away3d.core.utils.Cast;
	import away3d.core.utils.Color;
	import away3d.primitives.Plane;
	
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	public class HealthBar extends Plane
	{
		private var _healthTexture:BitmapData;
		
		public function HealthBar()
		{
			yUp = false;
			width = 60;
			height = 5;
			
			_healthTexture = new BitmapData(10,40,false,0x585858);
			
			this.material = Cast.material(_healthTexture);
			
			adjustHealth(100);
		}
		
		public function adjustHealth(integrity:Number):void
		{
			
			var integrityCalc:Number = integrity / 100;
			
			_healthTexture.floodFill(0,0, 0x585858);
			_healthTexture.fillRect(new Rectangle(0,0,(integrityCalc) * _healthTexture.width,20), 
				Color.fromFloats((integrityCalc < 0.5 ? 1 : 1 - (2 * integrityCalc - 1)),(integrityCalc > 0.5 ? 1 : (2 * integrityCalc)),0));
			
		}
	}
}