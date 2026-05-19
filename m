Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396003E2AB1
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224531; cv=none; b=E8OYjwlMUSDbdYmNH9wKo03ag1PYfBvEJkMubJkRcj+ToE4aWlFLulVG5SWnsaIUw4G1qWyLThxMg+uEhpBAde2i75yMhGO1C+zuY3P3t2ay9uiJijBtLqhVtoGaLuymskjGQtDXOn9+TpX2BOvOG1rDP6PDHt3Q7M78ozZQMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224531; c=relaxed/simple;
	bh=XVgVa1b+kM7WXUFVrZEpPtjRrGURLmOIPZnsDpk6NZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNCBx5l/tFl/EewoNYMchMQxYJ2hcMRzOOfaykLWmwEdjOrIRaHv7oonluxau2h6AIW8aelC8p9mHVyh8vx1SSCc0Dx7iujuQofUWPFQCZdczBtoIzLLIj3U5oDuRp/XaHB9vorF6dAFjZzql2UJs5T++PWt39VA5tW2mfpBVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBQ3c9s2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBQ3c9s2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ABA1F00894;
	Tue, 19 May 2026 21:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224529;
	bh=aU9hrRrAgnmq784fdRqn27JRCVdCyzx16D460zy5SAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lBQ3c9s2PogfamtNldMjA0gfKuquCm9mNT+N9rMhonO2NG3y5UaLgFX3xWjbfi5QD
	 bsMMP6JVaIkpphMpFIpXv/hxxGMzzD8CPELzp3/W/bjhQhZZuTOf3DXFJOUmyTxkm8
	 pLIVuECWDAzgAA3VN5c8Ha5AAvTEtDX+173Ho3/jQgDdKUMZHge7AekN5gxTocQAUU
	 vg8eLC4m3Kye9WJxgLvEXRfjaHNbaVpiPIiygfWlheFeAb+8G0isuZnapCFZZm6uIc
	 wOf9bBpj88o2WKTONMoa1ZZ6wh0WTgEtIy9fCeVbyIiCoTS29COCTVW8U7MiNnj6bx
	 rORRRl6kzlP6A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DB037F40076;
	Tue, 19 May 2026 17:02:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 19 May 2026 17:02:08 -0400
X-ME-Sender: <xms:0M8Mat-lT_WEnVNtVKp_XrWC5fdB81hR0C2Z3POKtXpuApkMo1Oj8w>
    <xme:0M8MalY79URIjSfHYkdwruanbzB4ndrxK79nyScOV0eDERS0GW_s0I7WoUDgaeXvM
    bBzy3jGrJ1T90uQ557izXQ1je40Is1HmtW0EP8jCKTfPp1NtMrYGtW3>
X-ME-Received: <xmr:0M8Mak3ixD_tohgPAYbKQO4BQYmxKrppDhWPBy-sl98aoRVNQzdTMFtY13ryMP-f9OIyBvYIcadkbqcxmEYDeWLAFMAFbtsd-dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghnucghihhllhhirghmshcuoegujhgsfieskhgvrhhnvghl
    rdhorhhgqeenucggtffrrghtthgvrhhnpeeuheffhfelleelgedutdfhleefjeejvedtke
    fgjeefgfettdeljeefvefhueeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqudejjedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdr
    ohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtg
    hpthhtoheprghlvghjrghnughrohdrlhhutggvrhhoqdhprghlrghusegrmhgurdgtohhm
    pdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghluh
    gtvghrohhpsegrmhgurdgtohhmpdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:0M8Maob4DlO8cKKNPe-NnqrZwbUjMgGmYBLnkmH4zZIuq7KDC83z9A>
    <xmx:0M8MakIEpob7pSIWLrDFKcHjbrmCrIb3n5izK920tVcIinHRguXCHQ>
    <xmx:0M8MavE6izSC9hDugnHLlVloPD4E4mp6MCN_lOC_hBUwtBh0db2uWg>
    <xmx:0M8MajsVcdhd_dP0dKXQxPRPq1GxE2ue2jQ9P_HOiLBlo3AG_MgXXw>
    <xmx:0M8MamsQa3wPwHZEvOfSXLK08_mE_b6sp-dn3oQKDMAP5JwEYKin5jD2>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 17:02:08 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com,
	alejandro.lucero-palau@amd.com,
	jic23@kernel.org,
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH 5/5] cxl/region: Introduce devm_cxl_probe_mem()
Date: Tue, 19 May 2026 14:01:58 -0700
Message-ID: <20260519210158.1499795-6-djbw@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519210158.1499795-1-djbw@kernel.org>
References: <20260519210158.1499795-1-djbw@kernel.org>
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

The locking and lifetime rules were validated with Dave's work-in-progress
cxl-type-2 support for cxl_test.

devm_cxl_add_classdev() supports the general memory expansion flow where
region assembly is optional, dynamic, and user controlled.

Cc: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/cxl/cxlmem.h         |  27 ++++++--
 include/cxl/cxl.h            |   3 +
 drivers/cxl/core/region.c    | 124 +++++++++++++++++++++++++++++++++++
 drivers/cxl/mem.c            |  50 +++++++++++---
 drivers/cxl/pci.c            |   2 +-
 tools/testing/cxl/test/mem.c |   2 +-
 6 files changed, 191 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 776c50d1db51..d3bdd00f94b3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,10 +34,6 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-struct cxl_memdev_attach {
-	int (*probe)(struct cxl_memdev *cxlmd);
-};
-
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -101,10 +97,29 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
+struct cxl_memdev_attach {
+	int (*probe)(struct cxl_memdev *cxlmd);
+};
+
+/**
+ * struct cxl_attach_region - coordinate mapping a region at memdev registration
+ * @attach: common core attachment descriptor
+ * @hpa_range: physical address range of the region
+ *
+ * For the common simple case of a CXL device with private (non-general purpose
+ * / "accelerator") memory, enumerate firmware instantiated region, or
+ * instantiate a region for the device's capacity. Destroy the region on detach.
+ */
+struct cxl_attach_region {
+	struct cxl_memdev_attach attach;
+	struct range hpa_range;
+};
+
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
+
+struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
 struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 					 const struct cxl_memdev_attach *attach);
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_attach *attach);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index fa7269154620..016c74fb747c 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -223,4 +223,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
+				      struct range *range);
 #endif /* __CXL_CXL_H__ */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index faf9785c0509..ce99f0650764 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1148,6 +1148,19 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
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
@@ -2560,6 +2573,17 @@ static void unregister_region(struct cxl_region *cxlr)
 	put_device(&cxlr->dev);
 }
 
+static void endpoint_unregister_region(void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+
+	guard(mutex)(&cxlrd->regions_lock);
+	if (xa_load(&cxlrd->regions, cxlr->id))
+		unregister_region(cxlr);
+	put_device(&cxlr->dev);
+}
+
 static struct lock_class_key cxl_region_key;
 
 static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int id)
@@ -4057,6 +4081,103 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
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
+	get_device(&cxlr->dev);
+	rc = devm_add_action_or_reset(&endpoint->dev,
+				      endpoint_unregister_region, cxlr);
+	if (rc)
+		return rc;
+
+	attach->hpa_range = (struct range) {
+		.start = cxlr->params.res->start,
+		.end = cxlr->params.res->end,
+	};
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
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
@@ -4088,6 +4209,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (cxl_region_has_memdev_attach(cxlr))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		rc = devm_cxl_region_edac_register(cxlr);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ff858318091f..67d31482f06b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -183,27 +183,59 @@ static int cxl_mem_probe(struct device *dev)
 }
 
 /**
- * devm_cxl_add_memdev - Add a CXL memory device
+ * devm_cxl_add_classdev - Add a CXL memory class-code device
  * @cxlds: CXL device state to associate with the memdev
- * @attach: Caller depends on CXL topology attachment
  *
  * Upon return the device will have had a chance to attach to the
  * cxl_mem driver, but may fail to attach if the CXL topology is not ready
  * (hardware CXL link down, or software platform CXL root not attached).
  *
- * When @attach is NULL it indicates the caller wants the memdev to remain
- * registered even if it does not immediately attach to the CXL hierarchy. When
- * @attach is provided a cxl_mem_probe() failure leads to failure of this routine.
+ * The parent of the resulting device and the devm context for allocations is
+ * @cxlds->dev.
+ */
+struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds)
+{
+	return __devm_cxl_add_memdev(cxlds, NULL);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
+
+/**
+ * devm_cxl_probe_mem - Add a CXL memory device and probe its region
+ * @cxlds: CXL device state to associate with the memdev
+ * @hpa_range: CXL.mem physical address range result
+ *
+ * Upon return the device will have had a chance to attach to the
+ * cxl_mem driver, but may fail to attach if the CXL topology is not ready
+ * (hardware CXL link down, or software platform CXL root not attached).
+ *
+ * Failure to probe the memdev and/or setup a region for the memdev
+ * results in this function failing.
  *
  * The parent of the resulting device and the devm context for allocations is
  * @cxlds->dev.
  */
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
-				       const struct cxl_memdev_attach *attach)
+struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
+				      struct range *hpa_range)
 {
-	return __devm_cxl_add_memdev(cxlds, attach);
+	struct cxl_attach_region *attach =
+		devm_kmalloc(cxlds->dev, sizeof(*attach), GFP_KERNEL);
+	struct cxl_memdev *cxlmd;
+
+	if (!attach)
+		return ERR_PTR(-ENOMEM);
+
+	*attach = (struct cxl_attach_region) {
+		.attach = {
+			   .probe = cxl_memdev_attach_region,
+		},
+		.hpa_range = { 0, -1 },
+	};
+
+	cxlmd = __devm_cxl_add_memdev(cxlds, &attach->attach);
+	*hpa_range = attach->hpa_range;
+	return cxlmd;
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+EXPORT_SYMBOL_NS_GPL(devm_cxl_probe_mem, "CXL");
 
 static ssize_t trigger_poison_list_store(struct device *dev,
 					 struct device_attribute *attr,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bace662dc988..267c679b0b3c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -878,7 +878,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
 
-	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
+	cxlmd = devm_cxl_add_classdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 271c7ad8cc32..095ca544ac02 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1769,7 +1769,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 
 	cxl_mock_add_event_logs(&mdata->mes);
 
-	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
+	cxlmd = devm_cxl_add_classdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-- 
2.53.0

