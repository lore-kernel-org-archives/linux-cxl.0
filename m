Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937622;
	b=Ksk06omSXSIbXQJHcLU2n0ORfMmpGZ3qYKnRXrdemeZyWVFTFTO0uYwB2M+TMBVKR2lD
	 y6gJ8VHNUrKDx7Zvi2OR+X7fNOZ1wAPKwf82CB4PdSsnf222IaS2J6XhoToaUdgZoBt85
	 3WQa1HHjraR6ZO5iwL/dz0oZvVkgmNUsQhnFO2OQkyQscuB8fMB0T719QZmXXCiWE/iUw
	 VT5yybloThGnjV1S5Wpk+7PWmqMP+SGQQAdp1nBImoBwd83Qbm0uypzWkFEBGj4doXkdz
	 yjWzzpCKt81TkJjTkIGors/V+3FJ2Qjnoqtt1nqzs0wujasywaAuA4ZBDRDomIDM5UQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937622;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nCUDUXtF8J7aFkCrXrb8sivdCXXhllAppz6SzyG86Cg=;
	b=NqaZn5TcB3ah2bZJsFmsx6f6xXrSJ63gAiRqA8ZhEINjPq8R699ptySO9bXBk0AsnbM3
	 9rSb3wQbp1I1fMDukb41MhJycNVQ81OvGnf0MpF/J+CBz3sB/JDKgvLH0NwZjqr42VP55
	 6nb6V4AcLWe99DPXPcm83hFA9JRQQWV3chUOTqwgUEAijlvJGsQnuanXKM7Q/ku65Pfnh
	 n2FCyHlt0JudfixCNueZlhL65lcTIuegkaMUHuaR+Edovh81/v3aY9EN0fLQoCcWOXq8y
	 C5yB+nlENCug5G5071Q4y57xAZelW5N624r+CgEEGimlXyF7OiJS9JNRI4ftouUb4dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aMIqMdOU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.62
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91A606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A91A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aMIqMdOU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ6Zi1c7Ad4X4D5di4hX0DSyV+q0dFfNcQtWdCc4jEbQNViZEQov46/w5y0L4DpPB0OFdOJo0huM7zPaKTNuCuZguoreoOIJtkRIxEFvE7wlmD4dY2Z89cNqC3nrx7epmJh/o0PylYKGhHuUMGWb7JHNv2xMrPY6ho6lq2/jKr3RLc/eix+t4Tgl/sU0f2D88pgE8SfIIseAPumFP5F5HTpudJ0l0J6CkgoCVOF+ErhmogYCWzS46bn0iwRubs9ExjB712gO2gkRfxQjNbXx8YV0XQU9kKyi0niJTzHEaiFhRYDIazczVvLrUDyaZkgrs8xDqemlr11i99/VxM7PKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCUDUXtF8J7aFkCrXrb8sivdCXXhllAppz6SzyG86Cg=;
 b=tg+FWehkgIMsXkQg0q0sBQQqmbRw+bzBGpaBcua2wcHH4dYVYjtBeV91NVqoIgqN1TsbGvyfoakVMTj+PhY3CZqGBqxcqJeQcmg9H9lOjSVmQvRYEdnb8Jj+p6116iB+Z91RyRSwJidWTO1IDIqS6bRblIpXHOa0Atd8ZbNvHilLgSPLYOB7FZsLU5VHzjkdtssNE8uqnUZDVT3BCXQ4t27cZJpptpIi0FZHx4jNu57MwSnkCs9Go35vgWsLd15/3eaHHwEB0wlIOJZK59YTGbcweiOpuBVT+bdPgtZNFJZXOFW4dJholqHF2LjqJ4XY3dkX100ehTc15VR0uD8xXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCUDUXtF8J7aFkCrXrb8sivdCXXhllAppz6SzyG86Cg=;
 b=aMIqMdOUprcPqtDYDSAxQC4zC5Wdr8nubRISyfFu7Hkn9pDkZDnRBiN+6RVH6gZ+GNaZAT0fZ2dS9Z9dKTZK7J3sW3LKtpbPR2SEmLoiHsK6njlRyzND2NlD8fYbzgJMWOLPO+oFnLV3IKAul8HapiEAvZ+CfdzWeyEYM/lD2Q+5eFmfefvrAIwvAvTgfIESmpsnermB0489oRVJ+sCIC9MbU43KbBpR06jHKBts34xW/c3AQna5deSl8eO5AfdlrxX5pwZEo60ZHA9gvCi7CjMHd0NscifuSP90CFrM1oyz8TEQXk4NcHKFzFdu/1E/r4toPG2kE78LNk3CO9O07A==
Received: from CH2PR10CA0021.namprd10.prod.outlook.com (2603:10b6:610:4c::31)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 04:00:16 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:610:4c:cafe::1c) by CH2PR10CA0021.outlook.office365.com
 (2603:10b6:610:4c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 04:00:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:00 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:54 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 05/18] hw/cxl: Define the CXL Device DVSEC capability and control bits
