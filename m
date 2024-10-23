Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B71A48;
	Wed, 23 Oct 2024 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729645210; cv=pass; b=Wrm6kVa0C9cWwSLyg2+3qseko0m2KhWrvjZAM+8rXdDZsBuLiR4tS8ajDLBdxCRdbUtyb84RSZc1YAqauzIEs88sGdTbixuC443HD+zX7Bgh0FALINjM1rD6EZAeJ/10K0apcpTTBRxZXgiHipVPoTrIcS/DkhTYZtfK/BqAeGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729645210; c=relaxed/simple;
	bh=iz5FJiRdAaTt6XvCz5hHOw79cCv768zy64sfS+JpJYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQsriSJvnRamA4flu0yCQdrb58WaqQ1UaP5kjBdoA7QwYKudavmwL7+pERGOAPejafChMFmCmM96jaMqYrxz7WlDksVg7HXnZw6NCFPoBfOigj3o/uZ5K1vX+vTYdrmwGlL15Uor8xldmoW+a6tJcNKp6hMVtmy76O4RGZ/WYjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nwe4WUrR; arc=pass smtp.client-ip=23.83.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nwe4WUrR"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5ADF7943E1E;
	Wed, 23 Oct 2024 00:53:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (trex-13.trex.outbound.svc.cluster.local [100.99.209.159])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DD1D9942133;
	Wed, 23 Oct 2024 00:53:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729644788; a=rsa-sha256;
	cv=none;
	b=cZsdaLjEIqurXGOVEYD7qRHdFhxOED1xMurx7ICn0x7MywkvzF5BQVfTKw9z1J76Erz6s6
	agBk+BnmNk1eLqvEmm7arLRHPoq4NyU5WbS6zKBn2hzgXyX41b0RKWiUProG+aum3gYbCE
	pS0y/4aSdCg9Gj97kt+JitNg8AeJwlaCJoKNDeS10JpmrAYcAb1pbsRcoKfQDqnTEE8ZMt
	5PqUcZAzNYZtq315GjFCV5V2tHptwskgcS1Gub8M+p33t23e9ipL3NMsbT1AMiO29A+P+V
	diobuhI78Hmavbi8+LXZMO+KrMKZMiUVjTgKHcVTJ3hFf3KL6jTXQ6vBBOPDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729644788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iz5FJiRdAaTt6XvCz5hHOw79cCv768zy64sfS+JpJYA=;
	b=Aod4eknf1YuCck+hjaQ9CO5luB3N1+HFISJoSto+grOOQGaAjeE9PcMDAERMyHeanOWYLJ
	VZvE2fFNU53xcMCU4JiHtU2qG3Imzlp04S+W7zhek2m+LdfVA7cdNHBs8IdLENdyIv7wE4
	nvjen8wdrL7qZxCCs+HKwtUPDxMQAqwE63h8kaH4qD5C8IIqmzKUZ6Er7fW02zEcEszg4L
	9SX4eWpSHBf0X/ynHnbN9ea2zzc7mXJnepBpFVdAGoPvR+YzLb4GF84VyCwuhCNEyhpkTk
	fztg8S8rSDIaYkAMqsnYxpsF0GteBLLSX4eyU3LHYeRGtVLVzvKK+g/QXwfTNQ==
ARC-Authentication-Results: i=1;
	rspamd-7d55d965b5-c5dfn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-Blushing: 7877a02964464eb9_1729644788208_3160964976
X-MC-Loop-Signature: 1729644788208:3733274980
X-MC-Ingress-Time: 1729644788207
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.209.159 (trex/7.0.2);
	Wed, 23 Oct 2024 00:53:08 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4XY9Wl0h25z2Z;
	Tue, 22 Oct 2024 17:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729644787;
	bh=iz5FJiRdAaTt6XvCz5hHOw79cCv768zy64sfS+JpJYA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=nwe4WUrRuJe1mG5li6WACnNEIGv7rKRMEWF7qiHWrDceMz8tfYsg2PpA/MDJEEY4/
	 dyYir1XFFgchw9lAWV5WBy5MRy6gf2aUfwnBtjSAeONBSIN8eQXEuD90F5MGhnr4BV
	 sdCCAEnZcw/YHelsysjxm0eask4iZziD8fm8S68CF7NiTrRQdnGUrad+kyIn7oUusa
	 X6wu0Gr8+YBWzZS3sxZxjg7JIaUcSNShb1HyZKlwVIzD6VpXlHiAuykkriUo33Farr
	 pFT1Ma3w+CDddCLoTAivCLe0jrJ3e18AqC38CKCt0luyw021heT8sq973LWHUeqj+K
	 YlLes9ojhKvZw==
Date: Tue, 22 Oct 2024 17:50:23 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: shiju.jose@huawei.com
Cc: dave.jiang@intel.com, dan.j.williams@intel.com, 
	jonathan.cameron@huawei.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH v2 1/6] cxl/events: Update Common Event Record to CXL
 spec rev 3.1
Message-ID: <pfjneiajzokyjhkzdcu74zyhnj2lej2ipvs7ru55ensb2t35zj@4xduj44cuodz>
References: <20241022105849.1272-1-shiju.jose@huawei.com>
 <20241022105849.1272-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241022105849.1272-2-shiju.jose@huawei.com>
User-Agent: NeoMutt/20240425

On Tue, 22 Oct 2024, shiju.jose@huawei.com wrote:\n
>From: Shiju Jose <shiju.jose@huawei.com>
>
>CXL spec 3.1 section 8.2.9.2.1 Table 8-42, Common Event Record format has
>updated with Maintenance Operation Subclass information.
>
>Add updates for the above spec change in the CXL events record and CXL
>common trace event implementations.

Yeah, I had also noticed this while going through Maintenance.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
