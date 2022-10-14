Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF3C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Oct 2022 15:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJNPLP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJNPLP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Oct 2022 11:11:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFC751A17
        for <linux-cxl@vger.kernel.org>; Fri, 14 Oct 2022 08:11:13 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MpqZN5ZWpz67P5L;
        Fri, 14 Oct 2022 23:10:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 17:11:11 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 16:11:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>,
        "Gregory Price" <gregory.price@memverge.com>, <ira.weiny@intel.com>
CC:     <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v9 1/5] hw/pci: PCIe Data Object Exchange emulation
Date:   Fri, 14 Oct 2022 16:10:41 +0100
Message-ID: <20221014151045.24781-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221014151045.24781-1-Jonathan.Cameron@huawei.com>
References: <20221014151045.24781-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>

Emulation of PCIe Data Object Exchange (DOE)
PCIE Base Specification r6.0 6.3 Data Object Exchange

Supports multiple DOE PCIe Extended Capabilities for a single PCIe
device. For each capability, a static array of DOEProtocol should be passed
to pcie_doe_init(). The protocols in that array will be registered under
the DOE capability structure. For each protocol, vendor ID, type, and
corresponding callback function (handle_request()) should be implemented.
This callback function represents how the DOE request for corresponding
protocol will be handled.

pcie_doe_{read/write}_config() must be appended to corresponding PCI
device's config_read/write() handler to enable DOE access. In
pcie_doe_read_config(), false will be returned if pci_config_read()
offset is not within DOE capability range. In pcie_doe_write_config(),
the function will have no affect if the address is not within the related
DOE PCIE extended capability.

Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Signed-off-by: Chris Browy <cbrowy@avery-design.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS                |   7 +
 hw/pci/meson.build         |   1 +
 hw/pci/pcie_doe.c          | 367 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_ids.h   |   3 +
 include/hw/pci/pcie.h      |   1 +
 include/hw/pci/pcie_doe.h  | 123 +++++++++++++
 include/hw/pci/pcie_regs.h |   4 +
 7 files changed, 506 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ae2e43c83..562e1d02a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1832,6 +1832,13 @@ F: qapi/pci.json
 F: docs/pci*
 F: docs/specs/*pci*
 
+PCIE DOE
+M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
+M: Chris Browy <cbrowy@avery-design.com>
+S: Supported
+F: include/hw/pci/pcie_doe.h
+F: hw/pci/pcie_doe.c
+
 ACPI/SMBIOS
 M: Michael S. Tsirkin <mst@redhat.com>
 M: Igor Mammedov <imammedo@redhat.com>
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index bcc9c75919..5aff7ed1c6 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -13,6 +13,7 @@ pci_ss.add(files(
 # allow plugging PCIe devices into PCI buses, include them even if
 # CONFIG_PCI_EXPRESS=n.
 pci_ss.add(files('pcie.c', 'pcie_aer.c'))
+pci_ss.add(files('pcie_doe.c'))
 softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
 softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
new file mode 100644
index 0000000000..2210f86968
--- /dev/null
+++ b/hw/pci/pcie_doe.c
@@ -0,0 +1,367 @@
+/*
+ * PCIe Data Object Exchange
+ *
+ * Copyright (C) 2021 Avery Design Systems, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qemu/range.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_doe.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+
+#define DWORD_BYTE 4
+
+typedef struct DoeDiscoveryReq {
+    DOEHeader header;
+    uint8_t index;
+    uint8_t reserved[3];
+} QEMU_PACKED DoeDiscoveryReq;
+
+typedef struct DoeDiscoveryRsp {
+    DOEHeader header;
+    uint16_t vendor_id;
+    uint8_t data_obj_type;
+    uint8_t next_index;
+} QEMU_PACKED DoeDiscoveryRsp;
+
+static bool pcie_doe_discovery(DOECap *doe_cap)
+{
+    DoeDiscoveryReq *req = pcie_doe_get_write_mbox_ptr(doe_cap);
+    DoeDiscoveryRsp rsp;
+    uint8_t index = req->index;
+    DOEProtocol *prot;
+
+    /* Discard request if length does not match DoeDiscoveryReq */
+    if (pcie_doe_get_obj_len(req) <
+        DIV_ROUND_UP(sizeof(DoeDiscoveryReq), DWORD_BYTE)) {
+        return false;
+    }
+
+    rsp.header = (DOEHeader) {
+        .vendor_id = PCI_VENDOR_ID_PCI_SIG,
+        .data_obj_type = PCI_SIG_DOE_DISCOVERY,
+        .length = DIV_ROUND_UP(sizeof(DoeDiscoveryRsp), DWORD_BYTE),
+    };
+
+    /* Point to the requested protocol, index 0 must be Discovery */
+    if (index == 0) {
+        rsp.vendor_id = PCI_VENDOR_ID_PCI_SIG;
+        rsp.data_obj_type = PCI_SIG_DOE_DISCOVERY;
+    } else {
+        if (index < doe_cap->protocol_num) {
+            prot = &doe_cap->protocols[index - 1];
+            rsp.vendor_id = prot->vendor_id;
+            rsp.data_obj_type = prot->data_obj_type;
+        } else {
+            rsp.vendor_id = 0xFFFF;
+            rsp.data_obj_type = 0xFF;
+        }
+    }
+
+    if (index + 1 == doe_cap->protocol_num) {
+        rsp.next_index = 0;
+    } else {
+        rsp.next_index = index + 1;
+    }
+
+    pcie_doe_set_rsp(doe_cap, &rsp);
+
+    return true;
+}
+
+static void pcie_doe_reset_mbox(DOECap *st)
+{
+    st->read_mbox_idx = 0;
+    st->read_mbox_len = 0;
+    st->write_mbox_len = 0;
+
+    memset(st->read_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+}
+
+void pcie_doe_init(PCIDevice *dev, DOECap *doe_cap, uint16_t offset,
+                   DOEProtocol *protocols, bool intr, uint16_t vec)
+{
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_DOE, 0x1, offset,
+                        PCI_DOE_SIZEOF);
+
+    doe_cap->pdev = dev;
+    doe_cap->offset = offset;
+
+    if (intr && (msi_present(dev) || msix_present(dev))) {
+        doe_cap->cap.intr = intr;
+        doe_cap->cap.vec = vec;
+    }
+
+    doe_cap->write_mbox = g_malloc0(PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+    doe_cap->read_mbox = g_malloc0(PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
+
+    pcie_doe_reset_mbox(doe_cap);
+
+    doe_cap->protocols = protocols;
+    for (; protocols->vendor_id; protocols++) {
+        doe_cap->protocol_num++;
+    }
+    assert(doe_cap->protocol_num < PCI_DOE_PROTOCOL_NUM_MAX);
+
+    /* Increment to allow for the discovery protocol */
+    doe_cap->protocol_num++;
+}
+
+void pcie_doe_fini(DOECap *doe_cap)
+{
+    g_free(doe_cap->read_mbox);
+    g_free(doe_cap->write_mbox);
+    g_free(doe_cap);
+}
+
+uint32_t pcie_doe_build_protocol(DOEProtocol *p)
+{
+    return DATA_OBJ_BUILD_HEADER1(p->vendor_id, p->data_obj_type);
+}
+
+void *pcie_doe_get_write_mbox_ptr(DOECap *doe_cap)
+{
+    return doe_cap->write_mbox;
+}
+
+/*
+ * Copy the response to read mailbox buffer
+ * This might be called in self-defined handle_request() if a DOE response is
+ * required in the corresponding protocol
+ */
+void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp)
+{
+    uint32_t len = pcie_doe_get_obj_len(rsp);
+
+    memcpy(doe_cap->read_mbox + doe_cap->read_mbox_len, rsp, len * DWORD_BYTE);
+    doe_cap->read_mbox_len += len;
+}
+
+uint32_t pcie_doe_get_obj_len(void *obj)
+{
+    uint32_t len;
+
+    if (!obj) {
+        return 0;
+    }
+
+    /* Only lower 18 bits are valid */
+    len = DATA_OBJ_LEN_MASK(((DOEHeader *)obj)->length);
+
+    /* PCIe r6.0 Table 6.29: a value of 00000h indicates 2^18 DW */
+    return (len) ? len : PCI_DOE_DW_SIZE_MAX;
+}
+
+static void pcie_doe_irq_assert(DOECap *doe_cap)
+{
+    PCIDevice *dev = doe_cap->pdev;
+
+    if (doe_cap->cap.intr && doe_cap->ctrl.intr) {
+        if (doe_cap->status.intr) {
+            return;
+        }
+        doe_cap->status.intr = 1;
+
+        if (msix_enabled(dev)) {
+            msix_notify(dev, doe_cap->cap.vec);
+        } else if (msi_enabled(dev)) {
+            msi_notify(dev, doe_cap->cap.vec);
+        }
+    }
+}
+
+static void pcie_doe_set_ready(DOECap *doe_cap, bool rdy)
+{
+    doe_cap->status.ready = rdy;
+
+    if (rdy) {
+        pcie_doe_irq_assert(doe_cap);
+    }
+}
+
+static void pcie_doe_set_error(DOECap *doe_cap, bool err)
+{
+    doe_cap->status.error = err;
+
+    if (err) {
+        pcie_doe_irq_assert(doe_cap);
+    }
+}
+
+/*
+ * Check incoming request in write_mbox for protocol format
+ */
+static void pcie_doe_prepare_rsp(DOECap *doe_cap)
+{
+    bool success = false;
+    int p;
+    bool (*handle_request)(DOECap *) = NULL;
+
+    if (doe_cap->status.error) {
+        return;
+    }
+
+    if (doe_cap->write_mbox[0] ==
+        DATA_OBJ_BUILD_HEADER1(PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_DISCOVERY)) {
+        handle_request = pcie_doe_discovery;
+    } else {
+        for (p = 0; p < doe_cap->protocol_num - 1; p++) {
+            if (doe_cap->write_mbox[0] ==
+                pcie_doe_build_protocol(&doe_cap->protocols[p])) {
+                handle_request = doe_cap->protocols[p].handle_request;
+                break;
+            }
+        }
+    }
+
+    /*
+     * PCIe r6 DOE 6.30.1:
+     * If the number of DW transferred does not match the
+     * indicated Length for a data object, then the
+     * data object must be silently discarded.
+     */
+    if (handle_request && (doe_cap->write_mbox_len ==
+        pcie_doe_get_obj_len(pcie_doe_get_write_mbox_ptr(doe_cap)))) {
+        success = handle_request(doe_cap);
+    }
+
+    if (success) {
+        pcie_doe_set_ready(doe_cap, 1);
+    } else {
+        pcie_doe_reset_mbox(doe_cap);
+    }
+}
+
+/*
+ * Read from DOE config space.
+ * Return false if the address not within DOE_CAP range.
+ */
+bool pcie_doe_read_config(DOECap *doe_cap, uint32_t addr, int size,
+                          uint32_t *buf)
+{
+    uint32_t shift;
+    uint16_t doe_offset = doe_cap->offset;
+
+    if (!range_covers_byte(doe_offset + PCI_EXP_DOE_CAP,
+                           PCI_DOE_SIZEOF - 4, addr)) {
+        return false;
+    }
+
+    addr -= doe_offset;
+    *buf = 0;
+
+    if (range_covers_byte(PCI_EXP_DOE_CAP, DWORD_BYTE, addr)) {
+        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_REG, INTR_SUPP,
+                          doe_cap->cap.intr);
+        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_REG, DOE_INTR_MSG_NUM,
+                          doe_cap->cap.vec);
+    } else if (range_covers_byte(PCI_EXP_DOE_CTRL, DWORD_BYTE, addr)) {
+        /* Must return ABORT=0 and GO=0 */
+        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_CONTROL, DOE_INTR_EN,
+                          doe_cap->ctrl.intr);
+    } else if (range_covers_byte(PCI_EXP_DOE_STATUS, DWORD_BYTE, addr)) {
+        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_BUSY,
+                          doe_cap->status.busy);
+        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_INTR_STATUS,
+                          doe_cap->status.intr);
+        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_ERROR,
+                          doe_cap->status.error);
+        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DATA_OBJ_RDY,
+                          doe_cap->status.ready);
+    /* Mailbox should be DW accessed */
+    } else if (addr == PCI_EXP_DOE_RD_DATA_MBOX && size == DWORD_BYTE) {
+        if (doe_cap->status.ready && !doe_cap->status.error) {
+            *buf = doe_cap->read_mbox[doe_cap->read_mbox_idx];
+        }
+    }
+
+    /* Process Alignment */
+    shift = addr % DWORD_BYTE;
+    *buf = extract32(*buf, shift * 8, size * 8);
+
+    return true;
+}
+
+/*
+ * Write to DOE config space.
+ * Return if the address not within DOE_CAP range or receives an abort
+ */
+void pcie_doe_write_config(DOECap *doe_cap,
+                           uint32_t addr, uint32_t val, int size)
+{
+    uint16_t doe_offset = doe_cap->offset;
+    uint32_t shift;
+
+    if (!range_covers_byte(doe_offset + PCI_EXP_DOE_CAP,
+                           PCI_DOE_SIZEOF - 4, addr)) {
+        return;
+    }
+
+    /* Process Alignment */
+    shift = addr % DWORD_BYTE;
+    addr -= (doe_offset + shift);
+    val = deposit32(val, shift * 8, size * 8, val);
+
+    switch (addr) {
+    case PCI_EXP_DOE_CTRL:
+        if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_ABORT)) {
+            pcie_doe_set_ready(doe_cap, 0);
+            pcie_doe_set_error(doe_cap, 0);
+            pcie_doe_reset_mbox(doe_cap);
+            return;
+        }
+
+        if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_GO)) {
+            pcie_doe_prepare_rsp(doe_cap);
+        }
+
+        if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_INTR_EN)) {
+            doe_cap->ctrl.intr = 1;
+        /* Clear interrupt bit located within the first byte */
+        } else if (shift == 0) {
+            doe_cap->ctrl.intr = 0;
+        }
+        break;
+    case PCI_EXP_DOE_STATUS:
+        if (FIELD_EX32(val, PCI_DOE_CAP_STATUS, DOE_INTR_STATUS)) {
+            doe_cap->status.intr = 0;
+        }
+        break;
+    case PCI_EXP_DOE_RD_DATA_MBOX:
+        /* Mailbox should be DW accessed */
+        if (size != DWORD_BYTE) {
+            return;
+        }
+        doe_cap->read_mbox_idx++;
+        if (doe_cap->read_mbox_idx == doe_cap->read_mbox_len) {
+            pcie_doe_reset_mbox(doe_cap);
+            pcie_doe_set_ready(doe_cap, 0);
+        } else if (doe_cap->read_mbox_idx > doe_cap->read_mbox_len) {
+            /* Underflow */
+            pcie_doe_set_error(doe_cap, 1);
+        }
+        break;
+    case PCI_EXP_DOE_WR_DATA_MBOX:
+        /* Mailbox should be DW accessed */
+        if (size != DWORD_BYTE) {
+            return;
+        }
+        doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
+        doe_cap->write_mbox_len++;
+        break;
+    case PCI_EXP_DOE_CAP:
+        /* fallthrough */
+    default:
+        break;
+    }
+}
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index d5ddea558b..bc9f834fd1 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -157,6 +157,9 @@
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
 
