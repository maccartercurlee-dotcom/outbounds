#!/bin/bash
set -e
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'

echo -e "${GREEN}=== НАСТРОЙКА КАСТОМНЫХ АУТБАУНДОВ ===${NC}"

if [ ! -f /etc/x-ui/x-ui.db ]; then
    echo -e "${RED}Ошибка: База данных /etc/x-ui/x-ui.db не найдена!${NC}"
    exit 1
fi

echo -e "${YELLOW}Обновляем шаблон Xray в базе данных...${NC}"

python3 << 'PYEOF'
import sqlite3, json, sys

db_path = '/etc/x-ui/x-ui.db'
conn = sqlite3.connect(db_path)
c = conn.cursor()

# Получаем текущий шаблон
c.execute("SELECT value FROM settings WHERE key='xrayTemplateConfig'")
row = c.fetchone()

if not row:
    print("Ошибка: Ключ xrayTemplateConfig не найден в базе.")
    sys.exit(1)

try:
    current_config = json.loads(row[0])
except json.JSONDecodeError:
    print("Ошибка: В базе битый JSON.")
    sys.exit(1)

# ТВОЙ МАССИВ АУТБАУНДОВ КАК СТРОКА (чтобы не было проблем с true/false)
outbounds_json_str = """
[
  {
    "tag": "direct",
    "protocol": "freedom",
    "settings": {
      "finalRules": [
        {
          "action": "block",
          "ip": [
            "geoip:private"
          ]
        },
        {
          "action": "allow"
        }
      ]
    }
  },
  {
    "tag": "blocked",
    "protocol": "blackhole",
    "settings": {}
  },
  {
    "tag": "Ge",
    "protocol": "vless",
    "settings": {
      "address": "177.3.217.1",
      "port": 443,
      "id": "ce337bdc-a55f-44bd-89da-3bbf9b4d8c5a",
      "flow": "",
      "encryption": "mlkem768x25519plus.native.0rtt.BCY_BaQg7ekWAmzoVwq1TGXOfzpCrVHsbZ2A4vQkbzA"
    },
    "streamSettings": {
      "network": "xhttp",
      "security": "reality",
      "xhttpSettings": {
        "path": "/",
        "mode": "stream-up",
        "xPaddingBytes": "100-1000",
        "sessionIDTable": "Base62",
        "sessionIDLength": "8-16",
        "xmux": {
          "maxConcurrency": "16-32",
          "maxConnections": 0,
          "cMaxReuseTimes": 0,
          "hMaxRequestTimes": "600-900",
          "hMaxReusableSecs": "1800-3000",
          "hKeepAlivePeriod": 0
        }
      },
      "realitySettings": {
        "publicKey": "55_0QqYuVu0IxTt05HRMZIrpkcdaJ2d22xBQry6y3FE",
        "fingerprint": "chrome",
        "serverName": "agema1979.uk",
        "shortId": "5ddd998b",
        "spiderX": "/9cb0cdf556811b5",
        "mldsa65Verify": ""
      }
    }
  },
  {
    "tag": "FL201-FL201",
    "protocol": "vless",
    "settings": {
      "address": "201.58.176.53",
      "port": 443,
      "id": "e9fad515-2fde-4c09-a440-88816db40930",
      "flow": "",
      "encryption": "mlkem768x25519plus.random.0rtt.USFBBkiJm59iHS3Kaci8jihrteYpmVS3oO6t4jav6ns"
    },
    "streamSettings": {
      "network": "xhttp",
      "security": "reality",
      "xhttpSettings": {
        "path": "/",
        "mode": "auto",
        "xPaddingBytes": "100-1000",
        "seqPlacement": "path",
        "scMaxEachPostBytes": "2000000",
        "scMinPostsIntervalMs": "10-20",
        "xmux": {
          "maxConcurrency": "16-32",
          "maxConnections": 0,
          "cMaxReuseTimes": 0,
          "hMaxRequestTimes": "600-900",
          "hMaxReusableSecs": "1800-3000",
          "hKeepAlivePeriod": 30
        }
      },
      "realitySettings": {
        "publicKey": "0M5FsK0WSAlzHTCdHHE6WrK7rJSNOMmA8cjdRBpMh2o",
        "fingerprint": "chrome",
        "serverName": "kielibuusti.fi",
        "shortId": "90552c51",
        "spiderX": "/35df68c75dc4754",
        "mldsa65Verify": ""
      }
    }
  },
  {
    "tag": "fl",
    "protocol": "vless",
    "settings": {
      "address": "212.237.218.31",
      "port": 443,
      "id": "a0aca67d-17f5-4d4c-8ec2-5cd40a5983ae",
      "flow": "",
      "encryption": "mlkem768x25519plus.native.0rtt.SMPdbkF9CePzdwJw6fMrtknIAxNwwSzyUTO5zmjQQjc"
    },
    "streamSettings": {
      "network": "xhttp",
      "security": "reality",
      "xhttpSettings": {
        "path": "/",
        "mode": "stream-one",
        "xPaddingBytes": "100-1000"
      },
      "realitySettings": {
        "publicKey": "-zTVMLmpWPpAbcDg2slqmy1_YdjNUudywmF_DiJ0eQY",
        "fingerprint": "firefox",
        "serverName": "sql.agema1979.uk",
        "shortId": "a3eef4",
        "spiderX": "/b20d2903f6b2f3c",
        "mldsa65Verify": ""
      }
    }
  },
  {
    "tag": "fl3-fl3",
    "protocol": "vless",
    "settings": {
      "address": "2.26.87.132",
      "port": 443,
      "id": "656a2055-4d6a-4c9c-a7ff-8cc184bb8944",
      "flow": "",
      "encryption": "mlkem768x25519plus.native.0rtt.lE2oPQMtL6nEZ7IgeX4XmnMvWnLl4z2zNWRFa_gSyyk"
    },
    "streamSettings": {
      "network": "xhttp",
      "security": "reality",
      "xhttpSettings": {
        "path": "/",
        "mode": "stream-one",
        "xPaddingBytes": "66-567"
      },
      "realitySettings": {
        "publicKey": "EQtkrSZmpvADdNkQ83DnzGE2PG0PfzkJUdDD3SPKBlA",
        "fingerprint": "firefox",
        "serverName": "agema1979.uk",
        "shortId": "4d9f",
        "spiderX": "/7058ba13df36059",
        "mldsa65Verify": ""
      }
    }
  },
  {
    "tag": "out-vps2-masque",
    "protocol": "masque",
    "settings": {
      "address": "212.237.218.31",
      "port": 443
    },
    "streamSettings": {
      "network": "masque",
      "masqueSettings": {
        "path": "/.well-known/masque/ip/*/*/",
        "user": "masq",
        "pass": "0144817102"
      },
      "security": "tls",
      "tlsSettings": {
        "serverName": "sql.agema1979.uk",
        "minVersion": "1.3",
        "maxVersion": "1.3",
        "enableSessionResumption": true,
        "alpn": [
          "h3"
        ],
        "fingerprint": "firefox"
      }
    }
  },
  {
    "tag": "default@sqlhl.agema1979.uk",
    "protocol": "vless",
    "settings": {
      "address": "2.27.204.151",
      "port": 443,
      "id": "b3ca5594-1a02-45c6-b335-65fb962cf72d",
      "flow": "",
      "encryption": "none"
    },
    "streamSettings": {
      "network": "xhttp",
      "security": "reality",
      "xhttpSettings": {
        "path": "/api/v3/stream",
        "mode": "stream-one",
        "xPaddingBytes": "100-1000"
      },
      "realitySettings": {
        "publicKey": "MECkG-92WICQYfCHGSEb2uMzFWEf807_xf9thu9A9D0",
        "fingerprint": "firefox",
        "serverName": "sqlhl.agema1979.uk",
        "shortId": "1b3020",
        "spiderX": "/654c4c33ed5d438",
        "mldsa65Verify": ""
      }
    }
  }
]
"""

new_outbounds = json.loads(outbounds_json_str)

# Подменяем аутбаунды
current_config["outbounds"] = new_outbounds

# Сохраняем в БД
new_json = json.dumps(current_config, ensure_ascii=False)
c.execute("UPDATE settings SET value=? WHERE key='xrayTemplateConfig'", (new_json,))
conn.commit()
conn.close()
print("\033[0;32mТвои аутбаунды успешно вшиты в базу! \033[0m")
PYEOF

echo -e "${YELLOW}Перезапускаем панель и Xray...${NC}"
systemctl restart x-ui
sleep 3

echo -e "${GREEN}=== ГОТОВО ===${NC}"
echo -e "Статус Xray:"
x-ui status | grep -E "Panel state|Xray state"
