Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761C26AC0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPYx+5B0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77227DD
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003088; x=1731539088;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tqj05+W8GQUGQH6c7Z14rpGbMQtWhF9wwh6KWSnAeJY=;
  b=GPYx+5B0BPCzW0Tgb+8wOCwvoPHvzhqfF88DU2u0dJDX1klpDY9wwG3X
   U8cweRKEGOfK75Ka+/CiIY2lI2P863+vp3Vc8BKeopXw+1woi3ZSyNaFe
   NsHOWTzllzzRzo+rE9nif75CutTUnG0QwcUMxxP8ULbm4T8nN/H7qZDza
   8bQ2iHxn1OkFKGhUxyCeluw5Mqhuu2rvi9WbMWCGRMMtXQIbJmpVsJ9BS
   y3RuzgRg67p1wp3Ph+7RY9Z6FAd6afyw2Lvj3XNtSOXOo7E5JIs6wrGEc
   iPrgqMkRiEYYPnHjK3nb6t4kLJbnSb3v6+QCIYlYMmnL+K9uUpvY/7UpC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="9403090"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="9403090"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:04:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741237440"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="741237440"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:04:46 -0800
Subject: [PATCH v12 07/18] acpi: numa: Add helper function to retrieve the
 performance attributes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:04:45 -0700
Message-ID: <170000308535.1974471.1084680860649143507.stgit@djiang5-mobl3>
In-Reply-To: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
References: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
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
v12:
- Change matching param to _UID. Testing against hw showed that the _HID
  is encoded as EISA ID rather than string. Since generic target is
  expected to be CXL (ACPI0016), the driver can just compare based on the _UID.
---
 drivers/acpi/numa/hmat.c |   40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |   11 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 70a6e775856d..31d146be4bf1 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -108,6 +108,46 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
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
index 54189e0e5f41..db7585be337e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -16,6 +16,7 @@
 #include <linux/property.h>
 #include <linux/uuid.h>
 #include <linux/fw_table.h>
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


