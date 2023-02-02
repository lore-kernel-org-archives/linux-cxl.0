Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B53C05027
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 16:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjBBQD1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjBBQD0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 11:03:26 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DACC66036
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 08:03:18 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P73Sx4Pbdz6J9T2;
        Fri,  3 Feb 2023 00:02:09 +0800 (CST)
Received: from localhost (10.81.211.68) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 16:03:15 +0000
Date:   Thu, 2 Feb 2023 16:03:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <20230202160314.00002cfa@Huawei.com>
In-Reply-To: <Y9rWskfaz9dLoW+l@memverge.com>
References: <Y9h2VhGuraZfEJfD@memverge.com>
        <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
        <Y9ll5S3Y4BZkakNn@memverge.com>
        <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
        <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
        <Y9meWfDiCGbca4nP@memverge.com>
        <Y9mhe2xPGRE1/7cC@memverge.com>
        <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
        <20230131235003.GA336751@bgt-140510-bm03>
        <Y9n4zjtwf+w6xnmW@memverge.com>
        <Y9rWskfaz9dLoW+l@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.211.68]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 1 Feb 2023 16:16:34 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Wed, Feb 01, 2023 at 12:29:50AM -0500, Gregory Price wrote:
> > > Are you using single root port configuration? If yes, the following
> > > patch should have fixed the issue,
> > > https://lore.kernel.org/linux-cxl/20221215170909.2650271-1-fan.ni@samsung.com/
> > >   
> > > > [   97.476231] RSP: 0018:ffffa30000d23d20 EFLAGS: 00010292                      
> > 
> > I did not have this patch.  This should definitely make its way up.
> > 
> > ~Gregory  
> 
> 
> This fixed up the stack trace for me, but memregion is still failing to
> successfully complete.
> 
> It looks like configuration and decoder commit completes, but then
> cxl-cli bails out because writing
> 
> echo region0 > /sys/bus/cxl/drivers/cxl_region/bind
> 
> results in "Failed to synchronize CPU cache state"
> 
> I presume this is because of either a logic error or because the memory
> just isn't actually hooked up yet, but this is the relevant code:
> 
> 
> static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> {
>   if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
>     return 0;
> 
>   if (!cpu_cache_has_invalidate_memregion()) {
>     if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
>       dev_warn_once(
>         &cxlr->dev,
>         "Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>       clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>       return 0;
>     } else {
>       dev_err(&cxlr->dev,
>         "Failed to synchronize CPU cache state\n");
>       return -ENXIO;
>     }
>   }
> 
>   cpu_cache_invalidate_memregion(IORES_DESC_CXL);
>   clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>   return 0;
> }
> 
> 
> 
> Looks like i can bypass this with CONFIG_CXL_REGION_INVALIDATION_TEST
> but just wanted to report back incase this is not intended.
> 
> On x86, this invalidate_memregion() call maps to not having the
> hypervisor bit set:
> 
> bool cpu_cache_has_invalidate_memregion(void)
> {
>   return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
> }
> EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, DEVMEM);

Yup. I don't think we currently support this properly even when
doing TCG mode on QEMU rather than KVM.

Note that there is another QEMU issue that needs resolving if you intend
to use this as normal memory and it's worse under KVM. Effects the
corner case where an instruction crosses the boundary from normal memory
into CXL memory.

Thanks to the various QEMU folk who are helping us figure out what to do
about this for the explanations that follow!

We currently handle the region as MMIO - in QEMU terms, no actual relationship
to what the OS sees (as need to mess with the address
mappings on each access for interleaving). That's a problem for KVM
(which may not cope with sub page granularity remapping under the hood).

https://lore.kernel.org/qemu-devel/ff3f25ee-1c98-242b-905e-0b01d9f0948d@linaro.org/#r

Also a problem in TCG because the handling of executing out of MMIO takes
a shortcut.  It is fine (though very low performance as using a fall back path)
for fully in MMIO regions, but not the corner case where the start of the instruction
is in normal RAM (with all the related fast paths and instruction caching) and
the end of the instruction is in the CXL MMIO region (a CFMWS window).

Currently looks like the fix will be to use the slow path for this case.
Patches welcome!

Anyhow, in meantime beware.

Jonathan


> 
> 
> 
> I presume if i enable the invalidate_test bit in my config this will
> work, but if anyone can validate that this is expected behavior without
> it, that would be great.
> 
> Thanks!
> ~Gregory

