Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3A2F5302
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197128; cv=pass; b=imY4DKn19hr1iYQqVfawLxdIGPn6DWve7NTkX0jMkgeNuwGCZefwja9aCuC8HhsfMocwtREfJ9AqzAwbwQpX4vY/EAKL9qC8ZhfTh8m4CTsV2uY4TcGy4dse4dPiJLv+R7nO9gUEjtRIP/H+dcJJHFGGiX87Ihnd0xdBe/vAGnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197128; c=relaxed/simple;
	bh=AxMb4RVyeQDl0cQwfhSnSUnmdUivkKYIfoAcWMSUOr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXPMFWaUP602HnFtKVKIPN0OGM1yJaURMhhF3NzlRECjTSW/e5Zdeq/CXXItOuNavDhsKajxZamYiFzwcrfxfJOGhRhINwRzLmOJq2LrtHyMJxjcqPj8DsSZ/uuH8RXoub2Mhaisz62H3RsQuq+TrD+ciO9eftg20hlRzNtW1TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MendmnNW; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MendmnNW"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A6D742C32FE;
	Tue, 17 Jun 2025 21:52:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (100-122-29-47.trex-nlb.outbound.svc.cluster.local [100.122.29.47])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1BF682C2FCD;
	Tue, 17 Jun 2025 21:52:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750197126; a=rsa-sha256;
	cv=none;
	b=pqfCPwSu58XrIpVtfIANSxySJTPIENlJIIIk9SrON3CkIJnWb0rqLTXPzVEhf7B6iflK4P
	DcYc5GYpVJak1EC/g7OBLp84+OFo7LW78B6Wn7c91Z8BrTe/mmtR2HZAiK+WYhGjI/zMP/
	fe34/MlRINQk/D9ati8rvbQBhVCkbKfuKIBWEByGRRW6pX4TWCz56KOsEFWIYYZ9I/rHL3
	V+0w1dKsaN3Uay79chjrOMfcuNtd2LwJyUIP6NbgSSEvt9YBz90RCMb9hs0iu661HitiCD
	7HovQqa3Gxq0nIyZwWir+bactgbDVbQ/7Ei8+r3RBHprS/BSPtqXB7jYglvIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750197126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AxMb4RVyeQDl0cQwfhSnSUnmdUivkKYIfoAcWMSUOr8=;
	b=jJjer3ngZ5l3OxUNfAM4dJY62K4eWQmbI4JZXOtzq8OIEPgyeJXjuiCKbyhfAbVU9OMHJO
	QCAheBeZinTTe5OwDefj3nPiOYKFvFbehnCiKx4J6y6OAV9ju9r/qjJ8b9lCcxGqgy0WQs
	N9afOKBsgq/rBOv3R75lIgjrL0NmNlgVK8YYxsMhOozewDhETVvPPYUDcb43arcyGuS4Md
	1cRD8l3xFEMJs3RffKTB90YsGWHIOnd3frgiQdxUl7jdilZmdhbRs6m6FhAytFHeiyXGPI
	x9aNOXL1zA4x9Px1Drnm8BPyA6aFM9Wg4Rdi/WWAAgYtn+CnhO7KN2nKojtGhw==
ARC-Authentication-Results: i=1;
	rspamd-6c978647c4-rtdl4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Broad: 03b22b22278f6250_1750197126465_3527817378
X-MC-Loop-Signature: 1750197126465:339537686
X-MC-Ingress-Time: 1750197126465
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.29.47 (trex/7.0.3);
	Tue, 17 Jun 2025 21:52:06 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4bMLF04p4nz1P;
	Tue, 17 Jun 2025 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750197125;
	bh=AxMb4RVyeQDl0cQwfhSnSUnmdUivkKYIfoAcWMSUOr8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=MendmnNWdGGh2pcDwzfb1k79uDs9/DvQ+TpFEPTXZNHmCEEOG0QQhcOTfWdg7BW2g
	 jCPCw5gen+54SIQ+ca5UwVUoADqeNTtn641J0TkbwQ/02thicm4Gc6qhmAxwvW8mNl
	 VASsQjHOtg8xKgtamZI2SQHfgpmsJcaRTlK8tu0ArlcO3ByYRSCvjjFqWYMkr/Mbeo
	 0lnAfMvTURwJdN7rId44yFUOBXkMNmwqMrm7MvnMhjaoEzRWbzqLdR01K7BaB5Tch1
	 CkJI88k59sjQnVN55dcTdQ8fP54f/WsIVZE4laXf9p7/VWtdbFxBd8M/mqAuHw0KPR
	 pVovdcNHlZJ4w==
Date: Tue, 17 Jun 2025 14:52:01 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, jgroves@micron.com, ravis.opensrc@micron.com,
	fan.ni@samsung.com, anisa.su@samsung.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/7] cxl: Activate FW and userspace bgcmds
Message-ID: <20250617215201.jyah2f7r5jcs2vhg@offworld>
References: <20250617193611.564668-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250617193611.564668-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

On Tue, 17 Jun 2025, Davidlohr Bueso wrote:

>Testing has been done via qemu, similar to the previous proposal
>(hacking the code further to disable the userspace only policy).

I should say that this fixlet is also required on the qemu side:

https://lore.kernel.org/linux-cxl/20250617214832.579960-1-dave@stgolabs.net/
