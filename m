Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927AFC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbiAXRfE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:35:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4480 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbiAXRfB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:35:01 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjH8m3YSwz67M4k;
        Tue, 25 Jan 2022 01:31:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:34:59 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:34:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v4 35/42] cxl/cxl-host: Add memops for CFMWS region.
Date:   Mon, 24 Jan 2022 17:16:58 +0000
Message-ID: <20220124171705.10432-36-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Cameron <jonathan.cameron@huawei.com>

These memops perform interleave decoding, walking down the
CXL topology from CFMWS described host interleave
decoder via CXL host bridge HDM decoders, through the CXL
root ports and finally call CXL type 3 specific read and write
functions.

Note that, whilst functional the current implementation does
not support:
* switches
* multiple HDM decoders at a given level.
* unaligned accesses across the interleave boundaries

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/cxl/cxl-host.c    | 125 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl.h |   2 +
 2 files changed, 127 insertions(+)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 9f303e6d8e..d9cad188a8 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -136,3 +136,128 @@ void cxl_fixed_memory_window_link_targets(Error **errp)
         }
     }
 }
+
+/* TODO: support, multiple hdm decoders */
+static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
+                                uint8_t *target)
+{
+    uint32_t ctrl;
+    uint32_t ig_enc;
+    uint32_t iw_enc;
+    uint32_t target_reg;
+    uint32_t target_idx;
+
+    ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
+    if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
+        return false;
+    }
+
+    ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
+    iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
+    target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
+
+    if (target_idx > 4) {
+        target_reg = cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO];
+        target_reg >>= target_idx * 8;
+    } else {
+        target_reg = cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO];
+        target_reg >>= (target_idx - 4) * 8;
+    }
+    *target = target_reg & 0xff;
+
+    return true;
+}
+
+static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
+{
+    CXLComponentState *hb_cstate;
+    PCIHostState *hb;
+    int rb_index;
+    uint32_t *cache_mem;
+    uint8_t target;
+    bool target_found;
+    PCIDevice *rp, *d;
+
+    /* Address is relative to memory region. Convert to HPA */
+    addr += fw->base;
+
+    rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
+    hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl.cxl_host_bridge);
+    if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
+        return NULL;
+    }
+
+    hb_cstate = cxl_get_hb_cstate(hb);
+    if (!hb_cstate) {
+        return NULL;
+    }
+
+    cache_mem = hb_cstate->crb.cache_mem_registers;
+
+    target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+    if (!target_found) {
+        return NULL;
+    }
+
+    rp = pcie_find_port_by_pn(hb->bus, target);
+    if (!rp) {
+        return NULL;
+    }
+
+    d = pci_bridge_get_sec_bus(PCI_BRIDGE(rp))->devices[0];
+
+    if (!d || !object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3_DEV)) {
+        return NULL;
+    }
+
+    return d;
+}
+
+static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
+                                  unsigned size, MemTxAttrs attrs)
+{
+    CXLFixedWindow *fw = opaque;
+    PCIDevice *d;
+
+    d = cxl_cfmws_find_device(fw, addr);
+    if (d == NULL) {
+        *data = 0;
+        /* Reads to invalid address return poison */
+        return MEMTX_ERROR;
+    }
+
+    return cxl_type3_read(d, addr + fw->base, data, size, attrs);
+}
+
+static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
+                                   uint64_t data, unsigned size,
+                                   MemTxAttrs attrs)
+{
+    CXLFixedWindow *fw = opaque;
+    PCIDevice *d;
+
+    d = cxl_cfmws_find_device(fw, addr);
+    if (d == NULL) {
+        /* Writes to invalid address are silent */
+        return MEMTX_OK;
+    }
+
+    return cxl_type3_write(d, addr + fw->base, data, size, attrs);
+}
+
+const MemoryRegionOps cfmws_ops = {
+    .read_with_attrs = cxl_read_cfmws,
+    .write_with_attrs = cxl_write_cfmws,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+};
+
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 1b72c0b7b7..260d602ec9 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -46,4 +46,6 @@ extern QemuOptsList qemu_cxl_fixed_window_opts;
 void parse_cxl_fixed_memory_window_opts(MachineState *ms);
 void cxl_fixed_memory_window_link_targets(Error **errp);
 
+extern const MemoryRegionOps cfmws_ops;
+
 #endif
-- 
2.32.0

