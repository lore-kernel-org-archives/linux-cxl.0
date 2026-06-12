Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3AB38E11C;
	Fri, 12 Jun 2026 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781242881; cv=fail; b=pN722RPi6CBnnPq/cLqX5z6DqcPLrQHYKcAqvtAv8CM0iQbU/6dqZi9HuFqlybWP3Xu3YbZKL3YD024dLmLlGzOIpDMozuAdq74Yijm1fGCVpPKsETAyRbP0kqGOyuh4nIc0FUcpa4Ejno9pG7HONMg/Z3XjWdpDYTmECdakp1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781242881; c=relaxed/simple;
	bh=A3hgjb5RQCAPmfgrB4AYH5gXd+PkKFFooFO+2QP9yi0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SLT8eexHoAyLtNpBahoz7VKb6UIS7iAxs6BBfYyoNA/g0gaOmcB+MyWyg7a78RevWcy22Gb5hlnFSrlStYH8Q1cVe0nBX34G3WZpE6rCojLrR2Jemjo8zeF/8h9mLrJZO25CfzoT82krtji+dCtBkFSQrQMwinJJO4GRMLfQR2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+k1bP7w; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+k1bP7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781242880; x=1812778880;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A3hgjb5RQCAPmfgrB4AYH5gXd+PkKFFooFO+2QP9yi0=;
  b=L+k1bP7w/ca02aplhJHmSgRleqLtmZinIcrlqMAUde8iQ1taUXZCrm3S
   hyKMJajAnJKWv5oV9TjYyrUJDV+ZzzNVkAbopz6ypfwFNfi4PR2gyRkqX
   ceeZ6EfclPXAPZK/lLlK9dCfTLCOSM7TMupaspOhtfqYjKLCGYVlw8abI
   sjH0wqdeKpLcJFKUPivsEG+zm4q+uVhNtvoJuApPRdSVq1Ty5XUt9Nwjc
   GwaY92jJFsOITsAvSC694jgCh2UjnPUF297aqr7620MOIud16SoRv/vBx
   7Ehcv7frxTIfastuoywXbWYvG3U7jjcqIAt0Bf8Qx17WB+uRUpiA9vDfS
   w==;
