Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D2328DB
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haHms+f5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704477815; x=1736013815;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqQZIYXV9POTcvvHbk3IALeSkmdMIpoUQIvSnJBtoAE=;
  b=haHms+f5YKdie1mbf1OyhnOHr/t+cIJaNaAnw+qZhk5eSJo0vGhxSkeD
   zQ+Y+Vikx/zPOR8TwXh1RdirXKhAjHiIgMLJu+Suo/uCtkYGXrBPrt5gS
   P56a2p0KonIC2EF2/IHnRuc/cog8fht2usTqIs1L6jKMhMrajhLurxyU8
   5wRn73bZX9NUAIRUfVJe/NtJv2M2/szo2OMrLrEvOfl4B+Mq3sTyTigmv
   eI2CpP96LYCbQlnmG0loBcbvLCM/vdiHEnE+i/14RY8oxWWernI8PrYjz
   31VSNPxuT3nkZSqzPSQknYHF5+57JN84CoXix3FzmHhlQXY4hZy0jv1eA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="382528549"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="382528549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:03:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="924277951"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="924277951"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:03:33 -0800
Subject: [PATCH v5 5/5] cxl: Refactor to use __free() for cxl_root allocation
 in cxl_endpoint_port_probe()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Fri, 05 Jan 2024 11:03:29 -0700
Message-ID: <170447780994.3687480.10026614511779346820.stgit@djiang5-mobl3>
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

Use scope-based resource management __free() macro to drop the open coded
put_device() in cxl_endpoint_port_probe().

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Update commit log (Dan)
v4:
- Don't check return value of find_cxl_root() per comment. (Dan)
---
 drivers/cxl/port.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ddbb42f0fd70..89d303f048e7 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -95,7 +95,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
-	struct cxl_root *cxl_root;
 	struct cxl_port *root_port;
 	int rc;
 
@@ -131,7 +130,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * This can't fail in practice as CXL root exit unregisters all
 	 * descendant ports and that in turn synchronizes with cxl_port_probe()
 	 */
-	cxl_root = find_cxl_root(port);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+
 	root_port = &cxl_root->port;
 
 	/*
@@ -139,7 +139,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * assemble regions from committed decoders
 	 */
 	device_for_each_child(&root_port->dev, root_port, discover_region);
-	put_cxl_root(cxl_root);
 
 	return 0;
 }


