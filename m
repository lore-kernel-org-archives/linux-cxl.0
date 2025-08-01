Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446011ADC93;
	Fri,  1 Aug 2025 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074175; cv=fail; b=kgWRGYiNAnQDD2MxeQb+yW0EzjOPyUXeL9DiLbuvLyFKFWfRBJTjraoZVkUPAJOfrPbrFyeShU0X/Hnh63JI0dCPV7F0MEHwWNjVIbH0NPjdHaM7Hm0s4hrDt+G+J1s7IQ6ayQB/ShEd6xPyTQsPBT78GQuCUk/WO1+mlwNKqR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074175; c=relaxed/simple;
	bh=c3yWDs+Rm2aPCvfkh+taX9PAxcAK7U+72IOchbCTAdk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=oGe9A5DkUiITYZesuPlYUebter5WcA8XcEwKGL96mZDC/mb3sUX6cXa9LPmWfP9S7qUq89QqtcFFaLzf4BIU2SE1KZpEbiPk38Hr9uE8Ed9jTbv9cfxTQqc3ybCdPmYKoSvmiGEIo7wsx76po9RZN4Kky+hzSCrJDx1AEsS/g3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBQlgFUK; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBQlgFUK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754074174; x=1785610174;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=c3yWDs+Rm2aPCvfkh+taX9PAxcAK7U+72IOchbCTAdk=;
  b=OBQlgFUKuN7hCAd1CfCPz0UNvs6nWr9kBQixdrx99O/DDw8dfGeGdq3r
   k2dHhTLFyd69OIgzKLK/24a6w0aUItkCTXf7XKqHEgsHvaGoNgyI9FpBF
   0J2LC9utX5AEfbWTDzGR165hbL1oDnwx9bRici7/0//gnWnapMKpMsMYt
   pplPSYWzJZ6mw4FiIviOnBovskT0LtbPWSy4SF4k/YNQKKxsqzvRqrDlC
   QbZsmEN8wMBtxwIWUwAQ3pbKNR+InTGDx1P++YrAU5PxVuMao3repDrTJ
   /KcU8G/x0ONzslRueWy//NJFL7rbTy+6IjHaIhAEJUVGQeCiJZDJ6bSM4
   Q==;
X-CSE-ConnectionGUID: 4Z/6FghnRFO+prEn5CYwzQ==
X-CSE-MsgGUID: ++bBkp2ETY+eex471ax09Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="78981809"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="78981809"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 11:49:29 -0700
X-CSE-ConnectionGUID: MclzhfjCROOGnYUcCNx53A==
X-CSE-MsgGUID: IhdnvS2MQSq76XNruxySfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="167822989"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 11:49:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 11:49:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 11:49:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 11:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNWzpAomptIzG7AFA6Xq0nAtvfGzGb5g+70ezMrEojBCCylEYCpL0cQWL1kbUcg+1iUCkGlXsWK+1eP+J4WhKtRWpaOOsnYLj2TH4Z4FFpaFIANaJxe0nOauzB2r7MSTnVLHPptMEMTqEm1EMhBA2TlZ7bYR0BP2mGKdossrWKjAkV2T7uajoiFif3Tlhe3YJthsrj90IOodbe128F+se0lBpPdCXI59AyJx4+qiDxaIztih67us4igTgHzDOsPup1UGzGPiJ8ulprdGZcObVos7aTBpMiq382uy1bzi9XSPUbc7wAK1893a5ZF99p8pwfTsAW0Z18Hcrc4o6SO81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w3VQAs4NRM842YU8wZzJ7sQ/goUjwSu/XeWlskkmy0=;
 b=B+AJm1AqS9GLQcLkr5aYyzaHkrJyIyX+Xpi5Owf1vmpyFskfWmOlHMlzBw+o9qqJZODZ+rXDNXhVXMInYyhWUsdXChOqQkhhEdJ1Gpm2efeepIJNN3AWeZJMupD3is8q6hHRtqVaIGM16jBuUUsnyblamuOxMcTQiS4Hnn9uklefZF1rLAuyPP+Yt3q2VyiQoHO7sXzlf+u/OF86P+twgdUVNQpy5vm2c7O6I9ZAR4VmIn+oNyNV53XrqYOCJvQumEPEOOaiOymP3V21SVYMQwcU7lSukUbcKPHob/59hekmim1ZA8Wc87MPBo6FAg2AZDO64Tn7aekiA95n1sSgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 18:49:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 18:49:24 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 1 Aug 2025 11:49:22 -0700
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Nathan Chancellor <nathan@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	David Lechner <dlechner@baylibre.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Ingo Molnar
	<mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Shiju Jose <shiju.jose@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>
