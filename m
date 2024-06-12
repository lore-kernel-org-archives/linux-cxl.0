Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9F2574D
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167903; cv=fail; b=DC1akkDhMjzD6XtDiD365f/75w8gy1yKGcOroh3otcEEuW60cfDL+ex3IwQ+te9BCFpT4LipwSglRhLPnpvQ+qaNnGCYx6oKuM5R3BEbwFtUJpbbfekzqGvAy/UCulWxxT66lWcskpY0jv5VI6nO7jLpqt0BUMyohNzgO2Vq9GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167903; c=relaxed/simple;
	bh=Xw42f84j5gkjo6l1Pgh69NtjCRCKTh/L6rWnaXBiyzo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M5FcluBjSDr6R/7BNLVgtOFuxhB8FyMzKutQKWnmTm2s9gskaEw/bib04BRD8d6nhAYfPYMOVFzWhPaSRbmgc0V5zFvEUznWymEyw4iAByR3y4I7hb3dJWoYJTWYIYKA+PPttumcfbn+hvuv5ekMtRHzKSmmtkQ3U8ztj5ns3Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkCCxxGz; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkCCxxGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718167900; x=1749703900;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xw42f84j5gkjo6l1Pgh69NtjCRCKTh/L6rWnaXBiyzo=;
  b=SkCCxxGzQd+xXO00OeEE955DwUOe2bCt5+WmUR6KsHwNh4kAV10u9uN9
   liPoAw3+61oAtLVt++lZSTxY+FRk00+kTM2sT7KV3qtK2WUDbg4Ssb/GL
   LqCbap9/RmWPhCuwxG9yIawj8ofN03J5oTJxi2nN5NX4hKURNEASydnGC
   FyuS+xo9hk0foRAE+Cp1sQzndH88rk2vzHEYG397XnHKlIduX8svTu6Z2
   vQqStl7WbSBJr9/tKFeqAYapii/9KbCVdAe47lDwwGtgIbDExEMFISU8l
   bdVkYNy30eeEXti0v2fBN9niDLg3yadsSl5EATiyHGCrI3C6cDB6JPC0a
   Q==;
X-CSE-ConnectionGUID: uma80B3lRs+ayIrCPo7koA==
X-CSE-MsgGUID: FOscK/hOTMO4KWf/t0SQUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15136985"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15136985"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 21:51:40 -0700
X-CSE-ConnectionGUID: OuTJz2wBROCQjXEcRpB6hQ==
X-CSE-MsgGUID: cDlUzv2HRGibRo9mUsG1qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39520647"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 21:51:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 21:51:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 21:51:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 21:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewu/yAmJoSjke0xP10hnDq3kLlIx+b1kYNhEPhMLjkZjp7b3Latpoq4SIwueWvtUnsf1j1UvQz5+dfxciLZLE7AOgUJqmA4NgekSvzLgE23uv6vYtLSBuvyDvCD/UCDOiX99j9BUx1HPA61JeZDZnIAsr0OuVMlx1Oajv0FlJ9gVn3d7WCSnT4h1OQ05zcXj/nvVSv4ZvA7e4obtioXe3YIl9AhsQ7GoSwAhXDNzSk9rErjCn21dcoBhpuJ+S7ZvDYbVJNeq0/DiTCYrp0JIOAE2dodOU3Ef8nIs5MjVT+BX++aNf0ptz+FyYOrFjU4g56bTi68AC3QjCoXwVfm2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il1ZTrRya3gxa4rRU37cEP+sYFtrg1+uxtC8efrPd14=;
 b=og0BIKspCRQBIUb54mgINuAp2P4tImZBIMVTs2naoB3Cbft+bC2U0aHCgDbDMIHMheWBQsSqQgyzYwVL6JCJyn8cJA+UBjn64xl2tty+Oa4WWCnApcN27ApIhCt8li9YXzdqgz6teIvqQ5f8uuYL7aYX6CVMixWXMsti2K88oLM5kac4dGR8CUJ1/9HNUQyT2zu1yfHvTsMs4obWt5+XTajF1Qi/2lTyNpyzJAd7hc1QzoiAUDUw3uaYRZx+wtK6urSsnXfPQV1hJp1VQDX30Rm49tK3+9RE1oE0f8BZh1PBBtoMjL2VPfnxTHZB/pudaj7UOQ0VNM76BwsyUdlFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 04:51:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 04:51:37 +0000
