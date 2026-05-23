Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E338886F
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529450; cv=none; b=GYffyEaT4zsqvteayDf5+Lbq9YGKs8xn29mlBvbAEuEbGRWs/TATLMT1f3oq7Sq2ned3QPzOwmJ7s+cbofZQgSqwOe1zC8IDreQM9Mr4vu1IqbG2giA0mVMKTYWE6L2TX4LHGaWeCa4rVeNh08tw2az311ucH4Hx0sw9mrVuvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529450; c=relaxed/simple;
	bh=+Fs7s5G0qsALoEg5+n2VxXmV7ZgzgjcZhlIbWf49dqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eT9KbhMYc5tPSqXEfaIEaAgm9G5PvAp+k2RSyvEWVqMKyf0Vg5C4HfjYcvtw2BBmkV74FtfnMQBBV8DPIRJb9iYnYGCfmCH9qexJVbsy+TBBtOprPhPfNUgS1hg2rGlLYA6J+W8wEZ0FnPiELfx5TTQA6hEyhI9epsw3wvddDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCTztp/C; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCTztp/C"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-135e88b8e55so3425216c88.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529448; x=1780134248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmIYAuyAsD2n/pMyj9L4/1IUWr8KglMpbMYEoiJlFTY=;
        b=MCTztp/C+i8seJ55Nim5KVKg+NeUCNld+NDuTn7TPmVoW7efCtgotIqc1KaSbAUGeh
         wsjG6PrMkxVYwmm5uYbrO+5cN2PXZ/JF3td0F9tXnIMLIbGCwwqR2rTAPRmMlhIjlEVl
         /TaWA5SLdL9t2rAzvdpOroSn7la9jbA4MBw9JGu0rDdupzjsdP5G2C5t3uh3iTkNRFIi
         IQHJAylgW2rDp9aLU49J5P0DL4ozvgfKSZFISfkDKXejuANAX2Mw93o1xAiyzB2tZsZg
         7CuJ8EQKM78zl3/D82wsxS7DphQaFLBmTFZN1tELidWLz+k6BaFWk8k8ZOowWcjEDofI
         4g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529448; x=1780134248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmIYAuyAsD2n/pMyj9L4/1IUWr8KglMpbMYEoiJlFTY=;
        b=MoakG4fH6MhvwiA2BonmbieSqdjNu5qcnsXwXP1kldGjvRz3T0g34NE+XSOo301ns5
         iFJcWzqFJexTI/76KAsxhR6gwpuQCkOUe33Xkxur87pCYFYDb2Aahgly6cjhW7MBhQ+/
         /CkCud5s7o0oCkLvw/XkhSX5WRiQtaPdzOF2CeGAaowh3eM89MksWEBXHuf1Kd9lmhIt
         jkJ4yRQKXjadqDvum+J0RXrDjLqgp8QCt9cgnGgwYjk0oR3SyM8hrosI+oAdGjg25Kij
         +gPq8anSd0hLiBEx75YWxMAQoCK0R/ppXezq6J0DjjsrxBwb+oNT3aGcsTOdC8fgpP6X
         jnRQ==
X-Gm-Message-State: AOJu0YwjTkIVululy9rK4b+YsjYN5xNOdiRb79CnXQ/pZn1cp8byE9BN
	nH+AKJdz4pXJBUB5kANWaI3Eu+PsIiIur+fz1EjkhWyPiHjUKAvfgP46A7Tz7w==
X-Gm-Gg: Acq92OETi+d3Zeo+GxDGeTEdh8Br5q9RXY2f6axaM17ASelohRatiKbcPWesQG/Blu1
	y1C+MMTtvqesq+SfJ8+Nxv7XYt9rIRo/hETtL2z4TGh26Drms9c2v3VOxDkmxOK4jKQbRAvtmUg
	GPbJhBA6K8QxeIauILCWRAdMj6stzkfrQ3F+F1oIO1OrK5/RHoEsGMFwv3zmtZoLyj3J6nYA+em
	vBfw9vnrQLMfMjXUAqajlLbX70VaakxGdvcREX+4zgKtphQx+QpBxz7NGv/exLgJua+gDjCmHsv
	0yxzqPbzVYwwsc2/Mh8CaNVP5ueO7xhY1rH+wsKNVE1CKKqR+SgSH0QCXbB7ADQkSWhxnTJiwBR
	rq8gYLqJwY2ofR3PKy2fpzDofkYcN3MEiCbaf1ub9UTUvp9eSX8G7GREcdTKGms1tkMHsN4He+l
	Qou1v5DeJmGxl4tkouaWFjkNtpZqH/2MqHC5fu0QISX6GHv+m+zKE+K3r02oJ1/W//m5VASUrsR
	9S3Yn4=
X-Received: by 2002:a05:7022:128a:b0:12d:de3e:86a8 with SMTP id a92af1059eb24-1365fc774a3mr2758746c88.38.1779529448111;
        Sat, 23 May 2026 02:44:08 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:44:07 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v10 16/31] cxl/extent: Validate DC extent partition
Date: Sat, 23 May 2026 02:43:10 -0700
Message-ID: <def526ee51b647e9256c7e777c6b7bd5cd647f89.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend cxl_validate_extent() — the per-extent check of the add pipeline
to check partition membership.

