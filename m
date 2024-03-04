Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA279DC1
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581476; cv=none; b=ITla4errsU+J+Vv4KycCu7n3CgsqmvtWNcIi4Jzpcn3S3l/TKVwIXfx0wP+Y/2DazMke4Os7ro657KFazzE0pM847/2M2r5WuswLvkAcUNOPSLc4XdWch7gCVSipeJ3f2AbcilbQNFQrKI4J2jeKig12AeArgvu3PjeP1eTcHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581476; c=relaxed/simple;
	bh=yXmDFhk1WuzmTEaSI2rn7rAngNLiKIOtu3hJ1D5oISk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0MdyUBOYbUohOWnGiHvVP6Xj3gFZ5UXjjtNFoQlMePuy7WYSOLteRVBOvdozcgrmr3sNYWnN0BNs28TQuFHTDHb1kLtzjqW+zdN26VuUOu1WO/196KVNntIp/SsDWgA+GKvVNKZSlYgosjHgNyey90d+aBDefj5gA84CX7h3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqrtouZ1; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqrtouZ1"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db3a09e96daso4303950276.3
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581473; x=1710186273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaOcSj55m2vuHo7NOezYbOQrG1G43UvBtyGzB+x7te4=;
        b=VqrtouZ19ZibmHZZPBBfNVwGbsURSs5KGNT0PInroYAzVB+BtW03LxMonMd3ym5yXy
         Zq76hBobgQtKJqTxz1LvOFj0BFQK7g6k0Pt0mR1OO7hWOIozdCAB5/kJBPYgLUSatElS
         vPJIXOiKXqzXXxvZcy7uhHXa6d72eHVuICm+oKRDz7VAfm0lze86ZPF8+Tp8G42YrDTr
         5hHnQLdCz+cEQlTSWONCwefWZnihSPSJ8D5HowLA4zXYVXmu6kG1xg8rNSvdaUdqEQ16
         zbAGDc+TWn7MMWuOfm9skjTw9Fsru/eDnPubmE5Wl5pEieHBO/1pVVWYDE1+y6v/zgc/
         wZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581473; x=1710186273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaOcSj55m2vuHo7NOezYbOQrG1G43UvBtyGzB+x7te4=;
        b=UcsCUk1Y3f4ExoI6YJ5OEKZzOqWvzp9zoE5dfCXxz6QNQfW4zmbUjFX6e+4eLgPhq6
         TiJharbktXAaIZTj2d3YFiQNFW1UxwtSNdvB6WdDckycvBaiQHFEDGngxHMTwPgJtEqX
         nRtvBLkCarWh6N4KTb0bOtxcA8H2OUbncWd7lQS+eH62z/7MHP2LYXr/6MpTMWes3GK6
         33O/EQKtPYEYNtWyvbaAwPCA33p4orOID7fJu5kV3vAGfsmydyNo3j7Gs3y8TTIlVK5s
         i/N30kCM4svarAgktLFPZeIFgPjEViSgfW4M0J4xPm6oY9oKNwaCqzWku5J1dMUsUN3r
         8PfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzC7KgOUZPSYd2lmOr/eog8QRDvgN9K3WlZ6e5CbPAOiF+5lpkReqa6soDgHGrn8E8DJ3uGrDy//b8QRnHhkyoR978Hs9wFkU4
X-Gm-Message-State: AOJu0Yw50gVcwxCWjwwHHeJ0OO9eH9v+JSzVCJpDwx3Zqne200LmAV81
	WD2EZ5wTvmNjg6+UISG12/35rqjR6wqVSgEiEYjQaLmhinQinP2Grjx+R9tL
X-Google-Smtp-Source: AGHT+IGAUQ4G1g2oUYmUyuIpiZpE/G0LLDXICATQRHvrTwniiC32r7Y2rbFBwsEBLZHMsINmZ5Ysdg==
X-Received: by 2002:a5b:cd1:0:b0:dc2:1f53:3a4f with SMTP id e17-20020a5b0cd1000000b00dc21f533a4fmr7160003ybr.5.1709581473236;
        Mon, 04 Mar 2024 11:44:33 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:33 -0800 (PST)
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
Subject: [PATCH v5 12/13] hw/mem/cxl_type3: Allow to release partial extent and extent superset in QMP interface
Date: Mon,  4 Mar 2024 11:34:07 -0800
Message-ID: <20240304194331.1586191-13-nifan.cxl@gmail.com>
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

Before the change, the QMP interface used for add/release DC extents
only allows to release extents that exist in either pending-to-add list
or accepted list in the device, which means the DPA range of the extent must
match exactly that of an extent in either list. Otherwise, the release
request will be ignored.