Date: Tue, 11 Jun 2024 21:50:34 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <pieter.jansen-van-vuuren@amd.com>,
	<richard.hughes@amd.com>, <dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC PATCH 03/13] cxl: export core function for type2 devices
Message-ID: <666928a27eefc_3101294c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-4-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240516081202.27023-4-alucerop@amd.com>
X-ClientProxiedBy: MW4PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:303:b5::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b213390-ab54-489b-89ae-08dc8a9b5775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AxMvkHwvCYPlWt0+rs5Ei//HkQAK79mVDzfwzHGL1QVrXAnluqfgDghvhy8k?=
 =?us-ascii?Q?HrbO2QiS4nCOZMNnmhaLMoI2ArkkrMewJLqkyNxEMSN34zzcX81JwHHBqbeg?=
 =?us-ascii?Q?ZrrMLEqCNCgYcd+RoSDK2pVgWU6YWZTZvxKgC0uqAh3/6uPwMVPrYBtsaO/a?=
 =?us-ascii?Q?pjbAIRj6R2QUMYdjNyijBQOfd4Qjdws5nf0IcAp8zVrTgzAGji/7JiJpoNQf?=
 =?us-ascii?Q?Hah4CJcnPChcjzWJgHmCQV7LdF7N04ITalFcXLsk0A1c/J09pT2g2swRttWA?=
 =?us-ascii?Q?9YByBEW+wG6SJcV3NF007GyV1lVVJPKXh/A2nhV0DCnDTLfM/KGKYn0U6tDD?=
 =?us-ascii?Q?hOWrKNXvPHj/P3g70hRqpFUXB0zsd/s5xo1ME9LQ+n8tJJ8S21ug/yoZSekn?=
 =?us-ascii?Q?0rDiLLebwb7NwpqxgHDGmV+zQYcMxuZb2qzCO7qjqYFqyXvLgm+9SSIiJ0IE?=
 =?us-ascii?Q?YSzwH+D+ld92PLLa7Jsjhs6MawvRmi/JK9Cd+feFIFz04wbcWoHayJ7jbyHF?=
 =?us-ascii?Q?6C6kQnT13iiaq6qFFJP8aH5YRC6uooai3Sh8qKRpcWzfH83UfajXhSuBVDyU?=
 =?us-ascii?Q?lEgZBk+1nBwvqNnUqh2GqJEdlkBkpUJ8a1rLt8YHKSsVykrAE+0IGMeM2Wsm?=
 =?us-ascii?Q?7fAxXB4exLNstczYCcseUJWhBpxWLCass/lf4mNjKHfCij7IRR7U21dVMEh6?=
 =?us-ascii?Q?fDBgWS2jasj9B1jCzIqI0fOfjs3pnCKJkXpjLq5aPLXVVMaXpJ067WObUIQZ?=
 =?us-ascii?Q?mvHKxemB/PLlh3aTjbclLriq9LZ/JqAFg40+P1ra7+rvoNpAt/KN0Mr8q2MC?=
 =?us-ascii?Q?LYLcO2S/INDGGvVi/g0GUkfa/yCjxp86mlElSZW5cwc/FjeGPE61g6SVi+Gm?=
 =?us-ascii?Q?Hq1KGGuFhR9/KcYdMMTL3xpclyakSuJMWrNCmARlzYBZn6Kct583uNmKpfDh?=
 =?us-ascii?Q?kMrIvEgTtkuKm7P0hPt7SEtMTz5J1ruh+irJ7K1zYhetKfTLfl/Rpn4saV8s?=
 =?us-ascii?Q?Zi/qghQNyd+5tDWneWaZ9qISXuL81F0OZ6QHQuze3lHGw1hT3kAymb/m23i6?=
 =?us-ascii?Q?raibM4LppEMB+lvtii1Cb4vrLDE2f8NhMZfCpaK8mDUSFWZ8/ukPTFvdjcua?=
 =?us-ascii?Q?sQ4R8hjvbBPvbzW92t/28XjvQhLyGNb+htwYfoqPLaR32dWDxCejhznDBjsx?=
 =?us-ascii?Q?VHCej43d48Ttl8pxcX9VYHq4XGsi8ixIRTB8SIxes8gAHnhmU24EQlGrvpE5?=
 =?us-ascii?Q?RRJsdNM8yoCnFcJYyHzVCzU5ViU9MHecuJh80vDbc+TMjv9rEqmHA2EroiDM?=
 =?us-ascii?Q?2GHDT+aKh6FUyLVdL/59RL4k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qii3BbgxK3aA4n+F6Eu3QecnRhMoUVkkkviMMgoGIhd1OTy77GJxqU4x28fQ?=
 =?us-ascii?Q?K4PZyBgVwNp1rs+IHgA0Beb807QGSt9df+ndNk1+ovgFUX1rzO7Ffnc/Cucv?=
 =?us-ascii?Q?UgbgzaZ78/9aJ6NT/ehKdGF4DS9Cq//MJ5JPx8Os1RQ5P+u+FGwD1Vy4CCJV?=
 =?us-ascii?Q?d5lDl9NvkhjPmPsrZPhv+IscTLZCdgKu6M1Re8TdFyxKAPb2ze0DLEKXRiKw?=
 =?us-ascii?Q?J/EQH3Jfe/QZx4xei+omLmo3uoM0B/TUaQs58+QsRN3kChhIk1p8Q3FcCIx5?=
 =?us-ascii?Q?NKiZlqhcJY3HyfGNhVmlul/WyQk5Sx/U6h8CWtBpeILUoxPXiVpxl3E/EEqd?=
 =?us-ascii?Q?37+9Q3MaTtn2yBd/cQcuuxNIAZEXgZeSeanXx0cNjbN1ak1i5OTvRElOQcL/?=
 =?us-ascii?Q?FkMqtGdiYjGPYaM8pAe1kA8goZ/arAG62xP9RETc85wDbDlXJPGBsOLPe69e?=
 =?us-ascii?Q?sZ1H07lUVfHOZHAFS4hRvcivVUGGOdMtWRj+kcjTRy+KXj+PlXserpiOAeBb?=
 =?us-ascii?Q?Ngq96k6Vz3uOIFOuDjKe6swl0LtGpLxFHzrjoOg/i73k5NWTeCabvbPqHXP1?=
 =?us-ascii?Q?bGeGWCVsHHoBz5+l7TKppduMUokZfbI5qAwIJsbgXd1YPwyj65z4ZeUcJTY7?=
 =?us-ascii?Q?MMa4KanzEEJfqIe6yQnjSZqAX2t/ceRHUTdVEBPR/IiEI7soN6dIkGBuwIho?=
 =?us-ascii?Q?WD5LJMj6MX0WGqMu3ScrozSZf8IANewQv1fRtyhmWXT8BBpr3a7kyOsPt3pg?=
 =?us-ascii?Q?38DrBnmxENSzaM0H2EDfvjl8v9Gs/mDKC3e94/87uT4fWanAQCBT48oQlRJ4?=
 =?us-ascii?Q?LcXjcrq3TPiUDrXCtRPiOINahkAhI7ZqObpSt2tKI1+iVW2iRoNLVtoyVLuQ?=
 =?us-ascii?Q?PjM/8TqguKyHcNAMiRENdswGa7oDhTLCiB9MXA3FENkvsXqi8RNxWqilqtWO?=
 =?us-ascii?Q?NdqGso88hGXcKRQ5/rafLvZyuFnsF3wVlaIr30LdKwLweaY7VrwOaD30j9Zm?=
 =?us-ascii?Q?2WuDP8fj5qGs+mtEJHaoUqj8ESK1fa1hFaMdedv/JWX0CQPh9/G1OXObE9fO?=
 =?us-ascii?Q?NXIM90fwgHNS7TkmNttiTZPfgrJEZZS5mPHpUowj0EKAbP8QHa/6rdeXkjqB?=
 =?us-ascii?Q?K1m1ND/70A80jxD12rwXLJhaMZtDBCRdu3mvfcfnKNG7BAR9c1pr23bcf671?=
 =?us-ascii?Q?+XJjephk0AFm/+wenrkDD2fe2kFEZ4Z6DKhVwDO3RHQ6y0ZOoJOZ/3Fc+S9D?=
 =?us-ascii?Q?WOVhQHPnBmjwK258mVfZQOMvUVHKzcpLEbGuhINqFAc49o7kQZ2TLXDQsd4d?=
 =?us-ascii?Q?zGud2oe/apwxX8jZ5U7Es+fu0Js7VDw0SWpOZewzYoDW89J0ND9yxQ+kExFo?=
 =?us-ascii?Q?MAfjU5fAg5PwYS3iQPwqCSu/9o2e2Iuz7vgP8SBxBhlD4q8JqICt+sdVoRXV?=
 =?us-ascii?Q?byOcMsyD5QAV97fThmYRjPC5hZFrGz3roAqIudMf6/ddtSa9xllvstsVOxQK?=
 =?us-ascii?Q?lGNxIFZ5QFB5WqPWCdp1Lw9Cyuo69Uzz7a80dE0xRgFWsaoPNnr8H3GBFFa+?=
 =?us-ascii?Q?DcQcbQ+BLjAsnHBoZ526BwQG5d7aj8ARhdpF/eZYb2NuHkBQf97hyPLh+c0x?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b213390-ab54-489b-89ae-08dc8a9b5775
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 04:51:37.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jscfT36ZRs9WWxQL+8cNp8ZjCWB5WxdZ7RKf/w6tDqrddEc4boF194DidU1/OlF8wzY7IYkXl63lDF+vmnVawhYFVulKTh2m/aBA67QMz0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL initialization by type2 devices requires to use current CXL kernel
> infrastructure only available to such core code. Type2 devices are by
> definition owned by specific vendor drivers which need to use part of
> that infrastructure for initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/pci.c                   |  3 ++-
>  include/linux/cxlpci.h              |  2 ++
>  tools/testing/cxl/type2/pci_type2.c | 31 +++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ccde33ac9c1c..497276302017 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -500,7 +500,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			      struct cxl_register_map *map)
>  {
>  	int rc;
> @@ -520,6 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  
>  	return cxl_setup_regs(map);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);

