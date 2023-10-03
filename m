Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B794AE8FDC0
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Oct 2023 23:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjJCXYF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjJCXYE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Oct 2023 19:24:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6BAF
        for <linux-cxl@vger.kernel.org>; Tue,  3 Oct 2023 16:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696375441; x=1727911441;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XF/5sNf6DladE7qdn3Dj9+7T6fnJYHKQfpDEPfizqJI=;
  b=bt3TH46HNQDw08orJQF287mqoizFsfcYp6Jpi+PpTJ0nmeIqKCERa8Fw
   ZI/87XbEzpBQZFVGbh9lLdiPxQ5Q3GsFj1ptOLwzVAu5nB1sAPuNA6+hY
   JRCKlUrs+CONx+1L8J1Y0w/a9aAiUw/tvMpjij+4L7uJHLixS6Lhw3ctx
   uenbTdUGwmO846ATsHq8hDsN+ldhJV2A9wX4ZnaWNu9XDLCQdOQeRAQxe
   o5DU4x5jgYfXbz0glL5Z+7PM5y5QeqZcG7mCb4FCONgUtwA6XkEHZ3Kt4
   wWd8oByNHcieJqq9qHcgIUnBpGk+E7xo6QBKHOUZi4tAZpHADhVFxam6M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="373339722"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="373339722"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 16:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="751069902"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="751069902"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 16:24:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 16:24:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 16:24:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 16:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNPjyYtQixY+r9l8covinoW9/byCk/qUonVWN73AQNkK6+VB4E5wh58bwfA4oWSmUt3hS45vJ4++1uPqUh+EWKQjP1r4q4a3Rc1RBVYgLYWIxdXNEYGTrrT8jJmxGa/EnRKrfynQhQDGsbWTbCbpNY9yFDEot/GLnL1nHjvIU/eAjjbgF+7iJe3MlTcuIkGm1gTOvJv/qRi/e3mW2G+MOmaC2ns/CZrUZ2wL2mJ06UWsR7BgY5gyNSFEiOPcCNCMbMq+jAyXMmYQUySGtJIjx30+hsYTaSWEz3r3SfY4c8LLkx7paOODs55ssikGtQMBQQcjQYoB/9WrXOTT4lWlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLMLsDDYV77wDHeuu6lYB6G3KyeCFxTlfMe7z3likcs=;
 b=Srthg0LhK97gE8S0BGQwyyDetNvE0WSA7xgDXUu7e6kFodjNcRhx7DYZutm8ogY+uyPmqu87ljNH/p71EsCuuj1MU5/bd1ExPILxwy+dJQZaQnsaLessslc7k8dYpcqUNXY6tMI37vafIMd0FNB/ptS8CRfMHayw7SqMKVrXNqowkAQwNoVG83dn8G3MDEpul0picBK7Y5mQuK+K+WUHFoslDcTLZYezj6TLooqYH85deZJAYm05eM8204BYgS/sWcU8TvhoOR/9MEzuSywEWM59YEZirXHyDNrklh/6/aUny839DUPMH2ZqU2O21onseitWtERndLACAkNs6jD5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB6885.namprd11.prod.outlook.com (2603:10b6:303:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 23:23:58 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 23:23:58 +0000
Message-ID: <27f1581d-43ab-4ab9-b6ee-b591d82c30b3@intel.com>
Date:   Tue, 3 Oct 2023 16:23:53 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3] cxl: Add committed sysfs attribute to CXL decoder
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>
References: <169575398814.4028282.11591056324662123995.stgit@djiang5-mobl3>
 <651c98472dfed_ae7e729495@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <651c98472dfed_ae7e729495@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 65efebeb-5edd-4a57-dbc8-08dbc467d151
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/Lq4hMEegJLavVlZs9scQ8nV08J1FjtTvZ0GTRt/VdKYepIZTIH00RQxU9sv2+TJOMEPSNhT8OmtqZHiZBMDADMAdouAhQ811ZQy7YK/sp95dW7wQCjGuSK9RauIASzd2d3asAOGoGXoBSJ9nFKHYemz4w+vyB5D0OwzIc+/MznECYzcndYJqA34kRF/wVOoaC2QgUloI/ikQHmx5BSN2CVcMu9jEXE+m7jPeIrxZahYi1Qmi0V9s8y2+v0mGgw8sxL02T4jUyFupkSfzLytFwWPAYXsjATzxd2w8UzPDlKV8hOMuShZRbngrrqN5B5rkPtrjr7zCq8W/4L4/mSPCJQENkOKSMXPoBFKwAjQWtz+086C4XeSVrRo2mwlU6jKEQLfwTMIZU19k8gfgYB43G4e8IOEQMF8UJE398auIdl4WMLqge6OFZtC4ouJKX7dAgh95i+ObMDXjTDeQ5EjBfvYZNgrHTeZCtRCt8lgGFY+5fxFq3Cxqfi1Tqx+hur4TgP84od18RPKdqnbgcNT4rOGFQ95QKaxQSoJei+KTQY6Sv1iJGXXv6EquAmkrZqhbeMTIyHGeGShG8ho5qqb9jgKPIM4qk99IC4IKHr15U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66946007)(5660300002)(316002)(31686004)(2616005)(6486002)(44832011)(6506007)(8936002)(66476007)(478600001)(66556008)(6666004)(53546011)(2906002)(8676002)(4326008)(41300700001)(26005)(107886003)(6512007)(66899024)(83380400001)(38100700002)(86362001)(36756003)(31696002)(82960400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRNZjdqVVk4NG1xOXNtVWRRbFFkSnd0Rk42ODBrekNsSWJDbDRITHF4aHcr?=
 =?utf-8?B?TEFtNk5lZW9lNVUzb2I0cjZxa3hwOHlXUlloeGozcEZRUEhPdXJ4ZXpkRGFH?=
 =?utf-8?B?YndZNXYwQmE0MTVaT1MwS043UXlxWk9ZdDQ2cXR1VEt3SEdtRGM3MFZwVU8r?=
 =?utf-8?B?czErdXdkbjZNSVlrSDRLTDFpTDFWZ2JGVXRwVEVQbFBjMnM2Q3NpbEd3ZWpC?=
 =?utf-8?B?V0I1YU1HbURKaGRHZzRFeFd3ZEhrN2xORmJLZEVOOVYzQnJBOHdkM05qM0xq?=
 =?utf-8?B?ZUZzN3plT3ZaQ1NxUjdUQkRMKy9TMzRjd3EzM0pkWldqcElDd3lNd0RnUFgr?=
 =?utf-8?B?WWNoMkdpc3VGcGU2MUVpWE91U2xxQTN2dFYxZVdXa3p6UEE4cVJpMUFab01S?=
 =?utf-8?B?dmlNNTU4Zm5BNVJtZkxiN0FIVG04Q1ViUlptSjM3RWFmMUFYV1d6QXlMRFZr?=
 =?utf-8?B?Y053N3U3eWFVNFJPaE0xNzJRNE5kekZvdDNyaVdQOFlGSFpHTnB5ZTRvNkdC?=
 =?utf-8?B?ODllcWdjUXlUa0paVTk2V2k4MW5HeUJlaWpFSHkrTlptVWpGa3I1THRpTXp2?=
 =?utf-8?B?Rk1ORE96blVyZ1JMZit2eVhOQkRKd0JqR1FGajAzbTVZay85RklvU0tYTXcz?=
 =?utf-8?B?VWlsd3kvUnVBQmpMV2l2UFVjV0JrVjZMTngyLzNxNGQybjd5aFJ1VktuTHRj?=
 =?utf-8?B?eGx3M21oQlhMbUE5ejczd3ErM2JHY21ueUxqSDBhZFhZRWVCVDJ2RFZ5Z3dF?=
 =?utf-8?B?Q0NDZDhuMVovVDRoUzZJYThFY1lBcDBiUy9KZ2JBNU5oNDNhOXVURVAxSnVk?=
 =?utf-8?B?eUdFa2Q1K3J0MTZZQ2c5RFI1Rms4dnpzZlBVcTNhREN4Wnp2bS9UY21TWTBP?=
 =?utf-8?B?YWIwMjkxTDF5RldWWGE1b3o1V1I4QUZoR3JIQkJyb1dWdGlPT1Y3MThiaVF4?=
 =?utf-8?B?Tk5Qbk15Y1pMcXpCa3V1ZU84MzdTTENaYU4xZ2pjZU1mN1lLM1BmYXZBUFNK?=
 =?utf-8?B?dTdScUhuRTFXMEt4dUdBbnhweUliS1dGdHF2N2syU1ZhV3FHVElzUGc5cFRt?=
 =?utf-8?B?cmhpYjFVRW82dzVRQktEbWhnbTBBRE1wWDhHUnBPRWlZZElTS2JiU2xDNGVC?=
 =?utf-8?B?YlhFTGg4dWpMSC9UYkUvWGhENnRMenBEcW8vS2o3SEVTdUE1Z1pNWFJuTHhD?=
 =?utf-8?B?elhUTkNNcFd5WG1XTlhVOFZ5V3lFVFo5U2tRa2RNNEozYkZET0piNDJuRFBq?=
 =?utf-8?B?NFpDVzZESjVYZTVNQVZ6bmNOdlVadmVsMFl6VkkzYSs2YWZYMGE5VWpRb09V?=
 =?utf-8?B?Mk1EZXdKMU52Vm45ak9WbFQ4YzYwSVp6MUlRSmdJRGNFVmtvcjJFMG00eFU0?=
 =?utf-8?B?Uyt0c2psb2xoZjBXR1A4S2QxQVQvSTlBL2tITlZwVTFya3hpSEt1WlVUeXl3?=
 =?utf-8?B?Szg0UXEvUVpiazZtRlJvK0pCQi9uK2wzcnorOGhjeGRXWHhjODA1QVVMM0VQ?=
 =?utf-8?B?OWtJL3U5U1l0SnduVTRUZXA0WjIza1ZFYTI2UXpHalNrc2t1bVBvSldaam1q?=
 =?utf-8?B?ZnNCMVltM21WQmEyeE5NZi9aWXc2L0xzU1lIWWVlVzlPdEJtUnErc0psVHNo?=
 =?utf-8?B?dktrblZHaU0xc0tBVEtKUnpaekpmQVBPd3lxZDM0QVM2RlpsWDJDaW5rYzZ5?=
 =?utf-8?B?VC92WnBtTXJ1OXE2azhsK1pENGg1REtmY3hvL2tTL2FTL3ZDbm5QWlFSQU1u?=
 =?utf-8?B?aC9Ob0c4RVJnbU1XUmh0dTJGcWFGdm1EYUI3RGNWVFdLZzVDWnlGVDlsRjR1?=
 =?utf-8?B?SGF0N3laZzluclVJUEF5U1VuWXlvc01ZTmg4WnVhV0ViTWFsY2pVRGNseEg1?=
 =?utf-8?B?Z1hWQW1WRzJTVnk2TVdyMzBxY2c5OGE3N2g2SzRVMnJhd2RDSXc5RGhxRnp5?=
 =?utf-8?B?a0gvSWFteWNOV0JJc0dLMm5RTlNoNDA2amJqb3VHbDNnM1BUYzZ1VlJKd2h0?=
 =?utf-8?B?NlN1M1B3ay9ibWZjODNUMUZudDc2ekxwWHZzLzhxdmVEWlJZait4UjFydWky?=
 =?utf-8?B?RkNrZUpCcjJtQlpsSWZKK21xdkFZeGNVVGJNRDJXb1RCWFVYVXZ5MzRLbmpu?=
 =?utf-8?Q?QHNO8Y4F1kJ1eYwPNKr3b/RW6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65efebeb-5edd-4a57-dbc8-08dbc467d151
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:23:57.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOrQTbjUM1gqAYTb1aK8kW6bVwwGwXCGeiptJuY5eJwbDeElr/O0rwg8DqCbUT2JmsRl17VPf+OHVFrM8wf2SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 10/3/23 15:40, Dan Williams wrote:
> Dave Jiang wrote:
>> This attribute allows cxl-cli to determine whether a decoder is
>> actively participating in a region. This is only a snapshot of the
>> state, and doesn't offer any protection or serialization against a
>> concurrent disable-region operation.
> 
> A random thought occurred while realizing that the kernel uses a check
> of:
> 
>     port->commit_end != -1
> 
> ...to determine that a given port (switch or endpoint) has committed
> decoders. If the goal here is to determine when it is safe to disable an
> entire memdev maybe it is better to check all of the decoders at once at
> the port level rather than one at a time. It is already the case that
> CXL prevents decoders from being committed out of order so what do you
> think of replacing decoderX.Y/committed with portX/decoders_committed,
> where it just does:
> 
>     down_read(&cxl_region_rwsem);
>     sysfs_emit("%d\n", port->commit_end + 1);
>     up_read(&cxl_region_rwsem);
> 
> ...and cxl-cli aborts destructive processes on that attribute being
> non-zero.

Seems reasonable. I'll rework the patch and the cxl cli code. 

> 
> Is there any use case for userspace to check for individual decoders
> being committed? It can infer "decoder committed" from "decoder_id <
> decoders_commited".
