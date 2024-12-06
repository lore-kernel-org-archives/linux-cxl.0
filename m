Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CE22334
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445867; cv=fail; b=nlJk0/PqhibnjXQzrxSeaMo1IMaBAimeyDSuFHXK7N5qFJj2QMfSLpyVlWY2opq2y9pgvJZNQ5zporUZu87Y2vpu9oGhoKlo+Qx/vbo6eCN0/3F0Im6yzlb3qhy03pS+u0Cv590Fhg2BurrxSNUxQko00Ic8TXdoercKZ+jgcB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445867; c=relaxed/simple;
	bh=dqAGDeCG92yUtf0IXl+Zv/FGUbGVj7Y80XuD0Jw6efY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tcj0FiWZTPvYR8yCSVpKUfelPz/b+PJdYX7acZnQOkLbSkql8SN/BADFIHibU5WA3jo1ZO06yitSZDPKeUIz96zh2sW0PLAW3iGJYb6DK8L8xX/rdRN1v7njiMQDBIWWtidMiAYiUsGc8qRW3P0MJmJ05pn2oHxgjCTStEqgYRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6sMa5HW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6sMa5HW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733445866; x=1764981866;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dqAGDeCG92yUtf0IXl+Zv/FGUbGVj7Y80XuD0Jw6efY=;
  b=X6sMa5HW7Lqn+Wo0VTmwRJd4fVAVwBCMT7VMkIu0Nm28sxjdgSH1V1L5
   Tz6VMJMIL48nhDV1CohjDNouj/ztmin9fWK5N8w8Ob3uco4Z7YJE3smjg
   8iJvuOKzwumu3viAycCMlQoGVMOrG07jCT0wNWEa4jrhPogGLqZM/w1IA
   gwebPJTNgE+g2fsIMbk0bvmKbmQ11tjfwjnXSXYhPcmaz9ghTUKSTFp/3
   fWfEtYzX9g8zGXR/1IyrWLbA/QfR8AKltgBmIETgziY8kU1aGnCb3e5v3
   CZQiMOyMBkPhxyH84zeIkQacLEENscoFO5j/34cAuCgCI9jx381Go0trQ
   w==;
