Received: from olivedrab.birch.relay.mailchannels.net (olivedrab.birch.relay.mailchannels.net [23.83.209.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0282376E1
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698882; cv=pass; b=BLb4Ctc9eMH5gbfdePU+p7txvjSgtq9exsf7GjkUblaYp5DsQRbDZe3f8/UB7Oji5SKrvskYISnv6gf3QAcQEAyhLcp1LSV17JsGxMdPc+3eHVYteklvrvv1KRgs9idqx5z8oD20kz2AgEC6v2stnQ9IKF4dYNlpDEBMLkOKBAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698882; c=relaxed/simple;
	bh=5ekCuOv1Kdb74ALy2BFxpvDG5fs0m5VB7vobm3stQGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjlxh0b451roanfPIjYjVQyPUgD8qxxen1UFhlBOnds8aZwG9nkUv2oTgwLCDGuGxkqDOzX+c7Qhf1vTKzbhW5DqdWdAwJTHt4WipxW7+SjTV6E6qyGA/B9FfpwGbw1uY3p5C9TN3uOYnCW4XYApfHYodufsiSxilFs73V5ifJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=VSbsgQJA; arc=pass smtp.client-ip=23.83.209.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="VSbsgQJA"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0D0F32189D;
	Mon, 23 Jun 2025 16:19:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.108.113.202])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9799D26D44;
	Mon, 23 Jun 2025 16:19:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750695545; a=rsa-sha256;
	cv=none;
	b=bcCROVeDPRw4EIuNDlSTW0yN0GY7zz+LHH4jTHPsYNVD+nCrwqR9dvWAVSz9tUbhIwtcfT
	zwmWPUxgIpnY0mKBCvTcUBeS/kP89b+D0f5t2Psn4FaN3OCZ17itjmb6KDO1D/3gBfHpvr
	AcOTJ1M5uVNPh+8BdY6iNpzSwj44619zk/k+JFSFbnGbrHLSCipoREsUu5OCOWSc+ykiDn
	qMd7BNKC6MigIGN6TYb4kxLHo5xaEHxRFD88YaWNybc7P1nba2DbLLYaEaUjvIe5r9UUvA
	n9bi5N6eJpCLYR/L1MWJPdULnwofruGGUYvKbSVfyUXozz/ygBKqOTmbr7TuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750695545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=E75i9nVELBIoQQ6GizJlLuNofstKQHohWbRDWyMthwA=;
	b=pzwK1x7ZiwD5zJx4Qgi6HpYcGWtI+ks5U2WQ3/ckBdkFZNZGZyA77bMlwn0KinvbA460XG
	KkUNbcM5v7nCZE4u8Xb4yGmgT4eazysXOhYRlRJQm8q5rI1Q4AffBx0eviFtg4FvmBeoH3
	/M4wLoUSQQtRZH+zafj1tZoIBmWjj5VDaDCxqsFz9iaX+QPXy5lLlvd8bDIHAdRZuF3gHq
	Pp9JSaSCZBNK20F//Uoc5MwUPb8mj1FLwZcdMSTuaK1ES4z8gIAyaXBtK21urWL6zh/dvw
	ZZVCVXpCnryXb+mtA5y9XCEalaYXeRI9pvBYsSY0XP9kFEmBBkWUBOTKzaauWQ==
ARC-Authentication-Results: i=1;
	rspamd-6597f9cdc7-v7jv9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Fearful: 290b3201743f003f_1750695545937_360647197
X-MC-Loop-Signature: 1750695545937:1890790837
X-MC-Ingress-Time: 1750695545937
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.113.202 (trex/7.0.3);
	Mon, 23 Jun 2025 16:19:05 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4bQtZ05BSNz9y;
	Mon, 23 Jun 2025 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750695545;
	bh=E75i9nVELBIoQQ6GizJlLuNofstKQHohWbRDWyMthwA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=VSbsgQJANqcqb0vYXoGM7Q1hAZF1Fby83oEBlaQG4HtHKJx6p5KGcSjf0P9P82Yjb
	 6VS0hO5+HeiWq4TYZXdUh9HT3D0EWh+IkJlNy6B15LenCueRiNojjkcdrXz98JuM10
	 IdCG/eXJJGcMVcVv+7BSJh6HegKaTGhDnEwpZWFtE6M2RIowY1L6e/dpmbwUKbJrG8
	 kLO3+ekfYALuQCkXYn0cAwiLZa/QuOB01n3KKAowVbxi8gKQ1WhcgLmPLKXfmv78JX
	 bM5RMEnBlt5jCahEmgrRl3phMEZwAi+njQfZdmQtaWpq/zYiPjL93CFQkGp5FW53ml
	 0nSaC0Scg1oEQ==
Date: Mon, 23 Jun 2025 09:19:01 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, jgroves@micron.com, ravis.opensrc@micron.com,
	fan.ni@samsung.com, anisa.su@samsung.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/7] cxl/mbox: Track background commands from CEL
Message-ID: <20250623161901.icxnhk6dw2eu7x5m@offworld>
References: <20250617193611.564668-1-dave@stgolabs.net>
 <20250617193611.564668-2-dave@stgolabs.net>
 <20250623151632.000070d4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250623151632.000070d4@huawei.com>
User-Agent: NeoMutt/20220429

On Mon, 23 Jun 2025, Jonathan Cameron wrote:

>On Tue, 17 Jun 2025 12:36:05 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:

>> @@ -778,6 +804,10 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>>			enabled++;
>>		}
>>
>> +		if (effect & CXL_CEL_BACKGROUND_OPERATION)
>> +			if (cxl_set_bgcmd_enabled(&mds->bg, opcode))
>> +				enabled++; /* might be redundant */
>
>I suspect we'll forget in the long run what 'redundant' means here.
>Perhaps make it more explicit.
>/* May already have been detected as enabled */

Sure.

>The whole incrementing of enabled pattern hides that we don't really care
>about transitions other than 0->1.  Maybe we should consider making it
>a bool and using
>enabled |= check_features_opcode() a few lines above this.

Yeah, will consider as a post series cleanup.
