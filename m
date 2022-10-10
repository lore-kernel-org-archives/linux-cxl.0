Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B191DC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 15:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJJPSP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJJPSO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 11:18:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E97D6E899
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 08:18:13 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmMt65Lshz67Xf1;
        Mon, 10 Oct 2022 23:15:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:18:10 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 16:18:10 +0100
Date:   Mon, 10 Oct 2022 16:18:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <20221010161809.00006f8e@huawei.com>
In-Reply-To: <CAD3UvdT1ZHJDaqj05C+n7t4rM7yhjZyM6fooXAfG12rAYnBqmw@mail.gmail.com>
References: <20221006000103.49542-1-gregory.price@memverge.com>
        <20221006094557.000035ab@huawei.com>
        <20221006095007.00001271@huawei.com>
        <Yz75ppPOwYCvNamy@fedora>
        <20221006174214.000059c7@huawei.com>
        <Yz8QlQ9yLFrWxWsN@fedora>
        <CAD3UvdT1ZHJDaqj05C+n7t4rM7yhjZyM6fooXAfG12rAYnBqmw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 7 Oct 2022 10:50:12 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Now that i've had some time to look at the spec, the DVSEC CXL Capability
> register (8.1.3.1 in 3.0 spec)
> only supports enabling two HDM ranges at the moment, which to me means we
> should implement
> 
> memdev0=..., memdev1=...

That needs to work (for backwards compatibility)
but doesn't need to be the most optimal mapping.  So you could have
two HDM ranges defined, but if your software is clever enough to
use the CXL 2.0 infrastructure you can have more (Linux is).

> 
> Yesterday I pushed a patch proposal that separated the regions into
> persistent and volatile, but
> i had discovered that there isn't a good way (presently) to determine of a
> MemoryBacking object
> is both file File-type AND has pmem=true, meaning we'd have to either
> expose that interface
> (this seems dubious to me) or do the following:
Whilst there are good usecases for using actual volatile and non volatile
for the backends, I don't think we want to enforce that as it should
'work' with whatever backends are used.
> 
> memdev0=mem0,memdev0-pmem=true,memdev1=mem0,memdev0-pmem=false
> 
> and then simply store a bit for each hostmem region accordingly to report
> pmem/volatile.
> This would allow the flexibility for the backing device to be whatever the
> user wants while
> still being able to mark the behavior of the type-3 device as pmem or
> volatile.  Alternatively
> we could make `memdev0-type=` and allow for new types in the future I
> suppose.
> 
That was why I had one suggestion of just supporting two memdevs.

memdev-volatile and memdev-nonvolatile but then messing with whether the
whole memdev was presented depending on the set partition.  I'm increasingly
thinking that is the least ugly solution.  + until we implement set partition
along with a control on maximum size of partitionable region, we can
just use a pair of memdevs to provide all the information needed to emulate
the devices.

> The one thing I'm a bit confused on - the Media_type and Memory_Class
> fields in the DVSEC
> CXL Range registers (8.1.3.8.2).  Right now they're set to "010b" = Memory
> Characteristics
> are communicated via CDAT".  Do the devices presently emulate this? I'm
> finding it hard to pick
> apart the code to identify it.

Not upstream yet.

Patches on list + can be found at

https://gitlab.com/jic23/qemu/-/commits/cxl-2022-10-09
There are a few messy corners in that tree but it should work. I'll be
pushing out a new version in a few days.

I updated that in latest version to build the tables based on the
memdev provided.  We'll want to add the volatile support to that alongside
your patch.

Jonathan

