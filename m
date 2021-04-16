Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E990C433ED
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 01:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598246101E
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 01:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhDPBxa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Apr 2021 21:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbhDPBxa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Apr 2021 21:53:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F88DC061574
        for <linux-cxl@vger.kernel.org>; Thu, 15 Apr 2021 18:53:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n2so39723681ejy.7
        for <linux-cxl@vger.kernel.org>; Thu, 15 Apr 2021 18:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LP27OnqeI918q6Pd6DACqeTjD0c0CLUkc5Dyft78Fgc=;
        b=wD2ZksK6yf1FtGCCFI4Y7NxAy1aXdt1fQxGKfdnmokJSL0oRENrPj+sOn2bittiV1Q
         7qrKqLHLNkyh/aZ/8ngTsR+Ad0dZ3QkKaOEUmPpcHZkC+dv6CFgjcGVEArs1Jdflos0h
         04IxD/0FxqpAQ0SPRbsaQgf80X+J6bxQxJPImlTqsFQBRNXrHlSEJzrb/0rEasQlB6BH
         9E27V+nS9WVQhlbPV2nD1gQsIuXbYNpAW4Xa9zlQFON5fTBetvTQtElS2XPBqqiUfdfH
         65Vc0ehsF5bwGuvd1EAp8n1Q9t4FtNhfPM7EUznO3SUSLyq3WMm/uMFaJTCBoZMAqR9o
         ZX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LP27OnqeI918q6Pd6DACqeTjD0c0CLUkc5Dyft78Fgc=;
        b=BGd3mRqbut2RFcWvbSsGFyxVVC8xA1NcOW6+ri4us/OtjnYu9FV1LONsW0bOyddHQi
         QpJzuRgKKMzjBZh3HyP6EYY+5RslwYqPM9aznhpkU5B46xtAhjdDZ+c/No/aeE31J5mu
         0EcjzjVoluySt3Vt5i+aLWLoYqqaskrLGpJXU4/VMcdTLktqC3vCj9cOpwsWdm6Xzb3b
         Alx8PthRV63Ys2Sp8CzqrVkvUOd7KoHi0qfDuU6cEQVU9H95ZNrsOlJrQM1kzpWp4sRx
         AzPhXvqFCujJW9ZVIQmmeXbLb5JfOTSeJS73+1FjA7BPi1Rq2Fxgx77/sM7Lxblqhf3M
         n21Q==
X-Gm-Message-State: AOAM530tSp7LMe69IPwdBEihrgfDBMeZrK6DTRcPLqhFYJ+tNgItVbfv
        5I2GQD1oR4az8BZ+1pQYqJn58VXedIbG00oBkt8no6SjNxJcCg==
X-Google-Smtp-Source: ABdhPJwou5AeQcuJy+kCt4z16Wbq0Mg3Jcb62ewEoNoWI2dMqF32uyhjCcIc5rr4DQRR1GQBcqdzu9jHmQ/jpkPjOlU=
X-Received: by 2002:a17:906:8407:: with SMTP id n7mr6053232ejx.264.1618537984788;
 Thu, 15 Apr 2021 18:53:04 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 18:52:53 -0700
Message-ID: <CAPcyv4gseedV78W72ERtdGozW_V3aTpPDw5-Py3X4HWRFYRbSw@mail.gmail.com>
Subject: CXL Trees for linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Stephen,

CXL development has established a cxl.git repo on git.kernel.org. Please add:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes

...for fixes targeting the current rc cycle, and:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next

...for new development targeting the merge window.

Thanks for the help.
