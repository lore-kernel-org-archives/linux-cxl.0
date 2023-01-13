Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5549DC6379F
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 23:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjAMXhn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjAMXhm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 18:37:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A1A736E3
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 15:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673653061; x=1705189061;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H7wy+3LXFyq93XQCUJbdd4GwAY0F7QGLdaBmuyYqFks=;
  b=TrlurpaiwausPH2KoG87hgBkysRVfW7lJH7IaiTELVKHgfIoFRHeMcTj
   P4Cpeg7o6raYLiQYhNJFV7czbRfT6OjhxEQxhDn+6NvkE/2CRlabedJ8B
   4Qho2YLpksKLUVTMeuXCY68cW8mCIICr690pyH/T0r3oAgppErjR2sBh1
   DK/zlxGRzOjA9czlsWL/mckXLu5vOHWQoPB6rbKSbDfue+IYdZ5FHc6s8
   AJqgHrsOAvGLLn5oU+D2BHEBgCX89rvcjABtM0X7aa2Ak6kJ/agSRatJ3
   rCvkRLK3wb7+E6Ck5pEFSfRCZfuEuoM/gOO5AYC5VumhGWZx2tzG75GBa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="307684052"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="307684052"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 15:37:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="658370323"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="658370323"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2023 15:37:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 15:37:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 15:37:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 15:37:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 15:37:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFFQBQtegwfmwvUDFdRaPWaNF4YaAAoqt62bJas6vA1+0eJanIqz/6zVjVyoJNh5tITCKiUAxWhFcgfW65JD1mTwI1knFrMBO54t6yerIS5OeOy54G5ZR/8VDyjAxmkXYIdwUCMpru5y6Un4WUyAH3zmmOt8XOJ5TS8aQG3e5zYsXZDe3yGhMAIx6svgIWGN3+iLFi7xXXTBCgToEQz9mSVDrVxCz9F0jO9iNJOojQkRxMyvJrwywpSFBgAQapz58EyuZe/nYGEHAvvPbhOiU4nUVSJVcu67Pr3IayKUyKklX51y8Sy7jYt8EJEtEMloSl3KG8iWjJbUK00i+LvRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdM1AQmKqCms9vUZ0IiqlhDJhaZUHOYYiVSxmhPuUos=;
 b=JlwcLoVdqQgW4bHygFe9icLlbBpgYdhCOdX+1kqpkxiHhvT9HXYK0QEU9Fjhq2qYFji5BYefo5N9iejK1zMK6NLhBN/UaELrIk21B2/KfXLs4x42onXbbIqwr6Hhx9htCifzoFaXPz1YQIOW2ra/txxxmeuGU6kegal5Z+fzbUXwMe6J5vIAOkVWqI7Au0ZmzdywJAFm3tP1aLKeJ/++dsbCtEpfN7YhyR0cev7qFkAH40wj5ja1I21NNc8QMpdjuPtirx9df3i4I/6a2fbCIJHH7LsybqJVUQgynZnVROy0Nd5wP2ptPRmDJtXE/VWOYLe41pT4yGjCfIqxLcg2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 23:37:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 23:37:38 +0000
