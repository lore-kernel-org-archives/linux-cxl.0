Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C8AC001B0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjHKTxe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbjHKTxO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Aug 2023 15:53:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD53EE
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691783593; x=1723319593;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F6oknxdBdBBLd0G6YNlC9sP6YBljKZJoOe+4LItrsac=;
  b=I7vvqf00hiCn1iy4E4S0uEoL75AkyNnxUQ5+W7aAhhtrE6xmAS4uqv2p
   pDTM2MuFiY1K/w4kzpkwGs1u2zjWXgwWGkxqEQDFFby1SqnJqT+aD0H3P
   pB1YnDq7NWBbmgP98Ecb+PojdK0V7J+2pMZoOQP02wBoEdoVPxq1NnqLs
   MgX9PJIA0nGHD/QFu8hvU/iECEE/Cwi2B42cDBt4lLjZxqkcwg7SvK34a
   xGNiUWc/3uAVOINotmAxON9wrzvblf2zuZ4B8kZivN7A0JIxuuZZ4j0ym
   4JsBwVmVfXEx9MuoQJDhmD11AiwOmprOqOaaYXab0KMy5Hx2FGC6Se7CZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="352077936"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="352077936"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 12:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="802788061"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="802788061"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 12:53:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 12:53:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 12:53:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 12:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHLBLlf8KKyuG8mtm3tMMGCPuW9ZQUYBGc7i4o1ZWjtlcAogRZQlDBUo058ErUiJbmJPlAU43+2orZ1U3EuB2pDZ+f3xJAVL6XrNqoRGPGudPKPd5Wqx5W77W2f2tPkQu8858rRguw5Kn5UyX+TGcMcgOAmN8a6fy+R+Va8AbURTHdJtJKGN76hDbSD/xDYhoWNMMYcFwa56E+A6g2ECKbwzqYNIgJ5kA35G3fF+Xz/+v47vE955CzNrxxDE4d86ut/Hl2tk81cb4rxbTc8Yppw2Q+JgorZasSwcTORNq012c/gebLEHP+DJl6fsk/PdKDh7d9ZCU2sNucz6hi6p4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q30BdQiyCYRPVi/EQ32/TAEp9fFtxCzzIH6OzXMTrj0=;
 b=Ey4PolLvEsaZT9pFN5x+0XncDE94c6xJtvtQPSolS8nCC2HnM73fcQb7wLvQfJEojAmwd/ZgXSNMNAI+sJ5GZpO+mZdBK1vBzxRvy6f4Gpvex3FI8qURukR5xU9w7sizKGU36y69UrhbGKVA6JPIk/AZyw6L7wJvWSM/TM8xsZIBxdKJ3Pwq9mq7LwTTEuj0AaRiFkhqHF63fdOzeasR2HJsxbBiGNGy/j828TWDJklFFqH1NmI5y5WQOUsVxd3Z5LiV4jMXlv47w2JF9R3gV9PifUFu0wCIUYegSkShxz787f6SoWG3L+GC1azbgOT59e01qiczNg1LP46UOuGjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 19:53:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 19:53:09 +0000
Date:   Fri, 11 Aug 2023 12:53:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/memdev: Decouple security init from
 devm_cxl_add_memdev()
