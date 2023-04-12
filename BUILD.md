
## Build steps

1. Build Docker image:

```
docker build -t openmagnetics .
```

2. Enter built Docker image:

```
docker run -it openmagnetics bash
```

3. Run tests:

```
/home/openmagnetics/OpenMagnetics/MAS
./MAS_tests
/home/openmagnetics/OpenMagnetics/MKF
./MKF_tests
/home/openmagnetics/OpenMagnetics/MVB
python3 tests/test_builder.py
```
