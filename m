Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D4EC7EE23
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 18:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEVSTb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEVSTa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 14:19:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4302E0
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684779568; x=1716315568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ajB76i48TcdYXAqsFLUUjyFBRtIECV9IS59p8i24cVo=;
  b=E8T6iYRTOPnt8tJ21Q0qhJIJ+PWVO1gvJUvkKhqmjMi31lyiS1vYjFpC
   kkCgP5HJdHOH8mbOsm+xBzHcDVCKV1KGNde4H6GIgGjdH8rkB/emgoLSS
   R2uSOfAiwjFEedcWTqk85dTXH5pbasKKlGu0LrR8ejV9pd7C1dPu7is5X
   6zIjysJlmT/Tg6EhUNDeltcmnsyFItM7Z1FXrUMp8DmNIlwmqtF+0ajZ1
   iREm4/Y0F83n75lRIC0Z0MEvAeDADn/CAQW83YDktcXs6y6HZcOTKwS5L
   jgYP6vYR3a15KcZhRcgmSPlpIVjWZrZXRSK257AM5r4mI8HYCZLkEmBwZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="332614297"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="332614297"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="1033704639"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="1033704639"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 22 May 2023 11:19:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 11:19:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 11:19:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 11:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AktlQqtqT578lthP05Y8SOaIkAsL9QIDWrnYx8q0ksbTYMaHM1I+ypmzxiR/Y9CfoqJyR4UEzAoYiC9o5DQp2eIRJBUwM9Akkn1rvxIpxworLS1qtme9+3yL/Q/kixdS3OQ6POKepbHeN+yKnX87JWJwwNUSxktJ4cbIPTf6VdA+Bqidh727mpd8uORBwNm2EtcnW8Ykke4PStj1pNf6/kOsdhK8mmDOXTqTnULKguIir6EKqIUNpjmMxAzWy0wkpb8g9nsTyBEjBuIQXPWZLqzc3KogpDjiPHRwPpd6t5oyr2xOaNuqyGHeVb5v0UGLZyCekETUZDq+8aSlp7lMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7exeuzyk6bdnmuv6evvYJBNeqQ2uLxbb9XAEXC4llrw=;
 b=D8NeBEa3CtMwmkofpe1+GsTxtSuJt0OfxhnYKqN86PT8kb44T1Wc+rc70JK1ycnED1eCOK2WUwCgNVuqzFXSd+taTCGceTGd9qVYL5cAU5o1AyXzOtrum+bwKVlcMxCwytYUS5ER6wvhVz9xvQn9Q7Tpq+1YhYvkEREHRkvm1FNnjEBpunu3aNh3dul4+jzknzIwpODRBOdBZ/acILS/4C70Nyar73EmjXaWYJRzAV2vK1VLMP/IIuRDch2Mv2kvEunA4loIXikIEVDuOFyObhhq56vRoNvlT/+WOPWqxpK88/Siu6ey/RU2iWqt3T5tiGkI9qBvNrKKTa3opqkBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6761.namprd11.prod.outlook.com (2603:10b6:303:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 18:19:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 18:19:16 +0000
Date:   Mon, 22 May 2023 11:19:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <646bb221db164_33fb3294b3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
 <64jusopypczmfmkeg5ulzw6gwbfv4mdnk2jilmja7iyr5dsukc@vkpwdjsjsbk5>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64jusopypczmfmkeg5ulzw6gwbfv4mdnk2jilmja7iyr5dsukc@vkpwdjsjsbk5>
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: efda6719-192a-4af8-d160-08db5af10d61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BE6eppN4NI9IPSKyPds2SG9cLs+RDA+cHMIEcJWBWHcwa29WTszq4aYOD740SUN9LwLAtc7eA7wq53fjG62oNraqQNOIvTJoLNwclvhPReBeQkufxB5nM17K9JQ35WM5CsVlhXXNYwjt9FRhwvjOJHXSV+nONiMnJ+d2wVaF2lu6wWcSmVc4qSrYJ8OE45ewDlyNKZc4BB/p+levgBewi/nzWAkelpgo5u986DrQUaz4BsCWuwY+BDJf+dyOELu+ZR/yEGKMYg7qjRLB/1xj1BuKpP3Im+6T7LYQ2MJ0OoK/YZE/kR/929l3DRlawZrk1zMAEdB65fyZa0I2iMrNXHd/c235dxflWCwHzs/s4Q+Vvftzdd7gjfDR60G85WkQ1xWnExPXYIoctmdbLrIVvZ4p5nGdY0PYGOj32I+XYr/PosPIrccjI0Wr+oMqxH6VyaToF8g8TXdLRwyy8iC7JeleAFj2zqQeR7Tv+sH7lk11fmdGBmzeBgnXXldGB3xqEoFqifH4A9NIbtutAst7CUwn5SeIM2WbTMagYxNodLY6X/mIdafMpCfC3g0L0Fed
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(8936002)(8676002)(5660300002)(83380400001)(186003)(6506007)(9686003)(6512007)(86362001)(26005)(38100700002)(82960400001)(41300700001)(6666004)(6486002)(66476007)(66946007)(66556008)(316002)(4326008)(478600001)(110136005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S7TtBpOjkPivnBBuld/pX2W+O/sWOUz7StMvkV16qbPom5NnkyK/5dyBpVxr?=
 =?us-ascii?Q?BpD6PK05weweJc8iOHhx/GS02qqclBDBuBfZsvjqrk/HDq8ZfBCdPhqvdBoC?=
 =?us-ascii?Q?rcowzZirOTP3mrEgp8UENZLxAFUyPxIOPt6+hh/dSOUG08tKQT0WB09PknyU?=
 =?us-ascii?Q?akVKg3l+HEJWfZ7kcM2sBz965xrG4mRfPIaObd7sCEPfdNoTPoOr8HTsc/oA?=
 =?us-ascii?Q?5+TOvf9usB3hayDJSbW9PQKcloW+AZzPneHCiZS2KPMBZVez9/AW0lBie0/n?=
 =?us-ascii?Q?lGCMwWbof9kWf4A2kKfrXSWg0dK04hRtPcI7N83UdI+Yg9mEtCBMHwl16XPZ?=
 =?us-ascii?Q?SCtnfIHca50DUjY09NpznlAYVkNuBciUjNG4c4aArKHIc9s5hSkj6RK3MPnD?=
 =?us-ascii?Q?YJUSe8WBKYoqfsA6KSZK2g6cdnCGTP5gwkviZZVT5CuRFbwvknFmrlJ4qk7g?=
 =?us-ascii?Q?eDtepa7h4fD9RY8rbnCQraR1sSCrnDkMY6HeaKeTSM7aQvHNzkTyLpcagwDp?=
 =?us-ascii?Q?2ICplnqW55Qmfsm+EqynJhqu044sKH3/mq/mVT+5v4nzmBp6SO4rygb7rSxp?=
 =?us-ascii?Q?/e7OuKw5IVqt4A/9Do8r3Nfn8CIFwbiQvHAHLsN0ryVdpWJOrlf624AlFmiC?=
 =?us-ascii?Q?MS9B4jgI6pAKOoJD2MVgi1ugk5glaV0mFEzt+0hYD8dukZKWGPdgGcnjI9KV?=
 =?us-ascii?Q?C7nz81xEnib1lQ7RkDCxxIJiCBauAGJ14/oeb6G3O9nisrAn8l+RT0dBRlyr?=
 =?us-ascii?Q?/tluMm0GNEbyZkfzJmOrWXJrNHqHEruPxvQpqpdy6OBiuHWP8+dcN+IwgjZ1?=
 =?us-ascii?Q?srsKDhAL0vqJ8qiHmIVMbFrq5TnfgrSmH/rVFL3mUECKzn89Af796oYIGI3j?=
 =?us-ascii?Q?hhLRCn+45Zze+dlwWy2C3FtWBGun32J9Ls/bGQ8+qYnwUab7oBbFXsjMcLcR?=
 =?us-ascii?Q?X8KuQkBy2nO+umzAe5Dw7NJQ+MC78oMKbn0kIpq/4qvHMGWohdd3y0tNIOWl?=
 =?us-ascii?Q?JakL3U3UJGGFFueMP97OwVimH9zgM0b+CLpAtft73ZqRVwK4oiUQaZdWKlm1?=
 =?us-ascii?Q?O+kC7kwsTMm4VheE+/kz1sF8tL+bjay4caKumfQiv2pa9hZYBQoXq+PnP5Bo?=
 =?us-ascii?Q?AW36rGwmzTUzPrqCv2OCVXGw6D/cGs/1wTugKZpyvAdd59g7czo/s+5raTg+?=
 =?us-ascii?Q?5JN3ldIqqvdZ6lBSw7HxbPK5NkTsDhh0vvDpZTLUFi5Kd7EoU1smZEDgH37g?=
 =?us-ascii?Q?mZ6VuTf7NeR3co8gfcpq9N0vklNdFhL8Gao9Xg86N32gDVQ4YAowqCOeHZiD?=
 =?us-ascii?Q?9ZfKTrVBpmBg91FLm0yhepjkkk0M3+X2EJwM4UoK4ZH3zpEeWm0nuM7gqbwp?=
 =?us-ascii?Q?5varHVDsl8BvrIj6Z4zbxWd3Sc9aJGyODCQvOhze4jWBf5g5hMhjC5zY8gss?=
 =?us-ascii?Q?FYrcd9YXM0yZZCEoQ9TmNI+Z894a5J6CNgPHuMWZZ12v4kfKFokZybKCe95/?=
 =?us-ascii?Q?fSIa3shtbirg/6AZZWJ9DNvb1G8AjcSsbdZ3JUNQ/wgcsaYyVpOXCFcSgiqB?=
 =?us-ascii?Q?rKK9vP4q7O19tOVKfM+2yi36LqQ43IQ5vg3w7oqjUv8jJObQjyyqoqeTT3Y1?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efda6719-192a-4af8-d160-08db5af10d61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 18:19:16.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmVnz3FOr6u3WKUteeNPErGmCJKUOBXjrlrwXGRVRttDZLXcCNfjyPE5TBrVAM9Q1XOeDww+7tHbNH6VDK4tDPz4xhC7hAkfyFa8iHUUCGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6761
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Fri, 19 May 2023, Dan Williams wrote:
> 
> >> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> >> +{
> >> +	struct cxl_dev_state *cxlds = id;
> >> +
> >> +	/* spurious or raced with hw? */
> >> +	if (unlikely(!cxl_mbox_background_complete(cxlds))) {
> >
> >I expect this will fire all the time. While the specification allows for
> >a vector per-reason there's nothing stopping an implementation from
> >using one vector for all reasons. There's little incentive for spending
> >silicon gates on exclusive vectors since none of the CXL interrupts
> >service software fast paths.
> 
> fyi I have removed the warn below entirely. Handler is now simply:
> 
> 	if (cxl_mbox_background_complete())
> 		wake_up();
> 	return IRQ_HANDLED;
> 
> >
> >> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> >> +
> >> +		dev_warn(&pdev->dev,
> >> +			 "Mailbox background operation IRQ but incomplete\n");
> >> +		goto done;
> >> +	}
> >> +
> >> +	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> >> +	rcuwait_wake_up(&cxlds->mbox_wait);
> >> +done:
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >>   /**
> >>    * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
> >>    * @cxlds: The device state to communicate with.
> >> @@ -177,6 +205,57 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >>	mbox_cmd->return_code =
> >>		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> >>
> >> +	/*
> >> +	 * Handle the background command in a synchronous manner.
> >> +	 *
> >> +	 * All other mailbox commands will serialize/queue on the mbox_mutex,
> >> +	 * which we currently hold. Furthermore this also guarantees that
> >> +	 * cxl_mbox_background_complete() checks are safe amongst each other,
> >> +	 * in that no new bg operation can occur in between.
> >> +	 *
> >> +	 * Background operations are timesliced in accordance with the nature
> >> +	 * of the command. In the event of timeout, the mailbox state is
> >> +	 * indeterminate until the next successful command submission and the
> >> +	 * driver can get back in sync with the hardware state.
> >> +	 */
> >> +	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> >> +		long ret;
> >> +		u64 bg_status_reg;
> >> +		int i, timeout = mbox_cmd->poll_interval;
> >> +
> >> +		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> >> +			mbox_cmd->opcode);
> >> +
> >> +		for (i = 0; i < mbox_cmd->poll_count; i++) {
> >> +			ret = rcuwait_wait_event_timeout(&cxlds->mbox_wait,
> >> +					cxl_mbox_background_complete(cxlds),
> >> +					TASK_INTERRUPTIBLE,
> >> +					msecs_to_jiffies(timeout));
> >> +			if (ret > 0)
> >> +				break;
> >> +			if (ret < 0) /* interrupted by a signal */
> >
> >Have you tested this path? I am curious what happens on the next command
> >submission? As far as I can see foreground commands would not be
> >impacted but the next background submission would fail instead of wait,
> >right?
> 
> No, I haven't tested this path. My expectation here is that this would be
> similar to the timeout case in that the driver returns but the hw keeps
> processing the command. The next command, fg or bg, would be at the mercy
> of the hw doing the right thing until it's done with the canceled one.

Right, it's that "mercy" part where there needs to be documentation of
what to expect.

If someone sends SIGTERM after triggering a scan media and then
immediately resubmits it maybe the right answer is to go into another
interruptible sleep awaiting the last background state to clear out. It
just seems like returning an error leaves userspace to fend for itself
with little visibility of what it needs to do next. SIGTERM during a
background command means, "I do not care about the previous result".
Given the driver is mitigating long running background cycles that
implies that waiting before submitting the next colliding command would
not be onerous. They can always SIGTERM again if the wait gets too long.


> >Perhaps a dev_err_ratelimited() message and an EBUSY status for when
> >that happens to at least indicate, "hardware is still chewing on a
> >cancelled request".  Later we can think about whether that's recoverable
> >via a reset.
> 
> Well but reaching this path already assumes hw didn't error out the current
> command because the canceled one was still being run.
> 
> Alternatively we could also just make the sleep uninterruptible, but because
> this comes from the user triggering the bg op, I thought against it.

I don't think that would solve the problem of how to detect when the
driver is out of sync with the device and what to do to resolve that
situation. An inopportune SIGTERM is indistinguishable from getting the
polling interval wrong.

> 
> >> +				return ret;
> 
> rcuwait, unlike regular wait, returns -EINTR instead of -ERESTARTSYS. I've
> updated the return value here to the latter.
> 
> >> +		}
> >> +
> >> +		if (!cxl_mbox_background_complete(cxlds)) {
> >> +			u64 md_status =
> >> +				readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> >> +
> >> +			cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
> >> +				    "background timeout");
> >> +			return -ETIMEDOUT;
> >> +		}
> >> +
> >> +		bg_status_reg = readq(cxlds->regs.mbox +
> >> +				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> >> +		mbox_cmd->return_code =
> >> +			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> >> +				  bg_status_reg);
> >> +		dev_dbg(dev,
> >> +			"Mailbox background operation (0x%04x) completed\n",
> >> +			mbox_cmd->opcode);
> >> +	}
> >> +
> >>	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> >>		dev_dbg(dev, "Mailbox operation had an error: %s\n",
> >>			cxl_mbox_cmd_rc2str(mbox_cmd));
> >> @@ -271,6 +350,29 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> >>	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
> >>		cxlds->payload_size);
> >>
> >> +	rcuwait_init(&cxlds->mbox_wait);
> >> +	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> >> +		int irq, msgnum;
> >> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> >> +
> >> +		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> >> +		irq = pci_irq_vector(pdev, msgnum);
> >> +		if (irq < 0)
> >> +			goto mbox_poll;
> >> +
> >> +		if (devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
> >> +				     IRQF_SHARED, NULL, cxlds))
> >
> >This needs IRQF_ONESHOT and that @dev_id needs to be globally unique in
> >case @irq is shared. So I think you want to factor out a common helper
> >from cxl_event_req_irq() that this can reuse. I.e. cxl_event_req_irq()
> >already gets the flags and @dev_id right, so just create a cxl_req_irq()
> >that takes the irq as an argument and share it.
> 
> For the oneshot this was a hardirq, so I don't think this is needed, but
> regardless, I've added the following helper in a new patch which both
> events and mbox can call:

