Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604093955F0
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522666; cv=fail; b=iA/ojwRwCiKm4g6xIlGdqaHmHt1xe6l9EsNel5gl9QK6E5rsCOQnO+/lwkopAVGld8hNGrFmNRy9G5hVEMFk775IVV4a1BXwhDSQGOS8ljKHMFhpNXlSaqIFnOsxJuhTcCyRPyqiSPc/jqXoyX+C2dDzG1yh+xQU/SBO3APMJlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522666; c=relaxed/simple;
	bh=pDfE1GINT4jt4lJbs+DemULBrNvSChGNOgVbFW6L60E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L4F5zopdokXsD2GLIXOrSVR4XgDYeTTs9KQAzU5iK7N75mZWu5BIxdtF96Hn7/R0zonL/ZhOm6BfYbjVyQzAq8EXZ3rc8HQ3mQUwVVXiRTMLj4FE7Ygkxgxfan/G40oicUOqgivNEwzbzBR01nGQMk7iBI9+E3gpG8z1pZORe00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WthKaQkw; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WthKaQkw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNxNMR4JPpirVGNlQm90uTfAI1GNNwEq8iNrAEhfFhQ44c5kv+P1iXQyNLemutQKvQCKfiUNjUa25UdTfaDRXZC/IJmJt3qcqe3wrKXRhw2DNn6sR6jKSXGPZDbWVGgLPL6nyBTKah0POMB2MnesaSoVeiMiv1fkuSgTxJkh07QL+onDXEnTSNhSzfRIYn8Q8nFhuOZDJNp7INMist92Mmy/N6tjh0sNXaTXYKGZ2BYUXC1G69pILhy33Sn4EXQpCaPhdxmkjIFxtQF6gzmpiYGjre8YtKvwB4TtmlG0S564qcYuCtYvrL7vTJ/ZGHBmDf9EZOGZqg9uTW9iGA1T4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNJCfkL+WTORP2qofnt1mCXjWjRpv2BtyhC8oOfvciE=;
 b=Sxn8YrF1z6V8Z99LFO+A4lYyBI3Opf67dn8oDRJaxzFNevtaCZ4jRdDxXhLpirtRg/kuu/5ALem7De3k4yjfCda+pUHZQxl/4lfeJ+DLL3EmUzI5SrHm3SpNoxR31xPsvmjJQ1cv4ZtHVjd7L2jzT2ziLXH2mx0Lklz7bdZ9BnIv4bI49PgQi3G6dC0sg1ZKsUylbKU3SeHZLkKOk5Egn6ANXQJfW4WvOQhJC7INsoj2TU2xlpjxW2pJ9QcJ4Ew++A6QqlA2RP1BP3SNWr/uHbDI8LJ4f/iMcm1WZqwWNZdJkGfFASpDKokM7111l4jzodSMXYQZ6qUIrETFJ5SFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNJCfkL+WTORP2qofnt1mCXjWjRpv2BtyhC8oOfvciE=;
 b=WthKaQkwTyK1f717ZSam6+2mcryHdpKZIc6uIc/5DQCyeNhlisohjWQU2GVRITUxIUfhMdYCryzvYEvg3rxxO25YWXurkLSUOsPQOAduq8j0Csou/cQJlinAs1euSxa8c2NhJxbtdUyShhZf4uODJEZ5LbSXTfyZpqobxihVRvr7zJzqqdRLjRP4kx5RsUBLeQ3nYxgDRPD8NHbnMz2pMSIafxmR5AXDE5AHS0U1oEcS07E2XXXA2D2tLcqZpW2pZ+ArFoqIbnduELTcHFPFVcUosBnddP7c+Td1tXfwtLvk8ohyLmPnyGvBVE+WvxClJ3FEI52xCCOE7Ul0Ew0emw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:17:40 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 08:17:40 +0000
Date: Wed, 12 Aug 2026 16:17:34 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/cdat: Fix uninitialized stack use in endpoint
 bandwidth gathering
