Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0139CC41620
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Mar 2021 00:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AC464F09
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Mar 2021 00:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbhCDA7Y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451229AbhCDAgE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Mar 2021 19:36:04 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0594C0613DF
        for <linux-cxl@vger.kernel.org>; Wed,  3 Mar 2021 16:29:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d3so40165736lfg.10
        for <linux-cxl@vger.kernel.org>; Wed, 03 Mar 2021 16:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ONK94MZgVSDny2ilxX6r4SZWWoxXErPn+J3MDhmJDfs=;
        b=XWq7MSs6rb2TJEcT+9UP/MdsDPK++HgvKzfosfD12cPwSEXrIGQEKDsp74l4yKXEaJ
         C0xLO6Jykq+YZXl94Q0KGquPvFoiemaahXGUXgYmcJdNhxKzyIa3oPnpj19vMugFSs1G
         5kDlZILtp1HT2ThQN2DHWOqu62Vk5e70oTl9j9ztcpUNDElIJGPF2mF9GRxhjG2eg2/K
         OOZ+MvpDof+Hsxy9KARRUeLjgD8ER3aA5nrsgfcklE9fL8K0vP8e9K++cHez4E7/hkbZ
         GaMWX5IwfKV5cA5xbKbIoTVL+8m/CUBdW8qEA3SE6fTABS+o3V2Vdw7nDAwPPx/COipe
         azeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ONK94MZgVSDny2ilxX6r4SZWWoxXErPn+J3MDhmJDfs=;
        b=gHZljGAdXH/5FPJ0jtfhP7a/fzFhNJOco7Oak8jZjFkGLueOR7VTBQVQ/lRAysRFpX
         kdqgrO6k1zzx7aVbkOxMEiSKdVu1CEOdx4LaoVTAGUV6v10nKYBLljxPTpXhq2nRHxtI
         rF9QfkRuovmP5Hxn83c7AfjgR1KaChH9hR159J070vtEqpnlPtE4broknINzmvoVWiaF
         NMVHMReNtbg5avrwq/c9Cd2jXicsKzL0Wp6jvyYkVlhAXCqvKQqT6+DcN/AIitpzecXx
         awT0HsfRJjEvnpNvibgNPIpfQDjwEuOdm/O73Hrgj0Ntwb5EjdvKX9pjzvVJIG9LFsWY
         Em2Q==
X-Gm-Message-State: AOAM532r5oX9XbI2aCgI0FhEQIPozWxhROXTGlbQfp3jU+aZONvzHr6l
        VDQCY7pAejyA3gFCEHtzJf07sP9KKn6PnfMAq2hGqDbuZlI=
X-Google-Smtp-Source: ABdhPJzzlt7DlW+M/fyA91IunAXM6SBiw8fRKMB2gHiR+ZSnbJJzkFy4zSLaExAlKVVhbHkefSo4ta5Zl/zku69q+P4=
X-Received: by 2002:a05:6512:1106:: with SMTP id l6mr723081lfg.204.1614817786200;
 Wed, 03 Mar 2021 16:29:46 -0800 (PST)
MIME-Version: 1.0
From:   Raj Vishwanathan <raj.vishwanathan@gmail.com>
Date:   Wed, 3 Mar 2021 16:29:34 -0800
Message-ID: <CA+-5cKeAxJSFve5HzFDREj3uOFanGZ7CH33RnPe4G003hQa7AA@mail.gmail.com>
Subject: Test Message
To:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

I tried to subscribe to this list  and it bounced from my yahoo and
outlook address. Just checking if my gmail works
