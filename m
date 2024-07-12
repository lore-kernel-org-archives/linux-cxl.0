Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA315E5B5
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782797; cv=none; b=l7fslsDBM9uNnr8hiwGbDtc4CW2NV83rH5J38he5zmPnZ6hxvBCxiLMha6v044NCUanL3KD1ZI11HBdOkvFbdaeuJKHu53pOaSQXZ8haSnPBB5D+DH6LvBm0GxUNlb/YjhNjqaXkI0nk9uqzh2n10Iy79+nrBuRMZiIh3vtQzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782797; c=relaxed/simple;
	bh=LZoIWmdFTx7R/rFN1z93YK2K8LLuJpXERg0rFiokakM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lud/L7llvE959YMrvx/exlRJC/MrfNThZwS/4HqhI/VSfG4Z/xC6TZNrPuXeM6DYDG/y7Y45R6LuH9tEaTgggop6DQaBakONnFt1X4IBVw8qEsc7vgLEgtYQ0IzSfQuq6v1+tP6aUAaBg7ycnUsmtfIuriL+2ibb7Ld4SLg2eTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL87149Tsz67M6q;
	Fri, 12 Jul 2024 19:11:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 61E6B140B2A;
	Fri, 12 Jul 2024 19:13:13 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:13:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v5 09/13] hw/pci-host/gpex-acpi: Use acpi_uid property.
Date: Fri, 12 Jul 2024 12:08:13 +0100
Message-ID: <20240712110837.1439736-10-Jonathan.Cameron@huawei.com>
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

Reduce the direct use of PCI internals inside ACPI table creation.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5: Similar to previous, use bus number, not uid in ACPI device naming so
    that uid can be 32 bits and we don't need checks to ensure it is only
    8 bits.  Not change to the actual numbers as the UID == bus_num
---
 hw/pci-host/gpex-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index f69413ea2c..f271817ef5 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -140,6 +140,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            uint32_t uid;
             bool is_cxl = pci_bus_is_cxl(bus);
 
             if (!pci_bus_is_root(bus)) {
@@ -155,6 +156,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 nr_pcie_buses = bus_num;
             }
 
+            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
+                                           &error_fatal);
             dev = aml_device("PC%.02X", bus_num);
             if (is_cxl) {
                 struct Aml *pkg = aml_package(2);
@@ -167,7 +170,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
             }
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
-            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
             aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Device")));
             aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
             if (numa_node != NUMA_NODE_UNASSIGNED) {
-- 
2.43.0

