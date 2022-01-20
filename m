Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0649AC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jan 2022 19:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346971AbiATTGb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jan 2022 14:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346956AbiATTGb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jan 2022 14:06:31 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02C3C06161C
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jan 2022 11:06:30 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c5so6059126pgk.12
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jan 2022 11:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srs3TN/75QhowKqGGsiHvm6pbhOWZu8Z1iu0c5373LQ=;
        b=oYBx1lVcXUkFnUepbpxU0fVmaVVHsTyb+loylm1UD3UHlFhok3pZDRUbSSi32gafpI
         B9QkEKiCwEQXWs4RL85vh+68H2K34uKoEfk1KZawdaziy8qjNTom3gXcUTX1PfMD4H3J
         Hi2r7lvhdDOOURTkZYMei+BngqzoEcEAkZ3ZAeAua7R5rk4BcMT+S71z74l5ynjlYmaW
         bx97vsGX//Ankpza0NK6/59HF1TAl80urO2VwN1q+iaSvRwAAo6/Pn+hqF/40Cuocjdz
         jLSyCANRo3v1zKeuWtWlhvO7KMNp9V5FnoYge6BzTly4IG8aXsbXwcoyqWTvVc5Ls/HC
         ORFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srs3TN/75QhowKqGGsiHvm6pbhOWZu8Z1iu0c5373LQ=;
        b=6IkXl5MqL9MoM+iAADWFafJzisIPzo/ZuuZKXBLxOS583gOQ8VUwfsA5w5ARl7l+7u
         sxNCivgUS/2glx81m/vWDtlcmH8ussGZwiGYHoI8vzsnP9iq1vTFrwhJ/CnJE2npojCJ
         EHy3l8d/CEkoswHW4NwgNF+xIye2eHlsQfo8/BLhPqoImMd6R3cGJNNqwEIoqK+Ks6ma
         xH56Y40hdruf9vKfGo6rg+wAV3psprpzkxIQ96OL5rlyF2wr1ok07DWIrj/FRrRT9qy1
         oUTH0K6a3V1cqHD+lXkSo49TZCsOQcVxYjRldq/NSwPi3KD+aWr9atbryoDmrzrxtoT0
         boQQ==
X-Gm-Message-State: AOAM531zhFGryhsre4GLciPHGdTQFadDxOkLwpYp5iOhN0IcJq/xFiQr
        tacg0fo0NncTnUjG9t4Kw8uSM0mWvNv7y28RXMJL+gmNbHnhwQ==
X-Google-Smtp-Source: ABdhPJx/W/CfDq5GkBhdtzDO1btrPLmYyQ4ne7AminxEUjN8xkQzFlcmwfd045bEUy0Ta5xv3LcanJaERxAvTuy9DMg=
X-Received: by 2002:a05:6a00:8d3:b0:4bc:3fe0:98d2 with SMTP id
 s19-20020a056a0008d300b004bc3fe098d2mr173324pfu.3.1642705590104; Thu, 20 Jan
 2022 11:06:30 -0800 (PST)
MIME-Version: 1.0
References: <198c0ae2-efdf-7f47-11c7-27e9a87b3f32@boldcoder.com> <CAJZ5v0ghyNEZayq6CsRpP3LDjFRrCsuSUacU99s8U1Bj6x1o9A@mail.gmail.com>
In-Reply-To: <CAJZ5v0ghyNEZayq6CsRpP3LDjFRrCsuSUacU99s8U1Bj6x1o9A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Jan 2022 11:06:19 -0800
Message-ID: <CAPcyv4h7DtL0v3TPtsMk+t_Y=YKZetiaiZfsAcMgKwPGsbQ7AQ@mail.gmail.com>
Subject: Re: Patch: Make ACPI subsystem provide CEDT table
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Kiraly <me@boldcoder.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

[ add linux-cxl ]


On Thu, Jan 20, 2022 at 10:49 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 13, 2022 at 12:16 AM Robert Kiraly <me@boldcoder.com> wrote:
> >
> > This is a simple ACPI patch. I'm submitting a revised version to
> > linux-acpi as opposed to linux-pm at Rafael Wysocki's suggestion.
> >
> > The patch adds ACPI_SIG_CEDT to table_sigs[] in "drivers/acpi/tables.c".
>
> This can be done, but please send a patch in the message body (not as
> an attachment) and provide a Signed-off-by tag for it.

Yes, although I don't see much incremental benefit to developers
publishing a root only raw table given it needs to be parsed along
with all the other cxl information in the system. So, not opposed to
the patch, but I want to direct you to the sysfs representation of the
CEDT and CFMWS in /sys/bus/cxl/devices is what the cxl tool and libcxl
library [1] will be using instead of the raw table. Platform firmware
CXL details are modeled as "CXL root" objects in the /sys/bus/cxl
device model.

[1]: https://github.com/pmem/ndctl/tree/main/cxl
