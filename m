Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738779;
	b=bPASK4VhOIL9zaMlNnCefzPJBd7ihZHTzw6IPDZKLKQXv7j7OmelZR7yQqqDnyweG4pR
	 D/WE7vto+LELlvbv0BHaY41ZnvbwaGJyXsn0t4o8AomN7/GZx18ARiU1gtG4MyKGx61IN
	 ZMoJqG5o60BRBG5PgB7WzHnFZQddZAwMSA2Gv/7Njys6TbL7HNay3x+vJSi8ReuvblDaq
	 cfc1kUAdy9B9Dj+IZhSVjGZFfQsMAL8gGwj6mWJ/xNKbwpb1/UD6WpP0QrRo4kqB/y9Ag
	 fNtBcMB8vcZGaaIONh2buAHf4Oc0s3xxp/T1yh4vG5fZMW3H1xqg6iJ2OYtMYaGXEKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738779;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Company-Wipe:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=jIU7d709b3DCMTX3C9XJdoZqLQtxTHIKdqVtHcC1xIE=;
	b=zMi6UJRM2fTB8kpnNWh6j5HQ25m+4crhjqYbHCqF0Z/obE08gCfmPafdfXWPdqXqM/B5
	 6xCYZm8PNLLGP5mUoWEIy8MsH3QmytOSxPFsvuzXLZu47Q6qUNn1eThauqS6YdAdRVqsW
	 nT1rezJbhNCzIWqm4Oi0nPUAaYlNpsz/cpbLmc+fmMA4B+tuvkjSaHWXnzHN3lxVSPHy6
	 PpY4U4ZBclXfNCm8g1pqdTWMSrGczFne21Tm2QY9SQ+LMzkbWKqOl0YehpG8eNy4w5umK
	 Y7x91xGUSum5zlnd0Mzpw27FL5pwT+XFceSvGjveYbVZeDC0HdjLPgZwJb6Oj4uLTgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="ZkVoq0Y/";
	arc=none smtp.remote-ip=23.83.218.24
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1241606A31B
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1241606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=ZkVoq0Y/
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BF79E9430B0;
	Tue, 03 Nov 2026 20:46:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (trex-blue-0.trex.outbound.svc.cluster.local [100.99.198.86])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 59212941F73;
	Tue, 03 Nov 2026 20:46:10 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Wipe: 38a4697b7f5f457d_1793738770569_943858695
X-MC-Loop-Signature: 1793738770569:682477327
X-MC-Ingress-Time: 1793738770569
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.198.86 (trex/8.0.2);
	Tue, 03 Nov 2026 20:46:10 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4jK0wK73ryzymg;
	Tue,  3 Nov 2026 12:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793738770;
	bh=jIU7d709b3DCMTX3C9XJdoZqLQtxTHIKdqVtHcC1xIE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ZkVoq0Y/0CDTP5YEDgp+K/wFLm+J6nmTBQeX8jZgX9bNGJRChLCWfLtmVBO3rcDUf
	 g+++ZLAXa6yUdUoBGSrGX7UWbhuByoYl0av+3zSd+y5aeL5LQbbJeRWWTsZ4XYNt8j
	 TsWhj4a03v7sZOc0PGvRd2WGWggX0Edu3aulyzh5gMb9ke8+OIQ5LnIZbMKCAb0tPw
	 hVNUNNzHz/m5DCfSvZlE39ogc9Jx2odqPWLZQKy2yY1KUXyczEhxKMv+FJ2uKtsPy/
	 DanAKEJicGps5Pcn5TMraDuF8fmVoi2O/44xd++kfRUPXpJaEHVHJI6XP+7PgPrB8G
	 zeLrGNLZ08A/A==
Date: Tue, 3 Nov 2026 12:46:07 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: sashiko-reviews@lists.linux.dev, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v10 04/10] cxl: Add HDM-DB region creation
Message-ID: <20261103204607.xybp5dfybdu5tlip@offworld>
References: <cover.1793567979.git.dave@stgolabs.net>
 <187374442f21d6cc52ec6b9e390550db198f05c2.1793567979.git.dave@stgolabs.net>
 <sashiko-outbox-192709@kernel.org>
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
In-Reply-To: <sashiko-outbox-192709@kernel.org>
User-Agent: NeoMutt/20220429

