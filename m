Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EF2DC76A
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324273; cv=fail; b=s3hHPXQYkxTuZkUDDn1AmkUHl2Wowm27OfY75Co5ijZo0wbSy/nDGW6yrTAd0hzstE5Xo+tpsXRy0jT0RA+UuE3wLpXPaUPHZol5clYZowH5FQVPHYN14G3lxJdgszuCx4gKrsAvPUlpZiqfFFYDQEG6vbCHQeZhHZlYzZdV+Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324273; c=relaxed/simple;
	bh=Po6PgPjzDtPouIkx9hj9JaZtKbFi+D7Mo9nyOPaTb44=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EbMrapafIvmSuy09ZPJxcRyGeJmwRY8th1rYOUGYHSiKfgil0axjV0mwq57EyNxmKcSG9ilhm2IDyqFSHIwA3UABvGFcLfyrX7G0Uas+E+adX1ylqFecKM325IEiaHl2cTXDe0yG9ZRRXcoi7MsIlkSbKByoFW3jOJGf2dhSNvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYPdLY+H; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYPdLY+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784324272; x=1815860272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Po6PgPjzDtPouIkx9hj9JaZtKbFi+D7Mo9nyOPaTb44=;
  b=dYPdLY+HA+mbhq/1g58haxfgSWX1JJnwcy5FRc6xAaik2WP+LSMaunqj
   Si7LxzZgIpE69IftSzbwVospRsKxfEokq1t4TVvnB2fYr/urhy2nb07cE
   QNnZkh3Mehapmhn/Z/JchLIphF2ckVNdj+QD4RzUDKhn++LoDy3rq2c++
   +xRp5rEVLl7PgKnhQoP/xT6hMTISZzzeXy8KcCgePMIYzay4Twhn9U7Kp
   sO780pLaQlA+zD03J4QISGHNgCHa3iapBh5BOA+QXz4QLJ/SsrLmkwKi8
   wzHOZr8Etw5R5VBotkNPm72NVCzpzvf05rkPNWn7OMu3XzP4Pzjd8oPwR
   Q==;
X-CSE-ConnectionGUID: noP6Onj0R8WfDxZvc7F+sw==
X-CSE-MsgGUID: g20vHNjyS3eYdeRi5bWeMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95356182"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="95356182"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:37:51 -0700
X-CSE-ConnectionGUID: 34Wnm3LpSD+F3pHeILZRMQ==
X-CSE-MsgGUID: JIVbefeyRi+1isVBBxzTJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="257532174"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:37:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:37:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 14:37:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 14:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nA1qerksY6tPML4JYbHNNLvhqTDEj1trSQJGWxfbdAjmBC91Dnbug6o0LuPweJXl4nSbUjQon+U2xKQ3fERI07OQ24Ze96alVEExD8HlH7le6PQmaSVgdGMiCcGvTTIrHBDsifu2WTKuXu17B1p0ACAthRf6axgwzSTSvrpbm11T8AYGTrjtsk4wV03JoEKYfGRRPo+aTBy0TqKvpGOifcX1WKtQAdlbVd0DARskQ8Gh38/p8hXouhib+FoLSDtuNRdy65SpLVvhzQ0LO17noh8IujSj0/b79tydlTO1ILFp3QYCzyZtUQD3Ra5jga88/y+fzc2BKCp1ovCmLuUfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqoyf6/bbaqWzD4cE5pzX52zk54X2XW/mxHXmOFnTlQ=;
 b=IWv4m7+ufc8RTdnFv/pDOhbYgTI4Lshg5v+C9LmoP1euF6ZpiQyQ5vXCEXaLPu4HLwQ36W7i5lX1uvruyU+H1V+yibyO/vFRDW3szyRk7HVNVSogQO2vYRbh6WXiDtoay8wMN+KVIKvw9NkAUm7ASoxtL/pM2EqPgaPEWHdjl+5kQ5Fg4hNgXfHSqBTrSTDPAlZqfBmLQ0z9fCsjCEaJXDuEC6kJQ0BXJ2gOWRxrIVq9VIGpC6sbU3oc0XlkEmmyuSa3fGzgTDV0hLJnUaXkZ2irx3Xo3mHmdYbPCLAEibJyM1lQ+gNJco9KvH9xfUB2ibZpI0oE8aNoc+LJN7q4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 21:37:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 21:37:41 +0000
