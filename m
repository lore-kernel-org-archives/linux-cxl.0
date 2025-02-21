Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3578F20;
	Fri, 21 Feb 2025 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101565; cv=pass; b=OcQDXwA7fzwFLDYaUpNuFtjV+RN5OU00xMgHJac1SMx+gtwmqZvvzCx8o+sf0Vwq7J5KEg+J7q7/E8nkz2VTNarEAxrVUs8RN8KcVcmrRU/H9PW/W0WuepyhRzfGCFm/UFO5qgwn9qPyAYLXAe8bVPEUePgcQncNP6GCcXwawEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101565; c=relaxed/simple;
	bh=l2ia1P25YQ3Mf4mDhF0k4Q5xMVysd29f7M4fX3GmTKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFSNs41dVpvDVZ51BUn4JyxDvjHxBioq7qzeg8cdmwraerBzltB7o/cLNX8AmMsf3z8oYwTOKxz1ZqupZJIbxusdfzguce6qwWFmxE0+B7nrRkTBhoe1IbSztr1qXxPSLSbQO9eOyyaB8sz4x6DRMMllxU3A+Y7rPSubgq1PoU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=FB+m5EbW; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="FB+m5EbW"
ARC-Seal: i=1; a=rsa-sha256; t=1740101546; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Lu43KBZtEt7AFdDQImnyCTD3tI9u93k787RdZoT6lrq3GoQZYN5BqYIG0eXgxICwGaZ3Om9SX1IJcM6aOxGdzcjdRpbxsNDGckDo814Zvvwb4qGO572whzKtTCNzEB65rh1GAPE9qlRdJs9YEq3BiC5csIyRAcr6Kq+jc2XlvGs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101546; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XbeiqXG68L38/7TIuRvqSKkNvkHaENKByIF8L8Iwwag=; 
	b=F8/XI/oxXmoQfCNgjVsCrcOLh++tQOuZ2uiQs8HhmHQEJlA5XO4jQU02gdVtlXyUWZ+vfXp7MQ4kp5w+inTu9euoP8kxCM4tgaMzgtnvyZ6cT5gqkAk/XZX9atWfZS0v1dQIHJxi4Jgx5kK5uhAs3JfIlA8t9zGV7fIKyozIkFg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101546;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=XbeiqXG68L38/7TIuRvqSKkNvkHaENKByIF8L8Iwwag=;
	b=FB+m5EbWp8c4V+L0koNO9ccyGNA3SXW3VbajxyHTW8A1EzD6VvrNPJFZm49G0a4L
	ZIGOtge210cC97PMTe141zlNDiGeJAT+lCI8Px7654uhzNPuwvsSdyrY4SlKFOlLKR+
	mR2/I30Nfno2X70JLHDBLMnhvAlnfmB9Ma+igDH8=
Received: by mx.zohomail.com with SMTPS id 174010154362018.66000672863879;
	Thu, 20 Feb 2025 17:32:23 -0800 (PST)
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
Subject: [PATCH v3 7/7] cxl/region: Drop goto pattern of construct_region()
Date: Fri, 21 Feb 2025 09:32:05 +0800
Message-Id: <20250221013205.126419-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221012453.126366-1-ming.li@zohomail.com>
References: <20250221012453.126366-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122787e1089ae2cfd4493ccb2d0100005e49b58b3a16a64b6ce805ef390e6ff2bee79d0789ac43cbcf:zu080112271e8ff87ffc2ac7730f475cf80000f6a46113b88e0ffe05cc23c5ad4e1571e5f568cb4cbceef50c:rf0801122df3d6a5f08848c75d152a743800008096e50ab0d2c03a46f4357e7c1ba25604d2764f294324b0c49bbc4ad15a92:ZohoMail
X-ZohoMailClient: External

Some operations need to be protected by the cxl_region_rwsem in
construct_region(). Currently, construct_region() uses down_write() and
up_write() for the cxl_region_rwsem locking, so there is a goto pattern
after down_write() invoked to release cxl_region_rwsem.

construct region() can be optimized to remove the goto pattern. The
changes are creating a new function called __construct_region() which
will include all checking and operations protected by the
cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
and up_write() in __construct_region().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
v3:
- Drop the renaming of __construct_region() to construct_auto_region(). (Dan)
v2:
- Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)
---
 drivers/cxl/core/region.c | 81 +++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9f082bc0f4e3..3cb91cf0e2dd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3215,53 +3215,31 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return 0;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static int __construct_region(struct cxl_region *cxlr,
+			      struct cxl_root_decoder *cxlrd,
+			      struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct range *hpa = &cxled->cxld.hpa_range;
-	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region_params *p;
-	struct cxl_region *cxlr;
 	struct resource *res;
+	int rc;
 
-	if (part < 0)
-		return ERR_PTR(-EBUSY);
-
-	do {
-		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
-	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
-
-	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			__func__, PTR_ERR(cxlr));
-		return cxlr;
-	}
-
-	down_write(&cxl_region_rwsem);
+	guard(rwsem_write)(&cxl_region_rwsem);
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s autodiscovery interrupted\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__);
-		rc = -EBUSY;
-		goto err;
+		return -EBUSY;
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
-	if (!res) {
-		rc = -ENOMEM;
-		goto err;
-	}
+	if (!res)
+		return -ENOMEM;
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
@@ -3284,7 +3262,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
-		goto err;
+		return rc;
 
 	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
 		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
@@ -3293,14 +3271,43 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
-	up_write(&cxl_region_rwsem);
 
-	return cxlr;
+	return 0;
+}
 
-err:
-	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	return ERR_PTR(rc);
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	int rc, part = READ_ONCE(cxled->part);
+	struct cxl_region *cxlr;
+
+	if (part < 0)
+		return ERR_PTR(-EBUSY);
+
+	do {
+		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
+				       atomic_read(&cxlrd->region_id));
+	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
+
+	if (IS_ERR(cxlr)) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s failed assign region: %ld\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__, PTR_ERR(cxlr));
+		return cxlr;
+	}
+
+	rc = __construct_region(cxlr, cxlrd, cxled);
+	if (rc) {
+		devm_release_action(port->uport_dev, unregister_region, cxlr);
+		return ERR_PTR(rc);
+	}
+
+	return cxlr;
 }
 
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
-- 
2.34.1

