Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313313E02A
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464455; cv=none; b=YJYk/Unu/z7tfseTyltcJA/pYqTl2FiV5RN4I+jkoln4D+dv+GA42BALjNtpTei/z50+Ef8reMmyQP3nB4ILPSs+a6VjZ4x2YkEXVVkORoBb5AbUis1xKYmYNCUTQy34OB+uaCjoje5jHBr+R0BtC73vdApWjgk1IEVCenGX0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464455; c=relaxed/simple;
	bh=QEQjBz7ZQIshXsAfsVROxUBglg7z3qtSZmGCamRRu04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkYEsE97BnRkZuCq4XJuls8U0cVgPiRkBoAp18Srcslo9vsCR+v+P8pvFretOw2j9mpSk84bl/PE5vMVExboLI3vBLcNf9Yec8+R/xwILRrmhSqwCaoLbxQ/F41v1Qnf2N+hBWo19SNJ5vfYNJsziuZ9oesN7rKqN7CeBT8FAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwrC0wMtzJ46DS;
	Thu, 26 Mar 2026 02:47:23 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 16DA640086;
	Thu, 26 Mar 2026 02:47:32 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:47:30 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 8/9] hw/cxl: Add tag-based dynamic-capacity release support
Date: Wed, 25 Mar 2026 18:42:56 +0000
Message-ID: <20260325184259.366-9-alireza.sanaee@huawei.com>
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

Add support for the tag-based dynamic-capacity release policy via the QMP
interface. The new path scans committed extents, selects those whose stored
tag matches the requested UUID, and emits a Release Dynamic Capacity event
for each matching range.

This is intentionally scoped to tag-driven selection. Prescriptive release
handling and the underlying extent teardown stay in the existing paths.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/mem/cxl_type3.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6b73d58358..d5fa8a530a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2492,6 +2492,63 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
 }
 
+static void qmp_cxl_process_dynamic_capacity_tag_based(const char *path,
+        uint16_t hid, CXLDCEventType type, uint8_t rid, const char *tag,
+        CxlDynamicCapacityExtentList *records, Error **errp)
+{
+    Object *obj;
+    CXLType3Dev *dcd;
+    CXLDCExtentList *list = NULL;
+    CXLDCExtent *ent;
+    g_autofree CXLDCExtentRaw *extents = NULL;
+
+    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve CXL type 3 device");
+        return;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return;
+    }
+
+    if (rid >= dcd->dc.num_regions) {
+        error_setg(errp, "region id is too large");
+        return;
+    }
+
+    QemuUUID uuid_req;
+    qemu_uuid_parse(tag, &uuid_req);
+
+    list = &dcd->dc.extents;
+    size_t cap = 8, n = 0;
+    extents = g_new0(CXLDCExtentRaw, cap);
+    QTAILQ_FOREACH(ent, list, node) {
+        QemuUUID uuid_ext;
+        memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
+        if (!qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
+            continue;
+        }
+
+        if (n == cap) {
+            cap *= 2;
+            extents = g_renew(CXLDCExtentRaw, extents, cap);
+        }
+
+        extents[n++] = (CXLDCExtentRaw){ .start_dpa = ent->start_dpa,
+                                         .len = ent->len,
+                                         .shared_seq = 0 };
+    }
+
+    if (n == 0) {
+        return;
+    }
+    extents = g_renew(CXLDCExtentRaw, extents, n);
+    cxl_create_dc_event_records_for_extents(dcd, type, extents, n);
+}
+
 void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
                                   CxlExtentSelectionPolicy sel_policy,
                                   uint8_t region, const char *tag,
@@ -2537,6 +2594,10 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
                                                       region, tag,
                                                       extents, errp);
         return;
+    case CXL_EXTENT_REMOVAL_POLICY_TAG_BASED:
+        qmp_cxl_process_dynamic_capacity_tag_based(path, host_id, type, region,
+                                                   tag, extents, errp);
+        return;
     default:
         error_setg(errp, "Removal policy not supported");
         return;
-- 
2.50.1 (Apple Git-155)

