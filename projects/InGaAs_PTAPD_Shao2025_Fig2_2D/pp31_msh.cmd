IOControls {
  EnableSections
  EnableEMW
  inputFile = "n29_bnd.tdr"
  outputFile = "n31_msh.tdr"
}
Tensor {
  Mesh {
    maxCellSize = 0.025
    minCellSize = 0.005
    maxBndCellSize = 0.025
    minBndCellSize = 0.005
    grading off
  }
  EMW {
    parameter filename = "emw.par"
    wavelength = 1.520
    ComplexRefractiveIndex WavelengthDep Real Imag
    NPW = 12
    grading off
  }
}

