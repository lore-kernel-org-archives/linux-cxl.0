Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021211A4F2E;
	Tue, 13 Aug 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580971; cv=fail; b=HoquuhTGi5yM8ZrTXgflqvRh0bKM16qDmMICJB/lD2O2bMMn2h99UA3oWu7riZwI40uamM3iXMxfgjmhZYaWDyjLzL4VqwiXKtXJ5bvTPyL6Gb3Q/Q3hxvlsw7InbAsETdXsed/BJyJOhAxfIfH/t17Qtvp+kGwtvaTmYAryyak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580971; c=relaxed/simple;
	bh=+rvEOH0oSKry5W0emWUo4M7fHkSUZ172TZRVudgnO0U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KCf9OnXrlnSjXY1IGOpMkXWZiFWQuEE0F9wg2G2FZI9UT7MQCSy6rMbUKCp3ndxgkfSfJc/1VpT+Koh6pIIa0FDYfXeyNnxW8mFWeL4oeoxN2HfRNkdNiw9wW+WSnNka8lGlrm2JCpBZqsX33wsI/XboRjB7wZ3mi9WHAI5h2I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9/lsMIq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9/lsMIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723580969; x=1755116969;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+rvEOH0oSKry5W0emWUo4M7fHkSUZ172TZRVudgnO0U=;
  b=H9/lsMIqsJufMeQ9Ryup4ZtrDxZyG6nPQQb+IA0AM7KC93CgzIWUaQpj
   oITQHrl15LlOT/1tnCXODYiSeE2w6TfGAd0oYPETubS6wTldkPzOtRSd3
   ObWeRMYpCNFkKWeMt6xewplpoAeotICxHY7aGAXJQgIiJtEAy0Gd5Y7SW
   g/BU+z2Ef501XM5AQ/C8LY4InbF8MX3gRCwNhKP+fgJCRCorl2HvSC1Or
   gMeg7x2u5AL5ILS7ULpLwlFB8WyI6uDa9xupcw/Z8RD2wEUt8vVtbkzeA
   OMOgWueQOtNODRA/UxubtwjuwKyaUjek2Qm39rpxDJSk+HhrGOUGTxr96
   w==;
X-CSE-ConnectionGUID: 3h+c2yUtS9GVRFodGp7vIQ==
X-CSE-MsgGUID: IWjFj5w+QH6oBan3VRPzaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21902326"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21902326"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 13:29:28 -0700
X-CSE-ConnectionGUID: G8/d5JNQQJGe7itGYJoMxA==
X-CSE-MsgGUID: ALCTfUtcTMmeb4GzqsVjQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58880202"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 13:29:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 13:29:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 13:29:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 13:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDzmlQM3gbBg0mnQ7GpihgY2Kzwh6c+8ajkHoycffEBQkrGe8LD2fO6YQPaInQ+Mj67K7yDP7nAYTQwyz4qMzHCyP8a9Lm3p2+OZh37y5HFtv9CwfTxcHXQFXE6wClbjE0UFVc597HAFDFTvWYbni8k+aN5m8Tk13gQnvwsCTWyc/koGT/sal04+lS8Rn0j0nfw/eriTkWnRPizPi1GGNYs2qH30ioVSRr/PF69NRHAx/ur5W95Zm7lhxzeyA6yGmUNBEob9/w6hJBivhH9V0zJqCrOn16vQVj0s2Us+svamOjd2iyPMecFcXYLwlLBhxO+VHdIj4V0s4ni2GMWzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yrLtsxp+6n8nA5oinLcWzPSGH40NFKmxc06u6cQOJg=;
 b=PvDZydz0WkwKqh3Fd0EBDolsZNUd8vgGW+xlUvyQuhO9e8U0WB7F8Py9RZxMSQmBF6V0Smg7+AMa9TFms0ekoP4oEz3kJmN1Lp9SOCTMwvysoX2H7d0XCyqf+V1JRAIAB+L6w1PxQGioVcGy0f7HSbW5HFZg3yEMqm252yfJnQSG9XdSA2P5gPAbtN3tpRmAKnDBruqktwqS6lswWnoIbwLybiBPq9IqlmRgBHszyicolR/gNgTEcFBJ9PNbNFkd3XLJLl13kRBobuaxtckAUPZzERjUQ8Q/yeOYJF7oi0rI/TUhHS3f4+Cke7OEqnYdy7Sxp8s+ABYHX2sWx1FWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 20:29:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Tue, 13 Aug 2024
 20:29:23 +0000
