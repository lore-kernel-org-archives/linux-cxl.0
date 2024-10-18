Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FCF17C22B;
	Fri, 18 Oct 2024 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286280; cv=fail; b=KFlmY/w/7yYQwhHOIdOU+kKmwJRSLfxHGnfYFtTGbvXl8oDGcm6Ng8cFnb9FkYdC9Sn90kcOPBDiAFSmD8RtfIGGQz/t+E61x0CgfBQ49lL2syWSmr6YEl3ZRw/qB+SerQ7A1ApbjIjTXA14SD6wtPpjW9hFMO2OVYRl8Yp5/JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286280; c=relaxed/simple;
	bh=fEqboCzXKYDVOgGxoE7LDonhM+A7T3ONWfnvYAR87z0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DcHmOmsu0p6dfeNbbJ/Y9bLEaFYbQ9/FBYbCdrcp9DqkXE84GqNz2jArItfvy/8fjyt79yYtslTBKZScADFZBw2IpjV5ZlL0+cqPHhUkQvUJVjS6lxFtAX7HHYTl+5jq7V6W/r8YGE3PRAu8d7t9PHPhBSyG390hHO6GvjV0F8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hq5H6O1f; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hq5H6O1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729286279; x=1760822279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fEqboCzXKYDVOgGxoE7LDonhM+A7T3ONWfnvYAR87z0=;
  b=Hq5H6O1f6ajfZ/0lqV44FejpguDEakGk+ixFqlZN00ot5xYJuD/gRQj9
   Dk5eUml+VqX2m4Yl4g9o4NAhBNtxno+oNM0TqcK9LPtJfN+NOq6XxfceE
   cqkH1XLtndcQJXZznoLMRO53oMoFsCdsSq2xnqcHqjI7rzsWe75F0Zqd+
   J1lEB3BmVdrJRhAZEsDeH3J4dcBDRaQcYh1BZnqP3ockyUxIlxVJJ1wPV
   OUJjHuCGJgb29YL0H7bBi11WYES2izwsbBonkgpEkUrGlySTJSmFduVyQ
   4fDwA24BltTch0qZJWUJFvkize8O1vm6zehVd/I6ktQ/XCl5Ttw1gSEnj
   A==;
