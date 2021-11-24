Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB7EC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Nov 2021 21:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhKXWBc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Nov 2021 17:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhKXWBc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Nov 2021 17:01:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA35DC06173E
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 13:58:21 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so6120177pjc.4
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 13:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qh4NPOAoAylAgbo+Xn1k/1oV2Re6786m1wslbTsVQwg=;
        b=gns/Y+CY4hX55TqT7xu8ABUbcU3kuJ7Xxnw9SO/AP0wi9CWTk/uR61nK8K8C3H0zEU
         M9UVM2xqBhR/ePwRsm9uAxhUGwOAZ46c+WTCP3aElx4G2EXNS9LKxlY9JEpxDevs9m5e
         NxfSRCx6Ss1G96aUA+XCWqyRPIzzR6kStI6fUta5mwZNS/oqcImY4DGoHVZGgv/fUBZS
         7nBW6/jbG+ROYQibDyRXHSqpHGr+i5Y+T/aCugw5ZEdxCMEp+xtcZlxrqhqXyYnrPks4
         VpkQGrbVpRD/L5TzGHoHThZNiPM0umvlmtgRK8TzNS0e3LMQqOvPgjy04HeYCWExFvQI
         zIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qh4NPOAoAylAgbo+Xn1k/1oV2Re6786m1wslbTsVQwg=;
        b=XQjzjVQaZC8Jncw0K7L2oUpJyzRlIAHSi31ig5mbPn9k8NbL6nK8Z/kagdcXPo1BID
         VCsmsrVXKz6BL6QLGE2z/rpkwOq6OsWmEVdAGHPonD1AQNpERyYZ1VNHEvwo4afwW0TL
         Qekd+2DSBxJr4K7Q6XA7T0HqQnmRjqqr5uB7Lm9NfINt2yLEZhBsx8BMQx9+19DrZlJK
         2g5cJQZW9FYCDGoTxfOaT/L0UaXEC71Lx3/wPpvmxmbIASvTXCuTdh2//1y+Z/YyDKno
         6fuhbIQGdnZaqJbGM27Fl9Mg12lX+sROeSp+DjLGqPx4nqDYsxzqOn7vfgg6inMHIwVi
         v8rw==
X-Gm-Message-State: AOAM530VhpKUXcoPwantlL7sn5nmCWYhllGSX23vII5HhfLgzBhT3l66
        Bf5ucCZjtDfvD5VPkMMFKIWEq3g/VgwwyM0OrUW8Pw==
X-Google-Smtp-Source: ABdhPJz+P/ZSU9Flh9ezgNd0iqMjTPhAz3nCoeUD65qSwu5eYjkJwtOFTZr6lcbFPm8C2bLadglRyksJgfFpCqKN30Y=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr23009449plt.89.1637791101163; Wed, 24
 Nov 2021 13:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-7-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-7-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 13:58:11 -0800
Message-ID: <CAPcyv4iNoNcZJkR+_mSGwWqnGOA0679ACfkP9yh1tYvXrT5khw@mail.gmail.com>
Subject: Re: [PATCH 06/23] cxl/pci: Don't check media status for mbox access
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Media status is necessary for using HDM contained in a CXL device but is
> not needed for mailbox accesses. Therefore remove this check. It will be
> necessary to have this check (in a different place) when enabling HDM.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> This patch did not exist in RFCv2
> ---
>  drivers/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 869b4fc18e27..711bf4514480 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -230,7 +230,7 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
>          * but it's possible early devices implemented this before the ECN.
>          */
>         md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> -       if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> +       if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
>                 dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
>                 rc = -EBUSY;
>                 goto out;

Per comment on last patch I think this whole 'if' block can go.
"Ready" need only be checked once at the beginning of time and then
only as a forensic step after a future failure.
