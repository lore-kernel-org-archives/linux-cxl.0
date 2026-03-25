Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1047334C28
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464254; cv=none; b=Wskkr0FWhWM8fJLWa99NyzpEdB28ij7UXQ23mtaVhA7xt9VTrI5cj5F5gPNOVOPBRIkgKUjPIea6i95v91I35D56mp6E4D0oX7EBILzvmHebjHibLFsjkBuXRdeJxvISYiR9S/hkuIxvmFEmO8G6WSQQtCcaGMXBKGv6lQc8HMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464254; c=relaxed/simple;
	bh=0iSYBNpmW2YIqQ7lCWfuwk6grAyVZ0zQeWmV3EDxxEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGumS6Ya57PCRcNRMoWqxos5AQ80NcR+6znIDcjki9dCw6o+07jIJfuhAl/SNuUQLa/RGMXdOuRvfK9U8J54tXl+u8R6004eiT5nSslw9u27EG9JUFN05iwPYUcZJ39j2/Fw34C6A4AQiGPCDR1Zo+4bsGwZmw8FfWJs5qwQMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwlq03HMzHnGk0;
	Thu, 26 Mar 2026 02:43:35 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CF7554056E;
	Thu, 26 Mar 2026 02:44:10 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:44:09 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 2/9] hw/cxl: Allow initializing type3 device with no backing device
Date: Wed, 25 Mar 2026 18:42:50 +0000
Message-ID: <20260325184259.366-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260325184259.366-1-alireza.sanaee@huawei.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Add a dc-regions-total-size property that allows creating a CXL type3
device with DC regions but without a backing memory device at init time. In
Dynamic Capacity scenarios, memory can show up asynchronously from
different resources (RAM, PMEM, file-backed).  For these cases, only the
total DC size needs to be known upfront.

When dc-regions-total-size is set (instead of volatile-dc-memdev), the
device initializes DC regions using the specified total size but does not
set up any backing memory. Any FMAPI or QMP command that attempts to add or
release extents will fail with an error, since no backing device is
available yet. The runtime hookup of tagged memory backends will be added
in a subsequent patch.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  8 ++++
 hw/mem/cxl_type3.c          | 92 ++++++++++++++++++++++---------------
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c83b5f90d4..e6e136cf44 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4270,6 +4270,10 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     int i, rc;
 
+    if (ct3d->dc.total_capacity_cmd) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     switch (in->selection_policy) {
         case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
             /* Adding extents exceeds device's extent tracking ability. */
@@ -4357,6 +4361,10 @@ static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     int i, rc;
 
+    if (ct3d->dc.total_capacity_cmd) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
         case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
             CXLDCExtentList updated_list;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d9fc0bec8f..45fb6c55bc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -190,12 +190,15 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     }
 
     if (ct3d->dc.num_regions) {
-        if (!ct3d->dc.host_dc) {
-            return -EINVAL;
-        }
-        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
-        if (!dc_mr) {
-            return -EINVAL;
+        /* Only check if DC is static (has a backing device) */
+        if (ct3d->dc.total_capacity_cmd == 0) {
+            if (!ct3d->dc.host_dc) {
+                return -EINVAL;
+            }
+            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+            if (!dc_mr) {
+                return -EINVAL;
+            }
         }
         len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
     }
@@ -216,7 +219,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
 
-    if (dc_mr) {
+    if (dc_mr || ct3d->dc.total_capacity_cmd) {
         int i;
         uint64_t region_base = vmr_size + pmr_size;
 
@@ -651,8 +654,12 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     MemoryRegion *mr;
     uint64_t dc_size;
 
-    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
-    dc_size = memory_region_size(mr);
+    if (ct3d->dc.total_capacity_cmd != 0) {
+        dc_size = ct3d->dc.total_capacity_cmd;
+    } else {
+        mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = memory_region_size(mr);
+    }
     region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
 
     if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLIER) != 0) {
@@ -818,36 +825,41 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         MemoryRegion *dc_mr;
         char *dc_name;
 
-        if (!ct3d->dc.host_dc) {
-            error_setg(errp, "dynamic capacity must have a backing device");
-            return false;
-        }
+        /* Only require backing device if total_capacity_cmd is zero */
+        if (ct3d->dc.total_capacity_cmd == 0) {
+            if (!ct3d->dc.host_dc) {
+                error_setg(errp, "dynamic capacity must have a backing device");
+                return false;
+            }
 
-        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
-        if (!dc_mr) {
-            error_setg(errp, "dynamic capacity must have a backing device");
-            return false;
-        }
+            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+            if (!dc_mr) {
+                error_setg(errp, "dynamic capacity must have a backing device");
+                return false;
+            }
 
-        if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
-            error_setg(errp, "memory backend %s can't be used multiple times.",
-               object_get_canonical_path_component(OBJECT(ct3d->dc.host_dc)));
-            return false;
-        }
-        /*
-         * Set DC regions as volatile for now, non-volatile support can
-         * be added in the future if needed.
-         */
-        memory_region_set_nonvolatile(dc_mr, false);
-        memory_region_set_enabled(dc_mr, true);
-        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
-        if (ds->id) {
-            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
-        } else {
-            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
+            if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
+                error_setg(errp,
+                           "memory backend %s can't be used multiple times.",
+                           object_get_canonical_path_component(
+                               OBJECT(ct3d->dc.host_dc)));
+                return false;
+            }
+            /*
+             * Set DC regions as volatile for now, non-volatile support can
+             * be added in the future if needed.
+             */
+            memory_region_set_nonvolatile(dc_mr, false);
+            memory_region_set_enabled(dc_mr, true);
+            host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
+            if (ds->id) {
+                dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
+            } else {
+                dc_name = g_strdup("cxl-dcd-dpa-dc-space");
+            }
+            address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
+            g_free(dc_name);
         }
-        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
-        g_free(dc_name);
 
         if (!cxl_create_dc_regions(ct3d, errp)) {
             error_append_hint(errp, "setup DC regions failed");
@@ -1361,6 +1373,8 @@ static const Property ct3_props[] = {
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_SIZE("dc-regions-total-size", CXLType3Dev,
+                     dc.total_capacity_cmd, 0),
     DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CXLType3Dev,
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
@@ -2305,6 +2319,12 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         return;
     }
 
+    if (dcd->dc.total_capacity_cmd) {
+        error_setg(errp,
+                   "dc-regions-total-size is set: extent add/release via QMP "
+                   "not yet supported without a backing device at init");
+        return;
+    }
 
     if (rid >= dcd->dc.num_regions) {
         error_setg(errp, "region id is too large");
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ba551fa5f9..630cf44e0e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -785,6 +785,7 @@ struct CXLType3Dev {
          * memory region size.
          */
         uint64_t total_capacity; /* 256M aligned */
+        uint64_t total_capacity_cmd; /* 256M aligned */
         CXLDCExtentList extents;
         CXLDCExtentGroupList extents_pending;
         uint32_t total_extent_count;
-- 
2.50.1 (Apple Git-155)

