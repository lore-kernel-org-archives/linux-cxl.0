Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72762DC791;
	Thu, 21 May 2026 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395102; cv=fail; b=jw9L3M6EXd2EWCAm+XCeHWvcJJ1hck+KEpQQHM07wiLZouXA1HMBNwMQyi2aKLu3VRo5kSmAlenXFwKLsYnIoq+pA3BBdbXBw0lt/y0zhCcGQitFvRPuk7x/DHHKbDCiWsgtmKjt5ms3FrAelab6vOCowTGyDlOeqi9jU/lYQtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395102; c=relaxed/simple;
	bh=zJ33xF+KhFUjt5a6Y7ZyxuTJMq4ThSYtQItLjk3MZW4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QGSQ5j+a9DsPUm/QCkHdmuDBskXoRIjpPOegWkZHxmr6K3RjfM8eH0jaPKPnyIBcyogy162QMJwkcLqPFAN+3pn4xl38UkKVgvbM57KLnzgsYRCatATZRx1l5Phuej8oFzomka4KgyX6gawRc4Khkk8WPYIMr1jE9sRUB0UGzoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2llVbit; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2llVbit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779395101; x=1810931101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zJ33xF+KhFUjt5a6Y7ZyxuTJMq4ThSYtQItLjk3MZW4=;
  b=R2llVbit2nf/wmjQ7SI4shh63ZnNW3ERafzodu4YCqbLxrblUPaN0+c6
   10Pcd+LupPXl3SCn8s7uPxJ4jkILd+RtpEmaf/5FUjxYxwvhbKlpqioKy
   Sagv+6kd9DyuvAllkIy0YtuJRqzypv00QZlCYGBBTrTdVNxv4tx8L+KdY
   MhFwOkwI7J2q5leulYfrh41JshjChF8k7Ydf17QC3vlkGRCpsmlqVHOT6
   uxfMl+nrSoUQlW/kNLLyS2CzYwIbUcvyksuN/5Ze7Z/3hqROlxRYaLjfb
   PpEr74JO0B0CXHHjiCwpu99BKZp9MU8aUsO9sun7A66gz+0LcBwliniM0
   Q==;
X-CSE-ConnectionGUID: Y8Pw8HBXSMWd18EWV1iZng==
X-CSE-MsgGUID: S0A1OyRnSyGwTX07RnayNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80379668"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80379668"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 13:25:00 -0700
X-CSE-ConnectionGUID: /gSBrO/8S7+VxE/pxSIvSQ==
X-CSE-MsgGUID: ibt672e0SFOL2iIWhb6Vvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="264441458"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 13:24:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 13:24:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 13:24:59 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 13:24:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXEuRkszNXOJqZYL38ALlN2Rf87KxiMhJvnqYaigJdvGiXSltLSR+zsrdRA6ritel2BTDEUENCkwhNYqTKaNPdcuF3kR6yTB5xDb81jShGJKEdHIlA3n2P/vyvwQjq0JfKef3mO2rwAkpjW/DIFBy8K5tDwBWG8x48cSnDhPQ+cTGYr4KSK4KydmjSkJtCBJRspTOicYkBDsjFqsz3IaVZ+S4Twlv39hU7gFAJDr2S+fqRkleFR8VXGdYavf0V+yR9OV/bTnhCoWKn1zTFAVHTsdth8OrtMTBjo8l6ySI/uxxFw3KDhOsgzI1litU70sTRs4VfAfQcIefHm+wtxSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0uI1AlrGpUIqnmMQ9bv/dHd/uWvE7hOsYyGaV9/uDs=;
 b=hxz8HrVv9tQ2JBxHHtlz8bOn1YOruM1UTRk5KczJh6otcmmO9yaQcHraE/rwlC+S6MvRuUBBF6mwFgTjmtt+jEsdA2xZMMpy0OYBsSiMPu1+c/OJa/5qRm56wQVXXsZ23xgOGfjMzcACBJ12azUGCo3aUOLCEZJ3jrpu1Y3prh9GS31/TQMce8UxAXBzmwygi1oBrNXt2LYMkPXuPx2MKyL0yiN45reWaNPpG74p9ErhHHTq38+0JmGnQ1E44nWnZ3cu8xOD1/h1GgI1DF5sXpkIayQgmLtHIP151uy6SgWwPyro+LoAMIycx1X078MCf65aAWR+CDBMAdLJi8bBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 20:24:54 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 20:24:54 +0000
