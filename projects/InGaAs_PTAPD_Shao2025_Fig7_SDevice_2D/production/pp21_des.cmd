
File {
  Grid = "mesh_Slanted.tdr"
  Parameter = "sdevice.par"
  Plot = "n21_des.tdr"
  Current = "n21_des.plt"
  Output = "n21_des.log"
}
Electrode {
  {Name="anode" Voltage=0 Resistor=1e7}
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
    Avalanche(vanOverstraeten GradQuasiFermi)
  )
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
  NewCurrentPrefix="n21_IV_"
  Quasistationary(InitialStep=0.0005 Increment=1.3 MinStep=1e-8 MaxStep=0.006
    BreakCriteria{Current(Contact="cathode" AbsVal=3e-7)}
    Goal{Name="anode" Voltage=-28}
  ) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n21_endpoint" NoOverWrite)
  Save(FilePrefix="n21_endpoint")
}

