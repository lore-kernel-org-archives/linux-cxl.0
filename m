Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28FEC001B0
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Aug 2023 00:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjHJAAv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Aug 2023 20:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHJAAu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Aug 2023 20:00:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217FE1BD
        for <linux-cxl@vger.kernel.org>; Wed,  9 Aug 2023 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691625650; x=1723161650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TcSzEhPYZLjHbm5zAxJGOskVOKwZbawxwGeTPFGxtkI=;
  b=dWFTQoZUpOW4k16dVGjYlvUKU+9fMHiGmQhXIhhbm0yCe26RVNHhvYMS
   3O88IMSO0EkZUhsyNQtwTHFTNMYNYwxsLKVwX04IBC2Xho7swtAn1iI+f
   xC5aj80O9bExu7DGygE2OiVrK5Ar9wkCs9Jc1JOi48i+gjfQY6sRK8G99
   +LoaYrjzrruxS8XsEqWyV82z6IS8NeZB8t6faB7wnmnvuLP/XSf+kUCsw
   L+7dTMcq14h95IluZl4Vn2U2uK9JbtdmfyBt0D7IeZu035mRpRX10cRm/
   FXXj7tTeRS9MRqlbsj4HXEz2nFtIjCJY+1ipUFJZpzQGlQU+oRmxe7AYu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370159552"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="370159552"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 17:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797392898"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="797392898"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2023 17:00:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 17:00:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 17:00:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 17:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8KewfuZmkIpCoeoBXnvu31eLdJtpj6xRzf4ovMKJFFsJEPSIGLxbY8S/stErmRi5etuOUijR3S78g9EX1CP6TmmcyTcX3Oc98WfvNJlX3oToO9g/O00BtF/5zVR5edvY+JJ6W4cxAqrrCCcRDIbqgylZq4iIiwI38+IZUtmTAdB+AIVqJ1rVt54KsHBnCGJaMfwWL2MAQ9GkZCEGP7taTiO+WNI8ABl5SZrZyHw2Fgpz5NKSalYZQ8jYPgUic0IHlwk0nFKAYpcDXXU13zIFbDWj+CCDlX/5DfTj7pdHMMMEWKDho+OER5FFM7ksg4N+lmtv22IYU91/u6fAhacEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP5eCu+6Qj4XBIZ1vkudonAPvfc/uZ02CNq9/dNw0L0=;
 b=TO+XpSl1cK/cB2qfiDqcJN8vKZCslBPxjCzcaO8vejJthUOAdW8W7uZ8uLgle3QR0oAr/6nfVsTwH262n8R1KOn6DzejTKv+eQV3HsEJz+qCbba6CugLSKnLragiw6X5WX5IXhaFNxYmGh6ckNozzHwP/NhrFIljVQYi8eV4VTOhXRVf7dvsjRGNJnE9d97hH2Z6bLhXxWN4pJ4rLheaA8o/4nNmm5vSZCtYYVoKCXPi7prZbFCD1Mc0nVUQPiZqHxgqwaJMlDgu7IAaGuz1VjYlLRvWyRszfLidIGU1EOLhQGerT1eTrNlHVdgI7g77em1QevfYNd02mKT9E3JoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 00:00:45 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%6]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 00:00:45 +0000
