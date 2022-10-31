Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698BDECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Oct 2022 19:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJaTvP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 15:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaTvO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 15:51:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B89E095
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667245873; x=1698781873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+mAuvX+OWNvjN5RbXYM3KlBSDVtsEqvO527vYdNKQOA=;
  b=MJBY7l3z2F8QSmHAxnZlb3obJdUpURl0i5NUQ6BYzwG1wcotmiDto0O0
   OMrbpYCUU4XT79KrvCFjJ06PMBb7vv51NoPXAyVpuMQa3sKUIwOO/WYVB
   7eIomTf/0KOIRSVtQzUfnHwf4+Ia7IsdyRCxISRAA44TUUi/Rf6ZiARmi
   ABPlTp5yemPZGD5Sx9RaRSMLipuKh8rw2VENoeEdKD9xyTYoeRtXmjwNk
   DKhOvjcwhAtFES0iqaaW0ZJVtX+JbyUSTvqhBoKnroKh7vDMoI2tvuPBA
   L5odGrHi9PpIH8zWc29r61fr79+BpKE/4XIUXgKo1sA42oEpr+5CPQY2c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="307711051"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="307711051"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 12:51:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="664906901"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="664906901"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 31 Oct 2022 12:51:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 12:51:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 12:51:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 12:51:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 12:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0Z5MuxHwX1wj5J2QYy4elAOOVmdmHjoRv11xctzSeMq8AbcKu3B2A/jMlfqwfoBNLfiJXz1GK4NMhWBbt0HIz+Wkm0zxDCbFEDzWlYSTsfsTXxGDZjO5+2yFz1IL8r5Do9Bf1zJKvMDdf93Z09elNWNmuVuTagldXXvf06yFxrL/v7Nh0LpevXPYRjwFwpFFwlVgnBZlMVdEv8i/8xp+YdXp007A7UZ7y+pkW5SiSK6Jcs+AewNqMyF+SRjOZjOG8lIYBYLmNdEPoJMDLlN2oyqXZ9Piap+OVIPmTJ/MAOUEcRo0iptQfRpYZGnZSkmKazr/zIq+mE0vgy8nWT5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CxRygme5827oCyCZeudtohPKPS56VhAckfwXk7+eo4=;
 b=kHgfHM0O+s4FjlBVou82NTX+ffnJ6L6aIhfZCIAWOvk7+rOjERyP9/YPqtwxKLITYqQl6kvGvf5+DtWetccplPzEAPbg8avT5x2Nv8IiI6tKPKmVFgES8XWN5T2JCbrbbEkeByXUA+d1UdNFXcPlHqm+yB2NhjRZLFXRw+4bx9k3qYKVKNKqetw0QttdHvELfhlxUyoG49GQAZMOX2YlmBvHgyAdwwyzf7Q3IAz5JoCQbFrxSo/LPPzAiy/rrb4pTUmY9468/m8C4HC98FUu3lweRiMKLbD85cT+8bBrskgoD+/EAGwcU9d+2Cm07s/nRMJrjV+f9j23RSWXhgCClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 19:51:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 19:51:09 +0000
Date:   Mon, 31 Oct 2022 12:51:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gregory.price@memverge.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v9 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <Y2AnKB88ALYm9c5L@iweiny-desk3>
References: <20221014151045.24781-1-Jonathan.Cameron@huawei.com>
 <20221014151045.24781-5-Jonathan.Cameron@huawei.com>
 <Y1bOniJliOFszvIK@memverge.com>
 <20221025115617.000035b6@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221025115617.000035b6@huawei.com>
