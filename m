Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76662C7619A
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDKSRM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDKSQx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 14:16:53 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C85276
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 11:16:52 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5491fa028adso497240087b3.10
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681237011; x=1683829011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7rx3MgpBWYFSw0IirP1+4MZNl+aKRUmf8h7Qo2lJm8=;
        b=S3112uF+4GQy7gKSiXJxNvtx2OI4It5Ba8y7K6Zlh2IZg7chsB4d1xXVoKrIYqk/Cm
         53QdztjZKBzFZR5lL6R2hzkrWMcf49kvC2lxDKEgzs94VBOcWPDG0HQZ/Iwz7W+wZv8X
         fH36ODJlGH+FswwmMEG2CMrOmnwDkdfy1JL2zv4eMVqPpTvzXB28yYKcJqJE/45Vu0Ql
         pe77Q95qrnrgWWXNwpMy8XWxP+YZUDa/93vHsPA559ME3U4eGLXa78rw9z0k3ZLKQ6pi
         QN2J9vLArOFXqQxgKCOd9n0UcW2SN1oMtkxJaxOO0KK+bqP8e35WWNAxeQSpoPlCpUp7
         IZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681237011; x=1683829011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7rx3MgpBWYFSw0IirP1+4MZNl+aKRUmf8h7Qo2lJm8=;
        b=xxu9oZjCNC7O+DKn7jP5YHh5Ij0OJWKyce2fzdurRReHpbzMEdMuUUFGzntM0vBZes
         WS/mqqEyg/4iix5PmIAi9d+b7wfzv+SiccLEl6YmQkTPBCUyfteqM52opeDv/ftqsX9J
         FSFz+UCkY3Pw6zyEyX+xF5qYiHAjPq4mQJJ0i3Ss24snG7bEJmZLUoPD91KyRtZDbl3H
         cpYM4MXoazq/4r2KRzxM/Vr4+qgKHwZDz32oKLvfxoxvGVal9HwPwCKP4lsi+btOfrN+
         5tLWUPEpTyv7YBGUbqPRzgMXffB5kRblcZbWYvsATgBZQSlNkGH2vWgb1eFPNNZPaoc2
         PDMA==
X-Gm-Message-State: AAQBX9fJnZEoLGX7qGc+L4B2xNXoI7/VU41OoY02JG15PVIAIDVLOkQS
        k7rn11UZxZE8G86xnHHiF0QYbMy0Gz9KoufAiOI=
X-Google-Smtp-Source: AKy350bk2xxu1tDGXhk5Y8qSXEyqsuZLUfelqtG8xI5ro+bRGOPOOTZ5RlCWKatjpuuotajOsg3SOGxmjxwAPjijamo=
X-Received: by 2002:a81:aa14:0:b0:54f:2ad:91c5 with SMTP id
 i20-20020a81aa14000000b0054f02ad91c5mr5288660ywh.3.1681237011487; Tue, 11 Apr
 2023 11:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
In-Reply-To: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
From:   RAGHU H <raghuhack78@gmail.com>
Date:   Tue, 11 Apr 2023 23:46:40 +0530
Message-ID: <CAGWUp4rVEeUCwyuAc5LqgSbr_SVv4oNGy6vVdNDB+5vrH5AYVw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BLSF=2FMM=2FBPF_TOPIC=5D_BoF_VM_live_migration_over_CX?=
        =?UTF-8?Q?L_memory=E2=80=8B?=
To:     Dragan Stancevic <dragan@stancevic.com>
Cc:     lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Dragan

Please add me to the discussion!

Regards
Raghu

On Sat, Apr 8, 2023 at 2:56=E2=80=AFAM Dragan Stancevic <dragan@stancevic.c=
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
>
>
> [1]. High-level overview available at http://nil-migration.org/
> [2]. Based on CXL spec 3.0
>
> --
> Peace can only come as a natural consequence
> of universal enlightenment -Dr. Nikola Tesla
