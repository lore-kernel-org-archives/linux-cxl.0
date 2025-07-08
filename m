Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F63C01;
	Tue,  8 Jul 2025 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951805; cv=pass; b=S4JMnK4keBtqSMYc9Ns9r2A/1H8S0wGMH+8GpjwQEnc/Fovfu5n2z+pz/FNg/ePC/VINNdz8G6+E4tIIeM+lUM30EQ9YF2wjzccYRdtYfOV4xlBSGWdlZ1m8HG5oEnsDhilRh6MmuMxpJXed9ZdofJjdag8sLCyGjnwTAvG649g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951805; c=relaxed/simple;
	bh=KY/2DFaV1aTZP3Lr1fHxjsGhU89xRUGJpvxl4O/ssLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqPit8s5766H5L7NtgJhtT82p1Sxm54VUKoIMnBD7/DQ8BFqiOEueloyO4fUop4mDcWWxKz+61NSOvYR15JKQM6LecfeW5Er9FkiM80S7soc1E8bc4VKEjU8OSYt/kE3HeCmsXgnLLDzgTtDyHVaXSAdD75di4gUcTWRcotE6nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=VErObh3I; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="VErObh3I"
ARC-Seal: i=1; a=rsa-sha256; t=1751951777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aw3pawn8MtqaQ5cXD5enEJZZCOSw1iNUfKPtn2psQ+e3H6ShNlx3O0sGXQmsB2wHakVU6/MYaLy9j5uSdj+vWRfVo5W56ssb27psBPiRANYo/SCEtdCr2F3GuRJcpXjAitk4cpj9qQPXkicnKCp4D1e1G6g38jA2b3UlprO8RMU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751951777; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hYBESk6nOP8V4psOWi9bl5fVZVI2OdSjQiQzH+9ACEo=; 
	b=WYAWU8fZYccgrdPO4FKnxsRG1hTCQL+05iFhUuTv/gWpaNklQL/Nlajy+gj/q4c2hJwanvAk8JkA1Bg6VSmSc8znWvlY/cP6fnj5M5CQca1jUxMNy3Do7cwt7r5mF5sYMG73gvkJmTcrunFgKu6YulM/hFyUcAvZzD6cla3zao0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751951777;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=hYBESk6nOP8V4psOWi9bl5fVZVI2OdSjQiQzH+9ACEo=;
	b=VErObh3ItRqnjMWWnrwIQWAbbMZv1d+e876/cPKCSoJN7HpUKrLMZxQpLJmOEGZt
	3UgMUudkFesf32PJLlvmPOOaDRE+iKemoMiFgiNXkB3lGgQj750ugNSArkw6/LnAgWE
	B9SAmjjzxuoX1izTYMnyz7eySime+o9LG7Pqc3DE=
Received: by mx.zohomail.com with SMTPS id 1751951775085411.2607486019855;
	Mon, 7 Jul 2025 22:16:15 -0700 (PDT)
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
Subject: [PATCH v3 1/3] cxl/core: Introduce a new helper resource_contains_addr()
Date: Tue,  8 Jul 2025 13:15:34 +0800
Message-Id: <20250708051536.92119-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708051536.92119-1-ming.li@zohomail.com>
References: <20250708051536.92119-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122718af00d8b8b4b2bb720d4e590000d230f30d87874be179b99d2c2a6ce5ec2cc059c17b29f91afc:zu080112273ecdcb08181d3f659f7c32a30000ac0634e7386ccdb384c41aa66b68fc188d85d8dd3be87a4460:rf0801122db3f80ea441acb665a4c3c0380000be5df47c785eea47c9e70ac6ecff884ff3a631a9dfea3506e39317c01f5d2c:ZohoMail
X-ZohoMailClient: External

In CXL subsystem, many functions need to check an address availability
by checking if the resource range contains the address. Providing a new
helper function resource_contains_addr() to check if the resource range
contains the input address.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/core.h | 1 +
 drivers/cxl/core/hdm.c  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..3798e9047175 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -80,6 +80,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
+bool resource_contains_addr(const struct resource *res, const resource_size_t addr);
 
 enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ab1007495f6b..701a6a3baa6a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -547,6 +547,14 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 	return base;
 }
 
+bool resource_contains_addr(const struct resource *res, const resource_size_t addr)
+{
+	if (res->flags & IORESOURCE_MEM)
+		return res->start <= addr && addr <= res->end;
+
+	return false;
+}
+
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
-- 
2.34.1

