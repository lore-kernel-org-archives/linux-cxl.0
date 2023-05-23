Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423ECC7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 21:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbjEWVxE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 17:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbjEWVxD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 17:53:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2068.outbound.protection.outlook.com [40.92.107.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA3C2
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 14:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv9YjjvUGOJ/xSmdlz6sAhy22iw1sa4ocBD/rNmo904RHrpehfCv7pKxAZkVS0xDnBDTawvA53RHjcWa4hFYSVcyHNxhLzYdPuNOUGS7XudK7iuIq9Dj4ojGm1hNxayAdpGdDN2PSb6ojg7UCJg7xeRof3r0MPOGMTQbEOEo4MZcrO+LLLKL3X8e7WJQ3t/AlJTUJ3UoEehYOzD85sgyMacvQrOtkAO343ajqHvivYf3Lb90Ra5JB4M+igdLiExtlgMEH8SKgbGUBQvm4dRZ5W/JzTtmSMk9DPCZgUj4EoETq3+4P+228eobBbGdHEbLeDGEi+QmnRXY22HvRAY4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/UsZ2om53p4rrFpa34bR3PnXUK2l+uUyGdDNoBkcTM=;
 b=mKVxMHWWIY7DTYDzFy4Qpjwlck8TXvCHXFZAXMrZXkILFI3cU+TLH09STDQrno/as3h7oRZKW1MqIbc9l4VTmsKRqkiQDOuClXepelGXQqHGdQU6Aae1PW2nPDHNRhGwarUTPWjucxS8DM987QcfrMJU7bdYcylgaRr87XlT6+tM53fL2G7M4q4/8lrHuPcAc7t4EkV6iEcnQREDWH4WSblRo0+3gEd/EW+6LEGw96yZaXfKEy7DVWgh4WXwKhT1+NbU6cP2S/tK1bpkYKfTAajdm5FYQZmGX5/ZLnC6l5gXyOarnx8BrQ30noUJzZsO2aynbArmpmDFgTDArtU1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/UsZ2om53p4rrFpa34bR3PnXUK2l+uUyGdDNoBkcTM=;
 b=G9iP8za/+5gfO2MJnUwWLVwfCgfpA7nLGBC59s181O5mj/QmFlruJwhHlZKlhgU6QOKYalBAf11PG3Y7qwwL6g7bUa7c/28BzqchUU1H7KETzz5cv4hMlHvwFzONxte+iBus0/ZTR41BwoFVrBbT8ECjczk6JOyVhZWg7mptEYe/APN8m02zH6VRWKNWMm7CWjrMR5qvDvifxz1380Ko+xhwJqctWtXTn/K8UXV5ZrgLNpLywKpxIaJIcE/X2uVPX50PSpVbACv2QGe/Y9Nkiu1W4xJF44zMrRz4fPxQ8Ic6IUtF0dkWs0lDdPpwqSUNjSV5O5pVyy7MGslCyISENA==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SI2PR06MB5340.apcprd06.prod.outlook.com (2603:1096:4:1ec::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Tue, 23 May 2023 21:52:52 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425%7]) with mapi id 15.20.6411.021; Tue, 23 May 2023
 21:52:52 +0000
Date:   Tue, 23 May 2023 14:52:37 -0700
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
Subject: Re: [PATCH v7 6/7] hw/cxl/events: Add injection of DRAM events
Message-ID: <SG2PR06MB33977FCBF929CD33216F5E89B2409@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <CGME20230522151257uscas1p17b46f19e5bafcd199f099f1545839422@uscas1p1.samsung.com>
 <20230522150947.11546-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522150947.11546-7-Jonathan.Cameron@huawei.com>
