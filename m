Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87B0C6FD1D
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Apr 2023 22:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDGWYD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Apr 2023 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDGWYC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Apr 2023 18:24:02 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03C1A5CB
        for <linux-cxl@vger.kernel.org>; Fri,  7 Apr 2023 15:24:01 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a13so30682ybl.11
        for <linux-cxl@vger.kernel.org>; Fri, 07 Apr 2023 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680906241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bvf3MWEQMEfK9l+qtvdnMnbC3l5JejEx7dkk53z/8TE=;
        b=GuEyeS5RXgO1+6zaEPKjGBshS8EnNlWBiytCcVT5bJZ3A7+kk4+kn7i05PVMB0aaL+
         FKYUwu5mmQZUwQ8lduZMhNDfwjXE7W0338LNK/ChXuUqnsEGG1RiKdVXF1mmNtMkaxEZ
         D0+Cj/XKI1wQcChiuUjmAsfFn/8xgsvsDW00OAEteCJQ5prmfNVqm2OIQfupsI0Xtv0C
         lqNa6ijlmNjMFWwJQFLrvonXWasGSanie09BqspDxwSWabzyaAhTjsCQgdyJFq7CtL7V
         4TTGcb88TwLFS6ZsR5M6VEKDIPRyjtpLjCeVgzABEapUQGuKRlazK/2QZmBBVTFJ2VYQ
         EKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680906241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bvf3MWEQMEfK9l+qtvdnMnbC3l5JejEx7dkk53z/8TE=;
        b=ysMeZ2MGuE4JX27TmlyKPMZiIZS2ieV/Z8uLXZXMmWzC6hcbph04AGwDeB+6FDxSe9
         PJhYXQpNHZwj2sPbTG54xGmPPuafDqo2ltZEN/o5qFZKVVfAeG1UgRkWcNgwJQ7nn0NB
         c4aepK7cbimiuykBub108betGJMbkV9FHW5qJhv+2h/oOkUQsVtaSpvXHzMMLGNioLzG
         k6Oit2O3YVdMTfB0lJ7oumQwckSuP3X2Pj8vgmmxQZgXNSi7O6h4eUyqjHKSHIaagIIs
         NWk8iI9ylQqaGj2CraCbeRqQSU+GoRDZO/T5jeBhX2TCckoo5DNFjQiCDtUMkhs+itL3
         kkWw==
X-Gm-Message-State: AAQBX9fHhZS9xyPujaqONflyx3lMj8FJaJyf+opyQHkKoyP12q9wpc3M
        z+4TgjC9tPhHJ8mxvVy7jP1rzhZmPkPFf/1x7BTILA==
X-Google-Smtp-Source: AKy350Y6Rkpcq75A5segkxblbg32RhYnioBKRTfMOHFt/eNpONDcF4WQ1RsCHQ8O7pehwaVni+1xlgj59i7JK4mJosE=
X-Received: by 2002:a25:cad1:0:b0:b78:4788:525b with SMTP id
 a200-20020a25cad1000000b00b784788525bmr2649501ybg.0.1680906240805; Fri, 07
 Apr 2023 15:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
In-Reply-To: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 7 Apr 2023 18:23:24 -0400
Message-ID: <CADrL8HXLEd8PsCn0y7hfFNsGPoV8nyXokL-_wmmXE=TuV6ML=g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BLSF=2FMM=2FBPF_TOPIC=5D_BoF_VM_live_migration_over_CX?=
        =?UTF-8?Q?L_memory=E2=80=8B?=
To:     Dragan Stancevic <dragan@stancevic.com>
Cc:     lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 7, 2023 at 5:05=E2=80=AFPM Dragan Stancevic <dragan@stancevic.c=
om> wrote:
>
> Hi folks-
>
> if it's not too late for the schedule...
>
> I am starting to tackle VM live migration and hypervisor clustering over
> switched CXL memory[1][2], intended for cloud virtualization types of loa=
ds.
>
> I'd be interested in doing a small BoF session with some slides and get
> into a discussion/brainstorming with other people that deal with VM/LM
> cloud loads. Among other things to discuss would be page migrations over
> switched CXL memory, shared in-memory ABI to allow VM hand-off between
> hypervisors, etc...
>
> A few of us discussed some of this under the ZONE_XMEM thread, but I
> figured it might be better to start a separate thread.
>
> If there is interested, thank you.

Hi Dragan,

Thanks for bringing up this topic. I'd be very interested to be part
of this BoF, as I'm also interested in using CXL.mem as a live
migration mechanism.

- James

>
>
> [1]. High-level overview available at http://nil-migration.org/
> [2]. Based on CXL spec 3.0
>
> --
> Peace can only come as a natural consequence
> of universal enlightenment -Dr. Nikola Tesla
>
