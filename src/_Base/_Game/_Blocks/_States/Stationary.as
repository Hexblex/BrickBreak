package _Base._Game._Blocks._States
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Framework.StateMachine;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;

	public class Stationary extends BombEffectState
	{
		public function Stationary(block:Block,bombType:String="")
		{
			super(block,bombType);
		}
		
		public override function enter(currentOverride:Boolean=false):void
		{
			if(_self.FSM.PreviousState == null)
				_self.FSM.PreviousState = this;
			
			_self.onStationary(BlockState.ENTER);
		}
		
		public override function returning():void
		{
			_self.onStationary(BlockState.RETURNING);
		}
		
		public override function transition():void
		{
			_self.onStationary(BlockState.TRANSITION);
		}
		
		public override function toString():String
		{
			return "Stationary";
		}
	}
}