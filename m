Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE1205AC6
	for <linux-cxl@vger.kernel.org>; Tue, 12 Nov 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429774; cv=fail; b=QIMyE0sDDxAMJ9yVVeX86JMWSsNyRDBGgQNnlMqs7OQa4zzHVg9vf4BEvZwm86K4phAayr1Ly6vvUNKwrlnjcnYtD/ifSk9opadzusDjGxpvOp6+e0ny1HupugblFO7z/4oHkB22hu0T4zgwIbMTy/y9X/kVsvw8H6g4LHDpbRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429774; c=relaxed/simple;
	bh=o8VoBzKiInx+nAAAkaZe3LVLEsxaQjXnMkodTdrsi7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DhQx5FkJDuayu8UpzjBBf0nbiMODwO2Nvl2TopxNU0MivZZIjYZcpgCZyFW6TVSmO3jXGD6NvBHqkLPgBRDWQu2FbEWw7YCPxV/l5m5CPWUziTuuoHSR9EQX01kNpjtjQKTkph597TBXSOntS3ba6NFT6wjiNDcmeXqRYQUMeDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ew+3YRDd; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ew+3YRDd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731429773; x=1762965773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o8VoBzKiInx+nAAAkaZe3LVLEsxaQjXnMkodTdrsi7c=;
  b=ew+3YRDdZMO9q38BJ+P+FcBgkh+5s51cWTm5EWyg/0BB7ZrTgZDQFoyw
   vWwuQXSLz0tpYIvSOuCo9KesejlN+/M9OvWaF0Ogr9j3oGF+4MnLkHeDD
   HO/ymTIxu/A+15aW+SPq70iXlAg9R/wZr9pVZ0KtIheQJm6h3/i1/eXZM
   mRfrf6ZJG2I5Z3AKCmA0XJEMeXdXbuM8EyPIDwNAvxDFDa5HC4RRg6TOP
   0qcy80QxLuwdZlSVOo4ul4qoBfHM/J1qh9v8fRKs+VN5WgBP5ZqPC1ORj
   lX1MbZdxB7GN1+E9y3AxVYY3hl1FspIKwoFfyotUHYiaQEg8dQB6WgzHQ
   A==;
X-CSE-ConnectionGUID: 4tZ1unpcTVuPzcIOSjRK3w==
X-CSE-MsgGUID: l6zdiGMsQg2C7F3s0WufZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31129612"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31129612"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:42:52 -0800
X-CSE-ConnectionGUID: e/5jh0G7TNe8R2/M4lKOVg==
X-CSE-MsgGUID: I7BcHHYjRpOejxmzjFC5Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="118498468"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 08:42:50 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 08:42:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 08:42:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 08:42:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVmZIcftQ81qntsHrYQ4FXzi8b9zBoM3I73p/L+8C5yhw+g+vtORCWJ5lXVb/UJuSIEWSEbTU1ECTxyjo7uHRi92CJAKz7MfUGk5trCJNnWazw+faNQ+E3WZVWSluUtXeKKmcJ0XQSCBzn7II9su4BmFtARnZ1xu/vv1KL7L/6klx4gfi1pInS0eF30Zy0B5jGqVzNs5aOJr26bA4eFiWFXsFMl/IvzZZ7EXJa6Ij7FW4d9zh5ZNVxauYGiWwxfBnp7vqG2Jpsa9PgNOZoJfjk5nP3R+nw7VtidcdjCq9//pdWfkvDPcBUiEDvGnxPW73/aBqwcEzC2WIn0eoKgWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK3A2RBCC84j0Xdwi/DJOG6M7l54bDfXR1oxY0Rvyts=;
 b=N9QRL4NYVMr09cZD+bnL9sRxm0djFQZtDaHPvPYf6z85MGF+gtXVOqOa1iK45vhmr4XRqJOwRe5va8HKDYyRL1b3jJl8P/txPk8A9pRzp0QhVJ72BEDJ+2qs27QBzUIE5SfpeDAjzLrw6MkNVIMLdtB5BecopNbUF0DTLTeirhgkNAwGhuoa9ZHmDD5CMOPgLgALyPezjaUHpiHZM4RnE5bBHG4n+ATmzqzfx1OPwQxuCIEa3V19F8gfBvjpk+/ISSyMXeHsyUEdI8YE8A4aFZzCbRAVuG1M9KCNshaCOZ9eZRrQCfgrCCW5nszFWD3NBr2gzUGZapwi0Ixoc4gTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 16:42:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 16:42:42 +0000
Date: Tue, 12 Nov 2024 10:42:38 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<dave.jiang@intel.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] cxl/port: Revert __free() conversion of
 add_port_attach_ep()
