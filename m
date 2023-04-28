Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E130AC77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 16:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjD1QSl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjD1QSi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 12:18:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2047.outbound.protection.outlook.com [40.92.53.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F485FD6
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 09:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRop55Qy7pzbrBiyHrWLASnlhTtHNZkIbk16+RpnqMyh1TV2IG1rG+rdGYB0eHHVMuHVdMvDKbwmaR0omraQaPZvojFngpX9ztRT7DCwjn2jvidmtmrd0epa5fvSMtiwHrS3hDbBfwMeOYojOEOSd+kjsZ0jcJrB1S03dn4r/tUXZrNNvS5yQFHHUVZSk8jF2I7aekbVTtG9x55rQRBRpej5ApQsm1u7rGcixL5CwpsY+V4C8XqiX3Wm0HzKu3qv/HMCf4VrprFZKr6QSIa09xSUmbC9BX/WvpuOmh6mZOlEavbLePWTGMS9YhIiFJI9DFmn+I4Pg1B01wFNBkosBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so80GjtoaSEdVcVpobu0MOB2YDuE6KqunPHiTS0G1ZY=;
 b=RlXt19MigpkMgAQOiWNMaSOH/zL34pJ8pzcGme4LS4N7lbuFvAqS4r0FsN2y9C6RzyCG1ArA9XVxt18YNJ4AiVyAZRjLr/QfDKR3tRm0TyTN9XQ2TydMSSC047KpT6kCgUPSKOl0PB2hDERBpKuZefXEI8KEiMocQbI90a2rXI4Mj/MnZq5OsbzVWHxV+Ug6hmPxqW0+cc72tn5YUGS6s7Uc6cxqgOJTxs/eq+YR10fePdTlu6TeqonDuas8jayYde/A1HZKTfi8kGn+YpMsGOzsyAk7PgwGw4WZSSCK0lwjL3ztDLz+jew81PtFdsuP1UAu0h8b/aFikrtHv3Na/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so80GjtoaSEdVcVpobu0MOB2YDuE6KqunPHiTS0G1ZY=;
 b=G2xwUqADxqPC+Y9M/GfnMNeNhjR/wlt4BPh6m0VCM9cA1rRmM3ovZt2J/C3y0XXo8mNDsZAN2nOxyade4E9KY/ZcsqtpNRGG/UKjFU2UKa2lB3cwUmwwYcddsdqx4u5Sy/tuk5QgjDVYfAmzTQWwGUvReNMAnSUeylKDRzDicfHelTejxeektJ+Gb8AdxldnE0WKVBzz2ojUTn4IHW72H8Yfu1iX7CxQL4KvjJtEEir5r3kdmUNuPwwgfUPaqYuvraBhL3bl/wJwIg1+T+cPdgewgkf2tHWBiIDr2fC8D6o/BcxCzamnhdVeNVsQno4ssUj7Dng3KXnnHufJOk/KIw==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 PSAPR06MB4056.apcprd06.prod.outlook.com (2603:1096:301:3f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23; Fri, 28 Apr 2023 16:18:16 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::93bc:25d1:6ff9:2b63]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::93bc:25d1:6ff9:2b63%3]) with mapi id 15.20.6340.025; Fri, 28 Apr 2023
 16:18:16 +0000
Date:   Fri, 28 Apr 2023 09:18:03 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] hw/cxl: Add get scan media capabilities mailbox
 command support
Message-ID: <SG2PR06MB3397E10EB741A22CC919C0FEB26B9@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230426021418.10186-1-dave@stgolabs.net>
 <CGME20230426024613uscas1p2ace5025489d1d976a5e4860b0b06c42b@uscas1p2.samsung.com>
 <20230426021418.10186-2-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230426021418.10186-2-dave@stgolabs.net>
