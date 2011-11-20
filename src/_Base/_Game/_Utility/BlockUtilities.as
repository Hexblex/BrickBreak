package _Base._Game._Utility
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Blocks._Headers.IState;
	import _Base._Game._Blocks._Materials.Blood;
	import _Base._Game._Blocks._Materials.Brick;
	import _Base._Game._Blocks._Materials.Cardboard;
	import _Base._Game._Blocks._Materials.Cement;
	import _Base._Game._Blocks._Materials.Crystal;
	import _Base._Game._Blocks._Materials.Glass;
	import _Base._Game._Blocks._Materials.Titanium;
	import _Base._Game._Blocks._Materials.Wood;
	import _Base._Game._Blocks._Misc.MaterialProperty;
	import _Base._Game._Blocks._States.Burn;
	import _Base._Game._Blocks._States.Destroy;
	import _Base._Game._Blocks._States.Fall;
	import _Base._Game._Blocks._States.Freeze;
	import _Base._Game._Blocks._States.Health;
	import _Base._Game._Blocks._States.Joker;
	import _Base._Game._Blocks._States.Melt;
	import _Base._Game._Blocks._States.Shielded;
	import _Base._Game._Blocks._States.Slammed;
	import _Base._Game._Blocks._States.Soak;
	import _Base._Game._Blocks._States.Stationary;
	import _Base._Game._GUI.Board;
	import _Base._Game._Managers.BlockManager;
	import _Base._Game._Managers.GameManager;
	import _Base._Game._Managers.SpriteSheetManager;
	
	import away3d.materials.BitmapMaterial;
	
	import de.polygonal.ds.ArrayedStack;
	import de.polygonal.ds.BitVector;
	import de.polygonal.ds.IntHashSet;
	import de.polygonal.ds.PriorityQueueIterator;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	public class BlockUtilities
	{
	
		//so the compiler won't compain about not seeing the class during dynamic instantiation
		private var brick:Brick;
		private var blood:Blood;
		private var burn:Burn;
		private var cardboard:Cardboard;
		private var cement:Cement;
		private var crystal:Crystal;
		private var destroy:Destroy;
		private var fall:Fall;
		private var freeze:Freeze;
		private var glass:Glass;
		private var health:Health;
		private var joker:Joker;
		private var melt:Melt;
		private var shielded:Shielded;
		private var slammed:Slammed;
		private var soak:Soak;
		private var stationary:Stationary;
		private var titanium:Titanium;
		private var wood:Wood;
		
		public static const ROW_HEIGHTS:Vector.<int> = new <int>[-350,-250,-150,-50,50,150,250];
		
		[Embed(source='../_Misc/_Mappings/Mappings.xml', mimeType="application/octet-stream")]
		private static const _mappingClass:Class;
		
		private static var _xml:XML;
		
		public static function ConstructClass (className:String,state:Boolean):Class
		{
			var package_prefix:String = state ? "_Base._Game._Blocks._States." : "_Base._Game._Blocks._Materials.";
			
			var classToConstruct:Class;
			
			classToConstruct = getDefinitionByName(package_prefix + className) as Class;
			
			return classToConstruct;
		}
		
		public static function RemoveBlock(blockToRemove:Block):void
		{
			GameManager.board.removeChild(blockToRemove);
			GameManager.blockManager.LivingBlockCount;
			GameManager.blockManager.BlocksToDestroy.push(blockToRemove.BID); 
		}
		
		public static function GenerateRandomBlock(blockManager:BlockManager):Block
		{
			var randomNumber:int = (Math.random() * BlockManager.TOTAL_BLOCKS) % BlockManager.TOTAL_BLOCK_TYPES;
			var classToConstruct:Class = ConstructClass(blockManager.BlockRepMap[randomNumber],false);
			
			return new classToConstruct();
		}
		
		public static function RefactorBlocks(blockManager:BlockManager):void
		{
			
			var blockColumn:int;
			var fallingId:int;
			var landingId:int;
			var destroyedId:int;
			var fallingFound:Boolean;
			var fallingBlock:Block;
			
			var hitFound:Boolean = false;
			
			blockManager.BlocksToDestroy.sort(Array.NUMERIC);
			
			blockManager.BlocksToDestroy.forEach(
				function(destroyedId:int,index:int,vector:Vector.<int>):void
				{
					blockColumn = destroyedId % BlockManager.BLOCKS_PER_ROW;
				
					blockManager.ColumnMap[blockColumn].remove(destroyedId);
				});
			
			var currentId:int;
			
			var colsProcessed:ArrayedStack = new ArrayedStack();
			
			var column:int;

			blockManager.BlocksToDestroy.forEach(
				function(destroyedId:int,index:int,vector:Vector.<int>):void
				{
					column = destroyedId % BlockManager.BLOCKS_PER_ROW;
					
					if(!(colsProcessed.contains(column)))
					{
						colsProcessed.push(column);
					
						currentId = destroyedId;
						
						if(!(destroyedId + BlockManager.BLOCK_VERT >= BlockManager.TOTAL_BLOCKS))
						{
							while(!(currentId >= BlockManager.TOTAL_BLOCKS))
							{	
								currentId += BlockManager.BLOCK_VERT;
								
								if(blockManager.ColumnMap[column].has(currentId))
								{
								
									fallingId = currentId;
									landingId = fallingId - BlockManager.BLOCK_VERT;
			
									while(true)
									{
										if(blockManager.ColumnMap[column].has(landingId) || landingId < 0)
										{
											
											landingId = landingId + BlockManager.BLOCK_VERT;
											
											if(landingId < BlockManager.TOTAL_BLOCKS)
											{
												fallingBlock = blockManager.Blocks[fallingId];
												
												fallingBlock.BID = landingId;
												blockManager.Blocks[landingId] = fallingBlock;
												blockManager.Blocks[fallingId] = null;
												blockManager.ColumnMap[column].remove(fallingId);
												blockManager.ColumnMap[column].set(landingId);
												
												fallingBlock = blockManager.Blocks[landingId];
												
												fallingBlock.FallState = new Fall(fallingBlock);
									
												fallingBlock = null;
												
												break;
											}
										}
										else
										{
											landingId -= BlockManager.BLOCK_VERT;
										}
									}
								}
							}
						}
						else
						{
							blockManager.Blocks[destroyedId] = null;
						}
					}
				});
		}
		
		public static function GenerateNewBlock(blockManager:BlockManager,board:Board):void
		{
			
			if(!(blockManager.LivingBlockCount + 1 > BlockManager.TOTAL_BLOCKS))
			{
				var columnWithCapacity:int = -1;
				
				var sortedColumnSet:Array;
				var blockToFallOn:int;
				
				var newBlock:Block;
				
				for(var i:int = 0; i < blockManager.ColumnMap.length;i++)
				{
					
					if(blockManager.ColumnMap[Math.random() * BlockManager.BLOCKS_PER_ROW].size() < BlockManager.BLOCKS_PER_COLUMN)
					{
						columnWithCapacity = i;
						break;
					}
				}
				
				if(columnWithCapacity >= 0)
				{
					sortedColumnSet = blockManager.ColumnMap[columnWithCapacity].toArray().sort(Array.NUMERIC);	
					
					if(sortedColumnSet.length > 0)
						blockToFallOn = sortedColumnSet[sortedColumnSet.length - 1];
					else
						blockToFallOn = columnWithCapacity - BlockManager.BLOCK_VERT;
					
					newBlock =  GenerateRandomBlock(blockManager);
					newBlock.BID = blockToFallOn + BlockManager.BLOCK_VERT;
					newBlock.Y = ROW_HEIGHTS[Math.floor(newBlock.BID / BlockManager.BLOCKS_PER_ROW)] + 500;
					newBlock.X = columnWithCapacity * (BlockManager.BLOCK_WIDTH / 2);
					
					blockManager.ColumnMap[columnWithCapacity].set(newBlock.BID);
					
					blockManager.Blocks[newBlock.BID] = newBlock;
					
					board.addChild(newBlock);
			
					newBlock.FSM.changeState(new Fall(newBlock));
					
					++blockManager.LivingBlockCount;
				}
				else
					return;
			}
		}
		
		public static function ImplementsInterface(block:Block,toMatch:String):Boolean
		{
			var interfaces:String = describeType(block).child("implementsInterface").@type;
			
			if(interfaces.match(toMatch))
				return true;
			else
				return false;
		}
		
		public static function ChangeBlockTexture(block:Block):void
		{
			block.Material = new BitmapMaterial(SpriteSheetManager.GetBlockMaterial(block));
		}
		
		public static function GetMaterialLocation(materialProperty:MaterialProperty):int
		{
			if(_xml == null)
			{
				var ba:ByteArray = (new _mappingClass()) as ByteArray;
				var s:String = ba.readUTFBytes(ba.length);
				_xml = new XML(s);
			}
			
			var materialID:int;
			
			if(!materialProperty.Multi)
			{
				if(!materialProperty.Shielded)
				{
					materialID = _xml.child("Materials").child(materialProperty.Type).child(materialProperty.Health).children().(@burn == int(materialProperty.Burnt) && 
						@freeze == int(materialProperty.Frozen) && @melt == int(materialProperty.Melted) && @soak == int(materialProperty.Soaked)).valueOf();
				}
				else
				{
					materialID = _xml.child("Materials").child("Shield").child(materialProperty.Type).valueOf();
				}
			}
			else
			{
				materialID = _xml.child("Materials").elements("Multi").valueOf();
			}
			
			return materialID;
		}
		
		public static function ChangeBlock(oldBlock:Block, changingType:String):void
		{
			var ctr:Class = ConstructClass(changingType, false);
			
			var newBlock:Block = new ctr();
			
			newBlock.BID = oldBlock.BID;
			newBlock.Y = oldBlock.Y;
			newBlock.X = oldBlock.X;
			newBlock.Z = oldBlock.Z;
			
			GameManager.blockManager.Blocks[newBlock.BID] = newBlock;
			
			GameManager.board.removeChild(oldBlock);
			
			GameManager.board.addChild(newBlock);
		}
		
		public static function RandomizeBlocks():void
		{
			var randomID1:int;
			var randomID2:int;
			
			for(var i:int = 0; i < BlockManager.TOTAL_BLOCKS;i++)
			{
					
			}
		}
	}
}
