Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67A3C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 18:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBBSOE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBBSOD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 13:14:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C481CAF5
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 10:14:01 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P76J54q8tz6J7Py;
        Fri,  3 Feb 2023 02:09:41 +0800 (CST)
Received: from localhost (10.81.211.143) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 18:13:58 +0000
Date:   Thu, 2 Feb 2023 18:13:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <20230202181357.00002827@Huawei.com>
In-Reply-To: <Y9riPw7ccA34FQG6@memverge.com>
References: <Y9ll5S3Y4BZkakNn@memverge.com>
        <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
        <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
        <Y9meWfDiCGbca4nP@memverge.com>
        <Y9mhe2xPGRE1/7cC@memverge.com>
        <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
        <20230131235003.GA336751@bgt-140510-bm03>
        <Y9n4zjtwf+w6xnmW@memverge.com>
        <Y9rWskfaz9dLoW+l@memverge.com>
        <20230202160314.00002cfa@Huawei.com>
        <Y9riPw7ccA34FQG6@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.211.143]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 1 Feb 2023 17:05:51 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Feb 02, 2023 at 04:03:14PM +0000, Jonathan Cameron wrote:
> > 
> > Note that there is another QEMU issue that needs resolving if you intend
> > to use this as normal memory and it's worse under KVM. Effects the
> > corner case where an instruction crosses the boundary from normal memory
> > into CXL memory.
> > 
> > Thanks to the various QEMU folk who are helping us figure out what to do
> > about this for the explanations that follow!
> > 
> > We currently handle the region as MMIO - in QEMU terms, no actual relationship
> > to what the OS sees (as need to mess with the address
> > mappings on each access for interleaving). That's a problem for KVM
> > (which may not cope with sub page granularity remapping under the hood).
> > 
> > https://lore.kernel.org/qemu-devel/ff3f25ee-1c98-242b-905e-0b01d9f0948d@linaro.org/#r
> > 
> > Also a problem in TCG because the handling of executing out of MMIO takes
> > a shortcut.  It is fine (though very low performance as using a fall back path)
> > for fully in MMIO regions, but not the corner case where the start of the instruction
> > is in normal RAM (with all the related fast paths and instruction caching) and
> > the end of the instruction is in the CXL MMIO region (a CFMWS window).
> > 
> > Currently looks like the fix will be to use the slow path for this case.
> > Patches welcome!
> > 
> > Anyhow, in meantime beware.
> > 
> > Jonathan
> >   
> 
> This all tracks, and is similar to what i've seen on other hypervisor
> platforms when attempting to execute out of MMIO.
> 
> The reality is that CXL is not MMIO and not RAM or ROM or any of that
> and is intended (eventually) to even be shared between QEMU instances.

Indeed it's an oddity - but this is all smoke and mirrors anyway
as far as the OS is concerned. The OS / firmware doesn't need to know
anything about how we are modeling things in QEMU - we need to make
QEMU functionally correct.

> 
> That means it's likely going to require its own MemoryRegion model and
> some deep dark corners of TCG and friends are going to require some
> updates to make that work.
> 
> Whether it's worth the effort when the intent is to just let the
> hardware handle that in the future, i don't really know.

I think we need a fix, though perf can be terrible ;)
> 
> 
> 
> Some speculation here:
> 
> The crux of the issue, as i understand it, is the invalidation path.
> MMIO doesn't traditionally have a mechanism to tell the caches "hey
> i got updated, boot this cache line", so whenever your compiler accesses
> MMIO it - at best - does a fetch-and-discard, meaning that instruction
> translations can never be cached.  That's the source of the slow down on
> the QEMU side, you're constantly re-compiling the translations.

If we actually care, I think we could do some tricks with creating
a cache of pages in between the interleaved underlying element and TCG
so that it could behave as if it were dealing with a normal page when
executing, but when writing it would drop such a cache so the writes
reach the interleave elements. I don't think we do care for now though.

Slow down on TCG is fine (if possibly rather painful). We just need to
work around the currently broken corner.

> 
> On the KVM side, it likely requires a VMExit to handle the MMIO, and
> when it sees that it's an instruction fetch it probably just falls back
> to emulator mode to execute the instruction before re-entering.  Maybe
> there's a mild optimization where it continues executing until it leaves
> that MMIO region, but you're still getting QEMU performance over KVM.

Might be ways to improve that perf, but TCG is good enough for testing
so I'm not sure we care.  I tend to be doing cross architecture anyway
so don't care much about KVM :)

> 
> So that all makes sense to me.
> 
> To me, the solution here isn't to change QEMU, it's to change the kernel
> to try to get it to aggressively keep executable regions out of CXL by
> marking CXL regions into a new zone type that essentially says "Use this
> as a last resort only for X pages".  But that would likely require
> adding migration code to the likes of mprotect and friends.

No. This is a QEMU emulation issue, not a real hardware one - so we shouldn't
touch the kernel. On real hardware (with exception of shared case) it should
be fine to execute from CXL memory.

> 
> In the meantime, sure would be nice to have a userland program that
> grooms software to detect this problem and migrate X pages to DRAM.

Lots of program memory is exceedingly cold (typically things like init and
exit code that is only touched once per program run), so we very much do not want
to do this.  In some cases we want to push executable memory to the CXL memory.

Jonathan

> 
> 
> ~Gregory