Message-ID: <anwrGdUjKDCjr4He@MWDK4CY14F>
References: <20260812060912.54932-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812060912.54932-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: e7016947-4148-4da7-8892-08def84a2d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|6133799003|22082099003|18002099003|11063799006|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	pPngX7+yzwZov1LySN6DfbBdXxyD2Bg7+m4qtBXDxDrjThyhLTGpZv5V7IMca/LF+r2DXDGNS2rdaYgPmLoR7GJ7ec8WczcWt7LkdUUbHz0skGYlZlQbFyL/64hMp3dmxl8nYm4U3qnTo6gW6IocEuX0NKW4cXJb2RwuC4L8oT3yvLT7FMhTJ1/qyCS/uCpf+3jNI3d4FgEBMIpm/vgDyo/zj4gMFrH9MSDGAKDFmsuq3bJuXdfRzQ+uUs5nGiEkf6GIcNwqfjbzAjAEAgFXHT+treV0w/bnKvnb5ibs9QZXjr8ocCKprAv5Gxx85AkDILtpJMNEAXrz6aJOGp4WvkD6cEgVSj+dJMGiqyBldH2MbafMdIoW9XcSPSVqd8HmDsJPPBV8Os1pqOmHv0NHXrs3uGCJYRHxi3boV9Ct7iEc/y40EeUFGBvXbxzFbuSmZde+x1+i16YNzrRowWO04vH5R7FtMhgC1pTsRoR1MYcMVQIDcNaePel5qK27K0aXp95YDq7AQZO6bkUGedPEq8Hj9OCRZrMhTJM+0WQgxCsuG0sa65/QY5TCXVsmBLDQJB5CocvRZ2Qlfin7yKNkxz67Dfc8PgwSoCfkuxGtpkDNmIP1JBgEC8xBq5zv0K8OAHKlNAZWLH7vH2cmt8Y0vQleZLskYTbiikmWfQhbCVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?to3oUHed4fhkqw5BF0hd7eiWCI/UG4wpAFc3HtRhqSn9DLz6nall0D8w4P7Y?=
 =?us-ascii?Q?bEmmWpM3pkPaDS9zmlozc76C9L0SmlcItfVLoNKTOYlLIOiQwj27ctGh5Dw5?=
 =?us-ascii?Q?lV9ISqJysIfinPUW9g+wxZ+kjMOH7A62aJiuItuf825USv/3m8nywjo8T2rG?=
 =?us-ascii?Q?UUt0U0yWOfJ634sAgpfUaHaed3b4ogZS3Y9+6T20OlhL6gHABlG81rRpSZpX?=
 =?us-ascii?Q?gdZIOU4kf+2vKPtQ8qDyhMrf99j6QWnaeHbOPdJAc+tj5vlWA28vnMEW5Yga?=
 =?us-ascii?Q?MKNfY+zad3moCjKXnpYi0YyvARPgdTaUlBKkhGhQpaKBVcZW+EDovidKPp/d?=
 =?us-ascii?Q?06+85S74JBzFDa+q6ehT1LUmyU3EDL/jqPj8ViGVDlwpoY9w76Sqxm0IQuOx?=
 =?us-ascii?Q?e9LSawtvJuffKyvAxcSziKNot44gUZJjWQICpFNCGOhMdyI3pYKEJciRzMt2?=
 =?us-ascii?Q?fOFAIC/F7ajCatr4bXcYuWQVtE2uu8FhdyZDOftSxrJ4mNuRfLY9gT/AvVG7?=
 =?us-ascii?Q?JsQF/OX8vI0+f9f4nWinyitTB+t5FuqEHHJJozwrbZ92qgYX4ceCmiayrP3k?=
 =?us-ascii?Q?JOjVELb2xUzRJtMY3htVk6F0inkTpFX2aHdamrcjLHFu198cDlvsiE8jDbWU?=
 =?us-ascii?Q?8avKh5SzslfHBW0TwJxExVQ+ZrftLHcx392yRQnjioTrTpYty93UdAkmJgWZ?=
 =?us-ascii?Q?hWoH5DipAIApPx9DzxRn018kNYmznKK/D6TtEfefQBpT6gfnYkWNawds1J8i?=
 =?us-ascii?Q?mcyT90rkw/Na+CEL/d20vc/7trOoR5BGmPXeGdbuNWFowVV84U/lzZhh/Qnl?=
 =?us-ascii?Q?+as5FUBpOBIzCKLeB99gZmgzMe78kWU6t3JOKNuLmYS61fMPf+m18emdnlFY?=
 =?us-ascii?Q?n4/fXSeNCHe7a3rTXYSOVsKgYNPd7u5thkapdgCON6aVu5AymO8isXWsVO4K?=
 =?us-ascii?Q?yxF6EXOoQxe1WBJ/MTs7FwrS2xfK5L6OlvAFRvxvl4/RcAIMN5w1kxnj9TNg?=
 =?us-ascii?Q?tVBDhjMSbnvzEPzI0MIGLSKcPWekHq59hy68d+Sm400sHBzsz11nmS1sSb7N?=
 =?us-ascii?Q?BISMNPaEmXW+DirnwMbZVr9BaSLy4rZeoshFqqnV+iNjXEGRq4lRPLNDiuzB?=
 =?us-ascii?Q?XYRFosWxPRCXGFd6ZT4DDoSTZwr0XL2L6U2XKx5JJo7ZOvfCvkltPZMeefBk?=
 =?us-ascii?Q?0+or0EPAipRTglt0pClGb6IdwPHXop4nvEvpn5Zlfn6Hv564Zj1GOvhG65NM?=
 =?us-ascii?Q?+PFOmVEALL4NSK2TVaqJO3LLJoWqsqn9Tnz/5LfWHrbMG16+W2PLR7A/+u+a?=
 =?us-ascii?Q?rRvIN4575VHQS1PajvyHJo3Wx5oo6q2NAMU4GAV//0Wny6Gi6hALzBgOHfaa?=
 =?us-ascii?Q?nPFmdM/LxMRW6fHXN86mSJh+HDgyn0pP+Hvs7tcLHkU3Dym5FMJkiN6VuOPc?=
 =?us-ascii?Q?Gbt1k4Ad7ktz+vaksQsiU8jqn1uNsQzq9X+2Gl8qBbYKloFmfrZmSPXrDZgU?=
 =?us-ascii?Q?Hy6NZJY+h5j2yew5LkF6J4SZgAznWy5uXH7o7tFFFA/wxBwW6ygNOJdzafeG?=
 =?us-ascii?Q?l0zw0LBPczB25sNz7pBkuC3FdZlV6WvobtDWWUCOfPyZOE86lu5A/EdZyTqs?=
 =?us-ascii?Q?SoPoXRMEc7HFbZzT6y1KjbLAB9mn1d/gIBtb1XprQdaBFpz0IiSQWo3WfOh2?=
 =?us-ascii?Q?wRworitat4q542ZIFABv0RIhlwe3JfiPZuUv3Ws22+4gXv6KpvIHJXuPYHwI?=
 =?us-ascii?Q?YcF0hLq35g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7016947-4148-4da7-8892-08def84a2d0c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:17:40.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFhSJKC9grnK3DgoSq0YrGnEkRfqxm+QrmqOd4GD0fFaZnRv80EKhF5X0g5EK2qsdv/IB37ZJC4jTt7TgXPQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663

