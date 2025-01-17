Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD025A658
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114580; cv=pass; b=bhctKw0FcTZ/hpw/UgPqBRHBfozZQ8/nk1NYsLRgC4RQ2frydfzjSMRsetJhaJ2jMjSvkFdW0WKis+C4dkWUX4ekfQhhTPpQFQnvCBE/MZPbS80I9U23I0hQCsFtXA7zfo7mxY0XxuPrpQSa42s1TVDwXNEIvlUmATcL6EwqtsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114580; c=relaxed/simple;
	bh=aT/c9PYF+icDYCKpJGdfUcAtxxgir3nMaN068dQZdY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7RORrCGXC8Ic/Dj54Mw5YJifXsg+WeaJxyZzNN6d4HxBhLHb2Zz1XKUo9vAWfH+MrCxFGKzZxUy8pbaC1opJQbBCIbZxmG4WOoCHlVbmZyf4xh71dsbM5tphBEgkMHdTpMjArb46KtvREu4gdpxVb9BlEA2E8TqjaDrP05c8MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=m4A8RRh6; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="m4A8RRh6"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C9E8E8C3133;
	Fri, 17 Jan 2025 07:17:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (100-111-255-151.trex-nlb.outbound.svc.cluster.local [100.111.255.151])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 50A978C323D;
	Fri, 17 Jan 2025 07:17:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1737098272; a=rsa-sha256;
	cv=none;
	b=NKXOuP0vi/jPI+SotVqyfuNJMDiC/CtC2aByKp4o/XFQezODW7uS1fKDAHVNHJkxiNQUk9
	pvrrHLC09n6HUFTa4yNykxYPlL9uF/WtC2kL5fjv/1R/QHAhvz+qKIwPmQrNwqJk49oe5r
	55fKgnoD8LtbKrIgyrUPp1t0NhuvlEIuGjkMfdxMZGMYDT83niNh47l6WWZ9Zh4NUlWKlV
	mBYYiXLmIa6ns727nNX3mI2JXqNCT7bQ6hxHcI52ilMpR22L9isvEuvt+HtnbhifzxkGmf
	2c45kLBx9mSty1MWGzgf7uL11xWG/kEdkg2izG1DqJQG3TWnuDcqVRmd7mlhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1737098272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cKE9AzBVKmQ2TctKD9jseOt8vQStvhTVpthqeDMpZlw=;
	b=Eez4WYhhB0Mj25KMvuGGt7OjLyejJhLy7DETIsDF2AqX8q8LsP4a70Eccm20BwGlGwNyP2
	j3yNfocrs7twHriRU+UepQTtiNKCbYONnwB01unwjWJ2mAw9TyMM4OWKbFOARLQC9pFAMW
	dTK5IjWDafroYIyq+2infnNTdojB8MenYinmwR4tRvFBn8pd2/cYPhDwZLPFfZC1GQy8nN
	lkrV/I/b1ihYE/Wc+pCRrUaw4qur7MBcOAa8oJezgBFNBlqc9lvdz1aKCuisHXIeX+A9aZ
	u1BVZ2Td//dgPmxcPn6Q9SE8ajggeWTd25pO1zV58EwF1owmYRyQDLvXjfkhGQ==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-rq445;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arch-Shade: 76ca272c05e981ba_1737098272631_964783420
X-MC-Loop-Signature: 1737098272631:393827764
X-MC-Ingress-Time: 1737098272630
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.255.151 (trex/7.0.2);
	Fri, 17 Jan 2025 07:17:52 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4YZ9zz35p9zQf;
	Thu, 16 Jan 2025 23:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1737098272;
	bh=cKE9AzBVKmQ2TctKD9jseOt8vQStvhTVpthqeDMpZlw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=m4A8RRh6vJifRUQcSDHya5prGt7F3wvGmZ1M3c4/82/0X+RVZXQH6epnVKuUnvNsh
	 3GV5ZWiZi22seIjoMRELwLttQyuhwonvB0VQAPgp/YxfenO38OSoXmnjqejm83Ge3S
	 EEd+BxABllOy+9c28Shupk6stZRJtOjdvFP01yp8qA1gpw1rm3DoftQOHUnZ0vKMof
	 7ezzhVpAR1XMFGNdz8inVJEzPNlBhMU0j2uQ+q0fwQefszyi7dz7bwsy0UvKTpDui3
	 TJwRr3fo57wDawM8IuMLpGtSxvD1vGiLQcoAh4gjr4Nc7bwOOm7z7YM78nhXG0kJMP
	 BX7vWM+BoiHSg==
Date: Thu, 16 Jan 2025 23:17:48 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.jiang@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com, hch@infradead.org,
	a.manzanares@samsung.com, fan.ni@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <20250117071748.ss4rm7y2mdzdvuaq@offworld>
References: <20241220164337.204900-1-dave@stgolabs.net>
 <20241220164337.204900-2-dave@stgolabs.net>
 <6789c06b84028_20fa294e4@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6789c06b84028_20fa294e4@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429

On Thu, 16 Jan 2025, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> +int cxl_pci_update_gpf_port(struct pci_dev *pdev,
>> +			    struct cxl_memdev *cxlmd, bool remove)
>> +{
>
>If the timers are just maximized then I don't think there is any need to
>pass in @cxmld.

The max for T1 is 20 secs, true; but the max for T2 is based on the max of
all the devices T2 in the hierarchy, so this call still needs @cxlmd.

Thanks,
Davidlohr
