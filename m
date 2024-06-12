Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00142257D
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718165237; cv=fail; b=OsTCxFSMqVF5FW45gSCdHpPaxCRQ1DjBUgfxY2Ipbha4LF3wrp6RWC7W9uTyiE5WvtBXd5NfPX6aBpWzfaixpgjvzq4g+ASO7WVGJWCFT3uAgGQ/15e7bqJ53bz3myAsGzwoIbu4ScPJKkFnkcFYW8AJobwANqqjENbeQ9kQ+bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718165237; c=relaxed/simple;
	bh=kiHeI01VLflLsw7GZZBAbd+V5/INHFlry7S1u08ujxk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k7ToO1AN0WL9SGlaPER2E4PFk5EKqdaohZ9WD5vXAT0Btg05al8C2ysW/QPmhHJqPjCRQWuUUnbHWCamSQudQdGneUwftXZtqFcF3oL9qnawTF3q2d4ml7R2wdJxh9cWM7QrW1KdlVHZxv43QMfmQC/b19xahpVvW2omxoSdnc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/D9PZG3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/D9PZG3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718165235; x=1749701235;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kiHeI01VLflLsw7GZZBAbd+V5/INHFlry7S1u08ujxk=;
  b=O/D9PZG3hbpbJ2r5sc2mVRZHElOE4zfjKYHSPGbwMW85hoqE0djjCcmP
   nWRRTZU447t2fKdeFWCgl4RIKdYDg/0BI33RqR8UPv0sguCL4+XTFc3a0
   BElIcaGdMxbw0J4aVShO+Fzoy3OUtqdSP1DyHMpm7RvT4xSew0Iz6HVtr
   65gQTUegas1VjOyBvPkSBEYaj9IZ3LJAWhPuGoFhJho5r8Gn0mEJi5o3d
   0NYO4HR34tgwjB+KKX7ku3c+Rbip3wsfu/OzBojVe4J6SLVM/C2Kp9Lg8
   GiR1IA1kUMoeuHQGTbfUj9l5KYX2XVmaLM7OEGZw430KgP41lW1DQWSMk
   w==;
X-CSE-ConnectionGUID: 9g07S3CcSU2618YC5ooksA==
X-CSE-MsgGUID: wJ0N3wCdShetFzYDJQftjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18740784"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="18740784"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 21:07:14 -0700
X-CSE-ConnectionGUID: JuvFFUZGTF2HOOZMca5WPg==
X-CSE-MsgGUID: A8PAAxwCT7ew95f0Zt7+Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39582116"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 21:07:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 21:07:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 21:07:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 21:07:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLGulcOrLLZzAd3tcnMP9cMHWFCbWq2WDTknVSFWQ9yTe5FbDDPv7HzN05hI27N8CfY9dqdEE52LvJY+HRpX2yrrHvNiWLfOylmRUXeZPKYQW6YnFx5dA8mQ/h2Z3bJsKyn8etx/Nv+nnnTcf0dluGYuXIU+S9jzF80zgMwbCNxv8of12DfeZwomqEro9L5KWve6W6Pq7eRbSsUsq9zYmGyH0az3H1s91vVv7aEsWA/AHcTOravQczwU+Nu7NDFkZy4TK147wP/5yyfx2ZalAe0M1hm8NjNgZ34uHb9fJsm9gGO6XYUQgkgNAMouyIdBbwNrVKWAkZ/YxX+lbRdL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGJAUpFg8/yEKH5+6eEkHC75arPG8inKw9RyWGK5Mlw=;
 b=GXGz5SDy0HDcvHpNrDLGwwHb33K+6uq8iM7AQMD24FKQU88c7BopvjIKyfXKdrzHclLVNKgvjcMFJndv7tU07GxnzmZ5auDpJwvqrj4zx7US+cuR2MTZe+XwTC+g8IzKt25qhC/6T8ggaetDjzOZsSxRv/5rxFNlKHrGVrLmWuy3+Gt0MDdrnNXhp/TzpS0JbtF9anfUTayFF8SDf0TdQ+i/zYyhenLaTMTQHRaqYLtuJoEKBI1GydRZYaOhR5zVTz71W8xbMfhUKWzGNw7vh8Lr2c7A6N6JTUvoC9k2SiCtapIH8DnqyYQOLWwIAjwHQltKLm+MLcXU3S7Y+K7UWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 04:07:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 04:07:11 +0000
