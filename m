Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7321CC5C
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787266136; cv=fail; b=awyqM+fiu4+ydiwVhLkycKCGxiEoRt1VqZNM5X8fXOe1e4SinB4fTfOv2BU4pRXQQEBSdyS6XJdZBcL3eGXuytg2Ll7h47nZ2Xn+bX3OwhDXcVpanzJvgDS+VImX3VIFIMZYzXpMood0+hJtzvN8JZH2KtMR6Ogn06/+LFwDl+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787266136; c=relaxed/simple;
	bh=8yohVyzmdrlcla1PxGKPlauQbaxkrTi/3uuEEBhlMyI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kDcOlVfaa7yGm2Uug9gw6tAUlzXbzdh+vpsupVIfvnBYOPF5G1zHtHC75uZBYzKY04/dxfSyIUBDueeJF+sHsEAHOgWcHCSgAYvOZ4+cOF+spKCCSkRQ5LPjiLBF3DYbW2LFkUzz7rQq340GYPAPSpx17k4yfsvmIjVhd+VoP7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuR3X40+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuR3X40+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787266134; x=1818802134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8yohVyzmdrlcla1PxGKPlauQbaxkrTi/3uuEEBhlMyI=;
  b=OuR3X40+N70U0tHc6eiZDkR2Q0bDGjt1KdtoMwhhc2/nMAt2SW4uJOx1
   PbH/2EQjGYULdk/AUHDM+18kXYT8IuCg+428u/INGXZRGezAF+KulfDx3
   pxb5NJPI/pv1lEYeBNZ4RLBMIH/2BiIcDPxXT99cE1vho8HT6Qti23k8B
   tSh2NoEgbI39xXk9/n1FBltsGL/ZvXa5DSF1vj73m2H+6kfMXiL8VCeKF
   a8vPIU/YkOf/f7R8DW0kqasXYR5pkImPE6rKXtd25PngUKlZqne35zzEr
   Kybmv5g9KyumI6axfHoH7H15UArjMgC0fcbls8CYf32y8ecfTHeWc1zwr
   A==;
X-CSE-ConnectionGUID: k1Ew9nvvTJmz9edROfQmew==
X-CSE-MsgGUID: WY3jUS/1QcuJhxC7OoJo8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87939329"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87939329"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 15:48:53 -0700
X-CSE-ConnectionGUID: F6/6kOB7S2OnaAZ2ZK6IJQ==
X-CSE-MsgGUID: NYuJ57OtTWeTNIoSGlF1Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="296091546"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 15:48:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 15:48:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 15:48:52 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 15:48:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPzJM4T18mP0fKn2Pu8tcO07E2DE9EZ4tmbYeknWQoP2s5SOLPseD9iWEsa4e4IasaUOzr+c4ZpCsLxK7TnI3KaPI8+ezbFKqrgSt5JOPa4+93qdP1RAdvjYk3oe0z/WtvcLOnXQB5FIcgckuEALw6QsxYbeEEwdYinCnlJY6yicdp/TOc4FgVhJUXwkOcH3B8iSYbY5prCeuqI7S2/E1jZpf9+cyvGwxwWa+Qcjgx7XhVCCK542rn8t3vYl4lkB7SPw84RfuMN+qAcQ/8EEhKsRliFRwAw8G1nXSyXx4clzvvEK5Bl/b0uFBzIF3fgwhcmXsRzWKzVGvAL+UK7csA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJY30gja9vLfolnL4stKa0uU0AKD7GaPrh6g5Ph5l7I=;
 b=NCIntCUm2sKoQ5F1Der6qiU/DBkp3+iC6a6Fde70jX5an4k4jkxL1Fz7TcgQqoI/Zd60ImsHkTvTgveDHDm9w2MGyxtohPFJGW7HjxdcKVkyb5qoPm8f7xRLg+cMvX/ZDY7ze7jaaWGJsfIimdNrqAWJ7K1Kk8rpitwYuSLN3CUO5DaNXoyxFK+skZ5RBiBFIyMJ0pvUR3OrGiZjEohQSqmAdxAat1n0aI/RueKnNkylzO4gwVIWCpzzUGH90kXJtz2nMpyE/j4dwODr9+GSDzwZq+7FTs7fo/ujkvNPrArLfrptuTBKYNMVguxBbJCW2xfm39I2udnnki5gKfs1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SAWPR11MB9572.namprd11.prod.outlook.com (2603:10b6:806:4e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 22:48:49 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 22:48:48 +0000
Date: Thu, 20 Aug 2026 15:48:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 3/9] cxl/region: Derive port granularity from selector
 bits
