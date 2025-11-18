Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77272F6909
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431813; cv=fail; b=lZGDbVluG21Tc9SPTPfaPfvvj5k8zGiPCk5ulN1Q+xxyy+QZsARI29r1JgJ7+WHUmiG6N+zaXlykAs/eDxOLu93rm/FeIWfcwZeGIAxW+J8EOb8o6KBtXWV2rLhtu412J+r7Gpjuega/9IF7+9kI99pf9agny5c/mzw45uMsfk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431813; c=relaxed/simple;
	bh=L6mmepMq5TqB+MVXRoYKPty/GXNyhNcwvvoTsX20+Wc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WbW3GAZBkRxBidGRyVXZFZGXLvbSj5sTfSKfny2/+dWvJ1Xjf59JQvIgiBBrkYnk5RvTjCxCojYl0bvW6uOBYtBfCjxl4WY1EsSTm13UwH75it5KsY79a3uoNqkbTVBYpXWCPLdjnbYJfTmzWH+zKnezEbCfOZdeUo9yTuvv3NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hayEtb9R; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hayEtb9R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763431812; x=1794967812;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L6mmepMq5TqB+MVXRoYKPty/GXNyhNcwvvoTsX20+Wc=;
  b=hayEtb9RobGnWI+WR27M90fWz55aYfgXeqz336fw90gYvx/SKbHNbZCR
   MM4a8mw6yl15B37x5JgPc+4OEL5l1MCLKh3XDg8TRomFu+ThY6eX6RlOa
   O372NwSzqksLFc19t1CvPjyyYGec9sSjpE2N4gzLZ7br2o8ym4ckaDvOq
   Bc8A0RioPJcAq1m07nrLqRK6ghCEzMSO5s2LQSJb17ebiS/F+kvrf9CCh
   4FeexBBYIPbuLmwX55gJn0mR2i4ALR4rLG+lvs8iJfW2kGduulIUMA5PP
   KqSh9y99TsH6QvVUO5rTSevVXz/xQkTetrbjU8E4x3K8fOkVWAihKrLlJ
   w==;
X-CSE-ConnectionGUID: 2vD7CslOTGeUC7aVuL8B7g==
X-CSE-MsgGUID: DrH/Ic+VRU6NZy2X5bbxIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="90919872"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="90919872"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 18:10:11 -0800
X-CSE-ConnectionGUID: MLuZbgK7RGa1bWYtoIP97A==
X-CSE-MsgGUID: WAF3pzGfTEKjBFrF2g5Ilg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="195546362"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 18:10:11 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 18:10:11 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 18:10:10 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 18:10:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWOFmxBp/SEqSAWVRzW4FBi88DQ7JczRXZIjbQ1iRvBbU1+6255qBG8M+5fcBpQlKCtfpBpTO23ILy5xkWnIMN8rKNV6J8UbdtmpK9epR+fIkScHGOJr9YUGEqYE/sAzopooQXwmbuf2h9MbNXWSqHUkFa1BHQATf45MNgbff8qfWyEToY+3CnKacsnH1M6W4qBOgB2U8jSOkwQaLfndyS5FJ40vGPMxeySE8zMlA+yWTlkIyljCp6yRXGAhjQk81Y7iZ/IkcTMdRBYU04oBCbK/AObNdt1bYAlo9tWEu4OR8d/bZfUqL875ZuoPe6cdnm2v0S8pnK3PlkyEBxoQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE5FrHSSmTSApD9mLV93vtJlIjyTRMg7PVAmGGWJlBQ=;
 b=nu8N4oXzdDcSu0RLK6xp2CelxqowE4Sp42I7oX+tl5JmbQbmcUeqT2Y6Cvwmc6k6RwBJn2A4HfP+nauuS+aJDispS1hfrf5h6FSiwf+qkNgDfufE9MrRs9e82CU6WTSsA/GKhjCnq0+z0I8EBDQFaceL2MId3tKn66fW3/k5qNzgXippxhvRomuHOjfnfKMbMTdb/6wNUQOeLiaPJKHQPEsTINWzSG3aTYQriONCLP9RhgFnkiuQ6doCk+7OpNZWwj8oZazc3Hlo/ServXqLQJYQJA5CBITsGKaeRttuXkAfhhLH+i85So445Q9DrfII2N9mhj/SKCIr47BXQJiztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CH3PR11MB7324.namprd11.prod.outlook.com
 (2603:10b6:610:14f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 02:10:09 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 02:10:08 +0000
Date: Mon, 17 Nov 2025 20:12:34 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Itaru Kitayama <itaru.kitayama@fujitsu.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH] cxl/test: Remove ret_limit race condition in
 mock_get_event()
