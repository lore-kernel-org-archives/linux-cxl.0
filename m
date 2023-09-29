Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F79DE7734B
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 23:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjI2XuB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2XuA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 19:50:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACEEF3
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 16:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696031398; x=1727567398;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U2aPrTfh5XBi4efggtcx51JF2iUAaZfaH1haBDKnEOc=;
  b=eplla7UlFxZB/LXanOyKj6C8A68mxGHa0r4iuGOZg2eN03nLFJ0SdYII
   WQB1xachIVQIcmlb19i7mU7ycmvvMaYY/iYjf9/++4StyzMkNM9WyPTuw
   s0NQXAUdqidmB8SbOJpbThIt7Np26vunz+n8TKczM+Oh1KA/i+vXCP8TA
   7wKStC9fjCEwvrbFe/6xuAVQOIddQDYU9J99Gn3LWr2kLncJ6RYQ3xTuj
   FFvxztbemFb5iZBsQu4x8OG9VfPhjXSHjxV4L+zYHuTPy/f1htCL72rk8
   JvtFB2z4ppWc+2UTIRWK9mMH5y6PVv8xAM6Hovc9eXlrbJNbfq1Hvo6hv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="385226122"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="385226122"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:49:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="820334976"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="820334976"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 16:49:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 16:49:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 16:49:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 16:49:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 16:49:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La5qlZKeyUriTo9sN/yV3OUJKF6xpWyv6nRIwlN7LDPUwvAoXipPt9c0L+h9TtAmD0RldAPO1VbiGyH0N8S5Lk95UQQOO22DnmasziZhc87Pv1FsQOHdPPt5FCn4g6zodeUur9AUnrHPOSMeUuXF37CMTNE/Ua0/J30F//nHMf8sREXrTFH5DVdFN5H6nlcVGiwmMObGjTe1zSX9gQNEE/qPtTVGHRtpEVhaLvcSYw39lLfqVWQ8YJsJjdTS8Og+uFv4Jh2loAP+82qO/2sQbg3lxDuHltPrEmgAGH+9VV9xZq0IRtnDN4S/Wdj2QHPj//y07a8B/ZWoRbAhi9JlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIeL4TZvRiWBUGOVOqbP+HvSnFT+Hjz8oh5bQ95U95s=;
 b=jTPb4Y+w7yreFQxRzCBdbRMLcIX5Sqm3kLZSUZt+5Yv0+4rzWGNOzKHSUVCGNZbW/LxOd1xEI6ME7WtTtGPL0tlaDGF7D7cu00wDWPlRsy+7hKBbjWeaOSjdNvXaWiKN/1XX8L3ScnYcR2H7S7O14nwPu/1MJ2C6j9eVTttSlEvrXxIjgeyZn0O3JjHWtCinXBpy1R71NVn8biNpqhxBCrx4VfjkD7yCQgqxk9yHoY93zq+Zjo4XsU9+A+b0Xl5RiBIBwiAxE9qvmT9ssSKr8QaOhkNGjee+Frp6f0qZJ2KPkEDfHm7e0h0tBgbNZXb7CJlCjArh3aJ9tZKjagjBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 23:49:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 23:49:55 +0000
