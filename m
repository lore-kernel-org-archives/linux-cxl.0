Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D726F2BE;
	Mon,  3 Aug 2026 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737977; cv=fail; b=Qcvc6hxVYIiN9J6KfxeE0i8xwrOqCaymqLYgx2yxcNlq2EKC7jxKr9YxsewoENLC3qGcwbbblDE09JjsGiY+9tw0v7E0vlHoaVopChfYXlKPXMm7uUVZ5pbTNqVahLg8o276vuCQZiAy5JDUuU7eAaUR0RcJjmGaeEdgjGGzzwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737977; c=relaxed/simple;
	bh=i/JxqBBloXXYKj/Nh34qcFijJouS3CSwfGbYo9glcwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h3+mJhRysaPVUKyi8ktCzuaqQBXC00J/amXh6pvEwjso3V+16rgrhIVVVwyODrscEn9YDU6bXxZ8O60r8pnzPWFl6OAdmcX/yHtn1yqsvTCEj9nEFNx4cPSSfoAulcERcieTGrr3HxLKfJ8YnGR3MYhIMpb1JMG0GTGwjX3BsoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mDPhqkoh; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mDPhqkoh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyP7vILvF9HHe2t/wcGbcuyGSRnC1/dLGOLweXs4rzmYzt4/psdIqHsT7XZABzalt8vPX3yx6d8/+MqBo3T5gvqzeA2hWJXktpD5IRm9Sxgc+hdTKH0bdeuRml7oB48QaMPRyBc1P1OzFr0I/TOWUlCPxn61v6B59N/dWNM/pU+LusMk3G4O3g5Fgi/XbNFHnJZkwW5U5alYS3QXxwUmSQO/hJ5ElFajsrTmcY0VRYjaVtUWNjHa3gu2WdRXkQneakIoMFlB7VoM/noBab/hDEgJxI3b6F+Bs9gngmDi0TxaA/jhOPPRgqzWZaHXT70AXdZtEPcdPp6Bl7cntTsqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcy1KjAv4nKOimr14d7n44kQ5buxvUM96Z8522z5208=;
 b=Z2AZH6KXnpaagzPlwoTKohWbs8Dgdb8Vb6MPU4F6mn+FJoy0oMrjJ+HEmDdiFfZl4MIWaBiAlnNBwQThsKMRAn4uRERe4IvzUt0GTRhxak9Eo4sP6x/fr2tR8pjtLyhT0m4hGAVXrZrSTkE48A1fw6Z2kZb8BGRjyfrdxGpf+41LjoWYVu0JsecxYxUKK66t4E/vHi8U95dw/pfnIl5MmjfYHbN1XrghlliXqkd2StQgDVOZ+i3iiz1N/DyWFMEywBBpgcxsZOa6KudIp+T4M8NqfywA5e7AWNnjqkJK0/BA3373WRr0DQL5a+Ua3aVXe+QIc/Z48jziHNlDxun7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcy1KjAv4nKOimr14d7n44kQ5buxvUM96Z8522z5208=;
 b=mDPhqkohUSYqk/EL8tC5iWinL+9wQ0jdTlQIQ00Mznj6RpAdAcIOH5B1GObpq1qAcL51GsH0zRDgskbpZsVyzcDvHQZSPPAgI8FektykBLZQZwOln/BgMJwAcoxU1B0aF9Miemtoj5kAaK88Yx5TsFjs+B724iq1MUwySClWqUEgh/Uf297cMkOiEDcqck3MM4KEhYCKYQZ6O3IQWUlDwxCEg9YatTtEV/44XlrLSd86obDfiLKD67t/CRiTJCHGkDXWxZj2WDpJeeZqCKKpxXyNuHPkSqe7ozdpGNR9uf9ItVPUojfKTlLRXUIAN3xj/PhaUTRHbvWxj8JvmPxV8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 06:19:33 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 06:19:33 +0000
