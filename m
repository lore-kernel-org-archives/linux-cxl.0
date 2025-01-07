Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9F1F4293;
	Tue,  7 Jan 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259069; cv=fail; b=eLheUJmwOzX+3/EoCdc2iKTTDV8Vh6DGkQ2Q3ljBLvpPHqvnzFucFUiH8mwf1iu9FVv42jycDhxUAQw2g142VIo8lxGyTFGZTbTYUsbZNNxwCkwd1DNn526zsNSj/qaBUJZ6sm8WZGhyK/FGM2mjzIo+KESsPAGzKAtpDPKFrbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259069; c=relaxed/simple;
	bh=IFLNbphfPng2yUxiFVNSFscqaoTsWFcbbKOHYmoSnJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvxmoK+K750v+g4DpPXLSDrINK9yraUXlL/H3F4BvkCJDK6fv1BtuzgJMLMMkdVU6hZ8Gmja/aiSAZrvwH/BgJWLgueczXnUzJzhQEE2WkqkQigKg/k81eKD1+ZYiPmEZ+Ae7Nk0u4ghxqCIYu0G2wUdm963sL9qw3iypIO4/sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=inUeNhDv; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="inUeNhDv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flkEko2N/MWNIAucr+J8GQkIEPGr1olfokYRyJSRBd31Q9E3zx7Cd6baeqwXYuSRJ4hmAy9qWenUseTXiBrAe/V7edUYX2NGD9CuQU0mkk04sUY64p6L0UMKPNiFKKtvZjVGc4CI0Rgz5pL8hb0qrVqK+PScgaH6Zb3awIUh2bxlqPr3zWzzj+m4BxQ2FKPqlm2+x+7/01qxyxktdQxyjOIPTl4a8C1FjXOgufGTlPNhwXOTTgqnl+p45/N108BdcjC/0Fumf53s+TZ2JVX37eK+G6k0b5Z9oGvx/o4Tm6d+E6wz13E1eZ/UG25G6rdP6WtKjIv192xgriCM4uzbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ8cBv+5t5NsEn7HGLqiSaUbNkfiftUQ/tM3mwsLQvM=;
 b=HirJp3XFMy1neTOHYaCt1NWAPXaVZXNivZcDEzIh803CyJ+nNvHx+h8RBPTXc+GYBeFdJF2UVh1sB07OoKEJCMlvMQ4y0plxHF3ly//pkMAurADAi3c0oAflqR7Pm4/dom2DihXqTTITam+oXUegVl6cEWB97R84QsA9WEIPsvQiMykSQZR23COmatPbRA+NSFpnQLVSfATw9okAGgwd6H3ieVGCgLFopB4xOcv9EKjkL/cpvNts36RBWkTmnm2dRCngf/kXkIfjKeU0D6eoQz4QnXcfd50AzfNjSwRYBc1+rhJJtKRgOUKptRdH72Nk9iveFQ4GMgOXtUu3/Ua8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ8cBv+5t5NsEn7HGLqiSaUbNkfiftUQ/tM3mwsLQvM=;
 b=inUeNhDvssEMjHqAQhWIeiTEY/oFCHYWs4PgCd/afyJvMGUTDv0A9TwS1Gi9KsZRomSA+L72CnzyVLQqFbcyK7ZPWJwDXMdQsL0GPV9iJE9WZjG1IhNITQP5jr04d4pj+AD7VKgXwe1Lc9XRzgsTKYq8mzBk/yyVTtWw8Qr1820=
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 14:10:49 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::d0) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:10:48 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:10:44 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 02/29] cxl/pci: Moving code in cxl_hdm_decode_init()
Date: Tue, 7 Jan 2025 15:09:48 +0100
Message-ID: <20250107141015.3367194-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: b78f34d3-d310-4546-4c06-08dd2f25161a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N8KHFo4cF1uiap7YcFPEnFOvRhZDOU4H/4hwQ1J+dUq+Q2wShmrmkwf5Hhcz?=
 =?us-ascii?Q?2nz4CuFgyiDLqgVWR3jCwoLLyATx/xxJOaoCVOnDtG6a2hEG6wTNiGtMW5ZO?=
 =?us-ascii?Q?OxqZQEfu73NSKhynxXepf0yLvR5nLbVGFpWuM4hqgUhap+SCR7SUHnoT/+S0?=
 =?us-ascii?Q?bB1jxpkizKTGaC7iA0u6GMjHQCx+zyoeqM4vM/Dd6hm+VaY5Y5QC7bZ1GUX9?=
 =?us-ascii?Q?MZvOhbgUSw7wi4M2n4ikR71BTSkISvcBKQpnnQv7Gq0T76062NRasnaF9vAB?=
 =?us-ascii?Q?lGaSz+Twio5j3cevRd6+V0/BMCwrvN17WlZK8IeqLkLRMXYxBapv5aL1kdg4?=
 =?us-ascii?Q?VYieVD46EouO5LzmwehbVR/0fKdxfAs+LrqhmHEUHwVX2KWGYkZcDyr/0Zvr?=
 =?us-ascii?Q?g3EauCAUAhce0pCQWEiYcPMMO2H/O+LkSQHmRBYhgbndvfWWw7oqnOqyeGUv?=
 =?us-ascii?Q?KLniYL1m8SslYic4wUwK3X+gcneFyQRDyV0cEjRncEbmpsMyH6uph+xoSyzv?=
 =?us-ascii?Q?s1431GFa6ahezqG6/O1g9PZnyVWGAQEcwpkrMc4yFo3dqVX3g3Jza4t7JH2K?=
 =?us-ascii?Q?5GFwUZ2WsLByE4jH8w0djCiOllVLgwew0F80cmU617JM2SP8H1NgAwtYJ2BC?=
 =?us-ascii?Q?WM9vRLndYnUjl8+dCKm9zUkcxG3KfUWlaXdzxoQa4SMEXbaHZ6y7iq7Srkns?=
 =?us-ascii?Q?DTsz2ZOVHmJePwQiiOoziLelpSwrdgF8hHd4tCwCit3xtGUFCR3t//G0CU3H?=
 =?us-ascii?Q?V8NXl5CQ8JcndmHevbQgXvZgPmWIO0gYZ6NdmxUJi9VablI7QCzttlyr9aW1?=
 =?us-ascii?Q?wNQOWdqEyvpgEd9dOPnogb3v82jU4QXS7x8dMagtYNYVhoBNJtB2y+1WDWod?=
 =?us-ascii?Q?f9wqdvuTnqtyv+4v0uyllqBLqtb0E/YauSQA1XCdwXWuSJ+Ef57AemONEiUX?=
 =?us-ascii?Q?C6i7GW0ULCNSUx/Cc18hKT53GwJp2rHDamcF8CnmtekSO8VcbvZkKLDwXO5f?=
 =?us-ascii?Q?DzTLlNJYU3FYuEeYztRj4LCMJz+y95aauPZ7V9jAt0qEVBVv8/rCnjQBdHgz?=
 =?us-ascii?Q?xzjck+j83gZlgOu4EN4X4fVAukqFQ1WHvZjZWNLZCok3l+t6NcuEY2yoBy6T?=
 =?us-ascii?Q?35aseeutlwHFsRzioZIXCiA2ADvBjlryHTcyjWiWNkEFeMvpWyjuMzD+eoQ9?=
 =?us-ascii?Q?uTFn4tDhWBg/Gdv+cnz80JmSz5V6RlOCHN81+bjo0VtCETozKKzTmD4hjR1E?=
 =?us-ascii?Q?IiTE8qrNtbVWAFHrGNWiwPaH1Aeb4KPVdj25Pgvfe5iyV34mmVuZJGe/9J5c?=
 =?us-ascii?Q?w1oJNlx6XDWeRSzYajHhivkbu62OfYYXO4ztPIPYqMq0XGf7+1jCPGXjDXAA?=
 =?us-ascii?Q?L9KrOPSNx5/bPeFdQ43F8DoorLyqLBcg99R1S8rLeAiDinvu3WNZhEdddSq1?=
 =?us-ascii?Q?y+W9NIhnO9kq5IITu+l0ffcAF7bfim3JDiQB+1Kzu67xVsuXR7fdftX6oojo?=
 =?us-ascii?Q?bByCWAt4GyaI89M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:10:48.6033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78f34d3-d310-4546-4c06-08dd2f25161a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
cxl_hdm_decode_init()") changed the code flow in this function. The
root port is determined before a check to leave the function. Since
the root port is not used by the check it can be moved to run the
check first. This improves code readability and avoids unnesessary
code execution.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3e8d20f8955c..d206378c4cbc 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (!hdm)
 		return -ENODEV;
 
-	root = to_cxl_port(port->dev.parent);
-	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
-		root = to_cxl_port(root->dev.parent);
-	if (!is_cxl_root(root)) {
-		dev_err(dev, "Failed to acquire root port for HDM enable\n");
-		return -ENODEV;
-	}
-
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 	}
 
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return -ENODEV;
+	}
+
 	for (i = 0, allowed = 0; i < info->ranges; i++) {
 		struct device *cxld_dev;
 
-- 
2.39.5

