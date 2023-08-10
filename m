Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D5BC04FDF
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Aug 2023 16:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjHJQl0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjHJQlB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 12:41:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD44A8
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 09:41:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe655796faso1729220e87.2
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691685659; x=1692290459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ca3TZndavt4jIZhjML9ZUNghyRq+9cHaQAL0Og1JAs=;
        b=XdBD/f5HTJtz3+ukrnX5G0blFyX7X4dhYV8nqQFdWX2qVmUPe4r/W1DDuaPCRisFNX
         SXhPqLQxMGn+gMMhDQN+canO1j7s8klx8DeLi31iOEna00YwuOO/SWb6XEZT/wBnubnm
         QDcN9P7ej6rkirPak4mfZ0iapiYh4uTsP32M6iwCWLGr3TuVPQpdgBekix+JBhyKKnZr
         Rj8Ou5/sfFV5aw8wtuvS18MoAaU0oHUWx3P0fgBLULXf8CTq+gOJd+TSnYS6Pvi3YPTn
         lNxfS6eIf4ZVUB7x1acv6cJDbozsmzFVSTuvnF4Yme+fWr6x37Z2v//aUlBeAYgxpVQ0
         bl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685659; x=1692290459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ca3TZndavt4jIZhjML9ZUNghyRq+9cHaQAL0Og1JAs=;
        b=dBjjZICFpKwn9qQiy022gFJmbSophlt1p5iQWYO9bhR7dIYr1rAzIT08tr3AO5phPv
         MTAnGy318I0P4rnPQmtVkIu31ly8I36bEUHoPMHECKCCq4cx5zVzze5KlDsTLmICKwGd
         jasgUoQFBrW3v+pJ/RaNT0t+nsViMe4hbNpQLL/OsMNR3aD0GYpDIiVXe4lNYfEWN5BY
         O9tfVRGZ+j9zs7s4IaS+Pp9/oz0r5YzJS+G9l5Ym4qIPt2jRlJybzHKUy1W6Z/Z8aCP/
         MQafE/td92y7de43y0cNxX2ey0qDA7Liowff92lHPfObgud2jd9AITJQQQB5w8sKlosl
         E7Fg==
X-Gm-Message-State: AOJu0YwWdOzrF3YoTzXMYzkDf2YiCkmNbrHz01UZmDEbLW3cN0kyFOrW
        8Y1HGXWRSPs9jCM7g0+GbM75w7XSoeWog2AryT9JH8Ub
X-Google-Smtp-Source: AGHT+IHrGl+RJB879F/qdJ2R6Joc7OWzKdqySFPxgFOUamdDu2UZk2Vm4toiP2tULpWMr63mXp3dTC8UdaGI6TXW3Fw=
X-Received: by 2002:ac2:4d8f:0:b0:4f8:5717:e421 with SMTP id
 g15-20020ac24d8f000000b004f85717e421mr1985305lfe.40.1691685659093; Thu, 10
 Aug 2023 09:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
 <20230810173322.0000543c@Huawei.com>
In-Reply-To: <20230810173322.0000543c@Huawei.com>
From:   Ravi Kanth <mvrravikanth@gmail.com>
Date:   Thu, 10 Aug 2023 22:10:48 +0530
Message-ID: <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks Jonathan for pointing this out. I will definitely take a look
at this. Current support for the simulation of CCI mailbox is only via
MCTP messages or even via CXL driver IOCTLs?

Ravi

On Thu, Aug 10, 2023 at 10:03=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 10 Aug 2023 21:42:12 +0530
> Ravi Kanth <mvrravikanth@gmail.com> wrote:
>
> > Hello,
>
> Hi Ravi,
>
> >
> > I am writing this mail to know if the latest QEMU has support for CXL
> > spec v3.0? I understand from the older tutorials that QEMU has support
> > for CXL v2.0. Is there any update to QEMU to support the CXL v3.0? I
> > would like to specifically test the CCI mailbox functionality which
> > has been added to CXL v3.0 spec.
>
> The nature of the CXL specification and the QEMU support is that for
> devices there isn't a clear divide between different generations of
> the specification. By that I mean, that a device based on the CXL 2.0
> specification is compatible with the CXL 3.0 specification. As such,
> the QEMU emulation has focused on features of interest - it is a far
> from complete implementation of all the options in the CXL 2.0
> specification but conversely there are some parts of CXL 3.0 are supporte=
d.
>
> Note that the particular CCI functionality is not yet ready for CXL upstr=
eam,
> but we do have some support in the staging tree I maintain.
>
> https://gitlab.com/jic23/qemu/-/commits/cxl-2023-08-07/
> specifically
> https://gitlab.com/jic23/qemu/-/commit/2eb7e6402a45b359c304cea894a1d27625=
a4b80c
>
> Note at this stage we only support subset of commands.
> Contributions of more support welcomed!
>
> Intent of the current support and related MCTP CCI access (over I2C) is
> to enable ecosystem development, particularly of fabric managers.
> For that a tiny subset of commands was sufficient to be sure the architec=
ture
> inside QEMU worked and that the proposed kernel code functions correctly.
>
> Jonathan
>
> >
> > Thank you in advance for your assistance.
> >
> > Ravi
>


--=20
Regards
M.V.R.Ravi Kanth
