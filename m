Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040323027B;
	Wed,  5 Feb 2025 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752992; cv=fail; b=F2uUCzk7qLGVWN8fvdlUnSHysPT7xU5/EWk8M7ltJ713W+gsdtcUU7ZBtL6rMPBwFi0O7AmJlSLA993C+bLZR4aiiJz0hahfZIquJkHEjS2kW9yPl8hN4FAzZEVw3TkfCLsmFImT0fciUkTPy0qF+j+N8SZ6/w+0LR5RFaoy4Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752992; c=relaxed/simple;
	bh=hVkHj/MwJmZp6FgrtgpOj7S4CeWA53avQqiAqsT/zH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R25lPOjkyJCTbhj2VbRcFsM84GOb2yFOoatHtWy7QMNQ9y9Le/OJFT7kajuJpLmI8NEBalF5B4VpxYWkWSYzdBJl+2oTTCGN4RYmRxYMHtKXcrGKXy5/nCecZNukUBKW5mviCyePo1E9mD9ZolFk3t6wxsbFQQpvok5vICwJmc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pkhUnXRj; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pkhUnXRj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay/+aim2LfWDSNfltTzruzNBcCteeNOkI2O8zqCsehbrLBXvyWVHV2EZf9LsPmby8Yp3b570rwUkiFyHllxKT5AJlRHJ01VuJRQdbP4kvqCxLcIF+bTegQUH+4Dju7IWCbokpTc9xLJFjfYk0c6r6ZpSlkFe1XaRIeu9mnmDX2sutLl41Sb7mbs4spugoF9GotbFq8cjvNjpopFIj13erPYSCSr5fyeQHqDcnEiBEx4Y88Fyim0Vl1NOHnse1K3SARGLD9T1KYoisZrtrVjEMc2afHxxvMf/zttcmiBUBSKllSU/dSpcH9I9H32pfEm/wykAdsSKBZ8zgOG1XBAfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+iqGKQ7UrkTuYsRDuwhLsLzsBL0R3AddPT16D0A+wo=;
 b=pC2skGqCEpIFYI+2NrtaoGoyUS5pS1eJ0QVrwEdxCJ4dCLhujCpAtdXqcknaNo3SsdBeaFlpsPeuXwnn8rdg0xcmcxsfJwoOAwLC/UjlJqoy1+DIwOZFddih/qJf4zhd+yptzcnbrnI7+MMy8yODxg8xXt8qy22x3CcqMfaDtulHq4hHoLVF/GJ/HopQC+C1KdCtzmDdEnkGNVJhHlSZefk2roELMEy1ZZ+0UZV88zXmlNQleM8XPKIJo+Ot2rKg7u/GR41BtX2QsbINBEMH++nNJfV0+9PQJtjMObu/9+fCMHaHiyyMwI8e3MV65BVK04kq//TMyBMPZNRaJmG45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+iqGKQ7UrkTuYsRDuwhLsLzsBL0R3AddPT16D0A+wo=;
 b=pkhUnXRjoBnm+5eITM0tSFMnOg9ePSOVw64nTKh8FMhN/GeoHvsaDxK2kmCllc88nbuV4TiXrakqA9vtsHNxJPb4GKQS/YXVknTBNjlojk3CUDUmJrvkJ2ASAmM1VI5+KcHlyqIpbiWA9igehKVaMQL69zfsS9qqG2d057Ew/70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 10:56:28 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 10:56:28 +0000
Date: Wed, 5 Feb 2025 11:56:22 +0100
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
Subject: Re: [PATCH v1 17/29] cxl/region: Rename function to
 cxl_find_decoder_early()
