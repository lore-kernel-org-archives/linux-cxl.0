Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1927C162
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754869; cv=fail; b=BIvMEDzoQuJVudrmzVS3x9IEZ61qwXMt2IVd8kbr70xhFZ9NTkY60orvTmrTS9UyZqHB+QowP8FlsOhmfEJtIwgNJYkyZcZ/m6HFEImR9OY3gCPDvF5amNRCGLTI1JMqecUzlZNjWDSMvsaQh3VVMokD+eYEBVBb+dEsW+U6Kr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754869; c=relaxed/simple;
	bh=xkqbT/3g1qgTdlZGZExyhDu7qiSAhhAYg4aHQzIwSp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TEU/JL5S0oW6TqPaLpdgV9jLK1Z4eFSIZEqG6D+vY0rm2Pt1CY8znwvpeI+UNJ4/rbb/gfQyHf92Yj+HDz7beZ1G1bUwH5gQCLj7eO5W8eEHjbfxIalTwHm6oYcMgXQxEvVFMON1smygDdBCXeoPpSp4K0vA7o+IeKWCCz/0fKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=14+uDmEn; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="14+uDmEn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2a9Pw3HVfNB29pvq7bCF+xkoE7zmykmcsm6YJdA5ZMbAtN1gCgh5uOAeEuveTsRV6hmL2UFUMeCm6Q2O6USQwKK2gv1GSwPWZJuk2WleySCW6cA0e9KWS94YcNn7CG8exZLwz0euGCNo5N091y+NB4qxdG1Wpj3SCFmTQDbhMQDrMpTNDSVfcrVw2E4dUO0XvmdmhquQ9ta4w6ZE/2Li3vgDcwc0gg/S1TGLMgW/K3+LnnhucwUjk0vFa33Ppr7FOHSC4ZwWP8nzvTYkJTjA8Ho2fprQqp6v+MGmPzBnXJv6wqAfrFemvbvjr7xsJU6o0nJ9IePJR5Q14QY8kUqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHKFOWIqyZL4d6COxcsMWGwLRXURDNlh4tB4eBqtsa0=;
 b=a0ZlLFBCOePI93YkpxqTi+hyzazfUF7Mgb9Rup4Q/zjefbKs5IPH5yT8l1I7m4sKlXiILs7CXmftcc0M5IB5yutLw4fTZgdmxN2mIeKUyPMkotasnT19O2XE4cD02HH6YTtm5gVrxE0f7mCydy2Ld/1LulbAgXP1Y4K61dse3KBxWfILFoqRYCxk2i1ZODXK0PCt+AAXl0MOu+dDXE4Uju/BsHKIky635LJG/HSdUvELX/tERIZO8JbiaC3PXfIzBEBY/dyfwaUwsANt6J2OXHrt/6IMjs2yu2LMBV7QrKujdKWGWWJiu/dXy2s2gyvawAleWfQjBoCo8Ci5StJz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHKFOWIqyZL4d6COxcsMWGwLRXURDNlh4tB4eBqtsa0=;
 b=14+uDmEnWKvKfStSPTjwB5RAaqFbIjrP7Lx0LcF1uBIIMmpga2NKobxC2Gi5AahwxBjX1noxx5WJQ6UfDujxSOhVbQqJKdITyvxgwyzaVnuWrbilTGxbi1r8ipGGS4UH5bpj+4Vd6tVon6xlvuCy/vUwQGDK6BclNJrzUlTYJJI=
Received: from CH2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:610:4f::37)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 17:41:03 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::13) by CH2PR18CA0027.outlook.office365.com
 (2603:10b6:610:4f::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 17:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 17:41:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 12:41:02 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Mon, 29 Jun 2026 12:41:02 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v30 0/2] Type2 device basic support
