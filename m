Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A362270ECB
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901896; cv=none; b=OCUIiSvrGlPYEoU0ITrl9VJjFI9O06NI4xF5paNSpJWF065yxzqTu63oLyTfrl0uW79AzJ8uXNY8qp2fcVTFUIVWdNScGEMj8w3KMB5skI8+PnzenmxHJmKqG8MB0A1pnpFCnUMTu0RNgUK0mW0rCDMB2iDDcA6m1a/kzSJfdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901896; c=relaxed/simple;
	bh=89YH2L66JdBDvc/z1zr776bVYkPkPpM/OI3XRKn7/0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXbRxkHMeKUCDEQ+ZTffR5/ss4gCFN8FTzMjc7UXqdfFYaNmaOACYoL07x4SBGuI0C5tIa7Il25lTldhfXWorQNISAKrtRnRzPvvQ/6jZJbmaAKMY6edTSRQUAtLsaqQjaQHxlno26rkvVX6xB1n1EmSrPTffgrTYScu2npbpM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K0a6GdIy; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K0a6GdIy"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0a26b1c67so220889185a.3
        for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 10:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739901893; x=1740506693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/2QkXBrR+RLY2Ff/8MHFN38wGfIHYvjpwObZxuk5dJA=;
        b=K0a6GdIyb3ewk6pQ6b1xuyURq3XEdUo5m64DbGAV0y45eDuLj/MDS2BZr/oRNzUGYI
         aNTlQkGSqRtSIlnkQFJE2sgfpbqzP2GwBh8A6pqGXjAc4QRpDJvDEQGE91YVI+5NYS3H
         AJLRbV2a0dJ8goyv+69bJjzEUwC50EJZW7IxZcghhIOOpyQExcKymOWqTukXu7HoYNkh
         9h0hMGg0YMrW1u4OsLEbKDlC3vj1eokY3Hu2IeS1cD1sUphPpsd5ASwniV7mh7h1EyQh
         nCO/ihxAZDkhvkA72NNbr9nWP9u+hp5mAO6SFW1JAtCjamDrF0p6CQx/KoiWjvSfyBpG
         kyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739901893; x=1740506693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2QkXBrR+RLY2Ff/8MHFN38wGfIHYvjpwObZxuk5dJA=;
        b=C7DY1BCQz4XYLiIVJhx6kdSnmnre9nN6DXPruWZHGJp1x1Xl7A76aav60uHK7FpD9y
         h8vuYDJ7k09WSQBgmSgyTcqK0g2m7ew++/CmLgFeT5rd6pCnY6YQF3fikcZnNOUdY4v2
         Lj35h6h1X8yMiYhZf24tVh8bEazdDzmkkfwyWvqgtsyCtQV0K4qvXjo5Z1J5wY9ZUnNC
         ZgPiqkVBblrqmpC91ybrwEEseMxsTfDKIwRBw7ldM0WnQywXwY0edhzWxj7+h+IaPbXE
         vTlX8J/P9ObMO0reboWz4iKoO21Ick10Sdllpu12lF/KXp/Ueog092YsFgAEfMrhH2hm
         Vu3g==
X-Forwarded-Encrypted: i=1; AJvYcCXRaATrZFGwDJHeeUG0JhuAHD3Ay96RyTQUW/dP37M6DvFoglXr2+PJni0toYgihKlw4c7QhVn6Jx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gObPMG2Kw1ujTX8X5LsBC8/wkRuPZrfIOI+azJnkubjIRJh5
	0u3Clxu9m53PHZ7WUMXVgkHN7XJuyPlqSAiPUXg7lxa0Gs0Pmmy94zfpg2lKrXg=
X-Gm-Gg: ASbGncvESw6ozcE6xZ9z8KwG6oa7Llyn58qGmwSxMEj0CvsGFq3e7XYLgm9LKuB1J1b
	DBcF2ZhBF1rXKpEMd/0lWVfmeJtlPmU+O5spXdbfKYkNR5/9Ktnb7Q45k00IzQ8hi0d/WCoq3jr
	BdcK+LdVbJJIoGZ7WwC7p4VX32mmEIjOM473zHpSUTQLNbgnBtYLs1O0wkRWihkq6nh64Ll/Zey
	ji6cGdWe/VEBAijPB6d3sWPVzsgT1CHkV/molKo7xp6ofRpYh9Bt6SpBiugTC1T27XmeEmEGJk3
	csiFZoXLhmSlLbDcGx1Oj9fK4y4wh5BuHMXL4jUiWy9YbrWRni8K6CSUEwIIyAAfSuJJ5Joysg=
	=
X-Google-Smtp-Source: AGHT+IEprOBQSn3Ytg4X7qFQ2WbvhHazV+Lw3tNlJvmsytmgmsjBdXJWK9TXucgmcuhpw5lyap3g8A==
X-Received: by 2002:a05:620a:2b4a:b0:7c0:ae2e:62ff with SMTP id af79cd13be357-7c0ae2e6516mr464537585a.22.1739901893011;
        Tue, 18 Feb 2025 10:04:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a852b95fsm162892085a.116.2025.02.18.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:04:52 -0800 (PST)
Date: Tue, 18 Feb 2025 13:04:50 -0500
From: Gregory Price <gourry@gourry.net>
To: Yang Shi <shy828301@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>

On Tue, Feb 18, 2025 at 09:49:28AM -0800, Yang Shi wrote:
> On Mon, Feb 17, 2025 at 12:05 PM Gregory Price <gourry@gourry.net> wrote:
> > The node ID passed in as an argument is a "preferred node", which means
> > is insufficient space on that node exists to service the GFP_KERNEL
> > allocation, it will fall back to another node.
> >
> > If all hot-plugged memory is added to ZONE_MOVABLE, two things occur:
> >
> >   1) A portion of the memory block is carved out for to allocate memmap
> >      data (reducing usable size by 64b*nr_pages)
> >
> >   2) The memory is allocated on ZONE_NORMAL on another node..
> 
> Nice write-up, thanks for putting everything together. A follow up
> question on this. Do you mean the memmap memory will show up as a new
> node with ZONE_NORMAL only besides other hot-plugged memory blocks? So
> we will actually see two nodes are hot-plugged?
> 

No, it creates 1 ZONE_MOVABLE memory block of size

                   (BLOCK_SIZE - memmap_size)

and as far as i can tell the actual memory map allocations still
occur on ZONE_NORMAL (i.e. not CXL).

So you just lose the capacity, it's just stranded and unused.

> Thanks,
> Yang
> 
