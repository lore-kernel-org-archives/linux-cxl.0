Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF283171CD
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631151; cv=fail; b=lDVSBNzjA/9vHWGzZUGF696/Xh1dx2jZIZxBbcvLxONsn3RklX1ahbljpZTOUeA35QsumzlgOAPnnS5I0FpzbQ2AfxG69f632TfXuI4zkIUVCGp79YuoWry4eR7KDgAOEHbsvK9qnPyRR0b6d5EY0eAwwVT8nW6ZkAZqluTSJ0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631151; c=relaxed/simple;
	bh=F0D/BdclVqeT527YVYuLOR63D0Y+OTlzfXQgk/Y0wuQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oh9WzEQkdMpK++PKVVUVlq88hvB1WRbgJgRN9rC+OiiDaBJesmCiUlfjGB3ZV9eFQBAqThCSKElGNDsgaTMJvcISIRs40tkYiqXfhsRKTI75ZIdKIzp2VlXGVUIO0qU+SOQVUpM83Pf6leR0vmsxUpK5Y0/MtYqaYPlTAYbAJig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6/WyUc2; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6/WyUc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631150; x=1784167150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F0D/BdclVqeT527YVYuLOR63D0Y+OTlzfXQgk/Y0wuQ=;
  b=V6/WyUc2hkkC6sOT0bWuHN04jbkmYZEhddqngW0/MpGEjuIcyuRAaS8d
   fiTbQKDVjDd5NQaX6NB2GOkvO4dXP6S/Vdk3VC4u9SG2NifqkBFr14veK
   KC2l1ZCGnQUGcW6DbljStVoz71bEjAnrxG557jAa/KFHo/4H6IfmtBXRi
   O7u71O2u3Nzj2oiJG3t/6bFxfMfco3BbpQCrtLb6lC5F97CuBH/ETgoxr
   DvkqswG6K+KRw5Y4Ja+29Wc3P2sn35SJMm+gm0q5t4DhusGOdD2kOLX8R
   QxahTNmTfLG6nj0o6thMOnjD1wCCtPJ6WetqZ2L1FLLoq56t6vbgihfxk
   g==;
