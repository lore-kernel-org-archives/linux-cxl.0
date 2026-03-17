Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991227EFEE
	for <linux-cxl@vger.kernel.org>; Tue, 17 Mar 2026 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791371; cv=none; b=aIV/PWhHhHnTUEM2pmCGiU3SExGx1EwLsOlTcRer2yirlLfydUkkhKj+ZqGh5PEY0Btzvnu2/UdBF5j90GfKhoVoU6M0Did4e8eQrytPi5QEWCB9mqoQLzmFwq+QILFBCY5JG6qfz7dLNiCCTZTpEw+5XPZrAxv8GLRvJOsBwDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791371; c=relaxed/simple;
	bh=Zzy9VJrO0dIyYKilW290iDA2JcoJ9nh2Xg9tLrQXIfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9jslWsTwNj2WR0uVRBMubx60AfFh/xaZ+SKKi2YFL/VvWiHriiOMGMe8nbP2NtbX+/b02xPiZ+/Wha122NEnYaWJ/8QYM5YiuAAFo+VHZkseH14BG+Cj2kUehOukEkHJsMPeqL40tmG02tRhFei1Y1SdIdJeFc2w8EU7EFvJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C81BC4CEF7;
	Tue, 17 Mar 2026 23:49:31 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com
Subject: [PATCH v2] cxl: Add endpoint decoder flags clear when PCI reset happens
Date: Tue, 17 Mar 2026 16:49:26 -0700
Message-ID: <20260317234926.3545119-1-dave.jiang@intel.com>
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
v2:
- Rename CLEAR_MASK to RESET_MASK (Alison)
- Make the helper function take a mask argument to specify which flags
  to clear (Alison)
---
 drivers/cxl/cxl.h |  1 +
 drivers/cxl/pci.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
index fbb300a01830..a0bba4b4db92 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1030,6 +1030,20 @@ static void cxl_error_resume(struct pci_dev *pdev)
 		 dev->driver ? "successful" : "failed");
 }
 
+static int cxl_decoder_clear_flags(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	unsigned long *flags = data;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxled->cxld.flags &= ~(*flags);
+
+	return 0;
+}
+
 static void cxl_reset_done(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
@@ -1045,6 +1059,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	guard(device)(&cxlmd->dev);
 	if (cxlmd->endpoint &&
 	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
+		unsigned long flags = CXL_DECODER_F_RESET_MASK;
+
+		device_for_each_child(&cxlmd->endpoint->dev, &flags,
+				      cxl_decoder_clear_flags);
+
 		dev_crit(dev, "SBR happened without memory regions removal.\n");
 		dev_crit(dev, "System may be unstable if regions hosted system memory.\n");
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0

