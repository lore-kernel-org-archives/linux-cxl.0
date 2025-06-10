Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5422652B8
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560108; cv=fail; b=Z43KS2dDL7CPJIeVuCZre7/gCNCsvWTQi+IdFd9zLzQrqp3xt945S20JI75SQRh/Fd/Oea2HVKIiGtjWonKhHYrvISnXAdR82lxNGcQfhz+Lcq0OzE0Px3+LRgi7AMBH26F7RMR8DddInj+ml7j0aDcqcmQOB+wQNfas8Torv0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560108; c=relaxed/simple;
	bh=rpgBXhDYPdvL/aoI4tSZiNq5y4WRYGqA4jPGFAnO4LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AMZx+uYGszjjvbd61Y2sqLL4aLa8K89Oqh4F9cn8datISySZTTH84r+EiqGhaJFpONflGWA3FCF05QRtmQcULjxMouROFMUDbfHZxF3MttBO5Ya3x1nk4S+4kFwsgVQDHiRZa1j5jFMjDfpB6k16aRAa1u//Y8yPx75tsIRrQ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JbTt47No; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JbTt47No"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwbz3eab4+E9aOwFlNxfFmaJ4YlV/xTYgxj6o1dtGMsImgWMFD8R+Vm1KUYfwjImpuy9ovSmnt0cnQRDvzm19XdS6uFiLooITbhxPMYLcKDUyqf/0nUvjp0vLKz9Crl05eaprivkfLwaNvI1qopzoPxHV9141zaWvMEmtxgdZ59alJRw9NrNgE3Hof/04lKsmDfNb8hTB6Dy6c71t6sNOmXgwF0nLqZdZHv/pJfPXDZoMhV51Kw0Pcnq9Od6p1+WQfGq4hyENyZRv1Cz74m1rDIWedvxP3zJNP5w2cBGJMppehEHBOaRAQsUn3CIqMPDXrAfF6kbaRNkCzlGA7N0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS8zlkXY/9bWzZsbqa0U+7Gjro/tI4HCZWzHpYODu2I=;
 b=EgUguHDLajAbZuN5HuYUElubVhcqu15MIueyOaSM+0JiFiliE96tVfHEdaZBHT2NXo3GVrwVV8uK9YzLBGu83iD0AQ0PoQFe5eg3hLkIB7/xZEQfnWbibLdc1N2t0Gr8S10Mkjfnii/6dzkVfNEol+afb6w4MEEP/sQkfduLjpuY+m6RI8roI0TdvqEgX7/lY49FatmQZ97Hwikgpo94CUH0jW4uygdVYcVpUUr9BNIzoelw3893m7Gn2HnGyzmxcOlQntZHDmRvXPv6tzKnj9r9H6rYeMMsg8ysrCSvsLVrXytYaGOlSO6T+cHYa5KE6+Bt8GSvQbdynVjnmMQ2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS8zlkXY/9bWzZsbqa0U+7Gjro/tI4HCZWzHpYODu2I=;
 b=JbTt47NobC1mxo7Gd3+RcXdUD3+ysd3hJuhNc4vz6Vg1frOxZhnnqufcSRHbwxKtwTaoVTImHnGh6we2ZZ+SX/JUH9IAGwNwEuU9WXSoSMtaB8XA54pc3Lp6a7673XLzCZ6QPSuGYFvjEySdThm6U0FXwSCXn/2BMDDvqGD2VmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 12:55:02 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8792.036; Tue, 10 Jun 2025
 12:55:02 +0000
Date: Tue, 10 Jun 2025 14:54:57 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, dave.jiang@intel.com,
	fabio.m.de.francesco@linux.intel.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] Documentation/driver-api/cxl: Introduce conventions.rst
