# docker-image--smatch
container with smatch (syntax checker for C) 


## Usage examples

Run smatch kernel check and save result at the source directory
```
docker run -v /devel/my_kernel_src:/bld/src -e BLD_RESULT=/bld/src \
       dmonakhov/bld-smatch smatch_test_kernel

# See check results
ls -lh /devel/my_kernel_src/smatch.warn.log
cat /devel/my_kernel_src/smatch.warn.env
```

## Environment variables

- `BLD_SOURCE		default: /bld/src`
- `BLD_RESULT		default: /bld/result}`
- `BLD_SMATCH_LOG	default: {BLD_RESULT}/smatch.log}`
- `BLD_SMATCH_WLOG	default: {BLD_RESULT}/smatch.warn.log}`
- `BLD_SMATCH_WLOG_ENV	default: {BLD_RESULT}/smatch.warn.env}`
