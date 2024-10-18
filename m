Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F820262C
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267998; cv=none; b=tAuQkYrQhiL2Y8DKMaP7/wcGG7hhUEd+oZa+n5gzNuosUMP1xiFv3cyY4YZnokvYQbvS5zLepCMDtiZUfR+UXLgq4yZ9kIlQB9XTKGK2d4R2QSRPeIX26tr+juf9nGUu4H4PB+yxF3rwAC9oYdX6wxb31IVkJqyIBAgky4svZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267998; c=relaxed/simple;
	bh=IqaB/KGMVFL/KaoreSmMSXUrTD1rAXjaUaimBbMlXdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0h73vwlda7jdNOxweiXeT9htKwUatEenk4L7Rf4l+djf+FEb0Hv90dDDE2hsTY/aHXBPtdtUcMEyzz4nqtleZtOQmU9TwY9XbqLI/Lsi3eF/8IpNIVC01ul3yPPZGMHU/uzwkgnOqLTp/F3aNMTedN37AI2X3BB0C2Qm7tFyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Y2JzrUdB; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Y2JzrUdB"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b150dc7bc0so147757785a.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 09:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729267995; x=1729872795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWkU6s2NOVNttOr0QYI8NeG1kjlYmYzZJu3z4aGvls0=;
        b=Y2JzrUdB7lNys90UcbzyOdsq6bOrrDRMWkRa0CTqCjWlrVaQml34Z5ZpYH/l2Z9XtU
         3u6NHjeiHRIpi8l3WnLf78WvBrBwoaaJiu7PjnH6H6VrCpDkywkWou/IaB9nVIgNdNwJ
         B8qoXS2cnLe5ixHNqrKg21TfxcnNofYMEqOx5Rl0Zx/80IZ6jnRo58dZK4gKl3H6NPEm
         MZBfOX5ym4u607FTXoIpeZdHit1oLpFvTDuUHFeVJ+fOhIQZrn12T7yNv56LMVkXONeE
         0Y2Ez08fvV/uPVIrFa46rD6kXYgqHAku9PhMB5foDq4IfqszpkYBvqmJKK4ihsKKDqFE
         ORrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267995; x=1729872795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWkU6s2NOVNttOr0QYI8NeG1kjlYmYzZJu3z4aGvls0=;
        b=E0x9Rywm90E5nWYzx3PU3Ne6FKaBCx8l5MVY3Cd1wjEFxgogPLDm2WUG7FP3Ad/YKW
         s/GemuRd5FZ5y0HjpmeDEHr6Ur84e+mQYnLlfDpKkcz4xDiBRqiuaV+tmVButh6cfhmZ
         HxD7J6rmkbb3vG8vkrrYqSUnjJQrO4rUolTCqq9lY/mFQT+ftidUGE0LN6J64QvXpHq8
         2Oxv2pkI/NltN7CraG4/kiTueW32as2hwL8F/zafGbXxjBQxuyHXnw3GgAjzdB2Zf3NM
         Qdpb4DEJlmrdZrKG8hNd6z19+aLvmi/O5Ur32WtLLfiMDH9Vss6pRQSXjNyz9H6XhApi
         HVWA==
X-Gm-Message-State: AOJu0YzT5Fjq0iP50zzb82BcV/XeYiFdkNWRT2gsy+sjql2MEmRdEDVL
	ubxLe14lgh5Czf6LSWS4iBZxDlPzE+tL1mPMH9Rh/riL8ZgfcF75zISRO/3VH++II6R902YLPlS
	0
X-Google-Smtp-Source: AGHT+IEqKAO0ketnSqmhUBvPOV068tf2A5Q37gpR9t7bNJ8EjmxgVJSGSr2XZ2oPQNDkOHcwr/ymVw==
X-Received: by 2002:a05:620a:2492:b0:7b1:4579:61fa with SMTP id af79cd13be357-7b157beea8fmr371565785a.55.1729267994804;
        Fri, 18 Oct 2024 09:13:14 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156fa55cfsm81677385a.67.2024.10.18.09.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:13:14 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	svetly.todorov@memverge.com,
	jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com
Subject: [PATCH RFC v3 2/3] cxl_type3: add MHD callbacks
Date: Fri, 18 Oct 2024 12:12:51 -0400
Message-ID: <20241018161252.8896-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018161252.8896-1-gourry@gourry.net>
References: <20241018161252.8896-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Svetly Todorov <svetly.todorov@memverge.com>

Introduce an API for validating DC adds, removes, and responses
against a multi-headed device.

mhd_reserve_extents() is called during a DC add request. This allows
a multi-headed device to check whether the requested extents belong
to another host. If not, then this function can claim those extents
in the MHD state and allow the cxl_type3 code to follow suit in the
host-local blk_bitmap.

mhd_reclaim_extents() is called during the DC add response. It allows
the MHD to reclaim extents that were preallocated to a host during the
request but rejected in the response.

