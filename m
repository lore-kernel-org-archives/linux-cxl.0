Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833A403B00;
	Tue, 21 Jul 2026 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613101; cv=fail; b=Oe279wipJbapJqSJy9RdnPNnt6YPtpbP4kVSz7uUOwjtKXPge7IOANoN09Ie+MaPTMSjKudhonDXLqcvpySYDvz0+vwUD96bUdAQAnqRpj4UsoBwjnEWZZuJVSi5qFBntNj+qZxAeTasCNLz5vD2Qn+KwaSxxFqyF0FitU6wpT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613101; c=relaxed/simple;
	bh=IzlzEbGjiRhcJa/nuh0gxMoc5RFDiJO9nczdNdmib30=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p7wa5VjJM6RjeGRjhGuD7bfS0FcxpIFgBRB+XvnNyrkq+LCh/0FKY9+XJbqxc0LETUwuh1HhXIx7D09yJ0SThVd+X/XSvDJtj4/Qmbaz0GhhMB8QzzQblkKX4Z/cNu70gownJbOpoA6bEHLT2ssH/8t4MEly6EH6DklUFwYJ+4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aPkGxgpP; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aPkGxgpP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcIhDNfJaX7ZogIShsLx3ch0jScYHJuA6zKSKjpK0+5y/L0XPynxBDEK8AcaxPbYckIgJ+1rTT54rK+sZhCxXmy2zpt4LcBqqxGJOx+xJB0bXgXYzdu852CIj40jQ30dVZqQ2IoZCnoItOhxTU2qRM4bP8IvVzYWdR1ePl/RlxvO/HkHeOnJ5rtNqn270rAtaMZv5DDIWW3a4njFjGdfzZDo7z18VNdwwqHsu0r1r1wdrpGLqujjaEbY+NmxKmjuEMojoRpJOpSK7cf8AeGgc3WOEnYj/kbXwL23OecHkDSMZ9v1OLgr2jcebxyk1oI6oF8DewkWpVBluj9xlm1jIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPRWdrM+VsvLtXCvFvNzXLiBXQipnbhZLTl9WAugNMs=;
 b=DRsi+9QGnQJBUxScd5eF/BRX9LPW5GGI6SXkmB5fXhB4sjZVO+r1zQhBp0k/B6k6jZSz3ma7BFzpdOXNjlNXUN3fjJZ5dswzUPBDt9o5CyqioNOhx/RkCFGTpXM3vI0aC5BXgZt0QCg8Y8DLBHDrkl+8QOstnUK1IYWg54Nz5ZKQhyAwjewhnHVbw6iWU6cFTfkTqfMsMdrP5w7l9wC1lTZlW5vw7ePvcuXP6YFW8GIJDbHcSa/NDypC0U/leSRCiXmSGWl6W6repzMbirzX5u/jZmJrMAoRY0jgFWqyOsAMKaJZhBu5IyNQk4sYY8Pakw2JVSiTicTbSEhQHw0fLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPRWdrM+VsvLtXCvFvNzXLiBXQipnbhZLTl9WAugNMs=;
 b=aPkGxgpPz0TcSt6ItMY+Q3WJ74tAbXCNhSgbNnAbR4dcw129AQlC8v2OUbv04tTBwfEeymaHlalTbOTSWfwQCOvP6cNbCuwbb3BIwPUIlB4u1q++6BveTO/Aco0XPlFRMYaHq4sqgdMi+vP6S2uhkhogVguuVZr/Wips+xLSZlU0z2/7e30ELO3TJ+aqTUk6fPqgzviMqz5ylEZgm5lp8P704m8jCt6LcX+/Wi50nJTn3EI6G2EoH2dG+mS+l+zlIJHn3wHZi6CHBEH5GGP+D+Zmilop/e9raAPDgyzvAVVxVqWgwPZfsfXKe/cuPEd9vE7Q3RNbSAB0pJbJPn+Jdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 05:51:36 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 05:51:36 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] cxl/region: Reject delete of a provider-locked region
