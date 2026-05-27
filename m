Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8323E3D8D;
	Wed, 27 May 2026 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872626; cv=fail; b=fK+vJ1T4fvDhRnqO3aYvmYuxBKP3EDSGCT3RzhwUYjOXXQiBBE4p0sPop75hmy3BrMomMSaa2WkEHeYiTxCBaIZQEtwhvSBUIs43dlLeq+71F/fKpSkIJR0IJtHAnfvV7/lPpEGHKxPzkF+0SVaunS9OisoTizCQD62+bmZn6QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872626; c=relaxed/simple;
	bh=h7MDNVstchSLziB+zLeW8caKDPTt0kad4HedNGxI7CA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LIRSJoDoZzzMCFwu7U0Isa9WynI/yfmkTXkVsGRUgMHEdaQAeUvnfYY6gCBqr8uQ1S4g4ExasRX4wpVT1oJlYIKe34p8EPvSQqCvVX9O+tjh3FjA1sQSBpd01b4G8NXpA5hY6CMOonQYRkgHxMeRcdDA4icEixm7g6F0ZtV5xBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=trashutp; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="trashutp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WK/0lWbp3r+rgttFPG22rIcUAJdM3J4y4L1KLzhs1cXEgaZ7HuHWZZ8scQVr2uvYlE12fOYi5T7U/j1/LKyLP4iIVe2QWQGRYM7eKH0tEHvaeL3Uo6wZoiKEoCgDZB0Jj8Pbdu5qiYyNfhSVQSAymOAz0KdsBwZcmlD9KoON30fdc9iBkQdSX3945bqrGoktAtbqZNZko8B+FTD4kxdjdD1pMQFvcdMHjXbHQpW7NvOJmSil1V/oF37VP6+HlW+zU+An4jhSLFNbdCAJ4RDIORs5BlCjNm9OQJ2IEzDTN+rVb7O6+pNFijPoFdjkB3aF0JL3pe1RMys7m+t64uQ2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo1YcK0DXKAY0ELEWXjH1+Z82iZ+eCopUCC+ftr9xKA=;
 b=wDO6T92WfBC+NlDzyoq3Gk3hyNKck6+id24CSdZJN2HWFmecrZ1jCAh5VFl5+vzNooscNPAoAW9Jo9p9ZeqUSd65mVQbSr6wdReXZy3HNE62L6tf+llqlkVGbkyB1BepLN5IAJEBuWhz86RNAfcGXN0zKCyOxuz5UkHEm/7p4vHqEqZB4Fi6V6uRXidmVnYdvTba1XBjwvtTZLtvMXkMTX1wAC3z1J0BPRFTZ3OiW68IsF2ZPPyqtU1OrHUZRzXUChckTyar7pitIT3eCQTAnIQS2LaHWEyCzMAVno1ZstGEo7K1vvexJ2ALM22S1Z4cV3+PJABuuxe5EEK82gO53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo1YcK0DXKAY0ELEWXjH1+Z82iZ+eCopUCC+ftr9xKA=;
 b=trashutp/El4IrlRYpL7F6Iglm8vm5gLSI39cXgjKY0z0UAwgIqxTH8Tz7R0jQcdXujMDDqWMW1AB+mC9NR/OjcqpuxhJzCmzy37zR9pdLzwrTghuu7F0Sl8cpIBFBPTkffig7b5eHR9KHKm96IUEGmPXrhbOTKEabTbYJjWBZK7fuqiYxi8CT+3DThukGq6rrD63jSA4BAaj5bPebGADLy55KaIxJuwVWjMB0v5lvnPVnrzDgMlXU/VlfxmXM4ZjaT6AwP6gnkq9cBwcBibEy0AO/hf3xCHwW7iOj4Wf4o0tuR3agXE3KgVZ5rpRY9BOuaO4+etxijqSEkG7JhlFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 09:03:41 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 09:03:41 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v4] cxl/test: Enforce PMD alignment for volatile mock regions
