Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3D332601
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464487; cv=none; b=qRDfPh+ZXthMfiHfCh6dJCViZDdISLpsFaQiv+ALrPf/qJBViDkwcZoBZd1Ol9ocEKfvpU+Z8AQyIw12vIqSR1DyWObWb8/NTGqEFHTGNFOBmM/UkoIPyFTi2LtgrJqzo8vf9jy1t5Ia+DxOmxm6FXE/iZ3rIyXS0ftz4HPiI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464487; c=relaxed/simple;
	bh=GzdNRSZXMYgyrtLfHvG383Kct0SvZ8MNKqxwGIKtuXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r50kZQSWjkH2LQr/jUOO0ls6eDQ+Ttrbq9wERH9sZlwbMC+TocavKFPwW1s20Jwy0HA9A7NWtfUDcsl+G5mTgdx5kXTbbtg9yeQLbs4dCUk5vQH7gfGnapYq+UXBjhDeojtedeRGWWbs+dZZqFsG+pHsoHhnzMGp0vwasKP0RFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwrq2fRtzJ469d;
	Thu, 26 Mar 2026 02:47:55 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 5254F4056B;
	Thu, 26 Mar 2026 02:48:04 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:48:03 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity extent release
Date: Wed, 25 Mar 2026 18:42:57 +0000
Message-ID: <20260325184259.366-10-alireza.sanaee@huawei.com>
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

Add a small status query so orchestration layers can check whether a tagged
extent is still pending, committed, or no longer present after a release
request.

Introduce the ExtentStatus QAPI struct and the
cxl-release-dynamic-capacity-status command.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/mem/cxl_type3.c       | 85 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c | 10 +++++
 qapi/cxl.json            | 46 ++++++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d5fa8a530a..8999b36e61 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2635,6 +2635,91 @@ void cxl_remove_memory_alias(CXLType3Dev *dcd, struct CXLFixedWindow *fw,
     dcd->dc.direct_mr_bitmap &= ~(1u << hdm_id);
 }
 
+/*
+ * This function allows for a simple check to make sure that
+ * our extent is removed. It can be used by an orchestration layer.
+ */
+ExtentStatus *
+qmp_cxl_release_dynamic_capacity_status(const char *path,
+                                        uint16_t hid, uint8_t rid,
+                                        const char *tag,
+                                        Error **errp)
+{
+    Object *obj;
+    CXLType3Dev *dcd;
+    CXLDCExtentList *list = NULL;
+    CXLDCExtent *ent;
+    QemuUUID uuid_req;
+    ExtentStatus *res;
+
+    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve CXL type 3 device");
+        return NULL;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return NULL;
+    }
+
+    if (rid >= dcd->dc.num_regions) {
+        error_setg(errp, "Region id is too large");
+        return NULL;
+    }
+
+    if (!tag) {
+        error_setg(errp, "Tag must be valid");
+        return NULL;
+    }
+
+    list = &dcd->dc.extents;
+    qemu_uuid_parse(tag, &uuid_req);
+    res = g_new0(ExtentStatus, 1);
+
+    /* Check committed extents */
+    QTAILQ_FOREACH(ent, list, node) {
+        QemuUUID uuid_ext;
+        g_autofree char *uuid_str = NULL;
+        memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
+        if (qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
+            uuid_str = qemu_uuid_unparse_strdup(&uuid_ext);
+            res->status = g_strdup("Committed");
+            res->message =
+                g_strdup_printf("Found committed extent with tag %s dpa 0x%"
+                                PRIx64 " len 0x%" PRIx64,
+                                uuid_str, ent->start_dpa, ent->len);
+            return res;
+        }
+    }
+
+    /* Check pending extents (not yet committed by kernel) */
+    {
+        CXLDCExtentGroup *group;
+        QTAILQ_FOREACH(group, &dcd->dc.extents_pending, node) {
+            QTAILQ_FOREACH(ent, &group->list, node) {
+                QemuUUID uuid_ext;
+                g_autofree char *uuid_str = NULL;
+                memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
+                if (qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
+                    uuid_str = qemu_uuid_unparse_strdup(&uuid_ext);
+                    res->status = g_strdup("Pending");
+                    res->message =
+                        g_strdup_printf("Found pending extent with tag %s"
+                                        " dpa 0x%" PRIx64 " len 0x%" PRIx64,
+                                        uuid_str, ent->start_dpa, ent->len);
+                    return res;
+                }
+            }
+        }
+    }
+
+    res->status = g_strdup("Released");
+    res->message = g_strdup_printf("Tag %s released or not found", tag);
+    return res;
+}
+
 static void ct3_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 98292a931c..17f9414142 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -127,3 +127,13 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+ExtentStatus *qmp_cxl_release_dynamic_capacity_status(const char *path,
+                                                      uint16_t host_id,
+                                                      uint8_t region,
+                                                      const char *tag,
+                                                      Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+    return NULL;
+}
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 81d6198ba0..53325ba530 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -636,3 +636,49 @@
            },
   'features': [ 'unstable' ]
 }
+
+##
+# @ExtentStatus:
+# This is an object that describes the status of an extent.
+#
+# @status:   String indicating the overall result, e.g. "success".
+# @message:  Human-readable description of the outcome.
+#
+# Since: 9.1
+##
+{ 'struct': 'ExtentStatus',
+      'data': { 'status': 'str', 'message': 'str' }
+}
+
+##
+# @cxl-release-dynamic-capacity-status:
+#
+# This commands checks if an extent tag has been released or not.
+#
+# @path: path to the CXL Dynamic Capacity Device in the QOM tree.
+#
+# @host-id: The "Host ID" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-71.
+#
+# @region: The "Region Number" field as defined in Compute Express
+#     Link Specification, Revision 3.1, Table 7-71.  Valid range
+#     is from 0-7.
+#
+# @tag: The "Tag" field as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-71.
+#
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
+# Since: 9.1
+##
+{ 'command': 'cxl-release-dynamic-capacity-status',
+  'data': { 'path': 'str',
+            'host-id': 'uint16',
+            'region': 'uint8',
+            'tag': 'str'
+          },
+  'features': [ 'unstable' ],
+  'returns': 'ExtentStatus'
+}
-- 
2.50.1 (Apple Git-155)

