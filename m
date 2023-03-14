Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEAC74A44
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 05:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCNFWT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 01:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCNFWS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 01:22:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2063.outbound.protection.outlook.com [40.92.53.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B482911C6
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 22:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6pWzy+/Aeh+yxrkG0Mp7vK4fQXzGKIBwVX/W0DbA/Q6j4Zl1UOrhLe6YjAVnE/BzKpNHpSm5NoLim/bSe1suOYMhUoGsFRK2JZEH+SKtg4PIrFBMB96qj1z70mB30stJx5oejpZv35iIOHT76YI7DdVslpH5ildtkttl/9N4X4dnG/V7izWFYBGBgZQtd6rFN/11BjwOl0uCLWKnVdxdRgaQ9rT3+fBtyoB5aT5OJdO6VCJsVTBfeIfku32lNjlfT8VkqPHU0eAhsFpkTKsu7/PG1UlyRc4hzWxz0m+VVzomcqFkgSRfYR2C1TBLF4ezt9I0y01zCp8wabiTryGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+u02BO8REKjfQIZNIdhPtK1FaGj1GSYSlTSmyOsZ10=;
 b=UNsJgvp9Yp9qm3XVIne0LsWkAzeiMrGBNJZO0oaotcazTHgrmzhLfw87CQ0UDkW0JSFawt4dItoGrDWp25xrR3rdDS/mpDILIBnGDNH6LviVTPXssdBgBIdzWQHupMJOygjyO/Ooro0eXlFSp3r9/kWT5ya57y5S5IPAEic9P5cEC7treOfztQOBTBYDs1zLHMXXgk4j98jzr80Xf5QQgL4n8iNJus8QAinxwH9CXsaxM2QDISKieMGBUAHbBRuW43elA84UU1aSFTDlDFl82GHOjJfYlR7L81HiMa7Xg9Y6HWKan3wh2TnG+jfOdsSNHWfZXf4ZyCApFWQk2wBneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+u02BO8REKjfQIZNIdhPtK1FaGj1GSYSlTSmyOsZ10=;
 b=cu4JRAVhainxyJ2VLIB5ZrKRUYBfhGjJsooRfdOxiDIZ5kT+WeYII/55IzzO/gQiZQwUrSJ8/KQ0q+WFGyeL/zOQopwX1HsWsC1VmeRwDe0GP+cpYxIBKbbLRa/W6N0F2mpM9gy7jGaYyTb2FgWavL1Nx2LsB/RONAuBODkKbcKyvp3Bz2i3D2qKuL+wxOOXIRCRV20ipCuKuH0cZSJI5o3Lgiy9+3j25oj8moezkK8exL7OHSOPuJZ9WCuW/3AIT4VM7/DPwnIKY9vblz1z3D0XIzaEYwlpPWAy2Fmg68kijOKAt9NO9MGLEpOzZ8sPKeraCoqIgjgolrlsblg+1A==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SEZPR06MB5739.apcprd06.prod.outlook.com (2603:1096:101:ae::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 05:22:09 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::822f:761f:a577:c76e]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::822f:761f:a577:c76e%4]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 05:22:09 +0000
Date:   Mon, 13 Mar 2023 22:21:49 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 4/6] hw/cxl: QMP based poison injection support
Message-ID: <SG2PR06MB3397672D065AC45B2F2022B3B2BE9@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
 <20230303150908.27889-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230303150908.27889-5-Jonathan.Cameron@huawei.com>
