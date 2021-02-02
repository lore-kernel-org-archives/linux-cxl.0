Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA20C43331
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0202464ED9
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhBBBBu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:01:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:21927 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhBBBBt (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:49 -0500
IronPort-SDR: iOQvTWiEFKSyQ+nfcIHwAaXeczHedVcl8SSJP90neBb9oIBRWmCjT1r/38v4FNkWW2+SAhRgMa
 M1wW2XZbGk0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294647"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294647"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:16 -0800
IronPort-SDR: mj/WECK9mex43OGDJQ+sNJnmkCYCD8EO8/Ml13pY/nuQpmCNcku2zKN22Y7S0EIvuKBzv/Ngg9
 E8+RnkBnvchw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764231"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:15 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     qemu-devel@nongnu.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 22/31] hw/cxl/device: Implement MMIO HDM decoding (8.2.5.12)
Date:   Mon,  1 Feb 2021 16:59:39 -0800
Message-Id: <20210202005948.241655-23-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A device's volatile and persistent memory are known Host Defined Memory
(HDM) regions. The mechanism by which the device is programmed to claim
the addresses associated with those regions is through dedicated logic
known as the HDM decoder. In order to allow the OS to properly program
the HDMs, the HDM decoders must be modeled.

There are two ways the HDM decoders can be implemented, the legacy
mechanism is through the PCIe DVSEC programming from CXL 1.1 (8.1.3.8),
and MMIO is found in 8.2.5.12 of the spec. For now, 8.1.3.8 is not
implemented.

Much of CXL device logic is implemented in cxl-utils. The HDM decoder
however is implemented directly by the device implementation. The
generic cxl-utils probably should be the correct place to put this since
HDM decoders aren't unique to a type3 device. It is however easier at
the moment, and requires less design consideration to simply implement
it in the device, and figure out how to consolidate it later.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/mem/cxl_type3.c | 92 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4e9a016448..fe02c3b63c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -57,6 +57,84 @@ static void build_dvsecs(CXLType3Dev *ct3d)
                                REG_LOC_DVSEC_REVID, dvsec);
 }
 
+static void cxl_set_addr(CXLType3Dev *ct3d, hwaddr addr, Error **errp)
+{
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(ct3d);
+    mdc->set_addr(MEMORY_DEVICE(ct3d), addr, errp);
+}
+
+static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
+{
+    MemoryRegion *pmem = ct3d->cxl_dstate.pmem;
+    MemoryRegion *mr = host_memory_backend_get_memory(ct3d->hostmem);
+    Range window, device;
+    ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
+    uint32_t *cache_mem = cregs->cache_mem_registers;
+    uint64_t offset, size;
+    Error *err = NULL;
+
+    assert(which == 0);
+
+    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
+    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERROR, 0);
+
+    offset = ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
+             cache_mem[R_CXL_HDM_DECODER0_BASE_LO];
+    size = ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI] << 32) |
+           cache_mem[R_CXL_HDM_DECODER0_SIZE_LO];
+
+    range_init_nofail(&window, mr->addr, memory_region_size(mr));
+    range_init_nofail(&device, offset, size);
+
+    if (!range_contains_range(&window, &device)) {
+        ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERROR, 1);
+        return;
+    }
+
+    /*
+     * FIXME: Support resizing.
+     * Maybe just memory_region_ram_resize(pmem, size, &err)?
+     */
+    if (size != memory_region_size(pmem)) {
+        ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERROR, 1);
+        return;
+    }
+
+    cxl_set_addr(ct3d, offset, &err);
+    if (err) {
+        ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERROR, 1);
+        return;
+    }
+    memory_region_set_enabled(pmem, true);
+
+    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
+}
+
+static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value, unsigned size)
+{
+    CXLComponentState *cxl_cstate = opaque;
+    ComponentRegisters *cregs = &cxl_cstate->crb;
+    CXLType3Dev *ct3d = container_of(cxl_cstate, CXLType3Dev, cxl_cstate);
+    uint32_t *cache_mem = cregs->cache_mem_registers;
+    bool should_commit = false;
+    int which_hdm = -1;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case A_CXL_HDM_DECODER0_CTRL:
+        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        which_hdm = 0;
+        break;
+    default:
+        break;
+    }
+
+    stl_le_p((uint8_t *)cache_mem + offset, value);
+    if (should_commit)
+        hdm_decoder_commit(ct3d, which_hdm);
+}
+
 static void ct3_instance_init(Object *obj)
 {
     /* MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj); */
@@ -65,18 +143,13 @@ static void ct3_instance_init(Object *obj)
 static void ct3_finalize(Object *obj)
 {
     CXLType3Dev *ct3d = CT3(obj);
+    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
+    ComponentRegisters *regs = &cxl_cstate->crb;
 
+    g_free((void *)regs->special_ops);
     g_free(ct3d->cxl_dstate.pmem);
 }
 
-#ifdef SET_PMEM_PADDR
-static void cxl_set_addr(CXLType3Dev *ct3d, hwaddr addr, Error **errp)
-{
-    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(ct3d);
-    mdc->set_addr(MEMORY_DEVICE(ct3d), addr, errp);
-}
-#endif
-
 static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     MemoryRegionSection mrs;
@@ -160,6 +233,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ct3d->cxl_cstate.pdev = pci_dev;
     build_dvsecs(ct3d);
 
+    regs->special_ops = g_new0(MemoryRegionOps, 1);
+    regs->special_ops->write = ct3d_reg_write;
+
     cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
                                       TYPE_CXL_TYPE3_DEV);
 
-- 
2.30.0

