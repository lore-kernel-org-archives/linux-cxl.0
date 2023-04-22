Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1175BC77B61
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 03:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjDVDWS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 23:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDVDWQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 23:22:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E0E60
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 20:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682133734; x=1713669734;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mKaKi5nfykXVqIxgVFWAzPr9kjeza28FFZEW4J3sraE=;
  b=jXAz1nHku+jeClppq0nPJr5u0DU+6twjf9KgVyZR4HZt+QgT5e3i4Gom
   qFGXxTot3YVTcn3/9MVqrxnhgD/8QKbv2N9iohCoZTbMtFXxuQaypN2nO
   dX/htNB0e/xQL/GNJSCbZf0C/RPyky37ZCqLAR1eR9FrIvwY//QF9eXGE
   IHjuFUxkORW0Hs9lrhZDqBV1HAHtjbnZKgpRHGdgR+i1P+ulBWtL+pX3t
   XsD4df/4wBhkVOx/CWNVGbz3mE1s/oEiUz/0yUfo4LQ4UzthYb3nLW6Z1
   qPPRgrZt/EA8IEJq0WMyS8lscrptOpHZnoot15yM6BEfIGSwwISFloSgL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="343609746"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="343609746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:22:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="781802379"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="781802379"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2023 20:22:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 20:22:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 20:22:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 20:22:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 20:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEJ9pMbaj4lIl4LHswymkRFirKRa7CG8CcT3jLB/r+CeWhfBBFKjPwBHYdEc0UmZgguNmRAuMRtZHG0XuK+Wa4XypIphV1p01+hPYsAAYl7+Axj7rVWwE8uE3WfQOke9SK4RTrHV5/3+iLc3Fwg3w+y5kqYpdE/gDcbJ6+P9YUwAScQ9ikY2XMkK5C52CG0W+MWxA4EG8EPU8u/zldhwiD2tq+EYsDr8ZELkDWT5cblkSpVZbXZ9SofiPCsSDykUDKQYnqw5LFZE35C9OSZFIVj+E8aGMJC+XYaD1WPjcs0xZpROOlIWgDcJdRR9JIPr+KgyQ2vFsyg2Fw3VF16LdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoVaBnhtMmba3EZGRYICfux47tQ2zBFNId5cYb3sfn8=;
 b=Lta+Uivln0LlB9SlKMLxh9sSWD04yyGTbPdwYv4hGF6Cn6Myfyf4eoF8ptBvfDf9nif1MaIQoeFYu/zYha/5KfC2biNbknzxBWi6SlBSS5WADSQXpC1R/Me0m8ZZBnsvr3yo7OX2HHdlVwkhpgSck7lLi29QHWBHplhenjknhZ2GoHDYO65E38A+AAwZCyB+JHxz1bIzI25P4kc6dIKR8c6EDL3E25x+qGrf0Lcxmufw/N+GQeBi0Gjc1OMccFH6d7gm5XMl+P8nzMg2NQhZLQI7sb+UGXM55E6CeZUtmz36wg9qr/8pdSDphkG9NfP25KX4xM5fMX6zfXRBY8uOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 03:22:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Sat, 22 Apr 2023
 03:22:11 +0000