Ah, right, this was hard-irq only, I missed that.

I wouldn't be opposed to cxl_request_irq() following pci_request_irq()'s
lead and taking multiple handler arguments to skip the thread invocation
when it is not needed.

> 
> static int cxl_request_irq(struct cxl_dev_state *cxlds,
> 			  int irq, irq_handler_t handler)
> {
>         struct device *dev = cxlds->dev;
>         struct cxl_dev_id *dev_id;
> 
>         /* dev_id must be globally unique and must contain the cxlds */
>         dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
>         if (!dev_id)
> 	       return -ENOMEM;
>         dev_id->cxlds = cxlds;
> 
>         return devm_request_threaded_irq(dev, irq, NULL, handler,
> 					IRQF_SHARED | IRQF_ONESHOT, NULL,
> 					dev_id);
> }
> 
> >
> >> +			goto mbox_poll;
> >> +
> >> +		/* only enable background cmd mbox irq support */
> >> +		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
> >> +		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> >
> >Just in case some other code ever enables doorbell interrupts it would
> >be nice if this performed a read-modify-write rather than assuming it
> >can clobber that setting.
> 
> Hmm do you mean enabling/disabling dynamically?

No, grep for:

"write.*CTRL"

...and observe that all writes to control registers are doing a
read-modify-write sequence.

> Otherwise I would have
> expected this to be a one time thing which we could just OR both bits.
> Maybe this could be revisited when needed? Jonathan suggested enabling
> doorbell irqs in the future, which I plan on looking into at some point.

Sure, that code might be in another function also performing its own
read-modify-write, so my comment just asking for this to be consistent
with other control register updates in the driver.
