Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B14071DA;
	Sun,  7 Jun 2026 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780815795; cv=fail; b=FZM6OqMJjQ4yy+ZP/wdL5CWhsO9Rh+04KHIE9HWc0oAPzHL055PKUUIpJeZuHr9IuUB2j/+FH6hrZJUtOqm9or82uUYMHS4RZ/KSCz2B4lUGNfN2gM2c3/dcaVHXfMs4UVQrVWhSEdSKWKE6JC4+HBtSfqoYxX8lBzerTSbwNbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780815795; c=relaxed/simple;
	bh=sITprt98GowwVg+EqFUMaiLZlHvjtOuenYfvYKal9sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sc1D3XbYAvxjDJEqmpSwuGoHfalq09KFdPEYh7jZn8Th4ELmypHV/0xZnEPB7LNhKCs/qo49FUVUjaYolZeZuP3zVWuf5dbFqfmZD37M4HkoPFA39/CQETRi1GNP4ZKeiciV5N4n2lf75WFX/S7+JXzupZXAqAAq5YkefJvF28A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NfPg42aQ; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NfPg42aQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxmvNWJDYVSUDFdHr/KwsvlEzOqvXOF8Q3fQa5VbPzrTwrvYY9XbMfiApENCKN7ZRHN3YhhtYCWJxJWOgfL+LLlVQ3ASYPMj0hRcHNZEOsD0qEqW55Cpc9LqRHdq1V0lN3Nd6yZ/nBeFzdYdI+eXyRBmRrLNkPz7sDJqIXDAxZ0ZYd/bDRGJlffPOfAFfliJg/EuTE3m8VC6LUgFkW1oh6iG2CyHR+eIkCujFEeg6GsdHESXEhMUW8+asNL+Rj2NbAzIC2R7vvulZ0J1Ig5zlYAj8BKx2N87FZrf/C8fXboR35OpNr5iQCuBqKhbMdvxni4s0NyWNVK6VCvMIHg2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62aa23Qy0gewzZHFg0JjVdKHlt+tcmyjlmOzrAKmmF8=;
 b=HgBFyKWPQ9KBPOv3YgpqldlioLWACf+Rsg2UG4rpE8LGMkQ90T9tn9n9DKRn6RC2XTJ4rhBzYnMMhhYddNeRFBkHCe2xENG2i4eRB8OGxWdrtQRpyTB/H1gUELki3//T9V80doojFEHlxXyxWHQG/2oMM+CFaX2RTaey86sgjzTSIImT5wn3Cs9rBYnQ9+AVjNv9/zdGBgUZnRbgtmfALvnVLFm9ou/PYWY6DnzaNtO1BNYhVPavIDXhO5C0XDyOD+YotREOlnYBdlmh2boolqEv5KtWqOjZuCPv0dSvk40brO1TICVqykODZB5isf4yDCKTT3uE6f2cm7fCc7P3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62aa23Qy0gewzZHFg0JjVdKHlt+tcmyjlmOzrAKmmF8=;
 b=NfPg42aQxJRg7qNOAkFIt5i9MworYSZFxpc6MZ+a83mq/DKjD7ruSKqMwB+ncxTxynJeKBl6fAdOPr0Wrr+29GdPdoVOKwouH43tlDzB1QsW286N7u5fBPXdGesO//Dv0hkHYuQM1U189XoiI4GIoCqIeZb9wUMbiYx0PmzhZdfAOeMvu/HU7McIB77x+pP2Zt5eU2w9tuQLcHfG8bbef7yIn5je5+I1ThMmv9j5u3ZjbRa8J4gLvVTAh7fwKoDbPiJZK1NpHCiW9ZNWZLXUHzG+bk6rF9xK7i8TmRCgHBrv561vVM1nGqP74m4IudEslVivhabrlHUHdV23bNWQzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 07:03:10 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 07:03:07 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: terry.bowman@amd.com,
	gourry@gourry.net,
	ming.li@zohomail.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 2/2] cxl/core/regs: Check return value of DVSEC register locator reads