mhd_release_extent() is called during the DC release response. It can
be invoked after a host frees an extent in its local bitmap, allowing
the MHD handler to release that same extent in the multi-host state.

Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 28 +++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 17 +++++++++++++++++
 include/hw/cxl/cxl_device.h |  8 ++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 10de26605c..112272e9ac 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2545,6 +2545,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 {
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDCExtentList *extent_list = &ct3d->dc.extents;
     uint32_t i;
     uint64_t dpa, len;
@@ -2579,6 +2580,11 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
         ct3d->dc.total_extent_count += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
     }
+
+    if (cvc->mhd_reclaim_extents)
+        cvc->mhd_reclaim_extents(&ct3d->parent_obj, &ct3d->dc.extents_pending,
+                in);
+
     /* Remove the first extent group in the pending list */
     cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
 
@@ -2612,6 +2618,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         uint32_t *updated_list_size)
 {
     CXLDCExtent *ent, *ent_next;
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t dpa, len;
     uint32_t i;
     int cnt_delta = 0;
@@ -2632,6 +2639,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
             goto free_and_exit;
         }
 
+        /* In an MHD, check that this DPA range belongs to this host */
+        if (cvc->mhd_access_valid &&
+            !cvc->mhd_access_valid(&ct3d->parent_obj, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+
         /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, updated_list, node) {
@@ -2704,9 +2718,11 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
 {
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDCExtentList updated_list;
     CXLDCExtent *ent, *ent_next;
-    uint32_t updated_list_size;
+    uint32_t updated_list_size, i;
+    uint64_t dpa, len;
     CXLRetCode ret;
 
     if (in->num_entries_updated == 0) {
@@ -2724,6 +2740,16 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
         return ret;
     }
 
+    /* Updated_entries contains the released extents. Free those in the MHD */
+    for (i = 0; cvc->mhd_release_extent && i < in->num_entries_updated; ++i) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        if (cvc->mhd_release_extent) {
+            cvc->mhd_release_extent(&ct3d->parent_obj, dpa, len);
+        }
+    }
+
     /*
      * If the dry run release passes, the returned updated_list will
      * be the updated extent list and we just need to clear the extents
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b7b24b6a32..a94b9931d2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -799,6 +799,7 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group, *group_next;
+    CXLType3Class *cvc = CXL_TYPE3_CLASS(ct3d);
     int i;
     CXLDCRegion *region;
 
@@ -817,6 +818,10 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
     for (i = 0; i < ct3d->dc.num_regions; i++) {
         region = &ct3d->dc.regions[i];
         g_free(region->blk_bitmap);
+        if (cvc->mhd_release_extent) {
+            cvc->mhd_release_extent(&ct3d->parent_obj, region->base,
+                    region->len);
+        }
     }
 }
 
@@ -2077,6 +2082,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     CXLEventDynamicCapacity dCap = {};
     CXLEventRecordHdr *hdr = &dCap.hdr;
     CXLType3Dev *dcd;
+    CXLType3Class *cvc;
     uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
     uint32_t num_extents = 0;
     CxlDynamicCapacityExtentList *list;
@@ -2094,6 +2100,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     }
 
     dcd = CXL_TYPE3(obj);
+    cvc = CXL_TYPE3_GET_CLASS(dcd);
     if (!dcd->dc.num_regions) {
         error_setg(errp, "No dynamic capacity support from the device");
         return;
@@ -2166,6 +2173,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         num_extents++;
     }
 
+    /* If this is an MHD, attempt to reserve the extents */
+    if (type == DC_EVENT_ADD_CAPACITY && cvc->mhd_reserve_extents &&
+       !cvc->mhd_reserve_extents(&dcd->parent_obj, records, rid)) {
+        error_setg(errp, "mhsld is enabled and extent reservation failed");
+        return;
+    }
+
     /* Create extent list for event being passed to host */
     i = 0;
     list = records;
@@ -2304,6 +2318,9 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->set_cacheline = set_cacheline;
     cvc->mhd_get_info = NULL;
     cvc->mhd_access_valid = NULL;
+    cvc->mhd_reserve_extents = NULL;
+    cvc->mhd_reclaim_extents = NULL;
+    cvc->mhd_release_extent = NULL;
 }
 
 static const TypeInfo ct3d_info = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b2dc7fb769..13c97b576f 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -14,6 +14,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/register.h"
 #include "hw/cxl/cxl_events.h"
+#include "qapi/qapi-commands-cxl.h"
 
 #include "hw/cxl/cxl_cpmu.h"
 /*
@@ -682,6 +683,13 @@ struct CXLType3Class {
                                size_t *len_out,
                                CXLCCI *cci);
     bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
+    bool (*mhd_reserve_extents)(PCIDevice *d,
+                                CxlDynamicCapacityExtentList *records,
+                                uint8_t rid);
+    bool (*mhd_reclaim_extents)(PCIDevice *d,
+                                CXLDCExtentGroupList *groups,
+                                CXLUpdateDCExtentListInPl *in);
+    bool (*mhd_release_extent)(PCIDevice *d, uint64_t dpa, uint64_t len);
 };
 
 struct CSWMBCCIDev {
-- 
2.43.0

