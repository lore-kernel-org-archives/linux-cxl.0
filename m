Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727B2D021
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7abZKLi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704409262; x=1735945262;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sEuN6K6nGBXCRWcwmHZrbYhXKye2NqPXk5QGB/syBDY=;
  b=U7abZKLiaf59wEzJYYvaQMju7be3mVR5/8RNvQ4PhuiS9tH7kFqXpqAV
   KdTyWaj9wlqzmT7NWVcLhCwPTzWzZg9C2U/41ITamt+Wfvkic+5j8RCyo
   eE3IoFkWHMn5+za2RcoW/hiq2z+mvG+HRZtYbvA3oTaz8yE5rRffd7FH1
   lNz2Z2jD+WIhCYxgi7Edy93JATc2J6YmfmU8ysgPzNu9xcp1jxOLFrfcg
   lkt6azwoz/OoD4KjfNWyuuTNpe3DNM3pMHeVtxUt2YRkIR/VPvpwuAKTf
   rR9kq4/0yGiLhZXRpeJiGGWhzRYxMeSboV8vrbdbfo0DD5h7wWTZuCsNq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387831554"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="387831554"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="846392358"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="846392358"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:01:01 -0800
Subject: [PATCH v3 4/4] cxl: Introduce put_cxl_root() helper function to have
 symmetry of find_cxl_root()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Thu, 04 Jan 2024 16:01:00 -0700
Message-ID: <170440926084.3570725.9962332024836108779.stgit@djiang5-mobl3>
In-Reply-To: <170440924347.3570725.6271367271629367301.stgit@djiang5-mobl3>
References: <170440924347.3570725.6271367271629367301.stgit@djiang5-mobl3>
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
 drivers/cxl/core/pmem.c |    4 ++--
 drivers/cxl/core/port.c |    9 +++++++++
 drivers/cxl/cxl.h       |    3 +++
 drivers/cxl/port.c      |    2 +-
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 280ca1508f21..260cf2d621cd 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -173,7 +173,8 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 		return rc;
 	}
 
-	struct cxl_root *cxl_root __free(put_device) = find_cxl_root(port);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+
 	if (!cxl_root)
 		return -ENODEV;
 
@@ -354,7 +355,7 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 	struct cxl_port *root_port;
 	int rc;
 
-	struct cxl_root *cxl_root __free(put_device) =
+	struct cxl_root *cxl_root __free(put_cxl_root) =
 		find_cxl_root(cxlmd->endpoint);
 
 	if (!cxl_root)
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index da92a901b9e8..df3d11257511 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -64,7 +64,8 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 {
-	struct cxl_root *cxl_root = find_cxl_root(cxlmd->endpoint);
+	struct cxl_root *cxl_root __free(put_cxl_root) =
+		find_cxl_root(cxlmd->endpoint);
 	struct cxl_port *port;
 	struct device *dev;
 
@@ -73,7 +74,6 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 
 	port = &cxl_root->port;
 	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
-	put_device(&port->dev);
 
 	if (!dev)
 		return NULL;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b8af09464363..63a4e3c2baed 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -986,6 +986,15 @@ struct cxl_root *find_cxl_root(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
 
+void put_cxl_root(struct cxl_root *cxl_root)
+{
+	if (!cxl_root)
+		return;
+
+	put_device(&cxl_root->port.dev);
+}
+EXPORT_SYMBOL_NS_GPL(put_cxl_root, CXL);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8f43a06c4f72..3a5004aab97a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -735,6 +735,9 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
 struct cxl_root *find_cxl_root(struct cxl_port *port);
+void put_cxl_root(struct cxl_root *cxl_root);
+DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 656f2e03d2ea..27b7b45476e3 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -130,7 +130,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * This can't fail in practice as CXL root exit unregisters all
 	 * descendant ports and that in turn synchronizes with cxl_port_probe()
 	 */
-	struct cxl_root *cxl_root __free(put_device) = find_cxl_root(port);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 
 	if (!cxl_root)
 		return -ENODEV;


