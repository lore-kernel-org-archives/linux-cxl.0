Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCC3E866B;
	Mon, 27 Apr 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313691; cv=fail; b=ioTyPW3Qm2v/OfC/DQupAdVOADXm8wwOOcLrWyreALr7KR1MaHTAHGpX9Ya/6McpTLtdgqwP3XltSqvRyV/Lextt26eFUnyf6tUBCs7xoWXfoUS9VozBPxHp7heIJjySytAHnWMeXGXIltdx1GM6yqw/mwsaAfhOp+nQs9TSyRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313691; c=relaxed/simple;
	bh=/QlYvqDTI5KpbfsMs/t46PuS22WgiW/LZZ7NfJlw39A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNzLAR8kq/7nVdQxCdfH0ow53FqfgRANRzzsJw/hlokw1bPddOV3Qvkzdj+riXP5T27pP0IXySJWU4xuGKqU+LslkUGakYT6KdFTinNeyzPpXSAFZt53QaBFuwBAeOUaEQMmygSXT0fgUgMLD/DTo13ag/2R7anslT4+GbJyBh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XNQU+xRe; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XNQU+xRe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJBsT6F89+KqCibCrbB32gHfxMrnPy/zoFXQgJpS3i/70IUl9UN6M0PIKh/32KAMBc90V62dtb3ToU5rne8Ni107CLRQNHS1XcTpvmmJlB19owIn3MlDEdt7tt0ABZ5SmFNIIyIAufdJy/4bVwpgEBZIwFFhl2FxeGndOlmnjN9ujnPw/WLcE+ECH0XZnjkxdsMqNKhH/zV8yWCeGktVTlVPkXM3NPQAzgWjD0TsH65k+fFYHOVjXFhkfJAZ6HwoTVjLjbdkhOWSAbtOl9b2TbHb/g3ErTuCd2NqrYp7/+XvgSSTTM5vAAbaSyt/Au79dtdtAqbpE8WvyVZKPmaT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbfMC/amRJsGvbjWK9+uOWFMnjrdJBePyasFxsn0gI0=;
 b=JHF20nA9iCS0gnCbOQ1D8xm6TBA2C6Wn1TTSjuU89CLzjnfQMWfiAQaf2hAzQ+1FRbtPv2jfpKgDfymF43Wyc3LiHT00f61rsbqOQ3pubeM663f7W4AyDHrJfQnNOdBc9lMI3GJyhrggkZVuo8s3Vl1FvEHQQZHTDBVd4nkpuQJPDvpWwqK0tF+qtD92kmZu1S8qdPZW2Wq3+ZGBH1XW2w6DYJbT3e9w6LHPvCWsdfUqeRf6fCS+G+v4AdQ4wSFSkdSIMFJQtfc8LeGY+EhodqKrLN/VcbKe1c4WmJe1u6JbalQwh95jn3CjePsk3q/Vw25bTG8aMMxwcs6+fyOghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbfMC/amRJsGvbjWK9+uOWFMnjrdJBePyasFxsn0gI0=;
 b=XNQU+xRe/3giSzLGsNvW9w1giLs3M84WhMmYEbQq129s/PMr3B6AsyvzIgk5gJCU/3sDlOt0pP+VHqT3GHfenB16e7KNS0hHtXz341t7AdSjZbeJTuncimvhMMPsEXXF0XJRppO4KvQE4mv3zoRydX+wbNwgxvIiu3TwRqppALaVl4CAVgG3G+qEV7mdVYXPi9jVfPyfMCFPoq+Dvi1EhkmQ82P6nnocWlzMEkLxMI3JZPfL+qD16OuabpuN26IuSgTTYINN1TEq8mZw1pV+uY3gPPZYKqeiS65fOPTXJ/CgIAlWIDYrg+29stGXSzbkd061qtKr2eZvpiFRKUKMfg==
