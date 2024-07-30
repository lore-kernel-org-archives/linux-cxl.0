Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4215FD15
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jul 2024 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722317090; cv=pass; b=DlOIfs6Q9ighIeHvubR21iwv54KHTHr1fFWxwWfNPuGUVG0sjKXyRu5lvBJT3uQyWa0dlctkPXFbxdoxyjUOHEBKW6llSuD7OWZW+WbjMP6U/xuyor0rYPHP2TlW0IXaUH7wzsCWk0OEyOrMIIpDvJxdTdaXFu2/rwagzpg/37c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722317090; c=relaxed/simple;
	bh=P+8K2Ya41MwbnllKZe/XxYRRMM3JxZbJausKOqLFzdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbDctUlk4N7K0nXDJYWZ8o2bvwpCy7ygd+UDLt/+A8soKh1+fND/eHMah4pmk4/skSYYOE6zC6dftuHyirvgnBUEpZd8sjME4B5Hp1bRPbtC/cB4vhVMIpVx2pMbjwGh1xTDDyGKz5UDMLqsyC0l6uKV9FGycVwZd32q9U4PwOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ZfcdIWFb; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ZfcdIWFb"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9C0E180465A;
	Tue, 30 Jul 2024 05:24:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a211.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 12D9C80520E;
	Tue, 30 Jul 2024 05:24:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1722317082; a=rsa-sha256;
	cv=none;
	b=S4OiNgnmjnTfbdVSjJBAz0uzhbMUhzKMf5YE9bVbkuHkFFoggEhLEPwqFkzImps5Jt9w2H
	+kM3ne8+rv3wIXHEA07fIsaBp55ohLbHyPKl4gxoKQX2MBjzTKnxzE+KJS7wUR/H8uj1SK
	KMk19RkMfTPc2RkuU4ji/8EVQAFaDfrBMkc7F+5fekngom22jhEOrF0VAbcTp4MKtwONhV
	K9Iq50AzTuCx8UQt+gaerh6Oq3BUzPxZ22f3Vw5g6TnOtzAy2nmwHSptUzXEv1vaCy5LnH
	KVIJVIkQotJ5DmFmSjerbH+LI3ljgq4RXru4iOup7y0KFPm0P5I/2TfqfF4gOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1722317082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=P+8K2Ya41MwbnllKZe/XxYRRMM3JxZbJausKOqLFzdU=;
	b=wn9LuDlqoSjhkRzwbI9C27AEY4PExQTwwHlOTNlChQrmlGs4rYfkS5GPoEuLdzkgXprkXe
	khE8l4u74ooUXGOShXeWST3LakntrpWtbKBIunM3CtJvnW3UvRhQRWaTNAVg2PVSSs0gEe
	JvL+4QvZ8rvP2WLJ725XDUe4SITeNtuJG/HGIasYjyR2D0/hGuS7yczdDYmIFnDiOB9+56
	CMAwGkihcfL8YseHeRx3xHFoX1LxUTt6jVHwtCDyI+a8j5ocfLc9/qXeN77nKBjuDSOEc7
	v3pezIhjs1WiB/Zw1l6A+2q//ZQRyZwb1/uj/sVCkYQzoojoQzIVLBRZ8r9JtA==
ARC-Authentication-Results: i=1;
	rspamd-7f77fccf7d-q2sd5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Spot: 56fccda32f31cf06_1722317082529_4276875075
X-MC-Loop-Signature: 1722317082529:3149186005
X-MC-Ingress-Time: 1722317082528
Received: from pdx1-sub0-mail-a211.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.213.80 (trex/7.0.2);
	Tue, 30 Jul 2024 05:24:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a211.dreamhost.com (Postfix) with ESMTPSA id 4WY3ZK2MvZz6J;
	Mon, 29 Jul 2024 22:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1722317081;
	bh=P+8K2Ya41MwbnllKZe/XxYRRMM3JxZbJausKOqLFzdU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ZfcdIWFbrRyi70lUwD9SsFs74aBcKmdE/yvpikBXDEhZnuWgDVXuD2lB65JZkc59x
	 Q8Jsd0P7z51aO4PIIgJYFG5BgbGNOAQ0VKxI6bA5dvAj3Zac84013gSAKRptO/evbG
	 vIKHmU6nLImnD2HxTuhNLaP68oB8f88a8YK4qkInF3l5/TwehPyZDtmG4/E3J9owkd
	 o9/ty+0Oecx4u5yY3M8ECil7adsNjQeLOA66MjZaeDLAe1OfyGqqyONb8QAFxAX6GC
	 //V+xFGX+/8KYlncP0ocWRDMlm/BJXupiUgnLxC70PhMr+mf2f3ekJYJiTgAvHRScs
	 /tNA2DgtyIumQ==
Date: Mon, 29 Jul 2024 22:24:38 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: ajay.opensrc@micron.com
Cc: Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	john@jagalactic.com, emirakhur@micron.com, ajayjoshi@micron.com, 
	sthanneeru@micron.com, ravis.opensrc@micron.com, arramesh@micron.com
Subject: Re: [PATCH] hw/cxl: Fix background completion percentage calculation
Message-ID: <svy4snogtc2k5423b4vtmzaoaryetmxzatjfiqfeiywepkr7us@dcslpmazfuw5>
References: <20240729102338.22337-1-ajay.opensrc@micron.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240729102338.22337-1-ajay.opensrc@micron.com>
User-Agent: NeoMutt/20240425

On Mon, 29 Jul 2024, ajay.opensrc@micron.com wrote:\n
>From: Ajay Joshi <ajayjoshi@micron.com>
>
>The current completion percentage calculation
>does not account for the relative time since
>the start of the background activity, this leads
>to showing incorrect start percentage vs what has
>actually been completed.
>
>This patch calculates the percentage based on the actual
>elapsed time since the start of the operation.
>
>Fixes: 221d2cfbdb ("hw/cxl/mbox: Add support for background operations")
>
>Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
