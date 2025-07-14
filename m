Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4F1E9B2F
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515269; cv=none; b=bgp+s1yS+pekvUOiyeKTMO2BojPDUCd0HOJBBtZcHO8dLD2/5ZRlo1WWsS+hNwhvap3ovkFwUL/JX1ElEfhwTa6Nm55nGx8ygY8YByrvXnBqg4mE/p9Qrs5lCWFwn0ypCk1vAGAPLdJgIMsou5d7qvtwZxAkVcZpWujJt0k1xqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515269; c=relaxed/simple;
	bh=II4UeUwNuuyO1h1T9Q+jI5UAD40cjcmDbO+v96tHbyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnargZLZM1VLWX/eJKZHbLgDNEtukZj8j64mx72FITW/vbKUCz1dck3kuE0ica4aybZ6ku3qHiHiaCjXGlPL3IH0izpgu0IbAGswEgW5E/S+BQM8Grv6LkWrM6vPLP5VN9x/XsStuqg5Go2V70otjP3Cb5+Eo/ja1AbtBOQyy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgqWN092dz6L5W0;
	Tue, 15 Jul 2025 01:46:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D2CC140142;
	Tue, 15 Jul 2025 01:47:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:47:44 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Anisa Su
	<anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu v2 05/11] hw/cxl: Move definition for dynamic_capacity_uuid and enum for DC event types to header
Date: Mon, 14 Jul 2025 18:45:01 +0100
Message-ID: <20250714174509.1984430-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
References: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
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
index 6b0889c9ae..52d3910ed9 100644
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

