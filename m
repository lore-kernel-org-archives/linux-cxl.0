Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289BF1D6BB
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817773; cv=none; b=ERqowiqZF8cI9ZQvb3wvK0Q8oNsSmvB0K02N+KTtIb7YBPyk85Wm9vRHnkzEBQQsVumNGLW/OMkxpqeW03VgkKE0nvj+a7WsfJBxz7PblvvuenFUwSWERhBdaVyPy3cFGU4BoItX8UsRkjsAiAJEYxE4zBMDtc7vF9jWArSNoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817773; c=relaxed/simple;
	bh=UM4ctbGH4yiOTujBNf9oK7H/SMnCWLq3W7Brd+CEqEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIXiCCVAM0Zii6EAH4fSoAbh0R1gAQqGRLao6lQxhzRBgZpEwQOTbaUHDwoa9aSG7Jgo6k7s3h94TFqIknAzPF+35Nwoa2t3VSEi1E9uD9Uj5Ps5BJSZoTpx+4BvPrG+geigE5Erg+h7w0HwYkuOISLP2Wq5aMtIXrOH2r0I98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bu49MjNT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bu49MjNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817771; x=1801353771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UM4ctbGH4yiOTujBNf9oK7H/SMnCWLq3W7Brd+CEqEI=;
  b=bu49MjNTzPj7E5ixgpda1OE1tuIeM2uMyau4yPNeoNREe9wtBg3lmEnD
   FuM/sZJJTPRkJ69WWkofyKla9+LtxKlkNmsQmi7iRoH9/K2yPSGTMT6kn
   s7DZieH38LoMnUiMOM9Ri76uoMSpqKwYmos9aNT1M/qiah+mJG3csrj6W
   05X3Fh+iQCFedadhAUteipLLx+up42vtc2LCsmD67ZVcMAm7BgKOx63mJ
   VK9aKfFhNJCJ3YlYkPkwmKQaahCJbDV3KmKJX1sLzlOsKkYvo1XHZKHa6
   oh+4imett7z9AW6KEnQapRYfAAk1fzjc4dEWoMJGBjzmjg/yw16AzEs0/
   Q==;
X-CSE-ConnectionGUID: 5QcsSX1KScuzFzYvbCfA8g==
X-CSE-MsgGUID: erWH2CkfSAmOgxinyOX2Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71156894"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71156894"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:02:49 -0800
X-CSE-ConnectionGUID: oVLnN53YTAuslZeezGN2Mg==
X-CSE-MsgGUID: 9zvkGNy5SIensRgoYgarsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208093710"
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
Subject: [PATCH v2 1/9] cxl/port: Cleanup handling of the nr_dports 0 -> 1 transition
Date: Fri, 30 Jan 2026 16:03:55 -0800
Message-ID: <20260131000403.2135324-2-dan.j.williams@intel.com>
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Terry Bowman <terry.bowman@amd.com>
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

