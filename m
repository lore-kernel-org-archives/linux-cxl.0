Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D24C433B4
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Apr 2021 14:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D9E610C7
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Apr 2021 14:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhDIOvb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:51:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2828 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhDIOva (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Apr 2021 10:51:30 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FH16Q1g8Bz686xF;
        Fri,  9 Apr 2021 22:41:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 16:51:10 +0200
Received: from localhost (10.47.90.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 15:51:09 +0100
Date:   Fri, 9 Apr 2021 15:49:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <mst@redhat.com>, <armbru@redhat.com>, <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <hchkuo@avery-design.com.tw>, <imammedo@redhat.com>,
        <ira.weiny@intel.com>, <jgroves@micron.com>,
        <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <tyshao@avery-design.com.tw>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH v4 cxl-2.0-doe 1/3] PCIe Data Object Exchange
 implementation
Message-ID: <20210409154945.00001e3f@Huawei.com>
In-Reply-To: <1617208595-3443-1-git-send-email-cbrowy@avery-design.com>
References: <1617207125-1138-1-git-send-email-cbrowy@avery-design.com>
        <1617208595-3443-1-git-send-email-cbrowy@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.233]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 31 Mar 2021 12:36:35 -0400
Chris Browy <cbrowy@avery-design.com> wrote:

> From: hchkuo <hchkuo@avery-design.com.tw>
> 

Description needed.  No patch is going to get applied with out something
to say what it actually does.  For this one, useful to have links to the
specs etc in the description plus a very quick intro to what it is for etc.


> Signed-off-by: hchkuo <hchkuo@avery-design.com.tw>

Process wise, if you are sending the emails Chris, you need to be part of the DCO
chain, which means you should also sign-off on the patches. That confirms that
to the best of your knowledge hchkuo and copyright holders are legally fine with
them being included in Qemu etc.
https://wiki.qemu.org/Contribute/SubmitAPatch (follow like to kernel policy that talks
more about this)

Comments below are mostly minor stylistic things.  There is just
enough here that I want to take a look at v5 before giving a Reviewed-by tag.

Thanks,

Jonathan


> ---
>  MAINTAINERS               |   7 +
>  hw/pci/meson.build        |   1 +
>  hw/pci/pcie_doe.c         | 356 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pcie.h     |   1 +
>  include/hw/pci/pcie_doe.h | 123 ++++++++++++++++
>  5 files changed, 488 insertions(+)
>  create mode 100644 hw/pci/pcie_doe.c
>  create mode 100644 include/hw/pci/pcie_doe.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f9097ed..e77e989 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1681,6 +1681,13 @@ F: docs/pci*
>  F: docs/specs/*pci*
>  F: default-configs/pci.mak
>  
> +PCIE DOE
> +M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> +M: Chris Browy <cbrowy@avery-design.com>
> +S: Supported
> +F: include/hw/pci/pcie_doe.h
> +F: hw/pci/pcie_doe.c
> +
>  ACPI/SMBIOS
>  M: Michael S. Tsirkin <mst@redhat.com>
>  M: Igor Mammedov <imammedo@redhat.com>
> diff --git a/hw/pci/meson.build b/hw/pci/meson.build
> index 5c4bbac..115e502 100644
> --- a/hw/pci/meson.build
> +++ b/hw/pci/meson.build
> @@ -12,6 +12,7 @@ pci_ss.add(files(
>  # allow plugging PCIe devices into PCI buses, include them even if
>  # CONFIG_PCI_EXPRESS=n.
>  pci_ss.add(files('pcie.c', 'pcie_aer.c'))
> +pci_ss.add(files('pcie_doe.c'))
>  softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
>  softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
>  
> diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
> new file mode 100644
> index 0000000..ec937ac
> --- /dev/null
> +++ b/hw/pci/pcie_doe.c
> @@ -0,0 +1,356 @@
> +/*
> + * PCIe Data Object Exchange
> + *
> + * Copyright (C) 2021 Avery Design Systems, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qemu/range.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_doe.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
> +
> +/* Discovery Request Object */
if you are going to use _rsp for response I'd
suggest _req for request.