Date:   Fri, 13 Jan 2023 15:37:33 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl: fix cdat_available state post error
Message-ID: <Y8HrPQo/9CmJh1WZ@iweiny-mobl>
References: <167364543268.908947.8539778012050364814.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167364543268.908947.8539778012050364814.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 942594fe-52ce-48be-4d43-08daf5bf2787
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5asRi2ggU+e13zbnVzYO3QI6vQt6CUO3lvfCE+7u0n8ayoDBBH50E+Dj5HaoNzaLGEHd7HKd3sd7g0HCVX+pWuyno4vB+qJCHxdBu0VqUsf7jJeKNRO53JzNJ3lo1LIoXS45dO0gVfk3N6X76VLFyAiiFWg7fgfCrcE04PdZm0jQv/f/zp8BonELp93D3KUDu4r8X14IG/6yZgQKJzC5ZLVcpFdj2bET7YLoEu4PfQ0FxwUg36qHUCBvK9WTK7/21dAUqNn8wH8SJA0qASSUhyxqveV6Lg2JE3biD0DlrH/UHzG0xeVfPVn/Ay2OBeH+sFDiLtoR9lkOUhqoiR5kZtTxcwKL7vD8o/zfExLVXLR+2OWqOEulYVYAlPGFv/OpuG6UxqXiWljFUUo5i2f3GhJZan9YLHDbF/25cri2Jf04Aln/tYlm//1WwbIEaiw44Y7E+e0hTl7nnecT5SLHKwBzuYZZUP6X5Ig2YZVh8VxbnSqXZM9QjI+bFMQDYTccVtKQoKfAlIKmmvFbZSf/NctbV2+lddhGFor6Qc8XBbsltF4N1AI0B/HthjDSl9XCZ3HMWMQsIoV4as3zQzfjniVr67uNW2bDv1y1HgzmCHQFqOcRzBwZDpkDJWzPXqQVGr+w3hq+G1CLzkz0YoY6GVoQZFakwErmIu7haf890tyTtBZZwbmOLVuN/tCReH8P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(66556008)(41300700001)(44832011)(8676002)(316002)(66946007)(66476007)(6862004)(86362001)(8936002)(33716001)(38100700002)(83380400001)(6636002)(4326008)(5660300002)(82960400001)(2906002)(6506007)(9686003)(6486002)(107886003)(186003)(478600001)(26005)(6666004)(6512007)(131093003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7beVpkVdKOvXA4uoGwD6Uu0Q1lNoTujsMwp1o304lcdqZh5nlh4OMpOau97r?=
 =?us-ascii?Q?I9jdl261jPASnnmGzLFxs80RifUo4wbsbTLAcEZJBLf4tBeo6ntEdBDyHlvv?=
 =?us-ascii?Q?lNGGYMCroaHw/M7KXUGYbFT6KNJHwJIXOodcmkFC0SJ12fbdXnrggQ7nP/jK?=
 =?us-ascii?Q?vbUzqCtxMHiFD4MFyxYEN1svG4WNJlx6Iao/WUfnRGj37P7Hvk2o72LqAArB?=
 =?us-ascii?Q?iAJf7Wk2OsWBtfbkswT5yxBI6KLS7NM4mBdRCS5JYkY0RS0XAt3FlW0zM8Da?=
 =?us-ascii?Q?yeXTGhnL+2+6LwROgEaIk/eokEC2lYjBD/qdHsul5mvfUxJ0CrJ1nm+3emk3?=
 =?us-ascii?Q?a9FdvMNH8utXsynYCIbrlbe5RWvk+RkOwnN4Xu1AmxJz3iOofEszxPwfEnGa?=
 =?us-ascii?Q?64dryUauZLzBKiviFPwn+Znw4l3cidM9bs+fQELVhn8hEDGTZpGC8IqYv5Wh?=
 =?us-ascii?Q?ZnESHkHEYoNB06lxoa4uySp/IykSAjaYXbq8S5S6WC4GieAGzcGRGZvBZPKC?=
 =?us-ascii?Q?IINQHyANX8ySheUrTGooVAzsGetGU0HOqY8qhbN62GAhqJQo1ZAkZshWRTEa?=
 =?us-ascii?Q?JdkDrR5zK6+91hZQ2jGge3MPLCTx98VIGJaFMKymOqnC/qEGBK23+KWJ1CI/?=
 =?us-ascii?Q?QlsH4h+U8t/1x9llXuoHjEYbPF9lVfetCqFsUb+IMrlJpLgFaeIChslEGJ4L?=
 =?us-ascii?Q?diBGLdutXTjuiXCPMylOvAVNWuPwLTH+kEmUrUCkC99EHAdVyYKcOk5ZlXmU?=
 =?us-ascii?Q?b8gppqb2RZ171L5Ib0dS9iAsK1xNCAd0PDrTCi+ZM6dqQ7uzXvz04JutEyo0?=
 =?us-ascii?Q?dq9aHPa8Nt2x2n382LrGVBxPWMDDvb8AX2hi7+S5hrImz0R1tcW+Axxpy8cB?=
 =?us-ascii?Q?agA0upaihnwHMRsvzY/kOCDLgK8De1eOLKZja0yk523vieS9Q1GxpabujBXG?=
 =?us-ascii?Q?XUEeL9JrnVd6wNQLDv8HTMKYfcvu81gySkk17E39h3A+91rkjoKXRTCbabb1?=
 =?us-ascii?Q?YGY5V3KraQhwODl4WCD/FXU4wpStuMwwXNwa9a4G/W55+yzO0HS3Vfz/HQYN?=
 =?us-ascii?Q?mZnr0U8LmJaCYD80Q9xusk8/JodstnDa4yns45DEinF5TJDhYCpQt8IO1T9Q?=
 =?us-ascii?Q?O898DnjT8u4qUB0OaEggSOjH2rP7+X13IOiSqtLnFYZF8uIMHtzXGOQMv9he?=
 =?us-ascii?Q?qwBqJd4/xbiPSsd+hfz+rBfHKOT3VX12B5QkWvts0RghHX9qr0rGNa35KXKx?=
 =?us-ascii?Q?bNC1itFpZXcHFLbAMDdiyEchXNrTmqGBgkcZqWJkap1YDmNiVPfIylA6894o?=
 =?us-ascii?Q?9tOT+jUgGvfV1p6UuW10qub0qDF6CX/ZBV/MbnyGaUMbzlPcYcmCukjqCUoH?=
 =?us-ascii?Q?s8MVJMdchcug/wsgyYLd/xVkw+lvAJQv1eJGDkC234d7R8taz8JsuWb0QAOj?=
 =?us-ascii?Q?O0RwqjDrZehDuKt2Pyh/70me68DOheBG640pCj1wpcf7YXUGB0oNqeYM9LJq?=
 =?us-ascii?Q?UhWrqZkvc5FX8ZNMqdPhjckAPAznHun4IhJyHcrFGJE8V9Ini0Q51PRS94Zs?=
 =?us-ascii?Q?mK/+w4Mi8oZq1q8RY1mccja2X/7hwWym9beL40Of?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 942594fe-52ce-48be-4d43-08daf5bf2787
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 23:37:37.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBy8pJ+jA0n9/U0VJ9XQlVefs+0j8xhl4QzQYv7MZ5SjvButemqJRaWJDGhoyQRg0yDd7Ba2V35SIhfXRSOb4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 13, 2023 at 02:30:34PM -0700, Jiang, Dave wrote:
> Given that the sysfs attributre for CDAT_read() checks port->cdat_avilable,
> it indicates that the binary backing cdat must be present.
> 
> port->cdat_available is set to true in read_cdat_data() before the data is
> actually read. When error happens during read, this state is never set to
> false. Move the setting of the attribute to after everything is done to
> ensure it's always true.

Actually port->cdat_available does not indicate that the data was read.  Only
if the sysfs entry should be there:

...
 * @cdat_available: Should a CDAT attribute be available in sysfs
...

The table pointer should be checked to see if the data is actually available.
If data is not available the sysfs will return no data.

Ira

> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1d1492440287..91cdd6a00964 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -601,8 +601,6 @@ void read_cdat_data(struct cxl_port *port)
>  		return;
>  	}
>  
> -	port->cdat_available = true;
> -
>  	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
>  		dev_dbg(dev, "No CDAT length\n");
>  		return;
> @@ -621,6 +619,8 @@ void read_cdat_data(struct cxl_port *port)
>  		port->cdat.length = 0;
>  		dev_err(dev, "CDAT data read error\n");
>  	}
> +
> +	port->cdat_available = true;
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  
> 
> 
