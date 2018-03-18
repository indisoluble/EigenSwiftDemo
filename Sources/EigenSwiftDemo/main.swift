import Accelerate

typealias LPInt = __CLPK_integer
typealias LPDouble = __CLPK_doublereal
typealias LPComplex = __CLPK_doublecomplex

var n = LPInt(3)
var lda = n
var w = Array(repeating: LPDouble(0), count: Int(n))

/*
 Hermitian Matrix a:
 ┌                               ┐
 | (2 + 0*i) (0 + 1*i) (0 + 0*i) |
 | (0 - 1*i) (2 + 0*i) (0 + 0*i) |
 | (0 + 0*i) (0 + 0*i) (3 + 0*i) |
 └                               ┘
 */
var a = [
    LPComplex(r: 2.0, i: 0.0), LPComplex(r: 0.0, i: -1.0), LPComplex(r: 0.0, i: 0.0),
    LPComplex(r: 0.0, i: 1.0), LPComplex(r: 2.0, i:  0.0), LPComplex(r: 0.0, i: 0.0),
    LPComplex(r: 0.0, i: 0.0), LPComplex(r: 0.0, i:  0.0), LPComplex(r: 3.0, i: 0.0)
] // stored columnwise

var jobz = Int8(86) // V: Compute eigenvalues and eigenvectors
var uplo = Int8(76) // L: Lower triangular part

// Get optimal workspace
var tmpWork = LPComplex()
var lengthTmpWork = LPInt(-1)
var tmpRWork = LPDouble()
var lengthTmpRWork = LPInt(-1)
var tmpIWork = LPInt(0)
var lengthTmpIWork = LPInt(-1)
var info = LPInt(0)

zheevd_(&jobz, &uplo, &n, &a, &lda, &w, &tmpWork, &lengthTmpWork, &tmpRWork, &lengthTmpRWork, &tmpIWork, &lengthTmpIWork, &info)

// Compute eigenvalues & eigenvectors
var lengthWork = LPInt(tmpWork.r)
var work = Array(repeating: LPComplex(), count: Int(lengthWork))
var lengthRWork = LPInt(tmpRWork)
var rWork = Array(repeating: LPDouble(0), count: Int(lengthRWork))
var lengthIWork = tmpIWork
var iWork = Array(repeating: LPInt(0), count: Int(lengthIWork))

zheevd_(&jobz, &uplo, &n, &a, &lda, &w, &work, &lengthWork, &rWork, &lengthRWork, &iWork, &lengthIWork, &info)
if (info > 0) {
    print("ERROR: Failed to compute eigenvalues & eigenvectors")

    exit(1)
}

print("Eigenvalues: \(w)")
print("Eigenvectors (stored columnwise): \(a)")
