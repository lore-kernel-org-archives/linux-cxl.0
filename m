Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C153228CF56;
	Wed, 12 Nov 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980696; cv=fail; b=ZQj4jyP4LSvHFUZDPYjfkPZoF0hUSzh5dJpZuXu3JkTkc1h5wbo+PEia/mcCdTY2aBUcWSAveyYOlqbVBVrsfNfi0PJ+GQtvJXXmCpJE9y0oe/qMAo2JqGSYM1gDUUY9ZmyHuCBUJV4/nkmn+emwaFWWfLpuwzj/HaruCAy/zs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980696; c=relaxed/simple;
	bh=4dYgLkugynF5v1UvdGS8GdLY1Gr2iqPuhYJ48c/2Qa0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NZqmDumb5Bd7H7Aky0lzvczJyBsYV13RrWfKzC4+3FDb8mb7Eg30uESTIO6I4ivkTh/4DSehF9XAo6uR9f5w725W7YTRsN6T39Kc6qWIsbaOg0Hqz9tSfqq+JDCWKsE9YYSintL6jJS62VEmdSazjegBPQ4/ZFFD6718I3VHH8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gf0DfcjC; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gf0DfcjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeGFeDV61krxQu6mv3lAkcygk/vGoSMpwNT64UorUOjsZW6gY8QoLruakYy6Q9wOAcgzf9r9hTfcoqfden47gSJ+DXykhi3xFdJnS1GKom2Q8DLkMciN/SLW2IHRQWgHLNYWL+ob6YcKM35PwqsGMFH9DX7wI76c7x2IRr7iso7JwL5vPIwOohsSapOnpB8SK0dGApJXm9K8ugEMVtH1lSkRMb9jnyDcJtCx+3ZlncvC7mzeTO6FPrU4D8Pi96jJtF0N4YiCzFdBrbdJUkioHW0Dg5r0UasTMF9wXSrdhkZX+r8EnFaRk4fv3m3SdfCM2+aBADqW9xkZB4bTUMcnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnWoj9tVdKbBSKqplPTRiQSTgc02AnsiCuNw649gdVA=;
 b=yTL1u5equnnWNNrVU9BD8L9pp8+yEQdcRtSqqiASN2XJJu0ZP1nV/xs8A26/1FlL+nGMkGVRvruXbwS0C4LK79KxW6l3nqE/NWieiOlRs2ljcwl+3OCUqZHYTMcWUw54RBJoecpCYwCtPOuMa/evMAMkuMw+LqDT7Qj3hLGrVgHlSgHcBz/0cVG8CzqW18kLEUo8tYn+5zapR9qz8ch5b7zUbO8XkbQPGSDCUEJ6rAvH/LH+m009l+r7+HVDOjwUZyjzOLcvQcHwbSBk+spuhPWW1J/Tulf0+WpVlnZoh9sBiRqddrFn6vCN2jM1K6ffW32AejOlc/HYoQGE2Zg0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnWoj9tVdKbBSKqplPTRiQSTgc02AnsiCuNw649gdVA=;
 b=gf0DfcjCG6yu0QLvZ7N96Qag8ctnaCdNPo6/IFO7iBxC3hLqRDV5yqO2mEAS+zfGHDWaBDxXOAB7Ww9U7EAcab4vVOHeJsG7Gt4feZmRG+kxQNIMEnE027oNOeVLG51f3qBJ7EYaiyEcShOOyc40ior4yGMVwcKgYFJPTdsrELQ=
Received: from SN7PR04CA0184.namprd04.prod.outlook.com (2603:10b6:806:126::9)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 20:51:27 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::35) by SN7PR04CA0184.outlook.office365.com
 (2603:10b6:806:126::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 20:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:51:26 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:51:21 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 0/3] CXL updates for v6.19
