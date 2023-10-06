Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC776AA2
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVd8Bxnc"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F47EE4
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577189; x=1728113189;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WUVCTriV4DblB6HFbzHOc/CfOxuFpWx3xEn/9moPfQo=;
  b=HVd8BxncmJwJiNvfKF3tSz35RLaKFrEA/JscP4x6OC4La5FXxq+HtAzX
   eg3D9fkRNRKGICtbjQFTB+m6vBpZT6AGofS4yurlvkVvx52oOzix2vxCi
   v8wIj6EH1lAqUGAH6zlzBdIX60cqLuRPAswN3Ax1r6tiW0GPOZh42rrDX
   ke7np840bZ2dRsa2ZXkiYCzf5mMeLiiknIS3jlqqil13qLxCQbPHlLx5K
   GcoB9JhbtOe5x9F5sVS6lE/5kITGVVelub+j+oTJx3vcR9uI5lTKuOBig
   mmLdx24+4wJ/V9cCulKgCk57/AMOqO2NQEiGn05bA6geM+rCKt3I2I2dl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="450192237"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="450192237"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817923219"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817923219"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:28 -0700
Subject: [PATCH v3 05/10] cxl/pci: Clarify devm host for memdev relative
 setup
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Date: Fri, 06 Oct 2023 00:26:28 -0700
Message-ID: <169657718805.1491153.2457900463470349092.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is all too easy to get confused about @dev usage in the CXL driver
stack. Before adding a new cxl_pci_probe() setup operation that has a
devm lifetime dependent on @cxlds->dev binding, but also references
@cxlmd->dev, and prints messages, rework the devm_cxl_add_memdev() and
cxl_memdev_setup_fw_upload() function signatures to make this
distinction explicit. I.e. pass in the devm context as an @host argument
rather than infer it from other objects.

This is in preparation for adding a devm_cxl_sanitize_setup_notifier().

Note the whitespace fixup near the change of the devm_cxl_add_memdev()
signature. That uncaught typo originated in the patch that added
cxl_memdev_security_init().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c    |   16 ++++++++--------
 drivers/cxl/cxlmem.h         |    5 +++--
 drivers/cxl/pci.c            |    4 ++--
 tools/testing/cxl/test/mem.c |    4 ++--
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 6efe4e2a2cf5..63353d990374 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -960,12 +960,12 @@ static const struct fw_upload_ops cxl_memdev_fw_ops = {
         .cleanup = cxl_fw_cleanup,
 };
 
-static void devm_cxl_remove_fw_upload(void *fwl)
+static void cxl_remove_fw_upload(void *fwl)
 {
 	firmware_upload_unregister(fwl);
 }
 
-int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
+int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct device *dev = &cxlds->cxlmd->dev;
@@ -978,10 +978,9 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
 				       &cxl_memdev_fw_ops, mds);
 	if (IS_ERR(fwl))
 		return PTR_ERR(fwl);
-
-	return devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload, fwl);
+	return devm_add_action_or_reset(host, cxl_remove_fw_upload, fwl);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
+EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_fw_upload, CXL);
 
 static const struct file_operations cxl_memdev_fops = {
 	.owner = THIS_MODULE,
@@ -1019,9 +1018,10 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
 	}
 
 	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
- }
+}
 
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -1053,7 +1053,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
+	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
 	return cxlmd;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 55f00ad17a77..fdb2c8dd98d0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -84,9 +84,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds);
 struct cxl_memdev_state;
-int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds);
+int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds);
 int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index dc665b12be8f..7c117eb62750 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -867,11 +867,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	cxlmd = devm_cxl_add_memdev(cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-	rc = cxl_memdev_setup_fw_upload(mds);
+	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
 	if (rc)
 		return rc;
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 464fc39ed277..68118c37f0b5 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1450,11 +1450,11 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mdata->mes.mds = mds;
 	cxl_mock_add_event_logs(&mdata->mes);
 
-	cxlmd = devm_cxl_add_memdev(cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-	rc = cxl_memdev_setup_fw_upload(mds);
+	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
 	if (rc)
 		return rc;
 

