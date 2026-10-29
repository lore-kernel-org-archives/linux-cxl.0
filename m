Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295340;
	b=fxo7bWzhEm7ICIp2qSA1mxLCEeDBFP1wn8g5hBFAW1Tiyfy10EKOFM4Yf/Cec0ywj1DZ
	 CHxo8+oxgGuzDB+xzWS11uuuEhMxjP/b4xRNtqngGF4wthGcJSDqYaq816mcH34jOn5XH
	 u7Klfba6cZLtP6C/yE+eYaTvNrmueMvWHxBSWyvkbs3+ETFh+j2rGfh6zkATdE/ccpOJi
	 5itqNSpNApQvEaiQsLalo9ZyBapSZcMqR+f50Ai+5R+znNv4hLvUMaPX1VgCv/8JL2bO2
	 0SZRIPobqTLlaMA39tdiA0cAi4kqp99J2aQf9KOLkKDAJgtkIUN0kiXk2lu4qulXiBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295340;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Unite-Broad:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=+bircFjvmviwpCVkmqAxsi/oMYWfa7HoqnDjH7A6qis=;
	b=5p5IK+SOxhSBPQdPfUStsx37zZn6Snb/pKoex9ZaNlmMIGTRF1iBwJJTl0u6fkkK8RO9
	 +x64zqNlltIWnSczSOpkp6YrgwuOIIDWjrFjmhyTGuzTop0s2gh2KGNU2UjSgJlKCPdH/
	 v54EWGuGmqYwJIN6FNuz3ffZBNCmE78A3L9MS2wz+jOFxmsVCA7OlD5vuR0G+DEiDhzDm
	 lBSqUa9sqbAwX6mns8w1sruMsvkokDOohmJHFv92a5i3CJMEjyTRkC2Y8ujKCtw3N0+Iu
	 4FgC5+BVzJ/6qkgZx094lgvUVupIT9aSXf9dFeemwwePFhKG+6/RnFpWkGTJpOquh2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	arc=none smtp.remote-ip=23.83.218.253
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06B606A31A
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 17:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D06B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2CE52643271;
	Thu, 29 Oct 2026 17:35:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-99-172-52.trex-nlb.outbound.svc.cluster.local [100.99.172.52])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BA7A66431CD;
	Thu, 29 Oct 2026 17:35:28 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-Broad: 22253f3e3463653b_1793295332961_2547424862
X-MC-Loop-Signature: 1793295332961:49873692
X-MC-Ingress-Time: 1793295332961
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.172.52 (trex/8.0.2);
	Thu, 29 Oct 2026 17:35:32 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4jFrwc27lGz1t4;
	Thu, 29 Oct 2026 10:35:28 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:35:23 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
	icheng@nvidia.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/hdm: Account for a firmware-armed Lock On Commit
Message-ID: <20261029173523.c45omstu2ohicxki@offworld>
References: <20261028211836.939648-1-dave@stgolabs.net>
 <5eda91a9-9f44-4b3b-a154-f60227a90bfd@zohomail.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5eda91a9-9f44-4b3b-a154-f60227a90bfd@zohomail.com>
User-Agent: NeoMutt/20220429

On Thu, 29 Oct 2026, Li Ming wrote:
>Hi Davidlohr,
>
>My first feeling is that we should read this decoder locked state
>during init_hdm_decoder()(currently, init_hdm_decoder() already does
>it for committed decoders), so that driver and user have change to
>know the locked bit of the decoder has been set at the beginning.

Yep, I got to the same conclusion after looking at sashiko's feedback.

>
>Besides, I am not sure if ndctl can expose decoder locked state for an
>uncommitted decoder, but I think let user know that is neccessary.

It can't, this is a cheeky firmware scenarios (hence the hacked qemu).

>
>Does it make more sense?

Yep, thanks for reviewing.

Thanks,
Davidlohr
