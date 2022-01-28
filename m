Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC639C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbiA1PDH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:03:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4548 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbiA1PDH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 10:03:07 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JlgbQ5l8Hz67F8F;
        Fri, 28 Jan 2022 22:59:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 16:03:04 +0100
Received: from localhost (10.47.76.156) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 15:03:03 +0000
Date:   Fri, 28 Jan 2022 15:02:54 +0000
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
Subject: Re: [PATCH v4 04/42] hw/cxl/device: Introduce a CXL device (8.2.8)
Message-ID: <20220128150254.000020e5@Huawei.com>
In-Reply-To: <87y232bc0f.fsf@linaro.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
        <20220124171705.10432-5-Jonathan.Cameron@huawei.com>
        <87y232bc0f.fsf@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.76.156]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 26 Jan 2022 18:07:40 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > A CXL device is a type of CXL component. Conceptually, a CXL device
> > would be a leaf node in a CXL topology. From an emulation perspective,
> > CXL devices are the most complex and so the actual implementation is
> > reserved for discrete commits.
> >
> > This new device type is specifically catered towards the eventual
> > implementation of a Type3 CXL.mem device, 8.2.8.5 in the CXL 2.0
> > specification.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/hw/cxl/cxl.h        |   1 +
> >  include/hw/cxl/cxl_device.h | 157 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 158 insertions(+)
> >
> > diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> > index 8c738c7a2b..b9d1ac3fad 100644
> > --- a/include/hw/cxl/cxl.h
> > +++ b/include/hw/cxl/cxl.h
> > @@ -12,5 +12,6 @@
> >  
> >  #include "cxl_pci.h"
> >  #include "cxl_component.h"
> > +#include "cxl_device.h"
> >  
> >  #endif
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > new file mode 100644
> > index 0000000000..3b6ed745f0
> > --- /dev/null
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -0,0 +1,157 @@
> > +/*
> > + * QEMU CXL Devices
> > + *
> > + * Copyright (c) 2020 Intel
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef CXL_DEVICE_H
> > +#define CXL_DEVICE_H
> > +
> > +#include "hw/register.h"
> > +
> > +/*
> > + * The following is how a CXL device's MMIO space is laid out. The only
> > + * requirement from the spec is that the capabilities array and the capability
> > + * headers start at offset 0 and are contiguously packed. The headers themselves
> > + * provide offsets to the register fields. For this emulation, registers will
> > + * start at offset 0x80 (m == 0x80). No secondary mailbox is implemented which
> > + * means that n = m + sizeof(mailbox registers) + sizeof(device registers).
> > + *
> > + * This is roughly described in 8.2.8 Figure 138 of the CXL 2.0 spec.
> > + *
> > + *                       +---------------------------------+
> > + *                       |                                 |
> > + *                       |    Memory Device Registers      |
> > + *                       |                                 |
> > + * n + PAYLOAD_SIZE_MAX  -----------------------------------
> > + *                  ^    |                                 |
> > + *                  |    |                                 |
> > + *                  |    |                                 |
> > + *                  |    |                                 |
> > + *                  |    |                                 |
> > + *                  |    |         Mailbox Payload         |
> > + *                  |    |                                 |
> > + *                  |    |                                 |
> > + *                  |    |                                 |
> > + *                  |    -----------------------------------
> > + *                  |    |       Mailbox Registers         |
> > + *                  |    |                                 |
> > + *                  n    -----------------------------------
> > + *                  ^    |                                 |
> > + *                  |    |        Device Registers         |
> > + *                  |    |                                 |
> > + *                  m    ---------------------------------->
> > + *                  ^    |  Memory Device Capability Header|
> > + *                  |    -----------------------------------
> > + *                  |    |     Mailbox Capability Header   |
> > + *                  |    -------------- --------------------
> > + *                  |    |     Device Capability Header    |
> > + *                  |    -----------------------------------
> > + *                  |    |                                 |
> > + *                  |    |                                 |
> > + *                  |    |      Device Cap Array[0..n]     |
> > + *                  |    |                                 |
> > + *                  |    |                                 |
> > + *                       |                                 |
> > + *                  0    +---------------------------------+
> > + *
> > + */  
> 
> Excellent diagram ;-)
> 
> > +
> > +#define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
> > +#define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
> > +#define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
> > +
> > +#define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above */
> > +#define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */
> > +
> > +#define CXL_MAILBOX_REGISTERS_OFFSET \
> > +    (CXL_DEVICE_REGISTERS_OFFSET + CXL_DEVICE_REGISTERS_LENGTH)
> > +#define CXL_MAILBOX_REGISTERS_SIZE 0x20 /* 8.2.8.4, Figure 139 */
> > +#define CXL_MAILBOX_PAYLOAD_SHIFT 11
> > +#define CXL_MAILBOX_MAX_PAYLOAD_SIZE (1 << CXL_MAILBOX_PAYLOAD_SHIFT)
> > +#define CXL_MAILBOX_REGISTERS_LENGTH \
> > +    (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
> > +
> > +typedef struct cxl_device_state {
> > +    MemoryRegion device_registers;
> > +
> > +    /* mmio for device capabilities array - 8.2.8.2 */
> > +    MemoryRegion caps;
> > +
> > +    /* mmio for the device status registers 8.2.8.3 */
> > +    MemoryRegion device;
> > +
> > +    /* mmio for the mailbox registers 8.2.8.4 */
> > +    MemoryRegion mailbox;
> > +
> > +    /* memory region for persistent memory, HDM */
> > +    uint64_t pmem_size;
> > +} CXLDeviceState;
> > +
> > +/* Initialize the register block for a device */
> > +void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);
> > +
> > +/* Set up default values for the register block */
> > +void cxl_device_register_init_common(CXLDeviceState *dev);
> > +
> > +/* CXL 2.0 - 8.2.8.1 */
> > +REG32(CXL_DEV_CAP_ARRAY, 0) /* 48b!?!?! */  
> 
> What does this comment mean? A 48 bit register stuffed in a 32 bit one?
> Doesn't seem right.

ah. I'd forgotten about this.. !?!?! is code word for spec bug without
actually saying it in a public email...

It's fixed now in the published errata which makes this a 128bit
register but then says you can access it as a 64 bit register and reserves
everything above bit 48.  I'll update the comment and make it a REG64.

> 
> > +    FIELD(CXL_DEV_CAP_ARRAY, CAP_ID, 0, 16)
> > +    FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
> > +REG32(CXL_DEV_CAP_ARRAY2, 4) /* We're going to pretend it's 64b */
> > +    FIELD(CXL_DEV_CAP_ARRAY2, CAP_COUNT, 0, 16)  
> 
> I'm confused why you don't treat it as a single register it is in the
> spec.

Code predates introduction of REG64() and I'd missed that turning up.

> 
> > +
> > +/*
> > + * Helper macro to initialize capability headers for CXL devices.
> > + *
> > + * In the 8.2.8.2, this is listed as a 128b register, but in 8.2.8, it says:
> > + * > No registers defined in Section 8.2.8 are larger than 64-bits wide so that
> > + * > is the maximum access size allowed for these registers. If this rule is not
> > + * > followed, the behavior is undefined
> > + *
> > + * Here we've chosen to make it 4 dwords. The spec allows any pow2 multiple
> > + * access to be used for a register (2 qwords, 8 words, 128 bytes).

The F4 errata covers this as well, making it clear that 128bit registers
can be accessed as 1,2,4,8 byte aligned reads.  No read advantage
of REG64 over REG32 as neither matches the spec, so I'll leave this one alone
but update the comment..

> > + */
> > +#define CXL_DEVICE_CAPABILITY_HEADER_REGISTER(n, offset)  \
> > +    REG32(CXL_DEV_##n##_CAP_HDR0, offset)                 \
> > +        FIELD(CXL_DEV_##n##_CAP_HDR0, CAP_ID, 0, 16)      \
> > +        FIELD(CXL_DEV_##n##_CAP_HDR0, CAP_VERSION, 16, 8) \
> > +    REG32(CXL_DEV_##n##_CAP_HDR1, offset + 4)             \
> > +        FIELD(CXL_DEV_##n##_CAP_HDR1, CAP_OFFSET, 0, 32)  \
> > +    REG32(CXL_DEV_##n##_CAP_HDR2, offset + 8)             \
> > +        FIELD(CXL_DEV_##n##_CAP_HDR2, CAP_LENGTH, 0, 32)
> > +
> > +CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DEVICE_CAP_HDR1_OFFSET)
> > +CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSET + \
> > +                                               CXL_DEVICE_CAP_REG_SIZE)
> > +
> > +REG32(CXL_DEV_MAILBOX_CAP, 0)
> > +    FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
> > +    FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
> > +    FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
> > +    FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
> > +
> > +REG32(CXL_DEV_MAILBOX_CTRL, 4)
> > +    FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
> > +    FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
> > +    FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
> > +
> > +/* XXX: actually a 64b register */
> > +REG32(CXL_DEV_MAILBOX_STS, 0x10)
> > +    FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
> > +    FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
> > +    FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
> > +
> > +/* XXX: actually a 64b register */
> > +REG32(CXL_DEV_BG_CMD_STS, 0x18)
> > +    FIELD(CXL_DEV_BG_CMD_STS, BG, 0, 16)
> > +    FIELD(CXL_DEV_BG_CMD_STS, DONE, 16, 7)
> > +    FIELD(CXL_DEV_BG_CMD_STS, ERRNO, 32, 16)
> > +    FIELD(CXL_DEV_BG_CMD_STS, VENDOR_ERRNO, 48, 16)  
> 
> Again is there a reason not to use REG64? I can see the need to split
> 128 bit registers but not 64 bit ones.

Will do.

> 
> > +
> > +REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
> > +
> > +#endif  
> 
> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 

