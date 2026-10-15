Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5341A4FD;
	Thu, 15 Oct 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086001; cv=fail; b=sYbuxGeXqh0bgsjlomEzTXj/llIwYXTiDe1T0RGD6vmc1v3qeW60ql7Pxl/Nbm4XuMwwocxE+O8/EUN07YZeTKKqwLR6glSz95IvQhK9i9K7DlmUQ4Ck6zvD/OhrtO63A3eLVKrIRmrUDvFO9MKUR8IxVESiWZf0MWUSpBgp3/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086001; c=relaxed/simple;
	bh=EK90g9hwVWNACRQ1++vFSj6OTJMI40+k8g/Evv67Ow0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QGVORkYwz/+fy8Vu9+ZSyc8Dvnpblkmp8jA5aqkuLsHyi47z0abNHo5wMrAyYauHMk3KqHW/AoB3UEBSCgaI99NEnPLGBdxpM5uilQ2vVenQ00Hk7IyNZVTWtbvSL0DfD1QyN+Z9ehYWFn1V8bwiHjjbZNQozBHy6OIXebTGyFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPAOXfLQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPAOXfLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792085993; x=1823621993;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EK90g9hwVWNACRQ1++vFSj6OTJMI40+k8g/Evv67Ow0=;
  b=JPAOXfLQ4ly8Mrb8Jp8EsgF+BM6wnxOFzjQVU+CgO0OUS3G+HKxEvicx
   HDUbJRLKkaxoMg09KWPo8h0p0lYHHw3r4Jwnf3UdrU2BA0YnL5aozurA7
   gqFN2Ztj54pdQN7m9LcmkVQRXUSRnvs2U0CX7X4NaAMcPmAt9DGc4TcQ7
   R0uzDsndMdG4t0Vq6HfhPftjRBVv+tFYYTXbMwH3UyKQ+C65p/o+5QIva
   IM9mOu4w8xAzHutNYIt4jFiXIq2e7YwFDWzVC9OZbjaHf+/WSEFcnO8wU
   C05ThdEd6/EwMtul95AuY6APP+Jv41vV8QPPKaYBPRuZHeselo/8NC/Ih
   g==;