On Sun, 01 Nov 2026, sashiko-bot@kernel.org wrote:

>Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>- [Medium] cxl/acpi: cxl_acpi_cfmws_verify() rejects Host-only + BI windows on QEMU 11.0+

We already decided that the check stays.

>- [Medium] cxl: stale cxlds->bi state on reset in cxl_region_decode_commit()

This is mostly benign, but still worth a fix, see below.

>- [Low] cxl/acpi: unreachable third coherency check in cxl_acpi_cfmws_verify()

I've removed it.

[...]
>> @@ -346,6 +363,21 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>>  			cxled->cxld.reset(&cxled->cxld);
>>  			goto err;
>>  		}
>> +
>> +		/*
>> +		 * A reset after the check above wipes BI Enable, but
>> +		 * cxlds->bi is only refreshed from .reset_done, which may
>> +		 * not have run. Ask the hardware.
>> +		 */
>> +		if (hdm_db && !cxl_bi_decoder_enabled(cxled_to_port(cxled))) {
>> +			dev_err(&cxlr->dev,
>> +				"%s:%s BI disabled by reset during commit\n",
>> +				dev_name(&cxlmd->dev),
>> +				dev_name(&cxled->cxld.dev));
>> +			rc = -ENXIO;
>> +			i++; /* this target committed, so undo it too */
>> +			goto err;
>> +		}
>
>[Severity: Medium]
>When a reset clears CXL_BI_DECODER_CTRL_BI_ENABLE in hardware without
>.reset_done (cxl_bi_reset_detected()) having updated cxlmd->cxlds->bi (for
>example, during a concurrent reset before .reset_done runs, a secondary bus
>reset that does not invoke .reset_done, or on a Type-2 device driver that
>does not call cxl_bi_reset_detected()), doesn't this leave cxlmd->cxlds->bi
>stale and transiently commit decoders before rolling them back?
>
>First, in the pre-commit loop at the top of cxl_region_decode_commit(), only
>the software flag !cxlmd->cxlds->bi is checked rather than
>cxl_bi_decoder_enabled(cxled_to_port(cxled)). If hardware BI Enable was
>already cleared while cxlmd->cxlds->bi is still true,
>cxl_region_decode_commit() programs and commits the endpoint and switch HDM
>decoders in hardware with CXL_HDM_DECODER0_CTRL_BI set before catching the
>mismatch in the post-commit check and rolling back via
>cxl_region_decode_reset().

The post-commit read prevents this. A reset can land after any check made
before the decoders are programmed, so only reading the hardware once a
target is committed closes that window, and the target is undone before
the region is ever committed. So a stale flag cannot commit anything with
BI.

>
>Second, when the post-commit check detects
>!cxl_bi_decoder_enabled(cxled_to_port(cxled)), it does not clear
>cxlmd->cxlds->bi = false. If .reset_done never runs, cxlmd->cxlds->bi
>remains true indefinitely: back_invalidate_show() in
>drivers/cxl/core/port.c continues to report 1 while the decoder is attached,
>cxl_region_check_coherency() continues to allow attaching the endpoint to
>HDM-DB regions, subsequent commit_store() calls repeat the hardware commit
>and rollback cycle, and cxl_bi_release() attempts to disable BI on teardown.
>
>Should the pre-commit check also verify
>cxl_bi_decoder_enabled(cxled_to_port(cxled)), and should cxlmd->cxlds->bi be
>updated when hardware BI Enable is found cleared?

The first, no - per the above. Only a read once a target is committed is
conclusive.

The second, yes. This can impact the sysfs 'back_invalidate', for example.
I've folded the below, and in addition sprinkled READ/WRITE_ONCE lockless accesses
to ->bi - which while is a bool so no tearing, readers run under cxl_rwsem.region
and the writers under the endpoint port's device lock. It does document it and
potentially silences kcsan. While I couldn't get a kcsan splat with the
code as is, I was able to artificially trigger it in a tight loop reading cxlds->bi,
so it is best to have these.

@@ -374,6 +374,8 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
  				"%s:%s BI disabled by reset during commit\n",
  				dev_name(&cxlmd->dev),
  				dev_name(&cxled->cxld.dev));
+			WRITE_ONCE(cxlmd->cxlds->bi, false);
  			rc = -ENXIO;
  			i++; /* this target committed, so undo it too */
  			goto err;
