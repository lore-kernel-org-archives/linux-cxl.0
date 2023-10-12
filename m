Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836BEA6
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mu4sLQs9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0063C0
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 16:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697154563; x=1728690563;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UTI10PEOiyn/UaHUYX1BPuCCxHvuu3AGCdU+/q/eUoo=;
  b=Mu4sLQs9P//s/auyv2hHJ/oNi7alnImMiGx63Olcvxynv4ODTpufUZSs
   LBxKsjqGl0t2khFjvkXo/7oFjCCccgu+3n5iS5+5fw1QW8naBv6lKHOxm
   0J/BkrSg5S+nD9JSYOFV5d11zqvFmRDNwATrNWlgtUu3t4pHKW6SVGWkh
   1nHOWUmYnuKVlLGxJRDppI7HRWuT5yjxHsVyrW0AxKrYC+NSF+ye5PPvu
   AMP3W4W6s3JyFNQ6t1b1GOBoXbD70ZxaxG0ufNhrNBoA/hTIq4i+qptYs
   wwsiogwrMbQ29zY6yASa23JPR+rAi8FmcmWd6P1bVW1FonaXvKPoDrsyC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="6624921"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="6624921"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 16:49:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704389004"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="704389004"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 16:49:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 16:49:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 16:49:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 16:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/sjf1qLa5DGne9IL9LqW7PvUPD5HIk/P0omX3z3lFliO2jnDmX2HZ6slQ130K2W/ge7yGdHTWzgcjidz681781Oo17NcD/kDDMP/Yt6f3AymjjXC1CKzr7QgceneYyj5dXoUkU1xsXYbfYwkTR1wLRCsobogNbi8quo5vkao1OOG1dOa6kBiWY2vMe38/IxtDUji1SmTPKdgi+X8yCYKOFSOExg9BChfSFqw80L+qpopHmcfiU5XfUFln8R3OMdSVo8NbC2XKYTtKtjR7eHkdaSfFkqoyQvyBlV14WF2Pov8EmQ3mreg7EcmW99AuhqLN9Bl0JOLWCuFHrepl1siA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/CdcdpA+rPHI38nS6w0sH2zm38mHHZ7XHVjgW0T/1E=;
 b=gsAlvehrtp9/zM2ocjwceZcbv4uhUtivY00b9yNP5kIdp88inlQF6xMzvkhFwEKSgxBnHmjoq0CnAL6KzvakMtSEeZTZ2fuyOJ2NoU+f0k6qBrafpDtL6guZPElLHQJLOxzD8JmsQY8CmwXo8RD3sMW0bIkN7xXmgYlmdAuX/CWRj5tuvSY972YkMS7fgrCk+c06S+g7X67876DotVtl6HX0FMKqkxkuBcpZnJerADaa6TLyOOLIcRUVgb1uqChuy04BtBlEBHmXtcDchocSn302tzy+Uge5bQzj+Mx34Xlsc3C6ggD2fNLFPtLeo0aurhTyhGT0kNvKgR1s4N+Lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB8293.namprd11.prod.outlook.com (2603:10b6:a03:44f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 23:49:19 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Thu, 12 Oct 2023
 23:49:19 +0000
Message-ID: <ea3c2989-2fb9-4b0d-b696-a7fe737b5bed@intel.com>
Date: Thu, 12 Oct 2023 16:49:15 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/3] cxl/region: Calculate a target position in a region
 interleave
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>
References: <cover.1696550786.git.alison.schofield@intel.com>
 <5a7133e0ab7eb11f96daa73d88ec765f3536634a.1696550786.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <5a7133e0ab7eb11f96daa73d88ec765f3536634a.1696550786.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba6271e-7192-4c28-5bea-08dbcb7dda08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBxTdx+VpRYcgA/Xyx1D8B2BIqRok3iugd71ayw8CyePl0qzC//KEOeDgJn74o3hraxz4HAPWLda50nN92Pxat8PTdxi/atQigA7xu3+RHeEpLb4xea2Yabx6p1DhnZ2I4T/WjOEIk2je5WerFjSISVbYBxVv+ki70OyTqIkGxJMBpvcBVhGq02Ves8ie0rfkJjVa717Np6tH/5xRnejcnPFXzq9DzN9O8pcGJmPfC+L+a0ww9jTDlMDvz91jvKkKnhdkSwQ7Ru2lJKumMzSRxBkqv3m6LZkrXpXxAsoy1iABTylYk4MjwlryNwvvXlcUKr9NxUMcQd7iNekyS830YN6C+qRvKwVPVyxgHT9sV1tsDMbdrYghAi7h0L5EDcqEIUWlBJcvibkD7JwGd5B7PQUY3RvVRviBcV/6ZKof0q/Or/wFT5rkIaFlhcRfRLxlR11q/KLK15cP/CtNpO9YsbnHEX5FpZguqq11AtGtkap0aZ/VRZJdahATUkRLL0/9I335PvJmeZRxx3Y9YLRofpW2mZ/qrk43H95zb4nZTXY/q0cGOWT1QjTE0MSlvvS/NTF1TW4L+DpbrPJtxkTXPoQGqn1GzAbEDTeWLdwJcZ9I7T3Z1sOpcGNV2Kyv8r0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(107886003)(2616005)(53546011)(6506007)(6666004)(41300700001)(2906002)(66476007)(66946007)(66556008)(4326008)(44832011)(31686004)(26005)(5660300002)(478600001)(6512007)(6486002)(83380400001)(66899024)(316002)(6636002)(36756003)(38100700002)(8676002)(110136005)(82960400001)(8936002)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjdocmlXUlljcmk4SFM1VVVRc0FxUGdpN0NCM05yUW5LMStOQW9zRDcybmxr?=
 =?utf-8?B?blRtcnVVdjE1UnRCSE9yQkRVR3NCU3JuZjhYUGRWWmFTMzFQUHV4VXMyYlF1?=
 =?utf-8?B?Y0JXeFNHZ0JGSzF4RXFkVHlESzF4cGl2RW5McXNXVEFJNnI0YXNpYlFtVjJx?=
 =?utf-8?B?NnNvcXYxNmtaZU1IekUxZ0xaT1pSWmtEQ2M1VWVRVkJlMGp3clM1dHFFWGJW?=
 =?utf-8?B?MWloWGREaU40UkRJYkptbHpZQ0xHRUIrVjRCaWpSSkhSNldCOW5Qc3U4UGxE?=
 =?utf-8?B?Q3RrTnRQazliVllhbE1mT3FibUtYYUIwUXRDdXFMc1hxMkl4SU9URzJZVDhZ?=
 =?utf-8?B?bHRTMDZRN2ZKN0ZlcjRzSUlNTWQ3b25ieTkrV3g2ZmZmNmRBaWkrMmNrWExB?=
 =?utf-8?B?ejVpTVI3bkNEeTJUQ2RFV0xPQXRXNitUZVZMcTZyNXN6MnF2TjFwenNERXQw?=
 =?utf-8?B?c0FVckI0TEVzUW9TMDFYUisvMmFPU0twWVpNV01jSW5mR3J0REovSFo4VWQw?=
 =?utf-8?B?T3gxMzRlVC9wTTlrclFLbGhacjJJQ2FscnhDRysveEVVNy9rTUFyRENVZ3VZ?=
 =?utf-8?B?TGNuaUdKZjFCNWlZY3hqN0JFeC9BeTB1MjFaTWR6T1BidmxrRHY0NHJLaUh4?=
 =?utf-8?B?amtmVEIrU3JSSFhMTEsvOTBWTThGTXpZUmRzSm1yMDFQQWVzRVRaQi9lY3BW?=
 =?utf-8?B?TU1wSE9Wa2pNK2NwQ3NsNVNEMFVlRGY4aG13MDhVNUNNOVNaTHlacjgrdEI1?=
 =?utf-8?B?T2JiQ20xczMrNjFMTHZVeENSbkN0WFY0NzF4T3pUcnR4emxKTXc4QjVtYVNi?=
 =?utf-8?B?dzZ5RHp5UHRXZW5SeHpqd2JjZ3RkK1h3eXduWEVqVUdydVpvVkJUN2RSekFQ?=
 =?utf-8?B?bGU2OURJTkJDWS9DQXBQdnFyNCtoWTl6Y0wrTE9ZWS9qNW9jQWc5V2k1Tlh2?=
 =?utf-8?B?Mmg4ZDFobzdqZDBuNVFabkIvTFh6aStJL0xSMXZMYUpBVkhTV055TDhRYUUx?=
 =?utf-8?B?VGJYV3p6RUVHbVhGV3dFaW5hRWFyMThuYzhHWDdmSXYrODZ0dDlodExhWE12?=
 =?utf-8?B?QzFoVzJsZlVkRUx6YnBVRGg2Yy9TdXNiWEdRWlVtYWZ5OWYxTEJwUVE1TUlP?=
 =?utf-8?B?Sng0QUFxZUxqMWRrNkFDQVRnNEtvV2xJTCtvUDVSOTgwbTI1SThaMno1ZHJR?=
 =?utf-8?B?RHl3VXllTjVjbEpaVExBRnFxWElrUGh3THQvMEVoUGYwRGtGSi84Y0tHTTc2?=
 =?utf-8?B?WVRwUTFCNG9lS3ZKZ3pKTFREY0p5SEROdzAwRVZUN3doQlFQMlhVakQzZm52?=
 =?utf-8?B?VXE1cDY1clExeVd1SFFvNEF2Z0pzbUYya0VBK0FMZ3BJZGNHRlA3ZEY0TDdL?=
 =?utf-8?B?NmlsdnhhZkc5R0R6ZGFLV0ZQZVRaRjdxY2NnQkVJQW84Zm9hNUNUaWZPQkpu?=
 =?utf-8?B?RjZaSDBjNm9UZFJKOEdlc0J3eTdiTHA4djg2TXhocEJiSUV1SVN5ZHY2YWZr?=
 =?utf-8?B?TytRRWlKMDdua3NmTmtFVEYxMUN4RG0xSjdRWkJqcnFLNUpUaVQxbkVtQ0cx?=
 =?utf-8?B?VmFkMGZ6cUJ5WDJqdWdqQVhFcXJpK2U4ZkozR0RDMUUwMGpBdERVaUEyb0hv?=
 =?utf-8?B?eEN0ekdxLy9UMmVWTmEzNUlWTWQzZEhiQWNpYVlIbDJkZWJobVJIUm1hcFVO?=
 =?utf-8?B?Q3FjYzRHaUNrNEU1b0FMSlBLZWFmTHpXbENLZDl3VU03RWNrczQ3aTdNRjVB?=
 =?utf-8?B?RU1LVEVlSTRvK1pvL2ZEWGExSTdybW1IZy9OL3FmSTlPZ3E1V21ySG1Lais0?=
 =?utf-8?B?RzBWN2RUK1E2SFBwNTRuTy9lOWdHMHVxaUUrblNxN3BtYk1nT012cGxvQU5C?=
 =?utf-8?B?aC9DUzkwNFVkVUY3Q1o2WlNSd2dWanhhRks4TkNmdEZHdG95QkhxMGVaNm5V?=
 =?utf-8?B?akZzejJ4TEwyMk5Ic0t0UW9kQ0VoTjBYcE5rWG1xV0FBNGVzUmNrQURmMHI5?=
 =?utf-8?B?SVl5NktnRWx6NFhOd0RlSHhLZzByZUZNRGdsMHN6bVFNUWhNVkpHMlgveU5z?=
 =?utf-8?B?TGJsZ0xITkFJQms3eFhQRElQa0hSVStmSEdqQ2pKbWN2S1l5VzJHeEs5MUl4?=
 =?utf-8?Q?9DlMx1U83jV6QsIbcRbSYpMmu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba6271e-7192-4c28-5bea-08dbcb7dda08
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:49:19.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtJjkMO5ZunXjuFKQzX0nnwx54K/HUSr1GBeMYzvkgzwTeq7HuYPSkaFjOgAtlq1Uqu0bsfm5m4AjktqMX+TOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8293
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/5/23 17:43, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Introduce a calculation that determines a targets position in a region
> interleave. Perform a selftest of the calculation on user-defined
> regions.
> 
> The region driver users the kernel sort() function to put region