Date:   Fri, 29 Sep 2023 16:49:52 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <651762a0a9fef_168c4629434@iweiny-mobl.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: da2555ee-e765-48fd-a959-08dbc146c7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdltEXY+KAwyEcrn8UCoJmQkkzWwMrt3DpWbfluMPTrMUoon0bTRdq+xgv1h06B7Enx7jo49R/eSBCvBaWOPneva83Nkg2NIM1hhVGG+hz/0/ojICJeeNyMVQmvxBQhB6/eEZDyASUJki6qPnB5eJDKSBFGJggqIlMCdpTgThjUdn1VIUwg7I35rwiMW9jom1B1jfO5gW5RLH+up9iaOeZE+8WB1EgH5tAtp4P4YKrBXvlEoV7JcOR633a40WoPkQNmc0eIZ36Kq/US2POYvd4Tjv0mMZS9PmYvsipKufAFsazpmXUnEhA+O2aACGfc6I8+ywQlJ2asEih5hPML3cke9Ywwao9GlMnnaQVcQmlagrBtllaABT/rkrKSMedqClXc/gNif0IasI/bryjhTr27LfV2aoknAW5j4OK7remJtkQvhNmF9jPevp8Nt0/YBNw3F2CXDr1vFBEvizC00Yw+fVZhNXL4EjretOrkim0tiBeW+AQOBEerFpr7XReZCmU+7VAYobIbHWt2d8wXG690/8kTfMAc75HJvCjifSDvveavuEJrjPvKLdIGmFGXr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(107886003)(26005)(6506007)(9686003)(6512007)(38100700002)(82960400001)(86362001)(66476007)(316002)(83380400001)(44832011)(4326008)(66556008)(66946007)(8676002)(5660300002)(41300700001)(2906002)(478600001)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GYDHLwKy1GPz/yAFW5f7p4bpGdMREljzipku7GElADg/Pwlu0B53Yh6SxVEh?=
 =?us-ascii?Q?QVBYUmK+EKlOhixAOjhIBMi46t5s+FzgmPvIZBncH9MLry03CY1n0ioSqu3V?=
 =?us-ascii?Q?n+nRi6oNemOft7sKzXC7/ZjdEOvFUcJroWEImJIIqS5TN4M7X8ZPR8z5PvUf?=
 =?us-ascii?Q?44ReI84MMll6MCz3yq1etv1Yu1hm4oEWlzkdqiX9lQKIGEgBr3b4yFAYMz8y?=
 =?us-ascii?Q?YVa8VHSqOE0A66Vd5jrPyjPl5qFdpJH2RJyJaVXW7sLSh3IQ6N/t1GErKtCw?=
 =?us-ascii?Q?T4vXB3WXUichNFDtej78i4nlAU9eWxW4krR8Ip1vRmqAkLEHV33fYLwdx9Vx?=
 =?us-ascii?Q?FDgQS7+RXwPCwq7jiIQO3WyC7Ig2PP2apXGTmwR2A3+AJ9ZeP3qEuE6Jrz4M?=
 =?us-ascii?Q?dmF9lbICQykstA7/qqIDynge9MQX8BUmIlIvPIcSOHPIucDclqPH2e+DBHB+?=
 =?us-ascii?Q?TkvQ5EFcdZoquoWP/5w8epo6IIgaR27wJFc4tsHhLmDeiSuM0AFNLiJhD/iv?=
 =?us-ascii?Q?3kUQtR8uVEMZ8Rux+OC13g38hMxVIVYPWfA3S5itZ7cjZNJXzfVbQIdTe7s+?=
 =?us-ascii?Q?QnVSggnG5QiY4nOa2SRJ6epfNCS2x656ygu2Mc1J3lt2FnAglypRAWRchjQ/?=
 =?us-ascii?Q?aU6Q8LkGeWKY9OyLFsKpsGWhpQwMu6/s7yiCFr0Z/P4w4Ai/jXErY2cCKOj4?=
 =?us-ascii?Q?4wHHzwOYX4GC7JUxnieNGnVPmXzE5qJaByZshKypbzTkjIE5wel4YCf8YWFT?=
 =?us-ascii?Q?CtibeSoB8qOv+PWGKOBxtMqUiEMfg8EkvxBCWmC1ka9lFWK1imwmyT4yeo1g?=
 =?us-ascii?Q?66H0WUlBZXHfExWa9gfNzagFTECXhAEUUmop0EcR0PHWAOlJgzD3TDq3W8hW?=
 =?us-ascii?Q?h1oqHKF9GJpR/AEo+hfZuPyFhAccOi7oHlY26BI1Uq80JCAcmMT7VYcZT+A3?=
 =?us-ascii?Q?eM3+Xr2jpToLMEvd35LanGc4oNRS0PcqwfhdIIldNe8jRCkJPj7fmF6nCkym?=
 =?us-ascii?Q?/u2/SqSXUkI71pIeCmR1VjbYzHF5ipoVRlROtRKEu3tXYBni8DoOeahRBGPL?=
 =?us-ascii?Q?PeI+1lp1EgVRbubjpHliXjGLxFj3L7Iuncv0g6wjx3RZUbOAan3+f5rJApJP?=
 =?us-ascii?Q?GcyIzPXC47Kc3NrOszbPvVLpRhFxpffC6wcVr3OX2XuXYpiSEbtN6QpqYwlp?=
 =?us-ascii?Q?RJTnX13ebQk5CM67jsTUpDYCAUZ9rud3Uy3iEDjIilFgFRaLNuBn2CLrZWSR?=
 =?us-ascii?Q?UiMLo0AoHarQIFkGa6j56waAnCdxx2X0iWvXNqp1kP7K193QF9EgYl3igNpX?=
 =?us-ascii?Q?fRCMDy1mJNqvWalq8sZhUZ0uENOxP6s7r3anmyYGMfWc6muxPSPfw4mpejHu?=
 =?us-ascii?Q?RPBBE6QZZj5B71ND+W3B4TdfPU6oPBjjrauhUkH3VJsqpnQ59inUjvS5lzIp?=
 =?us-ascii?Q?V1R5+AeRU9zR8PJ52Qm3aHcMbi1lEneIYzQgLATe6CHbMx7BbSMw+iC3OydX?=
 =?us-ascii?Q?Rjap7MEI1bvxPpzsje5bIV3+0lgceZjUi23WQH6Iewbq2sVVGXm+AoGxIBPj?=
 =?us-ascii?Q?xyFWAqHcKsUXYjU7y6lCekt1pJRwts8+8nSz7ukr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da2555ee-e765-48fd-a959-08dbc146c7f1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 23:49:55.0837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzO2NQyxm4lUOF0tWxcriJSwPiaBjsPWRMc79SthVMSaO2sVL2N9YIlazT4U5Xvo0CpeI6St8KLu5fRmfIp+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> In preparation for fixing the init/teardown of the 'sanitize' workqueue
