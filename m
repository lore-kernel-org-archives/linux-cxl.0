Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53B4BF942
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584368; cv=fail; b=gLpVb28GjofQujSIUNXzWQFRuKJbH/dPPqmcTshdvFxIrDwStW1C1SSJ+8vyeUovjGDYW1FT6d1ugXisWeNJevswrrTTRGGpPmgEaS1IlRDGczgzr3uR4v1qRe4/exFpq0POBefDxqnFztCSyJK1HCUNLKSO52Pp0k+ILdT1QAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584368; c=relaxed/simple;
	bh=X3UaNHHoW7BkBleZgqeRSkMWsJvXhfsakoGGLulOY3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5L74kslri8UipSg4eZQHhZ6/+PAvdXTVhBhjNhONqu2bxH0K9d5CVlbyxVVUJOmtw9nV/2k7pb1DtNV7TM4Lr/HwnM3Qev4ogDinFABDSCGudmQUIyKMcAuc1wE/ouQegalVoXpIB60+5tVxdz98cdDX6024wMCRB2wCDXrQ7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVjH+M0l; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVjH+M0l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpIKt+DtBQgdaar5vbPrV6If4SScfn2SbePCRsZRbwg90vAdplkvcRlL4LP3uMAW5hq2Qux45VTxjw17adumtwKU3vuabntszzBIY7g1ERrPOZF/C0Gqw7/QfWmTeYfhTBhwOKEb7NDw8mNIUyV5R1xh5HHGegYDDzih8fgMULdDCyapyowTFxPXVfWGTLfpPwUMQpyz1kqftj2u7Ya8XA/eo/yO4BcQchHeYyZgBdpzWSLXrvkLMQ7VTEWrW0x5JTwsFd74RwizjdPRqQI/59Okc/Zpdi/7hs7+5tAORHlvIuMzzEQqQgGoTkCtVqzrvCufVN4Zkypo9fL/oXQDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XbEStw/Foh3GYayNFhrbcmwy2aT7mYYj8+cXb9Jlk4=;
 b=HXEb6sC16a8W/qNoaCOJzp4oe8P0xEFrEegkrEoh1UTUALh472YjcCT1JJLDr6VVFkyeJZluGnWAfEiP34hbKY47a5QgU2S6D5ctruRhThZSq0gxPkUWrC12CHHStVV9JbQwo1uXYsOzqIA39ssZRgECcsiCldW6DJOEB68ItYYAPYL9Zhs7yPeZxSRzGridGxxQqABneV550wbC/ETre7UBBnFinKxSlQZ11TCIaxzNXuG1rnt/OIMQLOwBFqz6oNHoK7/VTSyn1/zgZNCxEgraXpnshFdV/YsKZDhiJX63duQKhbVW9/sh1TrBAoytbnMycj0o2DbirmO1itxFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XbEStw/Foh3GYayNFhrbcmwy2aT7mYYj8+cXb9Jlk4=;
 b=UVjH+M0lw6sUXg8skVnpTF8ZNav981HMjH5gMQFtxHMwKuTD720wEPhMoKpcENSiHb44Q0/AbSk15oCAzfS3Z2THW4umvV/odbYpcBA5ANx3g36TwXrwHjKeqbp1fAUkn+O+4R0s8VbUV4FxVb2BCbrfA7B1IjlmhHPTf2lN4wNXfEsggzlburjQ5QE2kwRjJZbR0q7ojfBUTklOZ0s+6p14/qI0L0oERx3Cqisj7WGos9KWZPUdQd+zLUGYfNfAkvKbvIRHANPLPdJk4lTeMEbeYjcbCDWSphoP0G4uDTjFVzKQ+qUf4yPMezyHZvQGisemyYZO7mUFY+K9CM4zJg==
