Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A6158848
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926324; cv=none; b=HKOKBxJ42xRslapGZhsxrYMtPda14vwMOX167wDwA62YbFmo8iK/opiK3ricDuJZHdzCEFy2u5Yrt2KcNuVix5WeeXgUci9bA/GTtkYB1GYxcIuY+GsUvhaH+oITc34yCUjJKYqoWcvOfxCZ5axkaYf83T1eCkg1BqhTDpJClNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926324; c=relaxed/simple;
	bh=esz85nZzuRrA5DYFnT6tIrbMHTkNwxGcdHIHMB3CJ94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTkctTUbLhMA0kdSGvAgHgBplO0nECZwcDFjaeVcOIaD9kQuBSmONrgNbsT7jnIQYDSWWluwSNHEvmwVilzehCfoa8662iw+GfkngM4/PY8+2pVj4swnut12So+za3JsXBoJY+vPbO7AP3Lg6GQfNl26dIq7R6RrzEpZpSJXoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD3N115kkz6K9TH;
	Tue,  2 Jul 2024 21:16:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 67E57140517;
	Tue,  2 Jul 2024 21:18:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 14:18:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 08/13] hw/i386/acpi: Use TYPE_PXB_BUS property acpi_uid for DSDT
Date: Tue, 2 Jul 2024 14:14:13 +0100
Message-ID: <20240702131428.664859-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Rather than relying on PCI internals, use the new acpi_property
to obtain the ACPI _UID values.  These are still the same
as the PCI Bus numbers so no functional change.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v4: New patch.
---
 hw/i386/acpi-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ee92783836..cc32f1e6d4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1550,6 +1550,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            uint8_t uid;
 
             /* look only for expander root buses */
             if (!pci_bus_is_root(bus)) {
@@ -1560,14 +1561,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 root_bus_limit = bus_num - 1;
             }
 
+            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
+                                           &error_fatal);
             scope = aml_scope("\\_SB");
 
             if (pci_bus_is_cxl(bus)) {
-                dev = aml_device("CL%.02X", bus_num);
+                dev = aml_device("CL%.02X", uid);
             } else {
-                dev = aml_device("PC%.02X", bus_num);
+                dev = aml_device("PC%.02X", uid);
             }
-            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             if (pci_bus_is_cxl(bus)) {
                 struct Aml *aml_pkg = aml_package(2);
-- 
2.43.0

