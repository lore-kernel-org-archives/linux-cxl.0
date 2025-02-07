Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E351A0BDB
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738912844; cv=none; b=awsVtQfZCgi5DBLiHnSyvptEXsTkrqfQinLDXnQDHNBStXbrEYMFFuIqUMg9UCanRTF0bgXYozZvr5J3z02TQg+jGyVBbX1TIwb7RC6Y82RqUp0oC1RrGFwcFXfhnlax0Z04GQwsGd2iLZ5NG+RsIH/MlBsv/EPduArlH2CHso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738912844; c=relaxed/simple;
	bh=7WD0sLVMZpG91Qn1m572aAqQtGFtNqchoLBGQzxCQfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STz8mWiUKNJb9xPJFAMeMWCyMKkuw40L1vcBLo8jqSBZet15PlygkBe7OfkOBr92MVLUDUUmJw9rOlWe0oWgtDTE0xN87c46hgSm2lAlkXQP1JKhB3cOmm1IOE70LRIvsvoo6vK0oWM0D9Nn9nQCA96qJ3OdUZGpAWeKyOEZSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-5c-67a5b43e5722
Date: Fri, 7 Feb 2025 16:20:24 +0900
From: Byungchul Park <byungchul@sk.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <20250207072024.GA48419@system.software.com>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z54p4QOnAlTYm6DG@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsXC9ZZnoa7dlqXpBg/38VpM7DGwOD/rFIvF
	vTX/WS32vd7LbPH7xxw2B1aPnbPusntsXqHlsenTJHaPyTeWM3p83iQXwBrFZZOSmpNZllqk
	b5fAlXGmcxFjwUfxipvzVzM3MB4W6mLk5JAQMJHYsWc5excjB5jdvEUYJMwioCKxad0pNhCb
	TUBd4saNn8wgJSICGhJvthh1MXJxMAvsYJR4tfAHK0hcWCBN4u0PP5ByXgELie+nPzCB2EIC
	cRJ3etYwQsQFJU7OfMICYjMLaEnc+PeSCaSVWUBaYvk/DpAwJ9ABR1o+gpWICihLHNh2nAlk
	lYTAGjaJby2TWSAulpQ4uOIGywRGgVlIxs5CMnYWwtgFjMyrGIUy88pyEzNzTPQyKvMyK/SS
	83M3MQLDd1ntn+gdjJ8uBB9iFOBgVOLhTTiwJF2INbGsuDL3EKMEB7OSCO+UNUAh3pTEyqrU
	ovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjB2rfafvDK3WsSovllN2
	azZWFet/c2ch31SWiMe6TJycPsmTeOYy7eY/3WMm+6HsXqzGq3cB6+7Wn973it1BuXCjYru6
	/S55tl2P9NJ+sYe5re3YV6BSWfzY4fyUEzyOcvVXZDfu1Wz0Ndm0Y8+svfflnEz3is29JPtQ
	5YH3ohdnlwrKHi1apMRSnJFoqMVcVJwIAJCf2G1bAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsXC5WfdrGu7ZWm6we+n1hYTewwsPj97zWxx
	eO5JVovzs06xWNxb85/VYt/rvcwWv3/MYXNg99g56y67x+YVWh6bPk1i95h8Yzmjx7fbHh6L
	X3xg8vi8SS6APYrLJiU1J7MstUjfLoEr40znIsaCj+IVN+evZm5gPCzUxcjBISFgItG8RbiL
	kZODRUBFYtO6U2wgNpuAusSNGz+ZQUpEBDQk3mwx6mLk4mAW2MEo8WrhD1aQuLBAmsTbH34g
	5bwCFhLfT39gArGFBOIk7vSsYYSIC0qcnPmEBcRmFtCSuPHvJRNIK7OAtMTyfxwgYU6gA460
	fAQrERVQljiw7TjTBEbeWUi6ZyHpnoXQvYCReRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZg
	eC6r/TNxB+OXy+6HGAU4GJV4eBMOLEkXYk0sK67MPcQowcGsJMI7ZQ1QiDclsbIqtSg/vqg0
	J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgbFOK/7H7npfnZksN/ceS2B56Ghd
	PrHRRFHK8pKGV4eSSKNgge6118kP9JY/FTjL94+jfLFQ4qNJ68MWfatYI3VWesaZP1/qlrwz
	+eW0eFfNK6Hsnz/b25SOXpkWvY5Ne3a+SJCUlOS5aIe9Kzu/mTqlPTP8dqBphZr1yUcFhdy1
	PW8Z124XLFdiKc5INNRiLipOBAAmQDCFSwIAAA==
