Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A23A3809
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887040; cv=none; b=hmQ0gdqCK4hv1yjVUHh8eO/baqLweVO9bRw8veHa5ABYTYpstn5TTtPQPIe0P6Xs4Tzs5ymdEPHCuIRgxhh4mYigGsCrpv8hzBSCEf9wDiJXXzgHda83qWJlij1DZq2F7kEcIaeqnFL/YC2kzVHJ5By20An/HVcopTUdIQPr80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887040; c=relaxed/simple;
	bh=hP4nlPGIrqeNY9wpwr+srgGK8bvJUTL6djQnXyZwy5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOwaof1xwNA6IOEoc8JcIfHOTOULdUpd1dzKNSmMzxP5UgrMp57gddu6hhv+ilHT5Fglzn5dtM6iyJ1wnLcDd+QxPbseEEKGN2Yyi4tNIIVEs6jSKCm1N75fuFZE56C3jR1lk2uo27OQQyQZWwJRIyRsXhykXdc45mU83dPArgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XqUw/zD3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XqUw/zD3"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8f18d92172aso5294636d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782887038; x=1783491838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5xWJ7lGSS4cy1ExwRI73Ip42ktEi6AnmleUk+CzcRsY=;
        b=XqUw/zD3iq+eGg0QalMkPbgj1OT8YwYSgzm4d+KIM/UXNeWVBlWIgHyp6WSh9pvADJ
         7NoipYiINTQR1vT2gpfcrH7hGdNXntTMmhUvLl+UjIFF9d+yPNdJ/KuWBwSNJGL+5vjM
         NfCow4Egn9Ekz4VUpS4Lu4oA6JUBLm986MYCSuro5QTOb0SlS/Pj4/mXXFwwTNFbjqjX
         k6IRHz/nggG36ohWpJQb46AWsx4B4ZsLUZojLu9tt3LqMj3Cmx4+FznBsGkomigX48ky
         HJI38PZ10RB9oNDzy4xt9Wh2JwYYcg7FloV2seOTuDbGiUrdqZyXn8PZzJ00N+NL8CM5
         f9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782887038; x=1783491838;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xWJ7lGSS4cy1ExwRI73Ip42ktEi6AnmleUk+CzcRsY=;
        b=sbtVkKgii6BUjtOiJTiTSRIALPq4YxsKShtcBhfBh4FQa+MkgpMpYlmLpMrbz7/ysy
         T4c1zXyylenf9Ieb22MW9pzKUhOf/Ymhc4R93paMqTWqetPBSmv5VVCg2r/vEXVLrjHp
         dTrw02a0LXZCDIoAjGpMQ4qLNHS+bjgnTvq428pmu1GHMbqY4C96pJo1kozU9eonZ9C0
         tVUaqgxZEMmAQ2SOPWAc2pRoVSBeDnokrmqNPgabrCcnrlKjfP3iYcS4iCcSwtDG/p4J
         kore2e1AZsCRrcEJS+1CsZSa8uioI1Ksyk2EfFpl4DPHfg9+LrvnSoukA0o7x/LrtxH1
         SVUA==
X-Forwarded-Encrypted: i=1; AHgh+RqVgijHbI1nuiVsyMc3iRqphxkNS4AmwxIvu4vMPoezZuMiT1S4bLMZ2+/e+d25kRdwKGuMcr3Ztz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1MYe7K5j7U6Nxo8g3ApROqahY1o25mLvMO4+gHlCKwr+FUeg
	jFS+Z8ENw2LcQirvRDBiY9zDgKI8WNEGUd8pPwE0Wo/fx4Z9oSG9JRBvIWxzBmHmOOI=
X-Gm-Gg: AfdE7cmwxkrh0yRF4FG9/hIbF6rFEIGuhzYMqqFO+rpDrB2BFimjYjVqRvr8lbFhu2c
	g85w3oL+xGgQ/7cYsAfHu2C2kN1niahn2Pm5invyy0DCmjTboNkezmUCNT20LwsdAsP45bIKD1I
	0U9SwvAKDtIBPLZ8pioHb/m27+J7LI11vsg9rk4X6IWWhTv+/TggwTwHCciuIPmWbUhnD8Boeaw
	ITA+Bd/0/tYZyk4OzNU25Ntn5RtcW83Wy8EIzIbZNFzUhZEO+7GLXKttuN4+d5Y95KOGZX1503e
	gU6da13fFXONJwTSkkVpIH5hp4tlW4qu/PK4slCw7yhd317nVoCFh4gH7r72tcurcyDZ3SuSFRr
	tfauFE0I5ce4jXthtLtWza5YNVS2sjja68VskhAUJY/A0WEsqbDrSv8ZDY5Fg4ZIQXgO5MSqmRO
	IPGCUYsbSYXaSa4m6g+l62dw4Oa5UCIzeSJrYxOuYjT5T/Ekimj4CbKOHYAh8ygUdUZHte
X-Received: by 2002:a05:6214:2dca:b0:8e4:d2ba:d677 with SMTP id 6a1803df08f44-8f3c7e708demr3649096d6.29.1782887037749;
        Tue, 30 Jun 2026 23:23:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f361ba3efdsm12323456d6.39.2026.06.30.23.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:23:57 -0700 (PDT)
Date: Wed, 1 Jul 2026 02:23:52 -0400
From: Gregory Price <gourry@gourry.net>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com
Subject: Re: [PATCH v6 09/10] dax/kmem: add sysfs interface for atomic
 whole-device hotplug
Message-ID: <akSyeHnfcDmxnCSz@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-10-gourry@gourry.net>
 <akQ_xlJtXNgnGUdf@gourry-fedora-PF4VCD3F>
 <abde41f0-7d40-42ba-a232-cc0538cd0e4b@suse.de>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abde41f0-7d40-42ba-a232-cc0538cd0e4b@suse.de>

On Wed, Jul 01, 2026 at 08:13:28AM +0200, Hannes Reinecke wrote:
> On 7/1/26 12:14 AM, Gregory Price wrote:
> > On Tue, Jun 30, 2026 at 05:18:41PM -0400, Gregory Price wrote:
> > > There is no atomic mechanism to offline and remove an entire
> > > multi-block DAX kmem device.  This is presently done in two steps:
> > 
> > ... snip snip snip ...
> > 
> > Sashiko pointed out a false-positive, but adding a fixup patch
> > here that adds additional consistency.
> > 
> > On total failure - release all resources.  This makes the sysfs
> > interface consistent with the probe failure path.
> > 
> 
> Speaking of which ...
> With this patch we now have _two_ interfaces to do the same thing.
> And both will be generating uevents.
> Which is far from ideal (one could easily envision _conflicting_
> udev rules, one set doing an 'online' on the old interface,
> and another set doing an 'offline' on the new interface...)
> Is there a way to not sending uevents for the old interface
> or to make it configurable?

We do not allow "offline" in the new interface.

That fixes the entire issue - the blocks are gone, nothing to poke.

~Gregory
