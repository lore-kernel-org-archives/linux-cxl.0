Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A933C001B0
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGXSTd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGXSTc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 14:19:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317ED10DE
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 11:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkJDS7xpHXG0jIbol1Mwrd7/yXNO8AX91bDbv8K8zNuoEP0apthRdrOceIVVw/VjgwksEVk3PbyPAvkzJ6pKL0hS78hT5esGLV+kWFf9ewjkJufuDxVRZj9HluHSLLoGqomZmHVGflp3+3sv0bGAHbPas3wXYBz0Ohdkb87WEnFHObio/1D9JPIMGTv0H3oftJgGOouUDjjM03GrAzlx/rAslGE4qeEkzgcF/ZjgGZSeXXq3SLaDrrYlwAHsxOxO2C1IgYfH1EyXkI8eP1iakEF/hPSRfRk1Zs/2ft8U5/w3vn9Sn1feZBIsukt4iic12LsfmNYJ2JSVz5GB7JSyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHgKzj6pDsOqilY2rKHHktctOXeHpyfVIllVPF+Hja4=;
 b=bXYY2p6U9STLHnCbxZAKEfH4LiSU7ZF2RLi6ZRI9fi5QRBNO+iC0+W0cNk0+UDogqG01dI9IwmDEvrGT/7D6p6jJpLM54IUcAJGh3P92lGyer96iyd4BIxlC6xblPD1dnKqgpvIKWaGToATHOBhlVXz8cIcEFeJqTt9kIPahHg7eNm0ru+cByqbObEIreqHyiYyheRmEuwHw70Okq2HRyzNrGps1kVF1RqKjikLyscsASuMpHS41ef0kA+mfSULYMPGC+bVay6gx+BguHP4xY+K4AuIJQ7+bRal0EPoEw9+cn5zkHbCwBscqbYN2Obi/2X5aXA63m130h7bdM1dnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHgKzj6pDsOqilY2rKHHktctOXeHpyfVIllVPF+Hja4=;
 b=ss7vb/Opx1flOpPAj4KOZFlWMgyrKnz1VJ8xLQ7BR4djaxe1NXfc1J9w10/YKKUx6yw1IST33bzA1Q1OjJju0g22I5Lk9mNdV/ykRBdnl/JtwltJB36a3rqXTrH5Dcyj/yAbaeydO/nsn5l/joOGKqzRBDiw8yfdbHhhp1UzW8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 18:19:25 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::9b81:467f:8267:9891]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::9b81:467f:8267:9891%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 18:19:25 +0000
Message-ID: <0a831345-1d31-3730-57fb-267a6413256a@amd.com>
Date:   Mon, 24 Jul 2023 13:19:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Qemu PATCH RESEND 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox
 commands to support add/release dynamic capacity response
