Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1A1EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 09:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjFVJxp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 05:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjFVJxa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 05:53:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2441D30C8
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 02:48:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QmwWk6DP2z6J748;
        Thu, 22 Jun 2023 17:47:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 10:48:21 +0100
Date:   Thu, 22 Jun 2023 10:48:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [BUG] Root port fails to match with port driver on non-RCH
 topology
Message-ID: <20230622104820.00005249@Huawei.com>
In-Reply-To: <ZIuUL/hKp+RdhTna@memverge.com>
References: <ZIs5Ra+9SGGbUZoZ@memverge.com>
        <ZItcdaq3j8kW+/Sy@memverge.com>
        <ZItdoWTyOS5YSPzz@memverge.com>
        <ZIuUL/hKp+RdhTna@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 15 Jun 2023 18:43:59 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Jun 15, 2023 at 02:51:13PM -0400, Gregory Price wrote:
> > On Thu, Jun 15, 2023 at 02:46:13PM -0400, Gregory Price wrote:  
> > > On Thu, Jun 15, 2023 at 12:16:05PM -0400, Gregory Price wrote:
> > > follow up with more context, there is a subsequent error on
> > > cxl_port_probe which causes dev->driver to remain NULL.
> > > 
> > > 
> > > [   15.561313] cxl_mem mem0: CXL port topology root0 not enabled
> > > [   15.561315] cxl_mem mem0: call_driver_probe failed  
> > 
> > wrong prints here, this should have read:
> > 
> > [   15.549316] cxl root0: driver set to cxl_port
> > [   15.549732] cxl_port root0: call_driver_probe failed
> > 
> > I confirmed that call_driver_probe sinks down to a call to
> > cxl_port_probe and that is failing on cxl_port_probe(root0).
> > 
> > Rest of the commentary below is accurate.
> >   
> 
> 
> so cxl_switch_port_probe fails on this stack:
> 
> - cxl_switch_port_probe
>   - devm_cxl_port_enumerate_dports
>     - cxl_port_to_pci_bus
> 
> int devm_cxl_port_enumerate_dports(struct cxl_port *port)
> {
>         struct pci_bus *bus = cxl_port_to_pci_bus(port);
>         struct cxl_walk_context ctx;
>         int type;
> 
>         if (!bus)
>                 return -ENXIO;
> ...
> }
> 
> struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port)
> {
>     /* There is no pci_bus associated with a CXL platform-root port */
>     if (is_cxl_root(port))
>         return NULL;
> ...
> }
> 
> 
> I presume then that for the root port, we should just return 0 to note
> success?  The rest of the devices should register themselves correctly
> with the root as they're iterated over - i think?
> 
> What I can't figure out is why this doesn't happen on QEMU, which also
> presents a similar topology.
> 
> Still not sure what is correct vs incorrect here, will need to dig
> around in the spec and system settings unless someone has an idea.

Interestingly on QEMU we never get near the path that's failing on root0
as no driver is associated with that particular device.  There are plenty of
child devices with drivers though - just not the top level one.
I wonder if a rescan or something similar is causing the probe on your
system but not qemu?

Dan, should we be seeing a driver binding to root0 or not?

Jonathan



 

> 
> ~Gregory

