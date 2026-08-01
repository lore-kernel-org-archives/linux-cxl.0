Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ABE79CD;
	Sat,  1 Aug 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785604411; cv=fail; b=tuTzVAbMHr4qZXI5GNfUHDqSesVqTpzp9Lw5MbLsXzuyJFU6eNVBXGJ77wjKG4mnCHdJaDUL9CQ8IyBVfoAYjcNTCXuLDDWlUsMOFD1pBPpaixfn22utmOOe9lfDIt9JwCWEiZI+JnWbS9NKIcU7CctHVO0jSMjezM5w0j3zzJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785604411; c=relaxed/simple;
	bh=u+TClOUnisrnqDbETnHIeggM7wUlyu+A+ki2jv8UvSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fqW/OWRHXGTIM3Ug+SJF28mhZ5MJE3I6Q3KQ7r8lWORcmFELvng9gx+32QKcOFvsaoMoc6/ciGmSVhKF1hh9P+FIaWeCmpQplEMXwfpyeWcx5csrwK5ZEDB//cjbQh5SMwugrTBvaa0i+mrPMPWvtuoUoY1ytWjBijB3mbEJuYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbEirBh2; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbEirBh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785604409; x=1817140409;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u+TClOUnisrnqDbETnHIeggM7wUlyu+A+ki2jv8UvSU=;
  b=mbEirBh2Ag3EO33Tpf9ah3fdA5OjKWfL5HQiR6a8qNWli+dVLcbEl1QC
   VgC2N5gydcK0LjVwoGC0y0nLOkMrAe0LUs4uATbljMqiRho/PgbaY7qts
   NvPJHEEfaHRmUoEaYlOZATzwdCCN6szkYyuo6BQ2zPEaXXRh99ZTfKd0C
   jF11PDEbJ+xk1EVXdmJinVd5s+ee5aHKi4fQvwXOZHaxh7f7g5nqzg72s
   1bkoE56fea10QGg6rf/CAbpBkTsXupReLHkJrh+K9ZuSb6TNxa7trwOmn
   GBzFUkfs8tTHh9gmEf4nhZ0c/DJnY3I325ng9jwSp75yohvRdbnYzRADY
   A==;
X-CSE-ConnectionGUID: SfjrVxkYQo+lpcuMZms3Kw==
X-CSE-MsgGUID: 6ANFkPctQwefdHg7vubY5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="86154842"
X-IronPort-AV: E=Sophos;i="6.25,198,1779174000"; 
   d="scan'208";a="86154842"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 10:13:28 -0700
X-CSE-ConnectionGUID: nLv3wMR8TlyMswy67ykaeg==
X-CSE-MsgGUID: 3xz6sO/gRdSEIT/EWFQRIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,198,1779174000"; 
   d="scan'208";a="265905316"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 10:13:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 1 Aug 2026 10:13:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sat, 1 Aug 2026 10:13:27 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 1 Aug 2026 10:13:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbxqyWFC51pvqCQRn4iTjoNvg9Lv/BsN8weW7XZTb7OVJnDWhGStGN9HVv9k5nxZB/62OV+VMEOF/QuG3Jw15jPdOB6wnknWe3PgAtosmvWzBFqXW8aG2zzO3VAe5KYJ9mJHdtpbrsh8lOvgO0LuNUZacJW4gDB9/77zGwpR9eb+zizMHjjm2H5VArFwdC5gUNTQvQqh3Sa09cEj742I2pGjzn/vtAegayaTOSFbUZIXEWfYLwx+X81WEN3HwyC19MUBIGcpdVaQbYglBIDDrr0pLVyD4Eat9zJbFXMWJcMaAVuVvdj6vl/v6GA34701A0MZOsmBTqblmZruMsNTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqz4Z9MHbtrIStaj14LvzUzTltwvOcyb0qvB79uZq00=;
 b=XGUAyKOnlC5CoDxcuSfGY4MfUcdwAigGvlhb6ocGCBnZg2khokPvp4NfpicmP9ytTLKg7IvBM+JzdhTYvrn2SwcZC9BGVYDTAXuTYfxFdrciS768Y/lIpGetb2OLAvHeUuUoCDmMmLHeCMSVhaLFMm+qDeT/Ixd/fOT3MG53dsC1fJc2Wu+jb39FmM8farIm0dJgMNyAxrc4o1gRHn2yXgBCnkm1+Cnwm0M1TY1bRlI5SfaBr9b87XGI2NHMTsQDjYW0cJhlz98MZ07IBYNPy/Zhsy64w6SQhdp8A2HIVwA+bnx9JzkJjLCC3VQ7SBE90Zk/Z0hTYNU3D075Uy7Mwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 17:13:23 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.012; Sat, 1 Aug 2026
 17:13:23 +0000
Date: Sat, 1 Aug 2026 10:13:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>, Gregory Price
	<gourry@gourry.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: use %pe to print error pointers
