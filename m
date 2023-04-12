Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D428BC7619A
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 05:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjDLFiC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLFiB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 01:38:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F1E5A
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 22:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681277880; x=1712813880;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lfklhc5SajrPZQBeTTEJm3bwcLyRih4oX2T0gazIt3M=;
  b=VjsliQp8cde9OaM9r44eesPrVFH8EUcuCTOJ7jwz3V8zzHzHgzznx/0s
   w0g3djsEN7lV0JQ3PaGkyzUIiuTtlh127fI+y4fH4+ZmERzAjT9c4XKZa
   oLqaD4lzMG/eLcaf3S/oR+6Ak524G1Vea4PN8qXFWvkH6K2gD61Pw38yy
   cnVkbWiDJUZcMOaKBerol2eFyrBa1DQg3jCrKrByGmtIIzSWHvSnapy0T
   5lJtE25DXGi+8uGB9MoRWM6vISnKNaR/dQaH+KBfLxHrgkHwepqzn7en4
   nND55EaJOVviAlyU6y+h5EH6U4WBgb4AkiTBVkVyCDPpymYuWz3NNqozL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="327913622"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="327913622"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 22:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="800180515"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="800180515"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 11 Apr 2023 22:37:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 22:37:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 22:37:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 22:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaW+x7dB1dED0cer6ejjXKjf8Wdj6DUf+6SHFW+6IL0FnkvZ3V9Rw9VCOfCdRG+B6YqCgfjQxF1DsHsL66hyA+GKlKjYD2nApnzNl46V0dsl9eJDoFavvvWh8RSMTU5nEvf0JNsJiIqAgqgd+KIW6FAQisVxFvqHlDTblae+6gi95Z0LgGv2Su6fDAoRlURv1JLSYEOHMEXwAmI5puEzOyHoFXWxGabC/p+4znRiNWrI+Mkox1f9lXmSvcMsUkQVJBe2SOLSQ7AMq7j4rDcEhiPnO5Q3TWkKk3HTJ3lhmlq7Z8DNJLjhRCB0XVA9Kvu86fHuXVIQ5LnoaWnMxqMhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZOfiAhygB1rT2CoezTXRqxu+kXfSL4n/m+WboxAzo8=;
 b=lKkK+9d0/9UOonUeRa6cYMU06MFw1AxDrFbe7Rd7hVjveHnTAwpdGpFR0SRHPfEsL8BAALOlcBH+a91r+4kfom0SfsKzf4C9Ua+qLZhZRiC8+ccpp+czna5TEXndx7PZrPmAvRPfE+E/ZFzg6QbcqID+Gc0vbxt14GdnAE87tx/5zxkAeOZjmj0AMtrehJrJHZqOWJXR6dGGxoY0it9eoSOizmFGOlLraRTPjPMB8Bz4dEnITP5oS6VtYp83yNmXXCntoLM9Ibqe6QLYAbiErFbH70XLVQL12WJ0EWjPmbnDzcud4ZCX8yvBdF1r7N6/A9GHfeTV6o3NZoJ+FIf93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB5683.namprd11.prod.outlook.com (2603:10b6:208:33e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 05:37:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 05:37:52 +0000
Date:   Tue, 11 Apr 2023 22:37:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v12 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <643643ada955_417e294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <31ecc71e43fa584aa0c4b1cb1e9aa7b124461037.1681159309.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31ecc71e43fa584aa0c4b1cb1e9aa7b124461037.1681159309.git.alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:a03:100::48) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a70279-ae42-4543-5509-08db3b180ee6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kix3mM5MGAp8RTNAFrKK6vjIuDklbNDNqxecIbfVGf2QWvvBGFHOy6j0rezEj7/oF5w6tPyfhdqhT1erWocNaFbCRNONhpcJF7Zi52EuEhLhpvzpXZDZtikb7igy+lMkpW05T3Uo0dA034ZozOcilHfOee6bmoLMZ95xWVM62XaVZ09M8Z4NtC4yZh4YK0ZPfpBJI5t/MrHVVj6zW9VE7AAS66FeZQRSc4sFOHTL3BPNPQ4R/V9NCfUGzAJn8yDb4bOLOkSo8mHV/Ofoto2g1rKVz5oFvt1a8L52ARMMaY+3+3mKBU/cwTwYITA+LFeK4wN5Qf2Lm80D67pl1QjohJepYH4rdKXDX0ktmYSYJDAAvwrLK/YC5aHWBvYNBD2I8iA5EZ9WydBOxfsoS7N66uo/hqY04nXmrlBzbKxwbvisOXSDXNVlfPwSYNKC+FMlGh+RBLWUsEZzZ/n4eJEx36iKDV61AnRehPdjK81KjnPi6a14ux6gIhERNOv82thiBTH6hVn9wgGqWj5DS2QXAH3Wjcl2IZyH5sxl4a1/BMkxuotYJjdchpIPEuG7bp52
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(26005)(66476007)(66556008)(4326008)(66946007)(6512007)(6506007)(9686003)(2906002)(83380400001)(6666004)(6486002)(186003)(54906003)(110136005)(86362001)(5660300002)(8676002)(8936002)(38100700002)(478600001)(41300700001)(316002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+upsGdj2jBGhRKHkwKE0hPpPqz8lA8SFi0dUINsVYNmU0w+p4yQbefoXr0U4?=
 =?us-ascii?Q?v2wsEgqOb9e1DZKWOAblbJVpGUiRnGLwnYO98xZkpgopXziOlz/+Tn+YqkPL?=
 =?us-ascii?Q?1Hrtwqke7eu48m+WpGtndU70piHU+J/w6kB0ISRIzhBYSI2HxH90LLwFUuze?=
 =?us-ascii?Q?uY4idPZHZcYytXEXuSxoeCyjWaV99YdN7eR1Ij+lTWoFPQh7dTmetnlzrvXL?=
 =?us-ascii?Q?EcYsxL7aknFdvlbfOUFvSYEPNPgyNhLkJd10rrYp+rXgG6MlTB1pe+QpS91P?=
 =?us-ascii?Q?0oadiRO8q5DEL+amR2mnf5BTIf/HdCDIoIzuDJbofo8tQbRuJs2MH0euUtL2?=
 =?us-ascii?Q?8+WCdnaxexeGb+MzfeIAGywF1vd5/8Ii/3O8IANc1R7jfwGeUDjeIon8FEpI?=
 =?us-ascii?Q?nYEpmQK2bg78UDAq/QlyPHI5CUh97IkTGfGSBDF7iGC6hI3pPMBt49k1f7Ux?=
 =?us-ascii?Q?8uEcHaGKDCPe9xJfmJguf2l+UzwTRmTzt+zOt/qwWJ8gp3QibdH2OPnElKOg?=
 =?us-ascii?Q?cKu0sbBlO96OncAwFqyNohuTQpd1tOiaMIb/OCz4/yv1DJQcT3+3rkAqyH3z?=
 =?us-ascii?Q?Oi8OKRtJkU0eFPX4GFS02r4M27x+dmlT3myFpzCvFVXVpkvDQm5BmlRX5X7/?=
 =?us-ascii?Q?tbLWQodDqWtzG1TSnI8ZeAxDGS7Up4dR3rVZHIQ0MzUn08RGtTqkJMJUCO/r?=
 =?us-ascii?Q?EV8GC+QAmkpg7o/I1lkHQG8BC792lQZgY/NHuHF9otJ5MGQMCb2JPVTO1FCq?=
 =?us-ascii?Q?ONMTiSYUVIWZ1oyb1aj5VSZyTO37cv1Z+vpukjqMamSLZLiwdW2miTFa43bD?=
 =?us-ascii?Q?IXpNnu8hNurSFDLYXzpbokBpbPYZ95kZgXCyUa812TMyHcKRkAUjXoZ+MPZW?=
 =?us-ascii?Q?UGAZlp2qAdW+ID8nPkSL2QOOdANRp4OqzDLoi02LycRNbQCrqO3NHHPUknXK?=
 =?us-ascii?Q?b/1Ye1lEJ8ktmKVyDAX1e0PCD/G79dk+IHbeF7Cvq4zLhc75goqr93EsH7Jd?=
 =?us-ascii?Q?KoaKhiOMoEMEb0itzwCV3urznvz1DYC4k+mK4XAn261axMTbXcbbrJPSrioc?=
 =?us-ascii?Q?slwg5b3emb6IKzQfSQDKhflNqSquxbYge6hOMNyTNaPN2tfZRq21BKmuPWAi?=
 =?us-ascii?Q?yCzprj23iHNgCWqZgxUCRf/RzDMeDQ3CC5e5Zv+CwOI9Jq4DN/q0YZuw4xVG?=
 =?us-ascii?Q?xQevetR5it/OncZcO19Dv6qdJ56r1L85OqM8rif94yf28c5fwsW/rqhF6bBo?=
 =?us-ascii?Q?PkwYh4oRYvDgBWNXaiwAzWtKJYCUjqGsc6H9PXH4//EKPSWIAYcE0Eyl0uOm?=
 =?us-ascii?Q?XxwF+dsAGyIRAmYUaAAtzs5aqSCmVB8pXbXfz4TdUeo53xPFDoPla0dkRAgM?=
 =?us-ascii?Q?7Mj3Yioyf6Z7jJITXgnHMCVs2fMzuWT9I8I/8UF7KMQKWH47NsOlqUzP+oZd?=
 =?us-ascii?Q?Bjr+9N7okkTCthV2p8gIjCGnVkgz5/YewOlYNr+BBlQKOTOu+2wCGgs+dai+?=
 =?us-ascii?Q?OrWKMPOigPJ5e/nv33OvJ0KfK8NnBHqDCJcmY03IwT/c7WGll394V/Wlj1Zw?=
 =?us-ascii?Q?246tMnWFf55yJFS9F9vXJlwus9CQquUPdBvVzPWcLAllpaQRQrPpCAQRW+Lt?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a70279-ae42-4543-5509-08db3b180ee6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 05:37:51.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie4jYcpwImTrvN9IvT5G0WyG4KufyKfM9KA1x4Cqk9xWc3CNJJF8+pr16WbgAyYKDo34v7PJGhsEdZQMxwtapGjPvhSN/+5Xq0AodPpiYNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5683
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a boolean 'true' is written to this attribute the memdev driver
> retrieves the poison list from the device. The list consists of
> addresses that are poisoned, or would result in poison if accessed,
> and the source of the poison. This attribute is only visible for
> devices supporting the capability. The retrieved errors are logged
> as kernel events when cxl_poison event tracing is enabled.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
>  drivers/cxl/core/memdev.c               | 48 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  5 ++-
>  drivers/cxl/mem.c                       | 36 +++++++++++++++++++
>  4 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3acf2f17a73f..48ac0d911801 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -415,3 +415,17 @@ Description:
>  		1), and checks that the hardware accepts the commit request.
>  		Reading this value indicates whether the region is committed or
>  		not.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/trigger_poison_list
> +Date:		April, 2023
> +KernelVersion:	v6.4
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a boolean 'true' is written to this attribute the
> +		memdev driver retrieves the poison list from the device. The
> +		list consists of addresses that are poisoned, or would result
> +		in poison if accessed, and the source of the poison. This
> +		attribute is only visible for devices supporting the
> +		capability. The retrieved errors are logged as kernel
> +		events when cxl_poison event tracing is enabled.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0af8856936dc..297d87ebaca6 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,6 +106,53 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> +	if (resource_size(&cxlds->pmem_res)) {
> +		offset = cxlds->pmem_res.start;
> +		length = resource_size(&cxlds->pmem_res);
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc)
> +			return rc;
> +	}
> +	if (resource_size(&cxlds->ram_res)) {
> +		offset = cxlds->ram_res.start;
> +		length = resource_size(&cxlds->ram_res);
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		/*
> +		 * Invalid Physical Address is not an error for
> +		 * volatile addresses. Device support is optional.
> +		 */
> +		if (rc == -EFAULT)
> +			rc = 0;
> +	}
> +	return rc;
> +}
> +
> +ssize_t cxl_trigger_poison_list(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)

The @attr argument is unused, it can be dropped.

> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);

The caller can do this conversion.

> +	bool trigger;
> +	ssize_t rc;
> +
> +	if (kstrtobool(buf, &trigger) || !trigger)
> +		return -EINVAL;

Hmm, the caller could to this too...

...the below seems to be the bit that the cxl_core cares about handling.

> +
> +	down_read(&cxl_dpa_rwsem);

down_read_interruptible() since this is coming from userspace.

> +	rc = cxl_get_poison_by_memdev(cxlmd);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	return rc ? rc : len;

The caller can do this conversion.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
> @@ -130,6 +177,7 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  {
>  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
>  		return 0;
> +

I am surprised that Jonathan let this slide :).

>  	return a->mode;
>  }
>  
