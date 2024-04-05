Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B816EC18
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354777; cv=none; b=pPwCHCrnMS9cNkZfkzXToJzvLyCfcDI7hVotTFXu/+/cjPYPfVsLURUUQpg7Pvocv0nTDgqMFx0lB3YqHPO5F+9irs+v9Gg6AuvoR3pz+qgPkrAwGdiVTpieLxtgSmXqEINIstSO5q11PpQg1SVVbMFZncWKN/gTPA+objxdOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354777; c=relaxed/simple;
	bh=H0fAkJ/hCgw61sDbNF3Zq8jC44hihFpKt18Bq2FstPQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RP+HASSGDzYeV2IUmPW/Hz0YPYHTr0fedkfQUURvLGUjBCcnrmM87xVrfTy940nDLbc997TlTTERx5MiNLuo6tqTxetl3qG4Qv6cPahvrvsoxQGlrH0b9Iokrw+fDiixjjZDNCqWJMG2HIQCo7NuSeI1ERPizITfd492SnYVTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=md9+0kMz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="md9+0kMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712354776; x=1743890776;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H0fAkJ/hCgw61sDbNF3Zq8jC44hihFpKt18Bq2FstPQ=;
  b=md9+0kMzba3i0QsBMcO9pNd8RGv5POdvz+ZPcTd1nJYXPR862QYYsjq/
   c7zaqJPFGIZiF1F1qHmnXNB8UsazmTJovk4ZFksoPyY2uwvqTkGObZ6TH
   Hb7KYJYqVK3d4FCe/kLoWxoII+dElSBKVO4MeTuAXZeEdeDwMLkTLQ/6C
   wgKzKB5yaTCGvaqRzltNdTyAFdx3onludPB0BvmMnuRMd1v8Euq1Cy5uK
   R76o7vJU0oflnHvXJrO/vxmvoFa/18YAM0XLZqnBXLNmrJUL9on0pKqEw
   t2LOBenKUfYC1jKVR9kHvJZhVRl3M3GlbPh2jHDky37c4KynvMGG9XN47
   g==;
X-CSE-ConnectionGUID: Qo+W3NotTcWmddqsTX/S1g==
X-CSE-MsgGUID: oJw+ak/3Tpu9vFZgspoDeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7871463"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7871463"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:05:52 -0700
X-CSE-ConnectionGUID: Kv6v7mRHRaKyDMLK50OXxA==
X-CSE-MsgGUID: VMHQW+odTJKFa4FvLHfyhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23791802"
Received: from brownjac-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.180.254])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:05:51 -0700
Subject: [PATCH v3] cxl/acpi: Cleanup __cxl_parse_cfmws()
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Date: Fri, 05 Apr 2024 15:05:50 -0700
Message-ID: <171235474028.2718248.14109646123143505522.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>
References: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

As a follow on to the recent rework of __cxl_parse_cfmws() to always
return errors [1], use cleanup.h helpers to remove goto and other cleanups
now that logging is moved to the cxl_parse_cfmws() wrapper.

This ends up adding more code than it deletes, but __cxl_parse_cfmws()
itself does get smaller. The takeaway from the cond_no_free_ptr()
discussion [2] was to not add new macros to handle the cases where
no_free_ptr() is awkward, instead rework the code to have helpers and
clearer delineation of responsibility.

Now one might say that  __free(del_cxl_resource) is excessive given it
is immediately registered with add_or_reset_cxl_resource(). The
rationale for keeping it is that it forces use of "no_free_ptr()" on the
argument passed to add_or_reset_cxl_resource(). That in turn makes it
clear that @res is NULL for the rest of the function which is part of
the point of the cleanup helpers, to turn subtle use after free errors
[3] into loud NULL pointer de-references.

Link: http://lore.kernel.org/r/170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com [1]
Link: http://lore.kernel.org/r/CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com [2]
Link: http://lore.kernel.org/r/20230714093146.2253438-1-leitao@debian.org [3]
Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Closes: http://lore.kernel.org/r/20240219124041.00002bda@Huawei.com
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v2:
- Drop kvasprintf() usage in alloc_cxl_resource (Alison)

 drivers/cxl/acpi.c |   93 +++++++++++++++++++++++++++++-----------------------
 drivers/cxl/cxl.h  |    5 +++
 2 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index af5cb818f84d..32091379a97b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -316,28 +316,59 @@ static const struct cxl_root_ops acpi_root_ops = {
 	.qos_class = cxl_acpi_qos_class,
 };
 