Message-ID: <am4pLLTXXZLMaHw3@aschofie-mobl2.lan>
References: <20260801101217.12778-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260801101217.12778-1-shaikhkamal2012@gmail.com>
X-ClientProxiedBy: BY1P220CA0041.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: f51ddbc5-3e05-4013-8bcb-08deeff03171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: fCkCIWgj3Bm6b7UMnanav+Z0JdknhHGWtXCftd1C1duqmznkQLigYjxphmTrB1eiYqbwO/YLJenB8+uvxm7Bl3UUIegbzyLMQ3sXaF768szEtJ+JCO28gQWlsXH5k0TI78TWXko+yyaWZKFpqwfS8zZ391Lgak/IPWnIU8pT3bM0HixSbMandzq/n7tXTsdKLQFLPXML7tQ2UOtsehkQPgipZWS7fsnDtkt16NTDfcnzoicp9H+e8NjW5JG9zLE+5pc56MICzh790fvYgIWjA0ovq51dd6phwPb2ywq+0JQMC/2jGLttVMWauwlWrGqGspwAZ3n4QjFx4QJi0xAQZXaZN7BfO0T2fBOFhATO0MTxOdKNWvx0tqmInYu2NM52CohF0iS2zbw01rRhTc7Qrh+PdAYtoPdvv7Hki5mSk4yN0fn2QYv06OzkDziymZ+JJe1CaOtSQ0qQo61a3sPLPydY4FzOoszDRp/enWGX3HP2IfjSECFiaTLsLxhqsMzLuxBJOlwrTWExZIlc9U4j9F6gpO7wpd/60vTpaKxd1S8VWLGZKRahqd+sRzd3Xe4/hmlTyxc2RbVRVTy17M7U1JLuUQPbsWMREHslv699iSPFm7tGk86isdZb/R7ex1rIPZjX7aDMt4VhRgVuU+vW31vw3jKlOR5fY53pmB1YHg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OP6m7PplwuhG8BkucjCMxAHPK01YWvjhbOagU7RO1jmE+v3ACSSEXOBtN/Lt?=
 =?us-ascii?Q?fAKJOSyn4nOWXBmkrUgA7qo6hY07GLlAzu6oNNjA6v+c7A0YvS+U2xxeA/ti?=
 =?us-ascii?Q?CRgsFnVIwORIxIUt0En21t84LPwdf0i3+bRBoFk3PhI9gOnq/VwD5jaTDNh1?=
 =?us-ascii?Q?gPcbho76zXRg8sNSRomUHj1MlpecJIlRH4bc/ZghdUQTDilKTvOKB1gyOnAE?=
 =?us-ascii?Q?ZeK0JdQPv09pFTsc08mXUzRryQ/zJkLT6OYdHqwitOaWAIJpfI63wNfqg4vt?=
 =?us-ascii?Q?lrLMQFsfQV7HDa/zHNuIdG3tzG87mWI1c7LB7psuaKyO14cMQGA22akzpt2p?=
 =?us-ascii?Q?7wX/Xi9cqPpodWPqAfelrvFxXly372b+1dKaaQl7YCGqhPzftAxtsV5XVu+F?=
 =?us-ascii?Q?MwMEqBPtpZBZ3y7x5+4V7a/Qun976z3bp0JFAw1eI6JA45+hM7GnUetfYqoD?=
 =?us-ascii?Q?LgZILXDw8qTldMz0SjkRNpVB7rqLAVX0ZZYN5ka19aHx4SlGy1F0loleDqRA?=
 =?us-ascii?Q?STFZAdN21sTkswX0itth0LS5h/iK6NW190/5tcSllJOgkk11PZY+hK23B7he?=
 =?us-ascii?Q?irfyRYDsqz7h1EHWeN9thwspIm941zq1AhmDyWn1vSDYq+6snqnERgzCe2s5?=
 =?us-ascii?Q?WchXlEXrjnG6gRES8tSw3YvPK51cRu2sLFie+VcM3MuH7e9nqtPfA4Mcgxg4?=
 =?us-ascii?Q?Vsgzj5gLBc5z1h4QapeWG+onhm5A2oWDjUWrreRh9F0c8hpOsS5+cYKTSFPe?=
 =?us-ascii?Q?Cv2FxjBzUiFcFDq785XgpCMc+xKRMHPQ1aeYaaRt1peBokd02LOy8JhFgnJA?=
 =?us-ascii?Q?/lhxri63aCReM6qI2vQO1CENpP+uraXNtO61fhbjzqo9wZjTIt1G963dRyzM?=
 =?us-ascii?Q?KuRWRoP3XILgECp6PYUnUU8n0L8krjCR1diElVCovgKI6AQGdPn3w73bUwVQ?=
 =?us-ascii?Q?jtJucvQyRQWIsbVQKmEYkumOu8U9lNqIFcx40QMmXDoJScjprlDYXzV4ACI/?=
 =?us-ascii?Q?MYCdTOxuJAszg3QrQfJ4mvJG5pGlqrucKjJIxuHiN1ItNPp510hOmxkWZdOJ?=
 =?us-ascii?Q?iCbk/koyjhvmI52XGuNI0hfAVldZrdXDErAgaSkn1q+zkHWtLvOy/iLvVBjP?=
 =?us-ascii?Q?Uyyv/cuULZ1e6Y5FmPwWtAlF1LOOTjsP/e9KRUXsPTCLx+kaGHqT9vszMKDB?=
 =?us-ascii?Q?af8Da7MMZxVTD+aSaILALrhJtTkRWrlcfrFw997v7lscHgXtD2r9j4Kf8jog?=
 =?us-ascii?Q?t8K6hMsjYvNIRqF9mGqChnOaIy4xKRsfxLoTOVmLlCT8KUMO6srqD1GJgzn7?=
 =?us-ascii?Q?zZF03HGAuc4tlkWIftJqGFOe71iRRoKLpB+R0QmrBm8SXb2oX9wNd+asjjey?=
 =?us-ascii?Q?2EVaPS7pxhcCBtoT7atUhjrjJsEKFfCTfebaQbpIZuhm1KQtZU90/hdpGZy+?=
 =?us-ascii?Q?EGJl0DHBq/dKIsztsJpn0ihTlDtpMjAYllTJRImNOXr9knGiJp4SkCeMudwk?=
 =?us-ascii?Q?ke6JHJYroMrlTne/Oiim6c3W2EInSYHr5wCiEK9Kh7SkwD5D1H3G49+L6be/?=
 =?us-ascii?Q?U2REoCV+BHiwkH/aeuFoz8brW1r9Ch7b7qlXjvgjmondHHIMT6dyLQThsOJ+?=
 =?us-ascii?Q?LychUjLvV2m1TA32VCMTTUIU3TLJahp7YY0+YmnVMNj7CpBqaj7/YXqJhqw1?=
 =?us-ascii?Q?oRB4IAG7ykLU0zNhagYnOqjH3aq2GZHqfby2WirVhmto0j6PXf1xzoujkULQ?=
 =?us-ascii?Q?EiGs+ngFmutTEBq2/BfiOktUUH+8Q+M=3D?=
