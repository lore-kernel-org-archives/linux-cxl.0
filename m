Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D80C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 01:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiK3BMv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Nov 2022 20:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiK3BMu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Nov 2022 20:12:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE3F1D0C5
        for <linux-cxl@vger.kernel.org>; Tue, 29 Nov 2022 17:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669770768; x=1701306768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3uqqkN7FSYLcLuCzQclmvxpKUaCu+KusVAG6VsoqJ7w=;
  b=PdsldiwYwZmUrqPJLopm7tMxLajs99wimL5EOHEQ4oNgTdU8ldmq8c2j
   p//JXpqOPcIBJQomb1yAIU7aD9ca7y3+c8lUMYUekoEpUtTU1mJPAIzDC
   gL1PhxAkuW3yFNBTRG7kDa+FfuBM3zU59Y1CnZP0ZqWhs/ae1nlF8D2lJ
   TAZSMmp/a1eUN9d08Jx6HTioEjhY8s0YllHLNhlIlpBEhVyRA4NrRHp9j
   cEaiJkYczyML25PeaWF1bKof8pXOA9fDHXrVjRrUNgo4+dcKlQKcwX+4a
   CpFu8hVW/ky6eBerpWNUhBTdtC4mtZ1gYrgO9AdhaJkE9dP7I15y1uElV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="315303547"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="315303547"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 17:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="676639480"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="676639480"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2022 17:12:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 17:12:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 17:12:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 17:12:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBO9Sw4hlsy0PDAQI1pgb5PjgPPl1MREZJc5bV7hulZSMLPdTSbmzicds9AoE+cwdTCUnZYr0f3CurmQ8jcBcA0vqj+brIZTQpzECGObBrBTOUK1s9Xe9AcHpvTtjx/Dwvg+YDOAnu71wQ1kHn3F4JU2ZXgG6bQUxOxZfICELIMMlCRrIfN8D6oOxermdb5RFZPEFIOVvqDF4WcAZfzh2/dHUkK6Oi0clndbeLR675NyjIIp6oSEBVfWdiQFs0LDvJ0UI49JC8+cBJtGFue0imWAXenVNyY1X6ygTQlUD8dRznA2Gi6AA3YiAF6bgboqdD0O5JOmCjOIyoNbez0Bgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFJz8NuDP9LGmQFmOejBvEEAX8exdX83RzKalbJd/RE=;
 b=h6V7NKV5QwmWU0/kfUyfFNZ5n2yQKtEK6j9IYa3zBCWzWahWcGNQkN8JqVaNUze/8uuhL5CYFvroXj72tV9ny4ocBKp4UsKj3ZPqGcuB4D30L4xL5vBwrnC0HucLZPDRxy7KBvxIzZgQ9UjtuDSsLMOGmrUxS1tN83ervo0tJPkke4HIIBcTtXAPuzj3ZU5/wq1YW8wKRkYYX+SBJDhN2OozQk50vbwaDBrKO5fu5AsXGDBigb0MgbJOe1dMm8H80SRmP4OXWh4N+MOYzbureJCd+AbhnJI93JtMUD2YYZFoJ0YSRs+K2aCl6R6UorTKjwOZLzw1vVod6LrB5K4ZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4561.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 01:12:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 01:12:40 +0000
Date:   Tue, 29 Nov 2022 17:12:33 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <benjamin.cheatham@amd.com>
Subject: RE: [PATCH v5 16/18] cxl/pmem: add provider name to cxl pmem dimm
 attribute group
Message-ID: <6386ae0171083_3cbe029453@dwillia2-xfh.jf.intel.com.notmuch>
References: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
 <166863355850.80269.1180196889555844539.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166863355850.80269.1180196889555844539.stgit@djiang5-desk3.ch.intel.com>
