Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5863C38DC7A
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572596; cv=fail; b=AXbz0Z9IkpVllmZr1dvP3YYTL47SDQsL8qlwt2beNlppd+U3+0QNryR/6e/0lwf3IfUUPYxZ1HpikpRvGpqBm0LNPQmCqPREcYBqI3RPhaqL5/3Wz4VrALAcnDlpkkpEuvtYtvih3+QAW+iWIv8Y6fnz67PIBsfn3r1oqo2Kt2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572596; c=relaxed/simple;
	bh=V2ZORs8iyBitEaTWBTR1wa2HYc/deg6KcBwBOZYgDoc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oqpaV1cZ+N+h3HOCly3VcQWZWlZilcpydi9RuoW8NdcrHYio7OPwqYa0UnbwZekng7c+Se5T7h0VknTmw9QrVD2WIFkVbIytjgiDD5QG5aJTIMzLWznw7YGsdiWsUKB/+TvyZx0LKwzMw4ogqvaxKG30u6FTl5eXrXcVUqOBApE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Igzd1a1s; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Igzd1a1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791572595; x=1823108595;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V2ZORs8iyBitEaTWBTR1wa2HYc/deg6KcBwBOZYgDoc=;
  b=Igzd1a1sbrcF4yTjaPRH9lfakLdx1ipTF6jkqi6Uzn80iK7LFYjpBVAm
   iGe7ZKa5FcrPYh1ZIeerPRLPwoFNq+EPcDqiyMrP5QiFpCQtskoA8I1Iq
   ykeduXKXMlACzyl4vUNgezP4cv/5GhPFTBor1I3KuCAr3SMgAJ+wt6dhT
   5ulE9l3JZ0pRRm+FuRN3HyW0b21VqKxFUK3/vGWLhkhFnEzagdYksXikv
   5UjB4BwKo9Bu1tuLUVrf46IJhSFkDILXRS+IYPAlmgN4HcnoKWjjSwm7W
   gIafl9gs0YmojaNa3xjQFt4Dtq9YwjVshNzNH3Cyy8Dl6XDwKJHE9K/A4
   A==;
X-CSE-ConnectionGUID: cRP0UcZ1R1qm6MUHE3s2mw==
X-CSE-MsgGUID: x6ASCvjQSuudOuBoCI05jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="380418"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="380418"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:03:15 -0700
X-CSE-ConnectionGUID: JTnYVY1wR5yeEthJO2ZZqQ==
X-CSE-MsgGUID: xsPoW32wT3m4JiZI3NCi/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="704969"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:03:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:03:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 12:03:14 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBrWC4AvdA7rn1xCSZnx/52ypTlckhGEXvAajGVUqjKwfgGGfHeCk8debRdMmSDKz25db1eNiWhze7FoJ7GWOSc5kUbf5ktuBT9mVbRupXe8u9XM9h85IPwmOezS4cY6GDxLbNcII2W4epXhozp78A9AueGEgt2GgH36UzpeSluEjaeCyoVHeL4Kr8U7LCsbCOOGmTOF40+zau1evRFAuVpyrRowPnlcEJEeSx4XpBkK6qzcwvpKI8zi8c8VnLYoFfvaLsybxC0V9NNXotFfFLx0hKi9zCZ6dpLlY5ovCPjklgqH2ZYRu2oUvmfiJHwd7MtFqsVRTSN9m3zorbA4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55BCR1jpe54jEir3iDJjniQZOlPLbvoFXbv0q34Xr78=;
 b=E/WbYB4cDwjSXfeOZSF3VH7CHy1QXMs0qav2APh/Jf+DdfizEfD3tuitt392dcWHwD48x7uBXCVhkBbIajzKlzOSkpbmKiK0JjnTbwUXx3psjERWyXkzvGsmWmat3hlYSKvm/0S8L38SHRiUJnf9ZhDyAOHzpmxg3ffTzAAh57j+8Rpkf4WvddBSyjnf8WmtxbztEUCbLypsP5iZWIR35HAWI8t++7YXvwAvgXY5Ok9KrwOPNI+R1q0JpBI96Buys9bkeiV8kdGDRiOwrr1ssNKocBP4UGx8yNjw1US6zKS9v2jQqmFifUyDJQKFFI55yRZ5535oQ7f2sely+EMbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB9684.namprd11.prod.outlook.com (2603:10b6:806:4df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 19:03:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:03:12 +0000
Date: Fri, 9 Oct 2026 12:03:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] cxl/pci: Program the Port GPF timeouts before
 caching the DVSEC
