Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBEC4EA397
	for <linux-cxl@vger.kernel.org>; Tue,  3 Mar 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557459; cv=fail; b=DA4SKG3nNCfI53/tf2w3ajj+1mM06YDPuhyftXjBfVfk7br2A9seVjD+QP94Eo9bg2KZfpNKOIVf8XRXbD3vvyWqDLldhmmT/MIGD+oeizkacV9E4HZj4HgG9V5wMjuj4EKEYvhbG4FeF1IYT6lUxAONTnC3jfPiVhsH3AntHTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557459; c=relaxed/simple;
	bh=qw8/3+XQVmE9POQerOsxwZa3DzMsfwZrSLVr3ynLJKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IUD7IJBcimmdwi6NmAdE9raMZIZp3eVbeRqPabtyg57Bsl5gr0xc1WIiWueCoKJAFNnywYSay7833CCDKrWvXjvLKdRyAbfjIvedy4sWvVy1TfsEVJBkZZCX9dMDajBZQR7d1hydKMY9gKp6hIpYEFWdfVr28zeew5b/L3zY78o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fd9i/M00; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fd9i/M00"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772557456; x=1804093456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qw8/3+XQVmE9POQerOsxwZa3DzMsfwZrSLVr3ynLJKQ=;
  b=fd9i/M00xm4DLAUYCD6KebvaoosCa72fCYDlJ+wIvJL7eaJ80j1hRbO2
   807aB9fM3kkw6rn5zN2ETSF5wwdSnXmcpi1BnoX81J8KEkufgklTZBnkV
   Qjs0DF2ZVOz++1Pk4bG12dYo4DK17uLpgsre0Z0+Zeu4qQpGk+cJ9a6eV
   YCvb2T/SQxi3LEBlVwydeGHZsYotRtE0Nh5DHPTjSHx63BTuxetTAzduv
   uWlZKznm80KUsJnsyqD4VJ5Vl8ZwpOvcoTHcf3IKJBV5Djsws4ayMNssk
   NXNHXlIp95w+J9hjJKu6e5y5s/BGtCcegPhRQXxpSN3sYxCv9fm2kCcQI
   g==;
X-CSE-ConnectionGUID: VCBuWmvNQnmKnWNyuQQbTA==
X-CSE-MsgGUID: UjWM+op6S2uWv5/2NLjWVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73475891"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="73475891"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 09:04:08 -0800
X-CSE-ConnectionGUID: n45S9/Y8TWm7V2kzTzCAIQ==
X-CSE-MsgGUID: 3AGusx15RhyY/DQ9zox2/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="217230479"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 09:04:08 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 09:04:07 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 09:04:07 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 09:04:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flCjxaYBSnv2f6zyU2gT+vGuqbH0xhvAeZNSMODFomgxGwTAyZFM15z24yeiwgB2LeeHqA8hz9UuSPvo9euo8udmIy4RRWqK2nLqveSj5JEQlkAqgWcFQTqrHmXETeOFkKNidD0OzI2bT+tImNZq3+Aq4UCJ40qw/1KRGNfvRXpipG3zoXA9NUHm5oDkOngDWIvRCtb2MSCfy2K0ypZPE97/Z/+sURFx6tWyMKwgLPmG21UBVKK0TOsZgKtajc/WBlDib6rQDBk++yeLkiwmjE/XWmLrdsLgsMbmBTiZR4RcHMPCwLK1afI1/DPuYAgcpHAf7yKAn6v2VHDBOCAJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVZetAUYofawqHqo3BAKXzpi5rzsRjUvkR+QNv0FyPc=;
 b=c+3ozkRpz0wWq9EhjfQrRzM7uX3GjevhXvEFxrbQQsJPinTELLuoxXrbl+tMUBl5hIdr6KqQR5rN83+FMUchn5V4Y+alhkpuBx1lPrkwt3xqqIMN/TuTE27mNSL5ksWyYSPNpGXx8AxxDrkgVV6wrbpITP7FY4K6fnsQcQGfKNwwXMJy9y0pPI5vL/MZhLjfoavFFo65XtBeP8coIxfAY44xQlS54227v4R0WUOSVd9/rldOa4AwVwxSmlQMKdnv8ytXI29CD+jrgN6qF5STnNte7XKP/lccc8D6LfoNer1hz8BE4XedAID9j1LTqSp3UUuUdW2Ynq8a/zWdEC2TlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:04:05 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 17:04:05 +0000
Date: Tue, 3 Mar 2026 09:04:01 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: danjwilliams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, linux-cxl <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
Message-ID: <aacUgSk6fUR_vFMd@aschofie-mobl2.lan>
References: <20260303001616.1821728-1-alison.schofield@intel.com>
 <69a6514597db6_6423c100e8@dwillia2-mobl4.notmuch>
 <19cb36e3606.ed1be6dc75881.2832304784422670674@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <19cb36e3606.ed1be6dc75881.2832304784422670674@zohomail.com>
