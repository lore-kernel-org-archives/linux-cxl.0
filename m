Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE64E8E02;
	Fri,  4 Sep 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538748; cv=fail; b=U6wApvKmD4ceM5LWWvB784r8YJU4a5crjWelBvtLuzmGVQmEJBeDyUrtRXA6l3p+yOZuUIBXfJM1PWAkAwnl9dZLoyUAiShC/sDrqjtaTSdG4hAihPT/UwJGe12jcmzlO7NpWLdwZbNieAsk3dDyB7MA6k467HgcXXJ85sgkhr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538748; c=relaxed/simple;
	bh=RDfIKWJ+sN/99fJPkhRiS/dTIlMEROfZAGbHiPJEqig=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J9pnReQf34OoeJT1YXnnNDxUOC24QlxHZQxmXJnMq45iPj+sU/EAjjBXx4GPFzBq6+elZ9sOP26Ym3+YTP8R9kFNjKZ3fvE6EL1GO16luWE0EqwaU7ElyWSZwzIZIq23Ubkp7P/OV8UxTK5u/hSgCUeYLpfABSM6+H5xjclIbko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8dSxCaD; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8dSxCaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788538747; x=1820074747;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RDfIKWJ+sN/99fJPkhRiS/dTIlMEROfZAGbHiPJEqig=;
  b=Z8dSxCaDml8hsXcCdLWFLlT97IQitl+xX1GeO6QDqnXVhG5sE2DtvDSJ
   dlOTw0+/qB/OdAuqJbfISJO2nOYSYFa92vMKzrhvbesKWdxxTRlluXDK4
   nqZqLQy555XgRtrJ5EYIx1zC+3xlGd5pHMMYtYtHSiO4tKeiGBVa9e/IN
   HAkEc+Gmju1l7I7f7TGhAMhtmuL3ccuD7K3fHLN1P9Y6kSBOeAuR8iFRo
   +fcTNE4dq0phk86buWOEst8x3V/9uneIkqZzGEadUz+L7BuqRoDkix+UW
   PbDIEv9tcs09UoDxxh+nTAtdLP9+6er6Wve+VipG438v70BInaF0V3H52
   Q==;
X-CSE-ConnectionGUID: y0pGkrzrSVuZRLVTFXs2Zg==
X-CSE-MsgGUID: S4q+dexQTOmM5mEkPSTxxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88187442"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="88187442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 09:19:06 -0700
X-CSE-ConnectionGUID: dt85wHlSRquE0xxo6Xjp+A==
X-CSE-MsgGUID: HZtyoWdpRouZ81VvQ30jBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="266396954"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 09:19:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 09:19:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 09:19:05 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 09:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sz5s2phMWOL4s/AwqFN1gAMqX6EoU429fATZqXRFeONdqSfmkyqiUuLcEiXMvIa0YTLWGPmup9gjZRFyyUgpyNBF+k3KcZvLB6OAwyzV37xnlR0f7I/fW5Fik7bJvOG0SlLbbhgKyOqpOVh7QHhyps+uNVJXQ/Zv0jykSlt1YbOLFLjyandihfcVZN04OU+jPko3c+O+SmW3OHr9+j+0l3gZ/5zcfE4GwUx13YCugYBUSP/ku6qgLwUrbiD5SKh41zrpzj4X7kvGU7d+/mdOi9JSoJMnQeNxg9189RxcPOVYYC1CGqGfHUuTw/EnFzSG0sFYBMu42VIhqixoGZb1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eUs0uKUCt0M73DTwzOwZXdFv+QIX/w0YuxS0wosDco=;
 b=f0kgZuQxObAuYS5NgSY8WySXekkhheOR6LjOMkcGe/Yid76Vg7pWWiFEPpAF/ZfOtySpfc7PPlSb3juCl/9zzUpsWj89flwZqAxV/75rUX9jdef7uhjO3+hLLMiQQeBvN+wEiKYJvqYAvDvi9s0ZHeE9J1OZ84HIIqwYBOa5unm1wPuGXKkz2G0+c6S3gSEHeMFYFYDuU/JWje4WFUZh0Ji2+gg+2OL0ewjrtRblMEMGcSCfnXgt5rJakaCrg714TtnUbl1xkmNo6s1yJJC7DJitiFRc72yWyaG2UqrA0EWrtvS5C0hudUt3Y5JQF1C0ws4A0jN1/L0c1QEI1j+xvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:19:01 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 16:19:00 +0000