Date: Mon, 29 Jun 2026 19:37:25 +0100
Message-ID: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 166675f4-a3b5-4ee9-3615-08ded6059744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LDiGejnAgPiePpicXRNDGq6Aps/aLI8dI+tNZecwjCU9VSzPX0c26OzXHWTqiZTofw0jok9yQn55SISwNs0TvHaeASyGPiNE8gui344fpQD1+Pm7e9tSgsysBZM+t/QjrQ3X1IOzcM7TthsDeESEWVugeshmgAnP3dqxrQZTEmrezvbfjekIgLp5GvALqk0hg0Psli2oBJkJuzgqGik0etQfE4ytL1VZNJSlBpKlaFkytsr/VNNSmngR0Vnu+0xSmTCoY0ZCMLCVOihfAIlhNLQz8wQazMGvUR0OuBjdTDk3Tm5nRA67Rly10ZGT80/p+oNJ9sEF1VZj6sdqUfXUwj8z4qvFE6xf75NG333Q5x3DnDQsAhXARtNbx6+Wttbb0NSj4dmJIqlHpqRvHxbP9OqmTMDZnOOC1EWzl4WHcfZZZQ26guPsVcElyQTePCeQxxrmcXeAgqguqydOZSZ8x6nrk3Y8gtHg6bV5wIzsaThHEqmjXlbqUYsBYy27F5aEWznPUGAFm1wiYb0Zrr43VCVRlWww8ebwThebnZ7RiiRL3ro5PL9HPdZRGUrqL8+uAydSVU9zsgwKXjKvn9D1QBPiOeiLZ1JYdHEbeVPQ7dtUIlLda7NX9iWH9qA7gOqfiXlkqUq4dlfdKINCodDz6kTRK/Ucj94vmn/ixnLajLy1KEduvFlNfZ4+m6hoit8JsVQkeIwu9V+RF8thTNH1Dw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8v8zVhEJf9Bh/hcfmWhj20h5NMdnNRWz4eGF251jyQ3RCgyEUJxFZt7qdRy0Yze9ro52cg985SxhpVGNJGYTxMRITZ+085cV/EWWMpOuIuYlkhChlzNjylNzdqCZmimWasR0TqIZZdcZv/IvIfu9LyBSn4Wws73j1FzDrCviEBbB1Vj5neu0pmgf4zLKAhYzepsnZ3G+0qdxltWXY/+r/BDgWwF/peE+Sas3c9CiWR/bPp5nJEwD9+ulX2cCVNX/2laqJBXzhjHPqCiRaMeOQwLFLuQ89R7a1FvuXDz1wdEn3Aw9ndSm7Kj8tmX+o0ieyruwEFsFpq1qKit9/rzbD0+PSWRe5OERQmqLd6A4jqzgUtt/hd3Qu29MMOyzsrXt+AwJE1fjEeUwqy248LtB09MkOakFPIYE1Ewiw8kQBFfdSG9CaqIL0Rp1hnx3LUDb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 17:41:03.3394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 166675f4-a3b5-4ee9-3615-08ded6059744
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999

From: Alejandro Lucero <alucerop@amd.com>

This series adds the last bits for allowing a CXL Type2 driver to obtain
a CXL region linked to the device HDM decoders committed by the BIOS.

For the sake of merging those changes and the driver using them, this
version only adds the changes without a client. A later series will
include sfc netdev driver as the client.

Changes from v29:

 - Only cxl core changes.

Changes from v28:

 - patch 1:
        fix doc (Ed Cree)
        fix error path (Sashiko)

 - patch 3:
        removing extra + char (sashiko)

 - path5:
        remove stray change (Ed Cree)

Changes from v27:

 - patch 1: make driver probe failing if error in efx_cxl_init (Dan)
 - patch 4: add unmapping if error after efx_cxl_init (Dave)
 - patch 4/5: move cxl_pio_initialised from patch 4 to patch 5 (Dave)

Tested in the cxl_for_7.3 branch.


Alejandro Lucero (2):
  cxl: Support Type2 cxl regs mapping
  cxl: Support dpa without a mailbox

 drivers/cxl/core/core.h   |  2 ++
 drivers/cxl/core/mbox.c   | 51 +----------------------------
 drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c    |  1 +
 drivers/cxl/core/port.c   |  1 +
 drivers/cxl/core/regs.c   |  1 +
 drivers/cxl/cxlpci.h      | 12 -------
 drivers/cxl/pci.c         |  1 +
 include/cxl/cxl.h         |  2 ++
 include/cxl/pci.h         | 22 +++++++++++++
 10 files changed, 98 insertions(+), 62 deletions(-)
 create mode 100644 include/cxl/pci.h


base-commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686
-- 
2.34.1

