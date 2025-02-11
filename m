Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D21F2B82;
	Tue, 11 Feb 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267672; cv=fail; b=AOkj+lWiEUlovr7gF75kvCtwDqIaKZWTnw5TBqYIpSTfjN5asQscN6BmCAbZULX0iiV/7yqOsDOjJBTFJGP9gBRbKb0wtcGxvDRctBzl+IgmWoDNFK9m+uXuun3usQ6q01IttbKPHiHIhj8ZYb48RA6hk/0noEKWTWOpbeOtqz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267672; c=relaxed/simple;
	bh=VrDsycnkcjDto/URNm+Z5vmKGPWELGnQ0JJaSf9CO1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9KN9ppOh/z7mnwrhQy+cIPdJd5AkZy50Dg78HDvHCs8/YF6D7VbZeoMSfH3p256fvtkR2IbFN2LGPsNM1wHA+K8d5HXLFXmB2//4VSeNqQ7bH9Ov4rijXKcsEpKURo27MijyIfJ8caLVU7vV8Aq2oHwsDwIUhmnlfXRABOJrRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wE/5txMM; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wE/5txMM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpbXk0pOj9eg1bDtFsZUPx2duSU9NBmTtqkBfvsG+3LxAS2zHFzedTPVn83c7PqwUBZfVLcykSzM34BPZ3EDq8PDVMYOA0j59j6Sebf5kpmDMvB0UsQnnRgoY5K1SYV37wURI8UpqNS2ZT5Sg/PomACAprTS2xSl7KwyUP+9tEpf5nvX6qj5sj+OpCMtDLi9yyHPK40qzsFNW/Gof33/uIkqbjRK5d9YAzTRAqWqwuJNfQz1bsKEPFSHGCVZAuw7EYuWHzZYl77ks41Lytul4OvXOO1dirSQ1nEOCBv8v/sSqN4koKi/1hk2jF3T8k9UoiLiIq6OtcZdZ4vH5xkq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egxY0YP7PifHCv2EAMZUEPDDoPmySwOCHfw1ZqwtpNM=;
 b=zJvP/dpvbY0QcOQJvfsk1A2XyVOv6HlyaTPBt5HB7xSaqD2WPoPMmOhknlrOWvtZj4F5IC6SV6CK2KNrN7tmE3r03rTRb9nSEo8R8GiqtiXt9c7p2JPHg9/ogJqzNnKbJgETVjsdoXGD7wGsM6FMb6/hJstP+RyKdTLiEIiIf7rfi2GoZ4wHsQPW+bw9y/A6LGXjHYwRJ3K+1Qg8jhvrxRUwi9T6yg/O3dfEZFZG9cBH+Fc62Ew8aueUTPmD5WArommWxVJyF3hSrq/omeD6z/hDoXgxboN1CUkVkly/yt3s8+W3DUwVcGz5oC9HdT2T+9UE7PdQWAL9lFZE8QHXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egxY0YP7PifHCv2EAMZUEPDDoPmySwOCHfw1ZqwtpNM=;
 b=wE/5txMMw+Sf8uoxgjKl0RnaG5tD03RQnrFoacTbhUTRUiZv9IWnPUfQwSEbvbeHkIWmwb0/uaKlIXIc+OCFKK6JNY+u+y9vWoLJfqBoRepFT0Vu+D4Ej4d+O2sTAff7/D1SWRwH78F87+TaIST2spzeTwBlKjWq+Bsv4ja+M+w=
