Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B4472784;
	Wed,  1 Apr 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054483; cv=fail; b=UPHLOMDzNacRcJwtSZx1bGPn7dBmFW1JWe/yzFNqsBmrKfw1jxhaGzX0HtYbeYkkOJP+NmZ2QyZ1ZBG88w4UiLweMu9avf9KA0U03xVDN9uNXL5pRImVPqHLkMrfHAFiWlnPj0lwO6hW4+LPgtMBo0Cs0bUfvdjehu6AmpN8Vd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054483; c=relaxed/simple;
	bh=Mj4FO4ivkPGj7Lsz7DO5JMcM1ZnLR6bQk05Jsuxi9kM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByyH0qywrljptQfz/aivU0LFqD+RSNmB0x0Q4lfFum4BJo/QSbEx0rZhjoqZMCHgvrJQV8Sc6i6foPSfVAaimEn/piU5Jbg7dCq9tyhIqLG7sBxyUHOwlcBo1h/jzTYjnqg1NXuEFwtIKZIQoIE/UgGa+0veJiKfhP6EwQQEUjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkVhJeM2; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkVhJeM2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKD90oJPjjEoHNEBVlCBVkMtQ9xrKEGu+85IoDFH7ruzdQUdVJW9b2IPmscS29sN+Q1PXTYpkYqQAAgd2yiW9GUNN5HzXvRmEzyP3l3vzoZL97ZZGk4Oy3TO7rrLFMfnfyAOm/h13DP+mfCcdKc66ITAekFyqEulgg/HtGn3qxscKNirTHqMK9cXUiO0ddsU1ZLnytBfbgUuitLAaHjyqruLY9a9BaRUGgEyZgW6mSm0R0WrlPO7gS3LnvfjXWK2pcHzKgJwapIf1jd/NgtUMSwZDNnGbl3LT5+myHDvhrm/z0ypiZvtQuEkPqppU4F7uX8f0EagTQUjOFut4VpvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGnyw0zorclIAgHtXFJ9d+OGIdew+gBTMi71wHkp6aw=;
 b=in3g0cC9Xlfv95wL2L0HjozlkYrLOiUtWRkGYKUM8w3cUNzx31zuucvS4dXGnA26/kZqpUr/zymk2wO/rSw1SwSu7kKPn1W3BlHQIoDtY8XNQhpVvAql+385zEci5UL7UGU0tST0z/WvenIy9rYgJfUKTr5DCgRoHTrJCL/1dDKsXImwcpFlHYCbvOawmRhZzGAPGMcVEKoOGP1aIwZSNx7uJAKxWHuSqSJQaa0NhMOy40DKkih7hGUVTH2K3gESkEgdv3XwLWZT9npuWuERoMuVP8TlW9wZQUze9LWYCALAmHR+b7PRfhoao2taiwNIUk4DUNnRJ9YpiFKqPP46ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGnyw0zorclIAgHtXFJ9d+OGIdew+gBTMi71wHkp6aw=;
 b=fkVhJeM24F/B6+UXLLShrGtB5qPIDV2RR7TXNDw3IkvBkmHPNLgkmp/r2IS8DZxXXrtQi8V0ii6V4bAiu4Z0Xa+d6zS08JFKNkynSoYVVKoAjnZrr9eFVIaip2tjbFUL4aaCMm/y2k6BECEFtE23nCa5Bo1ocFrSjLcGYR/uEYh7ByhCLQN9v3sIDhsSuS9yx3Wex4FBoR2e/NSptCg0JPQNPQzWa5X+gJBRNNLZN3ckfkJwWV/fsH3k8Snd4aXFlqLpYiy6LnsRcCB1yiGPEo3OQDZT+ZNH5nY7F+KCU6C6Kv0BIgBt9mXhbSvlzx5dvay/vWD9nc6Uwyj/4m4Zkw==
Received: from SJ0PR05CA0125.namprd05.prod.outlook.com (2603:10b6:a03:33d::10)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 14:41:08 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::95) by SJ0PR05CA0125.outlook.office365.com
 (2603:10b6:a03:33d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Wed,
 1 Apr 2026 14:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:41:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:40:46 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:40:38 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dmatlack@google.com>, <shuah@kernel.org>,
	<jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH v2 09/20] vfio/cxl: Detect CXL DVSEC and probe HDM block