X-CSE-ConnectionGUID: gMAmKme3QqaCrCZeHOfq2g==
X-CSE-MsgGUID: xq9G+Ip+Qxeahhli4zBxPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="867080"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="867080"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 10:39:52 -0700
X-CSE-ConnectionGUID: QfybzG5MRXe7Vi6D75lqZg==
X-CSE-MsgGUID: vXjfg58IT9++eT3t2sOwzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2066252"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 10:39:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:39:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 10:39:51 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:39:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8gJ77UdPNBIpwQj5zbeYyNfR3UsffgF3gZ2pkgPVtrtNbpyFaaZM7/1DbMSiPPlcz6RarfqxSyWyaIsdrtcDEncwvnQg7irNO46v843sje7YUZ6LxJtRJMq/oyxbixPhrmFZpwUgfFP9WbgQmasTfYatTBIXO3mLlekIHKRtFV+camXkjUaeXgEyajbxS0J1EfoIAq6tbNsKKLI/85wF88Vb/ZHHjPWzunDdEo0sEt+3AqL8YZPnOTrFeiUobV4g2IzCOX6uaK+ypDkxVITs867S3CD+vzbEBAhqzJ/57qePwXDwB2wtHAT8ggtBsWWzbC6Aq3dsh+VnZAwTVouTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGorEBBYV4ZEI3HHNP03iCRWfKWhq2Av6nR4DeMFm+Y=;
 b=XqcmOPl7dJf1+FdZiOTk3Gc/eVFg9msBCPlNHJlulR+W4eRTk24JTNlUioGxCZtPQ9bVgcAaXNo1qOeUA10RHQNKOD+lDfBSBSDz6VXyOKvIL2+4f3WgqjmtxO8iHzdOqpVIGQ86H9rKCuZFcgGp7ODxR3g52lUPOFBtXXPam8bMfk1heqDqpeq0qDmWkaHgAIGrumeBXqBdT9ud/hkBb4v/40lWZ9XGGCkcYD9QdiC1BMid++AmbYSXxn3gQseOrQMN904pl8+bsbb5TFFbfgDljHe7DXbxiTPQ9PmdcFTmdJwQR/ZXOwdgVtxyoLxW0d8IWgOfuIMqDioeAg0QUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB6271.namprd11.prod.outlook.com (2603:10b6:8:95::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Thu, 15 Oct 2026 17:39:47 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 17:39:47 +0000
Date: Thu, 15 Oct 2026 10:39:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: =?utf-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>, Richard Cheng
	<icheng@nvidia.com>, <linux-cxl@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
	<iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Add the CXL 4.0 command return codes 001Fh and
 0020h
Message-ID: <atEP3yvpvEK3O3VX@aschofie-mobl2.lan>
References: <20261015055048.1765042-1-huanggaobin23@semi.ac.cn>
 <atCLjvE5xJp9jo6L@MWDK4CY14F>
 <31c53d8e.42202.1a13eba4ae8.Coremail.huanggaobin23@semi.ac.cn>
 <ec305690-a036-406e-8185-d93632a5dcb7@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec305690-a036-406e-8185-d93632a5dcb7@intel.com>
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a46180-7660-4783-6ce0-08df2ae34ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|260925021911599003|260925021311599003|260925022911599003|11063799006|4143699003|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: ZA5YaA+HNveGIOPD9/zcjHACgD8XhOSx2jZCXsULohgXGMwl+DQfHjxVG/R4h/SjZ/6+abJttdUX6ub9KWDmBOmNUgG3Ju7MXqNp2NW1m3N4hf3p+hu55blvKobfmRWxJ0VaANaA9Lx6/wt3TbXQqHb4giBQ3FnjNrLh05z3Qe8o+oMecyBWApOwhmncM9G+1B5T9/DGMutx/mO6QqqH06mQQnbYa8YdT1GJduB/6VSFUlo2Blx4row5EEMfTQ6D+gbY3qKp3Y+2OEV0JrmJh9+OYns43YzpWnuvow0HtgVzYr77mB+gqnG1SNzg51Tc3gSQfUEelEY1aDUBACAlIfN4NnFwRqcmsB7mgCrE2DHUmIdoPHkzKcmnZlSBfeUOWd/9KqXgvdljcolwUtokC8FLog2inwIj6KmeH3nZPP86IWDLogxKn79HK2t0yWTEYqarIwVTcVZZjo7awR6By5XR5CUWEz6Y38b5oYnywV2pePmO/O68Q0U5Hho9xhJi/24Zc2KjM8CXd3wCLxrpFrtiRbJhhU9S5aXe21ADk/bLcvdmIhVnQJJTnOZSs0xtd/rWYazMYgpEo/yAB5Sr6P+5t6JMcO4RJ/tJczp2WQ7OqTXDMunUTW7lAy9Jc47A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(11063799006)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdnZXFJSjJxWmNLTnk3TjN2VldyUE5Pa3Z4aklkRjhUaDFvNkp1MnBUVnlN?=
 =?utf-8?B?dzBlU2I5N0krS2pVUzJHV0t1ZW5xdEJiSGQ1OXZLK2QwUjBWUlNYZVMzUWlZ?=
 =?utf-8?B?MXdYRGVyc3hlZjhmTXh3YmliOHJRcEN4OUFQcENDMytMeU5hdHN5YWVEN1hI?=
 =?utf-8?B?djhmMzBMSGVwMGtoR0hkZmtiOE5rdVZHNHdFL0QrenRKaUZydGZ0NUc0dkNa?=
 =?utf-8?B?RXE0aUhtQjVIQkRGellVSllvb1RSWWNacFEvd0UwV0pydHR3KzByT2U1eHFQ?=
 =?utf-8?B?eWJkSjMwWUc1RStHTzA4S1ZXSloyYXkySm5KTnBPQlNSWENpWCtpRUVOVUFv?=
 =?utf-8?B?eE16cU5DVmNtczNiamV1UUdiYVBuZ0dmclRhcEpTc256Z1JQNGkwUTBsczBs?=
 =?utf-8?B?WGFSTndlYlg2MXMxR2xBZVByeStqdHNycVF4eUhIdVpGRStZSzM2ZTNMWURK?=
 =?utf-8?B?L1VWT29nTjAzbnU0TmgzTHhvbDRma1lxbWhnRitmWVJHdHRod3BJandkcTk2?=
 =?utf-8?B?eWQxdU9sS0hsNU9SbUVZRkVYRk82czVKU05PdmFkNXhDWWdCWlZadExLU1hn?=
 =?utf-8?B?UlpKc0NoSUEvR1czUm1vRnpXOGQ0VEZRTG5FNlpjYlNJT0JUaDVBdmZ6UFNw?=
 =?utf-8?B?dTBDbll6UjU1N281dUs4Qk80RDZZNmpuaC8xRHJtM2xjV0lJZ3pzR1hJTHJU?=
 =?utf-8?B?dlI5Y2ZYQUZIblJqQWk1YTFjanh5QlcrYnFpNjV1MmZ2SG9UbnRta3p1MVNv?=
 =?utf-8?B?aFF2Qm44ajgwYmlKL1U1WkdlK3NZSzBCaWRkRzVsRXV4Q2N3c2JlNFlTRkZ1?=
 =?utf-8?B?ZHczWTJQRmRiM3l5SW8rb0QrWHZCV3V3c1RSbHA0QjBzZm5yaTRqK3RIZzQy?=
 =?utf-8?B?K3dmL1RmTGhPZ0lLa3dHWGkzUXV2czBWcmR2L3dEdXhlRU0zQ2R2cWlONldz?=
 =?utf-8?B?ZXhzRG0yNHkrZEhLbXZTaVd2dUVXejJPamRHMzB2Zy8yTWRsbTE3aU5GaVdj?=
 =?utf-8?B?TWlVczBSMEc3OWl1RzM0UnJjZGFRZ3hrT3o5ZDZsaDlrRTZUNXM2Y1J4Rkdl?=
 =?utf-8?B?bVUxS1QwTVJOS3BaMXc2YXErMGcxemYzMVZEdjNHRUltVlM2KzN2bVVaQjEw?=
 =?utf-8?B?Y004Sk13MGE0OFZqOVNCZExXS01GV0NZWWVubUhkUXh1SzNlNy9TWGhrMy82?=
 =?utf-8?B?cEE1eWF6WVVydllNQ2hoZldUS2JFTjJFVVN0Sk9KVklaYnJpQzQ5R0s3dWQ5?=
 =?utf-8?B?S2M3a3gxa0hzRTdTNDVHcU9EbDQ1Y3hzcUVyNkppWGk4RWNxcFNTbW9IQVZD?=
 =?utf-8?B?VDZOWG5JMlk1S285K2JiS2lFRjkwN1lQZGp6QXBUY0ZNQ2QyeGJ0dDlQZFd1?=
 =?utf-8?B?RFVGbnhwaXU0M1NEQnphdkJCdlJ2L1J1QW9Fd0lIRFJZTjJkRFpvUk1xVjR3?=
 =?utf-8?B?dS9nSHFMbXJDU0lSSmovZjNwbDVuU1lOMnd6STdKMFlRa0ZmdlBZMXJjVkxZ?=
 =?utf-8?B?YmRPRnBBQjF2cFc1dU4zREd1SzJrSUhvMmtsT2d3djVxU0lCVlE2UGV6WHd0?=
 =?utf-8?B?eDhDbWQ0aGRMRmNkMFhLL3lQd1daVjBYL0NVMFVjTTRWMW1UUnhrTWdhKzBE?=
 =?utf-8?B?KythK3Q4eUZFTjVoeERuNWRaQm5BSnRkZjBkVjltSzFVTyszeW5IZWhFanB4?=
 =?utf-8?B?RDNiOWZNTU1Xd0dGa1F6YmpVWk9FNmdMbjVpYWVFUnVJaHFmVWlWM3J3ZHZj?=
 =?utf-8?B?c3ZTMVVOdHF0ZlJDSGFhQzhuNHk5WXZzNXZ4NlZUb3VTNmtiMWV5T2NONkNz?=
 =?utf-8?B?Mm1FNVlwME5SbEVuV2JrL0wwdWRvTGJoemVXek4yODBpY1lWb1JybkN5Rzd4?=
 =?utf-8?B?ZFhQanJzeHhCR0xHakVweWU2TldLRzVMV1gwaUlEVU1acWk2VE1GUE5Oc3NO?=
 =?utf-8?B?NzFXRHZRVFdIWUg4NTJXdk1waTl0VFpHL3h1cG1ObHIvdkpmNTRFNlZGQmZB?=
 =?utf-8?B?cWwwMEtIajFPWk5iUjQ4Sjh3SWEwMnhJVFYzQXdFL1BPWHNYc2h3WmJ3Nmdm?=
 =?utf-8?B?NCtNUTVscVdUZlRXeGtHWktmZndNcllzajVnSGNlSnlEMVdFOW9uamE5eWlN?=
 =?utf-8?B?Q3YzL3hVSzVsN1BDNE42UjJGb0RRcUtOTzZuUm5YdVlpU1JUOC8xdGlVb0Zs?=
 =?utf-8?B?aklRdmlBVmFFODQzZUljUktLdjIwcjRiVnRNMEk1TzUzSlJneWhwajNhV2c2?=
 =?utf-8?B?R2EzbWFZeEtyNlNnWjNiYVpLY2FwK01mdkFxblp6RXVzMVJ1b1hwYm1xR3Rr?=
 =?utf-8?B?MUNjQnVsZ1JSbzRwWGY3dlNscjU2N1gzVnBpS1dFdldsU2U0Mkt2S3BPMjRN?=
 =?utf-8?Q?ZLFGwCwUn386u9bA=3D?=
X-Exchange-RoutingPolicyChecked: Dk4YXmOcaN5XWNrM9Xd0v9AEGK9j6upixc6Xc/wrzkI/u5mPGrbzFV33qq/6i2f+1eDMSY/DLhcf+N8MiKvYnyPpir+V/EO0Hh5m2KGGxAwNBxeR1KVyuiSMp8C6TnQVryujRRVy3BffU6u3KUAGHb0wxSGoouYXh/GzFAW2zFiVfajBvdnNiHI7l4ROL7z7d9CocKyTIl1oUd6Y0ifv+Lb1NmtORPODk07vMCBBm0jnAGHPe7H3Sl/p/352QEHRoM8+JC8WN9rKrIyAS8sAy0RxR559kI/RKWBJkYjjJVhpQel5vdeWCA1unKglZVIj1SJxAeowqJoWu9yg63FL7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a46180-7660-4783-6ce0-08df2ae34ea3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:39:47.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkjE9Bvi6aiklHea2/fMCAyIqjOeKfnjkpHIdRx5UfTfd4VROFIDk2lTy86cd4a+VKLNB+0mtT/BGhoofan3jZNXZdZeinTN3gPNwkrD+wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6271
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 08:17:19AM -0700, Dave Jiang wrote:
> 
> 
> On 10/15/26 1:42 AM, 黄高彬 wrote:
> > Hi Richard,
> > 
> >> Do we have users for them ? or potential users ?
> > 
> > I checked the related code, and the honest answer is no for both today.


Hi Gaobin,

I apologize for the bad suggestion here.

So, devices will return codes Linux doesn't recognize and your other
patch [1]  protects against that. As others responded here, we'll
add the new codes when we need them, not before.

https://lore.kernel.org/linux-cxl/3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com/

-- Alison
