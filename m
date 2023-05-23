Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C9EC7EE2A
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 00:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjEWAkE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 20:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjEWAZE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 20:25:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7186A9
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 17:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684800792; x=1716336792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l5lq7U8N2vnoXRB99bEgh4LPk9tvBBjBUGd1oML+RB8=;
  b=CB4fjB0IK1VP3xAgZ6zTlUMsmdTELKQgny2YXckZbpG1mBRRNV89f2L5
   AAouv74cwNVBNb0dZZGCaiwpzotWj0MglOupa25vKuvZ/2rYlwuwW0ZXV
   pmmiYb/+JjGQcxpzmM47rJJeSNPYyCkhoixD/6dxJQcUxAFzLcwQA9LaO
   JmIeSlxsaitgAI35BYIcKm2mPks5Dpbdw68/ttycFGyBkADF++sqhQKjL
   Z6zd0U14VpL0jFEA++xoC+AkRZ9H8N9avGFdTzpKyoA1AsC3YbdU5wiDu
   2jxoZMvngLN9BRivHOpmuIvD8k0Cnt+AOV9OA2OrAeEyWCm8oEBPx5M6I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="418785979"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="418785979"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 17:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="736626180"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="736626180"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 22 May 2023 17:11:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 17:11:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 17:11:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 17:11:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 17:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgCmny3jf9d895++30Sa13bEjZK4pZGqd8vt0f7bcOEzHaaksvTnfQH9XXx/BNW6YrO79KrPcQZ/PazMuBWNuN6giiolojsLSgKQutXUSScqM5gBV1qsLVl9yLTfZqZxPtbt1933O9m+/6ZRvJZIX+nFgPERVgMN85JjYeww0KJt30xXhRKgiuS5VfkgPJzhm8I0DMRRtUHrOhe70DNzCDxy1eRBj9hqxhqoaA/g6vq2MCHkwtz/pxunKBFmXvMeAwpvg1nAU57UV8HQETurAJD8HfZfiFybJe9GjrFmJH9g7BEvOdSQM47wUSJ01kJS5Ld23gLHK/r/LvbPCsyPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJp3C8KHy840cylZCs5rnNDOxVmeY1wRgK6Rn+8y2Hs=;
 b=kUvmwPRnAK11sU1VjYc3k9uVyPsc30Czp91QZJOaE8U/9hNWcucOFR06Q/LU8jiof3GPeqNxW/rbj8wr/NYazR9BsNRV/moZO01yNuY/XD7jILe+ekUcJtn1KMqDjBsCqZ3Bu7Wdr36ZARN3rqyUFiZymcBvXOVYxXPrk9axZVQz36CuaMBS5ets2sbhTFzJH3nt1gqm7kK2JkCNCiIHosw+4sKeojBzh+d5oshc5XP70b+riGyb77Ou4qdZmQO5tNBG2/qzYZjPGAKEz4xk0+zk0CbNkF9JbAlgwFegeAR355e+1qBDpTxcoIhmCu4W9pz/74Dvz0zQv1xqAh3Z2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 00:11:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 00:11:41 +0000
