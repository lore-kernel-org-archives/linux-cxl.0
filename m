Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71313C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 01:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbiC3B0q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241538AbiC3B0p (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 21:26:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7BB5D661
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 18:25:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso4675226pjb.5
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 18:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBtZ2egYpCjwRIO54vCI5XOSIgE5NSFKpUhGwawH0yg=;
        b=uIHbt/+mjsFy2OsbqMHlVl7n/Oh2waKiS3Xu4LQwZPUnDQfDRsQzRLG6ZoJqaKKjcI
         wDN4SUJH6uWFrz57wwbNNvRinuxP+RI2MstufMHMcJVQJQ9sdCXvAyVxnyFQpY7fvrE9
         KXb+joTrX7uQgpjjJHQpqTsm4a7j5h3QW7NbBcSVxKeymzQbjpe6qrjPfYDqUrnO8L2z
         AF5lcLSaD3qyi8DJP7od48/6FTp3SkTAyOCaZegR6C0VENIHbWSi0l3ImOkfQUcUXPNa
         uRcY1TkhuSHj+OQz0aNNtK/yINZzPd8IO8tu6SBJ+JOeX9D/8hx1gN0uYRVENSKN29eB
         cS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBtZ2egYpCjwRIO54vCI5XOSIgE5NSFKpUhGwawH0yg=;
        b=z+OmdE6QFYZP00hhNGQT3z56ewsTsKZ+/z5IC3DqdCywuj53FOpEDIaqIaCxfHzde3
         SSXC9FLeOQBJi83TZWvnX1f1UdeFjZ5NP9JXdDzfgPi0lmm4DVs0OFlNyf08fu2uu+Cm
         EpXshe+nJMPhW1Ob4piOgRvyeODZtZEo3CoOwJi3Y1PiDAQLiZSxcQ1Jm94aRHUbP6/y
         qQ+4W3lXi6ShAEtN8Foshq4UcE+6V2omwOmN0kjt4tW8QG6wRmrTvcq0/zCU6x6cS1KY
         7nDpsMFbWlHy/JslbLfora0Sq0lg4wV+uA17aa3jmLVrVEwORB2dNuFGvtqDEcKor7xi
         ZFgw==
X-Gm-Message-State: AOAM531Jp4lZw612qk137nrCQknKlPSwPC00pg4MjcByBaPcrFgfusHQ
        wtDf8oRIblBaojn5StPH70nWxffRumOKx3HXBId97g==
X-Google-Smtp-Source: ABdhPJxG641zkKSQbJTi9mXrZG14HudBw/ASZk/L1hxYawtvvOZWOBLvS2YyGgqyZ7Z/Ueh+CIPVDQZ9kF4gUicQNtU=
X-Received: by 2002:a17:90a:990c:b0:1bc:3c9f:2abe with SMTP id
 b12-20020a17090a990c00b001bc3c9f2abemr2130563pjp.220.1648603501393; Tue, 29
 Mar 2022 18:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220324011126.1144504-1-alison.schofield@intel.com> <20220325103426.00003916@huawei.com>
In-Reply-To: <20220325103426.00003916@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 18:24:50 -0700
Message-ID: <CAPcyv4i36Mnza83Bg0+VfVfL_+84EK=Y6aGBa+MF4tQ32HP3AQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Do not allow set-partition immediate mode
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 25, 2022 at 3:34 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 23 Mar 2022 18:11:17 -0700
> alison.schofield@intel.com wrote:
>
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Blocking immediate mode in set-partition info triggered a
> > refactoring of the send path of userspace mailbox commands.
> >
> > The v1 to address the issue was a single patch [1] that inserted
> > a new immediate mode check in the send path where the payload was
> > available for examining. That was not in a validation function.
> >
> > The v2 patchset [2] added refactoring of the send path so that
> > validation work can all spawn from cxl_validate_cmd_from_user().
> >
> > Here, v3 offers a finer level of refactoring:
> >
> > Patches 1-7: Refactor existing code so that all validation work
> >       can spawn from cxl_validate_cmd_from_user().
> >
> >       The movement intends to cleanly rip the work of building a
> >       mailbox command away from handle_mailbox_command_from_user()
> >       and give it to cxl_validate_cmd_from_user().
>
> This makes me wonder a bit if
> cxl_validate_cmd_from_user() is an appropriate name given
> it now does more than validation?

Yeah, perhaps as a follow on, I think there's renaming possible to
make it clear what the difference is between:

cxl_send_cmd
cxl_mbox_send_cmd
cxl_pci_mbox_send
cxl_validate_cmd_from_user
handle_mailbox_cmd_from_user

---

cxl_send_cmd is really just a helper for the ioctl path so perhaps:
s/cxl_query_cmd/cxl_ioctl_query/
s/cxl_send_cmd/cxl_ioctl_send/

cxl_mbox_send_cmd() is the path that kernel-internal users take that
don't need to do any copy from user work to pass buffers to
cxl_pci_mbox_send() (which needs kernel buffers from
memcpy_{to,from}io()), so perhaps:
s/cxl_mbox_send_cmd/cxl_internal_cmd_send/

cxl_pci_mbox_send seems ok if the other function names change.

cxl_validate_cmd_from_user and handle_mailbox_cmd_from_user are really
doing three distinct operations. Check the payload for correctness,
check the command against the submit policy, and construct a kernel
command buffer from the user buffer. So how about:

cxl_ioctl_send_checks() (inspired by submit_bio_checks())
cxl_ioctl_send_to_kbuf()

...whatever we pick I think it's ok if this is done after this
reorganization completes with the current names.
