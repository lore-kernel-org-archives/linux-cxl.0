Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238333939A
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405668; cv=fail; b=clXt4yhUJ9W9K9dZyZcNovCRK6xlIuC9QlKGurFWuxa453pDMP1v4o7dtpo7cc6g2WG27QhU2aOwI4m0IECqsKzfsTIr7bgxgWbJkZF/bLeCJHV07MwZ9JDybDgkfLWVTWrI2MVbz4NCjetUo0yVu5TAELwa0HbHOVUXQ3s9Bks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405668; c=relaxed/simple;
	bh=TAb9EE8kd2tuuSL5Bx0a4jBMkuae6oTLGl2jklIBlQ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=crYgWJEcUxsgUR9UVX4ZGbHrAzpS6eT7kjAo3MnPyYbXgaE6zmCLLEQ5IfYq3fcFdq+GFzqPYf0+7duQsQzggtI47qf0Ad2yYdHfjysFBDwqDsIEY+ooKIVGBO+bcBPAL6kZ9pDsF78pTl3aO3v0FdVzPDXdLI02lA7aVWkaJgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiQp6a0N; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiQp6a0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788405666; x=1819941666;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TAb9EE8kd2tuuSL5Bx0a4jBMkuae6oTLGl2jklIBlQ0=;
  b=OiQp6a0NmcpfFB0rz/vk+Jg71Fmzv9eJip2PZrvMmO6uY9sRdd8hfDss
   q+6i5r+aO99A/a0NItUhhg7bFsmVvDzDbNIJRkte3RkeZaoapF7Ck2r6u
   mYFzUQiZwIyggXwEmBkgOX/A9b06VcR26sG3OLmxeW3h931P7DqVYwlME
   lPoAJ0Idf3IqYJrTdKnRKaGcDUl/fCdz4UmsVs95uaBu+jUNeY8BZn3rO
   yMJN6Xa8MT/ktViWJ2kiACrgtiS1PbWA1X01rPWG/5j+ZcECUg9cHu5dF
   a6QWZCL9vT60Ky5VQjJHTjm7NTyNmam5vv4cyzS68VeqZ19peg5PVzSEy
   A==;
X-CSE-ConnectionGUID: BqpbYbP1QMqBwyEOMfqOig==
X-CSE-MsgGUID: M93RcPBQS+26D+mWygPIMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100391172"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100391172"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 20:20:42 -0700
X-CSE-ConnectionGUID: GfsXoeQNQeC1etKfvk/Snw==
X-CSE-MsgGUID: LpfYvVaZQGqTNKopDwPK/Q==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 20:20:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 20:20:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 20:20:41 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 20:20:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ycls5QVgS5jZWqzoA4Ic1oY2+ZJEbhVz/4zcklP9WSHZaUNpCwoataFEn97VPRXSaVkevOXOydWx/KyrhWqzBHrVd3tjGDZiPpt2X/x7ENAKaEDbeltu1DzFKFOyWCHSXGuYId+jvkV3Jhxva4nd2vQAzoSckZ+LiEYGyluWwUXYZbOHmT/lxLLHC/PqtTnNItsBcOdliW5Y1CBZvNUefMxI2gMTtDeyw6AcJs3oKTZk7ede0paZWQacAmmPSWtv1EolaCrKqLPqKXNoHduiypAbz6rIsR5v8H9bqmO3l2F/jizcIfj6zHFnzDS2Ma3k40oE4K4e6jEoDzQXiS6Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2Ph+KaxnvAWneaLTPh2guZqahiFfabdYYBYIC6r/9Q=;
 b=vUMIKJjdJ9L/pnwltBzXi5woslB1+GnmRbYxMmO9b6hS2aR/wAkgxIeYm5tFSVAdL+B+qHqpGmFq/LbzL8q3iirx/puu7ghhRi3YQfmok0TifEmJXXgkIfBAGGyKftgIchEVC2L6cwj/OzKwvRv1IF5a5G1IrT9S4YwnD8WjHlwBKr02vCf4Zfi+vg/08ZKVa2POt+VbQday6PN2Lpfwf5cnYMgrBydoQE1f+4ut/IOdtMHjiJq9yYRMOyCc3Xa7coyhNqVkQX4lgSP36L5tWIl3RagnKpuw5CfcOhybLVbZSWX1+cZrjN0pzqokhuUm95TAkIJAgiuxixhK6ML4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB6695.namprd11.prod.outlook.com (2603:10b6:a03:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:20:33 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 03:20:32 +0000
Date: Wed, 2 Sep 2026 20:20:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] cxl/test: Add a topology to test
 mixed-granularity regions
Message-ID: <apjnfahmu4r5zLaI@aschofie-mobl2.lan>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <dcba06f559a891950910348418b415aa614f399f.1787255388.git.alison.schofield@intel.com>
 <20260821230759.209cd190@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821230759.209cd190@jic23-huawei>
