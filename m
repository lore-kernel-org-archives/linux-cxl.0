Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A4EE8FDBF
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 01:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjJDBAC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Oct 2023 21:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDBAB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Oct 2023 21:00:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA658A9
        for <linux-cxl@vger.kernel.org>; Tue,  3 Oct 2023 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696381197; x=1727917197;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6TLSrci94O5EJ4XSJyUv9yxemetZdiQrQ8QXef0xApk=;
  b=iZPYHnEfAdlJGPgOi7f2sSNBR4GVx81vN05MeYRhrRnWNfLv0NTrT1Xl
   293pXYt8t9IFgFYVmiOfVHLiaoZtaoW254FR2uzWDuErCMFsSYXSmFyPi
   gtjh0FASm1voxe+9gvCdYAJJoBf5rAD1WpsL2TvheZ2n1blwsmVyoYfAF
   J8hdcpKq3AG/ePGK+Zjw0GJU43i8Ij7Q+W+EKa6cBfiWkFByVKOpmzghD
   aNWYxjuKJVACsb/gff66mHAWEr76wllBSF8D7M+3KnwWawfgnTrJjy1dN
   9F1thZrVGjqa+4BXT/UasbcCydCSwXGHzyy0G0b6tcOTv3IhRkTWu/a/j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="362376642"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="362376642"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 17:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="744704014"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="744704014"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 17:59:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 17:59:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 17:59:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 17:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLzliFhmAK18uvqtS/kgDqCeD7v9XcS7puG9k+2WMg8WoBXMwbPcec4wgCVDl75Pgb2sK27zfjRzhIYH/Rtr9RmcCZ3BYbg/etUTOxvQLwql6NfKszMdjIcNsK0dqHTLXLHLRVo7XthsBXQrLpHgk/NLUZKdEccYehTODiXCvIEjyzQBXLwQMERorz9TiF4nvhCY0IfbhwhvJjC5OJ5wsKdY0RxQghQo9mP/KSFhd8Vrx+FZTCj7C+cOcRyunbUhG+cskpS4SL5IRHbBQHIigum5qSMP0nqpbKldhUu/BBHcacb1HAFL9ZwNPRJ3gNBGRwuf7wG+ugC0F5Pd1xD/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXPF68ruLKBFY8abG0/XIwTyXsSG60xJTklrr0qDX9E=;
 b=UT8QrcQWgu99xMCIFw1/Amlr14CwpiR6we7MwafF3xywNBhL7Jj/P4wpvRFJBSGjurwyD3rTKgF7O8SvkxGDNurcd9bvF6CZWLD1uKa8kTYqbSgWTsb1l9QUOWo+SMDj48hFdNb2MkQcaK+xGtTOZIjQx/U/RR5rHLzGfsyAboGBNUIFFtoJdwq0yMm474N3BWVKi6Sb2X388/xq45V/a80VWO9ootv4y2O7EcGfg+twQTmEYucUjf6bxejonVJsTO2I+mbGAFB991uy9NWgUWe7PmQJ77ZcwRizh8c8xR7YQkQFRcmmeRwM/0JLhJEoBIXJpF4jL0M6cfXgnZ+Dsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7525.namprd11.prod.outlook.com (2603:10b6:806:31a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 00:59:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 00:59:49 +0000
Date:   Tue, 3 Oct 2023 17:59:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <651cb9024ad66_ae7e72945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
 <20231002111046.00000f9e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231002111046.00000f9e@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0218.namprd04.prod.outlook.com
 (2603:10b6:303:87::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de08ef5-d723-4ef9-47a0-08dbc47535cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCmaNEbLIQKHwSdTqZ+h+7EXdXmyHyZRHdJPomkD6ng2H2FBTWRhmy+Ji9wSJ8uHNZZXI9jlKzS2In1bOWq2oIo/p/JWgATnUEnLSTzyqoLHp+oO3kdi6fy7Ot/Joc3x2Hjg4Fkg3xQZXVV/T34xT72Uoe2SnDxuWhSGUpK4/3P5hDPdHLEkSQM/7SPqGSFb2bN/YwBaiVLbRuY1hd3jMg4qHvxBPFV1iaXmoKP7XgGehPmxhxKJcfTYvriiLUKF8B9XZvNhyQIHJ+WJKa7KCvMKfTHGUtAOji/5tfzQTJpWxRSqoSlSfetLwhcqGXTXlkvyfgiAIhDNNvlhAgSNLKOVKm0YPkRARlCQurFT8KX7NPKWr8bIf5Dkyr/Qwb5JoYxG8ePo2fusbaOi/9bcqi2RUJEqU38jcPDUx0SQUskAfKp7ZMEzBcm484SUqOKWYHdAgNanY2cUv2dsNyakAi7OjOiVHg2iFQwLavnMh5x9yS3TVxotO3K9UlEHE/vQ22hYG/HV6mLTD8Z0OLKkgqGR6qF/IOVJfMSM1N5kbkE9Xuy/ZpFBPnvWwbzIwPob
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(110136005)(66946007)(2906002)(26005)(4326008)(8676002)(5660300002)(54906003)(41300700001)(66476007)(8936002)(66556008)(6486002)(9686003)(478600001)(6666004)(6506007)(6512007)(316002)(107886003)(83380400001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcwH33/stEMGIie9ZglTS/rhuZNiLWiiRYam5kUAdLO3FAHdY+oZ8WWM+ixg?=
 =?us-ascii?Q?1DszNbuMdROBv2WuculRWms/B/zGBE9SLoKUOyDk2wT29dVw/WUrhf01bMOy?=
 =?us-ascii?Q?QU8sBuZsTxh4BZCPVkTzwT7X4Ju7pxd/Qpg9d3eGqI30d6+mt2Y12mk+IhZu?=
 =?us-ascii?Q?9vUn40DZ0hWpzUVx6w51IqsrrNuc1t1y7jQpdKVpAjA/qXzogPGImCPag08e?=
 =?us-ascii?Q?obyWqyfGx6ybHIlB5qGS3l7Xhu9ez1YwDh3kz+QOi4CiVdHzYJ9GumhwofKF?=
 =?us-ascii?Q?pNfOHwyJUBr+InrSVsZQuA+DG++VqnEMJM2nZEAm7D3Tkim09/gJ88jnhkkF?=
 =?us-ascii?Q?hTiX6NSTpfsaMor0G9SKWsi6sW+S/i+7R7i8Jb27pIFWRpb1bpNnEPh2Zsw9?=
 =?us-ascii?Q?R1d9JVfJUeEdg9z15yFgdwI61/cTEGsdkjrXBGDxiNaeM3pEq3QonPeosxHr?=
 =?us-ascii?Q?uccasy7jbnC/xX4XHRB3crPF1qF52A/ASth6uCcVWR232qC4j5kzWH1Qzt8R?=
 =?us-ascii?Q?k5u2J9m9N6WHhZ6jDtwyaOh/TzjB+wUmzGd3brwcMJ5bH2JEqNwbVvV+tqek?=
 =?us-ascii?Q?VwrChQu6r7IR5ZwUVdVkpV0x4k9oWhfm6sOq3a+YdHfXrX6JHcfhGKwkc3uO?=
 =?us-ascii?Q?jBDUMOX7LKcaGV09x3/EzyLhOeEH9iKnJUgnmJsCmSdMR3p05a8y7ZiFlQJ7?=
 =?us-ascii?Q?t5D/XFZrc33+4x7i5tnmK9tdV16V1kF35qLWu7vGG2LyykwTsdbkF6giUHJM?=
 =?us-ascii?Q?6lCyevqgGHkTySgJ82CVIqlEEyZ2Zk0PZIGmeBIWFLouM/DhwtKq3DSvW+Yc?=
 =?us-ascii?Q?+AZvrq2wz6tTEhY2TO0sahCd0ql14yKlR1Yb/lsZAIcpKYz5fEQEBMJKWsnY?=
 =?us-ascii?Q?nKZ3h0f/5u0HnaT/a6XnT55hQOyxT5XHUuksRYNYSUYCkZb6+cvilTDZBCW2?=
 =?us-ascii?Q?lcL6AmEcSK9RALCTiWJ/QIU9Ix/MeT9bJ20lUFkBt0spJexCAez18DNbgn0V?=
 =?us-ascii?Q?hhyvn8321jdUqz5EDOa/eNF0GwoSv/oGWwg1Bzn6re7ZQ01qMpCySGnLJrcP?=
 =?us-ascii?Q?F5V8PWCUPDOMrXd2FC9oPFCDX0nnci4BLGKc5K1L7bd5kZDnW4eb6kZaWg1L?=
 =?us-ascii?Q?mUUtEBBT6MiRYNDcqeseaQbwaeHy52Us0wso0PfUoHwcxbE/L9YdyR/oIdRq?=
 =?us-ascii?Q?w6k8nkzveQRrUNoZGozcYOLrI0O8vIjvwJG5GD6mqBx86gCvQy1YCNuE+8qL?=
 =?us-ascii?Q?4jDKAmFsayjlv5n384Dzy1lkRVHRByACLr2lTEjKFFcjkAvSM2pBs4G+CyTg?=
 =?us-ascii?Q?L0f12L8cXMk9HKt19PfspRU9EZ0qGS74k05c7UBNrH4pV1H6D3KSs0NQ9aZq?=
 =?us-ascii?Q?q7yG7ZrBDp3jO4omqvoAdnNnhFe/FRP7QShRYunfrrXlBsVR1wnde/zC1sIa?=
 =?us-ascii?Q?LmnD57uHss05rf4XqkNXnX0GlXHolWEwKtD5/RKzopeAgkjlnl1U5A/iY0Tv?=
 =?us-ascii?Q?sSK3o2tJldDoV7YumJae/+tymCm6QfPr+quGyZwY9/YGtGyWMhCyo9f3lA50?=
 =?us-ascii?Q?kx3QJlvAIJ7Uk8Ygnyexhneb/c8RpHkcYtlrIeG+lszfWsWyMkrBMS19AyxY?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de08ef5-d723-4ef9-47a0-08dbc47535cd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:59:49.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpZpw+ZRFgj1MInM7jtV0wH2VQ7eNzhBhZVbfrH6zBAjlIhfFsvvaURs8rfxqSo2/mVRmJisszMnkS+lhshSLnWRRzALzg5dLEMQ169E530=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7525
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 29 Sep 2023 16:09:44 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Fix a race condition between the mailbox-background command interrupt
> > firing and the security-state sysfs attribute being removed.
> > 
> > The race is difficult to see due to the awkward placement of the
> > sanitize-notifier setup code and the multiple places the teardown calls
> > are made, cxl_memdev_security_init() and cxl_memdev_security_shutdown().
> > 
> > Unify setup in one place, cxl_sanitize_setup_notifier(). Arrange for
> > the paired cxl_sanitize_teardown_notifier() to safely quiet the notifier
> > and let the cxl_memdev + irq be unregistered later in the flow.
> > 
> > This fix is also needed as a preparation fix for a memdev unregistration
> > crash.
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> One trivial question inline about which parameter to pass in from the
> many many interlocking state structures...
> 
> If you do make the suggested change, it's just complex enough I want another
> look so I'm not giving a tag for now.
> 
> > ---
> >  drivers/cxl/core/memdev.c |   42 ----------------------------------------
> >  drivers/cxl/pci.c         |   47 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 2a7a07f6d165..a950091e5640 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -556,20 +556,11 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
> >  
> > -static void cxl_memdev_security_shutdown(struct device *dev)
> > -{
> > -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > -
> > -	cancel_delayed_work_sync(&mds->security.poll_dwork);
> > -}
> > -
> >  static void cxl_memdev_shutdown(struct device *dev)
> >  {
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  
> >  	down_write(&cxl_memdev_rwsem);
> > -	cxl_memdev_security_shutdown(dev);
> >  	cxlmd->cxlds = NULL;
> >  	up_write(&cxl_memdev_rwsem);
> >  }
> > @@ -1001,35 +992,6 @@ static const struct file_operations cxl_memdev_fops = {
> >  	.llseek = noop_llseek,
> >  };
> >  
> > -static void put_sanitize(void *data)
> > -{
> > -	struct cxl_memdev_state *mds = data;
> > -
> > -	sysfs_put(mds->security.sanitize_node);
> > -}
> > -
> > -static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> > -{
> > -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > -	struct device *dev = &cxlmd->dev;
> > -	struct kernfs_node *sec;
> > -
> > -	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> > -	if (!sec) {
> > -		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
> > -		return -ENODEV;
> > -	}
> > -	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
> > -	sysfs_put(sec);
> > -	if (!mds->security.sanitize_node) {
> > -		dev_err(dev, "sysfs_get_dirent 'state' failed\n");
> > -		return -ENODEV;
> > -	}
> > -
> > -	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> > - }
> > -
> >  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> >  {
> >  	struct cxl_memdev *cxlmd;
> > @@ -1058,10 +1020,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> >  	if (rc)
> >  		goto err;
> >  
> > -	rc = cxl_memdev_security_init(cxlmd);
> > -	if (rc)
> > -		goto err;
> > -
> >  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
> >  	if (rc)
> >  		return ERR_PTR(rc);
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index ac4e434b0806..b0023e479315 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -165,6 +165,49 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
> >  	mutex_unlock(&mds->mbox_mutex);
> >  }
> >  
> > +static void cxl_sanitize_teardown_notifier(void *data)
> > +{
> > +	struct cxl_memdev_state *mds = data;
> > +	struct kernfs_node *state;
> > +
> > +	/*
> > +	 * Prevent new irq triggered invocations of the workqueue and
> > +	 * flush inflight invocations.
> > +	 */
> > +	mutex_lock(&mds->mbox_mutex);
> > +	state = mds->security.sanitize_node;
> > +	mds->security.sanitize_node = NULL;
> > +	mutex_unlock(&mds->mbox_mutex);
> > +
> > +	cancel_delayed_work_sync(&mds->security.poll_dwork);
> > +	sysfs_put(state);
> > +}
> > +
> > +static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
> > +{
> 
> Almost everything in cxl_pci_probe() passes in the mds.
> Why not do the same here?

Because this one really is built on top of a stack of things and needs
the 'device' because it is tying the device's sysfs attributes to the
completion notifications of the background workqueue.

I mentioned this in the cover, but failed to mention it again in this
changelog:

"The special wrinkle of the sanitize notifier is that it interacts with
interrupts, which are enabled early in the flow, and it interacts with
memdev sysfs which is not initialized until late in the flow."

There are no sysfs attributes reachable from an @mds.
