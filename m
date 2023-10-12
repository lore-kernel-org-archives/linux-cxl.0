Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2E2AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B73vk/AI"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A083
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136891; x=1728672891;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jD3m7dUC7fN+KYxFKM0m9H0ocrjLWb3YoBEfn1rj+Vc=;
  b=B73vk/AI2ktGfym2Pm9vzYOe/cpRHu9bn7rEla6M8D5wkfiSis26fkhE
   4O/44DWrE2LZqrrkj1vtQ6MiHl2yJsiQ6vqmhXpxIshdyYqSPPY5ljyND
   QTRx7EQoC9R345uq0bi3zQNDuDeKEhkUfurQATpuBoJErpgMJ46kBfRid
   lmB8xCfXr32UegFBbjQLD0baMGShlZBGvIjBHy6UxgAQn/WQO+Km9k2kW
   AzxbdS1qFs4i4aWFNsemJWi0/12tQGgLdOx0MUMEKsIM0d4ookn8G9Y2/
   aDsq4oqF+vfuOZTiCveyuJZYjvWcMfHHrC5IR50mR0aqh4MBaUhGd5S8c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388880243"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388880243"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870711307"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870711307"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:37 -0700
Subject: [PATCH v11 11/22] acpi: numa: Add helper function to retrieve the
 performance attributes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:54:37 -0700
Message-ID: <169713687744.2205276.17806838881616683926.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add helper to retrieve the performance attributes based on the device
handle.  The helper function is exported so the CXL driver can use that
to acquire the performance data between the CPU and the CXL host bridge.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c |   35 +++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |   12 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index aabd89c79e26..e3a29ddacbca 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -107,6 +107,41 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
 	return NULL;
 }
 
+static struct memory_target *acpi_find_genport_target(u8 *device_handle)
+{
+	struct memory_target *target;
+
+	list_for_each_entry(target, &targets, node) {
+		if (!memcmp(target->gen_port_device_handle, device_handle,
+			    ACPI_SRAT_DEVICE_HANDLE_SIZE))
+			return target;
+	}
+
+	return NULL;
+}
+
+/**
+ * acpi_get_genport_coordinates - Retrieve the access coordinates for a generic port
+ * @device_handle: Device handle string (ACPI or PCI) to match up to the gen port
+ * @coord: The access coordinates written back out for the generic port
+ *
+ * Return: 0 on success. Errno on failure.
+ */
+int acpi_get_genport_coordinates(u8 *device_handle,
+				 struct access_coordinate *coord)
+{
+	struct memory_target *target;
+
+	target = acpi_find_genport_target(device_handle);
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
index 0d334975c0c9..7ffe054befa2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -16,6 +16,7 @@
 #include <linux/property.h>
 #include <linux/uuid.h>
 #include <linux/fw_table.h>
+#include <linux/node.h>
 
 struct irq_domain;
 struct irq_domain_ops;
@@ -419,6 +420,17 @@ extern int acpi_blacklisted(void);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
+#ifdef CONFIG_ACPI_HMAT
+int acpi_get_genport_coordinates(u8 *device_handle,
+				 struct access_coordinate *coord);
+#else
+static inline int acpi_get_genport_coordinates(u8 *device_handle,
+					       struct access_coordinate *coord)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #ifdef CONFIG_ACPI_NUMA
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);


