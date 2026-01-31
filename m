Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8443E1D6BB
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817774; cv=none; b=cKI9f4BEjARsRR6lVQvwXcmTeodcl8SOwbhed8tSrwDSFF8VyjpdcMZSlCpYP19dREbO2jvMOSdEEKPCDzwOed9itpqQURfak0LL1fpkZEgD8mb61UT37mL/FfX1cY2jz5VC9F585nwRJ5PlXKQpzJfKmwxsGaqjum+9+S/NIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817774; c=relaxed/simple;
	bh=OYMoK227RYmuhtXVAh2K9p39JFOlRXW0QXEWyurkshI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRhrk4gTDNKtidYVgDiPqQlN6LdeUdU7YVsjW/SNmtWmyRRn6bbGRnaGaCAb+drU+fVd3YLrIJZmabwKuflWYHSEVKTcMhuNLn2AYRgTYook/cdd7M11FQriRuRqySkxR/Utr2I71dAVc4BW5EC/16WmJ2ufGlwmVUYeJge6sEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRYscEwt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRYscEwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817773; x=1801353773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OYMoK227RYmuhtXVAh2K9p39JFOlRXW0QXEWyurkshI=;
  b=kRYscEwt1DW8FbGxqbiolqHcMGdZHbuS2MN7YOUOTT1vGwgrDpkiYDHc
   945eTX6a4e37OrjStGrwYX5CBg43AO+cHfZB22yms412hJ/6cJhx2sEai
   d41EaguDhHkS3TtOE8xU90ca7Q07lUqp1fHFWVIlfJL8MIFii1/bdlro0
   wLAkm0ExHXqhuF81spORRuLAR8K3gz+9SsxZWShysLFlvI6XIZwGDMIsL
   UAA5IdpY7QzmiipmCNzSUhijOAMMXhBK0t1kOFA5JRMbEW23P98dMoWev
   Js45qCOU8Rv5zZyDrPggJPkWlnk0aXUu+WXGOBrvjozB09UYuzolZGd9U
   Q==;
X-CSE-ConnectionGUID: 2RN3df6NRx69ulEqPrTj7w==
X-CSE-MsgGUID: qRJDCrYpTvuwLHJOo7cUWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71156908"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71156908"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:02:50 -0800
X-CSE-ConnectionGUID: w3QtArP+S/G9tceyqYOnmg==
X-CSE-MsgGUID: odxSrPLXTgK3SFi7lR5TvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208093719"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa006.jf.intel.com with ESMTP; 30 Jan 2026 16:02:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	alison.schofield@intel.com,
	dave.jiang@intel.com,
	terry.bowman@amd.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 4/9] cxl/port: Move decoder setup before dport creation
Date: Fri, 30 Jan 2026 16:03:58 -0800
Message-ID: <20260131000403.2135324-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131000403.2135324-1-dan.j.williams@intel.com>
References: <20260131000403.2135324-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are port setup actions that run on first dport arrival, and there are
setup actions that run per dport.

RAS register setup is a future additional setup action to run per-port
(once the first dport arrives), and each dport also has RAS registers to
map.

Before adding that, flip the order of "first dport" and "per-dport"
actions. This makes allocation symmetric with teardown, "first dport"
actions unwind after last dport removed. It also allows for using a devres
group to collect the unrelated decoder, RAS, and dport setup actions into
one group release action.

The new cxl_port_open_group() collects "first dport" and "per-dport" into
one group that can be released on any failure. This group's lifetime only
needs to span the short duration of cxl_port_add_dport() to cleanup all
potential damage from failing to add a dport. Contrast that to the "dport"
devres group that is called upon to destruct fully formed dport objects.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 99bbcf9cf236..6a554d0466a1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1651,10 +1651,14 @@ static bool dport_exists(struct cxl_port *port, struct device *dport_dev)
 	return false;
 }
 
-DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
+/* note this implicitly casts the group back to its @port */
+DEFINE_FREE(cxl_port_release_dr_group, struct cxl_port *,
+	    if (_T) devres_release_group(&_T->dev, _T))
+
 static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 					    struct device *dport_dev)
 {
+	struct cxl_dport *dport;
 	int rc;
 
 	device_lock_assert(&port->dev);
@@ -1664,14 +1668,13 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 	if (dport_exists(port, dport_dev))
 		return ERR_PTR(-EBUSY);
 
-	struct cxl_dport *dport __free(del_cxl_dport) =
-		devm_cxl_add_dport_by_dev(port, dport_dev);
-	if (IS_ERR(dport))
-		return dport;
-
-	cxl_switch_parse_cdat(dport);
+	/* Temp group for all "first dport" and "per dport" setup actions */
+	void *port_dr_group __free(cxl_port_release_dr_group) =
+		devres_open_group(&port->dev, port, GFP_KERNEL);
+	if (!port_dr_group)
+		return ERR_PTR(-ENOMEM);
 
-	if (port->nr_dports == 1) {
+	if (port->nr_dports == 0) {
 		/*
 		 * Some host bridges are known to not have component regsisters
 		 * available until a root port has trained CXL. Perform that
@@ -1684,18 +1687,24 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		rc = devm_cxl_switch_port_decoders_setup(port);
 		if (rc)
 			return ERR_PTR(rc);
-		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
-			dport->port_id, dev_name(dport_dev));
-		return no_free_ptr(dport);
 	}
 
+	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
+	if (IS_ERR(dport))
+		return dport;
+
+	/* This group was only needed for early exit above */
+	devres_remove_group(&port->dev, no_free_ptr(port_dr_group));
+
+	cxl_switch_parse_cdat(dport);
+
 	/* New dport added, update the decoder targets */
 	device_for_each_child(&port->dev, dport, update_decoder_targets);
 
 	dev_dbg(&port->dev, "dport%d:%s added\n", dport->port_id,
 		dev_name(dport_dev));
 
-	return no_free_ptr(dport);
+	return dport;
 }
 
 static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
-- 
2.52.0

