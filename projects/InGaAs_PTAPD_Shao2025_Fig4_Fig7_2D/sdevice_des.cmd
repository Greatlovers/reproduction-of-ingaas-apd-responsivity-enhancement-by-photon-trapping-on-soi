#setdep @previous@
File {
  Grid = "@tdr@"
  Parameter = "sdevice.par"
  Plot = "@tdrdat@"
  Current = "@plot@"
  Output = "@log@"
#if "@Mode@" == "Light" || "@Mode@" == "Power"
  OpticalGenerationInput = "generation_@Geometry@_@Lambda_nm@.tdr"
#endif
}
Electrode {
  {Name="anode" Voltage=0}
  {Name="cathode" Voltage=0}
}
Physics {
  DefaultParametersFromFile
  Temperature=300
  AreaFactor=1
  Fermi
  Thermionic
  EffectiveIntrinsicDensity(NoBandGapNarrowing)
  Mobility(eHighFieldSaturation(GradQuasiFermi) hHighFieldSaturation(GradQuasiFermi))
  Recombination(SRH Auger Radiative Avalanche(vanOverstraeten GradQuasiFermi))
#if "@Mode@" == "Light" || "@Mode@" == "Power"
  Optics(
    OpticalGeneration(
      QuantumYield(StepFunction(EffectiveBandgap))
      Scaling=0
      ReadFromFile(DatasetName=AbsorbedPhotonDensity)
    )
  )
#endif
}
Physics(MaterialInterface="InGaAs/SU8") {Recombination(SurfaceSRH)}
Plot {
  ElectricField/Vector Potential SpaceCharge
  eDensity hDensity eCurrent/Vector hCurrent/Vector TotalCurrent/Vector
  eMobility hMobility eQuasiFermi hQuasiFermi
  Doping DonorConcentration AcceptorConcentration
  ConductionBand ValenceBand BandGap Affinity
  SRHRecombination AugerRecombination RadiativeRecombination
  AvalancheGeneration eAvalancheGeneration hAvalancheGeneration
  OpticalGeneration AbsorbedPhotonDensity SurfaceRecombination
  xMoleFraction yMoleFraction
}
CurrentPlot {
  ElectricField(Maximum(Region="R.Multiplier"))
  OpticalGeneration(Integrate(Semiconductor))
  AvalancheGeneration(Integrate(Semiconductor))
  SRHRecombination(Integrate(Semiconductor))
}
Math {
  Extrapolate
  Derivatives
  AvalDerivatives
  RelErrControl
  Digits=5
  ErrRef(Electron)=1e8
  ErrRef(Hole)=1e8
  Iterations=40
  NotDamped=100
  ExtendedPrecision(80)
  NumberOfThreads=1
  Method=Super
  RHSMin=1e-18
  RefDens_eGradQuasiFermi_ElectricField_HFS=1e12
  RefDens_hGradQuasiFermi_ElectricField_HFS=1e12
  RefDens_eGradQuasiFermi_ElectricField=1e12
  RefDens_hGradQuasiFermi_ElectricField=1e12
}
Solve {
  Coupled(Iterations=150 LineSearchDamping=1e-4) {Poisson}
  Coupled(Iterations=100 LineSearchDamping=1e-3) {Poisson Electron Hole}
#if "@Mode@" == "Light" || "@Mode@" == "Power"
  Quasistationary(InitialStep=0.01 Increment=1.4 MinStep=1e-8 MaxStep=0.2
    Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=@<PhotoPower_uW*1e-6/(3.141592653589793*5.2*5.2*1e-8)>@}
  ) {Coupled {Poisson Electron Hole}}
#endif
  NewCurrentPrefix="n@node@_IV_"
  Quasistationary(InitialStep=0.0005 Increment=1.3 MinStep=1e-8 MaxStep=0.015
    Goal{Name="anode" Voltage=@<0-Bias_V>@}
  ) {
    Coupled {Poisson Electron Hole}
    CurrentPlot(Time=(Range=(0 1) Intervals=100))
  }
  Plot(FilePrefix="n@node@_endpoint" NoOverWrite)
  Save(FilePrefix="n@node@_endpoint")
}
