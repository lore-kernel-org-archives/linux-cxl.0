Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92245C3DA6F
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Aug 2023 16:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbjHXQXe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 24 Aug 2023 12:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242484AbjHXQXO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 24 Aug 2023 12:23:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3D1BE
        for <linux-cxl@vger.kernel.org>; Thu, 24 Aug 2023 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692894192; x=1724430192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L/5TzrNi6pHD5wsxIkWdvK+ik86xyeqYyuvZUOoV/cQ=;
  b=iMJz17ObePezQGQC2QOqhX5lq4uUROIMz1+RLkXBAp9DDE95ByfILlUg
   GoCfVowhwZRZ0C+Qle9bri+QX0fzxlSE7qpOZdRYANdLeoUu0IkeEQlS9
   bSnDajvCzZ3kl80Rz/guGY/GOdrNSaG1ZzyR8pkWnQQnwfa5DqVWDIxbf
   yWCDMTAtRrPhVy1EYoDWaO8iqbl0E887WdajbC1nzVT4hBjHWK9OOeuZa
   45MSD/QgJ+QArUwEB6cDV6BHLlpCeG6oWEC79nYzARpFIbz8Iw0h4gZ1r
   ePKZnQ5nA5hAbDAh7+0g5QfXXMz2zEFnNOLjlK/h2d56Q5TLOAiEvzdtG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364682399"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364682399"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 09:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880857507"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 09:23:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 09:23:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 09:23:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 09:23:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 09:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKNSwy8a4rGdFD1YoAm8OaTZkF7yBz4xgvnCjBSwjLA9TwU43WRrUpU2//FcBhkXNaasFW4lTP2nzBLvHuugCTbGn+eMNDyYhLaKtpqNCNKgmwhIXEY240fxwrSMvd2ZnazET0sPi8DHknlDgL3J/WJjSkCMX3ZsutA8BwAp2NY2Q69Yzi8QrrsmJ0xbPmkhNZLAeleFbYkWENWB0PGiE9RJ7kwzQsJiZL+OSXsh0n/L/YFPcv5vofvOEtYurdB1abnFkjh1HSnmzWqJtBblyysFircVdRAZzDixtNG6jXbA0N+uvcAdK8DsMdQcFoDsOAyOpkMnU9kJygffNvN94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAJ95iyGaEGfag3AD3bteaTwC59W4C9pKoEHHDpbeCY=;
 b=UDBOr5ijcVh9A01wmW/4s6eN2EIrOgn6yudlO3pusFnV54aP94THn6B0IW3ucjLmlEjZPqHDp1TcF4GS1av0wypHNrBkCEJtDUuvp4fLptS1lHwkYJdI7HrkRTQz3jm9HAgBXsTIj5A9ju/PkvRNzHxBeOFiCYK4hvxfDpeFssuUj08AvNomSjdp9PmqY3j6J7esMPmApxlM0R9QRKvst+7PF9FE18SKk/dAD9iQGjJ5il6clBimgzR5RpENbmlDKnaH4nhK+FED4Ma48EogJUujPl2g+tXedePWNRH2rfrib4AUwvDXmR8elSfuh7ajEWNssNcp/LosjdvqLl0sTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 16:23:00 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::c542:a94c:fc8a:52fc]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::c542:a94c:fc8a:52fc%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:23:00 +0000
