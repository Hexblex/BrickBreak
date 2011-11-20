package _Base._Game._States._Base
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Blocks._Headers.IBlockState;
	import _Base._Game._Blocks._Headers.IState;
	import _Base._Game._Blocks._States.Destroy;
	import _Base._Game._Framework.StateMachine;
	import _Base._Game._Managers.BlockManager;
	
	public class BlockState extends State implements IBlockState
	{
		protected var _fsm:StateMachine;
		protected var _self:Block;
		
		public static const ENTER:int = 1;
		public static const APPLY:int = 2;
		public static const EXIT:int = 3;
		public static const RETURNING:int = 4;
		public static const TRANSITION:int = 5;
		
		protected var _initialBombDropped:String;
		protected var _latestBombDropped:String;
		
		protected var _transitionPercentage:int = 0;
		
		public function BlockState(block:Block=null,blockManager:BlockManager=null)
		{
			_self = block;
			_fsm = _self.FSM;
			
			_saveable = true;
		}
		public function get InitialBombDropped():String {	return _initialBombDropped;	}
		
		public function get LatestBombDropped():String 						 	 {	return _latestBombDropped;						}
		public function set LatestBombDropped(latestBombDropped:String):void 	 {  _latestBombDropped = latestBombDropped; 		}
		
		public function get TransitionPercentage():int						 	 {	return _transitionPercentage;			 		}
		public function set TransitionPercentage(transitionPercentage:int):void	 {	_transitionPercentage = transitionPercentage;	}
		
		public override function update(time:Number):void
		{
			if(_self.FallState)
				_self.FallState.update(time);
		}
	}
}