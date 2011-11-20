package _Base._Game._Bombs._Base
{
	
	import _Base._Game._GUI.SideMenu;
	
	import away3d.materials.WireColorMaterial;
	import away3d.primitives.Sphere;
	
	import de.polygonal.ds.BitVector;
	
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	public class Bomb extends Sphere
	{
		
		protected var _type:String;
		protected var _menuOffset:Vector3D;
		
		public function Bomb(init:Object=null)
		{
			super(init);
			
			radius = 30;
			segmentsH = 10;
			segmentsW = 10;
			
			useHandCursor = true;
		}
		
		protected function initializePosition():void
		{
			this.x = this._menuOffset.x;
			this.y = this._menuOffset.y;
			this.z = this._menuOffset.z;
		}
		
		public function resetPosition():void
		{
			initializePosition();
		}
		
		public function get Type():String
		{
			return _type;
		}
		
	}
}
