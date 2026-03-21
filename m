Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B821E087;
	Sat, 21 Mar 2026 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073731; cv=pass; b=tbe95U9K3W0loZWrbacKRDNjFWB6/lPUXhM9R8hSLNgebcEf4/su27sgZFJA2dOZQ57G5efeCsjFnqjznRp0GxoYLqUMN9JqQST35n0x6KMgoMV2n09G2NkcYJAAQPmMO9t+GS6YIcqZDcMgg2ifEs2lNVYWE5jAR99HJkcl+ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073731; c=relaxed/simple;
	bh=R8hqgzL8gySuZr6XFKWnCcrZ8Q0gd+F1ANKNup3AGF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0jPY+UrKevpqUOp2A4jbDhZF2OIaR+/3QZCBq++Hzjfa8iiHSpDZI4FUW2R66zIO7hFs/HStD0v/0UUjus2kDgqa3wL/zJV5zZT2g9VKrsY7D1NoLwvqX530Ql/DxkJ1IrV/dI80h0azV0Fgae/PP/nBtsoeeFSdpsHTnkjgqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=DXoc6VsP; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="DXoc6VsP"
ARC-Seal: i=1; a=rsa-sha256; t=1774073714; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nu0pb2B12hcogHvX0VmAHlYucMsUKNdjiL0Xz9XGNN1SQWL/AuxtC0TDzlSNn6fNx50x0q6mGix7ZUObibM+QHHE2wKmY0EpTXZVxatY0QQBvnFfGMlSWbDFvPQwOQxDcWcW5kZpOTHuwnVmI7DF8Dkt5xPKFT1AQ9JXADKax44=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774073714; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gz0KEVMIV8B2SjI4J8MA/8fYF6PzD08zan+pebU7jGs=; 
	b=F7EAI/uJZbvnk8gM0ETKEHxRAxfddT7UcgzlJTuXiskTKlyETo8hEnt1JCyiGztLdHIQZR+2++aMksqi0BJg9HIF0wHORhMusbCJeVNwwD5Y6sSw6byJaecLExWIj3L25WoztmQ8TU9DPdft1RJA6bg9JmrsWFGShZCOto58QGs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774073714;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=gz0KEVMIV8B2SjI4J8MA/8fYF6PzD08zan+pebU7jGs=;
	b=DXoc6VsPfMHQRundxLTEeDz+YzRBr4KVvIyVAbpy/WL4RdIEo73RbAGZnbx3WjMP
	Wfe48/GE2PqsAvM2CQqyAbaIL163tN3AJYC22X4OgAXRNfM6Fwo6y4BgohcYuwflY16
	Yd2n3imz2vAxwLpj6S75G7GTZm9O5p1uveeZL4KA=
Received: by mx.zohomail.com with SMTPS id 1774073713696906.8987266611789;
	Fri, 20 Mar 2026 23:15:13 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] cxl/hdm: Add support for 32 switch decoders
Date: Sat, 21 Mar 2026 14:14:59 +0800
Message-ID: <20260321061459.1910205-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228a41846d621cffd570ff3dd2b00007d26f5ee1df0a8a68b09280a4adb57dcca844681c9b1f7a4c402:zu08011227f218607ce2f145a162a2c5920000d4dcb8b8d0956c0c3004ac73b57011a16c3ff11ab497cf43fd:rf0801122d2f56d9e7a45b7c7cf5593a3c000072ce1e779c8bfeedb88d724e70796c59cd44dd53eeaf4c84fa77a9915dbac2:ZohoMail
X-ZohoMailClient: External

Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
support 32 HDM decoders. Current implementation misses some decoders on
CXL host bridge and switch in the case that the value of Decoder Count
field in CXL HDM decoder Capability Register is greater than or equal to
9.

Update calculation implementation to ensure the decoder count calculation
is correct for CXL host bridge/switch ports.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
Changes from v1:
- Return -ENXIO if the value violates SPEC. (Dave & Alison)
---
 drivers/cxl/core/hdm.c |  2 +-
 drivers/cxl/cxl.h      | 11 ++++++++++-
 drivers/cxl/cxlmem.h   |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c222e98ae736..3930e130d6b6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -177,7 +177,7 @@ static struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	}
 
 	parse_hdm_decoder_caps(cxlhdm);
-	if (cxlhdm->decoder_count == 0) {
+	if (cxlhdm->decoder_count < 0) {
 		dev_err(dev, "Spec violation. Caps invalid\n");
 		return ERR_PTR(-ENXIO);
 	}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9b947286eb9b..0a5301049cf3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -77,7 +77,16 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
 	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
 
-	return val ? val * 2 : 1;
+	switch (val) {
+	case 0:
+		return 1;
+	case 1 ... 8:
+		return val * 2;
+	case 9 ... 12:
+		return (val - 4) * 4;
+	default:
+		return -ENXIO;
+	}
 }
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e21d744d639b..399b150b404c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -923,7 +923,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
  */
 struct cxl_hdm {
 	struct cxl_component_regs regs;
-	unsigned int decoder_count;
+	int decoder_count;
 	unsigned int target_count;
 	unsigned int interleave_mask;
 	unsigned long iw_cap_mask;
-- 
2.43.0

