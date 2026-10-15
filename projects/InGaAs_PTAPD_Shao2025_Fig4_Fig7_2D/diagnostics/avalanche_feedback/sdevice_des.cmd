
File {
  Grid = "mesh_@Geometry@.tdr"
  Parameter = "sdevice.par"
  Plot = "@tdrdat@"
  Current = "@plot@"
  Output = "@log@"
#if "@Mode@" == "Light" || "@Mode@" == "Collection" || "@Mode@" == "Power"
  OpticalGenerationInput = "generation_@Geometry@_@Lambda_nm@_angle@Angle_deg@.tdr"
#endif
}
Electrode {
  #if "@Mode@" == "Dark" || "@Mode@" == "Light"
  {Name="anode" Voltage=0 Resistor=1e7}
#else
  {Name="anode" Voltage=0}
#endif
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
  Recombination(SRH Auger Radiative
#if "@Mode@" == "Dark" || "@Mode@" == "Light" || "@Mode@" == "FieldAvalanche"
    Avalanche(vanOverstraeten GradQuasiFermi)
#endif
  )
#if "@Mode@" == "Light" || "@Mode@" == "Collection" || "@Mode@" == "Power"
  Optics(
    Excitation(Wavelength=@<Lambda_nm*1e-3>@)
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
#if "@Mode@" == "Power"
  NewCurrentPrefix="n@node@_DARK_"
  Quasistationary(InitialStep=0.0005 Increment=1.3 MinStep=1e-8 MaxStep=0.01 Goal{Name="anode" Voltage=@<0-Bias_V>@}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n@node@_power_dark" NoOverWrite)
  NewCurrentPrefix="n@node@_P0_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=@<0.1023*1e-6*1.875/(3.141592653589793*5.2*5.2*RefPower_W)>@}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n@node@_power0" NoOverWrite)
  NewCurrentPrefix="n@node@_P1_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=@<0.3235936569296281*1e-6*1.875/(3.141592653589793*5.2*5.2*RefPower_W)>@}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n@node@_power1" NoOverWrite)
  NewCurrentPrefix="n@node@_P2_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=@<1.023*1e-6*1.875/(3.141592653589793*5.2*5.2*RefPower_W)>@}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n@node@_power2" NoOverWrite)
  NewCurrentPrefix="n@node@_P3_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=@<3.235936569296281*1e-6*1.875/(3.141592653589793*5.2*5.2*RefPower_W)>@}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n@node@_power3" NoOverWrite)
  NewCurrentPrefix="n@node@_P4_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=@<10.23*1e-6*1.875/(3.141592653589793*5.2*5.2*RefPower_W)>@}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n@node@_power4" NoOverWrite)
#else
#if "@Mode@" == "Light"
  Quasistationary(InitialStep=0.01 Increment=1.4 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=@<PhotoPower_uW*1e-6*1.875/(3.141592653589793*5.2*5.2*RefPower_W)>@}) {Coupled{Poisson Electron Hole}}
#endif
  NewCurrentPrefix="n@node@_IV_"
  Quasistationary(InitialStep=0.0005 Increment=1.3 MinStep=1e-8 MaxStep=0.006
    BreakCriteria{Current(Contact="cathode" AbsVal=3e-7)}
    Goal{Name="anode" Voltage=@<0-Bias_V>@}
  ) {Coupled{Poisson Electron Hole}}
#endif
  Plot(FilePrefix="n@node@_endpoint" NoOverWrite)
  Save(FilePrefix="n@node@_endpoint")
}
