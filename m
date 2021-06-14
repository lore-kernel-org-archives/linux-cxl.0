Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE0AC2B9F4
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 21:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFAE611C0
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 21:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhFNVGs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhFNVGs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Jun 2021 17:06:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F655C061574
        for <linux-cxl@vger.kernel.org>; Mon, 14 Jun 2021 14:04:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i34so9683545pgl.9
        for <linux-cxl@vger.kernel.org>; Mon, 14 Jun 2021 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z/WfRz79Tiro41OkU9roOy0uWsdC8Eo2NGOeA/3ZRnk=;
        b=kYgOONWywddzW1PsBs/8b3YGY3bV9pRZDAQLLIOz9FlK3AtbQW44JhvHxes8a4H1ED
         xf+6Ddjn7Hjh1j5ZUhR3zY+LBgy7tgOWPFunUKfm+8en8qk6DJyR5DQ82gwnylkDvZMm
         24B0evQHOApXeq8Y+xcjIG6oJOq87oi3gkcVUi7qlPU0pF2WIWeYYp/TFklC0XoYcifH
         PrcrHufYBSHyPnj2YSJQ7aWyhOeZE/JFx/zqxdUQC64WrnZAzr2jSUZw+TuN+BbD0ksc
         rSxCSneJYCQGOPRsqq93YA3+v18w+ZqFmp9J8LMa0gxX2lKANnMUcb4b3Fx7EY0rjfWF
         6qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z/WfRz79Tiro41OkU9roOy0uWsdC8Eo2NGOeA/3ZRnk=;
        b=GUZ+6mCPR6cZyBc1vETBRY41SbLRQldgh49Z/d4Ja58S9GH9PYCH6aAdxh/r24BQNc
         yvb0DOL85uU8P9N1zV2L4gkpxBKXoLNM6nDl8+9YRUWg7r8m0QdKXdI2MYN6Qg9YVwug
         MdzfgzAeWl9n5rQFLElhqm2uwSFl7JiuQEJQOXe3nYnY2nnuDcJMpYxBmiy+O5T1nWeq
         glYtsXmP6XIC39b/foqatl5Jbb9DHT4YFil7wqTQciB59MsmtX8Pd45C08F6GzkSw/5k
         /yzjFt3JIm8muMRZosAdxH5O60ONFNHkoa/Cx95tmkjceC68cmx9ION4UZxspBnxPAx7
         u5cA==
X-Gm-Message-State: AOAM533TgM9yM18ZeNQIFOhm0l52fBTWtb1pyuuge8bviKCV79LpvUc1
        IhxHTQhyAqB26cz0US/1b0f1uywunnwBFl27Vu9u1Q==
X-Google-Smtp-Source: ABdhPJx5BpkN6TjLG2kyO1yRMwb1Z+gq5ZWUVO6CSX12pxmb9TtncPVIES7BssUyFmHZR699xSYovraRWu0LJ303Zpk=
X-Received: by 2002:a62:8647:0:b029:2c4:b8d6:843 with SMTP id
 x68-20020a6286470000b02902c4b8d60843mr842526pfd.71.1623704684062; Mon, 14 Jun
 2021 14:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210610185725.897541-1-ben.widawsky@intel.com>
 <CAPcyv4j=cFikFD_jrPwMfGuMbFZ+1DPUyQjYq7SqTYYauMxLOA@mail.gmail.com> <20210614161159.cqq64nbm5whzpud7@intel.com>
In-Reply-To: <20210614161159.cqq64nbm5whzpud7@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Jun 2021 14:04:32 -0700
Message-ID: <CAPcyv4gaxWDC9eN965VkbDv0W5QgBBP7Cg0RU74uE08OKSZVow@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Region Creation
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jun 14, 2021 at 9:12 AM Ben Widawsky <ben.widawsky@intel.com> wrote=
:
>
> On 21-06-11 17:44:02, Dan Williams wrote:
> > On Thu, Jun 10, 2021 at 11:58 AM Ben Widawsky <ben.widawsky@intel.com> =
wrote:
> > >
> > > CXL interleave sets and non-interleave sets are described via regions=
. A region
> > > is specified in the CXL 2.0 specification and the purpose is to creat=
e a
> > > standardized way to preserve the region across reboots.
> > >
> > > Introduced here is the basic mechanism to create and configure and de=
lete a CXL
> > > region. Configuring a region simply means giving it a size, offset wi=
thin the
> > > CFMWS window, UUID, and a target list. Enabling/activating a region, =
which
> > > ultimately means programming the HDM decoders in the chain, is left f=
or later
> > > work.
> > >
> > > The patches are only minimally tested so far in QEMU emulation and so=
 x1
> > > interleave is all that's supported.
> > >
> > > Here is a sample topology (also in patch #4)
> >
> > I'm just going to react to the attributes before looking at the
> > implementation to make sure we're level set.
> >
> > >
> > >     decoder1.0
> > >     =E2=94=9C=E2=94=80=E2=94=80 create_region
> > >     =E2=94=9C=E2=94=80=E2=94=80 delete_region
> > >     =E2=94=9C=E2=94=80=E2=94=80 devtype
> > >     =E2=94=9C=E2=94=80=E2=94=80 locked
> > >     =E2=94=9C=E2=94=80=E2=94=80 region1.0:0
> > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 offset
> >
> > Is this the region's offset relative to the next available free space
> > in the parent decoder range? If this is output only I think it's ok,
> > but I think the address space allocation decision belongs to the
> > region driver at activation time. I.e. userspace does not have much of
> > a chance at specifying this relative all the other dynamic operations
> > that can be happening in the decoder.
> >
>
> This was my mistake. Offset will be determined by the driver and I intend=
 for
> this to be read-only.
>
> > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 size
> > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../=
../../../bus/cxl
> > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 target0
> > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 uevent
> > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 uuid
> > >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 verify
> >
> > I don't understand the role of a standalone @verify attribute, there
> > is verification that can happen per attribute write, and there is
> > final verification that can happen at region bind time. Either way
> > anything verify would check is duplicated somewhere else, and the
> > verification per attribute update is more precise. For example writes
> > to @size can check for free space in parent decoder and fail if
> > unavailable. Writes to targetX can fail if the memdev is not connected
> > to this decoder's port topology, or the memdev is out of decoder
> > resources. The final region bind will fail if mid-level switches are
> > lacking decoder resources, or would require changing a decoder
> > configuration that is pinned active.
>
> I strongly believe verification per attribute write will get too fragile.=
 I'm
> afraid it's going to require writing attributes in a specific order so th=
at we
> can do said verification in a sane way. We can skip that and just check i=
t all
> on bind. Most of that logic is what would be contained in verify(), so wh=
y not
> expose it for userspace that may want to test out various configs without
> actually trying to bind?

Because there's no harm in actually trying to bind. A verify attribute
is at best redundant, or I am otherwise not understanding the proposed
use case?

> Also, I like having ABI that helps userspace get details on the configura=
tion
> failure reason. You mention in the other reply, TRACE_EVENT. I suppose us=
erspace
> could use tracepoints, or scrape dmesg for this same info. Maybe it's 6 o=
ne way,
> a half dozen the other. I'd be interested to know if there are other exam=
ples of
> tracepoints being used by userspace in a way like this and what the exper=
ience
> is like.
>
> To summarize, I think we need an atomic way to do verification (which obv=
iously
> happens at bind()), and I think we need UAPI to get the configuration err=
or.

I expect higher order configuration error reporting and non-atomic
pre-verification to come from user tooling. As for what the kernel can
do at runtime in the absence of user tooling, or in the development of
more aware tooling has been debated in the past [1]. In this case the
entire decoder resource topology is visible in userspace, and while
userspace can't atomically predict what will happen, it also does not
need to because the admin should not be racing resource querying and
resource consumption if they want to get a reliable answer. The reason
I recommended TRACE_EVENT() rather than dev_dbg() is due to being able
to filter event messages by cpu, pid, tid, uid... etc. Another
approach I have seen upstream is to emit extra variables with a
KOBJ_CHANGE event, but that is more about event reporting than extra
information about provisioning failure.

[1]: https://lwn.net/Articles/657341/
