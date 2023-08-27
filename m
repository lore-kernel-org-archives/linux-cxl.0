Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35036C83F10
	for <linux-cxl@archiver.kernel.org>; Sun, 27 Aug 2023 16:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjH0Qn6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 27 Aug 2023 12:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjH0QnZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 27 Aug 2023 12:43:25 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E315A118
        for <linux-cxl@vger.kernel.org>; Sun, 27 Aug 2023 09:43:22 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34ca860051fso9353515ab.2
        for <linux-cxl@vger.kernel.org>; Sun, 27 Aug 2023 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liquid-markets-com.20221208.gappssmtp.com; s=20221208; t=1693154601; x=1693759401;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ae1+/1E+Nw43C4neQF4bZiwpYE1SVhwO8fkagZKnW+o=;
        b=tf2MERnwWeWW7Y4WlRIl18hpTLPvESHX9SDtjLBXrOgrZ97NIAFsuAAnCTXCF9DiT9
         fRuVjvubbwb6/FyBN5zxEDbRdEhADQL6Qy4wne+REYP5iG7w3EvoMM6xWengzmiqPNQ0
         bdt98kzhQsx7qWrAmZRbM0CR/0SXwEs1ma52WSO7VBPShMK01nHb3V5O4x/RSzRjCSCY
         Za2ppkaaWVibysju1omS+Tid/IeKoJPX2pcJM8q+lmUQU2ZZ4PO2bPXPQHXCAws0NC3D
         rst0qNnBO8KqgwbmAov/1f2ENfMsLtucWUDi54w02EocmUoh5NllJJkDxSqGxGwUqq5t
         qO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693154601; x=1693759401;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ae1+/1E+Nw43C4neQF4bZiwpYE1SVhwO8fkagZKnW+o=;
        b=MY1I2o2JPWxDbfOd6nik5jEzFy2pRrOfzZYQygQ0yZq6HJBXiHl1RiM2AAo3FQG/Jo
         k32bOOx4kouDnB+1K2k8DlJZLqbl9HmbEj0uw8PAyV2uXM3z24CsZAI9mOvZNhV6KvSM
         p5bmJhTYQsZpADnQr4s+U5jByOPYMG7ab7o5YreqzPCggVGMODGPD21UJBB5/RZ9yQKC
         mNsWD0n65oCBZyxbC5QFb2kn4a4+oHxDcW3bByrPaU/3jwVMqCarD0yIW+HbLE8v5NwM
         GLxbed8VtOC50OcSWMMV9jfuS0Qd7RJV5BEN0Q/oaBVny5f9F5gNpx4ZwLliwtm6x+0S
         musg==
X-Gm-Message-State: AOJu0YyELsrdcretwNc7nL90fxDygwtSNxm7MPioU9O0LYBLCNjmKVRn
        Hv8qRZhh4LpWF8MaBgLGgDlIcPDofzhEf+XWt8V5ihQUK79MIvmvmodfNQ==
X-Google-Smtp-Source: AGHT+IHs3GKbgY7B819LTaSPDLqOeFMMJjh5aKJf7j5hE6wPIk/ZZJWEQtLLheW2yuK7CE5hfcAOnB2vKSAxp5CvJj4=
X-Received: by 2002:a92:c5aa:0:b0:34b:aa34:a5ca with SMTP id
 r10-20020a92c5aa000000b0034baa34a5camr12713851ilt.4.1693154601786; Sun, 27
 Aug 2023 09:43:21 -0700 (PDT)
MIME-Version: 1.0
From:   Alexis Gryta <alexis.gryta@liquid-markets.com>
Date:   Sun, 27 Aug 2023 18:43:11 +0200
Message-ID: <CAPtxMzOiKZXBrY4KXbQiRHaS0Kx8N0_La-1P=G3eo=3Vk6Jzjg@mail.gmail.com>
Subject: [CXL DAX Question]: How to change the memory-type/cache policy?
To:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

It is my first message to this mailing list, sorry in advance for any
mistake I may make.

I use a CXL Type3 device configured as devdax and I can see and use
the /dev/dax0.0 device file. Nevertheless, it seems the memory-type is
by default set to write-back.
To avoid using the native instruction CLFLUSH and to avoid the
speculative prefetchs, I would like to set it to WC or UC.

Is there any plan to add an option to "daxctl reconfigure-device"? At
least for mode=devdax? What could be a production-compatible
alternative?

Regards,
