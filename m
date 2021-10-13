Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DEFC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Oct 2021 22:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D975A61154
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Oct 2021 22:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhJMWvq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhJMWvp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Oct 2021 18:51:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F9C061749
        for <linux-cxl@vger.kernel.org>; Wed, 13 Oct 2021 15:49:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y1so2810815plk.10
        for <linux-cxl@vger.kernel.org>; Wed, 13 Oct 2021 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzcJqcZKaeP4N0r2R1aUwTSZHSBWK2JQNN59igSj9bg=;
        b=vPZXcUwuf1K265GJj8iIKKtmClnf1X3/ENDU22ChBpToG9/0UNfVWmUYKdU7mZHsiu
         o5qGCbisyw1McngOT+uM7pSOONaLaVwqFpTU0kw30+8GAbq+iM7slO3wJFXIDFjMRpMs
         3Vky0ze1Q2VS2L5MTCawll1tVB1yanrB/dZX7QIgzIdSAEMi4HPV3jWJPszNSDrqTN4c
         bm1T4QmKF5lMiJHbXPsTvJxcSq+DhHbBwnnah+ozSRBsOboGfVzOBqAz57EbTlV9Dm9U
         3d3PWtODSS5XXncAUgxzpAo1QF1rhDlYGlJTaKbR9JX0YiEa8m6BCFHWj9aIxbHmvl/D
         79kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzcJqcZKaeP4N0r2R1aUwTSZHSBWK2JQNN59igSj9bg=;
        b=avnvmWrvEHx2PlTVY/yXRztTxI9h8IpCKGaaC4lCIu/xW120ygGQobI8PKk0k9GJlU
         aNP/xCp8F7pilTun4LYczEStlzL/5Jvwe/UQn7N57QKnsAtd/4Ni80D5wdqy0d1LH6Di
         QydpVPt4XWhFAbjWXzzIC9HMjUc2khPXruI69RTak8Anu3PTM852THj4LGl8f4u0H/42
         RYUxk5hVzrxwhQTXMIOkXokXfqbRRjLctu2eELURh0FrCEZLHZz4MlkyQ7nFWCP0JuqG
         vJAL/QXZpQzbOkHs5/9swxT7eW1MaWyBf7dUcZdGgTsBLStAAelKkRGKwqfQSPhdqTvK
         cDhQ==
X-Gm-Message-State: AOAM531hqH18mN0429+rTkoaA2uI9VXQfIPCzVokgrW8HimTrA7TYmP4
        GKzsO2fvS5rrdUNSccH0e81NZ0swM0yo2recKg15Dg==
X-Google-Smtp-Source: ABdhPJww2lQN3rWRGSl0Xrohz3SxU98D1oyYuUtwtyaSQEfPit3AjHQnFldz1HLlCTkUoxm+2IrROcbWMyTUwh6Oopk=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr2317067pjb.220.1634165381427;
 Wed, 13 Oct 2021 15:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211013224523.rxyt2mg75ebxismi@intel.com>
In-Reply-To: <20211013224523.rxyt2mg75ebxismi@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Oct 2021 15:49:30 -0700
Message-ID: <CAPcyv4jHxWJQSgGFg4e5tSg8dgDcYVKrzXEN8gtg7TjNRj3h0g@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] cxl/pci: Split cxl_pci_setup_regs()
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Oct 13, 2021 at 3:45 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-09 09:44:34, Dan Williams wrote:
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > In preparation for moving parts of register mapping to cxl_core, split
> > cxl_pci_setup_regs() into a helper that finds register blocks,
> > (cxl_find_regblock()), and a generic wrapper that probes the precise
> > register sets within a block (cxl_setup_regs()).
> >
> > Move the actual mapping (cxl_map_regs()) of the only register-set that
> > cxl_pci cares about (memory device registers) up a level from the former
> > cxl_pci_setup_regs() into cxl_pci_probe().
> >
> > With this change the unused component registers are no longer mapped,
> > but the helpers are primed to move into the core.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > [djbw: rebase on the cxl_register_map refactor]
> > [djbw: drop cxl_map_regs() for component registers]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> [snip]
>
> Did you mean to also drop the component register handling in cxl_probe_regs()
> and cxl_map_regs()?

No, because that has a soon to be added user, right?
