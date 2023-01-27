Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1174C38142
	for <linux-cxl@archiver.kernel.org>; Fri, 27 Jan 2023 10:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjA0KBy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 05:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjA0KBx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 05:01:53 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A727995
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 02:01:52 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P3Ch11Jfxz67kTG;
        Fri, 27 Jan 2023 17:58:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:01:49 +0000
Date:   Fri, 27 Jan 2023 10:01:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] hw/pxb-cxl: Support passthrough HDM Decoders unless
 overridden
Message-ID: <20230127100149.0000563e@Huawei.com>
In-Reply-To: <20230126215727.GA203951@bgt-140510-bm03>
References: <20230125152703.9928-1-Jonathan.Cameron@huawei.com>
        <20230125152703.9928-3-Jonathan.Cameron@huawei.com>
        <CGME20230126215736uscas1p2166334bf8185239cf6ac70053dc386c5@uscas1p2.samsung.com>
        <20230126215727.GA203951@bgt-140510-bm03>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 26 Jan 2023 21:57:35 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> On Wed, Jan 25, 2023 at 03:27:03PM +0000, Jonathan Cameron wrote:
> 
> > The CXL r3.0 specification allows for there to be no HDM decoders on CXL
> > Host Bridges if they have only a single root port. Instead, all accesses
> > directed to the host bridge (as specified in CXL Fixed Memory Windows)
> > are assumed to be routed to the single root port.
> > 
> > Linux currently assumes this implementation choice. So to simplify testing,
> > make QEMU emulation also default to no HDM decoders under these particular
> > circumstances, but provide a hdm_for_passthrough boolean option to have
> > HDM decoders as previously.
> > 
> > Technically this is breaking backwards compatibility, but given the only
> > known software stack used with the QEMU emulation is the Linux kernel
> > and this configuration did not work before this change, there are
> > unlikely to be any complaints that it now works. The option is retained
> > to allow testing of software that does allow for these HDM decoders to exist,
> > once someone writes it.
> > 
> > Reported-by: Fan Ni <fan.ni@samsung.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> >      pxb_dev_realize_common(dev, CXL, errp);
> > -    pxb_dev_reset(DEVICE(dev));
> > +    pxb_cxl_dev_reset(DEVICE(dev));
> >  }
> >  
> > +static Property pxb_cxl_dev_properties[] = {
> > +    /* Note: 0 is not a legal PXB bus number. */
> > +    DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
> > +    DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
> > +    DEFINE_PROP_BOOL("bypass_iommu", PXBDev, bypass_iommu, false),
> > +    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBDev, hdm_for_passthrough, false),  
> when setting hdm_for_passthrough to true at the qemu command line, we
> will see the segfault issue as before. I think this is expected as it
> is the logic in cxl_cfmws_find_device. Wondering if there will be
> following fixes to handle the case when hdm_for_passthrough is true.

Absolutely, I'd expect a kernel fix for that case, but it's probably not
high priority for anyone given we don't yet have any hardware that does that
(as far as I know anyway!)

I wanted to keep the control here to make that easy to test when we do
have the fix in place.

Jonathan
