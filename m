Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6072DE6E2
	for <linux-cxl@vger.kernel.org>; Wed,  2 Jul 2025 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489606; cv=fail; b=tfeYK/CxIF02imhL1G3IaQ2vSJUtDgxDkhqg/PLX4YkXL3CWRTy6E9cqqymkwzVk0UbIdwVI6qbYhJ5/xlXXlwXFL8363CeR0w25ko8WIU8P7+BaVoYDBfhAWRbLW3qy9Smz8ScuiKqpBDLRwBiLvEMf86JRZdCf7iInEAf0Hns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489606; c=relaxed/simple;
	bh=uuKXZ0pYuLgae4XVTH7uTiMazX7UrOeK07871sBqK5M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HlQ3CgJ/7gkPMn0yB+roSpmVxp+vKtA5UxMc7pQ3kD543E81rK3sHEutXDkupAgLEtVsrjJxKyJDzsW1hNoUC9QfaFXpFDLvoxqeneS6QdhAMTgZThGFWrhlDFEPTzi9B67dO7X5fSqlMVjpozd11mfYpQw1MP39kXukq2U3M3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=in4ZoIWJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="in4ZoIWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751489604; x=1783025604;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uuKXZ0pYuLgae4XVTH7uTiMazX7UrOeK07871sBqK5M=;
  b=in4ZoIWJ7M/2X6E8+M+161yzqGRhOJ9RTwbyJU/pa8cbh3Y/ptmng1Ah
   g235LNKtT7jtwZ8pJgrQVt0w2bF+X9T+1rQp5/UO11oat5gAPeZ/Rr+6I
   9XCZmEZm690q+Y4VlJq45eLomHwUYbikYtZTX117pvdjD7G9dpaVMkz6V
   W+CuA5sTkWQkCK6TH9Hud3tFeDeXJKbyigpRqPcRZd4AkvGswx6Mr3r4n
   9yhhus9/8rtJNl3Fge+Fojlwb+77YlByjyzfHG43t0fRrq1z1gTa+aQjE
   Gn9Ju2plLOTSelRi0t8fmgbTMQ6eDKg+ljMNZcUWNbaO1apu9lnM8BbX/
   Q==;
X-CSE-ConnectionGUID: 5YnlxRPzQdqs/RAl05VJvw==
X-CSE-MsgGUID: Rmms/FA/QKG3ds95fNyn/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57612890"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="57612890"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 13:53:23 -0700
X-CSE-ConnectionGUID: ARFEOPAtS5WmlZoRJVttMA==
X-CSE-MsgGUID: Ze1mQpzQT+apvkm0Ti4x8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="154539701"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 13:53:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 13:53:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 13:53:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.76) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 13:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAeIyiHroaw8HMA+3g+9xrJq1heK78Y5QHCtz+l5itfVq3eF61dSAfgBm9PgbkXOUyA15iK2O7HEJtcHbqHkFG9G8zdG2HFnWzc+R7AER0uzEnr1BnfK1E79Sqk11Uc29fRGMdjzXG7VLMSco1pWdSjIdZiAihaEQcTZxiDlk1Deq3qVuc5pQhg6Rj+JrbhUukXiDLpP68MwJxI/NMztKMe7IjIx7oa+pbNT2UVNkw4pMXtT37cGEVH2+Usk08UGLRM/AXv/nntUSBLwmeJnF647T/dahlU0s3+dz+NKPPUPx+Jwj7HaHrQmWVj54rZ2ZeCCuwZ0WMixi29nGfiFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2p2wnr0ByU9rspOa4SfNoRKDXEdkI6Q4RfcrW+Cj7Q=;
 b=U1Tdai6LRyRSHueSiNTr05jLBfH/AVbxE8hjxgCcOeGAudJ4hK86nKGIoCOcxxa+P4dSatOplqeBpfvcNBpxUtAXiSjzpF9pAaWPBFNLReX8RIoTurGiG7y6MCkFMRebOkf0NAybM5Q4x3mt18QfPqwRZ/aiIXHuw7lZUtG6eJjlsyHxGxPtricMLSHlfJefBmhPe+QIeyoZ5QMebVPIrkcBcQdMOfKh74J2d8hkNfVg7B7qfyjrf1jOzJ2Cz2b0OYYx37lhjWjNG1emPWAYeyraCs3009waGhK24XR7qk06L4mGEWwzDJGTSptwXM5GP+4/3qlv4v4hDRBuNET2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB8476.namprd11.prod.outlook.com (2603:10b6:806:3af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 20:53:19 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 2 Jul 2025
 20:53:19 +0000
Date: Wed, 2 Jul 2025 13:53:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] cxl: Remove core/acpi.c and cxl core dependency on
 ACPI
