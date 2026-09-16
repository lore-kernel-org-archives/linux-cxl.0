Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844344D955D
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584409; cv=fail; b=c1RF41KZGIelZlGUvVn31DCiUW0B8VLm2cqhg7Bxjvgw3ypdjLmWijXINMM+EtEzJaXfBOazdtY6tLNg5L3b+cjrs0mmvpr66yOls+hK3x+Zacc0O3QKHMmGM3PLsB+ixCeVrA8bo1T8D7r81dCpCMbkDhY9yHwJ7zbMv1LIQpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584409; c=relaxed/simple;
	bh=yLlfXbXDIig6PXYic77bgTNz4P4XPtRSZ8h0EDzho5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2ZFzM4sL8wWZEGcyJUJgfm0vr9z59UthIivwmakb3vg+N9rAxACcx9zBr4b6/t/phKcNaH9AjJuzrc46fVMUsOXsspkFrptd/NSFkUhKssMRzY5rcaY7pAsf1/0aNrr5tOl+feEyiSGeEh6iOUQxbGKKSWlbAFHSZF+ORxea9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NR8Qx6La; arc=fail smtp.client-ip=40.93.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NR8Qx6La"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wd377dmR7yYTURwASrR0GfzwuWZe7kPboERbdlOcvpR59kZCIF3AzdUn/3mPCPCNHS0h0OrUiIMJkjcJEANgN/JUzcxJs3/eC5Eyj6LD6SNsT6QEP0O19eGsgU/2VM9I7UUGvGq4FN5kYSefYXniVWCTgwO3j4Exoef8eGJz8eutHOtgaNtATsU7vcd+bpDFNVqoZFGoVW4kO7uxeRnAug+kErBAn9mgYExVec7IpcxzEctGKQ4Rm9y6sfoufBTSeXw2ZzHBC8cYeUqWroUIuczdNmDxoiS/uRq3A5S0HVmpRHIJP37CyzUQWueh74Cgmgov3Sh5pyXbjvXfnlXa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XQK/dG1YVFszxw5vqZ++4pFST0Mr2jhFbzgDhRoEVs=;
 b=Xplzn7jvLaSa1RqxIRy1BBkAO22mnMYMpVBdpdGXjiih4zVj4Ci/euOK8qKN1D73qLG/rkmBSX4P7RfxkE+MSejyb/BgcI42E163lZj2Nt36dHHNgKES8Cic+UegCWlO08k6fKkI5x0K98U2VnEw6W64JjTOvdssWGvqD0mMYkP72aKDmDqNDFkeswwnjyDssXuw8CMKqMUAFlRbiG72kCkFkeRZ6wCE7C0BtQjBbALFTLTKkophTfzeaM9nm2jYwSu1jZqRN7rEgSR0zmPrc8qLnnUTfee2e0X9fNrp9hlgihj/C0/JV0sYN0oducoegt0lsxWMABlFoHltuXFDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XQK/dG1YVFszxw5vqZ++4pFST0Mr2jhFbzgDhRoEVs=;
 b=NR8Qx6LaybEMEUcJ4ExWhaGffrXIkQ32YNZ2JJ4ElpcB6TIDhBbTqFbwRxACLRGvJIZqz7DWmNQKMFFu2qeVEllY4EadRb65PlFaqkoQP9k/l46hwIIt3ld+ll6VcsfOeAC8pYQq6Ww00GoG7jIQ1EU9wgzzVEsT94fqbLQSSA1i46aAXjduE3XqdVYFW3dBPkfa0qzfq6xwzKzorijmku5nNjhN8D7zxludv3GCwbyaGgN4NRgL9TGe34Fq9pRgeXhGoC3A+fPdFkGr8yi6QYo03llfF569h6vXS5uMj69vqbUhvoobxcCbRx/yL6g9yERNRd6JxCgSb4ynkfRsmA==