Content-Language: en-US
To:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
References: <20230724162313.34196-1-fan.ni@samsung.com>
 <CGME20230724162324uscas1p1004474b4ac5267f90a97a6eeabe68db8@uscas1p1.samsung.com>
 <20230724162313.34196-8-fan.ni@samsung.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20230724162313.34196-8-fan.ni@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::20) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 662bb414-2e90-47b4-f957-08db8c7282d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgf+84h5LeTprDSz5tCqtyGpJ0kcqj+Y7AnUwg6w7zdRwX9o52eTVuYG3oKjQGAQdy1pY0iI1RQStdS5+pP0lbrV8GU5rlibf4wFTC35G6q9ZPfXuKvYx+/a2nG8jce1T5w21dEsWl96JqMIgTLx0CuWDCUfZjhEnTCevFNIPNrWg593hwO3f3UU0dc3/pziebxvrA+1M9MEU22EeiOGVy93HIvwnKvV3U2h1UFXrHy1Zq1+8jFHCx2YEl4TS4WwvEZkXv55YMfC5e5wbBjqXP3GOuDsAxveKg4ZfbZEECgPXFi2kh62Xm5bQYNGPNqxnK+RWSIGWqmFFXl1i2Ycimcf3wsawuovfEGvgmqn4MAozygF+mNuB4h6RNJYQY48YaVcptJ2ADurwVqnjt7YMLTBU1vjPjb5DUU3/r6H303ujKTNHLyMvLupYTwbOYllfmR3B0g14ComtK4lSlCISsMnxzoi4w2JiUSJZaQ24fEMWs6jfJVyoCCxqwPB53kKtGcFFiag4mFxzQ62A2YUXF72IZ69brKC3rQfZbc+0DAjwh43iySP9MmhkJKbAqgnSvpkbbZSCxA5ws3qS0o8UBkubFnTl3ZuB3TesJWiFooNHZDiETaEnt3AlWacLGECPxWr+AWSt3xvNGR70OaWhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(2616005)(45080400002)(54906003)(110136005)(478600001)(36756003)(26005)(6506007)(186003)(6666004)(6486002)(53546011)(6512007)(31686004)(5660300002)(4326008)(66556008)(66476007)(83380400001)(66946007)(2906002)(31696002)(15650500001)(316002)(41300700001)(38100700002)(8936002)(8676002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJhWEEvNVc2T3BwdXBzc1VhS24yUnRtZVJMelArV0MzaFVrSGFOcWtkWGsr?=
 =?utf-8?B?eUVUNUh4T1NLbzk2czhuVTJPcm84Q29CSk1GdWxFdnBwM25lMHNpaDRoQ3pY?=
 =?utf-8?B?WWNSTy90MGQyNUpPNWxoRFRHeVdkVHczZ1pNRkZ2TkhxWUprV1pLTnVLOTJu?=
 =?utf-8?B?bS9NRkNRRUgxTkl1WE5ZMzhZdzVsWUc2WTd2YkpuSHNPbVdkZFExR0crblZy?=
 =?utf-8?B?YzN1R21YeUREZlB6bEx4SHdxbjY0RHJYbmdNVXp5RDNGK2t3M1pmZStockdS?=
 =?utf-8?B?NVRhdWhPY3Y0Mzh0TktsVkp6NGNlY2wxMVJ5TnB2NzNlcEo2SkxLUVp6RzJo?=
 =?utf-8?B?Mk81YVlIdGJkRlM4TkwrQzk4Rkt2K2FYZ2d4VmhCSTlpMTgvSUJLS2t3eThm?=
 =?utf-8?B?cWUvVWhKRzQ5YWNwN09pNUwvdmF0M0V3ZkhWdVFnd2ZLYklWdWlMMkdNLzl0?=
 =?utf-8?B?ZkgrcDdzMUg2a0RmOHRQaDRkbGFMczVZcHhnMVdFMitGOWNCRHVnUEYyRUFi?=
 =?utf-8?B?L09iWHQzMEtYZkgzeGNvbUVaQ2VNdVI2elRLTFJYK1RLempPbTE5WUYzb2VZ?=
 =?utf-8?B?cG9RQVlXZkJzdUVETWZVYjB2SHhETXB0ZWZmbHUzN1lZSXBFOC9XWkRIWFpQ?=
 =?utf-8?B?UE9kbDllb3pLOXBqT1UvZGlmbFgyQUpCUjZLa0dkb3k3amEyaHROekgzTFRx?=
 =?utf-8?B?QkNXNnI4TWhZV29tMDJ2R0VQckYxVjI4REEvRmx4UDU3c1IrZjJQbTRYaVFE?=
 =?utf-8?B?eDUyMWtmZExGc3pmSUFaZmU4U3RMUU1CSGcwajg2Yk9CTlNUN08yU0tmTzkv?=
 =?utf-8?B?emZJdXVkYUpCUldLNTZ0Q25zNE45dmQ4ZmkwZDNZemFrdktkdDJLaGszQTdT?=
 =?utf-8?B?NmVieXEzYnBJaXJkODFHQWxYTHdCczV1ZlA1SU5UZEJvVlRWZmRLbTgwRHYw?=
 =?utf-8?B?aUF5NWUzQy8rT2lhMmhYZGdrKzVjUGZxMWJYZzJTcUhlTTdiQ21mSjVEWWhE?=
 =?utf-8?B?YlNWS2dMVkRRWnNDcUsybjBmREtJT2hFUGtMVFp0ZmFiL1F1NWMvZGtWY2g2?=
 =?utf-8?B?Qi9JVGVETWtXcm15RjE0b25KZGRNc2xjcFI5a1FjOXhnTm5ZaEU5RFhmTzcw?=
 =?utf-8?B?SndnbkZMVSt5NnRNQjdVaFZXUjZvaE90bm1vd0FzOWdnMzVwa2lUSXFDMDdu?=
 =?utf-8?B?YTRWVVRzSnp0QzVjbHk4eVl4dVFFWnlwQ2ljeTBYcENVek9jdE9SeTJHN1NB?=
 =?utf-8?B?Tit2RHRWdXIybVRDNEFUbXRwQ0JkNWtBT2VYVDhSSzJrZDNCeWphdWZLNFFO?=
 =?utf-8?B?RHFGM3c1Yk11OGlVdDVlT2hUVnE2MTdhUjJaQjVJSnVwSit3MWlIZTZmbytW?=
 =?utf-8?B?Z0NGU1EwcjBVZkZMVTN3OEFhSllRTVIvRE95ek9aNWlVSGFuMEQzb3ZzNmtI?=
 =?utf-8?B?anNlMXhLZFdIY2UvT0xwUXJ0VzNwVE55dVA4RWxMWnZDOHNaTTRBa0NPQWw5?=
 =?utf-8?B?eTZCZWZRNkJsVk5nZU9UclBrZ1ZkbWRVWDdaUTBiY2hhQkIwb1pCTFQ1d0o0?=
 =?utf-8?B?aGtxbHpwbE52U3RlTlRIZWEvRnM0eVpXRUxuQ2xTd1JnYmdSalpIbWpLWnFn?=
 =?utf-8?B?NURSZHk4WkkwbDQxM2tWNUhBTFcwMGppbFlRcUV1VDZCSCtMckJCcnRrSStl?=
 =?utf-8?B?Rjh1dGJDNllwY0kvK3ZDeE9aYjYveHBEMW5McmdaQU1pd2tYNWJkdEhJUFhJ?=
 =?utf-8?B?WGpMTXpxdjMra0RaaDhkaFdmbGJXNzFNeW8vNlBOSHdCeWRqSkNhSjUxemtk?=
 =?utf-8?B?WW4zWk9qRmdoSDhWNThuVjFLQklIZXNzYVRSbVRHcEJLZkVyMGpJWlp0NkVD?=
 =?utf-8?B?TU1xcTRIQUZmWUtReHlBdVRHNFVhRHQvL0FFOU1PMG1DS3pqR0YySVFvdCtK?=
 =?utf-8?B?YUJRMWROei9QN0dpVUZ2cFZvOWlpeDNabG5NTERuNFhBbkVBUDYyOFYyR09i?=
 =?utf-8?B?bnUwY013N25iT2tWakhaRU90NUpIMW1HZDdUQi9BRmRobkxxZCtWMy9BTVhF?=
 =?utf-8?B?dGxYcXpLVGxzckZMTmtKNVZ2TVB5cWV5cGkvaGlQRUZSaDg5WXFZelZ0eUlY?=
 =?utf-8?Q?C7J76qmizDAMjjwwrKZVzEAug?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662bb414-2e90-47b4-f957-08db8c7282d1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:19:25.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU7AN+LUIpEaH8H2HbM44jJJ0YvFNnGJZn6o/4iv0E0LoShqRA5FTQuRHlFyRRF/4v9BTAi5td7SJf28sjuQdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 7/24/23 11:23, Fan Ni wrote:
> From: Fan Ni <nifan@outlook.com>
> 
> Per CXL spec 3.0, two mailbox commands are implemented:
> Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
> Release Dynamic Capacity (Opcode 4803h) 8.2.9.8.9.4.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 253 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |   3 +-
>  2 files changed, 255 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 754ab68b78..d547385ba7 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -84,6 +84,8 @@ enum {
>      DCD_CONFIG  = 0x48, /*r3.0: 8.2.9.8.9*/
>          #define GET_DC_CONFIG          0x0
>          #define GET_DYN_CAP_EXT_LIST   0x1
> +        #define ADD_DYN_CAP_RSP        0x2
> +        #define RELEASE_DYN_CAP        0x3
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -1086,6 +1088,251 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * Check whether the bits at addr between [nr, nr+size) are all set,
> + * return 1 if all 1s, else return 0
> + */
> +static inline int test_bits(const unsigned long *addr, int nr, int size)
> +{
> +    unsigned long res = find_next_zero_bit(addr, size + nr, nr);
> +
> +    return (res >= nr + size) ? 1 : 0;
> +}
> +
> +/*
> + * Find dynamic capacity region id based on dpa range [dpa, dpa+len)
> + */
> +static uint8_t find_region_id(struct CXLType3Dev *dev, uint64_t dpa,
> +        uint64_t len)
> +{
> +    int8_t i = dev->dc.num_regions - 1;
> +
> +    while (i > 0 && dpa < dev->dc.regions[i].base) {
> +        i--;
> +    }
> +
> +    if (dpa < dev->dc.regions[i].base
> +            || dpa + len > dev->dc.regions[i].base + dev->dc.regions[i].len) {
> +        return dev->dc.num_regions;
> +    }
> +
> +    return i;
> +}
> +
> +static void insert_extent_to_extent_list(CXLDCDExtentList *list, uint64_t dpa,
> +        uint64_t len, uint8_t *tag, uint16_t shared_seq)
> +{
> +    CXLDCD_Extent *extent;
> +    extent = g_new0(CXLDCD_Extent, 1);
> +    extent->start_dpa = dpa;
> +    extent->len = len;
> +    if (tag) {
> +        memcpy(extent->tag, tag, 0x10);
> +    } else {
> +        memset(extent->tag, 0, 0x10);
> +    }
> +    extent->shared_seq = shared_seq;
> +
> +    QTAILQ_INSERT_TAIL(list, extent, node);
> +}
> +
> +typedef struct updated_dc_extent_list_in_pl {
> +    uint32_t num_entries_updated;
> +    uint8_t rsvd[4];
> +    struct { /* r3.0: Table 8-130 */
> +        uint64_t start_dpa;
> +        uint64_t len;
> +        uint8_t rsvd[8];
> +    } QEMU_PACKED updated_entries[];
> +} QEMU_PACKED updated_dc_extent_list_in_pl;
> +
> +/*
> + * The function only check the input extent list against itself.
> + */
> +static CXLRetCode detect_malformed_extent_list(CXLType3Dev *dev,
> +        const updated_dc_extent_list_in_pl *in)
> +{
> +    unsigned long *blk_bitmap;
> +    uint64_t min_block_size = dev->dc.regions[0].block_size;
> +    struct CXLDCD_Region *region = &dev->dc.regions[0];
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    uint8_t rid;
> +    CXLRetCode ret;
> +
> +    for (i = 1; i < dev->dc.num_regions; i++) {
> +        region = &dev->dc.regions[i];
> +        if (min_block_size > region->block_size) {
> +            min_block_size = region->block_size;
> +        }
> +    }
> +
> +    blk_bitmap = bitmap_new((region->len + region->base
> +                - dev->dc.regions[0].base) / min_block_size);
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        rid = find_region_id(dev, dpa, len);
> +        if (rid == dev->dc.num_regions) {
> +            ret = CXL_MBOX_INVALID_PA;
> +            goto out;
> +        }
> +
> +        region = &dev->dc.regions[rid];
> +        if (dpa % region->block_size || len % region->block_size) {
> +            ret = CXL_MBOX_INVALID_EXTENT_LIST;
> +            goto out;
> +        }
> +        /* the dpa range already covered by some other extents in the list */
> +        if (test_bits(blk_bitmap, dpa / min_block_size, len / min_block_size)) {
> +            ret = CXL_MBOX_INVALID_EXTENT_LIST;
> +            goto out;
> +        }
> +        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size);
> +   }
> +
> +    ret = CXL_MBOX_SUCCESS;
> +
> +out:
> +    g_free(blk_bitmap);
> +    return ret;
> +}
> +
> +/*
> + * cxl spec 3.0: 8.2.9.8.9.3
> + * Add Dynamic Capacity Response (opcode 4802h)
> + * Assume an extent is added only after the response is processed successfully
> + * TODO: for better extent list validation, a better solution would be
> + * maintaining a pending extent list and use it to verify the extent list in
> + * the response.
> + */
> +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(struct cxl_cmd *cmd,
> +        CXLDeviceState *cxl_dstate, uint16_t *len_unused)
> +{
> +    updated_dc_extent_list_in_pl *in = (void *)cmd->payload;
> +    struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev,
> +            cxl_dstate);
> +    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCD_Extent *ent;
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    CXLRetCode ret;
> + 
> +    if (in->num_entries_updated == 0) {
> +        ret = CXL_MBOX_SUCCESS;
> +        goto out;
> +    }
> +
> +    ret = detect_malformed_extent_list(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        goto out;
> +    }
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        /*
> +         * Check if the DPA range of the to-be-added extent overlaps with
> +         * existing extent list maintained by the device.
> +         */
> +        QTAILQ_FOREACH(ent, extent_list, node) {
> +            if (ent->start_dpa == dpa && ent->len == len) {
> +                ret = CXL_MBOX_INVALID_PA;
> +                goto out;
> +            } else if (ent->start_dpa <= dpa
> +                    && dpa + len <= ent->start_dpa + ent->len) {
> +                ret = CXL_MBOX_INVALID_PA;
> +                goto out;
> +            } else if ((dpa < ent->start_dpa + ent->len
> +                        && dpa + len > ent->start_dpa + ent->len)
> +                    || (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> +                ret = CXL_MBOX_INVALID_PA;
> +                goto out;
> +            }
> +        }
> +
> +        /*
> +         * TODO: add a pending extent list based on event log record and verify
> +         * the input response
> +         */
> +
> +        insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> +    }
> +    ret = CXL_MBOX_SUCCESS;
> +
> +out:
> +    return ret;

