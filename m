Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE6C433E0
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Feb 2021 22:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D963B64DD5
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Feb 2021 22:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhBIW2q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:28:46 -0500
Received: from zangief.bwidawsk.net ([107.170.211.233]:50692 "EHLO
        mail.bwidawsk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhBIWPw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Feb 2021 17:15:52 -0500
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
        id EF982122C69; Tue,  9 Feb 2021 13:42:48 -0800 (PST)
Received: from mail.bwidawsk.net (c-73-37-61-164.hsd1.or.comcast.net [73.37.61.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.bwidawsk.net (Postfix) with ESMTPSA id 9D866122C84;
        Tue,  9 Feb 2021 13:42:31 -0800 (PST)
Date:   Tue, 9 Feb 2021 13:42:30 -0800
From:   Ben Widawsky <ben@bwidawsk.net>
To:     Chris Browy <cbrowy@avery-design.com>
Cc:     david@redhat.com, qemu-devel@nongnu.org, vishal.l.verma@intel.com,
        jgroves@micron.com, armbru@redhat.com, linux-cxl@vger.kernel.org,
        f4bug@amsat.org, mst@redhat.com, Jonathan.Cameron@huawei.com,
        imammedo@redhat.com, dan.j.williams@intel.com, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 1/2] Basic PCIe DOE support
Message-ID: <20210209214230.md6nciasmkaisqx3@mail.bwidawsk.net>
References: <1612900760-7361-1-git-send-email-cbrowy@avery-design.com>
 <1612902949-9992-1-git-send-email-cbrowy@avery-design.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612902949-9992-1-git-send-email-cbrowy@avery-design.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Have you/Jonathan come to consensus about which implementation is going forward?
I'd rather not have to review two :D

On 21-02-09 15:35:49, Chris Browy wrote:
> ---
>  MAINTAINERS                               |   7 +
>  hw/pci/meson.build                        |   1 +
>  hw/pci/pcie.c                             |   2 +-
>  hw/pci/pcie_doe.c                         | 414 ++++++++++++++++++++++++++++++
>  include/hw/pci/pci_ids.h                  |   2 +
>  include/hw/pci/pcie.h                     |   1 +
>  include/hw/pci/pcie_doe.h                 | 166 ++++++++++++
>  include/hw/pci/pcie_regs.h                |   4 +
>  include/standard-headers/linux/pci_regs.h |   3 +-
>  9 files changed, 598 insertions(+), 2 deletions(-)
>  create mode 100644 hw/pci/pcie_doe.c
>  create mode 100644 include/hw/pci/pcie_doe.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 981dc92..4fb865e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1655,6 +1655,13 @@ F: docs/pci*
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

It looks like this should be like the below line:
softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: pci_doe.c))