Message-ID: <6733857ee7922_1cc30229435@iweiny-mobl.notmuch>
References: <172921380683.2133624.1708770961640157143.stgit@dwillia2-xfh.jf.intel.com>
 <172921382410.2133624.570103049126168259.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172921382410.2133624.570103049126168259.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 66009b8e-a771-4816-7472-08dd03390709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?snl31SVnG1cGHLsysSPIJaGSvHdcLHRj4Sg3DjTvHRBIJz2RD6Mdv2rh6rAm?=
 =?us-ascii?Q?a9f1sG9zbdnEYtGimIYGebolhXgjD4dYriFRBNqt8tAamUoTnTGOHMwZh97P?=
 =?us-ascii?Q?svmjA+fTnbeNXZlteIfMaznQlnELOeBU5I4sKcF0N1JDVNukIhiENRx+Rhz3?=
 =?us-ascii?Q?sHDV8Z/Jh3HGJJHCILE2g2akfHE/5ZvbMX2dhQ9tuB+RnYf3l8BLYgFFD08F?=
 =?us-ascii?Q?vTvoD1w3sTBrVRCII1hGyom9mZ4f6eP+rFfLL6E3BgoUwQLzGqvkv+PEPMHJ?=
 =?us-ascii?Q?M0/EF4guU8RraERemWGBpwGmHbTee9W2IeX6yv+AubkI96LntTU7k6P+43Op?=
 =?us-ascii?Q?qMizJ6rev/91Rre8ugpc0ZXsD3mi3w17xkCozDwXNCOIOOUjPDeaQfC1VkY2?=
 =?us-ascii?Q?AtV3IfLiAipcGEQamC7DaISjCHrnweGobagVKubluGeRfBP9SBBPM/TQLdzG?=
 =?us-ascii?Q?3VSCxM3oF5XI4d+R43DoLOHlkxVkeUij5351INFxCR/Z7bol/BGPXY8wHAVp?=
 =?us-ascii?Q?ckKvIlWX38Brgi1Nb0RWIOV3JhXlOwgYywyT5GW2cD3shpovvIiFiuzI5tIB?=
 =?us-ascii?Q?XLEdZIPRdPsdmF9TqH4ynUiIwhjCkz8DkEy0sNv45IUsptKFxcClOH4CPrEu?=
 =?us-ascii?Q?sI3ocA0WIMVRepnNFf7LfZcJAxrBhZKHi7/Q3ZOgCp48SHlBCxRYkccccJNl?=
 =?us-ascii?Q?AbZqCS5yC+RXM9jwB+b2XpEsfpthcbYQAbGLhbzlHDEMSyvyzOo5OOVZQkvn?=
 =?us-ascii?Q?oD9cGiGPWpgSV0bLrWN5oibU9aivWmOJXQNgSWCq9oHzwgqLGxg4lYcSq5vN?=
 =?us-ascii?Q?6aBjdDcWKdJsX40SkoQK5i7vBvC7ZoF3mmDDPkZDiiMqqTJFO/O9bj58ywgV?=
 =?us-ascii?Q?O2B6yYjwu4MSvvotkT5Ux0JFNvLjRLo1NAlUEXweo0WXV3Sp4b97ZMZc5UX4?=
 =?us-ascii?Q?7/IYGKFGyPKSE4x59R8Sps/20n72R8sjzN2mP3uLc/NBi9IJX/VTZNe727wK?=
 =?us-ascii?Q?NZjxrPZBYZ4DSs+whz8Zflz8o5ZetPqJIL0UTk2NB0doM8Fvqyf6sh/p5qIU?=
 =?us-ascii?Q?JiaBpvRED4o7wnm45xP+7K+2fbArqei2tjCw1vH2xo/oTxklZyk+tHyaRlny?=
 =?us-ascii?Q?yJlNZSxa5z/IDXybY6W6kBa/5CrW5vX+FY84VdPR3NBGF9FEAd0/li0cI5Wb?=
 =?us-ascii?Q?bELc3f8EAMA1UPsz6eRkV1Q5iS0TRGX4+5giMHUWenKekpg4Z/ClTr4zd8yq?=
 =?us-ascii?Q?l9YL2ac81DHc99IPv3GXUkyJXoDrffkoH4CHjYa/6qEAP2tv3L2v03CinCfH?=
 =?us-ascii?Q?zNCkKWEXwUau1JIQBGRJHp6D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8GkZn75kzA8lVK/kWUh4pBNKnlKkxN05e3yvw4sZavJUJ1ik25x/6MCJY6FD?=
 =?us-ascii?Q?rqRzdq8x6OFZagw+qnwxwcScWPqM07Sz/j6hsiK97T54/sXnIgnJgdRY4nqm?=
 =?us-ascii?Q?sFtrYeUGrx56y7O1qp9zjD5+HsRyUSWsrulqpa/riNtqj0A+yn0mf0UGLTLe?=
 =?us-ascii?Q?zDwA1QR5TQa5JrrQMX9z2cV+k58hsUKIFQJFfRJ535YPQm/CPbHLlHYaCVVE?=
 =?us-ascii?Q?bYzRaD3mtvJqWCGHd64/7JejJRT9JsBGv3+9sMVVi1K2ontjiy9S2P5eCLrg?=
 =?us-ascii?Q?TCZdVDn5r2oGwFjaDVs9fIgCmZqZ+vgPrVDCv4sM7T0p6Cp7+m8dbX3ghyUL?=
 =?us-ascii?Q?PqQRGR9tLL9rDXsoEjBk/yorpeZTZrVfiMrcnhlgTKgAsg8o9EqDUpsTToGr?=
 =?us-ascii?Q?Wo7wchBA5TZAPRG++DaTA7D4PFgXU8QAzbHKeQ3cgrAuFlpHHNW4yOSRVa2Q?=
 =?us-ascii?Q?oGOzfG1G7LX0XMpqmcNJG1Z/FXjUxuuI5U8B+Xoe65/0aXT+aoD6kWybFIEb?=
 =?us-ascii?Q?/1lDqkCyks+n3WFEu5V+jo566GdeX+voHtxkMi/N7c+SH0vICf6feH0dnlux?=
 =?us-ascii?Q?C6Q2nZIDQdx1JmVpGjQVTa3LIp61pTYEGEIOY5r1snV3rb6tkqnzdU50jHX+?=
 =?us-ascii?Q?h7BBxkjgHzk+UyHWzDiJv1qpNHnTCDgWuYWlguMQx8wio+08nee06eyRlY5s?=
 =?us-ascii?Q?M/npN6lFcuysZOZa4IK6EpG/jSofcOZJ4oC224S2oK8voODdj2CueTYsXJCU?=
 =?us-ascii?Q?fJKrcGwT1DLOcbj41oPmB4Dj6c9g+wiQmISJyd84dT4az2vLS6a+UzKqDm4a?=
 =?us-ascii?Q?oavXUnhklDVdFEliM3nLhgVY52n8ieHd0Lz2i60IGNBirlg1xP6b/92M/Taa?=
 =?us-ascii?Q?nQMe7TVH4BjKuBmQmcHHtCINSNpv1FkrIi5Ktn5H9uSCMd/fsKGI0Ck5dntU?=
 =?us-ascii?Q?IGicBRU2xrfeXd3LTVJsq5S+KL7WcyK4FEKWplRbh+JhM98g6yW4XF2vR37j?=
 =?us-ascii?Q?TOcWTV5Zcd5WoC2VxfWwqhyR5l7oUmNz4WpcSEETLCmHq6a8RzLKX8yQrrl3?=
 =?us-ascii?Q?t2MUrEjYMWIQQxtsy9/ezaaB3sEW9n3Ij6VcI8/m8Qd8EoXCo9PIi/8izifO?=
 =?us-ascii?Q?YOHhBW0D3od9VTPzgCn/8nmmtl5k7QX3EC9+/P8zclbTSK+0DSBSl5WN9f68?=
 =?us-ascii?Q?eqP7uiVyns2eQSnbMvqGIYvyWJ4gx2UOtc1IV/FQTj25kR5aQB+mEoGOwrn7?=
 =?us-ascii?Q?6SBq0+2M7PO1YdnFcb850HdJaWgmy/gfJSZemBQTi8Rk48HFEdBsxPNuOZli?=
 =?us-ascii?Q?KdHFWbPnVEbz1F44Fob52Mmag0oRDtfRWAlZX/CFn2SMxt6GnGh91xoSLCUZ?=
 =?us-ascii?Q?6xySzeti0EByV2eG2ZaKvmFp5v+GF9TpiuNlOEyXNSGP/obhwW9jUKNEUPS7?=
 =?us-ascii?Q?DqmXRZqtqvSEFqMIy9njBChstgXAKNwtVth34rk44lnux5ek1jNh+dzDFkOF?=
 =?us-ascii?Q?G1JnwrvD3GjSoSw0FqZgSIPmd6tUT7mldet2leHLxKR3ox/fDpMT94A2Zw5d?=
 =?us-ascii?Q?SgSCM6aoDuCs1QimjXuow7jRvUH/oVpct0aYeWOB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66009b8e-a771-4816-7472-08dd03390709
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 16:42:42.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvJNqZ3hM0SOmX87knW2GNahpu+AcCDU8raTx74sSxWJqtITSh5pxIGdluop8r3rfn+Ax2hwOZ8ll3WT8KtK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Dan points out via smatch [1] that the conversion of
> add_port_attach_ep() to use cleanup helpers does appears to not
> correctly handle a pointer reassignment case.
> 
>     drivers/cxl/core/port.c:1591 add_port_attach_ep()
>     warn: re-assigning __cleanup__ ptr 'port'
> 
> The reassignment still results in the correct cleanup and reference
> counting, but it is not immediately obvious from the code.
> 
> Revert the __free() conversion in preparation for refactoring the
> subtlety out of this function.
> 
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Link: http://lore.kernel.org/2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain [1]
> Cc: Li Ming <ming4.li@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
