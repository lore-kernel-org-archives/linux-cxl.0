Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A021DC99E
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737066561; cv=fail; b=GC7hr3F9n4a9NDYZCD2681EcAb0qRh5980URFXkmeuDRWa8b9M8L/5P/r/HhlRquR3Fl6barNHjohpngZ3Dp64MMuUgxSiuvjxuMrWiBMRV+6CSWD6lGmYf7FoZWeWlA/LDosSIhhCtUmdytTBkRXy7ICNf1dpcvz5cea0XeHbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737066561; c=relaxed/simple;
	bh=wgYAKJ6XzeieHaZAmvjOEQnGObtMufNNXRerMJKX0N4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TEEYls0SS1OQJkQxaTOvKXT8312zqC/GOlq4WUvDrvZqoZei9Q870dbo33CkvCU19CGMeguIBzYP7GzvcDXjHmwOEFsvSNvpT0a9tQLrl7+sAikGvp8+QapvmyLWb35+veNT0ukp8dqXo1oX+WumlDmzx8h4U/BBFxZ80Db196s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfLNG/gM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfLNG/gM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737066559; x=1768602559;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wgYAKJ6XzeieHaZAmvjOEQnGObtMufNNXRerMJKX0N4=;
  b=AfLNG/gMaLAAKXbW7TkWO1++gK5hU5EX21LVKqRgXk4eP+YYyHWGjuv5
   l4TyikbcG7r9zpfq362nngdwJ/8XFoV/Q/T4Zs9SGsTuDflNFO2hf1L52
   TyMObGtzX1g4TxFnAUhYXlSugwqVfNdoHmzjmy8zFIrDAjM1RL9E1/t8m
   rsV1Zs1Zk0MtQjkrobarLvAW7Yo7m9K51iOXX6Zc/POP8FBFXnBqPoWoS
   icDgMQ28atJwug3LKTowX0QLx0pcbT2SyovKUyvu6BUntnML5FchO3yCp
   SgHO/jbJEtZ/N1a4m0imr5j7VNCQ6Ve/Sc+sxyi3At4QriRkNEfEl+2Oz
   Q==;
