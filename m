Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBDEC43334
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Jun 2022 01:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbiFHBLT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587616AbiFGXx2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Jun 2022 19:53:28 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE7281847
        for <linux-cxl@vger.kernel.org>; Tue,  7 Jun 2022 15:37:09 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1ED2C5A2004;
        Tue,  7 Jun 2022 22:37:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 16EE25A1AF5;
        Tue,  7 Jun 2022 22:37:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654641427; a=rsa-sha256;
        cv=none;
        b=lONLYd0StgE/iYJ5pnG9Ab+j9R0q+m5rsUHrBIh/IfrpXGdt9mkTgOOEVElvlEEmtfR43+
        18c/iO9ZZjetzqzsSK+ZmEDvxokGDfCbjxthcSaLiPhBHmrmj4oySP0BXR8NSCO3avvN1G
        jUnvjV1wsEKXMRqw+ii7qa7XtrEFT9pfHNg4gX1+NdXqJcIVn895dClJRLvuiM6KNXym9I
        /8kaOANUPQbjsr3maeMs15aWQ6ke/K8QDyfGPts3IBnbk8radJQpCPZd3y+gCvbA2D88qX
        GhvqjNUdlwhxLxO/+h18NkrXtLTuh6LS/UkB5CP9bHTBH7cUTxT4TEBp/dZ+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654641427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LXR2eEloRFAvntPDQLNHttzah9bZfuod1gXWFD1jMgw=;
        b=sZlMCeAyxFUGnnoNX+VQptKZ0HcAmnbCsV/fME+Esj8+gQfsDDwA0s2Wiy756kjbpLJ/cd
        Gfaz9lLuJlBIffXGYP08htDItn3RBPnxCjOmYAegwZ8wgraSZ1oOLvFwfwrqMxMx7+6kh/
        uu873Jk9oar3Uyie2kUwWDFq98O+2dteBrlC1csPnurcoSVpZuWoaBnFU7ubltPG25V0nQ
        5MOl51NyVLnlXbHwX4Qdql4n0j3g4XiueQ+hQnmMuIhyrhtxiTjboanS9H0lgGO3GStX5p
        LqCXCJAwpdHQohmr2XpW67q75DV6LVRV4qMuIJx10NDzst5LnOBbGiexipB9UQ==
ARC-Authentication-Results: i=1;
        rspamd-848669fb87-2fbzt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Occur-Eight: 1715e8b966d04826_1654641427843_1511666637
X-MC-Loop-Signature: 1654641427843:3666851013
X-MC-Ingress-Time: 1654641427843
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.98 (trex/6.7.1);
        Tue, 07 Jun 2022 22:37:07 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LHlbP5cL8zLK;
        Tue,  7 Jun 2022 15:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654641426;
        bh=LXR2eEloRFAvntPDQLNHttzah9bZfuod1gXWFD1jMgw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TMsV061F/hj4rCCqiTe8NsjhLaQjArSDWmeLA7nuSheOkRFexWWEN0mGo4hZfSsMU
         8YE5ufEAvEv8saPMzb8AqH1hdD3ZD9gCYo0JKJmxbSNj8Yx4JsrDF62XvDeLGhqnJH
         69CLKAVaEqS97PFV1o2Jj3U+oVMIa3kMLFCy5U2RqDieRU+FQgatMYIXGjLWsvcDg9
         YBU7mMZMtBCwe2oFWz5lfVHbc/HUzFi1gFQL68S60spqZxr9lQbq3pf6nDypnNVGit
         N9kurT64Ko5sc1HiuQPrpnjdRx09bsIsgZR/+HjFt4goNs5z/nUxSzfP3mAwqKjbqC
         J0ODhaUWo4LIg==
Date:   Tue, 7 Jun 2022 15:37:02 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        "Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, alex.bennee@linaro.org,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 1/8] hw/cxl: Make the CXL fixed memory window setup a
 machine parameter.
