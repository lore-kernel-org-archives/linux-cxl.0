Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD435950;
	Mon, 20 Oct 2025 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942810; cv=fail; b=e/vAE+/u9+0s+x+9yML6VNMn0/ybifnZnBykiEhjzbVREq1jxsHNaOnShZH6uemwj2qvTus0mx03ufuTmItzmskAbalTnCuRUHmDS86Tkk3K/k1uLnXpkRNi6WtbYrUB+QnO4ioF+TszIREoCM07O/cukgjuwq2I20I7XBEy46o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942810; c=relaxed/simple;
	bh=rn5DLbQpwxswQY26W0DkSKeQ4Of16pAbtC4LDo6CINE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTllIWSRCuruEJd5NhD70dzZgkSAxd176Axf5Kga33ztaCWIRQ0ITN+3p74TKr87JQoQFsGuIDXsqkaRwb166r9h0mlGrCh1nzjuJY1VHxcKc5cbiZbM7k9plG4YdPzkH293qEHcl5yOb+fulF1fQfh5ZOkQe7EzVJ0ErSD5Sng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKVkIaJU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKVkIaJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760942809; x=1792478809;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rn5DLbQpwxswQY26W0DkSKeQ4Of16pAbtC4LDo6CINE=;
  b=UKVkIaJU4OUySi3WKl72lHLp+5X4BlnriwUuyhdcWZOZ/9rgN3sO2xrq
   CTLHP+TFsAJD96ytfLVEaCbxYkysgwTxVAGW6aK+lywhvRtMJ4i0yhCH4
   IW/M2hCIImnwM3mKK17PcZZaHicxZ0HWutF242ENE56kM3wc/KcbhnKiF
   1tz3bCjo9mkLj8DVA9wDczDq7kUTEG2i5ju9wy0y23WvDY3mmxfeb1BnS
   t8CXNK0FuVS34dZKO3uEIHV7ZvNKusHbHIcVUmss6iliiXIQrspF8CbBw
   VL+vsc5hG7bmvUt9iSKqf9CFz+Ew0OBi6Q0Be00hqfovJox2hOTSjZPhM
   Q==;
X-CSE-ConnectionGUID: 5HXKHIlQTb+AJsEvWeFitw==
X-CSE-MsgGUID: cLbL/q7KT5uImSp9ASdF2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="62264116"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="62264116"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 23:46:48 -0700
X-CSE-ConnectionGUID: cQoHVF9FTbuzSqqkrIf9LQ==
X-CSE-MsgGUID: 5drnzvesSdC1QGTmcqDg6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="187275618"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 23:46:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 23:46:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 19 Oct 2025 23:46:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 23:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v42mzMaoXPlRH15MiTYeHEyD1SM76fI+TTTYVwIBMT354L7Lph5cCTSR524JZSNspc/Imv99bMGimdxbd3cOShpGP3Qd/oVafgeReJww9P8u2GVtkYiTP46t9Em7P8K/hL0ZSBIKQVNUB0jSp4spA4HGashGWNZNISYCCdSk5h3gFSDaU7LXDEwTZix8Wd90tGp7FMgPgcqneWWvZfjhP5fpasMKWxolQgeH0GzsFCkVGSFmnCD97STtwSIcHS9mz1btdffYcy+LKsNMUYrGBGxW0FsW9D/cKg2TZT4ULRa1wyj79rgOV7i42ngxRdqNN0e5liYkS2aJleK99NCHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBuIyeHqE9a7118zXdyUFERm6D3Oca77hD6oULd/5BE=;
 b=KYMk30BgA8QnZEFhHuNa5/1Na/VgyD2RAA360Y0R3Z+0gtNT8HVDyskTrDv5+YSkeTeVpWpVhyJ2H/oXSM0a/+/pR8tizfOBIzJrE4ch6VcbBW+S7sX57m5vbySCW56QlZ4PpTBJPT4KPT326YGqbrFFgzMTePr2SjkhBRDe6Q2vAb2l2IWlVC+dFSowB4/bmjd1KNJFuHDn3Ck2yl28iB3UIEGR3xH+UJCd9IDCD1nkL9op5aSQpMPN07IQtWvG+CSYLFN7EcjZpvU0nJQgqFEaRXJCMIAv+vf46ZldYrCmgx5GNTuOaMwdnCL3b1VZTgEd9ZhOZoisMcr+mNS24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 06:46:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 06:46:43 +0000
