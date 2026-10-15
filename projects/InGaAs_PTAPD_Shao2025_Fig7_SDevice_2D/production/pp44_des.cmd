
File {
  Grid = "mesh_Slanted.tdr"
  Parameter = "sdevice.par"
  Plot = "n44_des.tdr"
  Current = "n44_des.plt"
  Output = "n44_des.log"
  OpticalGenerationInput = "generation_Slanted_1626_angle0.tdr"
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
  Recombination(SRH Auger Radiative
  )
  Optics(
    Excitation(Wavelength=1.626)
    OpticalGeneration(
      QuantumYield(StepFunction(EffectiveBandgap))
      Scaling=0
      ReadFromFile(DatasetName=AbsorbedPhotonDensity
      ImportDomain(
        SourceRegions=("R.Absorber" "R.NContact"
          "R.PContact_lump_1" "R.PContact_lump_2" "R.PContact_lump_3" "R.PContact_lump_4"
        )
        DestinationRegions=("R.Absorber" "R.NContact"
          "R.PContact_lump_1" "R.PContact_lump_2" "R.PContact_lump_3" "R.PContact_lump_4"
        )
      )
    )
    )
  )
}
Physics(MaterialInterface="InGaAs/SU8") {Recombination(SurfaceSRH)}
Plot {
  QuantumYield
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
  NewCurrentPrefix="n44_DARK_"
  Quasistationary(InitialStep=0.0005 Increment=1.3 MinStep=1e-8 MaxStep=0.01 Goal{Name="anode" Voltage=-20}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n44_power_dark" NoOverWrite)
  NewCurrentPrefix="n44_P0_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=0.12051244198}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n44_power0" NoOverWrite)
  NewCurrentPrefix="n44_P1_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=0.381202950204}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n44_power1" NoOverWrite)
  NewCurrentPrefix="n44_P2_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=1.2051244198}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n44_power2" NoOverWrite)
  NewCurrentPrefix="n44_P3_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=3.81202950204}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n44_power3" NoOverWrite)
  NewCurrentPrefix="n44_P4_"
  Quasistationary(InitialStep=0.02 Increment=1.5 MinStep=1e-8 MaxStep=0.2 Goal{ModelParameter="Optics/OpticalGeneration/Scaling" Value=12.051244198}) {Coupled{Poisson Electron Hole}}
  Plot(FilePrefix="n44_power4" NoOverWrite)
  Plot(FilePrefix="n44_endpoint" NoOverWrite)
  Save(FilePrefix="n44_endpoint")
}

