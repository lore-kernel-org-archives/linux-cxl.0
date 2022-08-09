Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A2C25B0C
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 13:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiHINM1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243508AbiHINMW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 09:12:22 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71E1706C
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 06:12:20 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id x128so2781523vke.3
        for <linux-cxl@vger.kernel.org>; Tue, 09 Aug 2022 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rfyfPwglwciXLLR8sWdzJP6xrPyKg3aLqgO210d0WV0=;
        b=FBw4IUt5WJxENoQkmMp49X2Jn1bDo9+nEV9tXfreig+yRJpLMkkgz9Z5uIWX1NUGhh
         AgO4eVZkjHzE7y+uhNITIscji5A8Ox7R7xzB8aJMsi+DweIWi706+aqOPwa9TBLUHZFf
         cTtW7Z/JfnuErxSYEgo+66ZHDVT3qxj3brvXZZFKRgLoMC6VTOOVb7Knzl+YWV+6qUFb
         5hbF4YYvP5AJ6BhEvw8qFYz6OznRraYtTuzj3gkknttvLKWQD/AEdaElv3coBN8tQHy3
         Gkf2zM5VXO7KxOn9TQGaHkuKQJCsMqcj6NyKeP+lzgkFYigI2G/PFCRyjJSbZ4nDj9C6
         pBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rfyfPwglwciXLLR8sWdzJP6xrPyKg3aLqgO210d0WV0=;
        b=1m6FQ7bulDhpyckfl/i1ovROmUMEa6cGizzD9BAY0ITZH6TXgVx0zhi/AVfWLB5iMA
         bQk5SPy+/PnlP5FVdYqJGcLPIKKwa33OmjtS8Gn4lJKLLR4NSOVLZpCHAy2ND0xWF9dw
         ZVWsKijpUpblBsmAhUUQZCQ+hyfDIiohq6YoNGjIJ5YyXmrgo2afghYYKMlnGpxIKdWa
         hlKnD763C4SjyIgTAK9KsWMCL44f4I9m18hj/9zuOq9zMDA8Vtkn0pq6yNOHFsE7ydNW
         PQlVLYImIzB8AGMEl7bV1aB3DJizSUsjDq5L/SThg97i7ngh5zXcAGo+9Bro98slsb9G
         b7KA==
X-Gm-Message-State: ACgBeo1HiLRWvwu7oZ46pq+5tgZINQv95bK/mC4bSrEiHgTunszCU0HC
        3WizgMVs4Eu9zZ7L72Z4xQ7aG/B31CiV62haOxE=
X-Google-Smtp-Source: AA6agR5k468yuHcJpndNTOEPro5TPqeMcnojIS2nPInj35w8yeUpE6bE8rA/AU8tPtr1XsvW+cRS2o4zZ/KrlhqUbrM=
X-Received: by 2002:a1f:a7c4:0:b0:375:52b4:8249 with SMTP id
 q187-20020a1fa7c4000000b0037552b48249mr9636797vke.31.1660050739152; Tue, 09
 Aug 2022 06:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
 <62f132aee401b_1b3c294c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62f132aee401b_1b3c294c@dwillia2-xfh.jf.intel.com.notmuch>
From:   Bobo WL <lmw.bobo@gmail.com>
Date:   Tue, 9 Aug 2022 21:12:05 +0800
Message-ID: <CAGr_yG389Bm_NL8CLgo_ZkGd4staocNENbtb-ULVA5vh_ywmcw@mail.gmail.com>
Subject: Re: [BUG] cxl can not create region
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Dan,

Thanks for your reply!

On Mon, Aug 8, 2022 at 11:58 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> What is the output of:
>
>     cxl list -MDTu -d decoder0.0
>
> ...? It might be the case that mem1 cannot be mapped by decoder0.0, or
> at least not in the specified order, or that validation check is broken.

Command "cxl list -MDTu -d decoder0.0" output:

[
  {
    "memdevs":[
      {
        "memdev":"mem2",
        "pmem_size":"256.00 MiB (268.44 MB)",
        "ram_size":0,
        "serial":"0",
        "host":"0000:11:00.0"
      },
      {
        "memdev":"mem1",
        "pmem_size":"256.00 MiB (268.44 MB)",
        "ram_size":0,
        "serial":"0",
        "host":"0000:10:00.0"
      },
      {
        "memdev":"mem0",
        "pmem_size":"256.00 MiB (268.44 MB)",
        "ram_size":0,
        "serial":"0",
        "host":"0000:0f:00.0"
      },
      {
        "memdev":"mem3",
        "pmem_size":"256.00 MiB (268.44 MB)",
        "ram_size":0,
        "serial":"0",
        "host":"0000:12:00.0"
      }
    ]
  },
  {
    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":"0x10000000000",
        "size":"4.00 GiB (4.29 GB)",
        "pmem_capable":true,
        "volatile_capable":true,
        "accelmem_capable":true,
        "nr_targets":1,
        "targets":[
          {
            "target":"ACPI0016:01",
            "alias":"pci0000:0c",
            "position":0,
            "id":"0xc"
          }
        ]
      }
    ]
  }
]
