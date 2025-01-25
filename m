Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8541EEA43
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737770918; cv=fail; b=rHPPiUNpxj2Fmx8Aoego5MKMK7PwhNfk0LhrOlIOHoieMD093OU1sQJzNh4wQA8FCKkjor/5j0WJY+TzFgDaPOiYMunOv+ANBXw3Sk8qx7YcLEeNaxod51aIye39NLQaX2soPzUmwo8kjmq8blwxM78kqYqTY15RIBkPfNMlXhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737770918; c=relaxed/simple;
	bh=XlYI99/zgXhHbRt1fni/JPRFZ5GocVZEmMOIp1vj+6o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VsJuHLbYmkcv+I/QXe4ItNJma4B//Tg4I9J6/mnJqvZ4A1XA/qtK0kEmJM4wia8C1u4i42RLeMw7qBaX769VafhVo8vxSoCWAVsu2weBmpftJxlRcLd2n6PNJyjjigrz8DgoZ9D/2zgTqaRPMy5WN+LKUwB/sGF0zvHDorCdeko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7BMMmA1; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7BMMmA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737770912; x=1769306912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XlYI99/zgXhHbRt1fni/JPRFZ5GocVZEmMOIp1vj+6o=;
  b=C7BMMmA1+mPNSxsDZoufZjUMm/faTycnD3GOxmmylP8hJzTDoogRp+Kz
   DOi2Obf8D9gS0gO66skiRWGWHBSyAN+km36SZS5fqhFGUdm1DmzjAbqXU
   K1wd59z9Apc+TfEjuj1kLqRSWBDUQLjuIN2wu2ytOn/Qi0X5Qlnpvi4b9
   k/zQ+B5twSiq1xEvdNIV40yF+1VWgdVvPoPgd7nVhveL+yTMuf8at9QIL
   9zJqKlwYag6Dhan4rflKHMx0NXe4CVcVlPJay0hzIbdl+Rs0WHOpADiSh
   3wZLao1SpriELDd/q6cfspFYeE3RnIgpXlK3Y1PEUQfX7sNRZ2A026l1+
   A==;
X-CSE-ConnectionGUID: 2S+H2PrmTi+k2D0V7EASlw==
X-CSE-MsgGUID: xm/3vd1WTZirMUJSMzQGZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49305178"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="49305178"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:08:32 -0800
X-CSE-ConnectionGUID: vrxjHHFhQUCBtuRDNhy/SA==
X-CSE-MsgGUID: I7l+aRyLTXm1No1PAbLODg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112870227"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 18:08:32 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 18:08:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 18:08:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 18:08:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flkKwp2azLlr3Yzre7SLhjcQYkFdKcoO9WvlOA2C7rFfQLdpU3CqarEUrNOHzk7vpt4HPbHpH8LDIzyHaj6ATxLqdsF2Onmp9aDxEo8bs+uClDkf4SEzAIntukBInDP7l++LcunHCqbbH3vsbnE5uhg/JyP8esct8jdJkJsRgOz9wfvYJBVN7OWqiEKcniW51jj4RltWtPdep79SW6asbNtlgF9aYF2nrH4qP2dyG3CzlGMh95NPmYWjla6XUml8KNZgkFRL7d97ACPYWOaNQ5Z6+aEgFeh0gDQeuS7LATn6V9AeWiIcxKFvFT58QDROsYwmeNKEJY3MnC4ERkYpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feraXdLrY2XNp3+HmmSDV1Fy8AHiGmcHaSk/X8US5gs=;
 b=RHen+YO7L83irGTybIG/XRnjRE/1pUCO+k6z+qaj/K1E1FqhrW9W9uj6rVWCFq7NEEsrR4aoDIlYiMwjyxGUHFz8TxJtMVB9I7nEkAsUuwjdUtNKSuhovhnqp5XOofV+NgPZsbEeDlVqbWnktrsWlXgqWxA6T0TYoNBw9yChaQogR9qW0AARf45hRn9WoUzWVQyNjP7HXFaZ2YKyoKkPLe9sEEc6r/uxHYXI0FhReEOsCGHlFiN3dln+gjHTXcj/I7BRGCjlEF1vhK3oo78xYrgsGJMC+JlV8zd6wQYTb4qx+sWCj8UvMikyp9ALb4IdLhXaimKD7R+6InVQM1/3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 02:08:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 02:08:16 +0000
