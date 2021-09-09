Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A523DC433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 18:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892C0610C9
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 18:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbhIISIP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhIISIP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Sep 2021 14:08:15 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9EC061574
        for <linux-cxl@vger.kernel.org>; Thu,  9 Sep 2021 11:07:05 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q68so2600383pga.9
        for <linux-cxl@vger.kernel.org>; Thu, 09 Sep 2021 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DB7d8qlsEXjW0/p+LkG3Ot1Z62d1BxqW2zd0idHHe0Q=;
        b=eVgSeQ7F796y82CTKM+Cp2kt12L7ThBsq/xNzKztOT6g/3VY9KWlhuZGqyGyNk7fmj
         beswRIhKQGuXNkb9M8xG5PwT7ZyJfipkE3mQKUknallBSc2YpWlS6/qpTaDoEnJUl/vp
         tcrbHr4tCMAYPfUowT1tu8kCO8jgfb7iI3fepUoy/4YTu2St+uKVy0nQUNHy1npzvqo5
         CL3uQvK7PDezWBPOG78OCf3Wq5Zr8xikIB6UsQq/NCPLtiOOYCiiR5T1c5IxTqvJA3dv
         aQQjqE63ueJ91oDcyoxMlV1t+5UgIKWLfNr5B51PIP//a9byyKevXzv3uJAbvtQ7ACqi
         Va9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DB7d8qlsEXjW0/p+LkG3Ot1Z62d1BxqW2zd0idHHe0Q=;
        b=sBgxB5aSuJegqW5lCIkxAcrW5DJL9wDwCMZD5w6vUzhBuM65j2/+HQ3ZIHRNePRcR+
         cI0L3jeVAcGce9nsMEQUQCWqVPSnsZw2XER6c5phNCScSVQdAv8zFds7l9xdVklG/ilq
         juO7wgpmf1E1RBqJeRhZWQm4S4ZI4RdWMiRR7Ch8of/PvS286tv0M6PpANa4bmRWLHyx
         G6mKVth+xnWHzImdpUE3My/rZRXoW9x8VR63Enc2ITF73xkx6rd4dTZMRUVyl/cFOQuW
         OmiAk2G+2IDQP7XP70m/5YTvzP50J+M6QYUhU3wii+hmC9ZjyXiV5yWtReqa6fM1dWZ4
         amxg==
X-Gm-Message-State: AOAM531d2Rrzebbt43vRuVRyq6KAPcm5CPCrx1dwCwtYxqxhFaDY3cWF
        uQil/ysnvNZD2MyefL4/cz05dLJ5TQbKBDYRBPbiww==
X-Google-Smtp-Source: ABdhPJyqAkf2g/NQRuEFf1jdcFOpyadRO6oGaB4+JFa5Qz5TVO7SvGXbKcXs8Yjvowe/QcDEQxiFgTi++eb6eDOArdI=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr4134686pfb.3.1631210824902; Thu, 09
 Sep 2021 11:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116433533.2460985.14299233004385504131.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210909162005.ybqjh5xrbhg43wtr@intel.com>
