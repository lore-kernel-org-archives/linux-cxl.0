Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C617DC433DB
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CBC64E5F
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 15:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBSPkQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhBSPkP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 Feb 2021 10:40:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E2C061574
        for <linux-cxl@vger.kernel.org>; Fri, 19 Feb 2021 07:39:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u20so13473791ejb.7
        for <linux-cxl@vger.kernel.org>; Fri, 19 Feb 2021 07:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLTA7FtePU+dZNp41QMgufF0dTfbm8VBzRM8fJ89BRY=;
        b=sDnU+xsNSISI47NUzHuG6iz1qb+e3QU8NY5m3se39I6xdjgfmz4soMB4C40+NDA8FM
         7OMisFUw0H588yRKLFcET4zTiGMFL7okEuFTJrx2id6MeSnX91GvssNIzVMUEROnkT82
         lZuecmk4c5WqOo2klU3VagkRPxXypCnBb6XApE27ZfZzfWkY6ThBmWfTfPJ5bvLjcIB7
         2JZA8+kxPc7QWlVke8mbDE0WB6OgsRYBLD+R8qQ/EJlpoNsIu6t/ZrRDaYUj+R+KRFe9
         G9PTQAFDjoPx5jYkpTnXpWvmddJOBZE3CoiWMBtQskuVBVSZOWPffafd3hNx8y4RJAr8
         6SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLTA7FtePU+dZNp41QMgufF0dTfbm8VBzRM8fJ89BRY=;
        b=BeQkHwn89V92K4IHtiSdBb0BSNuESMSCGlscMZI4UhOUl1Sg5Sj0ozI4C8QJHfgBQj
         OrsqEKa9nWgt8mWrrZ8aKKXP9pvGQ2lnSbysIbuQj/JwAbYDVIChXqKTFNglaZiTSsSR
         IbT2o3PIMKbszcBzxlvlChj5qwsaS5weQHf/6L7k6xhzJ3j2J/3GkZSNhclCxzMDgmkc
         M/vYFuAVQkRfU2anxfzyLpib2qwsHNXyhvRBgiekl+HPEQeLj4Ahx1d9mhtEdGbQngK+
         lhNvogSRsAIZeXQjiAkfZ1KDDZNeKxnm5ass0GeQodMnguNrXZYXq38VPKafKV5k9Fu6
         VA2w==
X-Gm-Message-State: AOAM531SkwtabRnRLPm3QubwsdCBT7sU9kLvyYjHrKX5IK5vSkBLwtpx
        VhZHswre9y4HZu4/g4m5LTx+iGX14qRsvW2iJVXt6JdSnyg=
X-Google-Smtp-Source: ABdhPJwh1/ZWcZ2N8I4xU2iWDfMsnReGdFlU4wq/EF39Z40noDKMmZJCBlRafzsDbQZHsTP0uMuOyikCYSEzh3laL2M=
X-Received: by 2002:a17:906:cc91:: with SMTP id oq17mr9053192ejb.45.1613749171563;
 Fri, 19 Feb 2021 07:39:31 -0800 (PST)
MIME-Version: 1.0
References: <YC+K3kgzqm20zCWY@mwanda>
In-Reply-To: <YC+K3kgzqm20zCWY@mwanda>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 19 Feb 2021 07:39:23 -0800
Message-ID: <CAPcyv4jCAcZH3C-kSbYVjBu34g60aYzQpwANjXecY-ziUKxguQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: return -EFAULT if copy_to_user() fails
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Feb 19, 2021 at 1:55 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The copy_to_user() function returns the number of bytes remaining to be
> copied, but we want to return -EFAULT if the copy doesn't complete.
>
> Fixes: b754ffbbc0ee ("cxl/mem: Add basic IOCTL interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Looks good, Dan, thanks!