On Wed, Aug 12, 2026 at 02:09:12PM +0800, Guixin Liu wrote:
> cxl_endpoint_gather_bandwidth() declares three access_coordinate arrays on
> the stack - pci_coord, sw_coord and ep_coord - without initializing them,
> and relies on its helpers to fill every member. None of them does.
> cxl_pci_get_bandwidth() and cxl_port_get_switch_dport_bandwidth() assign
> only read_bandwidth and write_bandwidth, and
> __cxl_coordinates_combine() assigns an output bandwidth only when both
> input bandwidths are non-zero. Every member a producer declines to set is
> read back as whatever was on the stack.
> 
> Both cases occur on real topologies. The latency members of pci_coord and
> sw_coord are never written, yet __cxl_coordinates_combine() sums them
> unconditionally, so the latency reads are undefined on every call. And a
> device whose CDAT DSLBIS reports no bandwidth for an access class leaves
> perf->cdat_coord zero for that class, which is exactly the condition that
> makes __cxl_coordinates_combine() skip the bandwidth assignment and leave
> the ep_coord entry untouched.
> 
> The ep_coord case escapes the function: cxl_bandwidth_add() accumulates it
> into the per-upstream-port aggregate that is published through the region's
> access coordinate sysfs attributes, so stack contents are reported to
> userspace as a bandwidth figure. The latency sums are discarded by
> cxl_bandwidth_add() rather than published, but they are still computed from
> uninitialized memory.
> 
> Zero initialize the three arrays. Zero is already the value this code uses
> for "not reported" - both the __cxl_coordinates_combine() guard and
> coordinates_valid() test for it - so a member no producer sets now reads
> back as unknown rather than as a plausible number.
> 
> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> This was patch 6/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
> 
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)
> 
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
> 
>  drivers/cxl/core/cdat.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..3c6a1537f89b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>  	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
>  	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
>  	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
> -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.43.7
> 
>

Code changes looks sane to me, but I'm curious what compiler did you use
and what level of optimization did you open ?
Normally compiler can figure what whether to init them on their own.

But perhaps since the arrays are passed to the helpers in other source
files, in this scenario the compiler can't initialize them reliably, not sure
about this.

Otherwise I have no issue.

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng.
