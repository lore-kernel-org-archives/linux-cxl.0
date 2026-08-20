Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052C31E830
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264083; cv=fail; b=cJq7SrW0e0VqaB+oEd602BN98cZy/j0DqX4hUoVaiF4Wx0orIQ9hqiJc32MatL8nDjz84EHzUq2yxtE+DD/8bgb15u7XNnlGasCHfATbBEHhfnKpMC3gdAoeiwSMrUJV6XyYj47Nbo3wSFS9XJWbsAnMKmiCXCXOp4Kko85/pF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264083; c=relaxed/simple;
	bh=n2Em9Rst8ifnFxFET7E74zSBnnvnO1Rz5L+mCIalKWs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iM6HDGQVZZ0eDRSm+QsL0KobIvfF/lzY/ReH7o8Hx7R9ARhiyOr+Ve44yHjIfxPr3EzOKZExXqwVd1I84mABZdWljepNqtERsKUkuYMEXzIdyoYasBipFno0SF7R4Yz5PyOF70WvcvbfK/CAW5IKoWaXllGdKrEcj8faqioc1tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1HjvyzD; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1HjvyzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787264082; x=1818800082;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n2Em9Rst8ifnFxFET7E74zSBnnvnO1Rz5L+mCIalKWs=;
  b=D1HjvyzD6FzWPPNsMCzUn2mKY+zaTqQSxxcuYhsin5vfsPQd4hcsv5fK
   11RzxDQEIi0GQcBBvlCbQ0CREvckt/DSnMKPSPQdDcP7xXptRPjruj4Dn
   QDBp0qaRu3OTONX4j7TMiCpF+V7lBVlS1rSsHEnxXvSdMHy00cQ8RH3ow
   cH3oCdhnbIPHXjN6+850rh0S9016GXCyIDmzwQHbWMUU3V5WXA3qYxS5e
   JJd1vF+7UETi2Pl3lufE/v08M+k2s1w6p3ndavNzwWwLE6pqfUVxV5Mt5
   xjiYXiMRnYgKVWoGy5Wt2wrHBOeyqeXsrH63DPpzjsX0U4sNEwxzk/W8i
   A==;
X-CSE-ConnectionGUID: Jd+d6ANKQFmYsK8C9vH0Bg==
X-CSE-MsgGUID: AmNWK0nJRLezILs7zPV+JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="86760254"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="86760254"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 15:14:42 -0700
X-CSE-ConnectionGUID: 7HOyEOVyTT+3CWkpLjB4Nw==
X-CSE-MsgGUID: AlY0elsRQg6ob4f3KFVpag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="271378353"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 15:14:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 15:14:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 15:14:40 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 15:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDg5eHGG4iApWBpoCn4yyyaufqmKjla/Te4V5d0Wa5op2ASIiXvS/6AtTDJORRKKu+F1iaDFma63NwLnrBEplRUrdAY3sDTaighoUw9CW9ScDUsN8trQYoPAN1ueiH6lEb6GNRJhesY9fek/RujRNoDligcWDVWpzy87Z6MLdRokvcLgC3OIRuK0D/NrLfpsmMhipdAmmF83mNTnZB2C3TZzmvdW5Vzi9PbscuHrzLE/MfCOSClDbx43KBD++2feBAWRr0qyFEHVg/xGuN80Zf+lJ6yfmODLpuKbH8qoDcgYIrKYRRZu+SEaDKa/xay5ChHRFyWSnkwtpxc9eC8yPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a7DI8n9MlaOCnd4qZnR8WTIosY8qk2WYAfk+2ZSk+c=;
 b=xI51F4B06CARCl7FVqd2HNBq0qg55ODPwLMclRCttybJ3X0W4YHnPNze5OJb4rWGD1BfCSq0TEzJmzuFxollfWpjTMQD8pmQSgtpesE/gBNYTIDwZIHTE+HKnRVo3369SoEuA8Y/Rhgo89Rp5IIJPxMn6E92wE6hWChmlwy6c1IY6iky7MMlgLOIxc011zcN05adDk2Pb/FknWKy4nVqcAfdluOlMydjS0p0w3u3fg234bk0aIWKHdWqKE7kiuG8OElUjfDnRm6gKbr2GVMqg2zShJc70Mq2t4w67RW/ZohlsCrIMBkwMJfYRESPuq42Yg+9mQJlrVDs9zudLpiBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 22:14:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 22:14:37 +0000