With that naming it should be clear enough what these are that
you could also just drop the comments if you want to.

> +struct doe_discovery {
> +    DOEHeader header;
> +    uint8_t index;
> +    uint8_t reserved[3];
> +} QEMU_PACKED;
> +
> +/* Discovery Response Object */
> +struct doe_discovery_rsp {
> +    DOEHeader header;
> +    uint16_t vendor_id;
> +    uint8_t data_obj_type;
> +    uint8_t next_index;
> +} QEMU_PACKED;
> +
> +static bool pcie_doe_discovery_rsp(DOECap *doe_cap)
> +{
> +    struct doe_discovery *req = pcie_doe_get_req(doe_cap);
> +    struct doe_discovery_rsp rsp;
> +    uint8_t index = req->index;
> +    DOEProtocol *prot;
> +
> +    /* Request length mismatch, discard */

Might be worth a comment here to say that we don't need to explicitly handle
the 1DW case on the basis, if that happens the second DW will be meset to 0
anyway, so this check will fail.  Took me a few minutes to figure out why
a request that isn't large enough to actually say how large it is, was not
a problem!

> +    if (pcie_doe_get_obj_len(req) <
> +        DIV_ROUND_UP(sizeof(struct doe_discovery), 4)) {
> +        return false;
> +    }
> +
> +    rsp.header = (DOEHeader) {
> +        .vendor_id = PCI_VENDOR_ID_PCI_SIG,
> +        .data_obj_type = PCI_SIG_DOE_DISCOVERY,
> +        .length = DIV_ROUND_UP(sizeof(struct doe_discovery_rsp), 4),

sizeof(uint32_t) so we are consistent everywhere on that being how we get
to bytes in a DW.

> +    };
> +
> +    /* Point to the requested protocol, index 0 must be Discovery */
> +    if (index == 0) {
> +        rsp.vendor_id = PCI_VENDOR_ID_PCI_SIG;
> +        rsp.data_obj_type = PCI_SIG_DOE_DISCOVERY;
> +    } else {
> +        if (index < doe_cap->protocol_num) {
> +            prot = &doe_cap->protocols[index - 1];
> +        } else {
> +            prot = NULL;
Given you don't use prot for anything beyond this block, perhaps this
would be clearer as

           if (index < doe_cap->protocol_num) {
               DOEProtocol *prot = &doe_cap->protocols[index - 1];
               rsp.vendor_id = prot->vendor_id;
               rsp.data_object_type = prot->data_obj_type;
	   } else
               rsp.vendor_id = 0xFFFF;
               rsp.data_object_type = 0xFF;
> +        }
> +
> +        rsp.vendor_id = (prot) ? prot->vendor_id : 0xFFFF;
> +        rsp.data_obj_type = (prot) ? prot->data_obj_type : 0xFF;
> +    }
> +
> +    rsp.next_index = (index + 1) % doe_cap->protocol_num,

, ?

While the maths here might be technically true, I'd suggest it would
be clearer to just use an if statement to set it to 0 as appropriate.

> +
> +    pcie_doe_set_rsp(doe_cap, &rsp);
> +
> +    return true;
> +}
> +
> +static void pcie_doe_reset_mbox(DOECap *st)
> +{
> +    st->read_mbox_idx = 0;
> +    st->read_mbox_len = 0;
> +    st->write_mbox_len = 0;
> +
> +    memset(st->read_mbox, 0, PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +    memset(st->write_mbox, 0, PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +}
> +
> +/*
> + * Add DOE cap to a device
> + * Initialize its protocol.
> + */
> +void pcie_doe_init(PCIDevice *dev, DOECap *doe_cap, uint16_t offset,
> +                   DOEProtocol *protocols, bool intr, uint16_t vec)
> +{
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_DOE, 0x1, offset,
> +                        PCI_DOE_SIZEOF);
> +
> +    doe_cap->pdev = dev;
> +    doe_cap->offset = offset;
> +
> +    /* Configure MSI/MSI-X */
> +    if (intr && (msi_present(dev) || msix_present(dev))) {
> +        doe_cap->cap.intr = intr;
> +        doe_cap->cap.vec = vec;
> +    }
> +
> +    doe_cap->write_mbox = g_malloc0(PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +    doe_cap->read_mbox = g_malloc0(PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +
> +    pcie_doe_reset_mbox(doe_cap);
> +
> +    /* Register default discovery protocol */

Is this comment accurate? It seems to be registering all other protocols
except the discovery protocol.

> +    doe_cap->protocols = protocols;
> +    for (; protocols->vendor_id; protocols++) {
> +        doe_cap->protocol_num++;
> +    }
> +    assert(doe_cap->protocol_num < PCI_DOE_PROTOCOL_MAX);
> +
> +    doe_cap->protocol_num++;

Why the extra?  Add a comment perhaps.

> +}
> +
> +void pcie_doe_fini(DOECap *doe_cap)
> +{
> +    g_free(doe_cap->read_mbox);
> +    g_free(doe_cap->write_mbox);
> +    g_free(doe_cap);
> +}
> +
> +uint32_t pcie_doe_build_protocol(DOEProtocol *p)
> +{
> +    return DATA_OBJ_BUILD_HEADER1(p->vendor_id, p->data_obj_type);
> +}
> +
> +/* Return the pointer of DOE request in write mailbox buffer */
> +void *pcie_doe_get_req(DOECap *doe_cap)
This is a bit oddly named.  I kind of expected it to return a copy
of the request rather that a pointer to the write mailbox buffer.

pcie_doe_write_buffer() or something like that perhaps?

> +{
> +    return doe_cap->write_mbox;
> +}
> +
> +/* Copy the response to read mailbox buffer */
> +void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp)
> +{
> +    uint32_t len = pcie_doe_get_obj_len(rsp);
> +
> +    memcpy(doe_cap->read_mbox + doe_cap->read_mbox_len,
> +           rsp, len * sizeof(uint32_t));
> +    doe_cap->read_mbox_len += len;
> +}
> +
> +uint32_t pcie_doe_get_obj_len(void *obj)
> +{
> +    uint32_t len = (obj) ? ((DOEHeader *)obj)->length : 0;
> +
> +    return len & (PCI_DOE_MAX_DW_SIZE - 1);

Masking doesn't feel right here. Also, isn't a 1MB length
technically allowed?

> +}
> +
> +static void pcie_doe_write_mbox(DOECap *doe_cap, uint32_t val)
> +{
> +    doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
> +    doe_cap->write_mbox_len++;

As mentioned below, this doesn't feel like it's worth encapsulating
in a separate function.

> +}
> +
> +static void pcie_doe_irq_assert(DOECap *doe_cap)
> +{
> +    PCIDevice *dev = doe_cap->pdev;
> +
> +    if (doe_cap->cap.intr && doe_cap->ctrl.intr) {
> +        if (doe_cap->status.intr) {
> +            return;
> +        }
> +        doe_cap->status.intr = 1;
> +
> +        /* Notifies interrupt, legacy IRQ is not supported */
> +        if (msix_enabled(dev)) {
> +            msix_notify(dev, doe_cap->cap.vec);
> +        } else if (msi_enabled(dev)) {
> +            msi_notify(dev, doe_cap->cap.vec);
> +        }
> +    }
> +}
> +
> +static void pcie_doe_set_ready(DOECap *doe_cap, bool rdy)
> +{
> +    doe_cap->status.ready = rdy;
> +
> +    if (rdy) {
> +        pcie_doe_irq_assert(doe_cap);
> +    }
> +}
> +
> +static void pcie_doe_set_error(DOECap *doe_cap, bool err)
> +{
> +    doe_cap->status.error = err;
> +
> +    if (err) {
> +        pcie_doe_irq_assert(doe_cap);
> +    }
> +}
> +
> +/*
> + * Check incoming request in write_mbox for protocol format and
> + * memcopy the correponding reponse to read_mbox
> + */
> +static void pcie_doe_prepare_rsp(DOECap *doe_cap)
> +{
> +    bool success = false;
> +    int p;
> +
> +    if (doe_cap->status.error) {
> +        return;
> +    }
> +
> +    if (doe_cap->write_mbox[0] ==
> +        DATA_OBJ_BUILD_HEADER1(PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_DISCOVERY)) {
> +        success = pcie_doe_discovery_rsp(doe_cap);
> +    } else {
> +        for (p = 0; p < doe_cap->protocol_num - 1; p++) {
> +            if (doe_cap->write_mbox[0] ==
> +                pcie_doe_build_protocol(&doe_cap->protocols[p])) {
> +                /*
> +                 * DOE ECN 6.xx.1:
> +                 * If the number of DW transferred does not match the
> +                 * indicated Length for a data object, then the
> +                 * data object must be silently discarded.
> +                 */
> +                if (doe_cap->write_mbox_len ==
> +                    pcie_doe_get_obj_len(pcie_doe_get_req(doe_cap))) {
> +                    success = doe_cap->protocols[p].set_rsp(doe_cap);
> +                }
> +                break;
> +            }
> +        }
> +    }
> +
> +    if (success) {
> +        pcie_doe_set_ready(doe_cap, 1);
> +    } else {
> +        pcie_doe_reset_mbox(doe_cap);
> +    }
> +}
> +
> +/*
> + * Read from DOE config space.
> + * Return false if the address doesn't hit the range.
> + */
> +bool pcie_doe_read_config(DOECap *doe_cap, uint32_t addr, int size,
> +                          uint32_t *buf)
> +{
> +    uint32_t shift, mask = 0xFFFFFFFF;
> +    uint16_t doe_offset = doe_cap->offset;
> +
> +    if (!range_covers_byte(doe_offset + PCI_EXP_DOE_CAP,
> +                           PCI_DOE_SIZEOF - 4, addr)) {
> +        return false;
> +    }
> +
> +    addr -= doe_offset;
> +    *buf = 0;
> +
> +    if (range_covers_byte(PCI_EXP_DOE_CAP, sizeof(uint32_t), addr)) {
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_REG, INTR_SUPP,
> +                          doe_cap->cap.intr);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_REG, DOE_INTR_MSG_NUM,
> +                          doe_cap->cap.vec);
> +    } else if (range_covers_byte(PCI_EXP_DOE_CTRL, sizeof(uint32_t), addr)) {
> +        /* Must return ABORT=0 and GO=0 */
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_CONTROL, DOE_INTR_EN,
> +                          doe_cap->ctrl.intr);
> +    } else if (range_covers_byte(PCI_EXP_DOE_STATUS, sizeof(uint32_t), addr)) {
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_BUSY,
> +                          doe_cap->status.busy);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_INTR_STATUS,
> +                          doe_cap->status.intr);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_ERROR,
> +                          doe_cap->status.error);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DATA_OBJ_RDY,
> +                          doe_cap->status.ready);
> +    } else if (range_covers_byte(PCI_EXP_DOE_RD_DATA_MBOX, sizeof(uint32_t),
> +                                 addr)) {
> +        if (doe_cap->status.ready && !doe_cap->status.error) {
> +            *buf = doe_cap->read_mbox[doe_cap->read_mbox_idx];
> +        }
> +    }
> +
> +    /* Alignment */
> +    shift = addr % sizeof(uint32_t);
> +    *buf >>= shift * 8;
> +    mask >>= (sizeof(uint32_t) - size) * 8;
> +    *buf &= mask;
> +
> +    return true;
> +}
> +
> +/*
> + * Write to DOE config space.
> + * Early return if the address doesn't hit the range or receives an abort signal
> + */
> +void pcie_doe_write_config(DOECap *doe_cap,
> +                           uint32_t addr, uint32_t val, int size)
> +{
> +    uint16_t doe_offset = doe_cap->offset;
> +    uint32_t shift;
> +
> +    if (!range_covers_byte(doe_offset + PCI_EXP_DOE_CAP,
> +                           PCI_DOE_SIZEOF - 4, addr)) {
> +        return;
> +    }
> +
> +    /* Alignment */
> +    shift = addr % sizeof(uint32_t);
> +    addr -= (doe_offset + shift);
> +    val <<= shift * 8;
> +
> +    switch (addr) {
> +    case PCI_EXP_DOE_CTRL:
> +        if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_ABORT)) {
> +            pcie_doe_set_ready(doe_cap, 0);
> +            pcie_doe_set_error(doe_cap, 0);
> +            pcie_doe_reset_mbox(doe_cap);
> +            return;
> +        }
> +
> +        if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_GO)) {
> +            pcie_doe_prepare_rsp(doe_cap);
> +        }
> +
> +        if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_INTR_EN)) {
> +            doe_cap->ctrl.intr = 1;
> +        /* Clear interrupt bit located within the first byte */
> +        } else if (shift == 0) {
> +            doe_cap->ctrl.intr = 0;
> +        }
> +        break;
> +    case PCI_EXP_DOE_STATUS:
> +        if (FIELD_EX32(val, PCI_DOE_CAP_STATUS, DOE_INTR_STATUS)) {
> +            doe_cap->status.intr = 0;
> +        }
> +        break;
> +    case PCI_EXP_DOE_RD_DATA_MBOX:

Should we protect this register and the WR one against any accesses
that are not the full DW?  I've had a good read of the spec and can't
actually figure out what would happen if we did partial reads and
writes.  The implementation note says to do full DW so lets go with that
as being a requirement.

> +        doe_cap->read_mbox_idx += 1;
> +        if (doe_cap->read_mbox_idx == doe_cap->read_mbox_len) {
> +            pcie_doe_reset_mbox(doe_cap);
> +            pcie_doe_set_ready(doe_cap, 0);
> +        } else if (doe_cap->read_mbox_idx > doe_cap->read_mbox_len) {
> +            /* Underflow */
> +            pcie_doe_set_error(doe_cap, 1);
> +        }
> +        break;
> +    case PCI_EXP_DOE_WR_DATA_MBOX:
> +        pcie_doe_write_mbox(doe_cap, val);

Why have a function for write_mbox?  It seems to be doing very little
so just put the code inline here.

> +        break;
> +    case PCI_EXP_DOE_CAP:
> +        /* fallthrough */
> +    default:
> +        break;
> +    }
> +}
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 14c58eb..47d6f66 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -25,6 +25,7 @@
>  #include "hw/pci/pcie_regs.h"
>  #include "hw/pci/pcie_aer.h"
>  #include "hw/hotplug.h"
> +#include "hw/pci/pcie_doe.h"
>  
>  typedef enum {
>      /* for attention and power indicator */
> diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
> new file mode 100644
> index 0000000..64a7dba
> --- /dev/null
> +++ b/include/hw/pci/pcie_doe.h
> @@ -0,0 +1,123 @@
> +/*
> + * PCIe Data Object Exchange
> + *
> + * Copyright (C) 2021 Avery Design Systems, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef PCIE_DOE_H
> +#define PCIE_DOE_H
> +
> +#include "qemu/range.h"
> +#include "qemu/typedefs.h"
> +#include "hw/register.h"
> +
> +/*
> + * Referene:
> + * PCIe Data Object Exchange (DOE) ECN, March 12, 2020
> + */
> +/* Capabilities Register - 7.9.xx.2 */
> +#define PCI_EXP_DOE_CAP             0x04
> +REG32(PCI_DOE_CAP_REG, 0)
> +    FIELD(PCI_DOE_CAP_REG, INTR_SUPP, 0, 1)
> +    FIELD(PCI_DOE_CAP_REG, DOE_INTR_MSG_NUM, 1, 11)
> +
> +/* Control Register - 7.9.xx.3 */
> +#define PCI_EXP_DOE_CTRL            0x08
> +REG32(PCI_DOE_CAP_CONTROL, 0)
> +    FIELD(PCI_DOE_CAP_CONTROL, DOE_ABORT, 0, 1)
> +    FIELD(PCI_DOE_CAP_CONTROL, DOE_INTR_EN, 1, 1)
> +    FIELD(PCI_DOE_CAP_CONTROL, DOE_GO, 31, 1)
> +
> +/* Status Register - 7.9.xx.4 */
> +#define PCI_EXP_DOE_STATUS          0x0c
> +REG32(PCI_DOE_CAP_STATUS, 0)
> +    FIELD(PCI_DOE_CAP_STATUS, DOE_BUSY, 0, 1)
> +    FIELD(PCI_DOE_CAP_STATUS, DOE_INTR_STATUS, 1, 1)
> +    FIELD(PCI_DOE_CAP_STATUS, DOE_ERROR, 2, 1)
> +    FIELD(PCI_DOE_CAP_STATUS, DATA_OBJ_RDY, 31, 1)
> +
> +/* Write Data Mailbox Register - 7.9.xx.5 */
> +#define PCI_EXP_DOE_WR_DATA_MBOX    0x10
> +
> +/* Read Data Mailbox Register - 7.9.xx.6 */
> +#define PCI_EXP_DOE_RD_DATA_MBOX    0x14
> +
> +/* PCI-SIG defined Data Object Types - Table 7-x2 */
> +#define PCI_SIG_DOE_DISCOVERY       0x00
> +#define PCI_SIG_DOE_CMA             0x01

Introduce CMA define only when introducing support for it.

> +
> +#define DATA_OBJ_BUILD_HEADER1(v, p)  ((p << 16) | v)
> +
> +#define PCI_DOE_MAX_DW_SIZE (1 << 18)
> +#define PCI_DOE_PROTOCOL_MAX 256

Isn't that one more than the maximum accepted value?
I would expect MAX to mean the maximum value inclusive.


> +
> +typedef struct DOEHeader DOEHeader;
> +typedef struct DOEProtocol DOEProtocol;
> +typedef struct DOECap DOECap;
> +
> +struct DOEHeader {
> +    uint16_t vendor_id;
> +    uint8_t data_obj_type;
> +    uint8_t reserved;
> +    uint32_t length;
> +} QEMU_PACKED;
> +
> +/* Protocol infos and rsp function callback */
> +struct DOEProtocol {
> +    uint16_t vendor_id;
> +    uint8_t data_obj_type;
> +    bool (*set_rsp)(DOECap *);
I wonder if this is the best name.  It does set the response
but it also does a bunch of other stuff (like parsing the request).

handle_request() might be more accurate?

> +};
> +
> +struct DOECap {
> +    /* Owner */
> +    PCIDevice *pdev;
> +
> +    uint16_t offset;
> +
> +    struct {
> +        bool intr;
> +        uint16_t vec;
> +    } cap;
> +
> +    struct {
> +        bool abort;
> +        bool intr;
> +        bool go;
> +    } ctrl;
> +
> +    struct {
> +        bool busy;
> +        bool intr;
> +        bool error;
> +        bool ready;
> +    } status;
> +
> +    uint32_t *write_mbox;
> +    uint32_t *read_mbox;
> +
> +    /* Mailbox position indicator */
> +    uint32_t read_mbox_idx;
> +    uint32_t read_mbox_len;
> +    uint32_t write_mbox_len;
> +
> +    /* Protocols and its callback response */
> +    DOEProtocol *protocols;
> +    uint16_t protocol_num;
> +};
> +
> +void pcie_doe_init(PCIDevice *pdev, DOECap *doe_cap, uint16_t offset,
> +                   DOEProtocol *protocols, bool intr, uint16_t vec);
> +void pcie_doe_fini(DOECap *doe_cap);
> +bool pcie_doe_read_config(DOECap *doe_cap, uint32_t addr, int size,
> +                          uint32_t *buf);
> +void pcie_doe_write_config(DOECap *doe_cap, uint32_t addr,
> +                           uint32_t val, int size);
> +uint32_t pcie_doe_build_protocol(DOEProtocol *p);
> +void *pcie_doe_get_req(DOECap *doe_cap);
> +void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp);
> +uint32_t pcie_doe_get_obj_len(void *obj);
> +#endif /* PCIE_DOE_H */

