Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C55C77B7F
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 23:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjESXNN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 19:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESXNN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 19:13:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4309112C
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684537991; x=1716073991;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jcxL8Dm5A/cvB5Yinup3Nndk7qTrOyglQg/LJAnj+h8=;
  b=dQqTz1gpNfUr8CVb5cP8l+airsc5m/G2PT3uXnqJOHxkMuMFuFjmU9/V
   yMTWwLUO4Sd8g0xgb2ZHZlmBvTNZXXz3rdLfofGm/tlc4alidNJX73GVp
   ET61Skjw/+NWG2uBu0tfdjYM9CMWvd9iGMEm0XRig2w/J4XQsTiPYZbQS
   DJUFFnKDFcbF3XMuEnG4oWGsX+H7cHRb3klbk8k5bpD9Txlj8FoJk17OI
   iFxnHxDAwE4czixoz2XbsNaWSc0IcJ0V9VnmUqoOsBYokdLzRxa1nY8Ie
   2uVVj4PmeMctIx74mfgLMNeHSPADNsHkmD9/CcC45kzAmiyajDXiLoC0K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="337098077"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="337098077"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 16:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="733466239"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="733466239"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2023 16:13:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 16:13:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 16:13:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 16:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5v6DNDSvjChH4KzDukyeIskSNcwHVjfbXE/tuadZLZZOAt+QEf+jdHY5zZ+/dFpx/M0yhixjSlg+g5AgqXP/fdkv+eP2H03Dg8xVHyE6HefZJlF40pFzV8rD8zNJHDmUjjiHCicyw7N2RXn9OhMqtNah60yqsZTi8E/5+tfPbY0z37QvKEooJdaYmoVUJ+KgeoaXyw3jTut9NZlICvy1pIpSZnTnOw3XQplCstVErNA/rfqrY1HaeFEJDAXgFXoYMYBEpYR8MWW7HB1kUZPq8knktnuxDhtybs8OERG3c0AjZz1ELDPp7JgjwtNZQF0sWVlMNMLhi+I1DSQ2Foh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfKNHX1QeZ7V6MrMAd9BGYAvscBLVhdBt0YfP9//Otc=;
 b=VX/IkpDhlP2YB9aQf5S3A0rcq+aGxxDDDfc+wWTHU5UPkaEdwVjlpEfGFslpdQYUIUxw+aLP/jR2geEaMicLThyaL1V20/6hg3jN3cjVyKMg5OGUod21WYDcnJs1JtxgyhDWdr6hat0KlYDoIU4YJsXHlAbVPrGDPgmWTuPevyBRc2fO5ZEmk6CZoKiVt4/NmSac4eMzbmerViaZGr7M8ZqTXxOZWeYvUL7xPwk2oQz6rxRg2Uiy8X+r7ogIVOOr4w0VjqskTGI+z91YrXpiSvyy4SqNqtrGoa3Lrv6FsZGa8UsVwGJjmjDm/tQ2TIvhYOOuGzA7jUBS73TAotFuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7127.namprd11.prod.outlook.com (2603:10b6:303:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 23:13:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 23:13:05 +0000
Date:   Fri, 19 May 2023 16:13:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3447e1-ea15-482a-0233-08db58be9978
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkRugqk1TMf8qaFM3BeOI8xCC95YK8BwCN8QgHpf1WU9x0hxzSNd38hSU+I6nuN6ZjcOz64WhPMEqw6r8tLt7SoeXjujNeZx0qDsZuhPaO3J01aaE/pnIhi/n7svuUwSjhEODK22P4pSIl84l78qQ/uEK8UmuE5ZZhqvKR8CEXv8EA+KpXDiua8usgXqYFMH0hsltKh/PdW7ExIU5FB7eQ3g1r5hwIQhudZXtGfjjybx6b895dmK7mbHT4pOb+byHRXQXqw25+fMS8j3aaPeKP/jCYKg9v1cSSC4HYAtWLvJnEIV4SSbE7kxMgPCsxV7YXabJi0lmj83JGSXemaMSc+1g+NOzys3US/Muvud3znaKNZYOeHPsh660/lJQo1Bmv4bSX9cRg74m1cvN0C3KyF4Cubph2fUdE3+Gq7748hBjcFsgBMyDyuePrmZG0CRlyHYi0s35HK6Twznf/qG5Fh8vDbvq7LnP//8UCjs9mAvvZeqYUXTFREeujD7ZXeT4tlzBK7Fn+1ODAKgPChdDQgNQc9pOKGSFTdHCd14FDIQf7WH15RmTaMSo2TqI8S4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(86362001)(66899021)(83380400001)(82960400001)(38100700002)(41300700001)(66556008)(5660300002)(30864003)(316002)(66946007)(4326008)(8676002)(66476007)(2906002)(186003)(9686003)(6512007)(26005)(8936002)(6666004)(6486002)(6506007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HPAc5FthWodRtquwKEaE4gA/FZIbzyM+jo7KTRPmRZIVac9nJ20a1OqC42DS?=
 =?us-ascii?Q?rGQq9jSiSYNKWaGvHebT9FI695QAZoMi82BFiODDbzVOeNP+JlQzzwm/ZhMc?=
 =?us-ascii?Q?uCD9IrVKyKbtsoTuOGM5EoLe3Zm0ApolRkN7Yu2g1R6r6IVzs04HIOGXH+8D?=
 =?us-ascii?Q?wZx0HmE8UKBmcPJTpiL5vlffzzKoDI8RsFQ4mIWUncD/42Wk4F7euzQ3SYfu?=
 =?us-ascii?Q?May5kdmRtc0QDL1Ib+5gobBwhWM+nfbsSoJqw6fbyChNQ0qiivM7hcaz1w3b?=
 =?us-ascii?Q?jpgtO5OivHMM8Lak3+O1ZrCg2VmHLZ+WC+EcYfynXjvRBwpxPQEUFBkuoehq?=
 =?us-ascii?Q?GC8qlcVtxwQuXLqyt774Q43ICe7jMaEHnWVT83LZs2KSqRM1MJnuF+oGd2W5?=
 =?us-ascii?Q?0KPaUIqsBIA5pkN0zswzlBE4dipQ707NlE2Wyw0el8NVRNvlxZEoXr3S5bSn?=
 =?us-ascii?Q?n/gs/ujdNmg2SYeDXcUto9z6RQXYupHHhja0TVd7vg37P3InzTya9INZliPH?=
 =?us-ascii?Q?SNlr9g5Er2it6EUfm/YvScB+pOHvSTNKpAYO7Pc+X0l0ZD0ZNEFiC0f/mAl3?=
 =?us-ascii?Q?Q0M67j3Bt/Aoluc72Ga31zD5HwHCEX6PQ2yooXJSUtfyn6elk+CJaY3o4RBU?=
 =?us-ascii?Q?53w9HAX5Il8innJnhMY9tcJjEmzd4QBwCFMkc4nUWS+2YPkzTH2fHZC0K6eL?=
 =?us-ascii?Q?ispc8PY/4MXPU+DDUXkseBaHp/9qkgFC6n03mYyVYH5B80R6hR8V5XfQbl0E?=
 =?us-ascii?Q?OiPeg23/nwHJyH3cyhSpZJYuR5K9AM3A92LN1+CQzTvj9mA5abi5G6zJB3KH?=
 =?us-ascii?Q?nVM/LQNDomzJGcxYsn89R4Dq8Aiaj6PliEZkhAAQ4GxNx9kzSp1OakbkhEwj?=
 =?us-ascii?Q?qGmXTEZ+OVbtrYm7EfY7tjmjm+RV1qTVcldIXWOCU+y+TnQQzxVT7J1p11AD?=
 =?us-ascii?Q?xhVzLyswpxyE+X+YRltPlTQNmAAQHzNNuQQLR4ejdTfRFisfgukmNJOyspIx?=
 =?us-ascii?Q?pqA66VQGnl/+VWWeEtwQpiH85fF58QZY3deWjdKVvsQajDKmIFNdj5IKa39Q?=
 =?us-ascii?Q?KcOi5mKXzVyhCJ0bhccNBeodEZNTbVQWFmSKiDLon6xZ0DiEij2cVeT3cEGN?=
 =?us-ascii?Q?ijSFt0PlEmI51kdUr1eP1VJdxAL1oJkqG7PmyzRJGU3MNy8Xqm9ykbn+lKP/?=
 =?us-ascii?Q?Z2pvItsyi+QdLfhMBZzct/Ugg0rc7Szhklq6DJRP4eawkIMeHkh4C4pN7IJI?=
 =?us-ascii?Q?5be2HFWcdiSeklWDGeX9U9Aovv/IOhw3mSdvTioLlZUw6X5e+9rPg4XSAUeu?=
 =?us-ascii?Q?tt+bw5ohl9rZRq5WxgERJVhUJUGmXacqwsYkwXDxCRkLgoAwx5RJkC4o+C1r?=
 =?us-ascii?Q?1h81dhi2yEJZ3OueVxxJvpFOblbqQjWu8/8GstLlP3r2IrwJRIy+cvLkdjwr?=
 =?us-ascii?Q?FW5Lhu0Nau3hW/74CN4jsRVfgXhUwHS+Xrq5+sIP957aPcaOrllw0TFeaBy8?=
 =?us-ascii?Q?Yrke8avEClVAt2rJhaGdKNd3JYEz6diumEINjD4qRaaKQ0V07U7RM3Hx/phI?=
 =?us-ascii?Q?EXQW2cB7QH6hJHJofH/WpFB2E9eei8GnpgWHBSVLx+HLwB9/8U2WxQ1hQQMu?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3447e1-ea15-482a-0233-08db58be9978
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 23:13:04.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAbJy0s3obt3HVK2r2SKEUxDp/INGkrzw5T2ZrdVE31yduJ2id/k5cXV1ocd+nHi8nx4RIo581XEfQEeFHHRwr685IWG8tndlsZAByVtGPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7127
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> This adds support for handling background operations, as defined in
> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
> can run in the background asynchronously (to the hardware).
> 
> The driver will deal with such commands synchronously, blocking all
> other incoming commands for a specified period of time, allowing
> time-slicing the command such that the caller can send incremental
> requests to avoid monopolizing the driver/device. This approach
> makes the code simpler, where any out of sync (timeout) between the
> driver and hardware is just disregarded as an invalid state until
> the next successful submission.
> 
> On devices where mbox interrupts are supported, this will still use
> a poller that will wakeup in the specified wait intervals. The irq
> handler will simply awake the blocked cmd, which is also safe vs a
> task that is either waking (timing out) or already awoken. Similarly
> any irq setup error during the probing falls back to polling, thus
> avoids unnecessarily erroring out.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> 
> Changes from v2:
> - make the wait ret a long.
> - pass correct param orders to the wait (cond and state were inversed).
> 
>   drivers/cxl/core/mbox.c |   3 +-
>   drivers/cxl/cxl.h       |   7 +++
>   drivers/cxl/cxlmem.h    |   7 +++
>   drivers/cxl/pci.c       | 102 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 23b9ff920d7e..7345ed4118b0 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -220,7 +220,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
> 	if (rc)
> 		return rc;
> 
> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
> +	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
> +	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
> 		return cxl_mbox_cmd_rc2errno(mbox_cmd);
> 
> 	if (!out_size)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..72731a896f58 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -176,14 +176,21 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>   /* CXL 2.0 8.2.8.4 Mailbox Registers */
>   #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>   #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> +#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
> +#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)
>   #define CXLDEV_MBOX_CTRL_OFFSET 0x04
>   #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
> +#define   CXLDEV_MBOX_CTRL_BG_CMD_IRQ BIT(2)
>   #define CXLDEV_MBOX_CMD_OFFSET 0x08
>   #define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
>   #define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
>   #define CXLDEV_MBOX_STATUS_OFFSET 0x10
> +#define   CXLDEV_MBOX_STATUS_BG_CMD BIT(0)
>   #define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
>   #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK GENMASK_ULL(22, 16)
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK GENMASK_ULL(47, 32)
>   #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
> 
>   /*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index db12b6313afb..d2f751d6583c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -5,6 +5,7 @@
>   #include <uapi/linux/cxl_mem.h>
>   #include <linux/cdev.h>
>   #include <linux/uuid.h>
> +#include <linux/rcuwait.h>
>   #include "cxl.h"
> 
>   /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -108,6 +109,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>    *            variable sized output commands, it tells the exact number of bytes
>    *            written.
>    * @min_out: (input) internal command output payload size validation
> + * @poll_count: (input)  Number of timeouts to attempt.
> + * @poll_interval: (input) Number of ms between mailbox background command
> + *                 polling intervals timeouts.
>    * @return_code: (output) Error code returned from hardware.
>    *
>    * This is the primary mechanism used to send commands to the hardware.
> @@ -123,6 +127,8 @@ struct cxl_mbox_cmd {
> 	size_t size_in;
> 	size_t size_out;
> 	size_t min_out;
> +	int poll_count;
> +	int poll_interval;
> 	u16 return_code;
>   };
> 
> @@ -329,6 +335,7 @@ struct cxl_dev_state {
> 	struct cxl_event_state event;
> 	struct cxl_poison_state poison;
> 
> +	struct rcuwait mbox_wait;
> 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>   };
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8bdf58c0c643..10dc4a4fbb4a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -51,6 +51,7 @@ static unsigned short mbox_ready_timeout = 60;
>   module_param(mbox_ready_timeout, ushort, 0644);
>   MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
> 
> +
>   static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>   {
> 	const unsigned long start = jiffies;
> @@ -84,6 +85,33 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
> 			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
> 			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
> 
> +static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> +{
> +	u64 reg;
> +
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
> +}
> +
> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +
> +	/* spurious or raced with hw? */
> +	if (unlikely(!cxl_mbox_background_complete(cxlds))) {

I expect this will fire all the time. While the specification allows for
a vector per-reason there's nothing stopping an implementation from
using one vector for all reasons. There's little incentive for spending
silicon gates on exclusive vectors since none of the CXL interrupts
service software fast paths.

> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +
> +		dev_warn(&pdev->dev,
> +			 "Mailbox background operation IRQ but incomplete\n");
> +		goto done;
> +	}
> +
> +	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +	rcuwait_wake_up(&cxlds->mbox_wait);
> +done:
> +	return IRQ_HANDLED;
> +}
> +
>   /**
>    * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>    * @cxlds: The device state to communicate with.
> @@ -177,6 +205,57 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> 	mbox_cmd->return_code =
> 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> 
> +	/*
> +	 * Handle the background command in a synchronous manner.
> +	 *
> +	 * All other mailbox commands will serialize/queue on the mbox_mutex,
> +	 * which we currently hold. Furthermore this also guarantees that
> +	 * cxl_mbox_background_complete() checks are safe amongst each other,
> +	 * in that no new bg operation can occur in between.
> +	 *
> +	 * Background operations are timesliced in accordance with the nature
> +	 * of the command. In the event of timeout, the mailbox state is
> +	 * indeterminate until the next successful command submission and the
> +	 * driver can get back in sync with the hardware state.
> +	 */
> +	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> +		long ret;
> +		u64 bg_status_reg;
> +		int i, timeout = mbox_cmd->poll_interval;
> +
> +		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> +			mbox_cmd->opcode);
> +
> +		for (i = 0; i < mbox_cmd->poll_count; i++) {
> +			ret = rcuwait_wait_event_timeout(&cxlds->mbox_wait,
> +					cxl_mbox_background_complete(cxlds),
> +					TASK_INTERRUPTIBLE,
> +					msecs_to_jiffies(timeout));
> +			if (ret > 0)
> +				break;
> +			if (ret < 0) /* interrupted by a signal */

Have you tested this path? I am curious what happens on the next command
submission? As far as I can see foreground commands would not be
impacted but the next background submission would fail instead of wait,
right?

Perhaps a dev_err_ratelimited() message and an EBUSY status for when
that happens to at least indicate, "hardware is still chewing on a
cancelled request".  Later we can think about whether that's recoverable
via a reset.

> +				return ret;
> +		}
> +
> +		if (!cxl_mbox_background_complete(cxlds)) {
> +			u64 md_status =
> +				readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +			cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
> +				    "background timeout");
> +			return -ETIMEDOUT;
> +		}
> +
> +		bg_status_reg = readq(cxlds->regs.mbox +
> +				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +		mbox_cmd->return_code =
> +			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> +				  bg_status_reg);
> +		dev_dbg(dev,
> +			"Mailbox background operation (0x%04x) completed\n",
> +			mbox_cmd->opcode);
> +	}
> +
> 	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> 		dev_dbg(dev, "Mailbox operation had an error: %s\n",
> 			cxl_mbox_cmd_rc2str(mbox_cmd));
> @@ -271,6 +350,29 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> 	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
> 		cxlds->payload_size);
> 
> +	rcuwait_init(&cxlds->mbox_wait);
> +	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> +		int irq, msgnum;
> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +
> +		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> +		irq = pci_irq_vector(pdev, msgnum);
> +		if (irq < 0)
> +			goto mbox_poll;
> +
> +		if (devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
> +				     IRQF_SHARED, NULL, cxlds))

This needs IRQF_ONESHOT and that @dev_id needs to be globally unique in
case @irq is shared. So I think you want to factor out a common helper
from cxl_event_req_irq() that this can reuse. I.e. cxl_event_req_irq()
already gets the flags and @dev_id right, so just create a cxl_req_irq()
that takes the irq as an argument and share it.

> +			goto mbox_poll;
> +
> +		/* only enable background cmd mbox irq support */
> +		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
> +		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);

Just in case some other code ever enables doorbell interrupts it would
be nice if this performed a read-modify-write rather than assuming it
can clobber that setting.

> +
> +		return 0;
> +	}
> +
> +mbox_poll:
> +	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
> 	return 0;
>   }
> 
> --
> 2.40.1


