Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B31C43334
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Jul 2022 19:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiGGTpx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiGGTpw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Jul 2022 15:45:52 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEC72BB18
        for <linux-cxl@vger.kernel.org>; Thu,  7 Jul 2022 12:45:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1C9BA2C145A;
        Thu,  7 Jul 2022 19:45:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a297.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6DC432C185D;
        Thu,  7 Jul 2022 19:45:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1657223143; a=rsa-sha256;
        cv=none;
        b=AQ/02B61lYNJ7JgswG4LBb5n51BOQaa64BoNkWk5ehBSFI1GOnQEha4C47nITqQLAaHzR9
        U8b4X4u+5W8D8ZKOfsBbA9Sy7jJX3tq6ztZ4jFzX24G9r8eR992MOsy1SFUvN9XUV2dgmI
        NzJAnDEUZXbCT7l5yi8LDMqdQpo/rIuMIA2mYyCWcG1Jq8BJekuME4gAjaIoWm1GjL28FK
        4y1iGcxjyS4wj0CwM0epSURtooLW6OHkq5z4WcEkKtU1t8H2pg4nH4FoyEb0LW6MCpQS7f
        az6lzfCA0Tl5VRYVMSIOL4DH4Vq/AuKDVP9JENniy0p0Iqg8qm4qc/eXei7O/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1657223143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=W+C/FWKLB8nDC1sdLUTwJdGWMbjLCIvupTmL51vpv3k=;
        b=3XZAUuFGsruVZ8zsS74GqoC/ifLFOua98Mgr+C4dGsTQFGiioYpRNTbGI17VXYXpfFQw6R
        h59D6uwpmydlKxHGfxEow6H0RftpZUThW09ocMXWRG31vbhQvJLJAlag4KBGCuQpy0ujvC
        Qxfy7r7Y0ig2o3xbs9QOYY72P0iV7k1wUgXL0VRWfSWMMLGNuvEJoo6R9mtEI1TUJnsv65
        H8GRVM6ZJfROCIYWcsuW0hHIUAJdzJymgAKv5xtREYnDvxaRUgvuuUNpf8dTw8Btrh6Oo1
        dUjeQCUWp2smuL3fjKd+tKQkofb/ve2DEl69n0Aj9BV16t/wcOa4MQdr7tI9NA==
ARC-Authentication-Results: i=1;
        rspamd-674ffb986c-zn9wj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arch-Stretch: 252a8d5916d654b3_1657223143815_3897624975
X-MC-Loop-Signature: 1657223143815:4191711699
X-MC-Ingress-Time: 1657223143815
Received: from pdx1-sub0-mail-a297.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.120 (trex/6.7.1);
        Thu, 07 Jul 2022 19:45:43 +0000
Received: from offworld (unknown [104.36.25.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a297.dreamhost.com (Postfix) with ESMTPSA id 4Lf6Mp2KDhz10;
        Thu,  7 Jul 2022 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1657223142;
        bh=W+C/FWKLB8nDC1sdLUTwJdGWMbjLCIvupTmL51vpv3k=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ONOz+d6/IFE/kV+wPU5TUze5HC9asK3TzFeZedCejig04u5oqbaC1W0d45Qfm6ILZ
         N1ehfUtaK/B01qxXHcb0Khu6PWqdMbRGfkzj2CtSgSDxx2o34uczrPo3PXjbHi40vd
         ihPOduDy8rveQWjX/hEuFDCQjycwZ0vWwtHBgA53169Zt/zLUas6c04SsJQ+QGKLI9
         r58X4UQAySKlItcc0EaNuUkGoI4hNAbPi29oodhwE+x/gIobRd2opJuAcwOIW6zOYK
         oZeXRHsuPlQlmbaCdm9bFMi2wHJf2AzkwqViB7S4hy5PqwqscW4zIGRpAMvoSVkzmJ
         UnBoOxBWdFvrg==
Date:   Thu, 7 Jul 2022 12:30:16 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        a.manzanares@samsung.com
Subject: Re: CXL device sanitation and pmem security questions
Message-ID: <20220707193016.qdpnwi5jnu6hxrix@offworld>
References: <20220707190524.i2fxgk5ez6c35vw6@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220707190524.i2fxgk5ez6c35vw6@offworld>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 07 Jul 2022, Davidlohr Bueso wrote:
>Iow, get security capabilities would need to be consulted (for the
>CONFIG_CXL_PMEM cases)?

s/capabilities/state.
