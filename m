Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91B1EE7A5;
	Tue, 11 Feb 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260744; cv=pass; b=lK3YnjMBefzq5ZH94fM3fHavaCiaoy0uoIqANq9c0gCGvLicJ9rikX3MsnQaOS1tv5uQbaByBa/BGrVtdQZMaSL1MwuT6XB7CdyKE8VwdNaLxtST95tCY9NVYYnU/Rg3RLtooPM4sByIKamsKhFn2g3D6ePNoljfT9HQHfdZwMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260744; c=relaxed/simple;
	bh=1O+6Raac1UXIYzEZIawfYHTpWeTFO2h2JmW576CIqJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8vQ6VAUkdUcGGzoxS44k6oWb7XOCeempG8id60+w5S6s7Q/AWY61CWMJlaszF4kmwpBDaHzyyyFOrrTHLy2K3aXDOaM88Pad5/rGSbhG8apq35TPDFSd2NUVbCctkQTItpL/lRh8WuE0F3OHKWD2b8D2RCbzS1S1PT4iEaYLxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=TOClt8sS; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="TOClt8sS"
ARC-Seal: i=1; a=rsa-sha256; t=1739260724; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cxOGDz6ZyXMo7F6KbP3+YdjqDNAGdMfjPhxteRaSxnKOLiXJLcRUaBKGsnhYvwCGglK7H1hi4vl/IZ+AMNJkUOfbThMhNA8M1N8yNR7Va5MxpzlfSCMn49wJWMKcrmm1QOeMizS52Z5Ep0irXu2LOQ/Hvp4Bj9iyflSUQDdYObI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739260724; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M53iekaUTE9kiToZzRvGlu6mrTrD0dl1s7HNg2PhFzw=; 
	b=nCFKB1ahsY3zP1qmYXycvrbl48kRd45t/sUvReWkN84WzUgr9qOyA70kQvBqUNUS7bISeNhj3ZnWo843SXV0IQ9U8mYE+ATKYtBWVDi+8XDHq7ysykBjD64nkaMeZa0e+5QPHqutYFjo4eY67lIsEgCHvEFyMygD0SyzsTvmhb8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739260724;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=M53iekaUTE9kiToZzRvGlu6mrTrD0dl1s7HNg2PhFzw=;
	b=TOClt8sSD9ihRsMPPwp3jK6SVhLb+e4zNGd1BsQ59JYyFvmhvqTet8bY+O1O4j9C
	ubVHbxOI7vgX6H0zvtiyLRDvTQpGFJjZoB84xGJajB7lu2bmPTP7R3idRyZIP86alHL
	b5UMuJoaSNjGYj0ry3BRI58coYuJ9reXEb/D6/j0=
Received: by mx.zohomail.com with SMTPS id 1739260720842743.4866933984274;
	Mon, 10 Feb 2025 23:58:40 -0800 (PST)
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
Subject: [PATCH v1 6/7] cxl/region: Drop goto pattern in cxl_dax_region_alloc()
Date: Tue, 11 Feb 2025 15:57:26 +0800
Message-Id: <20250211075727.351895-7-ming.li@zohomail.com>
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
Feedback-ID: rr08011227dff62015b7b668575db7403c0000328c3e1bab183ae8a0fec3faa15bb224780dd55d0922aa6e2b:zu080112274ae7e0741b2ff80ae36db9eb00007e8765f3ae3a74d6a16013d8c9884faa89f6e8415175d09962:rf0801122d5801bd134d2035ed3485e31b000069299876dad2030739cadd74dc2df7503546c44759e6cf54bd8f9702aec9e3:ZohoMail
X-ZohoMailClient: External

In cxl_dax_region_alloc(), there is a goto pattern to release the rwsem
cxl_region_rwsem when the function returns, the down_read() and up_read
can be replaced by a guard(rwsem_read) then the goto pattern can be
removed.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e3bb33109ced..36f3771818d3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3038,17 +3038,13 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
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
@@ -3061,8 +3057,6 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 	dev->parent = &cxlr->dev;
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_dax_region_type;
-out:
-	up_read(&cxl_region_rwsem);
 
 	return cxlr_dax;
 }
-- 
2.34.1

