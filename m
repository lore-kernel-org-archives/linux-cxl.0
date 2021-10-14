Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D63C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 23:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E6761139
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 23:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhJNXgs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhJNXgs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Oct 2021 19:36:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2EBC061570
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 16:34:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w14so5229510pll.2
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iq1R2vOoGCVjcZgn+ZMPcRorADbzRkujEOUqDJc96iY=;
        b=xo5QJjW09N1qV2nCHHYgp1+0XZR66iHmBcVmyPFi7Z1dviYqLxAk4KwsLSsnL1r497
         M4VAQ9D1OvZUV5cCryuBl0EejklT02/eaRU9LZffwO/n+0beq1tzSrCh2Oas+R5cQQys
         P3u4pi1pEJrFarhgdrKOXlvHpJPrSaBy3xCzCN+N7IuWIjlpTHxhKl7P3kTKA+BgXJMM
         HMGRyQOnsiagH+VC+g5ckdNOfM1JHfdoJ+nPbSlZ9GbMNHoqDuRv1VvVzWMzesLgRlTO
         77MhWzWYq98xqnGW7lbFF6OGUqnvoJ27H1hr5Gd1IX0dDXWOCEr6M0OhkpiyV3vOczDH
         eSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iq1R2vOoGCVjcZgn+ZMPcRorADbzRkujEOUqDJc96iY=;
        b=KU1DLYeluLFQjAOeZcgjYB36uPw/zkGzEBF1783Ubpj+olM/gmnIVv3jhv/hMiDPtP
         Udbmx6weecL4GooOx6vJyGSFWzBHQ5kxmuY0msaPfjTStVeI/2JhPeEKhODDDFU1wCKq
         3bdhc5PAf5ANdrDIARZZzg++OeRX88A3pyPMImD5+I3rT/62DDyg75nUh6psYwEAnWES
         TcdQSq+uvwp8asvhejzqvKOinNL4FVrUQ505Kc7ZvTSYE/wldv77+CqlT+Ip4yC4VFji
         IQ47P1ASoXp2P1GvOZRTmlMD9QXF/km3JhF5kaQrdLK6L/uBP3/hSeNM7hudZH917Rxj
         5yMA==
X-Gm-Message-State: AOAM533L5P1TSdY4vVJkRJzkY5lXZff8xQB4TvWCLqIdU2i1YWq8rWJO
        DCWZTIypGzQ4nRQpNfaCd/L+uH7zDL/SzRqS6ddJ+d/yWiY=
X-Google-Smtp-Source: ABdhPJwttEzIdgNzDfbtp1KIg9pF4rhju+Dgnns3/xrilIpBvJfL4X5BR5QSMc40MsVtGVVrpCmDntFg2LJhBgMYkQI=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr9525393pjb.220.1634254482497;
 Thu, 14 Oct 2021 16:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com> <20211007082139.3088615-17-vishal.l.verma@intel.com>
In-Reply-To: <20211007082139.3088615-17-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 16:34:32 -0700
Message-ID: <CAPcyv4g0V4JicoOfyiSB4LySB0sp=1hYMQYePu81PA9p9NOF5A@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 16/17] cxl-cli: add bash completion
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add bash completion for the cxl-cli commands implemented so far:
>   cxl-list
>   cxl-read-labels
>   cxl-write-labels
>   cxl-zero-labels

I'll take your word for it :)

Acked-by: Dan Williams <dan.j.williams@intel.com>
