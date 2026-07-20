Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46931A7E2
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590974; cv=none; b=ds0Xz/jdClwD56e1Ukde7Q1y4UhK1ELxVBSiZbaLdfIltRcZ7tMlUnBOkIN8AiwzTghHZlDdJRgjdS3OaDXslfMc/UWEsWVIgLKLYwf81jVT6hD4lN0xFmgpTHBxavm4UUIMPZYap6Hgi0uu+cydKApdWFDt148h+ROZQ2NVf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590974; c=relaxed/simple;
	bh=/c0sNGSQaDr0zLvwwyVC+RwnDdHSwqcH9LdcLgviDpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOZIFXkMDrziXYCB3AzdDPGPjvctldNTwyr+3xZiVHtEQy5HB+RGD8nmaMyKsh4N1s1hiBSAG+iV/IkQxtAbWm1U/C/9LH7RkR3PHHadr4zFyyPsTeJPh+W296ZDQlwVANGc6jF4pHmey7w9GHBU0fcJz+CGtL+gjVClkuuU9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ZrMKD36p; arc=none smtp.client-ip=23.83.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ZrMKD36p"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BFE8F4C0952;
	Mon, 20 Jul 2026 23:42:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-104-253-237.trex-nlb.outbound.svc.cluster.local [100.104.253.237])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 58F3D4C1079;
	Mon, 20 Jul 2026 23:42:44 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Relation: 367eb78547b43b37_1784590964425_131921293
X-MC-Loop-Signature: 1784590964425:732101614
X-MC-Ingress-Time: 1784590964425
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.253.237 (trex/8.0.2);
	Mon, 20 Jul 2026 23:42:44 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xrz65vzz2x;
	Mon, 20 Jul 2026 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784590964;
	bh=/c0sNGSQaDr0zLvwwyVC+RwnDdHSwqcH9LdcLgviDpA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ZrMKD36pKn0r3b1OmHb9tjYbPi8MmqsFCwll9Pg6Vg22tqR6LAg/6jpd4lbABwxPZ
	 NKAH1bgUU6OUoykeavCRhS3FzC5TC5JYTxNcNFqUfgbof1YRFTPpttUU+1Zc5bgoYi
	 4NnWa27rkkVHv5riFoOuuVD8MlkCZs96ZdjXDBmvJ2g/bsshGRtQqpWYgI29BphSFE
	 16I/mCsFtyJjt52FIlpA3Rnhw0nZihni+X08LWg8/ItPA3+fnCFJXTRZ0+CEacoLmm
	 aoyOoLMZsqEp6Jn6CZXndsEhvfio9eqdSLv3bknDbUH0b7PxHC1qlD4zDY1PCOOEDh
	 T7zOTZBmhLVmw==
Date: Mon, 20 Jul 2026 16:42:41 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org, mst@redhat.com
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/5] hw/cxl: hw/cxl: Host-only default CFMW
 restrictions and per-window options
Message-ID: <20260720234241.zugypuohzgdve7md@offworld>
References: <20260720233242.901544-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720233242.901544-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

bleh sorry, the cover letter subject should say -qemu.
