Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E323E8C74;
	Mon, 27 Apr 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313676; cv=fail; b=AQp6myeLNE7+ro3IFuRZuGNALroTsdWadyf0edj5fKMRwOrlMXnqTAaCH2WAkCsAkLktQrSJa5qTn6ywbgtb6MU6GfhdxoPBqaxGGSeRaAp3md10sBF4JknCRUwuVwJlOUoOrKGhxyVzqH4kqxdyprlLpZYe/pPBcDpM4dbGcQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313676; c=relaxed/simple;
	bh=jBca8fjfv1nuYodlhoEjtcsKY9OnWuOcC9kO+gKtask=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fddH2ksXv3Q8iIL1N1f0lmixlG9xJBjbAt3dh3v5DHYq7PRkBS4i7/GbOR9q70kKgar8oo2gO1wjyN+liJysymUWmBZjlv7VhIyuLFxea8s6i6E8JwLLlEZ/VVwbZjvzjq84JOyorK9DjmL+xxIJmCMdG0xTFe0OxKBYjvMcBjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rZ3Mkn/e; arc=fail smtp.client-ip=52.101.85.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rZ3Mkn/e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsiPjjVI9RMnGykQgbBiAzSCqpjbJXzqDw+yrgwUzbBe6YVLqvOxdi4tF8ICe0+TBFIkOggFAxEFGmh4iFfjAMfFZaDxmll8u88KI2KaKVaui3LGr+xuk/6aPvSxrpH5vKu8Ds7KAKvoswgbKdI63WDbGi3gPKh74Jh4VZYfnJwRTcrrWcEsQ9/ph5GA/V4KrLMuI68JmsrTg/bueh+rWrQ5umDqLKAj+a43wUVHWC7YUS5HdaVjwX0HYB+5fDD6d1v2HtxN6O3tHC8JIUUAl6Ov1j/9vgXnJ4/Wpx4MLeXZMEMVnofskQ3/KpR6a44WuB6WB8adzVIwT0bCfB80KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfW+Ey24wRPupkyPOeGDHYACfwBXVNhwnCKNuYUBIg4=;
 b=sAjxRj/0sJllucao9KdqCJclXWQCoC8E7DbctLCnE9OozxfOUh92+PnjaQ6U4Hb9cggIZPdFEJi9RLg/UUw7UfVztKlg212vibYaQ9eU/+HLuVc2Qcp7YW5I/phqsyzoCaRSqvuOkhZZaH09z+3RDahmyT/nFAj4ZdqA3KOm2TiWp5oiqExF3j228NxvYyg+hTcyQsZFsfLfxwLnphUd4w8vy5i09c1cTh5EaRkUy2VGmJu4xNHIzcyV4W9Zjy97GbE/6PuJ6XeDsBVB73+od5+WwQ+hgivKAnsQPU3/AKVyMK1ooeG9B6OaZn5e8hY/CTtvXFsESUGDwbk9pPp/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfW+Ey24wRPupkyPOeGDHYACfwBXVNhwnCKNuYUBIg4=;
 b=rZ3Mkn/eibn+FuD4MBhs8RcVrA1adpy4rp8lDjpJn5bN/PcHKSqY7M1sU89b2lRbenl1fEKA9AyW/Cw3v/rZE20Oj18QXE5JPISSvJfi5elDCApJ2krUiIYBtyBqmcmeUOo5rKYsEnX0bSzn+Yhbg6XsE5VdafFJK7AStwufVxOchCwyxVaXd6Ine26EGhrS/Q0vYv1CA7QlFkWeMnouN/IY8P3scyHFqMeuVMTtqnYeIr218THLvoyxw8AbhVqxXWMz9AK8Slpx18vt9tfOVi2o1ptEKpkgn//lEpvdem46KbpLLsb5SZhWYjiz/vZy3JsHaNwcNYzzMh4gaYEhWA==
