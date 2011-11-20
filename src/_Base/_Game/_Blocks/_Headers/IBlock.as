package _Base._Game._Blocks._Headers
{
	import _Base._Game._Misc._Startup.AWAY3D_BASE;

	public interface IBlock
	{
		function render():void;
		function onBurn(phase:int):void;
		function onDestroy():void;
		function onMelt(phase:int):void;
		function onSoak(phase:int):void;
		function onFreeze(phase:int):void;
		function onShield(phase:int):void;
		function onStationary(phase:int):void;
	}
}