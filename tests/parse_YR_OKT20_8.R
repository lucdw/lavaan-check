test.id <- 'parse_YR_OKT20_8'
lavaan.model <- '

# factor loadings (lambda)
trait1 =~ start(1) * L1 * i1i2 + start(1) * L1 * i1i3 + start(1) * L4 * i4i5 + start(1) * L4 * i4i6 + start(1) * L7 * i7i8 + start(1) * L7 * i7i9 + start(1) * L10 * i10i11 + start(1) * L10 * i10i12
trait2 =~ start(-1) * L2n * i1i2 + start(1) * L2 * i2i3 + start(-1) * L5n * i4i5 + start(1) * L5 * i5i6 + start(-1) * L8n * i7i8 + start(1) * L8 * i8i9 + start(-1) * L11n * i10i11 + start(1) * L11 * i11i12
trait3 =~ start(-1) * L3n * i1i3 + start(-1) * L3n * i2i3 + start(-1) * L6n * i4i6 + start(-1) * L6n * i5i6 + start(-1) * L9n * i7i9 + start(-1) * L9n * i8i9 + start(-1) * L12n * i10i12 + start(-1) * L12n * i11i12
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
