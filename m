Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E132BF51;
	Wed, 11 Feb 2026 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770850463; cv=pass; b=OMjBs7RELFAJHIpeMQAo8GApJ7AeEY6YrZQ6AstEurAQpWT9/Im+LIKUnOrYucb88P2v1QqEvz8yBF7pUYV2kcHiAYuofOT+er5yUSSnU/5kcbVoBtb8DkI/B2PwBXOSMBr2q8X+6ldRBTvulzgMC2AxcoRhVKn8EYeiqc/GxI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770850463; c=relaxed/simple;
	bh=b72hF6OyyXoE6DDy5L0JDupxs1vq3duhOLVtf8mt3AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwA4iEUnZsDY+MMouMBe9wAqPwJNvyEZSDDM+/5qSx/uW5Jlq91Y2X5xXUgaShsS/2dRRKhV1zlCoA1KXU7088oxSjjhMaUJnfB0TOHbOEc+FWgndaHM+zYjOM+XTd3aC8sAA6s3Niq+NWDoa7p32rsTDKGo+peuoYVyIsu3yLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Taw9WlbD; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Taw9WlbD"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 82A7E161948;
	Wed, 11 Feb 2026 20:59:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.101.114.146])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 156E2161884;
	Wed, 11 Feb 2026 20:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770843560;
	b=l/vG6Vn0TliJX1WVF3RSWis42RwqleVnIqE6YfDsV++UykcqYw30xlcMNTSdzDOTs05bNT
	EiG4X4BjL8AyJdeOq5+09YEoiiClfMcIt/86tCmVganbY244jzupiCs80oHk1wqyZAO+Yd
	swekqHueaOjXfmA6SYe0dUVCZWB/ONZN7FyVnueA1i/CJOYIu5X29uETvb+w2qP+987EmD
	zs+6Mcf/dhqhYBlhslvogrZ49I1hOs15vRBePbNH5oM6btOujTAIANJNudS+N/Ph3jMQpY
	E3ZuiQb8QwdPv9owjGK1FnFTlCHykEr2rM9NH84+0JpVxfq1PgfSacqzdBJFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770843560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tu+4LNB5SwtQx3gF/sNS4g1nykO+ebDT+7ad3yIOlOc=;
	b=o+Wwgab1jQDC+JP4vme6aVV9voom6ObJn/2iRneNqPzZAZ4QCmTMpUZ+2IFzLYVE2tfTRd
	mKB3R2TB46FakjD7Op3jPsIrYkUNRKZ3tStnoo8HejtoRtT3UetaPT00kCEhbue02p/389
	6oieL0Gw/0iGXbO6MvDADePxu4ZmuMl/RiY5FLON7CDsD8QJYxgKPNMgLTQFwBfbKHb80X
	+KHrz70wpw0lAfTf1U+9eMH0BZ49hdsj6YejJ8Nsur6NfLFHZkJOXtUd3v2ZxUAsn/C9C6
	bfE+7UYMvt7sb+ZUZUtxbMCx1GHr4lLK00y1YnvO9vjZvvc05T6r/k7Ihvxpaw==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-fgtcm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Language-Hook: 53475a4d047458cd_1770843560365_2613431788
X-MC-Loop-Signature: 1770843560365:1493895934
X-MC-Ingress-Time: 1770843560365
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.114.146 (trex/7.1.3);
	Wed, 11 Feb 2026 20:59:20 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4fB9lq34l4zT5;
	Wed, 11 Feb 2026 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1770843559;
	bh=tu+4LNB5SwtQx3gF/sNS4g1nykO+ebDT+7ad3yIOlOc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Taw9WlbDe2VpEDfPNjkqu/IANwjJ7I0MnddbY4PiVzea58uDUPF1W8EdPWQgP7GO6
	 Z9utIkXb5+RtHVVhQT1/48FNRLi0LoesfHarN+8FY8GoqH6SmqESH2gwP/llo1Pk7t
	 MqSm+k+KwLbi1JsrIKorqbGAWLpWnGmLMic+YcY4IyXC+JjwMUWpG8pKqSi7saJeiV
	 bMkkrRpeEMv/OGaMiPw8eANU8rfvLlYEO7cPH1B1w70QABjJG7KIG08RBmZm243ZBy
	 Z/RIpRMH6I7EYqTNAexjTVlba0zs4e4v/TOazx4b2cakqAPheTON/M6d1yr/gDZKPv
	 lmvwmSaVvO9ZA==
Date: Wed, 11 Feb 2026 12:59:16 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v3] cxl/memdev: fix deadlock in cxl_memdev_autoremove()
 on attach failure
Message-ID: <20260211205916.fmmld2ifc62cl42t@offworld>
References: <20260211192228.2148713-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260211192228.2148713-1-gourry@gourry.net>
User-Agent: NeoMutt/20220429

On Wed, 11 Feb 2026, Gregory Price wrote:

>cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
>and then calls cxl_memdev_unregister() when the attach callback was
>provided but cxl_mem_probe() failed to bind.
>
>cxl_memdev_unregister() calls
>  cdev_device_del()
>    device_del()
>      bus_remove_device()
>        device_release_driver()
>
>This path is reached when a driver uses the @attach parameter to
>devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
>DVSEC range registers decode outside platform-defined CXL ranges,
>causing the endpoint port probe to fail).
>
>Add cxl_memdev_attach_failed() to set the scope of the check correctly.

I preferred the "if (!cxl_memdev_did_attach())" but the below still
reads nicely.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
