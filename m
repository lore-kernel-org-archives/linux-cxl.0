Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A1280328;
	Thu, 10 Jul 2025 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130720; cv=pass; b=nJ40jbP39bqry4QuyLMJMMAi2lox5s/Fb0xHreIRoUJS/dQzuTzM+cD8pzNyOriNaLcCmspuYZwpne+1LdW/1ql6K65vd7xsp59g8VpOm3l1yRJZfb+DXnj6x2zPlXNYEIPP5B46ihjIss/J/OyIpXhKBVx+3DpSA9DjHai+XEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130720; c=relaxed/simple;
	bh=kleyIYQDLQE4ccm5Yvd3nhk/56WiSGSXMisKX415Ubc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAocZRZUB/wRgBaHmKVrmAWazLOFJQNUw3qPLNwjNKIySjJ4i9Ybzcx9xlrrg7UEhLCQRnf2ZlqaOK7wiSaOhHHApAicrlfgYmIHyhrA8CNAzPl7EQFqTCNLX+AuSoT8RiS+5OaWcRes6oyKXV6k7myxM6DTFpJ2AseQU4Q7oL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Na6YwQg3; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Na6YwQg3"
ARC-Seal: i=1; a=rsa-sha256; t=1752130694; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P6wSRT3em5KjQ07ly+mTQNtCW8Vn1USg0FozTR7d3atm9QVIq7wS1rJQGn5zk7bpWlRa5/IpFenr6gGsfe+afCGSyFHwG1zMkNxINgtWZXS31y1WL21MKaxigFLRQ3o4eZcm9Y9IOS3QGPMGU/kpZLreRe5/ReJ8abJrjd/+Phg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752130694; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R4yqQEncWjn6CZ3DlAAJiCNhjqHF1n7HHSTt3k5XNew=; 
	b=kOm4f6wK88R1FcBKllo6C7HQCFnIxnlTScWRoDkIyD2K8PhPujwZ8QgQgcJYryPAkJgwedP371NjvBlomihAoTX/8ICZCKoTBjj51Zec/EK3b0XGd0/K+9DEFr+td3R/lXJnm9Bf8Y26ko2mh2njZNjCEYQTjNdmUjfgchuMZlI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752130694;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=R4yqQEncWjn6CZ3DlAAJiCNhjqHF1n7HHSTt3k5XNew=;
	b=Na6YwQg31gRsYyT0wxoIf/fvPM1gA7vS+xetd98J4gWQKmY+tRVfkpycDdcMsF3U
	rtxNwPknQjyzZYb1Y49bmt8rQbsKdfby8KY+s26qFmKjzXNa7cfXoW3tz0FS+tmN+9b
	XGwIvBiShbCtCGZ1fPMBPyjwG/1/0jnFW5RA5KcI=
Received: by mx.zohomail.com with SMTPS id 1752130692353436.68439357214424;
	Wed, 9 Jul 2025 23:58:12 -0700 (PDT)
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
Subject: [PATCH v4 1/3] cxl/core: Introduce a new helper cxl_resource_contains_addr()
Date: Thu, 10 Jul 2025 14:56:45 +0800
Message-Id: <20250710065647.98094-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710065647.98094-1-ming.li@zohomail.com>
References: <20250710065647.98094-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112271991723bf026685fddf203f30000c57052456450f141825631ee15b111c25e7e3f2241ab33bec0:zu08011227c60f1b15adedfb5cffb21b570000d383b1b5e793e578dc735fb34eabee5e31eb69139438b150b9:rf0801122df7b51dd5a3f6c135b0ba1dd100002debb34a3df224007f35e73aa53d69ba4918a665e757618bca77c72ebd533f:ZohoMail
X-ZohoMailClient: External

In CXL subsystem, many functions need to check an address availability
by checking if the resource range contains the address. Providing a new
helper function cxl_resource_contains_addr() to check if the resource
range contains the input address.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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