Date: Mon, 3 Aug 2026 14:19:27 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	Robert Richter <rrichter@amd.com>, Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl: Use %pe to print error pointers
Message-ID: <anAyw-5TU7m23W4k@MWDK4CY14F>
References: <20260802112029.28767-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802112029.28767-1-shaikhkamal2012@gmail.com>
X-ClientProxiedBy: TPYP295CA0057.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::8)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: c4940331-7d9f-4483-dd56-08def1272e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oHjhULJOqiN1TuE9I9mjAUWZ4/lghGw03xukja+J5/pKrJZcgpIXLmOxDCS25kICVqqjr9v9RiJyVsC2NF4lIQESU1TNZG+U69AE6IjwKYJ+Bg43TeZb5mmoflf3LULw/l7/nfCjs056GHpznkH49fu7680raX0ZOL2FPTE4evfng6xitIocagMD00BYdpVPcaEe8bnO/nJVfPF4yvURO45iseRK7kDndA57PfaQXRTJDeaNTD6twzqjrASBrQPByt4d5sE25cieYqyIFhH5pYJhUwBWA13bV/xSqALJD3FFa4FG71q4SAg0sBE+NQcZC2EdhZRMvDFD/fEIG/KnxVmElME/vEZmgkcsaPDmtukZzNLb6LUm4WFAXkBmbgBdCrMLenyrsE2jOYzaqEuCShj9jVdUV+e8JSkEKtKwB5EVU39iI8CkCSIZ2Wf+svoKIvbUvWutyl9rXW3G/Wy1W6pX/wa5kGT8Ln2qsrLaJPwwR7v8Xiohtr/lpAIytpYySXnZJ0c4/pOEDSQpGTGG1Mf3/AUHFXbvVDxpsCGxJG29OeZPiyj9NRvNQP+Myb3e3VK/FJ1DJ2BWgCBX+eUPpFzMi/aa+lwI8/VAS5iNp8FUVIe0y0HWTRu4n0vlZ742MJ1RIC6LlVINdq9DVIQ2Nghf3gWqsE0E6DKxmkxwyTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KycSYdXdL1sFTxYnHiAFNBcG+OUP2XtmSBy7ynN2m9HTi2m7WhZvdSYK2Dz3?=
 =?us-ascii?Q?Z+X5L3IzFyz8WBrZV2NgaOgevUUuESKe2afT/imTOGgjWpc/alxT06dC3OsF?=
 =?us-ascii?Q?HoUInRFbwDBeutBjf4YX2Yco0XJasYH9tkVpU7SAHSrT44rApXO02URAY+Ng?=
 =?us-ascii?Q?S7IQwTgf/AYlyLgb7NrGfWKGKU0VEWna7i+vz3gH5RkaummA1peRhQUx6FTr?=
 =?us-ascii?Q?kF/PgwTuEVcZCpiQS9VgbY1+f1brKdz2w94pQSn0sMnFm+QKC27qeRJfOOlQ?=
 =?us-ascii?Q?u7pAa3iE2QhSSzvLSpoeE4prStTavAxGBFO501UTT/bgGADr/itJ5m/K2Oqp?=
 =?us-ascii?Q?h6LAGKWaEwoCj85WnF9+N/rqHsEcrF0xxfgOfcml2g7XRvpXRcufPcF6DAVr?=
 =?us-ascii?Q?hd+ju/NuWi3VVTrArWzKzod719tHRwhWS64TxeUJcMWYQgo0bV8GR04o3TTa?=
 =?us-ascii?Q?rcUyZukKkyZuxEADFB7eVrFRWbH6Hgv1Uy4chqeLvtvGhOvkDoh8dfm1NI4M?=
 =?us-ascii?Q?JKocWL5QJ5YvaDfe4JT4CQ3cO+xlckW78vlMN6+K8lr/rxuFDcx6JoAbdyfx?=
 =?us-ascii?Q?oFHdcy3svcCefJIOhr7LFpzi6xlLJNHakwG1yVTOtVDnVu8g27YUon6Ly09X?=
 =?us-ascii?Q?jc55vFt0RZyS/swAUBaAtpNgH6WIhdlL0nu9fDF626MflDDl3ZSHyQFW/Vnn?=
 =?us-ascii?Q?CIM3ShkEQTXyrH6ZM1LakrhwDBeb333PLPu+g5owDMskeQam1cspTcxdCjq7?=
 =?us-ascii?Q?JJszmAPVpRmmcLBiSRQ4OZmUbNTHdAm3+3uMtvFtW3wXzGcZWlUH8+yRskcW?=
 =?us-ascii?Q?ijAYFhokxqUZIpSyQds6Iv2v3TY9nLFzSaqzB/V9cJfbZM7cSuBciISJ/cIS?=
 =?us-ascii?Q?P5lCUo7eX6p2Sxf9ikijEdfIm5Z1ZqKRaCb6/Fr5vWvt6X1FRz7JvBAMrGyY?=
 =?us-ascii?Q?SJVbjhAfabg4y8VwmI7aKCj8C9B02fJorpb1rvRgXNN3LUakutwrziLffqVk?=
 =?us-ascii?Q?U12uKkBAFT9sNVaWqHuwwaDf7kly2xG/FKKRo6mb4Qk00gCQWB8FHTtvlBlv?=
 =?us-ascii?Q?1Vo7A1d5xB/TbWyfDj2MIKuSNGe6ZaK95KDInVX8Sk8TnCAOyDCy02LCFu1Z?=
 =?us-ascii?Q?Y6lex6oDLkaY6N3JKrwupaAIkBSfs/PvNoX4vNxKxkGUO2gNQoaXT37QEriZ?=
 =?us-ascii?Q?iXmWMpXxMbgwG4/4bO9BIhACchyiqhbGEFUxifmnc+5ttvlNm6uPrQkbTERG?=
 =?us-ascii?Q?NaXWTu/KO4sgbdl/AeY1Rc0MjGqsqUmEfpogsk68CwVWWpotAs7CDtB0Enkj?=
 =?us-ascii?Q?PSrwiLnGjWG1mt4PO2sAIk7gnqndeWDIA4SSo9xOlu4ww2kQFHYyoiPLvCzX?=
 =?us-ascii?Q?hMrVRFlbNgvD2j/Jw6c0l2/EtZjEyDvRu8HS3WCLHsmh6fHfTDDV/vo3zklY?=
 =?us-ascii?Q?te0FkgkDbfCNyg+jdpzWKie+P7ceIYbRDhjtSTDl7WdM0gKr6g7eh1f3zruV?=
 =?us-ascii?Q?E6WGKGD8Av7l9SEgYwT1iEYxkBCqiwPDd5jvG7klZL5ZqPJGIWPNeanKLHzK?=
 =?us-ascii?Q?Ua6l+ZUIxCzwZU+kBw8mU6U2GASve5+lcxj8viplT7lyLD+qL+pa6U1uge8f?=
 =?us-ascii?Q?WF3+mX/x1WCxTr6PNEnGzTBAEgTx5vuMlX4mwBgnjfYUCrYHE7o+y2r1yTeE?=
 =?us-ascii?Q?cq3jgvrejM4TyU1X7tE/ypKsh2eBQQRlj6TzSRllaQDBuZfr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4940331-7d9f-4483-dd56-08def1272e53
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 06:19:32.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucln2gSLHaPcSidzssVIGdgQO8Fj84fQmEQm8mBHg0wpFz8U525JLLsHzwToq4VQzdl97GZz864ny0papwGFWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644

