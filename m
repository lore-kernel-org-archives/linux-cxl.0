Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F52E0904
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769129029; cv=none; b=QAFhq4N/NeCMvSXqbiBO0zkKrLFrZz72gxSuRopODEd5whOLhT8jPMuKBuitpJCtuRyTn0USRTwv6JqIgGAU/+SxkBafLjOCYRJfqj+thKRYIp7Bsse5SIPVFwn8g0qhzTMmzpNX2WoZfotMuxraxasNvcUDGLgj4tW4be5rfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769129029; c=relaxed/simple;
	bh=XGJ8do6DqiSNmZPIr9zz3bcxbAKjbH/slyEIBawIwRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYfhcYtTZw8OdobAz7O1qMeYrExYCLLLnkFgMqG1sTSybPYIZsthF/ibnxKd/7wny9/P5u7glPNPf8TfRDbPTmQV4T2KFQP0GksVS1hmxJgauUsT0Ci8QglQD+nOzl9OtK4sp25bFGSQiPZXqc1EO0hly8ft6KUF+mt5cAArC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hFjTiAmA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hFjTiAmA"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89473dca8aaso24514256d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 16:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769129021; x=1769733821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfDbc/em5bjOki5V5/p4q24wfcBoeK7m+V9bweSJP5A=;
        b=hFjTiAmAxYF12xnXQduZ5Rq8uiqpAkF/48v7Vrt/m4ZO7CoKwMFV0ojQfo0+2MzNwB
         gTFQ+6Zf6JI0N+1XHbW9T4hRvPQBZ7o94iPA05I8CgnAQbi610Ghc8bLmubbRsW2dF5e
         uHRwkT/ZOF9s+wtHyxfcFD5RTeXr2bMWGsBfvNm2zVZX3tpERTRj0mnDwWIq9tZV7xMC
         tEvUWVqVFaW7+j1QoDzOlQj+EEag8YktREfiXcrBU7Bj0/G5GyIiOmD+eEaMAI2A2TLM
         S+SyI0lNVN32xGE/orw4ulE89BhNW0Dl0sUoOtJEO6nCPUOFL1SViSlOlDlzMhYvlhSl
         KwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769129021; x=1769733821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfDbc/em5bjOki5V5/p4q24wfcBoeK7m+V9bweSJP5A=;
        b=ssJsXxNC6QnznCe9X7ERf7FZFEsgO33RiirmiHrNAOibuOtZr5+lu/2OSU+1uTtNzU
         SNPNOgZz1StKPmGdTzdy8x5BlYhx0cabzl2Xty3OE8KdOyXoKuOXOOPJQufqInbHLP5q
         JJAkzKEfiGqbU2+DH8qmjb2s51PmyVW34ZDJuNZYNSu1xRmrfP0bNfm0nET4DlQ5fTix
         KALEth/0ya3LCd3oUiJOpm2bdFWpxwEgqwV1FFFzPZFOc/Pa5m3iK7KdwY45JIbk2hgU
         i2UeIwR7j8AZ+1iECOZsR43vsaPoG0HM2R66Hap38XazPGBosAlOkh6IyB5JHzcmKfbX
         7WNg==
X-Forwarded-Encrypted: i=1; AJvYcCX7R0plYsHLj+G+NxJfroGStEwwZGVsD1fo7yYIWOb+cj8xKO4260Kx95Hrw1X3yEewNHKA4aObwlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbCnFAH4IaBPZsMnVeiPpik+SVY+W4bpX3Vc8AKziRF9u5d+k
	SIarhJWYo2M/6sHh2O6MlASTxEj45v51raOGPfW0X/Uc6t6uR0HlgpNcmrC9k/yWvDg=
X-Gm-Gg: AZuq6aIqSmeN4U8FWUXXjAm0CGvn6/D1a/gmqR7Du2s2J1lKrpGk8v66vwG2wsLUJ27
	ClnwZevTQSkWOF+KTdDf7GGaupOnAml3sTcTAisJ57qU8b1A71e4Q1tTfLOmotsy06LtelKZjrB
	kvUWDD4awILLC/rfgGxLwtTLB6Ov30ke/bvAxKDGEGCuM2RfqdKb4r0tucRa/AkOWUzZPlQtaFv
	xabEZKR3ohxx5k5hgH9/8FDwchVq6KEOhHdOt0psjK8YoUn9uEVRW7aUHKA8ElW7hqomhKQ2eMZ
	VD4uUzhcZ9PggKw4jkO+tbd2+Fp7dRLcd1OYYcLcD9wMH5eRctFlLDmeZb8vuMb+inoD+Ik8VLZ
	CsL0l8Hih6niE0bgn89aX8yG3T9KJ/7OwqjyRS6nAxck5CftO2RzspdsIasuSppEOJfs6jrsih1
	o1MJjk+rS1Pmx1soWZJuyxo//Y0bpWGT5odpoJvn0jMU1cF1K+wrKNy7vt7bC3k0eTRQ3DtA==
X-Received: by 2002:a05:6214:f2a:b0:88f:d4b1:4c2d with SMTP id 6a1803df08f44-894902209a0mr21597136d6.60.1769129020746;
        Thu, 22 Jan 2026 16:43:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491853478sm5521546d6.25.2026.01.22.16.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:43:40 -0800 (PST)
Date: Thu, 22 Jan 2026 19:43:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 7/8] dax/kmem: add sysfs interface for runtime hotplug
 state control
Message-ID: <aXLEOjgVyGYAU_zk@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-8-gourry@gourry.net>
 <3555385d-23de-492c-8192-a991f91d4343@kernel.org>
 <aWfcYjZVrROHfGyh@gourry-fedora-PF4VCD3F>
 <57c5f44f-3921-478b-843b-877fae536591@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c5f44f-3921-478b-843b-877fae536591@kernel.org>

On Thu, Jan 22, 2026 at 11:49:48PM +0100, David Hildenbrand (Red Hat) wrote:
> 
> I'm merely wondering why, in the new world, you would even want the offline
> state.
> 
> So what are the use cases for that?
> 

I don't have one, and in the 5-patch series I killed it.  You are right,
it makes no sense.

However:

> Why would user space possibly want that? [plugged-in offline blocks]
> 

I don't think anyone does.

This is baggage.

The CXL driver auto-creates dax_kmem w/ offline memory blocks

Changing this behavior breaks existing systems :[

> Can't ndctl just use the old (existing) interface if such an operation is
> requested, and the new one (you want to add) when we want to do something
> reasonable (actually use system ram? :) ).

I think we're in agreement, I think I'm doing a poor job of explaining
the interconnected issues.

summarizing the long email:

   cxl/region + dax/cxl.c + dax/bus.c auto-probe baggage for
   BIOS-configured regions prevents any userland policy from
   from being plumbed from cxl to dax.  There's no interposition step.

So yes - new interfaces would resolve this and the old interfaces
could be left for compat.

~Gregory
