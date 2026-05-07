Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690C3B7744
	for <linux-cxl@vger.kernel.org>; Thu,  7 May 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156950; cv=pass; b=fvDRF2Of03mcVZjtgv40OhOdzDeeKsG+XSQlyClx7a83FNLbAJ0M/qx09hlaYvuZKs8BUd8zrV9kb4XgOJZ1g/JSVDcDSA26z98jBZRV8LgRCztDPXwGfK3moeEqBmlSqlUmtH6hAOaMggIsDA+iCKSccRTCLuUG4awbizPyLzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156950; c=relaxed/simple;
	bh=HeqJ0aZAJGZZY7NdLUBrGus1WWOvl9X+lQzi2xjLLkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwwKYW9jzRuOxDxDcviFlF4C1C3ofKq6wUcijxAU4S2VTK+ma4N2D5F5l+qimDQ5gPuuZxtAdyIEjvDTRzrdNKsrXqyF0iRDrtujQKPWrufcskuIWS3075TE/zsSDvfINWZFuB/zY3Qswb5hjFFsQFUiFW5h6EOMMgKDWeKHzkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=AXxNgcn8; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="AXxNgcn8"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A7B23641F37;
	Thu, 07 May 2026 12:09:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a253.dreamhost.com (100-98-10-198.trex-nlb.outbound.svc.cluster.local [100.98.10.198])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A8B15642152;
	Thu, 07 May 2026 12:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778155785;
	b=2rExssuw8ZOjpa0WrZvnUjw/C/hQzCUcIhIODF0NqAMKQTu/5i/eGRwx4rJguTR8joOcfe
	WvsqVuJrXZ2/pGHwsKKqLdrWzgKlNHjWhqGV7bIyhyYWtOAIdHFvgS1NgAVZxowEP+6LiT
	aWdK+CgYnBPIGlN+xtY1WWhemDHwpRbjicbTl+MuWz4M4ooC4jO7Niz9HmIBtdWLk8VAWY
	/dzSTgLjTGxk267KqaTOEgo64JzzBC68T5A3ncmcnIH+ECi56+fRpRe7EMoXl05NYGYOn7
	eZ6iTIIPNqvIuW4hVHOok94IVr4MKjH/nt1Xxw/XdrPmDwYEajPu6w4nSIbzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778155785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HeqJ0aZAJGZZY7NdLUBrGus1WWOvl9X+lQzi2xjLLkg=;
	b=EykVSS7qFada9UNqjfTuKHA0BtF4X3IDnqaRe23ivd8wd6Hii5/wKVegX1SQDRrhOKiuyL
	4WPbwp8qUFYP+Eq0w9OMdyfJcQlApwY6omslZVXy7gIX3uqU+aaFERdegq+HC6cpqNcMCY
	SIjXlt0lgjhsW9ARb/0oIQ4sjwbD5PzCXYoBTibEdIx2SXIvp5aGrHmxe7sHLaUJw9/ao4
	lHiSvRI6zJ6b7NZvfB1cbt7f6fgQPqdwSQAuBlySEC7LcUqxE96zJFjCqqIYhhj8T0Qtqv
	B/x11VubcBPZ1jwjEXcjMPl8far7zJP6ykK1E/PwjX7AcwfFNy3Vb5zeUCjfIA==
ARC-Authentication-Results: i=1;
	rspamd-5c5444c55f-75gt7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Oafish: 4b7ab9c22d0ca9ba_1778155786502_1000765668
X-MC-Loop-Signature: 1778155786502:4226656728
X-MC-Ingress-Time: 1778155786502
Received: from pdx1-sub0-mail-a253.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.10.198 (trex/7.1.5);
	Thu, 07 May 2026 12:09:46 +0000
Received: from offworld (cpe-188-129-77-158.dynamic.amis.hr [188.129.77.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a253.dreamhost.com (Postfix) with ESMTPSA id 4gB9zW3ZVBz106N;
	Thu,  7 May 2026 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778155785;
	bh=HeqJ0aZAJGZZY7NdLUBrGus1WWOvl9X+lQzi2xjLLkg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=AXxNgcn8V4wnu3aSQqX3ntXS8qPqvhSnznd+frhW/bUJyVLRPL8agzfuOsA+eJ4qD
	 RGRRbF+wsGAp+E8ft7E8s6MperNe4BtAStG9e6uQlX7iuAqqye5doaOM2uP3X+I+tG
	 xVXT+K2xQsIlSYc7dLPuGWeBR/p3rETMqZClN46TiTHwKPLKZ2J1pzZn8eewZP1AdE
	 wsPtoG0HArmrP1tgj8auLfQ7uaM1weqRrMnXvl/mfnvyAGs0NGvvfQGMCDluzBOixe
	 K0qxg1ziuUnkgWEiFpzs0iqNCxTPTixxgMWuigHMKgldRX9VTfdyXcL+kcBNZjKbIV
	 4RMZjFTx1kX0Q==
Date: Thu, 7 May 2026 05:09:38 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <djbw@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>, ira.weiny@intel.com,
	dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Support Media Operation
Message-ID: <20260507120938.yyfn6hxjobr64xa7@offworld>
References: <20260428200410.705675-1-dave@stgolabs.net>
 <1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
 <20260502193429.hztbijgv3bjwit5k@offworld>
 <9f73073f-09f0-4e08-b1d8-746be33fd674@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9f73073f-09f0-4e08-b1d8-746be33fd674@app.fastmail.com>
User-Agent: NeoMutt/20220429

On Sat, 02 May 2026, Dan Williams wrote:

>However does userspace really need to pick ranges? Would it be sufficient to start with a "sanitize / zero all unmapped" semantic to walk all not mapped DPA. Or perhaps a "sanitize / zero on unmap" flag to the decoder to make it similar to a storage "trim on delete" semantic. The nice thing about that, you can defer freeing the DPA until it's clean to avoid reallocation races. You actually know what you're zapping because it had some recent prior association.
>
>Otherwise I do not trust the security properties of policy wanting to clean a DPA range but an unsuspecting thread can race to allocate between lock drops. Looks like a footgun.

I agree that this is much better than having the user explicitly pass the range.

As we discussed at lsfmm, for this we will need to move to the asynchronous bg handling since we can no longer control the size of the range.

>
>What use case is missed with a per decoder automatic cleaning on unmap setting? Zero before map policy might be nice too...

Agreed.

Thanks,
Davidlohr
