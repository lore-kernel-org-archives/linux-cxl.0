Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F1384
	for <linux-cxl@vger.kernel.org>; Fri, 17 May 2024 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715904507; cv=fail; b=FuuT7HaGlI+/D6ScouWvXt/o524mQOPNY2tM8mjde8IcaZMuLpzkvxunK2pddf1oogZpLZm/aKGKZFOUK7R0Vlcg+lffz39MipaJAXPkh8DyAuNz5AfcJYihzccjgfq36QwVdBz5edbSYmQvp1DGVQBFoqZTT3JVKCBCt4n0GU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715904507; c=relaxed/simple;
	bh=JOwDmcbKwfFWMPt/6H1OJFhCyKcseAbjPr/ZodNIbW4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ouXrN48qWrrimI9OtooIFJ5TinvR9YR+/uDSESqyycIiA96pPxpM+mA1tuUqTde7YWzBw4yK9PIqqUBB79r8bvjgVH3ZhFufGqMDAdqFbnkkVhYIHXCzkY1p+MJfeDSzpxGY/ii2BLXIQv/TlZFE9OPnG0oYXuCQI14WF1WG/ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GybaRtw5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GybaRtw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715904504; x=1747440504;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JOwDmcbKwfFWMPt/6H1OJFhCyKcseAbjPr/ZodNIbW4=;
  b=GybaRtw5PZc9UYHQh1sC5U2/gn1rGE6GA72p5J3AedWXClEKkXgqOnwf
   AI+hiPVRO4axQgvQpcz0JH2tL0R9qXq6/gFrG1S/3NZVXPBO1r8CMLSwR
   LGJlIgE7xOcGjbGTxVvWXvYQC7laGHyrdEiE4RHePhS8m99qhFq1JTE3Q
   DB7GHzmEhZ/OrSKhu2m6/WyuynTBcHwa+TPBiGwMVRNdSRQY5zBcOQBA+
   D7nAtoR7S9V/Ftu5c+fmntgzm+tHIZotR/ji3feZH+Qu+NQakF6qCepto
   LKRZQMIpkAPrCnCFhu6W1STI8ZyFOKriM8KjdPLmHMGEvFuHD9w/2sk4T
   A==;
X-CSE-ConnectionGUID: Wu//SkuYSnOUBNsEv37S4w==
X-CSE-MsgGUID: AW1360T+TwmwbvmHR3B9iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23196379"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="23196379"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 17:08:24 -0700
X-CSE-ConnectionGUID: KcuRStixTwSoDg6m8T017g==
X-CSE-MsgGUID: gZaE/zoWTCS7FZzdcbYpzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="31602303"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 17:08:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 17:08:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 17:08:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 17:08:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 17:08:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyVuiFm/Szj5FSBf/P+E/GmYX6Rf4k6yPPZ7LHVUxOfSCPzJKYGqz2ce7bEqEnKJIMQnPukFZlbPmdFVjM/PKjXgwcIPpxMEw3P44EM5TinaLeO9KOQu4EIr36n68SQRaXXSIrTBGWnrq/T/PZ7pmTWObBa1LB5kYiGG5PNpSIpVrU3zJPNUHId0J4uFjFentyW1VqCeeqSaz1xVXIgRHuawze5A/VRVaE6O+yf2vPSsxCvgBCx7alX/LQC/jArgcg7LE6gMY0tntIRJlz+NaOQ/EyvnhOt7sSDHhsmrT3mwbb4LVuo5zz5adOg/RNaOYDIKb7Ytkwgtl8eQ2Y417w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be2M8K5P4Df/GOBx8bDiggtSuR+Ne21+qpHUMEwK+5w=;
 b=ZBiZit0oI2E4SVeTwFnPIoVgfFAqGqdCfJWIncHqU7hc503CFty76nhjf/wbv8um6kPxg9Mi6GviC5gnsUtyF14LjDvxQi1V2VZg/q3JqjcU2qk6CDwPOu/F5GJOeTFWcj1Q9uos0FNFIA2WW/xdgJst1FcYo/2UMZ6NLdDC9ebsij/6v9vES+3l+IWxI6ayBpfe1IpJAVfT58Zd4QXXPHgx1azTKTg9F5k0xz02DxgqFxtJXCAUItUhXd2xcrib3362NW+qt0WYLNceN3SAjibiEbhZXV1ZDjIgS3p6dkyK2r5ES4dF/WzxqE6pKdGgHeTC3DEppRxw20ufsdfWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 00:08:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 00:08:20 +0000