Date: Tue, 21 Jul 2026 13:51:31 +0800
Message-ID: <20260721055131.20935-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6e795e-4306-41af-273a-08dee6ec202f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	nUKXpalvTOgWiDlVuIYITzle3gaINffInxj20B0PgHMDTvf8pURmMwc56xqtiqPok1D0XN66lDf4DVDVcTrQt8EQVD0dhL+yTzQymFlKUWYVbxMu0Pdl24fl7o8qgMvmogKUH8D9Ay2LeBksgVarzNVAuYYhP6jlqkvsj+Fep9Yx9jDg9x3zWoyDDnKlpPTz+n1ge2Pv/3Z24lDazngO5j7+e1qyTXc8FTmRHtHJ7xVhTqs6cybezuWUIbdz9eqSk3Y/DZ2nbpj5W62ERD0sHp1MZ1KUg3JgaR7w/ktKsBl6JXIqjD4MiHiFB33DPFJ5zn/CMMR0dRZ0qXH/GtsILV4Ikt7Qs66r/+tkCi8XAxMhwpNtRSrzurE81PI7DPj+hWph/ska1WTZvYbKUvMLOUUsddWH7XH3WqtFg36QMgmIryPWA11bASCYznSXQdRzflMNyKGybp2Cv0FHZuCSdNoAxd6zS7zy2Vl5ncoFIblqe+AtN555t8aPBrB1/osK3oCK1PEu9bORCaUaSlyO2WB2W2MrpqMIe5xP2WVhDVKzX/LJuTRL91ELRW57BP2P1ThLpLYelCz3gYhuA8VVMimXIcWbi/4ts4VWJSKJan0MUZjq2Nb9zQG9UKxWT1XCcDhhhhBTWUXQLlqKaqXPZbhF9KAsloOsv7aH1kj7i7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oz1SIXdC+oWYcDftXVZw9pnlC6pWiwCNY0sZSBE987zUJMEvQGFiIef45ICD?=
 =?us-ascii?Q?obFT5a8SrmGC0YL4PxcOmR5bV7jKmC9gabAL07BHKtgMvc/Hi9fvPATLzOAt?=
 =?us-ascii?Q?DTCryXdzhR2DuAfqwDMRjAaUv9irMGENKYZMices31viNqsoOQg3h530vE4t?=
 =?us-ascii?Q?kGd7kxdxqZWaLhZgaZyp/PfJzyydhjEeeMDO2yUY0rQlkDC+9ubYBf/tAvW4?=
 =?us-ascii?Q?v8N86ur4y3FsvNNmYwPmK9s/fm5ztdgv9CYnIBi/UvyZWbcMwz+Yqzv8sxtQ?=
 =?us-ascii?Q?8Pa8kgvI9DkMnllDZgtFoIGU1L9WroAa5qd5mBDdxskjZaaRwWHCmXp+ClCO?=
 =?us-ascii?Q?gU/Ttk+gir5YVomn88bWkJ5PGlPzPLTFahl8Sj5llnwJSVnQjAHue6UBGZN1?=
 =?us-ascii?Q?sS7EoleWfHFghfw21G4GpPat7hAABTkJUe6+OML4/KF9p2SqIOirn2eNKaCd?=
 =?us-ascii?Q?gMXq+BJ44pyCMr1NfNwUIGZwkTvdp4GTmsQJe4WbGAVgLJ0LnrWe6oQh1eYp?=
 =?us-ascii?Q?8YC9Pn4fRLKu1IevmoGovszkzKyqYH5JZPDEKZ+SnPgFWMlUyr6NISVuqKE9?=
 =?us-ascii?Q?MY9Sova9rUXD5dfOVc/o/ly2ur2zhZY2IwwJsB08FfOZZkhKO0sP23oLYrS2?=
 =?us-ascii?Q?dIYhl7+mp6pKk+mMRGErpsbgogXdJxa9kdSuJwfhFIKWr2E6mIgL7/b7O2di?=
 =?us-ascii?Q?U/9WRcMCCVDHMcBMhqwilwIpknp5unh7Rd5v/oinHvFL6PE/RNGVE7yUXVrL?=
 =?us-ascii?Q?LLScvLeleeHQapebf4wI5UOzcxEAJr+TwgB9JjXhiN79iwDc+XmZcfZsUEIn?=
 =?us-ascii?Q?1aW05NUCQNVNoIUPOXJ7bhL5b37sH13fQzH775kWBWA0g7MdE2ZrLNAGPDeH?=
 =?us-ascii?Q?D/XDFTIBiyTj6vt/NjbvGxZB/4dw5Wl3tFtn72u3LS7rutokcTBnqARFFupo?=
 =?us-ascii?Q?XkBnIqG3wHYCkb5AhTWVM23XM+ETAcLenMV1bGk17M9XII886kDM0Z24ueap?=
 =?us-ascii?Q?rKNW/XGlM+AeTcOW71H1DtH9v2UYcriwsEhbgDfB60sN5T38o8IxCJ7yHYk6?=
 =?us-ascii?Q?RheUbwQrLkK8Am1OF3H+TEB1bxTjuFSc2NpKmbZU368ft5L5wH6KbItOqnbt?=
 =?us-ascii?Q?hhjZgbIIhSTRvGMzcd7UJWY/cxJE7F/F31ihkrYA11L+jnb3fhAQoG3Dwezd?=
 =?us-ascii?Q?Ndbr8DecqmhlkO9qxE1GSEulagMGKiVk4WoJ4yvVklpFnuRj8pw1Tp/JoWyg?=
 =?us-ascii?Q?DVf5GEMLzFFWevhgbz+9KjDkTrEbKP82pUto3D9PuFWrVsJ23AoZ5avrZa7W?=
 =?us-ascii?Q?0cC7XiGC2/sCRZUo7BvBLKl2x6lFBTYC1a7Yakgr3YdFv80kve4yVt4W45pz?=
 =?us-ascii?Q?LDNdnUj+yGEtTShFKBKraQQLNcH/bDCA5NVBlBSvQsPr0D2CBEVqrqVOU2pb?=
 =?us-ascii?Q?xMCVVRIshhceEUrUXMsrZO1TDbsxTkdyNUeyuk6hfUxQxBJyijWTXrZnXZo4?=
 =?us-ascii?Q?fYx/jNvdQkmBMGVSV30aPJRWZRQQziaX4h2dS1GDZNHMMBZJ1GniL025MkR2?=
 =?us-ascii?Q?qWqNewZdj4R0Ko2eFMP59beHBTJqTALtxj0C6u2XCYgSAkCvxfyS6x7Y0m3f?=
 =?us-ascii?Q?2tZ+oM+LtZPK1yweB/XkzaBF8P/I/vIM5mLBaagTr8yNaeUXT8bAD1gYVWVy?=
 =?us-ascii?Q?9k8dF/9X8HxO6oZXA7/facqvpjtmszCMhuwxOCgOm1Ae+K4C2TXubM2g4Z5z?=
 =?us-ascii?Q?nUWy4LOViw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6e795e-4306-41af-273a-08dee6ec202f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:51:36.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4qE/0uxXK4AKBbVI6MAYTg1K3doRt8VUyLTZD3bn1PpDx/wFDFvttVBz0/kJQwasxU/UKIKlrZ+UrnqFBHAXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757

delete_region_store() destroys a region object without checking
CXL_REGION_F_LOCK, unlike commit_store() which refuses locked regions
with -EPERM. A region owned by a memdev-attach provider carries F_LOCK,
and cxl_region_decode_reset() deliberately skips the HDM decoder reset
for F_LOCK regions. As a result, a userspace write to delete_region
tears down the region object but leaves the endpoint HDM decoder
committed with no owning region, which is an orphan, enabled decoder.

Gate delete_region_store() on CXL_REGION_F_LOCK.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 578622240401..cfc9622c9309 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2894,6 +2894,9 @@ static ssize_t delete_region_store(struct device *dev,
 	if (!cxlr || !sysfs_streq(buf, dev_name(&cxlr->dev)))
 		return -ENODEV;
 
+	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
+		return -EPERM;
+
 	unregister_region(cxlr);
 
 	return len;

base-commit: 5ca04f3ba91f1773bbd5da6d9c654ccc1ba7831d
-- 
2.43.0

