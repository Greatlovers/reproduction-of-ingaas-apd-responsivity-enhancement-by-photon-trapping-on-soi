Title "Untitled"

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "MoleInGaAs" {
		Species = "xMoleFraction"
		Value = 0.47
	}
	Constant "P0" {
		Species = "BoronActiveConcentration"
		Value = 5e+18
	}
	Constant "P1" {
		Species = "BoronActiveConcentration"
		Value = 5e+18
	}
	Constant "P2" {
		Species = "BoronActiveConcentration"
		Value = 5e+18
	}
	Constant "P3" {
		Species = "BoronActiveConcentration"
		Value = 5e+18
	}
	Constant "Gx0" {
		Species = "xMoleFraction"
		Value = 0.03
	}
	Constant "Gy0" {
		Species = "yMoleFraction"
		Value = 0.529375
	}
	Constant "Gx1" {
		Species = "xMoleFraction"
		Value = 0.09
	}
	Constant "Gy1" {
		Species = "yMoleFraction"
		Value = 0.528125
	}
	Constant "Gx2" {
		Species = "xMoleFraction"
		Value = 0.15
	}
	Constant "Gy2" {
		Species = "yMoleFraction"
		Value = 0.526875
	}
	Constant "Gx3" {
		Species = "xMoleFraction"
		Value = 0.21
	}
	Constant "Gy3" {
		Species = "yMoleFraction"
		Value = 0.525625
	}
	Constant "Gx4" {
		Species = "xMoleFraction"
		Value = 0.27
	}
	Constant "Gy4" {
		Species = "yMoleFraction"
		Value = 0.524375
	}
	Constant "Gx5" {
		Species = "xMoleFraction"
		Value = 0.33
	}
	Constant "Gy5" {
		Species = "yMoleFraction"
		Value = 0.523125
	}
	Constant "Gx6" {
		Species = "xMoleFraction"
		Value = 0.39
	}
	Constant "Gy6" {
		Species = "yMoleFraction"
		Value = 0.521875
	}
	Constant "Gx7" {
		Species = "xMoleFraction"
		Value = 0.45
	}
	Constant "Gy7" {
		Species = "yMoleFraction"
		Value = 0.520625
	}
	Constant "ChargeP" {
		Species = "BoronActiveConcentration"
		Value = 7.5e+17
	}
	Constant "ContactN" {
		Species = "ArsenicActiveConcentration"
		Value = 5e+18
	}
	Constant "MoleInAlAs" {
		Species = "xMoleFraction"
		Value = 0.48
	}
	Refinement "Ref.Global" {
		MaxElementSize = ( 0.25 0.25 )
		MinElementSize = ( 0.02 0.0125 )
	}
	Refinement "Ref.Epi" {
		MaxElementSize = ( 0.075 0.04 )
		MinElementSize = ( 0.012 0.01 )
		RefineFunction = MaxLenInt(Interface("InGaAs","SU8"), Value=0.025, factor=1.8, DoubleSide)
		RefineFunction = MaxLenInt(Interface("InAlAs","AlInGaAs"), Value=0.03, factor=1.8, DoubleSide)
	}
	Refinement "RefG0" {
		MaxElementSize = ( 0.08 0.00625 )
		MinElementSize = ( 0.025 0.00625 )
	}
	Refinement "RefG1" {
		MaxElementSize = ( 0.08 0.00625 )
		MinElementSize = ( 0.025 0.00625 )
	}
	Refinement "RefG2" {
		MaxElementSize = ( 0.08 0.00625 )
		MinElementSize = ( 0.025 0.00625 )
	}
	Refinement "RefG3" {
		MaxElementSize = ( 0.08 0.00625 )
		MinElementSize = ( 0.025 0.00625 )
	}
	Refinement "RefG4" {
		MaxElementSize = ( 0.08 0.00625 )
		MinElementSize = ( 0.025 0.00625 )
	}
	Refinement "RefG5" {
		MaxElementSize = ( 0.08 0.00625 )
		MinElementSize = ( 0.025 0.00625 )
	}
	Refinement "RefG6" {
		MaxElementSize = ( 0.08 0.00625 )
		MinElementSize = ( 0.025 0.00625 )
	}
	Refinement "RefG7" {
		MaxElementSize = ( 0.08 0.00625 )
		MinElementSize = ( 0.025 0.00625 )
	}
}

