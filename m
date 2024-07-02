Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A61A3BCA
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926135; cv=none; b=qF/9rCmrkJkD3UZqgP6tvCDRJtgHFnafZXbt1F1WVdRPxyq0rrowg24K1Qx1ewbTz8YP+WgPVMM79Tu4Q/l/okH4+p/w92Zp0T+tPZuCC8NPSh5hCvzC5T+kTjYjAgIJl3miBlkFRrQIUlAMsOHM73WFGUqSQwptnxPmt48AF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926135; c=relaxed/simple;
	bh=HQ1Im8pootDc01yCyPQfhR10KQy4AlAscZOZpuEyE7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmydW7HAjAHPvodrxphrsME+bMNxP8wAa16Au1gGVjfnkGgFJ+BwJxJxqV3k9ZJ8jXYggNw66lpy02l3RrZ2VBvpDIuVebYtB+b7B/oxFllKVkkOAYVk+ORfsqriCloUAlY2jEXzU5ARBkYI768PdowooESd6gJd5Y4gTajUtos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD3JM3xCVz6K9pT;
	Tue,  2 Jul 2024 21:13:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 406C6140B33;
	Tue,  2 Jul 2024 21:15:31 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 14:15:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 02/13] hw/acpi/GI: Fix trivial parameter alignment issue.
Date: Tue, 2 Jul 2024 14:14:07 +0100
Message-ID: <20240702131428.664859-3-Jonathan.Cameron@huawei.com>
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

Before making additional modification, tidy up this misleading indentation.

Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3: Picked up tags.
---
 hw/acpi/acpi_generic_initiator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 3d2b567999..4a02c19468 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -133,7 +133,7 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 
     dev_handle.segment = 0;
     dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
-                                               pci_dev->devfn);
+                                   pci_dev->devfn);
 
     build_srat_generic_pci_initiator_affinity(table_data,
                                               gi->node, &dev_handle);
-- 
2.43.0

