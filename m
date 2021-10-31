Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F59CC433F5
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 20:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBAA60EB4
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 20:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJaUFx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 16:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhJaUFw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 31 Oct 2021 16:05:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE797C061570
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 13:03:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a26so14393025pfr.11
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfRzUlr72wcEtJUDpUZipof4EYrmRT0ogUdIlVOMnhM=;
        b=41st4Xfp1kUuuVwj5szpdRrVNO4YLZX5iu2wO8NirIRXIRIwfLklTM7Yt1wUl19M9m
         kFl4f8MIC/38KT8pixICpj7ezOMjxcGcSx/jsLS+hf1hGKXetsVSGrlVAWYKUdrbT343
         cJ7eXYaxGSh5U3Y5Ok2NCxbrJQO/1gdd84KAqpQcNm2GPci7MeeddLZVfmDx1I6ZKLkb
         VB6Bil1ZgEwE33sOGlIEzh09nlv8aMNLv7cvir9eN3eQ5PSU/maA2e7BDH4EdLe3eFw6
         pyggRAcWWvlg37l5dqU9KwW06q5YDuA6vM6eEQeyL0ET2p7psfQclQxK00q2Byh/wotg
         418g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfRzUlr72wcEtJUDpUZipof4EYrmRT0ogUdIlVOMnhM=;
        b=3Yjuq2XWNhAkrhI9gDF11nL8djETxnUKogg+gq9Vj84Oq3SJUzvBpzcPKRfUiNxsiy
         WrWqqj18C8S6HWWiIqLD6pRyq+Z9MBSsl3oyiTpsNapVsp10u5J7+wD90hfi1+Dwasu/
         NSJNRtgLJamHZikEqFCYB0GMoF+9oWMrNJf9efzoq/U6nzIWKnaHW7lVff+nW7SIsvxD
         g0FhM/SuxWJM1asA0pJzycCDAoKxnW0MGcjVOMtvZ+fJwJDanglaTh9LSR4b9sOVyYDH
         3Im3YFZOv1U7YxpPsumk4Kj6fTEf98Hs6bbPN54giHc+WfI94ZYMeBjatts1v8y3XOy4
         fsmw==
X-Gm-Message-State: AOAM530SQBja7O5Hzlr1hZB/PVZUix/wzM4MlihWrb60nR6+0IFcJNqC
        kXk+7XKTc/EdfN4a5UnRXIc94IG4Pmwko/W6OiUtWg==
X-Google-Smtp-Source: ABdhPJw9Dg8vdjvBoSRpu/jiAtF7FbTONdvdjC3/qsDlviGOY/HgTEsZ1nf5meeWzzNjaeFQc3ALk6+LTHzhkdk2xzw=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr5316159pgd.377.1635710600349;
 Sun, 31 Oct 2021 13:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <163555506776.2553440.17247681249660176777.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211031183123.m6wors3hizsbm7cd@intel.com> <CAPcyv4i7iakV7drgPwVjBRgB-j4EhahtQn6B0mhGaAx9RKOWpg@mail.gmail.com>
 <20211031184150.blkw7ioxo3ln6hkk@intel.com>
In-Reply-To: <20211031184150.blkw7ioxo3ln6hkk@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 13:03:10 -0700
Message-ID: <CAPcyv4gwot9cF5gi1sDHksB7Xwgv7DDvhhDAtQ+cdFu+hpF2Kw@mail.gmail.com>
Subject: Re: [PATCH] cxl/core: Convert to EXPORT_SYMBOL_NS_GPL
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Oct 31, 2021 at 11:42 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-31 11:35:11, Dan Williams wrote:
>
> [snip]
>
> >
> > I can't see any reason to have plain EXPORT_SYMBOL_GPL() for these, we
> > *want* other users to declare the CXL namespace.
>
> Why do we care if they declare CXL namespace?

To indicate their dependencies on the CXL core, i.e. the rationale for
symbol namespacing in the first instance.