Date: Thu, 21 May 2026 13:24:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Richard Cheng <icheng@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<fabio.m.de.francesco@linux.intel.com>, <rrichter@amd.com>,
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v2] cxl/test: Enforce PMD alignment for volatile mock
 regions
Message-ID: <ag9qEdwvqc51Ju2B@aschofie-mobl2.lan>
References: <20260521083257.27753-1-icheng@nvidia.com>
 <f98724ee-249e-46a9-9a07-3be0e436adbb@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f98724ee-249e-46a9-9a07-3be0e436adbb@intel.com>
X-ClientProxiedBy: SJ0PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 239011b6-e886-453b-a5a8-08deb777048f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|11063799006|56012099003|18002099003|22082099003|3023799007|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: YIVi4CS3yhK7wg0MfaUYBusHPpr4hAF/FV7+b+YcRau9lWpY0NEwsrELYue8wNGoEL+XEFIHb+AnQNNXthPHbmYqhYHG6FQPaR7uMITyDbN+D6XnVLBd7sV16Qk1QIyhCu+2WSYQytxf9QCgwG4Z0vhA1mkMCMG4o7qeRLzZNXsQrt921z88hOzbtjdaLXhugSNnUfEjWknyaSleKfBjbOZ1A7j3DS3OVTD/oN3d2fBd9LSvY4HKLMkec6mXtMmZFV4CR/mi1YJUD1wzQiYFzgaFaVhJWA3aPSGesqJk+Ukeq7Rm9qca2iTFoqrJydOVIPB6377Q+w120WkxApf92RTmC3OGMkdtnwzQ+8bATgS/+g9ev15qf+j1ad/wAYiRt6K2sb4pCtrZpzyUKQYkqRjYuy7AIyE8Gk1rGyZRepcV9yWFFS4EFUT5JW4sPjewT1mCyTTvtc5K+/2vurXmK8DfDuTauvOXOKgE3vanynAiwlJmMZn3YmoDX0xNYzgdcfL9rZHQFkDZfd1SkoSJUgRUzhBMOkoi53IGEKqT+RyzPE+/n4o1TOJXabKC8CkIJ9A+mc3cYwCi9TFNh316yJT3ezZ6HOllCQau+shYUKDk6Ai4ytfjJtE/Dd3/Jt4e0l22oyNXUbY3v7wF5cLIn+mGLJPDrNwkFUPBCTenL4gp+1pnxu5Nam7+vrXVsPdoPVwovUyqLrUD/JCoHtoswQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(11063799006)(56012099003)(18002099003)(22082099003)(3023799007)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nHdlr+1SbIY8FDDOL3ZEcqg0ccfo42K6+3RUwOWg4tvUpeh/859qi0V/TOFi?=
 =?us-ascii?Q?qRSXioPMIJ+9GplktjqzZRRlGTom94pLmPloY/u9oNUhN+dXCPCri32MYWGa?=
 =?us-ascii?Q?qTPllCHGrMQiWrP3uyx1SJYTwYEgWzR/LNGBjLImuwuhnX8RXLcJQRkUDNnK?=
 =?us-ascii?Q?a2jEsBMiTW0MJBbWqRvrlRI1Sj99jAI16CbemWhJyhdPko2+jm06K1GIq/i5?=
 =?us-ascii?Q?VhQWUYmz3WPfirP7LscrLzSddOQAp67mnaoLUt/Yvk00xIHJdDm6Th/IUsTC?=
 =?us-ascii?Q?0Ph/U49s2RUXSKH3d3PajcxrwFlfZshlA0UJiMCHBA7KFbIccOJQizZB77I3?=
 =?us-ascii?Q?idyoZL2449tjrdGRwjcOs1ga9P0BSwuWv6DH03fo0FI0Wp4roIjwq02T9WaU?=
 =?us-ascii?Q?PmSrA/eep58w6YGhBT7RMNmZQz9PXXZMN1lMrRPn0tZGcpicH+s4KJdzdmHs?=
 =?us-ascii?Q?kq3dJXTG5iQsXrTb0PupipJ/T8mQNbNupL7D1LmpV2AliLu5NWkg1tZexvS6?=
 =?us-ascii?Q?76tQ2Bn5SWRAbbHHDBOOigpb1v+pX9rMfbx28eaV9BDV6llpyfDH15ttPA/v?=
 =?us-ascii?Q?5HfQTpI9FMqpHC/5VjpYiT115+B7Ni1DrnepcUfWdVlwMlA/iNVlo3dPfJsN?=
 =?us-ascii?Q?hQWcoU3AdRNx3JoTVDwQpgkmAhfXPvUusO9E2u+vMJlQEWO5d5l/Zg9hSyR9?=
 =?us-ascii?Q?gDpqlh/HDCiyUbLCH6+v9WfQ4v1EO3n+5eF5xnP8UziUuX3n8DyRp+HdtlL8?=
 =?us-ascii?Q?SX+p9EXq6I1vlFeYx9khIdQl0AyZLxzXqasvT767Wi1KucpW/muebRFMCA9p?=
 =?us-ascii?Q?XhibzdIDSmhtVNjGm9Cj5QvkTFawpBzB0e8bkN7+hGqWJDi3P9iynVDBcnlJ?=
 =?us-ascii?Q?t7FPoxY1F4hOLsgM1Rqf5o6mpQM90TZtItgSoxsagaOOEXyxntOL7eYSQmwh?=
 =?us-ascii?Q?iJdOKKari27PSSvY/iK2L9+Cn91VjVBvut6koWSMbhgatcClAsvBugzS2TIv?=
 =?us-ascii?Q?pg5xbc/D5hRcHnnkJPL7xgJjzGmU+YyuS8Z7CxaYIIaFNokAGb97LZsycgjk?=
 =?us-ascii?Q?JPRIVpBLuvpJZf2wvksqgLmzp+f9xJlq5z98Y/MCgpZZuGlvVrFtevWfG7ts?=
 =?us-ascii?Q?+2jKMW4JN5GnW4dvw6KJKTCsnKJBdBNDOUaUL8ilJcmk8EFIKDam1yExiJTh?=
 =?us-ascii?Q?Rcv/NIjGAHjijB/w31gFUOZwbPQTZJYT3wGzTKU6FU0Ki0wUyPUCA4nXX2vV?=
 =?us-ascii?Q?e+geNSUiXz+0x2CVZ9wZst7J24yuNQuAaQy+ssKHvZiI3W64F5y1kcghKLid?=
 =?us-ascii?Q?R7gD8bS8FzLXW2sYt1akEqgcF+jSpY/D/dl1Cb0sNGEh/qm5rD2fwU23+Fgm?=
 =?us-ascii?Q?ke+Xr+UFIaXC/tN0r5mIVF/nI8TYTPp/REAHMAu7zrkKjpyRPaLvR7O+t8IQ?=
 =?us-ascii?Q?6JvQOSXUH3NSbLKXK52WW9ucWtuH/TTongpp7tMLDGkRX+rCIdVO2TmIk3z0?=
 =?us-ascii?Q?D9VBzpFvARK1gylFl86upqdnuaECsLuRz936K8alS0d4abRnHOvyGdlIrfu8?=
 =?us-ascii?Q?s95qMOiqg2vEsRbdPqtJ6cvhnWTK4HE+kNAE5VJbdnFq4tgQadhXYRRjeN9v?=
 =?us-ascii?Q?2k15wRlWPFa2Zmgxm13drBv5RIh9fguEMkZUN8AVimEQXO+OAPzwK98qOmy8?=
 =?us-ascii?Q?T6rTu0msEcyyUINALAnnQSe0vhQCenCPH7V8bqvNljZpw8C78WbS+dz4Djuo?=
 =?us-ascii?Q?VRxeJ0bKe90dUrPw0RXocySr/BXnZvQ=3D?=
