Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A11ECAAD1
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Aug 2022 15:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiHaPej (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiHaPei (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 Aug 2022 11:34:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5FBC32CD
        for <linux-cxl@vger.kernel.org>; Wed, 31 Aug 2022 08:34:37 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHp6L3nHXz6HJCs;
        Wed, 31 Aug 2022 23:30:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 17:34:35 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 16:34:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 2/3] hw/cxl: Switch to using an array for CXLRegisterLocator base addresses.
Date:   Wed, 31 Aug 2022 16:33:35 +0100
Message-ID: <20220831153336.16165-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220831153336.16165-1-Jonathan.Cameron@huawei.com>
References: <20220831153336.16165-1-Jonathan.Cameron@huawei.com>
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

Allows for easier looping over entries when adding CPMU instances.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c             |  8 ++++----
 hw/pci-bridge/cxl_downstream.c |  4 ++--
 hw/pci-bridge/cxl_root_port.c  |  4 ++--
 hw/pci-bridge/cxl_upstream.c   |  4 ++--
 include/hw/cxl/cxl_pci.h       | 10 ++++------
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 68d200144b..5d29d2595c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -44,10 +44,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
-        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
-        .reg0_base_hi = 0,
-        .reg1_base_lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
-        .reg1_base_hi = 0,
+        .reg_base[0].lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg_base[0].hi = 0,
+        .reg_base[1].lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
+        .reg_base[1].hi = 0,
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index a361e519d0..7822ccd5de 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -126,8 +126,8 @@ static void build_dvsecs(CXLComponentState *cxl)
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
-        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
-        .reg0_base_hi = 0,
+        .reg_base[0].lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg_base[0].hi = 0,
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index fb213fa06e..08c2441dab 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -87,8 +87,8 @@ static void build_dvsecs(CXLComponentState *cxl)
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
-        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
-        .reg0_base_hi = 0,
+        .reg_base[0].lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg_base[0].hi = 0,
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index a83a3e81e4..45ee6ba884 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -111,8 +111,8 @@ static void build_dvsecs(CXLComponentState *cxl)
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
-        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
-        .reg0_base_hi = 0,
+        .reg_base[0].lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg_base[0].hi = 0,
     };
     cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index 01cf002096..8cbeb61142 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -141,12 +141,10 @@ QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortFlexBus) != 0x14);
 typedef struct CXLDVSECRegisterLocator {
     DVSECHeader hdr;
     uint16_t rsvd;
-    uint32_t reg0_base_lo;
-    uint32_t reg0_base_hi;
-    uint32_t reg1_base_lo;
-    uint32_t reg1_base_hi;
-    uint32_t reg2_base_lo;
-    uint32_t reg2_base_hi;
+    struct {
+            uint32_t lo;
+            uint32_t hi;
+    } reg_base[3];
 } CXLDVSECRegisterLocator;
 QEMU_BUILD_BUG_ON(sizeof(CXLDVSECRegisterLocator) != 0x24);
 
-- 
2.32.0

