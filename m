Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE8C433EF
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 19:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EC760FBF
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 19:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhJaTa2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJaTa1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 31 Oct 2021 15:30:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FDEC061570
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 12:27:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so7731566pjc.4
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AG6x958ihkGmkGyGaMPgYDReIqx9xThmJrjlyjicqzk=;
        b=NO6vaom+MC93iCbQLbhE5Rch8PnhPLuQ7hXKDB2armceJrMpumkDMP4z2etAVRNhre
         PWQYAw3xHfL90+oueI4slzKgRNVzMZntQMsif0dQXbQC92EH9xRxq3AnjdlZ2LzmIUA+
         rH/0x+jM2XV0nDxjFSO5LWYNMvyGRr/fXVQbPiCARFF0dxUZ8I5L0UOdmxj71FlA3FR8
         K7LmxaXV5LsSaTdZ2lcg0DYEZp0V0dpI4lDCSYLn6OTP7x4QBsoLThSBo5oIK+OeYUrP
         kEJeOMrJ2nsAzNsOEZRfwGp34Bjg9u7hdLP4onzLhqANCn21OC15yQJ8XxqcYKWHDwF+
         4tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AG6x958ihkGmkGyGaMPgYDReIqx9xThmJrjlyjicqzk=;
        b=DzR7BcfYoS2ZDfPGoOTJmk6yvOUKGjb9Ha9slaG36VldVnKhArxsCIRpqTQBwdqvaZ
         8+V54w70ILqO7/zNziUR/Y/Ko3MYhNUJwukcWFooAnztCH2bmfKYToO9JneHend3T0rp
         gRpM8yj+IwMsltCPkuwXEmLOJeKxN50tXy+CoLTLxHXbsL5PR12kIaaftcdXlBdaMic3
         Ij1Y/E345z9ZGC1DMFB6w8q71ZqmAqHkT/D28dqLkkGuFN+CJvrsni0cf57Ykiq0ES0h
         cyzq93tN0ftGzveIStZvjs1LzCXEncZvCZMUk6hSAwrriGSohvFBK4i7tx+psmZCeUmE
         +9yA==
X-Gm-Message-State: AOAM530EteJTCVEGJDFSdBmmTcgRTH39DjL5LkFof+yHD/new71y81A6
        9SBtM41HFuUZYo8JmKzgU+sUqo6HBDoka+F8qOSlTexFgp4=
X-Google-Smtp-Source: ABdhPJy/KVStscMLNQR0+az3iMaIU0GXQrXgDuDV0JZnJzUIh+Bdl9cygQZtP3ElFT0hoPC3WE2xuAJ1BbdW1O4uuxk=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr33197521pjp.8.1635708475458;
 Sun, 31 Oct 2021 12:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <163553734757.2509761.3305231863616785470.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211031185831.4gtasmqiqdf3zkv3@intel.com>
In-Reply-To: <20211031185831.4gtasmqiqdf3zkv3@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 12:27:45 -0700
Message-ID: <CAPcyv4jWTnbiCndyHmCREtF=pk0eDdAL97hQMFCVdJ4WPGz7kQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/pmem: Fix reference counting for delayed work
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Oct 31, 2021 at 11:58 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-29 12:55:47, Dan Williams wrote:
> > There is a potential race between queue_work() returning and the
> > queued-work running that could result in put_device() running before
> > get_device(). Introduce the cxl_nvdimm_bridge_state_work() helper that
> > takes the reference unconditionally, but drops it if no new work was
> > queued, to keep the references balanced.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Arguably fixes/stable?

Whoops, yes, definitely needs a Fixes:. A stable cc is debatable, but
if autosel picked up this fix I wouldn't say no, so might as well cc
stable upfront.

> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

Thanks!
