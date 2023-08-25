Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3EEE49A5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Aug 2023 20:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjHYUUo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Aug 2023 16:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjHYUU1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Aug 2023 16:20:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44F91736
        for <linux-cxl@vger.kernel.org>; Fri, 25 Aug 2023 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692994824; x=1724530824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XrSk9StQ2vo3k3JPHoelNAKSfWKAhMn9Sluc08r96HQ=;
  b=gkoaiDAST8dyOLxI1VgxoQU9+1yqJGvlpw1WRzEjKC2HsSQ95VgJbQpX
   VMfOMhEW/mScrDpt2Dq0bzgNz9X4xY50/eqHmR1zxlZBz7tWvd4IbbTRf
   3b1fexcJcWI6Q65jPziOiTdbukI1gcmcTJkRDgXB1GGLJwE9Y1eSNuWNN
   fec1UvMnjIpuj4B9QhMaLcdmBa0dSdCJF3fWr3EsMpdMfw0r+WdS1Vbsd
   U35NKVst5+V9AZdzsOh/YMiihxoxOIDmOk9Ro1sz/Ndte0+qaIwE0CKkV
   wBpndUeUdY9xZfNzWGUkkQXWcBvXx7Haq0DfbRkB2l0NcjIkLFk7xdVDe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="372194599"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="372194599"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 13:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881268604"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2023 13:19:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 13:19:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 13:19:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 13:19:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 13:19:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obXGLQrVQCSvL6191jEwyb5WUtthHZw5E7G1Jd7DkLOvQonUqhN9NcssIRE9jwkcuswU8TlNN4AaJsPseRzstAYdfAxyMCvq0NnUc9AKw6H1Ao+NrqBKLprRlBGeZvApeoQJf22NnYDbuE3DSSkH5NXGpaaCTi2f/dbvfrKsfMDmxmkQAa/iugGUI/hwI27klP4Gyz1DiKfdjvvaOOV46fNqJn72dMFBAnACvAr04rpshQ1US6R/6K5bUSvGyODoKnkc4T83UmeISowSyRtJtTP+iZLBN1xUFyUdqUjVuBUKbT7S6StM/sYqlK8Gsrf7fVMbA0FgLPo3N+Wga4L8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBZ4G4w7m9MmPyJ1K7RdZdoom/OCIJYdfaD732eyqbg=;
 b=fhFoPIOaSK1W++Gx0Y8fWWvgYAYgapVKkeam9emeBAtP/cQ5f69+8Gml5SaEvBI7GHHjdI44Si7E356ZvcWzCYMgUPoPZzqXZiZlg3hilUumydb7VXSWz1QRvIXs7oCAJ4rMVHy4Epj36vlpwPMVsgj/P+PhngJrBQ6QNBPiHTqZHGeo5tyRBdVMjl/8AaXCYWLXvH+LWzEfMIQCAhu4o3+qVdP3nmjvcU2f9V1xlf7gJIzkzptY3RRGK4fkC0Li14qVdP7c5TQSxYY/hizneTvu5jU6W9sdnpFturaSuS7Na9aIL6WHvYjf1RtsoJVPBnQqfgqIR0IrXql8ee8JdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 20:19:17 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 20:19:17 +0000