Message-ID: <aEgrIeoOR3J0Iaqs@rric.localdomain>
References: <20250603185254.3730099-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603185254.3730099-1-dan.j.williams@intel.com>
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c81fb6-620f-4d10-fd53-08dda81e039a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RZu6l2WgbNvwPeif5taN4HRjiXPD0lKd6xNRnZ7ATw8o3qKogqmyAbTv0gC9?=
 =?us-ascii?Q?JfH4IaKfpy9XcOFZi/cwcM7qWhhoq9Z6Ees2zbGK/52+Im6PnUdQYsWDl+AP?=
 =?us-ascii?Q?vuxSdZLwLyADFkAt/MVZragSHuR4oqJamj1wdlMU4KGynpyVWbSPMJEPCBVy?=
 =?us-ascii?Q?q/qYaz8ObVVwK1zZ4+6gCnO0dGDGMJYxItjLG/X0/USi3+myn5wgIwuRXNxF?=
 =?us-ascii?Q?AiMVBe4BAfNXUASaNfju/+pt0N7NBXcCOCltPeXRkWxLPjVmatFwluFDTqHx?=
 =?us-ascii?Q?lRmXEohYL3UAjYjkWb65jEQXYsLXsl/gfgClDbaK8ZR8+iclZRn01bY08cyY?=
 =?us-ascii?Q?O+RnPjMlWRb1O/Htn/tdM2WYbWrct5tvH5a0WZmZCmI7yaFHBX9M7Eo5tbGr?=
 =?us-ascii?Q?i44nzuWtU7/a3kgV/jfdernODSrH3IcgZGdm+CfmVPgmXgCPrWmHICwRFQoO?=
 =?us-ascii?Q?l0rIavfstvTwN3KSLcSY5bJUpko46onN5LM2UsZqj7h2k/EoqGGBwRfg7Z29?=
 =?us-ascii?Q?wNvBmlrLXIDTtUtVHvGX2TNSEMERVCqj4F8I5Kg944/Qcf0TjoMjr7ypsut9?=
 =?us-ascii?Q?/rqeX4opXKpBnHuhwuh3sKHD3TNyonHep3JCIfvsin68wRRlCOiecGYzVv6B?=
 =?us-ascii?Q?YjQCLlsBmM1tbYhQJA2TgyMbo/B5w5jR+I2MnJnKjDd+54PIvt1COOJPHc4G?=
 =?us-ascii?Q?qhmaO1fxZz+DgBvioCH8co4icWDA42+Gd7BNNDizey6JSDyzcW2PbGwQtXws?=
 =?us-ascii?Q?LvZ7vl4oug0LLYW4ONF6b7HUDtrrmpjMYD/3f9uge0erL+Aa1dS7R4xXaAYL?=
 =?us-ascii?Q?g95jNoK45ZDJ+uEa5scz0E6aB+t/r59vKJ1px5f8S2kL0DrQZUh7NtNIK69e?=
 =?us-ascii?Q?nY+XRkqOMPcJLwCIHKMVe0ADmEMVZBBHFeFMxCF6xx53ew72kP/wNCWuBGdV?=
 =?us-ascii?Q?wKhowvtDwpIXkRnD40CRuD6lc5FosttoDVS6qttGsEYl/fcd23/hFzQ45fS9?=
 =?us-ascii?Q?LpCwYckZsWOZ3U6YkV+nxa4BLAa0j6kL8V7bcZYxxOX5ssBc5epjwm6n4PAG?=
 =?us-ascii?Q?ZFU84Pll9KJZWbCt85prpa4bFkBs7HHWfOIKe56VsIkUvhsKxwcDmk9uNHqz?=
 =?us-ascii?Q?sYwOnVyhwLWyWGkbjy7CYIiDGYzmLENdBw8x+WefeQrjMRwCEuF0hLmp4s7j?=
 =?us-ascii?Q?Ehl7nhGxI6tcjgjo0xjuevcmnX+ktx66SFhO4Ps86biglupXNy5lGravUYBP?=
 =?us-ascii?Q?hzcfSCiZ5gIBssTpuELcvcf+OXQoZEwEwROhwflcaBVuOYn/So5V2xDV+reX?=
 =?us-ascii?Q?ByIRaHE6/NIavYdurBy3oAeeLafFMaIQ//PPsS00Q5ntzBxcZ4p33YC9FWHH?=
 =?us-ascii?Q?zhi5SxhhHBaGsa27ZSipDRwUyFxxufaFwJtz4VJW+4dnW5scVgT8YtwhVn84?=
 =?us-ascii?Q?wHLudfYukD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1x4UP1Si26/ASOyl+iWx5PQl3ZyEjtESXo0qkxzdgW2XCuUhnStVy4x5xndL?=
 =?us-ascii?Q?xIF3zEzDjrBBi/oFW/mhylVzFhfbP+7bdzGrqXUR4UschI/zrHdc2hOJcBR2?=
 =?us-ascii?Q?Sm9r/o899kzYj8T1gMyW9KzCMe1FRK8DSWkSupBz99xng2GyKGq4GNzsHYIA?=
 =?us-ascii?Q?ZiyZFlbbk+vctmaNhrLFyCxIKfFYuVMm+sbXqE22r3ZP1U4WBCh5w0Be4U9S?=
 =?us-ascii?Q?IRPQFTpQ7xwmrErlfhaUzCD4VtyqTxvYfcW0CcjIsJkqHE2Q5GimeF6fLtVd?=
 =?us-ascii?Q?OebJLLEjiLfro5j6N9gjTPS1/uwOHibYwQnpqx5LHwAo+P3M2ztN/0irGubY?=
 =?us-ascii?Q?XjL0CEYxITNjZgGHyYsIblqGC11WEgrNs4qvLaKb3br6OBg0Uf2TmJy2s1Ws?=
 =?us-ascii?Q?G30YgXwmua42TUFO3iaBSQ+j93MG2Gg6I/VMezQXnl5DzGRdavwSZhjDRuJF?=
 =?us-ascii?Q?ahkBthHIWl1cGZiJwuBaPn9ss3S2OzKe0yROk7rgOiey4+ppc/jLK87LL3of?=
 =?us-ascii?Q?IRIfx2YqBKyvIpJsVvpmFq2Djw69SrO9TR0w/wYWFQ9X5q9e+m7YYhZL+uBB?=
 =?us-ascii?Q?W46wUrNoxfRQ9IO0XV2sozNKrH+i8i4MIjvQzu78u+xeVggye0iN8uzpAsm+?=
 =?us-ascii?Q?uiEFGyWVwkT6JFsKuoVgKUskW6CaTvXFNblZtC3xO1USIrwtZHbIGsK9v1hI?=
 =?us-ascii?Q?Off0xXSqH1jVQO2MPoe2v4KIFUJ9JNrzv29eCexFxthZomhpd+ef0rA61sRm?=
 =?us-ascii?Q?0PzNFs+08l+2/pG879ScmSbUVR/WyOmAGmHFYKfFxCJygJ5RJk+a2mCfBIjQ?=
 =?us-ascii?Q?jDhKSYqPX1LrE5bY7l9awFogq45FW4+7yaXmZrctmIa7PeZ38+DTyABHxgKj?=
 =?us-ascii?Q?sYMRCIN9TtXOrrO+iu3iBAr3OJGsZe0meo5aIgSahjMoSylhSj59iMMNwly8?=
 =?us-ascii?Q?GiCKXVXonhjk7tpopK+D+z+4M3wjQQSyoR0SjyMOv80mNepLXqmsyaOTC2cr?=
 =?us-ascii?Q?mp3//O9iRud42wM87VImg9kF5K+EJbV/Lx/ziz+ACvnuiUoFasWd0u8Kxf2I?=
 =?us-ascii?Q?ZvvniQzyEpWjwfRy89W3my7qVjrtU+UiNJe1XJPRD47pE4K9K5ca3pKTNJb5?=
 =?us-ascii?Q?vPKOaAcaU2tbXFbpKw8tiWad2kKyXxDcQyJb7d3izlOvUS8EBFTm/fBEaYY6?=
 =?us-ascii?Q?dDtHjM/jxulDiGTQ2m7WWAhiXkbedlC35ceM2Ija+cRmFTi+ONjKrKtrz/FG?=
 =?us-ascii?Q?BXICkL87VutwoiqlN5rRTIQoqDnPHPrt4oq7UQx3vacSDaurYKb36Oi/V9HN?=
 =?us-ascii?Q?TLGqgnU57tAeEz7/BFNtk5YlSXvVcX/jvr3o1Hhk1KErsW3xCSZg2hWJQdVL?=
 =?us-ascii?Q?Ygpo1kdbYaJF+++2QiVWGuBuE0DUMjyR7Qi7XorvIp+UCuoI5Ty0Z6FfgC1q?=
 =?us-ascii?Q?nRbxHg7sVt+J/E/ZtiMD3C36R9STLNGPH4pfXqj4nPEJLOD/i9Ug7qoJuC27?=
 =?us-ascii?Q?cHBwa1mtPQ8xjEEkjQcpIKt/3lgZyhh44LlM/0JsgCAxjB7kWWx3t+fcKt5P?=
 =?us-ascii?Q?ATDOqH9fWLmEEENrMejkEsYiaWwKmsmXGPeMLhh0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c81fb6-620f-4d10-fd53-08dda81e039a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:55:02.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFNcfowjSs2XBRTs6BGjcLRwb6/5tGI043Zlwv7XcXZxguxH5Xuqe3mlsjrpvbYphOohu8Cr0vsju6zWALs0Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

