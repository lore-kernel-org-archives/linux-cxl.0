Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDF8C3DA7D
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjACP4n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 10:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjACP4e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 10:56:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CED386
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 07:56:33 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nmcft1qjwz6HJZv;
        Tue,  3 Jan 2023 23:51:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 15:56:30 +0000
Date:   Tue, 3 Jan 2023 15:56:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <bwidawsk@kernel.org>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20230103155629.00007466@Huawei.com>
In-Reply-To: <Y6IMoxKZOc7eUPCg@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
        <20221128150157.97724-4-gregory.price@memverge.com>
        <20221219124211.000032b7@Huawei.com>
        <Y6CNcuIzUVmKL0SM@memverge.com>
        <20221219172502.00001338@Huawei.com>
        <Y6CloIiuruB/h7qp@memverge.com>
        <20221220153453.00000436@Huawei.com>
        <Y6IMoxKZOc7eUPCg@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 20 Dec 2022 14:27:31 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Tue, Dec 20, 2022 at 03:34:53PM +0000, Jonathan Cameron wrote:
> > > However I don't think this is successful in creating the dax devices,
> > > and therefore the reconfiguring into ram.  
> > 
> > Sure. I only bothered testing the it in some dax modes rather than via kmem.
> > It 'should' work but more testing needed there.
> > 
> > However as you've noted, that only applies to the pmem regions at the moment.
> > I wondered if you'd scripted the HDM decoder setup etc for test purposes
> > (so what the driver will do). Alternative to that would be enabling the driver
> > support. Not sure if anyone is looking at that yet. Final alternative would
> > be to port the existing EDK2 based support to work on QEMU.  All non trivial
> > jobs so may take a while,
> > 
> > Jonathan  
> 
> Also, I'm relatively new to this corner of the kernel (mm, regions, dax,
> etc), so i need to spend a week or two with uninterrupted tinkering with
> how adding new memory regions from these devices is actually "supposed
> to work" in a dynamic-capacity world.
> 
> At least in theory, the partitioning of persistent and volatile memory
> regions on one of these type-3 devices should end up looking a bit like
> dynamic capacity when doing runtime reconfiguring.
> 
> For example, considering
> 
> Device(512mb PMEM, 512 VMEM), I'd want, at least i think
> 
> CMFW-Volatile:    max window size(1024mb) - Numa 2
> CMFW-Persistent:  max window size(512mb)  - Numa 3
> 
> Then we'd need the kernel support for
> 
> 1) Online 2x256mb volatile regions in Numa 2
> 2) Online 2x256mb persistent regions in Numa 3
> 3) Offline persistent region (256mb:512mb)
> 4) Reconfigure device to 256Pmem/768Volatile
>    a) change decoders in device accordingly
> 5) Online 1x256mb volatile region in Numa 2
> 
> The question is whether you can do this without offlining the other
> adjacent regions.  I just don't know enough about the region subsystem
> to say what is "correct" behavior here.

Whilst you probably 'can' do fine grained offline / online (to some
degree anyway) I'm not sure if people consider it an important
usecase. If decoder reprogramming is involved things will get very fiddly
so at least in first instance I'd advocate just ripping it all down and
building up again.  Or in the simple case, just block attempts to reconfigure
at the partitioning if either side is in use.

> 
> On the device side, I need to go look at the mailbox commands to go
> about implementing the reconfiguration / decoder reprogramming.
> 
> I guess the "decoder" reprogramming is essentially changing the
> read/write commands to adjust based on v/pmem_active vs v/pmem_size?

Yup.  We also need multiple decoder support in general in QEMU.
It's not that high on my list as my main focus this cycle is going
to be on reducing the out of tree patch set by upstreaming stuff.

> 
> I suppose I can look at this chunk next.

Great.

Jonathan


