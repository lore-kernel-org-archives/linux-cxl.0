Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE331C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Mar 2022 02:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbiCPCJo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Mar 2022 22:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiCPCJo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 15 Mar 2022 22:09:44 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0515C876
        for <linux-cxl@vger.kernel.org>; Tue, 15 Mar 2022 19:08:28 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 25F9F280FC4;
        Wed, 16 Mar 2022 02:00:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a314.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DF90328107C;
        Wed, 16 Mar 2022 02:00:40 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a314.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.126.219 (trex/6.5.3);
        Wed, 16 Mar 2022 02:00:56 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Harbor: 5eba763c4fe2c90b_1647396056012_2194390190
X-MC-Loop-Signature: 1647396056011:2281342408
X-MC-Ingress-Time: 1647396056011
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a314.dreamhost.com (Postfix) with ESMTPSA id 4KJD540107z1Z;
        Tue, 15 Mar 2022 19:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647396040;
        bh=GxcVkw0atyl3mYFIk7cPPWRAc0TbRbf3bd+NKLrXuOA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=kdZAdDLtx0kMPEy7Rc+4tdfr6k5P2VsgF6l1UEOb5j84WOIKizhEEtXgF14K368gD
         oZzXhfN3u/fLwIvsEGeHZCNA91m2rCiOSEbz2QbXUM1A6AfNFYw8bE+9l9lSPVrBGO
         Coh3+/KGig5rWG4gYrsDw5DbX1q7TJr0EKTNpGWGBcnHAQ5JPbRGLckrsetyryPFUY
         gKODU/mhdl+0zrHRwPl7XDZxnXP38BA7/ohrP8zezuUWeHWJXbzomwLvAqyKJewWJz
         WsOkEQI7CoHiSrOTP1sP4evlbYrZKW3Q/KX2109eggTu00Ix+sj7JmiQn1YBq6lIS9
         ouic5b+tBplkA==
Date:   Tue, 15 Mar 2022 19:00:28 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v2 3/6] cxl/mem: Make cxl_dvsec_range() init failure fatal
Message-ID: <20220316020028.2yqjvez4avwrni5l@offworld>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730735324.3806189.4167509857771192422.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <164730735324.3806189.4167509857771192422.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Mar 2022, Dan Williams wrote:

>In preparation for the cxl_pci driver to continue operation after
>cxl_dvsec_range() failure, update cxl_mem to check for negative error
>codes in info->ranges. Treat that condition as fatal regardless of the
>state of the HDM configuration since cxl_mem needs positive confirmation
>that legacy ranges were not established by platform firmware or another
>agent.
>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>---
> drivers/cxl/mem.c |    3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>index cd4e8bba82aa..50704deb2ff0 100644
>--- a/drivers/cxl/mem.c
>+++ b/drivers/cxl/mem.c
>@@ -88,6 +88,9 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
>	void __iomem *crb;
>	u32 global_ctrl;
>
>+	if (info->ranges < 0)
>+		return false;
>+

Nit: shouldn't this be part of the next patch that actually implements negative
info->ranges?

Thanks,
Davidlohr
