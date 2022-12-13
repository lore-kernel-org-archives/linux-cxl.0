Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B19C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Dec 2022 01:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiLMBOJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Dec 2022 20:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiLMBOI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Dec 2022 20:14:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AA5F2
        for <linux-cxl@vger.kernel.org>; Mon, 12 Dec 2022 17:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670894042; x=1702430042;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bVn4+UehiurP4GEIP6HzERE74UaIRq50z5HxIIzvchE=;
  b=gXSht4ErWczAu4OnUxQOlzL88dSosG/aypoEKupmooKmBJ8REQXeGFB4
   Ve+gw3kxKw4lIYxXUNfdUw/GGLcIM3225yExOMSZtfIf5eUyykdnZvAfi
   OfREA+T3vnYxXaiwBnrnvqMJduxTVXNsqNgxuJLNF/dVUcWHlmy+yzZRm
   PbeRkgYnRo15R18Uv+OpLHOrv8Nw6CoBvkx00pYZOu8mxcrMmQgnYYJY5
   xgecFc1jQ9KfJdfDDVOdRVGSI6IU1WSQ/JUVpoPJrvokJDx5S/zxocJ8Q
   A//eesH4vycKNNBU9L7uxfW+AG3Yu5Zpq9rNwI3TUTKIujmsLBEp4wRTa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="404260675"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="404260675"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 17:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="626107807"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="626107807"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2022 17:14:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 17:14:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 17:14:01 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 17:14:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCsucklTq654bVZSvJ99sgG6q+LARmMIOLnadTQAw21xq6RzIxiinD91Tlcw/fd39h1rB1hqX46ibVCd2hgwzBYi5f0wBv9gOeKUsZmRPSPZD0ykpKIFe3JkuKTVvmR4+ANbalkuhrt4WJVCEONOLwEY9aKsLR6/lkgtXsaLxcCMnVJEsDGDMpPeQPUQ76lIVbqe1D1IoN4WOx9V+nCkEVLKILh5B6jbS6wSec65gFAAaAGoF1vooDfE3Y0s2vQPEsv1pxQhkf1vxuiYHEmnErNs4h6q/wATzIf83H6KZV7n/AGxD6MUQWCP4LbeLZm0xWqfgTlwyIZ3XMNhIMe1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkhyK17cv+8dYuaf9K/lfNSfpbYC1MroT4UEt0bPPOQ=;
 b=Ut8aVg5DFrL0mWCOrNUlis6gLRkLsNgYqm7Kt6w1Hkkhl1fXwycREjbIUhlJdnZx2RgVq02TRWLK4fy7zK3fetystdOhE2ixdEtTufKkaHyvt9nITyBJ48J3Yq9bdsFn3IjHCL0c/V/Qm7SieGS8lAPT22uxVZl3e19sDTM6Blw/NPFyD/ffzkqMAMZXQBMuDHefATYjCwPkKpvxff0t4qLgM+zKQwMDsm3nz+qin4X/PV32bCF7wWfUbsMQfa72VqVU+hPL04BMgq8PGQv2Cr8sLK/DsXt4ixaZWZKAbLyS0T5UZqOpkNChTBKLI++2p7u0m2Hndo4vd33cCuyAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6420.namprd11.prod.outlook.com
 (2603:10b6:208:3a8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 01:13:58 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 01:13:58 +0000
Date:   Mon, 12 Dec 2022 17:13:54 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: RE: [RFC PATCH v2 4/4] cxl/pci: Add support for stand alone CXL
 Switch mailbox CCI
Message-ID: <6397d1d288fed_b05d1294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
 <20221025104243.20836-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221025104243.20836-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3738c74f-2887-4868-38fc-08dadca74ef4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5TIy1N+OajLwnu7qXRAlaqnsSrhs1Ofs+UKfiSseInPonHr7aWh+CzHu+uhleZPyOfQMKOxGUUqADHx1qiC/r2A4HX7Eo6ihkaInCj/Zi3ezfU2ydBIGlSxqNrH42esMzXVKvK0wN+sWffXzw1QRivUZ9q1OLPADKEWO3RPk0gojCU8YNWxlOuhvJXEU5wc8mGbr7jTPGzWkGvLI6+unUxg5mXbaXqLqmZ57QD57OFXD8qtUeKahxPbu6uiyBgFDOiGv/nTCL1ZZHjlGoJUdbrFj1k/M215Y/2JdWrAUohY8qMo0CI5DtRkUab8OYwH5psHrkykF69oIqXpX0aAjho8vh729YhdNQsIgSbT7z8m/cJ0j7uHsPZGQ46+rXh/QXfwdyV/GCN5FLgCCnyq4vGC/5JtJsjVmBe+dASml7Ojv9gPOTEYk38Fpdr7SPLclIZflPb0yCBZ5Q2GE7klcYUcUWA9MVsFOXOyvWIy5ZXKEg8pWRdlmUxuFA1ATajm+GlXNwZorpAMQfrngKwDUdeatRZhwGxje51IpgmJRyAlLBwhvuv/cf4VcC0Fyl9oLkjTO0x73hh4ls6/BYw8jF/4lvVoBzU1FqrHYg5epiLs59c/nwwuNj2z4FlKxMxmXpUHoEZLHPUbatpvHiESkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199015)(83380400001)(6506007)(15650500001)(41300700001)(316002)(2906002)(8676002)(66476007)(4326008)(66946007)(26005)(186003)(5660300002)(30864003)(66556008)(9686003)(8936002)(6512007)(54906003)(86362001)(6666004)(6486002)(82960400001)(478600001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LXeA/0A8PCdH4w3VjK6l8LOdSG4DAlotzijHvpB7lazpWz3431kVk5H8iyYH?=
 =?us-ascii?Q?D1ofUMAhB0V1w3BCQBkwYC3fktDFeGN/lNmIdL0ayBKPEUf35LzRWYgOt0ld?=
 =?us-ascii?Q?FGAuOF8cs81pGEL8C50BuJpXwy5Uq9djYgrHtI9cluOKTz88l4AAQs0ZrwMj?=
 =?us-ascii?Q?rkzAkT898/Kcf7bERoq0SLAKs4rqjXWLtHeigsDTeL6zNFlXq7au1yZc3+pR?=
 =?us-ascii?Q?j2b7W9Enp6N1uACzN+S5MvajBIRADS22ts3z5n1i43QUgMiBK+zH1/iFMlyu?=
 =?us-ascii?Q?Gi4hz09tnwCfn60s0RmnO9jYRzMuSySf/rp7YKQE+N+ARCTrwpbSzqgq8awS?=
 =?us-ascii?Q?Pxik8qkO7FMOFuBtzDLk9XEzLSLjB6U5LVjs1i9SR5Mp5v9vbmtYYFwAfHw7?=
 =?us-ascii?Q?dQZbwrCBIijbTag/p4Um2aD46corA/GsAu+qPNg10zcl2EcTfDPgmU+bGCcn?=
 =?us-ascii?Q?8v3WKW+m4QkCj5u6xTUpDRLh28H46c12H3sMm0YpuCqqQleNtpILeQ0wE7UP?=
 =?us-ascii?Q?eR1IAiwJ2hgrS8zVUDXIaknSlN2GoGAlcbkKD+QTk3sT+Pd0W6Ky6UWaSOSk?=
 =?us-ascii?Q?0E6gBf5YlKBaPyIaizeYREPVBcIL8rXpI/UclgEranri1a63f/cBWxXwPDY8?=
 =?us-ascii?Q?k8M+HclA6SaQpzIkzkQMy5oEmy3uE2aKaIWL0W0k1bXW56qyDWPHhrS03Au6?=
 =?us-ascii?Q?RHRJGwxvOsnis81twA/34q2NZNdgAqOxwrvxzTR5pyqsIjlupkeplnpvcSvZ?=
 =?us-ascii?Q?iiGBhNvMDOf9VnYneKuRCXGdX3JN0yozD2HqRgbg/u97+iS/y59t6i5jz9+o?=
 =?us-ascii?Q?6u74SOvzICZr8E/1L1+3XsNDIpILILY+WQPghpEtOjEZHT376C5D78J6/yn5?=
 =?us-ascii?Q?bga5MYerqXAYSXtvfOr00hbZMsEAT8Q4IbYly85JMkrQnJWHaFVQFJEIAzDN?=
 =?us-ascii?Q?dWVZFFeEeGtgLl2+2w3zJRX/JSUeXe0Khzp62eTKYlDno+Y42Jd4mstyZWHx?=
 =?us-ascii?Q?KmjRmVuCv5nhh43Pl83SD0a+j5rkLzfvfvG9GQfQsmMwCL7lXHQ2HMYUN0lP?=
 =?us-ascii?Q?W0Sn3ioiGcEbX8hOcn0r2KzRtgXheNTnc87GTo9ZeUH3aYOZhhX7IQ1wvO2I?=
 =?us-ascii?Q?J1nj4OW6fcw6a+I6JDwK8LJnkIvtQRro6CR688nWDee9ejiDdkcZjPF86nwU?=
 =?us-ascii?Q?9HIO6zsvBzRZwI2daT1fierI+dItdLrmHcBnW0M4aYP7QDV08LE588D+cx2a?=
 =?us-ascii?Q?v7CUr6x4hr3e7kwzR71BSIoO0lAyDD6ZKPFpEHTHNKV5lmjceobKin4Yx+tG?=
 =?us-ascii?Q?AQQZsf6ud7ce0PtGniJ+6o85CKGJ8Jqbl2AngY6EY5uFnghxVaHpEJWdzvi4?=
 =?us-ascii?Q?fx7wVk0u0dTjm1XxSFNou5ovZGncqvoWhSjxZtcsqPYw7jNS69T+h1MFbDbd?=
 =?us-ascii?Q?Litz+WNG7FX13WoZKFrJYmunM3Cd881UcRuOGOBlfMWFPWn5Q6J6OY4MLOci?=
 =?us-ascii?Q?lDOpORClslmD76LHeAi7rE1oVJvxz9Fz3eNpVU8no3EbsTOZskGcdmlsZ9gC?=
 =?us-ascii?Q?BY9dQiuBJS8AcM3I4+lFZVTUZzh9kQNVdqjYVH8Er2TDARxjG04viCKMlJZl?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3738c74f-2887-4868-38fc-08dadca74ef4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 01:13:58.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS7w7aGhqa9SdzReKTyIV+WaK9aOfy+Bhk+ME/kmiiAfKYnmaW+yN/SxCnAkArIt9VrdPynGPnokQTYko6+SDzTro8uqVMlfBBvfCwYjVT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6420
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> CXL 3.0 defines a mailbox PCI function independent of any other CXL
> components. The intent is that instances of this mailbox will be found
> as additional PCI functions of upstream CXL switch ports.
> 
> RFC: Including this directly in cxl/pci.c as a second pci_driver, is a
> bit hacky.  The alternative is to factor out all the common
> infrastructure to a library module shared by the Type 3 PCI driver
> and the Switch CCI driver.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> V2: Thanks to Viacheslav Dubeyko for review.
>  - Drop double free of IDA in error path.
>  - Switch to cxl_send_cmd()
>  - Hex constant for size.
>  - Shuffle code to put the release down near alloc.
>  - Correctly handle shutdown in unregister path by setting the
>    cxlswd->cxlds = NULL.
>  - Use new define in pci_ids.h instead of opencoding the class code.
> 
> Options to consider:
> 1 - Factor out all the shared code and have a separate module for
>     switch CCI driver. Messy!
> 2 - Is sharing the allow lists between type 3 devices and switch CCI
>     an issue? Not a whole lot of overlap...
> ---
>  drivers/cxl/core/Makefile     |   1 +
>  drivers/cxl/core/core.h       |   1 +
>  drivers/cxl/core/mbox.c       |   5 ++
>  drivers/cxl/core/port.c       |   4 +
>  drivers/cxl/core/switch-cci.c | 149 ++++++++++++++++++++++++++++++++++

Warning, incoming bikeshed comment: How about dropping the CCI term?
It is really only used in the specification to indicate the class of
transports that can convey CXL commands, but as far as Linux terminology
it's just a mailbox. As for the filename, perhaps switchdev.c?


>  drivers/cxl/cxlmem.h          |   3 +
>  drivers/cxl/cxlpci.h          |   3 +
>  drivers/cxl/cxlswitch.h       |  18 ++++

The only reason the "cxl" prefix is there for cxlmem.h and cxlpci.h is
to not collide with "mem.h" and "pci.h" for usermode-linux builds and
the like that confuse the core that includes those headers by include
search path. So this one can just be switch.h unless and until a build
robot says otherwise.

>  drivers/cxl/pci.c             |  95 +++++++++++++++++++++-
>  include/uapi/linux/cxl_mem.h  |   3 +
>  10 files changed, 281 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79c7257f4107..18275e153437 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -10,4 +10,5 @@ cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
> +cxl_core-y += switch-cci.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 0835942bcea6..f6a35e7f980c 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -73,5 +73,6 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> +int cxl_switch_cci_init(void);
>  
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3823d450fdd2..76987f2e30e2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -5,6 +5,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/mutex.h>
>  #include <cxlmem.h>
> +#include <cxlpci.h>
>  #include <cxl.h>
>  
>  #include "core.h"
> @@ -43,6 +44,8 @@ static bool cxl_raw_allow_all;
>   * 0, and the user passed in 1, it is an error.
>   */
>  static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> +	CXL_CMD(INFO_STAT_IDENTIFY, 0, 0x12, 0),

Ah, guess this answers the earlier question about raw only or not.
However if there is a non-zero possibility of this being used in
production then it likely does want to be formalized.

> +	CXL_CMD(GET_BG_CMD_STATUS, 0, 8, 0),

This is only for "Bind vPPB", right? In that case the result of the Bind
comes via an event, correct? Perhaps this command does not need to be
exposed. At least there is no use case to expose it even for endpoint
background commands since userspace has no mechanism to reliably
associate to which command that status refers.

>  	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
>  #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
>  	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
> @@ -65,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(IDENTIFY_SWITCH_DEVICE, 0, 0x49, 0),

>  };
>  
>  /*
> @@ -552,6 +556,7 @@ int cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(cxl_send_cmd);

Why?

>  
>  static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8 *out)
>  {
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index bffde862de0b..3b2e93bc4684 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1859,6 +1859,10 @@ static __init int cxl_core_init(void)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_switch_cci_init();
> +	if (rc)
> +		return rc;
> +
>  	cxl_bus_wq = alloc_ordered_workqueue("cxl_port", 0);
>  	if (!cxl_bus_wq) {
>  		rc = -ENOMEM;
> diff --git a/drivers/cxl/core/switch-cci.c b/drivers/cxl/core/switch-cci.c
> new file mode 100644
> index 000000000000..8c3f2b8a3b53
> --- /dev/null
> +++ b/drivers/cxl/core/switch-cci.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <cxlswitch.h>
> +#include "cxlmem.h" /* For now to get the cxl_device_state */
> +#include "cxlpci.h"
> +#include "core.h"
> +
> +
> +static int cxl_sw_major;

