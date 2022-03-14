Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4D7C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Mar 2022 18:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiCNS6f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Mar 2022 14:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiCNS6f (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Mar 2022 14:58:35 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E0165CF
        for <linux-cxl@vger.kernel.org>; Mon, 14 Mar 2022 11:57:23 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A305B2C177A;
        Mon, 14 Mar 2022 18:57:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A94172C1466;
        Mon, 14 Mar 2022 18:57:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647284241; a=rsa-sha256;
        cv=none;
        b=2UvH5jcRvfUGRY7/AKK8aZq4w3uYYXxbMrbcsTTJMq1uDVkAcBpeiu2raTaTIj0LvNYgDy
        m57lT2gjhLu6Db4YJ/SWVoNxDuqiymgQ5dH9kEeFQgAgXK2CTF5pEd19OK78L0A0wVqZlW
        zY/K9c7BcS5Sw+pMj9uTamI9m6FXvAGfekO93k7jBBWJWFR84dZTUqHcMGD1OuHzhCQjiO
        bxr7d/E8gdX9V8tGxNHA6VNz90ixtGBON+MTf2kHC5mmJmIfj8R01uIP2rx5zJ2SQQVBTZ
        6htAx4dCb6OyVbRFQNBgZ9nJZI6SuOwIS2ZJRABIdy019N+mgkRM4gDss0CuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647284241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=5nleZ0c0t7GX2xavCSGEWi6xPIqmw7fft/IrTavw+9k=;
        b=YWrIB7b1+EOfc9lRfnlt8aOooePU59l2gIzggDjGWlF2Vcrkq7mxfcFqkvA2osx1iDJ4iB
        KajoGpIOAj/dCFUZBFpyLDLVmMNhi2tGhHVhIY1Fw+S4zuVWXfAEcsOFmIrH1ODbE6/5NI
        1JfiRO0gHlvFvysm7ODJNFl9eULiU3pqfPJPZzGH8/yJnjstKw95FkBfLLevEVOzXqZ2fS
        tmLvvyOIE6cgaXkOBWzmoH+Iijhwab+T9HdvFBAVCq2DcdwqluOr9cK0i2Rh7gBcBzAoPS
        vK+Jo0FiKmSg4DcU9p1nhnwAw3tiNKheLLiz7LCs5ECSpmcqLNMj6dOMLz2LUw==
ARC-Authentication-Results: i=1;
        rspamd-74bfb75fc6-tnhjm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.157 (trex/6.5.3);
        Mon, 14 Mar 2022 18:57:22 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Broad-Gusty: 734527b8388dbfec_1647284242485_13410863
X-MC-Loop-Signature: 1647284242485:1490249930
X-MC-Ingress-Time: 1647284242485
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4KHQl50bF5zZR;
        Mon, 14 Mar 2022 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647284241;
        bh=5nleZ0c0t7GX2xavCSGEWi6xPIqmw7fft/IrTavw+9k=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=XUEPFtnVAMZYSCQPC5ySutRwaN/o6Jjmd1zfTX0gXI31KJVnrM722Fkf2khacS5QH
         uaDOC6E3uprnVS/pY70PJ7kDGkuCJ33bnSybGpNzO0mlevEbzLSLRs4ZzypsM9xBP1
         nSoalShO86mZGFJa7WBIFghqSnYY/FVe9+CRUj3QazocEx9LymwHyp/jRTihj9AIZs
         bI1YQ10hGa+3PdDZSoz7s8eSilJVdZapC47EfiXoPS0ox8NrcmQEHBaP/h+eMcKTsR
         rgHLO5Aibm443y6J8vkDBCLOQHxehMh+j3dwnh6vnb1vMuywuypYbUkKsLMWj0yRTZ
         ninVU+uHG1NoQ==
Date:   Mon, 14 Mar 2022 11:48:19 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
        ben.widawsky@intel.com
Subject: Re: [PATCH 1/2] cxl/mem: Drop DVSEC vs EFI Memory Map sanity check
Message-ID: <20220314184819.dzg6e5h6wym4mp2d@offworld>
References: <164690155138.3326488.16049914482944930295.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164690155691.3326488.3362471282782924455.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <164690155691.3326488.3362471282782924455.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Mar 2022, Dan Williams wrote:

>When the driver finds legacy DVSEC ranges active on a CXL Memory
>Expander it indicates that platform firmware is not aware of, or is
>deliberately disabling commone CXL 2.0 operation. In this case Linux
>generally has no choice, but to leave the device alone.
>
>The driver attempts to validate that the DVSEC range is in the EFI
>memory map. Remove that logic since there is no requirement that the
>BIOS publish DVSEC ranges in the EFI Memory Map.
>
>In the future the driver will want to permanently reserve this capacity
>out of the available CFMWS capacity and hide it from
>request_free_mem_region(), but it serves no purpose to warn about the
>range not appearing in the EFI Memory Map.
>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
