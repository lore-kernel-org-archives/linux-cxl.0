Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B784A32
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291295; cv=fail; b=LgZM2FbckylsO2UB653upnozcX/vOA6dxurY3b+fHO0Z5vw6Dheczfh8knPCBvifRZ4XEsw8SUxFddpY/G3ZlAMt8xj/YFCzxZipoDzMY1Qrb9MlWVlrZJiiayNebPjb9LeRkLHnIZCUfl4DNdlVBZI/QuiIRr9uoeZRdMoLtXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291295; c=relaxed/simple;
	bh=sdfHJ6rtrI2u1ejEgssdQoGUwLGT7inxXum5Nbc9Iy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LLcR5KF3ClbrxAgmc2Fd0aozKIIh8CJJn7WdkS+rBNFkoufK2iSjUqGRBiviM4WuioL/Www2HY1VcLaS2VpG3HP3hoh1cKautJxoFA8hjNXK8FQSSJ+y/jA+hRirNR+ddP8+NiPG2+ptIsBYwHfL1U8ZrxXmNmoVX5QlbOwa0Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwfdqT2z; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwfdqT2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713291294; x=1744827294;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sdfHJ6rtrI2u1ejEgssdQoGUwLGT7inxXum5Nbc9Iy4=;
  b=CwfdqT2zucohJFpwy+04fHEt4/CawsoBLzKM8Nr3WQL0QCzRmZ62sWR5
   p8E9DJnc1SjecrxjiEO3ZozZmlsQsdhHG18HMvmYDjBN5GAdEcgTtIosS
   tz1yxcWwpyIIvkGSWfBkZdj9Hx1qectpKwJkNdYbJr0Q6k2BabpgrtpeN
   LFYFGx1VKAO5Fp82OUChfwQLIPkzGaxL4qUDYvFgcsNFsw+0MElj/ehCe
   edGddBDpq9LmA7XMGJyQturjNPlW3COpwF2XL+VOBoHymHwnKZrvhLMEX
   Eee/k07//JRk/rMOmEeNd8gr/Xrqx7YFg03saCETtiRrhsW95s7oiMLol
   w==;
X-CSE-ConnectionGUID: qkKGx49SRq+DsIUNcgYRwA==
X-CSE-MsgGUID: yzmAmlTXR8uE2NfilFn0Tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8631783"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8631783"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:14:53 -0700
X-CSE-ConnectionGUID: +8yGKb6sRoWgCGSKDcZ7Zg==
X-CSE-MsgGUID: YZ0J+Q5fT/GBW5FuhbILjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="27029050"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 11:14:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 11:14:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 11:14:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 11:14:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 11:14:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHBWw7TasxjnJ5d/q+aLhVUzN+tb12e+TQQrdPL/Qf0WeESvxm+Bh4afXgezzlv3ly8jTJ8KUuGSmdsHGqTqB/Fn/s/yv6hFR19XKTlDlVj4VuPxC8BOndslailpvANw4Vn+jR/wgRT6e3b74rNgJS8GBxfSp/YgCAeGoU8+SWHmNy0GRdcMsgdrYhwmQb5+7emIY8WFuIXmc0rH2EM1tlxBV97+7oiuPrg3/KZ2EiwmDvqPLCMqDXZaejqWSLhnvclO4PDekyFlP6RW2vMzVvtmCeGPmdPZWkv+yRh+J/qmIe6hXidywqUslA/Z9NPdC2F32Cv97UfoFafGR62FYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhmEwhSDoAFr9ziIGdSH1CigrWua2YQaoBKDIEtm1zE=;
 b=RlzmXC4O6RrOhpWCQB6BGMBZ0LCgRsuoYF6ifY9KGGrEb64leL04X6Qp11Fe1l9kVw+ALibkVjWEtzJN/Ie7GIF7Nc+X64gG9L6JGUwAxKF+IfwnoN5tjpLiS8PsfBEbuCbUxiWcbjT8jw/QMGcAUfxX+i1sK/O7+MIV6vXWupCB7mSwk0i9y6C5ACz5f+rTZ91wwv2Y+zzWIwRSw7yULA8cYzqWXU83lyrQjW3mYbooCKKGQ0oSxa1TKIkijFKI6cd748+qn8qvFj1Gp0o/+YlR3+filXtERAFHgZGo5bSxpVp9QgZmiqyOhZbFYQLODPZZ5o3zGS94yCBdpAduCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.48; Tue, 16 Apr
 2024 18:14:49 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 18:14:49 +0000
