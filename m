Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FEDC433B4
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Apr 2021 20:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112B361423
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Apr 2021 20:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhD2UdL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhD2UdJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 29 Apr 2021 16:33:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB7C06138B
        for <linux-cxl@vger.kernel.org>; Thu, 29 Apr 2021 13:32:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c22so16487026edn.7
        for <linux-cxl@vger.kernel.org>; Thu, 29 Apr 2021 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q+h21fh57iD7tN7El7dbsYK0bO3RkAwVO5Jaroh4xxw=;
        b=JuNgY/O1MdFzZFyJT3b9s3QW/R/a+/hjBF69EwAzVSmdyIw7sVmtiWA99o1Fgu/Mut
         RNj6K9jRSqEvD7gfwmexJqvPW1/fkQoORe51IzLsfWGUFB1s/kbGuBHaPdq+2KU8yVHH
         MeD8KqD14znLm+KRnTBII7GnB5Ddqcuysba1I9vi991/l4EHlo6kC5xOc4Rt5P087KFK
         MvzPlFzrvxdPuSWd7kqNLUoU0ENmrYCO1L/1syupq3TLVRka7NbHV7RuxjDlq6MuGwbv
         mF7BylFzk3k209aHpIvi/M4zjYf8De3Aimrn7bxl3vQv3hYv8Ws6582SnztCT9svLAsV
         fwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q+h21fh57iD7tN7El7dbsYK0bO3RkAwVO5Jaroh4xxw=;
        b=RDIq6tc8Gs41lAO/GNRNT9N8obsvXYtuSPkTlOf6EdkZHRynKrgEDSXX69bPHoXVoK
         A1tuNRzGheFDBCb0qSv2mt3mgwlWXrFGlvGMwXZtqnYdmAlqVslOACYH8VVwJiGS7Dt1
         bK0GJz87BD/5EKC3i15OUxXiSCVgUl4fXtTfhMZYoF/kj9sW0zGVU565gU75UjzhzIGl
         EV+IXQT74KE6rL57yI8rg6+pZDXHw0LvgQx/lbM+jcfbt9pMRkO82MynpW74JrAJ7pcA
         QUfDZ8TBZkGlhHsfnIbkfFI5XJikMNB0Rd8yGaOrsdmEUwTNxQoomhdWhe7+G0QRcvaA
         1VtA==
X-Gm-Message-State: AOAM532+yk3nw37i2HUHCCa17vvV/rwPR9PiWJcjEBzuRKNHlJ+j1UQ+
        qTUXMNRDU0ghJLNm6BYORBZ8BVglGfTNtN2pmi2CM9izPoM+xA==
X-Google-Smtp-Source: ABdhPJwVsZMQlT6PxGuHZ1R+ZHOT8c+Pu4yAk5bVKBQH37X6w2g9SYhQ+XNMnvGgPWXq7QGK+I539i6FW8U9Ry90Sts=
X-Received: by 2002:a50:f0d6:: with SMTP id a22mr1774770edm.354.1619728339553;
 Thu, 29 Apr 2021 13:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <008b01d73caf$ce11b7d0$6a352770$@montage-tech.com>
In-Reply-To: <008b01d73caf$ce11b7d0$6a352770$@montage-tech.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Apr 2021 13:32:18 -0700
Message-ID: <CAPcyv4gTyj=PAEUdKdMUyLz1hP8Wg+HyabkO11kJ9C0Vx2wkQw@mail.gmail.com>
Subject: Re: CXL mailbox background command
To:     "Dai WeiBin (David Dai)" <david.dai@montage-tech.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        "Jin LiZhi (Lynn Jin)" <lynn.jin@montage-tech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 28, 2021 at 9:30 PM Dai WeiBin (David Dai)
<david.dai@montage-tech.com> wrote:
>
> Hi Ben,
>
> When we think of cxl mailbox background command, we met a difficult issue=
, how to handle switching between a background command end and another back=
ground command start?
>
> The flow is as below:
> 1. Host/caller sends a command to cxl device.
> 2. CXL device identifies the command as a background command, then cxl de=
vice returns background command started, background Operation is set to 1.
> 3. CXL device start to handle background command.
> 4. Host/caller can send other commands to cxl device when background comm=
and is ongoing on device side.
> 5. At a special point host/caller is sending a command to device when the=
 background command just is finished, the new command will be handled as a =
background command by device.
> 6. That means the old background command ends, background Operation is se=
t to 0, immediately the new background command is started, background Opera=
tion is set to 1 again at once.
> 7. So Host driver doesn=E2=80=99t have a chance to check the old backgrou=
nd command has been finished, it still see =E2=80=9Cbackground Operation =
=3D=3D 1=E2=80=9D.
> 8. Mailbox Status Register and Background Command Status Register are bot=
h read-only, that results there is not a handshake between host and device.
> 9.How to guarantee exclusion between two background commands.
>
> Do you have any suggestion about this?

Background commands are not suitable to be exposed directly to
userspace, they can lockout critical driver access. They need to be
mediated by the kernel, so they each need a kernel managed state
machine and those state machines need to cooperate with each other.
Userspace can not be trusted to get this right on its own, so
userspace should be disallowed from issuing such commands by default.
Luckily Linux distributions can get this safety policy with minimal
effort by leaving CONFIG_CXL_MEM_RAW_COMMANDS default disabled.
