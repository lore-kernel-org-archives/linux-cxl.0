Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C42248AC;
	Mon, 17 Feb 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803949; cv=pass; b=jjpMF52PiuwBPtvR0qr4kyo3NcwrVioWx/F1TV0NuF6CAvEnq9a46BOjofix7pvtiwrluVj9Zeew5oZMOQA2kcDbYHrrdeZW/teBN0xl0beYHdERbzd7BmB2JaBSrf5gDO1W0znbYiPHotOMWuJ/bZfFygGWrn17yCkIoboRT0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803949; c=relaxed/simple;
	bh=JRmCF9LjmJYKWivhjQ6n8IMZFxSXDeNdiP8wgPC7wg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EkkZGQ5h2PeTNLYz7333gduhTT6310n1Xw+Yf2bS4icVps5TRLkmzLVBaNgsTMop9vkrL06p/f5NO5Hds9AsKS5rSYz3Ja6PbUDC/MM6Tn5TFSiD6nzecyGU5ZHxB5UZDSZG8YHaZjEYQrve5MZrYeVi5LVkBr6NE0DEAYL/QJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=TW/TVcc6; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="TW/TVcc6"
ARC-Seal: i=1; a=rsa-sha256; t=1739803806; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UqiwUddfNdEJ/ycmxXdmA38GekVPzC7NL83fV3PdbunGGkpW6BZWqBg/mz4jExLuehulmOar8psrWw0AZbsH72dDH27ioAcXgTbXsgeHcZ6/rrK+tTd2mNjcbO2xbVWmAqf5A0pFyBRk7+poykB50JNs3/2ifC24z6Dl7xirPkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803806; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u5TjcDD2fVC5Z7fmg3HTZT6iZIZPELI9FVatCCA70pE=; 
	b=JCObFY58kyM/3qfU+hAY6rnwKW7vc+YW4EJSIFVrDEIYBrnt1IWnU5SsVQk2qb+aJ+nwSCz7UDsB0QUl6NQYQ3W8xl64UBR2HE9MMg2j71WMMuIfSZHFBwdsqAgaegonNS2m3xWjK/aDb2xJDxFxPEXZEePKmSuZGSPUv3x6idU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803806;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=u5TjcDD2fVC5Z7fmg3HTZT6iZIZPELI9FVatCCA70pE=;
	b=TW/TVcc6KoDGSDzqzNLWxrpINcDFMI7E9zZAO83NE9Ib/LB7/BNAkA69CRhKCD6d
	93doKC2o251DrvXKPZqiYwJTWJLFEbjIBzH3lgtaC8xKsCR51yPPrjuhxxDK4KycWja
	mphbbfrvlBGGnOzb889zmvUy7BLnwTRS+jLz5sac=
Received: by mx.zohomail.com with SMTPS id 173980380247995.30722494540043;
	Mon, 17 Feb 2025 06:50:02 -0800 (PST)
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
Subject: [PATCH v2 7/7] cxl/region: Drop goto pattern of construct_region()
Date: Mon, 17 Feb 2025 22:48:28 +0800
Message-Id: <20250217144828.30651-8-ming.li@zohomail.com>
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
Feedback-ID: rr080112270a1b3a40a4862390f0c7011f0000a6533c9e532b319b72bcea67a4ff7b47a766f9ac6b7a87cf67:zu08011227637483a4a31eb2f0b8ceb2e6000059b8d4e13f7089160e231c8be7dbb43f030a73e70a3b9635e1:rf0801122d5c87afa6af03d5275597f33e000026a3925e33887a0b88a34465cb4731f8771e61e7a209610abb740fad050b8a:ZohoMail
X-ZohoMailClient: External

Some operations need to be protected by the cxl_region_rwsem in
construct_region(). Currently, construct_region() uses down_write() and
up_write() for the cxl_region_rwsem locking, so there is a goto pattern
after down_write() invoked to release cxl_region_rwsem.

construct region() can be optimized to remove the goto pattern. The
changes are creating a new function called construct_auto_region() which
will include all checking and operations protected by the
cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
and up_write() in construct_auto_region().

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
v2:
- Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)
---
 drivers/cxl/core/region.c | 71 +++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 320a3f218131..7a9e51aba9f4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3216,49 +3216,31 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return 0;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static int construct_auto_region(struct cxl_region *cxlr,
+				 struct cxl_root_decoder *cxlrd,
+				 struct cxl_endpoint_decoder *cxled)
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
@@ -3281,7 +3263,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
-		goto err;
+		return rc;
 
 	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
 		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
@@ -3290,14 +3272,39 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
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
+	rc = construct_auto_region(cxlr, cxlrd, cxled);
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

