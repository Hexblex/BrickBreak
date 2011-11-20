package _Base._Game._Misc._Startup
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.primitives.Trident;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	
	public class AWAY3D_BASE extends Sprite
	{
		protected var scene:Scene3D;
		protected var camera:Camera3D;
		protected var view:View3D;

		public function AWAY3D_BASE():void
		{
			initUI();
			initEngine();
			initScene();
			initListeners();
		}
		
		protected function initEngine():void
		{
			view = new View3D();
			scene = view.scene;
			camera = new Camera3D();
			
			camera.rotationY = 10;
			
			view.camera = camera;
			
			view.scene.addChild(new Trident(1000,true));
			addChild(view);
			
			view.x = stage.stageWidth / 2;
			view.y = stage.stageHeight / 2;
		
		}
		
		protected function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void
		{
			updateGame();
			//view.clear();
			view.render();
		}
		
		protected function initScene():void {}
		protected function initUI():void {}
		protected function updateGame():void{}
	}
}