Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0043ABC
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817777; cv=none; b=XKih2jv5+Sog5RDrlAUgCyqunQId2oJs/4JJCYE7tZtmv6I2R1odCXgOGY2QI33+Tzp5fyahm0dBy5ufhVMFr8WLZLKOxgWmjo4qdV5tswizAfte2hAYk8U8FpMQRjwHnaMV45888E9+YrFrvYudnL+jedMloWyble9u0Dl6DHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817777; c=relaxed/simple;
	bh=K3kIFLpnL2RTtOKikosZpO/EnZJCXrrazJIfwMK5fmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3FDCDOzqqrTm7mq5KHPJl5EZN8BsS/jgbPeOah/27bIixE1yR6WL6vGUgXrP62xX5Kqw0VpPZI3RGsfCTSYoYz4zOfLMvAOGCcXKSu/49VwyOb3BCeKaS7eS20UmQ3SxdvWAGZrkavtMkDy1RcVhk9OYRISElj8AuIMtlUqN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMP2lI2o; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMP2lI2o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817776; x=1801353776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3kIFLpnL2RTtOKikosZpO/EnZJCXrrazJIfwMK5fmk=;
  b=NMP2lI2oYBS9eLmTd2hqzTIPHolVe2jmmNOlvjVVZUFBuxh4e7PLHL9u
   8apYzEUGO3dqCl9REMvD1iEuinshvTLx+XV8EsD9A3cHZZzAQX+MBvIim
   mhKMD45b2hR0pGVCQOI6hjK75gijnTJnJoDowwrGE5NTWlFOg48y9FITW
   MrEEIuYzCdbrFNWci7RJr9xBrg1I7PI/PaNezAhbF9xbfC+BGfoall7QO
   Ji3X36o0Rw10MnOGYlYqlSblNakanjhySJruio88X6I0RFKjU1gxx/dRf
   Q4oVqFESh/9/fC3O5VsCQtwnyW7yHVUasCIs4W7QF6MwOo6XCU/g76RCc
   Q==;
X-CSE-ConnectionGUID: V2JV0nwpQj+H+BS2/NAgdQ==
X-CSE-MsgGUID: /TOZyKVgQja0yOUnQsFvdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71156924"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71156924"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:02:50 -0800
X-CSE-ConnectionGUID: MsekvHEDRKyRp8sIOifMGw==
X-CSE-MsgGUID: 7DqsNQFTSICknimESL9Kqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208093736"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa006.jf.intel.com with ESMTP; 30 Jan 2026 16:02:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	alison.schofield@intel.com,
	dave.jiang@intel.com,
	terry.bowman@amd.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 9/9] cxl/port: Unify endpoint and switch port lookup
Date: Fri, 30 Jan 2026 16:04:03 -0800
Message-ID: <20260131000403.2135324-10-dan.j.williams@intel.com>
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

In support of generic CXL protocol error handling across various 'struct
cxl_port' types, update find_cxl_port_by_uport() to retrieve endpoint CXL
port companions from endpoint PCIe device instances.

The end result is that upstream switch ports and endpoint ports can share
error handling and eventually delete the misplaced cxl_error_handlers from
the cxl_pci class driver.

Reviewed-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9f56f7e75e81..ee7d14528867 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1590,10 +1590,20 @@ static int match_port_by_uport(struct device *dev, const void *data)
 		return 0;
 
 	port = to_cxl_port(dev);
+	/* Endpoint ports are hosted by memdevs */
+	if (is_cxl_memdev(port->uport_dev))
+		return uport_dev == port->uport_dev->parent;
 	return uport_dev == port->uport_dev;
 }
 
-/*
+/**
+ * find_cxl_port_by_uport - Find a CXL port device companion
+ * @uport_dev: Device that acts as a switch or endpoint in the CXL hierarchy
+ *
+ * In the case of endpoint ports recall that port->uport_dev points to a 'struct
+ * cxl_memdev' device. So, the @uport_dev argument is the parent device of the
+ * 'struct cxl_memdev' in that case.
+ *
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-- 
2.52.0