X-TMN:  [G4zxYlaCOngWoA6hS8fOF3oSoBCwz28j]
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZBAEbTVOuEeAzRf1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SEZPR06MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 1532a5e4-4d87-48fa-bbd0-08db244c0dfb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIZNcDc8AxLA5fMvUdyil4Qj0aHYX+NJwu14IG15JNTFzI2LdLqISUZHo+uK3s4/mU1xWn4tNEsc+JBwrPwUfT70Yvyo/dLWu9zUPdoakXxLtykMXjXbk3ls1uzOJ1DRDS49mEq5ivcEDyOf74svZ2HYnoMjWJyk45dH9+WoHUC/gOe4dUX4CL6BeKlJD2VV+RYhJoWZBZRtR8C6YGwyKYZt6JFPYFQ1CCsefLkMnXxEZyDQpMLFndjPq5vbL4B6rJvwq9bQ8jpRKFY9sOFhYrLP1hAceGOHKWY28MvvGYnKmBQOAcAGs8+vmYfEgxzn/YcWplwMRM7frV0wvHgsszxRcxleOIdvRW+SXwVwmyQ0TOYkd2bq/vY9lNk21DILFaiSQp/rPkP0/TXUuSeT9Jd/d3jasozEq84tZYuSG3HX/bsagoU7eRcJGjDwmPghxSdaQd6z9ak7sbFOImMCUd/VSwb2CGpwQS0SigNzboVoo/ZMWwyOjfWm9Bb7oi62BYw8P2sOOr2KQYOeoTK/BruUv7eb93FfZxrXxL+5uDy/4ocArIH7oI21v4EuDAv64IIn2nelnogMpXD9OEsv8zYY61P/bqpMRnMeAQFPfUTsZl3S79DQYRDPuYEtejD1dMeTQ5qB3ZCUL/pOGTpA6Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTI4bVNKM1RaZFgrKzR4TGxMK01PQWx3cVhLbnNocHBXNlBaSVMyVkwxNnZn?=
 =?utf-8?B?SWRsTmp5NFI4a05yUWRYa0ZFVkQ4NHN6WXQ2NzBHcXZoMURHbU9hZjdjVCs5?=
 =?utf-8?B?Z04vQmtmZ1NFaWIza2xLeDZJeWZ1NHZVNVdoSUFRVytGNE9zZ2RNNjFURklT?=
 =?utf-8?B?V00wZDZhZjFkTC9RekNlWjNtOGt3OEUycUovSW1lSWJVaFZTZlNYSmZXcWJW?=
 =?utf-8?B?aWRpVVBPZzZoOXRQdkZFRFNsS24zVE5nZVQxTmhFcURTN2tuZE94c1JYajJW?=
 =?utf-8?B?eXBpem1zallHUk9NMkc0K0d2bUl2a0JPQTdPUE9RQTZVRm54aThwa0VNdzFF?=
 =?utf-8?B?WHoyQ0ZiejBMR01obVVWVzhWamI4L1JmK3lqNG9xOUxjRHhCc2xaUmx4bWJ0?=
 =?utf-8?B?aGVQMG13Rlk2RXB3REd1eEFuZjh1ZE4xNytZb01mVWxaM004cXFWOTJPVzYy?=
 =?utf-8?B?VWV0MDRoeVFLcnZJb0RyZVI4cGJCQnU2MFV2emt4dVI4cDR5dFkxTEVvNzQv?=
 =?utf-8?B?M1hUZWFRR1dvbEl3bkNvaWN1ekVFMUx5QlJ1aDFNOXI2R05TMEVUYUxGaGpV?=
 =?utf-8?B?UWpUcThUbW95NUU0UHAvQnhOLzUwQXFkc1Nab29yaDVxSThiMUtKODJyL2JB?=
 =?utf-8?B?WjVZSjJ5cVRacklmUmtRZVJYWWlMakFaL2Ewb04rVWlpQWVudzJUQXhKSS82?=
 =?utf-8?B?cDdLaTY1TzFpdHN3WUJVTVN0WVM0WittUkZhcHdZNU9kWXE1S3FHL3Y0cWpt?=
 =?utf-8?B?c051NWpvSEF5TUxhMXVYQUdwVkV2ZnRXS1pSazZWblNpOVk2RmhVc3RlRVpS?=
 =?utf-8?B?ekpDWHlYUHpselZiVVk0aVV2bUF6L0lna2dYemVndDNEenpzVFFlVFJGWE9j?=
 =?utf-8?B?K2x5Y3FkdGQrbGwvdTB2ekFKQzVvaHAwZnBPclAvdXZ4L2RISW80bnk5Z01M?=
 =?utf-8?B?bDJRRTJLbUJSeHhIV0Vza3hPRFFxZVZLZklYZmp6MkJXemJNUU4xSmpFNnNq?=
 =?utf-8?B?ZjFVQk1OYk8wRDQrTDVEdmRvbzVrQmJDVkUxTlhNcFBXbDFTSGJVMHBRak4z?=
 =?utf-8?B?WkxHS3VFSGh5MVlNeUhIdjlsN3NFT0E0NXN6azh0ZDAxRDFMU2llWWJGRE1E?=
 =?utf-8?B?Q3B5TFIrenVRcmtETFhEOTl6Zm1ob1V1VjlWVEQ3dTNpRG9Fc1RvbFQxdVZL?=
 =?utf-8?B?V1M1eDk2MlJzYXVkS3lkWFpJWUxmRlN6bDhLc2xiQXp0U1hSZ3BrcVFHcGJH?=
 =?utf-8?B?VXU2aHVyeStRdDJwWGsyNUlRMTVIRERWaW1rVkMxR1EzMHZ1enZNQUc5ZEhu?=
 =?utf-8?B?SWNXRkZkNHdMang0VTZyZjIralVrcndVZmd1VDF3dDhLVkRQZGdEV1VZa0FV?=
 =?utf-8?B?RWNNaW1UN3NXaFRDeUtibDlLQUVaSEdaMDBLL0k3RXFrMktDdXI4R2NHWmtv?=
 =?utf-8?B?aldMVXhQUENlSkJTNFp2ZU5SSlhEanZNaGRicjVRdnl4OXhGSy9VT2VNVXBF?=
 =?utf-8?B?OHFVS0NPSnY4MDVCcVBqMWR1THBQemFuQitFUFRJeTNvaTlhMXNkK2ZQa3RL?=
 =?utf-8?B?OW5tL1NJRzdTM2c4M1FvMjBhalpSVTd2ZVltbkt0WXNabCtwS09hSEZXNlgy?=
 =?utf-8?B?SjgzakN2UDdUSlBFTGFFK0RDM1U2aTRZSi90cW1ZcnlNRzhuQjU3aWFtbDRp?=
 =?utf-8?Q?SGXYRJ3URVzc8SEgwvQz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1532a5e4-4d87-48fa-bbd0-08db244c0dfb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 05:22:09.5802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5739
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 03/03/2023 15:09, Jonathan Cameron wrote:
> Inject poison using qmp command cxl-inject-poison to add an entry to the
> poison list.
> 
> For now, the poison is not returned CXL.mem reads, but only via the
> mailbox command Get Poison List.
> 
> See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)
> 
> Kernel patches to use this interface here:
> https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/
> 
> To inject poison using qmp (telnet to the qmp port)
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-inject-poison",
>     "arguments": {
>          "path": "/machine/peripheral/cxl-pmem0",
>          "start": 2048,
>          "length": 256
>     }
> }
> 
> Adjusted to select a device on your machine.
> 
> Note that the poison list supported is kept short enough to avoid the
> complexity of state machine that is needed to handle the MORE flag.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> v4:
>  - Widen the mask on Poison source (lower bits of the address)
>    to allow for Vendor Defined. Change will make it easier to potentially
>    add a means to inject such poison in the future. Today it has no
>    impact.
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 90 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 56 +++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  6 +++
>  include/hw/cxl/cxl_device.h | 20 +++++++++
>  qapi/cxl.json               | 18 ++++++++
>  5 files changed, 190 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 702e16ca20..25933cf62c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -62,6 +62,8 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> +    MEDIA_AND_POISON = 0x43,
> +        #define GET_POISON_LIST        0x0
>  };
>  
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -295,6 +297,10 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>      stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
> +    /* 256 poison records */
> +    st24_le_p(id->poison_list_max_mer, 256);
> +    /* No limit - so limited by main poison record limit */
> +    stw_le_p(&id->inject_poison_limit, 0);
>  
>      *len = sizeof(*id);
>      return CXL_MBOX_SUCCESS;
> @@ -384,6 +390,88 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * This is very inefficient, but good enough for now!
> + * Also the payload will always fit, so no need to handle the MORE flag and
> + * make this stateful. We may want to allow longer poison lists to aid
> + * testing that kernel functionality.
> + */
> +static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
> +                                            CXLDeviceState *cxl_dstate,
> +                                            uint16_t *len)
> +{
> +    struct get_poison_list_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +    } QEMU_PACKED;
> +
> +    struct get_poison_list_out_pl {
> +        uint8_t flags;
> +        uint8_t rsvd1;
> +        uint64_t overflow_timestamp;
> +        uint16_t count;
> +        uint8_t rsvd2[0x14];
> +        struct {
> +            uint64_t addr;
> +            uint32_t length;
> +            uint32_t resv;
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED;
> +
> +    struct get_poison_list_pl *in = (void *)cmd->payload;
> +    struct get_poison_list_out_pl *out = (void *)cmd->payload;
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    uint16_t record_count = 0, i = 0;
> +    uint64_t query_start, query_length;
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent;
> +    uint16_t out_pl_len;
> +
> +    query_start = ldq_le_p(&in->pa);
> +    /* 64 byte alignemnt required */
> +    if (query_start & 0x3f) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    query_length = ldq_le_p(&in->length) * 64;
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        /* Check for no overlap */
> +        if (ent->start >= query_start + query_length ||
> +            ent->start + ent->length <= query_start) {
> +            continue;
> +        }
> +        record_count++;
> +    }
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    memset(out, 0, out_pl_len);
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        uint64_t start, stop;
> +
> +        /* Check for no overlap */
> +        if (ent->start >= query_start + query_length ||
> +            ent->start + ent->length <= query_start) {
> +            continue;
> +        }
> +
> +        /* Deal with overlap */
> +        start = MAX(ent->start & 0xffffffffffffffc0, query_start);
> +        stop = MIN((ent->start & 0xffffffffffffffc0) + ent->length,
> +                   query_start + query_length);
> +        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
> +        stl_le_p(&out->records[i].length, (stop - start) / 64);
> +        i++;
> +    }
> +    if (ct3d->poison_list_overflowed) {
> +        out->flags = (1 << 1);
> +        stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
> +    }
> +    stw_le_p(&out->count, record_count);
> +    *len = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -411,6 +499,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>          ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
> +    [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
> +        cmd_media_get_poison_list, 16, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 572ad47fa2..21e3a84785 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -919,6 +919,62 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
> +{
> +        ct3d->poison_list_overflowed = true;
> +        ct3d->poison_list_overflow_ts =
> +            cxl_device_get_timestamp(&ct3d->cxl_dstate);
> +}
> +
> +void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> +                           Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLType3Dev *ct3d;
> +    CXLPoison *p;
> +
> +    if (length % 64) {
> +        error_setg(errp, "Poison injection must be in multiples of 64 bytes");
> +        return;
> +    }
> +    if (start % 64) {
> +        error_setg(errp, "Poison start address must be 64 byte aligned");
> +        return;
> +    }
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +
> +    ct3d = CXL_TYPE3(obj);
> +
> +    QLIST_FOREACH(p, &ct3d->poison_list, node) {
> +        if (((start >= p->start) && (start < p->start + p->length)) ||
> +            ((start + length > p->start) &&
> +             (start + length <= p->start + p->length))) {
> +            error_setg(errp, "Overlap with existing poisoned region not supported");
> +            return;
> +        }
> +    }
> +
> +    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +        cxl_set_poison_list_overflowed(ct3d);
> +        return;
> +    }
> +
> +    p = g_new0(CXLPoison, 1);
> +    p->length = length;
> +    p->start = start;
> +    p->type = CXL_POISON_TYPE_INTERNAL; /* Different from injected via the mbox */
> +
> +    QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
> +    ct3d->poison_list_cnt++;
> +}
> +
>  /* For uncorrectable errors include support for multiple header recording */
>  void qmp_cxl_inject_uncorrectable_errors(const char *path,
>                                           CXLUncorErrorRecordList *errors,
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index d574c58f9a..fd1166a610 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -3,6 +3,12 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-cxl.h"
>  
> +void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> +                           Error **errp)
> +{
> +    error_setg(errp, "CXL Type 3 support is not compiled in");
> +}
> +
>  void qmp_cxl_inject_uncorrectable_errors(const char *path,
>                                           CXLUncorErrorRecordList *errors,
>                                           Error **errp)
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 02befda0f6..32c234ea91 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -242,6 +242,18 @@ typedef struct CXLError {
>  
>  typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
>  
> +typedef struct CXLPoison {
> +    uint64_t start, length;
> +    uint8_t type;
> +#define CXL_POISON_TYPE_EXTERNAL 0x1
> +#define CXL_POISON_TYPE_INTERNAL 0x2
> +#define CXL_POISON_TYPE_INJECTED 0x3
> +    QLIST_ENTRY(CXLPoison) node;
> +} CXLPoison;
> +
> +typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
> +#define CXL_POISON_LIST_LIMIT 256
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -264,6 +276,12 @@ struct CXLType3Dev {
>  
>      /* Error injection */
>      CXLErrorList error_list;
> +
> +    /* Poison Injection - cache */
> +    CXLPoisonList poison_list;
> +    unsigned int poison_list_cnt;
> +    bool poison_list_overflowed;
> +    uint64_t poison_list_overflow_ts;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"
> @@ -289,4 +307,6 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>  
>  uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
>  
> +void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
> +
>  #endif
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4be7d46041..9ebd680dfe 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -5,6 +5,24 @@
>  # = CXL devices
>  ##
>  
> +##
> +# @cxl-inject-poison:
> +#
> +# Poison records indicate that a CXL memory device knows that a particular
> +# memory region may be corrupted. This may be because of locally detected
> +# errors (e.g. ECC failure) or poisoned writes received from other components
> +# in the system. This injection mechanism enables testing of the OS handling
> +# of poison records which may be queried via the CXL mailbox.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @start: Start address - must be 64 byte aligned.
> +# @length: Length of poison to inject - must be a multiple of 64 bytes.
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-inject-poison',
> +  'data': { 'path': 'str', 'start': 'uint64', 'length': 'uint64' }}
> +
>  ##
>  # @CxlUncorErrorType:
>  #
> -- 
> 2.37.2
> 

-- 
John Smith
My name is not generic at all.
