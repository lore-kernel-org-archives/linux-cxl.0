Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92017EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 21:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFOVeS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFOVeQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 17:34:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98232962
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864853; x=1718400853;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=axJZOlxMAQTwmCM5YUj0YDnqmRASt+H7oqzzCYoALMc=;
  b=Q+NfiA+ZKgZljxAGSmChg/cNPrhqEJFDFbh3jrKSepAy7Z/qx514PVvk
   BcDFwob0qJkNn+05qTyZyx9FtIKqh0FjtNWUb4BXb9S5am50Jsx5y3h5D
   N0YMc+WNmytGNFoYdK1u7oQNycbOwACgQiHvn+PfS6sTseBavPvWvxm6S
   wuuu6/H514kxji3ZVaBLTJw4X8vxwmdp+XXsmJF34yKmhR6JYWE0uodPc
   t1vARGg3ILtmhXM7BQ4CBcEAPqoTd4r0xupQT9bjpofpOiW8IGmfGmyyb
   yD+vBE5p9f2ArIN9witfU8/n4wHvNm4Fe6N51+Nl4wmIakOjyEbEmguSi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424977919"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424977919"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825463494"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825463494"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 14:34:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:34:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:34:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 14:34:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 14:34:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8b+4nBUkbMUnajvsGwqV5xd1gOLFwz6HSNtC5GnngJiuE0sOYWRmPYINT+7T+z0oF523Nva07Hb1e6nZPJoPrCRFUY82lQjG4CRDH3cDq58XT/Mg+fx8nI9CFzlZz7ky87e2gDBO+De/ILr7Oo1LxfJjCWzWamjO82tNFZ8TIwhHJ4cjOD8JSXCSSx+qdjSpyuzzausoVEfXgSHf+Hy3IftRTJtdz9hVY1ZE7P4fsL7eGYkc9um8d9MNpJKd3sLWBGDg82aTWjxCiRVyAiwfR2yv0u8cPqvnoF8K/ZvJSi5n7XE1qeioLnAwX53lvXU8z2u6s8WTbZ6wmTNb7fwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r8VaCWyknT7toB5xbhGdy7HTYFXWycFSanzGikWitI=;
 b=MafE/qlGAHv4LuUCOfqZNMs9LHYp1to1SjpK9IiOX8+k3KNisJhJJjUxFugnx6W432qlAIMdknB8qlilq18/rNcfrq8PqP44iWCUKsCn02uYAi3f2KMNPt+C2c0WWnbu1e18K/pxxSRpoyiX0x7UZiGmM5Zxm1cps8ftd2WLZNFFxc6ZivKYWuQIIzH/na68akGN5HQdLwWq0hiGptX+ewofh71mTmh/r5km7vI4SkqK/qUTPsnA8kqiGd++Lgm8pneR9g7L3lhBgxzYNcXDvu4YZSrrKVQty92YDFV6kcN90q7ZaX+8MfHTI+P+E28umSRzvxK1zFOurryq+Xxi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM6PR11MB4708.namprd11.prod.outlook.com (2603:10b6:5:28f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 21:34:03 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 21:34:03 +0000
Message-ID: <8daadc47-115f-79a9-a18a-a72e6f06b7ed@intel.com>
Date:   Thu, 15 Jun 2023 14:34:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v2 10/12] cxl/pci: Unconditionally unmask 256B Flit errors
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
 <168679263124.3436160.6228910132469454346.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168679263124.3436160.6228910132469454346.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0065.namprd08.prod.outlook.com
 (2603:10b6:a03:117::42) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM6PR11MB4708:EE_
