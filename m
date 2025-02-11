Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB861EE006;
	Tue, 11 Feb 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260732; cv=pass; b=b1FqB5d4vTDv6pkQ/ak9FP1NUmLsYCr6W95TY8PFRam5lmxqC5p+hf+EMRhBIWePDzxiJQJpbV6Dab4a9esQyRCnaeciDIN4YYMTSTV8wHLqVfYbuj7IF3svk1MP2bx/wvhQgmHPod7TAo1hsJZ+xkDG5tvd/ZbfG1EJq3cqCuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260732; c=relaxed/simple;
	bh=vkzV05Gs7XYdaSqllXxUzjJhF64gmbcaH6g2i+S1ZeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJJxfIJKvEhDMLPRVHQajro9yfmCluc8OLIcJNLE198DS2iPpSq89/XtYIXTHBrocstsy53ePq/QKFtIhoD3sSB5cHJA6iPy6pPmG+C1Difu1K4xSguFbrZI6etrBBQiZ5aygOoTeMh0j9QGoo9dUofzAjaHQbSmshSYuPYX5eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=A5dWF/Kz; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="A5dWF/Kz"
ARC-Seal: i=1; a=rsa-sha256; t=1739260712; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E1gBDwoi1Bb3lNK+4qkoTEZex4ubrnfuAPBvPXkoCfbB5isbTP0P/EBna+FF+iszCOo/dbWhwxr9gLC1bnPpk6acL3SvR2uNmrRhPNcn0DMQGYfY66GixQb7h/+EA8xBQLpNTPuM8inYeWiO/GcaXobox8KhDNa7dcLEs2EIKdY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739260712; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xo6LVXxBk8luultuiNJGM+k/vs2dVpcg7QsqMgG6nvU=; 
	b=horctQeFEaGeMzlpr/JWuRLJ+AlIAku/xf5AYvy81NiLfhb6CO4QusOFPZMamVnhUc4h2B3OI0cntbLe+iQEojkIVmpJC4EqeqPr3LhgGR49X0q69PfIxmKu0nn60YQT+hocc3dDkf/CgStmynUMhokSGVvBDlbiN1Ebm0r9xmM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739260712;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=xo6LVXxBk8luultuiNJGM+k/vs2dVpcg7QsqMgG6nvU=;
	b=A5dWF/KzsxL7i7pDrDwFEQqP/exZlGSOsQyhyG9dLxg80G5aEnKrLE2oY8POdigD
	Y97Ku2W59bbIKM5EAttIXCfTMGb6Lylle6AytO0S3Uen0bTi1ol6QAvwXQYHlAn+oh+
	6Qo00dYJBKX/WCVpSsWeB6F/pFCFhKX+UPQMCpsU=
Received: by mx.zohomail.com with SMTPS id 1739260710354138.37583421281113;
	Mon, 10 Feb 2025 23:58:30 -0800 (PST)
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
Subject: [PATCH v1 5/7] cxl/core: Use guard() to drop goto pattern of cxl_dpa_alloc()
Date: Tue, 11 Feb 2025 15:57:25 +0800
Message-Id: <20250211075727.351895-6-ming.li@zohomail.com>
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
Feedback-ID: rr0801122718be4e9ab09d08c67a3cc64800002b9f99af80e6f326acc9192af39c5ebdb4e95f8c4d79872a8a:zu08011227c20d155d6494045a0e02dae400007bc391ada48f10dc61b8d786c1a634e274d56516271839e98d:rf0801122d406f06170db6aa24e559e01c00002326dc041cb13330494fd9232a8015ac92e5e2de37282883b4153bd53237b7:ZohoMail
X-ZohoMailClient: External

In cxl_dpa_alloc(), some checking and operations need to be protected by
a rwsem called cxl_dpa_rwsem, so there is a goto pattern in
cxl_dpa_alloc() to release the rwsem. The goto pattern can be optimized
by using guard() to hold the rwsem.

Creating a new function called __cxl_dpa_alloc() to include all checking
and operations needed to be procted by cxl_dpa_rwsem. Using
guard(rwsem_write()) to hold cxl_dpa_rwsem at the beginning of the new
function.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/hdm.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4d753520a79a..27813c430db9 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -444,29 +444,25 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
-int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	resource_size_t free_ram_start, free_pmem_start;
-	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxled->cxld.dev;
 	resource_size_t start, avail, skip;
 	struct resource *p, *last;
-	int rc;
 
-	down_write(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_dpa_rwsem);
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder attached to %s\n",
 			dev_name(&cxled->cxld.region->dev));
-		rc = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
 		dev_dbg(dev, "decoder enabled\n");
-		rc = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 
 	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
@@ -506,21 +502,24 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 		skip = skip_end - skip_start + 1;
 	} else {
 		dev_dbg(dev, "mode not set\n");
-		rc = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
 			cxl_decoder_mode_name(cxled->mode), &avail);
-		rc = -ENOSPC;
-		goto out;
+		return -ENOSPC;
 	}
 
-	rc = __cxl_dpa_reserve(cxled, start, size, skip);
-out:
-	up_write(&cxl_dpa_rwsem);
+	return __cxl_dpa_reserve(cxled, start, size, skip);
+}
+
+int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	int rc;
 
+	rc = __cxl_dpa_alloc(cxled, size);
 	if (rc)
 		return rc;
 
-- 
2.34.1

