Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC58C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Feb 2022 00:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiBAAAQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Jan 2022 19:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiBAAAP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Jan 2022 19:00:15 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A313C061714
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jan 2022 16:00:15 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id p125so13739492pga.2
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jan 2022 16:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2w+PybZGj1Pt9zwKncrlYIefOTBGfgydX9Jj0viB1o=;
        b=wmUftE29XD1cDjU2mgt+TtdTRcVStkpoChebeK06YjxXDFn3MLM97GInA/Gu6+SXYS
         DhG8N7qdCycIXw3pXmtttGD6SZm85zuJ+aN1ueV6yTp+qZJBcFCodkuIPa+8rN6xPVpB
         dPw7rP6k7+X6a5IsGq+5ssrW1VpAHMdmz+PjiCCFaoc5ME42lBpONkSbFVxyYruu94hT
         j7RO5t1DKQ1G8fQhhgWU26Pg/xB584tAzvTNpQG5Zz4Tz1zvd7dHJMaeQvdFrm/j46uw
         mMPe7o/aUCvpdXNIhJnFAANBBS64dYM+b1TnKfkCVLMeFgMEcP78hDZHkk1c1MNj/Wv1
         h0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2w+PybZGj1Pt9zwKncrlYIefOTBGfgydX9Jj0viB1o=;
        b=OtWPwXNZmrvWyWE0ZUA+kX1y6OQX10Rcev3N9s9LDHObVRUrmLe3HS+Kkf72eqkDoc
         15BwDzCLSZBlXUoqA9IA8q4+OIr5Do3l+WWCbzSCnXp/k0ameU/0kQy+sY9asj+Y/UGx
         84/2jLmHHeUi9zwRRCcmHM4F7mQATG2QTWAsbMdaF0hPzg82MZn6/nH1RTnMPCgfrASQ
         pKioMdl+ftBUCy9WBZWbitu6+T75tkRZAdtENixaoEoLtbI227aDsRnkPncXbdT5z4bb
         cRR+FQlrk93EG2HNr+a3WhFTH4dynWovjyGYUGaM7GwXAg6aaZMu8LO5TksZqsCDyIis
         XYIg==
X-Gm-Message-State: AOAM5338UZPIZEY3MxcYjgdQzYTb0AnB4+kSLEQHXdjxeszAVoLPj7tW
        inGryLuC+VMWU3qCCnQcNs2fujuRfw43y2ufILcwBdzeVuA=
X-Google-Smtp-Source: ABdhPJwu7flVE67Zd28ydBqsaVlXmqVhbsBjuDcQx7XQgSdNuJ71Ra9vq5CV/TY0xTtPZK8VxEMd4grPCznabbW55PA=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr18413808pgd.437.1643673614974;
 Mon, 31 Jan 2022 16:00:14 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298422510.3018233.14693126572756675563.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131162251.000023fe@Huawei.com>
In-Reply-To: <20220131162251.000023fe@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 16:00:07 -0800
Message-ID: <CAPcyv4hcE+4Vt1KZ4HB74ScSt9rEF4HO_TX+H1KyMN=ew=EOzg@mail.gmail.com>
Subject: Re: [PATCH v3 20/40] cxl/pci: Rename pci.h to cxlpci.h
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 31, 2022 at 8:35 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 23 Jan 2022 16:30:25 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Similar to the mem.h rename, if the core wants to reuse definitions from
> > drivers/cxl/pci.h it is unable to use <pci.h> as that collides with
> > archs that have an arch/$arch/include/asm/pci.h, like MIPS.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Does this perhaps want a fixes tag?
>

It doesn't need one because it's not until this set that the
drivers/cxl/core/ reaches out of its own directory to include this.
