Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B5EC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Nov 2021 23:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6246120D
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Nov 2021 23:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhKKXUX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Nov 2021 18:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhKKXUT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Nov 2021 18:20:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6CCC061766
        for <linux-cxl@vger.kernel.org>; Thu, 11 Nov 2021 15:17:29 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y1so6929219plk.10
        for <linux-cxl@vger.kernel.org>; Thu, 11 Nov 2021 15:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMxMBwZvQOQ0P3ozk3ltI4YHuakXqNt7HmzHegtg/go=;
        b=0qwRv5X8E1xcAA+gjh7gOTolXnl4bvGP8rN8bp5ZhvgvpMtTzEeGjN82SCNi9JPa2H
         vBpU6gn/8wFJMYR3UWpTq4Yp6cxt/YoDqixcaY4+V//Tib3fogx4Obp35zpjjuZC5kUN
         kolLdaxR7UgqcvmEAvbbwleEMpF5dZvUYNXJiVINQ25vu7MrVuWIunlSJU338rn7PUW4
         km50HD4VOv7ojzfHivO8ouF2KRNWj8qsMCQHVTeQb2mStOezMuYtUaWuBmbf5adGF9Qo
         huy5BzRtWJb6XxGISAzhXmKdISgyzVBksFWvX07arfkMC4TGe/Nf1RQi3VrnNC3xN5Nt
         Sayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMxMBwZvQOQ0P3ozk3ltI4YHuakXqNt7HmzHegtg/go=;
        b=hKErnjoxwL++6V0vQK04U+8DUvl0V2ZIYsEZ7VBkAWggcCtE0O0HvawJVsbgnhP8jG
         ka+JtHJm4+9j1drd8lU9iBzlDEci6ZKowcLw/pSN64C3gJuZ0dPeFHy52TCTdMTnMJcz
         Q6x8hgNm2espmhipq072dfCljm6mamtRbMCn/ycQKnhyy3euGjnXolu0sFvbzrMf8ZB+
         PIIi7FSkanI4XF2OCQ2iJQiztPEquMvFn3oHMQH9Rq/tQMo59aelP7DnjURn+xDO4kAp
         S9Jw38NogpFqWMvpUgnUsUDIqUVKU/pDqtTOteS4LORIpJ+DRvvSRHlduwq+KcCDo3MS
         VrSg==
X-Gm-Message-State: AOAM530jwmZsHJP8NL0AZb12IbTQWxqNDv5i+i1u69oEgbjaF49KpPf6
        xRzjy63gpF/aprwSLScJe3VglOvP+AP2ybA0EQhPALpqF/k=
X-Google-Smtp-Source: ABdhPJysyP7M4cBwMxRbatuyqgvGr8S0wnjW2nBtz4kxJfHDSdNW387zK5vTAQlx+VVxsGioP+SXTbRcfWOeih3PI7E=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr21849203pjb.8.1636672649392;
 Thu, 11 Nov 2021 15:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20211111204436.1560365-1-vishal.l.verma@intel.com> <20211111204436.1560365-8-vishal.l.verma@intel.com>
In-Reply-To: <20211111204436.1560365-8-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Nov 2021 15:17:17 -0800
Message-ID: <CAPcyv4i7PFNSkSk4U=8CnkOe0M1Ap2iuPWthDN86sXQ-ux3dsA@mail.gmail.com>
Subject: Re: [ndctl PATCH v5 07/16] libcxl: add GET_HEALTH_INFO mailbox
 command and accessors
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Nov 11, 2021 at 12:45 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add libcxl APIs to create a new GET_HEALTH_INFO mailbox command, the
> command output data structure (privately), and accessor APIs to return
> the different fields in the health info output.
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
