Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445B4C19F2A
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Aug 2022 17:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiHDR6E (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Aug 2022 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiHDR6C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Aug 2022 13:58:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C321E0D
        for <linux-cxl@vger.kernel.org>; Thu,  4 Aug 2022 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659635881; x=1691171881;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=l+BIdOhH65V2PwkiWqXpKZRHELYZMSFeMu0pdCBRtdE=;
  b=XEPOllMnlI7Qh2C4/f3Znv06LyXqDPeeHTmN/H1eCloRxZk59Z9bmSZN
   kf/7fvmEQAAz1A4TTXRop19d8cKz7vKwofqupYafSYklATxAn03t/jG5S
   +kXoPMTdpx9Im8LHqKP/3K/MLrVH1+1JXrzmXv3I97Bm9WqQKTHX9JLCr
   +jIR8PgxCIem1pO5bUMI0OdikGxHQFQ1XQ8b8WScAffdWnpynKv2X4k2P
   IDTftq9E7YOQNFgBE1wxGNRVdd2G+ElhSkHccVate+csbnlCLnTxBy14u
   AeBJqaGV9QmPOKaFRQN6tOImPE3XBlFSyuROJ3SsZ4ZHKhIbhWtAZn5SZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="291225972"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="291225972"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 10:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="706291367"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2022 10:57:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 10:57:39 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 10:57:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 10:57:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 10:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy79mHxOPxfjmsJ6+Eu7oGx8RpY0p6fv43w1fSbFexhIfwOBrceUo/ginA6rKlqDNVcNbPRUdLCn7sqrU6as8baP/JRW4XR5cYifKnirkU/4dmYaR2cC94W8IpOtdICzvgtqIu2Ttp/NZ7erUlN9n0R9SpmwU6oLPCxWW/rL1jj0BbyhoXMPGbHE2K3vxcksrl20AT1h5Rv9iE+QWFZusW1dwk1CfpGRRDOVOcuEinOGaygEBz9P3cgFprHJDtnTy/U9z6VYa7nz8EvCD7sj+DV9D5NwOLL3PiSwg7p0Gcnrt21RPh+qxSZG6SqwSZHEIfxxRVhw3OxXvJhCvKQrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a+RHo7sXS8TCOOCHoRNbCV6TjT/AN7kcmsr//ixEOc=;
 b=oT630zxy9ZC5yqHcrBevsQBileWIMLlCtk79/jNqZGpFjHkx8AEsVrxVJi6jfpMxJ3a0zgH9iz8xa3ykV2VwQ+d45QPzjF1wxnfzbW4eTE/wwtJe+x4S/+yivUnIm89yRoPFny5vqzZOtVfBLgxlyZzBbD3C9/2YBuYqh7WEOB+3f7hs6QqA95Juh6fNxDAyhnQ9+i2/cwv+ONky/+tq/J9JuP4drcnh50L9NsigZ0zdyzBYwQGOBCNm4PJUdL+fW+HKowpuQy2rgzcDtw7Z+TlSU1gPdqWY0u7Ctgh2v7kakeiRr5OvPSU8LoLTaqA1fZfpaX0i+ZrGMXkR+flIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB5889.namprd11.prod.outlook.com
 (2603:10b6:303:168::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 17:57:30 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 17:57:30 +0000
Date:   Thu, 4 Aug 2022 10:57:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/5] cxl/region: Constrain region granularity scaling
 factor
Message-ID: <62ec088830bcc_88148294c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com>
 <20220803171732.0000482d@huawei.com>
 <62ebf4e022ca6_8814829481@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62ebf4e022ca6_8814829481@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY5PR17CA0061.namprd17.prod.outlook.com
 (2603:10b6:a03:167::38) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f274002-6be2-4309-2342-08da7642ccff
X-MS-TrafficTypeDiagnostic: MW4PR11MB5889:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbIHQli93c/Ds2GByHHPr0I5FfCF6YfXhmRIjd2TX6uoxSd43IIR9Y9nilZxjZwagPoqfmjjv66qiKMzSwJU8MglMNgXwlk6z5pKSwqxGNvoAWsvi7IBcRXN+3oYHjrH8exSDzwEcP8GyZ8lEVEXDiBXcdeQByKJFmWbw8DKILEl6DA4PnQeOxD2ZGRkXolYy2drO7LEl5ako8VKxU1aUmVf9uLxIsvp8eOcGv3oXPq787+Ms7lgRhpa/LH99clwGlNVU9bmzWL64g1rw7R7fxE6/zRa1ytnIvlyUmXcYi+2FovHTsIL+WCtgAdiLplQaRbYKAUnoIxUiaWQjLr3BWHJ6LooBJUwrtKU5DvyDFCbpzi8h4kxuA0F2HK4zDAqOL3dLf9+xHvr3KpXmYi8eczKWkTuF1Oss7gMVjIBXu25xmCv2lTZ8s/QJrE7tngygEm5WO1ZOCOEQcjah7JBx9P09OumPwt9Zp9c5jo9FrV//ePsT8XhAoGfSm4YPv2p9HgUKse1eyM6MuTRPWpkUak6QMaKfbaf4nAU8durQ5l4k0TqJL5V2WcGrf6iuLpkm/pzpG0NzXK0QwSSmHi0H2nEHM10UiGwc5T/txphhnA/BIfnV+t6GrhLBbmXEPweFdG4z2ZCdajrrD7Mw2MeDRLYcKhx/x0S1AlvPje8kKn9mxa2PuvfUaHHAOK1YG2WIVKtOwG9pxKxyEcdWx20vXqDBodFxfUapil57hHMfDHyoOkp5erff3Es4XvV8lRO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(396003)(136003)(39860400002)(186003)(9686003)(6512007)(41300700001)(2906002)(26005)(6506007)(38100700002)(82960400001)(5660300002)(66946007)(6486002)(8936002)(110136005)(83380400001)(316002)(4326008)(66556008)(66476007)(8676002)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzkxTVo2QnJ0ZkNaeWsrV3hpckNRZkx4bFY2UXZMZE9WTERWQjNBd0dBc0xF?=
 =?utf-8?B?cHVEL1RVWkcxQXlWN0ZYN00zbHE2TXRWQVIrRFdrM3ZWSHdyN1cwUTRzdHZo?=
 =?utf-8?B?RmkzYUdTQVB2RlZ4cG5rRUlieWIrb1oySmN1eDM2Qnc3SWQ0Z3BpK3hlN2hx?=
 =?utf-8?B?blFDV0w2RmZRZFBhT0d1ZW10dW4ycDA1Q0N3M1dIRHBkTlpzL09NanE3V2gx?=
 =?utf-8?B?YTJVM2FubmZWZ3VFK0xJSGRnRDI2V2hhVzQzZCs1Y1lCS2Z0bWZlbmIraTB4?=
 =?utf-8?B?YU9HTmlqZkRsdTNFTmZMYTJldHA1ZldoeHF6R25QTnFWSjJwamEvdE1ONzI3?=
 =?utf-8?B?NmRWZFFidFZobnczY09RN3NOL3ZEUW9wcjNkSlhsaFBnLytVN1AwMnJWM3Ju?=
 =?utf-8?B?eXNPWjNpVU56ejk2N0R5QkFMUHRGVmdYdWZLVjMvR2FkS29vaUFrQm5xNkZC?=
 =?utf-8?B?N0c0eG1wUlMzV0lHUThFemlnSzJPQVA1UnZ3OUswRkNOeStTMG1rRkxITHRy?=
 =?utf-8?B?eTZVbi9HbWtUTWtYWW12dWVBVDBIZlAzSVkxNzluQzIyenhGTzJnaHhNbVpR?=
 =?utf-8?B?RVRaekFtbWJJZHA4MVcxU3A3Q3NLak5OcTBaSFdwWnFIOTNiKzNTcm9MZGM5?=
 =?utf-8?B?eDRQdjRoSmk4TnN0Njd5ZENGdlNOWm9uK3JsUFF3Qi9jdlg5WVJXTXdTaS8v?=
 =?utf-8?B?YWJUWStua0ROWjFsRExlbUl1YlM0alJ4ZDY4QjMxcEZ2VWRGQk5uZU5KMGkv?=
 =?utf-8?B?VFpiS0I0eXRyYXhtNWoxUU02S1pXQ0JhcmNqNC9Md2xmL2M2ZWZFa0ZoUVBh?=
 =?utf-8?B?NzlaMEhmcmdBMUxlWHNWeW9lSUVZNWl4T3dVV1ZBc0ZEVWw1YTJZSjVCMko1?=
 =?utf-8?B?by9zRHRITktqcHltUzF4NnRUOXFNWHprMW10NEJlejI5N3RZL1gvZkJuQlgr?=
 =?utf-8?B?a3I4VlEyRDhjVE01RUlmcnl3NytxWnRRZEZTaHRRZFVLcWtYeUlzZTE5allL?=
 =?utf-8?B?ZzlBeVhtNDFRVmtiQmtIeUZkZGc4dnFBay9DRzZKZTZ4a2JJckRmQ084QllR?=
 =?utf-8?B?OHc5ZGVQczJVQlVpWCt6dFRjZ3hjN0F6WloyaFRRaHlHV29vbGViN3pkM2xw?=
 =?utf-8?B?V0hZRW14TGtCRW95Mm1EWUVpYjJ5eGFpeGs3c0dSZTJibmw2V3k2SjFPRVBn?=
 =?utf-8?B?VnNxbEoyQzNET01aRStqUjNUUHFlMFlHbXlPc3dyekxwU1lIWkV6TEl1S0pt?=
 =?utf-8?B?ajlFRzlWNkRTaDVyTGhqNnFVREI3bEVRdjE3V0FPK0FndmtFRWhCRGJzODRD?=
 =?utf-8?B?akhRUlMwNTI1ZG1jOFl5WjRPdlNCdDdTVVYzWHJqdVlxSUNabXpJeEcySFBN?=
 =?utf-8?B?V3BoRjVXQmk0cFJOM1hqdnRreE5CVTl5blhyL2h5ZCtyMXF1VTltUmV3QmpW?=
 =?utf-8?B?T1pJQ2RyYkhvN3U1dzhMaGRycytuSTE5ZzNSVVRKbWlYemtabE8wYnFodFdr?=
 =?utf-8?B?UERBNWw1TWJrRFRmcytjNk5CUWZmc0JSS0pjMHYzRlhqdTIwM24raGx0Z01y?=
 =?utf-8?B?emhwQWFHWGJNNlIzM3lrVkdyTk5ieTVqUFlxcXV4bzM0dmJqY1Qzd09DaTVJ?=
 =?utf-8?B?c214OXR2Tzc5TjJOT1NtcnhKeWtnSEpHdENlTnBaMnhUYy80S3lKTTFSUnp1?=
 =?utf-8?B?a1M2NE1ZYmF2Z2ZqUElKV3pJR081Uk5jMXdMQ1Vrd2tqdUY5UmEwVVZrU3pL?=
 =?utf-8?B?VHNCbUJDNmhqeXdxenFFNnhaalFsZGRpdkY1dFFKUm5GVTk2WmpLOHc4YUxE?=
 =?utf-8?B?L1JhdnQyY2NYbTloVFZCOXlja0x2a1RaSWgxS054dU4xMFNyZzVaK2RibEg4?=
 =?utf-8?B?TGNhUGxVZ1BQN3drSUo2YXBsWGZWa1RPN0hXNDgyK1J1OXNRbVhFTEwzZ0VS?=
 =?utf-8?B?UWVSelJoenF6TnVBT1FtOHplTjV0L0drTDhScVB0UitFcEYxZmoxVCtwSWxq?=
 =?utf-8?B?VmdhbTJRWXdOQTJqRGNjV1cyMmt6MzRnaDN3eDE1MFFsTFpUVTJmMW9CNXNr?=
 =?utf-8?B?ZFlLSzRUM3N5M2lFVnVuR2RleFVQVlBxZGl3OVBscUNYSG5nUlRKMW12SWkx?=
 =?utf-8?B?UU9LQUZvWE1nODBXcHBYcVlSNVd1bmRNYTdzR0hLQ2dzcWtJWnR3NVFzbzBj?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f274002-6be2-4309-2342-08da7642ccff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 17:57:30.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CB5VvW+upu4oOuQSMMLcaQPVelqa4L/52U7InQVgmmdIzOGcAKTply3ob/P7N2qV9pf5ZthXCGxc7Bu+Ouj+aH1WAC/gD/LSEcs7VX+nkq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Jonathan Cameron wrote:
> > On Fri, 22 Jul 2022 17:56:20 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > Consider the scenario where a platform provides for a x2 host-bridge
> > > interleave at a granularity of 256 bytes.
> > Hi Dan,
> > 
> > Terminology not clear to me.  Is this interleave across 2 host bridges?
> 
> Yes.
> 
> > 
> > I'm lost in the explanation.
> > 
> > > The only permitted region
> > > granularities for that configuration are 256 or 512. Anything larger
> > > than 512 results in unmapped capacity within a given decoder. Also, if
> > > the region granularity is 512 then the interleave_ways for the region
> > > must be 4 to keep the scaling matched.
> > > 
> > > Here are the translations for the first (4) 256-byte blocks where an
> > > endpoint decoder is configured for a 512-byte granularity:
> > > 
> > > Block[0] => HB0 => DPA: 0
> > > Block[1] => HB1 => DPA: 0
> > > Block[2] => HB0 => DPA: 0
> > > Block[3] => HB1 => DPA: 0
> > > 
> > > In order for those translations to not alias the region interleave ways
> > > must be 4 resulting in:
> > > 
> > > Block[0] => HB0 => Dev0 => DPA: 0
> > > Block[1] => HB1 => Dev1 => DPA: 0
> > > Block[2] => HB0 => Dev2 => DPA: 0
> > > Block[3] => HB1 => Dev3 => DPA: 0
> > 
> > Block[4] => HBA0 => Dev0 => DPA: 512 ?
> > 
> > which means we are only using alternate 256 blocks of the EP.  Does that make
> > sense?
> 
> Yes, but I found a subtle bug a bug in my logic. Here is the output from
> my spreadsheet calculating the DPA_Offset for the first 8 blocks when
> the topology is "x2 host-bridge @ 256 => x2 endpoint @ 512"
> 
> Address	HB Index	HPA Offset	DPA Offset
> 0x0	0		0x0		0x0
> 0x100	1		0x100		0x0
> 0x200	0		0x200		0x0
> 0x300	1		0x300		0x0
> 0x400	0		0x400		0x200
> 0x500	1		0x500		0x200
> 0x600	0		0x600		0x200
> 0x700	1		0x700		0x200
> 0x800	0		0x800		0x400
> 
> So we have 2 endpoints at 4 DPA_Offset == 0, so there is aliasing.
> However, the bug in my logic is that this fix for this is not:
> 
> "...if the region granularity is 512 then the interleave_ways for the
> region must be 4 to keep the scaling matched."
> 
> ...it is that the number of *targets* in the interleave must be 4 with
> that split handled by the host bridge, and leave the endpoint interleave
> ways setting at 2. So, in general to support region-granularity >
> root-granularity, the host-bridges and / or switches in the path must
> scale the interleave.
> 
> ---
> "x4 region @ 512 granularity under an x2 window @ 256"
> 
>  ┌───────────────────────────────────┬──┐
>  │WINDOW0                            │x2│
>  └─────────┬─────────────────┬───────┴──┘
>            │                 │
>  ┌─────────▼────┬──┐  ┌──────▼───────┬──┐
>  │HB0           │x2│  │HB1           │x2│
>  └──┬────────┬──┴──┘  └─┬─────────┬──┴──┘
>     │        │          │         │
>  ┌──▼─┬──┐ ┌─▼──┬──┐  ┌─▼──┬──┐ ┌─▼──┬──┐
>  │DEV0│x2│ │DEV1│x2│  │DEV2│x2│ │DEV3│x2│
>  └────┴──┘ └────┴──┘  └────┴──┘ └────┴──┘
> ---
> 
> ---
> "x4 region @ 256 granularity under an x2 window @ 256"
> 
>  ┌───────────────────────────────────┬──┐
>  │WINDOW0                            │x2│
>  └─────────┬─────────────────┬───────┴──┘
>            │                 │
>  ┌─────────▼────┬──┐  ┌──────▼───────┬──┐
>  │HB0           │x2│  │HB1           │x2│
>  └──┬────────┬──┴──┘  └─┬─────────┬──┴──┘
>     │        │          │         │
>  ┌──▼─┬──┐ ┌─▼──┬──┐  ┌─▼──┬──┐ ┌─▼──┬──┐
>  │DEV0│x4│ │DEV1│x4│  │DEV2│x4│ │DEV3│x4│
>  └────┴──┘ └────┴──┘  └────┴──┘ └────┴──┘
> ---
> 
> ...i.e. it is not always the case that the endpoint interleave ways
> setting matches the number of devices in the set.

No, that's still broken. Even with the host-bridge scaling the interleave it
still results in stranded capacity at the endpoints. So, in general region IG must
be <= Window IG. The current implementation is already blocking the region IG <
Window IG case, so forcing region IG to be equal to Window IG is the
solution for now.
