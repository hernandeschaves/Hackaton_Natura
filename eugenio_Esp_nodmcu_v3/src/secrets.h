#include <pgmspace.h>

#define SECRET

const char ssid[] = "I Am Batman";
const char pass[] = "brothers05";

#define THINGNAME "bebbe0b9-37b4-47da-9bb4-3d5cbb444309"

int8_t TIME_ZONE = -3;
//#define USE_SUMMER_TIME_DST  // descomente se voce estiver em horario de verãonce

const char MQTT_HOST[] = "logicalis-eugeniostg-iothub.azure-devices.net";
const char MQTT_USER[] = "logicalis-eugeniostg-iothub.azure-devices.net/" THINGNAME "/api-version=2017-06-30";
const int MQTT_PORT = 8883;
const char MQTT_SUB_TOPIC[] = "$iothub/methods/POST/#";
const char MQTT_PUB_TOPIC[] = "devices/" THINGNAME "/messages/events/";


// Copie aqui o seu certificado CA do EUGENIO (ex: CAxxxxx.pem) ▼
static const char cacert[] PROGMEM = \
"-----BEGIN CERTIFICATE-----\n" \
"MIIDdzCCAl+gAwIBAgIEAgAAuTANBgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJJ\n" \
"RTESMBAGA1UEChMJQmFsdGltb3JlMRMwEQYDVQQLEwpDeWJlclRydXN0MSIwIAYD\n" \
"VQQDExlCYWx0aW1vcmUgQ3liZXJUcnVzdCBSb290MB4XDTAwMDUxMjE4NDYwMFoX\n" \
"DTI1MDUxMjIzNTkwMFowWjELMAkGA1UEBhMCSUUxEjAQBgNVBAoTCUJhbHRpbW9y\n" \
"ZTETMBEGA1UECxMKQ3liZXJUcnVzdDEiMCAGA1UEAxMZQmFsdGltb3JlIEN5YmVy\n" \
"VHJ1c3QgUm9vdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKMEuyKr\n" \
"mD1X6CZymrV51Cni4eiVgLGw41uOKymaZN+hXe2wCQVt2yguzmKiYv60iNoS6zjr\n" \
"IZ3AQSsBUnuId9Mcj8e6uYi1agnnc+gRQKfRzMpijS3ljwumUNKoUMMo6vWrJYeK\n" \
"mpYcqWe4PwzV9/lSEy/CG9VwcPCPwBLKBsua4dnKM3p31vjsufFoREJIE9LAwqSu\n" \
"XmD+tqYF/LTdB1kC1FkYmGP1pWPgkAx9XbIGevOF6uvUA65ehD5f/xXtabz5OTZy\n" \
"dc93Uk3zyZAsuT3lySNTPx8kmCFcB5kpvcY67Oduhjprl3RjM71oGDHweI12v/ye\n" \
"jl0qhqdNkNwnGjkCAwEAAaNFMEMwHQYDVR0OBBYEFOWdWTCCR1jMrPoIVDaGezq1\n" \
"BE3wMBIGA1UdEwEB/wQIMAYBAf8CAQMwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3\n" \
"DQEBBQUAA4IBAQCFDF2O5G9RaEIFoN27TyclhAO992T9Ldcw46QQF+vaKSm2eT92\n" \
"9hkTI7gQCvlYpNRhcL0EYWoSihfVCr3FvDB81ukMJY2GQE/szKN+OMY3EU/t3Wgx\n" \
"jkzSswF07r51XgdIGn9w/xZchMB5hbgF/X++ZRGjD8ACtPhSNzkE1akxehi/oCr0\n" \
"Epn3o0WC4zxe9Z2etciefC7IpJ5OCBRLbf1wbWsaY71k5h+3zvDyny67G7fyUIhz\n" \
"ksLi4xaNmjICq44Y3ekQEe5+NauQrz4wlHrQMz2nZQ/1/I6eYs9HRCwBXbsdtTLS\n" \
"R9I4LtD+gdwyah617jzV/OeBHRnDJELqYzmp\n" \
"-----END CERTIFICATE-----\n";


