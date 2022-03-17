Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC09C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 00:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346042AbiCQAtz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Mar 2022 20:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbiCQAty (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Mar 2022 20:49:54 -0400
X-Greylist: delayed 82063 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Mar 2022 17:48:39 PDT
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7911A802
        for <linux-cxl@vger.kernel.org>; Wed, 16 Mar 2022 17:48:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 05B26801186;
        Thu, 17 Mar 2022 00:48:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 87867800D17;
        Thu, 17 Mar 2022 00:48:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647478118; a=rsa-sha256;
        cv=none;
        b=EHhjvWt00lp2w1uInSGofW2JB7a1ZFjGwmOnxmuugfMg1O4+spyHoTZ3KLYPzZCJ/gbizX
        CqvhUp6WjnYkB0+zr6SCAZPqx18Vjn/tONQxD+80bwFZxDd8m9l3yLzjYHpVcxgY2Fh+rD
        Wnj/HmG8IVSZNZE8NzD2sT27DFo2/E4b/YY+zYJ0DD7VRZmkSU6xI2HfCtAVe17IJ9GqEn
        xB0iMdeuOIArU4XSD/8J154pAtR108J/4EJLzfaA9wWR0GsS0cgyOknucmV861T6axFqCi
        gZDIoWV4QBrI8JZsQj/ukOEIFHJCbakHR/hCn/PTvji4ghKUigAhik5RrI7yOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647478118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=HJpz2VufQRZLPnd4lzQfR5wsVagRZgd5zwLwD0t1/Mo=;
        b=qJBv4NAPVqIqrbseapcXdIcKt/nYG4hLOUaOFio8sZQS/54YRpq0Lc5vG7XmS/+sPj5DcE
        QFustFPPHuv3bRMpJipbJTpZCATaebKxmIJ8rIlG+08InFFUZjSiR3IZrD61w8W1YieydG
        kGGvEqGSuA5yXau/F4UZE284vow3Z7NKjfMvTKBdVDczlDD1OEha0RoVkW4IHilIlOBjoO
        3/Nxwj0fRaSYp4pCm9NkOdtljodv07fqecBy6073tt8mgIM47hmcjIUbxEt0PBY8uhN8ND
        9H15YE9HI3btiO0/j9aNMTxdwAcbnPsiWEuGXrYbnEU1TDyDrVuwIwoLuzDwwQ==
ARC-Authentication-Results: i=1;
        rspamd-74bfb75fc6-g2xgm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.157 (trex/6.5.3);
        Thu, 17 Mar 2022 00:48:38 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Exultant: 54a6a3f13c18d00c_1647478118851_2357152912
X-MC-Loop-Signature: 1647478118851:989818459
X-MC-Ingress-Time: 1647478118851
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4KJpRT6VLcznb;
        Wed, 16 Mar 2022 17:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647478118;
        bh=HJpz2VufQRZLPnd4lzQfR5wsVagRZgd5zwLwD0t1/Mo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Ymdfdw5z11TlpZrYxUksbvauWxux+S6EUuXZpQC/kKUfbXjfcBz2E9CNFOXI9y2rg
         b6Ij1A/nt0ysEGYADKCJjVFrIbC+7QHwKlhderUDjjUIxO4f1nEJ/g3aosvh/AJACU
         nwsWbP0osby823xH3Vb751hHkAMLve66TkQGAZY2jr7Zh8UOVzdvqAJCSGwWEyD9l5
         +UYKEJTxzOTn9ltgDv5SUMrhnC+1wuBjHJ7oVyr+cMdu42uHvK7PAUv1C13jZsEyX3
         iYB4O3QI63nih4VbDNvnSShTFrc8qkzTX2pKkpc/5ZsVO456d4Y8hZ2hEP+vPuJiWS
         M30ynQWBw/i5w==
Date:   Wed, 16 Mar 2022 17:39:29 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Krzysztof Zach <krzysztof.zach@intel.com>,
        ben.widawsky@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Subject: Re: [PATCH v2 0/6] cxl: Handle DVSEC range init failures
Message-ID: <20220317003929.de4yw7yrjxhz4cza@offworld>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Mar 2022, Dan Williams wrote:

>Dan Williams (6):
>      cxl/mem: Drop DVSEC vs EFI Memory Map sanity check
>      cxl/pci: Add debug for DVSEC range init failures
>      cxl/mem: Make cxl_dvsec_range() init failure fatal
>      cxl/pci: Make cxl_dvsec_ranges() failure not fatal to cxl_pci
>      cxl/mem: Rename cxl_dvsec_decode_init() to cxl_hdm_decode_init()
>      cxl/mem: Replace redundant debug message with a comment

I have gone through the remaining patches and they look good to me.
Feel free to add my:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>
> drivers/cxl/mem.c            |   52 +++++++++++++++---------------------------
> drivers/cxl/pci.c            |   40 +++++++++++++++++++++++---------
> tools/testing/cxl/mock_mem.c |    2 +-
> 3 files changed, 48 insertions(+), 46 deletions(-)
>
>base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4