X-MS-Office365-Filtering-Correlation-Id: 245e9c63-973c-4b36-9f9e-08db6de83cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gi1dHXwWS7hwqJNGktfYIIxAjjywfJvjtW/OnLkvS+5bVVQopQ1y3XdMUh4AWm6jorkPlRyNArnBTIQL5X/ZtxRAKQ1bUY7mwzxdMNqa3i3lb6dWfGyw62+dAZtogvoNf++277WN6IVAs9V1OZr6gGpFrHXTIQhhHuFdkIjBInEQrxbdCjuJlc4zoBKHJdL3MBIgMRFT5/KBf2LulYNKQ4adEDA24Z4did7rvNIatQe1ODt6WVKm47LgN0Wl5EISSNyj7HQ2xeZbVZ9C0t9R63t0j/7wg/PYotnuRYiJRBdGwrFVbLKm6h43sa2516Yow82ESnizg+AKv9JC1BGqiXENkFmdn0e4xc0FuRgjsCIIcRS+VWhBN+GeoVyAlYR/V8T8P/lQRqvXoQ/2A0VmAgRU5eygxzkV+FbfZO9x2h8oBgWLBI9+YUmxZnRE0i7MusBto4G2sYHTA7tU2B4jyNgvU/GuGg8y1uNyB/Il4WClwc7OoaluIdPMpB8jfmPAFXA968X8nrLqu22SdJc1AThuxlYGwhaRg4rznmwrB5KAAaHAxLkZBTsd7mMgGokynV38K77tYhJ5gznDlH8a2oZSL+19vFOgWg9SsoPBCEf5pbgtNrl+bolF8XM51SKGl0E8RqNFZ0EzODF+tX5TDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(41300700001)(31696002)(6486002)(8676002)(86362001)(8936002)(6512007)(26005)(53546011)(6506007)(44832011)(5660300002)(31686004)(66946007)(38100700002)(2906002)(66476007)(66556008)(478600001)(82960400001)(2616005)(36756003)(83380400001)(316002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkUzUktOc1pETnZoS3FTZ0hrTytaU2pTVnBZWDNqS2U3bzV2UktsNFp2Mmto?=
 =?utf-8?B?UXpFQkNTaFBkMXJaTnN1bzB1eERNa2xtbVhjcndsdldSNms4UlZSUHAvYjlL?=
 =?utf-8?B?K3dDNnlXcUNwNW5LVkN2Q0dGcUVYNnc0elhuQ0daM3o0ZlJIMTd0aUNVTDBX?=
 =?utf-8?B?ZU1ZdnVuejYrT2pEemZ3cGJBcEh5MlpJTjFMWVZZaTZEcUNrOHh3OVdBc1Ju?=
 =?utf-8?B?bmZjQjJ1MnZ0TE5BNUpvaHpuQS8vb0tSTloyL1hlTmZFM0tDYUtxNGxkV0dE?=
 =?utf-8?B?MC9wU3BtL3VPZjZmRUI0eEUyTWhnc0c5WjI0UENjM2VyK00ydnkzbzdZVGFu?=
 =?utf-8?B?ampQSHRocVRSVGVmSTFyTjBzMjkvM1FnR1VIL091bGJHQkE5R05Wb3IzRHpX?=
 =?utf-8?B?NVZ0MVJsZXpPTXZKK000NHlVeTAvQkwyN0h0ZWRqT0dMR2QvM1BwS1BQdE9o?=
 =?utf-8?B?RE03a0ZJUVluVkRhMjlDVHBTNjVzTmVCbDhEdmxNTTdsK3ZlaGJuQUdlTFBw?=
 =?utf-8?B?WEZuWS9ER0NiMy9XVENsY2tDNXRPY2c0MW82cDN3QU5ITjRnTjRCaFV1anhT?=
 =?utf-8?B?RTV1aFZCUk5YV1RtTCs4SUZNd2dTTkxyQzlNRnRyZ2duOVJLZW9FbktsNFov?=
 =?utf-8?B?UDJWT3FkRi92N0lEWmdzT2YxSHpqc3hLZ2VpMVRkQkFJU3VPWHdqYVUyN3FV?=
 =?utf-8?B?UXRvZVNTbHNkNU45c2pRR0hkOVdYYUFqUjBRSFlmVVB5WjMyTEVjTktoL1N1?=
 =?utf-8?B?N3RTdFV0V3Q1SGlRdW5zV3U5Z2JZK2NWSHA3ZVBRWFlSR040dGpraUVjRGJh?=
 =?utf-8?B?MDJldU1xaVIvNEdWclNlR0ZnZ3loeGNmNDRwbHJ2SXpSOU1aS3BtamdDREhw?=
 =?utf-8?B?UWdUZ1hIUkY0dzZ2eTk5RFNZRkxKZkhJZWVHbzZGVjBJRjBBVGZ1akMrb1E1?=
 =?utf-8?B?by8xNVJUUGJmUklwaTFzdDRQUm1LRVJlbno2STQ1SFlUWmxiaGlCUDc1V3hm?=
 =?utf-8?B?Qjc5SnpuWlZtUkRxdUFjSXRFKzdnMTdGYmkrUDRqNjdhRFczOHl1ZzNIeHFV?=
 =?utf-8?B?cmJGUjc0djFnbnVTY1JCeWZkSlVzcC9ENStIZENPa0hwdlk2VkZHZUdGRjc2?=
 =?utf-8?B?TFgydVlaSFBxS1VlaUd6TzZIZUt0aWNrbHJzekpIcEx6Yzk0Sy91L1Y3THlW?=
 =?utf-8?B?NkdwdUg2YnJvaDNqRm1IOXNkV3JzOGdEWWp1K09VNzFGT2IxWjYzcVRiaG1O?=
 =?utf-8?B?TGl6ZUZib0FIck02eTdsMzNBZjJlNDRqc1FtdzQzck9oT0RnR2pmUktqRGNu?=
 =?utf-8?B?UzlXYklZRVNEWWhiam9iSHB4UWJ3NlltMkNhS3YxTTJuWVMranFSTjgzZkM1?=
 =?utf-8?B?RVZmRDhNT0hNdUo4K0c1NzVGc2F4YW5jZE1Pd1IrWDlVM0toTEQ3TTJjblJQ?=
 =?utf-8?B?MzdWK0F2WWFxM1VuRUR0cUpydDJZRmNLak1kQjgxS2RRc3VSSjhZTGV5SFdo?=
 =?utf-8?B?bVBvcDEwVy83UG5yWkFPT21QSnY2bHIyRDVBRG1FZ0hZNmFkSWkyTXpMUFpB?=
 =?utf-8?B?S2RaU01sMjNhMXl0VUcydWs5amliUm12MUpIejgxTEc5aXVnK01CQUtlb1pY?=
 =?utf-8?B?VnJqbW8zZERKUnhlYkpLSy9KYVdTSzJzS2JxYWlvV1pEUERLYUpSOXlSYUUy?=
 =?utf-8?B?THMrSm5pSnh4SkkvUmNrOGtJRmU3VXg1bHhPaXZXZ2t2ZnBabFFNcmFFVXRM?=
 =?utf-8?B?VmE5Q3A0bUZobWRyL0dDWk9NckNremhKa3V0K01SZHRZcyt6V3FENnRHcVBS?=
 =?utf-8?B?RmJmclEwRFlDUXVWM2ZwbVJKS1NiZTVRcCs1dDducVlmUVE4NmUrdXdZK3B3?=
 =?utf-8?B?SHZNdUd5dExUNkxLb2hjczgzOHBNeGlTWW9Kb2NDdHRuMXlNaHM1dVIvSXVr?=
 =?utf-8?B?cjlJV1I1UjFGSGZJU25nWVpsbFRRWXpDYlljakg4NnIvRVI3WUVneEk1ZnBr?=
 =?utf-8?B?bVlXNjdVRVRqY1ZQeFc4R0hFT28zNkN2UUMzcVorRGRVTnVSdVFpM1UwbFUr?=
 =?utf-8?B?NUE3NlIzcm9xY1pEcTQ0cEs1RDNzTmY3UlBkdUdHcjZXcXpWWWtnWTB2dmw5?=
 =?utf-8?B?K0JvRlBlTmk5R2FnenozMWxUOXh5Z1JkdkwrZjZRV0FmYWsxQ0JISi9IOGlT?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 245e9c63-973c-4b36-9f9e-08db6de83cd3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 21:34:02.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KAEF/giFrbjlWIZlHDkvLgJzXoSUUxEgH5LfaEdwI5f2aFYJGSFNQbxdMjJ5uSEWWtgkUbfcfGKvfNGimOQGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 18:30, Dan Williams wrote:
> The current check for 256B Flit mode is incomplete and unnecessary. It
> is incomplete because it fails to consider the link speed, or check for
> CXL link capabilities. It is unnecessary because unconditionally
> unmasking 256B Flit errors is a nop when 256B Flit operation is not
> available.
> 
> Remove this check in preparation for creating a cxl_probe_link() helper
> to centralize this detection.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/pci.c |   18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4e2845b7331a..3f78082014cc 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -368,19 +368,6 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
>   	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>   }
>   
> -/*
> - * CXL v3.0 6.2.3 Table 6-4
> - * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> - * mode, otherwise it's 68B flits mode.
> - */
> -static bool cxl_pci_flit_256(struct pci_dev *pdev)
> -{
> -	u16 lnksta2;
> -
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> -	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> -}
> -
>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>   {
>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -407,9 +394,8 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>   		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
>   		orig_val = readl(addr);
>   
> -		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
> -		if (!cxl_pci_flit_256(pdev))
> -			mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
> +		       CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
>   		val = orig_val & ~mask;
>   		writel(val, addr);
>   		dev_dbg(&pdev->dev,
> 
