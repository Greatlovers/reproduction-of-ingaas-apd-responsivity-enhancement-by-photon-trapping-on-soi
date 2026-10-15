* Shao 2025 Figure 3: physical-time optical field snapshots, 2D three slots.
* Same geometry, optical constants, illumination direction and NRise as Figure 2.
Globals {
  GridFile = "mesh_20nm.tdr"
  ParameterFile = "emw.par"
  ResultFile = "n13_eml.plt"
  LogFile = "n13_eml.log"
  NumberOfThreads = 1
  TimeStep = 1e-17
  TotalTimeSteps = 2680
  TdrNativeTensorGridUnit = um
}
ComplexRefractiveIndex {
  WavelengthDep = {Real,Imag}
}
Boundary {
  Type = PeriodicOblique
  Sides = {X}
}
Boundary {
  Type = CPML
  Sides = {Y}
  Thickness = 15
}
PlaneWaveExcitation {
  PlaneY = -1.25
  Theta = 0
  Polarization = TM
  Wavelength = 1615
  Intensity = 1.0
  Signal = Harmonic
  Delay = 0
  NRise = 8
}
* Final Plot at the requested native FDTD endpoint; independent start from t=0.
Plot {
  Name = "n13_field"
  BoxCorner1 = {min,-0.7,0}
  BoxCorner2 = {max,0.52,0}
  Quantity = {RealElectricFieldX,RealElectricFieldY,RealElectricFieldZ,ImagElectricFieldX,ImagElectricFieldY,ImagElectricFieldZ,Region}
  FinalPlot = Yes
}
Monitor {
  Name = "SourcePlane"
  Location = {0,-1.25,0}
  Quantity = {RealElectricFieldZ,ImagElectricFieldZ,AbsElectricField}
  TickStep = 25
}
Monitor {
  Name = "Multiplier"
  Location = {0,-0.55,0}
  Quantity = {RealElectricFieldZ,ImagElectricFieldZ,AbsElectricField}
  TickStep = 25
}
Monitor {
  Name = "AbsorberCenter"
  Location = {0,-0.275,0}
  Quantity = {RealElectricFieldZ,ImagElectricFieldZ,AbsElectricField}
  TickStep = 25
}
Monitor {
  Name = "HoleBottomEdge"
  Location = {0.26,-0.02,0}
  Quantity = {RealElectricFieldZ,ImagElectricFieldZ,AbsElectricField}
  TickStep = 25
}
Monitor {
  Name = "SU8Bond"
  Location = {0,0.15,0}
  Quantity = {RealElectricFieldZ,ImagElectricFieldZ,AbsElectricField}
  TickStep = 25
}
Monitor {
  Name = "SOISilicon"
  Location = {0,0.40,0}
  Quantity = {RealElectricFieldZ,ImagElectricFieldZ,AbsElectricField}
  TickStep = 25
}

