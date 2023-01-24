Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37CC38142
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 09:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjAXJrg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjAXJrf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 04:47:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EFA3EC64
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 01:47:23 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1MTx4rDXz6J7B6;
        Tue, 24 Jan 2023 17:43:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 09:47:21 +0000
Date:   Tue, 24 Jan 2023 09:47:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [RFC PATCH 0/2] hw/cxl: Passthrough HDM decoder emulation
Message-ID: <20230124094720.00005c97@Huawei.com>
In-Reply-To: <20230123175315.GA168673@bgt-140510-bm03>
References: <20230123121712.29892-1-Jonathan.Cameron@huawei.com>
        <CGME20230123175325uscas1p134d834ae3636c7c56e93299c01a4f351@uscas1p1.samsung.com>
        <20230123175315.GA168673@bgt-140510-bm03>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 23 Jan 2023 17:53:24 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> On Mon, Jan 23, 2023 at 12:17:10PM +0000, Jonathan Cameron wrote:
> 
> 
> 
> > Until now, testing using CXL has relied up always using two root ports
> > below a host bridge, to work around a current assumption in the Linux
> > kernel support that, in the single root port case, the implementation will
> > use the allowed passthrough decoder implementation choice. If that choice
> > is made all accesses are routed from the host bridge to the single
> > root port that is present. Effectively we have a pass through decoder
> > (it is called that in the kernel driver).
> > 
> > This patch series implements that functionality and makes it the default
> > See patch 2 for a discussion of why I think we can make this change
> > without backwards compatibility issues (basically if it didn't work before
> > who are we breaking by making it work?)
> > 
> > Whilst this limitation has been known since the initial QEMU patch
> > postings / kernel CXL region support, Fan Ni Ran into it recently reminding
> > me that we should solve it.
> > 
> > https://lore.kernel.org/linux-cxl/20230113171044.GA24788@bgt-140510-bm03/
> > 
> > Tree with a large set of patches before this at:
> > https://gitlab.com/jic23/qemu/-/tree/cxl-2023-01-20
> > 
> > I've done some basic testing, though I did hit what appears to be
> > a kernel race on region bring up of existing region / namespace in a
> > 1HB 2RP 2EP test case. That is proving hard to replicate consistently
> > but doesn't seem to have anything to do with the emulation other than
> > perhaps we are opening up a race by responding slowly to something.
> > 
> > Jonathan Cameron (2):
> >   hw/pci: Add pcie_count_ds_port() and pcie_find_port_first() helpers
> >   hw/pxb-cxl: Support passthrough HDM Decoders unless overridden
> > 
> >  hw/cxl/cxl-host.c                   | 31 +++++++++++++--------
> >  hw/pci-bridge/pci_expander_bridge.c | 43 +++++++++++++++++++++++++----
> >  hw/pci/pcie_port.c                  | 38 +++++++++++++++++++++++++
> >  include/hw/cxl/cxl.h                |  1 +
> >  include/hw/cxl/cxl_component.h      |  1 +
> >  include/hw/pci/pci_bridge.h         |  1 +
> >  include/hw/pci/pcie_port.h          |  2 ++
> >  7 files changed, 100 insertions(+), 17 deletions(-)
> > 
> > -- 
> > 2.37.2
> > 
> >   
> Tried three different cxl topology setups (1HB1RP, 1HB2RP2Memdev, with
> switch), the patch works fine for me.
> Btw, there seem some format issues with the patch, got warnings with
> checkpatch tool.
Thanks! I'll clean those up.  Was being lazy on it as it's an RFC for
now :)  Given this is small and useful I'll probably pull it nearer the
head of the queue.

When I repost, if you could give a Tested-by tag that would be great!

Thanks,

Jonathan