Resolves an extent's DPA to its containing DC partition. Then based on
if the partition is shareable:

  - Shareable: tag must be non-null and shared_extn_seq must be non-zero
    — multiple hosts reading the same allocation rely on the device-
    stamped 1..n sequence to assemble extents in agreed order.
  - Non-sharable: shared_extn_seq must be zero — sequencing is
    meaningless when only one host consumes the allocation; tag is
    optional (null UUID permitted).

Any cross-mix is a device firmware bug; reject the extent.

Based on patches by John Groves.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: John Groves <John@Groves.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
[anisa: split out as a separate validation step]
---
 drivers/cxl/core/core.h   |  4 ++
 drivers/cxl/core/extent.c | 78 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1bae80dbf991..30b6b05b155b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -179,6 +179,10 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 void memdev_release_extent(struct cxl_memdev_state *mds, struct range *range);
+const struct cxl_dpa_partition *
+cxl_extent_dc_partition(struct cxl_memdev_state *mds,
+			struct cxl_extent *extent,
+			struct range *ext_range);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 94128d06f4ed..b01507022cff 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -63,11 +63,55 @@ alloc_tag_group(struct cxl_dax_region *cxlr_dax, uuid_t *uuid)
 	return no_free_ptr(group);
 }
 
+/*
+ * Find the DC (Dynamic Capacity) partition that fully contains @ext_range,
+ * or NULL if the extent falls outside every DC partition on this memdev.
+ * The returned pointer is owned by mds->cxlds.part[] and lives for the
+ * lifetime of the memdev.
+ */
+const struct cxl_dpa_partition *
+cxl_extent_dc_partition(struct cxl_memdev_state *mds,
+			struct cxl_extent *extent,
+			struct range *ext_range)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = mds->cxlds.dev;
+
+	for (int i = 0; i < cxlds->nr_partitions; i++) {
+		struct cxl_dpa_partition *part = &cxlds->part[i];
+		struct range partition_range = {
+			.start = part->res.start,
+			.end = part->res.end,
+		};
+
+		if (part->mode != CXL_PARTMODE_DYNAMIC_RAM_A)
+			continue;
+
+		if (range_contains(&partition_range, ext_range)) {
+			dev_dbg(dev, "DC extent DPA %pra (DCR:%pra)(%pU)\n",
+				ext_range, &partition_range, extent->uuid);
+			return part;
+		}
+	}
+
+	dev_err_ratelimited(dev,
+			    "DC extent DPA %pra (%pU) is not in a valid DC partition\n",
+			    ext_range, extent->uuid);
+	return NULL;
+}
+
 /*
  * Stage 1 of the add pipeline: pure, no allocation.  Resolve the extent
- * to its region/endpoint decoder and ext_range, and verify the range
- * fits in the resolved endpoint decoder's DPA resource.  Further
- * per-extent invariants layer into this function in subsequent commits.
+ * to its region/endpoint decoder and ext_range, and enforce every
+ * per-extent invariant the device must satisfy:
+ *
+ *   - DPA falls inside a Dynamic Capacity partition (cxl_extent_dc_partition).
+ *   - CDAT-sharability rules:
+ *       sharable:     tag must be non-null AND shared_extn_seq != 0
+ *       non-sharable: shared_extn_seq must be 0  (tag is optional)
+ *     Any cross-mixing is a device firmware bug.
+ *   - DPA resolves to an endpoint decoder attached to a region.
+ *   - The extent's range is fully contained in that ED's DPA resource.
  *
  * Caller must hold cxl_rwsem.region for read (cxl_dpa_to_region()).
  * On success, @out_cxled / @out_cxlr_dax / @out_ext_range carry the
@@ -81,6 +125,10 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
 {
 	u64 start_dpa = le64_to_cpu(extent->start_dpa);
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	struct device *dev = mds->cxlds.dev;
+	uuid_t *uuid = (uuid_t *)extent->uuid;
+	u16 seq = le16_to_cpu(extent->shared_extn_seq);
+	const struct cxl_dpa_partition *part;
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_region *cxlr;
 	struct range ext_range = (struct range) {
@@ -89,6 +137,30 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
 	};
 	struct range ed_range;
 
+	part = cxl_extent_dc_partition(mds, extent, &ext_range);
+	if (!part)
+		return -ENXIO;
+
+	if (part->perf.shareable) {
+		if (uuid_is_null(uuid)) {
+			dev_err_ratelimited(dev,
+				"DC extent DPA %pra: sharable-partition extent has null tag (firmware bug)\n",
+				&ext_range);
+			return -ENXIO;
+		}
+		if (seq == 0) {
+			dev_err_ratelimited(dev,
+				"DC extent DPA %pra (%pU): sharable-partition extent missing shared_extn_seq (firmware bug)\n",
+				&ext_range, uuid);
+			return -ENXIO;
+		}
+	} else if (seq != 0) {
+		dev_err_ratelimited(dev,
+			"DC extent DPA %pra (%pU): non-sharable partition but shared_extn_seq=%u (firmware bug)\n",
+			&ext_range, uuid, seq);
+		return -ENXIO;
+	}
+
 	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
 	if (!cxlr)
 		return -ENXIO;
-- 
2.43.0

