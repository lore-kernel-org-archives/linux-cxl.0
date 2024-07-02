Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79F15884B
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926355; cv=none; b=CrgOmVASIl1q/VxI15e461ePUEdKGrbNFphzCF7IOyEwyOucBwzq6a6o4DBJoSJoMPc8r02SB0OYUXXmKu94bibGptGuVAaNxYN7GBjaY0Uyh3ycQlZgXcagVVR80I6J6+fVfeq8xcL77FrPuL3M/f4OmM4pDxI+E3Cul/x5Tlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926355; c=relaxed/simple;
	bh=ZwlDAE0fm+XVQisMZ4vatYkdwI/9+wtye0+GWy9MyM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VibfiIU5DZMN1u/l+gPC6JZjD5rw5b5xe24YM7Gg9UtuCKsS6HCUg5SYW8pwaNseHQZ8sCMvPez54r3TEZ1sOZwTAP+CR/7EucV5NNO51nhk3QgMGBq74HDZ8tr7maWsgw8XoJmsld47MCh/QTsn10kQxwX0Q9LIpDm8qRiBJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD3Q33dGhz6JBvW;
	Tue,  2 Jul 2024 21:18:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 426D5140B33;
	Tue,  2 Jul 2024 21:19:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 14:19:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 09/13] hw/pci-host/gpex-acpi: Use acpi_uid property.
Date: Tue, 2 Jul 2024 14:14:14 +0100
Message-ID: <20240702131428.664859-10-Jonathan.Cameron@huawei.com>
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

Reduce the direct use of PCI internals inside ACPI table creation.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v4: New patch
---
 hw/pci-host/gpex-acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index f69413ea2c..5faebdd467 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -140,6 +140,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            uint8_t uid;
             bool is_cxl = pci_bus_is_cxl(bus);
 
             if (!pci_bus_is_root(bus)) {
@@ -155,7 +156,9 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 nr_pcie_buses = bus_num;
             }
 
-            dev = aml_device("PC%.02X", bus_num);
+            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
+                                           &error_fatal);
+            dev = aml_device("PC%.02X", uid);
             if (is_cxl) {
                 struct Aml *pkg = aml_package(2);
                 aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0016")));
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

