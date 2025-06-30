Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421E146D45;
	Mon, 30 Jun 2025 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751247717; cv=fail; b=BFNaf5lQmyXIpnTU12XN+sA7LwhsSUmuFQyQfqV2Njvz36zi5PfcgDbQ2CZGQreUhNAVRc7P8cAkIdFMXGr/Nts9dw657HNSxAHMO4qWg5a30nutaQ75pP+pGeRSfDDYCgBTIiKoIh4k0r3m/6bRsnvyMLjSKYBrHGv5V4h0IS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751247717; c=relaxed/simple;
	bh=gLrxTEEZDmXZJVWFDygZW7CdTRdJBhmo62VEIeK6GLQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q2A4C5PGMFIhx7HnoHUH/A/l36NJUGLij/1pf8hPtMjcNidt42VCR7YJM/zizaDNngPznwpWWkv6suhJR26LGEU/YBYrz1I3q05atNYRaNxiplWXla+cTM0CRYeE9H2c2REroQLWGVuya2kIeTRj2VGi9Hh9wweXiMxw42ZVGEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQXxee3p; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQXxee3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751247716; x=1782783716;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gLrxTEEZDmXZJVWFDygZW7CdTRdJBhmo62VEIeK6GLQ=;
  b=bQXxee3pnCWj0O1NlW6cWnpvnOHxykNA9hIcyU8PoUDXtMh9LxJKB7KX
   24MVc1eb5XZG/xodY+G327Nqb8oXaaS/o+AKX/btyml3w2boEuzkQD3wT
   1V5JTZZqNDc8ytf7hBfhOT960l2SFAt99NmO8b7EN5hYw3Ax6pk93znpP
   pxWICdUTcRv7bfeTrM/nHcEUHJROeWlTnh08Yiwr6VQ8bLpDctxQ7gpK0
   P2KmZLMSDkkIGCU1pPkxVtp3D8BZkz5y8WLPGjljJ94n8e6K/oDpg3Gjj
   Y7IsKJNwzCcux+YEjqbXj9cnkkXpgs0V5Jy4SYsiWkC08E/ynJLqmDmMD
   A==;
X-CSE-ConnectionGUID: FhwDSKsWSoaAPyIfJDv15w==
X-CSE-MsgGUID: X/tYUZoPSqaiFkGq8S0EkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53186304"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="53186304"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 18:41:55 -0700
X-CSE-ConnectionGUID: 8GJzFlNZRvKh1TS8YMv+Mg==
X-CSE-MsgGUID: Vt4d78pjQDGxuKwx0Q4/YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="157589026"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 18:41:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 18:41:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 29 Jun 2025 18:41:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 18:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDHygF5WxOq2fluHuoctUbj6ZccXP7NnwHe1zRegHjqIPZu8d/uu2QsaRF8W2Cwg+mwJDML3q2yP89kBCvZO/tDN6YGreHM5ifJnh4kX3jwr/C/GK/jrtkTqVdydMWhmsiYSMDECgzD6w8UMF3gigVQ8VeSqQf6oNv4AkXvGyW3UH4/v3RFKROvDtfiSBssv/zVpUajLu5Uc6y97KUv33FSolwwHZA3P3hhM0ZHb/jwBZo4O80h3xrpOVqgHCNrOaNHgt7MDdDAtDFerZtQ4Wp+I9uke+z76s9pRi8CQpqpCZhtb0xXdYQTYbP8CoFLEE8ynKE3ZvjSUSYCDzXW46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/FvPZiW09FDa9GCWNnffC1R6cu8XHYgwe6C/bQ9Ra4=;
 b=w5vLe0/oLljiQ4wOaMOuA3OTWZSJzCJzoQSmurgjmRebdYC9RFASta72jP2AaWerlr06sUGLoNiOQa5iizsXIL0agW4tRJ6LTr6aLFkDyQtUQ6Fn0wU9eKZQDmOoTBm2CrAf54MmLH2+kTH+xKBsDx7RgUOZbhikJlr/76gU9OV99uc5bjSLQYwtBRWatWQgbS5nYG+eZw4QEGNfL1LxGyY3d2go1gXNpOCiwbDYIonaBMCGt8UqvvTqrislTEza7oB0Xu/nc1umi6RQUNPHQl039T1e+vOo13XaOjCb2pvhEZcD6b7AE74/jGH+PMAiXAxIsiSIL4YENbohb6qmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 01:41:38 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Mon, 30 Jun 2025
 01:41:38 +0000
Date: Sun, 29 Jun 2025 18:41:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/core: Add a helper function to check dpa
 availability
