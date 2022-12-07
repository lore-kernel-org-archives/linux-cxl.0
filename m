Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2CCC352A1
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 19:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLGTRC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 14:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGTRB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 14:17:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F9C578EA
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 11:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670440617; x=1701976617;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xxT/LySfYUBHOBqEBXIbkjRhHNq+A5fhtjUmAhwms1Y=;
  b=XwjBwFHGEAF7RYyUGd0aojoQ16H68kM2bSdgxpkaeZ6GvflULR62vLil
   E7r7HJ7JyeZCZJzH0DYas5UgQf6BJBRn8X3HuirjkyYf4VllA/Nnc5zyO
   /9BqNWnucTAiXcfqctz6YGtnP+mzxskXWK7fCnCvhzEuHuS7PzNZvUP9l
   L49+CKqX/mHZQzjjjjj7mZonQ/2v99jq1MtNddoRt0yReXf5GQk9MoS+f
   AF11yNZxYZhcliBMvpVDyb3qDccUEILtIXB9GoEPT2Rz5eWmtPo2gLmdh
   OeZTkCxXaFIzYCVs4jTfVhXJqC0bKHPYDh6+YC4QNYy9mOrfgVwfSVdQD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318119052"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="318119052"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:16:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="648853310"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="648853310"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2022 11:16:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 11:16:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 11:16:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 11:16:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 11:16:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjacBFCRJDmhpM5lY9DWN2RMFLi22NYqOneYOmBBNTFeIZ5Xg6OnxNT4S8a9rHchJ/cZ8HiFTicmB0ecIXGgCNfiUh9mdOB9yMbwa3ZVPddNZf140y5t9ioxhcetCE85b4aB+QT6F7L4orgshU1FmfsG/6O4FLEFB6oUhve66OTHk9hqytD69TWrWzR3tqyRMZGyb1xjfnoDZu7ZwIlT8bxQjk0C43NpW6e7g11gqPbS3vEpu02iktmNXF8G2gjA8lGG+sCzqzmBlVrDW4SpzTfAyN3murJvIa9uQewUYlU3Q4/rMMtfP0s7TyXPHtFtBGesc8wcTur6wQP7Km/DBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRSm8BBC8ZEoHZzwKn1CheBBGktZ6D7ZG2jA/p9jLiQ=;
 b=RM2dQYNo2teCbl/YKZOyNiagwNRd2Ao9VdVq0f+6vZ1VtrJYm4YdI2G/l72yRXyF3QEnqt59VHvQmL3DcErhuChIpPIYsORGo+lWvsiesXF6mDlpAr4smriiBa2CNSfTmdi0HmcpVvAsM1ueok7k7qSSgseXy21eEh/Dd9sBQVf2tQcKvcuV0yiWvZL3yyf9uTZnNAHiDz2R1pj8Iwe1t28E7S9kcMLlnB5yIUJ81ttfPj43dg0bURvjLZugBcdRpFTFtpTpT/YE0hBqpMKxIQfa70YlaAM3l4ATR1JQzvY6ExsDwoI7iSkbKmRAUTrSNxcMZoAiun1uLOvFeHD0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5197.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:16:53 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 19:16:53 +0000
Date:   Wed, 7 Dec 2022 11:16:50 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] cxl: BG operations and device sanitation
Message-ID: <6390e6a24fa35_3cbe02948b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <638fd9c2d11b3_3cbe029448@dwillia2-xfh.jf.intel.com.notmuch>
 <20221207030314.4xzlqhe3kgl5r3pp@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221207030314.4xzlqhe3kgl5r3pp@offworld>
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad88573-35e1-4fc5-e613-08dad887992e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2Rt7soTVh85BsfqEuygbKQZ0fe40G2Z+Nz5L2ce/gPF2kKvx4FnxrQ/kJDA07+z3s16FA74L9nRknYnKZaFSypsaibuWl+wrYywimYyMSDWwOEGO/NdaZQqy1vE2BcWe+QO7iqU6e4ysfT78Ea05qBbHbc/qJKfJsPEPXNosvXNWn5Q7Y6/SgdhDv2mWdlJNLt0/mgGbX6UTXpucGPR5m4f56aSWRLdJNF/yF/cPIlyAh8ZYCajEISi/bJBh0odHSROqq2SHUv86O/A6p/m8qsvKHbnruxee43kp8Mh7kBVbBumW1IxKwcq/UXuHMqOEGK3uTspaNiitj88gzeW6TcGqRw96cAAvoiO+Pupl1fttXNbDxFVqpT5TY2fDkqdKZSSuQLcPnFNUFUzEwWj1MWbN8ebxVb6J4OvNC7XvqziO50a6XB5FGC0jqQXHAjer2PtzWoNKCVebDxN8m7xbx8KPxkDLWBPIfs6JIznP3l13mtdSdkMxZJoetTaFsYzG3Z7VGidh4zcXL9z6oRhukaDeyRSy2QGAN5qxGznm5Fx4DX9CxGVu/YnxSyNDhs5vPdXAesF9wAUwwaDLx2MvIR2oeVYlvomB45wE3z3YFTiMNCJMDv22xyWGM2R9gqt6kgKZouYMvlNLEyzN5hJug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(83380400001)(38100700002)(8936002)(4326008)(66946007)(66476007)(86362001)(41300700001)(2906002)(66556008)(8676002)(478600001)(5660300002)(6506007)(26005)(186003)(9686003)(6512007)(316002)(110136005)(82960400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxZLNmCCr0GZyTGmG/KTmHX8JehzL0ssboRvIE5/Vy30Hs8P04mP48w7ZVLC?=
 =?us-ascii?Q?8WSX04yQ5PJxsvwA7WYF4vXyD2P7NFRmwYyLHDQQ9Z4CdlAgnywnVnaSDSq0?=
 =?us-ascii?Q?h2Q0WnVjq/jxC5gzt+oI4WYyhPFn4jtiZ7aXGYnEoz6OpXzw+onT+vTAwO5r?=
 =?us-ascii?Q?HrcYkh2SU3A1marADqMssr57k6cEiKD4KKriTZmNFuKhobsf9RBvfMw3i7JB?=
 =?us-ascii?Q?8Rbo5LhQ/NfH7dDsCbA2PUaEnR3XcGTGxDwQ93WeiQlX2KDYD7KOI5jDTpS9?=
 =?us-ascii?Q?v2As3D9C+XH/9A4D/nSoD3MqKogYZZGL7dDQLFZgvDYHPwWwIPLKRvq4hL0I?=
 =?us-ascii?Q?g07yAN/EmmLOx4t9WJ/d6aXrI8o9gLQ3Vxxf9wJqzHtmPUfdKvsZ000FhtsV?=
 =?us-ascii?Q?6Da9ZIJZ2jAYQ7SVPGH2t32+D8TfLXp0o6wDHV8dWibmEKNeKZ9WrDXqGCac?=
 =?us-ascii?Q?25ZoL/+xT2fC8SiJO4mtCeIYsTgtw7yPZYNT1gtb9xO8Vz3AtSZU4QI7YSFZ?=
 =?us-ascii?Q?s6cSunRNa6/nvMAToXFf4f9l6nAiVPQLjlHsR4vflsv4qV/RlVqJrhbAlNn7?=
 =?us-ascii?Q?7MXzLi7lGnoO/ADt+CEUfxBtArhHKBmo2Jc9s0OK/hcXdTmx+t/+220U+DVt?=
 =?us-ascii?Q?ZZ42dKkePLhhKuSmNUDiGWKXP5OWNXXWYrkNHPxCaIXspdODqOgW1O55m/0X?=
 =?us-ascii?Q?Ht4dZrs52ynViWLJpLaodjlEJalh2V/EeKKjABOoJJw0sPe4VwqL9XwU9zfx?=
 =?us-ascii?Q?MrmDBG/yvxojBGHBstqE4pUs0yCG0dCTmmSwUOb74K4fd0CRsIQSJlNac9eu?=
 =?us-ascii?Q?HrSZd0OsBvqYy1wuCNCUDKb8r6eNoKkvlc51BtD2sWxSizQRADvcu+SuwKHO?=
 =?us-ascii?Q?5kC2fLP71i6Ku64gIsf6QuJFyxDiCdWly+msY2hdrPDz3SqKzezEEomKxCY6?=
 =?us-ascii?Q?WZqkWQ+M19cITkt2X/fC+aoXrIFvvM8rY+sPkkKwlFD5fOcmp7lh6L7PcLHU?=
 =?us-ascii?Q?Qxc0m5h9NQA5kVqGWLXrOLQRN5MNTkD1yks1N58IUxPlSsKSOl632KgY2oUo?=
 =?us-ascii?Q?iXfu9YQFI3FLfCk9O1NafprGqd5/Gg1XoF6roLWCesZmPtmjfkMIqf2KfC0x?=
 =?us-ascii?Q?iYrDsZ3hXsIHSNcDAMalpXMQGFjmrmd+wqAZRINhjFp/Mr6PSoAcornX9Abi?=
 =?us-ascii?Q?8EjQpZEsWfbKPtVUanX2Bm3kJv9cUpnFnZ6pHR8GAdD4+8KTorizRzRRKvhz?=
 =?us-ascii?Q?hXIO/QOTVSJMKRbt2bt0XfLpQ9NSxMZycbNpctF0htrFeIsf+QuwjN55R1Mx?=
 =?us-ascii?Q?oYcGtoTWVv9E6wXn2ctwgrLJN7qy99uiHeJ/Ptilttp5vqPWghWshHsdtxl5?=
 =?us-ascii?Q?K7Jz4KlTMRwTR3K5XsECGSO7TUSR2AvKekUSU/IqpycSXx7Ys4L+Q7mdCeu2?=
 =?us-ascii?Q?TrZH1JBh6bzwBmZSzqV+fZT9BnCUt08T3D+AHFIPKVZVWBQ2AmnJaPncL6jS?=
 =?us-ascii?Q?5IP9H6494wHjZh2lBE/GZxw37YRxi2BP1beunKeji5a5Y1GBpMw8sikvri9y?=
 =?us-ascii?Q?5A6rdjmllhrNVK0ultZV+3lw2mQLiNCYfNEZjpm+MTEbOUcWPU0sReOJb5+n?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad88573-35e1-4fc5-e613-08dad887992e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:16:53.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZhmX1gOtGdWrxHF0/1u+ZC1eYJujwg3aUo3Ndh1CiAyf+t0yccroiqn6Yo9sAKaa7ktd0yxMf4iaFe1bTMXDvRw/XO+9YMZq01NzIEjhcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Tue, 06 Dec 2022, Dan Williams wrote:
> 
> >Davidlohr Bueso wrote:
> >> Hi,
> >>
> >> This series adds support for the rest of the security related cxl operation
> >> which are not strictly dependent on PMEM.
> >>
> >> Patch 1 adds the required background cmd handling bits. While this is currently
> >> only polling support, the idea is to follow up with an irq support once the
> >> bits land in Ira's event work. All polling-specific code has been marked
> >> as __maybe_unused.
> >
> >I will take a look, but this tends to put me in the mindset of this is
> >v6.3 material that should wait for its user. Was that your intent?
> 
> Thanks for having a look. My intent was for 6.3, yes.
> 
> >
> >> Patch 2 implements the sanitation commands (overwrite and secure erase).
> >
> >My concern with landing non-PMEM secure erase is that it is not scoped
> >by partition type, and there is no existing appartus like there is on
> >the nvdimm side to make sure an erase event does not collide with a
> >device in active use.
> 
> I can drop the secure erase part of patch 2 and just leave overwrite.

They both have the same problem, they need extra safety to make
sure that the device is not in active usage during the operation.