X-TMN:  [7xxMuz3NX7zsbNTcQmqh4attj0zsOZanN7/jTgTbBGU=]
X-ClientProxiedBy: BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49)
 To SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZG01dP+OW5keMKz5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SI2PR06MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: ff22b387-4150-4f5a-f6a6-08db5bd80e71
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayGvrfbU1mG7FQrbYU5luE8SkvIyaWREbx2k70sXsiSepZyndOoU6wTZwA6ZNWaAFARpwgdvDfTvGF2Ye2xbaTIfaxXw2SyzsTHMVxP3YKHiKIltFXCWbcrNUbMQKyVyHSQGg4EcNa723wEieV5QxjPc6cvmVZVknTp+u7WiaQVkLL1C86OOpJvImbMVnPoUEDxT8Zj/R8NqEjg/mCQUZWv2AN5AL0fp4XofwY67IWoG3rT8xK+Os4VvgmI2RA+7PdhndoEvCrsjS+b11TUfhY9Z6uNo10EQG/8A5zxm2/7rFiW8rDOl7fZP7+u1sZZUuV8p3p+MCizdF4Ri5QVF7KBZ+LHGpQBfAkcYt3ICyn7249sOpQT6ChQtQd1lj40XzSv7KCw0Q7ioPIG5EUgi0FQpJ8M9/pejPcBHSCjA7PJ/5kX5ZgctKFiCi8IphWfgvflicFurLZDdcebTrU7uNnFUrbtCm7ojHiLxZy+7Ho0y7QulkCM1It1h3GjLGg6WYoz5UB13K26UzJaQw1xvJaeDJMb6HuBMwDUxBIHWV56YinYzptrE8VhFTG4CwhM3ayXwdCBTrKVzAfv4FT9hTqmBrTowAnifsrFRhTJMg77M0lbBS7tInML6pgKOclhJp0fDce3am4vL4cbiDKjz65YmboGDLCGIS1ASlowkn+Gp1gq064WgOIm4X1s/mfXjPcNjzRq8FUGXTTSVE8zVAq4Hy+U4j53RYZc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWSrOk+wcYdDqOf6cR2XEo745kdHT6e3/uWVvjLKuvhpSVEK/cuBoUsQpxjZOiJK4Dafn3z3YAzDvWrUlBKwkWkdrsNFwt2sGEk9PSAFIdb+sATABr7eOXJS3uztBouE3Un1xbOZZP4T1bqxNDUZ8kVek0f8AAEq3VR5sxyeQRSRiZ05VnJUOB66nVPP5pvgQWxGJjTOH8QuiwB3iHbiELMxAL6oD2ypmDP0a9Z/nPJcPBUlwizg27ztcDBHAzvJj2YfnfAx4Jyu5jcOe/j0hnNab9YqbcvAiuTGB/W/X6gvOgjTrVkgUbfKXqUVn/lQsClxfiyw52k6jXMguv7mA0lIwfkxAssxfju0aOrAC733Bgxxl0g1oraswL/+oQDNi/IIELoqIizQZVY3f80iKkjGjFaNZg6FRvkmbcqYJDt9RcSuZ3gGqeEnIxmhLU4UKimTBTTRiDb84Eewvkz+1ZRH23FQdvwOV8nBUnTr8DVN6sVrK/oA7JCYijR6vJT1HT2XJCx0T+r6N2dXmFhBvysATe7IvMdIC0e5fBaxYGuZo07yaqCiE/7vpxnNE0QJDx4Ewf4ZQdPPWhgyjlMq4mx87x8t/PlUCpzLqRGlENMxLq7zK3ENZbZ6fXq4PbXfbw4sEETZ8wb0oLUVtXZnBA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1BVTDQrSlduQkc0RHVHakxjU2NrckZrdTQvK1lLT3JhRWlKYUlIOW1WK0Fn?=
 =?utf-8?B?aUhyZ2I0QnkzQmUwbFJDd24zTlpaaGsxSmxsZXFZMlp3Z2JVL00zZ1BJdS9l?=
 =?utf-8?B?N2tBSmhqTGd3YmtGUGl6Y2lEWUdPNkdvNkxVcDIwSDlmaWxObEJCeHcxQ2t6?=
 =?utf-8?B?VGxGYTk5NDRacE1JTExuL0REZFl3VHcrL0dmS2h2VHBUQWxxWGNRT3FtdUpI?=
 =?utf-8?B?c3NQUDFUdk8vNk5idktJNHdXL2JVRFE2NC9xOTkwSTNzVTd3MHNPVCtPUStj?=
 =?utf-8?B?dWtKMFphTXNXU1JobTNFbmx5SjFOT0VjQUFXUFAxNDk0YldqYTFYcWtYRnZD?=
 =?utf-8?B?WTBreUhZWlMzZm5xQXVoV21UKzNyWG50NlNqUUZFQ2FYeEhTQms3S1VPRU9T?=
 =?utf-8?B?dFpKT0JuQjE1NTF3cVZBanA1cCtHcUZrcUlJdGZmUHNQWnZPSHdaWEJsMWZr?=
 =?utf-8?B?UHNqNklKY2dZZjlFMEJKWHZmSXd2eWx2MHpScno3MVJqRUtTU3BBc1pkdUND?=
 =?utf-8?B?Vm13bm55MVhHeWZpS3Q1Y3RTd2tQcFhUdTVqZWQzUnFDUjNwMGphOW9hRXR1?=
 =?utf-8?B?TFI4K1plNmkvSG03TU1pc1krbTQ2TlJhYUJTa3Y5aWYwYXU2M2FzRmRJVVd5?=
 =?utf-8?B?UllLNzJNelpOWlFGd24vd0w0SFNPakU0KzN5R0hhWURTNjRxSUVGWEtSOC9U?=
 =?utf-8?B?OFZwenlvK0RUZThUUHkxK2ZFSlVZSGtYaGpQVzZ2ZHB5TldVTDlnQWF3MnJE?=
 =?utf-8?B?OTFObDNSeVNnOUV2RnRDKzhPUGRZUmtWT0hxUlJqY1d1L1VqNFUyYnJscnR6?=
 =?utf-8?B?SStPZURFTGxuSjkwUlFLYTVSZUxaY3dJSEVjR091NVJlSXVZZG50QzR3QW5C?=
 =?utf-8?B?V0tob1RpVktUWTUxL2laSWlDaXN0WExSN1RmR0djQWFhS204aVRlWE1CdEpp?=
 =?utf-8?B?UExqVWxzd2d1b0RZU3lTTzh6MmNhTm5TTlpRVWYrYWlnMjVhMUplMnJaMjBj?=
 =?utf-8?B?REN0Z1lPaWM4VzBUWElPYzd6N2N2alhMdmNGZDM3Nmc0ZWV0R3hXU0pWekRv?=
 =?utf-8?B?R0dmb28vTnpMb0dJME1jd3I3ZlpSVmxWUG03L3l3WVVYcUVUbkwxNGFPanpK?=
 =?utf-8?B?cFNzSVVCendjV1YyU2ZyYUp3TDkwbTRqczdOcXY2V1c5MzdrdzV0UmpKWnBJ?=
 =?utf-8?B?Vm1ZVTJKWkkrK3ZMdmxPR0gxZTNLcEd5bEE1QTdTOWJoSHhoOHJhVTdDQlRz?=
 =?utf-8?B?WEpac25kalBmYkRBVjh5TDhybmdpdlVMZXoxSmt1WUFLR2FLK0dLVlROV245?=
 =?utf-8?B?WHRzbEt2amlBUkwxM3YzSTFTam02QlZoeGpoSitJRzc1ZWMxYTJPVVV0cit1?=
 =?utf-8?B?bC9QSHkra2tLdHVyTTFJcXNtWDdwdTRaM2Y0bktWQndoOURNcm5OS3RhVk5w?=
 =?utf-8?B?V0dReWZCZ2F4U0piRnZhUGVTUTYwVDlKVUdsVDRDZGlIY09MRUZCYVZpeGEr?=
 =?utf-8?B?Q2RSM3lUM3NpZkpyaDhZaFU0NkYrSndBRUI2UXk2RWRRMWlqVmxCdUk2OTlL?=
 =?utf-8?B?NTIzdllnbWEvOTdnVy9DNnVPdko3eGVrSTZ1L0NuR3MvZDZ0Yml6bGd5R3Fl?=
 =?utf-8?Q?+6OBqKSX3DX/dXPUSXrFPDAHxsP2ltJM+CH6TBAy4+js=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff22b387-4150-4f5a-f6a6-08db5bd80e71
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 21:52:52.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5340
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/22/2023 16:09, Jonathan Cameron wrote:
> Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
> provides information related to DRAM devices.
> 
> Example injection command in QMP:
> 
> { "execute": "cxl-inject-dram-event",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "log": "informational",
>         "flags": 1,
>         "dpa": 1000,
>         "descriptor": 3,
>         "type": 3,
>         "transaction-type": 192,
>         "channel": 3,
>         "rank": 17,
>         "nibble-mask": 37421234,
>         "bank-group": 7,
>         "bank": 11,
>         "row": 2,
>         "column": 77,
>         "correction-mask": [33, 44, 55,66]
>     }}
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> v7: Additional documentation, plus rename physaddr to dpa reduce
>     confusion
> ---
>  qapi/cxl.json               |  63 ++++++++++++++++++++
>  include/hw/cxl/cxl_events.h |  23 +++++++
>  hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  13 ++++
>  4 files changed, 215 insertions(+)
> 
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 7700e26a0d..ce9adcbc55 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -84,6 +84,69 @@
>              '*channel': 'uint8', '*rank': 'uint8',
>              '*device': 'uint32', '*component-id': 'str' } }
>  
> +##
> +# @cxl-inject-dram-event:
> +#
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
> +# This event type is reported via one of the event logs specified via
> +# the log parameter.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @log: Event log to add the event to
> +#
> +# @flags: Event Record Flags. See CXL r3.0 Table 8-42 Common Event
> +#         Record Format, Event Record Flags for subfield definitions.
> +#
> +# @dpa: Device Physical Address (relative to @path device). Note lower
> +#       bits include some flags. See CXL r3.0 Table 8-44 DRAM Event
> +#       Record, Physical Address.
> +#
> +# @descriptor: Memory Event Descriptor with additional memory
> +#              event information. See CXL r3.0 Table 8-44 DRAM Event
> +#              Record, Memory Event Descriptor for bit definitions.
> +#
> +# @type: Type of memory event that occurred. See CXL r3.0 Table 8-44
> +#        DRAM Event Record, Memory Event Type for possible values.
> +#
> +# @transaction-type: Type of first transaction that caused the event
> +#                    to occur. See CXL r3.0 Table 8-44 DRAM Event
> +#                    Record, Transaction Type for possible values.
> +#
> +# @channel: The channel of the memory event location.  A channel is
> +#           an interface that can be independently accessed for a
> +#           transaction.
> +#
> +# @rank: The rank of the memory event location. A rank is a set of
> +#        memory devices on a channel that together execute a
> +#        transaction.
> +#
> +# @nibble-mask: Identify one or more nibbles that the error affects
> +#
> +# @bank-group: Bank group of the memory event location, incorporating
> +#              a number of Banks.
> +#
> +# @bank: Bank of the memory event location. A single bank is accessed
> +#        per read or write of the memory.
> +#
> +# @row: Row address within the DRAM.
> +#
> +# @column: Column address within the DRAM.
> +#
> +# @correction-mask: Bits within each nibble. Used in order of bits set
> +#                   in the nibble-mask.  Up to 4 nibbles may be covered.
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'dpa': 'uint64', 'descriptor': 'uint8',
> +            'type': 'uint8', 'transaction-type': 'uint8',
> +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
> +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +           }}
> +
>  ##
>  # @cxl-inject-poison:
>  #
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index b189193f4c..a39e30d973 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -123,4 +123,27 @@ typedef struct CXLEventGenMedia {
>      uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
>  } QEMU_PACKED CXLEventGenMedia;
>  
> +/*
> + * DRAM Event Record
> + * CXL Rev 3.0 Section 8.2.9.2.1.2: Table 8-44
> + * All fields little endian.
> + */
> +typedef struct CXLEventDram {
> +    CXLEventRecordHdr hdr;
> +    uint64_t phys_addr;
> +    uint8_t descriptor;
> +    uint8_t type;
> +    uint8_t transaction_type;
> +    uint16_t validity_flags;
> +    uint8_t channel;
> +    uint8_t rank;
> +    uint8_t nibble_mask[3];
> +    uint8_t bank_group;
> +    uint8_t bank;
> +    uint8_t row[3];
> +    uint16_t column;
> +    uint64_t correction_mask[4];
> +    uint8_t reserved[0x17];
> +} QEMU_PACKED CXLEventDram;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b1618779d2..3c07b1b7a3 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1196,6 +1196,11 @@ static const QemuUUID gen_media_uuid = {
>                   0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
>  };
>  
> +static const QemuUUID dram_uuid = {
> +    .data = UUID(0x601dcbb3, 0x9c06, 0x4eab, 0xb8, 0xaf,
> +                 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
> +};
> +
>  #define CXL_GMER_VALID_CHANNEL                          BIT(0)
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
> @@ -1292,6 +1297,117 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> +#define CXL_DRAM_VALID_CHANNEL                          BIT(0)
> +#define CXL_DRAM_VALID_RANK                             BIT(1)
> +#define CXL_DRAM_VALID_NIBBLE_MASK                      BIT(2)
> +#define CXL_DRAM_VALID_BANK_GROUP                       BIT(3)
> +#define CXL_DRAM_VALID_BANK                             BIT(4)
> +#define CXL_DRAM_VALID_ROW                              BIT(5)
> +#define CXL_DRAM_VALID_COLUMN                           BIT(6)
> +#define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
> +
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> +                               uint64_t dpa, uint8_t descriptor,
> +                               uint8_t type, uint8_t transaction_type,
> +                               bool has_channel, uint8_t channel,
> +                               bool has_rank, uint8_t rank,
> +                               bool has_nibble_mask, uint32_t nibble_mask,
> +                               bool has_bank_group, uint8_t bank_group,
> +                               bool has_bank, uint8_t bank,
> +                               bool has_row, uint32_t row,
> +                               bool has_column, uint16_t column,
> +                               bool has_correction_mask, uint64List *correction_mask,
> +                               Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLEventDram dram;
> +    CXLEventRecordHdr *hdr = &dram.hdr;
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
> +    memset(&dram, 0, sizeof(dram));
> +    cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +    stq_le_p(&dram.phys_addr, dpa);
> +    dram.descriptor = descriptor;
> +    dram.type = type;
> +    dram.transaction_type = transaction_type;
> +
> +    if (has_channel) {
> +        dram.channel = channel;
> +        valid_flags |= CXL_DRAM_VALID_CHANNEL;
> +    }
> +
> +    if (has_rank) {
> +        dram.rank = rank;
> +        valid_flags |= CXL_DRAM_VALID_RANK;
> +    }
> +
> +    if (has_nibble_mask) {
> +        st24_le_p(dram.nibble_mask, nibble_mask);
> +        valid_flags |= CXL_DRAM_VALID_NIBBLE_MASK;
> +    }
> +
> +    if (has_bank_group) {
> +        dram.bank_group = bank_group;
> +        valid_flags |= CXL_DRAM_VALID_BANK_GROUP;
> +    }
> +
> +    if (has_bank) {
> +        dram.bank = bank;
> +        valid_flags |= CXL_DRAM_VALID_BANK;
> +    }
> +
> +    if (has_row) {
> +        st24_le_p(dram.row, row);
> +        valid_flags |= CXL_DRAM_VALID_ROW;
> +    }
> +
> +    if (has_column) {
> +        stw_le_p(&dram.column, column);
> +        valid_flags |= CXL_DRAM_VALID_COLUMN;
> +    }
> +
> +    if (has_correction_mask) {
> +        int count = 0;
> +        while (correction_mask && count < 4) {
> +            stq_le_p(&dram.correction_mask[count],
> +                     correction_mask->value);
> +            count++;
> +            correction_mask = correction_mask->next;
> +        }
> +        valid_flags |= CXL_DRAM_VALID_CORRECTION_MASK;
> +    }
> +
> +    stw_le_p(&dram.validity_flags, valid_flags);
> +
> +    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +    return;
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 4dfbdf9268..e904c5d089 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -13,6 +13,19 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>                                          const char *component_id,
>                                          Error **errp) {}
>  
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> +                               uint64_t dpa, uint8_t descriptor,
> +                               uint8_t type, uint8_t transaction_type,
> +                               bool has_channel, uint8_t channel,
> +                               bool has_rank, uint8_t rank,
> +                               bool has_nibble_mask, uint32_t nibble_mask,
> +                               bool has_bank_group, uint8_t bank_group,
> +                               bool has_bank, uint8_t bank,
> +                               bool has_row, uint32_t row,
> +                               bool has_column, uint16_t column,
> +                               bool has_correction_mask, uint64List *correction_mask,
> +                               Error **errp) {}
> +
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>                             Error **errp)
>  {
> -- 
> 2.39.2
> 

-- 
Fan Ni <nifan@outlook.com>