X-CSE-ConnectionGUID: /zNGtLtMQwSdkRgawDDGVQ==
X-CSE-MsgGUID: DoYLNx2/SoiavIJp1Ge4qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65435865"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="65435865"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 18:59:10 -0700
X-CSE-ConnectionGUID: 6U/3dIGXQBu8Ee8t5VsIQg==
X-CSE-MsgGUID: nU9OLKyNQXOpuVofX12HAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161684341"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 18:59:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 18:59:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 18:59:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 18:59:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0Vt+FRWAsKTNlRbZ5YMRF6YMpz8EF1IedQQ3YSCbIGHH0LVHAxb0dnMTJLhsjudJX+v6GZ4sebD5IK3FX1kHFo8QimJRthqqAxQavvvzZxfO0ExW1t0m9Jdfk00Lj9CF8UPk5d5raVqE3T8zN9fWNEralrCdnzgvQWBlRe22kjVoSDdp5mQQkXLicN8FDovENBUtqMap27UjWCPQcdAm8kLaoI/bURF/u3ldULF7esKxjNOQV2vATwxO+IAp4I7vT6HS562izuA+QvxTG15mEqQr9Yvi33VIiAQ1NiwCN2tJA1IxCJYkPfzGATP24rvtSWybecj/+Az5de7ncknlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GiBfxPaUL3gbsn8JTL9BIemyw2WkGT0HX9VCulztTw=;
 b=onfT6XGH4zvGn72cnPYVvXEK4DqjSHnge51WCO/yf7KsqNSz4MdvIhE5TlFhGdpyI3uUzX5LKl2/rPhYtZN9sLKUtKrJPpgyiNg7lUjFh8hvRKoICaF2DJZmOif8v3NsQS4k2KShcuvibW4qh/JW5bPeJWIjmpqbpp29ZESHVqEmZQO03xGu9NTEiGD+Qr+nX2w/QueQZdEKtHtEaYl5jgtcoR+NatPpJlSTgcBx2Y2ApaZv59gPX5C4AHxceJFXLvmGaej0Zv8+PDbisNfRmsYETW8vJSrc6MPQtQjhy2wlnSqRKI60HsoQz5uYAJ1DChlJecHqdSTeM946EzpfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN0PR11MB6205.namprd11.prod.outlook.com (2603:10b6:208:3c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 01:59:05 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 01:59:05 +0000
Date: Tue, 15 Jul 2025 18:59:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v7 03/10] cxl: Add helper to reap dport
Message-ID: <aHcHZe_RAvEtv4ut@aschofie-mobl2.lan>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-4-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN0PR11MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e08585f-e291-485b-ecee-08ddc40c5811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hWTwD+AgMzGp5PDo+z3Q9Kmlcg0oNTDd1aeDs90ORWEl5rPbH9568bVqMgex?=
 =?us-ascii?Q?fvTM2h+bkGB/egwvV32trZ2r+0Ri8NQjpPKqt5ElAkwLycbs97jFGYYzGapg?=
 =?us-ascii?Q?sTMmrXh6sMIJ20CiqBk9sJHOYG83fA7ZkY3ApQ+YmmPDrfjwJVT2ePjUbeZV?=
 =?us-ascii?Q?ugGcJeaWRhMAOUhDXtYDMmDE32hUvEkNYLnf0XyeivZ8z2Ybp0iIyUt/qHie?=
 =?us-ascii?Q?HGCVdF383e6umuBVj9BQitR8KMS5/WjSXkAorE9TcvDoY/Ep5QE9vjOWmvWx?=
 =?us-ascii?Q?roASHbbdS9eRjUFtt6VUM1su+gcLeKEJguInQhe3lx1LjmheXb3NmgXvVqwf?=
 =?us-ascii?Q?3qhy2M8YMgdms0GkUDmbyRKpvLlP41UnBa/6UDPZ2/VjMZStY30MXXS30MfO?=
 =?us-ascii?Q?/bCLh0vOWWMTvRriRa3XLOyE1lDgh422tyYKPCpOu91+4a63XZqD/AR7Cxv6?=
 =?us-ascii?Q?rC6R7nHpc0SIsyLvXWKW33gEiCSWX8jDodHDiXYIJ2Nm0MuIvVf+bX+0q7GS?=
 =?us-ascii?Q?Ah6GylhOFC1b2X5IRtLonHRbBffvOQmg5JZteWUpxfqt56xkTuIv02L6XvDJ?=
 =?us-ascii?Q?Yb7PFnswYH4/gyzveSEl4AVGxBXhCXJZHfeElcd21XGNwtVpyIkVmKX025pI?=
 =?us-ascii?Q?5cao9+I6TbdxN4MkGVmS3oOmCZH38WTlfCXlGOySMqAehTE8jTjMMiVsXQx1?=
 =?us-ascii?Q?GKXdSetIDFvPhFW06Iw+meNbED6oTcjhNhHDV7TwnwffNfO2gcXuHSIeptvy?=
 =?us-ascii?Q?xX0iple05JqhXwQMdnFJudtlcnEnY0s1+UDOFxQfvZrAaRUQHEBEA6Xe2eK2?=
 =?us-ascii?Q?2ynwmJFdMzIVTbPy0nMg+N6nXADKAAQWXFIaw7cSFOaI0E1twH2TswSnDMEs?=
 =?us-ascii?Q?xqrO27jDKBhLvvCTobP9uvURWuDb5Zz/pDiwPLDVLnwWMT+OXXjhC5UDf9b3?=
 =?us-ascii?Q?YGi7dzec7hqYZrYUxpqLihS/DKk9joA734dIa64PFcJbrCxIAPOXmux9X9Xc?=
 =?us-ascii?Q?xw9oTLLQLjEXCnqbgnZlT3bx36oxzNvOYaBl5ga3wd/1wz5C6r5anXIRTqE7?=
 =?us-ascii?Q?LMMagKDcA234bwf5Y+nXcCOP1MaLqfhvR4PYETGzKRCBmHIyQgg0DkZQUE/X?=
 =?us-ascii?Q?XYWIhQIwCXZGtUbWVri0XRRnveP6RPtk1D3XGGwT3vGpadlSVfhd0eIveqkX?=
 =?us-ascii?Q?fuPO/e8iRu7jt1bA52fmxT0Gga2/xttVoI8AFWw07HnWAV9okjHkr963Sekk?=
 =?us-ascii?Q?2eTvrtwzl79vCN5jEqhYbDIrW3uFRdlhaee35QtTnRoIYpxwn+7LX+ByJWWD?=
 =?us-ascii?Q?oIee+7w8mUAD9Huod04qeYFQxkcHOgW6ldjWZi5+NvLKN4ZXDFGdYXxaeHb0?=
 =?us-ascii?Q?TBGGjd7Crv/g76JzKnBGo9pqblSZmV5pkPvETDa1elpvCQj58NMHyllkHMGV?=
 =?us-ascii?Q?4fQ8R/wzk7I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JEy8A5Fm9iWtXkEqWKzibaYbrMBzjraLp3tdLme3J4qkJMMgCaZ4yJ9nXnr5?=
 =?us-ascii?Q?L4qPCk/EAeM0G0412PTxQtkbNm7pob+mTZPY46GtzblKEU3sbPgKpm4dlpFG?=
 =?us-ascii?Q?kR16FLca4QJv0FvB7DGgLSPtNe19kdhCUk+vIbKoDdCaCV2VE9Uyqs0W/1KM?=
 =?us-ascii?Q?K2r9MtFw7xRgYEPvoFdxoEn59I2q1jmaXVittqcbUoPTWN9hNFG4RVQxEA9u?=
 =?us-ascii?Q?ySzw2q9ctrFV7v/AKQf94jpyJZPLGTyaMfQftvdhxCKJldXcLEGlMJvz+kY3?=
 =?us-ascii?Q?ydFJSpIuZkcn/HKFaTbRTO7/jOdo38nNQOo+3O2IZ24rFasDqhQFSOp5X20W?=
 =?us-ascii?Q?MzsYWBaz7H351gaUvkUkoXcl1+jjUocQNa4c3paRnearWbAOgb8YWpfcVutR?=
 =?us-ascii?Q?bbUTf7gv/elG2CMy1d26csvrV0VGIPZy5qI9WqKhiHMEMCuTxHXMe6C3Nm2z?=
 =?us-ascii?Q?A+ioHylp1swm0VLRBzqRgHbRc5ZbQc0aTCIwmzViNjoeiUZGwvniI/S8mDfU?=
 =?us-ascii?Q?Ay57I2o99qpUm9UZYKrpvA3R/0AbORW2HOgAOFdI870SIO79m4yeAPTXKbmM?=
 =?us-ascii?Q?lg5Z/grgiaGlckbwkJTEubVavVcTa3U5gd8FyyCIWkuhlP8mAxeXA2LLEuGY?=
 =?us-ascii?Q?J9GmIfD4ymm49cry9xt8lhCI2vUo71EIxbqmoEf7OT0NjfkuEMQ/3GIogQqY?=
 =?us-ascii?Q?Naybo1LffCuJ/PMXRBxd6/H02cv2QM4CvOszFGUoNtg/G7A/LZIeO2Ruaq8m?=
 =?us-ascii?Q?g98vO2RJvRSRq20f2V+YShxxcRkvLyErV+fjkDg1XWelpKzNRFD4LlDCDTGi?=
 =?us-ascii?Q?Y4/ghuEk0ACSphyVtqpWM70rOu1UKnjH5Ne0GBBm2BnKu+TYZcsZNHfl0ZtZ?=
 =?us-ascii?Q?n1UvJNnZGyRtDnay4gGOOm9Sk3G3E90gZdzOLt05QsDgmvbOa6MzmGO2LUYu?=
 =?us-ascii?Q?jwegbN76oDQQgDE0GvMtuWBlClTr3CF3ERvyqblgueR2QAyo0Xpy7z4xKtXu?=
 =?us-ascii?Q?hjMCgvv+YZqnKZmVin4B6PEg1Z2DEwaRLpsWcMF2ungksBTgQGd4U7AKh0r0?=
 =?us-ascii?Q?8lmQWbLtEh4F8CgLOX06gH99H2DsS5UXY7GpQx2LT7aeqy0h/Sr+SqfNkFQC?=
 =?us-ascii?Q?bC1muLthToz5yxUoVM4QzLONgDYasd84iVffoW1MLk8QfA+wKGXDS77O4/kx?=
 =?us-ascii?Q?NlIlNPIO51eVrAzrh/ll+D1dYh4iMqH4G1G8gGRg8UsuZCd1moi3f09Utk4a?=
 =?us-ascii?Q?JN8IveMaV1J/vA0e3YGBvF+qvqDpNWSvbF/JzY/I2G6WC0jDZDKkprJnE6bB?=
 =?us-ascii?Q?j087akqLEsKQl1x0SQ0yIceQraq0I8G8wlJk6+Zv30/qEgRUQM5DvCoUOorG?=
 =?us-ascii?Q?1EIPpo/C15k4SydSwBPG0p0otBV0l+LezEfs/wISV+YWcgSmg0ETW7dno9me?=
 =?us-ascii?Q?TrfDBkqg74mMSUd2nj4iZmdf7Uf0WtgRNYMq8DStTus9fictf2zkYUzlanwo?=
 =?us-ascii?Q?cPsz5ePPtDrs5U7eHHA9HTxsfn/Um+VroCWYSm0Tx2PLgng20+jMoyt1ZFsg?=
 =?us-ascii?Q?nF7zBpXPGbt2SDWFgjbs3dUVeNmL2NZkusqQ38hqfT/bCE6kPTn2wiMymFkz?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e08585f-e291-485b-ecee-08ddc40c5811
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 01:59:05.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPrxINSoHguKx0RMZyEAbqb0CBlft5+SHHtqckxQJgVfNctgjmSTSxrDdDE0ehzvle1wS5HwKdc1+GS4NS4ri6ACsKkDNu26/QJgkMHfUfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6205
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 03:35:20PM -0700, Dave Jiang wrote:
> Refactor the code in reap_dports() out to provide a helper function that
> reaps a single dport. This will be used later in the cleanup path for
> allocating a dport.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
