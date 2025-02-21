Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CD156CA;
	Fri, 21 Feb 2025 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101137; cv=pass; b=CqmT85FB3dyoOR/T3Gzqmk4idxLYZv+QSYXj+78RW5xrOwOuWjSvl0Z1GJO4IBIQPSvTa/GhYobx+kfiUImstev2dVPZwpMnYcGo8/ueH/FFeW0X1DNDWW9oewdMDsCx3Yu/Y+fcBieywZ4aa2CYlI3b+lqzwQL5wzquvr+A4PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101137; c=relaxed/simple;
	bh=0jjDmVZ0DWQeBFLkbUe54TAyFTfBgES6vjrbz49jGVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tx+60bxYUYy4L9i/hncZRpZwuyRh5Dg6LICdJKSVCn4+ZHTVmBPOGQdINhxslT9eUBR6XII8S18wgNHLtXQI+chlAqa2/YAYyp+41lK3s9IprsLo0r+8HgXKxxBBMssU/Pq1bROn02oxALwVZQgcaO2lrgZ7kn1WgfLfD8oVJmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=SEON03ai; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="SEON03ai"
ARC-Seal: i=1; a=rsa-sha256; t=1740101118; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kID90N5ufdzkaWmx0GcVUxUiBWeMy6x4KaivzKKfdz67aSG34LIHxMaeF8T7tsRHA/kvkt5OpbkcfTNk/Vkj4vgUY5+/Gjs8ilEGDFbCIPfD3SSV7Bpv+MRL0UH5sG6KsDrT2HhalHsmdsQHm/R9+LnYUS2Yu9dcZuV8uJhjO4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101118; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hrozyDGjYx56FYwETNUUKzYL8DMYbFGqaUYZpdLc5sc=; 
	b=EdQrFp/X77aEX4Xganhyw38iRC3rHq2rqUVmXsk7MKxBTFP/MdzDizWG0SoH0Pdhpn/ZvKZr0K8wAy/J7OEQrULgsJBLK1Nrp/fv+RZN9GptduEKfLhGHPlorIVqSvS6oVH4d5lj/7QNMjKNbfUS3utiL/pDixuAhXvgPvIJzGU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101118;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=hrozyDGjYx56FYwETNUUKzYL8DMYbFGqaUYZpdLc5sc=;
	b=SEON03aiXZjkoHwkBul4b6xRTTngkSHywGkVmJ1lu5kwvW54LREXZkYnjwSCRXpX
	+Hy+u0FOim+taWyptXNlWefxJ6DaSxUCwFuhchTadoZbK4RZcVGbOdDpI7E+Pz9bgya
	QLoGL/QuMunayN1oC+STc0n9STmx+RX2LT1+qsQA=
Received: by mx.zohomail.com with SMTPS id 1740101116470586.7723743964838;
	Thu, 20 Feb 2025 17:25:16 -0800 (PST)
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
Subject: [PATCH v3 1/7] cxl/core: Use guard() to replace open-coded down_read/write()
Date: Fri, 21 Feb 2025 09:24:47 +0800
Message-Id: <20250221012453.126366-2-ming.li@zohomail.com>
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
Feedback-ID: rr080112278d36a65c8aa006c08bf137a000002c31ebfd45cfefb89dde9021b0dc7e1d797bf71e783aa11e56:zu080112278c1d72eff5205966dbf48a580000111d16b3e441b3994305645ce53760af7bef5ee166c1ce3ce4:rf0801122d7259ba7d11d9a76e855f108b00007de08c766826de382087d62e9f79fdc05262ac10c6aaf94fff2f74c7634e8c:ZohoMail
X-ZohoMailClient: External

Some down/up_read() and down/up_write() cases can be replaced by a
guard() simply to drop explicit unlock invoked. It helps to align coding
style with current CXL subsystem's.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
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
index d705dec1471e..ad74b46d3e16 100644
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
 
@@ -281,9 +280,8 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 
 static void cxl_dpa_release(void *cxled)
 {
-	down_write(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_dpa_rwsem);
 	__cxl_dpa_release(cxled);
-	up_write(&cxl_dpa_rwsem);
 }
 
 /*
@@ -530,14 +528,11 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
 
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
index 2914e3ff104b..da692020980b 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -582,10 +582,9 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 
-	down_write(&cxl_memdev_rwsem);
+	guard(rwsem_write)(&cxl_memdev_rwsem);
 	bitmap_or(cxl_mbox->exclusive_cmds, cxl_mbox->exclusive_cmds,
 		  cmds, CXL_MEM_COMMAND_ID_MAX);
-	up_write(&cxl_memdev_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, "CXL");
 
@@ -599,10 +598,9 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 
-	down_write(&cxl_memdev_rwsem);
+	guard(rwsem_write)(&cxl_memdev_rwsem);
 	bitmap_andnot(cxl_mbox->exclusive_cmds, cxl_mbox->exclusive_cmds,
 		      cmds, CXL_MEM_COMMAND_ID_MAX);
-	up_write(&cxl_memdev_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, "CXL");
 
@@ -610,9 +608,8 @@ static void cxl_memdev_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
-	down_write(&cxl_memdev_rwsem);
+	guard(rwsem_write)(&cxl_memdev_rwsem);
 	cxlmd->cxlds = NULL;
-	up_write(&cxl_memdev_rwsem);
 }
 
 static void cxl_memdev_unregister(void *_cxlmd)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f9501a16b390..6a44b6dad3c7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -559,13 +559,9 @@ static ssize_t decoders_committed_show(struct device *dev,
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
index 84ce625b8591..8e68091e3f20 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3207,7 +3207,6 @@ static int match_region_by_range(struct device *dev, const void *data)
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	const struct range *r = data;
-	int rc = 0;
 
 	if (!is_cxl_region(dev))
 		return 0;
@@ -3215,12 +3214,11 @@ static int match_region_by_range(struct device *dev, const void *data)
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

