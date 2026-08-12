Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7343303B;
	Wed, 12 Aug 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533727; cv=fail; b=szr0nXV5dwaV8Fsbe7BhEwAmKKWui5x9bx96rU7yBsLECKtV5iHkc6jJBf0Bk0FYoXE7T+bL+m6pf5yEiDdfc05aPRUh84rxGIbqGLUPO4pC6hsc5kR3qhxaFgh0VNAopp3yVNj/lcVUSW2M3C7zMA8dihMwHNSITtx+BHQnZUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533727; c=relaxed/simple;
	bh=VFmyMXMqg8tcoIgwz6QVEmUkR+eqAEiQ3aDU3Zi0jc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMpT58pI3tsNhYrta6eqbu1lDEC1ngHEgDceMq6caaeAdfAA/m5LYLjpolIe5EvlaLdGv6+vGcosGAc9lxq+SpK8QZlIkGMzlNtC3oUzWlHcoFQ4F0vBwZrCgVbp23kp4j0bP1DTZxZRCqQKM3N3K+ylaTcl1sydBv38CH7QyDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oCnEqFY8; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oCnEqFY8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmkkqTC6tz6ZVsIA6XGItSmPCAj+dWXepBFbmwj2I8hOf+SKQSX7v6HKz+fB6lO++kuiEMUwtUj832kVUWR9ILO3jjss2LgxUn+xY2RLfYGLNrFjdyyxXvbhgk49VEhF/pW3b74Y7nCGa4vQO3NzoSgDoxRcSim2OGcAIh4paieHM6KBCKO3usavODRYKYgotwB0vFnBSaLjB+HFfDZkSXUe/+MAzstSQRD4lcFY7JnaU49G9TlWtbxplmqdtZBnXy4ALf6KlgHnd3lMHv5rlyNCpIWUeStlC5mwsLHzuexe3e6lfOXp8mNQZxFvqSngTh3vI9yjumX58+JvnBqdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ/w+FgUXkffWxt9iwsNfGAt5njzVP25NtvN6W59nY8=;
 b=D/e4/goVFjczkegz8GRLX44bFFjErBTjgutMUhG1919wcjizooTr/uxElGKWujDS8fDOHyNEfKVkJkZRR6H25lkwdhTtp8Mag9OFkpaWFSmt4vjix+jmxXwznZheTiCpDwvH7XnA3gl3SfBaQ7933OVB6I0hgid09JmN4YKT/Dq3ZYwwkatsaJmt0fxw2pm5VeCtM+5i+iDd8rD4c+eWAVIvXopVwzdhdTvgN9u30hToLGQEhe9OAHJl7pNlrLJNwUpMxHKF6FaipIR4vaZJw+LexpQ7E7oThP83on6vvWUjkf/4713ZV3oXTX6yMhnZPAS9pElyF9UqqXMAvlTfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ/w+FgUXkffWxt9iwsNfGAt5njzVP25NtvN6W59nY8=;
 b=oCnEqFY8NXdiQ6dUFL9csP6HFlImtSTRbPx/oD+FMW4Md7zZXpEGgcwL79sZfpUs60ytB7UeSLighn3KDoJV+hpIZXbg/LhOH72nW7Ff3BCuKndgqWWNQMCXvlOezkkggd5e7a2VVTWS7nlngdpG7aq88moLIlybFdV5kMouXn2KpQRvl3LK5e/U+4zKA7dFFMCODP20oJ2j0Q8XTW+QSXw60qBSWM8xrSCIdg8X+yqBLWAfFskjZQXc/Q480EsRwFbnnTrWWgYcXfdhw3roq9YwUOe5fcuT82sP3OFMnM3Dtm//RUKm74z1UIKS3Y5lheq+/GPQLceAEVeY8JZILA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 11:22:01 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 11:22:01 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v4 6/6] cxl/region: Reject poison scan for decoder without a partition
