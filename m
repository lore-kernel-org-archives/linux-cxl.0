Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712C18EB3
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jan 2024 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164437; cv=fail; b=YIGxHVzCaCcAr1cIym3M4Ust+Ekc7/LVqf4CjzFW5YIo1xK87i8V1QulAKiQsVnsRJNiMfhGvF37mxdrjRjqm2HUkTy9GVoo6E2XmVUP0nXMPSWmGusuxasUR/YiXDZiWJYe/JHN72g0pQDtYMOx01qFrnXIFagB1BL5EFeYd90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164437; c=relaxed/simple;
	bh=1AYMR2EgYVVvPvjsZPLYxRlauXdH9wn8geE7JgKkN54=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c+fna/DUNPAAnQRfXYR/fRBekRcaUvl/3aQxUQEE+8V5SS+J1s0ekPaEmMr9Sy/xz9fmfMIxhHJMka0qtbg3QlpK1lZ1Q2UM2nw15qBV2rfgADpFuNCBmju5WA+FFCtPd4f9TasuIbo8IaCE/PjT/m8Y2ZHEIyQhThZ8en48SIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9NW23AX; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9NW23AX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706164434; x=1737700434;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1AYMR2EgYVVvPvjsZPLYxRlauXdH9wn8geE7JgKkN54=;
  b=Y9NW23AXPmnn8C/qgMnqkGa/vKFwLXX8iNCJWf6v/gJdExT5bQr+huVq
   HRBFWo9bZWWVIGzThbffM6iHQ6+UunCqItLitLhtcheDc0JTLcxNLXsiK
   lD8tNW1yW4aXxq03vJWiIftye4Aue0dgSwFB2P0bjEbK6TV7BpCWicM/6
   xIFX1jN3eXYjW2ls3y8zMUXu6KoARNjHAPBDIE4B5y8Ot/4vdGT48Rwr1
   AOeaATeBRAegBTt67OZKk1geOM45klSxmHZbm/grhRfxCSLbNPC5l+MqX
   Pg6GIaCz5GHrCxwAhkNIL9IuwUBBwwGuVQauR6elLsaWKHqLhmAN5h/ML
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="399234509"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399234509"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:33:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="856967815"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="856967815"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 22:33:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 22:33:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 22:33:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 22:33:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnkaY3BVbJgOK1lg4s2H1WaJjjHuS/hPEQeunbd7jkQ3hxKZCpDD/47SZEUOD8KfdA5hP2NaJpRaio2szhbZERtRBMyFIe2CpwtddThEYGHRnlXb1EySg+StsXDo6knVjZgm/WJF3l/w3G+xt8ZpyNdgiK7/1O/+gCy/m6xrvPIRPZXxQeeiMSfXiHdzMsGibZ9p6Vxp03Z1gMnwENqyZG0ApuGa1bpoU+2EZUGjfvZtHFGLi6tvzLc9A458sX6Lk35+zxihJeeXwZSmO81KWcPKW1aISY/QWaANThV++C8EkGv9/n3azRXp+NRuBYVINOhRd99Q7laLsz84VO/7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuRbE0r0q9RuFnrfBCjEoBmfSBkRtcEuLUlhifSoUh4=;
 b=m9tTrpKP9jcGTfT05YCnoVOoitixJtijXGzvQaFS7eM0NXSkgYAVZoGbvrUexZc+DAV3HGngtwXiuOM1/DmLMqJD+YzYnrFb8fLJk2ByrDq7u4/wseoU8xnMlPaH531mKISXaLJtVplKxG9PCy/l99Ix6Jhz0QY9RFQ+MdZnUuTeWLe8TYZ4ZG8XFHmQkHiTsb0+umf0L5eG+UaJ/cwy0hrZmVFCyUhnyQmdoThpxMhjgyvqNcnNIgSXdLEvFDBNT0D/jsq+6nTaoqPk2f96soQBoI4FyBQWBFmwSkHIntk+iaWz18TSi7N1ZjXWF1wudiX5rT0mz9shnzCMFgsMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 06:33:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 06:33:32 +0000
