Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE1C77B73
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 19:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjEVTvS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 15:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjEVTu6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 15:50:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2082.outbound.protection.outlook.com [40.92.52.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DEF12B
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 12:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNY2+1mtfylTtpakMz6oUM6xD8ErDDP+c9415bZdVvffzng3ypEigGJ495BVlHs0nmvyQHflWyF/MQ5Du/AOzxdjZjMtd4kST3K1tBUR5eS7CwRYlSgWbteVDKEC9iivWJe1e6UZ8mVu4kl4woKp7gouVGn7G1ysrQwCeAHHN4XIMJiwWZwUsBlbVHJq1ktMa0yLHPQJ73LfGmHxNwnO9VE15Tt5t0a02ipDdqvInn4Ythu/El9IrYluAwGra1/NHgIQZsZEGO8tw61xsPRxIi+0S/tQBnsC4iliUclSIE+JVtbxJKRDkM+XwS2Q7Ct86dhvFXcMxkgxuzPMPj2Scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBO35UCzaez7CLkXANWJPWfb0JcQ0UYghIH6Nz+U6Jg=;
 b=JQjCdMWvx7MeW3du3rfnf2R5PvbX+aaKGzOLm4RdNfHaTxieVC0Hkgs6l/pgM+6DUdDUPornkqBvFHMcWPEDh+zz1v4O07ps/AWJogtExDH/o17zNAeLnbVV8c0/F1NW4j8Hhz08kAVMZVSWFqHV35XlmXK5abNIEIU3FyHPYARh5GHdeC+CxzkmCy+d71eInSxPnoMre6AlGYs0Iq3VHNibLhq2COd6P7p+nZQb/dyPY9lwrCINNwv6JcI4k3qMB9UkOs9X8x/fkNbirB39GFe3kobNx6SBghCBC+QmeKsTR4ox9v3VqQmwySXyV51YLm8NxNgDPUqmG2EQ6RGMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBO35UCzaez7CLkXANWJPWfb0JcQ0UYghIH6Nz+U6Jg=;
 b=G5SJ70flQ0g9MfrwfuY8Amx93zcwDD1t12Jn4P5x+8+kvK9k+N1FOHM2HZa2DyjwlVB5QIyIHu5YnnrPO1yY7Lr3ELC0fYnil8pPNXxYf0qGLPon0aDrTFqh7SNoOvZgYGnYZ4SPhgHosg1Oe/cM7cxTFLnfiHx73maKKDbNFhIxyg1esYpgI/ZqwbBpKRhMzOG8mxzOwc2dJTV7mE/oUf7BE4ss6B9tfeIKezP01Bd/vd6u7sDc99rQq+rwzN3QuOm+cfqZT8rs9tKl7F3JCfpIV07AXNZSM7pOyp+2VLPS3I1MKbLLKXwTzhgGG0IdRhKp8s6i7S25Stw807quWg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 19:50:44 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425%7]) with mapi id 15.20.6411.021; Mon, 22 May 2023
 19:50:44 +0000
Date:   Mon, 22 May 2023 12:50:34 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 3/7] hw/cxl/events: Wire up get/clear event mailbox
 commands
Message-ID: <SG2PR06MB3397AB10C301F4F596EBD688B2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <CGME20230522151125uscas1p1ac7cc62cf284544e2b827d7cacaba8cd@uscas1p1.samsung.com>
 <20230522150947.11546-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522150947.11546-4-Jonathan.Cameron@huawei.com>
