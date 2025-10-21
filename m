Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90826FA60
	for <linux-cxl@vger.kernel.org>; Tue, 21 Oct 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079857; cv=none; b=CBqzrOmlk2Kt3363ABNLaY+NqhuWnaYYEZb4RZ3unsvqT9XHs5TKRyGEjrtmJvZ7ZZ7XnJhWMr2ssOVX1t4s5u//5/gTKAXzMXMfmN3fZsoLNhaWkga7oz0M895iwjH1BAGU8342sXUhS9qhXRLgIr7Ktv1aAZlWPwG9Uz5OweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079857; c=relaxed/simple;
	bh=+HYcai2HFBbCUikKPgjqPncsSsDp4N1HPlgnS5NaPqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9iePdzcoGicaJAzFdbmMO1GKLfmwH6mqTcJVk4qfwB580IgqX0fxJ6/uqX9L2DDMDtdg+dUsZAyCFGIIYd+A0AIM2vqUCrd0ry9+uq+77cWGN9YJHP/J385S/vPIC8zjxZ3t+Wtj3pYkbv37vl29jIlqxLjK0z3FLd+kMAVr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8529C4CEF7;
	Tue, 21 Oct 2025 20:50:56 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl: Add handling of locked CXL decoder
Date: Tue, 21 Oct 2025 13:50:55 -0700
Message-ID: <20251021205055.2081800-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a decoder is locked, it means that its configuration cannot be
changed. CXL spec r3.2 8.2.4.20.13 discusses the details regarding
locked decoders. Locking happens when bit 8 of the decoder control
register is set and then the decoder is committed afterwards (CXL
spec r3.2 8.2.4.20.7).

Given that the driver creates a virtual decoder for each CFMWS, the
Fixed Device Configuration (bit 4) of the Window Restriction field is
considered as locking for the virtual decoder by the driver.

The current driver code disregards the locked status and a region can
be destroyed regardless of the locking state.

Add a region flag to indicate the region is in a locked configuration.
The driver will considered a region locked if the CFMWS or any decoder
is configured as locked. The consideration is all or nothing regarding
the locked state. It is reasonable to determine the region "locked"
status while the region is being assembled based on the decoders.

Add a check in region commit_store() to intercept when a 0 is written
to the commit sysfs attribute in order to prevent the destruction of a
region when in locked state. This should be the only entry point from user
space to destroy a region.

Add a check is added to cxl_decoder_reset() to prevent resetting a locked
decoder within the kernel driver.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c    |  3 +++
 drivers/cxl/core/region.c | 16 ++++++++++++++++
 drivers/cxl/cxl.h         |  8 ++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d3a094ca01ad..1c5d2022c87a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -905,6 +905,9 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
 		return;
 
+	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
+		return;
+
 	if (port->commit_end == id)
 		cxl_port_commit_reap(cxld);
 	else
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..8647eff4fb78 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -419,6 +419,9 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 		return len;
 	}
 
+	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
+		return -EPERM;
+
 	rc = queue_reset(cxlr);
 	if (rc)
 		return rc;
@@ -1059,6 +1062,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 	return 0;
 }
 
+static void cxl_region_set_lock(struct cxl_region *cxlr,
+				struct cxl_decoder *cxld)
+{
+	if (!test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
+		return;
+
+	set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
+	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
+}
+
 /**
  * cxl_port_attach_region() - track a region's interest in a port by endpoint
  * @port: port to add a new region reference 'struct cxl_region_ref'
@@ -1170,6 +1183,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 	}
 
+	cxl_region_set_lock(cxlr, cxld);
+
 	rc = cxl_rr_ep_add(cxl_rr, cxled);
 	if (rc) {
 		dev_dbg(&cxlr->dev,
@@ -2439,6 +2454,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;
 	cxlr->id = id;
+	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
 
 	return cxlr;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 231ddccf8977..6382f1983865 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -517,6 +517,14 @@ enum cxl_partition_mode {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/*
+ * Indicate whether this region is locked due to 1 or more decoders that have
+ * been locked. The approach of all or nothing is taken with regard to the
+ * locked attribute. CXL_REGION_F_NEEDS_RESET should not be set if this flag is
+ * set.
+ */
+#define CXL_REGION_F_LOCK 2
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.51.0