Date: Wed, 1 Apr 2026 20:09:06 +0530
Message-ID: <20260401143917.108413-10-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401143917.108413-1-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a30470-a87e-4d1c-8676-08de8ffcb601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oa4pG2FAXZOKCDWWG0I02Ew2+joiE/fiCP/lsKnN2QYKudAFocEnimRLcKYXV8thlKNlf4DzhF4vUhUE0uvA4XgPIxw1AWWJDzrr+oILR1+ritHrsI7vDBaIbsY6Pqoa+KPHHBXz2OHXycfiS8hFRl//1AsEwz7TXCfixRIiGqvZsqvS8Y0FYlRS1bYQhNVfSPz9XCDoIfYO+mohKnQk5bmbRbBg2RKubrQSFJ2GyF351b0ZFKnyu65ZuyJ2UiMN6ENRaPKnQSGhOTVPxOMYy3pBs6CEwc/8XR+cW/BjoGOFzoXp96Rn58H2J9832B6zW/NtPo2gY8pG6DHcmQGNzn+mczcFtfihlteUlb8rlSPTfFx1h/RMa8KOgYKHzsGIwrRMwuI63dYep0OaQpSkv1fWwazafKrClRzpnibh+oEaGzD3tLQGo+uEwZcL6MMZ/G6vwRt5gy1p/JObNj3pveueukA5IAaGX9GLp0V7yAQpUTgx22p8hJqxkfiVSHXuB6/S0M9SlYf2oh8J8dVWkrSKduDdhUSXni5FuyL9l2bsSQcTZbW5WC9/tui+3/yCcZXpxHx5E/jiLXE/6GhIECZqjeXDhUSi6+StubMLXGM6tRzMs6eY0ksDHkqc4i0mQBao4DhNak3FXrkhLiEvjF0xbEyKwiU44l8UkNkpIcP5+aMfhzZprlgbbrAPa6i7THYCqoNdZ5UtIc7jh6h8fYQ+z//lLt0QCaCCcl7kx77j9AazOePO2LOEDMcft+5g4AMbwGEcsm+JgK8M7+OHcLHNFUoDKcV6xNaROsnFCUAdAQruI5Hb3JZE8YylHxIU
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C1t/heU7pXLjBku48HUBVDYfNw8mU9kVdEj5VxfYk1DoWF3lwxYJNMp3I82y+NU9W6y+/RxIE7gSGFhMDHqu8H1B/RfhY+PG1HHHlXoXnFsVEDRMXD9iX3L+3CWuOOfzNQ5TPDTvtM0FXiYAeV2IZPf03wGN6len8055ZkBIUqZnJvs8NOp8K2S9LmwgDhePqnfsVnUKzLSB0WhP/VkVArqtv4Y7+L4iGtYFuHJY/0TDonq+HcxRULsPj2xVlIvd00HiTPLWVkGKzlFFVr8z7IBm3CsoN27Gb34+Dljlzs2V1Bmr7vEyGdUnkBnQvYJ+sP4P9lPENQZZS5+6Yd2gpQDG+m4f3AtqGFVwW+GcPZnpNoLUKGYyqfW/AjC2dgz0K8omoprmkEVQ+AHtQtHfu9qdiOunffRvOuKQOfIKMQeft1GnTuIGIfEFjgZkWGki
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:41:08.0011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a30470-a87e-4d1c-8676-08de8ffcb601
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804

From: Manish Honap <mhonap@nvidia.com>

Detect a vendor-specific CXL device at vfio-pci bind time and probe
its HDM decoder register block.

vfio_cxl_create_device_state() allocates per-device state via devm and
reads MEM_CAPABLE and CACHE_CAPABLE from the CXL DVSEC.

vfio_cxl_setup_regs() locates the component register block, temporarily
maps it, calls cxl_probe_component_regs() to find the HDM block, then
releases the mapping.

vfio_pci_cxl_detect_and_init() chains these two steps. If either fails,
vdev->cxl stays NULL and the device falls back to plain vfio-pci.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 217 +++++++++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |  12 ++
 2 files changed, 229 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index d12afec82ecd..b1c7603590b5 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -21,6 +21,158 @@
 #include "../vfio_pci_priv.h"
 #include "vfio_cxl_priv.h"
 
