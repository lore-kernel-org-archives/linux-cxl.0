Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974641591F0
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506872; cv=none; b=toCTx5UCYsIH3zUT1xTsVyoUsZ3+LbmsNSOrVuPNjeOOgAqH0eFqYPMTa3WQ5/ImQJ05PebcFF6YZshb9IfUuIm3/MKO36zzihzRDkItsQKd4JgM4Vd7Uu9Isj9oNTz8W6AdI3mWvNZGrmy6wwEJ41rxNUwGoVArxgmoPhiV1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506872; c=relaxed/simple;
	bh=VbEk9oGoC7JXuhXMBQTxrYqnocvxUs3On/sKVYDVuvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MX0NkjQph/Dc+r9F2X/QGA2DvX3h/SDdZqivIZSIqJm+C/habCDWvSTj+rgxMwnHy2CiaK3W3Wv6PsBHz0c5EVFa79wYN0Xr+2ivbuixVEX9BYum6OFybizmyLpdt8D9nc+Qd0kzFtlDt8oEtnEFBX/WcKB49H4Y5LNSq7efROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6ryJ3vd3z6K5rP;
	Tue, 17 Sep 2024 01:10:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A7CB8140A77;
	Tue, 17 Sep 2024 01:14:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:14:25 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v6 07/15] hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS
Date: Mon, 16 Sep 2024 18:10:12 +0100
Message-ID: <20240916171017.1841767-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

Enable ACPI table creation for PCI Expander Bridges to be independent
of PCI internals.  Note that the UID is currently the PCI bus number.
This is motivated by the forthcoming ACPI Generic Port SRAT entries
which can be made completely independent of PCI internals.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index dfaea6cbf4..3d52ea5867 100644
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