Message-ID: <64d691a0f2e74_1aed4629493@iweiny-mobl.notmuch>
References: <20230809163733.32008-1-dave@stgolabs.net>
 <64d5392b3364_1aed4629443@iweiny-mobl.notmuch>
 <w6qikszveyi5ns7oqsjld6nhqtiid56mkyof3tghubz2jxxuh4@fbqkkp3znxn4>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <w6qikszveyi5ns7oqsjld6nhqtiid56mkyof3tghubz2jxxuh4@fbqkkp3znxn4>
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0f7da8-8bb4-4996-c30d-08db9aa4963a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVeZsTaS72mcmoghUM0XzHhtufuELcMO+txxfLs4hZAl7WNZV/plw27OadadY7E/U6sOZhnefZDdsU+xezvEp1CUGagBFtz1z3oOldV3oEZtqfDeSvmrMwvkA4asJpxsvifw3tL4pB4chNOoyCSrF9zqfhIdh5i4Dfmf9kesLB22l9cmBUIBlYz9/3x0wEq/DwzO6hhL2b4YXoBKNIEaOK0aIhdOwo2FB2Y4Dk2PcxSDeyTUCOTZ7QT7ZIgH/02NVoqcyJA2pp9S1bxr49lBDIuieuVH2JXa1rPxg+F7JE6+sPZ8KSIVMuDsunnN6Z4dIuufpnoSycs9ZyHhraNZivIDX68N5ADQRnVqPFTDO8lnQ8ciWDYWfzKiCtZ7eVXQjOZeh2LxS+c+Af7DYcNOz3p5AhY3kI59HgkWsVzqj/v7fLDPYdPurRzAQZ/fJa97keb+ch1XCjMlmdyuJ3t1uWC3gzoh+RjMHILivh7CviC7Wl6M8oAs/nawreEd4oFOiOFhTfs7xOqkHISEJuYiZ4fCDI/wIKyOr3I5H/f74Bn9KDcZofDvwSAIhXRg9OhR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(186006)(1800799006)(451199021)(5660300002)(6666004)(41300700001)(26005)(82960400001)(44832011)(8936002)(6486002)(8676002)(316002)(6506007)(15650500001)(4326008)(66946007)(66476007)(9686003)(66556008)(6512007)(83380400001)(2906002)(86362001)(38100700002)(478600001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ngUdV+uFcwi8p2j79aEO/wYjvgoO5Jmui823JEBEqW8eeOCKkOWaH9gRLVWZ?=
 =?us-ascii?Q?FRa1jU+XaAii7ul+zp8gDWhgXb5Rwjo1sSYw0y+nWNXy246ANooE3Mw9T1HI?=
 =?us-ascii?Q?2Y3Pz181NgavWNEaoD/L8Mf6aIBzk1TZR0GUO+nxjrCQHMKFzn7dXjRxzDKE?=
 =?us-ascii?Q?pKJqyPNk1bcZsz1+tlk7xEMwWuvoLM1KX2kLy1Z0H3K7oI6mNcpREqVISpYD?=
 =?us-ascii?Q?SbWTq0IKqdQJX1ygfWJCjpKZ0igmpiWwHBjCQYCKZcE1nzG5VgRBhQBTFytQ?=
 =?us-ascii?Q?emAn9wVKcXtkf8XEdxd0AkhgdVPKmgCnKuHjTr9SFFc90LJVKCR5dAjjI38y?=
 =?us-ascii?Q?v6Cdm6osOIoW0XOn5QtAzIRrjqVi6CN4RLW6PxCLKJD/t0PRW59gcegu5DXh?=
 =?us-ascii?Q?FfUSWosLR5IsCpATElltlNIWPdAr2IjhbKIAJY3X/sW1FvUGwvANME9sSvKz?=
 =?us-ascii?Q?f9/r7w5q4SmUuuU2NY6lUrSqAGIEdQ2wBT5un5a+znQTvRQSeScTym36GRoa?=
 =?us-ascii?Q?5eVfOo1nAZ5HEgj+D5zasltee/dUoLOW65+aBUuYDx8YPNBGAZMiEborUAUF?=
 =?us-ascii?Q?GeWW6Xo8NmKjNLYqLBu2NoTlmG9DpEP/UVyioWJtbvjQNwHXwWMQLcdX0jqW?=
 =?us-ascii?Q?ZaYhmPeY217nu4oHzzgwfFjXifE1eNnIdwrqBFRxcNQWtLcp5ZnwtRGCYZuj?=
 =?us-ascii?Q?Z+e5ihiFapctFlW6FjFuQs2d33T+svfYG+f+E5wY/jO4lEV7tfETUyAAPE43?=
 =?us-ascii?Q?j1Tiod0SWvYtvr5PES+dHdewRz0Y0rBa1hcMkzO8IA6XPZ3uybUWktRSxkQ6?=
 =?us-ascii?Q?Si+oGgNZ45IF1TyEpN1y8s7jZWWyKJJln4sQmV9XR69Aosp3zLRyC2Ftt8Jo?=
 =?us-ascii?Q?lg2GCiJOwz08IaCn20pIhTtEHZRcRiBpi3/Nsu+Fc+3vdcpWp7PHYe2KnxcZ?=
 =?us-ascii?Q?+lD+0nbwzzqOgTiyeWjAEuE5UtmhJ0sfplHJa3hmR+Kr+xaHqtdHwMhQ1Xy/?=
 =?us-ascii?Q?v3vtiGOs+GGNbf41CIj+Cv+chCUeB4CRyEKOwUVblEAceteOe++u6ntn6f3S?=
 =?us-ascii?Q?ZXO6IJRsdwvkY6fsYTEcsakm8MSCyNdV1uqIk/uIpensOmiGTLQYZE0xOhuO?=
 =?us-ascii?Q?sQc14GwbylRdQys051QEkpOoC9WA6Bmasx2uQXi178GCXOalywB/OLyxuqOB?=
 =?us-ascii?Q?Khi7rNreSLIKnVr54Iik3TpGi0yXQbSSIAnMx81eC/5llsEUxgqmRzU7Y+j9?=
 =?us-ascii?Q?psaPz99MOpI7vLSvhXx00fcr8PE/xJqWN/j1TSnG0JfVDbspt0ylYSZny2Ui?=
 =?us-ascii?Q?sx5O8wxn1OjU63vhUQJMGc5J605Fm6LNQsYCTJHo2SRCByWIqM93DwMQLwHu?=
 =?us-ascii?Q?wIc0haQEWvZz1RBp1Wb3M0jps3znrv3O2OH/161oo6XSZLCDxSIr/A/Jf8ZW?=
 =?us-ascii?Q?fYUiuCR8I0mVsAW0wCJdyzl31FcEw5XNsFUj02r374UOLlyV0bbwihrA6kYP?=
 =?us-ascii?Q?Y/hWUZLydCLXSC5Rltv9IRJaP7NVN9QkcL+5L36Bxjl9Vu4Tkjcclu6/IcAY?=
 =?us-ascii?Q?4ox2pTc9MOFNbGVvZnQKP4HDtMxeC8pm1yoweCIX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0f7da8-8bb4-4996-c30d-08db9aa4963a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 19:53:09.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67aHHNfAadVR5NdbSIWzklO/CgLuKpmCGqeZTpVlLr8sp7957F0iJTSXY6cmuCbcU5sMLwpMe9Nrl/Ca5QUz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Thu, 10 Aug 2023, Ira Weiny wrote:
> 
> >Davidlohr Bueso wrote:
> >> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> >> index 14b547c07f54..628d9d1fb795 100644
> >> --- a/drivers/cxl/core/memdev.c
> >> +++ b/drivers/cxl/core/memdev.c
> >> @@ -561,7 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
> >>	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >>	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> >>
> >> -	if (mds->security.poll)
> >> +	if (mds && mds->security.poll)
> >>		cancel_delayed_work_sync(&mds->security.poll_dwork);
> >>  }
> >>
> >> @@ -570,7 +570,6 @@ static void cxl_memdev_shutdown(struct device *dev)
> >>	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >>
> >>	down_write(&cxl_memdev_rwsem);
> >> -	cxl_memdev_security_shutdown(dev);
> >>	cxlmd->cxlds = NULL;
> >>	up_write(&cxl_memdev_rwsem);
> >>  }
> >> @@ -580,6 +579,7 @@ static void cxl_memdev_unregister(void *_cxlmd)
> >>	struct cxl_memdev *cxlmd = _cxlmd;
> >>	struct device *dev = &cxlmd->dev;
> >>
> >> +	cxl_memdev_security_shutdown(dev);
> >
> >NIT: Moving the call to cxl_memdev_security_shutdown() kind of threw me.
> >I see why you did it.  But is there is a way to make this call mirror
> >better with pci probe?
> 
> Right, this is the disklike I had with this patch, and have not come
> up with a cleaner way to do this except just doing without the call
> altogether and move the sanitize corner case directly into
> cxl_memdev_unregister():
> 
> static void cxl_memdev_unregister(void *_cxlmd)
> {
> 	struct cxl_memdev *cxlmd = _cxlmd;
> 	struct device *dev = &cxlmd->dev;
> 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> 
> 	if (mds && mds->security.poll)
> 		cancel_delayed_work_sync(&mds->security.poll_dwork);
> 
> 	cxl_memdev_shutdown(dev);
> 	cdev_device_del(&cxlmd->cdev, dev);
> 	put_device(dev);
> }
> 
> Then we don't really need to mirror the init, specially considering that
> ad-hoc sanitize checks are all over the place due to its nature. Would
> this be preferable?

I'd be ok with this.  In my mind it is more balanced.  Especially since
cxl_memdev_security_shutdown() does not exactly reverse something that
cxl_memdev_security_init() does.  It is really just cleaning up any
outstanding work.  But in reality we are bike shedding a bit here.

[snip]

> > struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> > {
> >
> >>  {
> >> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> >> -	struct device *dev = &cxlmd->dev;
> >> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> >> +	struct device *dev = &cxlds->cxlmd->dev;
> >>	struct kernfs_node *sec;
> >>
> >>	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> >> @@ -1029,7 +1028,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> >>	}
> >>
> >>	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> >> - }
> >> +}
> >
> >NIT: this is an unrelated change.
> 
> imho such a small change makes more sense here than a separate patch only for that.

I actually agree...
Ira

> 
> >
> >With the export fixed:
> >
> >Tested-by: Ira Weiny <ira.weiny@intel.com>
> 
> Thanks,
> Davidlohr


