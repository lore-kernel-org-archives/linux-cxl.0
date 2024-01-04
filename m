Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FD23747
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmVk+nRU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704384488; x=1735920488;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qR2cz9ZbpT7HmfL0Mx5nZZeZKyB3OJz+oACSzAOoeQE=;
  b=lmVk+nRULkDRufeSMe4eXvhRm8eWQ+io1mguY5PahFetCE5oKjavG0Jp
   ZcCUXJQMDLUhVPtd+yuFRieQcxHaF3r+vp0Tj9WdibIky+dWrwyTzkvVV
   EcXLb87O+1CLhK0aNgBcQ7R5iPVlyIg02oDHtr3irXW+TLezTJrCeyWpM
   pwx3dAAthU32N4H2ObUrJcWIF1Y4oimi9O6L7s6MzANRuXVcJLsyU33y7
   6MmLsQJ8em5p3RLfeXeqLebdC95en90KRsMkIbL1Ruq7gw7gQQfKn9c4b
   QLqfz4U/I2qO6eTZfulgs7eF8/EZp7r8GI9kvG4d5Mss2fsjCwBdFCice
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="18808639"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="18808639"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 08:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="783924430"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="783924430"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 08:08:06 -0800
Subject: [PATCH] cxl: Clarify root_port cleanup routine for
 cxl_qos_class_verify()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 04 Jan 2024 09:08:05 -0700
Message-ID: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The current __free() call for root_port in cxl_qos_class_verify() depends
on 'struct device' to be the first member of 'struct cxl_port' and calls
put_device() directly with the root_port pointer passed in. Add a helper
function put_cxl_port() to handle the put_device() properly and avoid
future issues if the 'struct device' member moves.

Suggested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index cd84d87f597a..d6e64570032f 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -345,11 +345,21 @@ static void discard_dpa_perf(struct list_head *list)
 }
 DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
 
+static void put_cxl_port(struct cxl_port *port)
+{
+	if (!port)
+		return;
+
+	put_device(&port->dev);
+}
+
+DEFINE_FREE(cxl_port, struct cxl_port *, put_cxl_port(_T))
+
 static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct cxl_port *root_port __free(put_device) = NULL;
+	struct cxl_port *root_port __free(cxl_port) = NULL;
 	LIST_HEAD(__discard);
 	struct list_head *discard __free(dpa_perf) = &__discard;
 	int rc;


