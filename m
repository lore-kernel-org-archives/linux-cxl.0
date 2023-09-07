Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01127EC8752
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Sep 2023 18:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjIGStH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjIGStH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Sep 2023 14:49:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2C0121
        for <linux-cxl@vger.kernel.org>; Thu,  7 Sep 2023 11:49:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RhHJt2jj4z6K6LB;
        Thu,  7 Sep 2023 19:37:02 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 12:37:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 3/3] hw/cxl: Support 4 HDM decoders at all levels of topology
Date:   Thu, 7 Sep 2023 12:35:43 +0100
Message-ID: <20230907113543.19760-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
and CXL Type 3 end points.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_component.h |  10 ++++
 hw/cxl/cxl-component-utils.c   |  27 +++++----
 hw/cxl/cxl-host.c              |  65 ++++++++++++++-------
 hw/mem/cxl_type3.c             | 100 +++++++++++++++++++++++----------
 4 files changed, 140 insertions(+), 62 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index ef9e033919..3c795a6278 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -135,6 +135,10 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
         CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)                          \
+  REG32(CXL_HDM_DECODER##n##_DPA_SKIP_LO,                                      \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
+  REG32(CXL_HDM_DECODER##n##_DPA_SKIP_HI,                                      \
         CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)
 
 REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
@@ -147,7 +151,13 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
 
+/* Support 4 decoders at all levels of topology */
+#define CXL_HDM_DECODER_COUNT 4
+
 HDM_DECODER_INIT(0);
+HDM_DECODER_INIT(1);
+HDM_DECODER_INIT(2);
+HDM_DECODER_INIT(3);
 
 /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
 #define EXTSEC_ENTRY_MAX        256
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 352d0dace2..ed1a07a62c 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -90,6 +90,9 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
 
     switch (offset) {
     case A_CXL_HDM_DECODER0_CTRL:
+    case A_CXL_HDM_DECODER1_CTRL:
+    case A_CXL_HDM_DECODER2_CTRL:
+    case A_CXL_HDM_DECODER3_CTRL:
         should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
         should_uncommit = !should_commit;
         break;
@@ -129,7 +132,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
     }
 
     if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
-        offset <= A_CXL_HDM_DECODER0_TARGET_LIST_HI) {
+        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
         dumb_hdm_handler(cxl_cstate, offset, value);
     } else {
         cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
@@ -209,7 +212,8 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
 static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                             enum reg_type type)
 {
-    int decoder_count = 1;
+    int decoder_count = CXL_HDM_DECODER_COUNT;
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     int i;
 
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT,
@@ -222,19 +226,22 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
     for (i = 0; i < decoder_count; i++) {
-        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20] = 0xf0000000;
-        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20] = 0xffffffff;
-        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
-        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
-        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
+        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc] = 0xf0000000;
+        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc]  = 0xffffffff;
+        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc] = 0xf0000000;
+        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
+        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
         if (type == CXL2_DEVICE ||
             type == CXL2_TYPE3_DEVICE ||
             type == CXL2_LOGICAL_DEVICE) {
-            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xf0000000;
+            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
+                0xf0000000;
         } else {
-            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
+            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
+                0xffffffff;
         }
-        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;
+        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * hdm_inc] =
+            0xffffffff;
     }
 }
 
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f0920da956..3b7f80ea8a 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -97,33 +97,56 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
     }
 }
 
