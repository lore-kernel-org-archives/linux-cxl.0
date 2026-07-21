Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70B31B803
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652561; cv=fail; b=tAQ4nKb5jjpuZgGsXv01WLHjhtphWOJRIq++nVy4nijovSbPaJDgtK9NJamRvQVh8APx85c2W+zGi+gu6Y2VeR8gKc+mRBxX4ExhNEnynUJnZA1z/o3e99kTXY7WXQNehBrT+Bn9RvIck01WjkLxDhoYfhlizaiuU13Ei7nA5Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652561; c=relaxed/simple;
	bh=a4BaM691Ilfn45Yory/ivJ4em44KVgMznPmBYZ6SZnk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jlUc0evqXC2LqiU5l2LzGdOF5aupigk2rJjXpZ9yqtQHeD7Xylh0LTJdrm1iKy6hNl6tYoSR8SB1c8bImgiMtY4CZkaIksQRMUTaKBr8A/mWitYJDTAFD97mIR6g7xdc7CwfNn34SVbCnB4p/046RcLuZ6BS0sBEGp5Wjpyk/yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fpxkx3Fs; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fpxkx3Fs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784652559; x=1816188559;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=a4BaM691Ilfn45Yory/ivJ4em44KVgMznPmBYZ6SZnk=;
  b=Fpxkx3FsPrfvzQyJ16QBhqYrni7CM1K0jDl8zN+avmOeJtgFxsDeLyem
   xCIMUNE9EMz5nDKNKmbcmXlUsqmxlhg8eMHYcgLyerud20FWOiK8Rz7O4
   1StJP0l8wmdPfpc2VA+TlO9R1NPIsCk9Di6OFh3SP3HZszi4IsAmMwEut
   J1tW9k+yhc3znwPnXPjy82brLBZGDYtC047PScBkGBzSNLgdjvJG7uZ/V
   CWHPCdhVcIJiAcspvdamzyBFSBmYB1bwlCjbgfZQiQvyGTlDhNWmSktCR
   wNu2LlfvxfVRcIQrUXfzNODO5flm4FzeXo5nhUAVL2iyilLHoF0002kfc
   A==;
X-CSE-ConnectionGUID: RPEgf7ytQLaOYICaP0J01Q==
X-CSE-MsgGUID: pfvh0jQLT12cbW9jRfr0NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85206097"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85206097"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:49:19 -0700
X-CSE-ConnectionGUID: HKA4HJpZSkOKt0aNS2/UVg==
X-CSE-MsgGUID: 8eWv6f/JSsys++fryMZUag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="262099142"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:49:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 09:49:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 09:49:17 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 09:49:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apKHUZj5AznRCg9KzrIW50RdUoeTr2m0xcQPfsYTqSzskEmV9veSn8jqKHBUOZ3ONmRDGhWuJMA8PXtum1FdoBlVYeoRkbLV9sXFfCVZyjAC0GiNDFWwzci5yRia66YmmKOmd5hie11JDSq+r1PljGif0W9IurndUP5P+xbpoLUzh6RMu5Cy0anoZEpK+adrvIwTVi/wv6xrP2MvdtvGoWhcVGnaFHBvebme3s5df27o7R+02Kah6bdoq3/5p7uTezWYIqXaI9GMJdRlaKXgjUYXFufl0AvLnGLAzvRHw0KhkuPhUvFZklucC33eWyl1+uzErO4bX0J7PbNHl2cY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJevmbT21+zgkFWgGF849aTo9Ir3a5hlzMDSphHHcXA=;
 b=YLgZoRZ2zkmkHMFnd65LFFcW0yLggk7x1K5SCqq9Sh3i530P5hsoDI+yQ03IWpl+m9WWad22KConzbrubA4IBWroZy6IcWtogb+5xdO0yBsDkgmbrZO8YSzl2DKK92WABenT+YwQ0TRCUm3EgsoC2k/mr9w31WPra6H0S8PszA2WxiZ/ZPch3V4W6LT7PrN5IojMBgzameqJvtmkUVJyEu+Jn8r9VSflL569qkuOCYwXXioI3iYCeojcVI0m2nUyfHqiGk7+Gg+C1MeL+Hipnh3Iux5418aPMYsWaMhNLavDJTjaU4+eALsgOKhl5la7vH7l0yXMplKXiuxfAYip7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:49:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:49:12 +0000