Received: from MN0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::28)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:54:27 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::4f) by MN0P220CA0013.outlook.office365.com
 (2603:10b6:208:52e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 09:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:26 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:23 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Date: Tue, 11 Feb 2025 10:53:33 +0100
Message-ID: <20250211095349.981096-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea0a2c5-832e-4afe-e81a-08dd4a821232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mOO9w/vJozSb0J7h+Ah49SpDQP05Y/rjyFWfjwDfjVHA4T+hnq9wc7VK0PAZ?=
 =?us-ascii?Q?Dn365WkLocJHRXQtB9WcM2poG045xb6FmmvAuWEtr43mWALdYNBGN3a6f3UF?=
 =?us-ascii?Q?qiLyzKeG0FWGSlpJBxDEX8ovgeuA02zLVhDmI9GL7MWY2JlaAxkxDBtrCe6E?=
 =?us-ascii?Q?5Kj+/4NQONqzDkhdqmAyUvFuJF+lhPBe0Pny2z7QiCQ7PiI2Zr/J0dsaN3Xe?=
 =?us-ascii?Q?+/V7GzDZ9iyO/hYPz1BXTYfVWCcMqjn4wv2wDR4EUOEqqYZbCEZan18y/ppj?=
 =?us-ascii?Q?SNLRkGdi8kORKTnenjLulDjvyE7drUGBbixmaunBYDyfJ4K3ebpVteGyPEWV?=
 =?us-ascii?Q?dDYAOrJ0UEHO51nnruHTOcTKQmU5UHlj6Vcp/IX6nZC5icmbw0LJkVvroENZ?=
 =?us-ascii?Q?2cyjzm8CSTnmpUCt6s9r9GnMk5fT5MPBI3F6i103oJgP5CBDGzvOpOmwXmff?=
 =?us-ascii?Q?oiLuClCyYhygzslRPAlys5MAHjhBbCeyN+Xat+7eg6t3nFh8tcdAn/ZJ6a27?=
 =?us-ascii?Q?You/zf2YdZJlJuWZEAcceIVU5anGbG8gd0mACcTBndkwn6pMTLnO3IskUw1Y?=
 =?us-ascii?Q?e7Uj/foJNXWUXRm9zxLFmjA8ID9r+dzZ8mjLrlcECJhJE6wKcdBsfCXrBpNO?=
 =?us-ascii?Q?LCcCOdMPwVe68hbEwoSfh58BGSEjDG/DmKQnyN4TJgs0QRwiDUFHX2gciuiV?=
 =?us-ascii?Q?G3OAmwkTRglb1qhGtduf+g+H91X3JIEeb7rN1bVWto1OldJuNrqDec6TSKH3?=
 =?us-ascii?Q?HrXHGkHkUUqi04xGjFVeOu/ML/+6akF/bZsb44bWnoCq4aCc+abKC3b4qEp8?=
 =?us-ascii?Q?sMfG4fWLl6YZy5nZ8b5H6Am8dorCz2+JHSPdsa06+g06pYwEr5RTRXGevdYV?=
 =?us-ascii?Q?LGVYdrfrSiAm9vLdqtK6cmL3qIn1OZDGOaNvbjA+FG3TgSqFl+tgEc3nvIj/?=
 =?us-ascii?Q?N3fcdJDXA7JRPDP80e9YapxBR+bztIBAktNqXRal+lIKX4B4xRSf87dh03QR?=
 =?us-ascii?Q?etNIUmD529fv0laIMajTCswQ1HR36f8mI93SuAGzizkWY0/tYbOlvilxcy+H?=
 =?us-ascii?Q?CY3yinigaz8cviMcZ7akHsPtNgRqI4e5cmCot/KfLG95BIzpWUgfK3Yx66mU?=
 =?us-ascii?Q?KizixUC/gaAuyynD77e960Qgw5Snr7i433DnNL8k3HsMcYj9tDxY46nR4c5I?=
 =?us-ascii?Q?9CdDU1dWKmWmkQSIhtZpsqD88vW+BxzXF3zNHxXRjsaFJEUCoGNpPWgeOvr+?=
 =?us-ascii?Q?UCadwtTpv3OLyvFv1tmDvBH5dQyG+EVkpARW7tfqsbKtjFv88xnEWOMrM/80?=
 =?us-ascii?Q?2UR/NtgGqcCzV8qfHPuAo6gkSECZX6drlPV3wh+ArjuYFQLSWjFoJiQ43BkW?=
 =?us-ascii?Q?CdJ4ooFswesnpWHj+k4EcCH4WNQHSVXVIykDCO+99L4PkbMYjYFJdZ28Xn8e?=
 =?us-ascii?Q?dMCozN7lPj0dBwNTF5S8SdOrCCanwNyOKKXKrNy5bHqDXVdjT6Nu7GPhKX2l?=
 =?us-ascii?Q?BU7kjPRTgIvF7F8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:26.7227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea0a2c5-832e-4afe-e81a-08dd4a821232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780

The comment applies to the check, move it there.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f8e22bc278c3..c49efc419285 100644
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

