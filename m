Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AABC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 22:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7285D61186
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 22:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhIIWFH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhIIWFG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Sep 2021 18:05:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A35BC061574
        for <linux-cxl@vger.kernel.org>; Thu,  9 Sep 2021 15:03:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s29so10715pfw.5
        for <linux-cxl@vger.kernel.org>; Thu, 09 Sep 2021 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUxwV6XCqqMFLWzFgkmAURBDJPUK/ez7E/Hfrb4Mumg=;
        b=evxYXoGg4eg8cWiXuzfXe/L4RVHHKvaWSH0l4/IBgGEeaeS1SGWmzqcM5KM7qEOgci
         gOAF7ndJTA2njgP4/uurVsaxm8HhUAbHfyVJ/YAEjHlJA2tKz2bCt+xUyXk5kHq5vmk2
         IAC3e2/WnSEjckeKLrfCDNPsbenOxtbina4c3SAExPEyJCDMGiZ7QI5ZzMagwRan5DnB
         OK4QKr+u/ofqbNBL9o5eHGdJ8Qd208EYIV11Hh4mFh/0z5dy6DhXGMVjPrKuRa0TMLou
         N0dPiGPcF9gFU/aVHM9k8YsXoWL7o/HJwYEiaIQWtDCEXf/EqDnHaW6gzlQ7D4FKsco9
         e5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUxwV6XCqqMFLWzFgkmAURBDJPUK/ez7E/Hfrb4Mumg=;
        b=KGmJOMzYrhZfi9iwbCCYC6d95d7JtFeSCtLKCOZK0R1bEdNfKUNG0Sl4i+XDbUR/uc
         ELTsTyMe1E87mPsJKCFAQH074GdvVF0mQk45nwZkCVMKDAKvTrrYXvyBEjSQ0CBF5wzt
         hyqKTjScUbhOx989nz08SZbU7Qjvc0Iy1XMqTFMxsEdbTdMC+Uqw9eTEnqhX36mI2m1o
         3bnoifjqoXDWLrrbGwL5bWWvtutolwUzQSiL/EIa+4Nva/HhoPggAqy5YcbqSfplRogt
         D7ikijU4Oxy5CJyByDrKE2KKyUHqROPoM2lY+GUCDa7hWVlCJffq719LRTToPBWsYgtN
         Au6g==
X-Gm-Message-State: AOAM532NPug/T+zQ1nUGLyT/GVBTGYt2p/xOhtovnV/+Xf6QkHoGV3Zp
        97QHSf6VmUfqkK8gxYwiYjBL5d6eyqlX+N7AfSdFEs1DtSuSvg==
X-Google-Smtp-Source: ABdhPJwN4VkDehh5MoaNKQCkMxukEOavBsC4R75tW1GnnbiLuwe6PWvWWw5a5uQ+t10mDLPngeuM4992FD+g/SD/x7g=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr4971964pfb.3.1631225035680; Thu, 09
 Sep 2021 15:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116437978.2460985.6298243237502084824.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163116437978.2460985.6298243237502084824.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Sep 2021 15:03:45 -0700
Message-ID: <CAPcyv4ixJZTZF-d0nmsLv2BQ+X9F-Ph_khG4i5pyksNniY_q_A@mail.gmail.com>
Subject: Re: [PATCH v4 16/21] cxl/pmem: Add support for multiple nvdimm-bridge objects
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Sep 8, 2021 at 10:13 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> In preparation for a mocked unit test environment for CXL objects, allow
> for multiple unique nvdimm-bridge objects.
>
> For now, just allow multiple bridges to be registered. Later, when there
> are multiple present, further updates are needed to
> cxl_find_nvdimm_bridge() to identify which bridge is associated with
> which CXL hierarchy for nvdimm registration.
>
> Note that this does change the kernel device-name for the bridge object.
> User space should not have any attachment to the device name at this
> point as it is still early days in the CXL driver development.

Apologies Jonathan, missed your:

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

here...