Received: from SJ2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:a03:505::19)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:46:16 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::af) by SJ2PR07CA0020.outlook.office365.com
 (2603:10b6:a03:505::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:46:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:45:43 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:45:36 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
	<mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	<linux-cxl@vger.kernel.org>, Shameer Kolothum <skolothumtho@nvidia.com>
Subject: [PATCH v2 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to preserve firmware PCI config
Date: Thu, 17 Sep 2026 00:14:12 +0530
Message-ID: <20260916184412.3825713-11-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916184412.3825713-1-mhonap@nvidia.com>
References: <20260916184412.3825713-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab6b507-fb4e-4c11-ee45-08df1422c94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|23010399003|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	x8i0bBZLxyBrv0CaABnxtuHbF7RZDmZcLp0CRq9XxDUNGinupBe52yVp6/XzA8J0iqVXWGtyQbuvCKkwcHPHCq0Eg30rra6LPcBtfvmUxuxhbuf6uHgi6I41SoQ58JCtldJUy35ELqFioaumn9P8XSN3Y4uKxZZMGKD0nB7Z6wYE/iooZlMoewYdGbbr1JCMoU5BKQicIRC2W2kWqXS3ySkO3LAYq2qtdyMrtc7chc1Ih1i+sfsTK7T4ZkBMXal41rHYzmOQEtDy4MK67/1PFL7YY1wt2APt9ryL2QzauuxHqNwXIDAjgUKanGYT0ric4INPc+iARlDDwxKn3IaX/eLxkPHcyXlNv4GaxpQMMwOe6nUnb6VA7WM9t+I8Z7yyIFA/Cow5fUPEYP8OUXXgWZpnMp+pZVvvNFAu7ARfD4tb1serZrRLJjtcyyVE8ZxKHlN1SgRJ381nA0TziGgeI7j3EtZCbkO4Xw20qqYPPe/l5Pzr0bnWQji6AlseFE6c3nRl/sjkIEppmXdQX6TZhBSLuwjS4GfN5LIQkZtSV3flOB6hMxpqexio9Umh8UOaw7QLMR76e9KjBo1pw16iQZ1jkrT7D9mNUjq6ObMzRMVxqRoMbt9rZQEy7WRnh8E+mA5K51qws/HonotrcW4tZU8ZeoU2RnvDqwvAIvoqaxSktJ59e2hxiBXukKutGwlQgjOaXlhodJDT+Y5SXMT3N8EKr5yA/bI6bfPWuTtcJTFXn/XKu0f4CClijo0tM5SU
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KvSnOIwhPGLI0UZrBUAt9P0yeg3i4olYEeSEotBw3Q+LLi0iKkUL1DO7o9ACUGfBLCQs/GqLR9lbJWxI4K+swVE2Hf2OtpX80szEOCShPctDKDkIDpQgXxWtxkM9XbkXpakHgOMbin9Ku5tc9yMPrBTpeK4fwHNJc0NbyFmcW0mhZOZAxFIT+FhHS5jOtpyPdy/7ixh2G28GHN0YQxsG9rnADgIVFtNhNOE3dOh/8YSK/7lcU1bDJcIZhuHBW3+rYtL+yhRHWGGpoaHWqIG5ebh+PcX1SJEcJ0yKJwIwarwuW89Bqhcq2NNZwy3/keHOC+dhBr9m03fs0goQXOBuOuFQjBM3RQW5x0zdzrlNj39bFQTOEunv/c1hd4HPYPvZm0pbS3v4nRywqf92ub59dqyjCaNHFt+KzS1BzdP2q1Dpnphc+c7fJY0qcUT6y9m+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:46:14.7274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab6b507-fb4e-4c11-ee45-08df1422c94d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

From: Manish Honap <mhonap@nvidia.com>

A pxb-cxl host bridge had no PCI host-bridge _DSM method, so it could not
emit function 5 (preserve firmware PCI configuration) even when the
machine asks OSPM to keep the firmware resource assignments.

That preservation is required by the accelerated SMMUv3 (accel=on), which
describes MSI 1:1 mappings through IORT RMR nodes. An RMR reserves a fixed
IOVA range, so OSPM must not re-enumerate and reassign the PCI resources
underneath it. virt sets pci_preserve_config for that case and expects
every host bridge to emit the _DSM; the pxb-cxl bridge was the one that
did not, so a CXL topology under an accelerated SMMU lost the guarantee.

The BAR configuration itself is safe without this. vfio-pci marks every BAR
dword ALL_VIRT, so a guest BAR write updates only the virtual config and
cannot move the host resource; QEMU's trapped comp-regs region is a
subregion of the BAR MemoryRegion and follows any guest-visible relocation,
while the kernel's physical decoder mapping stays fixed. The CXL.mem window
comes through CEDT/CFMWS and is likewise unaffected by PCI resource
assignment.

Wire preserve_config through GPEXConfig into the CXL host bridge OSC path
so pxb-cxl bridges emit the _DSM function 5 when the machine preserves the
firmware configuration. Rename build_cxl_osc_method() to
acpi_dsdt_add_cxl_host_bridge_methods() to match the pxb-pcie analogue
acpi_dsdt_add_host_bridge_methods(), since it now appends the _OSC and,
under preserve_config, the _DSM. Gate the _DSM on preserve_config: x86 q35
passes false as it does not use the accelerated SMMU, so it emits no _DSM
and its ACPI tables stay byte for byte what they were.

AI-used-for: code (prototype)
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/acpi/Kconfig         |  1 +
 hw/acpi/cxl-stub.c      |  2 +-
 hw/acpi/cxl.c           | 12 +++++++++++-
 hw/acpi/pci.c           | 40 +++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c    |  2 +-
 hw/pci-host/gpex-acpi.c | 42 ++---------------------------------------
 include/hw/acpi/cxl.h   |  2 +-
 include/hw/acpi/pci.h   |  1 +
 8 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index daabbe6cd1..9490b75c94 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -88,3 +88,4 @@ config ACPI_ERST
 config ACPI_CXL
     bool
     depends on ACPI
+    select ACPI_PCI
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
index 77c1db6561..dc2a5fcdfe 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -23,6 +23,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
+#include "hw/acpi/pci.h"
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
@@ -320,11 +321,20 @@ static Aml *__build_cxl_osc_method(void)
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
+    /*
+     * Only a machine that asks OSPM to preserve the firmware PCI configuration
+     * needs the _DSM (function 5). Emitting it unconditionally would change the
+     * DSDT of machines that pass preserve_config=false (x86 q35), breaking the
+     * golden-table tests for no functional gain, so gate it on preserve_config.
+     */
+    if (preserve_config) {
+        aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
+    }
 }
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index c82924be86..f1feb33fc2 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -351,3 +351,43 @@ Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug)
     aml_append(method, aml_return(aml_arg(3)));
     return method;
 }
