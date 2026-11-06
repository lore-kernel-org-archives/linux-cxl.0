Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009288;
	b=GKeDPL8kW2zoWyYC/p5330udTxR8LDD8fst/AcZcsKFM/ICusQau6kd8Nfcx5LlmsT9E
	 Bv1LTRDlQnhm5jVVBzuDo6hQSPXEfK42WQTJonbVUsUjgb1jye7xIaiPbfRIW7Z+Irtit
	 hHn+JGhXNzADiEOAPrhWLoP9rj3VWQV4OpIBlVkHzg8mexRu6v4qAPJrRz6NjdyQq0Z1K
	 1GG/O1lGmSUJQ/FsPfUbYSvxaOE1HHD6sqUhO1N/7hKkZAtFYSDCZiTVaKdnCchYSjIa7
	 J0QqOiytXR0MY7Y5TaUpqRGAi1bv0X49jW1XsuLgB6UTvNh+b10KE1LMCV7fK5XHF+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009288;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Shelf-Imminent:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=LEIiF6m5nfC9Ad84lModldGENvWoLDBpFpzsIM0j77E=;
	b=iZZYTqsI5J5DFzU5cwwx4Xq0KZjqG1tbWB6S9eQLn4f1+sYmBH65HMj/jZU9X4+sbsvS
	 JaDF5wUVr7Qn8zwn6S48JMKmhjMK6606oKMaxG1yVUgy5uFbuTq8xazE0wiUdTHqSOt21
	 +8US6t/AqQ3gIsox+0ZVGw4aGOWtx2luq5+rJ0XUNgmPWDDuzQ6AtFLLhCnrRHp0VIHAo
	 FKVlq45zty7TiHlvHL4m4Ica46tcxvwnSaHbT0zCujPLFxx0rhVws0BVGeT6bxX1Xfpte
	 Vzwv/tjLXGI7dBOt7ilq1OlBjb6T+Rz7SdTRVyIxZW08qiUymtb1o4yJpgLf3KMNkSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=LBH+URf+;
	arc=none smtp.remote-ip=23.83.222.52
Received: from duck.ash.relay.mailchannels.net (duck.ash.relay.mailchannels.net [23.83.222.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D771606A32C;
	Fri,  6 Nov 2026 23:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D771606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=LBH+URf+
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4BFA6801E5D;
	Fri, 06 Nov 2026 23:54:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (100-99-188-114.trex-nlb.outbound.svc.cluster.local [100.99.188.114])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CE3B98004B5;
	Fri, 06 Nov 2026 23:54:36 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Imminent: 52b676f1385e26a1_1794009281086_2729413475
X-MC-Loop-Signature: 1794009281086:3480117955
X-MC-Ingress-Time: 1794009281086
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.188.114 (trex/8.0.2);
	Fri, 06 Nov 2026 23:54:41 +0000
Received: from offworld (unknown [172.56.210.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4jLwyM55yvz105H;
	Fri,  6 Nov 2026 15:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794009276;
	bh=LEIiF6m5nfC9Ad84lModldGENvWoLDBpFpzsIM0j77E=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=LBH+URf+ZPVacprMvsgY9NpWwYehAO6xrq1xINLH614Tf3RI/FRhPaznfWKKvO4or
	 JAy5o6zsIhcWVKEXWGq2RxS1WKajK1hNytU3LLpDJ44wjEje8lo45KSrvgMM11QLoS
	 xpDLDK5F25P10douOMAuCS0f3JU9rUNbEZYicuVRyfRGZx4ZgbTulMcq47g+StqE4/
	 jmSFF2xzco96xwrpkTZrjxZRe+kvZH0JnqLZ8N4Rd2CSFD45cnBKDmqzZBoyJAPbF4
	 HcrJ43puHv9/zJMnOaSew3ZkS/5fJaeR7jde60i2EP8qbxKrKwetC3tpfQk4KX/Ewv
	 yCzgbvF0rxKSw==
Date: Fri, 6 Nov 2026 15:54:29 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Li Ming <ming.li@zohomail.com>, jic23@kernel.org, dave.jiang@intel.com,
	vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org,
	icheng@nvidia.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl/mbox: Use mapped errno to determine command
 status
Message-ID: <20261106235429.lsdaj4wh6rvam6ng@offworld>
References: <20261103024305.2333508-1-ming.li@zohomail.com>
 <20261103024305.2333508-2-ming.li@zohomail.com>
 <auwI9iLC0NCRvp9R@aschofie-mobl2.lan>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <auwI9iLC0NCRvp9R@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Wed, 04 Nov 2026, Alison Schofield wrote:

>On Tue, Nov 03, 2026 at 10:43:05AM +0800, Li Ming wrote:
>> cxl_mbox_cmd_rctable already maps all mailbox command return codes to
>> errno values. Use the returned errno directly instead of checking
>> mailbox return codes separately to determine whether a command succeeded
>> or failed.
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> v2:
>> - New patch.
>> ---
>>  drivers/cxl/core/mbox.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 55828a836c01..bd91b03c4d21 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -270,9 +270,9 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>>  	if (rc)
>>  		return rc;
>>
>> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
>> -	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
>> -		return cxl_mbox_cmd_rc2errno(mbox_cmd);
>> +	rc = cxl_mbox_cmd_rc2errno(mbox_cmd);
>> +	if (rc)
>> +		return rc;
>
>Hi Ming,
>
>The existing code really seemed to want BACKGROUND as a special case, so
>I searched the history on this one,  Davidlohr and you discussed this in
>2023 around sanitize[1] .
>
>I do think it is confusing and if we can just follow the table codes,
>that would be easier.
>
>I'll let Davidlohr dig in on this one.
>
>I read both these patches as cleanups but no bug to be fixed.

Exactly, the Fixes tag in patch 1 should be dropped, but otherwise
for the series:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

(this patch reminds me that I want to create a cxl-bg-tests + the
abortable bg semantics)
