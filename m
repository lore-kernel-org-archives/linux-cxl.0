Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD922C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Nov 2021 22:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbhKXWZp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Nov 2021 17:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhKXWZo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Nov 2021 17:25:44 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49083C061574
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 14:22:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id l190so3384290pge.7
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1usb7UtD3l2QlYViflcIVKcZYxhVZOO6TUs/1spBqks=;
        b=sU4NY7H4Hr60DZ4Fb9gi2nK8Mjta2Jap7KfLpXKofdGY+Y0adBu+vNmgUj0BITrOK7
         RX+8xIbJgqva3JmJEQmqEL8Bj9v1422S6/1/r5GxrLSR+flFP3bqaQX63HIF/PFFyXN1
         Daa8hzF6rrjmZS8NwC/f6F/Nia7Nlx+1XFuL71VqG2hqo5TaNHL4LXNEOhDotBhmxyOV
         UnxTJ1JeRhWz4uURfuvVIv+nRcQwM/6/VHzLXlao8gyCF2OW0f/L/L9sTfmo6OqCfeES
         fhnAWC2o23/iqYnp+KRXdj7JD+P0YnYvTGkwRx6Od1wKwtGLUhMssZgWBcW94Rauj4wQ
         1YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1usb7UtD3l2QlYViflcIVKcZYxhVZOO6TUs/1spBqks=;
        b=rH/BqwNJI9rnP/pfd+EsLhxyNaGVxpetxj98vBGUKvADO0WhIuYy6HY+vSkTWgmzty
         HCiWODZvUSnUllAGvEFCU+9SJH6+mLW/OIHAh9CX6kAZBR7RcYHNoG/Odh4cLltoqmR1
         ecHkdyWWd8QPZAhk2ei2fjJ55RwKG5MvuChtiGBaaKJ1sttj1caTtSWrtRJNbhWocRjY
         lkKlo6qqXGRKCgfj0D4IPnNXfSR2Yyq0m4ykiRqAuqVrJOWQYu2H7MPiJG/rVm9IUJ9b
         Gjo5nEy3PtIdf+sSlrR88c69E77m3lqTwYKsPvXKSlLuFi3tn0TWg4muHz1kOOWfrIDF
         ZjFA==
X-Gm-Message-State: AOAM5300cjP1aM/1dS4gC7GqdVHjguYnfYHlrAE8SsKAng8uuPYcli8+
        tdDrJlXkFdFrug4e8ae4Q+Kc0GPZXo8EVXo1gIIfyA==
X-Google-Smtp-Source: ABdhPJy5kNPu9teWe090tmKlzC0EdhLvwER/Av/pfEXD/2h1jMTKe+JplmNnORPJz1SaB39a4wDuYB7kepvu4FF5XO0=
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id
 j10-20020aa78d0a000000b004a282d71695mr9757066pfe.86.1637792553750; Wed, 24
 Nov 2021 14:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-10-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-10-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 14:22:23 -0800
Message-ID: <CAPcyv4hgF4T_oVniu0J4xNUegi_+XLEXkMcC_L8AB2Y+Sf4Nzg@mail.gmail.com>
Subject: Re: [PATCH 09/23] cxl: Introduce module_cxl_driver
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
> Many CXL drivers simply want to register and unregister themselves.

s/Many/Some/?

> module_driver already supported this. A simple wrapper around that
> reduces a decent amount of boilerplate in upcoming patches.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
