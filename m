Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB71BD9D0
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245722; cv=fail; b=ZwSCOwag+0Nf5ibaswRGaYJCMizMP624dPNn4pykO2o48ccU2PS9uWaYNkyvhv1ot6lP0wTrQSpg8CBUX1S/13U8j8rctOkGJl3TbxH59xMoxYFD3yJDAOLPwVEwPUnxtyQQNJHjPWDwokiAEdz8NRtt/l96pBGmVKJPQJQka+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245722; c=relaxed/simple;
	bh=6hMrVg2kuPrIkSO0WYhcSYUoVg76PpwRUrFYKU6m4Lo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GLDNP7PKBQGpjq6AHAs49GXPNUZTXS3tcM/+13W9M5R13jonEKwXlQv3zJs/NJj4oWFIsCt9VvksgzDNol8EbaMnBcQtlI/MBWMABiyculZqn22PAQ4pLZctwfp/j+5fURabYm9NQgDPpCH3mK9wvn/tlmWE47aroHS2Z/T/SLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njOLRN9M; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njOLRN9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779245721; x=1810781721;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6hMrVg2kuPrIkSO0WYhcSYUoVg76PpwRUrFYKU6m4Lo=;
  b=njOLRN9MWhj35D69oM1vekUT7QhD3CdZuJUJlwqjdEnyG3GwfT8NMeZB
   1TaQPDDDcRllzt6JwHU1Bt34ptNmVCENMR20bT7JML4FMl5j2Gzfgytfe
   2l1AlAMFbUoeUsKBJrntHYKMZQOFWWATjC6s3IqP/QfREKOCpddzGVlrV
   7HAfQqyH2QjWGsd2gTZNjM1fkfVq75jGFVv1liyOJi0VhDLBb/89kYaTv
   XTBbPi6NCNCviW0zQTT2IDbzGuyhEiLA3YFZ17fHsaZtSR5yTwEUoct3V
   t2kqVk08BZxjIu5M2fA4dXSQSaP5eHskDBSp0hArw6zSArNe8oVRJGzNk
   w==;
X-CSE-ConnectionGUID: j9CsQey4S8+9SE2yUgUuSw==
X-CSE-MsgGUID: igJrDVt3QBK+745mAy7fLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80190199"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80190199"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:55:21 -0700
X-CSE-ConnectionGUID: G+YOH1oDQ2Ke72zHKJbcEg==
X-CSE-MsgGUID: cMxk0Oq7RHGXv5Pka3iqMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239150397"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:55:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:55:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 19:55:20 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:55:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTjmTT7mypUurWbuMHxl1z1zi1m6/bnDV6BDkp3uX+QChSRlYOb1OETtzHeoaDQF0gKVb01xSwTyO0QDbAiSR0jl3lpDL7QK6E1O0VSuyPN1yrCSbCCgib3GdwBTb0VqGSFHzoe5OBqUrHWd9PZPEWW0oPC93HPiqDOwBEFyxxgjbOSJMupPykhT0s2U///TV9WPp/w0Q8NaXi6GWkHeRjuH5w0ligpfESmDewGDUrk8fiU1ED0KgtXdFhXXEI+w/MXT1E0LIFDkGZ9gnX7SZP5u/X8U9DYT5TfXLx8wiRiAdkzFNgC2oOKYbvXbzDid3QKWN6I9wiINYEwxtWGFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hMrVg2kuPrIkSO0WYhcSYUoVg76PpwRUrFYKU6m4Lo=;
 b=lXZolwqgx1bLuC46DwYVIVHVtd1YDaayuasIbvMooEmPT8d2sG8XqzimRSvZroij0EA8LVLf+8SsNbS5W+ve/6R5QrqtoHiMU1FQLEY55/HBxNEfJYyIuUgljrJ8w+HkRtXZs6LX1NPc8LrMhSNsxxUs/4bEmYMtSPUcgy/DCm/pGvMVTYQjIikuZNTmH49xnqRhW9LsPJG969BO7Cl8BU698J9Nqb+kGWU/mdnOK4e0Td8hSmG6EeL3j+G1TM4kPWG4Ns8NPQW2y5EaSrla72MasPiVZVZcT3HPSvioVzZbHpIMWPDqFJUC2vrqBDuEMxsEAdAZy+5Aa5cTPuGY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 02:55:09 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9891.021; Wed, 20 May 2026
 02:55:09 +0000
