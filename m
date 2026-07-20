Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA839CCEC;
	Mon, 20 Jul 2026 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564978; cv=fail; b=OkAdg6ZVonG+xANFN0A5tdvqwo6qeeBdtBrGnxM71qjEnBRQ5PInOGBUfZq4YJxLGkCugRP3sqEloghrX31nKUqNK6pI3eu8nosdcPQAML9TYmbYSmDRpVnUimF8vgPEG7zyJ0nXWjye2OabwOChr8ABp8WjDiFywusG8vXg79M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564978; c=relaxed/simple;
	bh=04pOvS6iTjI1M0TN3Z0SFlCVlPIZCqHdmMU0NtS5s2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJqLIZqNJXIx2vsZw9GO8Y+0jG1CVRtXnY7fU6pxfjcGYWXRtQSGAKfw4EAKFYNaC1jYKHpPkXYPXfuoOKOmILfs86ISCP4N+MTrf1d8bBNJI1eNJILj5IYnHnY9Eqqups1av/xdrLCdLXoJAf0cdx5zsoyutcen2FAYP7jK0hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCPGmasZ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCPGmasZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564978; x=1816100978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=04pOvS6iTjI1M0TN3Z0SFlCVlPIZCqHdmMU0NtS5s2U=;
  b=HCPGmasZOVVr62f7/wl3BunhBac9oKFdEAG+zuPtQQ98ZUvupRZHvP6S
   MIU1FivoZwfbLSzoqx+omNhhgZQaC21p6lugck53XNW4ldZ5LHBadbeZp
   xDFWto7cvLyY7lZZyQ8KI9mhJqlsFO1br86Q/CTB7qHXxDN0MsKBuxmtR
   pf/+4DT30pNqpyuuK5bWKsizLuWxbswEVOV5IOB+CXMiAkXuNWehKPS7Q
   s96wRy77upLHapCbzfW/YATEmpO2zx3dtdlywWtfKF4VYaj93tvWTxSAF
   3q87TdiuxVKFkULB91nvG0w4pq75iuo3ou5VMVet96mu0tPqWOP2VCyUy
   w==;
X-CSE-ConnectionGUID: CKmyK2qDR6eN4i06b6CijQ==
X-CSE-MsgGUID: I492At7FTnWL55ULNdrwtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="110703041"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="110703041"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:29:37 -0700
X-CSE-ConnectionGUID: eel0jTgYTjSKaWnD9dS36g==
X-CSE-MsgGUID: 2Uo9IBIcTKS73RRRYiyD1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254092066"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:29:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:29:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:29:34 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:29:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B59g0vVziQZuMCHwjeNYoS1/xgjtNUar/0+FXECNdOCRaadMtptYWfAZVbQaNvE6L5eJOeZaqeQgxfJiEKyfNaLor8d7//o3sybV6wfD2GFaaWcIunU1dbLnp79sSlqkXxFFkyKmxyczemrL0/FAt2NUcE1Pj1omdrP6vKG0c3ocSraIDO1h48A699JpT1fuLsKNAIgIDyk+GvNfCuOEr+Oya69ZcXQahEx/3yRr35jJ8TJ57szEm3peQsGXuqhU9a0VWhDaVbvXQhW05E3sqoZ1Auu6qb0zNrqHPRpVdgA5KqkPOGl27XVUHquKR0/CZcGTxpHUIMwoFLa/tRwjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nStEuFi7Kva6E0Pv28GLTFfRLelSZkEkOL90/8Y0vfw=;
 b=I+JAydKrBygSHAXhLgawib2ktv4qiqKeVbjszM17O7OcfnqzFhA6udotfKFACH94RXT5DqI0u8KuWj9TW0ZtT/NCUVDoFCkihisBXTs8zYyzPRsFZiqdlk79wWiYQsbOFp7pmKIJ6/WGv+J97GG1QMJdo8G71sN2wOftMK+8hRmNSCr+N1GTvYSgWyqWxG78Lkc+FkFYkC6U777CivwaZQYJjNm49uRmpzz4ki+fPg5v5kBexpY0UdYsqJPjdrazbWWgqZfJhi4/jgtZy6RqWDmu1RvlsXUxufOFN0NALRjwGiChIXD+8/GiXDve+It+sUj/hhWvy8U4b2tfs8BcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB5248.namprd11.prod.outlook.com (2603:10b6:5:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:29:31 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:29:31 +0000
Date: Mon, 20 Jul 2026 09:29:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 10/10] ACPI: extlog: Validate elog record length
 before walking sections
