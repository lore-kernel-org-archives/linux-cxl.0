Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CC442FD4
	for <linux-cxl@vger.kernel.org>; Thu, 13 Aug 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611327; cv=pass; b=UhgQ8/guFUNDOxav/ieQsk1/7iyCgK7dbEt4sauBq9dEaJ3FtSmflmfTv7mqtfSkN1kqL3WCvOpQOz0rm894onlDbg1OyX+4DCjm5ywvNKvkzYmbpLhZBU7vf7hOQvwmgI4sYr2A6M3cymzjw4uNUAEpB0h1Uo7BuMsjq2Q0Mfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611327; c=relaxed/simple;
	bh=Jzc8k1yrWfBTMmPd/uTV9o0ew6ZOvHlbY2BVlHKCDmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgFGSQQepINFJld7384NJQ76jMHPBgu/97Az13bme7w5wTReIPc80ofwrv26Hxt1+zYuA3DJSszJpIClUZfkNmK5jlSBvaqrQNrHlK0p9kwZCxNRuH2pojd2aeGoDkJMMT5Ulc23aD9R3RhXogQbbcwAoX3M7vnD2rMv4uhesps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbbGxqob; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbbGxqob"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cab973140bso7898985ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 13 Aug 2026 01:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786611325; cv=none;
        d=google.com; s=arc-20260327;
        b=VM/rc+QByFxRcKwf5fw8MBpOhEwsvwTCTjMxdnS91IS3XQHSQp2wk2TJ5d6dELNcKm
         x4dtqQPOdpQ9AYRdlpEUX/gnhInxx1v+09iow+9Tn0tmZwEft7fJJicSTaHpClsGH0rW
         avbKgJ9/izFarrhrPguBkQisuMg/iIMWXl01vzUbulIoJR7s8ouZiZlKL0jM9STrw8AK
         f7dCZxFmUJT+aMNpBO10SYG4DVd0LjjLNeuJlwnEi0VaDoLdc7A/9tQpGYncZCVJijdE
         dHJjsQt5PqFadseDR8gzvZAbVqJgBK23/JWCvlMQnATR6xMq6oOdjO97j+JPf8t3ZRvU
         LiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iQkBGHUJCah+5IraL6W1VGnCKmw1qeB0IxjLs3arhcU=;
        fh=o19+AZmq0L/ZEHQQog1z0uUIJ2EYpU0ZNhAHdEXTZdY=;
        b=BmP+IQBwFcwyByxKDUrt2HiqD5k4SoSn8phbEtmvkVFLpD31nmEXbW16BFywP/zq4k
         hHjPcOpRr16jc7O7cqbZVtZWPT/SZFtFGgorrhQu14Z545ZQEF7E7ewHt0vUEYWyy3qP
         QLTI25MBGbv7Pwhki2KWEmf5hF/MGzXAj13OmhbmwnoNpv6Q42ML3zVltPLQQY6f+qAC
         7DnjP77j6UB4ru46DqMfLwwMMglsu6T1QAzcrRCla/7mpynAOmy6IY7C1iyKaW2GRJ62
         5fgHCMsMOpkV5K8RdFezvwDQ2FpJe65IYsAc3BP+lXlP+j73ej/5tlGw89K2QJ+FY8hn
         Dizg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786611325; x=1787216125; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQkBGHUJCah+5IraL6W1VGnCKmw1qeB0IxjLs3arhcU=;
        b=HbbGxqobFGq6jQ6lr3AJYabpK7r73QkMm2744ocBEgZnA+6LW1VXrJFvpPuRvh7/I6
         TkJKTnNGFbwPfPQkY7vkUNbj4DBRuQjSPrawZdDMGbvp3sfiPH5dD18PB77MjXzZA/qY
         XPo7ahdVsKJJYMaLNASbJYMiZtJ3FafVpzNeEnE/PnWlf476KRrykV3FhC0tMDv4WnNk
         m0y7kATTGB+afK+bUQQPp4AkzCAB81Xl36TrhqC9hE1NujciAOnmDwqF8d/3lvCK9nW1
         K5Dw1FSSyXL13cknl9NsxPbL3l/9WzZv36eVpZthyccF8dHS7UWpyPrQ/uxlaDZPpdzk
         1zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611325; x=1787216125;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iQkBGHUJCah+5IraL6W1VGnCKmw1qeB0IxjLs3arhcU=;
        b=WQbYAHXErI5P1cKWDC/kl6IqGztrLvxUmC0KywIJxuZKDV6pHwcWj/cxlvZr9v4pUh
         7h+CCQnBS/RssBQy1namzfRtiHZU5Bi4f7zioumj0WbUMqQncLv7eyAHdHVbLfNarljJ
         DLV/gu65MHkijveb24PSVyI5NOlVhvbzxON7qkSAtJoWzOafimcJtNL4ZAP/OSVHdDNB
         Xq8nkIulxo57TD/K7ijOf1TrY4fz7kQ5zq/M6zjgjBqdzE/NT8EYyZyWaVB+FjJJc1qH
         mE2r0T+B90e0YpoDUoHJTTY6psTOrr/PPFF8aFBruiWFMQKUTQD8ALbME3fiqpS7X8XZ
         REOg==
