Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73B9C25B06
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Aug 2022 20:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiHDUbA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiHDUa4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Aug 2022 16:30:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FEE19293
        for <linux-cxl@vger.kernel.org>; Thu,  4 Aug 2022 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659645055; x=1691181055;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w0YH2OmRW0kVVcT6UdxVDOgjTq3IWyxUaKBw/oWMipA=;
  b=kXPE3ruh2r5YotrpfehUbx69Z0JWDpfjzmiduUS1cUhcy/j3yIkizGCn
   sJEYqtXCCemIGItVZVrYrQustkdR258K+3lJCKt5u6m9rI8HrjbcDcE7p
   Byq8Sz8OiPabji8ERUAL8FKQOoikNrUppPiDR1zkE2NGZRcdghm3aXlzp
   b13NqQr9D/9bnsOAJTWG6jJg2x1veMehgBE1rHZSlpX1DLMniF9cJAEM0
   RWyR5P8jY/9xcbF7+66lDZyw6NqfqX4wiF30EQqq1npXiCyYEXLP6Fm71
   DvQ9rFxJj20kEGQx+ZclcIXY40mqTvE7JoYBZ1VFcxdib42LkpCmY7fGF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="315921975"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="315921975"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 13:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="631737194"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2022 13:30:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 13:30:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 13:30:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 13:30:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 13:30:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJRdC/ItmsdshoNI9blA38zVWSrfT3U5hkCCOkOLcjAEsL4TYjdWAU6oFSSJbr6/yay+SudyDPueT1Cy4NIeg+ZOynqVi2iAQlg/zvtfEMdwdGLVI7Khtz2+coEQi2rMvh/kYjpR6UDVAL90LjxlnMj2wSlER05K7nfG1Uc8+ZJm0JEO4FON1wVK3xwoxtr2Od0KyxTSU4VZOcPwYo+ZqdNZqCShm5ASyy0bXHGpWfEu5JgmWD0HOa11snwiugndRgrldWooTG9QdG3wU08coHGXIWaWOtydyR313gs24SHEzhGvusg32ZAGFv9Xr99EyVChmmLIL3VTli5fOydLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwbLPOLcdJndDzjw+bLVgjATmAIBEYm9DOIChgG4aMM=;
 b=UZiz47mW1anTbj+MGl/t3lcAIVDZ60LgG+Vfd0leDS71z6aVwXPPxzmXrKV0WGDT05FYY7qR81rZ3IkLgOo6MpRuz5kaVcG8VUTmKDL400XfOuOH/4pvAQMPYx/T7gzqBh+70+LyeiMybmP3+BrGordBD3RiVwZVezAuarX2QjcveA1tWX1LQUnSWoMs2SQlocwIFDqIuJa0c3h6kP+QZQoEzPU6CUtoHjImTxeM3Ua780ZmCeGmwmCNbihdgZ5V9beWht/LyZgdfHdW0q3tFE9zf7LSp/709DjEOv+FE9c3AwqdrVeQG04S1m6/vrwS959CPsK+8nOk6gJFUSboTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB6768.namprd11.prod.outlook.com
 (2603:10b6:a03:47f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Thu, 4 Aug
 2022 20:30:52 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 20:30:52 +0000
Date:   Thu, 4 Aug 2022 13:30:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 4/4] cxl/region: Fix region commit uninitialized variable
 warning
