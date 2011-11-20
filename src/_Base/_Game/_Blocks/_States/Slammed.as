package _Base._Game._Blocks._States
{
	
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._States._Base.BlockState;
	
	public class Slammed extends BlockState
	{
		private var _weightDropped:int;
		
		public function Slammed(block:Block,weightDropped:int) 
		{ 
			super(block);
			
			_saveable = false;
			
			_weightDropped = weightDropped;
		}
		
		public override function enter(currentOverride:Boolean=false):void
		{
			_self.MaterialProperties.Slammed = true;
			
			if(_self.FSM.CurrentState != "Shielded" && _self.FSM.CurrentState != "Freeze")
				_self.Integrity -= _weightDropped;
			
			if(_self.Integrity <= 0)
				_self.FSM.changeState(new Destroy(_self));
			else
				_self.FSM.CurrentState.returning();
			
			exit();
		}
		
		public override function exit():void 
		{
			//animation end goes here
		}
		
		public override function toString():String
		{
			return "Slammed";
		}
	}
}