X-Forwarded-Encrypted: i=1; AHgh+RpYfVrLVIZF4pvqlYh7iqRB8Aoyq/QKCHIolB5Frfm0b1TZWFo/Q5HxE179yTemrTZWc+ufFKRJqSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpQUJHe7j+lq+dc2jDKi2Z3G3Z5JtM7F+x8nhCiBRzMMk7UCI
	AxzAoNjMZXUejCCFM71LHzHUZTVWO+XBrvDAe5q9wh/LfAZCu22MeOp6asaWGxL0WdFI7Q754HY
	B0XIVmxfFMWlaExK2uA9Lvwaskjst9FI=
X-Gm-Gg: AR+sD13tvGiHSGpOgfuf8SvA5asM03CVzUle4sRgFZhFK4e/mAvlskU2dG9dOpiaWje
	+UaVPohD4LpDMeXSOZo2Mf3amMTWNoJwJeyAlERmx9Lqdn7heQ4KZ/JQp/LGHGbtO7CFpbZtU3Y
	UXQE3pEhe5et14+vh5BoqRflj6pAP2UYEdVgFv8tDAC7hJsV+lekEVGt8FEQY5TK7qFmLiCj59B
	I4TWWGobBTgfYlghz99Kd8qPZAGH2tjLXOxT+o5CpLAkYBOY52KjCqtp/d8wMP5NjJuWaOy+Tbv
	nVy2gTu2Lr0a3LutMqM/+hioXv8NwA8QbFp+I79PxbDBLVA=
X-Received: by 2002:a05:6a21:150b:b0:3bf:8604:9a3c with SMTP id
 adf61e73a8af0-3cc553f513emr5787899637.28.1786611324791; Thu, 13 Aug 2026
 01:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720193431.3841992-1-gourry@gourry.net> <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>
 <an0cAMh_m8ZhGIm2@fedora>
In-Reply-To: <an0cAMh_m8ZhGIm2@fedora>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 13 Aug 2026 10:55:13 +0200
X-Gm-Features: AUfX_mx5aRT_GeBsew982Oll4m1v2zeTSERp4DtDb2YI-VK1slYjLWUFWPkF2ZE
Message-ID: <CAM9Jb+jmxPdL-CdWQHYMT5G=qmjB6z2WFg+4K8Fod5n=2N6YCQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	djbw@kernel.org, "Gupta, Pankaj" <pankaj.gupta@amd.com>, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, 
	jhubbard@nvidia.com, peterx@redhat.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	lance.yang@linux.dev, usama.arif@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

> > > Bonus Configuration: HBM device memory tiering
> > > ==============================================
> > > echo 1 > dax0.0/private       # make the node private
> > > echo 0 > dax0.0/adistance     # highest tier
> > > echo 1 > dax0.0/reclaim       # reclaim active
> > > echo 1 > dax0.0/demotion      # may demote from the node
> > > echo 1 > dax0.0/user_numa     # mbind()
> > > echo online_movable > dax0.0/state
> > > echo 1 > numa/demotion_enabled
> >
> > I am bit confused by the HBM device example being discovered as a DAX
> > device. Is it to
> > only to showcase the use-case? Or we see HBM device is actually
> > expected to be discovered as
> > DAX device with N_MEMORY_PRIVATE?
> >
>
> "actually expected to be" -> no.  there's no requirement HBM be
> discovered and boudn to DAX, DAX is simply a convenient intermediary
> to memory-hotplug.  This is at best a demonstration.
>
> A device driver could very well just call memory-hotplug directly,
> or its memory could be brought up as a private node via a boot
> paremeter (which I have sculpted for v7).  The former is preferred,
> but there's a bit of a chicken/egg scenario for bootstrapping.

I find this interesting as this appears to be evolving towards a vendor
agnostic framework for hotplugging memory directly to private nodes.

How you see this working? In particular, How would the kernel know which
memory ranges correspond to HBM or other device memory?

Please also CC me when you post v7: pankaj.gupta@amd.com

Thanks,
Pankaj
>
> Most of these UAPI extensions are going to be consolidated into a
> debugfs interface for testing purposes only in v7.  I've been working
> on aggressive Linux Test Project test expansion to ensure there is no
> UAPI regressions.
>
> ~Gregory
