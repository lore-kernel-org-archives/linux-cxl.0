Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1579DA9
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581479; cv=none; b=hNivzozoJNj62loP4H5e2iTFy7BX4TWr6yg+EdRKYFUlRQUFyL191iL2yjiqZ82hbi3Me4tp2kUgJnHmO2KngfpJqKGB36B1tgxbdsthZtVUrwoJ3zFZkDbwwgUJ6Xrl4rCzqy36rsFWpz6fIKjuh64mZau55yfIhETjZV2wzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581479; c=relaxed/simple;
	bh=sxiGml8sSyPhzFwRAZ2KX5EroGcFTa5vXUesyH6hOR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GO4v2zUVpIV8U9gEp2FLwRPf+4kclNPjXVIA3ypBlFMPB3zlMGMAr7F2o6YosGoSpW5oTT1bWXcHFOaA5ShyJKLYsuveqZKp+tehiSoqen6glrjsWn/5L8zGby1CJzQD6T+SR8J6GsIBOxS10wnX3PXbh+FaEnZuo6LGPluL7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB5WgSXY; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB5WgSXY"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc742543119so4933308276.0
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581476; x=1710186276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKU7EMmrCEGIbEXLnUmzxmQlpe4p33ksgB+5YiuAYXs=;
        b=XB5WgSXYxtLITOXoGonqGBTz6Q8G+owJNeK7Xss1yQfPnnK/a2LafMTq3oa9ZyU4tO
         9yY6m/wLbvGw0oj4HlsRCkXrHXKTut3XBiIw+p5FLIJtk2Pq4QMY/ATj+aSSj1rpP3em
         FD496hldtYH75s5x0abhA/n5zVNnVBjMuOLecKwiq3xgetaRlwChBm2+Gh3dZr2r7p+o
         xG4VxQKPA+SNMp2jKPQeCGQVWOr7XJC/D1jMuV6FPNbgY9W56L4ATzSX+f3WjTTkBvbk
         GOMAaC1bh5/nKFK7lt/ioxVXAKqi/utKHRYEUf32nkJvr58DMTzJyoGdkgLQy3u68qCb
         j7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581476; x=1710186276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKU7EMmrCEGIbEXLnUmzxmQlpe4p33ksgB+5YiuAYXs=;
        b=cIGFCE0K1udoIRs4QH+rYzVVGN0zM1n6koUqw1O7vMMYY+Am+/vGDy6+e4VLIGtkt+
         0xLb0WFh/86eTs23CqO5gEKrYMnfDyC7iLtNXMFg5QxnNXcVscXWnUtn0QJeFPz1/OnN
         PduFVd+J9b12SqZkzTUZUHv/OCjbpaLFO2QHhMcXb48I4NVIdSqfHtT9ZAxfEsMp083M
         pbITKhmtJZfSgUefya3720KO1tUPD9XAtoOuwqzOsTiRl0XCRUv8kxDg9krE/ajZR26h
         4l+gWqhr0Sm7ACaQQfXVHJI5RbnhxUBHsVLwAdqNDsfITNRvZBr1OVNJb59/DfajZLyo
         XgjA==
X-Forwarded-Encrypted: i=1; AJvYcCWu3PZZCP/9Nuhct+qvkXnG2nS600pIaMsic0J12ODzfe0K1Z1uQsPAEjIKC7etEw0v1fb1Mj+BjyJvCcS3qxFbrjFCD12Gq0eY
X-Gm-Message-State: AOJu0Yy8w4SQOSBLdZsW/P8/yHWOTPT4r8MhKVTLtOnzudD3z3Zit3NB
	EXHwQYfU4VHPH2WX0GBq+Dl8vjfmgAWWc0QpLjf1JAMbX6YhAWD6
X-Google-Smtp-Source: AGHT+IGJaenBrz1oSac79n8j93VzbYMt0qiN1tC/RpBnCVT3yoX1a0NYTi0pRDY7jv1mKlEMaKgrEw==
X-Received: by 2002:a25:2690:0:b0:dc6:ff12:13d7 with SMTP id m138-20020a252690000000b00dc6ff1213d7mr5343408ybm.60.1709581476386;
        Mon, 04 Mar 2024 11:44:36 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:36 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out accepted and pending DC extents
