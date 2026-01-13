Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326927B353
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314138; cv=none; b=ZXhCnJoZHDbwlu7td68EWpVBvkfUwHylTz+uX6MHUlMegpxmBQS0bZ0VDYnpXVmO9XrfH2jISag3w1VJ6ap8cRlCG0fbE8GU52CPIriEg02359gkUttouaoMt/hBTC3Vf0jcMuik0w0RPVNt+ovMa5MuStLmBguNlS62vx48efk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314138; c=relaxed/simple;
	bh=eGYf2Wx7+bxI9fnoEdaKbM+ix0y39iZXCpZ7Kf2dgqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmc/nOrv70W6mjMmyvrs/FDp+hNJ8W3Tx3Gi/hAPoxz0ktRHZweH49DEvWGXY+tca4hjQ7whbpT3XETQ0CLXAwuHfB8QQWnCuVkZMAmaTvqhc0KA+08qTkFvz4k8qNqqnUQOQEQywkzrIMF9nrBByynFpnlSYGgkS++m77XeLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nxRwG7nR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nxRwG7nR"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a3b9ddd40so45223616d6.1
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 06:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768314136; x=1768918936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4O37FQr+LOdMRqQ+TweaC2/Sd4OM2JtWu1rpX/F7Rk=;
        b=nxRwG7nRohedhtQXF/V6ET8r6E1hCKNpxlzftno1dvf+aoyTKgKLEYFzotdFeaS82j
         PF36RsbR9oCEBJ+Aifu/nMLKi92wqbSQLnLLXOg5k4/I3+y9ylsJqOsnxVrfBTXSPhhA
         a2Twusxuh6BCFzYh33Se9RWnDujRooZp51B5TRm8ti6koUW+ItEDiMvrUSeqaww1fb7g
         4vHvS+jZhJTia75hPeLrHZ025L0uWyeEzdeunVnF6lKaIb2WysxZfrbb9fjPPp49REjv
         zcH+mqYHu6lxocF+QYu0G+BkjBun6GwlthswaI19nEGuSJHyNpztiK9m+0cGVwNDRV0n
         DWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314136; x=1768918936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4O37FQr+LOdMRqQ+TweaC2/Sd4OM2JtWu1rpX/F7Rk=;
        b=GpdRhwei1dhF8G6GHQU4zxgN8cmT5ZB956vAcLKk5VeaVzz3URxafeRUB3QFwUfLTu
         Tl/hz/repbqGG/smE1vwPwJmnvrdbIysC9KuGbAYaIP0BkAqIAqh9X4qpwAxJEveleon
         /FZiV/clc4h5lKWaURBMf0wKII3azlgqTbjRSsyRNAoLIOc1as4wzBV6c4smI63gLYwG
         tMijYvyQg4z3FJCYY0p+vouzNQzgSBHiL4WdP5VlhM52ScjZwiNEEBDeWZvthTmOsQcY
         yfyNbr6MalAQEW0nW8cfHprsah+wblX/v1i5YAO1hSAaQZVafpTNHh7VENj5/QOqv9nb
         wpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3iioKhxQOtVHp0G75U7KrURhrE3BdIQjrLidWMnQWQNT/g2hlBNbBzmXZZ7cWZMreQVrSbUT7HWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/7dWcszwm0HpeddDUrgsH8eJYxqIgGIndQ/u0yi7IWc7YAKO
	JrapgTaJxOV/pk2NOUi0bu2aWVuE5r5uR6tU6Ug9NTw7CKWSp9YWj9McP9VjBYzu0hg=
X-Gm-Gg: AY/fxX65l5kp2EsF6vsHw7QeD5Z4eTPiJE13uIRiwQtNMvXLbxNJwBTZd//QRr2Vftq
	EUguLT/7+EavavmIL/yh58ggywnmIqKeMnXruGVOSsuXevFljC/5YjYSgscp1kd1NlTVME8chbA
	+3vy5JBIuOyd/XW4o+EHxQgaxTJKdWAVIGMEUIQuOj9SvEBJMhkARWFLawc9X35Lwe/JUauV81N
	VOB4XuIyjAaG/Rxj+3vc/gAYjMQNcE6/phavmGUQOmPL1Qotw838mflyAtz7E0yLQ5UzicSpKiZ
	DoAZG1gnNAP2VFWG44w4nWT2wRRxNFK3QOJ23H6oLxqHu5r7TrBE7R2TMP5+DS1PQxEuKM0jjME
	3vYogiUbo4csbc4neeH5377cJSBGqJZ9Ap2v1uYv92+qVREzSQ23gpfIWPGvCDEDNA1z9L42d6h
	12GVQZJhlkSuGm6PdPcxJlp1cNwgDetMrZU4Pz2nkuYZDkKSVTVeqixJQEN4jBOMQGSEiRyA==