In-Reply-To: <20210909162005.ybqjh5xrbhg43wtr@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Sep 2021 11:06:53 -0700
Message-ID: <CAPcyv4h3LmmpTt_0Om0OCxWPXo-8jucA-9p3rwhx_j2vCFEj9Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/21] cxl/pci: Clean up cxl_mem_get_partition_info()
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 9, 2021 at 9:20 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-08 22:12:15, Dan Williams wrote:
> > Commit 0b9159d0ff21 ("cxl/pci: Store memory capacity values") missed
> > updating the kernel-doc for 'struct cxl_mem' leading to the following
> > warnings:
> >
> > ./scripts/kernel-doc -v drivers/cxl/cxlmem.h 2>&1 | grep warn
> > drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'total_bytes' not described in 'cxl_mem'
> > drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'volatile_only_bytes' not described in 'cxl_mem'
> > drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'persistent_only_bytes' not described in 'cxl_mem'
> > drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'partition_align_bytes' not described in 'cxl_mem'
> > drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'active_volatile_bytes' not described in 'cxl_mem'
> > drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'active_persistent_bytes' not described in 'cxl_mem'
> > drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'next_volatile_bytes' not described in 'cxl_mem'
> > drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'next_persistent_bytes' not described in 'cxl_mem'
> >
> > Also, it is redundant to describe those same parameters in the
> > kernel-doc for cxl_mem_get_partition_info(). Given the only user of that
> > routine updates the values in @cxlm, just do that implicitly internal to
> > the helper.
> >
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/cxlmem.h |   15 +++++++++++++--
> >  drivers/cxl/pci.c    |   35 +++++++++++------------------------
> >  2 files changed, 24 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index d5334df83fb2..c6fce966084a 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -78,8 +78,19 @@ devm_cxl_add_memdev(struct cxl_mem *cxlm,
> >   * @mbox_mutex: Mutex to synchronize mailbox access.
> >   * @firmware_version: Firmware version for the memory device.
> >   * @enabled_cmds: Hardware commands found enabled in CEL.
> > - * @pmem_range: Persistent memory capacity information.
> > - * @ram_range: Volatile memory capacity information.
> > + * @pmem_range: Active Persistent memory capacity configuration
> > + * @ram_range: Active Volatile memory capacity configuration
> > + * @total_bytes: sum of all possible capacities
> > + * @volatile_only_bytes: hard volatile capacity
> > + * @persistent_only_bytes: hard persistent capacity
> > + * @partition_align_bytes: soft setting for configurable capacity
> > + * @active_volatile_bytes: sum of hard + soft volatile
> > + * @active_persistent_bytes: sum of hard + soft persistent
>
> Looking at this now, probably makes sense to create some helper macros or inline
> functions to calculate these as needed, rather than storing them in the
> structure.

Perhaps, I would need to look deeper into what is worth caching vs
what is suitable to be recalculated. Do you have a proposal here?


>
> > + * @next_volatile_bytes: volatile capacity change pending device reset
> > + * @next_persistent_bytes: persistent capacity change pending device reset
> > + *
> > + * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > + * details on capacity parameters.
> >   */
> >  struct cxl_mem {
> >       struct device *dev;
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index c1e1d12e24b6..8077d907e7d3 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -1262,11 +1262,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
> >
> >  /**
> >   * cxl_mem_get_partition_info - Get partition info
> > - * @cxlm: The device to act on
> > - * @active_volatile_bytes: returned active volatile capacity
> > - * @active_persistent_bytes: returned active persistent capacity
> > - * @next_volatile_bytes: return next volatile capacity
> > - * @next_persistent_bytes: return next persistent capacity
> > + * @cxlm: cxl_mem instance to update partition info
> >   *
> >   * Retrieve the current partition info for the device specified.  If not 0, the
> >   * 'next' values are pending and take affect on next cold reset.
> > @@ -1275,11 +1271,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
> >   *
> >   * See CXL @8.2.9.5.2.1 Get Partition Info
> >   */
> > -static int cxl_mem_get_partition_info(struct cxl_mem *cxlm,
> > -                                   u64 *active_volatile_bytes,
> > -                                   u64 *active_persistent_bytes,
> > -                                   u64 *next_volatile_bytes,
> > -                                   u64 *next_persistent_bytes)
> > +static int cxl_mem_get_partition_info(struct cxl_mem *cxlm)
> >  {
> >       struct cxl_mbox_get_partition_info {
> >               __le64 active_volatile_cap;
> > @@ -1294,15 +1286,14 @@ static int cxl_mem_get_partition_info(struct cxl_mem *cxlm,
> >       if (rc)
> >               return rc;
> >
> > -     *active_volatile_bytes = le64_to_cpu(pi.active_volatile_cap);
> > -     *active_persistent_bytes = le64_to_cpu(pi.active_persistent_cap);
> > -     *next_volatile_bytes = le64_to_cpu(pi.next_volatile_cap);
> > -     *next_persistent_bytes = le64_to_cpu(pi.next_volatile_cap);
> > -
> > -     *active_volatile_bytes *= CXL_CAPACITY_MULTIPLIER;
> > -     *active_persistent_bytes *= CXL_CAPACITY_MULTIPLIER;
> > -     *next_volatile_bytes *= CXL_CAPACITY_MULTIPLIER;
> > -     *next_persistent_bytes *= CXL_CAPACITY_MULTIPLIER;
> > +     cxlm->active_volatile_bytes =
> > +             le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> > +     cxlm->active_persistent_bytes =
> > +             le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
> > +     cxlm->next_volatile_bytes =
> > +             le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> > +     cxlm->next_persistent_bytes =
> > +             le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>
> Personally, I prefer the more functional style implementation. I guess if you
> wanted to make the change, my preference would be to kill
> cxl_mem_get_partition_info() entirely. Up to you though...

I was bringing this function in line with the precedent we already set
with cxl_mem_identify() that caches the result in @cxlm. Are you
saying you want to change that style too?

I feel like caching device attributes is idiomatic. Look at all the
PCI attributes that are cached in "struct pci_device" that could be
re-read or re-calculated rather than cached. In general I think a
routine that returns 4 values is better off filling in a structure.
