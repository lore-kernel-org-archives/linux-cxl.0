Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E416D9D4
	for <linux-cxl@vger.kernel.org>; Mon, 22 Jul 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662271; cv=fail; b=ghAtk3peVt4EGfIAG4DNVY9GNi07IMOlbtWb6vPT1aD55vn4eYySoKeYZ85qOh+RB/ViNz9ciYmmTAuTcTNLBOhLH0OMnmXse3G985PhwPJ7onhH+2BA+PhgDLFeXJRvl16fHMkdUAPD/BFOpAP06OtGu/C0O1yRXKMWwh7uYHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662271; c=relaxed/simple;
	bh=Fdekkq7j0fQqh/J4BCNQrdDoSTTkJA4BA3JPrxeq6Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uHgXXTqo12A8CSzctZiXL2vOtfuZJt0A+UJDjsNuFV3H0U9Xl1KfbGUcgqxvZnXtJzdriB4KdDwsphgfDh2GJmL3yIS638fhWw+rT1LPSvEzvbq1usNwiOxNqsWJIgwHxfsgYXVPYRkPJ2Z6LjYA8hP0wTE9By/9SOlUF4xGsVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1TNVEX+; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1TNVEX+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzoHWskDAt0Ua/64YIFQA1MrTEO7l9ABk1uRYw38fnJI0NSQi30R82Dq33qzDvs2CzwG7VTNnBGR5s7IU+zfI3BCCQdNNjkOXaFNDEW8QINCK5DYXCr/+mONYpcyFua0q4cGdjRga8OQ/tEu9AdiFyJVOUlurRUfXOdIJIumCe6SSRwuSkQMJPc2QH2PxGdkqqWrpwK7LCYJQDkHkbxBTCx9jd3lV7SrQFu8mhg8vPGEk1JydvDsHPYOFH7F7dXkzQSsZ7MNIjQU6hRgoMHIQ9Kw8rE8ueQ4FcHpK5N04P1A2/kj/8jX7rcYO1x/6OkbodNRLQneneISOi77JnQK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naAxleW2vDGdIqw1xyGwrfE+YRzM5XErBtGTsnEObj4=;
 b=tvs8U2+HckMu7TQj3LDqbd1iDd1GkeuKwwEob+Y5p5HN3nhYc5E/LEHzGhz2bwHhNPQu9c/AykRdP3UlkQ3BiKwj1unprWH6DjZArMDySwuMLc+tWKtvYVDPfLix4ceMnDGqoPqP5wXyo5XtNAwa9mx8Ybh0SnJyHYmW4rjaWzhlGYqfNNUbm7YrgfJcGr/0JIf9ZbqZPPJk4zGeJqeYkZ5qesoE0D3M2W90HS8MXEcjGJLwZa0koOVVplG1dChwyEXU6tpalYPJP/IkBYaKNI2ScT7jcKsoNnop28A0AJOzW8ose4PH8g76Qoavpy34SajjReA/MP7ZNuaufh3Llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naAxleW2vDGdIqw1xyGwrfE+YRzM5XErBtGTsnEObj4=;
 b=g1TNVEX+fsLR3Xa+KqQaB9HjxD59fIu302OLRj/utGRtmNKGEoMFZqB9kQSN3NtiyGhhxEHvdYJR5kd6g5n1pAu6qBsXqBNq+N+6F2I1soS4uzamR6UBVsqIkCdeRl2yjkO1SEOhyDmwYvwRWbnyiBYHIfrj5ryM+U622twxHgE72p3zYSGwrPzzZjVfii5ucVzZTv9ZVAA1NPSzFESSJ0/sJjuhr4lR3+CGbRSmOGtVf32TNdhXEcjnkc0/by80V+AlHo6ZhVPy7dqCkUFPj/D0IcQbMITWdnSut2wSbb2LsQkM/gjzlDjC1F7XQSeq/CQ40vrZ8RsfdTQ/JAdh+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 15:31:06 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 15:31:06 +0000
