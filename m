Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC3342CBD
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109795; cv=fail; b=qu25JxWAZLZ4Brc2bRN8dIYK/wzP21zLaizB4m9LLRWGe59CZQDQZStBz1I8tf7XUF2+JwTQykNXHxelFS5SP32oeZpB834CbEoGFDuR4JCdcooHmbk4qrzMsd9zkQ57Wkf5j/jnrTuHYZVtfpZbMo3LJ6YIFnxvX45dPSg7fB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109795; c=relaxed/simple;
	bh=kZ49dGWHP6BaaNeRgHk7iAcS8OiLgPnid85ijkvS8hs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OJHAqE9hIX0njQDh3s8HoW9p5VB6QbxZXD01RyJVu73EOc51O2A11FoxDbcoYHIP0fIpKvGEx/O24cVqnnyPjXEhRwLMVPtDsAdW4LjCfDNAreYmXMYxqAgXV55lDGil2Ga+GWMKC0fPPgABv32LjsXrB7IUic1aJF/84lr/G1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvXFGyor; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvXFGyor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781109793; x=1812645793;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kZ49dGWHP6BaaNeRgHk7iAcS8OiLgPnid85ijkvS8hs=;
  b=LvXFGyorUNVRqysk3NouQsSfrz42xShQRc3e2UoJFXLVMuo7Id0zWCqW
   8mb7mqgtubGkWw7+qXBlFbV0ZUfLpvN8XtSMDYeriuNr/apvWF6Q0HC9M
   pfd/zgcy0ZV8UbgEGZjCX6PrbV0NZ2ByopqMy9/S1vuVSKzV2Iuf7DJWP
   B7Ej7f+JSRDvHk3S4+rmdpeBu89uyC2bjzanI59+nlJLOpU8Qbe74KOts
   zDwfvb6FX4EqD1NNhYnY4yRO/xUKhktSNUAhQirNGz/jukS4kUAABPDV8
   SFZIrn2LV0fzhDKWI7KNII/MkACMivyf9u7jEZy8dzwh0S0rN521lXGA+
   g==;
X-CSE-ConnectionGUID: eDqzz18FR92D19gKdpwL1A==
X-CSE-MsgGUID: VcXK/sXXThussVAAY3lfmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81757743"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81757743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 09:43:12 -0700
X-CSE-ConnectionGUID: audNt/r2RSi5cZbb6CS4kQ==
X-CSE-MsgGUID: 9YkiXnQkS7K/PQTrZvevOg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 09:41:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 09:41:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 09:41:35 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 09:41:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdxQ07dz+a4TLOHOGHfsjvXeo1oyKlz1XlV3yxZcOCNaCVwZBf/CBv7LohLxupxrktEdTnadnGdCDtlVS4ukoQ5t6G+uPU/Oaq8fVt1VSo7c3qAsOFiCWldvebmk4F7Nt2QGs5cxLcLdhce6qyBKt5Oy0rLaLi1wcw0Y0PnyjoRt0wcbeCgiTf04R/WZxk5fUOkOk4zaGw5BwyzxSj/VcHDXYN6cLA5TNF5+dLcREPxAc+lmWIDJQjeu0jVnl5g0dNelnM6g3DSReW/QjeioNHQuRDAAvaKBTOmoQNNqsQdPpxneKmdu6IzrbdqotdMipxrvQcX2dwlPabFA5Av2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aKa5T/gl0K1vRKWKtB6P2tMqGedpoOgaRsw/JTjTIw=;
 b=KhnUDhHntIzLKlmLNoSSGogWT9ofEloAd0knGQyRutDLpjQ95lknml5+L4t9ChZdFZHgfrrBQ5b1PEtAdgxN2SnYCYU8b8uWwy/iqRvwChPtZcEKDzZ3jq92sp6i7brDFgqvCkDRsxg4R7oFdeZw9OyK9CwMyL4nlBnXeNHuuyPzX+6fYLNi2f6z5vS7Ppkw5GqWcyUR74J2ZjOoG2nlu8ss4mFQ5dd4zPNG8JefItJUlbPKgf9lWYWH3GcfOMePsn2b2L6310F1KYGdLf/Kh7L2vxXlauw6Dceq35xiqLTgo4GtGolbdtTrZO/FBIfzpcDpEaGMGwv8w1OdzX9vUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPFF3DEC9799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f61) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 16:41:27 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 16:41:27 +0000
Date: Wed, 10 Jun 2026 09:41:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<djbw@kernel.org>
Subject: Re: [PATCH] cxl/test: Zero out LSA backing memory to avoid leaking
 to user
