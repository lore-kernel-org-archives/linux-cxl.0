Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B128469C;
	Tue, 10 Jun 2025 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592861; cv=pass; b=i306ZyATWdITha3AEbbI+XbLu9ChKoCdklYSapQumkNMAdi90k/Nqnec2Kal5wvcNEp4UZJiNkMvrYvkP/cIDbTtDZxaqGz4PFYvRczi+kAzMZnqGIQC4uN8Rxwb/O2mBQ+O0H5TB7nopoT6Md0gbfHFnO07NfyHUARi/sOpnJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592861; c=relaxed/simple;
	bh=dIbNFft6CaYTMLr+91ryBglJuKP2jhFXmKg1aBJZ8vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCTrteZP7k7Nwfd6G4ZOPpiq1AHu7sYZnhNxee+4vL+CNTJDAGZF9CEst6AP/Y8rFwJ/w3CGYFLQs72/neHHV7GDGiuPoZm8DXIUvRKjap3RWPMMtMFNG9lDxmG2GvCrLAVN/r/NUEQ9r3yJ8VRJXZPWBococUaI5rE3M3EvrKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=BUOlSahf; arc=pass smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="BUOlSahf"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 89AA62C4F3D;
	Tue, 10 Jun 2025 16:25:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.119.143.12])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E50E72C5598;
	Tue, 10 Jun 2025 16:25:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1749572702; a=rsa-sha256;
	cv=none;
	b=KB0W8msBHstNJ9oBJ9BFRev/hfSHTRlLy5Sa/i0534dU+lLw8xGLGPdibtBUn2Da2O6Imb
	X7HDSE50ChLnoShxZLQaVyGGbnUI1wSUlAbKpwYXK8b5PNQWej2yhBs0rOfD/eV30BkXsd
	4R1u2eZUXMoWw2J7RDxozIYwKCt4UmDg3MEqDH4jF1CDfmyucZKa1PD9dD1c/O87HoQUD4
	Om3C9VFTCVzpLMi5bbGsdqo6KCMSLIb9IAFlLbSiCVhrrbt7pp5MIUlDAAK4T0GZrxfdTN
	7tg9H0tqLRa/T8eqCXmAqyiacNL7CkCkpkLibMhpDe3DZ03enkXWYehxHgVi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1749572702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dIbNFft6CaYTMLr+91ryBglJuKP2jhFXmKg1aBJZ8vI=;
	b=RdaFcVFR1K5pEo6opZwgLv1akYVFpi8jfb1WcXKNqwqd7nxlAxU+GfMo3TJiXPR7s2JRhY
	7o/IiLwaauVswDhXHJ4fLtrt0AFyxaD05q4o1UDJYFof1COeVS9/wdXIUO8bXnI1NgaZEU
	NI91p2Bu02EHj1WoSPys5D2Js0XaxwapSrlXy/977jQUpB3QG6sfF0knLCDc8KgyrC9Fqs
	Z2zWq71/Xc4iibwzN0sn17qofs+PxllVTcSQI0Wok7Ggge9ZSWDF5KSmFtpCJ9090mw6RR
	tbW5h4bNwTLvK+uA17Xno2GvZrpUn6EZ39miKMJAxa8RaKkEQdhaKdv8IFdzPQ==
ARC-Authentication-Results: i=1;
	rspamd-5674bcf875-gcbmk;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Society: 54d24218127b95f7_1749572702295_686142442
X-MC-Loop-Signature: 1749572702295:142634956
X-MC-Ingress-Time: 1749572702295
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.143.12 (trex/7.0.3);
	Tue, 10 Jun 2025 16:25:02 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4bGvJs1l23z4x;
	Tue, 10 Jun 2025 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1749572701;
	bh=dIbNFft6CaYTMLr+91ryBglJuKP2jhFXmKg1aBJZ8vI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=BUOlSahfn2dlJpoN23ujgzyYTnEPXa2Q9+/1lWKciIhYHyBflU8CdErXNFy9RgbfU
	 l9nTVYIAViuYzNejlkoaxVEV5XmaHdDU7WUK4egEuSQ1u6nDV059tUhgH+MAUdSGz9
	 uu/OisbFV5jnRPd2nzI5toMEeG8Dg9paW1T0JtnT7vrUzj+TbJKRghGBbfleFMnBTg
	 y/XACTSxTu3YudRmuhlKnUR201IWMNpnPRHo0nMw0V6P2kPPlUKJpVnUGj1yeK1f6O
	 jyKRVSeUEnbSj9txcw6pBD9osrMcYaVRhjQi9Sr0iRrJm1lNiQt6cbhW2f9ffZ12x3
	 cp3/Y65W0oLRQ==
Date: Tue, 10 Jun 2025 09:24:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] cxl/Documentation: Add more description about
 min/max scrub cycle
Message-ID: <20250610162457.suqmw3bawg4n4zmu@offworld>
References: <20250603104314.25569-1-ming.li@zohomail.com>
 <20250603104314.25569-2-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250603104314.25569-2-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Tue, 03 Jun 2025, Li Ming wrote:

>user can configurare scrub cycle for a region or a memory device via
>sysfs interface. Currently, these interfaces have not enough description
>for the return value. So adding return value description to these
>interfaces.
>
>Suggested-by: Alison Schofield <alison.schofield@intel.com>
>Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
