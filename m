Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06410193079;
	Wed,  9 Apr 2025 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165551; cv=pass; b=H5abUYBoYbRZee55/6IsiQV2aYmMjgBrs8oe4QA5UjiSN7ahQxfoWD3puoNp8tGNeD3eCSYt2eCRl84MCRugVwtoNJAI/5yZYrAVyoNqAkpp6ThE1YJ0oSdJbKQCSluqVAl3R7MXq4gjYxeybpeqjVcCubBMzo22ZJy4bJgFDCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165551; c=relaxed/simple;
	bh=pXJWppTx1qdMzBMYsUHzNiBfUBrIPFVR39HuYWFXJzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hO+MHOCkiKW08OXf5Sy9rSW4e8DyfFTooORxl4UaVBhckJXkW0n/BHBUDQVsjNRmg8rJ6lI9s+HO0tWDYJEc/rKIGh5G09Qq69ffSmcji5T4qZARsSCT6UM0yQrQDReAy9QGHX7cO6hVGld/Y1g9niZlwcaM52NXgZmSYxID7d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=BTNl+YNP; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="BTNl+YNP"
ARC-Seal: i=1; a=rsa-sha256; t=1744165538; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JMPhTC+BzCxDFPJh6PB7IrEVhcWAh/FpoEs4/OgEFwc49FGByWWuPQA7fHOOvCLY8WXkDL4JZ//3BC5pkpRHq4A2ht3n6fpCMfnPlOrNDYHuhgVWC1+u25+l6wb0guGAiFMSR9GPH16obaR+4A6Y2iF00FxakaNhXSSahJjnYtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744165538; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c2Q/LbaNcF/uKuVERnCxl3mlpMxwx5vDNL9Cl5zk4kQ=; 
	b=a5odCl3NzNvH94JBpYlRdulCPkuHshtfF0/YmNrfrcJuzuswWm+R/Xw/FNrRShcj17Z5RAfKqiYfzAozhswsBZd5PBr3rui+GRXlRdQGJV5vSpBf73FM9K4lw5W5PTbMvOs5q+Rk0bR/MF0K6A2lTYRUmaCB7vcKUuQ9H5/IHMA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744165538;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=c2Q/LbaNcF/uKuVERnCxl3mlpMxwx5vDNL9Cl5zk4kQ=;
	b=BTNl+YNPQrtOFM6JsqD1xzbOhLl2mHFKIlVSnqlggpME1t8jE2Dx8pcZ9KxZ2Gdj
	UhKn/bsWW6c3F1LBpK/z3Q+19ceWNBIYOS09oNCoiVikbST3HkoY9QAp8SqTKj9eBnP
	fDLr5ilaZ5ptzkS5iIxND/nNIvdseTyqffD3/KwU=
Received: by mx.zohomail.com with SMTPS id 1744165536186156.31004439157994;
	Tue, 8 Apr 2025 19:25:36 -0700 (PDT)
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
Subject: [PATCH v2 1/1] cxl/feature: Update out_len in set feature failure case
Date: Wed,  9 Apr 2025 10:25:21 +0800
Message-Id: <20250409022521.510146-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270e58f87a54bd8b96edbc74880000dd8eeec944b7144b8d5f4089687c9f5eb2537c27b2a2161ce1:zu080112276d123e7c2186ffe047fd6d1800006dada48baddf763acaa0733b60fa564208b0cbc03cc035e46e:rf0801122d8d790992f2626579a09f1f650000061ad1921e6dafea777d50a6c7037e3709db4bd6d21e09babf597b1bae2e7f:ZohoMail
X-ZohoMailClient: External

CXL subsystem supports userspace to configure features via fwctl
interface, it will configure features by using Set Feature command.
Whatever Set Feature succeeds or fails, CXL driver always needs to
return a structure fwctl_rpc_cxl_out to caller, and returned size is
updated in a out_len parameter. The out_len should be updated not only
when the set feature succeeds, but also when the set feature fails.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1

v2:
- Adjust changelog
---
 drivers/cxl/core/features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index f4daefe3180e..066dfc29a3dd 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -528,13 +528,13 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
 	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
 			     feat_in->version, feat_in->feat_data,
 			     data_size, flags, offset, &return_code);
+	*out_len = sizeof(*rpc_out);
 	if (rc) {
 		rpc_out->retval = return_code;
 		return no_free_ptr(rpc_out);
 	}
 
 	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
-	*out_len = sizeof(*rpc_out);
 
 	return no_free_ptr(rpc_out);
 }
-- 
2.34.1

