Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DC16727B
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782766; cv=none; b=iNkxcWUe9FO+77IJEJvRbEymEpJ8nCJNGu/whUSqw+FgGUKuKbrdH9otLuVuW8eUGDjoBuujMOnm91sGg8L6auyW1kJkJqewLXWKia6AoXHEZioEprSrDk0nrZA5iV2YwFhUrUcxixId9ad1nxHClErihjJ6PUe5QidX0EBbhjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782766; c=relaxed/simple;
	bh=3Zrm2SV3rjoOhxea5szExHWXYVZYDZhieY2LTXZBrmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSJz36p9glKL7KsnVM3bp9pSLvJRYZfEza4RFIzUKhlTBy+LCC/isqW1cPGJ6eJwRq4Feoi/07+jRNoPR3zByY83NkB7rO5t2EYy3P6Tobqfb0qgiZgWpg74+IxPcgPy9wj6V+BF+fVltI3G/bZ/gPHvUmaq2NmU4f28h5o1B6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL86y6w9vz6JB6M;
	Fri, 12 Jul 2024 19:11:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E686E1400CF;
	Fri, 12 Jul 2024 19:12:42 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:12:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v5 08/13] hw/i386/acpi: Use TYPE_PXB_BUS property acpi_uid for DSDT
Date: Fri, 12 Jul 2024 12:08:12 +0100
Message-ID: <20240712110837.1439736-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Rather than relying on PCI internals, use the new acpi_property
to obtain the ACPI _UID values.  These are still the same
as the PCI Bus numbers so no functional change.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5: Leave the device naming as using bus_num so that we can
    relax assumption of the UID being only 8 bits (it is but
    we don't need to assume that)
---
 hw/i386/acpi-build.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ee92783836..2eaa4c9203 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1550,6 +1550,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            uint32_t uid;
 
             /* look only for expander root buses */
             if (!pci_bus_is_root(bus)) {
@@ -1560,6 +1561,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 root_bus_limit = bus_num - 1;
             }
 
+            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
+                                           &error_fatal);
             scope = aml_scope("\\_SB");
 
             if (pci_bus_is_cxl(bus)) {
@@ -1567,7 +1570,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             } else {
                 dev = aml_device("PC%.02X", bus_num);
             }
-            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             if (pci_bus_is_cxl(bus)) {
                 struct Aml *aml_pkg = aml_package(2);
-- 
2.43.0

