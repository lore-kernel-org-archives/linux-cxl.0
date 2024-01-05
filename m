Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458D1E4AE
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBqVMeCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704492456; x=1736028456;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A7iPQsje7mIrbgy4z/xOdtK3IEcoYV20SAvaDlTOx28=;
  b=CBqVMeCiNrj1fgJ4jtns58ZUjglif4t4BLiyn6yYHUkzPX/FVNKA9AqU
   OzZ9pudoUXvBE9aCt6vQeYu/o0wS/O8sIOnWJkGQioJqKYC88bbs4d9wK
   RKWv2vLT92/qSrQfkH4lRDDiDJcg7gfWSEMC/vthLxUbEQQeYsg3Xk46y
   078MvQ9EfelJyR99HyeybFaKF6o+ToOaVvW6CQhzVjbNHEEqzfFUDgNv1
   rBVzFrYkd77Wn86sGYlvMiU8/Mhuvq3/6vsR2RV3ZGilsBGOOhtaEIsTh
   6pAm/zsZ9l2k66E9A7C1tO6/Gjg9Fvrv9dskVmHl93TGSJGweVxD30YRG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4957424"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="4957424"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="904260046"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="904260046"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:34 -0800
Subject: [PATCH v6 1/5] cxl: Introduce put_cxl_root() helper
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Fri, 05 Jan 2024 15:07:34 -0700
Message-ID: <170449245417.3779673.4566146351673989387.stgit@djiang5-mobl3>
In-Reply-To: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Move DEFINE_FREE() of put_cxl_root to current patch (Dan)
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
 drivers/cxl/cxl.h       |    3 +++
 2 files changed, 12 insertions(+)

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
index 492dbf63935f..df3db3e43913 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -735,6 +735,9 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
+void put_cxl_root(struct cxl_root *cxl_root);
+DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);


