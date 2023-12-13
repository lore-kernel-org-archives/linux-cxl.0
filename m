Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5bJ0lam"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48861F2
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485722; x=1734021722;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W9rsfylUgt/6+WrouPDV9pYswIEmroZcKKrOZRpBU7I=;
  b=P5bJ0lam2odUBj75FldCiXyniorAnWbs+XKcaaRf15fKqAJHyUBB9rQW
   uxRAmloEBhDb/oCPVtbN7dhP86KxnNAhK3cY8jGPHkC6dGfyM28MAeA1u
   U5NAdHh36ou+kp4iMwZ4cYYA5Qe/NLG4eWYjxFU4wBO8ErDlNKKOaFc35
   7lKGt9UEGG09dBTcVgrC0bv3Hf1HuMhrbZgy7oZ0IUKHJ0n7EUjyy2s0s
   pPbfsf7UjDFtMmWBkE8anuoUNbzLvgsV60/WhqvV6xW/oP8XnsVSgzNZw
   MXfYcYvsFBggYB6sJi1ru61Rh1ZjHGY+/sNZExeg+QKX6yQ132mzKDNUo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="397775064"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="397775064"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767270437"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="767270437"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:01 -0800
Subject: [PATCH v14 07/19] acpi: numa: Add helper function to retrieve the
 performance attributes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:42:00 -0700
Message-ID: <170248572089.801570.1842990248095678984.stgit@djiang5-mobl3>
In-Reply-To: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
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
v14:
- Add target_lock for walking targets list to find coordinates
---
 drivers/acpi/numa/hmat.c |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |   11 +++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 70a6e775856d..1836cdf610b2 100644
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


