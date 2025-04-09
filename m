Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A721D00A
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242014; cv=fail; b=NEOSqGenEJ0Y/o2s+6Ad6Ycfptt/3bZXkylBPu26RLKmpYZKXDjvaofF1v45C9DS1gdTLwCmb2hlV6PfGO+B8fiD+SQUc0cMC5nnxrSgyJ539rvzJq9ZkLocrrEhNv6KKyfLS6UGpXSv98aylDUItRHpNrfChkeMigqKXzelhN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242014; c=relaxed/simple;
	bh=RJK6SssCVtvqsmAEtpGlj6hsHI3sbb5h93rdEEc/xKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZGYH89f2HLh6GZsrX0gRvZ1alQvOQZFDH0CCXy9y1dvWhT/AiSmy0jsiC0PB7tcPdyRunF5l/ruOu/sHa3fpQ3yJRyCVFJz2jpJBIRCgZdje2B/OszOzwBGUOozau+J6+W+t7yJRDVnY/sjTZ9MlGoaCLW9OolSA7APTwW1TGRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PewhDb3F; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PewhDb3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744242013; x=1775778013;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RJK6SssCVtvqsmAEtpGlj6hsHI3sbb5h93rdEEc/xKU=;
  b=PewhDb3Fe9I+f5FXzhxAtDZ3gwW/bk4i7mtjKmbh4+oC6AFOf0OcNZBE
   iXo+MJqttL0xF1ke3c2BabJGgq5TguSILpUfDCK1nuMlZ7efAvLyVHezG
   OdbyJCOvfGO7VK70cC+6AkJJpUM5VLSv6iMzW1f2u88e/Ok2B68M09Fww
   ++S14btKu94DQiNWUzfwA6bSE13VIGHGj3v9uOO+rC/tVvC4ObUgJCEZT
   c1+MQysUU/CYD8M57ieOaRIo8Jv3/u/TQnlmftrldWrTUkS9++DplvfAM
   owRk0t2/1wg3X9pud11FmvI1cCu3qU141By9VBPTPMZRCEJE1mU2MV+ht
   A==;
