Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6226B1428F1
	for <linux-cxl@vger.kernel.org>; Mon, 22 Jul 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661849; cv=fail; b=twdEspPXjDm62SdAmeNsjkcFTCC73zendcQC+m0HpXeXUL1Lluvw8qItDZNjH6k/g1m2PpuSdIfOUd5yIBuZ0hdl0lk4iKtWJ3tDzRsCPiMEerar5M0Lvms2aBMifbc2juPY3QdwDyckaFeVmNsxLeE/FQ1YFLY/TQpL41PNY1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661849; c=relaxed/simple;
	bh=7L3+8iOLYmnYvkfpfHoLksjR70rX1+ay0plqkcAR/9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cdJDpiCjN4ngxYXYRm/ueYVQg4dOeAaNmY88gymHSH3toPBwoADVyHFX8cdAQzzhKs4CK1cCIl8D3tYlk2b1uB83eo9PJKzqK7uLBGHLLDRzOpiED1aUIk1pEHxJK+r6qVMTP2O3xzN2KySDGmnL5h9txYh64djg5jkdu2QJuxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GmtOwrit; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GmtOwrit"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCc88hyJ29CAtgyFKzaHUIPkKt+DoSmIdP+Qli4XpFtnFcTs/xElLVE13nQ0vtgUz9zxZVsD1UYAx8YJYF3YwVtEOwJWgoTyUFkiwAQE5dzbITTmXmlhw3kbMoTIBnGNTW412gXnpvxRmsnO1bAUwOAcBJsiK4Z3wiQ5yYcQbpUdhSozjOrdgMosuhAQ63cSdbeIUcI4G9AWXZqXzIHqqOSqosKClg3q1znYM2CLKjXyZvlsrRh2WDu+fG+9jACP26lxsWJHQit2mjYddGRD4p9PW+xxbyPGw+EoVkn2wHHerR4SLw71NN/vpIqddICGvZlsBvvhps9DKH5+agafJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L3+8iOLYmnYvkfpfHoLksjR70rX1+ay0plqkcAR/9Q=;
 b=JNP3M5QrS0JkmHf9me8B3ILh1nHQKdUDwP5BQxoQ1qKMhRODg0oEUZDmHKnbdD86fPo0U+RtseFvHi5uQBD/3gd8kAhbrAE23cbBt2YAhzgvBvSXmYhjoqKwwUVMca5emJf96mwqPO5mYo/xRfFPLaapdqZVzOuwz79UP7Dj7fXyObZvna3Hpt6dYK/us5WjQvZNUI6bBzRRFvR1ixWRyUNrJxcozfq2S1He9FwdNqMxELd4u8a5ZMbZiRFZu07dtCdX/NWLTgfZX6OpSiuvbaIuXDl7VSjcE9fBqZVjiK1OB9VBGSfOGSfjFX4jkFuRhQ9vJke/fcLItnoTkJmP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L3+8iOLYmnYvkfpfHoLksjR70rX1+ay0plqkcAR/9Q=;
 b=GmtOwritK9CxlgIB5J9TZo21oOej3lfz/+nHUMiklguYnj29U3kICG8g9ZwgTOFEwWpzMMbh6YeWfAK9kHalJ0MibRBSNmlZMMUvXEDAFYznq8sBYDlolvM/DpKqUcarolkyaIsut1gXlzSJ6NXqPyPbgAvatcXw3o79/RyTmqMj5p77tyksMTVjd0Y0xKj5er0lNBHPRAN+FB7Dp4yKWStO3AKGDpO1lfl2lej0Kx/WqEuaxkpaEu4l1XOCLBk6YRsLzC2i/Zlx1u8HOumwhx7mZ77OrkpkJ3wlLbywCdSgSjrgNwCn7zrcd77P0bn7njUO92M6Om4htqcGd0DAIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 15:24:03 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 15:24:03 +0000
Date: Mon, 22 Jul 2024 12:24:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH 11/13] fwctl/cxl: Add query commands software command
 for ->fw_rpc()
