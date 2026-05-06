Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98B1C861D
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041916; cv=fail; b=KucmzvpDbDQHvN+BCzvaZeBKw9kUoXpeBad6MgSVeEXyTNjFQvbadDU+12Ao5D9O6wIfY6AD1p9Oabm3CI/9VxivIuH9QwU9oX2L9tDov9X30crX8jz+gK7N4wJUJS+iVwJTcn4eYHR/9mV7qEd61kN2V/7mlG5bWnWtMWJWbwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041916; c=relaxed/simple;
	bh=chlWKzFvr5oMuMJMYYsE3ZsDbni+75dWs5aNNsAcg64=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B/AOrddAtdDak64c1yIwGpcR2l0CLiVZXcWeXOzSVfmdj7SriZMl7LMQnuAiaE+unL9bPxHrlqBF5YpalTOKDDg0ZZJdEstjFX0WLC9YsYhXbQiI00yLrvy6iVxFwWQBh0gVNFyu3jwPjWPW9HUcwCVCVFVxfj4ZjQRcSTN4IHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkMCbPwj; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkMCbPwj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778041914; x=1809577914;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=chlWKzFvr5oMuMJMYYsE3ZsDbni+75dWs5aNNsAcg64=;
  b=ZkMCbPwjUg37pfZdNWWQCfJR9XV7FBni+aq3lSZAZ7perxHikTf8DyuN
   hdC/oQpIC5FGb2cIgkuKUr/ZtiYAS/yrMaLojIj+fPl/W0Pl/TUHFPqi+
   hu731R7UJDlKL75K5CnGFs7r5D5Y2aNP1IJK1I+qlpWi4PplNgFRKVH8d
   L1EVwR53FEyCsBaJDwXoIcEmivrLlCso8b8xF002ww91efocRkTNPXJbf
   6BRZNeCaOTk9k9hsdnY7tHpXI+bDDLz3MwA1yTOEOdUQmR3N8HnUM2243
   Jtz6hPIIjtfo9pC22UGpW3EJTJOzbgF95wyaCljsHLd7IWFElCgkXnpqb
   Q==;
X-CSE-ConnectionGUID: pW3tvZTlTDC8n4Uj6ml/yA==
X-CSE-MsgGUID: Ud/K/L7ES7m3YrbpmJvgrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89522554"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="89522554"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 21:31:53 -0700
X-CSE-ConnectionGUID: z2UBX5ceQCKheYTbRG2eUw==
X-CSE-MsgGUID: g1loYqDKThadG2pIwqUInw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="259673905"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 21:31:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 21:31:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 21:31:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 21:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BikskvdNDlJmiQdlCiGHRsWUplB39lVaszRLiuijdpTdEJKKBqCTlGFeo6e7+YuPiHivcvOiSQgRMIB0BCBJaWjR+YuyHgOKGNeqd64f/Moi//pdFFmiE4GOJ1ARBtAYZSt35TS/MoHN33ZakNwZeAoMXWbsMhWHB3JkpdFdBDkmnXhZWSRDldDBKDVrHcA2Wgw9G9iUO0wN/qVvyAB9Y7nJP4WfCLHoABzfWunLgnmtFQQ5VsdZpdcbbvyZsoOuAnm0F9AJG8P0MwW5KitLhuwuele82io5hcOxU9ZXjEglxR/EBA3+28FhryxHqppyTX+ukBC8sGVIwz2Qy3Mk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQqoiNrSfQGaGUZFCjx93CyBaoh1IvH+qXiZy3L8aB4=;
 b=hkkTwCJthAodPMd5Ne9hnCl/5u0VH0r2GZvSvPDZKR7rEjXYdhYKbTqYmOo4IWl+yc8vNjJl1KMLn8j4wllpE2NUnEU5D/O+AtVugBWDTXO15HWLoJ4yC0z2P9Nk/HZaT7rN0+hDFqxFpEc2CVrYtPOjW6o3+sQmxrIiInLf9Uj/gjDjowY6/YslA0oPJyp2dKpdb6CST9dp6CTVyslKdGsEU4qfEbhX1RMj6r6J4qnGbqjSfqZsR98fQaLIrap2QE3s0u7f12npeVvb2WKyCut1NqPf0F802pfK42jovMZ+2fs8bXhTirQ4k/LRLG/R3SaGqirjNhK62MEECiwl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 04:31:50 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 04:31:50 +0000
Date: Tue, 5 May 2026 21:31:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>
Subject: Re: [PATCH 1/7] cxl/test: Refactor mock_init_hdm_decoder() to prep
 for type2 decoder
Message-ID: <afrELziKpyUDuZXS@aschofie-mobl2.lan>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422230237.2599333-2-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA0PR11MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 95946209-e4c6-4e2e-67ea-08deab286471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uCNm6CCu75qQ2M9DR9MK7HbvErNvNQyhCkBZoqwBusznKjFv5Mwp10GHRtFA3ssMC+hDc7VEGtUbaSfRMxF6gpqU7L8lZLSnjMCiTGzBsYqo54nBVl3EfnZyna+0x+qcyO2fkXIqmUhJUz62xIzZAdcaURluQ0W3BVRKE2ZwWudc1j+IW/98IQD4qB1kd76xAN6s4lbzmHMXJerYbkQiQu8DiV7C202ldH5wsYG0tNhTH9XUwrF/lO/jMi0QKSpz+bLfLUE2UNXdvlX5IpGdNjmREZo8NOZ44SkVNu66kXvdgmyfugoK1YrEfoSHq4onOLGjokDBjlfdDiiTUzgN1RAgCWmtvbXMEFwoxpnUbMzSSzADTjrOsoN35Km8Y5LRgRq3+e1h5ntCcRoMcAqAarAai0NwpeHrHgmbHi7dPhYzJ8tRck/W0QFAGhlrXPnuvFAddx5lgJcdyFY6EMMSflbF6SJzFD5wR7DAc73EPHYgfMCfmT/Qox6nYFf9F8xqww8cxlhfGR5c+wYVWD/TCA2r1g/NTa27XAgP/pbp7AxBfkp6Pj/a+zypiuKJ/8ihgODh9eAA2dLlmRdbvXvSY8D/tuFcd3BguyrWeAi7HpdO7c/Xdd2tXDh/HQLXW7Z72iin/T+o2de/rpWneHaetTdULGabMxpBgu/CJyQKy9J5BJm6HCwhftranxv2lJjN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C2ew+tmAr6k9ZRY/gx99u840yOVN4HXPyaqzlg9U+E/y5rbn1IOnbKtL7UHO?=
 =?us-ascii?Q?+kHS2/+KxvOjT9ofTj0/FAEtaFaU8L+oxwELgpFREDpsaBj9urMJZ71LW16r?=
 =?us-ascii?Q?UE6YqIo/4P44Q9v/8w1W6w+x9kkeBkhb2XTa7j40DPHrzOkukmWv9L0kCa/s?=
 =?us-ascii?Q?vN0emXIEKugr/SorMuDjMrtd7BRYQONM6hzPHGTYpZC1jW/BYXuwzx6/q99z?=
 =?us-ascii?Q?wU78kXnWEp1lk0i447SEN7yuqViH6Q1LBPX0SPV3r618/e7uDmk4Ays0txXM?=
 =?us-ascii?Q?i2AxD6M2um/AaYejTXPxEq8wPzBUIvx518v5TalAt4AeAuSzCuZOJEr0C57E?=
 =?us-ascii?Q?1honEynFvnK5BtyNzOyiX/L7ooV/Jw/uT3uWDuDriIQOocKNsLpyZ7VG9rKl?=
 =?us-ascii?Q?hKqDMzqEiHBG/R5+cWTrEyQ128uEuvrD/B3zt+JKBA5uMYLkhgjC5ZdCMhXu?=
 =?us-ascii?Q?OYH3Yx78Nztqq11vgeyHybKmpeWXh/9LeioZsRR8IBDX4BjfLoUlKVV3PZy6?=
 =?us-ascii?Q?Zb0aI8FIazwZCOfOlH03lA6etOnMXBqd41XMXtI+ZDTkvTgJrT/hIhuiXlji?=
 =?us-ascii?Q?YduP+ekhqqTjUnN9Wkq/AWOES7YoT65DRjUXcVU1H3kqZeZsswnOYzIpmRJ3?=
 =?us-ascii?Q?+ZtWJ0SdNI7Mp5wUzv/9UBNWlMCoMmIiQnSHI9CohWLedRZKX4KklXxh+NQw?=
 =?us-ascii?Q?f8dx+aab5iVYGU/Bc1y9ikByVW9PcSn5+pJUrjd7eTXM8VMe5mX4klmfY2tY?=
 =?us-ascii?Q?EEpbnV6Xg3q6MQDnwf5+pfu5rLNVCE0dIy2PAl2mn1GJthedqiaM9lpwi/Bp?=
 =?us-ascii?Q?x0DANovKTiFT+32/4JhOV/CaKQKlPVwwhrEvbmH4thrdYDi0fJSLDSHwtXZN?=
 =?us-ascii?Q?ZN1RF2XcZfePJMMw9pPl4kdda1fTOi0OkxprAgkRyE+dCNlquZAHWWLUN46j?=
 =?us-ascii?Q?i6vpE2YCu94Bo2OQ5v69upuKZQ7ZhWeuM3tty5V6+QLr4nwPoW/d3jEdbRmK?=
 =?us-ascii?Q?1H2bjTh8yoj7TeKoZUzkXHBxHQugw3sWvhP8bfXLcnVUh++CSldtR+/nd02e?=
 =?us-ascii?Q?MtKxsPMOjVTVD6+1OS0QeQJFItwvWCdrXENnSZtA8ByBRj3ksxGTmHWgwa18?=
 =?us-ascii?Q?6XeXLpTdbGKpk+Aa42l1jRLkmukN53z1cUbId0Gs//Y4Ns3egyLzUj4wHzaV?=
 =?us-ascii?Q?i/LLMv7Li4irtmgmWGDmrSqyQpi4gxFKCFkotz3iJ8/SBedlCEdA6N3ZwrUd?=
 =?us-ascii?Q?UcshruC41YfUKckE4PaHFrVhe7DZdAmgYbNrBZo6CEk8qDSDOjALSoWJsUDa?=
 =?us-ascii?Q?O4yh4xFJAhpgWzsiuAVal7DygronxuVEChITO1K6MGbrn2Rxmr7CzBxwaSOo?=
 =?us-ascii?Q?Yp1F/egdvNnrM/e98/H0zRnrQZ38hw9wLcg4GjKu01vG6zlFBq3HsvYFxLpn?=
 =?us-ascii?Q?0F/ws9R9ivZZotHbFDFbsMUCWynQfug/idwxF++1N7f49Vfb64UriFxpgMLV?=
 =?us-ascii?Q?cWl4mPye/pRejWiKO+llhng+Yu9fwYqcrty+segz2A9UqFdZXPqdFC5rtxhC?=
 =?us-ascii?Q?C18K+jLyTLDD3ionlhjDwqYka1qTXg+TaaqbQG1M6gDHvBwNM9o7a7/6aO/j?=
 =?us-ascii?Q?7IxA4pBEFXA66cwLJ+WfsETtA/1XxOKZ5TFIR/eJLcqLsheo/1RV5R9p/HJu?=
 =?us-ascii?Q?/6ljMhws0o+jsHDTBUpY/dKE9lwKhhiv3qELzOxsOVXF47sBgKDsx/hJl6Li?=
 =?us-ascii?Q?naur7zS/iu0MdSx/k2HNruRwgzlAx2M=3D?=
