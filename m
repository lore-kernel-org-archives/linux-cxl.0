Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCA71FEFA4;
	Wed, 23 Oct 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726735; cv=pass; b=mxKYk3i9esQIf/Fu3HyZ3NNqu+/Tg+3XoEQNOj4eDQdrB3VeXqjPD0CKczZIzm8ZIs/rQiMeuZbU5PWpIDMQIJEvoAPd9FYwZyQ7PklJbNbllSXGjsykTvRSdApaIeak0q9cstsM0JcZFK6u09t+ExMl4FEKCscce1EIv4U5Dpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726735; c=relaxed/simple;
	bh=KFOO68DlNvKj5mCTkKTiIn8IF4tVDRLM9Jqu//LVK+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyrPmazOoyGxGw6Pwqs7NnJVlOoxyWwLs2yCkd8MsHaoHBm8XJ036h/0fWu5Y4g/wo2OwWsdAeIzM2NToKGPBZBciWN4QE+cQFZZvVKO+AtejvN2aKSuI9tKg7R7Giw06CgdhipXVw33uOeUIV7S3Vxnu97LRQW0Rsb1xmLPWyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ArhqnrBw; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ArhqnrBw"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E8D6380A9B;
	Wed, 23 Oct 2024 23:38:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (100-99-209-54.trex-nlb.outbound.svc.cluster.local [100.99.209.54])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6811580253;
	Wed, 23 Oct 2024 23:38:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729726725; a=rsa-sha256;
	cv=none;
	b=WC/bB4t04MYNGHHov9NeZunElGUf6uqElBSt04MAw76sdxE+Jgf/BzIR4WAp9Lc4unwqmN
	JPY8yzeVKCvHob2IzL4bpOgnXCS0IIcHEnT7X26t1AXopxcM1+iulq/ZQLQtXjW3HH2Ep3
	DvdNtEsACTfFf+p2v3ZdvGBobMax5LVoSmeC/FN2eb0S9RLtibrocS4gBMTtGQa3K4UHso
	HZoxDHBUBQw1cNcaWY43JZ/+CDmTwa3/RiglBJdpIfwPVtoqmqw0FECiIfun8MMg0HnkxW
	lMjZLIpGU3uJn5FHCdPlc3schorfID/iO3g7fAnW/m48q6YLBJo9P07q54+phA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729726725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2nSvvT+ozuQhD9gVxonB1GXT6CzOfiUqScJawcHHKmQ=;
	b=KkEGXeHnY1QXsvlEWncmhIbS61mKRI40PyvEZ+PMIIvUuHkWPcIQ7hoNeGFoEhOz/pS9zR
	yjBW3ngdRM95AY2mmyW6wOiwje9Z9/TawMolU/WKx/fQKhOlAM2BQx+vdMoQAiS1yBgzWw
	t/zIrcQEFBfY1lTZE586jGeCYKxNlLKmchApqIHQup1vvENoPNbpT1UpQAkjg7S93d6+fF
	JWIzLsYv+8gvsXihNh+9JXkcPM/b9lSO1tw026FunAtmjsdhEpYBo8kHM7yAIiQyGEents
	GDbNplrBpgepwLjHUNNLHxrH2ZX1VzmLaWdBCAjrBI0SLonPTA7R+CbeVC6t4g==
ARC-Authentication-Results: i=1;
	rspamd-7767f6b98-kcp28;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Grain: 4e6f5f2623663543_1729726725804_1213636018
X-MC-Loop-Signature: 1729726725804:3303723294
X-MC-Ingress-Time: 1729726725803
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.209.54 (trex/7.0.2);
	Wed, 23 Oct 2024 23:38:45 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4XYlqS2pvMz9v;
	Wed, 23 Oct 2024 16:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729726725;
	bh=2nSvvT+ozuQhD9gVxonB1GXT6CzOfiUqScJawcHHKmQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ArhqnrBwTF9zg9As/DY7XiMlJeSlk1WWxTYWaku2SOC6nDnFSjOQLnhijp4tICvIB
	 UkcVQzyhQu0qnl5PRqEEec456VVW7HYVwXoxR0LF2AIklse7Yr8BW3Rk7lglltY9MH
	 COuegRVurmgLiPYRVHiLMNv4qJbeHq3YfvNic3vpNoVvSGE/fHmEsXEcuCEEQ8BtnL
	 p026DhCAt5NhmFLkoI8zPfJCjNcMNTTYV9jYefnm/DEVmQtwQz2PZkLORT9rYmxu7M
	 mtw1HuBAtxtOWO3wjbut5Z5CgSpNXcBn3UqUB469J3MMxLjdvBA2XN4WnvrqVvaKnu
	 NJwRk0LaEu8tA==
Date: Wed, 23 Oct 2024 16:35:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, 
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
	"alison.schofield@intel.com" <alison.schofield@intel.com>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, 
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "fan.ni@samsung.com" <fan.ni@samsung.com>, 
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] cxl/mbox: support background operation abort requests
Message-ID: <vtj5cp6brmyvqut6xaxo3vfgnidvzwxr4kv6ofuiimcga5dyke@ts32khqtmexa>
References: <20241022031809.242591-1-dave@stgolabs.net>
 <feef15c9fcfd462e9b3cf614a1b4621c@micron.com>
 <zrmn3j2wzzlnzzwunk64xfy4jussoiek5ro73qs3yrjqflemtz@zbn53a27tt6y>
 <d4fb5d07a2994f6b9b36b1ee4c7e6563@micron.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d4fb5d07a2994f6b9b36b1ee4c7e6563@micron.com>
User-Agent: NeoMutt/20240425

On Wed, 23 Oct 2024, Ravis OpenSrc wrote:
>The one major functionality in our original proposal apart from implementing abort is
>
>Allowing background commands to be invoked from user space through the primary mailbox
>by ensuring only those background commands are enabled which also support request abort operation
>by checking their individual CEL details.

Is vendor-specific logs not something that can be done OoB?

If we are strictly talking about CEL details, yes this series could use that, and was
planning on adding it for an eventual v2 -- ie: why send the abort cmd at all if we
know the current one doesn't support it. But that is minutiae, for kernel bg commands.

But yeah, for your needs, the enabled cmds would need that filter.

Then with that, would adding something like the below address your needs and below
questions? Basically, if userspace is running a command, then the kernel comes in
and wants to run its own bg command, it will simply abort *anything* ongoing as a
last resort. And since we have no kernel-context about whatever is running at that
point, is *think* it is safe to assume it was user-initiated.

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7b0fad7f6c4d..bf0742546ea8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -374,7 +374,7 @@ static bool cxl_try_to_cancel_background(struct cxl_mailbox *cxl_mbox)
		mds->security.sanitize_active = false;

		dev_dbg(cxlds->dev, "Sanitization operation aborted\n");
-	} else {
+	} else if (atomic_read_acquire(&cxl_mbox->poll_bgop)){
		/*
		 * Kick the poller and wait for it to be done - no one else
		 * can touch mbox regs. rcuwait_wake_up() provides full
@@ -403,7 +403,9 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
	 */
	if (cxl_is_background_cmd(cmd->opcode)) {
		if (mds->security.sanitize_active ||
-		    atomic_read_acquire(&cxl_mbox->poll_bgop)) {
+		    atomic_read_acquire(&cxl_mbox->poll_bgop) ||
+		    /* userspace-initiated ? */
+		    !cxl_mbox_background_done(cxlds)) {
			if (!cxl_try_to_cancel_background(cxl_mbox)) {
				mutex_unlock(&cxl_mbox->mbox_mutex);
				return -EBUSY;
