Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE35405E7;
	Thu,  4 Jun 2026 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541805; cv=fail; b=RzefnQZG5HV+IxOWdG+4d8reKuzFAqFo0Xnpq9P78XIzEek7l7nA0Py/FtYECLMGb6qm8uu6y+QqEVrj2QfOIZiDiKKqjYlFyyx6Qv1FTKuO4ldp9PsREraXphiPt2ZUMJdyOfYOuCe4ngO0LvXhplP2EoEYfjtrLrITLrtn7Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541805; c=relaxed/simple;
	bh=SAD4BJ9WkZ1EVq6PyCFiRHtzjx9O1tKvfASvDzTs00Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=psif7qxkgoC5K7cGZ6F/gqIurYSbeqXIIwSw4nfieCZ/x6z9RVGaJWxEOnlor9/tfgJXuxK1fs7rZoYwYDEHYp06xo9gHJCEfBOEuXb9hmKeqszFmVJLxiq0ULkS3KXDJ0kDmRRzReHvPrYX+6SlvV+7PMo/YNEKanuFcoptlHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqR2tLu8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqR2tLu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780541804; x=1812077804;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SAD4BJ9WkZ1EVq6PyCFiRHtzjx9O1tKvfASvDzTs00Y=;
  b=EqR2tLu8GYouRdXQKV3PO8Hd1blz+Xomlg9Bn9Bq0KciLlbQxICwc5L8
   Z2LqUrguY7tcsQ8FtfmhVHuU/VhPQthT7OeDMh5NtrznE7onbTGcFY4Cg
   x6ufQd2mXe8fvA/PCyYIk9ERr30x2KSDP6jXiCPKgaQ+fd8epD/kLz4Cj
   1Dy3O8tQJNpBiIOxgkYtdmS3sumxo0vmL5aw97cbSSVDUqBRkErgLqTpo
   Zs9G0eZRCGsUIs0R60KDV3Hzsnn0Tl1M2JGsnFkmtMcXb06wU7RUx+8e4
   TAIm0Y2AiGxU5E/r5eIhSQKNfcgHBk+NmX/DG6iPLWX8ErSWLi9XOHafh
   g==;
X-CSE-ConnectionGUID: NiVFPrnvQXmpkKP+TfXZWw==
X-CSE-MsgGUID: wucUxX/kS26vzV8+MmWwdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="104024944"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="104024944"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:56:44 -0700
X-CSE-ConnectionGUID: IFh4M5HtSwiKqJrJoIvKjQ==
X-CSE-MsgGUID: BadTKuxSQtimAr1EoRYL4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="243351446"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:56:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 19:56:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 19:56:42 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 19:56:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJEiKfsXKWilPwTPW87BjjSmHpc3Bj/Z8rGj66/X3wp3jhYSCfhBSvIXhIfadO6T47oMz4zfr2JxxzZWli1/Gv/tD1ZH5cxPOGwtnmH3haq9hyT0ULJdmtRUVgtqGFpgDC46XznVvkbbnDdwuzzpEYkfn9y/ypwsf5z9yVAmq/ZYhJImTf8lKKRqf2pFzRnOCU/aZe88wJKb/Je4kBNx4l5zlDN0CRgX3EWDO0gBIxz0AC43qPQNndEKzDJCoEG/XXcsuUjXJP8pdb+drHVtY7qsKSpTnBTBBiUg0ALUYM6GAQmnyxzLx4QsRCeh2gf+q3J0NRcVmVlb626Du0nC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XOGGcjA8wLa6Dyb2q4ISzmMu7aYJerpSOu7FwS7tqQ=;
 b=oCcQ0drSQKIUaS4SrVSb0JxDm6OVX7fvfhkZ+0RVIzNzOWD3/M39P2GTAdHcEcXSX3Fii8LHx2MqKTXDQec1rMs6ldltUELWTFsYqqSxs4U05iZD4zq5DgM/aAdk75sTdiSOf1Diq2Lb+uAyuQvy4xXiOrZdpaKL7pkR9nNkM1Oa4gX0Da5sLUJ1pZbsHpCXsqbHUsivMHm2dcz0J0Guook4N/S0wKpIIvWJonS1ypUEEAuC3EBKdZHnKR2L1HcmIB2FHTkRr6u7yNwOT/l/l6I2KOvae+uutNGvfGr5/lko/9s93/1PgGvUkfe2cNsDt1Xxftpr9BAM+ui4ncYtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 02:56:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 02:56:39 +0000
