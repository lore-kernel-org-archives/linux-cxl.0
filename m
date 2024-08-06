Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F0166F0C
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929881; cv=fail; b=moZ++muXOboAYl2riYFcrCWLwWacSOS8CLBENxV81S8KD8XpEGRywGzA5nd47Sje4E16wjk8EAAAnX2wSzfDTF9ECFiPKvnZZaxmxvkRk/Jw8XZ63zEUePVRjnJJVCdiafr59biACM8aVg9NprL61ESYfm74QAA1oLB1+3kySb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929881; c=relaxed/simple;
	bh=47mAlpuONuoacIjoCJdvRGjUe488fCxykW7rvYbmHfU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nOuY44zDkAgHsgL9BRhXWMx1NFRdPZ9a2plwspAchWjj5cCzYesz4CNsWvbINsqdsFCf+OmvrTChOqarzJXPnJ8cfjKTzhw7A6iKhAtpA/VENIkPxYB2XyxMryopPEw+6OFYshDni1BKkhjc5Xkx/oHHUMIjJfGKTkSWnvjfDvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayak4z51; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayak4z51"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722929880; x=1754465880;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=47mAlpuONuoacIjoCJdvRGjUe488fCxykW7rvYbmHfU=;
  b=ayak4z519LcTGGXml4APgYcKiwPVhFmzw7I0+CGrUg5LxiIGwd+vT+Rz
   TKHw6qp9ctUfh8GSviYOESLkonLfF0rhMmCcYgHTTvZpiYDGLzN7BM6EP
   xsq3FYd/h/kL4U3o5bfYJUGmRKHx5H7FcujT8KPtp2RbBl13mEAXuaRba
   RkYy/ZyhvYeAqcYj23IbdhGat2nOB9B32yw+/+Hb/JNPcKF6vhb8HAst+
   UEOjZc/m3kSBUfxWptkabB84VPz1Xt15ijFWvn4GJHAwLt+7HOTOEOXRP
   +FnCjO0jzGfB6pymyPNK6jCWFKIbBceNhC2GPQ04Q/AKHRmRZK4v0DlzJ
   g==;
X-CSE-ConnectionGUID: la5PiW6aTq+3tImK6F7YkA==
X-CSE-MsgGUID: lT6y0DEMTPiFWmIfg5/P9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="38432809"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="38432809"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:37:56 -0700
X-CSE-ConnectionGUID: FpizySHsThieJ0tOp+B9Mg==
X-CSE-MsgGUID: fad84mXZSjiESpXoiw0Axw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56508489"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 00:37:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 00:37:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 00:37:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 00:37:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 00:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egFJVPWLvjBSf8N3i6UrkcFBrJ8xE5ia3kp4Fp+ErWnr5Fh+PGUuWbwO3DqbSeRaZ3q9ZThS1huGqVJ93vQ5SMLhFA09raM31v7B7DZk7hlGuTywRNVTV4uQf3p7h9SN3nh+PJuJ5KO/Xh+C8go9rAWigm8b6sbV/tueuJcx8OVNNsNUtSWeMSWPiDH4FNpLFFd7YR9rnc05Zif8MckApKVeg/QB4Pg7hnxbjAdsUdYbQrxXt53D1NdkQB1TFEGQPBnbgwXW/6WVR8xSsVvHgpJu/8FBoYBWpm8qu5Nf78VzDubNSAi0o0Nm4GD8WDXjRhfMh7d+HWeiM2a2mr9u+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dIeYr7b752jZ59JKzyASA6OJz83s5eI5pG4BfNm4OU=;
 b=dqsn4o5Two6KNgQBsMIW2z1/Kl85t0w2XHLcNW0UBj6JQBJ26vjgDh4Ly3u7cJhPMrSJ1gfQx+iJfm1dVn673d5ebhXcEH6zYMXyRgR8PIvG+ovzjrfmOqr1Dn2kY23IV9uVGxP55XdgF3Vs2ufQcbV6TnsYNqSsYn1qmYsHfkER2DJxUOrgAfbVrSXC6HhsX+5b/1OPGKC0bsq9OjpbEeKPzl2EuT31FCTVhcGPtaV+8FHL78aHvkc749eFmcLDsDbYOJ1xEJ449R7435qIb03l3XFyaOG+Aj7cRFE6HCvlMKYuoS58cpOwaMUrccVPNgIkUpyVHCEvoS3FtcHgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 07:37:53 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 07:37:53 +0000