Message-ID: <aGWcNpaRup9MkFm7@aschofie-mobl2.lan>
References: <20250610172938.139428-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250610172938.139428-1-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: cadca46f-a5b3-4d6a-aa9f-08ddb9aa792f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mCU2TYvoFa6m8n9tTDrHmbVjAxX4GHACoEgyVUvUoGPwabRAwtuuKpa5oz83?=
 =?us-ascii?Q?rAcjYz6CeI9c1UgcpcBeFUUNqhdm6vYwiIdFxVjVL7A2RXrD22T6+CjNXj6J?=
 =?us-ascii?Q?CQWijIpZe6Wg48RSLvGXm0SgtEItyLGO0Hdv8/VcIIEMSzQC2yFVlrjRUMaQ?=
 =?us-ascii?Q?ACYFZQC+GBVuJFa3sW5lEWw6u6xWm2//QRkeTjvCT4NvokTF65SmcnG1glhT?=
 =?us-ascii?Q?iW2L5vDjzX8ZDOg8fchG9Qf07mI7ru7I4oVEgNdSBc+8DqCMFjB0SKXg2NwK?=
 =?us-ascii?Q?PbgI2GMo9NBLUz4ta/Py7ZaTaZQW3rwwBhEJqN2k6Rd1XOjD2dIHZJv9r9QB?=
 =?us-ascii?Q?Lf6YMjFsqTap8LzboLUzavzNMuFbROojIuUtBpW+n/0ktK1QlAhepAGPKjgv?=
 =?us-ascii?Q?FaSaQtSgEKNh7WLviYfA+55YDhnWQ0Qq6Cgn7Johy5qjDdwKPLfeBfaNeLSE?=
 =?us-ascii?Q?0xlLGs+kUrDmeBb/SNPoMnS9FfxeH4n0sKbpeHWK5oms+Gdeo7wPOvUjyvL/?=
 =?us-ascii?Q?OxkF5u96l6dm0qYKxRYuHtGy3or/p+3Ci0wheiPT3Y1gBVklvSi0XHK18wB+?=
 =?us-ascii?Q?B34L2HeoF+1Xt4gRkkOdaGtpMuEvqt9E/821KvNpR70cyrRZ3XxCruJ/MHd2?=
 =?us-ascii?Q?TN2gtxlWX9RTR2v6XHFlG6d0VmyBRI7ucIZ2FVj1dVWXZ8zclUkHM31U93Kv?=
 =?us-ascii?Q?JBx332BLLP2qyVyvGEgC7J/LlyxoDOtuncRavlVscUoMdetDlP0B/Zm2xCj/?=
 =?us-ascii?Q?p6RRvoD3qjDPleJRzExxli2Wk2wFHc5mHr0GJ0FK2mJnKJbbN2Z+L4rDlcz+?=
 =?us-ascii?Q?9Orh919OLyikOoGW8xpBJXX28+zFbl2stiayFv1SHJI5Ssg3AnCqWCV7SZce?=
 =?us-ascii?Q?XdjPqOEc04WYq7Edr4edWG5CtNqebIQGx+8rq5kn87daOYE/g6AqUs453adF?=
 =?us-ascii?Q?Y9YZWzNjbOgPXc17w0cTv25dKjXMmZxuSZ3XFuxIE8+6j8+mR6PJfMBuMKqy?=
 =?us-ascii?Q?eDm9XrngQBWC2KMn0AY26SybEvFEWm2kPO1zRDpREVSVL9w+m4GO69u8EpFP?=
 =?us-ascii?Q?Hm9GTGGk4KMqAd0CXiNsQ3WPU783esGDUrEuOQ60IwFxYm5SFP1roYZ5AmbK?=
 =?us-ascii?Q?fTV8hYV+2s/NXeaQ/QEuLaqd192jrpg7Oij1CfIKeP+c4hHuliR1649Sjlek?=
 =?us-ascii?Q?iy7UpvkTW+N4nO9Yhdv5Xsaxa7G0LdoqywAtFnMqG8aj8zTWxxFNLgnpwTg0?=
 =?us-ascii?Q?TJCnDZ7hnNzAdpoXIK37LHMEiMXx9jtIbWBXVAJ0MOCDVYFDYNoIS5lhb8VZ?=
 =?us-ascii?Q?N0v+OwtI2mOK1/h7Yed0EXxBjzy79o+8Y33Zz2bEtngSXn3zZH9v8f5aods8?=
 =?us-ascii?Q?WBYaNUbsZzM/SZUXAQoS8PS05FjtPp+SY7zpKxkFasZvXG9TjwDG0FifWz9m?=
 =?us-ascii?Q?1/9aSVIruIo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MsOqJropDhT9yypdt/uiqNeHccIAjjdRX3lqNfvNgaMt8ObIUQVyDqSZ/aBy?=
 =?us-ascii?Q?phmrypmvkFB71fO4r5X60WNbLvZT920BW/4mFkr7KMSHsodx6YpUjBydaPMg?=
 =?us-ascii?Q?s9R07z0/LIta3TgjfD33ZnrCGCtDzPh1Iy/39PRBgPk5LK2seYj0A6OqscE5?=
 =?us-ascii?Q?R4E4w+NmfGuQ6MHYhyLhCLVQ2r7zwDCLNJx48o0156xDKsazTcZlM482aI4i?=
 =?us-ascii?Q?o00Aa0iameAfNSNBVlM4qQKx1CSxEI6jMcBzXr7spnvpewY/7H8kucDX3NuP?=
 =?us-ascii?Q?M6ZpCdATECD6wEKAN8jfsbF+0iySj7iv6z4xX5qYVR27CNe9RA2XZ8cqyKgr?=
 =?us-ascii?Q?yD94uwXA08AM5t6ZRtNv7ydxK3Y2Om4v/NzDatqPD0o0P02qSeHqA3sduyaN?=
 =?us-ascii?Q?tlVB6J8TKmCDomC3dLgg9YUeneiS5nDYrgyqgHvxWhup1wbNDBjnsDAikqq2?=
 =?us-ascii?Q?XAFRCw3zRN5LjVrLznsbdrXCpeNuveHD96PZYeUkpWvTlc/dmEdNbAhN5I1X?=
 =?us-ascii?Q?uCJauiS/R6Wtv+bPU7bypwAOPjpBoBEbIGhUdF2YLZq3YntMJ26llt4E3c7b?=
 =?us-ascii?Q?UUQSLdWmM4Sx5uBnImv0WhDz2lbdbtZjKIF+9ocpFbdq9PvMqT/cpYT/rdE2?=
 =?us-ascii?Q?5t/hfIueqJTDLy+WaBOFRgeBnM92hWXp0MQz7/ntuETsdPFGuFKmmeB9uQZU?=
 =?us-ascii?Q?fqymE+RwLdz3hx+FVu212JaE+Z9X3FH4RlXJZDsQobiEaNPwmX20S2tKhpPR?=
 =?us-ascii?Q?4QJO657lwz/749DhHIwYimr3wxL5xJ4Q45gZEMuvm3+4HtYvuEgLZSNRvN8h?=
 =?us-ascii?Q?1w2CQvhb54yDB9Mfu7xeXkxCoGVc5cUCUdL6n8AUvuo4GSYMm0RyexCVobGE?=
 =?us-ascii?Q?avAzGuj1tzs9Y10IIA0xCNpJm+OlS9hAVAg/U+VGVpO4pkynY/BVxbYkiDdq?=
 =?us-ascii?Q?JXI1RagCMu6TtWbwLzlW3VeGkvPPIWqKsX/YDaATKStNjEtEkEc6sImS6UHk?=
 =?us-ascii?Q?v/KxW4BZSe8WAHWV3bq55Aga/sK1SUzut3sI1sp1rNQuiJRo/jQVNQgVL1YT?=
 =?us-ascii?Q?0c/Xe8y7I5AIUlgJufu2+0D9FpcSbwp8UmCXzukgcxYcVUuOZgIdWijOR0f9?=
 =?us-ascii?Q?N/DCrRe2kMnUUBIQTsuci05xNaxDbCFkJjYsgVNSbNhexR5jkBP5aqyapgNM?=
 =?us-ascii?Q?MxocRxhBldi9WMmRQS+8BfRqLKlcyAIVEWsJ2rhLTt/+OQL0JBBOi//e8Di6?=
 =?us-ascii?Q?62ODdyU8ZaSLeJRy4LepAuZ3FXcmEkthsFPwAtd7XoLBP1SyfZR/WEsnk1kg?=
 =?us-ascii?Q?hyZxQRxDjaSW6UJOtWkFM7/eWOFttrAPRGC86VYeyQ/82Ped/4DAEVTh1a5n?=
 =?us-ascii?Q?b9rhyHLNgu+SPuTAmIOMZd85KjBL0c8/97273Y90DFbF9ENgjB8zipfyn5Kh?=
 =?us-ascii?Q?3mAdqF2BFqHV0vPWNFu/Sp3rCApGo6VZGfVcm0XEC4iGbpi9BHA4cC/3Txlx?=
 =?us-ascii?Q?Qw7PX1mSVR3p81LK9+U8ePv3K7s59W4tTMC8xljtZK7TqdIALHNEQ8X22yGx?=
 =?us-ascii?Q?3NTZpuLpZJdi9cMcZyPySaV2IJji4LltccnDTLG8Vp56w7iSmVeoPq3l21yg?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cadca46f-a5b3-4d6a-aa9f-08ddb9aa792f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 20:53:18.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUKX3rOZYvxLXd0hiszLtsEjGL4LoFESyHd9CR+Zo8JuHNDXbfa5xyHlR5HEluxlqrB2v8mD1TczI4jCkGCxN4PBynbrRYotl/CeImjQI8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8476