Date: Sun, 19 Oct 2025 23:46:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Vishal Aslot <vaslot@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, "open
 list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] cxl: Allow zero sized HDM decoders
Message-ID: <aPXazKH-FYS5K3qq@aschofie-mobl2.lan>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-3-vaslot@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015024019.1189713-3-vaslot@nvidia.com>
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 756b06ac-21bf-4ef2-618c-08de0fa46e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8SkgJst0M3g/iVj3m+XtLS2dwp71Bq1PJC78PsxCVW1E7t3GmIZ5NGXo/xAi?=
 =?us-ascii?Q?XKzosF4Moeh9xOOZJR2YtIConRjL+K0Df7WQsxwdUaXytyVaqTkfWKuMkoo1?=
 =?us-ascii?Q?AsZniwvCqW7qUJOBgasmVOsY7UgNTN2enThsHKG6U11k2WnZcbcE86kuxloj?=
 =?us-ascii?Q?izvcN0tdniRm5LuWencSey0uCq7yGu7BMypqwU9PrIYpuYC2YTQPD3q4xoRp?=
 =?us-ascii?Q?zu9MRIxrEPQshg16xx6tfID7kINOEiwycb20IEak2Q5t8ypH6CMhsXmGxfK+?=
 =?us-ascii?Q?jztWhIsLrMcniqquYMLBz+eDJj2sHFj07OkEZ8C44OHv4ilBEWCgnzF4KDB1?=
 =?us-ascii?Q?6mVAk7XVA4FlIzglPYiDH5ExdTgM14Hnsk/V7JOh8+RV/WcVAV+UZMKrWBuQ?=
 =?us-ascii?Q?EkR08TGA5v88pTOgDpYt7RGq8LppPYCj4/NPZtBRmGLXYB9baqvOLF1aGZBn?=
 =?us-ascii?Q?9LotrHiPvwXfXGL5xS9k0eQfgYCXbRREzMFhBHgIrkjgrLiaG2rh4MuDcebN?=
 =?us-ascii?Q?zLY0WA38/odFvc908LxEv1DAb2SfXLCVcyfCq5VaYouK5J26rlHMtd+FSek+?=
 =?us-ascii?Q?W6xGwRJD44Fz4IgX9QYlnp2ld0VMoh8BX7oITzitLmKFgMsAwHfsXPFkEcX6?=
 =?us-ascii?Q?LX1MK32PSVrpThHoTsNw1Yq2wQEBRfTY3F6QcYu1fnFrWHa06CwryIs7F2tV?=
 =?us-ascii?Q?ZA1XtoWl1vPDyGxNYHB8Bx61GyOtDTvb6a/rv7K7fZPPJoqPMomrnwc0W9c3?=
 =?us-ascii?Q?k1pOm7QXk5fBNKLGVV+yQ16hPPs9ZiZrOYCXuMMaO9ThDuIYhYFNgD4oV+3i?=
 =?us-ascii?Q?ZBlUj8UNOMOPRMiimJZEKq2oEtzYNpdkyZGl0HRyYGLlclB3HJQ9eb+fL6uM?=
 =?us-ascii?Q?OkVX3vwL1EzQc8DU+i35P7QNxO+0eb6f+/a9+kpY3GbTm1yKdb0J5+00ytYV?=
 =?us-ascii?Q?vTnNPd8lV4ilN1JIaEUGRmnPBKrk+NS1+FMkoHudh5VamsuBTc3z0TJPXI0w?=
 =?us-ascii?Q?MvQPcK6n2fPFORrKs3Z9OdeqwZ9ObAbAlWcAaSotOnh2LB439EuGG5j2Vbws?=
 =?us-ascii?Q?3SihdtLew+D9HrMPk5A7MoXTkyzF9iek+W6s2mOzCZ+CDiZVT3apNxesn6SX?=
 =?us-ascii?Q?6Qfsp8MFsjVz0lDKEEMXwNbzVsoYnz4ggMrWMC/Q2wM/rdMvOLrazc08nlvu?=
 =?us-ascii?Q?cXH6B+y8RLek7tgP9NCqIQBqusC3S6UIm92LghAj4VtIUdlNkkpwitIbuxPt?=
 =?us-ascii?Q?lK2oH0nQlz1fx7jv/KFu11qfZSxLRMEJe8LsNTaCLT59qQSqpje1NAgL1rNb?=
 =?us-ascii?Q?wC9ytxRec1k2u8pbUCmwWhBXX+X5/ZDsgSLo/mTvxow5EORaqFmtkYimZfpF?=
 =?us-ascii?Q?1F9CHENMdLIEQS1AcqyJHqrbAFxlnwwQwBbnFn1jrEXf52pQ42lJl8AQMHB1?=
 =?us-ascii?Q?4qzogmjmnOzK7FAmyOEHQdWQINpovQFu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J39BH0PEr5sIIwNbzQkp967gtah0PrWMhcIwRCsXgRwNMRRGnOVa1M5d6UKm?=
 =?us-ascii?Q?VqZoCzkis+oZTVXX1bbc7UxcDEONlOUMOREyHU4aNISHSW7FLX0LxO76Q9O+?=
 =?us-ascii?Q?ZjrLZmIkKGQ9hsO9F8drnvhTpzasq9QQxXIrIxtOylYLDc/IBCyYWBDES8CI?=
 =?us-ascii?Q?gCs11dBumES7m87GO+fj+RrHXeo7d9BXFw8sND3Cq4IA5F0OJ6IFx58Oh2RZ?=
 =?us-ascii?Q?Xpt2FdJhZxLcy85EnDo6Cz2oqmnECyYBAb6bKESssRAgr/688rhqgFqWFH1M?=
 =?us-ascii?Q?WZcFn8SJiGpdQjNh8DzlgZL33kuZid+h7lAk4B3UdGCbhc65YSY4AYC6S2Ok?=
 =?us-ascii?Q?1nqMP4kiWlqvVi/mCkC1iCYnRaI9VsUjRh/oQ7FeNSTSipB5sTTWQDKgkAsE?=
 =?us-ascii?Q?/O+XxlWOCEPtudu+jS/hibQinm4EChhbPCErBj4B+OnYZnTGzEk+v8PMhtAZ?=
 =?us-ascii?Q?mEeauWExNkz2dW7kgDu5hgic5woO+tdoC2Jryzg61mFHm1oqE3sHggHbZVnJ?=
 =?us-ascii?Q?vdr90O76i/DFiVePwFA3DqfKsx45PuZXcBpW8ubjxaoSvD94wIcWfO4SS5jf?=
 =?us-ascii?Q?pRLx9MLmTtzusq/eUf1fur2LUdOUR7O5C2W9ae3zPE2zIsqdHm3twdfYUva4?=
 =?us-ascii?Q?FunxOzM1HfPhX58ikkknkvTPhv8N7kJ0M9c5EMeWUzOpuu3fg5lV/dC5pbzr?=
 =?us-ascii?Q?XUwBtOEZyG+cmeULYUJr2UkRLCxXuDB++/A+6dvUNNHDrP3XkqJavwrJidSE?=
 =?us-ascii?Q?Go7iZ9CqcvgCsqGnbx0DN9SljOM2hjW5RrB2YjfM5BOUPGG3rj4Dk5Zc8d6h?=
 =?us-ascii?Q?qMCjCjtWE4oLv365vzght6kcyKkgSRJom1Cm6SSut7URL3u+6V/vT87rwWCh?=
 =?us-ascii?Q?pf4pMtpI7niTegAfUvMUp/17XTp+7bt8yd8drg9e7RQETfAfEbs47cTR28mb?=
 =?us-ascii?Q?lsbLHhsqIfS3+hQx+wuIwvd9xtMMoAD/txZCsBiExNApEyz4KF/XDQKbD9EO?=
 =?us-ascii?Q?Om4cqUUAsJcEdi1ZJd9rczt3qCnAShVxRY7Qk21N09ZHSL7TGAA8+bx5Gj7k?=
 =?us-ascii?Q?DowPCsOzu5BVBxWWFa8kX0bZFCk4OT4IWFUv7CVhjTwCsTrgnCzh3Sd/l8qh?=
 =?us-ascii?Q?L1RRrPhWRJVMIXRiBbD8c6NUNwhJENZ+kvZrMzNJoiQ057CmoIdCXC6MB+Z/?=
 =?us-ascii?Q?rT9CuHpq09SdDoj7skI2+IGtQbiLgwjgTNnpQ+W+0GfEl9EkIJkvFxHuVE59?=
 =?us-ascii?Q?qtKl9Oy4FunsW3INkdN3ywMjYXu8EEabHuF1VAkE7XxtENLF8TZ2b437iVi3?=
 =?us-ascii?Q?UpiA8TGsgYVR7HmMx0dyw/nSG9CTP5PlmtCYgv6FILhGsG6RVeHIkl9tdfks?=
 =?us-ascii?Q?m69ouGlT1NRsl6zY3ovj1ub8IOpgGv9By4HL3hnAIZrgf/fIZ2dca5MK5Y3V?=
 =?us-ascii?Q?UNEGAhbRoIgmTk+4hpft1FDL6gPUkqTk7TKIv86QNgLGSuZhDdMc3Kj2o8Fz?=
 =?us-ascii?Q?jWemZ9+Tj8rnfi2upR5JqG8GfExxpgMbdlVvznfXOIlKE5lyj3AIB+Jh3NvL?=
 =?us-ascii?Q?yccs7feSNnMskPAbmwLvicay3UyUzOpoZIhxLcgGzzqvaLNuS/Ydw8iMfOfu?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 756b06ac-21bf-4ef2-618c-08de0fa46e34
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 06:46:43.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhfflxAQDVQD1QsRlcKmGJuCCaRkQ9REH6Cb8dItitelLkngT3oJXLfZjiAY53P5aDpiOgqqodk2oln/ibytFHA7lBRmevgNq1F3hPYQlBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
X-OriginatorOrg: intel.com