X-ClientProxiedBy: BYAPR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:a03:114::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e302ba-5464-4108-b5f5-08df096a5037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: ljeriHpkKTcd3r6t72Ju5h6XOCMGY16x3aJVqcOlGOAZ+ZrWfpGboqfll6ZVF/kGNOQYVN2khfvNn7/DAXAhuSR9qH3qQZzZF5Pn195l7MBB5e/HBnSwP9Ng0yQMiv+0yamlXeOs/cAF8IvJBj7zBtpRakgfWBZCm43yNaR3h856VJathElH1fbADUUz0OZVebZPoAokZJVl4g1HRrMQ65MeflZZA22x7EDog3DOXJJmJk0+U7yr3oXwhBV9jpfVK+MxOhIo2LvpQcyav5mpVHX0ileoKShZooWttnCHJGjgt6x18rtMvwnua5GuqrCQDCTQphhHSIWQkzPBMG1SKgyoEuSzdiSwIXnFgE680oGc6QFn63wqvohnKh3930n3+7iFkhYHeIU57hnGXUxSsrwngoW2RlL9YnQVGsI+Sug+66g2fI2yYRpa7hx4jCrynxKOm0BuuRRgUscI8yxbDtwOc2qnBcUlk98R5g3XB6G841TWXdEDZKYI4FcJVBL6uYUoD9KKkIomx4kZ8wJRpcdeuh1P9iCkQICjVLrDJIZ9IjEVlTaYKuFHk3Pp5boSPo1rMdGyHUMEiBQXkWwp/RnulMgIVPrqpsyZxSIq9ToQnQ3Btr3HiZq5zB2Ai1fKZmFBEw3cciuA2m+1yjpkQef70+2xy2tQyavNTUdvWqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3xEjTotcSgAK/CYNTRLgEe7X7LgkRmR92Id7lAKo9lvEnO36tU+zJBVOVZu?=
 =?us-ascii?Q?xVfjhD7Y50qKJHf8qpdDzvvz2xi2qAm2S9hMrr1Bu8S+uE/rUMBL3wBQCluJ?=
 =?us-ascii?Q?gpqRQ/YlOGfnbHCT9kTSZ+yVLCCRjkwBu0WtJTrgCtK2E49vToINhXH9jkeh?=
 =?us-ascii?Q?JQhmRN76jhrNmv6etLW9tAhb056qHVLFmUm5fGnLUfIj66deZWUTtdW5D86u?=
 =?us-ascii?Q?333G1riwbIRlp+3TmkGNDrH1A/oAhG6jUVxrzxIV6VGurEbGCWpveH5Rlfx6?=
 =?us-ascii?Q?/kGTr9tE8E7RvExwI83G+KUS6Tg27lv+J+b9cv+5axm3x6H+BQa8Zp7MdTR5?=
 =?us-ascii?Q?XVxlCaNcSkiC/6W7vxnpEPfN2oTX1JjDFpqX65TUdROZV78WofVPY2eTKoxT?=
 =?us-ascii?Q?xtXzcTdw4tRkMX7YMl40fQ+mDa7nOhbLNUJiotQSsXwdhBvi8EtIN6JUOQMv?=
 =?us-ascii?Q?D5D+2E+F6XQCdtkE+L9vop38ZlRwJaMWaYuLOgnZveUc+UtnqiWpJg1ovKy2?=
 =?us-ascii?Q?f95Y+UL9A1dKbyjRT/K99AekW8GvKbrZ2m791SUTI99tHdKdwLjBf6ldz5BL?=
 =?us-ascii?Q?xymOvVBorg2BXBLa79NaUwYfdzKJlFHxS/5cySrlwadB8H7fcseneByuv6Ft?=
 =?us-ascii?Q?Bem7+O6syJKSVyIlZ3B5Nu8Rs8LsO0xlXAI3fZaFhethzh1K2r5wVb7t0txR?=
 =?us-ascii?Q?NkTB/o/QgLslm/uJkxlM7UI910LicejpQlBK/Bbuur1NXXOuzRwV6BsZiW+2?=
 =?us-ascii?Q?7yLi3lbq0vw7+wmdb0jYg8ssosOSRSLlf7AZHMk0t/AXcDbY1VD+0EV1IMsX?=
 =?us-ascii?Q?GzHGf+9K/zXCQ9FM11zRsIyacOZCPkM29TjzDAca6mmMgSj2fOdydAk8GC2g?=
 =?us-ascii?Q?zUoejjudG6FUCCn89T71qRSceyLFpu4PE+k+nhecVRbl0Ge/AIVYEDaZ3vn+?=
 =?us-ascii?Q?1APO2FLX1szPkvs6dII2CbeqXl9/moTTy//jHwzFyYuANFTWiuGGHItCZrG3?=
 =?us-ascii?Q?JCgPYAHZjD/EUT3hR1zim9okfBI4FJGyLvcbFqjN3Mz4pIrTYpgHVJNGZGSj?=
 =?us-ascii?Q?UanUY7PwudRuRpscV7Lpnnlqi9NCsT2uGFQmcPRTA890Ir7Ctu3GY/NNI7Yg?=
 =?us-ascii?Q?naBaGAdNOhfEgGF9cgpwTVxlODxWOMK5p8Xfae65aiGopMNCsE+tPCaS3z91?=
 =?us-ascii?Q?SEzEIlmn/nYau6AQzi1AobGnlD4MYTYEGpx2oezx2mI2IS8FnyldjZpg8agI?=
 =?us-ascii?Q?L5Y/wRYOg8g1z/AnQl325KCpAmL2HWy+FkqdHzxpQVloVJrQr3o0hq88gelL?=
 =?us-ascii?Q?NxzHOXyTR1sM+OeOjpPIRg2uWNnqApdyKK4U6gzCnPUAfEG0gKKSL8Ud0iq4?=
 =?us-ascii?Q?j4PS/cqFTlIpEedogpZ6DSjdblp1XLk+8b9n5b4jejbUUaB7sUveXaXzheKz?=
 =?us-ascii?Q?jre412LgJBZ90L0NlJPPRnz5LT0SfI19UHkHxuyFTwRg7BOyCSWkhtLJfpcP?=
 =?us-ascii?Q?TkFrRYrgiAbeyh+xBGhWb231YHu543xm+5oryQlhdn0df711FddI0JvIntE5?=
 =?us-ascii?Q?Xcw7cNM9VwdI+iYNmNLxJlRY8EwfL7zlMx2lh9s+YsaLvJO169QXBi1c9/6a?=
 =?us-ascii?Q?ntHFncVhDD8ssVgAk2rdr8BmkNw3DwcURnSZXRT90W0RafsapVebUI1y20eB?=
 =?us-ascii?Q?vEEQ3NyVHQmf/NA/j058wD3IxPWGW/OvORia91kN6EETz1ut2T26LA6cPcUX?=
 =?us-ascii?Q?WiKncabK56Z8cvUbmg9kQvxyPnvNV8o=3D?=