Date: Thu, 20 Aug 2026 15:14:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] cxl/region: Validate interleave selector bits
Message-ID: <aod8RoI1gJoKkrry@aschofie-mobl2.lan>
References: <cover.1785444498.git.alison.schofield@intel.com>
 <67cfafacefffabb7db34f9d261ba47c0edc7dc67.1785444498.git.alison.schofield@intel.com>
 <aoQiLpojRvgfZA7I@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoQiLpojRvgfZA7I@rric.localdomain>
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c53ae8-f108-4d1c-70e4-08deff086c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5xDveatiDOtNWskjw76IzwPQnBULkfjbnJoaByLhLu++KTm0HR7S0ga+0h/Xxffs4Q7hh+V2qIVau5Vz6NN/TBzdZ3bkkeV6zZ47IHYGzzxGvogRHfj4wKjqpy8+/fPHyCEIilAn622CtTJZOQ9KWCGIQ/MODbcO4lKpBLJGYSBJRUVWYvE+NTEoMJVOj+n+PiJz+aHYCUqygG3ZgZLC1qA0PZctArBpEbsrrA6vN0CVyNjMmfoZwGJIeNnHXoYAGv5fVTny3A/OtO179LIpFj7SCrvH2u7THaZc/I1rj94q//1ERtrBesOX/mZ4kiKIoUbuJSuF3w8T1h5VH2MwYUzNSnyRLwNUKpExeOMn5HvgJCYCIxQaIcW8UeI/R11HXbkCQReo8yV0Rkcve5udsK2BzgQpFzElhiC/ihwfVM2VbOQsRL47bbcmdHcF78zugVAd+fAqJ8BiwjBkutBvAsEPfEX86PGRCbqpXM+FbPLvtDfLvQB+xWVDFnY9lxVD5u/gtlhsfIX7JqWlB1xTYk4aazX+WZwZQptACM+GpSI1j31d0OdfLbApfK8i2RWC4fZ3KSMPPVUBqVGg+EyNciuz58drfGn6g1JzVXO/WNhOUk1lNyHZWQRPfJw3la9taI1XVZQC/4EzNUtTpplqZR5V7eITMkMz7BgFaZlFKas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDMy9Ipl97DtwCqZ4XA9pWF1/Z1OqGGyvQtyYtcKJl4vd57+W35J2wH3AQWF?=
 =?us-ascii?Q?T30ZvkNAErUHtBLwK4mDx44tgQnOs8I5Uf3jHygE1+Ask+WYwic+Vi1CE383?=
 =?us-ascii?Q?ZLABH8GvXRde7kxn8tXSQYDr1Ofdb3KEV9C6RaGV8PYDtX5aEoU/7HaWp9PG?=
 =?us-ascii?Q?65q6iz262LC+KPjsqQyL3CEbACK4OV+ehj2S4+9hD0KtngjraXVPnfFsa4U/?=
 =?us-ascii?Q?jLD2+Q2Y6s5K1n6Y6q99LmbTCTtz/On13aU0dHoT/+X+D30M2/VJQfB0srUt?=
 =?us-ascii?Q?uNB1HMKtm2jk1hG+/vS8TBt7rxwZvK5qgF3BhSXq3YCbr9u8x1kXjG8Len1g?=
 =?us-ascii?Q?LFSvCMyPUFt2A4Q+8nL/PRaM+eZTE7fWpUSjTF0ihq1nwLup2bYWIUyC4To0?=
 =?us-ascii?Q?58ECoatB8lmv7rfghrMLSld5UwQ/0oqJy+GwESwbUP9in55WDwk6lwWLQrKJ?=
 =?us-ascii?Q?PfJAuKZ4MD4Mq8lK0T2gL6KHbKPFIFS2d99OF3UWeJ9dfHgDJWPmFOtZoEOY?=
 =?us-ascii?Q?stpmTLvsc3iF15IcyW/GiHzYMw9TGdRuZCCv6DwYQgA7RZmobqryu4eA+mYe?=
 =?us-ascii?Q?9HLtgK8e/EDZGYFsYY0vhxcVuuxBqnCOlrwPLcXJ8ODEkI0xyTvuN+nOx3DD?=
 =?us-ascii?Q?TKxotMj0HEZ4HBY/LxwWWRKOJpJjTrSaBqxYDOJHX9x7z/O9xHJcgqr3PoYk?=
 =?us-ascii?Q?90kj290Dct3v+yyJdieD+clcXiA3Lf1Msm+HRsO12922QSvaufVHJGbJK8JY?=
 =?us-ascii?Q?69aDLNnKYx4WC/Bn25sm8MpbxUpCflyCnGoVbBCVH4NC+J9nQlwIVg/Pe4NF?=
 =?us-ascii?Q?9WFdnLbKWyyx/RDL3XukFmJMFUzcHWQDLQc995lrEwF6u8Qo7XFF+DfyKyja?=
 =?us-ascii?Q?ktgMje0lHjwYY6bImFMrqReY6nfjVkKg/FRdXn4P/xQiUJ/tE14cgy/l2gmk?=
 =?us-ascii?Q?unnxoIXUtVm3CxIvSdJ1myR27wFKBEN5c7/AQvJAtIlLakzr/G07LaW67ezY?=
 =?us-ascii?Q?0ajzICV5TRcJ8lN3IZRDjoMOXWQo4MhD8OxsH8+rxQQlB2WuflsaZhgAttM1?=
 =?us-ascii?Q?gy53BosxSLFwXc+DT/cWoWYVR6ChJs46wDzevI1U7sOsba7EYsgrtzpkRv79?=
 =?us-ascii?Q?n+c6D8oHhbAZbswtVoGj0WlshVvLabvpmSowK2twoet9gpg93NmyUODwZSPs?=
 =?us-ascii?Q?igvOjym1ou/xkJB76QBAXgshjkWjMyldlpEByqJkq3d3Q/cMrogvISF9byLo?=
 =?us-ascii?Q?kVrEyhRdaLpX19+u9oftTGulQizRp2ofvSoxCB3SKx2kCG9NSMPDBRv4TgpH?=
 =?us-ascii?Q?ZyZI+oBEcZo5VuJYGi8Ka9Qswmw2G8nihsURnILjkWTearcihcJ17pkn3MgO?=
 =?us-ascii?Q?87avZkUlLCDXh5KzNXRTG1vmYyVnxwjXp8nfyyCbkQJUhkRd7RAdGdaGziyo?=
 =?us-ascii?Q?tMwbELvl8f0XI02kdXnumaG9eGRWQHmH8xYA64vdN0oc90Oup676Dk2S5Hlc?=
 =?us-ascii?Q?0rv1gTkXT8g8Ua3A1S0PH2Y1dHzrX3DjS2CgbKGZgiUcEaMCQjhw01IhxwY5?=
 =?us-ascii?Q?awYtMJCc1MQzC0K1Y/434UEaaQ6h0t0x7x7LNUptQ+KhHRuDAO9bpXAsew0r?=
 =?us-ascii?Q?kbzlQmMywn2Doz9M6JjxDIr2CgMHGMm891l5yD93FpxW7hY/dqPfyR8loiLt?=
 =?us-ascii?Q?D06g36wxv1l53qeiGggOjLNZKXelW15J5zlHa9UXM4r1xJlEjlI4phHMKH/9?=
 =?us-ascii?Q?9oka0WeSiaxPkYY6Xwl762d3iSGVtTM=3D?=
