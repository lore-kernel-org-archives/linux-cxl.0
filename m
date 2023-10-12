Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1312AB35
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA96B8
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 07:06:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5ryy0Qv6z6K7FC;
	Thu, 12 Oct 2023 22:06:18 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 15:06:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 3/4] hw/cxl: CXLDVSECPortExtensions renamed to CXLDVSECPortExt
Date: Thu, 12 Oct 2023 15:05:13 +0100
Message-ID: <20231012140514.3697-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Done to reduce line lengths where this is used.
Ext seems sufficiently obvious that it need not be spelt out
fully.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 include/hw/cxl/cxl_pci.h       |  6 ++---
 hw/cxl/cxl-component-utils.c   | 49 ++++++++++++++++++++--------------
 hw/pci-bridge/cxl_downstream.c |  2 +-
 hw/pci-bridge/cxl_root_port.c  |  2 +-
 hw/pci-bridge/cxl_upstream.c   |  2 +-
 5 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index 407be95b9e..ddf01a543b 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -86,7 +86,7 @@ typedef struct CXLDVSECDevice {
 QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x38);
 
 /* CXL 2.0 - 8.1.5 (ID 0003) */
-typedef struct CXLDVSECPortExtensions {
+typedef struct CXLDVSECPortExt {
     DVSECHeader hdr;
     uint16_t status;
     uint16_t control;
@@ -100,8 +100,8 @@ typedef struct CXLDVSECPortExtensions {
     uint32_t alt_prefetch_limit_high;
     uint32_t rcrb_base;
     uint32_t rcrb_base_high;
-} CXLDVSECPortExtensions;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortExtensions) != 0x28);
+} CXLDVSECPortExt;
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortExt) != 0x28);
 
 #define PORT_CONTROL_OFFSET          0xc
 #define PORT_CONTROL_UNMASK_SBR      1
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index d1997a52e6..8ab04dbb01 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -392,26 +392,35 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     case NON_CXL_FUNCTION_MAP_DVSEC:
         break; /* Not yet implemented */
     case EXTENSIONS_PORT_DVSEC:
-        wmask[offset + offsetof(CXLDVSECPortExtensions, control)] = 0x0F;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, control) + 1] = 0x40;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_bus_base)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_bus_limit)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_base)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_base) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_limit)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_limit) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high) + 2] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high) + 3] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high) + 2] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high) + 3] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, control)] = 0x0F;
+        wmask[offset + offsetof(CXLDVSECPortExt, control) + 1] = 0x40;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_base)] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_limit)] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_base)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_base) + 1] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_limit)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_limit) + 1] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base) + 1] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit) + 1] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high)] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high) + 1] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high) + 2] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high) + 3] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high)] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high) + 1] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high) + 2] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high) + 3] =
+            0xFF;
         break;
     case GPF_PORT_DVSEC:
         wmask[offset + offsetof(CXLDVSECPortGPF, phase1_ctrl)] = 0x0F;
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 5a2b749c8e..8c0f759add 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -98,7 +98,7 @@ static void build_dvsecs(CXLComponentState *cxl)
 {
     uint8_t *dvsec;
 
-    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){ 0 };
+    dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
                                EXTENSIONS_PORT_DVSEC_LENGTH,
                                EXTENSIONS_PORT_DVSEC,
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 7dfd20aa67..8f97697631 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -107,7 +107,7 @@ static void build_dvsecs(CXLComponentState *cxl)
 {
     uint8_t *dvsec;
 
-    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){ 0 };
+    dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
                                EXTENSIONS_PORT_DVSEC_LENGTH,
                                EXTENSIONS_PORT_DVSEC,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index a57806fb31..b81bb5fec9 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -116,7 +116,7 @@ static void build_dvsecs(CXLComponentState *cxl)
 {
     uint8_t *dvsec;
 
-    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){
+    dvsec = (uint8_t *)&(CXLDVSECPortExt){
         .status = 0x1, /* Port Power Management Init Complete */
     };
     cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
-- 
2.39.2

