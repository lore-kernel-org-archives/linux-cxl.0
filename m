Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973A6C0015E
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jul 2023 18:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjG1SC1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jul 2023 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjG1SC0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jul 2023 14:02:26 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAAE19AF
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jul 2023 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690567345; x=1722103345;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2qrr+Z9ZResJwl42i8ulxGFK+e4q0xrudFcx4awuKjI=;
  b=aiQrOVJODtocg9NIp2UoLi+ZdXrvnFeTfGjejagoCywqnQ5i0BdYRK4e
   UbT1nuImMWy2K9UiTGVeNuY607kx7z3d7dTZ10mQm7ExYjFSiAKh2HC2z
   yfGjpLIiZjyjAabvvs5jjxqWB/l1tHH3mnhJmJNcGHszy7tcgc/sOGJIG
   QChkGhxZYmTXIiZQ2dxe8Ty46BUd36cIUiW0qBgyJyy7kWKHsEOpsoN7+
   G41icdygyEFFMUjy09TVCs1Wh0cmMk0GdFUIYCfKd2/q/QbGdHGXGL2dE
   u/+gPCV59udljdKg+DYirT0Jl4G9rjTSZZ5+GY4pRNLz4iakHYMuqk2u5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372278773"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="372278773"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 11:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="730852902"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="730852902"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jul 2023 11:02:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 11:02:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 11:02:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 11:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJxK2yDvIVzKvNGP/aCiRg6dCSxDSkqgGV2ryDneEqV4kpzA0MOAcLg2TC9axzKXB5rwTQbEC9WAoebiPhYgypokxRN3/dvKpIUec2sZOWSXg6IDb0CMuYcSE05xgUZFEMp4tNyq3cBNIHkv0jfEoxIli44kgBx7EqX/br9rbrCNcMPhGehSZogLD+clxh53fDayYIkO+RqLrQN10jICCLB/3bX/EIpnazHHipIH5NHnzryUrI7kpTGZQG7eXoe7jZuvm3sZydAGvF9xo6iXFeuHJSQmwqAyX0YZ+Joqro60W9NLyNkxwmtIiWYvAoGtn3Z8IHgEdDhHFPRMLvdFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaMgjXG/s2YZ9KPPBkqh0QQi1tXHt/2uhuYw87cG8wY=;
 b=jxhwk3O2CUBYs5zYHHE1TMumTosyVBgISOUzEFu9VAaIi8ahTMFobUj4EnEFIIFK5B1pzwnt45sqGxfsfBKg4hacDpUsm3LbYvN6Nu6Cn9uF9ppyCY2TBBPtj0/xG45UhEYIhaFiXee4Iy/JdaqyVMb4vBz+pcH0qF2dHEgLWKXnEJURsFwFqLWXCjLqo/Piua5UquG1t71tbmy79/0qbA8kNmkEmzZn3GzkyCqkLghX74SqD8/3tg3LkfyC55Af68mZ9pI4zqxwu0KYZw5v0DWbM4StTUHv1tAzhmhv962dqqr7RimRCp2eh9oVJrt4PLXWBCBINHkWbv9+YiyTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB6729.namprd11.prod.outlook.com (2603:10b6:510:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:02:21 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6631.035; Fri, 28 Jul 2023
 18:02:21 +0000
Message-ID: <b6b58948-494f-7d04-3572-4e63174b3a2b@intel.com>
Date:   Fri, 28 Jul 2023 11:02:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 2/3] cxl/memdev: Document security state in kern-doc
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <jonathan.cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230726051940.3570-1-dave@stgolabs.net>
 <20230726051940.3570-3-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230726051940.3570-3-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f7ada5-d386-4cf4-d282-08db8f94ca4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9yPRhBuZ6R9uVhsTBx5V7B62PBCgyKXZ49dua2SRQBEXl4clKxa8YG65PABSdqi2EHlN/zQ5uy20451G8XqtkGyDD3LzWG9qB0zEP+SC8GjcUJdnG/awvm1plx9aE9m82ZrmsQ29LgyL5amVHyuHpkAZ6XVIZJszzpeoGtgNSNjtGZynbMrm5lYuuZkzDwWRyHxxL0FK/qCsILoMLwdsoqXZYC2oHfiGSevpGqRKGSK80KUDgv9jKWa0vwbsoI84XNiE5lIaidB1ZxiIOyR0KCI9ehTo7ZyHkCvOt38X1ZAeOp7VAmi76H82rPs71YOh1Ot/mjRczRhc1E+nLSVvai8dHZKMwHLL7yeNuABwMpbrxoy+4ZaIByvb/s9H81PG4F16zubI1K52ZJxS8AzFsnPLuQt1jQHuCKx/D83cUchXD63pknjCsPgRVZPuRV+mMOd1b6oaC0A79n5C/RAcxUQ5cJv7WZVvfDiYmeA1SJCfe2JBTMivvouxzYYRXa0O2I945j1os+soMlEnFJmAFq6FZ2x/Lh3kBJ/mpLTe4USEeInpfsmH5pr9Pm3dK0SCUtfk5ypSr8Ie+UUkzciAxUIGH55ZnLrE/4PGQhSAVayl5WjYXbGJawwtBe3H9m1lSsqgAGgAJNSLXdftEckUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(15650500001)(2906002)(6666004)(6486002)(2616005)(36756003)(38100700002)(4744005)(186003)(5660300002)(44832011)(86362001)(83380400001)(31696002)(31686004)(41300700001)(8676002)(8936002)(26005)(316002)(6506007)(53546011)(66946007)(66476007)(6512007)(478600001)(4326008)(82960400001)(66556008)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzlYV01LanpVOXl3cEhMcjN6ditraFp5RmEvU1pjWGo0RmZMeDh1QXhRM1Uy?=
 =?utf-8?B?R3JlaHU3SHhkc1ZKK2d0bTI1WVNOWGZDUFR2cElmZmkvQ3hJQmVvR3paNmc1?=
 =?utf-8?B?QmRJNjlHZnh1TUI5a0FnOEd3c24vdTAybkl4cEorTlpJM1lDOXpGcHkwaVZr?=
 =?utf-8?B?TTJhSm85aklEZjBnSktNeUVjYnh4TmhBZ1ZqQURZcUc4QXQxKzBBQTA1MHR6?=
 =?utf-8?B?aHUwcWtNa3RQWXNZREs1UW1EQ2lUU1hqZ3JNNXUwOE9za1M4VW5zTFFVVjZX?=
 =?utf-8?B?WmJNMjV1aDRUb0RoRG5WdFpROTN0VElhSW5GaXYveG1SUWxxMVdXcEI4Yi95?=
 =?utf-8?B?TXRSTFdjazZkVFJCMjRrOVpEN2JsaFU0VmlTL3RUK0VzQzc5Szh4ZzlIT0Z3?=
 =?utf-8?B?T1o4d1lqVkZUS3MweEc3R2E2VjFKMUtpcUpjbjNXQ05XeVpKY1BOUDFCdDNq?=
 =?utf-8?B?SjdNbjFYeVhudGZmYmZ2dmFWTW0waHZpdkVJdFpWeUtGOE15VHMyaW5wQThl?=
 =?utf-8?B?ZnVmQ3g5VDV3MEdkZ1RSeDJCWmZhRDhCc0FmQzQrNCtvUWh5alZITjRYNGlk?=
 =?utf-8?B?a09HSDBnR3ZiR0w5ajVOUjRzUDcyZGM4UEhLVThNWERxNlVWbDJSQlJKUUZV?=
 =?utf-8?B?R2NtNVdMVG15dFhucnFIQ1dDS2VRRzczczhOWVU5MW1IWm9ZdGFOb2ZWNmFL?=
 =?utf-8?B?bzFObzBQZjJma2RZbi9CelFaNU1SR085UHhNSGg4VExKWVR2NmlOWDJEMnNy?=
 =?utf-8?B?V09YR09YYjk4VTRuaXNkdFBYUXlqOExZd0dRTXZSWFVGNk5tNWdJbk13N3JW?=
 =?utf-8?B?UWZ6OUNIVnVkUGNlaXFSRlBjK1lBcklWV1N6UVY2bGhMbWFWc0pSMlRqRVRK?=
 =?utf-8?B?a3o4YkVmTjFWY1lDcGdFc2h4YzRuMkh0V20xc2pydUV3NFQ5WkhJeGlsSFFr?=
 =?utf-8?B?bjZUZjFZbkxZbzJJNDdWQUVCQ1M3ZW0xdjZjV2tlUW01OWdRcG51bTRNeHUv?=
 =?utf-8?B?NXpsNkZXWXRyVEdTdFRmeG8zT29zeE9kVHZpMk9vakVnQVFJR081enVsclhB?=
 =?utf-8?B?ZHZtb2szQXZtUnNjOFNqVkJYSjVUWlNVTEFKZWw4RVhHUHBIZ0lCM2tpYXBZ?=
 =?utf-8?B?TktIYldNS21sY3c3RFNOV2NhQ0I0Vk96VDRiMHF0TXZjZFl3a203ZXNzQVdj?=
 =?utf-8?B?bzR3d1BPMmZHTlRzOCt5bDRHUVFJdUt0dlRDM2xlZlhNeEdKNnJEU1NTV1po?=
 =?utf-8?B?ODJrYkhxbEpGRTBCclB1bVlNMElHQmJRTE5LT3hvOWpKVEs5aGRjSmNEU3V6?=
 =?utf-8?B?SjdBK2hKUXJLREVGa3hIbXBqS1JyQm5teVFkdW9TS3B4aHU0WnZucWlnd2sy?=
 =?utf-8?B?MHJYUGxEMDBjdTZ5ZzVDRkxBVm9MRDlaekQ2M1dkanFMenR0N2JwUVM1bjZK?=
 =?utf-8?B?b1VRdGM2Uy9aZ242NVlXbzYwNm1rVnFiRVlxSHE2R0IwL2pYaC9XK0JrMUZ1?=
 =?utf-8?B?SCtjNjk5SEM2TXFOYzVQUjNPZDcyUDAwUG1wb2tYSHlCb3k3OHkvNlhUVDcv?=
 =?utf-8?B?OURnRXFocVJLNzRTdnVlMGdIcDQ4ZW53MUhpcDM3QzBPRTNtVkVVZlo5OWdG?=
 =?utf-8?B?WjFMQW5UanRjYnpPLzBnT08vVWF5TU1WdVZsUlI1K0taS2tPT1V4Y1FEMUwx?=
 =?utf-8?B?MXJpcUVXVWNtOGVsUEtxQkkrMllXYWQ3aDhZenVFZTA1L29Ua0xaN3hyZndh?=
 =?utf-8?B?cjZ3RlkxUkNZTTJUOTJ5ditLS3BNODFOdEs0VlJ0R0orcjIvQmxya1EyNExC?=
 =?utf-8?B?RmN1bEJVSktwMWZyRThvZXR4d0I1ZytSbklHVU91aDRFYUhMVXEzVHRONGVK?=
 =?utf-8?B?SS8wUTZsZVdycTkvWGg3d01jeEwrM3BNUnlLM1NEeloyVnJjMkdQWEdkNGFs?=
 =?utf-8?B?SkRPdEhsT3FDdllocDlCckdScmVVL09hV3d0WXNvL0pmNHhPRGI2YUt4cm5n?=
 =?utf-8?B?ZDh4RTJEVlZLaUdLLzZhSHpEUUtFSmtnamsvbFFPMmUvUXdrcUlvTTNlSi9s?=
 =?utf-8?B?dk52RjN5WHNQNXowcHRwS3RuNDZjWVNvMUY2RzF3ZDBMRmNqc0RrTmdaT3h2?=
 =?utf-8?Q?x6Hw1+64Wgh5uiaeUyeJ7Y9Bc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f7ada5-d386-4cf4-d282-08db8f94ca4c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:02:21.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N8+tGSa3URDwdNGWuLENdPpeGpfVlTNW0ouJOSoEuAsCHhN7mbR94EUJPPfTa2tleXN7Oc/3HOcEzDmDqXQWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6729
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/25/23 22:19, Davidlohr Bueso wrote:
> ... as is the case with all members of struct cxl_memdev_state.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/cxlmem.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 79e99c873ca2..083c6e58bc49 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -434,6 +434,7 @@ struct cxl_dev_state {
>    * @next_persistent_bytes: persistent capacity change pending device reset
>    * @event: event log driver state
>    * @poison: poison driver state info
> + * @security: security driver state info
>    * @fw: firmware upload / activation state
>    * @mbox_send: @dev specific transport for transmitting mailbox commands
>    *