X-Exchange-RoutingPolicyChecked: rwCLhkGFBpw4q/PJzISJR+Z6H9LMsr98/q62go3CSAw1iigWiFU0ltKsAcT92A+UAylkBwpbsyWP5jab8OLHSZQX6qb8hwHRSPeCgaWQyMNsyUL2tXn14W1jO7++69v9EORdLAdLBBJcKviaqfOuViwEs+PFXgRm7jdUVAyoD9ms7OxEE9E9/IigGB27gv+BhZ2VKQyhelmAwa83WieJPSzae+L9TpNINCzkoEA0CYc4xvYTjNBAyITfNdVly86/F1hTg93xDU4/cD10dAFKUy3lWpP0qG60fTDNUmVWsGqL2XZSpVjY1g8RwfrMG6JMRjZBMr1KzOmZ4Yam5I5h8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 239011b6-e886-453b-a5a8-08deb777048f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:24:54.1365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usx7aExN6USDKthvqJpTEEXzq2+iu9sBlHjv6VVuLmnUJplgQy/X9FNSoQcNgnGOZt3ASpA+++XK5AZJbq2snk8YfOEnLmFms84xFUZ2LCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

On Thu, May 21, 2026 at 10:20:26AM -0700, Dave Jiang wrote:
> 
> 
> On 5/21/26 1:32 AM, Richard Cheng wrote:
> > cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
> > SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
> > CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
> > from a volatile window inherits a non-PMD-aligned start, and
> > cxl_dax_region_probe() -> alloca_dax_region() fails:
> > 
> > """
> >     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
> >                                 with error -12
> > """
> > 
> > Enfore that every volatile mock CFMWS is PMD-aligned in both start and
> > size.
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> 
> Hi Richard,
> I can't seem to apply this patch against v7.1-rc4. What base did you use?

