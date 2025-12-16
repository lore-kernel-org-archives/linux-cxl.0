Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41351C8E6
	for <linux-cxl@vger.kernel.org>; Tue, 16 Dec 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765847549; cv=pass; b=OONQnU3xlTZU9dGj2jdr6/+jVvU3QVi3b69EMPiB7FMZXBuaWrqazC0yzPhdpIRUkyA5MkFPW/3PiUwMYS4DgnyoDwliaYd4Cw9aGDYrJIX429cnx1rbZLhItLEBrx/AkFOBc6eQsMlC0LLyxFW5j4cysygO5Qp04j6Xh16uvQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765847549; c=relaxed/simple;
	bh=27X+0lsG8lLYVdgLxuU9xn6aGmW52A2UJLm2XZMWYgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN649/fKMuwFc9iKmfrU3zsNq6dgQDMY23XPuI6EymXp+zwUt0Na7+rn3s2RAMTA/v4SPXYU8DFrpGFebWC8MTVnzX4nXtCfzIml0EpDQHVMFYXyicgQG49yCICgLeTLnT90cT/Io0P/xgEmCwn7qEFjb/gKw32zW3m7SGg/31g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=jjql1rs+; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="jjql1rs+"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 968382221C7;
	Tue, 16 Dec 2025 01:12:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.108.184.183])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4666F222170;
	Tue, 16 Dec 2025 01:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1765847546;
	b=Fd2uTwQakHWywm9oxgWURUQdg4gGjh2s2GdFj5vd1iWuD5wnC1kovR9zXcxKZOacYpa04U
	8zVDKYpkv3VCVE6glWv/nAjqrZu7LIHx8ji0A3DKF7fBoQe6i7+eJBOBgZFNH6W0dV5tU2
	B3BDNFC4pPb/Y1RZ6+swJGzbJ9+zxKxjYLr4cNEMG72yL0Of8OPVmGQuLYGXQyzh661dVc
	JUmvtlfaAEpZzO5RBFIabLHWmzTRczMBT+dy6gD0LuZpJWmX9mRpr0SEmXkiCcg2QACayh
	BoYIzRXc48lEIlblqVDsUrQCVE06GDmvlOtvhh0bi+fLQLWAE4Mc6SGIHAWUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1765847546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=27X+0lsG8lLYVdgLxuU9xn6aGmW52A2UJLm2XZMWYgQ=;
	b=HyvmrIS5iQvIpAk8d29svDh0tJIJ9PirD/LGH/jxZiyzHOEgQEzBanXDmEePEZUILNuggW
	iY7xyCmxrxvz77u1T7r9tr+2jPnsEajHW1STslBqCqYdoEeRhmd91P7RVfx+cgR7yW9nif
	PjxGmr5tSPTNeSocY0ZvrdftdIDKlqKzix5GsZNFniOCENcnx3t3awzftZvQHr+Yt5wqMF
	llxz0+d3Gqg1TXpUaIlDLf5sTzcoQrwfh4Rq21CVG+oH5LjDxFPWr2QQ4vy+YwaUWF3zMO
	/TBrxjGrj358jZ7TAJtdqjq9yfZGaZEIVecBMapCIAtNu2VAJi2jUS4/ruK4Rw==
ARC-Authentication-Results: i=1;
	rspamd-6ccd5b4cc5-9bzp5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Chemical: 4789de36710ea059_1765847546497_4048344186
X-MC-Loop-Signature: 1765847546497:1204676025
X-MC-Ingress-Time: 1765847546497
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.184.183 (trex/7.1.3);
	Tue, 16 Dec 2025 01:12:26 +0000
Received: from offworld (p7838222-ipoefx.ipoe.ocn.ne.jp [123.225.39.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4dVf6c4HyczyrD;
	Mon, 15 Dec 2025 17:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1765847546;
	bh=27X+0lsG8lLYVdgLxuU9xn6aGmW52A2UJLm2XZMWYgQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=jjql1rs+KG6Clfi1YAZ39wF9MauIGiT/HQIJs4XmMnShCvWx1w0nOHBcMhW+RUsDa
	 3Xg0dpSm0GWFQFsiEUk3ryZWwuHYP8W68Osw/xW+4mX9SrwL5taiAni+gJo64d1bLZ
	 0ZMGTmV+josVFyJbGvtK/VMcTVyE+xv4RE7Lc7cx0bfDAp/GuKOpE1Cc4ZyeIo3zm3
	 4Uwm4OxU2OULqiyPbuqGeXxczLlbiljbSsPZVn7qf4RyxyQZaVFhUAAJBwW3E0fL9g
	 QUe1RXZTp+IWn8nFqozDMqTotyFKYh3E20w2TtznKKhLktFLqf3/W82eUoAEZeTPeR
	 l1BcQQoShRG7Q==
Date: Mon, 15 Dec 2025 17:12:11 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
	dongjoo.seo1@samsung.com, mst@redhat.com,
	marcel.apfelbaum@gmail.com, armbru@redhat.com,
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20251216011211.anwnw25ot6n3euhq@offworld>
References: <20251103195209.1319917-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251103195209.1319917-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

ping? If there are no further issues, could this be picked up into
your jic23 tree?

Thanks,
Davidlohr
