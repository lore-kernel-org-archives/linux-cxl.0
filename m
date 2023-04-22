Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10709C7618E
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 20:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDVU4i (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjDVU4h (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 16:56:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E1B210E
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682196990; x=1713732990;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZaCn4wcGWwY24yRgycqnLUupN4qd3lN0DcLhy+9cWKk=;
  b=PnKOkjN1zUTpBL21++8KaFFAttLmOkWanno4i+ETyrd3/j6AoO2Bn60R
   D3EHmWpGlHwpCLx4+sD4MqZU9eEdMEP9+Lv9QwOJSdbkJJNRA8X+mUkHS
   qXw4v0eznI/CG6rdR3vsGnt4O6BRsVcGU2hlLALJwH3FIAVCL6kNMuR/R
   cAYmnMONWxZSrCGvsaP7r5C8yiDqd3gE75CYCopRJkwxOQFCwuqHaUW6S
   UZMK8L0k+CONfxCCF4gkcmAErZfdFEa1HfNBfFz0rpJ+fkh65PX8PhCnW
   44rSv0hMCIey6m/EuALpsutY6cTYkYFIsrhXkZGFZU5Rr9sYPsKQpu7Nc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="411476787"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="411476787"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 13:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="816781767"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="816781767"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2023 13:56:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 13:56:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 13:56:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 22 Apr 2023 13:56:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 22 Apr 2023 13:56:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0J3P5xfE54yn3retTe24lb9pvefUdf6vB7QKdHQWpxnmidpz9UaY4tQLRPNR9zMjPnEqKnK3sZAj4Irl4ZTKjyIEr47NfmmPu2kOVtOdI0VwAzfJUqHsG3vL8kz+O3xAg6i72r6K+SV6rOzunawkfbtYvoFAlPA/dIWMR5p4+kIyURkRe61qV2z16UCMwRocJIQKh5AfQ2mTO6nRg8booEdY8Ix3tuoMQYIc1TFK/06vU4VrISU8ytLsg+3a0YjxcCUN4LZxmgUw3WK1nwoQprYe1oI+7D2ZDkWLO02bErplFgLrTBgNCtPd/rroxT1FXM6NsLethTqW3DBtJWLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1gw0828Zd3hjEJH5TqCWkauG0IxuD+/SxW6tH41304=;
 b=bEHCU0n+1Uglp5OAyGnAmk6Ywbvc2+9fVNSAaNMzLk8W0Dcgu4ujxzT/Ty9c9xqP/gcPw2bEkXuSnDKclC/I6XQLmhlA2xc4YazqVhDO4dPpR6lcGxumAZ7NGGyoytJ235udEddyaKDtav8oUoD9Pc0XirFQAS4YGeuJnrLhNrSLkwCmFFQIp2Zx5cfoAdYIlywgoXPixCRxtKmuOwJd0Dgxw/RY839N1esVCcUru+0f4eSK4ipCVUJ3MoMvWKP1zJVLtsvAYEPyh3VQQ3GvNnGWNVat3uxOyFJ5w5rp9gQN/X5hPYLiQxyqbMHa9nC6BOi19lQCFkGBEalJb8bDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.29; Sat, 22 Apr
 2023 20:56:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sat, 22 Apr 2023
 20:56:23 +0000
Date:   Sat, 22 Apr 2023 13:56:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
Message-ID: <644449f43a352_1b662947a@dwillia2-xfh.jf.intel.com.notmuch>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
 <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
 <20230422083502.GA31480@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230422083502.GA31480@wunner.de>
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5999ad-9939-4b34-73f3-08db4374077a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TsV5BYKtyUREQjPHfeD5sMO4NEBMWiR7lEBOSLbvaPj7v3s/eCTdjRrUhLyv7Ggm2zfDi/cyVIEpd9rIHGeTuVMaiu/z+0AYO/G0dhFEo9bN5tGiVBR0cL5kCbCsGzgR7DN95rOY/6F2bRXxB3DrzgKmSJDjXMhUCrxQ5fjm4/k9c4JfhGkAFSnSSJEaHVAxyZOy6S5TUEaI7y3Lmg6WazXn6TDJLDD3CV1Z6/We/70pRtvxP2qAd2rld3hsWjmRjR+0sS8ZgsDHn7uD1j3+YTvlxVAt4FWTbgqGq0AEMjUtMSkfzwnFqvNSw9YPeTa2jWCXg7g7+DiUQpb3mVdCBT+b7IbK6XCPW8dMA+rXCVVu3Ch63FOGl/L9QrIMBYUWZAF1mBU21aDU1PZVbiv2P7UyLjf0UKSWnJeQ3LOUgTJJB0VJrE0/N7FpGZla/BKepdSPaSfgCDthBYQrccNx1ei8dSixz2lCnEDRkISvnpx2d/EeefvCz3sQZFkdJUVNA3JzFV73IQIqGps8TsaL4JiL0btKnah6uwkubodTZJQaWX5KI/o10DHNoEXHjNw+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(26005)(6506007)(9686003)(6512007)(8936002)(38100700002)(8676002)(186003)(66476007)(66556008)(4326008)(316002)(110136005)(478600001)(86362001)(6486002)(66946007)(107886003)(41300700001)(82960400001)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mpZmzWO9USuYIQeI8sQ/F5Mn+nubykeAGNQsiYkqOhGvWLFBNYD469E9D/3o?=
 =?us-ascii?Q?2z6KLZeSAbK+a2zBR5265TjviNexP17Uoaxt2Widbm+X8288PZBJT7fnFPSs?=
 =?us-ascii?Q?YbDNsfqXQJA4AyentpTJEcXcshvFFHLk8cWXl/3+0yzLxm97c1b+4rPfmOcJ?=
 =?us-ascii?Q?UCsnI5CJGnGiCJafHD8fB7bYc2RoCtTr0TrwTXM14jSGtCC313EsTWn9IS+m?=
 =?us-ascii?Q?yCi9UTiUSKESufQr58kVExPCeNDUBStFyXg+CMC9TdfKsehUvDKs8U3YxMSM?=
 =?us-ascii?Q?jjmUX+d5x4YLZ2vXx3wh0j7gWMWxPdwNULaFvlJVDareUP0Wt/2EN3BEbuFv?=
 =?us-ascii?Q?KRUaiiXxcukCjI8xV6gQpnOVk6OiE1JGMXegCcwvgH3FzccmqoyAek9Ruj5L?=
 =?us-ascii?Q?RE6xrZuKGFF1IKi0MLEC6OuTbO9KkjHB7TSI527glvFXZ4UOD5GkokmIW9iD?=
 =?us-ascii?Q?2eXHnyKsMuW55ckX8iXbXswEKKGwYhKDRTBtbD1TEwfKp2hX1/y3TdPjk5IE?=
 =?us-ascii?Q?GUyGQ5LEIDtmTDTFssFNI1hhJRGllI+gCaSkmptFutLayQlyM8fpxAwokNh2?=
 =?us-ascii?Q?P9rglIPoGiEDcDzaK4v7eOexJIYrzTlZUnrmqIiK0ZOnahHPYTI6mV+oaJ37?=
 =?us-ascii?Q?l1RteWqMRh2untIJG/9647w4nrgPh3LV1GFpxbzz7Hz14vvfps+k3PLLVMN+?=
 =?us-ascii?Q?SvciaIckbrcvkSBRTBKoPllOLq9UHTW9uUQHxCUJNYQumiiyNK6lDEADOyic?=
 =?us-ascii?Q?MKSw06YSQzKsVVKJRiqp8GiugSMyA8sZmE4y6hW7CkXczGh44T8nizy9FfUt?=
 =?us-ascii?Q?D3aJ32BP+fZspaw12iL1Iwua0AO25xuxj0GCYxk7X6FgCidf1NEUjMr32HzL?=
 =?us-ascii?Q?sMuQ2GKaY7FEFp1GUePcSiz8J8m8ivLtafb12zMqYfiXbymftCVb2YLSJWxr?=
 =?us-ascii?Q?5RtfKEIbflvCukAFYs1iOK3Yriy/CmYq2/UwwP3tat93tZZ8FJSy38FXW2ME?=
 =?us-ascii?Q?XfROxa5FEWnCanEZK/cQjePpMihtmoldEuPfUkGEUZijUBSPO4yBDITB47gs?=
 =?us-ascii?Q?4c9sTs7c/tY3bpCA+HNvrIqYRyI7eUpS08SVdQuc1zPIkt6RJGHP940FF70G?=
 =?us-ascii?Q?fY47yJrozceyyeLfVzZh4JBsCgW6pkITsytoMqNhFFadleJgdMxYLsiVjwbg?=
 =?us-ascii?Q?M7hCjB1UqFlOQuS1vy4idwGTYLx01TowhAR5UbBCrpKeXyu9YMl17jorqxvF?=
 =?us-ascii?Q?RAxCGn/bI6kuetZxhdTtXG9Y4AGogYjLmG7jAilpveF5Lg3QSp+IIpgsmYJg?=
 =?us-ascii?Q?WCRWCdfxegq+11fUENdkZLUZCPu/pdzH+v3S/t6wmfEvC/CDXDugpC8lV5UM?=
 =?us-ascii?Q?1RwA3j8olpmi5zhoqsjbBygZuQMK1Zrbf1EIuGYNfdpsfahMzyK9hJdTX2u7?=
 =?us-ascii?Q?jzkPMhdLlDYkti6J2NohgtT+ZGu0y7POjfTeT+vV7/x2G7sfdOrV2z9V2/OU?=
 =?us-ascii?Q?PABD3wYS6AJlI9PJzXh2dEqoV+tPvX2QN8DvUeCrfM8FUJ1p+ckz67703rb4?=
 =?us-ascii?Q?aFCaitWlmYRL8bhWrBY6IyDrs4iCvWa9RooDY0pEIXrCxSTPseBEPmT5ZRIq?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5999ad-9939-4b34-73f3-08db4374077a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 20:56:22.8530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C49UL+15D68PRFf+VkzPvd7QN8f+wroAJK0z55I079mdBf75lEvBQP0KaTPdvsgaFXivCZ55czWNLh4GLkmiXlI3h3ECwKH83Kj8psVH5mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Lukas Wunner wrote:
> On Fri, Apr 21, 2023 at 07:51:47PM -0700, Dan Williams wrote:
> > Not all CXL ports are associated with PCI devices. Host-bridge and
> > cxl_test ports are hosted by platform devices. Teach read_cdat_data() to
> > be careful about non-pci hosted cxl_memdev instances. Otherwise,
> > cxl_test crashes with this signature:
> > 
> >  RIP: 0010:xas_start+0x6d/0x290
> >  [..]
> >  Call Trace:
> >   <TASK>
> >   xas_load+0xa/0x50
> >   xas_find+0x25b/0x2f0
> >   xa_find+0x118/0x1d0
> >   pci_find_doe_mailbox+0x51/0xc0
> >   read_cdat_data+0x45/0x190 [cxl_core]
> >   cxl_port_probe+0x10a/0x1e0 [cxl_port]
> >   cxl_bus_probe+0x17/0x50 [cxl_core]
> > 
> > Some other cleanups are included like removing the single-use @uport
> > variable, and removing the indirection through 'struct cxl_dev_state' to
> > lookup the device that registered the memdev and may be a pci device.
> > 
> > Fixes: af0a6c3587dc ("cxl/pci: Use CDAT DOE mailbox created by PCI core")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> Take my Reviewed-by with a grain of salt as I'm absolutely not an
> expert on the cxl struct hierarchy, nevertheless this looks sane to me.

Yeah, I think we need a data structure relationship diagram to explain
endpoint devices, memory devices, endpoint ports, and switch ports all
interconnect.

> I note however that before af0a6c3587dc, xa_for_each() was run on an
> xarray which was not initialized with xa_init() on non-pci cxl ports.
> (xa_init() was run from cxl_pci_probe() -> devm_cxl_pci_create_doe()
> but xa_for_each() was run from read_cdat_data() -> find_cdat_doe()
> for non-pci cxl ports as well.)
> 
> Hence can't this crash prior to af0a6c3587dc as well?  If it can,
> the Fixes tag would rather have to point to c97006046c79 ("cxl/port:
> Read CDAT table"), though this patch wouldn't apply cleanly to
> pre-6.4 kernels.  c97006046c79 went into v6.0 and there's one stable
> kernel between it and v6.4 (for which af0a6c3587dc is queued).
> So if the missing xa_init() can indeed cause crashes, you may want to
> base your fix on v6.3 and fold it in at the front of cxl/next,
> then rebase af0a6c3587dc on top of it.  Let me know if you need help
> or want me to look into it.

As I replied on the other note, I think older kernels are ok.

> Thanks for fixing this and sorry for not spotting it myself!

No worries, I had missed that the unit test were not run yet.