X-CSE-ConnectionGUID: FFhjyV77QjmzahkOFgmgpg==
X-CSE-MsgGUID: id15UOxBTG2QfVDqD4Bw6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48479321"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="48479321"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 14:29:17 -0800
X-CSE-ConnectionGUID: jIBvAwIzQGyPjRCvg70V7Q==
X-CSE-MsgGUID: Nk/yJbPlRXqCYguD85reCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105473211"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 14:29:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 14:29:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 14:29:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 14:29:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIL37Bmgb8ttQM/k8/5+eAMLBfInX9YS6uM5ULH/SSNnGzywm08nuUWfkY3YzrwM04n9oQkAEfGF5Mjig9GAaNr1H5BOUB4KlfpiLt9Sx8b1ByerBtpMZLnlwR2EqqwBk1GPsVwI5B3Ra1kk8YbO7Ih9Z503PTlSd1Ure7+S7kLk8xBBvWo+3KwDnbEGr3+68w3M0cQJUbQ5rPcptbn86daj3et2bpVmNJVcrE5mMPtMvYe1u7Ft50atM0xInhyrAA/gzheHN7mRlmY6j0qQyTl3dToXw3UrHTkkwpZpCmCb58w92+XJmkb7nEJ2PbKgBoMP6GnvRCjpnsE462PKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PV/lr7XP5sEbpXfzsngH6GdHYt5O9rPJvYYMto6B4g=;
 b=sjKpMggc+1bvaWZUCtHvMg9zfexbV58Wxx3++bNxY+xv74vyEbx/LQnBv+OqcgEUHTEfqiXiT/tLeFm52xi6zSUGc1U0b1i7V3zgeQ0vSkgop0POffRFH8zwxsh4UFob8Pxr1NS03+jkDOM9FKOTipM/sTkRXAWOIYFdzvtxYVRkWexYfWjCHKRZDyJbV5G5MfUhx3GgBdK2UtUkh2knwwIAUCl8PNPRKgIs6nqCWSPFoBNWu3hxQZhfrWFczc2s2YR9IAJtaoqsE7vDj7xOwmMqX9sApTiszTmUxgmYCs5oy5YhIk46Wrp4R8fWeaYWfgmnbCDAxaHrbNonS8MBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4709.namprd11.prod.outlook.com (2603:10b6:208:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 22:28:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 22:28:41 +0000
Date: Thu, 16 Jan 2025 16:28:37 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	<linux-mm@kvack.org>, <gourry@gourry.net>
Subject: Re: [PATCH v2 3/4] dax: Update hmem resource/device registration
Message-ID: <67898815e6280_1c3f7529466@iweiny-mobl.notmuch>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <9a41f91ed487ea64e187d84fab3bd69a4a5862f9.1737046620.git.nathan.fontenot@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9a41f91ed487ea64e187d84fab3bd69a4a5862f9.1737046620.git.nathan.fontenot@amd.com>
X-ClientProxiedBy: MW4PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:303:8c::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4709:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f1b43a-8f09-49ed-c0e3-08dd367d2123
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qcsU18H4xW9kEj8yDGrCHBQm1JLDaUMfIWX1+9LWI/PlnQAc+PaaaysKVap/?=
 =?us-ascii?Q?4gXLuKHSxAVWLNcrOLC6koZnfLUoaqJOY6PuR4oY9vHicIc3rPJZ/fXR1tTq?=
 =?us-ascii?Q?ffLJcixWl7W0bUmMbMAxB/fx57ZYyUKeL2qvr7uur10DGMWXlnQp44mBJ6Os?=
 =?us-ascii?Q?hEAaxswEbVNBZwHHhrT5OaNwfVX9sfQO5LHehSpqCD/ue+0iNgEWigyuBkVS?=
 =?us-ascii?Q?A79JIqUicUtVrY5KvpFpWE2TePgoe/qwnpookZmZfpZKKBmne5YHweVqnGAS?=
 =?us-ascii?Q?YA7Ve0RsuUQU72KVr9TnqUSnp1l0oNGUhZE5LOpYhh3+wbMGFFTsCtDG/AAK?=
 =?us-ascii?Q?uwQtEbiQWwt5GhDjNcjJ7nJepoqrP+UoYnJF20CqPwMOS45Q256BBIIKAYR6?=
 =?us-ascii?Q?atv8OXMDak92KoiGjvAYNCGrAz3OIwsT5NbxDW0XfC0ekguE9DoO1aiIy25l?=
 =?us-ascii?Q?bWgnNIJJOCx3nLLFSgnLCHGrCsC8/jj10MhLbhAl2aI9uXsjYEeBqyDnfhl0?=
 =?us-ascii?Q?9BfX0iiul99Z8aYxCaZwq1rsbvGLM7sfZP9Hy9wOtHLsYihcDSdMUOHniry/?=
 =?us-ascii?Q?vrN6uVxHKQe7gOrmnhfDhjcC8sXmaygbboD/nnCNSl8tsf5tpZG/6qM1sZKY?=
 =?us-ascii?Q?r9+FYgQGUHW69I+wu4IpmOwTFhlY2XxyTherOeOsvxN64Fv9nxIYoSzaZKDC?=
 =?us-ascii?Q?xY1+96jcOQE64hylxrmctqH3RcmBNiE94MlZsJTLp+Wx+hAub5e5rXstC7Yq?=
 =?us-ascii?Q?7k3ZCNeiabn5HFyFIvgvwwkCT5DpHuWfw//75Ty7dL1j3/6lI8kVRsdY5a/Q?=
 =?us-ascii?Q?f9sfU85225hSYCWak63/frwrjjaGVGx6dJI7ErJ61wayteGKCBdyKjFW/XUC?=
 =?us-ascii?Q?z1NNb2NI5Eoq084YeKwhUonJT18bMa6ccQDA+k7ZPKPck2Ye65RUYKS5osiI?=
 =?us-ascii?Q?NbBhfhTStVzbsveI8demD2s2pcTO5dA5BQ6V0mWNAZel00qfocdH237pE+et?=
 =?us-ascii?Q?Z9vzCcVE73S6/9Yq+463EsiyB/fcw7ZfqTarYaixvN+jtyFYzJmYVYnV1LD9?=
 =?us-ascii?Q?iOLzIi3+lm7l1ufMZ6QTAYfuf+TGOHS0C5biXB2mC0FVXD9VI3QiK82Nf2MH?=
 =?us-ascii?Q?EuW7+HdK3SNi4r8mvFIjiW9GkJd37jjFmjWNjKCcyvBhKpSVWngqBiXXxdNH?=
 =?us-ascii?Q?xczTYhy+cEJvRxIyApgQ71EPGu7iNNf0jWCM0DDqLkmbsBXOemXbB0WhQGt8?=
 =?us-ascii?Q?eAxOON4UPy3xoGigjngkrXIrYweFKxk0MU/UDwHzGyqYwrR7LSeNLZXIL+Mx?=
 =?us-ascii?Q?rQ/gUlwD3ppwpb7QltLE6pkXeWP+c+OjqZbqe+5U0qF0Ci/GGcAAn3vmA3c/?=
 =?us-ascii?Q?LYf7d/+tnqsk6r3tKHIUm7wT0196?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67ElF2JuwZpUcq7t8jCQiqrHl+GehFUzdwBqbf6NDHqyqi8GMf5nPyFeDn6w?=
 =?us-ascii?Q?YO7KsLpq/RctJjajfdQofFB1eWrHSvAGwwD5Egql+kyYYvLsqiW2koGPZ3U7?=
 =?us-ascii?Q?uhy2W1SfQZyBvJ0sLH8CyuTBYGvZJlX7mOxQsxDbYVMD+4ZfnPkyygV5Uxag?=
 =?us-ascii?Q?gYuhxWE0nYKYr2X9zibQYrH3r4P1I11HCack0oy7lnn0aALVnkPNLvByGsIq?=
 =?us-ascii?Q?fYOBzplhUr5sIxpmOUf4eXldBQCFoiDvjb9qg4RHdaT0eh+Mlzqz9e54jaLU?=
 =?us-ascii?Q?NPrf29NEsayRjKt9BmWqDqJV2Yixs7O+nYwpuElcyNJKFbqumRotwWKpllT4?=
 =?us-ascii?Q?8/6KEKHcW3yVblJlq5V/ELNskT0Iq/pLsbsPK6nQ7QJdbFYS8+Dy6rNTDBWF?=
 =?us-ascii?Q?VsIcVvO1vtnBUgTRotkRSk0SAjhgaWKj2g7R9fKy4kPRQAPBiR4y5CYJlhQq?=
 =?us-ascii?Q?MnrBjI/XBLKJuYLiGm/hZlxcMkCuHQjTLAKBo6z2kJ2LGi+gCYM9I79edU/9?=
 =?us-ascii?Q?V6hhtaCdwNB+r9dWauYcONTjPWcNobcBpNHSZ1Uav5mJ2Ve7C4Wll7k0KtpL?=
 =?us-ascii?Q?z4Lal/4jrrrBLSTiZR34yCIaz7nyiD8Pr6mSr+S7n3W/0higP1P64DTwpiFL?=
 =?us-ascii?Q?TPJZpOk6dF1JlvP+DDaSQ0rw5Y8/Z8LqQ3B94q81TZEYG6CoKc6rYzsIswXq?=
 =?us-ascii?Q?gU3iqdl6jWLKJTbB5D2a0hyNFgTfWGGLrNB9so0kpoe+DB4qEcq5MZYkL5Hg?=
 =?us-ascii?Q?1zKZWAJLgdhp0DwBWGchYd4/XxqM/svSiC70YjXXoCfFqdmiRd1SLQcE6VP6?=
 =?us-ascii?Q?hUKX2s1omRIK69QT3yFXUr10/IiDo7Bw34wAl4xTbyYiu69VGzft2GPjje7L?=
 =?us-ascii?Q?JAZ46lRF00uzbSLNz/4UDF7C959/Dt4y7ACD4ftz/0DEDGsSiJkKfOFYf4l+?=
 =?us-ascii?Q?MwOqg3TzEmQuYs11frKJRmRvDEmWO0nFVGZ8ZdSyy/9iaGAYeIC7uP84yTFG?=
 =?us-ascii?Q?1ufL9yIu/1RiY9KvSPDEFkk02zgE+67TZ3zEK8SUEuOiPAXdFLZZMfOyFN7R?=
 =?us-ascii?Q?2NTlUsy1NWQJ/Enm13KObp22YVToc+rHxj037AzTFf/TnU8NY5WVPnF6RMNz?=
 =?us-ascii?Q?OoB4EZ0swgs7Aud3nedOgitPuxRVYlEKK0kDk6xgg6DT0U4Wi/Uhsd0lFoB2?=
 =?us-ascii?Q?fxhA41MwCnvXGiZWL+2tTS4VBm7GzTDiTGr8VRInrCrsUF2ewTCUyhNZn50k?=
 =?us-ascii?Q?j2kpy8dFodfFQIOocAJKwrvw1xbU7iyzbL7zgL+7O8g5Sy6+xWqh8E8yy724?=
 =?us-ascii?Q?29IRf3LZ6Tmzkzy8kfjzER3fuFCiaiNf10ANxjLr74SshD/aWfKNlH0e8Oqm?=
 =?us-ascii?Q?J6b+XVGEnwQwnA+06NV2HYau0fOYzYp5Hs8BO5D8YJFL8svjIhCJG7mCSlpj?=
 =?us-ascii?Q?5ofD6nSO4sibcvsFytJyZGWgaDg5K/Ew9A1c2ojWCMChhNAQWlivhAxPR3Qv?=
 =?us-ascii?Q?pyXrGswJ7lEJwSUaDdXsjepn0l19HYFZuwfEohsoYINZbTyGlkOo8tpv7J4A?=
 =?us-ascii?Q?r9HEBx5R0Y85X+9A4bgUG17Sapq1Op+oQI6xUgl8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f1b43a-8f09-49ed-c0e3-08dd367d2123
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 22:28:41.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUWL3hg2uES4hWxQFNqIUMGp0L4Gp6xdzcEDq0FOIB/3TjdNxlQMg39omPd3c6xoEAfQ6G6ORAcpBHqzhORibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4709
X-OriginatorOrg: intel.com

Nathan Fontenot wrote:
> In order to handle registering hmem devices for SOFT RESERVE reources
                                                              ^^^^^^^^^
                                                              resources

> that are added late in boot update the hmem_register_resource(),
> hmem_register_device(), and walk_hmem_resources() interfaces.
> 
> Remove the target_nid arg to hmem_register_resource(). The target nid
> value is calculated from the resource start address and not used until
> registering a device for the resource. Move the target nid calculation
> to hmem_register_device().
> 
> To allow for registering hmem devices outside of the hmem dax driver
> probe routine save the dax hmem platform driver during probe. The
> hmem_register_device() interface can then drop the host and target
> nid parameters.
> 
> There should be no functional changes.
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> ---
>  drivers/acpi/numa/hmat.c  |  7 ++-----
>  drivers/dax/hmem/device.c | 14 ++++++--------
>  drivers/dax/hmem/hmem.c   | 12 ++++++++----
>  include/linux/dax.h       |  9 ++++-----
>  4 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 1a902a02390f..23d4b3ad6d88 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -857,11 +857,8 @@ static void hmat_register_target_devices(struct memory_target *target)
>  	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
>  		return;
>  
> -	for (res = target->memregions.child; res; res = res->sibling) {
> -		int target_nid = pxm_to_node(target->memory_pxm);
> -
> -		hmem_register_resource(target_nid, res);
> -	}
> +	for (res = target->memregions.child; res; res = res->sibling)
> +		hmem_register_resource(res);
>  }
>  
>  static void hmat_register_target(struct memory_target *target)
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index f9e1a76a04a9..ae25e08a636f 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -17,14 +17,14 @@ static struct resource hmem_active = {
>  	.flags = IORESOURCE_MEM,
>  };
>  
> -int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
> +int walk_hmem_resources(walk_hmem_fn fn)
>  {
>  	struct resource *res;
>  	int rc = 0;
>  
>  	mutex_lock(&hmem_resource_lock);
>  	for (res = hmem_active.child; res; res = res->sibling) {
> -		rc = fn(host, (int) res->desc, res);
> +		rc = fn(res);
>  		if (rc)
>  			break;
>  	}
> @@ -33,7 +33,7 @@ int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>  }
>  EXPORT_SYMBOL_GPL(walk_hmem_resources);
>  
> -static void __hmem_register_resource(int target_nid, struct resource *res)
> +static void __hmem_register_resource(struct resource *res)
>  {
>  	struct platform_device *pdev;
>  	struct resource *new;
> @@ -46,8 +46,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>  		return;
>  	}
>  
> -	new->desc = target_nid;
> -
>  	if (platform_initialized)
>  		return;
>  
> @@ -64,19 +62,19 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>  		platform_initialized = true;
>  }
>  
> -void hmem_register_resource(int target_nid, struct resource *res)
> +void hmem_register_resource(struct resource *res)
>  {
>  	if (nohmem)
>  		return;
>  
>  	mutex_lock(&hmem_resource_lock);
> -	__hmem_register_resource(target_nid, res);
> +	__hmem_register_resource(res);
>  	mutex_unlock(&hmem_resource_lock);
>  }
>  
>  static __init int hmem_register_one(struct resource *res, void *data)
>  {
> -	hmem_register_resource(phys_to_target_node(res->start), res);
> +	hmem_register_resource(res);
>  
>  	return 0;
>  }
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 5e7c53f18491..088f4060d4d5 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -9,6 +9,8 @@
>  static bool region_idle;
>  module_param_named(region_idle, region_idle, bool, 0644);
>  
> +static struct platform_device *dax_hmem_pdev;