Date: Mon,  4 Mar 2024 11:34:08 -0800
Message-ID: <20240304194331.1586191-14-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

With the change, we add the following two QMP interfaces to print out
extents information in the device,
1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
   the device;
2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
   DC extents in the device;
The output is appended to a file passed to the command and by default
it is /tmp/dc-extent.txt.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c       | 80 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c | 12 ++++++
 qapi/cxl.json            | 32 ++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5bd64e604e..6a08e7ae40 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2089,6 +2089,86 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
                                      region_id, records, errp);
 }
 
+static void cxl_dcd_display_extent_list(const CXLType3Dev *dcd, const char *f,
+                                        bool accepted_list, Error **errp)
+{
+    const CXLDCExtentList *list;
+    CXLDCExtent *ent;
+    FILE *fp = NULL;
+    int i = 0;
+
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return;
+    }
+
+    if (!f) {
+        fp = fopen("/tmp/dc-extent.txt", "a+");
+    } else {
+        fp = fopen(f, "a+");
+    }
+
+    if (!fp) {
+        error_setg(errp, "Open log file failed");
+        return;
+    }
+    if (accepted_list) {
+        list = &dcd->dc.extents;
+        fprintf(fp, "Print accepted extent info:\n");
+    } else {
+        list = &dcd->dc.extents_pending_to_add;
+        fprintf(fp, "Print pending-to-add extent info:\n");
+    }
+
+    QTAILQ_FOREACH(ent, list, node) {
+        fprintf(fp, "%d: [0x%lx - 0x%lx]\n", i++, ent->start_dpa,
+                               ent->start_dpa + ent->len);
+    }
+    fprintf(fp, "In total, %d extents printed!\n", i);
+    fclose(fp);
+}
+
+void qmp_cxl_display_accepted_dc_extents(const char *path, const char *f,
+                                         Error **errp)
+{
+    Object *obj;
+    CXLType3Dev *dcd;
+
+    obj = object_resolve_path(path, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path not point to a valid CXL type3 device");
+        return;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    cxl_dcd_display_extent_list(dcd, f, true, errp);
+}
+
+void qmp_cxl_display_pending_to_add_dc_extents(const char *path, const char *f,
+                                               Error **errp)
+{
+    Object *obj;
+    CXLType3Dev *dcd;
+
+    obj = object_resolve_path(path, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path not point to a valid CXL type3 device");
+        return;
+    }
+
+
+    dcd = CXL_TYPE3(obj);
+    cxl_dcd_display_extent_list(dcd, f, false, errp);
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index d913b11b4d..d896758301 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -81,3 +81,15 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+void qmp_cxl_display_accepted_dc_extents(const char *path, const char *f,
+                                         Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
+
+void qmp_cxl_display_pending_to_add_dc_extents(const char *path, const char *f,
+                                               Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 2645004666..6f10300ec6 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -420,3 +420,35 @@
             'extents': [ 'CXLDCExtentRecord' ]
            }
 }
+
+##
+# @cxl-display-accepted-dc-extents:
+#
+# Command to print out all the accepted DC extents in the device
+#
+# @path: CXL DCD canonical QOM path
+# @output: path of output file to dump the results to
+#
+# Since : 9.0
+##
+{ 'command': 'cxl-display-accepted-dc-extents',
+  'data': { 'path': 'str',
+            'output': 'str'
+           }
+}
+
+##
+# @cxl-display-pending-to-add-dc-extents:
+#
+# Command to print out all the pending-to-add DC extents in the device
+#
+# @path: CXL DCD canonical QOM path
+# @output: path of output file to dump the results to
+#
+# Since : 9.0
+##
+{ 'command': 'cxl-display-pending-to-add-dc-extents',
+  'data': { 'path': 'str',
+            'output': 'str'
+           }
+}
-- 
2.43.0

