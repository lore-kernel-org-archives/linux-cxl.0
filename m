Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4F63A9
	for <linux-cxl@vger.kernel.org>; Fri, 15 Dec 2023 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGX+Z2F3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702617921; x=1734153921;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y+ZFiivg57dnigPOM9B8cvl7jWzfd2meRnTd84syCQ8=;
  b=eGX+Z2F3t8AprG46Ix4GiI9EYwYJVLFnddG1L3rXQArvDOjTeMCGpt9S
   PCjGctkodVwxU2sW/v6qpyOgy/1JLgpj5YhKkJeUMK5zHbUTdo5uqmIqn
   0Q5DxKsVvuUinhDDJzl/dolUWAC4Vrl2PAuhSKoeVXnIQrDlKo27GSWn0
   WNQHcAvsIvj5oNPUGb0ERzjQvJC/o42iOf1+SFJ3fxwOU1oXCsPjDmK93
   LQJ1KT0t6iKeL6tH63atSSsMN0SnSao3iTL70BXpTFpcQc/XHMLHedo4E
   79nCK7H9/j7uN9YIYFlFXJ3YBaaOedeGIMU7E+eRCSBfFk6dmZ8mXb6ul
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="13918200"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="13918200"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 21:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840544546"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="840544546"
Received: from olsontx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.83.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 21:25:19 -0800
Subject: [PATCH] cxl/pci: Kill a goto in read_cdat_data()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>
Date: Thu, 14 Dec 2023 21:25:19 -0800
Message-ID: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Given there was already one bug here around passing the wrong value in
the cleanup path, remove the goto with the use of the __free() helper.
Note that since the cleanup helper only passes a single pointer as an
argument the auto @tbl variable needs to also include the @dev argument
to devm_kfree().

The open coded math to shift the port->cdat.table to the relevant part
of the response buffer is saved to a follow-on patch to cleanup.

The "devm_buf" scheme can maybe move to include/linux/device.h one day,
but the expectation of using devm_kfree() in an error path for the same
function that performed the allocation is a rare pattern. Many
devm_kfree() usages are at object mid-life or end-of-life time, not init
paths.

Cc: Robert Richter <rrichter@amd.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 37e1652afbc7..dd938a60a2de 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -606,6 +606,12 @@ static unsigned char cdat_checksum(void *buf, size_t size)
 	return sum;
 }
 
+struct devm_buf {
+	struct device *dev;
+	void *p;
+};
+DEFINE_FREE(devm, struct devm_buf, if (_T.p) devm_kfree(_T.dev, _T.p))
+
 /**
  * read_cdat_data - Read the CDAT data on this port
  * @port: Port to read data from
@@ -614,13 +620,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
+	struct devm_buf rsp __free(devm) = { .dev = &port->dev };
 	struct device *uport = port->uport_dev;
 	struct device *dev = &port->dev;
 	struct pci_doe_mb *cdat_doe;
 	struct pci_dev *pdev = NULL;
 	struct cxl_memdev *cxlmd;
 	size_t cdat_length;
-	void *cdat_table, *cdat_buf;
 	int rc;
 
 	if (is_cxl_memdev(uport)) {
@@ -651,26 +657,19 @@ void read_cdat_data(struct cxl_port *port)
 		return;
 	}
 
-	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
-	if (!cdat_buf)
+	rsp.p = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
+	if (!rsp.p)
 		return;
 
-	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
+	rc = cxl_cdat_read_table(dev, cdat_doe, rsp.p, &cdat_length);
 	if (rc)
-		goto err;
+		return;
 
-	cdat_table = cdat_buf + sizeof(__le32);
-	if (cdat_checksum(cdat_table, cdat_length))
-		goto err;
+	if (cdat_checksum(rsp.p + sizeof(__le32), cdat_length))
+		return;
 
-	port->cdat.table = cdat_table;
+	port->cdat.table = no_free_ptr(rsp.p) + sizeof(__le32);
 	port->cdat.length = cdat_length;
-	return;
-
-err:
-	/* Don't leave table data allocated on error */
-	devm_kfree(dev, cdat_buf);
-	dev_err(dev, "Failed to read/validate CDAT.\n");
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 

