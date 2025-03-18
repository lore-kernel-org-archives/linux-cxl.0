Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D2202C5C
	for <linux-cxl@vger.kernel.org>; Tue, 18 Mar 2025 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334153; cv=pass; b=jlF0VaCz1FE6AZJGwYAh/KM4AoY6sUM0mcXt3Xsk++52lpRZ6EEB8oKnDMmkmHW+G21gM/a4+VyOLh8DQvbFfq6C0Y1oh7jPCPnwUu0kT3PKN1cUlwUZP3BA6QnJK4HfrCOHiwptcdDZZaXhXcYhoHHdSkXrDC/O9lhYR1m/QA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334153; c=relaxed/simple;
	bh=rQPIv/xXn1ZD+TcGelb89D2WG5gSbh1uefNP+/WHRZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIHTEhLwCtlMD6mQWH1lN5hBfW55i7G55MlzQiW1HkKQY9mjtJyZw8mAc5bHbBO1+AlRReSTsKXzbG88kfwW3vqMi0Jk80XuaoHfs2G5Nu6kajWjjU61oGZPZxUOrPCsdOacZ6rwUJolbV4at52/dc89HEX/69uoSLnPBmZV09k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; arc=pass smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 339321A45D5;
	Tue, 18 Mar 2025 21:42:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a205.dreamhost.com (trex-2.trex.outbound.svc.cluster.local [100.125.202.153])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AEDAB1A462E;
	Tue, 18 Mar 2025 21:42:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742334143; a=rsa-sha256;
	cv=none;
	b=lFJ+W3JtZmPRaHv6i7+PshFaN6tGGbIO/9tdVRm+5xqBfI4woUFrLBJ+U8XAWwoLTuMoPJ
	bdUTn/BIovjBdtjcIAmirO575mUqeggSLPuahPLIMP4sxhZ7Hn8mbPAGXqrQMhYg3zUjif
	1OYgX0dYXOTr8qeqTc2pyypMNctzpRa18nWb27yG1I98kiw6POQy7u/YvpNg5WTvttFbcm
	ESkTVTL5XawOwkBNl4J+GWHRS/jpqmCA/QA2maf756fOo+wgg2Tj4eS2alt+HJlB+oxsTj
	s8qfq4ClyCTmLi+bCuYuaTyesP4Yoqzo6Hv9nz2nqq7z0y8E99S2ldsQKYbJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742334143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlZh5RenXq6OZhFu9Dii/EDye9jfsp6DU68dClhfiWQ=;
	b=QtiJUOuokv54nkYV2DhQnW7sy3xCPJMmkHzeBtXcKJiISVmBIOhdSIUB3SZE1bAtPwgO2l
	LO90vtTkapQt0G8ZfaHcIRcz52jhUE2J1ZAdf/Yxv005FqY5iLB5/M9rStQEaqoC2Omcka
	ToYHHXo+br47qkMX3L4KZ2GSYXiszlJmGLys3pZKMtoYDgEp80JU6+hIEucLhgIgs+/bGw
	jwiJIchtQVRLfRuZDf43YBidY2EscunrwMOtgPN/em2MP8nqRG/FQ9oIsEaC4RnW8n+VFO
	ZkAsUqqBxacrW2o0MNPhQSZbo7NHidPnR0D5UCYR4086nyrWF+kR17SSq+RftQ==
ARC-Authentication-Results: i=1;
	rspamd-5bd7b8dc7d-rfvqt;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Hysterical: 7a937fae12e84d12_1742334144004_1890217598
X-MC-Loop-Signature: 1742334144003:90561002
X-MC-Ingress-Time: 1742334144001
Received: from pdx1-sub0-mail-a205.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.202.153 (trex/7.0.2);
	Tue, 18 Mar 2025 21:42:23 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a205.dreamhost.com (Postfix) with ESMTPSA id 4ZHQKq23tFzPt;
	Tue, 18 Mar 2025 14:42:23 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:42:19 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 -ndctl] cxl/memdev: Introduce sanitize-memdev
 functionality
Message-ID: <20250318214219.7u3gldsvdqb7q5rg@offworld>
References: <20250318205032.558920-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250318205032.558920-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

On Tue, 18 Mar 2025, Davidlohr Bueso wrote:

>Add a new cxl_memdev_sanitize() to libcxl to support triggering memory
>device sanitation, in either Sanitize and/or Secure Erase, per the
>CXL 3.0 spec.
>
>This is analogous to 'ndctl sanitize-dimm'.
>
>Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>---
>Changes from v1:
> - remove '-s' option and allow sanitize and secure erase to
>   be exclusive. (Vishal)
> - update cxl-sanitize test cases (Alison)
> - update wait-sanitize manpage to include sanitize-memdev cmd
>
> ...roduce-sanitize-memdev-functionality.patch | 289 ++++++++++++++++++

hmm let me resend this. Sorry for the noise.