Message-ID: <aoeETSCOkPjX88l_@aschofie-mobl2.lan>
References: <cover.1785444498.git.alison.schofield@intel.com>
 <efef416440a89a44dfddb13ef390285a98c69cd4.1785444498.git.alison.schofield@intel.com>
 <aoQtZwK7_cvtl4fR@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoQtZwK7_cvtl4fR@rric.localdomain>
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SAWPR11MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b162539-c94d-4771-405c-08deff0d32ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|6133799003|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: wPx7YHM2zyWzfWbcGFyHtdRfhcbY3shffw0G7aGqUK40BbXpS1OskJZgoVWC2Gp3V5Af+psdQ738LEmQod1FImvHVmrTNMO/VJsORayOZjPCVau5w9Mfbhn+Apy45dGQpYhAfQYoXL5xRfKTcv7ESb+EwvWYQFJnLIypNKtmppwnR49La3JsETzFUe4wq0xidFXdnq2c5o9d7JKoRoodA+LTqIAHDWHI7rdLj84kF7VVJlnScMsc9S4UXXsbFfWTKfHLoqZIghUNBBbLXFI3KqB/ZSzExIebi7sHAGVjVT6M+hA+9StWm9n9biTMQS+vyRed15c+02h3Y8jd7FYwx+x0uiRTSzZabUkTiDfyhsCPz8HUX1jBYkww9EeQchHgfHN1XxTDqvmn4X5hmrzag4P4gJH/6/MRqvy8d7DnPZrLt2GH+SKyuPZ5V5jzknbtdDoDYDMiWhr09nCBZjbNjMxLMrIMs3U/i09Z1IhtdRZx+3TXy5uzwtGNa/P0DBMQtzdj7/U3QAc31jClkolVxV2aru+clLGvnsi/8uqy0emsqQORdmEYTW0fxvxU0Laqkgwv8XiAU03ssCLreP+QfzZZ8Yix551FjME7pxWaF4VHRDpK1NOW8UruH8mOjJ8CFkbl8+03a8vQXPI9mRv93l5QwdhpmCMij1cbuY7uqd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RC4DqerQH37e80HCAg7a/X+BzmWgge7UGbTDCau8bQ4CmICdx9w3VJDnsh1t?=
 =?us-ascii?Q?GRMiyub3bP6Y3JjahtQ+0b1aUD5zi8PhmySDrAEyqh7k+XmoS74lP9NwFTyu?=
 =?us-ascii?Q?7eP4T9S5IFk1NAzPCykhyo1neKwi5Fry3gBQvkQgPUQkwrMpQ0SzBNSBcyjF?=
 =?us-ascii?Q?mcnLP0WFQlQ1Bi73SAMtLVHVOGHHdq7lws9Qe/o6EAlFNFHXztTPjMSV4LN5?=
 =?us-ascii?Q?My6WBcFB5BGd6E8fN9qWvvJYXFgJYozFu4YeRxc62UU/MJhTGCsgqi6OI9YW?=
 =?us-ascii?Q?cJjMQeYKNvkeBN5wpIiMlpGfEASwY4+tzcvUWfOgCGTID5vgrtd7SfPbPVKw?=
 =?us-ascii?Q?pEUKVSGYCRDoUkRr5PxTsPKmWPMTbMpVieCGrYG4k/E7bWEsyrjFYBGEthwk?=
 =?us-ascii?Q?iA1KaL3YYln2y4or84OEDgD6BaO8CDnbXdx+cbU6hbkbdqhGDAHzGFkB+oIo?=
 =?us-ascii?Q?+8cyOsSf7OoEq0vtInzBib6gDOnnbaL4GKT0VJ/f3Z2hQ9UedKGmvoHZS4Xx?=
 =?us-ascii?Q?dw+hrCB5hNzmGbXy7tslmxuQAT2ehPT+Iv3ZjNgvUpBdOPvKuLix2urlN/9F?=
 =?us-ascii?Q?H9XCC46oZ5A1VxqNnpxvIboQUOiut8CKOs+1PeucFU0isN3Bogi37hargVKS?=
 =?us-ascii?Q?xgmK5IXbyDDW8kMOStWJan/r8mwj45EiSMOsrnXdKFPGv/xv7HSy0FSFJXWg?=
 =?us-ascii?Q?Iu/fRvjhK+0F/cJp8K7YVRfLW65ct85PCuxLHk17rR+S2CuDeGsfo6aKLrNZ?=
 =?us-ascii?Q?FA1PHRYOxLq+o6xAWlnR24sumJT+MFeby441icfa2b+lAW1bBOI+aN7rCmlO?=
 =?us-ascii?Q?RSdYfD8XhOsjvYGShY+RCaGBcqOHGiYCtQxARWljZ92tC8A6VUGIwpNWXi8Y?=
 =?us-ascii?Q?btnp/054wMCTcMDaz5mRyiCfu0ZWo6eLX4KVBTX1yLuy2zebapKS8A1nbBbB?=
 =?us-ascii?Q?pC5311oaL+L5YtcpZfnC/VDYKwCzY6kpZC0drh0Vw+CHuQwcdPm8U7ZHQSGy?=
 =?us-ascii?Q?QbgneayyHRKhd1nfbTX9LOCwuzPJ/qwlyKztMKM7ptT3/vvqXV9OCiODV84h?=
 =?us-ascii?Q?ObvIn3aFgY6NwG52NBDMTT2pLGmY23CXNGg3CdsbR0/gheUW5kz0NXYgqEy7?=
 =?us-ascii?Q?ZPb8rO9LKNnVAeociCfxSZSk+3eWAIJMfysZOo4g9r3HkcZGLH4VwPlx4OB2?=
 =?us-ascii?Q?IlzXirFf5IPGBYS7HadZadMUX5p2Qq1TjXMHIj5tZdtWBj8v4JA9/mdVnbHK?=
 =?us-ascii?Q?zdIzKUeK2NogvusbUUsbnVCdg8OsoRRxKpE26TbX1nFvZm/CWo9n3Kikhitl?=
 =?us-ascii?Q?plRMD7cREpfh1BNapkI7iMysYZy1Sg8tHFH4+NGg5gs327qOHcSwLx6Z/nF5?=
 =?us-ascii?Q?XzZ67i0ndQgGeW7eN24Y3w7s89TTD2aceHSRBFsyyIdCmV+4mSvhsL8UaiFO?=
 =?us-ascii?Q?cJxLok69QMBH86nihQGMc0cizrEEISYQPa6n65rdMsF+QPTVD6thyI9+Twyv?=
 =?us-ascii?Q?a+AGRGwSLq2ts0xjzx9GuhTUiRdjkG6FHyto0tJKT5078VntWLJMSuiKIPOR?=
 =?us-ascii?Q?k2L7zVWMVQUH5I+tSqG5jEaeSL5DsDrrPmDFs7EnVM4wgOjtNqFbjll4XjJw?=
 =?us-ascii?Q?DcwV6X4tmBeemTjq8UXXzSG2RkbtRcmLjktwrVCvBR+zoiN4WaTUzeVZ+bVB?=
 =?us-ascii?Q?LSE3gtscofVJ0GGbq5C6uF+8M+fond+7/wNWkvmGF9rliOegUcft+gT6iiiG?=
 =?us-ascii?Q?qgR+wdG3ARMoCOIy3UiA9EyW0wuqIM0=3D?=
