Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D363C3A5A7
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 02:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLGCVE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiLGCUx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 21:20:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554CF5437C
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 18:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670379651; x=1701915651;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1gI5UmUmEIIRdCXnFln5PQg+VdtkFyIusahkI16oDrw=;
  b=eWlTYnr2u1qElW63EUJTGwdhxjoRbi0COvu5+SeBZSyRax8CQu3rBwGZ
   aqd5U2Jog6dQzisqfJ6/RW+PSdjV0HoR/KV/eMol7nkjS+7qJPWbk4kFr
   bLcejMGvfldhWn5r6QFTx7yFlBlR+uHZB7J5vHJeRMcopHGkEJtwHN/bV
   Rg4hjIsa3YY2jygk4EeUOn18apswfgtdX5/IVspu/RCRYzMmFFU0Kc817
   /bnkQZ2AjNjU2FMgJ35zMErK2EvQM9fic8677hGzV3b42RLkcJyDXyTJn
   Lk9nSLScRd44itOZgRlLHATHWjEGSzajMuhfjfB8H33gGSA/g8xdXMgZm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="378949792"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="378949792"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 18:20:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="596799355"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="596799355"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 06 Dec 2022 18:20:36 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 18:20:36 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 18:20:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 18:20:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 18:20:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axkgiVvP/F7rxrtyAeNFiwF2y9tTVXMkNdj0oDdIN3zENHG4k4sY67yKF0uuZ/ogflBRP1ZFa41GrrohUhNTcjpU0HWD87ermZycbYLYmCcja4kejKsx4LmHZ6sieMUmePIuB2tAOB5+Jj68gILokS01dwrQKnP1JHtRCgoCSlmlR5KXJDxZveu3wF+WSC3PJoSzdUU0ENPb8T+B6HorB1h3pAW8AjEwoxpxKO0zXyvEbeKX7CbhQ73pZf7LiXqETFT7uEXWV1jdZay5QBV3NRLjV3kQ7ED80fyA1rUZcsALhMSuEdkEI5WKo7UWhkAcFMx9/JEgt9R3MIGC3pcqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EEIdw+RfLyBIxzi/9Z0HEAwLI9pz/hkguJPTXXQ6+k=;
 b=aJuv9mabjvfzJmAa/0eBZPr9QVbQsSNKmJa3xT72Vj9oGvp75FHyUc3EnZHmxkG8Q37AfoWFhxYdx82UK382ORCn9woBsZDjSYjGZeKRVu/GMvzFl+8yChD9jVAi2FqgMu220XXWP4ul55X02yHO26NHSP0XKZOH/v8zS4UeVeow6HGRDc2E9xWN2NrIKIQwLJz3acivZs/RBVVPmoYR9tQGrF24PGbTQBPfajP+R9GJOvphYjDJWY23ywkFIwT868oSK4AJXJje+QQgXrazPNdhLruGLkJOfJ9zlg4hAjEd51mrQPAoSrXyFoaMOYPo1mZ/53IGjcm0+835uIbL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL3PR11MB6364.namprd11.prod.outlook.com
 (2603:10b6:208:3b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 02:20:33 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 02:20:33 +0000
Date:   Tue, 6 Dec 2022 18:20:30 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 2/3] cxl/mem: Support sanitation commands
Message-ID: <638ff86e7e44c_3cbe0294fd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-3-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221206011501.464916-3-dave@stgolabs.net>
X-ClientProxiedBy: BYAPR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:a03:60::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL3PR11MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f2ecc1-3b58-41f0-afc4-08dad7f99e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcVADwCh75UisHtTers5ZU1Pnbpjq15T8A1nFLCrawjd3+hUlGwSk9FxYk/SXCMSR26yfPafCiEgv6cXO65fTyvSP/Wkb6mGfuv0mNxSjqVtjkLIW5oHXQg0oep3o6xZXSaR0l7Cu2Mlh9IzNkSXcr4HJQSZCsDJb+kFfwTwt0kBPv3rMYaJe1H9dcb4thda4FqoPqElcy2SYLtF+qKhG/OZOUIpIv6utgjWxRJidspyzgX1FXcAFLquYNEadf2B0mhCB6VfJ2DvwW7pMPyX0/MQayyrbt0bSAsTNr3VXCv80FgWKyifQ5dAWtOKG1Yjy8JwRwJnkh4JD1mi7O6LKYHcFRIfvE8h+9VCQyfYHfOi2K3O2DujAVfLQiNHQKHrghPofpmUd3kfvm93m2HcEy7/hMGY/W6HtqAxMGLbf0tM1eNObOib9A65e+qIUzCVdebm5FNqg7Xyw32BxRqvtNdodyt7nR6LtMxeVoFVJq7igN5KyZfFy49N4rUscvpgv3tpVMSKsUcfpI597YNiIV+mlOxpEJ2BvXKzrgw2os8KNSQG3hPi7IZyjJYy3sNzLDEv1vIKP0Gb+vjCCIVzsGIHkYcQ9a2cOH7wYUNDELvUBVwvbfyBl+7ACgH4F60g8uoP7ZtLuP5tmOdWtLZINrHQ9MtjrvjjZ0+Tt5Bi8hrwDAnt9GNsHIc8ggT8sRrT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(2906002)(86362001)(6506007)(83380400001)(9686003)(316002)(6486002)(6512007)(186003)(26005)(66946007)(82960400001)(5660300002)(30864003)(478600001)(8676002)(8936002)(41300700001)(4326008)(38100700002)(66556008)(66476007)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hRzar8ZO/MCg60KT7o/Ewx7CVADWzJL4TbO9wGt3BtX7CP8xx86loTRkXxBP?=
 =?us-ascii?Q?3iwVtmJa4JsLuKuhMVo0Bxw7McFIctRUDrO5M4GhmEt9eshsdLlVeq51zZbe?=
 =?us-ascii?Q?JFdnIJf3Hfz3suMJu9H6F2bhZfqpaRUCnMtj7IiizG8JXkkN9wwCvaNKIYRo?=
 =?us-ascii?Q?EgXeBHSiBDXj6q9SKjn81kM0X3fI893FrwH6QBs54RKYJcD/yfSpTqu2wAwH?=
 =?us-ascii?Q?Gpe1j3cIauvxWVxVm/Psh/aDopYIDHp1YurrU2ggxn+7mmnGDpU5edOz5V2g?=
 =?us-ascii?Q?MUD5RFJsvz6gHC/JwgcQgmLhPxcbSxJWuqsOwxQP+3vUorD7SOX/ydK9n8+4?=
 =?us-ascii?Q?jcIqRhjx3yhsXZOODht1WYs2IP+QMuO+pWuWr8eVI/ptZwviSJBW8YcwDf6b?=
 =?us-ascii?Q?CeFUkDNp9xxUIR4isMLMcm8yUolDFBVqhD/XhPgC6SGpxxH1BVNJuO/MwfXs?=
 =?us-ascii?Q?UdFJrgEDv0ymZEBXPT/kz+orfRX0sEpbH4Qv9vY9a4eQy4e2bTjGFRl2/L2N?=
 =?us-ascii?Q?W+lhptQqjfFW642IM3wuJtISZRexJpf98AxJeHeFMi5L/h5OLk2oFO4wzAda?=
 =?us-ascii?Q?lZ8KkF1hF73AXtvYnlPCMi5kSZerg8mGnMPC/qJX/PeJae/9ou1F0gzAfSCc?=
 =?us-ascii?Q?DVtTQg9EqgRiBPQgVRvBWi5NTNlecWy8+PnHGnC030qFPJzLiRhMiH7z090O?=
 =?us-ascii?Q?r5Au4AVNFaXV1C6OkX6sAR/MO6RdFmnCf9O6oSTPY9ikDRLmj6rGosFK+iH7?=
 =?us-ascii?Q?MDRATrD5fxB6dBJ/qsQ3xKw5EpOdYAQQ7iO7I3NcAoNBk24iohyxfK0ZCD4z?=
 =?us-ascii?Q?kZuY5bYh+0pALinTKndppGsmeWABCf37uCK9zsoAYlRJSMrP2H/PKivdRvho?=
 =?us-ascii?Q?KCOm30xf8K9qQsRFgauJeQ0//RO5Va07zqvL59IE11vRVnuL1a7lx5gLTAUg?=
 =?us-ascii?Q?UPIT0XHHsUkJmDyFmfu9tFhLO85w0IFQ5iMQvVfl1nyURL8V3xj+RvtjRYlf?=
 =?us-ascii?Q?nkZ0/NmjWjABBKjrZYwxqAwGa3fYmy1yqdp2B2I54mxxUPnWIhUzWnfWTPyP?=
 =?us-ascii?Q?j7q33IpHwDfEsSVBmBw/KlFpTlUpnDowEF4UZxirvwBAi9hHoMj1r8isJWqP?=
 =?us-ascii?Q?Iv4jAuJ/R3mYgdbDl0HcNzEuq28JS7HXbCY1vaCx9qynPeJf4xCLsW0h+MCD?=
 =?us-ascii?Q?/zceHEkWwqVLcwIylV62h0AJrsQRG1+vcVQxjo6vL8vitYBMd8t9Lo3Ri7g6?=
 =?us-ascii?Q?zEQLrSgERZcjd+LkzbsDMeUca/Jy5EjTf3ucI8KfTDX/32uVDI+ps4DSp3lA?=
 =?us-ascii?Q?oOrA2tlKa3r7zbrB7gXCnTpMyAGv9exumEF+wDp4E8zcvKivl7OQkN6x5kVq?=
 =?us-ascii?Q?FNJDNWPLAYNm+4S3FGM2ZlXf7Pp4lU+s5FPbnsZD+7Bvvs3VYG4GET0qJ58o?=
 =?us-ascii?Q?K1uUIIscB5yAXa8RosqocWI6pyRTdPjGaTMSkkyryoPid4pviJPwJLRaLYgX?=
 =?us-ascii?Q?aQ38bHrjHBTOcno/4TU/IHbJvA13qYnWRiO0w6aFb2L5ZWcQD2F8SCVgzKBa?=
 =?us-ascii?Q?C1CH3A4jhZSbuEdnI8+UrNg2Xb+NJ7WJVCtlFebsC06IzQZAn0i4LsoKZWXt?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f2ecc1-3b58-41f0-afc4-08dad7f99e13
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 02:20:32.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baJ/PxtpVMzNB5bOdKSE2ZBNbchyYlApQCJmdZx+wR8v5OU1qzYPvr7u2zQj8/iTVjYAFV3hy7F4VKsSJeM3jGvC6ZoL9es1oBTMANr5Q6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6364
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> Implement support for the non-pmem exclusive sanitize (aka overwrite)
> and secure erase commands, per CXL specs.
> 
> To properly support this feature, create a 'security' sysfs file that
> when read will list the current pmem security state or overwrite, and
> when written to, perform the requested operation.
> 
> As with ndctl-speak, the use cases here would be:
> 
> $> cxl sanitize --erase memX
> $> cxl sanitize --overwrite memX
> $> cxl sanitize --wait-overwrite memX
> 
> Where userspace can implement entirely the wait/query mechanism for
> waiting for the sanitize to complete (albeit no poll support for
> the security sysfs file).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  19 +++++
>  drivers/cxl/core/mbox.c                 | 104 +++++++++++++++++++++++-
>  drivers/cxl/core/memdev.c               |  54 ++++++++++++
>  drivers/cxl/cxlmem.h                    |  10 +++
>  include/uapi/linux/cxl_mem.h            |   2 +
>  5 files changed, 188 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 8494ef27e8d2..18e26ae3d75f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -58,6 +58,25 @@ Description:
>  		affinity for this device.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/security
> +Date:		December, 2022
> +KernelVersion:	v6.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		Reading this file will display the security state for that
> +		device. The following states are available: disabled, frozen,
> +		locked, unlocked and overwrite. When writing to the file, the
> +		following commands are supported:
> +		* overwrite - Sanitize the device to securely re-purpose or
> +		  decommission it. This is done by ensuring that all user data
> +		  and meta-data, whether it resides in persistent capacity,
> +		  volatile capacity, or the label storage area, is made
> +		  permanently unavailable by whatever means is appropriate for
> +		  the media type. This causes all CPU caches to be flushed.
> +		* erase - Secure Erase user data by changing the media encryption
> +		  keys for all user data areas of the device. This causes all
> +		  CPU caches to be flushed.
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index bfee9251c81c..5ffdab10073d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -4,6 +4,7 @@
>  #include <linux/security.h>
>  #include <linux/debugfs.h>
>  #include <linux/mutex.h>
> +#include <linux/memregion.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  
> @@ -11,6 +12,7 @@
>  
>  static bool cxl_raw_allow_all;
>  static struct workqueue_struct *cxl_mbox_bgpoll_wq;
> +static struct cxl_mem_bgcommand_ops sanitize_bgops;
>  
>  /**
>   * DOC: cxl mbox
> @@ -70,6 +72,8 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_BGCMD(SCAN_MEDIA, 0x11, 0, 0, NULL),
> +	CXL_BGCMD(SANITIZE, 0, 0, 0, &sanitize_bgops),
> +	CXL_CMD(SECURE_ERASE, 0, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
>  	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
> @@ -136,7 +140,6 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
>  	cxl_for_each_cmd(c)
>  		if (c->opcode == opcode)
>  			return c;
> -
>  	return NULL;
>  }
>  
> @@ -887,6 +890,8 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  	 * Setup permanently kernel exclusive commands, i.e. the
>  	 * mechanism is driven through sysfs, keyctl, etc...
>  	 */
> +	set_bit(CXL_MEM_COMMAND_ID_SANITIZE, cxlds->exclusive_cmds);
> +	set_bit(CXL_MEM_COMMAND_ID_SECURE_ERASE, cxlds->exclusive_cmds);
>  	set_bit(CXL_MEM_COMMAND_ID_SET_PASSPHRASE, cxlds->exclusive_cmds);
>  	set_bit(CXL_MEM_COMMAND_ID_DISABLE_PASSPHRASE, cxlds->exclusive_cmds);
>  	set_bit(CXL_MEM_COMMAND_ID_UNLOCK, cxlds->exclusive_cmds);
> @@ -970,6 +975,103 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>  
> +static int sanitize_bgcmd_conflicts(u16 new)
> +{
> +	/* forbid anyone but health related commands */
> +	if (new == CXL_MBOX_OP_GET_HEALTH_INFO)
> +		return 0;
> +	return -EBUSY;
> +}
> +
> +static unsigned long sanitize_bgcmd_delay(struct cxl_dev_state *cxlds)
> +{
> +	unsigned int tmo;
> +
> +	if (!cxlds)
> +		return 0;
> +
> +	tmo = cxlds->sec.sanitize_tmo + 10;
> +	cxlds->sec.sanitize_tmo = min(15U * 60U, tmo);
> +	return tmo * HZ;
> +}
> +
> +static void sanitize_bgcmd_post(struct cxl_dev_state *cxlds, bool success)
> +{
> +	if (!cxlds->mbox_irq)
> +		cxlds->sec.sanitize_tmo = 0;
> +	if (success)
> +		cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +}
> +
> +static struct cxl_mem_bgcommand_ops sanitize_bgops = {
> +	.conflicts = sanitize_bgcmd_conflicts,
> +	.delay = sanitize_bgcmd_delay,
> +	.post = sanitize_bgcmd_post,
> +};
> +
> +/**
> + * cxl_mem_sanitize() - Send sanitation related commands to the device.
> + * @cxlds: The device data for the operation
> + * @op: The command opcode to send
> + *
> + * Return: 0 if the command was executed successfully, regardless of
> + * whether or not the actual security operation is done in the background.
> + * Upon error, return the result of the mailbox command or -EINVAL if
> + * security requirements are not met. CPU caches are flushed before and
> + * after succesful completion of each command.
> + *
> + * See CXL 2.0 @8.2.9.5.5 Sanitize.
> + */
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 op)
> +{
> +	int rc;
> +	u32 sec_out;
> +	struct cxl_mem_command *cmd;
> +
> +	cmd = cxl_mem_find_command(op);
> +	if (!cmd || !test_bit(cmd->info.id, cxlds->enabled_cmds))
> +		return -EINVAL;
> +
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return -EINVAL;
> +
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE,
> +			       NULL, 0, &sec_out, sizeof(sec_out), NULL);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Prior to using these commands, any security applied to
> +	 * the user data areas of the device shall be DISABLED (or
> +	 * UNLOCKED for secure erase case).
> +	 */
> +	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
> +		return -EINVAL;
> +
> +	if (op == CXL_MBOX_OP_SANITIZE) {
> +		u16 ret_code; /* hw */
> +
> +		cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +
> +		rc = cxl_mbox_send_cmd(cxlds, op, NULL, 0, NULL, 0, &ret_code);
> +		if (rc == 0 && ret_code != CXL_MBOX_CMD_RC_BACKGROUND)
> +			cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +	} else if (op == CXL_MBOX_OP_SECURE_ERASE) {
> +		if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
> +			return -EINVAL;
> +
> +		cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +
> +		rc = cxl_mbox_send_cmd(cxlds, op, NULL, 0, NULL, 0, NULL);
> +		if (rc == 0)
> +			cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +	} else
> +		rc = -EINVAL;
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 20ce488a7754..0b79c2b6720e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,12 +106,66 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t security_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u32 sec_out = 0;
> +	int rc;
> +
> +	if (cxl_mbox_bgcmd_running(cxlds) == CXL_MBOX_OP_SANITIZE)
> +		return sprintf(buf, "overwrite\n");
> +
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE,
> +			       NULL, 0, &sec_out, sizeof(sec_out), NULL);
> +	if (rc)
> +		return rc;
> +
> +	if (!(sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET))
> +		return sprintf(buf, "disabled\n");
> +	if (sec_out & CXL_PMEM_SEC_STATE_FROZEN)
> +		return sprintf(buf, "frozen\n");
> +	if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
> +		return sprintf(buf, "locked\n");
> +	else
> +		return sprintf(buf, "unlocked\n");
> +}
> +
> +#define CXL_SEC_CMD_SIZE 32
> +static ssize_t security_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	char cmd[CXL_SEC_CMD_SIZE+1];
> +	ssize_t rc;
> +
> +	rc = sscanf(buf, "%"__stringify(CXL_SEC_CMD_SIZE)"s", cmd);
> +	if (rc < 1)
> +		return -EINVAL;
> +
> +	if (sysfs_streq(cmd, "overwrite"))
> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SANITIZE);
> +	else if (sysfs_streq(cmd, "erase"))
> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);

