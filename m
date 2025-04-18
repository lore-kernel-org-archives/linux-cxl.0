Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE5217F5C;
	Fri, 18 Apr 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993415; cv=fail; b=gsCRhIiE/WjGUU/9SWUOPyu0Ax0FXjXIqglj9CA6+SmNXJCUja0ICaMqnEX/OMu2AxojgLT4BQlIMY1WiT7oBjIV97d+jGAekbkNYoPhoQI/i6xBiuvz/bbpqZ1PYwiVwT4cQU4lShMEFW7SW/NfDRVsL3RGv1ThpnzEfbW+Lx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993415; c=relaxed/simple;
	bh=iuL7r7SotQXAxbVwjMxwOCIUgyvUPHcWFZRrCDWUaUE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C0uxiCS4/EkHslLpt22ZFdVKajBYQEWqGsZjU9A3I1Dkl7R1Q5JPlf71U3MpsXN4ytnrZc/+6KLLh31sEHM3/pq1Qjs87b2MHextMLW22k+9U64om+2IdtwOUsEM3YR5Edn+3x1S1Gw0rNVwF0o95U3wGYf3vALFABEO55uEH0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLROuNkM; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLROuNkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744993413; x=1776529413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iuL7r7SotQXAxbVwjMxwOCIUgyvUPHcWFZRrCDWUaUE=;
  b=aLROuNkMKNm9xJwlAvPe4of/3L7tvA2oeU03qMAgA50o2Msa0VKNw/8O
   rgbMS/xDcNr9cQkk7C+TMMlF6yp31wU0mfF7hHwXC1WLJNa67r+bc1nXa
   3vuKaaSIr9Vji/XOO0rxNdHIzp8tj1bm11Eq/cq8pvrO82NXBKdEURAeL
   FvK7xoMG1bOQvGBemcuIjT2g5PVe4TZn+xZCf2OWukoktD+i//bb34xj/
   gNqpd3ulNuY0GCxFmhitoXH6OYpnpsCUufHENxlhf/wjeRhbjHbJh7tUo
   BgnXcdor2I6GDMlcqhha6MLssBsd4P8qmcF7ChyqgVswHNwhJ9aiapuB8
   Q==;
X-CSE-ConnectionGUID: kzVzQX/ESw26fVe14nm+Xg==
X-CSE-MsgGUID: dKMhAzbiSKiYpwPD+Japhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46745318"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="46745318"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:23:29 -0700
X-CSE-ConnectionGUID: JWMhKzPiSYOeAIf1MbexhQ==
X-CSE-MsgGUID: 9yfOw6+9TVGo146gP4533w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="136323022"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:23:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 09:23:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 09:23:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 09:23:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbDOWC7L6DsCS/FBuzSUtNVjRksxZnXYy+MQeSru99e184Y4PnHRBwgwPu27fj5kNlrdC51VdhXw+mu3WIJv4gqcjGzx3Pm5EJBCpkKXem7PXvQhGwAygPdPf3Kiniv3HUC5GOC8Xb70975Jwxw/jy0U7ZK0rh0gVMjqmjJpFgdmSpEkmJTSK89c9sPheYTXSBd1KYe9KVv6hijLpTFV+i0J2iWRDxSM4DKqY258lkQLjB+/b3/dCjXcSAIqEZUpN+BXwKJkKoRZwx6YJLNs6qf/m7PRuMIIj39LENfcmufr6vnJd6MYHU1nfMa0OpJterqZFzylrny5A74IgjjWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hixXuovTfxV1bImpgCheKTIq1xc79nR2AUSrIbf3qjY=;
 b=sj+dWANivVrHUrQPQTh0ledhfxaYZUJR8emelTvaw9cqTVAhfJpbP86d2xe+tFn60l4ncmsUcuVkcA5n5d0nBE9CKHNcjhQIG2dB+/O8sLfTRWesYGIrfYtE0dN8VhgKnyZ3nGfszS8nfhSc6jzwv+ps5nVvZbN0v8wSC0WQQkeuAinU0rBYQQDGlFcehqxUiB7hUoD6coZ2BWRkYiwPzdXkB2xKcmoflFNcezPaTD92K/WQo0/urpYTkQMYwqOmApuVEZcVllqA/kIlcwRZoP7Re79TnnEBq/c9hZaxZxvO/Fzat0YB2iniSVtj2Ih+Ar5zCCCbLHzFu2I6a77pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Fri, 18 Apr
 2025 16:23:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 16:23:23 +0000
