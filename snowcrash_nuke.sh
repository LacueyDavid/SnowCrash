
#!/bin/bash

HOST="localhost"
PORT="4242"
CURRENT_PASS="level00"

for i in {0..14}
do
    LEVEL_USER=$(printf "level%02d" $i)
    TARGET_UID=$((3000 + i))
    
    echo -n "[$LEVEL_USER] -> "

    RAW_OUTPUT=$(sshpass -p "$CURRENT_PASS" ssh -q -o StrictHostKeyChecking=no -p "$PORT" "$LEVEL_USER@$HOST" \
      "gdb -q -nx /bin/getflag \
      -ex 'set pagination off' \
      -ex 'set confirm off' \
      -ex 'break *0x804898e' \
      -ex run \
    -ex 'set \$eax = 0' \
      -ex 'break *0x8048b06' \
      -ex continue \
    -ex 'set \$eax = $TARGET_UID' \
    -ex 'set *(int*)(\$esp+0x18) = $TARGET_UID' \
      -ex continue \
      -ex quit")

    NEW_TOKEN=$(echo "$RAW_OUTPUT" | grep -i "Check flag" | sed -E 's/.*token[[:space:]]*:[[:space:]]*([^[:space:]]+).*/\1/' | tail -n1 | tr -d '\r')

    if [ -z "$NEW_TOKEN" ]; then
      echo "ERROR: Could not extract token."
        break
    else
        echo "TOKEN : $NEW_TOKEN"
        CURRENT_PASS="$NEW_TOKEN"
    fi
done
