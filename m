Received: from insect.birch.relay.mailchannels.net (insect.birch.relay.mailchannels.net [23.83.209.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5340855
	for <linux-cxl@vger.kernel.org>; Thu,  7 Aug 2025 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754527524; cv=pass; b=BbcnaNb7+K9zajuNuCqJL3yGeb6Dk6Vn9XdNj1QrH6klQmQ9gYuKfPQ4goQgEDjDlINSaLaBqwUxdDq4QuJ9YGj8p5oX3ZCODTiEkOlrCcOUi0+A28isZAYWWWcsTcdN7SjUpd2BFMfo+K6tX6KLbcY7vKTQIzqaSnKsMpZtCtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754527524; c=relaxed/simple;
	bh=0xZNOJxx3Mj4fdrStA2ZaHn4bxNWK+vyKBILMaa5Ec8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXKpPskwQgxs8COqtIR3xTpn6Wb75kCmgjFcjtPDsO6/WuqdHae05dwzUN7/b36agamzVzH8W+NBnaQIk3SXYs43bhwIt8JyhtmbKnb7+w+u0YpL2K45UmwzYQw/xshT93LWvh28KwfaVzlFB+3zwCu0fgajr5oLUaOMhn/jlSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=JyUSpzjk; arc=pass smtp.client-ip=23.83.209.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="JyUSpzjk"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C65B31A5024;
	Thu,  7 Aug 2025 00:06:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (100-98-216-71.trex-nlb.outbound.svc.cluster.local [100.98.216.71])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 56BD51A4DD7;
	Thu,  7 Aug 2025 00:06:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754525193; a=rsa-sha256;
	cv=none;
	b=wKe4hBTT/6o7ZdgUirjUChtfmEYLEQOcEeu7tzmTNkONMIFDT3sY6AvgnmPfSOaHKZ9h63
	fyXZl/D0pJMNeev4eKjYRBLV8IH7A/LCFU1uFeE0l0EtJMtcCFJY0J2l15dI87okjHp74X
	zMsjPJZ+K+Ixl2T601yU8Can2IfwJ/bXfTjrvtRXKKVfTNROJJMiQHfeboaFMhXDfBWFvu
	3WLkFf+zBCzjlKOzpOpX2ZJfluTUZGgrEmGDgVHMgarffFXxd0OoDNz3cSkgpxbiFzqpBo
	DfkAgU/MAYrvr/fQgmXVkFeViiUGCTPOse1By60gsuxuGcE0xJwHHUdpsCoKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754525193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lC+S+PMJ0IPLx3hpttP4fsD+ikeDBNPckxX0HDz441I=;
	b=m2H4hsz6AFWCYcjBtmk/IPxhqFvkWbkwnwyFLlO85mxSW/7Gb8kINDxzjr3ffIpqCBcrTK
	GLh+6PmR1BJiWRgNSpjcE2QzgN0AtPS7d4BZ8JNp+yIhPz45IJ6+GfAC7WmII0j7+Ql0lu
	HUpVSoy8n8+vRlTP4RITHU6/daKBZdjNLDVqNJjwcaf5/7MfxMfQeTixRw6EeenhDpvLf8
	nFZcw1uTzPw+R4CdqS/a8swqFSjPgBs2+6KD9/SCv5kE2dl+ZEgXvy4FL7XELFFjtFX0oK
	hpFJJUeH2KMAZdGn99HEA918WkS8dqB7QE/68n1CpIAyHuoqa0HsCmdhBXqz3g==
ARC-Authentication-Results: i=1;
	rspamd-565df7d78-rkwqc;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Bottle: 6e5936080bf291ed_1754525193604_1346270259
X-MC-Loop-Signature: 1754525193603:634501519
X-MC-Ingress-Time: 1754525193603
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.216.71 (trex/7.1.3);
	Thu, 07 Aug 2025 00:06:33 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4by6s45jSYz4w;
	Wed,  6 Aug 2025 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754525193;
	bh=lC+S+PMJ0IPLx3hpttP4fsD+ikeDBNPckxX0HDz441I=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=JyUSpzjkAV8zv1fVt7e+S3xHg5yS4W4UbslmT17xiWzCzqlEVjXsLCgxM2yMhdE1O
	 v4P2Do564v90Ndp6iJ+DtY6NEUlvVT5j0GOi+V01vFS9LS3R9BC+SACproz5Jh1hu8
	 FXjlavz6CX+fG2JmfdeWxRQI5MRUQ0jXCbpwsaJoTo4Iv3ymM0tWlmDFaIKQZ9jaAs
	 MIMjdehoh5iOHXev7DuNTn/hp4QEhxzTkjyVMUnEOr1PuBWD5CElaEKq42KCl3Ak5H
	 1j1hm77ZM+RhJq2+HgC1Qa2hqmVv7Fr/XsKdsBHQdeLOS00LhfQyfGSci9hDtKl5u4
	 oEWB6+g7qPeHw==
Date: Wed, 6 Aug 2025 17:06:30 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] hw/cxl: Allow BI by default in Window restrictions
Message-ID: <20250807000630.w5k6kzc3sahup6vr@offworld>
References: <20250806055708.196851-1-dave@stgolabs.net>
 <20250806055708.196851-4-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250806055708.196851-4-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

On Tue, 05 Aug 2025, Davidlohr Bueso wrote:

>diff --git a/qemu-options.hx b/qemu-options.hx
>index 1f862b19a676..ef6072bd8b59 100644
>--- a/qemu-options.hx
>+++ b/qemu-options.hx
>@@ -142,7 +142,7 @@ SRST
>             -machine memory-backend=pc.ram
>             -m 512M
>
>-    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
>+    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity,restrictions=restrictions]``
>         Define a CXL Fixed Memory Window (CFMW).
>
>         Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
>@@ -168,6 +168,8 @@ SRST
>         interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
>         4k, 8k and 16k granularities supported.
>
>+	``restrictions=restrictions`` bitmask of restrictions of the CFMW.

hmm so there is a doc build error I missed:

qemu-options.hx:212:Block quote ends without a blank line; unexpected unindent.

------

diff --git a/qemu-options.hx b/qemu-options.hx
index ef6072bd8b59..da642642eafc 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -168,7 +168,7 @@ SRST
          interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
          4k, 8k and 16k granularities supported.
  
-	``restrictions=restrictions`` bitmask of restrictions of the CFMW.
+        ``restrictions=restrictions`` bitmask of the restrictions of the CFMW.
  
          Example:
  














>+
>         Example:
>
>         ::
>-- 
>2.39.5
>
