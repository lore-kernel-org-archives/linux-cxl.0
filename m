Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2C46AEC6;
	Wed,  1 Apr 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054423; cv=fail; b=sGJHUr3ulvqBZrg6EoErpRw0Uinr/gLjfTiS64G7st5dCO6Nb6OQDA/LTqRbIq4VqEChrJP6SbPavNIJBdNfmB5qLMzhqZ0HEpr1La0xtsVzrww9o1o03fSxGmeYBAvh9MM/1zVCWGi20Vhkz5HtcsfUBGr8kgu9p5Poc3omc7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054423; c=relaxed/simple;
	bh=CM3Omvs4kPJIEeZpVHQjTd2p5V/VJ/5vM5LDlIguEIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CS1vazP2VCbtwagHJiy+CqnwW6101mvWTzc1I8c2lFOoZnSuHLudNJNNoh3MJIFXV42VV5j0Kv3w74JIW51/JB42wf0w2x7bb1haD34zS9CLJQJ2ewfwaFK1qXNY+6W0pL7VKOcOIwbWlZqFSUkfceKb0vJkYYQG+bv9GajHOgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VNHSVYJo; arc=fail smtp.client-ip=40.107.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VNHSVYJo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNGzFb88s9YMU2qbmmENp6ymip+Y7N2/cu9q3WteW94WHZNJjoX+C0dM5zftRRAQtnmks86LcuyvX3bRRoLH+TrArlQ2jVIwfszNNwLMBOfhv3f5Mh00UsLSUlFDXcFNTqgPO1rbe5CFM5qiRHT5pEbwnnlERcDoFhD6cFhhD7Fty0GNoWjPZ4/vG06Vhii3ys7kHGyKDcH9jiYTJxsZtWaotLw80Oi1N1mia0ci55O7HRZhVW788kIhdUTfVzEaEcb8KGN6dvdf5MBZf9BmDm90y/TfwSvVLhIpDRpW8Rpwo5twy4zYyBg1Wp4e/uyVPSCW/lu9sD+792irMH4LFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOhoKZWIQIV3EJwsde2rjAKTmFymKCOodHc98qR7CBQ=;
 b=fLKle9xJs50gSMe+hGqE6QezdwOjXQgPmX/mWOMq5TsufV6+5Np3hFAMaX7tmrorjr0a+qbBsg+4mDWceiprJ09ou7n1ag9+EXeQnSJvkSEo/UwTF3XJwlba/fpD/APciyAx/2VzUFYdjkzzhcBTsSx3zdfReMIP4QZizbuP53OQnfyU5spYUpxkWyCg336T/wZcn5vE8jiaUD+iM17LqrhSLVPGArTVAO7/etDCBAjR3eloH6fP9XwydATvFEizTN7sNBSV/D+A8gayfRwhMHCqnPo7tdOkMcmr/bUV1MjBs818HGNX603ccYVWHtj+E/007JoksoLJ+fpEiyz8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOhoKZWIQIV3EJwsde2rjAKTmFymKCOodHc98qR7CBQ=;
 b=VNHSVYJoJv3oNdQUfcfx0CyVCx0oIAFhDXZLzZu0KKYhHY3yZhowkcibUv9qzd43Y+4hoELig1RMdifqviIwXI4bH701y0mzg/Mt5tcbkYWTpT/SwiRGUriYeAjwjgNPrjqciEJ3Buh7qOSuAJa6C+Msd4Ku7Kr1fEgJvec+gQqxjME66EyZlKqH+hYZJBJV1rCwDieTu4JAp6JDN1mEAj+CU6ZtHZe1rd5kvoLfIrvNDKY7Y6WP13EOqghGOgafYaR61kJq4xvN92/DfgMN8NvOn3zFdIHjLLC+nIhccO9I5r/3gplN8rL2EPwLPrkLorRT37XNo/VIvfwZJ8l44A==
