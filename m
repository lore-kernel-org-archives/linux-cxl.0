Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F672C2B9F4
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 22:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5257C611EE
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 22:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhFNWYz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Jun 2021 18:24:55 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:54886 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFNWYy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Jun 2021 18:24:54 -0400
Received: by mail-pj1-f45.google.com with SMTP id g24so10603037pji.4
        for <linux-cxl@vger.kernel.org>; Mon, 14 Jun 2021 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G87+cE2FafY405pDv0BorStPnXI94WkGlDMb6e0XQso=;
        b=hTnG7Yvfc8oN1htGLC4PGXOspgbxLUgHLMqopS1XPa/ddIXuJyB4ucuzjjrSADsI4E
         w6Y1OclrAkZDFwo9kJpKg3bmvCPvOC/IfW0/4SI04/JCBYTfZjqDXZsun8RdO1uhMSsy
         3KxXQbCmBggFOyChZfNYIHSA6yAx9KQe9HyIn7Ym45uIN7pFOqhkdmfpnuBb+Yyy8rtj
         r8SA2YK+7eCqiuQ3aqSL5Ab7Sq6hlQ0ekVmAVEsezWwmnlEGy3nV2rXlPL6QW42Ocdef
         39WhLjf3RWwSV+2/fQUm4U/sg07xUExOQC2KK4LKQ6BT25m3QBuQoWbnOzHBOBQdCPA2
         JqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G87+cE2FafY405pDv0BorStPnXI94WkGlDMb6e0XQso=;
        b=SYJp5Mt/IO61TSdgUfKYwhp3JAA7dg+SCPGO/bzQLBlZzsFys+TUtiVuvNojb4rTpl
         27C/xXr3vRTWbU7EctXtBMhfkR4Z+2ScuALM6C0Pj/xDen1qizDFAiAXrPrOpls04QjP
         IF7wCP1gX7p/GXKmcPY7GR+wlWBNJXgBr5TBYf5jGc4WIh1USfWrBTUmLRtNLJjCeudp
         U5A8XgXkja6WNBtuM/b01ju0oXj3JfFVfXwMvuktOT86aOW4ubaACmONVXtzNnBsWEIL
         JvXsVJZNIgXu3gml6AzOxLCVDNf2ZN4EcyDvqawlfaywsaFdNQst0hVgOwWFnFapDW6k
         p67Q==
X-Gm-Message-State: AOAM530nPSDH74/WIenky7DW9t4ICUwnkUEFBYnYzRlevJ9sFqMn8a6N
        Q3lc7iccdlt3TgcpJeLIbcFzqfGuUc2SQb06Kt9ecw==
X-Google-Smtp-Source: ABdhPJy+YZ3SlQTcJYwAV8/5+V8dsv2+g8tnS3MhV2wgvpG8daxblts2bOrPaBe0fQykhfD3IZQO9FvX5w36w71CFH8=
X-Received: by 2002:a17:902:b497:b029:115:e287:7b55 with SMTP id
 y23-20020a170902b497b0290115e2877b55mr1157058plr.79.1623709311287; Mon, 14
 Jun 2021 15:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210610185725.897541-1-ben.widawsky@intel.com>
 <CAPcyv4j=cFikFD_jrPwMfGuMbFZ+1DPUyQjYq7SqTYYauMxLOA@mail.gmail.com>
 <20210614161159.cqq64nbm5whzpud7@intel.com> <CAPcyv4gaxWDC9eN965VkbDv0W5QgBBP7Cg0RU74uE08OKSZVow@mail.gmail.com>
 <20210614215402.mxcwdv4wno6krm7w@intel.com>
In-Reply-To: <20210614215402.mxcwdv4wno6krm7w@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Jun 2021 15:21:40 -0700
Message-ID: <CAPcyv4iMFszSRic-5B8vqc3bc9yXudJHa1dv4L2P8vzc7BVqgQ@mail.gmail.com>
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

