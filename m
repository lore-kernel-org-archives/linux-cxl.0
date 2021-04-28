Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20EDC433ED
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Apr 2021 13:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A64613CE
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Apr 2021 13:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbhD1N1X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:27:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2936 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbhD1N1X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 28 Apr 2021 09:27:23 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVfJw5SDrz72f5N;
        Wed, 28 Apr 2021 21:16:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 15:26:36 +0200
Received: from localhost (10.52.123.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Apr
 2021 14:26:35 +0100
Date:   Wed, 28 Apr 2021 14:25:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <mst@redhat.com>, <ben.widawsky@intel.com>, <david@redhat.com>,
        <qemu-devel@nongnu.org>, <vishal.l.verma@intel.com>,
        <jgroves@micron.com>, <armbru@redhat.com>,
        <linux-cxl@vger.kernel.org>, <f4bug@amsat.org>,
        <hchkuo@avery-design.com.tw>, <tyshao@avery-design.com.tw>,
        <imammedo@redhat.com>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH v5 cxl2.0-v3-doe 3/6] hw/pci: PCIe Data Object Exchange
 implementation
Message-ID: <20210428142501.00002825@Huawei.com>
In-Reply-To: <1619458099-13734-1-git-send-email-cbrowy@avery-design.com>
References: <1619454964-10190-1-git-send-email-cbrowy@avery-design.com>
        <1619458099-13734-1-git-send-email-cbrowy@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.69]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 26 Apr 2021 13:28:19 -0400
Chris Browy <cbrowy@avery-design.com> wrote:

> From: hchkuo <hchkuo@avery-design.com.tw>
> 
> PCIe Data Object Exchange (DOE) implementation for QEMU referring to
> "PCIe Data Object Exchange ECN, March 12, 2020".
> 
> The patch supports multiple DOE capabilities for a single PCIe device in
> QEMU. For each capability, a static array of DOEProtocol should be
> passed to pcie_doe_init(). The protocols in that array will be
> registered under the DOE capability structure. For each protocol, vendor
> ID, type, and corresponding callback function (handle_request()) should
> be implemented. This callback function represents how the DOE request
> for corresponding protocol will be handled.
> 
> pcie_doe_{read/write}_config() must be appended to corresponding PCI
> device's config_read/write() handler to enable DOE access. In
> pcie_doe_read_config(), false will be returned if pci_config_read()
> offset is not within DOE capability range. In pcie_doe_write_config(),
> the function will be early returned if not within the related DOE range.
> 
> Signed-off-by: Chris Browy <cbrowy@avery-design.com>

You probably also want Huai-Cheng Kuo's sign-off to match the From on this
series - otherwise the DCO chain is a little unclear.

