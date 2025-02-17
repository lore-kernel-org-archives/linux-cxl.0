Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40BA223324;
	Mon, 17 Feb 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803791; cv=pass; b=PwEComnIMcifhr4WpC4VFwXb4Wdzyuy4pn/K1Z4npk9ME/vK0HYJrIuwoTJhvggorWxNf1lUUfbI4SVmnqltqs18YOMIhzNQRiZvacttE11iWhpp2VMhof1S5jErhWbg4h2sLFuW1eGYnq4fNXas60tdzPVTPQ56BuxXn6zVTCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803791; c=relaxed/simple;
	bh=1FkAUqTty3d7vuzR1pxX8pP9dLgtx+UOp3YDgSeskPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtmA4X62mw0dMjr8cGic+XMyr5rISgmx6yOLvnF7qeKZJL4yA98WIukKiFYkLAIR76oS2trdNKUB+oSzZpPWDxD01/JBPzeah2wNR0M829p5abKBt3HpBn9wV7ZYYYvS5qGsw7O+A1SRK/9+cK0ao/wXsCtf2F5v/w8lozokwUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=N8z7xsy/; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="N8z7xsy/"
ARC-Seal: i=1; a=rsa-sha256; t=1739803768; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GSWG37s5bdPqqHD2yv0ee+qYtutJS9eKVr+5mihTBg62anUJBgWJgtuJShR/aFK3vrfss80oVH4lU2XXiUMRfUAxR4sSBGEkXfQ+3uodl4VVPvT2vLAyh/GX3DoXzYBYSJeS/niZs6zS0dT43rqsYDQCzirGvvqdbguqbUbxgh4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803768; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+mlZk31zofzRORFSVPS6rIRxE3VbHvcdGYG1A+JhSGI=; 
	b=LLOa6RkN0XViyLxA278ku8ZgnsNENLNkIdyK156MwYPgGdZ1Uxah8iK2KT34E/a5tMYPrRSaq7EmTXpuPb+ExLvQfDf879I3V9n7Y3DVd/PBpZ3DSzJmn4JE2GYQ1iWBv86LMN8P+EKCiAJfV3rLaDe7TybGzuD+mDcZbCcYq/4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803767;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=+mlZk31zofzRORFSVPS6rIRxE3VbHvcdGYG1A+JhSGI=;
	b=N8z7xsy/ghBf6Tfr4E4Dx+W/qSJRZ4hvxZ4luT8l4qMDtVxPhjZmTBUvDNTqKSKb
	nvX2TZ16QFX/i70rwjmHp6EZ+WSVXvySoLiTN0wnzwEmTS2DoHedCmbBZzbLnTZgsDD
	+KObavXxKcZKtOQb98YpSJ4eNCfod40HYYh59IxQ=
Received: by mx.zohomail.com with SMTPS id 1739803764974919.182094874602;
	Mon, 17 Feb 2025 06:49:24 -0800 (PST)
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
Subject: [PATCH v2 4/7] cxl/core: Use guard() to drop the goto pattern of cxl_dpa_free()
Date: Mon, 17 Feb 2025 22:48:25 +0800
Message-Id: <20250217144828.30651-5-ming.li@zohomail.com>
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
Feedback-ID: rr080112278b6ecf97784c241d977590780000149296f73421664c9c5744797e1ff0253aa46d5c24bad258c8:zu080112278b7329716ba05e01e922103700005107c85808d8b7b15aded6999d45b6d804028dcedbb17aea80:rf0801122dc82ac33beabc0b24907af4a20000173845c03f0bb6a735fd29f16c2dcd59980b23bfa2ad5e4957fc266f5a146d:ZohoMail
X-ZohoMailClient: External

cxl_dpa_free() has a goto pattern to call up_write() for cxl_dpa_rwsem,
it can be removed by using a guard() to replace the down_write() and
up_write().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/hdm.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4a578092377e..874a791f8292 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -382,35 +382,27 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
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

