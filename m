Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C2C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 15:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJJPZZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJJPZY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 11:25:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD53D589
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 08:25:18 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmN4j1dHGz67dBN;
        Mon, 10 Oct 2022 23:24:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:25:16 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 16:25:15 +0100
Date:   Mon, 10 Oct 2022 16:25:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 2/2] hw/cxl: Allow CXL type-3 devices to be persistent
 or volatile
Message-ID: <20221010162515.000009f8@huawei.com>
In-Reply-To: <20221006233702.18532-2-gregory.price@memverge.com>
References: <20221006233702.18532-1-gregory.price@memverge.com>
        <20221006233702.18532-2-gregory.price@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu,  6 Oct 2022 19:37:02 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> This commit enables setting one memory region for a type-3 device, but
> that region may now be either a persistent region or volatile region.
> 
> Future work may enable setting both regions simultaneously, as this is
> a possible configuration on a real type-3 device.  The scaffolding was
> put in for this, but is left for further work.
> 
> The existing [memdev] property has been deprecated and will default the
> memory region to a persistent memory region (although a user may assign
> the region to a ram or file backed region).
> 
> There is presently no interface with which to expose a MemoryRegion's
> real backing type (HostMemoryBackendRam/File), otherwise we could have
> used File to imply pmem (or inspected HostMemoryBackendFile->is_pmem) to
> deterine whether the backing device supported pmem mode.  This should be
> considered for future work, as it would make creating an array of
> HostMemory devices to represent DIMMs on a Single-Logical-Device
> MemoryExpander fairly straightforward.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
Looks good to me, though I haven't tested it yet.

A few trivial comments inline.

>      *len = sizeof(*part_info);
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 1837c1c83a..998461dac1 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -100,18 +100,47 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>      DeviceState *ds = DEVICE(ct3d);
>      MemoryRegion *mr;
>      char *name;
> +    bool is_pmem = false;
>  
> -    if (!ct3d->hostmem) {
> -        error_setg(errp, "memdev property must be set");
> +    /*
> +     * FIXME: For now we only allow a single host memory region.

TODO maybe?  FIXME tends to lead to reviewers asking why we haven't
fixed it yet!

> +     * Handle the deprecated memdev property usage cases
> +     */
> +    if (!ct3d->hostmem && !ct3d->host_vmem && !ct3d->host_pmem) {
> +        error_setg(errp, "at least one memdev property must be set");
>          return false;
> +    } else if (ct3d->hostmem && (ct3d->host_vmem || ct3d->host_pmem)) {
> +        error_setg(errp, "deprecated [memdev] cannot be used with new "
> +                         "persistent and volatile memdev properties");
> +        return false;
> +    } else if (ct3d->hostmem) {
> +        warn_report("memdev is deprecated and defaults to pmem. "
> +                    "Use (persistent|volatile)-memdev instead.");

I'd suggest we don't warn on this yet. There is limited advantage in
doing so given it's easy to carry on supporting by just treating
it as another name for persistent-memdev


> +        is_pmem = true;
> +    } else {
> +        if (ct3d->host_vmem && ct3d->host_pmem) {
> +            error_setg(errp, "Multiple memory devices not supported yet");
> +            return false;
> +        }
> +        is_pmem = !!ct3d->host_pmem;
> +        ct3d->hostmem = ct3d->host_pmem ? ct3d->host_pmem : ct3d->host_vmem;
>      }
>  
