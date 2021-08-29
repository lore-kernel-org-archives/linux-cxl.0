Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B787C432BE
	for <linux-cxl@archiver.kernel.org>; Sun, 29 Aug 2021 18:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863DF60F3A
	for <linux-cxl@archiver.kernel.org>; Sun, 29 Aug 2021 18:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhH2S21 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 29 Aug 2021 14:28:27 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52356
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231919AbhH2S21 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 29 Aug 2021 14:28:27 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CA8323F04D;
        Sun, 29 Aug 2021 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630261654;
        bh=BCJeSu6Ppr2OhOB7/69UMFfqAB/FiVSuD5l0YDxuwJE=;
        h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type;
        b=QdZKZfsZBsavjU6gvKd5SaxO3ioOufPAf9JjdvS2bYDwHLdbcGQzPWxcxb5wJMI8T
         mVu6IQpzQvwCV9Q0FJmOW/vbif72wYFPHfuQvXfSLf+fxymn7Q9OSJeoiBLbmglIrH
         ldaOtBNFNOoS8EB8u0aTHByepzb9uko7XiCZlQPueXl6/kLsv4FwYiHB/cltUbdzo0
         PmqtQJYxxX16UjHEi38kFR+nmbsaSzaafO0vAciZW9XFyWz2D8Iw375EADsWs8bncq
         JWh1Cnh7YtfXcpUn7YAkPvUVBJudk9ATirujlIzVD35Ije4YfWRHEYL/wOdO1Htr5G
         aG7VsihQ9Sw2g==
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: cxl/core: Split decoder setup into alloc + add
Message-ID: <99e8520b-b613-72f8-f24c-b0b760de36eb@canonical.com>
Date:   Sun, 29 Aug 2021 19:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

Static analysis on linux-next with Coverity had detected an issue with
the following commit:

commit b7ca54b625514464bac2db59b754e95c49b66fb5
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Tue Aug 24 09:07:56 2021 -0700

    cxl/core: Split decoder setup into alloc + add


The analysis is as follows:

494 int devm_cxl_add_decoder(struct device *host, struct cxl_decoder *cxld,
495                         int *target_map)
496{
497        struct cxl_port *port = to_cxl_port(cxld->dev.parent);

   1. var_decl: Declaring variable dev without initializer.

498        struct device *dev;
499        int rc = 0, i;
500

   2. Condition !cxld, taking false branch.

501        if (!cxld)
502                return -EINVAL;
503

   3. Condition IS_ERR(cxld), taking false branch.

504        if (IS_ERR(cxld))
505                return PTR_ERR(cxld);
506

   4. Condition cxld->interleave_ways < 1, taking true branch.

507        if (cxld->interleave_ways < 1) {
508                rc = -EINVAL;

   5. Jumping to label err.

509                goto err;
510        }
511
512        device_lock(&port->dev);
513        if (list_empty(&port->dports))
514                rc = -EINVAL;
515
516        for (i = 0; rc == 0 && target_map && i < cxld->nr_targets; i++) {
517                struct cxl_dport *dport = find_dport(port,
target_map[i]);
518
519                if (!dport) {
520                        rc = -ENXIO;
521                        break;
522                }
523                dev_dbg(host, "%s: target: %d\n",
dev_name(dport->dport), i);
524                cxld->target[i] = dport;
525        }
526        device_unlock(&port->dev);
527        if (rc)
528                goto err;
529
530        dev = &cxld->dev;
531        rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
532        if (rc)
533                goto err;
534
535        rc = device_add(dev);
536        if (rc)
537                goto err;
538
539        return devm_add_action_or_reset(host, unregister_cxl_dev, dev);
540 err:

   Uninitialized pointer read (UNINIT)

   6. uninit_use_in_call: Using uninitialized value dev when calling
put_device.

541        put_device(dev);
542        return rc;
543 }


There maybe more than one incorrect jump to the error exit path label
'err'. As it stands, the put_device(dev) is occurring on at least one
error jump to err.

Colin