Subject to a few things I've commented on inline...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  MAINTAINERS               |   7 +
>  hw/pci/meson.build        |   1 +
>  hw/pci/pcie_doe.c         | 374 ++++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pcie.h     |   1 +
>  include/hw/pci/pcie_doe.h | 123 +++++++++++++
>  5 files changed, 506 insertions(+)
>  create mode 100644 hw/pci/pcie_doe.c
>  create mode 100644 include/hw/pci/pcie_doe.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f9097ed9e7..e77e9892e3 100644
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
> index 5c4bbac817..115e50222f 100644
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
> index 0000000000..b2affff933
> --- /dev/null
> +++ b/hw/pci/pcie_doe.c
> @@ -0,0 +1,374 @@
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
> +#define DWORD_BYTE 4
> +#define BYTE_LSHIFT(b, pos) (b << ((pos) * 8))
> +#define BYTE_RSHIFT(b, pos) (b >> ((pos) * 8))
> +
> +struct doe_discovery_req {
> +    DOEHeader header;
> +    uint8_t index;
> +    uint8_t reserved[3];
> +} QEMU_PACKED;
> +
> +struct doe_discovery_rsp {
> +    DOEHeader header;
> +    uint16_t vendor_id;
> +    uint8_t data_obj_type;
> +    uint8_t next_index;
> +} QEMU_PACKED;
> +
> +static bool pcie_doe_discovery(DOECap *doe_cap)
> +{
> +    struct doe_discovery_req *req = pcie_doe_get_write_mbox_ptr(doe_cap);
> +    struct doe_discovery_rsp rsp;
> +    uint8_t index = req->index;
> +    DOEProtocol *prot;
> +
> +    /* Discard request if length does not match doe_discovery */
> +    if (pcie_doe_get_obj_len(req) <
> +        DIV_ROUND_UP(sizeof(struct doe_discovery_req), DWORD_BYTE)) {

I'm a bit in two minds here, but maybe sizeof(*req) is better in this
case.  It looks a bit odd if you do though as querying the length of
itself to compare with actual length.

> +        return false;
> +    }
> +
> +    rsp.header = (DOEHeader) {
> +        .vendor_id = PCI_VENDOR_ID_PCI_SIG,
> +        .data_obj_type = PCI_SIG_DOE_DISCOVERY,
> +        .length = DIV_ROUND_UP(sizeof(struct doe_discovery_rsp), DWORD_BYTE),
> +    };
> +
> +    /* Point to the requested protocol, index 0 must be Discovery */
> +    if (index == 0) {
> +        rsp.vendor_id = PCI_VENDOR_ID_PCI_SIG;
> +        rsp.data_obj_type = PCI_SIG_DOE_DISCOVERY;
> +    } else {
> +        if (index < doe_cap->protocol_num) {
> +            prot = &doe_cap->protocols[index - 1];
> +            rsp.vendor_id = prot->vendor_id;
> +            rsp.data_obj_type = prot->data_obj_type;
> +        } else {
> +            rsp.vendor_id = 0xFFFF;
> +            rsp.data_obj_type = 0xFF;
> +        }
> +    }
> +
> +    if (index + 1 == doe_cap->protocol_num) {
> +        rsp.next_index = 0;
> +    } else {
> +        rsp.next_index = index + 1;
> +    }
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
> +    memset(st->read_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
> +    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
> +}
> +
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
> +    doe_cap->write_mbox = g_malloc0(PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
> +    doe_cap->read_mbox = g_malloc0(PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
> +
> +    pcie_doe_reset_mbox(doe_cap);
> +
> +    /* Register self-defined protocols */
> +    doe_cap->protocols = protocols;
> +    for (; protocols->vendor_id; protocols++) {
> +        doe_cap->protocol_num++;
> +    }
> +    assert(doe_cap->protocol_num < PCI_DOE_PROTOCOL_NUM_MAX);
> +
> +    /* Increment discovery protocol */
> +    doe_cap->protocol_num++;
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
> +void *pcie_doe_get_write_mbox_ptr(DOECap *doe_cap)
> +{
> +    return doe_cap->write_mbox;
> +}
> +
> +/*
> + * Copy the response to read mailbox buffer
> + * This might be called in self-defined handle_request() if a DOE response is
> + * required in the corresponding protocol
> + */
> +void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp)
> +{
> +    uint32_t len = pcie_doe_get_obj_len(rsp);
> +
> +    memcpy(doe_cap->read_mbox + doe_cap->read_mbox_len, rsp, len * DWORD_BYTE);
> +    doe_cap->read_mbox_len += len;
> +}
> +
> +uint32_t pcie_doe_get_obj_len(void *obj)
> +{
> +    uint32_t len;
> +
> +    if (!obj) {
> +        return 0;
> +    }
> +
> +    /* Only lower 18 bits are valid */
> +    len = DATA_OBJ_LEN_MASK(((DOEHeader *)obj)->length);
> +
> +    /* DOE ECN Table 7-x1b: a value of 00000h indicates 2^18 DW */
> +    return (len) ? len : PCI_DOE_DW_SIZE_MAX;
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
> + * Check incoming request in write_mbox for protocol format
> + */
> +static void pcie_doe_prepare_rsp(DOECap *doe_cap)
> +{
> +    bool success = false;
> +    int p;
> +    bool (*handle_request)(DOECap *) = NULL;
> +
> +    if (doe_cap->status.error) {
> +        return;
> +    }
> +
> +    if (doe_cap->write_mbox[0] ==
> +        DATA_OBJ_BUILD_HEADER1(PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_DISCOVERY)) {
> +        handle_request = pcie_doe_discovery;
> +    } else {
> +        for (p = 0; p < doe_cap->protocol_num - 1; p++) {
> +            if (doe_cap->write_mbox[0] ==
> +                pcie_doe_build_protocol(&doe_cap->protocols[p])) {
> +                handle_request = doe_cap->protocols[p].handle_request;
> +                break;
> +            }
> +        }
> +    }
> +
> +    /*
> +     * DOE ECN 6.xx.1:
> +     * If the number of DW transferred does not match the
> +     * indicated Length for a data object, then the
> +     * data object must be silently discarded.
> +     */
> +    if (doe_cap->write_mbox_len ==
> +        pcie_doe_get_obj_len(pcie_doe_get_write_mbox_ptr(doe_cap))) {
> +        success = handle_request(doe_cap);

Superficially looks like there is no protection on handle_request == NULL.
Whilst it might not be possible, that's not locally apparent so perhaps
add a sanity check here.

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
> + * Return false if the address not within DOE_CAP range.
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
> +    if (range_covers_byte(PCI_EXP_DOE_CAP, DWORD_BYTE, addr)) {
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_REG, INTR_SUPP,
> +                          doe_cap->cap.intr);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_REG, DOE_INTR_MSG_NUM,
> +                          doe_cap->cap.vec);
> +    } else if (range_covers_byte(PCI_EXP_DOE_CTRL, DWORD_BYTE, addr)) {
> +        /* Must return ABORT=0 and GO=0 */
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_CONTROL, DOE_INTR_EN,
> +                          doe_cap->ctrl.intr);
> +    } else if (range_covers_byte(PCI_EXP_DOE_STATUS, DWORD_BYTE, addr)) {
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_BUSY,
> +                          doe_cap->status.busy);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_INTR_STATUS,
> +                          doe_cap->status.intr);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_ERROR,
> +                          doe_cap->status.error);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DATA_OBJ_RDY,
> +                          doe_cap->status.ready);
> +    /* Mailbox should be DW accessed */
> +    } else if (addr == PCI_EXP_DOE_RD_DATA_MBOX && size == DWORD_BYTE) {
> +        if (doe_cap->status.ready && !doe_cap->status.error) {
> +            *buf = doe_cap->read_mbox[doe_cap->read_mbox_idx];
> +        }
> +    }
> +
> +    /* Process Alignment */
> +    shift = addr % DWORD_BYTE;
> +    *buf = BYTE_RSHIFT(*buf, shift);
> +    mask = BYTE_RSHIFT(mask, DWORD_BYTE - size);
> +    *buf &= mask;
> +
> +    return true;
> +}
> +
> +/*
> + * Write to DOE config space.
> + * Return if the address not within DOE_CAP range or receives an abort
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
> +    /* Process Alignment */
> +    shift = addr % DWORD_BYTE;
> +    addr -= (doe_offset + shift);
> +    val = BYTE_LSHIFT(val, shift);
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
> +        /* Mailbox should be DW accessed */
> +        if (size != DWORD_BYTE) {
> +            return;
> +        }
> +        doe_cap->read_mbox_idx++;
> +        if (doe_cap->read_mbox_idx == doe_cap->read_mbox_len) {
> +            pcie_doe_reset_mbox(doe_cap);
> +            pcie_doe_set_ready(doe_cap, 0);
> +        } else if (doe_cap->read_mbox_idx > doe_cap->read_mbox_len) {
> +            /* Underflow */
> +            pcie_doe_set_error(doe_cap, 1);
> +        }
> +        break;
> +    case PCI_EXP_DOE_WR_DATA_MBOX:
> +        /* Mailbox should be DW accessed */
> +        if (size != DWORD_BYTE) {
> +            return;
> +        }
> +        doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
> +        doe_cap->write_mbox_len++;
> +        break;
> +    case PCI_EXP_DOE_CAP:
> +        /* fallthrough */
> +    default:
> +        break;
> +    }
> +}
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 14c58ebdb6..47d6f66e52 100644
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
> index 0000000000..dc2c872f4d
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
> +
> +#define PCI_DOE_DW_SIZE_MAX         (1 << 18)
> +#define PCI_DOE_PROTOCOL_NUM_MAX    256
> +
> +#define DATA_OBJ_BUILD_HEADER1(v, p)    ((p << 16) | v)
> +#define DATA_OBJ_LEN_MASK(l)        (l & (PCI_DOE_DW_SIZE_MAX - 1))

in Macros, parameters passed in should have () around them to avoid running
into unexpected precedence issues.  Eg DATA_OBJ_LEN_MASK((1 << 32) + 4) is not
going to do what you'd expect.

#define DATA_OBJ_LEN_MASK(l)	((l) & (PCI_DOE_DW_SIZE_MASK - 1);

l is also a nasty character to use, so maybe len is more appropriate so the
eye can't parse it as 1.

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
> +    bool (*handle_request)(DOECap *);
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
> +void *pcie_doe_get_write_mbox_ptr(DOECap *doe_cap);
> +void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp);
> +uint32_t pcie_doe_get_obj_len(void *obj);
> +#endif /* PCIE_DOE_H */

