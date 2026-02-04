Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263FC3033F7
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225041; cv=none; b=XwZonqtRlCgUYaul9O3NTsioWu+FsT416mdR7PZgLCSrkqaiW3bwQCukIyJtGXiJF+397MGcoNz/Wddgeere6Rw857eERN0sWpDQOz7zBmLaIhgEpn0q3rki321MHXzG3Rx3ySZA8U5j/JUtqDvryNi/d7LZ96MZdX1J4sGHj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225041; c=relaxed/simple;
	bh=eG+cdcahil7oOMeaxKL9Vuch/YKN+SYWHgKJJUsQrv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXnzZDkyPgI+3kTmJZ6RdXXksSgvZ7ho7ZMVMw5PAbyd739WVFoF3bmqmzsK/JO2ZNXFsdqHJF8BeocQVwJKOuPT4fg3rLzL8B3nBmAIK5D93uuRj4REcRTH73RQbBrO0dnWADjbQ0d1ozNFNx2/2n7i4TE9lKG1ZNl9APNQRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5n0G1XBMzJ467C;
	Thu,  5 Feb 2026 01:09:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8698A40569;
	Thu,  5 Feb 2026 01:10:39 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 17:10:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v7 2/7] hw/cxl: Refactor component register initialization
Date: Wed, 4 Feb 2026 17:09:30 +0000
Message-ID: <20260204170936.43959-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
References: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

From: Ira Weiny <ira.weiny@intel.com>

CXL 3.2 8.2.4 Table 8-22 defines which capabilities are mandatory, not
permitted, or optional for each type of device.

cxl_component_register_init_common() uses a rather odd 'fall through'
mechanism to define each component register set.  This assumes that any
device or capability being added builds on the previous devices
capabilities.  This is not true as there are mutually exclusive
capabilities defined.  For example, downstream ports can not have snoop
but it can have Back Invalidate capable decoders.

Refactor this code to make it easier to add individual capabilities as
defined by a device type.  Any capability which is not specified by the
type is left NULL'ed out which complies with the packed nature of the
register array.

Update all spec references to 3.2.

No functional changes should be seen with this patch.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
[rebased, no RAS for HBs, r3.2 references]
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_component.h | 33 ++++++++++-----
 hw/cxl/cxl-component-utils.c   | 75 +++++++++++-----------------------
 2 files changed, 46 insertions(+), 62 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index b0f2aa791431..1f167d3ef79b 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -32,10 +32,20 @@ enum reg_type {
 };
 
 /*
- * Capability registers are defined at the top of the CXL.cache/mem region and
- * are packed. For our purposes we will always define the caps in the same
- * order.
- * CXL r3.1 Table 8-22: CXL_CAPABILITY_ID Assignment for details.
+ * CXL r3.2 - 8.2.4 Table 8-22 and 8-23
+ *
+ * Capability registers are defined at the top of the CXL.cache/mem region.
+ * They are defined to be packed and at variable offsets.  However, NULL
+ * capabilities can be added to the packed array.  To facilitate easier access
+ * within the QEMU code, define these at specified offsets.  Then NULL out any
+ * capabilities for devices which don't (or can't) have a particular capability
+ * (see cxl_component_register_init_common).  NULL capabilities are to be
+ * ignored by software.
+ *
+ * 'offsets' are based on index's which can then be used to report the array
+ * size in CXL Capability Header Register (index/offset 0).
+ *
+ * See CXL r3.2 Table 8-25 for an example of allowing a 'NULL' header.
  */
 
 /* CXL r3.1 Section 8.2.4.1: CXL Capability Header Register */
@@ -46,16 +56,17 @@ REG32(CXL_CAPABILITY_HEADER, 0)
     FIELD(CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 20, 4)
     FIELD(CXL_CAPABILITY_HEADER, ARRAY_SIZE, 24, 8)
 