Placements {
	Constant "PPlace0" {
		Reference = "P0"
		EvaluateWindow {
			Element = region ["R.PContact0"]
		}
	}
	Constant "PMole0" {
		Reference = "MoleInGaAs"
		EvaluateWindow {
			Element = region ["R.PContact0"]
		}
	}
	Constant "PPlace1" {
		Reference = "P1"
		EvaluateWindow {
			Element = region ["R.PContact1"]
		}
	}
	Constant "PMole1" {
		Reference = "MoleInGaAs"
		EvaluateWindow {
			Element = region ["R.PContact1"]
		}
	}
	Constant "PPlace2" {
		Reference = "P2"
		EvaluateWindow {
			Element = region ["R.PContact2"]
		}
	}
	Constant "PMole2" {
		Reference = "MoleInGaAs"
		EvaluateWindow {
			Element = region ["R.PContact2"]
		}
	}
	Constant "PPlace3" {
		Reference = "P3"
		EvaluateWindow {
			Element = region ["R.PContact3"]
		}
	}
	Constant "PMole3" {
		Reference = "MoleInGaAs"
		EvaluateWindow {
			Element = region ["R.PContact3"]
		}
	}
	Constant "AbsMole" {
		Reference = "MoleInGaAs"
		EvaluateWindow {
			Element = region ["R.Absorber"]
		}
	}
	Constant "Gx0Place" {
		Reference = "Gx0"
		EvaluateWindow {
			Element = region ["R.Grading0"]
		}
	}
	Constant "Gy0Place" {
		Reference = "Gy0"
		EvaluateWindow {
			Element = region ["R.Grading0"]
		}
	}
	Constant "Gx1Place" {
		Reference = "Gx1"
		EvaluateWindow {
			Element = region ["R.Grading1"]
		}
	}
	Constant "Gy1Place" {
		Reference = "Gy1"
		EvaluateWindow {
			Element = region ["R.Grading1"]
		}
	}
	Constant "Gx2Place" {
		Reference = "Gx2"
		EvaluateWindow {
			Element = region ["R.Grading2"]
		}
	}
	Constant "Gy2Place" {
		Reference = "Gy2"
		EvaluateWindow {
			Element = region ["R.Grading2"]
		}
	}
	Constant "Gx3Place" {
		Reference = "Gx3"
		EvaluateWindow {
			Element = region ["R.Grading3"]
		}
	}
	Constant "Gy3Place" {
		Reference = "Gy3"
		EvaluateWindow {
			Element = region ["R.Grading3"]
		}
	}
	Constant "Gx4Place" {
		Reference = "Gx4"
		EvaluateWindow {
			Element = region ["R.Grading4"]
		}
	}
	Constant "Gy4Place" {
		Reference = "Gy4"
		EvaluateWindow {
			Element = region ["R.Grading4"]
		}
	}
	Constant "Gx5Place" {
		Reference = "Gx5"
		EvaluateWindow {
			Element = region ["R.Grading5"]
		}
	}
	Constant "Gy5Place" {
		Reference = "Gy5"
		EvaluateWindow {
			Element = region ["R.Grading5"]
		}
	}
	Constant "Gx6Place" {
		Reference = "Gx6"
		EvaluateWindow {
			Element = region ["R.Grading6"]
		}
	}
	Constant "Gy6Place" {
		Reference = "Gy6"
		EvaluateWindow {
			Element = region ["R.Grading6"]
		}
	}
	Constant "Gx7Place" {
		Reference = "Gx7"
		EvaluateWindow {
			Element = region ["R.Grading7"]
		}
	}
	Constant "Gy7Place" {
		Reference = "Gy7"
		EvaluateWindow {
			Element = region ["R.Grading7"]
		}
	}
	Constant "ChargePlace" {
		Reference = "ChargeP"
		EvaluateWindow {
			Element = region ["R.Charge"]
		}
	}
	Constant "ContactNPlace" {
		Reference = "ContactN"
		EvaluateWindow {
			Element = region ["R.NContact"]
		}
	}
	Constant "ChargeMole" {
		Reference = "MoleInAlAs"
		EvaluateWindow {
			Element = region ["R.Charge"]
		}
	}
	Constant "MultMole" {
		Reference = "MoleInAlAs"
		EvaluateWindow {
			Element = region ["R.Multiplier"]
		}
	}
	Constant "NMole" {
		Reference = "MoleInGaAs"
		EvaluateWindow {
			Element = region ["R.NContact"]
		}
	}
	Refinement "Place.Global" {
		Reference = "Ref.Global"
		RefineWindow = Rectangle [(-0.9375 -3.02) (0.9375 0.8)]
	}
	Refinement "Place.Epi" {
		Reference = "Ref.Epi"
		RefineWindow = Rectangle [(-0.9375 0) (0.9375 0.7)]
	}
	Refinement "PlaceG0" {
		Reference = "RefG0"
		RefineWindow = region ["R.Grading0"]
	}
	Refinement "PlaceG1" {
		Reference = "RefG1"
		RefineWindow = region ["R.Grading1"]
	}
	Refinement "PlaceG2" {
		Reference = "RefG2"
		RefineWindow = region ["R.Grading2"]
	}
	Refinement "PlaceG3" {
		Reference = "RefG3"
		RefineWindow = region ["R.Grading3"]
	}
	Refinement "PlaceG4" {
		Reference = "RefG4"
		RefineWindow = region ["R.Grading4"]
	}
	Refinement "PlaceG5" {
		Reference = "RefG5"
		RefineWindow = region ["R.Grading5"]
	}
	Refinement "PlaceG6" {
		Reference = "RefG6"
		RefineWindow = region ["R.Grading6"]
	}
	Refinement "PlaceG7" {
		Reference = "RefG7"
		RefineWindow = region ["R.Grading7"]
	}
}

