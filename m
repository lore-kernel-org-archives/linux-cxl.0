Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8213475C
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039402; cv=none; b=M2cu0JOyFlXsgZeM/+7H3zunQl+JppM7LvyUKwClCJXLRMYSNWZ2WmeJ6kLOuxDuT8qiYdiBxdHbcp3FGhGjMC+NL+FGz6xBuntTKWW1ZNjC2nE3aqgHPbdL6Cd+xvdD5L5ycSjtlrStAvCXgWgZBc8T7mdNv3jWYk42ZwWlUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039402; c=relaxed/simple;
	bh=iDAwl7cQqRDKehq/IxWu4wiGp4tO44OV6DDMt8MK8I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ar0DlbOIOvsY1kfb5MAJaH7n/XPSHS1A/5CH2HsP+jqGg2t1+aFiI9iAamlLZjN3LDyBv1gife3frtUzrkxLiFzy26YpS7S22F+PBaZW5bVTUp97yGuKYq3L6aI28GX7jUKg3MTUBDf6rpSU8q4nYWljLK3uwjBk9NftQuEPPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59150C433F1;
	Thu, 15 Feb 2024 23:23:22 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH] cxl: Add post reset warning if the reset is detected as Secondary Bus Reset (SBR)
Date: Thu, 15 Feb 2024 16:23:07 -0700
Message-ID: <20240215232307.2793530-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBR is equivalent to a device been hot removed and inserted again. Doing a
SBR on a CXL type 3 device is problematic if the exported device memory is
part of system memory that cannot be offlined. The event is equivalent to
violently ripping out that range of memory from the kernel. While the
hardware requires the "Unmask SBR" bit set in the Port Control Extensions
register and the kernel currently does not unmask it, user can unmask
this bit via setpci or similar tool.

The driver does not have a way to detect whether a reset coming from the
PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
detect is to note if there are active decoders before the reset and check
if the range register memory active bit remains set after reset.

A helper function to check is added to detect if the range register memory
active bit is set. A locked helper for cxl_num_decoders_committed() is also
added to allow pci code to call the cxl_num_decoders_committed() while
holding the cxl_region_rwsem.

Add a err_handler->reset_prepare() to detect whether there are active
decoders.  Add a err_handler->reset_done() to check if there was active
memory before the reset and it is no longer active after the reset. A
warning is emitted in the case of active memory has been offlined.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c  | 14 ++++++++++++++
 drivers/cxl/core/port.c | 11 +++++++++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/cxlmem.h    |  1 +
 drivers/cxl/pci.c       | 31 +++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6c9c8d92f8f7..73b5cd54e761 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -322,6 +322,20 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
 
+bool cxl_dvsec_rr_active(struct device *dev, int d)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u32 temp;
+	int rc;
+
+	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
+	if (rc)
+		return false;
+
+	return FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_active, CXL);
+
 int cxl_dvsec_rr_decode(struct device *dev, int d,
 			struct cxl_endpoint_dvsec_info *info)
 {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..81d9f57d2e84 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -45,6 +45,17 @@ int cxl_num_decoders_committed(struct cxl_port *port)
 	return port->commit_end + 1;
 }
 
+int cxl_num_decoders_committed_locked(struct cxl_port *port)
+{
+	int decoders;
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+	decoders = cxl_num_decoders_committed(port);
+
+	return decoders;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed_locked, CXL);
+
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6017c0c57b4..530c7e693096 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -720,6 +720,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 }
 
 int cxl_num_decoders_committed(struct cxl_port *port);
+int cxl_num_decoders_committed_locked(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
 struct pci_bus;
@@ -800,6 +801,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
 int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
 			struct cxl_endpoint_dvsec_info *info);
+bool cxl_dvsec_rr_active(struct device *dev, int d);
 
 bool is_cxl_region(struct device *dev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5303d6942b88..9f1814005322 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -440,6 +440,7 @@ struct cxl_dev_state {
 	struct resource ram_res;
 	u64 serial;
 	enum cxl_devtype type;
+	bool active_rr_prereset;
 };
 
 /**
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 233e7c42c161..5a5fda7134f6 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -957,11 +957,42 @@ static void cxl_error_resume(struct pci_dev *pdev)
 		 dev->driver ? "successful" : "failed");
 }
 
+static void cxl_reset_prepare(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+
+	if (cxl_num_decoders_committed_locked(cxlmd->endpoint))
+		cxlds->active_rr_prereset = true;
+}
+
+static void cxl_reset_done(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+
+	/*
+	 * FLR does not expect to touch the HDM decoders and related registers.
+	 * SBR however will wipe all device configurations.
+	 * Issue warning if there was active configuration before reset that no
+	 * longer exists.
+	 */
+	if (cxlds->active_rr_prereset &&
+	    !cxl_dvsec_rr_active(&pdev->dev, cxlds->cxl_dvsec)) {
+		dev_warn(dev, "SBR happened without memory regions removal.\n");
+		dev_warn(dev, "System may be unstable if regions hosted system memory.\n");
+	}
+	cxlds->active_rr_prereset = false;
+}
+
 static const struct pci_error_handlers cxl_error_handlers = {
 	.error_detected	= cxl_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
 	.cor_error_detected	= cxl_cor_error_detected,
+	.reset_prepare	= cxl_reset_prepare,
+	.reset_done	= cxl_reset_done,
 };
 
 static struct pci_driver cxl_pci_driver = {
-- 
2.43.0

