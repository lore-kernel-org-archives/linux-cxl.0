Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E0E7734B
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 23:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjI2XvI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2XvH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 19:51:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52832F1
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 16:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696031465; x=1727567465;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vk/vJ3xGv1vsR1TNsc8tTTmFksFBjc6gfritcsqTPnU=;
  b=gh+Fh+DeilvNF5zO1IS/kvcWKCIsnF6ZqyQ/TyFZ1yylOpPS7VJotwvP
   Gy0qWVnk4ZaC7T0PcpwL2ZL88sRqtkBSC9AkV6wcuKyw7sYpV8p64reKN
   O2hWJtZj3apKn5HofCvfzY/WuCbAW813uMktZlE30sCTH2YLYJ+WwanRO
   matWjx12O7V9fFDKcIebUMpZsMYHgKuhbo299y1iTMpPVmkTTE/6Crj1q
   5Emv3nqKpsrkkw2M8e6fcT9em3LENgKRdndvUxSE+Zl3sYb0ZqHymihWy
   svrsnjsxXplJGX9m+dHXe897tTKOCi+2uftiK3n3af6tsy6ml7EUHup2N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="413305820"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="413305820"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="753530277"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="753530277"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 16:51:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 16:51:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 16:51:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 16:51:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4+dmC1owjwVVS+EguaX+OZRu6di2rwBgCQ/y+yP7C8h6mxiv1T9KzAkmexe37nd+L6Hfdcphv6rKqR0COcjAUUWYnTPsHuOyZEmLQAAF4mY9sUsaNedcpZ3ZCobzeySljP9pF1pG8yyPcgppi6pG74yA9wqKpbY8sUhymCMgOnRzFjWBvefFBBs5eNOedpMkiS2XWY66KpZIQSwXcBxxyHDUIg1QLwDG/ZcAU6/VbUHn7KFJRnJEr1FP/KZtS6eaVHUhZ8nncR8c1LNXcCGlsjMVUPjnrbK7bcT6oWqOQyenYX/7fz6hr/s5jCtXDUuSktzCzbctcZjhkshNwx+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Eb+vjD5xtR0RQEz02CvVnIKhJeMC2CEWi9i70Mk/SU=;
 b=OTkuONXk6avBFL3JPLvFvoB2x5azTWUDJ7iBu9jsUbeGDRlLVnlyAkDSWC6ySztB6DDS6weRecPdtQkWjAcIfI8vHikZ5nQ9uSNpXGWQaMSKptRleOI7ENLHyE6Vwbkc3NXX6u8ZjlaiuYo3KVNA+/FpWfo0uwcbIDAO5iQTogajibvuUEtxg2+q9ZDTrCGCVWzAyBjtW8qts/LWJKh4iCpoMxdRqCHDdHR9SQwOVa7WCVYVKPvAlzTd6WBqrl9KO17apMAV37B5o4rvRL8/AMUJkdV6pwDqJ/BD0XroTKSIUv5XHwQXjn7s/BF6+kgzWkFYbEeJ295t2CbFOJE5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 23:51:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 23:51:02 +0000