Date: Tue, 6 Aug 2024 15:38:46 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: "Li, Ming4" <ming4.li@intel.com>
CC: <rrichter@amd.com>, <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
Subject: Re: [CXL] There is BUG: slab-out-of-bounds in cxl_setup_parent_dport
 in v6.10
Message-ID: <ZrHTBp2O+HtUe6kt@xpf.sh.intel.com>
References: <ZrGFWYKwxa1ld9Iz@xpf.sh.intel.com>
 <7d1a47c8-4de5-44a9-b992-7f86d76366eb@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d1a47c8-4de5-44a9-b992-7f86d76366eb@intel.com>
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH8PR11MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd70609-0099-47c0-9072-08dcb5eaae43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iyvzr/0kj7BS0uYL4zJgSalvurkYTpWYISiBFdsYa1Eb17Dr0LmmrBedcEeS?=
 =?us-ascii?Q?CUJG2Qdqodlkrddh6KIxn1/JtL5YX5rpuUlaQkNw7vqde+R6GRR69ZWMMCcP?=
 =?us-ascii?Q?rC+iIa6EI88nRStMnC2ZBOz+PB0/k95ucp4ZtIuZoJLQmBiQDJUbhvgriHNJ?=
 =?us-ascii?Q?n/yU+ZF3cni3sVkCppWAaek2rO0VQ40AAGGlxGf1Gqj0eObUx1JTF8kTYOhk?=
 =?us-ascii?Q?dEACUpQ171VlaA+K1QHCDZGEKAs4egau5g69T+mfMmOzz1aIhUddoQdYIuL7?=
 =?us-ascii?Q?hC1kFyXtQ+RDMTrRE+CtGdUQLvvmJ4vJ4Pn6bWbGj0TfOOTD1E6ce5Ukm5BA?=
 =?us-ascii?Q?2FtVyM1y4EQwtanuY6QzJ+tBApQvAuUmQDc7jAlBsBDQB0vbT7TNhJslX2Qi?=
 =?us-ascii?Q?DfP042snbQ+xo2hKk2Daf621JktwFQFZ8pge+8a/khpvWkW4CHS92C+0gzr+?=
 =?us-ascii?Q?dq4ZMbA6d7ZlmPiIkGJNt/L6bPyfVinAAhEIQqm44C2LgPqaooQ/ct/FdYk6?=
 =?us-ascii?Q?Nw2AvU1bFCOs4FkkzUpapceFMZncrjAf1nleDiKOjAzoehEEnenNKPXs3CT1?=
 =?us-ascii?Q?1PnVAATGj3D8e0J8GwyHFBFQtkIaMo3vJ4O3MM/U2JaGNMPA12I8koYhe0se?=
 =?us-ascii?Q?kN9/l4QXDrd/FBU3f9+2Ky5S7c1grgqwqbNbAQ3Xv5lQQgr+c5rbO20b0A0h?=
 =?us-ascii?Q?CmlXm2uqkYRf/TIqDvFVo6xULoC0qE9R2s/SzY2H9PB9bBc0hF8XCW4jbNB4?=
 =?us-ascii?Q?nqat+QvVIDpHIlwpfIXabrPV6vrU+IzWMRqFJf/7roRC+64cH2jRO44ygG/K?=
 =?us-ascii?Q?zNtQOHiUbu2dqdgPP4lN0FpzFEZ3kbaLQ2bsTq1k22UwM7Gj7qkzu0I88nGB?=
 =?us-ascii?Q?yBbGaJydAVpbFRQUWKfzIfKrxwwtaUCYi5ujIQqy2WZ1THGcEKcVkjH2a9AA?=
 =?us-ascii?Q?jWeg0KGaUxIWokpvVLg1uj/s27MxKibAcbs0WTnMMFi8HWIhQIYgbGcfZjK1?=
 =?us-ascii?Q?goDCY+jubCa9O4aeNVEMNIl6Kx+3Eo9xfbEaQYXDBO3YZVaJWqWCM2vnWdgS?=
 =?us-ascii?Q?0ob3t6qd6ch5U67g5zOqHFKS4zmt59m0F3qLY2r3MP/O5KRgcQiyrwEYawHI?=
 =?us-ascii?Q?TwqBuIFoT0M8JbjLA7Jepof89z+nwfAGx5e3s9c4n+5B0y3da3EwnUORovW2?=
 =?us-ascii?Q?4Rrh/BrHPFJCr7bt83MM43u3G1vzTaBlQ8E75YU1Xo2Zf9Lx8MFmxmUoKbjM?=
 =?us-ascii?Q?+cslhdjuLiaTTl86RQSGt8dOauVMWgqse+8rCtxOWvzBCqBXrlds2jjhD0+5?=
 =?us-ascii?Q?lo/NADesqmNlprPDRsu18zxj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bVE67NuAd23a3pivhig1kdRXXvngmOmbceWpC8T1VwjYBdwiA8rIM3GY3Ee2?=
 =?us-ascii?Q?967aB7dUgy5nOyHc/JU8K/AC3yJ5wtMK0+Ib4m1StauUCfpImss+DuytRqjv?=
 =?us-ascii?Q?bPgj2PgK0R+mX4i8rhGDBOFCaDYLaz7VLQjr6OmgQexQRn227ftvw8S0XCdx?=
 =?us-ascii?Q?xmfackH1VFYUwcNt3qfaJ+7SNEE851GhUBZNxOIQuSptbyaDHJT3gLYUjlVB?=
 =?us-ascii?Q?CRStQUFink1vu03yPoLrkTCiETQPHVEuPD/BYErFfrwsrQulfQzKntqOQVdC?=
 =?us-ascii?Q?d5t/7O05f/Kx8eKI5Dff0EHwYQKj4owARNfXdwhMERi7DkWxHM8ZwOnHTRCi?=
 =?us-ascii?Q?40bnw4omiqi7E3U2qGfw113g93Cy75aAI/cwAw12E4Fueu0D8Ru+QNNC6wZg?=
 =?us-ascii?Q?U2qYh9dI/PZst1cXzTHfIkEzUy+/h+/ecvoYx6jb1r50ws4cTBVDGK8oVvyD?=
 =?us-ascii?Q?vT/P1ftppzawj/URz7Tpl3Vlcv4ltWuFIObMKYN40/upNsfqr1mrxg6xUhSI?=
 =?us-ascii?Q?lm2HFkSFF5xZztjbBSX1Ysy7yA0mVuJEfTPxynEjXT441AxTisXI2Di9MEF3?=
 =?us-ascii?Q?Ke2pjgj7phJs3TRZdUSjSdOyUteQVLgv3hVfhAJ0nHXFNHXOC53I+wqvUcfK?=
 =?us-ascii?Q?RFaQAvyGj4FWhQ3Nd0ZWBIxnh+UM7dycdJNQY0zTNtYefjjPseDrHU3i/S09?=
 =?us-ascii?Q?Dyzz4WBeciFh5ddoLopxxk+FqUoSJrbFTehprOTdrH0eilv01MTr22M5Yped?=
 =?us-ascii?Q?Vc05KwyioBXITlxmaIzTO9bEP0WoGitv8WmfH/DzDlU+10uFuWFhpsNBPSAl?=
 =?us-ascii?Q?jpgXUT2vQq1+UjHCmQfN5KGVV+rc0Kfh2dqwDogMah8xRqVTBrqCn6ZGXq40?=
 =?us-ascii?Q?EdF3+khcaBJ6jOO38Q3SeWxt3CjF6JG7TWB7yCX5lbwmqsUNa8ozYUkQnOiU?=
 =?us-ascii?Q?dLEvGka1tj8CqJI37T2twT7s0jerCdBP6D3k0WzA33KDQiO/gCOl1zW0RV05?=
 =?us-ascii?Q?jCbuYWfG/QtIR8dabxdhUjImruVAGwtMy2g2cdXA++AJs5jgTofdDZyUL0oP?=
 =?us-ascii?Q?zIw3gtkKDIfW8cSGkf9+xecMJ5dh/cgnYEkHkOZ1dDUm0GgsXv/Cl7drHMuy?=
 =?us-ascii?Q?3ZeI9CTAu8eof+H1S9U9FiqFu1dSl+z/6Wx3tAOM0fjk9lG78l/A3HarGJhp?=
 =?us-ascii?Q?/ZTwmQifwhOYdL7SC+QbDjJk+v0BqPAJKh4fj31XdSlHYPGAMw6Yzr8a7dXM?=
 =?us-ascii?Q?eDmQ+X4lho/CtCnbsVEbB9L1YzmbrGL7nmcuz0myT622ItZKwbhPpeX4pIOI?=
 =?us-ascii?Q?n3a69XgfLMPyQl+hD/4TVxTyFW2ZZj65BxIpZmyIFlC++FLWk3GOEdTmBPLs?=
 =?us-ascii?Q?suOG/DYfdnlooMjwctwA8WAyBlPK4qr8YoZ9o81h1OwqOXsixVZEOztTCecj?=
 =?us-ascii?Q?CCWpv33Ssr5WNhexNp50Yq1yTiwoT+Uq3PeWM/RTk7uI0l7rEvIxIhkWjYF2?=
 =?us-ascii?Q?s1ST0XM1so45C3aUr2ajzRKRPfIWSfxy+35eFlHmjhdd/X+wQNPYuqGvZ00z?=
 =?us-ascii?Q?V7oo5jW953CICNk0ys1dFu3tX+AYyvRSZ4Dd7+jx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd70609-0099-47c0-9072-08dcb5eaae43
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:37:53.1167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+K8x1cB+0yVs2pr6V/63xJHt/ewfEkklNykMCYUwnvgbP2KcHUOjgWJlcr6FbLPE7JL9txDQHy/wk0sMUcWuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com

