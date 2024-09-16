Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49A1311A7
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508566; cv=none; b=bByKzZeAk6oSF8mvIQRMlw2vpo+oJHfDQ2H2QVuaZNRwNowAI33MRYDiDZkmxBtKMdL0j/k66V3vcLcDHBtKu1f73kpf1UX8SrwPLS4Dh26wgPL3AM6KoXzyB74KhIausZGnrKjQu2HrGrUyfPoAgGWAS6n0slCU2Kf9JdbDkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508566; c=relaxed/simple;
	bh=a93Hv/8J/mPYqYBuk2diyaWglYlPkV6YTW9VGJ5/23k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3hTFYK5nkGujjyuYbMYnpyeMkuHp66g4fA38lm5RPhQufr389torS2qnP0TSMDujvwXYresPkhR8c6tp4CzADuq31AAepopV6mqdlbRzJcqM9mApVOhVBL8g4XjsTpyjs3+g1DzXTeAasNkGyKjgVqlaMj0LvGcjm+MjXHgW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sZt3xSXz6K9F9;
	Tue, 17 Sep 2024 01:38:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B7004140AB8;
	Tue, 17 Sep 2024 01:42:42 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:42:39 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v6 11/15] hw/acpi: Make storage of node id uint32_t to reduce fragility
Date: Mon, 16 Sep 2024 18:42:37 +0100
Message-ID: <20240916174237.1843213-1-Jonathan.Cameron@huawei.com>
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

From review of generic port introduction.

The value is handled as a uint32_t so store it in that type.
The value cannot in reality exceed MAX_NODES which is currently
128 but if the types are matched there is no need to rely on that
restriction.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v6: New patch bringing Generic Initiator handling inline with
    updated generic ports code following Igor's review.
    Kind of suggested-by Igor, indirectly...
---
 include/hw/acpi/aml-build.h | 2 +-
 hw/acpi/aml-build.c         | 2 +-
 hw/acpi/pci.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 47a4692a7d..4fd5da49e7 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -486,7 +486,7 @@ Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set, uint32_t io_offset,
 void build_srat_memory(GArray *table_data, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
-void build_srat_pci_generic_initiator(GArray *table_data, int node,
+void build_srat_pci_generic_initiator(GArray *table_data, uint32_t node,
                                       uint16_t segment, uint8_t bus,
                                       uint8_t devfn);
 
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 4aa4debf44..91540df826 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1973,7 +1973,7 @@ static void build_append_srat_acpi_device_handle(GArray *table_data,
  * 5.2.16.6 Generic Initiator Affinity Structure
  *    With PCI Device Handle.
  */
-void build_srat_pci_generic_initiator(GArray *table_data, int node,
+void build_srat_pci_generic_initiator(GArray *table_data, uint32_t node,
                                       uint16_t segment, uint8_t bus,
                                       uint8_t devfn)
 {
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index d7a0e91f01..a4835ce563 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -72,7 +72,7 @@ typedef struct AcpiGenericInitiator {
 
     /* public */
     char *pci_dev;
-    uint16_t node;
+    uint32_t node;
 } AcpiGenericInitiator;
 
 typedef struct AcpiGenericInitiatorClass {
-- 
2.43.0

