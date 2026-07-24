Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A54413795
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932090; cv=none; b=FkAajmtekunlAKB63frKLTOqDlDW9qKBFlukx0qZX4P0dqZAda0VNipUrulis2HBkSCDWQbwPFG9XUbBGkikc3H/OH5BnM1j/zA8L+c8moNr6J5iNMHRiwbYBKcWeUZcCQKqttKCR6A+f2Jqe02Pnf6WPVMlPpwzzvmR+UoVsWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932090; c=relaxed/simple;
	bh=8leG6+f9TvI1Dx33i2UWRlmEizKLaKljgwny4XvC28c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7k9M/AWcw4JsMX/L4cEu9mM824EQ0IuvzrFQ8fqouTEvVSfuuD0hs+9hiPqhf2BX4wfJeyNqFqxWGjWFkq1OY5fa4cyt83okn8riDEkY4fGCE6TO8XyDwLpLQQF/U7zkHHqHwuvb6RoFcSII2x6u8G3rJsI3HLURSwAhkt/Seg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhOqyxg/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhOqyxg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784932088; x=1816468088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8leG6+f9TvI1Dx33i2UWRlmEizKLaKljgwny4XvC28c=;
  b=XhOqyxg/zuvu1BQMm3rZInldWdy7J3BkSA/Z6eGYcUNRJhwtQHEz5mdP
   UE7cCPcBR/scJfQDZLPM5YFyIxojxvyyojoV1GMyQ3yG+b3naRIm3LS9Y
   8SXKkjJSsbkTbh2Gxs8pvqCZQRV+dkNQrCKNweswCQ27texQ6YYjJNStn
   8e0AUMuD6E/6quS7UYqk0f9w00qVrkc9CoufruOanMFr0jrW5jz1vQ4Ib
   xR6bfSGS7UC6NQw+wmtWimXJlNor+NDNWfggH0cYKfmoxkXD2xCtonF0c
   RHA+54jMo1GotTxDVkXLKrkLx+hP1jeZkeQJoni+sTd5nQzrMw1wK6u/e
   A==;
X-CSE-ConnectionGUID: 46xe055TS0OIMqcC/qgvtg==
X-CSE-MsgGUID: qKMePIP2Rly8yCpkPs+05w==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85547904"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85547904"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 15:28:08 -0700
X-CSE-ConnectionGUID: +aI4aozPSYG08BZSdCPsQQ==
X-CSE-MsgGUID: vKHJ1sr9QI2qF+qElgRyqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="297052662"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.232])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 15:28:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 2/2] cxl/region: Use __free(put_device) in find_pos_and_ways()
Date: Fri, 24 Jul 2026 15:28:02 -0700
Message-ID: <550db1771b3d30277988d3e575f1a6893a26b0ae.1784931354.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <10deb519b543ef693ce23148b509a03fe1c07d0c.1784931354.git.alison.schofield@intel.com>
References: <10deb519b543ef693ce23148b509a03fe1c07d0c.1784931354.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __free(put_device) for the switch decoder reference returned by
device_find_child() instead of releasing it with an open-coded
put_device().

This matches the scoped device reference handling used elsewhere in
the file.

Suggested-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v3:
- Declare and assign dev in one statement per cleanup.h (Jonathan)
Changes in v2:
- New patch

 drivers/cxl/core/region.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d902e1c4161..904e80e89206 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1913,15 +1913,14 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 {
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
-	struct device *dev;
 	int rc = -ENXIO;
 
 	parent = parent_port_of(port);
 	if (!parent)
 		return rc;
 
-	dev = device_find_child(&parent->dev, range,
-				match_switch_decoder_by_range);
+	struct device *dev __free(put_device) =
+		device_find_child(&parent->dev, range, match_switch_decoder_by_range);
 	if (!dev) {
 		dev_err(port->uport_dev,
 			"failed to find decoder mapping %#llx-%#llx\n",
@@ -1944,8 +1943,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 			dev_name(&port->dev),
 			dev_name(port->parent_dport->dport_dev), dev_name(dev));
 
-	put_device(dev);
-
 	return rc;
 }
 
-- 
2.37.3

