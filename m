Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C31EE03B;
	Tue, 11 Feb 2025 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260755; cv=pass; b=bFLJ0mdmwaLN1QHl48y1fdKPnzJfQli4ElkT7Yyoc8EzoPX2mBIv6A0svta9pwWDMTi1+icEkuypiVOjsvIB5URZ97po9MXQT+0rO6XO61w1QTtlHJbtV1FEd/21UjLWXH2su2NTPeNUwaY7zCZKgPGfINVkRFBeLIz3u7dRAcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260755; c=relaxed/simple;
	bh=lJBCGL/Hh2TS6/s5qoC6JTS7hu4S+3tX/1ZzND8Kyr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clN1PIDF22viz2ZP85VVVIqRrIu8IGCmPSUfh25E+JlXJR/T1PRE0eyNKFPPk97StsyBRbFC4wc3ydMmgs0E64CjOAflmwKdoNzhk9jjHkG/3gIhSrFrjJ9yYn8RPGxK6JrWlGRqOdS/Vu7raFlg78JvZOffr9sMyK1zgiiz9iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=WZKO2OCl; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="WZKO2OCl"
ARC-Seal: i=1; a=rsa-sha256; t=1739260732; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Uv6gh6oYCe8Ir8pcCKm9Hm+yLXl67gqZvLJi4lyxxmSEteC5U6pSjYfoBa0vKQle8lO+Dy5Fotd51oyzDCWHPUZyBk2XfcBcifW8pOdCujFRl77WhN/8eW/YcbnK/6hWjl38QCtjXP0xaErGgL4GAwuWUjG3lMKKe2fa1nUuJPg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739260732; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6LwYrCD3X+PwbPksm0pt4YiasLveKpUgjhEnYam7Dcs=; 
	b=oHv9NwYVxskoSTei4TsXRX/2Vow8AfeZVrlea4GtD3Cb0Edo1JOgP4C/7H5biCmOqzHcRywGZ8E13cBRjvej9rOzW/NjwwbSk5Hsr39YiXCDIZuwLlmH9hOq+KYKEafMZTFoWN6iPpUV4CQCNfMYs13OvBSNYMTZRXSpCTnu/sk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739260732;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=6LwYrCD3X+PwbPksm0pt4YiasLveKpUgjhEnYam7Dcs=;
	b=WZKO2OClOkDBPXbMka54htAF8ZzrTmK4Xf4CVEgBN0XcIaWAol/9djJjqxd1xu7p
	fiQpOmJ8mkIdvFQs7JlH16tUluMKCkBBhnacE4/5PXD+/80n8Y82YxmTOCJMVX8iLKZ
	2FRQQGcAlBXI57P38/H1qhL3PRcKehVexMeeYgTM=
Received: by mx.zohomail.com with SMTPS id 1739260730470623.7889860661993;
	Mon, 10 Feb 2025 23:58:50 -0800 (PST)
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
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v1 7/7] cxl/region: Drop goto pattern of construct_region()
Date: Tue, 11 Feb 2025 15:57:27 +0800
Message-Id: <20250211075727.351895-8-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211075727.351895-1-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227a16d10b5d8d57337aeb4a1620000d3baf67c89913e38df482e4c14c0553e5fe5fdc1b30b84f8ff:zu08011227890ac9626327ec3b1e672446000023a22b6c450890102d8749d89a9a0f72cbe7bfc3443a4624c7:rf0801122dab5f529589e1b01a51ff49aa0000e659d3e0033e6df4da9ea8bfb638e91f382e7b40bbe40434fb92ee9a27be4a:ZohoMail
X-ZohoMailClient: External

Some operations need to be procted by the cxl_region_rwsem in construct
region(). Currently, construct_region() uses down_write() and up_write()
for the cxl_region_rwsem, so there is a goto pattern after down_write()
invoked to release cxl_region_rwsem.

construct region() can be optimized to remove the goto pattern. The
changes are creating a new function called __construct_region() which
will include all checking and operations protected by the
cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
and up_write() in __construct_region().

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 71 +++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 36f3771818d3..170278bdcedc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3217,49 +3217,31 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return rc;
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
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
-	struct cxl_region *cxlr;
 	struct resource *res;
 	int rc;
 
-	do {
-		cxlr = __create_region(cxlrd, cxled->mode,
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
@@ -3282,7 +3264,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
-		goto err;
+		return rc;
 
 	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
 		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
@@ -3291,14 +3273,39 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
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
+	struct cxl_region *cxlr;
+	int rc;
+
+	do {
+		cxlr = __create_region(cxlrd, cxled->mode,
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

