Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F88C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 05:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiA1F2v (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 00:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiA1F2v (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 00:28:51 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F32DC061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 21:28:51 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d5so5470894pjk.5
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 21:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xF1XQTG5H5Wr2zQrwbMby7gynnDNiHNZ+I5ZE1z1uPg=;
        b=OIUpUnb4/1vAPBXmPK3cqXdwlSFQShxHtoMFPDmcsfD8RdZCpNC1proB76gMT4zGRo
         hy6ntMnYcmpLzpCye7LICf5J7znV5/T3fk7K03ShaM+SS6VOYNpydRBhsxpbczEhNor3
         nSsyBh0391FJQbRjsprphUxKkVEBrHSKUgRL1mobmaXrMHRCbDNCNEz03x8KyZjG6ZrQ
         lHeBl/ejydihb8qhJ6/tJecwDfqx+Iz/y0lkTX9tg2GUt0KdElHT6b+gtGzyTDG4ccIg
         q6/BjtZ69Md1zcLGRlOWN4hd6UtLvYIy8PNoJ1F5yBhO9Bjne1N35OAX2yKbQI9ya9jy
         v8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xF1XQTG5H5Wr2zQrwbMby7gynnDNiHNZ+I5ZE1z1uPg=;
        b=upzVr9AQqA9exlxKooHGZxfo6CPRIpzMHQMUk7y5sNRlCdMlQCE4sTcMz9WtilnH7x
         tzoYOO61/5kQ8X5rSe4gScN8wgZWiBRt+dp45yDVHNHPh22SS7UEa2T8rNf8zhdCqUlh
         rqBB0Vd5T4TtEhS2e6S7EMMl9kRgniQtxVb3iXv7d4J7mgX0O32PNqP3yrHJ+8k4C0Q6
         b7RuyAtQ2dqctaj9nmaaotrur7u7KhrQiaHZj+cVkgrE5Fk961rdwV0pcRcn7EwApFh3
         gsK9TbgR9b9Xrol6k0t4lRLGQ3arvIu7QaLMaRkqxik36Fhnx8wA/RRBxRrk57NzCHMx
         /amA==
X-Gm-Message-State: AOAM533cpxKKOmHEylbIZy3ARh1vsZmZvADK6C/m80ST1teXd2ZFZ0xm
        a72/ASErG2tNgsy6Yj98Lkhn5MaxBShH8AJ4e9YSIA==
X-Google-Smtp-Source: ABdhPJyHXOxsMVNVRGK6bev2SlwfUn+M5ZBLCfmsgts+bw2EH7obG46+3BsCrUY3tiAmP4Y6bNOdvhzuon+YDQxX8DI=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr6253950ply.34.1643347731054;
 Thu, 27 Jan 2022 21:28:51 -0800 (PST)
MIME-Version: 1.0
References: <07cedbe6-00ab-52fc-9475-c8d7120f5a95@jagalactic.com>
 <0100017e9c54d4e0-c1f1a7db-e2ab-4552-a7eb-8e4b56cd9528-000000@email.amazonses.com>
 <02c601d813fc$a8744c70$f95ce550$@montage-tech.com>
In-Reply-To: <02c601d813fc$a8744c70$f95ce550$@montage-tech.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Jan 2022 21:28:40 -0800
Message-ID: <CAPcyv4hWcxoEw=umN=0xDe4Ychfxe6GysYOBcxK6oHLEDhz1iw@mail.gmail.com>
Subject: Re: Should bios always mark CXL DRAM as EFI_MEMORY_SP?
To:     "Li Qiang (Johnny Li)" <johnny.li@montage-tech.com>
Cc:     John Groves <john@jagalactic.com>, linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        John Groves <JGroves@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 27, 2022 at 8:12 PM Li Qiang (Johnny Li)
<johnny.li@montage-tech.com> wrote:
>
> I think BIOS should follow CDAT spec v1.01 Device Scoped EFI Memory Type =
Structure (DSEMTS) structure
>
> In Table 8 Device Scoped EFI Memory Type Structure, field EFI Memory Type=
 and Attribute has below definition
>   0 =E2=80=93 EfiConventionalMemory
>   1 - EfiConventionalMemory Type with EFI_MEMORY_SP Attribute
>   2 =E2=80=93 EfiReservedMemoryType
>   3-255 =E2=80=93 Reserved encoding
>   The memory attribute EFI_MEMORY_NV may be inferred from NonVolatile fla=
g in DSMAS.
>   Memory types other than EfiConventionalMemory and EfiReservedMemoryType=
 are not permitted.

Definitely BIOS should follow CDAT for the type, but it's not so clear
to me the same can be said about the attribute. I think the bigger
question is when should devices claim to be EFI_MEMORY_SP, and when
should BIOS apply EFI_MEMORY_SP regardless of what the device
advertises. EFI_MEMORY_SP is a claim about usage that the memory is
either too high performance or too low performance to be added to the
general memory pool by default. That's not a decision that a device
necessarily knows how to make on its own. The platform BIOS might have
a better chance to know intended application the system was built. The
OS kernel is somewhat blind to usage but OS policy can do the last
mile tuning of how much if any memory of a given performance class
should be set aside for exclusive access.