+/* Ref: PCIe r6.0 Table 6-32 */
+#define PCI_VENDOR_ID_PCI_SIG            0x0001
+
 #define PCI_VENDOR_ID_LSI_LOGIC          0x1000
 #define PCI_DEVICE_ID_LSI_53C810         0x0001
 #define PCI_DEVICE_ID_LSI_53C895A        0x0012
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 798a262a0a..698d3de851 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -26,6 +26,7 @@
 #include "hw/pci/pcie_aer.h"
 #include "hw/pci/pcie_sriov.h"
 #include "hw/hotplug.h"
+#include "hw/pci/pcie_doe.h"
 
 typedef enum {
     /* for attention and power indicator */
diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
new file mode 100644
index 0000000000..ba4d8b03bd
--- /dev/null
+++ b/include/hw/pci/pcie_doe.h
@@ -0,0 +1,123 @@
+/*
+ * PCIe Data Object Exchange
+ *
+ * Copyright (C) 2021 Avery Design Systems, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef PCIE_DOE_H
+#define PCIE_DOE_H
+
+#include "qemu/range.h"
+#include "qemu/typedefs.h"
+#include "hw/register.h"
+
+/*
+ * Reference:
+ * PCIe r6.0 - 7.9.24 Data Object Exchange Extended Capability
+ */
+/* Capabilities Register - r6.0 7.9.24.2 */
+#define PCI_EXP_DOE_CAP             0x04
+REG32(PCI_DOE_CAP_REG, 0)
+    FIELD(PCI_DOE_CAP_REG, INTR_SUPP, 0, 1)
+    FIELD(PCI_DOE_CAP_REG, DOE_INTR_MSG_NUM, 1, 11)
+
+/* Control Register - r6.0 7.9.24.3 */
+#define PCI_EXP_DOE_CTRL            0x08
+REG32(PCI_DOE_CAP_CONTROL, 0)
+    FIELD(PCI_DOE_CAP_CONTROL, DOE_ABORT, 0, 1)
+    FIELD(PCI_DOE_CAP_CONTROL, DOE_INTR_EN, 1, 1)
+    FIELD(PCI_DOE_CAP_CONTROL, DOE_GO, 31, 1)
+
+/* Status Register - r6.0 7.9.24.4 */
+#define PCI_EXP_DOE_STATUS          0x0c
+REG32(PCI_DOE_CAP_STATUS, 0)
+    FIELD(PCI_DOE_CAP_STATUS, DOE_BUSY, 0, 1)
+    FIELD(PCI_DOE_CAP_STATUS, DOE_INTR_STATUS, 1, 1)
+    FIELD(PCI_DOE_CAP_STATUS, DOE_ERROR, 2, 1)
+    FIELD(PCI_DOE_CAP_STATUS, DATA_OBJ_RDY, 31, 1)
+
+/* Write Data Mailbox Register - r6.0 7.9.24.5 */
+#define PCI_EXP_DOE_WR_DATA_MBOX    0x10
+
+/* Read Data Mailbox Register - 7.9.xx.6 */
+#define PCI_EXP_DOE_RD_DATA_MBOX    0x14
+
+/* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
+#define PCI_SIG_DOE_DISCOVERY       0x00
+
+#define PCI_DOE_DW_SIZE_MAX         (1 << 18)
+#define PCI_DOE_PROTOCOL_NUM_MAX    256
+
+#define DATA_OBJ_BUILD_HEADER1(v, p)    (((p) << 16) | (v))
+#define DATA_OBJ_LEN_MASK(len)          ((len) & (PCI_DOE_DW_SIZE_MAX - 1))
+
+typedef struct DOEHeader DOEHeader;
+typedef struct DOEProtocol DOEProtocol;
+typedef struct DOECap DOECap;
+
+struct DOEHeader {
+    uint16_t vendor_id;
+    uint8_t data_obj_type;
+    uint8_t reserved;
+    uint32_t length;
+} QEMU_PACKED;
+
+/* Protocol infos and rsp function callback */
+struct DOEProtocol {
+    uint16_t vendor_id;
+    uint8_t data_obj_type;
+    bool (*handle_request)(DOECap *);
+};
+
+struct DOECap {
+    /* Owner */
+    PCIDevice *pdev;
+
+    uint16_t offset;
+
+    struct {
+        bool intr;
+        uint16_t vec;
+    } cap;
+
+    struct {
+        bool abort;
+        bool intr;
+        bool go;
+    } ctrl;
+
+    struct {
+        bool busy;
+        bool intr;
+        bool error;
+        bool ready;
+    } status;
+
+    uint32_t *write_mbox;
+    uint32_t *read_mbox;
+
+    /* Mailbox position indicator */
+    uint32_t read_mbox_idx;
+    uint32_t read_mbox_len;
+    uint32_t write_mbox_len;
+
+    /* Protocols and its callback response */
+    DOEProtocol *protocols;
+    uint16_t protocol_num;
+};
+
+void pcie_doe_init(PCIDevice *pdev, DOECap *doe_cap, uint16_t offset,
+                   DOEProtocol *protocols, bool intr, uint16_t vec);
+void pcie_doe_fini(DOECap *doe_cap);
+bool pcie_doe_read_config(DOECap *doe_cap, uint32_t addr, int size,
+                          uint32_t *buf);
+void pcie_doe_write_config(DOECap *doe_cap, uint32_t addr,
+                           uint32_t val, int size);
+uint32_t pcie_doe_build_protocol(DOEProtocol *p);
+void *pcie_doe_get_write_mbox_ptr(DOECap *doe_cap);
+void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp);
+uint32_t pcie_doe_get_obj_len(void *obj);
+#endif /* PCIE_DOE_H */
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 1db86b0ec4..963dc2e170 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -179,4 +179,8 @@ typedef enum PCIExpLinkWidth {
 #define PCI_ACS_VER                     0x1
 #define PCI_ACS_SIZEOF                  8
 
+/* DOE Capability Register Fields */
+#define PCI_DOE_VER                     0x1
+#define PCI_DOE_SIZEOF                  24
+
 #endif /* QEMU_PCIE_REGS_H */
-- 
2.37.2

