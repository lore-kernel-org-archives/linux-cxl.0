Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9F213E83
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841652; cv=fail; b=ClGhVIi1XPf2IdT/HOECd7vVMue5KMc+xwiAPaQ2r3HUvP5Py9CxonfQu38Ch4+kEmSdOxeiBoFvV4LOLDuWaciXl79U33heNuoLEc6L3g/KEKZeiiZ2blpPKaZE0jSClPL9ESt9UbDZrlPijI/xMyzGLhyC+vZk4QEYHL+q6nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841652; c=relaxed/simple;
	bh=4KO7ay2yEdIFid6BWCkrZwed/k8TbUM44M6IXn48Mjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D26J0ADdyxMVFKNfnsW7ZyImXjyeya8OjqwPnA1xTER6makK+OWzQqW+7Jx4+LQXl+uHvqXHBBH5qOztZbPcPDs6agna9zBovwlII8TNfZ3QyhVA+QF8ToYdy5f+Va/uL9rC8h1jd/fGf1SbzqhNKCOUc5VbfScswk9VPSOyzqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5wQVRHP; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5wQVRHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747841651; x=1779377651;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4KO7ay2yEdIFid6BWCkrZwed/k8TbUM44M6IXn48Mjk=;
  b=H5wQVRHP3MnGXE7okYKf5nZJFEcbEn5c7D5F1U9HZLzTfHWI7d8JB2Xj
   rhXY/MqKYkZQheUV9Tm2yhNVXvOuzqbIfP2pzIGQi9XNNTQ9pCdNkvJJ5
   oOpkbbqHgTfQjkxSKfAQ6CyrzoF3kQE0IXdqhh8jIi7b2DZjJVorbTApO
   5QychrYbd8I9aMBlFHA286dtgs50+jy3aPQxVF3AB582HBX13WARQIj1P
   XgENbrUpFW1XfwXjOI4nhFItus8wbCYVSMvZZIPxUuWABe5iYo2tCZBbp
   y2t6SqQ1QwZZQpGu4g+zymhQ3WRBlrdvAh42Uq0uv7y4bIqY8LOhC7Ulj
   A==;