X-TMN:  [qljxHMAg6dAhp8ZE7n26hPyi0JGBISys5GaLncBg6CA=]
X-ClientProxiedBy: SJ0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::22) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZGvHihvn/9h2rTVF@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SEYPR06MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: ef422005-72c0-4603-62f9-08db5afdd46b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uyLGe4XJcrnjrp1Y+vzMr2vbbbJ17PRw20ejb0IWNLJysMl0Pk/CjtDwVdMhvKtAcdcWg+arYf4gFDucJQphBVMYoq9RS1EaGKqpg0mSQ5n0ujQMr0193wJ58Ai4UBbB+uFJw0Ao3trOSe/3xUr8vr5KheqYTenMi4/pwvzz1HgqxYvmv0wp7zH2e4SHhWpfxMVH/4MS9Koj4eFDT1V9+nWoxHbjq6P/LXQdUYHOsMz6NlqVsIL05A+HKPx3SzO9dKMpIW9bncm2JRNcOqjMs/X4/GN1L3x2SYSef/IiRRggsHwPMFIwlbq6KDDbOGkIl3DX1zhlUUWqS+NGL56sQV+pmaRN8P2P8LzHL3o3Tuifg2HbjUE7AtUgAxJWWpDtDTFCKNYrNQxlM6oNj3tceHoIBuC8KY2omywa1u4mgPY9vHLcemdtEEq/dd0xenrbmxSJlt7Gy3Zer6cWs6ERaknPM9uWx9viQgJ/YgFl8yrKpsuuM0hdyd3EgzCrCEvhLaUKsVM0Jg99LEAkhedM7lI/6IpeQlCpg+lyXyo7qzRwLWShF6AOxn5JEzyaZSn1oW9cpESg6YSENmQ2y2fWrGWDM+Zi6bT4VSXi7bpHE1je0n80MGHMA+q1dMncsSVU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1kTzIxS3pIU2FSUUlFWklTYU1ISWhxelBjLzJQS2FpZTU4a2ZrQWVsMnZK?=
 =?utf-8?B?Wml5YnZvRHdtKzVTbU5MMFFmMzNBMmlJRFRhSmJJU09idUYxeXY2Z0QyUkYy?=
 =?utf-8?B?TmpyZGU5cjhUL0krTmQxK2R3eENnTExmVHJEYmlEM1FhOU9vRnBBZngvRTRE?=
 =?utf-8?B?bjNaSVhWV2hKcWFiak56NnF1MmR5a1VwQ2kzTVBzSGNCSlpydXkrVjJsRWRi?=
 =?utf-8?B?NGc0d3lBZ3BBTW16M2F5Nk00Tng1QTltMFg4aTRZVm5lTWYxdHhMVkdBLzBN?=
 =?utf-8?B?RG1vZkhxaUJrRXdlOWdEUzVONmZSOGp1ZmE2OThlUVNSU0pWMGY5WGdEUmJX?=
 =?utf-8?B?bERRSGFnR2IrTGw5UUV3bm9sQkRsSFNpOW1mQTFsZzVIMitQQmMwUlNzejdN?=
 =?utf-8?B?eVd4YlBhTHdxRGU5NCt3TTVzTGpUV2syQ1I0N0NWNUtVRWt1UUJDeFBtS3lP?=
 =?utf-8?B?K1h3U3JKdlRBWE1RUkNpUXZ4ZjU0a25pckJjOCt4bFFGMTlWNG1EcUR0K1lI?=
 =?utf-8?B?Z293L1FYdGdUNkRFd00vTzIxVGpaNENLZEVGeGFoSUE4Zm8rSUQwb3FrQ0Yz?=
 =?utf-8?B?SHo2RWttOE1ub1Ntenc2blJrbW5WcFBVZGNXdERrc1pFcFRyMlkzSnVBREdT?=
 =?utf-8?B?YkVpZjVGeHpiSnIyd3ZxaTNRdktvQjk1VHRWWlNkaWlmaUFRcjBPUjNVblI2?=
 =?utf-8?B?RGFobnY3ZW1mcVlPL3gycE9PelZ4SERFZ1Bkb1VmMUJ0NjlVK2o1amVSWm5S?=
 =?utf-8?B?RzNEenpqaE4zc2JWdHlYTlBqQUdFYlJKYXl0S2h0dk9EVnhzbVlHYjRid1VI?=
 =?utf-8?B?azhLWGRjeTcvQ0t4ZzVhNjFlRG9uVVpvQlZZYUI4RmNWajVFYU82WnQwWGw3?=
 =?utf-8?B?NWpkcHlFNm5ueXJrN2NiNHJCc01CQnJnWnE4dnhad0ZyV2JqenRneHkyNUta?=
 =?utf-8?B?dnQ1OE9vRmtXWnhKMUtieDFSTEJzamZ1cm1oZWprY2UvN0pIN2JTaWhDZFFU?=
 =?utf-8?B?cXlhRkhoTVFuMTJtR0lIbWE1S3Jtdk12RzkzTFVjSldpUlBMdkI2SGp4MmJF?=
 =?utf-8?B?enFINVExRTVNVlRvckZSRUJLM2VmdWx4WXBOd292QXhWZGpCMlpDZlNadVQ2?=
 =?utf-8?B?YlVrcWNNeEJFUXNvVGwzcUgweDF0bGp2aERTU1BLOHhhd014WkJGRW9hdW1N?=
 =?utf-8?B?V0tKQ25PWGNERTFYV1BQcmZzaXFYM0xSMHd1cDJvQlhScTVqVysyWFZoWjhO?=
 =?utf-8?B?T085Yk5JV1VrZ1B1eFcxektJSG5GUGtqRVEwZjFoUVVaampDOHhrM0grRXBC?=
 =?utf-8?B?M1Y4NWQzMEdMMElqZlQvNU9sakplYjFtS0g3ZnZNNnBtbERubis3V2xKMUtt?=
 =?utf-8?B?ZVN1WnNJdHE1ZE50OUdFKzJEblVCbWtRK3BLNktTdTEyb09uUnJXaUFmdzdk?=
 =?utf-8?B?dlRMa3graHRwZ2dZYnNIZDRGOXRoLzNiMjNFbHdESmFheW90U2pDMXFzQ3Vn?=
 =?utf-8?B?OFVSbVAxN2d6SVFjd05ZUjNmZDhUR0V4Nmw4NUJCMU9Id2x4N3dmYmJjQkww?=
 =?utf-8?B?QlRTSmpnaWFzZlNlQ09xSDJBR2ZkMXoweFEyWHpsd0VFTVhoYW8wUUJBS28v?=
 =?utf-8?Q?8TRjjB7HcIg9IDQQxLk0DuzZT7ZDCQ2k1z4GHMm9GMyI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef422005-72c0-4603-62f9-08db5afdd46b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 19:50:44.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6756
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/22/2023 16:09, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL testing is benefited from an artificial event log injection
> mechanism.
> 
> Add an event log infrastructure to insert, get, and clear events from
> the various logs available on a device.
> 
> Replace the stubbed out CXL Get/Clear Event mailbox commands with
> commands that operate on the new infrastructure.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

