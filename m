Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31081226895
	for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863047; cv=none; b=n/1XMIOSrLj/iyEDe5zOmuS88yvm9BiFbH7flTli4jcz3xWk68XQf3AMD8KkVasDYha8JfhLLOf6gejCPxuuCj20RSjUyBC50tK5fTz8X6kiMtxfKPdxBhNcvm7xcf9R+e8lEmTgXAdW9PobtYNrYaiNfZEQNX9QY589EXC4VJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863047; c=relaxed/simple;
	bh=3HwbTWhMYufOZq0hl8wnzOsmMo6nLRkZfM+ygxT2r1E=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=TJ4XLeoYnxt92EcM+MgzPfgRhqcm6FXqEYmi84Ph2/41SLeCXzdGs6eMdl/Kfq3ITqCuRy9yeIj1HghkQfW/3adL2nV+4yBgIbFolv6Bq21+1oxUKsc99oP7zChkMu3j2RcntAUjNdM0KM8yuY38Mntxzk7rKxxxubDYYeCas/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Su+SQ2iS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Su+SQ2iS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733863046; x=1765399046;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3HwbTWhMYufOZq0hl8wnzOsmMo6nLRkZfM+ygxT2r1E=;
  b=Su+SQ2iSQImRR1nJP+xwmYe49sXg4xZezatpqJ0UVFcTT5Qiz2FLtvww
   keZrPj1wd84b/W73RTM1d5APjODlzxv5ztM/6/OZIIBH0MP71d9/xfryO
   3CJ3DHMK920aCqBz9SsklecnpicdYdI9yj4K3rWGyLe8DvNf4ROx0+YNL
   Cet73xTbLJxyz91QQhet0FcezXcjwEw2I2i08oR1fFOi2y+lXL8Pi+xmn
   2zzsiCm2DZbQL3utnCNugspEafpBNOSc77IL4Kj2ZGsolCSVaVsozXSgK
   tyrxI2jDEH05RJsP2adXGFdYzzgqn1nJLZWGwuYODxzgck6fzdfT5ebs0
   A==;
X-CSE-ConnectionGUID: 4g2MUgrKS/6ORi4N8KgGLA==
X-CSE-MsgGUID: 7nyhXKLWQKWa7DmZmRVbFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34109863"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34109863"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:37:26 -0800
X-CSE-ConnectionGUID: +1z+fUQYR8+xOxoeQwG+7w==
X-CSE-MsgGUID: JdKykXCURkyZ3zWs746n1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="100572222"
Received: from kinlongk-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.210])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:37:25 -0800
Subject: [PATCH] cxl/mem: Hide RCD attributes when pre-requisites are missing
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: Li Ming <ming.li@zohomail.com>, alison.schofield@intel.com,
 linux-cxl@vger.kernel.org
Date: Tue, 10 Dec 2024 12:37:25 -0800
Message-ID: <173386304532.1383902.17130961308615551692.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

A recent change to avoid a NULL rcd_pcie_cap pointer consumption in
rcd_pcie_cap_emit() [1] arranged for the problematic sysfs attributes to
return an error on access. However, if the attributes always fail on
read they should simply be hidden.

Add a facility called @mem_groups that follows the same visibility rules
as the "dev_groups" of the cxl_mem driver. It is expressly for
PCI-device relative attributes, but that require the device to be
additionally connected to the CXL port topology.

Link: http://lore.kernel.org/20241129132825.569237-1-ming.li@zohomail.com
Cc: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c    |   14 +++++++++-----
 drivers/cxl/core/port.c      |    3 +++
 drivers/cxl/cxlmem.h         |    7 +++++--
 drivers/cxl/mem.c            |    8 ++++++++
 drivers/cxl/pci.c            |   21 +++++++++++++++++++--
 tools/testing/cxl/test/mem.c |    2 +-
 6 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 84fefb76dafa..7801bf64aafa 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -616,8 +616,10 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
-static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
-					   const struct file_operations *fops)
+static struct cxl_memdev *
+cxl_memdev_alloc(struct cxl_dev_state *cxlds,
+		 const struct file_operations *fops,
+		 const struct attribute_group **mem_groups)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -633,6 +635,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 		goto err;
 	cxlmd->id = rc;
 	cxlmd->depth = -1;
+	cxlmd->mem_groups = mem_groups;
 
 	dev = &cxlmd->dev;
 	device_initialize(dev);
@@ -1017,15 +1020,16 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+struct cxl_memdev *
+devm_cxl_add_memdev(struct device *host, struct cxl_dev_state *cxlds,
+		    const struct attribute_group **mem_groups)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
 	struct cdev *cdev;
 	int rc;
 
-	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
+	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops, mem_groups);
 	if (IS_ERR(cxlmd))
 		return cxlmd;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index af92c67bc954..a53f144bbac1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1397,6 +1397,7 @@ static void delete_endpoint(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct device *parent = cxlmd->dev.parent;
 	struct device *host = endpoint_host(endpoint);
 
 	scoped_guard(device, host) {
@@ -1407,6 +1408,8 @@ static void delete_endpoint(void *data)
 		}
 		cxlmd->endpoint = NULL;
 	}
+	if (sysfs_update_groups(&parent->kobj, cxlmd->mem_groups))
+		dev_info(parent, "CXL.mem sysfs attributes removed\n");
 	put_device(&endpoint->dev);
 	put_device(host);
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..9c5f2544da75 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -43,6 +43,7 @@
  * @cxl_nvb: coordinate removal of @cxl_nvd if present
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @endpoint: connection to the CXL port topology for this memory device
+ * @mem_groups: host device groups that change visibility based on cxl_mem attach
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
  */
@@ -54,6 +55,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
 	struct cxl_port *endpoint;
+	const struct attribute_group **mem_groups;
 	int id;
 	int depth;
 };
@@ -87,8 +89,9 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
+struct cxl_memdev *
+devm_cxl_add_memdev(struct device *host, struct cxl_dev_state *cxlds,
+		    const struct attribute_group **mem_groups);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a9fd5cd5a0d2..2d2a662c99d4 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -50,6 +50,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 {
 	struct cxl_port *parent_port = parent_dport->port;
 	struct cxl_port *endpoint, *iter, *down;
+	struct device *parent;
 	int rc;
 
 	/*
@@ -70,6 +71,13 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
 
+	parent = cxlmd->dev.parent;
+	rc = sysfs_update_groups(&parent->kobj, cxlmd->mem_groups);
+	if (rc) {
+		dev_err(parent, "CXL.mem sysfs attributes removed\n");
+		return rc;
+	}
+
 	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2cb81f6d9e7..7ad2fc42210e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -885,8 +885,25 @@ static umode_t cxl_rcd_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (is_cxl_restricted(pdev))
+	if (is_cxl_restricted(pdev)) {
+		struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
+		struct cxl_memdev *cxlmd = cxlds->cxlmd;
+		struct cxl_dport *dport;
+
+		if (!cxlmd->endpoint)
+			return 0;
+
+		struct cxl_port *root __free(put_cxl_port) =
+			cxl_mem_find_port(cxlmd, &dport);
+
+		if (!root)
+			return 0;
+
+		if (!dport->regs.rcd_pcie_cap)
+			return 0;
+
 		return a->mode;
+	}
 
 	return 0;
 }
@@ -993,7 +1010,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds, cxl_rcd_groups);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 71916e0e1546..cd294c9476ed 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1543,7 +1543,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 
 	cxl_mock_add_event_logs(&mdata->mes);
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds, NULL);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 