Date: Mon, 22 Jul 2024 12:31:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH 08/13] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
Message-ID: <20240722153104.GE3371438@nvidia.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718213446.1750135-9-dave.jiang@intel.com>
X-ClientProxiedBy: BL1PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::9) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 96054873-7d2e-4191-11b5-08dcaa634dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZZUy+wApoM7Ja7tyiK5TNsIbM1Tnl9YclghAmIHWaEc/G8RAMhmZC2RHUFPp?=
 =?us-ascii?Q?pSSWzRR5Iq1DNuPFrSg2D8FJiHiMmZuPgvghp6noIsIGjFOOBQUgcNLb/6oN?=
 =?us-ascii?Q?IKq5hfQGIZZgI9AVyc8nMC/1xYdrPvg60fl9Jo2Qt09pBEiig3kM7I2u0Pbs?=
 =?us-ascii?Q?B2IrlMvMTQ38ZPc7uazaxkq9cJvaSHgikPSudzgCLmcBH15DBrkhLpqXwOcr?=
 =?us-ascii?Q?i3G0zeQrQxPALI+Ptwg9IQZxCE8ZW6UkMamBcWD7vCNabZpGbGtuRZfYwSSQ?=
 =?us-ascii?Q?So4N/9F4E0UV3LU9P+boHR/xAJZ8A92VPTObOgxl3BfiPvrwZHTaV6VGACQS?=
 =?us-ascii?Q?J3cbDIeynVJkQyznrtUqteyqPqCRfKMnY0eaI2rTW60U7OfYB72pM9GRyLYb?=
 =?us-ascii?Q?Z9meufOX9uCXKLhCvItIKPIgC2yi3ufadtlOzdTkAHNrXx/XTxXOL20BzecR?=
 =?us-ascii?Q?Pv0jd0KfRB47vm8SdIkS4jjI3mX5Qh8eyhT2iGXXAPJlMBcMKhmxsHq5is5c?=
 =?us-ascii?Q?n5ky5QLq1hq6QsY+k7w1ufDXVwRYPRdwGTONXqWnRGOULpZABgI45KTc6605?=
 =?us-ascii?Q?wBTfr6ejfNb74U+/p3qw0qVZOoq/lMCkuPxIUNWXDUI+Tbvnz92jhB/iOIxL?=
 =?us-ascii?Q?A8Ps6ixHCECwx77yr5q3Hk01+nmBtYqURo8ylGpvvh/L+knOp0b0qc8GSdEc?=
 =?us-ascii?Q?lUqe0YNXSmsCVc5YnNHjpyeJdXRfrl5cD2UtqXuKJ7aGztDaKpMHtS11Bh5y?=
 =?us-ascii?Q?XjY6NZooHAyxaQCUjIghqS6N7//kBUpWlIxjzdWTeNzPeKUtt5sao7X66zZP?=
 =?us-ascii?Q?kAESv5Yr4ST+ppR37ANbH227eYnH40ApQc3duJ4fnskWapbbEPtfSjoURoPk?=
 =?us-ascii?Q?9C7ZBZjl1UwNDkw6uLiOUcZk2qz6ll65RRkIG2AGJ8vuyjXh0+0uAHH4dipT?=
 =?us-ascii?Q?i7AqsLowKgZj5QIegBDBgQnXNVrlTXC112mPo8lKT5TeEPaODcXsAhl2SBZC?=
 =?us-ascii?Q?KTEiB2ZO2nzrh0DZ5T9JbkZsU9CJchmZ4Bjkhy7alBiTfP2IbL9qM+PfMqRu?=
 =?us-ascii?Q?X5Y+wabAVK9fEJIUWBh+rxl1SBkKw+IErnX5qFP6KaZ5IbLqiqcZkavrE45W?=
 =?us-ascii?Q?FdQ6MIHwrOZLi6ciLkKG/v9GSeaKTEDHMcF2nuN7UL8tx7794kxgBZ2a0p0z?=
 =?us-ascii?Q?36J69Hnjp24O8EuCCAsjSQ+NblYdceosVWQE1DP7yPLXIcgnwa4PGyMt3s20?=
 =?us-ascii?Q?8MiKgtQzIomWt8jicJVfbWyc2KXSSjapS5IUag/Q0Hh1tIByFUKvo/PiC2MV?=
 =?us-ascii?Q?pQpS4eN7YDWxthkD3R6m3yjcYMbMy3geHW+HikCJiD5klw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFd1cmI+UJInIR1uR7sfK+Uy3YVlpSzvxwAQKpf4GrdyIUlJQCFbnEQWX3ue?=
 =?us-ascii?Q?EkX0xXfRAYPMhQwThbbVOjZvfpV7j+AtwM5EMwpHiTzs5jWzAf6njF5q4igX?=
 =?us-ascii?Q?sjOcZGj8oSz/0bX1fCtXYQXFuj6yIjBVRI7hsLRr0acHPlBuZ4V6lXI20Vc6?=
 =?us-ascii?Q?sqx/7g4vMD+srwWgRo+a+SWyDbR38fjWfuh4tLPXcNaqVz+9a7f0AcS4pUMU?=
 =?us-ascii?Q?ioT4AwhHfirWn0I3B8wW2zkogtlkG8Eot240PJyeA+4XRkSWFi2TFoYrMZv9?=
 =?us-ascii?Q?DYuByMiWfGULKfzjgh/5bNEduqS+FaJOe9wi4LuR8EWbyDt172JhQsK0xNnA?=
 =?us-ascii?Q?aWGQ2GuoCD+71qLtDxUo4TkS5HmH3bpaUKinxvGrBqeQip6vgvvaLh9iNKKI?=
 =?us-ascii?Q?WtKUgEwotNmJDsGj2JEZCjMO6Fh+Ybb8oNmwhpKDozTzrgQrgC1F2SbcjfSJ?=
 =?us-ascii?Q?2lD7K1qK5JTb0cKyiuuAoUe+eeQcuqmYlx/08UYmrZftQNNhSe29mw1bX8hs?=
 =?us-ascii?Q?8qgR/3KHj19nVpWXP3PVTw2JtyDcwD0pu13Zqt3HWzm1Nt2ywAG/Y1GCcX+m?=
 =?us-ascii?Q?hOIm7W96YRqx4TkjG+U+MSjcgkUnmyRpwPpl/1Djqxj4vbu45VqYE2ZPHD4m?=
 =?us-ascii?Q?2YK5olEdx4ZjUDzob6megEOJi0otPvJULK6pHOmfPPnUBOm/5WAoCYcKEJOn?=
 =?us-ascii?Q?nhk0i8XyzQAjVAh7sBlcw31U2eDMYkohCWYDlCZkB64a5zNGoEB7gjw3Fz2J?=
 =?us-ascii?Q?8RhZIEaRyhf4is2HfmAANLrw6Fpv2OjNl5iOZm9T96SUtC3+5kaH1jyraWoS?=
 =?us-ascii?Q?8ry9hR5xY1bXkUqw76zFoe3tJiU4Wx0YSxcI9s9YL7AwoA4RJJc1Fsg51Nyu?=
 =?us-ascii?Q?xLwFHhHPyU1bVTi1THJwoiTo0D7SeDjmHNBYhaxtH32jib7+Jo1kOkxsRf5l?=
 =?us-ascii?Q?vzY9vmwxgFqiX830AYdWk/1D6KryGw/FZeoqqUJf65jnUJdeXsAOIL0ywJ2z?=
 =?us-ascii?Q?eFqC1lrVNUaBN8BWajlYURYRwqUjvgBS/G0fVHBijKw227gda8k/LYQtxbp5?=
 =?us-ascii?Q?FuwNYPOjFt81Lrivg9iWJ9HPHgo1nS4JTNtmkPbCuFqsW7wodYVGpag9kbso?=
 =?us-ascii?Q?7RiMVVUOPjN8lkn10C/aoKiCniIXgMUOB9iVIxY9Qq540GYdzRnAPWj6Tit3?=
 =?us-ascii?Q?w9ElSxTtaG5EEYD8IqYO2GDOQJGR3k3O7iqOXqHw9heTfwvKpIkB2MWqEAo7?=
 =?us-ascii?Q?0kOt5lWjMdD5gvilU6VRkh9xmmJRO84dxD0R+GzmLGqoQ8VBJ6lungQfAfvn?=
 =?us-ascii?Q?laSZALh9N9W2TcoOxXbHpXYZFKenTe8yWsanhpue1WhCCbs2zfgx3q5sLG7E?=
 =?us-ascii?Q?wFkBXO1h7IQ1BsOI9G82DGvxDjtcLqvlOQjUZY2o7XffT0j/CT5vFYNPE7XW?=
 =?us-ascii?Q?erCVi36M80RYrdM2fu4vLCAPlQYDWABwhrKJPHXCCzjtRprSdAzPaKXmnsnS?=
 =?us-ascii?Q?inu12T2GNtWqb5UNRd6PgYkLWVi8voM5/NK1xxbq/+MHZVSHWvoDAKJrXT92?=
 =?us-ascii?Q?fT1PodUbyYR6neONAyA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96054873-7d2e-4191-11b5-08dcaa634dbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:31:06.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NJInDu8yqDIhJrGB9/pFI3ZLEetMgEiyD3S7jZUmRz8bgJiSkJpt2JPVh01Set9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173

On Thu, Jul 18, 2024 at 02:32:26PM -0700, Dave Jiang wrote:

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 9f0fe698414d..0f6ec85ef9c4 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -13,6 +13,8 @@
>  
>  static DECLARE_RWSEM(cxl_memdev_rwsem);
>  
> +#define CXL_ADEV_NAME "fwctl-cxl"
> +

This should be in a header?

> @@ -1056,11 +1059,27 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  	if (rc)
>  		goto err;
>  
> +	adev = &cxlds->cxl_mbox.adev;
> +	adev->id = cxlmd->id;
> +	adev->name = CXL_ADEV_NAME;
> +	adev->dev.parent = dev;

It goes there

> +static const struct auxiliary_device_id cxlctl_id_table[] = {
> +	{ .name = "CXL.fwctl", },
> +	{},

But then how does this match work? Shouldn't it be CXL_ADEV_NAME ?

Jason