Received: from PH7PR10CA0019.namprd10.prod.outlook.com (2603:10b6:510:23d::27)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 18:14:40 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::bd) by PH7PR10CA0019.outlook.office365.com
 (2603:10b6:510:23d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:14:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:14:16 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:14:08 -0700
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
Subject: [RFC 7/9] hw/vfio+cxl: Program HDM decoder 0 at machine_done for firmware-committed devices
Date: Mon, 27 Apr 2026 23:42:33 +0530
Message-ID: <20260427181235.3003865-8-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d258bb-7378-4c58-20d3-08dea488d972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	qtkB/ofjo91XNMEgtFYSmb+IzOWB6cnczaPgpYELVLx+HOcztu3AFyUbA65Z4bU7Ec47SICZ1uVAtpjHuzSgUmyIGuR84tBZzGHmWVezbB5x5IF8gQtWcATtjCpMylyUI5tkF8q4mlZZeXWxg3jk/G/TEizBiUPJ4AwaIENG+aEH7VA7bDc8xvj1ppKwLDAf23L/FNBjicThLfgbwzt9CVwtoPztCKpFCPejCAdTotqxeXMGZlQfrjYgwUT+HT6Q7DES5Eli7qAV7euZ8dZLxOokjQzABA8eSVgDanmFgQaVdP4C5FRkeKgTmUNT0s70OCwDcnA/4AA3+6ZK/nhg5x14T1PCkTXTxX9Mk2/u+YH6kMXfNBC8QPF4z/lOVfCELIdTw6VNx3sU3H0B3dHrWMNB1BmeMJIjZIdDLBwebBGIcB/StagpI6mKAv+4mCRQBCc6iCbtqcbh61Dont32386gLF7XxtPQEmle603gqUkMQXZ7uLQ9t2M3QfSRV9TIdUg5HczW4aaLQzPwWjQdXGYJ7Qc10CK+sVR/vYa2pJW3+Xx2bFk8bkoO0RUxB7Rkh+nVCeDle5dNAL3pyqXhZWlNXSTEbvKR3Ip9PmdMlr/29jHusDMKDW6QBXJuQsEAi37mmJrkxuxMBWyrqfYaO4cBZCzOn/0RZE38ZjX3zgeU+cxYXJCVuIiJgKYnvHyffN8oehTD0I2eOlkyhn9Dq55XISMQNpx2joucwvrY7ASVzvC39QDgJHwdjteIr6/7qzLNbn0wO3qPNz/nwFgefxyBtxnIejF3oyP9whxscrFVjdWThoYweeCbQHGR5sKe
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XNB0Pze+VV0f5q1Ysyg02DeTCC/CsyQomWCLlFCDWHNBpm/gpBqjLa2PONhR0LGmcoAB9lGLQnZqHx6z4RLGEGMlGpTtuWg0UIZgPY4RVS1fwIuVmv33M/UCOAEQXUCEoz897ckLvRAPgng3tWuT7fuyP9Ah9B8vHG3dEsuptX7/3ddi8oijSq72aHIiLRC15SjdHVQgA/6vxJ5vIdjT9KVBCcy7XzCutQVIa6iXo9KfftCAUIDO0vNSKsbujUu00SLAQGo+3qmTqS7f7WtCiN/mMHTG8D4fFNViMF/3REw23eKb3w9RUUn6x7zg0P6Un2OwgnsDsrlt7h7z3xbK8euZQSre3qb+YabujnU9D4QzdCCyjyZ8NLA/CLzy6KIRNnk5ePktR7Wcmv9RiCPWgsWgf8lSaYqcT5ZFH1YpZvBRAOxPJVMA0i4ya06b+euj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:14:40.2316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d258bb-7378-4c58-20d3-08dea488d972
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

From: Manish Honap <mhonap@nvidia.com>

setup_locked_hdm() runs as a machine_done notifier after all devices
have been realized. It programs HDM decoder 0 with the CFMWS base
address so the guest can fault into device memory from the first
instruction.

The notifier is only registered when the kernel reports the device as
firmware-committed (VFIO_CXL_CAP_FIRMWARE_COMMITTED). The host is
responsible for HDM decoder programming; the guest has no mechanism to
remap host physical address mappings.

The function uses cxl->fmws_base (set by the optional cxl-fmws-base
device property) if non-zero; otherwise it falls back to the
cxl_fmws_base global captured by cxl_fmws_set_memmap() during machine
memory-map init. If neither is set, it warns and returns without
programming anything.

If COMMIT_LOCK is set in decoder 0 CTRL at machine_done time (left-over
from a prior FLR?), it is cleared before writing BASE so the subsequent
write is not blocked. COMMIT_LOCK is re-set after programming so the
hardware enforces the committed base.

read_region() return is checked; failure aborts programming rather than
leaving ctrl uninitialized. All write_region() failures are propagated.
The function exits cleanly rather than leaving the decoder half-programmed.

Add cxl_fmws_base as a hwaddr global in cxl-host.c (and a stub in
cxl-host-stubs.c). It is set once by cxl_fmws_set_memmap() and read
later at machine_done time.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-host-stubs.c   |   2 +
 hw/cxl/cxl-host.c         |   8 ++
 hw/vfio/pci.c             | 176 +++++++++++++++++++++++++++++++++++++-
 hw/vfio/pci.h             |   1 +
 hw/vfio/trace-events      |   1 +
 include/hw/cxl/cxl_host.h |  10 +++
 6 files changed, 196 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index c015baac81..0294d484c0 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -17,4 +17,6 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 };
 void cxl_fmws_update_mmio(void) {};
 
