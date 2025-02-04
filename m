Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AC7DA6D
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738633454; cv=fail; b=DJ0Qf0oeF65Dwvg1qyM2+n8iraDEF3przHLvNiabykzpaydfqtvp6Ze9hpbWmZ3nM8PRhJ5c/2XQ0h9fvEVuFNj5RfYd6Nn4mih/p2aJMyq5n0Yev7FHJHac48djT37lim8aTYjfJeaBzoE7NS8IFo9CefNrYuGDjX8ocWy1RXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738633454; c=relaxed/simple;
	bh=MlTfsSfFJm97X130GrRyNQK4JDdxqt7tEw1H2REx6qc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBq92/frDm0wa2PT6rW8hAKG4yEFf0c6HzBh/tr23gqdKh9FlDsn0TlKRPKzttnxJ9k7xF/kmJAjhG0fcHWRf98xoRm2CnjpXE0hWd9KQtyU04yC1Iii+TvayEotb95SYnOKP/f/jAnQyzTWK182XqVebDqjZM/WIAiQyXS4muA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwTGCsL5; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwTGCsL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738633452; x=1770169452;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MlTfsSfFJm97X130GrRyNQK4JDdxqt7tEw1H2REx6qc=;
  b=KwTGCsL53NSa8B5wyB8h1hHGNgMRQOnOWyKb+lbfBPya4Xt5Htitj39u
   CN64LA9gxu9wu/y3DqUahiR7EYYZghDsymgmibWcDloL4UvdsJFF9Q8xm
   6lzhC567H0cy8IDt+CvgzpFbBts9JXIctXFn+wiGoUI5X0pzSXcjJpA6T
   WDQ3mxKdOkFeOPCFow9aPljqcnu/XAbNnrhT1XVM62vJGG1cH8pXr+wRD
   +AMXU0Wwblts//1kTOGuS11gPddz3sOdpV0JIetx4eBZ1Jj2cY/54AVCD
   znzllE97hlHn4ov/+IsJgiEFUo4/q2cmYozh8PpqK3PuCvFClsI3v/o9r
   g==;
