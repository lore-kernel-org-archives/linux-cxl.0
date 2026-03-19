Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B729DB9A
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933944; cv=none; b=Xpy/YxCja31IO3UiDghu67crgeL1YLeUZYHj/wXCC/bKqe/QOuXv2WAzctzOoHwX47R8ujUfdRd2b+2AlXSco9hz+vXNCKa3WT0qDyJQfZQ7UB37i1vpAkk4W4wj5gXmDiPoyunq1bCBiCJLhdvfPRw3y25uGI+wqDjnRVtMBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933944; c=relaxed/simple;
	bh=LbyY2xZOapzbL6LngObOzmr0j5kLs5dTVZZZnlpr0G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnfI22ueas9blfozmnCuwHhXZFAEkR0Fc50qjKpiF4yhoLP1XGVflBLopnx7kzXhuPQSaGZSjR2ipQugp0Hm8Xwl7JAw4oEv17rr6pa0RVxjgm41FXMxKdcEr6ISuK7egPUjI4FYVBsYp06ugjiv+mw5YDM3aP0TVs56B4KOHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5827BC19425;
	Thu, 19 Mar 2026 15:25:44 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com
Subject: [PATCH v3] cxl: Add endpoint decoder flags clear when PCI reset happens
Date: Thu, 19 Mar 2026 08:25:41 -0700
Message-ID: <20260319152541.2739343-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PCI reset happens, the lock and enable flags of the CXL device
should be cleared to avoid stale state flags after reset. Add flag
clearing during cxl_reset_done() to clear the relevant endpoint
decoder flags for all decoders of the endpoint device.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Rename cxl_decoder_clear_flags() to
  cxl_endpoint_decoder_clear_reset_flags() (Ben)
- Make the function single purpose rather than taking a flag. (Jonathan)
---
 drivers/cxl/cxl.h |  1 +
 drivers/cxl/pci.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9b947286eb9b..d09c84bcc015 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -333,6 +333,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
+#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index fbb300a01830..84cff73b39e5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1030,6 +1030,19 @@ static void cxl_error_resume(struct pci_dev *pdev)
 		 dev->driver ? "successful" : "failed");
 }
 
+static int cxl_endpoint_decoder_clear_reset_flags(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxled->cxld.flags &= ~CXL_DECODER_F_RESET_MASK;
+
+	return 0;
+}
+
 static void cxl_reset_done(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
@@ -1045,6 +1058,9 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	guard(device)(&cxlmd->dev);
 	if (cxlmd->endpoint &&
 	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
+		device_for_each_child(&cxlmd->endpoint->dev, NULL,
+				      cxl_endpoint_decoder_clear_reset_flags);
+
 		dev_crit(dev, "SBR happened without memory regions removal.\n");
 		dev_crit(dev, "System may be unstable if regions hosted system memory.\n");
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0