X-ClientProxiedBy: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2eb309-0483-47a4-5e31-08dabb7941b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qacKDkuDyT987DLJ3pfQaRuj5pRvpYR5zE1b2rDxeJrCa1NitF3F04w1gVKVQ8we1UWVB4Wot575S4pvPtbCXMscl8eSO2+NqH+nfQDDAUReoQfokc82PmF4SDGNqkY/tN5ghEmdNHr9DVkDHKOpZnrFpiXjovNZ/tP7rQaE1iLE/B4RkQzIuIcLW0CKd+az5QLFLtXAQ8SislZivyZ3Rkg8iP30xTv5GmB1+DtSS63DWAc5g0VMiyPNVSLmd+kYCcfqTeDzYrhv4VrsZZpbhFG+5NbfmzouQq2vdoYf2hZrQ1R/BlX1p+D7q6K6lnGk3ipyFGK7YaLfpVw2ZJVqVh5kywhYHwSEW0L7+M59EB8v5pZqYkTs5vuqR9K8zdKtrKRgaadqDjnbSglOOym0/Ika5p3DRh0jdJNtK8ucKsao26Icmy4lFvFOSoQzIKZvOa74fYplnovKhGQ6a4+VBRmV5z19Q3byNsxOOCF6O+Q7oEkcH81YyfyyV5TgstnDRSSHLQlqG+65B7pOKcLGIfg/kzKZXb2zo4NhdqY5x0RE4pQSnY1qzI0XsKtOQ4uPnnnXoKBTOYVPS2JWvrjESfx/L8OmKn3sL39ertbuyV7p72QULi6pGY3XhrBmD76XcwiQ+1BspD2onwzcJVg5iE4bk7IDthmYfml2WkWq9HNQtNtwAyVZKi1gr3qoCwUj61vlPDuMV0GxhqH2OcOd28fhEkaKwKWqbLm8tx3Upno=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199015)(82960400001)(8936002)(53546011)(6506007)(38100700002)(966005)(66946007)(6486002)(9686003)(26005)(6512007)(41300700001)(316002)(66476007)(66556008)(54906003)(110136005)(4326008)(6666004)(8676002)(33716001)(83380400001)(2906002)(186003)(478600001)(5660300002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7hpzX8vTzgRy++LWI9Rpu7a1kGgm/FteZGQJV+Si1DMSE2sd0CbEqqjFhdz?=
 =?us-ascii?Q?1luGvHjSvU3VZl5Be9ulQV49IQpCBwwjnxlukLmjx8GAUxregbyYUWuGdXmC?=
 =?us-ascii?Q?aUc/+8/JShYYbyNJp97/w6+EwG/bJA3MqQQt7hI0h2abUHh3ev5iyOXmSkRP?=
 =?us-ascii?Q?0NNGlAJSisAHGZtk64ER9SrYtD8yFZE2rfpyjKztJklK03HpvO/JNKyL4JW4?=
 =?us-ascii?Q?+MuJ9/SknPcV5XTJY+k8Ldqd/b4XZYl1geeQsP1qFeBoJvQN9T+YRUYyasUT?=
 =?us-ascii?Q?jQG3yhAx2p8t3Ajf1LEekNbHDMLiT6PsBlSqrKi70jrmHspLFoFLSRhdPOpX?=
 =?us-ascii?Q?D55kYURABAxAfMY8wMxmLvPji/ShR4oZeZKcpnrusPIGtFS7YfFeW889QIwj?=
 =?us-ascii?Q?xf5cJNz8ihZlYqYrDXmk6KVV8GnBn0xZmETB0/+Z2ej6olnCMAfrx+NIgnv+?=
 =?us-ascii?Q?s5a7r5MvS087N4xjAyz7ytZIGXW//2IaXTwZHW8WNDsPI7LbaFMFDVggc8cX?=
 =?us-ascii?Q?Gzd2DGA02j6KaBv2g8wzjKwx3lMjNaXttOwojTg8EQgvj0bGN7YgEoVlWvaq?=
 =?us-ascii?Q?ahtfwZ40b/AXJTrJJly4QwK+37jA5y8+MWRrc4rtR9cAX/nr4LHNcnAIM+IX?=
 =?us-ascii?Q?q8LRf78xZetB/2b6h7GgH9f6X5QzCE7hyAtndTDNpHgwN1KA9EW9h/N9R5R1?=
 =?us-ascii?Q?MbRqw31K78QgJU+5nWjy39walAwGcSrU/HoGZaZOoyPZ/RqaZec4YWV+6Yl/?=
 =?us-ascii?Q?N2YC1OEAKKma6oLhIBszR5EYhG0PCQIrAFcUanXR4L0rpbh0fxldP7drWSWb?=
 =?us-ascii?Q?mHiE9lhAoGfzSWN2fy2nrpA5EWKd5/laXw0oIJhigjxtGTwaoxcZyTQX+qtZ?=
 =?us-ascii?Q?j6SZgyHUXn5vjlZiYWw+uFWLRuiLFHRRuXU+cwNxjQ6dv1H52th758Aeagb6?=
 =?us-ascii?Q?w2xrd8FtQIbrX4hT8QFyH0OGJkmLVMbLM/20UA2kizx4fGM/5/v6URfG/U2Y?=
 =?us-ascii?Q?LfQD8qIKwyZHqJKgKaL1wgSkEnZX6ezEEemOUbt0bcAiWcZ6/OzmPzPTzPk1?=
 =?us-ascii?Q?xfvsPpAXvQSmtJktRJBJDE8jZUqOsLHpz+D4TttdZkATDAj+zaN9f7dfJ9oN?=
 =?us-ascii?Q?FoYZLeBCC7eXpRWWRGbnzd5bPi0XDX9l2wdhbm9pTYiLPHU5Vzf6FfjbQMF5?=
 =?us-ascii?Q?BRVEBGPQxi4JnxJXS4eccWEQICgUiCUWGN1YpkvHgxy6lorSS/xinrrV9jbf?=
 =?us-ascii?Q?B4ZuwaMwVFkPMRE7qU5uPfxxQ3MlTu+yk7tuimhHQjak35EozWCySWkjkbU1?=
 =?us-ascii?Q?LufkWBpnx4Jzfl9KnahbdphJu8S/XAcMmbRzEKCV7sQKKb1cBOToincMQcLF?=
 =?us-ascii?Q?9aAds9V4Kzny5YoD58z2jw0SKaKUH6JqL/VUmf05HzAyiZs1ax0AbrNE2RgJ?=
 =?us-ascii?Q?+p83X++j088l9sXRiFjdyx7AiwElc6fSCYpPNAe50pOMuSLg8G2sRYDQWNQM?=
 =?us-ascii?Q?MUtsldfvkiIlWAp/QiA/7aJopFW2YrHCRrL4uvbd449o2sJsbtpnZ+/taWN2?=
 =?us-ascii?Q?KbsUtLKQosn9mVNxGfVOCkImc1EAknnAzagW7CEL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2eb309-0483-47a4-5e31-08dabb7941b0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:51:09.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9968aoK/21gpIKgnyKPp2S2fEMQsN99FZmM3dGt40jGT3TGDtmtWx9eEMpOTfYTS9s7AQ8z/QTR/QHN18KLWOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 25, 2022 at 11:56:17AM +0100, Jonathan Cameron wrote:
> On Mon, 24 Oct 2022 13:42:54 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Fri, Oct 14, 2022 at 04:10:44PM +0100, Jonathan Cameron wrote:
> > > From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > > 
> > > The CDAT can be specified in two ways. One is to add ",cdat=<filename>"
> > > in "-device cxl-type3"'s command option. The file is required to provide
> > > the whole CDAT table in binary mode. The other is to use the default
> > > that provides some 'reasonable' numbers based on type of memory and
> > > size.
> > > 
> > > The DOE capability supporting CDAT is added to hw/mem/cxl_type3.c with
> > > capability offset 0x190. The config read/write to this capability range
> > > can be generated in the OS to request the CDAT data.
> > > 
> > > Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > > Signed-off-by: Chris Browy <cbrowy@avery-design.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >   
> > 
> > In reviewing this patch under a debug kernel, I'm discovering some
> > warnings / tracebacks that I want to get a sanity check on.  They appear
> > to be warnings, but i'm not 100% sure what to make of them.
> > 
> > I get the following stack traces during boot (on the x86 machine).
> > 
> > Removing the type-3 device from the configuration prevents the traceback
> > from occurring, suggesting it's something to do with that code in
> > particular (which tracks with the patch here)
> 
> Thanks Gregory,
> 
> We have an INIT_WORK() in pci_doe_submit_task()
> that in the pci_doe_discovery() call is based a work structure that is
> on the stack.  As such should be INIT_WORK_ONSTACK()
> 
> This is a little tricky becaues there is no particular reason to assume
> all struct pci_doe_task instances will be on the stack though they are
> today.  We don't really want to break the layering as would be necessary
> to have this init at the locations where we otherwise initialize the
> containing structure.
> 
> My first thought is add an 'onstack' bool to either the pci_doe_submit_task()
> or perhaps better would be to add it to the pci_doe_task() and have
> macros like DECLARE_CDAT_DOE_TASK_ONSTACK() set it appropriately so we
> can call the right INIT_WORK_*() variant later.
> 
> Ira / others, which way to go to fix this?

Yes Jonathan is on the right track here.  Though I was confused why no one had
ever seen this till now.  I see it was because I never ran with the
CONFIG_DEBUG_OBJECTS_WORK option.

While we could have a declaration macro.  I think the best solution is to
separate the task from the internal implementation; see patch below.  I was
never fully happy with the idea of having the work struct in the user visible
task object anyway.

> 
> I'll also reply to the last version of that series to make sure people see
> this discussion.

Thanks I've been looking for time to look at this series and have missed it.
So the ping over there helped!  :-D

Ira

From 9e16d5e399723412acbaec1bb9be807d5e5bf7fc Mon Sep 17 00:00:00 2001
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 31 Oct 2022 11:31:30 -0700
Subject: [RFC PATCH] PCI/doe: Fix work struct declaration

The callers of pci_doe_submit_task() allocate the pci_doe_task on the
stack.  This causes the work structure to be allocated on the stack
without pci_doe_submit_task() knowing.  Work item initialization needs
to be done with either INIT_WORK_ONSTACK() or INIT_WORK() depending on
how the work item is allocated.

Jonathan suggested creating doe task allocation macros such as
DECLARE_CDAT_DOE_TASK_ONSTACK().  This would work, however, having the
work structure be part of pci_doe_task seems like a layering violation.

Create an internal struct pci_doe_work which represents the work and use
this for the work queue.

RFC because I'm wondering if a gfp_t flags parameter should be added to
pci_doe_submit_task() or not.

[1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d

Reported-by: Gregory Price <gregory.price@memverge.com>
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/doe.c       | 56 +++++++++++++++++++++++++++--------------
 include/linux/pci-doe.h |  4 ---
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e402f05068a5..6a9fa57e2cac 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -29,6 +29,12 @@
 #define PCI_DOE_FLAG_CANCEL	0
 #define PCI_DOE_FLAG_DEAD	1
 
+struct pci_doe_work {
+	struct pci_doe_task *task;
+	struct work_struct work;
+	struct pci_doe_mb *doe_mb;
+};
+
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
  *
@@ -214,9 +220,9 @@ static void signal_task_complete(struct pci_doe_task *task, int rv)
 	task->complete(task);
 }
 
-static void signal_task_abort(struct pci_doe_task *task, int rv)
+static void signal_task_abort(struct pci_doe_mb *doe_mb, struct pci_doe_task *task,
+			      int rv)
 {
-	struct pci_doe_mb *doe_mb = task->doe_mb;
 	struct pci_dev *pdev = doe_mb->pdev;
 
 	if (pci_doe_abort(doe_mb)) {
@@ -233,9 +239,10 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
 
 static void doe_statemachine_work(struct work_struct *work)
 {
-	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
-						 work);
-	struct pci_doe_mb *doe_mb = task->doe_mb;
+	struct pci_doe_work *doe_work = container_of(work, struct pci_doe_work,
+						     work);
+	struct pci_doe_task *task = doe_work->task;
+	struct pci_doe_mb *doe_mb = doe_work->doe_mb;
 	struct pci_dev *pdev = doe_mb->pdev;
 	int offset = doe_mb->cap_offset;
 	unsigned long timeout_jiffies;
@@ -244,7 +251,7 @@ static void doe_statemachine_work(struct work_struct *work)
 
 	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
 		signal_task_complete(task, -EIO);
-		return;
+		goto free_work;
 	}
 
 	/* Send request */
@@ -260,8 +267,8 @@ static void doe_statemachine_work(struct work_struct *work)
 		if (rc == -EBUSY)
 			dev_err_ratelimited(&pdev->dev, "[%x] busy detected; another entity is sending conflicting requests\n",
 					    offset);
-		signal_task_abort(task, rc);
-		return;
+		signal_task_abort(doe_mb, task, rc);
+		goto free_work;
 	}
 
 	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
@@ -269,30 +276,32 @@ static void doe_statemachine_work(struct work_struct *work)
 retry_resp:
 	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
 	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
-		signal_task_abort(task, -EIO);
-		return;
+		signal_task_abort(doe_mb, task, -EIO);
+		goto free_work;
 	}
 
 	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
 		if (time_after(jiffies, timeout_jiffies)) {
-			signal_task_abort(task, -EIO);
-			return;
+			signal_task_abort(doe_mb, task, -EIO);
+			goto free_work;
 		}
 		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
 		if (rc) {
-			signal_task_abort(task, rc);
-			return;
+			signal_task_abort(doe_mb, task, rc);
+			goto free_work;
 		}
 		goto retry_resp;
 	}
 
 	rc  = pci_doe_recv_resp(doe_mb, task);
 	if (rc < 0) {
-		signal_task_abort(task, rc);
-		return;
+		signal_task_abort(doe_mb, task, rc);
+		goto free_work;
 	}
 
 	signal_task_complete(task, rc);