I don't think you can assume there is only ever 1 hmem platform device.

hmat_register_target_devices() in particular iterates multiple memory
regions and will create more than one.

What am I missing?
Ira

> +
>  static int dax_hmem_probe(struct platform_device *pdev)
>  {
>  	unsigned long flags = IORESOURCE_DAX_KMEM;
> @@ -59,13 +61,13 @@ static void release_hmem(void *pdev)
>  	platform_device_unregister(pdev);
>  }
>  
> -static int hmem_register_device(struct device *host, int target_nid,
> -				const struct resource *res)
> +static int hmem_register_device(const struct resource *res)
>  {
> +	struct device *host = &dax_hmem_pdev->dev;
>  	struct platform_device *pdev;
>  	struct memregion_info info;
> +	int target_nid, rc;
>  	long id;
> -	int rc;
>  
>  	if (IS_ENABLED(CONFIG_CXL_REGION) &&
>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> @@ -94,6 +96,7 @@ static int hmem_register_device(struct device *host, int target_nid,
>  		return -ENOMEM;
>  	}
>  
> +	target_nid = phys_to_target_node(res->start);
>  	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
>  	info = (struct memregion_info) {
>  		.target_node = target_nid,
> @@ -125,7 +128,8 @@ static int hmem_register_device(struct device *host, int target_nid,
>  
>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>  {
> -	return walk_hmem_resources(&pdev->dev, hmem_register_device);
> +	dax_hmem_pdev = pdev;
> +	return walk_hmem_resources(hmem_register_device);
>  }
>  
>  static struct platform_driver dax_hmem_platform_driver = {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 9d3e3327af4c..beaa4bcb515c 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -276,14 +276,13 @@ static inline int dax_mem2blk_err(int err)
>  }
>  
>  #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
> -void hmem_register_resource(int target_nid, struct resource *r);
> +void hmem_register_resource(struct resource *r);
>  #else
> -static inline void hmem_register_resource(int target_nid, struct resource *r)
> +static inline void hmem_register_resource(struct resource *r)
>  {
>  }
>  #endif
>  
> -typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
> -			    const struct resource *res);
> -int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
> +typedef int (*walk_hmem_fn)(const struct resource *res);
> +int walk_hmem_resources(walk_hmem_fn fn);
>  #endif
> -- 
> 2.43.0
> 
> 