Date: Fri, 18 Apr 2025 11:23:55 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: Re: [PATCH] cxl/core/regs.c: Skip Memory Space Enable check for RCD
 and RCH Ports
Message-ID: <68027c9b27e42_1834cf29448@iweiny-mobl.notmuch>
References: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 124e95cc-944e-4b0d-07fe-08dd7e9556d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rQhpQR2cTzliPLdipw7LIVYeXwlGvpRKMx6dnWxcQf/QCdRhDFK0ErIU9Mz0?=
 =?us-ascii?Q?WD1pBAvsJ0FTwPLKOqlA/e0OkhrptiTNnJC12pHwFSuQA8Xyp+R/AihpLqAy?=
 =?us-ascii?Q?B8c3dfG0XbrPxKawUq55M9t0zhPNB5qBipHn9T8AxNKg8ANKWJc5N0AFShX2?=
 =?us-ascii?Q?a0bOl90WZzrla7qeCyqPkanoOAjdWvW2Iq+MVy1T4A/0fYQRYrYwb9NSMFu7?=
 =?us-ascii?Q?3NR5pvELgaG0GZNmjr+hpHazkRDEXKS0zhtlfWo5JT8zAszG/OaRwf30ctzm?=
 =?us-ascii?Q?6SkHKbdq7yPYhzRxINfHvIyBihdFYIOLaqevFPGGGxJ4DWS9zS88GpcAyESs?=
 =?us-ascii?Q?R81HwihSwPmIVxunBx0IzlSEUfKi3obOsFjD4RxJ6UJ6OI2oILefl+B6rFjB?=
 =?us-ascii?Q?IBChR+zF9BmeCI5cCxGrCHPQeRmFpiS4VJfSo6LS7xjyWXfxZDs3w4V7Vw2Y?=
 =?us-ascii?Q?HiaC7WAIC1PYcsCL03QMH0wuOVcOhraJ9il8y9KdwriX5fDhWlN4wiQKzewT?=
 =?us-ascii?Q?SZpJQJIiGSGnTAovTEjyUid4AuGS4sCbEktAsXut7uQ24SntG0H6/GK5a/Ps?=
 =?us-ascii?Q?b+FyLG34MPYkkIUEO2xH6Vlw+V9e92KxUUmcEzQWQWW3J1YCYKJD+/Wd3Yu0?=
 =?us-ascii?Q?Mzma839OXqXdyMzWma4ren2g8/zC2ffpFXmGRdiqYIqLTAMZPC+JVajriQi8?=
 =?us-ascii?Q?Z/bI9fd+1UxyyXOV/QxY0Xf36QacST4agpMDTMlas85oYIojEe9kmHtcmNXk?=
 =?us-ascii?Q?m3GvUzAvntbxcJvK09FEbKMmR6qNniJZcIh8op27KnbOoA2+ghf6D1WxsBTk?=
 =?us-ascii?Q?Zk9z65M8Z4BB5bCOQ8c6R8VyOQL0dolLLeZDhxn6NW3Il8NKMQX4tfsw03ay?=
 =?us-ascii?Q?dvtKgOXUS7RwveYjpyy5AErTY8fNTFhdNDDapABwXTx4gFkoelfIxl6lG9hQ?=
 =?us-ascii?Q?4E46ZcYdYFykZYiAAIoOnVVFfzFytPNJdo2FDYGq/qfNw1bSqlnWyDACeQKd?=
 =?us-ascii?Q?98jQhy253GJdw/9Qo3dOrgGX5Ye2ugLVX8XfoCkBhlNd005KV743QKsCpkGj?=
 =?us-ascii?Q?xHPt53lOgq1GRs1SRrQ/P6uGmpmyfknHik/0TUgJ5uafN4NNYQ5ml7ecLGXS?=
 =?us-ascii?Q?HH5nXocnUdNjoq7dWOPzDDmURyaVFl9sLF4zjO3ySptoOK31SE/aCDVHYaLT?=
 =?us-ascii?Q?DQI2Gn0VIPO9Qod1SFtp8t0svWwJIvSoxl8GT9KH1ZE6z5R0DNV5Gpnf0eQ5?=
 =?us-ascii?Q?m1de5xtncFYYI/rK0GPeJALy+KRZ7J4C8bcA3HrWixbD/6aGvvBSK+bv72PQ?=
 =?us-ascii?Q?hLXABS8WbydbIHGod4M45SC2qBP7I0fjhi5Ddz1w3xTn3LqWTFkldgBY8R+1?=
 =?us-ascii?Q?CkPuRtW/ruruLbtHUx01RrezxY7uKGG39nyTvby59/fzotEgBHFIGcxdUIF+?=
 =?us-ascii?Q?e3fmlklAr+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?39YOsu3SS7n0zOVqUCejQvmc7CaatecLQkmA8hctBnABHL4wiymbVTM1p9Vm?=
 =?us-ascii?Q?mZvsfiOzJrHgJBrSMI0N9MZMk+8UxTImzhakvVMvUmjZ9ve9z7ldbNYUpI37?=
 =?us-ascii?Q?MK1RGSQB+CWEHTqkAI6HAA4BJ5LsoHEr9jQIx7AkHF4e8+OB7a9wp90fwPor?=
 =?us-ascii?Q?WI9IrvH2O6Oxd2BZxhQePjL3IlNrVsXpZBVSHhrxjVMm2OSN00sJ4HAI5GEu?=
 =?us-ascii?Q?zgLRAzn9CQxsXmAdCA5ETdxVKS/Sxzrk5IhM9gJ/pZIhgdeWA59bKoODzR/Y?=
 =?us-ascii?Q?fgbbIJzzxLmwjVPE3SMEpTmz2w+aRComi5ZbSvYLlD1fhUZTfhkIJwpSz0nD?=
 =?us-ascii?Q?2SAcYDszn0kpNwEiUjTcpUEdopdUOtqIBhLazvUzJ8DBV6QnG3mi6FUvjnlt?=
 =?us-ascii?Q?KgbQ1ngCa7yx15oY8qiP7HakpYYZ73/+zIYXn1Y9mz3colvba4Y5HoudmoC3?=
 =?us-ascii?Q?nToMloyY1Y3Cf1c5eDTvExPyHkDchxio6akuhT+AIxhn1Ujq4fz4wBAaKIpT?=
 =?us-ascii?Q?QVOSUqLuDl9Ka72qcIcshPQBu/T8bbvq1OSsEy6kKdMGyV3AUmeQGMJXCHQp?=
 =?us-ascii?Q?lfEOOKabtoXlqbBiDTt8vFnB8DN6c/TikVY3AMP8tl4VHmqAasQr88c5U9QW?=
 =?us-ascii?Q?cd85hMpgoy+kiLqXBtezp3fXx6hF462nKxMjEGb+4QB4cETx8Kk9fS4AR2E8?=
 =?us-ascii?Q?Bobf3nGLniEwD8Oq3o6LWOZiKoE+l/j3nTbOuhI2UnWxCqzDpuoTDvusrrvP?=
 =?us-ascii?Q?yUFtOVv2RN7i/Vf2VmfmDDcLr92EWGcBv05jBYoOCjnfgTjF0gBNRXWff5yK?=
 =?us-ascii?Q?aWIyU33ht3JUvpnvdKfsAPCcCu/zVWZiv9ntfjd1kRZoFoEPFCdDJ+VlQJOw?=
 =?us-ascii?Q?8sU5sXFOa66rWDJKxD4pNblCXBjK6J0MEWG+FUrLZRt+BDtVjQWjUCCo6dSb?=
 =?us-ascii?Q?Hhr2HSHmPNSqocn8fOBe4FScEHc82acKEq9f+kOYDl9zRxf0E+P2od8x4+0c?=
 =?us-ascii?Q?kGGlZxl3sOj/xmPZKa6cS9LYwoFn4A4EYHTDybRhNMu3Tc4+wlxJJeF3kL0h?=
 =?us-ascii?Q?4G/qKc8L/dlVu+15N32jiaEl4J+Shk8wMt07NZC6U7mgZPitYjB3+qsT4HAE?=
 =?us-ascii?Q?ULDzK8xcOHuIRsq+EYhpaQWkNMTnSOXofLc5GVaED9mYXJfykJFDpFvxuYJy?=
 =?us-ascii?Q?ytqokTodNur0bbG3fzgFK5wGIWQqt+NnWXRPr26YpDERLnua2yM7zuZWgNuD?=
 =?us-ascii?Q?XNzHko7MbPcrvmfsRuN2wBEa3L1Oe44W8vWD98wHu4FJ2e9kN2HKG0yJjDdJ?=
 =?us-ascii?Q?4Mlb65590XopXyZLd6E4g2SlWi1Ghppa+0RUYvqOcGfljVhW1xiaveYq3O64?=
 =?us-ascii?Q?kUbjYRo3D7vHsR3HfEzA0e5uk3Rm52f1k3cR297Rl4f6uld1V24Ms0duGJiM?=
 =?us-ascii?Q?3Vwy1+SatBTOqZAeDFi1bq/TVOup47uWcEVDBT6wbxzEQCFq9T7weVBU8Znt?=
 =?us-ascii?Q?qKnWquAFeYt63pZe6C+vMe4cM32QWncYvMGu13ikiyXSPebWNQW+WGoyYMiN?=
 =?us-ascii?Q?lb0T4UApwlEQ7RXyGM9K4YcltpDUhDATrBtSUjN1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 124e95cc-944e-4b0d-07fe-08dd7e9556d7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:23:23.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L47yiDYAnR/Dr1+WePDhOG9w09eRcWpxKLQAyjJR3/u19xxnLKKcYBhb1pgd58n06HD2DbujBFnPm1/QLYOCxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> According to CXL r3.2 section 8.2.1.2, the PCI_COMMAND register fields,
> including Memory Space Enable bit, have no effect on the behavior of an
> RCD Upstream Port. Retaining this check may incorrectly cause
> cxl_pci_probe() to fail on a valid RCD upstream Port.
> 
> While the specification is explicit only for RCD Upstream Ports, this
> check is solely for accessing the RCRB, which is always mapped through
> memory space. Therefore, its safe to remove the check entirely. In
> practice, firmware reliably enables the Memory Space Enable bit for
> RCH Downstream Ports and no failures have been observed.
> 
> Removing the check simplifies the code and avoids unnecessary
> special-casing, while relying on BIOS/firmware to configure devices
> correctly. Moreover, any failures due to inaccessible RCRB regions
> will still be caught either in __rcrb_to_component() or while
> parsing the component register block.
> 
> The following failure was observed in dmesg when the check was present:
> 	cxl_pci 0000:7f:00.0: No component registers (-6)
> 
> Fixes: d5b1a27143cb ("cxl/acpi: Extract component registers of restricted hosts from RCRB")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
