Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A330F95F
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335738; cv=none; b=Ih9XKI/q2BqXBEhNFBO++5T9ItkAgdNLd5/icNDUbZM+lCxI1ZCmuDSeqP8XT6t0fOKl0NEEx31yvrmFpjXRiSOyMrgbW8uUfzPZMTn5+F8suWRl4zVCDgNFsXkx6HR9TqXQb97IHEUqzVVWj0kpSTNpLMcVZwtXX3CpwjqxJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335738; c=relaxed/simple;
	bh=cbMNhBysHC2rcu9lAwGVOGhgE/1BcZnqUBX1soh2Uyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBI3HbYA5qBMSGpO8AiZbWm1TjzPymUDp1L6UHzH3FqYtKX4gQ7ebLDkExw2+O/SupYQW8Fq5+GC0DOGDl57EV71JzMdHJUqGSxUACsUlvceTqybdfi0bxspA3YXP3nxzXJf3k8w7VRwCNb+UU/+7XK5Ac2mcuG1eG/hsH+QpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=P7crusqa; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="P7crusqa"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b29ff9d18cso853765585a.3
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 12:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768335735; x=1768940535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQnVCpFilFyHQzy7odIbZb7IonUY8xt4v2GPGW+Oz54=;
        b=P7crusqaJ6/YRx+ltmIL2o2KDEP9+/F1IY7fpfgM5Ae8T8DZZgiWQRwdyYmXVt2WjX
         EEu+As0kI70CS4P0vtNSdCah5fJEZPtavx+gIY72fwqRcx1v2/J3bf9nnUJ2/GeXAaaA
         DWj/Y1a2WzsAJlFQHWYc0mb6jycNt2qt85uvncI0FatWTjxohBa+oI3j6ijQDVNjSjEu
         PQsYEy8SZm4WG0M9n8MxftYHFjwkuwWKVmN8bOHVnPg66O7AiZn6sxL0GvNzXjMw7ZrR
         fLcGGL0W1MGeHCGVt+sS2d8hqCiE9opT113dbl0ZViTHgJ9AAAK7Z7VcwRfewFvsIOec
         CbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768335735; x=1768940535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQnVCpFilFyHQzy7odIbZb7IonUY8xt4v2GPGW+Oz54=;
        b=nquo376FffvQ3v3Rot5hKJWmoXydDFUPS5K8Msy16aHDfMoXMHJaKEgzIb7rLMcfNd
         7UasfEw5fllEthQ7vZPW5yy7CRNBa9uWYquvC3PiLWXsOlfnTuEYuuqU/6QASyKjQ68p
         uihd1nMk52yKJ5uHA3Vb9kH11m33Q82I19TEOEXEExVDMk1U8Xzqgo0uFi08daronlU0
         iktu1WI7AFHajdQwIVev6IGJ4DKfaCjbaf8KaFIBDTa1YzEmqATKWf2q6MkfK+zYKLrm
         bxag30j/GH3FnAwxO2pcob2QKfLLCmFKOi+cM02Oou54WjW9JdUmbklZeMPSsFRAq5Wj
         UXeg==
X-Gm-Message-State: AOJu0Yx9vKWQKsfdxDuQ+KTBYe9bFbU7azXPjnyaonIOES9C83Kwa5Eq
	D77+YLXFHCA4jtNnT8IoCGA9abgGziUF+CgXwAgoRehEDsOx1C5fd6wbW+msdjcn+kTdz1UuoqI
	/Frn8MWc=
X-Gm-Gg: AY/fxX5x+JXcnyDorsaN6FEIMcjqsCLfsC9UHOu176SHLNiX62BldAW3xy3fjIz7h8y
	uKZtfcEr3kVOozKOiEzHUIhHwDVr5Zl7RRkjUfvAZh91f2P0p6CiayNuiuasbtONSpEraQz8ABN
	U2wilqXx1wvQH0uPWk9jteX8Lh+b0L+f/nFQRNzKEnJ/LwAeo5/HglpjpFyQtyOYLVBNF0C1p2U
	/LmtedKudGgQ3+K6JsCBibzwgCyQDVU6eJlvcffCti+piIhOvsEWjCyTCri1W4Y/XUcwKgDoh8T
	v9KI1p/MvPZXfci34QHoPo6CGDZDyGdfPVWQhWkqXaKGjNMe/Ep9C3yMGxxY5cbZVgAP5JnjNCU
	Tlob9Y5+a9I0H9zevnYBV1/88XeAIllUOFAPdrQj0Dm6vVDeiUx9mHxXABYg/TAin2OP6weKwEE
	df2+g1DD+Ty060GgwstktVVHN4vZAFLO1QZAdihsG1FJwko76A0bOV0lJ8w9b04zv4vqsqpfTUw
	uo=
X-Received: by 2002:a05:620a:40c9:b0:8b2:6ac5:bcb1 with SMTP id af79cd13be357-8c52fb4ced6mr71721685a.31.1768335735276;
        Tue, 13 Jan 2026 12:22:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530b74bc4sm3181885a.32.2026.01.13.12.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:22:14 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field for cxl_region
Date: Tue, 13 Jan 2026 15:21:36 -0500
Message-ID: <20260113202138.3021093-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL driver presently has 3 modes of managing a cxl_region:
  - no specific driver (bios-onlined SystemRAM)
  - dax_region (all other RAM regions, for now)
  - pmem_region (all PMEM regions)

Formalize these into specific "region drivers".