X-ClientProxiedBy: BYAPR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: bff2acd4-5f26-409a-0fcd-08de7946e052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: IrTr0Vc2IrxHZ7+ddBLc2LSqaRtSZ7NyGOcfy43TFIV3yehcpVUo3QT2Z1qt1RWghFuxgb+iYPZcBaD2z2qdciMdRo9DNQY1noDI3ORpgaW/wLlsYi4sewleWNm0ne2UguDo4NK4L6x2Q1UCRApryRTisoAkMwKltMXt6VQeNe/TZoEPVr0hvQMwUWvDBDftfuhiwqGCOG6NFW1aYi/k9laqWGY9Zc3+2Ia60rHOSopAR5w8dClCOIg1I2mwCny6tdr4+4FulvYD+EMbixJyNC/WwXxnwST8SH2shFZBJwdRb8bjGwlv5RWhNueYsajE3izW2SxWrfddNClCRQ9S6wQCYUm8PBxGekjeRQ0+vbCGDbqQLn2Tv8cSDFgzoEseLQcX4ZXMO2xxzLElN66VFoCd7JgRW70DWqHZVDQ5t7aFkEH+FgsoJp0Uuh79g2cOMuSR6GxpY4AulToQhSlapMmoj4C2G/FAahsAKL2mH704x/9WigY7b4klK2N26N3O8ild7yHJzMgQnuIcfDhLrw9fmDwo8GWnJi8eDfX2FMh40FkJncGbMtSVj4FkwOMuALasHLkIthPRvTinZ1CeAOHCwiDl0p2LLgPnGTteuZ2T6/qMcEJChSVvQDQCjVwq4GPl5UepeZOU43eGyziIWYeppuFm0M9dZwbVabnCBi3qKi5ZtdADy17cEkGtnAdvZWKTFGAWo0X8p2EkNAxL4HYfcV0+lyXI8bTTB7DCbp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/AK7P9jPI+YOuHa2pKW7BOafMMlTNXf6DTndH98GhT6ARZfWtwrmG4TiHvx?=
 =?us-ascii?Q?s4giW7BYJnAVfYbGWUPej7ck4RBAN0u+P1AVHC/Y69KhWdmmEY/UND7SRtkn?=
 =?us-ascii?Q?NcwLAFnu97FbZlNjKqqFmuAePcIawftzDIdrHQ75+s9Sv65vAmrrL/Fq3ET0?=
 =?us-ascii?Q?RF/C1DD9ucv6D8/M+BZ0MxCQYfSW5DBfs/e6q22vylD7bgno+UaA0qZzctEI?=
 =?us-ascii?Q?w9sqr2mOJxOBxy/eF6Nn+Kl2zIagXgt8/nZeESDEg/oupMNgitFrtkWJcr/8?=
 =?us-ascii?Q?M5HH8gQ+qWV88iv771myu8sWc2R+DVEmVvxH+hfeF91xv/CwtYbGuibBkqTI?=
 =?us-ascii?Q?5yiNy8V9gb667rJYZFwWOHfTx9uMPRJHrs6GW/jXwtHU5pOPw2Mmj7UzZBjV?=
 =?us-ascii?Q?h5uMHiIMY90d/ekdxJ/uS3Oeeusxmrhst56u56Yg7D/ojxGnmx5VgN3B3yUq?=
 =?us-ascii?Q?Qt0lp0u/ZtALnt/okpYBjczCmbTu3WsdUa/OWvXyeAksmUF+ynaDbzVGCQDz?=
 =?us-ascii?Q?soxXYxlgaqFM8csiNSHxbBuLskdl7tQ1Ab1KBf8RcGCMQGi0bM/tgQ0lyBMQ?=
 =?us-ascii?Q?JWK3K54HQj2BK/HTLBKGn3GA9Z4qhyoiYC8bd3loI5UvmjdTOXFVYw35OA9o?=
 =?us-ascii?Q?OBuy/+bDZKO63vens/pvISl6kXpqjlAkF3f6OxoRDp0oZR9XQArGhfcNm7Hw?=
 =?us-ascii?Q?kVclMoiG7KNq7IkUz4WkOGGhhOGMQXihTp3MLcxy1oz6+LQ93jg5t2JwqoZ4?=
 =?us-ascii?Q?TT2YwDLOQIiAwbKI4E3SfzpCJsW+t+vdht3Y1mp/KqM9mekIxBpD3GuObFBI?=
 =?us-ascii?Q?/EjaQZVp79bpw95HoK2nMGR348G9v1b7g3DZlKbhpw8yAC6yXOA2XDog7yt9?=
 =?us-ascii?Q?wJvZCeo0uKTapYIZav2f5zcblxGETRe0YFKqXTv9lUqpiWnjuXc/aw4MId2P?=
 =?us-ascii?Q?JAtABqfzXWjg5O3NxpPtoi787x5WqPKcmvsegLGtbb4QqmOT90WGFrDfb+Ne?=
 =?us-ascii?Q?6S8dLU8mhfTzIoxUhkqJKzPxgUD5Ncv8XyM8z0P4fgYFW3njkB4bZsKZ1rNr?=
 =?us-ascii?Q?3+cuRcDPq0wokbhYdrwop/5F4m3wwDtuqcn7DD1GhfHRlN1PzPaPhYWwOlED?=
 =?us-ascii?Q?9mVWlXdoCxbCrQVsCWaSJOqR3qZVMG6u3hJ8oX9lnwqIyOnqkYcMN9QhTyXc?=
 =?us-ascii?Q?VlqonaeSL5HYHXtgUC7B7gD3uRw7DQkbnZ3HNmAs+W9qUL7dP77eJoEsuB1H?=
 =?us-ascii?Q?M6672BTTew8u9EEMHRJiy8YaaunqgY7vJ8pCHTo9w6C+51DYdrCNt8nBDQwd?=
 =?us-ascii?Q?RJLwhxUNqI6yHuYryMPHb5YvmEWLuWPUnWcLr4Kxo4dTDG/LuOBJs6kzYhAo?=
 =?us-ascii?Q?nwo7UhCdz0e/wCoUgqEjDPMMP/IvzbsTHRRkch+EWRxd/Vs0l8LO2adPCR+z?=
 =?us-ascii?Q?51OK9BQLfhMP2PNGsJrV2QRYAQIf6Niu80IFW4rr79fdjUCuX6FPDMKFBSrc?=
 =?us-ascii?Q?7FCqoOzDi8+4LpIy1r1ypc5w7E++fUqeCpPVwrXH5JInTQ9AszI1xzznfTZa?=
 =?us-ascii?Q?1aK8OLxfNaISZkulKiCB2/drrW46jpu/3HsGtEpMkJAEUIMRoMFm8tNzCnwn?=
 =?us-ascii?Q?T0C1WUhjChp5M00oHWjvuSd+SHCK2rfhb032nfpltR/jXtgnzcTq8KWXyB3/?=
 =?us-ascii?Q?j7gjxzhvfiPunJMoa7K7xWS7pJKl1l+88J0YMunu3+R9QGFogg0LyLkoTJia?=
 =?us-ascii?Q?kDZSbVTHF8GMoyzJT+sK2hmjArGdULQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bff2acd4-5f26-409a-0fcd-08de7946e052
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:04:05.3229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn8wN0y5tZj2CR3X/fRuQAJj2FY7xFNEn1REOHcD2wUpKm2tKS+68Yh6gb3kD7nTsEWhqLNUI0/s5fh3UpkIf98DktNT4eVLwYZ7VfmqPNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com

