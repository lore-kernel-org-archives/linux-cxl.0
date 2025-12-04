Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D11DB54C
	for <linux-cxl@vger.kernel.org>; Thu,  4 Dec 2025 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869170; cv=fail; b=eeNT4HHZC2eZC56pIRnSt+ftQx2oy9DGb1h8cPWhL6EMSn2+NAE6faZtVF8JVDeq4nfU5jUydc3lw19XzDIIr2Wucscs61XN6lqd10n6taB2UuRyc+sO+G3PiOA/fjWP8uYFH6pbka8mCNoN6z3CMQ7cVYyEPraqd0sYEMckThQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869170; c=relaxed/simple;
	bh=8AXLTVhXdgL686GEXVHyF0xfiLTuo5kF+vc71/z2OZw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELwKTyoFDwhC7LJQPsoLAh5rE8F/fBYdsQNqbfKb528gxlclmdIZ4opr8PKPLVYC/vBHMzMM2Adrkkxwv57q3MVUbmwlIL137LAV2U+3TOfhwwZteesKtIQkPwfU3QZhprucNUlgo+ejI6UsajBwCKPRTB6dcePkjZGd0WR1ngk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzKVXgV6; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzKVXgV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764869168; x=1796405168;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8AXLTVhXdgL686GEXVHyF0xfiLTuo5kF+vc71/z2OZw=;
  b=LzKVXgV6Y7+LgRZjZwBfnSgVQGTUae35hWmi1ore+rdHinTpjCctQ7U2
   fnzPbJvX3jxswnVPA/RCudeetUDZD9tfs1piSc7muqyouC5WTtDh7b7nL
   J1NWVsCdlIMfeXUdZSBzF2Qj8rYa8P2nazH/4gH5UKL41xDCwWfu66w9F
   QwdwJe9k5jqwrUannnT9WpVN7ldKjEfcrPfwBZ2PavcQDJmFTh9XaJp16
   GsTD6lsLWWsbO5QSzMJFkbmXFfIMeAs4ogX0jGve2oDYKoIyxsrbOXJqy
   6bRK0ijuTqyAOpMXI2uD6wJk4SyCJWccKAGgkGrhRlCOPH8vZbXCxUPBP
   w==;