Message-ID: <691bd61210fe4_5df310028@iweiny-mobl.notmuch>
References: <20251116013819.1713780-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251116013819.1713780-1-alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CH3PR11MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: de1593ea-9b84-4d82-a712-08de2647991d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sdNN1qIUlj4pM+b7mxli1nfjgN5keoDSquxyINq8F+FpDbqKkwkwQgFvGRPG?=
 =?us-ascii?Q?2pEADci/seOOr4cCeUuv8YiFjbUaXouxyXZp2p1qeZFCkfX+MBSG4xn9H+os?=
 =?us-ascii?Q?8isu5JMi22/vkZMNSymdZJEjqITZPd290PWPgr77dNLiCij/fGRLGX7E3gSj?=
 =?us-ascii?Q?2WKVDiM9+sUinXsL4rlyNuxX43RdkCyo8Ztl9LVrsDA0FtPx7NgdmVwQRdX0?=
 =?us-ascii?Q?AQfYM8ZiugigBHAoczXCbiuYP0yluT/d/dwZLopgm995ajI1An694ZcjqK5Z?=
 =?us-ascii?Q?7ZszmhVQtsn5VvUl64YRufMX8Hg2fRRRFup8QZxlE9a4RhGe9vHWNgaiWwMP?=
 =?us-ascii?Q?2HQVJ5PBEfK7YF9qEa7QM41lZgTDwWGSDAK1tisclLLlQnLVX8NAWPdvKuPH?=
 =?us-ascii?Q?crlPYl6bwK9dSrv4dqBTPicTm3650iOOOB4doR+bxG+Tr0BdyCH2QMa52SBL?=
 =?us-ascii?Q?K8NFYVJIcx7J0a+PGQyhtNfQ7Qd2i29reWaAbsu9IEGD9EnZ9Gy4FnxsoWbZ?=
 =?us-ascii?Q?5ggBoAHh6i7c/CGXVbKChkjxJ78OCAzdEcHV4vMFhoB4FszAcxrRNiu0E6HS?=
 =?us-ascii?Q?y/gHcVTBfRHDebyyyhoXmQxGajB7X4UaRSoR2CYRGXLmD3BJYe2z9gOrmK9n?=
 =?us-ascii?Q?x0fkh6mrMMW5fkAdsaHMD2cZDSLpT25cPQkJUB1WgVxLA7ItDnsvkOzGnNtm?=
 =?us-ascii?Q?6mz9Q5mt8M+EAY0zG+cHJ8ex6AUp14YH4WDG+lBZs//r1fItIYEzDivNM8GX?=
 =?us-ascii?Q?J6BrxFhroqYi2sz69KUpGbDbpFvRETQvpQEHy3NzTvRSB9ZaOh/cvlkNsbaU?=
 =?us-ascii?Q?oyIAJZVUaEZyT59/BTjPLCaJyFQmCKgegITyO44vIhlRPDaQn/XkecQXLePt?=
 =?us-ascii?Q?wWeHE1Sh1r8RHhQ5liJlpSFobBNNO6PvPAA+HgFIJY7XnKWy5EISNa0hfOZS?=
 =?us-ascii?Q?aafpZT+pdL2tckinfzM64IZKR+xm8zfTs/aEa/A/dnrQYLs8VyL/YSsrLj5s?=
 =?us-ascii?Q?ySzfl0YEaDhuDnAQmz+OuGnbJ6H9UhztNeSO/TFC+1gEP5ai9rBEFBklzdU8?=
 =?us-ascii?Q?k0uuIFFE3VXIQMfMpVnKE2+wqSEidRdMmtP3q8SDp05JEsoS4eaiehOV7p44?=
 =?us-ascii?Q?EVqmg6fNjoN6uRL6jaPzWjnDI33iqek7HAwB2V7847nP20G40sQK8vc7tkAm?=
 =?us-ascii?Q?87b9EAolXjBNkffsY0cngyi4Lh/uPjzGJmhD3zEmwgJar8SUe9JVLGF/Ubd1?=
 =?us-ascii?Q?aXUkyXPYkK7hag+3sM09Wq0iDTXjoyUfQBRSKmWc6vcVtvjCjj83egId7QTz?=
 =?us-ascii?Q?VG3Z7JTJJnXTqgLSmwgIgGV1RytMumvHzrVaWpmq85MQVeZ99wHS3ZbUEhDR?=
 =?us-ascii?Q?RtMlCLJbfqn/WpJv1wjg33LFvwiETn3kSGJ97dlOoqQ+f2WJKMkc6KymW8kw?=
 =?us-ascii?Q?O4wtXUU7DAP0MNaufULLu2sOBz1X3pBU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PNeo9i7nqDHwKRKK0r22SI9VfJkNsKkBLqPyykRd587Wu0iTrKR7+8XYjsIj?=
 =?us-ascii?Q?D9dF7jpAjzhpdPSvzy7FPKnr4dIqezkn2a2imP5QNk0XJZfPvKix+Zzxgxl0?=
 =?us-ascii?Q?JUnGzszXKPeVtPJjNX98ZQaWAwmQD4EBbenfiFvzZMRL5iZKZ6YRPCg+VQ/F?=
 =?us-ascii?Q?yiz+hN+Yiw9rM94O683qaDg1wsA25YKxW9wc0UXip/ebJIeLSl+rohZjiEBE?=
 =?us-ascii?Q?m7KWuzQIYmT7YnbEVmpb6fSXbO5rJVWPERMXhZkla5oZGeqy8u6x604u72km?=
 =?us-ascii?Q?sSp8xKqQW/pniWkQ2yin6OX8eduPGdDDG6EcOKXIWd/6OuGLUrKNLc8Sh00x?=
 =?us-ascii?Q?JGX07J2E2qBiCgmo9hAdjOIHjUxs5a0gFvL+bN6veEWyEY7cI6UgpubA8nbH?=
 =?us-ascii?Q?llu/iiroZHoMdx46nrIfbK3ZzFvpFxr/+030WjV0RTQalMHIYp7l8lEaXzkG?=
 =?us-ascii?Q?v6tPWqkwMvQG0LxgW2Q/OBNJhLucTCuaN6DK0GUY4toSimnID3Cd3jT6bp9j?=
 =?us-ascii?Q?SPjL4hiXgpzxWwi/HD7zSRoux4JMJX5OiNcnIBiSiHnugk6kxs5rFwy7bymA?=
 =?us-ascii?Q?g2fA12UQETSzYBk4N5L1G79slK28edIK2jNSpk2RvQOAbOAvxtMWSjM9n1f9?=
 =?us-ascii?Q?cfJGyVF4UzlZu6/w5H8/XxFIYq3UJZwDIaJB/C7/Z6GIbaZ9PuA5H0kYbTa8?=
 =?us-ascii?Q?ZaY/dcMj2/ZHos3mC4grkwim4GkyejshKosBYGA/9K0blBFNa5GvOJk/f1p/?=
 =?us-ascii?Q?d85WRpAFJthSrBVp2oUkIM0txaRf4FqErrBzi0FpQvZbpsQtTCQ0P53hL8Ir?=
 =?us-ascii?Q?4PxMSdLJ1myTup3TNJAJdiV7oO5lOpo6UTQXFJYd9XO+qzwxNGqkmDrExnIi?=
 =?us-ascii?Q?z3AGnw6Awg1Mo6o0iavFbdmGD5mBXmPZB/XU5cphq6sBlIIwV4yIuQCeg+1c?=
 =?us-ascii?Q?N9SgcwL5dRMZ7+ywQoiyWZ1EP2kYOYnGveHln6ja/gYVDCryJkIgHjojUSDx?=
 =?us-ascii?Q?bs/gZSyH+PQzAQHlABU890hJAY+6dTKZ5cIVF0E1JipPVYtqKb5RLbqXyfIi?=
 =?us-ascii?Q?oLC339GhnspgExKWsSJfExPBa1q5SfZbJlBaF1F28A5M5gFSLbIBdhYmO7hz?=
 =?us-ascii?Q?4zMNSY/UzKFyFSCWn7snyIIN0LkNGtw+vJVro3LBIKUS37KEMCJZkS+JXe1b?=
 =?us-ascii?Q?xLBMm1FEysl/SMXKfHPT4kKJ0BqodEG4zx9QaAcOdUHyo0nKyTqCshynJwii?=
 =?us-ascii?Q?7Nb8y/oGNUR0LohoYO2N/uLR3gs5/KfAwqrrVWO738sLmMdJGXcB3q2BuImb?=
 =?us-ascii?Q?vhCa7ugHmEN9ETukaSe3IxOFTCv5TXQCw3ECFjxIdvOCNWspy4+BWWVd46Wv?=
 =?us-ascii?Q?phDeXOY69p2dePg3uYCoKD9r08MnF6knwuY8Nup+xajVR12nbFBNa27m3IxY?=
 =?us-ascii?Q?occv9DTYfm/ifiw2WyvalUPul18t5lVRdr5ULVHdNsLVkliHrKjELHgKwJIB?=
 =?us-ascii?Q?qjuV+id3g92LxL3BPB+KMOht0+osn5g5//OJgxcjXU9oFK919wTb0/KFlvsz?=
 =?us-ascii?Q?yE5fmEIXXzLT3diPBBSX+DUBrUp+Si8p/gxjtfm3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de1593ea-9b84-4d82-a712-08de2647991d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 02:10:08.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmXVJ8BTcKygMMuboe41EL1poCmg3ujcGehr4qUeIF8yTOWgnqO+lXiPAbYG5nSQyF+VWkq9rwlsuiC4hRRuxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7324
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> Commit 364ee9f3265e ("cxl/test: Enhance event testing") changed the
> loop iterator in mock_get_event() from a static constant,
> CXL_TEST_EVENT_CNT, to a dynamic global variable, ret_limit. The
> intent was to vary the number of events returned per call to simulate
> events occurring while logs are being read.
> 
> However, ret_limit is modified without synchronization. When multiple
> threads call mock_get_event() concurrently, one thread may read
> ret_limit, another thread may increment it, and the first thread's
> loop condition and size calculation see and use the updated value.
> 
> This is visible during cxl_test module load when all memdevs are
> initializing simultaneously, which includes getting event records. It
> is not tied to the cxl-events.sh unit test specifically, as that
> operates on a single memdev.
> 
> While no actual harm results (the buffer is always large enough and
> the record count fields correctly reflect what was written), this is
> a correctness issue. The race creates an inconsistent state within
> mock_get_event() and adding variability based on a race appears
> unintended.
> 
> Make ret_limit a local variable populated from an atomic counter.

Ah yea...  good catch.

>
> Each
> call gets a stable value that won't change during execution. That
> preserves the intended behavior of varying the return counts across
> calls while eliminating the race condition.
> 
> This implementation uses "+ 1" to produce the full range of 1 to
> CXL_TEST_EVENT_RET_MAX (4) records. Previously only 1, 2, 3 were
> produced.

Does cxl_event.sh need the limits to increment?  Would it be better to use
a random number of events?

Regardless.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