I would expect to just reuse (and rename) cxl_mem_major for any CXL
mailbox like character devices.

> +static DEFINE_IDA(cxl_swdev_ida);
> +static DECLARE_RWSEM(cxl_swdev_rwsem);

Not sure this needs its own vs share a common one across endpoints and
switches.

> +
> +static inline struct cxl_swdev *to_cxl_swdev(struct device *dev)
> +{
> +	return container_of(dev, struct cxl_swdev, dev);
> +}
> +
> +static char *cxl_swdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
> +			kgid_t *gid)
> +{
> +	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
> +}
> +
> +static long __cxl_swdev_ioctl(struct cxl_swdev *cxlswd, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	switch (cmd) {
> +	case CXL_MEM_SEND_COMMAND:
> +		return cxl_send_cmd(cxlswd->cxlds, &cxlswd->dev, (void __user *)arg);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static long cxl_swdev_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	struct cxl_swdev *cxlswd = file->private_data;
> +	int rc = -ENXIO;
> +
> +	down_read(&cxl_swdev_rwsem);
> +	if (cxlswd->cxlds)
> +		rc = __cxl_swdev_ioctl(cxlswd, cmd, arg);
> +	up_read(&cxl_swdev_rwsem);
> +
> +	return rc;
> +}
> +
> +static int cxl_swdev_open(struct inode *inode, struct file *file)
> +{
> +	struct cxl_memdev *cxlswd =

I do think a common cxl_dev is warranted, but this looks like
s/cxl_memdev/cxl_swdev/ typo.

> +		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
> +
> +	get_device(&cxlswd->dev);
> +	file->private_data = cxlswd;
> +
> +	return 0;
> +}
> +
> +static int cxl_swdev_release_file(struct inode *inode, struct file *file)
> +{
> +	struct cxl_swdev *cxlswd =
> +		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
> +
> +	put_device(&cxlswd->dev);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations cxl_swdev_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = cxl_swdev_ioctl,
> +	.open = cxl_swdev_open,
> +	.release = cxl_swdev_release_file,
> +	.compat_ioctl = compat_ptr_ioctl,
> +	.llseek = noop_llseek,
> +};
> +
> +void cxl_swdev_shutdown(struct cxl_swdev *cxlswd)
> +{
> +	down_write(&cxl_swdev_rwsem);
> +	cxlswd->cxlds = NULL;
> +	up_write(&cxl_swdev_rwsem);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_swdev_shutdown, CXL);
> +
> +static void cxl_swdev_release(struct device *dev)
> +{
> +	struct cxl_swdev *cxlswd = to_cxl_swdev(dev);
> +
> +	ida_free(&cxl_swdev_ida, cxlswd->id);
> +	kfree(cxlswd);
> +}
> +
> +static const struct device_type cxl_swdev_type = {
> +	.name = "cxl_swdev",
> +	.release = cxl_swdev_release,
> +	.devnode = cxl_swdev_devnode,
> +};
> +
> +struct cxl_swdev *cxl_swdev_alloc(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_swdev *cxlswd;
> +	struct device *dev;
> +	struct cdev *cdev;
> +	int rc;
> +
> +	cxlswd = kzalloc(sizeof(*cxlswd), GFP_KERNEL);
> +	if (!cxlswd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc = ida_alloc_range(&cxl_swdev_ida, 0, 10, GFP_KERNEL);
> +	if (rc < 0) {
> +		kfree(cxlswd);
> +		return ERR_PTR(rc);
> +	}
> +
> +	cxlswd->id = rc;
> +	cxlswd->cxlds = cxlds;
> +	dev = &cxlswd->dev;
> +	device_initialize(dev);
> +	dev->parent = cxlds->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->devt = MKDEV(cxl_sw_major, cxlswd->id);
> +	dev->type = &cxl_swdev_type;
> +	device_set_pm_not_required(dev);
> +	cdev = &cxlswd->cdev;
> +	cdev_init(cdev, &cxl_swdev_fops);
> +	rc = dev_set_name(dev, "swcci%d", cxlswd->id);

How about just "switch%d"? Likely this will also want some late binding
linkage to the eventual cxl_port that gets registered for this switch.

> +	if (rc) {
> +		put_device(dev);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return cxlswd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_swdev_alloc, CXL);

I think a few exports can be saved if this is changed to alloc+add like
other cxl core apis.

> +
> +__init int cxl_switch_cci_init(void)
> +{
> +	dev_t devt;
> +	int rc;
> +
> +	rc = alloc_chrdev_region(&devt, 0, 10, "cxlsw");
> +	if (rc)
> +		return rc;
> +	cxl_sw_major = MAJOR(devt);
> +
> +	return 0;
> +}
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..ef9c0c347daf 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -252,6 +252,8 @@ struct cxl_dev_state {
>  
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
> +	CXL_MBOX_OP_INFO_STAT_IDENTIFY	= 0x0001,
> +	CXL_MBOX_OP_GET_BG_CMD_STATUS	= 0x0002,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> @@ -273,6 +275,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> +	CXL_MBOX_OP_IDENTIFY_SWITCH_DEVICE	= 0x5100,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eec597dbe763..7f53b601ad7c 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -75,4 +75,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
>  void read_cdat_data(struct cxl_port *port);
> +struct cxl_send_command;
> +int __cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
> +		   struct cxl_send_command __user *s);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/cxlswitch.h b/drivers/cxl/cxlswitch.h
> new file mode 100644
> index 000000000000..d823d2cc159d
> --- /dev/null
> +++ b/drivers/cxl/cxlswitch.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef CXLSWITCH_H
> +#define CXLSWITCH_H
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include "cxl.h"
> +
> +struct cxl_dev_state;
> +struct cxl_swdev {
> +	struct device dev;
> +	struct cdev cdev;
> +	struct cxl_dev_state *cxlds;
> +	int id;
> +};
> +
> +struct cxl_swdev *cxl_swdev_alloc(struct cxl_dev_state *cxlds);
> +void cxl_swdev_shutdown(struct cxl_swdev *cxlswd);
> +#endif
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..5f79742fb266 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c

Yeah, these changes want to be in their own cxl_switch.ko module.

> @@ -12,6 +12,7 @@
>  #include <linux/io.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> +#include "cxlswitch.h"
>  #include "cxl.h"
>  
>  /**
> @@ -520,6 +521,98 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> +static int cxl_swmbcci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_register_map map;
> +	struct cxl_swdev *cxlswd;
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	cxlds = cxl_dev_state_create(&pdev->dev);
> +	if (IS_ERR(cxlds))
> +		return PTR_ERR(cxlds);
> +
> +	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_map_regs(cxlds, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_mailbox(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	cxlswd = cxl_swdev_alloc(cxlds);
> +	if (IS_ERR(cxlswd))
> +		return PTR_ERR(cxlswd);
> +
> +	pci_set_drvdata(pdev, cxlswd);
> +
> +	rc = cxl_enumerate_cmds(cxlds);
> +	if (rc)
> +		goto error_put_device;
> +
> +	rc = cdev_device_add(&cxlswd->cdev, &cxlswd->dev);
> +	if (rc)
> +		goto error_put_device;
> +
> +	return 0;
> +
> +error_put_device:
> +	cxl_swdev_shutdown(cxlswd);
> +	put_device(&cxlswd->dev);
> +	return rc;
> +}
> +
> +static void cxl_swbmcci_remove(struct pci_dev *pdev)
> +{
> +	struct cxl_swdev *cxlswd = pci_get_drvdata(pdev);
> +	struct device *dev = &cxlswd->dev;
> +
> +	cxl_swdev_shutdown(cxlswd);
> +	cdev_device_del(&cxlswd->cdev, dev);
> +	put_device(&cxlswd->dev);
> +}
> +
> +static const struct pci_device_id cxl_swmbcci_pci_tbl[] = {
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_CXL_SWITCH_CCI, ~0) },
> +	{}
> +};
> +
> +static struct pci_driver cxl_swmbcci_driver = {
> +	.name = "cxl_swmbcci",
> +	.id_table = cxl_swmbcci_pci_tbl,
> +	.probe = cxl_swmbcci_probe,
> +	.remove = cxl_swbmcci_remove,
> +};
> +
> +static int __init cxl_pci_init(void)
> +{
> +	int rc;
> +
> +	rc = pci_register_driver(&cxl_pci_driver);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_register_driver(&cxl_swmbcci_driver);
> +	if (rc) {
> +		pci_unregister_driver(&cxl_pci_driver);
> +		return rc;
> +	}
> +	return 0;
> +}
> +module_init(cxl_pci_init);
> +static void __exit cxl_pci_exit(void)
> +{
> +	pci_unregister_driver(&cxl_swmbcci_driver);
> +	pci_unregister_driver(&cxl_pci_driver);
> +}
> +module_exit(cxl_pci_exit);
>  MODULE_LICENSE("GPL v2");
> -module_pci_driver(cxl_pci_driver);
>  MODULE_IMPORT_NS(CXL);
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..ea03a289e56f 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -41,6 +41,9 @@
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> +	___C(INFO_STAT_IDENTIFY, "Get Information"),			  \
> +	___C(GET_BG_CMD_STATUS, "Background Command Status"),             \
> +	___C(IDENTIFY_SWITCH_DEVICE, "Identify Switch Device"),           \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> -- 
> 2.37.2
> 