Date: Tue, 16 Apr 2024 11:14:45 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/4] cxl/core: Remove cxlr dependency from cxl_poison
 trace events
Message-ID: <661ec01531662_3f182929450@iweiny-mobl.notmuch>
References: <cover.1711598777.git.alison.schofield@intel.com>
 <4f1c74748ee880eea9ddf6f966a4266e86f12bee.1711598777.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4f1c74748ee880eea9ddf6f966a4266e86f12bee.1711598777.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e39c6a-77c0-49aa-692b-08dc5e411a6c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDEne27wY82ZkkOgONbZrFhtdMk+e0DKMrTO2ZPOl8q/boqP9q3rT3c343wiPzKt1R2DvO/8eqk0uhH/pkwjCUN4Ft3fB2Iz3W9ZWVzUuuU6/8qXDS6nZbvOnvchWh5T+Kso3pOBJ7wpNa3Qqxv9l4IJe8s0i8Dwheh3iqshZRMOSaArgPuiIxYjhfHq4L9VcV7NnDZ0rbIHpyFZX1ct5rYFNPdepaxQbhIr/y4E5piglAEqQmnnpaF/ApFVyD18n0mhos8rw0J1UslfZ5D+lHvZxOhD81zlauPHC3R9mwe0nQ5+xVH5zHOUmxBHXFWgkmC8fKdKPET5Ca72BIg4Pmo+wyTpUgzchH2CxzDYVLcpRuyM7Or0/Y+qk1sJtpX+ISKHVVq31e9ttlz9+fnzWJJdAeS9aNn1RisP8Is3amjm5zEvnfqk6LAP3iaOwqce8RTY/wzmAtn2BfNtnBuWCD1sXI1yQ8MT6CJnTERzILoY7jEK8NCnWbe2DCADBOIIDXr0cJkQEHjRyd7f+Igy0Ql5YDp6RtnxuDPFozIpUARZwQRut3kDonFtJWcJtj7yjdS1NhNWJZloZg1po88I0eS2IVUzpTbkGxj3TsTVqip34WmHr7YmDJ+mq3Fd2YZ60Xyxq6Aqpb3d3wFF6HKK6ptn1XCYZyzv0RxBSVUaHFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i1u4xC7ICJ2KpT7dfoaic7LtZQ6uRZQznvhS+qFZPUrCvfplPFP1KDdqLAa4?=
 =?us-ascii?Q?3HlUCyubMqbKBHPQOuOGU7ZAL3w3U7QUr//winxcvwzN+IJBcGYYdiLXdRf1?=
 =?us-ascii?Q?kHFbOmHRdTX6G1l+bXiJ3+YyQE6W8mols7ZG7nNFZQBiwbLvaXrn98ntpBV1?=
 =?us-ascii?Q?GxQ9YlalLcsgyy37UgyHrPjjjZj4+1+heHLETG0+7t+JP+0kRMRoJBH2+imP?=
 =?us-ascii?Q?dSVbc+jp1Lr0PXdBPUx/l4ss2re+PUe3fzQlcb4gtmC2vMFNkRYB2DLAXHwQ?=
 =?us-ascii?Q?/+WA5ALOj4LIPONAR7nATWBB0xGYWKfMkSWTAgCDCxPF4GjQxT1E2dHyVcee?=
 =?us-ascii?Q?fn2VtyJHPyvLPyfIoBQVOwYK3gVBkRaN3L4bWr1+cRrmyrxlL/ohFV78FS/y?=
 =?us-ascii?Q?nh88yPTyNPUMW4EK+oI8/zOfr2z+4Ph7dSfEAK+1ExFU0pu0ChKYXCHGn71g?=
 =?us-ascii?Q?UBytEYHD2vxLCixijdTz8vBi2KG5oHbB1gWQOt97XF6z/yGj/NkMQUV53pgv?=
 =?us-ascii?Q?kn45rx6xOtBRfBcOXap92FJU0ukv21e5tMLIzdE9Yf2mgjcllQ4Imzh4Ukxn?=
 =?us-ascii?Q?38Ajy3mL9NhFMmQvO+h85m5qLX8XrIiWBOONMnK+35tcEE3njjb3edcLF7sQ?=
 =?us-ascii?Q?Utmv9yhGjhHKXfMgIX1CDXzmAyS6EuUNmi/YH7HTVvDs5MgyPfQEV7hRoy9S?=
 =?us-ascii?Q?FCMyTVmGgTK7bBQLzUL7VEgoHFnmmQjNNRHSTJv7jWQDsvs0Tk2cKNl6VPvx?=
 =?us-ascii?Q?RMXeQhGZDjCt5SLJ5FdHsOELVwmosoB4vvj9SnYMetmJpGmJSaNcXL0EdleV?=
 =?us-ascii?Q?Td7b9HAAUHzfbUlpI4weV1CKBIIkbdSwbLEVs22WXjuCPuspsnNP1EC+Lbt3?=
 =?us-ascii?Q?SYHtwzkK9JF1yQ/mBK6WgHsH0zMFxMRd2weGxbZW9TuS0PT4q4PUldwCoAWl?=
 =?us-ascii?Q?QwJJDzPG4Iq7KKkavOrtuqMH2jynhP0H4yqlHdxpVavIMnNZ71aoguP1HahL?=
 =?us-ascii?Q?BNPt9tHUgZUQkAbr0wpB7PEAjDDeJQrHnUCbP6706U5VtVPK+jYM3ZZkrd6y?=
 =?us-ascii?Q?aYs5c+CdiJK4+JBuN8PA7iTuvIoGbx/v8o6PfM+ydzLLv/La212IJLukvRPx?=
 =?us-ascii?Q?I+ShE7Ift1xHuhekI+UJmbdzPGL0dw4Val6dN63qav6NRdMFzJcNOAxR3r7B?=
 =?us-ascii?Q?10k8Mho9qD4znRuhpuNO+/lboA2iQOOkpV7b42GO0bSLxLglmjIMNA6LQSm8?=
 =?us-ascii?Q?z0iUso3vfj4RCePdIsDo5SueDvEHJ8ZtOQopUKda6W2JOnHnf7i+6Ygi+pV8?=
 =?us-ascii?Q?WsNblNFXmPnpXRRSQxmLSJIirMvwZpGIK4CpxxCLt31bP7gYYMP0U8hBt9M9?=
 =?us-ascii?Q?2KETKGX2gYYorUQj/15cWgDp4i41Ex0LUh/Ozm/R8ILmmBtIhBWKtD934tHR?=
 =?us-ascii?Q?Zcq5NC++N3m8/YWWau7vYXpluYCKd/qZ1iDcg4SR8LvAqQsT6bQq4zEB0sI3?=
 =?us-ascii?Q?Ti2UsUsgGpBdDYq2B5IQmyH7I9di08/Uu6gAD2mhKKSHM0MgbOf6EQALLUUm?=
 =?us-ascii?Q?5K2Cbt6Zl5Iqsgff4Z166okI/o6FRmFehg/2mZiS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e39c6a-77c0-49aa-692b-08dc5e411a6c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 18:14:49.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc98TqRpkeCC2ZbWJBDf82/au6uv7Eml1T+0M6Q6e2VKlEUFCsOzdrDbokA0akecTCKe0q03evnSaRZkTma1Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl_poison trace events pass a pointer to a struct cxl_region
> when poison is discovered in a mapped endpoint. This made for
> easy look up of region name, uuid, and was useful in starting
> the dpa->hpa translation.
> 
> Another set of trace helpers is now available that eliminates
> the need to pass on that cxlr. (It was passed along a lot!)
> 
> In addition to tidying up the cxl_poison calling path, shifting
> to the new helpers also means all CXL trace events will share
> the same code in that regard.
> 
> Switch from a uuid array to the field_struct type uuid_t to
> align on one uuid format in all CXL trace events. That is useful
> when sharing region uuid lookup helpers.
> 
> No externally visible naming changes are made to cxl_poison trace
> events.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

LGTM:
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
