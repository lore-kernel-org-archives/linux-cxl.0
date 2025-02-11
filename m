Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B171EE7CE;
	Tue, 11 Feb 2025 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260719; cv=pass; b=UwzAS9lH0fdDANtMwFxZ+1JlUluAMoLyEHwg28f+4aThjuAtx/7/oEgE7znUpj+dbgXEnDAce+jDG866ifySdgTqxrhZ2TanpBdIGKpgdcQqDYgumbMCMTJz/RKw/KPcIq4Zv2JDbL+l3+riSyY5CmZgZEma4ylGyh2A9A2qkJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260719; c=relaxed/simple;
	bh=B7dBeu5tq3u0rnwnRubcu96D4tTv2tSuExxMShQSFWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbyv1ZIrsDy25Wy5TgKKyO68wDl7QYO39a34wCddj06bYML+r0FJZgtTt5yHL6MBLsBZ/H6mJ6FBOttuE0mmvnK3NDejJWyVxiAiRodnVs/WJr8xDiQjkzSz4SX35lqzGz73OOHtHkj5PxdMaLml03G6vENPj3hFKJ2dAmeGEWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=bBa+GnL8; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="bBa+GnL8"
ARC-Seal: i=1; a=rsa-sha256; t=1739260702; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hVM5jm/5Aajfz0JX9no5H4vYxPi3g97Sh+GsKefK/kXnDt6h5vKAJKQf2SUOfYzYUJVHuiO6MO666qAvKhHZfh3Ia+9KR72meenRA7H1lWZ8XWkzPpOHw7QCaLrn608tZ69YC79kZQ6lU9+kfe8L51I4XGsKS1oF947QFVpmiZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739260702; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dcqrKbEYpXtPntgi9g1TFJ4gOMFpUK/YoryvdERmHSs=; 
	b=avEHp2Gxl1AiPdmI/wVLzm/d5aCH7pPIo04EFROwXi68p3Nnxj2B428zl5parFNuqEt7UMVaRi3nprje/N5RBBOQRkZFALH5+G+6C9VuzpUDp7HIphfpUkkCsyoHlVf/jcfLcbpRIKLUCIwrNm5+ggtdJTGifPh1jrkMyFvkd7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739260702;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=dcqrKbEYpXtPntgi9g1TFJ4gOMFpUK/YoryvdERmHSs=;
	b=bBa+GnL81ozw1eJicq1y9/w2Q1ev7qyHsCFcVy95cW1hOUb/dFpOoQf6QFHSy4hc
	R/zDJwvwc597bT/u0g8bjq0o751WPJD7ccQ2mXWMaySZFEe4qTzFh8zziOIblK850bM
	uT1M4jkg3vn+FWU1xU4dTEPZiYEoZws5sBKXuUUA=
Received: by mx.zohomail.com with SMTPS id 1739260699005446.9363537917435;
	Mon, 10 Feb 2025 23:58:19 -0800 (PST)
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
Subject: [PATCH v1 4/7] cxl/core: Use guard() to drop the goto pattern of cxl_dpa_free()
Date: Tue, 11 Feb 2025 15:57:24 +0800
Message-Id: <20250211075727.351895-5-ming.li@zohomail.com>
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
Feedback-ID: rr080112271c03e09f54e2850cd15ff89900007f52c70684e3afe39734918b64bac0608e5cb1d37e428d02f6:zu08011227d9171e7f1569ae06da327252000022d5fc6a0a049266452b46a30d7d2ca88a562f8fa6f658bf3e:rf0801122dcc61a2396dfa7a3217788d440000ff8908c3bf899acf601c9cdec3f1cbd5aa6f255f923def5afa0e3e843fedea:ZohoMail
X-ZohoMailClient: External

cxl_dpa_free() has a goto pattern to call up_write() for cxl_dpa_rwsem,
it can be removed by using a guard() to replace the down_write() and
up_write().

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/hdm.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 2bb2782a72ad..4d753520a79a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -384,35 +384,27 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct device *dev = &cxled->cxld.dev;
-	int rc;
 
-	down_write(&cxl_dpa_rwsem);
-	if (!cxled->dpa_res) {
-		rc = 0;
-		goto out;
-	}
+	guard(rwsem_write)(&cxl_dpa_rwsem);
+	if (!cxled->dpa_res)
+		return 0;
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder assigned to: %s\n",
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
 	if (cxled->cxld.id != port->hdm_end) {
 		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
 			port->hdm_end);
-		rc = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
+
 	devm_cxl_dpa_release(cxled);
-	rc = 0;
-out:
-	up_write(&cxl_dpa_rwsem);
-	return rc;
+	return 0;
 }
 
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
-- 
2.34.1

