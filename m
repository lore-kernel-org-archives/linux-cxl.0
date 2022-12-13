Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54F1C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Dec 2022 00:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiLMAMd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Dec 2022 19:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiLMAMb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Dec 2022 19:12:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492DF1C91F
        for <linux-cxl@vger.kernel.org>; Mon, 12 Dec 2022 16:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670890351; x=1702426351;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3xav9uMLewGd92f8EeP+3vaAOYl//G5h/i8HhFGIylY=;
  b=BwrKHLzuLbnY7yEOvWhsL4yDElgOmanJu14PvXy0kWDhaJTMm/FyONrL
   CqyT1zhXdeVw8FYE+B+acF5C3rt73CV0vUwXvSG07i8kudnoPuOcsrVlE
   ORHh3NHLfEZnZPBfxQ+pcx4HTHg+DiqbJxJ1uEGxmHS6WKGS4mH3XnmqX
   +FYL+mmS2TyWp0u1aVQi4s56xmo9PCyLgqT4TRbcXB+9Ze6GPvgeDqyuR
   N1BlH9f+VJi11pIN2c6F9HjaywT+BzHFHgn2T1GnmGCdmg7+t2BfpjoFs
   DdUi5u9KmuEm06DBKLkZdWd3ZkZik5z7zLndmcSQKCZvc51gG9xOmC6t4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="315631412"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="315631412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 16:12:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="790692062"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="790692062"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2022 16:12:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 16:12:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 16:12:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 16:12:23 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 16:12:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8DWs1n8OZIShObU4zS/oSnY+dQkdxZXciIHUPSScVqRFdMjiHKagwNGJcC7vL6SWgVYnrmlZ+Q5fhlDpFiBReChtWLui84nQYftagfuv1vIcr7uhvAjtkAReMNU68DsZfOQxL7rTS84aEaEq5QMb5TewxC32YT9xJOFj6KQw7Q/XDKm1t3oqi9rbReNUp+SeSxyYQ6wVib0oCQH4BUtk3HOzDW77LqtIXwOQK0TxsP5TQdYiNDs4RZ9c1KfkMgsBdmi/2ExD7MsL42vOsf6Tnm2DAeoxH0nvzdTV4ep/2IpagOsnR/83gy2e/zbUB0YMwno9O3PjJjSuXEJBG2vaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdHhaimD/iBdpP5wvFiYVGOJtHVkWI7Q5xg4R393iRA=;
 b=OlvHV65mkNZ0Bhk5KdhQ+uNEQkTZAomrg/4Xl52DYaiwKt+ndri1yioCBhX/NJdCaHCKx8/eNvN/4DtghQWO065CCzba/MzGS6iE6uQLXm4wk0DMJh+SL3kIyt+bzK9RKONybQIGQ/ck5Kxmg7yk9fdVCCxwq4QJDE96LkN7xrHexFn+Us4bBy54GIcvokx6EB4SyQtvZ6PNgXkvkMxtXDxuR+PlKcO18FlljilRzMPS5VvQaqRsJVf7hfT6BRArx3lUvZHKBWF9coXElDPNi5d4Bk5jjxkzX3hQecFgoLWP4y6jeSVhoGixwjciPzg+EskEkUW4o6yV3wkG19ZB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH3PR11MB7345.namprd11.prod.outlook.com
 (2603:10b6:610:14a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 00:12:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 00:12:21 +0000
Date:   Mon, 12 Dec 2022 16:12:17 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: RE: [RFC PATCH v2 2/4] cxl/mbox: Change parameters to cxl_send_cmd()
 to not assume a cxl memory device.
Message-ID: <6397c361826e2_b41e3294bf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
 <20221025104243.20836-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221025104243.20836-3-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::41) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CH3PR11MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddddfa6-137e-4398-6392-08dadc9eb384
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9trrg3NnVPOyRmk9oXPlrVn+c4koByA6imSWMgxp5fZNKTOOnkDzGSTPsifwNKMYW9muXbzEBcPsbzw38n6EAm3aXcnf4AXkjpdWo0o5zEiV83dzyh6bdM0WM6o8BNIaYXVel456K4IiwmX78MnJbZfq7z1YolWoT4Kcy4NY1KgJnemvM1fgJqVLT0+SRFAzBEjurVS2vSJy8T4dNsIWEnSSasFPOT20x111IzS0lt4E3yG1LCXhvEPTeYJrF2MBWS/rZiDRyBr55ZTiUNZdGKJZjXMj9taKV+oSBLT3k12YzO5qyv9kojX7t1Bqk75pUyt3jk3r0roa2exPFSNaPe+GDUMA7ubuAY99IWjvJXhLf77WzOuGyzKnJOxNmXgaDIEAUOWwomTDr/xRxI4MqpNi1VJb7Pd1sr5DyT+8GTgLntrkwe2sZxVXSonh7r6fqK2wDrzxV5i4G2m8iRz4D4FQFQCs9tG+51+VP63j838ZC45bnud/wfLo6H4pDlU9BzAnsDHYc3kRb1Jtxc77LE3wMs3I6oEKjKoRfPFVCMtqPnKuhxc4U9z9bPgJrAmoll9ZNTpxEijN81HEs+Zp0jDx1g9uhTk9dwpifz1BsU4wgV558/ppwGhwlsRfuwtThJ4DK6KI45C9wsIDcshWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(38100700002)(82960400001)(2906002)(6512007)(6486002)(41300700001)(186003)(26005)(6506007)(6666004)(8676002)(66476007)(66946007)(66556008)(5660300002)(8936002)(4326008)(86362001)(478600001)(9686003)(316002)(54906003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sXAnvEVI+ewFEtlGiBOu7TE4OCgFrjwNBefTNRpCnmNbAwkepDABDE+pOiWh?=
 =?us-ascii?Q?VH/n6nh3q2QiCVY9t+QpciJhSk967M/Sd9AxY5rKRoRpdS9WWruoQ4l58BZ5?=
 =?us-ascii?Q?rFCfxlyvRaA3PNmWqAn/r6qw7ViclgICSXYNBgE1y7d2KQyWye5gKuNVyYR9?=
 =?us-ascii?Q?XASpQxT5mb5460HfzriANZIAxRx3rt2Oc+t5n/S8wveMtnRgP1W3AIG8cS18?=
 =?us-ascii?Q?ic43RDlbCkhZkdtg6cjSwd02MeSr0DLPmAOkZ/CEnzsP6y2Z9x+U04aptVoS?=
 =?us-ascii?Q?R+2KiTwV2pFtdprrB91nmC2cEM96gh+vnpwjxS0aXzSiOM5UYDcn1o0DSSRq?=
 =?us-ascii?Q?6w0nSHO7h6UCkkCiASwH4BbVLLeJhnqD7rgBzX8frwlpfAAPPEIGogXCz8Yu?=
 =?us-ascii?Q?ZefVlqVmzKYkTWbm6g94uycez/AKd3CxAbovuOJRf8erjvsbXy7FaTn+VtrY?=
 =?us-ascii?Q?9n3RuB9Z2YE08yWdrOBBOiwvsGvEVN78PEURY54eKKiijvbdOlTBtgXLMzgk?=
 =?us-ascii?Q?d3Xdlaw5DAd36vpBke5DiipOEEGv83fpXVcXa37LBhqOKtK1i7yEdFow5JAq?=
 =?us-ascii?Q?HFKhxhjBYu8Fj7sovGFSIoVVcktapg6d1qUqo3Z8cbMhxhdh/BrAgCCVfcWu?=
 =?us-ascii?Q?+66bFCTPYFAORvT0INx3nFVmX9AQGYwP1PA72cEwL7UhWvrVGVD8rKWP96sd?=
 =?us-ascii?Q?mPSFdfTjbPVviiNKte9ogvVkdwiEEPSYNFyLR7+6Dfs6c5LfPdl2R5Was397?=
 =?us-ascii?Q?6T2RZSRURKocjATbKxjjxAI0f9Gu74P/2V0M1j/3wk2aT/R2RT62vi4v4eVN?=
 =?us-ascii?Q?RqW0j2VZBlKdMJ3tTbntdG3ZK0QC4j9ph8j6NwfeDiIh7Rssrabtk95+7rQC?=
 =?us-ascii?Q?CLY9A96sJPP+ajGvWbLa4S7BM3b3nxzpv/OHB4+l1Th/gN2gAXiN0vvUMmeV?=
 =?us-ascii?Q?2mTDlfjJuoqzorODzmT7drUyyDUANnx/DKAVb42Jaj/hImEypQmh52QdWsus?=
 =?us-ascii?Q?gi0dvjjoagWMhT+N95osr1Cy8/DqeAu4VJa3ilKWjq8rmKTHIQCjvPSUeNqE?=
 =?us-ascii?Q?tV81MhG3othd8izlARFF0tBX5JmHymdaHgG44yG3ifXRmBfZ0Vr/evC38XKG?=
 =?us-ascii?Q?2enp9xo0iqTkrrmiJI9EOV+ku19w0dYGfpp9DmMTZNYtvlO0UnFS0As+CqkQ?=
 =?us-ascii?Q?I8GRmCUnERXvvZpLw512dfHIxq/tJhGd0q7pQEBfHdVCDJbyn0KGslNEWBIv?=
 =?us-ascii?Q?yM3rtbJYUS6p9IXOlbRWwUI82vS2rf+DE4NT8mURClpK20nYv3+c4ncga9J9?=
 =?us-ascii?Q?mBaBl3iJ7nOrGsLSEodaxmRysTIg78JlQvRSb8jcMReieSQn3a7xsN/g6BV3?=
 =?us-ascii?Q?xoHopuPBx0Ke2m0JwtQs5rr8xzXmv2tWpjjZJIeyI4Axm4OFBo+s8q03kzMI?=
 =?us-ascii?Q?gBJa/AevI7ZCOEasgALoUBwmJ7akot+FglfwlK5iuk/UCfz60+o45SNuuBlx?=
 =?us-ascii?Q?LGbQjC21zWnXVfRU15S2Y2+R7YgiKtu407jvo+yzxrbUiVrtrMi/Vjtx7Go3?=
 =?us-ascii?Q?d2XYwCbSOsMrAPHjpVoOXuT0xw3g8NiJjYjOQLTcAWL9tR6nyHYw1M2RZwXy?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddddfa6-137e-4398-6392-08dadc9eb384
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 00:12:21.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8hY7U9zlHJboyrzE0xXwSGijpgmiJp+a02j1xkSv2+rnK1Z30hyyUBppiilsoM8gmvdxKqH4cydQ0uJs+gq8JOdXfeCPfpLUJ0wntT+gaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Intent here is to enable CXL switch CCIs in the following patch.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/core.h   | 5 ++++-
>  drivers/cxl/core/mbox.c   | 5 ++---
>  drivers/cxl/core/memdev.c | 4 +++-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1d8f87be283f..0835942bcea6 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -41,9 +41,12 @@ static inline void cxl_region_exit(void)
>  
>  struct cxl_send_command;
>  struct cxl_mem_query_commands;
> +struct cxl_dev_state;
> +struct device;
>  int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  		  struct cxl_mem_query_commands __user *q);
> -int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
> +int cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
> +		 struct cxl_send_command __user *s);

Me thinks this wants another level of indirection to move the generic
mailbox bits out of 'struct cxl_dev_state' into a common structure that
endpoint and switch drivers can include in their local driver states.

>  void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  				   resource_size_t length);
>  
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index dd9e0aac37ae..3823d450fdd2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -526,10 +526,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>  	return rc;
>  }
>  
> -int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
> +int cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
> +		 struct cxl_send_command __user *s)
>  {
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct device *dev = &cxlmd->dev;
>  	struct cxl_send_command send;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 20ce488a7754..62840a6da140 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -269,11 +269,13 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>  			       unsigned long arg)
>  {
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct device *dev = &cxlmd->dev;
>  	switch (cmd) {
>  	case CXL_MEM_QUERY_COMMANDS:
>  		return cxl_query_cmd(cxlmd, (void __user *)arg);
>  	case CXL_MEM_SEND_COMMAND:
> -		return cxl_send_cmd(cxlmd, (void __user *)arg);
> +		return cxl_send_cmd(cxlds, dev, (void __user *)arg);
>  	default:
>  		return -ENOTTY;
>  	}
> -- 
> 2.37.2
> 


