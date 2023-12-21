Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BE745E6
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLbkfFSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196264; x=1734732264;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ozoja61O/kN15Lnkjr1HxlBfB+q6fKlabALmTrc2nhI=;
  b=MLbkfFSWfZEm3XyWQdGnN0+4kHADgdDOxwqfUfEZBfrCCDVeXMbyEjcd
   OuVm2eoUMuqV5GCFLPqXrOpuBgBGyWfJvYJUtg8pFZMcvq/ORnNXY0r8C
   CHg3SheANGS9sNlIAkthkZ7vPRmXfgMfpDfmlnEj0InyxHZH3S0TK+Ndy
   ZZQ8XsN58dl4FB5vGM+fawIF0ujHp91wlVkkE8+JidDDcO1W93MmM4oef
   Dae9KpA7IT8tYDw2wi+pQIFx3hgc5mkkyRxdO+YfCCDZO7n4nxFQFPLME
   ZKRIrgHCHPJZj6J3t2LMKymKYhPg8AAm1URLkg3xLqSJv2kZcAyxwML3C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="398831695"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="398831695"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:04:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895242901"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="895242901"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:04:23 -0800
Subject: [PATCH v15 19/19] cxl: Check qos_class validity on memdev probe
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:04:23 -0700
Message-ID: <170319626313.2212653.9021004640856081917.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a check to make sure the qos_class for the device will match one of
the root decoders qos_class. If no match is found, then the qos_class for
the device is set to invalid. Also add a check to ensure that the device's
host bridge matches to one of the root decoder's downstream targets.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v15:
- Move per entry qos_class invalid check to caller (Jonathan)
- Use return value of device_for_each_child() for match. (Jonathan)
- Have DEFINE_FREE() check list_empty() instead of list ptr valid
  (Jonathan)
---
 drivers/cxl/core/cdat.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 8c561f1deec6..0ac55dd050bc 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -270,6 +270,108 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 	devm_add_action_or_reset(&cxlds->cxlmd->dev, free_perf_ents, mds);
 }
 
+static int match_cxlrd_qos_class(struct device *dev, void *data)
+{
+	int dev_qos_class = *(int *)data;
+	struct cxl_root_decoder *cxlrd;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	if (cxlrd->qos_class == CXL_QOS_CLASS_INVALID)
+		return 0;
+
+	if (cxlrd->qos_class == dev_qos_class)
+		return 1;
+
+	return 0;
+}
+
+static void cxl_qos_match(struct cxl_port *root_port,
+			  struct list_head *work_list,
+			  struct list_head *discard_list)
+{
+	struct cxl_dpa_perf *dpa_perf, *n;
+
+	list_for_each_entry_safe(dpa_perf, n, work_list, list) {
+		int rc;
+
+		if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
+			return;
+
+		rc = device_for_each_child(&root_port->dev,
+					   (void *)&dpa_perf->qos_class,
+					   match_cxlrd_qos_class);
+		if (!rc)
+			list_move_tail(&dpa_perf->list, discard_list);
+	}
+}
+
+static int match_cxlrd_hb(struct device *dev, void *data)
+{
+	struct device *host_bridge = data;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
+	unsigned int seq;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxlsd = &cxlrd->cxlsd;
+
+	do {
+		seq = read_seqbegin(&cxlsd->target_lock);
+		for (int i = 0; i < cxlsd->nr_targets; i++) {
+			if (host_bridge == cxlsd->target[i]->dport_dev)
+				return 1;
+		}
+	} while (read_seqretry(&cxlsd->target_lock, seq));
+
+	return 0;
+}
+
+static void discard_dpa_perf(struct list_head *list)
+{
+	struct cxl_dpa_perf *dpa_perf, *n;
+
+	list_for_each_entry_safe(dpa_perf, n, list, list) {
+		list_del(&dpa_perf->list);
+		kfree(dpa_perf);
+	}
+}
+DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
+
+static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_port *root_port __free(put_device) = NULL;
+	LIST_HEAD(__discard);
+	struct list_head *discard __free(dpa_perf) = &__discard;
+	int rc;
+
+	root_port = find_cxl_root(cxlmd->endpoint);
+	if (!root_port)
+		return -ENODEV;
+
+	/* Check that the QTG IDs are all sane between end device and root decoders */
+	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
+	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
+
+	/* Check to make sure that the device's host bridge is under a root decoder */
+	rc = device_for_each_child(&root_port->dev,
+				   (void *)cxlmd->endpoint->host_bridge,
+				   match_cxlrd_hb);
+	if (!rc) {
+		list_splice_tail_init(&mds->ram_perf_list, discard);
+		list_splice_tail_init(&mds->pmem_perf_list, discard);
+	}
+
+	return rc;
+}
+
 static void discard_dsmas(struct xarray *xa)
 {
 	unsigned long index;
@@ -308,6 +410,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 	}
 
 	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
+	cxl_qos_class_verify(cxlmd);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 