Date: Fri, 4 Sep 2026 09:18:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] tools/testing: fix typo "occuring" in comment
Message-ID: <aprvcDMx4X09jnzI@aschofie-mobl2.lan>
References: <20260904104013.11549-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260904104013.11549-1-hemanth.selam@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f88a43-c6bc-4853-6338-08df0aa03abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7k1dIUG2ji68qEbok+oB1zBpIlmwIzAFu7mzo+VqKCXvnFYmBC0kqcz6qdhrUXJlfqQoJ61iScU/HiKmWhzeNeGQlVWwnBGwKlDbhl09OOzgBZbF4yx1axs/b4GQ5LGwOcdFS+yXlnjNpAM1OyYXZfk1qjaVFlH2sxdLYPpOzW118aJGbrnBmMmPAyMWH8emBiGODT8esgA97HHkFyJ02SsFiSbqaemkIUigMHJo6/kp5ElCsVJCFB9YRSZ3m3hjj+st4ce/GlVLkpXVUcdCw8Qn5IvA4IjfcrF9o3z5SmIniWV1IhxDUrPxgyS8KcRUlhJ9w9VkLRDDs2jiNldTwcQ+tN3SRdkCcgmzIf/3Je5hnGiB3+joLecAnXOcDafbVUUSgSjkrfp/bWKMDADa2MX1+XsJKMrJy94IAeAFxr7V8jSejZm/HTP+LycZxpy+yQBtmAR1in8rEJfPI6Yob3t+QV5iXpsgVZNOOKsb1xi+Y1BgMRVPg+mt8UcDNmWkHHg/N1hXBs5PrlkyYTm1fj0iTFW1RAi7QaERo9M9U0J2rF3WadLoTkypNRiJS/s9K1g6fxVUHJU1F5+ohyMZzs54+V4qIGcnTQhqBzcFbxEL6PD/Lmx4bu1wAG7r6YtF1UvNUVOMbthmA1/6KKpCCHgl9VKNlIsu5ngdqH+T07Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5V/HMDBYEm1TOWEGmz/Rcr8gvEN7RUUvfG2aADKO4JbSSl+HCZRj0TMogy/n?=
 =?us-ascii?Q?M2TkOqLVqdB4t7SX0a6l2PDBiMQ/ZtI2AfbtfER1trRErDmCAB38gCgfqeqO?=
 =?us-ascii?Q?EJI4VYD3QA9jT3nCgJjTcqwf70mletNSbu5FjOC82vt9sS20BbLHIXkTn90F?=
 =?us-ascii?Q?RwfWImrf3ZmOFrprklYko4rdm6di3wDvl54tk8OrROu81ILHhafvngm1VxkN?=
 =?us-ascii?Q?gFEerDnP7ETwuPCIlIu7XLBQPvD4yvjh/vT4JOc8wye/cLBUx7Yqlv6WOl99?=
 =?us-ascii?Q?YfiC4O+OIWlqXmgtXwyibAMLfXWEM53iASW8XYoXEjkxJUCUVFuNEKKCJVNm?=
 =?us-ascii?Q?GO6Tt+7xEtY8ryMRVpebao+H7ImTNf6JAfm+dpXNCOGG2Jyewi7gFwUzxFKd?=
 =?us-ascii?Q?875MwILxsZ9KbWyxLvQjMKRmLgsQAhCXdaa4tPkb/tne/i4w89/3hUlh1mfA?=
 =?us-ascii?Q?y3ti32kixaQJNkBJuj/jcDc+s+WBhzSkiuRjnEdzF347Y31nDYyqvTJkLXTe?=
 =?us-ascii?Q?om1t5RhM4VlqR2e8gx3m9djZNn4TmU2e3iJdBvEDTQwReSKRSIqWP8e5yiI7?=
 =?us-ascii?Q?PT1w7WWQRJfnFfBp3/X4xhCqz+XSq1cGb35JKoUi3uQOEsn4L3EHKhs6wXSX?=
 =?us-ascii?Q?+YAhoe86OmLjPuWE4q4zdnw2/wEeuQtnrnucCGPxcUvyFDaTlVCiVqeljKTu?=
 =?us-ascii?Q?Ihi92OIEMmJicQ/IFgJtUQj7S6W7U7gdYT2sI2Gh3NyT6XF4lTGJkQaVDsBu?=
 =?us-ascii?Q?VexLVcxiA9CTQ/VgcAPNEHxrgfds50ImE+9UVaqPHyzoT6oOkJPbgNfMAEsU?=
 =?us-ascii?Q?4fxaqykIr6D5HIBEDtTf0i/7xYXfh/uLxL18f+uEhZKQ1Lj+pWE96gc5YAmx?=
 =?us-ascii?Q?Oy4rPQ162kcaLklNfmOwSnr5Akcysq/KjxX6thqwtSxPLZfe/VAGvUlISOFe?=
 =?us-ascii?Q?QQUlrHnpfdaQFmkivCC+w7ZCvB71qq3B797TaOCBZSPbU7PSf1an4bDvLoHc?=
 =?us-ascii?Q?0XGcl0/kVrWEKyUvtDnz0urUsEdW1FOLp3m49AaLHDT+pYJ3isLoJPU3MkUm?=
 =?us-ascii?Q?+pkehlzMSUohzmdiTUceG7mHFHb201+eZHh0yGJIvpHHKSwPS45izkTN4J5T?=
 =?us-ascii?Q?+vLrPsVUc6ujVj1mfXY+vJ63d6+euIs07ZG7i45Xape/r/aevIHaia68e0JJ?=
 =?us-ascii?Q?Qbf6d+prIvBQ4dyX44CjY9AcchyIFb0yenouFfeXSMrmrXfNg34pOkaU0QB6?=
 =?us-ascii?Q?QRr5t54LPaHZpl36oBQ7StvM++H/PqgpiRLxNgNC+18BZuL7jq01cd+2VNg7?=
 =?us-ascii?Q?oNWTLTlyJPzIWWGsxG4apIRZv7Kk9Gejsr/vPrMwGnkPVQ55OJB0hnyJ+rRm?=
 =?us-ascii?Q?aW0rxJw8l6KKZp4p7PEpDT4HEiR2A3U/862yOhyu7hEkvd6Jl3lymhLeYhg4?=
 =?us-ascii?Q?gkUPGmtbvi/beClFGsuXOuwidIKzaxoCQ4TkvxEOY0kAUv6SfFvvASyfrCpN?=
 =?us-ascii?Q?3OUUgfZzjUXn/I4oRBl0YykM2+k13apgVh0Z9feRNNOViCux0i8yd861d2if?=
 =?us-ascii?Q?iiOMbP+8jVmu05LaxDK3nIHNlP5ds2BD4RQyR6Wdy8605/am9gaWFoiy2hKr?=
 =?us-ascii?Q?ibLf8DZrOrNckMcdiZYWNj50Ea8ZsAeYC3dcUdHDk+wCndHSITGeOR4dU5kO?=
 =?us-ascii?Q?TF/vAJx3IVaLVe4u/0r34KjHl6d3oC4VO6jcd6mekQ84JApI2MQrIN6ajAue?=
 =?us-ascii?Q?1+zqs8RR8znyZ9ykDWDqwC4ChmyuGEM=3D?=