>  softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
>  softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
>  
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 1ecf6f6..f7516c4 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -735,7 +735,7 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
>  
>      hotplug_event_notify(dev);
>  
> -    /* 
> +    /*

Please drop this.

>       * 6.7.3.2 Command Completed Events
>       *
>       * Software issues a command to a hot-plug capable Downstream Port by
> diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
> new file mode 100644
> index 0000000..df8e92e
> --- /dev/null
> +++ b/hw/pci/pcie_doe.c
> @@ -0,0 +1,414 @@
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
> +/*
> + * DOE Default Protocols (Discovery, CMA)
> + */
> +/* Discovery Request Object */
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
> +    uint8_t doe_type;
> +    uint8_t next_index;
> +} QEMU_PACKED;
> +
> +/* Callback for Discovery */
> +static bool pcie_doe_discovery_rsp(DOECap *doe_cap)
> +{
> +    PCIEDOE *doe = doe_cap->doe;
> +    struct doe_discovery *req = pcie_doe_get_req(doe_cap);
> +    uint8_t index = req->index;
> +    DOEProtocol *prot = NULL;
> +
> +    /* Request length mismatch, discard */
> +    if (req->header.length < dwsizeof(struct doe_discovery)) {

Use DIV_ROUND_UP instead of rolling your own thing.

> +        return DOE_DISCARD;
> +    }
> +
> +    /* Point to the requested protocol */
> +    if (index < doe->protocol_num) {
> +        prot = &doe->protocols[index];
> +    }

What happens on else, should that still return DOE_SUCCESS?

> +
> +    struct doe_discovery_rsp rsp = {
> +        .header = {
> +            .vendor_id = PCI_VENDOR_ID_PCI_SIG,
> +            .doe_type = PCI_SIG_DOE_DISCOVERY,
> +            .reserved = 0x0,
> +            .length = dwsizeof(struct doe_discovery_rsp),
> +        },

mixed declarations are not allowed.
DIV_ROUND_UP

> +        .vendor_id = (prot) ? prot->vendor_id : 0xFFFF,
> +        .doe_type = (prot) ? prot->doe_type : 0xFF,
> +        .next_index = (index + 1) < doe->protocol_num ?
> +                      (index + 1) : 0,
> +    };

I prefer:
next_index = (index + 1) % doe->protocol_num

> +
> +    pcie_doe_set_rsp(doe_cap, &rsp);
> +
> +    return DOE_SUCCESS;
> +}
> +
> +/* Callback for CMA */
> +static bool pcie_doe_cma_rsp(DOECap *doe_cap)
> +{
> +    doe_cap->status.error = 1;
> +
> +    memset(doe_cap->read_mbox, 0,
> +           PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +
> +    doe_cap->write_mbox_len = 0;
> +
> +    return DOE_DISCARD;
> +}
> +
> +/*
> + * DOE Utilities
> + */
> +static void pcie_doe_reset_mbox(DOECap *st)
> +{
> +    st->read_mbox_idx = 0;
> +
> +    st->read_mbox_len = 0;
> +    st->write_mbox_len = 0;
> +
> +    memset(st->read_mbox, 0, PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +    memset(st->write_mbox, 0, PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +}
> +
> +/*
> + * Initialize the list and protocol for a device.
> + * This function won't add the DOE capabitity to your PCIe device.
> + */
> +void pcie_doe_init(PCIDevice *dev, PCIEDOE *doe)
> +{
> +    doe->pdev = dev;
> +    doe->head = NULL;
> +    doe->protocol_num = 0;
> +
> +    /* Register two default protocol */
> +    //TODO : LINK LIST

Please do this for next rev of the patches.

> +    pcie_doe_register_protocol(doe, PCI_VENDOR_ID_PCI_SIG,
> +            PCI_SIG_DOE_DISCOVERY, pcie_doe_discovery_rsp);
> +    pcie_doe_register_protocol(doe, PCI_VENDOR_ID_PCI_SIG,
> +            PCI_SIG_DOE_CMA, pcie_doe_cma_rsp);
> +}
> +
> +int pcie_cap_doe_add(PCIEDOE *doe, uint16_t offset, bool intr, uint16_t vec) {
> +    DOECap *new_cap, **ptr;
> +    PCIDevice *dev = doe->pdev;
> +
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_DOE, PCI_DOE_VER, offset,
> +                        PCI_DOE_SIZEOF);
> +
> +    ptr = &doe->head;
> +    /* Insert the new DOE at the end of linked list */
> +    while (*ptr) {
> +        if (range_covers_byte((*ptr)->offset, PCI_DOE_SIZEOF, offset) ||
> +            (*ptr)->cap.vec == vec) {
> +            return -EINVAL;
> +        }
> +
> +        ptr = &(*ptr)->next;
> +    }
> +    new_cap = g_malloc0(sizeof(DOECap));
> +    *ptr = new_cap;
> +
> +    new_cap->doe = doe;
> +    new_cap->offset = offset;
> +    new_cap->next = NULL;
> +
> +    /* Configure MSI/MSI-X */
> +    if (intr && (msi_present(dev) || msix_present(dev))) {
> +        new_cap->cap.intr = intr;
> +        new_cap->cap.vec = vec;
> +    }
> +
> +    /* Set up W/R Mailbox buffer */
> +    new_cap->write_mbox = g_malloc0(PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +    new_cap->read_mbox = g_malloc0(PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +
> +    pcie_doe_reset_mbox(new_cap);
> +
> +    return 0;
> +}
> +
> +void pcie_doe_uninit(PCIEDOE *doe) {

fini is the more idiomatically unix name for de/un init.
> +    PCIDevice *dev = doe->pdev;
> +    DOECap *cap;
> +
> +    pci_del_capability(dev, PCI_EXT_CAP_ID_DOE, PCI_DOE_SIZEOF);
> +
> +    cap = doe->head;
> +    while (cap) {
> +        doe->head = doe->head->next;
> +
> +        g_free(cap->read_mbox);
> +        g_free(cap->write_mbox);
> +        cap->read_mbox = NULL;
> +        cap->write_mbox = NULL;
> +        g_free(cap);
> +        cap = doe->head;
> +    }
> +}
> +
> +void pcie_doe_register_protocol(PCIEDOE *doe, uint16_t vendor_id,
> +        uint8_t doe_type, bool (*set_rsp)(DOECap *))
> +{
> +    /* Protocol num should not exceed 256 */
> +    assert(doe->protocol_num < PCI_DOE_PROTOCOL_MAX);
> +
> +    doe->protocols[doe->protocol_num].vendor_id = vendor_id;
> +    doe->protocols[doe->protocol_num].doe_type = doe_type;
> +    doe->protocols[doe->protocol_num].set_rsp = set_rsp;
> +
> +    doe->protocol_num++;
> +}
> +
> +uint32_t pcie_doe_build_protocol(DOEProtocol *p)
> +{
> +    return DATA_OBJ_BUILD_HEADER1(p->vendor_id, p->doe_type);
> +}
> +
> +/* Return the pointer of DOE request in write mailbox buffer */
> +void *pcie_doe_get_req(DOECap *doe_cap)
> +{
> +    return doe_cap->write_mbox;
> +}
> +
> +/* Copy the response to read mailbox buffer */
> +void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp)
> +{
> +    uint32_t len = pcie_doe_object_len(rsp);
> +
> +    memcpy(doe_cap->read_mbox + doe_cap->read_mbox_len,
> +           rsp, len * sizeof(uint32_t));
> +    doe_cap->read_mbox_len += len;
> +}
> +
> +/* Get Data Object length */
> +uint32_t pcie_doe_object_len(void *obj)
> +{
> +    return (obj)? ((DOEHeader *)obj)->length : 0;
> +}
> +
> +static void pcie_doe_write_mbox(DOECap *doe_cap, uint32_t val)
> +{
> +    memcpy(doe_cap->write_mbox + doe_cap->write_mbox_len, &val, sizeof(uint32_t));

doe_cap->write_mbox[doe_cap->write_mbox_len] = val?

> +
> +    if (doe_cap->write_mbox_len == 1) {
> +        DOE_DBG("  Capture DOE request DO length = %d\n", val & 0x0003ffff);
> +    }

I don't have the spec in front of me, but this is begging for a comment on why 1
is special.

> +
> +    doe_cap->write_mbox_len++;
> +}
> +
> +static void pcie_doe_irq_assert(DOECap *doe_cap)
> +{
> +    PCIDevice *dev = doe_cap->doe->pdev;
> +
> +    if (doe_cap->cap.intr && doe_cap->ctrl.intr) {
> +        /* Interrupt notify */
> +        if (msix_enabled(dev)) {
> +            msix_notify(dev, doe_cap->cap.vec);
> +        } else if (msi_enabled(dev)) {
> +            msi_notify(dev, doe_cap->cap.vec);
> +        }
> +        /* Not support legacy IRQ */
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
> +DOECap *pcie_doe_covers_addr(PCIEDOE *doe, uint32_t addr)
> +{
> +    DOECap *ptr = doe->head;
> +
> +    /* If overlaps DOE range. PCIe Capability Header won't be included. */
> +    while (ptr && 
> +           !range_covers_byte(ptr->offset + PCI_EXP_DOE_CAP, PCI_DOE_SIZEOF - 4, addr)) {
> +        ptr = ptr->next;
> +    }
> +    
> +    return ptr;
> +}
> +
> +uint32_t pcie_doe_read_config(DOECap *doe_cap,
> +                              uint32_t addr, int size)
> +{
> +    uint32_t ret = 0, shift, mask = 0xFFFFFFFF;
> +    uint16_t doe_offset = doe_cap->offset;
> +
> +    /* If overlaps DOE range. PCIe Capability Header won't be included. */
> +    if (range_covers_byte(doe_offset + PCI_EXP_DOE_CAP, PCI_DOE_SIZEOF - 4, addr)) {
> +        addr -= doe_offset;
> +
> +        if (range_covers_byte(PCI_EXP_DOE_CAP, sizeof(uint32_t), addr)) {
> +            ret = FIELD_DP32(ret, PCI_DOE_CAP_REG, INTR_SUPP,
> +                             doe_cap->cap.intr);
> +            ret = FIELD_DP32(ret, PCI_DOE_CAP_REG, DOE_INTR_MSG_NUM,
> +                             doe_cap->cap.vec);
> +        } else if (range_covers_byte(PCI_EXP_DOE_CTRL, sizeof(uint32_t), addr)) {
> +            /* Must return ABORT=0 and GO=0 */
> +            ret = FIELD_DP32(ret, PCI_DOE_CAP_CONTROL, DOE_INTR_EN,
> +                             doe_cap->ctrl.intr);
> +            DOE_DBG("  CONTROL REG=%x\n", ret);
> +        } else if (range_covers_byte(PCI_EXP_DOE_STATUS, sizeof(uint32_t), addr)) {
> +            ret = FIELD_DP32(ret, PCI_DOE_CAP_STATUS, DOE_BUSY,
> +                             doe_cap->status.busy);
> +            ret = FIELD_DP32(ret, PCI_DOE_CAP_STATUS, DOE_INTR_STATUS,
> +                             doe_cap->status.intr);
> +            ret = FIELD_DP32(ret, PCI_DOE_CAP_STATUS, DOE_ERROR,
> +                             doe_cap->status.error);
> +            ret = FIELD_DP32(ret, PCI_DOE_CAP_STATUS, DATA_OBJ_RDY,
> +                             doe_cap->status.ready);
> +        } else if (range_covers_byte(PCI_EXP_DOE_RD_DATA_MBOX, sizeof(uint32_t), addr)) {
> +            /* Check that READY is set */
> +            if (!doe_cap->status.ready) {
> +                /* Return 0 if not ready */
> +                DOE_DBG("  RD MBOX RETURN=%x\n", ret);
> +            } else {
> +                /* Deposit next DO DW into read mbox */
> +                DOE_DBG("  RD MBOX, DATA OBJECT READY,"
> +                        " CURRENT DO DW OFFSET=%x\n",
> +                        doe_cap->read_mbox_idx);
> +
> +                ret = doe_cap->read_mbox[doe_cap->read_mbox_idx];
> +
> +                DOE_DBG("  RD MBOX DW=%x\n", ret);
> +                DOE_DBG("  RD MBOX DW OFFSET=%d, RD MBOX LENGTH=%d\n",
> +                        doe_cap->read_mbox_idx, doe_cap->read_mbox_len);
> +            }
> +        } else if (range_covers_byte(PCI_EXP_DOE_WR_DATA_MBOX, sizeof(uint32_t), addr)) {
> +            DOE_DBG("  WR MBOX, local_val =%x\n", ret);
> +        }
> +    }
> +
> +    /* Alignment */
> +    shift = addr % sizeof(uint32_t);

Can these actually be unaligned? The whole range_covers_byte() stuff could go
away if not.

> +    if (shift) {
> +        ret >>= shift * 8;
> +    }
> +    mask >>= (sizeof(uint32_t) - size) * 8;
> +
> +    return ret & mask;
> +}
> +
> +void pcie_doe_write_config(DOECap *doe_cap,
> +                           uint32_t addr, uint32_t val, int size)
> +{
> +    PCIEDOE *doe = doe_cap->doe;
> +    uint16_t doe_offset = doe_cap->offset;
> +    int p;
> +    bool discard;
> +    uint32_t shift;
> +
> +    DOE_DBG("  addr=%x, val=%x, size=%x\n", addr, val, size);
> +
> +    /* If overlaps DOE range. PCIe Capability Header won't be included. */
> +    if (range_covers_byte(doe_offset + PCI_EXP_DOE_CAP, PCI_DOE_SIZEOF - 4, addr)) {
> +        /* Alignment */
> +        shift = addr % sizeof(uint32_t);
> +        addr -= (doe_offset - shift);
> +        val <<= shift * 8;
> +
> +        switch (addr) {
> +        case PCI_EXP_DOE_CTRL:
> +            DOE_DBG("  CONTROL=%x\n", val);
> +            if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_ABORT)) {
> +                /* If ABORT, clear status reg DOE Error and DOE Ready */
> +                DOE_DBG("  Setting ABORT\n");
> +                pcie_doe_set_ready(doe_cap, 0);
> +                pcie_doe_set_error(doe_cap, 0);
> +                pcie_doe_reset_mbox(doe_cap);
> +            } else if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_GO)) {
> +                DOE_DBG("  CONTROL GO=%x\n", val);
> +                /*
> +                 * Check protocol the incoming request in write_mbox and
> +                 * memcpy the corresponding response to read_mbox.
> +                 *
> +                 * "discard" should be set up if the response callback
> +                 * function could not deal with request (e.g. length
> +                 * mismatch) or the protocol of request was not found.
> +                 */
> +                discard = DOE_DISCARD;
> +                for (p = 0; p < doe->protocol_num; p++) {
> +                    if (doe_cap->write_mbox[0] ==
> +                        pcie_doe_build_protocol(&doe->protocols[p])) {
> +                        /* Found */
> +                        DOE_DBG("  DOE PROTOCOL=%x\n", doe_cap->write_mbox[0]);
> +                        /*
> +                         * Spec:
> +                         * If the number of DW transferred does not match the
> +                         * indicated Length for a data object, then the
> +                         * data object must be silently discarded.
> +                         */
> +                        if (doe_cap->write_mbox_len ==
> +                            pcie_doe_object_len(pcie_doe_get_req(doe_cap)))
> +                            discard = doe->protocols[p].set_rsp(doe_cap);
> +                        break;
> +                    }
> +                }
> +
> +                /* Set DOE Ready */
> +                if (!discard) {
> +                    pcie_doe_set_ready(doe_cap, 1);
> +                } else {
> +                    pcie_doe_reset_mbox(doe_cap);
> +                }
> +            } else if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_INTR_EN)) {
> +                doe_cap->ctrl.intr = 1;
> +            }
> +            break;
> +        case PCI_EXP_DOE_RD_DATA_MBOX:
> +            /* Read MBOX */
> +            DOE_DBG("  INCR RD MBOX DO DW OFFSET=%d\n", doe_cap->read_mbox_idx);
> +            doe_cap->read_mbox_idx += 1;
> +            /* Last DW */
> +            if (doe_cap->read_mbox_idx >= doe_cap->read_mbox_len) {
> +                pcie_doe_reset_mbox(doe_cap);
> +                pcie_doe_set_ready(doe_cap, 0);
> +            }
> +            break;
> +        case PCI_EXP_DOE_WR_DATA_MBOX:
> +            /* Write MBOX */
> +            DOE_DBG("  WR MBOX=%x, DW OFFSET = %d\n", val, doe_cap->write_mbox_len);
> +            pcie_doe_write_mbox(doe_cap, val);
> +            break;
> +        case PCI_EXP_DOE_STATUS:
> +        case PCI_EXP_DOE_CAP:
> +        default:
> +            break;
> +        }
> +    }
> +}
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 76bf3ed..636b2e8 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -157,6 +157,8 @@
>  
>  /* Vendors and devices.  Sort key: vendor first, device next. */
>  
> +#define PCI_VENDOR_ID_PCI_SIG            0x0001
> +
>  #define PCI_VENDOR_ID_LSI_LOGIC          0x1000
>  #define PCI_DEVICE_ID_LSI_53C810         0x0001
>  #define PCI_DEVICE_ID_LSI_53C895A        0x0012
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
> index 0000000..f497075
> --- /dev/null
> +++ b/include/hw/pci/pcie_doe.h
> @@ -0,0 +1,166 @@
> +#ifndef PCIE_DOE_H
> +#define PCIE_DOE_H
> +
> +#include "qemu/range.h"
> +#include "qemu/typedefs.h"
> +#include "hw/register.h"
> +
> +/* 
> + * PCI DOE register defines 7.9.xx 
> + */

