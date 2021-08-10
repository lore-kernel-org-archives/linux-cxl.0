Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A47C432BE
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Aug 2021 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B555C60E52
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Aug 2021 15:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbhHJPVm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Aug 2021 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbhHJPVl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Aug 2021 11:21:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A44C0613C1
        for <linux-cxl@vger.kernel.org>; Tue, 10 Aug 2021 08:21:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b7so1712232plh.7
        for <linux-cxl@vger.kernel.org>; Tue, 10 Aug 2021 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTeuieYFo8ENaGwfkNtTCgQpsZjGUZAe4ytDOG3HS6Q=;
        b=YG9cF3SxMxGuZxmRz5+wU4aeeqigOSE3soVInU2XySjoVqNvPM6aCLbEoa+273dSsR
         xstlnXOnJgflyQMjvWh5RmOpWzOm+wppgilWvyrsrB6g+gKPNGQauC6ocrMD1q8fTzo7
         C3E1Jcp4xcIAEXzcka1jNb2uixsI30YzbEMJBqHQ69CyS/D3Qu2LhcozwKkZJ9dxkTjz
         7kXg81beN++3XQ/GQo3H0bPrwMirC93zNGEtCobCnKzJ/Xwr/L6P4CY0Wb3PAfHsNLO/
         beXhmR2VR7ZB1KN56t6xYSc3p77ls9mPT/d5oeg5tsI/GLLmRxZTp8FpH0viTf9W/YdR
         8VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTeuieYFo8ENaGwfkNtTCgQpsZjGUZAe4ytDOG3HS6Q=;
        b=haGgaaR6wSNapooK0QjvQFogdfJOst5Tlzk+gTW80cvwc0Us8tU2Qwzg8Wkb4VHu/c
         EGaq3KLRI2WfgY24gDwr7YQBsBNJ44832HRjpE9BrCtJiRYhwtJrS8kAWLJLtjGE6wKr
         sM55xvdmLefM71uhowqm4FZ8Za/pTEviqBckEBNDEI/vQdDmZLmzb/kVyJjxLoYH5kAo
         msUtJBs6NbfQUSNur9QJ3BfYs4dV0o3ehsm9oXm7yNk3O3CJFJWOgNht7NoqaxDgY/Ti
         eMwxd8R+qm/Tlo/ndBzXqsp4xHxtnA86JC0DkJwJaQDzoEjH4cD8dmU/2gefN6W53p36
         UFIw==
X-Gm-Message-State: AOAM531fBmmIG3PCC7YuMyXaK66936gYV61f1Iz6ryxD52c3b5IepwTq
        /+PJZDixImwrNA45T5CXPAltTar/v7+9zJfI0PVggQ==
X-Google-Smtp-Source: ABdhPJxNyBPxdejAYbv4NgfllrXKzGTDydYq6kDn/YU0qOEMlBo2sldIuizFv39iDX5nEMjMNFWG3JJ/WFym27JtJ/Q=
X-Received: by 2002:a63:311:: with SMTP id 17mr842399pgd.450.1628608879272;
 Tue, 10 Aug 2021 08:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210811001850.GA39621@montage-desktop>
In-Reply-To: <20210811001850.GA39621@montage-desktop>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 10 Aug 2021 08:21:08 -0700
Message-ID: <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com>
Subject: Re: CXL 1.1 Support Plan
To:     johnny <johnny.li@montage-tech.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 10, 2021 at 5:24 AM johnny <johnny.li@montage-tech.com> wrote:
>
> Hello,
>
> Current CXL patches [1] focus on CXL 2.0 support. While in the real world,
> CXL 1.1 capable host and EP are the first CXL components end user can use. May I
> ask community plan on CXL 1.1 support

The expectation is that CXL 1.1 is BIOS / platform-firmware supported.
Just like the OS does not have a driver for DDR and relies on the BIOS
to describe DDR resources via generic ACPI tables, the same
expectation holds for CXL 1.1. CXL 2.0 explicitly adds features that
exceed what platform-firmware can support with static ACPI tables.

Something is broken if the OS requires a driver for CXL 1.1 device
operation, at least for the generic memory expander use case.

Ben did have some improvements to lspci to dump the range registers of
a CXL 1.1 device:

https://github.com/pciutils/pciutils/pull/59

...but it does not seem the pciutils project has accepted that work.