X-CSE-ConnectionGUID: WNhrZOB5TseTSuu1LL9wXQ==
X-CSE-MsgGUID: kfw+GiTtSbmG5DmgUJeltw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="16450480"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="16450480"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 14:17:58 -0700
X-CSE-ConnectionGUID: syDukcT7SyasRqmwYsWxCg==
X-CSE-MsgGUID: jmWge/xsSkeqICGtJl/8Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="102281449"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 14:17:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 14:17:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 14:17:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:17:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGmGt0zRsqBLI/hIzQbtzNbTVO0MHCZ+7GXKxNUdwHeFyTZwSUD0Gx+0alxn725QSfnaJgk8oexyHTqMPq+wfwj9Qo7gsMnS5Bet0ZNpcijefzF0xBSXOVB2A/UUcxEA7sQjd1a9cK56WRhS6dl7QRYK3Ilo4CCSHfqntZSWgUdfKQOm3/FmU962563g0ndVLupbksx9hZCivrSiUBQNiwizUKGHs9xvm3KP6/HvTsj8ZDad6OHyEUP9a/AXA0Ct+bMCkIKuCj1zFcqTdExI7tP4MY3Ui/xOe1Y2QkD99NypfZZ0MXhUXgueHSiwCOqLj0JmMpNmOea7Zn8Cg5spsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cxi+F7DwprLFor+UX9R6pPOtgXZ7Kr5SwOuR1FPAqo=;
 b=YGYxzOB2+IjHqP/JwJrUgcZdhA7B13igOLDnt/MXcHCnSwzPoGdP+MIpdfniyGYV0fji3lkSdb6CFreq3RwAGbojYSv6C8Rywjfcl8XV50MuHD0QBQBA41UzKa8hPlo2Flo/YdM/djZ8yErnZfbafd9k/jnbRBI7s2urUQqydG3AYdelM38U+38ESjKFwWjKioAYWFAUVSRYvlPVv3IZE3TmORNvmh+6hOg2gBB52ih9M5/Xkq6chEw3U0poJNs+rM9a/WWcMSrb3EN6kNq41b4lp9Q2neBNkYXwOBgUXD47JCfivdTSjMO65sL3GWZoUUoQf4kUnpd0kYF6YOM6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4794.namprd11.prod.outlook.com (2603:10b6:806:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 21:17:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.018; Fri, 18 Oct 2024
 21:17:54 +0000
Date: Fri, 18 Oct 2024 14:17:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Gregory
 Price" <gourry@gourry.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/5] cxl: Rename CXL_DECODER_HOSTONLYMEM/DEVMEM
Message-ID: <6712d07f3300b_10a03294bd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241015065713.308671-1-ying.huang@intel.com>
 <20241015065713.308671-3-ying.huang@intel.com>
 <67118dcd2ba4a_3f14294fe@dwillia2-xfh.jf.intel.com.notmuch>
 <87bjzi6iig.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87bjzi6iig.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:303:85::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 498d84ef-5350-4728-0044-08dcefba548f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BB6V5uRY8hAH34HDKVpB0R2GTKFJ9TSuDnBiXwB6lXrQcMhJbl8DtlmpvJMR?=
 =?us-ascii?Q?i/Wd+XkitO4mqhHxcUdKC9bT93fCDbdomm3IPdPq+CK7/0SEZwZG77h3kUci?=
 =?us-ascii?Q?l+KT7IO4HHdKXX0292tZd2Px6uyYptxd3/MpaYPVVTQ2MRlJlCkcKvRlE5/N?=
 =?us-ascii?Q?BgpBP9OYszzUXEwCXQvXoM7sRiuDmo/3HA9lrOl12PgIfvoTHTtZkaxydM+N?=
 =?us-ascii?Q?l0q1oqfg36GRMUs7TrZqRjEaM03183q5TREa/2ky32LVOhqfF7BF/l2tLpWA?=
 =?us-ascii?Q?WgmJ5PbFBTKcKjLiN/PFx9tw45cAuFGsihGhTUo1vN3BgESf3NbmNmcYjY3H?=
 =?us-ascii?Q?qZKdvq8Hajj1T8Xr5DfDYQs4lhx6+pff24nLVe45icJdr14rrOrzUybPc5ir?=
 =?us-ascii?Q?vMEJdM+7V0qbAf09zfWmTXtG39fxLxeEB8dXx+wlvOwNa8lO3+eru4XL2L26?=
 =?us-ascii?Q?4QnsMEevYXHN7SGZj/lGZsOL5nsJMbn+lIGaxECyDgnurf4t5kOiBqWzYbac?=
 =?us-ascii?Q?+K9IH12bbCfUyOW0vSbpN0QeIv9IQCBH+zaTynuHPIM/yS/9BpTogjDyluCx?=
 =?us-ascii?Q?lIAL78clmYmLN5aGN5CO1mzzvKBxx5xXjCJ5b6PokS2MRnle0kl7EYfWAKar?=
 =?us-ascii?Q?jEuvS/UyYoIb4N1ktt4pnQEh8LNk4ROO/CHT04TZgrNQ1ks4Ih2CI5k7L2eB?=
 =?us-ascii?Q?8lxzMU0Vrs63kyYQa0TSwHfFGbPUBQ3guwOxZRHsVtCt9XWMea6xOERCGulG?=
 =?us-ascii?Q?IKy/qrz9njD+bDlzqpjDpM9nf0dhJak72OPTIuyFr2vBPsFgyNEBsgPqyDRG?=
 =?us-ascii?Q?Zzc7EIRDouwR/dBjqz0yNFmZ+Z6z3759bs8e/5KcUb7JNkPzt41VLsW1Wnwu?=
 =?us-ascii?Q?xDJmMvq0CelFzoHQOtcgsJ0kzd6GUzfkCxcYjp3sUaKM8lPCA+SSRAbj0ahk?=
 =?us-ascii?Q?KkC9WCGkbWWHJHz3Nh5gE4oK48/pEgmBzw1aHzPuY0qCDTi9gwyVETZ76F1z?=
 =?us-ascii?Q?sPeLV2MMeXocRl4NLxGfFLc18sY4A0HppcquxcOW0gBFSjt6C3f3KlE8/18l?=
 =?us-ascii?Q?caKzFEnaSwyg55uu/GDjfiPexPV9mCHovOkezneSUO0uFOpTnxAzmeq9D6L3?=
 =?us-ascii?Q?Ar11vOwuZkyCczqWPYzN5mjXB+zey94m/LpFAUYTc1f11ZowCAkH1VZLYibq?=
 =?us-ascii?Q?0/iqzpdrF5QqCREL1+2JK9uNCACjOpQQZTjHhQEf/xhJOpbWQJsS8x+oOJg5?=
 =?us-ascii?Q?PlGTb//r9EDku/p5sxfWDTQGEto1ZSf2CIweOkOYJPnXCl7176yjo8fdFGnx?=
 =?us-ascii?Q?sNM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?auQgVV1BKtowZ/8QVPX6FL3XzMYYh48NPoyHB2HrrWzScjqSiXAEIIuJXOEX?=
 =?us-ascii?Q?eUcnckFWjfSFpFi6MFxosd1+KOpq6Gvgx8RN2HO2CpIeuw3VBTu8ngmT/aR7?=
 =?us-ascii?Q?WmSmnr+29xhOVXCtox1nGi3d1kDhHEHKE9eGNx7AgxSdboKeUk0tdzIB3hTz?=
 =?us-ascii?Q?/81id2Pk5/62e57YEQTibQ53tj2AnV9x6aq05PU+6ULFLYn9qHQ4x/Rwehsp?=
 =?us-ascii?Q?Nh1DRsr8flVD0E0hmxV4I8zpS5kNylFQC8msvzWN86s5f8OXMNCxk0A9b+Fi?=
 =?us-ascii?Q?/E5TVOznYIjgNgJJvXyFEElKrT4hc+ngURczyJqp9CQHs+LWTgD/BneVrtXK?=
 =?us-ascii?Q?e7GUkUOzV2jRNwfY6/T9oIIZdVnFcpIUWXxpKuW/c46F8DFSTGROlzXT288z?=
 =?us-ascii?Q?DetqQIl1lo+/IYYkPc14Plap4BLOv2SGB9jR5eLG+AmnTjhJFmLbJj/UCsOT?=
 =?us-ascii?Q?JfXZPJ7dVslgJ77MLN+5U+7dphk9mr+0KMFpGJuyQ5zR69iJ6ii8ok167qtQ?=
 =?us-ascii?Q?r0G4UP2nNryVMoPoVDCVn4WHnL08AeabVAa0CVtNNbp57Sh8JGBBu/FWvr6U?=
 =?us-ascii?Q?eakL5551OFmbmV1ecjKsxpVCrahBPz6jAga8olIjracRU9Fuuh6gtWxCd1l/?=
 =?us-ascii?Q?3fsrmhD7fpW9eoIziOkmrDOnOkTkkHHnCkIy47LsJ3apEB0BzbAB2vylMAeL?=
 =?us-ascii?Q?Wf9+ZeiNqFrB3E8TekukwceqoSmZ5aNl/QrZIYO+R2Zr+L/JRE7jaaz5jHYc?=
 =?us-ascii?Q?Iw2muIBB1TeVFy6EqpZ3/3d6/hLN5KBQaG/Ff3BzxgrBC/+/mPhvduY+05xG?=
 =?us-ascii?Q?7uUuoKV6aWOcs1DvWjEgOCS0cv+UjsZFTTTZfV/bRbPzmOm8JARRutbVoYmN?=
 =?us-ascii?Q?W0uNbuzsyrt74Fjj2Bq98d/h7T8Jh5pjuZNoynD6TlC4J35OUF1614tMwoMA?=
 =?us-ascii?Q?K176afDu7UU9fnguU91vrzMJs+35YQts7wQH+6TgMMSuLGrSpLLYRi+5r/31?=
 =?us-ascii?Q?4013BpTS+pl5G/Gn3lGgnwPPyIfHGwEer9hGlGi39ZdXCMcrj1dv8FqSuu1C?=
 =?us-ascii?Q?SWHOBmAqAijY7AjT/pPrLOCoJaKTm/4PsVgKnVG83CEFL7gUIGax0XZBKIkR?=
 =?us-ascii?Q?TDV2USxcoTEy38KsRE7LpB6ThTETMM4rYzLHfUZ26kzUnsnvDxgBToflrMIC?=
 =?us-ascii?Q?lLjx4nqqC3DVhszYFjypZIIaMVejj9cvQ0IxCIAG7SJ1XyrT04OCx1zgQMN+?=
 =?us-ascii?Q?CpU8a54HQsLXmL+dD/JQUMRsvM2WXoypyWpWPPLINbf9Lq088Cv3iqamo+qC?=
 =?us-ascii?Q?nPT75sC8+zdJJJS68fFzzmc53B4Dm+UiYDjlwYuRcXzOfTrPd48bC0E5OPl3?=
 =?us-ascii?Q?u6lMLTarsPR9LEF+HEKnCW/xFWFJD69AawaZQo4xZVTo+l6BWayE/kFUZeaQ?=
 =?us-ascii?Q?2kW/Mizwd2O79lAlYEcIM7ZFYF/rNIXXNjz2TG52YEGqdBUxCPTlxEqF39tc?=
 =?us-ascii?Q?R0zYYl9fvPQWdAkgCXG+Aqs3u3nKMW9fBnzmPYNVAbgFwFCj1/Ns8AflCzkd?=
 =?us-ascii?Q?X6SZQx1gyzsN0m/s52vtI6RIpLSjjNMAoEkuWvnx555Mkh+kYAQgd/6ro6S7?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 498d84ef-5350-4728-0044-08dcefba548f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 21:17:54.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r01PkQCtxh0ML3Vj5XrfGwFI3S8DOJ9FSB1zmQ1Jo0/UtZU4D/1XyqAmMh50ZTf/pISZdphdv4msis1u/jyTmOmQclwZI9AqJc+ODLGVfWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4794
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Hi, Dan,
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > Huang Ying wrote:
> >> Previously, CXL type3 devices (memory expanders) use host only
> >> coherence (HDM-H), while CXL type2 devices (accelerators) use dev
> >> coherence (HDM-D).  So the name of the target device type of a cxl
> >> decoder is CXL_DECODER_HOSTONLYMEM for type3 devices and
> >> CXL_DECODER_DEVMEM for type2 devices.  However, this isn't true
> >> anymore.  CXL type3 devices can use dev coherence + back
> >> invalidation (HDM-DB) too.
> >> 
> >> To avoid confusion between the device type and coherence, the patch
> >> renames CXL_DECODER_HOSTONLYMEM/DEVMEM to CXL_DECODER_EXPANDER/ACCEL.
> >
> > This does not look like an improvement to me. Type-3 devices that
> > support back-invalidate are DEVMEM devices. The device plays a role in
> > the coherence. 
> >
> > Your explanation is the reverse of this commit:
> >
> > 5aa39a9165cf cxl/port: Rename CXL_DECODER_{EXPANDER, ACCELERATOR} => {HOSTONLYMEM, DEVMEM}
> >
> > ...so I am confused what motivated this rename?
> 
> Sorry, I am confused about the target_type and coherence and forgot to
> check the history.  In some places, current kernel still hints
> target_type (CXL_DECODER_HOSTONLYMEM/DEVMEM) as expander/accelerator.
> Should we change them to avoid confusion in the future?
> 
> $ grep expander -r drivers/cxl/
> drivers/cxl/cxl.h:346: * @target_type: accelerator vs expander (type2 vs type3) selector
> drivers/cxl/core/region.c:2450: * @type: select whether this is an expander or accelerator (type-2 or type-3)
> drivers/cxl/core/port.c:141:		return sysfs_emit(buf, "expander\n");
> 
> The last one is
> 
> static ssize_t target_type_show(struct device *dev,
> 				struct device_attribute *attr, char *buf)
> {
> 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> 
> 	switch (cxld->target_type) {
> 	case CXL_DECODER_DEVMEM:
> 		return sysfs_emit(buf, "accelerator\n");
> 	case CXL_DECODER_HOSTONLYMEM:
> 		return sysfs_emit(buf, "expander\n");
> 	}
> 	return -ENXIO;
> }
> static DEVICE_ATTR_RO(target_type);
> 
> for decoder device.  This is a testing ABI documented in,
> 
> Documentation/ABI/testing/sysfs-bus-cxl
> 
> Is it OK to change this?

No, why does it need to change?

It is unfortunate, but ABI's are forever. The place to clarify that this
decoder is participating in HDM-D[B] vs HDM-H protocol rather than being
an "accelerator" or "expander" device would be in user tooling like
cxl-cli. sysfs is just a transport, not a UI.