> and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
> to be the single location where the sysfs attribute is notified. With
> that change there is no distinction between polled mode and interrupt
> mode. All the interrupt does is accelerate the polling interval.
> 
> The change to check for "mds->security.sanitize_node" under the lock is
> there to ensure that the interrupt, the work routine and the
> setup/teardown code can all have a consistent view of the registered
> notifier and the workqueue state. I.e. the expectation is that the
> interrupt is live past the point that the sanitize sysfs attribute is
> published, and it may race teardown, so it must be consulted under a
> lock.
> 
> Lastly, some opportunistic replacements of
> "queue_delayed_work(system_wq, ...)", which is just open coded
> schedule_delayed_work(), are included.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c |    3 +-
>  drivers/cxl/cxlmem.h      |    2 --
>  drivers/cxl/pci.c         |   60 +++++++++++++++++++--------------------------
>  3 files changed, 26 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b547c07f54..2a7a07f6d165 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -561,8 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> -	if (mds->security.poll)
> -		cancel_delayed_work_sync(&mds->security.poll_dwork);
> +	cancel_delayed_work_sync(&mds->security.poll_dwork);
>  }
>  
>  static void cxl_memdev_shutdown(struct device *dev)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 706f8a6d1ef4..55f00ad17a77 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -360,7 +360,6 @@ struct cxl_fw_state {
>   *
>   * @state: state of last security operation
>   * @enabled_cmds: All security commands enabled in the CEL
> - * @poll: polling for sanitization is enabled, device has no mbox irq support
>   * @poll_tmo_secs: polling timeout
>   * @poll_dwork: polling work item
>   * @sanitize_node: sanitation sysfs file to notify
> @@ -368,7 +367,6 @@ struct cxl_fw_state {
>  struct cxl_security_state {
>  	unsigned long state;
>  	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
> -	bool poll;
>  	int poll_tmo_secs;
>  	struct delayed_work poll_dwork;
>  	struct kernfs_node *sanitize_node;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index aa1b3dd9e64c..ac4e434b0806 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -128,10 +128,10 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>  	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>  	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		mutex_lock(&mds->mbox_mutex);
>  		if (mds->security.sanitize_node)
> -			sysfs_notify_dirent(mds->security.sanitize_node);
> -
> -		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
> +			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
> +		mutex_unlock(&mds->mbox_mutex);
>  	} else {
>  		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>  		rcuwait_wake_up(&mds->mbox_wait);
> @@ -160,8 +160,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  		int timeout = mds->security.poll_tmo_secs + 10;
>  
>  		mds->security.poll_tmo_secs = min(15 * 60, timeout);
> -		queue_delayed_work(system_wq, &mds->security.poll_dwork,
> -				   timeout * HZ);
> +		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
>  	}
>  	mutex_unlock(&mds->mbox_mutex);
>  }
> @@ -293,15 +292,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  		 * and allow userspace to poll(2) for completion.
>  		 */
>  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> -			if (mds->security.poll) {
> -				/* give first timeout a second */
> -				timeout = 1;
> -				mds->security.poll_tmo_secs = timeout;
> -				queue_delayed_work(system_wq,
> -						   &mds->security.poll_dwork,
> -						   timeout * HZ);
> -			}
> -
> +			/* give first timeout a second */
> +			timeout = 1;
> +			mds->security.poll_tmo_secs = timeout;
> +			schedule_delayed_work(&mds->security.poll_dwork,
> +					      timeout * HZ);
>  			dev_dbg(dev, "Sanitization operation started\n");
>  			goto success;
>  		}
> @@ -384,7 +379,9 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>  	struct device *dev = cxlds->dev;
>  	unsigned long timeout;
> +	int irq, msgnum;
>  	u64 md_status;
> +	u32 ctrl;
>  
>  	timeout = jiffies + mbox_ready_timeout * HZ;
>  	do {
> @@ -432,33 +429,26 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
>  
>  	rcuwait_init(&mds->mbox_wait);
> +	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);

NIT: The change below was ugly to review...


>  
> -	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> -		u32 ctrl;
> -		int irq, msgnum;
> -		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> -
> -		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> -		irq = pci_irq_vector(pdev, msgnum);
> -		if (irq < 0)
> -			goto mbox_poll;
> -
> -		if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
> -			goto mbox_poll;
> +	/* background command interrupts are optional */
> +	if ((cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) == 0)
> +		return 0;
>  
> -		/* enable background command mbox irq support */
> -		ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> -		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
> -		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> +	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
> +	if (irq < 0)
> +		return 0;
>  
> +	if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
>  		return 0;
> -	}
>  
> -mbox_poll:
> -	mds->security.poll = true;
> -	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
> +	dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
> +	/* enable background command mbox irq support */
> +	ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +	ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
> +	writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>  
> -	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>  	return 0;
>  }
>  
> 


