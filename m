Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108961;
	b=oegKX1fOhd9lIZc2krOOCf2b4LtoRd6QMG/7gLc+xAgY4n2fpGpxHZvFFLdC6EtLJYQ+
	 TBazr6yFCb8gYRWbeYK+aZj64aXCOg3E6UnMtianvgbQ7EjmnirJLyRmv2WIPmEcQjta7
	 xiOeUx2RuOxwJiNevM/cBbPv7B+jZcOn2ghR9CULcnRalWtyKqkFEEgjFXdZPdclsSwxZ
	 Jkm03n36ryjg0J8ipphCHZ9VfZ7nWuXl9qedSUl6mv6QkPdDxobDGCPkus8toUZYVdk2Y
	 ZVRVVNOnUpEcmKQCzB1zPDDNaDzRgFH9cJNCOVlpmJA0Z95Pod2vAkQR5tVn76X+Dpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=XomX6DB6D1/SIO93qU+NvqAlwsKLsAk/d0xRuNeXAOk=;
	b=xq8+oMUAZ3fPbUWgWhwk2D0yxL464MgPBb1PhK7c7GI5TvgTlR+8ZE0tbWro50vDjUeO
	 UsGDqK+aG6gM4J6Y31n6m93vPq2vvvzrXcs3ZV6H3XY89Pa0AJxNE6TAhFPRsKdUyL6ob
	 zuR1m6CxsnL7e1JyCYKNQ4qWBUw3w8jcXKI82FhBsIBo0p8QFb1ssRoBNX4YvUxTv1sYR
	 wPG4hHIEKXwOqT+DJbFj9hPO1GrbI9xUjP3ZHuvhr61SGukqGmcXQnDjcWD8hk5JWnkvv
	 5oMNnzY2S8tgCUZ9msyYdYNB+8Cths91iUOvITx03zGGx8wV5dIxTTa4kUy1g8lbcNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=QirECd2g;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4F606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 13:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41E4F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=QirECd2g
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-536c8f958d7so30673791cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793108954; x=1793713754; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XomX6DB6D1/SIO93qU+NvqAlwsKLsAk/d0xRuNeXAOk=;
        b=QirECd2ghwJmRxFJOo7gQFoS9QwNcRuzit5+GxNaO2qtQ+wt8h38/bJwNtvPVkzpvs
         uBKiKsScICwdQfoim073GAnQEIVbJHBo9jXXyitttfpOjHA+RUzshYmhJah2wsfiGeiL
         quU+CXY6kF1//9a51cB6/Ld44ufTmvwrx9FHP4o/SOeQEzHybxBMr5nkIL1LY5F47hgn
         NOUhG2kwUKeQOOVvId/Q2+PdYC4gdULgfWWMzo1gkaBatU8cmxuxgAeWtgwCBJxZejMb
         H/SSVcSUMG6rpkrI803+iGPyss26YF5EI2j0KKoKWo9uQjHkad4gHNpMATKcxlKytRwr
         12sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108954; x=1793713754;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XomX6DB6D1/SIO93qU+NvqAlwsKLsAk/d0xRuNeXAOk=;
        b=AYFrD3o2FuxZEyoffUlNDS4nob5n0+K7zLaRjIDSG0dkL4BT3MPK8dkrGUXLw90XWH
         V04MgErUoLspePl4oD0Tshhq2Z5lt/XkIJCWCJwd3B8ozFEDDn1xFVwlpGkRJuXdcQnb
         dJ1NNGD6f6QicILUAW1PJaMVcmpZxpZPq72ei5EjrcSqoID2lIZD5jvFtOqBbXC8laki
         6hXUAL/4osBTM3aPHVU1dpS/DJr8dKMmxKpw5QtQTyOzP3uyfM20NVgANp0rY9hqyTfr
         NQRUc1iHBmltCix85qfeVfVO3CPUz/XCm4fmSUhWBMg1bl6JJh/JenTg0dXpP4PxcVOE
         07DQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0vlWe9tsHE+LIcApNK5uviGMtHCv0egWhjaTq0UDSqJ52WnGPR2eh9G3LrPx2F8PYSume1udZKYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5tlfXd1V+squ37UX6hGxMTwofaW/T/XnaaSmx6zCy0JIbAptR
	HNGYZOdtQLcYgKeWKFiOhxvcKlruyReEqdNV/T2+eJj5OFR/fm1/s6wQU67WMSVMjnw=
