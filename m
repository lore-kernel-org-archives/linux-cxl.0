Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B4489FB0
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991690; cv=none; b=Q/9gMzvkfTvHYa0+3Avlna/0hemW1B19hCHZEkxh0XYXWhTKjCEk0us9V64478N1Fak4kj55C9E7o4x3orqVvp9aDcWpBrJThiwuvxT5N5649EfmVh0E1HoZVtQO/WhJpAAtCjmHov0wveRFjuGZaytHVx2kOuhNaDE4Z41zCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991690; c=relaxed/simple;
	bh=+ECQnQCAczn54x2og0FLzc41pRMj0YayKrRN8XKNw+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeBY20Z7pBr/ONQ0bFPy0h0a0rKlsSACnCMB/oWA5Mmc3Te1D7rrddQrGb4oQ8iZXSuEGPAFnMt2nknUtrWvt3GX78ZCSrdOdLrQmccIr+BeCPwj+mB3wfbBRIzzNuGm7g0E6F3H8zgWK9STPqmo2UmZPb7HQFJ6NcU5HD5jtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=TivwGIYf; arc=none smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="TivwGIYf"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 53BA44C1E91;
	Wed, 09 Sep 2026 22:08:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (100-97-105-60.trex-nlb.outbound.svc.cluster.local [100.97.105.60])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1FB3E4C1CF0;
	Wed, 09 Sep 2026 22:08:07 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Broad: 75e76b1e1ee16be6_1788991688176_1219922788
X-MC-Loop-Signature: 1788991688176:3517061876
X-MC-Ingress-Time: 1788991688176
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.105.60 (trex/8.0.2);
	Wed, 09 Sep 2026 22:08:08 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4hgFLG3s1Mz2T;
	Wed,  9 Sep 2026 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788991686;
	bh=tIN8/PLQ55vtg1c9HjKHqgEUUoviuZ/yfgPDKCUAEo0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=TivwGIYfIxB95QqCGRxiZFKjgLlpvXmyyzSf2EtkbcpLnWtJ0QjnJlxLdGZSyYzMu
	 tjpejTrpYiRO8mJCFmult5Olk32VNhSqZAZTP+Sg+LjOq/954eBp87qK0BocEGC4RG
	 WtZydSePo9Gie0M0Y+eizcBYRX+rv5EachJC64x6jm8spZ0yH1HRAcCFbGRloRVPlV
	 WlxCtDHiVU0hBSimsU5WAg2q89dK0u1VT8oH6LC/hZoPaJWZ4EHIfJUDIoe9AtTNUt
	 oJalAG3ytVrZQvl/5UcU4lc/JeOwv1qLkuCfv7RSuijfaH0XiZXci4cEk7FGLh6kaT
	 nvJENGBH5QRrg==
Date: Wed, 9 Sep 2026 15:08:03 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 09/10] cxl/test: Add mock BI topology support
Message-ID: <20260909220803.bb4hdfcc5fghe6lw@offworld>
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <20260909170302.1550680-10-dave@stgolabs.net>
 <20260909224909.44e9a9c2@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260909224909.44e9a9c2@jic23-hlaptop>
User-Agent: NeoMutt/20220429

On Wed, 09 Sep 2026, Jonathan Cameron wrote:

>Another area I'm not as confident in but seems fine.  Needs more eyes
>but from me.

The qemu flavor is much more robust for testing, but with Type 2 support
now upstream (and with cxl mock device support) this was extra motivation
to test both types with HDM-DB.

Similarly, I also rebased Ira's old type2 support for qemu and integreted
that into cxl-bi-tests infraestructure. So that exposes type2/3 BI on both
mock and qemu, fyi.

Thanks,
Davidlohr
