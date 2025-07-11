Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928DA933;
	Fri, 11 Jul 2025 04:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208155; cv=fail; b=Y1G2bkg6wznVGIfu70JQBc9S4tCZET2L5AAX8fJyrWYmFWbe8H8ovbRZm/tZJYx4a3Qz34IRdbliioA/BJNmak07ZLF7wv1r2slZAeOOL1yV7zTwr0yZs6R1eYOgKnc/sOgRZIY5EdRkTbXy/UK181IudjaEDGGSCL8jLAASE4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208155; c=relaxed/simple;
	bh=nSADlsiTAQGuerQnCnUqAoZ1pWddZkpYN69Km3+Spg4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=YEwhEmBij/GOYZYtQq9Fg9CPgWZllaeefcLUeAfTVPUhxBLl9GLWQShx5iWBPkoafe3jCBfQ3TVaBWEcZJvAybvkmqE+ab82Q2FUaE1OC+MPGAIZpA9StGGsK4SKzwLnImve/gQJ9TzA8lMN/PKtK6iNQS+52/u6tQdK44F3pr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwlIj+Rp; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwlIj+Rp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752208154; x=1783744154;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=nSADlsiTAQGuerQnCnUqAoZ1pWddZkpYN69Km3+Spg4=;
  b=kwlIj+RptaYmzIuWyvsQLKPU8N4xJFCxlId5APXIJRjFfvrodUKmNZqk
   MDC661nGjoEKYxgyTzRRM8PX9oHr+0Fu67Szg8H2fzqA8l7rCKd0DrbZg
   rUQMjvsU2CY66/VXiTwEdzWacBagQzTfS2CEPqFWOdZDJqPv9yxii3bkc
   5gNhJ/N7iL0rGmwNFyxFxhTElnZ7wYs9ebOfxeh9Me6T3MFd5+mhK5ZHa
   3P9X2eQn6Q4cbQ6FQtCkGE6X0XdHHq71lCYlrG6wAQfiHhqyNUkO9cVYJ
   WMZGiqQDPEvVjzWSfK6HDHemfdy0BKy2Rq25wEPqHoGbDqcoB40nvBhpX
   w==;
X-CSE-ConnectionGUID: MaB/tLf2Q9q88/87boWrfg==
X-CSE-MsgGUID: AhwxvbfKT0ykkxJ6AV/jww==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65851434"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65851434"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 21:29:13 -0700
X-CSE-ConnectionGUID: z6Qrq5fzQlmo36SVu9B4YQ==
X-CSE-MsgGUID: ca+1OTgxTHa7Y96u3swaJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="179970902"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 21:29:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 21:29:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 21:29:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 21:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvytXk26w6Tr21KslkkSP9OALR/S3dazQ074r6JmtW+SqwsNkLGvLq0nAf1w1tYb0Krhl//3Q3MOjtdQ8TxXWaNlQkh8++k0rqU8xPWaY5d+j0pLE0uLMgNU9J8QnQF2B437GB3VRD/7tFL/jfko4YuSDEggJM8lE7kUrA8Qt9LXfY/cuv7Be7rj0X9i23rr0VOpEFAP6ufPdzCOPB5/kWpEdAd0lw1GKnIzuOpzYL7U451GebyWBhPT7cLwNOo5+KBkpfAz9+6jOVnNlAL1ZnBYUAS4l+4AQnWeiA7VNEq9e/WBV8AQrIEeaYiU/gNAZRXMEI3iaTo8EAJFpK8OjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROXdMctZHr89oOGCDADMUgJGuvFf3NggOjbgnnXicGU=;
 b=GdgZFr2hULNkLcPg9tytu8tVtdljmMxXxZ/TJOXjG5miY+eQlUPyxtK5ET7XVP4XF1hT+yXMzwa3NwADndSvsO+A+wj6CgsBJhR8eQAHQWkt+dk21CD7Wos6U5ZTIyesBcOntA5uh0B/a55NOuWMw9Y4sAsngSerj1DV9pKH4hPwqLJ/f5YFALxfcKNsYtuhTfwtED6dJWu70+wrUymxC0Y2SQO+DoRoBjpeOjk4uFluxYCt4sa/65x4Z3PJq5ym7d2mwDPQ5mkW89MYA7BrfvQtsUpGic9V/qEXU+zzH0fdFEUwHRwufj7am/7WW80p8bZvqtYDRWT0OWf+8BaGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 11 Jul
 2025 04:28:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 04:28:33 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 10 Jul 2025 21:28:31 -0700
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, David Lechner <dlechner@baylibre.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, "Fabio M . De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, "Ira
 Weiny" <ira.weiny@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Shiju Jose <shiju.jose@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>
