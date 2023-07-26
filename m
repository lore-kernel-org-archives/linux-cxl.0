Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36335C001DF
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 20:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGZUiD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGZUht (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 16:37:49 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B7410F9
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jul 2023 13:37:48 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 81F2FC1DA2;
        Wed, 26 Jul 2023 20:37:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a272.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id ECB26C0E8B;
        Wed, 26 Jul 2023 20:37:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690403867; a=rsa-sha256;
        cv=none;
        b=IXepS5io0W2EDlxjxOVRahpLGVhSIyImcGMICxAau1NrUMD7GBoDO/f3QngsdF9EmaktfU
        6S5I7pHEaXcejKa0Ze8xiUFnyMEk5PcChZALv3UVbIxj2XWrpRHh0SymieOCO+cCWtcbKZ
        FajAiUSl9bKL7dFOxOZxE5Mqx0NyisAJQm4z5fCdCeLk0BgZBqCFyl/irT3GFDo36Az7Sg
        75jkbhrlKLeF2W3jvU1y7M60IVul5tyQw5MhFKPxs5qmFq3dSZHh1pbEsk5cDvJsLN0e77
        BrwaiRlEAWX9VvJOcZhrJ8SIqoz9vAGk8wnVROChPsq0sFeZqAG7bYYHYneI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690403867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=vqjklyv31KaL4OdF+JFBqflLUWEGyfJ3ro0OT7CSuzk=;
        b=Tu3MAzJwYxLFWJ0dphbmHEH+Lf5kGyvSlbL67QaceBJIwZI5johgnhSJyQNtiPPQBhmTvW
        E1Kl5yROoIlQGxavSEN0DJ5qWdMTUnIbfFgkB6PiD0u2HiuDI8oIJ+Xu/97nb+iS20Iorq
        2qigT8lxbAO7fcUQK1H6oFpqL5Y/bT4pCN4WYHT1Duj7OHtQyROwUtfHPv694XCbbGB35r
        T9VmDvR/VG1h83GPjPQ7rGq1VDD34y1WOA/ykZOP+H7I7X9mcL4SWrIlPg9rTaR1fJqH/2
        iFR7l/GzMeEvwEtXGUB8z1kDFViRJ221t+UBkVTY71Lw41QvSXJW+2eq6rG7fg==
ARC-Authentication-Results: i=1;
        rspamd-649dfb7d6-br5h7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Coil-Bottle: 0da97e6e50239814_1690403867329_2357483514
X-MC-Loop-Signature: 1690403867329:890071381
X-MC-Ingress-Time: 1690403867329
Received: from pdx1-sub0-mail-a272.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.0.89 (trex/6.9.1);
        Wed, 26 Jul 2023 20:37:47 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a272.dreamhost.com (Postfix) with ESMTPSA id 4RB5Ld6gFsz93;
        Wed, 26 Jul 2023 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690403866;
        bh=vqjklyv31KaL4OdF+JFBqflLUWEGyfJ3ro0OT7CSuzk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=FYKxqfZ19GBdrycyBQ4/5pedQGSfL/NaXQhSRLf8VRnIKluE87re6oCn/klSdFU2J
         j6iMHEps+hjZxlHNZc0/eE8pLY9+Msam4viuwcYtWNRvrfFQnWH+V2o/WUwCH6dMSN
         A8NbFD34+En9W2ZV0NI26VOEAY9LQGyoGlwD2WceBIGzxnum2ZnK6NPO+FgBrCmUGc
         csVVuGBGNQy2M4sGu5F7eh3THcKopCCoOYMGh7j19uG3PDmLYM4FaHP8AaUT2GolG0
         QbmIIsQIHHI4wtlNF69DBh4cLgb2s7gcnnC4DOA+PUcxjWVouP5lzyjRQ/ARTkDokg
         pxFJ2XZhIHHGA==
Date:   Wed, 26 Jul 2023 13:00:31 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linuxarm@huawei.com, Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, fan.ni@samsung.com,
        a.manzanares@samsung.com
Subject: Re: [RFC PATCH v4 4/4] cxl/pci: Add support for stand alone CXL
 Switch mailbox CCI
Message-ID: <r7djcwxcuzsvqcwbct3iiyljdhpsobvgjwuxjmlew3cuo52lcg@xkrkc4srqzju>
References: <20230719091931.27799-1-Jonathan.Cameron@huawei.com>
 <20230719091931.27799-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230719091931.27799-5-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 19 Jul 2023, Jonathan Cameron wrote:

>+static int cxl_swmbcci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>+{
>+	struct cxl_register_map map;
>+	struct cxl_swdev *cxlswd;
>+	int rc;
>+
>+	rc = pcim_enable_device(pdev);
>+	if (rc)
>+		return rc;
>+
>+	cxlswd = cxl_swdev_alloc(&pdev->dev);
>+	if (IS_ERR(cxlswd))
>+		return PTR_ERR(cxlswd);
>+
>+	mutex_init(&cxlswd->mbox.mbox_mutex);
>+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>+	if (rc)
>+		return rc;
>+	rc = cxl_setup_regs(&map);
>+	if (rc)
>+		return rc;
>+
>+	rc = cxl_map_device_regs(&map, &cxlswd->cxlds.regs.device_regs);
>+	if (rc)
>+		return rc;
>+
>+	rc = cxl_map_mbox_regs(&map, &cxlswd->mbox.mbox);
>+	if (rc)
>+		return rc;
>+
>+	cxlswd->mbox.status = cxlswd->cxlds.regs.status;
>+	cxlswd->mbox.dev = &pdev->dev;
>+
>+	rc = cxl_swmbcci_setup_mailbox(&cxlswd->mbox);
>+	if (rc)
>+		return rc;
>+
>+
>+	pci_set_drvdata(pdev, cxlswd);
>+
>+	rc = cxl_enumerate_cmds(&cxlswd->mbox);

Making the whole mbox more generically available makes me wonder if
we want to start using Get Supported Logs Sub-List instead of the current
gsl? The spec is pretty explicit about this:

""
It is strongly recommended that the Get Supported Logs Sub-List (see
Section 8.2.9.5.6) is supported by Components and used by software instead of Get
Supported Logs so that requestors may control the output payload size, as needed.
Type 3 Devices that implement support for the Get Supported Logs opcode on an
MCTP-based CCI shall also support the Get Supported Logs Sub-List opcode.
""

Thanks,
Davidlohr

>+	if (rc)
>+		goto error_put_device;
>+
>+	rc = cdev_device_add(&cxlswd->cdev, &cxlswd->dev);
>+	if (rc)
>+		goto error_put_device;
>+
>+	return 0;
>+
>+error_put_device:
>+	cxl_swdev_shutdown(cxlswd);
>+	put_device(&cxlswd->dev);
>+	return rc;
>+}
