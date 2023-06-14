## run calert on host machine running prometheus alertmanager

```bash
./calert.bin --config config.toml
```

## Test it with curl command 
```bash
curl <ip>:6000
```

## Expect the following output
``` json
{"status":"success","data":"welcome to calert!"}
```

