package _Base._Game._Blocks._States
{	
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;
	
	public class Burn extends BombEffectState
	{
		private static var _staticSettings:Object;
		
		public function Burn(block:Block,bombType:String, runUpdate:Boolean = false) 
		{		
			super(block,bombType,runUpdate);
			_self.onBurn(BlockState.ENTER);
		}
		
		public override function enter(currentOverride:Boolean=false):void 		 
		{		
			super.enter();
			
			_self.onBurn(BlockState.ENTER);
		}
		
		public override function exit():void
		{
			super.exit();
			
			_self.onBurn(BlockState.EXIT);
		}
		
		public override function update(time:Number):void
		{
			super.update(time);
			
			if(_runApply)
			{
				super.apply(time);

				_self.onBurn(BlockState.APPLY);
			}
		}
		
		public override function returning():void
		{
			_self.onBurn(BlockState.RETURNING);
		}
		
		public override function transition():void
		{
			_self.onBurn(BlockState.TRANSITION);
		}
		
		public override function toString():String
		{
			return "Burn";
		}
	}
}