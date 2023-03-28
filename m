Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47677C76195
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Mar 2023 06:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjC1G1d (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Mar 2023 02:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1G07 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Mar 2023 02:26:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CCA106
        for <linux-cxl@vger.kernel.org>; Mon, 27 Mar 2023 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679984786; x=1711520786;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NJIX7poHyQfq5/cPs6pUIZ/lFQv43tWGIbJOk++FYug=;
  b=R6KX4UebUUOxn2EhY2wO9/Bbp44d61gQlS3rS89jNcYRRPfQ1UpDheg5
   3cDcpHNi8RRI9WyFdL+DYsMmeaYtYRVpUtvMCj8syZImjPo4vm+gPNyZy
   aMjTZvO9aEaFDiQGy1Pc2brD1j/yjA9nM8je6YrFTKUfiquLJG/+faVXb
   +d7isYUHNt+ylLgLwDRVLqg9lsQ6Q7H/XqssTSszUnIiIPHrvKvUZLwZ8
   mZ2ApSVngtF/g5ZfRZgGSBQ66s0NVh3IzzvlOQC2ZDnJ43KvM3YOO3rnV
   ZTyAg3qgCe+59FEuZnYnIOQSuS8ikbmVUF+60qJKPP/IusGODYJxJn44O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="339209109"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="339209109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 23:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="1013421941"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="1013421941"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2023 23:26:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 23:26:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 23:26:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 23:26:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 23:26:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTOBbaEuJ6cTRmKz/sSm6DBE8ho5mdY5WSLgCiMXkJUXI8xWrU3juxH9WkEV1mVHLdTX1sPR3UFaSZ9ukOaPErZ3xMHYb5iCb5OU2Uq0iOQPaMeT1CAlpPh8850F6Pi0Fu2R/3mjoZkXJcjQIh3dTeuiL+iiFEhwGj2tG5odMpMRuPW2/M9U2k8bhe2qDMDHZsHChddc1+VhlQwL6B6fJPcVwS6UIcTKX27/inY0Ib4Yp04x0sE7TzXTN2SeOApFDYt59uPwOZOS0lST0gP3tqmauFmwWyegEC0MkPhmy+3t3dSotjm2vG0hu091PQz+7VuGs7E9YPdOWGPyECl1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YXIlmm/eRuM1SVSIwnDauqIlpfHXilpKNiiEkvglus=;
 b=V7u3DNhWoLAy52M6PRyHGd5NQL5L/tGt53dtD/Qk0Edscl/YuvAvgW30KuI6hxYV11DzzWY/o3Lz5ogsXEWk4w9yYrT0albaq3W+l7FLuijtm8BkwGby+7LRWHpFpSYbmOAKLFys+UAsHyydKCcnu44en5e+c2QXvKVV61PucCUZQmXqt/4t3DD2PWMjy78urfxTQ4OPE1/SwQYCAAJP51rJogJAt4XmeydewaiJMeiNcVNhi6JCHb+HSytu61uxoPHEh/bYeBZ9NBHv9Slr5IwWF+BVCYLUfNT6knXuHdRyXX9B72zsKgskFvBhl/K7J8YVodp3IVjDa0Utct8m+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6013.namprd11.prod.outlook.com (2603:10b6:8:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 06:26:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 06:26:21 +0000
Date:   Mon, 27 Mar 2023 23:26:19 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>
Subject: RE: [PATCH 4/7] cxl/mem: Support Sanitation
Message-ID: <6422888b688fd_21a8294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-5-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230224194652.1990604-5-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfb1afc-f0fb-4937-0051-08db2f5558f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30FAFFFuR16czm+vB8aEGWsNWdWDCI/iMISDcGWg4tlZxTMSead+JMAbgxsBKoygBwQEUWr0+uoCp8vtKQwIymDWRwOFBXWU8xJ2QhFzQfubto5cZ+qD3Wm1Fp4pFQEFn0VUL/Mt5FKL+QrkHTSnlkTc7HuliCXr9sKcOUQnJju+z+sHh6uyxavJFoABzpcq/aZGs6paADv79OeX1I+swrc7TIWGbCDop+VCj0tGeWJsfKc611nufCAmLqI5R+3E2nb5ziKVRQnnspWBB3gTnrQFnnaV7R6XZlhT5Gj7fliZO64ArvXxeblxienKrXc13gLQSapHA0IfUmxf/vQIwe69c4E0P12TeJ9IhXaQ4jAoLXWZ008g97cumbl3u9975HOjyQB3pGFn/BuvkcAjXd9DzwhlAD2fplixSOR1BH3Dxbfp6rj20NAPn6hd5UZt1185cWgcnOATyNhcoHSTle0z4sqfu+/FgSHW1iFuSQ34GOYGv72TxrjIHcOpGSFtx0AuTqdnLgZDV00Q3r5yWuxokZpQMIB3AhISQUrJMZe4+TEuGsSBh6KrbeStIGu63ZpMdq6rtG3YFklz205UNkpsZ+Xh7dziNf5uVziTz/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(6512007)(26005)(9686003)(6506007)(316002)(6486002)(4326008)(186003)(66556008)(66476007)(8676002)(66946007)(478600001)(41300700001)(5660300002)(82960400001)(38100700002)(2906002)(83380400001)(86362001)(8936002)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TyYvHJIdbl712VsPHGNoEo1DE6ZyOtpIMSjyjYvT7gxE+LsMFUeYvYX4vIFw?=
 =?us-ascii?Q?uJ4sL5A+oB1d9CHPcEKVKe1FpKkA/CAdTNFwaqxrVSeiT9ZjtEF3oUQFtoO3?=
 =?us-ascii?Q?8nOqGEZG3yPrI0z9kNABRYwDI/h+HIFocuZkqK/QEBnhFmgPi1klKaFNg9dp?=
 =?us-ascii?Q?xE02Spv6wzrXxfHXJM/wlYvosb8TE8WPjxSe39mN21qqvApjDK1Pg7nSYQFl?=
 =?us-ascii?Q?Zoy9a+1cIpTqSKkOasaN+BUNJARllcM2PMBQsMHiCFSTC21MN+hJLVg+RL9U?=
 =?us-ascii?Q?GckYoPNde9/RAZFkzfEcdSPUP+MN/5KWCIaEre+oYHXO/Swl9EZU6L5TeIDy?=
 =?us-ascii?Q?YW0ESXXvftlmIPEGhW7Tg51Lg+PDnno4xYhUJJm9ppbRb3GCcNZWrhIxwJu4?=
 =?us-ascii?Q?WqYZ4DmyYZThR3W7w/VLHYEfKyW9W5lIjfqPh4f5aTBAnEZLxGCH7zDt7hcg?=
 =?us-ascii?Q?PziXNxrTTblU/lX7umEUuNUPsV9QcZeAnGdzyZoidVvEz3Tr2hYVzhhZu8/f?=
 =?us-ascii?Q?pl5v6+ONc1xcQ1+AhvTAY3KqUVYN0mqKEjcM/DM6oHXFJbJbsSYZoLwdLN9D?=
 =?us-ascii?Q?DeXcgcqZZKDYpwp1/gztK6bQcmY2RDCO3W3NefXkHCd4+gIkdePHGA5Q7o+B?=
 =?us-ascii?Q?Dl2/LpbYy2yvGgMNVIcdxqlK9S9B0b0k+bjhN2J8nH/8NxCWxB6hx+nhCVHq?=
 =?us-ascii?Q?5uZKX5DsXeYkekmhqo7/gUn9RwODlTqWfY5QKvN+7HZkfTPjQmJjcSU2bwVL?=
 =?us-ascii?Q?KBRojLGQYlMz0qmy+MDwPZ6zkjXE5KCZViJKI0/3Lgyjk+Z6Lanu25rZKM/4?=
 =?us-ascii?Q?3tb2v6aTSlxOLVNfrNft3z9wmuzY7ARm2Ji98PlUpoVPGwFW0uyqpMhs8RfX?=
 =?us-ascii?Q?7wIhwxKmOwBXijyXcuL+t/hgRUw72OF4B31HX06V460SU+jm7gWiXMuwtb5w?=
 =?us-ascii?Q?kWTqurzicb3xv5H/4ush68aicncCt5w0DW8cURTDo0Isk4eOgNkNq8K4y1zT?=
 =?us-ascii?Q?Zx/VfWVvdh+x871Qr970YvpKwluoSVEQhTVVKRcGPzc8husMtaipp2sfTgEO?=
 =?us-ascii?Q?J9uufD8xG9m9KcP0jMQXrm+I4W2rba4epB7Xmh0IQeIgziXfiDiDI1zFe3XA?=
 =?us-ascii?Q?R79RZmvCoxIjQnhau+GtNLFRSg1OOcNVntN3RefQOBrru6D54nBMSznwc/pG?=
 =?us-ascii?Q?PxZN0G2EyYA4gGplpMZBDNAfU+pecvNI0rSUymw0xJ0jxvq7WUATqzB9NhSI?=
 =?us-ascii?Q?Pn9ZyDcPKqpzGjfkwHq6uZdBQmWyUFtqq0xPdKoUckv2nV9iBGW1f/kngSxO?=
 =?us-ascii?Q?R1UdH60inC+FJhh8dvEA9hszgRd7NhmW+pKRU4lC3IpzgAYa6PbOGeJD3f78?=
 =?us-ascii?Q?Yni9L3CshwIsOLPC9aglMoq3j92TSE0vx+GpTQdTmmFKCI9csCMVrPKz1kIc?=
 =?us-ascii?Q?/Kd1IgySTYGAV3kFcfJ1O2609MynbS+rv+RRVOOGDc3nzkXmvR78eSxNHbLO?=
 =?us-ascii?Q?DiyeQpZCSZ/VffkqH73ASACFyFUJxnHHWu8OF+oQrr2YV0Qm2F9eyRuacgYr?=
 =?us-ascii?Q?l0vIoIGNlGav7aH7LJ7WmKZ62917ABnlS6AK6ODPS71GrGJtRRYoWc4QILqt?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfb1afc-f0fb-4937-0051-08db2f5558f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 06:26:21.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWtty7jP594XdHMggBpwYbRgcber5JMoJ4MQOi51CFNyrJqypTTZeptfhqxpLh0EXe72x7Gw4a6iXQyjbwVsOvieJ0gtygS1mjxPaRQu7AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6013
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Davidlohr,

Davidlohr Bueso wrote:
> Implement support for the non-pmem exclusive sanitize (aka overwrite),
> per CXL specs. This is the baseline for the sanitize-on-release
> functionality.

Wait, what sanitize-on-release functionality? The DCD facility to
sanitize-on-release (CXL 3.0 Table 8-126.  DC Region Configuration) is
indepdent of background command functionality, i.e. "Release Dynamic
Capacity" is a foreground operation.

> To properly support this feature, create a 'security/sanitize' sysfs
> file that when read will list the current pmem security state and
> when written to, perform the requested operation.

Sanitize (command set 0x44) is independent of the pmem security state
(command set 0x45), and I thought patch2 will list the current pmem
security state via security/state. 

> This operation can run in the background and the driver must wait
> for completion (no timeout), where the poller will awake every
> ~10 seconds (this could be further based on the size of the device).

Per the feedback on 1 this changes to be a facility that returns
immediately and signals completion via sysfs_notify_dirent() because if
it takes seconds and is hardware uninterruptible then that warrants
userspace being able to poll for completion if it wants.

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++
>  drivers/cxl/core/mbox.c                 | 61 +++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c               | 39 ++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  2 +
>  4 files changed, 116 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index e9c432a5a841..b315d78b7e91 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -66,6 +66,20 @@ Description:
>  		are available: frozen, locked, unlocked and disabled (which
>  		is also the case for any unsupported security features).
>  
> +What:          /sys/bus/cxl/devices/memX/security/sanitize
> +Date:          February, 2023
> +KernelVersion: v6.4
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +	       (WO) Write a boolean 'true' string value to this attribute to
> +	       sanitize the device to securely re-purpose or decommission it.
> +	       This is done by ensuring that all user data and meta-data,
> +	       whether it resides in persistent capacity, volatile capacity,
> +	       or the LSA, is made permanently unavailable by whatever means
> +	       is appropriate for the media type. This causes all CPU caches
> +	       to be flushed. If this sysfs entry is not present then the
> +	       architecture does not support security features.
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..885de3506735 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/memregion.h>
>  #include <linux/security.h>
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
> @@ -1021,6 +1022,66 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>  
> +/**
> + * cxl_mem_sanitize() - Send sanitation (aka overwrite) command to the device.
> + * @cxlds: The device data for the operation
> + *
> + * Return: 0 if the command was executed successfully, regardless of
> + * whether or not the actual security operation is done in the background.
> + * Upon error, return the result of the mailbox command or -EINVAL if
> + * security requirements are not met. CPU caches are flushed before and
> + * after succesful completion of each command.
> + *
> + * See CXL 3.0 @8.2.9.8.5.1 Sanitize.
> + */
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +	u32 sec_out = 0;
> +	struct cxl_get_security_output {
> +		__le32 flags;
> +	} out;
> +	struct cxl_mbox_cmd sec_cmd = {
> +		.opcode = CXL_MBOX_OP_GET_SECURITY_STATE,
> +		.payload_out = &out,
> +		.size_out = sizeof(out),
> +	};
> +	struct cxl_mbox_cmd mbox_cmd = {
> +		.opcode = CXL_MBOX_OP_SANITIZE,
> +		.poll_interval = 10000UL,
> +	};
> +
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return -EINVAL;

Given that the regions are already offline I think there is no
additional damage to allow santize to go through, because they could not
be dynamically re-enabled.

> +
> +	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to get security state : %d", rc);
> +		return rc;
> +	}
> +
> +	/*
> +	 * Prior to using these commands, any security applied to
> +	 * the user data areas of the device shall be DISABLED (or
> +	 * UNLOCKED for secure erase case).
> +	 */
> +	sec_out = le32_to_cpu(out.flags);
> +	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
> +		return -EINVAL;
> +
> +	cpu_cache_invalidate_memregion(IORES_DESC_CXL);

Given that sanitize mandates bouncing the decoders the reconnect will
set CXL_REGION_F_INCOHERENT in attach_target(), I think it is safe to
assume that caches will be managed before the sanitized data will be
ingested by anything.

Specifically, I notice that attach_target() sets CXL_REGION_F_INCOHERENT
in the region creation and autodiscovery case.  The latter is a bug that
I'll fix up. It should only be set when the chance the HPA-to-DPA
mapping has changed, or the contents of the DPA has changed in a cache
incoherent manner. The fact that sanitize mandates what appears to be an
HPA-to-DPA change then no need to manage caches explicitly.

> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
> +		return rc;
> +	}
> +
> +	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 68c0ab06b999..a1bb095d081c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -127,6 +127,34 @@ static ssize_t security_state_show(struct device *dev,
>  static struct device_attribute dev_attr_security_state =
>  	__ATTR(state, 0444, security_state_show, NULL);
>  
> +static ssize_t security_sanitize_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	ssize_t rc;
> +	bool sanitize;
> +
> +	rc = kstrtobool(buf, &sanitize);
> +	if (rc)
> +		return rc;
> +
> +	if (sanitize) {
> +		if (cxl_memdev_active_region(cxlmd))
> +			return -EBUSY;
> +
> +		rc = cxl_mem_sanitize(cxlds);
> +	}
> +
> +	if (rc == 0)
> +		rc = len;
> +	return rc;
> +}
> +
> +static struct device_attribute dev_attr_security_sanitize =
> +	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
> +

DEVICE_ATTR_RW() to poll(2) for completion.

>  static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -188,11 +216,22 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>  
>  static struct attribute *cxl_memdev_security_attributes[] = {
>  	&dev_attr_security_state.attr,
> +	&dev_attr_security_sanitize.attr,
>  	NULL,
>  };
>  
> +static umode_t cxl_security_visible(struct kobject *kobj,
> +				    struct attribute *a, int n)
> +{
> +	if (!cpu_cache_has_invalidate_memregion() &&
> +	    a == &dev_attr_security_sanitize.attr)

No need to hide the attribute given the above discussion about
invalidation being done somewhere else.

> +		return 0;
> +	return a->mode;
> +}
> +
>  static struct attribute_group cxl_memdev_security_attribute_group = {
>  	.name = "security",
> +	.is_visible = cxl_security_visible,
>  	.attrs = cxl_memdev_security_attributes,
>  };
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4e31f3234519..0d2009b36933 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -631,6 +631,8 @@ static inline void cxl_mem_active_dec(void)
>  }
>  #endif
>  
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds);
> +
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
>  	unsigned int decoder_count;
> -- 
> 2.39.2
> 