Date: Tue, 11 Jun 2024 21:07:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jim.harris@samsung.com>
CC: <linux-cxl@vger.kernel.org>, Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v7] cxl/region: check interleave capability
Message-ID: <66691eedbe8_31012947f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240612032544.39149-1-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240612032544.39149-1-yaoxt.fnst@fujitsu.com>
X-ClientProxiedBy: MWH0EPF00056D03.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:d) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3591c47a-f270-4bae-6677-08dc8a952284
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x2hxa2uIQ1zPV2Sl30k4Ai9jCkW6ob1P66cOTscfzAqHRLuOv39KsYmm7ZpR?=
 =?us-ascii?Q?Tx+Xvg5fFFs2WwgEygXseZe01SpkrBQAZee0dORfGtIbxGliML0+/tAEAXBi?=
 =?us-ascii?Q?YTQtTSsSCShVE+WKvae6Hc6uhl1o7E03SqCTVOscA3TUZU3exf9dFd44X9O7?=
 =?us-ascii?Q?I8PWabdV0o/0BjfosQ8xDOjthrQDGy5v3c6Ot4YA5+XcDBJYJD/45GSi79eW?=
 =?us-ascii?Q?VAy1ps4dyK39I43BPuMHyF3DqHwIjd4j3D+JqjT8SmQ+INrcLQ1VQ8W7ZpVW?=
 =?us-ascii?Q?UKwF3gRZVQArlbjzuvA+a9DIcRy/mv0IFEVPWc6OKwpvJAdk6h5tETE81bUV?=
 =?us-ascii?Q?GK9Tc5u4epCjndOK1W1wlGWacDeih3+k43XvjDfVp/4gwggyGkQtLIQXHxr/?=
 =?us-ascii?Q?dBlzWle0/qQYonyY9ILudPOHl6fY5eYMN2mPt3WeE/pR2LMzdlDD7jXABAMF?=
 =?us-ascii?Q?D6sQtuD0Mq4Ix8WX2zEWNLiVznki/IniyEKsL820WUksnypF0iE7e9PgFaZg?=
 =?us-ascii?Q?salXjn9XYmEqdsAYhLeyk/UK9W0hp8Pk+URaAGJhLPzj90IWgFHwN02RaIQj?=
 =?us-ascii?Q?iBSXyiyaM8d3fEB4wKTSUFsxNmUY7nJwLHn+aW4yf3hXIMBY93RY66v81vDk?=
 =?us-ascii?Q?S2Do91k9OYxFIcyilFZxDH+2raO8w+iIOSryK9xYGIUtZprBl3jEl6JpHa3y?=
 =?us-ascii?Q?7iI4tUHuVX7LYUDLCDZSHugTkCA54VUIZ9WVOWPddy9oN0aqHtNGuCpIunPP?=
 =?us-ascii?Q?glAzk7YK35Ma5oeEN96NRCyE0VrU7cLBRW/WEt8APDrVHOt7q+3gpUm17lpn?=
 =?us-ascii?Q?kQ/T7xZKgNqwTNlxN4jaAlDBKqpcOLLvyxkuIn7oaH/FFHxKyclDTWQaB6gZ?=
 =?us-ascii?Q?Ua1e2bwvYRl3mHdbzhKDldJV21nTyJq9rqp0GwFVB9Xrn94hGfh0zQuRQFRs?=
 =?us-ascii?Q?9iyLM3NSqRW2r7pBRunhNjqebxB2bchuGamRyxOG+85oIQ5ydCx6lEt1hCnG?=
 =?us-ascii?Q?j7TaGYs8VcnP7vjU296aY8bLiv5wpGzy6Neqc6zTZN5Kw01a77QpyNzWNgq7?=
 =?us-ascii?Q?+aHsWeSvaq+IiINPS/GULOme2l1GbsVi0X61h2h5zw4mcnssg3GUcGWElPk3?=
 =?us-ascii?Q?fYAug4Cd4nJuR4yrVWwxfCvU78R8iSo9AOZsqo5pCYO3oQVzgcM35di2M24T?=
 =?us-ascii?Q?puQvPNPqk7cf087Ngb0FJn/iZV9KFepIxBuZYKkA0dmnFWr7Px9ROVu2gwIf?=
 =?us-ascii?Q?N+XoLyjumPtgTmznQfWiUMvZC0qRr/+5P6ZWIi/8dBoMcmarImAXoplPrp6L?=
 =?us-ascii?Q?Rw4TZ9D5SFvY/uH3h/9/PdBU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a9rP8P9z/8/NAH2KQQHrrGPGsZW22cgW2YgsCa1qog7YerUryrCFlw+3fj8b?=
 =?us-ascii?Q?UfM0qIigtdRwl6NzHQEi1xVysUxboJWrM7QJdl+ZDYh54HMUvuQwFqbDSRTL?=
 =?us-ascii?Q?HA8jXtDGkTZ2pJjM4d11DpCo8pkDkC6VZp8LY/B5Nh9WnaBRG4iE1ZfEO17i?=
 =?us-ascii?Q?xvgkJ0UZmSVABJyxujXrMgAr+guOzAsmZk8R0nizViFK5kcMJDlLdttSf2au?=
 =?us-ascii?Q?d5MRwRRa4lqDWD/CI1CHNWbgcr7Px11JGYf7KWk7gHLW++woKXOMnHmlCike?=
 =?us-ascii?Q?So/JnluKla64P3ex0pqn3dpOayy/Ker1RPltY5i81L4R+Ee+NFsgVLggX7Mg?=
 =?us-ascii?Q?EFtR3s6glQem/dr0m6S97w5D0toY3JNdMMuZkQzxYvXzoy7bqJDx5ZvSuB0U?=
 =?us-ascii?Q?3OxKrs4HNJXN83N7tF31k6m/0MbeMzBBPHmSOadZI2zJuol8lAx9/AqAHi23?=
 =?us-ascii?Q?KT5hspLZGgmrkybEtz5zuFyUeiV/qIc1i0ROcHCom0ylyls5h5Nfn9AZIkcz?=
 =?us-ascii?Q?KlYlN3E/L6JNW2PGZd9WSN3nMBXvxXeR51uUr80q85PmuMcviBDpsWwtYzyw?=
 =?us-ascii?Q?iYDF0/QoCsdu5tIOEtV6/7iSRXoRyF50GZhHX2AZ2rDQdVLKyzgg2gSZ5PDm?=
 =?us-ascii?Q?buwF/q7tLPNMY4J1nVf0Af8MEkdjzF3I0glohGyt4a1d/tdfjQvHUUbgnj4i?=
 =?us-ascii?Q?7Px2vKRTsTRlnG+5+y94NuVgVvkOJendejwMuiQbBzeRXs6Dtc6YjkxpztMV?=
 =?us-ascii?Q?2xiwZGtNEqL2n7y0dWOZIhRZ1kRSmr2aCpIJkQTf8/8Z2aIxf/fTfFcdmws4?=
 =?us-ascii?Q?7/tfr7MD8/BlIMSxNK04okgFF+erkp7P5QCpH1H0WFUfP1efo9wFjhiumMoQ?=
 =?us-ascii?Q?UhhCRHZhz+H2tAFI2YSUbZLBONp5bLWdsonxpDJKFPjPWhXE9+X/MRHV+pZL?=
 =?us-ascii?Q?WC3n9uh6CrJnViYxnTqsQHChrC6okO3CehcrsI5PNYmB/ANcIwfU5xDRxK9o?=
 =?us-ascii?Q?uMPEk1KdAhgDx5nRtyRSGxLGgFsbZkdgVo+dR7pQxPywPGg2qlAJTR05mChh?=
 =?us-ascii?Q?Fjryde9PhHjsk75tU14TSJBnWS9PJfsoiP2VoyckS05OgeKlzigHLB1C1xJA?=
 =?us-ascii?Q?S2UvcyEwuRqdHQHENjAX/iVCs2tk9yuPLBs3HWOS+vfv+MFgLctLNKYcLxO2?=
 =?us-ascii?Q?NlzQUkp1X5BR8SkXY5kLnjOLp+VTOsqWHUXRu0zj1qr8oD/IstP13C1gXYH2?=
 =?us-ascii?Q?N5V1f7Gasbpcya0uWh8pFZhs4cNMukKKJZF7E2DZnlaUI9Tv1VUYRPd7z3fJ?=
 =?us-ascii?Q?zEFRC5VB+gTTaWPropgapr1Eb7ZgIjMpsDcB7EeMyCTTF8+BgdmGsAYK3rxj?=
 =?us-ascii?Q?At4LkD7KpIUMKR8iOgbYG947hf3jEE7uSAWlPHwKLg2Y6pC+H5jgHfuKGd4T?=
 =?us-ascii?Q?wVbFe5mnk6pPqGSpN/hQZo/tImu4YlSoewy2vv3nQWRj6BarsKkzD/ZxrnDn?=
 =?us-ascii?Q?8dRvaRUH4/c8OznvgYzRZ/X8otbwKegFdo3RC9/SIOy22P6Q1rbwK9LamHzU?=
 =?us-ascii?Q?akzE8r7mBrPM/sp/r3mwcfB+skbebMKD8HmmPgHAgvu/anStv5LEWpHyNBT+?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3591c47a-f270-4bae-6677-08dc8a952284
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 04:07:11.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJHJixuKGFJ/1pTWfLjYQkDyhEaEW/l6RQHx1hu+QT3B+RJxJawbbrIaYQb7cv9JHq8xvJqsbe1SaeAZV8TBCQMYLC4+kTr9oTHA7yFnpks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
X-OriginatorOrg: intel.com

