package _Base._Game._Blocks._Misc
{
	import _Base._Game._Blocks._Base.Block;

	public final class BlockProperties
	{
		private static var _properties:Object;
		
		private static function InitProperties():void
		{
			//order of properties is type, state, bomb effect
			_properties = 
			{
				Blood: 
				{
					Burn:
					{
						Fire  :{ damage:  90,  duration: 0  },
						Health:{ damage: -100, duration: 0	},
						Joker :{ damage: 50,  duration: 0  }
					},
					Melt:
					{
						Acid  :{ damage:  90,  duration: 0  },
						Health:{ damage: -100, duration: 0	},
						Joker :{ damage: 50,  duration: 0  }
						
					},
					Soak:
					{
						Water  :{ damage:  90,  duration: 0  },
						Health :{ damage: -100, duration: 0	 },
						Joker :{ damage: 50,  duration: 0   }
					},
					Stationary:
					{
						Fire  :{ damage:  90,  duration: 0  },
						Acid  :{ damage:  90,  duration: 0  },
						Water :{ damage:  90,  duration: 0  },
						Health:{ damage: -15,  duration: 0	},
						Joker :{ damage: 50,  duration: 0  }
					}
				},
				Brick: 
				{
					Burn:
					{
						Fire: { damage: 12, duration: 3000 },
						Ice:  {	damage: 5,  duration:  1000},
						Water:{ damage:-6,  duration:  3000},
						Health:{damage:-8, duration:  0	   },
						Joker :{ damage: 50,  duration: 0  }
					},
					Freeze:
					{
						Fire: { damage:10, duration:2000 },
						Ice:  { damage:4,  duration:1000 }
					},
					Soak:
					{
						Fire: { damage: 5, duration: 2000 },
						Water:{ damage: 2, duration: 3000 },
						Health:{damage:-10, duration: 0},
						Joker :{ damage: 50,  duration: 0  }
					},
					Stationary:
					{
						Fire: { damage:14, duration: 3000 },
						Water:{ damage:8,  duration: 3000 },
						Ice:  { damage:9,  duration: 3000 },
						Health:{damage:-15, duration:0	  },
						Joker :{ damage: 50,  duration: 0  }
					}
				},
				Crystal: 
				{
					Melt:
					{
						Fire: { damage: 5, duration: 3000    },
						Ice:  {	damage:  5,  duration:  1000 },
						Acid  :{ damage: 15, duration:  3000 },
						Health:{damage: -50,  duration:  0   },
						Joker :{ damage: 40,  duration:  0   }
					},
					Freeze:
					{
						Acid: {	damage:7, duration:2000	},
						Fire: { damage:7, duration:2000 },
						Ice:  { damage:0,  duration: 0  }
					},
					Stationary:
					{
						Acid: { damage:15, duration: 3000 },
						Ice:  { damage:10,  duration: 0 },
						Health:{damage:-20, duration:0	  },
						Joker :{ damage: 40,  duration: 0  }
					}
				},
				Cardboard: 
				{
					Burn:
					{
						Fire: { damage: 15, duration: 3000 },
						Ice:  {	damage: 20,  duration:  1000},
						Acid :{ damage:20, duration:  3000},
						Water :{damage:-10,  duration:  3000},
						Health:{damage: -50,  duration:  0   },
						Joker :{ damage: 50,  duration:  0   }
					},
					Freeze:
					{
						Fire: { damage:10, duration:2000 },
						Ice:  { damage:4,  duration:1000 }
					},
					Melt:
					{
						Acid: { damage:20, duration: 0	 },
						Fire: { damage:20, duration: 3000},
						Health:{damage:-20, duration:0	 },
						Joker: {damage:50, duration: 0	 },
						Water: {damage:0, duration:0	}
						
					},
					Soak:
					{
						Acid: { damage: 0, duration: 0 },
						Fire: { damage: 8, duration: 3000 },
						Water:{ damage: 2, duration: 3000 },
						Health:{damage:-20, duration: 0	  },
						Joker :{ damage:50,duration: 0 }
					},
					Stationary:
					{
						Fire: { damage:15, duration: 3000 },
						Acid: { damage:18, duration: 3000 },
						Water:{ damage:25, duration: 3000 },
						Ice:  { damage:9,  duration: 3000 },
						Health:{damage:-25,   duration:0  },
						Joker :{ damage: 50,  duration: 0  }
					}
				},
				Cement:
				{
					Water: { damage:0, duration: 0}
				},
				Glass:
				{
					Freeze:
					{
						Fire:	{	damage: 20, duration: 0}
					},
					Melt:
					{
						Acid:	{	damage: 20, duration: 2000},
						Health: { damage: -30, duration: 0 },
						Joker:	{	damage: 50, duration: 0	  }
					},
					Stationary:
					{
						Acid : {	damage:15, duration:2000  },
						Health: { damage: -30, duration: 0 },
						Joker: {	damage:50, duration:0     }
					}
				},
				Titanium:
				{
					Freeze:
					{
						Fire:	{	damage: 50, duration: 0},
						Melt:	{	damage: 50, duration: 0},
						Joker:	{   damage: 100, duration:0}
					},
					Soak:
					{
						Joker:	{	damage: 50, duration:0}
					},
					Stationary:
					{
						Joker: {	damage:50, duration:0  }
					}
				},
				Wood: 
				{
					Burn:
					{
						Fire: { damage: 12, duration: 3000 },
						Ice:  {	damage: 5,  duration:  1000},
						Water:{ damage:-6,  duration:  3000},
						Health:{damage:-8, duration:  0	   },
						Joker :{ damage: 50,  duration: 0  }
					},
					Freeze:
					{
						Fire: { damage:10, duration:2000 },
						Ice:  { damage:4,  duration:1000 }
					},
					Soak:
					{
						Fire: { damage: 5, duration: 2000 },
						Water:{ damage: 2, duration: 3000 },
						Health:{damage:-10, duration: 0},
						Joker :{ damage: 50,  duration: 0  }
					},
					Stationary:
					{
						Fire: { damage:14, duration: 3000 },
						Water:{ damage:8,  duration: 3000 },
						Ice:  { damage:9,  duration: 3000 },
						Health:{damage:-15, duration:0	  },
						Joker :{ damage: 50,  duration: 0  }
					}
				}
			};
		}
		
		public static function get Properties():Object
		{
			if(!(_properties))
				InitProperties();
			
			return _properties;
		}
		
		public static function GetProperty(blockType:String,state:String,bombEffect:String):Object
		{
			if(Properties[blockType][state])
			{
				if(Properties[blockType][state][bombEffect])
				{
					return Properties[blockType][state][bombEffect];
				}
			}	
			
			return {damage:0, duration:0 }
		}
	}
}