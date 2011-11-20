package _Base._Game._States._Direction
{
	import _Base._Game._Animation.AnimationWrapper;
	
	import away3d.events.AnimatorEvent;
	import away3d.loaders.data.AnimationData;
	import _Base._Game._Bombs._Misc.BombDirection;
	import _Base._Game._States._Base.DirectionState;

	public class Horizontal extends DirectionState
	{
		public function Horizontal(animationWrapper:AnimationWrapper)
		{
			super(animationWrapper);
			_startFrame = 0;
			_endFrame = 20;
			_type = BombDirection.HORIZONTAL;
		}
		
		public override function enter(currentOverride:Boolean=false):void		 
		{	
			_self.FSM.setNextState(new Vertical(_self));	
		}
		
		public override function exit():void  		 
		{	
			super.exit();
			_self.AD.animator.addEventListener(AnimatorEvent.ENTER_KEY_FRAME,stopPlaying);		
			_self.AD.animator.gotoAndPlay(_startFrame);		
		}
	
		public override function toString():String
		{
			return "Horizontal";
		}
	}
}