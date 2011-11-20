package _Base._Game._Blocks._States
{
	
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;
	
	public class Joker extends BombEffectState
	{
		public function Joker(block:Block,bombType:String)
		{ 
			super(block,bombType);
			
			_saveable = false;
		}
		
		public override function enter(currentOverride:Boolean=false):void 
		{
			super.enter(true);
			
			exit();
		}
		
		public override function exit():void 
		{
			_self.FSM.CurrentState.returning();
		}
		
		public override function toString():String
		{
			return "Health";
		}
	}
}