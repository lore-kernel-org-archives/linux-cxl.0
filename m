Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630B1A3AB0;
	Fri, 31 Jul 2026 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456821; cv=fail; b=ppRGi/A7iq9C6MSnyhgOB2JXlwEM1QsJmSF+Gj9+tdL+LfZh/qs3Oc4DZOO8jQKoLAcusyA96V5DEAwgsV2BZQevpqJBKaXP1AxKMq6ZvbMEIjJdAylCVCFGvlV9oI4n1GSXMLwBF0UDRhkO6LVauyBMIBSl7keBq2wgdQ/x6Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456821; c=relaxed/simple;
	bh=tfu13eqNvj97BBbdXaTV/x1WO+onsAhqYw9/NdVoxzQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jXqArjEg2oqjrWilIUB8RuRXOtejl2wbaqzOANtZhQqYq8dbETsovqHx3fF7+8Ik1qFfa9W0RS+VpugcQfgxMj3UIbq0ePYVfukNCP0nSmD8ZdzUN2aOqJKJ70uH1Kw00rqlzJ6Ktg5cjKatCGGKTmSh2/oRFCy5yMPtHsUTyZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jacf21OJ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jacf21OJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785456818; x=1816992818;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tfu13eqNvj97BBbdXaTV/x1WO+onsAhqYw9/NdVoxzQ=;
  b=Jacf21OJZqOipif+h/nvpnlCzk/PmqAfZDRRjVadT+s1b+D41IUtWEsm
   9kmREpfeSMRBirxDd9AdvXbd+rwZ4F8ju4Z04BhOu3J7BmB8kyTl+Q4KH
   sOEzyr1WXlObxXeyVarA/F06FvQWzaN0zWJwdB8caCQgSl2V7KUEsmpEn
   KYq5dFansekIa9m4J0dUFB327006n+3sTIRDR/69MeWtWAyVCTJJEtq01
   zT2pPWmAfFGgLqF2zyFCC0njsGVCejjie00TS6dfWXxzX8YDFStwCwweR
   AJhZ49LsRCqg6RplxcrRwCm2r07pw7t/oFGoV6bFr/fb3gPsnj7VECU0i
   A==;
X-CSE-ConnectionGUID: +j1Rm44mS3SklLTOff3Egw==
X-CSE-MsgGUID: 6JwHCn6hQ9K6I8o1IsZuvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86099932"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="86099932"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:13:38 -0700
X-CSE-ConnectionGUID: f8C4B7+KSVaDjv+H+O3ZAA==
X-CSE-MsgGUID: CkUrHdcQSdq0XoiK0a8v0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="283769388"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:13:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 17:13:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 17:13:37 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.23)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 17:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9EjE0zUo6xP1LyV1xovXwJautxtCXYs5ch4keZzaA4w/ZARjPX8zxV0U59GOkMg0JT+EjJXTwjrHUN2pKar9D37cTiwkYFfqcJrts2/hbuE0W/wQ6l6Hg4tqDIcuCoI6NOgOJeVgzXaMsGoE34Y6FjySE22/FgEzwFCmhXnRi9fD14P648zQnMt2Q1akLgwF7oYQeDvXE+gTlp0AEjeojwhrJaaSKdXsf+n4YZGnRQk59509bb1xaIf/u8CU5Gf/trURBvMhpydw06l3Mmx9dkOLX3+Z0o9LopjvOpA4I33nNHVrOY4uz8hXB51UDfuyzOh4oxPNgRlcKFigeHfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kMU0E02hTNjPw83+q00P6kkc5GyukBzSS/MKLYF14g=;
 b=mZaKHxbsBzF/eMgQI0f0MSuL0KoT+Yml3berL9vrYnGtLY+X/nGIPviDpOg4fGyDOcQdjFWB90z9M0zJkavK/ZMmHDE74dH7HwLgo6m4Cq/KA8XMILu1oxFGn2UFl8zf3tZwbDTmCCFlZ80fOQZKP0yHIuoH+osNVQYaK2DKJnFt6hORCzg1ZEkz0qMvff934hqG2ncwxLLIsspuzXQLudDJZrZx1f2fjPR3qh14XEBV/wlc/4o7uFUTnMU9qW/uKiouTDP1Jb7zZ3TYyFLmtP7pDEeSb0f/QHo/Mt7NHt53Zjy2nueKfixKApe8cGLXnFd+/KbnJw6POMc8tSVcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 00:13:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 00:13:34 +0000