Received: from MN0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::24)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 14:40:13 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:52a:cafe::c5) by MN0P221CA0024.outlook.office365.com
 (2603:10b6:208:52a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 14:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:40:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:39:54 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:39:47 -0700
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
Subject: [PATCH v2 02/20] cxl: Declare cxl_find_regblock and cxl_probe_component_regs in public header
Date: Wed, 1 Apr 2026 20:08:59 +0530
Message-ID: <20260401143917.108413-3-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fb7f3c-3662-4a9a-1849-08de8ffc94e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	DlRZ4/MA9u0Bi5rVK2hZwMaOFc2ihMh+PbeHjfUDW7QPtbGjPvQaHEMi9SMLX/wlBS3OJA9TbNbUeU92taiIP/Nexdma2jkJkH5/cIC74WIAAli/jNonv+SqY4U1ICsY4kAmTkMGXM8g2VZqoKl0hCLZkHR6K9CVI+GFS4n3c031I2/tY20PeUlgFc7MjU4EATddwhkQ00zL30Ngk5JAsNsR6TMC2eCW+gBby8U+ZIovXYEhvkmREnDOcLRUN4EK+dyPTHFChHaIM56SruXKLpRVzL9VGn9T2puTiqxHJn++ToHfVpMBznmDphSwdU/BJxhWzQYcikq+1uvDZgjNxwrKXTHWnDIxuVCxsrO0KqoueijLS5ECjVbMOcLKgMfCpBN5n6TP7GbOiBbUMvUDby6s0YSCT46+bNRdRCftwY8cSZrXWJmJ8Jj8GCft7jYhz69y10bv4cqRvTqWbhqTOuJn4nem9J8yBy2RRtrH0wUNddynmEprYO+FNrwQcH6uIoJZBImrhq4O0XiCPEfcWAPE908E3Rrnugle6tjLFDybvLX2rh9EBWgkHqRxq4kppRhwUCDdiTWuqEvs+yqzYqfoB0J04nmVESwESpeidlqUOF4y+WBAvSXvqN+iadUutVk8gvSjJRQFrqbLIfWm0C44b4yTKnfQ4ILt4dGqzh2sfIpissx7JFuD6jfb02SUpL9hzrLvo/y4wr+BTxyQNxIAznrRrJLNlAbclHzPFazO8y+y9z33jRIhP95cQnKWYCflBOznsP+yrSZ5Y0vpVtOVb4KLWUS2g3d5ONDZPSWcKZN9V489K5Jr4UDM1jYi
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1tJliM/9PbGpEUlTqchMNt9gUwLA6ranDCjWm4racSwBwz3A6JtAwqVmZ2ZLlyQcyWqMXuEgH2hjvfvg7UIL5V7+tPR1DNB37jgc1qh57CoDk6A+ceBC6nKga6PFQI9C9j77ESso5eF0V7m6WCDlsrpLFNXhyWJQovAFDMNOsxOFKRvnpZMgwH0TxmXmZIBfiw47SwFCFXTYDr6kneqfvjHsZM3CIZOyMn0119BgKoadrywLkX7TC+Gv8gORIAgFEGBLEoUvTxEQpdmIFocbJPrcFR6qdLvDIgjJAJSFgFfnpxzIbVs/SSbs1Z9bpGYGpZl6RNdq9pNj8+Cdj8xv32RCYvExnu6+ncjPr5oZia32NhljZqy3jErhExNOeKR8baa3Z2uAv/2dzCe3Gl1VMqodcBNrszxlXo1MNlkZMfgea8F6fOq2W6u5Y11KUIVr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:40:12.4167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fb7f3c-3662-4a9a-1849-08de8ffc94e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911

From: Manish Honap <mhonap@nvidia.com>

vfio-cxl lives outside drivers/cxl/ but still needs to locate the
component register block and fill cxl_component_reg_map. Those
prototypes were stuck in the internal drivers/cxl/cxl.h.

Move the declarations to include/cxl/cxl.h next to the other
vfio-facing hooks, with stubs when CXL bus support is disabled.
Drop the duplicate prototypes from the private header.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/cxl.h |  4 ----
 include/cxl/cxl.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2b1f7d687a0e..10ddab3949ee 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -198,8 +198,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
-void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
 int cxl_map_device_regs(const struct cxl_register_map *map,
@@ -211,8 +209,6 @@ enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, unsigned int index);
-int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index d86faebb99b7..8ef7915a51f7 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -286,17 +286,33 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     struct cxl_endpoint_decoder **cxled,
 				     int ways);
 
+struct pci_dev;
+enum cxl_regloc_type;
+
 #ifdef CONFIG_CXL_BUS
 
 int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
 		     resource_size_t *offset, resource_size_t *size);
 
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map);
+void cxl_probe_component_regs(struct device *dev, void __iomem *base,
+			      struct cxl_component_reg_map *map);
+
 #else
 
 static inline
 int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
 		     resource_size_t *offset, resource_size_t *size)
 { return -EOPNOTSUPP; }
+static inline int
+cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		  struct cxl_register_map *map)
+{ return -EOPNOTSUPP; }
+static inline void
+cxl_probe_component_regs(struct device *dev, void __iomem *base,
+			 struct cxl_component_reg_map *map)
+{ }
 
 #endif /* CONFIG_CXL_BUS */
 
-- 
2.25.1

