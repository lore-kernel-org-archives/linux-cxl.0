Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E31E501B;
	Tue,  7 Jan 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259059; cv=fail; b=CFBC36R78FHJhH14JB75eqSK4iYfETtBCSW49QjJBriSdxhk2Vy18dUuNntNU47iYcumgfJIukH0S+keq8APiM0niYhl+MKHQrjNXzgCoyG9KARSUgxJ5Nmvw9S3fsL/SedExNg0UYV+p56LdC6DK9Vy39TBaSlUTuPlpmf+lZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259059; c=relaxed/simple;
	bh=Knzh7rD4YYugKswAaCwWKw31r1itlpMNNRBdWEfLVD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEPySdm1QLawXuix1U6V5CGeSynZpmlgNEZFFya00/6sLKXNhlX/Gap3r6fScDFTJV/gkMg4rC/pb3Wi4V2JyrN+wUhHQo5qFD736KWMEkLL9TR6aTLUkg8dAjmgvoJ2+WRO8UpBjJh1h1I/InlJvSafbjj/3sToao0fRcZS0PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L5fp+np9; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L5fp+np9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZGWUvtfZqAiR1HKD4WDHQY9+rLZ1P4+e/0iCzxpGVrS8migXnBPr4MvSqYLQ/sb8hvd/OSsp4WfhApwiwyOlJJLg2KXFYKzG9gu+VaCLCuuRVXD2DRWI1fARTUtG6SOyOZYUv0kHwSrA59Gbnba+JXuKHXWfsk7PVTjzBTfEHvCkWOJZ0Ptq+wJ1bF9bnli3est2+sx6ykndymDsq4GWXM1sHrclzIvEhkojrm93D5pu5VcI8m9tOT1PwAwfR712XTLJBp3i0w45lAVfwFqOfazfF453X2PPeiFwEwRv/j2VDTX37SbWvEH7NFvfM8cIHdyAOwzIgeVtfewAAUYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nts77dc6NFfp170Ga9LgAuGpqzLcB71tNis0KMAtDMo=;
 b=dPPeTa4XPzW+xMioET32IYYgGqcqGRnblZr2d9H04wKFxp31B/sVqGuHb6DMF5TGuX86Due5VAU4v0LIgCkSSWtkvQyIkoCy6Ps/R0zSmCv/jVpce65LCIB5VjHuxeexAj40b4hx2lE/YzOr0cTgSSC/CfDkc401MNuUznZ3VymlPHmDvBmZ+sIKuiuyINFOH/qxa/n0RW8yxsn3fojji4D8oQbt5dPHZWa4OCmrMLYqt7ruNbAcQmX2lXbRg2QypnuJfMLOZqVC0JY9kiuaglwNgf+tYfxhAIMzCcetoESKqv44jBOsILTtLFF1yLm2bwlRCXIZdFqLhlqJ3G9mew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nts77dc6NFfp170Ga9LgAuGpqzLcB71tNis0KMAtDMo=;
 b=L5fp+np9Df2zg+tEw2G5pevR2KC/Em86nG9cra/+egvDLVZqZETGVaCxMIeb/Zskn3L4iGa54Uuu3TObEKsR8gLIJu/VLUgK02ml1j9ISKUUghd1eVAFRvRPhF4Sz4eMao7zqtD0rydWodl7X4H5EoJTm5sjEpsn9jWZ1cc0vxo=
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Tue, 7 Jan 2025 14:10:45 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::4) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:10:44 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:10:40 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 01/29] cxl: Remove else after return
Date: Tue, 7 Jan 2025 15:09:47 +0100
Message-ID: <20250107141015.3367194-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7a5bcb-8c48-4c3a-386c-08dd2f2513ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zgSXXIjfKuPiccI2pMeUghMDmilmPEaPjolsElAAcpAyOAkQZaavq9kYhVfG?=
 =?us-ascii?Q?y2tlH5A7QiTTwhWhxwQ7d7MN1rjG34azlMzs73WnftJtLzWeh2ypBmX15Qoy?=
 =?us-ascii?Q?Y0gJQOa90iGpB4EoGDzKbwqvsJ+xO8SHvnPFXxwzozDbDA4JDj2/XmQLYL9Z?=
 =?us-ascii?Q?GLJudmu5QBeIIlA5LtjDRIyvaC+VsWgUnDNSQzzTECx2ucW9rnklt1/zqbeC?=
 =?us-ascii?Q?mV28WJRmk0w2qBKS1zdReVC5qZZ4oINsLTpCa69VHeypnW8Do17i+yfXn61O?=
 =?us-ascii?Q?RWgXEWv/P+DRh4Dh6PR3eujI0TK3LfDOkhC0e5UwYirMCt5KM7liHmK6DpGJ?=
 =?us-ascii?Q?/ZOi9FQH1g/IH8hq4JhXoScWH0rE03Pe2tcChdqXBO7f91BGJ3Cn2hbISt2J?=
 =?us-ascii?Q?PwnTXtI4jnhd7MelVZtPsEUdNzAMlUoXKP/FcyRA2PRaZ+iSAT3JxxPwYkEv?=
 =?us-ascii?Q?OM71PGgLLfa0uY5LwpExcLMFsgQB15HZTJQDz/i29feHDIEor5M0Pqo3/lk1?=
 =?us-ascii?Q?k0p0fXou0HxjlVOpjIp8QDpV6408B0HfRP+pBs2Zmrr506r9WAyRSZXiImK6?=
 =?us-ascii?Q?kFwVux/V/UbHs2qhSGmDdk0qpvU1YtIsRlfMo6b8qtSzJxnNNHeANRu4h/bb?=
 =?us-ascii?Q?/O7Ab20Z1Dtuj15E5I/ZbWH+WWAvz2h16fQx2KqzKJ31Qphhpg+/9UGrqFav?=
 =?us-ascii?Q?umpB4CpSH9sa0eA9uPcyH4jbKhGgy0tnUiDU/HvjLj98oFgQ3q8ErCc5JZwK?=
 =?us-ascii?Q?7dyor6DrGoFvzXCAXiz/cgGvdaiVgRJio3T0+RFFwiMYxVo4rjn9EAR4cKxX?=
 =?us-ascii?Q?Eu1hEtoyRODslKugnN/Rw/0/pzJIOYG+kTV1lV1u6mHIYIser0/UPrinf2XE?=
 =?us-ascii?Q?WHsNZSe4rzmtgHSF1zegSfY5pDRPKlNqab0NT+kuiknApIhvUeFOQaisDBsJ?=
 =?us-ascii?Q?6WxyOZ3fuwAfQ4DGAYLsBKj11ccq2FnsD+N9jrTZLDq5cTQQJgH/PuzjaoUA?=
 =?us-ascii?Q?ofFabCR7N+Mip13sGL5kdtJDVNHBk+TfhNHxKZ4DAsGquxkBSYO826EWGxzf?=
 =?us-ascii?Q?iqruI1lJiMshYfRioaFbH8iFwWe/mxixgBErdweESUkqOvobflagYZtU0Btp?=
 =?us-ascii?Q?7Su/xfnFYF4H6gSp3HXaQeFCPHZvmsxZIEB1uezbemIyVk3Y2sTs/FcWQ/5U?=
 =?us-ascii?Q?QyP9W5SKwitAfgILMHCU2NtSIpDl83dOuQtnoNqjsxPWqf45p7xTxfgKwih8?=
 =?us-ascii?Q?azs9R7E7r+njZPiQ3ospV2+a4ttODSknke8JtQs6Hr7zOBZJOcuUm4+wsWqs?=
 =?us-ascii?Q?w/paMYjkqP2prP7Vi9K1W5FzccVJvcFudnHy1id4ESz6zMb6jeADSAmjBBYY?=
 =?us-ascii?Q?j2uAsUzsJP1XjK/foTHOyZunctyJRS6/sNCjay72OH9NWstiJVkkMv7Xz7XU?=
 =?us-ascii?Q?u2mEglqOSxbjcFULFogEXL1sXy+ptDNSfYwkZhaoPrik/L+MWUv9NUYRGXc8?=
 =?us-ascii?Q?jIJ5ml5a2aLOozg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:10:44.5108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7a5bcb-8c48-4c3a-386c-08dd2f2513ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567

Remove unnecessary 'else' after return. Improves readability of code.
It is easier to place comments. Check and fix all occurrences under
drivers/cxl/.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/cdat.c   | 2 +-
 drivers/cxl/core/pci.c    | 3 ++-
 drivers/cxl/core/region.c | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 8153f8d83a16..2e69d9f27028 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -28,7 +28,7 @@ static u32 cdat_normalize(u16 entry, u64 base, u8 type)
 	 */
 	if (entry == 0xffff || !entry)
 		return 0;
-	else if (base > (UINT_MAX / (entry)))
+	if (base > (UINT_MAX / (entry)))
 		return 0;
 
 	/*
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b3aac9964e0d..3e8d20f8955c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -415,7 +415,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 */
 	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
-	else if (!hdm)
+
+	if (!hdm)
 		return -ENODEV;
 
 	root = to_cxl_port(port->dev.parent);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b98b1ccffd1c..9b3efa841c8f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1915,7 +1915,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_dbg(&cxlr->dev, "region already active\n");
 		return -EBUSY;
-	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
+	}
+
+	if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_dbg(&cxlr->dev, "interleave config missing\n");
 		return -ENXIO;
 	}
-- 
2.39.5