On Tue, Mar 03, 2026 at 07:21:10PM +0800, Li Ming wrote:
> 
> 
> 
> From:  <dan.j.williams@intel.com>
> To: "Alison Schofield"<alison.schofield@intel.com>, "Davidlohr Bueso"<dave@stgolabs.net>, "Jonathan Cameron"<jonathan.cameron@huawei.com>, "Dave Jiang"<dave.jiang@intel.com>, "Alison Schofield"<alison.schofield@intel.com>, "Vishal Verma"<vishal.l.verma@intel.com>, "Ira Weiny"<ira.weiny@intel.com>, "Dan Williams"<dan.j.williams@intel.com>
> Cc: <linux-cxl@vger.kernel.org>, "Li Ming"<ming.li@zohomail.com>
> Date: Tue, 03 Mar 2026 11:11:01 +0800
> Subject: Re: [PATCH v5] cxl/port: Fix use after free of parent_port in cxl_detach_ep()
> 
> [...]
>  > > @@ -1533,6 +1537,7 @@ static void cxl_detach_ep(void *data)
>  > >          port = to_cxl_port(dev);
>  > >  
>  > >          parent_port = to_cxl_port(port->dev.parent);
>  > > +        get_device(&parent_port->dev);
>  > >          device_lock(&parent_port->dev);
>  > >          device_lock(&port->dev);
>  > >          ep = cxl_ep_load(port, cxlmd);
>  > > @@ -1558,6 +1563,7 @@ static void cxl_detach_ep(void *data)
>  > >              delete_switch_port(port);
>  > >          }
>  > >          device_unlock(&parent_port->dev);
>  > > +        put_device(&parent_port->dev);
>  > 
>  > Wait, why is this needed? 
>  > 
>  >     struct device *dev __free(put_device) =
>  >     bus_find_device(&cxl_bus_type, NULL, &ctx, port_has_memdev)
>  > 
>  > This is the child port device reference prior to the device being
>  > unregistered by delete_switch_port(). It is not released until after
>  > that:
>  > 
>  >      device_unlock(&parent_port->dev);
>  > 
>  > So, if children are pinning parents and this child is released after it
>  > is finished with its parent, why is an additional parent port pin
>  > needed?
>  > 
>  > 
> 
> Oh, you are right. I missed this bus_find_device(). Thanks for pointing it out.
> 
> 
> Ming

DaveJ - Please pick up v4 and ignore this v5.

Thanks for the discussion and learnings Ming and Dan, :)


