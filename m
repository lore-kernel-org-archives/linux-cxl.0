Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E3C43219
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Nov 2022 23:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiKVXIE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiKVXH7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Nov 2022 18:07:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8117D57B47
        for <linux-cxl@vger.kernel.org>; Tue, 22 Nov 2022 15:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669158479; x=1700694479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/bS1ui6SalGp/MxEBN1In7Zgrx+Hg8N5ZdUG/O74OFg=;
  b=QxzQATtc7jcymDVXYWIstPb2HNAvEJUJCegvde8RWl+CGwmxzS4+3ebt
   XtpZTbntC/fRVhFtDVLgYF8Kl0xlCPAkzieJJP+nu57Gn5VQX8jtQpz9V
   FYjjhbx4xzJlvjdt/vnSj2J/WTLtj9b2wpUM8yTu0hDr54GtzViSmDlEp
   tcmYJqDAyh6MfLZpLB5+YZAYPxQV8qyh60qTkbSfooYWph3hvW58VMOqi
   ZUpGfJdNqg1lQvxWF9mDLb9ekUUEeviGrho3WqtmPk6vIUORZa+Ez+1Et
   nZs+RONTSQyV4Sme0VtFe8njlDhqPJEdaX4MAt/uhz6ey7a+BOITDs7tG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376079347"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="376079347"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747542516"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747542516"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.144.204])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:57 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 4/4] cxl/acpi: Add a match on dport check for XOR addr translation
Date:   Tue, 22 Nov 2022 15:07:51 -0800
Message-Id: <f44d5fcd9946344801208b3033dfd7543512facf.1669153711.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669153711.git.alison.schofield@intel.com>
References: <cover.1669153711.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Address translations from DPA to HPA are validated by checking
that the resulting HPA is within the expected region resource.

When the host bridge is using XOR arithmetic, an additional
check can be performed by passing the HPA through an XOR
function that finds its index in the host bridge interleave
list. An HPA passes this check if the index derived matches
the known dport of the endpoint decoder.

Since this is a check that applies only to host bridges using
XOR arithmetic, layer it on top of the existing cxl_dpa_to_hpa()
by adding a new call back type: cxl_calc_hpa_fn() to the
cxl_root_decoder.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c        | 50 ++++++++++++++++++++++++++++++++++++---
 drivers/cxl/core/core.h   |  3 ---
 drivers/cxl/core/port.c   |  5 +++-
 drivers/cxl/core/region.c |  8 ++++---
 drivers/cxl/cxl.h         | 11 ++++++++-
 5 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 38b5f77164b0..424469d73549 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <asm/div64.h>
 #include "cxlpci.h"
+#include "cxlmem.h"
 #include "cxl.h"
 
 struct cxl_cxims_data {
@@ -38,6 +39,44 @@ static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
 	return n;
 }
 
+static bool cxl_xor_hpa_to_dport(u64 hpa, struct cxl_root_decoder *cxlrd,
+				 struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	int ig = cxled->cxld.interleave_granularity;
+	int iw = cxled->cxld.interleave_ways;
+	struct cxl_dport *match_dport;
+	int n = 0;
+
+	if (iw != 1)
+		n = cxl_xor_calc_n(hpa, cximsd, iw, ig);
+
+	match_dport = cxl_find_dport_by_dev(cxlrd_to_port(cxlrd),
+					    cxled_to_port(cxled)->host_bridge);
+	if (cxlrd->cxlsd.target[n] != match_dport)
+		return false;
+
+	return true;
+}
+
+static u64 cxl_dpa_to_hpa_xor(u64 dpa, struct cxl_region *cxlr,
+			      struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	u64 hpa;
+
+	hpa = cxl_dpa_to_hpa(dpa, cxlr, cxled);
+	if (!hpa)
+		return 0;
+
+	if (!cxl_xor_hpa_to_dport(hpa, cxlrd, cxled)) {
+		dev_dbg(&cxlr->dev,
+			"Addr trans fail: hpa:0x%llx dport mismatch\n", hpa);
+		return 0;
+	}
+	return hpa;
+}
+
 static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 {
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
@@ -193,6 +232,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
+	cxl_calc_hpa_fn cxl_calc_hpa;
 	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
@@ -235,12 +275,16 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	if (rc)
 		goto err_insert;
 
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
 		cxl_calc_hb = cxl_hb_modulo;
-	else
+		cxl_calc_hpa = cxl_dpa_to_hpa;
+	} else {
 		cxl_calc_hb = cxl_hb_xor;
+		cxl_calc_hpa = cxl_dpa_to_hpa_xor;
+	}
 
