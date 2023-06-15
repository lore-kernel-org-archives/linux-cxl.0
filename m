Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06BDEB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 21:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFOV2h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjFOV2g (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 17:28:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B4E69
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 14:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864515; x=1718400515;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/ewLibyep9hjr4s/Q2DBCdg2X/nD7hTnQzbB9MoPqFE=;
  b=hn+Fhv06oYXpk442ApwyVgdJyj+ZikEPATy60j3YDPYaB7Kj/ZfuiOh6
   qJ806zHeYODLwm5UWY05pqSWHfPDi5Ikni79OX7NcO9W3SR4Fq+5Qck8D
   y4Vue6SNZ36qyUeDoet15C8Lacl0DyQIeSQC3EeLDm1g4InQdppA7wrXN
   kjBq6wjueb7xauRqb2eYRzqkoo9UVbLf4TAT5yBk5a0YKJOXffFnzqoqz
   4k7rS6UCyRT6MmTqJ3p9MUYkdSTQt9wksJEyX9JOeTajmPikUDC5+XNZC
   fcLRz87clYN1vxGThaV3Rvydz57oFW2t+yOaENEdTq8aV+amvdzygSXgW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="359048139"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="359048139"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="706835500"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="706835500"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2023 14:28:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:28:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:28:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 14:28:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 14:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4iv5/egImZGYoxa8nqB+r1dN6DM+jC7Hr8xZ9/waaq28FJljBLII8+hvumNxmg7ECLIZlgGtDhwM0hM+WvsLyhQPE8SsNBmonzJlJ0TP94ETknz+vIeiQThMymTwJ7Xk6CNuxrmre1XCej/NHgITOLBG8tf8sVcF1Fuqdl1MFd7OyC+HmdcDAko1t+nnB+YQwmVeY5GGrgXK87AoUGM3YyPF2Iy3Ac8umWuJoC5ykmRSJEaIlSnMLqqS293ElYsnjVMP6MqqrNmyDoSghwcO7z66olk/kEJ3pT69q2oP47C4nMqesZrfW0jx/9MoncvJuaaUrJFogV+uHGFsh4GZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYmWm7LwAZ5aemR/qxBTgs4yeltTDvIuxRN0L0dowyk=;
 b=bd8tN5u/GRAOJ6yLqIbye8raARR57o68SP4N0KdzRwP5cvjEn7n2+65lJH2B75D8HlZJ4comMR4WMA4QNGhfvBh91dDu66DX5jeAdSt3RlzT/SY5nvD67wl7uubLTw+6UFC8SNOgm6Bh7jsAjOpB8vSs7Q5Kz0DkuRMpiQviUDE507wo/VPFhus3h5CAAC8ufUdMKsRT7WKr+xAbzqI+FMY12ioSMI+gt+019bdBw4hcFnZGdoa2Bd2k+hTnIlhaKYq3qZDdcs4QR1D9ErXOO2Pz10BGKkph7e+s2aXnZCbADlAtDGMmM0Z6SWnoeIoqfvpXI04l6xyW6IcNSxtsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 21:28:30 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 21:28:30 +0000
Message-ID: <2d86715e-11f2-901a-0dea-5db954ee394e@intel.com>
Date:   Thu, 15 Jun 2023 14:28:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v2 03/12] cxl: Fix kernel-doc warnings
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
 <168679259170.3436160.3686460404739136336.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168679259170.3436160.3686460404739136336.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::9) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: f5064d8e-28ab-495f-60e0-08db6de776aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMAXlQ5+pRP5Er+0uJcL+ctMlZcifdf2YzZrE72nenlbNj2o+mOKW7jhNO7kWwR7Va4SBaciVSyhKmL49scllIDE1YDMi4M3IK1auVgQQQnJ0PGPVlbu8cJMLwPnQwumKsGuiAQKlV56+LH5Jo7fO9D3xU54unaRowkSuesTGqo8HgC7WF5xqgPfylVrIls7irb/2H2Jbq4lnHawBn1V5PZvqu5y2dyrDfcaz/4P8khbRbvq6BtLqI4BTg966uPlxPmHAkH36i8X+mYyuXDl30VIeFmZ5+ixOL9UahNDhf4YzgFbaMb/v7Uew00DwKCu3GSwPwwoTkhRz4DsfO6LUURMdrx/ghLRiRYjOu77UzRPFrN3lo83Mn6b/HqZkP+IvYn6JXPcbvauRo+9PkEQeKZWFkhwxWLpmtCCkSG+h5ItaRwhlSeVmZ8P0VAMZpzp1EKJ6pQWzOT1QkFx8oD13lbh7/5QLiIl6BOFqbmtfm7W9+jY24JbWhXgxX/EJ/uw2FG86hDPB18yaoXomjqqemo1woYKmt+v31IwsUD24P1YdB+Mb1FLGXl+NgTVU4i5tohVzNgpK9HsiRm+7xMcJrryENgjJzEu2azWAKq7V7fqjYfo58TDFnwHM0tsdzFyBTrw8jq5wftS0wFlZ0Lz1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(31696002)(2616005)(83380400001)(82960400001)(36756003)(86362001)(38100700002)(478600001)(44832011)(8936002)(6666004)(6486002)(966005)(2906002)(8676002)(5660300002)(66476007)(66946007)(66556008)(31686004)(316002)(186003)(53546011)(41300700001)(6512007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rks2U1JUeXpIU3hRa3lLWExmQkdjcm9pSi9uK21VWUM4Q1hHWlZaUnFUUFpH?=
 =?utf-8?B?YytHQlp3dERWYnFGUEVHZEhLVmt2SHcrT3djQ3Y0WWNUZG9JWnhQY2tPSVJH?=
 =?utf-8?B?L3RRNkhGcS9KaWQzVFhlWlJYUEpBWEgyaWhHSS94TjEwVmgySDkwZThnazZj?=
 =?utf-8?B?elRiZ3U2UktmTmxxazJodFloV1RyWlB1YVdNUWxwK1ZYY2JLc1JDUDFFbnZ3?=
 =?utf-8?B?NHdFZisvUFk0MXFxdFZRWnpxaHpkUkRLeWYyWGVLcVp3WVJNbWZCUmc3bmRD?=
 =?utf-8?B?Nm1QaUh3SHBpMWppUExoMEl2RG1HQWRoTUtkdFNBTDc4bkUyRml5VnpQNk4z?=
 =?utf-8?B?OFVGQU9CVGxzeVUxOWo0ajVpaTBqMTBDQkxneTJKTVFsMWcwTlBnZ0hQVEFE?=
 =?utf-8?B?ekRyb1A1Vk5IWkg5b0lVK1MwRjlYanBSbmgzL2ZOQmprMWlpSUl3UFlDVlg3?=
 =?utf-8?B?UkJobjVEd0VkM0JhM05ISXJneDdwdmFtSUNsOXNEU0tXNFZ2Tm9JY1FNQU5a?=
 =?utf-8?B?OURoSHFEYWs4L0F3UCtnWkdnRzcrTWpMdXcrVkZnUG0zSEIyRW9BUmZFVDN0?=
 =?utf-8?B?ZEdRNVo1OGhSYm9DYmdobjhFQUpvV2MvQjU4MjlDWVNycFRXNnhKbjk2YklH?=
 =?utf-8?B?aUVoQUF1S3QwWGlCVFFGMXFWeFAxRzlNa2t0QWF1TUJrazRIdUZlc1hLWjRp?=
 =?utf-8?B?Q25pSlJQTDZGNWIyd2dBQk1FM0lKMFFTYXJ5OWxuYU0zdHNJd2lMOFpjRndM?=
 =?utf-8?B?NHlOWnFyWjM1QzdKMEx1cWcrZldzcGU4a3JwS1NjOTZPZTRDQVpXOUMydTRY?=
 =?utf-8?B?MlBRS2VtaGg3UkJCSXJlMVNaN1YxRzg2V1VndG1UcDJucVpxS2JVUzAyenVw?=
 =?utf-8?B?azNwc2cvRVVQcHh3a1NVMVVHb1ZxUzhINUJVOVZjM1cxVlVLQktwT1YySVRX?=
 =?utf-8?B?bEZaRmtsTnNKcjI3Wk1QQnlzcG00Nm5Vd3Awb1IrNEQ1QitKSDk5czliSGJ1?=
 =?utf-8?B?YUNXSjF1cS91bVlOQmQrN1VZZU9FWkp2bzVuQlNMb1dyNEhNZzhIOWRiMTlt?=
 =?utf-8?B?MTM3cTdmRnp3TTNoM1dhM3ZKOU9XNkt5S1dVa0YrdmJpNFltcitWYUJaRjBU?=
 =?utf-8?B?aE90UTNqOGdxLzQ5eC9qVWdib3A4U3JuUXE1MDhYV3ozbDlWVGE5M2dNemdG?=
 =?utf-8?B?ZnQrZm9hNk1OSTJTOS9jZGdLMFVsQW5pelVieTZ1QVVtdGsreFJwMXRFSEpR?=
 =?utf-8?B?UWthR2Y1NUtJU1hlUThGMlNacWF5b096MEFiTEtRZXBYSS91Sit0c3BFSTJH?=
 =?utf-8?B?MXZpWUJNenVPaFhZZVpEVVg4dmhLT3oyT1phTFkwMUJCTjJSVmNjMVNndUxt?=
 =?utf-8?B?dVNKQkwwSjF1blJ0cHo1S3hoamR5WElvWm92Qk9hYUdUNDAvaU5WekdZcDVI?=
 =?utf-8?B?Q2M0ZWVDa0xMQUQ3T2xQbGVPeHY3czJ2ZmxTVVl5cTJPS0lwNDJXdURtdWdq?=
 =?utf-8?B?MXVwTUlweTFvWU1kNEJ4aHQwUjBiOW9MSjZqcVFGRW8rbWl0VEplbVYwVTBE?=
 =?utf-8?B?bU92N0hRUEVITHFvbkV6WS9XUThGWkcybzl1dCtjcmhzeFhhdW1SVHJGN282?=
 =?utf-8?B?WThVd1FFanBiekc2ZlRjODY5RTJoUlFNZVNQQjJoZnBLanVvK3VJVmt1Ykxq?=
 =?utf-8?B?Qjd0d2JObnduQUo2MWhZM1NzeWlDL0UxQk1vL2pyNkNuaVp2enMvTW1NNG52?=
 =?utf-8?B?ejJ5Um1PK3NsL21SbzJyNUc1eHZFa1BmWHBXL1dQOG94dmZXdkVMaG01WHVy?=
 =?utf-8?B?WlltRU54MkVzMmNDOXlFaE4yV3h1Rk91QmJRK250eUo0bEtYVERCSFc0elp5?=
 =?utf-8?B?eTNlMlR3cTBxekw2MFB3aHFPMCt6RVlPUm1aWVZ5SjNKT0JGeUc0T1RLNzRM?=
 =?utf-8?B?aTJBOGUrc3Y3REFLSDhTYkZYMUtPNkFTYk9tY09GQnNxRkNrdjRZdEdHSnNw?=
 =?utf-8?B?QitYUGNwRmFySHdzZGVmNnZUZkIyWXNRUzFlaEo1cm93Ny9vaUg3c2xxY0Rm?=
 =?utf-8?B?SzI1dzBNdVhIMlhrV1hMRi9JTU9Kb0ErUWMxRVNhcWhubGYwSksvVGROV1k4?=
 =?utf-8?Q?oyjB6OkrkUdDNwfMiV5OucNpV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5064d8e-28ab-495f-60e0-08db6de776aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 21:28:30.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7HGtHo447zSAfs9QlenUORFcxeiKYnkv8e6qa4aO3wUJoCLI9Lv2T2+xQC29QLXSAYusY3cDhd9ucyjNkGQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 18:29, Dan Williams wrote:
> After Jonathan noticed [1] that 'struct cxl_dev_state' had a kernel-doc
> entry without a corresponding struct attribute I ran the kernel-doc
> script to see what else might be broken. Fix these warnings:
> 
> drivers/cxl/cxlmem.h:199: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Event Interrupt Policy
> drivers/cxl/cxlmem.h:224: warning: Function parameter or member 'buf' not described in 'cxl_event_state'
> drivers/cxl/cxlmem.h:224: warning: Function parameter or member 'log_lock' not described in 'cxl_event_state'
> 
> Note that scripts/kernel-doc only finds missing kernel-doc entries. It
> does not warn on too many kernel-doc entries, i.e. it did not catch the
> fact that @info refers to a not present member.
> 
> Link: http://lore.kernel.org/r/20230606121054.000069e1@Huawei.com [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/cxlmem.h |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a2845a7a69d8..8e4ba5b52902 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -195,7 +195,7 @@ static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>    */
>   #define CXL_CAPACITY_MULTIPLIER SZ_256M
>   
> -/**
> +/*
>    * Event Interrupt Policy
>    *
>    * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> @@ -215,8 +215,8 @@ struct cxl_event_interrupt_policy {
>   /**
>    * struct cxl_event_state - Event log driver state
>    *
> - * @event_buf: Buffer to receive event data
> - * @event_log_lock: Serialize event_buf and log use
> + * @buf: Buffer to receive event data
> + * @log_lock: Serialize event_buf and log use
>    */
>   struct cxl_event_state {
>   	struct cxl_get_event_payload *buf;
> 