X-OriginatorOrg: intel.com

On Tue, Jun 10, 2025 at 10:29:38AM -0700, Dave Jiang wrote:
> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> cxl_core when adding the extended linear cache support. Add a callback
> in the cxl_root_decoder to retrieve the extended linear cache size from
> ACPI via the cxl_acpi driver.

I see the introduction of struct cxl_rd_ops and am wondering why
the other existing root decoder callback is not added to that
new grouping...
* @hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address

Seems it can join that _ops group with some updates at the call site.
BTW - another root decoder callback is in the works for the inverse
spa_to_hpa, so that'll join your ops group too.

If you don't want to do that now, or it's not a fit, you can add:
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Otherwise, I'll review and tag a v4.

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Remove commit log paragraph on adding extra dev parameter. (Jonathan)
> - Add device ref put. (Jonathan)
> - Adjust var declaration. (Jonathan)
> - Move callback assignment to same group. (Jonathan)
> ---
>  drivers/cxl/acpi.c            | 13 +++++++++++-
>  drivers/cxl/core/Makefile     |  1 -
>  drivers/cxl/core/acpi.c       | 11 ----------
>  drivers/cxl/core/core.h       |  2 --
>  drivers/cxl/core/port.c       |  5 ++++-
>  drivers/cxl/core/region.c     |  5 ++++-
>  drivers/cxl/cxl.h             | 10 ++++++++-
>  tools/testing/cxl/Kbuild      |  2 +-
>  tools/testing/cxl/test/cxl.c  | 40 +++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/mock.c | 19 +++++++++++++++++
>  tools/testing/cxl/test/mock.h |  3 +++
>  11 files changed, 92 insertions(+), 19 deletions(-)
>  delete mode 100644 drivers/cxl/core/acpi.c
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index a1a99ec3f12c..48478bc406ee 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -335,6 +335,17 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
>  	return rc;
>  }
>  
> +static int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> +						   int nid,
> +						   resource_size_t *size)
> +{
> +	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> +}
> +
> +static const struct cxl_rd_ops acpi_rd_ops = {
> +	.get_extended_linear_cache_size = cxl_acpi_get_extended_linear_cache_size,
> +};
> +
>  DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
>  	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>  DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
> @@ -373,7 +384,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  		return rc;
>  
>  	struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
> -		cxl_root_decoder_alloc(root_port, ways);
> +		cxl_root_decoder_alloc(root_port, ways, &acpi_rd_ops);
>  
>  	if (IS_ERR(cxlrd))
>  		return PTR_ERR(cxlrd);
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..5ad8fef210b5 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -15,7 +15,6 @@ cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-y += ras.o
> -cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
> deleted file mode 100644
> index f13b4dae6ac5..000000000000
> --- a/drivers/cxl/core/acpi.c
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> -#include <linux/acpi.h>
> -#include "cxl.h"
> -#include "core.h"
> -
> -int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> -					    int nid, resource_size_t *size)
> -{
> -	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> -}
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..9462aea9ce9d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -120,8 +120,6 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> -int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> -					    int nid, resource_size_t *size);
>  
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..cbb9c5a3c309 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1793,6 +1793,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
>   * cxl_root_decoder_alloc - Allocate a root level decoder
>   * @port: owning CXL root of this decoder
>   * @nr_targets: static number of downstream targets
> + * @ops: root decoder callback operations
>   *
>   * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
>   * 'CXL root' decoder is one that decodes from a top-level / static platform
> @@ -1800,7 +1801,8 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
>   * topology.
>   */
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> -						unsigned int nr_targets)
> +						unsigned int nr_targets,
> +						const struct cxl_rd_ops *ops)
>  {
>  	struct cxl_root_decoder *cxlrd;
>  	struct cxl_switch_decoder *cxlsd;
> @@ -1839,6 +1841,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  
>  	atomic_set(&cxlrd->region_id, rc);
>  	cxlrd->qos_class = CXL_QOS_CLASS_INVALID;
> +	cxlrd->ops = ops;
>  	return cxlrd;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, "CXL");
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..0a5effbc0529 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3287,7 +3287,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  	resource_size_t cache_size, start;
>  	int rc;
>  
> -	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> +	if (!cxlrd->ops || !cxlrd->ops->get_extended_linear_cache_size)
> +		return -EOPNOTSUPP;
> +
> +	rc = cxlrd->ops->get_extended_linear_cache_size(res, nid, &cache_size);
>  	if (rc)
>  		return rc;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..9a17e8beca7a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -420,6 +420,11 @@ struct cxl_switch_decoder {
>  struct cxl_root_decoder;
>  typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
>  
> +struct cxl_rd_ops {
> +	int (*get_extended_linear_cache_size)(struct resource *backing_res,
> +					      int nid, resource_size_t *size);
> +};
> +
>  /**
>   * struct cxl_root_decoder - Static platform CXL address decoder
>   * @res: host / parent resource for region allocations
> @@ -428,6 +433,7 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
>   * @platform_data: platform specific configuration data
>   * @range_lock: sync region autodiscovery by address range
>   * @qos_class: QoS performance class cookie
> + * @ops: root decoder specific operations
>   * @cxlsd: base cxl switch decoder
>   */
>  struct cxl_root_decoder {
> @@ -437,6 +443,7 @@ struct cxl_root_decoder {
>  	void *platform_data;
>  	struct mutex range_lock;
>  	int qos_class;
> +	const struct cxl_rd_ops *ops;
>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> @@ -775,7 +782,8 @@ bool is_root_decoder(struct device *dev);
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> -						unsigned int nr_targets);
> +						unsigned int nr_targets,
> +						const struct cxl_rd_ops *ops);
>  struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>  						    unsigned int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 31a2d73c963f..c4fd68db41ba 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -15,6 +15,7 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
>  ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
> +ldflags-y += --wrap=hmat_get_extended_linear_cache_size
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> @@ -62,7 +63,6 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>  cxl_core-y += $(CXL_CORE_SRC)/ras.o
> -cxl_core-y += $(CXL_CORE_SRC)/acpi.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8a5815ca870d..c0eb95632062 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -470,6 +470,44 @@ struct cxl_cedt_context {
>  	struct device *dev;
>  };
>  
> +static int match_root_decoder_by_range(struct device *dev, const void *data)
> +{
> +	struct cxl_root_decoder *cxlrd;
> +	const struct range *r2 = data;
> +	const struct range *r1;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	return range_contains(r1, r2);
> +}
> +
> +static int mock_hmat_get_extended_linear_cache_size(struct resource *backing_res,
> +						    int nid, resource_size_t *size)
> +{
> +	struct range backing_range = {
> +		.start = backing_res->start,
> +		.end = backing_res->end,
> +	};
> +	struct cxl_decoder *cxld;
> +	struct cxl_port *port;
> +
> +	struct device *dev __free(put_device) =
> +		bus_find_device(&cxl_bus_type, NULL, &backing_range,
> +				match_root_decoder_by_range);
> +	if (!dev)
> +		return -ENODEV;
> +
> +	cxld = to_cxl_decoder(dev);
> +	port = to_cxl_port(cxld->dev.parent);
> +	if (is_mock_dev(port->uport_dev))
> +		return -EOPNOTSUPP;
> +
> +	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> +}
> +
>  static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
>  				      acpi_tbl_entry_handler_arg handler_arg,
>  				      void *arg)
> @@ -1039,6 +1077,8 @@ static struct cxl_mock_ops cxl_mock_ops = {
>  	.devm_cxl_add_passthrough_decoder = mock_cxl_add_passthrough_decoder,
>  	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
>  	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
> +	.hmat_get_extended_linear_cache_size =
> +		mock_hmat_get_extended_linear_cache_size,
>  	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
>  };
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 1989ae020df3..ec8fc4a44073 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -78,6 +78,25 @@ int __wrap_acpi_table_parse_cedt(enum acpi_cedt_type id,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_acpi_table_parse_cedt, "ACPI");
>  
> +int __wrap_hmat_get_extended_linear_cache_size(struct resource *res,
> +					       int nid,
> +					       resource_size_t *size)
> +{
> +	int index;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +	int rc;
> +
> +	if (ops)
> +		rc = ops->hmat_get_extended_linear_cache_size(res, nid, size);
> +	else
> +		rc = hmat_get_extended_linear_cache_size(res, nid, size);
> +
> +	put_cxl_mock_ops(index);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_hmat_get_extended_linear_cache_size, "CXL");
> +
>  acpi_status __wrap_acpi_evaluate_integer(acpi_handle handle,
>  					 acpi_string pathname,
>  					 struct acpi_object_list *arguments,
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index d1b0271d2822..469a270ee245 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -26,6 +26,9 @@ struct cxl_mock_ops {
>  	int (*devm_cxl_enumerate_decoders)(
>  		struct cxl_hdm *hdm, struct cxl_endpoint_dvsec_info *info);
>  	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
> +	int (*hmat_get_extended_linear_cache_size)(struct resource *backing_res,
> +						   int nid,
> +						   resource_size_t *size);
>  };
>  
>  void register_cxl_mock_ops(struct cxl_mock_ops *ops);
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> -- 
> 2.49.0
> 
