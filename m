Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A426772A
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976911; cv=none; b=PDbca5Tm52Our6uYniHgkIy5ZPMRxq/ya/20zVpMIq2Bv12shtgyJRY8dYquD96e9yHM8TIYe401LSMT6tjmtxBfrjpMx+J+JVi7VUC3Kq0F5Z9Ss6bnMHX0DMha/m1mDm3eFBBJ41S5vy6MKrWTKuCXwosN1MrtRR8wARJOUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976911; c=relaxed/simple;
	bh=hqWvblfr2MQqSMMMQm5olR8gD//+bK5fTndZhC5CCiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH4fNVXCQeJzmAlUMAWEr6d28igDUwo6zDMmKuy32bQlkEGcdiAGFJF6CE0/DwoniW/jdDULWc04PByDE9LQOkKnEI/UrNRf9afOq6akCoOTKSgwPPg109GRQGYGTrB6tsQ9NfAUUIbSAKgPApDDe3+MsTq6s7vCLwryF/c8M4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti9ZEgQO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti9ZEgQO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234b440afa7so18093425ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976909; x=1751581709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNzdswBVnpQdWNT16OCETeREezHNIv1SZz5MkHcTEn8=;
        b=Ti9ZEgQOii1wPkppCE0kUAExr/U6/3VREVF1bIvAAzBpoKgxQq6uH9NDmW63XH2qb8
         kw/sRZYPUekdOFNgv8pw5RQKrYANYOKSwkmnS6PnY3iaIyxKngksDe+Qm85L7aph7TeY
         ob1OhfuJXVfq8SZ8g+uWajxGrJGrN89BBaab4kndPd/W0wVgSLJrvQZhERCWpitG6iYH
         gkNAeaC7V/6dI5YKYpHvAJ3ilKQIhkf9Aut1YHi90HL9I1fDFzIIZBli3w3l37ddCY7w
         iL3W7CrNeMVpre4O8E2jQvsXdNC9P8dJEAQ7IK7IZUmakhT7iMJqmnIAI6hyh2oJwMj0
         XaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976909; x=1751581709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNzdswBVnpQdWNT16OCETeREezHNIv1SZz5MkHcTEn8=;
        b=WEGkpWzjX9s4BA1zITWrR++e7yEnAKJc7PCsZeW/HWsjVs98kCXQMnmkHR+9/anv1W
         VPkP+Wo8dIUfq9DNYaT0KtC7j44AF/rzsYmcbO8RP4/IpnzqLjQ84TZZXFYqeLNamaMO
         QIiKrc5Wk16VXc/FPs1fEYVXkdNKXWaRCehnag8CGiXb8btyylvlJln+mMZJSSWQQh+2
         KmXG0H4L/jbKh2BIWCbb52B+0ijjRBDEliNNyJeUvq+XdEVEOixplSVAjMqd1KlpX/W7
         KilwoPjpXVRPMwRkXPKuTFOm+FgTeUrvlzimt4/zjLkz0KfsDxg9Tov9OkW0mHTJrFop
         SMeA==
X-Forwarded-Encrypted: i=1; AJvYcCVw7q+4qd+beO+91kbYVXeJTXYH+GjPMjInk2slLBB92jVosYeb+voPcHWPg6uqUqZaksyGgguiny0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwZt064r+HJ6EOymYsPMD8cgDF1rwQ29r9eOGbku+iOwciN4T
	rFhVqb9ihIqvhw/50AZwKh6w9/YjPbq1CIEMoNuxUjmk5fUK2iQB71p+
X-Gm-Gg: ASbGnctUFwz7/Ei46h+ykvuZodOh2IrfcEFz5XZo3ysDN8+vEaeXS8377SujqcFzoWn
	uMkkZVsmzyLL5y4WV+kCzcAEjG1M80eCqbsAtSZ2PyMHRw5M1q4UdwTIrpgH7Cn0l5uajBTwAsQ
	3N7loa3lNKl49/jpJFyklB6sodHy68R5liVbIxvQ+5CV5Xb9WFtvFPT3481/f5RGNmXqJDCOqph
	6KzTSNZAjEI0Yh5HqS4ogXLZcDV1XxDglKqZ82z+7QDDe+QFTx+kK8Sers63R2/lyF2o/L0gkQP
	dwynfaAB6/GsXgF4KpHX2S6Eb4vP1k2n+KQsg5MNwqq0tsk/8Vfn3RW683QutmpkrhoZFNCGNK/
	32iLhLmsvJ2jq0pD0aA==
X-Google-Smtp-Source: AGHT+IEoLN21IQhU3rd/hGmCc35DGpKEcYEcpyldg1wX32m6cPlhGIDY4ch+t8LStiJysEhJ+nzDOA==
X-Received: by 2002:a17:902:ce11:b0:235:5a9:976f with SMTP id d9443c01a7336-23ac462451bmr16428175ad.24.1750976909069;
        Thu, 26 Jun 2025 15:28:29 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:28 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v4 08/10] hw/cxl: create helper function to create DC Event Records from extents