Message-ID: <ask6bW7WQ2AtRdts@aschofie-mobl2.lan>
References: <20261008034619.28059-1-kanie@linux.alibaba.com>
 <20261008034619.28059-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008034619.28059-3-kanie@linux.alibaba.com>
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1c35dd-ac69-414a-eb9b-08df2637f758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: /0uzdos2vq/yKbyP1DP4mtkMMBbB08ndkMHO/mgtDtS7XpD4mtI9CG0+JdMTyeqhtGjm3lmOwAS8AZ37KQwIe54DNshwbQbKcLGo1OlsZkQY4NsfiKxP9LFoLulz6eMPaH8ETWTS36sJcWa35zC26QlUHpGWmXmEb+0pW+ZiC7qYkIuNtZHc0ohvb97LT9+nIYvFm93+Jq88ZgiT/qmUj/g/Ub9kmssu2eYt2vkUJjKAIJXVlUcPCiADmJqbU/lkJoUP+DopoYQx8nDOMbJDmwWPMzqv/LMcTjxbzHUCUfIMXQoMWsSbcB7EGw810xAEcwunlgKPkha+62F2KUuWG/zFuFIURiubmgoMTTZuDTviT4MtH1v1MLc4A0dXIzB1XopmV+9XqXwZnhA+9KQgi/mBFAmk3NsZQ/M2KxYLT2vbi/FFo9bEAFlVHULyoEBAtLOKnxLdCZ4DiDtf9Kq3QyBJnfMgIMR0AtiGcsmVeK10RVtxyQSma9eNOS57EcBXBVRjyN4Z4u47UMkuBPhNwZ1z8arQNg/zLnzLi2GkGAQfHVlGxnL/JQEspJeS5BycJlHDYpodUl/O759pdyuBxd17wpZKN+Tv0yeu5diTnQ+JrLZ28ALUZYkDCGJA7oEWEaTj1VGh+rsPCvAx+sCh0ytHNesJw+YZXQmqep4kJSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4T00ygmQWEokqnCg6WMfUjsCKWp5FZm4Yz+ejhTomjw8btdWnmgklMtUGBNg?=
 =?us-ascii?Q?sOnOCxXSvikDTou2dnoRvrwy8REBYL56+F0Bp8iTQenfSQjwzP7LgU5vl6km?=
 =?us-ascii?Q?32/ulrxUfs1RnroKI4EvAkLsfbYr1m8L2xq3quthutBXP53Q8QREmQciGbYm?=
 =?us-ascii?Q?4YzZUSebmdqAeDUqCG1BeeB4YPLIae9AMvYu/GK9TxcDVfSJDNIBJl0eF0vQ?=
 =?us-ascii?Q?cC2pYsRnYSP7tmsvpG/RzQtmBUS56lSkwYcmAvf2kPKWxK9K8sjab7lIVO+/?=
 =?us-ascii?Q?Klq5ucU64EX87fLb9Bx9h8xXkYXuzIifVDlNKjVYspeaDHZZPcXUgdvDM2OY?=
 =?us-ascii?Q?gFDN72W6e4++Cb8bpn9XJ0Vt2E/6gZ1n7J/bgC5gqnOMLxanX31ny9PZaFLS?=
 =?us-ascii?Q?UWjyEFsiPNU35aQwTQaeGb7voSBos9GEMy2Bjwg4QV9kguO5iDvqE2GCbucR?=
 =?us-ascii?Q?wALtFZXFybyts7dKpTWIDNhaSiVjVBr4CyhWXcVYBISmmrxUpvYz8QmaZIw1?=
 =?us-ascii?Q?t+QaZdsU6YGIrKkllTGFoZ8h47GnBuiti7XuaBT1jlvUXm2ikz4SJ8FlBUCK?=
 =?us-ascii?Q?uK7yx9B0ATk8o3tUl+R860pOfC2SoCYYbELBKv1j1f5gHFZe0/+xJvFUN2O3?=
 =?us-ascii?Q?nGkRrQBmjdbeeC4QyDwV2CbV9039VwkuAyfv1y9FoKoUPzqI7Bi29IUcR+rh?=
 =?us-ascii?Q?dCra4tuF370MrjrPawYuCO/8abFNdbhtD5l39JdlLKTCBcyO9X8RPPXqWQoY?=
 =?us-ascii?Q?9i8dbKMBVzsTLrfs/ILBcNSUaL89J+cJeRl6aUcE/uFRbqq9Ubkw+d3Y0u0X?=
 =?us-ascii?Q?gXJOSxYKInoogYVUJDcj4HiTxM4kvWacewZjr34/uieftI4vLhJaUt5vP4tE?=
 =?us-ascii?Q?wKN+pIt30KmeedbcJ8c67oAlZtNxCOfZbNC6ZHxuwo1bHbeDpsj/LxaoKZES?=
 =?us-ascii?Q?+pPDoMppV+uLxEke+nDJpX6oTKWpR50ChRVQiKzpLRl2h5bDjC3Dq2aVUYPm?=
 =?us-ascii?Q?CQaf4zzT69zh2xcgSzWcaFswpj/1NqcW3Lc7HCbiqKokzHscxN4kNpkFZYKC?=
 =?us-ascii?Q?AUAsxJE5aHSIMEwqS8lC33olIfbgxX/vF0CbNBTO7Deh+mhQmmXa/P09ziF1?=
 =?us-ascii?Q?H57LaCGxJEb1P/n78+393GvY2kPUl3ucled8Zf1+vnNIe+ta5AfigiEwP3kU?=
 =?us-ascii?Q?KxiRVwQsS3ib5kyLUz6KYSgldNlWO2GcEelruzVQ+fJs4loRHOrODt+PEa3g?=
 =?us-ascii?Q?7Dr+LqYQQYr9Sad7GuEv/CG5pV/R/Dh8MFde5OkPtmK+o3n5z0+f23WB4uMR?=
 =?us-ascii?Q?cgjhTYey8CG9V6+s4RaO/RE6p4B/yeHcy4JfQXTP+/bJlQDTYIgV0RA/9ePR?=
 =?us-ascii?Q?s0uPgVGO+Ar7ziKyAfU3Keh4N4XrC6crTfuycsxngvduVtK7PWASY5E3DiPK?=
 =?us-ascii?Q?M6CJ4TZxh1m5tzhdcbV+2cmNeYudMEXai1Hy+WIeTaEJfiId/4VFdImve2qs?=
 =?us-ascii?Q?/y164159yg/Q6uylLP8pPpg32U40Y7I5bO4PSx3xJ3UCfUn/qkOYhdozXKLY?=
 =?us-ascii?Q?RLBcAYbynpzywP44q4/tKX5zRx3tIBsMjoqnQciileWBTYacujYO3IVWjTxk?=
 =?us-ascii?Q?VfwgkT2t719718z2iMFAELwU6BwEHODpwVb1Va8OZrgmfYLuhim9Jio5ra30?=
 =?us-ascii?Q?jUIpR2pNsMtnSeNBaZKm/z+ngSLYsRyXZOEQ+tBZEEwOVLUFInjWtYkzZA37?=
 =?us-ascii?Q?LLpg0ieO6zPPrvASGIY/1wN9wpFfhHU=3D?=
