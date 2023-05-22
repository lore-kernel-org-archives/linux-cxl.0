Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623AFC77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 22:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjEVWlp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjEVWlo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 18:41:44 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2041.outbound.protection.outlook.com [40.92.53.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254CE6
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuureBTnTyFkBEjfu5tW9AgCLGFNHFLvu1qAapjEv46RpaW4ygoakTbfIJ+3xK8XIe6V26e7zo8dQujGYuFPj+6n2WcD0URo1M8GP+L9SUcr60A5d7KYz9LRbSjv3fCFNA6Jr/h7Vd/0tVxmBOWGiwti53Zdu3rgKDx425cEbkWCzYXS1ze1gE8teEz1US9ts5pCE202+rcjbNWks7jQlAzUyOjhOK4fQ0lwzdCSrWG5dJWq2xEXRZwgTROaHU7zy3GLus2wfVJHEM27o0y4cSDWrGoa3x3t78skpzs85nukfJazBSP+iTtm6dbey6E7xIkp9Cc9bgI3UQEZIEYHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9Sxaj2ei0JII4ZcJwc63MK3L7esTaCc7O4SZM6v/is=;
 b=Z39+hU5AmDiXxs/Or2yKpRSNsOdJwVcw5QF2uqTnSkvn0b2E3ZNeW195MUZXdASBj1wXqgoxFtpm4QTe30lTXE8BLwV9q35Ec81T4KAUg3RR48DuCFoXe/z8QfqQFDgQ+ih1V+l0Ug5WS7vyX02FeoBSv8V1Z6uChKQ2dEPjHWFGbvc+kI+CLpoh4Uthm2YZxLdOS1tKx5oiLJKy7ddBGsvF4XkNcFkLwRIY7nPx9cayGycQiR8UjOUQVCwhQF0USUkcVVsvjOAlrgyMgQZh0vj565iPBk2msQbKJwgd+tM/87tgjdVV7N6F4Y7mAMD9Hgso8erFM6GGj8h+md4KBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Sxaj2ei0JII4ZcJwc63MK3L7esTaCc7O4SZM6v/is=;
 b=f29Yz2ZviAouKTrSIhgQPDDzwtuMQqGqr1loOcUI+cbpdlLpw7NdNXou3FX9bJvQtzljT9ifHPn2Tn/8vAdcYxjDPwSJRGAzGgIzGuGm4odF5rX21riWZP6kVfzGdXNoywI+FkhTAo7qxHYaNVTv9MG3of+Qk0VSInPsk/DLeb9eyxcgS/nQhzelYvO85jiQh2ly4AqfNOBALO4w0QAuezgmjkBfpooTHL8Ib46Cl+0DGYxwmhfdGrlG76DCeMICmMKTgRFHJoY+lTCUCgzmF6RNM2zk3u0KnKRbcuIrW4aEdzL6whQzuI//2USgszQy/S/JCmwkMoRNJjabbzSpzA==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SEYPR06MB5961.apcprd06.prod.outlook.com (2603:1096:101:d6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.27; Mon, 22 May 2023 22:41:33 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425%7]) with mapi id 15.20.6411.021; Mon, 22 May 2023
 22:41:33 +0000
Date:   Mon, 22 May 2023 15:41:21 -0700
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
        Thomas Huth <thuth@redhat.com>, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com
Subject: Re: [PATCH v7 4/7] hw/cxl/events: Add event interrupt support
Message-ID: <SG2PR06MB339799CA0246F92C45A5F3EEB2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <CGME20230522151155uscas1p10e91528b5f7619923c286b70b891abec@uscas1p1.samsung.com>
 <20230522150947.11546-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522150947.11546-5-Jonathan.Cameron@huawei.com>
X-TMN:  [qAb0Zz/Qhqj7ju5YKmEzvcI0HKAx/NlD5ergwjytUxk=]
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZGvvkUi7Le8puZNt@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SEYPR06MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 97755f8b-dad2-4d16-f352-08db5b15b0e8
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrO3yEcJ8o8qPbkkVS+87Wk/8lm69NeR/J/Mg/ASWAsd8WITM86/Wns/aWmLLr9ajD27OoL4NSYXVc2BjEKDUpsnjR70YDBCx23t+GrhrxW+8IG5dCophEf9I4nM5d8XyyNIukAxoRXKMDWOF9VQbZJOm/d/I7heaM3fOfOhRE8K2XyMSOmz/2jX9Hf8P5zXcn0/2975Bdo0pQXnfQ9B3O5BsB0Z/cpC2GfRXnvUvhTFiF0SAD2/m84ARlQS7rFOBP1cf+//plDBK7qHquGmASWwPc5VuNF49U5sSODjNIZbxPXOAJdqzKNqFzVvO+A+mxpaFqYVNWX/6ZfgkA6EM57Qv9KRSTcM2DdI7b6KgP5Tvyz0liot+cDW1eV9nean7tkQPyI07gokPMBYtGW+Y839LDwX525EYMpyT40DcO0PP+4+iypXjx/wD26EMsbn36rpFGVPynYxdgG1tZue1szCsP37b7PT8IY9C1v1L3q0BbPamd5S2zmK8VRiMJu6/29mayrU58NNcq7bMunU8jLn0/Jl8uSIlYYCRAyzKEENp2pe0iyhlbJUXqmT3Mvjn9Kc7VD6HMu7GW4TfP5VMKPqeJTnREppIE4ErdGVrESvYZ55FHEeVyrHj/Mnpm59MJC/T/ORw3SnDWtWoODVBZR91cz1uu1+bR6UrUV+GAnohRW6EfkFmBb2/toBsyvTdNTNuOF7VBT8VNNGtY/z5XlgzyPon/0ApvfSalM9UcLQ8f+d5pe/itqfZnTOcRhGyNw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D72qTqox7Uj+Ku/Slg/H+nGKX4GAUHY2qEiCZUSgpUDV3mifzRtRrWp7Lvbe4wO3EfMmi0hyi0g4udA6TKvhybLSwbOYju2ai6xyq2naqtmOMtyHi1vK3B9SjR4cnQ80x7nmyUCyP3TKhGq7m0RCf0uZsIMKIYpSWW3VhslGVW72lcNTAA9BoAalDvrlb3czVm65bKPGp/zqCkd6XwgoKqsr9LrQsx0zVe2Y808p+9DiScha761MnTzamyS+ZoySb1jBq3YzUn8C6UmLo7Ym86Q3xhVTtJqhfFM6Q95HK3BBHgFP6TL5/e+wObVv6tVGSUji73NMbUXcK+pDd7BLEhAE+L6P7z3YlqylAq4wHxzemyd5j+X7d/dC9KmqtEhIzD56ts4OftAN7ZnXoi4jhGMqYrOq6E1VsaLMf7BStXzsvc9XIZRfHA7j6DiF4HhvURRL++vw4sBZnVADozeBAV9jo5zSHJa6Al2u1cdbGNUIZcsK6aJupOH25COU4m6jfCNa2XLMD/14DL6c9EazO4YERfEYcpqO/GhEXVzuWvP70lDRRL2bUZ0+5GUgVwzhEw+2owuESAq55cUxwhKPS0P9P47syMMOCJ9Uw3hREOwLlhK8irAizlZx9+jupVSxselAzE1E700hBC9VFXBTzA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJhb0lJOVRDZnpTQ01rSmhtWkV4RE5kR3M0WXduZkVvangvWnQ3V2JUV3hO?=
 =?utf-8?B?UUk1aEp1bnBKYlZpSjRpTWlkSUNxeGVVK1RQcCtLNzI2V0Q3VVo4UjdhQ0VW?=
 =?utf-8?B?S2Rabm5HZjBzYmR4UWc5bjU0czF0Y1RobGtOYXQvd2tiMWpieGhuak5uMmNV?=
 =?utf-8?B?NmNLcUhiRXRlL053RlhwbXRRNUtWT3lCVE5JWFZhNHl6WEptbmVGM0RlT25l?=
 =?utf-8?B?WXpGTWVNSHZsdWg0UE1jVHBtVHRwQnBHcUJsV2drL1JCZXQvbkh6SEkwTGJ4?=
 =?utf-8?B?eGpyS1pwU3MrdGZ4N1ZNRU50eWs2ektnbEY3RnFyZ3VIb0F4d1BWemMyY05n?=
 =?utf-8?B?Yk1pRE5yclJ4cXErVldvSGc5cnlhQkFQaDRCaHdsOVZJVVRISUNUeDZFbzFP?=
 =?utf-8?B?bk9ac1F1TzNrSmJidzFwd0FuMnR6bmlZbGNTN2hSS0RmWTJWUUx0aXVrTUI0?=
 =?utf-8?B?bHhJVUNxTGk5dnBOQ2t3L0lDbko5aTFWK09qZFc1U2h0L2xLN3lhdFVITXll?=
 =?utf-8?B?azloQU9acDh0R2VIRGJyQXZyZ0Iva2Q1WDlWVUlYVGZSRUxWOVdPdit3ellM?=
 =?utf-8?B?emNuMTZuS2VPQVVqeGZtZ1BENnp0em5QZ1RmbGR6QkxZSTV1TjVtb2hHRE5M?=
 =?utf-8?B?amNqME5qN2pwd3ZZaGhtTDFoWmMwSE5Mck8yRlRCLzFLVkZZOVhZcVNIVnN0?=
 =?utf-8?B?TDBQdW9iNUE5aXZWb0NtOU05ZVI1YlJpZmFOOVRJdzlpMFNYd2kwSmxKNDBV?=
 =?utf-8?B?VGg5SExDSFVQbnliMDdGeU9ZT2VBalNIeHc5TVpMdUEvSTdwNGRpMk9oNG45?=
 =?utf-8?B?TXJnS0ttNWNuSi9tREN5bjcvZnJBMWlXVWNsOURvOU0xQ2NUTzVzYzJOV3pI?=
 =?utf-8?B?UG4zbmEwcHlLYWRydGJKZDVEMEUrT0F3V3U2TWxDcUxOd1NoUjU3WFMxc1h1?=
 =?utf-8?B?amc0K3NPSGV3MzNJTytCbTdZSjRqeFFyTXllQU5OUkhaN0dvTE94UjdnZU5v?=
 =?utf-8?B?OXVnNFBWMjN2NzRqT0dEZ3hZdWtFaTdkNHFhRGdnSFRZTU5KZWs0RmpEdE15?=
 =?utf-8?B?c3ZMYkU4eHdLNFU2aFJOdms2blRYUmhEMXowUC9HR3ExdmdudExrSjhQbyt2?=
 =?utf-8?B?VTlsM1NUaU0yQkNrcUJlYTU0QTJ6VlhkOXkwMjNrR0g3Yno4NVNWcTliNmpV?=
 =?utf-8?B?RmY2SUhtdjRqdjRJd2ZZSWtqU05odTI5cW5SUnZvUE93RWdMcG4ydTVrb2R2?=
 =?utf-8?B?OUVham5ubnozNzBMR0RlQk1ZaElXbW53QWNqZ2hwdmZsMXRsRUhTNHNYektR?=
 =?utf-8?B?SjE5dTEvUUF6L3Z0QzZabmtqT0lTRitJWStYQ0ZWTUlTZzZRZXNPelpsV2RH?=
 =?utf-8?B?L2p6RkE0M3NMdWhlZm9NTUpQQjZDeitFRUVkN1Y4SkpZMFNpTGtrckpab0ZO?=
 =?utf-8?B?Mi93VTRVU0ozaFJGR1h4YXhpbW5ScGRYMGJEMjBMUGYraDZ0dHQ5SHVISG5D?=
 =?utf-8?B?cEdvcjR5LzAxK3RwbUVIemQ4RCtFUmgwQWdEdzNSdXpMQ0dBNkhWQ3BKQVlt?=
 =?utf-8?B?YlByVmpFSmZkc3U0YWdjRFJ2dkFIRlJ0Wk1UVHkwbmpDYnpuY1RhUjM2YXg5?=
 =?utf-8?Q?R3vWd+MFhuPGamtZ02sJ/zbX1jivChG7lLyBnS+Pd4xY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97755f8b-dad2-4d16-f352-08db5b15b0e8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:41:33.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5961
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/22/2023 16:09, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Replace the stubbed out CXL Get/Set Event interrupt policy mailbox
> commands.  Enable those commands to control interrupts for each of the
> event log types.
> 
> Skip the standard input mailbox length on the Set command due to DCD
> being optional.  Perform the checks separately.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_device.h |   6 +-
>  include/hw/cxl/cxl_events.h |  23 ++++++++
>  hw/cxl/cxl-events.c         |  33 ++++++++++-
>  hw/cxl/cxl-mailbox-utils.c  | 106 +++++++++++++++++++++++++++++-------
>  hw/mem/cxl_type3.c          |   4 +-
>  5 files changed, 147 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index d3aec1bc0e..1978730fba 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -121,6 +121,8 @@ typedef struct CXLEventLog {
>      uint16_t overflow_err_count;
>      uint64_t first_overflow_timestamp;
>      uint64_t last_overflow_timestamp;
> +    bool irq_enabled;
> +    int irq_vec;
>      QemuMutex lock;
>      QSIMPLEQ_HEAD(, CXLEvent) events;
>  } CXLEventLog;
> @@ -369,7 +371,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>  
>  uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
>  
> -void cxl_event_init(CXLDeviceState *cxlds);
> +void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
>  bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
>                        CXLEventRecordRaw *event);
>  CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
> @@ -378,6 +380,8 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
>  CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
>                                     CXLClearEventPayload *pl);
>  
> +void cxl_event_irq_assert(CXLType3Dev *ct3d);
> +
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
>  
>  #endif
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index d4aaa894f1..4bf8b7aa08 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -80,4 +80,27 @@ typedef struct CXLClearEventPayload {
>      uint16_t handle[];
>  } CXLClearEventPayload;
>  
> +/**
> + * Event Interrupt Policy
> + *
> + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> + */
> +typedef enum CXLEventIntMode {
> +    CXL_INT_NONE     = 0x00,
> +    CXL_INT_MSI_MSIX = 0x01,
> +    CXL_INT_FW       = 0x02,
> +    CXL_INT_RES      = 0x03,
> +} CXLEventIntMode;
> +#define CXL_EVENT_INT_MODE_MASK 0x3
> +#define CXL_EVENT_INT_SETTING(vector) ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
> +typedef struct CXLEventInterruptPolicy {
> +    uint8_t info_settings;
> +    uint8_t warn_settings;
> +    uint8_t failure_settings;
> +    uint8_t fatal_settings;
> +    uint8_t dyn_cap_settings;
> +} QEMU_PACKED CXLEventInterruptPolicy;
> +/* DCD is optional but other fields are not */
> +#define CXL_EVENT_INT_SETTING_MIN_LEN 4
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 5da1b76b97..d161d57456 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -13,6 +13,8 @@
>  #include "qemu/bswap.h"
>  #include "qemu/typedefs.h"
>  #include "qemu/error-report.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_events.h"
>  
> @@ -26,7 +28,7 @@ static void reset_overflow(CXLEventLog *log)
>      log->last_overflow_timestamp = 0;
>  }
>  
> -void cxl_event_init(CXLDeviceState *cxlds)
> +void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num)
>  {
>      CXLEventLog *log;
>      int i;
> @@ -37,9 +39,16 @@ void cxl_event_init(CXLDeviceState *cxlds)
>          log->overflow_err_count = 0;
>          log->first_overflow_timestamp = 0;
>          log->last_overflow_timestamp = 0;
> +        log->irq_enabled = false;
> +        log->irq_vec = start_msg_num++;
>          qemu_mutex_init(&log->lock);
>          QSIMPLEQ_INIT(&log->events);
>      }
> +
> +    /* Override -- Dynamic Capacity uses the same vector as info */
> +    cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP].irq_vec =
> +                      cxlds->event_logs[CXL_EVENT_TYPE_INFO].irq_vec;
> +
>  }
>  
>  static CXLEvent *cxl_event_get_head(CXLEventLog *log)
> @@ -215,3 +224,25 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *
>  
>      return CXL_MBOX_SUCCESS;
>  }
> +
> +void cxl_event_irq_assert(CXLType3Dev *ct3d)
> +{
> +    CXLDeviceState *cxlds = &ct3d->cxl_dstate;
> +    PCIDevice *pdev = &ct3d->parent_obj;
> +    int i;
> +
> +    for (i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
> +        CXLEventLog *log = &cxlds->event_logs[i];
> +
> +        if (!log->irq_enabled || cxl_event_empty(log)) {
> +            continue;
> +        }
> +
> +        /*  Notifies interrupt, legacy IRQ is not supported */
> +        if (msix_enabled(pdev)) {
> +            msix_notify(pdev, log->irq_vec);
> +        } else if (msi_enabled(pdev)) {
> +            msi_notify(pdev, log->irq_vec);
> +        }
> +    }
> +}
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3f46538048..02f9b5a870 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -80,25 +80,6 @@ struct cxl_cmd {
>      uint8_t *payload;
>  };
>  
> -#define DEFINE_MAILBOX_HANDLER_ZEROED(name, size)                         \
> -    uint16_t __zero##name = size;                                         \
> -    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
> -                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
> -    {                                                                     \
> -        *len = __zero##name;                                              \
> -        memset(cmd->payload, 0, *len);                                    \
> -        return CXL_MBOX_SUCCESS;                                          \
> -    }
> -#define DEFINE_MAILBOX_HANDLER_NOP(name)                                  \
> -    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
> -                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
> -    {                                                                     \
> -        return CXL_MBOX_SUCCESS;                                          \
> -    }
> -
> -DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
> -DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
> -
>  static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
>                                           CXLDeviceState *cxlds,
>                                           uint16_t *len)
> @@ -136,6 +117,88 @@ static CXLRetCode cmd_events_clear_records(struct cxl_cmd *cmd,
>      return cxl_event_clear_records(cxlds, pl);
>  }
>  
> +static CXLRetCode cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
> +                                                  CXLDeviceState *cxlds,
> +                                                  uint16_t *len)
> +{
> +    CXLEventInterruptPolicy *policy;
> +    CXLEventLog *log;
> +
> +    policy = (CXLEventInterruptPolicy *)cmd->payload;
> +    memset(policy, 0, sizeof(*policy));
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
> +    if (log->irq_enabled) {
> +        policy->info_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
> +    }
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_WARN];
> +    if (log->irq_enabled) {
> +        policy->warn_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
> +    }
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_FAIL];
> +    if (log->irq_enabled) {
> +        policy->failure_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
> +    }
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_FATAL];
> +    if (log->irq_enabled) {
> +        policy->fatal_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
> +    }
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP];
> +    if (log->irq_enabled) {
> +        /* Dynamic Capacity borrows the same vector as info */
> +        policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
> +    }
> +
> +    *len = sizeof(*policy);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
> +                                                  CXLDeviceState *cxlds,
> +                                                  uint16_t *len)
> +{
> +    CXLEventInterruptPolicy *policy;
> +    CXLEventLog *log;
> +
> +    if (*len < CXL_EVENT_INT_SETTING_MIN_LEN) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    policy = (CXLEventInterruptPolicy *)cmd->payload;
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
> +    log->irq_enabled = (policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
> +                        CXL_INT_MSI_MSIX;
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_WARN];
> +    log->irq_enabled = (policy->warn_settings & CXL_EVENT_INT_MODE_MASK) ==
> +                        CXL_INT_MSI_MSIX;
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_FAIL];
> +    log->irq_enabled = (policy->failure_settings & CXL_EVENT_INT_MODE_MASK) ==
> +                        CXL_INT_MSI_MSIX;
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_FATAL];
> +    log->irq_enabled = (policy->fatal_settings & CXL_EVENT_INT_MODE_MASK) ==
> +                        CXL_INT_MSI_MSIX;
> +
> +    /* DCD is optional */
> +    if (*len < sizeof(*policy)) {
> +        return CXL_MBOX_SUCCESS;
> +    }
> +
> +    log = &cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP];
> +    log->irq_enabled = (policy->dyn_cap_settings & CXL_EVENT_INT_MODE_MASK) ==
> +                        CXL_INT_MSI_MSIX;
> +
> +    *len = sizeof(*policy);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* 8.2.9.2.1 */
>  static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
>                                                 CXLDeviceState *cxl_dstate,
> @@ -611,9 +674,10 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
>          cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
>      [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
> -        cmd_events_get_interrupt_policy, 0, 0 },
> +                                      cmd_events_get_interrupt_policy, 0, 0 },
>      [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
> -        cmd_events_set_interrupt_policy, 4, IMMEDIATE_CONFIG_CHANGE },
> +                                      cmd_events_set_interrupt_policy,
> +                                      ~0, IMMEDIATE_CONFIG_CHANGE },
>      [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
>          cmd_firmware_update_get_info, 0, 0 },
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ec5a384885..c9e347f42b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -659,7 +659,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      ComponentRegisters *regs = &cxl_cstate->crb;
>      MemoryRegion *mr = &regs->component_registers;
>      uint8_t *pci_conf = pci_dev->config;
> -    unsigned short msix_num = 1;
> +    unsigned short msix_num = 6;
>      int i, rc;
>  
>      QTAILQ_INIT(&ct3d->error_list);
> @@ -723,8 +723,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      if (rc) {
>          goto err_release_cdat;
>      }
> +    cxl_event_init(&ct3d->cxl_dstate, 2);
>  
> -    cxl_event_init(&ct3d->cxl_dstate);
>      return;
>  
>  err_release_cdat:
> -- 
> 2.39.2
> 

-- 
Fan Ni <nifan@outlook.com>
