Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B92C433EF
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 21:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D8760FC4
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 21:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhJaVRg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 17:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhJaVRg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 31 Oct 2021 17:17:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DE0C061714
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 14:15:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r28so15515905pga.0
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yaSnox7NBAV0wwmcXG8H2kZFVNG7A+pDBSvP8eLgWwQ=;
        b=OB/ji1OOPIOXU2nMArp8gVZDdGJnaHEZk7d/z1eyYIWI6T/wOj7jXQ8YKHQiAQRhbv
         IGuisFmK2IW1ejmh8swtIpq01HoOSen482N1A9ehwU409BMpbmRKlbM/FeIwdrgsOKwy
         Ms7m0RK0qBUE/Z068nvRXQrCMWbwDxeU1x8RIYC4jbPY+9uwIy0PSuziFZhT2E0YLLz4
         kb1v0qTUQshtoE6mKsd9b1nKzp4YKN2J+dkQBcJUW0BHcE7Ta2KQkvrAuEyluh6Zcpdd
         XxFRIMnookq2WhhCmyKstcOXOY+2tnuyka9mltBrKehMi+0TidGuqka7UwIyu+EBx9bd
         vAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yaSnox7NBAV0wwmcXG8H2kZFVNG7A+pDBSvP8eLgWwQ=;
        b=QDu6WLKZcV1EOZCDpUlT8SGvml95FCnrzFWPw3SmWERD2CTwmw70pmawKbyUUWo0or
         P0kd98ua6GiCZkKM3GsbPCH24ZSEwEkr4sHywsn84ZxVT9b6974l8iwM4H//0vB4X7Rk
         j56uvUUZ43WxwW1etMvu/NJbyTLDnl9Cuso40JcdIRoZQd6YOmJmn405zp1uhmlgizl8
         Xj0m0zIpj7KweBzvWmyKUw4FkT4uulU/UPzGlbQy3ZlhE3ZZ2EKicdPpF6T2oOZfMQiz
         RciHq1EqsdDqNx7IyD3MDPTfW4oYPUhueTC0emdSsW120sEa3+ac+4QrxrWlwDM3axU4
         wTmQ==
X-Gm-Message-State: AOAM5334ipeyxTq2cfrc39YXJVNwGZXdzI56VzxZq2P6uScpB2fyqpPo
        7Jy+UX+A3Mb0P1TDaKr7iS//oAqFKLWP+lDR3JFuJQ==
X-Google-Smtp-Source: ABdhPJwrCQuDYVNqiUNqQ0N0jVnTQfvadA7bqEudpDLuLCxntGuY88cuetDaMXuSgHJLHbJLSGbh+BdW5FpeOurccMw=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr24401541pfu.61.1635714903701; Sun, 31
 Oct 2021 14:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-15-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-15-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 14:14:53 -0700
Message-ID: <CAPcyv4jGE_6-hjMNGnAeOA=WQHbGtY-j+pE18nKoYtzvjQ+dxw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/28] cxl: Hide devm host for ports
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Generally, a platform will only have a single instance of an  entity
> which has a platform specific CXL driver. For the time being, this is
> only the ACPI0017 device defined as part of the CXL specification and
> ancillary specs (ACPI). With this in mind it becomes easy to drop the
> need to pass this around for devm functions which want to know the root
> host. That change allows future work with the mem/port driver to avoid
> having to determine the root host for port creation for endpoints and
> switches.

Given the revelation earlier that we don't need to devm registration
underneath the root object to coordinate descendant device teardown,
this change can be dropped.
