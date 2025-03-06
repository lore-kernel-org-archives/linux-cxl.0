Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F319D07A;
	Thu,  6 Mar 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287434; cv=fail; b=hqICWNUtdD1D9hGuFC4/7mrNWqXNR7kQhGAMzy+uWFYHBpsu2xwWib+pxy5EPrZrEKc3bvKrCHQQteTq0l3yCdLnKY4q1CRAcdqybOXiCeshgKycRRjQwnHT0mdRrOAsGaNcLqNP88HkGeGiG7KI3aS07yqZL/VE+UBTn8WJuUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287434; c=relaxed/simple;
	bh=MvxMSu2hqQwFmJAhsoWPYuI+E8hcskduuwrai4Z5KTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cs8oxV4AlwbpAJ/t+ZN49Voz4+Y0ee03IU/oFZJWTFWc3mxTKmxlHmNfDLNAiulMhGvB2lAF+szuFlvPSILrPBUoy/IK4TyL5aLE8QparX8oKWUVJeFTC57S7B0WkW8s0MrgYpeBCVuM2YKh8NIhgJYaPoIZohU5RAlfzZEoSgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKcSVlzv; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKcSVlzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741287432; x=1772823432;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MvxMSu2hqQwFmJAhsoWPYuI+E8hcskduuwrai4Z5KTc=;
  b=IKcSVlzvrqkusb83ECBbjbvU2KyirfPTK1mcP29jJi2R8FcJvdeGabNF
   mLdlzzzYqZVYaZEsysr6qtUOz6u6ELFH805WsH2b3noyrfNbM7B3z4bDa
   b/j9b1xx6oinJ7EuQJ0353+maReuzCE3KSrlqitU9VTUUvJjGiovOiZJS
   BxoZt9pJhoOCIWRhzJysTk6XFtXwu0SCw2EO2KM+B/meHPQc6Mxncx5JF
   coxHdYyFSUbG/K+JaMhzQ2PqU/9Oss1PJM9Yx9ZKlir6r3RRxw7yhLPh1
   WyKQMeo6/koxN7dPzrBhIPT0hLIlle+Eb+I+g9BDXfAF5lphRjC4eMcNM
   g==;
X-CSE-ConnectionGUID: RflsjcdxTsiEwBL62WdlEA==
X-CSE-MsgGUID: RyGOlD46R+qR0L8eXW945Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42232336"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42232336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:57:12 -0800
X-CSE-ConnectionGUID: FAxHfyH0R5qsxevzywhKiA==
X-CSE-MsgGUID: TJhee/kGS1Wh0iUL9YrwKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="118841041"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:57:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 10:57:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 10:57:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 10:57:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5TRwPEAmhzdUpHQwKdRukTvCZzuAPybYDLlleGf4sK286w+5b+1hbWNiory9ABoAzz3GooUGREPTSgX5ToSKLPt/ZGylhaF1KqrwaOx9xHETJEeqJG1ZVQKqdfCo9Xqhh5QdrEu8Xstz7Og3PUiaTh5CyuGRFvDmg3D4l46PjPWRJGgVA/z+Bqwql05kzWgGEk9H5twLLVmlHcgDj/6vvYM0cQu8xAY2IX/t+X89ZJZ7/9tQNWG0BrFS931dKBJfQOi3E3Hzl1Y67qtCJUwGDt9JXvkR7A/Qqk7xsrp+pMxkz2BjXsUYFtMg+D9cDFbRVRtwhtWC0feJxWsTg1lRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98Xyo7PFvRfsLjWfzmuNgO/z9Rj6NGYPhwFyZFyXV3k=;
 b=DyRiS71Jh+8OQ0Fth8qXwfpHg9LEgECjiMS07TehJv/fJPM4AHhv90B4SrSSCm3F6MT6Ouxuxs+MFX/mr8LyTBpdOZQpqlhk86GI6Ho/4g4okAA30ff5jO//T30AaYMzUkRndB03ZQ5mbfFIl2PslE5ikeKhvXl4y2R9eGt5vMGumyNy44hYtA5L/rmQHcJeQcVcruZ5ib53T8tlFjvBbTCoOBO2VmGdxE0M4qdzYh6rMzx38R7KVAmsgVvoo9iQ3KYSy2nkr28MTF4e/YMVYYcFTLnvyVrP54bZiGGMYP9RNlPdtHjP8woFmu5xqh5CkSraAh1POTonQmGqf1HkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 18:57:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:57:09 +0000
