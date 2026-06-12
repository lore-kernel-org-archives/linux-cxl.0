Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58C221F39
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224680; cv=fail; b=eqHxkJj4rs1cg4ozxxii0MdqOW1UN1x6XgRN3LJBCiyHNsij1Qm/JuNbIYLjVdln1s7Nourm1hoNK/bsxUcJNlDGxnFcGQCpE54DMcVQIMOry3KhvskMCV+00lWtCXCkTDvTRNetjKva7GhQrMxYoOsXcGOJrGjxdnBnwuYKE4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224680; c=relaxed/simple;
	bh=mmxc90lMx8Cflavl4U+4sxV09V+vM5cCWFd3RgAPOPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tV1UEc8P41pZrKPhJuZZikprd4TS+4WxQF3BCFc/4aCNVc4elItPDDKZjsm390QuqreVXENulNycbIelQ+YX29VOA3Kc+JKxXenApCWcUMMm8f2zD0T9M0CFRx8MohJL4yhAEx8m3ly8s7KidhOvEGTLVKUdkc961Jy1KyR0iz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjnGbtv0; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjnGbtv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781224679; x=1812760679;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mmxc90lMx8Cflavl4U+4sxV09V+vM5cCWFd3RgAPOPY=;
  b=kjnGbtv0JnOA7JmiGLBJ8sSd0lqCS1jsNiP6N2ulOrAfyrxGp2QfigL0
   4bFzyfcoT9kpLsfbRChAdqxomqUhSkutATZc5MD2A3KdNeZ5a9HCZMdP4
   vvb9JHH99B8Jk06NqEmv2RSOCtURzD+18BD41lN8QiL3oouHfbt+KqwXF
   PW/YaItRFCUy0y7WFp0OaY7WNbdM3eD7yuq7EiVfgrVbP+PG1YlgF1sfQ
   1aKpb/ttWwslnThL/20ka8ncK0McxeMOhdByr2MyWOWyk2E8Vz8Pj6uAf
   dfjpW88dP5wsr+ngFzDLA5T5becNkVFPaGZIua1ixV8YNjVbu8gW6Ag0D
   A==;
