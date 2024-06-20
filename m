Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045722616
	for <linux-cxl@vger.kernel.org>; Thu, 20 Jun 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899441; cv=none; b=WffrLvkHPtrjSS7T7Jk25km6uvXF0SJc4/GfljMebZgCfB2sC8wdfqapqu7GCTsU37VbukMAG96Pq1ipTmHGSsG8zzmXe8IqeLLpRKJmEavrfgw5s+KQ4VRrFWYnwPOOPM25uTXv96ugruidFl4nessigj/BwOYbVIM+ODWd+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899441; c=relaxed/simple;
	bh=JrMRgK+rqc7RlY+Dksl3EH9bpz82zkRbBvssniOqTaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rewCnWFx0RZTb0WB44BcB4EqiA367BDHwAWAPMebP9ISA6kzSPHFQumKjtLU8N1byYECP50srA+Cj9bMLFaOyWsBQYfCtDUBAhZNKOkgvI2fZjftyDOrjHs5k7eYSfQDWhr+LHu5u2VwdooOcslQ0ZHW+pIiSkZuYLgCQ4GiUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4lcZ365Gz6K9Gf;
	Fri, 21 Jun 2024 00:02:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 529671400D7;
	Fri, 21 Jun 2024 00:03:56 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 17:03:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 01/11] hw/acpi: Fix ordering of BDF in Generic Initiator PCI Device Handle.
Date: Thu, 20 Jun 2024 17:03:09 +0100
Message-ID: <20240620160324.109058-2-Jonathan.Cameron@huawei.com>
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

The ordering in ACPI specification [1] has bus number in the lowest byte.
As ACPI tables are little endian this is the reverse of the ordering
used by PCI_BUILD_BDF().  As a minimal fix split the QEMU BDF up
into bus and devfn and write them as single bytes in the correct
order.

[1] ACPI Spec 6.3, Table 5.80

Fixes: 0a5b5acdf2d8 ("hw/acpi: Implement the SRAT GI affinity structure")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v3: New patch.  Note this code will go away, so this is intended for
backporting purposes
---
 hw/acpi/acpi_generic_initiator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 17b9a052f5..3d2b567999 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -92,7 +92,8 @@ build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
 
     /* Device Handle - PCI */
     build_append_int_noprefix(table_data, handle->segment, 2);
-    build_append_int_noprefix(table_data, handle->bdf, 2);
+    build_append_int_noprefix(table_data, PCI_BUS_NUM(handle->bdf), 1);
+    build_append_int_noprefix(table_data, PCI_BDF_TO_DEVFN(handle->bdf), 1);
     for (index = 0; index < 12; index++) {
         build_append_int_noprefix(table_data, 0, 1);
     }
-- 
2.43.0