On Sun, Aug 02, 2026 at 04:50:29PM +0800, Shaikh Kamaluddin wrote:
> Use the %pe printk format specifier to report error pointers directly
> instead of printing PTR_ERR() as a long value.  A failed dport addition
> then reports -EBUSY rather than -16, which is easier to follow when
> tracing port and region setup with dynamic debug enabled.
> 
> Convert the five affected sites in drivers/cxl/core/port.c and
> drivers/cxl/core/region.c.  PTR_ERR() uses in return statements are
> unaffected and left unchanged.
> 
> drivers/cxl was scanned in full; these are the only conversion
> candidates.
> 
> Found by: make coccicheck MODE=report M=drivers/cxl/
> No functional change intended.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>


> ---
> Compile tested only with cxl config on x86.
> 
> v2:
>  - Reword commit message: lead with the code improvement, note coccinelle
>    only as the tool used to locate the sites (Alison)
>  - Capitalise subject per CXL convention (Alison)
>  - Note that drivers/cxl was scanned in full and these are the only
>    candidates (Alison)
>  - Clarify that the patch is compile tested only
>  - No code changes
> Link to v1: https://lore.kernel.org/linux-cxl/20260801101217.12778-1-shaikhkamal2012@gmail.com/
> 
>  drivers/cxl/core/port.c   | 13 ++++++-------
>  drivers/cxl/core/region.c |  8 ++++----
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f4035..c9875e6af9f6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -932,11 +932,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  
>  	parent_port = parent_dport ? parent_dport->port : NULL;
>  	if (IS_ERR(port)) {
> -		dev_dbg(uport_dev, "Failed to add%s%s%s: %ld\n",
> +		dev_dbg(uport_dev, "Failed to add%s%s%s: %pe\n",
>  			parent_port ? " port to " : "",
>  			parent_port ? dev_name(&parent_port->dev) : "",
> -			parent_port ? "" : " root port",
> -			PTR_ERR(port));
> +			parent_port ? "" : " root port", port);
>  	} else {
>  		dev_dbg(uport_dev, "%s added%s%s%s\n",
>  			dev_name(&port->dev),
> @@ -1271,8 +1270,8 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
>  				     component_reg_phys, CXL_RESOURCE_NONE);
>  	if (IS_ERR(dport)) {
> -		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
> -			dev_name(&port->dev), PTR_ERR(dport));
> +		dev_dbg(dport_dev, "failed to add dport to %s: %pe\n",
> +			dev_name(&port->dev), dport);
>  	} else {
>  		dev_dbg(dport_dev, "dport added to %s\n",
>  			dev_name(&port->dev));
> @@ -1305,8 +1304,8 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
>  				     CXL_RESOURCE_NONE, rcrb);
>  	if (IS_ERR(dport)) {
> -		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
> -			dev_name(&port->dev), PTR_ERR(dport));
> +		dev_dbg(dport_dev, "failed to add RCH dport to %s: %pe\n",
> +			dev_name(&port->dev), dport);
>  	} else {
>  		dev_dbg(dport_dev, "RCH dport added to %s\n",
>  			dev_name(&port->dev));
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..894df68a6074 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -682,8 +682,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  				    dev_name(&cxlr->dev));
>  	if (IS_ERR(res)) {
>  		dev_dbg(&cxlr->dev,
> -			"HPA allocation error (%ld) for size:%pap in %s %pr\n",
> -			PTR_ERR(res), &size, cxlrd->res->name, cxlrd->res);
> +			"HPA allocation error (%pe) for size:%pap in %s %pr\n",
> +			res, &size, cxlrd->res->name, cxlrd->res);
>  		return PTR_ERR(res);
>  	}
>  
> @@ -3773,9 +3773,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	if (IS_ERR(cxlr)) {
>  		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> +			"%s:%s: %s failed assign region: %pe\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			__func__, PTR_ERR(cxlr));
> +			__func__, cxlr);
>  		return cxlr;
>  	}
>  
> 
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> -- 
> 2.43.0
> 
> 