-#define CXLx_CAPABILITY_HEADER(type, offset)                  \
-    REG32(CXL_##type##_CAPABILITY_HEADER, offset)             \
+#define CXLx_CAPABILITY_HEADER(type, idx)                     \
+    enum { CXL_##type##_CAP_HDR_IDX = idx };                  \
+    REG32(CXL_##type##_CAPABILITY_HEADER, (idx * 0x4))        \
         FIELD(CXL_##type##_CAPABILITY_HEADER, ID, 0, 16)      \
         FIELD(CXL_##type##_CAPABILITY_HEADER, VERSION, 16, 4) \
         FIELD(CXL_##type##_CAPABILITY_HEADER, PTR, 20, 12)
-CXLx_CAPABILITY_HEADER(RAS, 0x4)
-CXLx_CAPABILITY_HEADER(LINK, 0x8)
-CXLx_CAPABILITY_HEADER(HDM, 0xc)
-CXLx_CAPABILITY_HEADER(EXTSEC, 0x10)
-CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
+CXLx_CAPABILITY_HEADER(RAS, 1)
+CXLx_CAPABILITY_HEADER(LINK, 2)
+CXLx_CAPABILITY_HEADER(HDM, 3)
+CXLx_CAPABILITY_HEADER(EXTSEC, 4)
+CXLx_CAPABILITY_HEADER(SNOOP, 5)
 
 /*
  * Capability structures contain the actual registers that the CXL component
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 473895948b3d..91770f103a85 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -284,32 +284,6 @@ void cxl_component_register_init_common(uint32_t *reg_state,
 {
     int caps = 0;
 
-    /*
-     * In CXL 2.0 the capabilities required for each CXL component are such
-     * that, with the ordering chosen here, a single number can be used to
-     * define which capabilities should be provided.
-     */
-    switch (type) {
-    case CXL2_DOWNSTREAM_PORT:
-    case CXL2_DEVICE:
-        /* RAS, Link */
-        caps = 2;
-        break;
-    case CXL2_UPSTREAM_PORT:
-    case CXL2_TYPE3_DEVICE:
-    case CXL2_LOGICAL_DEVICE:
-        /* + HDM */
-        caps = 3;
-        break;
-    case CXL2_ROOT_PORT:
-    case CXL2_RC:
-        /* + Extended Security, + Snoop */
-        caps = 5;
-        break;
-    default:
-        abort();
-    }
-
     memset(reg_state, 0, CXL2_COMPONENT_CM_REGION_SIZE);
 
     /* CXL Capability Header Register */
@@ -317,11 +291,12 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION,
         CXL_CAPABILITY_VERSION);
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
-    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 
 #define init_cap_reg(reg, id, version)                                        \
     do {                                                                      \
-        int which = R_CXL_##reg##_CAPABILITY_HEADER;                          \
+        int which = CXL_##reg##_CAP_HDR_IDX;                                  \
+        if (CXL_##reg##_CAP_HDR_IDX > caps)                                   \
+            caps = CXL_##reg##_CAP_HDR_IDX;                                   \
         reg_state[which] = FIELD_DP32(reg_state[which],                       \
                                       CXL_##reg##_CAPABILITY_HEADER, ID, id); \
         reg_state[which] =                                                    \
@@ -332,37 +307,35 @@ void cxl_component_register_init_common(uint32_t *reg_state,
                        CXL_##reg##_REGISTERS_OFFSET);                         \
     } while (0)
 
+    /* CXL r3.2 8.2.4 Table 8-22 */
     switch (type) {
-    case CXL2_DEVICE:
-    case CXL2_TYPE3_DEVICE:
-    case CXL2_LOGICAL_DEVICE:
     case CXL2_ROOT_PORT:
+    case CXL2_RC:
+        /* + Extended Security, + Snoop */
+        init_cap_reg(EXTSEC, 6, 1);
+        init_cap_reg(SNOOP, 8, 1);
+        /* fallthrough */
     case CXL2_UPSTREAM_PORT:
+    case CXL2_TYPE3_DEVICE:
+    case CXL2_LOGICAL_DEVICE:
+        /* + HDM */
+        init_cap_reg(HDM, 5, 1);
+        hdm_init_common(reg_state, write_msk, type);
+        /* fallthrough */
     case CXL2_DOWNSTREAM_PORT:
-    init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
-        ras_init_common(reg_state, write_msk);
+    case CXL2_DEVICE:
+        /* RAS, Link */
+        if (type != CXL2_RC) {
+            init_cap_reg(RAS, 2, 2);
+            ras_init_common(reg_state, write_msk);
+        }
+        init_cap_reg(LINK, 4, 2);
         break;
     default:
-        break;
-    }
-
-    init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
-
-    if (caps < 3) {
-        return;
-    }
-
-    if (type != CXL2_ROOT_PORT) {
-        init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
-        hdm_init_common(reg_state, write_msk, type);
-    }
-    if (caps < 5) {
-        return;
+        abort();
     }
 
-    init_cap_reg(EXTSEC, 6, CXL_EXTSEC_CAP_VERSION);
-    init_cap_reg(SNOOP, 8, CXL_SNOOP_CAP_VERSION);
-
+    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 #undef init_cap_reg
 }
 
-- 
2.51.0

