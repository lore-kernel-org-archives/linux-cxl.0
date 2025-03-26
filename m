Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C178F5F;
	Wed, 26 Mar 2025 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981317; cv=none; b=G0yPYGIxebSNoH+t5+oQgNCwC4TBtqC37C5PlPV/AWGn5Zxtovwn9aFu+5qjO1lRBm5PBfpqKKSkxjLdKKMWNxmHoLjFyb47Mmj5HJX9NId+UzWfZxwGPWfBa5N2xacdk/GiPs9eadhIOBKsqHHdZ+hV55yU5lfaJqcwaSnegSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981317; c=relaxed/simple;
	bh=SUkcoFwWTICKJuPVyI8TCpr6LB9AnVADDCDXBV4u26s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbzl9kwAUiqwAYZwj0fQuQ09yDdWr1ivTpZPkQeRxlaLlTDoGdCmWIKGfD3Sdy93nWtrndzLdPWlZLnPWTceAt5/LHdIn9f0etn7XeHQNIhAKoBQ9nMzO17CTdn5vp6D+iN5uOHFPLpv+tb5GwSIQjiDP73B0ML4tmn6U0x3tPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3mL2yyONnaYcEDg--.34050S2;
	Wed, 26 Mar 2025 17:28:18 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwA3PYmvyONnhX1VAA--.4059S2;
	Wed, 26 Mar 2025 17:28:17 +0800 (CST)
Date: Wed, 26 Mar 2025 17:28:00 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 4: Interleave
Message-ID: <Z+PIoAGgz33R2c3P@phytium.com.cn>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
X-CM-TRANSID:AQAAfwA3PYmvyONnhX1VAA--.4059S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWfjC7gD6QAAsc
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cw47Wr17WF1rCF4kAF45GFg_yoW8KFWxpr
	43tryfKr4rJrWxJr17J3WUXry5Xry8AF45GF9Fgr4xuF1rAr18Xr18Gr18Zry8Ary8XF1j
	qa1UJ340qryUCaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Tue, Mar 11, 2025 at 08:09:02PM -0400, Gregory Price wrote:
> -----------------------
> Combination Interleave.
> -----------------------
> Lets consider now a system where 2 Host Bridges have 2 CXL devices each,
> and we want to interleave the entire set.  This requires us to make use
> of both inter and intra host bridge interleave.
> 
> First, we can interleave this with the a single CEDT entry, the same as
> the first inter-host-bridge CEDT (now assuming 1GB per device).
> 
> ```
>            Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000300000000   <- Memory Region
>              Window size : 0000000100000000   <- 4GB
> Interleave Members (2^n) : 01                 <- 2-way interleave
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006               <- Bit(2) - Volatile
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge _UID
>              Next Target : 00000006           <- Host Bridge _UID
> ```
> 
> This gives us a NUMA structure as follows:
> ```
> NUMA Structure:
> 
>          ----------     --------    |   ----------
>          |  cpu0  |-----| DRAM |----|---| Node 0 |
>          ----------     --------    |   ----------
>         /         \                 |
>     -------     -------             |   ----------
>     | HB0 |-----| HB1 |-------------|---| Node 1 |
>     -------     -------             |   ----------
>       / \         / \               |
>   CXL0   CXL1  CXL2  CXL3           |
> ```
> 
> And the respective decoder programming looks as follows
> ```
> Decoders:
>                              CXL  Root
>                                  |
>                              decoder0.0
>                             IW:2   IG:256
>                       [0x300000000, 0x3FFFFFFFF]
>                              /         \
>                 Host Bridge 7           Host Bridge 6
>                 /                                    \
>            decoder1.0                             decoder2.0
>           IW:2   IG:512                          IW:2   IG:512
>   [0x300000000, 0x3FFFFFFFFF]             [0x300000000, 0x3FFFFFFFF]
>             /    \                                  /    \
>    endpoint0      endpoint1                endpoint2      endpoint3
>       |               |                       |               |
>   decoder3.0      decoder4.0              decoder5.0      decoder6.0
>           IW:4  IG:256                            IW:4  IG:256
>   [0x300000000, 0x3FFFFFFFF]              [0x300000000, 0x3FFFFFFFF]
> ```
> 
> Notice at both the root and the host bridge, the Interleave Ways is 2.
> There are two targets at each level.  The host bridge has a granularity
> of 512 to capture its parent's ways and granularity (`2*256`).
> 
> Each decoder is programmed with the total number of targets (4) and the
> overall granularity (256B).
>

Sorry, I tried to set this topology on Qemu Virt and used:
"cxl create-region -d decoder0.0 -t ram -m mem0,mem1,mem2,mem3"

but it failed with:
"cxl region: validate_ways: Interleave ways 2 is less than number of memdevs specified: 4"

It seems like the CFMWs IW should be 4?

Yuquan