Hi Ming,

On 2024-08-06 at 13:19:13 +0800, Li, Ming4 wrote:
> On 8/6/2024 10:07 AM, Pengfei Xu wrote:
> > Hi Robert Richter and CXL experts,
> >
> > There is BUG: slab-out-of-bounds in cxl_setup_parent_dport in v6.10 when
> > boot up CXL qemu environment.
> >
> > It's a kernel tools/testing/cxl testing in qemu simulated CXL environment.
> >
> > Related kconfig and dmesg are in attached of link:
> > https://bugzilla.kernel.org/show_bug.cgi?id=219127
> >
> > It seems to be related to commit:
> > f05fd10d138d cxl/pci: Add RCH downstream port AER register discovery
> >
> > KASAN and CXL kconfig could trigger this problem:
> > "
> > CONFIG_KASAN=y
> > CONFIG_KASAN_GENERIC=y
> > CONFIG_KASAN_INLINE=y
> > CONFIG_KASAN_STACK=y
> >
> > CONFIG_CXL_BUS=m
> > CONFIG_CXL_PCI=m
> > CONFIG_CXL_MEM_RAW_COMMANDS=y
> > CONFIG_CXL_ACPI=m
> > CONFIG_CXL_PMEM=m
> > CONFIG_CXL_MEM=m
> > CONFIG_CXL_PORT=y
> > CONFIG_CXL_SUSPEND=y
> > CONFIG_CXL_REGION_INVALIDATION_TEST=y
> > CONFIG_NVDIMM_SECURITY_TEST=y
> > "
> >
> > Dmesg info:
> > "
> > [   24.413405] ==================================================================
> > [   24.416332] BUG: KASAN: slab-out-of-bounds in cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> > [   24.419291] Read of size 1 at addr ff110000676014f8 by task (udev-worker)/676[   24.424403] CPU: 2 PID: 676 Comm: (udev-worker) Tainted: G           O     N 6.10.0-qemucxl #1
> > [   24.427232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
> > [   24.430089] Call Trace:
> > [   24.432534]  <TASK>
> > [   24.434891]  dump_stack_lvl+0xea/0x150
> > [   24.438131]  print_report+0xce/0x610
> > [   24.440498]  ? cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> > [   24.443129]  ? kasan_complete_mode_report_info+0x40/0x200
> > [   24.445602]  ? cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> > [   24.448221]  kasan_report+0xcc/0x110
> > [   24.450527]  ? cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> > [   24.453140]  __asan_report_load1_noabort+0x18/0x20
> > [   24.455455]  cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> > [   24.457986]  cxl_mem_probe+0x49b/0xaa0 [cxl_mem]
> > [   24.460285]  ? __pfx_cxl_mem_probe+0x10/0x10 [cxl_mem]
> > [   24.462592]  ? sysfs_create_link+0x75/0xd0
> > [   24.464775]  cxl_bus_probe+0x5e/0xc0 [cxl_core]
> > [   24.467153]  ? __pfx_cxl_bus_probe+0x10/0x10 [cxl_core]
> > [   24.469632]  really_probe+0x27c/0xac0
> > [   24.471750]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> > [   24.474087]  __driver_probe_device+0x1f3/0x460
> >
> Hi Pengfei,
> 
> I can reproduce it on my environment with your configuration. I confirm the bug is the same as the bug I hit recently, I have sent out a patch for review, the link is https://lore.kernel.org/linux-cxl/20240806041547.1958787-1-ming4.li@intel.com/T/#u
> 
> the root cause is that cxl-test module creates an RCH topology, and using platform_device to create RCH downstream port in the RCH topology. There is a wrong pci_host_bridge got from to_pci_host_bridge(dport->dport_dev) in cxl_setup_parent_dport().
> 

Thanks for your patch, I verified that this issue was fixed by your patch
based on v6.10.

Fixed dmesg is attached in link: https://bugzilla.kernel.org/show_bug.cgi?id=219127

Thanks!
