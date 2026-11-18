Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017377;
	b=WkIkenxjV5H71c/jMoSMT08y7apPABnuEcANGXK9buD2QhkDxYnKEeEGy7Pck96KCRWu
	 EAgKD9sYizVcsy7O7w1o8K6aUPuYnWk9tv2W5hNV9eHZ65KMQD6v+nRTSJykqbD1hAs8H
	 qFNtrm5gJLm7O9ZPmNFWjCU4nJQtesQYdClS4qvu+cN4WXrukpiGBChHXfN1R77rkKNMB
	 Gw8mZmZMGs7WPvq+VbmyyquCHdRnU2ijhLcO6nXYq1wPnRXm0zMsofrE9P+V/SH+3Brse
	 7vo9LtKc9dj3/mtLl2StHM0vw5CsVN6omSNAXU0JieJhY+AE1WpS0Op1NbMNDSNeMkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
	b=EBjDsnWPre7UIiEhuPa07cYPrngKYsJAK1KeYn6ApTk8dEbKhJ+Z3Z0t44NYaBIEPRFd
	 hwkMYOlHlIirhtFdjPq18/g+H+ifkHC0//bQWVf6kczpxUp3enfFBB9kyfQJCjlFPEwzc
	 oCJn4OQ0IX4vIltK+ykpSzUBfKfHc8blwxpDnq3SZi66Bt30DZ2OoAFjk0Ge/LwS+aZeI
	 Mx4eh6sOPVca9z6sisUc6peA1XWtdFJaoO4LJ9KLUlWxgZgcxU4ihlwtvO0PB2weH3O2w
	 ot6ix1rPpBm5rrVtljyyd/XkodMPWYhoz6cLdK9eNWA3pqRCeyncN7nE1GrR6nIQBZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gFIxxdDt;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B3606A331
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 15:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE7B3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gFIxxdDt
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ef011e338so5495406d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795017376; x=1795622176; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
        b=gFIxxdDtcqDrBFkqgwEzkN+bVHfcVbrm/mKFYHBw/aX+aK3i6yXT3iOHNNcy/dVpjR
         beX1ypC799ntnSOEXoyuWI9KAiYigmUzM2ktWAUGq14UH6bdfs19Po3EeuhNmuPBICwQ
         4fygV7vNlH+8kA4gHVrwCXXCMRXtK3og0Bhew+zJDF8jtO9O5fvmBFacfYtyQB0ZICfH
         uto7MDRpcWiyf9+vJZQn3ZyabRKAjiAEnbjmVD+LqH03jEVrnsuMJqNm4PPeRi2PD0kM
         0m9hgfLivrz1Z3dH1OiBWSOIUeexNiv0u7ws6tg5Gw4PB2Xal1+xCiI4FGHOyO/4c+dY
         QURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017376; x=1795622176;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3bQBfuPo4+GA4H58G8tofWZlnWMcm4hxNRzjXZBoZg0=;
        b=y9ETgIcosFav6PaDV8vAxVaUYIJzGAVMy+wnA94Rar57sVSHYZ0t3r0OJe9TZQrnVh
         OqUSCXjONVsgCb9roGSderiexaT/B50j11tM68WtHBoHx6l0U215nrUoUmdKnYWP4dHU
         1ywK66+pgMWRcnWqvv73bq0Fw2d0wFVlspL+1isTVh6zS06manr9idd5hSs9zlLbgzbF
         5imel+guK0SS3TBP0QH3vAeqnvvsm39gB7sZ4S3TU/7VRj7pNr/AqsEy8HCpSA4AYEip
         5TRrpmkBgqYyiO6wB6hzKnRSI/nBUJXd6CsOC2ly4RhC62jI+y9cmW6grAnf0Tcd4+xi
         JqwA==
X-Forwarded-Encrypted: i=1; AL+hErGVx56DA5NqtdTnCsG11+McReOltg0oO7wgPA6/h947PEedWumiPHhKDr7oaCmZ0Oijr6L8BIbXJko=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8RVom6eoQGV0IwNEwQfd32XHTNlAQbj9xF39DtIARun765pTR
	SikB4ICJLxjUY2HVBCLNkL+n62q/2slIbRqPclkITeXf0GR5M4mO3MWSCgE5x0TQcKg=
X-Gm-Gg: AZFdTZfLx0sugnqJx+lswzIFQBlfJJWreKKtgJToS6ry3NC7qbj2O90T8u7HcwjLe/R
	ihphlgkJ/3isWCEyxVK1/26QCDpTjeEHQQbgBl2okRgxC7TTx/A/oVWaIflH5XUQKOoQm+Cmwnj
	b7Dt8dNuj9Q8cZkM33ZGMKhYHJRbST/mDySHoBXFQFJyQgo7da9UIMaW6CZqYdWKPTJ0Xlq7lag
	r7v7x5tAxOFUrr1APsby3HSl0YJ2ZvhCEWxJgZxHtDwDfnu4rVRbgXrCbw16C7+YmVdmoTqJaVx
	pFoZKmrPAY30Inn55K5MKHSwroryg7Yo9eh6zmqJhUh48Inl/uN7qGX7qLeiM002+HyC4RJxVa9
	x0Cg6FxdbHUYWktl+X7EpLMnzhye8b6temZyrtJ/7OSfzBS40b7DwC1uNEWYRQGbCULuBHV4p9g
	58sA7VpqcziSth2bfEbhk7UmtKrplWpPUsNjEq25yrSirO2TdJEhX+7St4HAJkUbz4u8PoloEBn
	2esIqAX59ebgr5PlVuH+0eW6eWN5SV29n7zf1asNv9GD9w+lhqekY/AUkICBDHbUjouobuhrd2+
	RW599vDOc7vlwgXR6n83HBOMhDYJpoVckTfPExWg9BtEV+HotFy7kMGMoa2wOCDuZ8JSCb/VJlM
	lyP0dzjXBqW9IdcB7hrqeRv2v5hv2
X-Received: by 2002:a05:6214:8013:b0:921:1890:b77f with SMTP id 6a1803df08f44-9211890b87emr29798426d6.47.1795017375668;
        Wed, 18 Nov 2026 07:56:15 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d28215sm24719106d6.16.2026.11.18.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:56:15 -0800 (PST)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/22] mm/mempolicy: keep interleave and tmpfs mount
 policies on common memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 linux-doc@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, 
 damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
 david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
 skhan@linuxfoundation.org, rdunlap@infradead.org, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <av3EGWuHX2JDdlrx@MWDK4CY14F>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-6-gourry@gourry.net> <av3EGWuHX2JDdlrx@MWDK4CY14F>
Date: Wed, 18 Nov 2026 10:56:13 -0500
Message-Id: <179501737390.1206716.11014097946405277594.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-18 23:30 +0800, Richard Cheng wrote:
> On Sat, Nov 14, 2026 at 02:09:42AM +0800, Gregory Price (Meta) wrote:
> > -	for_each_online_node(nid) {
> > -		if (!node_state(nid, N_MEMORY))
> > -			continue;
> > -
> > +	for_each_node_state(nid, N_MEMORY_COMMON) {
> 
> Maybe I overlooked or somehow, but when do we have the assumption
> that common memory is definitely onlined ?
> 

For this particular case it's not particularly relevant.

This code only runs at init time, so it's either got memory or it
doesn't.  If the memory is present but offline, it still wants weights.

There isn't really a bug here, but the existing code could also just
check N_MEMORY and end up with the same result.  If the memory is
hotplugged later, it still gets weights accordingly.

-- 
~Gregory

