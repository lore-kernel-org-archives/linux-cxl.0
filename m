Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF1341678;
	Thu, 22 Jan 2026 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047561; cv=fail; b=tcUSkm2tyLS3FM/e1+uKQeTvGSABGdaCfWgjX++UhByZrGdVbgIIda6TArSxm0e5NV/mX0UYLO1hkCPLaxa6WvvIwKuEdjRNwRzzUCZJl3KVOWtr7Eb/X2MxImxHRE0oeeUt3kEdzcD8A5lO2MRJtShXJHFvdpy76U1GeSZ4m+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047561; c=relaxed/simple;
	bh=MNhJPGA83IR94bsjR5SekqxVv3OrAT+vVTPSRFSsFz8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=YwTcE5s5ItQgTDFtzkh0DI+QHhfrTbYAFlq+0ABlPlo2m3/qoGmZ20MjBZ+qVUTCIZ8gCrFuar6MKBADmdjIhYjjvPqkiN4rPzEFCF5nNwpttZtvXc6JRw2ywcjIuSQ+zimxfYV8L9VeXnqdwbQgXY53O/VfzKKU10j8azqlBaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hndps4gr; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hndps4gr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769047560; x=1800583560;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=MNhJPGA83IR94bsjR5SekqxVv3OrAT+vVTPSRFSsFz8=;
  b=hndps4grotRNY/UKPR/HADtpNdWXjUtHX0SXBqWVEWYA2T/zaHshg5W6
   8hpT+9uDWB81elSyIMK3PDJPelp+r1lAYOkfCGe5juxQ2UhFLXA5ByUnF
   dw8N8N2zXoEfb7ADiicDaGbgMC8xnnlktmPRRVnqlR60WO3hMke79mFs6
   wKtLAK8qpljBA/zShtWsWLShOFhbiOHkXnXAAyc7QqGyQFX6NE9orwo3M
   KNJyK//AXLhvg00kjq2tg6qffI+SviCB3W9y17slWcW4cG6JW/eIL3hwt
   7ZfqcKIi5pkE9JStVnYm2TwOf8kol/MRF8jdSjLn1kpizgGmanIDdD7Oe
   w==;
X-CSE-ConnectionGUID: it74DatYRSG6VQmj3eF5tg==
X-CSE-MsgGUID: n4L5fO2bSJ6sm4fASm357Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70256870"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70256870"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 18:05:58 -0800
X-CSE-ConnectionGUID: K2jMZKnHTZaoACFCkiwMQA==
X-CSE-MsgGUID: VMeCga7OTROERZOOOXkyNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="237870098"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 18:05:57 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 18:05:57 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 18:05:57 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 18:05:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUZz73KrC4beFITto8Bd6YZl2j1m5FsjGd6qx08kHy1ukGGWKayTIS75HGzPWMttwVqs/X9n6qO+125rYIocMBmcGveylbngbU/JfTSjZ339Rdh4EIOpyYvxYwFQfUdxei5E7zybi3mXc85d3c4E9ps1KDjS3JfYmK3BTS56LXmpge90roN19ZJnJ2nsFCmnSJ2M8xGK16xvartDIvU5gvoA17T36jDhca6re8SHOjEncyLp5LIwts31ull2zM6PvmPsuIAPb5KtBSbZQaObxlfwJShIWDbV6IKGvGXpoFURkYKYsWHFGqWmab6JuJULvPYgk6mjofUfnNu6ImJxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoKo/GQ/3+RSRIHsDwu2IXSgP0tCcfGwAsHghVrh1Rg=;
 b=WoB1TMHo+DGBWX5EUlrkAd9o+91mABYjWyi4eDiphHT/TtQMuUJqee1idU2p4YczpbAwCq/DQ8lcMRtuOsSLOKWpGj7CZ+YbhExwubPLqbSeD3Ktd3Qalc8hUKMwVRUwIM0Y2/EFafdN2ZF+VmudmlCoHJMC0vzd1ebA/aC3uiNSOn58BxUKY/QTH4I01C8aP+Lx5gDCJt3zdEPE3ruD5zMs1FD+9/NuRa0rMmyE9MjSW6MJyECrutTjM2vC3KUE4f30ycZz+U5R2PmlF/6gPEvVeYyjSP8l8wC+pXtYgP6gvh6ogal59SE6XWS45mKvvD0ayrQFYylG2IrZgMu30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 02:05:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 02:05:54 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 21 Jan 2026 18:05:52 -0800
