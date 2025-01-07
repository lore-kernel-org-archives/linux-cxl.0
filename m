Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96B1F4260;
	Tue,  7 Jan 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259072; cv=fail; b=F1MOeEYJ0EH7hDADiJh4WOJUyQxq/wMiXPPmQ5DsSKLIGLdxMsbu0giN8Lbkk7Yl7/cbJP1wM8TqKPC0LNE6fDW2wQ4mhHViY+nm0Q05fvNQXmwaqSjGTYhDl8kpMAhnFH71HkJPXs3KdV4/8EFaCVzDtNN2AKhC93j+dJesiDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259072; c=relaxed/simple;
	bh=88eJRNGXb6QfBwxgsEnvfSp9SIlfgka8fZvShbmsDyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hd1bC2gHSM5FS+4EuBOMN/HrwyXsDLefK0AKoY/xLEnS+JrK/HSGROqd0Jp74Jzmtpnht+V2qJzCI9AKh6jcoO+wgg5lg3btEOMfceEFMdbAStGX0WVK63QczxlHDpnajyetDlO+EYD213YFu6f+eZZv+3I1MUQHyYzqREQKAuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gk/6r8Em; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gk/6r8Em"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaIXFRrKlIKWew3cNqnls95YmUsVJanIXEeeQTL9VR6vm3Ch2Vohv4puQ7e/xpZzNES/HFZNyz+I9/OfEteMRE4xK4MS7caRt6MFT1bFaFpmZp17nfOCdg9jDN7nrCsZsCvY7ZjZUEAG6HU/mFDdMjrOdRrZADodQ7LjxjDn8Bqb/MgIFOTAGhqJexZplIStJinom6RGdnefD9QykwdpL64hj2klUmUUDRbm162hLoqSeTrkIe4Oxli0n8huekfDQSIyn4+Mc4oLuSuy4qR++p406C9iOl0sdjDDnZ8dpHB5Pl/iqV2FebPiHTKWiOLgEqJr+HaFd6h/xVN52x7A8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDgAh42ndYYAV48pStfabZfS/s0ErZo3tcy70FNuNzg=;
 b=Y7OrYm6VcSkdl5YxawNkWkWhNfY/apv139KUbVzsIxQAjUfMTosez5/Vdo7a8TTvdiqHYhzi5KsbBCAILAYvZKwRdwohRBIL17m2vTzBrJBqP8DJWCNf4tl63PtUJNy4hBruO8f642VOkc/Y6MwE5grGacu6ehAXhlNcyehc3Xi+tO4RqQ/52V48E26yWv8vHKj3Zl8bqqSX7C0+oWEsqor7X16LwhRwkEFz5gHIr+HsvLaWPRaCIgj/AnA1Ra14sxRfDl9+HM2lNRTWCAELVibN7U937Os1wYadBWFT0FFiMMlvsePRJ0jBjOrvwoW2NryJy0Qy8ZhEZmqNeAsVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDgAh42ndYYAV48pStfabZfS/s0ErZo3tcy70FNuNzg=;
 b=Gk/6r8EmwDrGxzkiyZwuAh9LNsgR8lEMRkaMAeniEEo7VxP2AqJZriap/g1b2UFoCrfABhRD/kAwbvSZz8nYsrP4zDaPkyJyUxydlg0dbRGbKHfKC3RfKkb/BtxSqz0/UJBVQW1glaEJjU7KJ9N2Qg8c2bVirRWmkC5CpCTw8pM=
Received: from MW4PR04CA0086.namprd04.prod.outlook.com (2603:10b6:303:6b::31)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:10:52 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::4) by MW4PR04CA0086.outlook.office365.com
 (2603:10b6:303:6b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:10:52 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:10:48 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 03/29] cxl/pci: cxl_hdm_decode_init: Move comment
