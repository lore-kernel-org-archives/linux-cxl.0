Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BF0C19F2A
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Aug 2022 16:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiHDQdn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiHDQdm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Aug 2022 12:33:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB01CB37
        for <linux-cxl@vger.kernel.org>; Thu,  4 Aug 2022 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659630821; x=1691166821;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2H7jn8pKoD5kOQNAkNYjSpZ6yFz+fHXpJYPZYuO2Lhk=;
  b=J5rkTjde1p08pUdqcv3QxWJaHdRMUlYyhpiDk/T8XcWzYaGWslTKR3mn
   qEsA2PvO870AA1sUPRXYecESnjMOJIHrqW+EUq7X3YwTfD4I2mAmfFDZO
   mQtgvkwIcNcGBIrNJ9ccxAJIoKQ3hxE4HqIt5XVOTa1xvCaltcFykwXG6
   kjj5Y5jViUu7HvCJKmhoQMKqyUOJbLx1UPTyTuunKhgWNFQa3bKu4vI43
   ZtE70Qy90zp048t927re6DirFePM8+uN4c8uxxIbveIoOuDWgUIx2qFAi
   yByowSL5OopqIZjQYIBPJMVI48SNFfrVGU4x+EtbszYsjQ+cSNuKBq8vO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="287545322"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287545322"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 09:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="553784973"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 09:33:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 09:33:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 09:33:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 09:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSNwCwR45+nW08Yu/J9XxjOfxIrVUiAyWZoHEVZIwB1JSk8qDzSPTitjkr/OMlMzYxDB1i7ekkcZ13JHWT3wm8k7tRej/PSnsiklVFqJR2VHMr+9+PdTGUxPezQ35oobkF6Ub84xsuoZwsUFp2PmzjrVdYu03A2L7OlXfwkdI+PfJktwRAkMi54K1OsmwJjAXzFMcaLQwtuwrbujpNlGOEy9aqPNb8WJjj9twn3KwZ8DPFNK1pXdfgIIXupDHF5DfJktQ7nCUpMA4GRCnNRnlDFCA0eH5EHdhvUBRfH6f+7NJJD9JNTqlEHHOYgD+hyKWrgMZcMA9MghPcQan8/Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCXBrnuUGLRdm0y1RrxiBXSohXe5BGj7vKT7+NkwhDc=;
 b=YRDrEDd4+clpCprbsoXhdnSEuOl7d9OBa32X1IqpzRYYA58zZUSP2U3PXMCBOcqX7UxRX42yb0kjW/uXpT0y32iqWyBzZXxQvtfU++nLa83+1Ok9lb0xu2BI3m3WN1xXrs9d/e9l2Ek6F+vDOaOyOuLWrJGKXgCF+U6yGp7OCaoqNFf8G5c6di7eIlEbjBOqKh3s3lnmHQFDaiO2CoKm6XzZffgoF6aWlcm1HwQhMJevWDOm3VYh1E3cK7wfwh3GSnrDhPF25u6CACzZLnu9SOBjUV0xEEyEmdDY3ohHIIR/GWYq/xhMy8cWEg0zvo7KWOghAV3+f+rvX1m1dA+pzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MWHPR1101MB2207.namprd11.prod.outlook.com
 (2603:10b6:301:58::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Thu, 4 Aug
 2022 16:33:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 16:33:37 +0000
Date:   Thu, 4 Aug 2022 09:33:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/5] cxl/region: Constrain region granularity scaling
 factor
Message-ID: <62ebf4e022ca6_8814829481@dwillia2-xfh.jf.intel.com.notmuch>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com>
 <20220803171732.0000482d@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220803171732.0000482d@huawei.com>
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c90f3ed-0f6e-4602-2cb4-08da76371531
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2207:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EpKkJgzEZNSWIZD/k7lvcirp1unXlwY3jJk53W33QGcwuNi5V1qj48msBOASkc0cVdUTSoq/oa5kpxYovr7udZJEvl1PHq4ObSZVCrETGjou2xNUTEJy6Jq8AbFaM3LHbLsf6PjzWa++Trl0Wf88jXKHRoB0JlXAG6a/rVMo0wGWFJXvP5WFBOMJpNtUXan+yszKTCMqc7I1io666U2359m+dAkt2jQZYHb9tpUChxM8yDx7nlK2+GEm36+da7/LXB3jZQQb9opXee+FZjj0K4AdPP/Cx1jMeVlMDQJg5nglWJogKIBDmTdLNPyQyUEa45Q4z2FrSFo3n+6YPdsobNY+F4CqfOLWayoYoO145r6STazI/+xygHkxizPr445WaxqfDvCPOVgfWZqh5jwME5ju3ZUmCwG+7zc5CeYoD9yRfbtfvr6KKqRd/zh1P37vqIIyUM2n4mR8LoMr4vrtkFQkJH2Kw4TrF3NR+5+rbG+LLGSkv6WC9/ti92BcdnO45WY/ctUkMLliP8BqXBnJbfgtNY0iY+VBT7bfUucj7mGn+4LYiGoxEcfvZQei63KNU02OyhipmSpm51FPhl5EbFPwIThUdeb31XD4mFWmMnarBiR/K9qC8wGoRgEocSFHhXLkkzSixWN3mMTyympepjlnY6SDpti4AUufgPKb8WD3YnBuoPY1ps9ynZ0vyfUXEBzjfKBs2EfDHhZpnC+bEp7SWtpuHMe7uzB2JwUmy9slRNAHQ7pfMtdSkdtiGhA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(376002)(366004)(39860400002)(478600001)(9686003)(316002)(26005)(38100700002)(83380400001)(6512007)(6486002)(186003)(8936002)(41300700001)(6506007)(110136005)(2906002)(4326008)(82960400001)(8676002)(66556008)(66476007)(86362001)(66946007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZOVlJCNk9LSld3SjRaUGZSNG5IT0p2aFlBM2E1ZjI5c0lYNmFLaHVOTktC?=
 =?utf-8?B?UXJBMEFwcWxUaFhKeS9BZHBBdXMrNzB5bURkWGc5TElKSXlEcWduenZ0NW5W?=
 =?utf-8?B?Y0FMNVA4LzBBSUg0TVFmbnp5bTJTVmVPVVZ0WW1kOEhjOU1DRk9KYjRSUGdo?=
 =?utf-8?B?a3l1ZTR5ZTJnQU94Q2RWUVlaY3cxZG9ib1pWUHJMcWZ2Tms5b3pybXFJc1RL?=
 =?utf-8?B?NVlZRElSallOSWRXbDVGNTJTMW16SVI4S2IzY0hxQ2ZCei9pK1J3S0k3OElS?=
 =?utf-8?B?RzdlL3F4VEJPSUs0clhkb0VxZVh3bFd6RFJJVjJCNFh6ZHhaSDd2OGwxTGhE?=
 =?utf-8?B?bjUwZjdacmI5VW8ydUhLMitnY0V0NmU5alJEVjJPRFlreDRQQ3JvYTBMNFBN?=
 =?utf-8?B?UUZRaTZQWGszR2xPMHlHQjdwZmZyMjZReTluMXFCRHpNL1laYThHVDlnemNz?=
 =?utf-8?B?VjZsc3BIZnkxTWViQ2M0dHVZVWs0NW1uU25vMFhsUzZaK2dOeWhITDFJZk12?=
 =?utf-8?B?RXIvSWNRb0pTakptQmIyL044UjFyY0ZJS3phSWxvcDM3YVFpdjRCcjlWZkxU?=
 =?utf-8?B?RTloWEFUVVNBSjJFMU43R2RVM3hhVWlLR2ZnVU9PTUtKN1Radk01cGR2aFBZ?=
 =?utf-8?B?aWFvWGVFekZIZkZ5MmNBZ1NWWTBNSlVXMm8xUEdUbkVwYXJOY3d3RWtpWURr?=
 =?utf-8?B?eGVWU0d0KzVTcWQzQU5jc05KOHFvK2hCYXUzcXoveVQ1b1VCOGRxMXQ2bUpB?=
 =?utf-8?B?dG4ycjRvWFBnelVQTXlPTHRPaU5QSERvNEFOV1doM2Q3dFNjSG1NbURTdzlW?=
 =?utf-8?B?R0pldS9DOEpLdTl1bnFhTVNkUlpTeEQySFJzVTJqUlZwNzJucWlwOHRJRjg4?=
 =?utf-8?B?L0hQbUtNT0Z3a1dnQjFYSzdka0d2VWRqM3hNNWpEY043WFRhcHB3c0dlalV3?=
 =?utf-8?B?WGxJWlNRZGFhRFJIKzhHb1ZXQ1REMWlHdkhZbUV5OWZvTDBYZGJEckdIMmFL?=
 =?utf-8?B?SEVMd3BCV3VBNUVWanFjdFEvZWt4d2U2SEZiZWVPUUgwQThERFhCOVdwYy91?=
 =?utf-8?B?WERkcFV2TjByb1VjL2R5Q2dreWJNT21yUHd3VXU3clpiOTlsTS9nazFuZ1pK?=
 =?utf-8?B?OEhldkc1bzg4WklHN05kY0phTnJMTnJrQmhQOG44SmdnMHlEbStLRm1VeW0x?=
 =?utf-8?B?NENkMyt4VE5yVXRBa0g4M1pkQlJtSzY2NHJ0TnFhVFo5Q045TldDUkovUUlW?=
 =?utf-8?B?RTFOMGpZOEh5NTZyT0I2VzBDN25zaXVaWERjVVp1Q2dnN1dockhQaGNVMUgx?=
 =?utf-8?B?a0RFdVA2RU5zdk81NTFGeENMSnVYSWhHankwYVhWRzhraTRIMjZNYzhUZENm?=
 =?utf-8?B?Z2NqeG1WTEJ3MkVyN1VnMlRxdU9PaklBTGNlekFsQzdPNkJtdEtwT3h2cFdm?=
 =?utf-8?B?dXovYStZWHdFcXQ5Yjk5aVFuQ0MvRGN3VHNJenJIZkR0a203ZjlNUFg2aTNx?=
 =?utf-8?B?S0ozMzJJdHE2WFpZQ0xzUmU2cnB0NmpXU1p0SUNsL0Nvckl0SVFQSTNneGM0?=
 =?utf-8?B?YmJPemdwU2svazVXcURVQTlCenQwZUVKNWpWbFMyUnRmUUxCWkJUMWtYdXZx?=
 =?utf-8?B?ZUFOR2MwNGJqd2VLTXNlcEZtcW9lMCttazBkTlRvaHhWeVRGZkh1bG43VWxo?=
 =?utf-8?B?U3FoVDBKTmJhNENseFVtOXhyeTJ5TTJYMFhrUlNjMFliU3JNZkljMWdSTHFy?=
 =?utf-8?B?NVR6ZGpoQ1NvN1RMOStZUFU3TzFabDJGTDJVRDhKQUVLb3d4NkxsaXI3S05t?=
 =?utf-8?B?UzB4aWo4cjdGUnJ3VDJUWElscHpWdHYvYjN5cndhSC9QU3lUV0dablltUWU4?=
 =?utf-8?B?RVFLUnNrVzhtcUVtS3JicFRHRXV4Z3d6a1RteGZ1T2tvZkZ0NkRMeC83VzU3?=
 =?utf-8?B?NkhMRFlrRW5CTlpxaDJqcVJRZjRSNFRERUpsL05sdWQzTWVtNWcxL0xkc2tL?=
 =?utf-8?B?TFd6YUh0cDIwZDRrY0tzWGxDSUx6TkRBZGRSZjBZOC9CeTlLbW92NUJuWGYx?=
 =?utf-8?B?SUNGWE1JZ21xa3V2M2dCa2RleVR3MllHSVdmaU5UMkw0djQzT0lEK2tJdG1I?=
 =?utf-8?B?cXVJdVdydzZjTFNyOEs0NHNNY1dydkszdkcyUFgwSE5oMzFMWXRESDVyYmMv?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c90f3ed-0f6e-4602-2cb4-08da76371531
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 16:33:37.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJmOCJF0a5X463Gzbv0ercoijpuXIHs3qBFuUrne0ky3t3VeNR6XZU3RXHezZ8s6+zua7hZzq9ufTSoB92b9M9YL0higmygLksPqeGA6ttQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2207
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 22 Jul 2022 17:56:20 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Consider the scenario where a platform provides for a x2 host-bridge
> > interleave at a granularity of 256 bytes.
> Hi Dan,
> 
> Terminology not clear to me.  Is this interleave across 2 host bridges?

Yes.

> 
> I'm lost in the explanation.
> 
> > The only permitted region
> > granularities for that configuration are 256 or 512. Anything larger
> > than 512 results in unmapped capacity within a given decoder. Also, if
> > the region granularity is 512 then the interleave_ways for the region
> > must be 4 to keep the scaling matched.
> > 
> > Here are the translations for the first (4) 256-byte blocks where an
> > endpoint decoder is configured for a 512-byte granularity:
> > 
> > Block[0] => HB0 => DPA: 0
> > Block[1] => HB1 => DPA: 0
> > Block[2] => HB0 => DPA: 0
> > Block[3] => HB1 => DPA: 0
> > 
> > In order for those translations to not alias the region interleave ways
> > must be 4 resulting in:
> > 
> > Block[0] => HB0 => Dev0 => DPA: 0
> > Block[1] => HB1 => Dev1 => DPA: 0
> > Block[2] => HB0 => Dev2 => DPA: 0
> > Block[3] => HB1 => Dev3 => DPA: 0
> 
> Block[4] => HBA0 => Dev0 => DPA: 512 ?
> 
> which means we are only using alternate 256 blocks of the EP.  Does that make
> sense?

Yes, but I found a subtle bug a bug in my logic. Here is the output from
my spreadsheet calculating the DPA_Offset for the first 8 blocks when
the topology is "x2 host-bridge @ 256 => x2 endpoint @ 512"

Address	HB Index	HPA Offset	DPA Offset
0x0	0		0x0		0x0
0x100	1		0x100		0x0
0x200	0		0x200		0x0
0x300	1		0x300		0x0
0x400	0		0x400		0x200
0x500	1		0x500		0x200
0x600	0		0x600		0x200
0x700	1		0x700		0x200
0x800	0		0x800		0x400

So we have 2 endpoints at 4 DPA_Offset == 0, so there is aliasing.
However, the bug in my logic is that this fix for this is not:

"...if the region granularity is 512 then the interleave_ways for the
region must be 4 to keep the scaling matched."

...it is that the number of *targets* in the interleave must be 4 with
that split handled by the host bridge, and leave the endpoint interleave
ways setting at 2. So, in general to support region-granularity >
root-granularity, the host-bridges and / or switches in the path must
scale the interleave.

---
"x4 region @ 512 granularity under an x2 window @ 256"

 ┌───────────────────────────────────┬──┐
 │WINDOW0                            │x2│
 └─────────┬─────────────────┬───────┴──┘
           │                 │
 ┌─────────▼────┬──┐  ┌──────▼───────┬──┐
 │HB0           │x2│  │HB1           │x2│
 └──┬────────┬──┴──┘  └─┬─────────┬──┴──┘
    │        │          │         │
 ┌──▼─┬──┐ ┌─▼──┬──┐  ┌─▼──┬──┐ ┌─▼──┬──┐
 │DEV0│x2│ │DEV1│x2│  │DEV2│x2│ │DEV3│x2│
 └────┴──┘ └────┴──┘  └────┴──┘ └────┴──┘
---

---
"x4 region @ 256 granularity under an x2 window @ 256"

 ┌───────────────────────────────────┬──┐
 │WINDOW0                            │x2│
 └─────────┬─────────────────┬───────┴──┘
           │                 │
 ┌─────────▼────┬──┐  ┌──────▼───────┬──┐
 │HB0           │x2│  │HB1           │x2│
 └──┬────────┬──┴──┘  └─┬─────────┬──┴──┘
    │        │          │         │
 ┌──▼─┬──┐ ┌─▼──┬──┐  ┌─▼──┬──┐ ┌─▼──┬──┐
 │DEV0│x4│ │DEV1│x4│  │DEV2│x4│ │DEV3│x4│
 └────┴──┘ └────┴──┘  └────┴──┘ └────┴──┘
---

...i.e. it is not always the case that the endpoint interleave ways
setting matches the number of devices in the set.

In the interests of settling the code for v6.0 merge the smallest fix is
to just not allow region granularity != window granularity
configurations for now. Then for v6.1 the algorithm can be expanded to
take switching into account for endpoint intereleave geometry.

> > ...not 2, resulting in:
> > 
> > Block[0] => HB0 => Dev0 => DPA: 0
> > Block[1] => HB1 => Dev1 => DPA: 0
> > Block[2] => HB0 => Dev0 => DPA: 0 !
> > Block[3] => HB1 => Dev1 => DPA: 0 !
> 
> > 
> > Given tooling is already being built around this ABI allow for
> > granularity and ways to be set in either order and validate the
> > combination once both are set.
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Typo inline.

Thanks, but moot now that I'm dropping this in favor of the safe fix,
and push ongoing improvements to the next merge window.