Yao Xingtao wrote:
> Since interleave capability is not verified, if the interleave
> capability of a target does not match the region need, committing decoder
> should have failed at the device end.
> 
> In order to checkout this error as quickly as possible, driver needs
> to check the interleave capability of target during attaching it to
> region.
> 
> Per CXL specification r3.1(8.2.4.20.1 CXL HDM Decoder Capability Register),
> bits 11 and 12 indicate the capability to establish interleaving in 3, 6,
> 12 and 16 ways. If these bits are not set, the target cannot be attached to
> a region utilizing such interleave ways.
> 
> Additionally, bits 8 and 9 represent the capability of the bits used for
> interleaving in the address, Linux tracks this in the cxl_port
> interleave_mask.
> 
> Per CXL specification r3.1(8.2.4.20.13 Decoder Protection):
>   eIW means encoded Interleave Ways.
>   eIG means encoded Interleave Granularity.
> 
>   in HPA:
>   if eIW is 0 or 8 (interleave ways: 1, 3), all the bits of HPA are used,
>   the interleave bits are none, the following check is ignored.
> 
>   if eIW is less than 8 (interleave ways: 2, 4, 8, 16), the interleave bits
>   start at bit position eIG + 8 and end at eIG + eIW + 8 - 1.
> 
>   if eIW is greater than 8 (interleave ways: 6, 12), the interleave bits
>   start at bit position eIG + 8 and end at eIG + eIW - 1.
> 
>   if the interleave mask is insufficient to cover the required interleave
>   bits, the target cannot be attached to the region.
> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
[..]
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 36cee9c30ceb..7fe617122d33 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -848,11 +848,21 @@ static inline void cxl_mem_active_dec(void)
>  
>  int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>  
> +/*

Minor detail that can come in a follow-on patch is that this needs to
be:

/**

...in order for the kernel-doc system to autoformat it like it does
other 'struct' documentation:

https://docs.kernel.org/driver-api/cxl/memory-devices.html

However, the reason it needs to be a follow-on patch is that this file
is not currently included for parsing and needs something like this:

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 5149ecdc53c7..e33ee67ac1a2 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -325,6 +325,9 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+.. kernel-doc:: drivers/cxl/cxlmem.h
+   :internal:
+
 .. kernel-doc:: drivers/cxl/mem.c
    :doc: cxl mem
 