Message-ID: <2860d3b1-a5d5-2790-abe7-bf974998d370@intel.com>
Date:   Thu, 24 Aug 2023 09:22:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v3 2/2] cxl/region: Remove a soft reserved resource at
 region teardown
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Derick Marks <derick.w.marks@intel.com>
References: <cover.1692638817.git.alison.schofield@intel.com>
 <29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SA2PR11MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a601028-c1fc-44ed-4f70-08dba4be6226
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ts9MrJUqryBvFuABO7MX75UD1iAeJDqLPXZKEjZNufi4jcGUPOSPmbXwIeg7DidPQP70oPUCrAKB5KTVE7JDrJ3Ckuq8A9OkA+tuIybHvJy46u2iGqx5pvwWl3HlKbeouw82rnnsAM+ddTsp5gB9I4dao7ND8mWLCRWksec+XMLjbEm5PS5cfa9q7PebMPNNvnjPU+Q5O+FoOPdvPTqfoF07W4wVC497q1TcALKFFWipDa9quTj433lYeHFzEMLIBmL4m+L25YBnx4xnRrp9N516F/mFe17VfSRu2mSa2j5EoNnsVM4cWRXYGsbmwc1aeVZzlqOA57Rm4CKYewLzXH87GB8RMwxl09BHjv7wvb83mhoSmslMJ9ND8LOq8fsmLOuOoZ+hs+xpj7pTx68E0Zbdfui9EiBt3gs+trbGQc1rLyJPz+f5ElUz0qQ9dFfcJLx72YATYNl/867jlRLGVh7lwlwCA6lX2648Pz69hsy/sgABY5LQBKHwyqx6vlAoUPKoJjd450eriWYY8S2kssDzo1FCSzy2QGVe3j5UhM7//l+NB8u7aSGzKFxdA7yfJPuTl5aqpvccNf/SkPFALg1Vt7uUddH4EXiJewt8IMPxFDeGFRBFHNmbWZsGkTEMgyqcWSaZyO9trEutDgTsbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5990.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(2616005)(5660300002)(107886003)(8676002)(8936002)(4326008)(36756003)(83380400001)(44832011)(26005)(38100700002)(6666004)(82960400001)(66556008)(66946007)(66476007)(6636002)(316002)(110136005)(478600001)(31686004)(53546011)(41300700001)(6506007)(6512007)(2906002)(86362001)(6486002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJwdEZZd2J1Nk16aEt0ZmtSQ2ErRndQakpsa2l1WHA4cllISFpiRGt2K2M0?=
 =?utf-8?B?Zk9VL3IrL2MveEtyOHRBSStIaUMvcVJtNURRbnI3ZklvbUVaL1liUEpLaWVa?=
 =?utf-8?B?Ynh4bTdHTE4xUU1XSHBwbUFkY0RvT0xUWHJGNjd1dlFyNjFuektGUTZKZ0R4?=
 =?utf-8?B?UnFjaUduRnR2UjE3dStMREoxS2hOMWxRVmRKMWZ2WDVKS1YvQWlOb3VLTHNx?=
 =?utf-8?B?SnBUNTNZdzJtd1BUWGRycVJtSndOWTJhUnZkc3NhT0krSS91ZFl2ZjNBLzB6?=
 =?utf-8?B?OE1IQnEySS80d0JBMnUwczRaNUQ3N29MdDhFcHNCYm5nQ3Q0SytQcHd6MzMv?=
 =?utf-8?B?bzZIdFZJQ0o0N1NBWDlsamJWNG1LK3pGUHVUSWpnc3lBd21tNDNYcW5ETmpN?=
 =?utf-8?B?Wit4ODVhY1VCSGlFOXByTWR2TWpsZ0dkZWYwaDlDVlovRjdtNVI1aHVoSGpE?=
 =?utf-8?B?RmhnRWNjZzd5dEQzemlTMzRxM1JnQ2JwTlU3bGVYN3VVZ3E5TlRDVTA3ZWVP?=
 =?utf-8?B?eVNoUHhEL3ZJbGxhc25ZZHBaZWVFbUdrMS8rOUhEZUhIdmxJRGJOeHFnbDdj?=
 =?utf-8?B?U1k4dkpKWm42TEFGcUgvckVqeUU0VW1OZDRIWDFOaitxRjBTYlg0OWo4U2pw?=
 =?utf-8?B?RjlyZHVLMW5oMVk2V0p5WFpUd1N1eTBCamJsWW5qelBmcTVoWFc5Q2JSOVZ6?=
 =?utf-8?B?aXJEV294VmZoWmpWQTlkdWYzSWtGWFQxc0NSbS9CTUEzQVQxYWRsMHRKbjZj?=
 =?utf-8?B?c0d0VWpDS0lxR0lVK0tyaVhtL3hPbWxtK2prTHVNU3ZPSDlOUnNvMWtjR2Jh?=
 =?utf-8?B?MlEzN3hncXcvUGZOQXhwblhnVi9jWWg1U2w3cWd5eGU2Vy9NbHVWeWVvcnN5?=
 =?utf-8?B?cnQzWnRYQUFpUzNrdGQwUGZkdUFBc1pnQTh2SkVvRjNDNjd4c1FyS1JtTC9O?=
 =?utf-8?B?cHpQSHpiK2V2RHV6L0R6MzNHYzhhb1o3ejZYVHhpNDc0TFZpZ1VKTjdTcXhs?=
 =?utf-8?B?L0R6R29xbWRvQTVSTlYzNWpraStrbHE5VXF6MkRqOTlNaXNDUHNQTjNvM25k?=
 =?utf-8?B?R1RtcUErWE1zMFRMemI2cUFrcEZhd0puOUlrak1JUHF0VE0vK3l1UWlvcTVL?=
 =?utf-8?B?bUNRNFNZQ2xGbGVleFR3MGJVaXNlUi8xS3BqalJZbWN0d201ZDhYTkNES3Vj?=
 =?utf-8?B?bUtyWjZBY0pRK2QweHNpU1hRdXhxcUxKSW1xRzM5QmhvZHI3TjcvQlhiWEds?=
 =?utf-8?B?SndTNXYwc0ZpUUtZRmFhVDU3eWMxWHZHd3BmVUtHd2F1QkxmWUFGcSt6VnRZ?=
 =?utf-8?B?Q3ROL1BhNm8vRkdSUTdRdDgzTWdBNm9HNC81a1JkdERtR20ydWs5ZnVWYm9Q?=
 =?utf-8?B?U1cxOXg3bmZ0cmZ5TFp5M1lLN09meFd4THcyUElwY3JMQy9tbStvY1BIMkJC?=
 =?utf-8?B?akxYTnIxRHJkcHdiaVRsNXNuVE5CNk8rU0RtNjc3dllnQXhub2RVU2ZCb0pl?=
 =?utf-8?B?Y2FkRUN4UnFaWm5mUWZjQkwzNU9iL1hUZU1LcjFQLyt1by9QV3ovU01FOUh5?=
 =?utf-8?B?b1R1eG1nb3prZncxeG9yQTRaTlRYSzB6cjArNDdKNVBERDVsUEU3bFppU1hj?=
 =?utf-8?B?MHFMdEdSTWV2RmVZamRUN1NBb3ZuSmxKN3ZKMWZCVlN0MFJ3TFN6MUtGWGZS?=
 =?utf-8?B?eHgraDVRS01WSVl5ZEF3L0QxbWw2Sm9hMnBXa1N1b3puU2p2SjYyaFFXZzFL?=
 =?utf-8?B?d2dNb1IxbXVXZlFWZHcwNFlodU5pVVpQaUppTUVhaXVaTVlzN3ZBKy9yQ3Z0?=
 =?utf-8?B?V3FaYmxUMDZ4cWRxUXFvUHpIaUVPZ1loNlJaL3h2UURrZlB6Q2RleVN6N3JF?=
 =?utf-8?B?WXovdzhFVlBEY2I4VWtweHZhb08wY050akdkbmE0Nk1rb1RLSVFiOG5scEFt?=
 =?utf-8?B?K0hBUmhzRnJyTkxzK25NejRNbHdpVEdxRkVjM1QxZy9Kb3hjZjN4Z3ZFaEk5?=
 =?utf-8?B?NmVPNnBJamJLRm1HT25WdmNnMkRpdTN0QkovcCtSMVRCM1FEdXo2YW1mNDhX?=
 =?utf-8?B?c3dkVDZ3a3JuaEw0N3RKdHpYUjRJV1ppVUJkcHlEVzQxK1ZHQ2xBSGRpb2NS?=
 =?utf-8?Q?+MYgwbcJpCnA2JbFrGuc2I5+Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a601028-c1fc-44ed-4f70-08dba4be6226
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:23:00.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yp5JS/E/iYbcF/2QVJCU4NjpAXjJzSFWSIW9+GQKTPiVM+0FZlDfjTHLPflASjP7NfVeu4B/7LtVieW68yw4fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/21/23 11:14, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When CXL regions are created through autodiscovery their resource
> may be a child of a soft reserved resource. Currently, when such a
> region is destroyed, its soft reserved resource remains in place.
> That means that the HPA range that the region could release is
> actually unavailable for reuse.
> 
> Free the soft reserved resource on region teardown by examining
> the alignment of the resources, and handling accordingly. The
> two resources will be exactly aligned, partially aligned, or not
> aligned at all.
> 
> |----------- "Soft Reserved" -----------|
> |-------------- "Region #" -------------|
> Exactly aligned. Any dangling children move up to a parent on removal.
> The removal of this soft reserved seems guaranteed, however the
> availability of the address range for reuse depends on complete cleanup
> of the region child resources also.
> 
> |----------- "Soft Reserved" -----------|
> |-------- "Region #" -------|
> or
> |----------- "Soft Reserved" -----------|
>              |-------- "Region #" -------|
> Either start or end aligns. Unlike removing a resource, which simply
> moves child resources up the resource tree, adjustments fail if any
> child resources map the range being truncated. So this one will fail
> for dangling child resources of the region.
> 
> |---------- "Soft Reserved" ----------|
>          |---- "Region #" ----|
> No alignment. Freeing the resource of a region in the middle succeeds
> if no child resources map the leading or trailing address space.
> 
> Reported-by: Derick Marks <derick.w.marks@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/region.c | 130 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 121 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c487aab15ad..dcf8d4ad2cf4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -569,22 +569,134 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>   	return 0;
>   }
>   
> +static int add_soft_reserved(struct resource *parent, resource_size_t start,
> +			     resource_size_t len, unsigned long flags)
> +{
> +	struct resource *res __free(kfree) = kmalloc(sizeof(*res), GFP_KERNEL);
> +	int rc;
> +
> +	if (!res)
> +		return -ENOMEM;
> +
> +	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
> +
> +	res->desc = IORES_DESC_SOFT_RESERVED;
> +	res->flags = res->flags | flags;
> +	rc = insert_resource(parent, res);
> +	if (rc)
> +		return rc;
> +
> +	no_free_ptr(res);
> +	return 0;
> +}
> +
> +static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
> +				 resource_size_t start, resource_size_t end)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	resource_size_t new_start, new_end;
> +	struct resource *parent;
> +	unsigned long flags;
> +	int rc;
> +
> +	/* Prevent new usage while removing or adjusting the resource */
> +	guard(mutex)(&cxlrd->range_lock);
> +
> +	/* Aligns at both resource start and end */
> +	if (soft->start == start && soft->end == end) {
> +		rc = remove_resource(soft);
> +		if (rc)
> +			dev_dbg(&cxlr->dev,
> +				"cannot remove soft reserved resource %pr\n",
> +				soft);
> +		else
> +			kfree(soft);
> +
> +		return;
> +	}
> +
> +	/* Aligns at either resource start or end */
> +	if (soft->start == start || soft->end == end) {
> +		if (soft->start == start) {
> +			new_start = end + 1;
> +			new_end = soft->end;
> +		} else {
> +			new_start = soft->start;
> +			new_end = start + 1;
> +		}
> +		rc =  adjust_resource(soft, new_start, new_end - new_start + 1);
> +		if (rc)
> +			dev_dbg(&cxlr->dev,
> +				"cannot adjust soft reserved resource %pr\n",
> +				soft);
> +		return;
> +	}
> +
> +	/*
> +	 * No alignment. Attempt a 3-way split that removes the part of
> +	 * the resource the region occupied, and then creates new soft
> +	 * reserved resources for the leading and trailing addr space.
> +	 * adjust_resource() will stop the attempt if there are any
> +	 * child resources.
> +	 */
> +
> +	/* Save the original soft reserved resource params before adjusting */
> +	new_start = soft->start;
> +	new_end = soft->end;
> +	parent = soft->parent;
> +	flags = soft->flags;
> +
> +	rc = adjust_resource(soft, start, end - start);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev,
> +			"cannot adjust soft reserved resource %pr\n", soft);
> +		return;
> +	}
> +	rc = remove_resource(soft);
> +	if (rc)
> +		dev_warn(&cxlr->dev,
> +			 "cannot remove soft reserved resource %pr\n", soft);
> +
> +	rc = add_soft_reserved(parent, new_start, start - new_start, flags);
> +	if (rc)
> +		dev_warn(&cxlr->dev,
> +			 "cannot add new soft reserved resource at %pa\n",
> +			 &new_start);
> +
> +	rc = add_soft_reserved(parent, end + 1, new_end - end, flags);
> +	if (rc)
> +		dev_warn(&cxlr->dev,
> +			 "cannot add new soft reserved resource at %pa + 1\n",
> +			 &end);
> +}
> +
>   static void cxl_region_iomem_release(struct cxl_region *cxlr)
>   {
>   	struct cxl_region_params *p = &cxlr->params;
> +	struct resource *parent, *res = p->res;
> +	resource_size_t start, end;
>   
>   	if (device_is_registered(&cxlr->dev))
>   		lockdep_assert_held_write(&cxl_region_rwsem);
> -	if (p->res) {
> -		/*
> -		 * Autodiscovered regions may not have been able to insert their
> -		 * resource.
> -		 */
> -		if (p->res->parent)
> -			remove_resource(p->res);
> -		kfree(p->res);
> -		p->res = NULL;
> +	if (!res)
> +		return;
> +	/*
> +	 * Autodiscovered regions may not have been able to insert their
> +	 * resource. If a Soft Reserved parent resource exists, try to
> +	 * remove that also.
> +	 */
> +	if (p->res->parent) {
> +		parent = p->res->parent;
> +		start = p->res->start;
> +		end = p->res->end;
> +		remove_resource(p->res);
> +		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags) &&
> +		    parent->desc == IORES_DESC_SOFT_RESERVED)
> +			remove_soft_reserved(cxlr, parent, start, end);
>   	}
> +
> +	kfree(p->res);
> +	p->res = NULL;
>   }
>   
>   static int free_hpa(struct cxl_region *cxlr)
