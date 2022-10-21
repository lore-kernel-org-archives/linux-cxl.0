Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB8C38A2D
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 23:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJUXdb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJUXda (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 19:33:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C42F2AB11F
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666395208; x=1697931208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kLRrFuCTXQORZAHKjlCzm/+ALYE6fiFHoI48jl50dvU=;
  b=GIOuv23owq5iuKLULPCTf8xAHE6CU6yveKfdIFgQ0bmuBlUh3DxolYO7
   n8knS+Nao2aRS4do40T7eGk6Gzvae4RO2tNjwM6XfjXIbPUSjWUfjvtbO
   LR+F9L+tBeOQmNxPWrqwbCD2IW9U0ydjoW/tkUMmSGjO9qGfIR5UbezOU
   xbFwQV581R+7iu4BYz6JXQyKw4hRVgIS3jpA2pu9u4b1Ng4+LWCTeDh3B
   kUQ3XmPRPU1YFPWJ00Z+pNKemPp4OAJJ152kXhorCL1KnHGaVAk8SZMb+
   RP/X98BYzwXRVlZpw0K9RqV+KlNwrhOcTLRaeMpVl4SOV1AurNcrJ9udw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308813982"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="308813982"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="625519031"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="625519031"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2022 16:31:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:31:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 16:31:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 16:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X85rt1zHsG98rxtdijQTScuRoL46Pc1fv1S/JUR3byR+14axMlcjg4xcRLytazm1HLH1b+hG1buEhqZz1oL/haoief356jtDZabqpK8Ru1B+rA7Awm+kLXdU5y3KehVBLNeB2DegUc8vCksgKPJZCSlkNqTDEeqxmThAZuf+Py3vbjX7v04aK+tXO0qmi32qrgzYdMiSCJh3OnNq+ku7jCbq7Ht4NMTKP2KVlHxcELvb4koF6nF+0f5CbncsQph77I/9yCwJ2MzeBSl2T5i2OHo9sqr3o5/2avwblgj7I3luZ8DsxZ3tlsSw7CJMA4b/W0PQ8OGrkcNhOcE334zVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP339ics0VM/cY0/+V4m0eXVHGo4IeGTDGMP6YojAIc=;
 b=dNG+RcDXEDXRkDhySM9DslO6/+wioJt6XAwt8PjCQMq5fq+6tkDgPTQ7ZL03lsRou1uDaxF3BT7VYqARyauvsebHorz3PqA2qWajsN2wC+gxWM8BFnB7KiYDyKH/w6xtzE1AEYZiosPXUK4dR25K53xxDY+hutRsgoWg2hujiAjw7j98zrueuRRM/yt62N29woPFhI1rfUnRQfIekev1TjQQIu1YIbe6r5/vTLGHp/S6CHVdOvsBmmtSIbf5uVYTNCFwpPhM6Yq9/wrKzx2cHamMmVtd0RL7pw+uSN65MPpcfmL47fxxsh2at+OIAW1o4b6MprwrfUj81tjzNI0Haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA0PR11MB7306.namprd11.prod.outlook.com
 (2603:10b6:208:438::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 23:31:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 23:31:03 +0000
Date:   Fri, 21 Oct 2022 16:31:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH 2/2] cxl/pmem: Fix failure to account for 8 byte header
 for writes to the device LSA.
Message-ID: <63532bb5576c4_4da32942e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220815154044.24733-1-Jonathan.Cameron@huawei.com>
 <20220815154044.24733-3-Jonathan.Cameron@huawei.com>
 <62fac0de2685b_dfbc1294d2@dwillia2-xfh.jf.intel.com.notmuch>
 <20220817122930.00004f27@huawei.com>
 <20221010163053.00003207@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221010163053.00003207@huawei.com>
X-ClientProxiedBy: MW2PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:302:1::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA0PR11MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 566a1ee7-b9bd-4f26-3831-08dab3bc51e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0Uc3QEHbF/iVmhn5lwzaSuarMllnx7HQPouVmrnIbrEvQ1BtIboDNNn3IfaKiqGj0u6tErXp6tWbQ1+VbHJLX/6gOoluBXmjXhJtkhfRJYUW847WFwqSD3bkScBgRIr/g1yOzpHj6g8Pg0ALSnEr3b2/wVqfR7HL4iETxyDDF8hqrg1/jDO9T6J2h/WffkO6Jd2kF4Mk4JDr8p5L55r6EuZYyfneTqpC84WlFd0R4ZDPraBbQ20JNNPp573TXjAWTUizf8+p/u4zywbQInigNQw1u56LLY3/KRtRaeNgHAuSaVLRFpUDHyajyN7dwBuCEqGwBo6xJCTIVQPOqBDtVKrBsgJHZw/ZLY40Kxk9wSGngW6LxcCxbLg3LX+0lX7zjfIecKY+HkdrnE0kiNdohcJdSGm4zYtRsnrHDR+2ZdHIKgc5WfDxTGLU2UjD0Z2pt2fGGrLMLI6ENZ9lQHYT6hk3+f/pl5MJcyzoEST6sXxANhov/Agn+XSJQO8LSEYWdcgqwijwG2Vh+2WOVTUdUIuaO98mcmTISavp7IwmQ0PCD2D0gdHohE6y5JT4UC8d/08iXSTmjBL4UO6pVcyfzQNyoI2t/JklxthPti6/0Ac30NeI07LSq5NY2pxV7CVWLKE6qbtJoO2R6b3rVffvPOyI+WznC7yC9xyT6YEbkOnrkZ72NHxlB/0OAVBYX28IHL/fZ/hUuBjo+gzYDc/vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(15650500001)(110136005)(6486002)(82960400001)(478600001)(6506007)(83380400001)(38100700002)(186003)(4326008)(8676002)(66946007)(26005)(66556008)(86362001)(316002)(9686003)(6512007)(2906002)(66476007)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ulh2O5tSJBxj7k7dI0LhhiR9LFZi8c69xsnmkckLNOnrQuUGClyqh79k1MH?=
 =?us-ascii?Q?+wv1k39miiVH8CdH9fOoNFdHbfBM08qzJUJK5VI6CYbNM96aI4FxQYO2RHVu?=
 =?us-ascii?Q?XjiJNWFe1c+UetLS9tH9WqM4+QSs2STW4vrvhEiRf1xt0cPZIrmZQvHSf2TR?=
 =?us-ascii?Q?l8o97pJcwdbUjzXqKV6t07mjpgffyiCHC0b5pZbZJXvrEK/uZEb2zITBeQh3?=
 =?us-ascii?Q?SIh5e1kUVni6ldhaAGdgzcgD3+HXPIdV+lrLHY9hy0Jc51llXeRomK6d0OMU?=
 =?us-ascii?Q?YNLXPIuhxBFuDNh6AXYd7JEHCRWJ9ru1SetVpVTr6+OBOjKiaRmdWCa7068l?=
 =?us-ascii?Q?+3qQmJTx4ij3nqXAjfdHFkIPlWtdfXVrssmOsh28Wb6D7MXTjppdB8HX5k6N?=
 =?us-ascii?Q?GIG4/aQ5yrFUtZ4eJdIcAZrGakBaPP1DECqEcfX63g4mx8XT90szim6eqzGZ?=
 =?us-ascii?Q?Np75QQMTb23bUU/oSQz5fUllIjojD/K0OGOOf0I4Tl5kpwvmA/K04kDxkxM6?=
 =?us-ascii?Q?7Hxx/6jyc+dT7CtC1GVeYctShticC26UZF4FXDLYrr9E7kJvbdQGmq8JHOhv?=
 =?us-ascii?Q?dSC23U2bRvw96qEWxuRrz3Qt8pYGFrFZNlpTmr8NebKGPxfI6kliIp2pPqJ+?=
 =?us-ascii?Q?WB/Uw7QT7bq38dYJFjkfWTioMIx9hsfZYiBAFGuAQKB9UD0g6pLbxhZHlRNp?=
 =?us-ascii?Q?Fko6M0kWznmGUQC9Pq7u1cWqTRGIkEN0R9tJXos4/fS0H9IolszU4QhBSbhv?=
 =?us-ascii?Q?kK8ldADa8lT6YCIRSsu92xTDd8iU7tHFZVSAJnDi90VuRwev+e6oHWeTLjhC?=
 =?us-ascii?Q?ciHQAT62Xl+ogSSLKGsa/fQkoM24170qtXjQQ+0loHqnsGnGNEp0m8rXSg/e?=
 =?us-ascii?Q?WNjg7P5BenleCW5mhAG9XtZVZmyfIgtP7/YaRyFs/B/hO6IhcSHOy5+5QQr9?=
 =?us-ascii?Q?jZgigHPSH0AaJ9z/2+5s5tSJiHIDjLpGFmU9UMiouTygttqsCgk1r92Ro8fn?=
 =?us-ascii?Q?Oy4dZ6EvGvrHZyxw/oFhbdvB+Igas1jc6yU0PudmmziL5MzOm8Osps1+MWDM?=
 =?us-ascii?Q?LG3HdI+B/CvXWMjvL/ZvZplS5RU5+4HYwlGb8m3VfgjLseQa6jUIVV/i6EG0?=
 =?us-ascii?Q?X8botV3ifLLO0+MTdXzFJP+ARiItWiL1s5fJrydbHEAaAEKHur6HPXtn9SeR?=
 =?us-ascii?Q?VJJB4ifpNDewD04qTDu3zcwHegQZlCKhLXnhZpOTdoreUwFnn3lEkK/UDESo?=
 =?us-ascii?Q?+Cu83useWXpn9BogTTGBIi0XnhbdoQeJ3nPD5lAC/LjQ9K0LFJQcicyQK57A?=
 =?us-ascii?Q?GIFafQIvutAxqC4NfkaG8lOS6MO8LDyOD2vuE3xLw8ioB/J7KrsD71SSXFKH?=
 =?us-ascii?Q?8OegcgL6oFCShkId8xzu51ii12huKpOo3I3bE+pMLOWCihF+zSWLa+BxyAuF?=
 =?us-ascii?Q?pGsLwMxmaORPU7bQ6OJKcl6DysJzNvU1JB2XK2LwW0W+GqQkMSLCFrBqeMX0?=
 =?us-ascii?Q?pyQJU6M70mAxqzifRgkn5OaNSgq8ogND3WnuMQplWl7y+vVp1gDL+4Miwsx9?=
 =?us-ascii?Q?fblCnjSQJ73SMR/FyPIWSy5sllg7kVJdh/m97uNvYeZuNsDbt1meY3WPj1zK?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 566a1ee7-b9bd-4f26-3831-08dab3bc51e6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 23:31:03.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aivMt0qsD77ngFEavDBhFSnsqUhpoWdxJjJeOB6DqLEd0eWETrZg8EoO7jkGK01hkQwyYMIKF/4Fh/3LdUDDqnfgLTX7aqeb9bD38w4HqeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7306
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 17 Aug 2022 12:29:30 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Mon, 15 Aug 2022 14:55:42 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > [ apologies if this is a duplicate response ]
> > > 
> > > Jonathan Cameron wrote:  
> > > > Writes to the device must include an offset and size as defined in
> > > > CXL 2.0 8.2.9.5.2.4 Set LSA (Opcode 4103h)
> > > > 
> > > > Fixes tag is non obvious as this code has been through several
> > > > reworks and variable names + wasn't in use until the addition
> > > > of the region code.    
> > > 
> > > Looks like:
> > > 
> > > Fixes: 60b8f17215de ("cxl/pmem: Translate NVDIMM label commands to CXL label commands")
> > > 
> > > ...to me since any transfer that got within 8 bytes of the payload_size
> > > would fail.  
> > 
> > Makes sense - go with that one.
> 
> Hi Dan,
> 
> I was assuming you'd pick this up as b4 will happily pick the fixes
> tag out of the thread and there weren't any other comments.
> 
> Let me know if you want me to resend with the tag in place.

I believe you should have gotten a notice from patchwork, but I have
this queued up for v6.1-rc fixes.
