Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73980198E8C;
	Fri, 11 Jul 2025 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203511; cv=pass; b=en+DIMWPucdgPdouUIQmvjL6gpA7nFC75c+9T0+YnR//Yilkk4UKwHvXzXWG3h7BehZW9e0a8QUs0gnZWvxceYQsD29lHL7fUUjWEPTp1L0xJHKBkXtUebRSdQ2W/G2dInFaTsj282gVFAfN1uZ4yzzCI73r+aEKKXTO+Fz8C30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203511; c=relaxed/simple;
	bh=yawaFjSxeq/fKlAhYVB8ann21U7uhl6dgm04Gq0j7TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpjFdr3qf3+WOZdpi41pSg10CXXaLdS3FdPVgWii23Hu+GyA3eG7YZycrxkWe3Qq4HjNLvczi+PxvGAMSfAzLYdYr0aSM+ZNRsCf3oAjol4QPE+1Vj2tDjizHQxvPfwdHJmQCRtc1qozE+EhW1zMFypuH29NWURqw+BXgHt9UTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=V/GENIji; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="V/GENIji"
ARC-Seal: i=1; a=rsa-sha256; t=1752203493; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L+iVKcOU+Rlv4+NtC1Ib6PUaPcYtelMmYga/YomgQDi+YIijXRH0Lg7XzawIG/weSDNps1eDSfHpLmMyOFwCPxYMgpDJ0HW5FtAn2UG3UhJIEzWrRW3Qaua8ny8+Udzh5P/d7w2ujU8nmcXLvRrPoC4P/ggYhuE+3PZGxZEuIlQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752203493; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b4u6LBdW93zKsk7vPHfRkDgEBvWxtyoEagsxCg2+pVg=; 
	b=Lyg1F7PH1YiYhDI1vTG7quKCS/OgQk0A7W49EX8S1k0vfI3XDn4CffGrH7ch87CgJQsTJArvS6JdHoNQSfvCWO8s4MYJwZ6Eik8+xAJe7EpGwagstDZJwaruVT+nColXLhz09wUDVBjgUAX7TS6H5vi7JUTR67Hhcuj+J0/aTxU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752203493;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=b4u6LBdW93zKsk7vPHfRkDgEBvWxtyoEagsxCg2+pVg=;
	b=V/GENIji9Cj6uj6WjmA8W9XvlLp4Pv0T5q55HXXtgwg0OgaEVUXJ1HTNNeOkFwOp
	EB3QzXBl3RGw0TF5uW/WqlCIm+yM5LXiuVQgn9aqOFtnGo7Jkb8rAcT7rvzbvrKBTpb
	4luEPh+YLFgZB5TbS/Tkw3ulaN1yXt46jFzDvcxY=
Received: by mx.zohomail.com with SMTPS id 175220349095176.4970901840478;
	Thu, 10 Jul 2025 20:11:30 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: andriy.shevchenko@linux.intel.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v5 1/3] cxl/core: Introduce a new helper cxl_resource_contains_addr()
Date: Fri, 11 Jul 2025 11:10:59 +0800
Message-Id: <20250711031101.126990-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711031101.126990-1-ming.li@zohomail.com>
References: <20250711031101.126990-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112278d61b1fa7fc914d13a8312560000b4c3fd5d465b4ba400c8a6558a3355267c903361c5f7235c6b:zu0801122776c2ec558fd8dbba7a5d39cb0000a72f7beb42218d977f9ffd5429520b96ce45d45c09f7a6fa0e:rf0801122d7a89d3d5e0f405b265fbbda500006dbb130add86bdb3c7c0505e257f975bc1bd07ed9e4a98810b447517ab65d6:ZohoMail
X-ZohoMailClient: External

In CXL subsystem, many functions need to check an address availability
by checking if the resource range contains the address. Providing a new
helper function cxl_resource_contains_addr() to check if the resource
range contains the input address.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h | 1 +
 drivers/cxl/core/hdm.c  | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..6b78b10da3e1 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -80,6 +80,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
+bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr);
 
 enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ab1007495f6b..088caa6b6f74 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -547,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 	return base;
 }
 
+bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr)
+{
+	struct resource _addr = DEFINE_RES_MEM(addr, 1);
+
+	return resource_contains(res, &_addr);
+}
+
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
-- 
2.34.1