X-Exchange-RoutingPolicyChecked: OO6ky7+mQzyKabfI7ZmEJga1hT4tZOC5qYytDlGHk9+DD47wNQKtSRt0m53h/ab+PJcgyJlhl7x3G6pEbw/6HaRTnGcW11Yb/BomsZUbOu0irosg+KSYZAlXubEx/cphzyV8xh7vJrziSL8cQFc3XUKTM0vRVCZOgIflRV8T1dKavaXj3XuU3JX2zTa6iZsI0D7I8mrCPxunwP0/5+/5o3cmlfEmDpvC5RqaZ3Gohb3I2B8SaWZqHi4dXwXis66uLNT9gLY7/3g4Zgzt7oPkLc+i2vJkosj6JKKa29Bb9aEwhx5GjgzgjS0E6w7mThi+D40mQ13QEuwMjnSwWB79cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e302ba-5464-4108-b5f5-08df096a5037
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:20:32.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeVcM4wW0dyEcGRzVR4zNZh13JPMlF2oRw+o9d6ynhzCJ1J/mhAP5E/BIJDa0svp8MH+Gp0bNE6xfAMyly4rb4EqmWFM40kv74pNjBEFUCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6695
X-OriginatorOrg: intel.com

On Fri, Aug 21, 2026 at 11:07:59PM +0100, Jonathan Cameron wrote:
> On Thu, 20 Aug 2026 16:31:23 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Add a cxl_test topology for mixed-granularity region testing.
> > 
> > modprobe cxl_test mixed_gran_regions=1 creates three host bridges,
> > each with a passthrough host-bridge port above two switch levels
> > and four endpoints, for twelve endpoints total.
> 
> Why the pass through HB? 
> I queried the 2 levels of switches in the docs patch - maybe
> you already answered that (I haven't checked just yet)
> 
> The spec examples that do multi level interleave are all cross-HB, HB and
> then switch.

Agreed. I reworked the topology in v5 to follow the spec examples:
cross-HB, then HB, then switch. The extra switch level is gone.

There are now two root ports per host bridge, with one switch below each,
and two endpoints per switch. That still gives us twelve endpoints.

I also added a third CFMWS so the topology can exercise a 12-way region at
256, in addition to the 4/8-way and 6-way mixed-granularity cases.

-- Alison

> 
> > 
> > Two CFMWS windows are added:
> > 1) A 2-way window at 4K gran over two host bridges, that hosts 8-way
> > regions at 1K.
> > 2) A 3-way window at 512 gran over three host bridges, that hosts
> > 6-way regions at 256.
> > 
> > Both windows also host the same-granularity regions their ways allow.
> > 
> > Register every mock device through cxl_mock_platform_device_add() so
> > the mock array is populated before platform_device_add(), matching the
> > ordering the rest of cxl_test relies on to avoid the endpoint-probe
> > race in commit d90f236f8b9e ("cxl/test: Update mock dev array before
> > calling platform_device_add()").
> > 
> > NULL-check the legacy topology arrays, which are left empty when
> > mixed_gran_regions=1 selects the new topology.
> > 
> > The default and existing special module params are unaffected.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
