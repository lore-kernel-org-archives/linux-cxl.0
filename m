Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3431DF977;
	Wed,  2 Jul 2025 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440889; cv=pass; b=Y8ARP46MFggWUHyOr0MeAoEFLWGsaL0jEhdCp19gRi7uEgVLym5QcpVYIwz4Cgsrbhoitg8dNScuMUZj+RNGiQSk7eq1tgInyOxzoAXX887n3+qh9HEkZmaOy8UOtoCCHVBm6nxTH289kqjhpiJs07GGS3fSA6+zHvXSnuIvbmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440889; c=relaxed/simple;
	bh=fQv1DrWsxhniOSaglMegWviPrsXQovkHo2ngrthRNB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GG2YA8WpGJNIEWbpEYUrcKzMLL9R4IsQVK77ZeW0I5GtPu4y2CqO4TwUIjC7uIj+XRE6kCzDWnnQ0Mrbw4a9sIuo45KgU9iGEy+D4ovtaexbdlRyVWc7p7JOK0Q0m8bPOZsFmqepqez/5jM56G1I5ckUmHYv5l1vcKTVZAtkOic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=NzryM7S0; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="NzryM7S0"
ARC-Seal: i=1; a=rsa-sha256; t=1751440858; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eedqEcFZKrJR0/dzEYaej978C/dQ1ozZhKtnQG6xOQIXsr9SYuQP9DxfeejwtT0VUtRaC6hZe7LAp06xEaX2aPkX8szbBIMbvHzVNa23utxapT/17nmhGvj8LwEZWLOKWPytGa11Hn1ftgJrAVxr8qTDf9vCqgwUHHp6VIfzddw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751440858; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q2LxtsF+ZY1C4SvYmke8RqTHozKgOopGjqEZpGjcMXw=; 
	b=LsRgnGoF6ego8pY8JHbiPvHgtt4F0130PJz/UjMB2kGverWA5xEPjeBU5RJY1tdReaQ+BqxEz7r5fzllbv0ZCmzd6EcUqkz75vPyWxvDjKXD5PuTHbpah/TN2T3wJAYw5A7S60GROkNowfGHIhP18p/dN5uKpD5QXQoMTtWuLfk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751440857;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=Q2LxtsF+ZY1C4SvYmke8RqTHozKgOopGjqEZpGjcMXw=;
	b=NzryM7S0O8SNnLRptIczq5ZYqqXT8idTZlnwnK3T0IoaRzukCMdFLWA8rhX8GmH2
	8y8AsJXB+ZfhFrIlqA+QUeO0cu5lzeLGatLdt9FF6rYy+1/DnvzPdWOe+RAKc3xFCVY
	+Yl3Hx7GR/lcqAeDb1UqnY8Ue098S5xdWmdkcEeQ=
Received: by mx.zohomail.com with SMTPS id 1751440856933760.1793466823643;
	Wed, 2 Jul 2025 00:20:56 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	dave@stgolabs.net,
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
Subject: [PATCH v2 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Date: Wed,  2 Jul 2025 15:20:07 +0800
Message-Id: <20250702072008.468371-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702072008.468371-1-ming.li@zohomail.com>
References: <20250702072008.468371-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227c6ea6696967f1a637e32cae00000ab352c030e463eb2677b92429603d7f51bed31ff06256733ae:zu08011227eec59116cf5a5a629860baf40000e77c37cea583470221d53da7a038de8a3ba7b9f78ad0991387:rf0801122d453a16631c24640696ad569d00003acafbc2f8121cf718b4bd843ed9d142653a86c1c831065b78e339cb8464dd:ZohoMail
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
 drivers/cxl/core/edac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 623aaa4439c4..1cf65b1538b9 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
 static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
 {
 	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
+	if (!resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
+	    val != EDAC_DO_MEM_REPAIR)
 		return -EINVAL;
 
 	return cxl_mem_perform_ppr(cxl_ppr_ctx);
-- 
2.34.1