The above needs quite a bit more safety that the device is not currently
actively decoding any HPA ranges.

I realize now after sending the comments in patch1 that Sanitize defeats
the dream of being able to timeslice background operations. On the other
hand, it really is a special case that is only meant to be run before
decommissioning the device. I think it is fine that it monopolizes the
device because the device is literally unusable during the process.

> +	else
> +		rc = -EINVAL;
> +
> +	if (rc == 0)
> +		rc = len;
> +	return rc;
> +}
> +static DEVICE_ATTR_RW(security);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
>  	&dev_attr_payload_max.attr,
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_security.attr,

This likely wants is_visible() handling to hide the attribute if the
device does not support security operations.

>  	NULL,
>  };
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e7cb2f2fadc4..1dd1caabd41c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -215,6 +215,7 @@ struct cxl_endpoint_dvsec_info {
>   * @mbox_irq: @dev supports mailbox interrupts
>   * @mbox_bg: opcode for the in-flight background operation on @dev
>   * @mbox_bgpoll: self-polling delayed work item
> + * @sec: device security
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
> @@ -254,6 +255,10 @@ struct cxl_dev_state {
>  	bool mbox_irq;
>  	atomic_t mbox_bg;
>  	struct delayed_work __maybe_unused mbox_bgpoll;
> +
> +	struct {
> +		unsigned int __maybe_unused sanitize_tmo;
> +	} sec;

I missed this on the last patch, but __maybe_unused has no effect at
declaration time, only at definition time. Otherwise, I wish I had a
facility that would tell me which of my structure members are no longer
used in code.

>  };
>  
>  enum cxl_opcode {
> @@ -279,6 +284,8 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> +	CXL_MBOX_OP_SANITIZE		= 0x4400,
> +	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> @@ -473,6 +480,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> @@ -487,6 +495,8 @@ static inline void cxl_mem_active_dec(void)
>  
>  void cxl_mbox_bgcmd_work(struct work_struct *work);
>  
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd);
> +
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
>  	unsigned int decoder_count;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 82bdad4ce5de..fbf619976eb7 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -40,6 +40,8 @@
>  	___C(CLEAR_POISON, "Clear Poison"),                               \
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
> +	___C(SANITIZE, "Sanitize"),                                       \
> +	___C(SECURE_ERASE, "Secure Erase"),				  \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
>  	___C(GET_SECURITY_STATE, "Get Security State"),			  \
>  	___C(SET_PASSPHRASE, "Set Passphrase"),				  \
> -- 
> 2.38.1
> 