Message-ID: <dc31d83a-a6c7-a96e-bfcb-1999af3b3ba9@intel.com>
Date:   Fri, 25 Aug 2023 13:19:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2] cxl/region: Refactor granularity select in
 cxl_port_setup_targets()
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
References: <20230822180928.117596-1-alison.schofield@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230822180928.117596-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO6PR11MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: b86ebf8e-0ed2-4431-a258-08dba5a88ea0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEcX3gF+xor+F405zKyYEZV6LTHU8ysix/JCZj/pb0Le3osuXIX8On0y0vO233TIeqgzGkfE3/27JPpjsxc1y+OUWW4U/cwkVxHhTFUXFMWcPS2wXX/cfbOdnicETyGOrTvl+O1SBOWF+z5ci4cSjxogHa8GvMgxm+r8GtRIAwpp64d8Qs5UydLkpkPY8/TNBmlFMOa2qWgElbgyxJ0AfS/GD1wXm8kJPgqMKBCFK952AGAvTl/s6v6Hth5HGFhB51f8IjUp3f0cgOrinxi4Rw+oP5I9GxUoGwTRGVfx5ezcr0S5UGA6Rh/9giTT08SYsJWCiAlZ7bSDq3lh0t8GBdM6ghQVTD4+iN6l7MtoyIXB7/FPwTDfH5dxNEXKbb/KJtPQ0Y5Ri/tTcZzGazJhMzgRxXS6CZE47iF6gkoyNxmkBRYkmQsz2l0bH6vukibkGAXQbjHAP7gRsL1PoDZ8KISgs+SP9U4T33RG0aQA/fRMngfBNepf8uyIg1EOSmCMS+EcECvSm86BRoCHSVA6c+XcJaRUd2nbPDdAHaccyGz4pplalnWIy4byeK4kWB5IvEsOsKjAHgaqXiZFXP2lF24T3VRXQ0gyXlK/nbG9aKDaSPMEzboR0lG+WWn2BNE5H5NenEw7/E9RWEr/FKKamA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(1800799009)(451199024)(186009)(44832011)(83380400001)(6512007)(478600001)(26005)(2616005)(5660300002)(31686004)(2906002)(966005)(8676002)(8936002)(4326008)(82960400001)(38100700002)(66946007)(6636002)(66556008)(66476007)(86362001)(110136005)(41300700001)(31696002)(53546011)(6486002)(36756003)(316002)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VllDMEZIMnFOZXpnMXoreURoWjhnaGhwcERodDdHNVBWZyt0UzRJS0Ztc1M5?=
 =?utf-8?B?VWpHVTdyQU9uQkJMV2ZkbXNGcWQrMkhzTTBPOFVLZlEzMlQwdWU3QnUyRUI3?=
 =?utf-8?B?VUVZTHBPTE8ycGJIZUVyRjZnaTZydHRxMVc5SmF2RzI3aCtZaHJna1dMVk0v?=
 =?utf-8?B?akI5MW52WW43N3czd1hxL0tMelVNVGNxUHM3TkpEYUIvaHdXUGVBNE1mTmgx?=
 =?utf-8?B?WnhGUTU4aHNTTW9qYlJzRUVNWW0yUmxxSnpnUU9kd2FzaEJ5aXFUdVFwbVV0?=
 =?utf-8?B?VEhDamdzT1VOQnVoU3NOdFNHU010dVJRcVRQUnY0akxMSlpTZ1hKMlZZTWpM?=
 =?utf-8?B?SERvS29xdk0wa1FabjYxVy9lMHB6QXBSMzM1Q2VLcjJXbVJWUTRBb3RvakE2?=
 =?utf-8?B?eTBaUUd5TlJScGgvY24xc0JQdEU0bHp4Z0MyUXNjSGduWVhpQU5ZdUJ0OHVa?=
 =?utf-8?B?NDdyV09jcCtBb3ptQlp4dG55WUxUYzVjNkhhWlFvQ1FCc0lxdnhlZGJWbHlI?=
 =?utf-8?B?eEl0M2lYdG9zc2pRbGxjWnkwVVZyUTRSaXBjNVRxS09PYWRJcktNaVg2dG55?=
 =?utf-8?B?R1lGSll3RTV0dWxoc2NqRDB0NGlFNGkxaFhGWUo5N29YSisydjhxalJteFY4?=
 =?utf-8?B?QVkya3dHY1VJaFN5dHhJUko5OTlzOEpaWnJ4TVlCNlgweG5OdXdBUFlTMkps?=
 =?utf-8?B?d2dUVTFTcm82bnQ2dnJwRDZzVEFtdnFCYzluTzlxMWNiSzZNK2UzMjd2bFND?=
 =?utf-8?B?VG1BajR4UG9mVmxsTkd6Z00zWXlJejdJNVpreWlJd3EzM1l6NzQ0ek5ZWUNU?=
 =?utf-8?B?dkhxWkE3MzhUSHhxS2dZRUkwL05jVHIvdmIxL1ZxaFE3aHI3ODFQK1VvenZE?=
 =?utf-8?B?c2tGeWFvSUJoemxuMFYySXdmekcyeEhieUdFa1d3U2UzMm5hSWM0clJiV0wr?=
 =?utf-8?B?d3V0b0lUVmUwVkl4U2FLRDJrSm96bzdUUEdzNFlDaTMyQmxVbHVWMS9zaWtH?=
 =?utf-8?B?VzFrU29Dd0tiVDNtODdOd0dPbjZhbGVGaGxGWVlvSVV6UUZZR1dzWk5iTjlw?=
 =?utf-8?B?TFR4cDRYa1hMOWZ6R1FYWUdhTFppRjA3Z0hnWDhFeEluRWxlWGtES09SSm02?=
 =?utf-8?B?TVRhbXpNVGtjZjVaMFNMOFhaWTVmdmdTNlpxWnRQMlh4K1U2TVpHQUl3Ukcz?=
 =?utf-8?B?SUtqcjFkeFE4K3NBZmV4eHl2bjU4Vjc1WXBPZ2toandqMk9XRUdWNUErWjF1?=
 =?utf-8?B?VHpLMndFbGN2a0VJaHZUdkNGdjU2MGpGTDFsVTE2alRhOG13Um12d2k0M1Nu?=
 =?utf-8?B?bkVEdEhIUWFxd0YzWXp1OEt6TFNDWkZDa2lEbHZhRmNNeTFGSFpzWkcvQ0ZE?=
 =?utf-8?B?ZFZZLzFGWlpBQ1lnSkJRdVYvNmVCMkZTQ3VLUTNmUVJnWjVhMGlnbHlySG1Y?=
 =?utf-8?B?M1RFVklGT0pPS3phMzFHc0taM015UnZaOG5CZ0Q5d20zWVBFZFhYMjNmN04r?=
 =?utf-8?B?bXA2cWdkTVM3L0RYci9xSmFNYW1YR3l3dnpnNUhLVUQ2OUlBQno2MzF3Ri9z?=
 =?utf-8?B?S1cwelFOTjN3Mmp2YStGcTAvVzBHV2dJN1NUbXVMellCU2F6cWs5MGJoOGov?=
 =?utf-8?B?dFRzelFJdXRGYlFlVWhIVzlBNWpydG54cGt6bjF4Z0V0VU04clBZWVFQSWEr?=
 =?utf-8?B?bnAwMXBSdGtZWFlVWjBwRkFiUXJGRDJwT0VzeVMrRnZpcGhsSEpWak92TTd6?=
 =?utf-8?B?MkJ4Qld0NXcydGd6K2dNL2RNam1Mc3RyZjUwWEkzeTQ2V2w1MGVlY2diSWp0?=
 =?utf-8?B?SlRINjZIS3YzL213cVpObW9Scm44RFZqRVpiTTNXTzdrM1hrNEthWTV4ZmVT?=
 =?utf-8?B?aUdqeHF2aWI0Z2laaEcyd0VMVHk5THF3WFpzQkRmTXJ3UkYyZFQ1cGNiU1BM?=
 =?utf-8?B?eWh4d01ieXJRNEtqRWRHN09RcDRmR3R2YlpFNVNhQlp3bHpOYkgrSmNBaDcv?=
 =?utf-8?B?NitHYkVxWktDNnpmb2pESlhEenZORzJ0aU5rTkxBL08yYXNja1pCVmQ1dHBE?=
 =?utf-8?B?czJ1WDRyK0hTb3Q1MkNwYnFqdFJDMlhMeVB0OC8wY0gvYzMzYnhrZHozRzFS?=
 =?utf-8?Q?0zDq5qNkkWM57+OeLXYCJ/un6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b86ebf8e-0ed2-4431-a258-08dba5a88ea0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 20:19:17.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38KeEclrwEgKWaZZbk71ewYUbRILLddE+J9DrcmU9GP2OBvw9mkLLkpb+5iFl7R+O3qNFJnb2T7ZV4dHERQGQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5602
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/22/23 11:09, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> In cxl_port_setup_targets() the region driver validates the
> configuration of auto-discovered region decoders, as well
> as decoders the driver is preparing to program.
> 
> The existing calculations use the encoded interleave granularity
> value to create an interleave granularity that properly fans out
> when routing an x1 interleave to a greater than x1 interleave.
> 
> That all worked well, until this config came along:
> Host Bridge: 2 way at 256 granularity
>      Switch Decoder_A:	1 way at 512
>          Endpoint_X:	2 way at 256
>      Switch Decoder_B:	1 way at 512
>          Endpoint_Y:	2 way at 256
> 
> When the Host Bridge interleave is greater than 1 and the root
> decoder interleave is exactly 1, the region driver needs to
> consider the number of targets in the region when calculating
> the expected granularity.
> 
> While examining the existing logic, and trying to cover the case
> above, a couple of simplifications appeared, hence this proposed
> refactoring.
> 
> The first simplification is to apply the logic to the nominal
> values and use the existing helper function granularity_to_eig() to
> translate the desired granularity to the encoded form. This means
> the comment and code regarding setting address bits is discarded.
> Although that logic is not wrong, it adds a level of complexity that
> is not required in the granularity selection. The eig and eiw are
> indeed part of the routing instructions programmed into the decoders.
> Up-level the discussion to nominal ways and granularity for clearer
> analysis.
> 
> The second simplification reduces the logic to a single granularity
> calculation that works for all cases. The new calculation doesn't
> care if parent_iw => 1 because parent_iw is used as a multiplier.
> 
> The refactor cleans up a useless assignment of eiw made after the
> iw is already calculated.
> 
> Regression testing included an examination of all of the ways and
> granularity selections made during a run of the cxl_test unit tests.
> There were no differences in selections before and after this patch.
> 
> Fixes: ("27b3f8d13830 cxl/region: Program target lists")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> Changes in v2:
> - No changes to the code. Commit log fixups only.
> - Correct the commit log example. Endpoints are 2 * 256 (Jonathan)
> - Use 'encoded' and 'nominal' when referring to the interleave
>    granularity format (Dan, DaveJ)
> - Commit log grammar & spelling fixups (Dan, DaveJ)
> - Add Fixes Tag (Dan)
> - v1: https://lore.kernel.org/linux-cxl/20230804232726.1672782-1-alison.schofield@intel.com/
> 
>   drivers/cxl/core/region.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..5a1cc59cca99 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1154,16 +1154,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   	}
>   
>   	/*
> -	 * If @parent_port is masking address bits, pick the next unused address
> -	 * bit to route @port's targets.
> +	 * Interleave granularity is a multiple of @parent_port granularity.
> +	 * Multiplier is the parent port interleave ways.
>   	 */
> -	if (parent_iw > 1 && cxl_rr->nr_targets > 1) {
> -		u32 address_bit = max(peig + peiw, eiw + peig);
> -
> -		eig = address_bit - eiw + 1;
> -	} else {
> -		eiw = peiw;
> -		eig = peig;
> +	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev,
> +			"%s: invalid granularity calculation (%d * %d)\n",
> +			dev_name(&parent_port->dev), parent_ig, parent_iw);
> +		return rc;
>   	}
>   
>   	rc = eig_to_granularity(eig, &ig);
> 
> base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