Message-ID: <Z6ND1vbgR5Gp1B3D@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-18-rrichter@amd.com>
 <Z32lTEVg0qCVtP4i@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z32lTEVg0qCVtP4i@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 64731bda-43ad-4224-3481-08dd45d3be0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c5+pgqdGYBFl+ZG/7HbuPR/NyN6KhhnQRojPJn6ufmNpJtq0MjUe18+Uat+a?=
 =?us-ascii?Q?Av7rcKpO9cajqrvBeJ3udwp90nJUMk1kWsAWNjjxL+ZnNVplhaG89FIwLAyy?=
 =?us-ascii?Q?cmHvimn6GfmBXMG8+JyDHJDuHBcE9ivfoQhEA8Tm3fxHevIthBEsATV1CLWe?=
 =?us-ascii?Q?uHJkCWeYIypek2y8o0cGLBMZUJLsQF81LIJP3k3uszl18kOjHWc4/Bej7F4s?=
 =?us-ascii?Q?ZIoKS261MEsd0FleRTm+R2CvjyrGgo0dA4xmBfPuNCcxoX8UnU6yATSzGHzG?=
 =?us-ascii?Q?aicnks8s6cmYr5CNr7u3KNPVSHj5rgLJfQrQZrSBEBO1+4azlWk7Xkd95831?=
 =?us-ascii?Q?v7ZyP9rUe/fL/WnBV/QsAhHoeX0OH/DLN/p7n4v6gi1G7Z8ekn94NMXOF/MR?=
 =?us-ascii?Q?4mhmZNf/cMpZQEgH1JzsfLHtayGNx3UFr5ovucxIMX5ufJYPZ2J2nr2avalX?=
 =?us-ascii?Q?ZmmbF5clA4/detrnp+uPNldthHw4lEtqhd8SKHg0VqUIvi56ywwFGUs4vdEZ?=
 =?us-ascii?Q?e3Jzh6sxKVReY2u/00FsovOikAUvIZNHbbEIjLkJ94GucE7+uW0MASbmfPnp?=
 =?us-ascii?Q?7qFsxr/nafAXvy/T+5b4cmxAuzfsgY/GtsshGCFP//OOOWdRvldwY61qMzG8?=
 =?us-ascii?Q?RSWCjeLcBDKrLmQw9PAzav3kENGLRfX+EkobxQDOAcNyZtEhiJzUMU+rYAHG?=
 =?us-ascii?Q?YN6GOZZeEJX1SDNxBjNI0IyP5lyKRaFFG04TZxomVyk6Cb/csgkvQ8tfYG+e?=
 =?us-ascii?Q?VRGau9u15m3JuThFCdpz506GEttTuEAm9zpNe0aTJQWlkXIwJgPv/Ab9X8Dr?=
 =?us-ascii?Q?P3JSIFZGzlpJ2g1iyI6PahU/d3Yby7BWRzP6xKlivBzIfeHuZFAoyo/PNz4b?=
 =?us-ascii?Q?En4zkjvQ5rP5ThO6E3djiJR/XzudzlUecqyZLQBy/5tiqvM92Ptk29+u5BiY?=
 =?us-ascii?Q?QLEYE0v2wR948GvekkVvIvPa67spItcOHT8yYltimdQWfRwCa2Nn+qiUcSde?=
 =?us-ascii?Q?vuMtOb3RrwWnN3w+O/pAIuhiWewxB3H/cUFLtjh1yhRQVOrJRemhEbD3eVDd?=
 =?us-ascii?Q?idLp6yoCQr/Zf8TqSymhpJEMBQfOOECEewi9vX9i6ZPvQMISRGVrh7SPGwSy?=
 =?us-ascii?Q?KJAppdBmc0b9A8uHVNMPW3gTdZ9N8iuB0jkzD5C/GfuRqJrUyTlBsBc3R82H?=
 =?us-ascii?Q?m3aP3sST26fGCcCmty0HYKpXeESuzB1oD4O4SkdnjWE3BcRCimoqZeKHmQyN?=
 =?us-ascii?Q?h33ZrAx6kSzVBtrYpgQdA3hnM2B6rfFJrisd8uictpJesULj0GLeKHPRWPst?=
 =?us-ascii?Q?W+DxTc9dDjfKA9NyoaoTNeSeLl7D4ibkdM4wc7cvNwfLC87CrD+/eWBRAChA?=
 =?us-ascii?Q?QLIAaPg64Gf77TF59LcqtF9NQ5qd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aSTNqn+4tRZRYMBF5IyZ3qnzxkxsL1W4qq11lg83OXLhgXGGhNInjm6Kz/eB?=
 =?us-ascii?Q?aK9yectwDwZ4k70xYQ7nURlDUrdAshhCG9lsuB2HO+pn5aRsc8zOwRpQ9Twb?=
 =?us-ascii?Q?bGpzam6vA/vtOIl2xVd7AWvnUitxoHjLySJozHpy3ENh0svL7ZRwmbP7oT02?=
 =?us-ascii?Q?275m7Kz9TWtDuZHhl5qZRAF+YE2FJZvCzAGF40exYo/+tNMrhfpNN83u6tXY?=
 =?us-ascii?Q?ZGBmK+ETwcPsuKaMfm9RTDQ1bkKhbbU/IjMeuIP8/wutEpVX9RKvPtZ8ToDF?=
 =?us-ascii?Q?jqn+qcWscx8g5NIwwBxNbrwVU1qmGMfkXLl6YGpkm0EViYbag7wRPdoG8mci?=
 =?us-ascii?Q?/VHh4vgtOpAij5UjpOPbRCJNdKl7hfjmWd0xUtZ2hGK4UoOys3ZsMQ3D/KKc?=
 =?us-ascii?Q?xXPUbrFtDgCNLo/szhWcNW5GkqQncJxgSN7gFhksM3A8fFklrSfKKEMTYizP?=
 =?us-ascii?Q?oOtBsJIdWMFgUS7jo0VnAsOSIDfgit2gveW3yGAsoVzwf6xo12xn2W4619ET?=
 =?us-ascii?Q?Lvf6E0HS2l6OAYLGC9iGj/8RG0t0nMIUAHMHqOPFs/X0VkNgkJim8QrmF02q?=
 =?us-ascii?Q?3TnMDEzRuSecP/LtEtEo2ydTlIbOt8xwDvVNUJnxlt50j+E5bWLLvGee4hZu?=
 =?us-ascii?Q?tpUx5cdKftrWqwBqPh948UyH9jrFT1ExOKPF2DcfPjJmUh+Ynqb4RGokN6cM?=
 =?us-ascii?Q?WLefnVZJ7sxSuKpU2TqvOHHLuZ6MODt4cGRuoWG44neXanZj+YsUxNSHuxju?=
 =?us-ascii?Q?vV5r80vX3uyMvMOGM5voSfxEETsxWQjKXtSrv7twq9xkYBfQRVGQpqoI6Euh?=
 =?us-ascii?Q?Iz30u06KytnvZvfzjeN4eoW38rkvkeOW/syovmqbZSRoTDOUCbfj60+0ocJB?=
 =?us-ascii?Q?0B//eZbHZQSmOPjpW5xthUND1UdKs1bgvhA7VEWWt4nqD7XTi+aNdT1rCPCF?=
 =?us-ascii?Q?qIXyr8kN8nUwm8Vxvt8ExqPgonjdQY+qrtiujGqtU3eu5Qw5R/rsfqanwXDE?=
 =?us-ascii?Q?87vbmcIKN0Vtbd4jSPgH3rRUdqqjJ15FW7nfbhtfWZ6IgPo2msV8duz7w8G9?=
 =?us-ascii?Q?c1rsev3nzbL3CJs7qdFGBGJNcBdDKz4NlF7fTPEgc4lHpUiUd28frg6jAxUf?=
 =?us-ascii?Q?7ibKCu2d98yaak4vzvc5qJ+NYhOndrALTxPmvdWxG1qCKffgNgA0nLaooayN?=
 =?us-ascii?Q?yVYx/Z4G6svoQPeUzl/fVGlnqt+DK6avyRxNAyXqmFsY3pijHIt58Z7dKQv3?=
 =?us-ascii?Q?2M4CxQTqTlBLtNJW8BksPbOm82QGyslBx9yYk/Fr4hmHCPxGV4P1bheIHUBu?=
 =?us-ascii?Q?tw+rs0y/0kPbFr/fJiCssuuVscOi8wirYKzoZxj44UqvPuMSP8ci7gViYGwN?=
 =?us-ascii?Q?njGeIDJjugBCaAYomLsEr7IUbOqDXZxlIUPNfCSTi2KXP5PbD2rZyFSI/pN4?=
 =?us-ascii?Q?4nduVfDcZLXvZi2T2vk/w7SDjiZRlY0rgpy4KNPge1wXc5IaxB5KwMdS35FB?=
 =?us-ascii?Q?tckztYyHMlgWyW8oxDkr1MWCtYNMedQrgXEk+6XOtuwl+z4bIAAPMlFrz45L?=
 =?us-ascii?Q?kf4YfiviHCtne4Wswb4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64731bda-43ad-4224-3481-08dd45d3be0d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:56:28.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OJT20hPjBSGJ0bkjV1WttMI1SkuVnRWD7PXC/oDJiaLstEWpzYj/hwPJcFX510QhtIDo9vVT0i9R8fnGeVphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

On 07.01.25 17:06:04, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:03PM +0100, Robert Richter wrote:
> > Current function cxl_region_find_decoder() is used to find a port's
> > decoder during region setup. The decoder is later used to attach the
> > port to a region.
> > 
> > Rename function to cxl_find_decoder_early() to emphasize its use only
> > during region setup in the early setup stage. Once a port is attached
> > to a region, the region reference can be used to lookup a region's
> > port and decoder configuration (see struct cxl_region_ref).
> >
> 
> May want to add a comment preceding the function to record this in the
> code along with the changelog.
> 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>

I added a comment. Thanks,

-Robert
