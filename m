Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FF2C77B60
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 14:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDWO6L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDWO6L (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 10:58:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CCFE5E
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 07:58:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4B8R0vl8z67ftk;
        Sun, 23 Apr 2023 22:53:11 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 15:58:04 +0100
Date:   Sun, 23 Apr 2023 15:58:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Lukas Wunner <lukas@wunner.de>, <linux-cxl@vger.kernel.org>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
Message-ID: <20230423155803.00001807@huawei.com>
In-Reply-To: <644449f43a352_1b662947a@dwillia2-xfh.jf.intel.com.notmuch>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
        <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
        <20230422083502.GA31480@wunner.de>
        <644449f43a352_1b662947a@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 22 Apr 2023 13:56:20 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Lukas Wunner wrote:
> > On Fri, Apr 21, 2023 at 07:51:47PM -0700, Dan Williams wrote:  
> > > Not all CXL ports are associated with PCI devices. Host-bridge and
> > > cxl_test ports are hosted by platform devices. Teach read_cdat_data() to
> > > be careful about non-pci hosted cxl_memdev instances. Otherwise,
> > > cxl_test crashes with this signature:
> > > 
> > >  RIP: 0010:xas_start+0x6d/0x290
> > >  [..]
> > >  Call Trace:
> > >   <TASK>
> > >   xas_load+0xa/0x50
> > >   xas_find+0x25b/0x2f0
> > >   xa_find+0x118/0x1d0
> > >   pci_find_doe_mailbox+0x51/0xc0
> > >   read_cdat_data+0x45/0x190 [cxl_core]
> > >   cxl_port_probe+0x10a/0x1e0 [cxl_port]
> > >   cxl_bus_probe+0x17/0x50 [cxl_core]
> > > 
> > > Some other cleanups are included like removing the single-use @uport
> > > variable, and removing the indirection through 'struct cxl_dev_state' to
> > > lookup the device that registered the memdev and may be a pci device.
> > > 
> > > Fixes: af0a6c3587dc ("cxl/pci: Use CDAT DOE mailbox created by PCI core")
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > 
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > 
> > Take my Reviewed-by with a grain of salt as I'm absolutely not an
> > expert on the cxl struct hierarchy, nevertheless this looks sane to me.  
> 
> Yeah, I think we need a data structure relationship diagram to explain
> endpoint devices, memory devices, endpoint ports, and switch ports all
> interconnect.

Agreed. I keep forgetting how this all works as well and end up scattering
prints everywhere to find out.

A diagram to refer to would be very useful.

Jonathan

> 
> > I note however that before af0a6c3587dc, xa_for_each() was run on an
> > xarray which was not initialized with xa_init() on non-pci cxl ports.
> > (xa_init() was run from cxl_pci_probe() -> devm_cxl_pci_create_doe()
> > but xa_for_each() was run from read_cdat_data() -> find_cdat_doe()
> > for non-pci cxl ports as well.)
> > 
> > Hence can't this crash prior to af0a6c3587dc as well?  If it can,
> > the Fixes tag would rather have to point to c97006046c79 ("cxl/port:
> > Read CDAT table"), though this patch wouldn't apply cleanly to
> > pre-6.4 kernels.  c97006046c79 went into v6.0 and there's one stable
> > kernel between it and v6.4 (for which af0a6c3587dc is queued).
> > So if the missing xa_init() can indeed cause crashes, you may want to
> > base your fix on v6.3 and fold it in at the front of cxl/next,
> > then rebase af0a6c3587dc on top of it.  Let me know if you need help
> > or want me to look into it.  
> 
> As I replied on the other note, I think older kernels are ok.
> 
> > Thanks for fixing this and sorry for not spotting it myself!  
> 
> No worries, I had missed that the unit test were not run yet.

