Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B12E888C
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770265424; cv=none; b=Qxd7rFC/CUXNTxZKosLCiylltJBovHTXJdWdX9AThvRclulNIY49pgff4TP4GxA4NfV/QO/dAGrQ9Z/GlcSuBvbX73HE4KKUbDXd/SdgxMX+DhIBmV17GtZ/9Ixe60D8W33aGUzsQxRpY/yUa/kcZq4SzmSMr2bVSHUcxv/JIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770265424; c=relaxed/simple;
	bh=L03384jtDexDfzkRHHtzPIVJ4BKFBQWzJGNmJuCR4wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/DQ87ZEdqGY/2/bderNZBzf6JT2n9IcEmHTd2DjUUYiNML33VOn5N0ARbs67Si9xZx2cFGqV70OpLpAQNMFBFYbdzPqFpXLECYyLoPDfIU1JMRx/6aKZW0CZMUvBH9LaTaSMWqb80WalJtrPpMHd5oxN9Q7bSxbwowbHrwp+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MLDTEQO6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MLDTEQO6"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c532d8be8cso40796185a.2
        for <linux-cxl@vger.kernel.org>; Wed, 04 Feb 2026 20:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770265423; x=1770870223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qW0+moZctApASOdwQkaNncsGOVFnNExxcEZS6yJkS4M=;
        b=MLDTEQO6exn21nK7WldrR1aIYxSKV0SetMJnEH6Pq9GFGudIeAuYOU2mKG4qNXd77p
         njiQp3vvn/XwQGj8U/pVscEkN7VUqTj/4rs6WF2nJh7NVgxPJOUGQ65Wpllt+WITmwjp
         L4Kd/7cFByLsMZuqVWlCALtotsWYWhVqrhtPsk97ZKxM60Fx+PuD440tbELBKDsFEN72
         fujBWqAsGz2bl14GxXX0stTlfIAFczr+vIq6muJQpN0ZtMa3P4RF2TiteF1IFNrsYK9q
         YTEQxJGJSJPn+21BExh4UjvWTHw4NwtQp5EX21CrP/UolEeBumKNm9SaUOFpUdNo3amE
         aUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770265423; x=1770870223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qW0+moZctApASOdwQkaNncsGOVFnNExxcEZS6yJkS4M=;
        b=Krn+tVeB4Zr8tWJKgFCkR6Dnp6YN6LzTVIRA4riE1kr1OesVwOqb1zg5iAwRu9Wf4M
         nq8x8B6vI+gu8s5MDAKBlO3V9K1Se3PtMDZYlVdI7eugmzEGEbaNqAc2d7/3ClftJgqY
         nvNugHfFllS7UnIdPy9AMliF6WAulqeQY898ttw+vtZlf5ZtaAVqFvstYXoU9P2MAC1C
         nSPoXIbtR5hkvx4tqRaawTSWilHx4YxwsFKNW18LuogmceavdRgn9+HE9xjfSolxwKJr
         epBOneQrLNlp0TqexK4vy4+nFaK3dQo+rsU1Dylln2csJ1RiwytFvUmWxZuIHnVnDSmW
         kwyA==
X-Forwarded-Encrypted: i=1; AJvYcCVN0VR3k7jWssqMbHngSHAzBJiSCbds8+RBcP7MXVDKslQMJxR7gQQdM1CPLvea5HH1TCk9vj0jBAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycsUacUMP8qkTQzwD8tvVjd76OIB/iLfhbU8Sl2J2eRnjNewmZ
	GXPyXrhFFQ825CY2CnZQMSfa1pZZZFfJDhljQvAvmdtGUM9S/lfGMqu1WC+OUO9jHRk=
X-Gm-Gg: AZuq6aKrOjZANfT6H1PrxJseEBoOZg3+Q4OlbRue+qnQ7R6GEXmqnzJEnEpJ5cwLf76
	U/7V8bfWmcc8dBDYcWk3TY6aLcECeDdBQqfpAW0s6MkUDmRA7+fn9zpcFf2bMRKvlENt+n2Nwwl
	cQuLQ+j4URDEzORsiWDge9e5l207drMYMlrm78gXZFES+xwOhySJakUNNfSR1pKhVJckiZ0SxtZ
	E59V961sdTStMaYeUyS6zKUGLCJmx9e6+bh3F5t+HaUlVrZ+sfTJLbusHsS9rYquSjz0aaBgTcf
	nG0ooQYTrXsibEdTWw1tJ6C3A0LtZxtoYqa+/a9f8T/INV6WplSXjlp+KqS6Ukx188LzBH34Y/l
	r8MU90Zg0msEIo8VzL70SgLZao5CnQqBldNHRqfSfApvHPGIroZIC0QxU0Tt0NbjYnaMP7hgziW
	KzoZ9P1HsHMLHazPbhHJbRSg91Yz7apGbrHfUWvAnVH+QY80PRmSP0X2ahy153NoNxRvChgA==
X-Received: by 2002:a05:620a:c4d:b0:8c6:f74f:9b69 with SMTP id af79cd13be357-8ca2fa5e50cmr701545185a.83.1770265422854;
        Wed, 04 Feb 2026 20:23:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521cf8619sm34240906d6.32.2026.02.04.20.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 20:23:42 -0800 (PST)
Date: Wed, 4 Feb 2026 23:23:40 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	terry.bowman@amd.com, john@jagalactic.com,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/9] mm/memory_hotplug: add __add_memory_driver_managed()
 with online_type arg
Message-ID: <aYQbTFLTRHiAnrKr@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-3-gourry@gourry.net>
 <20260202172524.00000c6d@huawei.com>
 <aYDmor_ruasxaZ-7@gourry-fedora-PF4VCD3F>
 <20260202184609.00004a02@huawei.com>
 <aYEZAUJMLWvaug50@gourry-fedora-PF4VCD3F>
 <3424eba7-523b-4351-abd0-3a888a3e5e61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3424eba7-523b-4351-abd0-3a888a3e5e61@kernel.org>

On Wed, Feb 04, 2026 at 10:08:45PM +0100, David Hildenbrand (arm) wrote:
> > 
> > David do you have thoughts here?
> 
> I guess we should clean that all up where easily possible, but I don't
> expect you to do that.
> 
> For online_types I used it, obviously, to save memory. So I'd expect it to
> stay at least there, but cast it to the proper type once we take it out the
> array.
> 

I can do it pretty easily and pull it out ahead.

~Gregory