Message-ID: <a51c9d5c-10d0-24d0-e91c-660472d3b8c9@intel.com>
Date:   Wed, 9 Aug 2023 17:00:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl/memdev: Decouple security init from
 devm_cxl_add_memdev()
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
References: <20230809163733.32008-1-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230809163733.32008-1-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a03:505::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d217213-b8f5-4dda-b1b4-08db9934d880
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLrEW+BqSLUYu71sTR54NV9YNzjdip7kudctHNV+zZY7k6qR0rSjruSe2N0k+gxxUEm2kf4buh9T2zJxH1DJATFuT3fmnpXq6RAGjCdDmxo+tnJVni5K37zyYkOquGxUTuIykBvxEOoLgluovxARAbZFP0VfEl3HfZRxNo3Up3W7KHD61qyk7Y1FtZUYMDceS/vOQacJLyJrruXCDqYDkdL4hkp1i/XEIlPqcY0j3dxRXy00j5tQhz2oHQbN1zA4Sygp7raBh22w6oUf2hPFWdbvSnzVkpCPdqttXwkzi9k9C3rFLBwIGBjL6KUYtr+zfrPKtNpP1iXTpISkSlp1NRvikcaXNf/5DxvpR4CUf+EuV+/zYgZll+IAZmnoQw+WAz6HyNugHrSyqMdDEpVCWmD4TNLFLRQ+NDCKPS5JuEjsZ4IeGgGbPYxzhnImsFFOBrCOpoRER2Zkc1oHnNSRqjVkr6OLs7XirjEvhJgS8CSzj3wfw03cu7tFtpJil0wVJ0IYkLMHgFGLigZif3VZI4SeBnOFTEZqL8BbQKBrdgCUVOi+IRXJzr7qQbO0x6c9wRlgXkaJDW2RWYQBTvsqa9YYGcYjgTpnunfmTmxfF2CiFAFiNrFQerkEni+y5Te+nZMzFqwrDOnuM4cvgUiwog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(1800799006)(186006)(83380400001)(2906002)(2616005)(31696002)(38100700002)(86362001)(478600001)(36756003)(316002)(53546011)(6506007)(82960400001)(26005)(6666004)(5660300002)(41300700001)(6486002)(8936002)(8676002)(44832011)(31686004)(6512007)(966005)(15650500001)(6636002)(66476007)(66556008)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5OQU1HUy9IN250aEFqRnJMcmVOZG53bjZQZ1VTWGgyRWcvZThTTjkvTFEv?=
 =?utf-8?B?NkZFRmRndFUxbXE4akZpa2RwcVVyenZJRGFmbUprZWJIM0pFaWIxTjd6YXlk?=
 =?utf-8?B?VXQ0ZUs5dlhTVjNqeHFuWERTeXI1amtHVE9lRDRHSC9Ycy85Z3ZFa1JiUTc0?=
 =?utf-8?B?RzZPQUlZMEFZZncyTEQ2NHdBVllsRzVUamJzcFRHNjRoNlpMang4Mm9XLzlV?=
 =?utf-8?B?KytDSGFUbC9WdnlqUUFTSGtRbHVnRFE2Y1k1NkR0WkxHdElKM1FTcnlyczhl?=
 =?utf-8?B?KzFCcXlISTl5Ni9XQjdpWHM3TU1CZDRiRThYVVZScm5ZRXU5Ni9kUytMcHl6?=
 =?utf-8?B?Rm1WSTB1aC9HQXA1MitXamFFQ01oYXR3WXROT3NoOEJ3MWJGTDdFc2h1YmMr?=
 =?utf-8?B?VnhxV2kyVWZ5QUl0TmhNRWdhNkxmTDJGSUgxZEtCeVpYY1NuS3lWWmthWGZj?=
 =?utf-8?B?clQyNnBUQnRNLytDQmNrS2Z4dGU4YVNDdTFLQ2VqS0F4blFMUE9WcVJDNDVl?=
 =?utf-8?B?b1ZIZDJvRnBGMFpWamViMTQ5R0c1VFN2ckQwa2lPZzhHalA5ajlyV0lNRTFn?=
 =?utf-8?B?MHJBdkdyNElNZ25peGpTTWRkUnF1OVpDaG9lTlpsK3dwbVo4aWk1K3hocVhS?=
 =?utf-8?B?M1ptL3RrTW9hZk1pb2ZHOW85WDZSZUhaSUFWWmZkVDNzZmdPbHpSUEg2eG56?=
 =?utf-8?B?VlpyWUxMM1lkNUtXUW9qVWg2SDY5RTVxRk5GVzZtSlh6R0tFR3F2TWE4MHhZ?=
 =?utf-8?B?c290V0tvUGNqVEE5UTdjcU1hUi9tTjlZWmtRdXEyWmowck1Qajlza0JPV0RC?=
 =?utf-8?B?K20vbnVYN2JFVHJ3Q2JjR2NZUmNQYXVjNS9SdTQrMHRkbWNVbWNHMlV4UHhT?=
 =?utf-8?B?RWFiR1hSTkJCSXJ1UG5CYlgyc0dPNm9INUVmR2xvTlROL3hMWUJadFNxanBM?=
 =?utf-8?B?VnhndXIrSlJGelV4cHVrdEZVcGVncUtkWll0eVE2NnB6MlBib2hYNTEvYVlZ?=
 =?utf-8?B?ejFQbXpINHBGUWxKQUp6d3pESlpReVBtTGNnYkUvU3hTaXpvay9QbkEvNHcz?=
 =?utf-8?B?UXpLckZmL0pOOTdaV0RyYmQ2OFNkeTBaVHovN09wZlU3WXpraTFmckwrUVlq?=
 =?utf-8?B?eUcxN2toOVZQYTYxMnBqTm1ZNU9xMUFoSUVudytWRDBsei9XRmtqUXVlZ2N6?=
 =?utf-8?B?VmJqZ0RLbGxxaFRERHRLUkRoZ0F4WHZScDZRd0tmbTYxWHFaajJQbXU2SVFv?=
 =?utf-8?B?OTRwUnBWSmlpY1pOdjBySDVjUzNCQllFYzViRDBmNmZPQ1Y2ZHdIK1hUVGs2?=
 =?utf-8?B?bmdTRG1tK1JGVGhucmZFclIwZDlmYyttQ3FpOWtBLzdGdzdNS203SkFwZG1C?=
 =?utf-8?B?T3RyUzc2cXdYZFkyOWNNbkZVWEtFMWpVRnQyaDR1NUJwUmR1UUNsWUdQc0hO?=
 =?utf-8?B?RldvUm9LSnNITnVXTllNSlBFYnJnOE9kbmw4Ukl6STgxZGhib1BHcEJtNmNz?=
 =?utf-8?B?SlRzajRrYjVsY3U2Q3BPSTFLQTdNWWdMWmlrM3A2K1I5SGk2akoranhGNVZD?=
 =?utf-8?B?U0pOSmEvNERpQ3pSaWgzSFBqOXFoVk5IVWFlVGxQZlBHY2Q2aU9DcHkxYXFC?=
 =?utf-8?B?WWx5L3JnWnV2SFl5L29nWk9FcHhDQ3F5ZXlUVEs1V3JjYW55VjJ3MXVvVHFC?=
 =?utf-8?B?aFdSUXJIWkV6QkNxNTdZaGtTUzk4ZUFxMEZnT2pqcVNVQVp0VWRwMjFVOVNx?=
 =?utf-8?B?c3pBbDRSZVU5M2Y1eHVnemw4ejZNVnZFZ0tVMmtZNmhrT0hIQWNEYjlxMU5i?=
 =?utf-8?B?QVNtdS84TWhTN1JNQlBTSmZmOHlsMnM5dEc3bEh6cmp1SFUxa28vdU9vWThC?=
 =?utf-8?B?M1A5cDU0eWlXbkR1K01kdjE3Z2JXUnhHUHh2RUJLMjdQZ0s5ZlFOc3ZjRmx2?=
 =?utf-8?B?Q2ZBMEd2RUxYbGpYc1hHSDQxUWk5WXhENzZNVnVwcldEbjQ5OEEwMnRTUENL?=
 =?utf-8?B?cnEreFo5ek1zSHpRVDQ0ZnJNWWl2b0VPNStzYmJvbFRrM3VUY0tkeXZSVkpC?=
 =?utf-8?B?eGdNMUZkYjJENFRCbGljSVRBUWYyZzZhdEQ3NWo3b2k0WlZ1R0UvcmkxQmFr?=
 =?utf-8?Q?xu8QJW/YUgeW3mPt43NAkydyU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d217213-b8f5-4dda-b1b4-08db9934d880
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 00:00:45.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVYnU400wiWs/ep0hTmr20qZ59HKgWCnwfWyi+Qhu5YvUk2IjKKjeBqcbPYHlVDQrsSTiTVqWVDsuCFI9PWE4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/9/23 09:37, Davidlohr Bueso wrote:
> A crash was reported during type2 device entablement[0] which called