Date: Thu, 6 Mar 2025 10:57:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 04/14] cxl: Introduce parent_port_of() helper
Message-ID: <67c9f002ddf2e_1a772945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-5-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-5-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0303.namprd04.prod.outlook.com
 (2603:10b6:303:82::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 54633492-e269-4630-0a29-08dd5ce0b272
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RrD/Plkl0t9B3bMaxsRpD3EJz/x5MtcITe+hCRxKORKaunfKdKMaxAoc9jMe?=
 =?us-ascii?Q?CMH4qYKkSkRuLxpsqCJTJubn5ZrVydo90vR/kFMsajnUzSJklMO3B1en+qEA?=
 =?us-ascii?Q?piUcGdyhNf+7EyM+6U4u1AalWwVu3NPrdECwcHvzsqpDVNiprXAubi0LaIaO?=
 =?us-ascii?Q?thNoSKhOos8aNQsEshdXp1nqt+bKr+bwaWTaq7lB8HhQPzBg0EnjATbqae3o?=
 =?us-ascii?Q?4dFlBFItKjIwIGciMNEZZFzFctUwEnccxr0/D/Olo4t8eTFws3yKcX5He15u?=
 =?us-ascii?Q?IWGWPfq0mu+4sM8pzQaZPKvXB4h7Qr0BTkBRjl0HKkPopKfz9rCrtP5y9cmq?=
 =?us-ascii?Q?6jLZtccuiyLS4wEydbA+oijZYN66zECV7WAnTLw/4RrqwQu+MHyGAjPmz/a1?=
 =?us-ascii?Q?V+jz7rcUqutaVW4otZcDUYWW8Su6BehkiDtstsSPE+8Yk3u9/4gZr6SC16mG?=
 =?us-ascii?Q?KstYuk+Cdb3mwnK7jjrqh3ofWCE+HTWNkJBz/KQAqOE94Wyn1okN2JzZJzJf?=
 =?us-ascii?Q?99Iv9z0lbSfSzremUjzfpUrj/zDsOufpX2J1MA0IatCH4rFZaWI8veBhX9Ya?=
 =?us-ascii?Q?QEU2WftufxvTv/JqA/Ct2YFxGtkOt+fpf6WVME44b0UuY4Z1v9h5Ia/67uHC?=
 =?us-ascii?Q?0YsBWGlK9Y0IpqDxIiIlWl+GlBV/9pFt9HSad4IZDhLomsTJPYreFAHvnGvd?=
 =?us-ascii?Q?f+YDHTJJykZUD/syK48agNCx4+fcbNLRNIBGkZ0+Qc1RROgwY9e6nnvmUJbp?=
 =?us-ascii?Q?hl/Hx9dOau9eOoKvroTttGam1vw4Clz4pvINHYJgLLRf9Ir9wyU6e7W/VgC3?=
 =?us-ascii?Q?6VoFT2Nbn8bJFUqnL/0t22wfzZ4l/NSc8DcX4USiWfFndU/qMiShc1whE5tR?=
 =?us-ascii?Q?6xo9UwZSqYEnPyj75aXUlIMO4UKP/moBI5VC+0Q8Hi6c2wrj6Wuog08KMiNB?=
 =?us-ascii?Q?bX5QUxC4MQw3a9FSH6TyoEpoqDUFevPzulvRcPBSFqRPtejLb7ZYUzNK4ZSH?=
 =?us-ascii?Q?IGuISIHt//Et4/WXGgx3oADBryhUPQZdCGTKWQL06SZCBe2Bv2241CSJGVYC?=
 =?us-ascii?Q?AIr3WGUXQQgSswYA63JkdKBGtc+sHw5d3Mr2WJOO7soxUG60c3zy+E/0tvbv?=
 =?us-ascii?Q?Wp/YVZinnwJxeDHPIQinHNGxA1uvcbJNazlQCzK1Hub3KAR2SR4xOYBHy9Ls?=
 =?us-ascii?Q?6/4XjO6q67XNiwztyFq4lUk8npPCivBt1SHxIF2C6CYui3hOgZxhFZLT7Etx?=
 =?us-ascii?Q?ecby5H6iqrrU7xiegi78IT7dZsdhaLkoUZXlG4WPfSN48QHHJDSGVou9VMfX?=
 =?us-ascii?Q?JQwdCZtsAbj93VGdq3uV1v0UT6KuLyvxna07P4zkjmqmdvJ7hOMY5n+j1yo8?=
 =?us-ascii?Q?o1p6FS+Qo/OmFwXjJXovuXefadlC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sRNtfqZqa9CT2W6RkQB3epM2EVFs9LtGTxKTwHNcogHOey1QvnSfy9DtjHHp?=
 =?us-ascii?Q?lnpOBU4hkryuWYNCLtHrkOo+iA0FnFsR4W6vEXrTcjF9quKLLJlWL0oXjmpb?=
 =?us-ascii?Q?86rDdfif9I11Yu44WwF4rL0ltvvJ5bVpuoQYcNG5eB3wXUUV1axIUsi96W+5?=
 =?us-ascii?Q?S1cPGboA/5sf/+eyYgU8/Q58DxjSZ6Tr6W3XdBzcFNcpdK8gSUEh+VxMofeW?=
 =?us-ascii?Q?JeQHOVDtRY7UPzpt0KPW3WfUhseJyqyA9NINT9VFAftJbtgbXyfgcdZu8GNR?=
 =?us-ascii?Q?e/i0FkFe5FOLO6TuCN97Jq4tcmLTkLMfyfyANmDqA6Ue90IaX3p8rYIOX16Z?=
 =?us-ascii?Q?2/B/i0xFilAo6dAtU+NmjShz+sgnkGIXno76oO1Ehby2HygokVcYzhzAx+IV?=
 =?us-ascii?Q?EobXIbAmLj6UwvqcZgtJbiik3pzCLYclVmpq6JkqngIhaaRViHfw2Cvu01Zx?=
 =?us-ascii?Q?UgR3Fl/Twpe9tSpztcoUkKxNOt3WevaT+eQCLpZeBj4Bn0zSS4Gmp8zFlu72?=
 =?us-ascii?Q?kjVc8ZuSCblxwz3lbM+2xevk0u6v6Om3DcX5cA8sG+NwmMOCNJDifk1ByHVF?=
 =?us-ascii?Q?N5M3CCs36SCsuK+0pNuYvEdZvCBUxFgXwLjXSwgHHkgDEoOPFJNcumltTWZr?=
 =?us-ascii?Q?x4TqoPog+zMrq4cdhKyicw4oPu737Xal6HRJMryJ02Y0Ur+UvX9fTR/f2q49?=
 =?us-ascii?Q?GPMCwxamo9wx66zwzZ+S1wKK9xEoCc6r6CEF7iRP/sPtvvt0U3GHrKHqQGrV?=
 =?us-ascii?Q?bTn7MkoE/eIhvmBa1BcuHQWIpuuKan/jjWOAbTHSiF4Yy/kQbH6xC1xIUD+n?=
 =?us-ascii?Q?OHMXKHUfJcWQNFwSnrJnfPvBXMHqL6NrHBv32Cd6YNSO7LqGaJBJV75rkeGx?=
 =?us-ascii?Q?8h5Ry/daRSRAr9I+aflCroACSfruuWqgujP96NaohBWTDZ0ALXfpmxIXR2XK?=
 =?us-ascii?Q?2rJGwIFWgWDVd6x404MG3DZcPsUYdjeNVj0Y7vdAnz3XbKjot9v6dafRfqHn?=
 =?us-ascii?Q?ssbQgkiMa/2MFKXstlDzwW7f+u8SNNmw63l57LRpYiEwyyETm3/B9bBLm+Ox?=
 =?us-ascii?Q?GzGKCRNxnO+yIxJSKPRGXYsvg9kDdo5X0TKRNue1Qg6gzgU9VsCNHHJpCxjB?=
 =?us-ascii?Q?oZO18UQ4OATY0CHbLf6+wyY8+wGSN5goKNAC/t6uG8e5OLecCEJW6zECx4Am?=
 =?us-ascii?Q?S9KhroGYKOu3tzycqPGY/xWJutZltdHz+BNYE2srNzBjm4TB8U78w5aqrVUp?=
 =?us-ascii?Q?irN3WjMuvGsym5tAP3oLvteJqsflXa4gQ3IUbFGE/TI5Hxefw912/fWFAz1N?=
 =?us-ascii?Q?R7jrHD8/7Gt7Hx4cSAHRdPUc1g9nVSm5f5P17YEchckqNo6QIg/VnglRhc4F?=
 =?us-ascii?Q?nFMERpub/ca++qsCjbTFvX+m+vfPmHYvnis840d2J1YxKchZ7OzE6G1XbA/0?=
 =?us-ascii?Q?O+JLk1vze1wuGsPTblZiidqCVi7WqGpHPL+7D+1zkfD+k6/0jTKOlGEvjMcw?=
 =?us-ascii?Q?Cbmzs05oz3iz9DSVoeAVByxJsLl6UZnYnNuQWX0vOoOtQGxAe6Sawn8esORm?=
 =?us-ascii?Q?8TrlAb7kwYejX7vKxlbdqI4RxTUamFxVt+5SPNRzf+JADXsvylId2DM2P1dl?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54633492-e269-4630-0a29-08dd5ce0b272
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:57:09.4313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hyo7DKGn7WC81PzumZhMEjf7YOXZuEbz6nq8BV4edH+eRi+TwJk3CaIPL0fjjsbfCl6/j/Ljb0QSd4BJMGyq0dCxe5wu0Fx2TQmYja5Qoro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Often a parent port must be determined. Introduce the parent_port_of()
> helper function for this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/port.c   | 15 +++++++++------
>  drivers/cxl/core/region.c | 11 ++---------
>  drivers/cxl/cxl.h         |  1 +
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6a44b6dad3c7..25eecb591496 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -602,17 +602,20 @@ struct cxl_port *to_cxl_port(const struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
>  
> +struct cxl_port *parent_port_of(struct cxl_port *port)
> +{
> +	if (!port || !port->parent_dport)
> +		return NULL;
> +	return port->parent_dport->port;
> +}
> +EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");

Why is this exported? All of the callers are within this patch are
within the core.

Also, if it is going to be exported for modular callers it should have
"cxl" in the name like all the other CXL exports. Save exporting it to
the patch that needs that.