X-CSE-ConnectionGUID: LCsJtcZyS5OqdxrlsUJgIg==
X-CSE-MsgGUID: IKbEd73MRaGxByYXil029w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85969760"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85969760"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 22:41:19 -0700
X-CSE-ConnectionGUID: g8D4McF1Tzug+oaZE4uN7Q==
X-CSE-MsgGUID: DmSE/rloRiSJrqhQ6Ll9Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246754972"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 22:41:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 22:41:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 22:41:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 22:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdQZbTRVHJB27XR4yAx11OG6Kw0ns/s//YifUazfcBrL7zisWbn74f2fzAUi5MhvrKH4TCP/TigoiEmltzJ1nV3Srczq3kTxINJ63ehuM9hhM7HbGcgEtIYk/uLafiv+SOaAEH6dsht9SWuAe/eeJHCcw7yG/R6jn2v03qTjR5ue4IM0hLmn4iu83HmOHQrMF6wwMNQV47kNxthm1N64QgergjZzSInPrx+Lr4Ls8k3R6sN6AxUux6wCFguj8ZgPE9Y1qi5aH85K/qKdxbVYHISJkx6lqNI0D6AXV/KzcXCQXsb2KTSr3lJsAApyuP2U1M4UP0ah3HTf4B09lR3TEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83kS8WuEo2IZgYZG2kZKMpSwsl3EesVGJdawP+gzvHo=;
 b=GHtG7eBbkYqPD4ZgX+r+LxuIfIIiQ72NFPW8ytFT4BOk2ABl6EAGz2ElP4EHa1paJjKyhaBwqVy6hdeqwrhNd8JL7TGzVjr9o3ga6hMXeCd9KM06HHgXNiQfAuXi2upXgP0AFD6r29sEgt1DJYMTTCh1CUycN47kDGYwKAoDBvu5iTEirQy2fe82EUhZYyery1B76C7PQKjLtfMCRCqahvCiQAUJrHP8b7wub1pWRYTUOBQDvKcvgtj0ozwEMjh4eXq3STBkLfk68UhQE/P/wJYn2ZtXY8I+2AV1QH3rJVq4PXad6wsrnk5HYihN5jmkHWscXD07fIa8bDMBD5rIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM6PR11MB4593.namprd11.prod.outlook.com (2603:10b6:5:2a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 05:41:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 05:41:16 +0000
Date: Thu, 11 Jun 2026 22:41:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<newtonl@nvidia.com>, <kristinc@nvidia.com>, <kaihengf@nvidia.com>,
	<kobak@nvidia.com>
Subject: Re: [PATCH RESEND] tools/testing/cxl: Resolve auto-region decoder
 targets like real HW
Message-ID: <aiub8gVN1rM_MIZO@aschofie-mobl2.lan>
References: <20260612011227.4220-1-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260612011227.4220-1-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM6PR11MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: c7996adc-3971-4119-ed90-08dec84538a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wpnZ1QpwJ2/jOMlscnEsJrF/ZPnyUDsOHDD3J4AVUPbsIiDpeG4TsKfAmquWrJwGbjbPSLfOIMdUrg5aKoYh1mfXY1QCcwvDNUfQ9haBNYM4+3E3hrzZw+FnC9GfIB0139CrcyI/M+eFO4MGwpIsH/qlKnwJ6HlDZK3glsmWXGz/lrwpSMXMBLPO4O24a1pq9DO+inUQeXq7qR5F4y40PG4wiIhE/E96I2Egin/kAWDDr5gCnFhUaJIqacPFL1bNbXbVAhQ1otPmEpZCdRWLB+ZYRjtEUyBeIZMAW+LeBSGCB+RnQX/3EehHiSXETDQWPqyfv2PQBYMCaksfBYPL3uOudK5AY7ilxpgP1NEMeK/wDVtqPTd2l8tIP7lcJJm+/pc+Uun25r6fxTSabMG7PdhRrwPpKBMVGXtAMP9qS/OMbh8JuuSUe6EFI3/oSKy3p150I27qzFyOOxq7+Mrnk/0XvRCvIQd9mpVRMF+E4L8W7KSzulKv5/VUU5VgmYg6pv1/A+XBlPAO4P/KPz7LCBBmM3/a4BSZY8jk90BF4tWEfUOckdolBagCWphLow1amCq868erpuzG9zwjanhlma5vLa1jSxBF/O0BlvFcJ5nMTUQIVRVSG3L4X6OohWZmTGYf2mUbUFjy8EsmZu2zr/iA095xGPeXLroLGi4KCIUfLaRddTeABfsbXZp4gB9CMthu6pqLL9ueCEyYAzifFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YoVQitFwxXf/H5KfXDlZnMZ4eP2xzXxpxbhpbYZqqLl6k6tp+wv2GnJgEyMn?=
 =?us-ascii?Q?IzANW2FWLZWD6wAiDc6bO2eDBevVMobNX+lBuaWWBw6uFMYR0ZBPNsFJzWm3?=
 =?us-ascii?Q?6QG4+B2isxePFmaYcOyikacyEkLd8WAM6ouzTsHXtUKbjkTTlccUcyalmPgd?=
 =?us-ascii?Q?mgoLdQL5lVLxDWT4hhxMG4BywhRC8fOrOPRZ4bUi8ztc3bZIY84DSGAkOQVk?=
 =?us-ascii?Q?PzJP3/vWyvMeTqdPKSY78R11GRAf5oQstRrBq5cbz6gsf7Z/tJwu3jFZMfqO?=
 =?us-ascii?Q?+vHHyZD8o/K+gH9WcALs65OHYv/B09eWQVMeW3aed3VaTwVmLRa1S+yPQcOE?=
 =?us-ascii?Q?quHa7spgKMuga7fAeLHuFl4remF4czjUGNKatDP1LHmuQRWcnhQ0fRilJwnK?=
 =?us-ascii?Q?ZwB0HYij8Tp+Usu4iX5mL22PRr22N1KHB7eKFLUis41tZk+9Mnu9YiuPtrfG?=
 =?us-ascii?Q?7DxVOUJrKuMO5KMJ4CV682eiv1daBOI4KUXiaM+wyGN7XaV9xvkPgICmRvgT?=
 =?us-ascii?Q?4V+0AfBebTgSIk1r1YzJABn28ubAizLCXQOJksLpU4JZDZRv8rGXLhwxxLa+?=
 =?us-ascii?Q?lp8wnLdpIAO1i/LKft8e4HPa95uKBqP97PawLogdka8XPJpJTIO8sYdwlRuQ?=
 =?us-ascii?Q?qC1JTsgSBQaBQFHROF8Q8qNmdoUVepL7MuEr0+0pP9ST2BhFDmQpOjmTcvGM?=
 =?us-ascii?Q?wsXe1Sd+1NeBHxxPCUApKIu0VqRneI+OYt0GEqTbgdrSE4fjx0zb5H237xEw?=
 =?us-ascii?Q?TRMwhgd2W5R0ufVl81STOnKcYCg8kjNjEzcNgL1ItoJFTfjchF0ay/vAbuD8?=
 =?us-ascii?Q?927rOOti7ynmaCHD9hirL8UAOeYKTMk8xIpgAoSGV3HVeOkX2+xVT25XQCFw?=
 =?us-ascii?Q?CZX0DkmyoPQY6Xg37uKPoD4/hjUPLleI81FHKZ7bbfZ4gvjZrppMEqZMSxie?=
 =?us-ascii?Q?WULaP2m/WUGPA2tEG9TvSdYitr/hsxuPlu7Rq0Rio7jdbfJVBriVziBL+XpG?=
 =?us-ascii?Q?Zeqs3PlLw0ngD8k+WbYAYmp4Py34fI6hhb5OEwYb4UObXIvUyG1Hw1lkc6Pl?=
 =?us-ascii?Q?FZ7+3kv7buwYdtsvpevj15vVVALsDf+XVDziqdDFL3yfKsTvXwDY0kHqdFBN?=
 =?us-ascii?Q?GunobKdKy+y6lL8EEgklldVu9O+e9OD0+tGjsN2ZtdGp+/jt6imeiN/vKFrM?=
 =?us-ascii?Q?T0QvD4buOj1H4gJ1d3OSU2QxbWgCQeDmEBGXRL3CxkwoTlNj/LcJJnA8N+BI?=
 =?us-ascii?Q?9ov0/L+q2EzlkaPypG3/qhdO5qH00jIhuhlptWIbWiWZ0nOlEr8SCQgK3y04?=
 =?us-ascii?Q?z0s6Y+LOT6mq+Nunt6b5NPOtm31XbJ+c7fXLhuSvvMCEcSgUc5a/bDCc07sN?=
 =?us-ascii?Q?v4CcV7uzxA8ygTOPcKW2YolgXFz/xnAvwWg0qHXfMcwKN6SbgqvA1pwDU+0T?=
 =?us-ascii?Q?fD1MXNAwegb528ZsFDXIBGmEXcbS43QKXstikapdSEKbtC8ydkUj0UIy87lc?=
 =?us-ascii?Q?ewl7PSM74+4CUUY+3XlEZHbVjgu6R1mmc9RyZYCFvVt/OkIH5pND+NfzvlZL?=
 =?us-ascii?Q?eWj2TTVGSrJIOvHqVcP73wQ57A+CsBHq4vHLYAKpluxHseZHk+CVvQvvgad6?=
 =?us-ascii?Q?hJFS8QaG5OniVTSGPvhuRg2GE+Zf/THwT6vN4CDOxQzptwar/tkvHWDDQq6B?=
 =?us-ascii?Q?ap+fxJh7mwhcaun7T3zq6HW00jgChYpyrlBh89TmizbtGblTxZIFtZIMsO9u?=
 =?us-ascii?Q?4Z7nwonM4pYj+AmkZUIBLSVEhelH2pc=3D?=
X-Exchange-RoutingPolicyChecked: pw8sDM5fjm4bbBb2ZEVrCAUcy1vcdre6O9MEadkOu17rEO2drtyKjbX7IEXOtIyklmxGCg4WzakB1gz2cVI1ymDumdgeV804+O671X3tApL1Rv+gsIctmp6JkItPbNO34z/c/Vsh2dgvhSciJAdvyvKKWHGxYWDHW8aMNVlfTHNZRMUirTQ0eKWCLnWgvEmtSRlq+P6kNCtQ8zQHZ/p3w2CExcuultPWJDZ94BvMcnPxxmnrr0v+EnnIIwc4D1ZraA8a7jLNB0z3v787zsXMWRPQfBMlxpbr+j+zjuE0WMMSx5/sDgJe24lXjLiMhIkUi4g2DhUE7YIxq22TX0ejiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7996adc-3971-4119-ed90-08dec84538a7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:41:16.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A61VVUS6PJXDGHVZiUHmch4SROG8bZixNIzqsXF5gsNS0vQg01l8JKRlHRVFhkOWuZ4C6vcU1LJDTqL1ir6Rz2SrNF+qHEviI9x8NQzAM8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4593
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 09:12:27AM +0800, Richard Cheng wrote:
> The mock auto-region created at module load wrote switch and host-bridge
> decoder target[] directly, in addition to target_map[]. Real HW programs
> only target_map[] and resolves target[] as dports enumerate, via
> update_decoder_targets(). Region replay already follows that ordering,
> the initial auto-region did not.
> 
> Drop the direct target[] writes and call
> cxl_port_update_decoder_targets() so target[] is resolved the same way
> as real HW and region replay, exercising more of the auto-region driver
> path.

Reviewed-by: Alison Schofield <alison.schofield@intel.com?


> 
> This is inspired by the discussion [1] below:
> 
> [1]: https://lore.kernel.org/all/20260521084806.28232-1-icheng@nvidia.com/
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> cxl_mock_mem didn't load together when I manually modprobe cxl_test
> module, should we make them loaded together automatically for better
> user experience?

Is this a documentation issue w cxl-test?

There's an autoload path. cxl_mock_mem has a MODULE_DEVICE_TABLE for the
cxl_mem/cxl_rcd platform devices that cxl_test registers, so udev should
modprobe it automatically. That only works if the modules are installed
and depmod'd, though. Did you make modules_install && depmod -a  or are
you insmod-ing from the build tree? 

Are you thinking of a MODULE_SOFTDEP?  I think that would be harmless
in our cxl-test suite loads.

Maybe explain more of the environment for me.

-- Alison

> 
> Best regards,
> Richard Cheng.
> ---
>  tools/testing/cxl/test/cxl.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..5266aa3733cb 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1181,15 +1181,11 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		cxlsd = to_cxl_switch_decoder(dev);
>  		if (i == 0) {
>  			/* put cxl_mem.4 second in the decode order */
> -			if (pdev->id == 4) {
> -				cxlsd->target[1] = dport;
> +			if (pdev->id == 4)
>  				cxlsd->cxld.target_map[1] = dport->port_id;
> -			} else {
> -				cxlsd->target[0] = dport;
> +			else
>  				cxlsd->cxld.target_map[0] = dport->port_id;
> -			}
>  		} else {
> -			cxlsd->target[0] = dport;
>  			cxlsd->cxld.target_map[0] = dport->port_id;
>  		}
>  		cxld = &cxlsd->cxld;
> @@ -1212,6 +1208,16 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		cxld->commit = mock_decoder_commit;
>  		cxld->reset = mock_decoder_reset;
>  
> +		/*
> +		 * Only target_map[] is programmed above, mimicking
> +		 * firmware. On real hardware target[] is populated as
> +		 * dports enumerate, via update_decoder_targets(). The
> +		 * mock's dports are already bound by now, so fire that
> +		 * resolution explicitly here rather than stamping
> +		 * target[] directly.
> +		 */
> +		cxl_port_update_decoder_targets(iter, dport);
> +
>  		cxld_registry_update(cxld);
>  		put_device(dev);
>  	}
> -- 
> 2.43.0
> 
