package _Base._Game._Misc._Startup
{
	import _Base._Game._Managers.GameManager;
	import _Base._Game._Managers.RulesManager;
	
	import de.polygonal.ds.TreeNode;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	[SWF(width="800", height="700",backgroundColor="0xFF00FF")]
	public class YOW_YOW_MAIN extends _Base._Game._Misc._Startup.AWAY3D_BASE
	{
		private var _gameManager:GameManager;
	
		public function YOW_YOW_MAIN()
		{
			stage.align = StageAlign.BOTTOM_LEFT;
			stage.frameRate = 60;
			super();
		}
		
		protected override function initScene():void
		{
			super.initScene();
			
			camera.position = new Vector3D(0,400,-1000);
			camera.lookAt(new Vector3D(0,0,0));
			camera.pitch(10);
			camera.y = 800;
			
			_gameManager = new GameManager(this.view,this.stage);
			addChild(_gameManager);
		}
		
		
		protected override function updateGame():void
		{
			_gameManager.updateGame();
		}
	}
}