X-CSE-ConnectionGUID: R7lSrOxzQQOXVXTM5c4fTg==
X-CSE-MsgGUID: yThzBy31QDe8DsZI9RhMTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="61232676"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="61232676"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:34:10 -0700
X-CSE-ConnectionGUID: wuZT7M/8Tgu6BuBaT6DFhg==
X-CSE-MsgGUID: ZiqMGNuOQDCd49Fdm8mzlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140025219"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:34:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 08:34:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 08:34:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 08:34:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joJrmQ/WsahgXTKNVln1KkeSEPE1K//vJlySsTLEjFHOvBvMm6GpAkQJXNIT3/nVBxTMeEXrp0qGTyqF0C9ZT6It3OVdbjvi65FSOgBt0RwrafYKZSych74Huw1cMVesMucw4jZG1kMJwTsCf2Iy28MenmV2uSnF2LxMQnWsIoZjQfq0x+rChv9SnNwUui8n1ifuaEBxcnHqRjYUx+Ie33zMKz2sJ/vOgUm3QkEhLrJ1inozq7k2RsgF73FISFnEeWxLANZwS+yChDktYxM6eZRKbTXaohSO4zV8NwnIdMpywQE0T09lYf50kMDyES/qMunM8nQFmXlNU7s68Pk4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5mmn3SGBF7iSs9MjnFVZ8vX8FJEzMjmSrxbs/Ekgd8=;
 b=xiW8YNm7KoAtnlE36x1ZpAVO6E6hn0VjXxwyBtCpTVDEreBKVddTpr4JZIhzl4uVZ6/TVTjjdScPTW0Qc0eo1j6nRtO0NDykVggzyTG00RiJYXj9ah56H4HmonEw7sqdI6pFTwJd/H+4kOtMu8E87XJXoa4DzDUuWu3qmri7rUku5jDr3UmlA0VWdPMI1FmAjH+ex3A9R4eKe2ci/AZmrAP6ADRgofBD0VQIKAbqiPcfM9lgWsFp/JlqHzXSiW/GNddsecVQ6O83M05b/ANDFS+csv15UjylDtVSkIH/kAtSDigCgugxdgj5cmZ/JadTKK/puyWnxnThNo92AZjy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SJ2PR11MB7597.namprd11.prod.outlook.com (2603:10b6:a03:4c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 15:33:32 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 15:33:32 +0000
Date: Wed, 21 May 2025 08:33:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: Internal error: Oops: 0000000096000044 [#11]  SMP
Message-ID: <aC3ySRMnHdKQOLF7@aschofie-mobl2.lan>
References: <aC2RKceK4HqYEQo/@vm4>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aC2RKceK4HqYEQo/@vm4>
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SJ2PR11MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d8f011-1865-4b08-d53b-08dd987cd7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VBkAAhCc5aQ2ZaPhHT4zWnT2l9NEz+i4x4GlVjyigJAl8XdAnci/hZhWAMBL?=
 =?us-ascii?Q?Isf+p5jTvFdtzqv24J8gv4W6p9+jk0KWAvSATv7jUoFJdltpIXrVsKyxZMPG?=
 =?us-ascii?Q?RR34rM8RRi25atqekgZ2Awb0dvAqeZecODmWxT2oDammQuKVyajNa2ZWixmg?=
 =?us-ascii?Q?mxLQyJMxnMp+grKEHdWMfK9dxvl3/lQhOFv+tphrZUhhxdbBvFDaZJn2BASQ?=
 =?us-ascii?Q?f7/2CD2Z6t7DQrkaDYJzmhDlT6RGuo0hhyC00CwW/mK99vrAuaFqVTAtvDz1?=
 =?us-ascii?Q?VsxMK/XDYUOguzNrKGKUuts9K3F1RuOdV2pfM6PT9CBR1q1jm64MSkuMQ8vJ?=
 =?us-ascii?Q?7Qu1JtTbROVpv7O9JXY1ode+1ezYD+zPJYO5y+XA6VgDQbCk89PzM1uXUtnm?=
 =?us-ascii?Q?LbS/1xt4cJIhAtnFtWiVKxFS3tO7+CY1RZqkNiiaekp3Xmuz2YHEbDcmlo4T?=
 =?us-ascii?Q?0uxj9/86rM7LMajeYXlILW4+tzAMPnPqvODhCPYolzfa3nfdKVFrVTcmz51B?=
 =?us-ascii?Q?T3Rq9PIiHDixxhcoVM6FfHImI5DdnfJhfUPo2GkXbROI9V35UZkP8AQcR2rC?=
 =?us-ascii?Q?Uczb22W0EF8cDDBzfLerZ8u6jQkVgpeGguomrM4yQYGHtLW0kd7nPYrIr5l6?=
 =?us-ascii?Q?KLHpUR2+LyXVGRWOmjJ3kmqRSeqL1ibfG+toiQ6YOhWRgRGnSF5jM0NXR7NM?=
 =?us-ascii?Q?kn24w7YRL2ff/QbkBSO5bmZgicb2G4nDi1dBDEdjZDrjR6KUF01B5HWJsDP2?=
 =?us-ascii?Q?FuU+pGRaXDkEP2uhSqdAwWSom6q0+LKXH4Wb8mX9VGMqmdrm+FBJ/K1nE99L?=
 =?us-ascii?Q?dE/aZhYOkrQtHxxxy+13J5bNX28DxeuKAKQj/DXnBAoQQz8C3HO6KheQJRUU?=
 =?us-ascii?Q?eC7Vwjw+zvn6H6utwqmWCTSpQ8JsDx7aashLlL6rTAdao6ch6PEXuEiQae0n?=
 =?us-ascii?Q?crEBOmYarPRbqtZrqROYtusByXtzu28xk3gc/fKQirNADwsklDI4elnR3muf?=
 =?us-ascii?Q?RqhqpKV806llaefnQifJPFYw0n0X4dkxXwO3d/s5C7+G4p8+X4rwnQVtogZW?=
 =?us-ascii?Q?8ZYx/+WelVygvAb36lmqrHWzkyaLS6Cprd7JftZbhZ1TSS89tMT2+iWMBZuS?=
 =?us-ascii?Q?JrmGmqondyOrmjC34b+HEwoMf5WSbyQzc5JeagmpPSGtseZ7MIxaUJpH24li?=
 =?us-ascii?Q?J+Rf+ZSbInUpATHlC6yRi4XhWPiS9r93jC6kAtJajUDwiI4mAuCcg/nd6S41?=
 =?us-ascii?Q?xzGb4vDv5rR3gtxbk/KNmSo8G1ZSIzMKZpzj46BO5RunNxrEIz6ZC8DURl43?=
 =?us-ascii?Q?Q+C4ULWKB50BOw1upyMeozIHwsG9hEil2TwttGUBRT9/RG4MUcPPQHXPbjky?=
 =?us-ascii?Q?i7KEbs7xaMh36mqqYM72DgCG21g/xA/uDrakY8AJuLXdavDa1EoIL/Npb/65?=
 =?us-ascii?Q?HtsH2K3E5VU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6IYRYP0wcGFbkUaO4ZTzPIdk0mIIs8iqfc9YCmMa+wiKDeNgPvpKi5gVJ62b?=
 =?us-ascii?Q?PbSlhdZExlVodh/RQCMJ55ufA3g6rYu+BzR6XysZ0tZUiy7CeW1bbmvrP1QI?=
 =?us-ascii?Q?D9ltehcqb7uTHUazxy3R7DEUzToE1QjkepNbMBuCithNZfIT1Y+HvjWwrUnW?=
 =?us-ascii?Q?jjHchme7fDdh1r+MP3LcQ50X7TM/wR0s5t0MtpvUh84b7B0+GSlHLJFGOvkM?=
 =?us-ascii?Q?4CUBA1akRNKCUSONzA2vqhMbOB+KH34OV8zHdtj0mfuiSmsp1qs6Z9cr02T/?=
 =?us-ascii?Q?pKygQkFXpPDt1EvePMO9s1xSiI40Tp/glY9QE+pEJgIGi+wXXO9aSsIIutdg?=
 =?us-ascii?Q?/BHdFxXC44jcgSYxLfzAlBzWCfEBziwK9UmXsBfx3TKfGtwSHscGi2cNg6gT?=
 =?us-ascii?Q?hHG85rNoRuhGsGIAU8OfJQEVj7i4LGUZ5ur189lohFgIEr+SxtS3r5b9SAZG?=
 =?us-ascii?Q?iVDPyX0eZi3uoOXo65aDziIO0wX9k4H+ZtlAZ2Y5p+014SlJBAD/5MEarucD?=
 =?us-ascii?Q?S2qAkJQFD+M2T0Fzyb0V3Z5QH6H3C0z6KPB1VdcR4NHrSmrBOzsy3DAaRl1V?=
 =?us-ascii?Q?898crGRqTsNvKXi6e0iRughn3M8TgZYpqpYWjYtkFc/6ypdCR+VWpm0QuAsi?=
 =?us-ascii?Q?sUMMh71GM2V9yr11ufv7e9cA2bheF02FQ0Xxr52Rb2qszf3pk99/GQOpmu2/?=
 =?us-ascii?Q?OwlYctqHPYhQCsVGOVQ4H8RilBjqhmeJZZ5buhj+Rqi21WK5GhbWaStnrZTK?=
 =?us-ascii?Q?NupmxIjvavZalSy48gNXCNouj48aKBQw0x4YUfmTOv6ZYYNeGMGLiB+KZfjC?=
 =?us-ascii?Q?t12uHnCMfmh2lm57ZZd1ckT5ZTplVBEi2a/jA2N2AxvMyJJoUUfN4pzJPpzC?=
 =?us-ascii?Q?n8Oj1b6H6bdR2MCDCo1yn8cSe14hSjGV+CQ1K2cTCFLqns3VgDuxvM7Nvqxb?=
 =?us-ascii?Q?mEEi3xBq7IaBeojX1o5tXTnexlMDwVyuRvRbYPvUv5PimNi2d6rt01Zg1WWg?=
 =?us-ascii?Q?FvdvS/BHoo3ZfgOuQP8KjMVGvK3WIGSUbbH9GLgl1MPc6BoA6v3olATYwQhR?=
 =?us-ascii?Q?fcWyHSEHveLj4oqIa4/DwxgZE1H6BATOelfq906r2Z9VZ7GpwlbOdAnkL0K/?=
 =?us-ascii?Q?d+6ws1NsnGNjraupCguQRH/9w59WvitvCCEmNa9olMS/nNxLvj9pynBzvFAf?=
 =?us-ascii?Q?RkneOAPKpxRa2jsALMK4drLpxTdHRHN2COeFfiGqs7UqCf8IIueKdj3rlpOU?=
 =?us-ascii?Q?lnPhddqwFFfdLjHP2l8i6s/aEz2VdXH37UEdRcLRrNSd0d484l9Mf0QMewlt?=
 =?us-ascii?Q?gkOL2KqmZpYj2gA1AbaRLW3y/ANVmcmo7YtauI9mWMEq/ifmuwH6Pd19eTPK?=
 =?us-ascii?Q?6OK3rkNXUYVBZ1TzpwANRPDn4T2m0PG8IcqD0tfk2a3Thm6s4H+Q6xz6vq2Y?=
 =?us-ascii?Q?SbVrI2S3CACAP1sIktxzIlfmxsRW3kfpCXNPNK9Urw2ikzEdDYRO/oBzCiQZ?=
 =?us-ascii?Q?H8KYBz5mcHer/s7D6zeZ2QePwEXgolacpKoKtbliVxOmPDl2LsVIisAOz6na?=
 =?us-ascii?Q?Nm7FBIxUBRIsTIulfKxM4lkDI5A1oRSbrrqFk0a8yuMAV1f+Gy+j59wjkZyN?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d8f011-1865-4b08-d53b-08dd987cd7d9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:33:32.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFFbyJdeFGlbntckVlI/B4eBNSaRCKf24vesXpl6LGgpihcnvyPBn6l+MWFu/E+pVaiDUl7ICM0xkHg9cemeqxczu5bOLbr1WKFXmv//pWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7597
X-OriginatorOrg: intel.com

On Wed, May 21, 2025 at 05:39:05PM +0900, Itaru Kitayama wrote:
> Hi,
> On arm64/virt QEMU, the cxl/next (as of today) kernel prints out Internal errors:

How do you repro this?  Is it repeating on each run of cxl-events.sh for
you?  Any repro info is useful. I've seen once but have not been able to 
repro myself. Since I saw in March I'm thinking not new to cxl/next.

> 
> [   80.968299] [     T48] Internal error: Oops: 0000000096000044 [#11]
> SMP
> [   80.989250] [     T48] Modules linked in: cxl_mock_mem(O) cfg80211
> rfkill cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O)
> cxl_mock(O) libnvdimm encrypted_keys trusted caam_jr caam asn1_encoder
> caamhash_desc caamalg_desc error crypto_engine authenc libdes fuse drm
> backlight ip_tables x_tables sm3_ce sm3 sha3_ce sha512_ce sha512_arm64
> cxl_core(O) fwctl btrfs blake2b_generic xor xor_neon raid6_pq
> zstd_compress ipv6
> [   80.992210] [     T48] CPU: 1 UID: 0 PID: 48 Comm: kworker/u8:2
> Tainted: G      D    O        6.15.0-rc4-00040-g128ad8fa385b #40 PREEMPT
> [   80.992791] [     T48] Tainted: [D]=DIE, [O]=OOT_MODULE
> [   80.993039] [     T48] Hardware name: QEMU QEMU Virtual Machine, BIOS
> 2025.02-3ubuntu2 04/04/2025
> [   80.993400] [     T48] Workqueue: async async_run_entry_fn
> [   80.994718] [     T48] pstate: 61402005 (nZCv daif +PAN -UAO -TCO
> +DIT -SSBS BTYPE=--)
> [   80.995329] [     T48] pc : cxl_mock_mbox_send+0xec/0x12c0
> [cxl_mock_mem]
> [   80.995691] [     T48] lr : cxl_internal_send_cmd+0x40/0x104
> [cxl_core]
> [   80.996189] [     T48] sp : ffff800080d0b9f0
> [   80.996380] [     T48] x29: ffff800080d0ba70 x28: fff0000008dd2410
> x27: fff00000088fb390
> [   80.996714] [     T48] x26: ffff800080d0bb07 x25: 0000000000000100
> x24: 0000000000000003
> [   80.997135] [     T48] x23: 0000000000000020 x22: fff0000008dd2410
> x21: 0000000000000002
> [   80.998119] [     T48] x20: fff00000088fb080 x19: ffff800080d0bb08
> x18: 00000000ffffffff
> [   80.998419] [     T48] x17: 0000000000000000 x16: ffffa8d169128748
> x15: ffff800080d0b5ad
> [   80.999243] [     T48] x14: ffff800080d0b400 x13: ffff800080d0b5b8
> x12: fff000006f7a0000
> [   81.000519] [     T48] x11: 0000000000000058 x10: 0000000000000018 x9
> : fff000006f7a0000
> [   81.001337] [     T48] x8 : ffff800080d0bb48 x7 : fff0000074fa0000 x6
> : fff0000074fa0000
> [   81.002497] [     T48] x5 : fff000007f937508 x4 : 0000000000000001 x3
> : 0000000000001000
> [   81.003993] [     T48] x2 : 0000000000001000 x1 : 0000000000000000 x0
> : 0000000000000088
> [   81.004223] [     T48] Call trace:
> [   81.004795] [     T48]  cxl_mock_mbox_send+0xec/0x12c0 [cxl_mock_mem]
> (P)
> [   81.005136] [     T48]  cxl_internal_send_cmd+0x40/0x104 [cxl_core]
> [   81.005520] [     T48]  cxl_mem_get_records_log+0xbc/0x198 [cxl_core]
> [   81.006042] [     T48]  cxl_mem_get_event_records+0xb0/0xc0
> [cxl_core]
> [   81.006246] [     T48]  cxl_mock_mem_probe+0x568/0x6f0 [cxl_mock_mem]
> [   81.006417] [     T48]  platform_probe+0x68/0xd8
> [   81.008340] [     T48]  really_probe+0xc0/0x39c
> [   81.008885] [     T48]  __driver_probe_device+0xd0/0x14c
> [   81.009539] [     T48]  driver_probe_device+0x3c/0x120
> [   81.010239] [     T48]  __driver_attach_async_helper+0x50/0xec
> [   81.011130] [     T48]  async_run_entry_fn+0x34/0x14c
> [   81.011276] [     T48]  process_one_work+0x148/0x284
> [   81.011420] [     T48]  worker_thread+0x2c4/0x3e0
> [   81.011552] [     T48]  kthread+0x12c/0x204
> [   81.011693] [     T48]  ret_from_fork+0x10/0x20
> [   81.011840] [     T48] Code: 54001b28 a90c6bf9 52801100 f9400a61
> (a9007c3f)
> [   81.013772] [     T48] ---[ end trace 0000000000000000 ]---
> 
> How serious is this?
> 
> Thanks,
> Itaru.
> 