To: Gregory Price <gourry@gourry.net>, <dan.j.williams@intel.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Robert Richter <rrichter@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, Dave Jiang <dave.jiang@intel.com>,
	"Ard Biesheuvel" <ardb@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Borislav Petkov <bp@alien8.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, John Allen
	<john.allen@amd.com>
Message-ID: <697186008aa26_1d6f10061@dwillia2-mobl4.notmuch>
In-Reply-To: <aXFdZ_uzXJ8shieZ@gourry-fedora-PF4VCD3F>
References: <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
 <20260119160342.GA659351@yaz-khff2.amd.com>
 <69701f6de978_1d6f1001e@dwillia2-mobl4.notmuch>
 <20260121145817.GB1784626@yaz-khff2.amd.com>
 <69714e9728d2d_1d6f10075@dwillia2-mobl4.notmuch>
 <aXFdZ_uzXJ8shieZ@gourry-fedora-PF4VCD3F>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: c507f7c9-7f14-459f-17f7-08de595ac647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEpwblhvbGhIWjhsWVhxNE4vdFpxNitXelRBbmt5a2lzU2NobCt4Q1R5L1lL?=
 =?utf-8?B?U0J3b0RaSUFiNUN0b1ovQXhCWGhSbnNtZGlWZWdXalNWT0lSb0ZVd0orNHFm?=
 =?utf-8?B?UWV0eHNFa1B3OG5jWXhqWVcrYjRrRG5PRk9OTXN0V3ZHY25NZUpsVUI1UkNE?=
 =?utf-8?B?RHZQTW5lYlhiS2NRTkpaVkQ4c2NNTFlpaVI0dFRqcG8wZGJtbEdZOU1wL3FW?=
 =?utf-8?B?UUVsT21zKzlWRVdVMUE1YlhCKzh3Y2tneUpXYkx2NDdJOVNOZ0NtSTFnWnpo?=
 =?utf-8?B?MmNrajVZQ0YyQVlMcVZyTzJvSEJZQVQ2WE9ROG04K0lnZHdJaTNQR2xPd0xo?=
 =?utf-8?B?QVBEb3B6bHlWL1JCMUcwN2xXNHAvRlcvRW1keEF6VzAxU3dzSExXNEJ4R1pp?=
 =?utf-8?B?MzhnN213WGl4VFdLMjdrOWZIeUlmRU5MWWJCTmVmNkZHa0FBM2J1YURESEZ5?=
 =?utf-8?B?dlYyd1p0V2s4c3pOdHhZUm5XNUI0NEFjb1l5elFVNlQ2cGg0R3c2Z1Qxb2V1?=
 =?utf-8?B?blh4UkZRU1ZXdm55WnYwSXRQSDc4anErbEkwMWNsci93YUt2ZGxMdzR3bTg1?=
 =?utf-8?B?SHYrdnRnZkpmOUUyQ1FmT3RoZGxkUmZTSW1RU1dkZjNwTFFYQ3FLcHIvcEJG?=
 =?utf-8?B?R1JUeDRWN0V0VXhMelVhdzhDaDhicWpYTFJWZG8vM2JkUE9qWjdGOTJJcyt0?=
 =?utf-8?B?TVBnVzkvL1hPV2d4QVNFbHIvM0NVanZwSnhYWm5GSHEwQ05EOTh3eWJxaG5t?=
 =?utf-8?B?VkdVcVl0T20rY0dISGp0QU5RQmJ6MXZyRGZhQWNtOFlNWlpUL041c3YvV0p4?=
 =?utf-8?B?UlBnSndHd2VRY1MweGpEdEhybHdZM3MrNWUrY3MvTFBjQXNwUG9mSGVwb1BO?=
 =?utf-8?B?blY4UHBpc0FSbUhuUzRtSHJwaVRjcC95UkRPNU1mdUdUa0I4RTRDNVlqdkpa?=
 =?utf-8?B?SldrdHRtSEJnTFMwK3ZJckR0REQvWE5UWFhpZGFwVStFTi94dUNoVDFuMlBi?=
 =?utf-8?B?N08vOVBabGdmNEZwVDFkc2ozalJScFc2dFl2TXluR2VWUyttNlBVSEdqTzBz?=
 =?utf-8?B?QWJOMGdkbjFHa1doazI5Qm5QR0R0TnN5ZFFIdHA3RG5HbGxWdUxBYW9xUitI?=
 =?utf-8?B?a0tSMzBITFhlQUtYeHR6U2F6S0JxK0RIQmptdzh2UklzbDBDUVp5ZjcxTU5Z?=
 =?utf-8?B?bVZpN3hUYzlGM2FXSENQUUprK3NxT25iaDUzbDVzTDQwNDlWUWhNbklXTEFz?=
 =?utf-8?B?QXdDODlQTzhnNWZ2UDVPemM3dngrREJESDhvS3p5K1NCdkJ4MmZSamp1VVNx?=
 =?utf-8?B?VWVoMWtnRXoyaGZJYnN1bG9uUWw0enFhZXdLNkNyZjRubVVlWG95akxPRHFm?=
 =?utf-8?B?a1RBQ2RiSUFjZERGRlVSWCtwVjkvNllKU25XRWdwYWJQUHMzR21wb08yanEw?=
 =?utf-8?B?Y0NmRGI5YjgzQnozZWgyaU4wa3F2V3Y5bjViVGJmQTlsV2VJaFc0bFFRMjQx?=
 =?utf-8?B?bE1YblpPaVNsMzVsd3kvMUhRaEtUKzZxR1R2STFDUHRYKzAwNGRIS0xVUmp1?=
 =?utf-8?B?L2xvaUlkOVUrb2ZOTDJETE8vTzBtWitFR3ZibmVPSmZqZWE3R3V2amN6d2NK?=
 =?utf-8?B?TUFkRnpoY1JBZC95QjhkYnNrdjU1a3IwRzlKdkQrcVdTRnFRQUVzaTg3NWcv?=
 =?utf-8?B?aXJObUZuckRsYm92d3kvOEJvYzNzWndDYmVpUFBacFZnOVVNMEdEYzdWcFhj?=
 =?utf-8?B?TEZ1dW9raldUWHcxYnVQazJzQUFuZTUwS3lBWHRoL1dFd1ZRU3hGT3ZnaFRt?=
 =?utf-8?B?ckJ0VFVrcnRNd1A5ZGFXbnVZaU9XMVpYV3RGK3VRaHZYc2RjYkFyMlB1SWU5?=
 =?utf-8?B?UWxzT3NGdUFwWW9mbTk4TlFCTmhnUVo0TFFuQWFrakJNSytNMnUyZFp4UkUw?=
 =?utf-8?B?UW5pVEs2aUtPYWhtODZKRDRJVlZvQTZ1MGRtU3NZR09pVmE0dm10UFhLYmlL?=
 =?utf-8?B?WGNlOS9qaVZXZHdKUGFSV2dydTNicnRNYWw3WTBDSGNGSjJoNUJLU3NGQ0Jw?=
 =?utf-8?B?dUNibHNyOE0xMXVSVDlVT0Erend5OGFIa0FKenRFL05nb212eElQWXdXVWhQ?=
 =?utf-8?Q?f5bE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0d2WkpDRWQyZksvM0FUNSs1Smc0TFJJMW9wNU5vdW00OXphZnQxNTczNFhv?=
 =?utf-8?B?MThoNUJJQW5mekxLem13N1M4cTI4ekdwRWVFZ0tsNERDV1U0eDNPMjVwWFJO?=
 =?utf-8?B?dzFzYzNMSUpMN1RZL2xsT2VSUEltQi93eU9WYTVVK3M4NmU1a3loZHBqalpj?=
 =?utf-8?B?K0VoejhYanYrTG9jRGtHRVZNZGd0czJSMHFjOHNxeGdQdGRCS0FQRWp0V2Fp?=
 =?utf-8?B?dnFSdFV0U3lyS3dDQmZSQU9hRWE1RVFQZ2h1Y3U1dmpWL3RNUzZ6WGRzaGVR?=
 =?utf-8?B?RXJBaVdqTVZKUlk1ZWJBbzJqaDl5WlBEZFlDeE5VVDBKNjY4Wm9kemNWY3N4?=
 =?utf-8?B?UFJuY2xST2RrWlk1dVYzUmVydjNtS1gwcUpISzNhbENVU1JhYmJmNnBvQmtu?=
 =?utf-8?B?YlR1N2lKOUNlTFdoa2ZER2pjZWpiTUh6aVlyYmdKMGZiSUNWTDVndFM2VURD?=
 =?utf-8?B?eTl0dmFyNnZGS3RlbXF2NWRpa25MRjg5aEN4UWV5RHZSYkZuNEprODhOTEt1?=
 =?utf-8?B?VEJCeEZVeURKR0JyOUNoUkg0OTV6WGUwUU9jS3NZSCtHVk1KT0dncGwxY1Fy?=
 =?utf-8?B?NUVucWJBRHd0MmtCeVFoMDdNRkc2eE5HM1p1MUp5MW8xK1RXNEVvVnk0bVZ6?=
 =?utf-8?B?Z1k0WDQrVk13QTl0djNjMFFSRVZtRDN0WjFGajgyNEFnekdhbUtWTVRTUUlG?=
 =?utf-8?B?blRtZ0F3R1RXcTdlRHRNbzNSTkMxUUQwemZRdkZIaFZpcHBGeldWY01jNGZs?=
 =?utf-8?B?WktiK1pNdFFQN1JMQXFRWVVtWUdaRUJvOXNsYTdvM1F0em9JN0lzTWFuUzJj?=
 =?utf-8?B?dndFcXVFQ3NnWnk1RkpqOVA3RGF4bWpROEt6RXZVeFliOUl4VHVjSm4vOGwx?=
 =?utf-8?B?Zm03bHllNTZuY2JJVTFobWF3V3p1T2VXSEJNbkR5NTVKMy9ERjhmQzVIMjJj?=
 =?utf-8?B?N2hWZ3ZoSEowRnVVKy9oZStnbWFlZjRvZDR5eWJFMW5mUmtmODd1MCtNTkxF?=
 =?utf-8?B?Qi8rMjVQeDNiUWR5ZHFOMEpXOUpGYWdkVi95am1zZERFblFWSENnMS9IdFQ2?=
 =?utf-8?B?UGU0WjI3b1QvanpueWpWSDN3SFI5SjkyYjdjR1RaSEFybWZ5VGgwaEVVK2xo?=
 =?utf-8?B?Tzh0d3MyZFRIdUJEL2RtL3RjRlE0L1dsblZkUUxmdEVubHZ6bE04QVdWRlQy?=
 =?utf-8?B?SElKOXc4b2RjZkh1SHpwQ1QvQ3UyT3lXT3hIVVAzRVUzaTg1UlMzNjk4d0t5?=
 =?utf-8?B?U2Q2Znp2Wmd6VkdQN0hxaGp2enpCQVo0Q1R0V2d4K0JWQkt0OVVWeXlUaWE3?=
 =?utf-8?B?QUFiOTlTVHJiS3BubkpjSWY0c3N5dHJoZnRkNmFlSGwrU1dCazFiQlpsOTJH?=
 =?utf-8?B?RDlHa21DUFgrbnlZT2dhRFZJY0pheVJqSURTLzBtZDFWTzRXUlJPVE5tSWhO?=
 =?utf-8?B?TTZhVkdjTWQ5K0lVbHBhd3FUTTZ2aFZtNlB1RVJqQmJKMktwVnhWeTBSZHlx?=
 =?utf-8?B?d2M5dVVSWVcxSFhiVXRxbWM5cy9JaXRCN2xCM1Z0MmNudkdsVGQrcm9CU0p2?=
 =?utf-8?B?R295Q3MwYVMyYVN6UWdKKzJabnU0b1RFalFkWkFtczRaczBsSHQvb2VMa0dQ?=
 =?utf-8?B?MUNUU016L2I5NWtSelZiYTMvb1l2YmROWERoSnZ3ZzdPcnVyUXAvZnByaU81?=
 =?utf-8?B?K2w5YXc1aFIvU0RHallyYnQ1ZVFEUXcvTVRUMXdIeUVoWVJWNWpWUUdoOFV3?=
 =?utf-8?B?TUY4MWVyUnZFbnJGcExjYUs2V2VKYzFvYTl5a0tLSlBSV3ZRVG5DVHZYcGtk?=
 =?utf-8?B?Ty9lMTdGYXFUenRJdFNkSXRTcnM1TktRakVGTkJjZ1VDWlZtS2hBWWQrQzdV?=
 =?utf-8?B?YTRYN2ZUTGhFUnIweWllT3IrU29HQ2tvZ3dPYkxrMkZiSHhSUDVWVm9ZeVov?=
 =?utf-8?B?bUJBazBVeEhYbFZxWlRDTjBYUVlpNmMvWHpTbXA0bkRYK0taNXBPOUI0MlUx?=
 =?utf-8?B?aU9UMHFaejk5ZEJyWjQ5ZDJLTnBqbC93TGcwQWFuRTBKTUtpZU5hbUlhTnNG?=
 =?utf-8?B?blVZRVp6TlhLbXYvWnB2SDF1QkhGV1lHdFJqcUtUZVBwR2kzUkZPVkUwU0Z6?=
 =?utf-8?B?MktKTHoyOXdiRklzWHR0SkMrUjlDWE5WTEh1S2ZmSVZYRHVTMWdRU2xYeU91?=
 =?utf-8?B?Q3VoVGV5N1QwNFk1VHI3RENUbHBkemRUVHlGenVMOVlmOU5yeDIyY21pS0Vk?=
 =?utf-8?B?OFhBbHhMV0kzM0dxaEp5Vkl3bk5jcHh4R2pZbk5GdTBnaXV4bkVITllhNmdH?=
 =?utf-8?B?bFUwWWJJSWR3MG5PSFdoRTd0NUUwZVVTbHBocDBJUUNJSVBZUk94dW5DSHlw?=
 =?utf-8?Q?WbR29gGYD3OchJlk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c507f7c9-7f14-459f-17f7-08de595ac647
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 02:05:54.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1XWepZ+eS5kU8wHbWCPVeXuQj+0e32KnzFBuuqWNxOlwTO3yZ+2ZVVQjeA8iFi/UUfrhl74bn4b24PgJS59qlLsR+TkP5L9UAlfOAfx1ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Wed, Jan 21, 2026 at 02:09:27PM -0800, dan.j.williams@intel.com wrote:
> > > 
> > > I see. So the concern is including model-specific methods that would
> > > modify the CXL standard flow, correct?
> > 
> ...
> > 
> > As I told Robert, I want a generic "Normalized Address" facility of
> > which Zen5 is the first user.
> > 
> 
> Isn't that what this patch functionally is w/ a specific PRM function?
> 
>    rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> 
> Or is the request now: replace this with static table data?

