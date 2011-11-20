package _Base._Game._States._Base
{
	import _Base._Game._Blocks._Headers.IState;

	public class State implements IState
	{
		protected var _saveable:Boolean;
		
		public function State() { _saveable = true;}
		
		public function enter(currentOverride:Boolean=false):void{ }
		
		public function exit():void {}
		
		//when you go back to a state using goToPreviousState
		//for example, if you return from a slammed state to a frozen brick, the cube will just break but if you return from a slam on a blood water block, then it will instantly collapse
		public function returning():void  {	 }
		
		public function update(time:Number):void {}
		
		//to apply the integrity addition/subtraction over a certain duration, called from the update if the apply is active
		public function apply(time:Number):void {}
		
		public function activateApply(refreshProperties:Boolean=false):void {}
		
		public function deactivateApply():void {}
		
		public function transition():void	{}
		
		public function get Saveable():Boolean								 { return _saveable;						}
		public function set Saveable(saveable:Boolean):void					 { _saveable = saveable;					}
		
		public function toString():String {return "null";}
	}
}