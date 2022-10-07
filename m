Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F09C433FE
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Oct 2022 20:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJGUNd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Oct 2022 16:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJGUNa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Oct 2022 16:13:30 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF49259F
        for <linux-cxl@vger.kernel.org>; Fri,  7 Oct 2022 13:13:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EB710260988;
        Fri,  7 Oct 2022 20:13:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a282 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id ED93426116C;
        Fri,  7 Oct 2022 20:13:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665173605; a=rsa-sha256;
        cv=none;
        b=XN3v2on9PoFSdZPQKOtGyzrtKz7aVAZUlmGsLOH7t0VebHa5ga/vDh7BX7oI3D1KylC+Q+
        9lFZ0YFmjWoMlKBHa39j/uMfGzMxpoOKgnW9WRXBRNrmR02uTRetaK0NX16mKjpXUBr/9I
        IjJdN9EANDGA0kljR3XC2gHieBI3I6Hwin+Jmj4WYyFAg/lhG6nay3ljBwtBhc1GYfrTPD
        FPCPbYqXtngXCXVm5lpXc1ZUZ50eSPfRVNBbQdmhxrnPeTIF6coFn0jhXR0/2GxF1u0N80
        Wa92aEl8Cun8pegSvZMG066TI6OHR+2olsIaoUxy0irqm+D3VxIG+1oLQNcdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665173605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=NAm1LUEGY44NNwjL2IJ/5MomV8aO8u78kjmZAIx7voU=;
        b=zPWPhJhzO+eI4WDB0uY9od8/UDNVxR6qFUNjoRge7dWnRYqxYq3072PgZsl/LYwIn0CcGe
        4qHMa3CsMnnFUgLrZmPTf+t7q9Xpp3fj9rXMMl+/Up1xW8XcoIibywUtOfxW6pj52GnRGj
        OKotVxr8biA0e17cTj6TXafZ1zqNO9doa40yH6AMqC8bom/Cy6qObPIw3jqs31pKItyi2d
        1DVm5JGi3stQAg9CTECXoIJ4VBKEBY1Sfam/ZLqb8jrwfAOH3WsptvuS0AcYAAYQ+6Y44l
        IwegDtey0nrZeXaeBkjAdx4zXhQcxwWTSw2CBafLq+THhNDVXXWV0GJj2vs6Zg==
ARC-Authentication-Results: i=1;
        rspamd-755f899884-2b47f;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bitter-Illegal: 25145ad5026fc4f2_1665173605286_648685402
X-MC-Loop-Signature: 1665173605286:3480309679
X-MC-Ingress-Time: 1665173605285
Received: from pdx1-sub0-mail-a282 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.246.134 (trex/6.7.1);
        Fri, 07 Oct 2022 20:13:25 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a282 (Postfix) with ESMTPSA id 4MkfdH6N0jz2Z;
        Fri,  7 Oct 2022 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665173604;
        bh=NAm1LUEGY44NNwjL2IJ/5MomV8aO8u78kjmZAIx7voU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hDJLtBvGgzAURSGTDeqeZUTHxKLK82jACUyxYz4ZwX4JKHko2poWa+HYRPoKnShqL
         +TWYFNBUFtp9lwvmG25trmodSlWQOCNcAtRNJ7fJPDZ/64/IcLcT+kUH8n579L25gs
         GCX9NSR7JTvKClvz5MFEkF5ErM3ZFxuxLXmWUF3iJRrc5K4aOhTWB09oVKS+cO01q5
         +ugTTOZCvxsAwna9DUzJ2fGIp5TRYsoAyMgz7HENU+rKHatLphclVV0kCsl+11WVCw
         h3iQPBON5BKfpiS6T2mYGQyc+RrnncXlyH2foOEvqhPfXRZ2XxkZzWFebjlSoenmTq
         ntDn/dk2LL8Qg==
Date:   Fri, 7 Oct 2022 12:52:48 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gourry <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        Gourry <gregory.price@memverge.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <20221007195248.2i7a44fuujpbfdof@offworld>
References: <20221006000103.49542-1-gregory.price@memverge.com>
 <20221006094557.000035ab@huawei.com>
 <20221006095007.00001271@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221006095007.00001271@huawei.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 06 Oct 2022, Jonathan Cameron wrote:

>One of the blockers for volatile support was that we had no means to poke
>it properly as the kernel doesn't yet support volatile capacity and
>no one has done the relevant work in EDK2 or similar to do it before the kernel boots.
>There has been some work on EDK2 support for ARM N2 FVPs from
>Saanta Pattanayak, but not upstream eyt.
>https://lpc.events/event/16/contributions/1254/

fwiw I had been trying to build some of the firmware bootup for the required
acpi tables that are particular to volatile capacity steps (srat/slit, hmat and
EFI Memory Map) by parameters, but got quickly out of hand. For example, the srat
could use a passed 'node' and have a cxl_build_srat(), etc. But yeah it would
be nice for the EDK2 work to advance on the x86 end.

Thanks,
Davidlohr

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 2bf8c0799359..1c3c6d17c222 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -254,3 +255,46 @@ void build_cxl_osc_method(Aml *dev)
+static int cxl_device_list(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        *list = g_slist_append(*list, DEVICE(obj));
+    }
+
+    object_child_foreach(obj, cxl_device_list, opaque);
+    return 0;
+}
+
+static GSList *cxl_get_device_list(void)
+{
+    GSList *list = NULL;
+
+    object_child_foreach(qdev_get_machine(), cxl_device_list, &list);
+    return list;
+}
+
+void cxl_build_srat(GArray *table_data)
+{
+    GSList *device_list, *list = cxl_get_device_list();
+
+    for (device_list = list; device_list; device_list = device_list->next) {
+        DeviceState *dev = device_list->data;
+        Object *obj = OBJECT(dev);
+        CXLType3Dev *ct3d = CXL_TYPE3(dev);
+        MemoryRegion *mr;
+        int node;
+
+        mr = host_memory_backend_get_memory(ct3d->hostmem);
+        if (!mr) {
+            continue;
+        }
+        node = object_property_get_uint(obj, "node", &error_abort);
+
+        build_srat_memory(table_data, mr->addr, mr->size, node, MEM_AFFINITY_ENABLED);
+    }
+
+    g_slist_free(list);
+}