Message-ID: <20220607223702.lpq34pq6wqnvr7ej@offworld>
References: <20220601164235.2117-1-Jonathan.Cameron@huawei.com>
 <20220601164235.2117-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220601164235.2117-2-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 01 Jun 2022, Jonathan Cameron wrote:

>Paolo Bonzini requested this change to simplify the ongoing
>effort to allow machine setup entirely via RPC.
>
>Includes shortening the command line form cxl-fixed-memory-window
>to cxl-fmw as the command lines are extremely long even with this
>change.
>
>The json change is needed to ensure that there is
>a CXLFixedMemoryWindowOptionsList even though the actual
>element in the json is never used. Similar to existing
>SgxEpcProperties.
>
>Update cxl-test and bios-tables-test to reflect new parameters.
>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

One thing missing however is updating qemu-options.hx - maybe fold
in the below?

Thanks!

----8<-------

diff --git a/qemu-options.hx b/qemu-options.hx
index 60cf188da429..3bcf1247b88a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -127,10 +127,43 @@ SRST
  ERST
  
  DEF("M", HAS_ARG, QEMU_OPTION_M,
+    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
      "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n",
      QEMU_ARCH_ALL)
  
  SRST
+``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
+    Define a CXL Fixed Memory Window (CFMW).
+
+    Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
+
+    They are regions of Host Physical Addresses (HPA) on a system which
+    may be interleaved across one or more CXL host bridges.  The system
+    software will assign particular devices into these windows and
+    configure the downstream Host-managed Device Memory (HDM) decoders
+    in root ports, switch ports and devices appropriately to meet the
+    interleave requirements before enabling the memory devices.
+
+    ``targets.X=firsttarget`` provides the mapping to CXL host bridges
+    which may be identified by the id provied in the -device entry.
+    Multiple entries are needed to specify all the targets when
+    the fixed memory window represents interleaved memory. X is the
+    target index from 0.
+
+    ``size=size`` sets the size of the CFMW. This must be a multiple of
+    256MiB. The region will be aligned to 256MiB but the location is
+    platform and configuration dependent.
+
+    ``interleave-granularity=granularity`` sets the granularity of
+    interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
+    4096KiB, 8192KiB and 16384KiB granularities supported.
+
+    Example:
+
+    ::
+
+	-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512k
+
  ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
      Define an SGX EPC section.
  ERST
@@ -467,44 +500,6 @@ SRST
          -numa hmat-cache,node-id=1,size=10K,level=1,associativity=direct,policy=write-back,line=8
  ERST
  
-DEF("cxl-fixed-memory-window", HAS_ARG, QEMU_OPTION_cxl_fixed_memory_window,
-    "-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]\n",
-    QEMU_ARCH_ALL)
-SRST
-``-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]``
-    Define a CXL Fixed Memory Window (CFMW).
-
-    Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
-
-    They are regions of Host Physical Addresses (HPA) on a system which
-    may be interleaved across one or more CXL host bridges.  The system
-    software will assign particular devices into these windows and
-    configure the downstream Host-managed Device Memory (HDM) decoders
-    in root ports, switch ports and devices appropriately to meet the
-    interleave requirements before enabling the memory devices.
-
-    ``targets.X=firsttarget`` provides the mapping to CXL host bridges
-    which may be identified by the id provied in the -device entry.
-    Multiple entries are needed to specify all the targets when
-    the fixed memory window represents interleaved memory. X is the
-    target index from 0.
-
-    ``size=size`` sets the size of the CFMW. This must be a multiple of
-    256MiB. The region will be aligned to 256MiB but the location is
-    platform and configuration dependent.
-
-    ``interleave-granularity=granularity`` sets the granularity of
-    interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
-    4096KiB, 8192KiB and 16384KiB granularities supported.
-
-    Example:
-
-    ::
-
-        -cxl-fixed-memory-window targets.0=cxl.0,targets.1=cxl.1,size=128G,interleave-granularity=512k
-
-ERST
-
  DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
      "-add-fd fd=fd,set=set[,opaque=opaque]\n"
      "                Add 'fd' to fd 'set'\n", QEMU_ARCH_ALL)
