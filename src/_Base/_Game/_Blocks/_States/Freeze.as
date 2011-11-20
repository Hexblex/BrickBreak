package _Base._Game._Blocks._States
{	
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;
	
	public class Freeze extends BombEffectState
	{	
		public function Freeze(block:Block,bombType:String,runUpdate:Boolean = true) 
		{		
			super(block,bombType, runUpdate);
		}
		
		public override function enter(currentOverride:Boolean=false):void		 
		{		
			super.enter();

			_self.onFreeze(BlockState.ENTER);
		}
		
		public override function exit():void  		 
		{		
			super.exit(); 
			
			_self.onFreeze(BlockState.EXIT); 
		}
		
		public override function update(time:Number):void
		{
			super.update(time);
			
			if(_runApply)
			{
				super.apply(time);
				_self.onFreeze(BlockState.APPLY);
			}
		}
		
		public override function transition():void
		{
			_self.onFreeze(BlockState.TRANSITION);
		}
		
		public override function returning():void
		{
			_self.onFreeze(BlockState.RETURNING);
		}
		
		public override function toString():String
		{
			return "Freeze";
		}
	}
}