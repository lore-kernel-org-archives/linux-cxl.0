Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DA192580
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987800; cv=fail; b=IbRw+SriLGKbRi7j7Z0joS5uy70EA5uIWzzV7VpzsNZEtUbtfqfb1SMREbWA7m/sJcELhJ8f/1IZxOVcOfmJQSHyEVrJ2j7iLaIt20OL++Rvie+uFkvD/OpNmIuouxb/XhWxgNlb9YTNkDVebCOLSm0Ov9eVCyV3nT3q31/yLnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987800; c=relaxed/simple;
	bh=FdJhg0sTcKj09aUuT2Hp4nXdd43ccnWmR5gCDepINBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S/TCDIEvto+VFwJPNPuBS/Nzgnhfa5ZVtLsmT4hHJdiND8BUI9emDw15u3cHHw2dBvMX48+yrmjh+YD2IKpaCYaBx67SGo3DXmt489Gp040lBOaEPt8q7PwPhl3t4ljHXKgfJ2nwwXi8kObPAXnvRkBYy+fIT9xiInfLTlKjYAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NDVpU63a; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NDVpU63a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMLfb2jVbrxX5ZIJxkAIuWHiSYlMtnfzp83Gf/jcx5fHV2iYXUACabl97Z99tbGR3qPj8/daltQyYEmwj1I8H7s9S95g1hLVYfFyJDW8AcnL/MaEnzQwz0gJux+CcVNpz0yU0uGxYqlzSJOKzE1HCWTISjKBf8sYYLuwtMR5j593LhbndrOCuCA6lGF2SL+Ffaqbp3W4+QQTfKrySsojN8U7l5ZHEnFbrRXrk/+zKea/VFldxV7bb+hfTfHMDxFUZp6r99zIINZDTCBW4KySyyapugUNVvUAqi+/kTKliPkjJSNmIZ7BjckSALhkaUubAeM5U9dzlNXteAMOC0Fq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBVAZ07URB86t/qEpv766LWbzzkXkIcbgp3mHU3IWe0=;
 b=NiXOpdjECiQlKOJvyWMuEJT6ECSZCGvW8wwdFEHkJe8tb1+y6/9UKR7fXIwK7yEDF8xe+vtiw9Fi5nh1TACtuDOyvxTJ/HwI+Gzj08H8wpmiDJgl1UZ5C37XSn+MSCcEYUWT8jvEPj0IguXOXK9NcfsEOYKvUVM7be5bqRDgQ0l/ko9aLYNY4P8tXui0q+du2h0TPJRTtKC0xkVMDpQAaBmKHN5vmcXpzxArvpr+xBpaVhShz+I+VJyDMoSVwAGs3xY+T1xFrZRghYVNCVCCjebk7afnMl23AVmKw1w4S+cEWPfFQJMIMR8iTQTDkrY5FvJdTdDCEVYgMfSEVIuOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBVAZ07URB86t/qEpv766LWbzzkXkIcbgp3mHU3IWe0=;
 b=NDVpU63a5nJLDp8zUYE3xsGtavi+1bpFUmC/hJJDoSRcBg+1prc860sKZpt5sWCueWZy3K0WXQocurKrsr9zWilakXHyEu5BDGkOXDzIHk6UeRTv+SwG5sAHvsoTJ6I36cR3VU5i+cgWRZEGIy6d5U+Qop7npnqbH2zkHEGNYiMr+YfzOy2KqVACeskZGsi0Ilt10vTMrTIR5kXU5YoqL6IY1oYUkqHfRilXDkyNUALGpFQ5HroIBJA7GZzU0mOD6sBW/YDfABFGpBMUCeP1Mw+v7RQ7SPvFjd3sT+dM0iIC/1z3vjKElAVyfMhUfB3ej8MEDSlklxrtOL6ytPBX7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 17:56:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 17:56:37 +0000
Date: Wed, 19 Feb 2025 13:56:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	dave@stgolabs.net, shiju.jose@huawei.com, saeed@kernel.org
Subject: Re: [PATCH v6 09/14] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <20250219175635.GB28076@nvidia.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-10-dave.jiang@intel.com>
 <20250219175312.000070ec@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175312.000070ec@huawei.com>
X-ClientProxiedBy: BN9PR03CA0570.namprd03.prod.outlook.com
 (2603:10b6:408:138::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: aac97b82-0017-44cf-1c2d-08dd510ec119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D5zuwgDJJMJTPKqoHNaOrFW6xdNi/pM2akhtuQTq+sUoEyibb+tqq+U2P2Jn?=
 =?us-ascii?Q?AsSUqAtTbx6XRWW/BMuNH0OYSTRlbpdew5gvOIhakcji68MyCqD22hJfnXiq?=
 =?us-ascii?Q?7RIghY8RzGhqgKguVFK/8l4g4ycZ8CuWmO/HJksSctGOs+VFdjNjcHDe0tCi?=
 =?us-ascii?Q?i8eJpntoX+IBpe6AfC0WZlMBMNn6cCNw6Yw7JeAVb3qvJy+DyTUaHxy9j0sF?=
 =?us-ascii?Q?4y6mO8HcCO5Oezv7aZM9X94ib5QJwqcsUyLnJdaW7XTwNGy4xnKAuuw6sXbH?=
 =?us-ascii?Q?oiEhyBk4qgzwrKcvXO+WS3Jt46DWG4TJW+dwZviQpQdwt0Xhqqp5Iz4AWN5X?=
 =?us-ascii?Q?rl9HknIiGiG57wiL+deWowi0fr6hqS1ss+LbLGeXIoc7FoJKtQMHKazhdTbm?=
 =?us-ascii?Q?QPZBRk9YH5u/+M1rxcW+9cDHNnHtJbEc8iy1TYYl7P3gQulhLXRnpAeer05Y?=
 =?us-ascii?Q?YrScU1UUH+9sVjlFO1Kf2CzwxqyFAEIbtU3+rf4lFOzpXVHtcbrGVD2IEG5u?=
 =?us-ascii?Q?joGuDh0o+aOD0GnyWceeazHIHwlDA3lQkGVClOfKd81QtKt3Jbk5riISp3Xv?=
 =?us-ascii?Q?ePDTi87Zw+GB8LYpAT1Eg5Ctsr8f0WYpeor0fHYoMFm+CpgnQ4vgi5J0BQRA?=
 =?us-ascii?Q?aH9udimwJCmVGMDCU/FqOwMl562AhZkb/I+9rLd3AZCUU8rrp94yGs2dGpof?=
 =?us-ascii?Q?sP5CjV8BPV8sAiyX9UsXDJxdhtwxz+n7PO1n6295QkhsFlbhlI41Ch7mAlwV?=
 =?us-ascii?Q?V2WkCRzlLScsh4DzpCLOjxdRiCDIyg5GX5nvh3FJPSOiP1L5Z4Ev6hu4Wfza?=
 =?us-ascii?Q?GqnO4Et372B5GfkHGb79F4tE9W1UcP/BNW8lICzCZyAzX5vhZO5q3hfL3JTZ?=
 =?us-ascii?Q?TYmucslOX2tH0hNqV2jr9VLvLxK3CymPZN14/QTugvpuZdNrUPfD0BBCSFHT?=
 =?us-ascii?Q?G3WpdpmzV1dd9CiBsadeJSZ9jZ8jRT9HcJpP24dfIxpYvmhxIywWuXoM7Caa?=
 =?us-ascii?Q?0UjalxyP8mJz90XFzcENelOQCHFoKFVa3VW0LwwDGfXstEOb2ARfd6BhxMNI?=
 =?us-ascii?Q?aEHK3oCr6hskCC0uT0quv/X+zbiswSwpOM0G7ONIT+UjtmX2l8CrF59Rih/3?=
 =?us-ascii?Q?lSDHZHE9qv8Cu2KiLvixmlVvxeTml1PFu57bTYhFf50bZdR/ro/QR0AO+rgi?=
 =?us-ascii?Q?me+ABCKMFOuW7CS9tIhlXLR5NIF/lfQDCPbglQO0WkxPcrlbZB4zy5yOJO/9?=
 =?us-ascii?Q?SbpdSFiTEc9RIBQxmMatQ5HHU0PRfho8G2QlqFvHIrFgV6yeOAhHkQxhLy3l?=
 =?us-ascii?Q?P4Ey3YE/nStNmYNvXT523I9fYuisYosgOczNCJmQJGZ44OF9bFVtcvhXDqpW?=
 =?us-ascii?Q?9kgvlu0qkReNL0ZgdfS5BzXExAmI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8iRgWWyvnJGDeqO88FPVFhLTQahsm5h0b/P0MG/Z3tfJ6C0dRAG+zQZXyWT8?=
 =?us-ascii?Q?816ViSPwT2cBx8XLnpLVMz1e43+XCpnFCO7oSqC5aEhChWYcEyRn+6xDSqau?=
 =?us-ascii?Q?a07ZZp746Ohdwm8Wrb4dawt/kW/cpbY265TC7g2Tm+Nn9TbGIoGHA+r4eYqN?=
 =?us-ascii?Q?w+She3WxvufiiuePc5dkF9mBIGzr0zAmNnzU6gGFVWZ51lDHjxFlof3dj6H6?=
 =?us-ascii?Q?sm19y+optOhoLMffshNgLm9DVe7PrbStcRx+ShnZyh4B/tNeDOgX6wH8jCFi?=
 =?us-ascii?Q?hnAM3oVwUGS4Q4m+EJOvPlC6eVYpxNVL71CL/kn0LM9aOERrafT7G1SW+kiO?=
 =?us-ascii?Q?ffy2gfVap939u0eQcvCCt1Je8bSZh9C3WCIzVED8bgPAXsPa6oHVQCn+zXCG?=
 =?us-ascii?Q?7GY/x0edh1j+r57gYvd3cTbmA+fTV61YXFyeDvKXgvaDTKEs0/OIVOgrEPBQ?=
 =?us-ascii?Q?wY63z3zUHe/bX6vjF5KEU50DGumqN3HRFFTSAhzaWZ6I5g8EhCHK/Djd0aB+?=
 =?us-ascii?Q?bM6Z0aCjKmDdk7L5vHgalvOl71MQFk5k9Datt8SiJRT6LAUHAG4kJvgXrie8?=
 =?us-ascii?Q?rQbw4rwyGTvut9Zkv9RrxzKLC8NCi1urdwTE9GCFiTmrnXYEz+2XgYULcQID?=
 =?us-ascii?Q?v0I6C57lh/LWY2ztOQaF0IIHucHSFCgxrD7wHhiCqxL7+FrtITyQbPE37tyL?=
 =?us-ascii?Q?mL/qv46G2BvANadKCh0x4TnefCMrNxzg/mV+b1czOnenUM75SinaDiLESiLj?=
 =?us-ascii?Q?NZsBCdp8qjIp2I+R5MqFaPrRY7NoJL2VvH0UTT+vfTpbTPrxVBTS9Gg7+Oon?=
 =?us-ascii?Q?sPMUF5eIIKHY2yfbdBKB4L4RImaDu0fS5K+Hca9eI4AvPZHZ6egKyAtJcTUy?=
 =?us-ascii?Q?JasZ4VAUqSftrdIKdRaXwHjz2qbNvCkS2k8KTpZbryCZZBikFWIon+u2XxaS?=
 =?us-ascii?Q?RjBWekimsdr5Vq5IdMu1ruysJiiL6M9QHWTlnziOB7VPXGNTYyP9BO8QaOlA?=
 =?us-ascii?Q?VjLckV5t7GDbdtzia6vTvdgAXiscCpuhwmptJsc+rZ1Yamfxgeq/xG9eJgJ+?=
 =?us-ascii?Q?4MZHQ3oWclBhhbWMMVh3Z67CwmGjmyhrg2CPfSmfxXdUF15k4UPRpwy7dbqE?=
 =?us-ascii?Q?rPv7I0NXL0jeIxG/fyUdyF4AqUlUgsRjShjet7/pUY6DV3IRmFnYWlRL17p+?=
 =?us-ascii?Q?P6L9cCETnOfm2RDcdbAGVXMNIc0OfE4Q+Au1+1joCR9Dxkpt+XwbVHdD0Cql?=
 =?us-ascii?Q?rF823bnReeaomE3SmnhzEreyrapS751fdeZ8rs2K/H280cSo+85e8Rwl+QSX?=
 =?us-ascii?Q?5XhRTQBTtn+bgk9H5g2iJLT6Ym2QVGdvMpACkEN3viGFEpoqj6FLii1qpKc2?=
 =?us-ascii?Q?6sEbEtMeH03+W6RRD3oN94C9pA3v8zHJWobpL16Fx9lSyqP/swV1qbXOX9O2?=
 =?us-ascii?Q?YlIZ4lDs9Pnnb3841bMqoiRdBnU4CLJM5OLa++0Gnh3kKSh9tQD303pjJ5rR?=
 =?us-ascii?Q?Yj+IQdoxE6kfmN2mPQfoMC99jTQt07/G3p8yD8DlfId5Dfu2iNgd+o1bPLI8?=
 =?us-ascii?Q?lEZV2XQFfp/zxCo7+YRs/lh8xiGA8chWEQu/IGac?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac97b82-0017-44cf-1c2d-08dd510ec119
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:56:36.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oaj30kHkq47kQ3rTV/yVewfLzZntIrBYgOvmh6M4XTpCUJpcXgL68J2oyPUpPYM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

On Wed, Feb 19, 2025 at 05:53:12PM +0000, Jonathan Cameron wrote:

> I'm probably missing something but I don't understand the need for
> __DECLARE_FLEXIBLE_ARRAY() in the unions.  We always seem to use one of
> the structs (some of which have trailing flexible arrays).

Can you even use those defines in a uapi header???

Jason
