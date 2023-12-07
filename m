Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVWssuJ7"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEE1720
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701989928; x=1733525928;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PCsDwPOCcGaP/fIrQ7A5/delVj4d27NAkEByFeLjEe4=;
  b=lVWssuJ7OaMGhQHf3MPKb34IvgRoMa1PlgNMTY7pzB+VxMc2/bTseH6w
   jmq8Zs2reMz8sgvshx5/Vp3peKrLoAjkCfFegJRUD9ZWBLHkAFJ9XfoDu
   Jw8//pwGTaf8wjtmGRP/2d33xWHqABl7AguDZH+g3Os2k1ktlXLAoHef/
   ykx5IUfFAwMpEdTe8pvpJTbpsEVbbAuXnORkp8fWbZ2I8TiEqzYCRFVyl
   oQwgXIjEUDsAnX+suiTq7gmI9VyRptXCxVXOXXrmF+BkTez+TvarFYuGq
   m/Ly+77OyVNEW6zFFfHoMV2ZmZiM0VtHUzhajIJiaibGY7tuHaplMN6lB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="398191249"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="398191249"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:58:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="19874041"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:58:47 -0800
Subject: [PATCH v13 04/19] acpi: numa: Add genport target allocation to the
 HMAT parsing
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 15:58:46 -0700
Message-ID: <170198992679.3522351.1761687170273700058.stgit@djiang5-mobl3>
In-Reply-To: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
References: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add SRAT parsing for the HMAT init in order to collect the device handle
from the Generic Port Affinity Structure. The device handle will serve as
the key to search for target data.

Consoliate the common code with alloc_memory_target() in a helper function
alloc_target().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c |   59 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index ca7aedfbb5f2..21722cbec324 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -72,6 +72,7 @@ struct memory_target {
 	struct access_coordinate coord[NODE_ACCESS_CLASS_MAX];
 	struct list_head caches;
 	struct node_cache_attrs cache_attrs;
+	u8 gen_port_device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
 	bool registered;
 };
 
@@ -126,8 +127,7 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 	list_add_tail(&initiator->node, &initiators);
 }
 
-static __init void alloc_memory_target(unsigned int mem_pxm,
-		resource_size_t start, resource_size_t len)
+static __init struct memory_target *alloc_target(unsigned int mem_pxm)
 {
 	struct memory_target *target;
 
@@ -135,7 +135,7 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
 	if (!target) {
 		target = kzalloc(sizeof(*target), GFP_KERNEL);
 		if (!target)
-			return;
+			return NULL;
 		target->memory_pxm = mem_pxm;
 		target->processor_pxm = PXM_INVAL;
 		target->memregions = (struct resource) {
@@ -148,6 +148,19 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
 		INIT_LIST_HEAD(&target->caches);
 	}
 
+	return target;
+}
+
+static __init void alloc_memory_target(unsigned int mem_pxm,
+				       resource_size_t start,
+				       resource_size_t len)
+{
+	struct memory_target *target;
+
+	target = alloc_target(mem_pxm);
+	if (!target)
+		return;
+
 	/*
 	 * There are potentially multiple ranges per PXM, so record each
 	 * in the per-target memregions resource tree.
@@ -158,6 +171,18 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
 				start, start + len, mem_pxm);
 }
 
+static __init void alloc_genport_target(unsigned int mem_pxm, u8 *handle)
+{
+	struct memory_target *target;
+
+	target = alloc_target(mem_pxm);
+	if (!target)
+		return;
+
+	memcpy(target->gen_port_device_handle, handle,
+	       ACPI_SRAT_DEVICE_HANDLE_SIZE);
+}
+
 static __init const char *hmat_data_type(u8 type)
 {
 	switch (type) {
@@ -499,6 +524,27 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
 	return 0;
 }
 
+static __init int srat_parse_genport_affinity(union acpi_subtable_headers *header,
+					      const unsigned long end)
+{
+	struct acpi_srat_generic_affinity *ga = (void *)header;
+
+	if (!ga)
+		return -EINVAL;
+
+	if (!(ga->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED))
+		return 0;
+
+	/* Skip PCI device_handle for now */
+	if (ga->device_handle_type != 0)
+		return 0;
+
+	alloc_genport_target(ga->proximity_domain,
+			     (u8 *)ga->device_handle);
+
+	return 0;
+}
+
 static u32 hmat_initiator_perf(struct memory_target *target,
 			       struct memory_initiator *initiator,
 			       struct acpi_hmat_locality *hmat_loc)
@@ -878,6 +924,13 @@ static __init int hmat_init(void)
 				ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 				srat_parse_mem_affinity, 0) < 0)
 		goto out_put;
+
+	if (acpi_table_parse_entries(ACPI_SIG_SRAT,
+				     sizeof(struct acpi_table_srat),
+				     ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY,
+				     srat_parse_genport_affinity, 0) < 0)
+		goto out_put;
+
 	acpi_put_table(tbl);
 
 	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);