Received: from DS7PR07CA0004.namprd07.prod.outlook.com (2603:10b6:5:3af::13)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:45:43 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::7e) by DS7PR07CA0004.outlook.office365.com
 (2603:10b6:5:3af::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 18:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:45:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:45:15 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:45:08 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
	<mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: [PATCH v2 06/10] hw/vfio/pci: Bind a CXL device to its fixed memory window
Date: Thu, 17 Sep 2026 00:14:08 +0530
Message-ID: <20260916184412.3825713-7-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 5070139d-1ff1-4614-0de8-08df1422b62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|921020|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wK+lxzZqC6KsMz9BgxY5Tl5lNG6I0W0Dk9W8RKLfHWmrhM1GMnp7aqdciBTczV7tQ4Htqy3Kivphh0nXV/lBc65nM5+w9lGOrmFtyhgqOjHsMUnlbCF6JOVT+km/Cpfxp3tu21KcCGIlu56OE86JsEeY2Yrb9T0sX2CN1WVcQlAahXjqUPz5G9mvLIWZhNxoVuA4gLYNLbdIF3NANYAmEVW2Zfg31mjek8Y6YgcZbGEcmYD7ZNRz/ha+KjeXRQJ1AQMdXKy2h4Q1B/4AGrZQplhIsHgidJ+6TwWnxvYyN+bztgtFOt/bYJku0mocCwfi3ATnJnYnNz+vt1YPTMUL3bmFCTnmUBqacb/6xLnjs1ntfuVcGhcT3WJyJuCCqgyKV3lVF1l+7f909AKEIPofwvTPG87L8ZGOb6YwMgGCEr5Y1PcWZFpDQFLf1NDcQcRpkgiG9Q7jxoKCh7ETahbTBU2UGRLmpsWVPCZ1yPYSYw79EYl4aI8uKIHTIQ/RrFdSnNQyF5Ky/EFd2JdqZrrKQr371gfi9XHbTnu8T9hmICzVGpfmXIdJPwE1pO8YmrNXGPpZecWQGGjgLmhFR0vz9Ru1Hj2h9jhNnMFTnrexbh2jcS6Fim7Of7py3Eq8k2gLoDOGX1xAark0lk1/SdRAoOcevM2fqWlbxOevfK0dvBWe6kko4BMBeBWz31dJd/a/7n9JFTfpzh+8rpK82uFAL0zqz/vCwWzHa07Z96U4qNBVonwepyOc4O3Vx8S+5yLI
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lmsTW1rwt+/sM3Lth7ImNmFJrXlTIaRJS0O3FyJO2GbxZ5GDzcDLezVJewAOhVKvvoOpEymuIlsiCqLAFsc8R8Lty+O+HXpB3l1+g/b2xsWtoAy4azjY5uReKsUkSAFBjYxG2czmfEcISDDsQ0uNXRiBD2eOlkCB0GcLUVgTsZNyRnaCid582PhJsmf7aHUPEh9lUhp7Hki73vwGuzr6ZNYT2NU3uZvXzAPyCiz35whyXQzTl0sZ6+gFyCIHZcu1MsaoG/L2qaUplq2l6viPZk9p8dXG0XuJYJcXWz0XWrw9B+astDy8lteXzSY4QVeQLS5I2DD47FAEYK3sBpmG9K2mO+qZ5RLfIjBtgOEfpsFpfEEg5RTEbMHfDQaDLWQzDe06wpPIijvOIddANCQpGU5ceIBfLWiMMwlMc3+iP6SPaqwlYrx6S84NqINkUZQS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:45:42.6529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5070139d-1ff1-4614-0de8-08df1422b62f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

From: Manish Honap <mhonap@nvidia.com>

The guest programs a GPA inside a CXL fixed memory window and QEMU maps
the HDM memory there, so the device must sit under exactly one
single-target CFMWS. Reject any ambiguous, interleaved, unsized, or
missing window rather than guess. Match windows by target name, since the
resolved target pointers are only filled in by a machine-done notifier
that may run after this one.

Require exactly one endpoint function below the root port: two functions
in the same slot would each match that single-target CFMWS and alias their
HDM memory at one base, so count every present function rather than one per
slot. The CFMWS windows are placed at machine-init-done, so a cold-plugged
device can only be validated from that notifier, where a bad topology is
fatal to startup. Validate a hotplugged device inline from realize instead,
reporting through errp so a bad device_add fails cleanly rather than
aborting the running VM, and arm the notifier only for a cold-plugged
device.

The endpoint's HDM size comes from the kernel region. cxl_fmws_set_memmap()
places the window in the guest PA map before this device is realized, so
the window cannot yet be sized from the device; check the configured window
against the device geometry instead. Reject a window too small to hold the
endpoint and name the size to set, and warn on an oversized window, since
the padding becomes guest CEDT that migration has to preserve.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/pci-bridge/pci_expander_bridge_stubs.c |   6 +
 hw/vfio/pci.c                             | 192 ++++++++++++++++++++++
 hw/vfio/pci.h                             |   3 +
 3 files changed, 201 insertions(+)

diff --git a/hw/pci-bridge/pci_expander_bridge_stubs.c b/hw/pci-bridge/pci_expander_bridge_stubs.c
index b35180311f..c44ad7fab6 100644
--- a/hw/pci-bridge/pci_expander_bridge_stubs.c
+++ b/hw/pci-bridge/pci_expander_bridge_stubs.c
@@ -10,5 +10,11 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_component.h"
 
 void pxb_cxl_hook_up_registers(CXLState *state, PCIBus *bus, Error **errp) {};
+
+bool cxl_get_hb_passthrough(PCIHostState *hb)
+{
+    return false;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4716266595..670e0d1da4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -27,7 +27,12 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
+#include "hw/cxl/cxl_component.h"
+#include "system/system.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/vfio/vfio-cpr.h"
@@ -3641,6 +3646,171 @@ static bool vfio_cxl_check_topology(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+/*
+ * Count the CXL fixed memory windows that target this device's pxb-cxl and
+ * report the matched window's base, size and target count. Match on the target
+ * names: cxl_fmws_link_targets() resolves target_hbs[] only at machine_done,
+ * which may run after this, so the resolved pointers can still be NULL here.
+ */
+static int vfio_cxl_match_fmws(PXBCXLDev *pxb, hwaddr *base, uint64_t *size,
+                               int *nwindows, int *ntargets)
+{
+    GSList *list = cxl_fmws_get_all_sorted();
+    GSList *iter;
+    int matches = 0;
+
+    *nwindows = g_slist_length(list);
+    *base = 0;
+    *size = 0;
+    *ntargets = 0;
+
+    for (iter = list; iter; iter = iter->next) {
+        CXLFixedWindow *fw = CXL_FMW(iter->data);
+        int i;
+
+        for (i = 0; i < fw->num_targets; i++) {
+            bool ambiguous = false;
+            Object *t = object_resolve_path_type(fw->targets[i],
+                                                 TYPE_PXB_CXL_DEV, &ambiguous);
+
+            if (t && !ambiguous && PXB_CXL_DEV(t) == pxb) {
+                *base = fw->base;
+                *size = fw->size;
+                *ntargets = fw->num_targets;
+                matches++;
+                break;
+            }
+        }
+    }
+    g_slist_free(list);
+    return matches;
+}
+
+/*
+ * Fix the bounds of the device's memory window once the topology has settled.
+ * Exactly one single-target CFMWS, with an assigned base and room for the HDM
+ * memory, is required; anything else is a misconfiguration the guest cannot
+ * recover from, so reject it rather than guess a window.
+ */
+static bool vfio_cxl_do_bind_fmws(VFIOPCIDevice *vdev, Error **errp)
+{
+    VFIOCXL *cxl = &vdev->cxl;
+    const char *name = vdev->vbasedev.name;
+    int nwindows = 0, ntargets = 0, matches;
+    hwaddr base = 0;
+    uint64_t size = 0, need;
+    PXBCXLDev *pxb;
+
+    pxb = vfio_cxl_find_pxb(vdev, errp);
+    if (!pxb) {
+        return false;
+    }
+
+    if (pcie_count_ds_ports(PCI_HOST_BRIDGE(pxb->cxl_host_bridge)->bus) != 1) {
+        error_setg(errp,
+                   "vfio-cxl: %s: pxb-cxl not in HDM passthrough mode "
+                   "(use a single cxl-rp)", name);
+        return false;
+    }
+
+    /*
+     * Count every present function, not one per slot, and require exactly one
+     * endpoint below the root port.
+     */
+    {
+        PCIBus *ep_bus = pci_get_bus(&vdev->parent_obj);
+        int slot, fn, nendpoints = 0;
+
+        for (slot = 0; slot < PCI_SLOT_MAX; slot++) {
+            for (fn = 0; fn < PCI_FUNC_MAX; fn++) {
+                if (ep_bus->devices[PCI_DEVFN(slot, fn)]) {
+                    nendpoints++;
+                }
+            }
+        }
+        if (nendpoints != 1) {
+            error_setg(errp,
+                       "vfio-cxl: %s: %d devices below the cxl-rp; a passed "
+                       "through CXL endpoint must be alone below its root port",
+                       name, nendpoints);
+            return false;
+        }
+    }
+
+    matches = vfio_cxl_match_fmws(pxb, &base, &size, &nwindows, &ntargets);
+    if (matches == 1 && ntargets == 1) {
+        if (!base) {
+            error_setg(errp,
+                       "vfio-cxl: %s: matched CFMWS has no base; reduce its "
+                       "size or grow the guest PA space", name);
+            return false;
+        }
+        /*
+         * QEMU reads the endpoint's HDM size from the kernel region, so the
+         * window size is really device information, not a value to make the
+         * caller guess. Sizing the CFMWS from the device the way firmware does
+         * is not possible here: the window is placed in the guest PA map by
+         * cxl_fmws_set_memmap() before this device is realized, so its size is
+         * fixed before dpa_size is known. Until a core change can size the
+         * window from the device, take the device geometry as the source of
+         * truth: reject a window too small to hold the endpoint, and warn when
+         * it is larger than needed, since the padding becomes guest CEDT that
+         * migration has to preserve.
+         */
+        need = ROUND_UP(cxl->dpa_size, 256 * MiB);
+        if (size < need) {
+            error_setg(errp,
+                       "vfio-cxl: %s: CFMWS size 0x%" PRIx64 " cannot hold the "
+                       "endpoint; set the cxl-fmw size to 0x%" PRIx64,
+                       name, size, need);
+            return false;
+        }
+        if (size > need) {
+            warn_report("vfio-cxl: %s: CFMWS size 0x%" PRIx64 " exceeds the "
+                        "endpoint's 0x%" PRIx64 "; set the cxl-fmw size to 0x%"
+                        PRIx64 " to keep the guest memory map stable across "
+                        "migration", name, size, cxl->dpa_size, need);
+        }
+        cxl->fmws_base = base;
+        cxl->fmws_size = size;
+        return true;
+    }
+
+    if (matches == 1) {
+        error_setg(errp,
+                   "vfio-cxl: %s: its CFMWS interleaves %d targets; use a "
+                   "single-target window", name, ntargets);
+    } else if (matches > 1) {
+        error_setg(errp,
+                   "vfio-cxl: %s: pxb-cxl is targeted by %d CFMWS; use one",
+                   name, matches);
+    } else {
+        error_setg(errp,
+                   "vfio-cxl: %s: no CFMWS targets this device (%d present)",
+                   name, nwindows);
+    }
+    return false;
+}
+
+/*
+ * Cold-plug path: the CFMWS windows are placed at machine init done, so the
+ * binding can only be validated from this notifier. The VM has not run yet, so
+ * a configuration error is fatal to startup. A hotplugged device is validated
+ * in realize instead (see vfio_cxl_setup), where the failure fails device_add
+ * without taking down the running VM.
+ */
+static void vfio_cxl_bind_fmws(Notifier *n, void *data)
+{
+    VFIOCXL *cxl = container_of(n, VFIOCXL, machine_done);
+    VFIOPCIDevice *vdev = container_of(cxl, VFIOPCIDevice, cxl);
+    Error *err = NULL;
+
+    if (!vfio_cxl_do_bind_fmws(vdev, &err)) {
+        error_report_err(err);
+        exit(1);
+    }
+}
+
 /*
  * Learn the CXL geometry the kernel reports: the HPA-backed HDM memory region
  * and the trapped HDM decoder block (which BAR carries it and at what offset).
@@ -3717,6 +3887,22 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
                     "performance may be slow", vbasedev->name);
     }
 
+    if (DEVICE(vdev)->hotplugged) {
+        /*
+         * The machine is already up, so the CFMWS windows are placed and the
+         * binding can be validated now. Report a failure through errp so a bad
+         * device_add fails cleanly instead of aborting the running VM.
+         */
+        if (!vfio_cxl_do_bind_fmws(vdev, errp)) {
+            vfio_region_exit(&cxl->mem_region);
+            vfio_region_finalize(&cxl->mem_region);
+            return false;
+        }
+    } else {
+        cxl->machine_done.notify = vfio_cxl_bind_fmws;
+        qemu_add_machine_init_done_notifier(&cxl->machine_done);
+    }
+
     cxl->enabled = true;
 
     return true;
@@ -3729,6 +3915,12 @@ static void vfio_cxl_teardown(VFIOPCIDevice *vdev)
     if (!cxl->enabled) {
         return;
     }
+
+    if (cxl->machine_done.notify) {
+        qemu_remove_machine_init_done_notifier(&cxl->machine_done);
+        cxl->machine_done.notify = NULL;
+    }
+
     if (cxl->mem_region.mem) {
         vfio_region_exit(&cxl->mem_region);
         vfio_region_finalize(&cxl->mem_region);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 06d15e807d..22fe8d7ff7 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -135,6 +135,9 @@ typedef struct VFIOCXL {
     uint64_t hdm_offset;             /* block offset within the component BAR */
     uint64_t dpa_size;               /* size of the HDM memory region */
     VFIORegion mem_region;           /* HDM memory, mapped at committed GPA */
+    Notifier machine_done;           /* CFMWS validated at machine_done */
+    hwaddr fmws_base;                /* base of the memory window */
+    uint64_t fmws_size;              /* size of the memory window */
 } VFIOCXL;
 
 struct VFIOPCIDevice {
-- 
2.25.1

