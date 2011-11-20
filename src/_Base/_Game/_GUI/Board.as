package _Base._Game._GUI
{
	import _Base._Game._Utility.BlockUtilities;
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Blocks._Headers.IFireable;
	import _Base._Game._Blocks._Headers.IWaterable;
	import _Base._Game._Managers.BlockManager;
	
	import away3d.containers.ObjectContainer3D;
	
	import de.polygonal.ds.BitVector;
	import de.polygonal.ds.IntHashSet;
	import de.polygonal.ds.IntHashSetIterator;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class Board extends ObjectContainer3D
	{
		private var _segH:Number;
		private var _segW:Number;
		private var _width:Number;
		private var _height:Number;

		public function Board(segH:Number,segW:Number,width:Number,height:Number,blockManager:BlockManager)
		{
			_segH = segH;
			_segW = segW;
			_height = height;
			_width = width;

			initBoard(blockManager);
		}
		
		private function initBoard(blockManager:BlockManager):void
		{
			
			var newBlock:Block;
		
			var boardHalfWidth:int = _width/2;
			var boardHalfHeight:int = _height/2;
			
			var column:Number;
			
			for(var rows:Number = 0; rows < (BlockManager.BLOCKS_PER_ROW); rows++)
			{
				for(var cols:Number = 0;cols < BlockManager.BLOCKS_PER_COLUMN; cols++)
				{
					newBlock = blockManager.Blocks[(rows * (BlockManager.BLOCKS_PER_ROW)) + (cols)];
					
					newBlock.Z = 10;
					newBlock.X = (int(newBlock.BID % BlockManager.BLOCKS_PER_ROW) * BlockManager.BLOCK_HEIGHT) - (boardHalfWidth);
					newBlock.Y = (int(newBlock.BID / BlockManager.BLOCKS_PER_ROW) * BlockManager.BLOCK_HEIGHT) - (boardHalfHeight);
					
					if(blockManager.ColumnMap[cols] == null)
						blockManager.ColumnMap[cols] = new IntHashSet(16);
					
					blockManager.ColumnMap[cols].set(newBlock.BID);
		
					addChild(newBlock);
				}
			}		
		}
	}
}