Date: Wed, 27 May 2026 17:03:32 +0800
Message-ID: <20260527090332.30002-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0048.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::36) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: fb35b42e-c0c3-405a-af47-08debbced8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|6133799003|3023799007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	bLvXJW2mKtk0ZphO8quXo+sgEUEX9GDRjtY6AgeEOdHlOQLZJs/ePO9olTB2538ZYsKiOvryTcQSIwCnpI/ZtaT9HnMPsiGnX0czbg/GFLfTJCuGA30/kOxejgJI2XLdufsPxUIoNGB16ZGW/qAw3TFVyBLPnyQJUIjaNk6dMau04RZNHnBhmGefZN+sZ7U7BT7F4FNevbxPYQh5rxVYb5wMtcLb8mrLvfwxqYHGGEP7IoeLshgbTLJ+Fp8dXw39fRc5CKY72asitRmZ5w8L18o+fCtLWfOWPcBWkT2xpQibNk4EYZQVQUBZP7+xoLtu28J4GiEuGlB2rOXWi0E5n3GufK9hXy1VFEU54pBa2QMwoWTsc5QesyjL+aCbKvGSprQNNsNYaSomTwtuTyW48PVMrSpHEaql8xzSYmYTQSDwjKE705byE42vLx5Lm3UlDAavKKj7qERiAzzOHjh6sQgQHH3OcMD+42NCBw3x1KpGd28N58y7xkOIZssi3ImSLhqqNl66+5i6j5fOoSMftgT81pw2ziwnJiTh4FSvqWOK9Em1PIRv+YOMHdU7k73VqvCofh8MhLoY5lt6d2efq0s5hA4MCMuMacgKfb1FNPgChKZgRweZQWl75f/HUvCP5vyHp/OtsNOP1wuyCegm5CbCuKCJLmCTvQ2egjh8ML2Y7ilZF0p+yvgEMzCQKAkx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ahJFLcrCni0WSyLp7rQCt7EQYgKBciaz0CHJQdFBAFwUUIqtu5wYG9z15hpC?=
 =?us-ascii?Q?BNjIL0jynRpTzbn919aNDvWJbjdetLhn9bRAPRN4EHF2orf8fsT8qg8JUoPS?=
 =?us-ascii?Q?P+mfzS90D1BIlLeOGCupnu89HQW+M4lT9LGKEvg8QPPV+vWd0ytTcXGzf1E/?=
 =?us-ascii?Q?sPcXmCY0Kg/Z0fDASwtCPmI+dQPWtcIpImrwFP4arGS4Q/dmIVzeuNyVifw9?=
 =?us-ascii?Q?fKLfNpYLLTyEiDp0st3BCP3eZSxgDJrD9VBRZP3GMKJaiFgjd1ijcnSQQRXT?=
 =?us-ascii?Q?9s02RFoqA8CK7A4bT/4QyHUCu/HQvR/Qri8CMCj4fth0EnL3G06oqYduxJjZ?=
 =?us-ascii?Q?kI/NtLi5Xli9/IkWdQ3zW5vGvQAhPNb1oBOTr2x4fWL9Vro2NiMIBpH/ojVd?=
 =?us-ascii?Q?FkqyBvYsMVbikYZMvMJkfiOHNvofoQ/2W39InqMa00DLORtxNTec5S7i021A?=
 =?us-ascii?Q?2LuZ2lpH40n99lcQx0eGVQ89mbsSJTReuSzBmNn0kHbWhpPns02mhBv5ktDk?=
 =?us-ascii?Q?bMM5jB5BSYZOC4blFjL8efynHKyQOjS9ukxioM85KRL+32hnRHUdURz3daUj?=
 =?us-ascii?Q?AIDDf2ZJLuJdD7qu6q32473a7jareukQ25NOwIrlXF7cYDj2FYkNSdPL5ELq?=
 =?us-ascii?Q?nD2dpu5J9v5SUeZn1JfZ6qA8ECXMkeqmTpBInmJZde6KRT7Nx/SJfeFvcp5d?=
 =?us-ascii?Q?eaX275bEIqq2YtE0EEybETasF3UiUglbiMZgazyEjma00jqxyOdqVttEw6Mp?=
 =?us-ascii?Q?kBIW9NEn3OsGwfNp3AEt3q0xja8dv6uHioVP7br9bwurLejhu0nLmS05nzZF?=
 =?us-ascii?Q?qcysWKD1je0Rd2FZ/JzLpZa+VeelD5SEzY1OnDd/ZKKKhStWHqO5F+El66YU?=
 =?us-ascii?Q?01LNmVyHzV5p5zMZDoHlvPVlj3mwhDEhboUHJkryLLk86wr0iCG4WvZJnsVi?=
 =?us-ascii?Q?cwvqMnptXTyQ7nHG98XH4DkU1JriH9c4JrAROLFP2yHMyInxTDIa/lWTK6Jg?=
 =?us-ascii?Q?5LCiYLLPB7UK0WjCb98NBNE7tzUPJ+UwOODscd6cf6QsuxqnG8lreBT0EPZj?=
 =?us-ascii?Q?n2Da0rXz9PwNDdeFBBWy7SAtIgtCConF5Ga7DipRCZTEHN39OJTxlycZCMhA?=
 =?us-ascii?Q?c8ixqbd+QwwkqygZh5OY06fi7KJvcn0s3UFT0Ka9TQ8zab2gWk4TMl+pcsHi?=
 =?us-ascii?Q?21hqFAmb/wRdCggXfuQEAXs2oDnSVbBc/BUVkMAzcipL+qUB7L+Af6e6DQeu?=
 =?us-ascii?Q?0zDyRt63yNKD5r454+sjWJPBpyegQgr/PHmdaLWX1d6mGpmmM6CMe1rVFsIe?=
 =?us-ascii?Q?fKSUbKuYgnlPiNsAuM6tIunRou2B/1ctoto8lqzT2oC2YdkmMK2XNC8+7VHC?=
 =?us-ascii?Q?yfM1f6QV8lftnJd+n4JAAQlh4saN+HhmrVSltuhQc3nNzx/Kd17sfFH+58EX?=
 =?us-ascii?Q?aNv2TN/9rIAryBEh8PZjCYyoMbaVmx1WuDxVJsyUjfAAVwtWer19+iCGNJuK?=
 =?us-ascii?Q?xefjkd0zHu58MBPbycUqeFkY/JqcihluK+zA3h+r0Hm55ss8RyFLX5hg2OWT?=
 =?us-ascii?Q?oncboUwfwS2M7NTQG1YGJ39LtLZn1oHSv8fvujbTYmnGONXpJPLYn1vfGsyh?=
 =?us-ascii?Q?un5oYGW8hNnjKqncJ8oxa6Y8lbdOvLC8oVKYfk+GDAprAQN+a8JJS6UiqZ5l?=
 =?us-ascii?Q?9Bo3GTJoGkYFWzQd1LvSlGG8kJeUVTfn7a11awFGuw/OpBWPwDnc1CTXYCkn?=
 =?us-ascii?Q?HpERywHRRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb35b42e-c0c3-405a-af47-08debbced8e6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 09:03:41.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ee8mOv6UfdE5hsFfl2SBF19kW1moKsEc26LeaXynA92lOK2YyHnvXot0mV7IYzkdNNeul1P0xBoL1vqh8LWHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
