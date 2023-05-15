# Zep REST API

---
### /api/v1/sessions/{sessionId}/memory

#### GET
##### Summary

Returns a memory (latest summary and list of messages) for a given session

##### Description

get memory by session id

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ------ |
| session_id | path | Session ID | Yes | string |
| lastn | query | Last N messages. Overrides memory_window configuration | No | integer |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [ [models.Memory](#modelsmemory) ] |
| 404 | Not Found | [server.APIError](#serverapierror) |
| 500 | Internal Server Error | [server.APIError](#serverapierror) |

#### POST
##### Summary

Add memory messages to a given session

##### Description

add memory messages by session id

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ------ |
| session_id | path | Session ID | Yes | string |
| memoryMessages | body | Memory messages | Yes | [models.Memory](#modelsmemory) |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | string |
| 404 | Not Found | [server.APIError](#serverapierror) |
| 500 | Internal Server Error | [server.APIError](#serverapierror) |

#### DELETE
##### Summary

Delete memory messages for a given session

##### Description

delete memory messages by session id

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ------ |
| session_id | path | Session ID | Yes | string |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | string |
| 404 | Not Found | [server.APIError](#serverapierror) |
| 500 | Internal Server Error | [server.APIError](#serverapierror) |

---
### /api/v1/sessions/{sessionId}/search

#### POST
##### Summary

Search memory messages for a given session

##### Description

search memory messages by session id and query

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ------ |
| session_id | path | Session ID | Yes | string |
| limit | query | Limit the number of results returned | No | integer |
| searchPayload | body | Search query | Yes | [models.SearchPayload](#modelssearchpayload) |

##### Responses

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | OK | [ [models.SearchResult](#modelssearchresult) ] |
| 404 | Not Found | [server.APIError](#serverapierror) |
| 500 | Internal Server Error | [server.APIError](#serverapierror) |

---
### Models

#### models.Memory

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| messages | [ [models.Message](#modelsmessage) ] |  | No |
| metadata | object |  | No |
| summary | [models.Summary](#modelssummary) |  | No |

#### models.Message

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| content | string |  | No |
| created_at | string |  | No |
| metadata | object |  | No |
| role | string |  | No |
| token_count | integer |  | No |
| uuid | string |  | No |

#### models.SearchPayload

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| meta | object | reserved for future use | No |
| text | string |  | No |

#### models.SearchResult

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| dist | number |  | No |
| message | [models.Message](#modelsmessage) |  | No |
| meta | object | reserved for future use | No |
| summary | [models.Summary](#modelssummary) | reserved for future use | No |

#### models.Summary

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| content | string |  | No |
| created_at | string |  | No |
| metadata | object |  | No |
| recent_message_uuid | string | The most recent message UUID that was used to generate this summary | No |
| token_count | integer |  | No |
| uuid | string |  | No |

#### server.APIError

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| code | integer |  | No |
| message | string |  | No |
