Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA03002CF
	for <linux-cxl@vger.kernel.org>; Sat, 11 Jul 2026 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783799558; cv=fail; b=lHYkFsS5nY9lDpZ6U9y3Fn4zzFSYFksrVlJSgE/6DHKk3ff3LMKl2xfxVPiK/Kx+ArY18hd80mkMOEO3NRt/S5XNpe5SmGma8KWvDBOthXqI62P1BvwuXv37M5Y+Cv+3uc+VcXNY92TLU8EJWd+V/egUTR3IqWJGfGXYqHjNfWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783799558; c=relaxed/simple;
	bh=U9Oiu6Dz2xL8GEnSbZSB+7BSGnmBHofvxWPOw0AUiHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=au50XwZxqKS7tNtGh+kYMKeRPonBAyk+wqw+Ag/vcDKNMOfai2JC4hV+rwa2/OwNcDFbeJ7SwG4dPEQT2KlJBtmr02gRKvmvabc689XiHmxFc3lg3ET4tDj+GF4rUVlne20dO2+394wA25699JhV1KFKyGWyQOFa7LBq5ujZlhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSzHvzUC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSzHvzUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783799557; x=1815335557;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=U9Oiu6Dz2xL8GEnSbZSB+7BSGnmBHofvxWPOw0AUiHU=;
  b=jSzHvzUC8RA7iDriq+8pOWS+cfH+JIi91ufaa7PJUuvsVfllXgxsZQLn
   xnf8kL9uaSULiJ85caL9I8Y+57JQyjOToqwiDWpWEld3Mu4eXH5fHpmv0
   7tmhxLeJwDiFu4b58u0Uha8Fh7BqE4RJt8VCrUtsRlXg0UXrvP6nN/Fma
   h+isRGy5ODJZkIOLjXsj/Bk6FNDe4j75qrbo4w+cA12qSuHA0WHnq8JvQ
   kHy82RxNxHkvTVxUJAykduc3mhZy0Wq6xXJSnK2JrtvUZu2cRPBvxRQeK
   hdph1LJ3tW7yqJ9SUEvnou3GI6z0ov/Ms1UPBf0yLMsIJ7+nXjgfCe02h
   w==;
X-CSE-ConnectionGUID: gCzNn8c3RnyipyKOs06R1A==
X-CSE-MsgGUID: jP/813WGQ8ukOoS6/UjtHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87012917"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="87012917"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 12:52:37 -0700
X-CSE-ConnectionGUID: Oe5gsQaWQei+gj3b39gcNA==
X-CSE-MsgGUID: NHiDjF+rSAuGV32lqOKGQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279582294"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 12:52:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 12:52:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 11 Jul 2026 12:52:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 12:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3frZdhDvAmOcGTtX7VBbtLrYCh/yhjwylFMObOYvBcFFuVsQJmazDZ0N6tyxtAUv83GpzRMDakz+O/KWVRdCqZuRKj4O8jpvDF8uLLTBfuOAhs+rRF/Hku3hTBb5lrzCOpOyvmgclKbEiNKsvamWSMtR9RZ4gqIAq31NB5antw66p0FNW6U3BkcwJCsw62mYyYrZXYRaDiEfbUYKkPRF5VpKyNKzW4WoFQYobQaoHbZnbJcZTCBKzs6wyujr52cCKvtwSgjIKM4qZ4PAUg3cSnLnew6MQc0EG7V7BIgBPTmzQbwvt8WrSrJn7XBNKCkCkO7dpORVNA9NV3xWU0IMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBF7KT+V7kGbh4J2jNGvF6p7nxoEkEFWigwD5kisaK4=;
 b=zUIAhHcfR21ZlI5SpeCZ7AykZnQ6f6MAMS1e5XCuusYk+TJ9aLgfh7Poq9HQWCa/rVkI8CRuk/LyxfmorCHi3Gt9a0xE0UQE2k1b49s3eh+cYsWWqJX2S1NCfLV71pmiazZ0Ar42DV61PPwMid2Nb1KmmzBPTL0ZnqN3faxHaDjddwsB5xsTvcfIQU18OVMG9hye1zGlImo/ighVZEQwX5NAR8/BmlsqOWtVbRDbllHSXe6wgp3xdsN7bBwFM8QVMhPMK9LsRJYXiejU+/A9eutnTwQ9D3BlId646WgCC1gTufjcTFuOh5J5dVpbaou4t8xpw9P6tj1pDJhVNV6lmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sat, 11 Jul
 2026 19:52:28 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.019; Sat, 11 Jul 2026
 19:52:28 +0000
