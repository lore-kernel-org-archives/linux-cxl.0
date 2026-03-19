Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B913DE437
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933289; cv=none; b=CZhWk8Y4brtU9jT9vX+8WwIQ7uWvt565DTkm6jAiU6cOjX2Kt2nYL3q0tHQj9smHZKMd1b0iBhBERF/H2f4ZSbfxdQAy8ddWfV/9izDDPIjFcM1BT+WgRRrpiAsx4c14jSXjTE6ffqoZbB1kPQIGjrP/fNp5cc6Wun+NCWzvECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933289; c=relaxed/simple;
	bh=rjFu1wOiIML2IZkKILM/Osetc+lSAXjUE1UzECrdXCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSbea61EqmhXNy/HZSlIxtW+rXy6+nPD/SpeLZAk61bwCg7T4jPoG+NgJDyydbadiFnDEBASpZ3Cko+yeo0uf72yEptciknvHXJwF8Nkf+gs2AsGaaWHHUWOI1hC/dQCNoBwHgMTi31YGNGKZ3mLqZmLYf0MpED01fo2wyLYXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sHIwABnH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sHIwABnH"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ca01dc7d40so121209885a.1
        for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773933287; x=1774538087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JiHy8DTJcynkCaiPLcFmDFB3/915cgrSB5THuPXRODg=;
        b=sHIwABnHfZ/TCvGHV/Q4WNDa4NLmnlb0vX05FMzdB8Iww8//cu6x48MGaLNtnDwCG6
         Ud/HByHbEP6hr7Fi2GRhXZbyZ4DKcOzuugqHzEvPa9bDiwPoUGxq19mj+jve9yNWZC4S
         dZNF12QUZdSj4gXlZgSBK0XdihtfknrETUIbydzmRYRopGXhcEt7i4FbCTFLcStYv6SG
         w709R6+8JnuIZCSwoRVh246ROBsU6GWRPpI8graDViU7PK6eJw8BeGh0rplqbV+ISnvF
         +FPBrbMtqdBl8B839J43cPKQCTjVgjgGDieqpQp0qs2ZbxzHSZFLsF72yoxQYd2XzqjW
         fAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933287; x=1774538087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiHy8DTJcynkCaiPLcFmDFB3/915cgrSB5THuPXRODg=;
        b=MhWz3VBJiV0qP9W58vOnVk+pngaGIwKnMVBXGz8pvHRcI4tlqeD3Y2NqvQGP7x0oKM
         LghfvPlL8FNMiqSWsVsfay+YB0EmUZK6alof02khtX2kKlN7qV/jmFyREd+uAYt8QfYM
         w9+4vOK++ZtUsPqg1/EqZFFPrjYzhraoEeQ1lpuqt1sHW9GjawEBlqVG2NL0rm/lNqJ0
         5FbSs5UL/gNgoSSb1M1NzkwQAAT1CilCpYojHqs7Gs9BmFG2QKXfC3EGruxMbXY8DeJU
         oHBqT1BD5IfEd+DUf7cu/dMb/21Mkud6HS6DPYl7lU7x/7GXCkNjy6iMi2fX531I6IML
         vXWA==
X-Gm-Message-State: AOJu0YzfxCkSnB+HEdYdbzvHG5hTQ+O5aC0rXHCB9Laeabv+vXQmDHTt
	+xTZ5J8rMNiEa1T8Ln8dLBVl7TS3jT6Y4czJgEv0zEhu0eWu9tsdLA0p99OQylmLeus=
X-Gm-Gg: ATEYQzxiFf9KjYERPEpSpAtw7Pezumi436tUel5MreuzJkxTx+Xrx0e4b7souWVaEcp
	pH8tcnvIZ3W/npYfg+QNXLus54/Y9VgNZSPWDJ984tD7nSVXcPigAd1xP/22FPWFM4SG2kDFH5p
	yJSvOJfO5h9G/Gk2iVytdA9JSppvX/dWa9uJhfRCwbr07cmpG9iIVwRA6H9JoA5TDy1zf8Bmehf
	8GjOUXOzYNQiIBnmi4UUYBuwla50FumnRRrFIhxNJfM8o5uROC6PnM+p0JtvI+aO+B2F1sRGmLM
	LQ0Lg/rMt452uG5dF81fT2FEkTRU4N5LXV9v8pnbwymAm62o3ZihYCXyh2n+XmGBXiyMuJWhlRR
	P8dCdY0WeUvpSp1lF3uLg4ZnLxI6eW8/GWXsV5WciLUrO2+69/TgPEA9JH0dCsL7Da70BAEygKm
	JPgWpFKaMhw2IIIKiqC8L/e519dvvXPGMMk64ImqzpmvdGPvrju06JtNH7uwuUq5T07NaQBQyns
	MZtPOLX/g==
X-Received: by 2002:a05:620a:4490:b0:8cd:af2f:3776 with SMTP id af79cd13be357-8cfad1fe1d5mr1007969585a.13.1773933286774;
        Thu, 19 Mar 2026 08:14:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc2cd6ba7sm90953785a.46.2026.03.19.08.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:14:46 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:14:44 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
	David Rientjes <rientjes@google.com>
Subject: Re: cxl/region.c improvements and DAX/Hotplug plumbing
Message-ID: <abwS5BK0erHVkKKH@gourry-fedora-PF4VCD3F>
References: <aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F>
 <4d66eac3-1a2b-4d9d-8a9a-529a19758439@kernel.org>
 <aXLAtVZ_bVwF9nBG@gourry-fedora-PF4VCD3F>
 <217b154d-e4d1-4824-b2e3-fea82bc44402@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <217b154d-e4d1-4824-b2e3-fea82bc44402@kernel.org>

On Wed, Mar 18, 2026 at 09:53:05AM +0100, David Hildenbrand (Arm) wrote:
> > and would change the sysfs pattern to
> > 	echo regionN > cxl/decoder0.0/create_ram_region
> > 	echo regionN > cxl/drivers/sysram_region/bind
> > 	echo online_movable > cxl/devices/dax_regionN/hotplug
> >         echo dax_regionN > cxl/drivers/dax_region/bind
> > 
> > and gives the user a chance to configure a policy before the region
> > is pumped all the way through to the endpoint dax driver.
> 
> Would that still be backwards-compatible?
> 

I've since squared this away with the CXL groups, the answer is a
different probe path and leaving the auto-probe logic alone.

I still need to re-submit the /hotplug extensions here as an improvement
because its useful - but i've cleaned it up considerably to avoid the
cross-subsystem nonsense.

> > 
> > For most use-cases yes.  For something like FAMFS (distributed shared
> > memory), one system onlining a block as kmem could be potentially
> > destructive to an entirely separate physical server.
> 
> Right. But shouldn't we fail this already at the add_memory() stage?
> Sounds like during onlining is a bit too late. Conceptually, the hotplug
> as sysram was already wrong for famfs, or am I wrong?
>

Mostly this describes the baggage associated with auto-hotplug path for
all CXL memory, and the fact that we only have a global-scope auto MHP
tag.  I've come around to better solutions to this problem.

Thanks for the read n_n

~Gregory