Date:   Fri, 29 Sep 2023 16:51:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <651762e440ba4_168c46294a3@iweiny-mobl.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: df24752e-8eaf-40e7-cd53-08dbc146f039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6eNc71KsaadV2jmxTq8L8RueJhhXO94KgDNjuF09pyTGyZrbRq2d9YBh0/NOv+Zfo8NG/I6SJWFlZV2Rrv1bB5mxatNrMNVRhpateH58YJIBgYSfK/9Ghiipp3h0Z0jMlrhPypldElpi7mOMpgXh4K5EJzSTZ81CzLFywUjpTMe4yb8ZJZnyyJIdkboGIreYhyFRHY52bExAa2lcSHvOYxuFE6T1EvpMjRgvA70wqIZXaCKOcJKpwuev5lt/p2SxXqxyPA/OEDFPWmcBfsf10FSkjRT33Ay9/s6TYupp/+5ZUKlkYeXDqzsCsG10WsA1IuxZmY85cHE2eAMlwoqdy68yjIZNRVNW+kuTkwMvK0G24YaDp7vEBlbN0RNmSv0NyZyaiWbKuD9uJAmjcNFwoaiop0s50of4H6bRk6/DErLQb8YrGsyhOQqaCy75IzILhGfNqo+q4c85lqsbmqr2dFcHVBPJL6vuzJCQHIY37tHBPXvUimLlGCnRclojsbuLzGyZqVUyDTrwKAGtSWKhH2N6+67gY+mBukeCYHSa7+G3X8zcUtkC8Wu4+CNMHML
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(107886003)(26005)(6506007)(9686003)(6512007)(38100700002)(82960400001)(86362001)(66476007)(316002)(83380400001)(44832011)(4326008)(66556008)(66946007)(8676002)(5660300002)(41300700001)(2906002)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?39L8y3D0fr2ihgoTlc7nM/df1uYfIu7amwkxjGyuIlxzhw/Di3V/ug6oGICL?=
 =?us-ascii?Q?fEnzXQPZ9sAX2wcPj8MriIHOchG/uPpepd18qG/z6RPVSRN9qdqiF1CPfavd?=
 =?us-ascii?Q?dcLgjP6QwH3oCO5G+VBtPhF9FMO4J0+SqTAVsxDuZwWdpi44TmVZ3aWYSAYh?=
 =?us-ascii?Q?ywigLOQdhb9PEzb1i9l0cmxvRzp91TCaykQcEszFPGLhZVxrtbbPWN/oQT9A?=
 =?us-ascii?Q?TZqukJymWLmAcyo3QCsdf35tRcjPU6686NRiIfA5bQRDSDtuNi3abfFhGDvh?=
 =?us-ascii?Q?xiWUD5S7Xywou2F9qmgDjuFXd9fM92soOAX6gFjcpv6z+wJtP0wfFIYg1gPP?=
 =?us-ascii?Q?7aeS50FkpR4S3sJhNRhxEkPqmGdtAtqKoSjuhrh2CHhZtbPffqAwV9t5ibSZ?=
 =?us-ascii?Q?QgiweW+HWCttGybEd/5CAH6XDL6W4SttRzivRUo2VyUvlWPvCkA/UnJZAID9?=
 =?us-ascii?Q?x1PMYYmZM+xVQa2MDvzLNGz5YUdswBlyiX2NwJL2YzGvzp8JHpmUZ4E+thEt?=
 =?us-ascii?Q?p1b602ZwzFjtmR0OGkadkU1uJxVSRUNJ9N4Sf4XHFNEQ5om2n+von6f415fD?=
 =?us-ascii?Q?sepDGSHQsvHFlPExJPkV0SrraBnMvUmiIYzil9oI2JNljizTv6RqLvmeK2fM?=
 =?us-ascii?Q?jSoCjgJIrp5MY/K3i9nj3K2bHBg5cXB3b3bgLeSPXpYcSn0ZC8N3Iozknpcw?=
 =?us-ascii?Q?bKEfSgX52bPvCL12C8y9MSlUY7GGbW3wwKkDAe3a5RshbLmm0/NLP06gN7eB?=
 =?us-ascii?Q?Pst/V+KGbTetJIkjNLua+F7/Bp1i1XBCH1KQgKvAP4ZO8zCeq186q/+bfU5b?=
 =?us-ascii?Q?aZWqMkpDFoe2mYtPe1DvNklZN1XWkVTI03tqQ9m9DihNx0NIWsCEYgN7EPmh?=
 =?us-ascii?Q?V/mR3l+l/ICAe4Pcd74C2Uqx0IIaI0FkDejFOOWCB5oA9sI0XZqT0uuu7ROk?=
 =?us-ascii?Q?e9o5SgVcCGJwmHDWUTZqrPuZvBQwx6442Tqb9IXcFiggAeU/rV2/BULGC+tv?=
 =?us-ascii?Q?rrVvJkLSwwyF9Fa6yNxHct9jDGsho+jROi3NBvH4jdobyBhxPfqVAUH29Rw/?=
 =?us-ascii?Q?6eBhzx9d4meZ6BEOFvrbHWUmNHzrwYlmtAGNgw7bbiCXbEv4vR1bfFbJ7m83?=
 =?us-ascii?Q?loezoSaEl+B7IZIHva4+rDysiJERzgqxOjRkmHujTp08vCtwosMOhL+PMjYv?=
 =?us-ascii?Q?OYSp3aU2lK0uDlK9LVR7CfoMkpgBXa/73U8Iv6byBzniVIIbKYb6DPFNwulM?=
 =?us-ascii?Q?Fw2ZvGanp7h1J6sT75LizsqyXR4cHxwlC0E4g/3fNEXdzA2Kf2NfenrlVlSI?=
 =?us-ascii?Q?k/JlVmMQFe9U9YprcyolDirdJiUATGkml44ypAWBJIe8O6iZWJTZDhxf6JM/?=
 =?us-ascii?Q?wLvfuQgV8IiLdNcLWdRcAu9YayQN8FJ3SSNNZwBVlg0Oy0KD+eZAZHxHBtKV?=
 =?us-ascii?Q?lr8OqdTQdw7QG7o95W2YTa8CR7wy9PpgfhBM84mB2ZNUmn8tJXANpm6WP1ej?=
 =?us-ascii?Q?FkR/YlPMTIFqTv/ey6NlVvaU214/FCLnXRrgVHq9RnufodjRqMyXsNI6GJF1?=
 =?us-ascii?Q?D6v1r2sDbiJn56xrJfGeIaQBQD061Rs3vjQaXB+R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df24752e-8eaf-40e7-cd53-08dbc146f039
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 23:51:02.7269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJGigVPqfqy+Yjz/XJn9lxJpo4baqstu2E1dGSzTRhXBNB25bQ28LQvhp3Bjp29FbxKnmCEIh3kHEmr8DlTGeA==
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

[snip]

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

NIT: The change below was ugly to review...  But I think it looks ok.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

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


