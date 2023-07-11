Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC09EB64DC
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 18:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGKSLP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGKSLN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 14:11:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6710C4
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689099071; x=1720635071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DipHrff8lMh9yM9VcbGM2FMYz1L9+38oYivC/Za/ujM=;
  b=LXefjW/sqD4yehrLwwDG1Znw/xix8i2m0LdRmjlH8rJtADHJ/9kllkKd
   4MZddbS7Dwb62b+DxMRIk/TYFoHL1yLg81Sb71APkIQRwmu7hAM+m4OAY
   cvhUelPLAEslCdLD6pBrEtRV57kfneoaCpFRPqx1vYM+v8XDmM1GUV6vD
   DgWKurCWsthICsTGz2z72Qh9pxE/fm50+W3N87wCLO6en31SA0dIBZu2e
   NUUa9QJKBgwuxjNZZBURV0UUQFsupnJvQbk12+Yj3fIph/Iiss2nTmWOl
   0Ulx8NvxzvWf/5qPNbm279wlOdwP44+CM0GMmPFoeI+lQY+/99SGotFCq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363560816"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="363560816"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 11:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786696859"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="786696859"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2023 11:11:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 11:11:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 11:11:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 11:11:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 11:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOmPR8cVQThyiXSa8+eQ0jM2i2oFow+fmnoK9C2LYEkcC61HbgvqE+tzyYF+SOf73F1TlSdwVMDAX40tV7mzKh5FeKeUf9sxFeO8boW7yZD6sRgF5dcNl1T+K7vy4XcE176EyCDZ1MR/L66cW1BY2su7mDBnCRQgU6QOnFvk2X/bvMPo1KGBBGI2ZLpxBOtJ9FdIyspgHwl7uvhP1sFgP6Ud7fs4Z3v0Fnl9L77Fkbp6iYThIUKVmbegu1J4eHOC0/cFhgkXm0pSQRPqJDeS3yEePuXwm3mNPmwq0PIvnGOy5bUV3xMSQ2TvawPKkvIrbl8+wBdRxQwMOy4o1JGRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3C9Zt65Ge04qTjq/Wx3VZbrZoeMzguEUS5f0yDKgM0=;
 b=EQSgeY6ixXtr+Nh3JtlXgmB0kQKkszvs9nhduSCGe4lBcDztYC0VmFFBThU517j92Xhd2uN7NRmORqV2pVrOeDAlrdKuhkoqXmCIHyqGgM4cJJy9MV8d3EO4zN7dlgVO3zFzkMAmMcXLU0qypea++hNnLQ004mwSLkb8uGX/X5DmtEEFr5HncsxWu1Miweet8jIPnVEVj23nrkAG43lU9EICMRlniAmtV3mw4BSeRvl+mbT1wZ3WW2FvfEwVepFiddV5GFo1cr28m8J0JwAWaZ8GPi4JgyMSCSYhdZ2e/eHsoeObF6wq9ZTM7D35cc5rM43X17qXw3vvDb4sfKmgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA0PR11MB7815.namprd11.prod.outlook.com (2603:10b6:208:404::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 18:11:08 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 18:11:08 +0000
Message-ID: <57e7dd38-cd63-ce9d-aa72-bf87054bb239@intel.com>
Date:   Tue, 11 Jul 2023 11:11:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH v2] cxl/acpi: Release device after dev_err()
To:     Breno Leitao <leitao@debian.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ave.jiang@intel.com>
References: <20230711161704.3033220-1-leitao@debian.org>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230711161704.3033220-1-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA0PR11MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 46faf912-0e62-4577-20bd-08db823a32dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDrQU5PhyIfmSswCIal8lYa0vYypY8BD/Kmzr3D+XOtHcZ25vZc/mEH0pqXJEzRZfWxeAmzCMDgFmmKE2qzt6lKjlaCJB3DIuWqo+vRg15BNRTNMAtSIEAoU5XqZ9U3wDCKMvvobHlSA//xwwmDxE16Xcq0/ctKboCD1ecmRuQfbNcPq0WdLEffB6mZfsgDQZAPLUlpiOK1/YzppT28W/XB4zndWBa/+A7oHroN+bUIwa161ll9mcaS4sOmxTEl1SrWGlb2ZLB+w5ZdVpeje87NW770+HRcl4n5n1CrQhfxPW5Lude6a2iYwzg8gEXkeRSOApcZ4WZBNnO3HXEzZm2Me1M8VrSL/qAuX9OrIC4FTLttKL9TGnKkXH3EG5EmWokLaIS1hyQzkFJ2L4voqoeRcvml7GOn80WGe28qYHIOHWfPHOmh3PFMaUboWd38jLcD6xt10NfHXBx4ZvbIw9akdeFAKkL6m1oV/vGUVFb4BI0bX+nrrFFoH1G5IdTLU6XAWuKqkVlnpfAQogU7qbiTQDkGBtHZaHiH/5TZlCo25+DM1C76SFqfzBKRgoZLePfebrNgFhvviUcSgBl6QUouOtC8zs3KewJMA5BtMMYdojErmFpK3xNIDqyG8pQ8MQCR8+2wXoaRx/LbgiIM2jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(82960400001)(6486002)(186003)(86362001)(6666004)(2616005)(31696002)(478600001)(53546011)(6506007)(26005)(44832011)(316002)(36756003)(107886003)(8936002)(8676002)(41300700001)(31686004)(5660300002)(83380400001)(6512007)(66476007)(66556008)(66946007)(6636002)(2906002)(4326008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dER1WVdVcHJPUVNBckJIeTNlbjB0bVppeXBQYldSU2ZPUmVNK0VrVHJrY0Vx?=
 =?utf-8?B?cjk1dGwxTldVSGVUNnF2MU84TGlHOXVaQUE1WFNyeGFjaWtJdlJ6ejFFTStU?=
 =?utf-8?B?V3A4OW9scXF3S0ZaeTBtNW82RmhVZFUxTDhuRkNFSHRwRjhKZEFDZU1EWnhq?=
 =?utf-8?B?VlU3N2tGTjE1SUZHSzZJWGV6T0Ftek5MYTlQQzhmM3YvQ3B3aHl1NlFtcHVp?=
 =?utf-8?B?ajhOT25oVTBBcDVYa3hmOTZOT0k4c3VTZWZuVys2NUtBOTFtT21QckpGOE9E?=
 =?utf-8?B?cCs5dm5RSDMySWh5djBnRTJ2WTRuamtxU0xyM0VXbXJkZlBlZlRjdTBBNWxS?=
 =?utf-8?B?aTFZQ0FmTFRReDFmbDFiR0J5OUxnYkNZVVBOYjRlRzRlTVdLRWI5YSticTFG?=
 =?utf-8?B?eUxXSUNwRFNVN1VHSHNVbTM1enhkZjNVb1VkRlQwODR2RWJEdm0yMXp2dnNk?=
 =?utf-8?B?dlA1T1VWNUp3V2dWMG9yYzVKMlZWSlV6WVU3aHNlSHlZWkNuVVdqdmZHOVA1?=
 =?utf-8?B?bGJneERkMzZYbm5jcWdaWUNiaXR1RzVMdTgzMXlycENWeGw1Yko4STIvRkNp?=
 =?utf-8?B?aUw5cWFlNGxxTFlrQXJzQklPVmtzNjF1S3NCWi9MYmtDVDR6QXBBSStVdXhm?=
 =?utf-8?B?SXJxbWpUMGd0M1cxT09YQ3NOVDMwTDhoUG9RQTlvckhYSGlaZHMzamNHVlIx?=
 =?utf-8?B?TmtURGxGbXMzWTh0OHRRcU4wTFZFQmkrTFViUkdrQVJsV2s1YWZmcWsrSXZ0?=
 =?utf-8?B?WlpVaTJJOTEzc3lqUVAzcU0vandXQmJRZXZrODhsd2k4WjRkVmVNMGUxQ214?=
 =?utf-8?B?OURNMDRIV3VhK245b2g3UitqdlZ2b20yTlhYcTRJam1SVVNndjZRRkVyek1m?=
 =?utf-8?B?S1EzVk82Z243dmtEcDdWTnNaUGdqVG44WXRmaDRjM3M2cEpMZ0lmZ3JMYjJh?=
 =?utf-8?B?QTIySmgrdXhtS3RKeER3VkFZWGRiZlUvdXJsVjF4MkZSa2E1RWdsWis1ck42?=
 =?utf-8?B?aWUxYmFOemFpeE9GLy9uNk8ydEZtSmltM0UyS3RKQzNDbFNMUVFyMzEyN1JR?=
 =?utf-8?B?RS9ZQ0lNeFNjWENVell0Y0gyNXdkTmd1WUdRcDhjOTRPNTNXU0VBZ1VQUTlE?=
 =?utf-8?B?S3M1Uy9PS205djNlQThkLzd0bmk3NXppYVE2eEc5VGllSTBycGwrT1hHRWR0?=
 =?utf-8?B?elZkQ1dEUlBOQkdadzg5MS8zN0NYekFaNUVKRTJqK2w4Z0FxQmZ3U1ZNcTds?=
 =?utf-8?B?VitOZno3bWdzbmJ5cU1ndHVLTHZBZXlvWW5NalFuWjdRUUwzRnBtd0JNMDc3?=
 =?utf-8?B?ZG4yMy9idHlvVUNLc3VzNDlkL0xzN1ltQ3M5Rys3NFl0QmFLTlpvM0hYVnl5?=
 =?utf-8?B?VTBMOVo1VzdSbk42N0dIR1AzN1NET1IvamEyb0tTYVF1RXZlcmtZbHl2eXAr?=
 =?utf-8?B?SEJoK0ZFWmQ2bDJXMnE0OHBLYkFwaXV6eWRGL0xpejBBT2Y4a09uRE9HRi9o?=
 =?utf-8?B?NDNHQWRuU2lkVTJsbW43UXlUUnk1NFdLZVNJalZjSnBadEtGRlBFNCtseFJr?=
 =?utf-8?B?RDNFVVRvNlNjNWswYkdBVVZRa0dzUE82T09wd3NrVTc1RGhIVjFTSTRwTjhk?=
 =?utf-8?B?UTVITmJMQjArRGtxNnVuVkViUlFrYTVkam5IK255MzgyRkZYQVpzVlhJckdL?=
 =?utf-8?B?OHdNcXJua01xSWtmbHdaOTd1WW9BWXQxNmE0OHJ5WlV3d1BxRCswWDNLUzln?=
 =?utf-8?B?QzIwTk9mN1dsUjBiTjlJcmk4OC9YVXVWaXQzeU9XTTRnK3dqdEpscG0rRkNZ?=
 =?utf-8?B?bW1EZjZubVBxdjZLTlhQZWVZekIvdWo2aVlJNHJHci9yb0dFeEg2YUx6dThO?=
 =?utf-8?B?TSt5ODg0MUJXcFRIRnVyNTladVVrc25BYlNET09waGY4d2IybjJwa3B3clNB?=
 =?utf-8?B?NjZqVEpSYlUxR1c5OWUyMTVJRmZNWUlEa1cyYUw0WGphcGZxNEZvTHp3UUpJ?=
 =?utf-8?B?U0p6OXpzaVpLRHJQenYwcldhdGxXZjh1b3d3ellmSENHcDRBSTFaNllsMDRT?=
 =?utf-8?B?YU9qZG1jb013c042ZVY0NDh0VlZMbmVha3FGNmZXaU41cFBZK1VIZWpLRnFG?=
 =?utf-8?Q?ldnDzvI17Wnb4WQ8GtFjo8Q8X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46faf912-0e62-4577-20bd-08db823a32dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:11:07.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPe5JSYXbU9hcHLtqv9CZ8hYJX4NGI9nc421h6N2+MkblY+itczVEuaxDllNGoPgkO06pbF6S3+cVInHQQDn0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7815
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/11/23 09:17, Breno Leitao wrote:
> Kfence detected an user-after-free in the CXL driver. This happens in
> the cxl_decoder_add() fail path. Kfence drops this message:
> 
>    BUG: KFENCE: use-after-free read in resource_string
> 
> This is happening in cxl_parse_cfmws(), where put_device() is called,
> releasing cxld->dev, and then, later, dev_err(cxld->dev) is called
> referencing the released device.
> 
> Just release the device after the message is printed/dev_err().  On top
> of that, cxl_parse_cfmws() must fail (returns rc) in case of
> cxl_decoder_add() or cxl_decoder_autoremove() failing (rc != 0), instead
> of swallowing the error and returning 0.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v1 -> v2
>   * Return the error (rc) instead of swalling it
> 
> ---
>   drivers/cxl/acpi.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 658e6b84a769..efead5cc8a89 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -291,14 +291,16 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>   	}
>   	rc = cxl_decoder_add(cxld, target_map);
>   err_xormap:
> -	if (rc)
> -		put_device(&cxld->dev);
> -	else
> -		rc = cxl_decoder_autoremove(dev, cxld);
>   	if (rc) {
>   		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>   			cxld->hpa_range.start, cxld->hpa_range.end);
> -		return 0;
> +		put_device(&cxld->dev);
> +		return rc;
> +	}
> +	rc = cxl_decoder_autoremove(dev, cxld);
> +	if (rc) {
> +		dev_err(dev, "Failed to register autoremove action\n");
> +		return rc;
>   	}
>   	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>   		dev_name(&cxld->dev),