from a volatile window inherits a non-PMD-aligned start, and
cxl_dax_region_probe() -> alloc_dax_region() fails:

"""
    cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
                                with error -12
"""

Enforce that every volatile mock CFMWS is PMD-aligned in both start and
size

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v3->v4:
    - Replace compile-time BUILD_BUG_ON() with runtime
      IS_ALIGNED(mock_auto_region_size, PMD_SIZE) check in
cxl_test_init().

v2->v3:
    - Correct hunk headers
    - Add base commit SHA

v1->v2:
    - Reframe from "fix start alignment" to "enforce PMD invariant for
      volatile CFMWS"
    - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
    - Gate populate_cedt() alignment on
      ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
    - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
      in cxl_test_init()

Best regards,
Richard Cheng.
---
 tools/testing/cxl/test/cxl.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..6f8fa7504cad 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -318,7 +318,7 @@ static struct {
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
-			.window_size = SZ_256M,
+			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
 		},
 		.target = { 3 },
 	},
@@ -495,9 +495,12 @@ static int populate_cedt(void)
 
 	for (i = cfmws_start; i <= cfmws_end; i++) {
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
+		int align = SZ_256M;
 
 		cfmws_elc_update(window, i);
-		res = alloc_mock_res(window->window_size, SZ_256M);
+		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
+			align = max_t(int, SZ_256M, PMD_SIZE);
+		res = alloc_mock_res(window->window_size, align);
 		if (!res)
 			return -ENOMEM;
 		window->base_hpa = res->range.start;
@@ -1826,6 +1829,12 @@ static __init int cxl_test_init(void)
 	int rc, i;
 	struct range mappable;
 
+	if (!IS_ALIGNED(mock_auto_region_size, PMD_SIZE)) {
+		pr_err_once("mock_auto_region_size %d must be PMD-aligned\n",
+			    mock_auto_region_size);
+		return -EINVAL;
+	}
+
 	cxl_acpi_test();
 	cxl_core_test();
 	cxl_mem_test();

base-commit: 507bd4b66c85d5b65696150cc16d31ac0b2ab151
-- 
2.43.0