+free_work:
+	kfree(doe_work);
 }
 
 static void pci_doe_task_complete(struct pci_doe_task *task)
@@ -510,10 +519,14 @@ EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
  *
  * Excess data will be discarded.
  *
+ * Context: non-atomic; allocates with GFP_KERNEL
+ *
  * RETURNS: 0 when task has been successfully queued, -ERRNO on error
  */
 int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 {
+	struct pci_doe_work *work;
+
 	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
 		return -EINVAL;
 
@@ -528,9 +541,14 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
 		return -EIO;
 
-	task->doe_mb = doe_mb;
-	INIT_WORK(&task->work, doe_statemachine_work);
-	queue_work(doe_mb->work_queue, &task->work);
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	work->task = task;
+	work->doe_mb = doe_mb;
+	INIT_WORK(&work->work, doe_statemachine_work);
+	queue_work(doe_mb->work_queue, &work->work);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_doe_submit_task);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index ed9b4df792b8..7c573cdbf17b 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -52,10 +52,6 @@ struct pci_doe_task {
 	int rv;
 	void (*complete)(struct pci_doe_task *task);
 	void *private;
-
-	/* No need for the user to initialize these fields */
-	struct work_struct work;
-	struct pci_doe_mb *doe_mb;
 };
 
 /**
-- 
2.37.2
