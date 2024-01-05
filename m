Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1E328D1
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bd3SHHUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704477790; x=1736013790;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iUQKC+xWl3Cm421NX8SqPJWZh4sLOPHbebX7wyaYebM=;
  b=Bd3SHHUCI8Cw/iTtvvfuaSe0f/S4YWVtyNHAjp8NOu1NVh4ReudoxA5t
   +1E6oIKUHbO/SIHHPTheG8qbBehN8bKGbyluiNf6BGDWh7KnFMnmsHK1N
   At3R70mN9Ky+v1mDieSvLWgS+V1iNqCkD5h8GVA1pJuh9UxPphynEK3Wb
   GxOsdjkZ/TYbBv03HNI5Z7pp3La2ejZ1COxUi6aifj3Lwu2IRDK1Ls0BS
   0xXyzQFfDDgubojSj12NyM4uVIzW/DnrIMfBIkaAnfj2pbKVlzk2Oa4B8
   N3BveU1B5kRTKlNlJbuESnpUyRZ4utDrnKe5xHreoguXiBdkdrO9YiOVc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="377047560"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="377047560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="773905572"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="773905572"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:03:05 -0800
Subject: [PATCH v5 1/5] cxl: Introduce put_cxl_root() helper
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Fri, 05 Jan 2024 11:03:04 -0700
Message-ID: <170447778486.3687480.17502575591619841802.stgit@djiang5-mobl3>
In-Reply-To: <170447769575.3687480.11698914923419362733.stgit@djiang5-mobl3>
References: <170447769575.3687480.11698914923419362733.stgit@djiang5-mobl3>
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
get_device() in find_cxl_root().

Suggested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Move out usages for follow on cleanup. (Dan)
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
 drivers/cxl/core/port.c |    9 +++++++++
 drivers/cxl/cxl.h       |    1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8c00fd6be730..64f30d5fe1f6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -986,6 +986,15 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
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
index 492dbf63935f..ffa56af7b0d4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -735,6 +735,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
+void put_cxl_root(struct cxl_root *cxl_root);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);


