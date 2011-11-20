package _Base._Game._Blocks._States
{	
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;
	
	public class Melt extends BombEffectState
	{		
		public function Melt(block:Block,bombType:String, runUpdate:Boolean = true) 
		{		
			super(block,bombType,runUpdate);
		}
		
		public override function enter(currentOverride:Boolean=false):void		 
		{		
			super.enter();
			
			_self.onMelt(BlockState.ENTER);
		}
		
		public override function update(time:Number):void
		{
			super.update(time);
			
			if(_runApply)
			{
				super.apply(time);
				
				_self.onMelt(BlockState.APPLY);
			}
		}
	
		public override function returning():void
		{
			_self.onMelt(BlockState.RETURNING);
		}
		
		public override function transition():void
		{
			_self.onMelt(BlockState.TRANSITION);
		}
		
		public override function toString():String
		{
			return "Melt";
		}
	}
}