Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF99C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 21:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbjEWVxf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbjEWVxe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 17:53:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2033.outbound.protection.outlook.com [40.92.107.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7669E9
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 14:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zuhl4S4yedDMqgqnavtqh9c4viYN1CuE5jD+YPpDAgmS9FSrP8Iqgv9LZtFxlbM6q8y9OhDcLbLmImPgwKLk4XSsq5vp5o//h37sQBEw2fNObs+nvCoaaMLGF/wQH82C1if4bCvMHt8gq82rms0WgUfVW8X8qkLUW2WDI4DmNYISIJ15//253q59ALB47L/gXWKV3WT5lhEurlD51VeEdxlczB4S9Kg0GbbiqBfbIJ+i6CR/I7DC5f8LjTj123R284DS1MGUo+NM38aZFYrqVboFIBap81m0IQcgvMSjdkp6mNqOBYVc+sgjmEIvAgxtUmTiP18T4hYBVOENoYW0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBzx2RCU+zdzX/E/MbtUzDDTmnb+o7ecWVGP6tIgNqA=;
 b=lfX8ICP1IBvn4hyMPZ1M04f9FKGwFEOcoMP0XfCzOcUWwLoVWh7aaH7Q8q0BFqgM2la7d9gJPXeDdjQPeVbcq3MnKPpvJ/YEZXKAlXph0WU/BqSpafv+iqvnt2zkGR1UdERELubxKsmSBo/0V/0qxartXTEw8qxSSA5NRw/DNwFRvTHMQVoDDMfzbeD14ZoCXBfEIegFAxdlCEo2FKcQd3yiHzdlSR7TPRIUjIOF4tgbFna/WpGghmXeSfEYW0CMkIoe8tcWFwhK81vIXAvFXHu7r7tG6CwTjmCBZa0mYXq5oimuxgr11zFQ9BIynvQiICP9loiBcS1Oq4XPDFsNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBzx2RCU+zdzX/E/MbtUzDDTmnb+o7ecWVGP6tIgNqA=;
 b=lp0Ql3qkLj7I6O5h3wloYl25XQpsoATqoz9tQYGBeVGFb1tg2w61toXRFPih+89gaX3Zs3kXjh5DVkkjc44rdSXv4R6O55PD7KVMw5TsBcQdBzoORmz1lFE8NM8W2dCr0tcrI0pgvgipkIfr0IjIbJVdRClkKXcp1+ZoAbdEjzlro25tYUK0T9uWprHkyyo8pkLFSAICZ3+5zGdh1hp5GfqSkpgUhKoDmgrMW7EZO4nucfO0W0J56/LHzzv8LChqzhhZWGWmvoHq3iU7Km/N1wCz2ULHKokT+u7HJ0uS8zqLaeVjvDB7mML1A2Zz/dp9+TyPjDgb7DbTp08fXwiZfg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SI2PR06MB5340.apcprd06.prod.outlook.com (2603:1096:4:1ec::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Tue, 23 May 2023 21:53:23 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425%7]) with mapi id 15.20.6411.021; Tue, 23 May 2023
 21:53:23 +0000
Date:   Tue, 23 May 2023 14:53:13 -0700
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
Subject: Re: [PATCH v7 7/7] hw/cxl/events: Add injection of Memory Module
 Events
Message-ID: <SG2PR06MB33970FFCAC51F65D8F03E204B2409@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <CGME20230522151326uscas1p1033dd1b33e4b95bde4189088fdbcad1d@uscas1p1.samsung.com>
 <20230522150947.11546-8-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522150947.11546-8-Jonathan.Cameron@huawei.com>
