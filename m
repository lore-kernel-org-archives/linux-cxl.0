Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006EE1B14F3
	for <linux-cxl@vger.kernel.org>; Thu, 20 Jun 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899639; cv=none; b=OSZ9AHtozBFkmHn38JzgPvtCxNUWvpaGtyj2dPOzUeTjcIuSmOWXyO7KEojXI5Kx1WDu2Qo6WJO90mEjAdZS5ApCOR7TBcr2hYIct9j3ENv2aBfgh/27+eDK34A/BQN4nMy9yofb6qJb5JZL+xCseVTBd3Khbwx0bcpNvhwk5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899639; c=relaxed/simple;
	bh=+UkdRefnSaeBbM2e4COcFKRFLyliJHC2xJELMbDjIMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWLbvEtF2gHN26ExjAoRuQC77iHSOikWlfFA/8iF8FRhy25pOroLPttk/7XHiWq1B7AKfeawmyIGsAemsPXOwgsa2E4HvHnlP6anrHvX2mfNgbqif+wVfBs+Qs4Dc1ceuOyNrmftVg509NqGpbbAxRHxand23fZx335KFvhO5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4ljt3N2Tz6GD5h;
	Fri, 21 Jun 2024 00:06:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 33AFD140517;
	Fri, 21 Jun 2024 00:07:01 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 17:07:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 07/11] hw/pci-bridge: Add acpi_uid property to CXL PXB
Date: Thu, 20 Jun 2024 17:03:15 +0100
Message-ID: <20240620160324.109058-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

This allows the ACPI SRAT Generic Port Affinity Structure
creation to be independent of PCI internals. Note that
the UID is currently the PCI bus number.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v3: New patch
---
 hw/pci-bridge/pci_expander_bridge.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 0411ad31ea..92d39b917a 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -93,6 +93,21 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
     pbc->numa_node = pxb_bus_numa_node;
 }
 
+static void prop_pxb_cxl_uid_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint32_t uid = pci_bus_num(PCI_BUS(obj));
+
+    visit_type_uint32(v, name, &uid, errp);
+}
+
+static void pxb_cxl_bus_class_init(ObjectClass *class, void *data)
+{
+    pxb_bus_class_init(class, data);
+    object_class_property_add(class, "acpi_uid", "uint32",
+                              prop_pxb_cxl_uid_get, NULL, NULL, NULL);
+}
+
 static const TypeInfo pxb_bus_info = {
     .name          = TYPE_PXB_BUS,
     .parent        = TYPE_PCI_BUS,
@@ -111,7 +126,7 @@ static const TypeInfo pxb_cxl_bus_info = {
     .name          = TYPE_PXB_CXL_BUS,
     .parent        = TYPE_CXL_BUS,
     .instance_size = sizeof(PXBBus),
-    .class_init    = pxb_bus_class_init,
+    .class_init    = pxb_cxl_bus_class_init,
 };
 
 static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
-- 
2.43.0

