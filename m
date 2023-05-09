Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A8DC77B7C
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 15:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjEIPar (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 11:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIPaq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 11:30:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71EE468E
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 08:30:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643557840e4so6506806b3a.2
        for <linux-cxl@vger.kernel.org>; Tue, 09 May 2023 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646245; x=1686238245;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7Kfo5IoYaNITwCS7KZb9AEWHVN5q9jOIDAvAT9AqOw=;
        b=GXPSX8ExSi7KHfhO/6v4hOCe16Q9vNVbKrR4QOAQ3O3SzLB+Pnaw+gZ+/jIZTvz5m3
         CAa98t4PLZwr7Ijt+tp8S8dlexzqNVtym+vLckKPTJc++p4aL24RReKl6zmZIH8NPDhb
         Qp1QwxAPS3ANNf+UnnsHkswnyfl2l+ZDgEfoM2RFbxSEpaHoymh5sdM5KaqEdG01C6qL
         Vn3p8LHX6kf7NfjoMg6I6qQ4oC5dW8jKBh2szTjFk42fjMJLpy1P0YFlyJIw26MEQXL3
         tFJUe4nwFa54fyasVvICKofuc3f2WwfsUpTtL6rYC/Y73rX/SXEAQWg2wJB8VZeSwbbh
         InDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646245; x=1686238245;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7Kfo5IoYaNITwCS7KZb9AEWHVN5q9jOIDAvAT9AqOw=;
        b=Wk8T79ktnhXQddxEJfsN2JEd4bDMdVP2B+nRHB0xdL1EmbWmpLZYMpda3+jNiDz8nX
         41WUHdX9Hbkmq7lMYfto8OOwzAiGXruAGNtSSYhZ3/tW+ODGtLiPh56Z7bo+Rp25Ke+V
         crUtTvfTRhwjnWMXOisKvAOX3tQpouTZSKJQxFV9LhFJ2HOl+h2N8q+3RLiJqOFjBFT0
         EitxWe8NmduT4zjBRwmG9tIMaU3Ga9O0vwXZ4kEiJwbeN+eA4Rr+4LevzNVXgT/wp6oN
         iSlXq1g/oMWT0Ri1lCqtBQC/T28AzPcjKOSLHxnD5Hwemep9AuvDh1klC8L5LaKHpTgL
         1FTA==
X-Gm-Message-State: AC+VfDwCLtfaPaO2cbmb7vEJntZoEVRbRrv3Xvrbaxa8Ak82b7B1P+Lh
        3QM1ncA8PfFr1e1qsaeSOtGGokV297I=
X-Google-Smtp-Source: ACHHUZ4yAbFTXp+9NWzeX7WmWaR2uMzGlq8yNtb1Pf9WAxKkJ8rzbuXvV6ELPHtK3pLRsbFoK8+Gjg==
X-Received: by 2002:a17:902:cec2:b0:1a8:1f41:59ba with SMTP id d2-20020a170902cec200b001a81f4159bamr17262823plg.38.1683646244697;
        Tue, 09 May 2023 08:30:44 -0700 (PDT)
Received: from minwoo-desktop ([1.230.133.98])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001ab0669d84csm1750195plk.26.2023.05.09.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:30:44 -0700 (PDT)
Date:   Wed, 10 May 2023 00:30:40 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Subject: ndctl-v77: LIBCXL_5 not found
Message-ID: <ZFpnIICkh3Wpqmn/@minwoo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello ndctl,

With the recent tag (v77), after building it with the following
commands, `cxl` command is not albe to find `LIBCXL_5` version from the
/lib/libcxl.so.1 installed.

	meson build
	ninja -C build
	meson install -C build

	root@vm:~/work/ndctl.git# cxl
	cxl: /lib/libcxl.so.1: version `LIBCXL_5' not found (required by cxl)
	root@vm:~/work/ndctl.git# ls -l /lib/libcxl.so.1
	lrwxrwxrwx 1 root root 15 May  9 15:28 /lib/libcxl.so.1 -> libcxl.so.1.1.3

I'm not pretty certain how to go through with this, but I'm using v77
with the following patch which might not be a good one to solve it.


---
diff --git a/meson.build b/meson.build
index 50e83cf770a2..665b8e958178 100644
--- a/meson.build
+++ b/meson.build
@@ -307,7 +307,7 @@ LIBDAXCTL_AGE=5

 LIBCXL_CURRENT=5
 LIBCXL_REVISION=0
-LIBCXL_AGE=4
+LIBCXL_AGE=5

 root_inc = include_directories(['.', 'ndctl', ])



It would be great if any folks here can provide advices on this.

Thanks,
