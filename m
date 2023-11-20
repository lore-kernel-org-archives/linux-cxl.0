Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="p4vcUy/G"
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28FAA7
	for <linux-cxl@vger.kernel.org>; Mon, 20 Nov 2023 08:05:00 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E4547841B99;
	Mon, 20 Nov 2023 16:04:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a295.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1AB85840EFF;
	Mon, 20 Nov 2023 16:04:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700496299; a=rsa-sha256;
	cv=none;
	b=eZwJyo7odz6G7+G8xVHWXTu+DwCjCpR5yNIP9pFs+W9gmHU4M3g0RWdig4gYIZGFiKzXLV
	I+j6HXraBMJyJdKi9vDBUUK/RqSWuYhUSrcX2YNvTJKxiKkYA8E7QmDxSx56PkZgcmbv2o
	9PZYjM9ZrlTeYYou/rn/ICSfrPyfzUjFXiftK9jmCO4gFaQi1Ze6FsHuENHJZw9GCeEzcL
	8k2dX4ieSsjnV5qFne1Wg3K0NYcQWwAXDViIsfpym+JLZAK5SpjMlR39tuCW4Oe3neidjM
	ji8W9T97SBY9UoBshRdbhc2u23r3ZOfcPmk406S1EoMJGbTizwXxgZf3/lGX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700496299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qZwsRCekNVeRZ/hI5GKcMSX9owhVk89JfYOSb6VC6UY=;
	b=mS2wOYB0yGGJcIZKJbKvR0m83jlAHSg381k068UyJVBUxEPjg3xXoDa2qGAS2SbKv39PUG
	g0/U+rvuZcvgM5dII1ZvtAEpqlOQouyZfDtjMxdzN2FCcbgEZb1h8Ig0+u2cTPPHQb42NP
	UFrqxlJV1cVGNg4S/sjZELZhoR3qdbULjm/WFozdwCGzV5V76qAfmKd2xV/isk/VAfHffo
	4fT3Sn9YGw5kKSNz4XA59U4uIAM+L5nMV+8qO7VtNrEMstbrOUToOBZceMaWzbrEK5F3ku
	4YJGL/Akzb1HKbIjTy4luNkhiLPbXpExD0bOyGCcBWg5Z4vnuQMfplEroS59Mw==
ARC-Authentication-Results: i=1;
	rspamd-55bcb54c45-997q5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Harbor: 7c19ba0b50ab8c13_1700496299677_2353292940
X-MC-Loop-Signature: 1700496299677:2954174184
X-MC-Ingress-Time: 1700496299676
Received: from pdx1-sub0-mail-a295.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.117.136 (trex/6.9.2);
	Mon, 20 Nov 2023 16:04:59 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a295.dreamhost.com (Postfix) with ESMTPSA id 4SYslt38yZzSZ;
	Mon, 20 Nov 2023 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1700496298;
	bh=qZwsRCekNVeRZ/hI5GKcMSX9owhVk89JfYOSb6VC6UY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=p4vcUy/GxPq0fkT6yriNS0VIuT3NAoo7tAiE9/X/pAXjwf8PVUOZIDuN+nRrt4hw1
	 sM8UFoOlqFqRRnrMCyF5y44LK+I8BZg1kqzL8ppBJDwoqPgZYMQgUefRzVLQdLaqD2
	 Ou12e/wTaK48WXDHDYQdYE15NsFcyaqqVtzlurgSMVm+h9PfxeQLdAc/jmMYwC2Gpm
	 UaT/+YHDhlgtLBf+RVUSuJc0vGuCCjBcR4IkPBmRrtYzumjN38jincPvCeDNNkD4C5
	 uTqEoLS5MWYi//DwIMBgYZ8Metscrt4w1TsdgwYICSYvsd9H564JMwuSE6vqzLWWOx
	 CSRSmWCok33Ow==
Date: Mon, 20 Nov 2023 08:04:55 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, 
	ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com, 
	Jonathan.Cameron@huawei.com, peterz@infradead.org
Subject: Re: [PATCH v3] cxl: Add cxl_region_rwsem around commit_end write
 during decoder enumeration
Message-ID: <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
References: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
User-Agent: NeoMutt/20231006

On Fri, 17 Nov 2023, Dave Jiang wrote:

>init_hdm_decoder() modifies port->commit_end without taking the
>cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
>However looking at the code, it looks like the write version of the rwsem
>needs to be taken due to the modification of commit_end. Wrap the write
>version of the rwsem around reading and writing of commit_end.
>
>Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Uhmm but do we expect concurrency during the switch/port probing phase?

Thanks,
Davidlohr
