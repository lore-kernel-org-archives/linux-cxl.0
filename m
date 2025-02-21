Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E913DB9F;
	Fri, 21 Feb 2025 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101199; cv=pass; b=IpK9IeS2ahKv1xcsbQ3HLmBG3sCv84jemIQkZLdthrGCIqo6d3fa5x+nJtOVjNZgV0YkmaoN2SAoevX7c4dz1UnvJPPjAEjAwSj1+qceyaOalVkJk1wNn+zhEhIETUiZxoF5jkSXmhcsO/o862p7K2KUl9rv5fFp8UlAk13Jz/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101199; c=relaxed/simple;
	bh=jJSVX2RrQtDAHNdHcfm0/wAcvFaJmQX1s57o1vOJo94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/H1byrvO9CZ7k8r+hBMMsyaPr7aQhckLyqIP3RhfeOrddo5elTk8jQ884yubA/3FH4GlIthDM79N1Mfx98kOpV+H4I90MBv5ZIivUIOaX/gg6LTaxh6r1gcKNC0R0ek0eVDNbPxwNf6XC4YP0GEZoJcCN+nITI9yXeT5lJpB1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=DSZm1U73; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="DSZm1U73"
ARC-Seal: i=1; a=rsa-sha256; t=1740101168; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BROVFzOWPGvONJKu41VUsV3duKcEtwdRFXMUuKl6qlSQwiivHAv7STqs8S/OnDRVVadjlBY3SNASQlKGhNqnUEl4i9jAvvyTtVROeuYPBSiNsbiSxBA+UR/E5jQBwQDscuRp3VWiInB5lep+lfiYvEnhtooWRSSXuubMA4WVMzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101168; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EC6hdBRAaNe+LM1jGuZXk5/BWpGrWVrmaRoztohpJHQ=; 
	b=VjatBjoFAa7ZZ4sKYVsDCxrhjqgkPyVbEbsH9FRpJHSN/HhJfDWQIp5B1dyBaq2RhJD8ZpLU1TK9dmXvb5cRBtYgu2WEbXps9kGVV6AYulvdptMJajLX9wX5+F2ola7vktCHDPCln2IYPi1uf1v2fooAu12gZlvuBEpZQgxUuWY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101168;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=EC6hdBRAaNe+LM1jGuZXk5/BWpGrWVrmaRoztohpJHQ=;
	b=DSZm1U73dUgZqMWnZPtzeOQfXL5hz0n0KYcde40xq3FEPhk4R8nlw8GTIKpzc7HT
	8pnBMGNRSh7UZo4JQq4MOxpMPDBPxynN36hRDkrD1Q48lP80jimQyC3SibI0Cm5073x
	WDlwARvYWplv/ZU2x5Ee3jypcVB0DOOLdji3U8yU=
Received: by mx.zohomail.com with SMTPS id 1740101166835944.9869850009496;
	Thu, 20 Feb 2025 17:26:06 -0800 (PST)
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
Subject: [PATCH v3 6/7] cxl/region: Drop goto pattern in cxl_dax_region_alloc()
Date: Fri, 21 Feb 2025 09:24:52 +0800
Message-Id: <20250221012453.126366-7-ming.li@zohomail.com>
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
Feedback-ID: rr0801122763afccc3e0bf13c4fcf237c500000a2e18be141714b8afd49bfb979b618f1b45778593ff423b69:zu080112274e6e69bb57c99848a7e6e5a7000073d3cb19de40d2a2c7cdfabd16edc081006965258de78e4823:rf0801122d5b45866a6bde9f6136f84f6b00001e311490b10bf04dfa8de33b7ea8801703c06894ccfa501d8da61161339fb6:ZohoMail
X-ZohoMailClient: External

In cxl_dax_region_alloc(), there is a goto pattern to release the rwsem
cxl_region_rwsem when the function returns, the down_read() and up_read
can be replaced by a guard(rwsem_read) then the goto pattern can be
removed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8e68091e3f20..9f082bc0f4e3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3037,17 +3037,13 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
 
-	down_read(&cxl_region_rwsem);
-	if (p->state != CXL_CONFIG_COMMIT) {
-		cxlr_dax = ERR_PTR(-ENXIO);
-		goto out;
-	}
+	guard(rwsem_read)(&cxl_region_rwsem);
+	if (p->state != CXL_CONFIG_COMMIT)
+		return ERR_PTR(-ENXIO);
 
 	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
-	if (!cxlr_dax) {
-		cxlr_dax = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	if (!cxlr_dax)
+		return ERR_PTR(-ENOMEM);
 
 	cxlr_dax->hpa_range.start = p->res->start;
 	cxlr_dax->hpa_range.end = p->res->end;
@@ -3060,8 +3056,6 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 	dev->parent = &cxlr->dev;
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_dax_region_type;
-out:
-	up_read(&cxl_region_rwsem);
 
 	return cxlr_dax;
 }
-- 
2.34.1