Date: Wed, 3 Jun 2026 19:56:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>, <vaslot@nvidia.com>,
	<smadhavan@nvidia.com>
Subject: Re: [PATCH v2 1/2] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <aiDpX63A6NyvPx7O@aschofie-mobl2.lan>
References: <cover.1779957270.git.icheng@nvidia.com>
 <c743dde11ad652a65b84d206085d09d7e56b9183.1779957270.git.icheng@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c743dde11ad652a65b84d206085d09d7e56b9183.1779957270.git.icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 547232b4-3af9-4c83-a2d7-08dec1e4e62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|4143699003|11063799006|5023799004|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: aId0jamM8IyZDC5bnAwVtkQ2F6BKy+DrOHU50wY4RDTIM5HtoWXIBJySF0riCotlyBSIPS1Kdv82JhAJQwCIgN+0QaHPbcNSj2g/0Y1ihZ42IPhPdDzgUdKZPeYDIMQtN3EZWM/hzWryKaU64iW+r5/bXjlqMMFCTu39bb635M5coh1OXGkNgcR9DMzfLDEPfKc1bt7fIWUSRV5v7/BYxnx6VTyTlvkNn54/fPU7p4eM1HL5rfFpbBe6x8vsoSLXcmjdoy0/j245jBv7KNd7brIWHZewehiIhQWGSmpD+oWtkaS98HgvbTQlpqcws7VWRTNutGYa2iwdt2QocDVuDKf/gOfRMT32Vevz0B14dSauQY1jK/3pBAYzZgoNY0vrQZa+g2Ah+zZjMVmCb8m7OzKGKyMApjAtTYrtna7B27WtAAVLQnPLlTKiUHU/xflFhcFKePQYJtHb/giUNWDmkH9iJ6ztf7O3C8M8BwyifOUUUCfRTnGHnpZpk7n2dT0FebiTgXmINYHLHRLkm14Nc8EplKwMa5/aJoDV2tycsU4/Hw8aiqYEnSa03GtwMF5xUnPb2Os4zTxxHVJZpF2KsUk+RQ/W3nMrP1shI2Nmkaz2utFa+NIN5qupXO1VvzPnX/9je4xI+Ytssv6f6bNwo7iZsA9yfVPUyJFi23MSKnL1REJDEUIq1kNKnGX3CQJ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(4143699003)(11063799006)(5023799004)(3023799007)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3/VbBii0WitqEQTdkGXc0s5EKl1Emyk7DvrFrTASxSRyk/wCr+ooo8JUar?=
 =?iso-8859-1?Q?c4DJY7RO2dWKxuIKFakZ9E3s3m8Fl1XMO0XkA1ONXswgEH8QxT2cW3UL+v?=
 =?iso-8859-1?Q?+wQjdti9Jm0bvyZ9YmHXBD9JdsyGGd6EE5xxyPo++KpX9MdBOvwjFudtZw?=
 =?iso-8859-1?Q?KI0QrbEzLJRc9SS5BU8xk/+CnL/0JasScl8dm2lta5p3gKkItQIavp5R2O?=
 =?iso-8859-1?Q?ftPtVJzu1oMO+qnW54O2xt5079D6Yzd3UYSHRkCXQgU/T1+yScRDZi4K26?=
 =?iso-8859-1?Q?7BDoVZzdDXEniVmkkWNvjOabUIwMbEh+cB1scwaUFi4NJanwDqsUsozoHq?=
 =?iso-8859-1?Q?t11IbIubGfMqiLoYYo2zYJwDwMY2YvkGVlq2inygtKOgbWhHalpl3fK2Cx?=
 =?iso-8859-1?Q?1NpAxzdrewtf3DuQqHkb7Aqg51sovgDzCunFJde2zwr1hCqmYOSDugVbwp?=
 =?iso-8859-1?Q?AOUvG9SekLSJYUe8PbffE6xh1MUcBuVZk2EEzKMKynyEWavFLA5JoVtvP3?=
 =?iso-8859-1?Q?FAiePCECjrPIbhWjf2z1kzYwjbPKYbwkcv1kavfzqdmJH+7X2H13Ezqkxa?=
 =?iso-8859-1?Q?7SOGoa7K0qbwmQcQOR4frNAyS/M+s4ep8NW6vh9JzGwU1aYdLjKCftYXmp?=
 =?iso-8859-1?Q?iZ76OwCp8HbYys0GFNx941FikPnp/ikWpl0TV9Z0nqMd5aZFUdwAL//IyA?=
 =?iso-8859-1?Q?YVxq5SFDr/PRy/7eKLwZCfGrfuc+SbqJQpgmMhfA1gZ5MKK5zC2M0n410v?=
 =?iso-8859-1?Q?mzwpDFPEapBAlLGUZxBOAvuP3KCWm8moobdWNi6ce9JqpPmyX1+ufvDTgf?=
 =?iso-8859-1?Q?dU+vEIOD8SBaYWRwMxgXLfWWkUNfjjs6t211eoxaewil4lUPfXBN+X5nL1?=
 =?iso-8859-1?Q?9/fYl/LD0ozIZwXv4g6/jdGk6gSzknTyRCr5/OgijGSLhVwyhH3f9vKNdw?=
 =?iso-8859-1?Q?iw1a3KC0EUXPv22EIr0hFFe6uqF7bBpsz1AGQlIsyLKuz/wlYQ9TnTOy9Q?=
 =?iso-8859-1?Q?/AK0kVKMOl8+3cHn7LlEvjGcD4VozdTxQa1W3jzg7uzG41nj7heAYU3toD?=
 =?iso-8859-1?Q?d1Cf+1RruH4I6y/cQKzFeKV8FJ9jR/o7n3imipu4+IfwO5ox4GSUX93Ygj?=
 =?iso-8859-1?Q?keFfRw5okzz1kK+aGcmmltn0ZT3luanSUAyvyLyUq5E1WI/QZtM7MdUNQ/?=
 =?iso-8859-1?Q?DA+bkQOVVha3rhwJI9XIFKPqsGW12yALUpe14k7jZld50lPtACgvpYSSoo?=
 =?iso-8859-1?Q?xn3nn+F5PuCIfG8sACTyWD/wGKyU9ZtcllXokZYTCljme/mxP3amcyeKpu?=
 =?iso-8859-1?Q?H4xcihW7MeP3eyJSONWqrz8AzFxWYm28/dHOe3lhqrEn4hTxmSoueuIT1H?=
 =?iso-8859-1?Q?To7CUZfNW8N8qsuJoS23pQTexl/zO05NVopQ8JNTi44O5BDsrie8GxddBe?=
 =?iso-8859-1?Q?WoLG7KsUL3KrakvPth6J8eHvxsyQBMxsrf1NJYypkfaNRDyiGEFpXgSq0b?=
 =?iso-8859-1?Q?efxQo/nwQiNfejSi0tVojeZoQ4BAb9ouAfeQ2v6aXfFHCY6pp/sWKKpI0W?=
 =?iso-8859-1?Q?V9QyWoalCT7yFb/Alm30F9zkWuPe6oHj6RcmOGhRJmXFJeFPQI/i3EzGPx?=
 =?iso-8859-1?Q?grbGcr48gcaUrm3ZG7g4aBnpQU92LCFsoyVDHEoRqpgWaE+57J5ZK6Cf/X?=
 =?iso-8859-1?Q?qOOzm3NdphQndqPq6DmErpp/n4FB6XFWrRIF2yon55rgiOX4c7RJ5Ogo1o?=
 =?iso-8859-1?Q?mhQSbYQrDCrS95sJmPd2YVUD7v6MCyu2d3y9/eOXraFd9sL6+VFeRYDFTF?=
 =?iso-8859-1?Q?sAdyxrm5E2/VgrIILrEVkE02SIJd/ho=3D?=
