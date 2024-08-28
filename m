Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91D15DBDD
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835018; cv=none; b=iQuS2C9088P/4U5iVRUbYWRpHUk70RCbaaSOvzjivvlK9i/HtDHkr4s2U47yOkL9xdm8x3an7fmdT+ygQL/LqaLUHEKetpzZnQEt1oLLrpUgrJeC3NMbEei/PS6B0phcOlr8aN3th2uLehPcamrNj0BQG88k2Yw+Sjh/uuaQQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835018; c=relaxed/simple;
	bh=43nIiQjTzmSP5bh6pAfz1We2jpQJ+M1wLHmyKywU0+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjSlygMYNpaMeukLLJ8YipqCQtekB6mowoGWeAf4nfE7nPH748mxDYoqvvNY8PbikxpRHMQJ0Cb1pE7Yjxz+KvC4S3gRVm6gRcBEhBvUignUIUtVwCQuyYcV3aVjyMdiWW5uJCrvg54NlkdSKGUudW7j/J1NIuIrOd5d1h3HPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqC+k6wb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqC+k6wb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724835017; x=1756371017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=43nIiQjTzmSP5bh6pAfz1We2jpQJ+M1wLHmyKywU0+s=;
  b=bqC+k6wbmJIU6jDCuQWtIoimctFc2cox4RqtWmsvN5KhQafnOi4wOlK8
   w9r06elqFB0n8HGUKBjwUcrItEQkRRsa5mty3OEOEEmy2m428wPBV4d+c
   0fhSPPN/gU6EulZ221HiIhgzOoQ6JKVnReNYIwPzAbqLy7GIxSeJRghEo
   VWL5kRj1zIBoyo95S+SwfRBiExeCa1lC/sIoQx/q8HHdcskbPG6cYhZIY
   lOH+BfYjCsPmtANWI7nj/OViDHrzx6piQpCryx+NyOyz/lc6djj8mDv5O
   NO2BD58mvDoVkADi7+7icSx8/efE2jx5gXceDWKuyiWHXxfKnWKfuLK/5
   g==;
X-CSE-ConnectionGUID: eCe+fg3tRBW43qgOWmgPkA==
X-CSE-MsgGUID: UsqSpu1kQh+IgZbFRFDA9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22874626"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="22874626"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:16 -0700
X-CSE-ConnectionGUID: PKbQTGY7SAiB/JpEIryfZg==
X-CSE-MsgGUID: aohfmdeFQIaGyEzl6YVdsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="62999040"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:11 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [v4 2/4] cxl/pci: Remove duplicated implementation of waiting for memory_info_valid
Date: Wed, 28 Aug 2024 16:42:29 +0800
Message-Id: <20240828084231.1378789-3-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828084231.1378789-1-yanfei.xu@intel.com>
References: <20240828084231.1378789-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory
related info") added another implementation, which is
cxl_dvsec_mem_range_valid(), of waiting for memory_info_valid without
realizing it duplicated wait_for_valid(). Remove wait_for_valid() and
retain cxl_dvsec_mem_range_valid() as the former is hardcoded to check
only the Memory_Info_Valid bit of DVSEC range 1, while the latter allows
for selection between DVSEC range 1 or 2 via parameter.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c        | 41 +++++------------------------------
 drivers/cxl/cxl.h             |  2 +-
 drivers/cxl/port.c            |  2 +-
 tools/testing/cxl/test/mock.c |  4 ++--
 4 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 73b6498d5e5c..f29af0b788d9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -211,37 +211,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
 
-static int wait_for_valid(struct pci_dev *pdev, int d)
-{
-	u32 val;
-	int rc;
-
-	/*
-	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
-	 * and Size Low registers are valid. Must be set within 1 second of
-	 * deassertion of reset to CXL device. Likely it is already set by the
-	 * time this runs, but otherwise give a 1.5 second timeout in case of
-	 * clock skew.
-	 */
-	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
-	if (rc)
-		return rc;
-
-	if (val & CXL_DVSEC_MEM_INFO_VALID)
-		return 0;
-
-	msleep(1500);
-
-	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
-	if (rc)
-		return rc;
-
-	if (val & CXL_DVSEC_MEM_INFO_VALID)
-		return 0;
-
-	return -ETIMEDOUT;
-}
-
 static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -322,11 +291,13 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
 
-int cxl_dvsec_rr_decode(struct device *dev, int d,
+int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 			struct cxl_endpoint_dvsec_info *info)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	int hdm_count, rc, i, ranges = 0;
+	int d = cxlds->cxl_dvsec;
 	u16 cap, ctrl;
 
 	if (!d) {
@@ -353,11 +324,9 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
-	rc = wait_for_valid(pdev, d);
-	if (rc) {
-		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
+	rc = cxl_dvsec_mem_range_valid(cxlds, 0);
+	if (rc)
 		return rc;
-	}
 
 	/*
 	 * The current DVSEC values are moot if the memory capability is
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..e2e277463794 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -809,7 +809,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
-int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
+int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d7d5d982ce69..861dde65768f 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_port *root;
 	int rc;
 
-	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
+	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
 	if (rc < 0)
 		return rc;
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index d619672faa49..63a404e05ced 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -228,7 +228,7 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
 
-int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
+int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 			       struct cxl_endpoint_dvsec_info *info)
 {
 	int rc = 0, index;
@@ -237,7 +237,7 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
 	if (ops && ops->is_mock_dev(dev))
 		rc = 0;
 	else
-		rc = cxl_dvsec_rr_decode(dev, dvsec, info);
+		rc = cxl_dvsec_rr_decode(dev, port, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
-- 
2.39.2