Received: from BN9PR03CA0529.namprd03.prod.outlook.com (2603:10b6:408:131::24)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:14:01 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::95) by BN9PR03CA0529.outlook.office365.com
 (2603:10b6:408:131::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:14:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:13:35 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:13:27 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>, <ankita@nvidia.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
	<fan.ni@samsung.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
	<marcel.apfelbaum@gmail.com>, <clg@redhat.com>, <cohuck@redhat.com>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	"Manish Honap" <mhonap@nvidia.com>
Subject: [RFC 2/9] cxl: Add preserve_config to pxb-cxl OSC method
Date: Mon, 27 Apr 2026 23:42:28 +0530
Message-ID: <20260427181235.3003865-3-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260427181235.3003865-1-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: de8bbc39-0d5b-4cbc-a31f-08dea488c1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FM5opkPptdGPgWORofhFDGEpcvwuFFj9/LcSw2nKkuRkRT3+dXzEaE+DFo36iBUOkVWIaGuxVP4aLtsqVe8p8aKsY2aDdTrBQl90d5UvRPHtQXtcVvpdyiC7vQuI47wVDAu3pcVy3bZQAESDWW01WeBnhaVP1Bz9HmqfdNbA0NStUyHB5MNPgX0BUiy3kylZu+R94fdJn4fmWsNYTGketdEKKcSG49GL2NJ3Dl03hAWIN5Anuj2pryqsVwM8Rb8RezPpcU0kqFWtgJH2pGOPN0cmjdCGiC/PmvqsZzEEQj2wMV3a7FWgosD/5StYw9uCIL/kuWw1S67717hrzksSdkI9zfeY2jlm/18lww0e41AQcRpPwNcyILFEb2zIap93DEx1iBYWzU8WCYi54XGJDX43fQB4zIjGSmF9p2Gupv/V5Xchu1g6aTv7hVyKwgD+qQncVwWYv6omjPekh5ggb2sn/3AzPp5E6XLuaJS9B1hwgqsFuolT+cfYSamGbcoDD4iDXwVcotFQyAR2uhq1n/arspgRxjdmdcrRij3guRGA0+px2AtNSZFTi4mfpMpH9DOK1d5pU/hsrcCekj3yis7h6m+hTSNEqr2W0QD6oE4NnQoN/wXw7+bpipCUtJ6tJzMBRIrTFFxC8pWh3TPDUPx5wBEkRUiDhJ1YZGXh1IQeJ7y7Teg8eZeCK5vNOyy78oxH6as8g1PZL2khB7z9a2ZWNmJfqdsG68NQJOT+B5pgZXDVN+yuNP8wjY0E1Rd4d3z1U/bNmEcVzfkdRDiUE8sLhoTqAZf1WkDgGGj1fqMhUzxDk2Ov1bBtULmWY2z3
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XjWHEylXYABBgHEc9eVsdxRfnutnXmDZhzWqYNrUktW23nZmlGy4T6H7unLmSVcE1lkmn2PBkWubyUcZBhqP78c/uMEfta+7bUjlNyNB9h3Nv6igdexpYiTkZcpmvhPJQ9w4lBA29FwijR10ygYYgg3mi0auqXRYOGEP8woI4QTCzBLIxP9fbUy+iez0kquaUaKcisyZ4/vTOMKiV9TcwtuTZHcrUTA5qrAc3XPyQtT9p2XPRFUCUBNUnvPqb3GI6nT6Bz6dpW9rdUQwzjhNqyMm46YZAiV+seS8XCQlonK3/v3BQKMFApH4FhNmKWCDiKB80jZLlfTVQ12lMsH4tJhrIsJEcpoo5gy3jhoCplc/+u2QasWAKWOUSpDtZ9wQv6pCXpQrfUxgw45/wJmGDFTUkNLPIZ0ll5SxzABP+7VLJNLcqtOrIdN0oLpP00l+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:14:00.3576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de8bbc39-0d5b-4cbc-a31f-08dea488c1b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417

From: Manish Honap <mhonap@nvidia.com>

Before this patch, pxb-cxl bridges had no _DSM method at all. When the
OS called _DSM on a CXL host bridge, ACPI returned an error and the OS
defaulted to reassigning resources across suspend/resume. On machines
where firmware pre-commits the HDM decoder, that reassignment breaks the
DPA mapping.

Wire preserve_config through GPEXConfig into build_cxl_osc_method() so
pxb-cxl host bridges get a _DSM method that signals the OS to keep
resource assignments stable when needed. The _DSM function 5 (preserve
firmware PCI configuration) is the mechanism used to convey this.

build_pci_host_bridge_dsm_method() is promoted from static to exported
so cxl.c can call it without duplicating the AML.

The x86 build_cxl_osc_method() call site passes false since x86 does
not use firmware-committed HDM decoders.

build_cxl_osc_method is renamed to acpi_dsdt_add_cxl_host_bridge_methods
The function now appends both the CXL _OSC method and the _DSM method,
so its old name is misleading. Renamed it to match the pxb-pcie analogue
acpi_dsdt_add_host_bridge_methods(), making the two root bridge code
paths symmetric. No AML change.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/acpi/cxl-stub.c         | 2 +-
 hw/acpi/cxl.c              | 4 +++-
 hw/i386/acpi-build.c       | 2 +-
 hw/pci-host/gpex-acpi.c    | 5 +++--
 include/hw/acpi/cxl.h      | 2 +-
 include/hw/pci-host/gpex.h | 1 +
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/acpi/cxl-stub.c b/hw/acpi/cxl-stub.c
index 15bc21076b..d7c6731975 100644
--- a/hw/acpi/cxl-stub.c
+++ b/hw/acpi/cxl-stub.c
@@ -6,7 +6,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/cxl.h"
 
-void build_cxl_osc_method(Aml *dev)
+void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config)
 {
     g_assert_not_reached();
 }
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index f92f7fa3d5..b32740a3e3 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -23,6 +23,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
+#include "hw/pci-host/gpex.h"
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
@@ -320,11 +321,12 @@ static Aml *__build_cxl_osc_method(void)
     return method;
 }
 
