Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11E217736;
	Mon, 21 Jul 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129402; cv=fail; b=QeiTSjjSwogNoLoZl9+B75EtInHAJJ32GMkaxXpeyHcArJdCPxTpQORfDGhzVCH1uQGKW6DbKeexWD08sJGWdpGrUXfwTYY4FNUCzifvQzkDJ2iQ+Afeb7m2t4HVVBmXscLtPJX8UZU1iSZszoEApA9r7T9g5Bq95wpFX8+SjoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129402; c=relaxed/simple;
	bh=Xtyopffcgz4lIhrPUnHp9CyjByuLk024fVahx1sw+Bk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kCD2xSiuftrROEYNV/3QYjFErtLg/mVeHQa2rJBrwp+mPtYG96hfoXepWBaHlhpUHaeQU/uMTDpHAWYqBrmoYqeNU9iFK3mQvSrILbyqP5zjnjoVW3nQkbV8SpqjmMu73M6k3+0aWQ8XnxxD0ev4uI5EcN5LEzO5khgbtZcyXWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meNJ7p3/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meNJ7p3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753129401; x=1784665401;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xtyopffcgz4lIhrPUnHp9CyjByuLk024fVahx1sw+Bk=;
  b=meNJ7p3/D5fyIup3TJJBoZVwHRA16v3XE9sE1oV3bPprnnXWQTUCTcqc
   jxyfLqFJ3/INOZLcbaP4PttltZ84HOh581Of2GgPBUkq3WQQUtbXPw3vF
   VOJ6W2nRXSSYZmCwtKw33ye7r4iYU26j1B9mgXNbA6LC5U1HxyTm3kyaN
   3XtCSZXH9gC6Vhge3Vil90QynTkyZnFXBhMdOIySEA6T67rv/C2HgW47i
   fdI+nO8auK1ikdyqPpXbrxUIQQnvjbN+Esvh78Oav91rei4EP2k1wQFK3
   obiOTh1wzzT2xxa0o8nYAQnHyw4zCmuskkDdH7Fvqfj+Fj6l8W3+sG/Li
   w==;
