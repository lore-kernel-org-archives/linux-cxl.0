Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62722C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 20 Jan 2023 17:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjATR0o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 Jan 2023 12:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATR0n (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 Jan 2023 12:26:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A60390B04
        for <linux-cxl@vger.kernel.org>; Fri, 20 Jan 2023 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674235602; x=1705771602;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UyeVJncifgetpWhUJOYV2OBSw84mwf7VkN5Ze4FEWZU=;
  b=E2zxcNBki3yrfn7NhS/5QvyPqScn9uI81v+RcxcwjQyYlzFP7XhP4EEF
   2QiJ5Td70JFSloQfzlaUHxmQXrIVqKpWhzJBpSoOiOuvVrWjSV15fq6kK
   9xLX4jJ2hFHMjSxsTYwqkk+gDF4f9ZA3jafsM6KsLwtH7c+8Ci3Z8KTVl
   zkumySzj5xdGJFKhtgsY607XHbqSEDXsoGY5gbwqjILjj8Fu2eZ/Enqnq
   C+gwMQbPriJGyICQK2k2qJb9w3m3gqozpT/HZlcQIEVOy5XwiFwDhGrWy
   e4fxVsh1N3ZuPO1C0VF6dH98YEvkb+wSOe5IKJDLxXTQwy4Wqnso64Unb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="327724241"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="327724241"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 09:26:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="834482606"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="834482606"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2023 09:26:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 09:26:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 09:26:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 09:26:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 09:26:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwA7lZ4hBnBzEO7CpBbHoZ+nBaI836SJZ03SBtHya9QygrDXbDoFzF2qG2UkBqHnSS+BM+HBLyRk7iosajrsubgQysvfZOGrBdWGeIja5LI22WbW2whKrIhULEdJVHdrd62FwfJvVJ515gPo04lEHGL5fHSkMnUT7td9YZwUK47QF19EoC33nNmGK7qij7gs4uCe9486+8UZlKnoTjew5vxL2xFZ3RvsBCXXFak7/lURujN6fjpzUIB/BZkbnDGu31Hc1CQqp5aTiAqhWpLBNuj0KLbc38cfOnvvR625pV8DToHcg9aF9K9HdqVF7yX1KCm6YZjKeHv8jCgD3QJJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcX4F2rAWHbG/+EFzYS8YAJuzfQApqD1jqIR0jL0LqE=;
 b=YD+dZJUaM8awfVY8U7RgAGmAnSBbmcD67ObH+bEF5K1OS0y9Zd8NTVTzFhpLdchRumgAcjDwIH4zBsKympYV7gMn5x/naUSzYeR2ATWZtsehmIXwT+ivj8i0BWXlJZNQbqSj7xYBhV3mCg51eEiytH9xoG+joXtvQvLSefhc7HuCiq+095Z91pm/rom51yjz/KEuuWRIoVVV8aPYMzqe8owdVvKG11oA3LQpmBABMK/Zo3nUh5Vu61vm6gmbwAthF1Vsos/6WIxSZo2KFV4siT9XOIqE4xCS9baSYXc6WkS+frmThwyWmOS/BS7Zo6sliCcvh0nxyhnoStWjTg1RFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 17:26:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6002.026; Fri, 20 Jan 2023
 17:26:37 +0000
Date:   Fri, 20 Jan 2023 09:26:34 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: cxl nvdimm Potential probe ordering issues.
Message-ID: <63caceca41de0_c81f02944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230113091213.00002146@Huawei.com>
 <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
 <Y8hG4OyJL7l9oD2f@memverge.com>
 <Y8hJKcy1993SFLLJ@memverge.com>
 <20230119124244.000015b3@Huawei.com>
 <20230119150449.000037f2@huawei.com>
 <20230119161711.000057a7@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230119161711.000057a7@Huawei.com>
X-ClientProxiedBy: BY5PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:a03:167::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: e50317b5-cde6-49d0-1711-08dafb0b7bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fknqiSWWkhsMkRpvmez6MogMLjxlZbhZLuEvmPMR2LxmTqdmtQy6Ck+gmCTaN+F356uXNlTNp+2CjV5MGcTxm+IxDvQMIIwS8e1u7uZmMHnHkzvq7g5fiasrn2AwTHjtyGcrDSFiwmotSIX5HrRRNDIah5MSRgM1tdvD5h4ng9Ztu0r9DnPDlbzRjBb0paWOIgTt1nZSI/x55QCjUfKI19z9IO0hfv8Kme63LNVZR1voy1D1DJJ9RFLkntDdyorxDMRTkxl82KFE4NR5I9/RLB0Y4NH0YNJBZ/51XBVDV1I8xD1psUZWo7sdEjdZTZyGw/WPZFbhiaMPx6FKstOU+OU2aXXoh6qfay26xOcecpttIX+VCxPC3fekvtt1XOVZnpXtbzFxN3fe2XFxVkCMV5N2/HYh46BjeuZDL/6LK9fjQ9IMxAMpEIDXSzNjuLCuOrz+xtDSN02aa0MZvIvIH92Do2CgXaI/Hya993fv6mdsp8dHnX5eOflD7SmRb8ctXyWNvsA5vkkoL4icNYj/sid/DdhB7GbzK18zGNa4nUwHxyXrwBYRYKG7uYn1epiUkLqto0ajQmfjy3ye1nSXR285ZW4O36+Ei/hb99O8Xj8kTd/SQA288KYcYjplLVpQ5pXBZW8R8i0aBwM0K65sBbZGqLTQ84Lf+4hdRf20IuuCK4egijD+OWx0CsFEUwKpXkHE9mwqaqVizJOe+k2REg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(38100700002)(4001150100001)(82960400001)(86362001)(45080400002)(6666004)(107886003)(186003)(6486002)(6506007)(478600001)(9686003)(26005)(966005)(30864003)(6512007)(110136005)(5660300002)(41300700001)(2906002)(8936002)(66476007)(66556008)(8676002)(4326008)(54906003)(83380400001)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IL2+kYA6z7qCRwngfwg8PitdkaK5o95v4vFbq0q7+pBqqnPZhZMONzJTVdFL?=
 =?us-ascii?Q?fbXkT9J6BjjEhsivkZ46PbiFygPjomjwW+1Rzk9sF4Tg7wkRAEc8vHCNBwzh?=
 =?us-ascii?Q?TlAv+96aLzOQCtZ44BhqYzRSjG7cJX1/wm1nK14kQB/KH6C1Lm89PQTxi5tv?=
 =?us-ascii?Q?qvonw8lKRl2ClLLg8j+0v5sW8fZ4TQfR+fwHhZ8QGAENJRb+YxwG4h4oQJjI?=
 =?us-ascii?Q?SXVxT5tfK08M9faYY9OhjjLonVA6U7xSKW+4LBMKgxulsMLlYo+1JCMNqtjJ?=
 =?us-ascii?Q?zwY8biaMjxhv495kcUoCumzhlKDmTPmZTRIYk/dhqGSKYCVRsxs3qJqYqMQ4?=
 =?us-ascii?Q?juc7zrRALH7z9RGnlFXcZXwPwcgBVKKPfjriPN9Rlx1fYQkBQNdbqos/CJEf?=
 =?us-ascii?Q?QBZnmJa2/r5eP935soLwZnrDewBDrcVWLCd/rC7vX2xrgs9jpN3UAbap/Q2F?=
 =?us-ascii?Q?aFdHqCfIGu5sX16V4Fjjopbdse9YJ6W5TUsf+xxU+n1VAj4077l/T2T9kvIe?=
 =?us-ascii?Q?oqVT/bZ5YsJHuesOcimfvg2gZ5/RJ6nUNvFoL6JYohNVw9ELX8vdxFwvJx2A?=
 =?us-ascii?Q?i1XqWfmr7PmUNssnjAnBNi7UAhKcN/0Qxaii+fU+kI58Cw7JTu7edhmoEj4M?=
 =?us-ascii?Q?ayhfIXCgyoPy8EMO+HFTp+0ic8PmYJ/TnkURQlAbicLHDOmjygN8bCwkW1Kk?=
 =?us-ascii?Q?lWZVVokehgSGqq2ig1QRUf5s/aeKWp6qogrhROUNc16z3VX+yFviRI0TeeoD?=
 =?us-ascii?Q?YFH2Hdqf7TmC7VC2BJmtpDdG7PwjApdao9y1iqhp4Ke7G6wz0uuNT5MhWx9A?=
 =?us-ascii?Q?uAJV0fC1naUAx77B7R57/YDyTMoI2BoenPnfRsN8eehiij0Dus2jd3hyN768?=
 =?us-ascii?Q?P+U/vkl4WCQ34tv3ZP7jjHZOc2NxyJa71wYgdpYOF1egV0BPNpIyhFliQBsb?=
 =?us-ascii?Q?AwQ8TwiqUyYU9QzU7cSvBG8wRHOb0mFpyJcOWPqBZfCUpdw/Re9AE03pm6px?=
 =?us-ascii?Q?yNnFlHP8V0buNpQzmYOG0IOWtIGIK6N1icDIkTfDt3jE2byvvBzCBkee3Jev?=
 =?us-ascii?Q?UDE09yz+2Bqjl9tBQHeAH59VebNE4w8cDsfIiHWBjhggIa1KFSLA/q1ZV56c?=
 =?us-ascii?Q?gD38/JNHpMUkwixzIoaI9GQwhssNxmd5Lih3OZJ6mE3VuD7x4qP9MhCrFhd5?=
 =?us-ascii?Q?8rUz7Z4VH2Jn8JeGEuajfkfdsmQfi5rU/U12lycKdISFNMcCnC8N8t01ipfc?=
 =?us-ascii?Q?DxdI7pxo4WHh1qCbOnsIO6ACHdR4Z1gEGrNLzcBGxJwAYLLvQGc5/0ED3362?=
 =?us-ascii?Q?ImTE/AixUjprkQSdQfFdcO2dzkQzV0SfTEkzIQPH8a9iJGz1+Z00oVuOvtp4?=
 =?us-ascii?Q?cLEExQY7kS5h2ldL3jp1m7OB8X/8Es/QMy2N0ESIMXyD0lJH6M+IrRywoGKT?=
 =?us-ascii?Q?A36M6TszRcbc1IlEbbHYH4fkTlN2jsxi1Yeh01PWbnIjtrk5brVTKL/Oj0Dp?=
 =?us-ascii?Q?ypmK6QSsa0Z7C6vhWny0RzqkjrBJyWPvyePcITMaUMCQL/S8Af5il2HeV/V6?=
 =?us-ascii?Q?aEoKy37kk9roOIdyIMHkE4jQVK1rpGGtAjfR2p/D7ecc7zUPag97KMafL/0M?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e50317b5-cde6-49d0-1711-08dafb0b7bcf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 17:26:36.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K+VpqcWwiBZ4PFzeq7deJCuq41poFGzsNp6zRoiZFMqv+cmcvMwLD7xbzpX3Q4Wm/j1BoHsilkAv3XKhavd/hL4m3fwccN/M0/yWM4jpIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6248
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 19 Jan 2023 15:04:49 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Thu, 19 Jan 2023 12:42:44 +0000
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > 
> > > On Wed, 18 Jan 2023 14:31:53 -0500
> > > Gregory Price <gregory.price@memverge.com> wrote:
> > >   
> > > > I apparently forgot an intro lol
> > > > 
> > > > I tested the DOE linux branch with the 2023-1-11 QEMU branch with both
> > > > volatile, non-volatile, and "legacy" (pre-my-patch) non-volatile mode.
> > > > 
> > > > 1) *In volatile mode, there are no stack traces present (during boot*)
> > > > 
> > > > On Wed, Jan 18, 2023 at 02:22:08PM -0500, Gregory Price wrote:    
> > > > > 
> > > > > 1) No stack traces present
> > > > > 2) Device usage appears to work, but cxl-cli fails to create a region, i
> > > > > haven't checked why yet (also tried ndctl-75, same results)
> > > > > 3) There seems to be some other regression with the cxl_pmem_init
> > > > > routine, because I get a stack trace in this setup regardless of whether
> > > > > I apply the type-3 device commit.
> > > > > 
> > > > > 
> > > > > All tests below with the previously posted DOE linux branch.
> > > > > Base QEMU branch was Jonathan's 2023-1-11
> > > > > 
> > > > > 
> > > > > DOE Branch - 2023-1-11 (HEAD) (all commits)
> > > > > 
> > > > > QEMU Config:
> > > > > sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> > > > > -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
> > > > > -m 3G,slots=4,maxmem=8G \
> > > > > -smp 4 \
> > > > > -machine type=q35,accel=kvm,cxl=on \
> > > > > -enable-kvm \
> > > > > -nographic \
> > > > > -object memory-backend-ram,id=mem0,size=1G,share=on \
> > > > > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > > > > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
> > > > > -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> > > > > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> > > > > 
> > > > > Result:  This worked, but cxl-cli could not create a region (will look
> > > > > into this further later).
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > When running with a persistent memory configuration, I'm seeing a
> > > > > kernel stack trace on cxl_pmem_init
> > > > > 
> > > > > Config:
> > > > > sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> > > > > -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
> > > > > -m 3G,slots=4,maxmem=4G \
> > > > > -smp 4 \
> > > > > -machine type=q35,accel=kvm,cxl=on \
> > > > > -enable-kvm \
> > > > > -nographic \
> > > > > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > > > > -device cxl-rp,port=0,id=rp0,bus=cxl.0,chassis=0,slot=0 \
> > > > > -object memory-backend-file,id=cxl-mem0,mem-path=/tmp/mem0,size=1G \
> > > > > -object memory-backend-file,id=cxl-lsa0,mem-path=/tmp/lsa0,size=1G \
> > > > > -device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
> > > > > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> > > > > 
> > > > > 
> > > > > [   62.167518] BUG: kernel NULL pointer dereference, address: 00000000000004c0
> > > > > [   62.185069] #PF: supervisor read access in kernel mode
> > > > > [   62.198502] #PF: error_code(0x0000) - not-present page
> > > > > [   62.211019] PGD 0 P4D 0
> > > > > [   62.220521] Oops: 0000 [#1] PREEMPT SMP PTI
> > > > > [   62.233457] CPU: 3 PID: 558 Comm: systemd-udevd Not tainted 6.2.0-rc1+ #1
> > > > > [   62.252886] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> > > > > [   62.258432] Adding 2939900k swap on /dev/zram0.  Priority:100 extents:1 across:2939900k SSDscFS
> > > > > [   62.285513] RIP: 0010:cxl_nvdimm_probe+0x8d/0x130 [cxl_pmem]
> > > > > [   62.285529] Code: 85 c0 0f 85 90 00 00 00 f0 80 0c 24 40 f0 80 4c 24 08 10 f0 80 4c 24 08 20 f0 80 4c 24 08 40 49 8d 84 24 b8 04 00 00 4c 89 0
> > > > > [   62.285531] RSP: 0018:ffffacff0141fc38 EFLAGS: 00010202
> > > > > [   62.285534] RAX: ffff97a8a37b84b8 RBX: ffff97a8a37b8000 RCX: 0000000000000000
> > > > > [   62.285536] RDX: 0000000000000001 RSI: ffff97a8a37b8000 RDI: 00000000ffffffff
> > > > > [   62.285537] RBP: ffff97a8a37b8000 R08: 0000000000000001 R09: 0000000000000001
> > > > > [   62.285538] R10: 0000000000000001 R11: 0000000000000000 R12: ffff97a8a37b8000
> > > > > [   62.285539] R13: ffff97a982c3dc28 R14: 0000000000000000 R15: 0000000000000000
> > > > > [   62.285541] FS:  00007f2619829580(0000) GS:ffff97a9bca00000(0000) knlGS:0000000000000000
> > > > > [   62.285542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [   62.285544] CR2: 00000000000004c0 CR3: 00000001056a8000 CR4: 00000000000006e0
> > > > > [   62.285653] Call Trace:
> > > > > [   62.285656]  <TASK>
> > > > > [   62.285660]  cxl_bus_probe+0x17/0x50
> > > > > [   62.285691]  really_probe+0xde/0x380
> > > > > [   62.285695]  ? pm_runtime_barrier+0x50/0x90
> > > > > [   62.285700]  __driver_probe_device+0x78/0x170
> > > > > [   62.285846]  driver_probe_device+0x1f/0x90
> > > > > [   62.285850]  __driver_attach+0xd2/0x1c0
> > > > > [   62.285853]  ? __pfx___driver_attach+0x10/0x10
> > > > > [   62.285856]  bus_for_each_dev+0x76/0xa0
> > > > > [   62.285860]  bus_add_driver+0x1b1/0x200
> > > > > [   62.285863]  driver_register+0x89/0xe0
> > > > > [   62.285868]  ? __pfx_init_module+0x10/0x10 [cxl_pmem]
> > > > > [   62.285874]  cxl_pmem_init+0x50/0xff0 [cxl_pmem]
> > > > > [   62.285880]  do_one_initcall+0x6e/0x330
> > > > > [   62.285888]  do_init_module+0x4a/0x200
> > > > > [   62.285892]  __do_sys_finit_module+0x93/0xf0
> > > > > [   62.285899]  do_syscall_64+0x5b/0x80
> > > > > [   62.285904]  ? do_syscall_64+0x67/0x80
> > > > > [   62.285906]  ? asm_exc_page_fault+0x22/0x30
> > > > > [   62.285910]  ? lockdep_hardirqs_on+0x7d/0x100
> > > > > [   62.285914]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > > > [   62.285917] RIP: 0033:0x7f2619b0afbd
> > > > > [   62.285920] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 8
> > > > > [   62.285922] RSP: 002b:00007ffcc516bf58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > > > > [   62.285924] RAX: ffffffffffffffda RBX: 00005557c0dcaa60 RCX: 00007f2619b0afbd
> > > > > [   62.285925] RDX: 0000000000000000 RSI: 00007f261a18743c RDI: 0000000000000006
> > > > > [   62.285926] RBP: 00007f261a18743c R08: 0000000000000000 R09: 00007f261a17bb52
> > > > > [   62.285927] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
> > > > > [   62.285928] R13: 00005557c0dbbce0 R14: 0000000000000000 R15: 00005557c0dc18a0
> > > > > [   62.285932]  </TASK>
> > > > > [   62.285933] Modules linked in: cxl_pmem(+) snd_pcm libnvdimm snd_timer snd joydev bochs cxl_mem drm_vram_helper parport_pc soundcore drm_ttm_g
> > > > > [   62.285954] CR2: 00000000000004c0
> > > > > [   62.288385] ---[ end trace 0000000000000000 ]---
> > > > > [   63.203514] RIP: 0010:cxl_nvdimm_probe+0x8d/0x130 [cxl_pmem]
> > > > > [   63.203562] Code: 85 c0 0f 85 90 00 00 00 f0 80 0c 24 40 f0 80 4c 24 08 10 f0 80 4c 24 08 20 f0 80 4c 24 08 40 49 8d 84 24 b8 04 00 00 4c 89 0
> > > > > [   63.203565] RSP: 0018:ffffacff0141fc38 EFLAGS: 00010202
> > > > > [   63.203570] RAX: ffff97a8a37b84b8 RBX: ffff97a8a37b8000 RCX: 0000000000000000
> > > > > [   63.203572] RDX: 0000000000000001 RSI: ffff97a8a37b8000 RDI: 00000000ffffffff
> > > > > [   63.203574] RBP: ffff97a8a37b8000 R08: 0000000000000001 R09: 0000000000000001
> > > > > [   63.203576] R10: 0000000000000001 R11: 0000000000000000 R12: ffff97a8a37b8000
> > > > > [   63.203577] R13: ffff97a982c3dc28 R14: 0000000000000000 R15: 0000000000000000
> > > > > [   63.203580] FS:  00007f2619829580(0000) GS:ffff97a9bca00000(0000) knlGS:0000000000000000
> > > > > [   63.203583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [   63.203585] CR2: 00000000000004c0 CR3: 00000001056a8000 CR4: 00000000000006e0    
> > > 
> > > Possibly replicated.  What I did was stop cxl_pmem.ko being probed automatically and
> > > added it manually later. Trace that results is certainly similar to yours.
> > > 
> > > Now the MODULE_SOFTDEP() in drivers/cxl/acpi.c should stop that happening
> > > assuming you are letting autoloading run.
> > > I wonder if there is a path in which it doesn't?  
> > 
> > Gregory, would you mind checking if
> > cxl_nvb is NULL here...
> > https://elixir.bootlin.com/linux/v6.2-rc4/source/drivers/cxl/pmem.c#L67
> > (printk before it is used should work).
> > 
> > Might also be worth checking cxl_nvd and cxl_ds
> > but my guess is cxl_nvb is our problem (it is when I deliberate change
> > the load order).
> 
> Whilst I still have no idea if this is the same problem, I have identified
> what goes wrong if there is a module probe ordering issue.
> https://elixir.bootlin.com/linux/v6.2-rc4/source/drivers/cxl/core/pmem.c#L306
> 
> 	/*
> 	 * The two actions below arrange for @cxl_nvd to be deleted when either
> 	 * the top-level PMEM bridge goes down, or the endpoint device goes
> 	 * through ->remove().
> 	 */
> 	device_lock(&cxl_nvb->dev);
> 	if (cxl_nvb->dev.driver)
> 		rc = devm_add_action_or_reset(&cxl_nvb->dev, cxl_nvd_unregister,
> 					      cxl_nvd);
> 	else
> // bridge driver not loaded, so we hit this path.
> 		rc = -ENXIO;
> 	device_unlock(&cxl_nvb->dev);
> 
> 	if (rc)
> /// and this one
> 		goto err_alloc;
> 
> 	/* @cxlmd carries a reference on @cxl_nvb until cxlmd_release_nvdimm */
> 	return devm_add_action_or_reset(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
> 
> err:
> 	put_device(dev);
> err_alloc:
> 	cxlmd->cxl_nvb = NULL;
> 	cxlmd->cxl_nvd = NULL;
> 	put_device(&cxl_nvb->dev);
> // whilst we scrub the pointers we don't actually get rid of the
> // cxl_nvd that we registered.  Hence later load of the driver tries to
> // attach to that and boom because we've scrubbed these pointers here.
> // A quick hack is to just call device_del(&cxl_nvd->dev) if rc = -ENXIO here.
> // There may well be a races though....
> 	return rc;
> }
> EXPORT_SYMBOL_NS_GPL(devm_cxl_add_nvdimm, CXL);
> 
> 
> Of course this "fix" just stops things blowing up, it doesn't leave things
> in a remotely useful state.  If it's triggered because someone
> is messing with the load order that's fine.  If the same issue
> is occurring for Gregory, not so much. 

Apologies for not engaging on this sooner, I have been heads down on
trying to get pre-existing region enumeration on its feet.

One workaround for this is to just preclude the load order scenario from
happening by making the pmem enabling part of the core module. There is
not much reason for it to exist indepdendently.

...but I think it is useful to be able to have some policy for disabling
all pmem enabling in an emergency. So I think fixing the cxl_nvd
unregistration is the right way to go.
