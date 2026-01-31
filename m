Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90302556E
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817773; cv=none; b=r2+LOKtoBPn1pSbYpW6nvv68stBBVKfpVnA5Zg1SFrRrNRVlGl9SOHovZy7M3mrQ1sHJKhg5RCsDY/KFZ4eSYXPBCQuOlq/pMxm74fl0w/EEhOGtSET0cdXfjz/6j0nVdUP/iUVgzJFvnBTSPWsoPrqWtYJT37oReB7pn/dn3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817773; c=relaxed/simple;
	bh=WHhRSTsxXlLSfBsjJSa4E/QulnHoOVm2nUDdUr8Vtdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqkthUiPr0kd8EfkyI2QeBN1VCi5q5oFnZt2+6suIxSPmIlrzP0jf/c9j0LCAeVuP3w+xl587Rb/bz3EKawF7nQRZIR648PrBXfKp5C7F0g4B4FGpsLuaUvkywozNQkaqxWp/9PZ9aBmHpmLBtDrdg0Xzgx27SLEAmXy3BMv8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJ6pZhUe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJ6pZhUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817771; x=1801353771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WHhRSTsxXlLSfBsjJSa4E/QulnHoOVm2nUDdUr8Vtdc=;
  b=WJ6pZhUeOTEcfELoOtCIaZv8igH47NQBj4tyDKXbJwL6BaPX1KuFSa7m
   APFlK7a6dThndaZtf1uasYLhxaBRkslq8Gb7Wr5xPJOcbIUqDHlBTeNm8
   2laM3sgg4WqVzS80J3wBzlBBtT3BXot7igdeh+ohVeorHL3VOQhschFeU
   iMaUj0THP2WL0t9JG5NuB7oXSeJDxa9gGSh8rgH8GFVcgs5zJs6m9aGza
   W6nyTI2L/Z78QWdGE1/g+FgiRNUb14tRZnSS0B6A+oCQB1qi2KGJOcw34
   AhWLUgO96sOLXiihn6Ql7NjkTm/s6MrUIbYXHRZKXUoTXEZigzKGIb0ql
   w==;
X-CSE-ConnectionGUID: jefRnud2RH68eEJ7S1uGbw==
X-CSE-MsgGUID: Azah8ixeRqqKE11c6CAnQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71156899"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71156899"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:02:49 -0800
X-CSE-ConnectionGUID: QyNz3XGaTm+3Ij7zzM1QyA==
X-CSE-MsgGUID: uD95TyDST4OlwPwZHrxRGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208093713"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa006.jf.intel.com with ESMTP; 30 Jan 2026 16:02:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	alison.schofield@intel.com,
	dave.jiang@intel.com,
	terry.bowman@amd.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 2/9] cxl/port: Reduce number of @dport variables in cxl_port_add_dport()
Date: Fri, 30 Jan 2026 16:03:56 -0800
Message-ID: <20260131000403.2135324-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131000403.2135324-1-dan.j.williams@intel.com>
References: <20260131000403.2135324-1-dan.j.williams@intel.com>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ff899c690d85..d7b6f52d0adc 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1587,30 +1587,38 @@ static int update_decoder_targets(struct device *dev, void *data)
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
 	if (!port->dev.driver)
 		return ERR_PTR(-ENXIO);
 
-	dport = cxl_find_dport_by_dev(port, dport_dev);
-	if (dport) {
-		dev_dbg(&port->dev, "dport%d:%s already exists\n",
-			dport->port_id, dev_name(dport_dev));
+	if (dport_exists(port, dport_dev))
 		return ERR_PTR(-EBUSY);
-	}
 
-	struct cxl_dport *new_dport __free(del_cxl_dport) =
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
@@ -1626,17 +1634,17 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
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

