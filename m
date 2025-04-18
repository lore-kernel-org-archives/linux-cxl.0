Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99745442C
	for <linux-cxl@vger.kernel.org>; Fri, 18 Apr 2025 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936175; cv=none; b=MiLSEqg8Y4NEJVovI62lLuUcJ/15QSzQHUQPKiNenx7u+wLQpPzyLn0I5l+5tF8zkcng6o5IIcgljBM8od+VUovdmb9QCVC086H504Vr/Fe9x0Tl+4aeqnOVl9aj0dlfS524YN/VHIas0E+Uk6+M2CvgKebyzMcIGUpGR8WHmHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936175; c=relaxed/simple;
	bh=xDnA2Cgm31sM5Uotuv+AV1EwZKmGrgoZByHUB9KMJME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3yG6nAIFfyzJEUWtDSQRLgPRXp9G/7ClpTIX0QVWJKOdc6uMZS1OKNTTodd7JzZLiM/SMHT/fls8gOMolbF3rfRc/tSv5Bn9Al2UsTLEjs29tG2QNKmTdik+AGaxZqA+I06POPqAWfv06p+vjlR7mcXLmurnaLmcgjuwPIjt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E699AC4CEE4;
	Fri, 18 Apr 2025 00:29:34 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl: Fix devm device for cxl_fwctl initialization
Date: Thu, 17 Apr 2025 17:29:33 -0700
Message-ID: <20250418002933.406439-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing revealed error message of for a CXL memdev that has Feature support:
[   56.690430] cxl mem0: Resources present before probing

Attach the allocation of cxl_fwctl to the parent device of cxl_memdev.
devm_add_* calls for cxl_memdev should not happen before the memdev
probe function or outside the scope of the memdev driver.

Fixes: 858ce2f56b52 ("cxl: Add FWCTL support to CXL")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c  | 4 ++--
 drivers/cxl/pci.c            | 2 +-
 include/cxl/features.h       | 5 +++--
 tools/testing/cxl/test/mem.c | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index f4daefe3180e..150a1776480a 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -677,7 +677,7 @@ static void free_memdev_fwctl(void *_fwctl_dev)
 	fwctl_put(fwctl_dev);
 }
 
-int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
+int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_features_state *cxlfs;
@@ -700,7 +700,7 @@ int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
 	if (rc)
 		return rc;
 
-	return devm_add_action_or_reset(&cxlmd->dev, free_memdev_fwctl,
+	return devm_add_action_or_reset(host, free_memdev_fwctl,
 					no_free_ptr(fwctl_dev));
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_fwctl, "CXL");
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7b14a154463c..785aa2af5eaa 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1018,7 +1018,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = devm_cxl_setup_fwctl(cxlmd);
+	rc = devm_cxl_setup_fwctl(&pdev->dev, cxlmd);
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL FWCTL setup\n");
 
diff --git a/include/cxl/features.h b/include/cxl/features.h
index a3bb34694c06..5f7f842765a5 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -66,7 +66,7 @@ struct cxl_memdev;
 #ifdef CONFIG_CXL_FEATURES
 inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
 int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
-int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd);
+int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd);
 #else
 static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
 {
@@ -78,7 +78,8 @@ static inline int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 	return -EOPNOTSUPP;
 }
 
-static inline int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
+static inline int devm_cxl_setup_fwctl(struct device *host,
+				       struct cxl_memdev *cxlmd)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index f2957a3e36fe..bf9caa908f89 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1780,7 +1780,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = devm_cxl_setup_fwctl(cxlmd);
+	rc = devm_cxl_setup_fwctl(&pdev->dev, cxlmd);
 	if (rc)
 		dev_dbg(dev, "No CXL FWCTL setup\n");
 
-- 
2.49.0

