module.exports = (fns...) -> (value) ->
    fns.reduceRight(((acc, fn) -> fn(acc)), value)
