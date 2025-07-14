Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA045230BD9
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532542; cv=none; b=H2SEZpv9U0ixdCICm////mEDY/zJA64RGJYvh56V7EGc7AIhTantKs7A9gvC0oSTjqpr0No216DCbJUM8rkgArFr1oLYO6HPZwUF2zL1HcSEKKsUYpJOnd0nkEG8745SYUkEsuHIPNTMbEU0nKjsAgfAYBgGFEHC9CtpuH1TUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532542; c=relaxed/simple;
	bh=Usfyhek/cJcZTJq/YTn41nS51w+YT1nH1VVWdyRcR/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+5TgggLWbIYTA3PByPCVSsL/6aoiPb2HnYuEzQK/SnEcObbELNTm3l492a8fMBqGaKcRF45OEhQ1moMZ1z323YawBQU5poxSoVCZsR4O63hImBqbGk7a9uV2P5G6OdpxyrNzkVG+5J587F8k/ROjU8hnZA4pQIqX/6qNY6u5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4265BC4CEED;
	Mon, 14 Jul 2025 22:35:42 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v7 02/10] cxl: Add helper to detect top of CXL device topology
Date: Mon, 14 Jul 2025 15:35:19 -0700
Message-ID: <20250714223527.461147-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714223527.461147-1-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper to replace the open code detection of CXL device hierarchy
root. The helper will be used for delayed hostbridge port creation later
on.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eb46c6764d20..a49491c14d19 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -39,6 +39,15 @@ DECLARE_RWSEM(cxl_region_rwsem);
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+/*
+ * The terminal device in PCI is NULL and @platform_bus
+ * for platform devices (for cxl_test)
+ */
+static bool is_cxl_hierarchy_head(struct device *dev)
+{
+	return (!dev || dev == &platform_bus);
+}
+
 int cxl_num_decoders_committed(struct cxl_port *port)
 {
 	lockdep_assert_held(&cxl_region_rwsem);
@@ -1635,11 +1644,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		struct device *uport_dev;
 		struct cxl_dport *dport;
 
-		/*
-		 * The terminal "grandparent" in PCI is NULL and @platform_bus
-		 * for platform devices
-		 */
-		if (!dport_dev || dport_dev == &platform_bus)
+		if (is_cxl_hierarchy_head(dport_dev))
 			return 0;
 
 		uport_dev = dport_dev->parent;
-- 
2.50.0