Message-ID: <al5M51G4Er8uP6wZ@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-11-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-11-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB5248:EE_
X-MS-Office365-Filtering-Correlation-Id: 837b7c1a-bf3c-4136-5715-08dee67c1367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CnobfoSjn+0qpLMYlIuzM5lU7PcHfUNvVySOFbZLYvSAY1Wtr4aqqAUIAmgkflUAkLH4vP/+I/t1mo4TOhcCUgOhpRwifrrGwow+Ncx9/EZfV3T9vqNVmSnyZhGpGxs5+PTVYG88PaSNsr08XClg5BG5JpfKw5Tjuq8A4vfi0IWy/5H2aRXW6qxcDM7889VPE1V7E0cbjhw3v9d9DPphj2FQsROWf+U8E7lDmo7l4Q058FVgkV5n5AoisDM4UNtbktG6Jtrc+EHetYtbwbHOKvkmqRoR09HkburL9qsIoJURAS0f8kT1LbJAopwCU0zvyV/LsB8YUH2p+Vx3lKo17MCagrmOSfKi1RCm48HDwZ0wCIB61CfImpqJaVtJ+OILHrAQ7kfeXVtNS8usORPBGl2+oCK8Q0Go4AlzjYeMp7HbsYTKVTR1fXFiC4Sqar/XOtRcj2LJw6l0V0MAIHgI1Q537/JpRUcwvpxwujKbuSUpMDjcChgNIXPxP2DWkzOBRueJSlBnungx1BBElfq4e7nQhpRjo9c8jXuhFTzHQ6YhjAoERp+ToatWGDQtSpj4zFD7t1yoUp0fros/OnJWmaXh+P2ZMflhegdc9mZ325w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vnVAGNkNjRs83L7mJa8zbI/kn8hO03wo3tJBLj3QjanAt+qorg2BXl05UVf?=
 =?us-ascii?Q?90wVsv0dc+qbpfpy0oOYXSglx7bNsvMJmv8RuVI/hKt2fuyYwVaTZysilQy+?=
 =?us-ascii?Q?nrZWCFBZ3exRl6I5/6qjaG4IyM4ylaBlsGm7rIMlTz4iDzxNFHLpQmMwHqQN?=
 =?us-ascii?Q?nS+9OXBlYF/oVxQRoSwUXEurGXBQLo1njyCYVBxol+sEtz0/EvSq4Z8viY6C?=
 =?us-ascii?Q?YhfXakNmrW6JT+60HfEtZW/s39ruj6SlrMJF/IxclSy4u+i6M1uzCUAuYlzV?=
 =?us-ascii?Q?MlR3bsj1EsY44zTK2/s503C8olEwBr7yzZW9MiWzXM1EKBMaNM4bqP4xUBKR?=
 =?us-ascii?Q?N/DZkU2PLaXQ+us/nAiWSi6YYFyTGnajEIvx77fosp5TVTZILgJ3qfP1ePeD?=
 =?us-ascii?Q?RCm2gBQ7oxIwOggSVPGr4tdmaJ5dbU533NptauwA1txwQ950ksLFurrBThyO?=
 =?us-ascii?Q?M53LzY3GLLwckJLZEj62nNkAyhWVYUQRN7OZtyruUlQ1FOZoSaI95M8qc9XM?=
 =?us-ascii?Q?x1tyr1lKupHtoHBk3sH4LImW5oSyp3N8Z6YVuWPXLEan9GARceFpfmAl5fol?=
 =?us-ascii?Q?16bvUfTSBvZTjLn9lM79hkNuKCMl6igI2vS/IvNOWXqgx2BZhEyo+lLrP8XY?=
 =?us-ascii?Q?7hAhDkyLWP2bqJDhVg9ZvtZ1wTgZcrrA6Rf+ZC18Zl5tn0keTijw4UF0SHwi?=
 =?us-ascii?Q?t51qfCLQxJwAyQIcaJ6nyppxj92c/HAj2nYEcQ56BXyFsjYMbcJZIbEFbbch?=
 =?us-ascii?Q?uE/AUwu5g0uHV30WW6tH9vP5BQVBVfoQaOQicacfZDIzOY+Qrq2lNuuGyx/N?=
 =?us-ascii?Q?4WFTkeRo2HHfpSgJ5/W3/YugOTMalQAAS2fpCWNYUufPOHTWFgmNRRO2UDA0?=
 =?us-ascii?Q?S9CG3v+Cd8FlvHn/iadrOD/4fzGp0yK+0PUurMsFG2NBfwXfii1WmkUEIh2g?=
 =?us-ascii?Q?3nrAGnfZTI67YZ2m/6fR6q5UBWt9fSv2eK9ZFL1DN+ULSbpl3xxciVuGBIJT?=
 =?us-ascii?Q?isAoIebn325bd0PqC8dfK7r7ZSFUfUcLWhxsfj3zMH7sEGHoLStThlxcKz2l?=
 =?us-ascii?Q?re62EbJfh9WhWDs0lyPM0FY9XLk+d+HeTbgyo94Jwvr7GaLWqc3VbAf1BT+C?=
 =?us-ascii?Q?By3EOe85OubqJpHpB3E4aW8ZdT5R9QrWdNCb9JLHiDob58Psy4Pc+5yQPeLS?=
 =?us-ascii?Q?EGMoygPOze7MGeBswIYSLhzhkFEuzpXsZtApX1deud+YUalU6rCZ40WrAOR7?=
 =?us-ascii?Q?RqJdA8yXznTLVRRRqBvr89lfRsQvyn29oEy8bbHRLU+rx2muaJw/GtTGz3pa?=
 =?us-ascii?Q?3Zb3vwSKOPvCK5K1h7SwWatRB7zQCNNxf/HLgb0SRvdB0LznAnCSIYyexqlu?=
 =?us-ascii?Q?RWahM29xfOkgQkcPp7zG5bD1woesmJ2kgMcyheDw1RqCAuCFRAIOunM3nCnu?=
 =?us-ascii?Q?tPgXW4P0TiVbNNXImk1ko1NyGWxyzuvq3A+1FcOYO0C+3bK74MIzJxurPHte?=
 =?us-ascii?Q?h+Xm36Fi0l8art/7TzE9GyAsVCCSXhF/nJSQbqDYH1FzHQjkj0FyiylRvnIV?=
 =?us-ascii?Q?WImlnoaN4hOv6eW6yokdIVUQ1PGJ78tWNIBTaeuCe/DWOOR4XA0/09QyFO96?=
 =?us-ascii?Q?9LURQ00krSv6mPtGchi2DJbNuFzZSKkvzy4GuhqkR4ysxaglHFhus3zh5fS8?=
 =?us-ascii?Q?YZn/uTMRdioyTXMArEhJbXUUEb8/oD0E9AeywfH8ss0nFUhYSzil5nprWAKW?=
 =?us-ascii?Q?JbBJkIBa6r5fsaAg8wlLp6Ime74XDpk=3D?=
