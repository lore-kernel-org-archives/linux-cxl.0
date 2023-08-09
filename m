Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AF8C0015E
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Aug 2023 22:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjHIW2p (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Aug 2023 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjHIW2o (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Aug 2023 18:28:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ED4DA
        for <linux-cxl@vger.kernel.org>; Wed,  9 Aug 2023 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620123; x=1723156123;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pdu/vTiCakbTe5EGSXXMyrTki2jiW2qZwZFKctLdhkk=;
  b=hkFeCqAeVMnx3bqhkD2fzxzYSDmw/bYpqTfx0EtWM/zl4szbQId+7EaO
   5I0GfqqLkVAEipUc8O/4xiz11VSn8mcKjjX6XpuUdDOFEQgaA3wHa6UoC
   kZt+wCOW0HMSvM3oPy8M31YZLIHZje7bNB2rmI38HGnyYQsPaVGgjJFhD
   e64XHoPMt40414l0NX9goZiWbBhzDzEwx87gOWPzwKOcG4NHUdXaCivVn
   hO5+ivOvOBvsCzLu6CcBu7DkArT+PNS1Ru24mboFGRvujorR4ilasYOMt
   XUDtyv3yfxqF7RWOzNcajzBwzyvE2mpcHhqIn3jrsjQUmF9EuB+m6FKbX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374028507"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374028507"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="978563919"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="978563919"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 09 Aug 2023 15:28:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:28:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:28:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsWuFzdHwq6J4Wv/nLjbXaax/ALxMRKRPCggsryUuKSVLlFv5cKMaq+Hkz/xY5Ik/C+N5oZCz6vfXBD1qNPG7TvOWd6sbyWsBVrqBhCNRpZ0t3ITNxW1kwUcq+VzAx7bK1gkzMfYaw/IeAOBCqCcJEuFCdh9aurNaNFLPbexkDE1gHXi2prhsSA73EHTyAJIHhl4v2tDBMTrZNIGMviP0259MBLQbMOD09SrsIOdGYFZ4mV57U+CpwQwNRXok6ETeNdWyK4KOiR2AEh+7r3I9CHthcEBPMDn62R6r2uCx152cv12argsM7QsdklOUX8CHr4HEZOq9C8ZL6TWtr7Rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLOeKGieW7epuXxfrHUbj2wVuKX/FZ6IvzMyEhOtw8E=;
 b=Bu12TNE8Jg9ckqKLM+jq4L+1S9vM+Yt0e/EsJ9VNF2ypTnT+OvYi6hsSxyftiU+cFaDcPMbef+bfNRaUpg+tYAxbd3JRMnD0m4Db2fazGqIhCIuHMi4Br8GQX5Gk0DkoI6H9gd4g60Dq7CF0oVo1MFo/lAAOxIXmpRuuRnThncyIkIWz7oo4ysoIAbiuk9m1/jAExeE7oYomphjCrQ7n6ex26VQe3fTXPttLgq3zTPUxiybI62O3NssYxQQXF1bLGQZ5u3uVjK3e75WKWt0uNoetr9ajrN5kP5fUjeI1m0z4yWC8wCfvhQxZNnqVfJsJo76r+UpLwFNA3vN6yQCGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 22:28:40 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 22:28:40 +0000
Message-ID: <6a944c93-6ad6-c934-afa5-276277d4757d@intel.com>
Date:   Wed, 9 Aug 2023 15:28:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl/region: Refactor granularity select in
 cxl_port_setup_targets()
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
References: <20230804232726.1672782-1-alison.schofield@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230804232726.1672782-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d13da8-26e1-4945-f4db-08db9927fb2a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6PG6455S3SI65CBFJ8Ne71BPzdIbbxZJElrGVhDgB11MsRdxFNiaxjVIMQDrfj68KvLOLC70+xjHQ1SFxGd6JD8xjI+Rv40njOXTH+Je4KD1Ifny3Y2Ol+cJijoOVrljTvjhdqyV0aMJ6iEp4I6Og26xtdrUll0+Wiv2GfmlUb5XDxKQM/Zd2lHpBFJciUcpo6JkKe7y+QIhdEEghraiq3cEZH/p/w3blcRiwZJplYh1L/V1p1Vjp9hPwIlY/GHUW8VOb9L84BJ6tRbAo8jgpxp7z6XCKf12meGuMgX1YtyBPLleblXVQx6QTmq8Ps/HhIHYjHyC73UeiEvb1EL3fNVTLdIpYCXFI5ovJOKwb0cNQ87vyLWvXWECLe7M+ZZP/jC64d6MFdPqn5r9VpzqVKECMtg722DN/8gqoHorNA3iLz9pZN7HrwUrt1cUiR/EGA0oz5sX9jhqiGvlNXQf/eA2vDbFMkbS4uNpotn3DtzHSkWHSp080DoCkfIXald7w/gWyWuM7G5q7nBcTmrbi3EEMtSBFSyvEDtc3baasbmspfjB9IlrMlVylrUeH1R0QAE/LLuqN6wb2sGT5sKT4hIjThGEZexI4xA80rkav78afUSH3coRSEv4GDTy52tNyEgatoo/IOSFvfg1q0VZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(186006)(1800799006)(38100700002)(6506007)(53546011)(26005)(82960400001)(2616005)(83380400001)(36756003)(2906002)(5660300002)(44832011)(478600001)(31696002)(6486002)(6666004)(41300700001)(110136005)(6512007)(4326008)(316002)(8936002)(66946007)(6636002)(86362001)(66476007)(8676002)(66556008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFNeE5kZW9VWTBGQ2l0aTlrcitWNURoYnBJeE5INVhuZU5pcXlVNjY0bTdq?=
 =?utf-8?B?b1A4WEE5OHhxUzBQK3dOd0FuR3RmdGExUkE4TUROY2JqYnNValpzVmdKRnZa?=
 =?utf-8?B?UFNYY01vN1JVUUxMaWE3U09oQmpBL0pOZUhUMDJWV0tXRkl5T1UyN0k1ZVlP?=
 =?utf-8?B?bE5aTS8rcTNQREpIQmQ1UVNydDB4ZlhqTTVZODhjaGg0ZkFKUlJhQWMrdlpj?=
 =?utf-8?B?OGJsZ2EwcTRJV2lUWnVqY24yRVBUOEp6VlJOL1BaY2V0ZklKeGd6bHJGKzFQ?=
 =?utf-8?B?bGQxVmJCQWdiaXM5d3dCa2VPWkVLSVljaVJQWHhtNW4wMlBqQ3ZVRTVRbFht?=
 =?utf-8?B?ckxHZVdEWVpyWXZQNWhNa1JmZUhsU1JHcWNQL1NNVVVEMXRVTmRVVXhDZTda?=
 =?utf-8?B?eDlrRnVhdmYrL1htUmtGdDRBeTZVWnh6N2pQZnViYlhuWEhQQ2tLK1Aza1Q4?=
 =?utf-8?B?anR3d3JUeFliMElxcEdtbk1LdEdPZEdxZlkwRW1vWC9HT21VU3F2ODJRcGNZ?=
 =?utf-8?B?NkZvKzhiNU9sUTZpRjg4ckVSZW1qKzZaVm9ScGN3V0dNRHRFckRUWmNyakg3?=
 =?utf-8?B?TTZ0cW5yRzRXbFFKSFB1SmpHbjNhQ1c1MXFFclJjblhyS0E4QWlMSjlDMHRB?=
 =?utf-8?B?Vnd3NC8remt5dHVqV3hxOURCWWR3L0lnc0VmUHRSUWMzOCtzeEJhQmhEeGgw?=
 =?utf-8?B?K2RMaGlGTWRnbXNab1lSc055WU5mWFcrTWhVWGVJVFF3djJiZGZMeUpkb21t?=
 =?utf-8?B?enBOWXJDQ1RlNnNwS3JkTFRrQlc3WTdoWjhMTHU5UEhKelIzaXJHVHhRaytN?=
 =?utf-8?B?eXdWR2xtb1VwMXVGQkZaV1VoVERtQk93c2FzUS9MZGk2NU1QYTlFS0FEQng5?=
 =?utf-8?B?MjU0VDZFbUVELzhFc3E4dVYwaEdVcFJPckRTeGExT0FNUkpaTU5kNW1oemd6?=
 =?utf-8?B?YXI5RVBEd3EvT0FSRlY3M2FSbGZ1SEc4b2xVMEY3SVAwM1FjWE05SnpoT0Vh?=
 =?utf-8?B?OUtaZC92cjdtN0IrWVp3OFVEOGdKR2VBMFdWUjlCVkNUV2xrYXgwaUdXMnZF?=
 =?utf-8?B?UU93c0FTV29hY3h3RENacEZLTlMrb0FCNTdmdWU2eUVGTFJuYmJaV2lyL1lU?=
 =?utf-8?B?MGhucjhNZGI3aFdCaEdSUEc0VjRCUENjb00yVzd2aUdnMUhvdU1KQnVieDBz?=
 =?utf-8?B?ZVRzWU04UUlJYlZvLzdRUUY1MCtxbWNwV1VkRTE4YnljNWhZQ25ydDNHNTJV?=
 =?utf-8?B?MVI4b0IwT0JXS0x3MWtMSHRKNFE0MStBaFdSOG9xVVRjSFYzaXlJVDZabTdR?=
 =?utf-8?B?OEJheHZNQ2FsbmhHWGZxWkRLSlRyNFRTWjZ5MCt1SnpoSEFkQTFRT1pVS3h6?=
 =?utf-8?B?ZGJVRk9ZZjhocXE1MXgvMWhsZ3pyUEhrMFozaXh2OVZNUWlaaVZjUitmUUdx?=
 =?utf-8?B?eXJVZUFTbVBCLzR3YU1rNE9tTU1vQ1JNbVJNSW1TYVBCNmsvcDZYa0pXRVBu?=
 =?utf-8?B?alBsQUFoK2Rab3NFVElTQTFEakhTTzZIb1lZdmhUWUFSeldNRExYaWdLZ0pw?=
 =?utf-8?B?NzZBVEwxQnkvdzloZG1jVU1RMTRERkdtdm1XMEJsOUhvSjRJckIvYTJWTDJN?=
 =?utf-8?B?Nml4b1JQQ0dWRHZTdy9LbFlVekw1WEgwcGs3cGN4My9rb3VINXd3THYzeFNJ?=
 =?utf-8?B?KzgzZ3pzZGxZT21OTGo2cCtkamxMVTZFbG9yMXFMenNieW9sN25EcW5LYUpn?=
 =?utf-8?B?TFdYa1FySExxQ0g4MmFMUVFPL1FIbWsrR0E4TTJ3ZHNJNVdUWW43VTVObFlt?=
 =?utf-8?B?b2Q2WHI4Q3IydzJ5emo0QmRISlFhOGxxQ1UxWFpsN2UwNlQzSEthM1g3T2Nx?=
 =?utf-8?B?SGhSdnBmTlZVSzMxeWtEU1R1dkIyTVZHSnIyeHc5c25ZQ1FPdkVpL0F6eVk3?=
 =?utf-8?B?Uk5mUlp5d0lPQ0VRZGZieUZ0emJ2endaa0hFektGV2hITk1oZ0F4eUNyQXdT?=
 =?utf-8?B?am9rU3FUSXdjTjl1N0UwTzFDMnd4ZStRZ2ZYSDN3NW9Yek1hVnFRUDVzcldl?=
 =?utf-8?B?RFNmdTBBVzl0NlcxUkZZelhrTXduT0psUnh0NnFFTzlpZS9ORGtuK1lMOG5u?=
 =?utf-8?Q?Q9hqICFCXqmRHEKgZ7tq36Q6A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d13da8-26e1-4945-f4db-08db9927fb2a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:28:40.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il6C8j1AN/2R5f/WPQhNHyuCCPMQ1g23Mzg7hFI1x/bw5bOtctUDVRxOZVyWbpTE5Nyjs5JIkW8dLq3/K7Dzsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/4/23 16:27, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> In cxl_port_setup_targets() the region driver validates the
> configuration of auto-discovered region decoders, as well
> as decoders the driver is preparing to program.
> 
> The existing calculations use the encrypted interleave granularity

s/encrypted/encoded/

> value, the eig, to create an interleave granularity that properly
> fans out when routing an x1 interleave to a greater than x1 interleave.
> 
> That all worked well, until this config came along:
> Host Bridge: 2 way at 256 granularity
>      Switch Decoder_A:	1 way at 512
>          Endpoint_X:	2 way at 512
>      Switch Decoder_B:	1 way at 512
>          Endpoint_Y:	2 way at 512
> 
> When the Host Bridge interleave is greater that 1, and the root
> decoder interleave is exactly 1, the region driver needs to
> consider the number of targets in the region when calculating
> the expected granularity.
> 
> While examining the existing logic, and trying to cover the case
> above, a couple of simplifications appeared, hence this proposed
> refactoring.
> 
> The first simplicfication is to apply the logic to the unencrypted
s/simplicfication/simplification/
s/unencrypted/normal?/


> values and use the existing helper function granularity_to_eig() to
> translate the desired granularity to the encrypted form. This means

s/encrypted/encoded/

> the comment and code regarding setting address bits is discarded.
> Although that logic was not wrong, it adds a level of complexity that
> is not required in the granularity selection. The eig and eiw are
> indeed part of the routing instructions programmed into the decoders.
> Up-level the discussion to plain ways and granularity for clearer
> analysis.
> 
> The second simplification reduces the logic to a single granularity
> calculation that works for all cases. The new calculation doesn't
> care if parent_iw => 1,  because parent_iw is used as a multiplier.
> 
> The refactor cleans up a useless assignment of eiw, made after the iw
> is already calculated.
> 
> Regression testing included an examination of all of the ways and
> granularity selections made during a run of the cxl_test unit tests.
> There were no differences in selections before and after this patch.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
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
