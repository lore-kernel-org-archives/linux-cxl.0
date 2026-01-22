Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41D38A29E
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052744; cv=none; b=ntHEwoRDU891inzcU5vm7UsmO5aBlDNthdMWfjHp0IL4AwcrKfB3DJTqAYqt6UmNuZlRD/+0l3NDCxLRzoVDWvWeAEMGncjEtmOTZdqAa+8EdqPe2JeX1vJcS5rblOAmhkgK5h+ygLFQaTV6yAApiHS/weq0g7z4M7fffPBme0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052744; c=relaxed/simple;
	bh=8b72ipoMIKD74GuZI8suXpzuKlq/i4o9b7nPPUo2QT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQNcUVym4wd1q8qAVnZUG3ffXNcl3h2R4hj7B2sNMuW+nC2XyhDPLewUj+eHFVKuQz+EiWBPEAA10geTLW6bNn+3w/AmFKcjXOxBoFPse3o9903hPF9jeHLkj3xp9YFV7mzLREDjieg1V5oO7Vca1qdiUrn0ynTlPet9PfAEimE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEXWLy6O; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEXWLy6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769052742; x=1800588742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8b72ipoMIKD74GuZI8suXpzuKlq/i4o9b7nPPUo2QT4=;
  b=AEXWLy6OJaE8YMm0Y0h48YdFTwPgPKPzoeocBouLT9uvjyKUiIsDzhUh
   6ektDm5ib7H7vqzhEwBmS9Rw4JKmLlDcMp/RtKIj14hPrHCkHoIr7+et7
   m+WGdt+ZqEF2AtbhrhUm2E6AYGLFysA1piVvkySGolSf1MfovaDwOsEWW
   kdDKsQryd4hGPVByavtQ/RKaz/gRDsqDOcggRpgAAoPocA+7beOxyVi15
   GmxK0aNEbUrLiGO4SwIXRFWyXOSZmuK8wrzXYBgRyhO/whBU84CUMV5ow
   4YPE3wzE9M5QxjArY2YQuKPTY90h4g8zO3qiE/mOonFFqdVmIR9H/CR4R
   Q==;
X-CSE-ConnectionGUID: iMnEmLr6RV2kW+o1Gl940Q==
X-CSE-MsgGUID: 2jGv+43NTjuI8C77U3sCfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81734442"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81734442"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:32:18 -0800
X-CSE-ConnectionGUID: 4mAA2lI7StKInDH8nHv7pg==
X-CSE-MsgGUID: sPMVZWpGQSaO5yj559CS3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211064092"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa005.fm.intel.com with ESMTP; 21 Jan 2026 19:32:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	terry.bowman@amd.com
Subject: [PATCH 4/9] cxl/port: Move decoder setup before dport creation
Date: Wed, 21 Jan 2026 19:33:25 -0800
Message-ID: <20260122033330.1622168-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122033330.1622168-1-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are port setup actions that run on first dport arrival, and there are
setup actions that run per dport.

RAS register setup is a future additional setup action to run per-port
(once the first dport arrives), and each dport also has RAS registers to
map.

Before adding that, flip the order of "first dport" and "per-dport"
actions. This makes allocation symmetric with teardown, "first dport"
actions unwind after last dport removed. It also allows for using a devres
group to collect the unrelated decoder, RAS, and dport setup actions into
one group release action.

The new cxl_port_open_group() collects "first dport" and "per-dport" into
one group that can be released on any failure. This group's lifetime only
needs to span the short duration of cxl_port_add_dport() to cleanup all
potential damage from failing to add a dport. Contrast that to the "dport"
devres group that is called upon to destruct fully formed dport objects.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f2723bf948e2..f69395ea0c14 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1650,10 +1650,24 @@ static bool dport_exists(struct cxl_port *port, struct device *dport_dev)
 	return false;
 }
 
-DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
+static void *cxl_port_open_group(struct cxl_port *port)
+{
+	return devres_open_group(&port->dev, port, GFP_KERNEL);
+}
+
+/* note this implicitly casts @port_group back to its @port */
+DEFINE_FREE(cxl_port_release_group, struct cxl_port *,
+	    if (_T) devres_release_group(&_T->dev, _T))
+
+static void cxl_port_remove_group(struct cxl_port *port, void *port_group)
+{
+	devres_remove_group(&port->dev, port_group);
+}
+
 static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 					    struct device *dport_dev)
 {
+	struct cxl_dport *dport;
 	int rc;
 
 	device_lock_assert(&port->dev);
@@ -1664,14 +1678,13 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 	if (!port->dev.driver)
 		return ERR_PTR(-ENXIO);
 
-	struct cxl_dport *dport __free(del_cxl_dport) =
-		devm_cxl_add_dport_by_dev(port, dport_dev);
-	if (IS_ERR(dport))
-		return dport;
-
-	cxl_switch_parse_cdat(dport);
+	/* Temp group for all "first dport" and "per dport" setup actions */
+	void *port_group __free(cxl_port_release_group) =
+		cxl_port_open_group(port);
+	if (!port_group)
+		return ERR_PTR(-ENOMEM);
 
-	if (port->nr_dports == 1) {
+	if (port->nr_dports == 0) {
 		/*
 		 * Some host bridges are known to not have component regsisters
 		 * available until a root port has trained CXL. Perform that
@@ -1684,18 +1697,24 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		rc = devm_cxl_switch_port_decoders_setup(port);
 		if (rc)
 			return ERR_PTR(rc);
-		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
-			dport->port_id, dev_name(dport_dev));
-		return no_free_ptr(dport);
 	}
 
+	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
+	if (IS_ERR(dport))
+		return dport;
+
+	/* This group was only needed for early exit above */
+	cxl_port_remove_group(port, no_free_ptr(port_group));
+
+	cxl_switch_parse_cdat(dport);
+
 	/* New dport added, update the decoder targets */
 	device_for_each_child(&port->dev, dport, update_decoder_targets);
 
 	dev_dbg(&port->dev, "dport%d:%s added\n", dport->port_id,
 		dev_name(dport_dev));
 
-	return no_free_ptr(dport);
+	return dport;
 }
 
 static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
-- 
2.52.0