-	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
+	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb,
+				       cxl_calc_hpa);
 	if (IS_ERR(cxlrd))
 		return 0;
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 72b58e53c394..1d8f87be283f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -67,9 +67,6 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
 }
 
-u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
-		   struct cxl_endpoint_decoder *cxled);
-
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 42cdf224a85d..0f1e691ed02f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1504,6 +1504,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  * @port: owning CXL root of this decoder
  * @nr_targets: static number of downstream targets
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @calc_hpa: dpa to hpa address translation function
  *
  * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
  * 'CXL root' decoder is one that decodes from a top-level / static platform
@@ -1512,7 +1513,8 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  */
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb)
+						cxl_calc_hb_fn calc_hb,
+						cxl_calc_hpa_fn calc_hpa)
 {
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_switch_decoder *cxlsd;
@@ -1535,6 +1537,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	}
 
 	cxlrd->calc_hb = calc_hb;
+	cxlrd->calc_hpa = calc_hpa;
 
 	cxld = &cxlsd->cxld;
 	cxld->dev.type = &cxl_decoder_root_type;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 32216b5fe450..c14d098d557b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1944,9 +1944,11 @@ u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
 
 	return hpa;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_to_hpa, CXL);
 
 static bool cxl_check_addrtrans(struct cxl_region *cxlr)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled;
 	u64 start, end, dpa;
@@ -1961,15 +1963,15 @@ static bool cxl_check_addrtrans(struct cxl_region *cxlr)
 		end = start + cxl_dpa_size(cxled) - 1;
 
 		dpa = start;
-		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
+		if (!cxlrd->calc_hpa(dpa, cxlr, cxled))
 			return false;
 
 		dpa = start + cxl_dpa_size(cxled) / 2;
-		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
+		if (!cxlrd->calc_hpa(dpa, cxlr, cxled))
 			return false;
 
 		dpa = end;
-		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
+		if (!cxlrd->calc_hpa(dpa, cxlr, cxled))
 			return false;
 	}
 	return true;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d03aa1776fc8..a14a1defa14f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -328,12 +328,15 @@ struct cxl_root_decoder;
 struct cxl_endpoint_decoder;
 typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
 					    int pos);
+typedef u64 (*cxl_calc_hpa_fn)(u64 dpa, struct cxl_region *cxlr,
+			       struct cxl_endpoint_decoder *cxled);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @calc_hpa: dpa to hpa address translation function
  * @platform_data: platform specific configuration data
  * @cxlsd: base cxl switch decoder
  */
@@ -341,6 +344,7 @@ struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
 	cxl_calc_hb_fn calc_hb;
+	cxl_calc_hpa_fn calc_hpa;
 	void *platform_data;
 	struct cxl_switch_decoder cxlsd;
 };
@@ -589,7 +593,10 @@ bool is_endpoint_decoder(struct device *dev);
 
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb);
+						cxl_calc_hb_fn calc_hb,
+						cxl_calc_hpa_fn calc_hpa);
+
+/* TODO should cxl_hb_module be of type 'cxl_calc_hb_fn */
 struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
@@ -598,6 +605,8 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
+		   struct cxl_endpoint_decoder *cxled);
 
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
-- 
2.37.3

