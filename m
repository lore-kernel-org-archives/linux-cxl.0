Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D91DC05027
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Feb 2023 02:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBKCF3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBKCF2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Feb 2023 21:05:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56D37358A
        for <linux-cxl@vger.kernel.org>; Fri, 10 Feb 2023 18:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676081126; x=1707617126;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QhSUNACfqPzCNyfwUAV1WtdU/M3OWhUGaBDKOSBYeJM=;
  b=QdtGh8rqoZFPnphi2Asdou2/jcrgszlGQsbTnPKsK29Wzhd462UTAKXo
   t7+bYriIX9BWhFh7OHO9kadN3A36lBfBoeT/wxitD14ZradhiXW4/GpfJ
   xNLoiaGLurVzuFrHyYdSYg4WSesYZyZC0ilgNvZCt1rf0NPKJ3g+hriiC
   jPHndrFQkykNT8Y3oB9u2Cl51KfrWfmm2gjl6MLcVkIC8KQ62BIJSKGYk
   c6e+boQo+JFVs27o0tJuU0GmP3f7hkt0lU5qwlRZFVfZMONsUixfctyco
   wCkoDM6O5f2iIPVZnbQLmVpHYqAFySC15DZmG0tXfvKlXybIOJQ4bC0jC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="329203248"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="329203248"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 18:05:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="661593033"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="661593033"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2023 18:05:26 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 18:05:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 18:05:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 18:05:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caCyFA5dV5EMduDXz7gYQGivhboKXTVF3qrAz8tyZhQm69sztPq4OoN5D8kiwdy4ximkgV0As0r5uqG0vIJjE/ER3inaR4hU+scD9WnlW+Kn1owGBqpA3z+NBnIZOQKj+qWrqKx7RaYg/50JywKq2ilPMo+8E4CGbKwkM6SnmCjAaUe3rLtRbdP5PAB6Zj7U68HpyT1JdnCtoEjeUxzuQR7uYUA1CksdgPsOV2C8auWxkYYA5T+09jVC9uqVjbD825pwY7ttnTM2I9+IE0xuRUfbDHA7z92rAt/bw00o/I2lOqfEz9fO1/Q528e26VkiMMGqEVlhcpqKvh2BhcCaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE+SFiS8Z8ZOhuqoKlMQ68g2oRFuhMYdGE3kjJSMbT8=;
 b=ADUJku2JkTv5DYRorOx2NaEAeQgwj/5xWSe3lsgeNoIfAo9Kpd8grimbK1gLdURAi0tpH9WV9vdnccx7tQVlZhqNXj11m+ljrk96AEGHDtkzEIXbevDSD+dTbXAhPbSq5+owy8qmqYhI51nD4Dvf+8WL5ueZLFRD1zlmQazYoKNCwCGZ75ILut+c6pjzPB2rSGURNRvyabLI8TmL+uEE5x8Uc+K8a0CuiyprMU+bebl9JBRbmwcrVVA2IzUiEQZeE3dB9eowX64gsyfCoBC/KGc2NtgMZBTxLGrO/1MIuSoMaGNMvwe57NcQklPoYjvCSVgJu4UshCqO0x1aQu51Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5599.namprd11.prod.outlook.com (2603:10b6:a03:3af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Sat, 11 Feb
 2023 02:05:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 02:05:18 +0000
Date:   Fri, 10 Feb 2023 18:05:15 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 0/7] cxl: Introduce HDM decoder emulation from DVSEC
 range registers