-/* TODO: support, multiple hdm decoders */
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
                                 uint8_t *target)
 {
-    uint32_t ctrl;
-    uint32_t ig_enc;
-    uint32_t iw_enc;
-    uint32_t target_idx;
-
-    ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
-    if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
-        return false;
-    }
-
-    ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
-    iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
-    target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
+    unsigned int hdm_count;
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+    bool found = false;
+    int i;
+    uint32_t cap;
+
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    hdm_count = FIELD_EX32(cap, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT);
+    for (i = 0; i < hdm_count; i++) {
+        uint32_t ctrl, ig_enc, iw_enc, target_idx;
+        uint32_t low, high;
+        uint64_t base, size;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
+        base = (low & 0xf0000000) | ((uint64_t)high << 32);
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
+        size = (low & 0xf0000000) | ((uint64_t)high << 32);
+        if (addr < base || addr >= base + size) {
+            continue;
+        }
 
-    if (target_idx < 4) {
-        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO],
-                            target_idx * 8, 8);
-    } else {
-        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_HI],
-                            (target_idx - 4) * 8, 8);
+        ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
+        if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
+            return false;
+        }
+        found = true;
+        ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
+        iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
+        target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
+
+        if (target_idx < 4) {
+            uint32_t val = ldl_le_p(cache_mem +
+                                    R_CXL_HDM_DECODER0_TARGET_LIST_LO +
+                                    i * hdm_inc);
+            *target = extract32(val, target_idx * 8, 8);
+        } else {
+            uint32_t val = ldl_le_p(cache_mem +
+                                    R_CXL_HDM_DECODER0_TARGET_LIST_HI +
+                                    i * hdm_inc);
+            *target = extract32(val, (target_idx - 4) * 8, 8);
+        }
+        break;
     }
 
-    return true;
+    return found;
 }
 
 static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4e314748d3..39a8bbe923 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -377,34 +377,32 @@ static void build_dvsecs(CXLType3Dev *ct3d)
 
 static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
 {
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
-    assert(which == 0);
-
-    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
-    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
 }
 
 static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
 {
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
-    assert(which == 0);
-
-    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
 
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
 
-    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
@@ -487,6 +485,21 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
         should_uncommit = !should_commit;
         which_hdm = 0;
         break;
+    case A_CXL_HDM_DECODER1_CTRL:
+        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        should_uncommit = !should_commit;
+        which_hdm = 1;
+        break;
+    case A_CXL_HDM_DECODER2_CTRL:
+        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        should_uncommit = !should_commit;
+        which_hdm = 2;
+        break;
+    case A_CXL_HDM_DECODER3_CTRL:
+        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        should_uncommit = !should_commit;
+        which_hdm = 3;
+        break;
     case A_CXL_RAS_UNC_ERR_STATUS:
     {
         uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
@@ -758,36 +771,61 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
-/* TODO: Support multiple HDM decoders and DPA skip */
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
     uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
-    uint64_t decoder_base, decoder_size, hpa_offset;
-    uint32_t hdm0_ctrl;
-    int ig, iw;
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+    uint32_t cap;
+    uint64_t dpa_base = 0;
+    int i;
 
-    decoder_base = (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
-                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
-    if ((uint64_t)host_addr < decoder_base) {
-        return false;
-    }
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    for (i = 0; i < cxl_decoder_count_dec(FIELD_EX32(cap,
+                                                     CXL_HDM_DECODER_CAPABILITY,
+                                                     DECODER_COUNT));
+         i++) {
+        uint64_t decoder_base, decoder_size, hpa_offset, skip;
+        uint32_t hdm_ctrl, low, high;
+        int ig, iw;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
+        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
+        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
+                       i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
+                        i * hdm_inc);
+        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
+        dpa_base += skip;
+
+        hpa_offset = (uint64_t)host_addr - decoder_base;
+
+        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
+        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
+        ig = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IG);
+        if (!FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
+            return false;
+        }
+        if (((uint64_t)host_addr < decoder_base) ||
+            (hpa_offset >= decoder_size)) {
+            dpa_base += decoder_size /
+                cxl_interleave_ways_dec(iw, &error_fatal);
+            continue;
+        }
 
-    hpa_offset = (uint64_t)host_addr - decoder_base;
+        *dpa = dpa_base +
+            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
+              >> iw));
 
-    decoder_size = ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI] << 32) |
-        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO];
-    if (hpa_offset >= decoder_size) {
-        return false;
+        return true;
     }
-
-    hdm0_ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
-    iw = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IW);
-    ig = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IG);
-
-    *dpa = (MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
-        ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset) >> iw);
-
-    return true;
+    return false;
 }
 
 static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
-- 
2.39.2

