Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649F1C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 17:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499C261050
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 17:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhKBRta (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhKBRt1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Nov 2021 13:49:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBA9C06120A
        for <linux-cxl@vger.kernel.org>; Tue,  2 Nov 2021 10:46:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g11so8852790pfv.7
        for <linux-cxl@vger.kernel.org>; Tue, 02 Nov 2021 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1Rrs0cEbLqPa7Hx2ePPuXhOZ/gRmPRTTNB0leA99WQ=;
        b=ZVbdpR6kBn4wHfNBznCi+TaMspQd8U2qEY6xrZkqsjutbX2Y6W1wgq86rJrjYEaoeV
         24fBzisgLLXXUd4Dbjd0b2JNSL7Nl8WMsYCoUnjmnzY8RicvBTXFtgj29Vn4XP5mjRcb
         mHY0tvJzCUXmzLaRQBMwi12xaP8Uus62PU8mF7Y38+ittb40Dml2GDKs/g1uWfM1Mk3S
         mcpH74lzl21+Q+zp15xil5p2cJg+pmTL5wYdh6iQOlYHYCyes0vAl36wSDtz9awkW+6K
         0nDg71HN6PTJSEj3Svx+FUCfDjK4U3ikEx/iyEybaiozNrxfr+hD5jQlsd7JlqE8g1pg
         cUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1Rrs0cEbLqPa7Hx2ePPuXhOZ/gRmPRTTNB0leA99WQ=;
        b=ZY0Q+Fq4357Ds5Te8vyobn4shFVbyeWq67qRqLoUQntArgz1f5npNAbW8kKQT6vHPO
         2akFdOJpsKaz9YLloVnWKjfqzbHVERs7wHenBhsi7S0S9QaXVMYx0k/DEHBbi+mshwAb
         VijPNQnco+AUB0ip61BBqdxlhNyb72BU1bUhi6ANpzjsuDVbH0rQp5pdb5rjV8V1KVIF
         SOJlLBkLBOpF6jsVUPzSi4RxN5Q3SZBlBkJkW46Sl+Nygh/6yDTZNi1eLtsjZhJDrE2o
         9dBecYJ8COEsQrynzpFjyCrQZBy+Qkuo99wdnP07R5flG1U9+CT+mtbIQ0fs9E03MdfK
         vyBg==
X-Gm-Message-State: AOAM532SeXP6PRmyy/Rup6MGrYLFSoiGbRBRkVUNbpQ81bZyve1Gd93D
        9YK0Jo6i2DrBz8M0HKGiHTQ6irGOjSk+FivHyD0VpQ==
X-Google-Smtp-Source: ABdhPJwEnVAbnhl705/SOwx+VT3uJWnXgSzstjkQ8EoAuVFVa9ZwzUCDeTXHToIKO7/01l2eQ22acLdGFRf2JHtcNdA=
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id
 j25-20020aa78019000000b0044dd7616f79mr38496361pfi.3.1635875212010; Tue, 02
 Nov 2021 10:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-10-ben.widawsky@intel.com> <CAPcyv4j+mv3+FyJd0OVBe_dUqzzYpS2gkEagiRp-Tqh9t7NMmg@mail.gmail.com>
 <20211101170750.sajcmjxdv5rajffe@intel.com> <CAPcyv4i-8oRjOPywtNwBef3irb8b44PzwBrEUdQ0Bxrzrju5+w@mail.gmail.com>
 <20211102163121.hyfj7yceainmppmk@intel.com>
In-Reply-To: <20211102163121.hyfj7yceainmppmk@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 10:46:41 -0700
Message-ID: <CAPcyv4iQzHeF8cth4VGGMpAT-3d6T=6knCq5fnt+Yt1ucxbW8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/28] cxl/acpi: Map single port host bridge
 component registers
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Nov 2, 2021 at 9:31 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> It seemed like a very simple thing to support given the port driver's existence
> so it was added to remove a TODO. However, I will drop it as you request.

I'm honestly asking the question why this is needed and more
specifically why this is needed in this location?

In other words, how is this case different than typical component
register probing that is done in the port driver itself? I would
expect the TODO just gets deleted by the port driver addition.
