Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2983C43334
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Jun 2022 04:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiFKEkI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 11 Jun 2022 00:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346916AbiFKEkG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 11 Jun 2022 00:40:06 -0400
X-Greylist: delayed 9421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 21:40:04 PDT
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E53C5FBA
        for <linux-cxl@vger.kernel.org>; Fri, 10 Jun 2022 21:40:02 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 35EF86C1791;
        Sat, 11 Jun 2022 04:39:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9EC256C1804;
        Sat, 11 Jun 2022 04:39:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654922398; a=rsa-sha256;
        cv=none;
        b=fpEBz6dIKcTNUGegOgK9A6rgcOAvneqF9TeUsyJo/ISGvHqCChKG30/7MjdZocixzjcPuO
        H/YfXATxkWtJO/tEaPgG2u9J+66TuxioxgTiZ0TBOPWOBH5lRJpaDTlZIlTiz1g2D2F1sN
        H+L4//uoqW7kZDAzMlLkuOVdw2lc0Kk8OapjkzJBaQsy1NUPXj88dj0IH4Sh7t31CMQTH9
        EAgY76cnHBiMMlvIIy3IgyAQd7H0pGJFbUM3hZR5tp395mk34llBglOx1KlmcynDoYFJqf
        P7Q0b8XKvKnQO2xSZ4MTIIOmlMop/F9Zuyq9WhIVvSzw+nHqCMRnXgY6BRmPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654922398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=EloioTOwJGQI4Ep0BNqAhmIWuMbxNqurxhFz49jnUI4=;
        b=Yg83iuQfsmr9E8UM4P5wT6zh5QANR02NHPnTY8QfpIQ6egycSUVIfnTlaLw2Mm3ubo2MTC
        PyqFatncraMpDz799dY2Nnz8mOtJDItZqelEYm6g+WWaRfZkO+CW/AzrxlDvMjOwruAe/O
        Az0+es+8BvOfosabAtlTxwv5o3CEAwq/kw8nUummW/NaPL6qRPeO5KGpIBcE6RGRig45A3
        ZvEAxkwaKcOazFJI/p2PRoJRxMjPJCQ8JWg+9JCUuVgEZC2taCWy9XtzLdGgKv61YqEXv9
        MSAAYH2SV6DoGHwOdp+Uc0CTl7Ki2+ieplbGwTScmHhgmhCIwrd6bd1GYp5dVA==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-bv6df;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Eyes: 5f8acf863a7e3125_1654922398975_3496181475
X-MC-Loop-Signature: 1654922398974:3703147740
X-MC-Ingress-Time: 1654922398974
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.51 (trex/6.7.1);
        Sat, 11 Jun 2022 04:39:58 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LKlVj6jtZzMB;
        Fri, 10 Jun 2022 21:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654922398;
        bh=EloioTOwJGQI4Ep0BNqAhmIWuMbxNqurxhFz49jnUI4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hAS0THRrP6GIE4HSCf+jktWilu9ZT8qLl6dwHT0+rvySQeul+K3TjMjTudjXP/RwQ
         XXY244/xm4L7AH5w/jq5G/hRyObRPW1mn0ANjndLAC1LserTjkpOlovU/IoXL7raXt
         uu7rA47KRsDIuAwPG+YGmBdRyJnWwI2DEy3/QBXOqe3i4qSIFzMppCkOUapo7bYXl2
         YND5hT694WVF28C9o4kGzVA8fYdH6ovVX1wJhhwp3InsralhB7B6dUowtduJ+awFHO
         ks4IX/f4mPeSSJsxc5tjfrukAXWRtImefDg28ol46fmS3lCPE6HwqiqmNb1yUetAvz
         mXSkGj0ybHD9g==
Date:   Fri, 10 Jun 2022 21:26:01 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com
Subject: Re: [PATCH] cxl/port: Check for sane CXL.io values for device DVSEC
Message-ID: <20220611042601.ezsjsoq2kaov76e3@offworld>
References: <20220611020246.140637-1-dave@stgolabs.net>
 <20220611040321.gmjyddcyb4q73o4e@bwidawsk-mobl5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220611040321.gmjyddcyb4q73o4e@bwidawsk-mobl5>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 10 Jun 2022, Ben Widawsky wrote:

>On 22-06-10 19:02:46, Davidlohr Bueso wrote:

>> +	if (!(cap & CXL_DVSEC_IO_CAPABLE)) {
>> +		dev_dbg(dev, "Not IO Capable\n");
>> +		return -ENXIO;
>> +	}
>
>I don't know if it's worth doing this. We wouldn't have gotten to the registers
>if it wasn't CXL.io capable.

Yeah I thought there might be reason as to why bit 2 was checked but not 1.
Does this also apply for CXL_DVSEC_IO_ENABLE? fwiw I thought this was handy
in case of bogus dvsec setups via qemu.

>> +
>> +	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
>> +		dev_dbg(dev, "Not MEM Capable\n");
>> +		return -ENXIO;
>> +	}
>> +

Either way this check should still be moved before reading the ctrl
word.

Thanks,
Davidlohr

>>	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
>>	if (rc)
>>		return rc;
>>
>> -	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
>> -		dev_dbg(dev, "Not MEM Capable\n");
>> +	if (!(ctrl & CXL_DVSEC_IO_ENABLE)) {
>> +		dev_dbg(dev, "Not IO Enable\n");
>>		return -ENXIO;
>>	}
>>
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index fce1c11729c2..845f59288dc3 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -18,9 +18,11 @@
>>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>>  #define CXL_DVSEC_PCIE_DEVICE					0
>>  #define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_IO_CAPABLE	BIT(1)
>>  #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>>  #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>>  #define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_IO_ENABLE		BIT(1)
>>  #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>>  #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>>  #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> --
>> 2.36.1
>>