Message-ID: <63e6f7db4055d_36c7294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: SJ0PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:a03:331::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 4973877c-05cf-424c-8146-08db0bd46bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOwGjpKHRlfT7uqbodrr34D6HYLMNvCFmIYKClrqbg4I0a1tMNNiHAQwFSLL1yZkeHfwDxUh6xu3D1w3LHlBZ1jcpm/IG+RLEK9e3tUyNccnDLQ4XpYg4TKjU+gr7t3v0lD3ki6J6XMRpaXcPuSFt54biwz5Fulyy63gcEKjcX6gJlV1YZrvFkpJZaN7CLnJsL3Xfmfz4sB7Mw56s4d9Hf4HX2BKFpRliB05H42Dll58B5e11NcxgXhbiU4+DClO7BRS0BuGlSVqTntUfz9ogsy3ftjwAZpzHGPkec6Q6NWFMWYhii7XAyxiGiUeLZDpX13OtDyE8h2UH8Wf7IL/J+KVzUYZLHKgss8kb45YlpQL5KYp5MFkrhs5f+qXA8aob73TyhlgKRMaS/Rk0E40GHziKKtxQWLSbuvJIUEw+Zz0v+bIzVnXpgqFj85GXBGzlpen513wdu9q9FleMtlsh6Nu+mYjaMEUol176tvE7HZ0l0RxUJMR2T5qcjzhxdV5Q8290O0nTsnvTrPpSqhu/0psd+U4M9tnuKvGTJcTmK17dHiitWjN4teoB3iny12uj7BLe3V+4VwC6u8rCVhmwq/M8yzaYvgnZuXnBa3zHYac8koURlTPEmLaH04bXIQeAFCxY3LOauU+M+2OSup1w5D1FMiHgNakfHlvfdxFp3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199018)(6486002)(966005)(8936002)(478600001)(9686003)(41300700001)(5660300002)(26005)(66476007)(6666004)(6512007)(186003)(6506007)(316002)(4326008)(8676002)(82960400001)(66946007)(83380400001)(38100700002)(66556008)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRlakx2Tmc5U1U0SVhoLzAra0tGTWRFUWhvT1Q4Mm5qOG0xTi9WQ1E1R3N3?=
 =?utf-8?B?VHgxV1o3bXpFZjNGMUgvN0prZ2dpUU9EOGFUZ0N4cnRXN00xbzNFWVJFck1B?=
 =?utf-8?B?UTcrMjBDbk9kWHFNcCt2cWw2YzRaNEZxUTI1eVVPRTdZREhDVmY0RE1pQ1hp?=
 =?utf-8?B?U0oxRFNOdnZtRkc0UXdqV2UyRmNlTlFERjQ4VC9PUnByMlNwRERNaUd4TnZ6?=
 =?utf-8?B?VEN5a3NxNHk5ZStDNm9ObVFPRTNhZU00RUszbSsrN3F4bkVsTUltL2tWdVJN?=
 =?utf-8?B?ZUNreWd3V1pFemVFeGNUeXBwQURINHFvMXkydnlVL2pyWUpXdjVrTThCWUJu?=
 =?utf-8?B?U0g0QlpSdW5wRUwzWHNCOVVLZDZFb0Z5Rm5EK2ZZeW40dDMweUdrb1JEL0tG?=
 =?utf-8?B?S0VBb2tYR280MEFzcFZEYjF3RmpLazc4WG5sSHorUE04TVBjejJBUUp5QlBh?=
 =?utf-8?B?M1lHVnhnQmpTNVVubEtkZXRCejhJU3BDRkcwenRQcGZWaWdydDl6VzVHeVF2?=
 =?utf-8?B?aDZLVHZtM2dndk5iSFVnQWdjMFg1T3ZFNFMrck91aHg2RjBma1o0YktIRDRT?=
 =?utf-8?B?NWlieVpvTnFDanVnYklhRWpuS05lc1hFS2hkaklvd0ErNVo0dTBOK0ErMURw?=
 =?utf-8?B?aEtZcU9pOHpmOWV6dy9qNDJPaFgwNzRiZ1cvMHo2MzlSZHN0QnZOekhmcHh6?=
 =?utf-8?B?QmRQaFFCczFIRDRSYmhDVlZQRXBqVUZLZTJiTURBR05CbFdrOWJoVzVLc1hw?=
 =?utf-8?B?THk5Snh4K3VDckNvSHFyVGQ2eFhYeWw3KzRsWlQyQ1JIcnBDZzhsNlM5TWpM?=
 =?utf-8?B?cEZGOUpvNVRMUUVrMHdqL3Q3VlJlYVp1cHRpSUdCUVZ6Ym83M2ZMbG9sNFBU?=
 =?utf-8?B?T2l5TldrRG9RM05DOWF0ZGxkSG11VkNqRlQvaFFZMFVkMFoyOHdDUVdTT2x1?=
 =?utf-8?B?MTZmZllKOHcybU1SUThVL0dXbndWUnVlWXdzK2s5SnpQamRWR2xOL0doanZk?=
 =?utf-8?B?U0ZCaWdFeklmRnJ5cWZ5U2xnWnVkUnhXeHVTQnFUU0xZeTFQQUlSY0l2SWwv?=
 =?utf-8?B?S0V4VjJ3YThuYjZ2N0ZISG1xcmVraEdYWFlGY3oyN1g1cStCbHFkMmlnaFAx?=
 =?utf-8?B?Sjl3Zkt6WWJpdGRtTFhzMFY1VUpFT3F0ZmxFSmRuakd1SnBJVGJ0bW9FQ0xw?=
 =?utf-8?B?WExVOE44NWNLeTRsZW9XQnFFTVJvWUNpaEpwZFRRQjFSeGFxWE1XdnBVb2th?=
 =?utf-8?B?V2xwa1hua1lqcjY0eHQzNGVvQUJYbGVVa3ozdFJWUlpaN29Mc1ZTUFNwbGF5?=
 =?utf-8?B?QzVmT25oY29kekRiRSt0dFB4cUdVeE44VzRZVURpc1lEYUVCcnFJWjhHM1BJ?=
 =?utf-8?B?WkNwNjAxUnMzOFRPWGYzOHdHcWF4SmZiSUtxdXpPU1Z1UWprM2s1NHl3TUhL?=
 =?utf-8?B?VkhudjdSZnZwWUlRdlN1Q2NGNTBBaVluMEVZZWZMM1NlZERxZjhicFlKQkhD?=
 =?utf-8?B?RThKU2hqc3BBRXJQOWI0ZU9wN2NRSXR2VnhNMlRjL3BuaDEraEdQenNCL0VL?=
 =?utf-8?B?OVYwM3ZHVkp6VmU3VEZ3T1psUmpnZzBISjVwZHhzL2tOc1huMXdXemZBYjE5?=
 =?utf-8?B?SUNqcWRUZlQyeHAvUVF6MGRGS2l2My84RnV5TEtNU3BXVkxZVDMwemZlN3Ni?=
 =?utf-8?B?OTdwQTlTVWlUcGtjQnlHZmxkSnYvZ2lYRnNmNE1TRWJMUy9XaDFXRm1HWUVL?=
 =?utf-8?B?bUZYSDFTbThBbUx2Ukh2YnNWNWpRd1ZlWWRVYjBmVE1zVzBQd0NpeXpGOFlr?=
 =?utf-8?B?U0N6Q1hML2FqNnB3ZkF1TTRYZnNxTFBuWGk4MlhZUkZDdGRiSkM4M2hiTTFE?=
 =?utf-8?B?MTlNSk9WeFBLb2NFRGVObTVDdXRyVXBJdmZHaFRGUzVxY0ZDRmo5d3cxNTZP?=
 =?utf-8?B?bTdpdVQxVWJMS2czL1VRUGwydy9Jc0U4MlVUaHNRM280WE5KUFJFZmtPaGdK?=
 =?utf-8?B?UzM5RXRWMkdxMS81RGRNVzlpM1dUaG1yZ2NtU21qaXBoQjI2aGNoSXp0U0Y2?=
 =?utf-8?B?cTdiL21JRkhJZDRlUXRDYWpxZDlNK3pYaUN4S3VCZWdBeDhiNHFrWFRNMFdW?=
 =?utf-8?B?ZjZQS08zZzJNWERBSE4rRjBZeDNiQlZ6VS9pc0lNVXRGWTEwQjE1VEUwdVVl?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4973877c-05cf-424c-8146-08db0bd46bb3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 02:05:17.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrruZSGtwI3urlgTWy+x1J9SaFhGKagt8uq5khah/oaj9quf2kBRRtvNdSXCvtq9MWu8G7OsVCatphEnEkv+JKT89WE1bKsFzXBoknPrPAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5599
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> v4:
> - Init invalid range start to 0. (Dan)
> - Direct assign range to range. (Dan)
> - Add comment for why emulated decoder is locked. (Dan)
> - Check range_len() instead of content of .start. (Dan)
> - Fix too long line formatting. (Dan)
> - Remove ->emulate_decoders (Dan)
> - Dropped v3 7/8 patch. (Dan)
> - Change decoder lock removal commit log for more clarity. (Dan)
> 
> v3:
> - Simplify to directly return devm_cxl_enable_mem() in
>   cxl_hdm_decode_init(). (Jonathan)
> - Move relevant changes from 6/8 to 5/8 and update kdoc. (Jonathan)
> - Add kernel doc update. (Jonathan)
> 
> v2:
> - Refactor to continue when size is 0. (Jonathan)
> - Update kdoc comments (Jonathan)
> - Use a bool for is_cxl_endpoint() to make it easier for static analysis
>   (Jonathan)
> - Update commit log to indicate cxl_hdm_decode_init() return additional
>   error codes after change. (Jonathan)
> - Set target_type to CXL_DECODER_EXPANDER (type 3). (Jonathan)
> - Skip HDM enabling if DVSEC range is active. (Jonathan)
> - Set target_count to same as number of ranges. (Jonathan)
> - Set target_type to CXL_DECODER_EXPANDER (type 3). (Jonathan)
> - Refactor to put error case out of line. (Jonathan)
> - Drop 7/8 "cxl: suppress component register discovery failure warning for RCD"
> - Add support for missing case where HDM decoders are present but no decoders
>   are committed. (Case 5 below)
> 
> This series provides the emulation of HDM decoders from the programmed range
> registers. From CXL 3.0 spec 8.1.3.8, there can be up to 2 ranges programmed.
> Some devices may not implement HDM decoder registers and some may not be
> programmed by the BIOS. Under such scenarios, if one of more range registers
> are programmed, then we can create an emulated HDM decoder per active range
> indicated by the range registers. The emulated HDM decoders will show up as
> locked and cannot be reprogrammed.
> 
> Below is a table that indicates different scenarios the driver may encounter:
> 
> rr: Range registers not programmed
> hdm: HDM decoders not programmed
> RR: Range registers programmed by BIOS
> HDM: HDM decoders programmed by BIOS
> 
> emulate HDM: Create HDM decoder software structs and use values from range registers.
> keep HDM: Populate HDM decoder software structs with values in HDM decoder registers.
> 
> Case 1:        Case 2:        Case 3:    Case 4:     Case 5:       Case 6:
> rr             RR             rr hdm	 rr HDM	     RR hdm        RR HDM
> unsupported    emulate HDM    keep HDM	 keep HDM    emulate HDM   keep HDM
> 
> For convenience, the kernel branch can be retrieved here [1].
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-emulate-hdm
> 
> base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3
> 
> ---
> 
> Dave Jiang (7):
>       cxl: break out range register decoding from cxl_hdm_decode_init()
>       cxl: export cxl_dvsec_rr_decode() to cxl_port
>       cxl: refactor cxl_hdm_decode_init()
>       cxl: emulate HDM decoder from DVSEC range registers
>       cxl: create emulated cxl_hdm for devices that do not have HDM decoders
>       cxl: Add emulation when HDM decoders are not committed
>       cxl: remove locked check for dvsec_range_allowed()
> 
> 
>  drivers/cxl/core/hdm.c | 119 +++++++++++++++++++++---
>  drivers/cxl/core/pci.c | 199 +++++++++++++++++++----------------------
>  drivers/cxl/cxl.h      |  20 ++++-
>  drivers/cxl/cxlmem.h   |  12 ---
>  drivers/cxl/cxlpci.h   |   3 +-
>  drivers/cxl/port.c     |  25 ++++--
>  6 files changed, 237 insertions(+), 141 deletions(-)

