Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D091876
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifCx8T7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704417502; x=1735953502;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VnVuwFMPi7OnCPXq7ErryhpmMyExxcFExv/HaPYgKm0=;
  b=ifCx8T7yhMoXSZICylaELcqqmjon8VkanIXxOVi1JXizTHyL/lBzW/nU
   THbw7vw3Eef3apOfwkrryv59PqTFCIarUr9N23SLuBH7gBfsmtyKugj1A
   +x2/N4qlZyFlPQmeVkenAJhtFt4DBQ6ezdKy8te377V9Mo3eZ16mpPuso
   53uO/j0gA34wMoKRpmFb5/CXPLmBYwP7OtAqJcEd3Oc02YsqVn//cud+Y
   NmHyv+HaTAbNqH7LtylbFjgx961lKERHpLMyCVch/9iKcWrlPqadJ6mRL
   9EliDJyaNZHoqFn7+LaNMpJ4AvaXBbY8y81ZwUO5LzCzLIphMLpampUgd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="463802239"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="463802239"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1027613342"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="1027613342"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:20 -0800
Subject: [PATCH v4 3/6] cxl: Convert qos_class() to use 'struct cxl_root *'
 directly
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Thu, 04 Jan 2024 18:18:20 -0700
Message-ID: <170441750038.3632067.659502106120894365.stgit@djiang5-mobl3>
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

->qos_class() is expected to take a 'struct cxl_root *' instead of a
'struct cxl_port *'. Convert to directly accepting a 'struct cxl_root *'
to ensure that the root port device is passed in.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/acpi.c      |    6 ++----
 drivers/cxl/core/cdat.c |    2 +-
 drivers/cxl/cxl.h       |   12 ++++++------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index afc712264d1c..dcf2b39e1048 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -295,14 +295,12 @@ cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
 	return rc;
 }
 
-static int cxl_acpi_qos_class(struct cxl_port *root_port,
+static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
 			      struct access_coordinate *coord, int entries,
 			      int *qos_class)
 {
+	struct device *dev = cxl_root->port.uport_dev;
 	acpi_handle handle;
-	struct device *dev;
-
-	dev = root_port->uport_dev;
 
 	if (!dev_is_platform(dev))
 		return -ENODEV;
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index f9bc386f3043..0df5379cf02f 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -191,7 +191,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 						    dent->coord.write_bandwidth);
 
 		dent->entries = 1;
-		rc = cxl_root->ops->qos_class(&cxl_root->port, &dent->coord, 1,
+		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
 					      &qos_class);
 		if (rc != 1)
 			continue;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 70d5e6363399..3a5004aab97a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -617,12 +617,6 @@ struct cxl_port {
 	long pci_latency;
 };
 
-struct cxl_root_ops {
-	int (*qos_class)(struct cxl_port *root_port,
-			 struct access_coordinate *coord, int entries,
-			 int *qos_class);
-};
-
 /**
  * struct cxl_root - logical collection of root cxl_port items
  *
@@ -640,6 +634,12 @@ to_cxl_root(const struct cxl_port *port)
 	return container_of(port, struct cxl_root, port);
 }
 
+struct cxl_root_ops {
+	int (*qos_class)(struct cxl_root *cxl_root,
+			 struct access_coordinate *coord, int entries,
+			 int *qos_class);
+};
+
 static inline struct cxl_dport *
 cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 {