X-TMN:  [FMIxti7bvm+yJwuHd5lkN9Txg6bDrqZ8]
X-ClientProxiedBy: PH8PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::27) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZEvxu7dvDeW/Ixc8@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|PSAPR06MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6cf293-dbe0-47e8-44a0-08db48042bad
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7N6DDz0Zes2DXVtnRuKlD/sc8y5iE9TryI4l7Lj47SUb7I4+sPh72+ruagyaM7aCa6h/RqI3HcVualD+UgCC00o1MFIMig5LQIXFhbWxs8jZnF3t6U6KPB580W2pRx2q6hEB7TrhJBbnZmKKedcnc+sEe603mQ9KZVPuEUulFpw/VJPqQECBc/7VysgawcS8qHBbUDtyszwFLeQsWfTBNealTNGD+3P1fwM7eW3IKFKjCnqMRP7iHrWnn5j+ue9tvbnaSmNuX1zxLtBBU+8UJanLhMy1TrnhfrQFRqf3pQI1jKWCyeFQ2M5F1fcRqFKSvwdIngBmMnyEp3HrLqWYG/b3JVaBEgloukhkqZ2j+xIOydh0t/a8+U1iTL3ABC2/Bxr7CNh7ZePKFnz8VvcWVMM58+C458ScHfi01BZJovSrHZ8Au8dq+mZePr4wgnt7XYt0eHsra4wrRN0cJIMoQgQE+6dwM75Rbk5OVSRjPdJZev/XDA7GaiOVSAQ+NFoOt68lxhIiPvWcZ3/EzLHJh4fGgwaIf/6FZ0fc+uOKN0RGlk52d7U1iQqZowgVP3TVyjuK/V/S8/A1xub/ImxsKLTsJQqLpNmoBf4yxsI9pQCZbTdHzfqRiNg4qOo211/C
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2pIS3lwekpMNDgyZ0FGTHNIUWdwTlFIN0tWOHNDdFEvN1Z6bDNZSlhlVnhT?=
 =?utf-8?B?TW9qNXUyZDZRRTBwNm1tNkN1MC9SN0pEZS9pYmNaMndsMjVCalpaMklPdmg3?=
 =?utf-8?B?cHp4WnRXbDkxZ0xNcGQ4c3V1K2dKMkRHV2Flb0JFSXk2czRrMFh2dDZ1WDFE?=
 =?utf-8?B?cVdEbTdnS09CeEFRYWNVclI5L01BRWVta043QU5zWE10dndteDVoNUtLRnZB?=
 =?utf-8?B?Z2x5RERNZWZRR1RFZFJzcHZKWS9WWHhkVmk2d2MrbFlLekdFZFA3QVRFbzJM?=
 =?utf-8?B?TDFYRHE5R2hoekdkQWc5a05ETVRvYzlPUXJEU2x6MytoMkkwcWxDSEdJekhF?=
 =?utf-8?B?TG1IcTZJOFZNaWwrV3VJYmZCS0RKM2dJa1I4cUpGRi8rZjhxU2FzK1RWaWEy?=
 =?utf-8?B?SCszMWlSUm9IeS9tay9Bdm9KS3hOU2dyS2V1dFF2MWFGUjFLRmJVaUk5NGMy?=
 =?utf-8?B?cHRxY1NSb1pNRTZoTmNhQjhZT1RhdG5IZVhXTWRaNzF5RkYzWTBWMnppY1hw?=
 =?utf-8?B?V2dQZFA5WHZOUGJhbXJMOXBVaFl4RXlGM2poZXRtc21xRDArdm45cDRDQ2w4?=
 =?utf-8?B?SFd1ZGxFU20vWFZLSS93eURJZWNBYXI5L1VOQy9UeWFnamFUeFNpL3R4OGo1?=
 =?utf-8?B?d2lXTHJkZ3VoL3ZDaTQ4b1I4L1h5OGQ1REFGUkxuM2VJc2YzTzBzNTliQVNs?=
 =?utf-8?B?ZGJwUTFTNTlYb0U0L1RuR2pTbWo1elpGYTBpV2ZDbGwwV2FhTzExR2tMdnZZ?=
 =?utf-8?B?WCt3RytBM25GQWVuSVJxQ1dsWm1MaHlLem8zTkFRczhXQ3RYbURYUE5GWEJw?=
 =?utf-8?B?cEJmYlp6dWJqOHh5K3YxcDErQUE5T0dpZWpPTlNKajI4SWxYM09RTGxGNUZl?=
 =?utf-8?B?M0NRdnRqdmtmMjd0cDhmTFliRjZXNEpUNlZyUTU0QnY5YVR4TUJHbGlnV2tO?=
 =?utf-8?B?WUFZZ3puWEdOaEVDL1p5bk1vU256eldiRTYrRlVTdDlZeEZIemhlR21pOHpp?=
 =?utf-8?B?bFFTY0xZWWR3Y0xrYjRDNGlGemFwRkxmVG5IaXJTc3k4V3VDOGNRVXRrc1JQ?=
 =?utf-8?B?K0cvcFFhcTNFU2ZFcmJHRkRYaEFlS3Y5QnRUMkRHTU1SMENuTzZ6Q2NMMk12?=
 =?utf-8?B?bVdkLzRtRjBFQjJqTHMwdGNEcStkSGMvQnJhdTcvRFZ6R2d1KzZtVjkzbFlU?=
 =?utf-8?B?ZmV2MjlwMUdNS2IvM3hxVnUwK084UEtrUmh0MXlkQUVmcUFsUU1mbXp4dllv?=
 =?utf-8?B?d2wzVGluWDM0QUQxTzM5TjQvZjRIcGF1NDYwZ3VqSUxjL1Rha0dwUU1MYkpt?=
 =?utf-8?B?NmUyc2dsQWhiQnBRY3BYZDZxN1ErUFd0S0UyczM1cEFqaVRyS2JWVSszUmI0?=
 =?utf-8?B?WFIrYXF3dUJjTU1CeENxVS8rR2VkaEUwRjZTeUZYUVV0UUpaVkJEWnEwMWx2?=
 =?utf-8?B?ZWlORzZ2NmlSczYrR0FNd3Q2ZnIwdytoQVh3UjVoM2pINktFenpvQzhlQVRz?=
 =?utf-8?B?SGxtcm9rRk9xT1U0alh5VzFlMEtodXRIUWRzU3hyY3gwYWJXOUZYdndncEx4?=
 =?utf-8?B?d3lFOFBFUGpEOGU3alo4Mml6bElNZVpMb0JHQnJRTjhjR1JCcEVZNkNvMmVz?=
 =?utf-8?B?TEJwMHJDV1M4OE85d05tN1cvMTMzOUE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6cf293-dbe0-47e8-44a0-08db48042bad
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 16:18:16.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4056
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 04/25/2023 19:14, Davidlohr Bueso wrote:
> Use simple heuristics to determine the cost of scanning any given chunk,
> assuming cost is even across the whole device.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 45 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 0849cfbc2a4c..f346aa8ce3b2 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -79,6 +79,7 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -882,7 +883,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>              return CXL_MBOX_INTERNAL_ERROR;
>          }
>      }
> -  
> +
>      QLIST_FOREACH(ent, poison_list, node) {
>          /*
>           * Test for contained in entry. Simpler than general case
> @@ -934,6 +935,45 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode
> +cmd_media_get_scan_media_capabilities(struct cxl_cmd *cmd,
> +                                      CXLDeviceState *cxl_dstate, uint16_t *len)
> +{
> +    struct get_scan_media_capabilities_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +    } QEMU_PACKED;
> +    struct get_scan_media_capabilities_out_pl {
> +        uint32_t estimated_runtime_ms;
> +    } QEMU_PACKED;
> +    struct get_scan_media_capabilities_pl *in = (void *)cmd->payload;
> +    struct get_scan_media_capabilities_out_pl *out = (void *)cmd->payload;
> +    uint64_t query_start;
> +    uint64_t query_length;
> +
> +    query_start = ldq_le_p(&in->pa);
> +    /* 64 byte alignment required */
> +    if (query_start & 0x3f) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    query_length = ldq_le_p(&in->length) * 64;
> +
> +    if (query_start + query_length > cxl_dstate->mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    /*
> +     * Just use 400 nanosecond access/read latency + 100 ns for
> +     * the cost of updating the poison list. For small enough
> +     * chunks return at least 1 ms.
> +     */
> +    stq_le_p(&out->estimated_runtime_ms,
> +             MAX(1, query_length * (0.0005L/64)));

estimated_runtime_ms is uint32_t, use stl_le_p instead.

> +
> +    *len = sizeof(*out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -972,6 +1012,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_inject_poison, 8, 0 },
>      [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
>          cmd_media_clear_poison, 72, 0 },
> +    [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
> +        cmd_media_get_scan_media_capabilities, 16, 0 },
> +
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> -- 
> 2.40.0
> 

-- 
Fan Ni <nifan@outlook.com>