Date: Sun,  7 Jun 2026 15:02:41 +0800
Message-ID: <20260607070241.48978-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607070241.48978-1-icheng@nvidia.com>
References: <20260607070241.48978-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:820:d::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7fb0f3-d7cd-4ddc-169d-08dec462d39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	DtOszQMQujsCcmK2Dgr6a1TIeo39O8nKp/RRXviPC1aKvALnVEdHy2X9plPdcAE3EQxcFxpybhhdb7A3mkMi/a+BwNHuzBqtrAq2o89U0BFQOgPGJ16UOelKszHswbG7qF9lXA4God6x7ns6dSDee1e5b9n65XYLX3sECo2RqwZMyty/4yXcgYygsUBQbCD5rf5YxJLWPQfZb/Sv/fRZX4EWd4Q771lMG6CQR6EpEOzVtZh/0irF4hq5WYmZUpvlu4o4M4WD91KXBnur41NDdXY0IbfqnSiP9O1vMs17Ff/x/lFx6JIw0zsKcTnMBmW6hy33bwvAr85nunP/LkkjUWt3n49VC+YZyqFfYfSZwPoFhVsv0pLJp/sfKXjtV3s8J5yylFsJA+Ey9LzSXE7Y8O8DbTscLSf6aNIwlmL323Krzo8WmMuAaBi85Iij7WI7B1U9gfmBMTUMLF9eCM9Uazs51+TCsom+GL6QVQFqlDxtuTpNOC3hQdVfhehDi/as71EzNQUPTrwi1rfsSoUdKFdbs4+1tK/X/FdYBhKfq/dvbFaAA1m6Ty4uS0eETfmE+vlHuYDsELDpAV7DVJvPxb10eYqBvxwbdT5NjxRUFlcYjljJLRX29ctKotq0EeHP9P8/Cbmiy9qO/zncQDs5GVItThMncbyPgaAxdHkELK5aEgMc5mUqzVk+xYNTxZMD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BJSXL2OWX71NImRLk81UXQYwD/Rl9KdMhpkr+LvGE+a5wJf4ns1Vm9ymiG4/?=
 =?us-ascii?Q?IdUgDzb7bfH9/0Y+b2RRnt3IfIHnpQ4Z7bTsWcW3PaYpDSJbdM6Tmof/Fxak?=
 =?us-ascii?Q?82bfdutiFLOmhvSATW4Z+jxy8PhgE9aLxdVfq970ETShbdPfm5L8WVbd2rrM?=
 =?us-ascii?Q?YBqK9utpNQ5r8LBBQsy0XiVuIwVsVHAGfYV8EuZ3E3XqXrecuk+bF7jZnpfT?=
 =?us-ascii?Q?lGoKa0BfgP2UC3xi4kQ0NDK636mHvtw9ghdED5B8iaiQgnW1oXMrDKS2xUPb?=
 =?us-ascii?Q?QYnIm9RbzIpiowyeANFZWcXZQqgxrvmVwQYoxjPciHlb3P16gxXrLrf3/tq+?=
 =?us-ascii?Q?iSE1ms1znfS9a8569zaudaZexBbRjcdyUhk1XH7fw68jXGoVSaHj5nuZl1uF?=
 =?us-ascii?Q?DRv6ZJeojc3OkatsFZNVBykRB6/uwykks25nW7614bmqVHohm7g5EidVBBLk?=
 =?us-ascii?Q?ICdWOktYoDDvh5a6hoB16FICeIhrEwWRx9lk8mL1puGkbQgr6WSD+qAXJ2n3?=
 =?us-ascii?Q?65BJhYInS0Xfz2DWtofhIr65N+PmfW4+1rzK4U/68IYP7NdkKmZBk6hpzFGb?=
 =?us-ascii?Q?qfUTEyQLa7CAm40MA18ubzTguuiJN8MNsXlgug5igoOSXwH9WgSMDGeqtRwd?=
 =?us-ascii?Q?fRd1BkXWcKTk9+koOlX7zRDWHBYjZ3LKAkf0FuKMJo8OkWr0CQsTKImEwRZr?=
 =?us-ascii?Q?UxQZ2CBBalGZjNwLsZHHVbcA9Ppd9zjwndkQNQciTjDoJwk8q21TFuNBrTI4?=
 =?us-ascii?Q?K8rr3bp3dFKLAR1awZ0Jdv66kuIJphXC9wEGoFLroZ8/dlx2F/dGVjPX2UFf?=
 =?us-ascii?Q?HWrC9NuHMo6eM5iErTmSI7VvI3w0dSVU3z3mVJRmTeGZzhy85rsXk8yvusmv?=
 =?us-ascii?Q?tLFyJWfwQ/yNZJUZ1nzDaS02SQ/o1CECgzmOcnLagX5uV5SdmdPFDc7lLDNX?=
 =?us-ascii?Q?/wuqGSoh3+VxlbpJoWhjQ4bfNVgN9wJMKQVa5WzrHelIE2HXFUVOh4YmXbiM?=
 =?us-ascii?Q?clPb1hO2pKQN6GUD93CaFs9b4X8r6+RSJXx+P4MTQ0SOeNcLfdrOWEdRqz/V?=
 =?us-ascii?Q?vIuF+O/KGyw+SpAf6+yF9PJAUHWRa779w+XWCdKCXlQlumj5ijHYFR7ha3gw?=
 =?us-ascii?Q?i+z7ALilSZL7GBoU0I745PPZH4L8B8A6l+G+/jcCJSpy3oLmC0kdR6bOKmXv?=
 =?us-ascii?Q?yG5oYrbYA/iAPzz0IR1BSQdC3N96t+UD78368eSAAIhKc6nnlK3KDE7zxZTU?=
 =?us-ascii?Q?1xprq1UeOmzvraZ8yGOAyBuv46RteZukZYuTLglvMwi8vt1Gz2TgLMy8qo2z?=
 =?us-ascii?Q?EQqFtI67JJIbngmeqFR4iHZk119scPnom+I8iAB/Xx4kNIXvTPasf2bJBHdu?=
 =?us-ascii?Q?8lJIaXzwrz3At0qznhpNci6OOOUWj6IDv7in58st7kgsdmUTWHYzQGA2ZBOC?=
 =?us-ascii?Q?1wRmujfvVxicSvoxuEjH6Jd8K0HY9MWVKSzcR7DYr1090NQOtsmWw5aag4NF?=
 =?us-ascii?Q?n2sDdf2xPO469wuKduBMqRggDWzeba566BlsrCAXUb/Fr+Vj0eh/3/xvoAcu?=
 =?us-ascii?Q?5Tr6vquq5paXkHU231lrT7m+Wn19YF5bzU5q5xVDrkEzXg9KkltATH6nNmX0?=
 =?us-ascii?Q?z4/CTGYpUVV/B+/1ihmtu+li9tlnOVrQCjYqntDhvmLvkCoLFkzhku7NGN1f?=
 =?us-ascii?Q?PgE6ONSSGDznjCC9m57BZYkX97L40S6cbako0ac6QkBH+wOKAQvzA4PAFTXr?=
 =?us-ascii?Q?2iAKrxrUrw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7fb0f3-d7cd-4ddc-169d-08dec462d39d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 07:03:07.6307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMw45mZVpEbKlEvAREFQQzQqCUpDC0/7HVKfbaIl6J86R1fTTRDWoCiyFoBVZI+BXtSK/3fI80Jo9lhcXnkPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

