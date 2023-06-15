Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0215EB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 15:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbjFOP0n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345065AbjFOP01 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 11:26:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38425212B
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686842786; x=1718378786;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=meRCSP4WhZATvF4ioJNgUfMCbGkVVBGpdq2hSkQajFM=;
  b=fdjlZrelSnyzBrCFcG40o/DdxSdqkbrHRLDB/IjtgiYSF3KK6L312G4B
   MJt/+IKNspeUPa2csR3kNMTKcRK5Tp1bgXDAlfp/Tk/XP0Dx6I8cdLJhg
   imgF1nI3urATplF5OyVyCQRH0TgwEoOX1TuKqS5PwRpDACzpJk8wGVkwf
   0s0gKSpai3a6bUUxu5vLih7TOlWRi7HVM818+6wPEBK8OmQp9Hwy0MBKb
   imDqXCJ04Dn67ueSSNpWjr3dRRRiGZFkw+dqlqXT4+qgS35fCDBcZnkie
   5xaJIFJYdHfynM2gA6QqOJhalizmuZ7HI+xlF4HJkjxDpXV9dqOsyYRvq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348637745"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="348637745"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802408081"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="802408081"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 08:04:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 08:04:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 08:04:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 08:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ5Ta5LO6tVvMVQe7wIFzT14vmvmDsp8K3HHxrGvwNCi+2pf7RFZwk5dBdbEI10HTVaVnwCMIPBmV7v6a2Y05EmfHc7CSsRjkSD39JDdsuaJ/Oc4N6k6b8lo7/6HZTTN059/br7HPWSwQvsGmnZljYuulMHrPAFCndEDaJHdHE8t0POQ6SjS1edOoLMT2c7rty9FEHam75s+0gwiKWW0tvuHV0XevCm8zGN5vRqvRS1q5xPaYll4DAfuoSmo4nKu0MBiwhcitIyF1uvJIwAad/CekpgfAyEnQBfJlOJpRVs4LXhhI0kZgqpomurP9L/jA+hdVcVCKaC3R4Qxya00bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/A/B9400KUFnS6qFrsgmM8I/PLxGoUODOELnqrA4T0=;
 b=D1QZHyQw32Gs6TnwtvwG+vAfR3Uq8RUeuBZoYkfbBfJxbICohQwDvF5b+jxvHqyaOcvM0x24PQfKjYt6miAHg/5YUkeU2JSV0trCrPHd16pL0FLY+fZpZx1Ok79kDgcle2cVLstOe0W3asxq5YiWteZFY34vtHzRZyrh8OAjhqT8pg5n2Tl2duZSdi1dawMeUA3NGqEF6C/a1Ojzacgg/Lg9fA682zQWbpHxRxws18jAEEvkd0R9itHQtEmkcnRZjenBF4NBZuAnimF8N/ckojZxkQJZATspn9ECWarbg9DzuompCfkdqI3uG0JkxcIfiqa+j/swIY0/I16lozczzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 15:04:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 15:04:49 +0000
Date:   Thu, 15 Jun 2023 08:04:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from
 the device
Message-ID: <648b2889a6b78_1c7ab42943@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
 <6ac12e10-3ead-a417-968d-cba06ec77d48@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ac12e10-3ead-a417-968d-cba06ec77d48@intel.com>
