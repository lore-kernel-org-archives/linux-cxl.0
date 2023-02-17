Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4715DC05027
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 18:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBQS7C (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 13:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBQS7C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 13:59:02 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6005FC6E
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 10:59:00 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id qh27so2146338qvb.2
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 10:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1676660339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=120DZvQoUAyoMne1gLDdZW6VztRdluB/SNtOtp0dBXE=;
        b=HWHnbkjRQnNSEIxrvSuNgw015iDG0UYGSMRYvdvlCFyUG7IA88QJ/cgIw/BJiQkuqH
         SGBe/v9bzJ6x2dT13OGpv+bdX+oBZmtOWpzXvX0q3u/BfSOA8hNmPCw6EFJzppSBUhWh
         583c+E/4UWXb9hHPC9vI/qkWrNYmafdPHp+OWYXj6eQIVU3LdUF5I/VKMGMdHoH7rre6
         lBRNnsBDgBT7yJe2fBicS9PhitY1TBVqVywKHO5vvkm80sl6X0lQMrlE/o7yV+l0PSkp
         uHnaX0z9g1cVbP2Mh+pgohKxIiy7kaMlj75mfv5DgeiOpcUI3kbjbv55A9a/2z5pqjIu
         D8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676660339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=120DZvQoUAyoMne1gLDdZW6VztRdluB/SNtOtp0dBXE=;
        b=pi/sQ7wZXfTq/PftAOTSg8QsSh55VgwkDZfNizsZwOHwE872Cl4CyO0EVUKe/+d+gv
         M3zKaLrUP8rOI04er5ZX9annuUL4W0TMk6ophOGhsRydLgR/oJoLkpxhlPjW5Y38NVzz
         K/uqbi1MqnWQmlPZQ/K73BkeZeLMUPCrlpud8w0HOmhE8k/ah1iTcFrzHo7qiov/7LQT
         8gkRJqo3hlpM4Xpl8EymEzv6HCmO4xuQzxP1j7oFwGitAjbXJjRZARGf+q3Fs7zR8sm5
         wnTQQVyKZu7GIkN8OiEPIsuC4YT1DOJkOj6dBxp5nEdu920mGP0Uh8HZy9qhDGjPbe3X
         qNBg==
X-Gm-Message-State: AO0yUKXy6keZTGVu5sk4f7FJPiKNPt3y5EV6tptQEfiQsOMbyYQ9axMm
        Af6jfd/pYVEzNMJii07i7rV+DTPXcz8nFTtUao9sKQ==
X-Google-Smtp-Source: AK7set9sQXjvibYlOfpGG1s6aZBjsxvI/qhbl8oed0I1rQzHNLQ/EEclbb0BeC8mX0HIUmptFecbhFBs1chcqz59q4E=
X-Received: by 2002:a0c:e006:0:b0:570:7e91:3927 with SMTP id
 j6-20020a0ce006000000b005707e913927mr389684qvk.76.1676660338988; Fri, 17 Feb
 2023 10:58:58 -0800 (PST)
MIME-Version: 1.0
References: <167653656244.3147810.5705900882794040229.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167653656244.3147810.5705900882794040229.stgit@dwillia2-xfh.jf.intel.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 17 Feb 2023 13:58:23 -0500
Message-ID: <CA+CK2bD=Vp7UoYyrtNs3sLvdCZ_nTps0FQYV6MOp-Fni0MAtKg@mail.gmail.com>
Subject: Re: [PATCH] dax/kmem: Fix leak of memory-hotplug resources
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, stable@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Feb 16, 2023 at 3:36 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> While experimenting with CXL region removal the following corruption of
> /proc/iomem appeared.
>
> Before:
> f010000000-f04fffffff : CXL Window 0
>   f010000000-f02fffffff : region4
>     f010000000-f02fffffff : dax4.0
>       f010000000-f02fffffff : System RAM (kmem)
>
> After (modprobe -r cxl_test):
> f010000000-f02fffffff : **redacted binary garbage**
>   f010000000-f02fffffff : System RAM (kmem)
>
> ...and testing further the same is visible with persistent memory
> assigned to kmem:
>
> Before:
> 480000000-243fffffff : Persistent Memory
>   480000000-57e1fffff : namespace3.0
>   580000000-243fffffff : dax3.0
>     580000000-243fffffff : System RAM (kmem)
>
> After (ndctl disable-region all):
> 480000000-243fffffff : Persistent Memory
>   580000000-243fffffff : ***redacted binary garbage***
>     580000000-243fffffff : System RAM (kmem)
>
> The corrupted data is from a use-after-free of the "dax4.0" and "dax3.0"
> resources, and it also shows that the "System RAM (kmem)" resource is
> not being removed. The bug does not appear after "modprobe -r kmem", it
> requires the parent of "dax4.0" and "dax3.0" to be removed which
> re-parents the leaked "System RAM (kmem)" instances. Those in turn
> reference the freed resource as a parent.
>
> First up for the fix is release_mem_region_adjustable() needs to
> reliably delete the resource inserted by add_memory_driver_managed().
> That is thwarted by a check for IORESOURCE_SYSRAM that predates the
> dax/kmem driver, from commit:
>
> 65c78784135f ("kernel, resource: check for IORESOURCE_SYSRAM in release_mem_region_adjustable")
>
> That appears to be working around the behavior of HMM's
> "MEMORY_DEVICE_PUBLIC" facility that has since been deleted. With that
> check removed the "System RAM (kmem)" resource gets removed, but
> corruption still occurs occasionally because the "dax" resource is not
> reliably removed.
>
> The dax range information is freed before the device is unregistered, so
> the driver can not reliably recall (another use after free) what it is
> meant to release. Lastly if that use after free got lucky, the driver
> was covering up the leak of "System RAM (kmem)" due to its use of
> release_resource() which detaches, but does not free, child resources.
> The switch to remove_resource() forces remove_memory() to be responsible
> for the deletion of the resource added by add_memory_driver_managed().
>
> Fixes: c2f3011ee697 ("device-dax: add an allocation interface for device-dax instances")
> Cc: <stable@vger.kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha
