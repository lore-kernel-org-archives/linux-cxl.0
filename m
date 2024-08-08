Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686D149DFA
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121804; cv=fail; b=rTX4x4W7fcQYzFu9WLqsBmgNTKZBmYdgHXVl8m2e9Dnurs/9Rw1aLjI3PLCSUBK1qCiTSIJt+iGn55gM0xMIlV3tvoWhtzA6uZk5qcojbsN4gybKtg1B+1nzk5DzpKJP4XDxFAvrWam9+0VEm24xlE7a92ZNI4K1tY208EZ45KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121804; c=relaxed/simple;
	bh=D9L+d2Bcubr6SNQBfwPHI4x+OacsGWF7hPL30m1K9cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B88t+FUW0oKaAhd5I69JLJg191GjYclOaIAXLHvLtEECieV+Ip1zRYeyavoiUdUrU1UBK4V3MOk1md7OnudwSnMtHOl/tOsqbBRUaAHzGsVA3ZB0GuicHR9/725uWHeGyX8nV3ZqIDQ2jvVNV5Oalsl7C95g/7+KJHbTp94CEJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CdHlC+vQ; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CdHlC+vQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0dbmG4oIJm843UW7jYhypDBWXJ9WH6BkBDRepZkaXOOXBTQ/09PpHR7GLkIw2FndJMdvLE3c9IHY9G/8mJdhvXhfcEALK5LqE5gVKmlQpQ6D6/kxuea9ePAw9D0KVseqFrk4ihYz6TMoJLjTD+1EGNCt8YJRe1pBFIgeO18mUJ/H7IJcrB/AzbjP9MsEDe3Os5LjC8IGk+/nii68Ue33FbURhzrOV01CjbqHDSc9I6hfN1xxgVc+7Uia2WqepditLydkEQUcoxMlDuDoF9dbqJLkoYANOmkNuSe2gXKBu4MalCad35525KiFYx/7WyLw2rZhRWvqfzSkUK3Vt+S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts6pFOaDOoXCDoZB2rsqZAtcWYzMbEt1krYIljQxe/o=;
 b=a3ccWhTi7j+y+EVTi9kf4gAUtjBeKB4bbGG5A2SewaFONL8e/90lnkP3vsch/Nk6vpxT1Kkh41+N8QGGwfsHhaD1m6gwA/sNti7Z40lktrylI5wOzOb8LaL522bG4gcj2sRixePo/H1eiL0QNCvGdzrEW82JpzYXjOAo+IPWyhmvhIeS9r4J6nlaeLElGbicGaxA4OaYNML8nEdtvyO4Q79uxXMv4Xl39fpMRfjkZ+1QSgzZrnn126Xt1b2n44sZtK8jpYip9VhtkbJowIAX95/Jcv13mO2zj6Uf5e6QYkJM7JTQEApFYi1AzvKOHpl9m8l1or+8puN4fYWR0iMO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts6pFOaDOoXCDoZB2rsqZAtcWYzMbEt1krYIljQxe/o=;
 b=CdHlC+vQeu0fgP51ojddrKis11esvi2lrhG7fkrTL38QtH3bWnyQQGhC5Hzpyr2Q77cHKtq8ZQctOGyGw/wxTmKanLDX+L2+WE3TzjIyflj/J/WkvLWRWZoeCYw28ieZZPyqRUmHVcYGDDs55iCOUuCWElA6YWhk0RjAa420ETcp02QFsx9cscPHj+2jzl17SIVuv7Iiz9eIeV3bmsQ4IG2CD9DtaHcLGnCyeXtiOxM72rW/Zn213froxVsoDnE7tgy3jr1Jgt2wyigxKeZXnlZMTSA1A4qNeYoFnwbL6gey1F5nS3Zve5L1OR+xQPa5maaSBDbdJNEpE9QTRaJauA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 12:56:39 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 12:56:39 +0000
Date: Thu, 8 Aug 2024 09:56:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH 11/13] fwctl/cxl: Add query commands software command
 for ->fw_rpc()
Message-ID: <20240808125637.GD8378@nvidia.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-12-dave.jiang@intel.com>
 <20240722152401.GC3371438@nvidia.com>
 <f3cd9a95-470f-4db5-97f0-04bd3ff70cf6@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3cd9a95-470f-4db5-97f0-04bd3ff70cf6@intel.com>
X-ClientProxiedBy: BL1PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:208:256::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: a63d1a9e-ea63-41d1-555b-08dcb7a98b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DwoWL7QMQoajGxbUlW8xrbrJ5UbW1rgf4yWGySE4vWS6DDMiO/Fgwr1y5QWh?=
 =?us-ascii?Q?CB35Xr/wkV7DP4lEz8AXuXFi+iPAu2HXwsp3Ke5KTIk9xHlJ4neysoZop9qx?=
 =?us-ascii?Q?+r/5bHL7IyyfcsqNgdrWyARrAmGOXGE5LgEgP2pTQvXvDQl3tXYTmftAau9j?=
 =?us-ascii?Q?p9+7cM2Tlk2Ghqw/lnCXBpEDjBGkU/SEAwNAP7alrXXyCyyD+EQVyrs64T8S?=
 =?us-ascii?Q?KNGUbNT7UtZhT8CCQWgxTTRwlwIRsdnZwkWCDeof9xkaRsfaTpSQR2LXqdPU?=
 =?us-ascii?Q?JHgGYXTCUJNOCDXWWXXXVrGlNJgPcBSI+oSi2TG9BnI+/LG3LGjkvEDnP4wD?=
 =?us-ascii?Q?ovjxCQQCqN/CcfyeYp3x8+lF8JJMtmGLuPcoeNW/8uO3sOhEHYZg9rGO8tyQ?=
 =?us-ascii?Q?OewSri/AbcK/kZi9bAV2ZoteU9QkhGgi+BqAyozlBqewfm6eKOaYNGljcAty?=
 =?us-ascii?Q?FEq7cvL06da76V1ReIlmD7CP5rJr4Rn3xMGlIVaHl8XK25QUqsU6hfygHVhF?=
 =?us-ascii?Q?Xvoh3DuAk5kzOyANRvt8z/BJ/rnpfC3tZUAJ2rWGPJmrRyxas9KsSMDLcVep?=
 =?us-ascii?Q?QV0yj1NW8+01BbWqQsfFYNVsXHXWKMTryzqCmatpXTdctVWyWPUruTqCOahX?=
 =?us-ascii?Q?cfZjJi8U3KQzSOZmUpJjV55yWLwhmh3rvnTQZdhRjvpeVU9YDc87skAto43u?=
 =?us-ascii?Q?d0VClJtWz0aFYzLuscBLbkuevBX1rzXEHMtvzadCx+y56BiQldyne70LPns6?=
 =?us-ascii?Q?nACKjneos3mhEIOdPZ9gM1GNQVQSGRhKQy9cpCiuMnd0JfOICxs9di8Kwdj7?=
 =?us-ascii?Q?F0RiJ7+8F/ciGWHyE+H+QNsbYaBDUAxYtOqFg6JMij3v5EVhv2tWXZ4z6k4E?=
 =?us-ascii?Q?mYpBntBO9AyVOr8R9uJnPzhnzqtecLsB8evDV93G/3HqfyqOQD3z0WpwNcRd?=
 =?us-ascii?Q?ajyKVQOH8/pHMHty6CFGwht0eS7WgPM5/A+l5gENEHWIcdp8j5PuYBanGc40?=
 =?us-ascii?Q?kDoxH7jUsqxITxi7cybQV1zljIf+qHgMtOSnwdzGXYVFHFG+1XkR8RjAh+Ol?=
 =?us-ascii?Q?z9acEpiHW4kLpsyDko88L88zrTKv3ZhztPoweSw4O3YW57zM0781gQzarcAw?=
 =?us-ascii?Q?jB7tt/NHL4b05dvFbPrWIHh2U1ySGavAtepUBUt8MvKAKLSROITQ5dTkQz2Z?=
 =?us-ascii?Q?NZJVMfmqFkIY/BI9WsSXzYb/VwBRTYjRLXaiXLrKLNQ+0qCzJ4y8gfc53tEt?=
 =?us-ascii?Q?VKfVKhtb52xHn1k0UYb4pUZOl2sgjryBlQTFmGrYB/HVqnty1GLVr+tDFE44?=
 =?us-ascii?Q?f9nEF1USH1je9zYndAgO2xAo9qoNZ6ngUBI218k5jFtfdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1a5VT/Izz7SEkuGrKNbfjUOwW+RLyoQxKR17PrChGszFaietagQOvWeyp62C?=
 =?us-ascii?Q?mSF6gqg41/hjEhgJwMVumS08aLRmhGHdccTRQPNljITtl+Ulu7kI6tcAsXG7?=
 =?us-ascii?Q?SEPu5a3cLiV0C9+//fZKxlemFoDQSq8a348r3z8eRtrBi4oKtV4Drf2TsdbA?=
 =?us-ascii?Q?Nn5D8pc9iTJeI+1qh4OOUfqQzA4dytF75BRIhaWf9jdTFvhhVVlgd+BF6kMe?=
 =?us-ascii?Q?KkecJHkWXvK+awXO6Ulc+qRHNn5NeMBrChwdNb4zPx+A3UEMjxx1WByyufba?=
 =?us-ascii?Q?TDg5PMzUQW1nn+IXsmHiqu/PaJK0T9z23ydLALSIcn8upzwx+vp2WAFd0QRS?=
 =?us-ascii?Q?X+NjklpucEx5LyYkLXmYpXV4xxkUSE4LgAdG7JL6z6nLvQFG3N3ktp0/U47U?=
 =?us-ascii?Q?VykptyCftBvfr/E2fyopggWtHvCy3aqR/ChP97CZzLgwTmjIHdj3lsweIULX?=
 =?us-ascii?Q?5+xhKRj8wnl1AaXHruRLV956I1m7Xain14SvQBnYL3mk1RtPG/EleP8HUbKD?=
 =?us-ascii?Q?MMfwNb+I7NuK/uLKVG+99t/OvkpeEJ7xZ2w0PC507bP4NbbV3J6z++DxMmyY?=
 =?us-ascii?Q?LqMFpLLNompCs6eEGY9rDMXsDCwKfQWrBLU+ZlQKeWskhpFFbnoiqzXcP1bG?=
 =?us-ascii?Q?Y3L7k9drbOdCIs5iIsJVisNaLqtcDjBwKG8VQ/InudaZ3mpO7DkLKkAgnfah?=
 =?us-ascii?Q?sLB+Fj0ySZREcR+m1WuHvDUVWyB3AkkvJfMkL6NBbWESHex8NPFgYGSnN4gA?=
 =?us-ascii?Q?LRKP7xJ4Ch7WsE6Bj2iMotNykVExaj0eF16v4XguZBOCZMhXSAwnpDuA4dYK?=
 =?us-ascii?Q?3LluSyeQKR0I6WSOErz3r+VjJiTHWEiPtUjnfjmDWzUDGZ5tgOTE81Jt9mQv?=
 =?us-ascii?Q?3Yp7sFiACLxgpEyw0Lvm/zv4YZnbTacCSnhQN+loGaro8qPTmIdYTYrWjqvh?=
 =?us-ascii?Q?pd03bpdGyMxfiJDwb9/tLx1TwV3hEIJX9HHnq3niykBgCPdow+kx435NsN3l?=
 =?us-ascii?Q?7HerAtz+4ZgOU4WUK53SxrMTO/EevOLOLf+NGxRpqByDGpcixGyHBXLup3ow?=
 =?us-ascii?Q?AWnl8RUo7LBILE4Y6fq1yQsf5CGHrrvaihB8WGppSLxPhO2u7tC16xWCnQxj?=
 =?us-ascii?Q?xvxu3gu4eXubjMBGKA0YIdUpBitHqQ217oOgLjavXEtTsq6LCLGpG52E8TDR?=
 =?us-ascii?Q?kD5af7aaM9BCZUJT2+M929ALQtCSnnO5gU/iZaeMcgyzPpjo51hMC+lgj35J?=
 =?us-ascii?Q?Dl2Z+BT41hgn2eneSsYd+YwKo4W4ACqbHoczUCDa4hB5EUPyxOwnXRtDYxnd?=
 =?us-ascii?Q?32t/AXzcDzYWa0K4RAnafJ5rsVM6/eiQpBREZz5JSsAG58eDtVx+QtiyVFSr?=
 =?us-ascii?Q?CozV96yvWqUShdZMZzdrUWwG0bGhpc9gT/dt5fqLbIlLXam+WHnlTVFNlOeY?=
 =?us-ascii?Q?HBYsZH5Vrp1WBk6oUh0CVot2ydGXaEj43xMtuRzGx39BgpvN0Z1eN0t+Uux0?=
 =?us-ascii?Q?A4kfslyD01/AMuou3ksgljHA4ZJm0aIbzqwh163nZBXxBqTZ6dbFWqeKPoFB?=
 =?us-ascii?Q?MFqdBixcT0d2+sCPtEA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63d1a9e-ea63-41d1-555b-08dcb7a98b64
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:56:39.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0JfTtXEVOi1CioxITqI/aiOc38DnznQQ1B8LLXYFco0my9iB4TXCWDuNTgODD6z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

On Mon, Jul 22, 2024 at 04:23:14PM -0700, Dave Jiang wrote:
> 
> 
> On 7/22/24 8:24 AM, Jason Gunthorpe wrote:
> > On Thu, Jul 18, 2024 at 02:32:29PM -0700, Dave Jiang wrote:
> >> Add a software command through the ->fw_rpc() in order for the user to
> >> retrieve information about the commands that are supported. In this
> >> instance only 3 commands are supported: Get Supported Features, Get
> >> Feature, and Set Feature.
> > 
> > I wonder if we should try to have a seperate API for this, knowing
> > what command numbers are supported seems sort of general to me?
> 
> Probably a reasonable thing to add. Will you add something in the
> fwctl v3 or should I try to add something in my series for fwctl?
> 
> Wonder if we should also return some sort of fwctl commonly defined
> effects field for each command.

I'm not sure I fully understand what CXL would like here, including
Jonathan's remakrs too. Can you give some short draft?

Jason