X-CSE-ConnectionGUID: XUkl5CqPRQ6L+7Lu1ihbrQ==
X-CSE-MsgGUID: xrd34Hi3RNO3hNgVk+gtaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56576814"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="56576814"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 17:44:11 -0800
X-CSE-ConnectionGUID: dQ6TmniNQK+ObXQjI9Kiyw==
X-CSE-MsgGUID: R/RCxjPbTeW32x+o3k6gMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="110409542"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2025 17:44:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 17:44:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 17:44:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 17:44:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sixkCG1jxVRyiVi0MDjX9hDEGLOAUSrku1RBb4bcbcex51I8umiDoTYqDv6oOScZ7OZHtB28u/xP6M6I2ULnAxXsQfJAom9unT2ygkk22rE6KNljXgSz8G0eao8paY0r84LoesnAlWeSnOOvIn0WHbPr/WS9yQrC7oa1av+wneTwD8mW/910u0XkRz9Iom/Xz279OhNM8ixGmSZz80wtX4c5xZ4L+q3HUXGtilEMaLHDTiY4eYeAc3qLhPNjGTXg2ZTJINkABXHdyIHDXnZTYY4KNFntSgseg3sndTif/QwmnudADP5BTLpOu1iK1BwyQvzSUYMf/mpM9UJ13aVbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQP6BGc4s7kGdfnJoONPe3K7gwKa5vj+sNXDwCRLR3c=;
 b=CAvB9jFgSiWKE1hjj8TonVl+PJDQHpw5NgrzMrQxspBEiw4fCvtLHYAhuY0DeD5OuHVunAp881LqZzMM3SXoNFCYKEiZaXfUo8swGhst3gum0bYL1jHkzev9MXTQ4ce0KvwLpAWpAZIPJ0Q0iAcEd0cMGvZB2f+HnTEej6ply86IUSP6TPZ5xrpLkvh7lrJYJIXR/k7hTlcsFgArl+1unKKYbWGb4RpPnOLGhuybAApzfn3MTGkf4PtOxWN8pAkN+3wvv6hz/bYZ6QjjqKvKQ4iEqqnoj73mPiB2ES8uaJUOafcY0wbQP9xZQh6VltZMkHhOC4Uaf0UJV2AST/XEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7684.namprd11.prod.outlook.com (2603:10b6:8:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 01:43:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 01:43:40 +0000
Date: Mon, 3 Feb 2025 17:43:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <67a170ca464e3_2d2c294d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-15-dave.jiang@intel.com>
 <6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
 <20250127105132.000072dd@huawei.com>
 <67982790e13d1_2d1e294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <20250128120138.0000599f@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250128120138.0000599f@huawei.com>
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 734af4e7-839d-49bb-6c4e-08dd44bd59f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1eeqPTB1TE30DOZ0q6ymYFhAlO6jNrw5yKPriwxAna2f5elDFJfxs3VAtEPM?=
 =?us-ascii?Q?Uif/z5NxGwb4hjCB5I/JbliluG5CpC5kmD1DdTo+mDxvSFaOrwEbvBJeMUru?=
 =?us-ascii?Q?YZvKYxwDf4ZTKMROXBYlJhjGbieasHuKjqA+rJtQ3MeEskfgXwUYlYUJRgre?=
 =?us-ascii?Q?msgu4vzM4vl73kdNAkHucSlp4/KZXsy4ArYJmDRSR8qG11C26EX7kpJkSBB3?=
 =?us-ascii?Q?DOzlZHVTMu/JuNtzLBHFXcIgd9r1E9L6auNCaBRvfxsezw5lzD9MagzYFJJl?=
 =?us-ascii?Q?vHfgwJRlYgCaWqXsxrSbNA3ZsorXZmoiTCdeOBvAYKCSSuo5FRzRRDtQXLvr?=
 =?us-ascii?Q?omMgBy+wOgmiycz81GxfBQTH8MqiFXAY6sKeKHjAP92SUg1EBLJDU7MGDkuW?=
 =?us-ascii?Q?FDoTYp48JKolzq8kmgZEItU1Oz/lWAlYBr5uZ5YKJNCotAk2e1rn6xalKW+7?=
 =?us-ascii?Q?EpIERAi5xE4/O+tq9vYdELrZWstcercw5zgqpj0jMqjWvOA4I6z2fep6rFEV?=
 =?us-ascii?Q?7MsKWUB0VNvKK3z98HnijPLg8rAcDUYFMOZuAYosmOVklEnt+n1pgIz+66o5?=
 =?us-ascii?Q?9jl+Ro7LBlhbE37ulu87wdR0WdmAkyUiYAC61lCuMWJRlQuNjTLnph3YGDCc?=
 =?us-ascii?Q?LTVBQCmAGX4nkwA5FUrvy0cEx1hvTM+JgfZ+vnDQJ4I6BuK+iNUwM7HpHKvK?=
 =?us-ascii?Q?m1xrrcyCtxrrp3G4xfLXA7g9aPxuRlhYas4tS6Nf44bSeiTPwYex85BUmuAd?=
 =?us-ascii?Q?eSbUsdx+5Dr9SNuY9lr9K5gCBOpSAM6bPa2TqhhS7tb+Bozr0GZvU/KfCCoW?=
 =?us-ascii?Q?WOxdJN1bTOlD0J+GwMXIJvr03V5v6aEeEp5Xj57qiWjg3zed3j3H+wL6EaIy?=
 =?us-ascii?Q?nhl9Cg8QyC1UD3h3kDGhxQVYG7o8RLTwJk8/qV/xqTqSMSao9bzv6xpACqt0?=
 =?us-ascii?Q?L8qtlHlNO8H9oEyCM8KjrB6JHpkzlgtKzPsxvmjdozQALdlnFNoTCGNdVxvE?=
 =?us-ascii?Q?QhyGZa5GRxWXBrBXHL1qhq7wx2ydb5sn5xZbaeC+JFJ3da+niLkePzh9KMIF?=
 =?us-ascii?Q?8pFkoZZ9VQqhJyrIUwSkktc0n8/PEw4WuzDgsjXjMhvgPXJz7HDElMDxD2nn?=
 =?us-ascii?Q?nJEweydJMjjcPkMxzVg2djS2hlP4/m6rglQhx3+AU5BbiE0r7iSwAyWYTX1Y?=
 =?us-ascii?Q?QrjfcjlOwxWMMh+RSbpP1MQvS3w4RwAAZ2CSJWKeaq6jDbVC9yophB2GUeSp?=
 =?us-ascii?Q?uv8wrVI+IdG80rcs+3UuBcaAp8lJ/oszbOd/MJC8qOuYOy5I3VdkTgbfgaru?=
 =?us-ascii?Q?7mjgBvcreQVdmMiQqne4Owdof9SIQMoXhP1F/+5eEhJ32kPRPPKCEPxeU6QR?=
 =?us-ascii?Q?BZFtYYwILCebnQjr1zdz/8gGYVvk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wJDtl5O70c5Jir0iG3WzlwMMeNY6Kxy/WHB9IL1mQZ4NJ+fanPXMj5RDQddU?=
 =?us-ascii?Q?K5T7Z0Im2jI9SvHPFL3x5RiM3Sa96NJC1KT3J3SkkqyBoO0QzbGoUVAU0NGH?=
 =?us-ascii?Q?toZ1PYKspQ94iWndxe2SpTTgwsWMNu/fmx2Zkc+P9tUU7Pjh+96ZEV2uZ/40?=
 =?us-ascii?Q?ZUDD7Dxcg4xMWhwQv08eHquKn9HscmpJmIe9EZWz6WDESiiC5/svjQ2e4C+5?=
 =?us-ascii?Q?DPGYdcEmmS4Zn9HEvsiDk+U+S05V/uJHPr6dBkuXBhPaBccjYFMNkFw2HoEj?=
 =?us-ascii?Q?CH6IarKFB1GHzrbmcq/86KSHW+ARym3Q3I8vJNaPsfcJiLnG5/SiNWmgXED8?=
 =?us-ascii?Q?7XLburOa1pHlWRTYCD1PeJUcyj4EO/A2N9C5+9neJ+gT8sE8Ya9ULHgst9Ee?=
 =?us-ascii?Q?fJ0UC/c/Mn2hvXWuGDU8ENzr6Dih3tSGcH6ysjCQGNXIV4aik0v1WwGJGlSy?=
 =?us-ascii?Q?+AkI9NjSzLSjdlC9ys2UdKGooINaTUoq0b/k9NoarT3oTwgwoFT7v3b+QrtY?=
 =?us-ascii?Q?Mhvlm+LULrkYu7pLUIOhdcr0almrd00epp4fXg++L7ogE272KhFL4QiJNFFf?=
 =?us-ascii?Q?OaRzkDcmIYMm50fLRrShmRG2I6XWxVYaqlTmSDUiYj9LdgCeNljDVr761IpS?=
 =?us-ascii?Q?UoS3jB2QPC9eaODQH4vmY8swsJkmwS5F9MUNnJdCfVuo6kRL8xS1XJ0O/4k6?=
 =?us-ascii?Q?KDIWtg0MZwW2nXN5ZKfHROvxVT27L3GGJXM3PE/Jk01FWCDvlT57VdaB7e6j?=
 =?us-ascii?Q?2e2ZzPMJNUyAWKiN8zh26Z91bVzqbK3yjTFSlmg+SIRb5KDU2DS0Fpfe60d2?=
 =?us-ascii?Q?8lxdaMX2UxIRrNntDno/Nqk0b26QY2bhnwt69+AvDgtLMdMI3/95chrg7jF6?=
 =?us-ascii?Q?3t0ovboC1ZTOXr8yybt/vRYJ8JCzyXEEMmOwFsXZTIyqmh34XFIjil933G7v?=
 =?us-ascii?Q?DMWK2tsi/np0zFtqOJcxahE0QHzodrmbHnTv1ZcQeG1zakpeevzdtVkmj/fv?=
 =?us-ascii?Q?JNtbi8acbAfzFprtMETbCWubO/dmQt4tGJV/6SsarEkZYKSTYHpBWl1yvPoY?=
 =?us-ascii?Q?LjAQ43yJKvO9iv2KkH1VxMF3Tkp5/vZh4goiG9EQyjb5AK+rWuOvHSrRTkQQ?=
 =?us-ascii?Q?779RlNxoF6wHR2wQpScWVzAVZL0zCaFRzDesj2E7WTQU4GxOvZ9m655Jf48w?=
 =?us-ascii?Q?kS3cEXWH/Uzu0hbNU+znHjGDlsmcCHNMb/tKn71W1F40GbPymm/uUC6fsujf?=
 =?us-ascii?Q?1WeZTr/64Ny2imCC9j1VoSqU/LtfX7ejvYP0NXk8Hu8/0vpTouAfYIH9UvyW?=
 =?us-ascii?Q?0eAJ04TRqeaCyLXPZ1e9yFrnCoaBVrYcuDhe4ACnUWXpqK3PMnjduwoGRe3n?=
 =?us-ascii?Q?D+S0UJJ5Z2OYdfesKA92aOfw34UxT5jDIDubQXlhPbTw7WgGZ2egFk2+/NnU?=
 =?us-ascii?Q?ZUysYjF5CJMTrpoCrwhpj2c1HyLwJfqYwQmgQOpB6V2ueYPtfuTPbBQI+rG0?=
 =?us-ascii?Q?zM52Fj8dkyOse5Skxlg+onE1H7yaOB1W9ZB1K1StkHBfU2sVGtS2pwd7dsC4?=
 =?us-ascii?Q?qcYHG+Kp4dub+XeR/UI5IO/Z4h2NQHGNNllH1OLM1YSbrMWX/4ALeO90LSpJ?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 734af4e7-839d-49bb-6c4e-08dd44bd59f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 01:43:40.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD2hfaWMJhr0k+BOIJGkERrrNl78cvIn4SNehrd8dEa0JTBiKR1hhZ8m4SI0fE7Vm/oo7ZJ3nhIzCbQ3qF1UV1Z2eL1fQdOD2kTc2gbnb4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7684
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > > > I think it's fine to let userspace see that exclusive features are
> > > > present, just need to return EBUSY if userspace actually tries to use
> > > > them.  
> > > 
> > > To me, a poke it and see interface is really ugly.  
> > 
> > That smells more like a matter of documentation. "Doctor it hurts when I
> > try to use the documented kernel-exclusive commands?"
> 
> To me this is a nasty interface design.
> If I'm writing a tool to enumerate what is exposed etc then it will
> have to poke every get command just to list if an interface is available.
> Hopefully none of them have side effects!

The kernel exclusive list is documented. How did this tool get written
in such a way to understand how to get data out of the interface but
without reading the documentation on how to consume that data?

> > > In many cases we could let "get" through even if the we are using the interface
> > > via some other kernel path and have it as exclusive.
> > > (I don't know how useful that is, but maybe it makes sense).
> > > 
> > > If we ever do that, the only way to discover if an interface is available
> > > will be to try the set interface.  Depending on design of feature
> > > that might have side effects - hopefully get never does!  
> > 
> > I would not put it past some future device to make that mistake.
> 
> True.  Though I'd be up for a quirk list to block such commands if we
> see them.  Can't deal with them until we know though.

True, I overlooked that Get Feature is documented as having no effects
and the only way to communicate an Effect is for the Set Feature
command.

> > > Alternatives:
> > > 1. Flag. Maybe add something that makes it discoverable if a feature is
> > >    in exclusive mode or not.  
> > 
> > I notice that all existing defined Features set a non-zero "Get Feature
> > Size" in their Supported Feature Entry. I would not say "no" to just
> > zero-ing out Get Feature Size as a hint that "you might get EBUSY due to
> > kernel exclusivity with this command", but that still feels like
> > overkill compared to documentation.
> 
> 'might' is no use. Would have to be definitely as otherwise userspace
> can't know the size that field conveyed.

Agree, and this falls back to "documentation by itself is sufficient".

> > > 2. Query type interface.  So a way to actually ask if a given feature is
> > >    usable.  
> > 
> > Not sure we really need a programmatic way to read the documentation.
> > 
> > The CXL_MEM_COMMAND_FLAG_EXCLUSIVE flag is for cases where the
> > exclusivity is transient. For these features the exclusivity is
> > permanent, and I hope we never need to cross that
> > transient-exclusivity-bridge for Features.
> 
> It's permanent today, but I can definitely see that not always being
> the case - we may well have future kernel does things in X fashion but
> for legacy support disable that CONFIG option. Not nice but definitely
> plausible.

Then we cross that bridge and build some new ABI to communicate
transient exclusivity, and that new state of the world will be
documented as to how to discover that new capability.

Something like a Linux specific feature that returns a list of transient
and permanently exclusive Features.

In the meantime no need to hide useful information from userspace.

> > > 3. What we have here.  To me the simplest solution is hide what we can't
> > >    be used.  
> > 
> > It is inconsistent that we do not do this for the other kernel exclusive
> > commands in userspace retreived Command Effects Log. The ABI here is raw
> > Get Supported Features payload.
> 
> If they were exposed via similar paths I'd agree consistency matters
> but I 'hope' no one is going to have a tool that mixes fwctl and the
> legacy path.  In my head we add all the useful commands to fwctl
> and that legacy path ends up effectively deprecated.
> 
> Anyhow, I don't feel that strongly about this, it's just a case
> of doesn't smell of roses to me.
> 
> > 
> > > > > +	/* These effects supported for all scope */
> > > > > +	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
> > > > > +	     (effects & CXL_CMD_EFFECTS_EXTEND &&
> > > > > +	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
> > > > > +	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
> > > > > +	    scope >= FWCTL_RPC_DEBUG_WRITE)
> > > > > +		return true;    
> > > > 
> > > > Looks good for the known bits, but this needs to return false for the
> > > > currently reserved bits because the driver can not assume a security
> > > > model for future effects. If a future spec adds
> > > > FWCTL_RPC_DEBUG_WRITE-safe effects, a new kernel is needed to allow
> > > > those Feature commands through.
> > > > 
> > > > Sidenote: I wonder why the spec wasted one of its bits on an extend bit,
> > > > but here we are. The 'extend' concept is typically something like
> > > > "bit15: go look at this other field in this payload as this 16-bit field
> > > > was exhausted", not "bit9: the bits above this originally defined 16 bit
> > > > field now has more bits", oh well.  
> > > 
> > > It's odd but corner case of going from 'unknown' state for the remaining
> > > pair of bits to 0 means this and 1 means this.  
> > 
> > I don't understand. 0 means no effect to worry about whether it is
> > defined or not.
> > 
> > > Naming though doesn't match the spec that calls it CEL[11:10] valid.
> > > Would be good to name it closer to that as we may well have something
> > > in bits 12 and 15 in future and it doesn't refer to them.  
> > 
> > Hopefully we can head off another "valid2" mistake, and I don't think
> > Linux needs to define anything for this bit. That bit's definition is:
> > 
> >    "Bit[9]: 1 is recommended, 0 is permitted (CEL[11:10] Valid)"
> > 
> > ...which translates to "useless". If 11 or 10 are set, I don't care what
> > value 9 has.
> >
> > If 12:15 are set, I don't care if there is a future valid2
> > bit gating whether or not to use them. Valid bits are for cases that go
> > outside of what Reserved 0 compatibility rules can convey, and I think
> > Reserved 0 compatiblity fully covers us in this case.
> 
> Seems the spec authors disagreed. (obviously I can't comment on that
> discussion).
> 
> Using just what anyone can see (if they have the spec)
> It was a clear spec hole and there wasn't an obvious default for 0 to
> mean so it was a 'read your device docs and act appropriately' case
> before this stuff was added.

I see v2 is still trying to pretend this bit matters.

Are you saying that because the unused bits were marked 0 instead of
"Reserved" that software needs to play this game of checking an extend
bit?

What breaks if software treats those bits as Reserved0? What breaks if
software ignores bit9?

> There may be corner cases where the right answer if we know the
> feature is not persisted over a reset but instead panic or take
> some heavy weight action. Same can be true the other way around
> in that we may have to do something heavy to manually reset something
> we don't want to persist over reset. Hopefully not but we'll see.

...but how is that relevant to the FWCTL use case which just wants to
know if the operation is going to have an immediate effect that changes
a parameter behind the kernel's back?