X-Exchange-RoutingPolicyChecked: iJTa17C7r+zlmkEmbw48Zdf+CSUqWdOIdj93u92bgfD5Yb1TRT9E+m5k3KL2GbLAjah8LNR8CnNEa4YGIZY3cLrqVb7BlmUawSCE2ZurUNJglc7oS7jVJOPvDeWGYZJIrT3k3qOziqDmbPwZqXXeCFwGN2mOSLPMErooBTPoHNZKrxOYkAGGu0yxVMJpAroKVMdR/nIEW1FXlV/oEu/EtD/d0q8wfCKuqCfiUFfcecn2zwQf1Ptv816n0dDU3rVRUYeXUq6vYqadHKZXFbdmr4buVr/+P6fuKRD2EHFTESGRIrX7a4CigdIAQhoY3h2cnvx2X4NV9zj1Cskz1zj4CQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c53ae8-f108-4d1c-70e4-08deff086c1d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 22:14:37.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIwQX2MVxcyMNGmWAXkSzxHPQ5uAsZI3apO8yeBxv9erO1zee2h880nFJbFO6zmpOAZw7NMuQlRGixNNY5DcQhBiF2ega91lrOXPXXANV7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com

On Tue, Aug 18, 2026 at 11:13:18AM +0200, Robert Richter wrote:
> On 30.07.26 15:20:22, Alison Schofield wrote:
> > Each decoder level in an interleave uses a field of host physical
> > address (HPA) bits, called a selector, to choose which of its
> > downstream targets a given address routes to. In a multi-level
> > interleave the selectors of the root, the switches, and the endpoints
> > must occupy distinct address bits so that every level makes an
> > independent routing decision.
> > 
> > The existing setup does not check the selectors directly. It instead
> > requires each level's granularity to equal the parent granularity
> > multiplied by the parent ways, which only holds for a subset of the
> > legal selector layouts. Layouts that place non-overlapping selectors
> > in a different order, as mixed-granularity regions do, are rejected
> > even though they are valid.
> > 
> > Add selector-bit accounting to cxl_port_setup_targets(). Accumulate
> > the selector of each level from the root toward the current port,
> > reject any selector that overlaps a bit already claimed by another
> > level, and reject an accumulated selector that does not fit within
> > the region selector. The root decoder's selector is walked alongside
> > the switch levels rather than tracked separately.
> > 
> > This patch adds selector validation but does not yet enable the
> > mixed-granularity layouts. A temporary gate rejects region granularity
> > finer than the root granularity until the position arithmetic is
> > updated.

