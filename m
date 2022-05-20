Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE4C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 20 May 2022 18:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbiETSBP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 May 2022 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352393AbiETSBO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 May 2022 14:01:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F73E1E3E1
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 11:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B185EB82D88
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 18:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E099C34100;
        Fri, 20 May 2022 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653069670;
        bh=ImQUdYKNrIij1Jw+4uGckVBsrpG6gEgp3/Eczb9EBsg=;
        h=From:To:Cc:Subject:Date:From;
        b=UsgTvYA1MiIuraliQIXh7BBXab5KL9+8x6+Xz22T/773gnxv06BsqXuvGnRCqTeU0
         hHKjCufHShk6UGHiQabGoBaAgCS7cNU9SnpuETAccVMA4mUgyxn9ijXAOAWXgSnp0U
         1YRgEYXXuoMyE7jwvLufrKCYBo0NGiDM2oeV0WsAcYplV1vFRMq062QjnjRNBxtboW
         hr7KqkuqIWbzMeNMQPJ0o92anL6It4Kqf4EX/CV2GewGhv080/Voj3a71EDwJm4rmb
         iEehGjVrIZNzuMv9eztI1xjM7r5GkiHfZRIwA17SpROQqDKMoEqbiNgOVTDHRN7zIU
         XDFnoHKb9TUEA==
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] MAINTAINERS: Update Ben's email address
Date:   Fri, 20 May 2022 11:00:59 -0700
Message-Id: <20220520180059.632054-1-bwidawsk@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

I'm leaving Intel. Update email address to korg and add .mailmap
entries. For now, I will be taking a reduced role in CXL development,
but I still plan to spend time working on it, and I can still serve as a
good substitute if needed for maintainer responsibilities (that may
change in the future).

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .mailmap    | 3 +++
 MAINTAINERS | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 97ccdf147111..e8fb056a8935 100644
--- a/.mailmap
+++ b/.mailmap
@@ -61,6 +61,9 @@ Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
 Ben Gardner <bgardner@wabtec.com>
 Ben M Cahill <ben.m.cahill@intel.com>
+Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
+Ben Widawsky <bwidawsk@kernel.org> <ben.widawsky@intel.com>
+Ben Widawsky <bwidawsk@kernel.org> <benjamin.widawsky@intel.com>
 Björn Steinbrink <B.Steinbrink@gmx.de>
 Björn Töpel <bjorn@kernel.org> <bjorn.topel@gmail.com>
 Björn Töpel <bjorn@kernel.org> <bjorn.topel@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index e127c2fb08a7..f5545ce42cc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4842,7 +4842,7 @@ COMPUTE EXPRESS LINK (CXL)
 M:	Alison Schofield <alison.schofield@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Ira Weiny <ira.weiny@intel.com>
-M:	Ben Widawsky <ben.widawsky@intel.com>
+M:	Ben Widawsky <bwidawsk@kernel.org>
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
-- 
2.36.1