+/*
+ * vfio_cxl_create_device_state - Allocate and validate CXL device state
+ *
+ * Returns a pointer to the allocated vfio_pci_cxl_state on success, or
+ * ERR_PTR on failure.  The allocation uses devm; the caller must call
+ * devm_kfree(&pdev->dev, cxl) on any subsequent setup failure to release
+ * the resource before device unbind.  Using devm_kfree() to undo a devm
+ * allocation early is explicitly supported by the devres API.
+ *
+ * The caller assigns vdev->cxl only after all setup steps succeed, preventing
+ * partially-initialised state from being visible through vdev->cxl on any
+ * failure path.
+ */
+static struct vfio_pci_cxl_state *
+vfio_cxl_create_device_state(struct pci_dev *pdev, u16 dvsec)
+{
+	struct vfio_pci_cxl_state *cxl;
+	u16 cap_word;
+	u32 hdr1;
+
+	/* Freed automatically when pdev->dev is released. */
+	cxl = devm_cxl_dev_state_create(&pdev->dev,
+					CXL_DEVTYPE_DEVMEM,
+					pdev->dev.id, dvsec,
+					struct vfio_pci_cxl_state,
+					cxlds, false);
+	if (!cxl)
+		return ERR_PTR(-ENOMEM);
+
+	pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &hdr1);
+	cxl->dvsec_len = PCI_DVSEC_HEADER1_LEN(hdr1);
+
+	pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAPABILITY_OFFSET,
+			     &cap_word);
+
+	/*
+	 * Only handle vendor devices (class != 0x0502) with Mem_Capable set.
+	 * CACHE_CAPABLE is forwarded to the VMM so it knows whether a WBI
+	 * sequence is needed before FLR.
+	 */
+	if (!FIELD_GET(CXL_DVSEC_MEM_CAPABLE, cap_word) ||
+	    (pdev->class >> 8) == PCI_CLASS_MEMORY_CXL) {
+		devm_kfree(&pdev->dev, cxl);
+		return ERR_PTR(-ENODEV);
+	}
+
+	cxl->cache_capable = FIELD_GET(CXL_DVSEC_CACHE_CAPABLE, cap_word);
+
+	return cxl;
+}
+
+static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev,
+			       struct vfio_pci_cxl_state *cxl)
+{
+	struct cxl_register_map *map = &cxl->cxlds.reg_map;
+	resource_size_t offset, bar_offset, size;
+	struct pci_dev *pdev = vdev->pdev;
+	void __iomem *base;
+	int ret;
+	u8 count;
+	u8 bar;
+
+	if (WARN_ON_ONCE(!pci_is_enabled(pdev)))
+		return -EINVAL;
+
+	/* Find component register block via Register Locator DVSEC */
+	ret = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, map);
+	if (ret)
+		return ret;
+
+	/*
+	 * Request the region and map.  This is a transient mapping
+	 * used only to probe register capabilities; released immediately
+	 * after cxl_probe_component_regs() returns.
+	 */
+	if (!request_mem_region(map->resource, map->max_size, "vfio-cxl-probe"))
+		return -EBUSY;
+
+	base = ioremap(map->resource, map->max_size);
+	if (!base) {
+		ret = -ENOMEM;
+		goto failed_release;
+	}
+
+	/* Probe component register capabilities */
+	cxl_probe_component_regs(&pdev->dev, base, &map->component_map);
+
+	/* Check if HDM decoder was found */
+	if (!map->component_map.hdm_decoder.valid) {
+		ret = -ENODEV;
+		goto failed_unmap;
+	}
+
+	pci_dbg(pdev, "vfio_cxl: HDM decoder at offset=0x%lx, size=0x%lx\n",
+		map->component_map.hdm_decoder.offset,
+		map->component_map.hdm_decoder.size);
+
+	/* Get HDM register info */
+	ret = cxl_get_hdm_info(&cxl->cxlds, &count, &offset, &size);
+	if (ret)
+		goto failed_unmap;
+
+	if (!count || !size) {
+		ret = -ENODEV;
+		goto failed_unmap;
+	}
+
+	cxl->hdm_count = count;
+	/*
+	 * cxl_get_hdm_info() returns rmap->offset = CXL_CM_OFFSET + <hdm_within_cm>
+	 * (see cxl_probe_component_regs() which does base += CXL_CM_OFFSET before
+	 * reading caps and stores CXL_CM_OFFSET + cap_ptr as the offset).
+	 * Subtract CXL_CM_OFFSET so hdm_reg_offset is relative to the CXL.mem
+	 * register area start, which is where comp_reg_virt[0] is anchored.
+	 * The physical BAR address for hdm_iobase is recovered by adding
+	 * CXL_CM_OFFSET back in vfio_cxl_setup_virt_regs().
+	 */
+	cxl->hdm_reg_offset = offset - CXL_CM_OFFSET;
+	cxl->hdm_reg_size = size;
+
+	ret = cxl_regblock_get_bar_info(map, &bar, &bar_offset);
+	if (ret)
+		goto failed_unmap;
+
+	cxl->comp_reg_bar = bar;
+	cxl->comp_reg_offset = bar_offset;
+	cxl->comp_reg_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	iounmap(base);
+	release_mem_region(map->resource, map->max_size);
+
+	return 0;
+
+failed_unmap:
+	iounmap(base);
+failed_release:
+	release_mem_region(map->resource, map->max_size);
+
+	return ret;
+}
+
+/*
+ * Free CXL state early on probe failure.  devm_kfree() on a live devres
+ * allocation removes it from the list immediately, so the normal devres
+ * teardown at unbind time won't double-free it.
+ */
+static void vfio_cxl_dev_state_free(struct pci_dev *pdev,
+				    struct vfio_pci_cxl_state *cxl)
+{
+	devm_kfree(&pdev->dev, cxl);
+}
+
 /**
  * vfio_pci_cxl_detect_and_init - Detect and initialize a vendor-specific
  *                                CXL.mem device
@@ -32,10 +184,75 @@
  */
 void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_cxl_state *cxl;
