package _Base._Game._Managers
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Blocks._Headers.IFireable;
	import _Base._Game._Blocks._Headers.IState;
	import _Base._Game._Blocks._States.Fall;
	import _Base._Game._Blocks._States.Health;
	import _Base._Game._Blocks._States.Joker;
	import _Base._Game._Blocks._States.Stationary;
	import _Base._Game._Bombs._Base.BombWrapper;
	import _Base._Game._Bombs._Misc.BombDirection;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;
	import _Base._Game._Utility.BlockUtilities;
	
	import de.polygonal.ds.BitVector;
	
	import flash.events.EventDispatcher;
	import flash.utils.describeType;

	public class LogicManager extends EventDispatcher
	{
		private var _blockList:Vector.<Block>;
		
		private var _blocksToDamage:Vector.<int>;

		private var _horizontalCheck:Function;
		private var _verticalCheck:Function;
		private var _crossCheck:Function;

		private var _startingBlock:int;
		private var _bombType:String;
		private var _currentBlock:XML;
		
		private var _blocksDamaged:BitVector;
		
		public function LogicManager()
		{
			
			_blocksToDamage = new Vector.<int>();
			
			_horizontalCheck = function():void 		{ 	leftCheck(); rightCheck(); baseRemoval();				} 
			_verticalCheck = function():void 		{ 	upCheck(); downCheck();baseRemoval();					}
			_crossCheck = function():void 			{ 	_horizontalCheck();_verticalCheck(); baseRemoval(); 	}
	
			_blocksDamaged = new BitVector(64);
		}
		
		public function destroyedBlockSearch(startingBlock:int, selectedBomb:Object, bombDirection:int, coverAll:Boolean = false):void
		{
			_startingBlock = startingBlock;
			_bombType = selectedBomb.Type;
			
			var stateToConstruct:Class;
			
			if(BombDirection.HORIZONTAL & bombDirection)			{		_horizontalCheck();						}
			else if (BombDirection.VERTICAL & bombDirection)		{		_verticalCheck();						}
			else if(BombDirection.CROSS & bombDirection)			{		_crossCheck(); 							}
			else if (BombDirection.MEGA & bombDirection)			{ 		megaCheck(startingBlock); 				}
			else if(BombDirection.HORIZONTAL_LEFT & bombDirection)	{		leftCheck(coverAll);					}
			else if(BombDirection.HORIZONTAL_RIGHT & bombDirection) {		rightCheck(coverAll);					}
			else if(BombDirection.VERTICAL_UP & bombDirection)		{		upCheck(coverAll);						}
			else if(BombDirection.VERTICAL_DOWN & bombDirection)	{		downCheck(coverAll);					}
			
			var blockState:BlockState;
			
			_blocksToDamage.forEach(function(blockToDamage:int, index:int, vector:Vector.<int>):void
			 {
				blockState = (GameManager.blockManager.Blocks[blockToDamage].FSM.CurrentState as BlockState);
				
				blockState.LatestBombDropped = selectedBomb.Type;
				
				GameManager.blockManager.Blocks[blockToDamage].FSM.NextAttemptedState = selectedBomb.Effect;
				
				blockState.transition();
			});
			 
			_blocksToDamage.length = 0;
			 _blocksDamaged.clrAll();
		}
		
		
		private function baseRemoval():void
		{
			_blocksToDamage.push(_startingBlock);
		}
		
		private function leftCheck(coverAll:Boolean = false):void
		{	
			var rowBlock:int = Math.floor(_startingBlock / BlockManager.BLOCKS_PER_ROW);
		
			for(var i:int = _startingBlock - 1;i >= (rowBlock * BlockManager.BLOCKS_PER_ROW);i--)
			{
				if(GameManager.blockManager.Blocks[i])
				{
					if(coverAll)
					{
						_blocksToDamage.push(i);
					}
					else
					{
						if(!(GameManager.blockManager.Blocks[i].Type == "Titanium") 
							&& BlockUtilities.ImplementsInterface(GameManager.blockManager.Blocks[i], _bombType))
							_blocksToDamage.push(i);	
						else
							break;
					}
				}
				else
					break;
			}
		}
		
		private function rightCheck(coverAll:Boolean = false):void
		{
			var rowBlock:int = Math.floor(_startingBlock / BlockManager.BLOCKS_PER_ROW);
			
			for(var i:int = _startingBlock + 1;i <= ((rowBlock * BlockManager.BLOCKS_PER_ROW) + (BlockManager.BLOCKS_PER_ROW - 1));i++)
			{
				if(GameManager.blockManager.Blocks[i])
				{
					if(coverAll)
					{
						_blocksToDamage.push(i);
					}
					else
					{
						if(!(GameManager.blockManager.Blocks[i].Type == "Titanium") 
							&& BlockUtilities.ImplementsInterface(GameManager.blockManager.Blocks[i], _bombType))
							_blocksToDamage.push(i);	
						else
							break;
					}
				}
				else
					break;
			}
		}
		
		private function upCheck(coverAll:Boolean = false):void
		{
			for(var i:int = _startingBlock + BlockManager.BLOCK_VERT; i <= BlockManager.TOTAL_BLOCKS; i += BlockManager.BLOCK_VERT)
			{
				if(GameManager.blockManager.Blocks[i])
				{
					if(coverAll)
					{
						_blocksToDamage.push(i);
					}
					else
					{
						if(!(GameManager.blockManager.Blocks[i].Type == "Titanium") 
							&& BlockUtilities.ImplementsInterface(GameManager.blockManager.Blocks[i], _bombType))
							_blocksToDamage.push(i);	
						else
							break;
					}
				}
				else
					break;
			}
		}
		
		private function downCheck(coverAll:Boolean = false):void
		{
			for(var i:int = _startingBlock - BlockManager.BLOCK_VERT; i >= BlockManager.BLOCK_START; i -= BlockManager.BLOCK_VERT)
			{
				if(GameManager.blockManager.Blocks[i])
				{
					if(GameManager.blockManager.Blocks[i])
					{
						if(coverAll)
						{
							_blocksToDamage.push(i);
						}
						else
						{
							if(!(GameManager.blockManager.Blocks[i].Type == "Titanium") 
								&& BlockUtilities.ImplementsInterface(GameManager.blockManager.Blocks[i], _bombType))
								_blocksToDamage.push(i);	
							else
								break;
						}
					}
					else
						break;
				}
				else
					break;
			}
		}
		
		private function megaCheck(blockToCheck:Number):void
		{		
			if(GameManager.blockManager.Blocks[blockToCheck])
			{
				if(!(_blocksDamaged.has(blockToCheck)))
				{
					if(!(GameManager.blockManager.Blocks[blockToCheck].Type == "Titanium") 
						&& BlockUtilities.ImplementsInterface(GameManager.blockManager.Blocks[blockToCheck], _bombType))
					{
						_blocksToDamage.push(blockToCheck);	
						_blocksDamaged.set(blockToCheck);
					}
					else
						return;
				
					var currentRow:int = Math.floor(blockToCheck / BlockManager.BLOCKS_PER_ROW);
					
					var nextRow:int = Math.floor((blockToCheck + BlockManager.BLOCK_HOR) / BlockManager.BLOCKS_PER_ROW);
					
					
					//west fill
					if(Math.floor(blockToCheck / BlockManager.BLOCKS_PER_ROW) == (Math.floor((blockToCheck - BlockManager.BLOCK_HOR) / BlockManager.BLOCKS_PER_ROW)))
					{
						if(blockToCheck >= BlockManager.BLOCK_START && blockToCheck < BlockManager.TOTAL_BLOCKS)
							megaCheck(blockToCheck - BlockManager.BLOCK_HOR);
					}
					
					//east fill
					if(Math.floor(blockToCheck / BlockManager.BLOCKS_PER_ROW) == (Math.floor((blockToCheck + BlockManager.BLOCK_HOR) / BlockManager.BLOCKS_PER_ROW)))
					{
						if(blockToCheck >= BlockManager.BLOCK_START && blockToCheck < BlockManager.TOTAL_BLOCKS)
							megaCheck(blockToCheck + BlockManager.BLOCK_HOR);
					}
					//north fill
					if(!((blockToCheck + BlockManager.BLOCK_VERT) > (BlockManager.TOTAL_BLOCKS - BlockManager.BLOCK_VERT))) megaCheck(blockToCheck + BlockManager.BLOCK_VERT);
					
					//south fill
					if(!((blockToCheck - BlockManager.BLOCK_VERT) < BlockManager.BLOCK_START))megaCheck(blockToCheck - BlockManager.BLOCK_VERT);
				}
				else
					return;
			}
		}
	}
}

