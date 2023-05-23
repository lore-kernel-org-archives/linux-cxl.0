Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E87C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 17:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbjEWRgc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbjEWRgZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 13:36:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C4E79
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684863373; x=1716399373;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=5612SYRFKITMKm0ThDUVPbHxxL2pzTWaSfpXbXKSqIc=;
  b=fbzmgKxDMwrbxbbiPcQ6p3XRWKsJnh8bdNq6keeZZ+nT151vfxhPomC1
   oYOma1NE1C/SwEhKBZlSy95pUgvRlgx9s4O+SJBA/g+j5fr97lImNtgsn
   P1jrl333vGFi3Rk9AU6wsqclxjqeJS5ANdFhbIrxmGP7GkJwNxNoktdv2
   G6WFhbs+ARG35pWF7f4tcaT0IPJrIIT9ZPXPh+qv9LDMqJaZChEZ1/mt0
   /tHXN41+EhtLDOYZMGH2XCVNq6UmPdOpbyLJgope8Nj4J6GbIeB5JALWQ
   E0BGU+865l3OZURyiEqW7f2tTfAScGvjTWEVFyWdbQSDiPtTCN/WY59pK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="381554178"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="381554178"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 10:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="707110712"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="707110712"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2023 10:36:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 10:36:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 10:36:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 10:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfvPnVvsePwvuxsVxyAm0eAOXtMyTkwllULVAy5so9Q8+AzFE7363NE3p/QbC+AF1V7VDJjqy3/yJL48vy3TJ7uDDAFEp95K23QEMsQfEK1Qt6GIA3lVAVSi0XRGtVPcIHQo1Xub3UF7U0xmKE4Vda8N3F556xx7sscRHyV7k/pU/q7D3/jrwc5H2U7id87UqSF0/PfUdM6fuZcReyT/ONMrqiI19xVSVm2dgWDAvwwIaN18u6y/8nJPw4tBQP8LBsK9OFp3XwSJDxQPFydTiOQdu3z7Vb1+Zz+k/pN840J3w/ZCIAkF/P7E8VFPqdnXAOAf0c13vKfrAuyTBSZKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CwrE02UwVUYBcUO0NzpfE3mpGtFtTD7o2jIwcwwEG8=;
 b=ERSMttvvSTHo4MvOiC6VtgHEvPbT+tHZ59cxgNfHutv0QigjDE+QMmReiFtJWzZ2zLdWT+tuHcvEwkgNWJI9EZwkHz75cselJDQTMqmU8HYPj/3RQHYv1VtQ1RRbsqbvOhdVVyLwI6sJm9VlVKxin84j8zBvXRVj1/weV4J+7o21vKgz3yAaoBhoU4FhGWoSMj7Fw86Y/qmRhhaST6YbHVak4q2CJBNJLmwEqQ2VUNcxTpJ0fCHvjXHdDCpfgKrYNV8yettdY1dNKam3t47kXsjP2F3kP7aJJDCR2KuQwz6H+s2ceJdaAcDuJnA8SM+5gRAjLGtyBH+N9M213bpt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 23 May
 2023 17:36:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 17:36:09 +0000