Date: Thu, 30 Jul 2026 17:13:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Jonathan Cameron <jic23@kernel.org>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <djbw@kernel.org>,
	<danwilliams@nvidia.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<newtonl@nvidia.com>, <kristinc@nvidia.com>, <kaihengf@nvidia.com>,
	<kobak@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>
Subject: Re: [PATCH v7 1/2 RESEND] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <amvoqnQLSYrMJxMl@aschofie-mobl2.lan>
References: <20260721085715.39322-1-icheng@nvidia.com>
 <20260721085715.39322-2-icheng@nvidia.com>
 <20260722013822.57335034@jic23-huawei>
 <amMIacsN91QDl9a7@MWDK4CY14F>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amMIacsN91QDl9a7@MWDK4CY14F>
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdde5a4-42fd-465b-5170-08deee988f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|18002099003|22082099003|4143699003|11063799006|10067099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: NAS8wRMxezuqOsnxVR6fBikOdY2HrJf/drOzY+1GYBczwSa4bMtzd3L7stxbnChKcHmBYKmg1ya9dyusIr0JOqtTiozzZb6j1+NM55wxCIfrpH4qw0xfZDXL1iMtEAIvnTQiSPze19qvAAgonDilgBkIXDhv913QEHqIihReN3veCMaqwKfdyLoZSO454PmkAtwlxVOXwKgHow2hVVKt17NE40jOOnoDf3P2cmNJla++KraNcviAAkWNLo9MoZEANt9yASk+/9+0vjefr+i5aNmGPEQgYss+uICZpT8cPvaCUQsR7vCXU3VG+0ZNKtKCeICd9I0VCW65QH/zD8q4Bpf4SOF7X1WI2v3IWHBWeag+hv33Tth1N45TLrugHItlW2byGaKwhvN8K1pMu5/nV1qjuhBj4dJFmllxCT5HOG5VOHcZlLdggHajrQeNfMuNcRPkZzFWuzljQ0iXlgi8m+y1/eVVMl0QZPzz6LTHleE9eSz75ME++26sPtNSF+QO3P1P3qexvAxK+ApIMgi0WNOG/tI9l5CabRAli1KCXwoXk1ME1+A3n+zNrXUBr1ezVOKFnuXrHVmqVBz6ECAAAuPlS37pqf4CavgfCtZWBZG1wRSgsBMraqQO+LxIPpOtcWZ86zjPyPX4Gxy9lxw5qTISdmo5l/KOe2zxgqQxew4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bQ2wjdpjmeUfK+3nm4o7Z08S+bhd1Vdodd4CnmhNc54M297FSXzS89hM8b?=
 =?iso-8859-1?Q?d50sfSQJ5OkzJ5/hc9yOF/GajvCq/lsjJIFPxMLinUz9rgzpLPM89TtJfj?=
 =?iso-8859-1?Q?476pccVrNA9DxT2IbM2ydfUhLmxpo+MsCHfUs94cJRyIGIPni82UI8OIaE?=
 =?iso-8859-1?Q?8gvY+JC+Cqj5TWBeVXHBL2JG/AxP75M0yC2Gt/h5LUyEeFRo1C+qusOQUt?=
 =?iso-8859-1?Q?3cmZZXkhi67eAymHel40zN9uoyQYWeR08b0IcdYiz90bC0aubiFRcaZ85F?=
 =?iso-8859-1?Q?uo5irg3g1VN6Aev/l13/JQmjkIfpHYibobckcQKkx4v9jXVm9ovrEpQ5r8?=
 =?iso-8859-1?Q?9nTuEDYRRSSh+buEJnWHeBsLxoj3A1x0HXkVSZCTLYRDSsLWAnjXrcZQGL?=
 =?iso-8859-1?Q?s007DaOQLRo2jFiclrimbGHopvwJP7YIZ6d2sHrlJTXjj5R0kX9DeP2pby?=
 =?iso-8859-1?Q?HxGExY9UdirCcv8wHIxVUKu4y1dCB6fXGwLMVIWHQwGKBezdIDp2iJfRFm?=
 =?iso-8859-1?Q?6EVDfg0Zll+Tc+nxhL4C5SEXTQVwNAEBxv7bE+3LFOPxfUIzWtf2fivE7B?=
 =?iso-8859-1?Q?yi+wCgFCQPONcTKkL5x1wZ1TO6cB0QZmAO4GxO1HosdW1gTUetr+9QUGkD?=
 =?iso-8859-1?Q?JqN+g4hPRQgAJ5FmImlr4wzGjH27CGABxnX9+NWwjh/T1pbfLgxwLzvEJq?=
 =?iso-8859-1?Q?BfJfwpY7CF1tRne8i27uka3g+uVfOL0Qp8adRHPEYzG/SbIIk//nyHibH2?=
 =?iso-8859-1?Q?4zxb1BZXQ99S75sE/liBtMMTKzq973qTnGhg/DFaNpkXRLEBsI93kruqk4?=
 =?iso-8859-1?Q?Ml0cfN8KQov4wQdOD6yMyBbBs/9UIj1AE3RgO6Iqz1tXIL3ON9Xlg5FQjo?=
 =?iso-8859-1?Q?M44xrqU7S2S2EIDETgknyHXWY5spnhB27wCXbtkZYJ7yTIKClTidKUlP5x?=
 =?iso-8859-1?Q?1/uC9jh8LF/AnS1c7uvAmKeZqeh6G4bEQVGXpIs8HpGy4KSKbrsIV5CN4X?=
 =?iso-8859-1?Q?+lV21iunbjSoQZU6Skumz/Zu8mSvmyq5BCKa/IS3Ibk/j+VSfK50qOpWSy?=
 =?iso-8859-1?Q?IWOIK7FJ/LVv+vlG1NbnJzjxL5vwt3ptwnUgkiV9qM6zdLN4KyFcY+RSij?=
 =?iso-8859-1?Q?Q5+1wgXzEbLnJhfG5MmJBu4ujMz0YprQ89LfUH9e3m/ZmgC4uWOF2SiN1P?=
 =?iso-8859-1?Q?YuSu8dcpA9njH3IwtjHAcweiHlC992OYCwdX/TOdGL0VTAGPvc8VS8ikcX?=
 =?iso-8859-1?Q?JQfeSQ82Kq5cfAUhf1/TFEh1ptXPPlmWf6erEZ7rTvDb/x0RyDtRTuylc0?=
 =?iso-8859-1?Q?I7FQfI7g2fOyd0ZQNR0tE8rBuXgXySXhYjFtDJ1UgGiF5GMbzBCs9ewmUY?=
 =?iso-8859-1?Q?cWitfpoYFlyEGBBo+C3LoopnAhFjXfFJpfUZbr+U45D91v2CGYYRKSDBxX?=
 =?iso-8859-1?Q?UozRpcX/yVCSK6sS3mP7xW1pwehCiCycrEXJEdTigKKx81b7WX/EAtKij3?=
 =?iso-8859-1?Q?BnR9eoSh8ctvSY9JSrQXHUBuGFx9tI5lz0FY4F5B1RSviKCyzzdAkYbe+e?=
 =?iso-8859-1?Q?4SvpO0Yi1wQ6aV04tCelojXYksjQJILLZ5PGw+kKVLJEaGkgDyTeHpmsLq?=
 =?iso-8859-1?Q?JYBXBp+G8pIlygX8Xa3da7kU3/rO8IKcgGPD2TNdNNkG85Pq9MXiHx9eeB?=
 =?iso-8859-1?Q?OoJJKrpZjRkiqbIigZnDxcE5aWxgUmENS4mBix+SroTKZFRf7fEAED2R4+?=
 =?iso-8859-1?Q?zFJE0QLHoD9gRjeL68+MR0qxfnNn8P/92HBeoCxF4Nja/6PXTwNi4IY5jf?=
 =?iso-8859-1?Q?kJHxySUMVJPCJg2ACbv/wLiEdlsCjDE=3D?=
