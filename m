Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97E5C83F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 16:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjIDQsM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbjIDQsM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 12:48:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4831B7
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 09:48:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfZKh3fzrz6D953;
        Tue,  5 Sep 2023 00:46:48 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 17:48:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH 2/2] hw/cxl: Support 4 HDM decoders at all levels of topology
Date:   Mon, 4 Sep 2023 17:47:04 +0100
Message-ID: <20230904164704.18739-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
and CXL Type 3 end points.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Note there is a fix in here for a wrong increment that had
no impact when there was only one HDM decoder.

 include/hw/cxl/cxl_component.h |  7 +++
 hw/cxl/cxl-component-utils.c   | 26 +++++----
 hw/cxl/cxl-host.c              | 65 +++++++++++++++--------
 hw/mem/cxl_type3.c             | 97 +++++++++++++++++++++++-----------
 4 files changed, 133 insertions(+), 62 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index f0ad9cf7de..c5a93b2cec 100644
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
@@ -148,6 +152,9 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
 
 HDM_DECODER_INIT(0);
+HDM_DECODER_INIT(1);
+HDM_DECODER_INIT(2);
+HDM_DECODER_INIT(3);
 
 /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
 #define EXTSEC_ENTRY_MAX        256
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index e96398e8af..79b9369756 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -42,6 +42,9 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
 
     switch (offset) {
     case A_CXL_HDM_DECODER0_CTRL:
+    case A_CXL_HDM_DECODER1_CTRL:
+    case A_CXL_HDM_DECODER2_CTRL:
+    case A_CXL_HDM_DECODER3_CTRL:
         should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
         should_uncommit = !should_commit;
         break;
@@ -81,7 +84,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
     }
 
     if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
-        offset <= A_CXL_HDM_DECODER0_TARGET_LIST_HI) {
+        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
         dumb_hdm_handler(cxl_cstate, offset, value);
     } else {
         cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
@@ -161,7 +164,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
 static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                             enum reg_type type)
 {
-    int decoder_count = 1;
+    int decoder_count = 4;
     int i;
 
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT,
@@ -174,19 +177,22 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
     for (i = 0; i < decoder_count; i++) {
-        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20] = 0xf0000000;
-        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20] = 0xffffffff;
-        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
-        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
-        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
+        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20 / 4] = 0xf0000000;
+        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20 / 4]  = 0xffffffff;
+        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20 / 4] = 0xf0000000;
+        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20 / 4] = 0xffffffff;
+        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20 / 4] = 0x13ff;
         if (type == CXL2_DEVICE ||
             type == CXL2_TYPE3_DEVICE ||
             type == CXL2_LOGICAL_DEVICE) {
-            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xf0000000;
+            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20 / 4] =
+                0xf0000000;
         } else {
-            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
+            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20 / 4] =
+                0xffffffff;
         }
-        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;
+        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20 / 4] =
+            0xffffffff;
     }
 }
 
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f0920da956..e71b70d5b0 100644
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
+    bool found = false;
+    int i;
+    uint32_t cap;
+
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    for (i = 0;
+         i < cxl_decoder_count_dec(FIELD_EX32(cap, CXL_HDM_DECODER_CAPABILITY,
+                                              DECODER_COUNT));
+         i++) {
+        uint32_t ctrl, ig_enc, iw_enc, target_idx;
+        uint32_t low, high;
+        uint64_t base, size;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * 0x20 / 4);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * 0x20 / 4);
+        base = (low & 0xf0000000) | ((uint64_t)high << 32);
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20 / 4);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20 / 4);
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
+        ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * 0x20 / 4);
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
+                                    i * 0x20 / 4);
+            *target = extract32(val, target_idx * 8, 8);
+        } else {
+            uint32_t val = ldl_le_p(cache_mem +
+                                    R_CXL_HDM_DECODER0_TARGET_LIST_HI +
+                                    i * 0x20 / 4);
+            *target = extract32(val, (target_idx - 4) * 8, 8);
+        }
+        break;
     }
 
-    return true;
+    return found;
 }
 
 static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4e314748d3..fdfdb84813 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -381,14 +381,12 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
-    assert(which == 0);
-
-    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * 0x20 / 4);
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
-    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * 0x20 / 4, ctrl);
 }
 
 static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
@@ -397,14 +395,12 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
-    assert(which == 0);
-
-    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * 0x20 / 4);
 
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
 
-    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * 0x20 / 4, ctrl);
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
@@ -487,6 +483,21 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
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
@@ -758,36 +769,60 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
-/* TODO: Support multiple HDM decoders and DPA skip */
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
     uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
-    uint64_t decoder_base, decoder_size, hpa_offset;
-    uint32_t hdm0_ctrl;
-    int ig, iw;
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
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * 0x20 / 4);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * 0x20 / 4);
+        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20 / 4);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20 / 4);
+        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
+                       i * 0x20 / 4);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
+                        i * 0x20 / 4);
+        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
+        dpa_base += skip;
+
+        hpa_offset = (uint64_t)host_addr - decoder_base;
+
+        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * 0x20 / 4);
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

