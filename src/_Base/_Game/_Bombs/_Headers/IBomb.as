package _Base._Game._Bombs._Headers
{
	import _Base._Game._Bombs._Base.Bomb;
	
	import de.polygonal.ds.BitVector;
	
	import flash.utils.Dictionary;

	public interface IBomb
	{
		function shadeBomb():void;
		function getBlockTypeMapping(mapLookup:Dictionary):BitVector;
		function get Type():String;
		function set MouseEnabled(isEnabled:Boolean):void;
		function get X():Number;
		function get Y():Number;
		function set X(x:Number):void;
		function set Y(y:Number):void;
	}
}