Date: Thu, 26 Jun 2025 22:23:31 +0000
Message-ID: <20250626222743.1766404-9-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

Prepatory patch for following FMAPI Add/Release Patches. Refactors part
of qmp_cxl_process_dynamic_capacity_prescriptive() into a helper
function to create DC Event Records and insert in the event log.

Moves definition for CXL_NUM_EXTENTS_SUPPORTED to cxl.h so it can be
accessed by cxl-mailbox-utils.c and cxl-events.c, where the helper
function is defined.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-events.c         | 38 +++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  1 -
 hw/mem/cxl_type3.c          | 37 +-----------------------------------
 include/hw/cxl/cxl.h        |  1 +
 include/hw/cxl/cxl_device.h |  4 ++++
 5 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e467..724055f2cf 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -260,3 +260,41 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d)
         }
     }
 }
+
+void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                             CXLDCEventType type,
+                                             CXLDCExtentRaw extents[],
+                                             uint32_t ext_count)
+{
+    CXLEventDynamicCapacity event_rec = {};
+    int i;
+
+    cxl_assign_event_header(&event_rec.hdr,
+                            &dynamic_capacity_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(event_rec),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    event_rec.type = type;
+    event_rec.validity_flags = 1;
+    event_rec.host_id = 0;
+    event_rec.updated_region_id = 0;
+    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
+                              ct3d->dc.total_extent_count;
+
+    for (i = 0; i < ext_count; i++) {
+        memcpy(&event_rec.dynamic_capacity_extent,
+               &extents[i],
+               sizeof(CXLDCExtentRaw));
+        event_rec.flags = 0;
+        if (i < ext_count - 1) {
+            /* Set "More" flag */
+            event_rec.flags |= BIT(0);
+        }
+
+        if (cxl_event_insert(&ct3d->cxl_dstate,
+                             CXL_EVENT_TYPE_DYNAMIC_CAP,
+                             (CXLEventRecordRaw *)&event_rec)) {
+            cxl_event_irq_assert(ct3d);
+        }
+    }
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e3d54ed124..382c41c025 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -27,7 +27,6 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
-#define CXL_NUM_EXTENTS_SUPPORTED 512
 #define CXL_NUM_TAGS_SUPPORTED 0
 #define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
 #define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ee554a77be..9c2b9d197b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1957,15 +1957,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         CxlDynamicCapacityExtentList *records, Error **errp)
 {
     Object *obj;
-    CXLEventDynamicCapacity dCap = {};
-    CXLEventRecordHdr *hdr = &dCap.hdr;
     CXLType3Dev *dcd;
-    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
     uint32_t num_extents = 0;
     CxlDynamicCapacityExtentList *list;
     CXLDCExtentGroup *group = NULL;
     g_autofree CXLDCExtentRaw *extents = NULL;
-    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
     uint64_t dpa, offset, len, block_size;
     g_autofree unsigned long *blk_bitmap = NULL;
     int i;
@@ -2078,38 +2074,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         dcd->dc.total_extent_count += num_extents;
     }
 
-    /*
-     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
-     *
-     * All Dynamic Capacity event records shall set the Event Record Severity
-     * field in the Common Event Record Format to Informational Event. All
-     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
-     * Event Log.
-     */
-    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
-                            cxl_device_get_timestamp(&dcd->cxl_dstate));
-
-    dCap.type = type;
-    /* FIXME: for now, validity flag is cleared */
-    dCap.validity_flags = 0;
-    stw_le_p(&dCap.host_id, hid);
-    /* only valid for DC_REGION_CONFIG_UPDATED event */
-    dCap.updated_region_id = 0;
-    for (i = 0; i < num_extents; i++) {
-        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
-               sizeof(CXLDCExtentRaw));
-
-        dCap.flags = 0;
-        if (i < num_extents - 1) {
-            /* Set "More" flag */
-            dCap.flags |= BIT(0);
-        }
-
-        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
-                             (CXLEventRecordRaw *)&dCap)) {
-            cxl_event_irq_assert(dcd);
-        }
-    }
+    cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
 }
 
 void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..3ae4303383 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -23,6 +23,7 @@
 #define CXL_DEVICE_REG_BAR_IDX 2
 
 #define CXL_WINDOW_MAX 10
+#define CXL_NUM_EXTENTS_SUPPORTED 512
 
 typedef struct PXBCXLDev PXBCXLDev;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 82e3bc1a71..91ec1ba299 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -732,4 +732,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                             CXLDCEventType type,
+                                             CXLDCExtentRaw extents[],
+                                             uint32_t ext_count);
 #endif
-- 
2.47.2