Date: Thu, 16 May 2024 17:08:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <pieter.jansen-van-vuuren@amd.com>,
	<richard.hughes@amd.com>, <dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: RE: [RFC PATCH 00/13] RFC: add Type2 device support
Message-ID: <66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240516081202.27023-1-alucerop@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
X-ClientProxiedBy: MW4PR04CA0364.namprd04.prod.outlook.com
 (2603:10b6:303:81::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c70567-b0da-421c-c666-08dc760575aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?xbQkiReNjEThyq1qIl1VaX+U1udtFdGfma70WXl6+vw42X0oxXw1dLEgvP?=
 =?iso-8859-1?Q?/gg+VvfTyR5t8FOzCzGP3XWW7l8K1iCbIg/TUc9qtYP/CqQXYpzX10/FEa?=
 =?iso-8859-1?Q?hcjgANnWex/v6KSgi2va0KbxaPcm/+iUv+ctiQzpgpiX/TdnmwtE6+2NsJ?=
 =?iso-8859-1?Q?7EGCff9bozt0wHMDt0wI58FAaDeK0o+A3R8/Yaf5/ALzDRHm24AAvDqTTg?=
 =?iso-8859-1?Q?D9OMEZqQQOBXtMtTKLcrxZC/67iSg/6X4wuZiYkB6yUPPIAc+0zw28LO3+?=
 =?iso-8859-1?Q?enx+bbVUb33ji3PL2tw0fFV2bJClb628uumT5+pnKz5MAQBVI+eKoFH4u0?=
 =?iso-8859-1?Q?3MDjIiKnFJ6KYNTiH5WMS0LnP8NG++wxXO9UlDcdiehemlBJ6Ya4sF+ymL?=
 =?iso-8859-1?Q?VYHtVI8ZWOf/An4hJ0iVPMZZ/tAFIIDvLolKVMoZ3wHKVv0NaqPUqY86yn?=
 =?iso-8859-1?Q?yZ3Mma7c0dDOb7TUQ6/aL7FIePSIOACkSb4NmpxVvUr9/Qi1UyYFk8CWJu?=
 =?iso-8859-1?Q?OjE3MoC8u0BHH7lWJSz+K6me52g8CdHdnI27fVl0KSfIoKuU+dPs0w4pRJ?=
 =?iso-8859-1?Q?UD3xjaz3snDms057AcJ9I/muy2oKG8/ESdRwz+m8DDbb4iutWq6S5IdqLp?=
 =?iso-8859-1?Q?wUltLDQBL89Av9zbnx8tReXHsli4jbQKBN98DCEtAjBiKwOAoo6CARW8XS?=
 =?iso-8859-1?Q?tgbvzhhrzFEAQqQbKxUIDMCg1iAsnpLHm97MfotTeUbh2AW7yA4kjaJ8Gw?=
 =?iso-8859-1?Q?qob3sUxZrTnu4381sJWQK2Xy7y3pZ0LMHpafM3DBNEirGiS/6KunOVRO+Y?=
 =?iso-8859-1?Q?KbDStD/2+os4hMTA6G1DS0EhPklUCzhlAReTsYV9jkU4iXf2EYQ4CDKHwd?=
 =?iso-8859-1?Q?cQTBEuKLNGjHPZtNZ44+OzVg7ccY2KdBJlPQVrCFC5dZZIhyObPWDrYPAy?=
 =?iso-8859-1?Q?PF1P3UxdsTIp5hEhFaDk9qiKzsJbIwZSUCTODIfmxaMtMNm5cCsx9CD7aE?=
 =?iso-8859-1?Q?d/HTG4tqAFhBb6AA1NyO/YiGk00iiP2bUbOJGp0INYYv40l/DWKR7HlOGJ?=
 =?iso-8859-1?Q?/eI3SqSW7sZu8DAB1zGmTT9ADx0lr/n7gd3Mhvzb38RrLLvR9wdE2739Qf?=
 =?iso-8859-1?Q?/jbgnYRShE/x9oz/BOqaWhSvuSfrbvemVVZqis30d91j0HSbw+npikQ4d0?=
 =?iso-8859-1?Q?vuxS9Iaz+P7Y9c1yadsbvMqeADxPBerHABOK8T4Zjg4JlhiqknmtgRmfBC?=
 =?iso-8859-1?Q?Uam3LDMasYy+Jd0g9mLLP9F7GjW9zStJ/1F8bvRvQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fFtrpTtBa1rq4gakMz2HZ5z7Dx51kIVwfEGcEq9b10ODwlnGqVfDxOgjXz?=
 =?iso-8859-1?Q?KDkgut5Nrqd5PKIA/D/2vg6KdlQLAJNAFjK6Qtlzjwx/6VQ6Ck60qAeDXY?=
 =?iso-8859-1?Q?/dyZGMpgrlPmAcMNpr8t4nkWT7XKxpEIDDsli44hKZbdj7DDVb6FimvTJD?=
 =?iso-8859-1?Q?8PfI61tb2qZgi2oK9G6baQWTZ2ZeYu1mLLTSfDU9miZbJfD2Vtf3NaRXwS?=
 =?iso-8859-1?Q?g+xPd7uT8Aht5huF2RMbJeuPvOfQ4zPuJlvzch5TGTxg+/bupqwedhfJ0L?=
 =?iso-8859-1?Q?/vIk/+5mvXUhGBXkgIodQZ3YwV+QwdKyPGFu4Bnl3liXmOZGAMEWqnm09A?=
 =?iso-8859-1?Q?oZIIBaQxU2r2NKrJmZ5oZKLXZLX6jTOigyz6vpXNiKHPa3yxw1j8VdjNxM?=
 =?iso-8859-1?Q?s4I1odOOswUryMUNxQuYOrUgugxFeBMj67+Jwuo8nxuudvAd9WtLJCxpE2?=
 =?iso-8859-1?Q?AgkRW2ez8co4pnpeyokvgc9BUHQSXb0T3eBK5U4z001aE3XpHZmtJRLko6?=
 =?iso-8859-1?Q?Ae/DEi9j/V22SxjMPofBf/7fq1JC/2DjuhF6mCFjyoSFaOmf/gWyYXRAxE?=
 =?iso-8859-1?Q?I6GmF0vbzGSqai2ozavbSiYm+EINg1HrQarwjk8kLYCLzTJd3uS6OmdVSX?=
 =?iso-8859-1?Q?b6BqfjVBqi/yDBBv8JwTrUeV118evi303hGff4+VOorVByg2WRTFCsRT0m?=
 =?iso-8859-1?Q?jLaIaJZ6Fy2pBk6vYmDmgfOyWNMDy5g84WQ0sekzJxIdIrGFX1JOYtF+iB?=
 =?iso-8859-1?Q?+b3Nbsp92Sd5gGGwl+Eq1AEqtFOp22OGdkTdgu+FR00GwuvFCOGaSZG3kg?=
 =?iso-8859-1?Q?At1uWon4Bmm5PYEu/vVBuEL/I0t/X0Opp85V+fK6L5m1Q3GjooS2IG2gBb?=
 =?iso-8859-1?Q?P1PW6Hy0SLxunhnUnXPpbi3EVQkUT+M9905MEebJGncHOxlxAF8GzOujiC?=
 =?iso-8859-1?Q?m5ikLOKlVieeDQWqHutvWyLsfvW/JS/TFwR+2HPmJWdDP4GvndDcVv1kaN?=
 =?iso-8859-1?Q?hKjljCcG2xyi7173gzTYDoHiyBlyLcSc/4ysio6SVYOVh8zfBis10TMPxj?=
 =?iso-8859-1?Q?wjD+Own6w6wEIz1thcpYssQwj2DCKZ4qVsK2i2v46SKlTOt+wlgE3E5HzH?=
 =?iso-8859-1?Q?IR5qRFA2zVzr405siFiNmvsbVffi3BCGEChsYXgCklNt/YKx/NO5aUIqyl?=
 =?iso-8859-1?Q?H71R4CPyKTQbHDyruBNwb9W5ubouOb6o5Xbg9eNDdS3T1Yp13ROt19rREs?=
 =?iso-8859-1?Q?1cIk2MXdki6n/PzlH4U7torlbUXcaRux92Mqdk9lHDmKaLZ4beyKQHHDrD?=
 =?iso-8859-1?Q?cNq0og78R2cZJBAhBwvuvC7M7lvrLzgEfkArHXEzXqJ5rODhB5B7xQDryw?=
 =?iso-8859-1?Q?0+10QhbGNQlc7eS+WN88bXbLJiYbK32Ig0IsaxDnuC5BVd50sQAlpGs5zF?=
 =?iso-8859-1?Q?O3W6abfVInwKxbOoCpE5cM6QcwWC0AjPYHDbJuX143kwNelv0EQAQOuE7w?=
 =?iso-8859-1?Q?1b4Ie6XVP1K1zqzV49YWXduyBuPXzJvCLTYvGMUYWrl9quQKeJ0DsSCfkJ?=
 =?iso-8859-1?Q?DhjjvZO+Osydd0Ly5QS6LMkgaut/2otbY7D72ZtUEnY83a2Lygs59XJlWJ?=
 =?iso-8859-1?Q?4o8MX68eH0CzjyA6Ae+Ko/2DkQ4e62rXwH/jz01wtUuBNCj5w9VRzAfQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c70567-b0da-421c-c666-08dc760575aa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 00:08:20.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zz6FiKruLP7wvO9K9hGOiqIX2+U1G5vSd8sljpwCewJk2k1vCG8iA1YdEQ/rIqdoK1lLneKaiJYtAxiQW9f6vgRtt7xeFI12WFBC0vtFLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alejandro.lucero-palau@amd.com>
> 
> I need to start this RFC explaining not what the patchset does, but what we
> expected to obtain and currently is under doubt: to configure a CXL memory
> range advertised by our CXL network device and to use it "privately".
> 
> The main reason behind that privacy, but not the only one, is to avoid any
> arbitrary use by any user-space "client" with enough privileges for using a
> public interface to map the device memory and use it as regular memory. The
> reason is obvious: the device expects writes to such a memory in a specific
> format.
> 
> The doubt comes from the fact that after implementing the functionality exposed
> in this patchset, we realized the current expectation seems to be a BIOS/UEFI
> configuring HDM decoders or HPA ranges and passing memory ranges to the kernel,
> and with the kernel having a default action on that memory range based on the
> flag EFI_MEMORY_SP being set or not.

Lets clear up this confusion first.

My expectation for CXL accelerator provided memory is that it is marked "EFI
Reserved" in the memory map (or CDAT), not "EFI Conventional + Special Purpose
Attribute". Recall that the EFI_MEMORY_SP attribute is just a *hint* that OS may
*not* want to consider a memory range as part of the general purpose memory
pool. CXL Accelerator Memory is far from that definition. If a driver needs to
be loaded to effectively use a memory range that is not a range that can be
transparently converted to "EFI Conventional Memory".

> If it is not set, the memory range will be part of the kernel memory
> management, what we do not want for sure. If the flag is set, a DAX device
> will be created which allows an user-space client to map such a memory through
> the DAX device API, what we also prefer to avoid. I know this is likely going
> to face opposition, but we see this RFC as the opportunity for discussing the
> matter and, if it turns out to be the case, to be guided towards the proper
> solution accepted by the maintainers/community. This patchset does not tackle
> this default kernel behaviour although we already have some ideas and
> workarounds for the short term. We'll be happy to discuss this openly.

It may have been subtle, but even in my initial RFC [1]. I was explicitly
skipping exposing accelerator memory via device-dax:

@@ -3085,6 +3183,15 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+
+		/*
+		 * HDM-D[B] (device-memory) regions have accelerator
+		 * specific usage, skip device-dax registration.
+		 */
+		if (cxlr->type == CXL_DECODER_DEVMEM)
+			return 0;
+
+		/* HDM-H routes to device-dax */
 		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",

[1] https://lore.kernel.org/r/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com

> So, this patchset assumes a BIOS/UEFI not programming the HDM decoder or HPA
> ranges for a CXL Type2 device.

At least for Linux it should not care whether BIOS maps it or not. The
expectation is that whichever agent maps it, BIOS or Linux CXL core, that agent
honors the memory type specified in the device CDAT. I.e. the "Device Scoped EFI
Memory Type Structure (DSEMTS)" in the accelerator CDAT should pass "2" in the
"EFI Memory Type and Attribute" field, where "2" indicates "EFI Reserved" memory
type for any HPA that maps this device's DPA.

> above, a Type2 device added after boot, that is hotplugged, will likely need the
> changes added here. Exporting some of the CXL core for vendor drivers is also
> required for avoiding code duplication when reading DVSEC or decoder registers.
> Finally if there is no such HPA range assigned, whatever the reason, this patchset
> offers some way of obtaining one and/or finding out what is the problem behind the
> lack of such HPA range.

Yes, that was the whole point of the "Device Memory Setup" thread [2] to show a
plausible way to reuse the common core infrastructure for accelerators with
CXL.mem capability.

[2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/

It would help me if you can summarize what you did and did not adopt from that
proposal, i.e. where it helped and where it missed the mark for your use case.

[..]
> Keeping with kernel rules of having a client using any new functionality added,
> a CXL type2 driver is increasingly added. This is not a driver supporting a real
> device but an emulated one in QEMU, with the QEMU patch following this patchset.

Lets start with the deltas compared to [2], the observation there is that much
of the CXL core is reusable for this type-2 use case, and even improves the
organization of the core. The consumer of the refactoring just ends up being a
few new helpers around the core.

> The reason for adding such a Type2 driver instead of changes to a current kernel
> driver or a new driver is threefold:
> 
> 1) the expected kernel driver to use the functionality added is a netdev one.
>    Current internal CXL support is a codesign effort, therefore software and
>    hardware evolving in lockstep. Adding changes to a netdev driver requires the
>    full functionality and doing things following the netdev standard which is
>    not the best option for this development stage.

Not sure what "netdev standard" means, and not sure it matters for a discussion
that is constrained to how the CXL core should evolve to accommodate
accelerator-local memory.

> 2) Waiting for completing the development will delay the required Type2 support,
>    and most of the required changes are unrelated to specific CXL usage by any
>    vendor driver.

