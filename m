Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205163F23C5
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781650341; cv=fail; b=tNGKuLY0v/qYZrTmrtDvjq2dcVncbIYt7Khmi2Xpvwn5blcPcE9oYwUT8Kb604tVHel56QMGqKMP3aRAalJqoIvaussUWhT137vFn2bZxXVNzYs/ajB0a0bXNnTt+nwSBVzajyMnVHVFbGafuqwnr1dYuz9Sf9ztwELdrz5pH7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781650341; c=relaxed/simple;
	bh=lTkQeSRAnbFPr39lqEmV3Geps7uhUn1S15NWuF9y9Jg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TlLvxlLbZ8mdZd4XcexGGflpM1m/Vh5fsECR/a6c/rzSvpU/dPE7O1AFyfMAwXLXd3T2PJWwWUGlfykM2XTCrchYSI7DQx2ddmX+D+U1RDRAoHPuzMTU3pIrYNAXucStSrklNyowvrKzP6/Uon7gv54ATTOee6sDLDBJLn7ik/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlnQFAKH; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlnQFAKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781650340; x=1813186340;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lTkQeSRAnbFPr39lqEmV3Geps7uhUn1S15NWuF9y9Jg=;
  b=DlnQFAKHnX3rlVwrVWvdIDi9XeH2hjr+5qJTY9gzhMeuhaf1HpNuq+n0
   l2GmQ9+N09wIu/HH8posq4u5ubIWANdw0UQV/SlUjvEpSCRwK7liPjw4j
   bbfxa4+GL7QON7jhQB7VfOi94Mg8HOwpsZWmD091qCFR26mkEkVsxQfRh
   qhDWpH8iA8/94Aqut1wKZKOX8KAL7+ZLdLOm6dfXaagBt7WooCEvjF2uw
   26aB8cA/YjvmdHqnz9yPK/AXR8Qsmro+61yLgFyYbvwrIRIGJRX+p4NDV
   ADVOhS2f1WTlEEBhpaUIHy58mhjTcaGJI1mTEFAlpmq9eUVLhD+COEeMQ
   w==;
X-CSE-ConnectionGUID: FmVBTee8QT2XD2druTXIaw==
X-CSE-MsgGUID: 5lU1PPc+QDunUPVT2aTl3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82293426"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82293426"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 15:52:20 -0700
X-CSE-ConnectionGUID: OHVVZU2JQ2Gghjq3tlOIZw==
X-CSE-MsgGUID: ChCbtT9oT/CTHLu8s+Fw5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247014994"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 15:52:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 15:52:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 15:52:19 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 15:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNeGQYj07b6rTmb3NSz4kI9cBl8x4en4OefTtWZFZuymaF+l88l870Ap3NvawaZ5sOFephep8er+bIUj47dZDOTKVu3iZ8iadIK6w1spGelYwgrIGQYf5Sw5/3twXGhkjP6uuSM03M1JLIBWjjxoL+4+aK/3udcZdxlrNVgEeU0DU4AP+MvFi4WFuDT5Twc0D4/ly3qJWuUv25QmscURuEV/Muo55gcWyRBJVZfNBCluxWaAogiRRxZyYIWbP4BC56pEGkPbLHH3xo3rNufq0BISlhQ03ow9E+BMpDuqcV+3eoGip2d+3SPw20noTJ4rTia5c+YcsBW7mhjKXNbUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08ie25c4E3MLK3ecfFaLGjJODgKk3H52IWz2d0a2Z08=;
 b=DxoN6/45/w7dlQ4ZbVotaPM0YDERdMHI/zYKa05yp9x1vjIqRGurRPHZcqdM1FYKkQH46ItfPRfJdEyJMgDGWe/uAdRGMt7hBaV0np88R5uKFJn8/DGG0K6yW0OXarjqwcZmwzJOvDt2O56jIb14tM+crDCC6TTyhW51SIsXn0pDO6d92wG+cUuIb424zD4mQACHG5cc4bdxmIq/qAqQleQy7hG7zpm4e6YyYJ/zz26cpZP7Nvjxqo+54dbMYJn9GNbVhPjvSgVvLy/OdFizgVWH0snFq8nkimT/mWbRKouZxSPO/rEVcRa2akMaU6H4cKIlr/a16Qykh1J0zTsnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PPF75D68BA1B.namprd11.prod.outlook.com (2603:10b6:f:fc02::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 22:52:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 22:52:11 +0000
Date: Tue, 16 Jun 2026 15:52:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] cxl/region: Validate mixed-granularity at sysfs
 and attach gates
Message-ID: <ajHTmAuRUMTNcyu4@aschofie-mobl2.lan>
References: <42da0b69d39207b712d7c27f1af6186febbeaa6f.1781199122.git.alison.schofield@intel.com>
 <20260611180334.7EC6B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611180334.7EC6B1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PPF75D68BA1B:EE_
X-MS-Office365-Filtering-Correlation-Id: e668dec5-9628-4f76-405c-08decbf9e6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|4143699003|5023799004|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: oDS585dQp4+9vSTJvx1KXW4XdmHBr8VFzjX53KBS5+8/EmwRjywvZU7WgZpOkDMOE0IJP6QfyOoT3sFfkXrYDo41YKwnFcGM7OfrSTQOjjUCf55Knmp5zvSBoqy3ssz/k9A/VmWmw150e1PrDqiMcxlKfRZmVsCHcd2H3Kep1hzsGfKi3iwg1Ti+iJJLmx3PXjAvKWSHSlt7GGSBxAXDxcvH2pKCtCDyqVdaYXE+/QmZI7N4WNBFzYTrA4D83tK5lvO+uqZHEXI2wVWXE32dsKy8R5kv1CxB2KY3VJBxfHCGeOsDKLAyj3zH1gKkSw15l5ssQoYX87v9s9Os6P1ubcnvH7Q2zehM5us6PhxVmS6wsHlUFeHfn4MASt5n/6LXl9BjUHPaQFfazo7/jB0si1K6POSTgYUSxhW00Pp4tR9J8164tXKnJ+GOR4/9fX3r7zxfpd/VdcLPOYZjyYrMoD1DUjwLtWZBE+GhMTYhr7XDyfxIqNHav5KBhskCKYyPRiGSzhtBdUdZHQ0B/rKCFTiXQiERe3YZFVqB3bqeju6+mHK5ig5ofFY8Mar5Aht+CobraSIsHCoN7eAylbjpakZTNN3xcN2TaMgOD3JpGt8m/iUBlwkZJvgSROTv5ArsP4Lev6tSySfVKX+0Lcby+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QdEc4sR1ecHfQpS96GGuobREFsWr0ec3JnQCojid76/q4ziUBc3LzwVYmI?=
 =?iso-8859-1?Q?5vRCW7m2xN00kobz6N2EKunuPeLMjxIQfNtvhnohi0KCT/6DLjv3pefQ0S?=
 =?iso-8859-1?Q?8GLhriGIS/Ws0lIjJ7RGa63BC7+URjw+fpHme1+sR1hWEcUtVGtFHOaLaE?=
 =?iso-8859-1?Q?Haf4PUeLiwq3AcQkJlpo2o/qV8gxeuutm7uIqAf+yqhNTNdq8x/FvUUAM5?=
 =?iso-8859-1?Q?I7SwTWPv+R3Oblv8daSz1srIcT06+adAm3tYkYhRbMwirojkgXjrdNrvHc?=
 =?iso-8859-1?Q?/gltkw5nBdiTD3OERfXvU2l+oj0fIeqerg6JnbGL3uAZIvKiwYQiWg5vY/?=
 =?iso-8859-1?Q?4T99PmMIaqCqiyuPNKPu6d17GXFZ8K/WY8SRfy7jXq0oYVK/ifpPQdrCan?=
 =?iso-8859-1?Q?eA2RhM276g6RNc1xaCEKbKgb0hxxOFp1HJR8b5TO25tRLf+x0WR9g9Ewdh?=
 =?iso-8859-1?Q?YopBNYcaRYJxpxg84JYg7WSfCKWdknbpcF3u29OVc4dtXAqpic7Z592Iv/?=
 =?iso-8859-1?Q?AFCLpwvfkM+Pp7emwF3qW08q4OG5nyCb87xYswhFSIK5rSmex6pWORbi64?=
 =?iso-8859-1?Q?5In7my8Y8FRG2rNJQ50vNf2oInCdFMTIrW7VXO5iHAq5hrUUJAM/tsPz4P?=
 =?iso-8859-1?Q?IbOLokXTVB2vrOCwgkWKZJ69LglL+yHfIfBX9QwwTkg9GbGoUOHOQhDjd3?=
 =?iso-8859-1?Q?BAC5Umlm9uArHXfOCq/b7DRpqOH0I1gd1GtsxK9fnHrB2aV6Qn2T5v4HRP?=
 =?iso-8859-1?Q?/x3WOeLQR069MTZxHzfFv7Ml8FwAp/SXcbloBZzmgp+pSaVoQmsE3WacRT?=
 =?iso-8859-1?Q?DKGqR4rUPKcfWPcKvBnjeZwm07w7ZAcTs4RX8OvHMmvQl6cYvfvgah3D7q?=
 =?iso-8859-1?Q?GyJS+leOhC2WUKqNpXr2R2F7ikuLxHjQsNRV+aQLH4WAGU7J1tIsvXZ75o?=
 =?iso-8859-1?Q?gmiF7OxYAivTObf2T8m5zfl8GHX+nSj9m88EZfkCo0/mwoBMsNVaY4TBhN?=
 =?iso-8859-1?Q?XLhA27vTLNAcwiMRY96QFPxcee3eBLzO2SSHqHjEX8NqIwtyRN8O/6DtHX?=
 =?iso-8859-1?Q?UGfwW3PZMgumhLLQ5ZsGRYxdXVeAhALYu0hwAKZjMu/S2O8HDhOTPXWWZT?=
 =?iso-8859-1?Q?NYfe5FG457H3BJJptWAHEj3l3LpTqlVXC7wXxX8geg1JeoDhBcrnp52mO1?=
 =?iso-8859-1?Q?pxnhQasvOfS4KUtoLsxVRmYXs9xY9uzvdIYoH3R8msaibiPeUy7p6gwS7D?=
 =?iso-8859-1?Q?bwB+IcENYF+uWsI4yyzS0c4SRKAHeUbOh9/ahAc2M3FWTR5wZV9Sm7kYgd?=
 =?iso-8859-1?Q?YOvd+olTcpy6dZoLMqGIeXS5Z6vHZOE3pysk9OhFW9lxvoYh+PQ1ocIsBv?=
 =?iso-8859-1?Q?UlS5p1qkWEf65JB40OqxeHCEr5W7+NwCYS6QIA6Are42bBgGDHuv1pb/tD?=
 =?iso-8859-1?Q?CKf+EaCHdcm85o/cwc/XXuld57+Ggb/s0VdM9famHeF/OOLf7sR+15YgA5?=
 =?iso-8859-1?Q?sZ3oJ6anNerdHKhVOmWDNVqbc1fgUvCz447FQRiqYE1ji0WB35fxQ537mn?=
 =?iso-8859-1?Q?POc+4Q/iLV6AdWOGGdYkqMGXyFC67f1qV3DBHGvq7LOezn5kZxzE1sXo7n?=
 =?iso-8859-1?Q?X9UatrO51Kuk+yEix1r1W5+t6aAq8HYdxAS2k9nT4rdY5kGF9YzOuNcDZq?=
 =?iso-8859-1?Q?S7m8TI+DvnstwAJBl2fL1pnfIG2u96d0QVeYYRCymMR5dBq8R/8maoBhBx?=
 =?iso-8859-1?Q?O/wGTDr+bgIFYvV8+2oHYReFBCRX3TCEMwNAygc4KzqJXrK3L2GTG+wvtf?=
 =?iso-8859-1?Q?51S4MiQeZCvEdD+7BAIqyN2Y3C5pb2I=3D?=
X-Exchange-RoutingPolicyChecked: cRItvwK8exdaTpIpWMxs+f4md8iHFf3hXH4ZvTplXdBZtKs3wa+N8QO/eKaUJszn90mt4uBdCGIUR/zrPqsgdzs38BWlU4gNzgmbDXl6SERRErR79z0vcXD4cKU14ix503Y1PnL/zFMJvQPWY7Sp72aEiOgCSpqpdw4LRifHJF2lCOu6yDVl4fGSdOJCN9cqyShn/D5GIk1j+La+eDiRiCzy7aW0DzIS5oqlGF8teVdc1fKTM3fobky23znDCDe+CbL3Up4+7Nnwnq5jsS0ifxY1iaubQ1aPjsuYHySrmydweiApKRAiANdrnjHFXEssgpjfSjnXR2zLdBVNs/4Dqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e668dec5-9628-4f76-405c-08decbf9e6a8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 22:52:11.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvQw2Be8ZiSIcQ3lR8LKoXE7hE10GColTCeuPFY7i8HK70he2rGAwVTVUJDCbxjIPrz5wTDQ76YSzE8uLrGX16Md02W2ZA1EMZskfFQAJNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF75D68BA1B
X-OriginatorOrg: intel.com

On Thu, Jun 11, 2026 at 06:03:33PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The function `check_interleave_cap()` ignores the return values of `ways_to_eiw()` and `granularity_to_eig()`, leading to the use of uninitialized stack variables (`eiw`, `eig`) in bitmask calculations.
> --
> 
> commit 999caa321a85ce92543a94c3525b252f33aab308
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Validate mixed-granularity at sysfs and attach gates
> 
> Replace the same-granularity sysfs check with is_ig_allowed() to permit valid
> mixed-granularity regions. Call this helper at attach time to enforce the same
> rules for auto regions, and add an explicit span equality check for
> 3-way-family roots.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 9fff538a9ce16..311b5052bbc8f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> [ ... ]
> 
> > @@ -2096,6 +2107,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  	struct cxl_dport *dport;
> >  	int rc = -ENXIO;
> >  	int stride;
> > +	int root_ways = cxlrd->cxlsd.cxld.interleave_ways;
> > +	int root_gran = cxlrd->cxlsd.cxld.interleave_granularity;
> >  
> >  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> >  				  p->interleave_granularity);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but check_interleave_cap() is
> called here with potentially uninitialized (zero) values for interleave_ways
> and interleave_granularity prior to state verification.
> 
> Inside check_interleave_cap() in drivers/cxl/core/region.c, ways_to_eiw() and
> granularity_to_eig() are called but their return values are ignored:
> 
> 	ways_to_eiw(iw, &eiw);
> 	if (eiw == 0 || eiw == 8)
> 		return 0;
> 
> 	granularity_to_eig(ig, &eig);
> 	if (eiw > 8)
> 		high_pos = eiw + eig - 1;
> 	else
> 		high_pos = eiw + eig + 7;
> 	low_pos = eig + 8;
> 	interleave_mask = GENMASK(high_pos, low_pos);
> 
> If interleave_ways and interleave_granularity are 0, both ways_to_eiw() and
> granularity_to_eig() return -EINVAL, leaving eiw and eig uninitialized.
> Because eig is an uninitialized u16, low_pos can be as large as 65543.
> 
> Passing values greater than 64 to GENMASK() results in an out-of-bounds
> bitwise shift.
> 
> On systems with CONFIG_UBSAN_TRAP enabled, could this lead to a kernel panic
> if a privileged user misorders sysfs writes?

This issue is already fixed for 7.2, sitting in cxl/next here:

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=next&id=661c092f9839

cxl: Align interleave decode/encode helpers with their callers

which initializes the encode helper outputs (*eiw = 0, *eig = 0) before
the -EINVAL returns. With that, the iw == 0 case reads a defined eiw == 0
and takes the existing early return, so eig is never consumed and the
shift is never reached.

ATM, I'm thinking the v3 of this series will appear rebased on 7.2-rc1
(that has the fix) so nothing to see here.

-- Alison

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1781199122.git.alison.schofield@intel.com?part=4
