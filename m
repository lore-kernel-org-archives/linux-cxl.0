Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBC3E5A17;
	Wed, 24 Jun 2026 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335445; cv=fail; b=S6wRdjea6oEOkeyfY/rmwsUa+SwKttRFejWPpnSH/8iiIpVUN2eyf9kyG4VuyNE7s0bg4H10sjJ4yp4mbQSmBjWpy/sNB0ek9sGVEH4jSw+dXQmxqoPj0OKctIt8eOxRWIVoJWcftJcVqUUXDINATnWKSv9AINwobcbr6RVM0d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335445; c=relaxed/simple;
	bh=05vmBJTuUjNrj7s9BgudVPlV7442jkz5rp05B48/jdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I1rbdCD7++71WivkOPBIRHyb4hhaiwnG8THzRX9Rgrqj8aN5o+7WvgFMFRT81iv9aJaR1DjC9ifprelKHZYX/VG0GWwjhKakhtnI1EayWBOr6siHkkllHM6MjtMVE9I1a1L3wotcIUo5qP5e9NFug1bcQo9rOShvBu88i65WXxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCFkpKbi; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCFkpKbi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782335444; x=1813871444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=05vmBJTuUjNrj7s9BgudVPlV7442jkz5rp05B48/jdU=;
  b=ZCFkpKbiO8pVZQOT22uwcvnNpdj+oozTQYAbtOpoKKw+3+ndthBoBbni
   8qGl6jpDBEmjbXgLTIfEHgrOkAv6XOdWG3EPN/QFbiSZiZUvPryln61Bs
   gJ4AW28/zF6ddlr/jje8aqHqsRZSUGVLwXbefdjFfKsMd0PMJclf77CDf
   E/8TaTxLJWsorA31vcAo8H5guIhcMIA/Z5RXbJRWzSvwP2q1O1jBWX/qP
   ixVwZuIfnXejhsaM7qKawdGMf1E6Ls5gsZFHukolnSqXrkLfvNQDIDJq9
   P0MkC2z/ZLGKr5VWk/kLhKBPgkb2PJS1DgAGtayQOM62AAdNR4UEVCcGt
   w==;
X-CSE-ConnectionGUID: M3Yo81bATxOTEcxVljoUgQ==
X-CSE-MsgGUID: p+PU/7b5Qx2KEducGCAToQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82993092"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="82993092"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 14:10:43 -0700
X-CSE-ConnectionGUID: BYb+ypteR2OUHTpMuqEVXQ==
X-CSE-MsgGUID: nD5qPhZ4RLOdri//LWKm2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="252015416"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 14:10:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 14:10:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 14:10:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 14:10:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XV3Kqhw/07dYgXJ8kkPLrJiAXaSXKD3FdrFSW3/CtnzwUmlkSnL/ZW3f3aV/YTOEI1bI0BM4t3FIGcU5uAqXbXbMP/LRHAzqw9lGESVYwBopFnPai8GURtysNxTSVT55riBEXtg69xYv7U/Hjh4wUuifQeqBHOWnSwNkpOygFNs2V/haRmamOh5Q/KPfOjqOBQxkp3b76P0LG7ke4F8XIPsgUYJhnHCDQtRkHrh744oDiFYuDtFXGXY2Us6FRnjnvOQ0rh5nqNaXSUYY2JJ2rE8z03R/1oEJvL63lcDqTU0+awlwoP7jOoX4ajVoL4eVF2WBO/vwbGAbtZxFry7hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc8U0B48Of5k7fJjOKmn2M/glnU3gvXzFHV2+Ly5dN0=;
 b=vFB1dXro7oHea0SMFg+n+eSVKTQEtlYNgffxFe6gojqtJ7PwN2rNZIdfXzmhlEkUsVbe1V/hm0JBWIfxI0etEf8pM/ZWXCKf4ttkjMzwsA4XIrg7QvUNqbwFInV3XZbkXJJyQ6+55OkECmPRA75Ze/xsChFEmM/Yx/CUxmkC0zU4cEkSWxheCb0uBUCNojfVCyxoagwjCcOMvfZ4dNIbYbnABCgY3tqkR5d08jGi8jbh/wE9gMdIQJatdcrfR9HwAgskFkhg3h0qayaX/QdU1jaSSPtAtgPFW8SytRL2C1xxDpWOlwL6UUfBEeQ+2Q8IDF7E0mM3e4azeloGDzzkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH3PPFC067E5C7D.namprd11.prod.outlook.com (2603:10b6:518:1::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 21:10:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 21:10:34 +0000
Date: Wed, 24 Jun 2026 14:10:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>, Zhenhao Wan <whi4ed0g@gmail.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <kobak@nvidia.com>,
	<kaihengf@nvidia.com>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <mochs@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/features: Reject Get Feature count larger than
 the output buffer
Message-ID: <ajxHwh3s2lM98aed@aschofie-mobl2.lan>
References: <20260624134737.49166-1-icheng@nvidia.com>
 <ajxEGmGxOhryENl4@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajxEGmGxOhryENl4@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH3PPFC067E5C7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 223e3662-0ffe-4af5-23d1-08ded23507e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|3023799007|18002099003|22082099003|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: N2l7WfX/KmZWnQZsvRgnBrrKwt5SFcH4IEishqzmwhFK1wD7w898hrBCRf+KMm1i8yuVFvh7U2lcXQ0PHooinIXreCp58I8a9d0lcwdt7/s6+OaI/L6w/MNiJw3O4lDCtE60Yg5/uuagHzyzaSwvjPMnyiosUxEdrdlhx/gPuN4S+8JYFQAACXDX/E3Hju50pjN+g8AxQGyxdMDZovWVZ+31S6EwJ3NDrx3m6vEApjVrI3vWWmegOrXSWJ/nkOXJ2/SWkrsK0bfFhqZPYeH1fBIMtV1MqD/SQC3Cj9z3y2TTVZrBM3IKTKT/aQSLBIMpwU9pynyNBfMpeDdS8ZPNdNA7DdRgtvjkpiushKSExJoyR1/qSjgJRTeN2xreHEalGSOKHyfYRJrfqMwu8Jn6ZAizr6SHd1Yf3Mc2ENmdVIPOXS6MS42xOIgzyrJTaZ2Weonydp1sQre1d6oeqtegoPYqp5jQx2RrQSU2nJS2AjWXUYTT3L/iBkiYQHUdu15596Qr1JQ1L3yjTXQ+Ep2lzOh22joulVyfLN3jsy7GJizTtlQTLAi/o8Q5ng0W9hzj3NB17KyWtLpgzJMzS4BezlNTfsMRFMhPbjr1ZGpM7oYQO/YXV0/vd4EOgwlN0VhT4QO/b2qy9D3kiuh6f0ZLxhvuqpC2gajbL3bokAx8vF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6L0v2ImTa70WMNsVwHRxUQLuJAk7kC8VGKX2XJ+DeFDg3TEI+2YImWy1RlIp?=
 =?us-ascii?Q?irgnXIzoIkyc2bq+vImt6i/0MGta11m1kWMrT9XwVQ9ncuTRGojc67EwC59o?=
 =?us-ascii?Q?0BeGVL0/U8QMuQt0IuX0AaC93z61ktSMf3M4W49j5YQ+0auLloNg5q1X0GcQ?=
 =?us-ascii?Q?s14mU474bsm7AeJwr6Pp80gcOwnUk61tO2gdWZGIPNgj+GhEv/i5UYA98JMb?=
 =?us-ascii?Q?cdOuoIfkR0Q9che9fxWqNHrNtOyK71rlUlY022MuBWT4rq/cKR2XALDdXr6w?=
 =?us-ascii?Q?SmFbbIkJRyjNlWFbbgbQPbcSXCRo4rtghnv/qyFbcPdvt48CpmV7RhI3JPEs?=
 =?us-ascii?Q?0qu26t+lY4ys7hqsWJ4obEVbDWKDftGpl76AOVdUlt71qBe0VORREosZ3c19?=
 =?us-ascii?Q?SJzSCqjIiyDAJ9zqZutRqdC2iR2QVF5RfJKuLT+408dnwyBjTQ4gzVZnraDf?=
 =?us-ascii?Q?r31xiEWAI6em42hXT/01WHFngRTqJM6LAvDgNrXW6WWnrfXg2kWhN9Pj5Hv1?=
 =?us-ascii?Q?HX1aT/XZGkN7BEJEFknnzcDZKGb0qmWONE8FcUKWLHV+y7goH5Gp/qEgcF8e?=
 =?us-ascii?Q?DiSGCCV0pNcrj4luCVOmJ+Me+mbUHuZ5xK2aehpaLKChsbR1qYc6ubMpRpDr?=
 =?us-ascii?Q?sEFBzKb1Z8Bs+4XFi/IKCjZ7b+athSJj8P90OnHe0+btwedQ5OVd2GjtXGCF?=
 =?us-ascii?Q?/1Zi4275YbaaM9TzDNBJ5yW8UHtjHiNkGWXr5x264ZMQWO4UjLjMN/aqnx6O?=
 =?us-ascii?Q?bsNmHhEGL0jbGjgUrj+mi5BN1rpuD5ZPtU5PiUaM+0rWFdKcoG5p1MzGPL9Q?=
 =?us-ascii?Q?QnUUOJcEsF1jGdNVOmBG3q16IpyohCd5joDxPD8pCEGF1DMN2p8r/zTC+Jgr?=
 =?us-ascii?Q?/sZw/84DAkUUFoFnQ8vRSWTLbX+k5nP6DMsQTTZiAxp6IJpkWYsbXeFXgIPB?=
 =?us-ascii?Q?KfVyLSZZFO5mMcobWD9bxdAOH8/8/HgFnDEq2lhGgrGrHqy/eS7jsCEop0e+?=
 =?us-ascii?Q?HVhx0bJNunJ8VMel24YdFvhJ00dQl3oiZbc7bxXOs3JxB/59mHjkwpz84Rzp?=
 =?us-ascii?Q?EsnY7wXoOb4bQ02B/aLruhvPmLrEXEr4m6C79TOAogzzzY90nZr3CLKwakI6?=
 =?us-ascii?Q?C03HXJyksl07WFWldHNY6ypbTwnAALJIGGEw8Mm3p/ToDFNK72eGeokhCYgf?=
 =?us-ascii?Q?z3hUYawbFwi7KX9WLG0H9PJUmHlLruFX3QoZ69mCUkNNH+Dl5/0U6uCym3X5?=
 =?us-ascii?Q?I9VoKkD3JybOKTT++W8Z9ll9Ky0fcWtnWWyTt32E+XoR9/VobYPzcGIRgzUo?=
 =?us-ascii?Q?51ymPtU4s/W87q62/7fdhCTWajOnyDrqewTtZL2gwOaP/qU2ItY2qx20Vyuf?=
 =?us-ascii?Q?lFVkbEUaK32WxPO7B4XOWM/2sIMhwTWdAxlSxIu9pSJ079264Htcx0thul11?=
 =?us-ascii?Q?zVh9FN4mQ96Bx8XqRb8Nd9mIggyfMO/2iF2TnNn2JUXshim3rWxZ9VH8LG7s?=
 =?us-ascii?Q?v5GtkJRu+W/HouILCYRG7gzeh8djXI/1oN5kWlkK2UXPPaqmC5yKgz03MLPe?=
 =?us-ascii?Q?E9gxniSOFjp6gixN1gwTfX2KawgsGiHll7QnWFdJlYpnd9UMLVdCfq/WYpXW?=
 =?us-ascii?Q?tpBQ2x5osIQ0MsMFtyhYQRRLNRf+zdCgQwEJaAT+fz0cpWK02qRWrSzDYWtN?=
 =?us-ascii?Q?0swY55v2mIi5znHgZwjUqNg01dg2rR+fJqCLNgyqQByoN0aAaXtbbOELv2I5?=
 =?us-ascii?Q?NrV2htfT0O//ymbvhZLrtnl9V5gQCLI=3D?=
X-Exchange-RoutingPolicyChecked: J7M954tRC5Pe/UoT7WialyOCbtKsrHc70T2M3JqacHt3Koo39g0W0T77RYauwbybkyRcxm4HMhguHFsS4lNj87Kxmkd5BIWohWjr2ER4g20XXM/zEkj/eQZOsajQT1bjVLtjhfhUQBi0HPw/6yVzgzYuC4CxrOiRD+Ystj4JskJuG+LuqmjyJ/90pb75iCEPM7EGiBS227LAeznxeO3FV97aGQD54IHVuRFYs1nBALJ+63JcTxNAkSeES/RQn0ij9wQ/AtwXC6NFa2pRIzqH/XVXDgpdo/WOG45ZyEr4f5sxQ3/IReiQlX8ictiV86kEYlBgudN7eSwOpY0uNi+84g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 223e3662-0ffe-4af5-23d1-08ded23507e0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 21:10:34.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MFf6Kp7DbdBCqDpnD+UPR9ECpQGuqolt3OILqP49OQT+rmc/u6ymI8VLlCRxia9HpXawaQgGvSzoJVrodNgRbwy5CLgdAuFHzWboDlqiCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC067E5C7D
X-OriginatorOrg: intel.com

On Wed, Jun 24, 2026 at 01:54:50PM -0700, Alison Schofield wrote:
> On Wed, Jun 24, 2026 at 09:47:37PM +0800, Richard Cheng wrote:
> > cxlctl_get_feature() sizes its output buffer from the user's
> > fwctl_rpc.out_len, but the device is told to write
> > cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
> > separate user-controlled value. Nothing bounds count against out_len, so
> > a small out_len with a large count overflows the kvzalloc()'d buffer.
> > A heap OOB write reachable from FWCTL_RPC.
> > 
> > Reject requests where count exceeds the available payload room, before
> > allocating.
> > 
> > Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
> > Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > Reviewed-by: Koba Ko <kobak@nvidia.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> > Changelog:
> > 
> > v1 -> v2:
> >     - Drop the reproducer and trim the KASAN splat in the commit message
> >     - Sent the reproducer as a regression test in ndctl separately.
> 
> This patch itself looks good. Looking at the other bounds checks
> Sashiko suggests, I'd rather see this all fixed up in one patch or
> patchset, rather than dribble in as multiple patches.
> 
> Maybe it all fits into one patch, like this:
> cxl/features; Add bounds checking for get/set feature commands
> or maybe it works better as a set.
> 
> Either way, doing in one swoop would be nice!

Oh, seems I'm reading patches out of order.

Now I see this: 
https://lore.kernel.org/linux-cxl/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/
which looks like it covers one of Sashikos's complaints.

> 
> -- Alison
> 
> > 
> > Best regards,
> > Richard Cheng
> > ---
> >  drivers/cxl/core/features.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index 85185af46b72..9c714ee42a41 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
> >  	if (!count)
> >  		return ERR_PTR(-EINVAL);
> >  
> > +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
> > +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
> > +		return ERR_PTR(-EINVAL);
> > +
> >  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> >  		kvzalloc(out_size, GFP_KERNEL);
> >  	if (!rpc_out)
> > 
> > base-commit: ef0c9f75a19532d7675384708fc8621e10850104
> > -- 
> > 2.43.0
> > 
> 
