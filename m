Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F86EC0015E
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jul 2023 18:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjG1SMZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jul 2023 14:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG1SMY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jul 2023 14:12:24 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2FC1724
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jul 2023 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690567943; x=1722103943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t2IY/LCpnzx89Utb09PEteKGL9dQgkctGD6/hv2nnGE=;
  b=HMShVeraKXZKZrC8e6k9rtQ1XDVfIIiM9s8RUWclSk58zQB3RKtyHmJf
   BS+2RObBwSOq8RUsOCOVdcgT+VR7OUTVe2WexzlgR2nuJWKLNj8YfkUS2
   54FQBrvvkcnjf9kzGmomA/B3SMrkJLasVnK1YPln3efcvNtYno5OO5HZW
   zZd37njurPgcch8PxccMdyFdpVI5UuSrWXq0cxmgNmM2CA2724yFcOVMN
   p/7Ccf+DKz1bafrJCIadT72oku4PdjeeKH8KLs4dqWRQB3jidWiqdVhnr
   nWMqiRas8cZP1pha5Ke1n7u8QlLfM6EDXRMTTUld6cU7vT3SvlfS7qDnO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432467005"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="432467005"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 11:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841400400"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="841400400"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 11:12:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 11:12:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 11:12:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 11:12:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 11:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF1A8ah6NvT45zPqgnhcbEesk3bH7pSk+oKkEZQAxrQCrbVhTpbu2MqIZrKSDHoYALjCpOTNZ51Igf1LOgJJG2HXCjQhqbtAVMF3fn/bsZ1GsA0mYdWpAbKkZ8ENB7W8gRAVlS31COgjh69GRDx4Au0cKraP5g0dtz7iWk9wKTR7OtTTkYfzaH9OXRVVJHIsxBW0ldMoOKoHlNIRfZqhpbi0TOS4x004/cg5oIFaEwbnWczFf9dhGxHu21242RPW18mbHez7sKN74St0ARKCtYjy/1VFHzpWmogoft9zip2idjm6S0jAlqmI+L7JAY3T1nc9bgAhxh0kRe6tnxKDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19bmqQy9j9qtzKDt+Xei4tfPOaRVMMSair8y71IRiq0=;
 b=Aeo28NG3en1q5tb5dJQzGSMMVM0kZw9hPJq3Rv4nENmhbxC4w1c+0AmgmkSOAAt8ClSMpb0NHoov7o1MczvY4RMRymU4KQnJnPCpemkR7MriWoK9jqp/kRoJPoBXmUA8aCzjjK7WPHNnOTCVmjwYiClXZSsawgiPVo9STT/YK+x9+eAqy8pxfW4fWRxV98RlC4z7Yti35SkWgkVUeyEXaVrB3WD7fgMTDmDzYjORo/gpPQ6E0oDn8+fNlq06D207WfO3fIoiSzg6fGlTPT7xQqCLAmf6qWYbNTZHzXLRkz6i31ZMAt0JwWOWbmDMJoGew9Ar5HbrifINsSHe/MVUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:12:19 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6631.035; Fri, 28 Jul 2023
 18:12:19 +0000
