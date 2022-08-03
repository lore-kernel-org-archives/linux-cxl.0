Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13890C19F28
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 17:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiHCRSl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiHCRSi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 13:18:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6BF54654
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659547112; x=1691083112;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6lHX4mczP3zurm23HPJh7QUUaF2fNtZGH/tNVcQv++U=;
  b=HczlTt2zIP4KwPRIASyjuvXM+1gPwt2wF/+lxVA/cAxssvIatU77XRVw
   RakXr4iOBGhiiTEXcaB5BkQLi+v5+BLDRkHq33RsckM/iYj2Hx5J0PwAE
   sDggopchWIRxAZUTA5MRibjcD8oEji31tJow8zlWszPXD+4lgqj+0bBs4
   v1rKRLL5fy1Z51MUtCx3HO/rdF/izJhdx27gHi4rBGlUmnUEHVE2MYMQ0
   CWAoL4ixpN5SC8hNcxR+NhMUy5T1/bLLmwAVDHYlKSAr08YuV2spxIzm1
   2t08RfnnRe2diGh8ZWNqY62FbinCAkkB2xJ2yGA8b01e6JHNymyUy5UkN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="270113402"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="270113402"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 10:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="848654696"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2022 10:18:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 10:18:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 10:18:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 10:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kv9VBbmTSyQhcmg1o+VAFaRga9De7vt+VS8ENc/kbPZOFdZpHFBIK/2lU8Jg0W/iDjaXQTzSwh8Xh/a8PGHnqhilZ9rheWFfiTuDncLZ+kUVYx/93Znxh7WdoAi8qIAGLh0xOJCgrcqyR9X3rM1rJyA4j8CaAdGjoSJQbPvHnpEAkoOOuh/FskZTHvAuBl33OFNMxdG54WM64lQnKFa3JE2r5ZLsYgSz0ImJucfTXt2mb/eiyZ2zFr966DMaiFklpdadvEV1xkg/gabO9BEf5TplJSTWnFTbc7/wqcjG0eo+6C/D+lW04Pr9WSYHvn3Mwov82cdxkppHX6HZ/9IT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLp2SmV2i0cCu6wGuvkHtcjT7+TC1/qGoPFIZT/FpfE=;
 b=II8YgSX/OEH3od0VCLkxNsOJRJAqp6GdMst7f4YBbF6Z74BSvPDgxoBL3DlTy/YhYJJ4/oi0Na/7C5ntCZ01BopwNt5pmgONhAYti8oYhvzepiG9ob70bBUsvXoLBHHFmofNPZFutf/MLz+fRe5axItIqHNZSEWPTCGU8RHJ6Jxzhsik054OOr+zTmqzh02axeClSVg1lUanA9kfck40QrlZRGwqWVxHu6/y8eRZwmHrrWPmwMRyf+teOGzYTAHsNeY/wsWxy8EtO+LkulZ90m6SzPLosgb+5bk84qW5Tn0rLSZivuCl2L2BdvKBeRUbKYcN29ge1Q3S78yVo9UVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB5960.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 17:18:30 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 17:18:29 +0000
Date:   Wed, 3 Aug 2022 10:18:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/acpi: Minimize granularity for x1 interleaves
Message-ID: <62eaade383939_881482941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
 <20220802165627.00003464@huawei.com>
 <62e95fdf9f6e2_30440294e4@dwillia2-xfh.jf.intel.com.notmuch>
 <20220803170020.00000c81@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220803170020.00000c81@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7cf9d59-cef4-417a-c336-08da75742f2a