X-CSE-ConnectionGUID: XX8ZaCWqQ1+FPByOpDXZCw==
X-CSE-MsgGUID: UyEd6zAWQZS1kOchlNaYFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="77899680"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="77899680"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:23:20 -0700
X-CSE-ConnectionGUID: ZUcmDyzbR7WFNas2VFpqAw==
X-CSE-MsgGUID: OUBFk1uoSRmqT3p+yKgBgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="182651472"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:23:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:23:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 13:23:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:23:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUAB7wl5HM3m1XRxwj3qxYMeh+/DhMNiAI0WGuEUTxra1aS2paBPWvYTEbT2WNkv0eYoN/huaLJ/RqzdmSC3Nj3ux9MYq6KiQ8jAmmTPXJahi1yOSOeAmS6akMA70UksxeKeqPk15ZPndczFFiEmxgzG9klXWWyNi3ss9UTMUF/xFumaEq16Z6KMTPHO05E1g0Ecnzu/9+loAxXoMCp+3MUsbZd9qraS6GfWOeN1S9rXqFUupJHsKKHfEUJB8cgNmIZUTfFvKyFnu5eoPmRK/KnVkI8dcJG0Z7vJ/lTD6w3B8YDISV5svE9v5ilG1mViKq2mJXuRMa8rnFoUEME3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqsnbUfh4nce6z/hI8JZCrlviPQcXqGxPN95qH+uvOs=;
 b=VBynJyQG4ugnomTUdfJipPjT/D0w/VZRq3mR9xKQZkAUOSLFJAoq/VzKkacpogGfkIti+FJGNKWRTT57uUZiNpNErZ16Q0wp5tFuqPKKIWTNSvgNCBwdoCihtdMhsbvAsmI9WY4E+pf42pI6c3t5lUDVuhXgMJlkuxZ6Bmwa0feA1h3ah/P406LlcX0LF/WPSImOBt3CrO3Jr8TbFx8SMrOFJaC6gvnwGndaW3mp/aPaPud5wYKxqDqTYqk+RIR34Y1InaS7VfiHTxws0X5Px0M7XCUzVkDMSeAdEHaZtcdNxLK70RcWyapOFhl8Jl+E9hHB5QCzSoquYiYYNh/bGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CH3PR11MB7348.namprd11.prod.outlook.com
 (2603:10b6:610:14d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:23:06 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 20:23:06 +0000
Date: Mon, 21 Jul 2025 15:24:45 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts
 btw CFMWS, LMH, ED
Message-ID: <687ea20d2e508_34e0f2941@iweiny-mobl.notmuch>
References: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <1985851.b9uPGUboIS@fdefranc-mobl3>
 <aGwmFwGNmw8n9zGR@gourry-fedora-PF4VCD3F>
 <17128669.tgchFWduMW@fdefranc-mobl3>
 <aH2PAju1rLxIbXXk@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aH2PAju1rLxIbXXk@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CH3PR11MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: dc965039-7529-4c08-6822-08ddc89466d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9uSZr73bFPWNTFUDGNuE0iKJ5J3o5GWt4Gv6B8xFZkt36NFcxbKYlR/EqyKc?=
 =?us-ascii?Q?rA9mLQ5dxZSkc6E3R/IlZBMowAWuqU4tVOU7TrZUQfUvbVMcKl3oEUD8y5nd?=
 =?us-ascii?Q?cUfpIKii4WXUbYCDIGQtbx51KQ8oRc1XGcjGHzWLKk8XeozCztj7U9UZqiUy?=
 =?us-ascii?Q?SbVkRrColkLMmE8Y2X2+J1l8vuD+4s7GXaECN3sQRBvueEyAVFfVJ9zE5JeL?=
 =?us-ascii?Q?w1Ac4HnM7+l+Qe49L9odF2CCcHWYRKx+NVLpXUSF/jSjYeVhr+a3XUniXURq?=
 =?us-ascii?Q?U8DkOShmCEXQ1Tg95Qnx6Ex+q4/6G+AQ0LzjGT24zm2jiZOfNMRis4jiaO5n?=
 =?us-ascii?Q?UqYY6ihnrP1/st0kgvT1MGdpsBnzz3XxfF57Fef5RYtRJZSO8LOqGwvhNvRt?=
 =?us-ascii?Q?8BoEAJsjl8vTbnTtrfQFQXJsxcssW0ES1FYcghl4JlYZCr0spvIwN2J/JM3n?=
 =?us-ascii?Q?GipCSpMemQr9qWQ/BNhq8SzQirXf3pwOCgilDu09W/BEUO9GnNLrXG7NMWxI?=
 =?us-ascii?Q?H3vA8ocMhgqzbZUzAiaCc2STebmDsRtVpu/XBozqxrnseFvv7e0uYnutmc7u?=
 =?us-ascii?Q?rO+JXMTc4YV6dmy6ByGQzHR0fXzfsXGKJBfy/1Ep/NMplOe7hXJoSWnmgr0O?=
 =?us-ascii?Q?vBFg4EW9/uYh1eA54yva9CfSUDWbxNQRp/jHoeVANGL7T44ExeKjv3jsRjpx?=
 =?us-ascii?Q?amOPL8YPC6lcwqN/c/ydb33GfpOcYLCm+uKlajsXNZBi1EpujQJYMcDUGMyy?=
 =?us-ascii?Q?XlqhoxwSVrfogPCezbhLOyqhAVtSpA3CkxpDUU0Dp9ipbn49GgbG4Otb7vCY?=
 =?us-ascii?Q?IJe6K3gOAnB1wJ4qhGQ155ziHRX8pXQxhHE8M09xZceXYLzXzAzKkP7sqnlw?=
 =?us-ascii?Q?uVoATdZEQcx+G01JPKPsaD/mdS0lvpILhqAni2TUxbo4m3+B9hptlwG3A5oT?=
 =?us-ascii?Q?PIkCFqyh6nycdFe7Qw/FPuomR2Kb3KRkyHELjMplmXlDPYRJbtFMI03wPJiB?=
 =?us-ascii?Q?aL9Tu4ryZ905/Yj1ue5M44jwvEVtUGqw8CiiMgeNNGvUpiY39VYcH9AfHNL0?=
 =?us-ascii?Q?qD+CPP/k1QOEWpynt4bdrHZ01tYs6lHv6odqQ+kl04xPLYwc+7gVToewqWCf?=
 =?us-ascii?Q?OcUC8X4Dud33+uxHJmsxya4pLf16REkG7jpMEmK0a/wJrNZh2tfa6zwRq408?=
 =?us-ascii?Q?qVunN0hzRaLC8v5Ev0awRexYS16DgYdGRwu+8okvcmtbxfsSj/I+Zh4LyO1q?=
 =?us-ascii?Q?DSkslhF/CJ912HmzHrE1STE+HlclmAl6ML9WJiJ7uPdOFbOqCCF9toaEh7bm?=
 =?us-ascii?Q?93aTKtgqe8ik+x8A4i+Q18ZykZXbQPYciDln0nndhykVeFrbcfXJQWAMlQg7?=
 =?us-ascii?Q?+3aBINCoq4nPrHk59xTC5ZH25hq9qCos8FMwJ1KI4Y8vCDVWaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JC+ZepFVyVyPN109uz2MAUVfKqI+2vO4IW2Nyjbi0QNdo3NU8D/kBfPrYkEG?=
 =?us-ascii?Q?V9G0Sw9qAgJLjCl+uIccIG3vz2TQ7GCnsC8pELgKna6YuBPljZbA9iQZ0psW?=
 =?us-ascii?Q?vdgmUOJL2colXKTQpCAYnWc3+cv52bjVZ3nsi6AqvA72brnmLqL1T3wmMhM5?=
 =?us-ascii?Q?d4NayRIml9g4HLJLI9oZ0/4fzMjXRpCLCksCzpjKgXFbKWc46rmZtbTUZT5H?=
 =?us-ascii?Q?UXBfPZYDCUq/sX2u1oV14FJ/47lpmRBJlDangrqnbYOPjxHHO9uh8wyz5kA/?=
 =?us-ascii?Q?YqvWS4p8qyQ8mSWd9k00if7JFpj1m2WLJ8UIrcfbCS2H5Il1ZBVYCDcobtza?=
 =?us-ascii?Q?qT/YAAK/f95h4laY+y39b9qm28KINcD6pCuPl+3K40E6Xj624dOcuSxF4wkH?=
 =?us-ascii?Q?x5vg3ogzAHo4IuW5BZJJX13r2GOGa8IsYhuK14KVIAEhhYzfXhFgVQjUZlRD?=
 =?us-ascii?Q?VbRiSktEwD1AZ0ORYFfzumrDwxIAb/eUxkzWd2Yy5Er3vDNxM/CVOW4tOzXo?=
 =?us-ascii?Q?EnBIegMObo8rshuIuX5sMPaLf5LSy7NT1hButEnI4VYdJXGzwGU4/JAjmdIl?=
 =?us-ascii?Q?3bMOQDuf1G2GOVJvXcw8AodAGVqD1ZGVl+CVkfxfoWuBO15i7Go3lYN8ksly?=
 =?us-ascii?Q?t4IO4tt7gsjuLvMb03crX3IrnCsPFg4lfozYMeuzJ1R1c3X62FGPZ4dA8LSD?=
 =?us-ascii?Q?gB55V64keLzaERbIZLcuF14RI0DcaFx6xUBMaEdI9dAv1hwlG5y3p5BfYGHC?=
 =?us-ascii?Q?JaJ2Qjh8IrPk3awekc0ZVQEGqOxqVqdJD8Z9hTca4jZJMsZxRF0o5OerKHHB?=
 =?us-ascii?Q?9Scrzp8UWpzSE1nlDUxeveHegn9dNcNarlxCC+5ejf6YhhuKRErVjb3FjQwW?=
 =?us-ascii?Q?Gc4fOhpPWcKsp8k5N+p4/bpyn9/Amy0YEtFh/rCqufuZY0QUxSLXRnnTew3G?=
 =?us-ascii?Q?Ap2mbfX7hm9S47ymJzMSIkqAIrRGtGO3F8Q/0MMZJs3pO/BXGmakShGXnUaQ?=
 =?us-ascii?Q?wsS46IRDYR6S/gJQiI5SLvDVoTyctxGMH76/GZ8CCqySzMAfcuWx/W7h7XTG?=
 =?us-ascii?Q?GhVQ5sp9YDLnzolxnsmijBc1lIQHC3AMJkUsdIlrOuF95PP1xvrlP0Foeift?=
 =?us-ascii?Q?CpuOWvK9N/KNPIBe5m/l57qAf22LatZEkBF08rxN2SsX/cHqMzs70wxZp9Ra?=
 =?us-ascii?Q?O7ATVth+yqZ+VaEuQS8faQiLdAKTplJ1u/Mx0D4J1I9cwk+KMkLuRLxjbQqh?=
 =?us-ascii?Q?ERt+MU14NKub0xlxSpr9wgzM+PkMj8bS9YpC/76TCACFDe1AYHag/EOWSSAE?=
 =?us-ascii?Q?yLXK41puUsVxSuGVUPGmOg2lfqR5D9HVU20Pd3img3ke7ZzEo+JmX9CCn71Q?=
 =?us-ascii?Q?eQ4S+gWJaGo8ckrvalCmExZaiZhuegX5mgRGN2XRJgCT7A55xYKyARs1lar6?=
 =?us-ascii?Q?bDj9ntuji+kAOPXSKW7XRfc7/MzmS9dwfI3kGM0ilF/B/P9X77rWx8QKg8mC?=
 =?us-ascii?Q?y1SKub3zxDtLID/IcseYCO8fctUg72wYq8X/4ACjtLddWvLSFUumnfgWI+B3?=
 =?us-ascii?Q?26aVOKaB5Gd7y0aK7PG4aW4WN2iOGJSnemSih81b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc965039-7529-4c08-6822-08ddc89466d1
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:23:06.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgwynTYbHOzv1f9/kj7A3VPrG+p0QfeMWUX6Yz55SJyQKWopZyNQN92np5eyW8yuLhL9s7PSLEaBI5vhKsr/+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7348
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Thu, Jul 17, 2025 at 04:14:13PM +0200, Fabio M. De Francesco wrote:
> > The table above shows a real configuration copied from an x86 platform 
> > where the Low Memory Hole (LMH) starts at 2GB. 
> > 
> > The"HDM Decoder Base/Size" refers specifically to the CXL Endpoint 
> > Decoders HPA range Base/Size. The first row of the table describes the 
> > first window (CFMWS[0]), whose HPA rage base/size is 0/2GB, and the 
> > Endpoint Decoder that the CXL driver should match with that CFMWS, 
> > whose HPA range base/size is 0/3GB.
> 
> The only thing i ask is being more precise with decoder references.
> 
> HDM Decoder can refer to any of: root, switch, hb, or endpoint decoders.
> 
> Below you make this distinct in the explanation, but in the table it's
> simply general "HDM Decoder".  All I ask is for a bit more clarity on
> what decoder will contain what values to avoid further ambiguity.
> 
> > The driver expects that the Endpoint Decoders HPA ranges to be contained 
> > into their corresponding Root Decoders. Furthermore, Linux fails to 
> > attach Endpoint decoders to already constructed CXL Regions because of 
> > the same size discrepancy issue. 
> > > 
> > > I think you need to describe what the expected behavior is for what linux
> > > will produce in terms of the decoder objects given the above.
> > >
> > The expected behavior is that Linux should be able to match the Endpoint 
> > Decoder with the Root Decoder range even if the CFMWS size is smaller 
> > than the Decoder's, as long as the latter adheres to the 256MB * interleave 
> > ways rule. Furthermore, Linux should be able to match the Endpoint decoders 
> > with already constructed CXL Regions and allow the attachment process to 
> > succeed. 
> > 
> 
> You may also need to describe more than just the contents of the
> endpoint decoder.  What would the content of any intermediate decoders
> be (matching the root or matching the endpoint?).

I wonder if the explanation is lacking intermediate decoders because the
test system does not have them?

Is this true Fabio?

Regardless I think Gregory is correct here.  We should try and document
the general case.

Ira

> 
> > If this explanation suffices, I will incorporate it into the next version
> > of this patch and also explain that "HDM Decoder" stands for Endpoint Decoder 
> > and that the CFMWS HPA base/size describes the System Physical Address (SPA) 
> > which the CXL driver uses to make Root Decoders HPA range base/size. 
> > 
> 
> This explanation is better, just need a few more bits of data and I
> think you're good to go.
> 
> ~Gregory


