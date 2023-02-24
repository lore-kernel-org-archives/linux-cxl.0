Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D89C61DA3
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 12:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBXMB7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 07:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXMB6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 07:01:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DAF64D54
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 04:01:55 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PNSzz42pWz6J7Ys;
        Fri, 24 Feb 2023 19:57:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 24 Feb
 2023 12:01:52 +0000
Date:   Fri, 24 Feb 2023 12:01:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH 2/2] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20230224120151.00007b79@Huawei.com>
In-Reply-To: <20230224002940.GA1282789@bgt-140510-bm03>
References: <20230131163847.23025-1-Jonathan.Cameron@huawei.com>
        <20230131163847.23025-3-Jonathan.Cameron@huawei.com>
        <20230217161617.000064d1@huawei.com>
        <Y+9gSWadbRfdqJGS@memverge.com>
        <20230220114646.000000ff@Huawei.com>
        <CGME20230224002948uscas1p220ab1ec9fbe16138e0fd314b7412f833@uscas1p2.samsung.com>
        <20230224002940.GA1282789@bgt-140510-bm03>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 24 Feb 2023 00:29:47 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> On Mon, Feb 20, 2023 at 11:46:46AM +0000, Jonathan Cameron wrote:
> 
> > On Fri, 17 Feb 2023 06:08:57 -0500
> > Gregory Price <gregory.price@memverge.com> wrote:
> >   
> > > On Fri, Feb 17, 2023 at 04:16:17PM +0000, Jonathan Cameron via wrote:  
> > > > On Tue, 31 Jan 2023 16:38:47 +0000
> > > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > > >     
> > > > > From: Gregory Price <gourry.memverge@gmail.com>
> > > > > 
> > > > > This commit enables each CXL Type-3 device to contain one volatile
> > > > > memory region and one persistent region.
> > > > > 
> > > > > Two new properties have been added to cxl-type3 device initialization:
> > > > >     [volatile-memdev] and [persistent-memdev]
> > > > > 
> > > > > The existing [memdev] property has been deprecated and will default the
> > > > > memory region to a persistent memory region (although a user may assign
> > > > > the region to a ram or file backed region). It cannot be used in
> > > > > combination with the new [persistent-memdev] property.
> > > > > 
> > > > > Partitioning volatile memory from persistent memory is not yet supported.
> > > > > 
> > > > > Volatile memory is mapped at DPA(0x0), while Persistent memory is mapped
> > > > > at DPA(vmem->size), per CXL Spec 8.2.9.8.2.0 - Get Partition Info.
> > > > > 
> > > > > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >     
> > > > Hi Gregory,
> > > > 
> > > > I've added support for multiple HDM decoders and hence can now
> > > > test both volatile and non volatile on same device.
> > > > It very nearly all works. With one exception which is I couldn't
> > > > poke the first byte of the non volatile region.
> > > > 
> > > > I think we have an off by one in a single check.
> > > > 
> > > > Interestingly it makes no difference when creating an FS on top
> > > > (which was my standard test) so I only noticed when poking memory
> > > > addresses directly to sanity check the HDM decoder setup.
> > > > 
> > > > I'll roll a v2 if no one shouts out that I'm wrong.
> > > > 
> > > > Note that adding multiple HDM decoders massively increases
> > > > the number of test cases over what we had before to poke all the
> > > > corners so I may well be missing stuff.  Hopefully can send an RFC
> > > > of that support out next week.
> > > > 
> > > > Jonathan
> > > >     
> > > 
> > > Very cool! Thanks for pushing this over the finishing line.
> > > 
> > > All my testing so far has been really smooth since getting the TCG issue
> > > worked out.
> > >   
> > > > > -MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> > > > > -                           unsigned size, MemTxAttrs attrs)    
> > > [...]  
> > > > > +    if (vmr) {
> > > > > +        if (*dpa_offset <= int128_get64(vmr->size)) {    
> > > > 
> > > > Off by one I think.  < 
> > > >     
> > > 
> > > Yes that makes sense, should be <.  Derp derp.
> > > 
> > > Though I think this may alludes to more off-by-one issues?  This says
> > > 
> > > if (dpa_offset < vmr->size)
> > > 
> > > but dpa_offset should be (hpa - memory_region_base),
> > > 
> > > The HPA is used by memory access routing for the whole system to determine
> > > what device it should access.
> > > 
> > > If that corner case is being hit, doesn't it imply the higher level code
> > > is also susceptible to this, and is routing accesses to the wrong device?  
> > 
> > I don't think so though I may be missing something. 
> > 
> > Say vmr->size = 8
> > 
> > hpa  dpa_offset
> > 0       0
> > 1       1
> > 2       2
> > 3       3
> > 4       4
> > 5       5
> > 6       6
> > 7       7
> > 8       0
> > 
> > etc  
> 
> If vmr->size=8, we should expect that at most 8 offsets (e.g., hpa [0,7]) will
> access vmem and hpa=8 will access offset=0 at pmem, right?
> If with hpa=8, dpa_offset round to 0, does it mean we never get a
> dpa_offset larger than 7? If so, when pmem will be accessed?

Ah. I didn't mention that when HPA == 8 in this example the dpa_offset is
now used to access pmem until we reach vmr->size + persistent_mr->size at
which point it is off the end and it's routed no where at all.

Table is too simplisitic!

> 
> > 
> > Also the writes are turning up where I expect them to.
> > 
> > Also just noticed that the code is setting Memory_base in the CXL dvsec.
> > Given we are emulating a device as if it has been freshly powered up
> > those should not be set - it's the OS or firmware's job to set them up.
> > Harmless though, so can be a cleanup to follow the main series.
> > 
> > We don't currently handle dvsec range based routing anyway and
> > I'm not sure we ever will as it is a pain to test without some firmware
> > or OS code to program them for us.
> > 
> > Note that if you update your kernel to cxl/next it will currently fail
> > as the Range register emulation is (I think) rather over enthusiastic
> > and currently decides to emulate the HDM decoders for the QEMU emulated
> > type 3 devices.
> > 
> > https://lore.kernel.org/linux-cxl/167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com/T/#m6c025d5c9b27d8360a64079593f6c5adaa408772
> > 
> > Jonathan
> > 
> >   
> > > 
> > > ~Gregory  
> > 
> >  