Message-ID: <aimTs2o0CIISJy3S@aschofie-mobl2.lan>
References: <20260605184426.4070913-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605184426.4070913-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a03:505::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPFF3DEC9799:EE_
X-MS-Office365-Filtering-Correlation-Id: bc06aac0-1a96-4b33-a7fc-08dec70f1d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: a1QEdbO/0aktXLxW7HtcPgLql80FA8/PQhvRFVUCtDb+n+iq5vKJc60kH2PUSvSs0L5xQj9DyXwE21NrtqRCGPw3Oo9Zn2xwfiXO7dJN43szT+rH2DHcum0aDxOl0axwpxBnpdPnmoRGKEpgxbRNU+DE0mIQHO0581iavY9+0U04gYPZzcMVsyEMzJ3h86votTXkN6dFa3VxThPL0xYY+dMTI+TvH7FyHACh16X+gSVg6aalkymqYwi9FeOnL4bHTWTd+cmT6Qe+kLPThQJC15rhmo3ruGOA8zQxOdfosJLkkd+Yg5KFqPLdV74vsnDUkO4k22DZg3/7A0fgCl9uJuvd57zkYpv2Q4U8GQhAPmnR9XHL1A9j7FOxCLRJWRheMuZgy3nBVR1m+8Oqn2rcaEQf7dtYqhAVknEY+51yfE94OSGWn8zKqcJCLsEqp0b+DdQWIBK9yrTFIeo6mHZo/QvuGd5UDVSud/kqaUeMlSoK88IAqo0IIWCcrIiKc1VxPOrucEZS2D58XmuK4/WkOxKJOw9ntQmw9ACkl6VZ+f8+RjAjvj15pdx5ZYGKypxxyL+TAlCEOgobPwqmD5Ss+IRqgsZHzZhORX/Xn8gTGGoqKyXpyGuaxNfbmzX0RdNIRd7jjPPM9H6HwNfa4yNj4CiZIUMqL3kb9e2KA+o6HLz5bwJtO4NRfTPYPs9Qb+8svT3mAzajYs8eKiLVlrBOWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XnNoI6KU1McqVdxapPZNfOF7RxRKbK+a6RihmCIN6cJqKAxB6Sjq1p9U/Hs9?=
 =?us-ascii?Q?ps0TRQekMUbzmfrAWZZSkPkpOejLvJZ2EfYmyL/kbXSTG6nqhExa3T8Z0FsQ?=
 =?us-ascii?Q?ruJ5rCUAx9KlanaR7DvSfO5TS/eIZgYzE9ccGNW4thAbkfavL/w8fNE7kEa6?=
 =?us-ascii?Q?hYIq17QHCorUJUYRqVo4w4UU5tRqqk/vaV7VKNm/MRwTJC25D1uQLIIpDPbb?=
 =?us-ascii?Q?PUCnN83vVRksAagAOHXC29RrW4CrsaWSs/qMP55rwgD/pGJsMNhAxOkDBgie?=
 =?us-ascii?Q?UWzsqFzqM+JoJRvFCcjOZlVR4IMCEWgQu6BbCFW6HW+ABVAWuNVyH0xhnIM5?=
 =?us-ascii?Q?O4WknPRBa7W9njbXN7mchO+7FgvTXLx0S82u3AGZfY24Ufk50o7ztD5YDADI?=
 =?us-ascii?Q?wX0ySoBokz1gsyK9jaN5udcT6sVBsnFyJkEJ47zOBW8yT6+691SXg/1x6bQZ?=
 =?us-ascii?Q?6IR0ZKzPulCzEpTrWoFOjfBFjs+4yebz6hN0fJFIdog8+UWrJY3TGysOtcZD?=
 =?us-ascii?Q?/E+Vr+qhuC2+YPWkcIMFYunFhXWB+5OxUQapqn36NKAiCWrOyIIe3eiEKznC?=
 =?us-ascii?Q?6MLWuUNStxI/0EI4Wy+A1NG67HXKTU3EJAZJyKnnLNhThi+qvW3byi+gqpjg?=
 =?us-ascii?Q?A/EqQXLtRppujK0wwsu5c6yXAY+yQe8Hx6Zj60JgZxUJlVugqFuZWRz/5hgr?=
 =?us-ascii?Q?SK5Gp6W0oMDQZwAYrz4vjDIvf8p1pxxvz9OFP3PUzj8BWMVRN1p+osHlsXr7?=
 =?us-ascii?Q?m9p0xRBPNWiSNgvZosRU1ks2NwBLk1NfQjjZuVCmyaCs0XyXsHmSv0ftPIFj?=
 =?us-ascii?Q?0doTEez6cZQbJBwUzjLaeOm6C/ns8bwvovU+8X4rMJpctk65Odo4EKfgQ9xA?=
 =?us-ascii?Q?mUFWnzHE1mStYw9Cty/fN5XA2EeMcd4teIs8K6c0VxpRZ+EhdWbkLQH4e7+F?=
 =?us-ascii?Q?xB+SH3VrnFnGMexpa+8oioWv8jLoyibADl3z/valdCEfXM1RUdGnr60EtpZ8?=
 =?us-ascii?Q?l8UFuMABD17G14PS3aOk67t0abv+I0PAmkECh2SpL84VI+KTiTz21PaAhxUQ?=
 =?us-ascii?Q?Y34n/iJCKDq17y6R6MpKrGYHurQGlkXRCqE8T/xll6FyxJVLIg9n5sHW3en2?=
 =?us-ascii?Q?UWz6UkgCzCNY9mfxthM8UNenBlflexmtC82oPUxMsU9QkJm+eBtThzZOIsHh?=
 =?us-ascii?Q?BQz+MbdIk6fKtuPEvUU2ahcF216ieHIaSDFZJ6isavCBdiKtG0MOIA1FWyhY?=
 =?us-ascii?Q?nQP6oOJDktHtmCHx5mTJnm/XvTL+qBsE3y1wkSgLw2HJjuAOrC0tVbDMJQAz?=
 =?us-ascii?Q?jWFAmOCyFfUJ1Hb+m8OTXiJTcNDN02iai3ob/xAUxCt6sVtn7bpWLjfmTN/o?=
 =?us-ascii?Q?dLWYJtODBOcwEoYrMrV36DPeeKTi54cR6tFdNKBcQlEuoCHR0Ks4D5hrN7Hs?=
 =?us-ascii?Q?XmPilM2a511y5CnEkEMf4PV+E6mD4Hyl07FDATszAHdc/xvjZLAiHidTKsaI?=
 =?us-ascii?Q?ajFnyI1x1WNhuk5XGFEIIq04sn+HOiufKf/ilWE4f+x5kd767oy0/FSaZu08?=
 =?us-ascii?Q?IFTiMqtCrH/uG6Ej9yM3bIWHfhOtMrF2xk6rVVa3kgbZZ/NtfZW83oAsXrJk?=
 =?us-ascii?Q?dwPRfiXg4/Nj4QniAD9z56L3nfrLV3oOQmjWcMZxp12BYyDVi2Z1dlNjN1Be?=
 =?us-ascii?Q?Pfi1MiYlGaJgSrhTzbMBW+F3nwdoKxB/s5sQ+891jn6SISQpcg37XpZqM54Z?=
 =?us-ascii?Q?pcY0wnHMQLev92ZnKjuha6riljy3oDc=3D?=
