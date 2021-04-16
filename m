Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E6C433B4
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 02:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264E96117A
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 02:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbhDPCLp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Apr 2021 22:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhDPCLo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Apr 2021 22:11:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8668C061574
        for <linux-cxl@vger.kernel.org>; Thu, 15 Apr 2021 19:11:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u17so39832091ejk.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Apr 2021 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9PRyie3tqkY9eSVy083i8HGuppdUqgC89QhrSrZVsQ=;
        b=PpvdCbCGGCAx1nwmb356SSyxZTqjdIDBjVlANtU5hRiRnENqEBazaeQSPT0hn2NAwY
         yeJzKhuxCifduw+PIFD3HORK5pi1GlOVPLJuKeNIr8YtLiSmtp1JfNfsJh0icT4DelJT
         vobZLYPB9JC643Ga92/KugZ0j3VqIMO4o9m8I4B+RD9Mjxb4+dlAo+n783gAr8UaUm8O
         gdJwYEXOvmuRawPpGOYmNb9fBL1YEscZFfTpjN4TsEMbCSRcIIkdShYL3lscf8M5NlVI
         VVLjtt7mPfIf6UlHkns7T4BTFkiyLC1bUoJlgP1kyiZNBz4dh9vPWIpwZXGLofkt+VLQ
         FfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9PRyie3tqkY9eSVy083i8HGuppdUqgC89QhrSrZVsQ=;
        b=ey4GlEi3uZOWdqXoGAHUc0AAGQebUSWirwpxHK0R9qkdi61REXJeCLt/bT2Cg/jZJd
         niKnBM+OaWXXykgTJT4KpEba6SyioXK+6vY8+SpgYI+vsKXXpFwaQRGcxnf9+0DeTAJw
         f4cmHmNgBn66Z7m6dv2MQaRcays/uNy2iSIejyexp18iM0orVMIq0ZHM+Pv8VOL/34kM
         Cjqd6XNq3duLO0O91M2nrJ7a+OCLE32SfvkUvfQ8xcrvdAeDwoDB1bNyjheZiEGoiU91
         LRXKxENl9kKFWb2ySmSJWns1ItfAVtLHtbTZ//YfsAUnrN88eIIGzn0nhekmhDrH2a2m
         r5PA==
X-Gm-Message-State: AOAM5305/RCjMe+n8tDjT15ZZ9NunXQNXopCwPPOyJnMaUQUM8L6Tayt
        QLPBMSgVPiDOPmb5MCkkMQFXVzRxnjDZIhrKTRgO38kgf2w=
X-Google-Smtp-Source: ABdhPJypxvDxQ38UnPB7t9ZYeG8s/8mUxm5HZeUiH03ncfHmiTu2tLKYZ1UVrFpTQuS5ld7AEZjcBM6Maj+EtzzjNnc=
X-Received: by 2002:a17:907:984d:: with SMTP id jj13mr6179807ejc.45.1618539079575;
 Thu, 15 Apr 2021 19:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gseedV78W72ERtdGozW_V3aTpPDw5-Py3X4HWRFYRbSw@mail.gmail.com>
 <20210416120905.19211c7c@canb.auug.org.au>
In-Reply-To: <20210416120905.19211c7c@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 19:11:08 -0700
Message-ID: <CAPcyv4iTBKXAEt=6uxenWgn-9GDSC0tH0Riq5167pVdTJ0208w@mail.gmail.com>
Subject: Re: CXL Trees for linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Apr 15, 2021 at 7:09 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dan,
>
> On Thu, 15 Apr 2021 18:52:53 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > CXL development has established a cxl.git repo on git.kernel.org. Please add:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
> >
> > ...for fixes targeting the current rc cycle, and:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
> >
> > ...for new development targeting the merge window.
>
> Will this be merged directly to Linus, or via another tree?

These will be submitted to Linus directly.
