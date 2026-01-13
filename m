Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5F1EB5FD
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290575; cv=none; b=gewe2S4hfLJULsvr6OSghu7PA5II50NrgGVD2vNi02p0r0QbAsS7egUl1UkkcAZJ+93VL3aL2twTuyt236Rsd6mn8xio1vJRwedS7FHXNxkS7z8XV/H4P+hBvQIExTE+kYaEsCNJxEjJD8SEPYCuOMiCcJKsZMEEORhU5WxVlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290575; c=relaxed/simple;
	bh=D72r7QS3AZghCN5eZae/D45TgwvMIo1bhMsAnpABw0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htb8NdYz8lhCYZPB4PjvU5bgSZLTC5K0J84pYsoXYHt09b2Xpo5c/ibz+t+TAwwz1r0CHfgotasJ2VMSeael6SpGzF8vLjV4NkHsTa8S+zB0IInGk+mFxfE8nmaIQ/bzWXDvbHCZeBLOmoIUUDRfrmQY+v/DvhB7evaqtJGowg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXqQDkS0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXqQDkS0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43246af170aso3427787f8f.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 23:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768290572; x=1768895372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D72r7QS3AZghCN5eZae/D45TgwvMIo1bhMsAnpABw0A=;
        b=TXqQDkS0p3yUSbgZZlJZi69w+PsFe/x+lD38HlEuH39i91wMa35KrYDXfs4yzt4tEu
         EzuIWicg9Q2UeSLapgBFS9g8sDnnzSLNWtjDVMu+wzKx9V2837bQ278xjOBg6Qxf9xxf
         IECzpFedn9YJyMSbnR7NPMwVTVr5Yx+3E8qy/LtEHv1b/BUDABX3JYaK8+AL1zHMYS6C
         kXZ+mlCLardLZ5qQK9o5Lr3QXF7naA/PoavhVOaY/NR5E9OwO1VjsKQkSKv8bMpOlSiu
         ef3T3rI8RzEG0CStiGGT9Rk2tc7CbYcVRO0qJTJbEFk3aUMY5SZk3Vbj5ufNVUPbqIO4
         oBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768290572; x=1768895372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D72r7QS3AZghCN5eZae/D45TgwvMIo1bhMsAnpABw0A=;
        b=nxhjksaXaXQPIAQ38+dB4Tz3qgv5YDl+XnPl3oXy5b7ivZMQfxCZ7L1qTG1YgrR5Fz
         haNrgDalnED7nKRqIUl4lnJ3zFiiq12UR7TDJ3Lerw5CfvXoT+L9a8oSNcNpyFEHVXXo
         9nayozr5ZxknAnJ/jJPnNFD6KJwmzGf9cLO50aNeII/KEle6RDRr6PQOyPIh25PjxYle
         foFSWd/JV+81l/Scmi5i8C6p3AsTK5YUfv8bwNuBRGipKOlS14h/JQ3DxUWIQKtjvNM+
         IxgKMkyYfbLiqMLNkS4YGOSqHXc/GakNMbRiA1Mj2m1GeJHG8hsfUgcQ12Fz+bZ1+dn2
         fV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBwc0Qxf6qpgM4hikfH/cNbnSdzHsi/PSgqkPrs6I4BVonwopuBUu0Dl1yDW9UKGUnb1V4/RURqFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6e6dHlt0PXe2Wp6f+Gk+KghG2kZf+Oo3samPNoWvwo+HuwzIj
	LCrg0Z/lXtPiqFXn7XNnDl3g7I09Nq8FlsEBVkA80dBcexweD7igidrUKc7/jxG+Km0MuhaMxOY
	X6dKi3lW93AUvMeap9FiDWOgRyobrPO4=