X-Exchange-RoutingPolicyChecked: JCjNCcAF8Xfq/Hjf9Ohwq+uw4MqvJhXFg7VgtyMlCoxHUxsgZKqnyQCltYOeqxjs8Tw/cvZnAdVkbhE+RxF88irVuiBT61smNTTW10uET5/QST/T8jyZ0HkkjYvH3tbPxE46ztJCoyvdH3bVDtLtoHuS0zhse/nGZZI/JZbZ4rjCfg3Ay2qO6eardnl4/EzVg1xhQUpQIcTpp+n9X0DraqVbg4tlV9NOv5kp6Y8BgYeUCzT6W+QJNnOx28arpOke3xD0sT/gXJHE9FVOL0N6GPDnL0UklubpSjRlTkBl7InI1+dLDxYTZ1HcxNXIamEo3rNlcqrirXQRPO1LGFhHOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 547232b4-3af9-4c83-a2d7-08dec1e4e62c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 02:56:39.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giJ1wIyLU7UZJDFvuA+7IhzvdKosmqmGUJDqHq1jsb/LqqYN6fkvGHL6rJU8DVGQbgawD8O2Z6Q8XFH/A778LmyUEGR7RoCbufNRWdGxAVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
X-OriginatorOrg: intel.com

On Tue, Jun 02, 2026 at 01:40:52PM +0800, Richard Cheng wrote:
> CXL r3.2 §8.2.4.20.12 and §14.13.10 permit committing an HDM decoder
> with size 0. BIOS commits and LOCKs such decoders to burn slots,
> preventing the OS from programming new regions through them, e.g. for a
> Type 3 device in a Trusted Computing Base (TCB) established via the
> Trusted Security Protocol (TSP).
> 
> init_hdm_decoder() rejects these with -ENXIO and aborts port
> enumeration, so "cxl list" shows nothing for the affected port.
> 
> Set port->commit_end before the size check so later contiguous decoders
> pass the out-of-order check, and skip devm_cxl_dpa_reserve() since
> zero-size decoder wouldn't need to reserve DPA ranges.
> 
> The decoder is added to topology normally, LOCK is read from the HW
> control register so "cxl list" reflects the slot's real state.
> 
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog
> 
> v1->v2:
>     - Add zero-size committed decoders to the topology instead of
>       skipping them. Drop v1's -ENOSPC sentinel and the matching
> "continue" in devm_cxl_enumerate_decoders(); fall through so
> add_hdm_decoder() registers the decoder.
>     - Set port->commit_end unconditionally for any committed decoder,
>       not only non-zero-size ones, so subsequent decoders satisfy the
> out-of-order check.
>     - Add an explicit early-return before devm_cxl_dpa_reserve() in the
>       endpoint-decoder path. __cxl_dpa reserve() rejects zero-size
> decoders
>     - Spell out TSP and TCB and cite spec sections in commit message
>     - Reorder series, implementation first
> ---
>  drivers/cxl/core/hdm.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..467ac45bee55 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1031,13 +1031,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			return -ENXIO;
>  		}
>  
> -		if (size == 0) {
> -			dev_warn(&port->dev,
> -				 "decoder%d.%d: Committed with zero size\n",
> -				 port->id, cxld->id);
> -			return -ENXIO;
> -		}
>  		port->commit_end = cxld->id;
> +
> +		if (size == 0)
> +			dev_dbg(&port->dev,
> +				"decoder%d.%d: Committed with zero size\n",
> +				port->id, cxld->id);

I suspect this leads to the poison count mismatch.
Previously every committed endpoint decoder reached
devm_cxl_dpa_reserve(). That meant the highest committed decoder always 
had a dpa_res. poison_by_decoder() depends on that. If it gets skipped
poison in the unmapped DPA 'tail' is not collected.


>  	} else {
>  		if (cxled) {
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -1096,6 +1095,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (!committed)
>  		return 0;
>  
> +	/* Committed zero-size decoder has nothing to reserve in DPA. */
> +	if (size == 0)
> +		return 0;
> +

This is the early return that Sashiko called out. Leave dpa_res NULL
but port->commit_end already is set to this decoders id, cxld->id.
Previously commit_end only marked a 'fully' reserved decoder, now
it is marking this one w dpa_res == NULL. That is different. ???



>  	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
>  	if (remainder) {
>  		dev_err(&port->dev,
> -- 
> 2.43.0
> 