I think you could drop the 'out' label and just return directly from all the
places in this routine. There is no cleanup or extra work done at 'out'.

-Nathan Fontenot

> +}
> +
> +/*
> + * Spec 3.0: 8.2.9.8.9.4
> + * Release Dynamic Capacity (opcode 4803h)
> + **/
> +static CXLRetCode cmd_dcd_release_dyn_cap(struct cxl_cmd *cmd,
> +        CXLDeviceState *cxl_dstate,
> +        uint16_t *len_unused)
> +{
> +    updated_dc_extent_list_in_pl *in = (void *)cmd->payload;
> +    struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev,
> +            cxl_dstate);
> +    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCD_Extent *ent;
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    CXLRetCode ret;
> +
> +    if (in->num_entries_updated == 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    ret = detect_malformed_extent_list(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        QTAILQ_FOREACH(ent, extent_list, node) {
> +            if (ent->start_dpa == dpa && ent->len == len) {
> +                break;
> +            } else if (ent->start_dpa < dpa
> +                    && dpa + len <= ent->start_dpa + ent->len) {
> +                /* remove partial extent */
> +                uint64_t len1 = dpa - ent->start_dpa;
> +                uint64_t len2 = ent->start_dpa + ent->len - dpa - len;
> +
> +                if (len1) {
> +                    insert_extent_to_extent_list(extent_list, ent->start_dpa,
> +                            len1, NULL, 0);
> +                }
> +                if (len2) {
> +                    insert_extent_to_extent_list(extent_list, dpa + len, len2,
> +                            NULL, 0);
> +                }
> +                break;
> +            } else if ((dpa < ent->start_dpa + ent->len
> +                        && dpa + len > ent->start_dpa + ent->len)
> +                    || (dpa < ent->start_dpa && dpa + len > ent->start_dpa))
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        if (ent) {
> +            QTAILQ_REMOVE(extent_list, ent, node);
> +            g_free(ent);
> +        } else {
> +            /* Try to remove a non-existing extent */
> +            return CXL_MBOX_INVALID_PA;
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> + 
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1129,6 +1376,12 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
>          "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
>          8, 0 },
> +    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> +        "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> +        ~0, IMMEDIATE_DATA_CHANGE },
> +    [DCD_CONFIG][RELEASE_DYN_CAP] = {
> +        "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> +        ~0, IMMEDIATE_DATA_CHANGE },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a9cfe4e904..5bf1dd4024 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -130,7 +130,8 @@ typedef enum {
>      CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
>      CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
>      CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
> -    CXL_MBOX_MAX = 0x17
> +    CXL_MBOX_INVALID_EXTENT_LIST = 0x1E, /* cxl r3.0: Table 8-34*/
> +    CXL_MBOX_MAX = 0x1F
>  } CXLRetCode;
>  
>  struct cxl_cmd;
