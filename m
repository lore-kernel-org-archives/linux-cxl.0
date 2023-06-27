Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC14AEB64D9
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Jun 2023 08:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjF0Iio (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjF0Ii2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Jun 2023 04:38:28 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E71B0
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jun 2023 01:37:41 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 57861880D10;
        Tue, 27 Jun 2023 08:37:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CEA8A880E26;
        Tue, 27 Jun 2023 08:37:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687855059; a=rsa-sha256;
        cv=none;
        b=Wtq49F5ctCB1shkEAd7GeMrQURPDaCUJdDaEC4iYkNl5ltNfsNlSGkN7525LNdHNXFduBF
        uJJctVGcpnE3xbB9budfISetLGmEollhx5b5Ssmnv6Lrg7E9z/EfAwFM+VsXCOG0iqr+so
        jHdjf/7OsJS1Rgtd1S0sGZfTA4Ifkr+0BLGwcGWcJDcJrX4eq44aPSdwIk29NMzTCf9jjB
        /NfYDhf23+yx5qy2Kh9hnMPpZyUKX70XzDTPvSeaUlK1G8BtFTVfydkJtnUWGo2deU/wFb
        TjxMbSFyy5DsOfUIzJ0jhuCMJYsHxEhm5LssLKTCNFyki1wmDAhiIqK3B0Gdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687855059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=VwuLXFy2VqQcm5HmKDk/jT/CloAe8Cp8oEfRoM/XAk8=;
        b=zdlF4kOm8n8jYVUWiscNLMs4bI5UJJiXfIF4Iy9c1kIwzHC61b4k2vCK95aoDkXznWkuDp
        O4TVcZ1d2D0Hk76AnVXuXJcCCZUTj6Wo0WHcwndsOVQS9Oou2Q5+2DWihPG3EL6SaCf7kN
        U3HRccO1pzTXX3umLUoLdX18n8WbADK+wsBJhIUOkVd/F8Ii7ewpJE97jAQhdxmpmOCGaQ
        J0YRd0od5YALpGYGlcuBglavVgAr2Mj8RIfHplkPL3ZzW1zsXUcbRRwzGk43pZFwBT3Sn7
        W4YhlOyS6F8sxl0W0HYHLXCC72Z5aD2258hRQUdOnk6611kzSm6W7qhMkM1lbA==
ARC-Authentication-Results: i=1;
        rspamd-9fcc56855-twxqs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Spill: 37bb6f1a4c8ac3b8_1687855060151_2635174159
X-MC-Loop-Signature: 1687855060151:729753962
X-MC-Ingress-Time: 1687855060151
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.17 (trex/6.9.1);
        Tue, 27 Jun 2023 08:37:40 +0000
Received: from offworld (host86-183-53-156.range86-183.btcentralplus.com [86.183.53.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4Qqyl54PHVz6W;
        Tue, 27 Jun 2023 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1687855059;
        bh=VwuLXFy2VqQcm5HmKDk/jT/CloAe8Cp8oEfRoM/XAk8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=gka/sfZl9+grAZpBjXAUcmkwD3yVQPWCLNz8KwuwICwNccBMfdCZ9NpW27Sf3F1Q0
         /LoToBCdk7acq3pRjv1mhFNJeBBVCyIQgW8Ta+W+y6eVoop0vxVRrow+8oBcHXrLdB
         bj1NKs3kwMw5BHcsAG82gRLXPAfjpSozVe8ful9Gr6FFcW1Pco6cuf4+3tqsLhhCey
         RbpyMfW5nWhR9zjBCcI1krrevLOAO47b6HMRrjxI8dSxqNcyNyldIX1esi8VGE3NcM
         Eb9cc/WDv3at7k2tA/1yb7iqWUdgqTmZzee3j1RjxnozgkaNZ6Gd+rEe1FDfcd63lg
         PshHBJ28/XK+A==
Date:   Tue, 27 Jun 2023 01:02:02 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/pci: Use correct flag for sanitize polling
Message-ID: <7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <6498c35a934ab_8e178294b9@dwillia2-xfh.jf.intel.com.notmuch>
 <ll3imaqzzqkhmsa2r4rxxzhmgnpoayuasb3ay5dfx47f7avco2@j6bmlcelamco>
 <649a1583f3331_8e178294f6@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <649a1583f3331_8e178294f6@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This is a bogus value, left behind from a previous version.

Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
  drivers/cxl/pci.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 48f88d96029d..1cb1494c28fe 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -295,7 +295,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
		 * and allow userspace to poll(2) for completion.
		 */
		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
-			if (mds->security.poll_tmo_secs != -1) {
+			if (mds->security.poll) {
				/* hold the device throughout */
				get_device(cxlds->dev);

--
2.41.0
