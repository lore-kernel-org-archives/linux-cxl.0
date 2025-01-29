Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918114C83;
	Wed, 29 Jan 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738163398; cv=pass; b=OQt17CeiLL6h5VxuX0Uy+X1KK2CR4Q2rIpMWRW/y+jLmu6aVEjz49TDWiKmLrAlzZ7ej6I0cFn5uOxQuias7y9qjk92yC2eUjCfOfwk17k/Hw5epZQZleOinAzMi2dRkoUyJshRhjyfJeH7+bN/su/qlTFyiiIF6DoK7VQ/Su5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738163398; c=relaxed/simple;
	bh=KVZuEZOEqrl+x9S9HAJjGoL4xZ6gpIQ4fq2iNnPsVys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYmlpd1cSX2Neg6ckTK5imDhg0M/bE8sA8MNathGVy+FWoqX7jZRRyFHsYcHMcVGUYcZlf12NmeEZ3quPrvXok4gpAkP2CoCQbBR+0NU9jQqAr1TfAIcxpp892BQMn0f9/8/KYUnUHBIKJUnCzLYIFQhZ2KcySHq0l9MC0uwsr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=eU+Mh4ax; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="eU+Mh4ax"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 06D9A2C3D43;
	Wed, 29 Jan 2025 15:09:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.116.71.244])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5B2542C3B3A;
	Wed, 29 Jan 2025 15:09:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738163389; a=rsa-sha256;
	cv=none;
	b=YbcBFZzxdLRwqNWr3BAXBd2FhaQBSPl18+k8bkrhugcWrWGKnwMU2nM3V4M5M3VfzjJWo1
	QdGo9akkSzW5qNIlUhOdeU3QgSkojVYdjeET1LaqNcqpii1DOlgBYcdAEXok3FDkwjOOCZ
	3W3idRL8qGclEtQNLGpFhC8gY5eCyjsMpgSl49M5I8qXfZ4CfQaMc750L/qJOX75T/obpY
	uEuMB9WNNmyqCx7yHIt9dGJa8xCI5PysWCJU8I3NsUbi1Qy62bv0mtyT505INoUv6PB3eO
	a7LQ2LyEaKW2ToFGhvkjWlYMjmUqHo6eLxeYrROfuQZqdWLelRxD6TXzL+IEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738163389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KVZuEZOEqrl+x9S9HAJjGoL4xZ6gpIQ4fq2iNnPsVys=;
	b=He//S/Dd0H/bbswDsRwnlF3ogc+3yEaQAJLqWuFSAvV5UEc1QCFi9LAz4jxc3HDq4gG82L
	gWDsyGShmghNUmF0akcxEcGcHOaHFMNjTn4LelSmOwkJhTDk00Kk0+fLm0sE3KE+F7yhtZ
	lZPJ7/F1aYyQN+PXaMdtLrqUi0suwD52MA6VWqmJ1NI4y2pMdfhcj9KfgKEjlNFuuEjVNY
	oouXupmFbcJtB0+80tYGQG2xRls1N4ltrcOL4WR2Ac1edDLVu3tYk/jrS8a5GoVDSPgBA6
	c1EM1jOeqrKxmmaxVU+9/nRdXKSSnWGKDC3EmuueHX5qqplS4H/9AB8PJy4DCQ==
ARC-Authentication-Results: i=1;
	rspamd-7f8bc4ff9f-gvn84;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Quick: 3fbc8e9912f56a4c_1738163389682_1346255113
X-MC-Loop-Signature: 1738163389682:1473457761
X-MC-Ingress-Time: 1738163389682
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.71.244 (trex/7.0.2);
	Wed, 29 Jan 2025 15:09:49 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4Yjlv04BQTz4F;
	Wed, 29 Jan 2025 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1738163389;
	bh=KVZuEZOEqrl+x9S9HAJjGoL4xZ6gpIQ4fq2iNnPsVys=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=eU+Mh4axfwwj+QWLt2izfwzNmrJuEjLSSwsPUKhx1kEXaTks2M7ZW0qnj2x8vTmRv
	 nsroTpS8rg4OjCs7kjSyXVHPZevd7Dcqwj3nz11Mr/4GThDcbvpnpMsBz2dqii0lOl
	 tuygnz9J2c/UBc6MwdGyQJQ3znh9izstaNeBHFxc6+EECjrbj+9H6DwZerat6nhTLi
	 CitBwv0IIBZEsehqK/0IWkrAnkdUjjxO9elYi5HyB3+27EFu5wLzjMtIyL9masZRVN
	 PBjA3aeF9OgKK7zsMScXApbwaiIJYQg7wsPhHoLQJVxPNOHvPAaddBzRW1LgEiyazE
	 NdhyeVq9NsjJg==
Date: Wed, 29 Jan 2025 07:09:45 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] cxl/memdev: Remove unused partition values
Message-ID: <20250129150945.ozoqocgugn5vapy3@offworld>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
User-Agent: NeoMutt/20220429

On Tue, 28 Jan 2025, Ira Weiny wrote:

>The next volatile and next persistent values are unused and are
>cluttering the cxl_memdev_state.
>
>Remove these values.
>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
