Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23B28ECDD
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852490; cv=none; b=iIdu9m0lO6/Qa8RHCx+ZTOJDxnArHSv9Cy7clxDuwd+EEgYixl7KKWZ6bgtEq1/FuGITimHgtsc9vzuF+WBJJWWiD7v3m/EsaqQi1+FZqVkhXoas8QoWlRezyaSZb41jAJEC+vwM+7EAf1wVLkR9hceyFfLOdkc70Qk+ErQoyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852490; c=relaxed/simple;
	bh=pLDeQ5+QdoHGtagLDPajvTt0pn+6v+vA1CT+UhVfJFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfYOcNN6EKLNwv/yX7pcSj+gB4cWer+pI/1B6Tb7Jn9A9D3REzGhoTVihuFU5zsJ6AbhJjqidaeYnS5E1hIliSsfwtPLV15D6N6YnDaLSRKCr9RtjzBhhKOOvjTdQFXGJ/4KfirCwsEWW4s9l0qq5LiUARNhe9EoBPgGaFQgG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE81C4CEE4;
	Wed, 21 May 2025 18:34:49 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonsathan.Cameron@huawei.com>
Subject: [PATCH v3 2/9] cxl: Add helper to detect top of CXL device topology
Date: Wed, 21 May 2025 11:34:36 -0700
Message-ID: <20250521183443.3828320-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521183443.3828320-1-dave.jiang@intel.com>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
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

Reviewed-by: Jonathan Cameron <Jonsathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 726bd4a7de27..cafb1b13cba1 100644
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
@@ -1642,11 +1651,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
2.49.0

