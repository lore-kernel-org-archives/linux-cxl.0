Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB25C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Dec 2022 22:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiLLWwT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiLLWwR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Dec 2022 17:52:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D1101
        for <linux-cxl@vger.kernel.org>; Mon, 12 Dec 2022 14:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670885536; x=1702421536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BJIkGrXdSDeAvP9CR/KrtF/9ETqqMswHhKfDDkOjhGw=;
  b=WUOrQS8f6QSXE2ZSRsKRXDtYdFiRiwWGofWoeaaTS80PYcm5mdu6np5R
   /nodCZhVeOQg24TKjNw/a6MzO0PuEyAMe7VpZwUbG5/hcQx4LQBoyosxn
   4HPg6DL3SIW4t8gvqZQQVXYitZoxMsV2PfGXff85nhKbovR8sfyUn5hD/
   MtoGf3f2gFjIS9pwKmn4Fj1+DxVHUtDbLXEZeu4bFpxxeI9yhuUHHjc1F
   BOEreNu2tdtNGnk71IknvwBbaB7YMjVVxIjWDbKHj3OqusuJgJJbsTDKD
   rRKtjLWWSbkiw31d2fRLnZ4FpIXJkwnsUxqZBhKziZVqcthtKwkP08Zwx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="382290538"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="382290538"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 14:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="648340486"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="648340486"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 12 Dec 2022 14:52:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 14:52:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 14:52:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 14:52:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLY1D8/RhPyVFDWqI82gFDku18MytPFD48IeQDC4SLkRvAhWe2PZiWGAmjMeWKwaeobwGLr4UxRW8+BFAlDIYSt9ju5lIR604c0nShzkztD5d9F0qYTO5TQsE+lUWJLnJpoXCDlIVxtIzqRf4MOAk3pwfcEfvnWmvT+dkiGDW6oJUCY6GnSBy0ygP92Rcf0STrmtLhg+JEqiZLQHx9WWybKd89rNuZiOLGmKBiuyJU/LwwgWvSRAgbJH/vn2fEcO2ow4qgk9zcwQ4oduP4pTskZJRC6HGJB3VUR6NuZk+1eE31YiS2W/u/UwsLzndDE/mlhUwlnfGwddC5wTrSnGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQj4G9t1m1t26r8/nfnrX0u+YWrIZiRFDIkkifTbVBk=;
 b=XG7KWjUk0mpVtQRGP0BU9Vj4xw2tS07+WIPWRTRhFm67WhNNSqvepfQ2WCgFzeYST7MTEkuicDhEZgt5m/pKX4WMu7/VH6+4XWAPkoCxFFYUKKk+NRiRs9uKqDApmEzST0YFftgmDBKjdSHyEkjuGMLyB8fAqJO1aY3vyipfFai2BNV7Eu/fMlABzZspg5ootV6r2FheXFgRr9vFhxV7J2EkoSlrb3cQ3AHMaF0+kuiJMw5G8L3b/xDJO82uCn7JGW/sMrcFWZn/1D7MoqNYnjyTa0vb0a0yja+hl4Ji+3Rgmtg26OD92arsKS6kt2o0JayCP+lWQcd9x2FZ3UwLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY8PR11MB7035.namprd11.prod.outlook.com
 (2603:10b6:930:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 12 Dec
 2022 22:52:12 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 22:52:12 +0000
Date:   Mon, 12 Dec 2022 14:52:04 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Message-ID: <6397b094dfabe_b05d12945@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
 <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
 <20221207161026.c2qpn4p7uplm5qkt@offworld>
 <639103c3b0853_3cbe02944d@dwillia2-xfh.jf.intel.com.notmuch>
 <20221212170507.qn5pegj6s6q3nto6@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221212170507.qn5pegj6s6q3nto6@offworld>
X-ClientProxiedBy: SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY8PR11MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fc8b3a-617f-4c56-1df7-08dadc9381b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UT15onfxfoWqH63CzSEPPP1BgmhTU+oevU9lfFADdlZeW7DOyuxbljpAO1ckcF5qWBjghT3Drfdzm61zzQ8+WNmx8V2DkG3YjPuHwKxuSZmnQrhOKM0B6V9DGUI8gJwikgI8l+fCXr7m/DDI8QkUqZXi4wDvSyvDI+uayHks4uP22FlaU+O3d0JSKjfUnAwxFjgOkgYOIDFbBzTieAeO/VlgxhQZhapndim6RbZFE9zTntb/LwKQXZfqbnfSXeUm5hiy+TQFLIZCn0ffoBPk7iU3xpA5AZfOTGbMxfAySGsyTj/a1PiPlnwFxHkr6KQcx9Y7DWlUsTbXDTQIexEV2tdJvlBvyHgP1b46Y7JvZkKHry6ei8OPvfgEkMu2LMC7z+VQAlnFPdi69lc2f3r1Pg5ZtKp9icAKKvzse5j2aK31ZM/Iy74jXAZhup0xTLJBAKgpXgSM+qPUe55LlR44xmh5APjW+9rMJ3W2FNWK6gkeC1bcPXdVOWzrSknUny6nYdkUxA01f4agZVHL1fgcLDb5VBiu+okyVim+E+M8HCuMwRbYoBpM2PdIwgsnbagiJ67IawsdtGpuovAd84k6xaQ8reyXXCZwHnRYuEwSCQXTSblpG3s+sply38mDQobBRw9GziXXsyCOH5ixnHQkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(6512007)(66899015)(38100700002)(9686003)(41300700001)(6506007)(110136005)(5660300002)(82960400001)(6486002)(86362001)(478600001)(83380400001)(8936002)(4326008)(6666004)(8676002)(26005)(66946007)(66556008)(2906002)(186003)(316002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/TjJLhDYpik60W++fuc7TCAgoTiIWpWQPSJyUND/jzkAD4yw680RLdMOnKuL?=
 =?us-ascii?Q?ssuqJchzF1RW5enaQoleAqjA/IjCYtOdgeEdoLEarJskmS6KhwZ9Sr4bNRZb?=
 =?us-ascii?Q?HRYgPWfVNQXSkHvNjIsUNZsuwoFabwVxkW0Oz4HZ4sLlgbbPUNyE8LBI9OHt?=
 =?us-ascii?Q?1mZ5yqNLR9oDlBtEHsLMI4+/m6lAf0T3jQGcuInqLo6H32/gC6Zc2rwzDpws?=
 =?us-ascii?Q?ek/JwD6fIrQrgAtYysBEhQDH/Mrn7AY9A5TjwWdU/iSQka+4QBmv3P06q4il?=
 =?us-ascii?Q?tnLZMBfQZlbu0kCGqLU7M7hCvugsR1+nowlvDsZzxUTHIW0jgjHXKkdABrLs?=
 =?us-ascii?Q?viwg5jqLvUBfwJ+qCmrxREN6QfP/cJNEy+tzNfMRas2tqHY3W05zJo4mZ6Qw?=
 =?us-ascii?Q?Qw9NXM1JN1Xoqfu2hnDMWw3AH8I2jss8h+AScbjkJ5nEBzcW4t1kkCvwHTNf?=
 =?us-ascii?Q?AnpfaVBUF2ScjDtL1ttA+0HKDjdOZDXUw11gs9z8cO00rCMOWxDM4J2atLdz?=
 =?us-ascii?Q?pAlbgLFwe12yO6i/zWz1n3XbiRsH/GytJpXAXEGHeBa73LRuCvDFremszn/M?=
 =?us-ascii?Q?2lj3nzDTTXetAClTL+ChQ7cKH3AU5qCCvN8oewjydr9xMge9vyD6h5yDhXtm?=
 =?us-ascii?Q?OaqZgwTaU2kEqSwj9PG/ewqkt1l1WEuz6ItCXnqPjhJ9eLbS8x2mKLQ8fxjz?=
 =?us-ascii?Q?S7/IRrp78Qc039n+iRtnGZIY0w6+Xm7VYGoYjiZ1pojYpsnRxOVOWr3DROok?=
 =?us-ascii?Q?LsyRkKKYkb/YnPpuz2ZyfjNQ4MevkQGpnwNrLQldqdl4+wcXqjHMavkAxLdn?=
 =?us-ascii?Q?rw+1rvkB1c5cPa1V1+bvquvERMmN99R6BqgaVWJzPfY0l3MWeU2ks9p4Ka2D?=
 =?us-ascii?Q?hGOfWihJMfZ1mlwgp3nKcXFGAoTGB8qentZA4cJaZbtSmVyQT/OSiiUD/+/r?=
 =?us-ascii?Q?iAjMKGvFR8QcnigzrFp8rnVJZ/coWr1wKvca8x6p86fPLC8W7pGs45Xc+hJy?=
 =?us-ascii?Q?Z+WneIbI2zcmIMGFfyUUWv7z/SNk9qdZ4eA+MUlPEeoAZDQ1kCRt4b5bRFsN?=
 =?us-ascii?Q?MiURupEebD0YDepsoAgNXicufTErfDYBZLmfVdf7/Mg31eVI+OMfUK4W3YUi?=
 =?us-ascii?Q?z3C2xBG1pE+/uS7uBAutaAkq+y4nkDaYN0OkBwZ113Bq6m5mfaWG0ioSm6N8?=
 =?us-ascii?Q?jiYesB2WL1iAw08skg5gDeMGWkYCan9UbBy4jXdjaozbbgAWIabl3kBZa3pY?=
 =?us-ascii?Q?9Lw25MKaRJXwh4zeThBaMqPiSn0A1jeiM5egV6zv/H+4dZA0w2lOK94QjTvV?=
 =?us-ascii?Q?x/RR4ttly29d/ymLvQD3o8sIewCmo8QR3C+RyXCeK6tSOl5AudT5psPcSYTn?=
 =?us-ascii?Q?0PvsxEK6knWNI+TgrrA4i0tkJNBvERxz2ZoW62fSvUBlTJEbNULwsK+2Hr80?=
 =?us-ascii?Q?e49U8La/avu9thEnrxZfnttHQDViO9lC9jiloaEGGi/aLP7uCAPDiRmevE+/?=
 =?us-ascii?Q?yx16y2tGjPASBns04Htv3CHSjUt5qlFlCZ01DKwODKU7NtNR6R7nG7ahVICd?=
 =?us-ascii?Q?WBP5WjGJ0JSOZYApoGc6A30IoMcuhH30D5e/SgUZcpqKgOPizPhPVBFbrDMo?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fc8b3a-617f-4c56-1df7-08dadc9381b4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 22:52:12.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuwO+51bdYvAAHtAMoKPkH3RwOb9AV8Db3l8uZuYtWNmVqbZsivl/uJtvM/o8VmNWSbR9mxUnl2KWOPirgwpiTT01X4uAcTiqRH74q/DfX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7035
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Wed, 07 Dec 2022, Dan Williams wrote:
> 
> >Hmm, I'm just not (yet) grokking how the callbacks or irq support
> >simplify the implementation. Perhaps I can explain better in code...
> 
> So when I say that no polling at all makes the implementation simpler I'm
> referring to the fact that only some form of ->post() would be needed (in
> an async context of course). As such, most of the infrastructure in this
> series is to support polling, and without it we could do away with the
> other callbacks as well as the atomics. The hardware would take care
> "synchronizing" everything - which is similar to what Jonathan had
> highlighted in the rfc version and was wondering about the explicit
> checks.
> 
> >I see irq support as a small incremental extension of polling support,
> >not something that precludes polling support. For example (untested /
> >unfinished):
> >
> >diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> >index 3a66aadb4df0..30b21ae4cbe5 100644
> >--- a/drivers/cxl/pci.c
> >+++ b/drivers/cxl/pci.c
> >@@ -178,6 +178,19 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >        mbox_cmd->return_code =
> >                FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> >
> >+       if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> >+               int i;
> >+
> >+               for (i = 0; i < mbox_cmd->poll_count; i++)
> >+                       rc = wait_event_interruptible_timeout(
> >+                               &mbox_wait, cxl_background_complete(cxlds),
> >+                               mbox_cmd->poll_interval);
> >+
> >+               if (!cxl_background_complete(cxlds))
> >+                       cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
> >+                                   "background timeout");
> >+       }
> >+
> >        if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> >                dev_dbg(dev, "Mailbox operation had an error: %s\n",
> >                        cxl_mbox_cmd_rc2str(mbox_cmd));
> >
> >...where all irq support adds is a small handler that does:
> >
> >    wake_up(&mbox_wait);
> >    return IRQ_HANDLED;
> >
> >...to short-circuit the wait in __cxl_pci_mbox_send_cmd().
> 
> I agree that under this synchronous scheme polling and irq are quite
> straightforward. I had always considered an async approach and not
> playing with timeouts, but just let the whole thing run to completion.
> I was also guided by the fact that the spec says:
> 
> "It is strongly recommended that devices continue to accept new non-
> background commands while the background operation is running."

