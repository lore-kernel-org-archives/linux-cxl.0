Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9182BE043
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379745; cv=pass; b=g8+tdmG8Ree/3m7f8SewSrln2U3mmvV7tDxBPO7VfVHHHlUGsVGZmggeezlYNd8OLcfEjAx0+E+pO6jL0QNAHlQuIKCJVyYNd2POEVpztQl2zgAOSQ4JSSlAafsvYu/k9eLCcIOfAVmnzx4s23KAmc0LYwY12/IgpIWOi6g0vxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379745; c=relaxed/simple;
	bh=RdsX+ju7ONZ09J7z65a8VHJYRsWL7Yn3BEaIO8Ipt8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj8zJ7SHA5Oy1gEqdJVYvxw8u/KQA3ASlAVilu6qmcfn0HtL1gQUiDF49CuOWzjNSzlQjIqThVJ9OY73m5iLYt915eITpk8rEokG8oY7Sv2ZWU12A2KhrKxOlrSZjPVxjUQk+Pvky95968PIWZXKDCQFKkq55otObNw7Aa/6dV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=b7m73sP6; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="b7m73sP6"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 73351162CED;
	Tue, 24 Mar 2026 19:15:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.121.5.127])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0564D162ECD;
	Tue, 24 Mar 2026 19:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1774379738;
	b=xEXlkzdS5dyywTJPZMy6Kfj3+WBqFzyRxzakdzcw0Z9+c/7sn6mTPPx5x9grxV1tIDqCtL
	D7A1ZW0SsjIFicv8Ty2WCb5NMBj50Q6nGVCkedXM1TDLkNkUPL9yGNiWMyoUPONIcFwiiW
	wkQ+VQrSskrKgDCwEFfZJ+5BgXMUsEj8QbKxuJIN3do6PbKpELjTyLMgVUfEBY2jIFHD8B
	pgKjswn+8aXpAlgDWxKRikWPwslSZhWmwefEefKfzpWUHxrU97f/jPLIRCEq0bNfqRzK0X
	FcbJILuEITNM/ad07wh7vDZBXg232lNZ9DoLxojVFa5naqsPkndiPWAHL6shGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1774379738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BbTqBTO2UNWPJmUNpZ6hRnWiEKplaybPDOvBvM88LqY=;
	b=M+8Oy4Ht1OV1wIyxCrapg5V5zHwyBzPYR/wBp11FXAHMVcolC3H6J1Yl/kQtL7i5Q32Ns/
	UaMLsYW+Os6ma+NVLHlBSXRey6GHneoaAiXZL83OqNOWudL9yreLEK7yo3tWSSJMFe2Hgc
	wiYvRTdwthnMaw4ECjJGYeT9XPYIBMzKsx+Fqtwo+8KIwuc/Hzi3VziIHirKasl5wr6pEt
	EsTjdWLZUZHkGZ8xkpGh0FswAvzsR0mDIr+vnKMj9vcsSDAEzb0Hj2bVBzrTeei+tPlABu
	f51XcBM9vKcawUeU7bbBo8LAq7tkfv8AcaGFiKQUCi2v2UvQUMXpNPqMX24BYA==
ARC-Authentication-Results: i=1;
	rspamd-6d4cb6745-pzlz2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Little: 799cf3030fc11620_1774379738279_1125417871
X-MC-Loop-Signature: 1774379738279:2983996870
X-MC-Ingress-Time: 1774379738278
Received: from pdx1-sub0-mail-a247.dreamhost.com (sub5.mail.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.5.127 (trex/7.1.5);
	Tue, 24 Mar 2026 19:15:38 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4fgKWF0XLZz106Q;
	Tue, 24 Mar 2026 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1774379737;
	bh=BbTqBTO2UNWPJmUNpZ6hRnWiEKplaybPDOvBvM88LqY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=b7m73sP6PclTbWah+3lOvakn3mLBZx2WeiYTj5zFc7VWCeujm/RukXnSpHHN3oFip
	 KvNQWG7YKRaNK3OaaeecqJuguV0DXkRGgzGvnoCOfv+K5Rqtyza8mjkLGs9Czf68IW
	 i9c4MLP27cFW/9JE8oKGEIGa/G3ieBuND8SHax+5P2Ni1c6VPNzC+SOlD54TQZZZkD
	 7q260MwJOp2sggonePUFRvzpcJnBMu7aISX/tr40WBaVHiDrFyD7nRrQoJBCyp8EZ3
	 zWrXioC8PQnCsNuThs9bEfTKycYQthwiCUD5OuTfw29XmDuxLp5wA4vHazBE2an3bW
	 bBIkjZ2muTS6g==
Date: Tue, 24 Mar 2026 12:15:34 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: mst@redhat.com, jonathan.cameron@huawei.com, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v3 -qemu 0/2] hw/cxl: Media Operation Discovery fixlets
Message-ID: <20260324191534.uc3tnircy6fse7cw@offworld>
References: <20260319184256.3762391-1-dave@stgolabs.net>
 <96061f5f-cdda-4bf1-9ab4-97400fcc9344@tls.msk.ru>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <96061f5f-cdda-4bf1-9ab4-97400fcc9344@tls.msk.ru>
User-Agent: NeoMutt/20220429

On Tue, 24 Mar 2026, Michael Tokarev wrote:

>On 19.03.2026 21:42, Davidlohr Bueso wrote:
>>Hello,
>>
>>Changes from v2: indent fix in patch 1. Added reviewed+fixes tags.
>>Changes from v1: cleaned up comments in patch 2.
>>
>>While working on the driver side of this, I tripped on two qemu issues
>>around discovery semantics. I think this is the first time these code
>>paths are exercised.
>>
>>Davidlohr Bueso (2):
>>   hw/cxl: Respect Media Operation max ops discovery semantics
>>   hw/cxl: Exclude Discovery from Media Operation Discovery output
>
>Hi!
>
>I'm picking this series up for qemu-stable (10.2.x).
>

Yes, please do. Thanks!