Again, [2] already path cleared the idea that early plumbing of the CXL core for
type-2 is in scope. Just need to make sure this effort is focused on general CXL
specification use cases.

> 
> 3) Type2 support will need some testing infrastructure, unit tests for ensuring
>    Type2 devices are working, and module tests for ensuring CXL core changes do
>    not affect Type2 support.
> 
> I hope these reasons are convincing enough.

I am happy to have general specification discussions about core functionality
that all CXL accelerators need and plumbing those ABIs to be exercised via
something like cxl_test.

I expect that cxl_test only covers coarse grained inter-module ABIs and that the
fine details will need to wait until the accelerator specifics are closer to
being disclosed and the real driver patches can start flowing. In other words, I
am not keen to see QEMU used as a way to proxy features into the kernel without
disclosing what the real world consumer actually needs.

Now, that said, there may also be opportunity for targeted extensions of the
QEMU CXL memory-expander device, like DPA capacity that is mapped as "EFI
Reserved" device-memory, but lets talk about the specifics here.

Also recall that the current CXL driver does not yet support parsing CXL PMEM
region labels. Support for that ends up looking quite similar to an accelerator
asking for a specific DPA range to be dynamically mapped by the CXL core. So I
think we can get quite far along the path to enabling type-2-CXL.mem just by
flushing out some of the generic type-3-CXL.mem use cases.

