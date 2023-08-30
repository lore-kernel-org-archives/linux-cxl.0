Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E39C83F1F
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Aug 2023 18:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbjH3SxM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245586AbjH3Ph3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Aug 2023 11:37:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD5113
        for <linux-cxl@vger.kernel.org>; Wed, 30 Aug 2023 08:37:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbT0f1VYxz6HJZZ;
        Wed, 30 Aug 2023 23:36:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 16:37:21 +0100
Date:   Wed, 30 Aug 2023 16:37:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     =?ISO-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
Subject: Re: [Qemu PATCH v2 9/9] hw/mem/cxl_type3: Add dpa range validation
 for accesses to dc regions
Message-ID: <20230830163720.00000f9c@Huawei.com>
In-Reply-To: <d0d7ca1d-81bc-19b3-4904-d60046ded844@wdc.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6@uscas1p2.samsung.com>
        <20230725183939.2741025-10-fan.ni@samsung.com>
        <d0d7ca1d-81bc-19b3-4904-d60046ded844@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> > +
> > +/*
> > + * This function check whether a dpa range [dpa, dpa + len) has been backed
> > + * with dc extents, used when validating read/write to dc regions
> > + */
> > +static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > +        uint64_t len)
> > +{
> > +    int i;
> > +    CXLDCD_Region *region = &ct3d->dc.regions[0];
> > +    uint64_t nbits;
> > +    long nr;
> > +
> > +    if (dpa < region->base
> > +            || dpa >= region->base + ct3d->dc.total_capacity)
> > +        return false;
> > +
> > +    /*
> > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> > +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> > +     * Region 7 for the highest DPA.
> > +     * So we check from the last region to find where the dpa belongs.
> > +     * access across multiple regions is not allowed.
> > +     */
> > +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> > +        region = &ct3d->dc.regions[i];
> > +        if (dpa >= region->base) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    nr = (dpa - region->base) / region->block_size;  
> 
> > +    nbits = len / region->block_size;
oops. Len is probably always smaller than block_size (typically 8 or less)
so nbits always 0.  Should be 1 in those cases.

> > +    return find_next_zero_bit(region->blk_bitmap, nbits, nr) >= nr + nbits;  
> 
> The 2nd parameter to find_next_zero_bit is the length of the bitmap, so 
> shouldn't this be something like (also considering that len is the 
> read/write len, and will be smaller than the region block size):
> 
>    nbits = DIV_ROUND_UP(len, region->block_size);

>  
> 
>    return find_next_zero_bit(region->blk_bitmap, nbits + nr, nr) ==
>           nbits + nr;

Agreed with your suggestion. I'll carry that in my forward port of this
series for now and update my tree at
gitlab.com/jic23/qemu branch will probably be cxl-2023-08-30
a bit later today.

Jonathan

