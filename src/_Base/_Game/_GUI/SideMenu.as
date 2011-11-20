package _Base._Game._GUI
{
	import _Base._Game._Animation.AnimationWrapper;
	import _Base._Game._Bombs._Base.Bomb;
	import _Base._Game._Bombs._Base.BombWrapper;
	import _Base._Game._States._Base.DirectionState;
	import _Base._Game._States._Direction.Horizontal;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Mesh;
	import away3d.core.utils.Cast;
	import away3d.events.Loader3DEvent;
	import away3d.events.MouseEvent3D;
	import away3d.loaders.Collada;
	import away3d.loaders.Loader3D;
	import away3d.loaders.data.AnimationData;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.ColorMaterial;
	
	import flash.display.DisplayObject;
	import flash.geom.Vector3D;
	
	public class SideMenu extends ObjectContainer3D
	{
		
		public static const SIDE_MENU_OFFSET:Vector3D = new Vector3D(350,200,0,0);
		
		private var _effectMesh:Mesh;
		private var _bomb:BombWrapper;
		private var _effectAnimation:AnimationWrapper;
		
		public function SideMenu()
		{
			_bomb = new BombWrapper(.8);
				
			var _effectLoader:Loader3D = Collada.load('assets/block_effect.dae',
				{
					scale:30,
					pitch:-70,
					y:-100
				});
		
			_effectLoader.addOnSuccess(onLoadSuccess);
			
			addChild(_effectLoader);
			
			drawMenu();
			addItems();
			
		}
		
		private function onLoadSuccess(e:Loader3DEvent):void
		{
			_effectAnimation = new AnimationWrapper(
				e.loader.handle.animationLibrary.getAnimation("default"));
			
			_effectAnimation.FSM.changeState(new Horizontal(_effectAnimation));
			
			_effectMesh = e.loader.handle as Mesh;
			_effectMesh.material = new ColorMaterial(0xFFCCFF);
			_effectMesh.mouseEnabled = true;
			_effectMesh.useHandCursor = true;
			
			_effectMesh.addEventListener(MouseEvent3D.MOUSE_DOWN,onEffectClick);
			
		}
		
		private function onEffectClick(e:MouseEvent3D):void
		{
			if((_effectAnimation.FSM.CurrentState as DirectionState).AnimationDone)
			{
				_effectAnimation.FSM.goToNextState();
			}
		}
		
		private function drawMenu():void {}
		
		private function addItems():void
		{
			addChild(_bomb);
		}
		
		public function get EffectMesh():Mesh
		{
			return _effectMesh;
		}
		
		public function get ActiveBomb():BombWrapper
		{
			return _bomb;
		}
		
		public function get BombDirection():int
		{
			return (_effectAnimation.FSM.CurrentState as DirectionState).Type;
		}
	}
}