Hunk headers are wrong. Maybe hand editing without reformatting.
Diffstat is wrong too but that didn't affect application.

I'll wait for the v3.


> 
> DJ
> 
> 
> 
> > ---
> > Changelog:
> > 
> > v1 -> v2:
> >     - Reframe from "fix start alignment" to "enforce PMD invariant for
> >       volatile CFMWS"
> >     - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
> >     - Gate populate_cedt() alignment on
> >       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
> >     - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
> >       in cxl_test_init()
> > 
> > v1 link: https://lore.kernel.org/r/20260519233523.5991-1-icheng@nvidia.com/
> > 
> > Best regards,
> > Richard Cheng.
> > ---
> >  tools/testing/cxl/test/cxl.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 418669927fb0..09c309af5fd1 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -318,7 +318,7 @@ static struct {
> >  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
> >  			.qtg_id = FAKE_QTG_ID,
> > -			.window_size = SZ_256M,
> > +			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
> >  		},
> >  		.target = { 3 },
> >  	},
> > @@ -495,9 +495,17 @@ static int populate_cedt(void)
> >  
> >  	for (i = cfmws_start; i <= cfmws_end; i++) {
> >  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> > +		int align = SZ_256M;
> >  
> >  		cfmws_elc_update(window, i);
> > -		res = alloc_mock_res(window->window_size, SZ_256M);
> > +		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> > +			align = max_t(int, SZ_256M, PMD_SIZE);
> > +		res = alloc_mock_res(window->window_size, align);
> >  		if (!res)
> >  			return -ENOMEM;
> >  		window->base_hpa = res->range.start;
> > @@ -1826,6 +1834,8 @@ static __init int cxl_test_init(void)
> >  	int rc, i;
> >  	struct range mappable;
> >  
> > +	BUILD_BUG_ON(!IS_ALIGNED(MOCK_AUTO_REGION_SIZE_DEFAULT, PMD_SIZE));
> > +
> >  	cxl_acpi_test();
> >  	cxl_core_test();
> >  	cxl_mem_test();
> 
