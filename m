Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC1CC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiKNU2D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbiKNU2B (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:28:01 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF21E30A
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:28:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id be13so21244956lfb.4
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yI0Z0WUF25vAdUAzb99i8mXCOtV3NrfXMXkKeMX9q0w=;
        b=ixww5z2q3xSJU1fXd9z3oHe0bnavvQp8HB33LPJ+I7IirlgcGyFvpMDGWhdj7hme1F
         7OlPJvXn6cN4+lGsdQqowf98hHbsM59mtbAD3FpfLRqM5/hijgds0r5r/biJsIhC00qR
         sI9QZSV7rRHQgVzJLZghWKdzvpon3l3+tOSzlYOzjbYbg57prDNkcn0SgP0Y98II8xt0
         P6Yz2mbwph1/R3jCeMqwxrfWO/xGQ4Gr2I5bskaw6eNZnpkkP+m0SFa+y14UpBuT0evn
         qRlyQ1tui0CkM9qZH7ToTHiyFTK6IANeIcZ+PPMapFWKb4gWx6KRlwN+ALA54Tp2UOPE
         Zn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yI0Z0WUF25vAdUAzb99i8mXCOtV3NrfXMXkKeMX9q0w=;
        b=D90o3v2xPKViOvVWQchIV4BjKZo0zCpPPZFeoWoZSOvyCiSGnOKq6yWtK7Qkre7ASb
         uz1awFOLAL0MXG+xZjbFbcSfzncWBYTK6SRTAmwEos1/2Rld0nRZ1DtLLe0owvygCEWu
         dov5R3WvdCMBLNw4bJii1gV/7EDiRIvQFFUs0kcC1zF8fzMyGpku3qJcWkP/pgjzsggQ
         n4+6XTp5t7xaOMlywpe7Ucya6WiEDmzRa4UX4hIX0AuGxoa19JpbpwlUb6du33NPxoox
         8SsvGwZjR1HupOBPcCbW4gTY+cBq65Cm06B7IQ9jGYM2wAHC3a5PTEJx/t6U3uawL9tD
         +KoA==
X-Gm-Message-State: ANoB5plDAN7CkxuXqSkGqtgMByDnTt5YW3uvP4Fn9/pTJJG3NcW1ARql
        9/1roV0wJCWj9S/Tf/VM5vU91AEKEqSuZYmi
X-Google-Smtp-Source: AA0mqf7rouyshFFxPBr/1NgXCvSVRhFW17XzLdZ1PhdOdNLVmKOuKeTz17bDFF8lwiJbwD9mTuLFxA==
X-Received: by 2002:a05:6512:718:b0:4b1:b7d0:21e4 with SMTP id b24-20020a056512071800b004b1b7d021e4mr4970962lfs.72.1668457678922;
        Mon, 14 Nov 2022 12:27:58 -0800 (PST)
Received: from ubuntu.armcompdev.pub.tds.tieto.com ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id cf13-20020a056512280d00b004a4731f75a5sm1935891lfb.250.2022.11.14.12.27.58
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:27:58 -0800 (PST)
Date:   Mon, 14 Nov 2022 20:27:57 +0000
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     linux-cxl@vger.kernel.org
Subject: trace events
Message-ID: <20221114202242.5f9023d3@ubuntu.armcompdev.pub.tds.tieto.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello cxl mailing list,

I just started a project for validating the RTL of the CXL root bridge
from Intel. One of my first goals is to better understand the
SW/protocol flows, so that we better validate it. I'm going to use
the tracpoints for it and possibly lttng. Are you considering adding
some of it shortly? If not would you be interested into the patches for
it?

On the list I'm seeing include/trace/events/cxl.h but on the repository
kernel/git/cxl/cxl.git seeing none for example with:

 git cat-file -e origin:include/trace/events/cxl.h

Thanks,
Marek
