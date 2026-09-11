Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA19453A5D
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159863; cv=none; b=tZKmPzQw50AkEPD/tumf4t6MWasZnEpMAu5zf2SvaCiq43307bTF+Y+aap7DXQXqt02nRCSAdTU2Gx4V59QM9tfN2+Os177nZ8aqS38veJx+Tlmrd5d6ic6XJYvU5Ln+JA9Ysz/wtBfeQRtsr18eLR7ywGJiYbTogzbprEB/pEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159863; c=relaxed/simple;
	bh=X0US1GqkpjmIxTg3oEdXxT+DG99WsysJ1ESqR7oEgaU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=r4Mdu4UDGFYKXiVr13VKWqk6uvOVyY9qETJCaDDCAxMCvnQPmCSEshDty6DqEtmftRzeu0YR5Ge4XvBtka2tCIsXRoC4F9CqY6wk5/kvE+q3Fa4K2SsMUP9VegP4dYa0H70XjiEbhJVJ9z46acpO8hApkCQb4iY9mz6ecNk5hgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=m5PzMBmo; arc=none smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="m5PzMBmo"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3E7F07E286D;
	Fri, 11 Sep 2026 20:50:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-98-23-230.trex-nlb.outbound.svc.cluster.local [100.98.23.230])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F41057E2AB1;
	Fri, 11 Sep 2026 20:50:43 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Soft: 07a29058713f0d75_1789159844103_120681674
X-MC-Loop-Signature: 1789159844103:4080844667
X-MC-Ingress-Time: 1789159844103
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.23.230 (trex/8.0.2);
	Fri, 11 Sep 2026 20:50:44 +0000
Received: from pdx1-roundcube54 (ip-66-33-200-4.dreamhost.com [66.33.200.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4hhRX34z4Tz105B;
	Fri, 11 Sep 2026 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1789159843;
	bh=mvtQWjNiuptQvVl4AO1dWtDGfLrI0BPIu3RFh6+XXSo=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=m5PzMBmoAUPuDuJxyoN8FG1CtONZZnGPDfl7oA6AhYm8bjpBBLMjcf0qHUZ2YXLp1
	 bky1y+ppEmVj45dgzTBD8Gkg6yzJqTMEvZcuiMXB5BZAlxp0wEcwFO5Vf1kWhm/Bin
	 SMDv+cfjm9lKyVisbhWmjqYhApWR4bnGdOkf+ZOkDbkcT4f7EMo4/BqgTnJEZzBR0X
	 wYXpVQ+XZ+BALG+lYiFFbhWCJTP3KmfUyafkV8fljkCRhuQuRY3DJ+SE0ceeeYvjkH
	 SgJtc/9MqRRE1St7Tz7jL9hCiCGb+hho8EKGGF+iaQt+qLIhNHMWd2qxqtDXsxS+z1
	 9gg4WIJkU7Y1w==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 13:50:43 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, jic23@kernel.org,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, benjamin.cheatham@amd.com
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA partition
 layout and ordering rules
In-Reply-To: <aqRmqRh89HEtlWS3@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-10-anisa.su@samsung.com>
 <5bd5dbd90d5029f92232d8b8f18318d4@stgolabs.net> <aqRmqRh89HEtlWS3@cxlqual>
Message-ID: <359d6939623ed64ee17e28a9fa939c46@stgolabs.net>
X-Sender: dave@stgolabs.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-11 13:38, Anisa Su wrote:
> For the maturity map part, I have another commit at the end of the full 
> series
> that describes how DCD works from extent record --> dax device
> creation/tearing down, so I could update the maturity map in that
> commit, when DCD becomes functional.

So if DCD upstreaming is going to be multi-step, then the maturity map 
should indicate what is there and help users understand and set 
expectations.

Thanks,
Davidlohr