Message-ID: <688d0c322cdd6_55f091000@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <aIo18KZpmKuR4hVZ@black.igk.intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <aIo18KZpmKuR4hVZ@black.igk.intel.com>
Subject: Re: [PATCH v3 0/8] cleanup: Introduce ACQUIRE(), a guard() for
 conditional locks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a75776-3029-43cd-31d1-08ddd12c2219
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2dsTVlmbzFGd3Q0bzhoaFN4REI0YVpvbi9JeWdmdy9kZ2JySTNBVWFWdFE2?=
 =?utf-8?B?QTNYcEx5WHhRamp3VUxpdWdpT3E0YjBBSnhQWU0ySEZvUnlwR3hFa1RobjlQ?=
 =?utf-8?B?cTM0WTVvMms4d3FVMkVkRWhGRitCYkN4cTVsWFhGU1hRSlVCS2x5RktSTml3?=
 =?utf-8?B?TWRtYmowaHJ1UHl4bmVDQy9SWlUxMDIxNWF3c0Q4cXFjbTgvZm9pUjFnbWlp?=
 =?utf-8?B?R1NqaldOQWNYSVBoUFZWTjNjdEd2Vy9MTXNyYmpzaUk2VVMrYllWT2FkdHFK?=
 =?utf-8?B?cWlnQ1JCZ2NNWTFTYTdHQ3pMT1hiekJ4ekxlazBHRThUYzJpUitGNmw1eWlE?=
 =?utf-8?B?cWowTXRsQ2ZlWkhSVnlRdjIyUSsxcFE2VHYrV0V5WURWTk1IUFFPYS8zais5?=
 =?utf-8?B?bnEyNktGdHJHSU91MVdQMEJjZm9udWw1Yi8ydk1mT1lrMDZzMmU1WmovTDRJ?=
 =?utf-8?B?bDA2MVVnd3ExeldzK2NMSCtNTTRpNXJWWlkwY2t5YTl5eFQraE52TnVZbW5r?=
 =?utf-8?B?SWVZQjY2V3I3dkRDdDFLeThXYnpMNmlkYkdtZXhNNkVqQzhkNWJjUUFsSk5N?=
 =?utf-8?B?Nlhod3Uxa1lVVEhqK2luTEl4RE4vZlh6MkxSWHkreDJKZE9rdUsrTmVXZmM4?=
 =?utf-8?B?TWJaVGIyRGRCR24zZThSbzV0TGdBT3lxbm1ERFUza0w0WkROcUNrUEVTcDVQ?=
 =?utf-8?B?VVk4SUNaR1dJTzA4OHJPbzIya2I4bExFL3l5RnJKb0JGZTAvNGl3aVgrUVlH?=
 =?utf-8?B?MkwwUzZCRENsYU5lZWM3dWpXb0dGM0lXSWZrMHhmYnJvbGIwWjNlcFBTTmtT?=
 =?utf-8?B?eWpRNDJzdURKM0xtVnQrMXdFUUswbWxVV0o5M29YRnNlblhwb3hWOWVjTjdH?=
 =?utf-8?B?REtDMzVlcFBiRFhoN0dCTW16cDBJZ0c0YlVpTXlYME1XWm51VjB4bzJUR21j?=
 =?utf-8?B?L2c5VjdFMmFlSVpsdnhOU25PcCt3SG9PVmlOd05RVXpRN2IvMWt0RDZrUjZU?=
 =?utf-8?B?WitwNS9waDFrU3Q2aUFCNzk3aFNmYVNXbFZKT2JWUkdTVDdZc2pxUzY0anc5?=
 =?utf-8?B?L3NMRlFtSzhvcFN6U2lDTEtUSGxGN3Y0Nk01L0lvWFlzY2RmckdEQVNZaW43?=
 =?utf-8?B?S3U3dVV4K0hnOEpIUllxOTd3aEd3THRNU2xQZUU0aVY1MjRuYjhsNjZZd1Nw?=
 =?utf-8?B?dmNad3kwN1NoeFhZSmd3dFIvQVhuUTM5dUd5YTNseUgxekNxWDdCY0Jyb2Fp?=
 =?utf-8?B?aUVCWWlKNGxnenpiaDBMdjRBbEMxWEpjTmd4N2oxQ1hMU0xrb0taWXB0aHJE?=
 =?utf-8?B?aEpmSjlTT0Z1Q2sxclFPZ25iWXUrZUNUZ1Z3R3dUTkl2NWtuRXFFSHJqdWsy?=
 =?utf-8?B?VU1Md1pGZzk3U1JZWWFNRmZtTGtMY0tZSEd4NUhQTVBBODczYmJhaFZaNGhZ?=
 =?utf-8?B?eG0xVHcxOUhESUo2UnNaOVJQVFB5bm5xK01OSHgyUDF0S1Z2dTFnc1ZRYWZS?=
 =?utf-8?B?VHZHWWhIYjFjMVpTZ2YzV05HUTNScFdkY2JIek9WMDFiL1JsOTkwaW4rcklF?=
 =?utf-8?B?MXRadlhoNXhRcWJObWFudHlna0Z2KzQ2YzFqTnNHTVlQbzFLNUR3dkFhRHZj?=
 =?utf-8?B?QTkrSXcxNVo0YmErVVh6ZjNxY3hSV0N6SS9ZOWRBa3ppUVE0R3J4VWdET2Mz?=
 =?utf-8?B?UkJmQ2NFUWlMMFBMa21CWE1PeXJaVHZEKzg5cHpBbTZJUWorbktFYVpWeVBy?=
 =?utf-8?B?Ymphb3BxTHBMOVlINndGNHVVZTNjR1ZJL2JPazRBeWFoNHVJaTZBVjMwMEhh?=
 =?utf-8?B?dUVvM0VaOVRnUEpzdC8wdFdETU1USFZEUmkwWlF0VWVHRjVEbXpGNXZOQVZZ?=
 =?utf-8?B?V0lRWk5YZ2VuYXhyL2UycE1zMGhwZURyRHozZlZuTXdVZlh6VXBxS21iRms5?=
 =?utf-8?Q?c3QKLVo0raI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9xaHhaK3N2ZnIzVWMvRWcrVW9oV0dDMGJRWi9oQ0s5aXBiSllaSmJMRTVz?=
 =?utf-8?B?SkFGTjV1SjAvZUNVanVUdVZTWXVia0UyQ1NkQjNFekNpNnpoUUFYRmU1YnVM?=
 =?utf-8?B?V2IwVHdJZ2NiVk5ubFlRRWlpeTVzemI3UWVpdlB4QWhoZzRIU3hCdFE3b0pX?=
 =?utf-8?B?dUEwMWMzUm92cjBEblJMYWcrL2s4Q0pnZmwzTGp6NDJmeFMvMnQzd0NzbVhO?=
 =?utf-8?B?UFE0RG5pcFo2SnRVeW5XWnJkMzZqQm5TcHc0QjRmNmFjK2lTZnY2ZTNMbDla?=
 =?utf-8?B?RGJ3YWVMYU5mQ3BrMkM0K2dlT1BHbEppN0w1ZysrcDlEWGs4OG5odlZkOEdx?=
 =?utf-8?B?RDNnTDZvRzNmdk9lZlNsVEsveENPRnJvQXV4dTJxVmZORmxHY2E1aUJSL1Bm?=
 =?utf-8?B?L3RFY0VJS3ZVeTRYWkxXa2JEV2kxV04zcjUzMG5DclJqM1pKb0hhbUh1blVu?=
 =?utf-8?B?anprWEFUbHhxelpYb3Y0R3NkcVVvb1FJaXA0L3k3b2xmY241ZllOWW04WGhR?=
 =?utf-8?B?TmFZWTJ3S3QxS2kzZ2FobnN4MGZzeE1tY0dFUmRUWkZOdDh5Q2w1Uk1ZN21q?=
 =?utf-8?B?UGx3VXNPaWpsTDlLMHFSbzU3Z01TSHN4NlJ3MXZUUUZmaUFPMFkyMUZLYy9C?=
 =?utf-8?B?ZVA2c05LWkQxNzVGcXFJUkhud0NzOFZ0ZHN0RFZFZjRPcTVmUk1ha2RHRzY1?=
 =?utf-8?B?VFdHR2hmN2ZESWRYa09LdzRhd0dkWVh1Q2dmQkd0VlZCU2lmVDB3cFMvNlll?=
 =?utf-8?B?ZkViWFE3NmRnQzROa3A2VXpsWit5ajFPWXB3QmdMbjRSQ2poUFhsVXNSTTdL?=
 =?utf-8?B?TzQ1aCtrV0ExN1pScWxNVjJzUFJneVA1enRDdURCM25vRHNMeXFwbnZVWXdV?=
 =?utf-8?B?Sm9OUHFkRy92RFZVMm1RTllLUnZaZC9CVmxGc1BoWllwZDh3ZWx0YnczKzJ3?=
 =?utf-8?B?NDdqblJmamgvaE5QZGhKOEhqZ2dLYWVvTWFjL0pnQzVDRzN5TFVtd1RWTDZp?=
 =?utf-8?B?UVRxYS95ZDBhYWxndTR2eTJVWUtKNWdrWjlXWFN5LzVzbjEvK1pSMmlEVlBw?=
 =?utf-8?B?amp3VGRwK3FyY1FSbDMzbFVjQzlnLytIL0xaMjJrUy9UeW1aRWp3Y1l5aTRV?=
 =?utf-8?B?bithaXk5bmRtREk2SllBNXNIWEt6cEprSENxQTA5bVRwZytuT1QwS2VTQ0FG?=
 =?utf-8?B?YU92a2o1cmt1cE0yeUxacUVzaHp4WEJUM21rbi91MDI3UlVLV1RiN0ovTDZs?=
 =?utf-8?B?SWltTGNCMUJBZitsM3pjSWR1VTZCVjN6eitKWERZb0pYQ0FpaU8vOWp3SzNl?=
 =?utf-8?B?dTFyZno1L1UwaE8rQUhHTUN1ZnpuMmw1NCtIL3pUWUI1bkR0alREQU5hMlgr?=
 =?utf-8?B?cW1QejI1TG91eVVPd2llWFJNV3ZZU0trLzhOUHRqY1dlWmp4Yitadkl5aXl1?=
 =?utf-8?B?VjM4MVRVbnhhSTBhTUxQaC80eXQ5SldqUm1PMVYvMGRFUjZQS3NtWFpST0tW?=
 =?utf-8?B?ai9wZXJCc1FHS25nYjRqeVd1MmFYdFRBanJwR1NKV2JwZjYxd3R0MFlmdFdk?=
 =?utf-8?B?MFVLVGl0TjREd2xIYzhWMEl1KzF5dW1zVURNZmRQeDdGWGczWDJVeDdlWUF1?=
 =?utf-8?B?YTZHOEFsUEhPVGpEL29OQnZOOUcwM2hPemN2V1QxdHh3aDM4U1hqVjk1di8y?=
 =?utf-8?B?S1FXT21ma29nY2N2Wkk0Y21QUzhwYVhHbkthMjV1cFZGUmgydnBXcDhMSkd1?=
 =?utf-8?B?bnlDNzdIT0ZPVG5SUkZOZXB2RVczZVljR0xMRDBTYmZlVEVLWGczR0RSYlJt?=
 =?utf-8?B?NndkbGRwZG5sMFErT1loVzNHUklTWlVUbmF2bE9zamR6anJyTU1EWi9DNi9P?=
 =?utf-8?B?T0NsZmhYdW8yZVRRc3h1QS9vMzNyKzgxRTl3RGFZMDZVL212YjdIUXFzRlNx?=
 =?utf-8?B?d2ROb09TLzJLYVVCNGQwbjl6TlI4bHM3clN2WlFybHFCUG11YWt0U01iQjJD?=
 =?utf-8?B?eTQxbXBDdituSDVzOW9kWllMRzhzZkU3MXg4RHpQODlyUWdsOGk1WWRoMjVV?=
 =?utf-8?B?bU54T1NZcjAyNUpXS0cwR0ZhWUxmNmJ2STB6MGFEZHJDSXNjajdWTWJNQXQ1?=
 =?utf-8?B?VkhSVWdFOXdBRjUyOG1oSDE2MEpkTlZ5TTZQMjdjbUFNSlcyRUpXUG96OENl?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a75776-3029-43cd-31d1-08ddd12c2219
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 18:49:23.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj/PogOmjGCDwoCMK7WEhfNqdm61suUqbvg7XqYf5iYwwZlxH1ehciMCxa2TQPNShEDkfMKzfsbgHpErKE4sE0bpxwNkgQLJCopq05Yms5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 04:49:24PM -0700, Dan Williams wrote:
> > Changes since v2 [1]:
> > - Pick up Acks and Reviews
> > - Whitespace fixups for cleanup.h changes (Jonathan)
> > - Use consistent local variable style for ACQUIRE_ERR() (Jonathan)
> >   - Not addressed: switch to less compact style ACQUIRE_ERR()
> > - Not addressed: pickup checkpatch change for ACQUIRE_ERR() style in
> >   this series (Alison)
> > - Drop the cxl_decoder_detach() CLASS() and convert to a helper function (Jonathan)
> > - Refactor attach_target() to make it easier to read (Jonathan)
> > 
> > [1]: http://lore.kernel.org/20250619050416.782871-1-dan.j.williams@intel.com
> > 
> > For those new to this set, the motivation for this work is that the CXL
> > subsystem adopted scope-based-cleanup helpers and achieved some decent
> > cleanups. However, that work stalled with conditional locks. It stalled
> > due to the pain points of scoped_cond_guard(). See patch1.
> > 
> > In the interim, approaches like rwsem_read_intr_acquire() attempted to
> > workaround the pain points, but started a "parallel universe" of helpers
> > that is not sustainable.
> > 
> >     0c6e6f1357cb cxl/edac: Add CXL memory device patrol scrub control feature
> > 
> > Peter fixed all of this up in a manner consistent with existing guards.
> > Take that proposal and run with it to unblock further cleanups of "goto"
> > in unwind paths in the CXL subsystem.
> > 
> > Potential follow-on work identified by this effort:
> > 
> > - __GUARD_IS_ERR() asm helper [2]
> > - Checkpatch fixups for proposed ACQUIRE_ERR() style [3]
> > 
> > [2]: http://lore.kernel.org/20250514064624.GA24938@noisy.programming.kicks-ass.net
> > [3]: http://lore.kernel.org/aGXDMZB6omShJpoj@aschofie-mobl2.lan
> 
> This series broke `make W=1` build vor clang. +Cc Nathan.
> 
> Par exemple:
> 
> /kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
>    89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /include/linux/cleanup.h:376:2: note: expanded from macro 'DEFINE_CLASS_IS_COND_GUARD'
>   376 |         __DEFINE_GUARD_LOCK_PTR(_name, _T)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /include/linux/cleanup.h:358:20: note: expanded from macro '__DEFINE_GUARD_LOCK_PTR'
>   358 |         static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> <scratch space>:24:1: note: expanded from here
>    24 | class_lock_timer_lock_err
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.

A few observations:

- This is odd, the inline should have been compiled away if not used.
- __always_inline does not help
- Seems to go away with __maybe_unused, but that seems more like a
  compiler band-aid than a fix
- This locking pattern is not immediately amenable to the ACQUIRE_ERR()
  approach because the unlock object is the return code from the
  constructor.

Given all that, and that an ACQUIRE_ERR() would end up being messier
than the scoped_timer_get_or_fail() approach, I think the best fix is to
quiet the warning, but maybe Peter and Nathan have other ideas?

-- 8< --
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 4eb83dd71cfe..0dc7148d1b88 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -348,7 +348,8 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 		}                                                           \
 		return _ptr;                                                \
 	}                                                                   \
-	static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
+	static __maybe_unused inline int class_##_name##_lock_err(          \
+		class_##_name##_t *_T)                                      \
 	{                                                                   \
 		long _rc = (__force unsigned long)*(_exp);                  \
 		if (!_rc) {                                                 \