X-Gm-Gg: AYBFou2xmuAnTrphT5NZOdEy6sgHsThxveiwYu2tCR8yn7fX8va4ztGguKsj4KR886O
	5JDysv1ON3Pfya2SVBawZSRMZNBreXP1w27glta9k7VLI9d4KmmECXt/YPYBEDyj2I5l/o7Hw+E
	HxUSsi7Mkz2ixoi40/qe3PVacpY2/OZnDl0/ZE5uzNaCfCHLcngg92bzOinrgTmIvrPxBAyOwgu
	ZGVEXQzGQKybjTKReCyzxWvADIoTpSj1dMRWsOmMBK4sJXV/yVrZ4JLKuRVcL4ehev5THS1L4Am
	4dF+bPEgHMoDZpWzlbOpU+grb23MJkXCZIaAnjgLdX3f528f19RllqCgfWigWojTMeY282r+Ih8
	xyaF3WuiifoxaB5/xQbNmNMheMHeoF1A32wQJYEu71OyVPvT1olelvG8iq+dO5IfpTa5SpTQe3N
	bTE+Va8MAsdL37bC3z6nsl0aWV8vb0z0bzMKu86Nk8zq/nIrO8+3ltDk3eglpCUDqiYORuSVogJ
	3ZsNClGbq4EWrecXRCN0qnqAACX80iMLsGp7qJnk1P7o38ovPhLx8FsVZoEQIqxBTLgrxOqhgvw
	6Jx0NAv7Npftz6MIthXRKDP5UdQ=
X-Received: by 2002:a05:622a:1b10:b0:532:f0a2:ef4 with SMTP id d75a77b69052e-5383b4caaa3mr156684351cf.26.1793108953988;
        Tue, 27 Oct 2026 06:49:13 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53839709ed6sm79085531cf.16.2026.10.27.06.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:49:13 -0700 (PDT)
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
Subject: Re: [PATCH 0/6] mm: fix pfn walker races with memory offline
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 kernel-team@meta.com, akpm@linux-foundation.org, vbabka@kernel.org, 
 surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, 
 hannes@cmpxchg.org, ziy@nvidia.com, linmiaohe@huawei.com, 
 nao.horiguchi@gmail.com, ljs@kernel.org, liam@infradead.org, 
 rppt@kernel.org, osalvador@suse.de, muchun.song@linux.dev, 
 iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com
In-Reply-To: <9051ac3d-60b9-4ed2-b781-b7191898bc83@kernel.org>
References: <20261027042204.3741307-1-gourry@gourry.net>
 <01d7d54d-0047-4eb6-a1d2-5b3f113f26cf@kernel.org>
 <179310071902.664110.12994053710961856591.b4-reply@b4>
 <9051ac3d-60b9-4ed2-b781-b7191898bc83@kernel.org>
Date: Tue, 27 Oct 2026 09:49:12 -0400
Message-Id: <179310895201.1491991.14362391061932133491.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 13:51 +0100, David Hildenbrand (Arm) wrote:
> On 10/27/26 12:31, Gregory Price (Meta) wrote:
> > On 2026-10-27 09:57 +0100, David Hildenbrand (Arm) wrote:
> > 
> > I actually have a reason for these fixes other than "bot said bad".
> 
> So you found them on production kernels?
> 
> We did not have a single real report of that for probably a decade or
> even longer in production.
> 
> Recently, we had the single first report about the compaction case from a
> stress test (no production):
> 
> https://lore.kernel.org/all/20260903095543.3752338-1-yuan1.liu@intel.com/
> 
> "We are not sure whether this race is reachable under realistic
> workloads or only under this synthetic stress test."
> 
> Where I motivated that we need something clean.
> 

tl;dr:

while these are ai-generated, I'm not posting untested, unreviewed
schlopp for the sake of getting patches upstream.

I actually care about this issue.

---

Some of these don't show up as crashes but instead as hung offline
attempts (GFP_KERNEL landing on movable).  That shows up as our
hypervisor just failing to overcommit / guests hanging.

The compaction/alloc_contig bug is one I've seen in production.

I've seen a handful of NULL derefs in production i suspect are the
zonelist derefs, but it's hard to say (they're rare enough that we
lose the dumps before someone has a thought to pull them).

