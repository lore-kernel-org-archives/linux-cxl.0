Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB71CA0ECF
	for <linux-cxl@archiver.kernel.org>; Mon, 11 Sep 2023 22:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjIKWVi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 11 Sep 2023 18:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbjIKLow (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 11 Sep 2023 07:44:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E8E40
        for <linux-cxl@vger.kernel.org>; Mon, 11 Sep 2023 04:44:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RklBd36gKz6J7wT;
        Mon, 11 Sep 2023 19:40:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 11 Sep 2023 12:44:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linux-cxl@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v3 3/4] hw/cxl: Fix and use same calculation for HDM decoder block size everywhere
Date:   Mon, 11 Sep 2023 12:43:12 +0100
Message-ID: <20230911114313.6144-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In order to avoid having the size of the per HDM decoder register block
repeated in lots of places, create the register definitions for HDM
decoder 1 and use the offset between the first registers in HDM decoder 0 and
HDM decoder 1 to establish the offset.

Calculate in each function as this is more obvious and leads to shorter
line lengths than a single #define which would need a long name
to be specific enough.

Note that the code currently only supports one decoder, so the bugs this
fixes don't actually affect anything. Previously the offset didn't
take into account that the write_msk etc are 4 byte fields.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
v3:
New patch to separate this out from the addition of HDM decoders.
---
 include/hw/cxl/cxl_component.h |  2 ++
 hw/cxl/cxl-component-utils.c   | 19 +++++++++++--------
 hw/cxl/cxl-host.c              |  4 +++-
 hw/mem/cxl_type3.c             | 24 +++++++++++++++---------
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index ef9e033919..7c864d2044 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -148,6 +148,8 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
 
 HDM_DECODER_INIT(0);
+/* Only used for HDM decoder registers block address increment */
+HDM_DECODER_INIT(1);
 
 /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
 #define EXTSEC_ENTRY_MAX        256
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 352d0dace2..aa011a8f34 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -210,6 +210,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                             enum reg_type type)
 {
     int decoder_count = 1;
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     int i;
 
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT,
@@ -222,19 +223,21 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
     for (i = 0; i < decoder_count; i++) {
-        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20] = 0xf0000000;
-        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20] = 0xffffffff;
-        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
-        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
-        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
+        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc] = 0xf0000000;
+        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] = 0xffffffff;
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
+        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * hdm_inc] = 0xffffffff;
     }
 }
 
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f0920da956..73c5426476 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -101,12 +101,14 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
                                 uint8_t *target)
 {
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     uint32_t ctrl;
     uint32_t ig_enc;
     uint32_t iw_enc;
     uint32_t target_idx;
+    int i = 0;
 
-    ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
+    ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
     if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
         return false;
     }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4e314748d3..cd92813436 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -377,34 +377,36 @@ static void build_dvsecs(CXLType3Dev *ct3d)
 
 static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
 {
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
     assert(which == 0);
 
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
 
     assert(which == 0);
 
-    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
 
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
 
-    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
@@ -761,26 +763,30 @@ static void ct3_exit(PCIDevice *pci_dev)
 /* TODO: Support multiple HDM decoders and DPA skip */
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint64_t decoder_base, decoder_size, hpa_offset;
     uint32_t hdm0_ctrl;
     int ig, iw;
+    int i = 0;
 
-    decoder_base = (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
-                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
+    decoder_base =
+        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] << 32) |
+                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc]);
     if ((uint64_t)host_addr < decoder_base) {
         return false;
     }
 
     hpa_offset = (uint64_t)host_addr - decoder_base;
 
-    decoder_size = ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI] << 32) |
-        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO];
+    decoder_size =
+        ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] << 32) |
+        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc];
     if (hpa_offset >= decoder_size) {
         return false;
     }
 
-    hdm0_ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
+    hdm0_ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
     iw = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IW);
     ig = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IG);
 
-- 
2.39.2

