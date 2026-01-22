Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421E3F0757
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052744; cv=none; b=Msc+oz85gU8oXLDS3+7dFfNkpDFvn6wdVmDGmQpYugyCKeBaEOdEpfXAClsErtLq4ClvbNC8H64kEekTt5tXe2rT8f5DJW2NSU1VpA6QyKx2LB7P9CIqubvm8kasnkU33MLH2jbfqDaENsxjMvrDff7b2qVysHJF9hxhbIScD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052744; c=relaxed/simple;
	bh=C+g63El3JiQXbyXFIScABmfp9o/Ewpeis2TsGmTFjk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t56EUstZx6Dtpd0yF7GkTliv4pXa57MdBQRCcT42n7o9t5Wpr2kTT54zjw9VcTuGxeuJ4rn+0zVIChIMmfMb5d7hlwzTmXcuGES5PnDhtXDhtXAWue7HeyfQojT2plAnAiUL7xPOtheKrirrP1Zaw9GzU9MfrZTWlU06j6rGJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sp45uNK+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sp45uNK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769052743; x=1800588743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C+g63El3JiQXbyXFIScABmfp9o/Ewpeis2TsGmTFjk4=;
  b=Sp45uNK+JFFywNlnlw/aK5RretmdKlYY+X8nrfu65glIHtR+Yc3zA6tP
   BinrmGqd2iEDgfFHrlprTg7WBzaR90SymIN+nWGOqpCj5yN1KiH/OEXxt
   ZgVTCkEmzXARZ08o6HdF53TSO9UjqUvjojbJy/G41E8VtgsExpI0E9fGF
   8C8S4f1r5CEK+CEcN9pIlXLOayBpy5Gswv0nzJsZRVjYxagp2EaykS8xm
   Ww+G1XNeYwL5/olYa4xPGlhL0AMuaTFoNNB3DHqs+1mkcSrdCUBEaAkAt
   rlYhc0uuD2IAcXH4AGixWg5RijpN796s4y4ZLTFhRIz8pKhL9xybDYUMM
   g==;
X-CSE-ConnectionGUID: GOLWrm2mRNKkX14RxOXqpw==
X-CSE-MsgGUID: OtNQVwldRraFeVZUuGQdmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81734434"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81734434"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:32:18 -0800
X-CSE-ConnectionGUID: eUmguyXKT5mQ8CroMcrhpw==
X-CSE-MsgGUID: LtC5MOA8TU+Xg6leaylCDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211064080"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa005.fm.intel.com with ESMTP; 21 Jan 2026 19:32:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	terry.bowman@amd.com
Subject: [PATCH 2/9] cxl/port: Reduce number of @dport variables in cxl_port_add_dport()
Date: Wed, 21 Jan 2026 19:33:23 -0800
Message-ID: <20260122033330.1622168-3-dan.j.williams@intel.com>
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

In preparation for refactoring cxl_port_add_dport() to add RAS register
setup, cleanup the number of dport variables with a dport_exists() helper.

Kill the @dport needed to check for duplicates, rename @new_dport to
@dport.

Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Closes: http://lore.kernel.org/20260116150119.00003bbd@huawei.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ff899c690d85..1637e97f6805 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1587,30 +1587,39 @@ static int update_decoder_targets(struct device *dev, void *data)
 	return 0;
 }
 
+static bool dport_exists(struct cxl_port *port, struct device *dport_dev)
+{
+	struct cxl_dport *dport = cxl_find_dport_by_dev(port, dport_dev);
+
+	if (dport) {
+		dev_dbg(&port->dev, "dport%d:%s already exists\n",
+			dport->port_id, dev_name(dport_dev));
+		return true;
+	}
+
+	return false;
+}
+
 DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
 static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 					    struct device *dport_dev)
 {
-	struct cxl_dport *dport;
 	int rc;
 
 	device_lock_assert(&port->dev);
-	if (!port->dev.driver)
-		return ERR_PTR(-ENXIO);
 
-	dport = cxl_find_dport_by_dev(port, dport_dev);
-	if (dport) {
-		dev_dbg(&port->dev, "dport%d:%s already exists\n",
-			dport->port_id, dev_name(dport_dev));
+	if (dport_exists(port, dport_dev))
 		return ERR_PTR(-EBUSY);
-	}
 
-	struct cxl_dport *new_dport __free(del_cxl_dport) =
+	if (!port->dev.driver)
+		return ERR_PTR(-ENXIO);
+
+	struct cxl_dport *dport __free(del_cxl_dport) =
 		devm_cxl_add_dport_by_dev(port, dport_dev);
-	if (IS_ERR(new_dport))
-		return new_dport;
+	if (IS_ERR(dport))
+		return dport;
 
-	cxl_switch_parse_cdat(new_dport);
+	cxl_switch_parse_cdat(dport);
 
 	if (port->nr_dports == 1) {
 		/*
@@ -1626,17 +1635,17 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		if (rc)
 			return ERR_PTR(rc);
 		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
-			new_dport->port_id, dev_name(dport_dev));
-		return no_free_ptr(new_dport);
+			dport->port_id, dev_name(dport_dev));
+		return no_free_ptr(dport);
 	}
 
 	/* New dport added, update the decoder targets */
-	device_for_each_child(&port->dev, new_dport, update_decoder_targets);
+	device_for_each_child(&port->dev, dport, update_decoder_targets);
 
-	dev_dbg(&port->dev, "dport%d:%s added\n", new_dport->port_id,
+	dev_dbg(&port->dev, "dport%d:%s added\n", dport->port_id,
 		dev_name(dport_dev));
 
-	return no_free_ptr(new_dport);
+	return no_free_ptr(dport);
 }
 
 static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
-- 
2.52.0

