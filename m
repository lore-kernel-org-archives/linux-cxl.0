Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936137A49B
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052742; cv=none; b=UGKc0oHkcYs6U645uHBSNZW+GhkuzO8orLFZA7sUjKew6E/LKR9gZsgTZrzKhrrOQgttY0sF3t3HK79CePraEqcr4NVyF6Cny4NJR3xsUA7DVX+RVEDMj2FXMWI3nUvTrjZ3qTJVVF/t9yW2DM7U+TMMFOMkADeeJI7UWtavgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052742; c=relaxed/simple;
	bh=T5Um5zWNhW0asWXrQNSd5UQzQ28ocEhjmO8LSik3PhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLtC6snbu474pg2hZC9c8vaGd0R9L6/MVm5ECpAzLvZTzt9a+4UBxrsyvhbjdHxbO86oDKXCmpae3XGZ7q84teW5JzQG3zxHpyp/oXuNm+CCObaZeeJZk1zk1do9b0XegvI7NPRmx9ZuRjQVfcFs+qLzhxGEgZOFRNZVZ8XiOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWdPmwbH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWdPmwbH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769052740; x=1800588740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T5Um5zWNhW0asWXrQNSd5UQzQ28ocEhjmO8LSik3PhA=;
  b=bWdPmwbHxqeXBPrt2B4qkI00kas+GP647stUaDT0IMKBPvi81lu2bviC
   ShNJEpRxcuM8srvPkUF5uaPcBUPUpU0joWQslvPcKSfoicEqP4RQg8vUc
   hXRsU7AEX6CmlxGUkWc0QF+MRPk473ZbhB69DpXCcssCrVXuCw++gu7yq
   WXm0QFHKGg61A+47383/R/ggDvpp8PZxt79896+cWD3tkpKdpcyTsw5zu
   T5HkqoDAK0n0cPqphpT1HiD2lQgjxV2557LUw4DOidZRYE5zEbVBuUoi3
   khSvQZiJ87W9VxSEaLocYBR4DNOhMmMCExn5AY1hbWbO5KcMlW9zsNfXR
   w==;
X-CSE-ConnectionGUID: lAWDv9PMT5+4M1WISwwgqw==
X-CSE-MsgGUID: i+tRTAK0RiKUsY2ge2MWnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81734430"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81734430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:32:18 -0800
X-CSE-ConnectionGUID: Y7LiUr4wRqeCFninjOQfLg==
X-CSE-MsgGUID: A/lr10g6RdqG55WfMM4ZqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211064074"
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
Subject: [PATCH 1/9] cxl/port: Cleanup handling of the nr_dports 0 -> 1 transition
Date: Wed, 21 Jan 2026 19:33:22 -0800
Message-ID: <20260122033330.1622168-2-dan.j.williams@intel.com>
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

There are multiple setup actions that can occur for a switch port after it
is known that it has at least one active downstream link. That work is
currently split between __devm_cxl_add_dport(), the add_dport() helper, and
cxl_port_add_dport() where decoder setup occurs.

Clean this up by moving all @dport object setup responsibilities into
add_dport() and all port effects into cxl_port_add_dport().

add_dport() handles taking a reference on @dport->dport_dev, and
cxl_port_add_dport() grows the awareness to setup the port component
registers. This removes an awkward open-coded xa_erase() from the middle of
__devm_cxl_add_dport() and instead tasks cxl_port_add_dport() with calling
the common @dport destruction path if anything goes wrong.

After this @port->nr_dports is always the count of @dports in the
@port->dports xarray, and cxl_dport_remove() is symmetric with add_dport().
With ->nr_dports now reliably tracking the number of dports the use of
ida_is_empty() can be dropped. Recall that the ida is only cleared on
"release" of decoder objects, and release can be arbitrarily delayed past
unregistration.

Lastly port->component_reg_phys is no longer reset to CXL_RESOURCE_NONE
post setup, no reason is seen to carry that forward.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fef3aa0c6680..ff899c690d85 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1066,11 +1066,15 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
 		return -EBUSY;
 	}
 
+	/* Arrange for dport_dev to be valid through remove_dport() */
+	struct device *dev __free(put_device) = get_device(dport->dport_dev);
+
 	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
 		       GFP_KERNEL);
 	if (rc)
 		return rc;
 
+	retain_and_null_ptr(dev);
 	port->nr_dports++;
 	return 0;
 }
@@ -1099,6 +1103,7 @@ static void cxl_dport_remove(void *data)
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
+	port->nr_dports--;
 	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
 	put_device(dport->dport_dev);
 }
@@ -1181,21 +1186,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
-	/*
-	 * Setup port register if this is the first dport showed up. Having
-	 * a dport also means that there is at least 1 active link.
-	 */
-	if (port->nr_dports == 1 &&
-	    port->component_reg_phys != CXL_RESOURCE_NONE) {
-		rc = cxl_port_setup_regs(port, port->component_reg_phys);
-		if (rc) {
-			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
-			return ERR_PTR(rc);
-		}
-		port->component_reg_phys = CXL_RESOURCE_NONE;
-	}
-
-	get_device(dport_dev);
 	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
 	if (rc)
 		return ERR_PTR(rc);
@@ -1622,7 +1612,16 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 
 	cxl_switch_parse_cdat(new_dport);
 
-	if (ida_is_empty(&port->decoder_ida)) {
+	if (port->nr_dports == 1) {
+		/*
+		 * Some host bridges are known to not have component regsisters
+		 * available until a root port has trained CXL. Perform that
+		 * setup now.
+		 */
+		rc = cxl_port_setup_regs(port, port->component_reg_phys);
+		if (rc)
+			return ERR_PTR(rc);
+
 		rc = devm_cxl_switch_port_decoders_setup(port);
 		if (rc)
 			return ERR_PTR(rc);
-- 
2.52.0

