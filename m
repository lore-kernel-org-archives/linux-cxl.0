Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A69C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 17:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C37611C7
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 17:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhIJRsG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJRsD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 13:48:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF10C061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 10:46:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id jg16so5856959ejc.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgWBO3Uv9OBhCwBG8vrFyyijHoDLNm3JMHSrjA1m4d8=;
        b=XY8cCc3ccfQuqITVPZKEVJENTylrP0bm3hfzg/071pJ3z57Ovb6Z4jBpg3l0jHjFez
         v5fvEjI3t6gWhouiuxBKNwltOiokgasQvdwSPafa0PKvnwQ1j/y0QvvYBmw1oGuGHtkX
         yoiU3faPL1nLPr/J+0dlpc3ZszH0v/3HvqjAuUhz6vVlYw0nQthe9oTO1WPvkbkS/BrO
         9D/yONYnh6X22yo+9v03LtTFiaDajcILbE/PAyIx8RSPyFbO3qBjBZm3jL7KFispLqVD
         aoRLkS5LNCRiQQF4wqnePFNIZlXGb2eL0XfUUm0Ag0Uk+lyEuzlpxo/rY2wf/GMKy30z
         TPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgWBO3Uv9OBhCwBG8vrFyyijHoDLNm3JMHSrjA1m4d8=;
        b=0axiIIGGRrxnKp2C280mIPaBgBo9lecHlv9VGtlW9jbIGvgigwU8/hReueBEacecl1
         k2HBs68X9fPwqYmA7ULAz7k+LyCfobkrwWsxamyMa6PGi1BCMdEc7BOQ0I+08S6YwNHG
         iJ8L8qPERqUbWwiGQGDRI5gZS/eSuWuZMLvmeovf1TVM/6duB61pf2ULWO9TiN8NJl5C
         quv8qEDGIoaLdmvksycp2EBCm1ZdXON/bkzGzI1kOPmJoXtiAutjk1bmV9ubxnOybClj
         PzomTAlawMpRotP78kxxwvNYIuDVfnXXfjaemGxI7sX87SRk1ederGH21RNWZ3FoD/io
         kACQ==
X-Gm-Message-State: AOAM531BKgWN/6A7cetcR5TFIQFy7BY0RclJVb8qocff//tmPD4LMS+l
        kDVep0MlOgP7MF/SzlMFMij4X+9gYLMBkgdDi13S
X-Google-Smtp-Source: ABdhPJyV4xLiAbcfLLKEYf7PEqfauqat1zMHSc2hlfKLjsRENAKUgQD4yxDupel9mDWlsLPIj9tZrVQM41UBekdsiF4=
X-Received: by 2002:a17:906:f15:: with SMTP id z21mr10455115eji.177.1631296010371;
 Fri, 10 Sep 2021 10:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163072204525.2250120.16615792476976546735.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHC9VhTNu8E9WkzUHbQC9xKK5U74L8oqetUtPXGX2RSofMcqgw@mail.gmail.com>
 <CAPcyv4gR+WbYf-dT0niT23UY8jZZVBXMk4R-1_0exPcbHrs=0Q@mail.gmail.com>
 <CAHC9VhTo-eV4oUF-ia67X-KK-qyB=M0xDv-=p0-xA-4=0BJ6uA@mail.gmail.com> <CAFqZXNvSu2-nL8YEfKhEdT9csm1=nxecoo31FF+jgwyCVdjPMw@mail.gmail.com>
In-Reply-To: <CAFqZXNvSu2-nL8YEfKhEdT9csm1=nxecoo31FF+jgwyCVdjPMw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Sep 2021 13:46:40 -0400
Message-ID: <CAHC9VhR3_yC4YcuK1qRuU2Rq=bOq7Y4=E16qcF9zBT0khvy6bQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] cxl/pci: Fix lockdown level
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        stable <stable@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 10, 2021 at 8:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> And I can see the patch is now in Linus' tree, so if Paul agrees I'll
> rebase the patch on top of v5.15-rc1 once it's tagged ...

Please do, thanks.

-- 
paul moore
www.paul-moore.com