Date: Tue, 21 Jul 2026 09:49:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix use-after-free in find_pos_and_ways()
 error path
Message-ID: <al-jBGiYfN5o7NZ_@aschofie-mobl2.lan>
References: <20260711180755.1779002-1-alison.schofield@intel.com>
 <20260711181949.A4B1D1F000E9@smtp.kernel.org>
 <alKe-MPcCLbLgFQt@aschofie-mobl2.lan>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alKe-MPcCLbLgFQt@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: d2889c79-3e54-4d39-72bd-08dee747fda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AKe/kELzYcgcmqP8M0EEqM2e1FwID5hHAGqgE1QbU5A/i9iY9IckXWO69AdzX6BXQdUPer8gDoTqXzfnUmgpZGxzdLa7cZ03vciN46a97ePdQWj/5VB9bnJ5BsbFmaR7+rzoGja1e1s6PxVcJZ9zq0vua4UFQgT1TbtxMmMzPkrQNsfXDq5MdTp910q23NGARTcCe5QyNDwjn5tAWY89Aw9dY2y3Lp3UIkb2HpBvFkz9e8qdn7EnJE8mnDR+8DjKiM5HgZ+nNNxdpVqwjisdQi5p7FKWRM3vl7WwjCuW3ekOIsSKfcTEleQZtv5BDI/YSOMSuFM/UltMa3CMNAJpsJcVe0A46QLTn5jxbWz23TPJRxeqDxqKlRdOwJjhhTfbwmT8TUoTYG7WlMuqhtX6eg9+8SjksNeFxQr5gF8Bg5gtnJIwF+69zCJWZVV3Xkg/gulZy3NXGEERyFlxPtTA/Dd8TLZPBEP/lonnwdMs3Yn+tiqbnztWtXC3aE84L9bZa9jcU1Bm2SiKrDKSk3K9ufEpyMI1e5dytI/0r7Zo6N9SFFKo0tZh0HVF2Uk6zaK+WIn9Vug4tAcnW3ERqVM3Gt1eBh/4u8nNoKVxBuRl0zc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0qQoW6bLKfxsztuHVD6trspHsga0ARVxoSdtSJLSoDhSUX4IxPLX5hux4W?=
 =?iso-8859-1?Q?N86iPZIuY/PBkHHGsrLMQmleRtL9J3zcDC4B1tm0mhzMOor8nV3KaZG50X?=
 =?iso-8859-1?Q?FSePRbLvhVgepZVp6k+1iBAkIrPJsBORlyVhbXzTXKo8HiUNd9VPVPwS0h?=
 =?iso-8859-1?Q?BWPZVU+wVyTUFgoMUG0Dm6mRxTSNksirCc20NF7HVhAx77FncH30VbSeY+?=
 =?iso-8859-1?Q?w0MB2BCy++26d0MMaQr0gOee78NaCEULxwD0sXHFhC4erPL9I0NE6IUWHA?=
 =?iso-8859-1?Q?CebpiVU4qXEIzBiwZmpI6iw5a7poTDI3oMBvRNqp/4mOlSINQrqXzjzcQ5?=
 =?iso-8859-1?Q?wZGD6m9iLLGC3dGGES9mmFon4Y+CbO0qp1nVxPMmtWcHt0z1kOfl3piM0x?=
 =?iso-8859-1?Q?EOTmI+pE1cJkUhNZFc08CuFZ/vXlrga5bGvx0Zof2AKL3AYoNWSAHg0lMW?=
 =?iso-8859-1?Q?xro4UrKPGO2ruwUL7w3HJhiCv5f8XvtMrkdkucEeeu1nOui9t2DxYcYXkN?=
 =?iso-8859-1?Q?+PEYh928pc5I1Skrd28OIXgXbul/IOGwqb6u0Dn1kNWdXJKmAlgYB9l90H?=
 =?iso-8859-1?Q?q3jLwo6LfN92TTAscypKuiL7crB1wrtXKhvS788eWGNFxbedqZlgU3CEGW?=
 =?iso-8859-1?Q?5Gv2i1X5zJq604tpUUGKprC+D3qoTR44x8insrGNKGZnkYcR1Tn4SVeB/r?=
 =?iso-8859-1?Q?CFf/Hkm1jLGAPglxRpOxAkCNYyxUQD00zxWBgcP3XvvICNzIKZ9vzeoFjf?=
 =?iso-8859-1?Q?oAl5YdrtkYihu4ZaxTDXybfGNX3D+xytp2hhInzwLCYdWIOsoCXtNAW2ua?=
 =?iso-8859-1?Q?8lfLEGuveJZe/sFLZQYmv1wpmqUBCrdmDO93HUOs2IZRawENAwWEySZBEG?=
 =?iso-8859-1?Q?5YAeVG2QqopIlyG+r3PYYUHcJ6hNPBYqM8n5Q0tKssG7VnwLKmpZYW4rQx?=
 =?iso-8859-1?Q?iCy3MVUvoCVdjgbvxJ6oDp1G8yVlnTBPJMaLsxJaJwenQ81hXUxgFA01BX?=
 =?iso-8859-1?Q?LMFsi44Jlx1q8KD6jeYzwsmXdn3GqXKEBQCouKIsVveJWCN9TIxqJs+f01?=
 =?iso-8859-1?Q?STaVKieVoW26XFqdwvb+9klNTBzIZQ6g+8aJjYCg381pvPfxXLn/dursUs?=
 =?iso-8859-1?Q?qrc0ezUAOEuHhr/XrVNKpzHnJvUMH6DPHFQaRVYSXfn3dPig3Ukb6GMN1K?=
 =?iso-8859-1?Q?L7DH4fL+UP6WU/YVMm9goA8AHbmP5iEyX7k7dItd25VJMXSZHpfpCBggn+?=
 =?iso-8859-1?Q?1ABLxWmNNHhx4LKJy0Zh+0p9yZwUVRTzhB1pj95yEcBubivlC+jQcdyTWp?=
 =?iso-8859-1?Q?S5oclnuNaM3FTLZ05iQdbZii333W8HWjKTiPAKuJJqw5obcOQW9MqCeXO0?=
 =?iso-8859-1?Q?LR7dNjOVkCCjMu5se7b3dVtl72D3CdGEq7SkT++3b34pc6wJ1BA43pni8c?=
 =?iso-8859-1?Q?qZixcQhpGukrLqC1LDpusAu8cD3fXxnlBttQX4tTIV0Jq8J4dzMsrWpuO1?=
 =?iso-8859-1?Q?QY3SggbQGV2F5wvbuoo3hLx6DGwc2JE0Ow85Mx3DBDf2q2IqCUB4Sx5Laz?=
 =?iso-8859-1?Q?HjGkScPw9oWWplTJOgWSyDy/HbfLYxnOcO7xSV9kdJZHEPX+bMX4o15Tni?=
 =?iso-8859-1?Q?1s1Fq9w5vYgMhAGauEy1s4h6WB6L9LgFg4ZEv0VKWozkDynAPxErJhAO8A?=
 =?iso-8859-1?Q?1mPXQEB+i3kYow+7Mv9TX0S/G52RPkn8AuEMLVQyOVGuSNFahv1Q9eRZkB?=
 =?iso-8859-1?Q?KRp0snmcCrfkaK0NDbJcy8ddISSKvxOwa5NwJ6SkeVsSRn9QTVMNyH39ZX?=
 =?iso-8859-1?Q?yFvEcFuiRmsGRjhSI4h2yu9I3bjzCUU=3D?=