See comments below in cxl_event_insert.

>  include/hw/cxl/cxl_device.h |  25 +++++
>  include/hw/cxl/cxl_events.h |  55 +++++++++
>  hw/cxl/cxl-events.c         | 217 ++++++++++++++++++++++++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c  |  40 ++++++-
>  hw/mem/cxl_type3.c          |   1 +
>  hw/cxl/meson.build          |   1 +
>  6 files changed, 337 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 9f8ee85f8a..d3aec1bc0e 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -111,6 +111,20 @@ typedef enum {
>      CXL_MBOX_MAX = 0x17
>  } CXLRetCode;
>  
> +typedef struct CXLEvent {
> +    CXLEventRecordRaw data;
> +    QSIMPLEQ_ENTRY(CXLEvent) node;
> +} CXLEvent;
> +
> +typedef struct CXLEventLog {
> +    uint16_t next_handle;
> +    uint16_t overflow_err_count;
> +    uint64_t first_overflow_timestamp;
> +    uint64_t last_overflow_timestamp;
> +    QemuMutex lock;
> +    QSIMPLEQ_HEAD(, CXLEvent) events;
> +} CXLEventLog;
> +
>  typedef struct cxl_device_state {
>      MemoryRegion device_registers;
>  
> @@ -161,6 +175,8 @@ typedef struct cxl_device_state {
>      uint64_t mem_size;
>      uint64_t pmem_size;
>      uint64_t vmem_size;
> +
> +    CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
>  } CXLDeviceState;
>  
>  /* Initialize the register block for a device */
> @@ -353,6 +369,15 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>  
>  uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
>  
> +void cxl_event_init(CXLDeviceState *cxlds);
> +bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
> +                      CXLEventRecordRaw *event);
> +CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
> +                                 uint8_t log_type, int max_recs,
> +                                 uint16_t *len);
> +CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
> +                                   CXLClearEventPayload *pl);
> +
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
>  
>  #endif
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index aeb3b0590e..d4aaa894f1 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -10,6 +10,8 @@
>  #ifndef CXL_EVENTS_H
>  #define CXL_EVENTS_H
>  
> +#include "qemu/uuid.h"
> +
>  /*
>   * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
>   *
> @@ -25,4 +27,57 @@ typedef enum CXLEventLogType {
>      CXL_EVENT_TYPE_MAX
>  } CXLEventLogType;
>  
> +/*
> + * Common Event Record Format
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +#define CXL_EVENT_REC_HDR_RES_LEN 0xf
> +typedef struct CXLEventRecordHdr {
> +    QemuUUID id;
> +    uint8_t length;
> +    uint8_t flags[3];
> +    uint16_t handle;
> +    uint16_t related_handle;
> +    uint64_t timestamp;
> +    uint8_t maint_op_class;
> +    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
> +} QEMU_PACKED CXLEventRecordHdr;
> +
> +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> +typedef struct CXLEventRecordRaw {
> +    CXLEventRecordHdr hdr;
> +    uint8_t data[CXL_EVENT_RECORD_DATA_LENGTH];
> +} QEMU_PACKED CXLEventRecordRaw;
> +#define CXL_EVENT_RECORD_SIZE (sizeof(CXLEventRecordRaw))
> +
> +/*
> + * Get Event Records output payload
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> + */
> +#define CXL_GET_EVENT_FLAG_OVERFLOW     BIT(0)
> +#define CXL_GET_EVENT_FLAG_MORE_RECORDS BIT(1)
> +typedef struct CXLGetEventPayload {
> +    uint8_t flags;
> +    uint8_t reserved1;
> +    uint16_t overflow_err_count;
> +    uint64_t first_overflow_timestamp;
> +    uint64_t last_overflow_timestamp;
> +    uint16_t record_count;
> +    uint8_t reserved2[0xa];
> +    CXLEventRecordRaw records[];
> +} QEMU_PACKED CXLGetEventPayload;
> +#define CXL_EVENT_PAYLOAD_HDR_SIZE (sizeof(CXLGetEventPayload))
> +
> +/*
> + * Clear Event Records input payload
> + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> + */
> +typedef struct CXLClearEventPayload {
> +    uint8_t event_log;      /* CXLEventLogType */
> +    uint8_t clear_flags;
> +    uint8_t nr_recs;
> +    uint8_t reserved[3];
> +    uint16_t handle[];
> +} CXLClearEventPayload;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> new file mode 100644
> index 0000000000..5da1b76b97
> --- /dev/null
> +++ b/hw/cxl/cxl-events.c
> @@ -0,0 +1,217 @@
> +/*
> + * CXL Event processing
> + *
> + * Copyright(C) 2023 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include <stdint.h>
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bswap.h"
> +#include "qemu/typedefs.h"
> +#include "qemu/error-report.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_events.h"
> +
> +/* Artificial limit on the number of events a log can hold */
> +#define CXL_TEST_EVENT_OVERFLOW 8
> +
> +static void reset_overflow(CXLEventLog *log)
> +{
> +    log->overflow_err_count = 0;
> +    log->first_overflow_timestamp = 0;
> +    log->last_overflow_timestamp = 0;
> +}
> +
> +void cxl_event_init(CXLDeviceState *cxlds)
> +{
> +    CXLEventLog *log;
> +    int i;
> +
> +    for (i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
> +        log = &cxlds->event_logs[i];
> +        log->next_handle = 1;
> +        log->overflow_err_count = 0;
> +        log->first_overflow_timestamp = 0;
> +        log->last_overflow_timestamp = 0;
> +        qemu_mutex_init(&log->lock);
> +        QSIMPLEQ_INIT(&log->events);
> +    }
> +}
> +
> +static CXLEvent *cxl_event_get_head(CXLEventLog *log)
> +{
> +    return QSIMPLEQ_FIRST(&log->events);
> +}
> +
> +static CXLEvent *cxl_event_get_next(CXLEvent *entry)
> +{
> +    return QSIMPLEQ_NEXT(entry, node);
> +}
> +
> +static int cxl_event_count(CXLEventLog *log)
> +{
> +    CXLEvent *event;
> +    int rc = 0;
> +
> +    QSIMPLEQ_FOREACH(event, &log->events, node) {
> +        rc++;
> +    }
> +
> +    return rc;
> +}
> +
> +static bool cxl_event_empty(CXLEventLog *log)
> +{
> +    return QSIMPLEQ_EMPTY(&log->events);
> +}
> +
> +static void cxl_event_delete_head(CXLDeviceState *cxlds,
> +                                  CXLEventLogType log_type,
> +                                  CXLEventLog *log)
> +{
> +    CXLEvent *entry = cxl_event_get_head(log);
> +
> +    reset_overflow(log);
> +    QSIMPLEQ_REMOVE_HEAD(&log->events, node);
> +    if (cxl_event_empty(log)) {
> +        cxl_event_set_status(cxlds, log_type, false);
> +    }
> +    g_free(entry);
> +}
> +
> +/*
> + * return true if an interrupt should be generated as a result
> + * of inserting this event.
> + */
> +bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
> +                      CXLEventRecordRaw *event)
> +{
> +    uint64_t time;
> +    CXLEventLog *log;
> +    CXLEvent *entry;
> +
> +    if (log_type >= CXL_EVENT_TYPE_MAX) {
> +        return false;
> +    }
> +
> +    time = cxl_device_get_timestamp(cxlds);
> +
> +    log = &cxlds->event_logs[log_type];
> +
> +    QEMU_LOCK_GUARD(&log->lock);
> +
> +    if (cxl_event_count(log) >= CXL_TEST_EVENT_OVERFLOW) {
> +        if (log->overflow_err_count == 0) {
> +            log->first_overflow_timestamp = time;
> +        }
> +        log->overflow_err_count++;
> +        log->last_overflow_timestamp = time;
> +        return false;
> +    }
> +
> +    entry = g_new0(CXLEvent, 1);
> +
> +    memcpy(&entry->data, event, sizeof(*event));
> +
> +    entry->data.hdr.handle = cpu_to_le16(log->next_handle);
> +    log->next_handle++;
> +    /* 0 handle is never valid */
> +    if (log->next_handle == 0) {

next_handle is uint16_t, how can it be 0 after next_handle++?

> +        log->next_handle++;
> +    }
> +    entry->data.hdr.timestamp = cpu_to_le64(time);
> +
> +    QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
> +    cxl_event_set_status(cxlds, log_type, true);
> +
> +    /* Count went from 0 to 1 */
> +    return cxl_event_count(log) == 1;
> +}
> +
> +CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
> +                                 uint8_t log_type, int max_recs,
> +                                 uint16_t *len)
> +{
> +    CXLEventLog *log;
> +    CXLEvent *entry;
> +    uint16_t nr;
> +
> +    if (log_type >= CXL_EVENT_TYPE_MAX) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    log = &cxlds->event_logs[log_type];
> +
> +    QEMU_LOCK_GUARD(&log->lock);
> +
> +    entry = cxl_event_get_head(log);
> +    for (nr = 0; entry && nr < max_recs; nr++) {
> +        memcpy(&pl->records[nr], &entry->data, CXL_EVENT_RECORD_SIZE);
> +        entry = cxl_event_get_next(entry);
> +    }
> +
> +    if (!cxl_event_empty(log)) {
> +        pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> +    }
> +
> +    if (log->overflow_err_count) {
> +        pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
> +        pl->overflow_err_count = cpu_to_le16(log->overflow_err_count);
> +        pl->first_overflow_timestamp = cpu_to_le64(log->first_overflow_timestamp);
> +        pl->last_overflow_timestamp = cpu_to_le64(log->last_overflow_timestamp);
> +    }
> +
> +    pl->record_count = cpu_to_le16(nr);
> +    *len = CXL_EVENT_PAYLOAD_HDR_SIZE + (CXL_EVENT_RECORD_SIZE * nr);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *pl)
> +{
> +    CXLEventLog *log;
> +    uint8_t log_type;
> +    CXLEvent *entry;
> +    int nr;
> +
> +    log_type = pl->event_log;
> +
> +    if (log_type >= CXL_EVENT_TYPE_MAX) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    log = &cxlds->event_logs[log_type];
> +
> +    QEMU_LOCK_GUARD(&log->lock);
> +    /*
> +     * Must itterate the queue twice.
> +     * "The device shall verify the event record handles specified in the input
> +     * payload are in temporal order. If the device detects an older event
> +     * record that will not be cleared when Clear Event Records is executed,
> +     * the device shall return the Invalid Handle return code and shall not
> +     * clear any of the specified event records."
> +     *   -- CXL 3.0 8.2.9.2.3
> +     */
> +    entry = cxl_event_get_head(log);
> +    for (nr = 0; entry && nr < pl->nr_recs; nr++) {
> +        uint16_t handle = pl->handle[nr];
> +
> +        /* NOTE: Both handles are little endian. */
> +        if (handle == 0 || entry->data.hdr.handle != handle) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        entry = cxl_event_get_next(entry);
> +    }
> +
> +    entry = cxl_event_get_head(log);
> +    for (nr = 0; entry && nr < pl->nr_recs; nr++) {
> +        cxl_event_delete_head(cxlds, log_type, log);
> +        entry = cxl_event_get_head(log);
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d7e114aaae..3f46538048 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -9,6 +9,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_events.h"
>  #include "hw/pci/pci.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
> @@ -95,11 +96,46 @@ struct cxl_cmd {
>          return CXL_MBOX_SUCCESS;                                          \
>      }
>  
> -DEFINE_MAILBOX_HANDLER_ZEROED(events_get_records, 0x20);
> -DEFINE_MAILBOX_HANDLER_NOP(events_clear_records);
>  DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
>  DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
>  
> +static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
> +                                         CXLDeviceState *cxlds,
> +                                         uint16_t *len)
> +{
> +    CXLGetEventPayload *pl;
> +    uint8_t log_type;
> +    int max_recs;
> +
> +    if (cmd->in < sizeof(log_type)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    log_type = *((uint8_t *)cmd->payload);
> +
> +    pl = (CXLGetEventPayload *)cmd->payload;
> +    memset(pl, 0, sizeof(*pl));
> +
> +    max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
> +                CXL_EVENT_RECORD_SIZE;
> +    if (max_recs > 0xFFFF) {
> +        max_recs = 0xFFFF;
> +    }
> +
> +    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
> +}
> +
> +static CXLRetCode cmd_events_clear_records(struct cxl_cmd *cmd,
> +                                           CXLDeviceState *cxlds,
> +                                           uint16_t *len)
> +{
> +    CXLClearEventPayload *pl;
> +
> +    pl = (CXLClearEventPayload *)cmd->payload;
> +    *len = 0;
> +    return cxl_event_clear_records(cxlds, pl);
> +}
> +
>  /* 8.2.9.2.1 */
>  static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
>                                                 CXLDeviceState *cxl_dstate,
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d751803188..ec5a384885 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -724,6 +724,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>          goto err_release_cdat;
>      }
>  
> +    cxl_event_init(&ct3d->cxl_dstate);
>      return;
>  
>  err_release_cdat:
> diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
> index cfa95ffd40..71059972d4 100644
> --- a/hw/cxl/meson.build
> +++ b/hw/cxl/meson.build
> @@ -5,6 +5,7 @@ softmmu_ss.add(when: 'CONFIG_CXL',
>                     'cxl-mailbox-utils.c',
>                     'cxl-host.c',
>                     'cxl-cdat.c',
> +                   'cxl-events.c',
>                 ),
>                 if_false: files(
>                     'cxl-host-stubs.c',
> -- 
> 2.39.2
> 

-- 
Fan Ni <nifan@outlook.com>