Date: Tue, 19 May 2026 19:55:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <djbw@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 0/2] cxl: fortify string fixups
Message-ID: <ag0iiuQkQ1RmoN03@aschofie-mobl2.lan>
References: <20260519221204.1517773-1-djbw@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519221204.1517773-1-djbw@kernel.org>
X-ClientProxiedBy: BYAPR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:a03:100::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b0de8e-9582-4268-2dd4-08deb61b3483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: KFF1DD6pruubRPEjSBvdSBYqtqO8hWLoZjN1bB/ObFmk+GhqrHZVUrxIPc4SBCqgfbuFazsoyIILJ/I/UGV8FRObyxjnDcrqPKjbisUbtXUbol4MQLvtDmVZintZneKkgnPoHwbyDEoHh59O+9CJHOrolzfT3XMruxTwwAApPe8CuxrUL9ru6+rz4/CLHdwUno1uIFmeEHl8CDVmZGLEJXbmwzxfnbHJG9cztH47ZAtPc4rGDrUsC+l+zvzTyPtqdLpCS6nBsw/cyDqG79HcLzFxPeHTFXqeno7FpwpKdHRDZe4N30R6IHQvFCyF6FyISqCBO/nVYilhVX654msxhfDSAdB3YuX4KJZdPqJ3LT64jiirdK7IRlezdg25jHz2jCU2AofQbItCgn9FamEKRJAN4tPJ/M+fmuR6LneM7FO7Oo7dBffQcppMmYi4VLPBiV9J7mn5bcCCl3FNezAvqZDmmv03gDA8WjbWVYmJaGkFuTEBgqZp8R9zK3wo1oj3PxyPp1uxJBO2fYr0xyieBco2hiRxav8aWGCvhhYdSyh7ZhlufHY+1DqhxLF6CfBLQwFk8swsUa59Zzy/PTTsPd+ebRURrFfYx46SkVWQO42+O+ZD1Ix8dBKZIpEfQURnoe6P/NUIbosursU9zjWOfaHfdG4QIeSMpVpqqmUiSYBMKvmDoLff9Ibf8sSU0AZUWmYi1o/gt9acBuj7lDqUQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2d2/ZaDbcjInfqm0+nM9WCnu57+HJxprIpdqqPlREI2nh8J8/ib5nA0ibRBz?=
 =?us-ascii?Q?KRbesliOheGbII8W7gjWhb2lOVaOrzfhLU28v3u0h63ah/wFDg4BRrPabRl9?=
 =?us-ascii?Q?uiUlJVBP5ulyNab1PE8kAa1oirrpFEsPNKie322S713myWS1iw+3EUCs+/FM?=
 =?us-ascii?Q?W7L8nGpXcNZZPnxmOJABCnJfN8u7DeEjy8CzcuIAt/9uOv+Umqa8Ry6k8EWq?=
 =?us-ascii?Q?ynPkF4RD4cPs0Ruu0cnEoAkFwdLcfWN2QKN26CaW0BYpayoZYkfgOBsK4hiT?=
 =?us-ascii?Q?h/B0Me8OUVc/A+908ahZcgrvjgfqvc1YBN9PMS0D9GY+lijW0+5bW8naQ+Ae?=
 =?us-ascii?Q?zmULTu2P8dao6oUDnekl8WdSfmFZ/TcuYC/XULAzQBl60pfSZAmF/jbgcd6K?=
 =?us-ascii?Q?1NuLAL1AJkkPER9emUXhADGe3BLym1LcRiiUvStF/PjgzDaWJDFzuMS5q3Wx?=
 =?us-ascii?Q?uQUhf0sVbxVN6+Kcigi9e8FgEkZ3pvL3isPmotobeUhCqcJRT+jqIPfYXHmp?=
 =?us-ascii?Q?xCz/CnB+Aj1j/CTCBcbqH5Q2QTBF3C2yuQ7selyoT1MFbvzSWQO8Io3fmshH?=
 =?us-ascii?Q?eazr0Y1Iae50pOqG5QHxD3MwIMq+HTUuFKxso8JfR4cW4MdV9tlNyHODbvS0?=
 =?us-ascii?Q?CwqAbk/LTzrFnKXSQousb4VEncsuQUXFntS1XAR5h4KDX/n8hl5UK5L7Ugbq?=
 =?us-ascii?Q?WGXFNdTlhUhsmnWu1jHJqrj7MsqbDNll+jEfx8uYuyGINd5U9vrQZZgvrSkM?=
 =?us-ascii?Q?+8ZasWKLX2Sg/T3khMn3K+Zwr7oi8Psn6VbDBvcn7kmk2fW+NODoqSOwdwDF?=
 =?us-ascii?Q?cmIKzvnO/+nDXKC4BRg0aDMQYKkBV1rh5K5Ciy0toE1uidpmLSkaDyzzO8wh?=
 =?us-ascii?Q?09njNpMcOpBmbfEbRu39eE87GuC1m39Y6lHMtZz5qNds5Sm/HBTioccPvv4a?=
 =?us-ascii?Q?334n/r3FAsztI1fuqCWxkQtRf5SCEDGqv6N6gQJS3zENxm9VNDNaukvgZ0vq?=
 =?us-ascii?Q?qKgcV97FBFQr+l6FFsaGCgSyBb2abBsu2erBEWJnDgPIa77afAnh4Qr0EYjn?=
 =?us-ascii?Q?q/Nm3MQyargGp693UFEZHt6LXeaskrnwSCaUbwTF0PGoicIgV0GXA3lQnPGI?=
 =?us-ascii?Q?CNjWM9qswsMfbeZIVOKGGc4pvymdr80JxOGw94puqjmyoCb9QXxqTpV0LPTP?=
 =?us-ascii?Q?j/3RzcEJsBLuTETsi0YRUsFTXQxai+3XLkgj7e2vhuBEQfGjJngvnblHaRn0?=
 =?us-ascii?Q?vcOAxNpV0LYGF0n5LHRdGsl3fOnsudJigdp/rh3GHUld0ck4uO4tJZzumfjR?=
 =?us-ascii?Q?FRfBM5XA4v0lqGHdfNXvXNopAqUXIiWNQszYJzixCr5Mcb00wEjtx3HyNAx5?=
 =?us-ascii?Q?XStPAI0W3Ce89EYoUydANycjZ9PJEUPRtjoNEWbd7KY9pRT4gPAwGN4PpxIK?=
 =?us-ascii?Q?+6BTQ0igOJypH9sz/YG9JzCkL5eXJWgJja5mBfCW6fZboUkK2DxeAEaafNa/?=
 =?us-ascii?Q?yQKW1S8ArLGjffHZV/T2fTTuxM05AFhC794oW/pZCwr1iy6VQHUJRR5n6JuX?=
 =?us-ascii?Q?uwf1I0Bop7kyk67mLO12nNDXveDLfwqW1l7Yqauz2WNptpqUB2BDKi5mS5C2?=
 =?us-ascii?Q?+p9VXGlVtLl2/nFmXrfXs3GV0V6d0oGomKIXKrVKaejXOZeBv8pm71thP4pe?=
 =?us-ascii?Q?izcpZgXPREFnNgkVWwPmauFhnahqGPV9cDgXTYsMaPxPn+xNZPH2Vs8fCX5j?=
 =?us-ascii?Q?bjyIdf2sZwYDymDhNqdpOFCLmPZPpek=3D?=
