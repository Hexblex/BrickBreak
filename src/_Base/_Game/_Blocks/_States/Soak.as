package _Base._Game._Blocks._States
{	
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;
	
	public class Soak extends BombEffectState
	{	
		public function Soak(block:Block,bombType:String,runUpdate:Boolean = true) 
		{		
			super(block,bombType, runUpdate);
		}
		
		public override function enter(currentOverride:Boolean=false):void 		 
		{		
			super.enter();
			
			_self.onSoak(BlockState.ENTER);
		}
		
		public override function exit():void 
		{		
			super.exit(); 
			
			_self.onSoak(BlockState.EXIT); 
		}
		
		public override function update(time:Number):void
		{
			super.update(time);
			
			if(_runApply)
			{
				super.apply(time);
				_self.onSoak(BlockState.APPLY);
			}
		}
		
		public override function transition():void
		{
			_self.onSoak(BlockState.TRANSITION);
		}
		
		public override function returning():void
		{
			_self.onSoak(BlockState.RETURNING);
		}
		
		public override function toString():String
		{
			return "Soak";
		}
	}
}