Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E718BB8B;
	Tue, 15 Oct 2024 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975511; cv=none; b=VtMkKpEsQLeVFDdRHD3cWmsae+JLa3Gyhhv8DYwkcr4FvCQm5ZUmI4JeQKvoLQZKp07UgD9t+APP7NBQUW+Sqc2Bo6rfB56TyW8ABYIadiBbPbuOB0y/Xv8sB4+ErE+O26TypivLtgOHhkUYfpGZsu5mH4b4fypNGtiZe1G5ScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975511; c=relaxed/simple;
	bh=kfEWIK4MkSwe8J7QnC0SyLg4DySWos7YcTLodpSGzF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRnQ5b+NrfMzwDohIFOcwJLIMcKonH8PvcpyJXU5Mx2eAw/mUbxFF5JRzgMTOjAMudQDPNw9VMXqp3TjccIB5F185pvyjdj4vbyC34xKMZi/GOUhlc1nQAAizW5qHvSMy2qn6rsiDyZAJ0kcHuoD3VgxC+iORwjveMbGZyqtUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSaoNfVh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSaoNfVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728975510; x=1760511510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kfEWIK4MkSwe8J7QnC0SyLg4DySWos7YcTLodpSGzF4=;
  b=FSaoNfVhzvjqUj7zL7/RUeTgUxJ7/LYtdOuVBN+d5Pen+TeFG7RKTo48
   VylfYU2zHgW4KIjCA4XHOOWmu5VWNWpaUhWd4QOs04xIIe/k5vhBbaaBd
   fh/t1o2bPnSED+YHHSil/17mS95OXd3HK6vO1BxwAQvauk2T70iqb2Ot/
   H+6VtEXnyK3wZqr+dmkRqzPd4DoH2HfHKa0z27hjMbpZIzZvY1iMcxmI2
   EO/8x78zZ7NFD5WdVtBtmN09ZGmKacAf9qPs/V1XQX6R9Adz+Lm02pUo8
   Ifw8+vRERY5j5p+Kp35fMC08E9n9yd4ILGc9lF9EFUkhb/H3hsnAorL0x
   Q==;
X-CSE-ConnectionGUID: ScUbsDBRRYyapZMOGQprow==
X-CSE-MsgGUID: WASINfLtSUmB05w42J1NPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28447865"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28447865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:30 -0700
X-CSE-ConnectionGUID: WKEUq0feTha0qIlAlJPguA==
X-CSE-MsgGUID: AML8i+ePQx6G445dIA2iRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="81776920"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:26 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH 4/5] cxl: Set type of region to that of the first endpoint
Date: Tue, 15 Oct 2024 14:57:12 +0800
Message-Id: <20241015065713.308671-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241015065713.308671-1-ying.huang@intel.com>
References: <20241015065713.308671-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current kernel hard-codes the type of region to type 3 expander now,
because this is the only supported device type.  As a preparation to
support type 2 accelerators, the patch sets the type of region to that
of the first endpoint.  Then, the patch checks whether the type of
region is same as the type of other endpoints of the region.  Because
what we really need is to make sure the type of all endpoints of a
region is same.  And, the patch lets expander/accelerator device
drivers specify the target type of endpoint devices via struct
cxl_dev_state.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Cc: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/acpi.c        |  1 -
 drivers/cxl/core/hdm.c    | 28 +++++++++++++---------------
 drivers/cxl/core/port.c   |  2 ++
 drivers/cxl/core/region.c | 13 +++++++------
 drivers/cxl/cxl.h         |  1 +
 5 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 21486e471305..29c2a44b122c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -382,7 +382,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 478fb6691759..c9accf8be71f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -841,18 +841,25 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
+	if (cxled) {
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+		if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
+			cxld->target_type = CXL_DECODER_EXPANDER;
+		else
+			cxld->target_type = CXL_DECODER_ACCEL;
+	}
+
 	/* decoders are enabled if committed */
 	if (committed) {
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl)) {
-			cxld->target_type = CXL_DECODER_EXPANDER;
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
 			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
-		} else {
-			cxld->target_type = CXL_DECODER_ACCEL;
+		else
 			cxld->coherence = CXL_DECODER_DEVCOH;
-		}
 
 		guard(rwsem_write)(&cxl_region_rwsem);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
@@ -874,21 +881,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 			struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-			/*
-			 * Default by devtype until a device arrives that needs
-			 * more precision.
-			 */
-			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
-				cxld->target_type = CXL_DECODER_EXPANDER;
-			else
-				cxld->target_type = CXL_DECODER_ACCEL;
 			if (cxlds->coherence == CXL_DEVCOH_HOSTONLY)
 				cxld->coherence = CXL_DECODER_HOSTONLYCOH;
 			else
 				cxld->coherence = CXL_DECODER_DEVCOH;
 		} else {
-			/* To be overridden by region type/coherence at commit time */
-			cxld->target_type = CXL_DECODER_EXPANDER;
+			/* To be overridden by region coherence at commit time */
 			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
 		}
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9ebbffcea26a..d1bc6aed6509 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -139,6 +139,8 @@ static ssize_t target_type_show(struct device *dev,
 		return sysfs_emit(buf, "accelerator\n");
 	case CXL_DECODER_EXPANDER:
 		return sysfs_emit(buf, "expander\n");
+	default:
+		break;
 	}
 	return -ENXIO;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21b877d8582f..d709738ada61 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1926,7 +1926,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (cxled->cxld.target_type != cxlr->type) {
+	/* Set the type of region to that of the first endpoint */
+	if (cxlr->type == CXL_DECODER_INVALID) {
+		cxlr->type = cxled->cxld.target_type;
+	} else if (cxled->cxld.target_type != cxlr->type) {
 		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			cxled->cxld.target_type, cxlr->type);
@@ -2476,7 +2479,6 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
  * @cxlrd: root decoder
  * @id: memregion id to create, or memregion_free() on failure
  * @mode: mode for the endpoint decoders of this region
- * @type: select whether this is an expander or accelerator (type-2 or type-3)
  *
  * This is the second step of region initialization. Regions exist within an
  * address space which is mapped by a @cxlrd.
@@ -2486,8 +2488,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
  */
 static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 					      int id,
-					      enum cxl_decoder_mode mode,
-					      enum cxl_decoder_type type)
+					      enum cxl_decoder_mode mode)
 {
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
 	struct cxl_region *cxlr;
@@ -2498,7 +2499,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	if (IS_ERR(cxlr))
 		return cxlr;
 	cxlr->mode = mode;
-	cxlr->type = type;
+	cxlr->type = CXL_DECODER_INVALID;
 
 	dev = &cxlr->dev;
 	rc = dev_set_name(dev, "region%d", id);
@@ -2562,7 +2563,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
+	return devm_cxl_add_region(cxlrd, id, mode);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1927a1849d82..f4cbe5c292ea 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -324,6 +324,7 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 #define CXL_DECODER_F_MASK        GENMASK(5, 0)
 
 enum cxl_decoder_type {
+	CXL_DECODER_INVALID = 0,
 	CXL_DECODER_ACCEL = 2,
 	CXL_DECODER_EXPANDER = 3,
 };
-- 
2.39.2