+
+Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
+{
+    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
+    Aml *UUID, *ifctx, *ifctx1, *buf;
+    uint8_t byte_list[1] = {0};
+
+    /*
+     * PCI Firmware Specification 3.0
+     * 4.6.1. _DSM for PCI Express Slot Information
+     * The UUID in _DSM in this context is
+     * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
+     */
+    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
+    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
+    ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
+    if (preserve_config) {
+        /* support functions other than 0, specifically function 5 */
+        byte_list[0] = 0x21;
+    }
+    buf = aml_buffer(1, byte_list);
+    aml_append(ifctx1, aml_return(buf));
+    aml_append(ifctx, ifctx1);
+    if (preserve_config) {
+        Aml *ifctx2 = aml_if(aml_equal(aml_arg(2), aml_int(5)));
+        /*
+         * 0 - The operating system must not ignore the PCI configuration that
+         *     firmware has done at boot time.
+         */
+        aml_append(ifctx2, aml_return(aml_int(0)));
+        aml_append(ifctx, ifctx2);
+    }
+
+    aml_append(method, ifctx);
+
+    byte_list[0] = 0;
+    buf = aml_buffer(1, byte_list);
+    aml_append(method, aml_return(buf));
+    return method;
+}
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6d7308b4e4..c8f02ea608 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1019,7 +1019,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(aml_pkg, aml_eisaid("PNP0A08"));
                 aml_append(aml_pkg, aml_eisaid("PNP0A03"));
                 aml_append(dev, aml_name_decl("_CID", aml_pkg));
-                build_cxl_osc_method(dev);
+                acpi_dsdt_add_cxl_host_bridge_methods(dev, false);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
                 aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index d9820f9b41..014f647c7f 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -51,45 +51,6 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
-{
-    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
-    Aml *UUID, *ifctx, *ifctx1, *buf;
-    uint8_t byte_list[1] = {0};
-
-    /* PCI Firmware Specification 3.0
-     * 4.6.1. _DSM for PCI Express Slot Information
-     * The UUID in _DSM in this context is
-     * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
-     */
-    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
-    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
-    ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    if (preserve_config) {
-        /* support functions other than 0, specifically function 5 */
-        byte_list[0] = 0x21;
-    }
-    buf = aml_buffer(1, byte_list);
-    aml_append(ifctx1, aml_return(buf));
-    aml_append(ifctx, ifctx1);
-    if (preserve_config) {
-        Aml *ifctx2 = aml_if(aml_equal(aml_arg(2), aml_int(5)));
-        /*
-         * 0 - The operating system must not ignore the PCI configuration that
-         *     firmware has done at boot time.
-         */
-        aml_append(ifctx2, aml_return(aml_int(0)));
-        aml_append(ifctx, ifctx2);
-    }
-
-    aml_append(method, ifctx);
-
-    byte_list[0] = 0;
-    buf = aml_buffer(1, byte_list);
-    aml_append(method, aml_return(buf));
-    return method;
-}
-
 static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
                                               bool enable_native_pcie_hotplug,
                                               bool preserve_config)
@@ -164,7 +125,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
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
diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 20b672575f..c7de33f8cf 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -42,6 +42,7 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
 void build_srat_generic_affinity_structures(GArray *table_data);
 
 Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug);
+Aml *build_pci_host_bridge_dsm_method(bool preserve_config);
 Aml *build_pci_bridge_edsm(void);
 
 #endif
-- 
2.25.1

