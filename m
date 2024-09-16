Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865015CD60
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506907; cv=none; b=EYpsMzD32qvEcYfNnmtzHNtEmhum9ad59DdgsBlSkSFm/pa/Cn20Wl70Cxu/QrLtScrNre9lbdvFx2xzCWvZZ1OEUZi4e9jz6dd6OYMFMwKt4eG8a34W8qysZOAYlxAolc5vKXtV12AO1hphJB/Hnl4wGc2vN9t7ryJ4+WbokKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506907; c=relaxed/simple;
	bh=/D3epognXrF7xKcl8a/DY0JU1LV/qHy629Ep94660Eg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7fTDWaaYd6O/uPMLEJGc7OgZlTonaOlZvv1Er79RU7ooaSY9lrnEImqjW0OMug5rJ5Uux5eQ7iO4qyLD465ZyKie8qrwmnGIpNq6XchPM4xFsuEGH8wCSktTaivbwq2TaP9O0FgwNq7w3eMskPkHe9YjG9iUban8YkoKmk2rbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6s3l0ZgTz67lLG;
	Tue, 17 Sep 2024 01:14:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B7F19140AB8;
	Tue, 17 Sep 2024 01:15:03 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:15:00 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v6 08/15] hw/i386/acpi: Use TYPE_PXB_BUS property acpi_uid for DSDT
Date: Mon, 16 Sep 2024 18:10:13 +0100
Message-ID: <20240916171017.1841767-9-Jonathan.Cameron@huawei.com>
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

Rather than relying on PCI internals, use the new acpi_property
to obtain the ACPI _UID values.  These are still the same
as the PCI Bus numbers so no functional change.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/i386/acpi-build.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index afb2fa2edc..88227e343e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1475,6 +1475,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            uint32_t uid;
 
             /* look only for expander root buses */
             if (!pci_bus_is_root(bus)) {
@@ -1485,6 +1486,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 root_bus_limit = bus_num - 1;
             }
 
+            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
+                                           &error_fatal);
             scope = aml_scope("\\_SB");
 
             if (pci_bus_is_cxl(bus)) {
@@ -1492,7 +1495,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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

