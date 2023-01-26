Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B016C54EAA
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 20:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjAZUWZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjAZUWY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 15:22:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765A3A840
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674764543; x=1706300543;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eXw2oClQsNNeDdMnYDkZnVlLSV9dJGA/Mx/CHhHjCyk=;
  b=e2afN8oLzeAx+vw7tW9ro0GQuY8e/lYroqlQJyLcAEBpD6qI+n6dr3N5
   lD0rPPLNu50sqSr/H6ZNcUVrudRhahDh1mmShubbNDb5IFu4enbVPVXCI
   WlTq0eEMKKCfpUiWX7pQBtEltRtUb/OXu9RH5wLxbJMS36SVBE1J6BRmx
   c5Lt3Ila2Cn0FmTT59vTpdMSJyFUCoupsYb7v4k+g/pIJekbS/4QVrOjX
   JWpH0HI2hWdIZX/WVecKMerXLr2dbZMtW10pg9y0O7UIF2iT/zaWiqn11
   kmiTCXrJjJ2nQCfZwnh0EwcwV9UK97HqTVe8NQ/D10MWgswgiOiDBt5Fs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="306585808"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="306585808"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 12:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="908386847"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="908386847"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jan 2023 12:22:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 12:22:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 12:22:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 12:22:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 12:22:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvmFYI0DDLxJD7pIR7eRJWvBJw/MujNsuJLhE/0oARNfbnWt7Psn0vR90HdomIqvnS3zucLjqMaPngewwGCjFh6ucoWgFzlZFCPgFumL1TL0fXwXMHmr2+ZiCCyZOlul2O4bCOUDbxm3WA4ynkbKpo8DGxSx3TAScuX8z7xNO3+KvdN+vb3MUfNlgqWWIdYSPWPpZul0bfstCBjbH0AxWNbEfaVNkWpxMQIKAT2vT+pR3GK2GZzNn+Gyr2jh52yV0ZR53Q0Aa64nuBr/TnqFIitU2P6MkyJc37dNIyePkI1u7NwROnR6d9L7qZSRjrz1bO7SBSCOO9lIgWyFcRTdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eiKeTiMN0skBmvecL6Ed7m0vZNdraR8g27hPHFMsOw=;
 b=Ov8O3pgBLDOxj7WAjcrH57DLV5dRqR4DBa4tVcYV0JcFxxijBHsfAbUnTV4DV1TyqpILJsQsZMtvGZGEgZEw9jFLf5xYv8Vd+EP04Lqr9dyERWI0tG5Hd6jo33nz4hnbSvnaSiAUqavIm9G+w91WL8tNhwvLG2V7TsfGDHE943q06jgdOEIpU80K4s4DEC8niMU37SAy0cfOQnL6ZfJASeoDlUk2magTUWMpjSa56jvp9QJWKvJ3O+Famr/iztMYhytJkQpHPNc45Onvn6faFLK/0o4cCWa6RRSLKaXQJLlGq5stkRlNJ6JQZYWPu5dnsZva7ztZr/PBOkqHN4gqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 20:22:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 20:22:17 +0000