// Copie aqui o seu certificar do cliente do EUGENIO (ex: xxxxx.pem) ▼
static const char client_cert[] PROGMEM = \
"-----BEGIN CERTIFICATE-----\n" \
"MIICBDCCAW2gAwIBAgIUZCI6qnkRbt7wHGlUF/fqMMEeRtUwDQYJKoZIhvcNAQEL\n" \
"BQAwFDESMBAGA1UEAwwJbG9jYWxob3N0MB4XDTIwMDkyNzAwMzE1N1oXDTIxMDky\n" \
"NzAwMzE1N1owFDESMBAGA1UEAwwJbG9jYWxob3N0MIGfMA0GCSqGSIb3DQEBAQUA\n" \
"A4GNADCBiQKBgQDOh8RIIhE79AeZ2U7GuGOqdYXW1UO5q2/Q587H04mwTmdjg6R7\n" \
"fZxzQ1Wo9O2ArnCBWF4Otz0oJmPMcT5KA1ocsYS6bc3ukQXdtafX/puMC29acfTW\n" \
"fmK3x2D0X5GF5SLqryHj41TdWFkz07Wnzphwr3hxeE/nB90u5NUq7T+/KwIDAQAB\n" \
"o1MwUTAdBgNVHQ4EFgQUzCskXb9SRzk5przoQ1qjf2RMadMwHwYDVR0jBBgwFoAU\n" \
"zCskXb9SRzk5przoQ1qjf2RMadMwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0B\n" \
"AQsFAAOBgQAmYko9NShfid6j+/Dcg1RdvB2ucUxc3nlngYT2IWjy9mMEDifbPQqI\n" \
"m5aVPQ8aPpV/FyNNK1mR4DCIRo20whKrFU07VwGlLT1pgyNwVzRd+99qKUD9+oEs\n" \
"7GFwi5s3J5ZIa9nAE4hFdQo8w8xfjAWptdal254FJPNhJ4PaGGrPYw==\n" \
"-----END CERTIFICATE-----\n";

// Copie aqui a sua chave privada do certificado do cleinte do EUGENIO (ex: xxxxx.key.pem) ▼
static const char privkey[] PROGMEM = \
"-----BEGIN PRIVATE KEY-----\n" \
"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAM6HxEgiETv0B5nZ\n" \
"Tsa4Y6p1hdbVQ7mrb9DnzsfTibBOZ2ODpHt9nHNDVaj07YCucIFYXg63PSgmY8xx\n" \
"PkoDWhyxhLptze6RBd21p9f+m4wLb1px9NZ+YrfHYPRfkYXlIuqvIePjVN1YWTPT\n" \
"tafOmHCveHF4T+cH3S7k1SrtP78rAgMBAAECgYAlZ0cv/SN75SUfQtDWgnxiWahk\n" \
"kPkT/i1g+ypi3De6e2iUCDpYtxYHdfFkiP8eZ/kuI6/dIGhuBg3a78NlKhg+eFK4\n" \
"OKoVtBcf1UFA6c2S2Fbq8ECvvfxmZMI/uiTxEK/XgiUpLComuhPKulgilpx5vx2n\n" \
"akG0IoO7EgeBepjNsQJBAP+h2n/M8kBVguEiNVrdtq7QnGHi4/1y6g2MsPXbCxnp\n" \
"oiWbKHLcxvok5x8HCDjsRvKXVNr4bXexzw8v3kvkuLkCQQDO09RcTNBEl66HzMmB\n" \
"Xzf/bSvdpn3d36Pxl5n1xCDRHTJSVsGfX82iEfHa56yeIEgdkEg1AsmOno+HQJVs\n" \
"Ob0DAkEAqDVkhXviXBroiCPuX+BMeTOj83VM+FVJVakiOGTuJRrrKzuxngNQmwD1\n" \
"ZCFIc8xl0vNpTrzxqzVBPokNCXtzYQJANWnVVQTtYFl/1EhZ3dRWZNuv0W024j7o\n" \
"WvMY6rR8+SQ+I6+OD3exZmKWAD+Gf8u8dA4X58DRhsiCLp7KOAntOwJAda+7bXiP\n" \
"aDHZiaYmf/R2ROxabWnHY8qQ4sxhIv4ToG9eQ3fFjlQNmN/smfyL7wKNYUPFQizi\n" \
"gdezjiOe1Wtqaw==\n" \
"-----END PRIVATE KEY-----\n";