X-CSE-ConnectionGUID: dISlwxiYRWCM6bExn3kbPg==
X-CSE-MsgGUID: NhQZy5z7REu1tAy4mPOgNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82098831"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82098831"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 17:37:59 -0700
X-CSE-ConnectionGUID: 9WURVIqhQjSuAFPjINnHaA==
X-CSE-MsgGUID: wpGi+ZidRPyu6wiS3eMGow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="270328911"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 17:37:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 17:37:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 17:37:58 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 17:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swgE/om3oWGt9CjqEDVQEQZOICeyIrIXxBjkVR2hyjSFaJcJGYwBVTLuCp7+9pfoCFnqQbHCtDdi4HoKgRCvZX6mtdYYu7HTnwLDDKL0uWfvMkjpW9hm6HeCXkSzCDsFFCGMsEVl/L5bULSv+2wIERESdkbRgGPggTum91gl074k9PRioe2WA9BqQva7SzaHKFPhOINP/D4IPZLSY7se/cHqp4z8juhUVbWTTCNgVOehpkOljCnBwSbBHU0W9Ir3vjPqutaeSdswv9JvKo6v6qJUr/AJnYND4jtw8nyrAP/9UIe+lETnsJkj/n0GAeLRSqZzHKaWP1PdQpr4XUe2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmxc90lMx8Cflavl4U+4sxV09V+vM5cCWFd3RgAPOPY=;
 b=o7zE/QPGJZ47LIfWEcipGdOeS8PJk9YfNWrDavWLQZ3oQ78DBHUYFPp2fW1BFXNIuBTDKC0F2VMKWsvOB4KzOI0/zRYw9UzVkYD82GO4yg93qmBGeK2ELkzzJghG6qY+ADZgywvuSIj2bgqIHoMzgz/VUimbxdy7jE+Dk4KNWoiZH6b5g4wI2LqwyNT3+8T2OIn1Dfzizy2Z2g/esVtnUHvYOugYOBSNTcrZvidT9aD79qFsna6kbk6vsyeCMUHIHBT/Ld/JJH0LhYyzlQJlAxl1hl8i+ufLYcD+0Nk4uks9gawr8/BsCdzuJH4B9rcBZ6cH83hkcVv/KenwSBzXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6572.namprd11.prod.outlook.com (2603:10b6:303:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 00:37:54 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 00:37:54 +0000
Date: Thu, 11 Jun 2026 17:37:51 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<djbw@kernel.org>
Subject: Re: [PATCH] cxl/test: Add check after kzalloc() memory in
 alloc_mock_res()
Message-ID: <aitU3-WrFCj7wjVC@aschofie-mobl2.lan>
References: <20260611230305.197390-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611230305.197390-1-dave.jiang@intel.com>
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1272e3-8056-4049-14dc-08dec81ad77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: v9lU9DFSOMDV5V94OcffVDtOHmE9tOZlCkSxnN15TZgSHOzs75pce+owtdAu0hRRkT1h2erC275GbOHzWVxjgLsBvUAMRbJhyqJtNB96qeyMZ+PNFvB6m2XdT8xdnRgjvrG6EuKBew0Hm82KqztBqdGjOInKxtiMXHscUHmRLfkZ96WQrpTDcfSjMVHnCyho4lD+5Z1UhFxYHpUzjqjQM7nLYKqvuEVJnPNnn5b6+ZM6lim5pYyKXW+UrXg16zF6n34R6v3hbojQkE8zU4rqsGD1cU7AFtwRqoxu+2oJExeLKJIDpJviXE1s4XtVkPXxkNGys6va0PjgbClcZ+NXJE6WZM6hZ+QQPnXsxbVyboh4B5BQ+Tz+WULpuB25l8okdJKmSTNhLwgrpnWaKKwSTo8+s/iNT2EiHfK0NVygTNf9/UbdSX6YxkEOdV/VcwL0SMsJ7Nmhuj/U1uWc2i/ezVdesH59OKHoH4Zz0+3smSO1qjiQZtV20PHgnNl/MiGggB9M0YfghuLjrOeakcEfnCnjLOtWvEbnEZ8g0lelLfWZ80YBtDx9PLlvuCu8rYH2ukYm9xUIc+y+8M5XbKyXeGYLcixAxdjz/J+I9+5fp3SYIlW4IUksT9uY+5TMVq0j0T9ipLIM5lUFL84oF/nQbfoXtuVeCe+ZRpaTLhpwKsMtwj0WanzxfP5Th3WY8lce
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aqs5EoaXwbiIznehIciTO6hay1kPbgyi1p077or6Z2LX7uAlgSbE/3fngPdZ?=
 =?us-ascii?Q?JdfqUNohMAJulAJwf7t9DwA2WDJVZ8goij1tvDo7jMrmRWGKH7tBt74GFDMg?=
 =?us-ascii?Q?HEocWIVyKFoqZ5opMJVcOc+lvqZGECMqYfLyzWZJF6PYvl+hN1+bLoavXsvg?=
 =?us-ascii?Q?/DvqG8ngRVwoIzNlowzzGElxh6POPmtyLtCplIDSDkvmX1MMAVzrGnpJuxM4?=
 =?us-ascii?Q?Ac2hKOAeB6U4l6GNg8/vwSX+3UuEOwDO5NJjLc1U6nih2FynANYIszkOO0MO?=
 =?us-ascii?Q?E3AEj9YELXdcjy+kqM9fTOktYtEQWLQIICp4X3R+3SSOMpUro8SC8W1wnP+C?=
 =?us-ascii?Q?5gReXjUwu/ANHPfWMajbB33lCrozMgWGQ0+bMw0JSG5yKAbFEHB+UTmuOfZM?=
 =?us-ascii?Q?I+0zWRkV2XXnxvkED8iuEcHJbZRoxgxuV1/8dOAXOULPUg4gabkMWaRrXiQg?=
 =?us-ascii?Q?nQkZw6hGJqblBNTPMlU/qQvoWlY8c2tKswYb56xTWpWzwzD3IYmaBuOaqbWk?=
 =?us-ascii?Q?6UZuoEtLhyN55hONHpjssLiwjxNRwfYcKJt38pjVqVO0nFmrmDU7KDyrxp5B?=
 =?us-ascii?Q?Wkb4rIbP5yzfAdQzFGDa7lrK1NnNqds4XUsfQbX1iAjx6k0PNossFRfM3Uo5?=
 =?us-ascii?Q?RuTit3ESAMovLmCgQYMtXG3FUCM09hvRfParEFEVisSX55UVd7kIzpF9BsMk?=
 =?us-ascii?Q?yu2s2YDEINp+3GoSAXvxjKONRCwt5eHW2pq+Xbvxbqen6qqbyrkZdRcsVK1P?=
 =?us-ascii?Q?hCyAjyPgzoMjA4wcXOORPxO0j82XHZoJRc0zsp2NrWhzxJn6eok8cnLcWqPV?=
 =?us-ascii?Q?qn9BestzHXXyPzFbsKZVt6gROVpj9r06PbMPJv7Mng9e++nIRmgBV1+hRf+o?=
 =?us-ascii?Q?Jiisamzy32gnKi3/Xr90lG+MxrWNKwWiw3Iuc/AcoXQEhBaDpWp9Tq+3+vPS?=
 =?us-ascii?Q?JA1sr+7fV0FprHP4Amd0APGHtj5OymAuTJHThMCBLK/IgPVcl5UNx8l9Zb2w?=
 =?us-ascii?Q?by2Vx/CEHDn00fKo2vLAo25goZANBfVdPiaAl3xNgd8pNAYv7ozzZQ/Rckwp?=
 =?us-ascii?Q?7HyM9ZVcp1AeArcHqm4oE3XeiCK4hFLqBWLG7cYZep7ifPOaMCp3mm44JxRn?=
 =?us-ascii?Q?m0TcgKNJirdWpeu97XKg/iZoeqBMgxn18qF60Ew50Gzv5lvFVcSjf0V669V5?=
 =?us-ascii?Q?kVzve+ZC7TxXLEsb7DZR7jqw5mkpYOazc/5eQcNbDFahPoV4ZtJdE+FybuQw?=
 =?us-ascii?Q?iFU+UM0iXyD/KSFVRNw7yQwN5ilbg8xt23Q9r0hIjE6Kd6phURmiJwwkjgzo?=
 =?us-ascii?Q?nfbatnmc2D3TvtZck1CPdK1NhaSLnNPz0OUa0Q6m0Hx1H2XsaDEF5FRnM8/B?=
 =?us-ascii?Q?apJ9XjSOtHsolc8xR/TixkFFVypGxWoIXsRaq0XWr9X+7sU4WkGx0ozlHzGM?=
 =?us-ascii?Q?ekpyGMwb+hsPV9qjUksIGkR/P0duQgcSwVcMLUPNgV71ClJ58Q3zEgRFuNab?=
 =?us-ascii?Q?wnU75tiGT8c/z4dxiqWbbLJ50pevnu6E1cccGbe06ircWevX2pNPwwncHqYP?=
 =?us-ascii?Q?W5ty6NRiGGBh1ExK8A6wAz8jrgJGOuUKXJZ9K79kR1bUHDfUglxAKyWmEF5y?=
 =?us-ascii?Q?phisGbbgBGs1SWIein/lYbke/T4ZhrUwrhN7LvOz6DJhb5c3uwvJPUUk4eUm?=
 =?us-ascii?Q?LyZEN1SIGzpbWgZPbxVEUSQduS26pvPA0TAulZT3X2CaMVdyFgUNehu8ATIy?=
 =?us-ascii?Q?xqUoqoaFVUT0I7V1gRSChK44TUAziNo=3D?=
X-Exchange-RoutingPolicyChecked: Pk0/rQUg21kQP7n8IOb7k5gbW2Q7L8yipthwZiH7msaUT9qF2TtK66xQtXg1n4KmYFK/dYMhmvz5JlGrV+0rfbE2nZDToY1AAJeMjiuJuC5f2kFjP05eftspvog6IMIrwp3PxnjORPf1w5FJDq2hG4yaOcftsQ/3zVOcee/zxgbP7Ghg3aRAIHj2YvsKTNP6hiKdPwrZE8p9c9QZp79Zcz+bH2Nv5keZ5+bk8fjSNBksE0dbeZo69r/I6aZkDljDsK/RBp8PY5LHKUFu1o5aSEnNVGadwiHs3AOs++3oELFLFeG2iiQgTOl+19KICCuQndLNXvsewCE24xD5woeA+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1272e3-8056-4049-14dc-08dec81ad77f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 00:37:54.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZPoSWuJ+xIz5RbkAV8DrI3mrhsj5EyEyveNHo1nHDow0/jVLXxF+cCD/XQrn2WOAtJAZUGFKWkSMQnU3CBCQMKOyKU/gswp0dKgLxq04DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6572
X-OriginatorOrg: intel.com

On Thu, Jun 11, 2026 at 04:03:05PM -0700, Dave Jiang wrote:
> alloc_mock_res() calls kzalloc() without checking the return value.
> Add scope based resource management to deal with the allocated memory
> cleanly.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