Date: Sat, 11 Jul 2026 12:52:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix use-after-free in find_pos_and_ways()
 error path
Message-ID: <alKe-MPcCLbLgFQt@aschofie-mobl2.lan>
References: <20260711180755.1779002-1-alison.schofield@intel.com>
 <20260711181949.A4B1D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711181949.A4B1D1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ1PR11MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f2d3d5-4b0d-49f2-514b-08dedf85efb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GZZyv4/tMNzvF82sOsT7uff4EFv0ARf/meBWGDjBbKJe6x990F0ZQkis5mr5hmbka0jkwScF1cQXs0HKV+KNSdx+YFKZod2FVKM133nrPUbtLn7g27itXazLGahVziTVJy5ZulwRFkPE32Tn2sfOFXKIdhFK7bsjA7tcpIkRpF5x9d7ToY0s1g+4B61XT//cEN2uOfBtCs9xpV2oGW0zy3XB+hYRmBY8ezPC73LbiFfY2n8nBs1Fq/y8Ay/A38rivhgQRhuSjzMxEapcvbumK9jTL0Ikt3CmY8n+3SySQq2YqsVF7epU3yue/1gJZwGP590ONXYFwEE7Ze0ZyHEtEAKw75O6TUkXpGcdqxO9B40pKN/KGv32hBzF7/Hg3gzUOwGS/B93Qu309bVj3LQ+CcybAA1aqjI6VoWEmZ9d42ANHSylUr0JImepEdR0XO8/jGJrGDySFOQu1gEl9vsEKL4AGlUYY94sbH5aYws+V7jFRnIeMsrXJ2x8O9XnTvjhP9WSrHfs30XL93H4IpYfhbp2riZNrYUoc1aWlNVLijHv/hV/olen4Utl1346RjJzbW2QRNR1y5SiuWtkaryf5r5qIeEkBTSPtM847OacMW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6qzfJ701VbshY+4Nqk9sFk8U4bylprVsUrA/8ST/ncSvVjdJsh7GhDFMdz?=
 =?iso-8859-1?Q?eZrWRQpNlfV1n7T9757v0WKEqTodOt7PRY9FJij8DU+KKXfivM9lAaIeQs?=
 =?iso-8859-1?Q?wJPyOhc71fMFfhYkquU9K1dAjmSPhX73P1dXLk7IZACsdOt0vtcItLTIIo?=
 =?iso-8859-1?Q?ZOzGNXRX89Y3Zh5WzIXfS0uwr432EOz3qDNwC+lvljBi3YseDGpK0xkNyQ?=
 =?iso-8859-1?Q?LN1/Mnq82fUujQsYsSRpPdY31+3VgEwlh/JjV9Ec7tZQEik3HF/s4eUT82?=
 =?iso-8859-1?Q?AQ2wAmcVs+HFw6zhDXIUryIlunPDyX8lCVyjm1MgYFjzSTLaLtabIHzFiu?=
 =?iso-8859-1?Q?GaHv2Cj4gwFjnZjQSqbBPU23F5XGLxxBW7we/z3P0XQdvj18UzNF0KtEj3?=
 =?iso-8859-1?Q?T1QS+NobkYNrDDBmI3+EVErS03exbwYwDPPkVTz6rYs3Zyd/5RoTbh/69L?=
 =?iso-8859-1?Q?Q02AiH3Qqgy3UJ3IQFq4Pk2wIjHlzZ2doKW0Sug2p1DCTGb6PptUsvB3mC?=
 =?iso-8859-1?Q?AFrubmj6JvSSChhv1WJmBO+MlhlVui1DqbkJGiqLsMFlllNgxgEx3qg9UW?=
 =?iso-8859-1?Q?mGlPJS71+dsMSu9fmFmM7USYqvihqezXULH3+6Fia8d3Lw5NRKxrPblY+4?=
 =?iso-8859-1?Q?XsEDA9XnKLGODo8yXNZJZFGseZ+ctRV/G7YvkAQ6N9lDOe+e6xCWK0Cf7o?=
 =?iso-8859-1?Q?5BwHGbSydOPVfMX175euXqYqsuieM0e9HTUgeRg2AglkkemS4hpsi62wlV?=
 =?iso-8859-1?Q?sAYmJbHpjqGPnHhDB8NRw4mV8ZpJ/grMi6x3kWuK7jrABYJI7E0u7miDvM?=
 =?iso-8859-1?Q?RJzkcAxlh+VQFvXyW2gqLFjbS60tAo1Q4KIbD4AMMHG5/vyvciPbLCh6Lt?=
 =?iso-8859-1?Q?S+LxTs3k81WtG/FG07scMd/0paEFxQOnpcY1ISh9fip8n9I9pWuMuB9YZa?=
 =?iso-8859-1?Q?c8lIQCsRopSMuQqLMvHTK+JLE1fHQ5/9I1kYpE+XSJxD1mDyGrTAtKvsUo?=
 =?iso-8859-1?Q?W1s6bzs0wzBJKFCHdnJaQdPktkdwLClXih0+fhPxm7kD+QQJdqUx6mehIK?=
 =?iso-8859-1?Q?xTKJX21xJgc8xxc2krimoFDXL8AfUQaIsIJVrojsaLdStsD8rZMw/SDAo7?=
 =?iso-8859-1?Q?a50sIb5w3OtLtiMJ1mtEpofO3hvlToRHsKHu7+qYNPkEIzWDg8ebrtVAOG?=
 =?iso-8859-1?Q?kE0Yh6p7sboUfn57hc5FYLV3TdphB1EJTxJe4/Q34Vhy2YIQOtfrI7faSF?=
 =?iso-8859-1?Q?mlyaVcXsXTusAkMO7KQjVVBoIWKHkQAM1J1VwQvtqzF89dEBNFmkB/TV2q?=
 =?iso-8859-1?Q?6T7rHbDYMwihiLwg1jaNT7dlgu966oaMWNONgGeYqHeY3568ktF3nLpCmB?=
 =?iso-8859-1?Q?4ya/5T+evXTv7gMFEuFqELkSeEMLUyOiOLp+PUyqzqjpczuzWtLi5/rZ+v?=
 =?iso-8859-1?Q?prNQ000kHwtNQXqbR5kYnKulD6X3Od/3J+2WsRQmM6P2yN7p6AQK0fBo54?=
 =?iso-8859-1?Q?2l7muazNZeyY+/P7lbt3Ws2Ur3Mh+pR+/po1piFMTjmzP0FkigJxsp89ra?=
 =?iso-8859-1?Q?0bRGcrcER12tbBBgeE5h71rEXMscJZpR/zzbM6Vd8DqLBFtOe2cC1SmbwH?=
 =?iso-8859-1?Q?IZsufpmL3GihxA/oBsLFq/YFklaE8Py9YmUinQoSyy5sebGQ3aBCZNwg1V?=
 =?iso-8859-1?Q?W4PzRsJteVQfmdzzRKI73ap/1UDge6P1Yed7EK8uvSf07HlzglQzNUyOrt?=
 =?iso-8859-1?Q?ey8hEUISiDvQww36VoUcidreEcclxfQii65Q04GAFda8G6vo6H71fbKzkd?=
 =?iso-8859-1?Q?jsbj89c7Iegxf+rh1DXoJr4fCDmHYuY=3D?=
