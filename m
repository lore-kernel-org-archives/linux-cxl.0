Return-Path: <SRS0=FIBN=EI=vger.kernel.org=linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F24C2D0A3
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Nov 2020 18:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C2A22226
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Nov 2020 18:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="e3280KJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKBSDa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgKBSDa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Nov 2020 13:03:30 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182EC061A04
        for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2020 10:03:29 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id k3so20079033ejj.10
        for <linux-cxl@vger.kernel.org>; Mon, 02 Nov 2020 10:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nmufHlN7PEujC/sOqa9SNa26JVNl51LU7nJggN5+u5I=;
        b=e3280KJR0jxfgMu0wD9WOKNR0rIAFMrLrVk6sPhZhxV/4ZVNzNmHKspxecd5l+V1ah
         Qt0WEGkMFYD4YhAr+tAFpUonbH+ld3DqGyJ1VKcxGUTLOrpoc7WSGF/zXSLYHUgOTZB4
         cppyjc2e9yDHzttGQV2BEg7w3eomVu7+tvKatvpMNuDkQViTX6Q6A5nomVOhIgTxcfdF
         1RAyOPJg/Nrd9EY91TeuV3xc7VnXvz036UUFugrx3aEley/j+PCxTU7EDdkFK6CuGFcE
         dVEzUuzwMX3j3ZbD3pT75KqSaiZVFLXspKZgtp4f4E42IZTxe6xqzHmk9VRxpXZrzLWx
         mlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nmufHlN7PEujC/sOqa9SNa26JVNl51LU7nJggN5+u5I=;
        b=U8E0yuHmnW+LwH4IhGzayx9xcAciKkituzs2uLd0Y+noRzzJt+Azi8w1IYs2o6rruV
         Z0CsVB3zJlcUclkychdGPKmregVzdJhjOgbxBz0EaYsUgmhghix73lKTmoiE/Ke7zjpi
         INsAu5pw2rLwI+PrcsK/2iouPTCt6wHgheTkMKvUM0/zbzEWcHfOjSkYEBjoBMj7dwFs
         WJlnVg6UXFj9vmHdftHo7XDHfHQWPrCzPv309SNHS5jfeGr8DNKE3MqvsnXsgReZlTO5
         ykIjUzTRYE6p1cZPrkNbQ/CGq7wqv8dOAOrfSNCNhzTgwCwuKwCs/5YUgVFIQqhe+9es
         ckIA==
X-Gm-Message-State: AOAM533UduLvIj6kZfczWQSaqPlb9KrlU2Iv49a+TllL+VZkOYW/JaOO
        7b57XAeeUOOB+Kjj2Z1seHNauhdxUOVjx4KCjCjARA==
X-Google-Smtp-Source: ABdhPJx84KmXGYY1qSAAmTqWyWTY7uzYVX9PJp29vAKJJ+OmvdQnWhirb250MJnNQiDindqjU6p2UCetER7HakL35rI=
X-Received: by 2002:a17:906:280a:: with SMTP id r10mr16327458ejc.45.1604340208573;
 Mon, 02 Nov 2020 10:03:28 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
 <451b2571-c3e8-97d8-bfd0-f8054a1b75c5@redhat.com> <CAPcyv4jX1tedjuU-vCSKgvhQeNFukyq9d0ddmsk7jAjWMX+iBQ@mail.gmail.com>
 <958912b2-1436-378f-43d7-cbc5c8955ffd@redhat.com> <BL0PR12MB2532D78BF9E62E141AED5EADBD100@BL0PR12MB2532.namprd12.prod.outlook.com>
 <2f9fa312-e080-d995-eb82-1ac9e6128a33@redhat.com>
In-Reply-To: <2f9fa312-e080-d995-eb82-1ac9e6128a33@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Nov 2020 10:03:16 -0800
Message-ID: <CAPcyv4jvndnm986vjQLHOw=q0+rN8JDuJd4z-Bv3Wz06Wz4gug@mail.gmail.com>
Subject: Re: Onlining CXL Type2 device coherent memory
To:     David Hildenbrand <david@redhat.com>
Cc:     Vikram Sethi <vsethi@nvidia.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 2, 2020 at 9:53 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 02.11.20 17:17, Vikram Sethi wrote:
> > Hi David,
> >> From: David Hildenbrand <david@redhat.com>
> >> On 31.10.20 17:51, Dan Williams wrote:
> >>> On Sat, Oct 31, 2020 at 3:21 AM David Hildenbrand <david@redhat.com> =
wrote:
> >>>>
> >>>> On 30.10.20 21:37, Dan Williams wrote:
> >>>>> On Wed, Oct 28, 2020 at 4:06 PM Vikram Sethi <vsethi@nvidia.com> wr=
ote:
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> I wanted to kick off a discussion on how Linux onlining of CXL [1]=
 type 2
> >> device
> >>>>>> Coherent memory aka Host managed device memory (HDM) will work for
> >> type 2 CXL
> >>>>>> devices which are available/plugged in at boot. A type 2 CXL devic=
e can be
> >> simply
> >>>>>> thought of as an accelerator with coherent device memory, that als=
o has a
> >>>>>> CXL.cache to cache system memory.
> >>>>>>
> >>>>>> One could envision that BIOS/UEFI could expose the HDM in EFI memo=
ry map
> >>>>>> as conventional memory as well as in ACPI SRAT/SLIT/HMAT. However,=
 at
> >> least
> >>>>>> on some architectures (arm64) EFI conventional memory available at=
 kernel
> >> boot
> >>>>>> memory cannot be offlined, so this may not be suitable on all arch=
itectures.
> >>>>>
> >>>>> That seems an odd restriction. Add David, linux-mm, and linux-acpi =
as
> >>>>> they might be interested / have comments on this restriction as wel=
l.
> >>>>>
> >>>>
> >>>> I am missing some important details.
> >>>>
> >>>> a) What happens after offlining? Will the memory be remove_memory()'=
ed?
> >>>> Will the device get physically unplugged?
> >>>>
> > Not always IMO. If the device was getting reset, the HDM memory is goin=
g to be
> > unavailable while device is reset. Offlining the memory around the rese=
t would
>
> Ouch, that speaks IMHO completely against exposing it as System RAM as
> default.
>
> > be sufficient, but depending if driver had done the add_memory in probe=
,
> > it perhaps would be onerous to have to remove_memory as well before res=
et,
> > and then add it back after reset. I realize you=E2=80=99re saying such =
a procedure
> > would be abusing hotplug framework, and we could perhaps require that m=
emory
> > be removed prior to reset, but not clear to me that it *must* be remove=
d for
> > correctness.
> >
> > Another usecase of offlining without removing HDM could be around
> > Virtualization/passing entire device with its memory to a VM. If device=
 was
> > being used in the host kernel, and is then unbound, and bound to vfio-p=
ci
> > (vfio-cxl?), would we expect vfio-pci to add_memory_driver_managed?
>
> At least for passing through memory to VMs (via KVM), you don't actually
> need struct pages / memory exposed to the buddy via
> add_memory_driver_managed(). Actually, doing that sounds like the wrong
> approach.
>
> E.g., you would "allocate" the memory via devdax/dax_hmat and directly
> map the resulting device into guest address space. At least that's what
> some people are doing with

...and Joao is working to see if the host kernel can skip allocating
'struct page' or do it on demand if the guest ever requests host
kernel services on its memory. Typically it does not so host 'struct
page' space for devdax memory ranges goes wasted.
