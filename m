Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9050C7EE2E
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 00:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjEWAYe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 20:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjEVX2A (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 19:28:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2039.outbound.protection.outlook.com [40.92.52.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E255E1A4
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 16:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLvfesz20zMhtzI2UiIm7SVURAP8lbqVgXUo1QEL80SdrTG4pu3lhgotwLMqcJbrZwrljwTGslCmzKuNFEFGEsYGdBehc3oM48wEvW62VZdfcjGy5CEuSCJpe9Sccz0RRPDTvaRjG9kjV5ykuTq+Ad4PRGzMDSzyWYQ+L3wjdhTOPINyyU3rEGUC1vvrqL8m6m5Lh361rA5Iar4TSyMytEpIP+0fomXqFRzIVRzTrBDFZEjyS7eN7dz4Bg3+DLy+JBF5hvb0Pi4k+8oEgQyoC0p4Yaq08Dd/PA8F+azKdGcl/5cxR/1f+cQGZ/gQjpSPpD8tz64vZTVgiB+q6sNvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kah9xYMgZc1cORzgg/Skr+yN/PXwUTof4jYFR4ej7o=;
 b=nRHk2ZuNcBgAs2wNS/zac+sL7Ba7skeVamv1QBTg/KhkdL2DX1a7eo4TJFU1xsEOAxQDg/TW0WJzN7CAEbYAmJnWaRlN6yR0iRLZ7RVTJsWTe0heco1OQM96rMDx8SR9RkA07Indd1awf/UPb6yuCpX1szS7TPuykCLYAY3uCNKHuhEjVSdDmtUQLfF159r/fKgWt1usOTGtUPd5ENIGsSGldF9jUNmUgDsx/bTE5u70k/Nto436sjnZctXvZq/HBiDzbsYvq2vDp3gkp3n4Fjn6Ov2YCzgoNjtVCScCuvgpaf7UhRn0BZwurdLyz/Jycaj/kIlcnZx29NOvEgj6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kah9xYMgZc1cORzgg/Skr+yN/PXwUTof4jYFR4ej7o=;
 b=ohnxygqCe5Zb4YnoHW2QH25FpDwkcewHwFKUPA0j4vzHrtJnS9mmpRhUuLMCPXmkAzH+ikQ6NaiNhDf36S85tmtcwtSIRAda2EetJ2YCRwEVSc5XNNmeSq/KwaHitBQctm/bimWvBu/Ul7ITL9p75Kr/Zwr5KnD6AGCPhNx+uOnRmQyg5EjhCSzeaTXG/PcpfJIJONn/nYChv2lHNPd/iRiMnxUZPaSkSOyBrG9QSt3oeXGqaPfZvvGGSrAmRa+cO97X0E/49EA1MJiKvsoI93tkrU8cJz0Tj95MpvMA7RwGD9BguvRzYvPy4QH+NbYw61277/hR1nEdU6JCIfS06A==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.27; Mon, 22 May 2023 23:19:38 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425%7]) with mapi id 15.20.6411.021; Mon, 22 May 2023
 23:19:38 +0000
Date:   Mon, 22 May 2023 16:19:28 -0700
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
Subject: Re: [PATCH v7 5/7] hw/cxl/events: Add injection of General Media
 Events
Message-ID: <SG2PR06MB339713607428B5C4B3748586B2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <CGME20230522151228uscas1p20e6e90e3ecbfb7ad237a043a86252d85@uscas1p2.samsung.com>
 <20230522150947.11546-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522150947.11546-6-Jonathan.Cameron@huawei.com>
X-TMN:  [FHVODIAGbQ+9c8LTucd9XzXHE/SNg+99R3QOGq+R4c8=]
X-ClientProxiedBy: BYAPR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:40::29) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZGv4gJ//roEEf9wk@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TYUPR06MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: ed156c3e-fc61-4a8b-dc20-08db5b1b0357
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayE5CJPSKkfc+gH+CEmTXh/KLd+d5Ug5U49ffe1OJSn8DE4FKEFHFmjA8n0sx9I/vaVRv4rpnkZt706vrN04VHwm1WJjIpLiY6uiouw7wVBn76ugfvveUAGFbjnNPUyH2V+kOSS/QfqMxkrOgAD3tmhro22ecRPbE0fOPM8ovhYRGXxacyOXk20WYa2bikh5FBJkEYai71UI0R+DCoB5P7MR9S0FrVeVJRJw34NDt766pRbW8RBEOgqx0trQ+ycn8etSl2HMXJtgBXomqOgeVh6MD5+6iUA44XCSh9EgcPp/V2gpGhJdNc/6Cr5dvHbhFtrCkHklTMD8hk+hhp/aQu2xhTDm1SACOe3qlCxu73RaE7eYNdyMcpEeC/CWzD5Ya1ltOX/BKHp8XAnY/7pQCkQJuQifOZAP8Icj5NCrtrPBACa2Fp3HXwDJmZXTB1p/G4vxBPTvV/Lcw3HlAr16jrWEYwBPJB1/JOLHBPqw+0LxGiy5ma6xqM0bWAxpHWeoHs9J0XOm8/cYqm1KgHd0/5qcwOpeHrMdD4M/VjdkD8k4/bBMTwN5tBaEYo1A1djPB7gpw7g3DHydR6+EAxZZkimW95cWeH6RHrnmtAPEe2Un4q5eVdAKJgiwe8bi0l1cH40db5vrwS5cBGghmvvw9YaqvoUk2f7jOoxjdHGuo2qqtxCDQHqZymDovrTu0jgny56atYphZOEEzdb0h/ssnEPpLKhgq8laVaU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPBt9L75EHfWUDExsyuhrSO0tqs5TbxnniVtjuGWw4CBlmQ92WYKeQcSUWauTbpaYwRhOYPSyE+JEjAdGB7tBXISsyM91sKYezjUk5EJDGMFDps/ZJ2RiuV2bnh7vaiS8w0SdA3kt70UOjd/6IfWwF6dH0G+oUvKoiBAVdjqy+xRuG3xl9sv+dH6mv7S9vHSmC8eV4h3ThMlhN/tzLfA0QDNvRy7hsgKQqVULE+27cv4gJJu6gsRckQ78WPfY8ot5vCVrt8UAR7+i7TUO6mHqG/bkV1soSZiaqeq5ur/ZcI8wNV+ZH64awBu5Zx58hYU+oRi5iDJa6LzyB6IJl0Ush8JztysupeolFzBHrjIaShVk7OZcLYRzuQ1G3rFQXv9hWvytbyyySPQFCweLHz3FJ0RpOQztsvpRFAJDtRxYM/hZXrlPnZqo2eHuLZPMQ54mxgnDSYrLsSPe//eFpG73mvYWJ8OaUMq5fWyXRYqrDqjswacS70Bo9/6+d6wC3zVIMPOYkINKMdvdIIAa7S86aNWp6/7P0pe+9/vy1mSwzXZq5mQmGhxJalHTprUj2PO/+JIZ8t1sxnKaggraJVUKrbeCq6QKv41Ugs4PchLrsNhTYUqU8LPTYYnOcxjqhlPjflSX/7lo4dt3MH88srTQw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ri93VWxxSE9NT0cvZm1XcUpXaTJRWml1bk1GODRUYm9rOExKSjg1WUFKNGVM?=
 =?utf-8?B?THlVMUd0SjVSZVBkSm8wcGZvM2RLNnNmd0gxejlzSmVKdElSN1Vzd3NnZzBL?=
 =?utf-8?B?V3p0TGhBYjdLVU1yaGRvNXN3YWZtVVJXNjY2RExlY0JLcHN5OHJOdVZ1Ymxh?=
 =?utf-8?B?SDFCd2VLbWhZdzZCTWJNLzVQQ2JwV3kwdGsrbVVPcXpPMU1MM2JubktCOHJJ?=
 =?utf-8?B?OHZMMy9wVzQ2aWhEOE1EemRib1J0WmhUcTZjcnVKTjhkZnVWYWhrVncxOXZa?=
 =?utf-8?B?ZUFqMU16ejhwSWJ6d2VHTkcvd01xUXY1dDJKYmlOLzIxbWZ2dEZ3VEplYmZh?=
 =?utf-8?B?VktkKy9aR2JMY1h3QXFoNE5lYlFGSkdyVVI4enFLaGRNaFk2WGsrVVdsOEE0?=
 =?utf-8?B?NmtWSzlUQXhRRFNTQ1JJUmJnR0NvZjhWaUs0L3oxQnEyZjdxWTM1T0ZXUEh0?=
 =?utf-8?B?RUl6dXA3YjZuNzlWQzE2MjIyQ1BVQ0JPdDd1ZjlJS1JsQTR4MW5BM3pZaEtk?=
 =?utf-8?B?eVFzaFZ1WFV2SGxmNzZpVmY5eWYxTCtzdXpydWdPU1R2NFBSMVVWUmVMZXVW?=
 =?utf-8?B?SWY5YTQ0YjVTb2NxZjhySzBEbjNud2gvMXlNVENuQnpsRE5lTlluekljZytR?=
 =?utf-8?B?bjF6OVFVdWY4MFZ0M0RnYUl6NkRBeHhiV2xDRFl2L0pBNGJYMWZrT3lQekMy?=
 =?utf-8?B?eW9tT3dtT2dLU0RyRlR4OGJpYjhRSzd0TXRBL3ZGL0k0YVVnZ1R5T0xsMSsr?=
 =?utf-8?B?MG5GMlN0OHg2cFFMSjQrVlJZV01ZTGxDUVNnb2IyNmh4bTJQd2FRNmxCTmp4?=
 =?utf-8?B?MG5OekdnRkJGOG8ybThYRGVndzVYa2xTNlVyZERYU1NReFJRU0ZmZFJGb0tB?=
 =?utf-8?B?ZlpnNFFkVHgvdTd4TXNQUzlzbFpHOHpVUWs5Vk1WUWRiSG83dTVtZVo5OTE4?=
 =?utf-8?B?MyttTGFHTE15YmpJWkFHWUZ2M1pzV0Z2Uk0xeEVxRk1rQ0FlSzUvRjN3ZEpt?=
 =?utf-8?B?dmNNbFNpeTZLY2xsWXZaQll0R2xkbk8rNkU0WnA2VjB1b1FaR2VYZnpUUGdN?=
 =?utf-8?B?RFpnL1pYMlBxSkp4eCtEamYyQUxGS0M4cUxlZ21LeGtSdEtuSG5IT3ByVjRj?=
 =?utf-8?B?Kzl5YW15V3YzYzVPOWEzemlQTkdDd0dvTVpWUmI2RUt5NkVTNkkwdHExUDk4?=
 =?utf-8?B?Y240dlNQS09MdXRKZHkzYUJIL1FmSjE5YmF2REUrQVllSmtOUzZyM3JzWWxh?=
 =?utf-8?B?S1Ewek5TczhEcGt3OGdFd1VrZ1NMcXZsTGRqdDlhOFlWd3V6cGN5b1JXdGhy?=
 =?utf-8?B?Yy9tckNVY3JzbkdLYnB3VHNuSHpiMStIN28rTkJVZ1E4ZVhzbWZNRXlBN095?=
 =?utf-8?B?WG12OHhja1FVMExJZDZUVUhJdVM0YmcvL0FLb0ZSSjNHOWt5WWVnbmlJS2Yx?=
 =?utf-8?B?MWZoUXZZTnNpaFpXcmlSQThUOW5VaU4zRmZwdWV0OFpOWmlSTG5lNCtCSWFO?=
 =?utf-8?B?U3VERVdLS2pueldqQjFKQXNtMi9zdEhXRld0Q25LQTN2Q2xRakRpMGtLeTBy?=
 =?utf-8?B?c2JCaTZDanlVSEJFWkoyYm9iSTJIZ2gwNlBvV1QyaG80N0x3cXl0bDRjODkw?=
 =?utf-8?Q?wwpE6/jzhurTBynQVUdN7LRDRP3vnUR1SU6/CWxWKTec=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed156c3e-fc61-4a8b-dc20-08db5b1b0357
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 23:19:38.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6219
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/22/2023 16:09, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> To facilitate testing provide a QMP command to inject a general media
> event.  The event can be added to the log specified.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> v7: Various docs updates and field renames including a lot more
>     specification references.
> ---
>  qapi/cxl.json               |  79 +++++++++++++++++++++++++
>  include/hw/cxl/cxl_events.h |  20 +++++++
>  hw/mem/cxl_type3.c          | 111 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  10 ++++
>  4 files changed, 220 insertions(+)
> 
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4849fca776..7700e26a0d 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -5,6 +5,85 @@
>  # = CXL devices
>  ##
>  
> +##
> +# @CxlEventLog:
> +#
> +# CXL has a number of separate event logs for different types of
> +# events. Each such event log is handled and signaled independently.
> +#
> +# @informational: Information Event Log
> +#
> +# @warning: Warning Event Log
> +#
> +# @failure: Failure Event Log
> +#
> +# @fatal: Fatal Event Log
> +#
> +# Since: 8.1
> +##
> +{ 'enum': 'CxlEventLog',
> +  'data': ['informational',
> +           'warning',
> +           'failure',
> +           'fatal']
> + }
> +
> +##
> +# @cxl-inject-general-media-event:
> +#
> +# Inject an event record for a General Media Event (CXL r3.0
> +# 8.2.9.2.1.1) This event type is reported via one of the event logs
> +# specified via the log parameter.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @log: event log to add the event to
> +#
> +# @flags: Event Record Flags. See CXL r3.0 Table 8-42 Common Event
> +#         Record Format, Event Record Flags for subfield definitions.
> +#
> +# @dpa: Device Physical Address (relative to @path device). Note lower
> +#       bits include some flags. See CXL r3.0 Table 8-43 General Media
> +#       Event Record, Physical Address.
> +#
> +# @descriptor: Memory Event Descriptor with additional memory
> +#              event information. See CXL r3.0 Table 8-43 General
> +#              Media Event Record, Memory Event Descriptor for bit
> +#              definitions.
> +#
> +# @type: Type of memory event that occurred. See CXL r3.0 Table 8-43
> +#        General Media Event Record, Memory Event Type for possible
> +#        values.
> +#
> +# @transaction-type: Type of first transaction that caused the event
> +#                    to occur. See CXL r3.0 Table 8-43 General Media
> +#                    Event Record, Transaction Type for possible
> +#                    values.
> +#
> +# @channel: The channel of the memory event location. A channel is
> +#           an interface that can be independently accessed for a
> +#           transaction.
> +#
> +# @rank: The rank of the memory event location. A rank is a set of
> +#        memory devices on a channel that together execute a
> +#        transaction.
> +#
> +# @device: Bitmask that represents all devices in the rank associated
> +#          with the memory event location.
> +#
> +# @component-id: Device specific component identifier for the event.
> +#                May describe a field replaceable sub-component of
> +#                the device.
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-general-media-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'dpa': 'uint64', 'descriptor': 'uint8',
> +            'type': 'uint8', 'transaction-type': 'uint8',
> +            '*channel': 'uint8', '*rank': 'uint8',
> +            '*device': 'uint32', '*component-id': 'str' } }
> +
>  ##
>  # @cxl-inject-poison:
>  #
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 4bf8b7aa08..b189193f4c 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -103,4 +103,24 @@ typedef struct CXLEventInterruptPolicy {
>  /* DCD is optional but other fields are not */
>  #define CXL_EVENT_INT_SETTING_MIN_LEN 4
>  
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
> +#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
> +typedef struct CXLEventGenMedia {
> +    CXLEventRecordHdr hdr;
> +    uint64_t phys_addr;
> +    uint8_t descriptor;
> +    uint8_t type;
> +    uint8_t transaction_type;
> +    uint16_t validity_flags;
> +    uint8_t channel;
> +    uint8_t rank;
> +    uint8_t device[3];
> +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +    uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
> +} QEMU_PACKED CXLEventGenMedia;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c9e347f42b..b1618779d2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1181,6 +1181,117 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>      pcie_aer_inject_error(PCI_DEVICE(obj), &err);
>  }
>  
> +static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +                                    const QemuUUID *uuid, uint32_t flags,
> +                                    uint8_t length, uint64_t timestamp)
> +{
> +    st24_le_p(&hdr->flags, flags);
> +    hdr->length = length;
> +    memcpy(&hdr->id, uuid, sizeof(hdr->id));
> +    stq_le_p(&hdr->timestamp, timestamp);
> +}
> +
> +static const QemuUUID gen_media_uuid = {
> +    .data = UUID(0xfbcd0a77, 0xc260, 0x417f,
> +                 0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> +};
> +
> +#define CXL_GMER_VALID_CHANNEL                          BIT(0)
> +#define CXL_GMER_VALID_RANK                             BIT(1)
> +#define CXL_GMER_VALID_DEVICE                           BIT(2)
> +#define CXL_GMER_VALID_COMPONENT                        BIT(3)
> +
> +static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
> +{
> +    switch (log) {
> +    case CXL_EVENT_LOG_INFORMATIONAL:
> +        return CXL_EVENT_TYPE_INFO;
> +    case CXL_EVENT_LOG_WARNING:
> +        return CXL_EVENT_TYPE_WARN;
> +    case CXL_EVENT_LOG_FAILURE:
> +        return CXL_EVENT_TYPE_FAIL;
> +    case CXL_EVENT_LOG_FATAL:
> +        return CXL_EVENT_TYPE_FATAL;
> +/* DCD not yet supported */
> +    default:
> +        return -EINVAL;
> +    }
> +}
> +/* Component ID is device specific.  Define this as a string. */
> +void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
> +                                        uint8_t flags, uint64_t dpa,
> +                                        uint8_t descriptor, uint8_t type,
> +                                        uint8_t transaction_type,
> +                                        bool has_channel, uint8_t channel,
> +                                        bool has_rank, uint8_t rank,
> +                                        bool has_device, uint32_t device,
> +                                        const char *component_id,
> +                                        Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLEventGenMedia gem;
> +    CXLEventRecordHdr *hdr = &gem.hdr;
> +    CXLDeviceState *cxlds;
> +    CXLType3Dev *ct3d;
> +    uint16_t valid_flags = 0;
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
> +    memset(&gem, 0, sizeof(gem));
> +    cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +
> +    stq_le_p(&gem.phys_addr, dpa);
> +    gem.descriptor = descriptor;
> +    gem.type = type;
> +    gem.transaction_type = transaction_type;
> +
> +    if (has_channel) {
> +        gem.channel = channel;
> +        valid_flags |= CXL_GMER_VALID_CHANNEL;
> +    }
> +
> +    if (has_rank) {
> +        gem.rank = rank;
> +        valid_flags |= CXL_GMER_VALID_RANK;
> +    }
> +
> +    if (has_device) {
> +        st24_le_p(gem.device, device);
> +        valid_flags |= CXL_GMER_VALID_DEVICE;
> +    }
> +
> +    if (component_id) {
> +        strncpy((char *)gem.component_id, component_id,
> +                sizeof(gem.component_id) - 1);
> +        valid_flags |= CXL_GMER_VALID_COMPONENT;
> +    }
> +
> +    stw_le_p(&gem.validity_flags, valid_flags);
> +
> +    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index fd1166a610..4dfbdf9268 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -3,6 +3,16 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-cxl.h"
>  
> +void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
> +                                        uint8_t flags, uint64_t dpa,
> +                                        uint8_t descriptor, uint8_t type,
> +                                        uint8_t transaction_type,
> +                                        bool has_channel, uint8_t channel,
> +                                        bool has_rank, uint8_t rank,
> +                                        bool has_device, uint32_t device,
> +                                        const char *component_id,
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
