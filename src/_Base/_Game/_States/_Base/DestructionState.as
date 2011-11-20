package _Base._Game._States._Base
{
	
	import _Base._Game._Utility.BlockUtilities;
	import _Base._Game._Blocks._Base.Block;

	
	public class DestructionState extends BlockState
	{
		protected var _animationCompleted:Boolean = true;
		
		public function DestructionState(block:Block) 
		{ 
			super(block);
		}
		
		public override function enter(currentOverride:Boolean=false):void
		{
			
		}
		
		public override function exit():void 
		{
		}
		
		public override function update(time:Number):void
		{
			
			if(_animationCompleted)
			{
				BlockUtilities.RemoveBlock(_self);
			}
		}
	}
}