Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E865246BD5
	for <linux-cxl@vger.kernel.org>; Tue, 25 Aug 2026 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787628343; cv=fail; b=mQ9lkgWcONTkUd7gnuYHZ1mLUQ1O8I4nhTKwJPiZoauUmq2imILNd1GeMYVlAIC4tHK8DyG8OBGl1P5PhF3klsEpBVqTMpjE9KbQSGPFQtBgnRogGq5bP7GTniuDC9i9fp9LzL++ZROnovO6yGgOMefOuiGo/E5SSi030Ak/Bhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787628343; c=relaxed/simple;
	bh=4jDGzkGI7gX1342RlTHNvbEwzfmDq4SX1bhMf/qq6Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nKLWJunfDplO9sqRm4i0TMalCUHZQdEXIYHhJ/1ERy8Ho/Bi4QneZr3i9Icotkkzr85zBzlgw16kJBseXTQdrHP9tPS9L6y31qUv7vEDpFonUUFwF6tXaKDRXxPe4/kOWLqIRd7gW7xFudZk0k9qkaOfE4KDkHyNZ8sjQEJB8Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MtKTI+ym; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MtKTI+ym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJXtPSl58g8PJIAac+AxeuqyT8s+AqmiPQNGGUx3V2wCDSUZb8SN4PNZs5tMZCsz+AbmLbjMzXs1zz84oC6iIXTvSmdQW01/16tvNy/iXJfZIBFtJY/VC+xH8djKXBrR31NNKKLXd64R0SewK6fV/dv/cmmwHEK/p4o2baIJFNf71xyUICUuHoGL0r9+OvzNeSz0qTgLLB5PGTchoclxIBdWHPZ2+5A73NPXpOgbwBy+Ienx6daWN5kM5yyt/5mmlmZ99aorlmF+g+rUEnYU8UpRNYZRbe1IN+EaYg1TA10BqdOXZd7WSIZKClKStQbEJ3wnM1YkZo84gB/CWoeBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWI0A1ny8Z8aR6fA9zqj5ylnMay2j5V5pwgsmHfC7vE=;
 b=GmQZ3Ge863xtv6oNEIcaBnBZiLFpgaP8LNE3rlbnhhIiZJVLA6FmXRRbNUKoZZ5CbyM5JP1lel8aQ1gvAkI7QhG3wxBJAguHfHCLJ+t0tB5Wh8Mv923ia1pTMn9WbBvKz5K3O5zASGqskeBCWfdCDoal0bIsg7edzs4nUj7LIp7KB/9+fj7OOTeRiw/xODaco52UN4k3EBAXlyBz8xpNfZFXynypPxgCp69Z1MbiE52GnpmA6cADY2vavma+/ARDDN85u+KmwAzKh9L2s7ETKobHUOoAw+7JAmI95JW67xHgsvvJzwMcyur/zXxeplYpWt/zqNSCSPWbm/qi8OgWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWI0A1ny8Z8aR6fA9zqj5ylnMay2j5V5pwgsmHfC7vE=;
 b=MtKTI+ym9fjBwK9g6hH/EWtisSncvpXse9AXMgO7pHSKaCwh/YbLSWN6VCWqxoxBcqPwfjIgDdiLHJ2Hq8Jx4OZ36peN70swZQIKyu+N90LEm76N3J0RxmorChI0JxRAM4XpwLgGqarfqWwdhDLK/WfK4VObWsYGEJH+p8gnXjebW8X3yKHsWvc11b1QDt+HBSEnBF5hCsLQ30OpUSAgMKcuBxeAj6nNyrlGFvJgmWNLjaXqNsGxwzgWVhiDpZ88cqKUXiSTLEt/aITS3nnsWt5LzXWUqf9NxOLaIYl7NZLtkGvBWBQVzLyo0iZe7MQ2Y9bca8CXS2xSxKe9R6LRZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 03:25:37 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::8f:c340:8bac:c36d]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::8f:c340:8bac:c36d%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 03:25:36 +0000
Date: Tue, 25 Aug 2026 11:25:29 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/region: Guard against a missing peer mapping
Message-ID: <ao0K-w43RAfCjRSE@MWDK4CY14F>
References: <20260821222515.2675707-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821222515.2675707-1-alison.schofield@intel.com>
X-ClientProxiedBy: JH0PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:990:56::7) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2376:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b791668-158c-4083-f487-08df025886f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S6bKJZQNdINjv/2X1Lqubt1AQOhZn4BF9LIEi3SyAWoBVYMXwqYeUBedpUBXlVd6Cma540JsWCgin7UKv7IJtuiCNIzf88Xh4OCeFdHNjhbx+epEzOzj4/zrIy2a4bvPx0gWBZT1R66weYxmLPQ1DDya78GRvHOza929akikXic9dQagXq86y4Oiic2u4p0CFVOmlR9yMzaSUJPfWJD1izttpCiB2dKDDTUNtU6e2SFLbhD2nU1o1XnwwNjtut9CddIamHFZe56FFrUsDFJO6UURl10XHTqfB9ZdztKMHI8OYVg1bYRJiwLJs6zfRARSU/rQ5lgEeB1aQA/YklAhomrJMkwsyl+JPO8tLmkvIpAqFTo+jRpn8j56pEa9qusZXV95lbDQoFhzLWh2LDIYXaUf/+ZH4KFf7y1m7Ar4SKieBXJvxICQ2xzW1QjbZzlu4PK9qxWM9Rfi1EJh9H6VmMWQQ7lOLIab6FJH1lxqnGLHXKzEGypW+IqfeVtzdATWMDcFn+tLwAt0XSz6b7iTKnDY7XqVkPOhZPfnGXjmilfKZa1/VCjFI3/d7dR3HKuweUoeYCgLndLmtc3d8LeFlgZvkTyvptGSBo6VQ73kuNKa+et15XmwIgDt+dEjZNbLr/y5TjSu7EeurYUC1mvcb47Hprs+yuZic6Y7cupnCmc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2376.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cXmo0k6QU2jRnhjBAoI5ZkSvJw0u0rerFSJoZWDizAPiqBLDvzF6StNIEM21?=
 =?us-ascii?Q?AsE+VE6K4aT1j0bjZRn+BNs5Yp9fE+Xkq1tF5cD7J9n1U2ftz2vyvYpavLmZ?=
 =?us-ascii?Q?iSettu8cGFd6MG6Z8t1XoVA1SHO7SgC2HKh06+x9ZdoMJZ6lZo+BnlC0o67a?=
 =?us-ascii?Q?SMpg+EpS/G8wptyCubB7uWoFQnxudDB3qhDvq8DfrhZeytWaDBCdgHk5/zef?=
 =?us-ascii?Q?VJxeWykNpi9i60XclLvMaL1QePRD0Ud/ZxM9qLQzToehDy22w6bCemu+c8vP?=
 =?us-ascii?Q?EBQvNwTbjAVl81o7iQn0y9l7QTP4hzcU1g01PvBHiVnsfMLTwXfUfwT3onCI?=
 =?us-ascii?Q?z0BD49HMYi700wQHX8Z8PjvKq/+KfTxKjslQho/9anjfhFUf5VsL6t7cpqaV?=
 =?us-ascii?Q?vnPKsCiHHw4Pw1VjDqL03QC57mEHBY35YyXZigw59/kU1F5HlGvxDYhKok6m?=
 =?us-ascii?Q?+2lpWVYipHZdf6pioZgWmv/Udp17B3u5ofZkOic5b6N6YGqsCODepWU4HjlJ?=
 =?us-ascii?Q?HI1HXpfKllJn/4n9O/8FZRg0x7XgL/B+NLF+FrbFALK13Fnkl8GCxgh1wWim?=
 =?us-ascii?Q?w+3dPiVEVs+kLIFyMnrNwL/0eHO3gTgVA5kiiWnfKYil89OcVT38ExmVKAqe?=
 =?us-ascii?Q?R1Jz9lUNtgrp5MPKdmhQM/sMNdcuucR9Q3xrZkXlOOhXBNpftu+W9ri9K2X3?=
 =?us-ascii?Q?kFO+0k2zFDlFBgQBsdFJGv/ekG0Zzqi6AsaTnf34+RX7DGX9N4vJwTxMCe/7?=
 =?us-ascii?Q?4Vh+bt6aEx3/9mKOojBekUGJyu3lH2IczmYAzmJWQzzKSoTEm/Xk80bdjgDh?=
 =?us-ascii?Q?oX48tRn9KVeODgGTjHx4VBz9bT0jjTYtloWFLNrLsXBiqfhoh8eOlb+EDmeK?=
 =?us-ascii?Q?6MPek5Wrmh/nFXDi1rojEKNZiv55t7cOfzqzndV1aafdORR+Eq+NMpbH8ehp?=
 =?us-ascii?Q?++vzOKIuJf+SZLYk8UZKU87qzrjfNl4HF9vN1abmTx+18x76pTuAPgczZ8MH?=
 =?us-ascii?Q?Qdk41PqJJStsqa45E/QciU867q7HufEIT1M3jWTv8twy0QM3C3TPFlJOeQTx?=
 =?us-ascii?Q?amvlbRfv7jRAkE2f73S9WVjm7e0RO+cJchZ9IYZ4O8k1+PfpJWeFaIv/x19t?=
 =?us-ascii?Q?9amt0UUZR0or+ruwOqYIUNLEgpj22tRycr/QBBc9prFS4Xj5t3h5H0nDKCRn?=
 =?us-ascii?Q?sD0A7DPzD7uv5RYp858w4+TZwNiIALDDZJhgMODceo3opmjxillNor7LDfJj?=
 =?us-ascii?Q?YJw5kPbnfN7puAdLrew3/yz//o68/DJXuGnsA4D0/l/XQE94CAM5wROi/ykU?=
 =?us-ascii?Q?C8+vwmsMflPuok0ob+31lIjsE37QOsn7De5xNbvaisar5sgYepNsjePOJQwa?=
 =?us-ascii?Q?hqy/Sv6plC6pRaOL9LYO7vRx8B2ZEfuQazxEegxNef4Oy5z5vq9xuJJMrN25?=
 =?us-ascii?Q?2Y1NlyfoHs6oSyt2BGY6nBha2iyC6+W/9OK/SwTxmT6xhIHGUbweoGTHxiMv?=
 =?us-ascii?Q?nlh0HuUj1fFuy+t5vD56gO28fPVsDAhXNHy2NtFVts4+fmmv78Vv/j2WjgI3?=
 =?us-ascii?Q?VERNcIre6nefvWZ98B8C+I7wMEo8paSrVOLZwGF6GFBNilGFeAA2NHRi56ZL?=
 =?us-ascii?Q?Kgm9tK8yqqrLantrWjC1ZrthFbCfwvKz2FHuZBKtzPdCqS6bfi2oMNYl3BuK?=
 =?us-ascii?Q?zDjFbWAcAMGqJ82XR+1Mgdp+H1Mj7QlHvDvd/FmkOKtgffXvQ6gGpq3rnCNO?=
 =?us-ascii?Q?1csP3Z5ZoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b791668-158c-4083-f487-08df025886f4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2376.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 03:25:36.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTbAJlzqN1zt40UBWfe8EWV7ZC+6knO/nmD8cpXccHwmrtCZY08/xrREijjBAP2wHLBtGKJCxum/O51RxZeGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025

On Fri, Aug 21, 2026 at 03:25:14PM +0800, Alison Schofield wrote:
> When two endpoints share a dport, both must be mapped by the port.
> 
> sashiko-bot reports that a missing peer mapping could result in a NULL
> pointer dereference during region creation.
> 
> No caller can reach this today. Guard it anyway so a future violation
> of the mapping requirement fails region creation rather than causing
> an oops.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/cover.1787255388.git.alison.schofield%40intel.com?part=3
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..75b8092e6dc2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1367,7 +1367,8 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	/*
>  	 * If this position wants to share a dport with the last endpoint mapped
>  	 * then that endpoint, at index 'position - distance', must also be
> -	 * mapped by this dport.
> +	 * mapped by this dport. An endpoint that this port does not map at all
> +	 * fails that requirement.
>  	 */
>  	if (pos < distance) {
>  		dev_dbg(&cxlr->dev, "%s:%s: cannot host %s:%s at %d\n",
> @@ -1378,7 +1379,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	cxled_peer = p->targets[pos - distance];
>  	cxlmd_peer = cxled_to_memdev(cxled_peer);
>  	ep_peer = cxl_ep_load(port, cxlmd_peer);
> -	if (ep->dport != ep_peer->dport) {
> +	if (!ep_peer || ep->dport != ep_peer->dport) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s: %s:%s pos %d mismatched peer %s:%s\n",
>  			dev_name(port->uport_dev), dev_name(&port->dev),
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.37.3
> 
>

LGTM.

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng. 
