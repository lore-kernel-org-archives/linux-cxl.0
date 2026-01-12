Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ADD30171A;
	Mon, 12 Jan 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219680; cv=fail; b=dUE2satkRwzsTYCP+9n+TNOP3d26IL2ewLaBZqkiKr8U5zthI/NACB9A3Y0/5GRFElty4NSa7dWy/LUq1wENAOTvRph+70Y3jSbujsfOUBmAdkHXQhMuBbjyXyryLCHIbEMSd4RCRldjBzF2JCQsB97pcryOjoOxKQqSP+9vxuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219680; c=relaxed/simple;
	bh=sMcjzMbCCKMzooQCZOI7KZvoBMnD0t1NUVGjjMN4cec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hR4wAwI1xVnMZAyWTkkbVYT/5gy7z4RCJfwdLMLC1DGnNS/fxE2ejXYR4YmLekfF6F9Gi9WbTvUb50C47+MaCcYGuFzDtEosxdt+Y/RuuID/WBomNbDuxgRmxpGUD+yCewE3XMz7BpIbHeuYWRR+jC5Xc1SiBL/slYGbO1bxs9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gJV59V9M; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gJV59V9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNVhbzKrz/vK5CbrAxDG0NzMBQZrcn6eEp1GfVdZg6WcMR3EqC4hj4t/HchnJMpzRip9yJpvahlAV8lO/irA7O0/+xHkmh/zz/W8iYJvpYdnComdEWGqBDBVvh4PZN0TSPJ/jTAjIoZQIgq3XoinhnjE+bGpk1jQok4Nb2DO5FLaABc/xyF9FZo2DKcLBon05FFkK2lYRPJjaDsrL8nbn7GjxXLk1z+rpDU77OQ5Cgs8VDvB0gufhDyiTkqmudGF5DgLvj+7L9V+ERiUd3TKQR21d3hGyKvdWfHRObI9Lbcbm6uvbttfw6i/r6J7adcR4LvhY/K2ujUdqZ0Ufb6PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XhNu8r4DmL9g8+DILCA5cZYQX+tQUlv1w9T8sX87aA=;
 b=DahcpWfzm+BTJYzlD5gh6XXRoF70IPAzHfalov5gthRzj0zKUrfg+/XMBITho4JUVXHi3W2a9E77fMpCiE1E1aYRjw8E9Y9L1x7TlzmrjKu3l2T2e3U4tE66DOQs7L7DwonXQ7C+mAsl4ge3psXEs13Jf0Awg0SmV1Ciy0sFmsjxdU+b8rw8p+j53dhBmj82jNAmQX2BXowG4tPacn+coaiz1AnAcnmMJWyqN/GBzd+n+m8pk7Nvy4o/ZMerV0lrLx5VhSsFLgg4UhHyqtNO4JKrNxiPhjRFj/bHZNJPASud78A73RREXy8/eSvLnwkI1tiUmiPhsu5RddqZgbKRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XhNu8r4DmL9g8+DILCA5cZYQX+tQUlv1w9T8sX87aA=;
 b=gJV59V9M13BOpHsCWroQ/8ImVCc2ud+Ao27IntUsmXsixUCU6kc2lg/I4je/0NKDwnQwP/c6dxiH/KSvF1KZQZzfa4wzR7BZcDFO1h0PxXeTL1Exxrgx/fG/qeKBP6gJ2ckRNn1ESfvBoG66roJKDbso5+yVKkC/aA7RGllJPx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 12:07:56 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 12:07:56 +0000
Date: Mon, 12 Jan 2026 13:07:50 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl: Check for invalid addresses returned from
 translation functions on errors
Message-ID: <aWTkFpaR_T4eVSsp@rric.localdomain>
References: <20260106172358.350724-1-rrichter@amd.com>
 <aV1XnLrAiONbeA_X@aschofie-mobl2.lan>
 <aV5LdGD8lQm7AYK3@rric.localdomain>
 <aV_ySgCVvEjLoxZ2@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV_ySgCVvEjLoxZ2@aschofie-mobl2.lan>
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b819a6-bd3c-4db5-4b9f-08de51d33894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmODIy1Zi24OIhLSFPCR+QO1dsMNibOqpzd2G5K6I2kSwQZKOB1mR7o3FHAA?=
 =?us-ascii?Q?9TpGVuNcUpihiwNlrjSf1KzDM0ydZD3Anfy5G29szFrW9/bV2HcOZ/LYPtc+?=
 =?us-ascii?Q?kL8roGqU7/fjT299G0bFFsJ4Jf65R9eNHsFALs3tfC9v5iDqmHAhHbJotRo6?=
 =?us-ascii?Q?c1qwUPkIkn/d+LrLE+FnDgusZa9SbuwohQy9KpFubBACMBZ5g0xvespzZb53?=
 =?us-ascii?Q?A3I5rVh8IhKFp4/LaMUPtfBeernDJpNMRJclyfbVkoCwsWpzhL7okaFjFxT+?=
 =?us-ascii?Q?UC9m97Nz/5SOJZsrv+oD6eShfD1OZSA27OxDP/5qpdeLvj7iuC96dLKpakqV?=
 =?us-ascii?Q?fHFCdVvBaWvBfcb6VibmR2xyM6UApKYbXpQqN1fj6L1G8wZwyzV3hWXnK98F?=
 =?us-ascii?Q?m2n8ZpCGjUlmHtM6vyWPSB0yZ/K9pC6+HDqfQxc2sJxkU5uoZWoNOE1MukmH?=
 =?us-ascii?Q?7QJx5ZT7xdOGsQpx32x3EyvE4WbhQ0MHaOHkb9GIRYPM8Hyt3IdST0nLLZ9U?=
 =?us-ascii?Q?T0D6JlrpIe6uYXL6QFPkDyLb2Ob3+ulETOj6963HgIY5lLD0bxgfZHX8XISW?=
 =?us-ascii?Q?G0iIGjOGmVAS3Ts9aWcJKDTQabIIAYhozuQZxzctKjaYSXapNgosz/qhHnxz?=
 =?us-ascii?Q?vGK3SYWYx8tFhKqVERf5M+7u2OB6vKHXH3Y+A75u+r7swnMWgGbiSBpEXgVb?=
 =?us-ascii?Q?LRLSejDrRtYTFxpphF2Hfp7UQ+c4+RkfzmTH3h21A+Bz+PETBkyzZX+F4Hck?=
 =?us-ascii?Q?9KNWTnHYfC5PKgGb2HLKE7e5tOVuSeAwlGwIe6gU73BvbwNj/nCiILL83OF/?=
 =?us-ascii?Q?awOrg2LPLUZoLCJXP/vfrtLbXSO30tWTin1gdUsrPUfF5Cv+RgHfYE3vg9p6?=
 =?us-ascii?Q?DB35xpx08ufNV8q9uN8jFulCqS91z1rDRj++qF6RlBtINzCRO4+XOaftGQIX?=
 =?us-ascii?Q?VPSo1e/R1bUJDbI0NaVQyGAOGVtOD/cXYef2Uv/psdAONroAkX5EKPZlwQfZ?=
 =?us-ascii?Q?PkGIWcBxrl4p0+kf8aKrAYi7L+KqnUmFOOyFIZnAKLL3m2bcEF73X4HAALNm?=
 =?us-ascii?Q?WHCAkYmFD+9KxhYG0j+BnsslZafeSSo7XMje71fq/TM8B3HqDETOwz73k4BY?=
 =?us-ascii?Q?ieyMBWGWlWZst+sOZZ0QHPByOqfssplKXc+AxPPtfjR6G6XNieMmA1Y/iBdr?=
 =?us-ascii?Q?WuOQizugXsA8z+V0Y5w6LL/uQcliNJrBzPiyc5iyNIq13NhhY7KLU2isEifY?=
 =?us-ascii?Q?fO60MZa6gSQWljdgb9pc//Q41Hf0KNmlz5bBfQ7yAa2I5g7e5rgsUyF03yHb?=
 =?us-ascii?Q?Oo00flaz21IzkkCGZN3iq4/1LhtlRBZ6+7T9x3Fm8ifE9dOr6kbc5QBCladX?=
 =?us-ascii?Q?oC6vJAxfAtQlXSvcd0klPnxz8rk8kFjWuxo1tMxyXLJ1BXRtZnFYLoHOH9zF?=
 =?us-ascii?Q?pAiiAYHEB1EYpkvVOGDza78/9Nr9qIL4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSWA6DIZt/FpbmIqfnZwgAf+39u+eRlSIU0pdNJnp0kBfp6mYnT2y5/p+s9e?=
 =?us-ascii?Q?5wPzBcnPYpof6H6oN4rSbHIy8Mvuh6N9tUy/pil1rMSJCFPjXYgVCkHVXHKQ?=
 =?us-ascii?Q?ovH6GX78RATaHmhzgPZY2TGXSqaVdjG5OAVeEdVE/1GHHWAKED/LIdwA5Tpg?=
 =?us-ascii?Q?yu+19JkDdICrXmzodofYmUxDBLbg/6QSHk4uFpf0rPuvqk37qMHlzUuywn2E?=
 =?us-ascii?Q?joIbU5x6dt7DbG2gcyBXKwm2/7zycuEvAe+BLnKHMwClOU/PsbG7eGHFOE/O?=
 =?us-ascii?Q?PX+J4IjkjSnOqoBZ9aG22JOOB5tEHZmcoaiNBWyBlfOEG+Fcp8OcYSda37jU?=
 =?us-ascii?Q?wINgv4SqPD3U8rRT5NVlMWuNkBIerL7nqP5/EM5wPla1c5nxi5Uh5JwbL2TT?=
 =?us-ascii?Q?KQsIpLB7iyWl2ladLCnqvwNp0I22QSoNa1HjhGRf2AdFmMPgpBTMKBxCpjPt?=
 =?us-ascii?Q?6f5w70ZVboS3j/TY9nJpJqYngwVzh4eNmOtdfUEk72lNk8ogKFjb9mQ4eyVn?=
 =?us-ascii?Q?qqT/l+SbRIUbz97JIQXduPQ740dV3mW1+yYag+Pu6oq4t1KH5mgdc/OmX1V7?=
 =?us-ascii?Q?6RXTWhH6EMuXpN393xNQS4BchikDg+00Oc/FytF2xmopHc8oqFxxxJ9S9hVw?=
 =?us-ascii?Q?/GfiqfkpTVgEBQ/awYBTD73noLsMLd7HjisY1dIpm84YUV/xPKtfThIQiEsy?=
 =?us-ascii?Q?ri3s03sQXrcS2VkawyVJ9fF5KzVJr8AmYIu4D1JNEsMeHQG7IaEdMi1ugpP7?=
 =?us-ascii?Q?xFOMZ+wbjFtu2FHS3AZZiB0/lzKE+gKIErXKYEkz9h+6o57stdngI1ITZop9?=
 =?us-ascii?Q?oKVLWoy99wriOg2/QquMkOmaFrPCTy9LtA/ph8YT2Br6YC0TOlS70/lJsbZL?=
 =?us-ascii?Q?DDmZeyuivVjB5sxe1wONL8f2CjdEnMJGQ65HJUJke3c2Und2VXisfptb0TiE?=
 =?us-ascii?Q?2HffKE+4rPdN83/smYwWFMSzW07X8frXajQzxZxu0EiGrGAFf12yQg/NEISe?=
 =?us-ascii?Q?ko6fDk6A1aAlUR+e92+25s5lyFOXqcUY3ka8sO4Swt5ifaa617Ch681r6KE7?=
 =?us-ascii?Q?h0JWDkhhI8PATCLDKId3obwpX5bogiRmk5hfuiiQftX+1j8Z0tAaZMzMY5x8?=
 =?us-ascii?Q?plWiOCV60pV3gJiAAml+Ax2eQGvMcGXLxn6nVpIy9q66mmQOvHroUN3bpiFz?=
 =?us-ascii?Q?ALnVWLTupshqajfh32JGRhK5FuoKLWXHGH/XuYe7Np3ljlsAFsTzkchuuMY0?=
 =?us-ascii?Q?xZHnmJNjLdAQSfZHgkHXDUM/PYsHV+G2O+6V16DWFcUQwLJebJYA00AeFDuY?=
 =?us-ascii?Q?J/E3gJjzmLmMf2mTAlt049vDHH4R6l3OkZG5Sgc+S+cI14h1FV1GR1luNbb6?=
 =?us-ascii?Q?ulIcduZ1FBL0pMCiV4vef7zpExIkW10LZ7cB6ddd0gegdPBL8oIvT8VC11ln?=
 =?us-ascii?Q?2XYXGONk3S5/RUJiGOT3Ddo196rl2pa6P3J8ssq3OJujEpeC2mVN0DMBz4hr?=
 =?us-ascii?Q?l0dTHPPQZUYqrX54cwE24EgSfbSWQ/HOV50AJ9VFEVOmSdjjCWKv5orgsd/9?=
 =?us-ascii?Q?rdUvO+DNL/nt20xnIn/aSJmJmkmymC3T68sGpmTguv9J6uv6h/2SNj0M6T8G?=
 =?us-ascii?Q?q46lqYYssLEdfqq6QFyTaW1C+vCyH+LjMiTEN3oGAlOWlzPRwYq7E7xZRLyu?=
 =?us-ascii?Q?+Bpo6OdTuBdZxIttglSs4EBxbV47GV2qf9u8Ec3Ac5Asg+1g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b819a6-bd3c-4db5-4b9f-08de51d33894
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 12:07:56.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2qIwNjPkhD25tYyk6AXXZ8s28c3cP4tLoo0lHeBz3psQuNBXAZtYEU9z9xWjQodmfswI6mrQL7AtrEeBQgLug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

On Thu, Jan 08, 2026 at 10:07:06AM -0800, Alison Schofield wrote:
> On Wed, Jan 07, 2026 at 01:03:00PM +0100, Robert Richter wrote:
> > On 06.01.26 10:42:36, Alison Schofield wrote:
> > > On Tue, Jan 06, 2026 at 06:23:58PM +0100, Robert Richter wrote:
> > 
> > > > @@ -3207,8 +3220,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
> > > >  		cxled = p->targets[i];
> > > >  		if (cxled->pos != pos)
> > > >  			continue;
> > > > +
> > > > +		dpa = cxl_dpa_resource_start(cxled);
> > > 
> > > We want to return -ENXIO, not 0 in this case.
> > > So jump out here immediately - right?
> > > 
> > > 		if (dpa == REsOURCE_SIZE_MAX)
> > > 			return -ENXIO;
> > 
> > The users of region_offset_to_dpa_result() handle the
> > RESOURCE_SIZE_MAX case. For that reason the dpa is not checked here.
> > I did not want to change the function interface with that fix.
> 
> region_offset_to_dpa_result() intends to return an rc when it knows
> it would return a bad result. This is that case. With this proposed
> change, we avoid adding to a RESOURCE_SIZE_MAX, which is defensive,
> but isn't quitting immediately correct? These fixups are all about
> stopping when any ingredient to the calc looks bad. It looks bad,
> let's stop right away.
> 
> Seeing that the callsites do this:
> 
> 	rc = region_offset_to_dpa_result(cxlr, offset, &result);
>         if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
> 		...this failed
> 
> shows that they do some defensive programming and don't rely only 
> on the rc. But the inverse does not seem right - relying on that.

The logic here says that it is not an error to have result.dpa ==
ULLONG_MAX, e.g. you still could take result.cxlmd.

> 
> Staring at it more, I guess you could refactor the function to be
> a void and get rid of the rc entirely.
> 
> Is that the real simplification needed here?

This patch aims to only fix the use of bad address values. No rework
at all.

-Robert

> 
> -- Alison
> 
> > 
> > Thanks for review.
> > 
> > -Robert
> > 
> > > 
> > > 
> > > > +		if (dpa != RESOURCE_SIZE_MAX)
> > > > +			dpa += dpa_offset;
> > > > +
> > > >  		result->cxlmd = cxled_to_memdev(cxled);
> > > > -		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
> > > > +		result->dpa = dpa;
> > > >  
> > > >  		return 0;
> > > >  	}
