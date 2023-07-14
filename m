Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F17AEB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 15:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjGNPhe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjGNPhX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 11:37:23 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DF630E5
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 08:37:17 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 690FCC12E7;
        Fri, 14 Jul 2023 15:37:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 94C03C1271;
        Fri, 14 Jul 2023 15:37:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689349035; a=rsa-sha256;
        cv=none;
        b=bFNeaPweAhmN2aPOgHGO93ukxyXj0VRouJrwE9nbKgGZuvOJhnVC/O/XNt29HgPeo38e/O
        OxWUH7OFuNqoUbXmZpiY2N9fI/tV1Aaq3UZApsnA4K96Ido31NRraC38i/3iNqXP6q6qZt
        vQfzrxaAqCMPJ/f1TcA1+QcY8uBk+ecpPfUigSasM7J2b1ZI2yP3ZwySuoraB2IZ3C/tnE
        xNz0hcung7f6GoFz6EsezAe99NdK41Sgrh3SwUvNsb2TwPr0dyng9sneZuFa0cMb8aSs6g
        3+HQMI/OvYu3J3M4hLMNEiyxot8kwa/wTYpqHmt6LNl3rsdNOvJsz+yC2mfP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689349035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=p5Cui3oDvu0aCHBUC10APznh7NHSRpZ49dKNbLU5T3Q=;
        b=a4D7nZLc158eyn+D6uq61gqfD9p36BfpkOxGNLnH+ZjYDFjDVfpZbZQSgl6P206Iazl8dm
        YDv7aN0ZBnPCdjl3xr4kOUcTXfu+DcZ1H3Wz2IeF05u8Sdh9XCW6FIkglbMy6ZNmuRwIPi
        f6D+BquZWaHivdqZQPo5l+VWsztMaSsrc3l3qUhqwV1AZU7DPAWVAkQXHvMV7j3YsSq1BO
        YvOLAEVDn6XRQNxMRkmy+0ccbnZeM9OQSFGbHZKGCTG4mtvYlKrtqcBsN92tOup5pwdsnf
        RV4i21uF4uZsso7XxJgvGPGxVDooHac53ATMR/HVg0n8iBbuuK/ANn6eDgL1LQ==
ARC-Authentication-Results: i=1;
        rspamd-5595f87fc9-zmt67;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Cooperative: 35530517534acee8_1689349035913_1772567096
X-MC-Loop-Signature: 1689349035913:181426493
X-MC-Ingress-Time: 1689349035913
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.146.93 (trex/6.9.1);
        Fri, 14 Jul 2023 15:37:15 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4R2bFQ5gZlz6f;
        Fri, 14 Jul 2023 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689349035;
        bh=p5Cui3oDvu0aCHBUC10APznh7NHSRpZ49dKNbLU5T3Q=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=NqNdnOdggIQ0VsYo+BdXw+e2y0rPDOLzRcRuhI9qibTvh7Zp5D/4fkpoYHKtAQise
         3Kris/dQ6JekQK3PY3coK4qtyFuBIgWjHOEeoEljYIdqfipbSJiWl7jlyHXIHpHfRX
         gK/7euBPMAeRB2tr434KDB7gmex9JvTqWQYrEg6EFNlmd+8iWAAc3FP+OxTsBUlvtU
         YJFM/u3bJCidCe5DNHixwUwnUUIlq6X+PFUr003dUdgyYb/BLogRb3wmjoZxdBLgw+
         x7jws1mAi/fKJP7nUTbMa9ES5iAsW0F1cYHdX6iCMAj7UfH4MuC9JYySWkW9ZiRNQo
         cJgbMpSAIWk1Q==
Date:   Fri, 14 Jul 2023 08:00:43 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/memdev: Introduce sanitize-memdev functionality
Message-ID: <72wb3boxuugrb35cz2riexiyfszzc4pc43v7i5ufct7kszjoso@x4gjsuohw4kc>
References: <20230713195455.19769-1-dave@stgolabs.net>
 <20230713195455.19769-3-dave@stgolabs.net>
 <ZLC/6mWTE+2WxcGd@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZLC/6mWTE+2WxcGd@aschofie-mobl2>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 13 Jul 2023, Alison Schofield wrote:

>On Thu, Jul 13, 2023 at 12:54:51PM -0700, Davidlohr Bueso wrote:
>> Add a new cxl_memdev_sanitize() to libcxl to support triggering memory
>> device sanitation, in either Sanitize and/or Secure Erase, per the
>> CXL 3.0 specs.
>
>Hi David,
>
>Seems like maybe the commit msg and log got outdated. You actually
>do the whole sh-bang here, not just an Introduction of the libcxl
>accessors.

