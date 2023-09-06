Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DED9EB8FCD
	for <linux-cxl@archiver.kernel.org>; Wed,  6 Sep 2023 13:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbjIFNEz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 6 Sep 2023 09:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjIFNEy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 6 Sep 2023 09:04:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBC81713
        for <linux-cxl@vger.kernel.org>; Wed,  6 Sep 2023 06:04:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RgjGz6Y3Fz67Nsw;
        Wed,  6 Sep 2023 21:03:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 6 Sep
 2023 14:04:46 +0100
Date:   Wed, 6 Sep 2023 14:04:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <junhee.ryu@sk.com>, <kwangjin.ko@sk.com>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 5/5] cxl/vendor: SK hynix Niagara Multi-Headed SLD
 Device
Message-ID: <20230906140445.00002acd@Huawei.com>
In-Reply-To: <20230901012914.226527-6-gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
        <20230901012914.226527-6-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 31 Aug 2023 21:29:14 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Create a new device to emulate the SK hynix Niagara MHSLD platform.
> 
> This device has custom CCI commands that allow for applying isolation
> to each memory block between hosts. This enables an early form of
> dynamic capacity, whereby the NUMA node maps the entire region, but
> the host is responsible for asking the device which memory blocks
> are allocated to it, and therefore may be onlined.
> 
> To instantiate:
> 
> -device cxl-skh-niagara,cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,sn=66666,mhd-head=0,mhd-shmid=0
> 
> The linux kernel will require raw CXL commands enabled to allow for
> passing through of Niagara CXL commands via the CCI mailbox.
> 
> The Niagara MH-SLD has a shared memory region that must be initialized
> using the 'init_niagara' tool located in the vendor subdirectory
> 
> usage: init_niagara <heads> <sections> <section_size> <shmid>
>         heads         : number of heads on the device
>         sections      : number of sections
>         section_size  : size of a section in 128mb increments
>         shmid         : shmid produced by ipcmk
> 
> Example:
> $shmid1=ipcmk -M 131072
> ./init_niagara 4 32 1 $shmid1
> 
Hi Gregory,

Some comments inline, but I'm happy to add this to my staging tree in the meantime
as it stands (might be a few days until I push a new branch though).

> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Junhee Ryu <junhee.ryu@sk.com>
> Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>

The SoB chain needs cleaning up.  Is this a co-developed situation?
If it is use the rules in the kernel documentation as I don't think those
are yet clearly stated in QEMU docs (and they are confusing so I won't try
to restate them here).


> diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
> new file mode 100644
> index 0000000000..4e57db65f1
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/meson.build
> @@ -0,0 +1 @@
> +system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
> diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.c b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> new file mode 100644
> index 0000000000..88e53cc6cc
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> @@ -0,0 +1,516 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2023 MemVerge Inc.
> + * Copyright (c) 2023 SK hynix Inc.
> + */
> +
> +#include <sys/shm.h>

This will need some osdep.h magic.  There is some there
already but it will need relaxing (unless you want to run only on sparc ;)
and we may need to make this device linux host only.



> +#include "qemu/osdep.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_mailbox.h"
> +#include "hw/cxl/cxl_device.h"
> +#include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_port.h"
> +#include "hw/qdev-properties.h"
> +#include "skhynix_niagara.h"
> +
> +#define TYPE_CXL_NIAGARA "cxl-skh-niagara"
> +OBJECT_DECLARE_TYPE(CXLNiagaraState, CXLNiagaraClass, CXL_NIAGARA)

...
> +
> +static void niagara_alloc_build_output(NiagaraAllocOutput *output,
> +                                       size_t *len_out,
> +                                       uint32_t *section_ids,
> +                                       uint32_t section_count)
> +{
> +    uint32_t extents;
> +    uint32_t previous;
> +    uint32_t i;
> +
> +    /* Build the output */
> +    output->section_count = section_count;
> +    extents = 0;
> +    previous = 0;
> +    for (i = 0; i < section_count; i++) {
> +        if (i == 0) {
> +            /* start the first extent */
> +            output->extents[extents].start_section_id = section_ids[i];
> +            output->extents[extents].section_count = 1;
> +            extents++;
> +        } else if (section_ids[i] == (previous + 1)) {
> +            /* increment the current extent */
> +            output->extents[extents - 1].section_count++;
> +        } else {
> +            /* start a new extent */
> +            output->extents[extents].start_section_id = section_ids[i];
> +            output->extents[extents].section_count = 1;
> +            extents++;
> +        }
> +        previous = section_ids[i];
> +    }
> +    output->extent_count = extents;
> +    *len_out = (8 + (16 * extents));

Too many brackets.

> +    return;
> +}
> +