Date: Fri, 24 Jan 2025 18:08:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-15-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-15-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:303:85::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 5baa2b45-c6a4-4c95-c476-08dd3ce5214f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kXC2Flp9PY9DlX2kyBu9OHuncle8zfGFjthrGBvrw/8EKns/yvgiDvpBc2zm?=
 =?us-ascii?Q?Ro1BXn2kckYCjZznKJTyoOmQPopHb6Oj/lmMINibJFXMAQdxGW317NMopFPZ?=
 =?us-ascii?Q?49OWmDVval/CigZuuVjZw4edEgBw3Z9g5gfC+jBUz3I3F6y/Hv/KU2C8mtfJ?=
 =?us-ascii?Q?GwbstOorm4kWwkmWLj3ZU4Z0Y6qvSG384cSrfBXelaNgkX4R00i1aHnKleX/?=
 =?us-ascii?Q?OGyNZVC/UyhevuiKdAaGPillISNMSNnZEhOR7uOi8D8yh43Bj8nYme4KOig5?=
 =?us-ascii?Q?6zaZrDp/OBtsL2GH1PsfHfI5n+KvWVGTgrcoRNETLYTUONyUFyOm/RGUM22z?=
 =?us-ascii?Q?haVSeHcOLT50aQVe7UCwE50UxR45rBLAZ26kaI2gQmhBISOjsdPnWN04JYrp?=
 =?us-ascii?Q?d0JdqhcSk810Ff54apUOtg3nlLscnZPPkQ+r2luk8QWzzRHInMKrgfzaxkB4?=
 =?us-ascii?Q?lNcqtGhv3KlnHiD1+pQe7fQgpdznZkMJ/hNYbPrOsusTYYTBX6MVNo88Q4CG?=
 =?us-ascii?Q?hQH8gF8FdCNql91jCcADa6bGkPy6/lRmX9fl1OUxDwQfpB2h9PFOKq0gxX2/?=
 =?us-ascii?Q?syIOPTJy6Oisl26Iuc3jbQZsBWwRSTOQJ1MiP/ZMuzwOk5zjz4DY9dr2jvKy?=
 =?us-ascii?Q?qE7GozmWg0UzfQJF1Kk73SAE9wT/UJJKpnrAI9XZroi2UK9Kd5tjEczRi5JM?=
 =?us-ascii?Q?Jhsf8g+DkdhL2+0yhKclaedyAGdB4o8AIeFeGCtSP4SyhbmqF1M9BRrr+aco?=
 =?us-ascii?Q?UauEP9Wrsro1RmYVFirO9e6RQjHythVz48VXVzNWVCMIgwbi5+lR/q4KGc8L?=
 =?us-ascii?Q?8+0nuW/Qc9PXjjKJ7I/dpeXVJVa2DBQ2wXpny8f9tSUsT858+SL7BXpBdMgi?=
 =?us-ascii?Q?EA20hHtJ2HLG9YKDIGW0PFq8MUslyNd99itFEKWAVhptSPoDtegv2CqfiVIS?=
 =?us-ascii?Q?DRQFODx0tNhxflfit2TsQPvS9VmO9ySR2UPrWsSLfBTIpFqkLHr3v27NmV8y?=
 =?us-ascii?Q?le7GGkZ9rpD3qPVfp9FbaDpuHMMjAUPkwy3QJuKy48XFEa0TG0TQBuBfL6v8?=
 =?us-ascii?Q?lHgTT/rLG+84YCoYmNbBCn9pBlmE5JnsWHdtBBIx6mh5guzU5WYoi4mfzw5u?=
 =?us-ascii?Q?haUk4BSC/uBCGedSPU2j2kF1KwKeiBFBh4DwUtUxBZZ+ghCtQuBePuSQkwUP?=
 =?us-ascii?Q?NmrSHs/Mplbd8PyplELMpW1ThTU0ddu1nDRTHXtgGcunXUoQUcATgd0hzMI/?=
 =?us-ascii?Q?u2JY7BFXNZwK78zQKqELt4eNfNn8u2hUnt5wC9uDI/YVrnVe8N3d9Q7mnkuV?=
 =?us-ascii?Q?1j51U0BuvTTjT+Z/NjS1YJ7WXYVb7fR73CFMBdfZhAyb95n2k7CpwVkgkH1B?=
 =?us-ascii?Q?ALKu8SfJx2UkD5US/v9MeYT+2p+C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pP54UtKBPVhW9m3pf9J1aBsuJzAv3xf+9bRK6fu37ol3EoNgsk4sxXHYnbxC?=
 =?us-ascii?Q?MlKbBa/5SWh2P2jU+E1kp8qj3DSEek2xnR/YAQ9kZaF5nstY/XjUWXx/g4Q0?=
 =?us-ascii?Q?OxjfTA5VHP9dTVgXtuBjw0B8MSxQY2YX1PnIOEur06d4eXJOAMTztgV04Cex?=
 =?us-ascii?Q?9vs/Xk6mbyJ752P9rjD0fI2bkkUFaNGKroscyFEvrnIufztLVOnVfG56a5IT?=
 =?us-ascii?Q?fD3lNfy3yuYeRUbZGQDuMImVwUwl73DjLlExowbvqxSVlneKuYKdOjeWjMfn?=
 =?us-ascii?Q?tQyINH9Wy7co7Bo7yScIlEe8Z4Vdzx0/HzlL8hW48ZZ+RCUeUHmBY2u7QrGc?=
 =?us-ascii?Q?hf9eUDRxeJQtJirFHkf2bBQk6J8jky5bSW53a5wp3en2/KepOIXZoorDEa0r?=
 =?us-ascii?Q?i9E878fYKDk83OKjCEUo1n+LAZ/W/nZeOyOtVWFVUrkYeucajovt7XjNkHsG?=
 =?us-ascii?Q?nSiJj+Vfl7dvIt2wjQswu4yRztnqVcbqscBYvgFYbJ2z+B/uFpTZ7KHOqx4/?=
 =?us-ascii?Q?S20UpUV0MCnI5SrtIZJ6UcLJ3qKXL0fORB36VTQ9GU/QKSbF/JPq7j8e9kVb?=
 =?us-ascii?Q?MMPHgS25pv7rkbvAIJEWmnKfsQO2DuZDooW/fXjUAebw8nLr03IcnqMJbel6?=
 =?us-ascii?Q?8ej50i9aDNWOYd5SZ3TuGSwr64PS6M9AzB9c2ZI31wykGQrO9kzO4ysNJsUn?=
 =?us-ascii?Q?YPk9tgW0jid0nfHZESKBrMIZTsXDTx6RPqJAVAYaiIxveM6vvd+WWNjSrfCv?=
 =?us-ascii?Q?G4/dZVELseBF2wbq+gWNiv4bmdaQJpQX34aAb98UlMpvB+c0rOtRBA4V9unJ?=
 =?us-ascii?Q?H8cOgzkEwgZQo8RKRnRlltKfLSW0aBROtIRJ9QKpbt7kmwKyt7/NVh06pQfg?=
 =?us-ascii?Q?2Bit19Ufo4pO4i497WUHROW/hP/HiqrwQG5p2vqPWtPGZZvCVQQj3+OH3vIB?=
 =?us-ascii?Q?z8cBfZBo8RkC8NNryjdodSBxATs7IRTdOpjdjPUWaMG8JculO6owvyI6dNve?=
 =?us-ascii?Q?RdE2sQ4EwS6xvbCTSZopsqQuwCcCYCQ7nPu/BkIVZFOXVO8lIfRc3uenQ5Oz?=
 =?us-ascii?Q?kCj/ZjO+wjrvCv8kxG1qTMkWQfLaXBwiLPjYtI+8uvAKJfh9108q2aTXtEHj?=
 =?us-ascii?Q?gKk08DCk4iMgVWqKauFClIwyvNCCSPmeMxPeon9l2pUKK2j5WjTlRm0cQ87t?=
 =?us-ascii?Q?H7tMDzlEHYGjRbx1wK3/tVZ1dUq3h8QRuPFjyGf8VKdUBrdHNJEHHwa3KAOG?=
 =?us-ascii?Q?qlo9DmhTchoiuBAsENfWlkr0iy6uHN7JDKv2M+gJ9XzT6IHhGbk0z1Igw/ak?=
 =?us-ascii?Q?GBs5Qpk9NAbAL56u3Lb+HFTire1ctld878oFFCHwUYQ30a9JeJtociUnyYnk?=
 =?us-ascii?Q?mw1yYcX/Lzyp8hhPb1xAqfujnIjQKMYzkIYnToP+fLe2/bFYALmxfp/NTtlK?=
 =?us-ascii?Q?kpKrj4CPiwf+Z7Qgao+p6z52OOSUAtn2i/sA03TNOHUozZLSTpavv118gFeC?=
 =?us-ascii?Q?kKUsdS2nnNA5751TaNywNLj81S5FNU2CrP3HaEtzHWi4007NRdTrbRJ9Q7a8?=
 =?us-ascii?Q?sZ/xRqGw+ugzfPvTOy3GT/ygmofxvq6I4rJ5LdL+Dj069wBNRsVYZvShFve4?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baa2b45-c6a4-4c95-c476-08dd3ce5214f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 02:08:16.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikjizMD2yUE2UhYMrEQkBmG4vvzWZx9ZuVEUQgUWNjzPx7nZlzDmyT3mtg/wnE/cDkGrfrdOqzJJ3nV8ow6nZKcWWqNsEH4UJIDUVSDGiMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> of the feature reported by Get Supported Features call for the specific
> feature.
> 
> Only "get supported features" is supported in this patch. Additional
> commands will be added in follow on patches. "Get supported features"
> will filter the features that are exclusive to the kernel and only
> report out features that are not kernel only.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c     |  12 +++
>  drivers/cxl/features.c      | 198 +++++++++++++++++++++++++++++++++++-
>  include/cxl/features.h      |   1 +
>  include/uapi/cxl/features.h |  13 +++
>  include/uapi/fwctl/cxl.h    |  29 ++++++
>  5 files changed, 250 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0b4946205910..f818e452dbca 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -246,6 +246,18 @@ struct cxl_mem_command *cxl_find_feature_command(u16 opcode)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_feature_command, "CXL");
>  
> +struct cxl_mem_command *cxl_find_feature_command_by_id(u32 id)
> +{
> +	struct cxl_mem_command *c;
> +
> +	cxl_for_each_feature_cmd(c)
> +		if (c->info.id == id)
> +			return c;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_find_feature_command_by_id, "CXL");

I assume this will go with the deletion of a cxl_mem_command array for
Features. Just do a simple hard-coded switch statement.

> +
>  static const char *cxl_mem_opcode_to_name(u16 opcode)
>  {
>  	struct cxl_mem_command *c;
> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index cc72e73ae8d6..e65fc8479d21 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c
> @@ -50,11 +50,203 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>  	return info;
>  }
>  
> +static struct cxl_feat_entry *
> +get_support_feature_info(struct cxl_features_state *cfs,
> +			 const struct fwctl_rpc_cxl *rpc_in)
> +{
> +	struct cxl_feat_entry *feat;
> +	uuid_t uuid;
> +
> +	if (rpc_in->op_size < sizeof(uuid))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (copy_from_user(&uuid, u64_to_user_ptr(rpc_in->in_payload),
> +			   sizeof(uuid)))
> +		return ERR_PTR(-EFAULT);
> +
> +	for (int i = 0; i < cfs->num_features; i++) {
> +		feat = &cfs->entries[i];
> +		if (uuid_equal(&uuid, &feat->uuid))
> +			return feat;
> +	}
> +
> +	return ERR_PTR(-ENOENT);

I expect user space to be surprised that it is getting "No such file or
directory" after successfully opening the fwctl fd. Just use EINVAL for
attempts to access Features that were not captured via the init-time Get
Supported Features.

> +}
> +
> +static void *cxlctl_get_supported_features(struct cxl_features_state *cfs,
> +					   const struct fwctl_rpc_cxl *rpc_in,
> +					   size_t *out_len)
> +{
> +	struct cxl_mbox_get_sup_feats_out *feat_out;
> +	struct cxl_mbox_get_sup_feats_in feat_in;
> +	struct cxl_feat_entry *saved, *pos;
> +	int requested, copied;
> +	size_t out_size;
> +	u32 count;
> +	u16 start;
> +
> +	if (rpc_in->op_size != sizeof(feat_in))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
> +			   rpc_in->op_size))
> +		return ERR_PTR(-EFAULT);
> +
> +	count = le32_to_cpu(feat_in.count);
> +	start = le16_to_cpu(feat_in.start_idx);
> +	requested = count / sizeof(*pos);
> +
> +	/*
> +	 * Make sure that the total requested number of entries is not greater
> +	 * than the total number of supported features allowed for userspace.
> +	 */
> +	if (start >= cfs->num_user_features)
> +		return ERR_PTR(-EINVAL);
> +
> +	requested = min_t(int, requested, cfs->num_user_features - start);
> +
> +	out_size = sizeof(struct fwctl_rpc_cxl_out) + sizeof(*feat_out) +
> +		   requested * sizeof(*pos);
> +
> +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> +		kvzalloc(out_size, GFP_KERNEL);
> +	if (!rpc_out)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rpc_out->size = sizeof(*feat_out) + requested * sizeof(*pos);
> +	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
> +	if (requested == 0) {
> +		feat_out->num_entries = cpu_to_le16(requested);
> +		feat_out->supported_feats = cpu_to_le16(cfs->num_user_features);
> +		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> +		*out_len = out_size;
> +		return no_free_ptr(rpc_out);
> +	}
> +
> +	pos = &feat_out->ents[0];
> +	saved = &cfs->entries[0];
> +
> +	copied = 0;
> +	for (int i = 0; i < cfs->num_features; i++, saved++) {
> +		if (is_cxl_feature_exclusive(saved))
> +			continue;

I think it's fine to let userspace see that exclusive features are
present, just need to return EBUSY if userspace actually tries to use
them.

> +
> +		memcpy(pos, saved, sizeof(*saved));
> +		copied++;
> +		if (copied == requested)
> +			break;
> +		pos++;
> +	}
> +
> +	feat_out->num_entries = cpu_to_le16(requested);
> +	feat_out->supported_feats = cpu_to_le16(cfs->num_user_features);
> +	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> +	*out_len = out_size;
> +
> +	return no_free_ptr(rpc_out);
> +}
> +
> +static bool cxlctl_validate_set_features(struct cxl_features_state *cfs,
> +					 const struct fwctl_rpc_cxl *rpc_in,
> +					 enum fwctl_rpc_scope scope)
> +{
> +	struct cxl_feat_entry *feat;
> +	u16 effects, mask;
> +	u32 flags;
> +
> +	feat = get_support_feature_info(cfs, rpc_in);
> +	if (IS_ERR(feat))
> +		return false;
> +
> +	/* Ensure that the attribute is changeable */
> +	flags = le32_to_cpu(feat->flags);
> +	if (!(flags & CXL_FEATURE_F_CHANGEABLE))
> +		return false;
> +
> +	effects = le16_to_cpu(feat->effects);
> +	/* Currently no user background command support */
> +	if (effects & CXL_CMD_BACKGROUND)
> +		return false;
> +
> +	mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
> +	       CXL_CMD_DATA_CHANGE_IMMEDIATE |
> +	       CXL_CMD_POLICY_CHANGE_IMMEDIATE |
> +	       CXL_CMD_LOG_CHANGE_IMMEDIATE;
> +	if (effects & mask && scope >= FWCTL_RPC_DEBUG_WRITE_FULL)
> +		return true;
> +
> +	/* These effects supported for all scope */
> +	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
> +	     (effects & CXL_CMD_EFFECTS_EXTEND &&
> +	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
> +	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
> +	    scope >= FWCTL_RPC_DEBUG_WRITE)
> +		return true;

Looks good for the known bits, but this needs to return false for the
currently reserved bits because the driver can not assume a security
model for future effects. If a future spec adds
FWCTL_RPC_DEBUG_WRITE-safe effects, a new kernel is needed to allow
those Feature commands through.

Sidenote: I wonder why the spec wasted one of its bits on an extend bit,
but here we are. The 'extend' concept is typically something like
"bit15: go look at this other field in this payload as this 16-bit field
was exhausted", not "bit9: the bits above this originally defined 16 bit
field now has more bits", oh well.

> +
> +	return false;
> +}
> +
> +static struct cxl_mem_command *
> +cxlctl_get_valid_hw_command(struct cxl_features_state *cfs,
> +			    const struct fwctl_rpc_cxl *rpc_in,
> +			    enum fwctl_rpc_scope scope)
> +{
> +	struct cxl_mem_command *cmd;
> +
> +	if (!cfs->num_features)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	cmd = cxl_find_feature_command_by_id(rpc_in->command_id);
> +	if (!cmd)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (!cxl_feature_enabled(cfs, cmd->opcode))
> +		return ERR_PTR(-EPERM);

Why "Permission denied", because the base command is missing? The
cxl_fwctl interface would not even be availble to userspace if the above
was true.

No need to worry about optional Set Feature becuase that should be
consistent with the Set Feature Size data in Get Supported Features.

> +

Per above, need to add EBUSY for exclusive features in this path.

> +	switch (cmd->opcode) {
> +	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
> +	case CXL_MBOX_OP_GET_FEATURE:

I would still check if a Get Feature has a configuration change
side-effect. You never know if someone purposefully or accidentally
introduces "read causes side effects" commands.

[..]