X-CFilter-Loop: Reflected

On Sat, Feb 01, 2025 at 02:04:17PM +0000, Matthew Wilcox wrote:
> On Sat, Feb 01, 2025 at 10:29:23PM +0900, Hyeonggon Yoo wrote:
> > The Linux kernel supports hot-plugging CXL memory via dax/kmem functionality.
> > The hot-plugged memory allows either unmovable kernel allocations
> > (ZONE_NORMAL), or restricts them to movable allocations (ZONE_MOVABLE)
> > depending on the hot-plug policy.
> 
> This all seems like a grand waste of time.  Don't do that.  Don't allow
> kernel allocations from CXL at all.  Don't build systems that have
> vast quantities of CXL memory (or if you do, expose it as really fast
> swap, not as memory).
> 
> All of the CXL topics I see this year are "It really hurts performance
> when ..." and my reaction is "Yes, I told you it would hurt and you did
> it anyway".  Just stop doing it.  CXL is this decade's Infiniband / ATM
> / (name your favourite misguided dead technology here).  You can't stop
> other people from doing foolish things, but you don't have to join in.
> And we don't have to take stupid patches.

Hyeonggon and I described the topic based on what we observed in CXL
memory environment, but fundamentally it doesn't have to be only CXL
memory issue but also heterogeneous memory or ZONE_NORMAL cost issue as
you and others mentioned.  Lemme clarify it.

<general mm issue>

   1. Allow kernel object to be movable:
      a. ZONE_NORMAL cost will be reduced. (less reclaim and oom)
      b. ZONE_NORMAL covers bigger whole memory.
      c. A smaller ZONE_NORMAL is sufficient.
      d. Need additional consideration about when(or what) to move.

   2. Never allow kernel object to be movable:
      a. ZONE_NORMAL cost keeps high. (premature reclaim and oom)
      b. ZONE_NORMAL covers smaller whole memory.
      c. A bigger ZONE_NORMAL is required.

<heterogeneous memory specific issue>

   3. Allow ZONE_NORMAL in non-DRAM:
      a. Mitigate ZONE_NORMAL cost. (less reclaim and oom)
      b. Followed by e.g. hot-unplug issue.
      c. Option 1: No restricting the ZONE_NORMAL size.
      d. Option 2: Restricting the size as budget to cover its capacity.
      e. Option 3: ?

   4. Never allow ZONE_NORMAL in non-DRAM:
      a. ZONE_NORMAL cost should be low enough to cover non-DRAM too.
      b. Any efforts to reduce ZONE_NORMAL cost should be welcome.
      c. Matthew's work would mitigate the cost.
      d. Allowing kernel object to be movable would work for it too.

Plus, I think Metthew's effort to reduce ZONE_NORMAL cost is amazing and
hope successfully make it.  However, ZONE_NORMAL cost can be reduced in
many ways and all the efforts can be considered meaningful.

We can work with from the easiest object e.g. page table, struct page,
and kernel stack, to harder ones, while struct page cost is getting
reduced by Matthew's work at the same time.

When it comes to this topic, the most important thing is the collected
*direction* from the community so that we can start the work under the
*direction*.

	Byungchul
