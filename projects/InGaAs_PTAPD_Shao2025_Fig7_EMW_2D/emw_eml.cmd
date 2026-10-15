* Shao 2025 Fig.2 2D three-slot optical baseline, eta=1.
Globals {
  GridFile = "mesh_@Geometry@.tdr"
  ParameterFile = "emw.par"
  ResultFile = "@plot@"
  LogFile = "@log@"
  NumberOfThreads = 1
  TotalSimulationTime = 1.5e-12
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
  Theta = @Angle_deg@
  Polarization = TM
  Wavelength = @Lambda_nm@
  Intensity = 1.0
  NRise = 8
}
* Explicit Y-depth sensors avoid UCS/DF-ISE top-axis ambiguity.
* Phi_incident = Phi_total_below_source - Phi_reflected_signed.
Sensor {
  Name = "IncidentTotal"
  Quantity = PhotonFluxDensity
  PlaneY = -1.05
  Mode = {Integrate}
}
Sensor {
  Name = "Reflected"
  Quantity = PhotonFluxDensity
  PlaneY = min
  Mode = {Integrate}
}
Sensor {
  Name = "Transmitted"
  Quantity = PhotonFluxDensity
  PlaneY = max
  Mode = {Integrate}
}
Sensor {
  Name = "AbsorbedTotal"
  Quantity = AbsorbedPhotonDensity
  BoxCorner1 = {min,min,0}
  BoxCorner2 = {max,max,0}
  Mode = {Integrate}
}
Sensor {
  Name = "AbsorberPhotons"
  Quantity = AbsorbedPhotonDensity
  Region = {"R.Absorber"}
  Mode = {Integrate}
  DOE = Yes
  DOEPrecision = 10
}
Sensor {
  Name = "AbsorberPower"
  Quantity = AbsorbedPowerDensity
  Region = {"R.Absorber"}
  Mode = {Integrate}
  DOE = Yes
  DOEPrecision = 10
}
Sensor {
  Name = "AllInGaAsPhotons"
  Quantity = AbsorbedPhotonDensity
  Material = {"InGaAs"}
  Mode = {Integrate}
  DOE = Yes
  DOEPrecision = 10
}
Extractor {
  Name="n@node@_generation"
  BoxCorner1={min,-0.7,0}
  BoxCorner2={max,0,0}
  Quantity={AbsorbedPhotonDensity,AbsorbedPowerDensity,Region}
}
