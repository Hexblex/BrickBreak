package _Base._Game._Blocks._Misc
{
	public final class MaterialProperty
	{
		private var _frozen:Boolean;
		private var _melted:Boolean;
		private var _soaked:Boolean;
		private var _burnt:Boolean;
		private var _shielded:Boolean;
		private var _multi:Boolean;
		private var _slammed:Boolean;
		
		private var _type:String;
		
		private var _health:String;
		
		private var _currentMaterial:String;
		
		public function get Type():String 									{ 		return _type; 			  				}
		public function set Type(type:String):void							{ 		_type = type; 			  				}
		
		public function get CurrentMaterial():String 					 	{ 		return _currentMaterial; 	  			}
		public function set CurrentMaterial(currentMaterial:String):void 	{ 		_currentMaterial = currentMaterial;		}
		
		public function get Frozen():Boolean 					 			{ 		return _frozen; 	  					}
		public function set Frozen(frozen:Boolean):void 					{ 		_frozen = frozen;						}
		
		public function get Melted():Boolean 					 			{ 		return _melted; 	  					}
		public function set Melted(melted:Boolean):void 					{ 		_melted = melted;						}
		
		public function get Soaked():Boolean 					 			{ 		return _soaked; 	  					}
		public function set Soaked(soaked:Boolean):void 					{ 		_soaked = soaked;						}
		
		public function get Burnt():Boolean 					 			{ 		return _burnt; 	  						}
		public function set Burnt(burnt:Boolean):void 						{ 		_burnt = burnt;							}
	
		public function get Shielded():Boolean 					 			{ 		return _shielded; 	  					}
		public function set Shielded(shielded:Boolean):void 				{ 		_shielded = shielded;					}
		
		public function get Multi():Boolean 					 			{ 		return _multi; 	  						}
		public function set Multi(multi:Boolean):void 						{ 		_multi = multi;							}
		
		public function get Slammed():Boolean								{		return _slammed;						}
		public function set Slammed(slammed:Boolean):void					{		_slammed = slammed;						} 
		
		public function get Health():String									{		return _health;							}
		public function set Health(health:String):void						{		_health = health;						}
		
		public function resetProperties():void
		{
			_frozen = false;
			_melted = false;
			_soaked = false;
			_burnt = false;
			_shielded = false;
			_multi = false;	
			_slammed = false;
			_health = BlockHealth.HEALTHY;	
		}
		
		public function toString():String
		{
			return "Frozen: " + Frozen + "\n" + "Melted: " + Melted + "\n" + "Soaked: " + Soaked + "\n" + "Burnt: " + Burnt + "\n" +
				"Shielded: " + Shielded + "\n" + "Multi: " + Multi;
		}
	}
}