On Tue, Oct 14, 2025 at 07:40:06PM -0700, Vishal Aslot wrote:
> CXL spec permits committing zero sized decoders.
> Linux currently considers them as an error.
> 
> Zero-sized decoders are helpful when the BIOS
> is committing them. Often BIOS will also lock
> them to prevent them being changed due to the
> TSP requirement. For example, if the type 3
> device is part of a TCB.
> 
> The host bridge, switch, and end-point decoders
> can all be committed with zero-size. If they are
> locked along the VH, it is often to prevent
> hotplugging of a new device that could not be
> attested post boot and cannot be included in
> TCB.
> 
> The caller leaves the decoder allocated but does
> not add it. It simply continues to the next decoder.

Please write out acronyms TSP and TCB ?
Commit log wraps at 70.

I tried out the cxl-test patch of this. And came up with the same
question that DaveJ responded here.  Why aren't we adding these
decoders to the topology? Are these guaranteed to always be lesser
id's than than the decoders for any BIOS defined regions, or is
the driver expected to handle non contiguous decoder sets?

It's an accounting task, whether they are in the topology or not,
but guessing in the topology may make that accounting easier.


> 
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d3a094ca01ad..1c036a485723 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1036,13 +1036,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			return -ENXIO;
>  		}
>  
> +		port->commit_end = cxld->id;
> +
>  		if (size == 0) {
> -			dev_warn(&port->dev,
> +			dev_dbg(&port->dev,
>  				 "decoder%d.%d: Committed with zero size\n",
>  				 port->id, cxld->id);
> -			return -ENXIO;
> +			return -ENOSPC;
>  		}
> -		port->commit_end = cxld->id;
>  	} else {
>  		if (cxled) {
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -1198,6 +1199,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  
>  		rc = init_hdm_decoder(port, cxld, hdm, i, &dpa_base, info);
>  		if (rc) {
> +			if (rc == -ENOSPC)
> +				continue;

This needs to be in the mock_devm_cxl_enumerate_decoders() ....

>  			dev_warn(&port->dev,
>  				 "Failed to initialize decoder%d.%d\n",
>  				 port->id, i);
> -- 
> 2.43.0
> 
