Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683D191F84;
	Tue, 14 Apr 2026 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776134542; cv=fail; b=qgU+NeXV/JWolujlQgfILnNg7+OjztIYm6FXCp83J+3sEKAcIPeSsG4nvYRZHXE9AjSEng8SgbtGL/VeIWhLxUD0KQRXdpL1QPmJ/u+6fxyjeh+jTNSoVkV24eP7M+AE3kr3cZO43aNrWtkzudh+8Qf0Qa9DKLZMK1HvSVpihb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776134542; c=relaxed/simple;
	bh=S3d8j/MQOQyOJ9hmDhkyBx2MmLI19nwVWP/dOp1vQTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tbA9caVgxJVj6vvuFnmvnmDWqtKeuvwq1uzHGvHScsrbQzaKv39kpsHcxdMGbE45A9JSWP8tGKqLutcpHnzZoj9HxJeWtrg56f+qLQrGfMpGT5bmdXKev+I3gH1QcCj+HzkgGKdJXlw9G+PNn067cCUaYlMsfRib4VtfpIzqvqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MV/j7iqh; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MV/j7iqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jezOcQ6AhIBowSbOCB9Eu67LPqla1L3rnUXc8UtHzHNHMfPCOTXWAiRBTLgYQp3sucHWwyy4kAtFpbOEYAYowyeZ9vi+Z5YYORKz0yJbgk7tbgzft6nuecbGhm6lsr1YUW3MV7Ck8+uuU/RqSzQJoTDsAgvfCwviIqS2x1Y0GrSL6KkDv32CLU4GCZbECJn8R+JxdH2yZGfha5gT/Grz8431oFxES9kFYqaHVrBq5oNhu5K/BDb7thoRAM845k1xsJTDgUL3sb418+rCnKL+fkAYJwFUXgXSxITzRh/Rlho9l5zx8zYr3NQDtlY+MOCwY5FmbTC+p5WQyBt3atO/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3d8j/MQOQyOJ9hmDhkyBx2MmLI19nwVWP/dOp1vQTA=;
 b=fyHR4a3nNdpQSnS87SpL8kWquYHKoMsVBDD5wXjsWeIZfb8NcRUc/HFG0nxhCapHNY9S5H/LtU+veCWmPXZghIEONfNWgvBios4kK1fkQD4VYtH1BOuEuymI4r1f4dhYxRdB0QSOMDuWTMpjCS196gasrR2yAwXLqfousUwbeDbmhXWtWlQtWcSvke/iW/0j+6Bk+2WdkZvIJ9RwyQlFoFkIcB5enoIscGlObr/DCyHOrw6fQvCeYJguim6GukcR0v1pGg7/M4RcVsqmFzGWy8OR938QY7yJxL/23mfnfAvxMnXuUkDTo+jBgPscqgfbmsdcFrCuKagwjVbFt1E9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3d8j/MQOQyOJ9hmDhkyBx2MmLI19nwVWP/dOp1vQTA=;
 b=MV/j7iqh3PXQOWVhc1z7QbtfwmrOLdDUWOZajpMCPveD2PlpswchFdwQ0/MqX/B8jFTSA+p7TEb9gLO9kYLCDysthYufP238pb9Fyzo7dyGrk9cGtNwohI+H3/PTlnnPUUOnrVHzSU3KOjj5196LZ1U07tz6PcDs2xsGjyB1AHlNkroXu89b6vBX5ik9CmnGF8v96QMLS9QUaS02aTWiXzyOdUKT5dAzyyRR3rKIjopu3u1aRhqZqRtfd3gQQgnh8Gbwk20DLRPQZlCHbV4Ceb7LGrpQ8BpQgM7ow7kX3IU1l6TqGH+Co00rIhpSTlRurOCgKsm7h2v3E4zxnAhhlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17) by DS0PR12MB7702.namprd12.prod.outlook.com
 (2603:10b6:8:130::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Tue, 14 Apr
 2026 02:42:16 +0000
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688]) by CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 02:42:15 +0000
From: KobaK <kobak@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Validate partition index before array access
Date: Tue, 14 Apr 2026 10:42:12 +0800
Message-ID: <20260414024212.3398675-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <adrWNiO-KeTIqBbL@aschofie-mobl2.lan>
References: <adrWNiO-KeTIqBbL@aschofie-mobl2.lan>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHXPR12MB999244:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: be09ad05-7056-4ce4-cbe9-08de99cf7066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5akvlC5bf0yQsY/fR6bJSwLoJM5g64CADmrdo38TbmSAn+O1LnrFTuiYPUoJT3XZhAehL5d1zGtTjiB7kL1+8mNUh0ZHUxNhqVi9hTW4fC1M1IX5p4UsoTvB3BGkFpiuFVI/WzNYzqsg2ilY1n6c1cHtsdvXo2JOikgCSbwyy2e4IQN3iQhG6TBGYq1dAaYtmQOL2kqXXiFjumHSd8Yn1fhrCgRHrEhRIFgD0qjh/gb/Hd2pivGRH9A15LCnmmYAnXo6Q2MLs3DXiAAcJXYuB/MfhjVecfEeeCP1dPv/GWv6l0CVtIPtpnWLjIA54R5H23lydz8exPIczZq7MdSiqMaB1myEdLB/cHmPIIBRQKOhDAeiNvHa71QefnL1aAix1B8phyp/BNRog6kOevFIt5W+DdnzhB1cKE5J0sg65ZwLu5YZ0/fgVd0zN4c1nD9ANZj9x6aAdvgKDUJu/2u9qKYFbBEEpNIRqEBwwOl7veKxBQ1PAM8/ECsaChodooYhoiFaMAvKw7tDmmfL82CyXKFUActc/yeHZrGMU6tsy6eypaRLl8KXhV9IpLTnr05aeXGmOvngpNtR4SEVLF95mxmX8BjTBKeWY6isMv7K0FpPAkWPB2c9C1ti6bQugp9Yy1iT3XIWeuymT7oMGPvUTqE2dbsY5zItoNgyeXubaptkD56nPtlk+5AuaAcb+efOdhzY0MgijaVc+e9/X9tk5mXprZtA5OiRwgdMO0vZNbQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHXPR12MB999244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gDOzOaqKQ1cya0ahs9831cTXWHklRW2wBYk+tOn4tsF2mSExgrvep9g0r+xr?=
 =?us-ascii?Q?Emp7tGBX84Bia6UxHZcKmIxKfiQ1D4VtUFRpAh8Fb9hTMjYRNjUeTTH/8PQU?=
 =?us-ascii?Q?xNN/ZWfeEQpdagfdGSS8zL3Fl205K3kD5sWbbmFaS3HPZt0GNtRESWaPHBJO?=
 =?us-ascii?Q?OxwyZUfZWB5BV1VW5sOYuS+QlHc2Lucr0FLGEOvbWvX627Ofcpq4At55uhy+?=
 =?us-ascii?Q?OCCIjWR9bIsZgcI5gy1xDURtnbI4Rdm5ZiYQZZEth4pLjIdBjR9CZ20FbZ1I?=
 =?us-ascii?Q?+92yT0YUtSOXRGaATOVGxJkft5InxJVKdkry1KYktdKhNUSrPJ7MenNU76O4?=
 =?us-ascii?Q?67Z0eey1q3QIWKof0IOKvqxU06Beba4AxVsJGm1C9r8XyDn8bIoMLiJedaso?=
 =?us-ascii?Q?35Ubncxe0a5p8QMs7tzCQ63fsA58vwWJkkHhaG6qNSaTwS2Bu7TnBSFlRoj2?=
 =?us-ascii?Q?/ZNk4GdaH0Cm2YsudiWLOZC0DjxPQGjmGKawTbnfXnz+do+7eHe77dNR8q0i?=
 =?us-ascii?Q?yfHmHPcqAXeL2t7RWDtahPws9gc3Ct6QDOLkeCmBlJFAV7XjfmQ/pkYDTdVk?=
 =?us-ascii?Q?vWhw8SwaHHf7N/e2JINfLyQ3dVjbKYHYXPN+nc3ojfrF73PLM1vUFwETLap7?=
 =?us-ascii?Q?OUs55NYjRUkzghSseAScrJKaQFK/N8MB+XVftXTTH9//ezseFe1rs/6uDxoU?=
 =?us-ascii?Q?fOlUNgm0G+E6DG6cDsrmduwp6lp1nPg7/pqB5geSyOuENpID1zSgmUmYnCsx?=
 =?us-ascii?Q?R1JJybcaZxsMGAWCey0WCqhajQgcOVnvZQF4kNqLUEuUwdMMpVE0N+zae9ki?=
 =?us-ascii?Q?+DesBM8Kxp6ilXhDhwmvgKIyLsRQMJTJvrnX6J7C+wRR3tezDAfNQqTpCSww?=
 =?us-ascii?Q?ktNWJjYT/Ae4W6rhIxQJnjvpuZa+AfHFSNSvf4h7UzbISpvtxxdLnvPOskZt?=
 =?us-ascii?Q?fnPcmlQxUCGvp8vxZU6Kr3qahYI5854756S3tsskCdrQUKcBM13zgOMBOZ2D?=
 =?us-ascii?Q?lHQNkHn/PBM/3d2qcJHQhPj3Uxqe3Tsqw6cfEXEtC1NAMMKADC1hnxN9haUX?=
 =?us-ascii?Q?9GO6ygygAe6Eexo9XDoSQj6j1nI5WWGbXu2exexPuHA8pv+q4XUyPV+CFN+6?=
 =?us-ascii?Q?5p8RXaopSXkIB6JsDlR6gVcuIXq4mqahagycGi1tmMV+wjaqMpEGspUwuEU/?=
 =?us-ascii?Q?vx0fDpxuYQa9SiOCVUrrIO3mvuVHpZwy4i/B2yfSX28430x32AQdWhPd4P9p?=
 =?us-ascii?Q?vXoAcJL3Lf8fzOyrIj6znG+Tsn/ErUYY6JRm5ig0IfmT0E5OEDMerEUIYA36?=
 =?us-ascii?Q?lmhSt7dkDN/V5EyMIchD9FAIthLTRuy7g/9yC32VJHiv5kaSq4XzTW+UFRo0?=
 =?us-ascii?Q?C1aDWu2TGGu9SFqqkY/whmuMSzC9bk10M9uGb5NJ9cesBh6fQiXs+/0YqCng?=
 =?us-ascii?Q?7R/sa7QK0Qf2TrJVHH1l61hOOqluQaF51wVg98PR+rhJgw1UCz303rLbY6Z0?=
 =?us-ascii?Q?7RTY6uzySSDX1AApVAlQxH5I1BeXDBS5z/scBtoufJdWIZYoZMrnNY8OnsFV?=
 =?us-ascii?Q?i5y4HNcZUhbhwduLFGBYZzi7tZCOcjamGcAP+mybTvEFPMv5ZPiktle5xjD1?=
 =?us-ascii?Q?cJGu3H21trF1BT18mPZEW/EwCPiBNqi8+YLKiu+ZHh/jCjty8kj8amyX52R5?=
 =?us-ascii?Q?Zcccxo/RB0La2frgnfMrqfpPxZINXA3yA7QQVqtsvcxxaeHo4/SWWZDksWyp?=
 =?us-ascii?Q?3vmfp37SGA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be09ad05-7056-4ce4-cbe9-08de99cf7066
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 02:42:15.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNpq3snAfqqS28cGRKqHioI82YVesP0Go6MbOxqKEMqYckBrusqH6ghE6Q/F4AEMZO4MQbFyIM1lxAAlS8XGgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

Thanks for the review. Will address the feedback in v2.

- Koba
