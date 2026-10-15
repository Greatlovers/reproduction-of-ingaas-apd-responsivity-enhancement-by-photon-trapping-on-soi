IOControls {
  EnableSections
  EnableEMW
  inputFile = "n29_bnd.tdr"
  outputFile = "n61_msh.tdr"
}
Tensor {
  Mesh {
    maxCellSize = 0.02
    minCellSize = 0.004
    maxBndCellSize = 0.02
    minBndCellSize = 0.004
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