__cxl_find_regblock_instance() reads the CXL Register Locator DVSEC via
pci_read_config_dword() but ignores the return value. On a failed config
read the raw accessor leaves PCI_ERROR_RESPONSE (~0) in the destination,
so the code computes a huge regblock count and decodes register block
addresses from garbage instead of detecting the failure.

Check the return value and convert the positive PCIBIOS_* status to a
negative errno with pcibios_err_to_errno() on the error paths.

Fixes: 303ebc1b1741 ("cxl/acpi: Map component registers for Root Ports")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/regs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..bbb1c278c4d8 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -303,7 +303,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 {
 	u32 regloc_size, regblocks;
 	int instance = 0;
-	int regloc, i;
+	int regloc, i, rc;
 
 	*map = (struct cxl_register_map) {
 		.host = &pdev->dev,
@@ -315,7 +315,9 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	if (!regloc)
 		return -ENXIO;
 
-	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	rc = pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	if (rc)
+		return pcibios_err_to_errno(rc);
 	regloc_size = PCI_DVSEC_HEADER1_LEN(regloc_size);
 
 	regloc += PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1;
@@ -324,8 +326,12 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	for (i = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
 
-		pci_read_config_dword(pdev, regloc, &reg_lo);
-		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
+		rc = pci_read_config_dword(pdev, regloc, &reg_lo);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		rc = pci_read_config_dword(pdev, regloc + 4, &reg_hi);
+		if (rc)
+			return pcibios_err_to_errno(rc);
 
 		if (!cxl_decode_regblock(pdev, reg_lo, reg_hi, map))
 			continue;
-- 
2.43.0