Oh, this all looks good on the base driver, but this missed updating
cxl_test:

tools/testing/cxl/test/mock.c: In function ‘__wrap_devm_cxl_setup_hdm’:
tools/testing/cxl/test/mock.c:143:26: error: too few arguments to function ‘devm_cxl_setup_hdm’
  143 |                 cxlhdm = devm_cxl_setup_hdm(port);
      |                          ^~~~~~~~~~~~~~~~~~
In file included from ./drivers/cxl/cxlmem.h:8,
                 from tools/testing/cxl/test/mock.c:10:
./drivers/cxl/cxl.h:664:17: note: declared here
  664 | struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
      |                 ^~~~~~~~~~~~~~~~~~
tools/testing/cxl/test/mock.c: In function ‘__wrap_devm_cxl_enumerate_decoders’:
tools/testing/cxl/test/mock.c:174:22: error: too few arguments to function ‘devm_cxl_enumerate_decoders’
  174 |                 rc = devm_cxl_enumerate_decoders(cxlhdm);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
./drivers/cxl/cxl.h:666:5: note: declared here
  666 | int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/testing/cxl/test/mock.c: In function ‘__wrap_cxl_hdm_decode_init’:
tools/testing/cxl/test/mock.c:220:22: error: too few arguments to function ‘cxl_hdm_decode_init’
  220 |                 rc = cxl_hdm_decode_init(cxlds, cxlhdm);
      |                      ^~~~~~~~~~~~~~~~~~~
In file included from tools/testing/cxl/test/mock.c:11:
./drivers/cxl/cxlpci.h:73:5: note: declared here
   73 | int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
      |     ^~~~~~~~~~~~~~~~~~~