X-Exchange-RoutingPolicyChecked: cjhMKipguTFFLOaS8ES4f1h/YqfU2JJzKKq6+vy3ILqdLb+nuOQ0b0BvzxN9F+/Qedculf32gGBfcyKFhlfRhR0u6aV2vDaJE1ftGGRXlXrvNlXroN8KsWj15R1StR7VLwdB9LkC1H6ZYCK79NiurRe2PwqzItIjKwUPSOGftW+GBTX+DlTSZ18FaZwG8+hluWDyDTfP0lDaajR15GUmrOnCCvErkYUVOrzoAa5P9bvnsdcKAH4dfdGFG0h/15s8U1NM2WJyojvR+onNcUcte2TVafJVR73FR/sCkHz4PFjsZBPDQ9XI73rvXFZfnwOfSRMHlf+hR7gOn9Zohtp2eQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b0de8e-9582-4268-2dd4-08deb61b3483
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:55:09.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VexwFDc5TccGaZ7DlCy/bEnemcLNb/dF7Ftofj1W0oxfGlZSc1VQG9IooBxVnmly4CQ53Pj2A+5sendh/Il72KXTKyENRSBZClcn/wsQhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com

On Tue, May 19, 2026 at 03:12:02PM -0700, Dan Williams wrote:
> It seems nobody is running cxl_test with CONFIG_FORTIFY_SOURCE=y. A

Added now:
ci-base.cfg: enable CONFIG_FORTIFY_SOURCE
https://github.com/pmem/ndctl-test-runner/commit/7b4e823


