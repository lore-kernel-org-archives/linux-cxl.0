Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09163C77B75
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 21:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjEEVQh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 17:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjEEVQf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 17:16:35 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBED525D
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 14:16:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9AB0E7621CC;
        Fri,  5 May 2023 21:16:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 176B27615ED;
        Fri,  5 May 2023 21:16:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683321393; a=rsa-sha256;
        cv=none;
        b=RP0FJYQr1XdPUbyjAk+hsoB+ymu0qYxCT5/2hICLVfJJGPgKGhSQd0+ma3dNTLKdsPQh1M
        1QV9QeR0ZB2ekjXssWZFZh0lnPgXPbnt52acFg65Qt9XtU3v/quMTJ1irzuL1zmaHrbzIO
        Fg0JtIiypR4w0NOaosYQYN+lNEt+jsLvzK2toec4RZT8jgVtiK4xjtJyIng15jLP1DvBT8
        0JhMoTMe6pVDHyFAuoAa/Yv5KF9rDPk87HCVOXmXpHeGQqqbTlA9Ykosoff4Zfk9eYcxq/
        KjiYEPzPvi//C8qEt2C80pcY26fz+CMvE8wpKLVD9y6soFQ9G8XJjaXFwzvCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683321393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=QAyswKkufEgDuCnQsqfN7QmCgehJM+vCzdu3g3j8DrY=;
        b=6H+ihnMFH1J37VaSqch8agRmqUj/4wCmLA1fNqtn3WVsNsFytSD7ivvhND9xF4F2OeqVep
        YRCcbcaF9JNLg5TjHbmga5TM5duqi1u9kigawwRQSFX7JwjdF9SZ2wz5WAXu0sI6CUFG8Y
        TdZi33JYhNmLoJ5+Z4fLNdgXgPp5XGQMa+YZk9t7bto08nuYZhtw+ZBpHA7hlG7ojEwVEX
        5b/HdMkRB57fb3FysgL79nl+se6h4OSZLEcpQJnJ477ztCFT7kPQ5FVAWboC//cMO78Ng0
        Gkj6XjM9VAAl8vpwtbMoJiaFUiXYRxFcNCGGiFJKS1kyi7TGdQJrFJa+l9rM5Q==
ARC-Authentication-Results: i=1;
        rspamd-6c5fbf566c-gcgjp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shade-Print: 5a84ce2e5a297dd2_1683321393419_1661744434
X-MC-Loop-Signature: 1683321393419:1211170747
X-MC-Ingress-Time: 1683321393419
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.49 (trex/6.7.2);
        Fri, 05 May 2023 21:16:33 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4QCk5D38PRz3K;
        Fri,  5 May 2023 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683321392;
        bh=tzASbyR0hLlGI2gjkBTGlW8CfTgtN6YWZpI9cP3n+fo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=KXFAcjwpneTlGrLaDNirPXPoLpMVsEDyzhpTwbZ923/iOSbO0lNjfDjoGRW6ro7Op
         lmkXUGESdCmoi6Qu0JlM+IXq7j9B+XNeNXZZbXlueWABr1332NtbSpc6K67ITBhNOp
         2t/d1NG+11r8j52+2FbOt/9Puv/vMfP5zyWWnVPd62RBnFju11uXikvcUIdtc9KP2O
         JE6SrtduZOReJFABQJy9x2IfrSpkeOpi+XANuzsi5BTwhYmY7U2TPIHU680Czucra5
         VQFpB+/hjEZRXvPK0j5POW2q+AKJZ/f1jGSTDNdjelNyIQq6XRvtjWlhL3y1lTBL1M
         zrWWmzh1ZI38w==
Date:   Fri, 5 May 2023 13:44:07 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH 3/3] cxl: Add support for reading CXL switch CDAT table
Message-ID: <z2lvbqzll5m2uqi3mtqgn2ci5dm3gmfmbiwvuzwds3kh3v6227@v7ygvbqzmhz2>
References: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
 <168330453501.1986478.10682875024496375027.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <168330453501.1986478.10682875024496375027.stgit@djiang5-mobl3>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 05 May 2023, Dave Jiang wrote:

>Add read_cdat_data() call in cxl_switch_port_probe() to allow
>reading of CDAT data for CXL switches. read_cdat_data() needs
>to be adjusted for the retrieving of the PCIe device depending
>on if the passed in port is endpoint or switch.
>
>Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Some style comments, otherwise feel free to add my:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>---
>v5:
>- Rebase after fix [1]. (Dan)
>
>[1]: http://lore.kernel.org/r/168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com
>v4:
>- Remove cxl_test wrapper. (Ira)
>---
> drivers/cxl/core/pci.c |   21 ++++++++++++++++-----
> drivers/cxl/port.c     |    3 +++
> 2 files changed, 19 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>index 046e55a9b419..9fabfe458499 100644
>--- a/drivers/cxl/core/pci.c
>+++ b/drivers/cxl/core/pci.c
>@@ -546,18 +546,29 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>  */
> void read_cdat_data(struct cxl_port *port)
> {
>-	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
>-	struct device *host = cxlmd->dev.parent;
>+	struct device *uport = port->uport;
>	struct device *dev = &port->dev;
>	struct pci_doe_mb *cdat_doe;
>+	struct cxl_memdev *cxlmd;
>+	struct pci_dev *pdev;

maybe instead set pdev to nil, then check...

>+	struct device *host;
>	size_t cdat_length;
>	void *cdat_table;
>	int rc;
>
>-	if (!dev_is_pci(host))
>+	if (is_cxl_memdev(uport)) {
>+		cxlmd = to_cxl_memdev(uport);
>+		host = cxlmd->dev.parent;
>+		if (!dev_is_pci(host))
>+			return;
>+		pdev = to_pci_dev(host);
>+	} else if (dev_is_pci(uport)) {
>+		pdev = to_pci_dev(uport);
>+	} else {
>		return;

... here

	if (!pdev)
	   return;

Thanks,
Davidlohr

>-	cdat_doe = pci_find_doe_mailbox(to_pci_dev(host),
>-					PCI_DVSEC_VENDOR_ID_CXL,
>+	}
>+
>+	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>					CXL_DOE_PROTOCOL_TABLE_ACCESS);
>	if (!cdat_doe) {
>		dev_dbg(dev, "No CDAT mailbox\n");
>diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>index 22a7ab2bae7c..a49f5eb149f1 100644
>--- a/drivers/cxl/port.c
>+++ b/drivers/cxl/port.c
>@@ -62,6 +62,9 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>	struct cxl_hdm *cxlhdm;
>	int rc;
>
>+	/* Cache the data early to ensure is_visible() works */
>+	read_cdat_data(port);
>+
>	rc = devm_cxl_port_enumerate_dports(port);
>	if (rc < 0)
>		return rc;
>
>
