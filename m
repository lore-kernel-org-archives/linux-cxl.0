Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686C1EB64D8
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 22:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjFNWx0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 18:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjFNWxZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 18:53:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264992110
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686783203; x=1718319203;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CO1njj9YykAODN3q1SC8rhGV9dHFozxFsVfsSHntG8Y=;
  b=Rp12PL1fXGiVcwIj3LzOSpo7qERVvp2lCtlv5UybAr8ZYWngIT9z5EMr
   FQQ/+dNPa8iOpjCTvCkmLNdr3XcZhglq7q8c6Gd9aN638zbbBROnTxxEL
   eMI0iiNOcOCFyLbfw4FDn8EPlTmxMDn+OhreVV+O/MqGtdHns+syJ+r0C
   vZnsUhMi0UdNXlQ4YlNguI+HFc/+LcxuoqGkVN3G0jqkcAAK/sBvZ1JXn
   wxzqDfKcyqM/Pes8nBfBa5AJFBHp5M2LZnhtVJYu+k5qVyyX1ejwwRLzV
   GuIGXsjNKjvUn2Ecq9mliPzMEWGI8YncJYihlWM7H2R+YxrnRNjY+rcd1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362131255"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="362131255"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 15:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="958954344"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="958954344"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2023 15:53:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 15:53:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 15:53:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 15:53:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 15:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faSp92HZIeqFXEE/GRN463Vs9TWvYGDna5gw9f67YFhDolIBEPxFRscknQRxLgobKBPYPosCil555Xvmz6HK9am1U29Q97hF989vfLv2/9wruM4xxHN7/RXvqSN8pm6KCGjAtKoEsd4zw6DMDdY1QFSxK6FRcfCHmhazGd26xwqpwX1kvOU1WdW6yZivDcUNFHSXdDJrki6R2ndfunlDfp+711lRwUchlKgFB+LQ/gxxBMcigmPoFaIuAFZhbhdutG8vqn9c2cLoPgEtEJyvFk/binMfPr9hWGOvCUu/rCC0wadH9WMwwEo0JIeoojhUp1DRXCLJU4Z01m+yxi0niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DLCFgwcY5IBFj2gHvsfB2vdnNXsMoSxMVBlw81PM6E=;
 b=l/A/BM7Y+WEVxVhjAAksew1YofpPE5kCPxCcPJmG3Q/Kt7l7E5Qbr4ZpQ6kMUh539+F10uqGvcLOPwWPSiJtZrHyFPVrgItfEXTK7IuQhw0MnmK7HR4eqCmyM4d0fiziC1AImtTvKUSv8wIa6DuU4XQkrJuKY8Ee4ItMyVTDvOHwojw1az26y+fRO6N3nHhm1zBzSnfYEEhunUzHXIZlHTNd0jJDxq4zoqZW/osjoT5P2S+lZSBSCdPpNXaKDSmR68kyFSoVZKKs74JJpnnj2zAKVfznkPuqsCi/hfaVucZlB3I2AroUE7b7CrqfhfjYFE1YFwYlw5I4j+OliI4v6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB7928.namprd11.prod.outlook.com (2603:10b6:8:fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Wed, 14 Jun 2023 22:53:19 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 22:53:19 +0000
Message-ID: <6ac12e10-3ead-a417-968d-cba06ec77d48@intel.com>
Date:   Wed, 14 Jun 2023 15:53:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from
 the device
To:     <ira.weiny@intel.com>, Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb8ff9a-e59d-4f87-8b7c-08db6d2a257a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghR9TPcega75sz5d5pVaCu3my8IOdfqc4ZqhIWLYNjODjWgT4d1cNI2X+rZP4dTIelN/u9jj+g9BjdRYA45IbLT3TOvR0pf30UEeHAA58A4x3NjNR9wV9FODNrjP5hOsyjgzo6NcV0cIMQr9Jy6MvjE72mMRWqwrb5AUyhAHV7FMr7gSlMkRIbGFCdpB9fHqOD1UrGGFENjOdwTm8Cgy30yuBC6FLgFgBMi2sXAQM7gxmd73APPn7bA3ovwOHOH+Moc6u+GwQ/Pryi80gEEAq+jYtcaNT8IvQjkHuFJaRnRbl6ecicteVfkerPLA+OhXzcl56cL/3WgoZTP/A4vN2CTY11OxNk0Q1x59bUUUFX/3g2feW0GFQ1v/LfiHEspjpH4d4cK6LnK3n0q8WWRT6GHRPmrwGScWr1hFQL4/Gm5399SC0P7DN9m7MzZoXdKuEexCY5NuE+Vljswxk2Mvu76sGStfC3dro34VnJe/o+dH+G/jbpPNaSaQTESdqCikR+x79+nTS19Ty3Oa9GoB9fJ3JrnoP0RqXJaGICIuVnDLnT/RRPc1k8Kk87RdUJkU2i5Ce/1K7roVTyuDeVr+a18wQjGNh9tKtBPDjTa2hvAgDBFruooelBGIztjTolh1GO4XA2pSR8R7Nh7dLNM69Q0jxrznBQHZbaZ14tKGmLxK+4RGwSW8MVO+TnqrnkH2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(8936002)(8676002)(44832011)(5660300002)(31686004)(66556008)(66946007)(316002)(66476007)(110136005)(30864003)(41300700001)(2906002)(6666004)(478600001)(6486002)(186003)(26005)(53546011)(6512007)(6506007)(83380400001)(36756003)(38100700002)(86362001)(31696002)(2616005)(82960400001)(461764006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXF4STQ4RlJ4MExYLzlBR0RMamcwd1ptQWhQcWErdXJlVHBTZXhDaUJhaEVU?=
 =?utf-8?B?bmNaSXc0cG1oSTR2K1FSWnVjaGQ5VGI1bTUyZmJqVWQ1TW5Ob0dDditrcWIz?=
 =?utf-8?B?VHhnb2c2b0pSR0NvMzdRTHIrYjdsbEtlSzlkNC8zTS8vNFAvaS80SWZJdG9O?=
 =?utf-8?B?MURPT1RISnpyZGlwZGRyeTBUVU8rVmx5VzZaV29WMzA5ZDBMVjYveEh4V1JT?=
 =?utf-8?B?L2NUNWgxQlNvS2M3VytZODV4U1FuVDlUalVZVWZpRlhEdUpmUFJtUWk1bWsy?=
 =?utf-8?B?c3FIekNzcDBxWldhUUVneDl3eFRSSjlLTzdXQzk0SjZkZkVoS1RiQTEvL0Nu?=
 =?utf-8?B?WXhsQVV6SjFYRVpLWG1YTFRyV1hYY25Ta0tGbWdEL1JBazZDT0pOTURER013?=
 =?utf-8?B?dEIvOTBiaVI0S3FEV2EvM3NqdTVsK1F6cll4SzRFOU9qUnprTGlBSHJTZWV3?=
 =?utf-8?B?NURWV2UvUWNERjNVTHl5a0ZOQm1PODIyT1BVMnZ5R2hTTDMxQUVraW1FZ3NJ?=
 =?utf-8?B?WXQ1K2xLdWRwTmllOWZhNjU2WTRuV0RpMnBzb1pYMFcyMFJLQXVkTzNpTWU3?=
 =?utf-8?B?ZWRVTytYeGpzd3BhSzlWbk94QzJtNmpQUXhITFo5Ly91RGIweDZLeHZoKyt2?=
 =?utf-8?B?R2svWmQ2RGVWVEFCclUwbUdtdHJjZlRYcGRUc3RxbWxZVGVIR2lqd1k0UmtS?=
 =?utf-8?B?Wjc3SjdranJod3R2OWQ5SjZheUc2WGFSSjNZdmpXTW5hUUpUMkhpTVR6TWl5?=
 =?utf-8?B?UEc3YnVoaHoxR0tqa3ZJUWlSc1pCUExrU080MHMyUmxsM3FPV1c0Znh0UzlN?=
 =?utf-8?B?dGpwKzBSclN4Mmg2MTQ5WnhZaTM1Y21BSktaYkY1WU52RzNlK0NqcmNDUC9z?=
 =?utf-8?B?KzJETzhqbkMrNUJZR2pFV1ZzZHdCTUhWVUI2Q3JaYzVvRU00c214NUdic0Ur?=
 =?utf-8?B?V0UrYzNKTGc0emhlSCt5N2NjeUszZHFNNjUwTVhRVHVhVmhsdUpkUjZFMWsw?=
 =?utf-8?B?Z2VBWElncUVScFY2SnZMaG5NVTRPUVdaam1jNTRkWk0vTkkvVzBiTWw3Y2JE?=
 =?utf-8?B?dEVWUFRFMVh5VStrZWNJQVJaQVVlTG5Cc1hZbUljYUtVSVlEZ2x0bHRXSHEv?=
 =?utf-8?B?RDJtRVl2anZrTHZUUXlQYmoxUXlnVW56WXpnS0c0MlNHZEQwZDNNYjdURVpY?=
 =?utf-8?B?Rlc2THdWTkp1ckpvTlhIb1BvSzIzL2VXdHBGVUptaUt2emhGVW5KVkF6L1NX?=
 =?utf-8?B?SFRXK0xYR091b1M4OU5nUGVIRWRaOXNYOVR1VEZ2bzRXdkI5UlpZTmFvUjEz?=
 =?utf-8?B?VXRML2NQTFFOcmtRcUd5VUZIaGdsY0g0QjlWVllaNVlVMnRlK2tSemxqc1ND?=
 =?utf-8?B?dkhDaXBaRzFTWHMzdXBKcFgycTFpOFpyNEt3K210cGtJdW5xQ0NRTTBXMWJv?=
 =?utf-8?B?Q011NWlZSHRNbDNUZnhscWFnZ0d5OU1oV1dFdUJVVTdGeFdVT2VHaStwNCtW?=
 =?utf-8?B?WmFiaysyd1dBaCtUUCtScFpQZXZjOStYSCtRa0VKaWdRMWZwdDdpZzBvS21y?=
 =?utf-8?B?M25lT0ppWFVZdjcySXp3ZmJMSDBWcWZBZkVDSXpaSXhEK0FxNkNlVFgwMEht?=
 =?utf-8?B?OStydlptYVJpdGpjMWlFbHZWd3lOV2NPODFkTm5vZlByN21SSXRzTXFZMjBw?=
 =?utf-8?B?eld1VTB4TDZSS1huZFlVcWU2Nmg3UjNUdlVzZ3pqcHFlbXEwQjN6SHdzVGM2?=
 =?utf-8?B?dDdpN1ZnOFlFSXhXUzZwZDBZM1hCNEtpcWU2dmN0cnhIeTJocEFtODJtdkU4?=
 =?utf-8?B?bmtMZE1MQUdaeGlYSUVCejNhVi80V1UvbTJQa2dMM3JVMkFnelB4VHdQcDc3?=
 =?utf-8?B?Z3FIU2lrTlJBMzRVaGt6eHhqZ0pHd0dweHVjL1dWU3ZUQ1ZkSG52eU9HaXIy?=
 =?utf-8?B?dDJXbWpOaGZMMGsvSDdpV25PNGxpa1NsT3luUFVsbDFwaWdLMmxFT1o5QnNh?=
 =?utf-8?B?bnlRRitKMHk0YlVjbnJYeGFYZ1B3ZHZ4MnJseG54cVk3STIzNzlkcHlGWUZw?=
 =?utf-8?B?bndWeml4Nzg5WDUxZWgwL2FYRng3KzdGMitrVnh1RmNqLzRrU1ZrSVNOL2ds?=
 =?utf-8?Q?HGi85pP4ayWP2qa5SdP5DtsdM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb8ff9a-e59d-4f87-8b7c-08db6d2a257a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 22:53:18.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DnrD3pSEOTIFEMtxDWqL2dzdsttVRnQoOSb0J4xhWt57SN3iOlJBM8Zpdy694c8CQMj837iIcP5ftgmC4JgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7928
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 12:16, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Read the Dynamic capacity configuration and store dynamic capacity region
> information in the device state which driver will use to map into the HDM
> ranges.
> 
> Implement Get Dynamic Capacity Configuration (opcode 4800h) mailbox
> command as specified in CXL 3.0 spec section 8.2.9.8.9.1.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> 
> ---
> [iweiny: ensure all mds->dc_region's are named]
> ---
>   drivers/cxl/core/mbox.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++--
>   drivers/cxl/cxlmem.h    |  70 +++++++++++++++++-
>   drivers/cxl/pci.c       |   4 +
>   3 files changed, 256 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3ca0bf12c55f..c5b696737c87 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -111,6 +111,37 @@ static u8 security_command_sets[] = {
>   	0x46, /* Security Passthrough */
>   };
>   
> +static bool cxl_is_dcd_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_DCD_CMDS 0x48

Move this to cxlmem.h?

> +
> +	if ((opcode >> 8) == CXL_MBOX_OP_DCD_CMDS)
> +		return true;
> +
> +	return false;

I think you simplify by:

return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;


> +}
> +
> +static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
> +					u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_DC_CONFIG:
> +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_RELEASE_DC:
> +		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>   static bool cxl_is_security_command(u16 opcode)
>   {
>   	int i;
> @@ -666,6 +697,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
>   static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>   {
>   	struct cxl_cel_entry *cel_entry;
> +	struct cxl_mem_command *cmd;
>   	const int cel_entries = size / sizeof(*cel_entry);
>   	struct device *dev = mds->cxlds.dev;
>   	int i;
> @@ -674,11 +706,12 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>   
>   	for (i = 0; i < cel_entries; i++) {
>   		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> -		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> +		cmd = cxl_mem_find_command(opcode);
>   
> -		if (!cmd && !cxl_is_poison_command(opcode)) {
> -			dev_dbg(dev,
> -				"Opcode 0x%04x unsupported by driver\n", opcode);
> +		if (!cmd && !cxl_is_poison_command(opcode) &&
> +		    !cxl_is_dcd_command(opcode)) {
> +			dev_dbg(dev, "Opcode 0x%04x unsupported by driver\n",
> +				opcode);
>   			continue;
>   		}
>   
> @@ -688,6 +721,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>   		if (cxl_is_poison_command(opcode))
>   			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
>   
> +		if (cxl_is_dcd_command(opcode))
> +			cxl_set_dcd_cmd_enabled(mds, opcode);
> +
>   		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
>   	}
>   }
> @@ -1059,7 +1095,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>   	if (rc < 0)
>   		return rc;
>   
> -	mds->total_bytes =
> +	mds->total_static_capacity =
>   		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
>   	mds->volatile_only_bytes =
>   		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> @@ -1077,10 +1113,137 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>   		mds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
>   	}
>   
> +	mds->dc_event_log_size = le16_to_cpu(id.dc_event_log_size);
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>   
> +/**
> + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> + * information from the device.
> + * @mds: The memory device state
> + * Return: 0 if identify was executed successfully.
> + *
> + * This will dispatch the get_dynamic_capacity command to the device
> + * and on success populate structures to be exported to sysfs.
> + */
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct device *dev = cxlds->dev;
> +	struct cxl_mbox_dynamic_capacity *dc;
> +	struct cxl_mbox_get_dc_config get_dc;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u64 next_dc_region_start;
> +	int rc, i;
> +
> +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> +		sprintf(mds->dc_region[i].name, "dc%d", i);
> +
> +	/* Check GET_DC_CONFIG is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd: get_dynamic_capacity_config\n");
> +		return 0;
> +	}
> +
> +	dc = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	if (!dc)
> +		return -ENOMEM;
> +
> +	get_dc = (struct cxl_mbox_get_dc_config) {
> +		.region_count = CXL_MAX_DC_REGION,
> +		.start_region_index = 0,
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = mds->payload_size,
> +		.payload_out = dc,
> +		.min_out = 1,
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		goto dc_error;
> +
> +	mds->nr_dc_region = dc->avail_region_count;
> +
> +	if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> +		dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> +			mds->nr_dc_region);
> +		rc = -EINVAL;
> +		goto dc_error;
> +	}
> +
> +	for (i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		dcr->base = le64_to_cpu(dc->region[i].region_base);
> +		dcr->decode_len =
> +			le64_to_cpu(dc->region[i].region_decode_length);
> +		dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
> +		dcr->len = le64_to_cpu(dc->region[i].region_length);
> +		dcr->blk_size = le64_to_cpu(dc->region[i].region_block_size);
> +
> +		/* Check regions are in increasing DPA order */
> +		if ((i + 1) < mds->nr_dc_region) {
> +			next_dc_region_start =
> +				le64_to_cpu(dc->region[i + 1].region_base);
> +			if ((dcr->base > next_dc_region_start) ||
> +			    ((dcr->base + dcr->decode_len) > next_dc_region_start)) {
> +				dev_err(dev,
> +					"DPA ordering violation for DC region %d and %d\n",
> +					i, i + 1);
> +				rc = -EINVAL;
> +				goto dc_error;
> +			}
> +		}
> +
> +		/* Check the region is 256 MB aligned */
> +		if (!IS_ALIGNED(dcr->base, SZ_256M)) {
> +			dev_err(dev, "DC region %d not aligned to 256MB\n", i);
> +			rc = -EINVAL;
> +			goto dc_error;
> +		}
> +
> +		/* Check Region base and length are aligned to block size */
> +		if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
> +		    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> +			dev_err(dev, "DC region %d not aligned to %#llx\n", i,
> +				dcr->blk_size);
> +			rc = -EINVAL;
> +			goto dc_error;
> +		}
> +
> +		dcr->dsmad_handle =
> +			le32_to_cpu(dc->region[i].region_dsmad_handle);
> +		dcr->flags = dc->region[i].flags;
> +		sprintf(dcr->name, "dc%d", i);
> +
> +		dev_dbg(dev,
> +			"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
> +			dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
> +	}
> +
> +	/*
> +	 * Calculate entire DPA range of all configured regions which will be mapped by
> +	 * one or more HDM decoders
> +	 */
> +	mds->total_dynamic_capacity =
> +		mds->dc_region[mds->nr_dc_region - 1].base +
> +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> +		mds->dc_region[0].base;
> +	dev_dbg(dev, "Total dynamic capacity: %#llx\n",
> +		mds->total_dynamic_capacity);
> +
> +dc_error:
> +	kvfree(dc);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> +
>   static int add_dpa_res(struct device *dev, struct resource *parent,
>   		       struct resource *res, resource_size_t start,
>   		       resource_size_t size, const char *type)
> @@ -1112,6 +1275,11 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>   	struct device *dev = cxlds->dev;
>   	int rc;
> +	size_t untenanted_mem =
> +		mds->dc_region[0].base - mds->total_static_capacity;
> +
> +	mds->total_capacity = mds->total_static_capacity +
> +			untenanted_mem + mds->total_dynamic_capacity;
>   
>   	if (!cxlds->media_ready) {
>   		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> @@ -1121,13 +1289,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   	}
>   
>   	cxlds->dpa_res =
> -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> +		(struct resource)DEFINE_RES_MEM(0, mds->total_capacity);
> +
> +	for (int i = 0; i < CXL_MAX_DC_REGION; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> +				 dcr->base, dcr->decode_len, dcr->name);
> +		if (rc)
> +			return rc;
> +	}
>   
>   	if (mds->partition_align_bytes == 0) {
>   		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
>   				 mds->volatile_only_bytes, "ram");
>   		if (rc)
>   			return rc;
> +

Stray blank line?

DJ

>   		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
>   				   mds->volatile_only_bytes,
>   				   mds->persistent_only_bytes, "pmem");
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 89e560ea14c0..9c0b2fa72bdd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -239,6 +239,15 @@ struct cxl_event_state {
>   	struct mutex log_lock;
>   };
>   
> +/* Device enabled DCD commands */
> +enum dcd_cmd_enabled_bits {
> +	CXL_DCD_ENABLED_GET_CONFIG,
> +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> +	CXL_DCD_ENABLED_ADD_RESPONSE,
> +	CXL_DCD_ENABLED_RELEASE,
> +	CXL_DCD_ENABLED_MAX
> +};
> +
>   /* Device enabled poison commands */
>   enum poison_cmd_enabled_bits {
>   	CXL_POISON_ENABLED_LIST,
> @@ -284,6 +293,9 @@ enum cxl_devtype {
>   	CXL_DEVTYPE_CLASSMEM,
>   };
>   
> +#define CXL_MAX_DC_REGION 8
> +#define CXL_DC_REGION_SRTLEN 8
> +
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> @@ -300,6 +312,8 @@ enum cxl_devtype {
>    * @dpa_res: Overall DPA resource tree for the device
>    * @pmem_res: Active Persistent memory capacity configuration
>    * @ram_res: Active Volatile memory capacity configuration
> + * @dc_res: Active Dynamic Capacity memory configuration for each possible
> + *          region
>    * @component_reg_phys: register base of component registers
>    * @info: Cached DVSEC information about the device.
>    * @serial: PCIe Device Serial Number
> @@ -315,6 +329,7 @@ struct cxl_dev_state {
>   	struct resource dpa_res;
>   	struct resource pmem_res;
>   	struct resource ram_res;
> +	struct resource dc_res[CXL_MAX_DC_REGION];
>   	resource_size_t component_reg_phys;
>   	u64 serial;
>   	enum cxl_devtype type;
> @@ -334,9 +349,12 @@ struct cxl_dev_state {
>    *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>    * @mbox_mutex: Mutex to synchronize mailbox access.
>    * @firmware_version: Firmware version for the memory device.
> + * @dcd_cmds: List of DCD commands implemented by memory device
>    * @enabled_cmds: Hardware commands found enabled in CEL.
>    * @exclusive_cmds: Commands that are kernel-internal only
> - * @total_bytes: sum of all possible capacities
> + * @total_capacity: Sum of static and dynamic capacities
> + * @total_static_capacity: Sum of RAM and PMEM capacities
> + * @total_dynamic_capacity: Complete DPA range occupied by DC regions
>    * @volatile_only_bytes: hard volatile capacity
>    * @persistent_only_bytes: hard persistent capacity
>    * @partition_align_bytes: alignment size for partition-able capacity
> @@ -344,6 +362,10 @@ struct cxl_dev_state {
>    * @active_persistent_bytes: sum of hard + soft persistent
>    * @next_volatile_bytes: volatile capacity change pending device reset
>    * @next_persistent_bytes: persistent capacity change pending device reset
> + * @nr_dc_region: number of DC regions implemented in the memory device
> + * @dc_region: array containing info about the DC regions
> + * @dc_event_log_size: The number of events the device can store in the
> + * Dynamic Capacity Event Log before it overflows
>    * @event: event log driver state
>    * @poison: poison driver state info
>    * @mbox_send: @dev specific transport for transmitting mailbox commands
> @@ -357,9 +379,13 @@ struct cxl_memdev_state {
>   	size_t lsa_size;
>   	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>   	char firmware_version[0x10];
> +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>   	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>   	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> -	u64 total_bytes;
> +
> +	u64 total_capacity;
> +	u64 total_static_capacity;
> +	u64 total_dynamic_capacity;
>   	u64 volatile_only_bytes;
>   	u64 persistent_only_bytes;
>   	u64 partition_align_bytes;
> @@ -367,6 +393,20 @@ struct cxl_memdev_state {
>   	u64 active_persistent_bytes;
>   	u64 next_volatile_bytes;
>   	u64 next_persistent_bytes;
> +
> +	u8 nr_dc_region;
> +
> +	struct cxl_dc_region_info {
> +		u8 name[CXL_DC_REGION_SRTLEN];
> +		u64 base;
> +		u64 decode_len;
> +		u64 len;
> +		u64 blk_size;
> +		u32 dsmad_handle;
> +		u8 flags;
> +	} dc_region[CXL_MAX_DC_REGION];
> +
> +	size_t dc_event_log_size;
>   	struct cxl_event_state event;
>   	struct cxl_poison_state poison;
>   	int (*mbox_send)(struct cxl_memdev_state *mds,
> @@ -415,6 +455,10 @@ enum cxl_opcode {
>   	CXL_MBOX_OP_UNLOCK		= 0x4503,
>   	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>   	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> +	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> +	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
>   	CXL_MBOX_OP_MAX			= 0x10000
>   };
>   
> @@ -462,6 +506,7 @@ struct cxl_mbox_identify {
>   	__le16 inject_poison_limit;
>   	u8 poison_caps;
>   	u8 qos_telemetry_caps;
> +	__le16 dc_event_log_size;
>   } __packed;
>   
>   /*
> @@ -617,7 +662,27 @@ struct cxl_mbox_set_partition_info {
>   	u8 flags;
>   } __packed;
>   
> +struct cxl_mbox_get_dc_config {
> +	u8 region_count;
> +	u8 start_region_index;
> +} __packed;
> +
> +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> +struct cxl_mbox_dynamic_capacity {
> +	u8 avail_region_count;
> +	u8 rsvd[7];
> +	struct cxl_dc_region_config {
> +		__le64 region_base;
> +		__le64 region_decode_length;
> +		__le64 region_length;
> +		__le64 region_block_size;
> +		__le32 region_dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed region[];
> +} __packed;
>   #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
>   
>   /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>   struct cxl_mbox_set_timestamp_in {
> @@ -742,6 +807,7 @@ enum {
>   int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>   			  struct cxl_mbox_cmd *cmd);
>   int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>   int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>   int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4e2845b7331a..ac1a41bc083d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -742,6 +742,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> +	rc = cxl_dev_dynamic_capacity_identify(mds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_mem_create_range_info(mds);
>   	if (rc)
>   		return rc;
> 
