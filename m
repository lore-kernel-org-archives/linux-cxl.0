Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A23FE7
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729121; cv=fail; b=cykrN0ZFzAM0VJhrq6uhbh8hhUeFA+tRXosLvxLzlKiGzfN7lii9egRQ8FJnv1Qr79VvuLMf1VZfvJboxAOcZMGDp9AAtP6S7593aLKho80iX5S+FxkLZpFbegURSCv9Ku1qH5UhRUj+ITb2sZSidqbgb5QPLL+YHJkOBTYE+Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729121; c=relaxed/simple;
	bh=3bTQfxkcQ8poBdiufOcB/HJm9QZODPdRGfVADeZRABE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O3BMkP3w12TEGBJuAL90xl3fC2QtYJyx+DQ02a4YXNw0rVLt5iB0rgZlHYygaXeFhm33DSFvwPA0is6vcGHx7TWg3/ZB1mXKKBC2oYTchhMHDYny3xX/9au8Be/ZPEt0QhhM6hmNdjIyhFBxm9ZYAO8ZCv+vr8xaoLp3nWNQ8sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7xmWD+o; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7xmWD+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750729119; x=1782265119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3bTQfxkcQ8poBdiufOcB/HJm9QZODPdRGfVADeZRABE=;
  b=m7xmWD+oEJPqoCDWABGeUjVR6HcCTco58HsSgGJK2tylTrihk1ja/G7R
   SMkq/hvC6lmatqTO7AX4mZwHgHaGpYcOD+yCK/1OQ+d3yn9dsNUxkTsYZ
   xeMX4iPCeYJBbGaUL4NoRYq6fy6zWOOYndZ0PlBsWNZ2ACeR2uwGi/Kxt
   URTHKJ8IbjwjPKNaF6xaLhP/Wlw2tWot2BWEPI8kfXXWs8ojxwwuVZuOv
   ssbwIVbT2me2P+0aCO702wmRBSUMzIWqUW/PAiM1fShPNPerBbgHPfzeH
   XXUJ0WpY3qqT5uhHroQPSGw7H/fSVF+jWfZR5eXRwssUmgR3JvIsDov5r
   Q==;
X-CSE-ConnectionGUID: Lu9ccagRST+czuuQzg/MpA==
X-CSE-MsgGUID: uOGwhTLlSoWqw0hvBMi6mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="78370501"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="78370501"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 18:38:36 -0700
X-CSE-ConnectionGUID: lNKAdib4RcC/SzRHs2pDsw==
X-CSE-MsgGUID: 1qQpw4E4R6qwJ4RQMNLu9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="152274317"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 18:38:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 18:38:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 18:38:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 18:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mveYoCLpO5decwUwBKSxbEfZoZ5agfIP6WjjyHNnHU9swWqyvWANQZLvrwrHqKp9YVfkl2v7RSoM70eKXXfUA8XiWZS+fg/0sj3Nx1fMQlcJyGTNzv3Tu4sqHfN1dV+Y8JNgrH6HokaZN9AxbWI430ngTdtzf1jkBzK1HVoGTIT7InfY3BsmfXqsgwjxzFyDO7istWZdXUNmBW9OJB7u7kRRf2YrEqf3awHFTIj6r0o+WxhVwhmMaWrJK5/dXBITWvqsAXmtASDratoXSVUAovMkAt4NYC/LsuvCqGY6N3Lnm8jp1mDaHCCG+8d5aycz65e8MVFTLbSQI58+Ixa9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DdkK3xEsYHKJQRSKem6IZo+m/2yRtka1N838j6Xrik=;
 b=Gn7/YujbOIwfRzaQHF4+TLWYXEJL0b8Y3Is8B/44ybiqdueHzRN7m9UbjKqnjCz21UPjoCww8GtnOOy54lmQ32EttkSLQ6B02o7mui63I2AAooAq8VVP10xqVZx5TctB9uAZWHrlAqQgSgf8HJMXrRSuFAieB8D7U7PWZt9n4O/vOISJl8hApXR8VAR6YfaCSa7M0T08So3E5c+8L6UbL+Ei2c8Q6709eUR50gw61QLSZuD44JjR907EF2fdEIraoJqFKKp7l059FzVurAX055AaGoawzObUiDSI+FgJJThK4yKpLp7EopU0aYNpORM5/v4rlkiGwzmlvfmDO0ZBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 24 Jun
 2025 01:38:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Tue, 24 Jun 2025
 01:38:16 +0000
Date: Mon, 23 Jun 2025 18:38:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/edac: Use correct format specifier for u32 val
Message-ID: <aFoBf6rD_svc51Fz@aschofie-mobl2.lan>
References: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
X-ClientProxiedBy: BY5PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL3PR11MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe88cbd-1f1e-4c32-a4bb-08ddb2bfca62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XIrR+MU8mbrijGjEeQBGdZqLuqXcjfBDgyAgqE32fJ3E6pdS36iQ9HNCZwLp?=
 =?us-ascii?Q?FmniSnVktRSQ5aarnhW+7wSUFI1Pr1Cag71+XjvF3KInJC0HqUb61jroiflx?=
 =?us-ascii?Q?h34POdS3tWyHYaXQUr5onRxnaKEL4xZvjwbSTpK3TBDM5WHplEeKJDvltAjk?=
 =?us-ascii?Q?NZ5kK+t6dX0xxzNmVQh8Pu6q3vKMRBabpleY228URG0d+uZRzfrBWp6u0ZdT?=
 =?us-ascii?Q?62elk8QM57T28EPArpj/Uv0sx4zBjN8HDwYcQmxaPN9LCr6mbwVLv6fDc6Wn?=
 =?us-ascii?Q?tDX7o/pYMcA4UyZEP2VhtPoibQK9h/wcsQMfYwQelD2/NEyKR/31KuhYnzVM?=
 =?us-ascii?Q?ksni0osL9o33uJuObRKjmsvq2JDrerT6XKyymLvUh1V/QbO85FjGRWY017xv?=
 =?us-ascii?Q?ojZ3/nLBu4pgzBzkz7aYHbs3OkCInJN3PHi1mcRBtT/SieEqdSvmoAYCHRFg?=
 =?us-ascii?Q?qi0LMm/5Zq49OQa+pgYFI228SR6tC5kXBDJ3N+gWzneClYANM1VI5+ieAUSg?=
 =?us-ascii?Q?I0Fq65AJPyfYp8P1BjTDdEx0T66TrAKw+EJXlb33ilI65IcQQ+X/OQjZ+8J3?=
 =?us-ascii?Q?QbfcZV4BlhsRLgVGdbIIF7WsQmYpgxNgV8f6r3kLre8JnGsN3JH2deTy1/Hz?=
 =?us-ascii?Q?DAtZ1uYXSq12mGdyGBAX9IT83wsQaFI5sIH1y0X1br7yMH4PmHhDuUx8df+d?=
 =?us-ascii?Q?lRsPxHsfNrUooNG1O1xhJ9pGGeNk2KldDN8hyIJpR2yqi6u21nRoMFBPltJp?=
 =?us-ascii?Q?qvRSS82fCrUYDz6JH8h2c49vyNzB9DYsUWG5feHo5/tzrvzSQHPyc4FLxqXG?=
 =?us-ascii?Q?S+aFQZiao6kJk5fxIzuOiIaAaGbNPHTHroraxjBouXIgtpcFb5qv+NvzMFOa?=
 =?us-ascii?Q?M6Ciqg/156Q10j1MA6obJA+bHpLZblozK9PfSZTE/53pAz5GURzhs2OVnn57?=
 =?us-ascii?Q?o+fxteZ2q238lEGtmz0Mzhnwmh7wETc1gs3qpD/Xelkda+I+3OGk+CfJoRkm?=
 =?us-ascii?Q?J6E+01ILtTMbFVS12dIfrHOwaiSVa2neFY7ZRvwfXZX7a9sAFvg0QMOrReXM?=
 =?us-ascii?Q?Km26pv2siRUY7r31R9w825I5ADSiP2KgZKpE6L/n4IJsVeMnAszHa8ICbram?=
 =?us-ascii?Q?RUa8ptjJxzX2qB7Q1cl/S3bwNfyrJdCWWtnUo4N8Ew7k7i7PVrNg6SIyVAhk?=
 =?us-ascii?Q?uTcehNleJlTn80+MY/JDaO7fxlKXPqz4BOoUKuBKrgylV+PzDbhBUrorBiRp?=
 =?us-ascii?Q?M0Hv6UzzS7VvPUa2rwtvfWsJCoh+fTL5tw3MDxMn34bqmclQO+WNhl3mOMHP?=
 =?us-ascii?Q?nUFIV253TBbU8Qq6UhY+5e33Yqwf1noJOUgo+vhtIuv2BnyQtt4j7NM951Mj?=
 =?us-ascii?Q?a0e3GK94Sf+VBsutWlfpZA7jlijavMz6Eb3g5YXMMD2c2Hxm1yuTXmfgEe20?=
 =?us-ascii?Q?98TZNxHd5sc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFVLRA5sIQq4xMtxmTFTQlMOHdsqMvyEpilzARi3d/TbeJvrw+HVQ0xsc9Qs?=
 =?us-ascii?Q?Cvv8SBELpjp3dZtOy8d0RzzM7DVraEIAVg0XvHkOIuoFecbdVVNfIrFJGpDk?=
 =?us-ascii?Q?faRfoxaFatjUYFRUN9rm7hPD2rt/DE8X8aVZwtLfLgV+T1zZN6Z2FxBJTBho?=
 =?us-ascii?Q?xPlMihf6Ia3s+Cp2XwlqROguvByf0jC2YfwQoGdiDg4o7vKfloyTmQYrD6K3?=
 =?us-ascii?Q?vTpgEtQDr0YJ2hD5pxQMfFC0YFhg9qYi34agIE0Ej+qVRoubp6VZL/IEVWG3?=
 =?us-ascii?Q?Q2KbMJjF49qFvO2aUYdvH2mDFAnk9QQLVNZLzMqBD/qcmO8P1VFPuohaTC+k?=
 =?us-ascii?Q?O1Cwqvi0SvPPo99nFcCEWu+v1JDe3luCDT7rT3Xpnn8Z6gWK8LQThkdTflPX?=
 =?us-ascii?Q?xQqZmDJpxDP2qzRV3IzsvkpDH9c+JGrogYiYvPHMhggiEmXoBuqFaD93MX0P?=
 =?us-ascii?Q?vVVoiryx/Etgxxx+/6VBYEJEfmk43fqk+CbQgcUSCcshr73vIUJwMyVESHjL?=
 =?us-ascii?Q?C0RbyWGCMuXG9g2hROuIAKEOOiELrD8LZIt78InZ4Othrgi/qJZjbjiHlfHj?=
 =?us-ascii?Q?Ah/xrANXnGRan0AntgB2QuntCXqb/MwPufSpwjvp5YqyFgMBHGDyt28WnSuO?=
 =?us-ascii?Q?KBTHo1NCXy9tMCvxcq2fmB4OUQWZLII7/8XWpyDk/sznJd7q2UaruOX9qluc?=
 =?us-ascii?Q?fKp3tze27ROEYzmQPQAb7iHlRVFXYM9ZF5nidv4Mr/pHMK1PlsKrFqIqlG/T?=
 =?us-ascii?Q?VvctL548D6mkW/m0hiiVtb3colJXcBSPb7mXxzy2zMjUcrNaVP26Z8n3A7R4?=
 =?us-ascii?Q?yDeF6uk8OxeyHDyhhBuoSmtAHbdYMufKhouLo/mAsLlpAMwEKFwmFV9kSk6+?=
 =?us-ascii?Q?1KG8JREJhS6G5ciauGc3cF4O306a9pu8XIldNvtkG7ClMO06qf/6n/a7PFS9?=
 =?us-ascii?Q?4/4FVkR+sG4p7d91z2YG5Ctxoht6iPJhrA4MXj/Cok2uKFP+xm2oChJnss74?=
 =?us-ascii?Q?MZXyLaYw8ebkMFgxY+Rn592vhbBOFDBV9KTJFfj8uJjhyIjgDmGt2G7CN73F?=
 =?us-ascii?Q?rzCqlRkYdtyCRhjFVyJGJnmNmySZg+HAt0XkCBUH152cIa8VhlppBrHlyVDT?=
 =?us-ascii?Q?AdsfK/xbQyBLFXEr1zFMp5ktdlyav3q5lYtRTL2sKcKT3ICNtPXFt091YgVt?=
 =?us-ascii?Q?lY9sd0kYrFnwtuExvpMn0V/HBJDd102lJamfugg3hp6wB21GgCUB2LyHPYzS?=
 =?us-ascii?Q?INUU1X8plrEFgpYFaYZkj31bZX4cDG/z1iNCUAj87jsoGRNwaMxaA/ZP6hxD?=
 =?us-ascii?Q?ZCu6Wugdi6nW/RmphsSe0dVT4a8P+RJQ91wEAUL2ruxx2yT0P8pTewOET1qj?=
 =?us-ascii?Q?v8ioR98MzldsolB8lsveqYj7rauZl+XOyXNfIJVZEGFPdHYWaThsgGIY5M1E?=
 =?us-ascii?Q?WZEC3bGF21D9bRL3yiu+BoISKaRbD1DPl4IKgGHLZPCt0mYhjReRtwe1uRKs?=
 =?us-ascii?Q?ZTOzHmzmqxTx5Fj+ITWu8kJdREA7BYzYiSBPFr7rmMyfRE/ggql121T8wGwc?=
 =?us-ascii?Q?xHd0LDlNF6BvqOJEYv3IFtyjrUMBmJ6MXngVWWepjdZzb6MPlo1kFz7C9Rce?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe88cbd-1f1e-4c32-a4bb-08ddb2bfca62
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 01:38:16.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSfO1a3Hqahq4oAkZT+Y3kVB+p1prdNztpbJTDUiBlQ98MSmB4/Fsa1TkTXNsJQNp0f9cZTlHlnVAk5HxdxmqxHIcR531KQGsSK2TXGkkOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com

On Sun, Jun 22, 2025 at 11:39:16AM -0700, Alok Tiwari wrote:
> The dev_dbg() message in cxl_set_ecs_threshold() used %d for
> an unsigned value, which could lead to incorrect logging.
> Update the format specifier to %u to match variable type.

Reviewed-by: Alison Schofield <alison.schofield@intel.com?

Alok, Not asking to rev this patch, but for future patches,
the text can be more specific.

'Use correct format specifier for u32 val' can be precise
like 'Replace %d printk specifier with %u for a u32 value'

Then in the commit log, a bit of detail makes it interesting
and shows how it matters. Using %d for the u32 value will
display negative numbers when the u32 value is greater than
INT_MAX.  

Adding that detail also saves your reviewers time, because
then folks like me don't go looking up what will happen in
this case. The commit log explains it all.

Thanks,
Alison

> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/cxl/core/edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 2cbc664e5d626..76cb016e0bd9a 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -693,7 +693,7 @@ static int cxl_set_ecs_threshold(struct device *dev, u8 *log_cap, u16 *config,
>  				      ECS_THRESHOLD_IDX_4096);
>  		break;
>  	default:
> -		dev_dbg(dev, "Invalid CXL ECS threshold count(%d) to set\n",
> +		dev_dbg(dev, "Invalid CXL ECS threshold count(%u) to set\n",
>  			val);
>  		dev_dbg(dev, "Supported ECS threshold counts: %u, %u, %u\n",
>  			ECS_THRESHOLD_256, ECS_THRESHOLD_1024,
> -- 
> 2.46.0
> 
