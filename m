Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583E41C6A
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051990; cv=fail; b=RiS9JvWiISaVKzFu5hUiOWb2tb7a6+4i84XG0wLFMr88MBi39RzhqthITtbKOr4rNMwNDEiyXrc9WSoO15AFnQ8MpAQXA7QxzwdCuoUJy7d9MNvFtcBkwQgchcxsuzcTBCoIFfLcLfsNGHGEv9KOo9Xt32OPdA4bb06ANz2B4Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051990; c=relaxed/simple;
	bh=K8RHZh8sWNq2VBM2t4CHhqc2rNiyqykzqSO81JbJsLY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EDOeQafsJ6wJ21x4yV0sZ810G7u2tq7ETiC8Vht7IjWylJud6rpR9Q0LvlsoAq0ZdMs0c7zl3WEfjrmB6JiNYfSfKy6sx80qMns5oAcyV+uDcoIYqvpJMTaT5BhuvOkK64M+EphCsSCmsg4HFXAVj6dY1Sq7OlwLGVT5R2/vlyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hu9ojbUz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hu9ojbUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737051989; x=1768587989;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=K8RHZh8sWNq2VBM2t4CHhqc2rNiyqykzqSO81JbJsLY=;
  b=Hu9ojbUz9MTE+9YoDRiNXWghpql5YstQBL3y7ZDURWP8+0H4MpOLrkV9
   4g0ExLKqP1uxRGBNoObScQguo7WRJOFzQkaf2BlEgrjmDENQMfptcPTAX
   wQftRqJbPBKB5PktM5P1KT/A6tSdQ1BuUm1AyYDEJkQWMnZM8vqVMgEDp
   mt0H/WRtyHQyKycZFDZCAhtiZZ95J5VBJ6TPJGSw4MGH3QlMgqYMd+b4W
   WkeQWd262CSeONVRbP3cztXVHacZ0v81nkt7Ci5vwG029uIO2Z0oBzodT
   T/910IGRZ1bqcSRN7iE+ISrsEDoYefu7mYe+X9rkZ3IaqyIVkpne905FM
   Q==;
