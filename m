Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD75143C63
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508612; cv=none; b=jk//WNGqQItG23oe6k/w69+95DIECo7g5VwJamEo99XprXFmQsPCFAhDpBB2fi2wnO3PM/r6nbUfRG1IUmAJOfRW29PT7bPt//g6vvWB9FNl3D+revjd80hrTYR3FKtvh2ltVW+VUrPh+oaG5laLa7MVjTR7bdHZbffkCsx4g/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508612; c=relaxed/simple;
	bh=/b6WDxYssbFp0mRr8WuZq3pBxpdeX+p4nZMjQYn+T4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehI15068tqiHN/ISeoMdutmAAmFz/nj2ibgafIgK+1itLvI1ktu2iPVR21XTobIGr8TEvtmHRgIPIqKPzvBAREG5agp/CJEOVh7PAlMWZrQ1oH+Dct/47M92HdWz4+zuusDnMAOuiXzRUXoB7fFsm1AGpy66fhM1Oqn2is4Bwso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sbk4vJNz6K9FF;
	Tue, 17 Sep 2024 01:39:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D842E140CF4;
	Tue, 17 Sep 2024 01:43:26 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:43:23 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v6 12/15] hw/acpi: Generic Initiator - add missing object class property descriptions.
Date: Mon, 16 Sep 2024 18:43:21 +0100
Message-ID: <20240916174321.1843228-1-Jonathan.Cameron@huawei.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

From review of the Generic Ports support.
These properties had no description set so add one.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v6: New patch based on Igor's review of Generic Ports patch.
---
 hw/acpi/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index a4835ce563..f88f450af3 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -137,8 +137,12 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
 {
     object_class_property_add_str(oc, "pci-dev", NULL,
         acpi_generic_initiator_set_pci_device);
+    object_class_property_set_description(oc, "pci-dev",
+        "PCI device to associate with the node");
     object_class_property_add(oc, "node", "int", NULL,
         acpi_generic_initiator_set_node, NULL, NULL);
+    object_class_property_set_description(oc, "node",
+        "NUMA node associated with the PCI device");
 }
 
 static int build_acpi_generic_initiator(Object *obj, void *opaque)
-- 
2.43.0

