Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805577F37
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTF/iazP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196184; x=1734732184;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nb3ByExvPeUddSZY+gIFLQG+VQpcRBU1chL3/pptkcs=;
  b=cTF/iazPYnp8Z63LFA9ALDNigIqaPILf+TvMHjnP6GcFOAm2qlm3Cszr
   HEoXVDhZEdMcaWj7VSz8GT7VVfKqccYt2LD0B/u8apoC/B1+FbD/8wyEj
   FdIGAGs1ga1buOVzKyw6fVSayDnkOyUtuatjcCBCijKWskeMHXMigdApG
   padBbXgHmg94KldMHecY/FBHrGYA3/7nxWAIl5t2IZW1OTLHQMTyb0g5S
   Y1447pZoQwINh6NMqiTPWS+GdgfRV/mj7n6+c2n3H656yh91s0TmVFEnE
   AnzyK97U0X7CpdYglpvL5G1QPK1lRHbpP8fPvPWujd4pkle6pvTFiTOIJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3286185"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3286185"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1108253697"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1108253697"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:01 -0800
Subject: [PATCH v15 06/19] acpi: numa: Add setting of generic port system
 locality attributes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:03:01 -0700
Message-ID: <170319618135.2212653.13778540010384821833.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add generic port support for the parsing of HMAT system locality sub-table.
The attributes will be added to the third array member of the access
coordinates in order to not mix with the existing memory attributes. It
only provides the system locality attributes from initator to the
generic port targets and is missing the rest of the data to the actual
memory device.

The complete attributes will be updated when a memory device is
attached and the system locality information is calculated end to end.

Through hmat_update_target_attrs(), the best performance attributes will
be setup in target->coord.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v15:
- Go through hmat_update_target_attrs() to setup best perf numbers
---
 drivers/acpi/numa/hmat.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 4cae2e84251a..8a1802e078f3 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -61,6 +61,7 @@ struct target_cache {
 enum {
 	NODE_ACCESS_CLASS_0 = 0,
 	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_GENPORT_SINK,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -654,6 +655,11 @@ static void hmat_update_target_attrs(struct memory_target *target,
 	u32 best = 0;
 	int i;
 
+	/* Don't update for generic port if there's no device handle */
+	if (access == NODE_ACCESS_CLASS_GENPORT_SINK &&
+	    !(*(u16 *)target->gen_port_device_handle))
+		return;
+
 	bitmap_zero(p_nodes, MAX_NUMNODES);
 	/*
 	 * If the Address Range Structure provides a local processor pxm, set
@@ -723,6 +729,14 @@ static void __hmat_register_target_initiators(struct memory_target *target,
 	}
 }
 
+static void hmat_register_generic_target_initiators(struct memory_target *target)
+{
+	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
+
+	__hmat_register_target_initiators(target, p_nodes,
+					  NODE_ACCESS_CLASS_GENPORT_SINK);
+}
+
 static void hmat_register_target_initiators(struct memory_target *target)
 {
 	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
@@ -774,6 +788,17 @@ static void hmat_register_target(struct memory_target *target)
 	 */
 	hmat_register_target_devices(target);
 
+	/*
+	 * Register generic port perf numbers. The nid may not be
+	 * initialized and is still NUMA_NO_NODE.
+	 */
+	mutex_lock(&target_lock);
+	if (*(u16 *)target->gen_port_device_handle) {
+		hmat_register_generic_target_initiators(target);
+		target->registered = true;
+	}
+	mutex_unlock(&target_lock);
+
 	/*
 	 * Skip offline nodes. This can happen when memory
 	 * marked EFI_MEMORY_SP, "specific purpose", is applied