X-ClientProxiedBy: SJ0PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 609eeeb2-9972-40e0-ff60-08db6db1dcf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwCIhbHoJYG1kuDDfbngLdpjr6O3rZv71AEw8Q2O9JYoSg5ra0To5eBOxfbs+4kQRu9kuKPNdWU6eHDNMGm7QkGWKZzjgjHBZxrCod/UXAcdzNUUCeTcX2s1PHqzPDBcFSjycFvVlB5sDdU2ZbqVM+JG/OPsZV555qoinhE6rS6xpLJSxWUp88Mdj2I0ckefq7Fu8hqGTVWfMZjEBPr6ScolL95gcDS8kP+/+etnV69de44EAz+3yJCABmIzux/8E/BT8pQ+skgzf/gGU5huBp9REZwPt44qt4rKeZi+VccnukEWASYqMD/7iaNpyQVjg42dXTV8uS4BTXFowKLitE8Jrhuk9KRBpRYb2+nAWleb/xVe2Nh2lUEZNXJau45pIX9ZsyxP6km7I9+jxBHsi3X62BIEiVNVSeUf37FiWgiXQ72HWInGlCD3Gh6+Te5rA0ZApoUySgjEidlZHFk/VBf2y67mpoHFZn2Q5m6cA0hXMBg1YJTjc5xXCNXnYEKD+gDhl0QZQ9zJO8Fnw2k1L8YPjSlq8bGYUTLbaAhs7JPrHbZotNiGWSLSF/km1R52
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(5660300002)(82960400001)(38100700002)(83380400001)(6506007)(2906002)(186003)(53546011)(26005)(6512007)(44832011)(9686003)(478600001)(66946007)(66476007)(316002)(6666004)(8936002)(6486002)(66556008)(8676002)(41300700001)(86362001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uIBf7s+hP4q64V2MkGPJ00Weo5ktuBBojHK015flistK8LtljMAwIV4o0/Jj?=
 =?us-ascii?Q?BvXgPwtr0efc2syVw3fH9uEKglrZOpdKyRU39qeCsyPjU1Ko6mB10DdN43Gu?=
 =?us-ascii?Q?7a2ZYNWOjElz5ijMZ1PFGOIspl8klL3OR6OvFpyLFNQSrhGOMk92XgAmO1aB?=
 =?us-ascii?Q?74qoNgevDxHvrp5v/9t0YBGSZnqxHKozOB2Jsll/72HMTcBpGbymQc9DCChe?=
 =?us-ascii?Q?WzfjKoRrkEUS1k51KUNMPTSUOi5qdI/DpyUv3hBC8i91wxb1L96A3dqiTozy?=
 =?us-ascii?Q?w77CLchYFKxk7CvOsYBOOdzt51/0MfdySFNpe5DR6JX6EcSPvNPqe+PFqOCw?=
 =?us-ascii?Q?TxpWexwHpFIw8cPPXHRZqyetvJZE9qR0r3S+SL+7CsXS3GD/st5zg82ppYme?=
 =?us-ascii?Q?yFtkHUJKzxaWvrWWlT5KM3AF9pn7NBq8KK6lduVSYH+6bfY1mfWbxPH99lzm?=
 =?us-ascii?Q?OYJM0kNu4K/KVF57CzT8j0l1ZqKACWmtdQ4CaqtTWg8SvV0Oq0lrQTsYGa/X?=
 =?us-ascii?Q?T46v1lJbmdBeC+oqXWlGyQqSYpi3u0PiFnJwAksY8YQgyy0d9Pi/Gag2/8Q7?=
 =?us-ascii?Q?Vei2gkozO08CKqWfhV8Zr4eroNknkKC7WCnbebPHMGTXtQ6gm4boYFjEPI3I?=
 =?us-ascii?Q?Jyc/vFkJdj8s2xXwIcAtaA9LKIfJUMgujjXLCpZ6c5ucxI0n2Jt4J6mN73Pr?=
 =?us-ascii?Q?1EYRftZZiG64lPB2AY9Z5ZiMwhrX0neF8B4desc1u32a6ys2kOSgixhwtYqs?=
 =?us-ascii?Q?yYMw7+vaG1sn7YUX8bpdW8lPSia8T/MHbohHTTow66yd6BsVoU/mIaFtv3Y/?=
 =?us-ascii?Q?vea9cHuOxhnsoNVXo/g9rQEdyRjUWdijBJBQ/1M7pgcj4qegxkz1hYFXkVV0?=
 =?us-ascii?Q?qtxpShkHeQcxqbZ0NdKvtXQ4Bk9HvoeiV+1elLbc4K1e+LawDAII/TvYTjhm?=
 =?us-ascii?Q?Lv9rP/7kZvi+VPpFdSup1FsgVOugZ63VMdUmj2lIxxCRy5Na+Zxsjj/QrMtE?=
 =?us-ascii?Q?Ang5Ep5MsUnhnA6NupSQZxf2Pn/4MveJzTkialRHyGd9zqDcRCx19ZXAIa8r?=
 =?us-ascii?Q?Uuel0ukXCdV39BsGFq0sfWMx9qljXrH6m/nOBUajzTyFaN1JeC8vm/pMGeEK?=
 =?us-ascii?Q?ZFbBTP1bBhBB6C/6LM9XuaFuROpXpKDPMxQ2sfV8yGRZQxiJMN7h/jYVyqEN?=
 =?us-ascii?Q?nJKNLK93rWvsQpOHu29VxyIxq29f8zbUkaVy0GoYueD2APG5lx6FLuiXtGTi?=
 =?us-ascii?Q?W7lNFwQxYLhEpxeVoqImPT8g0X4lI0G+aN8X/yndjBXnMp5gsLm5BQo5XQg7?=
 =?us-ascii?Q?1JJivQJB/ywRNVLH/qttderjoz/Ty1urh7r8uz63AFVwRuV6haojbkVqo8Bk?=
 =?us-ascii?Q?rLCXW6turE18DmQKAygrgrMxBk0Iu9pzzx5A72a0eA7KZhromGR5T+jb8Xe9?=
 =?us-ascii?Q?R0j9aaJqaTYktNG9Wmvf0eVBOynpzWVtq2Iev1yTICDXN7zz78ROXZg2Vaub?=
 =?us-ascii?Q?6ZhHVSiLYGl8aXRq4wOlwpY9iglpaufwNr2Y7Pc4cuRAlLHwB9Y++x6d5ige?=
 =?us-ascii?Q?SIxXIVQxW4SYtJgd+A7yTpBvaVyJZp0SCoEh7QfJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 609eeeb2-9972-40e0-ff60-08db6db1dcf2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 15:04:49.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTbDjvpGvZbACZTKNzfsDwghsnkdH2ldqG7FJaIkPOuCYQiMjDhhntzD9Vm9bJNr2UNdFDQWgx4sn6BKhMa9vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 6/14/23 12:16, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Read the Dynamic capacity configuration and store dynamic capacity region
> > information in the device state which driver will use to map into the HDM
> > ranges.
> > 
> > Implement Get Dynamic Capacity Configuration (opcode 4800h) mailbox
> > command as specified in CXL 3.0 spec section 8.2.9.8.9.1.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > 
> > ---
> > [iweiny: ensure all mds->dc_region's are named]
> > ---
> >   drivers/cxl/core/mbox.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++--
> >   drivers/cxl/cxlmem.h    |  70 +++++++++++++++++-
> >   drivers/cxl/pci.c       |   4 +
> >   3 files changed, 256 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 3ca0bf12c55f..c5b696737c87 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -111,6 +111,37 @@ static u8 security_command_sets[] = {
> >   	0x46, /* Security Passthrough */
> >   };
> >   
> > +static bool cxl_is_dcd_command(u16 opcode)
> > +{
> > +#define CXL_MBOX_OP_DCD_CMDS 0x48
> 
> Move this to cxlmem.h?

This is only ever used in mbox.c.  So I left the scope restricted for now.
If modules need it in the future we can lift it.  Also
cxl_is_poison_command() is also this way.

> 
> > +
> > +	if ((opcode >> 8) == CXL_MBOX_OP_DCD_CMDS)
> > +		return true;
> > +
> > +	return false;
> 
> I think you simplify by:
> 
> return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;

Good catch.  I'll clean it up.

[snip]

> > @@ -1121,13 +1289,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> >   	}
> >   
> >   	cxlds->dpa_res =
> > -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> > +		(struct resource)DEFINE_RES_MEM(0, mds->total_capacity);
> > +
> > +	for (int i = 0; i < CXL_MAX_DC_REGION; i++) {
> > +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > +
> > +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> > +				 dcr->base, dcr->decode_len, dcr->name);
> > +		if (rc)
> > +			return rc;
> > +	}
> >   
> >   	if (mds->partition_align_bytes == 0) {
> >   		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> >   				 mds->volatile_only_bytes, "ram");
> >   		if (rc)
> >   			return rc;
> > +
> 
> Stray blank line?

Ah yep!  Fixed!

Thanks for looking!
Ira
