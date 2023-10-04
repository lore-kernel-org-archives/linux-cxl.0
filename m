Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD9FE8FDBF
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 00:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjJDA4j (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Oct 2023 20:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJDA4i (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Oct 2023 20:56:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CDBB
        for <linux-cxl@vger.kernel.org>; Tue,  3 Oct 2023 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696380994; x=1727916994;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1+DMOzcSwFkITJ3315XgvzHN/we/JYJ0X+ON37zMvTk=;
  b=U8/kAGj7e2/7JkB9h0suI9dvPtyNWMfFnAfTBsJJ7AEqdnPoofYdZmgB
   KQC79Bptj9GEeJJe4N7IGgyz5XyxWb4S2igfVqtLMT8U+G2O3UjQFMJrc
   e5NYH3j6EAtwo1H/ULasLpOfncSsNdK/gueXr3bYIdFHOI0N8jxTHLkbE
   zsRz8meINljFxw+O7T8IvnnWU0AFIAQPvnwF6VseZDJBna2bfqitDyDry
   Y7uWkE9mqcfxs6Tnu8LP1oLwvMtrZXnEFHGGIorMqPmO3hkEwLDxH0gpc
   OMG5wG+m5+tCIuVHqSjUPklNnBsCh1Lxv2rrna/flywsCCpKYbgadpt03
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449510829"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="449510829"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 17:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="816905289"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="816905289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 17:56:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 17:56:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 17:56:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 17:56:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 17:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6Y9khk03JM8NGkFJDVmsHAlS6lBHpktTd/3GRCSt/ZdeJmZ2dM02C3wDTjbjf5LpX32rP/SOwdVgRZxccQfXrJxmWzBNoiEyLRL9jVcbjYPpHS3qp1PEaVPAQzn2R+An3GF/M6ACud4aDBhLaTygCHsTcodZ6TV1mo26v2XAGnFsAZT72r8gkxaHhaJKCZOFZCR/z6672B0wqNfJGksYaTCNo4MdH95ueGTpsr5RWzRjAncWNYPshif7F+MjGe4fQpScC0HoTUoEmpvNRVYCM9c9rU7qK8LnCPXjcg8aVyFGtPTuj06Ov4SK2WgvrlD4sEmKvC0IY9Vj9QDr4ck0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpPCOOePzylJCC4kj+JMjYUSVCkRAutiuvDkVea/xps=;
 b=iTej5xjmEyS2mgDaiCLCiECcsT1WGnKL22XbFJnWyJdMR/tnamWytBs7zqQ5wM3C3GcJ8tTvbCNoZUnxFicIo2+C1Di3VP4HMRbX4CeYP8EAIaXCC+GsdAzyyX+JYyv4FM7+ewyR4T85CD34VINb8lDl/6hAwc/k5sKcx9EJtqC1C5XTz5vq75VLNlSGtuqe64ETMQWhNK/ns/9gOJD+8PlEPoWp8Pp9v113k5zmTmawX9lar4oUPKychvEIaK7D9wqJheFk7zpjBgS+vcSc7qO07J0gPnLuVePEIQR3AXkuOGEYBETB++HOv6USfhaahYAx/RDNdn2mB9no0v0K8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7525.namprd11.prod.outlook.com (2603:10b6:806:31a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 00:55:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 00:55:47 +0000
Date:   Tue, 3 Oct 2023 17:55:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <651cb81049601_ae7e729466@dwillia2-xfh.jf.intel.com.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
 <20231002110225.00000e61@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231002110225.00000e61@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:303:84::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9673c8-97b9-474a-7b72-08dbc474a551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nV14mqCcgJfbXaM8bn2w+2bCyyJvj45xPkfZXgd4VFZ/rR3zsSJOv2skZG56XVGXZ/BGjKiD+US8/rKLqGeDGgYELsSLD7XAyHNY+nkzKNwZBYdQZYdCXJxiOQe/+sIGrLFYZz/RLVBNdhYV30NsqmI7lZ54434le1MnWwL9P6+r2aQmYon2mIRTyqoy5869rk/vBBcFBUTuc4IK+9DA6+koG3iNEaoexcvaE33s0Lwm5sWbatgm8GTF9etPQWPKaEbYI2IM+fu6q3xI3Deii1ZpZBJNPVIy4d6HgkS+sb9fS0osRUrhiqxVNAfXOo0Xx0XegaGeyYhjOeaTiMMfnQX3CEHGGc44MSZbJB/e2IbacCYDhVfJCdwGzOdjGsZJncAJQZjFICa86hx8B7UtHqu9KPJcL9aLErcOQKFB2VlbeSKdgIaw+SxA0e/qWkVf9sNgeRm3tINAbBNWvAmy2J3iWtxgJZAM6T4NIiDeUV6UdeJORVGN5KzRmtyRIJjGVYijDP/4xR6yDwnRnPBHFXJMUE7c10U5fWY8SBJTnL9sZo2sT2kBKnFcPL4zgyjL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(110136005)(66946007)(2906002)(26005)(4326008)(8676002)(5660300002)(41300700001)(66476007)(8936002)(66556008)(6486002)(9686003)(478600001)(6666004)(6506007)(6512007)(316002)(107886003)(83380400001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0hqnXK5NbbaH3Kswt6ws3/YC/V42UBIy6mGL0gcJbmgY1P6iHRmMtsvOhoT?=
 =?us-ascii?Q?QHRUC/nuCGi0yRfccVEkl7aElGxNIUZdLI0+lfFqBJ3LyJxu09su3HtuqU3N?=
 =?us-ascii?Q?a34Oi3zq/wGZGPc31CVyU15BqMJqkr6GRqKzATRHN3geaQ+eB9a00WaLvBhA?=
 =?us-ascii?Q?bw2wgccmKt6/V6ycqdzR1s5RmI5zt7sqkdmUemkTnb9H5VfsldoYIy/+8aIa?=
 =?us-ascii?Q?wv3h+PiMrCG5XRntB3YFKbBlDTIAZ++zupwYMprf6CueTDWR+CRtJ/OnIqQG?=
 =?us-ascii?Q?qMGfrSwavvoEvm+ivjWAXl4rHUyovBIbm1UgETs1SgRBsJOLxPYVoyOO16ND?=
 =?us-ascii?Q?pLQGlWw9lVkJshm3nmxO59PpolkYzZNvbM0nviWtj6yPhax8IbTzroehOeFa?=
 =?us-ascii?Q?Y4sY8voF19PeLXck4/XT2bGuv6SYGGiMlU2iSY9WYOHTNPZ6EMFqaRRrUJ8s?=
 =?us-ascii?Q?NW/bbCWrWvnGIFNI3lmYea73p2vmCb5xiPWyvE45LjfWkqSXJmC8rpVt0Uvg?=
 =?us-ascii?Q?Av6ddgAq5CbRrtrGFF04QUwyzwVOGWX3gkofVBQ4r2QyqXbFs+CXLRZRL0m8?=
 =?us-ascii?Q?9bznzmjViKM5NLMvYGRD9WWwk16NvdK+GWMn1JxbdqLenYSEZBJ/cjg/aZXC?=
 =?us-ascii?Q?/LjJ9qBYwO4Q/5iHSCG28VQqZsKLSqqzkvhJvuF9Xfr8JEOHUn2H1xd/bsoS?=
 =?us-ascii?Q?AYp0fD01Y4LgxQ5o8ouvBec/KrO/Yja9Y2Atuawr8HzD/yOsf5lH73W48NSX?=
 =?us-ascii?Q?tunCv5V2YsreLq0IdBW4pSOQ0XRvkw12CAvt9KNM3/Sjl7E4JXDUyYYpA8BE?=
 =?us-ascii?Q?opBotnKypK2k34uTiUHSdxR0rNj63cxMYpVS24MaHuyc6yRnBGCQtli4xtFk?=
 =?us-ascii?Q?zvRoQQRjOS01pdKR0vdEWVlJNgWDN0l5MZU/NytWSOUlET4P737XdfjgNn/2?=
 =?us-ascii?Q?Wmvt8rEYVqiA+ucB0jLov1J7qTxUhk/eib4Lm7AisDtZKZ7kayBWSjYcNNue?=
 =?us-ascii?Q?vHAHmHLvcM2HzzmdWJ/cB0mYTcIhJdpF8GbNf9mf4U0pEX1r+GP0fonsqdwb?=
 =?us-ascii?Q?KFEdjjpSjhqjLsVmhRxbzUyqQzLeaMamud/tTKkdBQeUmVINtgEMUyQ1Exrd?=
 =?us-ascii?Q?TdhNrE8X8oe+EG2UljCezxhOVCNu13e56m0xC/jIyXM1lqXCWYASNjijdfo7?=
 =?us-ascii?Q?LCDKY5YA7XbJMJ3btmzvUjGzodbAZmEUN8dwU5aVwJ5aB14LVn83fkbgnTcv?=
 =?us-ascii?Q?h/wHGKyWK1ZLlocAqXM6HssLqvVn3XUbaxvX0tZp2FyqFFLaaLW/1tD4Okw5?=
 =?us-ascii?Q?NHM4GjC5Zy6otoldRkuzKAX+57531reFSKjougoWdZE6B+b/l5xHbKOCopxq?=
 =?us-ascii?Q?258WXnv2CkQw7Omggu8vZIZ/poqb2Vh8ui+ZIJxleWGMyvPMLIySX7duZQMs?=
 =?us-ascii?Q?Es3k1Ry0VWo5IT6J390hbvJ07nReSuObbZ/WvJoLk8F6/PM6ow9pqtut6dyJ?=
 =?us-ascii?Q?G4g+qwZuD9Zj75EDX2u8duZUfrL407ot7FRILfCEUK/lLvSrgI+sPPOVy1yH?=
 =?us-ascii?Q?2A94FFX9AMWC0qzNjWbTkH+zV6KwEqmK7YdZirH/IxtRWKgytuUEpDYgn3BF?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9673c8-97b9-474a-7b72-08dbc474a551
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:55:47.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTjQECArCQyDSX6lrYcJ6CF7Ti4wr9c9nsULsoYB0/pPZSzIU9mYxoQ3XJn9INXHhM6qUoX9Ka8QOOXmXt/6Fy6REsWXgLs2Ch4EgpqVnDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7525
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 29 Sep 2023 16:09:39 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for fixing the init/teardown of the 'sanitize' workqueue
> > and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
> > to be the single location where the sysfs attribute is notified. With
> > that change there is no distinction between polled mode and interrupt
> > mode. All the interrupt does is accelerate the polling interval.
> > 
> > The change to check for "mds->security.sanitize_node" under the lock is
> > there to ensure that the interrupt, the work routine and the
> > setup/teardown code can all have a consistent view of the registered
> > notifier and the workqueue state. I.e. the expectation is that the
> > interrupt is live past the point that the sanitize sysfs attribute is
> > published, and it may race teardown, so it must be consulted under a
> > lock.
> > 
> > Lastly, some opportunistic replacements of
> > "queue_delayed_work(system_wq, ...)", which is just open coded
> > schedule_delayed_work(), are included.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> One trivial comment inline, otherwise looks fine to me
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/memdev.c |    3 +-
> >  drivers/cxl/cxlmem.h      |    2 --
> >  drivers/cxl/pci.c         |   60 +++++++++++++++++++--------------------------
> >  3 files changed, 26 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 14b547c07f54..2a7a07f6d165 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -561,8 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> >  
> > -	if (mds->security.poll)
> > -		cancel_delayed_work_sync(&mds->security.poll_dwork);
> > +	cancel_delayed_work_sync(&mds->security.poll_dwork);
> >  }
> >  
> >  static void cxl_memdev_shutdown(struct device *dev)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 706f8a6d1ef4..55f00ad17a77 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -360,7 +360,6 @@ struct cxl_fw_state {
> >   *
> >   * @state: state of last security operation
> >   * @enabled_cmds: All security commands enabled in the CEL
> > - * @poll: polling for sanitization is enabled, device has no mbox irq support
> >   * @poll_tmo_secs: polling timeout
> >   * @poll_dwork: polling work item
> >   * @sanitize_node: sanitation sysfs file to notify
> > @@ -368,7 +367,6 @@ struct cxl_fw_state {
> >  struct cxl_security_state {
> >  	unsigned long state;
> >  	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
> > -	bool poll;
> >  	int poll_tmo_secs;
> >  	struct delayed_work poll_dwork;
> >  	struct kernfs_node *sanitize_node;
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index aa1b3dd9e64c..ac4e434b0806 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -128,10 +128,10 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> >  	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> >  	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> >  	if (opcode == CXL_MBOX_OP_SANITIZE) {
> > +		mutex_lock(&mds->mbox_mutex);
> >  		if (mds->security.sanitize_node)
> > -			sysfs_notify_dirent(mds->security.sanitize_node);
> > -
> > -		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
> > +			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
> > +		mutex_unlock(&mds->mbox_mutex);
> >  	} else {
> >  		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> >  		rcuwait_wake_up(&mds->mbox_wait);
> > @@ -160,8 +160,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
> >  		int timeout = mds->security.poll_tmo_secs + 10;
> >  
> >  		mds->security.poll_tmo_secs = min(15 * 60, timeout);
> > -		queue_delayed_work(system_wq, &mds->security.poll_dwork,
> > -				   timeout * HZ);
> > +		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
> >  	}
> >  	mutex_unlock(&mds->mbox_mutex);
> >  }
> > @@ -293,15 +292,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
> >  		 * and allow userspace to poll(2) for completion.
> >  		 */
> >  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> > -			if (mds->security.poll) {
> > -				/* give first timeout a second */
> > -				timeout = 1;
> > -				mds->security.poll_tmo_secs = timeout;
> > -				queue_delayed_work(system_wq,
> > -						   &mds->security.poll_dwork,
> > -						   timeout * HZ);
> > -			}
> > -
> > +			/* give first timeout a second */
> > +			timeout = 1;
> > +			mds->security.poll_tmo_secs = timeout;
> > +			schedule_delayed_work(&mds->security.poll_dwork,
> > +					      timeout * HZ);
> >  			dev_dbg(dev, "Sanitization operation started\n");
> >  			goto success;
> >  		}
> > @@ -384,7 +379,9 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
> >  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> >  	struct device *dev = cxlds->dev;
> >  	unsigned long timeout;
> > +	int irq, msgnum;
> >  	u64 md_status;
> > +	u32 ctrl;
> >  
> >  	timeout = jiffies + mbox_ready_timeout * HZ;
> >  	do {
> > @@ -432,33 +429,26 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
> >  	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
> >  
> >  	rcuwait_init(&mds->mbox_wait);
> > +	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
> >  
> > -	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> > -		u32 ctrl;
> > -		int irq, msgnum;
> > -		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> > -
> > -		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> > -		irq = pci_irq_vector(pdev, msgnum);
> > -		if (irq < 0)
> > -			goto mbox_poll;
> > -
> > -		if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
> > -			goto mbox_poll;
> > +	/* background command interrupts are optional */
> > +	if ((cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) == 0)
> 
> Nit, but it's a boolean flag, so to me
> 	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
> 
> feels slightly better.
> 
> There are instances of this done with !() elsewhere in the file,
> so not obviously a case of wanting to match local style.

Ok.