A "strong recommendation" without a specification defined mechanism to
know when a device adheres to that is effectively useless for the
driver. If it needs to consider that failure case at all, it might as
well skip the optimized path for what are slow-path operations that do
not demand optimization.

> 
> What I don't like about a synchronous approach is that you get the
> situation where the driver timesout, but the hw is still doing the
> background command, no? And there is no way to "cancel" it. Sure,
> any new incoming mbox commands during that time would self-serialize
> naturally by hw. But when the bg command is done and we have irqs enabled,
> the isr will be triggered and we no longer have the context. You would
> also have a discrepancy in a returned timeout error vs a different
> return code from the actual hw, specially if for example the operation
> was successful. afaict the only thing that would allow users to know
> the real status of the sent bg command would be the Background Operation
> Status command, but that is far from ideal.

The kernel needs to give up at some point, so the status for that lost
command is "timeout". Then the mailbox state is indeterminate until the
next successful command submission and the driver can get back in sync
with the hardware state.

The typical solution for this case is trigger device error handling up
to and including reset to get the driver back in sync with the hardware
state. Unless I am overlooking something CXL is atypical / stuck because
any resets that might recover the mbox are destructive to HDM decoding.

> >The cxl_internal_send_cmd() caller gets a synchronous response and can
> >handle it from there. No need for conflict detection nor async execution
> >contexts. Caller is responsible for making sure ->poll_count and
> >->poll_interval are reasonable.
> 
> ...
> 
> >The complexity I see here is the synchronization needed to make sure
> >that the isr is aligned with the current background command queued for
> >execution and in turn synchronized with incoming commands. My
> >observation is that current mailbox state synchronization is
> >sufficient for:
> >
> >- Transfer FW: broken up into multiple transfers
> >- Scan Media: broken up by Scan Media Physical Address Length values
> >  that try to get the Estimated Scan Media Time below
> >  CXL_MAILBOX_TIMEOUT_MS per iteration.
> >- Sanitize: the device is effectively dead during this operation, so
> >  there is little need to time-share
> 
> But tbh I find it much more intuitive to get an error then having to
> block for who knows how long.

Yes, agree it would be reasonable to just have the driver reject all
other commands while sanitize is in-flight.

> Either way this would still require special cases such as sanitize
> where the poller should not timeout. Of course there is nothing in the
> approach from this series that prevents users from being mindful of
> the background command and breaking things up, where possible.

Right, especially because all the users are kernel internal. So it's a
code complexity question. It's easier to add flexibility than rip it out
later so I am leaning towards excruciatingly simple until that becomes
unbearable... which in retrospect would have saved some of the DOE
implementation thrash.
