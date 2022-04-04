Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A4FC433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiDDPdU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378608AbiDDPdA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:33:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88F3E5E3
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:31:04 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXF721kTlz685FB;
        Mon,  4 Apr 2022 23:29:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 17:31:02 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:31:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v9 32/45] mem/cxl_type3: Add read and write functions for associated hostmem.
Date:   Mon, 4 Apr 2022 16:14:32 +0100
Message-ID: <20220404151445.10955-33-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Cameron <jonathan.cameron@huawei.com>

Once a read or write reaches a CXL type 3 device, the HDM decoders
on the device are used to establish the Device Physical Address
which should be accessed.  These functions peform the required maths
and then use a device specific address space to access the
hostmem->mr to fullfil the actual operation.  Note that failed writes
are silent, but failed reads return poison.  Note this is based
loosely on:

https://lore.kernel.org/qemu-devel/20200817161853.593247-6-f4bug@amsat.org/
[RFC PATCH 0/9] hw/misc: Add support for interleaved memory accesses

Only lightly tested so far.  More complex test cases yet to be written.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c          | 91 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  6 +++
 2 files changed, 97 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 9578e72576..53fd57579b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -95,7 +95,9 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
+    DeviceState *ds = DEVICE(ct3d);
     MemoryRegion *mr;
+    char *name;
 
     if (!ct3d->hostmem) {
         error_setg(errp, "memdev property must be set");
@@ -110,6 +112,15 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
     memory_region_set_nonvolatile(mr, true);
     memory_region_set_enabled(mr, true);
     host_memory_backend_set_mapped(ct3d->hostmem, true);
+
+    if (ds->id) {
+        name = g_strdup_printf("cxl-type3-dpa-space:%s", ds->id);
+    } else {
+        name = g_strdup("cxl-type3-dpa-space");
+    }
+    address_space_init(&ct3d->hostmem_as, mr, name);
+    g_free(name);
+
     ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
 
     if (!ct3d->lsa) {
@@ -165,6 +176,86 @@ static void ct3_exit(PCIDevice *pci_dev)
     ComponentRegisters *regs = &cxl_cstate->crb;
 
     g_free(regs->special_ops);
+    address_space_destroy(&ct3d->hostmem_as);
+}
+
+/* TODO: Support multiple HDM decoders and DPA skip */
+static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
+{
+    uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
+    uint64_t decoder_base, decoder_size, hpa_offset;
+    uint32_t hdm0_ctrl;
+    int ig, iw;
+
+    decoder_base = (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
+                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
+    if ((uint64_t)host_addr < decoder_base) {
+        return false;
+    }
+
+    hpa_offset = (uint64_t)host_addr - decoder_base;
+
+    decoder_size = ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI] << 32) |
+        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO];
+    if (hpa_offset >= decoder_size) {
+        return false;
+    }
+
+    hdm0_ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
+    iw = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IW);
+    ig = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IG);
+
+    *dpa = (MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+        ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset) >> iw);
+
+    return true;
+}
+
+MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
+                           unsigned size, MemTxAttrs attrs)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+    uint64_t dpa_offset;
+    MemoryRegion *mr;
+
+    /* TODO support volatile region */
+    mr = host_memory_backend_get_memory(ct3d->hostmem);
+    if (!mr) {
+        return MEMTX_ERROR;
+    }
+
+    if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
+        return MEMTX_ERROR;
+    }
+
+    if (dpa_offset > int128_get64(mr->size)) {
+        return MEMTX_ERROR;
+    }
+
+    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data, size);
+}
+
+MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
+                            unsigned size, MemTxAttrs attrs)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+    uint64_t dpa_offset;
+    MemoryRegion *mr;
+
+    mr = host_memory_backend_get_memory(ct3d->hostmem);
+    if (!mr) {
+        return MEMTX_OK;
+    }
+
+    if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
+        return MEMTX_OK;
+    }
+
+    if (dpa_offset > int128_get64(mr->size)) {
+        return MEMTX_OK;
+    }
+    return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
+                               &data, size);
 }
 
 static void ct3d_reset(DeviceState *dev)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 4285fbda08..1e141b6621 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -239,6 +239,7 @@ struct CXLType3Dev {
     HostMemoryBackend *lsa;
 
     /* State */
+    AddressSpace hostmem_as;
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
 };
@@ -259,4 +260,9 @@ struct CXLType3Class {
                     uint64_t offset);
 };
 
+MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
+                           unsigned size, MemTxAttrs attrs);
+MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
+                            unsigned size, MemTxAttrs attrs);
+
 #endif
-- 
2.32.0

