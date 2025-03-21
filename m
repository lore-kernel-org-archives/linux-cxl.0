Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA71D9A50;
	Fri, 21 Mar 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553000; cv=fail; b=P6UwERPCItX3RVACplwAIY2gwTTirZp0dpss/zBi2m6bz/lZ1j9ViPGClnhOsGvKCqycUGgFyLP62bla9Mjv3A9U3sQnhohTBsmKdCIwsO17rCVtp7ex41Y2bHomzcLF1qWrkWPu9f0A8V/1Lod0gRQAHKu69BHUqJsLjIvj8CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553000; c=relaxed/simple;
	bh=jzI8QMw2MuQ1dBRakS7jhguxQABOP5QQkHDTHeZSxJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pvG/OMv3qP5RMhQ3vFUBMgBfFxMKJM0JbrPWabAvbxl96pKf67UdaD1wcRtWIXJUiAUdGfucsbXzyrF13Borm6lQIbjzz4DQsrwW4aUEftdn6gdOozUwpazHHNzxcAVOiy2M7RnjBwGoIrdMZocTetwxAq97blf3a4E0afmKVW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Js3Byera; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Js3Byera"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw9j+nz3+DpTpRkpGkZpf5Zc+aV38MO64Eo+QOFg/0fnMmOHZZpHydn/bs33EPBY4exD0p/MsfxbG7NEIbaoX+a+b0ktcuO1b4UL5Y76Xac5KDZ3GVyx//X6Ce1pFNCf+l+JUZrVpvTdo6YBdHwBlIqZ4UX2TeSc6eMaCe4oeSgWaVfOyHffrQb6+8+AswhW/tICHJZtmRNqsAJsvRjdDL+bLLndhG9YTwApXciRpSN2G6DzS1s65rJybD0dLhd1+bE+S8LvErQEpb9xfqsowAbAPOw2WjVfwPShDF9Mwiwkm7/NC4xPGxhBQLsBqjXAc2J2QPX8BfLSUT3f/Ewlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXQHdvxU3U7h5VdetaWA42Nv1YYj5KhQde9EjGywxp8=;
 b=HQgGnmS/rxT+FgjLAJ/aY/qzbRweb/M6IeNyrBvocrITlsltIY9ZiTnsLKJIDkAEDBYVqCgQBhdXiujkjm9uBYkfXfnZo94W8EFaW4i5KeEqj5Tmm0yFnNDuosW5FB6JX5kdlT89jSxJ+k1tftzDl3XE+O9dwPRwMUq6oVt11Mvb3VaiXv8knxRmrwziu/cvoI+xaOIs3Ft5o6x6VYOYgNkPH/ELrJvJmjLad6x/BC7kfv770m0y2Pj1fJQ2nR9wmCFD+mjby15jdCiqRVGVRKcoFkxV8WsGSyOkMSnoH0Hik43FUqHSVM9vJLZaJqytZdqaXR576ehbeIyQsbLuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXQHdvxU3U7h5VdetaWA42Nv1YYj5KhQde9EjGywxp8=;
 b=Js3ByeraQ8ddf528jKmWED3LIFZCUxqatXR+H5m+jAf/Llb9ERrZijW1pmntvjpx85dtnQZxQOmRIEcH3fbH7fLM91RdpLMhNEpki4s/rDNtY0Uw8zfwv1ON1EZOnBN1p1Rhy9/9biEaj4wlm6DZebb/kVkv+LxE8miNnT6Bp0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 10:29:55 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 10:29:55 +0000