X-Exchange-RoutingPolicyChecked: qq6h+2yojTTyL9OEYLI1W18evpsp3NWzVqmXfm/XFl1f8Ar8wkyeVMYcNVksiL8/LddIgL4ZzlC0qTtvzObvDqr3iSB0YcRcuC5hdrIUXAU0VlaSD3IqNgwwJPDE5hhXkXFmhYRph+bcDbBT4uzjXGIxAlC/sflvOHzhlhCthly7tbMoU+e3kv4lqSwoStvyjcoYe7AnD8gLA0v17QiGyD7eSUgp2PZWojpB0Kn29izt8jLtIm1CD2G5uD9yIM1gwLVFdJaE22GNAMeT0+sbIGcEoqsf9CJrL7AF74uq6TsmcpDB3mHb4LFPe882rgxsguQGEMGmAWhOFy3yWrrjng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b162539-c94d-4771-405c-08deff0d32ca
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 22:48:48.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: og/LON5+SzLW/s/xGrB0Jsd55B36gW/EOcy2aNEDiEyV7m12nJi2qCG2KJ+Tsl7etGzuSIl8Fv83epMZAlGmSathaVYO0TxfHs1CAgVCzTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9572
X-OriginatorOrg: intel.com

On Tue, Aug 18, 2026 at 12:01:11PM +0200, Robert Richter wrote:
> On 30.07.26 15:20:23, Alison Schofield wrote:
> > A user-created region currently derives each port decoder granularity
> > from the parent granularity and ways. That recurrence assumes the
> > selector bits follow the existing same-granularity ordering and cannot
> > derive the decoder settings for a mixed-granularity region.
> > 
> > Add cxl_region_is_mixed_gran() as the common predicate for regions
> > whose granularity is finer than an interleaving root decoder.
> > 
> > Update derive_port_granularity() to choose each port decoder's
> > granularity from the selector bits not already used by its ancestors.
> > For auto regions, compare the firmware-programmed granularity with the
> > derived value and reject a mismatch.
> 
> The only requirement I see here is that firmware programmed selector
> bits must be within the endpoint's bit mask (which matches the
> region's total ways and gran configuration). The selector and
> granularity of a single decoder within the chain may vary, as long as
> it is within the total selector and does not overlap with other
> decoders. It is not possible to calculate a single correct granularity
> value for auto-mode. And in user-mode there are muliple setups and
> values possible too, unless there are strict assignment rules given
> that only allow a single subset.
> 

