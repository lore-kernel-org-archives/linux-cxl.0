Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2057C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 16:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJJQ0p (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiJJQ0U (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 12:26:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4761112
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 09:26:15 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmPQ12wdgz67H19;
        Tue, 11 Oct 2022 00:24:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 18:26:12 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 17:26:12 +0100
Date:   Mon, 10 Oct 2022 17:26:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <20221010172611.00007f61@huawei.com>
In-Reply-To: <Y0Q4JWa6hddtHIcO@memverge.com>
References: <20221006000103.49542-1-gregory.price@memverge.com>
        <20221006094557.000035ab@huawei.com>
        <20221006095007.00001271@huawei.com>
        <Yz75ppPOwYCvNamy@fedora>
        <20221006174214.000059c7@huawei.com>
        <Yz8QlQ9yLFrWxWsN@fedora>
        <20221010154343.00007afd@huawei.com>
        <Y0Q4JWa6hddtHIcO@memverge.com>
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

On Mon, 10 Oct 2022 11:20:05 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> > > 
> > > Maybe we should consider 2 new options:
> > > --persistent-memdevs=pm1 pm2 pm3
> > > --volatile-memdevs=vm1 vm2 vm3
> > > 
> > > etc, and deprecate --memdev, and go with your array of memdevs idea.
> > > 
> > > I think I could probably whip that up in a day or two.  Thoughts?  
> > 
> > I wonder if we care to emulate beyond 1 volatile and 1 persistent.
> > Sure devices might exist, but if we can exercise all the code paths
> > with a simpler configuration, perhaps we don't need to handle the
> > more complex ones?
> > 
> > The sticky corner here is Set Partition Info 
> > CXL r3.0 8.2.9.8.2.1
> > 
> > Separation between volatile and non volatile is configurable at runtime.
> >   
> 
> Set Partition Info (Opcode 4101h)
> ... snip ... Paritionable capacity is equal to
> (total capacity - (volatile-only) - (persistent-only))
> 
> By definition, volatile backed memory can only contain volatile regions.
> That's simple.

I guess that's a reasonable model for the QEMU command line.

> 
> For persistent-backed memory, capacity can be chopped up (iif Identify
> Memory Device reports Paritition Alignment to be non-zero).
> 
> --persistent-memdev=pmem-backing
> --volatile-memdev=vmem-backing
> 
> By default, maybe we should make the entire size of persistent regions
> to be persistent-only for the initial prototype. 

Agreed.  Partitioning wasn't high on my todo list though maybe it is
for others...


> This would let us
> merge without support for Set Partition Info.  Then add an additional
> argument to enable additional argument to set the partition alignment.
> 
> --partitionable-pmem=
>   : Defaults to 0. If non-zero, up to N XBytes of PMem may be
>     used as vmem by the operating system at runtime.
> 
> On the CXL tool side we should then see the following output for these
> settings:
> 
> --persistent-memdev=pmem0     1GB
> --volatile-memdev=vmem0       1GB
> --partitionable-pmem=512M
> 
> Capacities:
> ----------------
> Total Capacity: 2GB
> Volatile Capacity: 1GB
> Persistent Capacity: 1GB
> Partitionable Capacity: 512MB
> Partitioned Memory: 0MB
> 
> Available Memory:
> -----------------
> Volatile Memory: 1GB
> Persistent Memory: 1GB
> 
> 
> Then Run something along the lines of:
> `cxl partition-pmem 512MB`   (or whatever args are needed)
> 
> 
> Capacities:
> ----------------
> Total Capacity: 2GB
> Volatile Capacity: 1GB
> Persistent Capacity: 1GB
> Partitionable Capacity: 512MB
> Partitioned Memory: 512MB
> 
> Available Memory:
> -----------------
> Volatile Memory: 1.5GB
> Persistent Memory: 512MB
> 
> 
> Thoughts?

Looks good to me.  Alison, I think you were looking at the partitioning stuff...
What do you think of this?

Jonathan


