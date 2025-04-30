Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA7BA27
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974081; cv=fail; b=KaEE5MWqDD6tB83aCmbcqH7wMb8S78TSzdAd5jM4yzwkgd6Wl0DYL5pXIMTqQavJE3km9BM1RllOEvjodKyb4EvWLiAcooYDzLldTshj/lm7UaUm7xlO1dYDJOYElIN6e3oZpbDF7ksxNdjaMpY9DTOTZ5ZiQVQQj6uao7lLjr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974081; c=relaxed/simple;
	bh=xNXJOoArYcUs/xJp8mheXPG+W4POb3rXP/jB8Mg54os=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V8ltGHeNrcMbGrCn2qZV7Y8bR4uMtLJbDz3JSsiRiQ/P5aQBDyqxoxYrnaIhZqBQFdv+5jYD001VelP3VV80402p7ge6RNwjKoCMXZLUx4wdYODMnjJFEEk62ey1Zeiet8E/kJCZD94a8u/HUSytxxjfpdGRomKfUQ3XFQbd4cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LszZoA0C; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LszZoA0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745974079; x=1777510079;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xNXJOoArYcUs/xJp8mheXPG+W4POb3rXP/jB8Mg54os=;
  b=LszZoA0CfaW9hQH4zFiA65bWwTKOgV1fp6pm6FqpKPVUUipFh2xpMkRl
   MDxrMMzOm8pQa1doqUULj8GKqFZljbxaKZsgjpAzLhkT1IdOAHnceCJFV
   /rDlymlvCqmLjR/6XKWi7t1w8Uc6R45GN4n1s63WowNiEwRodDMvwqa+3
   Yp9/ivkFrD1JZIHF+BM+U1f2h/LSpGxrVOU5ZDon+2mxHF++ELhu11zCB
   5r22MlUjjkfqaWisJExC6upeXCzJTliOEyMY7SW8KEnMuvjGjPeXtMnsF
   RGtcpEn7nSWtgV4lY81P+WcOJNga/MnOBSaiTuQqoUPx2Y1u9vhWbrqoy
   Q==;
