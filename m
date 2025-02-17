Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E22222D1;
	Mon, 17 Feb 2025 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803927; cv=pass; b=Pm5k5tXLIk0teZldC/6qsaBnKnVoj1tgK7yjcgo+RXEOalYkMve8BIbQVRkIzdV/mOKQjSmT2A3AKAM95bJWxrp7Kd7jpsVc6ULTvI89FoWN9E7/GVZF8bbEZCMc9MFNq+IjyTBNPKFGYgjWJI9bxxyBiQx/JG5wc6akTakSnKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803927; c=relaxed/simple;
	bh=CMU0oC5OqZfOfX3TUGRzV6xGk9VpKd3fVn4+DmGjr/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BegvAv4/BeaVtrArWs/IWy70W2FkTDQHPquprF3uGiIUbYw3bfkzQNUmb/QMaq5x8Jr6qajkRgTV07lLvVEYZh4p2lpOPeTLwignn/9Rnh+EMjubSqkRFKLltulcNMP6VKgOnVYW3oQ7WCc67F+IrVZF0VSWoz7bxMdifEtBX2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=IfRtTPGq; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="IfRtTPGq"
ARC-Seal: i=1; a=rsa-sha256; t=1739803778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sh77v+CqXjwXA2ckIXYeC8GWKl+CoU17/Ij9jOtVfrYAJeMefPPRt6NTIsTaQ4F/TpGrv9uKsJjPSwX6Ctlx6W0unjbcnxzU0Skh6rtcUp55zDsFEgnVcFEuzLs+NhpPHFOw7l/ZyfrDTGxx76yF536LrwqpKmBQMciLhbE6DtQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803778; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UBTwBPzFp5F5/5KTauGoDs85/B0rlCeCpCRsH73OvuE=; 
	b=kYwAFXa2zZ8w0ekdAF5Niy15pXsp3vf/BW71249Al8I1wCcUf5atjgWVklen1HC7CMNTTYaSpLGW2eI8DgTHfGk4H4Qiltw/1r5IFUNMiP+4eqWjH4GnjGQJZEGmQ0CjpL4ecoPNVutakhZyqarnLSfChauV2IZIyptNhFjOmRk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803777;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=UBTwBPzFp5F5/5KTauGoDs85/B0rlCeCpCRsH73OvuE=;
	b=IfRtTPGqfVpzOjZkgyXab2Sc32ZzpGfB29+yuyug7uz0FdxxCD+dYYdgh0/G7Fh6
	NaJ15Giu+6zJWPdhyYWa51g93yzAYX81nN+FAkZ9bLeoDyoEVmxtPK7FiDpnNkW4/5v
	Ob8PQi5t3QyONzpmPzy2ilMEaI82muJ8HazKZRCw=
Received: by mx.zohomail.com with SMTPS id 1739803775573102.290568107931;
	Mon, 17 Feb 2025 06:49:35 -0800 (PST)
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
Subject: [PATCH v2 5/7] cxl/core: Use guard() to drop goto pattern of cxl_dpa_alloc()
Date: Mon, 17 Feb 2025 22:48:26 +0800
Message-Id: <20250217144828.30651-6-ming.li@zohomail.com>
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
Feedback-ID: rr080112275d074be819fc2935b176da3600009a1dd890bc7708c32f22f433548c65c354c38b6f46e7576260:zu080112275322b8c484c65ee0f1fd9bce0000c575d7b372fecf17294a5b12d881d8bbd98d9ff179e6fb94a5:rf0801122d280512da356b3612724f41be000055e6ca8760a22fc51ff0373fa823d38b8c2049a0d54ac02e8258514d71a86e:ZohoMail
X-ZohoMailClient: External

In cxl_dpa_alloc(), some checking and operations need to be protected by
a rwsem called cxl_dpa_rwsem, so there is a goto pattern in
cxl_dpa_alloc() to release the rwsem. The goto pattern can be optimized
by using guard() to hold the rwsem.

Creating a new function called __cxl_dpa_alloc() to include all checking
and operations needed to be procted by cxl_dpa_rwsem. Using
guard(rwsem_write()) to hold cxl_dpa_rwsem at the beginning of the new
function.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/hdm.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 874a791f8292..1edbf7873471 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -442,29 +442,25 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
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
@@ -504,21 +500,24 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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

