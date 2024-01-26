Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDA18626
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270556; cv=none; b=OhrIkINGZXdakrvpX6JmNllR4LvnXMprQ9sqBbX9mGngRX47uNcT/+1xPV9skgmPPGCSODmEu53tGWAl8Pr9e01EY6W2USca+ejhJdIVZUbMKowe/BK6vrERR39FjGs0YY/HTd0PMswh2lBEvRJPWL29GVhTctRCTm+QcIqwtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270556; c=relaxed/simple;
	bh=i2TD53N9LREKz2vT00JfHIuk9CIg2RgcBRXzDBtRjug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxCCx9MVJMZqWWmISx70kBvFJo6j2TgYyJf63NwxB1lLM8D6BwhxSsasjQW9MuQ7/l4psTzYTPkvsZqfl539VeOD2bQShSNSE1fDOlO65rAKd1MGPKnTaqMfxY6hAP7s5fyd3q/3fCQUAOKxUHNtvE2aWhBrj26IybAfX65QiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLx7d4hWFz6JBRG;
	Fri, 26 Jan 2024 19:59:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EB20140516;
	Fri, 26 Jan 2024 20:02:31 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:02:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, Stefan
 Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/12] hw/mem/cxl_type3: Drop handling of failure of g_malloc0() and g_malloc()
Date: Fri, 26 Jan 2024 12:01:22 +0000
Message-ID: <20240126120132.24248-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
References: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

As g_malloc0/g_malloc() will just exit QEMU on failure there is no
point in checking for it failing.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2: Fix up description to include g_malloc()
---
 hw/mem/cxl_type3.c | 52 +++++++---------------------------------------
 1 file changed, 7 insertions(+), 45 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 52647b4ac7..1b92a065a3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -42,9 +42,9 @@ enum {
     CT3_CDAT_NUM_ENTRIES
 };
 
-static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                         int dsmad_handle, MemoryRegion *mr,
-                                         bool is_pmem, uint64_t dpa_base)
+static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
+                                          int dsmad_handle, MemoryRegion *mr,
+                                          bool is_pmem, uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
     g_autofree CDATDslbis *dslbis0 = NULL;
@@ -54,9 +54,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     g_autofree CDATDsemts *dsemts = NULL;
 
     dsmas = g_malloc(sizeof(*dsmas));
-    if (!dsmas) {
-        return -ENOMEM;
-    }
     *dsmas = (CDATDsmas) {
         .header = {
             .type = CDAT_TYPE_DSMAS,
@@ -70,9 +67,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
 
     /* For now, no memory side cache, plausiblish numbers */
     dslbis0 = g_malloc(sizeof(*dslbis0));
-    if (!dslbis0) {
-        return -ENOMEM;
-    }
     *dslbis0 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
@@ -86,9 +80,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     dslbis1 = g_malloc(sizeof(*dslbis1));
-    if (!dslbis1) {
-        return -ENOMEM;
-    }
     *dslbis1 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
@@ -102,9 +93,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     dslbis2 = g_malloc(sizeof(*dslbis2));
-    if (!dslbis2) {
-        return -ENOMEM;
-    }
     *dslbis2 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
@@ -118,9 +106,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     dslbis3 = g_malloc(sizeof(*dslbis3));
-    if (!dslbis3) {
-        return -ENOMEM;
-    }
     *dslbis3 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
@@ -134,9 +119,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     dsemts = g_malloc(sizeof(*dsemts));
-    if (!dsemts) {
-        return -ENOMEM;
-    }
     *dsemts = (CDATDsemts) {
         .header = {
             .type = CDAT_TYPE_DSEMTS,
@@ -159,8 +141,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     cdat_table[CT3_CDAT_DSLBIS2] = g_steal_pointer(&dslbis2);
     cdat_table[CT3_CDAT_DSLBIS3] = g_steal_pointer(&dslbis3);
     cdat_table[CT3_CDAT_DSEMTS] = g_steal_pointer(&dsemts);
-
-    return 0;
 }
 
 static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
@@ -171,7 +151,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
-    int rc, i;
 
     if (!ct3d->hostpmem && !ct3d->hostvmem) {
         return 0;
@@ -194,27 +173,18 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     }
 
     table = g_malloc0(len * sizeof(*table));
-    if (!table) {
-        return -ENOMEM;
-    }
 
     /* Now fill them in */
     if (volatile_mr) {
-        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
-                                           false, 0);
-        if (rc < 0) {
-            return rc;
-        }
+        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
+                                      false, 0);
         cur_ent = CT3_CDAT_NUM_ENTRIES;
     }
 
     if (nonvolatile_mr) {
         uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
-        rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                           nonvolatile_mr, true, base);
-        if (rc < 0) {
-            goto error_cleanup;
-        }
+        ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
+                                      nonvolatile_mr, true, base);
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
     assert(len == cur_ent);
@@ -222,11 +192,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     *cdat_table = g_steal_pointer(&table);
 
     return len;
-error_cleanup:
-    for (i = 0; i < cur_ent; i++) {
-        g_free(table[i]);
-    }
-    return rc;
 }
 
 static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
@@ -1168,9 +1133,6 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
         }
 
         cxl_err = g_malloc0(sizeof(*cxl_err));
-        if (!cxl_err) {
-            return;
-        }
 
         cxl_err->type = cxl_err_code;
         while (header && header_count < 32) {
-- 
2.39.2

