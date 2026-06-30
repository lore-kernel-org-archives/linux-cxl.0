Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F743D25B6;
	Tue, 30 Jun 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805630; cv=fail; b=cjyVfDdH+oS7N0QfntdfNN0LPMqFNPDSs40Pjp0jj1/nmGEKvKD4Mjo/8ic460n1v4P6VoopdPX2UAf0rJ7hz2GWt8pGo1eKlXyzg2TOElzu0l0UQlpKU1STzV4sU4siSC9YhYps6ihiv/W00wFTscrcahjSpJTegP87+gVB0LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805630; c=relaxed/simple;
	bh=ShNOu1OwdMSu0iBnCnaRmi+MGf3Mjh1D2o8VHmwml58=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MsaAc6tYV6B18L/GBVAuytsoXxUeJXlKkc2uPdzfOP/TeKowqCjWIawhW0vRbAzlm8naaYiKMq/T8eO7Dl5IpP9CJbpQ1BVq/Ywd6DyAElFF3uO9V5JlwKZg476P4oeyoDmM/xkb1q2pO0Y5Gj/p6ABSjj8zKBscxqB6FivBDfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fD/Bq85G; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fD/Bq85G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh3ePouleTT+4jkXERYbZeugySsxCfM5rW7TMg9gVYhGWk7pNoGjFcSNx5SGjOveSESkBQiEkUzSmB6fNVhD5iJRn1eXEDHJa/M8wjAXkHuae0WsRDwi0cYmiDkh+fZSaf9MtpoyHhB/buYYnfblc73vBfZR2MFd0u73H6yxG883ZyIW0o/HlITUZY09HeTPwPazK2qrhZu8VgaSCaIES2PJkDtYveRz9GzH4yPYv4AEtbVichuNISZSNp5Sqa6WxkXxbiJm2pdeEq3YkB+NxMXze35oHfk6zFnntp5UHGgw3ah7KXGLO0vEsW52UOKn4FgfSy7X/IksV3sYgQmuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz+xN7PsqCq0OpseuWWmDClF1bEFUzGMmJqTowwlg+k=;
 b=ozf4CUGdgdgsmLRxJSsWQa+jfjf2eZ7aZmrGwYIzl8Ytizgke4zMMq+gmd3nI0ZVRIXvld/clYUVuKivLuS8S1kDolY4JXOVZV4pZUecZqRHgnPN/i6PqmMGVF7Z/r4qkTfeB3Ui618Rvb6Ww55XRH6+DNbbvgnEM4luZKFjN1x0+cC/rHlulFzuBlh+jPE+ltUDMIjeo2AT0Y2fjxuFrVTw5+4R/9DVVK+ksMe4hiSo6sjGG3pgmyhj2xQcyEjeDcGBCRMd2kOdQWhB2yME1dKDYpnn7MHVqs5qXyNehdChicqOqvGEzSfMQI8ode9EM/8EYGLEfYEJ3ZFHhuGcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz+xN7PsqCq0OpseuWWmDClF1bEFUzGMmJqTowwlg+k=;
 b=fD/Bq85GmWKokOUSKoR47x8IHnutw4bez50e4cWSZtxy+6MEAd5FNIqveFzpV459XMoBrGfxShJWt43Y/IaMpSznhgqeNON/g57Ig8YC35nA8G47JON25rWj85Q83stbAG2m7cVXAIJyE3g2NAYmOtQytj8YuHwryNxbwQNnkrKl5Rnlol9Lw8JOqPt+b6hWLz+08uAS5QtDuGCyQxcqkHcAw8wDgj14dftY5Fn/zPFv+kOwOzjfWV1+uSUW3ZzJUBvz6nEBrVBBvlYKPdvRyqi+ZTtzJxEvjsQkFloZfBYOrEGZvIia7TummgoEgO5XCxrZxJD7NnzSjDn7hXM58Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:47:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 07:47:05 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 0/3] cxl: Sashiko bug fixes