Message-ID: <62ec2c7989c51_881482949d@dwillia2-xfh.jf.intel.com.notmuch>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
 <165951148105.967013.14191992449932268431.stgit@dwillia2-xfh.jf.intel.com>
 <YurtcUKKDFUbjJp4@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YurtcUKKDFUbjJp4@iweiny-desk3>
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d1ffce7-321a-4b5d-0d51-08da7658396d
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6768:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZF4zg+Z2XcuLWLlAxamFQusgQpoAuEoZm0yYo/fk/pFFZugcGGqBu/60SOgNktRm/mwW4haklxRBZDSkoyyNyy9kJq2eTRy58hw7oex+ixlw+VyYaJytCT7jUG/fpXTNs3ZcN5DZG4mAGWfTNahFWEjdW435O6PmZUNdp55H18JXfRpxQtfYvFhIJxBbHjvp8SGisWuJ9ComcSSLxkRj6rfNE3N6SoXA3Rj1m0EZkk0Sgs5hNKnoQlnPN8sZ9NNiG/2hKX98jao/U80MyJ0Hq1A4ibVBTOcv7l4Ec54yOMJCWPjujPgkcD67lqH7Ta5/ohX6EojhIkHA0RCcC8ggSkt/2OWxMX90SQUmfgtyQDZPGFjr+T+eivufiivOrEFbPoWCRTwOtur7cn+WQZFua/HIqVmZXG30xPsSNufKTSTcRm4YWTMM7Z5zukTURbRz0Kf0v9egewaUK1FHdnaHbad5plVzQX1myE1IJL8nNzVMaWKog3gFAJyLnj3gx46PZ3D/aORe9OSoM3djAoywZ9dJsp5hKSh9oBHP4WM00FfzNKXes+BPcK/K2ffmnDeIB0B8RXkG2+77UWkpo5vK1zSbnlD+ogGdZ2kRba5vwo0yTDa2Av2sgYzKTUjazfkAihGOjUKoe77/4gJJQRq55fUrBpokCIYiDnaPFAm5vuh/Sl3Tp03eFE1kOCtOjWUCECpnQCddbwDrLP3CkVWlmO6aR3qA85AoOhfwvr6zynzjeSgyEFLrNjVtXe/bQw1m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(346002)(366004)(136003)(478600001)(38100700002)(6512007)(316002)(26005)(9686003)(6486002)(186003)(110136005)(6666004)(8936002)(41300700001)(83380400001)(6506007)(82960400001)(2906002)(8676002)(66946007)(66556008)(86362001)(66476007)(4326008)(5660300002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IcxEXPFOWqQOZCcNsAotQw9MF08JQOAJWz3pczrUgL/o0zZxoRqAMRt53MoC?=
 =?us-ascii?Q?nlUcoAJKHkeZgTRtIWVmLjXkUMQsn78uylZEMZc2utUAOONkJOYSgwg91Axq?=
 =?us-ascii?Q?0+4cn0unJcVFSPyZuFE8XLk+Begi2zscH9cvlpMmTExn88Dt//u8nJZEPrhK?=
 =?us-ascii?Q?6ztRHvVydbUds/8Zr8/4s9NTiAcEFnqKOArXPTH/ynC/m7wZW0Zc4Bzj11c2?=
 =?us-ascii?Q?ng3MV88oY04pyRdLkt6CKUmWPXotgBLFoODMaumJuSyfYud9/dV+p6PqNdxb?=
 =?us-ascii?Q?tH/kIdKPqfJ9aiF8TbnVF2Vf1uDH33H4nw/jzQePY+G+wX+fn2+maa0vsdQu?=
 =?us-ascii?Q?FiZ3cRIq05IHk5Hh1DibtLVYnhG91391+TsQsvuePPfvtcoyFt+b2ynEH4ql?=
 =?us-ascii?Q?6tg9CNYbI2EUtYO+0ElH9MZgVDacUcFIOGwdB+p8qUC6/ZM5Au9TGUfrsH5u?=
 =?us-ascii?Q?YdxQ0HLnKYoFKBWqVScsUo/AY1Oh2QJ1+wjlu/X9Auz1S+vF8uKOBWIhbe82?=
 =?us-ascii?Q?1kYFvPLhi4XkfzlzDqZ+9KHe3BRN66Q6rWxQi9ThicjF0ikaqnFV6Sx7sXEr?=
 =?us-ascii?Q?YGN1iF9TanPlGCMbc/57IYIAcpy6IWDwgj5/FNTD32/JcqHD71X1BKDgTFDn?=
 =?us-ascii?Q?xfGsoBeaUnOAVE4oT/yvO/EZc/PzVeuVOC5maD38226hs4/m++3bKR61XUcp?=
 =?us-ascii?Q?iWNcY6oDyJ4tfTS9p3lGNzSBAGI4A2HK9WGLSEfErkEBhqyLDXWnWxVrQNCW?=
 =?us-ascii?Q?M2RtpJlDBqDCW3pjKNO0d3EcN1LExpW+occfkdQzBBv74IU4JrTlLD9Chisi?=
 =?us-ascii?Q?zotp5OMcguvDqSVkYjNl2/ZZhwr4CLuYrZ299X6hgOuvv43uXsxf0z1hWF93?=
 =?us-ascii?Q?aA/nboO3WwGYrwbOdxAtL4k4140B4R50iKBOgVYxfFsDOUI6qvYGzrWZJUjd?=
 =?us-ascii?Q?RTBn5H8s0fRHx8uN7sJjhpDRfeANej3TKvNqcWvSy+gQ7TLchFhsIHVMBf/z?=
 =?us-ascii?Q?ENQpHMP0t7FpTYiVr28eK7WFX+ou2yjeJKNn7QSCXwEIquWH5zpRZdE+JDZ0?=
 =?us-ascii?Q?TK2VPIDDuqwnYsIF2kmHsXtBhb83L+AKhck1BsfRpzkkpeVMag5zFnrlM8Cm?=
 =?us-ascii?Q?BH56WUe6Oy40b2hOuA4Msobd+Ylx1NHfK4APIbyqaT9ASVjzsUo7N1pSHhZF?=
 =?us-ascii?Q?Fv+yCE+Xat28icMVYB/GE0D4F8k/27YvgFTTbW81U7SSob29pb0xjK1+YOUE?=
 =?us-ascii?Q?zWUXwihMrrJ897Eh0fkXXZwaPdhBikEHkhi3JfvBDDGZddmklGoAyP+8dY8W?=
 =?us-ascii?Q?cATZJwXwH03FYGjz8JpszOLVhsJOuZR5RWWh3ubVs/fg5K/LzGcGaB/6Z67j?=
 =?us-ascii?Q?20X7nY4fVhIws5yg534QG94EekNdsGkjVfx+bJBXbqflC8Ro6gBWO+rQzOIo?=
 =?us-ascii?Q?o+OSpI1COzdKJe2KyVdoehxp0JS8NYfYEjKs04XrgjN8gk4VnL3V7qQob7pu?=
 =?us-ascii?Q?bsnGdAeKuCE9o6ln8Z70VDyMmO+Db7+fvq0QkHxz/LoZ7BZUYut+qqVXmphc?=
 =?us-ascii?Q?0qgOQCk5y8zvAVfKBcM2rek45BUlUTDnjHHF5CL9FiVciLjPKrEuhckCd6Xo?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1ffce7-321a-4b5d-0d51-08da7658396d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 20:30:52.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7ThDGhZfJl2yGey1YRO2gjDFZRZku9RF2lW/rnE2c2/Eo6+TmU+LIFxMwsTgYjkspCqbgYvDJ7TLTDoKpgywz8Iobboh24J+I/rlAMRPlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> On Wed, Aug 03, 2022 at 12:24:41AM -0700, Dan Williams wrote:
> > 0day robot reports:
> > 
> > drivers/cxl/core/region.c:196 cxl_region_decode_commit() error: uninitialized symbol 'rc'.
> > 
> > The re-checking of loop termination conditions to determine "success"
> > makes it hard to see that @rc is initialized in all cases. Remove those
> > to make it explicit that @rc reflects a commit error and that the rest
> > of logic is concerned with unwinding committed decoders.
> > 
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/region.c |   12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c931b6eb4e7..a68e4e0cf169 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -159,7 +159,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> >  static int cxl_region_decode_commit(struct cxl_region *cxlr)
> >  {
> >  	struct cxl_region_params *p = &cxlr->params;
> > -	int i, rc;
> > +	int i, rc = 0;
> >  
> >  	for (i = 0; i < p->nr_targets; i++) {
> >  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > @@ -180,7 +180,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
> >  		}
> >  
> >  		/* success, all decoders up to the root are programmed */
> > -		if (is_cxl_root(iter))
> > +		if (rc == 0)
> >  			continue;
> >  
> >  		/* programming @iter failed, teardown */
> > @@ -192,14 +192,12 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
> >  		}
> >  
> >  		cxled->cxld.reset(&cxled->cxld);
> > -		if (i == 0)
> > -			return rc;
> > -		break;
> > +		goto err;
> >  	}
> >  
> > -	if (i >= p->nr_targets)
> > -		return 0;
> > +	return 0;
> >  
> > +err:
> >  	/* undo the targets that were successfully committed */
> >  	cxl_region_decode_reset(cxlr, i);
> 
> Doesn't this take care of teardown now?  Does the for loop even need to do
> teardown now?
> 

cxl_region_decode_reset() takes care of fully committed positions in the
region. The teardown within the for loop handles cleanups in the middle
of that process. I.e. cxl_region_decode_reset() would end up doing
unwind work on decoders that were never set up in the first instance if
it was called to handle all failures.
