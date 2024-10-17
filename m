Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D81C3034;
	Thu, 17 Oct 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203944; cv=fail; b=VpyWxzEdBcrx4BQ1qO6t6NJlsGL+QamSqAPqLLRvqt/HAv/+KLgXVRSi2WFAmGBk+OH9BeHkk+BP6VeH+Cfy85VBDZOfl9jP3NPO64a4pz+cb9sFJh6xPWRZAED+dvOzVZ53/7qMd7qsUsjdjA4Hb5vfWzYwAMe3xAsyGQEsqpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203944; c=relaxed/simple;
	bh=N1OXEsxSgyCvqEND7dNAbmibVa6cpuI22eyKyoj6DQk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dq94EGmD0oQdE9QzOusjdowLT1nuHuFW4m6Q+AGPh7J49Orx4IgTpVDUD782VNvVg6cwdiXeSfoJfpv0Ou1vltvTCtYoF2MTlfUUyMVtVGCu7kg/Uv5HcXk9fQEjL6UMAq8Jk0gwNmoSJVEOOBGUBDRwdMzJcDW11IE4eqwH5Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4HuldV4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4HuldV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729203942; x=1760739942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N1OXEsxSgyCvqEND7dNAbmibVa6cpuI22eyKyoj6DQk=;
  b=e4HuldV4kgSVadPL065XK1OTZNFJkITLHuK0oCAW1qsyKCcNgDHPbxAa
   /qFNQ4feYO3brj3dcq7pNzVsrjoNUGpKJpFJdXwkwW3AlRU4F/Vox2qqf
   /hiPrAreDsDUimfh9NCy1KAwPxxtqb4sbLRMnO2YgjwVPGQPOJtsFjg4s
   GLz3WxB7hsclOCfssj20E0tQfPVJmOsPAZHsdH2sV3ZqbQsQMSat/SvWZ
   Hh7bbXdZitKY4r5HUaxY7yfwIkVsYxpcPqYGuyabro93d9xxDwf3R1zK4
   FCo+ZJEpRgGfmjFfY7mg4jgmK8ASDGshmOA07dVygIqnEy58b01yxno8W
   g==;
X-CSE-ConnectionGUID: ElwxvCCAR6SXNk0+RGR6Mw==
X-CSE-MsgGUID: 07PdzF5TT7Sy29UQiLoghQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51262914"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51262914"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 15:25:29 -0700
X-CSE-ConnectionGUID: wGP5dtS8R4+g0bBQ8EZpFA==
X-CSE-MsgGUID: 3zFuabo7Q6O5E9jPkuM+uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83326326"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 15:25:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 15:25:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 15:25:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 15:25:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 15:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuqQPf3O30lhxIpVjsmUzLnoox+OIDLQi/ZQgcXMmlJgx9VqaXGjXtRjSlKBzfPy4u9gW68xsEWa/9K6xTR30br/GfPY7bZoIZaylboN2YKCa5j0wnIMBCWc68Lb07IMqmx/Al6g33ROr0hyEomoblaHnTOMzsE48VmgTCNzBF0U9RRUreUZfVKzxVLXEQIYqyLQ1UOREFr1/RVIx3IuK/sxsBhqu8gZp8UntsZOfdL/OQ83+ckTbCrs+UjI/rCAV5m18gdjbEYh+2CRWpXBePb814Hr72yOVCpvn1UTZKovpqmCwGG0UvpyoQU+dNKHbAgK2MV0/zWW0/S/lQNgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlaCNwF6c98VKFNOHV+LE4mxFf/v5rIZNf2NIEdpg2w=;
 b=xi493tStDQT87ZF9qaYZX+vPkEOHhFDhj9kbO+hH/tWRAJmDrCs5CdNtC4G9uqLON+/O6iMmugiYDU0dSoDCkZZpoVSHYnmWjH6ujwBAertEF0oSljbr/WmxXdQjG/DcFzCapLyxrZg9w5gzPrjKukYDeHFGDaLiQPawvhOrtbvnNWMsAiz/mkpqROQ3TYUzsZWK+wRWQNEpp+Bzyr5Z8Z4K8sdjd29Sj2EoquAmhuipG8DJ4mxODF9k6UpvWWdIw+Z1QwJkwstFAAlaaBRQlNUU1djEidO+H/PLil3/l7FFfSnOcmxvc1X4rPrQTivCbEkL3DsI+qXsb6tjnHZ9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 22:25:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 22:25:25 +0000
