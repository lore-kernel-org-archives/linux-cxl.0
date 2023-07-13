Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C4C0015E
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 20:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjGMUbl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjGMUbk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 16:31:40 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A92121
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 13:31:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DD060141268;
        Thu, 13 Jul 2023 20:31:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 368581417D8;
        Thu, 13 Jul 2023 20:31:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689280297; a=rsa-sha256;
        cv=none;
        b=aK12w/N2V2YWGP/2HFWUax4snF/VKytEXhu9f3wgOxCEHlDrebw7dOOg7HCiPuhCyywWQo
        c5SgoiNEqogoh2PnIjQh5n5HQgs7LyARkrHquQSJUkKILnNr+5gw2k3NuwQ7aI4KlTuRKx
        WcGpLacabcnMpJLX1bCLlhGxJg+R4EstbEjGqZ0WVN3cNvOTObURgRXRmAgFJRKhwZLfSo
        /B7vTwJ10yRa0m5BwtuW5K2PFNy040slEHYKqNSzAT2xMDwEIVeoR9CKNn/mtU2/IfZZl/
        X0vIwzs3VNZ62I0KXZL/WWXZU6cePo69uCXrR+u7c6clPFPOQfDafDAXjipTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689280297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=DH8z4FJ5hHLI77wXPCUjJKIVl6whz5q2SGY/Zt9Wyk4=;
        b=SObIlExvRIIxwAmapWylBPz6GFRvNwglz5CzlKpAklxJ3OelJMPCN8Ze0jnJupzui9A5R7
        MGdLDgp2nzlQXiBL4Q2jj+UCI9Kjna5xIIvrHs/4lUfQFYc68sTHp4mIVM0XseiF8b/cnY
        6zvvx4SKN0eRqM7OgdUguBumxVPJt0K1cJDFfzvqQQRPY4KCd9AzxypFmDV/vhRsf+6Xk6
        rtVbX4WmgwrML3Pa2VVmvC+CUqPyS5obkQzgW6XWqaqBIZ4/CVWTlPf/9y+tw9lLLasDau
        JdWbz5jZK+Vjh43RtWxnz0XL3SXpJZSUHGIRNFkq2oL3wyBKCEwhegusEuGzGg==
ARC-Authentication-Results: i=1;
        rspamd-5595f87fc9-zmt67;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Industry: 6ee965ed4b9484dd_1689280297482_1709596642
X-MC-Loop-Signature: 1689280297482:659144134
X-MC-Ingress-Time: 1689280297482
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.146.72 (trex/6.9.1);
        Thu, 13 Jul 2023 20:31:37 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4R25qX3ywZz2c;
        Thu, 13 Jul 2023 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689280297;
        bh=DH8z4FJ5hHLI77wXPCUjJKIVl6whz5q2SGY/Zt9Wyk4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=SEo9zrN05wVJDVO4gJZHFTh1UlLRcGzDYcQRuIjsTt0yYp17Rvns5tO3L88RmL750
         EKmjaKFPb6qwNGshkecKLNHZspwwQN0aiBYsO0bMQLDLi5h4MRlx5xW3fNCx5DYg2f
         VI1SBHvofqujQgzNzozgnFZSYotAQPehZS1awguB/t7OeehfzBTm6WHwtME/8UG3uD
         lsHAvoOtGbdzb1ekxlW85MIBzedvMP5tPFCoMb8yYokP2/UY6FWTxo4Lz5p7cMZqLd
         l33AjIzYiGfQbCh+v5f3tSQhStIn93g3ZGnWzH7JPWMQwy0kl3Ha1SJsmxPekGstoG
         6YJRQvhaYHirA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     vishal.l.verma@intel.com
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH -ndctl v2 0/2] cxl: Support memdev sanitation
Date:   Thu, 13 Jul 2023 12:54:49 -0700
Message-ID: <20230713195455.19769-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

Changes from v1 (https://lore.kernel.org/linux-cxl/20230423015920.11384-1-dave@stgolabs.net/)
    o Added a LIBCXL_6 section for new symbols.
    o s/sanitation/sanitization
    o In patch 2's manpage documented that sanitize does not
      involve explicit CPU cacheline management.
    o s/host_path/dev_path in patch 2.

These are the cxl-tool new subcommands for device sanitation for the kernel
side equivalent (v6.5+).

Obviously the naming of the interfaces are derived from what is currently there
for ndctl. However note that the new cxl wait-sanitize and sanitize-memdev
commands do not rely on pmem security, such as ndctl_dimm_get_security().
However, the kernel does consult pmem security before sending the approving
the operation, so no harm no foul.

This code is also available at:
     https://github.com/davidlohr/ndctl/tree/cxl-memdev-sanitation-v2

Thanks!

Davidlohr Bueso (2):
  cxl/memdev: Introduce wait-sanitize functionality
  cxl/memdev: Introduce sanitize-memdev functionality

 Documentation/cxl/cxl-sanitize-memdev.txt | 68 ++++++++++++++++
 Documentation/cxl/cxl-wait-sanitize.txt   | 39 ++++++++++
 Documentation/cxl/lib/libcxl.txt          |  2 +
 Documentation/cxl/meson.build             |  2 +
 cxl/builtin.h                             |  2 +
 cxl/cxl.c                                 |  2 +
 cxl/lib/libcxl.c                          | 94 +++++++++++++++++++++++
 cxl/lib/libcxl.sym                        |  6 ++
 cxl/libcxl.h                              |  2 +
 cxl/memdev.c                              | 73 ++++++++++++++++++
 10 files changed, 290 insertions(+)
 create mode 100644 Documentation/cxl/cxl-sanitize-memdev.txt
 create mode 100644 Documentation/cxl/cxl-wait-sanitize.txt

--
2.41.0