Date: Fri, 21 Mar 2025 11:29:49 +0100
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4 v3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
Message-ID: <Z90_ncUzI20TGfq4@rric.localdomain>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-4-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-4-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 477be98b-081c-4698-094d-08dd686352dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eP6x7i9REbj+8vIH18fSKFnktP/Eb915742faWacUokVgpEkIYq/SuohS8tk?=
 =?us-ascii?Q?tt9r4ABPV3SMF/lAtdOQKlQmbg6pj7k3pUYwSR1/WxdqaZ/Bz1K8Q5uZgOB7?=
 =?us-ascii?Q?gNMprW/gxthtRxzg+2NBbVY+Isf5SyfHZioaQdgjFl4CkoEnGBU8SCsBn5bI?=
 =?us-ascii?Q?SK3Ru0uiIcQM+Zu/ZDXuBLlgMSi3EfhywEsME81XfwTWhV5Bkh5W3j2MZUxu?=
 =?us-ascii?Q?e5+n7laCxZSBvNR5/mHxPjHYdWzo01n37r/pMGAiwqKMH2LimZNzcLomVbMa?=
 =?us-ascii?Q?aZXaJNTI68HL4t77pS6Si2Vkms8WunH3RxMCwj57vFlIrtK5Uty0ZxYBruG9?=
 =?us-ascii?Q?1HHcHKh5reET1Nov0Mjhl4Be7+9yQKtsca/DKCg03TKI9QcBCNery/TJ9mYP?=
 =?us-ascii?Q?3LikteuB84berqNZ+2Xsvsyo5FH92edHDwzwckGYSdBQ9HfrBoGTu4FvSKbM?=
 =?us-ascii?Q?5TSnVfTDwGl+WqRHlowUdY41+0ZMyOj8fkvoktUCKc29y6yERu6P3Nw3DP9c?=
 =?us-ascii?Q?XpzuecWZW0uJKivZdBpIB2bVd5UErawEYiiqpDZCm67ZQQfiZ4cKsq9HgUwK?=
 =?us-ascii?Q?Xz3unFt1h2BbEQp5HsE9SHQT9gtwMWS9pqWvN+Oy1YIsVRLvnigO5/ASKYLd?=
 =?us-ascii?Q?7cMCB76gz0TKuqlwmRQdw0SoOSi8hvDM8trgIZ7jw2RK6+VxGL2uwFr16vg1?=
 =?us-ascii?Q?FOt/ZePF5c9F7A940AnxatBXtxaePa44wHsBUraz3K2Gv8bVLnglfoDDqaq6?=
 =?us-ascii?Q?rlB/p/zbzACjvslChT/Yt5YLWj4MIgrSBf90/fufaRAa5PEKBot5OkRaIOQi?=
 =?us-ascii?Q?dMh3UPv24bBOtygamDSg2MFEankdgep2JCqL8LFPxJjyd3C/lCJJFhJ75rqn?=
 =?us-ascii?Q?oOpimm4GxPZI4/mQ4y5khkE0SH4BEqNam7ABkqDel23lNuNcQU1yec2egZ9g?=
 =?us-ascii?Q?2AEfJLvSqyQjGTc8bYO5h862nqyezs4R1B4KNlN8ZEBszph7i7L2GlxliETT?=
 =?us-ascii?Q?paZVsNZy+iI+yW2aZe+DAxjHYeFWNdOFG2bF6vOJoWm6vawNVSbdNkJPeVht?=
 =?us-ascii?Q?KXmILjSM+ypHsHmnjVAC0saU6UEkWzyb87YvjEAqZj1NOwUY+Kn5aBxUoz/H?=
 =?us-ascii?Q?YiZ2jRMkXdQEQIoGfJ1L0lnhW5xUNJmzaUoQG5HFUfHqWt2D5g0o+tHZLWXw?=
 =?us-ascii?Q?vPnuciTCgOcUIVRy65GWk4w6qM8etA4cW9ywHv6YnTkTnxjAlK2l8FmNNh/m?=
 =?us-ascii?Q?a+YPIUCdcsoBk3tEcdmBg5O2Nj08wMj5GZ8lvCrgLRVKJghtbuiND8Lg/tqx?=
 =?us-ascii?Q?7fgOyS54gxBkagHrN9tkO8oF6V3riZ0XWxzvbLGOcN/9toV5fdAFjGJZ2tas?=
 =?us-ascii?Q?vgbH0ulvHDK1fRZGr2IhER4fpBUB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yVCEct8EaoSg9n/vFdJ8aeqZ52JkKuxJX7OadhcEd7/03zWnEfxhgSUwbzp6?=
 =?us-ascii?Q?W7WNoJH1x+OHB3YrVHuAEkfPU6vXtzGDLEN6LpDB82avCOaj8PFptE2a+tBZ?=
 =?us-ascii?Q?hucj9JY9Lc9pmRHgfb+ak9RUeZCM6K1nGDVYmAwlYHzlE+4tWhW15+RoXza2?=
 =?us-ascii?Q?UXAHoXvEDOzaYq9TYGKCQNh53G/IyIuZGcChftFv1/8XYihgijdNxoMnxEj0?=
 =?us-ascii?Q?NLZeyUsExUBAFTKeNiQh1pq0X3SfEmD5LbPkZesdIPhLtPfD+a8vFm7umGbB?=
 =?us-ascii?Q?30CCeAch5ZWewFF4RRUtZc5+WHdeBQgKWow9slrFNSDwNBBkMhHrECWNNFn9?=
 =?us-ascii?Q?/kVIU22K3yPUP0jSduNeebgJGelN3pa23j5MebzYjWTw4vsmLvIkhoXUaukW?=
 =?us-ascii?Q?4Y4+fNCOfS6SJ+mF/x85r3kvq949CGXjP/94vruGfgRg6L90SekB72nElaEz?=
 =?us-ascii?Q?yTmUlRs+rKZN1yMaHo5DYzV5snfl/4Zic82RXwWTV1RunraCgVTVOeoQrW1+?=
 =?us-ascii?Q?FnO+QNpeqeDR91wgssIZ4aIjdS/8WX+aqI+myJPWHe5iAHcZW5d4/1Y9Uc/f?=
 =?us-ascii?Q?vQq4nMWpt+ztnG/KK8mpsfMAJoEDDPsn+btnZpRnnRzoYtx9QcPmBA4Mv1dd?=
 =?us-ascii?Q?HwrH97DcdraJ57keKJ5pcEQnd2m5+bZEyD9LJ4D0azju0Dc+1met9BBWKjpe?=
 =?us-ascii?Q?m+vH2dzbqEzX8ar319bNEanQZ7MHAqKy3yU6i8AwEZNHcccKjJI1IDRmBi26?=
 =?us-ascii?Q?i7kB34gmz7dJfxtx3RKiGqavn30aeOGEuTxtPcYNo+AJgGz5S6v/5NEepdmy?=
 =?us-ascii?Q?/kAhbUnkynYu06YwkNjqn3mPmm8dIFZsyuWzUPLUIq9ZbMEZx3gOpVQnF9T3?=
 =?us-ascii?Q?l4SXS/K5Y4SPy521h3QI+FNSCFZTop8o0pQhUwOSfSPOHlNC8aHMSjkjIIeD?=
 =?us-ascii?Q?Ro11Plf1IF3OjsiTHBiklMNV7hsAIpU7vBwMCVHUus3XRtZWmgxtv6butPAu?=
 =?us-ascii?Q?LOeuaIl55AHmXHbhorFe9AOlivhEko/IQPI0/Kmx25XaiyTlYg4J7g33a7MJ?=
 =?us-ascii?Q?Lwh7NVmw5PbX2m4+1huoWOwSWMIQQGOWJrJ9AEPMdMQrvFBiepwGlPiqdUWA?=
 =?us-ascii?Q?2PSHqq+PqVQWSv6I5foF6C+ITJ1sjqCvlD3fmBRJF8dFLSNYV7tp3Tq82+Ch?=
 =?us-ascii?Q?MCBmjCOnNXAGirJrcP5fm8nFAd4+aBNjPqffS/z06qSD/LmOPOER6EUd2GRT?=
 =?us-ascii?Q?bWM3HZui4w1CQFO50l8GKZgauZkcbyfyXWTn/gUCCRnjDF0PxvNAfGvsng/a?=
 =?us-ascii?Q?mefe9dBJTxUz2ZsckTSfV6cIkVAH2dHicr0HvEWxT+z4KwVpVKPSyjQwWP8N?=
 =?us-ascii?Q?Z6NCQCGUBFVAoj0edAm1eN4+WcCnYRjnhwTRQfQ09xTyUo7uGxF/FCkp2urr?=
 =?us-ascii?Q?xaibRpMASXDwyU0RHJOOo0TIAMV27P64gmTTP3dKs5ujDMZtZyadIQD4EktD?=
 =?us-ascii?Q?kb3x8GU466O9v1tEfHWaeVviE8KO0wvRDPoWH4fejBXu8cV1vzNclBmoAV/I?=
 =?us-ascii?Q?kIbMw7iO+aYhrLRktaeTVWqvLZSpjHnPsagQMiAT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477be98b-081c-4698-094d-08dd686352dd
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:29:55.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwIjYWPi0NDZE4sc6YSsNZjDcS3qe2BDG2gQWRJBFqkQJoYOoyiq2Bu4R8rOQIZTDMuKuiMBRL1eW6V5lHjMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074

