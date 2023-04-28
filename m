Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EC7C77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 17:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346393AbjD1RBL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346358AbjD1RBH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 13:01:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2093.outbound.protection.outlook.com [40.92.53.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592F15BB3
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 10:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH0XfVKfA3bo0mUBKrB+Yhd1K6b+eNtvIU1oCk6VGPSVfzbNKZxOzgo30gKdQTAXjh/ShM59qmMrSYDhfconVHZjTfRzPPFUoz5o07LKNM6mDRRY1Osl1S2n6jY6yB0UxotUJ0JzkjHUxO9fKRtEum0d4IbdWfUKfReWv7NZZmYU1wSc644KwU7/jXuanydW6FiDkDsAFIq3crIxyYCNskwcKJ1RuXpomtsXeFiGKcIvKbCsYc75pzZG1duUV7DRCOA5iYrHagKZyq3c5O3u9mek17LakGQfooOQmzb17MDk+BiWlLaQX5H1lr8hOPLeBXme5+kwCBEW9oyJgtxvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eX9Qx3zPgWxyEaGc6qwSYMn/sA6YEahVRPC2hGQ44I=;
 b=PJcgQedCcRt16TCe0tgaBz1R25NveKlbqHmW0RCkpCsekwhq9lx0swPGt00CEUmpS40SIIpFd5/hpM/JfimdTgZBaqugf1ddw5nQYyUdiATt8DEucfDawFG6jqhftEcXbl07OdxHmQ5KJVcxD/Tf4Kmo7miAY3trhOmGutw3DUuo4uCU8d+AuKHhEONAEwCxVSZsWFcDCnCowxDrWQxcrSPTw1Mymi+HES8T6DmPswWwAJCUW0R3w80955sSoLcCNNSvi45QjI+NdWLv7oPFn7JD+gkrZtGCV8PUrlhUHeDWebeEfyf0/PgeEYNeTmb1HlraLwSPYO79hoD5ghMPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eX9Qx3zPgWxyEaGc6qwSYMn/sA6YEahVRPC2hGQ44I=;
 b=TBukAemjUScoOeoArqJXHL60dyMU8AiZ2vcZaoE0t6dSum7ghnDBBAk28plU8s/IzBbbA5i77DjAQhCWxNEepUNP3/4LFOVOLOuvA6SIVg9gta7MsNJ9jozMrLJKdBNfupOqUR0EtG1ZqxshZqC72dyefJaJQ60OELWLh8GIMYmYf6FAIKxif/GXVDxNAyE4vjr2zcCZdmodYz4QUzJZxlNDpGujxISgU5fwVHEfsbgv4qbSGwNzLMjwNRRpTcezDSfOxBgJiwQYaMqwieC11Dr+UuJqyuw+YfHQLLyws5cZVZF1p0hn1xUTyPZ3S2k8YCj0p0TUeSbtnkJjnXT3Uw==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 PUZPR06MB6148.apcprd06.prod.outlook.com (2603:1096:301:11d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23; Fri, 28 Apr 2023 17:00:57 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::93bc:25d1:6ff9:2b63]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::93bc:25d1:6ff9:2b63%3]) with mapi id 15.20.6340.025; Fri, 28 Apr 2023
 17:00:57 +0000
Date:   Fri, 28 Apr 2023 10:00:49 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] hw/cxl: Add scan media mailbox command support
Message-ID: <SG2PR06MB33977713A088C0F8C1320D69B26B9@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230426021418.10186-1-dave@stgolabs.net>
 <CGME20230426024613uscas1p163d380501d4e11fc7d2cd6f8c6e5b198@uscas1p1.samsung.com>
 <20230426021418.10186-4-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230426021418.10186-4-dave@stgolabs.net>
