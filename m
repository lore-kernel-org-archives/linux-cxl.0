Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE048A8D8
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688026; cv=none; b=snU9G39x3SS9Hf3Dht2mGOh8dcoAurFjBaFhoqd1BBu1GxOwELmVlRqN8a62+vXSuUr0ILY73Llv5gJzJmx+7CKnn/DgEYTLJ0S10oyeXNVqWQZJHcTIDty078t8BjVKLLTupiPu8SXdYtyglr4gTSqZxaPpyisQbIGO46qpypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688026; c=relaxed/simple;
	bh=H8dIRigzbfsqBlf9hKHCsMSk1K+oEsxPHUlgT9i8LkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaHf+MPpXPoh+XxsG+znYl/01i8HmKUU0AohZI1FWALbUIeltBYKBoRuQADCZ4iYgJQy2Xw1lBTg97+dLed13qFta+4I3ziiVvpog6gTF5/+j0VqXicdftYhmZ/v0tpK5kLQvzly3z507kWEdqMTHrJRtQKOLwYtQaG9ugXfjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZnjcaG4o; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZnjcaG4o"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5310b91044aso1221221cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789688023; x=1790292823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fl33IxVXjUjZlgjtUVRA5jnnuh38+J5oAeOt6c+b0Fc=;
        b=ZnjcaG4o9CRqVn0ICJvtIhmOr8c9oF3Fs/xgg1E0Ntrmx2fOTEiNpf47CJAuVrdrVW
         P4dXQLQlrhBzaER0fS5lIsF57urK2ran+8za1AL17mLBfJ+6zI3u02kye8tVgCYLtlGe
         9fh8yU5UuZgkYa0aysrKgZVeTnru9bTjkxWPij7lscFehYu8kNYFayzJEh/4x3vl/AVO
         6h5PW90RemoY4+hdtSYpqZr6+JCliHKcrV2ab+422f7SvGxfkkGjPdWJBxRG/tJ1mzSK
         Wk/JXqu0J/Pmlms+vD+On6SsXVxVXJTJG54jVQ90dvONip7rmc9IGCHENLbUh08GwOia
         Lurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789688023; x=1790292823;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fl33IxVXjUjZlgjtUVRA5jnnuh38+J5oAeOt6c+b0Fc=;
        b=15E5Q3HlLbJWBhK245z8ynnV1g7JhgddC68qG6TQGy/e0JZrLxhBq2+ISLFh0LBIYa
         KXGWD/R/8kX8GLiQbasQGVAjq4RVz5gZbOr4GScrTpNSGZgnSZnrnFY4iwkAgY3vxDQm
         L/dJK+35nSKdUEFUKab7ArVgJ0VOhQy80BzR7KBmqCYfVsuDMnTrOyNDQl8XAfUNNO2R
         jhZqKRr+OKtHRuX44RDbEXYkWx4R7yW/rvwsitfHHjynHO7JNKG7suj+bRPygqDtvqdO
         YMg2v7CLh0mm4bL1ZLbnueVsCVgV9K44ONB/R4bfyQ4FcRfl5TyS++LpH2hml8MlBFkM
         VaBg==
X-Forwarded-Encrypted: i=1; AKwUvByObTmhZ07b7hMEKCfD1+XDfD4R0db9HumY/82YSlr7C56KlFYkm2I6CC5HfNQ2pfkmT4WqJOzHTnY=@vger.kernel.org
X-Gm-Message-State: AFuF++n+O/X1Tvtk68XFRiBd5eOf33Tm2Zh5xV9TF3PeJAa4HQcIOQIq
	A6yhSTbk2F/KZNivuWP8vvEQ10qheQvK7vXihRF2Vn8Kfi/K6YJ0mMQUNELZ8fHjJFI=
X-Gm-Gg: AYBFou139jqCJ67mxEcfIOC/UliYgOZiCmcgVSwdQm7z9u+f8dZPU94jsJHxqxq9kyw
	Rh2p1LXCCf0XW961LDr/vQTnzvUrwUqCR6R+P/dfEyBwgrFl8Q6Qb/hlWp23RJUyBUq7Kgpwnkk
	0jT824Q10DD4UZaz/zSbgUSa10sEQqhzrcghazFk1fpqH/w08bH0dU2G/WG3Tuxv8MwToLZOmb+
	ECEnjTYuP5dH8WggKfnwqRcCsayyV9Ef63+68my0RC7utNRDh7n28KyDxxNGCMJYz/ytNjHVd8y
	ObVGpvdm0cGY08ZI75K/2aPYAlaQYv2T9fVXymVZXIoa/uMTbC/mWwWztPzx6sf3fK6zqKQfbED
	rRLh01xPTDAEaSJm8zCbb2HnpsOJ6wX5jkpHq5L7p1WpAjtEQiTRDtsVuw+eKWcN0Qkeq24MT7W
	4cSkbzMXPJHuAMRrACux0nwddGOEiQ35gyS9DwN1aSKo/gl5yHS7vyM+uiDhjFAA0fEFJjD77ag
	0+X5OuDuLY0MOKyQesecH3vyn62nLd4L411/UFP4fKQH7YcVFHxNnQ=
X-Received: by 2002:a05:620a:6499:b0:93b:d7a3:45e2 with SMTP id af79cd13be357-93bdc9fc0ecmr90045085a.75.1789688022815;
        Thu, 17 Sep 2026 16:33:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d147ffsm582554985a.43.2026.09.17.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:33:42 -0700 (PDT)
Date: Thu, 17 Sep 2026 19:33:39 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Create node access attributes for CFMWS-only
 NUMA nodes
Message-ID: <aqx4gd_VO_KhQ9bD@gourry-fedora-PF4VCD3F>
References: <20260916120338.369436-1-kanie@linux.alibaba.com>
 <aqrYws_qG92cdXHQ@gourry-fedora-PF4VCD3F>
 <20260917220432.44c703a1@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917220432.44c703a1@jic23-hlaptop>

On Thu, Sep 17, 2026 at 10:04:32PM +0100, Jonathan Cameron wrote:
> On Wed, 16 Sep 2026 13:59:48 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Wed, Sep 16, 2026 at 08:03:38PM +0800, Guixin Liu wrote:
> > > Tested on a QEMU CXL topology with a CFMWS window whose memory is not
> > > described by SRAT or HMAT  
> > 
> > Sigh.  This keeps coming up.  (Not your issue Guixin Liu)
> 
> I won't reply in depth again.  If a platform supports non trivial hotplug
> (i.e. more than one device spec) then the bios has to be clairvoyant
> to create those tables in a fashion that is useful. Generic Ports were
> added to put the missing piece in to solve the problem so there
> is no longer a need to pre bake. 
>

Well sure, but [SRAT, Generic Ports] - pick one.

But giving nothing is just a wart :|

> This is going to be more fun when we have more complex devices showing
> up and need to create a NUMA node per device (i.e. those nice compression
> devices of yours). At that point you aren't using SRAT memory proximity
> nodes anyway - unless they are all there at boot and you are spinning a PXM
> for each one.  How do you do if a mix of different sized (or at least
> sizes you didn't know at boot) devices get hotplugged later?

cough

https://lore.kernel.org/linux-mm/20260610014517.253609-1-gourry@gourry.net/