X-Exchange-RoutingPolicyChecked: sdsQSi8iYHR2mD6OPDIhINN8rr2RegM8RrY3LCJAnweS1jzfppJV54LQO7aCkVX8PPqLqZUkpCf79EiZCSbIfq9r/xVndS/acf/eJDnBshULmy1SEnyiyAo2TDTxcVx8OgWEZPqqxh124xJMoc6spd1gDneVrMd/L5pIrXgJtswXog9n1P5wZmhk/R8lvdibiiR7Rsmwrbxyn5ov7PSRiaITabKXNOmBPDD2U8AcW3+arRawYuf/37UyuuedH2im6RZSg6VtCGI2lVVXwwup+KD9qu36CxSQlZ9XQOixzkx2xKbJ/4i4sbJ/kxX4N7VqeYOrIhoIyC6OsnTbrkSNOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f88a43-c6bc-4853-6338-08df0aa03abc
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:19:00.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUg4bRIKY8lqXZOdUtebOnRI0BL3VhRvyidf62S9337nRjRvDfc/lda2c8/dMUeVVb6YFN3kibkf7TzN0JXR534ul9aB+BKXWvKxBF7tXSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com

On Fri, Sep 04, 2026 at 04:10:12PM +0530, Hemanth Selam wrote:
> Correct "occuring" to "occurring", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.

Hi Hemanth,

Spelling corrections to code comments, which are not user facing,
are too trivial to be worth the churn. Sometimes folks make a spelling
correction like this while they are doing 'something else' in that
code.

For for CXL subsystem, the better place to point your tool is at the
mailing list where you are welcome to review patches and reply with
spelling issues in any patch commit messaging, user facing messaging,
and code comments - before the patch merges.

-- Alison


> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  tools/testing/cxl/test/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 7b756000a1a6..3d8a6d2b69d7 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -246,7 +246,7 @@ static void mes_add_event(struct mock_event_store *mes,
>  }
>  
>  /*
> - * Vary the number of events returned to simulate events occuring while the
> + * Vary the number of events returned to simulate events occurring while the
>   * logs are being read.
>   */
>  static atomic_t event_counter = ATOMIC_INIT(0);
> -- 
> 2.48.1
> 
