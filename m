Received: from cross.elm.relay.mailchannels.net (cross.elm.relay.mailchannels.net [23.83.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D42F12C1
	for <linux-cxl@vger.kernel.org>; Tue, 16 Dec 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898707; cv=pass; b=egA+zPwMrMcTwLkLFZ4jaKYwtQv1bf1weyD9oLCiisazbXHrN0dMF/pB+D4Q6BxknrPxg6okhU7CmTt5LKdLNR5Lsx0lbpgCKtYHtmUX6PjdCmPAnBhLOLKCBUI9H+pCf/wGZaPECeZsQYCnAMpozJ5GTiIUD9+m9Xjp9oNdsr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898707; c=relaxed/simple;
	bh=hCCjvgenz77JUeHhv7Xih0uM29cppVmyMSbt1yWmakY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsF55Xznh7XOkcZ1aIIkfgzgSH+IsGBwTfiCVJzIh5H6c+IXTta7fPdCcLBvS6/PvUZxQkwMmfdYrbv+XHgeGtyJyIGB44xETuqhNIuuo0qfyGokiBUvv8hUhQI28jTfh1SUF/HkCbUMfEqZ6KZ461GvIv1vYbPFp3iSbjeACk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=q3xv1VoS; arc=pass smtp.client-ip=23.83.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="q3xv1VoS"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AF794161525;
	Tue, 16 Dec 2025 15:24:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (100-103-169-129.trex-nlb.outbound.svc.cluster.local [100.103.169.129])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 63F60161D72;
	Tue, 16 Dec 2025 15:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1765898698;
	b=+FFLEATeKvtx9uMf9WDlQWZtIoThhsuW/cWSWMuCxj5SiBj8vsgteVG/RH5R5stEsWgmCe
	YxddGBLB8BpHpRPwBnXjtZgEJxUQHvT9hxgu93EZxLqvtRPMMjr8sdrzvpB371vwiY/tT7
	Es8EmECoCWXaMOpVue7XH/AerJIrZ+zcbTs/bbZwp1g/fxBolEDvCl8caloKUwMY6gztzp
	A6nOJFm/5ZS0zGSzz27e+2hdMgQie4iLzhw6ywdQ+eDWe9enQKvvT9zVisXNH+v+dSx8gM
	oq5zKpL5mVvviZHCIiDAYc9i3SJUeYI/Fw1FhjzCJiy22m/DbfByk6r3wgjcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1765898698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=V6cZ6hVfzbwD0/szhv0n+m7UeoPuCzz7r4RjXAaVA5g=;
	b=jzCK7ZJYdIxar32KGty6fkRgG2GaT+mG2GpnM9NPH76nniidV02O1IeynuNweZeT2ITnGi
	JOqiWDVuLGS01kdiE/fhIGsw2nd75OSmyXdoMqbG1Dzwa7mnbi2Sdf7FzxGl/7UrLGjc5b
	tvpnAzcWBF4kpmmtQr3YyePHrI5mfvruvD4uy7MgGu0IGO3OGR4IkioTH8ZE/3E+7VgvD2
	V4+ZSqZIS+ZBtCLboh7AB2tNTHQuJ6gMSeq3FjF1G2Ze6YdRcbjYr5wiVm1Gmlsr5sj4nQ
	3piE1nfFSLHHbXpa9J3N0cgr4CnkgHPXUzMEw0dCK1UHm6g4DQFXdq8VKwdlVw==
ARC-Authentication-Results: i=1;
	rspamd-659888d77d-4crmn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Bubble: 55f6989866ea5fff_1765898699456_3183201204
X-MC-Loop-Signature: 1765898699456:1131494184
X-MC-Ingress-Time: 1765898699455
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.169.129 (trex/7.1.3);
	Tue, 16 Dec 2025 15:24:59 +0000
Received: from offworld (unknown [205.220.129.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4dW11s0lfqz1066;
	Tue, 16 Dec 2025 07:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1765898698;
	bh=V6cZ6hVfzbwD0/szhv0n+m7UeoPuCzz7r4RjXAaVA5g=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=q3xv1VoSocvjp4cr4gvq5+vyjvzd+7Ko1SItkU5jmyG1MbobTMVeJzpfdNo76kZCT
	 IKUtI8f63uMp4LlD3I1OYcz9Gp1xGDiWjjQ+B3h8AjEtV3wazdr3VEKsp2Vha2rn4E
	 orPZOQLSZYC2cGbrfYC4+lkTtEx+BLMPLxXATHHzQzvmonABo+ry8RCP+3yr9t4Y23
	 BgL3duuy0cyRivj5/IHUl/Ep2VDuVy1a7w/XygS0AAowlMPGERhPimKB2BrzZPqYSe
	 2Xt7Q8WeJ2ugh1n4ZGqU1R3JM0hJHAARigCjl0fNCYhoeY5OUBwx5jyjb3Wq+vxVQQ
	 NOQE/lmweNlfw==
Date: Tue, 16 Dec 2025 07:24:11 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Markus Armbruster <armbru@redhat.com>
Cc: jonathan.cameron@huawei.com, ira.weiny@intel.com, alucerop@amd.com,
	a.manzanares@samsung.com, dongjoo.seo1@samsung.com, mst@redhat.com,
	marcel.apfelbaum@gmail.com, linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20251216152411.mlx5tgsdwnjss7ku@offworld>
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <87cy4esysa.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87cy4esysa.fsf@pond.sub.org>
User-Agent: NeoMutt/20220429

On Tue, 16 Dec 2025, Markus Armbruster wrote:

>Davidlohr Bueso <dave@stgolabs.net> writes:
>
>> The following allows support for component basic back invalidation discovery
>> and config, by exposing the BI routing table and decoder registers. Instead
>> of going the type2[0] route, this series proposes adding support for type3
>> hdm-db, which allows a more direct way of supporting BI in qemu.
>
>[...]
>
>> Applies against branch 'origin/cxl-2025-10-03-draft' from Jonathan's repository.
>
>URL?

That would be:
      https://gitlab.com/jic23/qemu/-/commits/cxl-2025-10-03-draft

