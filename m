Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93440B6C0
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052749; cv=none; b=G9mjDZIhf9915DlnIwu0fFV9YotqrZv5kDRZl+q8TB6YqQx5QV5GAQqDYc7xuiXaR8aV7q0RZdSOLCe1uAmd/eCaeDqz/041rSy/YR8UtybvlX+cyw73SSc43c8YFbXuFBth3n0VCtMWwSXPwVZVgNnvUM/vMEtesvzqkNByJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052749; c=relaxed/simple;
	bh=fcgdkoHPJnV3nMMtxK0eKtquXhMnBJiRgGjIrSkbv8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpkkeAwkFLzV9dLbsCUGuxAyHZDeDe8VUA85qV6zXEwipzZ4teEXILfflQaNtDL6/nLeW1aH3QGCz4Z3VmerHvNczRxNTnOlH/PKsXBo9FVrc3mWPWVPnKcIkOcz0pl5VzbQhdYeGMqk/gKvEKcK23PUO7tpddluY5QJivwlq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRoluEfi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRoluEfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769052747; x=1800588747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fcgdkoHPJnV3nMMtxK0eKtquXhMnBJiRgGjIrSkbv8I=;
  b=eRoluEfiQfioA9r5P3w3kxwvdB6VWj170fmdP8yys6AUMeB5xkFJrIKN
   12n1Xbqv+Ppit2vnfnwxD2HwpT1NBNDYKFoyAjMBDpSwOnf6F2fZZwlSd
   C0e5SWyvQjC4L8lVzLZ/SlMAI8x96nf+dVYsYA7M9re8VDCZOMAlluPrp
   o/1YuAqUdFAu74Gs23P3ZbTS0KjrKQKvvD/ImzhNs6GvMpZGf+D8KDpcp
   u2Rkbx1TfQbLtFC/T+YIYD/6zCq2rLlkiA8A1Ljbklfs3qdBYeUhEJ13T
   5qOv99/yeINyjUG34co6tuVDwHUUQ/okH+PB32L0te5eYEdhzmVRIk0Vh
   Q==;
X-CSE-ConnectionGUID: g8H5YmZeRC6x4yIBU2i3Aw==
X-CSE-MsgGUID: tqdjfKsUQsyfMNrN5+xiLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81734468"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81734468"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:32:20 -0800
X-CSE-ConnectionGUID: 2IfLFf35R3SeUFtKUX2GbQ==
X-CSE-MsgGUID: jyYmYrLKQ021uHqArF7oRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211064121"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa005.fm.intel.com with ESMTP; 21 Jan 2026 19:32:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	terry.bowman@amd.com
Subject: [PATCH 9/9] cxl/port: Unify endpoint and switch port lookup
Date: Wed, 21 Jan 2026 19:33:30 -0800
Message-ID: <20260122033330.1622168-10-dan.j.williams@intel.com>
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

In support of generic CXL protocol error handling across various 'struct
cxl_port' types, update find_cxl_port_by_uport() to retrieve endpoint CXL
port companions from endpoint PCIe device instances.

The end result is that upstream switch ports and endpoint ports can share
error handling and eventually delete the misplaced cxl_error_handlers from
the cxl_pci class driver.

Reviewed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 436d9f8f65cb..446a97d48423 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1591,10 +1591,20 @@ static int match_port_by_uport(struct device *dev, const void *data)
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

