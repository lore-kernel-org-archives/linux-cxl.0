Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A040BF5;
	Sun, 29 Jun 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751185311; cv=pass; b=QUbhOqn16W3+xdPzRb+rQXiSBeyCUEUYa7Kr0Tq90m2q9/gvJmJ2btuYwcfgjxhBcjZz8s+M04AgLQoZT6xkrjb6oDdW77rf+0xxhX1ZNMgqGoCDBKyHy/XVYgA/inJu0kojRpBmyGTzVgbMW7atSgLwbTYl0aAuqEFNLA3EovM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751185311; c=relaxed/simple;
	bh=VqUtKx/ocM62xvMqnviJVCoS2/JjNzLbtv5QD5cbQcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bWEmrgwAaW5SfIH7ps2PUekaQG+ZZ6VIOhu0A6743qt9pUpj1bvW1NT8HKbsIU2vwITv1fHi8TI+NGffG/vO4GwiquwCmQrNRWGTP02/UB+Ku3l3HaPZrjBQ5GV4iiSTBUKzFIgAfkIyb/zAilXChY7+v2p0q/6KJ56tgVTk92o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RbsVqfmn; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RbsVqfmn"
ARC-Seal: i=1; a=rsa-sha256; t=1751185293; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D5y3xjPLBPocFaUP7HqlH4qzyj7vVTa7f5vjG83JOO7mzYm8a7x0ApKjpBfAgKY/ns+wRkdBAFYMddgFjJ+/2yxPNN4whLvBYaT3et5qmBFD9PlGetM0eQA6UevCTs5uTdCi5xLp9Ljl1SsKiYFfq4RvjYt6YcvfIMmP4I5Lwrw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751185293; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eGPzEZa/8+hObClzz/O3G73xHbWCVO7Dp/xusjMwSy8=; 
	b=XXAGJi3sVcslwTAnrCtaUfeJ6//TWOVUeu0QesHf8qwfR6TJDNYEa5Iworx5b2QIYAfuo0GdA8rejK6eYnWn7GlFywBnwyD2CnHn6Br2OJkoH6aQ8ghr20a7knX0ICcX0eWsM8xvTbXKjMyZrDlxXUqowdkAhtnLtNObxQ+FxQk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751185293;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=eGPzEZa/8+hObClzz/O3G73xHbWCVO7Dp/xusjMwSy8=;
	b=RbsVqfmnzag1Ff81jUbW7Avg59ifN1QzXz3/mHB6EhfA9+EPHJSttEH2ysCXBzPx
	78e1bPZU5iBPfHCTEsIfNq3XbO04s9XBr0etGQvn9IX0RnXOFU9KyyH/K1DNFquCIA1
	Nkla86g7XufnuwbO+DgNwpTUB8eR0Gl1BopG8+VA=
Received: by mx.zohomail.com with SMTPS id 1751185291625851.197636039665;
	Sun, 29 Jun 2025 01:21:31 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 1/2] cxl/edac: Fix wrong dpa checking for PPR operation
Date: Sun, 29 Jun 2025 16:20:41 +0800
Message-Id: <20250629082042.256123-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227321845281f5df1f67b4a0e4f0000cf7d02307da6457b165350d36f59e0263d7ab1958bfcdcdb70:zu080112278565b73313661e9bb4d4c9a30000fc8f6b806de88ca6eab49505c63329237ac1a020d33b05f346:rf080112327a5fff30ec32c1b87e093751000063260552fed1dbe9506be6608b769aec491ee65d21e2a836cf32eb68f44fd4eff73b130f:ZohoMail
X-ZohoMailClient: External

DPA 0 is considered invalid in cxl_do_ppr(), but per Table 8-143. "Get
Partition Info Output Payload" in CXL r3.2 section 8.2.10.9.2.1 "Get
Partition Info(Opcode 4100h)", it mentions that DPA 0 is a valid address
of a CXL device. So the correct implementation should be checking if the
DPA is in the DPA range of the CXL device rather than checking if the
DPA is equal to 0.

Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
base-commit: 0a46f60a9fe16f5596b6b4b3ee1a483ea7854136 cxl/fixes
---
 drivers/cxl/core/edac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 623aaa4439c4..11eaa2eea642 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1923,8 +1923,12 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
 static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
 {
 	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
+	if (cxl_ppr_ctx->dpa < cxlds->dpa_res.start ||
+	    cxl_ppr_ctx->dpa > cxlds->dpa_res.end ||
+	    val != EDAC_DO_MEM_REPAIR)
 		return -EINVAL;
 
 	return cxl_mem_perform_ppr(cxl_ppr_ctx);
-- 
2.34.1

