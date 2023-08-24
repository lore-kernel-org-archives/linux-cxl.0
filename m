Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346CC88CB9
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Aug 2023 16:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbjHXQpB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 24 Aug 2023 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242766AbjHXQow (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 24 Aug 2023 12:44:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E791BCE
        for <linux-cxl@vger.kernel.org>; Thu, 24 Aug 2023 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692895483; x=1724431483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4WRU6hEyqTqaY0Jo3HVwFICRR+jX1llzN7aXxm0Y9Ec=;
  b=GItRZ148ikE4bw9ebEdmP3XjhdgMABDl38z9Rruk8K/iipjrU4LQhxVD
   thYErL3o0MJ7+TffnE1W/F9Gd7pyHc6SwgAspCLdNhuf+vobjcgXOH8WI
   Fh/tTjsz8+2dRKyCidOYssEZmEJB7by5I9IER9plJfzVqOHzj3eQaQvKi
   paveVu38kQxETtKeENNWU5E6amPwWBp5RJ5dIC7dbRjAJU70U+jzy2TAu
   mXL9Lbc9C4sWtYn+5v+M90BxrgAv9nsDyHHePJ2xkHir9CaPa6va//837
   jVFvrn0rQAFpuJSBa9zEoRs4abIm6yxMnmRujpnMXpj+VSxyp1Khs5Ht7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364689090"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364689090"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 09:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802598769"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802598769"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2023 09:44:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 09:44:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 09:44:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 09:44:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyavhPUN9lny6fQua0pjZ0UZGA4ypXKYMPUc59bfSUwyUAyBHZpLZjRmfFO6TdoZ1zV3DEphb4AZSyUvSad6qRLKaVJ83Z0QPQ1fyDhugpmtbkurh1Pl2V+8c0DjqYlfoQlgyFRkeav4RBywWw3+K+MEZth18o34767v/VlT+dxlLSuGD1XszXTOzs3OUd7Fvao0PkrtZyAoI8RH3gw4B0Yggau6/gphlBGWvkEI4E3f1QOhap3fdU81+LxezZ2XKCDLppQjz9aXdNpAgLmQlH/likfRQXWeyCwstH1Ca7VWkad3LADOCN4ZYW3Y5Jz7ohBj14Jk/frCFBhggB+yOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+kB2oexOZT4jgTCLdoFB+uVKZwHjrHinLxPgpCD4gw=;
 b=HclMdbtk6juO2NYOFV/7xc0waVU24nasKkczUIKccqUaF8hgN+E77vUd0unwDB+sn8kIn+d7sDuu0irGLVhuaY+srHAINSp8y4lyq5zgamDuuiO/N+nFSn6xa5kh1mFbZv4ma9yUdF4zrz6gfAjQq9ouCW8s857Toj4wbmoVCVV9Jt9Nt4ZYSjo/1q51hCS+CHnz10TaOol6ccw0oQOSLMj8vbGmkSqFbBnhVGatv0KPDOotpG/C4HyUu24f93VdT+e+5lso1xF+QZ0FrGejloavTCtySUf1Fetw1p8y1egEH2yiNwgu7RBmbweeQ3HebkBgVFhCk8D6MPJ9MQpmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 PH0PR11MB5158.namprd11.prod.outlook.com (2603:10b6:510:3b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 16:44:30 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::c542:a94c:fc8a:52fc]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::c542:a94c:fc8a:52fc%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:44:30 +0000
Message-ID: <51aded82-7c46-dd16-67df-2dfbd9bd58f9@intel.com>
Date:   Thu, 24 Aug 2023 09:44:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2] cxl/region: Match auto-discovered region decoders by
 HPA range
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
References: <20230822014303.110509-1-alison.schofield@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230822014303.110509-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0049.prod.exchangelabs.com (2603:10b6:a03:94::26)
 To DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|PH0PR11MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: ced2cd99-a405-4775-42d1-08dba4c16300
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZkI8qX+AkWu2pPXHUj/cInDp1hLMT+HT20xieFGLPLVL4qQPgwZlUu0N6h0HN0bkamjvdrH5+s0DSEeXhyLRNrcytPUGSyh2UzV+0c0f5a/RhCNPXvA7kIZoSJeSkapE2xp+HRqtEGDc7F+si0IJnKX5MyUqduOqHqnsp6+uMbigzxnNA5mDoYKmkyWcEQAvsC8xe5B9NQ1j4MbUxB+Yk5KYVGGpfnfZMyk5AebJRaTPKx8bt1A7LDoYN/gioiAH+NngIEVcnf1XfsVP5eCqcIRL3ScrSINxTZSjH/pjo6S8QaFwASMWRTjHM0ud2sTc53vNIcasFPm6/mgU+X3qGe2CBxS/G6C+ouzy1bRFNvaLkkxVVbxwP8aHieNWEVhx1QupmowNSHEmTHACaYC3pQpj6mBtYR+dR+Rk7lA5t0CZ1pNiz4Sy3ge3kGOQsZLWkcLXaPMmQK7RYOs/lMyXmDpN1jk9he9hPSXHVhlq/5OTSzThbQKQGg9oQC4MFOc8ZEhtxoTsTy4mzH6k2206Y5MgO7Z2GcMxtQQs80ff1Z26Edy7ogYUXnEVcYRODn+a9DSIBHpag9yD+S2NwiEliyWdsGqE0gOVW6kxt6xNvH+qUcByo1PQwOilSoF7jCS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5990.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(186009)(1800799009)(451199024)(66946007)(26005)(83380400001)(6512007)(53546011)(2616005)(41300700001)(66556008)(66476007)(2906002)(6636002)(316002)(5660300002)(44832011)(8936002)(4326008)(8676002)(110136005)(478600001)(6486002)(6506007)(6666004)(966005)(82960400001)(31696002)(86362001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzQ4S0srZW1CQlEzQTlrQWF1NXNmMFBwR1pHbFIvLysrWWhiN3ZCWGxFOHpa?=
 =?utf-8?B?NjRieWhuN3ZsemlRYVdoTTExRzh1TVc1dDBaZnkwMTlSczkwRTgyeGFUZlEx?=
 =?utf-8?B?TEFvN2dsZ0hGRjJpMzdPVExQZGhUbVUzME1IMXRDWllha1B3WXk4Z1EwR0d1?=
 =?utf-8?B?MXZyRVlLeGc0QVlwbnIyaENPMXI1TFhYTVhvSDlTWXdDQ3gvTHVBWU50NFlm?=
 =?utf-8?B?MmpGd0EweTJaMEZhbmpsU0JjTEpvUDl6RElqenVrbVViQ05JSkFvK2ZwcWZu?=
 =?utf-8?B?SEVSOHJleEo0NW9nMDY5bWVRVXR5N2pEOVBzL2d1bVc0ODZhVytSMGlyVUMz?=
 =?utf-8?B?TmI5ZVM4WnU4K3RFVGJzemlZb3hnRFlpUk1jbElNZTAvV2YvazFlNE1JeGx2?=
 =?utf-8?B?MGVNcmdtL1UxZXRXcnAyb0ZJSTFRS1hLQnlGUVRuRldQUW04dFp3LzhDUEg4?=
 =?utf-8?B?YnR3blF4S3dnUXhJZUJiMHhwcXZUZXA2cEtoZU9SQk96Qk5pdDZzQldDZnIv?=
 =?utf-8?B?SmdBQUU4ekg1U1FrNmdwbk1nUjlyMWtRajQ4dEduODlRa3Y1Ty9hN2RDTnE4?=
 =?utf-8?B?NmlQWXBWL3ovcW1CbTg5d2NKQ2tFMkdiQnNnSVhmUnhqajNJcm5pazluUGdF?=
 =?utf-8?B?MzhHc1BMdGhPellEdmtFMzVqUmFnK04wUERaYVp4VTZOVHBteFJsYUJCRG5U?=
 =?utf-8?B?elFtdWN4TDJ3Zy9iR3FkYndIREltK1RlbW8zQjF1QnFCWGxtM0dRcUFqRHJQ?=
 =?utf-8?B?UW4rdFFMVHlXREh0ODExdXhGRUptMGJkQ0pFTC9ieUNKNDlhQVMwRCtjRXBH?=
 =?utf-8?B?Rkg4d0pNM0k2ZmdxQXl1SHE4S3ZUSy9pWmxZaHFwbHd1RFRidkNjSldOVlh2?=
 =?utf-8?B?LyszRTNWeWJVSnYyMU15U3I2T3Y0bmZEQ1o0L3Jla3pUSmtHVXpDZCtFb3ps?=
 =?utf-8?B?YUJNT2dHSldzK3MzaFZ0RWxBTjlIYUV5aHFYRlY3S3V0S1ltL3hDTFlaSTlK?=
 =?utf-8?B?N3JNQjZPRE5zZ3I4VVVSSWFiTjYvdkQwUHBuT3FvRzlmQVRNaS9kSTRiSktI?=
 =?utf-8?B?akNLY2FYWnFBQWZUeFZ5blh0UGdYeWk5YktRY2lFV2U5UmlzdHpxZ3ROc3Z3?=
 =?utf-8?B?RXQ4ZDV6UExCcmlKNzdQbU9qT1hLaTMxSVhBZU1oaDJLM3R5L3BldFcwcGpU?=
 =?utf-8?B?OXpFODJKMDZ0bWR1dys0eWdlSDdlbFl1RDJBdWpkZ01Kb0hKc3pCcUhGc1B3?=
 =?utf-8?B?RlhxbFpLazZGVUx4S1dtNkdpT2dFbldyc1lUejNXSjNYUFU1aHFiRHBsZnAy?=
 =?utf-8?B?azNscGJYaGFnbVFPT0FDUk50d3NCSUlQVjJzSzFybi8wQllCMXJrWEt0VGtv?=
 =?utf-8?B?dDRTcnZHTk9TeW1mdlp6Tnd4VWxxWjBDSHBIUGlWTEwvb0tUUURKazJVeVVE?=
 =?utf-8?B?WEw1U2FGOXVzMk1lWklyb056M09KT1V1ME1oNm1EUlFFRHZ2cnA2L0JUVWd2?=
 =?utf-8?B?RTJubjJoRzN6UjdGcHBrWkxwRi8xQmVoMEw2eDcvMEdFK1Z2cDFNWEo2Vmls?=
 =?utf-8?B?ejFxMm45Sm5Ud1ZYV2MzR001ZnJkdFRjSVJYTHNQMnNOWk9IRmVraVdGZkNx?=
 =?utf-8?B?dzk3VEY3REtJMUtiYWVqUEFkbXhXRmtGV0hwaER4Qi92OVNLUVFGU01Hb2Jv?=
 =?utf-8?B?bXlCQmxLSFV5bWROWksrdk9pMW1ZUk0wVXpXQlF3dXRqVk9tWTU5UmplSE5F?=
 =?utf-8?B?VHBsSEpQanc4cEJxdHJSNHFQb3BLMzhyMVg0NGx4ZWpWV0xRU1p6K0pHM1Rw?=
 =?utf-8?B?S0o4STY3S0NvWUZUUjdKU3JRLzlVdkUrYXBUSGlHWHpUS2pxL3N2YWQxaWhq?=
 =?utf-8?B?MC80MU8rMGlHcWU1aktjM0Fqa3Vva0JBODNrSFZOQXIxcDlHUG1QcGdlZXg1?=
 =?utf-8?B?cWtFZFV4RWgvUG5YblpSK3NUcHRpdnNKdHpvZm53dGVJNjZ1TlJiV2FkOWZu?=
 =?utf-8?B?UFpSZktxVzZKUmx1Q3BVN1dLZHpHejJuQkhIbU5jcURadmpqOTZLV053b1h4?=
 =?utf-8?B?S20veVlDa3pac3pVVVFTU2ErNEV3S3FzMW5tNFdoZjVTZjhmeGwxSkFURDcr?=
 =?utf-8?Q?UvAm919vwyGFsPGtm0/X6c019?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ced2cd99-a405-4775-42d1-08dba4c16300
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:44:30.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h91htypk0h8LL9amAJQLBE/rLaLK+k2/h+fFOma1PlhPo6Y+a4EjpE4OJSC6E2UZTov0tX1MSixHhGip8iZvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5158
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/21/23 18:43, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Currently, when the region driver attaches a region to a port, it
> selects the ports next available decoder to program.
> 
> With the addition of auto-discovered regions, a port decoder has
> already been programmed so grabbing the next available decoder can
> be a mismatch when there is more than one region using the port.
> 
> The failure appears like this with CXL DEBUG enabled:
> 
> [] cxl_core:alloc_region_ref:754: cxl region0: endpoint9: HPA order violation region0:[mem 0x14780000000-0x1478fffffff flags 0x200] vs [mem 0x880000000-0x185fffffff flags 0x200]
> [] cxl_core:cxl_port_attach_region:972: cxl region0: endpoint9: failed to allocate region reference
> 
> When CXL DEBUG is not enabled, there is no failure message. The region
> just never materializes. Users can suspect this issue if they know their
> firmware has programmed decoders so that more than one region is using
> a port. Note that the problem may appear intermittently, ie not on
> every reboot.
> 
> Add a matching method for auto-discovered regions that finds a decoder
> based on an HPA range. The decoder range must exactly match the region
> resource parameter.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> Changes in v2:
> - Use cxlr->params for HPA match rather than requiring cxled (Dan)
> - dev_warn() if decoder already assigned to a region (Dan)
> - Add failure footprint to commit log (Dan)
> - Add Fixes Tag (Dan)
> - v1: https://lore.kernel.org/linux-cxl/20230804213004.1669658-1-alison.schofield@intel.com/
> 
>   drivers/cxl/core/region.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..b08aec9f0af8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -717,13 +717,40 @@ static int match_free_decoder(struct device *dev, void *data)
>   	return 0;
>   }
>   
> +static int match_auto_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_region_params *p = data;
> +	struct cxl_decoder *cxld;
> +	struct range *r;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxld = to_cxl_decoder(dev);
> +	r = &cxld->hpa_range;
> +
> +	if (p->res && p->res->start == r->start && p->res->end == r->end) {
> +		if (cxld->region) {
> +			dev_WARN(dev, "decoder already attached to %s\n",
> +				 dev_name(&cxld->region->dev));
> +			return 0;
> +		}
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>   static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
>   						   struct cxl_region *cxlr)
>   {
>   	struct device *dev;
>   	int id = 0;
>   
> -	dev = device_find_child(&port->dev, &id, match_free_decoder);
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +		dev = device_find_child(&port->dev, &cxlr->params,
> +					match_auto_decoder);
> +	else
> +		dev = device_find_child(&port->dev, &id, match_free_decoder);
>   	if (!dev)
>   		return NULL;
>   	/*
> 
> base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
