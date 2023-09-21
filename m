Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840BEE71094
	for <linux-cxl@archiver.kernel.org>; Thu, 21 Sep 2023 16:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjIUQ6D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 21 Sep 2023 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjIUQ6C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 21 Sep 2023 12:58:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23803133
        for <linux-cxl@vger.kernel.org>; Thu, 21 Sep 2023 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695315443; x=1726851443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lc32o7L/aiYSNbHHY9MLaNqUDLejnMBkCRla1L3CZwQ=;
  b=ec+rDygknni8kj1sucSBdwIJIgpVx69hTv80vF/Dcrtk04Oo0qxLyfhX
   7CohTinJuZLRAxnzILkmw27Cg9z/++293yAwfsRa6Ah4nEcmZlAL0FjwP
   KX6d5P/Q2eX7nNwsIBI8AosH/yR3PnjPrGpJinubtcmAVCM9c1nmUyhvB
   1+flBRhxXdUGIQgPNnYKVXFDDfweXITKw5GyO8oZXgTjJcc0pOZOAly8n
   t29/AtJEG9JgKuauW3SNaphEQkPZHmMuuH5QapTYFxTfHHO8Va3+udl5C
   Sn6SrT3A/s47AbPP//9wcu6R0iWF777StuvqiIONePAK1phiQRga+4TXD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360809084"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="360809084"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 08:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="747170333"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="747170333"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 08:53:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 08:53:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 08:53:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 08:53:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAnJ0bNpm/Uy2H48t6HmOoaeUwbSuIEQvIRCkhAXFn+8w8obatrzaqmqtVis81KKpKmj2SI0AZU/V/SJKMo9V0GW4CfIvgZiOprtDQLxmMFuTZDWCuU1r/+ZTycz+WMGmoqARlMhVZgxkN5miZ8XQy3e7H+Qbrx6/quByI39z2v4JapeEzSWdFo5TaMpQPI4XF8z6dYPQySCY1cP88/zkYzIoY75y9RbB+aoa03kkHlANTeSWAfgug73xNoMU4xY7NgZ4uZoElnSgfioNGQyx2JmKe8ir0vdcI/H5xXO/8On3/HKyAjP8gh+WQfic212mnZ/Fw82KTdPj/zwPSEyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOpLOklKj/+hKkcvGsRxDLiBGZX/I7Fy653HJxDPprA=;
 b=Yd5ic5JQGhCtWvDVr8Kk1Ari/WWUXw/K2nMiNPjUeetdqLeokabyQvwNXXRllOXh20lYHcQBLEgmA8k12Xr0imYhs3cZH2GZLjsm+MLne/8VsQ7xocmbs0Pj2Zw4Qhcx6n+XhlTErpW1FSV5v8wsfUtXzfFVwoaxOTSchwDDbIZKpyCMr2u4DinN5R0KRa2lBG2IBeNhysZIkDz260m+lk467aY40NeK+E6fkoenzX4aLlIUUIq6ZlFuw0nUXraSJEr88k1Bcm4LLYc0+J5CXADvMExvb8lQiLlXoGZMY2JVAhv86pP1H8WPYrlOeuS0aQKUH16b16hny8EYty6a0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6036.namprd11.prod.outlook.com (2603:10b6:208:377::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 15:53:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 15:53:11 +0000
Date:   Thu, 21 Sep 2023 08:53:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] cxl: Remove noisy dev_dbg() outputs
Message-ID: <650c66e43a77_50d0729486@iweiny-mobl.notmuch>
References: <169524300432.3077964.4526387988891514104.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169524300432.3077964.4526387988891514104.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc21656-9cb3-4453-aa18-08dbbabadb6d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAL5/Jzc9hUp5Wflr6h6AzyHX07OrfZiWKPzBrM272aZEkRdOWAiutnBITq3BNcANn+3Godn9hOl2BXGPKFGjoDd2b7eJ84/hJ+V4+sP+e8JAVrzVCiZBtnXBPdbQnFgCnOlIr4SW+2b6pFrVgVcE7SmcRdoisNnc7rBt5GUfmry2cn+8VWqBrLoyFG5RPO0SxQlSIvUxXUr7QL8gQ12+G9W/tmZ4dKCeo+A33iMbqTksb45vBlnq3Lyl4QUvxAQL7ozbQa49rFgOsx1JTyG2LfD8Zy/sk5OtayFM+Y/qAuYwWnwyFsW+Vk9Lf7f74EEBSJT9X92kfl1fnWP1dbXuJYYkAgrKTkWHxCWxzIzkqv1ktOQaM2yX/W8fELjWOTLD62IQhfh7FrakKrfEYVXt7zYjCKQ0InIDOnTkluCBdfDoix/f7EQQoHj33uqOAMONUM/xxVGZ+kWrIKbJKYvhPMoXGcnN953AfI2nHfZXhHNr1YPxt6xB5i8Z53m6F+t1yuQi4bHWJFNAIK4CXwaTQQXPlGvkJKkJGQ/T/ENcdxR4/muiB73ptdv8DiObYh3bJ8itrbi7urpgbjEz77YQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(186009)(451199024)(1800799009)(83380400001)(6512007)(6506007)(9686003)(86362001)(5660300002)(4326008)(2906002)(82960400001)(316002)(8936002)(44832011)(41300700001)(8676002)(66556008)(478600001)(6666004)(6486002)(38100700002)(66946007)(26005)(107886003)(66476007)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/J+sV2w1I8UmK2UJeu+QI4O37JageVQiwRsktZXSUofJf6yeR8ZhUTHdPU/Q?=
 =?us-ascii?Q?gzN3PfSxUNT/hXWaROtVakTXK1NUGwUjczm0elYu4dW1MU1k75OUhVuh9Da3?=
 =?us-ascii?Q?qbsqluzXqxGKWpJJRZNBeum/E6gGObAL31ialfGa51nP+gsXx7M7tqBpstb4?=
 =?us-ascii?Q?Lhh4tPOih2S74Ov5V/vDpwBhVJwoDf3YsqRJnJkbH/jQ4Od+L8K735h4oGdd?=
 =?us-ascii?Q?Gb43KVExDMrJ/xGjXO6ArfHCIPc2ZzaxEXaizZqCXYRGehGUaKkA1v7uwCMf?=
 =?us-ascii?Q?WMDmFOeQyQqDDXm8KtyNv40jjBLaz23fU5+STBJr/bWD4N0ufPh3/PuK3eJq?=
 =?us-ascii?Q?T+MOZA3OBdfb6SdMKRgiKZTCT1909oi5I7hd2vBIwPBwakysGbrhDmvaokXZ?=
 =?us-ascii?Q?5FsGRR9C6kOJP2VfIOlhpjzak8z5v590/vwcH/8pOmBzDXzyszwfgZKn1oPN?=
 =?us-ascii?Q?0moadBcblU3ty/e6cpjPqmoACfcESHYP4Y2ElmObCK9DhQNKbMHdzRpVmmHc?=
 =?us-ascii?Q?u2zE5RYB3sVrIIzlMVLylrQWp1GHm64WbC7ojEnjHcHJ7TJpjPzW9lZ3lOEr?=
 =?us-ascii?Q?DIt0QnXEQvrQGm7S/8pa4DIC4Y5RW7CeJRx0iGSPssUtXcyzWfpybxh0edkI?=
 =?us-ascii?Q?5zUqh/ZwDwOyJMSl59536zaZDbpv7p1gyOQV+AG+WifSFT/7AhadIuNTNKRX?=
 =?us-ascii?Q?ulTzJrcKmjX2oBzBvo64ct0sW2Fh3SCxfxUA1Pzui49kBfWAixrQnahkLwCq?=
 =?us-ascii?Q?3gMbpkNpBDSdsdMcXdTU7aWiTpNREk1msAu3E6utg3/VnEtgQ7yfd/w75tYN?=
 =?us-ascii?Q?g5i3MJayzmETROVif+LzpyZ9CUCWZYMDFShZewYak3QSA4qO+IE/jxTOGDIQ?=
 =?us-ascii?Q?cGTJZyjU9iShfXd7uvLguYli+yX0/Tv/FnHD2lU0oTGp5psq7D2VW3msah3r?=
 =?us-ascii?Q?uPiXCu/F6J1ogB9ZXJOgFfJbKCSQiHyTdtI3rfP8mpBEquo4SRbpm+g9KDSg?=
 =?us-ascii?Q?oRn9weaLAt1Ul4YjLQOROtb45UWutx6LX7DPLcBApTf8dYJcaRfudCCmEOl9?=
 =?us-ascii?Q?f1d4o3+Esh2vqEvyA5WJ8kWH30e4OkGHPSMswAV1DNna4U7MFnMBvZgTdQpr?=
 =?us-ascii?Q?2hoRZ4pCAfrmaFRNFE6/c6HRiS5qgZ3caOla9ePFNefQ+SgPpIOzMCso3T1Z?=
 =?us-ascii?Q?BqHVIsle4beFYSD6MdW+IRWBB5hgSfySLGt0T6qISdZQsd3QAAYQE6sLh/5D?=
 =?us-ascii?Q?9CGB8HClx05c1tIPoGBHdiGpKmNGCGBDad691hJsT/fGgVZ7G4tFnWxIqpD5?=
 =?us-ascii?Q?AgEUO6GAVr0ZDJpavFQye/Pmse65xSrRcdxBagvA1i9wVxaLIXozPOk0lFBp?=
 =?us-ascii?Q?vkyBjuJ7A0JWETbafO41lnMIBoimWUh+G8mGHOCD98Q+sFJb+PAXCbcf14JJ?=
 =?us-ascii?Q?5pj8cljoQ4Rq3OVKXASipbedMiUx7ZgoJ2L9Js7wSJM88z6E2RAaSTCh2CcG?=
 =?us-ascii?Q?eQEDL3AiYSr0rNBlEvzbl/43/61qpxAoIbpB6WuueVVnTpBZu4gQ1jC3l5Ov?=
 =?us-ascii?Q?zL0MLmppipd6lu31KPqAEVOr29jPnE2i/KDodDGn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc21656-9cb3-4453-aa18-08dbbabadb6d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 15:53:11.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7vunylYhnHGr++HsaxMHb2GgPA4z7J6HKgrsSt+lcqAv7PzcACbvvgLu9DkynA3vSmMoM9VENJkLPZwhRK6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6036
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Remove noisy enumeration of commands and CEL opcodes via dev_dbg()
> emit. These outputs were useful during early development. However they are
> now unnecessary and creates excessive noise in the debug log. On certain
> hardware up to 500+ entries have been observed.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This looks good to me but it's going to conflict with Dan's rework here:

https://lore.kernel.org/all/6500e8a179440_12747294a3@dwillia2-xfh.jf.intel.com.notmuch/

It would probably be nice to rebase on that for Dan but in case he wants
to merge it.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> ---
> https://lore.kernel.org/linux-cxl/b72946f0-31dd-b22a-f2e8-a12eb2f522ae@intel.com/T/#t
> 
> v3:
> - Drop eventtrace and just remove the dev_dbg(). (Ira & Alison)
> v2:
> - Add enabling note in commit log (Ira)
> ---
>  drivers/cxl/core/mbox.c |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ca60bb8114f2..963c668a4eb4 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -707,7 +707,6 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  {
>  	struct cxl_cel_entry *cel_entry;
>  	const int cel_entries = size / sizeof(*cel_entry);
> -	struct device *dev = mds->cxlds.dev;
>  	int i;
>  
>  	cel_entry = (struct cxl_cel_entry *) cel;
> @@ -717,11 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  
>  		if (!cmd && (!cxl_is_poison_command(opcode) ||
> -			     !cxl_is_security_command(opcode))) {
> -			dev_dbg(dev,
> -				"Opcode 0x%04x unsupported by driver\n", opcode);
> +			     !cxl_is_security_command(opcode)))
>  			continue;
> -		}
>  
>  		if (cmd)
>  			set_bit(cmd->info.id, mds->enabled_cmds);
> @@ -731,8 +727,6 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  
>  		if (cxl_is_security_command(opcode))
>  			cxl_set_security_cmd_enabled(&mds->security, opcode);
> -
> -		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
>  	}
>  }
>  
> @@ -787,7 +781,6 @@ static const uuid_t log_uuid[] = {
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mbox_get_supported_logs *gsl;
> -	struct device *dev = mds->cxlds.dev;
>  	struct cxl_mem_command *cmd;
>  	int i, rc;
>  
> @@ -801,8 +794,6 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  		uuid_t uuid = gsl->entry[i].uuid;
>  		u8 *log;
>  
> -		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
> -
>  		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
>  			continue;
>  
> 
> 