> I have decided to follow a gradual approach for adding such a driver using the
> exported CXL functions and structs. I think it is easier to review the driver
> when the new funcionality is added than to add the driver at the end, but not a
> big deal if my approach is not liked.
> 
> The patches are based on a patchset sent by Dan Williams [1] which was just
> partially integrated, most related to making things ready for Type2 but none
> related to specific Type2 support. Those patches based on Dan´s work have Dan´s
> signing, so Dan, tell me if you do not want me to add you.

It is fine to reuse those patches, but please do include:

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Link: <lore-link for copied code>

...so I can try to remember if I still think the source patch was a good idea or
not. Again, a summary analysis of what did and did not work for you from that
posting would help me get a running start at reviewing this.

> Type2 implies, I think, only the related driver to manage the CXL specifics.
> This means no user space intervention and therefore no sysfs files. This makes
> easy to avoid the current problem of most of the sysfs related code expecting
> Type3 devices. If I´m wrong in this regard, such a code will need further
> changes.

Not sure what you mean here, I am hoping that sysfs ABI for enumerating objects
like memdevs, decoders, and regions "just works" and is hidden from the
accelerator vendor driver.

> A final note about CXL.cache is needed. This patchset does not cover it at all,
> although the emulated Type2 device advertises it. From the kernel point of view
> supporting CXL.cache will imply to be sure the CXL path supports what the Type2
> device needs. A device accelerator will likely be connected to a Root Switch,
> but other configurations can not be discarded. Therefore the kernel will need to
> check not just HPA, DPA, interleave and granularity, but also the available
> CXL.cache support and resources in each switch in the CXL path to the Type2
> device. I expect to contribute to this support in the following months, and
> it would be good to discuss about it when possible.

Yup, especially CXL 3.x Cache ID management. Lets talk about some ways to plumb
that, because it is also a general CXL specification capability. Another topic
is what is needed for CXL Protocol and Component error handling, I expect some
of that to be CXL core common and some of that to be accelertor driver
augmented.

If you think we will still be talking about this driver enabling in September
I would invite you to submit this as a topic for the CXL uConf.

https://lpc.events/event/18/contributions/1673/
