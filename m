Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75F3CE79A7
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 23:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIYXod (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 19:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYXod (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 19:44:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12026FB
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695685466; x=1727221466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S8WtzKfoo+7HretGo+k5Gkj6tYvr+DTk4BK3SGf316Y=;
  b=WO3Di/+DbW7b8qprSU0nANfcFFhpRFSlOOw6YEcgmJ8DhHweO5wL0e+S
   jd2d3jHr49sXOIxX9G9n5ZdedT/rq5Xf4nRDLdQ8M7oL2XIAlW0ZuDJ8T
   oGBzniRnOAyS48Jy2hDq0JbWb/E+rAhcy48g48Fq+2o76oeAuAIoeSgWG
   oXumFH4Dzm2vl5GUoFtvy4aUxfzP5TWNL22P1MzbP6MQ/xqsDDuwAAeNA
   ghO7s3VTSjOsUp4B8uxu2DCgFWnqITlUHMeFEIGiI7E8opvcfiJp75ngC
   QDXnque6NRRVaAiw6v+ODyZZJx0F9P3DHCS0vgoYpWwbssweJ9P6GUnMd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447936200"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="447936200"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814242243"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="814242243"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:44:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:44:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:44:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:44:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWvsEOe4I5Va50N/y+rjolIRxQK9AkeBFCnz4uSDxK/K4Os40nztWo+s2NI40r29KpNW65SMY8bGwwdvP1gBIgg3RIrdMvdS8Cph42CbwnaKwUNe90UcdhK+0XCS3Ag5mFdwhJMsK2O231fGIl3du//R6wAyOlgFkBFluySrWngL35zc2F+b4ngdTGgmVUnahvmNtBAzwrbbUHGIXi3QXS9gu/s1TpIU2YrAl+e0ORsklr+3Zr9bSRK9C0qcSL/XBvfYWE4eU0t6f5YgCGXG8C3BcqpCWKx2AQppJy65f5fEoOUY+Zk2RwGjjktRlLT6030AYVSj+N+BH+HzIUSGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrL7WwRu72Z8oAA/VJ1MudK/W2CtukPEkTL9nmViHZk=;
 b=OZ40vAcvfuN43FVB30Rigxizt7YIsIgZf38d7EgfRFwoVd4dTntQ/buSEsGHqKtzSfmmCl9L3BIapTSnTG0+ZlXCPVv9vVtoroWGfJSjzvYglX18EcXfjaJOtUHKRLl7vfGI2yjjnDg+A9choALQhID358hHru5XKk2t2C6CNLGu0wVDD7yTRBh2FajiW4v2vSehZmifyIzh8YlWtbbkAuu3b9UbE0OwjSt7lUFRG+yR4gMHoIG6tctvbMyb2NogLTuU99awNQVo2qHwfNi+srhXsJEbQAnfDesv6nF0RpU7vSutqvUL+uJZ+4kqwAQs2EXftVblEa6v77IS+wDarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB7642.namprd11.prod.outlook.com (2603:10b6:510:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Mon, 25 Sep
 2023 23:44:21 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:44:21 +0000
Message-ID: <a6a4e2d5-16c6-0a40-8b5f-5cdc0d5e8cdd@intel.com>
Date:   Mon, 25 Sep 2023 16:44:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [RFC PATCH 1/3] cxl: Modify background cmd handling for the
 others
To:     Jeongtae Park <jtp.park@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
References: <CGME20230922130302epcas2p3911ef4d46327ed8bb2ae990f933e9ad3@epcas2p3.samsung.com>
 <20230922130548.3476202-1-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230922130548.3476202-1-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:a03:40::49) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 209e1b1f-b9e7-4a45-10ce-08dbbe215751
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0XYz21H8Ac0daX+TzisS/b/OeSJepDfCq+e6jccwJYZk59jbyBtiAUoGYOkn/7t8d5Xy43RLENLCJHJ9O8BvWbQYrjndRvRqJGI1I2Jy2OE9MArYC2HIsj43RtpUz6GfGh9VqGrbBm+BBk5C8I8e0xpOTjjHpF8cWzaKS1EZv5LoyN9utB19YZCLNua/84sb3y2td3j9mmn4IumXNONWRLt+M4fnGvW/FmrBiRKTEmK9lAdT5clRrVX/LfaocfTcbFuaI7euscPIsrXpd/TsWqgZasF+gjvl1agUiMiUJaEkU0cBCo+giifrDnMDkn2JQzQ8jkqW+N1ucVC90ywqrAAgfvxiO5Qle9H4/E6pgkc+LXELu/qzt56mzj13a245hTeF0wZFqdlHuo9ttuChB86bMRryjULeENsp6WVqJRrIORLvK1tYdvcG4lt7RbBDGihUKQC6dANlBoOfl0RClHyt+D2N9lWJEmherjrJ4Qmew6xLzypnzbHJ1CRFPI8NNEpgAKTF/TSa9ekfIbKo3cLCv9EogAZCppMTVn67VFU+8IM43qFaWnLZBunklLST3m0LthxfGiC4TO9v7chK3Ol9nE2f9gPm0+8FauTO3bm+XYELpo4jo/5R8Nw5bDShatJ+O8TCLtPhdr5TvJ+Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(6512007)(66476007)(38100700002)(66946007)(66556008)(54906003)(478600001)(86362001)(82960400001)(36756003)(316002)(2906002)(6666004)(31696002)(7416002)(41300700001)(5660300002)(44832011)(8676002)(4326008)(8936002)(26005)(6506007)(6486002)(2616005)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpraGliMWVrRmZYdU1LTnQxQ0xGd2phMmt1WjFyUnNGNWxLL3ZBL0ZqVHpp?=
 =?utf-8?B?K3ZFdkw5Y3FYUGwwSU9vcksxOUduRjBNTFlkS3NocmdyOXV0ajNWSWR4cEVY?=
 =?utf-8?B?Y1g4b2poa1MvNXg3cHpJL1BBZ0dqZkxKTTdZaVFINU9RM0tleFVqVDcxaDBo?=
 =?utf-8?B?d2ZlYmREZzRWZVJydS9UNysvaTZJVG5BU2ZsckwzeFIrRnpUVUMwcXQ5NjB4?=
 =?utf-8?B?Y0Y3TjQ4R2tmZUkrVU10QmVXSkZVOEFSQzBQamF3Q0FaVWx5WlhaTFJ1TTJU?=
 =?utf-8?B?Wk9GSmZJMFVEVUR5d2tKRGN6d2FoclZoNlROaGJjL1ZaRXc2NHhFVWJPQnEr?=
 =?utf-8?B?MnRnSDh3NThEeEsrU0J5b1pqZ0t0UnZUUnBGbkdWMGcwZmszaGFxRnExZGQz?=
 =?utf-8?B?UEZxSHE5SnF6a0RheXVTOTVyKzVhei96aEFQVTdTZ1d5V2RHa2ZybVZUSjF5?=
 =?utf-8?B?U3lGSm50U3J1eVIwazcvNjhVditvYktuT2dnL2pCTGNxU0FnMlQvWjJzTmlY?=
 =?utf-8?B?OE5aU1BRbURQMWR3cmtBaGlWbExBWms0TFppeGpydXNrc1cxenh0SnVDMEtF?=
 =?utf-8?B?VmxhaDI4YTFiRlIyQW9ZSEpXRW5mZW1FZllFS1ZCTktNdENxUG9id21CbnVE?=
 =?utf-8?B?N2doZGZ4K0FXd3BTYy9OL0s0VXZkL2wvUnJiRHpLU3B6MGNRUTFJVU9oeXJx?=
 =?utf-8?B?OHhnUk1VYlVVcmRlcGRMTUZQUWttSExwUzBmUVZOYXZ5M3ZBN0tVNFBpdnph?=
 =?utf-8?B?WnZXbWc0Z2M0b2taeVZ4azJtMm9HdHN0MjlyQ1MxcmR2YVJWQ2JRV1hnVmNa?=
 =?utf-8?B?bDN4bTBKdHc5TTNIanM1cUgyeno4TjhYSzhlekdyRkxzcTNCaml6SVpOeFM0?=
 =?utf-8?B?QU56NDB1VnFrSjVmUTBFSUtja3gyemZDMzVrclM2Qkd1dW9CRGt1bkRRTU5r?=
 =?utf-8?B?U3BKRXhWSTVCWjVOVnIvRDQxZUZRc25jNC8wUnM3ekFRZTNpclRQT1l6MFl2?=
 =?utf-8?B?ZFdaUEJYbmkyNlpHenE3L0IzOHd3RFl6UCtDUCtzQTNVZkpSdnV4VmZqTlM4?=
 =?utf-8?B?OHQrNVFiL0dXaEpaSS9Ra3Z2NlpYZXhuWFZYOFBpSm52SHF5bUlMalNyeTJn?=
 =?utf-8?B?aEhCajhXaE41VU5PdFFEQWRTWkdWam1mT1lDdDR1L3BVZmVEa0t2YjJ1Unpz?=
 =?utf-8?B?ZnJTalp3Qjl1SU4xVDFLQytheUN2QlZac0RrZStENmMzanVEaXB6MC9HSHdr?=
 =?utf-8?B?amZteEc1UkVUdGp1OFU4M3JGeFVlWFFsY0p3RmtwTHZVVndqc0kvcW1wYlJ4?=
 =?utf-8?B?aTFpVDQyVDg1TmNHODN6WkN3Q241Slg2bHhaTlREMmEvUnQzaEREL2ZPUSsx?=
 =?utf-8?B?YVdIaks4OVZ1cGo3dGloR28xSWk0YkdEeFdUd2ZnQVY0WW4vU2dLMVhZUHYy?=
 =?utf-8?B?YVJJNEVaKzdDS1lwSGZOYnl0MzhLanNqUXJHZlBFZmZ1OXM4Ly9wdTJoby9u?=
 =?utf-8?B?NFhOQWliSjA4bVNkWnRGYXprVUtPUVgzLzFva0ZtYmZCNjFPWUtnZ3ZUK2Vz?=
 =?utf-8?B?UFlUYkJJa1hkdDM4aVZMNHJ1bFdXaGdsNWNXa1hyNWVXT2h5UTBPdXIxY0hU?=
 =?utf-8?B?ejNTMXZ3V3pLT25GdUVlT0RxZ0s3enpId3RzWCtFVUx4UGxsM0xaaklaclRN?=
 =?utf-8?B?a01YWlRIZm9HV0J3bU0ydVJBRFFoMWkrTUo2bkpwaXJieGkvcVBnY0EyVDJU?=
 =?utf-8?B?dDlZWDRJT1g1Y0J2TVdoNXBtcCtxRTJaNnBsNStReXpnRHlHK3ovMm5ldlB4?=
 =?utf-8?B?eTFZYkxvL2U0cW8rbUorWmdYWFVPWFhva3JvdTRXVUh0UmZrc29FV2ljZEUy?=
 =?utf-8?B?NXB4RkFEeTFaQTRVYVp3N3dNRzhlK1hYbmxOaEtmTkpUc1pUalZWYWN4WXhR?=
 =?utf-8?B?b1N1VmtwZkJkei9UcEdqeUJmdUJoblF6V3NkY1J1T1d6YllheGQxVFU3WTdK?=
 =?utf-8?B?RlFPR21MbVhXUGJiYnFHdWpXQkU1YVFLTUJkVGdBcHlaZkllVm9vN0lSaVRa?=
 =?utf-8?B?SEl6VklMVm5EVCsvNVczblBVZmowSU40dTc5aDhwVDI3d0VVR3lqaFNCaDZQ?=
 =?utf-8?Q?04yQIncwJUGxNlWuWdYvhpXBl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 209e1b1f-b9e7-4a45-10ce-08dbbe215751
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:44:21.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNgZtAfKNH/ltZgR/Q8K8aOcfP5WWMJ1HVex4UQanMd5dvUhhjRCm47P10DAzPF0ouwaEHLMjF0OnfzWhcSYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7642
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/22/23 06:05, Jeongtae Park wrote:
> This patch modifies sanitize command handling to support background-capable
> commands asynchronously also. Much of the implementation follows the approach
> of the sanitize command implementation, with the addition of 'bgmode' to
> cxl_mbox_cmd explicitly could choose how each command is handled. However,
> even if you want asynchronous processing via irq, it will fallback to poll
> based if the device doesn't support it. Added a new cxl_bgcmd_state by
> moving the necessary data structures from cxl_security_state.
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
> ---
>  drivers/cxl/core/memdev.c |  8 ++---
>  drivers/cxl/cxlmem.h      | 33 +++++++++++++++++---
>  drivers/cxl/pci.c         | 65 +++++++++++++++++++--------------------
>  3 files changed, 64 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f99e7ec3cc40..8d1692231767 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -537,13 +537,13 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
>  
> -static void cxl_memdev_security_shutdown(struct device *dev)
> +static void cxl_memdev_bgcmd_shutdown(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> -	if (mds->security.poll)
> -		cancel_delayed_work_sync(&mds->security.poll_dwork);
> +	if (mds->bgcmd.poll)
> +		cancel_delayed_work_sync(&mds->bgcmd.poll_dwork);
>  }
>  
>  static void cxl_memdev_shutdown(struct device *dev)
> @@ -551,7 +551,7 @@ static void cxl_memdev_shutdown(struct device *dev)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  
>  	down_write(&cxl_memdev_rwsem);
> -	cxl_memdev_security_shutdown(dev);
> +	cxl_memdev_bgcmd_shutdown(dev);
>  	cxlmd->cxlds = NULL;
>  	up_write(&cxl_memdev_rwsem);
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 79e99c873ca2..879903a8c822 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -100,6 +100,13 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
>  }
>  
> +enum cxl_bg_cmd_mode {
> +#define CXL_BG_CMD_ASYNC	BIT_MASK(0)
> +	CXL_BG_CMD_SYNC		= 0x00,
> +	CXL_BG_CMD_ASYNC_POLL	= 0x01,
> +	CXL_BG_CMD_ASYNC_INT	= 0x03
> +};
> +
>  /**
>   * struct cxl_mbox_cmd - A command to be submitted to hardware.
>   * @opcode: (input) The command set and command submitted to hardware.
> @@ -113,6 +120,8 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   *            variable sized output commands, it tells the exact number of bytes
>   *            written.
>   * @min_out: (input) internal command output payload size validation
> + * @bg_mode: (input) The processing mode of a background command. It will be
> + *	     valid only when the background command started successfully.
>   * @poll_count: (input) Number of timeouts to attempt.
>   * @poll_interval_ms: (input) Time between mailbox background command polling
>   *                    interval timeouts.
> @@ -131,6 +140,7 @@ struct cxl_mbox_cmd {
>  	size_t size_in;
>  	size_t size_out;
>  	size_t min_out;
> +	int bg_mode;
>  	int poll_count;
>  	int poll_interval_ms;
>  	u16 return_code;
> @@ -346,17 +356,31 @@ struct cxl_fw_state {
>   * struct cxl_security_state - Device security state
>   *
>   * @state: state of last security operation
> - * @poll: polling for sanitization is enabled, device has no mbox irq support
> - * @poll_tmo_secs: polling timeout
> - * @poll_dwork: polling work item
>   * @sanitize_node: sanitation sysfs file to notify
>   */
>  struct cxl_security_state {
>  	unsigned long state;
> +	struct kernfs_node *sanitize_node;

The sanitize_node is moved here from cxl_bgcmd_state, but does not appear to be used any longer. Does it need to just be removed?

DJ

> +};
> +
> +/**
> + * struct cxl_bgcmd_state - Device background command state
> + *
> + * @poll: polling for background command completion, device has no mbox
> + *        irq support
> + * @poll_tmo_secs: polling timeout
> + * @poll_dwork: polling work item
> + * @opcode: The background command submitted to hardware
> + * @mode: The background command submitted to hardware
> + * @complete_node: background command completion file to notify
> + */
> +struct cxl_bgcmd_state {
>  	bool poll;
>  	int poll_tmo_secs;
>  	struct delayed_work poll_dwork;
> -	struct kernfs_node *sanitize_node;
> +	u16 opcode;
> +	int mode;
> +	struct kernfs_node *complete_node;
>  };
>  
>  /*
> @@ -460,6 +484,7 @@ struct cxl_memdev_state {
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
>  	struct cxl_fw_state fw;
> +	struct cxl_bgcmd_state bgcmd;
>  
>  	struct rcuwait mbox_wait;
>  	int (*mbox_send)(struct cxl_memdev_state *mds,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..570fca24ab12 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -116,8 +116,6 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>  
>  static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  {
> -	u64 reg;
> -	u16 opcode;
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> @@ -125,13 +123,12 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	if (!cxl_mbox_background_complete(cxlds))
>  		return IRQ_NONE;
>  
> -	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> -	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> -	if (opcode == CXL_MBOX_OP_SANITIZE) {
> -		if (mds->security.sanitize_node)
> -			sysfs_notify_dirent(mds->security.sanitize_node);
> +	if (mds->bgcmd.mode & CXL_BG_CMD_ASYNC) {
> +		if (mds->bgcmd.complete_node)
> +			sysfs_notify_dirent(mds->bgcmd.complete_node);
>  
> -		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
> +		dev_dbg(cxlds->dev, "Mailbox background operation (0x%04x) ended\n",
> +			mds->bgcmd.opcode);
>  	} else {
>  		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>  		rcuwait_wake_up(&mds->mbox_wait);
> @@ -141,28 +138,29 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  }
>  
>  /*
> - * Sanitization operation polling mode.
> + * Background operation polling mode.
>   */
> -static void cxl_mbox_sanitize_work(struct work_struct *work)
> +static void cxl_mbox_bg_work(struct work_struct *work)
>  {
>  	struct cxl_memdev_state *mds =
> -		container_of(work, typeof(*mds), security.poll_dwork.work);
> +		container_of(work, typeof(*mds), bgcmd.poll_dwork.work);
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  
>  	mutex_lock(&mds->mbox_mutex);
>  	if (cxl_mbox_background_complete(cxlds)) {
> -		mds->security.poll_tmo_secs = 0;
> +		mds->bgcmd.poll_tmo_secs = 0;
>  		put_device(cxlds->dev);
>  
> -		if (mds->security.sanitize_node)
> -			sysfs_notify_dirent(mds->security.sanitize_node);
> +		if (mds->bgcmd.complete_node)
> +			sysfs_notify_dirent(mds->bgcmd.complete_node);
>  
> -		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
> +		dev_dbg(cxlds->dev, "Mailbox background operation (0x%04x) ended\n",
> +			mds->bgcmd.opcode);
>  	} else {
> -		int timeout = mds->security.poll_tmo_secs + 10;
> +		int timeout = mds->bgcmd.poll_tmo_secs + 10;
>  
> -		mds->security.poll_tmo_secs = min(15 * 60, timeout);
> -		queue_delayed_work(system_wq, &mds->security.poll_dwork,
> +		mds->bgcmd.poll_tmo_secs = min(15 * 60, timeout);
> +		queue_delayed_work(system_wq, &mds->bgcmd.poll_dwork,
>  				   timeout * HZ);
>  	}
>  	mutex_unlock(&mds->mbox_mutex);
> @@ -234,7 +232,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  	 * not be in sync. Ensure no new command comes in until so. Keep the
>  	 * hardware semantics and only allow device health status.
>  	 */
> -	if (mds->security.poll_tmo_secs > 0) {
> +	if (mds->bgcmd.poll_tmo_secs > 0 &&
> +			mds->bgcmd.opcode == CXL_MBOX_OP_SANITIZE) {
>  		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
>  			return -EBUSY;
>  	}
> @@ -289,31 +288,29 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  		u64 bg_status_reg;
>  		int i, timeout;
>  
> -		/*
> -		 * Sanitization is a special case which monopolizes the device
> -		 * and cannot be timesliced. Handle asynchronously instead,
> -		 * and allow userspace to poll(2) for completion.
> -		 */
> -		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> -			if (mds->security.poll) {
> +		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> +			mbox_cmd->opcode);
> +
> +		mds->bgcmd.opcode = mbox_cmd->opcode;
> +		mds->bgcmd.mode = mbox_cmd->bg_mode;
> +
> +		if (mbox_cmd->bg_mode & CXL_BG_CMD_ASYNC) {
> +			if (mbox_cmd->bg_mode == CXL_BG_CMD_ASYNC_POLL ||
> +					mds->bgcmd.poll) {
>  				/* hold the device throughout */
>  				get_device(cxlds->dev);
>  
>  				/* give first timeout a second */
>  				timeout = 1;
> -				mds->security.poll_tmo_secs = timeout;
> +				mds->bgcmd.poll_tmo_secs = timeout;
>  				queue_delayed_work(system_wq,
> -						   &mds->security.poll_dwork,
> +						   &mds->bgcmd.poll_dwork,
>  						   timeout * HZ);
>  			}
>  
> -			dev_dbg(dev, "Sanitization operation started\n");
>  			goto success;
>  		}
>  
> -		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> -			mbox_cmd->opcode);
> -
>  		timeout = mbox_cmd->poll_interval_ms;
>  		for (i = 0; i < mbox_cmd->poll_count; i++) {
>  			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
> @@ -460,8 +457,8 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	}
>  
>  mbox_poll:
> -	mds->security.poll = true;
> -	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
> +	mds->bgcmd.poll = true;
> +	INIT_DELAYED_WORK(&mds->bgcmd.poll_dwork, cxl_mbox_bg_work);
>  
>  	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>  	return 0;
