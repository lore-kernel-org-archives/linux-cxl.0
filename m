Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE0EC433E9
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Feb 2021 22:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F8A64E2E
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Feb 2021 22:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhBQWQx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Feb 2021 17:16:53 -0500
Received: from zangief.bwidawsk.net ([107.170.211.233]:53274 "EHLO
        mail.bwidawsk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhBQWQv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Feb 2021 17:16:51 -0500
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
        id 54F631257C0; Wed, 17 Feb 2021 14:16:05 -0800 (PST)
Received: from mail.bwidawsk.net (c-73-37-61-164.hsd1.or.comcast.net [73.37.61.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.bwidawsk.net (Postfix) with ESMTPSA id 87C5A1257B9;
        Wed, 17 Feb 2021 14:15:54 -0800 (PST)
Date:   Wed, 17 Feb 2021 14:15:53 -0800
From:   Ben Widawsky <ben@bwidawsk.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        Chris Browy <cbrowy@avery-design.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH v3 04/31] hw/cxl/device: Implement the CAP array
 (8.2.8.1-2)
Message-ID: <20210217221553.4zpm5rrzqy5jakmf@mail.bwidawsk.net>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
 <20210202005948.241655-5-ben.widawsky@intel.com>
 <20210202122350.000047f3@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210202122350.000047f3@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-02-02 12:23:50, Jonathan Cameron wrote:
> On Mon, 1 Feb 2021 16:59:21 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > This implements all device MMIO up to the first capability. That
> > includes the CXL Device Capabilities Array Register, as well as all of
> > the CXL Device Capability Header Registers. The latter are filled in as
> > they are implemented in the following patches.
> > 
> > Endianness and alignment are managed by softmmu memory core.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> A few trivials
> > ---
> >  hw/cxl/cxl-device-utils.c   | 105 ++++++++++++++++++++++++++++++++++++
> >  hw/cxl/meson.build          |   1 +
> >  include/hw/cxl/cxl_device.h |  27 +++++++++-
> >  3 files changed, 132 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/cxl/cxl-device-utils.c
> > 
> > diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> > new file mode 100644
> > index 0000000000..bb15ad9a0f
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
> > + *   • A 32 bit register shall   be accessed as a 1 Byte, 2 Bytes or 4 Bytes
> 
> odd spacing
> 
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
> > +
> > +static const MemoryRegionOps caps_ops = {
> > +    .read = caps_reg_read,
> > +    .write = NULL, /* caps registers are read only */
> > +    .endianness = DEVICE_LITTLE_ENDIAN,
> > +    .valid = {
> > +        .min_access_size = 1,
> > +        .max_access_size = 8,
> > +        .unaligned = false,
> > +    },
> > +    .impl = {
> > +        .min_access_size = 4,
> > +        .max_access_size = 4,
> > +    },
> > +};
> > +
> > +void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
> > +{
> > +    /* This will be a BAR, so needs to be rounded up to pow2 for PCI spec */
> > +    memory_region_init(&cxl_dstate->device_registers, obj, "device-registers",
> > +                       pow2ceil(CXL_MMIO_SIZE));
> > +
> > +    memory_region_init_io(&cxl_dstate->caps, obj, &caps_ops, cxl_dstate,
> > +                          "cap-array", CXL_DEVICE_REGISTERS_OFFSET - 0);
> 
> Specifying a size in terms of the offset of another region isn't exactly 
> intuitive so perhaps a comment on why or better yet actually use a size
> parameter covering what is there rather than simply the region below
> the CXL_DEVICE_REGISTERS_OFFSET.
> 

I didn't have a simple way to accommodate this before, but now I do have
CXL_CAPS_SIZE which is what we want here.

You also made me realize I have a PEMDAS bug in CXL_CAPS_SIZE, so thanks.

> 
> > +    memory_region_init_io(&cxl_dstate->device, obj, &dev_ops, cxl_dstate,
> > +                          "device-status", CXL_DEVICE_REGISTERS_LENGTH);
> > +
> > +    memory_region_add_subregion(&cxl_dstate->device_registers, 0,
> > +                                &cxl_dstate->caps);
> > +    memory_region_add_subregion(&cxl_dstate->device_registers,
> > +                                CXL_DEVICE_REGISTERS_OFFSET,
> > +                                &cxl_dstate->device);
> > +}
> > +
> > +static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
> > +
> > +void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
> > +{
> > +    uint32_t *cap_hdrs = cxl_dstate->caps_reg_state32;
> > +    const int cap_count = 1;
> > +
> > +    /* CXL Device Capabilities Array Register */
> > +    ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
> > +    ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
> > +    ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY2, CAP_COUNT, cap_count);
> > +
> > +    cxl_device_cap_init(cxl_dstate, DEVICE, 1);
> > +    device_reg_init_common(cxl_dstate);
> > +}
> > diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
> > index 00c3876a0f..47154d6850 100644
> > --- a/hw/cxl/meson.build
> > +++ b/hw/cxl/meson.build
> > @@ -1,3 +1,4 @@
> >  softmmu_ss.add(when: 'CONFIG_CXL', if_true: files(
> >    'cxl-component-utils.c',
> > +  'cxl-device-utils.c',
> >  ))
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index a85f250503..f3bcf19410 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -58,6 +58,8 @@
> >  #define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
> >  #define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
> >  #define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
> > +#define CXL_CAPS_SIZE \
> > +    (CXL_DEVICE_CAP_REG_SIZE * CXL_DEVICE_CAPS_MAX + 1) /* +1 for header */
> >  
> >  #define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above */
> >  #define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */
> > @@ -70,11 +72,18 @@
> >  #define CXL_MAILBOX_REGISTERS_LENGTH \
> >      (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
> >  
> > +#define CXL_MMIO_SIZE                                       \
> > +    CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_REGISTERS_LENGTH + \
> > +        CXL_MAILBOX_REGISTERS_LENGTH
> > +
> >  typedef struct cxl_device_state {
> >      MemoryRegion device_registers;
> >  
> >      /* mmio for device capabilities array - 8.2.8.2 */
> > -    MemoryRegion caps;
> > +    struct {
> > +        MemoryRegion caps;
> > +        uint32_t caps_reg_state32[CXL_CAPS_SIZE / 4];
> > +    };
> 
> With this unnamed,w hat is the benefit of having these two in a
> struct?  The naming makes it clear they are related anyway.
> 
> >  
> >      /* mmio for the device status registers 8.2.8.3 */
> >      MemoryRegion device;
> > @@ -126,6 +135,22 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DEVICE_CAP_HDR1_OFFSET)
> >  CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSET + \
> >                                                 CXL_DEVICE_CAP_REG_SIZE)
> >  
> > +#define cxl_device_cap_init(dstate, reg, cap_id)                                   \
> > +    do {                                                                           \
> > +        uint32_t *cap_hdrs = dstate->caps_reg_state32;                             \
> > +        int which = R_CXL_DEV_##reg##_CAP_HDR0;                                    \
> > +        cap_hdrs[which] =                                                          \
> > +            FIELD_DP32(cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_ID, cap_id); \
> > +        cap_hdrs[which] = FIELD_DP32(                                              \
> > +            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, 1);            \
> > +        cap_hdrs[which + 1] =                                                      \
> > +            FIELD_DP32(cap_hdrs[which + 1], CXL_DEV_##reg##_CAP_HDR1,              \
> > +                       CAP_OFFSET, CXL_##reg##_REGISTERS_OFFSET);                  \
> > +        cap_hdrs[which + 2] =                                                      \
> > +            FIELD_DP32(cap_hdrs[which + 2], CXL_DEV_##reg##_CAP_HDR2,              \
> > +                       CAP_LENGTH, CXL_##reg##_REGISTERS_LENGTH);                  \
> > +    } while (0)
> > +
> >  REG32(CXL_DEV_MAILBOX_CAP, 0)
> >      FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
> >      FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
> 
> 
