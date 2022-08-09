Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE3CC19F2D
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 13:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiHINHX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiHINHW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 09:07:22 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006E76301
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 06:07:20 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id bq26so2793972vkb.8
        for <linux-cxl@vger.kernel.org>; Tue, 09 Aug 2022 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UOAoK7IQMDEeEt2nG0iFjgejZbUhappL+ozDYl4kVTM=;
        b=ndy6eHbL2RDYtNCD+/sq27rColzXawZxes8IjgNVhUO6x4qm8+PMTW3h8MaUEf43Nz
         ZNPg9DX92h/XoRc35dnWEazbQJC0yVesA0XyrbhMfE2DJkLNdEwQ0yLzNzA7x+sW5K6a
         RYK8p7qOjdd38JbF4Dpw4RSHR7haMzK0VVfcwNmQ6p7c4JFJbwTb22T5xgSlQM4wL8Xl
         8pNdv97Yy8yOhFqT66OlwL5Z7pRwMfIokW27sVjJQ3hYsUY8JSsG6GS1kt2lJ+O+hg+1
         CVDzciG7zpD9vZeXk5BTO8J92tSL31QH3YkBP1qQB+YxCbGTMqdk37AtpRp1VXBctP7V
         RcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UOAoK7IQMDEeEt2nG0iFjgejZbUhappL+ozDYl4kVTM=;
        b=oJYh5YdmJQYEMDFsEK3axm0OspzpUmDwS7ryj/DTCYhXsax/gfKzBP9skxpiuDGRMz
         Zm3GUQNnOF+YTgaY0DeIN5hAJoqaJYbrog7DI6yhEkwATdfCl49UPBfpTZW1p8f0OfwC
         2aCIzJHFzZYVr4w281dmnOBRVAAkDC6MClQvtD6+jgWGEwneNmcHxphJFtdfZRnSijs4
         kWqtmYpGY83e/pzI2ze/6iVl1V+bMioI4ukomqSpNAlPCnLUAOeM88OsHO28wTRZ8wTW
         zcwuuYz8puAGWaiKknqcrIrd18CUZMGbGDzDMCFiPhPzG4O+BTUpRhRzmHkjKuY0O3b0
         YUrg==
X-Gm-Message-State: ACgBeo0ijadm1NlW5DdYwpq1Jy5wMUHG8xgdcAu6XNlml2sqLq8XMpAB
        cKscZ3DpuV1ogcLPqYxDXXCk5BgWM1K73avKOx8=
X-Google-Smtp-Source: AA6agR472E+2KFImJQlAL0x3/55KMlHGSRENEhSuZ3A3EcI8Ht8WOBCnHy/ZGb6mOCJeC9u46+lajC/6kJQ48pTeoLs=
X-Received: by 2002:a1f:da44:0:b0:377:2e13:1035 with SMTP id
 r65-20020a1fda44000000b003772e131035mr9667902vkg.29.1660050439860; Tue, 09
 Aug 2022 06:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
 <20220808133727.00001171@huawei.com>
In-Reply-To: <20220808133727.00001171@huawei.com>
From:   Bobo WL <lmw.bobo@gmail.com>
Date:   Tue, 9 Aug 2022 21:07:06 +0800
Message-ID: <CAGr_yG36GSO8esyO9nn6OeOEN5zPSosEmBHbfYGwqNGiYOh9vw@mail.gmail.com>
Subject: Re: [BUG] cxl can not create region
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan

Thanks for your reply!

On Mon, Aug 8, 2022 at 8:37 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Probably not related to your problem, but there is a disconnect in QEMU /
> kernel assumptionsaround the presence of an HDM decoder when a HB only
> has a single root port. Spec allows it to be provided or not as an implementation choice.
> Kernel assumes it isn't provide. Qemu assumes it is.
>
> The temporary solution is to throw in a second root port on the HB and not
> connect anything to it.  Longer term I may special case this so that the particular
> decoder defaults to pass through settings in QEMU if there is only one root port.
>

You are right! After adding an extra HB in qemu, I can create a x1
region successfully.
But have some errors in Nvdimm:

[   74.925838] Unknown online node for memory at 0x10000000000, assuming node 0
[   74.925846] Unknown target node for memory at 0x10000000000, assuming node 0
[   74.927470] nd_region region0: nmem0: is disabled, failing probe

And x4 region still failed with same errors, using latest cxl/preview
branch don't work.
I have picked "Two CXL emulation fixes" patches in qemu, still not working.

Bob