Date: Wed, 24 Jan 2024 22:33:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<jonathan.cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH] cxl: Fix sysfs export of qos_class for memdev
Message-ID: <65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170612211746.2737788.8759299841309402825.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170612211746.2737788.8759299841309402825.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:303:8f::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdbaec0-b4fd-42c1-8646-08dc1d6f8cee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEBx5rQGq/OGr+kiKapIC9tZjTPunUvh72o6DXDry2thRF+1/wld5l9LWaCExt1mKhTAu+SHCUfXLecfd3bVX0WDkQSQeLM760NdKWCewSY5pBkuQvzw42btMBmMka7yiVLFsjRSpFugier5FhoQmqsQ3uRWqX9LVpT9UShV5qJsK7MszVPr/USE/S97hUJ5c+tFGHulHDQEJhyQNQEa7XoUd/LI3d59jBzLGGHAvEw+tCj/+0ayLXWQvea/AR7vyYFVPdGyFEF+LrCDrWnMglW4JUaqphlihj7pMwldGta1CYlSUSScL+ezPgCYydn1eNEBBp/EeaGPDube064Bpgm7fwSK6VJtNHCa2l4sLtAEnepk0+v1FASMdwWFL4hQyeKqs46mBvclrYQIKFcANYvZmTHc7tWNVS89woeZI/c/ipG1PqDrZkiiSsTkhM0vW9Dq7H5Sn5EPBqwELH+OvQDBn3VJ7dZIkpTHh9lHkd0Q9af8NfzzjIaXOyvyCL0Ivcvj7rjz6P8nDi1jP0shrf8WG0aVLFc19drODDGQD3Y+3H9EWWhmt4Ae0VnZLF0w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8676002)(8936002)(4326008)(83380400001)(316002)(41300700001)(2906002)(26005)(66946007)(5660300002)(86362001)(66476007)(66556008)(82960400001)(38100700002)(6486002)(9686003)(6512007)(478600001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SIvAPydQuzvL8LCabhouleDuLaMYXycJcp9beYxKuo39N4+wwzC7pJP/JIOF?=
 =?us-ascii?Q?Frm3YXl9C8Oz3ribbzJGLiwIc4N4/rEoKhXEwFrfXjsymTrwzpw7JuLBOw6F?=
 =?us-ascii?Q?/00QTtYtbfJduN/bOTvzqkvwx8FenpaMXzc4UduH+ivCBy6E+KmV400oYWCC?=
 =?us-ascii?Q?4mMoxYY/xs2Zgh/Wcv3GFFO/MZmkBbYVentLQS0CIYtkvqN3B3uCYjpuzu0D?=
 =?us-ascii?Q?ElxhEhJJro9d3zLmwsEbLPxrmAjVx3n5HX1G4+6jOBb5m8cHFR3SFItkU1eX?=
 =?us-ascii?Q?qlx1KMl9c5gvGg+JDDlrOjqmBOMj4tZ1KL0/BoumouGHK6NTKAMap2Q9bRn5?=
 =?us-ascii?Q?JhacKL563dAexXtdLsmpOTjH3HmZJupJ9n8Y4iHh0IC6xkp8VmwTKJ2xz2Wc?=
 =?us-ascii?Q?9CRrCgIWEX6TNqPs+00PwYWTjFKyeYT9kl1prGaBkQHZJBiAxP7cCTBJDx6w?=
 =?us-ascii?Q?e86u+lGJKvTe5ts5J+K2vFrDcOCOem+H4JhwWfU07GKNLtg/UBz/4uA2mLpb?=
 =?us-ascii?Q?U+zmaB6+uVeMhfIe9rILyr9ATu6tXEqmqSkaexnghM77wKnZaLSWK8APTGMy?=
 =?us-ascii?Q?Wr+yO5xbn70AN5tCYf8+XkCkO0GiJmTMkRe8tc2UUU8obYjKAoM+ztu8Esuj?=
 =?us-ascii?Q?7RuTNztlNcdQkIG+GpBvlYGSJSulrA7KRNA5gzSYD7oAkZg7T72pFYDqx3d2?=
 =?us-ascii?Q?T1D/fcHImQDO4CNpkBEzmbw++9N2P+80JqCv5aaYbqs6bUVQcozcRK4tN+hI?=
 =?us-ascii?Q?Cq1L90TBj1EcZ/dQyY+lKx0RitYsBQ6H32f08Kho0NR+d4gn7xUm4TBxWMaB?=
 =?us-ascii?Q?yfpx43n/cCuGFUic7gEZdYySnDwtxFsJyp233H9eMMaXIxYwxBTKqJ48pF7H?=
 =?us-ascii?Q?GZ6GcFmhW69xFYSDgRMOYZzco6JkCa3gPSBgj8XvarGc6woc72Do+/H6oDDC?=
 =?us-ascii?Q?HbSpQ4X253Bl6nxtlZbzmXH+jrdPjQdP7JTuEfYbX8U/r0pvMRGvndt5cHiW?=
 =?us-ascii?Q?/3i6q+JlPWEM53yMKUUPG/w38DZBePDVf5aU5eqHtedH2UhfYOXrPZp/Qgo1?=
 =?us-ascii?Q?Ck4yp7pAcWCL4RmgG36KmeMDdRAJnwYJ2HUwonTdAAiSfWERec4bCnYGM16O?=
 =?us-ascii?Q?igebumUTXTl1XNLQEHMvQBa9itKmp7FC6EuGnPpZ80ET0l3lP2RLMx7NYN+2?=
 =?us-ascii?Q?K9yGkkLpUjwcV5r8bXIwwT0NAuP4o21uzyM9ZaQFhNTv/jgWZRQMFRYvYUag?=
 =?us-ascii?Q?eD/SfRyA8SLqcyDwxY3ENnznjVxoy4Ck70QhFQtklO6uLsBKcM+7e9OqTLRc?=
 =?us-ascii?Q?da0uOgifOiv/baGTXbuNaLPMd05BXyUPiXLzNCx8i4OaKnPzSK2papLs4YIA?=
 =?us-ascii?Q?6tiCXfDj+cpgruq3ffeMMY40+K0OV2YEaSe8ma/3WRTgvdR6ElVSSuCsyaj0?=
 =?us-ascii?Q?nyCKFyEF1XPjXRxbgAmnU1rjppPbuBtarzBj2999d5bpTsyjhWMXMP6nC378?=
 =?us-ascii?Q?CjD782RDKywbdkiGyXQJ0pMg2zzgcHQjYZYgARKJj3Y7n4SCa5ut6B/4heEP?=
 =?us-ascii?Q?Ub1FwSrkTbXNM+xLoZ+qy4V3kmwBOeM8qU1eVX+RbIsC8TsOIkArtfftxUy/?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdbaec0-b4fd-42c1-8646-08dc1d6f8cee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 06:33:32.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2YrU9B02rUae4AP3dwMChvvft+0/JJHAlTKMZTtIJYhwEXVdRUtkESYJTJbViiy7ZPG6os9FZqHoRm2TVzb/aFUjhbUqZX2jwi9MfYnELA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Current implementation exports only to
> /sys/bus/cxl/devices/.../memN/qos_class. 

Documentation/ABI/testing/sysfs-bus-cxl says they should be under ram/
and pmem/ but I should have required a cxl_test verification of that basic
detail. This style of ABI sanity checking is cxl_test's main reason for
existing. Especially for scenarios like this that may not exist in
currently available hardware.

> With both ram and pmem exposed,

Luckily this is not a common occurrence in the wild with real devices,
but the amount of fixes needed here to make the implementation match the
documentation are threatening to be too big to fix in a -rc. See below:

> the second registered sysfs attribute is rejected as duplicate. It's not
> possible to create qos_class under the dev_groups via the driver due to
> the ram and pmem sysfs sub-directories already created by the device sysfs
> groups. Move the ram and pmem qos_class to the device sysfs groups and add
> a call to sysfs_update() after the perf data are validated so the
> qos_class can be visible. The end results should be
> /sys/bus/cxl/devices/.../memN/ram/qos_class and
> /sys/bus/cxl/devices/.../memN/pmem/qos_class.
> 
> Fixes: 42834b17cf1f ("cxl: Export sysfs attributes for memory device QoS class")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Recall that I was dubious about the list_head usage and the hard to
discern locking rules. This patch pushes that over the edge. The old
locking model was that the lists were populated under the endpoint-port
device_lock() and the reads of them in memdev sysfs were gated by the
fact that they were guaranteed to be settled before the cxl_mem driver
dev_groups were populated.

Now they are moved out of that context, even that undocumented locking
rule is violated. I believe you can hit this race by a loop that does
cxl_mem bind/unbind while reading the qos_class. Even if that does not
trigger, the locking here is subtle and non-obvious which usually means 
broken.

In the end, only the first verified 'struct cxl_dpa_perf' instance per
partition matters, and *that* is what should be stored in the
cxl_memdev_state post init, not the lists.

Have a look at just caching that see if we can make this fix small
enough to be -rc material.

More comments below:

>  drivers/cxl/core/cdat.c   |   12 ++++++
>  drivers/cxl/core/core.h   |    3 ++
>  drivers/cxl/core/memdev.c |   86 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/mem.c         |   56 -----------------------------
>  4 files changed, 101 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 6fe11546889f..a47dc4102140 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -395,6 +395,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	struct xarray __dsmas_xa;
>  	struct xarray *dsmas_xa __free(dsmas) = &__dsmas_xa;
>  	int rc;
> @@ -417,6 +418,17 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
>  
>  	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
>  	cxl_qos_class_verify(cxlmd);
> +	if (!list_empty(&mds->ram_perf_list)) {
> +		rc = sysfs_update_group(&cxlmd->dev.kobj, get_cxl_memdev_ram_group());
> +		if (rc)
> +			dev_dbg(&cxlmd->dev, "Failed to update RAM QoS group\n");
> +	}
> +
> +	if (!list_empty(&mds->pmem_perf_list)) {
> +		rc = sysfs_update_group(&cxlmd->dev.kobj, get_cxl_memdev_pmem_group());
> +		if (rc)
> +			dev_dbg(&cxlmd->dev, "Failed to update PMEM QoS group\n");
> +	}

Setting aside that this does not need getter functions and can just link
the attribute_group symbols directly, just move this logic into
memdev.c.  I.e. create a cxl_memdev_attrs_update() that just
unconditionally updates all attribute groups that should retrigger their
is_visible() routines.

Note that this needs to be retriggered on the way down to make the now
defunct qos_class attributes disappear.

>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
>  
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..44958be2178a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -90,4 +90,7 @@ enum cxl_poison_trace_type {
>  
>  long cxl_pci_get_latency(struct pci_dev *pdev);
>  
> +const struct attribute_group *get_cxl_memdev_ram_group(void);
> +const struct attribute_group *get_cxl_memdev_pmem_group(void);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index dae8802ecdb0..5743c6b2710c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -447,13 +447,61 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	NULL,
>  };
>  
> +static ssize_t pmem_qos_class_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_dpa_perf *dpa_perf;
> +
> +	if (!dev->driver)
> +		return -ENOENT;

This dev->driver check was pointless when this was a driver dev_group
because a driver dev_group is only published while dev->driver is set.

Now that it is moved to a static memdev attribute that check is racy
without the device_lock().

Side comment, -ENOENT is a surprising error condition for a file that a
was successfully found an opened. It was not a problem before because it
was impossible to trigger.

> +	if (list_empty(&mds->pmem_perf_list))
> +		return -ENOENT;

memdev attributes depend on information being stable before the memdev
is registered. This attribute violates that perf information is only
valid while the mem driver is attached.

I am thinking that if cxl_memdev_state only caches the single qos class
per partition like this:

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5303d6942b88..9b4a26d3acf8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -494,8 +494,8 @@ struct cxl_memdev_state {
        u64 next_volatile_bytes;
        u64 next_persistent_bytes;
 
-       struct list_head ram_perf_list;
-       struct list_head pmem_perf_list;
+       struct cxl_dpa_perf ram_perf;
+       struct cxl_dpa_perf pmem_perf;
 
        struct cxl_event_state event;
        struct cxl_poison_state poison;

...then this attribute can locklessly do:

	qos_class = mds->pmem_perf.qos_class;

	if (qos_class < 0)
		return -ENXIO;

Yes, userspace can race and see false positive good values before
sysfs_update_group() can hide this attribute, but I think that's
unavoidable. I think false negatives on the way up is precluded by the
attribute being invisible during that time.

> +	dpa_perf = list_first_entry(&mds->pmem_perf_list, struct cxl_dpa_perf,
> +				    list);
> +
> +	return sysfs_emit(buf, "%d\n", dpa_perf->qos_class);
> +}
> +
> +static struct device_attribute dev_attr_pmem_qos_class =
> +	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
> +
>  static struct attribute *cxl_memdev_pmem_attributes[] = {
>  	&dev_attr_pmem_size.attr,
> +	&dev_attr_pmem_qos_class.attr,
>  	NULL,
>  };
>  
> +static ssize_t ram_qos_class_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_dpa_perf *dpa_perf;
> +
> +	if (!dev->driver)
> +		return -ENOENT;
> +
> +	if (list_empty(&mds->ram_perf_list))
> +		return -ENOENT;
> +
> +	dpa_perf = list_first_entry(&mds->ram_perf_list, struct cxl_dpa_perf,
> +				    list);
> +
> +	return sysfs_emit(buf, "%d\n", dpa_perf->qos_class);
> +}
> +
> +static struct device_attribute dev_attr_ram_qos_class =
> +	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
> +
>  static struct attribute *cxl_memdev_ram_attributes[] = {
>  	&dev_attr_ram_size.attr,
> +	&dev_attr_ram_qos_class.attr,
>  	NULL,
>  };
>  
> @@ -477,16 +525,54 @@ static struct attribute_group cxl_memdev_attribute_group = {
>  	.is_visible = cxl_memdev_visible,
>  };
>  
> +static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (a == &dev_attr_ram_qos_class.attr)
> +		if (list_empty(&mds->ram_perf_list))
> +			return 0;
> +
> +	return a->mode;
> +}
> +
>  static struct attribute_group cxl_memdev_ram_attribute_group = {
>  	.name = "ram",
>  	.attrs = cxl_memdev_ram_attributes,
> +	.is_visible = cxl_ram_visible,
>  };
>  
> +const struct attribute_group *get_cxl_memdev_ram_group(void)
> +{
> +	return &cxl_memdev_ram_attribute_group;

Could have just put &cxl_memdev_ram_attribute_group directly where this
is called, but that's moot now with the cxl_memdev_attr_update()
proposal.