-void build_cxl_osc_method(Aml *dev)
+void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config)
 {
     aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
     aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
     aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
     aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
     aml_append(dev, __build_cxl_osc_method());
+    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f622b91b76..f66ec8ed24 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1013,7 +1013,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(aml_pkg, aml_eisaid("PNP0A08"));
                 aml_append(aml_pkg, aml_eisaid("PNP0A03"));
                 aml_append(dev, aml_name_decl("_CID", aml_pkg));
-                build_cxl_osc_method(dev);
+                acpi_dsdt_add_cxl_host_bridge_methods(dev, false);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
                 aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 7de57bbc46..247bd78152 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -52,7 +52,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
+Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
 {
     Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
     Aml *UUID, *ifctx, *ifctx1, *buf;
@@ -204,7 +204,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             aml_append(dev, aml_name_decl("_CRS", crs));
 
             if (is_cxl) {
-                build_cxl_osc_method(dev);
+                acpi_dsdt_add_cxl_host_bridge_methods(dev,
+                                                      cfg->preserve_config);
             } else {
                 /* pxb bridges do not have ACPI PCI Hot-plug enabled */
                 acpi_dsdt_add_host_bridge_methods(dev, true,
diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
index 8f22c71530..6fe6c9c58d 100644
--- a/include/hw/acpi/cxl.h
+++ b/include/hw/acpi/cxl.h
@@ -24,7 +24,7 @@
 void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state);
-void build_cxl_osc_method(Aml *dev);
+void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config);
 void build_cxl_dsm_method(Aml *dev);
 
 #endif
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index a7c2e2edf3..e5c2ebef78 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -73,6 +73,7 @@ struct GPEXHost {
 int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg);
+Aml *build_pci_host_bridge_dsm_method(bool preserve_config);
 void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq);
 
 #define PCI_HOST_PIO_BASE               "x-pio-base"
-- 
2.25.1

