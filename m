Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2319440
	for <linux-cxl@vger.kernel.org>; Fri,  3 Nov 2023 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBYEtKb5"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F77D54
	for <linux-cxl@vger.kernel.org>; Fri,  3 Nov 2023 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699034809; x=1730570809;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i3LXyiPN/Gh/goX1sAwwmgDcpd9YtBMp8kh+zJkNXlA=;
  b=NBYEtKb5l9GwNF3gB3fTeosjHQr831uRojxiwia9uC+aG5Rlyda5NYic
   Lv7meTA5/61HOjWJpFRHmakTrg+N1u198FnAQJPI9NuGFGVf92GQkRpwL
   rmXfqF1Z1kndtvoaNi0vlW/Eo8aHZ34mkgEsFUiDU8/kkebKFbk/Q7I1H
   8DrOQrQCupDU0TQ3hLbbjbXg2iwKSyKllJm88QTdiypDd6m86GQqz/VCS
   DIXp1/O6nJcArhudMl8bKREg0E4PJBgbJkufQpJ7FbuSBud4/wMNLzzzP
   J9QbPqkKRFjwT2t6isNHoCgnQoJhBBnwE33XyBQot/e+n8TqL9J3yPEdJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="455484391"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="455484391"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 11:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="761698076"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="761698076"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.174.124])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 11:06:48 -0700
Subject: [PATCH v2] cxl: Add cxl_num_decoders_committed() usage to cxl_test
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com
Date: Fri, 03 Nov 2023 11:06:47 -0700
Message-ID: <169903480735.573043.9078564792792488687.stgit@djiang5-mobl3>
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
v2:
- Add missing changes, stg refresh foobar
---
 drivers/cxl/core/port.c      |    1 +
 tools/testing/cxl/test/cxl.c |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index b88546299902..f4e517a0c774 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -669,10 +669,11 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 		return 0;
 
 	dev_dbg(&port->dev, "%s commit\n", dev_name(&cxld->dev));
-	if (port->commit_end + 1 != id) {
+	if (cxl_num_decoders_committed(port) != id) {
 		dev_dbg(&port->dev,
 			"%s: out of order commit, expected decoder%d.%d\n",
-			dev_name(&cxld->dev), port->id, port->commit_end + 1);
+			dev_name(&cxld->dev), port->id,
+			cxl_num_decoders_committed(port));
 		return -EBUSY;
 	}
 