+hwaddr cxl_fmws_base;
+
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a94b893e99..f7e933f452 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -429,11 +429,19 @@ void cxl_fmws_update_mmio(void)
     object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map, NULL);
 }
 
+/*
+ * GPA base of the first CXL Fixed Memory Window region placed in the memory
+ * map by cxl_fmws_set_memmap(). Set once at machine memory-map init time.
+ */
+hwaddr cxl_fmws_base;
+
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 {
     GSList *cfmws_list, *iter;
     CXLFixedWindow *fw;
 
+    cxl_fmws_base = base;
+
     cfmws_list = cxl_fmws_get_all_sorted();
     for (iter = cfmws_list; iter; iter = iter->next) {
         fw = CXL_FMW(iter->data);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0270de61d2..2595229ea5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -25,6 +25,7 @@
 #include "hw/core/hw-error.h"
 #include "hw/core/iommu.h"
 #include "hw/cxl/cxl_component.h"
+#include "hw/cxl/cxl_host.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
@@ -3016,6 +3017,90 @@ static VFIODeviceOps vfio_pci_ops = {
 /* HDM Decoder BASE_LO: bits [31:28] hold address bits [31:28] */
 #define CXL_HDM_BASE_LO_ADDR_MASK       0xF0000000U
 
+static bool read_region(VFIORegion *region, uint32_t *val, uint64_t offset)
+{
+    VFIODevice *vbasedev = region->vbasedev;
+    uint32_t le_val;
+
+    if (pread(vbasedev->fd, &le_val, sizeof(le_val),
+              region->fd_offset + offset) != sizeof(le_val)) {
+        error_report("vfio-cxl: pread %s offset 0x%"PRIx64" failed: %m",
+                     vbasedev->name, offset);
+        return false;
+    }
+    /* CXL registers are little-endian; convert to host byte order. */
+    *val = le32_to_cpu(le_val);
+    return true;
+}
+
+static bool write_region(VFIORegion *region, uint32_t *val, uint64_t offset)
+{
+    VFIODevice *vbasedev = region->vbasedev;
+    /* CXL registers are little-endian; convert from host byte order. */
+    uint32_t le_val = cpu_to_le32(*val);
+
+    if (pwrite(vbasedev->fd, &le_val, sizeof(le_val),
+               region->fd_offset + offset) != sizeof(le_val)) {
+        error_report("vfio-cxl: pwrite %s offset 0x%"PRIx64" failed: %m",
+                     vbasedev->name, offset);
+        return false;
+    }
+    return true;
+}
+
+/*
+ * Direct pread/pwrite MemoryRegionOps for the CXL Component Register shadow.
+ *
+ * The generic vfio_region_ops routes guest MMIO through
+ * vfio_device_io_region_read() which returns EINVAL for vendor region
+ * index 10 at runtime.  The same pread() issued directly via
+ * region->fd_offset works fine, as vfio_cxl_derive_hdm_info() already does.
+ *
+ * The kernel enforces 4-byte aligned, 4-byte accesses on this region;
+ * valid and impl min/max_access_size are both set to 4 to match.
+ */
+static uint64_t vfio_cxl_comp_regs_mr_read(void *opaque, hwaddr addr,
+                                            unsigned size)
+{
+    VFIORegion *region = opaque;
+    VFIODevice *vbasedev = region->vbasedev;
+    uint32_t val = 0xFFFFFFFFU;
+
+    if (pread(vbasedev->fd, &val, size,
+              region->fd_offset + addr) != size) {
+        error_report("vfio-cxl: %s COMP_REGS read at 0x%"HWADDR_PRIx
+                     " failed: %m", vbasedev->name, addr);
+    }
+
+    val = le32_to_cpu(val);
+    trace_vfio_region_read(vbasedev->name, region->nr, addr, size, val);
+    return val;
+}
+
+static void vfio_cxl_comp_regs_mr_write(void *opaque, hwaddr addr,
+                                         uint64_t data, unsigned size)
+{
+    VFIORegion *region = opaque;
+    VFIODevice *vbasedev = region->vbasedev;
+    uint32_t val = cpu_to_le32((uint32_t)data);
+
+    if (pwrite(vbasedev->fd, &val, size,
+               region->fd_offset + addr) != size) {
+        error_report("vfio-cxl: %s COMP_REGS write at 0x%"HWADDR_PRIx
+                     " failed: %m", vbasedev->name, addr);
+    }
+
+    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
+}
+
+static const MemoryRegionOps vfio_cxl_comp_regs_mr_ops = {
+    .read = vfio_cxl_comp_regs_mr_read,
+    .write = vfio_cxl_comp_regs_mr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+    .impl  = { .min_access_size = 4, .max_access_size = 4 },
+};
+
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3404,6 +3489,78 @@ static bool vfio_cxl_derive_hdm_info(VFIODevice *vbasedev, VFIOCXL *cxl,
     return false;
 }
 
+/*
+ * setup_locked_hdm - machine_done notifier that programs HDM decoder 0 with
+ * the FMWS base address so the guest can access DPA through a stable GPA.
+ *
+ * Uses cxl->fmws_base (set by the optional cxl-fmws-base device property) if
+ * non-zero; otherwise falls back to the cxl_fmws_base global captured by
+ * cxl_fmws_set_memmap() during machine memory-map init.  If neither is set,
+ * the notifier warns and returns without programming anything.
+ */
+static void setup_locked_hdm(Notifier *notifier, void *data)
+{
+    VFIOCXL *cxl = container_of(notifier, VFIOCXL, machine_done);
+    VFIORegion *region = &cxl->comp_regs_region;
+    MemoryRegion *sys_mem = get_system_memory();
+    uint64_t hdm_base = cxl->hdm_decoder_offset;
+    uint32_t base_lo, base_hi, ctrl;
+
+    if (!cxl->fmws_base) {
+        cxl->fmws_base = cxl_fmws_base;
+        if (!cxl->fmws_base) {
+            warn_report("vfio-cxl %s: CXL FMWS base not available",
+                        region->vbasedev->name);
+            return;
+        }
+    }
+
+    if (!read_region(region, &ctrl,
+                     hdm_base + CXL_HDM_DECODER0_CTRL_OFFSET(0))) {
+        error_report("vfio-cxl: %s failed to read HDM decoder 0 CTRL",
+                     region->vbasedev->name);
+        return;
+    }
+
+    /*
+     * If COMMIT_LOCK (bit 8) is still set in the virtual snapshot the kernel
+     * should have cleared it during open.  Warn and clear it here so the
+     * subsequent BASE write is not blocked.
+     */
+    if (ctrl & CXL_HDM_CTRL_COMMIT_LOCK) {
+        warn_report("vfio-cxl: COMMIT_LOCK set in HDM decoder 0 CTRL at "
+                    "machine_done; clearing before programming guest GPA");
+        ctrl &= ~CXL_HDM_CTRL_COMMIT_LOCK;
+        if (!write_region(region, &ctrl,
+                          hdm_base + CXL_HDM_DECODER0_CTRL_OFFSET(0))) {
+            return;
+        }
+    }
+
+    base_lo  = (uint32_t)(cxl->fmws_base & CXL_HDM_BASE_LO_ADDR_MASK);
+    base_hi  = (uint32_t)(cxl->fmws_base >> 32);
+    ctrl    |= CXL_HDM_CTRL_COMMIT | CXL_HDM_CTRL_COMMIT_LOCK;
+
+    if (!write_region(region, &base_lo, hdm_base +
+                      CXL_HDM_DECODER0_BASE_LOW_OFFSET(0)) ||
+        !write_region(region, &base_hi, hdm_base +
+                      CXL_HDM_DECODER0_BASE_HIGH_OFFSET(0)) ||
+        !write_region(region, &ctrl, hdm_base +
+                      CXL_HDM_DECODER0_CTRL_OFFSET(0))) {
+        error_report("vfio-cxl: %s failed to program HDM decoder 0",
+                     region->vbasedev->name);
+        return;
+    }
+
+    trace_vfio_cxl_locked_hdm(/* name */ region->vbasedev->name,
+                              cxl->fmws_base, base_lo, base_hi, ctrl);
+
+    memory_region_transaction_begin();
+    memory_region_add_subregion(sys_mem, cxl->fmws_base, cxl->region.mem);
+    memory_region_transaction_commit();
+    cxl->dpa_in_system_mem = true;
+}
+
 static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3471,8 +3628,11 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
         error_setg(errp, "vfio-cxl: failed to get COMP_REGS region info");
         return false;
     }
-    ret = vfio_region_setup(OBJECT(vdev), vbasedev, &cxl->comp_regs_region,
-                            comp_info->index, "cxl-comp-regs", errp);
+
+    ret = vfio_region_setup_with_ops(OBJECT(vdev), vbasedev,
+                                     &cxl->comp_regs_region,
+                                     comp_info->index, "cxl-comp-regs",
+                                     errp, &vfio_cxl_comp_regs_mr_ops);
     if (ret) {
         error_setg(errp, "vfio-cxl: failed to set up COMP_REGS region");
         return false;
@@ -3486,6 +3646,18 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
     trace_vfio_cxl_setup_params(vbasedev->name, cxl->hdm_regs_bar_index,
                                  cxl->hdm_regs_offset, cxl->hdm_regs_size,
                                  cxl->dpa_size);
+
+    /*
+     * Only pre-program the HDM decoder if the kernel reported the device as
+     * firmware-committed.  Non-committed devices need guest driver involvement
+     * to commit the decoder; registering the notifier for them would write an
+     * uncommitted BASE value that the hardware ignores.
+     */
+    if (cap->flags & VFIO_CXL_CAP_FIRMWARE_COMMITTED) {
+        cxl->machine_done.notify = setup_locked_hdm;
+        qemu_add_machine_init_done_notifier(&cxl->machine_done);
+    }
+
     return true;
 }
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index f3906f0c53..5667c6ec17 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -133,6 +133,7 @@ typedef struct VFIOCXL {
     bool     dpa_in_system_mem;
     VFIORegion region;
     VFIORegion comp_regs_region;
+    Notifier   machine_done;
 } VFIOCXL;
 
 struct VFIOPCIDevice {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 3bced3cebb..174e577837 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -202,3 +202,4 @@ vfio_device_detach(const char *name, int group_id) " (%s) group %d"
 vfio_cxl_setup_params(const char *name, uint8_t bar, uint64_t hdm_off, uint64_t hdm_sz, uint64_t dpa_sz) " (%s) hdm_bar=%u hdm_regs_offset=0x%"PRIx64" hdm_regs_size=0x%"PRIx64" dpa_size=0x%"PRIx64
 vfio_cxl_put_device(const char *name) " (%s) removing DPA region from system memory"
 vfio_cxl_bar_subregion(const char *name, int nr, uint64_t off) " (%s) BAR%d comp_regs overlay at BAR offset 0x%"PRIx64
+vfio_cxl_locked_hdm(const char *name, uint64_t fmws, uint32_t blo, uint32_t bhi, uint32_t ctrl) " (%s) fmws_base=0x%"PRIx64" wrote decoder0 base_lo=0x%08x base_hi=0x%08x ctrl=0x%08x"
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 21619bb748..f890a5c0b9 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -20,6 +20,16 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
 void cxl_fmws_update_mmio(void);
 GSList *cxl_fmws_get_all_sorted(void);
 
+/**
+ * cxl_fmws_base - GPA base of the first CXL Fixed Memory Window region.
+ *
+ * Set by cxl_fmws_set_memmap() to the base address it receives (typically
+ * ROUND_UP(highest_gpa + 1, 256 MiB) on ARM virt). Valid after the
+ * machine memory-map init callback returns, i.e. at machine_done time.
+ * Zero when no machine has called cxl_fmws_set_memmap() (stub builds).
+ */
+extern hwaddr cxl_fmws_base;
+
 extern const MemoryRegionOps cfmws_ops;
 
 #endif
-- 
2.25.1

