Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78667C6FD18
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 18:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjDWSc3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWSc2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 14:32:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36318186
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682274747; x=1713810747;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PMc1Kr75q8Tw6ijBGDF7U1ogfYCjngoSxVte5JH9h18=;
  b=mNPS5quvCasL3KFZPAjvISgploAEtvSIHGPX2EGYSXtjyqUXkZBzvUGm
   X0lvTw/Zjf5CKmOVnd1Kc1qfaITyu28CYOPGiVaka57TV/83SJVaZ2KfN
   9hZsR1oz3sCbPNibHNft80j98uSYBpGif0wCsjzLGrVgjYO3bHyH+bYBY
   l2tn6V6Hatn/3xqmvM6tDP9bREmsta5LZpeI81iiX0w/rXfclD8p3r5/e
   rTObEtu6mBh7taTv7GUV7Rnb0Cx4/P0oWKtPJEXWKqw8k6HYHOf+gqeBu
   x/LKBG37gxPTj+zxyrdgc2PwolKTqYfGvgtLoKwD/mYHOmsUcm52aIObt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="409235209"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="409235209"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 11:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="725451587"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="725451587"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 23 Apr 2023 11:32:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 11:32:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 11:32:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 23 Apr 2023 11:32:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 23 Apr 2023 11:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7gic2c16V06lQwgkVeRQRQafLsYOaCvCQITIg514nTgZWoFIUfm1TZmLi5y9cyMs9gmbMvV2NQQRF8EgzThOhB0a+qYCJkrCzhE+reHxWFDoTzfRUjzD3hZqPDo9gU55Cf/OX+fncIBwfIZt0WZXFjJ6qY/RnVqggqJngqf2HIxcJYr4PZq8ZLFQBReG7v+kv//RRWnJIUPL3+lY6TDTCP/KWaMW0aMu59rXktFSdPTbuBo7w+K2t818Idhik64adUdqReeUlvz+jnNCyh78+wUaxCyTfw4coxSMLrDSYdiOVb+VwKUPsw9Ie66TvQ0HPn+DuzIhyPhRx4Zkg/kjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbyxGWDUlBVsrKFN7XHpx+HLAe3gXpMZT8AbXTJsk+Y=;
 b=I6zNDbI2F6VBJ7tXRyr+riX2iIu4+3zeeEDdZOSWxE3mCojxxyJSyRvvLYV7bV865B2oajmqvziS+y3dewUpPDN9gl7qGXsWcfzL+fG5UAZb9AjEb+prCivHFqcyRvWw6SW0SdCA2sowaVXv9B7pNy1A+K6ST8AOpgEawNvf48X4Odfy7MNOktSVCqhE2eprh3BdqnZCqUSsyfxPCfzEowyiu1RM13gXB32xYd3uMkY7DzvRZOBERO9WtAWujhVVpLxVTA9gRYO91k90LbQPuf3xituzf49wGemZIKbZuJcyyh/upyTeBH+w97frPFwdaQhJcnjOkEI3C7v16AQ3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5387.namprd11.prod.outlook.com (2603:10b6:408:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Sun, 23 Apr
 2023 18:32:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 18:32:23 +0000
Date:   Sun, 23 Apr 2023 11:32:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <lukas@wunner.de>
Subject: Re: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
Message-ID: <644579b4bdf5f_20282949f@dwillia2-xfh.jf.intel.com.notmuch>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
 <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
 <20230423160700.00007340@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230423160700.00007340@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 76eb214a-c2f4-4be6-3548-08db44291445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovIZKhOslZH0HV1+f5DcpkfbWVvAxlKiiUCcxEUUK+eVRNUu1IB+cAo4CEaEKU89bT/lCbTaV816ry/JKMrmOB2e3pruzBxVvlac2Pk9Ww/Ta/WOw1mvvOndbgtRBrc5adehhU134Ay55sLkyuirjkcUbK8jz+hG/0+0lRPYGu92T8ukap/+i9nVFrUQ+gbb9bA4jO1sisrlcEcCaoLJeNF5v0aAgZ4CkQcSHbEIsUC1TcEQWkObk/7wJ8t0F1c3/gc8CeUtwDr9UizRUHJFmFnWpt2JrCSoeSs29fR2VaHI7yzTvr98wVdNUVD3XsXYkm7AU443pmqzovTd4CTcs8ZVzu7oK3NtkeZmJ/3NHxFQwSKHY940/Xs/1P/H/NPkxZhsvrPNf3AgVfJdMlhqZ/yFxhAF4OMRfX3slXdRjQs2ZcVoTHbPzr2jEFGWozjmEGkXHB4bc5ZGWTNeC3DIKc2fhTlqxFAEcoinLXqSAgLfOSTk9HESI6u89E1iE8fN2tyvFjfxaazl01rbw/eWKqXjwrnlhXaNaJs2xWAcqMXTcqa0J35tUaRkMVfoBJqd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(4744005)(2906002)(5660300002)(26005)(6506007)(6512007)(9686003)(41300700001)(8936002)(8676002)(38100700002)(82960400001)(316002)(66476007)(66556008)(66946007)(4326008)(186003)(86362001)(110136005)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hTj3yF7lTKXn9TtoIqDk2H6I9TQT319O88b3Iw3DHRU6NIhVBAll7uEhvH1f?=
 =?us-ascii?Q?RCG0vlvQfKFVZeANEmlYP69K/vsBdqnORLhZkuZ7+iaD24cYGIfUhjfjVu2R?=
 =?us-ascii?Q?YDznD6S8OPEYXxTIJrSDWT1HC74Hanm0ZpboEPrrIY4Lstn5gPrmYJT8qk2x?=
 =?us-ascii?Q?8BbDFeDSOr4r7Vb3bht0FZh9AMVJV7nLQ0FHcL6lJZRAy+KGiVP9Qom8SG1h?=
 =?us-ascii?Q?EwMFDO9KgAbNPCDUe2UBcaY3pGnk/k9QzJ7vuyiOQuOhCZrz8b7lGVWHMBOt?=
 =?us-ascii?Q?x7TEswj+ARd5dyTMuFxjS3TBK1vJ20MIIW8wEKOblB0BVKWQsnOuqBjJzkzp?=
 =?us-ascii?Q?h1JybIBviS0OPuJndLqhpjyC4x/n74vsPzId9y0xrz3jV++s2yyma2jah0Wo?=
 =?us-ascii?Q?efRFbVTfq7e92R2FNAZHSpQ+yuusBbstuLzwg6jgl8oQvPLchv19yefzQEi+?=
 =?us-ascii?Q?fLA1AlRatNDhWaT87GUYWBgyZc8NIhW7YHHYZ4h17snBjiZ0lV3bQMH0+y79?=
 =?us-ascii?Q?jwxSENTSedEy5sCu2cfyfmE3X5dCdKboRPvt1LBFyH99bjBFxiRWmKk4W+zr?=
 =?us-ascii?Q?xTZfZ9Xvgs8y2j6jEjhfZgwzK+ZazszV0OjMTbs7iG1srGcXD/dWaMMQzinI?=
 =?us-ascii?Q?f/mJvdOMG1PuxaAqVxO4R5bbPjIN51qrZpDo/tFTMmZ5Ozh/oISNU6r4rwDM?=
 =?us-ascii?Q?LkOE74gby95f0VnygVTSAE5rCdDG9TVnaj39hLPZmpMJBykeVcnlnK63RLTg?=
 =?us-ascii?Q?nhleIXywQxm06G3Yz9es3r50StA154K+Tfq/5Qy89Eo/D/QnTyWsdWdQKGYt?=
 =?us-ascii?Q?ngu7eWr6qVqT4f61xlT8a3v+BR2uNIIspqdVlGXn/fsJ0P6BVzNPyXeC3uJc?=
 =?us-ascii?Q?a4uey8ydx/roGanXsKOqB48kYFVmZq77dNzHPq6Il/gO2v8z2R2bmYX/I1kD?=
 =?us-ascii?Q?ZU43yoNrpxU4sqGhf8VWe4mKoCSa13HmWi8llkpuQM7rKcvehl2YVnqd9rFz?=
 =?us-ascii?Q?aomnvwlO0vUubtKjOdmzdjX7oKdxwKcJyHoroc2BYjUXt2bvTWIXTUpJ+Xef?=
 =?us-ascii?Q?lXP6j5agh35zCK1mRpbSrhJ0v3BYP/Oky1hzYQcq8J09iIsuHqSsSbGcUJte?=
 =?us-ascii?Q?Y259ULqaS2TxGoRSJTUegmc1giib7JBQ8Zqg26peAUA/XzEhjT2QyfUy2mxX?=
 =?us-ascii?Q?tgZj2HMPqChh8OJQ4Pmdqmlm3cvlobDipsshFt4M115OhjlMmStSJVoPpUeV?=
 =?us-ascii?Q?BrVjTU5qQu+9N/l2GEi630pXOtpuSL2UCQ5bVa2CWYHYX8LZqFobuDg7jc55?=
 =?us-ascii?Q?ehGiiDgzjlTmOQBOSjrGxj+jdw3JN07++SGw+5uynKk9LOpdUfFW08Dz9fMw?=
 =?us-ascii?Q?m1Kr7AfafWC96A1VTX1/I86smxwwyG5rpaf1S0Bdp4+6B9FS+ocZEeA22h3C?=
 =?us-ascii?Q?vm3Ok4QTGnmNgxJ6MpCq3I2/pVePKv77WheuI65zWUlU/HazP+SCGe9nlRzv?=
 =?us-ascii?Q?xlBCcdtpbxn9xa6cGngcednxpvfOfwuYtaMtj0YZpqQWTW64nMYlyK/m8LIx?=
 =?us-ascii?Q?RCiDMuBzL4B0AkPptcs3aoWgc1ToYioU9WoKjOgf9XZrxnEZFAl+eixbEr0H?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eb214a-c2f4-4be6-3548-08db44291445
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 18:32:23.1441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHeeKUe5zIta84ua9SeAoNQGHL7SokjXvoaOsxAgHyc7QpQQSNd/EpuiPNhWcjk5u+KO6DkCKL2lSl8BgnSpLrqoU3rZ8pZioQPZt5ErW9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5387
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 21 Apr 2023 19:51:47 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Not all CXL ports are associated with PCI devices. Host-bridge and
> > cxl_test ports are hosted by platform devices. Teach read_cdat_data() to
> > be careful about non-pci hosted cxl_memdev instances. Otherwise,
> > cxl_test crashes with this signature:
> 
> This is crossing two paths.  One memdevs that aren't hosted by
> PCI devices, two the other port cases.  Right now this code assumes
> a memdev, so calling out the other case is problematic.
> 
> I'd just drop the mention of host bridges or mention that we only
> call this for memdev ports today. 

Yeah, the reason for mentioning host-bridges was more for 
educational purposes of highlighting that not all 'struct cxl_port'
instances are associated with PCI device objects.

I'll drop it so folks do not come away with the implication that CDAT
data is retrieved from host-bridge ports.