X-Exchange-RoutingPolicyChecked: BSEFpTQKRNEAowqNqFAuOnBbD8Mz9LFOxFb3OBaRnMNayabVDYfRzO0t6XWdPHcD3aK9pheRGEy+13GNeYxB13ly7v3qfkBr99AXmWDS4i2Cq5eefX3lZ/uKyw9+MD4ahWTDlp6jNhDhZYORi2nhZoX7+dsfnIEWTU5qHbwFlnaVzmngxSb3lANoZ0roJKReD/nZF97p4BrVhYaZV4lqdD6KeQjQfOztDQBCyNg5vUD6bMq0Lfsxn+a5Aszx6CNdZYJ8rZ2NPkYXSlGiwBv/VJTXYQvRgV+pvVui1fYvPPPPVCem6C1g2dMfzvZ2YIKZ2Y7E9k8usGQRmOEnUlDf3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f2d3d5-4b0d-49f2-514b-08dedf85efb9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 19:52:28.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/mvZSuOKcMxfcP+/BF2Xr0BR2FQAYsRqlNYOdjCh5MY53k2RkwwDlXp5uxcpc65xNjja8tLvMOG2uKq9zmGaDqRIGuqMwBXBN1CrQBaTQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
X-OriginatorOrg: intel.com

On Sat, Jul 11, 2026 at 06:19:49PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unchecked `interleave_ways` value from untrusted CXL device leads to heap out-of-bounds read and write on the `cxlsd->target[]` flexible array.
> - [High] Out-of-bounds read of stack variable `target_list` when initializing HDM switch decoder targets.