> +static CXLRetCode cmd_niagara_get_section_map(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    CXLNiagaraState *s = CXL_NIAGARA(cci->d);
> +    NiagaraSharedState *nss = s->mhd_state;
> +    NiagaraGetSectionMapInput *input = (void *)payload_in;
> +    NiagaraGetSectionMapOutput *output = (void *)payload_out;
> +    uint32_t *sections = &nss->sections[0];
> +    uint8_t query_type = input->query_type;
> +    uint32_t i;
> +    uint32_t bytes;
> +
> +    if ((query_type != NIAGARA_GSM_QUERY_FREE) &&
> +        (query_type != NIAGARA_GSM_QUERY_ALLOCATED)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    output->ttl_section_count = nss->total_sections;
> +    output->qry_section_count = 0;
> +    bytes = (output->ttl_section_count / 8);
> +    if (output->ttl_section_count % 8) {
> +        bytes += 1;
> +    }
> +
> +    for (i = 0; i < bytes; i++) {
> +        output->bitset[i] = 0x0;
> +    }
> +
> +    /* Iterate the the section list and check the bits */
> +    for (i = 0; (i < nss->total_sections); i++) {
> +        uint32_t section = sections[i];
> +
> +        if (((query_type == NIAGARA_GSM_QUERY_FREE) && (!section)) ||
> +            ((query_type == NIAGARA_GSM_QUERY_ALLOCATED) &&
> +             (section & (1 << s->mhd_head)))) {
> +            uint32_t byte = i / 8;
> +            uint8_t bit = (1 << (i % 8));

Too many brackets

> +
> +            output->bitset[byte] |= bit;
> +            output->qry_section_count++;
> +        }
> +    }
> +
> +    *len_out = (8 + bytes);

No need for brackets.

> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static bool mhdsld_access_valid(PCIDevice *d,
> +                                uint64_t dpa_offset,
> +                                unsigned int size)
> +{
> +    CXLNiagaraState *s = CXL_NIAGARA(d);
> +    NiagaraSharedState *nss = s->mhd_state;
> +    uint32_t section = (dpa_offset / NIAGARA_MIN_MEMBLK);
> +
> +    if (!(nss->sections[section] & (1 << s->mhd_head))) {
> +        return false;
> +    }
> +    return true;

    return nss->sections[section] & (1 << s->mhd_head);

> +}
...

> +
> +static void cxl_niagara_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
> +
> +    pc->realize = cxl_niagara_realize;
> +    pc->exit = cxl_niagara_exit;
> +    dc->reset = cxl_niagara_reset;
> +    device_class_set_props(dc, cxl_niagara_props);

As mentioned in previous patch, probably want to set your extra callback
for verification here as well.

> +}

> diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.h b/hw/cxl/vendor/skhynix/skhynix_niagara.h
> new file mode 100644
> index 0000000000..0489102f38
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/skhynix_niagara.h
> @@ -0,0 +1,169 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2023 MemVerge Inc.
> + * Copyright (c) 2023 SK hynix Inc.
> + */
> +
> +#ifndef CXL_SKH_NIAGARA_H
> +#define CXL_SKH_NIAGARA_H
> +#include <stdint.h>
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_mailbox.h"
> +#include "hw/cxl/cxl_device.h"
> +
> +#define NIAGARA_MIN_MEMBLK (1024 * 1024 * 128)

128 * MiB (include/qemu/units.h)

> +
> +enum {
> +    NIAGARA_MHD = 0x55,
> +        #define GET_MHD_INFO 0x0

Is this standard as it's in the normal space?
If it is then I'd like the implementation pushed down to the
type3 implementation (with some callbacks or similar.)

> +    NIAGARA_CMD = 0xC0

These are in the vendor space so having them in this
device directly is fine.

> +        #define GET_SECTION_STATUS 0x0
> +        #define SET_SECTION_ALLOC 0x1
> +        #define SET_SECTION_RELEASE 0x2
> +        #define SET_SECTION_SIZE 0x3
> +        /* Future: MOVE_DATA 0x4 */
> +        #define GET_SECTION_MAP 0x5
> +        /* Future: CLEAR_SECTION 0x99 */
> +};
> +
> +typedef struct NiagaraExtent {
> +    uint32_t start_section_id;
> +    uint32_t section_count;
> +    uint8_t reserved[8];
> +} QEMU_PACKED NiagaraExtent;

...

> +/*
> + * Niagara Get Section Map Command
> + * query type:
> + *     Free - Map of free sections
> + *     Allocted - What sections are allocated for this head

allocated

> + * Returns a map of the requested type of sections
> + */
> +#define NIAGARA_GSM_QUERY_FREE 0
> +#define NIAGARA_GSM_QUERY_ALLOCATED 1

...