X-Exchange-RoutingPolicyChecked: AZEgObm7QSoI1VbIlNHICRPQVv+wD3UhlWbzjJUlr8ZXNqlOoLuE7hNyIEBqTeDQd3eG5wV4IfEp1YWmVwpzLTBGbLeYq1neFNSz32ToMwCxIWdxer7DSQO5u/mPvwot2kgXcp6wewD1E7qHDp8irkhA7kLkm3+cKvrFXe+qBznyN0PWB8Hk29BRBpvH9X8QsZs9S3hq0gLF56EJcaHi9uu1H8OX5iR8f3ExbEqlTigfgUCr8WqERJ3RsD+H+xRGHQc7PqR4Jdfz5j7IrTOAALu7L14ISpXAuOUr6UiS/2gf4Mxp4aeSV0PTTSgUXoJiFsBt/mRLw50vnbY7E61owQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95946209-e4c6-4e2e-67ea-08deab286471
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:31:50.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFlFvfprW62Pw/+7jhnESb8HvnaC9HSOOe1kt97PHqgFgADPtidLvPy0uRDQ68Q91H3CFeCf+eNI6B0FV7bS5TWp33zeyuDieyMddOnNmFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
X-OriginatorOrg: intel.com

On Wed, Apr 22, 2026 at 04:02:31PM -0700, Dave Jiang wrote:
> Split mock_init_hdm_decoder() into different types of initialization.
> Currently the code deals with default initialization, saved decoders,
> and type3 auto region initialization. In the future, a type2 auto
> initialization will also be added. This refactor will make it cleaner
> to add additional init types.