X-TMN:  [uo8SoAlqoZ0URHD7ORWDvEYq3z5yuUP9]
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZEv7wazRhTHjMpGw@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|PUZPR06MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 217f20d2-cf17-4f26-81b2-08db480a22a9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nKDZiCWYelHr/B9XUVj/pOxN84MML6o3n7TLRADMzIaipLQX56VMx9ocrq5c7idgHLCKCZ1jX5BnzAf2mieCAzycEkGvvyjm20IvcazermSLWeXWPGZeU/uBWpyXStQ6fiRbQ+u1WZnm+ufPc+O2FRpyUd4Vxtzmff3vktLGXj/qmeJupHXC1x+iRXRsd9XjGGlkM1vXeXQn8Kmr/xG5gIodP69tMAJPruVHFtZxgLNNoOLfAjx0kiM9DnStT9kqYluSz5deMMRV0XmQ5aCJiV3IrVqibEhhc4egjDXp88hFVATSTNB2QhEoJ0gu/Bz3nfqFbdqrSoyzk5EsHNObhaqYpGhT/Hcz5cBRnWeST2eisTsFG2rsnzc7XMrMf+Che/PAYske5ZzTw7GMFzavl95dwrM9e9ljezlYDRIOYeB5cPq8Wu3hoevz4iyoznXKpruDbhxG8YTh3pjl4qAlx5/d/mtLQsJTeqe9lgbUC4Ftinu3KZt6aCmUhR+YlkQz0nXyOn51SB7oF9QOUbJSVxYLWaYoJQoH5sv6IqlR5wSRXOxdsX2Am9+0ZxMcC/bPZJHligzzyV6tu3ck9ZlAWQOeKY2kWtzg/kq+aSElezgNM0J56l9BMxmHFINxcbg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0MyUGZ2alc5eERpZENIQjVmQ1FaN3JKT3JRSXVzeEt2Ump5TnFEVUp2U2pO?=
 =?utf-8?B?b3dLemJaa1BQcG5DbDd0b1pHbVNncS9BakRxak1WWnVmZG9YbkNXb1YvMEhz?=
 =?utf-8?B?cXQrZEVHR2hXNmJCNFEzT3d5Rk12NVRuQ1NhZGxLTE1zNWpWV2tmL2pXK2lD?=
 =?utf-8?B?ZEtyWmhjdVFvbHIvL0wwcXdMT05aQVZiakp1ZWp0azUwWkI3QVFUSVRCckhZ?=
 =?utf-8?B?MnBGNzNCdTVVT1NMTnFzYXd2OWFFaFNoK1R0VmZyaTMwMXRPM3FQZjBEMEtU?=
 =?utf-8?B?RG1vZ3B5b3M2eUx6RjZMSnVOUFhsRkc5cG5EZ04xQ01TWWdUcXhUaVBraG4y?=
 =?utf-8?B?aURIQVhKUjU3M3IyeGJ1SUJHd3pLa3VXK2N2YXAzZGxoV3ZQdmxmakJjcUJ0?=
 =?utf-8?B?L3Jlays0SVFoRVpTQ2dpc21NaVhaY1k4N2lkelRuSnltd2Y1clpYU0RaZHRF?=
 =?utf-8?B?ZE5jSnFZelEycmV4bnB3azlrY080MkJPWVBzdVpJSDl1TWVyK0xDbWN3cmJ5?=
 =?utf-8?B?Z05OamFPelZSS3JXbmdGRmtxYVJzVUMycEFLZE1tUWhOR25VbzJTOERPWVJs?=
 =?utf-8?B?U3VCYlN1Q2R3a1ZTZFMxZ0QzeVArNy95UTRYQXNZZGR1ZGdyeVJBZEJvVWhH?=
 =?utf-8?B?aDlJZmpZWE4wRFg2eVFoRDV3ZU1DMittM0FHdGF2Ym1UcEJoZSs2cnJrMUV5?=
 =?utf-8?B?Um5ZZnR1Q0xyeCsyU3ExUmxha21SOHZCa1BYSFFZMnpNb0pMbVh5SCtwYnkv?=
 =?utf-8?B?ZWlXZGt6L0VmME4zOWpmY3Nia2g5REZGQkNQVzlMNGswck40L0dWM1JVMjQv?=
 =?utf-8?B?VXdOYmNkbmVseHQ0akVBWkc0ZnVYUkJUWGdXeXZDOHk4cCtPKzFhT2JlUzh0?=
 =?utf-8?B?ZUZLcGRoS0thTDdWNkJQN09YMjVxazR3MlJVakR2Y292a3pTYzRJbHZ6NEJK?=
 =?utf-8?B?aE02YVNBQTlHMjlmU04vam5jRE1lYVJXWTlNMlM1RVR0cXBHWStpVjlSSUpI?=
 =?utf-8?B?K1BoTTB3VTV3c3lidWFGcDlCVzJkb0daV200MU1lTjRmRlU5TTV5eUpWK3RE?=
 =?utf-8?B?VUh1R0dta2UyV1U2aVQ3WnNyOFNTWVQ2djVtTGVMNHIxL2diNjZ2d2VFaFRw?=
 =?utf-8?B?alYwRVdqL3ZMZWRvb2J3UEZZd2ZqR0dad3had2kraHdwTU03QUVsMW0vUDl4?=
 =?utf-8?B?VFRkUW1iNU4veTcxSWRVRWhGQVNad3RZVE1hZlVINkk1U05kcXZXaXF3RnJ4?=
 =?utf-8?B?MWY1NW80YmU1TEx3WEFrZS9qVVJHUWZQSVRlWXBzMXlGZkp5bW81WEFidHR0?=
 =?utf-8?B?Z0xRcUZZV3VLVTRVb2JLTkg0N0VvWmN0WmJhNkVpanQ5d0JGZEt1NHBqc0pi?=
 =?utf-8?B?UTBaTW52bEVuS0c5QU54aEp2cEJEMCszY0d3dUFzelg0TlhZU0ozaHRxNWQv?=
 =?utf-8?B?R2ZCQ2Y1MUZMM3NKYnNGYjM0c0NZVXBsTU91ZDYyRTB6SHNNdHI0NXpmbXMv?=
 =?utf-8?B?UlNnd1dOYTI0UjB4Nyt5bDE3TlR6TVI0VU5SVVVjT3o3MWpQajhYbUpOTEE2?=
 =?utf-8?B?ZzJseWIwU3lOTEdGS0pRcUJrS0N3SWZGbzkrc1JBRmVDREk3MjFTcUFydGpG?=
 =?utf-8?B?Ky90UUJVYmlTbjRYVkVNQlgwWVJMK2c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217f20d2-cf17-4f26-81b2-08db480a22a9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 17:00:57.7000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6148
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 04/25/2023 19:14, Davidlohr Bueso wrote:
> Allow the caller to retrieve the results of a previous scan media
> operation, with similar semantics to the get poison list command.
> Number of returned records is to the max payload output size.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 55 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7f29b840a2c9..f978180d8e21 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -81,6 +81,7 @@ enum {
>          #define CLEAR_POISON           0x2
>          #define GET_SCAN_MEDIA_CAPABILITIES 0x3
>          #define SCAN_MEDIA             0x4
> +        #define GET_SCAN_MEDIA_RESULTS 0x5
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -1079,6 +1080,58 @@ cmd_media_scan_media(struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +static CXLRetCode cmd_media_get_scan_media_results(struct cxl_cmd *cmd,
> +                                                   CXLDeviceState *cxl_dstate,
> +                                                   uint16_t *len)
> +{
> +    struct get_scan_media_results_out_pl {
> +        uint64_t dpa_restart;
> +        uint64_t length;
> +        uint8_t flags;
> +        uint8_t rsvd1;
> +        uint16_t count;
> +        uint8_t rsvd2[20];
20-->0xc
> +        struct {
> +            uint64_t addr;
> +            uint32_t length;
> +            uint32_t resv;
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED;
> +    struct get_scan_media_results_out_pl *out = (void *)cmd->payload;
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    uint16_t record_count = 0, i = 0;
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent;
> +    uint16_t out_pl_len;
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        if (ent->type == CXL_POISON_TYPE_SCANMEDIA) {
> +            record_count++;
> +        }
> +    }
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
Add TODO to cover the case when eror list is larger than output payload
size??
> +
> +    memset(out, 0, out_pl_len);
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        if (ent->type == CXL_POISON_TYPE_SCANMEDIA) {
> +            uint64_t start, stop;
> +
> +            start = ent->start & 0xffffffffffffffc0;
> +            stop = ent->start & 0xffffffffffffffc0;
so start == stop??? missing ent->length for stop???
> +            stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
> +            stl_le_p(&out->records[i].length, (stop - start) / 64);
length always be 0.
> +            i++;
> +        }
> +    }
> +
> +    stw_le_p(&out->count, record_count);
> +
> +    *len = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1121,6 +1174,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_get_scan_media_capabilities, 16, 0 },
>      [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
>          cmd_media_scan_media, 17, 0 },
> +    [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
> +        cmd_media_get_scan_media_results, 0, 0 },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> -- 
> 2.40.0
> 

-- 
Fan Ni <nifan@outlook.com>