Date: Fri, 17 Jul 2026 14:37:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>, Srirangan Madhavan
	<smadhavan@nvidia.com>
Subject: Re: [PATCH v2 1/3] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <alqgoVrM8fOTCu1E@aschofie-mobl2.lan>
References: <cover.1784150131.git.alison.schofield@intel.com>
 <0d7618c36e20bfda585699f8641d62928b23f6d5.1784150131.git.alison.schofield@intel.com>
 <aliaSasHogM2go8g@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aliaSasHogM2go8g@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: d87be94b-130e-461f-9e65-08dee44ba11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: apJE3Z3RRXNj/K24wXa7DQbvlAKSbraXnQ5dlGFhxFRfXrS3v7Ej4OsGT6Qy+PRY8loCwFYzy7oE9HBrHW8SrrGgNRsgX5F0vn4J7q+dl/1HM66FLJtIlUqWQX8nBHza2RyUdl9tiZ8KjL7LAisxDSRDdTe55rsBgGn4jfh4ppBDEZHL9C7IzKj780lEHTBnWJiH+zrksCzyYBmwH3WHgQjzIlFFQybhbU/bePadUueDvbyhUyeBz/uVu1FhcWGeGRXQ4C/MqLOQ5Uso8HqFWxN4z+kIGCumixjqblG7iI50V/pZ0pBe8UJzvFqGBNHR4gAS2pJXhZzdwJmVhO0mgBTkVsuEzPtnx1v6/2iyFgMup6lhyqFaBjdBU27tp5Y8PiTILFfI05oo25QKYLwrVA7fbDEt9fW8+vXIEdWq8vWrb6dJJX4I8HoRdZwM1soBzjCvSeYt3h7eLwNZQS3oqkpKweLFAxhNq4VFouqNoGvEvJShJBcANJE9hX1evKAUWP4tjSJpzbRjQwLd2p+1saor9cKj1ucJ31HSOQvZspoHlUMzORZXEV37w4LJsgooVQjS+h9Mrwd2hKpGucRh6fp0Aw38DospkvzZS7tAqhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NaYOQdj6pg6MXUBWbyCzMd6sIYT36e5BVd4Ja8y3PY4ZhVKF+zlFyU6qcaZ+?=
 =?us-ascii?Q?8lxbicZmu/apKs8GrdltDEWy3WzfFartaPPzqv9PC2XW//eR9nSMQilSNTmO?=
 =?us-ascii?Q?W7KZC1AU1Yc/hwpDkhgK58dO4dRhUHPUiTOuGdo/evHbw2wANqKuUlpckaQc?=
 =?us-ascii?Q?Psc5hov1+Np4r6M68Pm3GG7Hml4ZveZ+hQ6hPdI+GrxngkdobhhQIqSw1d40?=
 =?us-ascii?Q?huIgm/rqflq98DRpLwNwQXUWoezQOH4G6hGMnaIzCpQfwdOSUwMbe8VAPKhF?=
 =?us-ascii?Q?W+ChnidNdo2ZuAI7waA3QwCoTRdewS91sgrzrgYVi5T1ekFmVskIdZ21Oe+k?=
 =?us-ascii?Q?B/0UJUposvY1B4Q9IlEiWmwTeqeFrYvMGFpOFwCO9wWuFMsHyvzDHsCSlclQ?=
 =?us-ascii?Q?8hYlSkYsPhubzO58FFkZ41PvtsjNLJOw2W/2xfRanT46yuVJ5gEo4vjSwN3I?=
 =?us-ascii?Q?DsKN0AADuJnAJ6q3Oom4jasY4/0YX21z1zo3gXScLmhyYSMUKceQvcg6pxMv?=
 =?us-ascii?Q?bAeV8n6eYaZ7Yv2QwOL/rwoUFfai25mzwBLoxTzMkDKgmSQCRgllqACW7JAm?=
 =?us-ascii?Q?Qai9Ojom9Gz3kmGRIVrykA50iezFjU/WVbFT5XHjLu9e5ctyeZ1boSbGAFu3?=
 =?us-ascii?Q?ypSgjVBI8+KTFxHkWSn/OOnF4mQ57DVGd+JF31yF3wC7lDh6qqqWE67+DyKC?=
 =?us-ascii?Q?3JpDeNt7t6stGhoUmYaYf7jihlKcgapAr4ByevJH89xD/bl7F5UB0eb91vVs?=
 =?us-ascii?Q?PQdqk6Lpcaf6MH0gEMZ8iKc/xajOmJnvghcgfW+E9hQ4UvtJNeASzq8+wCT/?=
 =?us-ascii?Q?KI4uiZOOI1G8jfScjRsRzEq3pMElP7PUJPZ1wr9IiMpK4/m4UNiYxVx95EQu?=
 =?us-ascii?Q?mZR6auOTTWaDkYUghsDCX/p5lGwEPBCE+Kyu7D0zS2hZFvWpVxe8bG+RC6Bh?=
 =?us-ascii?Q?tJ7nNzcKm8mBfUib/7qeyDC60+5sAVwYW/602CDKeo5+EUmgvIMvCU182Azg?=
 =?us-ascii?Q?mP68xmUNVGUzzViolayay+NRh4uUoWgSUYNDzDxrcpq670TspVzXU/1xyAwk?=
 =?us-ascii?Q?o1r5hYztpYD0w7droRD/gVeOSkmUz7Wt7q89WbaXiXHJjWwRUkA3tWx4d79c?=
 =?us-ascii?Q?EtKvqFVECnyuaWGZcZI70Rxz6Si78jRLVmf70XYoP1AQz9cKKKFrv3G23fB6?=
 =?us-ascii?Q?XW8TMnj/RECrqC5kOD0u/xli6GSQSEMEt8yHW+VaWBlnAMYyaPBVgTbxnC7D?=
 =?us-ascii?Q?d3w8rcqxnjxNU9Z0ApJ9XMGtYhQvdHmcZLE0KmaE4MZRCHgsKuGMM5n72sl3?=
 =?us-ascii?Q?lKex8aOMoAXYopRWialvb48OgdxmCNEVvL2fGuGT4GA/cj92icPwdQvO+tS4?=
 =?us-ascii?Q?WS3AN9MXawZ9xltktAlNE2YJIkPxBw4cstJbxZJnQOw8KWt/rXo8KERB3n2x?=
 =?us-ascii?Q?dNmNJvft+vwgerVxm+PuiARD7pV1TkXRCghfPEGGzc7fdcjDcwsRnFpaz4jH?=
 =?us-ascii?Q?elCn6muZYTSn2iIhwXrHs7C5+nt1QASG1VCqX+O9QAOxA2NS0HIKmnojC2g/?=
 =?us-ascii?Q?KFFj9S24z3AOTO0cBOciYxuiejmaDxSZwKIRZPi49WvxzxUCV5WCM5l9iqDA?=
 =?us-ascii?Q?b0G3116xkMryU0QFuXpnbBTfDzl9uzDJccefmbb4DT3ZbBxKTCeiPf3vK00M?=
 =?us-ascii?Q?YA2oADo+CB8EtxnHkG3sL91DAUwRv4nK/H/7wWrfs/lbd9tj5s0UHZQ23xfN?=
 =?us-ascii?Q?arrnRm9jCKExm0m5KPlR+/Ua95ybw/A=3D?=
X-Exchange-RoutingPolicyChecked: eAD8+AcZPMZ0MF0d8nVkY35x1OuiUXGtraeZUkfNw+lYA0vPJtpKiVTJ5eYcl2E55hMI/kh0NsUyipR7K/ZwNhNHJyG2UuuKe63majnruRFhROMzHv0TBCnS57gMLSpRrzgTEhqPARAPHhRotfObWLsByqxg35IJ0R1ucwkmcjd687xnJ+2j4CS/LbXfxACPqukSnTAv+XMpk43FeFe9g1/WYI1hdW67Pq6FYWJpNDRUXZgHtZoEJTfFWRbVziDtornWferHn2P+UFTry9nHmbIVGIyKBiIwxyY5PRzArIDueFz0G3x9bmYMyA494NaREnnDzatL/DCBbT5/kSOuqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d87be94b-130e-461f-9e65-08dee44ba11e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:37:41.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elSMYAYc0sq08awzKlfNmo9m7UiOS4bXKTEJ6SNrdtLKLRentUGfj5XV10pQu7e1eMISEbaqX/KH8S8LJHhfJ9Le0hiTMEbZorHT+FNWfiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com

On Thu, Jul 16, 2026 at 04:49:35PM +0800, Richard Cheng wrote:
> On Wed, Jul 15, 2026 at 02:45:47PM +0800, Alison Schofield wrote:
> > Switch decoder enumeration validates that the interleave ways encoding
> > is legal, but not that the resulting number of ways fits the available
> > targets. This can overrun the target arrays during enumeration.
> > 
> > Reject committed decoders whose interleave ways exceed either the
> > hardware target list capacity or the reported target count. Reject
> > switch decoders that report zero targets.
> > 
> > For uncommitted decoders, ignore the stale interleave ways value and
> > reset it to one until the decoder is committed.
> > 
> > Add a clarifying comment that target_count is a direct count, not
> > 0-based like decoder_count.
> > 
> > Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> > Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c  | 26 ++++++++++++++++++++++++++
> >  drivers/cxl/core/port.c |  2 +-
> >  drivers/cxl/cxl.h       |  2 ++
> >  3 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b..9f005f3193e2 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >  
> >  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> >  	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> > +
> > +	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
> >  	cxlhdm->target_count =
> >  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> > @@ -1084,6 +1086,30 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  		cxld->interleave_ways, cxld->interleave_granularity);
> >  
> >  	if (!cxled) {
> > +		struct cxl_switch_decoder *cxlsd =
> > +			to_cxl_switch_decoder(&cxld->dev);
> > +
> > +		if (!committed) {
> > +			/* Ignore interleave ways until commit */
> > +			cxld->interleave_ways = 1;
> > +			return 0;
> > +		}
> > +
> > +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
> > +				port->id, cxld->id, cxld->interleave_ways,
> > +				CXL_HDM_DECODER0_TL_TARGETS);
> > +			return -ENXIO;
> > +		}
> > +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> > +				port->id, cxld->id, cxld->interleave_ways,
> > +				cxlsd->nr_targets);
> > +			return -ENXIO;
> > +		}
> > +
> >  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> >  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> >  		target_list.value = (hi << 32) + lo;
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 1215ee4f4035..28eccfdd75b8 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1979,7 +1979,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
> >  				   struct cxl_switch_decoder *cxlsd,
> >  				   int nr_targets)
> >  {
> > -	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> > +	if (nr_targets < 1 || nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> 
> This contradict to what the comment claims.
> The comment says that Target Count is a direct cound with 1h to 8h. However,
> this check uses CXL_DECODER_MAX_INTERLEAVE, which is 16.
> 
> I think since the capability field is 4 bits wide, values 9 to 15 are still
> acceptable.
> 
> I'm confused by this part, it looks inconsistent, refusing enumeration above 9
> doesn't make sense to me either.
> Maybe some explanation to explain why ?

Thanks for the review.
Good catch. `cxl_switch_decoder_init()` is shared by root and switch decoders,
so the `< 1` check didn't belong there.

For v3 I dropped that change and moved the zero-target reject into the switch
decoder path in `init_hdm_decoder()`, alongside the other `target_count` checks.
The original `CXL_DECODER_MAX_INTERLEAVE` bound is unchanged.

-- Alison

> 
> Best regards,
> Richard Cheng.
> >  		return -EINVAL;
> >  
> >  	cxlsd->nr_targets = nr_targets;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index c0e5308e4d1b..291ada46b646 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
> >  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> >  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> >  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> > +/* Two registers with one target ID per byte */
> > +#define CXL_HDM_DECODER0_TL_TARGETS 8
> >  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> >  #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
> >  
> > -- 
> > 2.37.3
> > 
> > 
