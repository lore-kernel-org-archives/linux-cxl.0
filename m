Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926AC53A7
	for <linux-cxl@vger.kernel.org>; Wed,  2 Jul 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472299; cv=none; b=mtPey6LGJrqSfrUibiEZan2IJEn7NT8MoZk259vofxgw7NVg84StXCO9BoTp1F/0yONI7jqdFvmdA6BDBWveeucRElmptHTmpPHkXqvrAL29l+SRC0kjaboktdCLgtkx9rJW1GMOKU37eMsaoUVET22IjyIeqh0SGdN+cFM4D7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472299; c=relaxed/simple;
	bh=sc0XkOBeobM7yOYTPU9yaQp2OCWafwZCORRJJ3gmEUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvA5lPk7k4T0uj7/+UqIPaBEmSQAvvdGKeStCoE4flLGVl7t0bgheeZ/C0aw+XdIdlKsGJO6bFhxcVN9f1e51eq1u8eBylhCW6sXu+wwPV53cLzUu7UlD3eh2wxJCvlU5JoM5SH9pB5a/nNhkaS6XQ2CD8Nw5SgvkYsZql5pDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXPm93mGxz6L594;
	Thu,  3 Jul 2025 00:02:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 246F91402F4;
	Thu,  3 Jul 2025 00:04:55 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Jul 2025 18:04:54 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
	<fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 05/11] hw/cxl: Move definition for dynamic_capacity_uuid and enum for DC event types to header
Date: Wed, 2 Jul 2025 17:02:11 +0100
Message-ID: <20250702160219.989731-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Anisa Su <anisa.su@samsung.com>

Move definition/enum to cxl_events.h for shared use in next patch

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 hw/mem/cxl_type3.c          | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..758b075a64 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
     uint32_t tags_avail;
 } QEMU_PACKED CXLEventDynamicCapacity;
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0fccd22800..cdd60079c4 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1876,21 +1876,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
-/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
-static const QemuUUID dynamic_capacity_uuid = {
-    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
-                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
-};
-
-typedef enum CXLDCEventType {
-    DC_EVENT_ADD_CAPACITY = 0x0,
-    DC_EVENT_RELEASE_CAPACITY = 0x1,
-    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
-    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
-    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
-    DC_EVENT_CAPACITY_RELEASED = 0x5,
-} CXLDCEventType;
-
 /*
  * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
  * the list.
-- 
2.48.1