Date:   Fri, 21 Apr 2023 20:22:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v13 3/9] cxl/mbox: Initialize the poison state
Message-ID: <644352df7db17_1b66294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <9078d180769be28a5087288b38cdfc827cae58bf.1681838291.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9078d180769be28a5087288b38cdfc827cae58bf.1681838291.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b58988-5b71-4108-32fc-08db42e0c224
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f27vdr484MUi6xcHwh9ZlxSHPs16sKYFlmK+NCP9K2Uyswh+mzIQ5OyRECtMDg1x2RkCC4Qm1oL76l1lPB82rkW0zt/jtZkeqiYIUoHcN3xVvdKfOn7wXDqYHI3ImK5Ifu5OsspYPDPkv3wu5Hgo5kKT5PTBgx7412d0KFT8woPcm45hSC9yH7MN9Fj7UEyEG/hFk8a/rZDqTwb90K7xPlV3fsqmxaQ+suxX4kjdmaiTd2ibuzHBDdYNrRJUbJoeZ90tZuWSBbDxktBntTZHI+ZQvyagIAYBmVlj/4v65h3/PdTxXW8qUhCflhoQf9iv5EdQwqQ2+IPzg0qQWBjEaVfvFy/p+3kxPYq0plDwgVnakfCM4V6sB3IzzXGV0YX1h68ZB7iOd3KvoI8Mim0vxSSyXDpq2L/uczV47CfFqwWW1/gkIAQGiMTOYh59yxTlIlyxwZ5sL+vuD/s2U7yu/yGu62SYARcazW1zkFklh4c4xlbpsks+/PstxBiPfXjf7nQo+G95Yjo3jJOcRweurQvgRhDxXqSxNE4gTTg0Mfhzhh27pyUXOHjbZaYU5meS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(66556008)(66476007)(66946007)(4326008)(316002)(110136005)(6486002)(6666004)(86362001)(478600001)(5660300002)(6506007)(8936002)(8676002)(83380400001)(38100700002)(82960400001)(2906002)(41300700001)(26005)(186003)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9TdtqVOBw2jbkCxm+7uzOln4dt85IcroBLTgPbIe+7jUe5S2lPy/f4BxpkRz?=
 =?us-ascii?Q?S/gz1YUj6qe04MgER3xb+MlY9WKoepo5FJIEqWC87vQbnYOGGOcXVxKcmOM0?=
 =?us-ascii?Q?PklMMF8GWgv/zOXx3STRVvhSst8ex8hdI2Em+0eSDJ9iG/AC6NA1gCGV3LQu?=
 =?us-ascii?Q?ZG8naE5lolYPodiOVM3InrmOFHN2IVFSnFNwZgbi5x82lpNoJK+C1E4u5Q9N?=
 =?us-ascii?Q?1Uxb2f/4WkOa/Vj1YE2gJVBfZherSHGWxUmAszVbNQIGsKlQlNuYLzrVYKDv?=
 =?us-ascii?Q?E4vW87i58wbYXxL3Mxs1iq8QfbGHpcrrTZefl/CvxTXOKJAbSLSgWxXwf6eN?=
 =?us-ascii?Q?V4Iy7A5O3Zy+YS2nO9xNKBXWKUbYSXcK9d7VokkKrSh9UlXlMdMbuEy/FZ22?=
 =?us-ascii?Q?6XGF8lj4oRqf6Xb5Qk8TrZx5eNIskzphHPtmq7YNLTx3gz1nXFuE4CwyAIvc?=
 =?us-ascii?Q?v5mcTMbLogL+3QFIe4B+k9znzb5Zr3C/YujdKauhpONAtpJfwxSyeqLGk+Hp?=
 =?us-ascii?Q?tOGwP3AkuODGBBPueyJ789qnDvh/h2dv3Oc6WFAgaiQI6lLVEEMkI+MIOUiV?=
 =?us-ascii?Q?ZBimvKvrXPUuiEa/TvTUjUYOwxESDXdeweVhut0MSI6rLhXsxzg4lT28sqzG?=
 =?us-ascii?Q?BuVlGxpE9IosFITSOZZbWgve4KXiA8sMLgNyvCZYtc9r7i+JXufMsvjKoVED?=
 =?us-ascii?Q?MPK9pjQ767dTTmi0W0hwvIj8XF25JLXfoH/vgn4yrYO6FT/u6eD8DAy5Fdlf?=
 =?us-ascii?Q?O8BVK1Dey7I3QXVKkCjSbbSHQW/q1RU2HKcXtof2a50pqxrtsy0tih4LHcWf?=
 =?us-ascii?Q?WRHY3+PudZomRrlALPjWlz1k4y7bzTfSG72qYsAPBQICKPNou/VbwLodATaV?=
 =?us-ascii?Q?rfYzKWlojy2103+yJIzzKKq4rM0zWhZwsr6ZM1ZnL/t4EOFeClfVnqvBGSPE?=
 =?us-ascii?Q?+7UZ/zJQyARCYyI8jdSdi1E09SKBstcdi6QIk1ddDkINMv1h1bzaNxerIBEh?=
 =?us-ascii?Q?LHm/vCj658dK23iBpOFjq+cUJ/y9JEWNF8vMPst5ZDAaVg8CFfCemE4K2tx8?=
 =?us-ascii?Q?DQYsGMiVtLuav///MiWUqVWlKfY0LhTs4wF/wPw7Ttn9meRBAKrOnuuudXhY?=
 =?us-ascii?Q?zzGNjF4jM4u4EN6hvVRdGezb5bBquCmZx5aGU7fR9qVqgfMWDbGT9zNKBmDo?=
 =?us-ascii?Q?uPKOExoauKCPH2u5TX335I7jeOdrVvD/JTnpV1D/pcbguqqAl1cfNMKDrwPC?=
 =?us-ascii?Q?QdZS+QuPF9VWK4vspjFUEX2lSP6Vh/tkNtnh0yOScdgNuAZLS9mpRvehhwSw?=
 =?us-ascii?Q?j6W4utKRuc56rhRT+Y/UVIZUcNoksPI5PCgKwDbc/OG6/igq8YxQHVMY2vXn?=
 =?us-ascii?Q?5a5/jc/kGfsRezjykzpvCOJ6tl9vjYHpDLWRvppttvt9bTHo1uHJYshhnT+o?=
 =?us-ascii?Q?lGfQKo9kYSIoeuvcdYuTmHtmoYx4L4GkW+VPVlbnpEFJQlBS88aF+xOjwhbj?=
 =?us-ascii?Q?aogu2+rzu0Q0IGjxTox4J+YGKLYFoX8d0MqE+Fahig42XoGV0ViVWGv8HVsE?=
 =?us-ascii?Q?1NWDfgKF7syFoWfmG2X4UfW/DjUzj1DFO5J7/1Kg9x/31tHMaucuP2IQX9c2?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b58988-5b71-4108-32fc-08db42e0c224
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 03:22:10.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91Cxgdd+XclYUSkOFwo4JlposIZUaJCRU7unvERk8J7TiB9b/XjW08CJjS3RkA9heNXT45gs0yvR51DVadToI/92XR63YRTsV2PhhPWb3Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Driver reads of the poison list are synchronized to ensure that a
> reader does not get an incomplete list because their request
> overlapped (was interrupted or preceded by) another read request
> of the same DPA range. (CXL Spec 3.0 Section 8.2.9.8.4.1). The
> driver maintains state information to achieve this goal.
> 
> To initialize the state, first recognize the poison commands in
> the CEL (Command Effects Log). If the device supports Get Poison
> List, allocate a single buffer for the poison list and protect it
> with a lock.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 81 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxlmem.h    | 34 +++++++++++++++++
>  drivers/cxl/pci.c       |  4 ++
>  3 files changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fd1026970d3a..17737386283a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -5,6 +5,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> +#include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  
> @@ -120,6 +121,43 @@ static bool cxl_is_security_command(u16 opcode)
>  	return false;
>  }
>  
> +static bool cxl_is_poison_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_POISON_CMDS 0x43
> +
> +	if ((opcode >> 8) == CXL_MBOX_OP_POISON_CMDS)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void cxl_set_poison_cmd_enabled(struct cxl_poison_state *poison,
> +				       u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_POISON:
> +		set_bit(CXL_POISON_ENABLED_LIST, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_INJECT_POISON:
> +		set_bit(CXL_POISON_ENABLED_INJECT, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_CLEAR_POISON:
> +		set_bit(CXL_POISON_ENABLED_CLEAR, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS:
> +		set_bit(CXL_POISON_ENABLED_SCAN_CAPS, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_SCAN_MEDIA:
> +		set_bit(CXL_POISON_ENABLED_SCAN_MEDIA, poison->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_SCAN_MEDIA:
> +		set_bit(CXL_POISON_ENABLED_SCAN_RESULTS, poison->enabled_cmds);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
>  {
>  	struct cxl_mem_command *c;
> @@ -635,13 +673,18 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  
> -		if (!cmd) {
> +		if (!cmd && !cxl_is_poison_command(opcode)) {
>  			dev_dbg(cxlds->dev,
>  				"Opcode 0x%04x unsupported by driver\n", opcode);
>  			continue;
>  		}
>  
> -		set_bit(cmd->info.id, cxlds->enabled_cmds);
> +		if (cmd)
> +			set_bit(cmd->info.id, cxlds->enabled_cmds);
> +
> +		if (cxl_is_poison_command(opcode))
> +			cxl_set_poison_cmd_enabled(&cxlds->poison, opcode);
> +
>  		dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);

Ah, nice I like how you suppressed the unsupported by driver message
which could have lead to confusion. I think we should duplicate this
approach for the DCD command set.

Looks good.