X-Exchange-RoutingPolicyChecked: PKBZcYzWsAImrG2o1KhD0OERZFDUhCtQcrD5a3hEkT3tbMAcprZzTXqG+8WZ2UTlZL987N473Lju+NeeaVhpI8d5Hr5FUG+5uefLUOqo6S0c7Gl5R5rPr5eRUHm5Jcg2wVn9pmZtRBs8wdA/hJWv7uqUfEMVojNT9ehT/IyHtQ6X71FI454XqK11HGhKfgH3PFrvvbOGrbIx83zVFxMGUUWldyQxj/FMfnbER7psp8tEHBQB8m6ZpxahHPU/Ng6AfraE6ltsVaYQSbzzQEXD4nkwyDPxQYkQ3fMORMTE/APGrFkG7lvZZj8u1iPMgu7qLJQpRHrQFvPdGkVbzZu8Pg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 837b7c1a-bf3c-4136-5715-08dee67c1367
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:29:31.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+lQfUqj/Y73OopYd65maH6YkSjRFIUcpmyRHxjHLnn02ZDQiaVG9/F77WrtALzFxtvRb6ODJ1OPRBVNCAuA+dkMODR//ZHuMdMjbkiG4bY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5248
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:47AM -0700, Dave Jiang wrote:
> sashiko-bot flagged a missing bounds check on data_length that allows
> an out-of-bounds read of elog_buf.
> 
> extlog_print() copies a fixed ELOG_ENTRY_LEN (4096) bytes from the elog
> record into elog_buf, then walks the sections using the
> firmware-controlled data_length. Nothing checks that data_length stays
> within the buffer, so a malformed record can walk the section pointer
> past elog_buf and read adjacent memory.
> 
> Unlike the GHES paths, extlog never calls cper_estatus_check(). Reject a
> record whose length exceeds ELOG_ENTRY_LEN and run cper_estatus_check()
> before walking the sections.
> 
> A malformed record is now dropped with NOTIFY_DONE without setting
> MCE_HANDLED_EXTLOG, reflecting that extlog did not consume it.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=6
> Fixes: f6ec01da40e4 ("ACPI: extlog: Handle multiple records")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