X-Exchange-RoutingPolicyChecked: UicdJM9FtL1F/lWdNQaIdsPAOPQdwh0tG20AbKeH63AZZKnEwebHLvgEa5MtwqFe+yVBvdyv37T5ADVKpThALlc+H30/6ICfaRheE1r4wakpllA9tnZoVv5Ehzq1pN1/WY/t0XAP0YYtkpOQUv86ydU+sQmjxWiTDZKphJAp0twWM7Ut/CyBCUsevSsv9uc5y3YravPAH/6WJrgJUZHY7XM7qA/1pIlVl8YVxq+fWWNw/Gju+JNl2T4A8rCE5H5pJIoDE+qeqjHalrxsmvcRU15XxruGoT8PTlDphn8CC5trzm9e73tLMsLcRMKkMeslZjjX64ijNfKaPFWI1cbDAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f51ddbc5-3e05-4013-8bcb-08deeff03171
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 17:13:23.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IULRLu8htyrF8/oXG1vd39Xv9RgyGRJxODfKFmKx7KUkxuvWN2CzlVHOzG4hbjfktXjLcZrWuGVbBykuySi7pINzx+dyoQ3RHxS9Lu+2Pqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
X-OriginatorOrg: intel.com

On Sat, Aug 01, 2026 at 03:42:17PM +0530, Shaikh Kamaluddin wrote:
> Make the code printing pointer error values simpler and address the
> coccinelle warnings:
> 
>   drivers/cxl/core/port.c:939:3-10: WARNING: Consider using %pe to print PTR_ERR()
>   drivers/cxl/core/port.c:1275:25-32: WARNING: Consider using %pe to print PTR_ERR()
>   drivers/cxl/core/port.c:1309:25-32: WARNING: Consider using %pe to print PTR_ERR()
>   drivers/cxl/core/region.c:686:3-10: WARNING: Consider using %pe to print PTR_ERR()
>   drivers/cxl/core/region.c:3778:13-20: WARNING: Consider using %pe to print PTR_ERR()
> 
> The %pe specifier prints the error symbolically, so a failed dport
> addition reports -EBUSY rather than -16, which is easier to follow
> when tracing port and region setup with dynamic debug enabled.
> 
> The PTR_ERR() uses in return statements are left unchanged.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> ---
> Tested with cxl config build in x86 Architecture
^  Should this say "Compile tested only with cxl ..."


Hi Shaikh,

Thanks for the patch. The code changes look perfect.

I'd like you to spin a v2 of this for the commit message and log
only. No code changes.

Commit message: follow CXL subject line format, start w uppercase.
ie: "cxl: Use %pe to print error pointers"

Commit log: Can this be reordered so that the code improvement is
the reason for the patch and coccinelle is only the tool that found
the sites?  We don't change code to address coccinelle warnings, we
use coccinelle to find code worth improving.

Please take a look at and follow the model in this commit for your v2:
c69ca4e992e3 ("mm/zswap: use %pe to print error pointers")

It would also be useful for the commit log to note that drivers/cxl
was completely scanned and that these are the only conversion candidates.
That documents the cleanup as complete and saves the next person from
wondering whether additional sites remain.

-- Alison

snip