Date: Thu, 17 Oct 2024 15:25:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Huang Ying <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@intel.com>, Gregory Price <gourry@gourry.net>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/5] cxl: Separate coherence from target type
Message-ID: <67118ed29b418_3f14294a1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241015065713.308671-1-ying.huang@intel.com>
 <20241015065713.308671-4-ying.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015065713.308671-4-ying.huang@intel.com>
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b3bdf4-9b65-4f1c-6f7e-08dceefa98c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VfsS1THS9sMYXxc/pW1wWYeCPGOGZjmdTUvUjahjb9i59JKuxh8INnjPzH4g?=
 =?us-ascii?Q?1uUJ+OWdqNYn8LNlj+MmLRYefKAkd7HaTWXTRHr0ZV3WoGlyL1Zw11zBDJ1g?=
 =?us-ascii?Q?vf06jKHktAsZ+ImUSdJ2+AOMci+4G+vemetc4b0LrAOjoneDqNI1uQjXvLqP?=
 =?us-ascii?Q?mt5D+L4tmC9/ivU4sFKqgXTIDh8Vs36Bd0bo+l+nwVq0NDxsMwuMgjGDWSd0?=
 =?us-ascii?Q?y42I2AM2K+8Dmf1wHmeGGrlQRMZ3wwHaaYcVwQmbin4LKPX39Vviq8H3MQmZ?=
 =?us-ascii?Q?UZ3b90q89Gg5a3AZFvSr5TLcaT9ldyHUVhxfby4Tz+z2b7RnvmBBHhXG/u6m?=
 =?us-ascii?Q?IFU6gPTbdxTRNTkxMC5u/6OcR5D4ThzmLpyJJBPs20BtIl8v2kLDPkLr9YvM?=
 =?us-ascii?Q?ZB2Qk1NQrV4TZP7UBXHS/D89zDILeEU1/j8N/NnnAKpG2pmAx6GGqGG4CsC8?=
 =?us-ascii?Q?FRwySL66g8ccDpOPO2moztcJ59TVkC/myBmEUXXQmuH/QNxY9JakdltxB3EP?=
 =?us-ascii?Q?L1Mk+9GfwmeTQdHcxgFtSVG9NiDIr9u5I422cOTkCVeZj+HQNKmSHdkYSbbj?=
 =?us-ascii?Q?yjV3de85lcCBGudJRSqpS46BoHvlApGiEWiCuJmOEK41QNuXXoA5ptwJhXMX?=
 =?us-ascii?Q?NuN1YBhNKZi6LVhm/X7fHM4J3oQ3/fQ/pksWN+bckmhvOLAzirR7SCFmHl3T?=
 =?us-ascii?Q?GNvp4bJLesBkxpaeKa3r1IIbbLk/R1VCKpB24adRo8BHLNszFWjcTeBnf1FB?=
 =?us-ascii?Q?qL7b2Ng4HYLQlUONf0UdKolG0fUYMer/24j9ZYw1SptleIvmsGfpkIoZQmxz?=
 =?us-ascii?Q?jrRX5ozoo18+8hJZsECL4VFm7ljfsLx+46+HB5bN/AjZo7ZvKRfZinKTEQQw?=
 =?us-ascii?Q?k/bdeymwFpwgDUbjRxr07rT+Jj09hDf1N9kqUGRCi3goFzHgPv4cbjfS5HxF?=
 =?us-ascii?Q?Ro3Kiur3UVCIhQbdOLfcEtDbUArq/25PWRORDYjaIWYFLjmcEvkGxR4dkyRd?=
 =?us-ascii?Q?bJTIYZhVEg4pcBXP3KxJmWBNYKYKPB0IhTv5PTIvCNxRG/NsqqXithbQjXor?=
 =?us-ascii?Q?i+VSPmZl5H5dvZ7LCZY/X2vVbDPhTwVsIs2qr+rLQtJJXT7301R0Lm4Vx2t5?=
 =?us-ascii?Q?Q7M5BMl53mC1EOJvtxUaRmeO9bKh0ddQxG25Szq1vnZ7SIMcnLKXgfY3LKLS?=
 =?us-ascii?Q?zfcPYEKj14zETLErWpL1gzt2tVsGVAE96E2iYjcmRGocMcOqZOgElpLZqNMu?=
 =?us-ascii?Q?JkYPHnu3KUtyki5wFKKHOHHViniBqWnGZKmZJHKMKl/AtyeY3VCtFPi+v2kL?=
 =?us-ascii?Q?G7hJ7lHpFTgDo2y/C9ruxBNP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0kWG99j92Btk76jBqxMMY+BI4Jg9Ri2NeLPeWkTMWXpVajoN6XLxZaAZi/2?=
 =?us-ascii?Q?XyZvd8UvCsGW4fsI7I8i7xrrtjkOQpWB/Z/TliCGufk48dgb9RnI+UiApjq2?=
 =?us-ascii?Q?Smn40rOBZJMNOa6l5CmANZ5v8ejVyz8895ZQZjcNexx+ccyWrjU7FdbgNn4o?=
 =?us-ascii?Q?atVEPY42Zt3hujojRtGyScbbOw3C7wISg4et64SNjsHlvlzvOFmnrGLF2UEB?=
 =?us-ascii?Q?6nAVYjl8CLuGutZp8wPHSZUcPvYRXNOF9w+bS1fUYjV1S7AlKuMj0GQZQUma?=
 =?us-ascii?Q?n5BMHsoR3LpIXH8m8UE9Gjs05s1XqbEHWalzvkdFCZEBlxirmllqC3u9qaVf?=
 =?us-ascii?Q?GjqJJ7Shl1IwILGcpjOk7KvHR98ftQ41Uj/CEQjYHyW67qoV90n0KguTVP9Y?=
 =?us-ascii?Q?tZSVz8ETJFruzfzM4pIhUT/Rxquw1P/t+wZwgjQdRNAq4t1uPfXCicy3/S68?=
 =?us-ascii?Q?Pk/rEb1r/RGFudvmZyClWfZwj2R4Pt68Y1+OewZlraHpuFLps1mDk6/RsK/u?=
 =?us-ascii?Q?Lb6gk8chwb3BLOMP2JTZLrYY8a/Xda6SaHn2RoOG2K3T0Yy/0hDjS/oN8Swp?=
 =?us-ascii?Q?obi4dt6ys213Z6jUIb5KUMUJr2oXf2BfdP53366x9cvCE5dZUIMPOJhn1CpT?=
 =?us-ascii?Q?5faWzg3K1sgx/posoicqcDub68k1eeJURQE1rIq1J67SME7UFPJQuw1SRXc0?=
 =?us-ascii?Q?ffu03YRzZuqG3wVdN3kH2PpBKkQdBh1soJJ/Dfx1wlxz+LCPaPu2pf2HczFJ?=
 =?us-ascii?Q?w75xbvRtoPRuHc0mcB0FpLpXrOk8qPBQN7t1WMCot/k7TBOhFZB26sJQKS0f?=
 =?us-ascii?Q?TCux21mzmgcj1S9g2R/BlQvLngRsxbkBt95tc/SIfLJp7irSLHC6SOsNwS4h?=
 =?us-ascii?Q?6J1H4H3ihDPH5s4tvo/ycCSX944GwUVo+L5Wq6zCrxctfzsHumBRHun3Xc56?=
 =?us-ascii?Q?LgDIs/DPHyAnJisKp2sCV2H+4sIzlGHVDXXBN+NNvNMEhdivm8Ldxbn5cF0h?=
 =?us-ascii?Q?iRCEpPSFSwmdHdGEwV8xeZVwdi9Da83/S4di1rAvu6bCmyWXtwezhJEGuf2h?=
 =?us-ascii?Q?F0jkRrL7uBeiWgMepb9kOB1dHfQOOYY5rf5i83B8s+7F/TEneTddOKPl6hgr?=
 =?us-ascii?Q?Jgzqj/uA1Nj9kxXqimvDrXYUm1ryIvMiCiTvIegT5OyRkcc+PhZa/VLhyYKp?=
 =?us-ascii?Q?q2WJYD1r30M7W+10kul4tia5t73px9Ad7IXVWRlgrAIuEbVwacvbpgLF9Agt?=
 =?us-ascii?Q?cC6+ZEDDroFeJ7CGn2KDt3slxbX27GjIGzR24dEjoRJFK0So++LZRO0ArloZ?=
 =?us-ascii?Q?XXN7TVf+JABaGjwlIZi/8QCeotJDD+L/R5ipeqDe31/u3W3UeE6b56NEdDJg?=
 =?us-ascii?Q?3kN0PVzr19PsSKTIxZdb+5YSmxnrgAzOaKxnPuDpPpX2eQoHrAHScrus/hUi?=
 =?us-ascii?Q?s/Rmaf7gFIlwed/Qk49DNwO918RYgUAcJS5ZL6M9jW/wWWRIJOaPMX9dB1Tc?=
 =?us-ascii?Q?epHaAZSTT0hq5n/t6EQ8HnwBIaJ7NdPVO6bv3Pel3umyeGnmD1QHejvpl6A8?=
 =?us-ascii?Q?SAv249+FwCsPRl72XJ5rhXOShSsTam4b2jgK0I+t6+PIuUVHBsbzWeebqPO4?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b3bdf4-9b65-4f1c-6f7e-08dceefa98c3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 22:25:25.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RarqzmHUhxmT6DsVD0pMoCbX86ervhGNUJMTHsZ594nEcU+jFnnOtMRqBX5DSnVWnfssulYya+1pQlewi6bCYECLQ4jukkGQnn3UoWDSEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com

Huang Ying wrote:
> Previously, target type (expander or accelerator) and
> coherence (HOSTONLY (HDM-H) or DEV (HDM-D/DB)) are synonym.  So
> current kernel uses target type to designate coherence too.  However,
> it's possible for expanders to use HDM-DB now.  So, the patch
> separates coherence from target type.
> 
> Accordingly, the patch sets the HOSTONLY field of decoder ctrl
> register (CXL_HDM_DECODER0_CTRL_HOSTONLY) according to the coherence
> instead of the target type.
> 
> Because we cannot determine the coherence of decoders via target type,
> the patch lets accelerator/expander device drivers specify coherence
> explicitly via newly added coherence field in struct cxl_dev_state.
> 
> The coherence of each end points in a region needs to be same.  So,
> the patch records the coherence of the first added end point in struct
> region.  Then, it checks whether the coherence of all other end points
> is same.

The target type is the coherence type, I am not sure what is motivating
this separation?

The decoder must match the mode of window it is joining because both
HDM-D and HDM-DB speak a different protocol than HDM.