X-Exchange-RoutingPolicyChecked: 2+G85q1uJXrTib9Hv0gQUZgqnDihwnZXNXlpVEZPPgaJyoha5/Sy6A6SZ/PR8vZxL5YG2fs+9Q/tiX3GNZ1/N8Nyd9QVtR/jc23qWF/GMTOFv8N0oLic6MAl8QUdi1UgAyUJhXVROM3KbSi0E7XtQ+imf+03XYGbtBLQW1SoCN1IMUBGzFg2i1sr/1frL130Aa7Yh3pXcHYkHnUiEkY12mkjPfTfyqJuAw9XQlVwPtfbdXGOxUvWnbiRGOO67LTDyG8PUNp823Uxl+7m3U69W1jHWy5WcOSV/bk4TEp7u1/ciNRvTsTP+BYK/vV7AsAO4AWmv7UdWCI8kezFxjVzbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1c35dd-ac69-414a-eb9b-08df2637f758
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 19:03:12.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzUcnMpkbSf1mH289+BflSY5mU0K2JYBRej65sH/GV7UjDnbYCys45ElhBqMr93hAxfi3cpuhFYLGJJl1HO0obWPcVsoauGx5w41tDpTrb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9684
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 11:46:13AM +0800, Guixin Liu wrote:
> cxl_gpf_port_setup() caches the Port GPF DVSEC offset in the dport
> before programming the phase timeouts, and ignores the return value
> of both update_gpf_port_dvsec() calls: the function always reports
> success.
> 
> A failing config write is therefore not only silent, it is also
> permanent: the timeouts stay at the hardware defaults instead of the
> maximum flush window the kernel is asking for, and the cached offset
> keeps any later endpoint attach from retrying the update.
> 
> Propagate the errors and cache the offset only after both phases are
> programmed, so the next endpoint attach retries the setup.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
