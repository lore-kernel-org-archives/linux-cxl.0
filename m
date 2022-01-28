Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58712C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 00:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiA1ArY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiA1ArY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 19:47:24 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B9C061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 16:47:24 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e9so3837954pgb.3
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 16:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iPzypwT9RpE5f0REEGQwwMZW+473s1sjHm1OUy2RZYs=;
        b=cXNfbi8gGOdOaX8W0lnXPihwEArCZIbf4JMmmYVYDIeQO6E3NRjqEv4aCv2Z0+7LfO
         bWo8yX77fcj6m3lirA9MWv0hh2p2VKlK3fP7+4Tfa7Q8wqxg7l/3l+Z4HpcGJO222KM+
         9yniav8p3lJ9V0q3Jygh0jVlpIFjLMTpgCwwkj3Cha1AAL3MywdP0ZM3peGlg5PkbtyU
         vDEgEgyxya96PKPj74n/aOUE6E4QRuCgb8JzhBQy0U4lV2eas/hg6IyhW1xj3heW/dFR
         cPgRxv5aFJETjbYqwnUzkoW1yZJJwH0IWWxhJ1eeMnTPgIu4LhoQrPrSTdBJKLosY4gI
         uQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iPzypwT9RpE5f0REEGQwwMZW+473s1sjHm1OUy2RZYs=;
        b=7SQMtn8vIYSlugZTziFjcuiIGKJpIOSCQqoLxQfG8f+3oQPVzSHqj1qIyooRuXEK2q
         SfKOal96FN2m2otxFdPzfXQwiNkUm93F0GeJP8WjqPHOPXPoJxZgSKr8yIFPTFFQHvAn
         4PZlGxS1z1oTX7KMMP688nSbBR+BCUZwES4DnW/VZMaco0t+l77X8CgygSF5bjubdzhd
         uh+Z5nLUMP4XVKZQ5DeusrEF+xZDexBFzswNVMW7TSsQTFLl5wAdqZ8rvFmqbz4ilYdf
         DZR0/LozQtq4MATmB7X7V3f7eNkZkXwR6HMoKWnZugcEEu36QTqMT2qtX5Vo1L2krwgO
         hqyw==
X-Gm-Message-State: AOAM533x9X419jX0NKoCfQQhyk5DUsQFtCqg+NpflFtVra/c1P9e+v1h
        8n70nfaPcChEol+mxnf0SsnsFcC3Pg7Ij+yfC78NJw==
X-Google-Smtp-Source: ABdhPJyYHG4Afjsq6G+2KDJXjprfuJ7oSzYM/+qdbSIgEeGjrmesjQ0Xdcp+uge1cSuM0wmcuICRetGySHVn2Oi1u8Y=
X-Received: by 2002:a62:784b:: with SMTP id t72mr5575652pfc.86.1643330843434;
 Thu, 27 Jan 2022 16:47:23 -0800 (PST)
MIME-Version: 1.0
References: <07cedbe6-00ab-52fc-9475-c8d7120f5a95@jagalactic.com> <0100017e9c54d4e0-c1f1a7db-e2ab-4552-a7eb-8e4b56cd9528-000000@email.amazonses.com>
In-Reply-To: <0100017e9c54d4e0-c1f1a7db-e2ab-4552-a7eb-8e4b56cd9528-000000@email.amazonses.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Jan 2022 16:47:12 -0800
Message-ID: <CAPcyv4gT+LdTn5krrsg0zg-u-7SNF4ZnD2HnzNxbSkq6u5bP-w@mail.gmail.com>
Subject: Re: Should bios always mark CXL DRAM as EFI_MEMORY_SP?
To:     John Groves <john@jagalactic.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        John Groves <JGroves@micron.com>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

[ add linux-mm since my opinion is not the only one that matters here ]

Responses inline below with only my Linux kernel developer hat on,
i.e. not necessarily the view of $current_employer:

On Thu, Jan 27, 2022 at 8:18 AM John Groves <john@jagalactic.com> wrote:
>
> I=E2=80=99d like to seek some feedback and see whether a consensus exists=
 or can be developed regarding how system firmware (bios/efi/etc) should pr=
esent CXL DRAM to a system in a pre-fabric world (CXL 1.1/2.0).
>
>
>
> The CXL spec, along with the Intel documentation are pretty specific and =
useful, but one open issue seems not to be outright specified: should the s=
ystem mark CXL-attached DRAM as =E2=80=9Cspecific purpose=E2=80=9D (EFI_MEM=
ORY_SP)? Consistency across platforms is certainly desirable. If this behav=
ior is not prescribed, we could end up with inconsistent behavior across se=
rver and bios vendors.
>
>
>
> If this is already specified, no need to read on (but please point me to =
where it=E2=80=99s specified).

There is no specification for how an OS handles EFI_MEMORY_SP.
Everything below is only a Linux perspective and likely any other OS
you ask will give a different perspective.

> Objective: I think everyone will likely agree that it should be possible =
to use CXL DRAM as either general-purpose memory, or via DAX, or a mix.
[..]
>
> =C2=B7      Currently cannot be online-converted to DAX-managed (can this=
 work? Is it intended to be working?)
>

There is no guaranteed way to un-online memory, especially ZONE_NORMAL
memory. There are heuristics to make it fail less often, but in
general it's not reliable so online-conversion to DAX-managed is not
being attempted for the general case.

> If online conversion from general-purpose to DAX is not going to work, it=
 seems that the default should preserve the ability to use it either way: m=
ark the memory as EFI_MEMORY_SP.

Yes, unfortunately that requires a paradigm shift for end users to
make a policy decision about memory where they did not need to make
one before. My hope is that distributions would set a default daxctl
policy to just online soft-reserved (Linux term for EFI_MEMORY_SP)
memory. That way savvy users have a control point to change the policy
to varying degrees of exclusive access through a DAX-device instance /
instances, and other users, that don't even know what EFI_MEMORY_SP
is, will see just another NUMA node by default.

> Is there a right and wrong answer re:EFI_MEMORY_SP? How important is it t=
o have consistency across platforms?

The Principle of Least Surprise applies, and the vast bulk of users
simply don't know that they need to care about memory types and memory
performance classes. The ones that do know and care are also likely
the ones to be surprised if they can not guarantee 100% exclusive
access, i.e. machines purpose built to run a workload where the
application gets 100% of the high performance memory.

The distro gets to decide the CONFIG_EFI_SOFT_RESERVE policy, and if
it chooses CONFIG_EFI_SOFT_RESERVE=3Dy I think it should go further to
ship daxctl and a policy that onlines it by default.

https://github.com/pmem/ndctl/blob/main/Documentation/daxctl/daxctl-reconfi=
gure-device.txt#L244

> If there is a consensus, the next question is who should express it. Perh=
aps the CXL consortium. I=E2=80=99m a part of that, but it seemed like the =
Linux dev community was the right place to start.

EFI_MEMORY_SP is defined as a hint, so to me that effectively kicks
all the policy questions over to OS specific / Distro specific
solution space.
