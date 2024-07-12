Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAE1422C3
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782736; cv=none; b=szVcpqF1GYmJI6sgldfaywBFnWpidVeLAt5rXFWX6I9fNMyYW8QTdlRU6RsvuOYgglC7RoHFitmRhf1km1LWqQ+l3y87q+KdB4HbgQcbCLmLJ+bWUU9rgT6QNAKP1Qsvy0RlwLyLL0GAweCmdIes62pVuHLMnwJAdV3gNePODNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782736; c=relaxed/simple;
	bh=VcbWq7c4Igxv1Ag+2yJDx1s/t+9kgHX8igN7wQVfLoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIRq89pVOy/HG0cIAV2mbTKodm4OB4yJgxFswoliV4I+x2bjdD1T31yiLEctwfnGmPqnWGpb3AFcyGLXmRToW9kOH66i4sFP0ZayrWkENn6YYoFNpU3A9AD7fOF5lPegpypQkT2FWNY48nR6CuT1qdjk+dV7ICne1nHyV8ltjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL85r5Cd5z6K61v;
	Fri, 12 Jul 2024 19:10:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BAA31400D9;
	Fri, 12 Jul 2024 19:12:12 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:12:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v5 07/13] hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS
Date: Fri, 12 Jul 2024 12:08:11 +0100
Message-ID: <20240712110837.1439736-8-Jonathan.Cameron@huawei.com>
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

Enable ACPI table creation for PCI Expander Bridges to be independent
of PCI internals.  Note that the UID is currently the PCI bus number.
This is motivated by the forthcoming ACPI Generic Port SRAT entries
which can be made completely independent of PCI internals.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: Add missing property description.
---
 hw/pci-bridge/pci_expander_bridge.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 0411ad31ea..b94cb85cfb 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -85,12 +85,25 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
     return pxb->numa_node;
 }
 
+static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint32_t uid = pci_bus_num(PCI_BUS(obj));
+
+    visit_type_uint32(v, name, &uid, errp);
+}
+
 static void pxb_bus_class_init(ObjectClass *class, void *data)
 {
     PCIBusClass *pbc = PCI_BUS_CLASS(class);
 
     pbc->bus_num = pxb_bus_num;
     pbc->numa_node = pxb_bus_numa_node;
+
+    object_class_property_add(class, "acpi_uid", "uint32",
+                              prop_pxb_uid_get, NULL, NULL, NULL);
+    object_class_property_set_description(class, "acpi_uid",
+        "ACPI Unique ID used to distinguish this PCI Host Bridge / ACPI00016");
 }
 
 static const TypeInfo pxb_bus_info = {
-- 
2.43.0