X-ClientProxiedBy: BYAPR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM6PR11MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb8523d-b73b-41d6-1954-08dad26ff9df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s49yCHsCJ6psdnuUIDYlBncdLS3frWVZgiCKph85gfs1Yhx9EjesRi6JM/4ebhD0C8hnPRxTClLsrTtHeNumFd6MQ3EndzcTECL+LIPj/oORSl8Ta2O6l6t6xnmDV3+5UWYw8qFmgg65fPizjg0BxrJSJkyshcaUFIVbRZ0WK9jSRofbAWnAHCnoewtVf/VP0+YC8/TwUixrNBa4bbN/A62HL6n+ArX0La5kE3Pl3QjyNnR4igFUlNlmeOazsfZjhEPnSpc3vxSCPZBas7Mz305ZjkzVF+g7GagE3fiWkNsrL3jJ1aW/8MNEaIrJHe/QrvnMWcjGkQybdMdGGSL/Fiz36TFWL/KF77y8MJd0HyHdgGL/0a0uMqFspTGELcd0Ko4lBxGPYhJ/RmjOElRr9yeTQ6adSzqCC9JkovoQh+0w3xMuEKRjkxhNPf2SpANKeGohtgF7pOPkCRbvdc1Snq+rX4Hc3sbeDHPj8gLSRumC6fL51SjK/eKxDVRWW6Zqt4TTpsJYG4B67hk0XNIevxDXzl/h08/Q+qZwRVqvmAPC7PTmKSAYR6GPj6kZ/NdeClcJHt5SyXTG6b+SgyertFGLU6JE+I0IIN5QiCly0DYmU7QevixjObBNKjosLRAq8qA+T9JOoXbrm8QqFKjfOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199015)(478600001)(6666004)(316002)(6506007)(83380400001)(6486002)(86362001)(41300700001)(9686003)(8936002)(82960400001)(26005)(5660300002)(2906002)(6512007)(38100700002)(4326008)(66556008)(66946007)(8676002)(186003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JdDwZEDX/Fn9CGFZ3JoAjP+Eh5QKQNA95DOeab9+990Teu51bQl5e/qHJPJs?=
 =?us-ascii?Q?eqv+tRGRBQPqIO0TzrGjnT2LWFwT3xpvfLIUtNR6olTTT2rbRHUDTVC1JBSX?=
 =?us-ascii?Q?+kLwbCBPxqNCHmOkZniVFodYBuEioK5vERtl9opuQGrQUDWKjjDxKCdY8TJK?=
 =?us-ascii?Q?5i5hkjNxILe59u9PEB3iadctWluJIvg2AhY0eqhoCnmnnvDVKScj+pOL1C8f?=
 =?us-ascii?Q?oSZUfxZer1j5jyqbNDvUYm6FbNxUetqUhUYQd8UBC8tI6z52EgtMr3NIzqIW?=
 =?us-ascii?Q?Zig/GYDSSxinUu1yeELQszjTWjq2LrJghuobWg7ao+8GDvo91G++f+hiCByl?=
 =?us-ascii?Q?1+a3vGzbu2jl/aQ/UrElMiltvvilVaZRURCs06TlezCmvJAOS+ab9OkKDy2U?=
 =?us-ascii?Q?lvOIy/R/DhpDUcMNlvpU6c4Qe2IHzPmwSzgpVHS+ilciocO4VH0hjovHsILJ?=
 =?us-ascii?Q?Hulb8SGQ8XxCRH6b1jPhI/sIxN8SZuBYUHgcoygigHt2lVr3ExWMU0NJHzkz?=
 =?us-ascii?Q?2KcWm8LJkzfakV87jU0nWShIi2N6Xw0KAzeZ8pB1zU/aVueLH5Psti9dk9R3?=
 =?us-ascii?Q?nsBg8xYc7lrF0xvKKyc4vkAZPsItW0UddCdLZLOUWbChaN4XcIUaN6J44LIl?=
 =?us-ascii?Q?QcV9Ha/DZK7wE88LXfRfUqe7LBEMZQOONOL2P9XkzcXSUwxWCch6y4Oz3wC4?=
 =?us-ascii?Q?7ug5zz1Zu3vfNTyZ4qpkcUs9MfMpv4C6ViGPJ6bdrgTnOx5spMYpANIr8jxA?=
 =?us-ascii?Q?wMkDG+wKhyONZsLop1zcLwPf0W8G6WLpGbWeS/gCb3P+SXkGbeMEiMiM3ZoQ?=
 =?us-ascii?Q?XRZdfiOQMnzrat8+OZNWAkAvIShsfyP8u79IZwGmP0AvkqqMtROpno/KaAp+?=
 =?us-ascii?Q?55iQjjYPd6JIvO1OaqPfwN7OT+Cd5sYhu+R+pJe3VwbsooNvwETHLH2xR8NS?=
 =?us-ascii?Q?ar+vhOsPSL7+Otj53K7h2YmzFUDjCTgXFkJ7vQAS8l7zwGi5iwIiaaLgIV6a?=
 =?us-ascii?Q?8asYYZqWVG7d3XcEKjk/Umvr6wOmjt+3SvOveGWTmpiSDY4JOSZTzKFeEGAY?=
 =?us-ascii?Q?r4ut2GHucQ40cgosf6K+C2B2LVsy7nQPfDxdeOaBYldeVpxBdPKRx3KZEYbE?=
 =?us-ascii?Q?zcsoBx45qV7AlnBCFiHndDfLRd/UoQMNutU2jIPNsb9JaJ+zJQ3/8sgceJwM?=
 =?us-ascii?Q?S6rGFRb4gjtRlnLX5KgbYRiBNNWv2Q84x8Fd6qSncTtlKDJT8/mmXOU5niLw?=
 =?us-ascii?Q?fgbyJxFo3X5nb0etDIJ4pi2CLSKAKci/eA6NyClvTj8V//qvzd+E2iGr8R39?=
 =?us-ascii?Q?LEwQmJQG+xiq3zQc9+0Yp7hoq8wj6B5y2fsgQOcCsUoD3l48J3Jk3WFH3oFO?=
 =?us-ascii?Q?iZ9PjuP+NxTBS0YjbhxW+e0nz3vj3yvVtPmGoACtE5I5lIEt6PoIPXKIg0qP?=
 =?us-ascii?Q?uU4CfxY6LwiUf7UTbYR+ZgACPhl74IW1P2O69Jg9u/kS4cojMK2/IsvhZdjJ?=
 =?us-ascii?Q?5XGIB181VrT7BPyPoAhAUrvxzxMVQ2cp3zY8AS7DG5tzzmzzFM52crUZ35xj?=
 =?us-ascii?Q?wFc1MmvGZ/OpJGDJ9jvvpzpa+kMEhltg6sDwb8gDgV7E7TCwl0r3YfgZwJef?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb8523d-b73b-41d6-1954-08dad26ff9df
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 01:12:40.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pI/DrYpwo+XSwq/UqQL7X2I69bn7o7SZyL3O2QDKWTtpPPtOoG+rsUsI/Q9B9qgsA7WaLkR2V0b2WMuSL/LIye6OfyPtN90wqZNELLthNWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Add provider name in order to associate cxl test dimm from cxl_test to the
> cxl pmem device when going through sysfs for security testing.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-nvdimm |    6 ++++++
>  drivers/cxl/pmem.c                         |   10 ++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
> index 91945211e53b..d78e4553d9af 100644
> --- a/Documentation/ABI/testing/sysfs-bus-nvdimm
> +++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
> @@ -47,3 +47,9 @@ Date:		November 2022
>  KernelVersion:	6.2
>  Contact:	Dave Jiang <dave.jiang@intel.com>
>  Description:	(RO) Show the id (serial) of the device.
> +
> +What:		/sys/bus/nd/devices/nmemX/provider

This is:

/sys/bus/nd/devices/nmemX/cxl/provider

> +Date:		November 2022
> +KernelVersion:	6.2
> +Contact:	Dave Jiang <dave.jiang@intel.com>
> +Description:	(RO) Shows the provider for the device. (i.e. ACPI.NFIT, ACPI.CXL)

To make this more CXL specific I would say:

"""
Description: (RO) Shows the CXL bridge device that ties a CXL memory
device to this NVDIMM device. I.e. the parent of the device returned is
a /sys/bus/cxl/devices/memX instance.
"""

...because there is no 'provider' attribute under:

/sys/bus/nd/devices/nmemX/nfit

> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 9209c7dd72d0..322f834cc27d 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -48,6 +48,15 @@ static void unregister_nvdimm(void *nvdimm)
>  	cxl_nvd->bridge = NULL;
>  }
>  
> +static ssize_t provider_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> +
> +	return sysfs_emit(buf, "%s\n", dev_name(&cxl_nvd->dev));
> +}
> +static DEVICE_ATTR_RO(provider);
> +
>  static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
> @@ -60,6 +69,7 @@ static DEVICE_ATTR_RO(id);
>  
>  static struct attribute *cxl_dimm_attributes[] = {
>  	&dev_attr_id.attr,
> +	&dev_attr_provider.attr,
>  	NULL
>  };
>  
> 
> 