Date:   Mon, 22 May 2023 17:11:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     'Dan Williams' <dan.j.williams@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c003913-27e2-456c-6be6-08db5b22488b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4V0iQUzo15YnjG4kq9DSb9GJhMhJuFDam5E1xToMX2TbThyXEFm1XAwnnK+rxQ532Pj6QTvaNw9By6Wt7uD1WF/PqnUqsCWZWXVnM6vKxG2G2ZR/TikZ0BQJOskz7aRV2NiH/FmaRbo77syp9bJTLyq4xcr5zJxNlaCSND4BC8C3DM4T+u8ufPo153LPj+NwzDKpNT/OJLH0Gp0skpqqPLE9GrUtlsIEm3LqxbTqCbs35RdXslGJrAEP6DJCCu7HNmBUVihdqQTvE0AlQnS9jr/ArZrdTcODaj6R/rQxLiDM8bBcdoM0HdZaH8QSLtro5/AG56Lnfk+dMtlv5IguTCFNlAHjBZMbnL0ccXduXBIL8s9kno/HfdllZX8g+Te1YYt2Is8UiSE6wsatk7f2WZAXU3QwfI06dva+7JRsE+3fqRGudiO6e8FlYGsVG+Sy0MvdAfFvh9qNCJRNQzCA/ZbrsEEPH/OsSIprq9eBa7dmchQaoltR8G8kPfS0YQY+/wFO1kl8RhfcKLC7hPUejzi3nHmXCEnCb/BI5MeKRlw2YbO/+sm2Bm93BUwkU7m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(5660300002)(8676002)(8936002)(83380400001)(2906002)(82960400001)(186003)(38100700002)(86362001)(107886003)(6512007)(6506007)(26005)(9686003)(110136005)(316002)(478600001)(66476007)(4326008)(66556008)(6486002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QIMk/0Ni3M1mBtgNrJOcostPSSC2D9GeR3bBsAZ66nSUvnyv+raiQgYLjdp7?=
 =?us-ascii?Q?hdPDWqVsExlCI0lmecAPm/C1Brn6JXK1Z9NFcGjPfc85n4j6hw+Ec4fk/83m?=
 =?us-ascii?Q?56l6dpDoLGAiAFT12rx23PYo7BMGCdTZkNqe9u/D83DUZjqFTs4an6qJS4SQ?=
 =?us-ascii?Q?il2Ur+uYAYeiK/T1i6UgCv2G+9e0WQ2VnsZn808wII+uiPQs8PD1uJbVhKYQ?=
 =?us-ascii?Q?oZBcMwhVgb6dSK/asIa3JZJhbp2ZEbIxX1Mu/BiUec+WVRcy/zGiF2ev1AKg?=
 =?us-ascii?Q?FhYBhyTCIDglxnUlf1F+nztizFlcuHJiQyJqkvGeoKgHZcwgvh+SfPD8D1lt?=
 =?us-ascii?Q?CEwNbD2ZJ2K6z/lT7tgncK6PGtoUJTlFr/ENn3a+b7Uctm6hXve8/gSmQR1i?=
 =?us-ascii?Q?gre9q5MkyZGKeNcUkLYrxN+Gdi4FQjzkVh9DGUM6uariIai11oDZNw0U+M+l?=
 =?us-ascii?Q?9laS4lOiL7/360M6aHDzRRtfp155HDJXDCeZ+eYERCR+EnOOAmJNH5jT+ucI?=
 =?us-ascii?Q?7ObmwflUoXOhtEaIJ6Y+X+uz/MbZzNaEglIu26CEj3YKQ6LEzUUdr8XtCO6A?=
 =?us-ascii?Q?ooSE0K05zhNSIhYr3j6u+YCQSW2C0nvbVzfpkbPBeIS+c0yCVRqwEG7xEvky?=
 =?us-ascii?Q?iFm5PtjN95VlSoGuzk4+HVOAFZK0pnlOsAsFCUio1AJqYP7VXJqQSsSKSRD7?=
 =?us-ascii?Q?2dW4rocQkexRigRP9iFiGIqNM3cG+YN4fVJEXHYp+tN0a2XPE8uCUdvQBobq?=
 =?us-ascii?Q?dbsbbKi//FwyGAihHlwlFwijHw1cGn+gIiHW0S0pv1ywHH4QBN14i2YpxJbe?=
 =?us-ascii?Q?JItStMgxar7tzYK0XJMnqladdXlGSRSrQUs6kZSMqVwjVbFB9nL9unXU5QOw?=
 =?us-ascii?Q?OUG+gbZL1ao0htyBfsIYQSbQ3yhK3H/ANbKd5It/i94CQqJmlJZ3uLPzEhig?=
 =?us-ascii?Q?U95yeoIxrT9EgElMjri5Eahgir4CDGDsxTioUHTOlvfSzjRaecqY0E3IGk3m?=
 =?us-ascii?Q?9xOrXZG8du42UqSdcJrgY9rCXKe3xFds7YRJUV3RmUeR/FrILKInntJengcj?=
 =?us-ascii?Q?BV27+SMLcbsdnGowc0LEYLmITvKc5Lg1JphMngTMp7Wrj3cU29gX+QGwlM/Z?=
 =?us-ascii?Q?wiCQyX3X0sN3zaa2vTFvU/jTnJkBlz9bZzmcOsblwCwh43SdO8ajdJ3reaDQ?=
 =?us-ascii?Q?Ei84bmQRQkyxcS6cgo239BkBJRBqlt7UXOCDyCvoUij2thFnvtstygJj/ehK?=
 =?us-ascii?Q?8afV7WZENCM04GCvMgPknGMegNQXriBx5fW1Dd+ypRk+LNxmdgVADpYiSFSi?=
 =?us-ascii?Q?YIrR9eA3iHyEvCXjuAXhxpthLE82vZPi2/ypm3m2ba1jobt9IYd5kYK5y5/e?=
 =?us-ascii?Q?9UMqjPrWTUWY37fYhtZCgWsM0hj4Gln0Xnn5pRwT25FMISIzf31O7U9oArif?=
 =?us-ascii?Q?izZ5QPv2QI4AzxQPw6Ca1sjzkn00o1T/nWa1dmad3zL2aceliKS1E1/0WyFz?=
 =?us-ascii?Q?j2jrUv1CH22DZi2eb1dZOWPZhu6vYYq3ERAz6/QPMNSBUcdzEObqCa22KPKw?=
 =?us-ascii?Q?zTyYOJXfDL3vtvZeogHYj+hcTVpbDyysb+VGIQVqBsfn0CnYrcPE6ZnDC/P6?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c003913-27e2-456c-6be6-08db5b22488b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 00:11:40.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwB5Y3w1vRsvoFm4U+XX5X+IWHGxnkKL5zqGpZ2PbsaVe/1wzOS3dXNitzLxu7Q9c8ejNRghUGUnlgKLiTKyGam6zCJvDOjC63WGHPxP8DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Yasunori Gotou (Fujitsu) wrote:
> Hello,
> 
> I have some questions about CXL device hotplug (especially type 3 memory device).
> 
> Though my team members still need to work for a remain issue of Filesystem-DAX,
> or RDMA for persistent memory yet, I would like to move some of them for
> CXL type 3 memory device after finish the above works.
> This is preparation for it. I would like to confirm current status of CXL
> type 3 memory hotplug.
> 
> Q1) Can PCIe hotplug driver detect and call CXL driver?
> 
>     CXL specification says as follows
>     "9.9 Hot-Plug"
>     "CXL leverages PCIe Hot-plug model and Hot-plug elements as defined in PCIe
>     BaseSpecification and the applicable form-factor specifications."
> 
>     At a glance, PCIe hotplug driver seems to be able to detect any PCIe
>     hotpluged device, and call its suitable probe/attach function. But I'm new
>     around here, and  I'm not sure it can actually call the suitable CXL driver.
> 
>     Can PCIe hotplug driver recognize a CXL device and call its driver?

