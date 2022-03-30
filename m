Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4121AC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 15:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiC3PHV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343578AbiC3PHQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 11:07:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE75490FEC
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 08:05:29 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KT8n66s0pz67YJ6;
        Wed, 30 Mar 2022 23:02:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 30 Mar 2022 17:05:26 +0200
Received: from localhost (10.47.70.51) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 16:05:26 +0100
Date:   Wed, 30 Mar 2022 16:05:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] Do not allow set-partition immediate mode
Message-ID: <20220330160522.000018ad@Huawei.com>
In-Reply-To: <CAPcyv4i36Mnza83Bg0+VfVfL_+84EK=Y6aGBa+MF4tQ32HP3AQ@mail.gmail.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220325103426.00003916@huawei.com>
        <CAPcyv4i36Mnza83Bg0+VfVfL_+84EK=Y6aGBa+MF4tQ32HP3AQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.70.51]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 29 Mar 2022 18:24:50 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Fri, Mar 25, 2022 at 3:34 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 23 Mar 2022 18:11:17 -0700
> > alison.schofield@intel.com wrote:
> >  
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > Blocking immediate mode in set-partition info triggered a
> > > refactoring of the send path of userspace mailbox commands.
> > >
> > > The v1 to address the issue was a single patch [1] that inserted
> > > a new immediate mode check in the send path where the payload was
> > > available for examining. That was not in a validation function.
> > >
> > > The v2 patchset [2] added refactoring of the send path so that
> > > validation work can all spawn from cxl_validate_cmd_from_user().
> > >
> > > Here, v3 offers a finer level of refactoring:
> > >
> > > Patches 1-7: Refactor existing code so that all validation work
> > >       can spawn from cxl_validate_cmd_from_user().
> > >
> > >       The movement intends to cleanly rip the work of building a
> > >       mailbox command away from handle_mailbox_command_from_user()
> > >       and give it to cxl_validate_cmd_from_user().  
> >
> > This makes me wonder a bit if
> > cxl_validate_cmd_from_user() is an appropriate name given
> > it now does more than validation?  
> 
> Yeah, perhaps as a follow on, I think there's renaming possible to
> make it clear what the difference is between:
> 
> cxl_send_cmd
> cxl_mbox_send_cmd
> cxl_pci_mbox_send
> cxl_validate_cmd_from_user
> handle_mailbox_cmd_from_user
> 
> ---
> 
> cxl_send_cmd is really just a helper for the ioctl path so perhaps:
> s/cxl_query_cmd/cxl_ioctl_query/
> s/cxl_send_cmd/cxl_ioctl_send/
> 
> cxl_mbox_send_cmd() is the path that kernel-internal users take that
> don't need to do any copy from user work to pass buffers to
> cxl_pci_mbox_send() (which needs kernel buffers from
> memcpy_{to,from}io()), so perhaps:
> s/cxl_mbox_send_cmd/cxl_internal_cmd_send/
> 
> cxl_pci_mbox_send seems ok if the other function names change.
> 
> cxl_validate_cmd_from_user and handle_mailbox_cmd_from_user are really
> doing three distinct operations. Check the payload for correctness,
> check the command against the submit policy, and construct a kernel
> command buffer from the user buffer. So how about:
> 
> cxl_ioctl_send_checks() (inspired by submit_bio_checks())
> cxl_ioctl_send_to_kbuf()
> 
> ...whatever we pick I think it's ok if this is done after this
> reorganization completes with the current names.

Agreed. Keep this series clean, but then circle back to cleanup
the naming is a good approach.

Jonathan

