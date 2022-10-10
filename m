Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A6C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 20:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJJUH5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJJUH4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 16:07:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CFF1D0E0
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 13:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnj90TlE7547pOdBWz9HhobVxqThm7xPilnOJCad3xyfAZ5LzZgEnSBHthtkQFHyPvW1gx7pZIkQyvPdaJsRU5/keaWn8f9bliqsA02E2UHPT2MNOF/W2rS7hhGmvQzrLPIjlluExOLarghPSzXlIwGfLeYkozYHZjBZgeHU9jORhhi8Uj0by4yITVueZYyQ5YU79dwup/Em0lKDTwBj5xlUtO0ijG89jrZB/1UiT92PROQUVdRzsNkwMJ4gqI0gFYrboCNwyoM0c04/d/yVqrZb6yycm3rEF+3jzUPC0+uI5sRwFYfjipqGUQbEn26jz+PbkztM54uNjHjbDfyYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Vi1ja634c5BG9GPMXsCJE6shgvUQoXC51sSWijhlxA=;
 b=GplVG+iY/o//R2Ok8wdDZv2vgKDIvADhgPJszhc3d0+omlmdnD8jXxxjCNKpx+5cfE38IOUKAAJyBLSrOWKI4MBf99bgFDL7VnTVTB/tV9RYxaecU9BdnPrmeassPa+pJSSim5F93TnNqnWrwLDdq5cCwTnEdTGAf7ryPzIG60XWfZLsHBjy8ekGeAX64fCYRi1tseKQOInjxxMmSOyBpmG1jSTXkv7VfVSpHEsF/2NeBslA0wkbwvvlc2C9xkxlZHnyM1xdFsKNhVVv+AQ9ehdl6BZdjHtZdmeA2vpKo0TI5UFIvCnLDqY6HcqA46m1rRw+g3ml4bA2k4s/tq/Yjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Vi1ja634c5BG9GPMXsCJE6shgvUQoXC51sSWijhlxA=;
 b=jvs6sY9uyZXZa5DzdemZt/w5cziFdievjalPiMQqVUf3/f5gvblYzMfkKqC2iRLssJq191lJKYjYG87mMLoHZHHlOosvSkEKju9DR8Nx9mpli2mwIjsMn1xBLrLiq0b5kbiUhkUZJroFqOwsgE8thLGj3Je/VXVSML4s3yyTWow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB5035.namprd17.prod.outlook.com (2603:10b6:510:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 20:07:49 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4%5]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 20:07:49 +0000
Date:   Mon, 10 Oct 2022 16:07:47 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        bwidawsk@kernel.org
Subject: Re: [PATCH 2/2] hw/cxl: Allow CXL type-3 devices to be persistent or
 volatile
Message-ID: <Y0R7kxVjgkn4+oWH@memverge.com>
References: <20221006233702.18532-1-gregory.price@memverge.com>
 <20221006233702.18532-2-gregory.price@memverge.com>
 <20221010171229.let7egonsflyjixh@offworld>
 <20221010193654.khne63svaaf3piz4@offworld>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010193654.khne63svaaf3piz4@offworld>
