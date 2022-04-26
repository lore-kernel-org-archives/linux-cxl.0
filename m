Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F616C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Apr 2022 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiDZRXZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Apr 2022 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiDZRXQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Apr 2022 13:23:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373244B871
        for <linux-cxl@vger.kernel.org>; Tue, 26 Apr 2022 10:20:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q8so7685123plx.3
        for <linux-cxl@vger.kernel.org>; Tue, 26 Apr 2022 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7c0uq9JnNfDiWuyB+f0L/MlFaExF410QQ2JjeZoTEU4=;
        b=vJL9pTa6L9mgfdwr9Lit5w0U5O3zrEFVzsNMebnk7gqmF9Tb7AhVnfQwVLCufpiUOg
         YcUiTPCvVX2EfkpLqJt1ksteRb56L0XrVRCDrYba9I4/VW8jboU5J7XyjJA3QlY45d6t
         qyUrdmjBxvuhgxAysx7st3ICCRAUvlLBHzkiAgi8mR0AdwaMod2tygj6+TcIKLyX3Aj4
         oBIVkVKY/f5/nh1iegppK6oNdYBCX6WQ3k/FmXV1uB92CTY9CUVXBLtOy7brO2JDYIjF
         l44JhdibI4nniRWiBwXFnq0Q70yHS7elp2dKSCYvfmmBBOJoyKtq6TC2663jNScs3h3P
         xvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7c0uq9JnNfDiWuyB+f0L/MlFaExF410QQ2JjeZoTEU4=;
        b=g1fhzXTv01yPuWNu8sCdy8JJ65W187VRJe/pbg1cRkj7YIh6fVql8EjcqRoK9J0b0d
         Pj244884L8Xl1TqcEBMZZ/gMB0o5k09JQWM9S/h2BtHhsvvRUikGK2Yy74eHPaPpJe7c
         Ci6d2hDsLEjABhmlx7kB/SzJp/gzea0q0Rra4tjxcGL7c6pvEQS83D08vPntkXnrbqut
         FmvfJm7UdpRY0ra+F8xFYcYcIIfRCOUS6QXdteTaesxDUwxW2JmprhKDXyzl7uIiqE0e
         pbM22GOlq8MpcEV/WPsoLtpP3FElZXnEMr5eGF98BfRvb53Ysjxn2pNTCkp/v/57zwUo
         fcYw==
X-Gm-Message-State: AOAM532oPKI/fjkN/hBpomu08ynTmHB8jkbxbaSZi2Pw/9y0qtXNFm5S
        edRcVLqyaMciLj4YYwRUOr5thuytQ7Dxm2OuekYb6g==
X-Google-Smtp-Source: ABdhPJxZa+lZlri7DKIxbhPIo5seE3cJZsd4vi6iTmkQDzEQmtW6YKzCD4YtvIb8M9Qmpfv8AgKeO3fQnXclyPYTR94=
X-Received: by 2002:a17:902:ea57:b0:15a:6173:87dd with SMTP id
 r23-20020a170902ea5700b0015a617387ddmr24946802plg.147.1650993605757; Tue, 26
 Apr 2022 10:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220426180832.00005f0b@Huawei.com>
In-Reply-To: <20220426180832.00005f0b@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Apr 2022 10:19:55 -0700
Message-ID: <CAPcyv4i+=ArjE7uH_jKGS+B9-dLJ3An_T+NgWB2xqC-7Zh-VYA@mail.gmail.com>
Subject: Re: CXL type 3 which doesn't have cxl mem enabled.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 26, 2022 at 10:09 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Hi All,
>
> I ran into this whilst debugging why on the current QEMU code
> we now get a probe failure for CXL mem due to the range 1 size being
> non 0.
>
> The conditions for whether we have legacy ranges programmed don't
> take into account if Mem_Enable = 1.  That is if the
> DVSEC CXL Control Mem_Enable bit is set on the type 3 device.
> If it's not then there is no existing user of the CXL memory
> setup by firmware or similar so we can switch over to HDM
> decoders and it doesn't matter what is in the range registers.
>
> Unfortunately the QEMU code was bringing the device up with
> Mem_Enabled already set.  So I fixed that.  After all default
> value of that bit should be 0.
>
> A few problems then showed up.
>
> 1. Nothing in the Linux code actually sets Mem_Enabled to 1.

That's because the device is supposed to, I though, set it of its own
accord as a result of link training. It's an RO field in the spec, so
Linux can't set it:

8.2.1.3.3 DVSEC Flex Bus Port Status (Offset 0Eh)
"Mem_Enabled: When set, indicates that CXL.mem protocol operation has
been enabled as a result of PCIe alternate protocol negotiation for
Flex Bus."

> 2. Probing fails in mem.c as wait_for_media() checks for
>    info->mem_enabled (cached value of this bit).
>
> So, dirty hack was to
> * drop that check in wait_for_media() as media being enabled doesn't
>   have much to do with CXL.mem protocol being enabled.

Per above I think it does.

> * Make the check in cxl_hdm_decode_init()
>    if (info->mem_enabled && !global_enable && info->ranges)
> * Immediately after enabling the hdm decoder global enable,
>   also set the Mem_Enable bit also update info->mem_enabled.
>
> This seems to work, but I can't help thinking I'm missing something.

I think QEMU should just unconditionally init that value to 1.
