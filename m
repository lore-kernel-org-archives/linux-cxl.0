Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1288C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 16 Jun 2022 17:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378231AbiFPRTp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378067AbiFPRTk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 16 Jun 2022 13:19:40 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8526E5
        for <linux-cxl@vger.kernel.org>; Thu, 16 Jun 2022 10:19:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 63125215B1;
        Thu, 16 Jun 2022 17:19:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C62F821768;
        Thu, 16 Jun 2022 17:19:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655399977; a=rsa-sha256;
        cv=none;
        b=I0U5btCKevthhg6R2g5V8OuPPvH58BXFSYm6dRQcV7xE0MlkiAqcJq05yQ4wLJY2KVecYz
        7Xv8098TjM96cjiQeRxRVuW0FTfnGjoDXQnoaZk1yU9KymCOA4TgCIWlu3pKgfFDR3YrdP
        7u0NIN7nAIYgRPWKIlrdLe33X9xQABIFgNRYQQtMxLOplYdGWvmNnWJoUXpVvfdOhxdVRs
        yUXENwVOt1D5Q6LQpitvML2i+o90mmipddKkbtoHQ2fIwZfUaelNfm5QIBt1PlX0Tcuy5N
        XxBZ030lVY64nYKR611i1A3EdvElpkAnGBbo40DrxS8n1AXK8SsPn2E6a3AkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655399977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=PM8YyFKcDux8T7r4uQmprBX+qh5eaBPs2+cNusSpmaY=;
        b=lN+UHemZxdYnin88rLZ167KA7igQp1XMJRrg3VLvIv6NPXcOTFs5wxBIjImL94TQJDoqOQ
        vDDCFP75jteLfsWTD7cvwkwszDPWLdUm+TIH+wRjy+FtWQwTsdqReBHhdkRJoNa/ZKyJkF
        rAoNQVuybvd1Am6W8oEJ86F00T2hJWn7vg5yKKzLcHnGn3f/yNTIyXGgouQUDI+KBgBqrJ
        kFSiy1z1EWERFE+yubpyTJakEcxD1jKgC8dLdZXeocv5wzjGlvOhQE9oe+H1LOe0Dsewju
        jDDIEXGpF4qIY9t0u+al6PMAclpzIc25ZNRx9Oa2+iUTVjWI0Ey58uOjGB5TJg==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-2dglm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Eight: 0bbe6bc61730ad7c_1655399978114_2632739479
X-MC-Loop-Signature: 1655399978114:2392080877
X-MC-Ingress-Time: 1655399978114
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.105.211.178 (trex/6.7.1);
        Thu, 16 Jun 2022 17:19:38 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LP86x16DTz4f;
        Thu, 16 Jun 2022 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655399977;
        bh=PM8YyFKcDux8T7r4uQmprBX+qh5eaBPs2+cNusSpmaY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=gn7T9g1ZnhykQLj74c5Gl0qhrfWi1W+D3at00J+fuEfI70PS9xs9+MtMfAbTpOsvH
         VoT/KM+aIuMEl/VwTve102NEK2xP0xtDJKecp6EIsro9eEr340Eo9mqv4iUDd/9zsj
         6JoPqSFCJGfHDdZvCAMvDm/2GxZ++z+0TFo/g8jv2sVAiXxO+uvFGRekx9vVmdFsST
         8+wj4r/Xmx+bvRv0XkSxyAaNYq/z8/Fy/Y/Xzip3ZPkzGjrxHbXoN7bUV6+E2Vol+9
         C4FQy8jbh7Qi3sFzxO3iRza3rak4vaJaZGuaeVWGQD0Eh2dX2VphZmkSuFWkzuPDY/
         WrdZD6+ve896A==
Date:   Thu, 16 Jun 2022 10:19:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        Dan Williams <dan.j.williams@intel.com>,
        Steven Garcia <steven.garcia@intel.com>
Subject: Re: [PATCH] libcxl: fix a segfault when memdev->pmem is absent
Message-ID: <20220616171934.s6m72nsh2kkvmciu@offworld>
References: <20220602154427.462852-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220602154427.462852-1-vishal.l.verma@intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 02 Jun 2022, Vishal Verma wrote:

>A CXL memdev may not have any persistent capacity, and in this case it
>is possible that a 'pmem' object never gets instantiated. Such a
>scenario would cause free_pmem () to dereference a NULL pointer and
>segfault.
>
>Fix this by only proceeding in free_pmem() if 'pmem' was valid.
>
>Fixes: cd1aed6cefe8 ("libcxl: add representation for an nvdimm bridge object")
>Reported-by: Steven Garcia <steven.garcia@intel.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
>Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
