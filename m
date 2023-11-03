Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630A18626
	for <linux-cxl@vger.kernel.org>; Fri,  3 Nov 2023 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUf1IVXW"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C45ED42
	for <linux-cxl@vger.kernel.org>; Fri,  3 Nov 2023 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699034359; x=1730570359;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ff70vid5UZ5vfChQD+3pAnSYqimTWhLczy5QWEiXrmg=;
  b=bUf1IVXWGnVvXtLtmIvDSp+/mZpHM6+h8zuB1nBSTeMZSV24wwpfY31w
   ASiUSbggm2xTXfQSfEKc2CquoCm7BxBugxkBHQjUJ17RIB8xolqLtdZQd
   FJJt+wlPeHLIrGUnz6VAbrupCEwS7DLEQl8ovV5pebobO0sY9GoemqWzY
   w09HPtV3vGqI+X72HukL3D1ZPkcaWDerLI/2MkR2S8xV6KqOUIVNojgeu
   +FXdaK1eC0zMaiEq02qhzARKGSI+J2OH1l3JC031jW1Z8ZH5WXeYWW8vb
   aq39cO+kdo3pT8kh+c0B9xxD4JGfHgx0LrhtA0Nebko9lPVPZ2MT0jqHs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="368333680"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="368333680"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:59:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="9812539"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.174.124])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:59:18 -0700
Subject: [PATCH] cxl: Add cxl_num_decoders_committed() usage to cxl_test
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com
Date: Fri, 03 Nov 2023 10:59:17 -0700
Message-ID: <169903435790.565298.13848186970380289757.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper") missed the
conversion for cxl_test. Add usage of cxl_num_decoders_committed() to
replace the open coding.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c      |    1 +
 tools/testing/cxl/test/cxl.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 38441634e4c6..26d17c205408 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -43,6 +43,7 @@ int cxl_num_decoders_committed(struct cxl_port *port)
 
 	return port->commit_end + 1;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, CXL);
 
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index b88546299902..f42ec896962a 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -669,7 +669,7 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 		return 0;
 
 	dev_dbg(&port->dev, "%s commit\n", dev_name(&cxld->dev));
-	if (port->commit_end + 1 != id) {
+	if (cxl_num_decoders_committed(port) != id) {
 		dev_dbg(&port->dev,
 			"%s: out of order commit, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end + 1);


