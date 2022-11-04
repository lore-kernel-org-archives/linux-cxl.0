Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A6C4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 17:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiKDRwu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKDRws (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Nov 2022 13:52:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6400532065
        for <linux-cxl@vger.kernel.org>; Fri,  4 Nov 2022 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667584367; x=1699120367;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UYvsETL9LZiW5TyFqjSjiGBI/cUh6dHWyBKTHxPhK6A=;
  b=hxWymh7aBctWz3WVCfTkw4bNHmppz35QCPdrlUQVBjyelpHem0KuSTCC
   jnEG+OcH6u16haFbSlxMHNkRkQKm3LnQyZhSFX/JpERbIRCcY/RJw4MiN
   UjM8rq1RQjEaQldiipO5W5VyQ2PjDLb5IrQTBzHoQfnDyfATurgZILv7M
   kS/f68CKI7u45pcZBVuUuCvYsNVSEUNBN5iQzuMZFZtlNsjQ+1bKfrUcM
   DBdtEPUjUhW5vFzZycASXKlEj7wd36aUtu8iT0KbwqC78h8pwxr+lLpsj
   Rw3ashkmtE0jd34Q5G/kPY7Rfzlci8eobKXXw6kiPYlJixEPO/5wzS+mV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="308739282"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="308739282"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="704168757"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="704168757"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2022 10:52:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:52:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 10:52:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 10:52:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 10:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1m1U/gS7vDbfv60LoBueAGgFByy3n6QLApSZSiadwFZtHMT0AXbGOipdrSijikSYQ3JoFAqCeQ+Syw3fzkG70AECo4BPxDZyMeizbEmJT5zAiDfotfdTbv+gNhuMq8JaEAiSKcuDF4xrJtG62DgOO/35JtctiH5lEFImqzQxxumMcd5ZYlwucvbuUAzXx0d1iCdHmWUpREwSzomsu2Mk/J//Trei4eeFI2rpWZHCqpY9rYO1lYFvIOykr/mi3HBQeafpiWWQp+Niw69hCOhOHZx2cyyUQqbXPbTgmXZar1upXgWMQwfZ36USxtfit6qrV44RzA/hd1AYmrADGXs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtkIedjH0dUp8pF9wxgxYF4UA2wqWEu94jBDy+e+Ays=;
 b=W20tZVakJh2C+r/LTK1+e6T4PAdz2ISL1tnbSXQPyhWWudPTdp8CJ8y/WEwp04M7tXnm8z6Yp++ja8ti9zfanhujhdaGJRhI6m1Tu2RJqypXixvHJejJb+d25VJiYNet46J1DpqxXZ2HrdsoPKxxt47JSFK7aafA/TRHvUtxR7Ug2IGTeCizFBE5CuJhaAyluWdn06DyXhZjT3LEORb2pTvNX5Rsu9j2XMVn5/sdWRQrMrv0zL5k1aQ4gDkFnxHNB3aKlcEiyutq+9wodObUuyPplWN4cazYFOYC/FUSHJqZAjCJUS2ywlzrZnZ5FtcR0xOMiVKSU5Bojl5UjDPQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4661.namprd11.prod.outlook.com
 (2603:10b6:208:26b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 17:52:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7194:47de:c1b1:2f63]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7194:47de:c1b1:2f63%12]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 17:52:43 +0000
Date:   Fri, 4 Nov 2022 10:52:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "lmw.bobo@gmail.com" <lmw.bobo@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 5/7] tools/testing/cxl: Add a single-port host-bridge
 regression config
Message-ID: <63655168df26f_f52ac294e7@dwillia2-xfh.jf.intel.com.notmuch>
References: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
 <166752184838.947915.2167957540894293891.stgit@dwillia2-xfh.jf.intel.com>
 <4261ecfb8d659cc16ca39e9411733ee512138525.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4261ecfb8d659cc16ca39e9411733ee512138525.camel@intel.com>
