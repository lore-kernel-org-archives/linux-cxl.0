Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F1C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Mar 2022 21:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiCVVw1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbiCVVwZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Mar 2022 17:52:25 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF876C959
        for <linux-cxl@vger.kernel.org>; Tue, 22 Mar 2022 14:50:56 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E90359219A4;
        Tue, 22 Mar 2022 21:50:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 62ABC92184E;
        Tue, 22 Mar 2022 21:50:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647985854; a=rsa-sha256;
        cv=none;
        b=PnprPgLDAogDHKymHwTfG1XYI+yx7Go1vosaukUhME7LGJ4dJdDMu64vTc8IU4JE8iTpY+
        IbMXSjYlzd0fzo3jcEmVHHZHh7HZRviQYXvp1j7zn1qNE17HHpP4a/TUSZwNqBodhTDzLh
        juBl6vFLlOPu1Yif+Ej5R5TwQCiBI/Lr6gK1hCqGDNpfpgrmbcCo7Ua+HsttrPEujtXpTe
        wgMU6zhTkG5+vLcazbTtd69O/l0qBQgUoeCXmFyntGm2OHprUJMff63tciJ9Hsa7MV2oyx
        MhHUOSeX5BE68WWDdTF9lpwPO6dxJDPPebzpKX21l7Sf9ZcxBtl4g3YVHnbDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647985854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=iSiIQtBV9gOo9Hb+uyCatBiflandKAcV/fhV61KhDLc=;
        b=B/8002JRgHJcDjAQERe4YW56jShlmN1bqElpAD0MWGtn6uJvPlUtfS6hb2YIr6SJLmxMFq
        O450IRHJVVnVa3Gl4P35HTB+nl6e2zDMwy9Af8chKQ4wDdxYCXNcjrpOmOvnSRr+bXx9zt
        0f3QrDUpOuoTWFZqdCYMQdesj5CSNf8PxVxr50y6xyy85/Go6gJFOgoLZBWNipWg3qutiM
        MC6Qs9ZMpr7L8Lwfxwbxfs9jym4aNCN8XZdHIW6KSaEMFIZKZDIXuS2i16/V3N0vy0PM4x
        AF36zPaRYi8vKtjhkqqQ4h0HDY2aivdBLHR43ZIUyb3ZETmdLbcRgBxG3z4soQ==
ARC-Authentication-Results: i=1;
        rspamd-55d445dbdb-4n72t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.234.135 (trex/6.5.3);
        Tue, 22 Mar 2022 21:50:54 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Scare: 1682f55712d38a83_1647985854753_2223154152
X-MC-Loop-Signature: 1647985854753:3454190382
X-MC-Ingress-Time: 1647985854753
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4KNQBm1ZpHz18c;
        Tue, 22 Mar 2022 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647985809;
        bh=iSiIQtBV9gOo9Hb+uyCatBiflandKAcV/fhV61KhDLc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=SOl72TD2uQy/lbnQ5uvPtGIN75q9mgAyo3616sNaXfKP+J/X7GIkWmDM/uNUwWdao
         Ap3ZS+HXFlw+REnCRw26MK0CKamniBN863DODFaGyXkVDtCIpndlL9aBrPVjvieQ3t
         N99f73hPFMP2Ht25NpygZF1kSKFLOoX3hT+lxbCYRX4EJzsRlul9Q+jIYzjA3hfuRy
         yIBjK5301GZCopqUc8XlHgmqxYPKgn95y9r5JKFlIfm3fapRhbxgecRbx889DXWtvt
         UJWicMiz6fWiVhTt3pIscmFM/K14mbHKPRkhKLvdX8MTQ7soVSC4CQO/LS4qy6NADT
         zJCxhopOF2PLA==
Date:   Tue, 22 Mar 2022 14:50:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>
Subject: Re: [PATCH 3/5] cxl/mbox: Improve handling of mbox_cmd return codes
Message-ID: <20220322215004.sejgcghqpwse7gqx@offworld>
References: <20220317234049.69323-1-dave@stgolabs.net>
 <20220317234049.69323-4-dave@stgolabs.net>
 <CGME20220322205612uscas1p17d7f32b9b23dbadc106ae0daf69477f9@uscas1p1.samsung.com>
 <20220322205611.GB198593@bgt-140510-bm01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220322205611.GB198593@bgt-140510-bm01>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 22 Mar 2022, Adam Manzanares wrote:

>On Thu, Mar 17, 2022 at 04:40:47PM -0700, Davidlohr Bueso wrote:
>> Upon a completed command the caller is still expected to check
>> the actual return_code register for to ensure it succeed. This
>
>Is  MB Status register == return_code register here. s/for to/to
>> adds, per the spec, the potential command return codes. It maps
>> the hardware return code with the kernel's errno style, and by
>> default continues to use -ENXIO (Command completed, but device
>> reported an error).
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  drivers/cxl/core/mbox.c |  2 +-
>>  drivers/cxl/cxlmem.h    | 90 ++++++++++++++++++++++++++++++++++++++++-
>>  drivers/cxl/pci.c       |  2 +-
>>  3 files changed, 91 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 778b04a0fb0a..d4d4a16820b7 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -171,7 +171,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>>		return rc;
>>
>>	/* TODO: Map return code to proper kernel style errno */
>> -	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
>> +	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
>>		return -ENXIO;
>>
>>	/*
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 5d33ce24fe09..268597d1ff33 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -85,9 +85,97 @@ struct cxl_mbox_cmd {
>>	size_t size_in;
>>	size_t size_out;
>>	u16 return_code;
>> -#define CXL_MBOX_SUCCESS 0
>>  };
>>
>> +/*
>> + * Per CXL 2.0 Section 8.2.8.4.5.1
>> + */
>> +enum {
>> +	CXL_MBOX_CMD_RC_SUCCESS = 0,
>> +	CXL_MBOX_CMD_RC_BACKGROUND,
>> +	CXL_MBOX_CMD_RC_INVINPUT,
>> +	CXL_MBOX_CMD_RC_UNSUPPORTED,
>> +	CXL_MBOX_CMD_RC_INTERNAL,
>> +	CXL_MBOX_CMD_RC_RETRY,
>> +	CXL_MBOX_CMD_RC_BUSY,
>> +	CXL_MBOX_CMD_RC_MEDIADISABLED,
>> +	CXL_MBOX_CMD_RC_FWINPROGRESS,
>> +	CXL_MBOX_CMD_RC_FWOOO,
>> +	CXL_MBOX_CMD_RC_FWAUTH,
>> +	CXL_MBOX_CMD_RC_INVSLOT,
>
>Should we keep the FW prefix for INVSLOT, since this is still related to a
>FW operation?
>
>> +	CXL_MBOX_CMD_RC_FWROLLBACK,
>> +	CXL_MBOX_CMD_RC_FWRESET,
>> +	CXL_MBOX_CMD_RC_INVHANDLE,
>> +	CXL_MBOX_CMD_RC_INVPA,
>> +	CXL_MBOX_CMD_RC_INJPOISON,
>
>We should indicate that we hit the poison limit, something like the
>following POISONLMT
>
>> +	CXL_MBOX_CMD_RC_MEDIAFAILURE,
>> +	CXL_MBOX_CMD_RC_ABORT,
>> +	CXL_MBOX_CMD_RC_INVSECURITY,
>> +	CXL_MBOX_CMD_RC_PASSPHRASE,
>> +	CXL_MBOX_CMD_RC_MBOXUNSUPPORTED,
>> +	CXL_MBOX_CMD_RC_INVPAYLOAD,
>
>Might as well be more descriptive here PAYLOADLEN, looking at this more now
>maybe we drop all of the INV prefixes since most of the return codes are error
>codes.

Yes to all the above.

>
>> +};
>> +
>> +#define CXL_CMD_RC(_value, errno, str)		\
>> +	[CXL_MBOX_CMD_RC_##_value] = {		\
>> +		.err = errno,			\
>> +		.desc =	str,			\
>> +	}
>> +
>> +/*
>> + * mbox cmd hardware return_code handling
>> + */
>> +struct cxl_mbox_cmd_rc {
>> +	int err; /* proper kernel style errno */
>> +	const char *desc;
>> +};
>> +
>> +static const struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] = {
>> +	CXL_CMD_RC(SUCCESS, 0, NULL),
>> +	CXL_CMD_RC(BACKGROUND, ENXIO, "background cmd started successfully"),
>> +	/* errors here on out */
>> +	CXL_CMD_RC(INVINPUT, ENXIO, "cmd input was invalid"),
>> +	CXL_CMD_RC(UNSUPPORTED, ENXIO, "cmd is not supported"),
>> +	CXL_CMD_RC(INTERNAL, ENXIO, "internal device error"),
>> +	CXL_CMD_RC(RETRY, ENXIO, "temporary error, retry once"),
>> +	CXL_CMD_RC(BUSY, ENXIO, "ongoing background operation"),
>> +	CXL_CMD_RC(MEDIADISABLED, ENXIO, "media access is disabled"),
>> +	CXL_CMD_RC(FWINPROGRESS, ENXIO,
>> +			"only one FW package can be transferred at a time"),
>> +	CXL_CMD_RC(FWOOO, ENXIO,
>> +			"FW package content was transferred out of order"),
>> +	CXL_CMD_RC(FWAUTH, ENXIO, "FW package authentication failed"),
>> +	CXL_CMD_RC(INVSLOT, ENXIO,
>> +			"FW slot specified is not supported for requested op"),
>> +	CXL_CMD_RC(FWROLLBACK, ENXIO,
>> +			"rolled back to the previous active FW"),
>> +	CXL_CMD_RC(FWRESET, ENXIO, "FW failed to activate, needs cold reset"),
>> +	CXL_CMD_RC(INVHANDLE, ENXIO,
>> +			"one or more Event Record Handles were invalid"),
>> +	CXL_CMD_RC(INVPA, ENXIO, "physical address specified is invalid"),
>> +	CXL_CMD_RC(INJPOISON, ENXIO,
>> +			"allowed poison injection has been reached"),
>
>injection limit
>
>> +	CXL_CMD_RC(MEDIAFAILURE, ENXIO, "permanent issue with the media"),
>> +	CXL_CMD_RC(ABORT, ENXIO, "background cmd was aborted by device"),
>> +	CXL_CMD_RC(INVSECURITY, ENXIO,
>> +		   "not valid in the current security state"),
>> +	CXL_CMD_RC(PASSPHRASE, ENXIO,
>> +			"passphrase doesn't match current passphrase"),
>
>current set passphrase
>
>> +	CXL_CMD_RC(MBOXUNSUPPORTED, ENXIO,
>> +			"not supported on the mailbox it was issued on"),
>> +	CXL_CMD_RC(INVPAYLOAD, ENXIO, "invalid payload length"),
>> +};
>
>Other than the minor nits.
>Looks good.

Thanks for reviewing. I'll add the changes in a v2 but will wait a bit
for any further feedback.
