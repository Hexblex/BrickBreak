package _Base._Game._Managers
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Framework.IHSIterator;
	import _Base._Game._GUI.Board;
	import _Base._Game._Utility.BlockUtilities;
	
	import away3d.materials.BitmapMaterial;
	
	import de.polygonal.ds.ArrayedQueue;
	import de.polygonal.ds.ArrayedStack;
	import de.polygonal.ds.BitVector;
	import de.polygonal.ds.HashSet;
	import de.polygonal.ds.IntHashSet;
	import de.polygonal.ds.IntHashSetIterator;
	import de.polygonal.ds.PriorityQueue;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	public class BlockManager
	{
		public static const BLOCKS_PER_ROW:int = 7;
		public static const BLOCKS_PER_COLUMN:int = 7;
		
		public static const TOTAL_BLOCKS:int = 49;
		public static const BLOCK_START:int = 0;
		
		public static const BLOCK_WIDTH:int = 100;
		public static const BLOCK_HEIGHT:int = 100;
		
		public static const BLOCK_VERT:int = 7;
		public static const BLOCK_HOR:int = 1;
		
		public static const TOTAL_BLOCK_TYPES:int = 8;
		
		private var _blocks:Vector.<Block>;
		private var _blocksToDestroy:Vector.<int>;
		private var _columnMap:Vector.<IntHashSet>;
		
		private static var _livingBlockCount:int;
		
		protected static var _repMap:Dictionary;
		
		public function BlockManager()
		{
			_repMap 		   = new Dictionary();
			_blocksToDestroy   = new Vector.<int>;
			_columnMap         = new Vector.<IntHashSet>(BLOCKS_PER_ROW);
			
			_livingBlockCount  = TOTAL_BLOCKS;
			
			initBlocks();
		}
		
		private function initBlocks():void
		{
			_repMap[0] = "Brick";
			
			_repMap[1] = "Blood";
			
			_repMap[2] = "Cardboard";
			
			_repMap[3] = "Crystal";
			
			_repMap[4] = "Wood";
			
			_repMap[5] = "Glass";
			
			_repMap[6] = "Titanium";
			
			_repMap[7] = "Cement";
			
			var newBlock:Block;
			
			_blocks = new Vector.<Block>();
			
			for(var i:int = 0;i < TOTAL_BLOCKS;i++)
			{
				newBlock = BlockUtilities.GenerateRandomBlock(this);
				newBlock.BID = i;
				newBlock.material = new BitmapMaterial(SpriteSheetManager.GetBlockMaterial(newBlock))
				_blocks.push(newBlock);
			}
		}
		
		public function renderBlocks():void 
		{
			var hashSetIterator:IHSIterator;
			
			_columnMap.forEach(
				function(id_set:IntHashSet, index:int, vec:Vector.<IntHashSet>):void
				{
					if(id_set.size() > 0)
					{
						hashSetIterator = new IHSIterator(id_set);
						
						while(hashSetIterator.hasNext())
						{
							_blocks[hashSetIterator.next() as int].FSM.update(getTimer());
						}
					}
				});
		}
		
		public function get Blocks():Vector.<Block> 							{ 		return _blocks; 					  }
		
		public function get LivingBlockCount():int 								{ 		return _livingBlockCount; 			  }
		public function set LivingBlockCount(livingBlockCount:int):void 		{ 		_livingBlockCount = livingBlockCount; }
		
		public function get ColumnMap():Vector.<IntHashSet> 				    { 		return _columnMap; 			          }
		public function set ColumnMap(columnMap:Vector.<IntHashSet>):void 		{       _columnMap = columnMap; 			  }
		
		public function get BlocksToDestroy():Vector.<int>						{ 		return _blocksToDestroy; 			  }
		public function set BlocksToDestroy(destroyedBlocks:Vector.<int>):void { 		_blocksToDestroy = destroyedBlocks;   }
		
		public function get BlockRepMap():Dictionary							{		return _repMap;						  }
	}
}