On Mon, Jun 14, 2021 at 2:54 PM Ben Widawsky <ben.widawsky@intel.com> wrote=
:
>
> On 21-06-14 14:04:32, Dan Williams wrote:
> > On Mon, Jun 14, 2021 at 9:12 AM Ben Widawsky <ben.widawsky@intel.com> w=
rote:
> > >
> > > On 21-06-11 17:44:02, Dan Williams wrote:
> > > > On Thu, Jun 10, 2021 at 11:58 AM Ben Widawsky <ben.widawsky@intel.c=
om> wrote:
> > > > >
> > > > > CXL interleave sets and non-interleave sets are described via reg=
ions. A region
> > > > > is specified in the CXL 2.0 specification and the purpose is to c=
reate a
> > > > > standardized way to preserve the region across reboots.
> > > > >
> > > > > Introduced here is the basic mechanism to create and configure an=
d delete a CXL
> > > > > region. Configuring a region simply means giving it a size, offse=
t within the
> > > > > CFMWS window, UUID, and a target list. Enabling/activating a regi=
on, which
> > > > > ultimately means programming the HDM decoders in the chain, is le=
ft for later
> > > > > work.
> > > > >
> > > > > The patches are only minimally tested so far in QEMU emulation an=
d so x1
> > > > > interleave is all that's supported.
> > > > >
> > > > > Here is a sample topology (also in patch #4)
> > > >
> > > > I'm just going to react to the attributes before looking at the
> > > > implementation to make sure we're level set.
> > > >
> > > > >
> > > > >     decoder1.0
> > > > >     =E2=94=9C=E2=94=80=E2=94=80 create_region
> > > > >     =E2=94=9C=E2=94=80=E2=94=80 delete_region
> > > > >     =E2=94=9C=E2=94=80=E2=94=80 devtype
> > > > >     =E2=94=9C=E2=94=80=E2=94=80 locked
> > > > >     =E2=94=9C=E2=94=80=E2=94=80 region1.0:0
> > > > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 offset
> > > >
> > > > Is this the region's offset relative to the next available free spa=
ce
> > > > in the parent decoder range? If this is output only I think it's ok=
,
> > > > but I think the address space allocation decision belongs to the
> > > > region driver at activation time. I.e. userspace does not have much=
 of
> > > > a chance at specifying this relative all the other dynamic operatio=
ns
> > > > that can be happening in the decoder.
> > > >
> > >
> > > This was my mistake. Offset will be determined by the driver and I in=
tend for
> > > this to be read-only.
> > >
> > > > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 size
> > > > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../..=
/../../../../bus/cxl
> > > > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 target0
> > > > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 uevent
> > > > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 uuid
> > > > >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 verify
> > > >
> > > > I don't understand the role of a standalone @verify attribute, ther=
e
> > > > is verification that can happen per attribute write, and there is
> > > > final verification that can happen at region bind time. Either way
> > > > anything verify would check is duplicated somewhere else, and the
> > > > verification per attribute update is more precise. For example writ=
es
> > > > to @size can check for free space in parent decoder and fail if
> > > > unavailable. Writes to targetX can fail if the memdev is not connec=
ted
> > > > to this decoder's port topology, or the memdev is out of decoder
> > > > resources. The final region bind will fail if mid-level switches ar=
e
> > > > lacking decoder resources, or would require changing a decoder
> > > > configuration that is pinned active.
> > >
> > > I strongly believe verification per attribute write will get too frag=
ile. I'm
> > > afraid it's going to require writing attributes in a specific order s=
o that we
> > > can do said verification in a sane way. We can skip that and just che=
ck it all
> > > on bind. Most of that logic is what would be contained in verify(), s=
o why not
> > > expose it for userspace that may want to test out various configs wit=
hout
> > > actually trying to bind?
> >
> > Because there's no harm in actually trying to bind. A verify attribute
> > is at best redundant, or I am otherwise not understanding the proposed
> > use case?
> >
>
> That's the use case. Though I don't consider it redundant. All bind() can=
 return
> is errnos + what you mention below (and following LWN link).
>
> > > Also, I like having ABI that helps userspace get details on the confi=
guration
> > > failure reason. You mention in the other reply, TRACE_EVENT. I suppos=
e userspace
> > > could use tracepoints, or scrape dmesg for this same info. Maybe it's=
 6 one way,
> > > a half dozen the other. I'd be interested to know if there are other =
examples of
> > > tracepoints being used by userspace in a way like this and what the e=
xperience
> > > is like.
> > >
> > > To summarize, I think we need an atomic way to do verification (which=
 obviously
> > > happens at bind()), and I think we need UAPI to get the configuration=
 error.
> >
> > I expect higher order configuration error reporting and non-atomic
> > pre-verification to come from user tooling.
>
> But isn't that just duplicating code that we have to have in the kernel a=
nyway?

It is, but it's less constrained. The kernel could only tell you yes
or no for a given region verification. The tooling can identify
tradeoffs and potential resource collisions across regions.

> > As for what the kernel can do at runtime in the absence of user tooling=
, or in
> > the development of more aware tooling has been debated in the past [1].=
 In
> > this case the entire decoder resource topology is visible in userspace,=
 an3d
> > while userspace can't atomically predict what will happen, it also does=
 not
> > need to because the admin should not be racing resource querying and re=
source
> > consumption if they want to get a reliable answer. The reason I recomme=
nded
> > TRACE_EVENT() rather than dev_dbg() is due to being able to filter even=
t
> > messages by cpu, pid, tid, uid... etc. Another approach I have seen ups=
tream
> > is to emit extra variables with a KOBJ_CHANGE event, but that is more a=
bout
> > event reporting than extra information about provisioning failure.
>
> Interesting. Thanks for the link, it looks like it never landed. I think =
trace
> makes a good deal of sense considering all the options. I'm not convinced=
 the
> interface is "at best redundant". I'll just drop verify(). I have no furt=
her
> arguments in favor and you don't sound convinced of the original ones.

My main concern is the atomicity of the verify response when two
agents are racing through the resource tree. The user tooling can
either explicitly coordinate with other user tooling, or the admin
could implicitly avoid races. When the races happen they will likely
be cases where bind() fails and verify() said everything was ok. In
those cases we'll still need a mechanism to understand why bind()
failed and by that time it seems everything verify() might have been
able to offer has been reimplemented for tracing bind().