Message-ID: <687092efb005d_1d3d10029@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <aGXDMZB6omShJpoj@aschofie-mobl2.lan>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <aGXDMZB6omShJpoj@aschofie-mobl2.lan>
Subject: Re: [PATCH v2 0/8] cleanup: Introduce ACQUIRE(), a guard() for
 conditional locks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: edd2889b-043e-4f88-84c2-08ddc033657d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFF2UWh0TlRCWlhUaVFLeHM5Q0YrZUUrSXl0d050TVpxOUZRQlAyNmFEakhs?=
 =?utf-8?B?dUNaUTFUM21KNXJXaEFEeUE5YTNHK3Z1RjNFQmllVThRekJsUUN6Zy9TVzhL?=
 =?utf-8?B?eWdMdWk5clRGSXJHY0g5NTJuMDR3Ukw0V0hVaGZPYjAweFNKZzhQZCtoTERC?=
 =?utf-8?B?Y1AyWm03ZkVpMTBNL0t0dEJsVWg0T0haNER6dGFwV05tcE1RR1czVG5IYlNO?=
 =?utf-8?B?YTRqQTBoMUFISzhtTUdjTnBXUSs1SGR2VFVCRFFwSVJVT3oybE1QTEhNNHY5?=
 =?utf-8?B?N2ZEVm5WZjRjUmFPTEt1a3BRK2w5cHEzQ0VVY3o1U1NJV1FXdlE3SzNXaUtB?=
 =?utf-8?B?SWNSUkxFVUtLSVRrd0hrQ1B2NU1HbHk1N0FsT2lGandObWx6Tm5ycUZrOHEw?=
 =?utf-8?B?R3YvRENjVnlkZG1oNTZRTkcybjlNaytNclh6WGxqNXZnWU4zcE1OdHpvcU1T?=
 =?utf-8?B?V0hOa1hWdjc5RGdxS2lUUUVYOWYxUlJORTNTRkZuQ3FERUFWR1kzS3RtUk5s?=
 =?utf-8?B?aW9wbXhJd1hTOForb1FYTjVVNVdUNy9CdTdEMys0S0NOclZxb0doVElKSi9k?=
 =?utf-8?B?S3M0aktIU1lrSEFNQjF1UlZRMlZCUndSazhiNWhxVGgxSDFZeEhLbjBobVk2?=
 =?utf-8?B?UU5GWWhmRnBQdmhWQkFrSVBEN2FxZEFZQnhabGFCbThkeXhITXBJMGgvL1dX?=
 =?utf-8?B?S0xQSTRreThyTjYya0p2dktUUTVhRzMrbi9oNUl4UEdONlA5UzhOdjRzMjVX?=
 =?utf-8?B?aytBY2t6NWlCL1ZLc01xZDc4OFFWWnVlRWVkY3FZZFc3MXIzVTd2eGhua2cy?=
 =?utf-8?B?MThPMjZWNWhVcHptajZhblU5MS9QQkwveDRrUDR3RnBBUjdPNEhFWUQ4Q2Ft?=
 =?utf-8?B?RTc1L1BHTVV1QmNjTGNZTk9XTnBQYTJXSVdmeDI5bzJ2V2dhaVZPdXNUREt4?=
 =?utf-8?B?alI1TVNKNlFtRVFXYXhuRWkrK056aC9pU2pVTlMwU0lwM01tVU9BbCt5cm41?=
 =?utf-8?B?ZTF1SWdlVVMzMXl4eisrN3V2TWVxUW9DYUYzQXZPelN1N3QxNG5FTW9tM1JG?=
 =?utf-8?B?REFqbStSMXZiUWkrTmpvcXZIY0EzSTlreUtQYUgyMUNVaExkZkRGVVVSRWRk?=
 =?utf-8?B?NmZHa2NOcmE1T0o4cFNYRW5IbzEwNmpMcVFiM2tCQWhkL0ZkUEEzcmIxRk9L?=
 =?utf-8?B?Snp3WlpmeTlVb1lzd0NubkNYc0lNVWVCTFpnYTFEYlh2dUlQbm0yank1SHll?=
 =?utf-8?B?VEZUQ0JRbXdqUEpxNnFOR013MWxvajMwdWRwdTJ5VTdXSCtGV2ZmMXN4d1Ax?=
 =?utf-8?B?M0c1RVhEZUQxNGlzc0ZlSVNnY3RaLzV3K0dNU3FSMkVDR202ZSt6TVVvZlQz?=
 =?utf-8?B?RGdmZTV4aVYrRzlvRklHVkZXRTQ5ZHViWnNaaXFsWXhHbnBNczlpeFdZUFhr?=
 =?utf-8?B?SlRQZ1haR29ybkZHNzM3Y0E3WitDQzJPYTl3N3M3WTROS0JZUlhQNFkxN0x1?=
 =?utf-8?B?VkJhQUZhcUtFblNMeWFuMTRzUmtaYzhDbHRMN0lkV2xJMnVyMzVKeGl1MGZy?=
 =?utf-8?B?T1R1akl0ck9VVUxEVGlGUXdpd0dhVWFPTER3MnNiYXE2YUs1OWJwU21SS1ZK?=
 =?utf-8?B?NUlCd2s2dTlYUGJ6QTdpMEFCdUoveVY4VlRtYldhajB1RTJMdEZDUWE1blFq?=
 =?utf-8?B?NWNieHIrZ1FVZjNDOVVzSGgvT0lER0xqU2hkK1pHZDNxa3R3ZXJHRjNEeFJu?=
 =?utf-8?B?RUlhcCtXbnlnRFdGTDlDNlkwSG1lWWc3SVY0OFNXL0RCU3ZmNXpHSGhPb3Nh?=
 =?utf-8?B?bjAxUDMyODZOd0E2S3hybjhYc0FncUxQYmVBNnozSTN1ZS9ZVTdFV3lpQ01I?=
 =?utf-8?B?L0R3VzdwVXdnekxmOXNZd21aNi9zMkZEREVEeHBibFdhRTlya0wweDhPT1I2?=
 =?utf-8?Q?dqoP7rOH6ns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpxMFhlOTA2cFV4a0NjR2hsYlNRdHJBRmhKYUQyNkRuZ1Bid2d6cGJDUFc3?=
 =?utf-8?B?ekI4WXVjdVVXSHNhYUlrMzVoenZmQmZGNWVMeHJBalpGMDBEWHlEVklvdWhk?=
 =?utf-8?B?UHo4RklaYUJlNHk1WFBOOWtYVElaZTdBSFlrOWJ5TTY1VVBiZ2tWc1diMmoy?=
 =?utf-8?B?MklUYWQrb01NMjF6NTE4N3E2L3g0Y1pBRTZ3NTNETlBOZWtTazNPREw4dUtq?=
 =?utf-8?B?Y1hnbjNnMlVZL0dEbXpOdHNxR1hBWGZIUFZCV3R4Vks2TzA5OWJYVGtUOXVM?=
 =?utf-8?B?YjNRU1IyeTFvZUtmbmN4YVRBMzNLMVJ2b295NzRLb0VPL2ovVnZOalBQczZz?=
 =?utf-8?B?NnA4dEd4eEMyK0dKcllSTnBndjVaZ2IycW1PTTRoWndMeWFHQnJTMHprMHRu?=
 =?utf-8?B?eERzVVlQcnpMM0FBeGc2ajZIb0xQdDdrN09wcjlFRzA5d2hnUC9HVTVFcm5a?=
 =?utf-8?B?U3o0c0JGeU95UzY3OGVUanJ5aWE0cm9EOHZsNG8yYndZNmw0OXZDOGZITEVR?=
 =?utf-8?B?ampKeVR2MmVOYUJ0bXZyUDdodEo2V0dZdG9GMk4vQlgwc2FyRnhJZ1Fydzhs?=
 =?utf-8?B?akVkL2R4R1FrdDc0Ym5OQUZENmhTaE9qODFBRUJjSk40ZU9LL2hwUjVuSkRN?=
 =?utf-8?B?ZkIyUGFjWXIxdUQ3cjhHeTJmRjZDcUlZdjQ3SWMxakt5YnJLeHhPRFFGSW1T?=
 =?utf-8?B?L2tOaUszSUt6M0Rjc2N5MHg0R3E4NThoaGRxNGdJakZPeHVUaFdtWkcvd05j?=
 =?utf-8?B?VmJCZ3JkNjQ3eHM5UTBMcnUwRVZOb2J4Y3h0MEZqUFl2R3VMRGpDZnZibWJK?=
 =?utf-8?B?SGh6cCsyOHlKVTRXbVNaUkp2N0tqKy9CamNQNEpnbFlqRUFFcVFBZDlsd1Nh?=
 =?utf-8?B?NGdjY2Y1cTRxcTFKTGpVaE9FbGRSUEJOOXlBUXlmdmFvbTNsdE84RENzaVpy?=
 =?utf-8?B?enQ5dlkxeEV1MFJNZytxM2x3UC9xUDVmRFQ3KzJhYnhNSk5pdGR4RzloRFNQ?=
 =?utf-8?B?MzVRaFJvMzhuL3dqaVFRQnl2OGJlM2pTUXgxR0hyVjRjaHZVdXd6Mjduek16?=
 =?utf-8?B?bnZ1MjQ0R1YzcDhEOXdYUDluUVdFTXRRQlJLeTBtcFJ2WVJXbDVxTmRuUHFG?=
 =?utf-8?B?ZjR3cnk4dmJLMnltcVpDNnFNa3pNVGwvZlZub2dJYzhkcFoxQjFFamFxVXAz?=
 =?utf-8?B?cjNNYTF1bWxYUUFpd3VtK3dFYllxWlVBTXB2Q0QwVEh5cjA0K1VrellIOUpu?=
 =?utf-8?B?Tkt5cmRUNWljWmJJR0ZmSnRpR2p3cGxYTDJ4SFI4ZGFjVnRCUlMyQVpFYWxO?=
 =?utf-8?B?dUt0bzR0UXBOR2NXSnJkd1N4SHV1Mm1KUlJJeVlQTjB3MFRSaENJMS90ZjdX?=
 =?utf-8?B?RUR2ZEhDL2QvY3E2UldDV3pITXdoQkprU3NQT2plZmdlRTc2SURxRWU3OHh3?=
 =?utf-8?B?UHpRYm1pZGl2SWhrVnJJSkUydHlqTzNpOTVCVjlUUjhqUitTdVdXRlZyUDIr?=
 =?utf-8?B?QXQzdVJlYTY4Wks1ZFBST01xNW9ENXpDN0VOOU1KWC9HejB4c2lmUEZNZUp3?=
 =?utf-8?B?SVlvbStXYlE3cnNxUFZhc1ZKOEFPVDEyQnVmWTJ1aW05b3hXd2xGamVCSnV0?=
 =?utf-8?B?T0cwNXZkWWNNZjZiOVdYeXYrOS9vMVBxYk45V0pFR3NVSjB3NjhzNm5kcGdP?=
 =?utf-8?B?SThydllkdGt5b2NUWHovWjhSWXBldTF3OTBBeWNHazcweGJKajF1eGkyclF0?=
 =?utf-8?B?SmluU1JzaEdDVVVLYXUwQUxEbDd4TElObFlzUHJPakJybDduUmdUWmVzbVZ0?=
 =?utf-8?B?L2dONWVhNzlKbWdIaEtnaGNITktJUi9aTXY3a2k3cnp0YjRuKzhCQ3Y0b2ZE?=
 =?utf-8?B?cU01ZlJNdlFqVDNVWW9NdHBNRy81WjNzcEhYL0dwUnpZR2VMOGhGbEV4M2JW?=
 =?utf-8?B?S0pJSlYySjhkZmY0czVOV3JyNjI3aFVhQWtjNnR0V1R0d2ZNeVdjNFc1ZTZX?=
 =?utf-8?B?UnM1b0xiRklhZmdUR09PUkI3NzZJVVRQbmZZUE12REE3a21PaXpyUDFvUWJa?=
 =?utf-8?B?ZUtoMEZsMXd4RXJ5N3U4UFJBVlM3MVV0ZEpRNE9SYW8rRmYzcU9lelZhZGZ4?=
 =?utf-8?B?MnBDOGllb3IrU0hsL3dvYjN0MldNd3RKdGlRbWN1R1RBYXFrYnF2bm0yM1FB?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edd2889b-043e-4f88-84c2-08ddc033657d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 04:28:33.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsPzu4T7kYb216sb/QgHMUh/rPUyAvfVyn+5B6+IvDgaORTjzaCZepKPPAR+/De4rHgbjGwtn+vki4MSHPJ028vcgM+1UDyCr8uEwZ5cyv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Wed, Jun 18, 2025 at 10:04:08PM -0700, Dan Williams wrote:
> > Changes since v1: [1]
> > * Peter took one look at v1 and rewrote it into something significantly
> >   better. Unlike my attempt that required suffering a new parallel
> >   universe of lock guards, the rewrite reuses existing lock guards.
> >   ACQUIRE() can be used any place guard() can be used, and adds
> >   ACQUIRE_ERR() to pass the result of conditional locks.
> > 
> > [1]: http://lore.kernel.org/20250507072145.3614298-1-dan.j.williams@intel.com
> > 
> > Note, all the code in patch1 is Peter's I just wrapped it in a changelog
> > and added some commentary. Peter, forgive me if you were still in the
> > process of circling back to this topic. I marked the patch attributed to
> > you as: "Not-yet-signed-off-by". Otherwise, my motivation for going
> > ahead with a formal submission are the multiple patchsets in my review /
> > development queue where I would like to use ACQUIRE().
> > 
> > The orginal motivation of v1 for this work is that the CXL subsystem
> > adopted scope-based helpers and achieved some decent cleanups. However,
> > that work stalled with conditional locks. It stalled due to the pain
> > points of scoped_cond_guard() detailed in patch1.
> > 
> > This work also allows for replacing open-coded equivalents like
> > rwsem_read_intr_acquire() that went upstream in v6.16:
> > 
> >     0c6e6f1357cb cxl/edac: Add CXL memory device patrol scrub control feature
> > 
> > The open question from the discussion [2] was whether it was worth
> > defining a __GUARD_IS_ERR() asm helper. I left that alone.
> > 
> > Lastly, this version of ACQUIRE_ERR() matches Peter's original proposal
> > to have the caller pass the lock scope variable by reference [3]. My
> > change of heart came from looking at the conversion and wanting
> > ACQUIRE_ERR() to be more visually distinct from ACQUIRE() especially
> > because it is accessing lock condition metadata, not the lock itself.
> > 
> > E.g.
> > 
> >        ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> >        if ((ret = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> >                return ret;
> > 
> > Yes, checkpatch disagrees with assignment in if(), but cleanup.h already
> > demands other expections for historical style, and a compact / limited
> > idiom for ACQUIRE_ERR() feels reasonable.
> 
> Hi Dan,
> 
> I've been building upon this set and applying this diff to squelch
> those checkpatch ERRORs. Please take a look and consider adding for
> review in next version.
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 664f7b7a622c..193a03fa7114 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5682,7 +5682,14 @@ sub process {
>  			my ($s, $c) = ($stat, $cond);
>  			my $fixed_assign_in_if = 0;
>  
> -			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
> +			if ($c =~ /\bif\s*\((.*[^<>!=]=[^=].*)\)/s) {
> +				my $expr = $1;
> +
> +				# Allow ACQUIRE_ERR() special case
> +				if ($expr =~ /\w+\s*=\s*ACQUIRE_ERR\s*\(/) {
> +					next;
> +				}
> +

Thanks! This lookls like a good fixup to send after ACQUIRE_ERR() moves
upstream.  Should probably go with a wider set to update checkpatch's
understanding of other scoped-based-macros like DEFINE_{FREE,GUARD}().