+	u16 dvsec;
+	int ret;
+
+	if (!pcie_is_cxl(pdev))
+		return;
+
+	dvsec = pci_find_dvsec_capability(pdev,
+					  PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return;
+
+	/*
+	 * CXL DVSEC found: any failure from here is a hard probe error on
+	 * a confirmed CXL-capable device, not a silent non-CXL fallback.
+	 * Warn the operator so misconfiguration is visible.
+	 */
+	cxl = vfio_cxl_create_device_state(pdev, dvsec);
+	if (IS_ERR(cxl)) {
+		if (PTR_ERR(cxl) != -ENODEV)
+			pci_warn(pdev,
+				 "vfio-cxl: CXL device state allocation failed: %ld\n",
+				 PTR_ERR(cxl));
+		return;
+	}
+
+	/*
+	 * Required for ioremap of the component register block and
+	 * calls to cxl_probe_component_regs().
+	 */
+	ret = pci_enable_device_mem(pdev);
+	if (ret) {
+		pci_warn(pdev,
+			 "vfio-cxl: pci_enable_device_mem failed: %d\n", ret);
+		goto free_cxl;
+	}
+
+	ret = vfio_cxl_setup_regs(vdev, cxl);
+	if (ret) {
+		pci_warn(pdev,
+			 "vfio-cxl: HDM register probing failed: %d\n", ret);
+		pci_disable_device(pdev);
+		goto free_cxl;
+	}
+
+	pci_disable_device(pdev);
+
+	/*
+	 * Register probing succeeded.  Assign vdev->cxl now so that
+	 * all subsequent helpers can access state via vdev->cxl.
+	 * All failure paths below clear vdev->cxl before calling
+	 * vfio_cxl_dev_state_free().
+	 */
+	vdev->cxl = cxl;
+
+	return;
+
+free_cxl:
+	vfio_cxl_dev_state_free(pdev, cxl);
 }
 
 void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (!cxl)
+		return;
 }
 
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index 4cecc25db410..54b1f6d885aa 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -21,8 +21,20 @@ struct vfio_pci_cxl_state {
 	size_t                       hdm_reg_size;
 	resource_size_t              comp_reg_offset;
 	size_t                       comp_reg_size;
+	u16                          dvsec_len;
 	u8                           hdm_count;
 	u8                           comp_reg_bar;
+	bool                         cache_capable;
 };
 
+/*
+ * CXL DVSEC for CXL Devices - register offsets within the DVSEC
+ * (CXL 4.0 8.1.3).
+ * Offsets are relative to the DVSEC capability base (cxl->dvsec).
+ */
+#define CXL_DVSEC_CAPABILITY_OFFSET 0xa
+#define CXL_DVSEC_MEM_CAPABLE	    BIT(2)
+/* CXL DVSEC Capability register bit 0: device supports CXL.cache (HDM-DB) */
+#define CXL_DVSEC_CACHE_CAPABLE	    BIT(0)
+
 #endif /* __LINUX_VFIO_CXL_PRIV_H */
-- 
2.25.1

