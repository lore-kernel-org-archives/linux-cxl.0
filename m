Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68B21019E
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491011; cv=none; b=e+QKXROoLX4l08cZi+Ui3V2fJFIBe4SO6o5/8RS7rHzMnwN6LEaxnQM00uxMxpmVQviwj3S99m4Bb6m6z3w9s4dLm/QdemFIAw+ZB/y414yr7WlT9yvMDxh8u5gW/iCSiUf+iiV05yWAzSE8Rp2KMqEdVYcXW5Eu3MXwyDftBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491011; c=relaxed/simple;
	bh=9sTg6uft/OU6oqQUK9vlXRxqxEhRMsZ5y5U6347blqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiwljYC0zSZaoe10JnfAREFWEBrBAHnE/adxXpdfouKwroDd4jVsye9U1r5wSGIFwN+cF8YKAGVEUv70+YAdF8xtpDYX6UlpjcwHq1P65BiV0zFio5yR5C+knNDn0jK80JAyBv3mxbcQccBLJEzBf3kfv8i6l6IOfJtXqKINnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F263C4CEF4;
	Fri, 29 Aug 2025 18:10:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH v9 04/10] cxl: Move port register setup to first dport appear
Date: Fri, 29 Aug 2025 11:09:22 -0700
Message-ID: <20250829180928.842707-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829180928.842707-1-dave.jiang@intel.com>
References: <20250829180928.842707-1-dave.jiang@intel.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 16 +++++++++++++---
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7344048f678e..f379e4c5121d 100644
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