X-CSE-ConnectionGUID: /8In7N6xT76yZxDglFf13g==
X-CSE-MsgGUID: /svzVI8USx639I4NtTVd5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56723347"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56723347"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 16:40:11 -0700
X-CSE-ConnectionGUID: DVwl+c18SaehszcuD9/dvg==
X-CSE-MsgGUID: DAPNWc3dS5qPclNx0Xwplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128691429"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 16:40:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 16:40:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 16:40:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 16:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/38nyqNHzlQWmsaIpA8+3z9k9Mrnk18tASwikPNoOD7/MtBbBPw6qzx4B5m6f7Er/nmeW074Hv5ay12sbV7Ov7nzfmEerYC/PjnE+0zASxPuldTuY01owFpMaI0dazFmXzbh6iqY3ACkKBzzcdsaGWsCQwB/mnF9FAdAPouB8jYSrF1SRF+UV4k4QvAMsVQe+BAeronKOCLIQSYtFBa7N0FA7iuGr6uP/KSfJigzLzwGfCGp2Ukid14qrMqATO1FHaVDzMfe9KVAsI7pgQPW/gOeZ7MHFDX6qKGiGLY2QUi5+J9bD5YRGJFswgR5HJOjo7P/uP6lCJ0W4B81TpuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bJNNDHHAnVdlEjKd9OIV1CwyTLp0KerdhpgEElaWpg=;
 b=jLukscUc+uXI1pehkBR8lQdSlSzf2kH4uoYe05xjnivjCQ1wWqW44yrq0daGYQAD4QGnFfsuDbN/TWXCHdthqpaHPb5W4yxgYcFo7Xx+h+HDw6cbZ5MUJ+LmEG/nztQsLhlLs/GNLM2o9Cf7inZtyWgvoP+GbQktdTYhloqCe+PJ1NyqauXuZISODyP38LfU9Eq9H6nO+Q3BPMzGMIo5zE+GEbbpI62TWRyXTwc1E9Dj07GQNsjBvFB17PY4Ilap5x/K++EyLX+gPt6CSigQSOCGO8Bsn8MyICv5b6ECU3hQRtYOPAy9QD81hfjiHUjs3T5cJW8vPjR+fGD9paUNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7254.namprd11.prod.outlook.com (2603:10b6:8:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 23:39:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 23:39:27 +0000
Date: Wed, 9 Apr 2025 16:39:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <alison.schofield@intel.com>
Subject: Re: [NDCTL PATCH v4 2/3] cxl: Enumerate major/minor of FWCTL char
 device
Message-ID: <67f7052dd5353_71fe29498@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250218230116.2689627-1-dave.jiang@intel.com>
 <20250218230116.2689627-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218230116.2689627-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 1424e2f6-d8ab-4f6d-4048-08dd77bfc47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UHS1fyzKeBLEjGXyTlQpj4t3SK9UA8VAVEt1wgyboRiMxn2Csh9qpz7Fbbc8?=
 =?us-ascii?Q?VkDL/o7eutkuf06bX/ZeunIjyNBYLtDw9Xp0XgqOifSM8uzK8daLDNWEuWQY?=
 =?us-ascii?Q?HpI/LIVTUJ8gEKwwd7TvudfY9aE+Og8o/ujse30MaXoWWTwgHfQL/QUOvPZO?=
 =?us-ascii?Q?wYHhzrCjnTMdOqwkRVC0W8xka4BgWJ8DRo3csDRUN2ppNtxy4TweJZu3qkwQ?=
 =?us-ascii?Q?9KN+93vlwkFfELfcLXSOWpZ7MmcQYsomMoX9EYvvI1wZtJd+71JK8HK6jd5T?=
 =?us-ascii?Q?cDUXHsv0aSLdgnT+t3t0lQ7fVLwQ2ei43Z1JxtfFh943anvesw7bbu2RjxZM?=
 =?us-ascii?Q?jwvUMoaR24si7gKV9CzvZNu9OL+8oTNPIApajEfm9a09lvdBrDUT64gYmn61?=
 =?us-ascii?Q?bl0NvcTgqQl1b7xlJHSI7glh5HiW9KemBP9b4KZ4k+eN8SmK+1s4q05p5sH5?=
 =?us-ascii?Q?Ahb2TrApGn593XDOqGNfLPHgv8ALEQuOej5UG+yXvpmNF59Lgw+nDDE5tek8?=
 =?us-ascii?Q?ZEa/LwEO47jwTgSMwl/TLfWpReSMdN/EFkj6Zqa02HYOo3UYxEjNQvac1c3k?=
 =?us-ascii?Q?d3sGohEfRBIOJBdRjC978+CntpZfLPpvqPnkHt2+aragOpRgCID0cFVHeUEh?=
 =?us-ascii?Q?hawo6jKBnG8MCoeilKJzNa3oacVp/OtE06siaGr2gE4dbL90RJSlfWZ8ouHc?=
 =?us-ascii?Q?aLBxA6bfVCaty0tmbu8z/g/jElioAg0PAZUaDMrYJGfu/xbVp6pXnwJDNHXB?=
 =?us-ascii?Q?XYN+AleQpI+hHC00tFEw/MX4o36qsw4I0qW1khY51jXBznf5TA5K66AtgRXo?=
 =?us-ascii?Q?xcXmLj/6Q4GqDd4jo8LZ+EdFsimXMJR54SXdyQ57zTFNduWnhFc4K+x+8fmF?=
 =?us-ascii?Q?zAsWcrS2S6X0kkGvIiqO++89kb9pGltDNgNoAN5nzQ7o1Go3+yk4foFWQBbL?=
 =?us-ascii?Q?m7vtBg5PFPd8dLjiMBS3h3r6F8nGz41MmsVMi2hawcS4tmEQQw4yBcNq6Ire?=
 =?us-ascii?Q?qgtOgHgrgArB5Co46SMfAdEDL5Tg0t/n02O0jG0WvMpjgxrCm5tyupzRGod3?=
 =?us-ascii?Q?fOaPrs9feLMHXpGzjVt3lqLdxqYmseNhv74RKOg3TupvhbFNVvXnk48to+OE?=
 =?us-ascii?Q?6cky5j0Qegk1B2PGq+6evsyFO9ySwiclgivE9Y4usTEndAAa7fIe72wo7qC8?=
 =?us-ascii?Q?qDlhL42eAAe+uFX5v2KV1pQUwlSScenaAxpmeX1DUspGJHVEdCAWsNtrA2i6?=
 =?us-ascii?Q?NMJhZR32HX4Hplp5gPKUkW4nmTC8lsqGVUm8tLW7hdZjw4QSFZ3Thh3U0DDE?=
 =?us-ascii?Q?YNRtZuCwwGZSFhZC050BBeisPT4WiLC6CzM2npU21uzEVSr7i4PHmT+gD1Lk?=
 =?us-ascii?Q?Mjcq0liNUy2cdNaBIiCSFeJT0H1L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdFiSRd4LYtmg0kocWcgo5fUPXl4vq+r/qHtBeBxohywov9ge+Yokp+XrAcm?=
 =?us-ascii?Q?LigL+eioUWsvGAtIBkFlmelaeuADd6jkXcLNjCCc9ziidrzAeUxlPo5cNn6X?=
 =?us-ascii?Q?Gu0STY+IcnLPtX8rCmuvuczxbTRZx0nptOWmLUqx2C170x8BW+h875U2tOeO?=
 =?us-ascii?Q?OIzOMenVRprtEefNsvFg/7GtLq/gpBZpmv4CfhSctT5l38+JDS7sRcEfLUyH?=
 =?us-ascii?Q?7NmEKQJch1WWGwlyn/djNprocX4DwtaFkuUXOjXGkeiymgI5JN/5gUAbUEPC?=
 =?us-ascii?Q?DpcEyxr3CAjwcVrIb1pr8F/dAfQ3yGJ9pnJeVBe1a5fAdJ4ceSXh1m75owo1?=
 =?us-ascii?Q?3j8eOvfnxcMwAXmBu6GONwG0HljNSeoWyLObymIcWCgqzUpV89f5637veZRJ?=
 =?us-ascii?Q?6ZU8adXF0MP/fUrXLRLRVy8zKIBlK6QLl6LkB/Pp4k9xDgPPanhy3ctyVQ0H?=
 =?us-ascii?Q?kUTnnS3yCA+rbg8ZmcfFYfX40HjGB7FxbCLx3P8IfN8JvFxrJc2++9SIliwN?=
 =?us-ascii?Q?yGuZUGlqDk4P9jXy5m34bE+5a26M6fbP0uYrR7JhAM674px0G3ld161znM+p?=
 =?us-ascii?Q?E3U6eDxYz1nzlAQwWYKV8W6JlGoGTArqdQagGMjm2Gh0KNeSsZSFWK5dFzyI?=
 =?us-ascii?Q?M3YUSXuXbx/6HkdOs7Ln8c+ksES8aDmjJkTZwjPmiteQg3ClAoR1XkmaAy1o?=
 =?us-ascii?Q?JA4/5o38NwFrBfWtCJDzqhUOGDwsekQobhDQi65OuuIhVfHAI9rKQdwvRQkw?=
 =?us-ascii?Q?I2kvnnypU04Uko1657jvdG2z5JcKcp8X3A3J6EcDLznuEhzJXwT67pKOVuO7?=
 =?us-ascii?Q?n9gaXNi/VF/HLi9y/rslLy6wolB6PyX0UU79nTWfsdRTwywvjhh8oRxZ9FIL?=
 =?us-ascii?Q?ghYqFG6I1uZ9M8W8XxG4hPpnK8TmFXsFm5BRv1OtNoNtnSSuidMNKdE/0Ckl?=
 =?us-ascii?Q?g6U99ER88iMDlJ8b12lR3fIBLqPHO0WAkF3s8NtPHryM7eq3mk1tf9ZzBkyR?=
 =?us-ascii?Q?yRlVQF0WjLlXJbnw8WAwip8tXvv75Q5ZGpEPbC+e7xfKHxCQ9C43BBRSzsxi?=
 =?us-ascii?Q?0NyXEQF5tcjg3ffMXh8MEnFeT8CazHh56D1kl7AZWfvgrxJG5c9vEUenIEMN?=
 =?us-ascii?Q?whaV7pHbcJx41RkySvkdaVgj5LGnRjT7ibNuDDDslLsxIzji+UAq5g/QbWyE?=
 =?us-ascii?Q?LFAVff299URih/jkAabNcuZaBVSPAOpZO4v+D0+CEXAkovJL3IV0D439kTcW?=
 =?us-ascii?Q?cPfJOkJSvYgW9o337KQMP9DFlN7mrut7zJATkr2cPzo5doQsFaN+LGxDFYw3?=
 =?us-ascii?Q?d4KHfUc6uD0+Y49Xvo40QsnfcW4SB3QH5sLS8PqcdBHKT4NHRSV3VRNycT43?=
 =?us-ascii?Q?hu8uhEuAthMXEllejXo+Kzl4nz3PDiXyFnEJJY0bX/ROHvn9uSB9rzf5fLVI?=
 =?us-ascii?Q?RFsxh/g0SRbciScvPxS5ZXr0rbSA8Avf47gVijY+qQhmesgoBFIWt0IrbcT8?=
 =?us-ascii?Q?vU4nNtMJghOm9reKn+3AYYIaJjzJS9FBICMUQ7wn1WIzEKu67Lg2HPG/B5S2?=
 =?us-ascii?Q?xAh2IOQPAVbxP3INuZNGBpc83k1iLidfIqqzkKSZX888Bzzn8oX1Uq5lnKZ3?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1424e2f6-d8ab-4f6d-4048-08dd77bfc47b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:39:27.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eJH1QOZ59NdRc7up9b860sIIoxg7dieCQ5NPWDiiSdaK+AyHYPavnPnqQP1L+A1qdtiRQOl9F+iKUTONgeofyPyn55ga2q8NU2MaAHXqJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7254
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add major/minor discovery for the FWCTL character device that is associated
> with supprting CXL Features under the cxl_memdev. Add libcxl API functions
> to retrieve the major and minor of the FWCTL character device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index b6cd910e9335..676bf1573487 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -37,6 +37,7 @@ enum cxl_fwl_loading {
>  struct cxl_endpoint;
>  struct cxl_memdev {
>  	int id, major, minor;
> +	int fwctl_major, fwctl_minor;

Unlike daxctl_dev_get_{major,minor}() which need a valid daxctl_dev,
there is no guarantee that a memdev has a fwctl capability. So I would
prefer that the helper functions are:

int cxl_fwctl_get_major(const struct cxl_fwctl *)
int cxl_fwctl_get_minor(const struct cxl_fwctl *)
struct cxl_fwctl *cxl_memdev_get_fwctl(struct cxl_memdev *)

...where obtaining that 'struct cxl_fwctl' gives you a chance to return
NULL and prevent non-sensical cxl_memdev_get_fwctl_major() against a
memdev that does not have an active fwctl portal.

It also lets you build other cxl_fwctl helper functionality around that
object.
