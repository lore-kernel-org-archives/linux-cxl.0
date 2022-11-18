Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02013C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiKRWj2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Nov 2022 17:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiKRWj0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Nov 2022 17:39:26 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF609A5DC
        for <linux-cxl@vger.kernel.org>; Fri, 18 Nov 2022 14:39:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id be13so10497774lfb.4
        for <linux-cxl@vger.kernel.org>; Fri, 18 Nov 2022 14:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOiJtYZeQVIXzLgp6qBI5UX5u94grwOq5OhhDbn0tUc=;
        b=W/oZ38tL+oI3keP+X/RXHKGUjusG0XHH5SRl4WO/Vppv0otayTr9RfIuPFhX19Mczq
         OOqomMKcIqpVdpwRSLvJruFlkj1n8eu9tbL7ausp78U1OaSyKgBwJBg4g6xpXrUiCB2l
         gslsv8MUI4PCyV53pta2U+8kV2euG7zlhGfXQZac46e/UwtOjK47FXkghX8vPyjxV17V
         w25Z91XybB2fsq0b+2B0geEDw2UiuKpaNxTUQiTie+miFXQWTq2SQ7u6WaUkqtU9zVRy
         H7FhaPlVDRWgrYSLzYyh4T4vf/NAQYmC/7ZoyCEHexUpICuiSE9Edsx43QOlEIa1WC6R
         IQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOiJtYZeQVIXzLgp6qBI5UX5u94grwOq5OhhDbn0tUc=;
        b=cmODeWM/bW1+Mh18Ig5TCr+9XKY2Ci7cKj5lfMzzB16Ovt4FOwWC6EBDeN40Z9U24r
         upQe7M5pYOq+k4BeFTCqEKn+jmOHlA4vHxZckySVPetDu14WMPw3z2bYrKea5Swddp66
         PTqQcUkwmMxHKUKp8qlDlQxQBKFcBUahq99gGE7GbFAUqc1UngmZVNFHpXU0gnUi3Snd
         aiz8T8J8v/G5RMWes19eVGQuN0YikDSn3pqnPf2hYovzkPBiGjJP+x7iuYOO5DSquzmY
         kEx7kMkqIbYu0thuUYTELZar1326WC4F95xniO3cAaiLbI11ER5nUHQ9CAi1VELlmaTw
         GD/g==
X-Gm-Message-State: ANoB5pnzgCxcBU5hpNeF9KBqBCrCOYFp+ET4SneNu+u/Apb4bWqrAliX
        6QtGrYFgEYKE+oxCrnSKU8c=
X-Google-Smtp-Source: AA0mqf67Dh1A71sI4ZnF2QL0zpmcCbpKb9+bCgfe0OeeJdEBCW1izx7x0Y/XoL5qDr34k2iHNiEfxA==
X-Received: by 2002:a05:6512:786:b0:4a2:44c7:ee58 with SMTP id x6-20020a056512078600b004a244c7ee58mr2949326lfr.127.1668811160564;
        Fri, 18 Nov 2022 14:39:20 -0800 (PST)
Received: from ubuntu.armcompdev.pub.tds.tieto.com ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id e30-20020a19691e000000b004a05402c5c3sm840193lfc.93.2022.11.18.14.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:39:20 -0800 (PST)
Date:   Fri, 18 Nov 2022 22:39:13 +0000
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: trace events
Message-ID: <20221118223913.075752fd@ubuntu.armcompdev.pub.tds.tieto.com>
In-Reply-To: <c71a8cea-b2d1-8190-51d0-754f80aa96a0@intel.com>
References: <20221114202242.5f9023d3@ubuntu.armcompdev.pub.tds.tieto.com>
        <Y3bW8CLw8xcbrfav@aschofie-mobl2>
        <20221118135311.12cb241d@ubuntu.armcompdev.pub.tds.tieto.com>
        <c71a8cea-b2d1-8190-51d0-754f80aa96a0@intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 18 Nov 2022 08:18:43 -0700
Dave Jiang <dave.jiang@intel.com> wrote:


> 
> Hi Marek. Have you looked into enabling ftrace? Maybe that would be
> the right starting point for what you are looking for?
> 
> https://lwn.net/Articles/365835/
> 

That was my initial idea but if there are no trace events defined for
the CXL what am I to enable? At least I cannot find any events for CXL,
there is no file include/trace/events/cxl.h in kernel/git/cxl/cxl.git.
Also

  find /sys/kernel/debug/tracing/events/ -name "*cxl*"

on linux-cxl returns nothing.

Alison mentioned she is working on some but these are yet in review.

As putting the trace events throughput the CXL driver/s takes time I
took a shortcut and added trace_printk scattered around for now. With
libtraceevent, trace-cmd and kernelshark and it is looking fantastic,
except it is not the CXL events as per-se.

root@localhost:~# trace-cmd show |tail -n 2
   systemd-udevd-520 [004] ..... 21.236650: devm_cxl_enumerate_decoders: \
			success adding decoder to port endpoint5
   systemd-udevd-520 [004] ..... 21.240517: devm_cxl_enumerate_ports.cold: \
			find_cxl_port() returned port port2
