Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F9142E6F;
	Fri, 21 Feb 2025 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101190; cv=pass; b=BQWk6NFICTO8kPteISs8Cneh5evSgg61++y3k1v4KQVuG98w910A52rpORys8kFfIoCcKHJTuVMOdgjvCL+dt+HLmDmuBiGEGZiP/z/gEgHLQWvMmAnTgNeGNaCp+GSILUfv8jsvwpAbOFieFzgymEJPSAfffiEaRdS8wpvdsj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101190; c=relaxed/simple;
	bh=VYMF9IY19OHeNl7smQ2vsUUrOoXY65jXCYvNRM7RWDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdT8BDmVsRKiYYHzIMQoHbilN4SaDfxr+Uk3aHrW8smACp0RD67qBX12+8XYGDVR4BaoV+Gf01dhpeyF7hdc71KHrGlQPJCeP6JSZ4zqpXF/v9UCGw7WHIll/7Y39TOgzNKmQJU1LzMC5xVrrK9//6CWBXqwkOxXJihuK7BoukA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=IkFfxGL3; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="IkFfxGL3"
ARC-Seal: i=1; a=rsa-sha256; t=1740101160; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MdaXGae8eVZ0z6TxonfY7kpRzT7T7gWS+ikqsnNSrNSnB+nOsG7DV0Ifw2xSGu4GQFRKu5k1CmRnJIQoGEANgECQhJGmvvON6Tr2ZWt/ObhkePHk/ym+wbjZKLfVBEqqjhavNAoFPgQ+igBj0/5JW6Z75rcEsO8JbC7IXMTe1A4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101160; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GtELuGJ5jBzdP39Ec6hbhrywYcuLcVHKazGBTR8GjVk=; 
	b=RgNUd2VxSpYn86Kfbu8xhww6k6ybpS02JWE9MWtdXxf/e8Sf953jjVFQ+yra2cWNxucIvg3lK8PRxgng1azeGjwdyxMw8KhFiMwOvZBIgHgF0d6H9VgI1UC633NbCpq+0s4JK8PCdMYFwHxW/6f7l3+wW0YUuML/7G94HrB9VnU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101160;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=GtELuGJ5jBzdP39Ec6hbhrywYcuLcVHKazGBTR8GjVk=;
	b=IkFfxGL3vLBAtlhOxkf70uY49O5K9BBBr2Iu66uQMqoXmewT5VoxK/fy783iCUCK
	9Aoh6BOZxYKVBudsprQst5XOA8si2ZcXXYhv2mVyDesTGvwrisZLomEWv9FdeXzcuNx
	MO9CdgcujrsbfiiVCEWdFvtYuETOUPPxX1A9gGQo=
Received: by mx.zohomail.com with SMTPS id 1740101157078900.0961567418597;
	Thu, 20 Feb 2025 17:25:57 -0800 (PST)
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
Subject: [PATCH v3 5/7] cxl/core: Use guard() to drop goto pattern of cxl_dpa_alloc()
Date: Fri, 21 Feb 2025 09:24:51 +0800
Message-Id: <20250221012453.126366-6-ming.li@zohomail.com>
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
Feedback-ID: rr080112275e68e10dae7a21c1c169da4100002819199dbed83f565b3d8f299ce0ee3dcb0c1cb18b8726df6e:zu080112272b1e86da6b50fce8074a563d00004737cbf3d37667c7816e7d6252d8f73c731cda310a64e82380:rf0801122d1473e70191fb77f47bb3c49100009ea45ce2ce361577a76fe89afd80abb68889ad2fc2a6bfd8a41b60f1ae53cb:ZohoMail
X-ZohoMailClient: External

In cxl_dpa_alloc(), some checking and operations need to be protected by
a rwsem called cxl_dpa_rwsem, so there is a goto pattern in
cxl_dpa_alloc() to release the rwsem. The goto pattern can be optimized
by using guard() to hold the rwsem.

Creating a new function called __cxl_dpa_alloc() to include all checking
and operations needed to be protected by cxl_dpa_rwsem. Using
guard(rwsem_write()) to hold cxl_dpa_rwsem at the beginning of the new
function.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/hdm.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e1d1fe5492ff..70cae4ebf8a4 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -603,36 +603,32 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
-int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxled->cxld.dev;
 	struct resource *res, *prev = NULL;
 	resource_size_t start, avail, skip, skip_start;
 	struct resource *p, *last;
-	int part, rc;
+	int part;
 
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
 
 	part = cxled->part;
 	if (part < 0) {
 		dev_dbg(dev, "partition not set\n");
-		rc = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 
 	res = &cxlds->part[part].res;
@@ -672,14 +668,18 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
 			res->name, &avail);
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