Date:   Thu, 26 Jan 2023 12:22:14 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: RE: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <63d2e0f67eee9_ea222294b6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ce0820-2c1e-45e7-912b-08daffdb04c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRZZzIUyOYPZf1yyHioKchKS6ZZtS3K+l1R1ttgq+QKwJtjI2+KJJdSEACRlDnVs78I3HDNkqEE+FNJIWgWSDuwWTV1dGxWwziszahd1EKHNlVa1ePnaIQvBzcqBDdxiuJT+Pku/1dkza+4ZYoECc2tYPNdAkrNnPASTpDgYuXGwxrgKEw/gdLZ/80OhAJQc9Xzcctv+pne1y3oeNOpmWGEwfNeek2ftACq9Aw7dKHI59/pfI2Io7teS5vD6v4LrLbyG6qQ5gAy/t2LNMtQ+4K8/bGjZgZwSqEixjwx8nXKoq8akpQScV832CeHWD4gvLiJ3wPEW9GoMnRDhxosq6Aoy75tDZIvgSugFsV/lS0Ce7quKueTbewE+yHICWlp7bvJoyimM9BQMobURQ4SNEZldlCzSUKy4CHw1+tX7M7SayYyIaUZriqRw9kCwNNsVl4k4nyG9Qjh2PSk3y/mRPyjnItKUHkCsuqd2EAGnhyBkT+TtVHWLdkTZFoS38AjiqLj3A87jUwCd+H//ITc+7QKWtp87d3BHi6hLFNSyiT2+bVLIiYOiL9NiS5TQSA/iAWpgxiZgoSqv/TkRZFjowmU8q+seNpRNjjXEXIKHZ74aOJP0Fko8aPPo4kp1MGqJ1uD5ZYai7z89LxgUPou1Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199018)(316002)(54906003)(38100700002)(41300700001)(8676002)(66476007)(66556008)(5660300002)(86362001)(8936002)(4326008)(66946007)(2906002)(6506007)(82960400001)(9686003)(26005)(6512007)(186003)(478600001)(6486002)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tlWb2+Y1o2JHLHLwImIXpLBtHFZbBuSCYsSvt661L3HJd+SaNeyscJoV7Qa6?=
 =?us-ascii?Q?BYfEG3l0L7oSu1jMQniX17bMvqVgLUgHLqIxP0W48cBFuYWrR2BZQxnSLSFq?=
 =?us-ascii?Q?inEzrK7A/EcV3vDLPXWmCDSkjpy6YK+qZPc+XQtEpcyS8tvKKoMvF4nMP6R+?=
 =?us-ascii?Q?Ob4kvUXLLd3Yw2a1My+i0o11IlR4S+KqaoTnWkHXosA5JB+red7/wmT9rYRh?=
 =?us-ascii?Q?3w4/EgelZr/6ZP4x124E9KzqBdyDWRgwzkAdYTlhhi+mp7PNERKPzNwLVSaa?=
 =?us-ascii?Q?w36Dh/pCqSIE0Rs0trJajEQtMj115jtXHEkbk1JFp+SbDb7+6ts9mpg5l2fQ?=
 =?us-ascii?Q?LZPDXkzM/vaRAZGW+jeoh5NT73UwcN7TSX0TjltaTDPRnRkh0kTwX7LFVEC0?=
 =?us-ascii?Q?CMJIMCmlsgPHbuafd8afmUBBsBFnhVPXKniBY33tb+Y/9Yt5Mi63eilJORmf?=
 =?us-ascii?Q?Ml03wd9w1CQFUmiJK8/Rdv68c5G3/jY5S88AF4Gss0RTHXOiPq0HqBruBZL8?=
 =?us-ascii?Q?SelRGiU/mYhlLirKJE9SbXNbZ8cqpVBmY+udm2om/ssC9usdFq/NNtRHIWMf?=
 =?us-ascii?Q?1wUc8kOsvpVjgnczr8S9ZHpq3s6m0so+1PXdl5xB3EINXCysbThzvKLh6Nyd?=
 =?us-ascii?Q?M5MLhTKENx18YfC292ALB7vmfbubagI3VdMLFyobMoeSAtf1oGS+SHpp+fFE?=
 =?us-ascii?Q?LXR32rRjSsLEZ3iMc9DsS3nu8UcmzavdUDBNnwfAhkRZDcGiO3x20N/jbbf3?=
 =?us-ascii?Q?if0n/ADEVB4eZHhtJQ1GBu23vPYP8RtFQyyFgqh6Ndg3yByq5uzD5qVQhcO9?=
 =?us-ascii?Q?wHKDVu11vRN0jxv8+2dMdOTnHKflHivfukwpJE83GbnSLRieziYV4m9b/+3Q?=
 =?us-ascii?Q?CI9SmlHDCaPtgqd/iVFo15/OaNCRpoZrwOLkMvcrzMLx4EdNoHOhd6uGr6kA?=
 =?us-ascii?Q?bNfP3jK16T/jJFA1hPwoUT1FTPILwTM1qbThYZT0XtnuszQeoazauvFrHSYY?=
 =?us-ascii?Q?VdGb8Fx9jESgwDHNsSV7jWNC3zeN4gvDk1ECLQNOJ5aCyxER8xwNicghIVR5?=
 =?us-ascii?Q?7IeTvdYwuV+8x4JaEaNCQ+opzqSZ4SU3g/MlLvyY6ZFtKTz7AsupDKZo95Qo?=
 =?us-ascii?Q?AdbkUtVBqp3CXiVQ9kZTPWeobigiA2FwTbd4g33coyIcDZzZQXv2fusKALFs?=
 =?us-ascii?Q?jxNjY46zKMy4pHPQ86U7JovhL72b9LH1nS7pHr1NYc9bx+/xlMzbjR5S48Qf?=
 =?us-ascii?Q?GvJ07L4q9VU/stwIBnGa1vA8gcmnBLHU4qaMCWjcJj/+M1+s5A0fr3Li0PhM?=
 =?us-ascii?Q?zPF87S6XKdSQNJWXR4BwEBmPSp5qEeXKIAJPac4lG6FT820pkIUDTVRBsupW?=
 =?us-ascii?Q?Hbe5M0iOILQRGk27Oa7aN/t1SSaq141tuUllhu7t/PFSPQb/7hdxLIOTvzjg?=
 =?us-ascii?Q?bygCXhD622MPRGSjiYI3Xv9xjbiRJY7G2O4SOZo+ltr0APgMdStguaGgS9+u?=
 =?us-ascii?Q?tHOm7wM3hXbCF/I7PFPpHSz9mioJ7TBMYcYjSSrkYpmuClKLDCXtg1gl/e3I?=
 =?us-ascii?Q?DkQo4GoUWRTc9H9bIGOpKNA17yAxOVNA3oaQMpzHHdY3wJX1n/bl5zRmzJUm?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ce0820-2c1e-45e7-912b-08daffdb04c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 20:22:17.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMQBgKPrp9nK8osUXp5tkBdCBSx9Ftm3xWyKB+RGoX+Z/Rwny3ov0FSJGBqYqcGxhEE+y/rBWpZMpLyv2BEtuB4KMhaMtzl0/tZnw52sgfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> CXL r3.0 section 8.2.9.4.2 "Set Timestamp" recommends that the host sets