Date: Wed, 12 Nov 2025 21:51:01 +0100
Message-ID: <20251112205105.1271726-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abb34c2-9e0e-49c3-ab76-08de222d3f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dr51JQFI5CZ7UAx96ZPPdpquPNBkmqP1Atw9zx63Z2WP7r0/lncbPN/3gmeR?=
 =?us-ascii?Q?+5nT8LOG0Mdd/j/+49j6DbsprMbI8Bz+BgP2grYVIlDFDYncN9MvsFjV4sIK?=
 =?us-ascii?Q?dI9DlECxkWvyTszrleBIDOIf1TXeZRmKcLDZ6xrgYjoKO712QdA27NIl0nQC?=
 =?us-ascii?Q?NppyXnX+vCsEtLBh+U0PyMlqeqYq7PL0fvIIwkmHKb0XwV2GGs1NOTx5nX55?=
 =?us-ascii?Q?YO+IIu+z7xxqr6Ssn4mb9hPJdFFALMb4XzYwPxSByapqR3vyMZ5eq2n7xH9r?=
 =?us-ascii?Q?TCmgKQxV5gJ+XGnwBTwInouhmOqZD8+sAVkED+h7Awour+3KFtCC2GTr8s2x?=
 =?us-ascii?Q?VsRJ7gpGh9m2gu2F7tmtCeqnGbEbPlx0iIQGo9mPopd6bOqNVeZ/354nIupU?=
 =?us-ascii?Q?cuJfgxadLn6AcFFmJHusWKSQQdP/KjkzUXKBX+lvJ79fPqbVKHUycWOdbHQ4?=
 =?us-ascii?Q?RePmGfh7E5XmMdkiLzCiKRCO4YDOL/ny4DeYS+EguA7Pe4sS6zb/7fHm6spg?=
 =?us-ascii?Q?m1kq5jTKLCi6IqqzWxgV3yUiFx3/7vHDDN7Tza9nECN1rHSshF87Zl8pw5kj?=
 =?us-ascii?Q?/kX/g0y4E9Ep/rbGdDAjrs+qOKIXX2icGR86dLOFQ/5c+ELf0cLYmOxEzeWk?=
 =?us-ascii?Q?PqmpAC4wdJKkMnA4PorCfum7wT7JZoFMwUQOwq7uQa5QPM1MKjNMfcsCC0hd?=
 =?us-ascii?Q?w1KXJCCnliViIRGRChhjqeMvtfw8APCeVLGsy0UhfvxvlpiCEW4Uu+Tw1Nh5?=
 =?us-ascii?Q?GMr/ole2pZtZy1TkivdZxntSc5berPJYThQ2en5f7OR+G1+ZBkOwgc/WhwuB?=
 =?us-ascii?Q?kXbMM1EX173H1itW5HugWTFtBtIz57CVx3tBC3pe+R+1r1xLifAQwdKqR3GD?=
 =?us-ascii?Q?aYvNP2Gfx3Bba1ZOB/4dIC4GrrYWTJB/lSTBlTjQUjYLCJQqoYiIhtK9s4eD?=
 =?us-ascii?Q?rIStlCcdcxTQ+nqDWHfDogcghlcqriadIlzn/OWAzFa6fLpcbNuX0e/deYV6?=
 =?us-ascii?Q?NaCt41PyiLVYAHlGnPDlpXlTvJz3JzUpoIwArifeiYIe5mQ+yggL7lga71P2?=
 =?us-ascii?Q?c7pIvmrW3vTTL0BzJ9hAD/2IIqHvFSws6qjEFJKYxpkjUAQvraZ1lMsBbzDk?=
 =?us-ascii?Q?jnjboeZ4esUDMLeH5Xi3wZXtfUXLG0jy1C22NpKRG99kDIkYhv1fCUZij00m?=
 =?us-ascii?Q?SLWPvl00AToQhZWNUImqTTIGbRTsnr6ULgsSBIGe2HGv2lCHCzyoBHhkhkGv?=
 =?us-ascii?Q?Y5rcAQZrPose9UISHpogBBjn9bTfoUf/KC3s1Qp5EkMdv29kcEn2J0dVGa1X?=
 =?us-ascii?Q?5JO/JFaXkeBSFdEltVlsGh5fFMmNaorq1X6lqzizuU62vc3OgvsFtEkjRiR2?=
 =?us-ascii?Q?ap2c9m3dObjNk82Rys9UPhNm+EqAD9lIvEwQoZPDvA0AR/9XVMRm8Y6mRmAf?=
 =?us-ascii?Q?00HSp8uUZH2nI8Ga0KrKzDL31+JCa+qlUcIoaGYX2YtS0NUITGiTaVJ0o+7w?=
 =?us-ascii?Q?oyazgHiFIqFO+8nRc+soFBBoM5891KGSV+CnIMGFUWjFoDSEkydnjXoGv/WM?=
 =?us-ascii?Q?O0ubeuIE7pg1yecaSBo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:51:26.4377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abb34c2-9e0e-49c3-ab76-08de222d3f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817

Sending optional and rather independent patches from v5 of the CXL
address translation series [1] separately in this series. The patches
could be applied together with early pick up candidates from the
address translation series (namely patch #1 to #4 or #5).

[1] https://patchwork.kernel.org/project/cxl/cover/20251112203143.1269944-1-rrichter@amd.com/

Robert Richter (3):
  cxl: Simplify cxl_rd_ops allocation and handling
  cxl/acpi: Group xor arithmetric setup code in a single block
  cxl/region: Remove local variable @inc in cxl_port_setup_targets()

 drivers/cxl/acpi.c        | 15 ++++-----------
 drivers/cxl/core/region.c | 25 +++++++------------------
 drivers/cxl/cxl.h         |  2 +-
 3 files changed, 12 insertions(+), 30 deletions(-)

-- 
2.47.3