Date: Tue, 13 Aug 2024 13:29:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/region: Remove lock from memory notifier callback
Message-ID: <66bbc21f7cfd3_216829434@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240813-fix-notifiers-v1-1-efd23a18688d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240813-fix-notifiers-v1-1-efd23a18688d@intel.com>
X-ClientProxiedBy: MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be39dfe-8ffc-414b-37c6-08dcbbd69e10
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DzuXj8NS7gNdElPRKW/sKcT8NG65zushmsB+N8IqDL+SBvxiTXrHKFcTip7f?=
 =?us-ascii?Q?zNz8vgX6wgbCuZZj1C8meH2XmbwqPQRXMPnErIb98FpSn//qeoYDPR90vikH?=
 =?us-ascii?Q?wk2Gj0hXxA4V9mvqlcDplg/cKbwfM9ZCi8XR/UXJeqmjK7JTAy1lXPf7wabF?=
 =?us-ascii?Q?Rkf4IgLH0jwgBAcig5Y73CK69C0ij0PsrCYggn4x+nrFNQcEyzaqzVl35KBV?=
 =?us-ascii?Q?YfQA6JPY+DFlxgTcPkyjcEJGNoaTNW6W5v1aTl1tMoLOVwdhWjaLQxqMcbZq?=
 =?us-ascii?Q?sO/xubR1y/5yUP8GM+Xrr1M8sL1s90Mx+UsP1bv5MLjBXwPOIgUM0usCEyEy?=
 =?us-ascii?Q?DGF/SOYu6/IQVic8haTVuj07nJYJ0MED3W/IR56699TyDRuf2jGnP+oAuLX5?=
 =?us-ascii?Q?deblnaO8xhEVgKU+8Qs7/5VAxCUJiVvcguyAVRdLTKqJHWrGuy/BREIOrYb4?=
 =?us-ascii?Q?VUeKN8X9FlMI9YJMI45QAIVE4RNW5GoaLfzRaE/aZQOdSYjM1uF2cUeKwCLQ?=
 =?us-ascii?Q?PpktRbmMJQQkoNaoHacDfedopNUCsq1hPi+dvTuhM4OdB710l6v4Rq9+SqGH?=
 =?us-ascii?Q?LvcT8UGzXd40WZklZs4XWA7EgooHX7pK1KHwm9SlsnDLG6dYOT0DfsMj6qF5?=
 =?us-ascii?Q?1IrGZRohf8CTp6sLHfHs6EJhkV/XVHkfqFUjKmhxhVw3x7ZjfuPAEp7nF60+?=
 =?us-ascii?Q?p8A27RvYuAdmbmWJ7hCG8bs8gDu6twSFMZ1fYSvjLs17TbZIYOH7DX4cq4v6?=
 =?us-ascii?Q?CnqJRbBrICUXrPY5mtIjEy9If91gCdRKl8Nz0nMp2KdlD7issE796Hvu4dGw?=
 =?us-ascii?Q?nuf4hvhlWvGRbeWSNAPdCqbOS2BC81RufTV6NLZddOVK5FdngQyz6RRIN/Ag?=
 =?us-ascii?Q?npwH38ulim7H7CPRkXGMREKUkOTCrmJewmenNQo/4hrAtM/oi3RE+bVwgJKA?=
 =?us-ascii?Q?vwwV790X5T0JDK+o/gnwB4Mmf6AKevdxqnpTLirZPabwnbogm5QzrGaXL9Wm?=
 =?us-ascii?Q?HLXW9DzSe2pVMQH82ALLZifCFQIVCMPM72816xXxJ9CE2kRGuH1pXOMU6zS1?=
 =?us-ascii?Q?B1i2r4mMNK27C8CqDjDJ5g0IGliQw6n0/6+eYmPXcdwyfo3sJ0zw1921obVM?=
 =?us-ascii?Q?FmfDhJnM3M+6Urqs4hf5QZyC1WW45/bx51vXNoSqVkiJwIj4iO0cFyQtwIEk?=
 =?us-ascii?Q?0OvVO+Ne1bSBiHbjB+YD6sbhq30u9l4FgyihB+CvWtCpsdzHkgwxQi5hqS4g?=
 =?us-ascii?Q?70iBietbHLk8NYIzpWpCo9nSFjzn7wmptV5usoDJ/bdrVSLM6m5unUWQ6ms+?=
 =?us-ascii?Q?Sj0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G62ixc/GsYWXHKdunUejNRH6FLylFaFhy8NkLMUIz1xJteiNyCBcEWVdLHPD?=
 =?us-ascii?Q?USiH8/EksAJkkQVlCYrfxZf5l+2tFIPfLV4bEPuHhSMVDGOPHPh0VuoAAtPW?=
 =?us-ascii?Q?xr59Q8WFQsEXTsIXp06ja7sOtUtOqVc/X6pqYRItkYlwSRotEhna0jRNn+zJ?=
 =?us-ascii?Q?EDil3i26vOGmYYBnnVqsnAUo4EfInyzrRXWswWB0FMmjr7oVUBwq8YX5s/Qx?=
 =?us-ascii?Q?AlNHLYRZzKPOW+Xb3HPbOG7MgwVSidriZp2ys5gWvHsXSAEixFFdbBahQQ6u?=
 =?us-ascii?Q?GmbsLjdzG3maMpVfksY+toq2YEoMPiFlcNO1ZKiGku/3eVjYTHNSasrI9pqi?=
 =?us-ascii?Q?51gFcR9SEM8v6v5YI0TyPSJhQYayqJIQdbYzfi1vt0lPxz1Yd52ibnR9LJRp?=
 =?us-ascii?Q?A+M0Lfy43JkgHlNj/35Jds6euhAVavT5OoUKQ+bg3Bv93CcN31dkqUamT1xe?=
 =?us-ascii?Q?VqbEs7cEaMVq33ta0AgmX7qrSsTZUq1k4wWSCxSEJnMeDoEuB91lrFFYX9GJ?=
 =?us-ascii?Q?ME43vmKsP8cfihsvuT2qx+tpjyR3jEr+eRAZV/TxY9dgEz6r4sYDTZ/z2zJm?=
 =?us-ascii?Q?ZLXg1kcS20fZwPRMs6VahteQetT9tjeur20AkXxluxY0WgVt8HSZCkrDoF/K?=
 =?us-ascii?Q?AjWvA6clVo7M0pA+deE8AyiZqdU3ROa2DzR0Yq/aetb0gJVMi4oREHbygjrE?=
 =?us-ascii?Q?pYmEE6bCfzsZKgyZ0EcR8tUrt39zC1W/K5M1UP2IgblB1WwsqshD3tfrrtOW?=
 =?us-ascii?Q?r6yPf3eoHkFkrNzxFrynCSlz+wtoY81W6SPMP0B9PBWjJfl/mS9LGR5w49ME?=
 =?us-ascii?Q?Elu/h4cS7anGo8KaDyt/EqGtFIzFS+rBxKSLCs6Yp5ky3yZGoq0JPQCfKit9?=
 =?us-ascii?Q?KFi6IyoxOYFs26Zn8PNhtZKMMX2sWU1huBhPTsDwslb/n1VbIifkajvZy7xe?=
 =?us-ascii?Q?7RzyIZ4bM4vqx2nJqSNLY9aJ44D5+iapgsF+ZXp/uI5fzaqB1kpFHrly35uL?=
 =?us-ascii?Q?fOAd87c4eJMNR7rWqL1gXkjRyzb4Dy8FtPkO5mAatDr8fqS6bCul8UOmcPFx?=
 =?us-ascii?Q?UMMEPKkVw35EyKmq+VqutWgmypEavY9KN8XpF7hl7yBorMI2U/sWEiLWfsDD?=
 =?us-ascii?Q?gSOfL0pxODMcaiDUOXOZrByM/Y6k5IkE/LpgsF/t7WrtAqH8t7o3YiWUmYVt?=
 =?us-ascii?Q?xpeb5p/mCOM00hbOGPoygS2m1INf3XjFy2JV9A/rHuK4FMf9zwflvuxpzgsD?=
 =?us-ascii?Q?3rXUuPHdH+lRN6fR9SAHG8wcB8rpHgmfoZz2umL1wxuH9e39tPrryF2X42nx?=
 =?us-ascii?Q?vg6mJBsn7f5aZdnplvkoUY9iK3YNetlCcbbMcJkXPCQxdvQqAKVjAqThOGRb?=
 =?us-ascii?Q?Dom9NyFKdc6CsTT2svMByFZUx0WnissMv9HEwpw/I9bFJtwTAwtw4aX/np4N?=
 =?us-ascii?Q?iXhqv1ATBFohEXbDn8F59DBDtkuhGVufI1dEl1Qp47MIRCMIOVx8W99gLjN8?=
 =?us-ascii?Q?2bd9iutxd/yuO19HfFMTEXuFlVYrNO1k4IWbEXSY0NRoSczY+vZK4enYJs9R?=
 =?us-ascii?Q?PJfoTZVX7dyEGGnc7ga3iIhildZDapNA2ZlayhY8If1fNDxyBppKOSnf6Mif?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be39dfe-8ffc-414b-37c6-08dcbbd69e10
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 20:29:23.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rzlivq26wRKDRAb+At3OFu2k7nVXj8WwYCs2CPP5UGwyO66xi+pBVsoy0NT/bDdxcvqSxW/VrjZ6LJbD+R4A9P4KGAs1oQvwzb1V98GXi+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> In testing Dynamic Capacity Device (DCD) support, a lockdep splat
> revealed an ABBA issue between the memory notifiers and the DCD extent
> processing code.[0]  Changing the lock ordering within DCD proved
> difficult because regions must be stable while searching for the proper
> region and then the device lock must be held to properly notify the DAX
> region driver of memory changes.
> 
> Dan points out in the thread that notifiers should be able to trust that
> it is safe to access static data.  Region data is static once the device
> is realized and until it's destruction.  Thus it is better to manage the
> notifiers within the region driver.
> 
> Remove the need for a lock by ensuring the notifiers are active only
> during the region's lifetime.
> 
> Link: https://lore.kernel.org/all/66b4cf539a79b_a36e829416@iweiny-mobl.notmuch/ [0]
> Cc: Huang, Ying <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/region.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..971a314b6b0e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[..]
> @@ -2396,7 +2394,6 @@ static int cxl_region_nid(struct cxl_region *cxlr)
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct resource *res;
>  
> -	guard(rwsem_read)(&cxl_region_rwsem);
>  	res = p->res;
>  	if (!res)
>  		return NUMA_NO_NODE;

The cxl_region_nid() helper is now completely unnecessary because not
only is a lock not needed to read cxl_region_params, but p->res is
guaranteed to be non-NULL.

cxl_region_nid() also needs to be killed so that nothing else tries to
use it that might *need* the lock.
