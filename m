Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152AC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 12:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E40603E8
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 12:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhINMXd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhINMXb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 08:23:31 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF6EC061574
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 05:22:14 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id z12so8249640qvx.5
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4EfrPUEpZjNfYI9C9dwg47FwF8i42QF8x9451dn0m4k=;
        b=HksAniPk7LVuwk4QXw91xIeDEH63QADXXNCPrzlxfG58hI6T4TKL6ofbJJbK1Cmy31
         bUNdjy3bmOx7A5P8l51h7wl+w8eCfufrBSh10bRXxZY+Mlj2Z9yW1qJ+AvThPBY0j82d
         I1CTpm/Z4MNDRo2KQqSkAdeNaCj6bq9dko9H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4EfrPUEpZjNfYI9C9dwg47FwF8i42QF8x9451dn0m4k=;
        b=GUlXaTMCULWxmT5dRB8B7H8lPygLrY2U5lS42Z+B4aEBWSP/GbrIRcUgCuIsmvaerz
         nB8ENoMN6rc06bDEVEHB86GTwKktxD0/2R4CJVeweFDWThfpIV8BGGvXKFKq73v6ITia
         3lWrVc+jTMrfQrKtUZNkBU2MjnieIJbTKdOCH1qJIBmZB4mDouc6hmeUR/jqZhc5GMHo
         hGKX3aFCL+uqLbqF6h3jn7UzvS5kQsccPToo0ClFlIQRYxieIucMlbw+PdrBTxtnBpbA
         jzpdCkMUlnpgCxVUXfvqNHt/qIgxhj+gt1dvxedKUAZOPlvpCFzcX/uCxFFCb6yRjohv
         LohQ==
X-Gm-Message-State: AOAM533qeUl64H+hoov3KEIddxwTi+hj2xeqDBxUa+SEDdslDhec2d+X
        FPF+kRFBQV8a084rKuNRoGGvEw==
X-Google-Smtp-Source: ABdhPJyvEG2pQ5qGBNdlYnK7urBC3ENhewUIxlVZV2tRwF3c8rp5TYOrYBYYbckZqoPkRVEs7E9ZVQ==
X-Received: by 2002:ad4:522c:: with SMTP id r12mr4831569qvq.17.1631622133662;
        Tue, 14 Sep 2021 05:22:13 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id a22sm5904669qtd.56.2021.09.14.05.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:22:13 -0700 (PDT)
Date:   Tue, 14 Sep 2021 08:22:11 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 14/21] cxl/mbox: Add exclusive kernel command support
Message-ID: <20210914122211.5pm6h3gppwfh763t@meerkat.local>
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116436926.2460985.1268688593156766623.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210910103348.00005b5c@Huawei.com>
 <CAPcyv4i48AHtHOAJVsDKQ+Zg2QqnvQg1Ur8ekb6qR6cRDbkAzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4i48AHtHOAJVsDKQ+Zg2QqnvQg1Ur8ekb6qR6cRDbkAzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 13, 2021 at 04:46:47PM -0700, Dan Williams wrote:
> > In the ideal world I'd like to have seen this as a noop patch going from devm
> > to non devm for cleanup followed by new stuff.  meh, the world isn't ideal
> > and all that sort of nice stuff takes time!
> 
> It would also require a series resend since I can't use the in-place
> update in a way that b4 will recognize.

BTW, b4 0.7+ can do partial series rerolls. You can just send a single
follow-up patch without needing to reroll the whole series, e.g.:

[PATCH 1/3]
[PATCH 2/3]
\- [PATCH v2 2/3]
[PATCH 3/3]

This is enough for b4 to make a v2 series where only 2/3 is replaced.

-K

(Yes, I am monitoring all mentions of "b4" on lore.kernel.org/all in a totally
non-creepy way, I swear.)