For both of these...
interleave_ways is not fully unchecked. It is decoded by eiw_to_ways(),
which rejects any encoding outside the legal set and caps the result at
16, and init_hdm_decoder() checks that return value and bails on error.
So the value is always in [1, 16]

But - as noted here it could exceed HW target list or reported target
count. That would happen w a bad device, ie malfunctioning or malicious
since good hardware won't advertise an interleave that exceeds its own
target list.

Worth hardening, and I'll follow w the fixup.


> --
> 
> --- Patch [1]: [PATCH] cxl/region: Fix use-after-free in find_pos_and_ways() error path ---
> commit 1c57e04f0aa13be6ae927836e151c3bc815eda70
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Fix use-after-free in find_pos_and_ways() error path
> 
> This commit drops the reference to a switch decoder after logging an
> error message that includes the decoder's name. This prevents a potential
> use-after-free if it was the last reference.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b64..c86dd9d55e939 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> 
> [Severity: High]
> This is a pre-existing issue, but is there a risk of an out-of-bounds array
> access in this function and others when handling interleave_ways?
> 
> Just above this hunk, find_pos_and_ways() loops up to
> cxlsd->cxld.interleave_ways and accesses the cxlsd->target[] flexible array:
> 
> 	for (int i = 0; i < *ways; i++) {
> 		if (cxlsd->target[i] == port->parent_dport) {
> 
> The interleave_ways value originates from the HDM Decoder Control register in
> init_hdm_decoder():
> 
> drivers/cxl/core/hdm.c:init_hdm_decoder() {
> ...
> 	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl), &cxld->interleave_ways);
> ...
> }
> 
> If an untrusted CXL device provides a small target_count but a maliciously
> inflated interleave_ways, could this result in heap out-of-bounds reads here
> in find_pos_and_ways(), as well as out-of-bounds writes in
> decoder_populate_targets() and update_decoder_targets() when they iterate
> up to the inflated value?
> 
> >  			break;
> >  		}
> >  	}
> > -	put_device(dev);
> > -
> >  	if (rc)
> >  		dev_err(port->uport_dev,
> >  			"failed to find %s:%s in target list of %s\n",
> 
> [Severity: High]
> This is also a pre-existing issue, but does this same unchecked
> interleave_ways value cause a stack out-of-bounds read in
> init_hdm_decoder()?
> 
> drivers/cxl/core/hdm.c:init_hdm_decoder() {
> ...
> 	for (i = 0; i < cxld->interleave_ways; i++)
> 		cxld->target_map[i] = target_list.target_id[i];
> ...
> }
> 
> Since target_list.target_id is an 8-byte stack-allocated union, if
> interleave_ways is larger than 8 (e.g., 16), could this loop read past
> the end of the 8-byte array and leak adjacent stack memory into
> cxld->target_map?
> 
> > @@ -1947,6 +1945,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  			dev_name(port->parent_dport->dport_dev),
> >  			dev_name(&cxlsd->cxld.dev));
> >  
> > +	put_device(dev);
> > +
> >  	return rc;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> 