On 14.03.25 12:36:32, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some cases the size
> of that hole is not compatible with the CXL hardware decoder constraint
> that the size is always aligned to 256M * Interleave Ways.
> 
> On those systems, BIOS publishes CFMWS which communicate the active System
> Physical Address (SPA) ranges that map to a subset of the Host Physical
> Address (HPA) ranges. The SPA range trims out the hole, and capacity in
> the endpoint is lost with no SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, cxl_add_to_region() fails and returns an error
> because it can't find any CXL Window that matches a given CXL Endpoint
> Decoder.
> 
> Detect a Low Memory Hole by comparing Root Decoders and Endpoint Decoders
> ranges with the use of arch_match_{spa,region}() helpers.
> 
> Match Root Decoders and CXL Regions with corresponding CXL Endpoint
> Decoders. Currently a Low Memory Holes would prevent the matching functions
> to return true.
> 
> Construct CXL Regions with HPA range's end adjusted to the matching SPA.
> 
> Allow the attach target process to complete by allowing Regions to not
> comply with alignment constraints (i.e., alignment to NIW * 256M rule).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/Kconfig       |  5 ++++
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/region.c | 56 +++++++++++++++++++++++++++++++++------
>  tools/testing/cxl/Kbuild  |  1 +
>  4 files changed, 55 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 205547e5543a..3bb282ef01df 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -139,6 +139,11 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +config CXL_ARCH_LOW_MEMORY_HOLE
> +	def_bool y
> +	depends on CXL_REGION
> +	depends on X86
> +
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 139b349b3a52..3dccd3c224f1 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,6 +17,7 @@ cxl_core-y += cdat.o
>  cxl_core-y += acpi.o
>  cxl_core-y += ras.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
> +cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += lmh.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 97122d645cc1..9eb23ecedecf 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -13,6 +13,7 @@
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> +#include "lmh.h"
>  
>  /**
>   * DOC: cxl core region
> @@ -835,6 +836,8 @@ static int match_free_decoder(struct device *dev, const void *data)
>  static bool region_res_match_cxl_range(const struct cxl_region_params *p,
>  				       struct range *range)
>  {
> +	struct cxl_decoder *cxld;
> +
>  	if (!p->res)
>  		return false;
>  
> @@ -843,8 +846,15 @@ static bool region_res_match_cxl_range(const struct cxl_region_params *p,
>  	 * to be fronted by the DRAM range in current known implementation.
>  	 * This assumption will be made until a variant implementation exists.
>  	 */
> -	return p->res->start + p->cache_size == range->start &&
> -		p->res->end == range->end;
> +	if (p->res->start + p->cache_size == range->start &&
> +	    p->res->end == range->end)
> +		return true;
> +
> +	cxld = container_of(range, struct cxl_decoder, hpa_range);
> +	if (arch_match_region(p, cxld))
> +		return true;
> +
> +	return false;

