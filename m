Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4F53370
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000045; cv=fail; b=Az2GgASG/hvll8GgOziMqrUMuo6aQhB9VJY1vkp9g2/cd9zDF3R9qIEg/Z6ssROTsXuf8U1jt+J4A8OzJmQU8OstwN9jOIF+tBDpqYTfvVuWsA8jsfQ4CSp+l/f1WGFY8qtQxTG9a+e3qPJvluVfcWz4MfWMteJktSFbOgHUalg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000045; c=relaxed/simple;
	bh=xq/HZLmMKePC1YhvT02pery+PsGbcUQkZvdD8RbUiRo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n8YmZXUbqnlZdYsrNMst8zqKM469wB5OOPpFTYK+V2fR26yFONQ7k5cg5YYksjmL98Mt2RJgoJiMk3OGl0r/oTAQoUMwehrlMh/tOcIGHjSf+Zxm+DtCXKHdmXAeIkXnsYHyrxLeUz36l2VRjJek/GClzne5PalaWvJHlIJgIb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENqxciDR; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENqxciDR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712000044; x=1743536044;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xq/HZLmMKePC1YhvT02pery+PsGbcUQkZvdD8RbUiRo=;
  b=ENqxciDRQc+r/FtHIUeq/1Zqmx29pjgxn/IzoO7b8OwkvPCb2yiFnNij
   PWEGjhhbqObIoj4MkCL7ucuRC7/oGl1MoiGqLGh6Uii8zfz6sB+2z7QWZ
   Vp72863qiVWMdlfMhaviONl7cwx4GSpkR3FWS1Jvbe0cIZug7Gle25l/r
   ZIAi72WmKK4N+XTZrNqK05JDMyMTRUfaaz0C8IrBE6RUcXJaQ+UiAR6ZD
   jH0WRMeT/c7V8W5B3XOwUmZ6/AFCmQRHTLdQk+Qqr6/Y7nQyTQSaQHl2c
   CThrJGsBMp6CF9JVZk1TVlR6HV3TMK6t2AIPd6OHlGgNBLVTLuSwAS2lp
   Q==;
