Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4438C433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 23 Apr 2022 17:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiDWRbB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 23 Apr 2022 13:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDWRbA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 23 Apr 2022 13:31:00 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9046E15B466
        for <linux-cxl@vger.kernel.org>; Sat, 23 Apr 2022 10:28:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g3so9278616pgg.3
        for <linux-cxl@vger.kernel.org>; Sat, 23 Apr 2022 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjNNj2h0H9BdL9f5m+RhS3iK90tZuCfxF3PYDW2jHLo=;
        b=Y4suICBQDJxf0jQtkeyC3zyUM3bJCKEEvMlhWiNcQGzmHv6AX00nag852PsZfn/2WY
         QX3PVo+C07/bFjX7RsJyx8FIa8FTgD/N2sYKBiWOpN2jEIWRzzbv5Cd0J8GEUpLILWe1
         kYOvssQac95PDPJANkwqEueJuzNVkyZfGUdeSyiSdjU3+KTpuB7qjofvFpgq9PTG962L
         iY5fl8f1dAKPE5sSN/uu+Ln8TWXq9VgcVzyZH71ov5mgjuJl8PBt0nZSjXlPmLC7OVUu
         Lx53yMbickS/RVM/xs9BR4dNxqU3PNoknFTU3wQfaMkFAgIKpRIeULxaBE48sPeUDaIW
         D2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjNNj2h0H9BdL9f5m+RhS3iK90tZuCfxF3PYDW2jHLo=;
        b=jyuQxAeGgcsqzz5OtMOkLc02Pr33rJrnUDvY4mphyLtP4pNe5P+idWTa9Sx77JydZj
         QF4GK007MXsO4ppgVyKZ7jyGpV7JSOOHFTSmK8+rJNzKBQ5Xb+fLuMdno6gWSmtOstG0
         +oZ+MMzZQnR5wl8gFp8NBaV2gsUJHjla5nH2gfQ4e0pbp2n5HByCs4Z5QHmQ6mirtJMk
         Mz5Rzv1PeTWBFIrxY+w985XbLoidns3zn7EtuscWA1+oOG6JDnBR9gFcEjul9VbHfpOu
         466XK3P9tNpVBS+i0LLWruUhiVbY7g1bqOz40zKfjo52O1ibhqKMjYz5IRNeRWhXBUnA
         w7mg==
X-Gm-Message-State: AOAM533RbQv726dPpcBnzql0GGsRFiVFSODMaODo85/i1IWQ1u60WiMs
        fsscgDNsa+dmWpsnMJp07NxqgdkLQk9ZJYRfV8GXpg==
X-Google-Smtp-Source: ABdhPJwT11ZC6iXsaztYnSq4YzfDM6EFxQy96NZsDhLdWGx609R+suZlfO9ayXNZmrfnqdz2ibDw7UZSkJUIhziL3i8=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr8862901pgl.40.1650734883122; Sat, 23
 Apr 2022 10:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YmNBJBTxUCvDHMbw@iweiny-desk3> <CAPcyv4jtNgfjWLyu6MtBAjwUiqe2qEBW802AzZZeg2gZ_wU9AQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jtNgfjWLyu6MtBAjwUiqe2qEBW802AzZZeg2gZ_wU9AQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 23 Apr 2022 10:27:52 -0700
Message-ID: <CAPcyv4hhD5t-qm_c_=bRjbJZFg9Mjkzbvu_2MEJB87fKy3hh-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] cxl/acpi: Add root device lockdep validation
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-cxl@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 22, 2022 at 5:08 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Apr 22, 2022 at 4:58 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Thu, Apr 21, 2022 at 08:33:18AM -0700, Dan Williams wrote:
> > > The CXL "root" device, ACPI0017, is an attach point for coordinating
> > > platform level CXL resources and is the parent device for a CXL port
> > > topology tree. As such it has distinct locking rules relative to other
> > > CXL subsystem objects, but because it is an ACPI device the lock class
> > > is established well before it is given to the cxl_acpi driver.
> >
> > This final sentence gave me pause because it implied that the device lock class
> > was set to something other than no validate.  But I don't see that anywhere in
> > the acpi code.  So given that it looks to me like ACPI is just using the
> > default no validate class...
>
> Oh, good observation. *If* ACPI had set a custom lock class then
> cxl_acpi would need to be careful to restore that ACPI-specific class
> and not reset it to "no validate" on exit, or skip setting its own
> custom class. However, I think for generic buses like ACPI that feed
> devices into other subsystems it likely has little reason to set its
> own class. For safety, since device_lock_set_class() is general
> purpose, I'll have it emit a debug message and fail if the class is
> not "no validate" on entry.
>

So this turned out way uglier than I expected:

 drivers/cxl/acpi.c     |    4 +++-
 include/linux/device.h |   33 +++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 9 deletions(-)

...so I'm going to drop it and just add a comment about the
expectations. As Peter said there's already a multitude of ways to
cause false positive / negative results with lockdep so this is just
one more area where one needs to be careful and understand the lock
context they might be overriding.
