package _Base._Game._Blocks._Headers
{
	public interface IState
	{
		//operations before the state is changed to or exited from
		function enter(currentOverride:Boolean=false):void;
		function exit():void;
		function update(time:Number):void;
		function apply(time:Number):void;
		function activateApply(refreshProperty:Boolean=false):void;
		function deactivateApply():void;
		function returning():void;
		function transition():void;
		function toString():String;
		
		function get Saveable():Boolean;
	}
}