Date: Tue, 30 Jun 2026 15:46:54 +0800
Message-ID: <20260630074657.43077-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: cf12bcc3-3461-4f2a-2738-08ded67bc758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	8qx5DWhO9ymYH8Dw7XQfONms2VWhjEjFRQ7AA6Laga5tmmwKYtCHLe/JpJxtoeC5ryFEQahM3itQvILCUsLftd2M7W8VNy7HVqiLgbdVmKTZzQKzPewepUcPMkPfvea+QJ6LgvqeOMKRaCl99IItNig27qmSUSBj1rogEqj+Ed3QvQzS/54/uKKE3eylSqSeTtd+/1eOnN2t2mKB8pb6nve+Z+mzBaHo1fbyJN2TwwBOkLqrHX9woBf+d21SRuEoSNg/DbKhyJQpSIkq37XISmlUNQScl1euamhS86u8apXDz0wHaCRoSz/NJq56H3aUFpqyIii95t0wfS7esU4NRdT5nEJ0IqkIa0CKuhuM3Vp7IuVKiWnpQE3bpO5cN5fkSpU5Q+MuXbxgdvyCS8hyq+wET0QI0nveQ5YzjvniQ/mYkMA45WboeIwIavDHYWGpWOmbooWDQ3Az97X7UvnSbzKYzYDJg7e7oiaMa8Vjso3Kx6D5TSOqfaN9jTcVk1jbpqaS9LjXbUpffx93ioIsX2ZYDX8boyWfdtXck5TFtxpVpXCPCiKmPaxAIpycdOCAxGVYEiu1JqVewlLbwSAXBWDYlNMQkJuMBkB7E2Ae3L80M5WVPAlfaRT87li3/axl41jRwI+9CLM25yYVeaW26Kq7VTct/BLlk9vdlksW94k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngHCPI9UR/X1x/HWvm/w+cLXt0qWU55JE8H4Juzlin0QXATkuz+psd9kew5A?=
 =?us-ascii?Q?/wEIoaXvIYXHQGYe/dKsSe8BJDeYfx0XwqRvVwrU3c+9KqmD2K0r1wkdLC+n?=
 =?us-ascii?Q?X3EJNEM91Dm0TZ7YTfNCI4JkuLO40uHYAYwfk86FJOxZHKHeXmoyrqJyFDUK?=
 =?us-ascii?Q?c12q5x6QyCKIhyZcm8BfufB79axSujcSOQKzKwymnwD6XoVnUPiFkXpGNgwA?=
 =?us-ascii?Q?URPCSL8SJVlR+j9d0lL3SovA9PWIYlI3zARp7J5U7Ah7ENlO0I7bJP+p12nR?=
 =?us-ascii?Q?RjIwxw7ZYzUvx7xDMG3HIz+KvUfSnUMHfNDhxbk/kV6PA1MyTSHneWnYYkGl?=
 =?us-ascii?Q?yvhKLkme7ucMFAQIp1MxbXET6z+UwGLckW50EX0VjR1LEo4d0aU6WSBpTYZV?=
 =?us-ascii?Q?nSSUHjXZej3NMriLPTd/HbSPZwZ8MMzLt1lIpXhRyGsnxkmVdeARBa+fonCb?=
 =?us-ascii?Q?zR5d//+QDIE+e1Hu9B0IhcRlqkiKmjtRO1Op8qTii98GqP+XvXt4nZHJvUUy?=
 =?us-ascii?Q?KJlVlARayrP27DzeV07zjwNWnobF5emNnXzHUZDmo9hAZENQbIM3uE8rqIZW?=
 =?us-ascii?Q?uo42xG7sV9gDiyAHEA+lcVve+uP5ZvdMGdjaWijvnj+qACuPRvmv5VSmaTS6?=
 =?us-ascii?Q?ijg/Lq8Tay9NcMZrTaa326ceAjSfhn1huXcXUT3SaPKquoAXH3g9Wz08C2fv?=
 =?us-ascii?Q?EJ5HwDtgHMmHrm3aICDCe2z7EO4aPIuc5qBrSYVpHGLTNEARQ4fFxxRY+RDt?=
 =?us-ascii?Q?GdEGXxINiO05gmRZcpFeTQZsbY1wuy7uCcUZzeL8x3cZZmHXG4kUkYR20FuT?=
 =?us-ascii?Q?8sGSwHISpxc8OWz1GlkxuPxsdyZ0g9vWOIyDDRZ0hUyebEK4v0XrPTQ9h25w?=
 =?us-ascii?Q?oVpjKZcWnhGtkEIs+hy4VJAIioIDoT5Tb1GJtUuspAbvvzsoYE2y5diPdnHt?=
 =?us-ascii?Q?MvgujwIqiiQco/TqyRiJz1im5LjnXMwNvaFZdRFJkTZNxQt30HPa7p68IRGi?=
 =?us-ascii?Q?1Vt8yVK7CXjuon/+/fUvjVfJBwE2hWlRJIF9uYxH0RUS2zW9aIZTx/LDPbmO?=
 =?us-ascii?Q?v8HrhpC+KHeCjOUbAxVZYZeMv/jIc/SWj6bBCvAZXzoiwqrQhH5uuC+h0miA?=
 =?us-ascii?Q?2XzSLOr+0nS4zSRPbSu0890lTiA7asUrkW+hAK+J2esmBjbrCGJ5yE4yW/4C?=
 =?us-ascii?Q?Cj+ijwKI8jh/6NoyUcExnewdNud1QIQBJYca9nKX2uRd6WbpHnzzjuSctnxX?=
 =?us-ascii?Q?8BdU2R8/48PKK1A6kVEr+pj3N1k0MQZziFFr7tOkl3yVyRyUljhAb82lIn8N?=
 =?us-ascii?Q?Da9Wr4wUgiHfMbpR/ZpCO1Q8O/kva2e1OSVL7usIhN2qIb0+PzwUiwyYgggl?=
 =?us-ascii?Q?kNTxE3zC4TTrK0EWzbdL/3ZFqU/kvd3juqaGjcfyKza0cXVvTqPwKy5dA4iZ?=
 =?us-ascii?Q?iylV4xP2kpZbj3VtOxCG4IQdaySPql2qN3Mj/hlCu3OLyF6bDtMnPKgutZha?=
 =?us-ascii?Q?wTRYjThcb1Q7bLw5asiFd8MZ5I8cpwgwthC6UzaSfyK/LpUmp1kwR9H5ZFp+?=
 =?us-ascii?Q?pIa+VOtM0EZdR+zzSLs+UxmiTFon6oMXBe1UBM7v1x0V89neANcXdo69Xklh?=
 =?us-ascii?Q?2idLoYF9cDSyauOy/JHEKZswZbzD00SK1QSiPrCc/RLqW+Un3aFryZualIBN?=
 =?us-ascii?Q?h0vuje7eOjpKANLohxLdCjYQUu0ZHmPurtB7swqSDyzElLfA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf12bcc3-3461-4f2a-2738-08ded67bc758
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:47:05.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ6JjoAOswIVLf1RscXGp0vS4uIxBR0AiKWr2QZvKRpdKh+JboaBn6GPBSzGpWp2Zez9GKnUmZT/QL6CXV8AtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

Three independent, pre-existing bugs in the CXL core, reported by sashiko.

Patch 1: Get/Set Feature stored offset + transfer-size into a 16-bit
field via cpu_to_le16() with no bounds check, so a large offset/count
from the fwctl interface silently wrapped and steered the device to the
wrong feature offset. Reject offset + size > U16_MAX up front.

Patch 2: cxl_get_poison_unmapped() aborted its whole partition sweep on
the first fully-mapped partition, silently skipping unmapped poison in
all later partitions. Skip that partition instead.

Patch 3: the same function tolerated the -EFAULT a RAM partition returns
for Get Poison List but left it in rc, so a benign fault on the last
scanned partition surfaced as a spurious read failure. Clear rc, as
poison_by_decoder() already does.

Richard Cheng (3):
  cxl/features: Reject feature offset that overflows 16-bit field
  cxl/region: Scan all partitions for unmapped poison
  cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan

 drivers/cxl/core/features.c | 6 ++++++
 drivers/cxl/core/region.c   | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0

