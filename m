Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E21DDF4
	for <linux-cxl@vger.kernel.org>; Wed, 28 Feb 2024 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709152260; cv=none; b=ov79lge2A8vawNOr4n6xsFwvnbFjhg5DJmMqGscM62AxmA5QoNIQy+V25nqi0f9MQmEgR4SYuKN6f2D+ZEhmdhL068KSTywo0Q8QkKklRBw4Y6hyIc4TjAkazLPCIsAOaYVdwzwnqM1BVp7+QIwFqp6L8VEGhQvHhywZQc6ANJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709152260; c=relaxed/simple;
	bh=l3yDttjWgb/Ul6rv6k6piLCRZsiKdGyq5Bvtvd9lw88=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=sLjWIrdM2idTs+VE/Arb9p7uP2bS07kgnTwJasj+1hGbJFPtD3gKQPgTzjkOsy0sA6BE3Yn0fOux9LkrB7F5RfwYS+8J+qce8rHriujAtA8QGQo45LOL41hN1953S6erYZt6E5OvpOs6QixaPT/w02VwycexV07qesECSOqMybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmihWt3S; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmihWt3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709152259; x=1740688259;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l3yDttjWgb/Ul6rv6k6piLCRZsiKdGyq5Bvtvd9lw88=;
  b=SmihWt3SOuwCmjjvQAZh1noZ5tEcDGKqblDUMfueyOViixoXLnYjcRQs
   pacOQIp7olprSDxZfJGNl+gy52Amb+wH7Vwv/qb8OalThOyY9Ac1RfcA7
   1ZwN/AWuQh0PiLxCSMJD04q6YQNqjbRVKtZMLxKVjQfkmUxs9nnbaGFGh
   5Yn1OuEvqxSDKgtK3NB9vxNFrU67zVQd4J+9yI6GwS9RVzJgvKfM7xuha
   HfZI7i7K5Ro+Y36mgyZmjN11SkSs45Md2EJCRor78jr78GOpxiNUrOKE6
   lWdBFk7923LEQfTFr60mYLJZC9n/voBFL04pYJMe8XbTOiiCg34PJVr4L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14291358"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14291358"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:30:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="38592942"
Received: from veerarag-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.31.231])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:30:57 -0800
Subject: [PATCH v2] cxl/acpi: Cleanup __cxl_parse_cfmws()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Wed, 28 Feb 2024 12:30:56 -0800
Message-ID: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1:
- drop the introduction of cond_no_free_ptr() in favor of reorganizing
  the code to clarify the handoff of "free on error" responsibility.

 drivers/cxl/acpi.c |   99 ++++++++++++++++++++++++++++++----------------------
 drivers/cxl/cxl.h  |    5 +++
 2 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1a3e6aafbdcc..1a47207932e2 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -316,28 +316,64 @@ static const struct cxl_root_ops acpi_root_ops = {
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
+					   resource_size_t n, const char *fmt,
+					   ...)
+{
+	va_list ap;
+
+	struct resource *res __free(kfree) = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return NULL;
+
+	res->start = base;
+	res->end = base + n - 1;
+	res->flags = IORESOURCE_MEM;
+
+	va_start(ap, fmt);
+	res->name = kvasprintf(GFP_KERNEL, fmt, ap);
+	va_end(ap);
+
+	if (!res->name)
+		return NULL;
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
@@ -348,29 +384,24 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	for (i = 0; i < ways; i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
-	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	struct resource *res __free(del_cxl_resource) =
+		alloc_cxl_resource(cfmws->base_hpa, cfmws->window_size,
+				   "CXL Window %d", ctx->id++);
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
 
@@ -378,8 +409,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
@@ -399,11 +430,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
@@ -411,18 +441,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
@@ -692,12 +713,6 @@ static void cxl_acpi_lock_reset_class(void *dev)
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
index 003feebab79b..8bc044a4a965 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -776,6 +776,11 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
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