As I mentioned at the bottom of this message to Yazen [1], the request
is to prove or disprove the hypothesis that a table would have sufficed,
but otherwise go ahead with merging this handler. Set a precedent that
the next attempt to solve a problem like this with PRM will face a
higher bar.

[1]: http://lore.kernel.org/69701f6de978_1d6f1001e@dwillia2-mobl4.notmuch

> point of ignorance: what facility would you use to expose such tables?

New sub-structure of the CEDT similar to the CXIMS.

> -----
> 
> When i initialially hacked up driver support for this mode before
> getting PRM support, the "hacked up translation code" I was this:
> 
>   /* Find 0-based offset into whole interleave region */
>   dev = (pdev->bus->number == 0xe1) ? 0 : 1;
>   offset = (0x100 * (((norm_addr >> 8) * 2) + dev)) + (norm_addr & 0xff);
> 
>   /* Find the SPA base for the address */
>   for (idx = 0; idx < cfmws_nr; idx++) {
>       size = cxl_get_cfmws_size(idx);
>       /* We may have a gap in the CFMWS */
>       if (offset < size) {
>           *sys_addr = cxl_get_cfmws_base(idx) + offset;
>           return 0;
>       }
>       offset -= size;
>    }
> 
> ------
> 
> This makes hard-assumptions about two things:
> 
>   device interleave index  - pcidev(0xe1) => 0
>   cfmws base               - all CFMWS are used for this one region
> 
> cxl_get_cfmws_base() was a call into ACPI code, and the acpi code just
> kept a global cache of the raw CEDT CFMWS structures (base + size);
> 
> So, assuming you had such tables, it would need to be like:
> 
>                   Normalized Decoders Table
>     --------------------------------------------------------
>     | CXL PCIDev | Decoder  | CFMW SPAN  |  Interleave IDX |
>     --------------------------------------------------------
>     |     d1     |    0     |    1,2     |        0        |
>     |     e1     |    0     |    1,2     |        1        |
>     --------------------------------------------------------
>   --------------------------------^
>   |            CFMW Index Table
>   |  -----------------------------------------
>   |  | CFMW ID |     BASE       |    SIZE    |
>   |  -----------------------------------------
>   |  |    0    | 0xb00000....   |     ...    |
>   |->|    1    | 0xc05000....   |            |
>   |->|    2    | 0x100500....   |            |
>      |    3    | 0x200000....   |     ...    |
>      -----------------------------------------
> 
> -------
> 
> The code above turns into
> 
> int cxl_normal_translate(pdev, norm_addr, u64* sys_addr)
> {
>     int i_idx = cxl_nrm_decoder_interleave_index(pdev);
>     int span, i;
>     u64 offset;
> 
>     if (i_idx < 0)
>     	return -EINVAL;
> 
>     span = cxl_nrm_decoder_window_span(pdev);
> 
>     /* Normalized offset into whole region */
>     offset = (0x100 * (((norm_addr >> 8) * 2) + i_idx)) + (norm_addr & 0xff);
> 
>     /* Find actual CFMW Base (might cross multiple w/ gaps) */
>     for (i = 0; i < span; i++) {
>         u64 base, size;
> 	int id;
> 
>         id = cxl_nrm_decoder_cfmws_id(i);
> 	if (id < 0)
> 	   return -EINVAL;
> 
>         if (!cxl_nrm_decoder_cfmws_data(id, &base, &size))
> 	   return -EINVAL;
> 
> 	if (offset < size) {
> 	    *sys_addr = cxl_get_cfmws_base(id) + offset;
> 	    return 0;
> 	}
>         offset -= size;
>     }
>     return -EINVAL;
> }
> 
> Where the cxl_nrm_*() functions just query the exposed tables - however
> that actually happens.
> 
> --------
> 
> I don't know whether the above math is actually true, it's basically
> just the simply interleave maths. If something else is going on, then
> this whole table thing might not actually work.
> 
> The rest of the patch set would more or less stay the same.

If the above is even close to being correct, I would merge that in a
heartbeat over this PRM proposal.

Robert, do you really want to be spending time on trying moving PRM to
userspace vs just doing the above?
