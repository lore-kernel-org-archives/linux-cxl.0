Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F06EECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Oct 2022 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJaRri (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJaRrh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 13:47:37 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97C81021
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 10:47:35 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CF8BB42520;
        Mon, 31 Oct 2022 17:47:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a225 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 30EA34250B;
        Mon, 31 Oct 2022 17:47:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1667238451; a=rsa-sha256;
        cv=none;
        b=zcZ7NRCl4slPD0UawGeJ160DVXOC5t5lPgQ22siFk3OfNZMGh0wUigYAc3S3ULCdRh9MaI
        0pa4nk++WGDCaJV7n9U3AWlDi5FoqCeKjjg0zC83xozZIIJsJRsqqK1wMCyrSdGGiVjWrZ
        C1uQVSqEDPgIqh9OxktHm+kJ/l5Y7cwv5LxOAbuGqfzGwSReXWAioHAnqMdz3L52Gaqh4S
        xcADyZfgIOIes4xN2o4Cuf4si8GleZ+yPm+3739w4gY8WFOTSi6JN7bgy4vhvjnLE2VC4g
        NlI65cH4+e9RMHhZlJdzoM0dKCy2Hp4nkDCNjc9747fXmCB425k8qHlzg/36ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1667238451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Bir2SJB8dGo7+XamxtZow5M/3jyuDb4RWRrNyzVDip4=;
        b=ww91rQQ6h9AP3SxkZ908PrJ0gGSv5LD5cfRqkUfMtyOn8VDDrW5BoGuIPSBqqkzbqFpyDR
        OK6adXvrQbLBFDyJDgrNZ1Rii0gSmxy1ac94Pu+mLX6BL0n/o7WuqxqeHC4bg7pJGs2zaO
        /41wq/A/TLczxlmmTrlpLPVKBfddNPrmHsB43whzrwWqZUHrYv281tF+qzC5+AXMMk+pfG
        y2O6K4LgasSFC/d76gpV9iXCU+mfJUEtSvRsKAGT2vZvbcap2lzrT9CJKdtsXxkw/S58Us
        m/ZISTqkyf7t0i28y7sEw4KS6fNCmET/Xp+/plY0c+7Ml6p3uFanZMJiw0MLeA==
ARC-Authentication-Results: i=1;
        rspamd-7b8dfb6d4c-m262b;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Thoughtful: 184aa1c6280e4263_1667238451626_3884422489
X-MC-Loop-Signature: 1667238451626:627654579
X-MC-Ingress-Time: 1667238451626
Received: from pdx1-sub0-mail-a225 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.144.184 (trex/6.7.1);
        Mon, 31 Oct 2022 17:47:31 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a225 (Postfix) with ESMTPSA id 4N1LFt0hVNz8k;
        Mon, 31 Oct 2022 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1667238450;
        bh=Bir2SJB8dGo7+XamxtZow5M/3jyuDb4RWRrNyzVDip4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=p0Jm3SzyiEsfD006waFiEMddCk7I7Ck8XBLHxJuZmHeYlQwElMOWlQ7QNGMeAPkzu
         gtlwPrKeMF0FaGhFeamdnObteYFyT9ySnYQ7jWX3AR0po1oDzl+ANVdcpu6vrPbHGB
         EjoYwOx0fl/aBmUx7w1K2fdZOp0W7pj5hZYlRqULRqyqNFXGN7oYFgoVqcjaayM9tY
         93dczT70umTZiSj8QkeHUUnS8yvbSPhYzCddWICuhw4/msGi0r5b16bdskuAkvcd1J
         s9GwGfN2UC0N2UvG8tUUE8/uUiA7D1Q4MWrJVqCpG5cdvmyCzuoJ9+3LHkXPX0gIBe
         T4tlDcbal6kxg==
Date:   Mon, 31 Oct 2022 10:25:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Fan Ni <fan.ni@samsung.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <d.bueso@samsung.com>
Subject: Re: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Message-ID: <20221031172530.jnywmbtjayfambb2@offworld>
References: <CGME20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b@uscas1p1.samsung.com>
 <20221028235705.32890-1-fan.ni@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221028235705.32890-1-fan.ni@samsung.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Oct 2022, Fan Ni wrote:

>The function for retrieving firmware version is named
>`cxl_memdev_get_firmware_verison`, updated to
>`cxl_memdev_get_firmware_version'.
>keeping `cxl_memdev_get_firmware_verison` for library compatibility.
>

Yikes, good catch!

While at it there are a few other typos (not abi, fortunately :)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index fd2962ad78b5..66c1d14ec5e9 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -110,7 +110,7 @@ may appear in the topology that were not previously enumerable.

  NOTE: cxl_memdev_disable_invalidate() will force disable the memdev
  regardless of whether the memory provided by the device is in active use
-by the operating system. Callers take responisbility for assuring that
+by the operating system. Callers take responsibility for assuring that
  it is safe to disable the memory device. Otherwise, this call can be as
  destructive as ripping a DIMM out of a running system. Like all other
  libcxl calls that mutate the system state or divulge security sensitive
@@ -327,7 +327,7 @@ const char *cxl_dport_get_physical_node(struct cxl_dport *dport);
  int cxl_dport_get_id(struct cxl_dport *dport);
  bool cxl_dport_maps_memdev(struct cxl_dport *dport, struct cxl_memdev *memdev);
  ----
-The id of a dport is the hardware idenfifier used by an upstream port to
+The id of a dport is the hardware identifier used by an upstream port to
  reference a downstream port. The physical node of a dport is only
  available for platform firmware defined downstream ports and alias the
  companion object, like a PCI host bridge, in the PCI device hierarchy.
