Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23E0C433E0
	for <linux-cxl@archiver.kernel.org>; Sat, 20 Feb 2021 17:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38D764ECA
	for <linux-cxl@archiver.kernel.org>; Sat, 20 Feb 2021 17:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBTRtN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 Feb 2021 12:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTRtM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 20 Feb 2021 12:49:12 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717D0C061574
        for <linux-cxl@vger.kernel.org>; Sat, 20 Feb 2021 09:48:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u20so21271538ejb.7
        for <linux-cxl@vger.kernel.org>; Sat, 20 Feb 2021 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niF1k3dVyqWcVFhX7Jys8F/FWOuqyr/3JpoSyGWUad4=;
        b=SJiJGOm92EOLuEmD8ZxINHCPgWL9FHxOSQ3VIYWX9zoyH2E9wOjXIS9rFt4qflATpv
         hSN/bjk3gMWmOoic96yidZvVl7/B4XMCsqfh0PkuMvTvPzxsbnnAAzqFwvJBX/EHx6Jq
         lEXEZ04J4mAMFF3qpTPsBe+t1d1hZCpoZ1tHexVfyV6BEj3IJZ6FxOnS5w7SFjV4xaQB
         bzdJovpxJgMpQMBdOPWU4kOe8uTftngZHfL80X3V4NBKw6dQvwl3+V0eAaAFtkaj7Nyw
         q6pWkVkKDyqb9Tw8d5bxJN+VZ9kPSu7gfMjLM+uXAWL9W050qu1qq3zAwkiaymsFO0Qm
         BLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niF1k3dVyqWcVFhX7Jys8F/FWOuqyr/3JpoSyGWUad4=;
        b=Yk6yP3sQB4IlMKyMgm7qcn1sD+gtGKCEHKb7usF7E0pFSjG/2zizGaoma56kNzJiZX
         DEq54+JaPuZKEzhWcGoFwl7OS5/lJ/7xK+AfIP2xK6Hff3ZRR1Snq+T7G+cVdBZ3diSZ
         o6NVvp1KkXzPJnyzgeV1rGdhuf5DKBa1hKKftYpjFcd4+Me6PLF2xXtmWnKBli7MI1zh
         MOhHXvFXOsaSV4sEVMtKylNluf4R3CVYWjdEKx8bnNwLDvP8n/mYOlfyic0tTs85Ad2F
         zn1DkZuz8ho2J7B3Frq7ieCkpHpO7RTwB5tV4zijxcHJal6/1uJLkCFGWBaFE/hwMICz
         TE9A==
X-Gm-Message-State: AOAM533cOudPZVGPrHLRhGBKdTq7P4bx0vCq4xo5n4mWjQ/MnG2vTPEG
        g4J++H1oMrJ+RMC0RH31qeblOfFkDJCOw+e14l27Zw==
X-Google-Smtp-Source: ABdhPJzMFtM3V/tSlVTUOFi/gy4tLf3ErLDeRmJYFtXE81s7f90uq338SYuA8goZna9AO+QqkY89+APsjw6TJdTe694=
X-Received: by 2002:a17:907:373:: with SMTP id rs19mr1248541ejb.341.1613843310167;
 Sat, 20 Feb 2021 09:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-5-ben.widawsky@intel.com> <YDBkOB3K8UqVakFf@Konrads-MacBook-Pro.local>
 <20210220163344.csczmkyxkpu4fxah@intel.com>
In-Reply-To: <20210220163344.csczmkyxkpu4fxah@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 20 Feb 2021 09:48:22 -0800
Message-ID: <CAPcyv4jWnW_i=jaGP_nXRuGgwmngObw_V8AOPY3k_YMHkL-8Eg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] cxl/mem: Add basic IOCTL interface
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Feb 20, 2021 at 8:33 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-19 20:22:00, Konrad Rzeszutek Wilk wrote:
> > ..snip..
> > > +static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> > > +                                   const struct cxl_mem_command *cmd,
> > > +                                   u64 in_payload, u64 out_payload,
> > > +                                   s32 *size_out, u32 *retval)
> > > +{
> > > +   struct device *dev = &cxlm->pdev->dev;
> > > +   struct mbox_cmd mbox_cmd = {
> > > +           .opcode = cmd->opcode,
> > > +           .size_in = cmd->info.size_in,
> > > +           .size_out = cmd->info.size_out,
> > > +   };
> > > +   int rc;
> > > +
> > > +   if (cmd->info.size_out) {
> > > +           mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
> > > +           if (!mbox_cmd.payload_out)
> > > +                   return -ENOMEM;
> > > +   }
> > > +
> > > +   if (cmd->info.size_in) {
> > > +           mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
> > > +                                              cmd->info.size_in);
> > > +           if (IS_ERR(mbox_cmd.payload_in))
> > > +                   return PTR_ERR(mbox_cmd.payload_in);
> >
> > Not that this should happen, but what if info.size_out was set? Should
> > you also free mbox_cmd.payload_out?
> >
>
> Thanks Konrad.
>
> Dan, do you want me to send a fixup patch? This bug was introduced from v4->v5.

Yes, please, incremental to libnvdimm-for-next which I'm planning to
send to Linus on Tuesday.
