Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CA21019E
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490991; cv=none; b=keTu71/3z36Ik2JdqMuDeEHNV+da0xkOraceSSvI2Em4VGd/pqaPKSHi9C7wM7AlzwvPXJzt7+UePbJXZ66Hg3sdoc2YzpWfcoU7w2aI/250mgVnpC+TWGPdM/5bE1JMceMWPW89OG/Zx0PtWnrNT/HumATuncby5eKFiWrqxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490991; c=relaxed/simple;
	bh=ENQU8vPkDLmgSjpsQp++Es31+AyFEH3G0OSOOznmG6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po5kQefcIVWFHu+pLQFe2ccXnxg/U4RPgI5sKt7ZLop8C56J3wG4MpqxS0EwicCZIGQEjT5dhqXxGYAB9ma4YarFcgM5ZkGhbMRI6yKtoA++mrIQhIOQq8v/piacub5tgZPN1+O7IW19o4tAds0Zb4X6AK7Q4wPV0dZYO//f/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1B2C4CEF0;
	Fri, 29 Aug 2025 18:09:49 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v9 01/10] cxl: Add helper to detect top of CXL device topology
Date: Fri, 29 Aug 2025 11:09:19 -0700
Message-ID: <20250829180928.842707-2-dave.jiang@intel.com>
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

Add a helper to replace the open code detection of CXL device hierarchy
root, or the host bridge. The helper will be used for delayed downstream
port (dport) creation.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Tested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 29197376b18e..855623cebd7d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -33,6 +33,15 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+/*
+ * The terminal device in PCI is NULL and @platform_bus
+ * for platform devices (for cxl_test)
+ */
+static bool is_cxl_host_bridge(struct device *dev)
+{
+	return (!dev || dev == &platform_bus);
+}
+
 int cxl_num_decoders_committed(struct cxl_port *port)
 {
 	lockdep_assert_held(&cxl_rwsem.region);
@@ -1541,7 +1550,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	resource_size_t component_reg_phys;
 	int rc;
 
-	if (!dparent) {
+	if (is_cxl_host_bridge(dparent)) {
 		/*
 		 * The iteration reached the topology root without finding the
 		 * CXL-root 'cxl_port' on a previous iteration, fail for now to
@@ -1629,11 +1638,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		struct device *uport_dev;
 		struct cxl_dport *dport;
 
-		/*
-		 * The terminal "grandparent" in PCI is NULL and @platform_bus
-		 * for platform devices
-		 */
-		if (!dport_dev || dport_dev == &platform_bus)
+		if (is_cxl_host_bridge(dport_dev))
 			return 0;
 
 		uport_dev = dport_dev->parent;
-- 
2.50.1