X-CSE-ConnectionGUID: 2ncsFXNMTseHSvyBuIhvjw==
X-CSE-MsgGUID: YmoINqjfS7aAnWBRYMfWZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66972069"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="66972069"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:26:05 -0800
X-CSE-ConnectionGUID: 6JzzyhdQTFKu+bk+L6Pfzg==
X-CSE-MsgGUID: Xu83d3wnSE2WOhxxhwwujw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="194859407"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:26:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:26:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 09:26:05 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:26:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/nQTU1DMZ+v2YABN/F0xKSEkk4TBXAmJJqwanZQj2HiVAxjsJ3MFk53hTr53776kupHqgQFUEKz//ZVHCSAga71fAVZIoni5o541WV2knOXRQHfMaMoiPRYbFDhqB3eOeE+QNe7EFgOAMOZjRxuRukuUa2uKfdZhWKRhITM/yYa4hwJe4Upzz9iElw+Bo+j7UiTQ/RmrE2rPZAdh9rEGF5jV8sgPqKxiSyIyZwkiNQJw2SFvBTQ1wPbTAK+nkGmtSum+/dd14M9LoJXCgrxP5TVqurGLi1GtrgqtkVIfI/j0P6k/9UjrExUvy12iSy+4ZGEcqEvwhTNNbJQAMqvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVkwnY8ntwMPdQEu5V9mR57Qgh02vy1yJVvEhcg3zXU=;
 b=IHz4CW2Vt46RmGV6mNByIV9iOQvTPKevr8Sa73lEtzYI3TsOY2GgMrEeygqP4Ip/oa9pgmtxHioW+caqtJHpg8sv6hQt+rFBK/iToQkpYEvwcwHnFjbtTtacdTuKTrV+dBHP3m/x1CIhwIzyc77NUNWa+oe/dr8D4d+W5eG6nrDv7qcYwHr4hpGuRjtmFzzDPhaKuKmDwNvZ4DahmuKnNNhyELyLOB9MhpXPdUTrNjjrkiL5UZ2I0e3k41r1J8qIvTmKBzkwb/vteR1rnGpAKhHIUcHoYH3Pd6O3i2TnsC02pb55nv2EeLzvY4nWfmT+S9x+mYZH9Ig6gfs1AanZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by MW4PR11MB6885.namprd11.prod.outlook.com
 (2603:10b6:303:21b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 4 Dec
 2025 17:26:02 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:26:01 +0000
Date: Thu, 4 Dec 2025 11:28:40 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <anisa.su887@gmail.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <nifan.cxl@gmail.com>, <dongjoo.seo1@samsung.com>, Anisa Su
	<anisa.su@samsung.com>
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251203203540.1091827-1-anisa.su887@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a52bc70-e49b-4ad1-cd41-08de335a324e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cUNqgq4964LunF7VX59OX1hJfL+/gBxjOLFcHLSRfDNMVivavW3Vx/ZAaCu5?=
 =?us-ascii?Q?hHjIso5OcgRmtmi56EFF6obqC3vqpInQkLr7bZQo0TBQSKejTHrqi64G5Hak?=
 =?us-ascii?Q?PYFrUby0gB1iLukkFIpFEz9dVQ9Paxx8pcDkWvhPoLzMKeFa1QwKI2L8ZmYC?=
 =?us-ascii?Q?LfsuLSDws0n+Hm0/v3OIfHYGdwJOJylEfuFF3gX9pa96x//tGETSvMURQeK4?=
 =?us-ascii?Q?NXiGu8RgLpEkc+AQzvzKKtyb8q/tj7AOYnumJk5x/9if2VfnHmBnIS7i87N7?=
 =?us-ascii?Q?fM8LWt5jFfL6AxfPQZQkje+ahhBeRY58ad9N9WNf2Iujepzc5kIYj7ys+Yss?=
 =?us-ascii?Q?rOQjE9WEPGV1la9/BPKcJCDXuMZ9riDYr+SQXdFZ3zVdq0oR8uUNclegLI9T?=
 =?us-ascii?Q?1D5ZSuccM3BMDkkDJPNLwbpVshItyYu2igWEqt+OrnM2TFjdF+5Cfkt3mzpu?=
 =?us-ascii?Q?1eR7EI2eXyTQi9CZHm1yUi/CBHdUnNL/ZfezL4ayyBhWAUzUR57yZFYCOHs+?=
 =?us-ascii?Q?LJbfn2Lt8XjDA4oLF59Gt3wFcp8RvVAD4jH+sBMpP0dL1e3KNJ3+TGrYM7dH?=
 =?us-ascii?Q?hIjau9dshRFi4FpwKALpy2gmb9dqfAQcq9MyU/f/hgzM+zV2C2Tmz4Zcq0FS?=
 =?us-ascii?Q?huIV2VKN1kl2gRr5Xnpi33czUwnot550ABRVfZj1ki5jyE1fekN+z6nuS7tD?=
 =?us-ascii?Q?3NtfXwot/ik2orycq8GYXjEYEcHE6UYPeWkXw8PhFsbRYpvPtJ6NDMiVOddR?=
 =?us-ascii?Q?/iorWaKZcxjUYXm6zTD+APNNTSM/yWESMlUSVtEEFuPukYsGCugcvDzpRr2Y?=
 =?us-ascii?Q?HCbwph5W7rG2oUhOJWSgxDYNwin+9Wnp574mu9QKm7YKxD9cuj5V6PJTwpmw?=
 =?us-ascii?Q?EYN/BLUxJCPyuG7nWTAj1aG3YhzTN6cv8mIbbzffMPw/z4KXvb8MMhdRAP39?=
 =?us-ascii?Q?XMwdV8iUG6d63HwLN8GvtXwI4itaT4ivEI1QHc4o0KjUR9SzHFFCahfDusoD?=
 =?us-ascii?Q?iCBUT312TEzkuE5OBfJaOW5Gz2cKgpldBaQCdK76hdTb8XW1DcYUYl/INky8?=
 =?us-ascii?Q?7F8RdVsTTxEmPOTW9Ig78xRXFHM/qVm5A2lQmbeW+S8uDTfNxpTAsw6iXl1M?=
 =?us-ascii?Q?gCqyV5jW4NbrlAM6cp6DT7dygAbWG3m5QTZxlEwApz3K+V3rvRIhKj56KgJb?=
 =?us-ascii?Q?L4BHTQ9M4u71keu1J1YnUjp5S00J4JHAZhPjOUyaHCNR6LHF74bG5xrdfHA/?=
 =?us-ascii?Q?3awoXkLMrXfl81knl6ILGQb4bF02WgSRi0ngYsDEOcPAXtsoV87u0FCnhgNy?=
 =?us-ascii?Q?fyt5ouUP/E2xvKis7YCPdiZOUWLISzSNf8+JeBpf/o73VtyFi9VDU5SpmctD?=
 =?us-ascii?Q?4o7ZgH4WRt0UFmBDo0SQjF+GiIcSKMnoQUfdgYRRJGDhwySAVp57auT59+3g?=
 =?us-ascii?Q?DRKjLk971pQkMZc7eNC4Jw+adlMnAwQQKAmy+OxC1M7wvuJPJT7Pmw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6PsgUuq7sk3C4S+Qeo2VIpFxemCSz08dsCqDvKpLuRhPi6RjIiRXdUWwbo7C?=
 =?us-ascii?Q?Ouh1a8SFICisvwiravX93TjhpOJvyNSS6zkRYibtvNcDeXIydWWZDPeH1kiw?=
 =?us-ascii?Q?uMYSur87xNZ9X6jaes70Gj1BjTshR0psJV3i9vPA9yom+L3t48Nzs5mkSnRK?=
 =?us-ascii?Q?JmNy5VFVkqL4Kv4BwEYDy88/yvT3AKuJzX6vlxq5ILXZTo5shqvn8U75ADid?=
 =?us-ascii?Q?qVSYoec8L4R33mBJ1AQk1P9IjBXQFFhg0LSBmC8nGQVUB9swCONwb3Z/RX90?=
 =?us-ascii?Q?4pQ6G7UUG37u3UGM9I4+nATXAFivOdzLm0Z+mlAv1emr1qqbUYqcuUQyHcv3?=
 =?us-ascii?Q?mmfW0cVoSuMR5Af6frtbh32u7TEVlLQorefoF90uweVluAcsJjASyCgBgDnm?=
 =?us-ascii?Q?m/RIff0PYyBcyJlgeRBcOA2MOhnLvztbCANmP10dwrC33H1jaX2y6IHXyGK8?=
 =?us-ascii?Q?KKifas/ZgPOi6xmDKIPB31A7qSY/S7mkasfFKMTXNbIVCi73idycUlBYeYj/?=
 =?us-ascii?Q?jFQiOTHEinxGWLofNq79GEVptSN1JvWEPCZycr3FJrxPF9EAmzZmpaUvKZMX?=
 =?us-ascii?Q?bFPvFPvAXseCa1cZ4Pjj23WBSSRlwfS1uR2z91zkE9DZPu6R/fKjXsJbwCVj?=
 =?us-ascii?Q?orMj/O6L+tAugMFbLh+VT3nWXAjU4DMfLAfve9y1+h8DkAxNcFS+JMOOomBz?=
 =?us-ascii?Q?bE6XjQ86lRBALrRXmFcW9Gl36WcGcs8oe/MXQ+RbcwZ/AAK0vh//5C51rFjt?=
 =?us-ascii?Q?YDgX/E/SMjnjVQQsukgm02A46BDTYKIC0ww8Z6RQ9pK4Q4tuLU8GG1wfxZHB?=
 =?us-ascii?Q?3akRXhQww3T1yswuA4Q3a9fnQxPyHkELmirwaem8zBEGSnScj7mkcd9JVxFM?=
 =?us-ascii?Q?pyUnKmf+7T5Jobuv0OfX4RRGG4G6umr9940rMM/Hi3I2x3T5kmlRb9oR3lFq?=
 =?us-ascii?Q?aTS7OYrwBAvmBv7GfbJTaEhRuk5aSi+U91cZPKJOaP6py7b/OlvbbfEOGMuC?=
 =?us-ascii?Q?qPptKVF12Sr0yFCSXYYZXa4+p0R1SdAxgJyFpp3UF8LDOLPPkXzwIry7IQiT?=
 =?us-ascii?Q?EflOqBD2Haiv/9brvQM4nz/0cyzaizk3XCVum6W/AAN8F7tbTuYosaxCEU2P?=
 =?us-ascii?Q?TQuTGoZCKFDiw9nTRU1VfN9YRySpZ8kEVIbzbuje6pRNpHal8Sdb3zLFe5lA?=
 =?us-ascii?Q?reidOjAe5GrGn1iymEXG09oms+ToNj70H2V5w2azIq9fMNy7mTmCeTchLUTj?=
 =?us-ascii?Q?AAsL0Cvx6MQMr7v0vHY9dnB4kMBQ5PdwymYR68QXuRSrJBLZ+9spkPNJ99O5?=
 =?us-ascii?Q?mFcTNullqshqHqdpXDqWemgI9bEmCjQaUf7EzjiifpHteOo8qesjJnsnRsVm?=
 =?us-ascii?Q?tRQjyot+zIOxautK0ejcvIpokEg3fKRUyKgPK3qiUUciI0684nTM59bH/zrp?=
 =?us-ascii?Q?+CvwU+XVymn9WucirQuBNQ5ltxt+oVgwTg04gS7H/8o9e3Ej8K+NB8w0HTyu?=
 =?us-ascii?Q?vN63O5rrUpIBMKvHShIC0Paxob0unirfp+PBoGDVyhtpjbk4yD4Iu53GhA+L?=
 =?us-ascii?Q?Sr9RCn1in5imLQwtGE8rGb9k4jOa4iPG3jN+Snkn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a52bc70-e49b-4ad1-cd41-08de335a324e
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:26:01.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2O4GeYCjvT8Pxn6RutqQH5LJw+3k+SzCbDNRObhEjhj77xSK0S0pp/VMpL9ychq8lAwW1O1MR3Aaa8vYvsl9cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com

anisa.su887@ wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> This patchset introduces support for multiple DC regions. It is rebased on top
> of the latest branch published to Ira's repository:
> https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-09-23.
> We hope it will be useful in the meantime for others and restart some
> discussion around how to move DCD forward.

FWIW it seems patch 1/3 and this patch are both bug fixes to the DCD
series I last posted.  If so they should be tacked onto that series.

So, you are more that welcome to take over DCD development.

However, I had multiple DC partitions (Regions) supported in previous
versions of that series and the community decided that there was no use
case for such a device.  Based on this submission it seems that me ripping
out the multiple partitions was incorrect.

> 
> The corresponding NDCTL support can be found on this branch:
> https://github.com/anisa-su993/anisa-ndctl/tree/multiple-dc-region-support.
> I will reply to this thread with a reference to the thread for the
> NDCTL patches once published.
> 
> Testing:
> This patchset was tested on a QEMU VM with the following topology:

Unfortunately none of the details presented in this cover letter really
show why the kernel needs this additional complexity.

Can you go into more details on the use cases of multiple partitions?

Also, did you consider to use previous versions of my series?  Perhaps v8?

	https://lore.kernel.org/all/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com/#r

Thanks,
Ira

[snip]
