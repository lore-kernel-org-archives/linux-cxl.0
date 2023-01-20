Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87C8C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 20 Jan 2023 10:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjATKrY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 Jan 2023 05:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjATKrX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 Jan 2023 05:47:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CEEB27A8
        for <linux-cxl@vger.kernel.org>; Fri, 20 Jan 2023 02:47:14 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nyx0x24CYz6J7CS;
        Fri, 20 Jan 2023 18:43:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 10:47:11 +0000
Date:   Fri, 20 Jan 2023 10:47:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: cxl nvdimm Potential probe ordering issues.
Message-ID: <20230120104709.00000572@Huawei.com>
In-Reply-To: <Y8oeYfyqNuSIIxCt@memverge.com>
References: <Y8CNw/fZT5fZJZcK@memverge.com>
        <20230113091213.00002146@Huawei.com>
        <Y8Foj/12QNl0C96o@memverge.com>
        <20230113144026.000001fb@Huawei.com>
        <20230113144511.00001207@Huawei.com>
        <20230113151206.GA20583@wunner.de>
        <Y8hG4OyJL7l9oD2f@memverge.com>
        <Y8hJKcy1993SFLLJ@memverge.com>
        <20230119124244.000015b3@Huawei.com>
        <20230119150449.000037f2@huawei.com>
        <Y8oeYfyqNuSIIxCt@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 19 Jan 2023 23:53:53 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Jan 19, 2023 at 03:04:49PM +0000, Jonathan Cameron wrote:
> > Gregory, would you mind checking if
> > cxl_nvb is NULL here...
> > https://elixir.bootlin.com/linux/v6.2-rc4/source/drivers/cxl/pmem.c#L67
> > (printk before it is used should work).
> > 
> > Might also be worth checking cxl_nvd and cxl_ds
> > but my guess is cxl_nvb is our problem (it is when I deliberate change
> > the load order).
> > 
> > Jonathan
> >   
> 
> This is exactly the issue.  cxl_nvb is null, the rest appear fine.
> 
> Also, note, that weirdly the non-volatile bridge shows up when launching
> this in volatile mode, but no stack trace appears.
> 
> ¯\_(ツ)_/¯
> 
> After spending way too much time tracing through the current cxl driver
> code, i have only really determined that
> 
> 1) The code is very pmem oriented, and it's unclear to me how the driver
>    as-is differentiates a persistent device from a volatile device. That
> 	 code path still completely escapes me.  The only differentiating code
> 	 i see is in the memdev probe path that creates mem#/pmem and mem#/ram

Absolutely on pmem.  Target for kernel side of things was always pmem
first. Volatile has been on roadmap / todo list for a few kernel cycles
but I haven't seen any code yet.

> 
> 2) The code successfully manages probe, enable, and mount a REAL device
>    - cxl memdev appears (/sys/bus/cxl/devices/mem0)
> 	 - a dax device appears (/sys/bus/dax/devices/)
> 	   This happens at boot, which I assume must be bios related
> 	 - The memory *does not* auto-online, instead the dax device can be
> 	   onlined as system-ram *manually* via ndctl and friends

Interesting.  Just curious, is the host a CXL 1.1 host or a CXL 2.0 host?

> 
> 3) The code creates an nvdimm_bridge IFF a CFMW is defined - regardless
>    of the type-3 device configuration (pmem-only or vmem-only)
> 
>    # CFMW defined
>    [root@fedora ~]# ls /sys/bus/cxl/devices/
>    decoder0.0  decoder2.0  mem0            port1
>    decoder1.0  endpoint2   nvdimm-bridge0  root0
> 
>    # CFMW not defined
> 	 [root@fedora ~]# ls /sys/bus/cxl/devices/
>    decoder1.0  decoder2.0  endpoint2  mem0  port1  root0

That should be harmless and may be needed to tie everything
through to DAX.


> 
> 4) As you can see above, multiple decoders are registered.  I'm not sure
>    if that's correct or not, but it does seem odd given there's only one
> 	 cxl type-3 device.  Odd that decoder0.0 shows up when CFMW is there,
> 	 but not when it isn't.
> 
> 	 Note: All these tests have two root ports:
> 	 -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
>    -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
>    -device cxl-rp,id=rp1,bus=cxl.0,chassis=0,port=1,slot=1 \

IIRC

decoder0.0 represents the fixed routing in the host as defined
by the CFMWS - not an actual programmable decoder.

decoder1.0 is the routing in the host bridge - may be pass through
decoder if there is only one root port.

decoder2.0 is the one is the endpoint itself.

> 
> 
> Don't know why I haven't thought of this until now, but is the CFMW code
> reporting something odd about what's behind it?  Is it assuming the
> devices are pmem?

It reports the ability to support pmem or support volatile or support both.
Currently
https://elixir.bootlin.com/qemu/latest/source/hw/acpi/cxl.c#L107
qemu reports that all CFMWS windows support everything except
"Fixed Device Configuration (Bit[4])" which would tell the OS not
to move devices that are already programmed out of this window
and doesn't really make sense for QEMU to ever set.
That is we support all of:
Device Coherent (type 2 and back invalidate flows on type 3, though we
aren't emulating the back invalidate stuff yet on the EP)
Host only coherent. [thinking about it we should probably not
support both this and device coherent as they would be mutually
incompatible on a real host]
Volatile
Persistent

Jonathan


