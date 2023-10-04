Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2DE7C4E9
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 18:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbjJDSro (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244590AbjJDSrm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 14:47:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087AC0
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696445254; x=1727981254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=huOBchUsxAcEOa40WMbg4mbNck0bbM0bmArFzEPNX4s=;
  b=PSgG0RSBoxItdasJl2UsNx0RcXuh+l8W2IEYR8Ls2ci04i2I1rZkL9Sy
   /d87e7wje8aE35VtbRPNCEh8qNmQiPtcmNzO9lWNYab6xgjZtgcpO7FG6
   runvZvoDzBnK/dfT8VEn4WVLh25RbfitJr24pgaPCM/l01s7QFxuWFXT8
   mTGpfI782nwCAUxBSRe5ILaQTpXSNiAgIxCnTPqbBXw77jvCVk/XNANw/
   P6sS81pTwfqPMoyLUz0FcMU/XSK3U8ZEhdhHdIRsICdI8/nc6b2KeVXzX
   5F4xk7pMtu0qbvPFKd4oQUWao8Qh/rTTFcS5DwABFlF8AboflBWFKKCQL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469541018"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469541018"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786630567"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="786630567"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 11:47:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:47:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 11:47:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 11:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyCN0S1lGbJt7EtwJtQ4Sqitn5HHLDwnZZ9kK+QHRyNALngow9qSqgF7q9wswF5lLKb52z8c2ZuM0ds0LmmRumAg/jF/d3zN5Oo2/4tuP9fqe+kYPA+QP7A2KlVNVNnVojx8ke2czSV93cWaVDc1uTdY419x7IfEoBm+NxU3DKRs2npuGBKmDUOPIb5FUGEV4gApul6Rlm9gZtP27twrwTMVnrQdO8WcfYHSIy/dwD0b89fxHV0lDjjd/IQBpBXRclYyD6FVOfpUYvaFnDaFHcVhC83ufpC/5eThh/s7WN3wVVYKrvuWtLYG+aGW14S3Xpo6FjLQhcvqg7ffJ+XA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTfkmDPomFg2a4NUxUYmYLvLF5tydZBpbdWpLPcZcx8=;
 b=GoYLp2khdreqqqguPTATYeVquTDHoBtqja9S2J4Id94ugaICfkNJlzy+pSdTYUIt5oqZh4YuhtOO0Oqlg2QkFqgjqFlJ/zdeEg9EZx5f4KcT6bRrtfGzuaxF/F2rfPlNZtQ0fP0sNDJIBmiBI4VR5uLjbgAf+crNUEXl+uMguI63YXfC93Z94ctQex9yLx5Po9Ib2371j8XG2cMgdB/FADNWJb39TUbMKuFeRwlKnehKUiMEW81TcUkYwftwtsSrc+FpCk8IRwAOcscGECvMmNy0PQ/8YAQzurRLIY00NOfeobe7UomX21KYjC6F2/mkD1dli+btCt9uQ4x6KSCQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7452.namprd11.prod.outlook.com (2603:10b6:510:27d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 4 Oct
 2023 18:47:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 18:47:24 +0000
Date:   Wed, 4 Oct 2023 11:47:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <651db3394422e_ae7e7294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
 <20231002111046.00000f9e@Huawei.com>
 <651cb9024ad66_ae7e72945a@dwillia2-xfh.jf.intel.com.notmuch>
 <20231004111220.00002dc2@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231004111220.00002dc2@Huawei.com>
X-ClientProxiedBy: MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: c33d5d92-898b-498b-55a2-08dbc50a5960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bX3BKHWYbClpvnKOAd70vzJGhJr+TZP5VWGIXPhueUqX8jdHcIbQK6iCPNxQAg4mSYDCIOziqBpF2qEBVcf4aTcx8TfyEflq6a17PNELBaHZ9zLxaoLZobD4up4RiJSc5ToL28xuhGKpCtEY3lxu212Bgmxf1x/7OxXxDbcLkfCBObgh02YG+F8ydwUOC+a9Xi8jNVb8fuMsLCjXlSQO4J81gHLzxQDDjCluu1/ctODSLHgeSqDNBSZjkiMHcSP6YvcZXxt+1pnNM+U+tCDsvUqmh12yDU4ZIXzaP5tFLc+wzkKSaIEV0/oghnbbfWCTxlMUwERBVcaA4Y+R/Wzlj+p/GblH92vgvcMs53OovllWgkkC4DmqDh9vZMvmbKd00Lun/jEvMegzZ5DRO9IFwA6w/P2nOaWlFBQ3HK/3noOKf778KDUOacrOhRQGmMlIhmYaIuUc73YTtU9s9x20nk/CrppZa5HAaf+NArZFNFs8fjZQVwITwfHQ0ZQcV4euLViysiWvXDdRQwN7/7DMCB8hSGe0R6m0FpPC6H4ZVa71rVdkKBpE4X1+q3vsBlqd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(110136005)(66476007)(54906003)(5660300002)(478600001)(66556008)(6666004)(66946007)(316002)(6506007)(41300700001)(9686003)(2906002)(6512007)(8936002)(8676002)(6486002)(4326008)(86362001)(82960400001)(107886003)(83380400001)(26005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NQ8cSJiEpfI5WNG085NTpVPU1Z5XR5IRL87m4JF7murvcmkh9zinlk7GKVa+?=
 =?us-ascii?Q?PoWI4jaRjl2yNsbI7vqTs0p48pFcgwWup+Wok9YAod57xTtzflO5FD3plecc?=
 =?us-ascii?Q?df8ZcOL9Oqof88afgz88aWlO+VNr2YkG/ovktAWpemV/q4A16pDGINJFlT7r?=
 =?us-ascii?Q?fpdyMKmeR6USLyZLBJzjVp6vHzcBmiLFMDqs1XWVG0fKW1eoaZahgPYrpZo0?=
 =?us-ascii?Q?wr66h4Uy9dUkdbuKt4MfMkAG/HSI2pv1XUrYrOS1avOSWD3Lzs+T4YUInYFI?=
 =?us-ascii?Q?AUfAy0GjPJMQYwYHO3byOjjMpTFfauLHdUM2EpyZObwiNhF1Jb6otwUeslNF?=
 =?us-ascii?Q?QvIikxGPwzafqK4oEndbzOBlFDb7LysQlNEa6ouHNYTxB40oqVs4dFwUwyoL?=
 =?us-ascii?Q?6yjujIqihcJi1R9nF6xkubslm5c5AAS1xyKlzd5otZXIGa/wxJXREO/qmMH9?=
 =?us-ascii?Q?dWstsgseXIS/kO4sSEI6hqQoTba6IKchcskA7K0WCJTVu5IDugQ5DnYbnkiN?=
 =?us-ascii?Q?PL4Agk6+hz9vzmz7Vf0cM6XdO7V4OzPWkDo/FDRxLLqsaHZkEMMtD1Y5hV0u?=
 =?us-ascii?Q?tVznKk4VKnJkVkobPIjp0Sfdm8jKIXKRUA41JpS7JLFC+hoXLrpq+EXEmhXt?=
 =?us-ascii?Q?+I26zcIA8NatwtrMa4kdmtfGT1AbD0h3FIbzh75wp9i3SnP/FkebcnqBbpBs?=
 =?us-ascii?Q?FMo2y2ixVUU4EJ34qq6zE7fedc9ITQ/Ztzi+loQmzcb4YemG6KhHVpkNGQos?=
 =?us-ascii?Q?B+GM8IzvBGwqWTkqkqwveuG21CJgQfuiIvMkDYivYHWhYCHCd2Oz/5nPElCP?=
 =?us-ascii?Q?6BGowQ2pRYJDdbmjeBaAYTqJkcqFwzT/CfRuwM9GGSaPog5D5gJuYgOSH/yg?=
 =?us-ascii?Q?aclqmYIGDl5jbJJj7lme5xRaW1H3vhrPu2KfryEHY05YBmo0kj3MCPcSA5bh?=
 =?us-ascii?Q?waGpAeV2JmslkUvXqgP/TkTW+5wZNZDNg3vhdFNc/+0UvhU0AmuLkZdkLLt2?=
 =?us-ascii?Q?S1Me1QSRroHktDxWfpYgp1P+3vaQoFnL1ZsZfC54tEY8RGOmwpYBNSdfGRMW?=
 =?us-ascii?Q?fB7mjKhf/MkNMRFqHP5YIyu4WWL/YuF21D1ZMyuwyip6lTtkKUFYD9x0/jSo?=
 =?us-ascii?Q?Lc0Nhs0fGGTr7pcQzz4AS/2NE5Bhez3fnaiH6Pr7+KoSQbMdLXkACY8dkskr?=
 =?us-ascii?Q?345S6N9Z5aEy/xOPhXRT4hfnls+My3Zf5S0B+ocxfHfIXU9nW+siSTETid6H?=
 =?us-ascii?Q?+9l9c8ZhmHsDhCdt1dciHtdjiSGdimfW8dFE8zPCLrLu5OAdJfP3mqMEcH5d?=
 =?us-ascii?Q?4vB3kuJHOYsZXdJ/LqLT2w30SEgMe55Eq2T+Jr8RhspshiSni1C78U1h731+?=
 =?us-ascii?Q?2MlfNdstzVHSQygBrHSW+UeZIq7Hcd8BDObHidZVeAY7YP7sYBxeAFSNtJRl?=
 =?us-ascii?Q?dHlWoIgOwmZE6PFYPDzBa8RzBntH/BRW6y1Jm3ILNX/3ZPd8wJz/E3tX0ij3?=
 =?us-ascii?Q?xSSW/yHJaQ7hkKqd5z3bgxtMJ4CaojK6lc4HITwiGTpPP5QDvkgc3xbzlQm1?=
 =?us-ascii?Q?nr9Y1JPg55u4awEt+kumSqD6VdYySHGlY2+3R8HcWPhuNbNgcEp7RN6z5/z4?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c33d5d92-898b-498b-55a2-08dbc50a5960
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:47:24.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beDEcxlPDXzpqu43qsUpt6qFkczHYma1U5HBRcNIvU6YM7jh8XR/JJO9U/SGZHrPG6D1zcXNbKjR2+dlVV7Synza9cD23StzbfpJrzlAXxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7452
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Tue, 3 Oct 2023 17:59:46 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Fri, 29 Sep 2023 16:09:44 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >   
> > > > Fix a race condition between the mailbox-background command interrupt
> > > > firing and the security-state sysfs attribute being removed.
> > > > 
> > > > The race is difficult to see due to the awkward placement of the
> > > > sanitize-notifier setup code and the multiple places the teardown calls
> > > > are made, cxl_memdev_security_init() and cxl_memdev_security_shutdown().
> > > > 
> > > > Unify setup in one place, cxl_sanitize_setup_notifier(). Arrange for
> > > > the paired cxl_sanitize_teardown_notifier() to safely quiet the notifier
> > > > and let the cxl_memdev + irq be unregistered later in the flow.
> > > > 
> > > > This fix is also needed as a preparation fix for a memdev unregistration
> > > > crash.
> > > > 
> > > > Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > > > Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > > 
> > > One trivial question inline about which parameter to pass in from the
> > > many many interlocking state structures...
> > > 
> > > If you do make the suggested change, it's just complex enough I want another
> > > look so I'm not giving a tag for now.
> > >   
> > > > ---
> > > >  drivers/cxl/core/memdev.c |   42 ----------------------------------------
> > > >  drivers/cxl/pci.c         |   47 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 47 insertions(+), 42 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > > index 2a7a07f6d165..a950091e5640 100644
> > > > --- a/drivers/cxl/core/memdev.c
> > > > +++ b/drivers/cxl/core/memdev.c
> > > > @@ -556,20 +556,11 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> > > >  }
> > > >  EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
> > > >  
> > > > -static void cxl_memdev_security_shutdown(struct device *dev)
> > > > -{
> > > > -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > > > -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > > > -
> > > > -	cancel_delayed_work_sync(&mds->security.poll_dwork);
> > > > -}
> > > > -
> > > >  static void cxl_memdev_shutdown(struct device *dev)
> > > >  {
> > > >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > > >  
> > > >  	down_write(&cxl_memdev_rwsem);
> > > > -	cxl_memdev_security_shutdown(dev);
> > > >  	cxlmd->cxlds = NULL;
> > > >  	up_write(&cxl_memdev_rwsem);
> > > >  }
> > > > @@ -1001,35 +992,6 @@ static const struct file_operations cxl_memdev_fops = {
> > > >  	.llseek = noop_llseek,
> > > >  };
> > > >  
> > > > -static void put_sanitize(void *data)
> > > > -{
> > > > -	struct cxl_memdev_state *mds = data;
> > > > -
> > > > -	sysfs_put(mds->security.sanitize_node);
> > > > -}
> > > > -
> > > > -static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> > > > -{
> > > > -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > > -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > > > -	struct device *dev = &cxlmd->dev;
> > > > -	struct kernfs_node *sec;
> > > > -
> > > > -	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> > > > -	if (!sec) {
> > > > -		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
> > > > -		return -ENODEV;
> > > > -	}
> > > > -	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
> > > > -	sysfs_put(sec);
> > > > -	if (!mds->security.sanitize_node) {
> > > > -		dev_err(dev, "sysfs_get_dirent 'state' failed\n");
> > > > -		return -ENODEV;
> > > > -	}
> > > > -
> > > > -	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> > > > - }
> > > > -
> > > >  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> > > >  {
> > > >  	struct cxl_memdev *cxlmd;
> > > > @@ -1058,10 +1020,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> > > >  	if (rc)
> > > >  		goto err;
> > > >  
> > > > -	rc = cxl_memdev_security_init(cxlmd);
> > > > -	if (rc)
> > > > -		goto err;
> > > > -
> > > >  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
> > > >  	if (rc)
> > > >  		return ERR_PTR(rc);
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index ac4e434b0806..b0023e479315 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -165,6 +165,49 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
> > > >  	mutex_unlock(&mds->mbox_mutex);
> > > >  }
> > > >  
> > > > +static void cxl_sanitize_teardown_notifier(void *data)
> > > > +{
> > > > +	struct cxl_memdev_state *mds = data;
> > > > +	struct kernfs_node *state;
> > > > +
> > > > +	/*
> > > > +	 * Prevent new irq triggered invocations of the workqueue and
> > > > +	 * flush inflight invocations.
> > > > +	 */
> > > > +	mutex_lock(&mds->mbox_mutex);
> > > > +	state = mds->security.sanitize_node;
> > > > +	mds->security.sanitize_node = NULL;
> > > > +	mutex_unlock(&mds->mbox_mutex);
> > > > +
> > > > +	cancel_delayed_work_sync(&mds->security.poll_dwork);
> > > > +	sysfs_put(state);
> > > > +}
> > > > +
> > > > +static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
> > > > +{  
> > > 
> > > Almost everything in cxl_pci_probe() passes in the mds.
> > > Why not do the same here?  
> > 
> > Because this one really is built on top of a stack of things and needs
> > the 'device' because it is tying the device's sysfs attributes to the
> > completion notifications of the background workqueue.
> > 
> > I mentioned this in the cover, but failed to mention it again in this
> > changelog:
> > 
> > "The special wrinkle of the sanitize notifier is that it interacts with
> > interrupts, which are enabled early in the flow, and it interacts with
> > memdev sysfs which is not initialized until late in the flow."
> > 
> > There are no sysfs attributes reachable from an @mds.
> 
> I'm confused.  This accesses the sysfs stuff via
> sec = sysfs_get_dirent(dev->kobj.sd, "security");
> where dev = cxlds->dev
> and cxlds is embedded in mds.

Ah, no that's a bug I introduced. The dev should be &cxlmd->dev and I
made this mistake when combining the code.

> So from a code point of view I can't see the restriction.
> Is it more a semantic issue that it naturally feels better to use
> the cxl_mdev?

This is also why I wanted a positive test result that I did not
introduce some silly bug, which I did. My typical capture of silly bugs
is cxl_test, but there is no cxl_test infrastructure for sanitize.