Date: Tue, 7 Jan 2025 15:09:49 +0100
Message-ID: <20250107141015.3367194-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee0b73d-5f90-4084-be73-08dd2f251832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swqwigfJaWuH+xkmVr+h58mtTeEYgVyIpal59D3trVd3Husc8IC2O/Gxn7sa?=
 =?us-ascii?Q?LovJL9wlE+fbsOl3dZxnZz2c9aZbbBoeqTtA3oFEDsut6cwvhTODoFb+BvZ0?=
 =?us-ascii?Q?8Tzv+62ZohuYsDkqPu0jTgYYRbSPVqfhN+RKJKqTc8NMg8f7W3Y0bI7YCxfM?=
 =?us-ascii?Q?fgBqhZHWJXb62kbrosOXa2ZABpNiX0yb2r1mVzRQT6FTlduNJthA/tEJesdS?=
 =?us-ascii?Q?uxx4ENJ4KpzX8VzVAHNgLT+WVsOQt+HRm5pnHNZPhFyZOdw/9GJkrqhRAlkp?=
 =?us-ascii?Q?QYJgfVZ7joEiA2+7D6CgZu+sEa9kPKtc5ydsRwCvSZxzOk1xvwiyCqBy1SCD?=
 =?us-ascii?Q?r+3znwWfJvxxCXhP6XXJ/lLmBHE+BqB8D6VWxcQJmGPX6eg780FGnDEoktmc?=
 =?us-ascii?Q?NF5o7xMjDW04SBiaebTEvaflhx6hmdN+VXsgeIU1E8koeMN87V1rbcTPlThW?=
 =?us-ascii?Q?Kx9gk9bXI7lLG6acVmj6xBDJMk6mtu8zrgTXz5bVbhPACdrjO9UxuaBSwMHL?=
 =?us-ascii?Q?M8ehtfZ8ZI/d9uJyuXCD8v+X3rgFsCNUG6afkwrqgn94gM1jRf4DShsDV1q1?=
 =?us-ascii?Q?SpijF5iNsM9/mn4AJKG1O0ArJ43ejX2Cf6eF8KHcZ+pYv1DqBEj58rhenSUo?=
 =?us-ascii?Q?CKHtCGd8uB3xmarZaY/HF542hoWMo8MgqjNtz9Hs4quf9t3II4koxyLS7PjO?=
 =?us-ascii?Q?OHHQ2LNW92x06EEbhO9VDlEqFRBA39KYBeBX/IHbDB/QqToLC2Ht1FYo1B4C?=
 =?us-ascii?Q?X7nVkCz1rR82FjGWS0Rp6EOX9fiSw9SF0ZLPExPMdFYxc82fgDfyrpwOXab1?=
 =?us-ascii?Q?iuxeHiaYJ7BUtKC8H5LDI+Y4/OMD0DIx4bjKR2EViaoO1GTsC8XalpW9Do0T?=
 =?us-ascii?Q?x2VX3tWVszUXXaTgZ17Pp2lbU24C5ESpd3sEvkNEw3yXJReRJSS0M7ID9oQD?=
 =?us-ascii?Q?ykZvEdbo+sr4I6fqSXBLoiZ1sk9GBSqGecOPmGpfPokva+6eiwnKRx+E7EyJ?=
 =?us-ascii?Q?xfi9s36xzBaM5Y104xmLf1L2B0SNV1cPMKJz6WG4r4f+h8qA2erE+N8DtaB5?=
 =?us-ascii?Q?ccA8ZF5jpyVkSJm0wwT2dgnSVRMKGRZh0k8hpUexUdcwDxSjw23GUHANf73d?=
 =?us-ascii?Q?QRaFORq+VI/P4JWcc/lAX58JdLmrBQfHf6F3u0FXsNYDVosPDTm6pvvoxuWs?=
 =?us-ascii?Q?kj0HVDsURkc6Uuvzd0MuPLrXJpbywUDJm3AIk9g+JGyAWNcx3s6gMVno2D9J?=
 =?us-ascii?Q?ee7uAxzjPgICb4y2oNakAfzMCQ4JG+q9TIxwK4uMgdv67jVVJrRkqIzEUhgh?=
 =?us-ascii?Q?P3mf3b72RhYlMSeoRHf1a+/KD52rOltIDoCCAy6hwTDbPN2xg5G0PILhIDQz?=
 =?us-ascii?Q?5cXgUy/88LSN038sfkc0wyQuALVLUf+BXlQG+cLKnNme3ruNo9u/fgDo1aR7?=
 =?us-ascii?Q?76wHKMBv106GrG/YebRvDg7nlvYGL/GsPWI5zrRA7b9Ui7tVjaHWYXZhqsP5?=
 =?us-ascii?Q?yUEf+KIiau6rE2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:10:52.1190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee0b73d-5f90-4084-be73-08dd2f251832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

The comment applies to the check, move it there.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d206378c4cbc..c7050c13f71a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -419,6 +419,15 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (!hdm)
 		return -ENODEV;
 
+	/*
+	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
+	 * [High,Low] when HDM operation is enabled the range register values
+	 * are ignored by the device, but the spec also recommends matching the
+	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
+	 * are expected even though Linux does not require or maintain that
+	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
+	 * Decoder Capability Enable.
+	 */
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -454,15 +463,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return -ENXIO;
 	}
 
-	/*
-	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
-	 * [High,Low] when HDM operation is enabled the range register values
-	 * are ignored by the device, but the spec also recommends matching the
-	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
-	 * are expected even though Linux does not require or maintain that
-	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
-	 */
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
-- 
2.39.5

