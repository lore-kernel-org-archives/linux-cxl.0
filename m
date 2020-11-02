Return-Path: <SRS0=FIBN=EI=vger.kernel.org=linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34EAC00A89
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Nov 2020 19:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FBF20731
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Nov 2020 19:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SaEFxDNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKBTrB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKBTqJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Nov 2020 14:46:09 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5BBC061A04
        for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2020 11:46:08 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id i19so9494926ejx.9
        for <linux-cxl@vger.kernel.org>; Mon, 02 Nov 2020 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9S7vWYZqXm3PqYUWfzNRmMs/AaRtdM//LcdO3k++WwE=;
        b=SaEFxDNLdalp+GldG72yakmXkFbPbvhYxzUPN6V+nHaJHQC2qvu41yf5eyB/QcvIXx
         fnyL4DvxD35TO/GGvlfiXuDMtgtT477/tYOW13bVtx/OrLfSQ2t415bP2SHkjLL/O8mJ
         AcwcCG+YwCDYOmn97Av9Te4pGZgyijcm5ClJbwvmjt3zc5RTZiF91Bs2s0gL3oQB2GB+
         ARpsn11XbZVHljA+/UnLfDpb8EBTXxpHgcXRJNr3gf+joX3g5/xDr/C7sjj+V5qYdXj/
         wgzPh+YKW1OvL3e4zUCCLAolj2fD2CNU9Ha6NeCI7xlO0U/CzEs2YoC5HjL0OOqx8G4u
         IByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9S7vWYZqXm3PqYUWfzNRmMs/AaRtdM//LcdO3k++WwE=;
        b=KpIx1DdG4zGMpLbNg2uPv914O5D50K16E8iPbzi2Zjgl8MXs/22fiLd2RzEHL/+2ha
         TzowMk/Vv+bGT4DLZstN0Fuq5ubCdCfhDSEd8oxujAwnmQ8HTrhjNXiREF6WjZNWVRVu
         OcDtdQUODhgdlbEK0SeFYSJfl34+/pjJPy++d7KzmyCT27XiWRVtc3KsHrGz2FbxAixj
         QeAFwN7+pTboc9Rtj5q8ayXph20zXFqEcXjCf4Pi3xmLQ7IDblVcK2oL50UXp4hVGV4k
         oz0Zdt/K69gJu/HBJvfGgA6l9Hcn2ltK5/GfGl9ivtAsKs++lRb+c0IBqRmj1XInR2C6
         HZSA==
X-Gm-Message-State: AOAM530EV3iCgdkyH5Bqc+xudMR5ThvU0uf+t5z6zIfCdq8bwJp1USuL
        PmT09B32DVUTHQl6K2dX5fRBGMc4at69QLg/CRnxeQ==
X-Google-Smtp-Source: ABdhPJxlB0VuTyd5PdBaybjL8K53mwvkGZB+YeHljHV/lmgT9JUksEsp6iUPlVknSl5PRxkdzwTfMN+/Mocq2Slc5vA=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr16418068ejz.341.1604346367393;
 Mon, 02 Nov 2020 11:46:07 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
 <451b2571-c3e8-97d8-bfd0-f8054a1b75c5@redhat.com> <CAPcyv4jX1tedjuU-vCSKgvhQeNFukyq9d0ddmsk7jAjWMX+iBQ@mail.gmail.com>
 <958912b2-1436-378f-43d7-cbc5c8955ffd@redhat.com> <BL0PR12MB2532D78BF9E62E141AED5EADBD100@BL0PR12MB2532.namprd12.prod.outlook.com>
 <2f9fa312-e080-d995-eb82-1ac9e6128a33@redhat.com> <CAPcyv4jvndnm986vjQLHOw=q0+rN8JDuJd4z-Bv3Wz06Wz4gug@mail.gmail.com>
 <BL0PR12MB2532F7D105A1DC2E41B13DF2BD100@BL0PR12MB2532.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2532F7D105A1DC2E41B13DF2BD100@BL0PR12MB2532.namprd12.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Nov 2020 11:45:55 -0800
Message-ID: <CAPcyv4jkm9MtkG5RPLJDM_PU9nLBXPOGRDZ8tRZX_cgGbf9p9g@mail.gmail.com>
Subject: Re: Onlining CXL Type2 device coherent memory
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 2, 2020 at 11:25 AM Vikram Sethi <vsethi@nvidia.com> wrote:
[..]
> > > At least for passing through memory to VMs (via KVM), you don't actually
> > > need struct pages / memory exposed to the buddy via
> > > add_memory_driver_managed(). Actually, doing that sounds like the wrong
> > > approach.
> > >
> > > E.g., you would "allocate" the memory via devdax/dax_hmat and directly
> > > map the resulting device into guest address space. At least that's what
> > > some people are doing with
>
> How does memory_failure forwarding to guest work in that case?
> IIUC it doesn't without a struct page in the host.
> For normal memory, when VM consumes poison, host kernel signals
> Userspace with SIGBUS and si-code that says Action Required, which
> QEMU injects to the guest.
> IBM had done something like you suggest with coherent GPU memory and IIUC
> memory_failure forwarding to guest VM does not work there.
>
> kernel https://lkml.org/lkml/2018/12/20/103
> QEMU: https://patchwork.kernel.org/patch/10831455/
> I would think we *do want* memory errors to be sent to a VM.
> >
> > ...and Joao is working to see if the host kernel can skip allocating
> > 'struct page' or do it on demand if the guest ever requests host
> > kernel services on its memory. Typically it does not so host 'struct
> > page' space for devdax memory ranges goes wasted.
> Is memory_failure forwarded to and handled by guest?

This dovetails with one of the DAX enabling backlog items to remove
dependencies on page->mapping and page->index for the memory-failure
path because that also gets in the way of reflink. For devdax it's
easy to drop the page->mapping dependency. For fsdax we still need
something to redirect the lookup into the proper filesystem code.

Certainly memory-failure support will not regress, it just means we're
stuck with 'struct page' in this path in the meantime.
