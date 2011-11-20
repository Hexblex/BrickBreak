package _Base._Game._Managers
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Bombs._Base.BombWrapper;
	import _Base._Game._Bombs._Misc.BombDirection;
	import _Base._Game._GUI.Board;
	import _Base._Game._GUI.SideMenu;
	import _Base._Game._Utility.BlockUtilities;
	
	import away3d.containers.View3D;
	import away3d.events.MouseEvent3D;
	import away3d.test.Button;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	public class GameManager extends Sprite
	{
		protected var _view:View3D
		protected var _stage:Stage;
		
		public static var board:Board;
		public static var sideMenu:SideMenu;
		
		public static var blockManager:BlockManager;
		public static var logicManager:LogicManager;
		public static var physicsManager:PhysicsManager;
		
		private var _debugContainer:Sprite;
		
		private var _selectedBomb:BombWrapper = null;
		
		public function GameManager(view:View3D, stage:Stage)
		{			
			_view = view;
			_stage = stage;
			
			blockManager = new BlockManager();
			logicManager = new LogicManager();
			physicsManager = new PhysicsManager();
			
			createBoard();
			createSideMenu();
			
			view.scene.addChild(board);
			view.scene.addChild(sideMenu);
			
			sideMenu.ActiveBomb.addEventListener(MouseEvent3D.MOUSE_DOWN, onBombClick);
			
			debug_built();
		}
		
		private function debug_built():void
		{
			
			_debugContainer = new Sprite();
			_debugContainer.addEventListener(MouseEvent.CLICK,onContainerClick);
			
			addChild(_debugContainer);
			
			var btnFireEffect:Button = new Button("Fire",20,10);
			btnFireEffect.y = 120;
			_debugContainer.addChild(btnFireEffect);
			var btnWaterEffect:Button = new Button("Water",20,10);
			btnWaterEffect.y = 140;
			_debugContainer.addChild(btnWaterEffect);
			var btnIceEffect:Button = new Button("Ice",20,10);
			btnIceEffect.y = 160;
			_debugContainer.addChild(btnIceEffect);
			var btnAcidEffect:Button = new Button("Acid",20,10);
			btnAcidEffect.y = 180;
			_debugContainer.addChild(btnAcidEffect);
			var btnHealthEffect:Button = new Button("Health",20,10);
			btnHealthEffect.y = 200;
			_debugContainer.addChild(btnHealthEffect);
			var btnJokerEffect:Button = new Button("Joker",20,10);
			btnJokerEffect.y = 220;
			_debugContainer.addChild(btnJokerEffect);
			var btnShieldEffect:Button = new Button("Shield",20,10);
			btnShieldEffect.y = 240;
			_debugContainer.addChild(btnShieldEffect);
		}
		
		private function onContainerClick(e:MouseEvent):void
		{
			if(e.target is Button)
			{
				var newEffect:String = (e.target as Button).toString();
				sideMenu.ActiveBomb.Type = newEffect;
			}
		}
		
		private function onBombClick(e:MouseEvent3D):void
		{
			if(e.currentTarget is BombWrapper)
			{
				_selectedBomb = (e.currentTarget as BombWrapper);
				_selectedBomb.Bomb.mouseEnabled = false;
				
				board.addEventListener(MouseEvent3D.MOUSE_MOVE, onBoardMove);	
			}	
		}
		
		private function onBoardMove(e:MouseEvent3D):void
		{
			board.addEventListener(MouseEvent3D.MOUSE_UP, onBoardUnclick);
			
			_selectedBomb.Bomb.x = e.sceneX - SideMenu.SIDE_MENU_OFFSET.x;
			_selectedBomb.Bomb.y = (e.sceneY - SideMenu.SIDE_MENU_OFFSET.y) + 20;
		}
		
		private function onBoardUnclick(e:MouseEvent3D):void
		{	
			
			_selectedBomb.Bomb.mouseEnabled = true;
			
			board.removeEventListener(MouseEvent3D.MOUSE_MOVE, onBoardMove);
			board.removeEventListener(MouseEvent3D.MOUSE_UP, onBoardUnclick);
			
			var hitBlock:Block = e.object.parent as Block;
		
			if(BlockUtilities.ImplementsInterface(GameManager.blockManager.Blocks[hitBlock.BID], _selectedBomb.Type))
				logicManager.destroyedBlockSearch(hitBlock.BID, _selectedBomb,sideMenu.BombDirection);	
			
			_selectedBomb.resetPosition();
		}
		
		private function createBoard():void
		{	
			board = new Board(BlockManager.BLOCKS_PER_ROW,BlockManager.BLOCKS_PER_COLUMN,BlockManager.BLOCKS_PER_ROW * BlockManager.BLOCK_WIDTH,
				BlockManager.BLOCKS_PER_COLUMN * BlockManager.BLOCK_HEIGHT, blockManager);
			board.z = 100;
		}
		
		private function createSideMenu():void
		{
			sideMenu = new SideMenu();
			sideMenu.x = SideMenu.SIDE_MENU_OFFSET.x;
			sideMenu.y = SideMenu.SIDE_MENU_OFFSET.y;
		}
		
		public function updateGame():void
		{
			if(blockManager.BlocksToDestroy.length > 0)
				BlockUtilities.RefactorBlocks(blockManager);
			
			blockManager.BlocksToDestroy.length = 0;
			
			blockManager.renderBlocks();
		}
	}
}