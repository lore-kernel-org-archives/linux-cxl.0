Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F928C433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Oct 2022 17:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJGRhW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJGRhV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Oct 2022 13:37:21 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5424C61C
        for <linux-cxl@vger.kernel.org>; Fri,  7 Oct 2022 10:37:20 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3AE4140F11;
        Fri,  7 Oct 2022 17:37:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a245 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B5C8940C06;
        Fri,  7 Oct 2022 17:37:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665164234; a=rsa-sha256;
        cv=none;
        b=FHtu83oSdXCDZDD4Z2wvp03vCOKi9d4x3wRsCeVR8CR7gC3+hSfCLtnhfCQn5P0Kd6kQdc
        zVO64xj6T35MVBkHEKOsSLW0xda3CmdaCEqBpb6STT/8MfvHHk3sFqNjjdrZ1/AqGBJ+TR
        D4v+YF8iG+BS+XU2dCJooOeMgdoxHEOQIuWt5DT9LKRA4W/eoD1uToiIhveFqk628bEUgn
        mnNk/71K2W3tMRYc0gk2xxpYf/kXR4hEsjNJ4clcawdiYuvYlwIGPo/dFSOKYAxpYx5Xiu
        /DSmsnX3Zh0aEnWvC3xfgm3oErsylEwLOHTQ+HYb2t54i/Ln50ZsVnyw634Zcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665164234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=x+MECLbchDnnXtnWCT/h9QTt+h/pBUOWL9FPfzdzFzs=;
        b=oayIjTs38F5nGvmtankPdR3hJ+1VNAEelBmYOHQX5rs15NnypfZ3aK2ShtnkKTB0eLIDKM
        Csfx81IoH+JUn1/gsKhELKvjKAwq+3KP24V2KED/l5nq1CY/aEK81IhX2082RZBQca3D13
        ArQix25tcsa+svEU2gqlFfZw3QYdo/ZgsTF23cD30Uv9O7hQsTVRwfg/FdGoo0uoinC6Lc
        VM7AJLs1Ra0IWQ9lJVHig5QbB7hwzCh+7/rbXNwGyBFIusN6mJKsMOqA84TVIolfOA9skv
        gqV/3nKG9kN+ToDcPbXKGMGiJTUOaNxbvGXBRDhOWsBTcURL6nmxYbmLG1uMmQ==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-pkd76;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Blushing: 0555657c0b976e19_1665164235026_2779162955
X-MC-Loop-Signature: 1665164235025:1003967718
X-MC-Ingress-Time: 1665164235025
Received: from pdx1-sub0-mail-a245 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.234.207 (trex/6.7.1);
        Fri, 07 Oct 2022 17:37:15 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245 (Postfix) with ESMTPSA id 4Mkb955hL0z1G;
        Fri,  7 Oct 2022 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665164234;
        bh=x+MECLbchDnnXtnWCT/h9QTt+h/pBUOWL9FPfzdzFzs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HBN4ZlSIUleyAJ+U9vHrdPMYyuPbrdamCzm4U1H+2+yAd6l5uiKOsQ1HqjUyQ18O1
         bjolOCabxqgSPFZSWU6VbiDrFTBfS1Gz0KtxQfAD/PbrBxBZOP4ZRrAMTX/K6N3gyg
         kE6i34ahm82PzHW0IPBZxZll9P0mtqo0OEFDdvrLL3uhcI0EwaSClf7aXdkhd2lNfW
         LLShv8b751IujdXFl3NRyRSlkNoNOGcjHqb/z75HxwmFsqGlr+qoKqqpXzYKVBayEa
         Z/2CZXfjKBQWYbqeGA4Xv3pkju7O8hw1R37Ujfue3WTXX7Rib0LquUkAPLdyT5Mb7x
         J0pdsSOZ7gzbQ==
Date:   Fri, 7 Oct 2022 10:16:39 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 1/2] hw/cxl: set cxl-type3 device type to
 PCI_CLASS_MEMORY_CXL
Message-ID: <20221007171639.ermnneauop2m6zau@offworld>
References: <20221006233702.18532-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221006233702.18532-1-gregory.price@memverge.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 06 Oct 2022, Gregory Price wrote:

>Current code sets to STORAGE_EXPRESS and then overrides it.

Good catch.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Signed-off-by: Gregory Price <gregory.price@memverge.com>
>---
> hw/mem/cxl_type3.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
>index ada2108fac..1837c1c83a 100644
>--- a/hw/mem/cxl_type3.c
>+++ b/hw/mem/cxl_type3.c
>@@ -146,7 +146,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>     }
>
>     pci_config_set_prog_interface(pci_conf, 0x10);
>-    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
>
>     pcie_endpoint_cap_init(pci_dev, 0x80);
>     cxl_cstate->dvsec_offset = 0x100;
>@@ -335,7 +334,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>
>     pc->realize = ct3_realize;
>     pc->exit = ct3_exit;
>-    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
>+    pc->class_id = PCI_CLASS_MEMORY_CXL;
>     pc->vendor_id = PCI_VENDOR_ID_INTEL;
>     pc->device_id = 0xd93; /* LVF for now */
>     pc->revision = 1;
>-- 
>2.37.3
>
