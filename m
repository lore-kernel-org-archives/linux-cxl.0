Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CDFC4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 08:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjADIe2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 03:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjADIeY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 03:34:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA0C2733
        for <linux-cxl@vger.kernel.org>; Wed,  4 Jan 2023 00:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672821263; x=1704357263;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cR/o/0OEMmMouDEGYRE8q9nMFxySp2utsMWXVDe5f/o=;
  b=ZCZ6y/MyVNKSGeknruKc4c9+EwY9JGrZPsDht0w3PTOOJ0RIEGqdAv3O
   Z7X5vOMGIT69IfIwwsRrLcEtztpU9EsoACTFaZ9ZME4CEk+m9GXlLlIBN
   x+NJao+7SUFOlvfupbmPJizs4rF5yVuEZOGugFpgCG2z9+hsZ0Bio0A59
   qY9bGcgFNf8RkOqbWuxxsn7Hll08zZ6IePl/O63wj8t8XAzAhKrYblfYq
   RFLZ4QuI+jNVlcUb5Xzh3rZ18ThI2YRPsyGjC4IPvTPMkqeA/QxOvIGIE
   RxT12uxOH/2m1E3tfG+0jsN+IoyYesVy+lZA2XBBCRczPiYc067YGqSkX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="323117407"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="323117407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 00:34:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="605120842"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="605120842"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2023 00:34:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 00:34:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 00:34:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 00:34:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV0xavoXVw2USD0o9qD1GJkYsUQFikynxeGEn6Fjfdzt6T3vXvd6pMw5GHX/4vM1Ixy7S/ju5RZyt9/qSN3HWaWyGLK/AZl2FKTZQguj7ZKFRMjvNaLQrb+TTGtcsgF/rO3eavaMjPq8n84L5SF4nT1kbfom/mapT1Bj34OApAYft1RR16HgCd9jewndgjx9nvwyXJQzkwXIPO2VYkgALxBT3qSeff1jcfFAFoQCiw1tyqjrJHrithje4D8P4VYs+08ALjpWnW1V641XJbHMKb0FQi7Ed2DRNtDLrthqMKszzqr8kim9g+WgkXF8vWZ736clrpNCWvqWWlxqe/rQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GSd2qKPkzgXXrEtTCVPW8XmkIMVokua3p3OwkFeO58=;
 b=h3t2Q33Of+EB+mt+M6zwcfsXX/eIOCNda5M2nZ7ZeYY2ANkB2qEAbuD0NE1j3caDMFK4tvnadxj93s8csEmy7xpwRr8bk5sUwYKxe7bhxYA7kB2shFrrRHfx948E+/0AI2QswwAHgIdoUFALHlCJod/DDpEwmXfb+SfPhEomncICms8aPPckKrARFwWLNKZgsLwexxqFry/rKpswGVv7SgoI1ZoASb4YRxJ5z1k1FnGdEAiuFXmx38stsefnvlcVtXhGrRxTsheBxnNFx2Jk4DGu/JkJhHc47aIcfwFYabwjQ3+sA2zp0KvjBUlRAlTB3mLFClf58YCtB/QH5FIkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB4799.namprd11.prod.outlook.com
 (2603:10b6:a03:2ae::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:34:20 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 08:34:19 +0000
Date:   Wed, 4 Jan 2023 00:34:17 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>
CC:     "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
Message-ID: <63b53a09a350c_5174129434@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c@uscas1p2.samsung.com>
 <20221220182510.2734032-1-fan.ni@samsung.com>
 <63b47c72a3cc4_5174129497@dwillia2-xfh.jf.intel.com.notmuch>
 <20230103214305.GA2878607@bgt-140510-bm03>
 <027f79b1d796fd0ad6c43d1e3fd8c02247e990bf.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <027f79b1d796fd0ad6c43d1e3fd8c02247e990bf.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: e89fe552-993d-49e6-bf12-08daee2e794c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWmGJ+MASI/KRUpyIGVw05dmFdmZFGL13aCCe2A5nsEGLQjdcD1zft36+18CNtpddXfAdb0C9IMWCi6JDGZrt7feSpqKNmm32HmRR2uhxNhw6G7OwcmhZ92AkuakrAEAN/HlHJRwFgwzS6gr59r5h2Vt2Aluem/4W7QHXPOvdjD9bcxjavc7o0Rwz+msh8W9PsiBTIg3JCidkbJkASW1oT073jcCL0d+bLMqJdRKl8F+HnTP0gUsBOotTARRCnbVyogsApgSwdkLmBEuDVaqy8yHOJuMWLJ85/8nlnVjpRxXB5N11pNOA2YJ09zUwKUKfuj1mz0iiDDWWAe8HFUt10T4EVOwBsJ0Gu1UVs5OLuGeilNjNnVW2py7iXjA0aZ7Z24qMIKESc0FHvYOQ09L9fk/x9AW/tuqO/Dz355tUK4Px8zu+E63dae+iFOxQBzDsJteHwPJ7y610clLHNFH7kHEDjIRlsyHF7qUgyruq7SJxGDDXpLerjFGsVibmRL31x1yQo+xQBgtPSWf+cJxzTdogXvbRtKSPtfrBBkF+rQwRysHxQckjaKgFXaRzbElXs6Ub5cy4rnjrhVQcpfftOoF8s9+E/4g+OXGZgjtytDuQkQ8eUQ9kGKWeGiougcCZLzYNG56zW5z4UVjmrVQAb1CuMup9bmAiTccrNRx2HHKVGNR9tqKz9WRM341Y9UszaHVQum7QvoNRUfxO0cPGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199015)(5660300002)(2906002)(316002)(41300700001)(54906003)(4326008)(8676002)(66476007)(66946007)(8936002)(66556008)(110136005)(6506007)(478600001)(186003)(26005)(6512007)(966005)(9686003)(6486002)(83380400001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?eMHdH6Q/BDUssYdMfNefHrbeQV9TbD1aqCY2JdCfPbCbqhLYk8REHc4mRz?=
 =?iso-8859-1?Q?61IH0AMQb0m4PnPR7LAOyvpPlnAvthDXJ+77x5vcO9mut/RVKa7LopoJSX?=
 =?iso-8859-1?Q?d0+xE+2y/yVlMk8Zhpq4B75P9Vbbf2bEwS00jfEbIeE4UthDOlfgbq7nEo?=
 =?iso-8859-1?Q?Z9VUCXrlG0fmkzd3tI28chw7DtRe8x+94oeFmqWtZLeWSUcHUqMZbroNnm?=
 =?iso-8859-1?Q?7/5OXHZFLHpyp94vkt2se/Nc+TcqS6PFRZPXNkJRiWBRLyOk5NVUeBRXIV?=
 =?iso-8859-1?Q?oBmRuF0pXWRK5OoSVmyAsTGCR3DrjkcbweKjJ0PeI+P2CRL6OovwEeZ8Y/?=
 =?iso-8859-1?Q?Jwsz2ZS5MQgsumzuo1R+dtMHLp9eIRG2zLDHz8mGlXOyi6f3brstM28np/?=
 =?iso-8859-1?Q?jaoNkwnjfwBX2T/37l69WQfO9A6xnlU1SnXM2hMQyhRJPhNaD/xFCvGKiM?=
 =?iso-8859-1?Q?LtDusuN6mJvjdnooHymSeFY4M5qdpS6fI/xkYzJRTxvgBx0jToduwVLNGC?=
 =?iso-8859-1?Q?GVzqPwDQskhD5kkSic5FCl+UoXp37A24+O0a7qAk7MUgE9VX5UwYZ8mTte?=
 =?iso-8859-1?Q?Rz4+nmZPAe8y+JugRRsX5ksG69HtmEnHVgvIuxdK+BaCV32Q6JPxn3lyNE?=
 =?iso-8859-1?Q?VfspozXx8mOzlkMM1O3GWg6YXoTwCJjARX4rm+rv9DIM6xYYhRAzOqHErD?=
 =?iso-8859-1?Q?jy/PsXXPEyT2yAgzCo4FefAvpc23uU7bXT9QMftF4MbUW0jD1PL75N3w6F?=
 =?iso-8859-1?Q?wKg5CbkC44yUR1tD7ZenLIQ36e2+1MXU+9+EPrm5n+lU7sBYdJt3CjMcfz?=
 =?iso-8859-1?Q?SdRY26RJyuQX1GGKVN4kcUQlsgLiXbj1dvJJqhCWks1rzKn3qqGjMbTG7G?=
 =?iso-8859-1?Q?YjR1nQeBMHg7juuD0zlYWOcUqCX9+/ydgoXQkpl9s8PYY/e4roT4rg5Vq+?=
 =?iso-8859-1?Q?cYEd5wwJVNhIBri6sXp4qyAO9sp0yG9SPsrF5vedWeE7MEVatXoEFJLpVf?=
 =?iso-8859-1?Q?esnOLa/zRnIVn19/ZPrlLyas+q5hb05yqx/TT92podOjYnDkNSyTQ96/ha?=
 =?iso-8859-1?Q?hysmLIWPrayoFq01NO+VmjEC4jpE7GrP4hsuB+0W5DF2EKgVPiNtcffkcb?=
 =?iso-8859-1?Q?qpjueI6wRgwvZTK118yMPObam0ChqQjuCmC5+GtcYV12nqJZE5ZX6v7DI9?=
 =?iso-8859-1?Q?hLOoZ8Ykd2xjsBpl8OqwOPW5yQzTrb4n8QoEXd0dFDDqa2MUA80AzNzjI6?=
 =?iso-8859-1?Q?tryVwjZ8pER200NzUIXu/InA4iGOhUGdYBeXwmzuR/yLyNTcNQsjxti9Th?=
 =?iso-8859-1?Q?c9dqqcCBkVzGsnHVH82p3bBQzSY61PTgLoOUM9jaUDweR538z4sS93ctMj?=
 =?iso-8859-1?Q?Ymm+bKRKBTYH5MLyG0oswH2ZzuO6tycrauZr06SMXXNTItMjhNV34T3t0j?=
 =?iso-8859-1?Q?Ql2PT3NASvsw/Rjj2vQIDmc4fY3P6y8CjIWGsoIUtbYsngFskSR0Gu2Lu9?=
 =?iso-8859-1?Q?LtY2gHVbqaLmWMAwzA8Gt9siglyrI4jjj8RI8qC8SsqJLouxrZQZQOMEit?=
 =?iso-8859-1?Q?aUUQJphYbp4ZBqf2faegNMhNuwuIsHKaf71orTI2d6Re1Uh9H3gYSjAWaz?=
 =?iso-8859-1?Q?vDIU1dg6E3RD1oamn3pCOg0LpT0s8/oMOJ0YaGn2LMezXgGpoTVBdsDQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e89fe552-993d-49e6-bf12-08daee2e794c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:34:19.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cTNprP+k1rCJtvCvTMkRIE5ygwscVkpdcoS2dWpWmaRFTKpdWMU1k3wInZkXZn0zloBcmOMVxijYFqfgFIzMaM/rLqn0jhkQBHlnUVUPZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Verma, Vishal L wrote:
> On Tue, 2023-01-03 at 21:43 +0000, Fan Ni wrote:
> > On Tue, Jan 03, 2023 at 11:05:22AM -0800, Dan Williams wrote:
> > > Fan Ni wrote:
> > > > This patch series extends the `cxl list` subcommand to show the cxl
> > > > topology visually. Mattew Ho first worked on the code and provided an
> > > > initial patch as list below[1].
> > > 
> > > Thanks for picking this up, it looks like a useful addition to me.
> > > 
> > > > 
> > > > This patch series includes the following two patches,
> > > > 1) Patch 1 adds a parent_dport attribute to ports and type 3 memory devices to
> > > > show which downstream port a component is attached. This attribute will be used
> > > > in patch 2 to generate the cxl topology graph.
> > > 
> > > I had a similar patch to do this here:
> > > 
> > > https://urldefense.com/v3/__http://lore.kernel.org/r/167053491908.582963.7783814693644991382.stgit@dwillia2-xfh.jf.intel.com__;!!EwVzqGoTKBqv-0DWAJBm!Xc_tWtX0GBqionoq7JRQxQ39MytJEW3jP-JcQnLrj7Op9_u5mMRg_hUoUvQabHNT_IXi3MbHF2d0TwCsiZckhvCToA$ 
> > > 
> > > The biggest difference I see is that your version adds 'parent_dport' to
> > > memdevs where mine keeps it purely an 'port' attribute. So the listing
> > > needs to have --endpoints to get the memdev to 'parent_dport'
> > > assocation.
> > 
> > Thanks for mentioning this, I missed the patch. It seems we can use this patch
> > to prepare the info for plotting the graph. Need to check more.
> > 
> > > 
> > > > 2) Patch 2 extends the `cxl list` subcommand to dump the cxl topology to a
> > > > json format file or generate a graph showing the cxl topology. To use the
> > > > extended function, the option `-o output.suffix` is added. Acceptable output
> > > > suffixes include .jpeg, .jpg and .png for generating a graph and for other
> > > > suffix, it will dump the json-formatted cxl topology to the file, which
> > > > can be used the input file (with --input option) to generate the graph
> > > > later.
> > > 
> > > I notice that the implementation enforces some implicit listing options,
> > > disables --endpoints, and does some magic with looking at the suffix to
> > > know what to write to the output file. That feels too restrictive and
> > > makes the 'list' command a bit more difficult to reason about. How about
> > 
> > Using file extention to decide whether to dump the output to a json-formatted
> > file or plot a cxl graph was suggested by Vishal in his previous
> > comments to Mattew's patch (
> > https://lore.kernel.org/all/093ebf126ad44920d9c7bfd1c30af5040e0c7020.camel@intel.com/
> > ). We are neutral to either way as long as there is a consensus.
> > 
> > About the enforcements placed on "cxl list" command option, it should be easy to
> > address. We should be able to remove them and fix in graph functions.
> > 
> > > decoupling the support from 'list'? I am thinking of a scheme like this:
> > > 
> > >    cxl list -vvv | cxl graph -o png > cxl-topo.png
> > > 
> > 
> > Currently, we can do similar things as you mentioned above.
> > cxl list -vvv > cxl.json (with some changes to remove the option enforcement.)
> > cxl list -input cxl.json -o cxl-topo.png
> > 
> > But I agree that using a separate subcommand may be a better idea as the
> > advantage you mentioned below.
> > 
> > > This has a few advantages:
> > > - The graphviz build dependency can be made optional where the user can
> > >   detect if the support is present in the build by the availability of
> > >   the 'graph' subcommand.
> > 
> > IMO, this is the main advantage to introduce a new subcommand.
> > 
> > > - Listings can be created on one system and graphed on another which
> > >   among other usages is useful for debugging topologies over email.
> > 
> > Our current approach can achieve similar goal with "-input" option.
> > 
> > > - The 'graph' subcommand can parse and optionally warn about the input
> > >   json rather than implicit forcing of listing options.
> > 
> > Agree.
> > 
> > > - The json can go through additional filtering before being graphed:
> > > 
> > >     cxl list -vvv $basic_filters | jq $advanced_filters | cxl graph -o png > out
> > > 
> > > Thoughts?
> > 
> > Thanks for the comments. So based on the above comments and my
> > understanding, I think we need to decide two things before acting
> > further.
> 
> > 1. whether we want to use suffix to determine plot behaviour or use
> > explicit arguments.
> 
> I think I was taking inspiration from pandoc when I suggested using
> file extensions to deduce the output / input formats. However, I think
> it can be valuable to have an explicit override too.
> 
> So maybe something like:
>   -o topo.png : outputs as a png (deduced from extension)
>   -o topo -f png : also outputs as a png
>                    (specified explicitly by -f / --format)

Yeah, that seems fine. I was more worried about the implications of 'cxl
list' filter options being silently changed just because someone changed
the output filename from $f.txt to $f.jpg.

>   -o topo.png -f jpg : outputs as a jpg - i.e. -f overrides extension

I think -f can be saved for later.

> > 2. Whether we want to introduce an extra subcommand for the graph
> > function or stick to existing approach and make changes as needed to
> > achieve similar goal.
> 
> I think the flexibility and decoupling gained from splitting this out
> to a new command is quite valuable. Especially considering the ability
> to pipe through jq filters. Thanks for this suggestion Dan!
> 

Yeah, the separation of concerns feels more unix-y.