X-Exchange-RoutingPolicyChecked: C9capIJWGzV9C0XSQmLhARpBXXX98hKJD3/md+C74XUWyvTMLpRSKCKtOBhB6L6HHQJ2mPWkHkndHNxO9LE04E46DJjazTIfovNYZWlubJJeO5FjDBh9etK7w2GjnGiMmH3xPFcl9rxfsVUOXfloNy45ISgeVSNQ14Ykv9bhu4F/zRarZTj2k00h1f0zxoYaoim5Lc8EfOaPqGsVworAixkz4pOBeaXq419uoDRS0dFNKB5MIofBnd2E3FV/p1+YWe6ls4xwBci+9XoiK8mXVdEWCWOMuy5D4nvCqLrhSQj+KA00m9gEcQiOs99zSIXIICwBVo+xhaQHt6A6rm+rFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2889c79-3e54-4d39-72bd-08dee747fda2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:49:11.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNU9RIzfAkNWAfFNrdYmprw4trBmU8gRBeLTm4tB8yEJ5gphxmh4gYZiH5uD8rXWuDYQDVVGphY/y4239kh6H1LJaIC/JbHh9A3qeZ/Ozys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-OriginatorOrg: intel.com

On Sat, Jul 11, 2026 at 12:52:24PM -0700, Alison Schofield wrote:
> On Sat, Jul 11, 2026 at 06:19:49PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Unchecked `interleave_ways` value from untrusted CXL device leads to heap out-of-bounds read and write on the `cxlsd->target[]` flexible array.
> > - [High] Out-of-bounds read of stack variable `target_list` when initializing HDM switch decoder targets.
> 
> For both of these...
> interleave_ways is not fully unchecked. It is decoded by eiw_to_ways(),
> which rejects any encoding outside the legal set and caps the result at
> 16, and init_hdm_decoder() checks that return value and bails on error.
> So the value is always in [1, 16]
> 
> But - as noted here it could exceed HW target list or reported target
> count. That would happen w a bad device, ie malfunctioning or malicious
> since good hardware won't advertise an interleave that exceeds its own
> target list.
> 
> Worth hardening, and I'll follow w the fixup.