X-ClientProxiedBy: BYAPR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:a03:60::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN2PR11MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad951b2-ba90-4af5-7b1b-08dabe8d5fb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFEu44WasbEvhZ+nQKmTSjlm0vLtcY98kBj4JwpbYWH+ojy1FXTzH7KhGhqH/44iAg9+k5dbKyVGbxmptWLxWYoJMwwKlj8BdCKaLJKDzIPjTe9AilAMokEI+19gR43cgcfZ8RgR/5agmnCbory57Uq/Pq6HQeyVL2roCfiQPRoMyIwNgmWJWjnA+vvnEIAtEgqV+UKrhBRoOQvlEHUOX+E1PrOBgipzXQyf4LmrRfq2sHH0JpqlqdOYT9lHD+gzi5kNwHTbF+zLREXvKcNUZph1CYwkl/08cKNpsJDtHCgI+BjC4K3pbd61looAMZugzZRcY2KoI4IfZNZqQjEtgPQOameNEJHXUCBfkJUVMb1Uxq+GjbiwF3UHezdVIznIIBkiC8ulVeuKzV8Sh0xHX+aw38FWcyu1l4sEkDAc02k9s9LxSLNO6EB5uFLtReqocGBEMfs4gllpT6kz79kO0lAeAmh3jPqt7tOAfUslj8FFTxyPMM077pExiEGBuYsZsaVL629eJkzu+tVEk1DYbFLvVFPYPB03a0LtHowW5VcA+GwOv81f8TbBXCQgoY2thIGrX9qMNupWxF0GuRmFB+X4ntoumbk5STZ1ZNlYC3lPfHzX8aE+AS1ZWF9DtU6s0335GftZdGDi9oWBfmUUE1X34IZyzVs67u40ARn0sVHpPwB8RtILiDy4AoF93Bu8gEKPJXVJY/ifJGw8qBm7cK6arIMZ+hr9URWVbCVHQqGOh1hkHEjxshSvQ71Brgfq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(38100700002)(4744005)(82960400001)(41300700001)(107886003)(8676002)(4326008)(66556008)(66476007)(186003)(2906002)(6506007)(83380400001)(8936002)(5660300002)(66946007)(966005)(86362001)(6486002)(316002)(478600001)(54906003)(26005)(9686003)(110136005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1U+oXj7UCPUo1mE6pQ8aN8cduM4CoxE+zpY+HIQ/yd4NeFDAYGwUR7Jthk?=
 =?iso-8859-1?Q?+x2B64htnLvmBa85+7Gl1GmnYQ7OOTfYJWkq1QKHmo06GmdioA7lsk/jlB?=
 =?iso-8859-1?Q?AwgSELI7jEDJnQeZ7k7DQkRj8WNlQYR+lsLPWINWdCs43EFnTYDGko8S1y?=
 =?iso-8859-1?Q?ysy7nerNdMUwVlcVCqMDtX8qb0S6aNvOsTl1Z0RQdN+nm8jO7Iklc2pTzG?=
 =?iso-8859-1?Q?56CON+np25Xk+g3Mabr1XhT77ziZNjL+MTZUelFsIOhf4K5I/5nxXB1CbP?=
 =?iso-8859-1?Q?mODpsSzMZRzXlnVhLgaYX3bqnrYpllfeYZrqcxjMlStK3IYX+YMthebehn?=
 =?iso-8859-1?Q?MlKDcazdU0f1E8m+Cjt6zdhRBKtf1CHSKyzvXB1UpS1jnAToW+30vW+A5h?=
 =?iso-8859-1?Q?aNHoufXEJOm0zpu0BcSiDe/1AlKcW/Sg1j1hq9xRLRb7YK+bT4c6UxXbH3?=
 =?iso-8859-1?Q?DzZ+GaV4PYVZCp6P7QgLtW1dkswjpmEhdKzF7B4Ad08zZRnewDBOY+qikp?=
 =?iso-8859-1?Q?p8/j3lpXbPzXUXFFydtYp69++8+7oJNa9j0UYzGnglij1TSEx00AS+n3i5?=
 =?iso-8859-1?Q?EQBDkF1mqufXH5+v0V11orc6q1v5BiVHZsvyYZjqIpt2w4X5GhJGpH+LdC?=
 =?iso-8859-1?Q?ZEekgv2BrWorv0uq/7CA5JCQBEdivkiYAqeCF5J1bVS1S9UImXnlsi9l8m?=
 =?iso-8859-1?Q?rTAYKLQalyZrV7/DSOwEqBB4su7C8fuZfvDiATMkHQDApx/B2UNaa65m/x?=
 =?iso-8859-1?Q?7JAwLXI/bT4ezuUg2CZBacj6FO6JcHOlOtfiJIt1LLiZ8f5VIpu0foUlbn?=
 =?iso-8859-1?Q?1oOD7s/s+l9zzWeNhrZgLNSiSZtyWmU8OHexeLQJLkX+2OBuF+tYkc0G4Z?=
 =?iso-8859-1?Q?hRaP1dW5kpyG+ybXkfDbi7ZL9UP90139BJ4dpoFYxGxgF+hKEnV1tklJu+?=
 =?iso-8859-1?Q?Rgs/0TfPJdvWC3JW7lb2B/7blWXYqrKlst+rCz6h4DyXqpUfPWq+zAKa7n?=
 =?iso-8859-1?Q?JCVRDq5NKCYavFXnVaSwlWDf15KLm3DbJrRvKTWfVOuQ+hWYE8FV6xYm8I?=
 =?iso-8859-1?Q?LK6OCIn0mMSbIYpBj7iMOUD3NFzD1vx9TtlapKawPc5EAS9wZUdiw2CmUQ?=
 =?iso-8859-1?Q?haUUUu8fnKy75XzZ+O6jGp+RKe+1VdCEQskcqdJAibKkGmMowcSj4ZMi9a?=
 =?iso-8859-1?Q?V6TiukhEbMcPIW0kSU6+u3y6KBWA86zyXPFYq/MI3zKktDOvrzvFgtf4nW?=
 =?iso-8859-1?Q?jOT5ZN8GErNVygEjnHeUUk162hAQbaTb1nAXaoCho5m0STEyPtuc26QRCu?=
 =?iso-8859-1?Q?jvLa6arSha4v36XJZpouTrn/SRC6Cs7uXESKH6A3pUoumJUzicgwFZz1Ec?=
 =?iso-8859-1?Q?L+rXNPxl1A2Yn4SNAFAx0lcJ3R+o/ZR9EVjjQD2DDSeLZTFg8p13KySMAl?=
 =?iso-8859-1?Q?JKzx2qQ1SyItxNrs//ZXazXWi7eFwyluQLk5Ci/vAAlxnFK2NM/I80JbYR?=
 =?iso-8859-1?Q?ax2DktXbo2zpriixgJwZC1lix5HiX3xt3TaUyRR+4cCZOY6rBZYPe/uyiY?=
 =?iso-8859-1?Q?JZ0osu12q/KploVBjlcxmtUPU71Dz4nAjbeGjDKOTkC0Lp2WlW37Sos1YH?=
 =?iso-8859-1?Q?9FR2inZN35noHM7sk8D8kFUcncu9h5AOtH3H3w110sYZxn6xKaYZU69Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad951b2-ba90-4af5-7b1b-08dabe8d5fb2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 17:52:43.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pvxoTnovKR5ZiRL4JTmPzLU//nGA3kCMrOudjWae2NU/FmTPV+iNtCjii4XvQK5eswXsf5f5Hz5FcPkVmzhd4EWcPusgc9PKjsHFccCEdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Verma, Vishal L wrote:
> On Thu, 2022-11-03 at 17:30 -0700, Dan Williams wrote:
> > Jonathan reports that region creation fails when a single-port
> > host-bridge connects to a multi-port switch. Mock up that configuration
> > so a fix can be tested and regression tested going forward.
> > 
> > Reported-by: Bobo WL <lmw.bobo@gmail.com>
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Link: http://lore.kernel.org/r/20221010172057.00001559@huawei.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  tools/testing/cxl/test/cxl.c |  297 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 278 insertions(+), 19 deletions(-)
> 
> Looks good - I imagine this will trigger an update to the cxl-
> topology.sh test, but I assume you have that in the cxl-cli queue
> already :)

Yup, I'll send that out shortly.
