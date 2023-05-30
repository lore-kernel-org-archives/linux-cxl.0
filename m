Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB0FC77B73
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 21:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjE3V5S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 17:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjE3V5Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 17:57:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E8102
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 14:57:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so7492209a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685483833; x=1688075833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dRXUhZqAXtIVu5pGmKLHh9adzhr/kFGdlVLQd625Qs=;
        b=ZsdehW9Pfs8WHcCJwuE3zxa378WBg+oybGabkQ195uuuUAZoBT8u29asveo67MNpTb
         2XjJv8vqpftIxKkzY5dUZ8ogbRp6//OC2Fvnn2kioXs2pGtgD5R8O7p7uzFLg5DhcmqT
         ulZhprjbhaEFPxQetuZHPx2LEXYwNfZl2GD/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483833; x=1688075833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dRXUhZqAXtIVu5pGmKLHh9adzhr/kFGdlVLQd625Qs=;
        b=EVoVESlKWzaHdlOYbxc0jhT5m7S0lbAHx6hmXcOkOwfA87QGfDbAMfimoetldmh/aa
         Sj1aEAF9Yi3Zc83WYRMeGGLUFduzugrgu82hDi42Vc6az0lAsfdChdYHm+eWtUwf8LmZ
         Wo5DauWTTUa5RwmXPn429V8kt8qMTK0VkeqW0Fo1cz/fIxgYloeIeqMbA39Uz2mReEQP
         5mOZt4IbNRe0chzKEtEdCfk+GG+nzW8nUJrGWYCQsXEzG3M3ARe2GL/3kMCjw9RnBt58
         zeFxlxWItur2vrFMBP4yNmues0egI2XrCt03EAz4Ks7f48mZtej/WXPQFxQLLG82UDND
         DfRA==
X-Gm-Message-State: AC+VfDxAohEpY+iw0gMFDQ3aty/yXO/DuHD/WB3QxQx8GD4kpQKWdh2u
        5SbYkN5S5qKmLqQ14wVkqfxWuDrTL5gCkmeZLv8J3beM
X-Google-Smtp-Source: ACHHUZ4a9YJH7m10ODOSxIBLMQEsMP4YIiUsMOSCH+t3VnghgZMIUCHifhzoRpezyieDdmG/r/O3xg==
X-Received: by 2002:aa7:c157:0:b0:514:9d17:d6ef with SMTP id r23-20020aa7c157000000b005149d17d6efmr2687711edp.13.1685483833735;
        Tue, 30 May 2023 14:57:13 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id d25-20020a50fb19000000b0050cc4461fc5sm4770110edq.92.2023.05.30.14.57.12
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 14:57:13 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-96f50e26b8bso917910066b.2
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 14:57:12 -0700 (PDT)
X-Received: by 2002:a17:907:5c8:b0:966:53b1:b32a with SMTP id
 wg8-20020a17090705c800b0096653b1b32amr2872578ejb.53.1685483832618; Tue, 30
 May 2023 14:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
 <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 May 2023 17:56:55 -0400
X-Gmail-Original-Message-ID: <CAHk-=whWJFw8+HP=0-ZaQYq2VVPtv1StFhUxgiJW1_FWdtgJSA@mail.gmail.com>
Message-ID: <CAHk-=whWJFw8+HP=0-ZaQYq2VVPtv1StFhUxgiJW1_FWdtgJSA@mail.gmail.com>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, May 30, 2023 at 5:43=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> [ add linux-cxl ]
>
> Sedat Dilek wrote:
> > Hi,
> >
> > after building Linux v6.4-rc4 I can NOT boot into my Debian GNU/Linux
> > AMD64 system with root-ext4 (/dev/sdc2 - of course using UUID in
> > /etc/fstab).
>
> I did not find a mailing-list thread for "9828ed3f695a module: error out =
early
> on concurrent load of the same module file", so replying here.

It is this thread:

   https://lore.kernel.org/lkml/20230524213620.3509138-1-mcgrof@kernel.org/

which initially proposed a different solution, then that "just reject
concurrent loads", and after that caused problems, there's yet another
proposal at

   https://lore.kernel.org/lkml/CAHk-=3Dwg7ihygotpO9x5a6QJO5oAom9o91=3D=3DL=
_Kx-gUHvRYuXiQ@mail.gmail.com/

although if you want to try out that approach, Johan pointed out a
missing initialization of a spinlock in that patch in a reply there.

> Just wanted to highlight this a test case for the next attempt at this
> fix.

See above: the next attempt won't be until 6.5, but if you saw the
failure on your test-cases, it might be a good idea to check out that
next attempt early..

               Linus
