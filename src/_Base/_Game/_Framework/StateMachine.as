package _Base._Game._Framework
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Blocks._Headers.IState;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.DirectionState;
	import _Base._Game._Utility.BlockUtilities;

	public class StateMachine
	{
		private var currentState:IState;
		private var previousState:IState;
		private var nextState:IState;
		private var _nextAttemptedState:String;
		
		public function StateMachine()
		{
			currentState = null;
			previousState = null;
			nextState = null;
		}
		
		// prepare a state for use after the current state
		public function setNextState( s:IState ):void
		{
			nextState = s;
		}
		
		// Update the FSM. Parameter is the frametime for this frame.
		public function update( time:Number ):void
		{
			if( currentState )
			{
				currentState.update( time );
			}
		}
		
		public function changeToAttempted(block:Block):void
		{
			var stateToConstruct:Class = BlockUtilities.ConstructClass(NextAttemptedState,true);
			changeState(new stateToConstruct(block,(currentState as BlockState).LatestBombDropped));	
		}
		
		// Change to another state
		public function changeState( s:IState, wasPrevious:Boolean = false):void
		{
			if(s.Saveable)
			{
				nextState = s;
				
				if(currentState)
				{
					currentState.exit();
					previousState = currentState;
				}
				
				currentState = s;
				
				nextState = null;
				
				if(wasPrevious)
					currentState.returning();
				else
					currentState.enter();
			}
			else
				s.enter();
		}
		
		// Change back to the previous state
		public function goToPreviousState():void
		{
			changeState( previousState , true);
		}
		
		// Go to the next state
		public function goToNextState():void
		{
			changeState( nextState );
		}
		
		public function get CurrentState():IState
		{
			return currentState;
		}
		
		public function get PreviousState():IState
		{
			return previousState;
		}
		
		public function set PreviousState(state:IState):void
		{
			previousState = state;
		}
		
		//only used during exit calls of current states
		public function get NextState():IState
		{
			return nextState;
		}
		
		public function get NextAttemptedState():String						   {	return _nextAttemptedState;				    }
		public function set NextAttemptedState(nextAttemptedState:String):void {	_nextAttemptedState = nextAttemptedState;	}
	}
}