Right, the above was only a summary of the main changes to support the
objective. Not outdated.

>
>A few tidbits follow -

Thanks for having a look.

>
>>
>> This is analogous to 'ndctl sanitize-dimm'.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  Documentation/cxl/cxl-sanitize-memdev.txt | 68 +++++++++++++++++++++++
>>  Documentation/cxl/cxl-wait-sanitize.txt   |  4 ++
>>  Documentation/cxl/lib/libcxl.txt          |  1 +
>>  Documentation/cxl/meson.build             |  1 +
>>  cxl/builtin.h                             |  1 +
>>  cxl/cxl.c                                 |  1 +
>>  cxl/lib/libcxl.c                          | 16 ++++++
>>  cxl/lib/libcxl.sym                        |  1 +
>>  cxl/libcxl.h                              |  1 +
>>  cxl/memdev.c                              | 47 ++++++++++++++++
>>  10 files changed, 141 insertions(+)
>>  create mode 100644 Documentation/cxl/cxl-sanitize-memdev.txt
>>
>> diff --git a/Documentation/cxl/cxl-sanitize-memdev.txt b/Documentation/cxl/cxl-sanitize-memdev.txt
>> new file mode 100644
>> index 000000000000..25aa3f55b789
>> --- /dev/null
>> +++ b/Documentation/cxl/cxl-sanitize-memdev.txt
>> @@ -0,0 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +cxl-sanitize-memdev(1)
>> +======================
>> +
>> +NAME
>> +----
>> +cxl-sanitize-memdev - Perform a cryptographic destruction or sanitization
>> +of the contents of the given memdevs.
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'cxl sanitize-memdev' <mem0> [<mem1>..<memN>] [<options>]
>> +
>> +DESCRIPTION
>> +-----------
>> +The 'sanitize-memdev' command performs two different methods of
>> +sanitization, per the CXL 3.0+ specification. It is required that
>> +the memdev be disabled before sanitizing, such that the device
>> +cannot be actively decoding any HPA ranges at the time. This
>> +permits avoiding explicit global CPU cache management, relying
>> +instead on the implict cache flushing when a region transitions
>> +between active to commited.
>
>s/implict/implicit
>s/commited/committed

Indeed.

>
>snip
>> +--sanitize::
>> +	Sanitize the device to securely re-purpose or decommission it. This is
>> +	done by ensuring that all user data and meta data, whether it resides
>
>s/meta data/metadata or meta-data

Ok

>
>snip
>>
>> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
>> index 172dfb47a2dd..baf2a917ea6c 100644
>> --- a/cxl/lib/libcxl.c
>> +++ b/cxl/lib/libcxl.c
>> @@ -4046,6 +4046,22 @@ CXL_EXPORT int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev)
>>	return rc;
>>  }
>>
>> +int cxl_memdev_sanitize(struct cxl_memdev *memdev, const char *op)
>> +{
>> +	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
>> +	char *path = memdev->dev_buf;
>> +	int len = memdev->buf_len;
>> +
>> +	if (snprintf(path, len,
>> +		     "%s/security/%s", memdev->dev_path, op) >= len) {
>> +		err(ctx, "%s: buffer too small!\n",
>> +		    cxl_memdev_get_devname(memdev));
>> +		return -ERANGE;
>> +	}
>> +
>> +	return sysfs_write_attr(ctx, path, "1");
>
>Write that attribute w new line "1\n"

Sure.

>
>
>> +}
>> +
>snip
>
>> +static int action_sanitize_memdev(struct cxl_memdev *memdev,
>> +				  struct action_context *actx)
>> +{
>> +	int rc = 0;
>> +
>> +	if (cxl_memdev_is_enabled(memdev))
>> +		return -EBUSY;
>> +
>> +	/* let Sanitize be the default */
>> +	if (!param.secure_erase && !param.sanitize)
>> +		param.sanitize = true;
>> +
>> +	if (param.secure_erase)
>> +		rc = cxl_memdev_sanitize(memdev, "erase");
>> +	if (param.sanitize)
>> +		rc = cxl_memdev_sanitize(memdev, "sanitize");
>> +	else
>> +		rc = -EINVAL;
>
>What's the deal w supporting secure erase with sanitize?
>Seems useless, but perhaps it's cheap.

It is what it is. The secure erase option passed as a program
parameter seemed a natural fit - in addition, both operations
are logically grouped under the Sanitize category per specs.

Vishal was fine with this, did you have anything in mind?

Thanks,
Davidlohr
