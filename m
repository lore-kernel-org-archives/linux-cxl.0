Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F1C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 14:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiA1OXD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 09:23:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4546 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349112AbiA1OXC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 09:23:02 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jlfmp1LHxz67bjw;
        Fri, 28 Jan 2022 22:22:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 15:23:00 +0100
Received: from localhost (10.47.76.156) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 14:22:59 +0000
Date:   Fri, 28 Jan 2022 14:22:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 02/42] hw/cxl/component: Introduce CXL components
 (8.1.x, 8.2.5)
Message-ID: <20220128142251.0000437f@Huawei.com>
In-Reply-To: <87bkzyd3c7.fsf@linaro.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
        <20220124171705.10432-3-Jonathan.Cameron@huawei.com>
        <87bkzyd3c7.fsf@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.76.156]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 26 Jan 2022 12:32:01 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > A CXL 2.0 component is any entity in the CXL topology. All components
> > have a analogous function in PCIe. Except for the CXL host bridge, all
> > have a PCIe config space that is accessible via the common PCIe
> > mechanisms. CXL components are enumerated via DVSEC fields in the
> > extended PCIe header space. CXL components will minimally implement some
> > subset of CXL.mem and CXL.cache registers defined in 8.2.5 of the CXL
> > 2.0 specification. Two headers and a utility library are introduced to
> > support the minimum functionality needed to enumerate components.
> >
> > The cxl_pci header manages bits associated with PCI, specifically the
> > DVSEC and related fields. The cxl_component.h variant has data
> > structures and APIs that are useful for drivers implementing any of the
> > CXL 2.0 components. The library takes care of making use of the DVSEC
> > bits and the CXL.[mem|cache] registers. Per spec, the registers are
> > little endian.
> >
> > None of the mechanisms required to enumerate a CXL capable hostbridge
> > are introduced at this point.
> >
> > Note that the CXL.mem and CXL.cache registers used are always 4B wide.
> > It's possible in the future that this constraint will not hold.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/Kconfig                     |   1 +
> >  hw/cxl/Kconfig                 |   3 +
> >  hw/cxl/cxl-component-utils.c   | 212 +++++++++++++++++++++++++++++++++
> >  hw/cxl/meson.build             |   3 +
> >  hw/meson.build                 |   1 +
> >  include/hw/cxl/cxl.h           |  16 +++
> >  include/hw/cxl/cxl_component.h | 196 ++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_pci.h       | 138 +++++++++++++++++++++
> >  8 files changed, 570 insertions(+)
> >
> > diff --git a/hw/Kconfig b/hw/Kconfig
> > index ad20cce0a9..50e0952889 100644
> > --- a/hw/Kconfig
> > +++ b/hw/Kconfig
> > @@ -6,6 +6,7 @@ source audio/Kconfig
> >  source block/Kconfig
> >  source char/Kconfig
> >  source core/Kconfig
> > +source cxl/Kconfig
> >  source display/Kconfig
> >  source dma/Kconfig
> >  source gpio/Kconfig
> > diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
> > new file mode 100644
> > index 0000000000..8e67519b16
> > --- /dev/null
> > +++ b/hw/cxl/Kconfig
> > @@ -0,0 +1,3 @@
> > +config CXL
> > +    bool
> > +    default y if PCI_EXPRESS
> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > new file mode 100644
> > index 0000000000..5007b29ebb
> > --- /dev/null
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -0,0 +1,212 @@
> > +/*
> > + * CXL Utility library for components
> > + *
> > + * Copyright(C) 2020 Intel Corporation.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "hw/pci/pci.h"
> > +#include "hw/cxl/cxl.h"
> > +
> > +static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
> > +                                       unsigned size)
> > +{
> > +    CXLComponentState *cxl_cstate = opaque;
> > +    ComponentRegisters *cregs = &cxl_cstate->crb;
> > +
> > +    assert(size == 4);  
> 
> You assert here but bellow:
> 
> > +
> > +/*
> > + * 8.2.3
> > + *   The access restrictions specified in Section 8.2.2 also apply to CXL 2.0
> > + *   Component Registers.
> > + *
> > + * 8.2.2
> > + *   • A 32 bit register shall be accessed as a 4 Bytes quantity. Partial
> > + *   reads are not permitted.
> > + *   • A 64 bit register shall be accessed as a 8 Bytes quantity. Partial
> > + *   reads are not permitted.
> > + *
> > + * As of the spec defined today, only 4 byte registers exist.
> > + */
> > +static const MemoryRegionOps cache_mem_ops = {
> > +    .read = cxl_cache_mem_read_reg,
> > +    .write = cxl_cache_mem_write_reg,
> > +    .endianness = DEVICE_LITTLE_ENDIAN,
> > +    .valid = {
> > +        .min_access_size = 4,
> > +        .max_access_size = 8,
> > +        .unaligned = false,
> > +    },
> > +    .impl = {
> > +        .min_access_size = 4,
> > +        .max_access_size = 4,
> > +    },
> > +};  
> 
> You have constrained the access to 4 so you will only see 4 bytes
> accesses. If it is valid for the guest to access 64bit words then it
> would be better to no-op that case and maybe LOG_UNIMP the fact.
> 

Ugh. This looks suspiciously like a work around for a kernel bug (possibly
an accidental one).

If the comment above is correct (I've checked the spec and agree with it)..

https://elixir.bootlin.com/linux/v5.17-rc1/source/drivers/cxl/core/regs.c#L48

cap_array = readq(base + CXL_CM_CAP_HDR_OFFSET);

is undefined behavior as CAP_HDR is a 32bit register.

I guess the undefined choice on all the hardware people actually have
is to service the 8 byte read, but there is no reason to believe future
hardware will.

... and this is why we like having emulation in Qemu :)
+ eagle eyed reviewers!

Guess I'd better send a kernel fix sometime soon.

Jonathan

> Otherwise the rest looks ok to me:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 