+static void del_cxl_resource(struct resource *res)
+{
+	if (!res)
+		return;
+	kfree(res->name);
+	kfree(res);
+}
+
+static struct resource *alloc_cxl_resource(resource_size_t base,
+					   resource_size_t n, int id)
+{
+	struct resource *res __free(kfree) = kzalloc(sizeof(*res), GFP_KERNEL);
+
+	if (!res)
+		return NULL;
+
+	res->start = base;
+	res->end = base + n - 1;
+	res->flags = IORESOURCE_MEM;
+	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", id);
+	if (!res->name)
+		return NULL;
+
+	return no_free_ptr(res);
+}
+
+static int add_or_reset_cxl_resource(struct resource *parent, struct resource *res)
+{
+	int rc = insert_resource(parent, res);
+
+	if (rc)
+		del_cxl_resource(res);
+	return rc;
+}
+
+DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
+	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
+DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
 static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 			     struct cxl_cfmws_context *ctx)
 {
 	int target_map[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_port *root_port = ctx->root_port;
-	struct resource *cxl_res = ctx->cxl_res;
 	struct cxl_cxims_context cxims_ctx;
-	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
-	struct resource *res;
 	int rc;
 
 	rc = cxl_acpi_cfmws_verify(dev, cfmws);
-	if (rc) {
-		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
-			cfmws->base_hpa,
-			cfmws->base_hpa + cfmws->window_size - 1);
+	if (rc)
 		return rc;
-	}
 
 	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
 	if (rc)
@@ -348,29 +379,23 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	for (i = 0; i < ways; i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
-	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	struct resource *res __free(del_cxl_resource) = alloc_cxl_resource(
+		cfmws->base_hpa, cfmws->window_size, ctx->id++);
 	if (!res)
 		return -ENOMEM;
 
-	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
-	if (!res->name)
-		goto err_name;
-
-	res->start = cfmws->base_hpa;
-	res->end = cfmws->base_hpa + cfmws->window_size - 1;
-	res->flags = IORESOURCE_MEM;
-
 	/* add to the local resource tracking to establish a sort order */
-	rc = insert_resource(cxl_res, res);
+	rc = add_or_reset_cxl_resource(ctx->cxl_res, no_free_ptr(res));
 	if (rc)
-		goto err_insert;
+		return rc;
 
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
 		cxl_calc_hb = cxl_hb_modulo;
 	else
 		cxl_calc_hb = cxl_hb_xor;
 
-	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
+	struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
+		cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
 	if (IS_ERR(cxlrd))
 		return PTR_ERR(cxlrd);
 
@@ -378,8 +403,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
-		.start = res->start,
-		.end = res->end,
+		.start = cfmws->base_hpa,
+		.end = cfmws->base_hpa + cfmws->window_size - 1,
 	};
 	cxld->interleave_ways = ways;
 	/*
@@ -399,11 +424,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
 						   cxl_parse_cxims, &cxims_ctx);
 			if (rc < 0)
-				goto err_xormap;
+				return rc;
 			if (!cxlrd->platform_data) {
 				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
-				rc = -EINVAL;
-				goto err_xormap;
+				return -EINVAL;
 			}
 		}
 	}
@@ -411,18 +435,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxlrd->qos_class = cfmws->qtg_id;
 
 	rc = cxl_decoder_add(cxld, target_map);
-err_xormap:
 	if (rc)
-		put_device(&cxld->dev);
-	else
-		rc = cxl_decoder_autoremove(dev, cxld);
-	return rc;
-
-err_insert:
-	kfree(res->name);
-err_name:
-	kfree(res);
-	return -ENOMEM;
+		return rc;
+	return cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
 }
 
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
@@ -694,12 +709,6 @@ static void cxl_acpi_lock_reset_class(void *dev)
 	device_lock_reset_class(dev);
 }
 
-static void del_cxl_resource(struct resource *res)
-{
-	kfree(res->name);
-	kfree(res);
-}
-
 static void cxl_set_public_resource(struct resource *priv, struct resource *pub)
 {
 	priv->desc = (unsigned long) pub;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 534e25e2f0a4..71ac7a5ada80 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -781,6 +781,11 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
+static inline int cxl_root_decoder_autoremove(struct device *host,
+					      struct cxl_root_decoder *cxlrd)
+{
+	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
+}
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 
 /**

