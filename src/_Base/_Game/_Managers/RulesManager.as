package _Base._Game._Managers
{
	import _Base._Game._Blocks._Materials.Brick;
	
	import away3d.graphs.TreeIterator;
	
	import de.polygonal.ds.TreeBuilder;
	import de.polygonal.ds.TreeIterator;
	import de.polygonal.ds.TreeNode;
	
	import flash.utils.Dictionary;

	public final class RulesManager
	{
		private static var _damageMap:Dictionary;
		private static var _timeMap:Dictionary;
		private static var _stateMap:Dictionary;
		private static var _textureTree:TreeNode;
		public static var EventMap:Dictionary = new Dictionary();
		
		public function RulesManager()
		{		
		}
		
		private static function initDamageMap():void
		{
			_damageMap = new Dictionary();
			
			_damageMap["Brick"]["Fire"] = 2;
			_damageMap["Brick"]["Acid"] = 5;
			_damageMap["Brick"]["Ice"] = 1;
			_damageMap["Brick"]["Water"] = 0;
			
			_damageMap["Cardboard"]["Fire"] = 100;
			_damageMap["Cardboard"]["Acid"] = 100;
			_damageMap["Cardboard"]["Ice"] = 20;
			_damageMap["Cardboard"]["Water"] = 20;
			
			_damageMap["Cement"]["Fire"] = 0;
			_damageMap["Cement"]["Acid"] = 5;
			_damageMap["Cement"]["Ice"] = 0;
			_damageMap["Cement"]["Water"] = 0;
			
			_damageMap["Crystal"]["Fire"] = 4;
			_damageMap["Crystal"]["Acid"] = 4;
			_damageMap["Crystal"]["Ice"] = 3;
			_damageMap["Crystal"]["Water"] = 0;
			
			_damageMap["Glass"]["Fire"] = 3;
			_damageMap["Glass"]["Acid"] = 3;
			_damageMap["Glass"]["Ice"] = 0;
			_damageMap["Glass"]["Water"] = 0;
			
			_damageMap["Titanium"]["Fire"] = 0;
			_damageMap["Titanium"]["Acid"] = 0;
			_damageMap["Titanium"]["Ice"] = 0;
			_damageMap["Titanium"]["Water"] = 0;
			
			_damageMap["Wood"]["Fire"] = 4;
			_damageMap["Wood"]["Acid"] = 5;
			_damageMap["Wood"]["Ice"] = 0;
			_damageMap["Wood"]["Water"] = 2;
		}
		
		private static function initStateMap():void
		{
			_stateMap = new Dictionary();	
		}
		
		private static function initTimeMap():void
		{
			_timeMap = new Dictionary();
			
			_timeMap["Fire"] = 3000;
			_timeMap["Ice"] = 10000;
			_timeMap["Acid"] = 1000;
			_timeMap["Water"] = 10000;
		}
		
		public static function GetDamage(blockType:String,bombType:String):int
		{
			if(_damageMap == null)
				initDamageMap();
			
			return _damageMap[blockType,bombType];
		}
		
		public static function GetTime(bombType:String):int
		{
			if(_timeMap == null)
				initTimeMap();
			
			return _timeMap[bombType];
		}
		
		private static function BuildTextureTree():void
		{
			var currentNode:TreeNode;
			_textureTree = new TreeNode("Blocks");
			
			var tbuilder:TreeBuilder = new TreeBuilder(_textureTree);
			tbuilder.appendChild("Blood");
			tbuilder.appendChild("Brick");
			tbuilder.appendChild("Cement");
			tbuilder.appendChild("Crystal");
			tbuilder.appendChild("Glass");
			tbuilder.appendChild("Titanium");
			tbuilder.appendChild("Wood");
			
			tbuilder.root();
			
			currentNode = tbuilder.getNode().find("Brick");
			
			currentNode.appendNode(new TreeNode(30));
			tbuilder = currentNode.getBuilder();
			
			tbuilder.down();
			
			tbuilder.appendChild("brick_crispy");
			tbuilder.appendChild(60);
			
			tbuilder.childEnd();
			tbuilder.down();
			
			tbuilder.appendChild("brick_heating");
			tbuilder.appendChild(100);
			
			tbuilder.childEnd();
			tbuilder.down();
			
			tbuilder.appendChild("brick_new");
			
			currentNode = tbuilder.getNode().find("Cardboard");
	
			tbuilder = currentNode.getBuilder();
			
			tbuilder.down();
			
			tbuilder.appendChild("cardboard_crispy");
			tbuilder.appendChild(90);
			
			tbuilder.childEnd();
			tbuilder.down();
			
			tbuilder.appendChild(100);
			
			tbuilder.childEnd();
			tbuilder.down();
			
			tbuilder.appendChild("cardboard_new");
			
			currentNode = tbuilder.getNode().find("Crystal");
			
			tbuilder = currentNode.getBuilder();
			
			currentNode.appendNode(new TreeNode(50));
			
			tbuilder.down();
			
			tbuilder.appendChild("crystal_crispy");
			tbuilder.appendChild(100);
			
			tbuilder.childEnd();
			tbuilder.down();
			
			tbuilder.appendChild("crystal_new");
			
			currentNode = tbuilder.getNode().find("Glass");
			
			currentNode.appendNode(new TreeNode(20));
			tbuilder = currentNode.getBuilder();
			
			tbuilder.down();
			
			tbuilder.appendChild("glass_crispy");
			tbuilder.appendChild(70);
			
			tbuilder.childEnd();
			tbuilder.down();
			
			tbuilder.appendChild("glass_heating");
			tbuilder.appendChild(100);
			
			tbuilder.childEnd();
			tbuilder.down();
			
			tbuilder.appendChild("glass_new");
			
			currentNode = tbuilder.getNode().find("Wood");
			
			currentNode.appendNode(new TreeNode(20));
			tbuilder = currentNode.getBuilder();
			
			tbuilder.down();
			
			tbuilder.appendChild("wood_crispy");
			tbuilder.appendChild(80);
			
			tbuilder.childEnd();
			tbuilder.down();
			
			tbuilder.appendChild("wood_heating");
			tbuilder.appendChild(100);
			
			tbuilder.childEnd();
			tbuilder.down();
			
			tbuilder.appendChild("wood_new");
		}
		
		public static function get StateMap():Dictionary
		{
			if(_stateMap == null)
				initStateMap();
			
			return _stateMap;
		}
		
		public static function SearchForTexture(blockType:String,integrity:int,frozen:Boolean=false):void
		{
			
			if(_textureTree == null)
				BuildTextureTree();
			
			var treeBuilder:TreeBuilder = _textureTree.getBuilder();
			
			treeBuilder.root();
	
			var brickNode:TreeNode = treeBuilder.getNode().find(blockType);
			treeBuilder = brickNode.getBuilder();
			treeBuilder.down();
			
			while(true)
			{
				if(integrity <= (treeBuilder.getNode().val as int))
				{			
					treeBuilder.childStart();
					treeBuilder.down();
			
					break;
				}
				else
				{
					if(!(treeBuilder.hasNextChild()))
						break;
					
					treeBuilder.childEnd();
					treeBuilder.down();
				}
			}
		}
	}
}