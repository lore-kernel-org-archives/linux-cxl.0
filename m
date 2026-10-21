Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.181.3.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588495;
	b=mfpaFVe1QQ4w4UTMiPa59/zx1sUlPgU5i6iu0h6Sa39SWg12Blyqh3wBbzaV100Q+rwL
	 fHXZRqiHNBK6aOg8CD5Z9QES9y7kXn5Er/Z2HkJdhYS4MAC38atHvj9vd0tPzVPcxcoNJ
	 bKVDjbEF+3NKsLefu0MowpjjmFUbIcS44ThEDtrjfwYg048zzDOqbU6K5l5DpX6BbIcks
	 knJXWT5JITmqejz+NZVQf7CHF+edTH5mplQr4UFC3amG0ZYq8vpk3D+AIm44IbsWwmpbL
	 IipfePrDEMAF3W634K1SnUA37KqQVkaopEUHj60JKJoLK1f08VGKXILCaWs7iBVeg2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588495;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=1TK2fDdADiYGOmHES1bBsCj+/JqIcvI51muk8Me59NE=;
	b=hTDCGYrR8advTDQkcypc2MBEEc9mmKbNljTbUpbn/sXlJOvSu0I9+Da2sR0qFlTledlH
	 2GZTNTree+mFAMfBsnenoWlHtP6IE5SprNW5rxlfHP8g27q/LksX4CdNCj4VgFcgV9NEr
	 M/Xh41CGi2aauPjZEXLhjjJmzsR6+lYeVqt1Zu8cehIWxJbl/QPuiXrB/uknx7VCoOs3Z
	 QR25OektXPkUxEMo659ZL6r2fo1T5BNjaV+q70xXEMMrEUeSnYrJtfDO5g8uKJy9JyvHr
	 OweIH2XHYsv5w38cYiHMM+1RiQKwrRHl0YKZ6uvjCzPB3CP7jXGH1BpqOSapuaacAPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=JZ6zUwyP;
	arc=none smtp.remote-ip=220.181.3.100
Received: from outbound.baidu.com (mx13.baidu.com [220.181.3.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C56EF606A319;
	Wed, 21 Oct 2026 13:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C56EF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=JZ6zUwyP
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <jic23@kernel.org>
CC: <alison.schofield@intel.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<djbw@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shijujose2008@gmail.com>,
	<vishal.l.verma@intel.com>, <zhangyili01@baidu.com>
Subject: Re: [PATCH v2] cxl/edac: Fail ECS threshold read for reserved encodings
Date: Wed, 21 Oct 2026 21:14:34 +0800
Message-ID: <20261021131434.79699-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020222739.72a07093@jic23-hlaptop>
References: <20261020222739.72a07093@jic23-hlaptop>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc9.internal.baidu.com (172.31.50.19) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1792588482;
	bh=1TK2fDdADiYGOmHES1bBsCj+/JqIcvI51muk8Me59NE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=JZ6zUwyPAwErDhX6GbA2ybHPJW5Mo7moz7kxE4eiaNCEVxwqjYbGVcRkdlpxxHTXJ
	 HX7AO1AhiEq3/9JYydfFh+CIJwe6tcXV2AMw8aPf2p9uamoVlbDOcdBZrf7g6eWRJ4
	 7FLi5sv86g6se1luF9NTtqwKaMz81gbGrW8t4Nyo+RsHMg4dIvCq2T2aIc0+yPjTEZ
	 +wos4p0Fb9uUjeESbiFQ1bnBQ5LAtMqWylPCd3Zz/67yJnMiWaR50AzftgP+WkG+cM
	 z0gRl+uZC62pvGJlKYc468EgvBVxSiiliyuwDdioJPBTmCFqgLbaQ77XJOc15z82vV
	 c7bvcX70ZBtsw==

On 2026-10-20 22:27, Jonathan Cameron wrote:
> This just called out in the CXL upstream sync call as lacking
> review!  Sorry about that - I missed it entirely :(

Hi Jonathan,

Thanks for the review, and no worries at all about the delay.

> 
> So this bit suggests this is hardening against bad device.
> Definitely a good thing to do given it is fairly simple but
> not a fix as such (so no rush to land it!)

Agreed.

> 
> For this one, can we trigger these values by writing a threshold of 0?
> I think that is blocked by cxl_set_ecs_threshold() so I think this
> one is also hardening against a bad device?

Confirmed, the write path cannot produce these encodings.
cxl_set_ecs_threshold() validates the value in a switch that only
accepts 256, 1024 and 4096 and returns -EINVAL for anything else, so
writing 0 (or any other unsupported value) is rejected. Both the
out-of-bounds indices (6-7) and the reserved encodings (0-2) can
therefore only be observed when a device itself reports them, so
this is hardening against a bad device in both cases.

> > Fixes: 85fb6a16ad14 ("cxl/edac: Add CXL memory device ECS control feature")
> 
> My overall suggestion is drop the fixes tag and state that this
> is hardening against devices returning values not currently in the spec.

Will do. I had added the Fixes tag mainly because of the out-of-bounds
read, but as that can only happen with a device reporting values
outside the spec, hardening is indeed the right framing. I'll drop
the Fixes tag and reword the commit message accordingly; the code is
unchanged, so I'll send a v3 with just the commit message updated.

> 
> It might actually evolve to become a real fix with future hardware
> changes using those reserved values but we have no reason to think
> that will happen yet. 
> 
> We had a small discussion on the call about fixes for bad hardware
> and I expressed my view that if they are cheap (like here) in
> maintenance burden by all means take them, but I'll push back on
> anything that needs very complex solutions.

That also fits your maintenance-burden point nicely - this one is a
single validity check on top of the existing lookup, and if a future
spec revision ever assigns meaning to those reserved encodings,
ecs_supp_threshold[] can simply be extended at that point.

> 
> > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> 
> Updated Shiju's email address in the +CC.
> 

Thanks also for updating Shiju's address on the CC.

Regards,
Yili