Dan,

On 03.06.25 11:52:54, Dan Williams wrote:
> There exists shipping platforms that bend, break, or otherwise lean on
> ambiguities in the CXL specification. Without driver changes to accommodate
> these deviations, end users are left without CXL subsystem RAS features.
> Specifically, provisioning, error translation, and other flows require the
> CXL subsystem to understand the platforms CXL topology beyond undecorated
> memory address ranges.

thank you for addressing and documenting this. That helps following a
process to generalize platform specifics and add them to the spec and
Linux driver.

> 
> Those isolated compatibility problems risk growing into deeper upstream
> maintenance burden if different platform vendors arrive at diverging
> solutions. For example, there are multiple options for resolving
> low-memory-mmio intersecting large-interleave-ways CXL windows. Linux
> should only entertain one solution to that problem.
> 
> Now, with the ACPI Specification Working Group, situations like this would
> be resolved with the "Code First ECN" process to codify Linux expectations
> in a specification. In the absence of such a process for the CXL
> specification, create a file in Linux documentation to detail the
> motivations, assumptions, tradeoffs, and proposals for amending
> specification language.

I have found a collection of ACPI ECNs here:

 https://github.com/pmem/acpi-spec-ecr
 https://github.com/pmem/acpi-spec-ecr/blob/main/cxl-hmat-ext-linear.md

Is there the plan to have a repo like this for CXL? Or just use
Documentation/driver-api/cxl/ for this?

> 
> The goal is to capture the issues such that platform vendors arrive at
> compatible solutions for these problems and serve as a repository for
> potential specification updates. The expectation is to update
> conventions.rst along with CXL subsystem code changes to accommodate the
> platform topology.

Ah, so it will be part of conventions.rst for each ECN, right?

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Though it is already applied:

Reviewed-by: Robert Richter <rrichter@amd.com>

> ---
>  Documentation/driver-api/cxl/conventions.rst | 48 ++++++++++++++++++++
>  Documentation/driver-api/cxl/index.rst       |  2 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/conventions.rst
