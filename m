Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC114658C;
	Thu, 10 Apr 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247619; cv=fail; b=Teh+e8k/0bvf+M/jXnIrQlBJnL9IXQKry6XsqkAbX23XSW6gjY2scq8IDyvEqJtZ5i1nkAGWDiKViQd8i6Hum01s2v8bCt412ZTlrvBrO/8nzeBsiFQ//JY6zNRWtZZhu4RwLjAv8r6RCQM1NjG6qlSqeKEhLIZftWt9bQIARCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247619; c=relaxed/simple;
	bh=tc4qIDmK6HXQUdLNULU77b84bn1oWMVoK68HJ5X9tj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aKWf3Pj1OJ1w+mM5XgXfhXK4ThaO8n+iOLCZIQ9tMroYzAqMZVHB5mj+xx4UjHRgNrtVV3OVZFTlK7ASL5WTBD1kEefPG2HsRygxmd75kn8lql3xgxpNvPDV1dh9i2KXT67x9IGQhITYaRCfqVt85dDUvBBYRiW6emrj8tp8XBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4oGqt0t; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4oGqt0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744247617; x=1775783617;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tc4qIDmK6HXQUdLNULU77b84bn1oWMVoK68HJ5X9tj4=;
  b=P4oGqt0tzf3xFCmEoy8SBi6OXfcdXFWPuvpH5C7QnDkuFtYeEwsHmsf4
   f4vUjlV2gb1VS6b+6nwu/UTaLUScd6T7ZGt8Dy6MHBsKo87vZgAnrm0mS
   WSXNCuSXKfF/ZteKb+NH2E7bf9HPNrpNoel/DUm/ovl6GtxpMME8+GRUJ
   ZNFyTvdwApZO65pOWblcN1/30br42NbwF2wu2PktRVUp36oNJic5vOnTo
   MnwvsgQB05AbmGAzWj/P9QCwggC9sjf4ILcXw9gD0LVn3PeBDQNlMSgv8
   nst/Ha4+xG4qZgxiiOiFiYV566i34yC9V9NhYh67wXDyCKb3fN1zif8bD
   A==;
X-CSE-ConnectionGUID: B+/Owr8qQJymAy1g0+lnLQ==
X-CSE-MsgGUID: jV9ZQOndQF+++zQsXVZiRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49409700"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="49409700"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 18:13:36 -0700
X-CSE-ConnectionGUID: tTiDKBD2TCuLBSLf+jyrIQ==
X-CSE-MsgGUID: CKG4ZjFBQH6D1n4MvyaLpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133949172"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 18:13:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 18:13:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 18:13:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 18:13:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFYZbiNBtlFsf+FmMyFPIBMxILJJnGcGm/J1B/HEe0JxBSUOACFmw4hUAPXroyObnwjv7d5ibHQNDla3JwNJwuYEjReeiIVeUF6vXOcRe+dNCPI5S2z3fBJsNlMwQ4CwVNG1ykiDUtOSa73redWEtSuKrlfCB/xNXEWbQMcXwVeH9dC/GPRuW767scVh5MmdDsIcJ2YSgezF8yvjYkgztjjoXVSZgYhMbvAuAecoX1CzYSUnZztWCMyTLqdfLD94oqD3w8Zzni5pjSa+ZM4UiU9h57dcm0M1eB1yq3z0/IrVogfCdXT03YysPvwcjcwZrJN/BNdbrzl69xO4nfK48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj7u1F/9Z7JqLkidu3W5X4O+TEqJtLhI9n24QfS84c8=;
 b=lsp4ce9/xGq8UiD+w8EX9OhPLuulcVci7JYd7vkTYoaME5DhI+nQlC3WnX3idjlggjwSlYjjmvYaIIHFG0NNycUVhqpHMBBHrDArGW3ruIzRDOd7aCVLf48LmNxHy9pjGjipIFfHxkxCjk8V2/6SFs3l1U/0ECs7mYvvhFpM9qDm6caJz2dR1xDDUOG6xu+JQRagfj7kmLCxwCaWzqgvXbNcYRks61OuLsQIqkDa7GWT3A0H8ay0jp6GjNL6MmyPZBv7XBadjBXS0RuAaxuhieeJncKlSabfUynwj83jwiU1UiDvQ/ifyyZ7Hh2tV9//jwTlUNnf+H0e0vXTlMwj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5313.namprd11.prod.outlook.com (2603:10b6:610:bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 01:13:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 01:13:32 +0000