X-Gm-Gg: AY/fxX43GF5g3t+AI3mesy7MzRacTCtUY7Xmgj3YuoTqg3BAhvNnRlG1zG13KiojxLT
	4osixdN6S0nslqzpPTpCyNQ5cY3cM2qkeyCY+aaRKMHT1iTudUnfv7ftiZ8wuqCo2tpD9LeZfa8
	bpD81Lj7aRBLHG/5VN6nnnwB/rf3dRPF3Iv1HmpoL8R1XDHymowgVMqqUqleQnaUICaAaJSOAty
	DhO4VSOf6Sg9otYe2TBc7ThKDJ1ydGIZRkwgwpnVKfDbkYs4V7wdgStW0rHlO50U68H+RpqalDR
	WZaMVg==
X-Google-Smtp-Source: AGHT+IEUFzHNS5l/qkxJS4NHDFzj85t9p9hXmvLuRRVn51UAN1F31Ec5D+lka3oYPvt3/QRvR+bD0XtQlx2VDHa+1AY=
X-Received: by 2002:a05:6000:2084:b0:432:86e3:84ec with SMTP id
 ffacd0b85a97d-43423e8dc7amr2509543f8f.23.1768290572295; Mon, 12 Jan 2026
 23:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108203755.1163107-1-gourry@gourry.net> <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F> <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
 <CAKEwX=MftJXOE8H=m1C=_RVL8cu516efixTwcaQMBB9pdj=K+g@mail.gmail.com>
In-Reply-To: <CAKEwX=MftJXOE8H=m1C=_RVL8cu516efixTwcaQMBB9pdj=K+g@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 13 Jan 2026 16:49:20 +0900
X-Gm-Features: AZwV_QjRztJYV3eeZ1od2Jwrm9JddNIFu6M0SVCsJAY8kxCGR_nVVkUgLa9Xz14
Message-ID: <CAKEwX=M8=vDO_pg5EJWiaNnJQpob8=NWvbZzssKKPpzs24wj+A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net, 
	jonathan.cameron@huawei.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, ziy@nvidia.com, david@kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, rientjes@google.com, 
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	osalvador@suse.de, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, cl@gentwo.org, harry.yoo@oracle.com, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 4:35=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> > This part needs more thought. Zswap cannot charge a full page because
> > then from the memcg perspective reclaim is not making any progress.
> > OTOH, as you mention, from the system perspective we just consumed a
> > full page, so not charging that would be inconsistent.
> >
> > This is not a zswap-specific thing though, even with cram.c we have to
> > figure out how to charge memory on the compressed node to the memcg.
> > It's perhaps not as much of a problem as with zswap because we are not
> > dealing with reclaim not making progress.
> >
> > Maybe the memcg limits need to be "enlightened" about different tiers?
> > We did have such discussions in the past outside the context of
> > compressed memory, for memory tiering in general.
>
> What if we add a reclaim flag that says "hey, we are hitting actual
> memory limit and need to make memory reclaim forward progress".
>
> Then, we can have zswap skip compressed cxl backend and fall back to
> real compression.
>
> (Maybe also demotion, which only move memory from one node to another,
> as well as the new cram.c stuff? This will technically also save some
> wasted work, as in the status quo we will need to do a demotion pass
> first, before having to reclaiom memory from the bottom tier anyway?
> But not sure if we want this).

Some more thoughts - right now demotion is kinda similar, right? We
move pages from one node (fast tier) to another (slow tier). This
frees up space in the fast tier, but it actually doesn't change the
memcg memory usage. So we are not making "forward progress" with this
either.

I suppose this is fine-ish, because reclaim subsystem can then proceed
by reclaiming from the bottom tier, which will now go to disk swap,
zswap, etc.

Can we achieve the same effect by making pages in
zswap-backed-by-compressed-cxl reclaimable:

1. Recompression - take them off compressed cxl and store them in
zswap proper (i.e in-memory compression).

2. Just enable zswap shrinker and have memory reclaim move these pages
into disk swap. This will have a much more drastic performance
implications though :)
