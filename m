Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A4298CA5
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585239; cv=none; b=BvC6JfotvCg8sfGQHDf+jHYA1vTXQK1dJAiDNdy5tkQDtyyZveFyCHZEx9i8uUAl5DM01M0/fjj/INOfwpsSHKpwAVZtMEq2pn5wlT8PeaTekjsQDiWj8Z2ZPXQa+ID227+8Hbnlg7o+/H7v7zxoulnKRHO8nLzbqmJPMmm4xxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585239; c=relaxed/simple;
	bh=Usfyhek/cJcZTJq/YTn41nS51w+YT1nH1VVWdyRcR/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nijOXmsU0io7+k3hk/6epGk6QcfNxj1a0ZIvN8uPZDdvVf94+eyRF37IzKZQmEF8XPQzqW1i0l6kWHwKd7YoWtndxdOekwRpEp23KPXmPQLFg9d8SZlrAa3g3kwWFRvIyX0eKQwgVcZjeh5Ktuy16BUTWQ+rRN/PAZTA7JubqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BA3C4CEF0;
	Thu,  3 Jul 2025 23:27:19 +0000 (UTC)
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
Subject: [PATCH v5 02/10] cxl: Add helper to detect top of CXL device topology
Date: Thu,  3 Jul 2025 16:27:02 -0700
Message-ID: <20250703232710.3141436-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703232710.3141436-1-dave.jiang@intel.com>
References: <20250703232710.3141436-1-dave.jiang@intel.com>
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