The fixup I 'promise' here is in the patchset under review
titled Harden HDM decoder enumeration.

https://lore.kernel.org/linux-cxl/cover.1784595445.git.alison.schofield@intel.com/

> 
> 
> > --
> > 
> > --- Patch [1]: [PATCH] cxl/region: Fix use-after-free in find_pos_and_ways() error path ---
> > commit 1c57e04f0aa13be6ae927836e151c3bc815eda70
> > Author: Alison Schofield <alison.schofield@intel.com>
> > 
> > cxl/region: Fix use-after-free in find_pos_and_ways() error path
> > 
> > This commit drops the reference to a switch decoder after logging an
> > error message that includes the decoder's name. This prevents a potential
> > use-after-free if it was the last reference.
> > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 1e211542b6b64..c86dd9d55e939 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> > 
> > [Severity: High]
> > This is a pre-existing issue, but is there a risk of an out-of-bounds array
> > access in this function and others when handling interleave_ways?
> > 
> > Just above this hunk, find_pos_and_ways() loops up to
> > cxlsd->cxld.interleave_ways and accesses the cxlsd->target[] flexible array:
> > 
> > 	for (int i = 0; i < *ways; i++) {
> > 		if (cxlsd->target[i] == port->parent_dport) {
> > 
> > The interleave_ways value originates from the HDM Decoder Control register in
> > init_hdm_decoder():
> > 
> > drivers/cxl/core/hdm.c:init_hdm_decoder() {
> > ...
> > 	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl), &cxld->interleave_ways);
> > ...
> > }
> > 
> > If an untrusted CXL device provides a small target_count but a maliciously
> > inflated interleave_ways, could this result in heap out-of-bounds reads here
> > in find_pos_and_ways(), as well as out-of-bounds writes in
> > decoder_populate_targets() and update_decoder_targets() when they iterate
> > up to the inflated value?
> > 
> > >  			break;
> > >  		}
> > >  	}
> > > -	put_device(dev);
> > > -
> > >  	if (rc)
> > >  		dev_err(port->uport_dev,
> > >  			"failed to find %s:%s in target list of %s\n",
> > 
> > [Severity: High]
> > This is also a pre-existing issue, but does this same unchecked
> > interleave_ways value cause a stack out-of-bounds read in
> > init_hdm_decoder()?
> > 
> > drivers/cxl/core/hdm.c:init_hdm_decoder() {
> > ...
> > 	for (i = 0; i < cxld->interleave_ways; i++)
> > 		cxld->target_map[i] = target_list.target_id[i];
> > ...
> > }
> > 
> > Since target_list.target_id is an 8-byte stack-allocated union, if
> > interleave_ways is larger than 8 (e.g., 16), could this loop read past
> > the end of the 8-byte array and leak adjacent stack memory into
> > cxld->target_map?
> > 
> > > @@ -1947,6 +1945,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> > >  			dev_name(port->parent_dport->dport_dev),
> > >  			dev_name(&cxlsd->cxld.dev));
> > >  
> > > +	put_device(dev);
> > > +
> > >  	return rc;
> > >  }
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> > 
> 