s/users/uses/

> targets in relative order. Positions are assigned based on each
> targets index in that sorted list. That relative sort doesn't

s/targets/target/

> consider the offset of a port into its parent port causing some

s/causing/which causes/

> autodiscovered regions to fail creation. In one failure case,

s/autodiscovered/auto-discovered/

> a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
> put all targets of one port ahead of another port, when they were

s/put/puts/
s/targets/the targets/
comma not needed

> expected to be interleaved.
> 
> In preparation for repairing the autodiscovery region assembly,

s/autodiscovery/auto-discovery/

> introduce a new method for discovering a target position in the
> region interleave.
> 
> cxl_interleave_pos() offers a method to determine a targets position
> by ascending from an endpoint to a root decoder. The calculation starts
> with the endpoints local position and its position in its parents port.
> Traversing towards the root decoder and examining position and ways,
> allows the position to be refined all the way to the root decoder.

Please consider:
It transverses towards the root decoder and examines both position and ways in order to allow the position to be refined all the way to the root decoder.

> 
> This calculation, applied iteratively, yields the correct position:
> 
> position = position * parent_ways + parent_pos;
> 
> ...when you follow these rules:
> 
> Rule #1 - When (parent_ways == region_ways), abort.
> 	  position = parent_position;
> 	  This rule is applied in calc_interleave_pos()
> 
> Rule #2 - Use an index into the target list when finding pos.
> 	  This rule is applied in the helper find_pos_and_ways().
> 
> Include a selftest that exercises this new position calculation against
> every successfully configured user-defined region.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 100 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 64206fc4d99b..297b9132d5b3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1500,6 +1500,91 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>  	return range_contains(r1, r2);
>  }
>  
> +/* Find the position of a port in it's parent and the parents ways */
> +static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> +			     int *pos, int *ways)
> +{
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_port *parent;
> +	int child_ways = *ways;
> +	int child_pos = *pos;
> +	struct device *dev;
> +	int index = 0;
> +	int rc = -1;
> +
> +	parent = next_port(port);
> +	if (!parent)
> +		return rc;
> +
> +	dev = device_find_child(&parent->dev, range,
> +				match_switch_decoder_by_range);
> +	if (!dev) {
> +		dev_err(port->uport_dev,
> +			"failed to find decoder mapping %#llx-%#llx\n",
> +			range->start, range->end);
> +		return rc;
> +	}
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	*ways = cxlsd->cxld.interleave_ways;
> +
> +	/* Use the child ways/pos as index to target list */
> +	if (cxlsd->nr_targets > child_ways)
> +		index = child_pos * child_ways;
> +
> +	for (int i = index; i < *ways; i++) {
> +		if (cxlsd->target[i] == port->parent_dport) {
> +			*pos = i;
> +			rc = 0;
> +			break;
> +		}
> +	}
> +	put_device(dev);
> +
> +	return rc;
> +}
> +
> +static int calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> +			       int region_ways)
> +{
> +	struct cxl_port *iter, *port = cxled_to_port(cxled);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *range = &cxled->cxld.hpa_range;
> +	int parent_ways = 0;
> +	int parent_pos = 0;
> +	int rc, pos;
> +
> +	/* Initialize pos to its local position */
> +	rc = find_pos_and_ways(port, range, &parent_pos, &parent_ways);
> +	if (rc)
> +		return -ENXIO;
> +
> +	pos = parent_pos;
> +
> +	if (parent_ways == region_ways)
> +		goto out;
> +
> +	/* Iterate up the ancestral tree refining the position */
> +	for (iter = next_port(port); iter; iter = next_port(iter)) {
> +		if (is_cxl_root(iter))
> +			break;
> +
> +		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> +		if (rc)
> +			return -ENXIO;
> +
> +		if (parent_ways == region_ways) {
> +			pos = parent_pos;
> +			break;
> +		}
> +		pos = pos * parent_ways + parent_pos;
> +	}
> +out:
> +	dev_dbg(&cxlmd->dev,
> +		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
> +		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
> +		dev_name(&port->dev), range->start, range->end, pos);
> +
> +	return pos;
>  }
>  
>  static void find_positions(const struct cxl_switch_decoder *cxlsd,
> @@ -1765,6 +1850,21 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		.end = p->res->end,
>  	};
>  
> +	if (p->nr_targets != p->interleave_ways)
> +		return 0;
> +
> +	/* Exercise position calculator on user-defined regions */
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		int test_pos;
> +
> +		test_pos = calc_interleave_pos(cxled, p->interleave_ways);
> +		dev_dbg(&cxled->cxld.dev,
> +			"Interleave calc match %s test_pos:%d cxled->pos:%d\n",
> +			(test_pos == cxled->pos) ? "Success" : "Fail",
> +			test_pos, cxled->pos);

Mismatch from selftest does not cause error?

> +	}
> +
>  	return 0;
>  
>  err_decrement:
