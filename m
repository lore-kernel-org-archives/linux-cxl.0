Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15098C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJKVa5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJKVa4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:30:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDAB9081D
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665523854; x=1697059854;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ymDMeAUFcKpIql04R1ecxRfVDwT8DymEFITTh3CBAmw=;
  b=C7+CdEGUnyS8vEL3y6RordIv9gtMxWy022HJdb2xhV0O0VoF5Y+q6ePI
   w0EsHF14p6l5XgM6ZcyUwPFdLnr1u86gQ/2GXfmT621v5ZgaPvIvUpnAB
   M8Ia1XceCTBj48zWGEZt4dT5IiOPEFR1SJ3Ty0zUF+0s9g0y+ob3QNjTL
   NTwtWjrS30meSoqoOYt2LviZOwJeChAK0w++mZhKvOCSY1Ob+ng1GAQYr
   ee5OXkA7zSrlVJEKSvJbyj1xrPUCffVjRsCecHq+dTXNLH8Wi43bwKIck
   HlkOoa35DC5j7dsSOzSAmRt4mArKphZmYfJd4mi/EwX2TcpfFfocUQFEZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="303370794"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="303370794"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 14:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="657517571"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="657517571"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2022 14:30:53 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 14:30:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 14:30:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 14:30:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 14:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyniFxzvmHtyDfBHSVu7ActjHEX9MGapOepHduXXTzlmfvF+itZeSdzIVqXg7aR+FATAumgMSBfeTusdZ5vVUrQUMBWFzhFmSnNaTE+qc4Jgnzf7oG9psQBnzBbHMSyDEhEUXDNKc/ZTGBomkhZM9wKr8NbGeE7QU5Gn7hcoK4Ib+piibvj3BAiRBMBPM2LRy+AfvOeOOv1n2razL+hvCPI8vGjIx8uyN2Jcsf8E8Jb1P1GYvSGQlZXHF+cgLi/pdqkd8z6HPkFDLU5yvcq6aXKMj4ui0cPSPx3oQze6XULgPGfSAyDdnLlQ5mChFbvesq9LUCRVlqAxV2fLPwMdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEEXHjRDGASym2BTH10P534P7WMjaJqGLw53+w920bs=;
 b=c+6S9OLEz+GOBTyx75dlMtKEGuC5oPjkJy4VuQ5SBg1sbPoEiF+aJGBej0MqcACmJhT1IU4/5ki8Mys9F1/GcUJ6etLU91nNotwVtrI7Xl/tGLubR243etDHuL07Cra8ABb6V1MSXt7ySMEpGSw7EBm8mdM/tWypMcQVOGgWf0xa7qFwmB8pzrUWAijLEjXRjScXBjrXB+UVTHSkmPCuT+5TzlzX9N0Ous/OXYM7+TFdNDgi8J2DYbHMNTz9ZhxrdTf0Sbbt/IPqMwZ7v5ADeN32TyBW4zNNegBf1BAXJqa4dpzGNwebnmZZupqkZp2Z5/5r9MmrWbt/TlMoxCGqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB5928.namprd11.prod.outlook.com
 (2603:10b6:510:144::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 21:30:49 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5709.021; Tue, 11 Oct
 2022 21:30:49 +0000
Date:   Tue, 11 Oct 2022 14:30:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        Bobo WL <lmw.bobo@gmail.com>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference due to pass
 through decoder commit
Message-ID: <6345e086e44d6_117adb294f3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220818164210.2084-1-Jonathan.Cameron@huawei.com>
 <62fedb421d71f_11e5e3294bd@dwillia2-xfh.jf.intel.com.notmuch>
 <20220819093133.00006c22@huawei.com>
 <20221010171132.000028f1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221010171132.000028f1@huawei.com>
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH0PR11MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c4a3b7-f91f-403c-e123-08daabcfdde3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsE4WcTXHB+Xb1sSgosa230AtMaBI8Hc8z2vHKCQVCkMVdv1dk1SY61RQQZFqk0hi2xTpTB9WjIe3hxZ2LFqlGBhUVWE5uJQVSbmYb32/ybur1rPyLgg0t6siku3CpjVb4zqpQM53Bstc3h9fawVSflLiKTIb2GkoYT2J9YMac69kAXGnsUz6Hh2SEIpzE9Xq4ehlRdvxm4Qp8+Leac2J52E7auNY9hhHMe2dCrNNQKfRnSPFCzoDMXYO6Ej+K6pKHykhBpwE95S4WrtkScQ8KxTYmXGEiv416R4jg33xVcnHvbuUziwwHBDfcUPA7SWg+wOL90eLkdNi7AQm9miS9uC9q521pWDmhfCXcsYQzChcZSq8TAFnVhnPvncsxf9YZJYoc4YxoDk+2WHORNxN3eZN+1KSu3LhD2Ms/cmOuqQFs0FulyTcT8y/StnadAUZxsjTT4zKLb1u3eBcBx64Ry8CFahbJFNRXrSwN54Fm/yzDcZgPCfkjqrIZqgR8eV+5yf1//OaiSx8a9rQhMPpyS3A3Su6fvuOYCQ2cwRqEiJt60SnZg1WBNSqGsxRn5GYeclwIlcGWR4bwsTq2i10qwU6vK7x3UcnXPDOSd3lrOq4MgVjrlEAoA6RofoQzgj8aAYC1GwhybfJq1VRPg43jNPIt6uUOHcwAF09Qlpnq3zE/OFOnwMLrQ5IL/d5TNuNOMI6c9Gkax6A6vbp8Sruw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(9686003)(6512007)(110136005)(316002)(6486002)(478600001)(38100700002)(86362001)(82960400001)(66946007)(186003)(6506007)(6666004)(66476007)(66556008)(4326008)(8676002)(8936002)(5660300002)(2906002)(26005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?goOkmro/50xI7orK5Ka0nxepdpajZHsXBEhJQWW49glSLiVKB1cXmwPZuwOm?=
 =?us-ascii?Q?qFc5dnvqK5bIHEjBzgjdzsIKin6X6vgb9FaWBqoyB/ohva23fz7/b8meEjbU?=
 =?us-ascii?Q?LSqtQdWrcjDSapnfUzYGLnYzam3HiDZ6ON8SfHS+j/qM07I/Tz+9oA1eA5Ze?=
 =?us-ascii?Q?/qSKrTP52A0znXJ6qsScihlNkQoP24Q5XQZT39aKywyefbeVN3fAWLKTLEY8?=
 =?us-ascii?Q?mug+pHUYOqBypzYm9w9cNlKnr1kZOwigStDMzSV8JsUQEzPeis3CJ2jKU1RH?=
 =?us-ascii?Q?9GxQF769+Cmx71yt3Ejm1J1ZK6SPYQbBSioA8Y8LDMlhNsbiQ8MqzCn2Y1Pw?=
 =?us-ascii?Q?2R3n2x+Y8cbop1wy8UgRv1hY5JHTpDIueafPCYLv32hK/J4ejOnt9vVywA/6?=
 =?us-ascii?Q?D3Wv3Jl80xZyN95oqT0VnDyzFaUdiAL6vijqBH/LTxHAbL7s2SUa2WR1RoSJ?=
 =?us-ascii?Q?uvWsKlFtaYVvxi83Ed7Co/6Y15MZDq4DVcCH1rMUwMNKGP4rwNI9x6rR2MK7?=
 =?us-ascii?Q?Vn1Te4iO1MCdAhgBdcCRllCtzZV8AchZpsXkl1Tj9T1JpAcYMrXxN1JjkNgJ?=
 =?us-ascii?Q?ZeoiXVuGlOF5mYvQTOkWYa7yHWKuDhDFoPdPMK4I8XAoGLcREc32e6mwol7s?=
 =?us-ascii?Q?QJDMtv7s9siFeKPGO1Ni9KFA53jhRu6ojFs0Z5HlX88wmW2cRGLdJpFlzGDF?=
 =?us-ascii?Q?7+Z6frwp2lG/FyTYKNuMwd3OvbSDTJCyXMXYPt7bbgB1W5/F+H7qOgxAMH4H?=
 =?us-ascii?Q?rB4P6XzJo3eSnu71C3k3PhNw15OHe1wVfWz3OyDMrkSbgUxStanasn6eakS8?=
 =?us-ascii?Q?m4Ejvnq9GUwU0z1UBxjy/6XKDgs7fhbymlAWphbBqFOjbjy+ptYz8M38qUqa?=
 =?us-ascii?Q?0Ik/yYqEZKv/yh2CsORehh6gh3hdOmmFwcv7HQ5n3xDKGKDCFbd6Fa9MYSJB?=
 =?us-ascii?Q?W/BwVsW/+BjfMzVccnT1MwG0U3tV8KJnKxEfezqa+yctidwrgJOjPf6p5Fwy?=
 =?us-ascii?Q?ZmJKXxy4b0ZUe8FetHVmOXvCL1uFjY9S43f9fxhCqo2kTeDuHAhdKY0Xs2Uy?=
 =?us-ascii?Q?hUqHiuCsbcXN4nNZdxbceeZAKq6T63qvOeyY1S54VmM0Ywa7arhzo6vXqEkK?=
 =?us-ascii?Q?BQ1xwTfJWbA77Tvt4ixpnxtEAu4Pc87v9bfV2kW5X7smNrgFVFLDPjT4ze0B?=
 =?us-ascii?Q?cDze24hehvWp5IQvL+JVkAqKmRgwcm7wxt9wKOnfxYwPhCOXUkGRPylGFr6b?=
 =?us-ascii?Q?qsJ7YGBF1rf6ujjD4PxqGH6I+ceZlfPMrDFHYLYR2i238ye+SWIKqVOsKZ2F?=
 =?us-ascii?Q?MkEqVQCftIry4G0kZvaA23FdgPi52Xv1wV50Zdpr1Mog+YrNk0UT5s+fBEDd?=
 =?us-ascii?Q?SprXWIPZtiezZwfwaq2XzdUm1eAjUt+cNs8qauzPcUe2i44jtQmwIb9T1ErC?=
 =?us-ascii?Q?9gUqAk42ogVbmetM2yXreeRBo/V+UMaYJxqABiHz8MwmnRH+0QpGvQO7r1jT?=
 =?us-ascii?Q?wuEVCmud4V8/rDhDEfQSCSwaDtJ7DipdZPSr12U3K7oUc6ExNlaYH3F/BDwL?=
 =?us-ascii?Q?6H7KcoC15+pRpxG+jHTpACPogzLFYu/c6aoXjEITA59bQXan3AALmJOzm5h8?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c4a3b7-f91f-403c-e123-08daabcfdde3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 21:30:49.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LJuJUL9lhvzHuTpvFlnZhTlQv9Ra7Lt8WkkzLk26almJLSrXoRohVEoYxc35yKThllIwHJN3SEOJWIsgXxlPNS3flBjciczdgzDRNoRNV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5928
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 19 Aug 2022 09:31:33 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Thu, 18 Aug 2022 17:37:22 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > Jonathan Cameron wrote:  
> > > > Not all decoders have a commit callback.
> > > > 
> > > > The CXL specification allows a host bridge with a single root port to
> > > > have no explicit HDM decoders. Currently we assumes there are none.
> > > > As such we create a special pass through decoder instance without
> > > > a commit callback.
> > > > 
> > > > Prior to this patch, the commit callback was called unconditionally.
> > > > Thus a configuration with 1 Host Bridge, 1 Root Port, 1 switch with
> > > > multiple downstream ports below which there are multiple CXL type 3
> > > > devices results in a situation where committing the region causes
> > > > a null pointer dereference.
> > > > 
> > > > Reported-by: Bobo WL <lmw.bobo@gmail.com>
> > > > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > > 
> > > > We could fix this with a stub function perhaps as an alternative?    
> > > 
> > > How about keep the callback mandatory except for the passthrough switch
> > > case?  
> > 
> > Should work, but makes it messier if we do add support for HDM decoders
> > in the pass through case (which I'm 90% + sure we will have once actual
> > platforms appear - we regularly have PCIe host bridges that on a particular
> > platform have one RP and on other platforms expose multiple - it's just a
> > wiring question - I doubt we'll bother hiding the HDMs given the spec
> > allows for them to be there in this case and it adds complexity to the
> > design to hide them).
> > 
> > Keeping the cxlsd->nr_targets > 1 check in one place would be my preference
> > or adding a wrapper. e.g.
> > is_passthrough_decoder()
> > that we can change easily later.
> > 
> > Either way, focus now is getting fix in, can change how it's done
> > later.  So I'm fine with either fix.
> > 
> > Jonathan
> > 
> > 
> 
> Hi Dan,
> 
> I forgot to test your suggestion. Now done and it works as expected.
> 
> One comment below.
> 
> Given this is now your code, do you want to send the patch or is it
> easier if I do so?

I will take your fix since it is easier to backport, and then follow-up
with a helper to make the expectations clearer for multi-target
decoders.