Nice refactor! A couple of nits below...

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 184 ++++++++++++++++++++++-------------
>  1 file changed, 115 insertions(+), 69 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index cd47fdd7ccb5..c26c37cef12c 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1052,74 +1052,25 @@ static int first_decoder(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> -/*
> - * Initialize a decoder during HDM enumeration.
> - *
> - * If a saved registry entry exists:
> - *   - enabled decoders are restored from the saved programming
> - *   - disabled decoders are initialized in a clean disabled state
> - *
> - * If no registry entry exists the decoder follows the normal mock
> - * initialization path, including the special auto-region setup for
> - * the first endpoints under host-bridge0.
> - *
> - * Returns true if decoder state was restored from the registry. In
> - * that case the saved decode configuration (including target mapping)
> - * has already been applied and the map_targets() is skipped.
> - */
> -static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> +enum cxld_init_type {
> +	MOCK_DECODER_INIT_DEFAULT,
> +	MOCK_DECODER_INIT_SAVED,
> +	MOCK_DECODER_INIT_TYPE3_AUTO,
> +};

skip

> +/*
> + * Initialize a decoder during HDM enumeration.
> + *
> + * If a saved registry entry exists:
> + *   - enabled decoders are restored from the saved programming
> + *   - disabled decoders are initialized in a clean disabled state
> + *
> + * If no registry entry exists the decoder follows the normal mock
> + * initialization path, including the special auto-region setup for
> + * the first endpoints under host-bridge0.
> + *
> + * Returns true if decoder state was restored from the registry. In
> + * that case the saved decode configuration (including target mapping)
> + * has already been applied and the map_targets() is skipped.
> + */
> +static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> +{
> +	struct cxl_endpoint_decoder *cxled = NULL;
> +	struct platform_device *pdev = NULL;
> +	struct cxl_test_decoder *td;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_port *port;
> +	bool hb0 = false;
> +
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +		cxlmd = cxled_to_memdev(cxled);
> +		WARN_ON(!dev_is_platform(cxlmd->dev.parent));
> +		pdev = to_platform_device(cxlmd->dev.parent);
> +
> +		/* check is endpoint is attach to host-bridge0 */
> +		port = cxled_to_port(cxled);
> +		do {
> +			if (port->uport_dev == &cxl_host_bridge[0]->dev) {
> +				hb0 = true;
> +				break;
> +			}
> +			if (is_cxl_port(port->dev.parent))
> +				port = to_cxl_port(port->dev.parent);
> +			else
> +				port = NULL;
> +		} while (port);
> +		port = cxled_to_port(cxled);
> +	} else {
> +		port = to_cxl_port(cxld->dev.parent);
> +	}
> +
> +	switch (get_decoder_init_type(cxld, pdev, hb0, &td)) {
> +	case MOCK_DECODER_INIT_SAVED:
> +		if (!td)
> +			return false;

get_decoder_init_type never returns NULL w _SAVED.

suggest replace w
		if (WARN_ON(!td))
			return false;


> +		return mock_decoder_handle_saved(cxld, td);
> +	case MOCK_DECODER_INIT_DEFAULT:
> +		/*
> +		 * The default path picks up all the decoders that are not
> +		 * endpoint.
> +		 */
> +		default_mock_decoder(cxld);
> +		return false;
> +	case MOCK_DECODER_INIT_TYPE3_AUTO:
> +		mock_init_hdm_type3_cxled(cxled, port, pdev);
> +		return false;
> +	default:
> +		return false;

default is unreachable since the enum has 4 names values.
suggest dropping it.


> +	}
>  }
>  
>  static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> -- 
> 2.53.0
> 
