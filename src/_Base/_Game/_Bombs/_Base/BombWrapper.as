package _Base._Game._Bombs._Base
{
	
	import away3d.containers.ObjectContainer3D;
	import away3d.loaders.Obj;
	import away3d.primitives.Sphere;
	
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	import _Base._Game._Bombs._Meshes.BombMesh;
	
	public final class BombWrapper extends ObjectContainer3D
	{
		private var _type:String;
		private var _bomb:BombMesh
		private var _scale:Number;
		
		private var _menuOffset:Vector3D = new Vector3D(0,0,0,0);
		
		private var _effectMap:Dictionary;
		
		public function BombWrapper(scale:Number)
		{
			_scale = scale;
			createBomb();
		
			addChild(_bomb);
			
			_effectMap = new Dictionary();
			
			_effectMap['Fire']  = 'Burn';
			_effectMap['Ice']   = 'Freeze';
			_effectMap['Acid']  = 'Melt';
			_effectMap['Water'] = 'Soak';
			_effectMap['Shield'] = 'Shielded';
			_effectMap['Joker'] = 'Joker';
			_effectMap['Health'] = 'Health';
		}
		
		protected function createBomb():void
		{
			_bomb = new BombMesh(_scale);
			_bomb.useHandCursor = true;
			_bomb.yaw(100);
			_bomb.roll(20);
			
			//Types are Acid,Fire,Health,Ice,Joker,Shield,Water
			Type = "Fire";
		}
		
		public function get Type():String
		{
			return _type;
		}
		
		public function get Effect():String
		{
			return _effectMap[Type]
		}
		
		public function set Type(type:String):void
		{
			if(_type != type)
			{
				_type = type;
				_bomb.applyMaterialToMesh("bomb",_type);
			}
		}
		
		public function get Bomb():BombMesh
		{
			return _bomb;
		}
		
		public function resetPosition():void
		{
			this._bomb.x = this._menuOffset.x;
			this._bomb.y = this._menuOffset.y;
			this._bomb.z = this._menuOffset.z;
		}
	}
}