Any functionality in cxl_pci that you want to export to a 3rd party CXL
driver needs to move to drivers/cxl/core/pci.c

>  
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
> diff --git a/include/linux/cxlpci.h b/include/linux/cxlpci.h
> index 93992a1c8eec..28fa4861a4f9 100644
> --- a/include/linux/cxlpci.h
> +++ b/include/linux/cxlpci.h
> @@ -130,4 +130,6 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
> index 863ce7dc28ef..b12f13e676fb 100644
> --- a/tools/testing/cxl/type2/pci_type2.c
> +++ b/tools/testing/cxl/type2/pci_type2.c
> @@ -12,7 +12,9 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>  			   const struct pci_device_id *entry)
>  
>  {
> +	struct cxl_register_map map;
>  	u16 dvsec;
> +	int rc;
>  
>  	dvsec = pci_find_dvsec_capability(pci_dev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>  
> @@ -35,6 +37,35 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>  	cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
>  	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, "ram");
>  
> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map);
> +	if (rc)
> +		dev_warn(&pci_dev->dev, "No component registers (%d)\n", rc);
> +
> +	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pci_dev->dev, "Failed to map RAS capability.\n");
> +
> +	pci_info(pci_dev, "requesting resource...");

Setting aside whether this driver moves forward vs a cxl_test mock, if
you want the driver to be chatty use pci_dbg() or dev_dbg() not pci_info().