enum cxl_region_driver {
	CXL_REGION_DRIVER_NONE,
	CXL_REGION_DRIVER_DAX,
	CXL_REGION_DRIVER_PMEM
};

$cat regionN/region_driver
[none,dax,pmem]

The intent is to clarify how to to add additional drivers (sysram,
dynamic_capacity, etc) in the future, and to allow switching the
driver selection via a sysfs entry `regionN/region_driver`.

All RAM regions will be defaulted to CXL_CONTROL_DAX.

Auto-regions will either be static sysram (BIOS-onlined) and has no
region controller associated with it - or if the SP bit was set a
DAX device will be created.  This will be discovered at probe time.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 113 ++++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h         |   8 +++
 2 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae899f68551f..f8262d2169ea 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -626,6 +626,57 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(mode);
 
+static ssize_t region_driver_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	const char *desc;
+
+	switch (cxlr->driver) {
+	case CXL_REGION_DRIVER_NONE:
+		desc = "none";
+		break;
+	case CXL_REGION_DRIVER_DAX:
+		desc = "dax";
+		break;
+	case CXL_REGION_DRIVER_PMEM:
+		desc = "pmem";
+		break;
+	}
+
+	return sysfs_emit(buf, "%s\n", desc);
+}
+
+static ssize_t region_driver_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	if (p->state >= CXL_CONFIG_COMMIT)
+		return -EBUSY;
+
+	/* PMEM drivers cannot be changed */
+	if (cxlr->mode == CXL_PARTMODE_PMEM)
+		return -EBUSY;
+
+	/* NONE type is not a valid selection for manually probed regions */
+	if (sysfs_streq(buf, "dax"))
+		cxlr->driver = CXL_REGION_DRIVER_DAX;
+	else
+		return -EINVAL;
+
+	return len;
+}
+static DEVICE_ATTR_RW(region_driver);
+
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
@@ -772,6 +823,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_extended_linear_cache_size.attr,
+	&dev_attr_region_driver.attr,
 	NULL,
 };
 
@@ -2599,6 +2651,16 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	cxlr->mode = mode;
 	cxlr->type = type;
 
+	/*
+	 * PMEM regions only have 1 driver: pmem_region
+	 * RAM regions default to DAX, but if the memory is already onlined by
+	 * BIOS as 'System-RAM', the DAX driver will be dropped during probe.
+	 */
+	if (mode == CXL_PARTMODE_PMEM)
+		cxlr->driver = CXL_REGION_DRIVER_PMEM;
+	else
+		cxlr->driver = CXL_REGION_DRIVER_DAX;
+
 	dev = &cxlr->dev;
 	rc = dev_set_name(dev, "region%d", id);
 	if (rc)
@@ -3951,33 +4013,38 @@ static int cxl_region_probe(struct device *dev)
 			return rc;
 	}
 
-	switch (cxlr->mode) {
-	case CXL_PARTMODE_PMEM:
-		rc = devm_cxl_region_edac_register(cxlr);
-		if (rc)
-			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
-				cxlr->id);
+	if (cxlr->mode > CXL_PARTMODE_PMEM) {
+		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
+			cxlr->mode);
+		return -ENXIO;
+	}
 
-		return devm_cxl_add_pmem_region(cxlr);
-	case CXL_PARTMODE_RAM:
-		rc = devm_cxl_region_edac_register(cxlr);
-		if (rc)
-			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
-				cxlr->id);
+	/*
+	 * The region can not be managed by CXL if any portion of
+	 * it is already online as 'System RAM'.
+	 */
+	if (walk_iomem_res_desc(IORES_DESC_NONE,
+				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				p->res->start, p->res->end, cxlr,
+					is_system_ram) > 0) {
+		cxlr->driver = CXL_REGION_DRIVER_NONE;
+		return 0;
+	}
 
-		/*
-		 * The region can not be manged by CXL if any portion of
-		 * it is already online as 'System RAM'
-		 */
-		if (walk_iomem_res_desc(IORES_DESC_NONE,
-					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-					p->res->start, p->res->end, cxlr,
-					is_system_ram) > 0)
-			return 0;
+	rc = devm_cxl_region_edac_register(cxlr);
+	dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d %s\n",
+			cxlr->id, rc ? "failed" : "succeeded");
+
+	switch (cxlr->driver) {
+	case CXL_REGION_DRIVER_NONE:
+		return 0;
+	case CXL_REGION_DRIVER_DAX:
 		return devm_cxl_add_dax_region(cxlr);
+	case CXL_REGION_DRIVER_PMEM:
+		return devm_cxl_add_pmem_region(cxlr);
 	default:
-		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
-			cxlr->mode);
+		dev_dbg(&cxlr->dev, "unsupported region driver: %d\n",
+			cxlr->driver);
 		return -ENXIO;
 	}
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..e8256099de29 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -502,6 +502,13 @@ enum cxl_partition_mode {
 	CXL_PARTMODE_PMEM,
 };
 
+
+enum cxl_region_driver {
+	CXL_REGION_DRIVER_NONE,
+	CXL_REGION_DRIVER_DAX,
+	CXL_REGION_DRIVER_PMEM,
+};
+
 /*
  * Indicate whether this region has been assembled by autodetection or
  * userspace assembly. Prevent endpoint decoders outside of automatic
@@ -543,6 +550,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	enum cxl_partition_mode mode;
+	enum cxl_region_driver driver;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;
-- 
2.52.0

