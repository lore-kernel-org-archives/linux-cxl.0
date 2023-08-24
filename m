Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D14C6FA8F
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Aug 2023 15:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbjHXP5Y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 24 Aug 2023 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbjHXP5L (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 24 Aug 2023 11:57:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B6198E
        for <linux-cxl@vger.kernel.org>; Thu, 24 Aug 2023 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692892629; x=1724428629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5yZ/k2m//CIAlGbitMJ94BqjWcL1P5zDlMXJ2kZuwhg=;
  b=BtYiWv2HGcrShBfasdCg248cWpdvq7ud2HpgvGKucDRkHTe3il3iHqnl
   T+vUYC9IlDqeos5ybsiQaBD0st3cNWsFi3aRF5yVDzzf8G1+itveTy/K1
   EjngShnWgjEGZHW/9bJNwLBMU6WWKfWl6YH7JoA1pFblH3iUiUkEgQjHZ
   85DYfMV+csA/aXU0M9W1sMc4L6gHd5oGw0YaXdXU1jSg93a8rfFofpzcR
   MkVTu5x6yfo92pHw8n4F47tAiH8sSY1gNgv5+cdULrFLSv+SBKV5jxgUS
   IS0hXsR809tP1pKQnsQ7PtcJQut7RtjFDQLBZ2KlN97mvnv/uzJrXVMNV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="373353415"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373353415"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 08:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880845473"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 08:57:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 08:57:08 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 08:57:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 08:57:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 08:57:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/PT2bx0LC4mDTnnUrwhNDdkByDmcajHuEMYRCJFgJ7Er0c1YQbHofaLqbcb/pigqGvg9j1GmZXex4lo4U/wT1KCVv5nSCWBDpcBgUoSoJp16RTu9WgMlgHPMvS5/Vf94vTAcmhEytqkeLLxHOQnMC3cjqvSK1UBJueIX7iRnhsuCsLmp89uiKsDnVDcyyytWZcuv19v2dgs9XX/0Dxh1nvy4Me6m/AF/Ws6/5T9ySUbnu6yWUEzmn4BFAOrHh6Xy/fjwntyjNpOnOvmnLXu5wdk3ttlEP7aFdSs8MS9Oina+49ZpsnmOQPkT7yvF3w0ADQVsKNxYRPwS9GeciHfbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw9u4xHMzO867WKpFWzSfKGzmWUGd33l+U77mj9APkY=;
 b=JN+dn2bXtUjJBPNz5/0XAWSUnaf/XCzMzwvO1goX8Hke0NNEUPrUlr/5Tj1gQ7sP9y1efinqefoaLUzJCgFNfAwlJY8bnY/kBzfdtLToexvcNtrhccn6B1M7I1SiCaPLnJjG3oTh3k2xsVOA2M6/tuE/Iay2ecyXr3nciLOtvTvjMXF2uTDy7ElrIQZjpZ42NpKcSTlOl8N+vh1RrOgcrDGkgjiVLK6ttu9MVF1Vr3cgb6bbh3xjp7ox+yKlNGHIF//+bR8EH+riyV0c3xq76s94OfWcLzAA8BHytCzbvsikagy4r1f9T6uF9PY0AidX7g+1sjxztF2vmMhpdfFPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 PH7PR11MB6606.namprd11.prod.outlook.com (2603:10b6:510:1b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:57:04 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::c542:a94c:fc8a:52fc]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::c542:a94c:fc8a:52fc%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 15:57:04 +0000
Message-ID: <6c1f054c-3104-6fa3-661a-60d3bd85e535@intel.com>
Date:   Thu, 24 Aug 2023 08:57:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v3 1/2] cxl/region: Try to add a region resource to a soft
 reserved parent
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
References: <cover.1692638817.git.alison.schofield@intel.com>
 <4cf018843ee9846c5b9907b8fc7140ab66b929b6.1692638817.git.alison.schofield@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <4cf018843ee9846c5b9907b8fc7140ab66b929b6.1692638817.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|PH7PR11MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: a85ee2ac-8df1-40e3-a75c-08dba4bac2da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brGNB5JCvtcQ1/QJDhYZULK8+bgDVk8OFJSQySV5ermNe/lO+UFLyX8yXjkq6ZaVerXAg4iyu+MX+URK0y6bf5Fk7oMLTG5tq17rfr8fJg1ToBboIPLhG76VCoTQHqnXuJNDp3UmIXwi4ZPOPEyAmEHqPBkKI7/X/Y7zk9ysGxgQXYrZ24qPUVGJLB5XLs/AcxfZEMuV6NjzIDrH8/Z7vIV2v0NTlQ4avLjUP4d8LRhqRdOd3lecq6/Wv/X6wPZFtT70MtMFzD7OhFSIB3CXpeK7a+NQrCUqVeQYP6lq3b8Z1uiVLo3MQFXRh4xFjS3sEji/qr6NNP9hED8XNwQmuvj0LaDjvX/dVgp7/w2BAKGYWfQIfaXuuIztXGxvoZZjEzLZfGQfcJlzd/Hw0sgiOMFrCmPRBIwtuBsCHpgqRo5bDSMzo2AoeDzFvRYUGlDX+RYjpzUmAy3MMka+sMHBQi0iRp7JVnH0Aifrh4dYC0h2KoeELAVfnCaMMacJvbgr5EO7HrjruxnpKN47FNGWPDiE30gr/s44MTuYivX2RX5nSiiEkmX/ZmEsH5nGTwG6wV+xSH12HLwvmPk8NPG5r7u/OwX1eJNLs+AtqSU2w+CfZJJkiPxSBvl863lNGKtZPwL/8XFjHZbmw3tLsEueYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5990.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(1800799009)(451199024)(186009)(31686004)(31696002)(86362001)(38100700002)(82960400001)(36756003)(6506007)(6666004)(478600001)(6486002)(5660300002)(316002)(6636002)(2906002)(110136005)(8676002)(4326008)(44832011)(8936002)(26005)(6512007)(53546011)(83380400001)(66946007)(66556008)(66476007)(41300700001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU41aHlVNFJJeE91YmRENEtUK3BiWGJNZEpmV09FK05LYXZLYjB3a25panBi?=
 =?utf-8?B?Z2twcmtHbFBiWUVtUFltZHU3ajZIQnpMMFloWEJPNXU2dnJqcjFPbnl1NWEv?=
 =?utf-8?B?OCtZOExldnpNbHVXcHV0ZlJjVUVBTVZ4YVJSU3pjdmYvNzdlQjVPMjZUM3Bs?=
 =?utf-8?B?a0dMTU0rbHppRTZURWJRcGtoWkM0elVvU1NsczJuNEdoUVNUbm1QeDJ6Nmpm?=
 =?utf-8?B?akZJQ0VDTTFoTnZqT3RmUkNYSzh3eWJ3ZzlnRjRvUG9VbktPZFlJaUdHNlBa?=
 =?utf-8?B?MFZFM0d4RldCeXhZc2o2K1hmV2xzZ1NKT2hyYVBBeGlDOTBaL0NwdWpTMXVl?=
 =?utf-8?B?c3BnQ3BWczByQUg3TTE5V2V2YXkvR2U0U3pkS1l4UFM4UFZONzBXWFhTTjZy?=
 =?utf-8?B?anlrUTE3Z3pJS0xUZDdZNUp2S3RqUFEwOTVYbWt4WERHMHllNndVUXQrRXMz?=
 =?utf-8?B?U2N2cGlSTmUvN3Z2MWJWNUlScDM3QlRibkdRSnNCejFYRUNTa1M4ZDJxVHlM?=
 =?utf-8?B?S1plb3FlUEk0Ym9mUjJMcVk5YnU0cFpqN2NmamhlYTFiUmVwWWFoRzFhTzdu?=
 =?utf-8?B?Z0N5cmNUSHdGR0Y0SmVpbjBtdUs3NW4rYTdwbEhFREFkVWkwNFE4dmx0V1lJ?=
 =?utf-8?B?T2RpVGlXMm52bzhNMWxJR2pLVnFBMjduYlFKQUowWVNDN0pML1ZVWHQxcDJH?=
 =?utf-8?B?M1BCYisxcGVQN0xGU2hkR3R6c25ZdHZmMXZMdkRMcWRGRFpNZittb1piMDV2?=
 =?utf-8?B?V1ByaW5jRFpUSlhmSllFSEt0aFFIbjZGaytHZGx2cVR4Y3E1SHRBV0R0STRM?=
 =?utf-8?B?T2xOcjk1VFhDaXQreGIrMHZ1WWRlRFQ2RjJDaUJGRmNodDFpN2dUY2lMalpv?=
 =?utf-8?B?NmpXYW5vNGFDRnlKb3dRT2VwVmFkRkZzWWRDT2I5QnZpdlFheWM5dmJSVzhC?=
 =?utf-8?B?a042RnhRZ2E1YzRLOXFvOS9lMi9aSTlXWkVuaGZyRWl0Y0RXZkRFK0wvNDdJ?=
 =?utf-8?B?K0c4VEpNS01XakRKN0JreHBDdjM5bTZDbDhvVFFzaWNpeWtVVFR0OTcyKy82?=
 =?utf-8?B?L1BJMldqd0tmRTIvYjNBb0VRNlpzUVV4RnBJdVRuUjhtK0g3elIwVVhXNDBs?=
 =?utf-8?B?MmRrRi9Ma0hGM0t4NmhTTnVVdjB3VXRweXMxSEwvTHZJN2xhcnYwWnF6YW1Z?=
 =?utf-8?B?Q0dIRW5uK0dteWdVdUJnRHFjOGkzK1VMcS85MndRQWw0aE1CUEFWcmFCdG9S?=
 =?utf-8?B?UEJFODhqSkE4TGdGbHdUN1NoSkxCeWZBT05maXNIRzhGU0FlMmVBSStBc3ZO?=
 =?utf-8?B?YkxBbGRZZUNwcUtxTkFiOEd4eGREdGVtYUtLdjQ1UXFRQzY4L1l3UnJpOHRE?=
 =?utf-8?B?dGtYUTZvMHNuelN3bnlYNDdpaGs3RXlLOTVIcHBpVEhJeWFVVGtxekRWdHAv?=
 =?utf-8?B?Z3kzdmFSTytwS1ZseXVyUFk2Yy9obmtPaExaTmRzekRLZ1ZwRnV4SnZ2M21n?=
 =?utf-8?B?emtwRml1Z0hvMzFmZHh1Y1ZLaVNtQk5UL0piY1ZmSWJnYzVId2R3bWV4RXpy?=
 =?utf-8?B?WHh1VVcxZmh0bHVmc3ZpVEhTaDN2U3JtV0JkbTVMM3h2cmdqYXQ3ZTJLcGlN?=
 =?utf-8?B?Yk90MWtPbElTUGtVeEJGNDZxVm5PZVY4bXY3MC9UUjQ1UGVLdnh4ZHFXMlcw?=
 =?utf-8?B?Y3FHeG9kS0NiTUJOWkx3Y1BGYnZCM1dvS2cwbTFoZnoxdmE3VWJtdWN3R2Fy?=
 =?utf-8?B?Nld1VEZRVTErWHFzNElxNnNPaUdmSi9HaXBLOE1TMnNEeTQ4bHRoZm1KSC9m?=
 =?utf-8?B?SGxCVXFKeHQ5QU9QSEZwRzlUdXh2eTUzcHZmcUJtUkFnZnhncGc1L1VHT2hO?=
 =?utf-8?B?cmdLcTFjYzhaUmNKb09LN0R0bE00Um1VWjcxWlh6dUpDN3k2YmpBTjFmTVlI?=
 =?utf-8?B?emtZOUw4MzlYalFuOHNOUnZHaFVrUEt6KzkwN3dtUE9rN0JXdm9nbXNxQ2t6?=
 =?utf-8?B?QjZDcm9zTnFGZzBRdzU0OWwydjNGZytQWXNYNUQ2OW1rM3BwdnFYMnVIODNI?=
 =?utf-8?B?bWJ1YlFQSVkzdjZiNzJ3czE5M2lGMXl0Z2RqVmJTUzJZTHRXR1JXeDBDTDl3?=
 =?utf-8?Q?BfPst5ltWqHNTVDoJpSwN0z8l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a85ee2ac-8df1-40e3-a75c-08dba4bac2da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:57:04.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwJui7r5iUImoJTwRDX20GjeNyLNnwBRBAvJHrv8LNWJJeUhSjJqj6o/7ZpItQjEjjGmu1dVcwcMb3R8Zgasyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6606
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/21/23 11:14, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> During region autodiscovery, the region driver always inserts the
> region resource as a child of the root decoder, a CXL WINDOW. It
> has the effect of making a soft reserved resource, with an exactly
> matching address range, a child of the region resource.
> 
> It looks like this in /proc/iomem:
> 
> 2080000000-29dbfffffff : CXL Window 0
>    2080000000-247fffffff : region0
>      2080000000-247fffffff : Soft Reserved
> 
> Search for soft reserved resources that include the region resource
> and add the new region resource as a child of that found resource.
> If a soft reserved resource is not found, insert to the root decoder
> as usual.
> 
> With this change, it looks like this:
> 
> 2080000000-29dbfffffff : CXL Window 0
>    2080000000-247fffffff : Soft Reserved
>      2080000000-247fffffff : region0
> 
> This odd parenting only occurs when the resources are an exact match.
> When the region resource only uses part of a soft reserved resource,
> the parenting appears more logical like this:
> 
> 2080000000-29dbfffffff : CXL Window 0
>    2080000000-287fffffff : Soft Reserved
>      2080000000-247fffffff : region0
> 
> Aside from the more logical appearance, this change is in preparation
> for further cleanup in region teardown. A follow-on patch intends to
> find and free soft reserved resources upon region teardown.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/region.c | 57 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..5c487aab15ad 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2709,6 +2709,31 @@ static int match_region_by_range(struct device *dev, void *data)
>   	return rc;
>   }
>   
> +static int insert_resource_soft_reserved(struct resource *soft_res, void *arg)
> +{
> +	struct resource *parent, *new, *res = arg;
> +	bool found = false;
> +	int rc = 0;
> +
> +	parent = soft_res->parent;
> +	if (!parent)
> +		return 0;
> +
> +	/* Caller provides a copy of soft_res. Find the actual resource. */
> +	for (new = parent->child; new; new = new->sibling) {
> +		if (resource_contains(new, soft_res)) {
> +			rc = insert_resource(new, res);
> +			found = true;
> +			break;
> +		}
> +	}
> +	/* Caller handles failure to find or insert resource */
> +	if (!found || rc)
> +		return rc;
> +
> +	return 1;
> +}
> +
>   /* Establish an empty region covering the given HPA range */
>   static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   					   struct cxl_endpoint_decoder *cxled)
> @@ -2755,16 +2780,28 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   
>   	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>   				    dev_name(&cxlr->dev));
> -	rc = insert_resource(cxlrd->res, res);
> -	if (rc) {
> -		/*
> -		 * Platform-firmware may not have split resources like "System
> -		 * RAM" on CXL window boundaries see cxl_region_iomem_release()
> -		 */
> -		dev_warn(cxlmd->dev.parent,
> -			 "%s:%s: %s %s cannot insert resource\n",
> -			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			 __func__, dev_name(&cxlr->dev));
> +
> +	/* Try inserting to a Soft Reserved parent. Fallback to root decoder */
> +	rc = walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, 0, res->start,
> +				 res->end, res, insert_resource_soft_reserved);
> +	if (!rc || rc == -EBUSY)
> +		dev_dbg(&cxlmd->dev,
> +			"insert %pr to soft reserved parent failed rc:%d\n",
> +			res, rc);
> +	if (rc != 1) {
> +		rc = insert_resource(cxlrd->res, res);
> +		if (rc) {
> +			/*
> +			 * Platform-firmware may not have split resources
> +			 * like "System RAM" on CXL window boundaries see
> +			 * cxl_region_iomem_release()
> +			 */
> +			dev_warn(cxlmd->dev.parent,
> +				 "%s:%s: %s %s cannot insert resource\n",
> +				 dev_name(&cxlmd->dev),
> +				 dev_name(&cxled->cxld.dev), __func__,
> +				 dev_name(&cxlr->dev));
> +		}
>   	}
>   
>   	p->res = res;