I expect this will scale up as we increase the number of VMs and
the amount of hotplug we're doing.

For clarity, we use ballooning + hotplug as a combo:
 - ballooning to do cooperative overcommit
 - hotplug to defend host stability when the overcommit ratio is extreme
   (basically deflate_on_oom because a host stability issue)

We're pretty aggressive about ballooning guests to squeeze them and
dropping the balloon to hot-unplug that memory when a guest is cold.


skippable side note on virtio-balloon/mem:

I have some improvements to virtio-balloon and virtio-mem that allow for
handoff from balloon directly to mem for hot-unplug without having to
drop the balloon, but I haven't posted those (and we don't run those in
production, so this is not the nexus of crashes).

Similarly I have another extension that lets the host set a "NO_ALLOC"
bit on the zone so a balloon-only system can provide the host a way to
defend against mass deflate_on_oom events (we prefer guests to OOM and
have the host to kill them due to PSI, rather than threaten host
stability). Also not in production and not posted, but there have been
a lot of experiments on overcommit here.

> The thing is that the race between offlining and actual memory removal
> is extremely long. Poisoning is just a mechanism to find these theoretical
> issues that could cause issues faster.
> 
> And with all the other things going on, this has lower priority, and I
> wanted to get back to the AI patches I have once the other thing is sorted.
> 

Sure, I realize I'm pushing this out during the merge window, but I
felt it reasonable to get some thoughts on whether these fixes are
worth considering for the window.

If the answer is no just put em on the back burner. We can carry
fixes as-needed.

> > 
> > I have a reproducer for every single one of these (and the other
> > series) - but a handful are unreachable due to a 2-statement read
> > being emitted as a single read by the compiler (which can be undone
> > by a targeted compiler flag). Those were included for completeness.
> 
> 
> In general, I think we want something that will protect all
> pfn_to_online_page() + zone->contig thingies, not just selected ones.
> We discussed in the past using some sort of rcu for that.
>
> get_online_mems is usually the wrong approach.
> 

Agreed, although the PFN walks seem genuinely harder to wrangle into an
good rcu shape.

get_online_mems seems like the backportable solution, but i can see not
wanting to have to go clean it back up later.

> protecting individual pfn_to_online_page is just whack a mole. Likely we want a
> way to check whether pfn_to_online_page() is called from the wrong context, and
> maybe we need a variant that can be called from "wrong context" for a good reason.
> 

Agreed.  Although I fear the structural fix for this will have uglier
performance issue than we think.  Then again, maybe it doesn't matter
(if you're doing a PFN walk, then you're likely already doing something
stupidly expensive).

Where i'm largely concerned is the page allocator and the
compaction/contig code not taking a regression.

For zonelists i've ended up with something like this:

@@ -1461,7 +1466,7 @@ typedef struct pglist_data {
         * Generally the first zones will be references to this node's
         * node_zones.
         */
-       struct zonelist node_zonelists[MAX_ZONELISTS];
+       struct zonelist __rcu *node_zonelists[MAX_ZONELISTS];

...

static inline struct srcu_ctr __percpu *zonelist_read_lock(void)
{
       return srcu_read_lock_fast(&zonelist_srcu);
}

static inline void zonelist_read_unlock(struct srcu_ctr __percpu *scp)
{
       srcu_read_unlock_fast(&zonelist_srcu, scp);
}

DEFINE_LOCK_GUARD_0(zonelist_read, _T->scp = zonelist_read_lock(),
                   zonelist_read_unlock(_T->scp),
                   struct srcu_ctr __percpu *scp)

static inline struct zonelist *pgdat_zonelist(pg_data_t *pgdat, int type)
{
       return zonelist_dereference(pgdat->node_zonelists[type]);
}

With this the zonelist cookie checks evaporate, but you still end up
with guard() at every walk location - not great, but better i suppose.

I was hoping this could be sunken into the zonelist walk macros, but
I haven't seen that pan out.  I've been spending a lot of time auditing
that code for private nodes as well.


On performance:

I've been hammering this with will-it-scale and a bunch of workload
tests on a variety of hosts and have not seen any obvious regressions
outside of powerpc (which i can't test directly, but SRCU-fast requires
atomics for powerpc from what i can tell - so it will eat overhead
without a fallback... if there is actually any hotplug ppc hardware out
there to care about?)

-- 
~Gregory

