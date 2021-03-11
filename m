Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0CC433DB
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Mar 2021 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B2564F83
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Mar 2021 20:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhCKUBH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Mar 2021 15:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKUBC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Mar 2021 15:01:02 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3F1C061574
        for <linux-cxl@vger.kernel.org>; Thu, 11 Mar 2021 12:01:01 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f1so41831600lfu.3
        for <linux-cxl@vger.kernel.org>; Thu, 11 Mar 2021 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ezZMH4vXt25Z4cy/Krmn4uBvgwJdzUSPpw3fvt2rRBc=;
        b=gLhNhFWjQx0R0ygQSvwFLtEtdgWDzHbgkH333y8IbcPETs7yMzr8NupGibwOMFVqgH
         G+AFHINjnZscqUtbT1vln9g8rtYligy+G4C0vuiMBwvD6vwPwjm03uqQIzvqAWqF8Swn
         xHmasP+nV7EenARcfQDIooM38RzVyjcYZd0EvzrXRMu8kr+C7f5NxZq5bel9Rzuc2ga0
         74FzTfj6bqX72bI0oXHi6Nkgny8rJlWlwDUfhtia9AtJouL7XNfLj3LuEFKLAWGTDvd6
         hRphKDD8WOfByTIRhCcIBpP6GYkY65YiW8zvoE/OUJRBV0SI4ed4wesyPE5Xke8/rMbJ
         32Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ezZMH4vXt25Z4cy/Krmn4uBvgwJdzUSPpw3fvt2rRBc=;
        b=i369ar8hmOjG93vAsgmSNsXnogRSTQk/maL+TeZ+01RUK16y90cx6k872peFf8oqij
         O7CF8mcXZ3qvHprJONF6pef8awWJukjp7IKbyTGgGF8T1mHSxcY8Fkbm5Fp6p+Nr9Ln/
         HFCbvcty8LbX9IRpNWS4+E4rx4Zz1wUi8tZUHwQLgAjXAFubJIFRH48DrGiE8+twer8l
         ASt3iA6KxqNM9geLo3pIRJtpROKvgFObmf/e41Sr4r6ywwbHabUmrQavcbTcU0R9qa9V
         TW5ExzpIhVf2kmhQY8jFeLkQcishmCcCFL9q0EKzbJDLqi4DfHYmvdAEyKeXpXhNeLHK
         SVbQ==
X-Gm-Message-State: AOAM530E6TCI9MUxaOQoI1/kt8pxQzRFU+c6pOQMXTjiNseb2kgzFpTk
        on7ud6AgfWvhbWw71Z4SDM5VrNCjcI41ad/NGEk301qz1To=
X-Google-Smtp-Source: ABdhPJwfvLvls+mKGTdytMxLBL/UAh/55cc6FgjIq++OySY6Z/YNU93VNvbm87BngF+7ItHSsXkcWqe5XUU0QfD/txY=
X-Received: by 2002:a05:6512:1106:: with SMTP id l6mr3063964lfg.204.1615492860118;
 Thu, 11 Mar 2021 12:01:00 -0800 (PST)
MIME-Version: 1.0
From:   Raj Vishwanathan <raj.vishwanathan@gmail.com>
Date:   Thu, 11 Mar 2021 12:00:48 -0800
Message-ID: <CA+-5cKckHDBC1V3S6eYBD=czKEn6Yu_ia_osLLvFEm+Ag0fbfA@mail.gmail.com>
Subject: Help!
To:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Can someone help? or point to some resources for me to move forward?

Raj

I am trying the following
------------------ Previous email --------------------------------
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