Thanks for the review Robert,
I took the simplification comments here more broadly in v4. The selector
accumulation, fanout tracking, and the associated single-use helpers are
all gone. Port decoder setup now derives the needed geometry directly from
the parent granularity and target count.

Replies to the individual comments below.


snip

> > +/**
> > + * get_parent_selectors() - Collect selectors and fan-out above a port
> >   * @parent_port: first ancestor port
> >   * @cxlr: region under construction
> > + * @cxlrd: region root decoder
> > + * @accum: filled with the selectors claimed by the ancestors
> >   * @fanout: filled with the product of the ancestor switch ways
> >   *
> > - * Walk from @parent_port to the root and multiply the interleave ways of
> > - * each switch decoder. Root decoder ways are not included.
> > + * Start with the root decoder selector and walk the ancestor switch
> > + * decoders. Reject selectors that overlap. Passthrough decoders contribute
> > + * neither selector bits nor fan-out.
> >   *
> > - * Return: 0 on success.
> > + * Root decoder ways are not included in @fanout.
> > + *
> > + * Return: 0 on success, -ENXIO on selector overlap.
> >   */
> 
> See my comment on comments in the previous patch. It should not be
> documented.


Agreed. This helper and its kernel-doc are gone in v4.

snip
> > +/**
> > + * region_selectors_fit() - Check ancestor selectors against the region
> > + * @port: port being configured
> > + * @cxlr: region under construction
> > + * @accum: selectors used by the ancestor decoders
> > + *
> > + * Return: true when every accumulated selector bit is present in the region
> > + * selector.
> > + */
> > +static bool region_selectors_fit(struct cxl_port *port,
> > +				 struct cxl_region *cxlr, u64 accum)
> 
> Better have this inline in the code, this functions does not help
> much.

This helper is gone in v4. The selector-fit validation it was wrapping
is gone as well with the selector-walk approach.

snip

> > @@ -1517,6 +1594,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	int ig, iw = cxl_rr->nr_targets;
> >  	int fanout, rc;
> >  	int pos = cxled->pos;
> > +	u64 accum;
> 
> rename: "total_sel", "parent_sel", ...?

Agree that accum was not very descriptive. The accumulated selector
state is gone in v4, so the variable disappears with it.


> 
> >  	u16 eig;
> >  	u8 eiw;
> >  
> > @@ -1538,10 +1616,13 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		return -ENXIO;
> >  	}
> >  
> > -	rc = get_parent_fanout(parent_port, cxlr, &fanout);
> > +	rc = get_parent_selectors(parent_port, cxlr, cxlrd, &accum, &fanout);
> 
> An easy and straight for loop could be a good alternative.

Yes. This was another sign that the helper structure was getting in the
way. v4 drops this ancestor selector walk entirely rather than moving it
back inline.


> 
> fanout can be dropped from the function interface. Weight of the
> selector can be used instead.
> 

The fanout state is gone in v4, along with the selector accumulation.
I did not replace it with selector weight, though. The v4 approach
derives each decoder's granularity directly from its parent granularity
and target count, which also accounts for the mod3 configurations.


> >  	if (rc)
> >  		return rc;
> >  
> > +	if (!region_selectors_fit(port, cxlr, accum))
> > +		return -ENXIO;
> > +
> 
> Without a helper it is actually better readable:
> 
> 	cxlr_sel = ...;
> 	total_sel = ...;
> 
> 	if ((cxlr_sel & total_sel) != total_sel) {
> 		...
> 
> So, only use helpers if really needed. And, assign values directly.


Agreed on the larger point. v4 removes these single-use helpers and the
intermediate selector state rather than trying to reorganize them. The
target setup is now much closer to the original flow.


> 
> >  	if (cxl_rr->nr_targets_set) {
> >  		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> >  			if (ep->dport == cxlsd->target[i]) {
> > @@ -2087,6 +2168,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > +	/*
> > +	 * Mixed-granularity position calculation is added by the next patch.
> > +	 * Reject it until then so this intermediate state remains bisectable.
> > +	 */
> > +	if (cxlrd->cxlsd.cxld.interleave_granularity >
> > +	    p->interleave_granularity)
> > +		return -ENXIO;
> > +
> 
> That change did not remove anything that would make existing code
> break, right? It just adds selector calculation. I don't see a need
> for this additional check.

The check was needed to keep this intermediate commit bisectable.
This patch relaxes validation enough that mixed-granularity attach can
proceed before the position calculation supports it.

The v4 set avoids that intermediate state, so the gate is no longer
needed.

> 
> -Robert
> 
> >  	if (p->nr_targets >= p->interleave_ways) {
> >  		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
> >  			p->nr_targets);
> > -- 
> > 2.37.3
> > 
> 