Date:   Tue, 23 May 2023 10:36:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b21891e-4901-4e2e-697c-08db5bb431eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDCjKMF8Jxvt4CiJmUhhTfXF8PJYVOBn7pt8ovjNaRhe74u/uXhjs5o/ucIkvwlINCbya28zN6E7BzstrOckNbLYqon/+scdHNpNspwCsJZslATvThvC/QTU4EBTo6VjNtpD98gnJhOmaBEUhTncA/5G7bAoiG1TcvlhQhZqaLTYzkIvWpf+qBZ35hBTheVo/osFimX7ucutrYnzp8OMpWuaCSxUUgMWvIE8KGyJ3dr7p2SVSG8ch6C5ivh8+7XHLRVnVvQI7gq/oQ0A8PfiLVY6DJooilSlyDZKKenEhbmRSog4zrCH+FK5Rzh3qovQIrGuOWrb+xotEqoHTFDUyEuBDFBpr+Ho5fE9a2iy1nQKrPtXViKzSogb8Ec4NDVj7wYkK457aljuxh2r5JcprZSKNL9s6I9bi0fUo7dmjzy3rnkWCt9eY9eoFWjoQegDT0sJJlDr8mj2+nH/ItdKAmRTB9YTgXesOQSG3zqM6+leSuyzvPtecFsQnDSb60b3wsznnyLwwZUn9BkPMiw7Rrqrut3h7s+Yyj8YDOh+5XP22CgA/vv4cYttbxiBwArm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(316002)(82960400001)(66556008)(6506007)(6486002)(8676002)(26005)(6512007)(41300700001)(66946007)(38100700002)(6666004)(83380400001)(66476007)(2906002)(8936002)(5660300002)(86362001)(478600001)(110136005)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uohppm7ieCgDZxj9UawsMqZDbAdb2qF3gs9W7RRzkol6pDbKGgP2oAY1ZybB?=
 =?us-ascii?Q?o3+j5962Fu92tCrGgrf91NCfbGJ1u6fuhoCqVmnaYpX/eW6uvy799a+rUMNV?=
 =?us-ascii?Q?TU0YSTGVdRnmEpKc1fWACWLmaBFxaSYD8CxLI5t5VHzcEKyAbh97MJtuIsNK?=
 =?us-ascii?Q?x8NTfPxkwVr2PtoH8oW8qYw9hKZSveVkt2e70za5HgqLb1v9GI2gtGicsiLR?=
 =?us-ascii?Q?teyqnP3Qenb5kPnAa6FiGtIPV2LYljkF8YqPE1WCj8SAL2dGzNfZLORJmhLd?=
 =?us-ascii?Q?i5aJ0yE3CDUUxTlwhR24YZuOYld59konnKJn5YDe5nPRvyzFtouMllv3iYa8?=
 =?us-ascii?Q?G9ZTDC3Z8F8rBgUeLx9If6UbvheD0WgMbGr8xgoxlJ+7psdfOHKJi/wj+8G/?=
 =?us-ascii?Q?rckC8adPUSJar2DQbVmh7zL7Kwjrdi75um5kEhqPSplR42lbHrUbeG1fiM5E?=
 =?us-ascii?Q?2lzH9I6N/McZS0CSN3aUd36iCK6DB7fSNNJjdE8fu4GJMG3qMfgIinAdd25r?=
 =?us-ascii?Q?6TsH1mh73T1akDWQspTb/Kc2TaqSEE4zn8w+sUK1Cc0mSe10ED/yidHbASyr?=
 =?us-ascii?Q?sjBkilSj7SYPXyMwX+L4gKQjd2ufbyb/YnSjvsqCtkLduv64MHWUM5gKsYUc?=
 =?us-ascii?Q?MRFK/gWamdJMvTShTKFoxLhqoSWUl/98zGBcQmwG3qyUPmWPPSN5dowFqYwa?=
 =?us-ascii?Q?P7zShUk+sIzkYcy2MUmESR2ZdKaRKmLhOt94zeeHM6w+gGLaHrXofsHZRhTx?=
 =?us-ascii?Q?EG1Qj3Tuslr/RqFko3t4uYmEs5NvVQ/xL4/3qRi8Cmftnkj+WfHKnTuN8Nnr?=
 =?us-ascii?Q?9A5T6GzIkC8dDGt9cvtnvu6hpFzNLkrQglmXB/grtZSxb151Ldz13oXsmucG?=
 =?us-ascii?Q?jZttdba5/chm5TneMjnHqYQfE+lkfOsk9/T0k3hE903LkH2rLyEo2y7ukfKZ?=
 =?us-ascii?Q?8dQXmPgbP4PZig8ZR3R22fLWf8iMp9seY6SnCaOqhPujDgo5jvc37wndM1Ay?=
 =?us-ascii?Q?7/pH68K8QYkTs3Ec++whR2I0vdhtWUdb/7baJlpzvFUY3r0Y8eAys+j1goTA?=
 =?us-ascii?Q?PR9zG6SDbzHxWjObgG5AvkRzAk5psRymdgJQEZUgss356tUX4U5fSZwLJ10M?=
 =?us-ascii?Q?iTAoXWwdwZuap7heFh9Yg5Zt2vfBjVI27PGQMdGpC82+rMGlDWz/vLhNu0ZA?=
 =?us-ascii?Q?0mPBaAd3Pmi+cZySAr7fYgNVF1c6pEqCPHUqD7WYupsPIvo+Z83r4/SwfmdV?=
 =?us-ascii?Q?Lor5b/EK5LN8qPOznlmN0diaedglPablB+YajImO84JeAgW7MnrP4fCfC3Dt?=
 =?us-ascii?Q?dx2O4a/dAcIzYL/Hvwxz6jftgx75A5RlRXIM8exu+6qNHNrHT4/wJ1XaL9aH?=
 =?us-ascii?Q?/9ob25+vMvktyFGDpFXSnnCtEvuDVxb8u7NTej2QmUfBiFAyzfyurSSdqPoD?=
 =?us-ascii?Q?1/wJP/aCiG1UGn8+EUJ0ZN620mDfxLYH8vvFZGzGleyf8prwfMHs7tq4VzuP?=
 =?us-ascii?Q?zbWPzPESyXJNvVAmnGd2MWUOPkNt563FJLTD969ewNepFceMqZa2Nv59wRM0?=
 =?us-ascii?Q?6EsppbK7qb0aw1hIMNENgCKsvfGaEU7qUXOOZjknLU7wQuN6M/b+xWITeing?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b21891e-4901-4e2e-697c-08db5bb431eb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:36:09.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MI79f3ifLXOwXEI92G1Z8aQDeRzfrvqwpypTX+tG2D9Jsgi4xLzk0KyhIzGdvInk+vXTB+4NdOvIY26pnoZ0Svm9SATDy3AMOXfh4MwFsQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6366
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Yasunori Gotou (Fujitsu) wrote:
> 
> Thank you for your answer!
> Its progress seems to be better than I thought.
> 
> I would like to ask more questions.
> 
> > Yasunori Gotou (Fujitsu) wrote:
[..]
> > Correct, after the device is added and the driver attaches there is still a step
> > needed to configure a CXL region.
> > 
> > For now that step is to manually run:
> > 
> > cxl create-region
> > 
> > ...later we might consider some udev rules to automatically assemble regions
> > from discovered capacity.
> 
> Hmm, I suppose 2 types of udev rules may be necessary.
> The first one is for notify new CXL device is detected, and cxl-command assemble 
> a region automatically.