X-CSE-ConnectionGUID: 5VTAJzTiRZ67XrwGgm5KZg==
X-CSE-MsgGUID: VJ43rRd8RUaTXAizKlHaqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="70124937"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="70124937"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 17:47:58 -0700
X-CSE-ConnectionGUID: UkqIFQLnSQ23/lJfIgCEJA==
X-CSE-MsgGUID: gYF1MamTTAOaXcEEnxVaiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137989946"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 17:47:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 17:47:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 17:47:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 17:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3umcgG8z9QY3Gh/WBv4MuYSxlF9XUFUjw2qNHehmHPTLzyrSmpiuWTat/LRrQJmkShwTUfOw80x+7w+9tOKOGpVu/QM0uu0/FFjz7lKGv7G2LOh4IsAI4ALi1HpZ3HCg0w8uV5/5oKIIOwSttniT7gw9e8Hk02V5j3XAONPzQv8Sunr4+2v591d1S1uWNgEnZNEqvcS++lmCw0/o4+mo6YyuisVIw+vw486lvWaOain/ssWf2WhfG6u7zVwOWQCyoPc2/KqU7HrX9Me6gRVXdBuRowFNUUerZLEtNJVjaFvnBFiVzsK2NXAkrrxH2eo+VTRPEBarY9kcF81WvNQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8i7hUC9YRcK2pFr6jX/3Ubq1ejjxSP27ZwsvoejRbs=;
 b=v5eYM12i6ca9Nt/hZADe6ECzGNW3FQECBtD7YKiR9ffukfTphHxRCaIn+aRrHDP2PiXJd+JK56tJYXUPLyV1sM9vqzzwyqwXIdtf7WqVcde8U5g9wd2b6eLrjP4Bq+80qaXKyzkiHNjNr3KXTuX7rAUc7VwC+zgg71USmX88oaFUIHJX2aZTjWgkE9uDJvUm2I8L6gfsIkilkhLbsaSRRBhBZmRutV5l0c6UQ58JXLLboxDVqaW3nNreTrEK2bLYjNC2uE0t/2sH66ZdNoKWr7h/LiUUJpKh+HObhHwMm7pdxXfCYbG1PHEP/vCUl0cY10FBlIVLL1hlmy0GW/NV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS7PR11MB8827.namprd11.prod.outlook.com (2603:10b6:8:254::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 00:47:14 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 00:47:13 +0000
Date: Tue, 29 Apr 2025 17:47:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/test: Address missing MODULE_DESCRIPTION warnings
 for cxl_test
Message-ID: <aBFzDexv17UcuLj5@aschofie-mobl2.lan>
References: <20250429235953.4175408-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250429235953.4175408-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS7PR11MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b34db1b-f1ca-47f6-a859-08dd87808c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?02ZnTOkZhjrLftA0bF0Og+f9gtdzfqnr58hw2uAbq1cXmD4zbQBFB2yheJF5?=
 =?us-ascii?Q?fpao8Z3oai7YQfkFQoP+9wEmEaEFd9NkGpS0bF/4sTsQugsDS3YEbRDJLlkZ?=
 =?us-ascii?Q?uqlh9MyIy2C/ghdMMlLE8KYFhogbBzcxMkYUd5oaL+Cl/S1tTB4Wb2kOBGLK?=
 =?us-ascii?Q?nN0NJul+DwgGa0o4NpFv229CPqff7NbB6uW+4fXTua9zhl+pxCuorN5fnriN?=
 =?us-ascii?Q?17nyazYfzhLXKHU5pDM3gmnWTQSDwDoxK7/vZqNEUJDL/6dOvJUNgHUKpJZR?=
 =?us-ascii?Q?cy8vLqj8lJewlueB5mUJEsuW/Z6RCJ10KtV5KpONFEZzB7DHhhGw/KKvAGtr?=
 =?us-ascii?Q?zP1f4Ku9BJa5ebLc6ZKCluIz2rPPhQhiB6SyiDAQ3mP0xEf2FQoo9OiV979T?=
 =?us-ascii?Q?b6PV0Pp6mYJAJhNgsVZU4opcMitL7w0kgzjzS76d7NXlQB/z4lXMuPOBmHt5?=
 =?us-ascii?Q?FzLFhHpoinL6JEAfOXr6Zwa0lTMi1+OsXLfXOPrTs9+XEd+S6cOl1VEVuO+o?=
 =?us-ascii?Q?vUnqViwpO2eDu6Vo+B3+aIGSeNcG5Gqbwx3POedEk1WKGHkxjtQdphQIUY7K?=
 =?us-ascii?Q?D8zgbAfFwVKKvhWxKKg0nvCoyyJsbv0mCVtud4/w2e8s4rczymcohvjDphg0?=
 =?us-ascii?Q?KoapmoFiyKfI6aDmtCEO24QIgvr8AZtqqco2rfFF+8uLbhZ5nYVt3YZVuE66?=
 =?us-ascii?Q?XTD9FATOd4t+3FMF5PFT+Ac9P09JMSTnweOu62dcvywn+D6IbrnVCFaa5f/D?=
 =?us-ascii?Q?WzBChiC/6bB7gFVq7/eGBExn29/7OQ+S3GyjBIqHs0+mifjswYpHlJHiueE3?=
 =?us-ascii?Q?evfZuty8qrpkJ5KVlrH6wLYunIKHCNTIvXR+nzVAZsEh9daG0gggGLGd1WrK?=
 =?us-ascii?Q?thWIyH76qJY0hUtP5mTyFTJieTooLsdYxYDfaCQ2Fc6HW8+KEaoIQ016hNRI?=
 =?us-ascii?Q?Z5UxjIfMxdyh5xq1/dWiIHXzPV38E1nA0K99jgyL5IAujmqKHB3OeOXQa1Z0?=
 =?us-ascii?Q?PSyS0DklM9+ln4JM3QWBEJlVTh2PyVwXx5d9QaIRh+tXEewGt2cFuHkAMIk1?=
 =?us-ascii?Q?m5/z/HmixImp8nm00scxv9ebZVewkdznS6dfuGa1weyHSJA9pmcucN/po6gO?=
 =?us-ascii?Q?9QUcHIULU84q0graOWpMoV4Z/ovZE4FSa4vraS/tw4rtX5HQxjs+IlKTuJxO?=
 =?us-ascii?Q?vH7XkidiNeTca9KLunYDB94HLgoLLnE/zXDzZbIhlQZelcjIYngne24d++ZU?=
 =?us-ascii?Q?OXSQXOGtjcwyTk30NjgKLVMhHW/MO8xaxb1u9Yd9yyERFTn2FwDZuKUf8p7B?=
 =?us-ascii?Q?96NcJmlTm3A2iOi0N/nHdDIDBOChvT5kyer8IrDFawtJ9Nz2aBUDO9TcqCsl?=
 =?us-ascii?Q?XdsPiZa4FZibFXxoTl1ejAI1bDJgxSOsVkGH9J6wdjeayppZmrEy/0WkgjH4?=
 =?us-ascii?Q?suh/gOIh5Tg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?85yqD4cvnWwfOldDMdYfT0P0rrHysl0mX2IGpjc48ykEUs4S1RpoGUXu23HO?=
 =?us-ascii?Q?H+13BIV/r+QTFk2OzkpcLH+afNkne8yYSLfbA5jevJe0ygH2CTUx7uNYUuNg?=
 =?us-ascii?Q?b2cGMhn2pXtfLT37yqpgaTum59SKsEDXYUGLyk6VIF+BcfxIggae+WqPN4aA?=
 =?us-ascii?Q?5Hyy1OUX//EDC9hFyEiDbvqfsnZ2o5ov/WMyj3GXa/mh2jUW0KncufzuDRmO?=
 =?us-ascii?Q?T7X0xn8GpP2IHWflIgQzZt1v0ZE8DRpWrcWIW5GY3L2GZsFJp8AGsbcBnhfT?=
 =?us-ascii?Q?Wbzx+MsB8NGdq41aCOHgSbhGHmfMo4cyGQX9dQv9niqLC7J2G9+AsuI+Tb57?=
 =?us-ascii?Q?TxLL51HQQyr5OroaQflfmuiZGvmDvAqNesVVrem1o02o5UhWoOflsZknKu2o?=
 =?us-ascii?Q?eV7IXUkyyrUDEJH31Aevwbs4/fwt9b0dFEA9hBUCXZ03qRa3Ci5Ndq12v8m6?=
 =?us-ascii?Q?SqHQ45N0s27G5ZpOuD2dLjvgp893t8e8FP3fWcMb5ULJCQUkKXRSZatsx3sp?=
 =?us-ascii?Q?M+Ld+PIJl59XmJXLq0thvzcXajFiq7Aee3Puil1nFF2PgNPi5enOObgAJhLH?=
 =?us-ascii?Q?MfxtJzC8mdtky02VDTVkiKIO+AMkXgSyQqkMBzdXYZyhDOSNhri3MvM7KZsK?=
 =?us-ascii?Q?Onmoq4lMiBltn/oGXN6ik1Y8/RjQYPr7F5SZBPRBXWJu8cnYvCjHaHfbTFU5?=
 =?us-ascii?Q?xJP3x5tIRj7yIVNqStFDWFDWjw07XNhJOkN9owNz9dalEe8xhf4/o9sFkiP7?=
 =?us-ascii?Q?6EpkBeH4YnDgo/lNlrQkXjMzXmY3dxPL4J5YucKS9Ribxu5K33SYXI8pm7iI?=
 =?us-ascii?Q?fEzQUOs4AToCzH8CPppQoFvG+t8fQwIDvED9ge3IBEUWBruUHe5XVkOrqOB0?=
 =?us-ascii?Q?zuN6OPCxTf8RDy/NszjVjNCrZLvrUxKOlt61ASLs8nrkNicR2YnMwDKaFJK7?=
 =?us-ascii?Q?GgCQz2ceK+xebPgFQEHjzrCYIMo2JwohCyQz7M+JTI0tefWZmWE6eZzyCr1l?=
 =?us-ascii?Q?dtj24y0V+ozmI8zdq7KLdEv/hwY2Pz4AsIwfSrpGFceAoYQtw8rGt34fo6NE?=
 =?us-ascii?Q?W7QJI+5eNbw0B9bVDbSSEpsA+NgzMbw+3OheHPAqEU4WyluIWfhA+yl7IWB1?=
 =?us-ascii?Q?KliEN32vByVJbrbWF53YPVV8zn01R0tzgzvujK3+gL+S2ALtx/wyRcxLm/3j?=
 =?us-ascii?Q?RjuMnH90AeQKRXHJ5tcLmRBBCjoqOwYgi9ZXrPeweifZ5koX8aSLkjoPw0ma?=
 =?us-ascii?Q?dKCRdo3ETC/DCJ1d0Yt2YIj11P1xt09fqkEsWt5QdmnZEh+icObVPXDSPohW?=
 =?us-ascii?Q?r3/rklrpAa0/yRuU+IPTYO/uzmyjSA8zkSynfogHruAOUBzRPIOHViUv52Cc?=
 =?us-ascii?Q?lLw5Vl61/cOn7qmDjHFk8xsCF4Tc66WF8IzX3ub26TW8cIjF8jdCFDYK6nV6?=
 =?us-ascii?Q?TlBfsX4C+Myu/XrU5Y0JMvSjy05pK8187ENXCgZb54o+w1O5U7ce/NLddMIN?=
 =?us-ascii?Q?kmiXoVxQt1+vLTAN3PJxqTltWrCLebIffa4oZQxnQz3JHFYHHmFTdaTMeyNx?=
 =?us-ascii?Q?FSGzIbBjQX6o3qfMGTFMopsuvcLaIUNjKlgQbyIIur7JB4I0lHXcgayfbQna?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b34db1b-f1ca-47f6-a859-08dd87808c68
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 00:47:13.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqCyZUNone0IPsO5TLp8dr3c+44tdGToC0+tPLPMQtFnSL2D5qcgX92O8ydV7YgKQtaxiY2THfYng/tpACdUa5SmGBo/r3m7JaZX1eHjeF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8827
X-OriginatorOrg: intel.com

On Tue, Apr 29, 2025 at 04:59:53PM -0700, Dave Jiang wrote:
> Add MODULE_DESCRIPTION() to address the following warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_mock.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_mock_mem.o
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

