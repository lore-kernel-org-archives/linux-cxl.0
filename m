Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F73C48BE5
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 00:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA417613DF
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 00:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFLArM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 20:47:12 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:42687 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLArM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 20:47:12 -0400
Received: by mail-pj1-f50.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so6920968pjb.1
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 17:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XvwZamYBZ+pg9i1h6luyaCPXgSIWvxPmp47+/F+VErY=;
        b=t/f4BzhagdTZzCVUgi/NFbH0WsfL4l3JJzSlFlhh1dsK4zBuRSUE9bpPa5DAOUXOqB
         XN1tE8MhLjEHig9Rb90AC8b4ZoaregLtYVsYRdxHBNBhAwNovnHNdMfaXxBXFP+3W2gH
         KgWI39VEudR+/o2c3id//IWnPTtX/xgLkbxCeRAFmzK+3GRd5o7SrUkT3X/z5OJA43wg
         uZ9/I08gjdJ/devL9Fct3/Lxyk4kkiq1Ql9d4CvNYnRHFriL87Oh9qMTtYAIOsJ0WiaC
         EXTbKIAyevGn87J1YdCXorHdhknCMI2ceEJEUCdankTUbmMd4zEAxeFAgkzcWiZKgTBZ
         Tt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XvwZamYBZ+pg9i1h6luyaCPXgSIWvxPmp47+/F+VErY=;
        b=bB+UfaUXa97PPE7URBBpJERMqkpjYmlymJFedvZGc55SxRtXqMU/evBStcXxaM3X0w
         mDFRuWoDp0ViG7QQhPFkRl4orgQhmLX8Ui+D0aDCnpptby9Hanewf85uS88pSkDyXtn7
         Bsq8VmP6b6cxMJ9k7twGhv5c/6fay8UngJzXAEtM8XcafyBqrl8EDCfJFkI24MFi3Hz6
         rGfaJqsGcK/nU2ItWISMHKFXGiSNVzKKytc3JAlkhFJFO45Ajc1FOStrkoNm3FXVkWoD
         XdaER5QFeJe6xcGOpig7NLiDDLKK1f9CM/ierJIJbcvDQSmqjrf0KLEHE9aJ2vP0Th1U
         lfyw==
X-Gm-Message-State: AOAM532hedgnYVIGs7h+y3OX4rL4cs2j/i5gSHssU+KXhVxVPxkDXLEY
        J2Aos09Q0nT4WuUTmM0X1tSRxt+y4wg6lu2btNhVr6a028A=
X-Google-Smtp-Source: ABdhPJxfD1IDTQu22FJ6rWRoHfdULDiZ5H7Y03jYNm9yBTx6cfFE02EBMqQuDyiEXpswjidlegpE8v/Otlo4hVn7mAU=
X-Received: by 2002:a17:90a:ea8c:: with SMTP id h12mr11240746pjz.149.1623458653652;
 Fri, 11 Jun 2021 17:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210610185725.897541-1-ben.widawsky@intel.com>
In-Reply-To: <20210610185725.897541-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 17:44:02 -0700
Message-ID: <CAPcyv4j=cFikFD_jrPwMfGuMbFZ+1DPUyQjYq7SqTYYauMxLOA@mail.gmail.com>
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

On Thu, Jun 10, 2021 at 11:58 AM Ben Widawsky <ben.widawsky@intel.com> wrot=
e:
>
> CXL interleave sets and non-interleave sets are described via regions. A =
region
> is specified in the CXL 2.0 specification and the purpose is to create a
> standardized way to preserve the region across reboots.
>
> Introduced here is the basic mechanism to create and configure and delete=
 a CXL
> region. Configuring a region simply means giving it a size, offset within=
 the
> CFMWS window, UUID, and a target list. Enabling/activating a region, whic=
h
> ultimately means programming the HDM decoders in the chain, is left for l=
ater
> work.
>
> The patches are only minimally tested so far in QEMU emulation and so x1
> interleave is all that's supported.
>
> Here is a sample topology (also in patch #4)

I'm just going to react to the attributes before looking at the
implementation to make sure we're level set.

>
>     decoder1.0
>     =E2=94=9C=E2=94=80=E2=94=80 create_region
>     =E2=94=9C=E2=94=80=E2=94=80 delete_region
>     =E2=94=9C=E2=94=80=E2=94=80 devtype
>     =E2=94=9C=E2=94=80=E2=94=80 locked
>     =E2=94=9C=E2=94=80=E2=94=80 region1.0:0
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 offset

Is this the region's offset relative to the next available free space
in the parent decoder range? If this is output only I think it's ok,
but I think the address space allocation decision belongs to the
region driver at activation time. I.e. userspace does not have much of
a chance at specifying this relative all the other dynamic operations
that can be happening in the decoder.

>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 size
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../../.=
./../bus/cxl
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 target0
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 uevent
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 uuid
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 verify

I don't understand the role of a standalone @verify attribute, there
is verification that can happen per attribute write, and there is
final verification that can happen at region bind time. Either way
anything verify would check is duplicated somewhere else, and the
verification per attribute update is more precise. For example writes
to @size can check for free space in parent decoder and fail if
unavailable. Writes to targetX can fail if the memdev is not connected
to this decoder's port topology, or the memdev is out of decoder
resources. The final region bind will fail if mid-level switches are
lacking decoder resources, or would require changing a decoder
configuration that is pinned active.