> the timestamp after every Conventional or CXL Reset to ensure accurate
> timestamps. This should include on initial boot up. The time base that
> is being set is used by a device for the poison list overflow timestamp
> and all event timestamps.  Note that the command is optional and if
> not supported and the device cannot return accurate timestamps it will
> fill the fields in with an appropriate marker (see the specification
> description of each timestamp).
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> Open question: Should we only do this if Linux has control of the
> error handling?  In theory it should be safe anyway given the
> specification is clear that the timestamp base should always be the
> same - so subject to small errors we shouldn't cause any firmware first
> handling to get confused.
> 
>  drivers/cxl/core/mbox.c      | 25 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h         |  7 +++++++
>  drivers/cxl/pci.c            |  5 +++++
>  include/uapi/linux/cxl_mem.h |  1 +
>  4 files changed, 38 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..a7317bb142ed 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -65,6 +65,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(SET_TIMESTAMP, 8, 0, 0),

Is there a use case for userspace to need to send its own view
of 'timestamp' to the device? I think it's ok if this only a
kernel-internal thing.

>  };
>  
>  /*
> @@ -93,6 +94,7 @@ static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
>  	CXL_MBOX_OP_SCAN_MEDIA,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA,
> +	CXL_MBOX_OP_SET_TIMESTAMP,

The criteria I have in mind for commands that should be added to this
list are things that need to have a kernel control point (like long
running background commands), or commands with data integrity
implications that only the kernel can reasonably manage (like shutdown
state). While it is odd for userspace to send its own timestamps via
debug kernel builds that enable raw commands, the side effects of
allowing this seem benign.

>  };
>  
>  /*
> @@ -857,6 +859,29 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>  
> +int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mbox_set_timestamp_in pi;
> +
> +	/*
> +	 * Command is optional and functionality should not be affected if
> +	 * the command is not available.
> +	 */
> +	if (!test_bit(CXL_MEM_COMMAND_ID_SET_TIMESTAMP, cxlds->enabled_cmds))
> +		return 0;
> +
> +	pi.timestamp = ts;

cpu_to_le64()?

> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_TIMESTAMP,
> +		.size_in = sizeof(pi),
> +		.payload_in = &pi,
> +	};
> +
> +	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
> +
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  {
>  	struct cxl_dev_state *cxlds;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..0ca7a35de893 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -274,6 +274,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> +	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> @@ -372,6 +373,11 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +/* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
> +struct cxl_mbox_set_timestamp_in {
> +	__le64 timestamp;
> +} __packed;
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> @@ -441,6 +447,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2bbebbc7e032..30a2b231d970 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/moduleparam.h>
> +#include <linux/timekeeping.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
> @@ -482,6 +483,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_set_timestamp(cxlds, ktime_get_real_ns());
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_dev_state_identify(cxlds);
>  	if (rc)
>  		return rc;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..333301037b74 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -41,6 +41,7 @@
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> +	___C(SET_TIMESTAMP, "Set Device Timestamp"),                      \
>  	___C(MAX, "invalid / last command")

Modulo the discussion above, may not need this.

>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> 
> base-commit: 172738bbccdb4ef76bdd72fc72a315c741c39161
> -- 
> 2.37.2
> 