X-Exchange-RoutingPolicyChecked: RKHXLc8G4l6GqhsJKMoIlHqZm+T0C5KyHknNHOkNv0bY/LPD4abB/1h4YRlH5DE/SWJgosMd7rE2V1jC/0BGwApmkTm2/jhSQvx0j6RejeGWY2ejuEs5HUVATkxN64H6nJy58SJvsyuovVTTAtywF3VvJzE1yZKvg66IxK4mk8rDp47gl0lDTKrMQSCUdqIG/e6+UuaohY5vt/P0DuGnMVKcfpKemg4QHsZg/ZnHhT1BNmUoEXFCVYv1dZsjuYHJH4Wv3hr2h4kPdVxXmLqn0r2YVBJ62KZ+uiTim3cjxsVInZIn+XpnCONXFv0t0xk5hQpX40m8gSIBmd7ykxo7xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdde5a4-42fd-465b-5170-08deee988f51
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 00:13:34.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrViLSgGi547sl97ixi0l+mstA1gO6QIKlBjuhcNY5QEfDeVxE698tsygHSzfGLdfDdgzxso95H9fqCQdAa3JHmF/A9I8DG3ZrHnEoBZAic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
X-OriginatorOrg: intel.com

On Fri, Jul 24, 2026 at 02:50:27PM +0800, Richard Cheng wrote:
> On Wed, Jul 22, 2026 at 01:38:22AM +0800, Jonathan Cameron wrote:
> > On Tue, 21 Jul 2026 16:57:14 +0800
> > Richard Cheng <icheng@nvidia.com> wrote:
> > 
> > Hi Richard,
> > 
> > > CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
> > > ("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
> > > with size 0. BIOS may commit and lock such decoders so the OS cannot
> > > program regions through them, this is a design choice rather than a spec
> > > requirement.
> > 
> > Trivial but consistency in commit message formatting is good. I'd always use a
> > blank line between paragraphs.
> >
> 
> Sure.
>  
> > > The kernel rejected these with -ENXIO during port enumeration and aborted
> > > the whole port, so affected systems showed nothing under 'cxl list'.
> > > 
> > > Treat empty decoders as first class instead of special casing them, back
> > > them with a kmalloc'd resource, since the resource tree can't represent
> > > an empty range, and keep the skip and hdm_end accounting intact. Guard
> > > the paths an empty decoder can't serve, e.g. region attach, DPA free, and
> > > poison queries.
> > > 
> > > Suggested-by: Dan Williams <djbw@kernel.org>
> > > Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> > > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > > Reviewed-by: Dan Williams <djbw@kernel.org>
> > 
> > ...
> > 
> > Main comment is of the 'whilst you are here' variety. I'm fine
> > if you want to ignore it.  I just found the existing code a little trickier
> > to read than the ideal and some of it gets shuffled round in here.
> > 
> > Either way
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > > ---
> > >  drivers/cxl/core/hdm.c    | 52 ++++++++++++++++++++++++++-------------
> > >  drivers/cxl/core/mbox.c   |  3 +++
> > >  drivers/cxl/core/region.c | 49 +++++++++++++++++++++++-------------
> > >  drivers/cxl/cxl.h         | 10 ++++++++
> > >  drivers/cxl/port.c        |  3 +++
> > >  5 files changed, 83 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 0c80b76a5f9b..ccbab2e21f06 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > 
> > ...
> > 
> > 
> > >  
> > > +static struct resource *cxl_dpa_request_region(struct resource *parent,
> > > +					       resource_size_t start,
> > > +					       resource_size_t n,
> > > +					       const char *name)
> > > +{
> > > +	if (!n) {
> > > +		struct resource *res = kmalloc_obj(*res);
> > > +
> > > +		if (!res)
> > > +			return NULL;
> > I'd format this a tiny bit differently but not that important.
> > The advantage is to keep the allocation and error check closely coupled.
> > 
> > 		struct resource *res;
> > 
> > 		res = malloc_obj(*res);
> > 		if (!res)
> > 			return NULL;
> > 
> > 		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
> > 
> > 		return res;
> > 
> > > +		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
> > > +		return res;
> > > +	}
> > > +
> > > +	return __request_region(parent, start, n, name, 0);
> > > +}
> > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 1e211542b6b6..6c7d9a52707c 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -2115,7 +2115,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> > >  		return -ENXIO;
> > >  	}
> > >  
> > > -	if (!cxled->dpa_res) {
> > > +	if (cxled_empty(cxled)) {
> > >  		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
> > >  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> > >  		return -ENXIO;
> > > @@ -2959,28 +2959,35 @@ static int poison_by_decoder(struct device *dev, void *arg)
> > >  	if (!cxled->dpa_res)
> > >  		return rc;
> > 
> > Whilst touching code can we just return 0 for this and the one above.
> > 
> > The return values from this function are unusual so nice if we can make
> > them as obvious as possible!
> > 
> 
> No problem.
> 
> > >  
> > > -	cxlmd = cxled_to_memdev(cxled);
> > > -	cxlds = cxlmd->cxlds;
> > > -	mode = cxlds->part[cxled->part].mode;
> > > +	/*
> > > +	 * Handle the degenerate case of a device with only empty decoders. An
> > > +	 * empty decoder can still map a non-zero skip range, so advance the
> > > +	 * walk to commit_end either way.
> > > +	 */
> > > +	if (cxled->part >= 0) {
> > > +		cxlmd = cxled_to_memdev(cxled);
> > > +		cxlds = cxlmd->cxlds;
> > > +		mode = cxlds->part[cxled->part].mode;
> > > +
> > > +		if (cxled->skip) {
> > > +			offset = cxled->dpa_res->start - cxled->skip;
> > > +			length = cxled->skip;
> > > +			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > > +			if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> > 
> > Maybe similar to below. 
> > 
> > > +				rc = 0;
> > > +			if (rc)
> > > +				return rc;
> > > +		}
> > >  
> > > -	if (cxled->skip) {
> > > -		offset = cxled->dpa_res->start - cxled->skip;
> > > -		length = cxled->skip;
> > > -		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > > +		offset = cxled->dpa_res->start;
> > > +		length = cxled->dpa_res->end - offset + 1;
> > > +		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> > >  		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> > >  			rc = 0;
> > >  		if (rc)
> > >  			return rc;
> > 
> > Maybe whilst we are here we can avoid the rc dance?
> > 
> > 		if (rc && !(rc == -EFAULT && mode == CXL_PARTMODE_RAM))
> > 			return rc;
> > 
> > >  	}
> > >  
> > > -	offset = cxled->dpa_res->start;
> > > -	length = cxled->dpa_res->end - offset + 1;
> > > -	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> > > -	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> > > -		rc = 0;
> > > -	if (rc)
> > > -		return rc;
> > > -
> > >  	/* Iterate until commit_end is reached */
> > >  	if (cxled->cxld.id == ctx->port->commit_end) {
> > >  		ctx->offset = cxled->dpa_res->end + 1;
> 
> Thanks for the review, I think these suggestions are all reasonable, I'll make them
> in v8.
> 
> 1. Add missing blank line between paragraphs in commit message
> 2. for cxl_dpa_request_region(), I'll split the declaration from the allocation so
>    the alloc and its error check sit together
> 3. for poison_by_decoder(), both early guards will return 0 explicitly rather than
>    the zero rc, and I'll collapse the -EFAULT/RAM handling into the single condition
>    you suggested, in both teh skip and mapped blocks

I'm wondering about these 'while you're at it' changes.

While (of course ;)) I'm for the greater good of the code, I'm curious
to see how they will be added to this patchset. Perhaps they will appear
as prep patches, refactors, or cleanups?

I did review and test this today, but will hold my tag til next
revision.

-- Alison

> 
> Best regards,
> Richard Cheng.
