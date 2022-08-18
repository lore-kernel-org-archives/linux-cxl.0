Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62400C32772
	for <linux-cxl@archiver.kernel.org>; Thu, 18 Aug 2022 01:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbiHRBXR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiHRBXG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 21:23:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23949FA8E
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=m1c/7dgPgZmh95BH2HkKYjB3kfsbPA12W+wnkT9IoEQ=; b=mOm8BOTF42txzxFMLIy7rw9bJc
        iBazSuaVC1QNSeS9uUg6jh9Setg7SD/DEh0FUwMvQ+GFuLFtb/OzyQKl1GedgnoViqMGmhlYqQ12D
        wV6HccDIX/vmO5rgdd1eosc4lzv9ZzemQ4Aw+0fVi2L5/J8794/2b8IK/el4GqzCJ8A8QUBKrvzbb
        NrRtba685E2VWN1SxWoSHNLbEH2j22iM32FDHsdqED2qq8IvvdDA9ZfyvFSMXtiXIL2C8Hk4BUxSJ
        ro0XPcZyqwYvQ+2jFUgopfsGSTpednoSL8VvSOi5JPjAeN6FGx6IQu1bbj/qQryiWGB/p2KiJXvEp
        bKEPLFAg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOUFU-00A4SO-6I; Thu, 18 Aug 2022 01:23:04 +0000
Date:   Wed, 17 Aug 2022 18:23:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc:     mcgrof@kernel.org
Subject: [ndctl PATCH] meson.build: be specific for library path
Message-ID: <Yv2UeCIcA00lJC5j@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

If you run the typical configure script on a typical linux software
project say with ./configure --prefix=/usr/ then the libdir defaults
to /usr/lib/ however this is not true with meson.

With meson the current libdir path follows the one set by the prefix,
and so with the current setup with prefix forced by default to /usr/
we end up with libdir set to /usr/ as well and so libraries built
and installed also placed into /usr/ as well, not /usr/lib/ as we
would typically expect.

So you if you use today's defaults you end up with the libraries placed
into /usr/ and then a simple error such as:

cxl: error while loading shared libraries: libcxl.so.1: cannot open shared object file: No such file or directory

Folks may have overlooked this as their old library is still usable.

Fix this by forcing the default library path to /usr/lib, and so
requiring users to set both prefix and libdir if they want to
customize both.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index aecf461..802b38c 100644
--- a/meson.build
+++ b/meson.build
@@ -9,6 +9,7 @@ project('ndctl', 'c',
   default_options : [
     'c_std=gnu99',
     'prefix=/usr',
+    'libdir=/usr/lib',
     'sysconfdir=/etc',
     'localstatedir=/var',
   ],
-- 
2.35.1