This reaches a complexity that cannot be handled in a couple of years
or even months. We need a maintainable solution for all this. Esp. the
use of callbacks or handlers enabled by platform checks would help to
better isolate the code.

>  }
>  
>  static int match_auto_decoder(struct device *dev, const void *data)
> @@ -1760,6 +1770,7 @@ static int match_switch_decoder_by_range(struct device *dev,
>  {
>  	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
>  	const struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
> @@ -1769,8 +1780,13 @@ static int match_switch_decoder_by_range(struct device *dev,
>  	r1 = &cxlsd->cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	if (is_root_decoder(dev))
> -		return range_contains(r1, r2);
> +	if (is_root_decoder(dev)) {
> +		if (range_contains(r1, r2))
> +			return 1;
> +		cxlrd = to_cxl_root_decoder(dev);
> +		if (arch_match_spa(cxlrd, cxled))
> +			return 1;

See my other comment in patch #2 to simplify the match functions.
Applies to the checks below too.

> +	}
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> @@ -1978,7 +1994,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	}
>  
>  	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
> -	    resource_size(p->res)) {
> +	    resource_size(p->res) && !arch_match_spa(cxlrd, cxled)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s-size-%#llx * ways-%d + cache-%#llx != region-size-%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> @@ -3213,7 +3229,12 @@ static int match_root_decoder_by_range(struct device *dev,
>  	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	return range_contains(r1, r2);
> +	if (range_contains(r1, r2))
> +		return true;
> +	if (arch_match_spa(cxlrd, cxled))
> +		return true;
> +
> +	return false;
>  }
>  
>  static int match_region_by_range(struct device *dev, const void *data)
> @@ -3230,8 +3251,12 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	p = &cxlr->params;
>  
>  	guard(rwsem_read)(&cxl_region_rwsem);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			return 1;
> +		if (arch_match_region(p, &cxled->cxld))
> +			return 1;
> +	}
>  
>  	return 0;
>  }
> @@ -3319,6 +3344,21 @@ static int __construct_region(struct cxl_region *cxlr,
>  			 "Extended linear cache calculation failed rc:%d\n", rc);
>  	}
>  
> +	/*
> +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> +	 * platform
> +	 */
> +	if (arch_match_spa(cxlrd, cxled)) {
> +		dev_dbg(cxlmd->dev.parent, "(LMH) Resource (%s: %pr)\n",
> +			dev_name(&cxled->cxld.dev), res);
> +
> +		arch_adjust_region_resource(res, cxlrd);
> +
> +		dev_dbg(cxlmd->dev.parent,
> +			"(LMH) has been adjusted (%s: %pr)\n",
> +			dev_name(&cxled->cxld.dev), res);
> +	}

See my earlier comment on squashing both function into one.

-Robert

> +
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 4efcc0606bd6..3b3c24b1496e 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -64,6 +64,7 @@ cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>  cxl_core-y += $(CXL_CORE_SRC)/acpi.o
>  cxl_core-y += $(CXL_CORE_SRC)/ras.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
> +cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += $(CXL_CORE_SRC)/lmh.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
> -- 
> 2.48.1
> 
