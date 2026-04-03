Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B83D8907;
	Fri,  3 Apr 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249979; cv=none; b=DK/Gpjw9UvugdhhLJyCX/1V78iZxzDjNRRzebRjBz2/FrTP7Xd4KJtxFnrhPx6wxpc/fZAir/eHGbMXoVMyOTpLTcwfxHMXo1pK/daklP55cXhvIO8Gpvvrwx0lmA7pm9KJWVw6CqFx2dRN2rbQDDXL6/PLond1r1unu5aOzwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249979; c=relaxed/simple;
	bh=CcCc5uicR+vsgmQJUW7EMBRPLNFUY6LBQPzlah2HaEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mniE2knngGlxDUGQJkaQEgpB6VH8heS4bNIoTfAm8AmnjJsSE1iOEGPjN0JIanS2ymN501+nsTNZ5cjKVSRdZP/BIszMDITOvxsdQ+dpC34ko8RQ3pmCcS8Dkm6+3hPxQIY7/7zZV22a3YZKv46mFY0HukGO7j4FTEkvJCutQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0HDr07i; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0HDr07i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775249978; x=1806785978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CcCc5uicR+vsgmQJUW7EMBRPLNFUY6LBQPzlah2HaEA=;
  b=h0HDr07iviWhlm5Fl4ssu9p7rOX/BIzmo/wFZf+pO9WyD4fOdM37kfYN
   smHvxynQHPjMXRCaNY5Zupah9tUtQC7FAT/zuHUctjy8qU2z3b25oLxQ7
   kSo9EecMWq5QltNvKCpn5yAsr+DXfx9lrLFPa81oXkJQiP5xVemMFQ641
   TQMjgJD67iyk1DQc6QqA4sz6jecVbk3fwKIiiQuyyzMnkTp0wvCv47Uce
   ymscNBESkaOnkEpWVpfR9dPF/9UHhOVPKev7ZPXj9F5ShMW7N64yRkExL
   +nVdJQwPjWAhJ40coVBZvGxak+jRwKlRXu6u0K4Ri5ZKEZjIJ+I2YS0TP
   g==;
X-CSE-ConnectionGUID: 53Ssf/LGT9SqSv55rivw7A==
X-CSE-MsgGUID: SpBeQbm0QZeuHgbVob50ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76281474"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76281474"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 13:59:34 -0700
X-CSE-ConnectionGUID: VL7BKUqLSt6QCypm8peHSQ==
X-CSE-MsgGUID: YH6HzLqARFiNaEVxx9A0SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="265280486"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2026 13:59:34 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alejandro.lucero-palau@amd.com
Subject: [RFC PATCH 4/4] cxl/region: Introduce cxl_memdev_attach_region
Date: Fri,  3 Apr 2026 14:00:50 -0700
Message-ID: <20260403210050.1058650-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403210050.1058650-1-dan.j.williams@intel.com>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To date, platform firmware maps accelerator memory and accelerator drivers
simply want an address range that they can map themselves. This typically
results in a single region being auto-assembled upon registration of a
memory device.  Use the @attach mechanism of devm_cxl_add_memdev()
parameter to retrieve that region while also adhering to CXL subsystem
locking and lifetime rules. As part of adhering to current object lifetime
rules, if the region or the CXL port topology is invalidated, the CXL core
arranges for the accelertor driver to be detached as well.

The locking and lifetime rules were validated by this local change to
cxl_mock_mem. This tests all the lock acquisition and cleanup at
modprobe -r cxl_test time. More work needed to also test the full positive
case.

    struct cxl_attach_region
            attach = { .attach = {
                               .probe = cxl_memdev_attach_region,
                       } };
    cxlmd = devm_cxl_add_memdev(cxlds, &attach.attach);

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/cxl/cxl.h         |  16 +++++
 drivers/cxl/core/region.c | 125 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 10a9b8fa2f6b..1698d15ec1ca 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -153,6 +153,22 @@ struct cxl_memdev_attach {
 	int (*probe)(struct cxl_memdev *cxlmd);
 };
 
+/**
+ * struct cxl_attach_region - coordinate mapping a region at memdev registration
+ * @attach: common core attachment descriptor
+ * @region: physical address range of the region
+ *
+ * For the common simple case of a CXL device with private (non-general purpose
+ * / "accelerator") memory, enumerate firmware instantiated region, or
+ * instantiate a region for the device's capacity. Destroy the region on detach.
+ */
+struct cxl_attach_region {
+	struct cxl_memdev_attach attach;
+	struct range region;
+};
+
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
+
 /**
  * struct cxl_dev_state - The driver device state
  *
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 11bc0b88b05f..090f52392b20 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1123,6 +1123,19 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 static void cxl_region_setup_flags(struct cxl_region *cxlr,
 				   struct cxl_decoder *cxld)
 {
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		/*
+		 * When a region's memdevs specify an @attach method the attach
+		 * provider is responsible for dispositioning the region for
+		 * both probe and userspace management
+		 */
+		if (cxlmd->attach)
+			set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
+	}
+
 	if (cxld->flags & CXL_DECODER_F_LOCK) {
 		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
 		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
@@ -4226,6 +4239,115 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
 	return 0;
 }
 
+static int first_mapped_decoder(struct device *dev, const void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (cxled->cxld.region)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * As this is running in endpoint port remove context it does not race cxl_root
+ * destruction since port topologies are always removed depth first.
+ */
+static void cxl_endpoint_region_autoremove(void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
+/*
+ * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
+ * simple case of single mapped decoder per memdev.
+ */
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
+{
+	struct cxl_attach_region *attach =
+		container_of(cxlmd->attach, typeof(*attach), attach);
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *cxlr;
+	int rc;
+
+	/* hold endpoint lock to setup autoremove of the region */
+	guard(device)(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		return -ENXIO;
+	guard(rwsem_read)(&cxl_rwsem.region);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	/*
+	 * TODO auto-instantiate a region, for now assume this will find an
+	 * auto-region
+	 */
+	struct device *dev __free(put_device) =
+		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
+
+	if (!dev) {
+		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
+			dev_name(&cxlmd->dev));
+		return -ENXIO;
+	}
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxlr = cxled->cxld.region;
+
+	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
+		dev_dbg(cxlmd->cxlds->dev,
+			"region %s not committed for memdev %s\n",
+			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
+		return -ENXIO;
+	}
+
+	if (cxlr->params.nr_targets > 1) {
+		dev_dbg(cxlmd->cxlds->dev,
+			"Only attach to local non-interleaved region\n");
+		return -ENXIO;
+	}
+
+	/* Only teardown regions that pass validation, ignore the rest */
+	rc = devm_add_action_or_reset(&endpoint->dev,
+				      cxl_endpoint_region_autoremove, cxlr);
+	if (rc)
+		return rc;
+
+	attach->region = (struct range) {
+		.start = cxlr->params.res->start,
+		.end = cxlr->params.res->end,
+	};
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_attach_region, "CXL");
+
+/*
+ * The presence of an attach method indicates that the region is designated for
+ * a purpose outside of CXL core memory expansion defaults.
+ */
+static bool cxl_region_has_memdev_attach(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		if (cxlmd->attach)
+			return true;
+	}
+
+	return false;
+}
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -4257,6 +4379,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (cxl_region_has_memdev_attach(cxlr))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		rc = devm_cxl_region_edac_register(cxlr);
-- 
2.53.0

