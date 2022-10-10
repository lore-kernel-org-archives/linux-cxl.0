Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223F2C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 17:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJJRmY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJJRmX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 13:42:23 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C701E754B5
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 10:42:22 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7C75D8C0A61;
        Mon, 10 Oct 2022 17:33:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D8B738C10D6;
        Mon, 10 Oct 2022 17:33:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665423195; a=rsa-sha256;
        cv=none;
        b=w0wi6j0eORnOJHf1IWf1hMlU5dVqudzFgSQvxaPyXeG+9K5GApMG4iP2MGIGhpenANAfkI
        moiHFaq7x6dM/U2uoVBduacKgGzrbkhZGEpnVusHXNHt+H2O+v7b1TMHNXotA9/mH2ifXV
        c6TCwic7wnqjhRhgFY7zv317oLclxnfNtt1jTLAASHFjS7HUswqLlY7GkGMekyj7wmGUQX
        OnF4I5iqbmjlebFxocT/LrQlqjTZ+PTlVve4wFq7h58XGqtBBMK1agILN1erryd57CY3Gh
        gL1Cc80SYfRwXXhKOtLUFeqawNWdFLTxQxtk2mGiP4+tGL4wIGi91nzyAtMu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665423195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=t8viUkUj1KrzJ1YJZvAeDehpOIrGVSGFA7zYGt76I9Q=;
        b=9Fs2WpQtb3TsjH6i/f11sb3jzbBWOagaLLfJaQ7XszbyzFLfWoW5tN+qBxoaUXWEHsH+Eh
        xsBwuI0zQym85NuLmXgdR2RZkrgnsUh+d7U8AtOplvuRCmYD/877Ml4oDRz8z05eaaTw+2
        F/m2HtspjDioEpjScU1DnJUcDMnIkwSe4/3TlyX19lNANGc/eUn9RQR1H6kpqoxqMW5on8
        vy9YnVXR6u/7kSxpdXk3rBKiHQtPOF6+9tHETSL6PCmuKPeH75E7lVOnutRBQjneonPcOn
        w/ZNFPcS99F0hrQYVxylczTxAvn00LRUF3srDSgDMa2au/ht44FNmP/2mG1ETg==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-2c8rr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Shelf: 0be60b285bb54b9c_1665423195255_3442516789
X-MC-Loop-Signature: 1665423195255:1269252574
X-MC-Ingress-Time: 1665423195255
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.129.213 (trex/6.7.1);
        Mon, 10 Oct 2022 17:33:15 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4MmQx56QHgz5j;
        Mon, 10 Oct 2022 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665423194;
        bh=t8viUkUj1KrzJ1YJZvAeDehpOIrGVSGFA7zYGt76I9Q=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=F1W3/KaAWDkTzbwNavZ7py1P6drF/pMH8BOs7TSSJR8dKtl2MCNI/DKz1uDGf8mI0
         iFIlntRGIBaW+9zPNiLxUzDI2s3hrPbqeBpfVel2wlzeFDNWVCV4lxwYVI/+lfbMVw
         1b+0JWHT4OuLgJJ/FNuilEPuEGAqaXUlpyM5XFn+aF68y4vvvxgULDWIxaD4bFV6Ot
         O3DU3OVUzvMyzqqwOcE9ClNYu79Ts+TIR7ONHQCxrCoeAjXY5l8C8jUslpR3nIW83g
         2c1bdeAUMy04d02EpaqJR78NZnyHhYxfC478TUOpSOjELOig4DQ5C9wYiaVWv26yRO
         BleJSf+ZaUr7Q==
Date:   Mon, 10 Oct 2022 10:12:29 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 2/2] hw/cxl: Allow CXL type-3 devices to be persistent or
 volatile
Message-ID: <20221010171229.let7egonsflyjixh@offworld>
References: <20221006233702.18532-1-gregory.price@memverge.com>
 <20221006233702.18532-2-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221006233702.18532-2-gregory.price@memverge.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 06 Oct 2022, Gregory Price wrote:

>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index bc1bb18844..dfec11a1b5 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -138,7 +138,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
>     } QEMU_PACKED *fw_info;
>     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
>
>-    if (cxl_dstate->pmem_size < (256 << 20)) {
>+    if (cxl_dstate->mem_size < (256 << 20)) {

Nit but we probably want to abstract this out (in a pre-patch), just like in the
kernel side. Ie:

#define CXL_CAPACITY_MULTIPLIER   0x10000000 /* SZ_256M */

>         return CXL_MBOX_INTERNAL_ERROR;
>     }
>
>@@ -281,9 +281,10 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
>
>     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>-    uint64_t size = cxl_dstate->pmem_size;
>
>-    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
>+    if ((!QEMU_IS_ALIGNED(cxl_dstate->mem_size, 256 << 20)) ||

is the full mem_size check here really needed?

>+        (!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, 256 << 20)) ||
>+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, 256 << 20))) {
>         return CXL_MBOX_INTERNAL_ERROR;
>     }
>
>@@ -293,8 +294,9 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
>     /* PMEM only */

This comment wants removed.

>     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
>
>-    id->total_capacity = size / (256 << 20);
>-    id->persistent_capacity = size / (256 << 20);
>+    id->total_capacity = cxl_dstate->mem_size / (256 << 20);
>+    id->persistent_capacity = cxl_dstate->pmem_size / (256 << 20);
>+    id->volatile_capacity = cxl_dstate->vmem_size / (256 << 20);
>     id->lsa_size = cvc->get_lsa_size(ct3d);
>
>     *len = sizeof(*id);
>@@ -312,16 +314,16 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
>         uint64_t next_pmem;
>     } QEMU_PACKED *part_info = (void *)cmd->payload;
>     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
>-    uint64_t size = cxl_dstate->pmem_size;
>
>-    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
>+    if ((!QEMU_IS_ALIGNED(cxl_dstate->mem_size, 256 << 20)) ||
>+        (!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, 256 << 20)) ||
>+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, 256 << 20))) {
>         return CXL_MBOX_INTERNAL_ERROR;
>     }
>
>-    /* PMEM only */
>-    part_info->active_vmem = 0;
>+    part_info->active_vmem = cxl_dstate->vmem_size / (256 << 20);
>     part_info->next_vmem = 0;
>-    part_info->active_pmem = size / (256 << 20);
>+    part_info->active_pmem = cxl_dstate->pmem_size / (256 << 20);
>     part_info->next_pmem = 0;
>
>     *len = sizeof(*part_info);
>diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
>index 1837c1c83a..998461dac1 100644
>--- a/hw/mem/cxl_type3.c
>+++ b/hw/mem/cxl_type3.c
>@@ -100,18 +100,47 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>     DeviceState *ds = DEVICE(ct3d);
>     MemoryRegion *mr;
>     char *name;
>+    bool is_pmem = false;
>
>-    if (!ct3d->hostmem) {
>-        error_setg(errp, "memdev property must be set");
>+    /*
>+     * FIXME: For now we only allow a single host memory region.
>+     * Handle the deprecated memdev property usage cases
>+     */
>+    if (!ct3d->hostmem && !ct3d->host_vmem && !ct3d->host_pmem) {
>+        error_setg(errp, "at least one memdev property must be set");
>         return false;
>+    } else if (ct3d->hostmem && (ct3d->host_vmem || ct3d->host_pmem)) {
>+        error_setg(errp, "deprecated [memdev] cannot be used with new "
>+                         "persistent and volatile memdev properties");
>+        return false;
>+    } else if (ct3d->hostmem) {
>+        warn_report("memdev is deprecated and defaults to pmem. "
>+                    "Use (persistent|volatile)-memdev instead.");
>+        is_pmem = true;
>+    } else {
>+        if (ct3d->host_vmem && ct3d->host_pmem) {
>+            error_setg(errp, "Multiple memory devices not supported yet");
>+            return false;
>+        }
>+        is_pmem = !!ct3d->host_pmem;
>+        ct3d->hostmem = ct3d->host_pmem ? ct3d->host_pmem : ct3d->host_vmem;

This hides requirement details as to the necessary changes that are needed for
volatile support - for example, build_dvsecs(). Imo using two backends (without
breaking current configs, of course) should be the initial version, not something
to leave pending.

Thanks,
Davidlohr