Message-ID: <c0dfc440-9f58-90ae-4233-bdb3bd5681ea@intel.com>
Date:   Fri, 28 Jul 2023 11:12:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 3/3] cxl/memdev: Only show sanitize sysfs files when
 supported
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <jonathan.cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230726051940.3570-1-dave@stgolabs.net>
 <20230726051940.3570-4-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230726051940.3570-4-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ab8b5d-99e5-4031-f96b-08db8f962e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGOTVCSuIA3RicaHpy6H6fGkQ9BZdVf2HX0esUy2SOGb95+F3T4V8aqAqj8TCYocAiJUtIXIYJb6V9mci9grjQ9fgOAJWkgP96lP2wrdOJLK8xgM20blQd2bWV4gSeq9DqJJfEmYx1tHIm3I9YTJLk8e564w7ZTadZo790vNTG+npVc79E25wPiPsJuwJ5pG3LMokxAnsCj4Nkt1Wmj1a5BSTUERs7H0D5PgGJ1F8vF5p/zMzvjxg651pu/vxynuzDBL2IOSE45RyoJRR6PyHoc6DEdxU1YcqRtkQnq/iFNst3u0qQQrSbD0/m6LNAvgwD4gcqWKZAtLwCvic9hY+yDFCmnbtBAyIaRJ7WsSZANVJVISsuZDdTkbZDFJfvSoFt+RHW/oXjSBOWLd2UacydSmuPr1XJoUDxajVW18fnv5KaVSIHjAxQxvVrUrzAbFapkaGrFyX83jhfp1LUIue+yI2V9QFdL5VDD6eQiMYhwpvXXHYTjqYlWSLaggjbrH4GF+L1o7UVdyvxf3S3s6PQ+9BBFAqW2zIufs984/spxH6OD3JUnQqaUrUzT+yNtddeZ2q5YdJ6fYA00sNqlYiSejse7xZAFgLMrVQ+ttI2p/rsCdlYl/wM0iHW9T71fak3oXtOUY1DmplOHWPwnA+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(6666004)(478600001)(82960400001)(6486002)(83380400001)(53546011)(6506007)(26005)(6512007)(66476007)(66946007)(66556008)(38100700002)(6636002)(186003)(4326008)(31686004)(2616005)(5660300002)(86362001)(44832011)(41300700001)(316002)(2906002)(8676002)(8936002)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BSR2RNRkxaWkNiMlozWkt5ZkZRTWhnNVlXb004alpuMFNOUlVYK2RjVmYx?=
 =?utf-8?B?di84TnlMMkNwYXVaVkVCY1ptL3l3T0VjeWlQYkRCWmp3U3Y2M2l0WHZJZzg2?=
 =?utf-8?B?d2FxckFTVWJ1QnVsOTdJYld3Y1VBVDBWTFg2L2tQd0loYmFod3lhdVJMMnFN?=
 =?utf-8?B?Yk4wVk5nYkc1bGMzU282MG9XanRlMkQwZ3hPNjB2SGxmeWZpSFRUNEJjZnBy?=
 =?utf-8?B?Q0xzdXNVNE85ZW5sd0JkUnVYamFaZnNGWVp3Ky83UENqR3ZoeDBISlRHQXp6?=
 =?utf-8?B?RVdDSGlBL21HSnAyaXJHVW1Hc0htbDhrZXlmTG5YN1E5UlRqVkRjNXhFeExQ?=
 =?utf-8?B?N0NJbGJMcnZwenZIc3V3eVV1WG1GYVA2TjhTNTJidjN6SFYrc1g0TU1qL2Q0?=
 =?utf-8?B?N3pnRk9ZU0ZlL3VoMlBqZGtyd3VkRjNBaVZXQy9LK0xoYVhWZTB0dVVEVUhl?=
 =?utf-8?B?dkkybHhqKzZ5aXdLd0ppdFhzMXlUTUMxa2JWY1Zsd2dJWUZOSDBsT2hTb1Zu?=
 =?utf-8?B?VUlFWk93UEEzUjZGNjFXQVovM0N4N28wWmNRQmhzbk9JSnoyMWo0WFJCRENk?=
 =?utf-8?B?SmlnbklkSGc5MThmaS9rL0loaHExb2JhenNHSndPQjJiVDAvL0pDM2s0S0FM?=
 =?utf-8?B?N1BNQUoxazhTZEMzMWo0M2g0L3VYemluQlVxN0hTUDQ2OG8xVkJjcjgwS0Zl?=
 =?utf-8?B?QzRQMUgveXBJOHNCeVNvODkreFUxNjFlcU9tZDMzT1drT2RGT3l0UEdCSWho?=
 =?utf-8?B?cU5NSHlWWnZwRm5PMFJGSWg4cXlKamNLRUd4RVNBYkVUNnlIaVJoV0hHczZm?=
 =?utf-8?B?RnRxS1FZZ2czTGQ5VmtRY0RxSXhZRXBmMVlWREw5SWIwU0kwMDhLWENaUnFY?=
 =?utf-8?B?eW5aZkNwNzFLNjk4VEhhb05pVC9MTDNydjJ5c3gvQTNmRWRUOWtMVThzVGdF?=
 =?utf-8?B?cVdiVEpiTVZsRHVCVy85NkM1ZmdNNW11SDNPWXlwNStqcXNnVklVVSt1V2Yv?=
 =?utf-8?B?SUNyWStURlNRZzlzbVg2dTV3QlZuczl0d1Z6Q0pwVUZweVNhVFliVXNhMHF6?=
 =?utf-8?B?UXJqQUd0eE9BbFNxbTRkZTNzekhMN1VNQXU3SytGNEdCdThHSnFQNUJVYTRF?=
 =?utf-8?B?UUFtbmNMNmxBczF1MEt4Mm1SNFRuV0tsVVVBWEVLQmdhTFd1d3F3Ri9iNFdZ?=
 =?utf-8?B?RDJqUUlVYlNrcTNKalo2L1pEZnY1S2ZiRFFRaldTdTVLVVA0Y1BwQkpkV0NV?=
 =?utf-8?B?eXducmE1OXRDQzJ5VFhSYnN5dzZuZWhkS2djRncyK1NvQmQ0SGpUOFVsZjdF?=
 =?utf-8?B?Yk4vbkNobUhaQm5QQld4ZFVCdk9va3JKcUhBMXVEYjZocFkrd3JqbEgvNllS?=
 =?utf-8?B?TFRLenFuNm8rWUxwUXIzdFhjWjI4Z3FVTGN3SFNmVndKVUduQjk4d1Z6R2JE?=
 =?utf-8?B?VTJDV0d5andNR2dCWWdhc2FLWTJZR2dYU2k3NHVVTGx1Wk5xZ294eFpRU2lK?=
 =?utf-8?B?K1JuRk15TW0xVUpVTVFEQitZemVOWTMwN29aanZBL0tOT2x0TEJmUHFFTzNK?=
 =?utf-8?B?RExCNXVGQ1ZXZWNxTy85dVRZeFYzeFlQQVJiYjRmVW5teDZrUi9HY3FVMXhP?=
 =?utf-8?B?SjE2VEdXdVNubFIvR1dJQklQd1dTM1c1Ly9pbEU2K3RiQ2J1ZGVPck1HbmV0?=
 =?utf-8?B?dWZhRi92Q2FYYXppeDAwZHZ6MHFPOHdTaFNTdkVmbHJsOUx0cTVGVDk5Z1VK?=
 =?utf-8?B?RU5Rc1hqdWNBZEwvWXJjWER6V09Ka1NFeDlZUHNITloxMWc1ZDN5ckNHQUFs?=
 =?utf-8?B?TjFBWHZRYkozcWxRczV1Z3lGRE03bWRWM1hCbXMzMzRMeVJ4NGNJcW1XSlFD?=
 =?utf-8?B?T0xZM0J6elNxbHFuQUNiNHp4Z05sRm5GWmxxTGRHbStwNFVpdklEMDBNK1RM?=
 =?utf-8?B?WXJ6MnRTRlp5ZTJHeERWeWxYT3VxZDVXaHdNS0RXUHIvSGpuNW5YbzhLdFh5?=
 =?utf-8?B?VDQxdW5xTG91Mkx5czd5RDduUHJNdWVKZlhJKzNWMEVndjdVMm5qbEsvZ0Ny?=
 =?utf-8?B?ZDc5cVVvblNCU0srMCtsUE1uTnhrODNiUDJ2cmk1enJ1RnhzVlZGek5PRDRB?=
 =?utf-8?B?cWtLYXR1Kzg2ZHVHN2RIM3N4Q2dZK0JMeDVCdDVPR1lDVXRPaUJ5SkRqbDBv?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ab8b5d-99e5-4031-f96b-08db8f962e6a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:12:19.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4B+GSUFQ09591Jm0UuQvQkiMQJeLpxkWOD/IpgyJqLVeh+/H8Nim9agVLz6ARk3eLMkWm6KITVglkBGzm8Ebg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/25/23 22:19, Davidlohr Bueso wrote:
> If the device does not support Sanitize or Secure Erase commands,
> hide the respective sysfs interfaces such that the operation can
> never be attempted.
> 
> In order to be generic, keep track of the enabled security commands
> found in the CEL - the driver does not support Security Passthrough.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

LGTM

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   Documentation/ABI/testing/sysfs-bus-cxl |  6 ++--
>   drivers/cxl/core/mbox.c                 | 45 ++++++++++++++++++++++++-
>   drivers/cxl/core/memdev.c               | 19 +++++++++++
>   drivers/cxl/cxlmem.h                    | 15 +++++++++
>   4 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c4c4acb1f3b3..087f762ebfd5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -86,7 +86,8 @@ Description:
>   		HPA ranges. This permits avoiding explicit global CPU cache
>   		management, relying instead for it to be done when a region
>   		transitions between software programmed and hardware committed
> -		states.
> +		states. If this file is not present, then there is no hardware
> +		support for the operation.
>   
>   
>   What            /sys/bus/cxl/devices/memX/security/erase
> @@ -101,7 +102,8 @@ Description:
>   		HPA ranges. This permits avoiding explicit global CPU cache
>   		management, relying instead for it to be done when a region
>   		transitions between software programmed and hardware committed
> -		states.
> +		states. If this file is not present, then there is no hardware
> +		support for the operation.
>   
>   
>   What:		/sys/bus/cxl/devices/memX/firmware/
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..ca60bb8114f2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -121,6 +121,45 @@ static bool cxl_is_security_command(u16 opcode)
>   	return false;
>   }
>   
> +static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
> +					 u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_SANITIZE:
> +		set_bit(CXL_SEC_ENABLED_SANITIZE, security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_SECURE_ERASE:
> +		set_bit(CXL_SEC_ENABLED_SECURE_ERASE,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_SECURITY_STATE:
> +		set_bit(CXL_SEC_ENABLED_GET_SECURITY_STATE,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_SET_PASSPHRASE:
> +		set_bit(CXL_SEC_ENABLED_SET_PASSPHRASE,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
> +		set_bit(CXL_SEC_ENABLED_DISABLE_PASSPHRASE,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_UNLOCK:
> +		set_bit(CXL_SEC_ENABLED_UNLOCK, security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_FREEZE_SECURITY:
> +		set_bit(CXL_SEC_ENABLED_FREEZE_SECURITY,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
> +		set_bit(CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
> +			security->enabled_cmds);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>   static bool cxl_is_poison_command(u16 opcode)
>   {
>   #define CXL_MBOX_OP_POISON_CMDS 0x43
> @@ -677,7 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>   		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>   		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>   
> -		if (!cmd && !cxl_is_poison_command(opcode)) {
> +		if (!cmd && (!cxl_is_poison_command(opcode) ||
> +			     !cxl_is_security_command(opcode))) {
>   			dev_dbg(dev,
>   				"Opcode 0x%04x unsupported by driver\n", opcode);
>   			continue;
> @@ -689,6 +729,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>   		if (cxl_is_poison_command(opcode))
>   			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
>   
> +		if (cxl_is_security_command(opcode))
> +			cxl_set_security_cmd_enabled(&mds->security, opcode);
> +
>   		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
>   	}
>   }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f99e7ec3cc40..14b547c07f54 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -477,9 +477,28 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>   	.attrs = cxl_memdev_pmem_attributes,
>   };
>   
> +static umode_t cxl_memdev_security_visible(struct kobject *kobj,
> +					   struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (a == &dev_attr_security_sanitize.attr &&
> +	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
> +		return 0;
> +
> +	if (a == &dev_attr_security_erase.attr &&
> +	    !test_bit(CXL_SEC_ENABLED_SECURE_ERASE, mds->security.enabled_cmds))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
>   static struct attribute_group cxl_memdev_security_attribute_group = {
>   	.name = "security",
>   	.attrs = cxl_memdev_security_attributes,
> +	.is_visible = cxl_memdev_security_visible,
>   };
>   
>   static const struct attribute_group *cxl_memdev_attribute_groups[] = {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 083c6e58bc49..f86afef90c91 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -244,6 +244,19 @@ enum poison_cmd_enabled_bits {
>   	CXL_POISON_ENABLED_MAX
>   };
>   
> +/* Device enabled security commands */
> +enum security_cmd_enabled_bits {
> +	CXL_SEC_ENABLED_SANITIZE,
> +	CXL_SEC_ENABLED_SECURE_ERASE,
> +	CXL_SEC_ENABLED_GET_SECURITY_STATE,
> +	CXL_SEC_ENABLED_SET_PASSPHRASE,
> +	CXL_SEC_ENABLED_DISABLE_PASSPHRASE,
> +	CXL_SEC_ENABLED_UNLOCK,
> +	CXL_SEC_ENABLED_FREEZE_SECURITY,
> +	CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
> +	CXL_SEC_ENABLED_MAX
> +};
> +
>   /**
>    * struct cxl_poison_state - Driver poison state info
>    *
> @@ -346,6 +359,7 @@ struct cxl_fw_state {
>    * struct cxl_security_state - Device security state
>    *
>    * @state: state of last security operation
> + * @enabled_cmds: All security commands enabled in the CEL
>    * @poll: polling for sanitization is enabled, device has no mbox irq support
>    * @poll_tmo_secs: polling timeout
>    * @poll_dwork: polling work item
> @@ -353,6 +367,7 @@ struct cxl_fw_state {
>    */
>   struct cxl_security_state {
>   	unsigned long state;
> +	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
>   	bool poll;
>   	int poll_tmo_secs;
>   	struct delayed_work poll_dwork;
