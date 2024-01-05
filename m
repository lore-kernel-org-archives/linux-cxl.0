Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F41854
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVmFjtcP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704417497; x=1735953497;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bglEbeQZSQXXIC/7SNQvwolDwsdqF3fEx33zsU+Jt7A=;
  b=bVmFjtcPzuqlX5qHRCkquBNN3ZzssdbInnR1lPs+YWsXUsPxK9wJwS5b
   5OcBIR1J5a85/5sZrT4p5XawIfjKOgUxYi8T7f3C8tD5owsmwd2SH40ay
   od1fO2UhddC3wpMHCBxCOr/A8+msT39355ERdXJ1OErgu9gQm4YtSUtXp
   Rh89S59SeVVXNVbKX8GXpunhTnkXLCbgAh69WXU6k4/fe5C8hE5W822qC
   WhW/4nnwq+6fmBH3tiCPa2SVsvr7cpq8uofeSymA6IZVbAfOfiBuySuJr
   m6vhqwwTiVlgyXljqcN8gxutTI3bdoUqsvd0TUKR2am9LvR5vBJy4pMIg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="463802180"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="463802180"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1027613261"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="1027613261"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:09 -0800
Subject: [PATCH v4 1/6] cxl: Introduce put_cxl_root() helper
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Thu, 04 Jan 2024 18:18:08 -0700
Message-ID: <170441748869.3632067.1712163433527825314.stgit@djiang5-mobl3>
In-Reply-To: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
References: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a helper function put_cxl_root() to maintain symmetry for
find_cxl_root() function instead of relying on open coding of the
put_device() in order to dereference the 'struct device' that happens via
get_device() in find_cxl_root(). Add cleanups for all code paths that
calls put_device() after find_cxl_root().

Suggested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Adjust ordering of this patch to front. (Dan)
v3:
- Adjust for cxl_root as parameter for find_cxl_root()
- Add NULL ptr check fore __free(). (Dan)
- Fix DEFINE_FREE() macro to name it put_cxl_root (Dan)
- Cleanup all functions calling put_cxl_root() and related calls. (Dan)

v2:
- Make put_cxl_root() an exported function to be symmetric to
  find_cxl_root(). (Robert)
---
 drivers/cxl/core/cdat.c |    5 +++--
 drivers/cxl/core/port.c |    9 +++++++++
 drivers/cxl/cxl.h       |    3 +++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index cd84d87f597a..c1085fcc5428 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -349,12 +349,13 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct cxl_port *root_port __free(put_device) = NULL;
 	LIST_HEAD(__discard);
 	struct list_head *discard __free(dpa_perf) = &__discard;
 	int rc;
 
-	root_port = find_cxl_root(cxlmd->endpoint);
+	struct cxl_port *root_port __free(put_cxl_root) =
+		find_cxl_root(cxlmd->endpoint);
+
 	if (!root_port)
 		return -ENODEV;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8c00fd6be730..f66650bb6128 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -986,6 +986,15 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
 
+void put_cxl_root(struct cxl_port *port)
+{
+	if (!port)
+		return;
+
+	put_device(&port->dev);
+}
+EXPORT_SYMBOL_NS_GPL(put_cxl_root);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 492dbf63935f..4e53604de041 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -735,6 +735,9 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
+void put_cxl_root(struct cxl_port *port);
+DEFINE_FREE(put_cxl_root, struct cxl_port *, if (_T) put_cxl_root(_T))
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);


