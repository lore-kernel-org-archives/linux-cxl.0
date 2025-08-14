Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDC14A60F
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210164; cv=none; b=kyUCQ0Acw66O2y8PYOEjZ1HqDwIoIW+NBo/BPoeoBk3ASx/48c9HvQekLTMD1nJulBEUe08ARHv/JhrcWcoLroArlr7osMcgHwweZsR1uD272jrisGEmPQNc4VgkuP25pfEwrnXMynFRJiPOaA57YNN7TaUk8AcY0SMrXvBC4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210164; c=relaxed/simple;
	bh=LrbDOQOJ1jFwdliCwgKVS3piOYu6pG6RcVwtvNgI170=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnLaUZOGfGoNG4xBdl6xb4UAPc7/H6yI+gVlAoBkGq+1MRdhKruaXMf/22QXzXpzgOB6fIKzp9TEBnz/DhkFT4Bng6C1BEH7G40Ozq2TUca3P6R0KlSvdnkFMLj4cRJpknINGAPcbi+VasjYewtH/JQx2NF9q/mSiuSvNBgUqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67572C4CEED;
	Thu, 14 Aug 2025 22:22:42 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH v8 04/11] cxl: Move port register setup to first dport appear
Date: Thu, 14 Aug 2025 15:21:44 -0700
Message-ID: <20250814222151.3520500-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814222151.3520500-1-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the port register setup to when the first dport appears
via the memdev probe path. At this point, the CXL link should be
established and the register access is expected to succeed. This change
addresses an error message observed when PCIe hotplug is enabled on
an Intel platform. The error messages "cxl portN: Couldn't locate the
CXL.cache and CXL.mem capability array header" is observed for the
hostbridge during cxl_acpi driver probe. If the cxl_acpi module
probe is running before the CXL link between the endpoint device and the
RP is established, then the platform may not have exposed DVSEC ID 3
and/or DVSEC ID 7 blocks which will trigger the error message. This
behavior is defined by the spec and not a hardware quirk.

This change also needs the dport enumeration to be moved to the memdev
probe path in order to address the issue. This change is just part of
the code refactoring and is not a wholly contained fix itself.

Suggested-by: Dan Williamsn <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 16 +++++++++++++---
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 48e76673aaf3..25209952f469 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -867,9 +867,7 @@ static int cxl_port_add(struct cxl_port *port,
 		if (rc)
 			return rc;
 
-		rc = cxl_port_setup_regs(port, component_reg_phys);
-		if (rc)
-			return rc;
+		port->component_reg_phys = component_reg_phys;
 	} else {
 		rc = dev_set_name(dev, "root%d", port->id);
 		if (rc)
@@ -1200,6 +1198,18 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_debugfs_create_dport_dir(dport);
 
+	/*
+	 * Setup port register if this is the first dport showed up. Having
+	 * a dport also means that there is at least 1 active link.
+	 */
+	if (port->nr_dports == 1 &&
+	    port->component_reg_phys != CXL_RESOURCE_NONE) {
+		rc = cxl_port_setup_regs(port, port->component_reg_phys);
+		if (rc)
+			return ERR_PTR(rc);
+		port->component_reg_phys = CXL_RESOURCE_NONE;
+	}
+
 	return dport;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4b858f3d44c6..87a905db5ffb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -599,6 +599,7 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
+ * @component_reg_phys: Physical address of component register
  */
 struct cxl_port {
 	struct device dev;
@@ -622,6 +623,7 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
+	resource_size_t component_reg_phys;
 };
 
 /**
-- 
2.50.1