X-CSE-ConnectionGUID: y3oVnP4USOurBjMtKeYETg==
X-CSE-MsgGUID: cpcod61aTPi7t1S5fMfLww==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37339143"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37339143"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 10:26:28 -0800
X-CSE-ConnectionGUID: 9dQ/Mf4tRwaYl1oAqpPHVQ==
X-CSE-MsgGUID: TY/OdVlqTFW2s7w8hH26eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="105724027"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 10:26:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 10:26:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 10:26:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 10:26:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVJSd/E2Su9cQR5IPAtrGdu7zm7a0p9Mf+OyParnlmMFtz6Ewj3KDg1oUOVgIMSJg5gbL6w+eFnm/CksqVI4jJViHEn1pJKa/ukD7/bKeiU1U+yEh3LWWPegyoHmVtfJkOQ5s4O50kniCIB3r+nP5At1HEA6dmRl0YSa6s4e//VuUUKlPJxW6o58XhoZKJsMKWpxGxm++yFcM1UQl5WfR+HoP8eZ1mfHThrmzuZBKCIY2vrkGu7xX6SJYqnze9SyHsOYaSGnii/bvR8n/6ZLb60rQ99AnOZCiPtir9iVldBZfyLUOrOlYha+d1BuKLnQPtMTT01mIV93HlHisDLWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnKv18HK0xRQ2UGlCHZ+GZeTQ8k6Dovt7PZji0ST2G4=;
 b=wIr4nDFqW3RlGn2Yr8hC8CJ60cxFcCLscQ6YRyhx3QiQskS9U03aSncqg/qSFUcyY2XPSb1L8UWGCGbbcfxAuIFfWHH86Yt969g/NauVXCdGxPHxNM+7kTEy65max8XF14qhbqdhjGIkCSzsHR6ac+SsnsmGcAQj31ziWUCTR04u+r+Qyn+klvqCtgFO0EodoLT8INlGPzHIHgSETsRZH1VbEdrO6YgRk1EAvWNvThtnfGTchnG8SKcagqUIAgVOnMOkwZn3/J6zaAfr4UaIIu1SRss8s3jxzF7apeTkhnC+5KvlaQo8udKt1qxSBhmHWUBHgpGTfkNz4bZ8zPeRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6432.namprd11.prod.outlook.com (2603:10b6:8:ba::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Thu, 16 Jan 2025 18:26:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 18:26:24 +0000
Date: Thu, 16 Jan 2025 10:26:22 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, 'Dan Williams'
	<dan.j.williams@intel.com>, "'linux-cxl@vger.kernel.org'"
	<linux-cxl@vger.kernel.org>
Subject: RE: Assistance Needed with CXL Memory Region Creation
Message-ID: <67894f4e5ed6_20fa2946@dwillia2-xfh.jf.intel.com.notmuch>
References: <OSYPR01MB53525FD64A9AFBAEEC1E19A390112@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <OSYPR01MB535212BCA854FDCC57DFFC1C901A2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSYPR01MB535212BCA854FDCC57DFFC1C901A2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 64912c89-aa78-47fd-3b1e-08dd365b484b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D2SMcM3OMzYEf1fjkMS7EcEEaDvUYWoRjtcAtTwXIAP3u6kAK5x5hlQUUbSy?=
 =?us-ascii?Q?6cWJpHSP+3WYxzteQFH1xroTLVAMADjBphOJAIHJmh1UPC/r0IucPE46a4i0?=
 =?us-ascii?Q?K3bMmWS1Z+xaYhXN8Z58LmX8qAFW2SydSuS7U5QmE3P3vk6Pheuf2OdzMWNu?=
 =?us-ascii?Q?/NrBiqiNpsUgcDjt80ALy6wLGaK4gfApUdMCChee5szWvrKO3SvVmwNi2nlB?=
 =?us-ascii?Q?cwUn08FMQdnGB7JK+GCIvvY9fbFe3wT5dLIwk87bKJShPpjHga4ZjHz0VgvI?=
 =?us-ascii?Q?fE2s3etX/SPhnMrR98lWkoWUcf2ejpSZ6Bjke6vWFVbb1H6153gfzavLqQvC?=
 =?us-ascii?Q?4raM6nAeq5wlOJXs8mrra/NZ4S9mmI1AVATM/lz/oeKEAXvogCC/L+2Qa5Vo?=
 =?us-ascii?Q?pR2yghfhU+7gy62aAsx3FIZHP47L3BXR9aiaTZSxpt/Xo0u7DquWwMgmz1Ma?=
 =?us-ascii?Q?pr8Bzagz21lPRItS1EiTVONYEN2nemISfJ/tJwZOAwVJi7ktdsx7GFDzXzx2?=
 =?us-ascii?Q?WlTdt4Kya8fk3sZ4fUdd0RgDPM6ceb8W+V+BPb+pau+HBaGaIEJFC1gd77Ca?=
 =?us-ascii?Q?6sTsEhve0gOCYPrmbFUEya8QVKNVj8RnRqMfKKLhNzswENkSSUuHW4zXR0mE?=
 =?us-ascii?Q?skhV2AviCsRhDWWAw9jJSw3XxitGwuKl71rxa3U+CB+aRiJHJmJKNl/WIxkb?=
 =?us-ascii?Q?rxfP+znrg1Dxwv/w4PkHqvNf4TXLFu5NdAi1MICVjN//T4cEx+zBWC0Oj7Hv?=
 =?us-ascii?Q?8nMRwMyGFeqreZhQFwzrLUJVYka5tbi7EQBj9qGxGftcyS13Cqqc6DtAXnUb?=
 =?us-ascii?Q?H+V7wT9kqPJntnNXQT27y0bEHo0/7Rghzb922sb8N2HPfXBQlHD0o9fnVCgd?=
 =?us-ascii?Q?TL54y174HIusamzWvM2O2pEY/EhbTY1Q037FBN5qxZKBb7zDR9G2KkrbTcYs?=
 =?us-ascii?Q?hkO02zVAhLb4R3Jb1JT1IumW5mB5y++Y+/1G64ioFuiBnCULrbZtFQugpK5C?=
 =?us-ascii?Q?vYBDSQSWaOPLnAaCdX3ytDidzLpcwfH0BCk/z6oxs0quSD57QIjKa8CjwcLq?=
 =?us-ascii?Q?djwkyLBqhZCin3sLHDaUi5yOuwtvk+skh2cdsDA7uVQM30tSmT1q+H8svYfV?=
 =?us-ascii?Q?w7fSHSjcCJQEd5p8hd7YGXGbjdfqdYH+QT+UB5VJubRxVsSw90zrm1b4tYHM?=
 =?us-ascii?Q?CBBGeHGz3LfhoH8sx6Behq20zOoj7SWJW4Y7k7luJD+iyRvdhU3C7IR9xtk4?=
 =?us-ascii?Q?MmnsBt+jFXqyAC+muNAXD5aqQcorv9tENzDdFJGkKSMJUj9C/u1wk65zH8sS?=
 =?us-ascii?Q?bDlXTdYyKUx/pa8rV8xmf4Bavyd/e5b+MFDwZepO6XFLSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LpkErmrHr6KxeRKv845lq6j2y3IpHDt9ZRA5habwIClmW35lU2e3euDpcNE0?=
 =?us-ascii?Q?OcBYXutnABQ0jBqo9PjY9q4Gqulc8uSGH6j0E5R35Oh76X3gBLaQlkxVEKAY?=
 =?us-ascii?Q?B6DhNWJwM03W0GYZGr7/PJsHqqYUI1pb/tz0bSSrHlTununyWMD3tWJIiX9C?=
 =?us-ascii?Q?BcoXAteQDXJ3wv+n4N8vBzh+DcudauYPOxdXsL6G8ecAzCAmSpYQ9xxa7gxp?=
 =?us-ascii?Q?IN/Np/1P8Vbwy7Fs3NHm54NYOb19lUMjJzYfbgLe9g/XasvgQfBG81ZZTX7h?=
 =?us-ascii?Q?rG8rw4QcZovH263MjkRdmjoHV8+NeoMqECo1OdRVxk4Eg75yktpV9b65OLmA?=
 =?us-ascii?Q?KIBM9G171pt3rJ8ra4Cxqid7M/QmNKoK9Bs6vnLzoYy6O6W/qO4qRjP2ONED?=
 =?us-ascii?Q?Y6XgvHcuMUVYLkgi5I9pLmVINXBI0GDBpf6hzyrfq4392a/ePchDKNgxPyAg?=
 =?us-ascii?Q?Hs5bLprVSv2ygZ6AibjhwtIOo8pKxZNpuE5595zU4GqCNnJFkUNM/KFXGo3J?=
 =?us-ascii?Q?Hn/Jbs1PMfCQ1jsEc1wDRNFRh9mCNh6yj81Et9rYobdSpDvAvcmi6G164LUp?=
 =?us-ascii?Q?f0H3x9UEyKr297Q1mQdQ+Ea4bj6sNL9+oLZkKGyBmlPF1JhxsndQ7iH3lAYw?=
 =?us-ascii?Q?nSa+XNxza1wJVqt3wCmBLANeEdUeq0eDzPEO8HGHcO4MLAdw0cgAZUsT9wP4?=
 =?us-ascii?Q?Hlky7/FtpBS0AFNNJ66CH38rCgPcBPJkNtOVneQLcoO06PRcn3Mq0O0o7RwO?=
 =?us-ascii?Q?bdjow15Ptsht8bzy7M7m3WfGZFLZrhkkuLZ2UvjX3FJRORKS+tycQJ1kg5dC?=
 =?us-ascii?Q?DlY4Gp8+JMeMXgcbzv0yvUcJQotQwIEYQIDwkS9bWcxvjL4yUS9YGNvHtOvg?=
 =?us-ascii?Q?VxjkBSHmFFq8Sn82HNy9zo99GacsXx+D/NNxo7FLoyx0hrvdtcFAIDjQU2dB?=
 =?us-ascii?Q?7Jps8r5EEvOyFCjKNIX50eKobXOBdz7Vt73zuIVCwJTsOg86rrVIoAPz89pf?=
 =?us-ascii?Q?jNizC8GFoUMioUnokSDYjGtGAMsWf9SX2zmR8a7qbYPnvbURPky7+fo6fwp7?=
 =?us-ascii?Q?KZz94a9ugwalPVeLq7KIJqb54sGwAf3BItOj+xUOpwg5pLurBIfV48GPvm9/?=
 =?us-ascii?Q?NQi1rit10xoxulnkTjml7pBBK2wFJQEIVi6doA3VZVB+FkLR4R6zYQozs6fT?=
 =?us-ascii?Q?LjlHkFvpt9S+1dw4JZHa75Aa+a33pc+8IRByPjENDtjEr5zqRbI9FhhQK4zs?=
 =?us-ascii?Q?xsHxjGtX6NdzJa5vpFzCQnpob5Uf5PfWF4HtuCUn/ezW1NSr6u03QkUJNdWw?=
 =?us-ascii?Q?I/VxCysgZX7WNWRLl1ojSZgPkWXBIVLSJg8CKUtlNbmTHsO8Q/z3l575iS/P?=
 =?us-ascii?Q?1iaWgn1Z5ItfCfh6PsiGR7t1svM64trP6hKOdAmB+P0tpMsx0YZBRYrnTKuj?=
 =?us-ascii?Q?Q3jnrKFrmiw/x9BZwyMlfzvoZ/gBeszXfjfcBW/GX0hjXH2I05GTKJGVdinT?=
 =?us-ascii?Q?2hjoQSAllCdQWJenqFUDvgzrlGwHU37FvtmEzkceVOXg6RN4SPxRVTZKuGTF?=
 =?us-ascii?Q?4THbOtSMVUfnBcMuInRva+xqkPkwSanRn4I9vhnK5d+G99e8s7lwXLFmUtvc?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64912c89-aa78-47fd-3b1e-08dd365b484b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 18:26:24.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORMIcguUBw09DYG0OmOOEb22vhlOiqa8KXP5eC2HMDzVwkqiYhBl1gzrKTRFw7oY6I+iarf4LPjOYbXTdM99IBCh8h2G7qbykdtP53usXTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6432
X-OriginatorOrg: intel.com

Yasunori Gotou (Fujitsu) wrote:
> Ping....
> Is there anyone who can provide information to help resolve this issue?

I missed this earlier... holidays + merge window opening == inbox
overflow.

> I met this issue at kernel 6.13-rc4. Are there any fix for this issue? 
> Otherwise, are there any kernel version which can create region under the special purpose memory?
> 
> I'll add some more information below...

Thanks for that!
 
> I think cxl create-region should succeed in the special purpose memory area, but I cannot
> understand why the above code results in an ERANGE error...
[..]
> > Below is the relevant section from /proc/iomem:
> > ====
> > 89d500000-89fffffff : Reserved
> > 8a0000000-189fffffff : CXL Window 0
> >   8a0000000-189fffffff : Soft Reserved  ------!!!!
> > fd00000000-fd03ffffff : Reserved
> > =====

This memory map is saying that BIOS created a CXL Window "CXL Window 0"
AND it populated that window with a CXL region marked "Soft Reserved".
The window is fully consumed by that existing BIOS created region. The
expectation is that the CXL subsystem parses the BIOS configuration and
creates a "cxl_region" object as a child of that Soft Reserved range.

However, for whatever reason it looks like the driver failed to parse
the CXL configuration. If that had worked the flow to create a new
region in that space would require first deleting the BIOS created
region.

So, the behavior you are seeing is expected. You can not create a
cxl_region in a space that already has a BIOS created cxl_region.

The work in this patchset [1] is aimed at making sure that even if the
kernel does not understand the BIOS CXL configuration it will still at
least transfer control of that address range to the device-dax
subsystem.

[1]: http://lore.kernel.org/cover.1737046620.git.nathan.fontenot@amd.com

...but that's just a fallback crutch. I would be interested to see more
details on why the kernel failed to assemble the region that the BIOS
created in this case. 

The overall flow is:

- BIOS creates ACPI CFMWS
- BIOS optionally creates regions within one more CFMWS ranges
- BIOS builds EFI memory map with the CXL regions marked EFI_MEMORY_SP
- Linux boots and sees EFI_MEMORY_SP + CXL overlap and waits for the CXL
  subsystem to assemble the region
- Region creation is only allowed with free capacity

The known bugs are:
- Corner case CXL configurations that trip up the driver (memory side
  caching and CXL interleaved with DDR are current examples being
  worked)
  - Reliable fallback to "CXL unaware" behavior when region assembly
    fails, should be address by [1]. A temporary workaround is to
    disable the cxl_acpi driver so that hmem_register_device() skips CXL
    range deferral.
- Inability to delete regions that were created by the BIOS. Should also
  be addressed by [1].
