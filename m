Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB08AC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Oct 2022 15:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJNP30 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJNP3X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Oct 2022 11:29:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01C71C8431
        for <linux-cxl@vger.kernel.org>; Fri, 14 Oct 2022 08:29:19 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MpqyN2nctz67y8R;
        Fri, 14 Oct 2022 23:27:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 17:29:17 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 16:29:16 +0100
Date:   Fri, 14 Oct 2022 16:29:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <bwidawsk@kernel.org>, <mst@redhat.com>,
        <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH 5/5] hw/mem/cxl_type3: Refactor CDAT sub-table entry
 initialization into a function
Message-ID: <20221014162915.0000187a@huawei.com>
In-Reply-To: <Y0hpv8jdqi+r7f4r@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
        <20221012182120.174142-1-gregory.price@memverge.com>
        <20221012182120.174142-6-gregory.price@memverge.com>
        <20221013114711.00005623@huawei.com>
        <Y0hpv8jdqi+r7f4r@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 13 Oct 2022 15:40:47 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> > >      /* For now, no memory side cache, plausiblish numbers */
> > > -    *dslbis_nonvolatile1 = (CDATDslbis) {
> > > +    *dslbis1 = (CDATDslbis) {
> > >          .header = {
> > >              .type = CDAT_TYPE_DSLBIS,
> > > -            .length = sizeof(*dslbis_nonvolatile1),
> > > +            .length = sizeof(*dslbis1),
> > >          },
> > > -        .handle = nonvolatile_dsmad,
> > > +        .handle = dsmad_handle,
> > >          .flags = HMAT_LB_MEM_MEMORY,
> > >          .data_type = HMAT_LB_DATA_READ_LATENCY,
> > >          .entry_base_unit = 10000, /* 10ns base */
> > >          .entry[0] = 15, /* 150ns */  
> > 
> > If we are going to wrap this up for volatile / non-volatile 
> > we probably need to pass in a reasonable value for these.
> > Whilst not technically always true, to test the Linux handling
> > I'd want non-volatile to report as longer latency.
> >   
> 
> Here's a good question
> 
> Do we want the base unit and entry to be adjustable for volatile and
> nonvolatile regions for the purpose of testing?  Or should this simply
> be a static value for each?

We definitely want a 'default' value if nothing is provided.
It might be useful to allow it to be adjusted, but lets add that when
we have a use for it (perhaps testing some stuff in kernel where the
values matter enough to make them controllable).

> 
> Since we need to pass in (is_pmem/is_nonvolatile) or whatever into the
> cdat function, we could just use that to do one of a few options:
>     1) Select from a static value
>     2) Select a static value and apply a multiplier for nvmem
>     3) Use a base/value provided by the use and apply a multiplier
>     4) Make vmem and pmem have separately configurable latencies

For now 1 is fine I think.

I've just pushed out a doe-v9 tag and cxl-2022-10-14 branch to 
gitlab.com/jic23/qemu  Also advanced the base tree to current QEMU mainline.

Note that if anyone is playing with the switch cci device and mainline kernel
you'll currently need to revert
https://lore.kernel.org/linux-pci/20220905080232.36087-5-mika.westerberg@linux.intel.com/

Jonathan