X-MS-TrafficTypeDiagnostic: PH7PR11MB5960:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1eo1sRLPnBUBGy2ywJc8gwZfXoy3v0QH3Bt6CVNpycljo3Dgs2J2vyM4UfZDfpvh5VMVnhMv4hWcTms9fNF2gTeuhqaXotAs8dq9ie6hLSDd8VvaRKzQp67K5/cvuqPo2L22iXEzUQD0J0BtlBkJNZucoD7Cvf4qjmNfdYXTRr9bGsP5P8T0x0v/ZA1EHv3musfiEmn/BOYJs5yr/dtI7jb7mDCb7+CfeURwoM9gMOe0Nnpbyc7Ymf3YKPEpN+vsVT09vdzSsenOl31SCDNjA4M8d3pkmuMMGAT+XRsnAB4gHjcofc7widFjBIK2+yOb/2mtIOB4Gi77ZzHoAIa+XRjthC3GaWVEuPnwubSzeJcRNhh9CgJJeKdq3pnP/4JiyysY8NyLU4DrdNz/vzPnCK+MN3036LCCpFKKCWNBSnxkMq6z7so6VBIomxnxF5HsXgf17mPhMchVd0gMbyUshq0qGBPjVZbFlVNCkNnqxI9YPi6aNm9So1NDSvnPP8Q+eKyghrzS49wUpY+7I2FWA/NkMkG9OGbzj8K+/a74P9pHKJVBJO3J+3Qlue4cT6IC1cxWiK2mlxA++SCK+E08zmhR6zJNcfB09bBh1xxYhjqbn9WZrnznlpUOjQsR6LPT/d5Ivj346/HGhP2lmAf4ZGRinTr6H7TSvtN9JaSp2ZR62iXtT+RjLDLGpcf47SU/muNTsUz4cTNfN4gBUdi+GNKLjU7ZIDQd3lycaSF1MNRbkROjBHOuKHAHJiQhQXdX2/4gqtXreN3nlS1EvQuww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(39860400002)(396003)(366004)(8936002)(2906002)(5660300002)(110136005)(66476007)(38100700002)(316002)(86362001)(66946007)(66556008)(4326008)(8676002)(82960400001)(6506007)(83380400001)(186003)(6486002)(26005)(966005)(9686003)(6512007)(41300700001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6PXofq7hZierm/joNkmRztcepShaVr6Hspfw0lRjzQGIAmrQXuAAXc2WF0J?=
 =?us-ascii?Q?u6r2oHn+TOiPC/J3pG1dYAqKk4J3HTpYnRjwAp5YW+gC2rYeTShSIi6R2Ldd?=
 =?us-ascii?Q?vVtoNCeb+rdWcsqPvv0w7s7yqH3raQGjDGinls7+vJ4xdtQ0cIVeTrgIuxQI?=
 =?us-ascii?Q?a8eJ+U+JXjSZOFmkwgTf5lPGJUBEx73WPN0mM4JnY84e4HRyInu71uDnvuqf?=
 =?us-ascii?Q?opSbuvn1f7km2NcNZCM4ht9eYBqq7R9akAL4bho1UiXKrohfCKHP88erI4kD?=
 =?us-ascii?Q?ztZfA1tUyNXVPXLQ8oexxEi1DXD49Bg59R+1G6CYCioN+6i2YKyybCunStqh?=
 =?us-ascii?Q?aruowv1RMxnSMFABju4bXTF2zMgzBoQFhfsqb7YfzFci3MfHysVa35GBr/sV?=
 =?us-ascii?Q?W801WB958GaZvdz7VulBLGi3hDc2Aky+tC8VtAWH5vH1gRmHhoiSMEL1UoPO?=
 =?us-ascii?Q?b3TNJk4eKfCB0bjJ4tOFEknL+Irc/MnAcMzpfuax4IclrjxAHb44csMOtvkM?=
 =?us-ascii?Q?ZSQzx6EdINRmUZWCUIGGBArgrq1AxdvATo/kbZGlTrLFCsXaNtL02TDI4RkE?=
 =?us-ascii?Q?fVdXN14Q/SJp34qrpEw3qjjkx+lawKmDTqTCMS9uRmVr25i7qzWxpiTD0GUU?=
 =?us-ascii?Q?EKR6Rfs5jQQ9Khk+bhapEIThLgAP+RErBz6NgxpvO9tQoo9vYdiBkl5hmuTZ?=
 =?us-ascii?Q?QymWAlL1gXgntZ+eDc+u7wvqQ+lgY52wyArRsV/coBXTIFRVyhQrh0Lwj3iF?=
 =?us-ascii?Q?Ujw8HVSZmIFcV/lZcDJoiqWREs7hgojUBUCiMwl8MW+3yQo/MPgKIgJx5Ecv?=
 =?us-ascii?Q?axCBoPlq05D5IzavFBBEuRSqKvfmx8XP/NlDGkpE4g5RFT5uiq02nQXsJqxz?=
 =?us-ascii?Q?tFOZVorfiQypeoyIKDb7yjAI5/a90x1zhOarAdC7uQuj+vVzQaMY7Xac8cDx?=
 =?us-ascii?Q?f97NJbnXsoHhwfRlvDIXtT/Ele+Q+Xt/jw6HM8KGNXaiVSbYUldAOCUxxr1I?=
 =?us-ascii?Q?bIfUlQqXcIElYJWvNCH/EkjTLwu4GuCrj22oJsn/gebUOPkgmZaD23ctJMB/?=
 =?us-ascii?Q?w03oQvTMB8sZXN8KzAbrwrsoQNu/OxLS9bh1MLCikQ/9vRKByaulq6VO0GL5?=
 =?us-ascii?Q?tzY62DJjuks+JM202fOOfHevEnu7nd742Cf6/3+2883l1sSWRIDeZreU50G8?=
 =?us-ascii?Q?iYCKoLEMYdE8y1dVVCxUfxj/vqvdjhmHEa86fq1Q/LkkfBcdX9ECz7rE8DQO?=
 =?us-ascii?Q?I0NsbrkJ8gstq/VrYg6OIaPSMkD1VcN1QEZRiiVe7uuv2MIyp25XAI99rfJ3?=
 =?us-ascii?Q?WqxKtr1zGGQ4gDJbUGbhUbxZ/FFk6fkFsSXJ7daLWsfJAxSXXz/3ScCPsxmn?=
 =?us-ascii?Q?xsFqpELJRH4e45Bl2f9q91ltXEZ5KFOJeP0LsmI3Ap+RG8RqDcDW016kU3Nz?=
 =?us-ascii?Q?IUVo8I+rmx0n9M71F86r8+iPCTDuA1668oHr4vzmrRbK88dpu1KKDog2jhQX?=
 =?us-ascii?Q?90mnc+9mj/vYjtlzvGcECxgCI/cZxDiqCniNdHiS1hj8+c7AxBthsY9ge4IU?=
 =?us-ascii?Q?HV0U7MDWRSxVcr7eVKNHWPt+XKjQZj5QjHNFuiWFpYb8MVgFOYmFRyogbcns?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cf9d59-cef4-417a-c336-08da75742f2a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 17:18:29.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeHOPHFJH43ZeX+usvhWJl3GOXYfnTqjLiyKtAjNsQOaOIsH0wsDkXGMGr7g56MmA19X4UDqoC6xSJjfe8bf7y78cQDRxKZouMWJDpV7GVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5960
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Tue, 2 Aug 2022 10:33:19 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Fri, 22 Jul 2022 17:56:09 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >   
> > > > The kernel enforces that region granularity is >= to the top-level
> > > > interleave-granularity for the given CXL window. However, when the CXL
> > > > window interleave is x1, i.e. non-interleaved at the host bridge level,
> > > > then the specified granularity does not matter. Override the window
> > > > specified granularity to the CXL minimum so that any valid region
> > > > granularity is >= to the root granularity.
> > > > 
> > > > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > > 
> > > Hi Dan,
> > > 
> > > Debugging exactly why this is failing (from cxl.git/preview) for my test setup...
> > > (1 hb, 8 rp, 8 direct connected devices)
> > > 
> > > If I set the interleave granularity of a region to 256, I end
> > > up with 256 for the CFMWS which is fine, then 512 for the HB which
> > > is not - EP interleave granularity is expected 256.
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/drivers/cxl/core/region.c?h=preview#n1070
> > > 
> > > Calculates the eig as address_bit - eiw + 1
> > > 
> > > iw = 8
> > > eiw = 3
> > > peig = 0 (pig = 256)
> > > peiw = 0 (piw = 1)
> > > (all as expected I think...)
> > > 
> > > So address_bit = s max(peig + peiw, eiw + peig) = max(0, 3)
> > > and eig = 3 - 3 + 1 = 1 (ig = 512) which is wrong.
> > > 
> > > I'm not 100% sure on the logic behind this maths, but would expect eig = 0 as the output for this
> > > setup..  
> > 
> > Yeah, the "+ 1" is not required when routing from the x1 HB level. I can
> > reproduce this config with cxl_test to validate.
> 
> Other than this off by one, with the other fixes you posted everything now works for me
> with the particular test case above.

Oh, you are hitting this path in your test? I misread the condition when
this triggers. It should be skipping the granularity increment when the
port's parent interleave is x1. I.e. in this case with devices directly
connected to a host-bridge where the host-bridge is not interleaved then
there is no need for an extra address bit to route the decode.
