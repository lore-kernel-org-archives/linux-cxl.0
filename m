Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C7DC433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 01:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1039761051
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 01:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhKCB41 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 21:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhKCB40 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Nov 2021 21:56:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B93BC061714
        for <linux-cxl@vger.kernel.org>; Tue,  2 Nov 2021 18:53:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso229565pjo.3
        for <linux-cxl@vger.kernel.org>; Tue, 02 Nov 2021 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WS8F9Mm3PeQjtYh6+wOnJgg0wAkGEtxpJ8h3c0TWJ1c=;
        b=pUap+BjUOXHTKWSn4mrx775hzpnkNzwQHcQDf62Sy3Z4+XV+n6E7+Vq6ZHCAOm+OeJ
         xKDRCaiJxIyl1ykzMv8cD+Zry6/zJ8JrgPyJYXyUdBeJvgmAVgZgFVbWPoWUOkbqagNW
         cGqwhbftfC1k+NknOjvjEIV/LwdQNMyLtDKvjgSewaDXWAzACbFrzSbaaCg7YbguDRS5
         DiHoTmPRD80VvcSkHLwm+KoeE6eONPdNbAQqY9DvBybbfZdhFXlgfs1w28YcPuNB2+mu
         ISIcxj9jq/yaFmMpl+GK5KxnHmkxCVnuWMRMZBuTsrh56wUvC+4BsO8h/Pd+RwNCKsN5
         tDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WS8F9Mm3PeQjtYh6+wOnJgg0wAkGEtxpJ8h3c0TWJ1c=;
        b=BdYSh1IeuVKw0r8yS1tIsZ4sxtQNiyJeda3hx0vJ/ejmqikyOwR9G5I6KZQhXw3cLE
         21rJFSnddD2vii+yTmYMSM2xB+udMduoFeNSJ8hR1g4iQ3AEimI/xCtMPQ09sW1FE5jI
         vliEXi98UwqbYz7APjdzIcLCrnlSRVr2sAcsehb+D1VJIE1gqcjQfCOXJXXgNXbzrIZf
         5bB91xGB3Ys+xc1XPj4LHHzwsE8tH9jSSBsuint7RMizHXa683gRhDClWFMwqjK2hWiZ
         /9/W3r1cICF9fjC0f/zgjGFjBMmURnLGoGaPf26E9/wUgx5ZcvgbkmDxOO3c43pz8xdl
         QS5A==
X-Gm-Message-State: AOAM531/Qj7/bZEDrijl6sFckQa1Ji0nVKlc1R6Eb4kYjoQxJp8jKloq
        qs9Cm6TXKWoenpgxOKXs26osBN0xnToW0jaXOtr21A==
X-Google-Smtp-Source: ABdhPJwuRXTk8BJSxlwrUf1jaK2UsdxSsD7hig10M8l+GDBcmW/wJQjIVruj/nPPmFWJeGVXdoNWPYx5WT42U/WrgxA=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr11083994pjp.8.1635904430927;
 Tue, 02 Nov 2021 18:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211102202901.3675568-1-ira.weiny@intel.com> <20211102202901.3675568-3-ira.weiny@intel.com>
In-Reply-To: <20211102202901.3675568-3-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 18:53:40 -0700
Message-ID: <CAPcyv4iJXzGGMs-o2uJ=5zEf_ZAXZy4vN=2rjMS5b=BzPX0pvA@mail.gmail.com>
Subject: Re: [INTERNAL PATCH 2/2] cxl/cxlmem: Change cxl_mem to a more
 descriptive name
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Nov 2, 2021 at 1:29 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> The cxl_mem object actually represents the state of a CXL device within the
> driver.  This is data layered on top of the PCI or other device.  Even though
> the only device currently represented is a memory device, calling this cxl_mem
> is confusing because this is not solely a CXL memory device.  Furthermore,
> cxl_memdev does drive a CXL memory device.  So changing the name helps to
> distinguish these to structures.
>
> Update the structure name, function names, and the kdocs to reflect the
> real uses of this structure.
>
> Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes:
>         From Ben
>                 s/cxl_mem_mbox_send_cmd/cxl_mbox_send_cmd/
>                 s/cxl_mem_enumerate_cmds/cxl_enumerate_cmds/
>                 leave cxl_mem_create_range_info alone

Looks good, I fixed up the changelog to the following and rebased on
top of the register and DVSEC cleanups that are on cxl/next.

"""
cxl/memdev: Change cxl_mem to a more descriptive name

The 'struct cxl_mem' object actually represents the state of a CXL
device within the driver. Comments indicating that 'struct cxl_mem' is a
device itself are incorrect. It is data layered on top of a CXL Memory
Expander class device. Rename it 'struct cxl_dev_state'. The 'struct'
cxl_memdev' structure represents a Linux CXL memory device object, and
it uses services and information provided by 'struct cxl_dev_state'.

Update the structure name, function names, and the kdocs to reflect the
real uses of this structure.

Some helper functions that were previously prefixed "cxl_mem_" are
renamed to just "cxl_".
"""
