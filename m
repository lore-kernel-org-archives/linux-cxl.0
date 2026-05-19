Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C73E2AD5
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224526; cv=none; b=TE7nyqxDv0z8mGTt4G0efbT+qdCIvoNHbRbo/WtakVYwAogyCpIE6AGuHId78ilY3Ghw/DuACyXm/AU+U6KcYLn3PL/MUs0+CJY4fCBFjxT875aEnMIQxp27DLniZKjUd3Emfw6vAuJ3S05MdA972bjVZ4RrmjIw5VDzdYyKEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224526; c=relaxed/simple;
	bh=hypfw+z4PoeER4EZXCXJr3ZoxMPzXQUO+mfOvpFaTCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKkzfvJURpWbRXfJIIfGjwpN+n2qu8Mxl5ns4lYDTUYQjYk4Pp/sLhEfoMeWlfS9JMkZD6+xL7a6lErAdJocF7q65v7vATl/fqsMao8Zwavv96iEQzk1LLDAfjHAs9MKa36nGxFlD4D+L3czu1jVMNGwktS88PI0MloFHqEAMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhWZ5v+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhWZ5v+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110491F00893;
	Tue, 19 May 2026 21:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224525;
	bh=ZLKpW6kJIJhj0IMHmhga4nl3DTsciA6Wocbjs1IO5Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AhWZ5v+bL0k413FpIjFsguLNzY78MIriO7Ju1VjlK+ng+yxc4Sryw8v4AvRBr9ZMU
	 38Xg0BfuDyc59hU4XIdswhroh3tM1N/Xc3UN5Z2FleqBnTJjTFeQI1+w9uFr6nyn99
	 YnXuDndMxyE2Rc4isJW8OpuRHVTvt7+OLHE0qg6c2h+NtasZlc74LBcE+YIv8xWP/S
	 jhzNXDu9VSd8GvkbnJwrL0PIbGKXd6weEjTXElilg6emURQsOocUjx2Wc8n6rEuiq0
	 Ae8Ig4RAUE9t9JAJY7gH/52lJV7e1oYntyIfo6oupLfsp1JYkgyY1hb+66swFAeHQU
	 /a2v8s91mfc1A==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 71F76F40075;
	Tue, 19 May 2026 17:02:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 17:02:04 -0400
X-ME-Sender: <xms:zM8Maie7JsbsfMfsjZE9sXL_FJ9O1CpSdelJn1PY8cRiXmQlVjPdLw>
    <xme:zM8Mav76B3w4s-9XzjqL0Pe8huTqB0yBMv5s8BaAbY_qM05IuVwCLuyLau7Tbsv8t
    8lA00Q-5Qm9ojcRCzXtNxeq4d-pTzIGdVH5yoO5Paps0F0TBCQ-rRA>
X-ME-Received: <xmr:zM8MatVs0ekWIQ4xxq2vwrpmhQxdweuep_KiXlLBx2juWkbFahHr7UTpGkPx47wP0_-Y1ByW7aaXJUVEyNO2U7w2z2qHb_X5YRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghnucghihhllhhirghmshcuoegujhgsfieskhgvrhhnvghl
    rdhorhhgqeenucggtffrrghtthgvrhhnpedvgfekheegffeugfduudevgeevjeffffeivd
    efuddtgeevveeileekudeuffekffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgt
    gihlugdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedv
    fedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghl
    vghjrghnughrohdrlhhutggvrhhoqdhprghlrghusegrmhgurdgtohhmpdhrtghpthhtoh
    epjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihgrmhesshhunhhgqdif
    ohhordhkihhmpdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zM8Mam4kPKQm-2xXoGobi0DEYBWZCufwEM1CY1AxDXRu9kwWk5xZoQ>
    <xmx:zM8MagomNFZYOAAWbydlmd9ALFEeFOoBwiFGWq9GW2Jde68bvNVvzA>
    <xmx:zM8MahlNydpFJ9EmNuzf0CQXO65uxyuRXNBlHU6ws3TRqmysYM9GQQ>
    <xmx:zM8MakPADtIcotsnJYGpuojKJvbY0xtKilROmo_1DqmpwUeX9yLrbA>
    <xmx:zM8MatMSlgdZbdY0WqMzBEvZdGNqt_eyJ-tZ9k-jQks9m5caSeNj2bYe>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 17:02:03 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com,
	alejandro.lucero-palau@amd.com,
	jic23@kernel.org,
	Sungwoo Kim <iam@sung-woo.kim>
Subject: [PATCH 2/5] cxl/region: Resolve region deletion races
Date: Tue, 19 May 2026 14:01:55 -0700
Message-ID: <20260519210158.1499795-3-djbw@kernel.org>
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

Sungwoo noticed that the sysfs trigger to delete a region may try to delete
a region multiple times. It also has no exclusion relative to the kernel
releasing the region via CXL root device teardown.

Instead of installing new cxl root devres actions per region, use the
existing root decoder unregistration event to remove all remaining regions.
An xarray of regions replaces a devres list of regions.

This handles 3 separate issues with the old approach:

1/ sysfs users racing to delete the same region: no longer possible now
   that the regions_lock is held over the lookup and deletion.

2/ multiple actions triggering deletion of the same region: solved by
   erasing regions while holding @regions_lock, and only proceeding on
   successful erasure.

3/ userspace racing devres_release_all() to trigger the devres not found
   warning: solved by sysfs unregistration not requiring a release action

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Reported-by: Sungwoo Kim <iam@sung-woo.kim>
Closes: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/cxl/core/core.h   |  2 ++
 drivers/cxl/cxl.h         |  4 +++
 drivers/cxl/core/port.c   |  5 ++++
 drivers/cxl/core/region.c | 60 +++++++++++++++++++++------------------
 4 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 82ca3a476708..07555ae63859 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -52,6 +52,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
