package _Base._Game._States._Base
{
	import _Base._Game._Animation.AnimationWrapper;
	import _Base._Game._Blocks._Headers.IState;
	import _Base._Game._Bombs._Misc.BombDirection;
	import _Base._Game._Framework.StateMachine;
	
	import away3d.animators.Animator;
	import away3d.events.AnimatorEvent;
	import away3d.loaders.data.AnimationData;
	
	public class DirectionState extends State
	{
		protected var _fsm:StateMachine;
		protected var _self:AnimationWrapper;
		
		protected var _startFrame:int = 0;
		protected var _endFrame:int = 0;
		
		protected var _frameCounter:int = 0;
		
		public static var _animationCompleted:Boolean = true;
		
		protected var _type:int;
		
		public function DirectionState(directionAnimation:AnimationWrapper)
		{
			_self = directionAnimation;
			_fsm = _self.FSM;
		}
		
		protected function stopPlaying(e:AnimatorEvent):void
		{
			if(_self.AD.animator.currentFrame == _endFrame)
			{
				e.animator.gotoAndStop(_endFrame);
				_animationCompleted = true;
				e.animator.removeEventListener(AnimatorEvent.ENTER_KEY_FRAME,stopPlaying);		
			}
		}
		
		public function get AnimationDone():Boolean
		{
			return _animationCompleted;
		}
		
		public function get Type():int
		{
			return _type;
		}
	}
}