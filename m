Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D49C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 04:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiC3ElG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 00:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiC3ElE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 00:41:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35C019288
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 21:39:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x2so19461465plm.7
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UbSDNF/RY5maCG9SIWY3fV6YMGvTHhYuD+cLUJfkRjY=;
        b=zSrD6+EEzIQKuDESGH1d8vXAeGrnF5w76bXnpAd1lxfAkxS8FS33FAMdN8gJstN9uA
         nIghTXg+WmQPzFITjY+Q1idHnK6623W03SWrMkLt5lBNCwKcR/vtUb73IiEhIAX+qpwN
         FgfAxTj/vICgHOgqBymfvOi6zERaXarT0xqmM+8mEczMQ14aoD/AOR8uxc8jjGNG2ime
         Mni96wGUecMAl/4svOvjlA0nylOiqBB2VeXvWa8U4BrpFvEdadSk9j6hfUY3P0PSIbf2
         BTorhXL6iql+vx9P/ijrBF9Lq7ILmXJhX0wwF2kn2IXoDia+xGxw2s33JsCnvr49ZIjv
         v5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbSDNF/RY5maCG9SIWY3fV6YMGvTHhYuD+cLUJfkRjY=;
        b=hMBdPruuJCPMPS/wE3NHLqvkwmtjUrme+YMQ+Sh3YvGEiKZ7uEsuLb5HAMsjPQrZ9c
         GygUmbyTzJIIlmvpgBF8LvkhbYINJcrjZSZD/ayc0ZKySLCtNclonI5lV1ZvNjqQtXU+
         A7qKZ7fBhDLFQmIIkBWUH9QDLH+f9curwxR4eQ6RXkhzz5c6uFOU/PvSeZ6UbTi1d9Ji
         mlQCjPEwYgJc0/TsGpLAuefyhK/ATXch4rs7XVP/CuzXur2JraaIqS+22tDZM5mKvBHy
         tC7EKxl8vWbD9zutw0Ii8QjEmZOEQ2NfG3sgbdR3LRpHiq4Dl/0oRZBh+/a0k59sL2Jt
         OkbQ==
X-Gm-Message-State: AOAM530nTLrAn9ZUfEQRIAMVj2KnG5hL7IgOB+qtjLpjwT+S3sqvErmY
        b3fjbxhcIyue7n5BIXaQB3HLu8pQTDLosEq7k9e55g==
X-Google-Smtp-Source: ABdhPJzX2iYk47FcI6a0JE02AB4nfSbo7KghZxc2a6q+ctKA3aqmoqcyHLf+i7vFfTlDHGb8cPnIOZ3Yie+Keccxt5k=
X-Received: by 2002:a17:903:32c7:b0:154:4156:f384 with SMTP id
 i7-20020a17090332c700b001544156f384mr33748751plr.34.1648615160140; Tue, 29
 Mar 2022 21:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648601710.git.alison.schofield@intel.com> <281bb6c00baa93c29a9f05162a274bd6140fea39.1648601710.git.alison.schofield@intel.com>
In-Reply-To: <281bb6c00baa93c29a9f05162a274bd6140fea39.1648601710.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 21:39:09 -0700
Message-ID: <CAPcyv4jt9ZRJ880j+EDaa_EzXO=HAAkzL5MW2eaYzbg89mo_vA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] cxl/mbox: Construct a users cxl_mbox_cmd in the
 validation path
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 29, 2022 at 6:28 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> This is a step in refactoring the handling of user space mailbox
> commands. The intent is to have all the validation work originate
> in cxl_validate_cmd_from_user().
>
> Move the construction and validation of a mailbox command to the
> validation path. Continue to pass both the out_cmd and the mbox_cmd
> until handle_mbox_cmd_from_user() learns how to use a mbox_cmd param.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Looks good modulo destination parameter ordering.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
