Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCC0C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Dec 2022 15:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiLTPfB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLTPfA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Dec 2022 10:35:00 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3BB489
        for <linux-cxl@vger.kernel.org>; Tue, 20 Dec 2022 07:34:57 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nc0w83lHcz67L21;
        Tue, 20 Dec 2022 23:33:28 +0800 (CST)
Received: from localhost (10.81.208.216) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 15:34:54 +0000
Date:   Tue, 20 Dec 2022 15:34:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <bwidawsk@kernel.org>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20221220153453.00000436@Huawei.com>
In-Reply-To: <Y6CloIiuruB/h7qp@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
        <20221128150157.97724-4-gregory.price@memverge.com>
        <20221219124211.000032b7@Huawei.com>
        <Y6CNcuIzUVmKL0SM@memverge.com>
        <20221219172502.00001338@Huawei.com>
        <Y6CloIiuruB/h7qp@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.216]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 19 Dec 2022 12:55:44 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> > I think an address space needs a memory region, not a memdev.
> > Initialize a container region with memory_region_init()
> > We could then add the two memdev associated regions (with different 
> > attributes) as subregions using memory_region_add_subregion()
> > 
> > Similar is done for the system memory
> > https://elixir.bootlin.com/qemu/latest/source/softmmu/physmem.c#L2675
> > creates it.  Then it's mostly accessed by get_system_memory()
> > 
> > Memory is then added to that at particular base addresses via for example
> > https://elixir.bootlin.com/qemu/latest/source/hw/arm/virt.c#L2210
> > and similar.
> > I think we can do the same here.
> >  
> 
> Ah, I'm just confused then, this seems reasonable
> 
> > Curious question on this lot. How are you testing it?  Some exciting scripts
> > to bring the hdm decoders up etc for the volatile region? Or some prototype
> > driver code?  
> 
> Unfortunately I got pulled off this work for a bit to handle something
> more pressing.  

No problem. It happens to us all!

> I have only tested that the existing functionality
> (persistent mode) works as intended, and that at least the ndctl/cxl
> tools report capacity as expected.
> 
> As of right now there is no code in the driver to actually touch these
> regions in a way that works to be able to online these volatile regions
> - at least so far as I know.
> 
> I don't remember where I left off, but some pmem-to-ram tutorials online
> suggest you could online pmem regions like this
> 
> cxl create-region -d decoder0.0 -m mem0
> echo offline > /sys/devices/system/memory/auto_online_blocks
> ndctl create-namespace -f --mode devdax --continue
> daxctl enable-device [device name]
> daxctl reconfigure-device --mode=system-ram all
> 
> However I don't think this is successful in creating the dax devices,
> and therefore the reconfiguring into ram.

Sure. I only bothered testing the it in some dax modes rather than via kmem.
It 'should' work but more testing needed there.

However as you've noted, that only applies to the pmem regions at the moment.
I wondered if you'd scripted the HDM decoder setup etc for test purposes
(so what the driver will do). Alternative to that would be enabling the driver
support. Not sure if anyone is looking at that yet. Final alternative would
be to port the existing EDK2 based support to work on QEMU.  All non trivial
jobs so may take a while,

Jonathan
