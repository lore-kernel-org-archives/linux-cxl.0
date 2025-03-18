Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4EF210F5A
	for <linux-cxl@vger.kernel.org>; Tue, 18 Mar 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317807; cv=none; b=m6Uw5Nd+axtRkHecMnpDCI66/IRXMbzpU/S5a+zBc59/nA1wNqQVrPNhj6ExbbNQhJ1RZYwMcczCJXuT+/7sK2XaHFJ3N19zHrUSIlCR/x1vC4hvmk6SPdKr3FEaKqxSKkDkBkwoLN4T6y4ZVq4OuKp6uWB+HbBCl/jPDgUm/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317807; c=relaxed/simple;
	bh=N0zGmGCDO+CYY/XH/Tk/8edyEkzgiw7X4BHO55vHXT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2djV6dKpxIb8An7gE94iWfJ5a/VrJbFfpcraTen6OZZpteR10pMqSYY+XlPi424xaSfZ0DPWLhAVDrANvILndQcU4f6m3Dq5D9LxonWgwsBZ/w8OfirLHJFiolYRA8hkKWLIGEwct0LsnxYwBYXVWLUPJ0y+S5Qdt2upk5ICgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dHXWNiM5; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dHXWNiM5"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f916e75fso76527616d6.1
        for <linux-cxl@vger.kernel.org>; Tue, 18 Mar 2025 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742317801; x=1742922601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAoBcA4JtXxpzIjbx779EoaKbfBPS1llR5iDCjOnQKA=;
        b=dHXWNiM5rdwm4hHJY/WBAJJTukHK4yz/RRSoCxldsoMziCqeRo5y6SktpxC8ZFM4aK
         HmUmPhwKFCQy6KkV+MijFyBvLzsFWc01/aCHNq5jwJ2rwgqiiJ9gGrX1b25ZaRa5UULf
         sUj66kh+N+jNL2rhgY5X48jA0SezB1NWJzqIH+q42ec2q8I5dMT/zEstTnPjBRCuK5l8
         Qmd4/h+KOhfRMYw9JiSxv8y/yoU7CmaLFlF7/lci/F2UbedcydRkV+VmNFfp55DCsXV9
         mdGwb6sFY8BdmPX80gWidcxvLBVQJa2MUDNsfOcdHHwDmXwn0B12XM/Y6MmQqn/lN85T
         2EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317801; x=1742922601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAoBcA4JtXxpzIjbx779EoaKbfBPS1llR5iDCjOnQKA=;
        b=rF0xrYVYZWvA4NKS9yDmKSJDLjv3tQQ40jZA6VDz6DZ2iSVqgNKsJluQz29KmpaLBs
         zzS5/JxKgnlaqQrqSaz3vqp1GdVbOg4Hi3kL1T5DPZQJ8AkaDsL3ihUVBNy9sj1G5WAb
         oFL7fm2D1GHtkTHUhVuQy67oOVul8JD2IUzqSRR1G6vi56txOXHRHRboytRZS2tBRngb
         XO5LbRMlr+mBf5er/sF4/9TvbwaFt0hv3PQTmiRSkTuIFPvvKdPDOoZghZHjkXg4dOD4
         IuGUvuhKPV8pREZbnf7LsjknYItYqLqqWSrR0mg8Mvu9kozl8mExrY5g2Tk6b1C+NYDR
         iD6w==
X-Forwarded-Encrypted: i=1; AJvYcCUj9OAhuUOjaArPTLk5pjBez16+TWkj0IskCdwzO1Jo6W2xoDaeHipXoF5d0pmZNO4A/cEdscpkyy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsJwffcpyrcU9cpd76GpQytptxxTj2VpbE6RWzJCdH3yHaCaZ
	C9nwOk66GH6zaGze9SfQOJqKlE84bRXvrMV4KUeiBTgsSdr6Y5QBFpvJ09kZ0an2ttgKxdXn4pc
	P