Message-ID: <20240722152401.GC3371438@nvidia.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-12-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718213446.1750135-12-dave.jiang@intel.com>
X-ClientProxiedBy: BL1PR13CA0248.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbdf744-ef25-4276-0bac-08dcaa62519e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?95EdknvYlt/hb/VhkGN2kXLANPKxLRrCZzQcvF79nFofnEOvPajGV5z5f+d2?=
 =?us-ascii?Q?fni3Q3dBU/1D3QIYHo5sUjmrJgNLMEcSJ9VNrrwq9w2hg5SJtV62NJPYmsol?=
 =?us-ascii?Q?pS/y/nIE4UH3hdE47z4LJ8GZb047MEEtmoEt+Aq3YOH7yQ1Hf1AtKH+Q8IEW?=
 =?us-ascii?Q?yPFqNxjFddzw5erzONLh1TUUtpLnzzpBO0vnkNzbeugiEgNsc4K6YlFZzOAf?=
 =?us-ascii?Q?B1qy+cNkkA6+TN1lyrgCrW3NUytzWD5QC2Z3+8ZV747uxq84tTfCL48HzabB?=
 =?us-ascii?Q?7Ve/KAhPJr0Iw0bFeY4rPAzSSZvsOnpRvvyEteUv3az8DwN37yV4h9HqLm1U?=
 =?us-ascii?Q?R5ddEcFRVTh63/h8wBxtrIk7beRPNKiq0VGSRsVG99mMVyMWiiMmHu92CRG3?=
 =?us-ascii?Q?alErsLhB0De/9NqHXDOB/NRJjD2O4fKZnsotXugVOQTd9UR6v2mJ4a2D/Zd9?=
 =?us-ascii?Q?l6vpFU4FPTC2zkjaY3KmZFcuYTsrGMF61JQ/Y33Jh52uu4VKJrtv/efnp1ik?=
 =?us-ascii?Q?fGhkAD0A5PaYl8udlYcNGJloLzRCoYjNoTBS/gYFepzM8lsNnhQeT3MIUS3k?=
 =?us-ascii?Q?TYXexKpnjU4KE29hiCawQlyEgGhNSvBjDEDVu9Koe+/XZuAPIvH1c5TVgaml?=
 =?us-ascii?Q?YP/1Ue4Avkjbv7yTvNjUnNLymg2j9DPXz3kO/uTFoKWVrPjONGQ7UCWO8nQe?=
 =?us-ascii?Q?j7vntOtD7J6yhiUyc2a+nwl6TCeTR+esM6PQdW9GUor8u3TVUsfnIGAfxCMB?=
 =?us-ascii?Q?U9gVTvOWdVHknSBPZN/nJiS3x4H9UA+X2n8WWcjqk5uzx9bzxxjLdzeuea14?=
 =?us-ascii?Q?dS/P2RqTjZGhXwyAJi+FCDECq+E/2eAMxCQv1sOE//uuCq9HIhMgMtCsGa5l?=
 =?us-ascii?Q?Ju91s23uJM8Q0w6wYE9lAaXrP2tQ8MVcDBgGf6F5k9TmxkHS+cby+8LMFBIM?=
 =?us-ascii?Q?q+YMAwM7du/KVTj6FMpSoE3pq8RRAwuDkmDPk5DPF08ePxsN6eRZwvIpSghE?=
 =?us-ascii?Q?+u+EcsWh3ocdVFD9Jy6NJa41PQtemrVZk2laUGVZt2kjBJmUBhKwkotOMxOJ?=
 =?us-ascii?Q?AZ+wP+HY+WsTdjTRtntsOx7RjDy2HNTGJYbtXfvxaVJDFVBTHoRlE0NgxtdE?=
 =?us-ascii?Q?wML4YyUK9xfDAFHtKSWDAIGnpGjjUG4raAFrRK75HvO7+a/QV/WzKZ+rjL8t?=
 =?us-ascii?Q?eWs19Ehx2q16nKD5T6A8yy5jT5eQellKRzoXwjK9DyA8XJ4uju5b2U1SDlNg?=
 =?us-ascii?Q?1rKFXL5gIdbUYdbUYP8XzQlVofuBQqKjpJMxgvN0MG3sfUWLrTc7LkwhjEsY?=
 =?us-ascii?Q?Z4BzaNR0dEgOrowTxKZmgA4BrxoYVAY+ek61FD4JEw9EQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?areIY/+j3jUDKaAykx+x/Xwn1Kb0XZXoSYIY6yXJ3BbbDmpvrXAKWRN7Uw7o?=
 =?us-ascii?Q?mqv44zazKZK119xZ93RYsSIDVqW5MXDW92K9alpuh+9Ls3EN9brpNM+OU5Bc?=
 =?us-ascii?Q?dupI9FNRUmcoJjaBL4/oeA3eT/tkT6m2UfRr3L+AZ1pPCcst0zam/UbQZx7a?=
 =?us-ascii?Q?Ls6SRamyDP5PemnFnL/paz7GRWygA7b0RXH+r7NxvCws/zyMIGULdUpwxu32?=
 =?us-ascii?Q?ywCbgPxLtdzIwxA35yQm52W6S4263wfJYmCtjnn4H+6bzvDEdcR07nJDULe+?=
 =?us-ascii?Q?wcwcSrC8/q9Elbh5/TF89CffrSc+QkQVwbmVC8jw6pmkclQeNk6+FGr1nYQx?=
 =?us-ascii?Q?54bE2kRpm9/QGcggQQUHG8M3OnLlytfj2pousVdwgFEG1/6sOZCRR6gkB2BU?=
 =?us-ascii?Q?aifpBWAxQbqZacqF9kWcYAnefY5v+4/oEJf6jkQ20d2MKSXJQ3NYyv/QwyL2?=
 =?us-ascii?Q?TgxoywzCZ1bDRAP8Pch/MjUsp1HAFnEBQrEJl+Z/9DH1pMHDsbNMU/c6PtQy?=
 =?us-ascii?Q?eEt7RSHxvaEXAE9VToJiND0bpoEDUvYe0b8XYXpElAzg9DwMgt71BXoVskLB?=
 =?us-ascii?Q?c9tnehMT043bC1m2X7fclADCd0jdNeSOlGL49PB2h5N3eAQkAC8wWLX1CxfA?=
 =?us-ascii?Q?mv+Aa95fllU4l34fjoir1waiqR/pfx6Q4TaH2f/ADyCngvaa0BVoQQXYtViI?=
 =?us-ascii?Q?xwlai5Ae/GO/hekGGiyvdNS6/Dh9w046V1yy1fV9ozKMrFORY+UDLkQOgZ7O?=
 =?us-ascii?Q?1icgiMkiWoKsE156QQSrS5L6wOmXlya8lIKVTMxuYkzEA3ZcscTQPfo6SrHy?=
 =?us-ascii?Q?lCVlpUVxce52R7KEW4kWi2k0Iz5R8iLcLhcJEkoFV+z5TQzxqGxV0KVnFqxk?=
 =?us-ascii?Q?5cwVbFPQXqZLI+XOjniklvGNUeG1EXIfReIQTZfxTfyS9RPYusvKWYfh7vBB?=
 =?us-ascii?Q?8Em+WT7HvZQydqxsfpPwC9KAevuPRlRTn5nAdQlLK05DsUGXlxnr95uCnI64?=
 =?us-ascii?Q?Dzg0tthFz6upDwxIp48zHpAERCKtlu7KsCrnj9X04+9LhhvwRrvrio/yT6i+?=
 =?us-ascii?Q?RWMZsdKmf5Qvl1Orr3a2MuK3kVnqa2u+M5uH8cu79ilVnkWsUOhpBtO1C3Ou?=
 =?us-ascii?Q?AUVEVA7EDKN7GBAYqxf9rSbmBRV2doMofsSkcHbYu0WQtrcFKQy5WyIBxled?=
 =?us-ascii?Q?z7JKXEk7FOayA9S0SbSdqDqX33xx0y2r2T0BF/IBTFBoJvrGXP6KLcKhG9CN?=
 =?us-ascii?Q?gPgWiV7pzyJOg16bsD5aACFWS1gRPrLhGiaEJgvE1r/IamjUVTP18RP8bwJE?=
 =?us-ascii?Q?iB6w28/E/jrnmvIi/JvY7GsZDkELdT8f3gzKsHTlfjY17F83yxbsWT7hYvmW?=
 =?us-ascii?Q?85YL1kd3ot59DtqbwFdwub6zcVT6HlQlwNbJkUJYbKjAuSAWtIcdznANEGN5?=
 =?us-ascii?Q?jrokSKnlrXyH/hVLR1AZFFImChLl0UQLWWs2ePdo9g9XXdLaB7mruqwtDVka?=
 =?us-ascii?Q?5vWyTfJPXrU80LQThkqWXlF1quD90s5/6lTBujTbs7botDACZbGQnQEz+Ec1?=
 =?us-ascii?Q?+7KWaAu3qDFHxqxcsdQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbdf744-ef25-4276-0bac-08dcaa62519e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:24:03.4605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1J+1hpzBiTLA1CQKxEvnHc4J7ZBRF/+VwGP7eP5bTjTaXyoaTewf4Qb5MXl4ii1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343

On Thu, Jul 18, 2024 at 02:32:29PM -0700, Dave Jiang wrote:
> Add a software command through the ->fw_rpc() in order for the user to
> retrieve information about the commands that are supported. In this
> instance only 3 commands are supported: Get Supported Features, Get
> Feature, and Set Feature.

I wonder if we should try to have a seperate API for this, knowing
what command numbers are supported seems sort of general to me?

Jason