X-Google-Smtp-Source: AGHT+IFjEUG/kkt8lULhTKW8EjcJ76aqeW9gt0lwSGT7fyOizprTUn0Us5awKcQHUHtWfOIUP8T8rQ==
X-Received: by 2002:a05:6214:5090:b0:888:8187:1547 with SMTP id 6a1803df08f44-890842a23b8mr315841516d6.48.1768314135363;
        Tue, 13 Jan 2026 06:22:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772681desm157803516d6.51.2026.01.13.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:22:14 -0800 (PST)
Date: Tue, 13 Jan 2026 09:21:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: dan.j.williams@intel.com, Yury Norov <ynorov@nvidia.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
Message-ID: <aWZU9YZLmpX7wxbb@gourry-fedora-PF4VCD3F>
References: <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
 <aWUs8Fx2CG07F81e@yury>
 <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
 <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
 <696571507b075_20718100d4@dwillia2-mobl4.notmuch>
 <966ce77a-c055-4ab8-9c40-d02de7b67895@nvidia.com>
 <aWWGZVsY84D7YNu1@gourry-fedora-PF4VCD3F>
 <69659d418650a_207181009a@dwillia2-mobl4.notmuch>
 <aWWuU8xphCP_g6KI@gourry-fedora-PF4VCD3F>
 <91015dcc-6164-4728-a512-1486333d7275@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91015dcc-6164-4728-a512-1486333d7275@nvidia.com>

On Tue, Jan 13, 2026 at 02:24:40PM +1100, Balbir Singh wrote:
> On 1/13/26 12:30, Gregory Price wrote:
> > On Mon, Jan 12, 2026 at 05:17:53PM -0800, dan.j.williams@intel.com wrote:
> >>
> >> I think what Balbir is saying is that the _PUBLIC is implied and can be
> >> omitted. It is true that N_MEMORY[_PUBLIC] already indicates multi-zone
> >> support. So N_MEMORY_PRIVATE makes sense to me as something that it is
> >> distinct from N_{HIGH,NORMAL}_MEMORY which are subsets of N_MEMORY.
> >> Distinct to prompt "go read the documentation to figure out why this
> >> thing looks not like the others".
> > 
> > Ah, ack.  Will update for v4 once i give some thought to the compression
> > stuff and the cgroups notes.
> > 
> > I would love if the ZONE_DEVICE folks could also chime in on whether the
> > callback structures for pgmap and hmm might be re-usable here, but might
> > take a few more versions to get the attention of everyone.
> > 
> 
> I see ZONE_DEVICE as a parallel construct to N_MEMORY_PRIVATE. ZONE_DEVICE
> is memory managed by devices and already isolated from the allocator. Do you
> see a need for both? I do see the need for migration between the two, but
> I suspect you want to have ZONE_DEVICE as a valid zone inside of N_MEMORY_PRIVATE?
> 

I see N_MEMORY_PRIVATE replacing some ZONE_DEVICE patterns.

N_MEMORY_PRIVATE essentially means some driver controls how allocation
occurs, and some components of mm/ can be enlightened to allow certain
types of N_MEMORY_PRIVATE nodes to be used directly (e.g. DEMOTE_ONLY
nodes could be used by vmscan.c but not by page_alloc.c as a fallback
node).

But you could totally have a driver hotplug an N_PRIVATE node and not
register the NID anywhere.  In that case the driver would allow
allocation either via something like

fd = open("/dev/my_driver_file", ...);
buf = mmap(fd, ...);
buf[0] = 0x0;
/* Fault into driver, driver allocates w/ __GFP flag for private node */

or just some ioctl()

ioctl(fd, ALLOC_SOME_MEMORY, ...);

The driver wouldn't have to reimplement allocator logic, and could
register its own set of callbacks to manage how the memory is allowed to
be mapped into page tables and such (my understanding is hmm.c already
has some of this control, that could be re-used - and pgmap exists for
ZONE_DEVICE, this could be re-used in some way).

~Gregory
