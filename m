Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092CFC433E0
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Mar 2021 23:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03ED64F96
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Mar 2021 23:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhCHXef (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHXeC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Mar 2021 18:34:02 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60EAC06174A
        for <linux-cxl@vger.kernel.org>; Mon,  8 Mar 2021 15:34:01 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u4so18323574ljh.6
        for <linux-cxl@vger.kernel.org>; Mon, 08 Mar 2021 15:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HV6Te7r9KJLF3Mw9pM7Q2p+3SeWjKjbOa4UDkSedz3c=;
        b=I1cvvKAdX0LNZcaqKxAwIHdpsm11rq+hfnpzNefeEilU01QWoxgsFWGUStrCuA0Fs8
         tB+GR2bWixZZJdEBiSlfUiSgz7IGbgzE4KulYLZTKvCPsuIPHpgvqhd2m8OzylvEcB0h
         Lu5oncesaSCWmrvrSWXpoCmObepBofg8eaaepIGx4Ttfl3xjJxnEYL+rZmD5pha8kRes
         zzh44H/Ur3dAHEsaL6vbxGxtOjBv9G4IBsATA4DFrQNCzrp2lKa9+uwj/1vfbywpNrj5
         REstezva/9/pTeSLCUeyBBak1y1z8QS6kf8nuZdVLBwngTsObczk7fKG0GEVNN25MJkh
         jboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HV6Te7r9KJLF3Mw9pM7Q2p+3SeWjKjbOa4UDkSedz3c=;
        b=h60CjVRj97W7e9w2cOBJPj5gVdaFxxtJ7uNpa+N6gZx/TSH41EGdgTgmc6b57pr6HA
         k63aX2TF0CZKxhPgZz5qRGlIDxlayUxQicFkUw3GdJZpOqbX67oFVTjrcO+DN8tE0xTt
         ReF8Oj654TS/8nelGVSEdPFraYSlDX65xyL6I3MyrrO4mer+UEZiOUo8Mnea0clZGVYH
         3uE9LGTyQmvQ1JQXw2zGTnjammD5/jh+0E4/R4vdoML43ZuAwGtDbpQcQbY1RTcKXIXa
         f+tBrLvRsK0XLt3LhTI2M9i/3LipFAUkRJwi7XNjg0zxbOuH2O/OHwUbBDPasoEPohRV
         maDA==
X-Gm-Message-State: AOAM533CX0+ItYkcpnr56H1YzVsopHmcQ2syAofL0BUIEQX/eVJke+Jb
        xjx4Lns0NKp5GmjBTSglex1ZF15A1WVtesv2kMZX/SWn53s=
X-Google-Smtp-Source: ABdhPJzep/K3CXWm4dFXQ8qTwplsGLy83pcyLxbVaJbV4KUsiQ60Tpx7K6W5tpuwO+H9Wq9Tkj+DVN9pwbmI94Lt6Ic=
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr15629169ljk.140.1615246440322;
 Mon, 08 Mar 2021 15:34:00 -0800 (PST)
MIME-Version: 1.0
From:   Raj Vishwanathan <raj.vishwanathan@gmail.com>
Date:   Mon, 8 Mar 2021 15:33:49 -0800
Message-ID: <CA+-5cKfDiDDG6zpnDSg12a=JPD8-FTypi9qA9qdr_CRnkrFuHg@mail.gmail.com>
Subject: Testing CXl with qemu and Linux
To:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Raj Vishwanathan <raj.vishwanathan@gmail.com>
1:55 PM (1 hour ago)
to linux-cxl

I am trying to setup and take a look at an system with CXL enabled

1. I downloaded and installed linux.5.11 + CXL patches on a regular qemu system
2. I built qemu using Ben Widawsky's CXL-2.0 branch ( I see that there
is a 2.0v4 tree)
3. I also built ndactl  from 2.0v2 branch

From what I understand, I use the ndactl to create a  memory namespace
and I use this in the qemu command line to start. Given this and the
Linux having CXL support  I should be able to see the CXL.mem device
with lspci. Correct me if I am completely messed up.

I am not able to create the memory namespace with ndctl

I tried with

"./ndctl  create-namespace -t pmem -m raw -n mem0 -v -s 268435456" and
it fails with

"failed to create namespace: No such device or address"

Is there a step by step direction of how to test CXL on Linux? I can
document this process if someone can describe where am I making a
mistake

Raj
