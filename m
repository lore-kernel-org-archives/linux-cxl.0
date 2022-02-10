Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED34C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Feb 2022 02:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiBJCbb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:31:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiBJCb3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 21:31:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9681B237C9
        for <linux-cxl@vger.kernel.org>; Wed,  9 Feb 2022 18:31:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso796675pjb.1
        for <linux-cxl@vger.kernel.org>; Wed, 09 Feb 2022 18:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLU6bPsZGwHyJVYo5jijI5LLvxPp0ukTfd7CbOJ/NgE=;
        b=1gPR/XwlCx4OMGXXJU7MQyj/rxq/jnNRh6uuQ23p/FE3uS4f0K84BWQCnEll9HKGmU
         lwNNMWOXLU8++FJMCpz/PFh0Qij5d7LEafjiFcwtWDbLdSKctEh742g2WsE/2eQe1jDH
         aA0RLsps+FRqvw4Bnia/7rfeIPSc7G04XbsJj4/OogDZ884mBRIFJibgIPnNIYzsXGts
         Q3IQoGaBTP7g8pHWOtD67hP/AI8M3uHErBtXVZXf7z1Bzg0rNVyZpTtpLPYasJm2WDR4
         nRSz16UtaNxtuEmXybqQNWXY33EmtmZe8txMyRVzUqqbT/Nqfwlw6rmiMRrIZ4ySoLgK
         21lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLU6bPsZGwHyJVYo5jijI5LLvxPp0ukTfd7CbOJ/NgE=;
        b=il6iNsLZaX3qZdYQphU54fLA5zwOK6nbVqwLRY9nN/LNaCxHrRw4Dsn3lUvhFZWjyz
         qtSdUwpUZL4SdKKRUHC2d6RozCormxE4Eoucd/2RTK0yXl5aCt+/zxXoeFn9UzkzIiV+
         LbORtVPrDSWA6PCdCdOseYbR2lsrMaklGqNHLJCJs22e98vyxIThubBdupRcI/QmAxv5
         d7Mn2oSSLJm/PGm2oxdTJuFaHakh/3e1d+xB1AxfZVkzgc3zYWvlPFpeaniG7cY54t7L
         mRw8l/qliTRFJxnannDndyGz2XUcnaMHGmoFoRAZxRHle76+1wKK90lkMGKYRXuR0VDU
         zJag==
X-Gm-Message-State: AOAM5336y9oexFe6CDa/D31rEFNx2TW/WDoX9ZRV4xTnVZZKghnq40tT
        ju6rt8dI2oC7WD3P09OhD6J3dq17UToyfq5FV/g7ng==
X-Google-Smtp-Source: ABdhPJzw0AlnVafRcyjp/Apr9rZF4CssYrKz5N6PYFuCuuXopJUi5OOtMhNYhQpqDCdEzCg68kR3GkNAIJo84LNmaWE=
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr392524pjb.93.1644460291091;
 Wed, 09 Feb 2022 18:31:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644455619.git.alison.schofield@intel.com> <6b937b09b61ddf95e069fd7acfda0c5bbb845be8.1644455619.git.alison.schofield@intel.com>
In-Reply-To: <6b937b09b61ddf95e069fd7acfda0c5bbb845be8.1644455619.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Feb 2022 18:31:20 -0800
Message-ID: <CAPcyv4h2DhDjJZPj25Fs9=VqLAHa75u7MzCOsS5wm_BBnyXUvQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v5 3/6] libcxl: return the partition alignment field
 in bytes
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Feb 9, 2022 at 6:01 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> Per the CXL specification, the partition alignment field reports
> the alignment value in multiples of 256MB. In the libcxl API, values
> for all capacity fields are defined to return bytes.
>
> Update the partition alignment accessor to return bytes so that it
> is in sync with other capacity related fields. Use the helpers
> cmd_to_identify() and cxl_capacity_to_bytes() to accomplish.
>
> Since this is early in the development cycle, the expectation is that
> no third party consumers of this library have come to depend on the
> encoded capacity field. If that is not the case, the original format
> can be restored, and a new _bytes version introduced.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