X-CSE-ConnectionGUID: XidR5V2HSK+/dIhC0JzrLg==
X-CSE-MsgGUID: BwxXydnsT5eybyv38czdKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="51204248"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="51204248"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:44:25 -0800
X-CSE-ConnectionGUID: 8lIBRz4oR4O7cE7AOdcrMA==
X-CSE-MsgGUID: 29I92R0tQx6NXcVZaGiDsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99216898"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 16:44:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 16:44:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 16:44:25 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 16:44:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbqA1ggAwZhiPsuaOrlSQG1Pvy8Ird3mzAe9tcu8mZJYzpI3FNx4JFoimCYZrGu8OUG8O51cZY6xGicIBDYQm4T2GD0vYuKL+UIVcA15/XuYxNi/ym2kf2NlVGA4oIGmlQDYu8dPQKgS8sYzjHmAcon6UjH/oZtjkbwE03u4znJ1q+tcACnCGb+pLCo1UaeQ07uiJldL4sK3vjPyy3kChXLLJrYV6yid0fHTWUZ0FVK4S/GrFQ3ZZuOsgZPfSOf7iy0dAjjOeEAnAtkQUWaZEpiLBorg9lN0HsLTT3pRSpnJmCApPHzSjWztVqBUM64sa8skt16/8tKUgrLUgZwIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuJX+z07w863Lr5CYVEAd3KCGhyldtiqdzd9GQ7h9T0=;
 b=IVncEHYVS+Xj7srY3b+jdFAcmHuMqNvT/VjE9TuQXl9JF4vv+eQwr7P6wShfD70vam7aPjFn4i9qoDrI1pXmXQcFaKgjWd70DmSQv1slMb/K/CNGqLZWBgtbNOoaTvSy7qPn5VqtAlZt3nu5h2tExdFU3YjvTzXTEM3CPXII5r6Ixr6eH4lAzHy3ZwYi6Qhsw0B2GFJyY8XGDLlGbUhz2TC++hDS/XOfM+Ru+/sdUbo6P3jWzjNAzkgSfy2CTZIC25mKfDxGPC/b4id5qNytGpg2WE11Q+99SyUOmc5sixzZ2Hpaxef9rhgdWLsVRrEM6lJTrXZUY8yK4Xg4HjsYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7054.namprd11.prod.outlook.com (2603:10b6:303:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Fri, 6 Dec
 2024 00:44:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 00:44:22 +0000
Date: Thu, 5 Dec 2024 16:44:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 04/20] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <675248e44c037_25073294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-5-dave.jiang@intel.com>
X-ClientProxiedBy: MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: a3df99fc-83dc-4910-3992-08dd158f2075
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HGiD5NkkxTvZtntPv6JQYPhwSS1aImY7gANvpBK2rNLOHVG9Q3ljmzbTGDmy?=
 =?us-ascii?Q?a10FHMC/iP7Z8Cw66TTMvuiAK4u/C+NaE9LOumIrFJblBzc+jum9LVc1dglz?=
 =?us-ascii?Q?csYdsp+/OEHa+UcBBNxKORlub4L7uM+trbV7xG5ihwT+qBPevSL9N8oQ/Rrd?=
 =?us-ascii?Q?T2WsscJreXg2a/dvXK1VoaokcfKqATLMgHHNao+6fQQy6kPjFB3vij72JodO?=
 =?us-ascii?Q?wnRJXHnbsmwq7WW8AyjGYsG3tbbvcpNjNgmcRRco8KtH/jYc8+tn3dFqGOFW?=
 =?us-ascii?Q?NvxUUXm92YiE5iZXF8aLRQ32A874t5Wxp7TY25oFCFAEHZQHO6sJs+n3ijLD?=
 =?us-ascii?Q?SssIDJ4c3RkTSmCN7/vX0NwXnUEXSozDfxd5M6MH/qtqlQ30CMtg0jgAifhk?=
 =?us-ascii?Q?lXzXfXkFOrvg2yOrnJoW+siCTl71S1QXEOJUudWgDuvzraeYDyUi2XirwrZq?=
 =?us-ascii?Q?shte1o6ILCj7oj6/ZAPvpXFBavhZmnnoKw6oX5UTEyCP2/aEX5jchvFOQbQc?=
 =?us-ascii?Q?/ytPgV/LTaBfLYliYm+12ZfGZCSOb0cmgczATS9RPe2Z3iDBQy03QSRFlyvf?=
 =?us-ascii?Q?HxsZjPDODxG9hPUpSrjUreBg/b1QcmCr7GGGLAQix3EuG1USTKkKHIhlKJoC?=
 =?us-ascii?Q?MC41FG92Rnf5GLxIPYO4GDKHDCXo220hwFTVMtOR1rQckpI6x25VxuOMifzT?=
 =?us-ascii?Q?FmY1Fw+24HqQEBgOP/Fe/PbUNmc9RdwbsTtYn2LK0znhjYchrk4CWGngZoUC?=
 =?us-ascii?Q?FwqM4U1UufonXbxLCyB0RH4licTWwPfUg67MgT1oITvk4wbwi6EyOy73k+2b?=
 =?us-ascii?Q?E2zSwqMcjooW9NEjYrme9pdppNduqF1f1tOkOwSTvfY7oRzyWkMB0hSjAloZ?=
 =?us-ascii?Q?VqVj5tJi1UOkK57npcu+RNvrGdD0US2t3Plx2phF2SpcT7ilaSOdajt5m0Z3?=
 =?us-ascii?Q?Lf/fkGHwZRvSinFcRDoeXS+9w0WjRdGyp+7hbxgZM+QEgtj6ARZw6HC1rZdj?=
 =?us-ascii?Q?6l0ujlsawkBjqqvcuTTDNPpdxNTvQ7KLZkaNrfv9uGe6R2nE5q+48ee0fqVm?=
 =?us-ascii?Q?uo0PRs7V9mQmV7Nlah0mTAwhl73M6zKQ1xH/XwZzArcsy5k1h8X3z+sZUDqv?=
 =?us-ascii?Q?VkCloBUdOzxalbNKHSGeuAhTLRt3bjkPKZIcu/LDEu5Pw09f/CYvFInDCQVC?=
 =?us-ascii?Q?YrgvUKXJyOOfJtaYkPE/JPntOwq0hAlbkvw95B9DwZuaWXyT2vBu9FKwuA59?=
 =?us-ascii?Q?N+o4XrrHQ1MbPoPVAd3NtmK2FMps3yZ9cb17CahqrxwfBsIjl3GoZNyQfmsK?=
 =?us-ascii?Q?/cDYkHPVtfrbApenBbAcuQEgpNVsmZOtHQuuOLb4IW4sPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wd95G+CGF008sGhvhzYzK8/EEjavBBdO5xPsCPsEIOcImwPRNtu69f1BK+2f?=
 =?us-ascii?Q?FirRFEqKSUqLeLwe5t9sMXTBC4aQltbkaLKEdCQsymqv8zWYiV24O646oNhU?=
 =?us-ascii?Q?jjPKqKPDnti/VzAhaiDBl/AhvJEFiQCw1DLXfKnFz6Jbk7co5a2oICHbgaoc?=
 =?us-ascii?Q?K/nAUE7lt7m482ZCwNk4lZG5kkimbM2Tr63EArYu4MqDfVXMdujhUvZR/80g?=
 =?us-ascii?Q?VDFA+yRYc9SCRwSda5GJrkVna33XMJ2lK8iR+fx4Lfm/1w2968uurZXk5Xhw?=
 =?us-ascii?Q?olCW7J6txiVoEQtWBhyDgYQz92qVcbeWFet+imrB6lm90kpj1rtz7G1BvIg8?=
 =?us-ascii?Q?8x6Mo5CY3mIg1Va+rI3Hha4bi282h+WPDdmHdntMhjGX7XvjGIwvYBMBDqRT?=
 =?us-ascii?Q?SiTdqL2DFeBiL7a10l4U6NBQMnLJVfTyAQERHNN2/AZ4WjaNIRA3M1XRd6b+?=
 =?us-ascii?Q?BCii+bRylB1eWfyuGTXa7Zr9wFdg+IJvTOSlUt9KdFQtQ+aOm9UaY3gfDetv?=
 =?us-ascii?Q?c2hUcJniZAh6mxYiXmGizGjyqQmN747GDeqLqz529LOyT0/KA72u9VPjiHoX?=
 =?us-ascii?Q?9BU+61trF7PSPIbjzikJ5EIpsiau8aza4vT6WSVTe1vSlFIm3zTREr2gAU/2?=
 =?us-ascii?Q?mDj0NiJFyOjU1C3P98UurYIEG+dVBIrLZtTKiWPu7ttCz8wsiFj5bxABszHf?=
 =?us-ascii?Q?sGNoTAj+T7LCptnGnpoKvke6FQ/07JL9+Sbh9MmKfdyLsg2sVx57SVXR6Z67?=
 =?us-ascii?Q?tZmojkw5SgcK/hxndcEkguZaaHlivhcD1b672saXgyynIvKK262xtdkwmyYD?=
 =?us-ascii?Q?ANZHb5U8ba3yPq9ZhF/KyDQ1rcopXClWHg+YK2OMb7z40yRhgeaSvYthKB90?=
 =?us-ascii?Q?H5+6UhJYbpPxoP5RZqGkwI1KFfFcGYDlBg+h5fy1/950pe523nZkPfzftIhf?=
 =?us-ascii?Q?fm+iYV8dckP1Qp8g3x7/Cgk/Q12jqUmmGeTxYrnWecMitObJPulFwUVM4f8H?=
 =?us-ascii?Q?LiTOcP3sOVJ1QcWfeDUVj2rqGifF9mQ0+MsuTOpeKze06sMVs4mGYVK4N1jy?=
 =?us-ascii?Q?cdSbZJo/kWbm+648kdNSonEkRy1V510MNqfyEMMtKg/cXMg62W+z9zYSljtB?=
 =?us-ascii?Q?gZyTudQn8FKjxOcv9Encj7JSN1YOHsyuZ+v5DHRGzX9DGajs27WJLOc78fcs?=
 =?us-ascii?Q?VhoX7ddveUsJ4IP0q0OoHKaFUBHcC51BlMRl41J+gR2XJjR33jOKeZbsEcDX?=
 =?us-ascii?Q?Bg+2dEoNc7EMe6oJLiPqg6WYej9uAMS2nGxW8gaFsNAAkM452hJkRie2/nuf?=
 =?us-ascii?Q?Rm1URbT+UUggEDUlWIDFl8w6S+/kM/GEaPaecQVNfdZa+N+HS3H4e6alzFP4?=
 =?us-ascii?Q?G39lzH9SiWH06XdQ/kkqHM1s0ezPPbsBRlolXGz9uyDAFIrcxk0RYkMjBTIM?=
 =?us-ascii?Q?iaXWC/csu4BYEwHuRFda1jsv8vDFpLX14yH0kuJRR6VdagvzXpBpYnlh3YmL?=
 =?us-ascii?Q?RxEiq3c1klhm0jz3TYirF6NsjLWrJNJwP3fStru+uwAofpFAXpFzb8RgSZXn?=
 =?us-ascii?Q?kRQCsA0pewve/41D54QqglA+NMGkUIeL/4DGFdRd0Gmd/Kaj8FbGUnlIhnEU?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3df99fc-83dc-4910-3992-08dd158f2075
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 00:44:22.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKkMbVt7CKIY8Sxy3Hyxr7fzM9q2Z0LWbFEe6cmuplkpZRB0gyWw3u8OH5fwnvs5xTTuqLfbTxtuZ7AYtNC8sdoy7rbKSrUOPe5k32CUpfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7054
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> This patch is not needed by this series except the opcode enumeration.
> ---

Wait, then why is it included?

I would say fold the small bit that you need into the previous patch,
especially if we think that fwctl can cover all the "get feature" use
cases.

>  drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 26 ++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4ba56f3d5a65..f70bd7d28ff8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -968,6 +968,47 @@ int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *f
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
>  
> +size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uuid,
> +		       enum cxl_get_feat_selection selection,
> +		       void *feat_out, size_t feat_out_size)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;

cxlds is otherwise unused in this function, just pass in @cxl_mbox
directly.