X-Gm-Gg: ASbGncurjm6WEFAGVJ1qoS2SHZoxUADgqo97pKbqXDEFI9BjjNlkLZTIB++onrC7S1z
	U/RMWXxEm8/ovi0NZtID3RqCnMupicNOiKEp7IBec8ep5AgEnoFK6lpInpHaNUanka4NKC4Tuwn
	NAypriXqQ/YfOXoRRNoNLlNeoy0oJN3u9H7j5N/3kl3siRdFxtE8DqN/mVZbqSicH53b4muV7YU
	4SPFUX8vBlqq/qL4m3d42a/gQ685GJrI/IZbCSbAGTPc5gtUt4u4k9p5kRQS0ep64Y7a8WSk+PK
	N1j8zAJVnwP6Ik6104eMI0e4vENlCZv0CJgYtuBDKZdUlPnc7OSrOW92K/R9Jp/7RT8Zk73ywmv
	j6NDZB49jA4QSTH+iAfXdUz4dS9I=
X-Google-Smtp-Source: AGHT+IGDKMLKrW98rtnIQnYwYyplJuQKNFT9i7Ymkc7/amGmSQWmmu9JY7piNnTLzFpuWgwVF1lrSQ==
X-Received: by 2002:a05:6214:2d49:b0:6e6:5a25:e118 with SMTP id 6a1803df08f44-6eb1bbc7675mr60892246d6.6.1742317800825;
        Tue, 18 Mar 2025 10:10:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade231bb5sm69811136d6.34.2025.03.18.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 10:10:00 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:09:58 -0400
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: [LSFMM] Updated: Linux Management of Volatile CXL Memory Devices
Message-ID: <Z9mo5qCpdlE-KZ7P@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>


Updating the summary to this because the old one no longer describes the
goal of the session well enough.

---

I'd like to propose a discussion of how CXL volatile memory device
configuration is creating a complex memory initialization/allocation
process.  This is making it difficult for users to get "what they want".

Example issues for discussion:
- Linux-arch defined memory block size and alignment requirements
- CXL as ZONE_NORMAL vs ZONE_MOVABLE impacts on memmap and performance
- NUMA node and memory tier allocations, and new evolutions
  a) multiple NUMA-nodes per device
  b) confusing state of memory-tier component
- cma and 1GB hugepage allocation from ZONE_MOVABLE on CXL

Most of this complexity is being generated by how BIOS, ACPI, build, and
boot config options interactions with each other. The best documented
description of these interactions is: "Complicated, Subtle, and Scary".

Having better documentation on "Linux Expectations for CXL Platforms"
will help guide innovations in this space - but requires some agreement
on limitations to keep existing components functional. This is becoming
increasingly important as more CXL hardware is placed into production.

The live session will not cover the full initialization process, which
I've attempted to describe and discuss in [1][2][3][4][5][6][7][8].

The intent is to evolve this series into more explicit documentation for
platform developers and help bridge the gap between maintainers that
need background on "Why the heck does CXL need this?".

[1] Section 0: ACPI Tables
https://lore.kernel.org/linux-mm/Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F/

[2] Section 0a: CFMWS and NUMA Flexibility
https://lore.kernel.org/linux-mm/Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F/

[3] Section 1: BIOS, EFI, and Early Boot
https://lore.kernel.org/linux-mm/Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F/

[4] Section 2: The Drivers
https://lore.kernel.org/linux-mm/Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F/

[5] Section 2a: CXL Decoder Programming
https://lore.kernel.org/linux-mm/Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F/

[6] Section 3: Memory (block) Hotplug
https://lore.kernel.org/linux-mm/Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F/

[7] Section 4: Interleave
https://lore.kernel.org/linux-mm/Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F/

[8] Section 5: Page Allocation
https://lore.kernel.org/linux-mm/Z9Ogp9fCEPoORfnh@gourry-fedora-PF4VCD3F/


~Gregory