X-ClientProxiedBy: MN2PR01CA0027.prod.exchangelabs.com (2603:10b6:208:10c::40)
 To BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: a84ab0d3-0a0e-4113-3d41-08daaafb1aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGV1wBhfFzE0yzm/WNKWJE4Bj1j+WINSLdheQ4Be6ALrlim+jVGlZFveeux2BvM2BFcKQqHoo+Bw443ZfWHr+4nweEm0kiGlHTN7LnYi580tyBFLW/tWKp6250kxri3QyLTw/lMd18hey1T7XBYRIUzkTN5HV+ov2Qp4RPFz6Swfww3XrWi0MFhTNv3qBX+19D35hQMPStX9HK1wTTBVi0/Ws2miv0LX5gWUkljX71SzJ/Sg/StF0Rg3o5oQ/fOc/nG6rGS/5sAvQzoJ9mPbBOGzWtBryhZqCJZmjW3wNJ1YWnhH6DCUSUsgOm8Yqy8FYyx/lLjGdLz0QC6DEbKQPB1k+xvb4J/JfYt016BQNFc/Ang2LTGrR7fQI+oWWWWbl1JIjQP9HJsfmwONvvwDgNw0Q1/nped9qIn/HtY8M5qpDWRTtC10aGicrhiXPXkUFL5ycr6cpROS46GJvzRrBnr3AfaPmCL1id71YJXNEJIl6uIegDAjFxdP4cKGlBjy0WUfzfvwO0d1NPQ74MCl0/QsXRvIex6fPSqMJ6G1ovP2Q+JdkUeBtF58olIvVQ9zLfWTopfLGNV4SjgbI1BCWkXfacdW/d1cJCKWFoWmqViw+jVxXkvxGwaJyl4UNsF29lrPMMKyS3pZjRQ0mScIFNRMxelQduYWXSL6rGItN/VyGJIJu4+MuyqJLAppeC8wF7kI9sqQVUxWqqzhAQwpOKWWjQ9W2YkSEbEdS1XVDYC4sa/+s2aFM+CQ04KIi71LTYFt1ImGNCcBJE/Apynwj4S0b4JKfyaFsUrQPbmTC10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(136003)(366004)(396003)(376002)(346002)(451199015)(316002)(6916009)(2906002)(8676002)(186003)(6486002)(66476007)(2616005)(66946007)(41300700001)(30864003)(66556008)(8936002)(4326008)(5660300002)(44832011)(26005)(478600001)(6506007)(86362001)(36756003)(52116002)(6512007)(38350700002)(38100700002)(67856001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z58yNBcWKjIDabXX/vyxAHMKkBxxbSSM9uP6J0X5iXrnboUy+csa7qUF07/R?=
 =?us-ascii?Q?kdY9/3rYzBQj+h8xZa8yLGWQWpudzW9aCLnD2pY3RyZkeXnEyySOxUdOo6Qt?=
 =?us-ascii?Q?MhxaZ+r2YWJIfVcaoCHiUv7OxTUbKQAmdWdnOCzuUb6E0GtahSOzpCtmxKV0?=
 =?us-ascii?Q?EDcdr1JfWbQCPHEI7Mvm0iUExYRaAKzGACAJngpi2C86gvdhHufGk8TzDfgp?=
 =?us-ascii?Q?qzYKG3yqdkt6EbwSadW8bs0bKq/usWbp19IavDGAcLQpDCmPjBKOj3p6vWQM?=
 =?us-ascii?Q?XdWBcRFfqGOf0wf7DQZj76iHnz9x8TlBvEyFPDAKpXdu8NAOmitpBhsc78Js?=
 =?us-ascii?Q?fCmNgSxQMC7rypoCU+8ZDMKMRCzpyJdVY8ezOaiQLvgWU4zF9GJLzT7mpURH?=
 =?us-ascii?Q?PvCieyU3dhSwjmeIGjUm5HO2LJ1wqr/vsKun0X4gKs63+EfS3O0Do7C9MiF5?=
 =?us-ascii?Q?iHHW7RX75Y9ceOHTbpk+BZftc3uePHVZrgjm91Zt6WJcPlrltn366//ZX8Hd?=
 =?us-ascii?Q?iILn6Iv4t/t0H4yV6/ZJuXxGMCH4JwY3zp1S/KtEO/goucopjMnqCxMS4iao?=
 =?us-ascii?Q?qqhQWkJ+WQGQBhX3nCoU/CL/f92R/Jurp2SYZ2gATcFcTYzv5EZs8I5Pxpl8?=
 =?us-ascii?Q?LnZPLImawxeiKYYvDtyz2Whmw6BgcSo47gAPGqnyLK/xkY/sjKrp7Rdy1O0v?=
 =?us-ascii?Q?dBiYzeybGxIuR6UmhSudEXvMk6KU+cAIz4Sa7a4xm5V7I8qJwDkQ+TDT5ols?=
 =?us-ascii?Q?tNQsZBsK06y5MfttjNtVxzUio0Ytsc3E7f5PHggoI8apaqP9O4dAwy3t3i0+?=
 =?us-ascii?Q?gyiUpw+lNBsp7WokMYJVOWK/ERXkM1A9tdAmJzhyPyswBE5a+oChsbC+lODU?=
 =?us-ascii?Q?nddF9oy3hdo5pY0ejGLibMXvZVif+NncsQNDHLo5TOyWWepzIwCkzrLsK+C2?=
 =?us-ascii?Q?2n0AF/FlHqzYb/1KmDF3wcxP2hTEHx7D78L3BtbkZ7J1ZMLpioaNRmbu+TA8?=
 =?us-ascii?Q?swy2jMschc/DmVCziwJ1Lau9lbFLdvQVu4GUlBTBKG8DzrtNJ4fGQMfto8zj?=
 =?us-ascii?Q?lO11BKCjQ2o/hNU+nBWqDY1ajIJJKieMYS0HHh/kPxMaW5fLuD/zgRo9PaUF?=
 =?us-ascii?Q?e3CUfVegwcSw1BGnTzRWT/rn3efWMZ9P9CEgQtpMXFfsGv/XiaLBOScdbZpo?=
 =?us-ascii?Q?AcrLitrEyCI+xTxolxj+G26tdQJ9D8dO5/Yd0u9sBVhmWyQpjnvI49QfUW2f?=
 =?us-ascii?Q?kTEkw+z6HqlxJh2aWhm9Z5tZf5F4YXGBeLv7/jwoD8JgPxZ/8wqiHfw+JT/C?=
 =?us-ascii?Q?gAzeRDiLsYsX+t057OStZm6P3/miaEorY4oXR65F5h7Maf9KmIWZlqScRU8t?=
 =?us-ascii?Q?80KKnUelGY8v0lWhQaGFK8UdEZNuQJ/x1MrVb/gNkO5118js1ITafHDoWTmT?=
 =?us-ascii?Q?/B3THqZnFFO6uS/zB54y+jmu8nMCaXqTM3qOYbKQBFRWD6LYehiP9OoB2oeV?=
 =?us-ascii?Q?CO5uwK4PlG+paS4X00ajmgiIxSpgbM7RgbNUSO/dwsBPxZWIxaPXnvBi+cNR?=
 =?us-ascii?Q?bkPUCNzjL5QhOhCj9fr+dfOrPVE6hczfp8d/lOBkrD7MtdOI4wFuHjEXcG34?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84ab0d3-0a0e-4113-3d41-08daaafb1aba
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:07:48.9522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOIOEKUP0B/oYk/5KmFBmVPa8AFQtsZwJi6gZXB9fXMTAkcWsOEFM9lIlSHTMyvE3P1dlw1g93QnxViPPcRXjqmxZEV5BqzdFVFJB/Kkt/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5035
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Hang tight, I'm whipping up a multi-region patch that will support a
vmem and pmem region and such.  Finally got oriented enough to figure
out the DPA decoding a bit.  I will probably need some help validating
the decoder logic and the CDAT table logic.

I will integrate the suggestions below into that patch set.

Jonathan i'm building on top of your gitlab branch and will make a
branch available for review when done.

On Mon, Oct 10, 2022 at 12:36:54PM -0700, Davidlohr Bueso wrote:
> On Mon, 10 Oct 2022, Davidlohr Bueso wrote:
> 
> > This hides requirement details as to the necessary changes that are needed for
> > volatile support - for example, build_dvsecs(). Imo using two backends (without
> > breaking current configs, of course) should be the initial version, not something
> > to leave pending.
> 
> Minimally this is along the lines I was thinking of. I rebased some of my original
> patches on top of yours. It builds and passes tests/qtest/cxl-test, but certainly
> untested otherwise. The original code did show the volatile support as per cxl-list.
> 
> As such users can still use memdev which will map to the pmemdev. One thing which I
> had not explored was the lsa + vmem thing, so the below prevents this for the time
> being, fyi.
> 
> Thanks,
> Davidlohr
> 
> ----8<----------------------------------------------------
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index e8341a818467..cd079dbddd9a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -18,14 +18,21 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>  {
>      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
>      uint8_t *dvsec;
> +    uint64_t size = 0;
> +
> +    if (ct3d->hostvmem) {
> +        size += ct3d->hostvmem->size;
> +    }
> +    if (ct3d->hostpmem) {
> +        size += ct3d->hostpmem->size;
> +    }
> 
>      dvsec = (uint8_t *)&(CXLDVSECDevice){
> -        .cap = 0x1e,
> +        .cap = 0x1e, /* one HDM range */
> 	 .ctrl = 0x2,
> 	 .status2 = 0x2,
> -        .range1_size_hi = ct3d->hostmem->size >> 32,
> -        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> -        (ct3d->hostmem->size & 0xF0000000),
> +        .range1_size_hi = size >> 32,
> +        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | (size & 0xF0000000),
> 	 .range1_base_hi = 0,
> 	 .range1_base_lo = 0,
>      };
> @@ -98,70 +105,60 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      DeviceState *ds = DEVICE(ct3d);
> -    MemoryRegion *mr;
>      char *name;
> -    bool is_pmem = false;
> 
> -    /*
> -     * FIXME: For now we only allow a single host memory region.
> -     * Handle the deprecated memdev property usage cases
> -     */
> -    if (!ct3d->hostmem && !ct3d->host_vmem && !ct3d->host_pmem) {
> +    if (!ct3d->hostvmem && !ct3d->hostpmem) {
> 	 error_setg(errp, "at least one memdev property must be set");
> 	 return false;
> -    } else if (ct3d->hostmem && (ct3d->host_vmem || ct3d->host_pmem)) {
> -        error_setg(errp, "deprecated [memdev] cannot be used with new "
> -                         "persistent and volatile memdev properties");
> -        return false;
> -    } else if (ct3d->hostmem) {
> -        warn_report("memdev is deprecated and defaults to pmem. "
> -                    "Use (persistent|volatile)-memdev instead.");
> -        is_pmem = true;
> -    } else {
> -        if (ct3d->host_vmem && ct3d->host_pmem) {
> -            error_setg(errp, "Multiple memory devices not supported yet");
> -            return false;
> -        }
> -        is_pmem = !!ct3d->host_pmem;
> -        ct3d->hostmem = ct3d->host_pmem ? ct3d->host_pmem : ct3d->host_vmem;
>      }
> 
> -    /*
> -     * for now, since there is only one memdev, we can set the type
> -     * based on whether this was a ram region or file region
> -     */
> -    mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> -        error_setg(errp, "memdev property must be set");
> +    /* TODO: volatile devices may have LSA */
> +    if (ct3d->hostvmem && ct3d->lsa) {
> +        error_setg(errp, "lsa property must be set");
> 	 return false;
>      }
> 
> -    /*
> -     * FIXME: This code should eventually enumerate each memory region and
> -     * report vmem and pmem capacity separate, but for now just set to one
> -     */
> -    memory_region_set_nonvolatile(mr, is_pmem);
> -    memory_region_set_enabled(mr, true);
> -    host_memory_backend_set_mapped(ct3d->hostmem, true);
> -
>      if (ds->id) {
> 	 name = g_strdup_printf("cxl-type3-dpa-space:%s", ds->id);
>      } else {
> 	 name = g_strdup("cxl-type3-dpa-space");
>      }
> -    address_space_init(&ct3d->hostmem_as, mr, name);
> -    g_free(name);
> 
> -    /* FIXME: When multiple regions are supported, this needs to aggregate */
> -    ct3d->cxl_dstate.mem_size = ct3d->hostmem->size;
> -    ct3d->cxl_dstate.vmem_size = is_pmem ? 0 : ct3d->hostmem->size;
> -    ct3d->cxl_dstate.pmem_size = is_pmem ? ct3d->hostmem->size : 0;
> +    if (ct3d->hostvmem) {
> +        MemoryRegion *vmr;
> 
> -    if (!ct3d->lsa) {
> -        error_setg(errp, "lsa property must be set");
> -        return false;
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        if (!vmr) {
> +            error_setg(errp, "volatile-memdev property must be set");
> +            return false;
> +        }
> +
> +        memory_region_set_nonvolatile(vmr, false);
> +        memory_region_set_enabled(vmr, true);
> +        host_memory_backend_set_mapped(ct3d->hostvmem, true);
> +        address_space_init(&ct3d->hostvmem_as, vmr, name);
> +        ct3d->cxl_dstate.vmem_size = ct3d->hostvmem->size;
> +        ct3d->cxl_dstate.mem_size += ct3d->hostvmem->size;
>      }
> 
> +    if (ct3d->hostpmem) {
> +        MemoryRegion *pmr;
> +
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        if (!pmr) {
> +            error_setg(errp, "legacy memdev or persistent-memdev property must be set");
> +            return false;
> +        }
> +
> +        memory_region_set_nonvolatile(pmr, true);
> +        memory_region_set_enabled(pmr, true);
> +        host_memory_backend_set_mapped(ct3d->hostpmem, true);
> +        address_space_init(&ct3d->hostpmem_as, pmr, name);
> +        ct3d->cxl_dstate.pmem_size = ct3d->hostpmem->size;
> +        ct3d->cxl_dstate.mem_size += ct3d->hostpmem->size;
> +    }
> +    g_free(name);
> +
>      return true;
>  }
> 
> @@ -210,7 +207,13 @@ static void ct3_exit(PCIDevice *pci_dev)
>      ComponentRegisters *regs = &cxl_cstate->crb;
> 
>      g_free(regs->special_ops);
> -    address_space_destroy(&ct3d->hostmem_as);
> +
> +    if (ct3d->hostvmem) {
> +        address_space_destroy(&ct3d->hostvmem_as);
> +    }
> +    if (ct3d->hostpmem) {
> +        address_space_destroy(&ct3d->hostpmem_as);
> +    }
>  }
> 
>  /* TODO: Support multiple HDM decoders and DPA skip */
> @@ -249,47 +252,86 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> 			    unsigned size, MemTxAttrs attrs)
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(d);
> -    uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    uint64_t total_size = 0, dpa_offset;
> +    MemoryRegion *vmr, *pmr;
> 
> -    /* TODO support volatile region */
> -    mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> +    vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    if (!vmr && !pmr) {
> 	 return MEMTX_ERROR;
>      }
> 
> +    if (vmr) {
> +        total_size += vmr->size;
> +    }
> +    if (pmr) {
> +        total_size += pmr->size;
> +    }
>      if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
> 	 return MEMTX_ERROR;
>      }
> -
> -    if (dpa_offset > int128_get64(mr->size)) {
> +    if (dpa_offset > total_size) {
> 	 return MEMTX_ERROR;
>      }
> 
> -    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data, size);
> +    if (vmr) {
> +        /* volatile starts at DPA 0 */
> +        if (dpa_offset <= int128_get64(vmr->size)) {
> +            return address_space_read(&ct3d->hostvmem_as,
> +                                  dpa_offset, attrs, data, size);
> +        }
> +    }
> +    if (pmr) {
> +        if (dpa_offset > int128_get64(pmr->size)) {
> +            return MEMTX_ERROR;
> +        }
> +        return address_space_read(&ct3d->hostpmem_as, dpa_offset,
> +                                  attrs, data, size);
> +    }
> +
> +    return MEMTX_ERROR;
>  }
> 
>  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> 			     unsigned size, MemTxAttrs attrs)
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(d);
> -    uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    uint64_t total_size = 0, dpa_offset;
> +    MemoryRegion *vmr, *pmr;
> 
> -    mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> +    vmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    if (!vmr && !pmr) {
> 	 return MEMTX_OK;
>      }
> -
> +    if (vmr) {
> +        total_size += vmr->size;
> +    }
> +    if (pmr) {
> +        total_size += pmr->size;
> +    }
>      if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
> 	 return MEMTX_OK;
>      }
> +    if (dpa_offset > total_size) {
> +        return MEMTX_ERROR;
> +    }
> 
> -    if (dpa_offset > int128_get64(mr->size)) {
> -        return MEMTX_OK;
> +    if (vmr) {
> +        if (dpa_offset <= int128_get64(vmr->size)) {
> +                return address_space_write(&ct3d->hostvmem_as,
> +                                  dpa_offset, attrs, &data, size);
> +        }
>      }
> -    return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
> +    if (pmr) {
> +        if (dpa_offset > int128_get64(pmr->size)) {
> +            return MEMTX_OK;
> +        }
> +        return address_space_write(&ct3d->hostpmem_as, dpa_offset, attrs,
> 				&data, size);
> +    }
> +
> +    return MEMTX_ERROR;
>  }
> 
>  static void ct3d_reset(DeviceState *dev)
> @@ -303,11 +345,11 @@ static void ct3d_reset(DeviceState *dev)
>  }
> 
>  static Property ct3_props[] = {
> -    DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
> -                     HostMemoryBackend *),
> -    DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, host_pmem,
> +    DEFINE_PROP_LINK("memdev", CXLType3Dev, hostpmem, TYPE_MEMORY_BACKEND,
> +                     HostMemoryBackend *), /* for backward-compatibility */
> +    DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, hostpmem,
> 		      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> -    DEFINE_PROP_LINK("volatile-memdev", CXLType3Dev, host_vmem,
> +    DEFINE_PROP_LINK("volatile-memdev", CXLType3Dev, hostvmem,
> 		      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
> 		      HostMemoryBackend *),
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index fd96a5ea4e47..c81f92ecf093 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -237,14 +237,13 @@ struct CXLType3Dev {
>      PCIDevice parent_obj;
> 
>      /* Properties */
> -    /* TODO: remove hostmem when multi-dev is implemented */
> -    HostMemoryBackend *hostmem;
> -    HostMemoryBackend *host_vmem;
> -    HostMemoryBackend *host_pmem;
> +    HostMemoryBackend *hostvmem;
> +    HostMemoryBackend *hostpmem;
>      HostMemoryBackend *lsa;
> 
>      /* State */
> -    AddressSpace hostmem_as;
> +    AddressSpace hostvmem_as;
> +    AddressSpace hostpmem_as;
>      CXLComponentState cxl_cstate;
>      CXLDeviceState cxl_dstate;
>  };