Thanks for the review Robert,

I agree with the general point that the CXL Specification permits
multiple selector/granularity arrangements, so there is not one
universally correct decoder granularity across all legal layouts.

v4 makes the support restriction explicit instead of trying to model
all of those layouts. Linux supports only monotonic coarse-to-fine
mixed-granularity configurations. Within that subset, the parent
interleave geometry and the decoder target count determine the child
granularity, so the auto path can validate firmware against that
supported geometry.

The 3-, 6-, and 12-way configurations also need the mod3 contribution
accounted for as part of that geometry, rather than treating the whole
problem as power-of-two selector placement.


> > 
> > Originally-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 90 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 79 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index b0061f03892a..871dedd37cc8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1552,32 +1552,94 @@ static bool region_selectors_fit(struct cxl_port *port,
> >  	return true;
> >  }
> >  
> > +/**
> > + * cxl_region_is_mixed_gran() - Test for a mixed-granularity region
> > + * @cxlr: region
> > + *
> > + * A region is mixed-granularity when an interleaving root decoder uses a
> > + * larger granularity than the region.
> > + *
> > + * Return: true for a mixed-granularity region.
> > + */
> > +static inline bool cxl_region_is_mixed_gran(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
> > +
> > +	return cxld->interleave_ways > 1 &&
> > +	       cxld->interleave_granularity > cxlr->params.interleave_granularity;
> > +}
> > +
> >  /**
> >   * derive_port_granularity() - Calculate the granularity for a port decoder
> > + * @port: port being configured
> >   * @cxlr: region under construction
> > + * @accum: selectors used by the ancestor decoders
> >   * @fanout: product of the ancestor switch ways
> > - * @ig: filled with the port decoder granularity
> > + * @iw: port decoder interleave ways
> > + * @ig: filled with the derived granularity
> >   *
> > - * Preserve the existing parent-granularity times parent-ways recurrence in
> > - * terms of the region granularity and the fan-out above this port.
> > + * Select the decoder granularity from the region selector bits not already
> > + * used by its ancestors. Same-granularity regions allocate the lowest
> > + * available selector bits first. Mixed-granularity regions allocate the
> > + * highest available selector bits first so decoder granularities decrease
> > + * from the root toward the endpoints.
> >   *
> > - * Return: 0 on success.
> > + * A passthrough decoder uses no selector bits and retains the granularity
> > + * implied by the ancestor fan-out.
> > + *
> > + * Return: 0 on success, -ENXIO when no valid selector remains.
> >   */
> > -static int derive_port_granularity(struct cxl_region *cxlr, int fanout,
> > -				   int *ig)
> > +static int derive_port_granularity(struct cxl_port *port,
> > +				   struct cxl_region *cxlr, u64 accum,
> > +				   int fanout, int iw, int *ig)
> 
> This function interface gets really out of control now. You need 5
> args to calc the granularity and return 2 values? Something is wrong
> here.
> 
> I guess we need to change the approach here. Maybe split target setup
> for auto- and user-mode. We must simplify the code, I think that is
> possible.
> 
> Will take a look.


Agreed. This comment, along with the broader complexity concern you
raised in the collab, stopped me from trying to simplify the v3 helper
structure and rework the series from the existing region setup flow.

v4 drops derive_port_granularity(), the selector accumulation, and the
fanout state entirely. The target setup stays shared between auto and
user regions, but the local decoder geometry is now derived directly
from the parent granularity and target count.

The target setup stays shared between auto and user regions

> 
> -Robert
> 
snip