Date: Wed, 12 Aug 2026 19:21:07 +0800
Message-ID: <20260812112107.56181-7-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812112107.56181-1-icheng@nvidia.com>
References: <20260812112107.56181-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: be7b0d09-3bcd-47ea-f938-08def863ee35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ISO0eAzJ3821oG1mm7hmSrp9nYHAsBneDAKQliS+3Ta5i5eVQvgUmW0JoyMcMt3IARgfuTNSFisRAPcKlJ1n+ZJKcxqXsY7IKKO3vLjgvJj548UJee60gKh1CXbGz8NoVbiBxnRe5dHjQuOE6/VvuIWtJaorkcuMxt16J9YCEnAm9+V19etOtzvMR75qaW6pkrgQ/adBb4XoHqBwn6823Mzny4ZhMPvN0yIDJoWYfWECZanTsipARklsFdwvMMfdlJOo2lgsJidbyOX0VwjlVnB6yhRD845biPMV9Qz/MA3zPEivaMIz1Z+MbbR26WvMgvK3ol5VzGDK870HlnhWl9Xk+zS7Q6WgawR9xsjoWnfhP22KrYSKgALcAnyl84agb7uh/S95/YbjF8CeVT0/ktKJYoD83vje1I1PoaU+aX7yAoCOIOrBWPsPzJN8c05rgKMXDfdx7hsQBkQduutloUlMFP5dRl/sQgq5xkwQQDqqGsx4MTHlFCNYeK2LsnkwXzKrFvFdm9oONdbt/Fgt5lqm0Ew6uqaRcaqnJEwJWklff8qeyMJ6ITj7JcfN2EAKDsSsN915DzX4grW2Ym2p+T/nBW71IvcsK1ot8rJtHMGs7BHUEXGAluN7nFlJf19n/6+6K7IPgBKPe6DPc2crR8PLXZHP+vWiEn0ucstzoyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/MHH5Ra1fy4HsQVbCvFGIN9+19Hm33NOV+gB+D5zmkIPD3lB7iuTBKLtdnBF?=
 =?us-ascii?Q?AyQfwiKkjGn6bV1QnvUwN11UMRolsm1p13k7LY/9wNkhflQYfM1RsDzjJxMU?=
 =?us-ascii?Q?HgFrvoYR/Y3z7qoe1hOs9ATlJ/8TuORTmZBV7kq2qVuBK5miiamHW39j2nqT?=
 =?us-ascii?Q?h77ccqUPnBxS+bOFFZxKDi1i1YqSglu9/GcTJRRKe8qorALe6U1/o2vtF5SW?=
 =?us-ascii?Q?ZQi7UsU5kWko7ViOObxPB8/5LouG3cjcnAyC1aTGs2Rrq3KC2GkOmp1Y0U1p?=
 =?us-ascii?Q?VPDHwRSZXyO9Mxl+c5Odi79StG5Ilj53/39cpBeqwSrBmsdZI5oB7Ic6ta39?=
 =?us-ascii?Q?7OY78dc8GIm9sJjKbxfgHmeZaRyOCrbNG8+e32ZdHZsEzjfnKyeutUnVd6rt?=
 =?us-ascii?Q?tEG6Fd7w8vQdT4AgQvEKiPKQ36Tg9MN7OoA3Mwfj8xNJXIH19158Xdol+QMJ?=
 =?us-ascii?Q?5MCvxho19HwhVi2iYsaoauPEsdRvqVeuFU7ld96KWEDBSSo8De2Z0AGCKO4W?=
 =?us-ascii?Q?aYEBlGHT7a9k/OvnfR9p1NBLXk+YC+VRJCP8d4aBoM3J6bYx8HfE0qA6wS7w?=
 =?us-ascii?Q?D8qvVDG6tyaMT5XnBiLTE6TB/L+JDUidFrE0EjIaD6f5rRac+FOeEich9Kse?=
 =?us-ascii?Q?6RPGOp2B2WTp47HrQWgpziKhvTVmgW/HTrc00WhN4Txmcd4iveHYivmQM/pt?=
 =?us-ascii?Q?m1lr01rGsWjApxMXwNqAe1ieb7TWKLKCpQtmXAoDAGub8frun1Xr8TX5AhpJ?=
 =?us-ascii?Q?CQQVkcv82wKxhcc2uJGPG+2FmQ4OKY3OtHGLtzURSC6s7IOFd6ArLIq6viTW?=
 =?us-ascii?Q?p01iRvc0wOTXKYYJkWp9uOXgKPiWlnZ+hwpHHDlXnIdv94efFRR19WJYoq4U?=
 =?us-ascii?Q?5BVDqbLpl4G9TEl5n36ji97ySR5IrjepVspp2sECGAGFVA3ABk4SQlLbmdnG?=
 =?us-ascii?Q?/e9+0EUJ9xGlXU6DAlD4+yl55lGZLOrhkRKbHijnC8SLlp+Ll3q9MJ/On6d0?=
 =?us-ascii?Q?I0En8/4/yr0PHOa48jWtlsoBOptu0E7g0/lbqbXmMA3pSr1mF4xQjWz9uQGr?=
 =?us-ascii?Q?+ATKaNCVBSlA2amTN7i47TeEEYKHzXChdmtnedYSTrUvN3bN9p/gkaNCD37H?=
 =?us-ascii?Q?Kbok2HB6aGVITBsousaoosO1dOMBky7z+BiCfCndxOu66XV8RpqP45dZdvnG?=
 =?us-ascii?Q?704V8bgdPZhoyElQI7MBJ+ktWPGDJjSAYZNa9XA4tPqG1himeC3deyjeoaYa?=
 =?us-ascii?Q?EXtsx2UTge4ip/ulqBVrsEjc6vkKyzQxoKqmsA12a0evV/AZ5EptNwgJWdtZ?=
 =?us-ascii?Q?8zROLAFBgauYX7efotarMAHQ9Ij5KT/R/L/Q7nCpjAoUA0Munevj/eXRaTdZ?=
 =?us-ascii?Q?mRsWBF32sLSWSleG2436to4pDpvpitPpq3C6aLpEAX9u/YBr8MUxIEiUp6En?=
 =?us-ascii?Q?Bp+UuHGThfD5vCbgpot8MrgasPsdDYtarMqgb1SBDWPIYIFioDwXsP6Q3ZP/?=
 =?us-ascii?Q?sZ7KXmoYyxtrvY+Vx9qbbWySKplDJ6FurmjBa5T0n/atvINrs4lCJ4uELa/9?=
 =?us-ascii?Q?HSF46NtoaDTpubu7v/mVzZLYl8mcKbkmOMxmDH0yPlloXigCSP30EM4T7zkY?=
 =?us-ascii?Q?G0YurrpfU+Hf4E0qAh6c6v/YIzik8x9l9n6jBn4WHoorOQbeA9hBKRSDPSUq?=
 =?us-ascii?Q?nNXJtGK1BQY+YHUOcITwLssJeAg7DYFyZwQouwL4wb3p98Y6dV05jDambp48?=
 =?us-ascii?Q?fsyHcwpr6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7b0d09-3bcd-47ea-f938-08def863ee35
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:22:01.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1jO/nV5fJNiysvo1Hjz+BlpfnOGoNl93Yhfwh5XBCStHs8/fe1AEPZMMAZEABYvSPxNOKOv+ru3mtvB9ucYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

__cxl_dpa_reserve() may leave cxled->part at -1 when a decoder's DPA
range doesn't map to any reported partition, while still keeping
dpa_res. poison_by_decoder() then indexes cxlds->part[-1], causing an
out-of-bounds read when poison collection is triggered.

Return -ENODEV before accessing the partition array when no partition was
assigned.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b7dc5d4988da..afe3fb57b7fe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2954,6 +2954,8 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	cxled = to_cxl_endpoint_decoder(dev);
 	if (!cxled->dpa_res)
 		return rc;
+	if (cxled->part < 0)
+		return -ENODEV;
 
 	cxlmd = cxled_to_memdev(cxled);
 	cxlds = cxlmd->cxlds;
-- 
2.43.0

