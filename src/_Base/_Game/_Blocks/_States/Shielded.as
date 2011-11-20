package _Base._Game._Blocks._States
{	
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._States._Base.BombEffectState;
	import _Base._Game._States._Base.BlockState;
	
	public class Shielded extends BombEffectState
	{	
		public function Shielded(block:Block,bombType:String,runUpdate:Boolean = true) 
		{		
			super(block,bombType, runUpdate);	
		}
		
		public override function enter(currentOverride:Boolean=false):void		 
		{	
			_self.onShield(BlockState.ENTER);
			
			_settings = {duration:4000, damage:0}
			_runApply = true;	
		}
		
		public override function exit():void  	
		{	
			super.exit(); 
			
			_self.onShield(BlockState.EXIT);
		}
		
		
		public override function update(time:Number):void
		{
			super.update(time);
			
			if(!_runApply)
				_self.FSM.goToPreviousState();
			else
				super.apply(time);
		}

		public override function toString():String
		{
			return "Shielded";
		}
	}
}