Date: Fri, 6 Nov 2026 09:28:58 +0530
Message-ID: <20261106035911.1280066-6-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dcd8f1-0cde-4614-685e-08df3bba775a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|22082099003|18002099003|10067099003|921020|261022075727099003|261102124527099003|11063799006|261026121527099003|261028144727099003|261102123227099003|261026140227099003|261022105027099003|56012099006|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	vDMYOP9a6tIF+ARcVQnfnmzu34vpNZV6t9cIbz4NYAbIZUtwoK38R0bSgoVMiaVrPac0DB7rsC/LiM+om3DZCz2FBUl3M0L8PX02MsFYgKbI6VOoizh7wlg/mR2yyPf6B5QR7rtAZzysiR3Fy8W4+CocV0xZUq3pY2Fi+8BhWNGCJ1WU/npfPtwLP5aP2Hg99QCGlMCFbkL7mfPdEOw69/XqrVsdlomCfNPBLzgDlZthfKNwHVQ2Ad07axXo3+lhS+jQFCpscQH0zkSoXnUAu5Cvcgkt0uZhKJpkWyLsDepqq6ko43nmkQAH6ennlLnMxnU8gv7NChae67Ljf0wsSJXJn5mxbi28Ipw3pW564IQI8O3XknfrHlWRlKQKOwIurzmteQLOinp2pRm48NzPnptDb/G8mOzDyEvjdKraUeFobH6PO2bTJ3mvGw7WD845oLhT5cw4/jlmdmgpu/MgtQICHzbAIqICxb7ltOiJAKcQvxK1TW9gHWJI6J5jrxouPnjJPkxpRQl4T1O6Rh+5pQinTvt7LiVzr/0DxLJ9A5ykm6FqPFN+eX72CoOGk0rSU2+PEZV7nKd8qTsMEwKlrJnVvw8aPQc4nlhXNMjExD9dlsyuOQBvbEIY/LU13XMMtVhxiMYp1mLhmaDRUY2fc3sXKVaalXEZS0MrDqPN3Bl2nPQorEd0jVb/5cV3cECWfWo1VBcMUqEYM7xQJ5eNiy10Z1ufFnLGz0oTF8V7u0qTfMtRHsViOTcvlj4XX41M
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(921020)(261022075727099003)(261102124527099003)(11063799006)(261026121527099003)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(56012099006)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0yaCkieFfXlLA0pE2w9OWdCKvzsgnNbRKAx2A99W/NfTrx3o7nKEw5+hJXe5NsREvhUcoCVCvvco4kAK1dWA3lZnh/g87iZ0+JDgcFlWziGUAIalFffO8VbfiM4WVFdHC+xp6ZUtpacPMkvkDw/VXvpcWrPT2vIiKI14x7oaWhZQPS+CzczibEvm6xX/slKjVAkWBPKIGtWG7M933/MBOl7xmKPv2rt6plUBol1DHxAlYnAm5pZn6i2P80+koAo5/WGN6FJ1NTsvc2sbpWn0K5hWkbKqca6jQY+faaZnADxiSrjvlmyf6Z4zvHex0Q57yKWbJI0r2piLOxLg01UhLWAswapNMy42596HwM/XFNx0sq46DvvcjlMVQw2v3k89OsJXgAkW2rCtWiaSQIBE5u4iO2iTFU7OUR9olWv77cSoja6zlTt61qWZ0XN/253/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:16.0478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dcd8f1-0cde-4614-685e-08df3bba775a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441

From: Manish Honap <mhonap@nvidia.com>

Name the bits of the PCIe DVSEC for CXL Devices (CXL r4.0 Section 8.1.3)
that the CXL Type-2 device added later in this series uses.

standard-headers/linux/pci_regs.h has some of them, but defines them
with _BITUL() and __GENMASK(), which it does not include.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 include/hw/cxl/cxl_pci.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index d0855ed78b..98efa529bc 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -96,6 +96,37 @@ typedef struct CXLDVSECDevice {
 } QEMU_PACKED CXLDVSECDevice;
 QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != PCIE_CXL_DEVICE_DVSEC_LENGTH);
 
+/* CXL r4.0 Section 8.1.3.1: DVSEC CXL Capability */
+#define CXL_DVSEC_CAP_CACHE             0x0001
+#define CXL_DVSEC_CAP_IO                0x0002
+#define CXL_DVSEC_CAP_MEM               0x0004
+#define CXL_DVSEC_CAP_MEM_HWINIT        0x0008
+#define CXL_DVSEC_CAP_HDM_COUNT_SHIFT   4
+#define CXL_DVSEC_CAP_CACHE_WBI         0x0040
+#define CXL_DVSEC_CAP_RST               0x0080
+#define CXL_DVSEC_CAP_RST_TIMEOUT_SHIFT 8
+#define CXL_DVSEC_CAP_RST_TIMEOUT_MASK  0x0700
+#define CXL_DVSEC_CAP_RST_MEM_CLR       0x0800
+
+/* CXL r4.0 Section 8.1.3.2: DVSEC CXL Control */
+#define CXL_DVSEC_CTRL_CACHE_EN         0x0001
+#define CXL_DVSEC_CTRL_IO_EN            0x0002
+#define CXL_DVSEC_CTRL_MEM_EN           0x0004
+
+/* CXL r4.0 Section 8.1.3.4: DVSEC CXL Control2 */
+#define CXL_DVSEC_CTRL2_DISABLE_CACHING 0x0001
+#define CXL_DVSEC_CTRL2_INIT_CACHE_WBI  0x0002
+#define CXL_DVSEC_CTRL2_INIT_CXL_RST    0x0004
+#define CXL_DVSEC_CTRL2_RST_MEM_CLR_EN  0x0008
+
+/* CXL r4.0 Section 8.1.3.5: DVSEC CXL Status2 */
+#define CXL_DVSEC_STATUS2_CACHE_INV     0x0001
+#define CXL_DVSEC_STATUS2_RST_DONE      0x0002
+#define CXL_DVSEC_STATUS2_RST_ERR       0x0004
+
+/* CXL r4.0 Section 8.1.3.6: DVSEC CXL Lock */
+#define CXL_DVSEC_LOCK_CONFIG_LOCK      0x0001
+
 /*
  * CXL r3.1 Section 8.1.5: CXL Extensions DVSEC for Ports
  * DVSEC ID: 3, Revision: 0
-- 
2.53.0