Whitespace issues

> +/* DOE Capabilities Register */
> +#define PCI_EXP_DOE_CAP             0x04
> +REG32(PCI_DOE_CAP_REG, 0)
> +    FIELD(PCI_DOE_CAP_REG, INTR_SUPP, 0, 1)
> +    FIELD(PCI_DOE_CAP_REG, DOE_INTR_MSG_NUM, 1, 11)
> +
> +/* DOE Control Register */
> +#define PCI_EXP_DOE_CTRL            0x08
> +REG32(PCI_DOE_CAP_CONTROL, 0)
> +    FIELD(PCI_DOE_CAP_CONTROL, DOE_ABORT, 0, 1)
> +    FIELD(PCI_DOE_CAP_CONTROL, DOE_INTR_EN, 1, 1)
> +    FIELD(PCI_DOE_CAP_CONTROL, DOE_GO, 31, 1)
> +
> +/* DOE Status Register  */
> +#define PCI_EXP_DOE_STATUS          0x0c
> +REG32(PCI_DOE_CAP_STATUS, 0)
> +    FIELD(PCI_DOE_CAP_STATUS, DOE_BUSY, 0, 1)
> +    FIELD(PCI_DOE_CAP_STATUS, DOE_INTR_STATUS, 1, 1)
> +    FIELD(PCI_DOE_CAP_STATUS, DOE_ERROR, 2, 1)
> +    FIELD(PCI_DOE_CAP_STATUS, DATA_OBJ_RDY, 31, 1)
> +
> +/* DOE Write Data Mailbox Register  */
> +#define PCI_EXP_DOE_WR_DATA_MBOX    0x10
> +
> +/* DOE Read Data Mailbox Register  */
> +#define PCI_EXP_DOE_RD_DATA_MBOX    0x14
> +
> +/* 
> + * PCI DOE register defines 7.9.xx 
> + */

