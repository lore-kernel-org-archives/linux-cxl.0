Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B841FCE7A89
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 22:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIYW5L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYW5K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 18:57:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7386E10C
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 15:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695682623; x=1727218623;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T8DvxWQKSFe9UThjTCBVOR5XVHWCWG4/2WeXvQ99roM=;
  b=asHzHrrtX2keobhGp+vOE7OO0Rulg2++cFlW+T93fzoShlIDG9fASj/5
   ZDo12DAyjJcRQCxf/jHwqilyFbsq3it+z+ZJw63JT+u0lUwpJPfDJP8Cj
   7GXPqrcRzpWo+TTtwt75655096+I469E2xp0LDsrwAgfomfdWK8YyUHs3
   7n+N5lm+VB+0gij5bQyyRWTNWmK9OPdYEBtq9PlYT/cI8KugL1HprHInl
   jAeGGnrKvMNJjpq9qkU9UfF4gkmIwmeXMckZw91mgDbAaKoEnP5BuBAaV
   9yzBeVSNt5OACPADcQw1FrKNq1iisORnvIEK5p+64hxm4roJ5opVDtL9V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380295674"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="380295674"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995581355"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="995581355"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 15:57:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:57:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:57:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 15:57:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 15:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz2HMDindPVktjouVNlOR+cgNe7+ThiC5yVXK0PTWeANun7R+0RQ4izmBmQimRzv+h7IFmY69d5yiJDuTUG/UBbk7V6qvrtQvVCNGN8Bzbk/u//k6Iy1acEQngcf72DZrSVlf3bwu9QJsX22O6P0qlUFhdHIGB4lY3e3i511/mAF9CxW3gJWIA1c6dAKV0ELACS2akinelAVUYweaat9kmLAfPAO2giKDYFK1/k26dWhI647WvbAJNJsXz78IM+eJ8AiiILYfhLIjRccAs9l3GCdKGgYS00jrZacTpFnxHFqgZ+IkImYQnaUSXniQShAhQV27d74oPg/Oh+rEuDXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy5rf0SLh9X/D+hlETlmkZDxQOHIDR0ggZIUS9ysE3E=;
 b=FPhMD/zMIlyTLQzjLcTSWUS83pIpBlaBNdpfeq8VXFqBcn3KgBs7sU+rRKp1EcdwH85BSqXJtcnO/+92tbTJmLcQoxRlIMmzDgPxhlnwFC8xpK5fLETKvAu3skV0NyXde3MgYKoklT+uAXnHOJT8UtElDojt14vPc5oEg10/qndAV78Z4AngaGJrV0HvC/yW9kuaQfVFoSzcjMcrHqcL973lBsNqk9wfIlJcLjgqmRtlKL5JErPior7PyGmP2+jiI3RJvYaT7LJJT0BWMvfNFAEGNTly2V8expS/fmLEcOjeUV1XHJLgTGvifrNlR2FDYdueBOQRtdSX3mvipy8jOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB6765.namprd11.prod.outlook.com (2603:10b6:a03:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 25 Sep
 2023 22:56:59 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 22:56:58 +0000
Message-ID: <5476c53d-d49e-61ba-5f78-abefc5f8c7cf@intel.com>
Date:   Mon, 25 Sep 2023 15:56:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [RFC PATCH 0/3] cxl: Fix background operation handling
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
References: <CGME20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e@epcas2p3.samsung.com>
 <20230922130528.3475445-1-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230922130528.3475445-1-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 13719358-6e56-48d3-2dc0-08dbbe1ab8b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpSoeQ5xT9MvJV7hxEQ5WxdW5CiASLlclNwZq80Oo784thPmL8Lb2HPE8tNW8hZDUoA09YlOlJu6jS5nzTpPDyEIJR2Ovb0zvFIsuHduOlEw5CddMQHlsdebcwEm2RuIGPQlXfBiqIQzDVk96IvkVfMH1EZyeiWmUXcJa8aFhZEgN2kZvzlfkb/IcQs6FPpK9+HtlGDlTnm319Z0n/Fpv6ZZTSW3Zrq35G/hEqRwC/i7jLtUdGGK/NZU39hmXZGWGkc1ljhV7rR9WuQcD8JOOw6TaXADmeDi18q7Co+HSPkw70LTqL+iOLBQKitE8ITzXipWV9F4zVRsD5zb2wFLl33OBYk2UKL548cdS7AQjBG1lVLaE8QVzpjGWv4qLCFF4XeeWkWlO1WnR1l8+Iu+Jr0CAZGyd5E71a1Zc4NObNGo0J5yGM1JBar+GjG4jA00g3K7imxesdU0qtMSnhKTueoPdActhYWQ3r6swRGEDReGmGMOtWvadRoxoAgnP1vvV0O6eOhgLEGaVJKxAw/ucwIliV1uWRVe4s6mbF2G5ZXZD+ynds8vxSvGEyXXZEwBYkxtSdidD6E03EBCPjTQmUASuCm2zKWwAPSLyapzj3svnnufhQfD2VWHOVJgOJg58cTe/TDbH0wqkASpxUBQQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(26005)(31696002)(8936002)(82960400001)(2616005)(8676002)(2906002)(7416002)(83380400001)(36756003)(4326008)(44832011)(86362001)(5660300002)(53546011)(6506007)(478600001)(6486002)(31686004)(6666004)(41300700001)(6512007)(66946007)(316002)(66476007)(54906003)(66556008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnVjc1BoQ0x3M1diUGliS2FIeHFlUkRodVlNNzM3OFVTdWtnL2p4QStHMzVP?=
 =?utf-8?B?QUNKN0pHNTIyWjltWFYvYVN2cVVjU1NvN3FLKzJRaDByUnJvR2c0cThndXBN?=
 =?utf-8?B?ZWxmdllnYlJSZTdsTWNwM0g2Zk1pb1R0TngwTjlRdHJ3Z1RhTVFtOHlHMktr?=
 =?utf-8?B?bmFQbGJsTERQWjhHRFdxdGVWRDhjdjZTaUdqS2dZcjZVMEpndzFuMjZrRHVJ?=
 =?utf-8?B?YVE5bWVyTHQ4UFNVSXY1bEQ1ZmhlSGx1cnlNcnBwMU0zblNFMWV3VEtid2hO?=
 =?utf-8?B?TVlzamFYSE9aRTF1aTVEMGo4OFhHTUxHVWs4Um9YY3N3K2pOZEp6dytEOTE2?=
 =?utf-8?B?VjVmNHNndGZEUTViN0NYNkh5UmluR3JKTHYyUld2ZTRQZm5MbERmT1NxZ1ZI?=
 =?utf-8?B?Wk0vOVkvNWNsSUFISVBmVHd5dXpEODJHWXBnUFJqOTFYYkVhNG5LOTduNlJH?=
 =?utf-8?B?emcwL1lJdnFqZlY2RUtQZXhBWGtpcm5GNnJDdTlEODhRV0QvL1QvK0dMbEwx?=
 =?utf-8?B?TW9iSU93MHJZcWEvMDd5VW11RTFiMXNuMHpNTUM2cXZxbFRQa1cwOGt5VllM?=
 =?utf-8?B?bksvSHBSMkx3RWRHUTB4cFFJNTB3TWIxWnpITWdUdWRLTnlpcWQ2MURUcEJW?=
 =?utf-8?B?K3o4blJwajZJVkc1bWFaUVRWbjF6UXc3eWJITHYrR1Y3L25ERUdtNGJZQkd6?=
 =?utf-8?B?cFlZRGp4c3VxeVlPMTlWMm9XRFNuSlpWOFJNUkZka2h1bjRaMVo5K1M0TVRY?=
 =?utf-8?B?RytEMXAzSGZzV0ZpUUkrM1VQdmlGQUFMQXFRS0NjM1Z5V3AyTGQ4cGF0RnRa?=
 =?utf-8?B?akJsLzJKanZ4MGMrTHlUN1J3OXB2TDM1THR5aDdOd1ZuRy8wbkU1UVdJbGFB?=
 =?utf-8?B?VHpERkxvUm5vRDJkS0hXNDV3K25GNFZWdzNjRENIeHFGTGJnMklPQ2NhdFpx?=
 =?utf-8?B?L2NJRDBqSFovaldua1l4Qm52b04xWVE4RzhNc3NTRWhiRGFBc2lETldOV2lQ?=
 =?utf-8?B?Y1d6d3JYd0NIdFNHTHhyNERvOHBIbDJWRFV6NHhiLytDSXh6RS92KzUybXRn?=
 =?utf-8?B?dkQxcE05d2hQN2VDRzNiV2ExcWFEejFEZjdBVDJoemtiYW1WN000ZGVGSWw1?=
 =?utf-8?B?MzY0Lzd0dUM0QloxYVlxSUlyZERDQ0ErUXp1bUNwazhqbERLaUMycG1uTDdQ?=
 =?utf-8?B?ZGE3aWZQSlhMQVRmTlFYaXoyUmh4ZlR6UWNCK2lxMlUxSGxLdXAxbElWbUV5?=
 =?utf-8?B?WndHM3g3NWtXMkNLSjRyT2NFaVJ4alBjdVRJeVdVUGVkNnAzTFhhWDB0RzBq?=
 =?utf-8?B?QmY3U1NwUURJYWNkNndxVDB5WXlxOFFOWm9rcm5CL2tIZTh4ZktDcThwVmVi?=
 =?utf-8?B?R1l1dDhXa3h5N3NEQ0R5aXhyalRvS3czVWdRUktZVVp2WVZ4dHJDazNYTHM2?=
 =?utf-8?B?SDNaK01rOHdPOTNjUjI3NHgvSktQVUZuM2JkMEV5d0c4RGZISWJFMVppS3Vi?=
 =?utf-8?B?S3REUVduR0VTWEFkcEVUbUZ4YjhqWlFTYjZIMy9CbHZTdHhmL3FYYkk1RXZz?=
 =?utf-8?B?cDdUeGlZN085Uy9SQUIwenB2TWJUdnNBdmx3NHJLd1hiWmJUaEozV1RXMUZs?=
 =?utf-8?B?RVE5NHBDeHBNRG5BaWJvcWprZ05NSkVCbVIyRXROaVVtQ24wOTBtTXFzK215?=
 =?utf-8?B?Y2ErK2FzZGEwRUZic2xMWHRqS3JtMmVudVA5TzZtOGlUL25sTlNqWWlqRFZv?=
 =?utf-8?B?ZHdUVjJVUlZuU3Zlc3dkSlhYSVpRbDFCTXNTbGdORDVCWXMwOHlxTFJ5dVlL?=
 =?utf-8?B?NWRLMkdBL2kyMnVZME9LODIxMW80YVluNGMvSjE0RTl3SW1rQ055TkNhc0N4?=
 =?utf-8?B?NW9Qck9RRkRMK0xlMk44THE2UzRyUUN0UGtLeUJyUFlTTXBLWVo2Q3o1clM3?=
 =?utf-8?B?a0l0MWRNM2V1cVFPemFPR283QzluOGlQeGt2Y1E4Z0RxcFN3Tzd3WkFRQ0o5?=
 =?utf-8?B?bGU5eGZGZks2V0s2TU0rcDVoU0VScmsybTJiNkU2bTJRbDltNklpblBNZ0NV?=
 =?utf-8?B?ZDI4ZHMzTEpldHZ5cnd3LzhDeDIveTlMcXlRZlYxUTJEWk9rM0Fvcmp1bnZH?=
 =?utf-8?Q?fkI3YLDZpTVsjXlVq5F0P5JOq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13719358-6e56-48d3-2dc0-08dbbe1ab8b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:56:58.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlQuZcmTqkL5AHJUu0BwVWA4Tn4k0cIvTz27GsLWTqx5sZ/ErZv8DCo7wq+LusqbBfCvbWZB0H90L62AWgCgNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6765
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/22/23 06:05, Jeongtae Park wrote:
> Hello,
> 
> We are currently trying to add background commands like
> fw-related and sanitize operation. However, as we modified 
> the code, we found that there was a lot of duplication of
> code, so we would like to modify the existing background 
> command handling a little bit. We want to make the most of
> the existing background command handling so that we can
> easily add other background commands in the future.
> 
> The first patch modifies the existing sanitize operation
> handling to allow other background commands to be used 
> with it, and the second patch modifies sanitize to work
> with the modified code. Finally, the third patch adds a
> sysfs file related to the background operation. 
> This sysfs entry is select/poll capable from userspace 
> to notify upon completion of a background operation.
> 
> Thanks,
> /jtpark

Hi Jeongtae,
For the next version of the series you send out, can you please make sure the series is threaded? Currently all your series are coming as individual mails. Thanks!


> 
> Jeongtae Park (3):
>   cxl: Modify background cmd handling for the others
>   cxl/mbox: Update sanitize opcode support
>   cxl/memdev: Add background command sysfs file
> 
>  Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++
>  drivers/cxl/core/mbox.c                 |  5 +-
>  drivers/cxl/core/memdev.c               | 71 +++++++++++++++++++++++--
>  drivers/cxl/cxlmem.h                    | 33 ++++++++++--
>  drivers/cxl/pci.c                       | 65 +++++++++++-----------
>  5 files changed, 141 insertions(+), 43 deletions(-)
> 
> 
> base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
