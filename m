Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9DAC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 20:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F6D60F9E
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 20:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhJNU5a (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhJNU52 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Oct 2021 16:57:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96334C061570
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 13:55:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s136so3378458pgs.4
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6fHiB47awPBWpjFYDqA/6sfMb3K3z3+8/CcbFBsGHI=;
        b=z+dc1lD2rCPqp9dY1vRI1BcMA5swqStK3Jc9skl3pu8pXGjExhuTmsSnJoixAFJYwK
         mzXBINPS8zqL37XEHf12KWwlHmc0LFPwC23UhSgPALZj6lqisrKpydoXpfxfp7JcmVf/
         Bxn1usbFH3iCJUDZqhglS3W/wzXb8+nbkocTOWsgBk/UILmhnuA7sw4KoJDFvXo0S5ij
         yLncVzp4BkJAcg/X9R0uVKnlzROYcgLtcvoOSUhJW2aFKaTJmtqOCopFniH5hRP1NMe0
         XAqyPh8mkSxkfUNmlymxARAEiyW6iQAhSmxJX72ABuI+vnbdWdg8FdrqJI+mOWqZA1lR
         FXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6fHiB47awPBWpjFYDqA/6sfMb3K3z3+8/CcbFBsGHI=;
        b=UVJvGYivAE3WnSJlMPQOTJUaJMtZ0A/aB+ANCJzGUjuxTMcY+MgPzXyUjLPc/UfvxQ
         AQUfLr2pqLJbB0VDhoF4uKzxwCCKuhpow3lPci381GSW9Sxmq++BOiyqjgxG2EL6ZXeq
         j9aUCMrXaYtEN8xSGnQ6Y2L1VCEYnbwFWwJgkLwQMWsfKBmt4OMzd5NrU6yL2yjDQWF9
         F4WP8+BCSYVHjqMQLxL9WD7ql1ixiKqVCvwQ4qH9Uo2ico5DU3YKvbkXqBthcmzatXa0
         NPQmHpHygg1bx2E3+cnhxrM6R1oEAm8QbcXO52COtrTrJvIqIxK4v44bj3Wy9ph/vb7s
         +WOA==
X-Gm-Message-State: AOAM533gGt3C4T4Y2DG4kLzjLeCZDTapU/eTvBm8IE7sMOzjIx6aBzE+
        4sfeVwGstnaStXf8sJjJtJKuBlTHYsU2uyFaHRs719Nuo+k=
X-Google-Smtp-Source: ABdhPJzM1DWVNxD1uRudT3AkakCCLUnpWkVPRgBmjVO89BHBfhak2/W8hXh7t9YEtPAvuE3NumnVu2XMqDtTCI1yi+w=
X-Received: by 2002:a63:d709:: with SMTP id d9mr5817363pgg.377.1634244923089;
 Thu, 14 Oct 2021 13:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com>
 <20211007082139.3088615-9-vishal.l.verma@intel.com> <CAPcyv4gMdTWPbLSo2+E6JzOzaf8soTwd+nzpBgcEZ-41BRJ63A@mail.gmail.com>
 <37ca5a878f72742bd85aba7989383a985e1666b2.camel@intel.com>
In-Reply-To: <37ca5a878f72742bd85aba7989383a985e1666b2.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 13:55:12 -0700
Message-ID: <CAPcyv4j5kYEbX_Zn2_5=J5h933e_W4vKbV7Th8RC5H4qy3r9Kg@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 08/17] libcxl: add support for the 'GET_LSA' command
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 14, 2021 at 1:06 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Thu, 2021-10-14 at 09:35 -0700, Dan Williams wrote:
> > On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > >
> > > Add a command allocator and accessor APIs for the 'GET_LSA' mailbox
> > > command.
> > >
> > > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > ---
> > >  cxl/lib/private.h  |  5 +++++
> > >  cxl/lib/libcxl.c   | 36 ++++++++++++++++++++++++++++++++++++
> > >  cxl/libcxl.h       |  7 +++----
> > >  cxl/lib/libcxl.sym |  4 ++--
> > >  4 files changed, 46 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> > > index f76b518..9c6317b 100644
> > > --- a/cxl/lib/private.h
> > > +++ b/cxl/lib/private.h
> > > @@ -73,6 +73,11 @@ struct cxl_cmd_identify {
> > >         u8 qos_telemetry_caps;
> > >  } __attribute__((packed));
> > >
> > > +struct cxl_cmd_get_lsa_in {
> > > +       le32 offset;
> > > +       le32 length;
> > > +} __attribute__((packed));
> > > +
> > >  struct cxl_cmd_get_health_info {
> > >         u8 health_status;
> > >         u8 media_status;
> > > diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> > > index 413be9c..33cc462 100644
> > > --- a/cxl/lib/libcxl.c
> > > +++ b/cxl/lib/libcxl.c
> > > @@ -1028,6 +1028,42 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
> > >         return cmd;
> > >  }
> > >
> > > +CXL_EXPORT struct cxl_cmd *cxl_cmd_new_read_label(struct cxl_memdev *memdev,
> > > +               unsigned int offset, unsigned int length)
> > > +{
> > > +       struct cxl_cmd_get_lsa_in *get_lsa;
> > > +       struct cxl_cmd *cmd;
> > > +
> > > +       cmd = cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_GET_LSA);
> > > +       if (!cmd)
> > > +               return NULL;
> > > +
> > > +       get_lsa = (void *)cmd->send_cmd->in.payload;
> >
> > Any reason that @payload is not already a 'void *' to avoid this casting?
>
> The send_cmd is part of the uapi which defined it as __u64.

Ah, got it.