X-Exchange-RoutingPolicyChecked: B0c5hsPcUXSUQJjO9A0cF3NKdLRhsRY/x4yVaq1te4RHyzCNSKShcEctxck0fij5XD9OPBZkEMuPF+m830m0s4Kkqdhc+vKxA26l6Ue9b0AoWUtZ5A+hRgdGwhZf9tf8RVTSY9EmUkCEzjnJVRy3mCooDsxiU55syc5Pixz6n6XfXBcy6EmaWcL7fpejwazXV6YxV65G8QJQIlzY7GGrFOsRPQ3tKsowAtdFUuG0LYt4xYF1/+PdmAD2SB6ggtqRATAnbeZDxlTF6x6LxtHJfk0i3RhcbZrjg+rsYo2l/XPMQCj5ZrTInibIOz6zPMvUDzLWXjGUXlqKVhxhwkq0VA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bc06aac0-1a96-4b33-a7fc-08dec70f1d8e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 16:41:26.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMNwRcEWQBqw/OZa1StBRRBJieRdPSzi5QNJK3NeGXrkhIYFdcGUAphZL8RtN2HoqoYKIyM/YPW4CfAOMLdZrAvIU/mzehKczcEmptGg0S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF3DEC9799
X-OriginatorOrg: intel.com

On Fri, Jun 05, 2026 at 11:44:26AM -0700, Dave Jiang wrote:
> Memory through vmalloc() is not zeroed out. When this memory is copied
> into output payload, it leaks memory content to user. Use vzalloc()
> instead to zero out the memory.
> 

I had wondered if the mdata->fw allocation was a similar risk, and
since it is not, this LGTM.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Suggested-by: sashiko-bot
> Link: https://lore.kernel.org/linux-cxl/20260605173146.2B9A31F00893@smtp.kernel.org/
> Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9a7cd3f46a1e..739343cd5802 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1724,7 +1724,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	dev_set_drvdata(dev, mdata);
>  
> -	mdata->lsa = vmalloc(LSA_SIZE);
> +	mdata->lsa = vzalloc(LSA_SIZE);
>  	if (!mdata->lsa)
>  		return -ENOMEM;
>  	mdata->fw = vmalloc(FW_SIZE);
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> prerequisite-patch-id: a09fa1bd37ae9ee663117e196f1b8c49c55365e4
> prerequisite-patch-id: 75202ea281daa3b091090369ada6eabcaefc6671
> -- 
> 2.54.0
> 