X-TMN:  [ECmLKmcyJZ8adE7TDSUmPuClh6ApLaPYkI4vjvMhV1k=]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZG01yWXAcR7VNh80@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SI2PR06MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b28d4d-31ce-482d-f7e0-08db5bd8214f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZvtnnDAxYCgAp+4Mn8kOy6h8xFFEegkOjEJqQZCvQz/nD/s2reqgHXg30RW/K0VcFvYfFoeJUD87H4Oe1pE/7nhvxp5B/QaMJmnbyl3/3BthxyER947tKzAvUV8eqIOgawQEFBnrTVwUZjjZalr3vTlTpDLOGcZ7zw1gac0aIJGUErimcHJLpqmiwrrMb0s4rSSysVJ5PSO4zbGqIcndvjKoqoyC51KBpN34KHJjBR8GFx5qEsP5ItlVc+qHqUzcgRiKh2rINgoZnGKmWMvRCi0P/g1tn5xWMeE85m9dRwA5zzb52msJrrII5qx9chGJBGeovr0dy6xncvgtzUU5336Q5yESx1W/g4Vtv+xfXnA1JoE+UiMfPg4kN4lrnkwKO0mhrgKU7WAGKS7kXUdHWbBpUhknXWRw+pUkQD8g2htKKHZ2TMdWsbKWy7SycYQPCDWPbDVaS9FWeQ0vYJ/DtwEzmLBMwrpZTjTZcuHFVgMIlHhN3fVRykwNuiYGd2J/XmkDdunfrsSyT4yRyrGjCvlqtuw7VUKKgLODNLf+JGzvvNDbr4G7Luy1Gfk1Zw1h4sKTdvWJJL+ahn/t0VoTh0bMCgyJsRiVJxIrpP4OLuu3tl9v0U7rbMetD09YnK9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THQxNmVvQ1J6Q1NuUENYT2xNRWhHNXVGWjF1TjRJVTY1RnlteDJPU3BLMGVk?=
 =?utf-8?B?T3pCZmdGb0d0b1Y2NnpMajM4TWxDdDRnclY4VEpYcFdZNnNOcWgvT25MSm9B?=
 =?utf-8?B?T1k4ck5iSCtjeHlVWFpWUGZsK2lpamRMdC9XOCsvaGdZenVDRDJuS1hoOGM1?=
 =?utf-8?B?ZlRibnc5eEtKZ0NwUTF4UzFsZnQ1TURzN1JqdkdjZnZ3NGp0MCtUUEdvUlg4?=
 =?utf-8?B?V21iL1BTN2d3bkdweU5OcWI2a2t2bVo1UDQxWEV4NlhFeXBvc1hsZ1lyNXoz?=
 =?utf-8?B?dC9FRVppemNPTENvbkFFRkNPbHFsdmdkV1BGVGdlalFxM2F6bS9aMUZtK3B6?=
 =?utf-8?B?NnFhVnROa280czdGS1dJTm91ZGdoYkVZSFpRV2d1QW9XVXpNdnBoeDQ5NHZa?=
 =?utf-8?B?WmxiU3lsUXdnNXBiSWRTY3FwM0ttdnB3ZjdxamJKa3RRbDdhemphNlkyQnlN?=
 =?utf-8?B?TERBdTF5S09yelZ2TEFDcmFLK0FLbmxZTnVMMDB2K09MRExDcHVFbVVTQlhX?=
 =?utf-8?B?NmVES3k0SEovN2lrUVFJdkdQbVF3dUxhbmFCNzVPZ0VCdXlFTXZ2Qy9PVUcr?=
 =?utf-8?B?b21xakpZM0g5MTB5R0tnZlMxL2VndkFBQUJJL1crYzUrcXBFSXRiS0NzcDJN?=
 =?utf-8?B?bjJaZ2Y1SFRKM2t1MlVYRHhOelFid0JSY1g2Q2lRSjNaTEVCTjRrLytwKzVa?=
 =?utf-8?B?eTc2aTFPU2JLbVZpSVMxcElrbWN2Zmh4c0RmU29NM1lqdUNQNlYrbjZwK2lZ?=
 =?utf-8?B?M3kxcFFQTzhaTTlHaUd2S2dZQWE4S2g1b1Z3Q052N1oxR1RQUG1qQzZleng5?=
 =?utf-8?B?MFhmekVqbkhmME0vSFV0dStUSVZWRGhza3ZkTEZ0M0ZXckREMFExcDFORW1V?=
 =?utf-8?B?MG5ucmRGMHlwWlZmL21rY0ZnMTg0RnBKYWk4VVhxdUNqN3poTnBneXJObmxG?=
 =?utf-8?B?bWk0Q0FIdkwrMWYreWhHN0ZsNmpQV0IxbloxbWhlck04MHFpOFJPdXowZEVs?=
 =?utf-8?B?RlVRbWZ1dUQvS1Bxa2ZIREQ2cmg4YXdZSldZeDBDYTR0MDhXWjlSNys1N0g5?=
 =?utf-8?B?bEV5NU0vTkZJUzBKQVpvZkpvcmVoeHY1VlhuU3VJcmhRREFXRVRyTGlDbkZm?=
 =?utf-8?B?R3BaSjI0b1JtR3RvNnNEUFhITUNVMCs1TzQvTmNFL1JuVW5meDlCZm5EcW5T?=
 =?utf-8?B?YS9JaVh1Z1dHR2kwbE9xaGdvdXViSnJxQlpRMTBpWlE2S0F0TSt0a1gyR05S?=
 =?utf-8?B?Y1VzaGw1NEZaN3VmRlZxVU45M1AyS2x4Y0IvUWt3OEtMU1A0TUR3WWdsRHBE?=
 =?utf-8?B?d0dTbTJuZFlSVmhtZXZ0R1A2bVZiSjNNWXFxcWN0TStxTGVXaXlaZGZ0cjJs?=
 =?utf-8?B?MzF5RWN4VUVGdXc3cGZLMXM5SWkxVXAwd1VzQTA5YkF4MEx1WDVab29EOUEx?=
 =?utf-8?B?UDU1OTA2a0pZUldyditQSk5YT1JkcEdIaFFLZXBhWnlzQlpDZFhTODdRc29T?=
 =?utf-8?B?bmtsYkVXVWk3N2pQV1JacjlCSVBwOTByWHN4VGFZYkJaNlNLSlZHYklFOXU3?=
 =?utf-8?B?Y2R2NEFUZ2hnYkNWRThWeGVZTlMyMmdJa3dsWXNPclZrOVZ4NVo4NCtIWlVw?=
 =?utf-8?Q?SMzprNBCHlT/ZtfcfhjjtLLAZ2YNOdBBBWRDhRxSxfDo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b28d4d-31ce-482d-f7e0-08db5bd8214f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 21:53:23.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5340
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/22/2023 16:09, Jonathan Cameron wrote:
> These events include a copy of the device health information at the
> time of the event. Actually using the emulated device health would
> require a lot of controls to manipulate that state.  Given the aim
> of this injection code is to just test the flows when events occur,
> inject the contents of the device health state as well.
> 
> Future work may add more sophisticate device health emulation
> including direct generation of these records when events occur
> (such as a temperature threshold being crossed).  That does not
> reduce the usefulness of this more basic generation of the events.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> v7: Expanded docs for qapi and added a lot of cross references to
>     the CXL revision 3.0 specification.
> ---
>  qapi/cxl.json               | 54 ++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_events.h | 19 ++++++++++++
>  hw/mem/cxl_type3.c          | 62 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    | 12 +++++++
>  4 files changed, 147 insertions(+)
> 
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index ce9adcbc55..05c560cfe5 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -147,6 +147,60 @@
>              '*column': 'uint16', '*correction-mask': [ 'uint64' ]
>             }}
>  
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a Memory Module Event (CXL r3.0
> +# 8.2.9.2.1.3). # This event includes a copy of the Device Health
> +# info at the time of the event.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @log: Event Log to add the event to
> +#
> +# @flags: Event Record Flags. See CXL r3.0 Table 8-42 Common Event
> +#         Record Format, Event Record Flags for subfield definitions.
> +#
> +# @type: Device Event Type. See CXL r3.0 Table 8-45 Memory Module
> +#        Event Record for bit definitions for bit definiions.
> +#
> +# @health-status: Overall health summary bitmap. See CXL r3.0 Table
> +#                 8-100 Get Health Info Output Payload, Health Status
> +#                 for bit definitions.
> +#
> +# @media-status: Overall media health summary. See CXL r3.0 Table
> +#                8-100 Get Health Info Output Payload, Media Status
> +#                for bit definitions.
> +#
> +# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
> +#                     Payload, Additional Status for subfield
> +#                     definitions.
> +#
> +# @life-used: Percentage (0-100) of factory expected life span.
> +#
> +# @temperature: Device temperature in degrees Celsius.
> +#
> +# @dirty-shutdown-count: Number of time the device has been unable to
> +#                        determine whether data loss may have occurred.
> +#
> +# @corrected-volatile-error-count: Total number of correctable errors in
> +#                                  volatile memory.
> +#
> +# @corrected-persistent-error-count: Total number correctable errors in
> +#                                    persistent memory
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-memory-module-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> +            'type': 'uint8', 'health-status': 'uint8',
> +            'media-status': 'uint8', 'additional-status': 'uint8',
> +            'life-used': 'uint8', 'temperature' : 'int16',
> +            'dirty-shutdown-count': 'uint32',
> +            'corrected-volatile-error-count': 'uint32',
> +            'corrected-persistent-error-count': 'uint32'
> +            }}
> +
>  ##
>  # @cxl-inject-poison:
>  #
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index a39e30d973..089ba2091f 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -146,4 +146,23 @@ typedef struct CXLEventDram {
>      uint8_t reserved[0x17];
>  } QEMU_PACKED CXLEventDram;
>  
> +/*
> + * Memory Module Event Record
> + * CXL Rev 3.0 Section 8.2.9.2.1.3: Table 8-45
> + * All fields little endian.
> + */
> +typedef struct CXLEventMemoryModule {
> +    CXLEventRecordHdr hdr;
> +    uint8_t type;
> +    uint8_t health_status;
> +    uint8_t media_status;
> +    uint8_t additional_status;
> +    uint8_t life_used;
> +    int16_t temperature;
> +    uint32_t dirty_shutdown_count;
> +    uint32_t corrected_volatile_error_count;
> +    uint32_t corrected_persistent_error_count;
> +    uint8_t reserved[0x3d];
> +} QEMU_PACKED CXLEventMemoryModule;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3c07b1b7a3..4e314748d3 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1201,6 +1201,11 @@ static const QemuUUID dram_uuid = {
>                   0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
>  };
>  
> +static const QemuUUID memory_module_uuid = {
> +    .data = UUID(0xfe927475, 0xdd59, 0x4339, 0xa5, 0x86,
> +                 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
> +};
> +
>  #define CXL_GMER_VALID_CHANNEL                          BIT(0)
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
> @@ -1408,6 +1413,63 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>      return;
>  }
>  
> +void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> +                                        uint8_t flags, uint8_t type,
> +                                        uint8_t health_status,
> +                                        uint8_t media_status,
> +                                        uint8_t additional_status,
> +                                        uint8_t life_used,
> +                                        int16_t temperature,
> +                                        uint32_t dirty_shutdown_count,
> +                                        uint32_t corrected_volatile_error_count,
> +                                        uint32_t corrected_persistent_error_count,
> +                                        Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLEventMemoryModule module;
> +    CXLEventRecordHdr *hdr = &module.hdr;
> +    CXLDeviceState *cxlds;
> +    CXLType3Dev *ct3d;
> +    uint8_t enc_log;
> +    int rc;
> +
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +    ct3d = CXL_TYPE3(obj);
> +    cxlds = &ct3d->cxl_dstate;
> +
> +    rc = ct3d_qmp_cxl_event_log_enc(log);
> +    if (rc < 0) {
> +        error_setg(errp, "Unhandled error log type");
> +        return;
> +    }
> +    enc_log = rc;
> +
> +    memset(&module, 0, sizeof(module));
> +    cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +
> +    module.type = type;
> +    module.health_status = health_status;
> +    module.media_status = media_status;
> +    module.additional_status = additional_status;
> +    module.life_used = life_used;
> +    stw_le_p(&module.temperature, temperature);
> +    stl_le_p(&module.dirty_shutdown_count, dirty_shutdown_count);
> +    stl_le_p(&module.corrected_volatile_error_count, corrected_volatile_error_count);
> +    stl_le_p(&module.corrected_persistent_error_count, corrected_persistent_error_count);
> +
> +    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index e904c5d089..f3e4a9fa72 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -26,6 +26,18 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>                                 bool has_correction_mask, uint64List *correction_mask,
>                                 Error **errp) {}
>  
> +void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> +                                        uint8_t flags, uint8_t type,
> +                                        uint8_t health_status,
> +                                        uint8_t media_status,
> +                                        uint8_t additional_status,
> +                                        uint8_t life_used,
> +                                        int16_t temperature,
> +                                        uint32_t dirty_shutdown_count,
> +                                        uint32_t corrected_volatile_error_count,
> +                                        uint32_t corrected_persistent_error_count,
> +                                        Error **errp) {}
> +
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>                             Error **errp)
>  {
> -- 
> 2.39.2
> 

-- 
Fan Ni <nifan@outlook.com>
