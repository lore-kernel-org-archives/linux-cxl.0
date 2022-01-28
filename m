Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F84C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 15:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiA1PQO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:16:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4549 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiA1PQN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 10:16:13 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JlgsY6yDMz67xJ8;
        Fri, 28 Jan 2022 23:11:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 28 Jan 2022 16:16:11 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 15:16:09 +0000
Date:   Fri, 28 Jan 2022 15:16:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 05/42] hw/cxl/device: Implement the CAP array
 (8.2.8.1-2)
Message-ID: <20220128151607.000022b7@huawei.com>
In-Reply-To: <87tudqbbr7.fsf@linaro.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
        <20220124171705.10432-6-Jonathan.Cameron@huawei.com>
        <87tudqbbr7.fsf@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 26 Jan 2022 18:17:12 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > This implements all device MMIO up to the first capability. That
> > includes the CXL Device Capabilities Array Register, as well as all of
> > the CXL Device Capability Header Registers. The latter are filled in as
> > they are implemented in the following patches.
> >
> > Endianness and alignment are managed by softmmu memory core.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/cxl/cxl-device-utils.c   | 105 ++++++++++++++++++++++++++++++++++++
> >  hw/cxl/meson.build          |   1 +
> >  include/hw/cxl/cxl_device.h |  28 +++++++++-
> >  3 files changed, 133 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> > new file mode 100644
> > index 0000000000..cb1b0a8217
> > --- /dev/null
> > +++ b/hw/cxl/cxl-device-utils.c
> > @@ -0,0 +1,105 @@
> > +/*
> > + * CXL Utility library for devices
> > + *
> > + * Copyright(C) 2020 Intel Corporation.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "hw/cxl/cxl.h"
> > +
> > +/*
> > + * Device registers have no restrictions per the spec, and so fall back to the
> > + * default memory mapped register rules in 8.2:
> > + *   Software shall use CXL.io Memory Read and Write to access memory mapped
> > + *   register defined in this section. Unless otherwise specified, software
> > + *   shall restrict the accesses width based on the following:
> > + *   • A 32 bit register shall be accessed as a 1 Byte, 2 Bytes or 4 Bytes
> > + *     quantity.
> > + *   • A 64 bit register shall be accessed as a 1 Byte, 2 Bytes, 4 Bytes or 8
> > + *     Bytes
> > + *   • The address shall be a multiple of the access width, e.g. when
> > + *     accessing a register as a 4 Byte quantity, the address shall be
> > + *     multiple of 4.
> > + *   • The accesses shall map to contiguous bytes.If these rules are not
> > + *     followed, the behavior is undefined
> > + */
> > +
> > +static uint64_t caps_reg_read(void *opaque, hwaddr offset, unsigned size)
> > +{
> > +    CXLDeviceState *cxl_dstate = opaque;
> > +
> > +    return cxl_dstate->caps_reg_state32[offset / 4];
> > +}
> > +
> > +static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
> > +{
> > +    return 0;
> > +}
> > +
> > +static const MemoryRegionOps dev_ops = {
> > +    .read = dev_reg_read,
> > +    .write = NULL, /* status register is read only */
> > +    .endianness = DEVICE_LITTLE_ENDIAN,
> > +    .valid = {
> > +        .min_access_size = 1,
> > +        .max_access_size = 8,
> > +        .unaligned = false,
> > +    },
> > +    .impl = {
> > +        .min_access_size = 1,
> > +        .max_access_size = 8,
> > +    },
> > +};  
> 
> I think for >64 bit registers you need to use the read_with_attrs 

I don't follow this comment.  Max access to registers is 64 bits.
A few are documented as 128 bit or indeed larger in the spec, but the
access is as if they were multiple 64 bit registers accesses.
It's not permissible to do a single 128bit access for example.

The F4 errata clarified that - previously it was rather unclear what
the restrictions on access to the larger registers were.

I've updated a few comments on this to reflect the errata.

Thanks,

Jonathan