entablement?

> devm_cxl_add_memdev() without an mds, causing the security state
> init steps to be bogus.
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000278
>    [...]
>    RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>    [...]
>    Call Trace:
>     <TASK>
>     ? __die+0x1f/0x70
>     ? page_fault_oops+0x149/0x420
>     ? fixup_exception+0x22/0x310
>     ? kernelmode_fixup_or_oops+0x84/0x110
>     ? exc_page_fault+0x6d/0x150
>     ? asm_exc_page_fault+0x22/0x30
>     ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>     cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
>     platform_probe+0x40/0x90
>     really_probe+0x19e/0x3e0
>     ? __pfx___driver_attach+0x10/0x10
>     __driver_probe_device+0x78/0x160
>     driver_probe_device+0x1f/0x90
>     __driver_attach+0xce/0x1c0
>     bus_for_each_dev+0x63/0xa0
>     bus_add_driver+0x112/0x210
>     driver_register+0x55/0x100
>     ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
>     [...]
> 
> Move out cxl_memdev_security_init() and allow the pci probing to call
> it directly.
> 
> The cxl_memdev_security_shutdown() counterpart will still be called
> by the unregistering scenario, but is removed, however, from the
> devm_cxl_add_memdev() cleanup path - as this is about ioctls and
> there is no way for the sanitation to become active during that time.
> 
> [0] https://lore.kernel.org/all/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> 
> Reported-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   drivers/cxl/core/memdev.c | 17 ++++++-----------
>   drivers/cxl/cxlmem.h      |  1 +
>   drivers/cxl/pci.c         |  4 ++++
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b547c07f54..628d9d1fb795 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -561,7 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   
> -	if (mds->security.poll)
> +	if (mds && mds->security.poll)
>   		cancel_delayed_work_sync(&mds->security.poll_dwork);
>   }
>   
> @@ -570,7 +570,6 @@ static void cxl_memdev_shutdown(struct device *dev)
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   
>   	down_write(&cxl_memdev_rwsem);
> -	cxl_memdev_security_shutdown(dev);
>   	cxlmd->cxlds = NULL;
>   	up_write(&cxl_memdev_rwsem);
>   }
> @@ -580,6 +579,7 @@ static void cxl_memdev_unregister(void *_cxlmd)
>   	struct cxl_memdev *cxlmd = _cxlmd;
>   	struct device *dev = &cxlmd->dev;
>   
> +	cxl_memdev_security_shutdown(dev);
>   	cxl_memdev_shutdown(dev);
>   	cdev_device_del(&cxlmd->cdev, dev);
>   	put_device(dev);
> @@ -1009,11 +1009,10 @@ static void put_sanitize(void *data)
>   	sysfs_put(mds->security.sanitize_node);
>   }
>   
> -static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> +int cxl_memdev_security_state_init(struct cxl_memdev_state *mds)
>   {
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct device *dev = &cxlmd->dev;
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct device *dev = &cxlds->cxlmd->dev;
>   	struct kernfs_node *sec;
>   
>   	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> @@ -1029,7 +1028,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>   	}
>   
>   	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> +}
>   
>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   {
> @@ -1059,10 +1058,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   	if (rc)
>   		goto err;
>   
> -	rc = cxl_memdev_security_init(cxlmd);
> -	if (rc)
> -		goto err;
> -
>   	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>   	if (rc)
>   		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 706f8a6d1ef4..b99099eb2402 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -884,6 +884,7 @@ static inline void cxl_mem_active_dec(void)
>   #endif
>   
>   int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd);
> +int cxl_memdev_security_state_init(struct cxl_memdev_state *mds);
>   
>   struct cxl_hdm {
>   	struct cxl_component_regs regs;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..5242dbf0044d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	rc = cxl_memdev_security_state_init(mds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_memdev_setup_fw_upload(mds);
>   	if (rc)
>   		return rc;