Yes, I suspect this ends up being similar to the mdadm monitor policy
where the device arrival events trigger notification to a daemon that
can apply an assembly policy.

> The second one is for notify region is configured, online is execute for each
> memory block on the region by the notification, and rollback when one of the block
> fails hotadd If necessary.

This policy needs to coordinate with the
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE policy and the memhp_default_state
setting. I.e. the kernel may do this automatically depending on those
settings.

> > > Q4) Current CXL drivers/tools support Hot-removal request from PCIe?
> > >
> > >     CXL specification says "In a managed Hot-Remove flow, software is
> > >     notified of a hot removal request."
> > 
> > Currently there is a requirement that:
> > 
> > cxl disable-memdev
> > 
> > ...is run before the device can be removed. There is no warning from the PCI
> > hotplug driver. Which means that if end user does the wrong sequence they
> > can crash the kernel / remove memory that may still be in active use.
> 
> Ok.
> Though "Surprising remove" is not guaranteed by specification, I think
> "managed hot-removed flow" should be realized.
> I'll chase more what should we do about it.

The nuance here is that even though the PCI hotplug driver supports an
attention button and pauses to let the OS acknowledge the removal. That
acknowledgement is not coordinated with the associated drivers instead
those drivers just receive a ->remove() notification that can not be
failed.

So, this means that the CXL device must be shutdown manually with

daxctl offline-memory
cxl disable-region
cxl disable-memdev 

...*before* the hotplug attention button is pressed. If any of those
commands fail the device is in active use by the kernel and the hotplug
attempt needs to be cancelled. My expectation is that CXL memory device
removal is not possible in the majority of cases. This is why the
Dynamic Capacity Device definition in CXL 3.0 allows for the flexibility
of partial removal.

> > >     I think that CXL drivers/tools need to find which sections belongs to the
> > >     requested device, and execute offline them at least. In addition,
> > >     Fabric Manager may need to prepare removing the device due to
> > configuration
> > >     change.
> > >
> > >     Does current CXL drivers/tools can execute them?
> > >     Otherwise, does it need to be implemented yet?
> > 
> > Currently the 'cxl disable-memdev' command is not smart about determining
> > when the device is in active use it just claims that it is always in use. That is in
> > progress to be improved.
> 
> Ok. I see.
> 
> > 
> > > Q5) How CXL driver treat region/namespace size against section size?
> > >     Current x86-64 section size can be 2Gbyte, but CXL region size may be
> > >     able to smaller than it.
> > 
> > The section size is still 128MB, the hotplug memory block size is what expands
> > to 2GB. That size limits what can be onlined via the dax_kmem driver.
> 
> Oops. 
> OK, I understand I should change my word "section" to "hotplug memory block".
> 
> One of the background of this question is "rollback".
> "If memory hotadd or hotremove for a memory block fails, is rollback available?".
> 
> If a block hotadd sequence fails in the device for some reasons, its user wants to remove
> the device for the moment, and may want to retry hotadd again or try other device.
> To achieve it, already onlined blocks before failed block should be offlined again.
> 
> If a block hotremove sequence fails in the device, its user would like to keep the device
> online to postpone replacing it or select other device for device pooling. (vice vesa).
> I don't find which component handle this situation.

It depends on how the memory is onlined and whether it gets pinned by
the kernel. As long as all of the memory is onlined to ZONE_MOVABLE then
there is a good chance to be able to get it back. However, ZONE_MOVABLE
is not a guarantee that memory can be removed later, and ZONE_MOVABLE
requires some ratio of ZONE_NORMAL memory to be present to make it
usable. See "Zone Imbalances" in
Documentation/admin-guide/mm/memory-hotplug.rst.

> I noticed that current users prefer online after device detection immediately, and kernel
> supports it. Though it is natural for some use-case, I feel it may be obstacle for rollback of
> CXL device hotplug failure.

Yes, this is a platform owner policy tradeoff decision. Maximize hotplug
capability by limiting how the memory is used, or maximize the
utilization of the memory by limiting hotplug flexibility. The kernel
defaults to maximizing the utilization of the memory, but administrator
policy can go as far as only allowing memory access through the
dedicated device-dax interface.