Yes.

The cxl_pci driver (drivers/cxl/pci.c) is just a typical PCI driver as
far as the PCI hotplug driver is concerned. So add/remove events of a
CXL card get turned into probe()/remove() events on the driver.

> 
> Q2) Can QEMU/KVM emulate CXL device hotplug?
> 
>    I heard that QEMU/KVM has PCIe device hotplug emulation, but I'm not sure
>    it can hotplug CXL device.

It can, but as far as the driver is concerned you can achieve the same
by:

echo $devname > /sys/bus/pci/drivers/cxl_pci/unbind

...that exercises the same software flows as physical unplug.

> 
> Q3) After called CXL driver and detected a CXL type 3 memory device,
>     what sequence is/will be executed?
> 
>     IIRC, kernel created /sys/devices/system/memory/memoryNNN directories when
>     memory device is recognized. Then, online operation was executed by 
>     a user or an application.
>     
>     However, CXL specification seems to require more configuration like
>     interleave, region, and namespace by Fabric Manager (cxl command?)
>     after device detection before memory online.
> 
>     So, my understanding is that the above configuration must be executed
>     after device detection, and before memory online. Is it correct?

Correct, after the device is added and the driver attaches there is
still a step needed to configure a CXL region.

For now that step is to manually run:

cxl create-region

...later we might consider some udev rules to automatically assemble
regions from discovered capacity.

> Q4) Current CXL drivers/tools support Hot-removal request from PCIe?
> 
>     CXL specification says "In a managed Hot-Remove flow, software is
>     notified of a hot removal request."

Currently there is a requirement that:

cxl disable-memdev

...is run before the device can be removed. There is no warning from the
PCI hotplug driver. Which means that if end user does the wrong sequence
they can crash the kernel / remove memory that may still be in active
use.

>     I think that CXL drivers/tools need to find which sections belongs to the
>     requested device, and execute offline them at least. In addition,
>     Fabric Manager may need to prepare removing the device due to configuration
>     change.
> 
>     Does current CXL drivers/tools can execute them?
>     Otherwise, does it need to be implemented yet?

Currently the 'cxl disable-memdev' command is not smart about
determining when the device is in active use it just claims that it is
always in use. That is in progress to be improved.

> Q5) How CXL driver treat region/namespace size against section size?
>     Current x86-64 section size can be 2Gbyte, but CXL region size may be
>     able to smaller than it. 

The section size is still 128MB, the hotplug memory block size is what
expands to 2GB. That size limits what can be onlined via the dax_kmem
driver.
