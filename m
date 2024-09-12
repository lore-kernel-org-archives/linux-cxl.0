Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9413D530
	for <linux-cxl@vger.kernel.org>; Thu, 12 Sep 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165069; cv=pass; b=SagpquoNK2NMTBi3uyaY1LiRIBGBy9Ilz3Ws5yKw6uDxEyk4zu05KxWxEeSoZLjiK6Ze54uHICgaYDMOabCjkryhaROHQv2wKln1yGJ1MjARgr9A4q2bIh7G1U/Kve5ukRUXE7YtucSdM49hG+wx9xufW+G5x/NmIUt8W0GUXso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165069; c=relaxed/simple;
	bh=0yuM3zGWc7vAkoGYEoYqfBmo6PloqtgxXi0Qx6XjusM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpAX6ERODLE2j3KRXt/36GGBu6pYOg5ISehfIwlyfDQtWQ0tLy3YGwVhPiRTbtLWfUKZjr12cZnKPkNqljrTpVpwetC26BqKYYrfBV84EqoNz0HiOiorhmRyUDVyq1GCI8HzRsAyewnROdhzOO+76z9lsewu4GgKNlCU+7GRD78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=VHLn5n+R; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="VHLn5n+R"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E537EA51C5;
	Thu, 12 Sep 2024 16:02:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.96.66.41])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7BD7BA11AD;
	Thu, 12 Sep 2024 16:02:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1726156923; a=rsa-sha256;
	cv=none;
	b=rcGPxBbq9G76MnOuD3dj9e4qbvk3jVo0BfO60dwS3/pr8v7OTOyMaK3ITFx1qwTmIj+IW8
	rda/1mr0Eu4wYcNO+luVRIUZgRjDh7+qThoQRTDPHKMt0N10ALbFE8sYi1YcQaZSQdd/Nv
	VtPTEtcv1OlmFrrquJZfaakFBnY/nFob9h1dU6Hp/kUblB8k+9yHmU6pPOf84tLczuiE22
	/EQ8p6OetMqXjsXJ1dqmlAGOvWH/mI+9gD1ZXBdwPehTJ7sr3j+kuciSUzlqZID2Knln8R
	KFX/NS0xOq6MAqe+m9J4YUSIPoqHo+AsQRDe84yqLpAWM4j34t1R1blB7MGWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1726156923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0yuM3zGWc7vAkoGYEoYqfBmo6PloqtgxXi0Qx6XjusM=;
	b=O26YoEjWGQ45HN+owaXlUlCMse2gTH7e6BogOEPVgW1ELjdW7IgJAs23AUUCjx99rmidWR
	Qvjsor7ESo9tUzcfUbQ8IfKMAXU4bEc01L2yVqn91mFey5Gp14JW57Tn7WZEi8g0e99vQ9
	MYmZFTUDB+JWNVSdqWgrgkPoiEzIFHMmzsnqguNbi1Six3vxjZcZvnkKdKdduYeWXag/aQ
	h7hcb24zgagoGYXrv+KjMWE6ABX65rOu2dGQ6AKTs3QEZwK+YIrn3u0neUXJGEVi2eT1hx
	jGeT6iSZgU3K7ViD+4ZPpmFR5e5LNeCmpikk3gecWamsYP5ylHTyvrEMTHkxww==
ARC-Authentication-Results: i=1;
	rspamd-77766c4bb8-xgmkp;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Broad-Society: 1a2ebe5c304950c5_1726156923776_274428463
X-MC-Loop-Signature: 1726156923776:2719597386
X-MC-Ingress-Time: 1726156923776
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.66.41 (trex/7.0.2);
	Thu, 12 Sep 2024 16:02:03 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4X4MdN3d9VzMD;
	Thu, 12 Sep 2024 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1726156920;
	bh=0yuM3zGWc7vAkoGYEoYqfBmo6PloqtgxXi0Qx6XjusM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=VHLn5n+RO2U2Nyb/dxsVPtqDcB5aPnwLWwUQ9vDwFfXXtdoVv1ACJNRDfVcDU1Lb6
	 W+TQiYz+6Gze+lfEBq8HKAnItwumZDqte7pe2IL3PQItynJSow3XE/IbMs3Uf7Jxfx
	 wk+yZ3FJhNZPxCScHWsLk9d384GICwWuDUkzmAHcleryK54FXl4HFc9FDrhYVgzM+c
	 ruLIp8KSYFowpMh5iQh9Z4+uBWJf+CprytGiQ9bff42CrRbiTGZJQTh/oQiwVrTlLa
	 XKjouNAG9Qj7NDL2IOSkqCAtTOV+B4xvEZAkx4BtWQmEDtopYyA/cl20OXETrxfOL0
	 2NUxap+z5pKmQ==
Date: Thu, 12 Sep 2024 09:01:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	jonathan.cameron@huawei.com, fan.ni@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <20240912160157.htic6o35p5r5f45t@offworld>
References: <20240911215221.308483-1-dave@stgolabs.net>
 <ZuJBKHi-l3YSgDEW@aschofie-mobl2.lan>
 <b4qrc6xbwmmfidmyhaieu3kxlqewtupttp3pqatg2rj6ua2yxd@xwx4ybpysnil>
 <6d9fc6b9-ddf5-4429-8d67-3a09f75960ac@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6d9fc6b9-ddf5-4429-8d67-3a09f75960ac@intel.com>
User-Agent: NeoMutt/20220429

On Thu, 12 Sep 2024, Dave Jiang wrote:

>I would say unless you are working in a specific part and updating that register block or adding a new definitions I would just leave it alone. Otherwise it's a lot of code churn. Will take that spelling correction though.

I will send a v2 then only updating comments in the event groups where new events are added (and the typo fix).
