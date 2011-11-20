package _Base._Game._Animation
{
	import _Base._Game._Framework.StateMachine;
	
	import away3d.loaders.data.AnimationData;

	import flash.events.EventDispatcher;

	public class AnimationWrapper extends EventDispatcher
	{
		private var _fsm:StateMachine;
		private var _animationData:AnimationData;
		
		public function AnimationWrapper(animationData:AnimationData)
		{
			_fsm = new StateMachine();
			_animationData = animationData;
		}
		
		public function get FSM():StateMachine
		{
			return _fsm;
		}
		
		public function get AD():AnimationData
		{
			return _animationData;
		}
	}
}