+void kill_regions(struct cxl_root_decoder *cxlrd);
 
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
@@ -81,6 +82,7 @@ static inline int cxl_region_init(void)
 static inline void cxl_region_exit(void)
 {
 }
+static inline void kill_regions(struct cxl_root_decoder *cxlrd) { };
 #define CXL_REGION_ATTR(x) NULL
 #define CXL_REGION_TYPE(x) NULL
 #define SET_CXL_REGION_ATTR(x)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3900a0778571..f43abd1903ce 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -360,6 +360,8 @@ struct cxl_rd_ops {
  * @region_id: region id for next region provisioning event
  * @platform_data: platform specific configuration data
  * @regions_lock: sync region discovery, construction, and deletion
+ * @regions: regions to remove at root decoder destruct time
+ * @dead: root decoder dead to region creation
  * @qos_class: QoS performance class cookie
  * @ops: CXL root decoder operations
  * @cxlsd: base cxl switch decoder
@@ -370,6 +372,8 @@ struct cxl_root_decoder {
 	atomic_t region_id;
 	void *platform_data;
 	struct mutex regions_lock;
+	struct xarray regions;
+	bool dead;
 	int qos_class;
 	struct cxl_rd_ops ops;
 	struct cxl_switch_decoder cxlsd;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6e7a70d51cfe..1215ee4f4035 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -458,6 +458,8 @@ static void cxl_root_decoder_release(struct device *dev)
 
 	if (atomic_read(&cxlrd->region_id) >= 0)
 		memregion_free(atomic_read(&cxlrd->region_id));
+	mutex_destroy(&cxlrd->regions_lock);
+	xa_destroy(&cxlrd->regions);
 	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
 	kfree(cxlrd);
 }
@@ -2017,6 +2019,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	}
 
 	mutex_init(&cxlrd->regions_lock);
+	xa_init(&cxlrd->regions);
 
 	cxld = &cxlsd->cxld;
 	cxld->dev.type = &cxl_decoder_root_type;
@@ -2192,6 +2195,8 @@ static void cxld_unregister(void *dev)
 	if (is_endpoint_decoder(dev))
 		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
 				   DETACH_INVALIDATE);
+	if (is_root_decoder(dev))
+		kill_regions(to_cxl_root_decoder(dev));
 
 	device_unregister(dev);
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b5601e89e302..faf9785c0509 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2537,12 +2537,13 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 	return container_of(dev, struct cxl_region, dev);
 }
 
-static void unregister_region(void *_cxlr)
+static void unregister_region(struct cxl_region *cxlr)
 {
-	struct cxl_region *cxlr = _cxlr;
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
+	xa_erase(&cxlrd->regions, cxlr->id);
 	device_del(&cxlr->dev);
 
 	/*
@@ -2673,6 +2674,19 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
 	return NOTIFY_STOP;
 }
 
+/* unwind all remaining regions */
+void kill_regions(struct cxl_root_decoder *cxlrd)
+{
+	unsigned long index;
+	struct cxl_region *cxlr;
+
+	guard(mutex)(&cxlrd->regions_lock);
+	/* no more region creation */
+	cxlrd->dead = true;
+	xa_for_each(&cxlrd->regions, index, cxlr)
+		unregister_region(cxlr);
+}
+
 /**
  * devm_cxl_add_region - Adds a region to a decoder
  * @cxlrd: root decoder
@@ -2711,14 +2725,15 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
-	if (rc)
+	rc = xa_insert(&cxlrd->regions, cxlr->id, cxlr, GFP_KERNEL);
+	if (rc) {
+		unregister_region(cxlr);
 		return ERR_PTR(rc);
+	}
 
 	dev_dbg(port->uport_dev, "%s: created %s\n",
 		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
 	return cxlr;
-
 err:
 	put_device(dev);
 	return ERR_PTR(rc);
@@ -2747,6 +2762,9 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 {
 	int rc;
 
+	if (cxlrd->dead)
+		return ERR_PTR(-ENXIO);
+
 	switch (mode) {
 	case CXL_PARTMODE_RAM:
 	case CXL_PARTMODE_PMEM:
@@ -2822,38 +2840,27 @@ static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(region);
 
-static struct cxl_region *
-cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
-{
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct device *region_dev;
-
-	region_dev = device_find_child_by_name(&cxld->dev, name);
-	if (!region_dev)
-		return ERR_PTR(-ENODEV);
-
-	return to_cxl_region(region_dev);
-}
-
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
-	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_region *cxlr;
-	int rc;
+	int rc, id;
 
 	ACQUIRE(mutex_intr, regions_lock)(&cxlrd->regions_lock);
 	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
 		return rc;
 
-	cxlr = cxl_find_region_by_name(cxlrd, buf);
-	if (IS_ERR(cxlr))
-		return PTR_ERR(cxlr);
+	rc = sscanf(buf, "region%d\n", &id);
+	if (rc != 1)
+		return -EINVAL;
 
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	put_device(&cxlr->dev);
+	cxlr = xa_load(&cxlrd->regions, id);
+	if (!cxlr || !sysfs_streq(buf, dev_name(&cxlr->dev)))
+		return -ENODEV;
+
+	unregister_region(cxlr);
 
 	return len;
 }
@@ -3718,7 +3725,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 {
 	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
@@ -3739,7 +3745,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = __construct_region(cxlr, ctx);
 	if (rc) {
-		devm_release_action(port->uport_dev, unregister_region, cxlr);
+		unregister_region(cxlr);
 		return ERR_PTR(rc);
 	}
 
-- 
2.53.0

