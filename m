Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6642222D1;
	Mon, 17 Feb 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803756; cv=pass; b=aDFFPVjd2YFu6t/nE8WGjadzAzL+ZeCuGKkuSkegmkKPgQM1zb6/G/S2KNGP2mBFjyaVfuZLp3N6j2JvDtXlrxGkllvKykTjoyjrAxNp33Lrfd45J6UY9m7RNqG2p9F3P72HPxFjqBiYJDzxwOpCJpQAIiC982Ys077rj7gdUUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803756; c=relaxed/simple;
	bh=j5rnVvhXjS0fp4vLFcuKjku1Vrlif66jGXAN8K5ae1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+piPdAcWfWHhzEjKksOCemucX/1wIfmAvpRqGEA7WfLQxEV/VTBlgTigLpjQZCWMd69Dn4m8+i5MCsUJYx8l9uYVyRSNVxkrYWVpe/+C7zYIsl8zCZYS7fBo8kD4ShyHTfcjuxGBi71RhFSJXU9Giv3bHmyvI+u7MqkKxIAwkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EHPo0kUX; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EHPo0kUX"
ARC-Seal: i=1; a=rsa-sha256; t=1739803736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VayC5VItgDuM/XfaxgiO594QQUnuCWKDidKxkaYshVXW18Q0nZqdkWEPkB8LZQZrQxAxq5DJqDJl4OJPFVR5WL67xCauKPd4w4ff+FHOpn4+UaV8iXAhHiCwj6diHeqLt+I13U07gqOp2z4X4C4YAlmNQDiWj0wSanaRhnIJKLc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803736; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AaEsjabfvnngmW6hr/bb/k32BBpUycgG3kyIthmnuxk=; 
	b=Gl2J7JtbPu3lhPT8rQcQcLL4bIPSxmtXFv49EH68MtOjiX3LK72WQMegTHVTgNrLNZEUV03h6BmYOt0QrG1Vsgfz7jvy5NoaIW2eM1nMSZ4k4UavmgCv4MRKcbvdKgtTGxgckf+t6oQyPpu9UNEh4w43ZJivw03K0IvCnnYfG+o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803735;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=AaEsjabfvnngmW6hr/bb/k32BBpUycgG3kyIthmnuxk=;
	b=EHPo0kUXaBNgIVlRaEhNxfPLN0rjJZA7Mg/tIaNd2crhbjjiGM6caVwWGe1y9CKf
	j8S716B3/uXqlPSDx1ISa7T1GGJIKS+EeUGL43rB2YyvDL6kBEJPriziNgC0noe9H+C
	00f2XVuxjIMazBXU06YVZZVo9SkgpsmudmGlFV8k=
Received: by mx.zohomail.com with SMTPS id 1739803733054890.5990768616672;
	Mon, 17 Feb 2025 06:48:53 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/7] cxl/core: Use guard() to replace open-coded down_read/write()
Date: Mon, 17 Feb 2025 22:48:22 +0800
Message-Id: <20250217144828.30651-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217144828.30651-1-ming.li@zohomail.com>
References: <20250217144828.30651-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227acac204fb3c8151c99a25145000070faa0f88922971c0cb1f3c5b7c9238d8e89a12c859171f0d6:zu080112272954007862cf36919bfa9c6e0000561f126de9b1c9b03846b8e44b797a08001aa80b7090d7e7d0:rf0801122dcb291df8be0a02025bd6eb960000341cc8f31c880c43310d4f9ebf2905145411140c7e35de049ba43fe7949a27:ZohoMail
X-ZohoMailClient: External

Some down/up_read() and down/up_write() cases can be replaced by a
guard() simply to drop explicit unlock invoked. It helps to align coding
style with current CXL subsystem's.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
v2:
- Drop some local variables. (Jonathan)
---
 drivers/cxl/core/hdm.c    | 15 +++++----------
 drivers/cxl/core/memdev.c |  9 +++------
 drivers/cxl/core/port.c   |  8 ++------
 drivers/cxl/core/region.c |  8 +++-----
 4 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 50e6a45b30ba..4a578092377e 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -213,13 +213,12 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 {
 	struct resource *p1, *p2;
 
-	down_read(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
 	for (p1 = cxlds->dpa_res.child; p1; p1 = p1->sibling) {
 		__cxl_dpa_debug(file, p1, 0);
 		for (p2 = p1->child; p2; p2 = p2->sibling)
 			__cxl_dpa_debug(file, p2, 1);
 	}
-	up_read(&cxl_dpa_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
 
@@ -250,9 +249,8 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 
 static void cxl_dpa_release(void *cxled)
 {
-	down_write(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_dpa_rwsem);
 	__cxl_dpa_release(cxled);
-	up_write(&cxl_dpa_rwsem);
 }
 
 /*
@@ -362,14 +360,11 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
 
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 {
-	resource_size_t size = 0;
-
-	down_read(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
 	if (cxled->dpa_res)
-		size = resource_size(cxled->dpa_res);
-	up_read(&cxl_dpa_rwsem);
+		return resource_size(cxled->dpa_res);
 
-	return size;
+	return 0;
 }
 
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index ae3dfcbe8938..98c05426aa4a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -564,10 +564,9 @@ EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds)
 {
-	down_write(&cxl_memdev_rwsem);
+	guard(rwsem_write)(&cxl_memdev_rwsem);
 	bitmap_or(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
 		  CXL_MEM_COMMAND_ID_MAX);
-	up_write(&cxl_memdev_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, "CXL");
 
@@ -579,10 +578,9 @@ EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, "CXL");
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds)
 {
-	down_write(&cxl_memdev_rwsem);
+	guard(rwsem_write)(&cxl_memdev_rwsem);
 	bitmap_andnot(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
 		      CXL_MEM_COMMAND_ID_MAX);
-	up_write(&cxl_memdev_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, "CXL");
 
@@ -590,9 +588,8 @@ static void cxl_memdev_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
-	down_write(&cxl_memdev_rwsem);
+	guard(rwsem_write)(&cxl_memdev_rwsem);
 	cxlmd->cxlds = NULL;
-	up_write(&cxl_memdev_rwsem);
 }
 
 static void cxl_memdev_unregister(void *_cxlmd)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..2c59d65bc18b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -549,13 +549,9 @@ static ssize_t decoders_committed_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	struct cxl_port *port = to_cxl_port(dev);
-	int rc;
-
-	down_read(&cxl_region_rwsem);
-	rc = sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	guard(rwsem_read)(&cxl_region_rwsem);
+	return sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
 }
 
 static DEVICE_ATTR_RO(decoders_committed);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e8d11a988fd9..d8a71f9f9fa5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3208,7 +3208,6 @@ static int match_region_by_range(struct device *dev, const void *data)
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	const struct range *r = data;
-	int rc = 0;
 
 	if (!is_cxl_region(dev))
 		return 0;
@@ -3216,12 +3215,11 @@ static int match_region_by_range(struct device *dev, const void *data)
 	cxlr = to_cxl_region(dev);
 	p = &cxlr->params;
 
-	down_read(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_region_rwsem);
 	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		rc = 1;
-	up_read(&cxl_region_rwsem);
+		return 1;
 
-	return rc;
+	return 0;
 }
 
 /* Establish an empty region covering the given HPA range */
-- 
2.34.1

