Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A3FC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Apr 2022 18:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbiDZSJ3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Apr 2022 14:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241942AbiDZSJ3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Apr 2022 14:09:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6806F62121
        for <linux-cxl@vger.kernel.org>; Tue, 26 Apr 2022 11:06:20 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KnqTj477dz67jy7;
        Wed, 27 Apr 2022 02:02:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 20:06:18 +0200
Received: from localhost (10.81.205.200) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 19:06:17 +0100
Date:   Tue, 26 Apr 2022 19:06:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: CXL type 3 which doesn't have cxl mem enabled.
Message-ID: <20220426190615.000063ed@Huawei.com>
In-Reply-To: <CAPcyv4i+=ArjE7uH_jKGS+B9-dLJ3An_T+NgWB2xqC-7Zh-VYA@mail.gmail.com>
References: <20220426180832.00005f0b@Huawei.com>
        <CAPcyv4i+=ArjE7uH_jKGS+B9-dLJ3An_T+NgWB2xqC-7Zh-VYA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.200]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 26 Apr 2022 10:19:55 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Apr 26, 2022 at 10:09 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Hi All,
> >
> > I ran into this whilst debugging why on the current QEMU code
> > we now get a probe failure for CXL mem due to the range 1 size being
> > non 0.
> >
> > The conditions for whether we have legacy ranges programmed don't
> > take into account if Mem_Enable = 1.  That is if the
> > DVSEC CXL Control Mem_Enable bit is set on the type 3 device.
> > If it's not then there is no existing user of the CXL memory
> > setup by firmware or similar so we can switch over to HDM
> > decoders and it doesn't matter what is in the range registers.
> >
> > Unfortunately the QEMU code was bringing the device up with
> > Mem_Enabled already set.  So I fixed that.  After all default
> > value of that bit should be 0.
> >
> > A few problems then showed up.
> >
> > 1. Nothing in the Linux code actually sets Mem_Enabled to 1.  

Sorry - my mistake, that should be Mem_Enable. Though that doesn't
actually clarify things much...

> 
> That's because the device is supposed to, I though, set it of its own
> accord as a result of link training. It's an RO field in the spec, so
> Linux can't set it:
> 
> 8.2.1.3.3 DVSEC Flex Bus Port Status (Offset 0Eh)
> "Mem_Enabled: When set, indicates that CXL.mem protocol operation has
> been enabled as a result of PCIe alternate protocol negotiation for
> Flex Bus."

Agreed with that statement.

Ah. Nothing like confusing register field names that are very similar....
A Mem_Enable is in DVSEC for CXL Device 8.1.3.2 and is RWL.
Just for giggles there is also a Mem_Enable in the Flex Bus Port Control
but the range registers comment isn't about that one (I hope anyway!).

The kernel currently sets the value of info->mem_enabled using
the Mem_Enable field of the DVSEC for CXL Device.
https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/pci.c#L501

So I think wrong name and wrong DVSEC for that particular condition.

Jonathan


> 
> > 2. Probing fails in mem.c as wait_for_media() checks for
> >    info->mem_enabled (cached value of this bit).
> >
> > So, dirty hack was to
> > * drop that check in wait_for_media() as media being enabled doesn't
> >   have much to do with CXL.mem protocol being enabled.  
> 
> Per above I think it does.
> 
> > * Make the check in cxl_hdm_decode_init()
> >    if (info->mem_enabled && !global_enable && info->ranges)
> > * Immediately after enabling the hdm decoder global enable,
> >   also set the Mem_Enable bit also update info->mem_enabled.
> >
> > This seems to work, but I can't help thinking I'm missing something.  
> 
> I think QEMU should just unconditionally init that value to 1.

