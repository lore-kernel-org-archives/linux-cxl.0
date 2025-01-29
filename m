Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE453A7;
	Wed, 29 Jan 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154894; cv=fail; b=bYElY0Sy4+xUpWLvH4/eh92AUZeMDy3QXV2zGgk/c4nrEC8lY0Sdo6OIJYVlen/l8T3TBTlJ/2CouaYbNVLTHBTEl+iP+T9C+FUudabRU6dCzSdwhA8gi35FdecBO4Falbs/Hh0ghKCq5ycBQROJapk5VzvWHmsAC4RbuXt2NLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154894; c=relaxed/simple;
	bh=g7dmOwbJibK1PfkxSumpoVVKz6xTvHw+9j/UCp12F9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sskGlWBVFA+Kh1deAN4o6T0jTWTkTUDQcrZd0RWWQsmeXvVSs10A++arGnCijrjQCuPz15N5fUEawjS21FAbxaLpTcNtT7aaQth8Pg0xfwhzLKuLRKplBNeVxF+Z4QGVKcyv43vKmiaGrF4joL/R5o39Ob3n2GUTWVdlIml3dmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ITJXhYEj; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ITJXhYEj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL90t+bHXLEBH0YLUSSUXGIGqD/4nfaA5bsjRyfH78FLw5+61cAb2uNy7/vD6H1u0w2HQa/VExDhw8ztwi7AvoHgjnureWw8C1Ttp7x7Vq7Kh4CX25dBAVPfVc6frma8QIr7n7oWsRjF8z0v9lVUttvrgbx06UlND3850Rucw/DMZn8w3XC3c7sSipAA5hm21Po63Dpr1dY3z7eRUSjVZ3jGmBpHmr+ssKzFJWzuaVwvoT0T6k4UNQadbUP13/F5zC4zlGzdGiXeKJJJhydLhnwpGPFOgVtxtyvLAN8BFK8bDPhb1aaZnxEoXOaHeYFTQ11lCqXNWPJcHgLaridopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyb43Y7bZ/15RGXOe4dtv6Re0eS7EHtJgmVTnUOdw44=;
 b=ylmJOizJse6hRyRi6Ih3+rn/o+GcNdm1zS8Rv8m0WdXU5M4iwL6CPOXvam1VK+tlDi8i1Uid17r1lINJ+v/rV+xWYbmoR65oAZsDpBQNBhZa8AFH1G4aGt0DTCSZu0aevYXImLTCzchwaTC96H75m8HgdNNxh6rVz8cZebtVzCne+1yZ6NypiOM9m0JRr06WY3m6LIcI0XuH107AWKoPP44yjadov1QkdTd8l9nUGJRRlTLr7xIl/GUijFUmP4ay4tRqFbTAGEUVX5CWdkagkuGAxIWAHptDSAdSWxf+fCMMv/hsC1SvsUgTtsCMDdfWIxg7oP4ryQVSI9oW41T0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyb43Y7bZ/15RGXOe4dtv6Re0eS7EHtJgmVTnUOdw44=;
 b=ITJXhYEjZM3VhBI6lNmMIemUR36jBEVqfXv+9ac9rVgg/+g/+5f+6BXP+RzwNn2khbDVSwhYffb0reArGCpSIx3f6lqaAX+STZJOdbBlnoda4E5WurhEsdONYqw7R2HnH6BrhWE+z+dnrznYtZaxH9WPPMMMaWatJ2dL3OMJqnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 12:48:09 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 12:48:09 +0000
Date: Wed, 29 Jan 2025 13:47:01 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 02/29] cxl/pci: Moving code in cxl_hdm_decode_init()
Message-ID: <Z5ojRRa8T5dva5Q9@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-3-rrichter@amd.com>
 <Z31T3xeUytKJGkWF@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z31T3xeUytKJGkWF@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b27b08-685d-405b-dc60-08dd40632eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xc/2sEn46/8z30X39ww6e87yUpHhhJRtRBALkaov108wS2McnrmZV+Fda1yG?=
 =?us-ascii?Q?HTnavckOhQ/GzmYlpdzIgu9wP+LiQ9rIPjLpaBr//9UH/b+EfhSJiQTMz4Zr?=
 =?us-ascii?Q?UcbadGHXTEWDgarS2XL99qyjWy8vTZy6Sp+0jMTF5FAscLLamLgi3jVDfEEo?=
 =?us-ascii?Q?/x2BIX6TlpzbKJ7no2dqadAruLvw+24b3iwPIaxL9YT0kSPcaBZwkXntbX1l?=
 =?us-ascii?Q?Hrk9B7NvGj8cPJeoWWC8fq1FFs3yGFbUVcMhKohqh+WWarVfhPAf5hDIcifb?=
 =?us-ascii?Q?0Iguce+ylWVJK2XbVCTTzA6m1l2b0d/VUEdMuKzkQCbShH1Q2tUsRhvdHxwv?=
 =?us-ascii?Q?chqjHoI+Ch/b0wz5vqbETmLDXlVoVbrBoi8nc7LGMAkuMkl76fibySGCOqmT?=
 =?us-ascii?Q?EJYR4ht1vBt+zTgSr2JRK2/TqHsUUeUV3X2kOchPQp2/2Rm1h1kqpPJOCu7W?=
 =?us-ascii?Q?QcuJ8Ea3zZzzUakwkudCQBiYM8brE+CCXRLcS7DvKJMF8E6dNJw7/3RUo6p5?=
 =?us-ascii?Q?5zF5+23N4/s/Drm5Q9d1cG5Elj7e21XQGCVthh6DeJu2tFpBIYStnCPStO6U?=
 =?us-ascii?Q?lFd7dtWam5MvzKp5aIDcFOq24NUdZo5+m6uRheJJsiITrUxZT7YXqyhlrc9E?=
 =?us-ascii?Q?uzxEz7rmpte9UYyBliKOM1dk/FrUggrrVm9o/CqGCTYxHSMTdhkNh7geb/6f?=
 =?us-ascii?Q?xG7yuAV1kcvUo0+85F5T6QJb87CygpQsHtmiKWNAMXRAn3PnsADvxSWFhgLn?=
 =?us-ascii?Q?cWf/2rMpNLCM3K4k0rN8QZUj9fgz53jNsiRI8S12asoJdwoKdFRa+YDqsXRf?=
 =?us-ascii?Q?u/3jmVHuBEY+SG+RMNVKl5Xu/MKTbnjYFteFB+rBigAErVoDC8VFMv2Zee0v?=
 =?us-ascii?Q?QChWja3VT78QIkW/FyMai/KeKKXa6fvHYfaEWGLKhxvfRdOxv8mvMcxUb05p?=
 =?us-ascii?Q?INQpbePEfvULI2Gg9HuHyoOZ+kkOcLAc1uUFZyGlTNtCHUwiSRYYjM8qL3sG?=
 =?us-ascii?Q?TBQZWPaRaOXYghqTewk63es6VrwaIAo/iFUaa8fGGsdJIbxoJJz464Qir3jA?=
 =?us-ascii?Q?A2c3SofMfGp+Mc09Dl/6L7Up5zWsLGve2LT5B+XDyNsktof9ZILAcN4YY4mH?=
 =?us-ascii?Q?/JzyxvL22TNwAwRcuj9aFiadtWss/4BaEurMOuWqbQVwhW8JBWO/0TMLBMzQ?=
 =?us-ascii?Q?ivFZ9UTCDq9H6SsdJGybH1DohzDRIOcxAXQo7l5C51mcmnJMDkLQ1EObRigV?=
 =?us-ascii?Q?xYPQ2lKfqiiTvgYMov86/5jJ+UA0nk72Wh2vJASPSHkC+tbJPzNpp0cGdZph?=
 =?us-ascii?Q?zakE7pK2GEfyqJYC1UsCVOCyr7v6ZGXTPq1WFtX0rePUKkTdskzAwyyebcw1?=
 =?us-ascii?Q?9r5CoNTButK6iipGNClIo0LKuLc6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tZNAbS73BBiiodfcopS0/DSVXSk8xI3MjdQKY2AmworbuJfFIrrEo/PrN3Bz?=
 =?us-ascii?Q?9B6r6TefLu6IF8jOfNBf123Ub8ZaGRz3fZk2FcF11J3oCpYLgDBKU46uR5SA?=
 =?us-ascii?Q?VCnN5PQxhsKsDXacl/BBhqiF9KpnM0qASHwYJW2DoEIZcp5bNI1DuVzM3I3S?=
 =?us-ascii?Q?blJEebKeRaQPa5Rlj0NG4TKKwTVVjmYfb8KyGHqD0dZJCLeIpF1l1BR+7kF1?=
 =?us-ascii?Q?eObghuaCzQ+Cra9xQE+7BYnPbk4pMP4nR7loPAiMabFJPOn92E36r0qRRZkb?=
 =?us-ascii?Q?Gyhw3Vc8mWslXmywHhlgjNaCnsat6JnctdHJDFBnC0HQetlBH1DkMt50Qeic?=
 =?us-ascii?Q?1wIhWZ2KieDABjsqs/Ufio9Ktg+5CgID90PxcZU6uXlJxD6CsSBjEVUJjJcw?=
 =?us-ascii?Q?LoCW5IzDh7ruQEn6jnFi+wPTm0d3QKbYzK3VY/Lg1H0lll1F2qOfAVL9DwRz?=
 =?us-ascii?Q?ODNRo90CA7lLNIfnoTk7Kw2rMQq4tiO42e7OsKKh4YYx9ja2VEy+fy3267Xo?=
 =?us-ascii?Q?EOZ5qcPeofX6g1dr3h/oTNtNjTqFy1k+vSwOPCJEAqo5SdqGdiCbgfuaWJzn?=
 =?us-ascii?Q?vgSyWH1M3mmd+9PPELGUguKyRA4uKBmpSspRbwallP1v3aRqmC0SLrR6Eaw6?=
 =?us-ascii?Q?oe3GOHZ5hhRQ6v+XK39DKhdI3JXu8NoWu88KvBS1FfAeTijB2HDjCTMizMu+?=
 =?us-ascii?Q?NdYiAZkVgiC5oH91/bQ5zSXaA9oUgnSjVKG/wW0aumzDjT5VWLxAzTc1QtPR?=
 =?us-ascii?Q?wjPTEUc5Lh/9a3/zv6oV4tGqU3Y/vE29jKA8GpIO1Bk1GJuio7QKmZVE8cmp?=
 =?us-ascii?Q?v1ENsHNjVRDBpK0JWanJF9KXSCtPWDVPBvDFW7n+P5zeuI6eT6PtY59hvmtl?=
 =?us-ascii?Q?VeS5oyUlAyXx5f+MXY0Z2FJVAYkT7ZDc09Vk31UIfTdTaCevshkO3xUq4w/m?=
 =?us-ascii?Q?LKThJr3A/FZPy+VD0TOiPAdkfqpfFBebK06j0qurv00jIdOgQKM5ZeQwWD7t?=
 =?us-ascii?Q?n1fUDfZdH2MCThRjDrxC8NFNlPc2BtGlblRl5Np76UNQOL1UkkKlokwBkezS?=
 =?us-ascii?Q?xLzBxgHarOIvDw8iHpzzZFiGARcard0z+WKYJUToRj6lRsPp7NzJ4pJDoZGo?=
 =?us-ascii?Q?bnfCKdAEAxULdTtTtuhekLmkjzFDHsA6Ol7+3Vsj/PoEyrxFnsAIRTK3Z0Al?=
 =?us-ascii?Q?tEwwVObcArWF8Yk872IqOGWezlR3CLkZfC3R/V/8NnpYRRbO2GjXcPtPvBTY?=
 =?us-ascii?Q?yTGha8PmPBd8xf+zplJFSjx6L8sVI5YP32h5PrJi4gzISc2NC0ZIxTkFe4wF?=
 =?us-ascii?Q?KP6/SI2ayExs3g780lT4N8ftGzz3E12iXgvAF5IuQoPTCl71yDf8wOXnOMmt?=
 =?us-ascii?Q?RtImPNdTTr91muRoMyj5g84V2cKdY7BnenugULxsBqD+0JvNCxRHsaDUZYaU?=
 =?us-ascii?Q?14S8Lzoz6oGJlu1kgf8BRCMdztUO9bHHQF+dJ+aWNhi209KnptHrA1yow1Ac?=
 =?us-ascii?Q?0GTbbdJHtK78+cTxJZu8BkNdlL08KoOmtiAsbtzZviPWDafOO/Cy32thI/FU?=
 =?us-ascii?Q?agMe/0PTf/aGapadh4RBEym1IZE8mX8EEhBtM7EM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b27b08-685d-405b-dc60-08dd40632eb6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 12:48:08.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xil4N6G+s6UNalJguh/aGtjSqmQud3EZ51MLKpOOr8RR4/sV6qxBRZfQakwbs2e1Y106xEQyeW+k88jXP8gUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838

On 07.01.25 11:18:39, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:09:48PM +0100, Robert Richter wrote:
> > Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
> > cxl_hdm_decode_init()") changed the code flow in this function. The
> > root port is determined before a check to leave the function. Since
> > the root port is not used by the check it can be moved to run the
> > check first. This improves code readability and avoids unnesessary
> > code execution.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/pci.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 3e8d20f8955c..d206378c4cbc 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  	if (!hdm)
> >  		return -ENODEV;
> >  
> > -	root = to_cxl_port(port->dev.parent);
> > -	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> > -		root = to_cxl_port(root->dev.parent);
> > -	if (!is_cxl_root(root)) {
> > -		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> > -		return -ENODEV;
> > -	}
> > -
> 
> Can't say definitively, but my reading of the original ordering suggests
> the intent was to bail out of enabling anything if the cxl root cannot
> be found (which suggests much larger issues).
> 
> This code flow allows the device to have its bits twiddled when the root
> cannot be found - is that what we want?

A soon as a port is created, the cxl root should always exist and in
practice never fails. There is no other ways to allocate the
port. Variable 'root' is used later below in the code and that is the
reason to determine it here.

> 
> >  	if (!info->mem_enabled) {
> >  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> >  		if (rc)
> > @@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  		return devm_cxl_enable_mem(&port->dev, cxlds);
> >  	}

For the above reasons just enabling the memory without checking root
is safe.

-Robert

> >  
> > +	root = to_cxl_port(port->dev.parent);
> > +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> > +		root = to_cxl_port(root->dev.parent);
> > +	if (!is_cxl_root(root)) {
> > +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> > +		return -ENODEV;
> > +	}
> > +
> >  	for (i = 0, allowed = 0; i < info->ranges; i++) {
> >  		struct device *cxld_dev;
> >  
> > -- 
> > 2.39.5
> > 