Message-ID: <aGHrSVX7ce96nTmt@aschofie-mobl2.lan>
References: <20250629082042.256123-1-ming.li@zohomail.com>
 <20250629082042.256123-2-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250629082042.256123-2-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c320eb-104b-4ff7-f447-08ddb77740fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dQTgSsUkem8kue3CifPeJJOD8ZeTBrww4AAkKtFsHG7Z09f7hPnqIL8v8Ymq?=
 =?us-ascii?Q?PoSVkDfCJsJkPeWJ/KLh35m0FGNb5hkQtBYFiIz2bLQwRtlfYWSmFvSVgF+i?=
 =?us-ascii?Q?8oTaZjw+p93hqDvqyQtk85YbwCkHFm/Q1drwcvvoXERDmrfLZmw3O5xcuvhJ?=
 =?us-ascii?Q?M0FhMB+E1OC1dk+6rbdkoSrWvEYWBJCb+A1gdIij2AEQVUc5WZ1kzzwcxwb7?=
 =?us-ascii?Q?Igk1VITKrBUlhUy1gmTu+rx63in5k/Vzr98vqMOOJsj4qwFPMwIJsofxIJOw?=
 =?us-ascii?Q?6BKhvMnUuoJsvv644/1HQv7ZFNlX+Bicuw/+EwUKJ0/3NvV/CGaPnaRnerys?=
 =?us-ascii?Q?d7favoSgAjfhi2rt9+bG9mTsNf/cQStFLbKxcZ47wSH6ws10tNoOLZUqQWDr?=
 =?us-ascii?Q?oVk7B7Ab2ULHKuQ7tReMgBTkLXh16Q//OOUQJ/hJ879HpZEhoMaUy8HyWcwB?=
 =?us-ascii?Q?69MZ09S4ls8Qq+VF3A9vzs9Z3faLCZS/iBQJpbm363EFdACpYNV2+1dLQwre?=
 =?us-ascii?Q?o5Qw63TxJfFqUiikSQ/GB9PcjpunbCedPqGruhiEJu+em/OiMjkJbO1E0VZ6?=
 =?us-ascii?Q?g/Rg7N1R/DgYLRqrgKOBQQeoNcIfxttjgzPNP/uDvYnHBQ3JeuYqM5TChn/S?=
 =?us-ascii?Q?pEm0/TsNxkcy1b/CnsRVe6aVMavUCY4N9WZp6v5ay1NGpV/zYWqDI+MUsjUY?=
 =?us-ascii?Q?PeajNtxmH61GpJWKyA4sM7ub1OIBdmgx5oSyg1bhaO2/EIP6GNsDt9vWDUHj?=
 =?us-ascii?Q?CIVgXICWJqxO6sgIYYp2nz581YoKNT4SfHIHY13RSbKOHbdrVbXSzizMjiDm?=
 =?us-ascii?Q?3xecd8v+diQGl4u6Q/C5bU/S6RCKxEAYrlMzazrCiAXDkyGQzbXdc6PZeV+F?=
 =?us-ascii?Q?xn6oVxoRt2Aa3ig8pPoHjIJnYuSC86DLe2zByld/e+h2iIAy5Ru9rA5z+TmW?=
 =?us-ascii?Q?D69ztHK5RXDSWcEk+upi+92OQv/51Wneyk0aeHmYd1hKfC9r3vEsE0UHB0O6?=
 =?us-ascii?Q?tGqldV4Fd2PytNl53QCkXDU6y4DUSHBlkBcDC9VyEttwjiAN9yBQZQCPYYkB?=
 =?us-ascii?Q?Bg5Q3Vs0moc8lGR9rsfO7gs1zfVqEtOxv7FKaEINQlABJPv2xJy7yzLA59Kw?=
 =?us-ascii?Q?XK6ER2u9LwWIPIfhIfwfBWHplCEuxw1u0kXHWXKotHBMdNREJF+aQBPLkM6y?=
 =?us-ascii?Q?b8IT8yBq9DCSXNQi0AQBTpSzXDQCOGyIbIFQIpBSJKvVVOIMqvWa6AH09tqZ?=
 =?us-ascii?Q?IGEolvEGCrOT16IyxdN9Ngl542SxiAjxxhN/gcyhLTl3BHxWjRXgouHdaOVm?=
 =?us-ascii?Q?jpP51DuVWjKqTTSjzogCkgaHqqSq+BWHFkzamxW+sexSqUGcbADtb2J+DT2F?=
 =?us-ascii?Q?WoX9iJLI97hbBPx/JczZlBl5v8PGqswiI/Wkx1c37QK8v8QRV2iLPzQo9lWU?=
 =?us-ascii?Q?8SS4htkH594=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m29IjTjsQErr3TMAceCSSlsunDnLs0PHinb4slp6+hyYRZQxbuFTulsBDJq4?=
 =?us-ascii?Q?HQqOE+LDI8msYqMMxYTQTLeTBc2osPGdkLAZVC/aN4ZPwA9ZEDRQkeylksv0?=
 =?us-ascii?Q?OSMGkcX4jUohOTK3ReW4LswhyYHioZMFDmSdqAU453kF9sFg5IpC4u4/R67o?=
 =?us-ascii?Q?+EbrXyOvM7wB1esFP9NPap2FpbCBlkjKgsWtGqGOk4cq3ZsA12MOvSgVBsBg?=
 =?us-ascii?Q?eyO9yA8oyWQPfyKihfO/4EXNpJbwA6VAh9LJiBWUN4UxoOsUJVYk/Cg+Lf0u?=
 =?us-ascii?Q?w1gqiTaRMOuSWoxYl8jgiMlF8I3NDJhAifQLjS6vAGrsTvPuhW34w1sumP5o?=
 =?us-ascii?Q?k65zeTGk+ltVpnqJmCqOeSLg4g2+y1eZQOl/jXu3JQA1s7OoXiHg7NCE+afE?=
 =?us-ascii?Q?nF6JWsIo05nJ/YKB5owI3aAQ0sHzYx4US7mwwbE3KspL1RBlMMgyeZn5mQNp?=
 =?us-ascii?Q?HfQld0fLtkshGl3y4z5w5fPQaWKHyv8UFxCn9wmz4aEVKjj0ihx+5Z5EZDt6?=
 =?us-ascii?Q?K17CkP+Fg0gTu6vrdsjr2aEUr6KxLODA9UgR2uXXsSuYAcaoz606jX83fA6b?=
 =?us-ascii?Q?LzYIqnZBT9QHJXurQCMOPO819h3gY0x/40HUvIGj3FxjPDBYNyKKQ7qPzheU?=
 =?us-ascii?Q?1gSVASN2rM4IpchF+Z2fIyQLuX5G0USxK+REm/LFwV72V4RvCTl6B9G2rM7z?=
 =?us-ascii?Q?sKj+Wl7WDK7c+H7muYWxaRXJROIIi6p7L45gQGeXJvPRjL8DrCIRChjrgvsg?=
 =?us-ascii?Q?ZoJvOwObvECn7IYHd1zz3iU5MFBum36VGfVoRbKpZJTZbvfa8kKSHZZzD2hS?=
 =?us-ascii?Q?zWXLb1aRzM+kwhU+Qaae6R2zssKgNQ6EqQ+YpUV347CD3Br8gDwNzAOJ87h2?=
 =?us-ascii?Q?BezCAjQmwMajUDlNokJCk3PIRvnHvuEh8Gy05x41doNmVN/QEh4rPtt1pHvS?=
 =?us-ascii?Q?siWBPvBGvarHQ+KxTKW7RRgoVSBO6djagY89DsnQcGDHXB1Z6PsewjquPF6b?=
 =?us-ascii?Q?QJt8CuWnn/xN6M8lux2mA19MnHyyS1Srq00P1WYsDhrJPhXkOIFOgLn9ocbG?=
 =?us-ascii?Q?8Yrghv1q9TzS1s3XQbby5rNraui9t/8XYGYCMMSwd1XMLf3AnJ5fJzHin0u9?=
 =?us-ascii?Q?HqvTzZC/xJTyNEm5FlPq3dbjBweZ3CMZOuPzOOHd2knxcwCmIrFm61J/Bkik?=
 =?us-ascii?Q?qv/kT9+tdMu/pW9esaZkIgVGRi2RDs5TZ2kdFvRajSVOG+3M50m/Al/KhU6P?=
 =?us-ascii?Q?VaJOjeXzA/uTw+KCvsPe1Yi+cQUvmbo9Gp+TC1+afNkO6t5Pz+WKtDD1OBcn?=
 =?us-ascii?Q?d0JWhRsrtbIaOZUeYB7lmWzqawglQZKHdNfd8RQAuYVZfJSFkzukHMD3Gdyt?=
 =?us-ascii?Q?OfLlEjjGve7hZiaUbuCSJlrFAC0FpgncqVB4+KVrTs4V3tk2SHRqKcfiGK7Q?=
 =?us-ascii?Q?V8UfLCNzQwy1Rh3L0FVZr4bPKmgAUWttzi40WHVA533cg18o1ijpQGMlUr3L?=
 =?us-ascii?Q?8uVVV79vzLFA8pVE5uEYScYbrlHXoaIxhTasYfl+ziPuC0tlz80ym0d+Yn48?=
 =?us-ascii?Q?9fYCTcHJ/M7+30qOupsiRBEybq18+vG+bCrmdvUPDDp07QHzoP6Bo6xKKH+q?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c320eb-104b-4ff7-f447-08ddb77740fa
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 01:41:38.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znVvwTzewsBVvDFVhgzoQfp7TMXyI6JXAX/sqIX0ztEouj9BlEgwFEmAkmnpP5zQlxRVfWaawzIiKrorUYSjzD0bzRbf9T+bsn9zvHqS1LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
X-OriginatorOrg: intel.com

On Sun, Jun 29, 2025 at 04:20:42PM +0800, Li Ming wrote:
> In CXL subsystem, many pieces of code that need to check dpa
> availability in case using wrong dpa. Add a helper function called
> is_valid_dpa() for dpa availability checking.

Does this have anything DPA special about it. Could it be done in
in a new helper like resource_contains_addr() for all to employ.
In CXL, we'd use it in at least one more place, checking for HPA
in a region resource. 

-- Alison


> 
snip

> +bool is_valid_dpa(struct resource *res, u64 dpa)
> +{
> +	return (dpa >= res->start && dpa <= res->end);
> +}
> +

snip

> 