Is this duplicated on purpose?

> +/* Table 7-x2 */
> +#define PCI_SIG_DOE_DISCOVERY       0x00
> +#define PCI_SIG_DOE_CMA             0x01
> +
> +#define DATA_OBJ_BUILD_HEADER1(v, p)  ((p << 16) | v)
> +
> +/* Figure 6-x1 */
> +#define DATA_OBJECT_HEADER1_OFFSET  0
> +#define DATA_OBJECT_HEADER2_OFFSET  1
> +#define DATA_OBJECT_CONTENT_OFFSET  2
> +
> +#define PCI_DOE_MAX_DW_SIZE (1 << 18)
> +#define PCI_DOE_PROTOCOL_MAX 256
> +
> +/*
> + * Self-defined Marco
> + */
> +/* Request/Response State */
> +#define DOE_SUCCESS 0
> +#define DOE_DISCARD 1
> +
> +/* An invalid vector number for MSI/MSI-x */
> +#define DOE_NO_INTR (~0)
> +
> +/*
> + * DOE Protocol - Data Object
> + */
> +typedef struct DOEHeader DOEHeader;
> +typedef struct DOEProtocol DOEProtocol;
> +typedef struct PCIEDOE PCIEDOE;
> +typedef struct DOECap DOECap;
> +
> +struct DOEHeader {
> +    uint16_t vendor_id;
> +    uint8_t doe_type;
> +    uint8_t reserved;
> +    struct {
> +        uint32_t length:18;
> +        uint32_t reserved2:14;
> +    };
> +} QEMU_PACKED;
> +
> +/* Protocol infos and rsp function callback */
> +struct DOEProtocol {
> +    uint16_t vendor_id;
> +    uint8_t doe_type;
> +
> +    bool (*set_rsp)(DOECap *);
> +};
> +
> +struct PCIEDOE {
> +    PCIDevice *pdev;
> +    DOECap *head;
> +
> +    /* Protocols and its callback response */
> +    DOEProtocol protocols[PCI_DOE_PROTOCOL_MAX];
> +    uint32_t protocol_num;
> +};
> +
> +struct DOECap {
> +    PCIEDOE *doe;
> +
> +    /* Capability offset */
> +    uint16_t offset;
> +
> +    /* Next DOE capability */
> +    DOECap *next;
> +
> +    /* Capability */
> +    struct {
> +        bool intr;
> +        uint16_t vec;
> +    } cap;
> +
> +    /* Control */
> +    struct {
> +        bool abort;
> +        bool intr;
> +        bool go;
> +    } ctrl;
> +
> +    /* Status */
> +    struct {
> +        bool busy;
> +        bool intr;
> +        bool error;
> +        bool ready;
> +    } status;
> +
> +    /* Mailbox buffer for device */
> +    uint32_t *write_mbox;
> +    uint32_t *read_mbox;
> +
> +    /* Mailbox position indicator */
> +    uint32_t read_mbox_idx;
> +    uint32_t read_mbox_len;
> +    uint32_t write_mbox_len;
> +};
> +
> +void pcie_doe_init(PCIDevice *dev, PCIEDOE *doe);
> +int pcie_cap_doe_add(PCIEDOE *doe, uint16_t offset, bool intr, uint16_t vec);
> +void pcie_doe_uninit(PCIEDOE *doe);
> +void pcie_doe_register_protocol(PCIEDOE *doe, uint16_t vendor_id,
> +                                uint8_t doe_type,
> +                                bool (*set_rsp)(DOECap *));
> +uint32_t pcie_doe_build_protocol(DOEProtocol *p);
> +DOECap *pcie_doe_covers_addr(PCIEDOE *doe, uint32_t addr);
> +uint32_t pcie_doe_read_config(DOECap *doe_cap, uint32_t addr, int size);
> +void pcie_doe_write_config(DOECap *doe_cap, uint32_t addr,
> +                           uint32_t val, int size);
> +
> +/* Utility functions for set_rsp in DOEProtocol */
> +void *pcie_doe_get_req(DOECap *doe_cap);
> +void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp);
> +uint32_t pcie_doe_object_len(void *obj);
> +
> +#define DOE_DEBUG
> +#ifdef DOE_DEBUG
> +#define DOE_DBG(...) printf(__VA_ARGS__)
> +#else
> +#define DOE_DBG(...) {}
> +#endif
> +
> +#define dwsizeof(s) ((sizeof(s) + 4 - 1) / 4)
> +
> +#endif /* PCIE_DOE_H */
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 1db86b0..963dc2e 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -179,4 +179,8 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_ACS_VER                     0x1
>  #define PCI_ACS_SIZEOF                  8
>  > +/* DOE Capability Register Fields */
> +#define PCI_DOE_VER                     0x1
> +#define PCI_DOE_SIZEOF                  24
> +
>  #endif /* QEMU_PCIE_REGS_H */
> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
> index e709ae8..4a7b7a4 100644
> --- a/include/standard-headers/linux/pci_regs.h
> +++ b/include/standard-headers/linux/pci_regs.h
> @@ -730,7 +730,8 @@
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> +#define PCI_EXT_CAP_ID_DOE      0x2E    /* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40

I haven't reviewed the spec stuff, but I assume Jonathan is familiar with that
and probably knows it almost by heart already.

> -- 
> 1.8.3.1
> 
> 
