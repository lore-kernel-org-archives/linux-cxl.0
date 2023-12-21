Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66778E9F
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHnCrADn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196189; x=1734732189;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vABgoaX9rifnChhc1ZLpU2OtLtrFFwznY5wZALTRH/o=;
  b=oHnCrADnCivfJE6FryoHDcd9LqfHSuom7x0w/wurxElc6D2y2lddv51I
   mQukvk/iSna2ufgbkQ4M4pqsZ8X2jAb2l3gpALhQguN55kOvr8wRfTHRR
   dQpyHl8ROMYL/OEUa1Xmi7ofKZblZQ40W4AhVb8OyoZxNKTPsTImgVLPs
   j4MMHYmFIPHyYvEKrkqb1lGYEk+txWgBUbdaNBEngP4JJCKaDY6Mdseb8
   o7J0RnslwOdWW/+VFC6s5grPi0yUBqucb2e6T+K10LY8NKXoSFSVp4lKq
   eDBRZvzq1EIFK9p6DaKgFmE7SUYtsLE1BJWSbgZvrnzK6nynJIco+twy6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2873839"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="2873839"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="770083774"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="770083774"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:07 -0800
Subject: [PATCH v15 07/19] acpi: numa: Add helper function to retrieve the
 performance attributes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:03:07 -0700
Message-ID: <170319618721.2212653.5552947472849081786.stgit@djiang5-mobl3>
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

Add helper to retrieve the performance attributes based on the device
handle.  The helper function is exported so the CXL driver can use that
to acquire the performance data between the CPU and the CXL host bridge.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |   11 +++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 8a1802e078f3..d6b85f0f6082 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -108,6 +108,47 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
 	return NULL;
 }
 
+static struct memory_target *acpi_find_genport_target(u32 uid)
+{
+	struct memory_target *target;
+	u32 target_uid;
+	u8 *uid_ptr;
+
+	list_for_each_entry(target, &targets, node) {
+		uid_ptr = target->gen_port_device_handle + 8;
+		target_uid = *(u32 *)uid_ptr;
+		if (uid == target_uid)
+			return target;
+	}
+
+	return NULL;
+}
+
+/**
+ * acpi_get_genport_coordinates - Retrieve the access coordinates for a generic port
+ * @uid: ACPI unique id
+ * @coord: The access coordinates written back out for the generic port
+ *
+ * Return: 0 on success. Errno on failure.
+ *
+ * Only supports device handles that are ACPI. Assume ACPI0016 HID for CXL.
+ */
+int acpi_get_genport_coordinates(u32 uid,
+				 struct access_coordinate *coord)
+{
+	struct memory_target *target;
+
+	guard(mutex)(&target_lock);
+	target = acpi_find_genport_target(uid);
+	if (!target)
+		return -ENOENT;
+
+	*coord = target->coord[NODE_ACCESS_CLASS_GENPORT_SINK];
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, CXL);
+
 static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4db54e928b36..8b0761c682f9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -15,6 +15,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/uuid.h>
+#include <linux/node.h>
 
 struct irq_domain;
 struct irq_domain_ops;
@@ -424,6 +425,16 @@ extern int acpi_blacklisted(void);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
+#ifdef CONFIG_ACPI_HMAT
+int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
+#else
+static inline int acpi_get_genport_coordinates(u32 uid,
+					       struct access_coordinate *coord)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #ifdef CONFIG_ACPI_NUMA
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);