X-CSE-ConnectionGUID: AWHmdqw/RuGQgMmKBU450A==
X-CSE-MsgGUID: WMa0H0PHTt+7/Y6XkKDHJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7353130"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="7353130"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 12:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18268337"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 12:34:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 12:34:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 12:34:01 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 12:34:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPMIIh5Ppb9Lz0/ixVLA17PZN124XYFljx/CraYjYDinLqeEGhnwxP10LbI5ETlnaRtWfTC/NvjsqTeBEgpMTH1fPcZpdAJzjpXlWlKCgS80/5/JHxCO63721ty7uR6jy9xLyjnaB+E207TFTW5eiiEqlWkuBEUYYOXbLzSouTiQqXP3gucHCexbbmUdCsnrn8+p8jgTiz4HQ8+xjf48/rxMHNW6RGcEe/Q6xN8qj2vEq9MsnLt5A2nUiCEdnRZ3/TIi1gu6vTkPjIvNc6dZl9SdV1v1cOaH88DTMmpjzAs9TZlVxTV3PsVQK3Dp3PmyecmqcAtyxkljvI2P3bkmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEDFRyYscsCxCXKpZPTcUO9unXN2ahM1LQD+mQcuCiI=;
 b=cmFF5Nnt6HfEkH5P3t6pCWvwzeHzDarnFVOwf0ND+1STg4vklS8Kfg/zVZigBWspruvqHL/mzmu04mupG/a4HamkN2E1UXdU2C5slDPbBGUNGhz++THzROqoZkTHSb2ZxoTrnLH6MR+mYSuN4HC+upq56srnu+gc2NhA2G3b2PQeW8DXpjLRT+JD6yV+Paj3DDhA/dOSBmTclSScZerVLzowXpsmUiRHx3+hATnQZOZABKcOGfifQwphH1oxtmBKJFsSN/NII0A0vRgw5KmWeemVvh3UNPLwOEadIRc0w1esMqTlZqFsmlU6ve9BvPVIBIoKH8si63qxFHpPTk/TMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8088.namprd11.prod.outlook.com (2603:10b6:610:184::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Mon, 1 Apr
 2024 19:33:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Mon, 1 Apr 2024
 19:33:58 +0000
Date: Mon, 1 Apr 2024 12:33:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v5 3/4] cxl: Fix incorrect region perf data calculation
Message-ID: <660b0c2473df6_15786294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240325230234.1847525-1-dave.jiang@intel.com>
 <20240325230234.1847525-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325230234.1847525-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8088:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Vw0XXj6MR8csrNdVQFp/xGPq7H5PATCa0wVkq3uO/r6dg7om/fEhOcF4mtkZIldwnxcQX3qknLdvMdROxYqoXtvZ9iJAvvN57K4oK9CvDVsHhdJpY54ia1r2iZve+sHMyCK1W75ja2a4/BrTna3qNFlyBTndcu8AlxScHo7VtuJ0jZKU2IVkY/+DpWtdX9zSsBNHm2Tf+aA3i6s/xjeeFFLzpBbMyDfyjPiYHCuKMXA2hb0sagj+GUrF+GOeMm3PhbMUUsKAuEUrlPCA3Z/RSehY766D+LQMnOhFfanR/K5yKPzqJ4IsPIsZgQs+O3sQISjE17a+fnn9QEJ4HBt+4vEygFzRAegjlRlDGGk+VeiQipblaLaTDuv1jiaW+58ZZnMVPbnQX7Ff1iY//5RfqWUXEfxRIlQ3o+S7ERv1op8UV8Fcu2cDxBcFsYTVthC8FMjZVmMgT4aMC59TwctC604Fc+9n6VEYsUWdNEd6Rz3rDBM00rzBIh6AzhhSyOp6+9FwHnD8E2FGV72uCyfC9p8Oom26nFQ+bXRBDfGWZbVf0EsYGzZNeiTjox49gfMPZgOM1QTE1cCNut5S1qYloEY7xDvyqNhArr9VOLah02cT4bTqGtsQEEL5JaOVOkvVOTO0y9C6FGPMBJ9cqKlNMNWOjvvjSG8x55nTTqBQ8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERD82A4/AEisS+UwSvTNW1Z0rPxSAtQ+1rC/iviYCEFqfnyoGzxP3YKn9e2k?=
 =?us-ascii?Q?TsfUSpTcqPSQ2XmndtLNpr7TVKRKezW5EhfhdwnifRfeyaql7cCrDj2fkhQZ?=
 =?us-ascii?Q?32lN6t0aQRdkFbs/sJCuZPjfZ2IsCThWNNfSXWoEDYsT8ay1XXq6QrmE+AaT?=
 =?us-ascii?Q?EVfMY01G/Ignfn/KHkdH5NplLJPKW/a+jx+0137GNvy+c1bMo0CmGDEeAMon?=
 =?us-ascii?Q?t0XlUbs4uUzCCkPoqdOkiSWCqCATnAZMUG8Y9GOF5/p664tFAwsTjusxQelt?=
 =?us-ascii?Q?RS4ppdjXWU+zjBH48mARYgyEFDMt7RcgUzkC7uYlYP9lZWh5sqIhFX2bStGE?=
 =?us-ascii?Q?Qnlw58Wld9imXilk7b0u0R2/dQQhEcN73E5F8PnrwdCshk9r7/h9SKSi3mrZ?=
 =?us-ascii?Q?rxJJcQw3S3RS1FSsga+O4LkNnqJzj5Ox+vNjIFFTChZznE7Zo7jFAJICN+Nv?=
 =?us-ascii?Q?bGz0FuohP4wQRQvtjzxhfdMVbEtAtL8HWKbdDIx6nJY8rGSmDRLws/ijgVYF?=
 =?us-ascii?Q?FXg09w69DgYfEX68/Y0qKpGwfhCi4wtEJvATtHpiTpd0dmtl13U4Dx2ftWmT?=
 =?us-ascii?Q?uZ7jyVEFcfE0sfp/MzssT8snqZrPiYjQnXlrsR3LEE+aVb836VFttlyMOi2g?=
 =?us-ascii?Q?NY6qsD5upoVkZXhtXSSeeFC2Yb+juv0yfdS9Zv1Op0WKNvUPSfivaBO4wMl7?=
 =?us-ascii?Q?Iq6o7xC4nRVTr4oNgzHtaD99cd3DJqvq/uep2Pz0m1fOG/kCCnuOSrdi2tCZ?=
 =?us-ascii?Q?GxT3JPKIp4c1y5Vq9jsR8ZQG3iYxDj4yaPYzt3ACZ13FAi3UMTEEyF59vMUN?=
 =?us-ascii?Q?tjGSDC1jdrvUGz2/wRu4o69ccZ6dHcvHxyBNHssJy0SY04npd7NEUjdg/Z5V?=
 =?us-ascii?Q?edU3zGCLYo8R4+yWMO2aaR5Cuvkixs8Hxaj5LYxZ4mWBil1XQUd/ahbqY946?=
 =?us-ascii?Q?Oyt30Fr0T8yEQ9m1iYqbjwfxKj2DPI0ryqHPjJ1ODlD4pnA0qdXU5uwoDrfA?=
 =?us-ascii?Q?UwLmhN3sWWkSV1tAKEhh2pNp2Giw9zaeoeTfx62tlmVCHBhaYbrHCgrjg9nI?=
 =?us-ascii?Q?c2GDVMOvX1t74F0rI5vZZKJwR7AJHD8IqErX94PBwJfDo+9jC/4JQa91NTw3?=
 =?us-ascii?Q?WmLT5dCKbG1CCRbQIv7spyMkqKiUGvbpw5GY85Y4GOx5VQa28q5EZe6cwU+R?=
 =?us-ascii?Q?bji9NTB+KacRjRVmmW10WiI2aDrHOGKTLsYOnXBfuoNxx3XhXre4pbxZO2kP?=
 =?us-ascii?Q?ETO9jI5D5O7ZILs6pymZrinYF8HJMlDPN5o2t0MQdL+bQkN1QOcUuVFLqdtB?=
 =?us-ascii?Q?10/e5/3z06crvFokhvfG/I7FJAOvRCVsZbSz2exhrb6EHSxLyne5gtl8zDab?=
 =?us-ascii?Q?CVfoOtQeEAed7JVgnWUMejJ4npRCzMYS0uop28iw7qX6arlICWhWD8tBZmrO?=
 =?us-ascii?Q?NeM9C0ykR9AyCNravT5zcwUDAWZ+NPI3FqktFSOD1JwqokREFjNn2nRAcDR0?=
 =?us-ascii?Q?AkymCefuP6Y0S6qKVpaWdUmCXkzCMM7u1bn/9uE+ARuQuhgUmMsoGOEU22TI?=
 =?us-ascii?Q?XnDSupZlSLDkgUMSgoz3ZvFyT0HNkX1eY1qKfMQFCh60rS6HhR+NNiFtuelr?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff255904-7978-4af4-f703-08dc5282ad56
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 19:33:58.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLQSO7pIO0aTmguX54AVjDAxbYMaYIaU5W5lPbRGiN40KUYu1+qSD69UzAaVsf4bbiEaiEtOIRHLuH/LO+A4vxpSfxpvgP9Xcz+V0OYwwZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8088
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Current math in cxl_region_perf_data_calculate divides the latency by 1000
> every time the function gets called. This causes the region latency to be
> divided by 1000 per memory device and the math is incorrect. This is user
> visible as the latency access_coordinate exposed via sysfs will show
> incorrect latency data.
> 
> Move the latency adjustment to where dpa_perf is set and this should
> provide the appropriate latency for the region for each endpoint.
> 
> Fixes: 3d9f4a197230 ("cxl/region: Calculate performance data for a region")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5b75d2d56099..a1b204d451d3 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -214,8 +214,19 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>  			      struct cxl_dpa_perf *dpa_perf)
>  {
> -	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		dpa_perf->coord[i] = dent->coord[i];
> +		/*
> +		 * Convert latency to nanosec from picosec to be consistent
> +		 * with the resulting latency coordinates computed by the
> +		 * HMAT_REPORTING code.
> +		 */
> +		dpa_perf->coord[i].read_latency =
> +			DIV_ROUND_UP(dpa_perf->coord[i].read_latency, 1000);
> +		dpa_perf->coord[i].write_latency =
> +			DIV_ROUND_UP(dpa_perf->coord[i].write_latency, 1000);

It feels like a latent bug that dpa_perf is temporarily counted in
picoseconds.  I.e. every place that assigns into a 'struct
access_coordinate' should do so in nanoseconds. I see how this change
fixes the "over-division" problem, but dpa_perf->coord should never have
storted picosecond values in the first instance.

Something like the following, to match / reuse hmat_normalize()
(untested!):

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index af5cb818f84d..90a7a90ea811 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -530,17 +530,7 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
        if (kstrtou32(acpi_device_uid(hb), 0, &uid))
                return -EINVAL;
 
-       rc = acpi_get_genport_coordinates(uid, dport->hb_coord);
-       if (rc < 0)
-               return rc;
-
-       /* Adjust back to picoseconds from nanoseconds */
-       for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
-               dport->hb_coord[i].read_latency *= 1000;
-               dport->hb_coord[i].write_latency *= 1000;
-       }
-
-       return 0;
+       return acpi_get_genport_coordinates(uid, dport->hb_coord);
 }
 
 static int add_host_bridge_dport(struct device *match, void *arg)
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index eddbbe21450c..d5ba4de97c08 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -124,10 +124,8 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 
        le_base = (__force __le64)dslbis->entry_base_unit;
        le_val = (__force __le16)dslbis->entry[0];
-       rc = check_mul_overflow(le64_to_cpu(le_base),
-                               le16_to_cpu(le_val), &val);
-       if (rc)
-               pr_warn("DSLBIS value overflowed.\n");
+       val = hmat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
+                            dslbis->data_type);
 
        cxl_access_coordinate_set(&dent->coord, dslbis->data_type, val);
