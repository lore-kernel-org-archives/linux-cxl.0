Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE42E7623
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231527; cv=none; b=SHmJqModk+QcIAFyX7EQH/Y1Gl/sYP00k8qLsVw90s8ALAzEQrsLIbgp9Yj2PjBpn2+OHcf3be1TQ5QBWogDzL5lcPQZe67FLz8o2EZWf1P+0LjFnK5lPoY35I4soBVjDFihAJP3iW15OgqpYfsMsUO7i69fAZ4DyKPIZA4Utxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231527; c=relaxed/simple;
	bh=8YsYVdzK2xXS/uvTjUlVirxk9QurQSxweeYWrOXK12M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFDO4qRLrTeuNxuj4TvvJMa2kK7XSFM5Z2p5ATeSSKe/4K6w84NjiL7Vwve6S3rh+7UOs++rzl9EL9z91WpAnPiCtagRO48DZVyOxXTEEkKT8M84E4Wf822khzjecDJEQBLOzywWGe7gKga8s9crUr9ePOA0dJnh/X1Vu3bVFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fN32X329NzHnGch;
	Sat, 28 Feb 2026 06:31:16 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (unknown [7.214.146.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1962240569;
	Sat, 28 Feb 2026 06:32:03 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.175.34) by
 dubpeml500008.china.huawei.com (7.214.146.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 22:32:02 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
	<peter.maydell@linaro.org>, <jonathan.cameron@huawei.com>,
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/3] hw/cxl: Add fixes in maintenance and memory sparing
Date: Fri, 27 Feb 2026 22:32:04 +0000
Message-ID: <20260227223207.972-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20260227223207.972-1-shiju.jose@huawei.com>
References: <20260227223207.972-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500008.china.huawei.com (7.214.146.94)

From: Shiju Jose <shiju.jose@huawei.com>

Add following fixes to the commit: hw/cxl: Add support for Maintenance
command and Post Package Repair (PPR).

1. In cxl_create_mem_sparing_event_records(), replace strncpy with memcpy to
solve coverity warning because full size of the array to use as length in
strncpy to copy the entire component id data, which is 16 bytes.

2. In cxl_maintenance_insert(),
 - replace strncpy with memcpy in to copy full data because component id is
   16 bytes data.
 - remove memset which is not required.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 4 ++--
 hw/mem/cxl_type3.c         | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c83b5f90d4..9c99422cd4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1994,8 +1994,8 @@ static void cxl_create_mem_sparing_event_records(CXLType3Dev *ct3d,
         stw_le_p(&event_rec.column, ent->column);
         event_rec.sub_channel = ent->sub_channel;
         if (ent->validity_flags & CXL_MSER_VALID_COMP_ID) {
-            strncpy((char *)event_rec.component_id, (char *)ent->component_id,
-                    sizeof(event_rec.component_id));
+            memcpy(event_rec.component_id, ent->component_id,
+                   sizeof(event_rec.component_id));
         }
     } else if (sparing_pi) {
         event_rec.flags = CXL_MSER_FLAGS_QUERY_RESOURCES;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4739239da3..3cb1096e16 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1767,7 +1767,6 @@ static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
         }
     }
     m = g_new0(CXLMaintenance, 1);
-    memset(m, 0, sizeof(*m));
     m->dpa = dpa;
     m->validity_flags = 0;
 
@@ -1804,8 +1803,7 @@ static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
         m->validity_flags |= CXL_MSER_VALID_SUB_CHANNEL;
     }
     if (component_id) {
-        strncpy((char *)m->component_id, component_id,
-                sizeof(m->component_id) - 1);
+        memcpy(m->component_id, component_id, sizeof(m->component_id));
         m->validity_flags |= CXL_MSER_VALID_COMP_ID;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             m->validity_flags |= CXL_MSER_VALID_COMP_ID_FORMAT;
-- 
2.43.0