Date: Wed, 9 Apr 2025 18:13:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	"Li Zhijian" <lizhijian@fujitsu.com>, Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v3] cxl/acpi: Verify CHBS length for CXL2.0
Message-ID: <67f71b3a1ebeb_2ce62948e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250410010545.99590-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250410010545.99590-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0298.namprd04.prod.outlook.com
 (2603:10b6:303:89::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: c42199ac-ba1b-4718-d307-08dd77cce933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sv+LGBqNLXy9+n6JHees08T5aBy3yzaTKz15qEQ/zm86E9zguT8lk9bWn/Ph?=
 =?us-ascii?Q?L4n0dX/OrOOHVsBmKKc+7bPpSL8B4pZpWw38k42stehENmKGQ1e0Un2gHxbt?=
 =?us-ascii?Q?zgFuLr20uP2/xjWWmcsFNJnPXHj+C2Sk/K4XiXFk/7V60hBQKDqaQy/mKbNu?=
 =?us-ascii?Q?XPkukhoEb+foJJsKQQMDkRGXMPn6Xof53qBImMtM0u4+UUEnblENfU8xleRT?=
 =?us-ascii?Q?NSiiOGMnf7/rinSWic1TZzjJDRl1v459Sa0gBAl3TlnzhCYHXMYeRUtWH0w8?=
 =?us-ascii?Q?5yomdDD9swKi0bC5qt61BOyaYqcl5AVXE1TvIqP2+XZWamDffNagMXr4jV9Y?=
 =?us-ascii?Q?S7uPlej0RpPlfv4XtHyFTPvnlgP8dCziE9aGooOufyVMPdhmY9xYlQQB8wdt?=
 =?us-ascii?Q?Ucv1QVs557MLStF6u3Dzubvseka67451i8kvNGj+Daxe5RqL11gYsBtVA5sS?=
 =?us-ascii?Q?lmh2I1zZlHEatpcfXQLy5fp/ToosOwJvGytQGDNBtCKdd2vdRAQLXgGBrDTh?=
 =?us-ascii?Q?/IPN+p70Mg6IbS+I1FK4F9upX9Cp/g2FA4x/eQIMP9YfItsAl2hO/FEcgzLC?=
 =?us-ascii?Q?O/4cBLAh1jdo6UAr2x+pSgXcyCahK5oJquUI6ckUvJhUddeF5jMVGNSV5x1P?=
 =?us-ascii?Q?5zC6LWltEQbBWEz3Lx/jQzb3uyXiWt1gxZr0TVQa/1jhdLKs2dL6agghdJsE?=
 =?us-ascii?Q?zzdsyvG954xyDhZ974i/SjHkieIaE82ynUZ2effB+I2EHlY+hn7xQjBkikRh?=
 =?us-ascii?Q?fv2+GnA3QdUAPt7Rh58qYN6VTpehdJMZsF/AL6Fr/w7HqKcGy8qmMtDE8E69?=
 =?us-ascii?Q?tyGLbmwqcP9GTRJunxKxTBpLeSjA01hca4XTwwAFModvyj+jw1O9udapfhh8?=
 =?us-ascii?Q?hLKcZ/eXF+n8jI5jyCzb6CZ5Vc7MD2bG8t8LRmre/tuRKK4BHfHDLWura0Lc?=
 =?us-ascii?Q?HSNvY1RCv9dzY99myEWVEQrMdRDvo8stL+2wy7TFiANNfGbsa/Hfvg8JBqkd?=
 =?us-ascii?Q?DXyTUBvU9/CnLjJwGEQUDo2XOUaLgxjPZ/Hn1dfA6US8P8Bj21ibrA0jq2J5?=
 =?us-ascii?Q?WJZ/PHUyxb4K2BkV7rivJV2ZKaciKcIcNq02UYmU56u/PMPioD4HT5v9AD4m?=
 =?us-ascii?Q?gul+apTZI3L+q/lQQ2H4h32jI0Tg1Zfz8r/4DAhTUw4e/PSi1XQyBcXOkdey?=
 =?us-ascii?Q?j2l6V9LJAAlp3rBFpsQ1/+qZxAaAfn8TiSQ7rB8yZD4qX0rcvNJku8DfU4b5?=
 =?us-ascii?Q?52pD6AJkH82Qg6nQP9023+iBms4y22Bd9j0yOrFqamr8Fm5Bh8OZgsqiV2X/?=
 =?us-ascii?Q?oITZYEx0HVifLygFxqkcVAITPzxzk6Yja39S4qvxYTxBiS3K0NKW32F1VjH+?=
 =?us-ascii?Q?Wvvq1AsKpRMNyPuuyboF5EJFIRvb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dc8M0KF93iqC7Q3oh3NeavNcWdbgnUM3+vOVdN55xPT2mVXGumT4uwYCx9Dd?=
 =?us-ascii?Q?B/oIVtsgzPqJV7sA2l82uvxCALj9SPCjDVwoIe/a/Vy4O1//6bIbw+KVsXuv?=
 =?us-ascii?Q?cwIRhowSEzvlYFEXw9j3zsWh70sqZrsKOrrk3Da82mXXq+de9LLF1iPyVkq3?=
 =?us-ascii?Q?aOLIu5Unx0G4z/EKRkgpM+yXzOrTdHEYlcSrnoSYvBI4FQgXnhyqfsZSiq5m?=
 =?us-ascii?Q?A6P1iy5/2a5yYmdZxNrL6LPNsKleuqP5fMzItdWvIQv5IFmBatfmrWiE2vo1?=
 =?us-ascii?Q?eA365G6JA2Gh32fqpV4zOzfsD6N/oFbsEb3QNi9Sw/xzR1OhRhqH7yknY0Qi?=
 =?us-ascii?Q?krP8OspfoCCmz8LFjJdkdkedEIEM4ujEpj/EMJxpJCIfy4QgZVmuu3CEetkt?=
 =?us-ascii?Q?nyHYRg1fxqUSn0fD0e22nVslI/1yf5xNaFiKAgWf3WwoCh3s44/oDM3Fv1WA?=
 =?us-ascii?Q?7bVUoAX370QsNyNAYHstffg5AjxRCNp7pk4KTzhsUQRY0wbmTg7uj74y923n?=
 =?us-ascii?Q?dK7f2bf+uFslRX2Kqy6OQlNkcodUY9v+vR2mgHKT8TEmUbQAWb/h2ekwbWaT?=
 =?us-ascii?Q?G6bnnE6FNMx6cK0jfH9Yz9bu+41mdVXBBBKyIrGtMQs63sLeHfGLGGUoKnJU?=
 =?us-ascii?Q?trmMUQ73LWCgAnaac43Z+hAMHbLzxhbrag3Ql6d772nkTe5rFs6yva5yopLu?=
 =?us-ascii?Q?eoulD+VXIg03t3l5WW4gBRktPXMjwc7zi+mAm49YLxIdLixtZmN7G1EbPEHU?=
 =?us-ascii?Q?NRAx3U5G3D6ERWk8V/Ph+4arLzVKZHRUXpfiQsVRP8JXEUUdZcvc3765LI/9?=
 =?us-ascii?Q?nD8Qo5bRvWjG0RyUxTs7vVmGen3Jp+kktcrtnlPaQbztv3JymN4B7TokjqLp?=
 =?us-ascii?Q?x9vG/PM9Cygb/lz4I7og+nR7zi30ONkcEocI3UWAVpNCzN4uKg/FtCduKqmN?=
 =?us-ascii?Q?D3sVYILkmnHs9KptiX1kzcHg74AF+lBk4yyZ1MlNqg/hTLdvoiQk7PPW+M4v?=
 =?us-ascii?Q?Y8jSmvZk3ZEB2XftGlzcJ3HIcczlu6luAVTWBvwXfXDAwalszFlRS0rkvC5m?=
 =?us-ascii?Q?ZmlTKW8Z06H+NIZEjoW0IOkEBnrjqzdjZEo20rfmW85Z8VqGf12tvQnrrRoT?=
 =?us-ascii?Q?xn8Hfh4/wlIFTjWgbZYsaJkbGQ9X8LXtEX1weiXcT7FhZ4pjQioASlVxVlUV?=
 =?us-ascii?Q?BeRe7jo1Z/iz1TQvkoKdWe9XUOHWJC8rdfeiB4kmfC4ODwpmavADSZaahDHk?=
 =?us-ascii?Q?chJ9TaxZCAwj7bjm9R9bTAivQIfdM4IZ+VwELekje8OnmqJSNdReRnp0zT6d?=
 =?us-ascii?Q?hdvncomkQ8Bi0nLLUaXpUUTlAgFTS58L0oyZ1jfJyXbWEqD3o5Rt1tpnGmSX?=
 =?us-ascii?Q?Tik+zDeIjqYwKMIIk9G6O8FxJ1CD6BpRavjYeebkKzjVydUH8rXbWiVvq0+5?=
 =?us-ascii?Q?4nut4HfQkMvqGZKRB5kGEX6QgihmbiQboIHkrBzXZVyv8DIygrJ/PMB1TD9r?=
 =?us-ascii?Q?YTnxzbkfUQNHM6VnK8NlTxst3H8uuoylzkVlajj55zZEfRdYaUvxyKYxOYAJ?=
 =?us-ascii?Q?qPLdmk8zdMi4IQPj+ZZVQuD8UoQgpvDIjaFY+qyaCHAUFYdN+rEUfVakOi+X?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c42199ac-ba1b-4718-d307-08dd77cce933
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 01:13:32.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJas2toQFgV3+cCGTrzYgy5bEXJZwKqt54bCPlQqY/yDLztLt6E3GZjrb9tCNt6NQIME5N6iXMp9uVwPS2b/ebTfj87N/URB3ySulfLmKkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5313
X-OriginatorOrg: intel.com

Li Zhijian wrote:
> Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
> own length, verify it to avoid an invalid CHBS.
> 
> Additionally, this patch also removes the redundant macro CXL_RCRB_SIZE,
> favoring the use of `ACPI_CEDT_CHBS_LENGTH_CXL11`, which offers clearer
> semantic meaning.

Right, it was a mistake to allow the CXL_RCRB_SIZE definition to leak
into the kernel in v6.2 when ACPI_CEDT_CHBS_LENGTH_CXL11 had existed
since v5.14.

> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V3:
>  - say more words in removing CXL_RCRB_SIZE # Alison
>  - Collected Reviewed-by
> V2: don't factor out, just validate # Dan
> ---
>  drivers/cxl/acpi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..2e63e50b2c40 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -11,8 +11,6 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> -#define CXL_RCRB_SIZE	SZ_8K
> -
>  struct cxl_cxims_data {
>  	int nr_maps;
>  	u64 xormaps[] __counted_by(nr_maps);
> @@ -478,8 +476,10 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
>  
>  	chbs = (struct acpi_cedt_chbs *) header;
>  
> -	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> -	    chbs->length != CXL_RCRB_SIZE)
> +	if ((chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> +	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL11) ||
> +	   (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20 &&
> +	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL20))
>  		return 0;

I have a small readability preference for:

        if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
            chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL11)
                return 0;
        if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20 &&
            chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL20)
                return 0;

...but not enough to ask you to respin this again.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
