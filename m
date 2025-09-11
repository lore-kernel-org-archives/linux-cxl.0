Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF332DC77C
	for <linux-cxl@vger.kernel.org>; Thu, 11 Sep 2025 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623461; cv=none; b=tbxW26p7vwZtMEF72sInmHP2V93YUVlcuCAxcMY+/2/wbzlECA50CraDZ6k24VHC+f5GyLX8I0HinkBoDYEaWzk+j7xHhdFOl5uy/EK5murRAR8G0em75tvn+SdNbpz+dnKfgDJd/rNxvoWvo8Ke1FG1DVFn6+4zFkO9cqZjSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623461; c=relaxed/simple;
	bh=DTvdkTh5vOUoiILLDd9QnKxRsBqhhrIBbN1GSVDEUQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNVYWDqz1JOaflC/1tMbYFbWHDzwnv/FWqFTruzRTj6P5/aB6QK7kBWmeGEC5cM3ftVLWpkecqw6WDUoU1zqNffJx7e2Gm7wGKBAmgygyTDOIHfNTObdFwMayxSynTTF85ksWdjQHQyvl+xIL47YlGiBoeqzDovlT3L1LNM74wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690D6C4CEF0;
	Thu, 11 Sep 2025 20:44:20 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH] cxl: Move port register setup to when first dport appear
Date: Thu, 11 Sep 2025 13:44:06 -0700
Message-ID: <20250911204406.2454689-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
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
host bridge (CHBCR) during cxl_acpi driver probe. If the cxl_acpi module
probe is running before the CXL link between the endpoint device and the
RP is established, then the platform may not have exposed DVSEC ID 3
and/or DVSEC ID 7 blocks which will trigger the error message. This
behavior is defined by the CXL spec r3.2 9.12.3 for RPs and DSPs, however
the Intel platform also added this behavior to the host bridge.

This change also needs the dport enumeration to be moved to the memdev
probe path in order to address the issue. This change is not a wholly
contained solution by itself.

Suggested-by: Dan Williamsn <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

I pulled this patch out to continue the discussion with Robert and not
hold up the dport series.

While the behavior observed on the Intel platform is a quirk, similar
behavior can exist for RPs and DSPs allowed by the spec. CXL spec r3.2
9.12.3 states that CXL DVSEC ID 3 and 7 may or may not be exposed and
the software can use ID 7 and link status to determine CXL link is
established. Thus to cover the spec allowance it is reasonable to not
access the port registers until we are certain the CXL link is initialized.
And the first dport appearance ensures that. While this issue is
only observed WRT CHBCR on that platform, the enabling code covers the
common case for all RPs and switches and the allowance provided by
the spec for future implementations.
---
 drivers/cxl/core/port.c | 16 +++++++++++++---
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 76dd06d282df..416d45516d82 100644
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
index 6c42646f47ba..bdc682a7d60b 100644
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

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
prerequisite-patch-id: e96001d5ba3459a014f818421b1f771e88775c9f
prerequisite-patch-id: 8b216a3f53da0be4117ba50a3a8ecbb0dbe61041
prerequisite-patch-id: 8da2fd3d645d11c1c6cb33aab62590f2533b737b
prerequisite-patch-id: 04a9b9c9e69bbff4da3917a33e8b7c1d77059c1f
prerequisite-patch-id: c0accfef8f5a037fa7456d2517eb197eb910739c
prerequisite-patch-id: 0f3f0698af3958b2e4cabf66dd2268132c2c51fb
prerequisite-patch-id: 3f47d2470e1c7bd34fd509a27331d72c45d33847
prerequisite-patch-id: 434177b7f4f808aeeace5d7d1e17108f66a7d6cb
prerequisite-patch-id: 6a6f4dbe624e00865bb1e087dcbd8bc9c8807a18
prerequisite-patch-id: 95e0c0aa6d4589772e6c38780eaed739d54ee755
-- 
2.50.1