With the change, we relax the constraints. As long as the DPA range of the
extent to release is covered by extents in one of the two lists
mentioned above, we allow the release.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 110 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 21 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c164cf4580..5bd64e604e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1802,28 +1802,79 @@ typedef enum CXLDCEventType {
 } CXLDCEventType;
 
 /*
- * Check whether the exact extent exists in the list
- * Return value: the extent pointer in the list; else null
+ * Testing whether the DPA range [dpa, dpa + len) is covered by
+ * extents in the list.
  */
-static CXLDCExtent *cxl_dc_extent_exists(CXLDCExtentList *list,
-                                         CXLDCExtentRaw *ext)
+static bool cxl_test_dpa_range_covered_by_extents(CXLDCExtentList *list,
+                                                  uint64_t dpa, uint64_t len)
 {
     CXLDCExtent *ent;
 
-    if (!ext || !list) {
-        return NULL;
+    if (!list) {
+        return false;
     }
 
-    QTAILQ_FOREACH(ent, list, node) {
-        if (ent->start_dpa != ext->start_dpa) {
-            continue;
-        }
+    while (len) {
+        bool has_leftover = false;
 
-        /* Found exact extent */
-        return ent->len == ext->len ? ent : NULL;
+        QTAILQ_FOREACH(ent, list, node) {
+            if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
+                if (dpa + len <= ent->start_dpa + ent->len) {
+                    return true;
+                } else {
+                    len = dpa + len - ent->start_dpa - ent->len;
+                    dpa = ent->start_dpa + ent->len;
+                    has_leftover = true;
+                    break;
+                }
+            }
+        }
+        if (!has_leftover) {
+            break;
+        }
     }
+    return false;
+}
+
+/*
+ * Remove all extents whose DPA range has overlaps with  the DPA range
+ * [dpa, dpa + len) from the list, and delete the overlapped portion.
+ * Note:
+ * 1. If the removed extents is fully within the DPA range, delete the extent;
+ * 2. Otherwise, keep the portion that does not overlap, insert new extents to
+ * the list if needed for the un-coverlapped part.
+ */
+static void cxl_delist_extent_by_dpa_range(CXLDCExtentList *list,
+                                           uint64_t dpa, uint64_t len)
+{
+    CXLDCExtent *ent;
 
-    return NULL;
+process_leftover:
+    QTAILQ_FOREACH(ent, list, node) {
+        if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
+            uint64_t ent_start_dpa = ent->start_dpa;
+            uint64_t ent_len = ent->len;
+            uint64_t len1 = dpa - ent_start_dpa;
+
+            cxl_remove_extent_from_extent_list(list, ent);
+            if (len1) {
+                cxl_insert_extent_to_extent_list(list, ent_start_dpa,
+                                                 len1, NULL, 0);
+            }
+
+            if (dpa + len <= ent_start_dpa + ent_len) {
+                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
+                if (len2) {
+                    cxl_insert_extent_to_extent_list(list, dpa + len,
+                                                     len2, NULL, 0);
+                }
+            } else {
+                len = dpa + len - ent_start_dpa - ent_len;
+                dpa = ent_start_dpa + ent_len;
+                goto process_leftover;
+            }
+        }
+    }
 }
 
 /*
@@ -1915,8 +1966,8 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
     list = records;
     extents = g_new0(CXLDCExtentRaw, num_extents);
     while (list) {
-        CXLDCExtent *ent;
         bool skip_extent = false;
+        CXLDCExtentList *extent_list;
 
         offset = list->value->offset;
         len = list->value->len;
@@ -1933,15 +1984,32 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
              * remove it from the pending extent list, so later when the add
              * response for the extent arrives, the device can reject the
              * extent as it is not in the pending list.
+             * Now, we can handle the case where the extent covers the DPA
+             * range of multiple extents in the pending_to_add list.
+             * TODO: we do not allow the extent covers range of extents in
+             * pending_to_add list and accepted list at the same time for now.
              */
-            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
-                        &extents[i]);
-            if (ent) {
-                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
-                g_free(ent);
+            extent_list = &dcd->dc.extents_pending_to_add;
+            if (cxl_test_dpa_range_covered_by_extents(extent_list,
+                                                      extents[i].start_dpa,
+                                                      extents[i].len)) {
+                cxl_delist_extent_by_dpa_range(extent_list,
+                                               extents[i].start_dpa,
+                                               extents[i].len);
+            } else if (!ct3_test_region_block_backed(dcd, extents[i].start_dpa,
+                                                     extents[i].len)) {
+                /*
+                 * If the DPA range of the extent is not covered by extents
+                 * in the accepted list, skip
+                 */
                 skip_extent = true;
-            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
-                /* If the exact extent is not in the accepted list, skip */
+            }
+        } else if (type == DC_EVENT_ADD_CAPACITY) {
+            extent_list = &dcd->dc.extents;
+            /* If the extent is ready pending to add, skip */
+            if (cxl_test_dpa_range_covered_by_extents(extent_list,
+                                                      extents[i].start_dpa,
+                                                      extents[i].len)) {
                 skip_extent = true;
             }
         }
-- 
2.43.0

